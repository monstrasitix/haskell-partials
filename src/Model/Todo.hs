{-# LANGUAGE OverloadedStrings #-}

module Model.Todo
    ( Todo(..)
    ) where

import qualified Data.Text as T
import           Data.Aeson

data Todo = Todo
    { todoId        :: Int
    , todoUserId    :: Int
    , todoTitle     :: T.Text
    , todoCompleted :: Bool
    } deriving Show

instance ToJSON Todo where
    toJSON x = object
        [ "id"          .= todoId x
        , "userId"      .= todoUserId x
        , "title"       .= todoTitle x
        , "completed"   .= todoCompleted x
        ]

instance FromJSON Todo where
    parseJSON = withObject "Todo" $ \v ->
        Todo
            <$> v .: "userId"
            <*> v .: "id"
            <*> v .: "title"
            <*> v .: "completed"
