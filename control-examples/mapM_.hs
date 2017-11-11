main = do
  results <- mapM (putStrLn . show) [1,2,3,4] 
  print $ results
