# Truebg - Candidate Verification Platform

A Ruby on Rails 8.0+ application for managing candidate verification and background checks. Built with a domain-driven architecture, this platform enables organizations to verify candidate profiles and conduct comprehensive background verification processes.

## Table of Contents

- [Overview](#overview)
- [System Requirements](#system-requirements)
- [Installation](#installation)
- [Configuration](#configuration)
- [Database Setup](#database-setup)
- [Running the Application](#running-the-application)
- [Testing](#testing)
- [Architecture](#architecture)
- [Key Features](#key-features)
- [Common Development Tasks](#common-development-tasks)
- [Troubleshooting](#troubleshooting)
- [Technology Stack](#technology-stack)

## Overview

Truebg is a comprehensive verification platform designed to:
- Manage candidate registration and authentication
- Handle admin dashboard operations for verification management
- Process multi-step profile verification workflows
- Integrate SMS-based OTP verification via Twilio
- Generate verification documents with PDF export capabilities
- Enforce role-based access control with Pundit authorization

## System Requirements

- **Ruby**: >= 3.2
- **Rails**: 8.0+
- **PostgreSQL**: 15+
- **Node.js**: >= 18
- **Yarn**: Latest version
- **Redis**: Optional (for caching and job queues)

## Installation

### 1. Clone the Repository

```bash
git clone https://github.com/sohamchavan07/Truebg.git
cd Truebg
```

### 2. Install Dependencies

```bash
# Install Ruby dependencies
bundle install

# Install Node/Yarn dependencies
yarn install
# or
npm install
```

### 3. Environment Configuration

Copy the example environment file and configure it:

```bash
cp .env.example .env
```

Edit `.env` with your configuration:
- Database credentials
- Twilio API keys (for SMS verification)
- Email service configuration
- Other API keys and secrets

## Database Setup

### Create Database

```bash
# Create database and run migrations
rails db:create
rails db:migrate

# Load seed data (optional)
rails db:seed
```

### Database Reset (if needed)

```bash
rails db:drop db:create db:migrate db:seed
```

### Create Admin User (Development)

```bash
# Using Rails console
rails console <<< 'User.create(admin: true, email: "admin@example.com", password: "WelcomeToDoIt", password_confirmation: "WelcomeToDoIt", confirmed_at: Time.now)'

# Or use the provided seed task
rails db:seed:admin
```

## Running the Application

### Start the Development Server

```bash
rails server
# Access at http://localhost:3000
```

### Start with Custom Port

```bash
rails server -p 3001
```

## Testing

### Run All Tests

```bash
rails test
```

### Run RSpec Tests

```bash
bundle exec rspec
bundle exec rspec bootstrap_spec
```

### Run Specific Test

```bash
rails test NAME_1       # Replace NAME_1 with your test name
rails test spec/models/candidate_spec.rb
```

### Code Quality & Security

```bash
# Run RuboCop for linting
bundle exec rubocop --auto-correct

# Run Brakeman for security scanning
bundle exec brakeman --config config/brakeman.yml
```

## Architecture

### High-Level Structure

This application follows Rails conventions with a domain-driven design:

#### Key Models

- **Organization** - Companies/organizations that hire candidates
- **Candidate** - Job seekers who undergo profile verification
- **Admin** - System administrators managing verifications
- **Verification** - Core verification engine handling candidate data
- **VerificationCase** - Background verification processes
- **EducationHistory** - Candidate education records
- **WorkHistory** - Candidate work experience records

#### Key Controllers

- **API::Application** - Base API controller with Pundit authorization
- **Admin::Controllers** - Dashboard, Organizations, VerificationCases
- **Candidates::Controllers** - Authentication and verification management
- **Verifications::Controllers** - Primary verification workflows

#### Verification Flow

1. **Entry Point**: `/v/:token` routes to `Verifications#start` for token-based access
2. **Mobile Verification**: OTP-based phone verification flow
3. **Multi-step Validation**: Sequential profile validation with supporting documentation
4. **Submission & Review**: Final submission and admin review

### Security & Authorization

- **Pundit** for authorization control via `AuthorizationService`
- **Devise** for user authentication
- **Strong Parameters** for request validation
- **Twilio Integration** for SMS verification
- **ActiveRecord** with structured associations

### Frontend Stack

- **Import Maps** with Turbo-Rails for SPA-like experience
- **Stimulus** for JavaScript behavior
- **TailwindCSS** for responsive styling
- **WickedPDF** for PDF document generation

## Key Features

1. **Token-Based Verification** - Secure verification links with token authentication
2. **Multi-Step Verification** - Sequential profile validation workflow
3. **OTP Phone Verification** - SMS-based one-time password verification via Twilio
4. **Admin Dashboard** - Comprehensive management interface for organizations and cases
5. **PDF Export** - Generate and export verification documents
6. **Role-Based Access** - Pundit-based permissions system
7. **Mobile-Friendly** - Responsive design for mobile verification flows
8. **Work & Education History** - Document and verify professional background

## Common Development Tasks

### Database Operations

```bash
# View database status
rails db:migrate:status

# Rollback last migration
rails db:rollback

# Drop and recreate everything
rails db:reset
```

### Generate New Migrations

```bash
rails generate migration AddFieldToTable field_name:type
```

### Console Debugging

```bash
rails console
# Then in console:
# User.all
# Candidate.find(1)
# etc.
```

### Running Seeds with Specific Data

```bash
rails db:seed
# or define custom seed tasks in db/seeds.rb
```

## Troubleshooting

### Database Connection Issues

```bash
# Check database status
rails db:version

# Verify PostgreSQL is running
psql -V

# Reset everything
rails db:drop db:create db:migrate db:seed
```

### Missing Environment Variables

```bash
# Verify all required variables are set
cat .env

# Check .env.example for reference
cat .env.example
```

### Common Solutions

- **Port Already in Use**: Change port with `rails server -p XXXX`
- **Gems Not Installing**: Clear bundle cache: `bundle cache --no-prune`
- **Database Locked**: Kill lingering processes and reset: `rails db:drop db:create`
- **Migrations Failing**: Check migration files in `db/migrate/`
- **Assets Not Loading**: Run `rails assets:precompile`

### Debug Mode

```bash
# View application logs
tail -f log/development.log

# Enable SQL logging
# Add in config/environments/development.rb:
# config.logger = Logger.new(STDOUT)
```

## Technology Stack

### Backend
- Ruby on Rails 8.0+
- PostgreSQL 15+
- Redis (optional)
- Devise 5.x (authentication)
- Pundit (authorization)
- WickedPDF (PDF generation)

### Testing
- RSpec 6.x
- FactoryBot
- Shoulda-matchers

### Frontend
- Stimulus JS
- Turbo Rails
- TailwindCSS
- Import Maps

### Security & Code Quality
- Brakeman (security scanning)
- RuboCop (linting)
- OWASP dependencies

### Integrations
- Twilio (SMS verification)
- Email services (configurable)

## Deployment

### Heroku Deployment

```bash
# Add Heroku remote
heroku create your-app-name

# Push to Heroku
git push heroku main

# Run migrations on production
heroku run rails db:migrate

# View logs
heroku logs --tail
```

### Environment Variables for Production

Ensure all environment variables from `.env.example` are set in your production environment:

```bash
heroku config:set KEY=value
```

## Contributing

1. Create a feature branch: `git checkout -b feature/your-feature`
2. Commit your changes: `git commit -am 'Add feature'`
3. Push to branch: `git push origin feature/your-feature`
4. Submit a Pull Request

## License

This project is proprietary. All rights reserved.

## Support

For issues, questions, or support:
1. Check the [Troubleshooting](#troubleshooting) section
2. Review application logs in `log/development.log`
3. Use Rails console for debugging: `rails console`
4. Contact the development team

---

**Last Updated**: 2026-06-25
**Version**: Rails 8.0+
**Repository**: https://github.com/sohamchavan07/Truebg
