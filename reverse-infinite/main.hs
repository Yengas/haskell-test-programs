-- import for the intercalate method
import Data.List

-- request a line, return if null, reverse print and recurse if not
requestLine = do
  putStr "LINE: "  
  line <- getLine
  if null line
    then do
      -- the do block could be omitted like;
      -- then
      --  return ()
      -- since return method gives us a Monad of the value we give it to
      -- however i wanted to be more verbose here to show that return is just a method 
      -- and not something else entirely like in imperative programming languages.
      let returnValue = return ()
      returnValue
    else do
      putStrLn $ "RESP: " ++ (reverseWords line)
      requestLine

-- split the lines into words, reverse and merge
reverseWords :: String -> String
reverseWords = unwords . map reverse . words

-- a message to show to the user at the start off the application.
startMessage :: IO String
startMessage = do
  -- another silly way of using return
  firstLine <- return "This program reverses the lines given to it."
  secondLine <- return "You can enter an empty line to finish the execution of it."
  return $ intercalate "\n" [firstLine, secondLine]

main = do
  message <- startMessage
  putStrLn message
  requestLine
