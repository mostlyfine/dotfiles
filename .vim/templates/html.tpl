<!DOCTYPE html>
<html>
  <head>
    <meta charset='utf-8'>
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width,initial-scale=1.0,user-scalable=no">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/bulma/0.7.1/css/bulma.min.css" />
    <link href="https://use.fontawesome.com/releases/v5.3.1/css/all.css" rel="stylesheet">
    <title></title>
  </head>
  <body>
    <div class="container" id="container">
      <div class="columns is-mobile is-centered">
        <div class="column is-three-quarters-mobile is-half-desktop">
          This container is <strong>centered</strong> on desktop.

          <div class='field is-horizontal'>
            <div class='field-label is-normal'>
              <label class='label'>Sign in</lable>
            </div>

            <div class='field-body'>
              <div class="field">
                <p class="control has-icons-left has-icons-right">
                <input class="input" type="email" placeholder="Email">
                <span class="icon is-small is-left"> <i class="fas fa-envelope"></i> </span>
                <span class="icon is-small is-right"> <i class="fas fa-check"></i> </span>
                </p>
              </div>

              <div class='field'>
                <p class="control has-icons-left">
                <input class="input" type="password" placeholder="Password">
                <span class="icon is-small is-left"> <i class="fas fa-lock"></i> </span>
                </p>
              </div>
            </div>
          </div>

          <div class='field is-horizontal'>
            <div class='field-label'></div>
            <div class='field-body'>
              <div class="field">
                <p class="control">
                <button class="button is-success">Login</button>
                </p>
              </div>
            </div>
          </div>

          <h1 class='title'>Books</h1>
          <ul v-for='book in books'>
            <li v-text="book.volumeInfo.title"></li>
          </ul>
        </div>
      </div>
    </div>

    <script src="https://cdnjs.cloudflare.com/ajax/libs/axios/0.18.0/axios.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/vue/2.5.17/vue.min.js"></script>
    <script type='text/javascript'>
    var vue = new Vue({
      el: '#container',
      data: {
        books: []
      },
      created: function() {
        var self = this;
        axios.get('https://www.googleapis.com/books/v1/volumes', {params: {q: '夏目漱石'}})
        .then(function(res) {
          self.books= res.data.items;
        });
      }
    });
    </script>
  </body>
</html>


