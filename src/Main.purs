module Main 
    ( main ) where

import Prelude
import Assets (Assets)

import Component (component)
import Control.Apply (applySecond)
import Data.Argonaut (Json, decodeJson, printJsonDecodeError)
import Data.Array (foldl)
import Data.Either (Either(..))
import Data.Maybe (fromMaybe)
import Effect (Effect)
import Effect.Class (liftEffect)
import Effect.Console (log)
import Halogen.Aff as HA
import Halogen.VDom.Driver (runUI)
import Web.DOM.ChildNode as CN
import Web.DOM.Element as DE
import Web.DOM.HTMLCollection as HC
import Web.DOM.ParentNode as PN
import Web.HTML.HTMLElement (toParentNode)

type AppOptions =
    { appContainerSelector :: String
    , assets :: Assets
    }

main :: Json -> Effect Unit
main optionJson = 
    case decodeJson optionJson of
        Left errors -> log $ printJsonDecodeError errors
        Right options -> runApp options

runApp :: AppOptions -> Effect Unit
runApp options = HA.runHalogenAff do
    body <- HA.awaitBody
    appContainer <- fromMaybe body <$> HA.selectElement (PN.QuerySelector options.appContainerSelector)
    liftEffect $ cleanChildren (toParentNode appContainer)
    runUI (component options.assets "Hello from Halogen") unit appContainer

cleanChildren :: PN.ParentNode -> Effect Unit
cleanChildren parent = do
    children <- (map DE.toChildNode) <$> (PN.children parent >>= HC.toArray)
    foldl foo (pure unit) children
  where
    foo b a = applySecond b $ CN.remove a
