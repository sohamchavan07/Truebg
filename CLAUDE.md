# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Commands

### Development
To working on this Rails application:

```bash
# Install dependencies
bundle install

# Run database migrations
rails db:migrate

# Run database in server mode
rails db:migrate RAILS_ENV=development

# Start the server
rails server # http://localhost:3000

# Run tests
rails test

# Run RSpec tests
bundle exec rspec bootstrap_spec

# Generate database seed data
rails db:seed

# Create admin user (for development)
rails console `RAILS_ENV=development` <<< $'User.create(admin: true, email: "admin@example.com", password: "WelcomeToDoIt", password_confirmation: "WelcomeToDoIt", confirmed_at: Time.now)'

# Run specific test
rails test NAME_1       # Replace NAME_1 with test name
```

### Key Commands
- **Run server**: `rails server` (access at http://localhost:3000)
- **Run tests**: `rails test` or `bundle exec rspec`
- **Database reset**: `rails db:drop db:create db:migrate db:seed`
- **Environment setup**: Check `.env` files and `.env.example`

## Architecture

### High-Level Structure
This is a Ruby on Rails 8.0+ application following a domain-driven architecture with Rails conventions.

#### Key Components:
1. **Models**: 
   - `Organization` - Companies/organizations candidates apply to
   - `Candidate` - Job seekers who verify their profile
   - `Admin` - System administrators managing verifications
   - `Verification` - Core verification engine handling candidate data
   - `VerificationCase` - Background verification processes
   - `EducationHistory`/`WorkHistory` - Supporting documentation

2. **Controllers**:
   - `API::Application` - Base API controller with Pundit authorization
   - Admin::Controllers: Dashboard, Organizations, VerificationCases
   - Candidates::Controllers: Authentication flows and verification management
   - Verifications::Controllers: Primary verification flows

3. **Key Flows**:
   - Candidate registration & authentication (Devise-based)
   - Admin dashboard for managing candidates and cases
   - Verification flows including OTP-based phone verification
   - Profile review and submission processes

4. **Verification Entry Point**:
   - `/v/:token` routes to `Verifications#start` for token-based access
   - Mobile verification flows with OTP validation
   - Multi-step profile validation system

5. **Security & Authorization**:
   - Pundit for authorization control (`AuthorizationService`)
   - ActiveRecord models with structured associations
   - Strong parameters and validation layers
   - Twilio integration for SMS verification

6. **Frontend Technology**:
   - Import maps with Turbo-Rails for SPA-like experience
   - Stimulus for JavaScript behavior
   - TailwindCSS for styling
   - WickedPDF for PDF generation

## Common Development Tasks

### Database Operations
```bash
# Database reset
rails db:reset

# Environment-specific DB operations
rails db:drop db:create db:migrate db:seed RAILS_ENV=development

# Add test data
rails db:seed:admin
```

### Testing & Quality
```bash
# Run all tests
rails test

# Run specific test file
rails test `spec/models/candidate_spec.rb`

# Run RSpec suite
bundle exec rspec

# Run Rubocop for linting
bundle exec rubocop --auto-correct

# Run Brakeman for security scanning
bundle exec brakeman --config config/brakeman.yml
```

### Development Environment Setup
```bash
# Create admin user
rails console <<< 'User.create(admin: true, email: "admin@example.com", password: "WelcomeToDoIt")'

# Configure environment variables
# Check .env.example for required vars
```

## Notable Features
1. **Verification System**: Token-based verification process for candidates
2. **Admin Dashboard**: Comprehensive management interface for organizations and verifications
3. **Multi-step Verification**: Sequential profile validation with work/education history
4. **Mobile-friendly**: OTP-based phone verification flow
5. **PDF Export**: WickedPDF integration for verification documents
6. **Authorization**: Pundit-based permissions system with `AuthorizationService`

## Troubleshooting
- **Common issues**: Database connection problems, missing environment variables, proxy conflicts
- **When stuck**: Check logs (`log/development.log`), check Rails console (`rails console`); verify database/migration status
- **Dependencies**: Ruby >= 3.2, Node.js >= 18, Yarn (for frontend packages)

## Project Dependencies
- **Core**: Ruby on Rails 8.0+, PostgreSQL 15+, Redis (optional)
- **Testing**: RSpec 6.x, FactoryBot, Shoulda-matchers
- **Authentication**: Devise 5.x
- **Security**: Brakeman, RuboCop, OWASP dependencies
- **Frontend**: Import Maps, Turbo Rails, Stimulus, TailwindCSS

Let me know when you need to search for specific functionality or need help with a particular aspect of the verification system.