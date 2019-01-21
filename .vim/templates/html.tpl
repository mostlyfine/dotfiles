<!DOCTYPE html>
<html>
  <head>
    <meta charset='utf-8'>
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width,initial-scale=1.0,user-scalable=no">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/bulma/0.7.2/css/bulma.min.css" />
    <link href="https://use.fontawesome.com/releases/v5.6.3/css/all.css" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css?family=Noto+Sans+JP" rel="stylesheet">
    <style>
      body { font-family: 'Noto Sans JP', sans-serif; }
    </style>
    <title></title>
  </head>
  <body>
    <div class="container" id="container">
      <div class="columns is-mobile is-centered">
        <div class="column is-three-quarters-mobile is-three-fifths-desktop">
          <h1 class='title' v-html='keyword'></h1>
          <ul v-for='book in books'>
            <li v-text="book.volumeInfo.title"></li>
          </ul>
        </div>
      </div>
    </div>

    <script src="https://unpkg.com/axios/dist/axios.min.js"></script>
    <script src="https://unpkg.com/vue"></script>
    <script type='text/javascript'>
    var vue = new Vue({
      el: '#container',
      data: {
        keyword: '夏目漱石',
        books: []
      },
      created: function() {
        var self = this;
        axios.get('https://www.googleapis.com/books/v1/volumes', {params: {q: self.keyword}})
        .then(function(res) {
          self.books = res.data.items;
        });
      }
    });
    </script>
  </body>
</html>
