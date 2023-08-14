{-# LANGUAGE OverloadedStrings #-}

module Model.User
    ( User(..)
    , UserAddress(..)
    , UserGeo(..)
    , UserCompany(..)
    ) where

import           Data.Aeson
import qualified Data.Text as T

data User = User
    { userId        :: Int
    , userName      :: T.Text
    , userUsername  :: T.Text
    , userEmail     :: T.Text
    , userAddress   :: UserAddress
    , userPhone     :: T.Text
    , userWebsite   :: T.Text
    , userCompany   :: UserCompany
    } deriving Show

instance FromJSON User where
    parseJSON = withObject "User" $ \x ->
        User
            <$> x .: "id"
            <*> x .: "name"
            <*> x .: "username"
            <*> x .: "email"
            <*> x .: "address"
            <*> x .: "phone"
            <*> x .: "website"
            <*> x .: "company"

instance ToJSON User where
    toJSON x = object
        [ "id" .= userId x
        , "name" .= userName x
        , "username" .= userUsername x
        , "email" .= userEmail x
        , "address" .= userAddress x
        , "phone" .= userPhone x
        , "website" .= userWebsite x
        , "company" .= userCompany x
        ]

data UserAddress = UserAddress
    { userAddressStreet     :: T.Text
    , userAddressSuite      :: T.Text
    , userAddressCity       :: T.Text
    , userAddressZipCode    :: T.Text
    , userAddressGeo        :: UserGeo
    } deriving Show

instance FromJSON UserAddress where
    parseJSON = withObject "UserAddress" $ \x ->
        UserAddress
            <$> x .: "street"
            <*> x .: "suite"
            <*> x .: "city"
            <*> x .: "zipcode"
            <*> x .: "geo"

instance ToJSON UserAddress where
    toJSON x = object
        [ "street"  .= userAddressStreet x
        , "suite"   .= userAddressSuite x
        , "city"    .= userAddressCity x
        , "zipcode" .= userAddressZipCode x
        , "geo"     .= userAddressGeo x
        ]

data UserGeo = UserGeo
    { userGeoLat :: String
    , userGeoLng :: String
    } deriving Show

instance FromJSON UserGeo where
    parseJSON = withObject "UserGeo" $ \x ->
        UserGeo
            <$> x .: "lat"
            <*> x .: "lng"

instance ToJSON UserGeo where
    toJSON x = object
        [ "lat" .= userGeoLat x
        , "lng" .= userGeoLng x
        ]

data UserCompany = UserCompany
    { userCompanyName        :: T.Text
    , userCompanyCatchPhrase :: T.Text
    , userCompanyBs          :: T.Text
    } deriving Show

instance FromJSON UserCompany where
    parseJSON = withObject "UserCompany" $ \x ->
        UserCompany
            <$> x .: "name"
            <*> x .: "catchPhrase"
            <*> x .: "bs"

instance ToJSON UserCompany where
    toJSON x = object
        [ "name"        .= userCompanyName x
        , "catchPhrase" .= userCompanyCatchPhrase x
        , "bs"          .= userCompanyBs x
        ]
