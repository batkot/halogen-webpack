require('./static/style.scss');

const { requireAssets, appOptions } = require('./environment');
const assets = requireAssets(appOptions.assetsBasePath);
console.log('Assets:', assets);
const app = require('./Main.purs');
app.main(appOptions)();
