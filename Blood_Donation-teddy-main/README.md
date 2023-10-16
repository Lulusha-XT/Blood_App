# # Fullstack Blood-Donation Mobile App - Sponser Dashboard

Welcome to the Sponser Dashboard, a Fullstack Blood-Donation Mobile App project! This repository contains everything you need to get started with our Fullstack Blood-Donation Mobile App.

## Table of Contents

- [Introduction](#introduction)
- [Prerequisites](#prerequisites)
- [Installation](#installation)
- [Usage](#usage)
- [Contributing](#contributing)
- [License](#license)

## Introduction

this is a Fullstack Blood-Donation Mobile App designed to help you donate blood effectively. It provides features such as Requesting Blood, Donating Blood, Sponsership and Support for Donors and much more.

## Prerequisites

Before you begin, ensure you have met the following requirements:

- [Node.js](https://nodejs.org/) installed on your system.
- [Yarn](https://classic.yarnpkg.com/en/docs/install/) installed on your system.

## Installation

1. Clone the repository to your local machine:

   ```shell
   git remote add origin git@github.com:Lulusha-XT/Blood-Donation-Final.git
   cd FullStackFitnessApp
   ```

2. Install backend dependencies:

   ```shell
   cd backend
   yarn install
   ```

### Database for Development Server

Before running the database migration, ensure that you have updated the "type" property in the backend `package.json` file. Modify or remove the line `"type": "module"` as needed. After completing the migration, remember to revert the change in the backend `package.json` file.

1. run mongoDB compass and create a collection called "blood-donation"

2. To start the development server, run:

   ```shell
   yarn start
   ```

3. Install Sponser-Dashboard dependencies:

   ```shell
   cd ../Sponser-dashboard
   yarn install
   ```

4. To start the Sponser-Dashboard, run:

   ```shell
   yarn dev
   ```

## Usage

Once the server is running, open your web browser and navigate to [http://localhost:5173/](http://localhost:5173/) to access the Sponser Dashboard.

## Contributing

We welcome contributions from the community. If you'd like to contribute to this project, please follow our [Contribution Guidelines](CONTRIBUTING.md).

## License
