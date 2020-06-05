search_historical_tweets <- function(q = as.character(), 
                                     n = NA, 
                                     since = NA,
                                     until = NA, 
                                     output = F ){
 
  if(!suppressMessages(require("install.load"))) {
    install.packages("install.load")
    suppressMessages(library(install.load))
  }
  
  suppressMessages(install_load("reticulate","jsonlite","dplyr", "plyr"))
  message("Loading the packages reticulate, jsonlite and plyr")
  
  twint <- import("twint")
  pd <- import("pandas")
  nest_asyncio <- import("nest_asyncio")
  
  message("Importing the packages twint, pandas and nest_asyncio")
  
  nest_asyncio$apply()
  name_json <- paste0(Sys.time(),"_file.json")
  c = twint$Config()
  
  c$Search = q
  if(!is.na(n)){
    c$Limit = n
  } else {
    c$Since = since
    c$Until = until}

  c$Hide_output = T
  c$Store_json = T
  c$Output = name_json
  
  message("Searching tweets...")
  twint$run$Search(c)
  
  out <- as.data.frame(do.call(rbind, lapply(readLines(name_json), fromJSON)),
                       stringsAsFactors = T) %>%  mutate_all(as.character)
  
  
  out <- data.frame(lapply(out, function(x) {gsub("list()",NA,x)})) %>% 
    mutate_all(na_if,"") %>% 
    mutate_all(as.character) 
  
  if(output == T){ message(paste("Json saved as", name_json, "in", getwd()))
    } else {file.remove(name_json)}
    return(out)}
