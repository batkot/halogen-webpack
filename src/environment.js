exports.requireAssets = basePath => {
    return {
        purescriptLogoUrl: require(`${basePath}/images/purescript-logo.svg`).default
    }
}

exports.appOptions = {
    appContainerSelector: __APP_CONTAINER_SELECTOR__,
    assetsBasePath: __ASSETS_BASE_PATH__,
    baseStaticUrl: ''
}
