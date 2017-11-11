import System.IO
import System.Environment
import Data.Char

argErrorPrint = putStrLn "Couldn't find the file to read and write in args."

processFile :: String -> String -> IO ()
processFile fileToRead fileToWrite = do
  handle <- openFile fileToRead ReadMode
  contents <- hGetContents handle
  -- alternative to all the above and hClose is:
  -- contents <- readFile fileToRead
  writeFile fileToWrite $ map toUpper contents
  hClose handle

-- get the input and output file names from list of args
getFilesFromArgs :: [String] -> Maybe (String, String)
getFilesFromArgs args
  | length args > 1 = Just (head args, head $ tail args)
  | otherwise = Nothing

-- parse the args with a pure function.
parseArgs = fmap getFilesFromArgs getArgs
  -- alternative with do below.
  -- do
  -- args <- getArgs
  -- return $ getFilesFromArgs args

main = do
  result <- parseArgs

  case result of
    Nothing -> argErrorPrint
    Just (fileToRead, fileToWrite) -> processFile fileToRead fileToWrite
