module Playful
    ( main
    , Optional(..)
    ) where

data Optional a = Some a | None

instance Show a => Show (Optional a) where
    show (Some x) = "Some " ++ show x
    show None     = "None"

instance Functor Optional where
    fmap f (Some x) = Some (f x)
    fmap _ None     = None

instance Applicative Optional where
    pure = Some

    Some f <*> a = fmap f a
    None <*> _   = None

instance Monad Optional where
    Some a >>= f    = f a
    None >>= _      = None

main :: IO ()
main = print "Yo there"
