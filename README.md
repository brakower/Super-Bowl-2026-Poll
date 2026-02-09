# Super Bowl Poll Application

A full-stack Ruby on Rails web application for conducting Super Bowl team polls with real-time voting and result visualization. Built with modern web technologies and production-ready practices.

## 🎯 Project Overview

This application demonstrates a complete end-to-end implementation of a voting system with emphasis on:
- **Clean Architecture**: Service objects, organized controllers, and clear separation of concerns
- **Security**: Voter identity hashing, duplicate vote prevention, and vulnerability scanning
- **Modern Rails Stack**: Rails 7.2, Hotwire (Turbo & Stimulus), Importmap, and Dart SASS
- **CI/CD**: Automated testing, linting, and security scanning via GitHub Actions
- **Production Ready**: Docker containerization, health checks, and proper configuration management

## 🛠 Technical Stack

**Backend:**
- Ruby on Rails 7.2.3
- SQLite3 (development) / PostgreSQL-ready architecture
- Service Objects pattern for business logic
- RESTful API design

**Frontend:**
- Hotwire (Turbo Rails & Stimulus.js) for SPA-like interactivity
- Dart SASS for styling
- Importmap for JavaScript dependencies
- Progressive Web App (PWA) capabilities

**DevOps & Quality:**
- Docker & Docker Compose
- GitHub Actions CI/CD pipeline
- RSpec for testing
- Brakeman for security scanning
- RuboCop for code linting

## 🏗 Architecture Highlights

### Service Layer
The `VoteManager` service encapsulates all voting business logic:
- Vote casting with duplicate prevention
- Vote modification capabilities
- Voter anonymization via SHA-256 hashing
- Comprehensive result aggregation

### Data Model
```ruby
Team
├─ has_many :votes (with counter_cache for performance)
└─ validates uniqueness of team names

Vote
├─ belongs_to :team
└─ validates uniqueness of voter_hash (prevents duplicate voting)
```

### API Design
- RESTful endpoints for voting and results
- Clean separation between web UI and API controllers
- Proper HTTP status codes and JSON responses

## 🚀 Getting Started

### Prerequisites
- Ruby 3.3+ (see [.ruby-version](.ruby-version))
- Node.js (for asset compilation)
- Docker (optional, for containerized development)

### Local Setup

1. **Clone and install dependencies:**
```bash
git clone https://github.com/brakower/superbowl_poll.git
cd superbowl_poll
bundle install
```

2. **Setup database:**
```bash
rails db:create db:migrate db:seed
```

3. **Start the development server:**
```bash
bin/dev
```

Visit `http://localhost:3000` to see the application.

### Docker Setup

```bash
docker-compose up
```

The application will be available at `http://localhost:3000`.

## 🧪 Testing

Run the test suite:
```bash
bundle exec rspec
```

Run security scans:
```bash
bin/brakeman
bin/importmap audit
```

Run code linting:
```bash
bin/rubocop
```

## 📋 Key Features

1. **Vote Casting**: Users can vote for their favorite team with duplicate prevention
2. **Vote Modification**: Voters can change their vote
3. **Real-time Results**: Live vote counts and percentages
4. **Admin Controls**: Reset functionality for new polls
5. **API Access**: JSON API for integration with other services
6. **Security**: 
   - Voter identity hashing (SHA-256)
   - CSRF protection
   - Security vulnerability scanning
   - Content Security Policy

## 🔄 CI/CD Pipeline

The GitHub Actions workflow includes:
- **Security Scanning**: Brakeman for Rails vulnerabilities
- **Dependency Auditing**: JavaScript and Ruby dependency checks
- **Code Linting**: RuboCop for style enforcement
- **Automated Testing**: RSpec test suite
- **Multi-environment Support**: Separate jobs for different scan types

## 📁 Project Structure

```
app/
├── controllers/
│   ├── api/              # API endpoints
│   ├── polls_controller.rb
│   └── votes_controller.rb
├── models/
│   ├── team.rb
│   └── vote.rb
├── services/
│   └── vote_manager.rb   # Business logic encapsulation
└── views/
    └── polls/

config/
├── routes.rb             # RESTful routing
└── environments/         # Environment-specific configs

.github/
└── workflows/
    └── ci.yml            # CI/CD pipeline
```

## 🎓 Learning Outcomes

This project demonstrates proficiency in:
- Ruby on Rails best practices and conventions
- Service-oriented architecture
- Test-driven development (TDD)
- CI/CD pipeline implementation
- Docker containerization
- Security-first development
- Modern frontend patterns with Hotwire
- RESTful API design
- Database modeling and optimization (counter_cache)

## 📝 Configuration

- **Database**: Configure in [config/database.yml](config/database.yml)
- **Routes**: Defined in [config/routes.rb](config/routes.rb)
- **Environment Variables**: Use `.env` files (see `.env.example` if available)

## 🔐 Security Considerations

- Voter anonymization using SHA-256 hashing
- No personally identifiable information stored
- CSRF protection enabled
- Content Security Policy configured
- Regular dependency vulnerability scanning
- Static code analysis with Brakeman

## 📄 License

This project is available as open source under the terms of the MIT License.

---

**Author**: Benny Rakower  
**Repository**: https://github.com/brakower/superbowl_poll
