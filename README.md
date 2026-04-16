# El Coach

Application mobile de coaching fitness intelligent. Combine CrossFit, Hyrox, Strength et Home Training avec un moteur adaptatif qui ajuste les seances en fonction de tes performances et de ta fatigue.

## Stack technique

- **Frontend :** React Native (Expo SDK 54) + TypeScript
- **Backend :** Supabase (Auth + PostgreSQL + RLS)
- **Navigation :** React Navigation (onglets + piles)
- **Graphiques :** react-native-chart-kit

## Installation

```bash
# Cloner le repo
git clone https://github.com/ElCoach89/alias-messi.git
cd alias-messi

# Installer les dependances
npm install

# Configurer les variables d'environnement
cp .env.example .env
# Remplir EXPO_PUBLIC_SUPABASE_ANON_KEY dans .env

# Lancer
npx expo start
```

## Configuration Supabase

1. Aller dans le SQL Editor de ton projet Supabase
2. Executer `supabase/migrations/001_initial_schema.sql` (schema)
3. Executer `supabase/seed.sql` (donnees du programme CrossFit de base)

## Structure du projet

```
src/
  types/          # Types TypeScript
  constants/      # Theme et design system
  engine/         # Moteur adaptatif (cerveau du coach)
  services/       # Client Supabase + couche API
  components/     # Composants reutilisables
  navigation/     # Navigation (tabs + stacks)
  screens/        # Ecrans de l'app
    Home/         # Seance du jour + message coach
    Program/      # Vue cycle 6 semaines
    Workout/      # Flow seance (5 etapes)
    Progress/     # Graphiques + PRs
    Profile/      # Infos + 1RM + reglages
    Timer/        # AMRAP / EMOM / For Time
  hooks/          # Custom hooks
  utils/          # Utilitaires
supabase/
  migrations/     # Schema SQL
  seed.sql        # Donnees initiales
```

## Moteur adaptatif

Analyse les 3 dernieres seances pour classifier l'utilisateur :

| Profil | Adaptation |
|--------|-----------|
| Performer | +5% charges, finisher intensifie |
| Stable | +2.5% charges, progression normale |
| Fatigue | -10% charges, -15% volume |
| En difficulte | -20% charges, -25% volume |
