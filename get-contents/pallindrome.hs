main = interact respondPallindromes

respondPallindromes = unlines . map (\x -> if pallindrome x then "pallindrome" else "not a pallindrome") . lines
  where pallindrome x = x == reverse x
