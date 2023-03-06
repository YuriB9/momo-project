## About The Project

The Momo Store App allows the user to order best dumplings ever! This application was developed to provide examples of how to build and support CI\CD process based on Gitlab.

<img width="900" alt="image" src="https://user-images.githubusercontent.com/9394918/167876466-2c530828-d658-4efe-9064-825626cc6db5.png">

See additional instructions and readme files for infrastructure in [https://gitlab.praktikum-services.ru/std-009-060/momo-infra](https://gitlab.praktikum-services.ru/std-009-060/momo-infra) repository.

# Getting Started

Repository structure:
```
├── .gitlab-ci - CI/CD manifests
├── backend - source code for backend
│   ├── Dockerfile
├── frontend - source code for frontend
│   ├── Dockerfile
│   ├── nginx-service.conf
│   ├── Dockerfile-compose
│   ├── nginx-compose.conf
├── .gitlab-ci.yml
├── docker-compose.yml - compose for local deploy/test
```

## Installation Instructions

These instructions demonstrate how to create the Momo Store App locally on your computer.

### Pre-requisites

**For Frontend:**

The Vue tooling utilizes `npm` for its set of tools to help develop Vue applications.

Before starting, make sure that the following tools are installed on your computer:

* [Node](https://nodejs.org/en/)
* [npm (Node Package Manager)](https://www.npmjs.com)

Follow the installation instructions at [https://nodejs.org/en/](https://nodejs.org/en/).

**For Backend:**

### Installation

If you would like to run the Momo Store App on your local machine, you will need to follow these instructions:

```sh
git clone git@gitlab.praktikum-services.ru:std-009-060/momo-store.git
```

**For Frontend:**

```sh
cd frontend
npm install
```

Additionally, you will need to export the `VUE_APP_API_URL` environment variable:

```sh
VUE_APP_API_URL=/api
```

**For Backend:**

```sh
cd backend
go mod download
go build -a -o /app /app/...
```

## Running the Application

**For Frontend:**

### Run Development Server (with hot-reload)

```sh
npm run dev
```

### Compile and Minify for Production

```sh
npm run build
```

**For Backend:**

```sh
go run ./cmd/api
```

# Contributing

Any contributions you make are **greatly appreciated**.

If you have a suggestion that would make this better, please fork the repo and create a merge request. You can also simply open an issue with the tag "enhancement".

1. Fork the Project
2. Create your Feature Branch (`git checkout -b feature/AmazingFeature`)
3. Commit your Changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the Branch (`git push origin feature/AmazingFeature`)
5. Open a Merge Request

# Contact

Yuriy Batkov - yb@btkv.tech

Project Link: [https://gitlab.praktikum-services.ru/std-009-060/momo-store](https://gitlab.praktikum-services.ru/std-009-060/momo-store)