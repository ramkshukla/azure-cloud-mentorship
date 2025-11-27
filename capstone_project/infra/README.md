# Capstone Project (Weeks 7-8)

This repo contains the Capstone infra and simple static app:
- Terraform infra in `capstone_project/infra/` (RG, Storage static website, Key Vault, Log Analytics, Budget)
- App static site in `capstone_project/app/`
- GitHub Actions pipelines in `.github/workflows/` (OIDC + Service Principal)
- Scripts to create backend storage container

## Quick steps (local)
1. Create backend storage container (if required):
   ```bash
   cd capstone_project/scripts
   ./create_backend_storage.sh
