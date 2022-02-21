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
  2. Choose the gems I need and create a new rails project.
  3. Add and modify this Readme file
  4. Add/set Gems I want to use:
    Todo's:
      - [x] reek => https://github.com/troessner/reek
      - [] rspec-rails => https://github.com/rspec/rspec-rails
      - [] rubocop => https://github.com/rubocop/rubocop
      - [] rubocop-rails => https://github.com/rubocop/rubocop-rails
      - [] rubocop-rspec => https://github.com/rubocop/rubocop-rspec
      - [] guard => https://github.com/guard/guard
      - [] guard-rspec => https://github.com/guard/guard-rspec
      - [] guard-rubocop => https://github.com/guard/guard-rubocop
      - [] shoulda-matchers => https://github.com/thoughtbot/shoulda-matchers
  5. Add the model with respective columns/parameters.
    - add belongs to and has many.
    - add subject reference
    - add model validations

</details>
<br>

<details>
<summary> Code (Algorithm implementation):</details>

<br>