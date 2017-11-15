import Control.Monad
import Data.Char

interact' :: (String -> String) -> IO ()
interact' f = join $ fmap (putStr . f) getContents

upperCase :: String -> String
upperCase = map toUpper

main = interact' upperCase
