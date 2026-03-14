module MyLib (someFunc) where

someFunc :: [String] -> IO ()
someFunc args = do
  putStrLn "Arguments passed to someFunc:"
  mapM_ (putStrLn . (" " <>))  args
