module.exports = {
    appName: 'app.js',
    indexPath: './src/static/index.html',
    entryPoint: './src/index.js',
    pursSources: ['src/**/*.purs'],
    buildPath: 'dist',
    excludes: [ /node_modules/, /\.git/, /output/ ]
}
