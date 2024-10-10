# Expense-claims

This is a Ruby on Rails application that can be run in two ways: using the classic method or in a Docker environment. Follow the instructions below to get started.

## Prerequisites

- Ruby (version 3.1 or as specified in your Gemfile)
- Rails (version 7 or as specified in your Gemfile)
- PostgreSQL installed on your machine (for the classic method)
- Docker installed on your machine (for the Docker method)
- Docker Compose installed (comes with Docker Desktop)

## Setting Up Environment Variables

Before running the project, create a file named `.env` in the root directory of your project with the following content:

```env
DATABASE_USER=your_user
DATABASE_PASSWORD=your_password
POSTGRES_DB=your_db_name
```

## Running the Project
### **`Option 1: Classic Method using bin/dev`**
### Install Dependencies
- bundle install
- yarn install
### Set Up the Database
- bin/rails db:create db:migrate db:seed
### Start the Application
- bin/dev

### **`Option 2: Running with Docker`**
- docker compose build
- docker compose up
- docker compose run web rake db:create db:migrate
- Access the Application
- http://localhost:3000

## Test

**`bundle exec rspec`**