## Workpath

### Evolgo
*(OKRs API)

**Versions:**
Rails 6.1
Ruby 3.0

**Installation**
`bundle`

**Test:**
`bundle exec rspec`

**Rails server \*testing:**
`rails s`
`http://localhost:3000/`


**Events handler:**
`guard`


Process with **PEDAC:**
<details>
<summary> Problem understanding:</summary>
  <br>

  - **Problem Domain:**
    none so far
  - **Mental Model:**
      create a RESTful application with endpoints based on the 3 stories:
    - User can create a goal
    - User create key-results associated with a goal to track progress of it.
    - As user I want to get the list of my goals and see my progress.
  - **Input:**
      User, Goal, Key-Result database and endpoints
  - **Output:**
      Data answering the story-endpoints User, goal, key-result, progress
  - **Requirements:**
    - It should be an API *Only(No front-end and only endpoints)
  - **Rules:**
    - Implicit:
      - follow standards and guidelines as a production level code (Good practices, testing, Production databse as PostgreSQL).
    - Explicit:
      - None so far
  - **Questions:**
    - Probably is as easy as possible solution, in any case I think is good to ask if the user should be created with a password and we should add some Token-based Authentication.
    For now I will start it whithout as is not specified and I think it will be ok to implemented later on.

    - About the model associations.
      In my understanding:
      - User has many goals
      - Goals belong to user
      - User can Create a Key-Result
      - Key-Result belongs to Goal
      - Goal has many Key-Results
        User can Create a Key-Result **But(implicitly in my logic) it should be though Goal, right?
        So it should be:
        We create a User, the User Create a Goals, from a Goal we create Key-Objectives
        So, in my understanding, the user should assign the goal id to create a key-result. Do I am missing something?

  Answer:
  1. User authentication is not required. But, it would be a great addition. You can implement any approach that you feel better.
  2. You are right about the model association.

</details>
<br>

<details>–
<summary>Examples/test cases:</summary>

- Story 1:
  As a user I want to create a Goal.
  Acceptance criteria:
  ● A user can create a goal
  ● A goal has an owner (user who created it by default)
  ● A goal has a title. For an e.g., “Grow our engineering team”
  ● A goal has a start date
  ● A goal has an end date

- Story 2:
  A a user I want to create “Key Results”, associated with a goal, to track the progress of my goal
  Acceptance criteria:
  ● A user can create a key result
  ● A key result has a title. For an e.g., “Hire 1 Backend Engineers”
  ● A key result has a status. The status is either “not started”, “in progress”, or
  “completed”.
  ● A Key Result always belongs to a goal
  ● A goal has many key results

- Story 3:
  A a user I want to get the list of all goals that are owned by me
  Acceptance criteria:
  ● A user can view all goals they created
  ● The information about goal includes:
  ○ Title of the goal
  ○ Start date of the goal
  ○ End date of the goal
  ○ Progress of the goal
  ● The progress of a goal is decided by the status of its key results.
  ○ It is the ratio of total number of key results with completed status divided by the
  total number of key results
  ○ For examples,
  ■ If a goal has 2 key results and both are “completed” the progress is 100%
  ■ If a goal has 2 key results and 1 is “completed” the progress is 50%
  ■ If a goal has 2 key results and none of them are completed the progress
  is 0 %

  ○ The progress is also considered zero percent, if a goal does not have any key
  result associated with it.
</details>
<br>

<details>
<summary>Data structure *(how we will represent the data)</summary>
  ~PostgreSQL~, relations
</details>
<br>

<details>
<summary>Algorithm (steps)</summary>

  1. Take my time to read and reasoning, resuming the key points, create the mental model, examples, input, output, requirements, rules and ask for questions(1hr aprox).
  2. Choose the gems I need and create a new rails project:
  `rails new okrs_evolgo -T -d postgresql`
    -T `--database=postgresql` or `-d postgresql`
    -T (don't include minitest)
    --database=postgresql (use postgresql database)
  3. Add and modify this Readme file
  4. Add/set Gems/DB I want to use:
    Todo's:
      - [x]  pg (PostgreSQL) =>  https://github.com/ged/ruby-pg
      - [x] reek => https://github.com/troessner/reek
      - [x] rspec-rails => https://github.com/rspec/rspec-rails
      - [x] rubocop => https://github.com/rubocop/rubocop
      - [x] rubocop-rails => https://github.com/rubocop/rubocop-rails
      - [x] rubocop-rspec => https://github.com/rubocop/rubocop-rspec
      - [x] guard => https://github.com/guard/guard
      - [x] guard-rspec => https://github.com/guard/guard-rspec
      - [x] guard-rubocop => https://github.com/guard/guard-rubocop
      - [x] shoulda-matchers => https://github.com/thoughtbot/shoulda-matchers
      Add Rubocop autogen config*
      `rubocop --auto-gen-config`
  5. Define the model with respective columns/parameters and associations.
      - User has goals
      - Goals belong to User
      - User can Create a Key-Result
      - Key-Result belongs to Goal
      - Goal has many Key-Results

      User params
        - owner *(*=presence true)
      Goal params
        - user_id (foreign_key) *
        - title *
        - star_date
        - end_date
      KeyResult params
        - goal_id (foreign_key) *
        - user_id (foreign_key) *
        - title *
        - status (default zero to change it 'not started' via key-value)*
  6. Create models/associations via TDD
    `rails g model User owner:string`
    `rails g model Goal user:references title:string start_date:datetime end_date:datetime`
    `rails g model KeyResult user:references goal:references title:string status:float`
    Adding , :default => 0 in (status)
    **( I decided to use float instead integer for future percentage)
  7. Create validations via TDD, make all tests green and fix rubocop offensess.

  8. Add the specific controllers
    `rails g controller Users`
    `rails g controller Goals`
    `rails g controller KeyResults`

  9. Add example cases as tests, and make it all green adding specific methods and testing the model.
    - ** pending: fix rubocop offenses from instance variables in RSpec

  10. ** Add the RESTful routes and controller actions

  11. ** Add jwt authentication for user?
    ``

</details>
<br>
<details>
<summary> Code (Algorithm implementation):</details>

<br>