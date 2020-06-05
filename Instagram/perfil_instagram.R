#########################################################
##### SCRIPT CRIADO POR JANDERSON TOTH (@trifenol) ######
#########################################################


# instalando os pacotes necessários
if(!require("install.load")) {
  install.packages("install.load")
  library(install.load)
}
install_load("plyr","jsonlite","tidyverse","rlist", "lubridate", "dplyr")

# função para a busca
busca_perfil <- function(user, timestamp) {
  # Dando um valor minimo para o timestamp
  min_timestamp = now()
  y = 1
  
  # tratando os dados de texto
  pega_texto <- function(local){
    xz <- function(local){
      text <- local$node$text
      if(is.null(text)){ text = NA}
      return(text)}
    dd <- ldply(lapply(local, xz), rbind)
    dd <- as.character(dd$`1`)
    return(dd)
  }
  # iterando a busca a cada página
  while(min_timestamp >= timestamp){
      if (y == 1){
      final <- data.frame()
      #busca inicial para pegar os dados iniciais
      url_ini <- paste0("https://www.instagram.com/", user, "/?__a=1")
      #buscando
      document_ini <- fromJSON(txt=url_ini)
      # pegando o id do usuário
      id <- document_ini$graphql$user$id
      # pegando info para ir para a próxima página
      end_cursor <- document_ini$graphql$user$edge_owner_to_timeline_media$page_info$end_cursor
      n1 <- 'https://www.instagram.com/graphql/query/?query_hash=e769aa130647d2354c40ea6a439bfc08&variables={%22id%22:%22'
      n2 <- '%22,%22first%22:12,%22after%22:%22'
      n3 <- "%22}"
      # atribuindo para facilitar
      s <- document_ini$graphql$user$edge_owner_to_timeline_media$edges$node
      
      username <- document_ini$graphql$user$username
      name <- document_ini$graphql$user$full_name
      n_posts <- document_ini$graphql$user$edge_owner_to_timeline_media$count
      n_following <- document_ini$graphql$user$edge_follow$count
      n_followers <- document_ini$graphql$user$edge_followed_by$count
     # criando a url da próxima busca
      url <- noquote(paste0(n1,id,n2,end_cursor,n3))
      #buscando as informações
      document <- fromJSON(txt=url)
      end_cursor <- document$data$user$edge_owner_to_timeline_media$page_info$end_cursor
    
      if(length(document$data$user$edge_owner_to_timeline_media$edges) == 0){
        message("Blocked or Deleted Profile")
        break
        }
    }  else {
        # buscando as informações da próxima página
        url <- noquote(paste0(n1,id,n2,end_cursor,n3))
        document <- fromJSON(txt=url)
        end_cursor <- document$data$user$edge_owner_to_timeline_media$page_info$end_cursor
        s <- document$data$user$edge_owner_to_timeline_media$edges$node
      }
    
    message(paste(nrow(final),"conteúdos do usuário", username))
    # criando um dataframe com as informações da página atual
      df <- data.frame(id_post = s$shortcode,
                      type = s$`__typename`,
                      date = s$taken_at_timestamp,
                      text =  pega_texto(s$edge_media_to_caption$edges),
                      location = if(is.logical(s$location)){
                                  rep(NA, length(s$shortcode))
                        } else { if(length(s$location$name)== 0){
                        rep(NA, length(s$shortcode))
                      } else {
                        s$location$name}},
                      n_comments = if(length(s$edge_media_to_comment$count)== 0){
                        rep(NA, length(s$shortcode))
                      } else {
                        s$edge_media_to_comment$count},
                      n_likes = if(length(s$edge_media_preview_like$count)== 0){
                        rep(0, length(s$shortcode))
                      } else {
                        s$edge_media_preview_like$count},
                      n_views = if(length(s$video_view_count)== 0){
                                  rep(NA, length(s$shortcode))
                        } else {
                          s$video_view_count},
                      url = paste0("https://www.instagram.com/p/",s$shortcode), stringsAsFactors = F)  
    
   # tratando as informações
    df$text <- gsub("[\r\n]", "", df$text)
    df <- df %>% mutate(date = as.POSIXct(df$date, origin="1970-01-01 00:00:00"),
                        type = case_when(type == "GraphImage" ~ "Photo",
                                         type == "GraphVideo" ~ "Video",
                                         type == "GraphSidecar" ~ "Carousel"),
                        username = username,
                        name = name,
                        n_posts = n_posts,
                        n_following = n_following,
                        n_followers = n_followers
                        ) %>%  
                  arrange(desc(date)) %>%
                  select(username, name, n_posts,n_following, n_followers,id_post, date,type,text,
                         location,n_comments,n_likes,n_views,url)
   # juntando com as outras páginas
    final <- rbind(final,df)
    # eliminando caso tenha algum dado repetido
    final <- final %>% distinct(id_post,.keep_all = T)
    # verificando até que data foi buscado
    min_timestamp <- min(final$date)
    y = y + 1
  }
  # filtrando apenas o periodo requisitado
  final <- final %>% filter(date >= timestamp)
  message(paste(nrow(final),"conteúdos do usuário", username))
  return(final)
}

# realizando uma busca simples
busca <- busca_perfil(user = "trifenol", timestamp = "2020-01-01 00:00:00")

# realizando uma busca para mais de um perfil
busca_completa <- Map("busca_perfil",
    c("trifenol", "ninadhora","oficialfiocruz"), 
    timestamp = "2020-01-01 00:00:00")
# juntando tudo em um data.frame
busca_completa <- ldply(busca_completa, data.frame,.id = NULL)

#visualizando o data.frame
View(busca_completa)
