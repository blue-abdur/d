# d
Devoir 2 master 2

Question 1

Il faut aussi revalider l'echelle de Hamilton afin de bien confirmer sa pertinence

On va devoir merge les sujets, on va devoir transpose pour les visites

Toujours bien de revérifier les échelles avec une analyse en composante principale (diagramme des valeurs propres et analyse factorielle), car souvent produites dans d'autres cultures
Peut etre voir les accords interjuges (?)

Recalculer directement les sous-score de scl90 et transposer par la suite

Validation
Coefficient de chromeback, (validation concourrante et divergente) (hamilton vs SCL depression), à faire à J0 et J56
Go matrice de correlation des 17 items () vs scl

Unidimensionnel -> plus correlé ?

/!\ Variable 16A 16B à fusionner


Question 2



Remarque: Application au modèle linéaire
{hdrs = a + b* groupe + c* visite + d* groupe* visite + €} -> tester d =/= 0 pour y arriver ==>> FAUX
Parce que qu'i n'y a pas d'effet "sujet", comme si chaque mesure provenait de différents individus; cependant la variable sujet serait autant de variables sujets qui ne pourraient pas être ajustéessimplement (n variables binairespour n sujet)
SOLUTION:
Simplification de la variable catégorielle en une variable continue de loi N(0, sigma), c'est un effet aléatoire. Cela complique très fortement le modèle
C'est l'introduction de cette variable aléatoire qui rend le modèle mixte
Cet ajustement se fait si cette variable est une variable d'ajustement

{hdrs = a + b* groupe + c* visite + d* groupe* visite + e* sujet €} -> tester d =/= 0 pour y arriver ==>> bonne démarche
La viste peut être choisie en nulérique ou catégorielle, et au lieu de comprer des pentes on compare des évolution (à notre discretion, numérique si assez linéaire)

A propos des résidus
Sur des mesure répétés, auto corrélation des résidus mesurés, pas nécessaire de le prendre en compte,
cependant, il est possible de mesure la corrélation des résidus, les résidus sur les diagonales seront égales (autocorrélation en bande), et à cause de cette corrélation le résidu devient prévisible

La librairie utilisé est LME4 et la f() est LMER [qui utilise un hypothèse d'égalité de corrélation, avec une fonction supplémentaire pour mesurer les corrélations des résidus]

(rappel: le residu represente l'erreur de mesure + les informations non disponibles)









