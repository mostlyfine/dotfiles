---
description: 'Terraform Conventions and Guidelines'
applyTo: '**/*.tf'
---

# Terraform コーディング規約 - AI 指示書

本ドキュメントは、AI が Terraform コードを生成・レビューする際に従うべきスタイルガイドおよびベストプラクティスを定義します。

## 目次

1. [基本原則](#基本原則)
2. [コードフォーマット](#コードフォーマット)
3. [命名規則](#命名規則)
4. [ファイル構成](#ファイル構成)
5. [モジュールの使用](#モジュールの使用)
6. [変数と出力](#変数と出力)
7. [コメントとドキュメント](#コメントとドキュメント)
8. [セキュリティとベストプラクティス](#セキュリティとベストプラクティス)

---

## 基本原則

### Clean Code の遵守
- **DRY (Don't Repeat Yourself)**: 重複を避け、モジュール化を推進する
- **KISS (Keep It Simple, Stupid)**: シンプルで理解しやすいコードを書く
- **YAGNI (You Aren't Gonna Need It)**: 必要になるまで機能を追加しない

### Terraform の基本哲学
- インフラをコードとして宣言的に定義する
- 再利用可能で保守性の高いコードを作成する
- 状態管理とリソース依存関係を適切に扱う

---

## コードフォーマット

### インデントとスペース
```hcl
# 正しい例: 2スペースインデント
resource "aws_instance" "example" {
  ami           = "ami-0c55b159cbfafe1f0"
  instance_type = "t2.micro"

  tags = {
    Name = "example-instance"
  }
}
```

### ブロックの整列
- 引数は `=` で整列させる
- `terraform fmt` コマンドを使用して自動フォーマットを適用する

```hcl
# 推奨: 等号を整列
resource "aws_security_group" "example" {
  name        = "example-sg"
  description = "Example security group"
  vpc_id      = aws_vpc.main.id
}
```

### 空行の使用
- トップレベルのブロック間には空行を1行入れる
- ブロック内の論理的なグループ分けには空行を使用する

```hcl
resource "aws_vpc" "main" {
  cidr_block = "10.0.0.0/16"
}

resource "aws_subnet" "public" {
  vpc_id     = aws_vpc.main.id
  cidr_block = "10.0.1.0/24"
}
```

### クォートの使用
- 文字列リテラルには二重引用符 `"` を使用
- 式や参照にはクォート不要

```hcl
# 正しい
name = "my-resource"
vpc_id = aws_vpc.main.id

# 誤り
vpc_id = "aws_vpc.main.id"  # 参照なのでクォート不要
```

---

## 命名規則

> 参考: [Terraform Best Practices - 命名規則](https://www.terraform-best-practices.com/ja/naming)

### 一般的な規則

1. **アンダースコアを使用**: すべての場所で `-`（ダッシュ）の代わりに `_`（アンダースコア）を使用する
2. **小文字とアルファベット**: UTF-8がサポートされていても、小文字とアルファベットの使用を推奨
3. **単数名詞を使用**: リソース名には常に単数名詞を使用する

### リソースとデータソースの命名

#### リソースタイプの繰り返しを避ける

```hcl
# ✅ 推奨
resource "aws_route_table" "public" {}
resource "aws_security_group" "web" {}

# ❌ 非推奨: リソースタイプを繰り返している
resource "aws_route_table" "public_route_table" {}
resource "aws_route_table" "public_aws_route_table" {}
```

#### `this` という名前の使用

リソースモジュールがこのタイプのリソースを1つだけ作成する場合、または説明的な名前が適切でない場合は `this` を使用する

```hcl
# ✅ VPC モジュールの例
resource "aws_nat_gateway" "this" {
  # NAT Gateway は1つだけなので "this" を使用
}

resource "aws_route_table" "private" {
  # ルートテーブルは複数あるため、より説明的な名前を使用
}

resource "aws_route_table" "public" {}
resource "aws_route_table" "database" {}
```

#### ハイフンの使用場所

Terraform のリソース名には `_`（アンダースコア）を使用し、人が目にする実際のリソース名には `-`（ハイフン）を使用する

```hcl
# ✅ 正しい
resource "aws_instance" "web_server" {
  tags = {
    Name = "web-server-production"  # 人が見る名前にはハイフンを使用
  }
}

resource "aws_db_instance" "main" {
  identifier = "my-app-db"  # DNS名などにはハイフンを使用
}
```

### リソースブロックの引数の順序

1. **`count` / `for_each`**: 最初の引数として配置し、その後に空行を入れる
2. **主要な引数**: リソース固有の引数を配置
3. **`tags`**: 実質的に最後の引数として配置
4. **`depends_on`**: tags の後に配置（必要な場合）
5. **`lifecycle`**: 最後に配置（必要な場合）
6. すべてのセクションを空行1行で区切る

```hcl
# ✅ 推奨: 正しい順序
resource "aws_nat_gateway" "this" {
  count = 2

  allocation_id = aws_eip.nat[count.index].id
  subnet_id     = aws_subnet.public[count.index].id

  tags = {
    Name = "nat-gateway-${count.index + 1}"
  }

  depends_on = [aws_internet_gateway.this]

  lifecycle {
    create_before_destroy = true
  }
}

# ❌ 非推奨: 順序が間違っている
resource "aws_nat_gateway" "this" {
  count = 2
  tags = "..."
  depends_on = [aws_internet_gateway.this]
  lifecycle {
    create_before_destroy = true
  }
  allocation_id = "..."
  subnet_id     = "..."
}
```

### count 内の条件

`count` でブール値を使用する方が、`length` などの式よりも推奨される

```hcl
# ✅ 最適: ブール値を使用
resource "aws_nat_gateway" "this" {
  count = var.create_nat_gateway ? 1 : 0
}

# ⭕ 良い: length を使用
resource "aws_nat_gateway" "this" {
  count = length(var.public_subnets) > 0 ? 1 : 0
}
```

### 変数の命名規則

1. **スネークケースを使用**: `instance_type`、`vpc_cidr` など
2. **複数形の命名**: 型が `list(...)` または `map(...)` の場合は、変数名に複数形を使用
3. **説明的な名前**: 型や用途を名前から推測できるようにする
4. **必ず `description` を含める**: 明白だと思える場合でも、将来必要になる

```hcl
# ✅ 推奨
variable "instance_type" {
  description = "EC2 instance type"
  type        = string
  default     = "t3.micro"
}

variable "availability_zones" {  # 複数形
  description = "List of availability zones"
  type        = list(string)
  default     = []
}

variable "subnet_ids" {  # 複数形
  description = "Map of subnet IDs"
  type        = map(string)
  default     = {}
}

variable "enable_monitoring" {
  description = "Enable detailed monitoring"
  type        = bool
  default     = false
}
```

### 変数ブロック内のキーの順序

変数ブロック内のキーは以下の順序で配置する:

1. `description`
2. `type`
3. `default`
4. `validation`

```hcl
# ✅ 推奨: 正しい順序
variable "environment" {
  description = "環境名 (dev, staging, production)"
  type        = string
  default     = "dev"

  validation {
    condition     = contains(["dev", "staging", "production"], var.environment)
    error_message = "環境は dev, staging, production のいずれかである必要があります。"
  }
}
```

### 変数の型指定

1. **シンプルな型を優先**: `object()` のような特定の型よりも、シンプルな型（`number`、`string`、`list(...)`、`map(...)`、`any`）を推奨
2. **マップの型指定**: すべての要素が同じ型の場合は `map(string)` のように指定
3. **`any` 型の使用**: 特定の深さから型バリデーションを無効にする場合や、複数の型をサポートする必要がある場合

```hcl
# ✅ 推奨: シンプルな型
variable "tags" {
  description = "リソースに適用するタグ"
  type        = map(string)
  default     = {}
}

# ⚠️ 厳密な制約が必要な場合のみ object() を使用
variable "vpc_config" {
  description = "VPC configuration"
  type = object({
    cidr_block           = string
    enable_dns_hostnames = bool
    enable_dns_support   = bool
  })
}
```

### 出力の命名規則

出力名は `{name}_{type}_{attribute}` の構造を推奨:

- **`{name}`**: リソースまたはデータソース名（例: `private`、`public`）
- **`{type}`**: プロバイダーのプレフィックスを除いたリソースタイプ（例: `subnet`、`vpc`）
- **`{attribute}`**: 返される属性（例: `id`、`arn`、`endpoint`）

```hcl
# ✅ 推奨: 構造的な命名
output "private_subnet_ids" {
  description = "List of private subnet IDs"
  value       = aws_subnet.private[*].id
}

output "public_route_table_id" {
  description = "ID of the public route table"
  value       = aws_route_table.public.id
}

output "vpc_id" {
  description = "The ID of the VPC"
  value       = aws_vpc.this.id
}
```

#### 出力名の複数形

返される値がリストの場合は、複数形の名前を使用する

```hcl
# ✅ 推奨: 複数形の使用
output "private_subnet_ids" {  # 複数形
  description = "List of private subnet IDs"
  value       = aws_subnet.private[*].id
}

output "rds_cluster_instance_endpoints" {  # 複数形
  description = "A list of all cluster instance endpoints"
  value       = aws_rds_cluster_instance.this[*].endpoint
}
```

#### `this` の省略

複数のリソースタイプを使用した補間関数を含む出力の場合、`this` プレフィックスは省略する

```hcl
# ✅ 推奨: this を省略
output "security_group_id" {
  description = "The ID of the security group"
  value       = try(aws_security_group.web[0].id, aws_security_group.default[0].id, "")
}

# ❌ 非推奨
output "this_security_group_id" {
  # ...
}
```

#### `try()` の使用

Terraform 0.13以降では、`element(concat(...))` よりも `try()` を推奨

```hcl
# ✅ 推奨: try() を使用（Terraform 0.13+）
output "security_group_id" {
  description = "The ID of the security group"
  value       = try(aws_security_group.this[0].id, aws_security_group.name_prefix[0].id, "")
}

# ⚠️ 旧形式（Terraform 0.12以前）
output "security_group_id" {
  description = "The ID of the security group"
  value       = element(concat(aws_security_group.this.*.id, aws_security_group.name_prefix.*.id, [""]), 0)
}
```

### タグの命名規則

- **パスカルケース** (`PascalCase`) を使用
- 一貫性のあるタグ戦略を適用
- すべてのリソースに共通タグを設定

```hcl
tags = {
  Name        = "web-server-production"
  Environment = "production"
  Project     = "example-project"
  ManagedBy   = "terraform"
  Owner       = "platform-team"
  CostCenter  = "engineering"
}
```

---

## ファイル構成

### 標準的なファイル構成
```
project/
├── main.tf           # メインのリソース定義
├── variables.tf      # 入力変数の定義
├── outputs.tf        # 出力値の定義
├── versions.tf       # Terraform とプロバイダーのバージョン指定
├── terraform.tfvars  # 変数の値（機密情報は除く）
├── backend.tf        # バックエンド設定
└── README.md         # プロジェクトドキュメント
```

### versions.tf の例
```hcl
terraform {
  required_version = ">= 1.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}
```

### モジュール構成
```
modules/
└── vpc/
    ├── main.tf
    ├── variables.tf
    ├── outputs.tf
    ├── versions.tf
    └── README.md
```

---

## モジュールの使用

### terraform-aws-modules の活用
**基本方針**: 可能な限り [terraform-aws-modules](https://github.com/terraform-aws-modules) の公式モジュールを使用する

#### 推奨される理由
- AWS ベストプラクティスに準拠
- コミュニティによる継続的なメンテナンス
- 豊富な機能と柔軟性
- セキュリティとパフォーマンスの最適化

#### 主要モジュール例

**VPC モジュール**
```hcl
module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "~> 5.0"

  name = "my-vpc"
  cidr = "10.0.0.0/16"

  azs             = ["ap-northeast-1a", "ap-northeast-1c"]
  private_subnets = ["10.0.1.0/24", "10.0.2.0/24"]
  public_subnets  = ["10.0.101.0/24", "10.0.102.0/24"]

  enable_nat_gateway = true
  enable_vpn_gateway = false

  tags = {
    Environment = "production"
    ManagedBy   = "terraform"
  }
}
```

**EC2 インスタンスモジュール**
```hcl
module "ec2_instance" {
  source  = "terraform-aws-modules/ec2-instance/aws"
  version = "~> 5.0"

  name = "my-instance"

  instance_type          = "t3.micro"
  ami                    = data.aws_ami.amazon_linux_2.id
  vpc_security_group_ids = [module.security_group.security_group_id]
  subnet_id              = module.vpc.private_subnets[0]

  tags = {
    Environment = "production"
  }
}
```

**セキュリティグループモジュール**
```hcl
module "security_group" {
  source  = "terraform-aws-modules/security-group/aws"
  version = "~> 5.0"

  name        = "web-server-sg"
  description = "Security group for web servers"
  vpc_id      = module.vpc.vpc_id

  ingress_cidr_blocks = ["0.0.0.0/0"]
  ingress_rules       = ["https-443-tcp", "http-80-tcp"]
  egress_rules        = ["all-all"]
}
```

**RDS モジュール**
```hcl
module "db" {
  source  = "terraform-aws-modules/rds/aws"
  version = "~> 6.0"

  identifier = "my-database"

  engine               = "postgres"
  engine_version       = "14.7"
  family               = "postgres14"
  major_engine_version = "14"
  instance_class       = "db.t3.micro"

  allocated_storage     = 20
  max_allocated_storage = 100

  db_name  = "mydb"
  username = "admin"
  port     = 5432

  vpc_security_group_ids = [module.security_group.security_group_id]
  subnet_ids             = module.vpc.private_subnets

  backup_retention_period = 7
  skip_final_snapshot     = false
  deletion_protection     = true
}
```

### カスタムモジュールの作成
terraform-aws-modules で対応できない場合のみカスタムモジュールを作成する

```hcl
module "custom_application" {
  source = "./modules/custom-app"

  environment = var.environment
  vpc_id      = module.vpc.vpc_id
  subnet_ids  = module.vpc.private_subnets
}
```

---

## 変数と出力

> 参考: [Terraform Best Practices - 命名規則](https://www.terraform-best-practices.com/ja/naming)

### 変数定義の基本ルール

1. **キーの順序を守る**: `description` → `type` → `default` → `validation`
2. **必ず `description` を記述する**: 明白だと思える場合でも含める
3. **型を明示的に指定する**: `type` を必ず指定
4. **シンプルな型を優先**: 厳密な制約が必要でない限り、`object()` よりもシンプルな型を使用
5. **複数形の命名**: `list(...)` や `map(...)` の場合は複数形の変数名を使用
6. **バリデーションの制限を理解する**: 変数のバリデーションは他の変数を参照できないなど制限がある

```hcl
# ✅ 推奨: 正しいキーの順序と命名
variable "environment" {
  description = "環境名 (dev, staging, production)"
  type        = string
  default     = "dev"

  validation {
    condition     = contains(["dev", "staging", "production"], var.environment)
    error_message = "環境は dev, staging, production のいずれかである必要があります。"
  }
}

variable "instance_count" {
  description = "作成するインスタンスの数"
  type        = number
  default     = 1

  validation {
    condition     = var.instance_count > 0 && var.instance_count <= 10
    error_message = "インスタンス数は 1 から 10 の間である必要があります。"
  }
}

# リストの場合は複数形
variable "availability_zones" {
  description = "使用するアベイラビリティゾーンのリスト"
  type        = list(string)
  default     = ["ap-northeast-1a", "ap-northeast-1c"]
}

# マップの場合も複数形
variable "common_tags" {
  description = "リソースに適用する共通タグ"
  type        = map(string)
  default     = {}
}

# シンプルな型を使用
variable "vpc_config" {
  description = "VPC 設定のマップ"
  type        = map(string)  # object() よりもシンプル
  default     = {}
}

# 厳密な制約が必要な場合のみ object() を使用
variable "database_config" {
  description = "データベース設定"
  type = object({
    engine         = string
    engine_version = string
    instance_class = string
  })
}

# 複数の型をサポートする場合は any を使用
variable "custom_config" {
  description = "カスタム設定（柔軟な型）"
  type        = any
  default     = null
}
```

### 出力定義の基本ルール

1. **命名規則に従う**: `{name}_{type}_{attribute}` の構造を使用
2. **複数形の使用**: 返される値がリストの場合は複数形の名前を使用
3. **`this` の省略**: 複数のリソースを扱う場合は `this` プレフィックスを省略
4. **必ず `description` を記述する**: 明白だと思える場合でも含める
5. **`sensitive` の慎重な使用**: 完全に制御できない限り避ける
6. **`try()` を使用**: Terraform 0.13以降では `element(concat(...))` よりも `try()` を推奨

```hcl
# ✅ 推奨: 構造的な命名
output "vpc_id" {
  description = "作成された VPC の ID"
  value       = aws_vpc.this.id
}

output "private_subnet_ids" {  # 複数形
  description = "プライベートサブネットの ID リスト"
  value       = aws_subnet.private[*].id
}

output "public_route_table_id" {
  description = "パブリックルートテーブルの ID"
  value       = aws_route_table.public.id
}

# 機密情報の場合は sensitive を使用
output "database_endpoint" {
  description = "データベースのエンドポイント"
  value       = aws_db_instance.main.endpoint
  sensitive   = true
}

output "database_password" {
  description = "データベースのパスワード"
  value       = random_password.db_password.result
  sensitive   = true
}

# try() を使用して安全に値を取得
output "security_group_id" {
  description = "セキュリティグループの ID"
  value       = try(aws_security_group.this[0].id, aws_security_group.default[0].id, "")
}

# this プレフィックスは省略
output "nat_gateway_ids" {  # this_nat_gateway_ids ではない
  description = "NAT Gateway の ID リスト"
  value       = aws_nat_gateway.this[*].id
}

# モジュールからの出力
output "vpc_cidr_block" {
  description = "VPC の CIDR ブロック"
  value       = module.vpc.vpc_cidr_block
}
```

### リソースモジュールでの変数定義

リソースモジュールを作成する際は、AWS ドキュメントの "Argument Reference" セクションに定義されている通りに変数を定義する

```hcl
# AWS の公式ドキュメントに合わせた変数定義
variable "instance_type" {
  description = "The type of instance to start"
  type        = string
  default     = "t3.micro"
}

variable "ami" {
  description = "ID of AMI to use for the instance"
  type        = string
}

variable "subnet_id" {
  description = "The VPC Subnet ID to launch in"
  type        = string
}
```

---

## コメントとドキュメント

### コメントの記述
- `#` を使用して単一行コメントを記述
- 複雑なロジックや重要な決定事項を説明する
- 過度なコメントは避け、コード自体を明確にする

```hcl
# VPC フローログを有効化して、ネットワークトラフィックを監視
resource "aws_flow_log" "main" {
  vpc_id          = module.vpc.vpc_id
  traffic_type    = "ALL"
  iam_role_arn    = aws_iam_role.flow_log.arn
  log_destination = aws_cloudwatch_log_group.flow_log.arn
}
```

### README.md の作成
各モジュールおよびプロジェクトには README.md を含める

```markdown
# VPC モジュール

## 概要
本モジュールは AWS VPC を作成し、パブリック/プライベートサブネット、NAT Gateway を構成します。

## 使用例
\`\`\`hcl
module "vpc" {
  source = "./modules/vpc"

  vpc_cidr = "10.0.0.0/16"
  azs      = ["ap-northeast-1a", "ap-northeast-1c"]
}
\`\`\`

## 入力変数
| 変数名 | 説明 | 型 | デフォルト値 | 必須 |
|--------|------|-----|-------------|------|
| vpc_cidr | VPC の CIDR ブロック | string | - | Yes |

## 出力
| 出力名 | 説明 |
|--------|------|
| vpc_id | VPC の ID |
```

---

## セキュリティとベストプラクティス

### 機密情報の管理
- **絶対に** 機密情報をコードにハードコードしない
- AWS Secrets Manager や Parameter Store を使用
- 環境変数や tfvars ファイルを活用（.gitignore に追加）

```hcl
# 推奨: Secrets Manager から取得
data "aws_secretsmanager_secret_version" "db_password" {
  secret_id = "production/database/password"
}

# 非推奨: ハードコード
# password = "MyP@ssw0rd123"  # 絶対に避ける
```

### 状態ファイルの管理
- リモートバックエンド（S3 + DynamoDB）を使用
- 状態ファイルの暗号化を有効化
- バージョニングとロックを設定

```hcl
terraform {
  backend "s3" {
    bucket         = "my-terraform-state"
    key            = "production/terraform.tfstate"
    region         = "ap-northeast-1"
    encrypt        = true
    dynamodb_table = "terraform-state-lock"
  }
}
```

### IAM ベストプラクティス
- 最小権限の原則を適用
- 管理ポリシーよりもカスタムポリシーを優先
- IAM ロールを使用し、アクセスキーの使用を避ける

```hcl
resource "aws_iam_role_policy" "lambda_policy" {
  name = "lambda-policy"
  role = aws_iam_role.lambda.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = [
          "logs:CreateLogGroup",
          "logs:CreateLogStream",
          "logs:PutLogEvents"
        ]
        Resource = "arn:aws:logs:*:*:*"
      }
    ]
  })
}
```

### リソースのタグ付け
- すべてのリソースに一貫したタグを適用
- コスト管理とリソース追跡を容易にする

```hcl
locals {
  common_tags = {
    Project     = var.project_name
    Environment = var.environment
    ManagedBy   = "terraform"
    Owner       = var.owner
    CostCenter  = var.cost_center
  }
}

resource "aws_instance" "example" {
  ami           = data.aws_ami.amazon_linux_2.id
  instance_type = var.instance_type

  tags = merge(
    local.common_tags,
    {
      Name = "example-instance"
    }
  )
}
```

### データソースの活用
- ハードコードされた値を避け、データソースで動的に取得

```hcl
# 推奨: 最新の AMI を動的に取得
data "aws_ami" "amazon_linux_2" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*-x86_64-gp2"]
  }
}

resource "aws_instance" "example" {
  ami = data.aws_ami.amazon_linux_2.id
  # ...
}
```

### ライフサイクル管理
- 重要なリソースには `prevent_destroy` を設定
- `create_before_destroy` を適切に使用

```hcl
resource "aws_db_instance" "production" {
  # ...

  lifecycle {
    prevent_destroy = true
  }
}

resource "aws_launch_template" "example" {
  # ...

  lifecycle {
    create_before_destroy = true
  }
}
```

### 条件付きリソース
- `count` や `for_each` を使用して柔軟にリソースを管理

```hcl
# 環境によって NAT Gateway を作成するかどうかを制御
resource "aws_nat_gateway" "main" {
  count = var.environment == "production" ? 2 : 1

  allocation_id = aws_eip.nat[count.index].id
  subnet_id     = module.vpc.public_subnets[count.index]
}
```

### バージョン管理
- プロバイダーのバージョンを固定
- セマンティックバージョニングを使用（`~>` 演算子）

```hcl
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"  # 5.x の最新を許可
    }
  }
}
```

---

## チェックリスト

コード作成・レビュー時には以下を確認する:

### フォーマットと構造
- [ ] `terraform fmt` でコードをフォーマット済み
- [ ] `count`/`for_each` が最初に配置され、空行で区切られている
- [ ] `tags` が実質的に最後の引数として配置されている
- [ ] `depends_on` と `lifecycle` が最後に配置されている

### 命名規則
- [ ] すべての名前で `_`（アンダースコア）を使用（`-` は避ける）
- [ ] リソース名にリソースタイプを繰り返していない
- [ ] 単数のリソースには `this` を使用している
- [ ] 複数形の変数名を `list` や `map` 型に使用している
- [ ] 出力名が `{name}_{type}_{attribute}` の構造に従っている

### 変数と出力
- [ ] すべての変数に `description` と `type` が定義されている
- [ ] 変数ブロック内のキーが正しい順序（description → type → default → validation）
- [ ] すべての出力に `description` が記述されている
- [ ] 機密情報に `sensitive = true` が設定されている
- [ ] `try()` を使用して安全に値を取得している

### セキュリティとベストプラクティス
- [ ] 機密情報がハードコードされていない
- [ ] リモートバックエンドが設定されている
- [ ] 適切なタグが全リソースに設定されている
- [ ] terraform-aws-modules が活用されている
- [ ] バージョン制約が適切に設定されている
- [ ] README.md が作成・更新されている
- [ ] セキュリティベストプラクティスが適用されている

### テストと検証
- [ ] `terraform validate` が成功する
- [ ] `terraform plan` で意図した変更が行われる

---

## 参考リンク

- [Terraform Style Guide (公式)](https://developer.hashicorp.com/terraform/language/style)
- [terraform-aws-modules (GitHub)](https://github.com/terraform-aws-modules)
- [Terraform Best Practices](https://www.terraform-best-practices.com/)
- [AWS Well-Architected Framework](https://aws.amazon.com/architecture/well-architected/)

---

## 更新履歴

| 日付 | バージョン | 変更内容 |
|------|-----------|---------|
| 2025-10-27 | 1.1.0 | 命名規則セクションを [Terraform Best Practices](https://www.terraform-best-practices.com/ja/naming) に基づいて大幅に拡充。変数・出力のベストプラクティスを追加 |
| 2025-10-27 | 1.0.0 | 初版作成 |
