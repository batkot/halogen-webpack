# Halogen + Webpack 5 starter kit

Simple setup for [PureScript](https://www.purescript.org) + [Halogen](https://github.com/purescript-halogen/purescript-halogen) development using [Webpack 5](https://webpack.js.org/)

Develop with `npm run dev`. Build with `npm run build`. Modify and have fun.

## Features:
- [Static asset loading](./src/environment.js#L3) via Webpack [Asset Modules](./webpack.prod.config.js#L30-34)
- [Environment variables](./src/environment.js#L7-10) via Webpack [`Define Plugin`](./webpack.prod.config.js#69-72)
- [Startup parameters](./src/Main.purs#L23-32) parsing via [argonaut](https://github.com/purescript-contrib/purescript-argonaut)
- [PureScript compilation](./src/webpack.prod.config.js#L35-49) via Webpack [purs-loader](https://github.com/ethul/purs-loader)
- [SASS styling](./src/static/style.scss) via Webpack [loaders](./webpack.prod.config.js#L19-30)
- Webpack [dev server](./webpack.dev.config.js#68-74)
- Custom monad [AppT](./src/App.purs) placeholder


