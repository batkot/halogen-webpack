module Component (component) where

import Prelude
import Assets

import Halogen as H
import Halogen.HTML as HH
import Halogen.HTML.Properties as HP

type State = 
    { greeting :: String
    , logoUrl :: String
    }

component :: forall q i o m. Assets -> String -> H.Component q i o m
component assets greeting = 
    H.mkComponent 
        { initialState: \_ -> { greeting: greeting, logoUrl: assets.purescriptLogoUrl }
        , render
        , eval: H.mkEval $ H.defaultEval { handleAction = \_ -> pure unit }
        }

render :: forall m. State -> H.ComponentHTML Unit () m
render state = 
    HH.div
        [ HP.class_ (HH.ClassName "greet-component") ]
        [ HH.div_ [ HH.text state.greeting ]
        , HH.img [HP.src state.logoUrl]
        , HH.div_ [ HH.text "Purescript Halogen Webpack" ]
        ]
