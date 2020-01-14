<!DOCTYPE html>
<html>
  <head>
    <meta charset='utf-8'>
    <meta name="viewport" content="width=device-width,initial-scale=1.0,user-scalable=no">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/gh/kognise/water.css@latest/dist/light.min.css">
    <title>sample</title>
    <script src="https://polyfill.io/v3/polyfill.min.js?features=es6" defer></script>
    <script src="https://unpkg.com/axios/dist/axios.min.js" defer></script>
    <script src="https://unpkg.com/vue" defer></script>
    <script language="ecmascript" type="text/ecmascript" defer>
      new Vue({
        el: '#container',
        data() {
          return {
            keyword: '夏目漱石',
            books: []
          }
        },
        methods: {
          search() {
            axios.get('https://www.googleapis.com/books/v1/volumes', {params: {q: this.keyword}})
            .then((res) => {
              this.books = res.data.items
            })
          }
        },
        created() {
          this.search()
        }
      })
    </script>
  </head>
  <body>
    <div id="container">
      <input type='text' v-model='keyword' @keyup.13='search()'>
      <ul v-for='book in books'>
        <li v-text="book.volumeInfo.title"></li>
      </ul>
    </div>
  </body>
</html>
