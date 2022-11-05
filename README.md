# README

## CVMAKER

Ruby on Rails app for creating a CV/resume. The application has a simple interface that guides you through all the steps of creating a CV/resume and allows you to freely arrange individual sections and deeply customise them. The creation process is completed by downloading the finished document in PDF format.

The 0.1-a version allows for usage of only one style.

Author: Weronika Piotrowska
Copyright: Copyright (c) 2022 Weronika Piotrowska

## Prerequisites

- Ruby version: 2.7.2
- Postgresql > 9.0
- Yarn > 1.22.19
- Node.js > 14.14.0

## Configuration

- Install the required gems:

```
$ bundle install
```

- Install yarn packages:

```
$ yarn install --check-files
```

- Set the `DB_DEV_USERNAME` and `DB_DEV_PASSWORD` env variables in `.env` to your
PostgreSQL user credentials.

- Setup the database:

```
$ rake db:setup
```

- Start the server:
```
$ rails s
```

## Environment variables

* DB_DEV_USERNAME - PostgreSQL user's name for development and test environments.
* DB_DEV_PASSWORD - PostgreSQL user's password for development and test environments.
* DOMAIN - default domain in e-mails.
* ACCESS_KEY_ID - AWS access key ID.
* SECRET_ACCESS_KEY - AWS secret access key.
* AWS_REGION - AWS region code, e.g. us-east-1.
* AWS_BUCKET - AWS S3 bucket name.

In order to set the environment variables for the development environment, you should
create a file `.env` in the main project directory (it should be listed in `.gitignore`)
and set them there like this:

```
ENV_VARIABLE_NAME=value
```
