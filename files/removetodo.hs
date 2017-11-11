import Data.List
import System.Directory
import System.IO

getTodos :: String -> [(Integer, String)]
getTodos input = zipWith (\n line -> (n, line)) [0..] $ lines input

main = do
  todos <- fmap getTodos $ readFile "todos"
  (tempName, tempHandle) <- openTempFile "." "temp"
  
  -- print the todos
  mapM_ (\(line, todo) -> putStrLn $ (show line) ++ " - " ++ todo) todos

  putStr "Please enter the todo you would like to delete:"
  number <- fmap read getLine

  -- delete the unwanted todo
  let deletedTodos = delete (todos !! number) todos
      result = unlines $ map snd deletedTodos

  hPutStr tempHandle result
  -- does the flush aswell
  hClose tempHandle

  -- replace the original file
  removeFile "todos"
  renameFile tempName "todos"
  putStrLn "Done!"
