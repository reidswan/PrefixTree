import           PrefixTree
-- toy example of using the PrefixTree library to store and search for strings
-- author: Reid Swan (reidswan [at] outlook.com)
-- date: 2017/08/07

main = do
    putStrLn "Welcome to Simple Contact Keeper"
    putStrLn "'add <contact>' to add a new contact"
    putStrLn "'find <query>' to find contacts"
    putStrLn "'quit' to quit"
    contactKeeper []

contactKeeper :: PrefixTree -> IO()
contactKeeper tree = do
    line <- getLine
    let lineParts = words line
    if head lineParts == "add" then
        contactKeeper $ addString tree (unwords $ tail lineParts)
    else if head lineParts == "find" then (do
        let found = find tree (unwords $ tail lineParts)
        putStrLn ("Found " ++ (if null found then "nothing" else join ", " found))
        contactKeeper tree)
    else putStrLn "Goodbye"

join :: String -> [String] -> String
join s = foldl1 (\a b -> a ++ s ++ b)
