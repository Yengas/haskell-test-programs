import Data.Char

main = do
  putStrLn "Hello, what is your first name?:"
  firstName <- getLine
  putStrLn "and your last name?:"
  lastName <- getLine
  -- let which is originally in the form of `let bindings in expression` can be used without the
  -- in part in IO functions, because they get binded to the function context.
  -- You could omit the semicolons by putting the second binding in a new line and indenting
  let firstBig = map toUpper firstName; lastBig = map toUpper lastName
  putStrLn $ "Hello, " ++ firstBig ++ " " ++ lastBig ++ ", nice to meet you!"
