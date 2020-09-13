if(!require("install.load")) {
  install.packages("install.load")
  library(install.load)
}
install_load("dplyr","rtweet", "data.table")


token <- create_token(
  app = "NOME DO APP",
  consumer_key = "UIGERYGFHBWIUVBRIWEVBIOUYH ERDQWDQAD",
  consumer_secret = "DBqDvoFDGOSGHJIOGNSDFOGDFih AFDAA",
  access_token = "1036HTRHROGIJSDPVBIDFNMBPGGl FSDFDSFSD",
  access_secret = "CuETBOJBNWRMOIUNRTBINRTBIP RFSF")


#########################
#ANÁLISE DE TIMELINE

#USUÁRIOS A SEREM MONITORADOS
usuario <- c("tuliogadelha","isabelladroldao","MariliaArraes","JoaoCampos","danielCoelho23","charbelnovo",
             "mendoncafilho","coronelfeitosa","dpmarcoaurelio")

#BUSCANDO POR TIMELINES DE USUÁRIOS
base <- get_timelines(usuario, n = 3200)

# SALVANDO OS TWEETS COLETADOS
fwrite(tweets, "base.csv")

###############################
# ANÁLISE DE TWEETS SOBRE UM TEMA

# PARA SABER MAIS OPÇÕES DE BUSCA DE DADOS
# https://github.com/ropensci/rtweet


tweets <- search_tweets(q = "#RioDeGente OR RioDeGente", 
                        n = 100000, retryonratelimit = T)

fwrite(tweets, "base.csv")

#####################################################
# BUSCA POR SEGUIDORES

# exemplo de user: @itau

itau_seguidores <- get_followers(user = "itau", n = 700000, retryonratelimit = T)

fwrite(itau_seguidores, "itau_seguidores.csv")
