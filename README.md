# Homework Board

Homework Board is an application for tracking your homework over the course of a semester.
Homework Board lets you input your homework assignments and then helps you keep track of
those assignments. Homework Board enables you to categorize assignments and visualize due dates
and progress.

I had an absolute blast creating Homework Board and I hope you enjoy it as much as I do!

## Running project locally

1. Install PostgreSQL
```
brew install postgres
brew services start postgres
```

2. Create database user
```
createuser -s -r postgres
```

3. Clone repository
```
git clone https://github.com/kellenschmidt/05-coders-choice/
```

4. Install db dependencies
```
cd 05-coders-choice/homework_board/apps/db/
mix deps.get
```

5. Create database and initialize
```
mix ecto.create
mix ecto.migrate
mix run priv/repo/seeds.exs
```

6. Install frontend dependencies
```
cd ../frontend/
mix deps.get
cd assets/
npm install
cd ../
```

7. Start web application
```
mix phx.server
```

## Features
* PostgeSQL Database
    * Completely decoupled from the web interface.
    * Connection is spawned and monitored by a supervisor.
    * Contains three unique tables and associated schemas for assignments, columns, and labels.
    * CRUD functions implemented for each schema.
    
* Phoenix Web Interface
    * Can read and display assignments from database, organized by column, and sorted by due date.
    * Can add new assignments and edit existing assignments.
    * Can create labels, edit, and remove labels as well as attach them to assignments.
    * Can add due dates to assignments.
    * Styled beautifully with Bootstrap.

## Future goals
* Add ability to create subtasks for each assignment which the user can check off as they complete them
* Add ability to customize assignment columns
