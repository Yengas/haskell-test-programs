import Data.Char
import Control.Monad

-- forever :: Applicative f => f a -> f b
main = forever $ do
  line <- getLine
  putStrLn $ map toUpper line
