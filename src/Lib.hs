{-# LANGUAGE OverloadedStrings #-}

module Lib
    ( initialize
    , userRequest
    , fetch
    ) where

import           Data.Aeson
import           Data.Functor
import           Model.User
import           Network.HTTP.Client
import           Network.HTTP.Client.TLS
import qualified Data.ByteString.Char8 as BB


tlsRequest :: Request
tlsRequest = defaultRequest
    { secure = True
    , port = 443
    }

userRequest :: Int -> Request
userRequest xx = tlsRequest
    { host = "jsonplaceholder.typicode.com"
    , path = "/users/" <> BB.pack (show xx)
    }

usersRequest :: Request
usersRequest = tlsRequest
    { host = "jsonplaceholder.typicode.com"
    , path = "/users"
    }


fetch :: FromJSON a => Request -> IO (Maybe a)
fetch request = do
    manager <- newTlsManager
    httpLbs request manager <&> decode . responseBody


initialize :: IO ()
initialize = do
    (fetch (userRequest 1) :: IO (Maybe User)) >>= print
    (fetch usersRequest :: IO (Maybe [User])) >>= print

