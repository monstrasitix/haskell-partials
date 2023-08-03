{-# LANGUAGE OverloadedStrings #-}

module Lib
    ( initialize
    ) where

import           Data.Aeson
import           Data.Functor
import           JSON
import           Random
import qualified Data.Text    as T
import qualified Data.UUID    as U
import qualified Data.UUID.V4 as U4

data User = User
    { userId            :: String
    , userFirstName     :: T.Text
    , userLastName      :: T.Text
    , userPasswordHash  :: T.Text
    , userSalt          :: String
    } deriving Show

data PartialUser = PartialUser
    { partialUserId        :: String
    , partialUserFirstName :: T.Text
    , partialUserLastName  :: T.Text
    } deriving Show

instance FromJSON User where
    parseJSON = withObject "User" $ \v ->
        User
            <$> v .: "id"
            <*> v .: "firstName"
            <*> v .: "lastName"
            <*> v .: "passwordHash"
            <*> v .: "salt"

instance FromJSON PartialUser where
    parseJSON = withObject "PartialUser" $ \v ->
        PartialUser
            <$> v .: "id"
            <*> v .: "firstName"
            <*> v .: "lastName"

instance ToJSON User where
    toJSON x = object
        [ "id"           .= userId x
        , "firstName"    .= userFirstName x
        , "lastName"     .= userLastName x
        , "passwordHash" .= userPasswordHash x
        , "salt"         .= userSalt x
        ]

instance ToJSON PartialUser where
    toJSON x = object
        [ "id"        .= partialUserId x
        , "firstName" .= partialUserFirstName x
        , "lastName"  .= partialUserLastName x
        ]

generateUser :: IO User
generateUser = do
    identifier   <- U4.nextRandom <&> U.toString
    password     <- randomString  <&> T.pack
    passwordSalt <- randomString
    firstName    <- randomFromList firstNames
    lastName     <- randomFromList lastNames
    return $ User
        identifier
        firstName
        lastName
        password
        passwordSalt

generatePartialUser :: IO PartialUser
generatePartialUser = do
    user <- generateUser
    return $ PartialUser
        (userId user)
        (userFirstName user)
        (userLastName user)

userFromPartial :: User -> PartialUser
userFromPartial x = PartialUser
    (userId x)
    (userFirstName x)
    (userLastName x)

-- partialToUser ???

initialize :: IO ()
initialize = do
    user <- generateUser
    printJSON user
    printJSON (userFromPartial user)
    generatePartialUser >>= printJSON
