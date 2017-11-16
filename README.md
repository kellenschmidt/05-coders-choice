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
cd homework_board/apps/db/
mix deps.get
```

5. Create database
```
mix ecto.create
mix ecto.migrate
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

* PostgreSQL database is created and functions are in place to preform CRUD operations on it
* Web interface can read and display assignments from the database
* Web interface can add new assignments to the database

## To be completed before next check-in

* Add more properties to the assignments (due date, labels for class name)
* Display assignments in a more useful way to the user than just a single list
    * Organize based on due date and priority
* Add database table for classes (to be used when user assigns assignment to a class)
* Edit existing assignments
* Mark assignments as completed
* Apply bootstrap and other styling to interface to make it beautiful

## To be complered before project submission
* Allow user to organize assignments further to increase functionality
* Add ability to create subtasks for each assignment which the user can check off as they complete them
* Add further styling to the interface to make it super sleek, modern, and functional

## Questions for Prof Thomas

1. Are my frontend and backend seperated properly? Are they interacting in the way that you would hope?
2. How do I install bootstrap and sass as npm dependencies (see explanation of problem below)
3. General thoughts about implementation approach
4. Advice as I progress with the project this next week

## Problem with Bootstrap and Sass

I am attempting to use Sass in my application and install the latest bootstrap 4.0.0 beta release for use in 
styling my application, but when I try to install brunch-sass npm gives and error and will not install it.
The error occurs when npm tries to install sass-brunch and it appears that the reason npm fails to install 
sass-brunch is that it tries to download node-sass v3.8 as a dependency, however node-sass v3.8 is no longer
available for download from GitHub. The current version of node-sass is 4.6.1 and the master branch of sass-brunch
lists version 4.5.3 as a dependency, so you would think that when npm tries to install sass-brunch it would install
the dependency node-sass v4.5.3, but instead it tries to download node-sass v3.8 for a reason I do not understand.

### Steps to reproduce brunch-sass error
1. Clone repository
```
git clone https://github.com/kellenschmidt/05-coders-choice/
```

2. Move to frontend assets folder
```
cd homework_board/apps/frontend/assets/
```

3. Attempt to install brunch-sass (Error occurs here)
```
npm install sass-brunch --save-dev
```

4. Install bootstrap
```
npm install bootstrap@4.0.0-beta.2 jquery
```
