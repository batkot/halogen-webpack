module Main 
    ( main ) where

import Prelude
import Assets

import Component (component)
import Control.Apply (applySecond)
import Data.Array (foldl)
import Data.Maybe (fromMaybe)
import Effect (Effect)
import Effect.Class (liftEffect)
import Halogen.Aff as HA
import Halogen.VDom.Driver (runUI)
import Web.DOM.ChildNode as CN
import Web.DOM.Element as DE
import Web.DOM.HTMLCollection as HC
import Web.DOM.ParentNode as PN
import Web.HTML.HTMLElement (toParentNode)

type AppOptions =
    { appContainerSelector :: String
    , baseStaticUrl :: String
    }

main :: AppOptions -> Effect Unit
main options = HA.runHalogenAff do
    body <- HA.awaitBody
    appContainer <- fromMaybe body <$> HA.selectElement (PN.QuerySelector options.appContainerSelector)
    liftEffect $ cleanChildren (toParentNode appContainer)
    let assets = mkAssets options.baseStaticUrl
    runUI (component assets "Hello from Halogen") unit appContainer

cleanChildren :: PN.ParentNode -> Effect Unit
cleanChildren parent = do
    children <- (map DE.toChildNode) <$> (PN.children parent >>= HC.toArray)
    foldl foo (pure unit) children
  where
    foo b a = applySecond b $ CN.remove a
