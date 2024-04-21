{-# LANGUAGE OverloadedStrings     #-}
{-# LANGUAGE QuasiQuotes           #-}
{-# LANGUAGE TemplateHaskell       #-}
{-# LANGUAGE TypeFamilies          #-}
{-# LANGUAGE MultiParamTypeClasses #-}
module Main where
import Yesod
import Yesod.Core.Handler
import Text.Hamlet (HtmlUrl, hamlet)
import Text.Blaze.Html.Renderer.String (renderHtml)
import Data.Text (Text, pack, unpack)
import qualified Web.ClientSession   as CS

import System.IO.Unsafe
import GHC.IO (unsafePerformIO)
import Data.List
import Data.Maybe
import qualified Data.Map as Map

import Import

data HelloWorld = HelloWorld

mkYesod "HelloWorld" [parseRoutes|
/ HomeShowR GET
|]

instance Yesod HelloWorld
instance RenderMessage HelloWorld FormMessage where
    renderMessage _ _ = defaultFormMessage

{-# NOINLINE getRoot #-}
getRoot :: Handler Html
getRoot = defaultLayout $ do
    setTitle "Hello IO ()"
    $(widgetFile "home")

{-# NOINLINE getHomeShowR #-}
getHomeShowR :: Handler Html
getHomeShowR = getRoot

main :: IO ()
main = warp port HelloWorld
    where port = 6969
