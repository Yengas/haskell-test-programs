import System.IO
import System.Environment
import System.Directory
import Data.List

helpMessage = "TODO program made as an haskell exercise.\n\
\Usage is command line based.\n\
\\t- todo-full.hs [args]\n\
\\t-              add todo.txt 'Hello, World' 'My name is Yiğitcan'\n\
\\t-              del todo.txt 4\n\
\\t-              view todo.txt"

parseTodos :: String -> [(Integer, String)]
parseTodos input = zipWith (\n line -> (n, line)) [0..] $ lines input

showTodos :: [(Integer, String)] -> [String]
showTodos = map (\(n, line) -> (show n) ++ " - " ++ line)

removeTodo :: [(Integer, String)] -> Int -> [(Integer, String)]
removeTodo todos idx = delete (todos !! idx) todos

todoForOutput :: [(Integer, String)] -> String
todoForOutput todos = unlines $ map snd todos

view :: [String] -> IO ()
view [inputFile] = do
  lines <- fmap (showTodos . parseTodos) $ readFile inputFile
  mapM_ putStrLn lines

del :: [String] -> IO ()
del [inputFile, idxString] = do
  todos <- fmap parseTodos $ readFile inputFile
  (tempName, tempHandle) <- openTempFile "." "tempTodo"

  let idx = read idxString
      deletedTodos = removeTodo todos idx
      result = todoForOutput deletedTodos

  hPutStr tempHandle result
  hClose tempHandle

  removeFile inputFile
  renameFile tempName inputFile

add :: [String] -> IO ()
add (outputFile:todos) = mapM_ (appendFile outputFile . (++"\n")) todos

actions :: [(String, [String] -> IO ())]
actions = [("view", view), ("add", add), ("del", del)]

main = do
  rawArgs <- getArgs

  case rawArgs of
    (command:args) ->
      case lookup command actions of
        Just (action) -> action args
        Nothing -> putStrLn helpMessage
    otherwise -> putStrLn helpMessage
