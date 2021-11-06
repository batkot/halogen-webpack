require('./static/style.scss');

const appOptions = require('./environment');
console.log(appOptions);
const app = require('./Main.purs');
app.main(appOptions)();
