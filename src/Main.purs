module Main where

import Prelude

import Control.Apply (applySecond)
import Control.Category (identity)
import Data.Array (foldl)
import Data.Maybe (maybe)
import Effect (Effect)
import Effect.Class (liftEffect)
import Halogen.Aff as HA
import Web.DOM.ChildNode as CN
import Web.DOM.Element as DE
import Web.DOM.HTMLCollection as HC
import Web.DOM.Node as Node
import Web.DOM.ParentNode as PN
import Web.HTML.HTMLElement (toParentNode, toNode)

containerSelector :: PN.QuerySelector
containerSelector = PN.QuerySelector "#app"

main :: Effect Unit
main = HA.runHalogenAff do
    body <- HA.awaitBody
    appContainer <- maybe body identity <$> HA.selectElement containerSelector
    liftEffect $ cleanChildren (toParentNode appContainer)
    liftEffect $ Node.setTextContent "Hello from PureScript" $ toNode appContainer

cleanChildren :: PN.ParentNode -> Effect Unit
cleanChildren parent = do
    children <- (map DE.toChildNode) <$> (PN.children parent >>= HC.toArray)
    foldl foo (pure unit) children
  where
    foo b a = applySecond b $ CN.remove a
