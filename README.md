# 📱 Étude de Satisfaction Client — Secteur Télécom (SPSS)

Analyse d'une enquête de satisfaction client fictive pour un opérateur télécom, avec test de fiabilité d'échelle, ANOVA, corrélations et modèles de régression (linéaire et logistique).

**Contexte fictif :** un opérateur télécom souhaite comprendre les déterminants de la satisfaction client et identifier les clients à risque de départ (churn).

---

## 🧱 Contenu du repository

```
spss-satisfaction-study/
├── data/
│   └── enquete_satisfaction_telecom.csv   # 850 répondants
├── analyse_satisfaction.sps               # Syntaxe SPSS complète
└── README.md
```

---

## 🗂️ Le jeu de données

850 clients, avec : âge, sexe, ancienneté, type de forfait, 4 dimensions de satisfaction sur échelle de Likert 1-5 (qualité réseau, service client, rapport qualité-prix, couverture réseau), satisfaction globale, score NPS (0-10), et intention de départ.

---

## 🛠️ Analyses réalisées

1. **Statistiques descriptives** — fréquences et moyennes de toutes les variables clés
2. **Fiabilité de l'échelle (Alpha de Cronbach)** — vérifie que les 4 dimensions mesurent bien une même échelle de satisfaction
3. **ANOVA à un facteur** — la satisfaction diffère-t-elle selon le type de forfait ? (avec test post-hoc de Tukey)
4. **Test t** — différence de satisfaction entre hommes et femmes
5. **Corrélations** — relations entre les dimensions de satisfaction et le score NPS
6. **Régression linéaire** — quelles dimensions expliquent le mieux la satisfaction globale ?
7. **Régression logistique** — quels facteurs prédisent l'intention de départ (churn) ?
8. **Visualisations** — moyennes par forfait, distribution du NPS, satisfaction vs ancienneté

---

## ▶️ Reproduire l'analyse

1. Ouvrir SPSS.
2. Fichier → Ouvrir → Syntaxe → sélectionner `analyse_satisfaction.sps`
3. S'assurer que le dossier `data/` est au même niveau que le fichier de syntaxe (chemins relatifs)
4. Sélectionner tout (Ctrl+A) puis Exécuter → Tout

---

## 📊 Principaux résultats attendus

- Alpha de Cronbach > 0.7 : l'échelle de satisfaction est fiable
- Différences significatives de satisfaction selon le type de forfait
- Les clients avec une satisfaction globale faible (≤ 2/5) ont une probabilité de départ nettement plus élevée

---

## 👤 Auteur

**Bakary TOURE** — Data Analyst Junior
[Portfolio](https://tourebakary29.github.io/) · [LinkedIn](https://linkedin.com/in/bakary-toure) · [GitHub](https://github.com/tourebakary29)
