require('./index.html');
require('./main.css');

var Elm = require('./Main.elm').Elm;
var elmApp = Elm.Main.init({
    node: document.getElementById('main')
})
