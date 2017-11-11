import Control.Monad

-- Applicative f => Bool -> f () -> f ()
main = do
  c <- getChar
  when (c /= ' ') $ do
    putChar c
    main

