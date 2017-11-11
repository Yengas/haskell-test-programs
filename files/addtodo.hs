import System.IO
import Control.Monad

main = do
  putStr "Enter your todo: "
  join $ fmap (appendFile "todos" . (++"\n")) getLine
