### Créer un groupe de ressource
```bash
az group create --name MyRessourceGroup --location francecentral
```


Pour créer un Azure Container Registry (ACR) avec un plan basique dans une région en France, utilise la commande suivante :
```bash
az acr create --resource-group <NOM_DU_GROUPE> --name <NOM_DU_REGISTRY> --sku Basic --location francecentral
```
### Explications des options :
- <NOM_DU_GROUPE> : Remplace par le nom du groupe de ressources où tu veux créer le registry.
- <NOM_DU_REGISTRY> : Remplace par le nom souhaité pour ton registry. Ce nom doit être unique au niveau mondial.
- --sku Basic : Spécifie le plan de tarification "Basic".
- --location francecentral : Définit la région en France. Tu peux aussi utiliser francesouth pour une autre région française.


### Exemple concret :
```bash
az acr create --resource-group MyResourceGroup --name MyRegistry123 --sku Basic --location francecentral

```
Une fois créé, tu peux vérifier que ton ACR est opérationnel avec :
```bash
az acr list --resource-group <NOM_DU_GROUPE> --output table
```

se loguer après de l'acr
```bash
az acr login --name weatherappregistry

```

