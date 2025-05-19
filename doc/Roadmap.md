# Areco MobTeam
Controle de ponto e rotinas de recursos humanos

## Comandos de Build
Selecionar a versão 3.16.0 do Flutter
fvm use 3.16.0
fvm flutter pub clean
fvm flutter pub get
fvm flutter pub run build_runner build --delete-conflicting-outputs

Desenvolvimento:
fvm flutter build appbundle --release --flavor dev --target=lib/app/core/config/env/main_dev.dart

Produção:
fvm flutter build appbundle --release --flavor prod --target=lib/app/core/config/env/main_prod.dart

Certificados:
Obs: coloque ou altere o caminho key.properties