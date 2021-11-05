################
### Devoir 2 ###
################

setwd("~/Fac/M2/Devoir 2")

library(readxl)
library(tidyverse)

SCL90 <- read_excel("outils autoeval.xls", na='ND')
HDRS <- read_excel("outils hdrs.xls")
groupe <- read_excel("outils groupe.xls")


## Construction de la base de données pour l'analyse de survie

# Construction de la variable HAMD16
HDRS17 <- HDRS
HDRS17$HAMD16 <- HDRS17$HAMD16A
HDRS17$HAMD16 [is.na(HDRS17$HAMD16A) ] <- HDRS17$HAMD16B [is.na(HDRS17$HAMD16A) ]
HDRS17 <- subset(HDRS17, select = -c(HAMD16A, HAMD16B))
HDRS17$score <- apply(HDRS17[3:19], 1, sum)
HDRStot <- HDRS17[,c(1,2,20)]

# Constuction de la table score à chaque visite
HDRSlarge <- spread(HDRStot, VISIT,score)
HDRSlarge <- HDRSlarge[,c("NUMERO","J0","J4","J7","J14","J21","J28","J42","J56")]

# /problème à J7 128 : pas de score mais attribution




#construction de la table survie

HDRSsurv <- HDRSlarge                                          # duplication de la table
HDRSsurv <- HDRSsurv %>% as.data.frame()                       # formattage pour faciliter la manipulation 
seuil <- matrix(rep(HDRSsurv[,2]/2,8), ncol=8)                 # Création d'une matrice contenant sur chaque ligne le 
HDRSsurv[,2:9] <- HDRSsurv[,2:9]-seuil                         # seuil clinique pour valider un évènement, soustraction à
                                                               # la matrice initiale: si resultat négatif, evenement 
event <- HDRSsurv[,2:9]                                        # atteint. Vecteur contenant les individus ayant déclanché
event <- ifelse(event<=0, 1, 0)                                # l'evenement. 
succ <- apply(event,1,max,na.rm=TRUE)                    

temps <- (c(0,4,7,14,21,28,42,56))                             # vecteur contenant les valeurs temps des différentes 
                                                               # visites pour les retrouver. 
tempssucc <- t(apply(event,1, FUN = function(x){x*temps}))
tempssucc[tempssucc == 0] <- NA                                # Création d'une table avec seulement les temps >0,
delai <- apply(tempssucc,1,min,na.rm=TRUE)                     # récupération des minimums pour les evenement, recueil 
                                                               # dans délai; manque les censurés 

# pour vérifier qu'on a bien que les délais des succes et pas des censurés
# table(delai,succ)

tempscens <- !is.na(event)
tempscens <- t(apply(tempscens,1, FUN = function(x){x*temps})) #récupération du temps des dernière observations censurées
delai[succ == 0] <- apply(tempscens,1,max,na.rm=TRUE)[succ == 0]  

HDRSsurv$delai <- delai
HDRSsurv$succ <- succ

HDRSsurv <- merge(HDRSsurv,groupe, by = "NUMERO")

#construction de la table pour l'analyse de survie
HDRSsurv <- HDRSsurv[,c("NUMERO","GROUPE","succ","delai")]
