{-# LANGUAGE OverloadedStrings #-}

module Random
    ( firstNames
    , lastNames
    , randomString
    , randomFromList
    ) where

import           Control.Monad
import           Control.Monad.IO.Class
import           Data.Functor
import           System.Random
import qualified Data.Text              as T

firstNames :: [T.Text]
firstNames =
        [ "John"
        , "Sally"
        , "Michael"
        , "Diana"
        , "Dylan"
        ]

lastNames :: [T.Text]
lastNames =
        [ "Murphy"
        , "Sullivan"
        , "Connors"
        , "Monroe"
        , "Thomas"
        ]

randomString :: IO String
randomString = flip replicateM (randomRIO ('A', 'z')) =<< randomRIO (1, 32)

randomFromList :: MonadIO m => [a] -> m a
randomFromList xs =
    let
        forRange = randomR (0, pred . length $ xs)
    in
        getStdRandom forRange <&> (!!) xs
