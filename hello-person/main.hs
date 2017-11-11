main = do
  -- bind the result of putStrLn which is an empty tuple
  -- to a unnamed variable. this is unnecessary.
  _ <- putStrLn "Hello, there! What is your name?"
  -- the getLine method which returns an IO String
  -- will be binded to the name
  name <- getLine
  -- we can't bind this to anything, because the main
  -- method should return something. atleast that is the simple case.
  putStrLn $ "Hello " ++ name ++ ", nice to meet you!"
