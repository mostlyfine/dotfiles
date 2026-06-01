#!/bin/sh

file="$1" w="$2" h="$3" x="$4" y="$5"

ext=$(echo "${file##*.}" | tr '[:upper:]' '[:lower:]')

case "$ext" in
    json|jsonl) jq -C -r . "$file" ;;
    pdf) pdftotext -layout "$file" ;;
    md) CLICOLOR_FORCE=1 glow --style dark "$file" --width $w ;;
    zip)  unzip -l "$file" ;;
    tar)  tar -tf  "$file" ;;
    gz)   tar -tzf "$file" 2>/dev/null || gunzip -l "$file" ;;
    tgz)  tar -tzf "$file" ;;
    bz2)  tar -tjf "$file" 2>/dev/null || echo "${file%.bz2}" ;;
    *) bat --color=always --style=numbers --terminal-width="$w" "$file" 2>/dev/null || cat "$file" ;;
esac

