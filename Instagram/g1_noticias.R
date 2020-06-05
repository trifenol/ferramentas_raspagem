# Checando se os pacotes estão instalados, instalando os faltantes e executando todos os pacotes necessários
if (!require("install.load")) {
  install.packages("install.load")
  library(install.load)
}
install_load("rvest", "lubridate","plyr","dplyr","xlsx")


#Script de busca
search <- function(term, n_pagination){
  #tratando os termos a serem pesquisados
  term <- gsub(" ","+",term)
  data <- data.frame() #criando a base 
  
  # função para o trataento das datas
  cleaning_date <- function(date){
    v <- strsplit(as.character(date), " ")
    
    xx <- function(v){
      if(length(v) == 3){
        if(v[3] == "dia" |v[3] == "dias"){
          v2 <- as.integer(v[2])
          vv <- now() - 60*60*24*v2
        } else if(v[3] == "hora" |v[3] == "horas" ){
          v2 <- as.integer(v[2])
          vv <- now() - 60*60*v2
        } else if(v[3] == "minuto" |v[3] == "minutos" ){
          v2 <- as.integer(v[2])
          vv <- now() - 60*v2
        } else if(v[3] == "segundo" |v[3] == "segundos" ){
          v2 <- as.integer(v[2])
          vv <- now() - v2
        } else if(v[3] == "ano" |v[3] == "anos" ){
          v2 <- as.integer(v[2])
          vv <- now() - 60*60*24*365*v2
        }
      } else if(length(v) == 2){
        vv <- paste(v[1],v[2])
        vv <- strptime(vv,format='%d/%m/%Y %Hh%M')
      }
      vv <- data.frame(data = as.POSIXct(vv))
      return(vv)}
    dd <- ldply(lapply(v, xx), rbind)[,1]
    
    return(dd)
  } 
  
  # loop de busca e paginação
for (x in term) {
    for (pag in 1:n_pagination) {
    url <- paste0('https://g1.globo.com/busca/?q=',x,'&page=',pag) #url de busca
    # Lendo o código HTML do site
    webpage <- read_html(url)
    # Usando o CSS para buscar os títulos 
    title_data_html <- html_nodes(webpage,'div.widget--info__title.product-color')
    title_data <- html_text(title_data_html)
    remove(title_data_html)
    title_data <- gsub('\n        ',"",title_data)
    title_data <- gsub('\n      ',"",title_data)
    
   # Buscando as descrições
    description_data_html <- html_nodes(webpage,'p.widget--info__description')
    description_data <- html_text(description_data_html)
    remove(description_data_html)
    
    # buscando o nome do jornal
    news_data_html <- html_nodes(webpage,'div.widget--info__header')
    news_data<- html_text(news_data_html)
    remove(news_data_html)
     if(length(news_data) == 14){
       news_data_html2 <- html_nodes(webpage,'p.widget--info__ad-label') #publicidade
       news_data2 <- html_text(news_data_html2)
       news_data <- c(news_data[1],news_data2, news_data[2:14])}
  
    # buscando as datas  
    timestamp_data_html <- html_nodes(webpage,'div.widget--info__meta')
    timestamp_data <- html_text(timestamp_data_html)
    remove(timestamp_data_html)
    
    # buscando as URLs
    url_data <- webpage %>%
      html_nodes("div.widget--info__text-container > a") %>%
      html_attr("href")
    url_data <- gsub("//","", url_data)
    
    # verificando se todos os dados estão presentes
    if((length(title_data) == length(description_data) & length(timestamp_data) == length(news_data)) == TRUE){
      data_interm <- data.frame(Title = title_data, 
                                Description = description_data,
                                Newspaper = news_data,
                                Timestamp = timestamp_data,
                                URL = url_data,
                                Term = x)
      print(c(pag,x))
      
      data <- rbind(data,data_interm)
      # colocando pra dormir
      Sys.sleep(runif(1, 2,4))}
    
  
    }
  
 message(nrow(data))
}
  data <- data %>% mutate(Title = as.character(Title), 
                          Description = as.character(Description),
                          Newspaper = as.character(Newspaper),
                          Timestamp = cleaning_date(data$Timestamp),
                          URL = as.character(URL),
                          Term = as.character(Term))  %>% 
    distinct(Title, Description,.keep_all = T) %>% arrange(desc(Timestamp))
  
      return(data)
}

# realizando a busca
# cada paginação retorna 15 resultados. EX: n_pagination = 10 retorna 150 notícias
test <- search(term = c("virus","bolsonaro","rodrigo maia"), n_pagination =  3)

# salvando em uma planilha
write.xlsx(test, "g1_busca.xlsx", row.names = F, showNA = F)
