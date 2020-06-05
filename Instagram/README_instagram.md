
### RASPAGEM DE PERFIL DO INSTAGRAM

Este script auxilia na raspagem de dados de perfil de usuários do Instagram. 

#### Instalação

Para usar o script basta fazer download do arquivo ``` g1_noticias.R ``` e abri-lo dentro do RStudio/R.
Pacotes necessários: rvest, lubridate,plyr,dplyr e xlsx


#### Realizando a busca
Basta inserir o usuário (ou usuários) e a data final. EX:
  ``` r
# Busca simples pelas publicações até o dia 2020-01-01 00:00:00 do usuário "ninadhora".
busca <- busca_perfil(user = "ninadhora", timestamp = "2020-01-01 00:00:00")
# visualizando o data.frame
View(busca)

# Realizando uma busca para mais de um perfil
busca_completa <- Map("busca_perfil",
                      c("trifenol", "ninadhora","oficialfiocruz"), 
                      timestamp = "2020-01-01 00:00:00")

# juntando tudo em um data.frame
busca_completa <- ldply(busca_completa, data.frame,.id = NULL)

#visualizando o data.frame
View(busca_completa)
```


#### Resultado
``` r
glimpse(busca_completa)
# Rows: 260
# Columns: 14
# $ username    <chr> "trifenol", "trifenol", "trifenol", "trifenol", "trifenol", "trifenol", "trifenol", "trifenol", "tri…
# $ name        <chr> "Janderson Toth", "Janderson Toth", "Janderson Toth", "Janderson Toth", "Janderson Toth", "Janderson…
# $ n_posts     <int> 1138, 1138, 1138, 1138, 1138, 1138, 1138, 1138, 1138, 1138, 1138, 1138, 1138, 1138, 1138, 1138, 1138…
# $ n_following <int> 2619, 2619, 2619, 2619, 2619, 2619, 2619, 2619, 2619, 2619, 2619, 2619, 2619, 2619, 2619, 2619, 2619…
# $ n_followers <int> 1470, 1470, 1470, 1470, 1470, 1470, 1470, 1470, 1470, 1470, 1470, 1470, 1470, 1470, 1470, 1470, 1470…
# $ id_post     <chr> "B-cqVvhJNai", "B-U-IbFJ3QK", "B-QWG7gpp-u", "B-MwqQYJt3u", "B-IAzuxpFAC", "B98X-Wtpm9X", "B9uopjypT…
# $ date        <dttm> 2020-04-01 15:11:23, 2020-03-29 15:30:24, 2020-03-27 20:23:43, 2020-03-26 10:58:46, 2020-03-24 14:4…
# $ type        <chr> "Carousel", "Carousel", "Photo", "Photo", "Photo", "Photo", "Photo", "Photo", "Photo", "Photo", "Vid…
# $ text        <chr> "Zero condições pra aguentar tanta fofura.", "Quarentena na roça tem suas vantagens.", "Aqui temos u…
# $ location    <chr> "Guarapari", "Guarapari", "Guarapari", "Smithsonian's National Museum of Natural History", "Guarapar…
# $ n_comments  <int> 1, 2, 0, 0, 0, 0, 4, 0, 1, 0, 0, 2, 0, 2, 2, 5, 1, 0, 1, 2, 0, 2, 2, 5, 3, 0, 1, 0, 1, 1, 10, 0, 3, …
# $ n_likes     <int> 31, 69, 45, 31, 28, 52, 64, 43, 58, 43, 23, 62, 71, 56, 58, 64, 38, 14, 42, 53, 44, 62, 49, 101, 69,…
# $ n_views     <int> NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, 259, NA, NA, 246, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA…
# $ url         <chr> "https://www.instagram.com/p/B-cqVvhJNai", "https://www.instagram.com/p/B-U-IbFJ3QK", "https://www.i…
```


### RASPAGEM DE BUSCA DO G1

Estre script foi criado para raspar notícias do site G1, usando queries diversas. Seu teste de carga pegou 30 mil notícias sobre os mais variados temas. 

#### Instalação

Para usar o script basta fazer download do arquivo ``` perfil_instagram.R ``` e abri-lo dentro do RStudio/R.
Pacotes necessários: plyr,jsonlite,tidyverse,rlist, lubridate e dplyr


#### Realizando a busca
Cada paginação retorna 15 resultados. EX: n_pagination = 10 retorna 150 notícias de 1 termo
``` r
test1 <- search(term = c("bolsonaro"), n_pagination =  10)
test2 <- search(term = c("virus","bolsonaro","rodrigo maia"), n_pagination =  3)
```


#### Resultado
``` r
glimpse(test2)
# Rows: 133
# Columns: 6
# $ Title       <chr> "Dezenas saem em carreata pelas ruas de Mogi pedindo reabertura de comércios fechados por causa do c…
# $ Description <chr> "Moradores de Mogi das Cruzes realizam carreata pela reabertura dos comércios\nNo fim da manhã desta…
# $ Newspaper   <chr> "G1", "G1", "G1", "G1", "G1", "G1", "G1", "G1", "G1", "G1", "G1", "Jornal Hoje", "G1", "Meio Dia Par…
# $ Timestamp   <dttm> 2020-03-30 16:39:16, 2020-03-30 16:35:16, 2020-03-30 16:31:16, 2020-03-30 15:57:16, 2020-03-30 15:5…
# $ URL         <chr> "g1.globo.com/busca/click?q=virus&p=24&r=1585608958287&u=https%3A%2F%2Fg1.globo.com%2Fsp%2Fmogi-das-…
# $ Term        <chr> "virus", "bolsonaro", "bolsonaro", "bolsonaro", "virus", "virus", "virus", "virus", "bolsonaro", "vi…
```
