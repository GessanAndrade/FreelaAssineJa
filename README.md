# 🚀 AssineJá - Salesforce DX Project

## 📌 Overview

**AssineJá** is a project based on **Salesforce DX (SFDX)** designed to
manage subscription flows, customer support, and business automation
within the Salesforce platform.

The application uses **Apex, Triggers, and Salesforce Metadata** to
implement robust business logic, ensuring scalability, governance, and
seamless integration with the Salesforce ecosystem.

------------------------------------------------------------------------

## 🧠 Purpose

This project aims to:

-   Automate subscription processes
-   Manage customer interactions
-   Centralize business logic in the backend (Apex)
-   Ensure data consistency and integrity
-   Allow controlled exposure via Guest Users (when needed)

------------------------------------------------------------------------

## 🏗️ Architecture

The project follows the **Salesforce DX** model, with clear separation
of responsibilities:

    force-app/
     └── main/
         └── default/
             ├── classes/       → Business logic (Apex)
             ├── triggers/      → Database events (DML)
             ├── objects/       → Object definitions
             ├── layouts/       → UI layouts
             ├── permissionsets/ → Access control

### 🔹 Patterns Used

-   Trigger Handler Pattern (when applicable)
-   Separation of concerns
-   Metadata-driven organization
-   Linting and formatting tools

------------------------------------------------------------------------

## 🛠️ Tech Stack

-   **Salesforce DX (SFDX)**
-   **Apex**
-   **SOQL**
-   **Lightning Platform**
-   **Node.js**
-   ESLint / Prettier
-   Jest (when applicable)

------------------------------------------------------------------------

## ⚙️ Prerequisites

Before getting started, ensure you have:

-   Salesforce CLI (SFDX)
-   Node.js (\>= 16)
-   Git
-   Access to a Salesforce org (Dev or Sandbox)

------------------------------------------------------------------------

## 🚀 Project Setup

### 1. Clone repository

``` bash
git clone <repo-url>
cd assineja
```

### 2. Authenticate with Salesforce

``` bash
sfdx auth:web:login
```

### 3. Create or use an org

``` bash
sfdx force:org:create -s -f config/project-scratch-def.json
```

### 4. Deploy project

``` bash
sfdx force:source:push
```

### 5. Assign permissions

``` bash
sfdx force:user:permset:assign -n <PermissionSetName>
```

------------------------------------------------------------------------

## 🔐 Security Configuration

### 👤 Guest User (Public Access)

To enable Guest User access:

1.  Go to:

    Setup → Digital Experiences → All Sites

2.  Access your site

3.  Navigate to:

    Workspaces → Administration → Pages → Public Access Settings

4.  Configure:

#### Required Permissions:

-   Access to Apex classes used
-   Object permissions (Read / Create as needed)
-   Field-Level Security (FLS)

#### ⚠️ Important:

-   Guest Users do NOT have automatic record access

-   Configure **Sharing Rules** to grant visibility

-   Avoid disabling:

    Secure guest user record access

------------------------------------------------------------------------

## 🧩 Object Configuration

-   Ensure all custom objects are deployed
-   Required fields must be properly configured
-   Validation rules and triggers must align with business flows

------------------------------------------------------------------------

## 🔄 Best Practices

### Apex

-   Always **bulkify code**
-   Avoid SOQL inside loops
-   Respect governor limits

### Triggers

-   One trigger per object
-   Delegate logic to handler classes

### Security

-   Always enforce CRUD/FLS checks
-   Avoid unnecessary exposure to Guest Users

------------------------------------------------------------------------

## 📄 License

This project is for internal/private use.

------------------------------------------------------------------------

## 🧾 Conclusion

**AssineJá** is a structured project designed for modern Salesforce
environments, following best practices and ready for continuous
evolution.

------------------------------------------------------------------------
