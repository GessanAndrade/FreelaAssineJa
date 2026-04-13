# 🚀 AssineJá - Salesforce DX Project

## 📌 Overview

O **AssineJá** é um projeto baseado em **Salesforce DX (SFDX)** projetado para gerenciar fluxos de assinatura, atendimento ao cliente e automações de negócio dentro da plataforma Salesforce.

A aplicação utiliza **Apex, Triggers e Metadata do Salesforce** para implementar regras de negócio robustas, garantindo escalabilidade, governança e integração com o ecossistema Salesforce.

---

## 🧠 Objetivo

Este projeto tem como objetivo:

* Automatizar processos de assinatura
* Gerenciar interações com clientes
* Centralizar regras de negócio no backend (Apex)
* Garantir consistência e integridade de dados
* Permitir exposição controlada via usuários Guest (quando necessário)

---

## 🏗️ Arquitetura

O projeto segue o modelo **Salesforce DX**, com separação clara de responsabilidades:

```
force-app/
 └── main/
     └── default/
         ├── classes/       → Lógica de negócio (Apex)
         ├── triggers/      → Eventos de banco (DML)
         ├── objects/       → Definição de objetos
         ├── layouts/       → Layouts de UI
         ├── permissionsets/ → Controle de acesso
```

### 🔹 Padrões utilizados

* Trigger Handler Pattern (se aplicável)
* Separação de responsabilidades
* Organização por metadata
* Uso de ferramentas de lint e formatação

---

## 🛠️ Stack Tecnológica

* **Salesforce DX (SFDX)**
* **Apex**
* **SOQL**
* **Lightning Platform**
* **Node.js**
* ESLint / Prettier
* Jest (quando aplicável)

---

## ⚙️ Pré-requisitos

Antes de começar, você precisa ter instalado:

* Salesforce CLI (SFDX)
* Node.js (>= 16)
* Git
* Acesso a uma org Salesforce (Dev ou Sandbox)

---

## 🚀 Setup do Projeto

### 1. Clonar repositório

```bash
git clone <repo-url>
cd assineja
```

### 2. Autenticar no Salesforce

```bash
sfdx auth:web:login
```

### 3. Criar ou usar uma org

```bash
sfdx force:org:create -s -f config/project-scratch-def.json
```

### 4. Deploy do projeto

```bash
sfdx force:source:push
```

### 5. Atribuir permissões

```bash
sfdx force:user:permset:assign -n <PermissionSetName>
```

---

## 🔐 Configuração de Segurança

### 👤 Guest User (Acesso público)

Para permitir acesso via Guest User:

1. Vá em:

   ```
   Setup → Digital Experiences → All Sites
   ```

2. Acesse o site desejado

3. Vá em:

   ```
   Workspaces → Administration → Pages → Public Access Settings
   ```

4. Configure:

#### Permissões necessárias:

* Acesso a classes Apex utilizadas
* Permissões de objeto (Read / Create conforme necessário)
* Permissões de campo (Field-Level Security)

#### ⚠️ Importante:

* Guest User NÃO tem acesso automático a registros
* Configure **Sharing Rules** para liberar acesso
* Evite desabilitar:

  ```
  Secure guest user record access
  ```

---

## 🧩 Configuração de Objetos

* Certifique-se que todos os objetos customizados estejam presentes
* Campos obrigatórios devem estar configurados
* Validações e triggers devem ser compatíveis com o fluxo

---

## 🧪 Testes

### Executar testes Apex

```bash
sfdx force:apex:test:run
```

### Requisitos

* Cobertura mínima: **75%**
* Testes devem cobrir:

  * Triggers
  * Classes de serviço
  * Casos de erro

---

## 📦 Deploy

### Para produção:

```bash
sfdx force:source:deploy -p force-app
```

Ou via pipeline CI/CD (recomendado)

---

## 🔄 Boas Práticas

### Apex

* Sempre **bulkificar código**
* Evitar SOQL dentro de loops
* Respeitar governor limits

### Triggers

* Um trigger por objeto
* Lógica delegada para classes handler

### Segurança

* Sempre validar acesso (CRUD/FLS)
* Evitar exposição desnecessária ao Guest User

---

## 🚧 Possíveis Melhorias

* Implementação de Service Layer
* Uso de Domain Pattern (fflib)
* Pipeline CI/CD (GitHub Actions)
* Aumento de cobertura de testes
* Logging estruturado

---

## 👨‍💻 Contribuição

1. Fork do projeto
2. Criar branch:

   ```bash
   git checkout -b feature/minha-feature
   ```
3. Commit:

   ```bash
   git commit -m "feat: minha feature"
   ```
4. Push:

   ```bash
   git push origin feature/minha-feature
   ```
5. Abrir Pull Request

---

## 📄 Licença

Este projeto é de uso interno / privado.

---

## 📞 Contato

Para dúvidas ou suporte, entre em contato com o responsável pelo projeto.

---

## 🧾 Conclusão

O **AssineJá** é um projeto estruturado para ambientes Salesforce modernos, utilizando boas práticas de desenvolvimento e preparado para evolução contínua.

---
