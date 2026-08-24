* Encoding: UTF-8.
*==========================================================.
* ETUDE DE SATISFACTION CLIENT - SECTEUR TELECOM.
* Auteur : Bakary TOURE.
* Objectif : analyser les determinants de la satisfaction
* client et le risque de depart (churn).
*==========================================================.

*----------------------------------------------------------.
* 1. IMPORTATION DES DONNEES.
*----------------------------------------------------------.

GET DATA
  /TYPE=TXT
  /FILE="data/enquete_satisfaction_telecom.csv"
  /ENCODING='UTF8'
  /DELCASE=LINE
  /DELIMITERS=","
  /QUALIFIER='"'
  /ARRANGEMENT=DELIMITED
  /FIRSTCASE=2
  /DATATYPEMIN PERCENTAGE=95.0
  /VARIABLES=
  id_client AUTO
  age AUTO
  sexe AUTO
  anciennete_mois AUTO
  type_forfait AUTO
  qualite_reseau AUTO
  service_client AUTO
  rapport_qualite_prix AUTO
  couverture_reseau AUTO
  satisfaction_globale AUTO
  score_nps AUTO
  intention_depart AUTO.
CACHE.
EXECUTE.

DATASET NAME EnqueteSatisfaction WINDOW=FRONT.

*----------------------------------------------------------.
* 2. ETIQUETAGE DES VARIABLES ET DES VALEURS.
*----------------------------------------------------------.

VARIABLE LABELS
  age "Age du client"
  anciennete_mois "Ancienneté (mois)"
  qualite_reseau "Qualité du réseau (1-5)"
  service_client "Qualité du service client (1-5)"
  rapport_qualite_prix "Rapport qualité-prix (1-5)"
  couverture_reseau "Couverture réseau (1-5)"
  satisfaction_globale "Satisfaction globale (1-5)"
  score_nps "Score NPS (0-10)"
  intention_depart "Intention de départ (churn)".

VALUE LABELS intention_depart
  0 "Reste client"
  1 "Envisage de partir".

VALUE LABELS satisfaction_globale qualite_reseau service_client
  rapport_qualite_prix couverture_reseau
  1 "Très insatisfait"
  2 "Insatisfait"
  3 "Neutre"
  4 "Satisfait"
  5 "Très satisfait".

EXECUTE.

*----------------------------------------------------------.
* 3. TRAITEMENT DES VALEURS MANQUANTES.
*----------------------------------------------------------.

* Imputation par la médiane pour service_client.
RECODE service_client (SYSMIS = 3) INTO service_client.
EXECUTE.

*----------------------------------------------------------.
* 4. STATISTIQUES DESCRIPTIVES.
*----------------------------------------------------------.

FREQUENCIES VARIABLES=type_forfait sexe intention_depart
  /ORDER=ANALYSIS.

DESCRIPTIVES VARIABLES=age anciennete_mois qualite_reseau service_client
  rapport_qualite_prix couverture_reseau satisfaction_globale score_nps
  /STATISTICS=MEAN STDDEV MIN MAX.

*----------------------------------------------------------.
* 5. FIABILITE DE L'ECHELLE (ALPHA DE CRONBACH).
*    Verifie que les 4 items mesurent bien la meme dimension.
*----------------------------------------------------------.

RELIABILITY
  /VARIABLES=qualite_reseau service_client rapport_qualite_prix couverture_reseau
  /SCALE('Satisfaction') ALL
  /MODEL=ALPHA
  /STATISTICS=DESCRIPTIVE CORR
  /SUMMARY=TOTAL.

*----------------------------------------------------------.
* 6. COMPARAISON DE LA SATISFACTION PAR TYPE DE FORFAIT.
*    (ANOVA a un facteur).
*----------------------------------------------------------.

ONEWAY satisfaction_globale BY type_forfait
  /STATISTICS DESCRIPTIVES HOMOGENEITY
  /POSTHOC=TUKEY ALPHA(0.05).

*----------------------------------------------------------.
* 7. TEST DE DIFFERENCE HOMME / FEMME.
*----------------------------------------------------------.

T-TEST GROUPS=sexe('Homme' 'Femme')
  /VARIABLES=satisfaction_globale score_nps
  /CRITERIA=CI(.95).

*----------------------------------------------------------.
* 8. CORRELATIONS ENTRE LES DIMENSIONS DE SATISFACTION.
*----------------------------------------------------------.

CORRELATIONS
  /VARIABLES=qualite_reseau service_client rapport_qualite_prix
  couverture_reseau satisfaction_globale score_nps
  /PRINT=TWOTAIL NOSIG
  /STATISTICS=DESCRIPTIVES.

*----------------------------------------------------------.
* 9. REGRESSION LINEAIRE - DETERMINANTS DE LA SATISFACTION.
*----------------------------------------------------------.

REGRESSION
  /MISSING LISTWISE
  /STATISTICS COEFF OUTS R ANOVA COLLIN
  /CRITERIA=PIN(.05) POUT(.10)
  /NOORIGIN
  /DEPENDENT satisfaction_globale
  /METHOD=ENTER qualite_reseau service_client rapport_qualite_prix couverture_reseau anciennete_mois.

*----------------------------------------------------------.
* 10. REGRESSION LOGISTIQUE - RISQUE DE DEPART (CHURN).
*----------------------------------------------------------.

LOGISTIC REGRESSION VARIABLES intention_depart
  /METHOD=ENTER satisfaction_globale score_nps anciennete_mois
  /CLASSPLOT
  /PRINT=GOODFIT CI(95)
  /CRITERIA=PIN(0.05) POUT(0.10) ITERATE(20) CUT(0.5).

*----------------------------------------------------------.
* 11. GRAPHIQUES.
*----------------------------------------------------------.

GRAPH
  /BAR(SIMPLE)=MEAN(satisfaction_globale) BY type_forfait
  /TITLE="Satisfaction moyenne par type de forfait".

GRAPH
  /HISTOGRAM=score_nps
  /TITLE="Distribution du score NPS".

GRAPH
  /SCATTERPLOT(BIVAR)=anciennete_mois WITH satisfaction_globale
  /TITLE="Satisfaction selon l'ancienneté".
