# Homework Board

Homework Board is an application for tracking your homework over the course of a semester.
Homework Board lets you input your homework assignments and then helps you keep track of
those assignments. Specific features TBD (but they will be cool!).

I'm having a ton of fun with the assignment so far and I'm really excited to put in a ton of
work on it in the next week.

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

## What works right now

* PostgreSQL database is created and running
* 3 tables with functions to preform CRUD operations
* Web interface can read and display assignments from the database
* Web interface displays assignments based on their associated column
* Web interface can add new assignments to the database
* Web interface can edit existing assignments

## To be completed before project submission

* Add more properties to the assignments (due date, labels for class name)
* Organize assignments in columns by due date and priority
* Mark assignments as completed
* Apply more bootstrap and other styling to interface to make it beautiful

## Stretch goals
* Add ability to create subtasks for each assignment which the user can check off as they complete them
