import Control.Monad

main = do
  putStrLn "Associate colors with numbers."

  colors <- forM [1..4] (\n -> do
    putStr $ "Associate color (" ++ (show n) ++ "):"
    getLine)

  putStrLn "Colors associated with 1,2,3,4 are:"
  -- forM colors putStrLn
  mapM_ putStrLn colors
