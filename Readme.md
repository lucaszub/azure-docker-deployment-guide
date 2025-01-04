# Comment Déployer une Image Docker sur Azure Container Registry et Azure Web App

Voici un tutoriel global simplifié pour créer et déployer une image Docker sur Azure Container Registry (ACR) et ensuite la publier sur Azure App Service. Ce guide est conçu pour que tu puisses le suivre étape par étape tout en garantissant la confidentialité des informations sensibles comme les identifiants d’accès.

## 1. Prérequis
Avant de commencer, tu dois avoir les éléments suivants :

- Un compte Azure
- Azure CLI installé sur ta machine
- Docker installé sur ta machine
## 2. Créer un Groupe de Ressources
Un groupe de ressources permet de regrouper et organiser toutes les ressources utilisées dans Azure. Crée-le avec la commande suivante :

```bash
az group create --name MyRessourceGroup --location francecentral
```
## 3. Créer un Azure Container Registry (ACR)
Crée un registre de conteneurs Azure où tu stockeras tes images Docker. Utilise la commande suivante :

```bash
az acr create --resource-group MyRessourceGroup --name MyRegistry123 --sku Basic --location francecentral
```
### Explication des options :
- **MyRessourceGroup** : Nom du groupe de ressources que tu viens de créer.
- **MyRegistry123** : Nom unique de ton registre ACR. Il doit être globalement unique.
- **Basic** : Plan tarifaire "Basic" adapté pour un usage léger.
**francecentral** : Région Azure où tu souhaites héberger ton ACR.
## 4. Connexion à Azure Container Registry (ACR)
Pour pousser des images Docker sur l'ACR, tu dois d’abord te connecter à ce dernier :

```bash
az acr login --name MyRegistry123
```
## 5. Construire et Pousser une Image Docker
Supposons que tu aies une application Docker prête à être déployée, par exemple une application météo.

### 5.1 Construire l'Image Docker
Dans le répertoire où se trouve ton Dockerfile, construis l'image avec cette commande :

```bash
docker build -t weatherapp:latest .
```
### 5.2 Taguer l'Image Docker
Tague l'image construite avec le nom de ton registre ACR. Cela permettra de lier l'image au registre ACR :

```bash
docker tag weatherapp:latest MyRegistry123.azurecr.io/weatherapp:latest
```
### 5.3 Pousser l'Image vers l'ACR
Envoie l'image vers ton ACR en utilisant la commande suivante :

```bash

docker push MyRegistry123.azurecr.io/weatherapp:latest
```
## 6. Créer un Plan App Service
Un App Service Plan définit les ressources allouées pour ton application web (comme les instances de machine virtuelle et les services associés). Crée-le avec cette commande :

```bash
az appservice plan create --name weatherappplan --resource-group MyRessourceGroup --sku B1 --is-linux
```
## 7. Créer une Web App sur Azure
Maintenant, tu peux créer une Web App qui utilisera l’image Docker depuis ton ACR. Voici la commande :

```bash
az webapp create --resource-group MyRessourceGroup --plan weatherappplan --name weatherappwebapp --deployment-container-image-name MyRegistry123.azurecr.io/weatherapp:latest
```
## 8. Configurer la Web App pour utiliser l'Image Docker
Ensuite, configure la Web App pour qu’elle utilise ton image Docker comme source de déploiement. Tu peux le faire avec la commande suivante :

```bash
az webapp config container set --name weatherappwebapp --resource-group MyRessourceGroup --docker-custom-image-name MyRegistry123.azurecr.io/weatherapp:latest --docker-registry-server-url https://MyRegistry123.azurecr.io --docker-registry-server-user <ACR_USERNAME> --docker-registry-server-password <ACR_PASSWORD>
```
## 9. Obtenir les Identifiants ACR
Si tu ne connais pas encore tes identifiants pour accéder à ton ACR, tu peux les obtenir avec cette commande :

```bash
az acr credential show --name MyRegistry123
```
Cela te donnera ton username et tes passwords. Utilise ces informations pour compléter la commande précédente.

## 10. Vérification
Une fois l'application déployée, tu peux vérifier que l'image a bien été poussée dans l'ACR avec cette commande :

```bash
az acr repository list --name MyRegistry123 --output table
```
Tu peux aussi accéder à ton application via l'URL fournie par Azure.

Remarque sur la Sécurité
Assure-toi de ne pas exposer d'informations sensibles dans les scripts de déploiement, comme les identifiants de connexion (ACR_USERNAME, ACR_PASSWORD). Utilise des variables d'environnement ou des services de gestion de secrets comme Azure Key Vault pour une gestion sécurisée des credentials.

Conclusion
Ce tutoriel t’a permis de déployer une image Docker dans Azure Container Registry, puis de la pousser dans une Web App Azure. Cela te permet de bénéficier de l’infrastructure Azure pour héberger et gérer tes applications conteneurisées de manière efficace et sécurisée.