# Website Age Checker
[![Website Age Checker Workflow](https://github.com/tamecalm/website-age-checker/actions/workflows/deploy.yml/badge.svg?branch=main)](https://github.com/tamecalm/website-age-checker/actions/workflows/deploy.yml)

The **Website Age Checker** is a Bash script that retrieves the age and registration details of a specified website. It outputs the information in a well-formatted HTML file, making it easy to read and understand.

## Features

- Prompts the user to input a website domain.
- Retrieves the creation date, expiration date, and status of the domain using the `whois` command.
- Calculates the age of the website in years, months, and days.
- Generates a nicely formatted HTML document containing all relevant information.
- Provides a clickable link to the author's Instagram profile.

## Prerequisites

- A Unix-like operating system (Linux, macOS, Termux)
- Bash shell
- `whois` command line tool
- [Node.js](https://nodejs.org/en/download/) (version X.X.X or later)
- [npm](https://www.npmjs.com/get-npm) (comes with Node.js)

## Installation

1. Clone the repository to your local machine:
   ```bash
   git clone https://github.com/YOUR_USERNAME/website-age-checker.git
   cd website-age-checker
