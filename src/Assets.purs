module Assets
    where

import Data.Monoid ((<>))

type Assets =
    { purescriptLogoUrl :: String
    }

type BaseStaticUrl = String

mkAssets :: BaseStaticUrl -> Assets
mkAssets baseUrls = 
    let imageUrl asset = baseUrls <> "/images/" <> asset
     in { purescriptLogoUrl: imageUrl "purescript-logo.svg" }
