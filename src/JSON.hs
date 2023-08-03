module JSON
    ( prettyEncode
    , printJSON
    ) where

import           Data.Aeson
import           Data.Aeson.Encode.Pretty
import qualified Data.ByteString.Lazy.Char8 as B

prettyEncode :: ToJSON a => a -> B.ByteString
prettyEncode = encodePretty' defConfig

printJSON :: ToJSON a => a -> IO ()
printJSON = B.putStrLn . prettyEncode
