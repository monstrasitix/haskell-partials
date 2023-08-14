{-# LANGUAGE OverloadedStrings #-}

module Lib
    ( initialize
    , fetchTodo
    , fetchUser
    , fetchJSON2
    ) where

import           Data.Aeson
import           Data.Functor
import           Model.Todo
import           Model.User
import           Network.HTTP.Client
import           Network.HTTP.Client.TLS

tlsManagerIO :: IO Manager
tlsManagerIO = newTlsManagerWith tlsManagerSettings

fetchJSON :: FromJSON a => String -> IO (Maybe a)
fetchJSON url = do
    manager <- tlsManagerIO
    request <- parseRequest url
    httpLbs request manager <&> decode . responseBody

fetchJSON2 :: FromJSON a => String -> IO (Maybe a)
fetchJSON2 url = do
    response <- httpLbs <$> parseRequest url <*> tlsManagerIO
    response <&> decode . responseBody

fetchTodo :: Int -> IO (Maybe Todo)
fetchTodo id_ = fetchJSON $ "https://jsonplaceholder.typicode.com/todos/" ++ show id_

fetchUser :: Int -> IO (Maybe User)
fetchUser id_ = fetchJSON $ "https://jsonplaceholder.typicode.com/users/" ++ show id_

initialize :: IO ()
initialize = do
    let
        result :: Maybe Int
        result = (+) <$> Just 4 <*> Just 9
    print result
    fetchUser 1 >>= print

