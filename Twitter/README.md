
### BUSCA HISTÓRICA 

Este script raspa tweets sem limitação de api.

#### Instalação

Para usar o script basta fazer download do arquivo ``` search_historical_tweets.R ``` e abri-lo dentro do RStudio/R.
Bibliotecas necessárias no R: reticulate, jsonlite, dplyr e plyr.

Bibliotecas necessárias no Python3: twint, pandas e nest_asyncio.

Para instalar as bibliotecas do python: https://nealcaren.org/lessons/twint/

#### Realizando a busca
Basta inserir o terno de busca e o número de tweets que quer ou período . EX:
  ``` r
# Busca simples por quantidade de tweets.
busca <- search_historical_tweets(q = "ninadhora", n = 200)
# visualizando o data.frame
View(busca)

# Realizando uma busca por período
busca_completa <- search_historical_tweets(q = "ninadhora", 
                                           since = "2020-05-01", 
                                           until = "2020-05-13", 
                                           output = F)

# parametro outuput é por padrão false, mas caso queima manter o json de busca, basta colocar ele true.

```


#### Resultado
``` r
glimpse(busca_completa)
Rows: 1,166
Columns: 34
$ id              <chr> "1260401703695855616", "1260389194465230848", "1260389136474791936", "1260383997122707456", "1260…
$ conversation_id <chr> "1260375748952633344", "1260375748952633344", "1260375748952633344", "1260235392068071424", "1260…
$ created_at      <chr> "1589338157000", "1589335175000", "1589335161000", "1589333936000", "1589333433000", "15893322020…
$ date            <chr> "2020-05-12", "2020-05-12", "2020-05-12", "2020-05-12", "2020-05-12", "2020-05-12", "2020-05-12",…
$ time            <chr> "23:49:17", "22:59:35", "22:59:21", "22:38:56", "22:30:33", "22:10:02", "22:08:12", "22:06:27", "…
$ timezone        <chr> "-0300", "-0300", "-0300", "-0300", "-0300", "-0300", "-0300", "-0300", "-0300", "-0300", "-0300"…
$ user_id         <chr> "50744741", "790022539032559616", "790022539032559616", "531924848", "98749783", "334930037", "98…
$ username        <chr> "redrod_", "cyberhipppie", "cyberhipppie", "beccsmmk", "tayycabral", "ninadhora", "tayycabral", "…
$ name            <chr> "rodrigo dos santos 🏴 🇧🇷 🏴", "ana", "ana", "rebecca barreto", "tay cabral", "Nina da Hora - Cient…
$ place           <chr> NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, N…
$ tweet           <chr> "outra coisa pros cotovelos hahah", "Mas nossa chocada com os preços de uma cadeira de trabalho",…
$ mentions        <chr> "ninadhora", "ninadhora", "ninadhora", "ninadhora", "ninadhora", "tayycabral", "ninadhora", NA, N…
$ urls            <chr> NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, N…
$ photos          <chr> NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, N…
$ replies_count   <chr> "0", "0", "0", "0", "0", "1", "1", "0", "8", "0", "1", "1", "1", "2", "0", "0", "0", "1", "0", "0…
$ retweets_count  <chr> "0", "0", "0", "0", "0", "0", "0", "0", "0", "0", "0", "0", "0", "6", "5", "0", "0", "0", "0", "0…
$ likes_count     <chr> "1", "1", "1", "0", "1", "0", "1", "12", "83", "2", "1", "3", "3", "36", "13", "1", "1", "2", "8"…
$ hashtags        <chr> NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, N…
$ cashtags        <chr> NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, N…
$ link            <chr> "https://twitter.com/redrod_/status/1260401703695855619", "https://twitter.com/cyberhipppie/statu…
$ retweet         <chr> "FALSE", "FALSE", "FALSE", "FALSE", "FALSE", "FALSE", "FALSE", "FALSE", "FALSE", "FALSE", "FALSE"…
$ quote_url       <chr> NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, N…
$ video           <chr> "0", "0", "1", "0", "0", "0", "0", "0", "0", "0", "0", "0", "0", "0", "1", "0", "0", "0", "0", "0…
$ near            <chr> NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, N…
$ geo             <chr> NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, N…
$ source          <chr> NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, N…
$ user_rt_id      <chr> NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, N…
$ user_rt         <chr> NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, N…
$ retweet_id      <chr> NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, N…
$ reply_to        <chr> NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, N…
$ retweet_date    <chr> NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, N…
$ translate       <chr> NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, N…
$ trans_src       <chr> NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, N…
$ trans_dest      <chr> NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, N…
```

