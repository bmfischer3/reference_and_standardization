# Project Guidelines and References

Welcome to the project guidelines and references repository. This repository serves as a comprehensive guide to ensure consistency and best practices across all projects.

## Table of Contents

- [Project Guidelines and References](#project-guidelines-and-references)
  - [Table of Contents](#table-of-contents)
  - [Introduction](#introduction)
  - [Naming Conventions](#naming-conventions)
    - [Branch Naming](#branch-naming)
    - [Commit Naming Convention](#commit-naming-convention)
    - [File Naming](#file-naming)
    - [Function Naming](#function-naming)
  - [General Best Practices](#general-best-practices)
  - [Additional Resources](#additional-resources)
  - [Revision History](#revision-history)
    - [How to Update](#how-to-update)
  - [Books](#books)

## Introduction

This repository contains guidelines and references that I will be using for software development, including naming conventions, coding standards, and best practices. These guidelines are intended to promote uniformity and maintainability across my codebase, beginning July 21, 2024 and beyond. Updates to these standards are indicated by the revision log at the bottom (#revision-history). Categories and explanations within these standards seek to be as MECE (Mutually Exclusive, Collectively Exhaustive) as possible. It is understood true MECE perfection will be difficult to accomplish and flaws exist in the categorization and naming conventions as they stand today. 

## Naming Conventions

### Branch Naming
- **format/**: General template (category/topic/short-description(optional)')

Topics include: feature, bugfix, hotfix, release, chore, test.

- **feature/**: For new features, adding, refactoring, or remoing (e.g., `feature/login-authentication/`)
- **bugfix/**: For bug fixes (e.g., `bugfix/fix-login-bug`)
- **hotfix/**: For critical fixes in production (e.g., `hotfix/urgent-security-patch`)
- **release/**: For preparing a release (e.g., `release/1.0.0`)
- **chore/**: For minor tasks (e.g., `chore/update-dependencies`)
- **test/**: For experimentation 


### Commit Naming Convention

Source: dev.to (https://dev.to/varbsan/a-simplified-convention-for-naming-branches-and-commits-in-git-il4#:~:text=Branch%20Naming%20Convention&text=A%20git%20branch%20should%20start,bugfix%20%2C%20hotfix%20%2C%20or%20test%20.&text=After%20the%20category%2C%20there%20should,%2C%20just%20add%20no%2Dref%20.)

- **format/**: General format (git commit -m '<category>: action taken to accomplish xyz; secondary action to do abc; third action..... etc.)

**feature/**: For adding new features (e.g., 'git commit -m 'feature: added button to allow users to search for product; removed add_product_price function as it became redundant with introduction of shopping_cart_function'')
**fix/**: For fixing a bug (e.g., git 'commit -m 'fix: add the stop directive to button component to prevent propagation'')
**refactor/**: For modifying code for performance or convenience purpose like readability (e.g., 'git commit -m 'refactor: rewrite button component in TypeScript''
)
**chore/**: For everything else like writing documentation, formatting, adding tests, etc. (e.g., 'git commit -m 'chore: write button documentation'')



### File Naming

- Use `snake_case` for Python files (e.g., `user_profile.py`)
- Use `kebab-case` for configuration files (e.g., `webpack.config.js`)
- Use `PascalCase` for class files (e.g., `UserProfile.js`)

### Function Naming

- Use `camelCase` for function names (e.g., `fetchUserData`)
- Prefix asynchronous functions with `async` (e.g., `asyncFetchUserData`)
- Use descriptive names that indicate the function's purpose

## General Best Practices

- Follow coding standards and guidelines specific to the language or framework you are using.
- Write clean, readable, and maintainable code. Create documentation and provide meaningful comments. Error on the side of too much commentary. 
- Ensure your code is tested and follows TDD (Test-Driven Development) principles when possible.
- Conduct regular code reviews and seek feedback from peers.
- For folders, files, etc. on your local machine, lowercase everything, no spaces, and use underscores and dashes as necessary for readability. 

## Additional Resources

- [GitHub Flow](https://guides.github.com/introduction/flow/)
- [Creating a new repository](https://docs.github.com/en/github/creating-cloning-and-archiving-repositories/creating-a-new-repository)
- [PEP 8 - Style Guide for Python Code](https://peps.python.org/pep-0008/)
- [Google Style Guides](https://github.com/google/styleguide)


## Revision History

This section documents the history of changes made to the repository, including updates to guidelines, naming conventions, and best practices.

| Date       | Version | Author       | Description                                           |
|------------|---------|--------------|-------------------------------------------------------|
| 2024-07-21 | 1.0.0   | B. Fischer   | Initial creation of the repository and documentation. |
| YYYY-MM-DD | X.X.X   | Your Name    | Description of the changes made.                      |
| YYYY-MM-DD | X.X.X   | Your Name    | Description of the changes made.                      |


### How to Update

1. Add a new row to the table above for each update.
2. Increment the version number following semantic versioning (e.g., 1.0.1 for a small change, 1.1.0 for a new feature, 2.0.0 for a major update).
3. Include the date of the update, the author who made the change, and a brief description of what was updated.


## Books
Below is a list of books I have read or am reading along my python journey. 

1. Automate the Boring Stuff with Python (https://automatetheboringstuff.com/)
2. Essential Math for Data Science (https://www.amazon.com/Essential-Math-Data-Science-Fundamental/dp/1098102932)
3. Football Analytics with Python & R (https://www.amazon.com/Football-Analytics-Python-Learning-Science/dp/1492099627/)
4. 

