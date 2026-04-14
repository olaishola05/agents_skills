---
name: Init Rails
description: Scaffold a Ruby on Rails application with best practices
tags: scaffolding, ruby, rails, ruby on rails
---

# Init Rails

Scaffold a Ruby on Rails application with Hotwire, Stimulus, and proper testing setup.

## Detection

Auto-detect version:

- **Rails 7.x**: Default
- Check `Gemfile` for Rails version

## Scaffold Template

```
project/
├── app/
│   ├── channels/
│   ├── controllers/
│   ├── components/
│   ├── helpers/
│   ├── javascript/
│   │   └── controllers/
│   ├── jobs/
│   ├── models/
│   ├── views/
│   └── mailers/
├── config/
│   ├── routes.rb
│   ├── environments/
│   └── initializers/
├── db/
│   └── migrations/
├── spec/
│   ├── requests/
│   ├── models/
│   └── controllers/
├── lib/
├── public/
├── Gemfile
├── config.ru
├── Rakefile
├── .ruby-version
└── .tool-versions
```

## Validation Steps

After scaffolding:

1. Install dependencies: `bundle install`
2. Run linter: `rubocop`
3. Run tests: `bundle exec rspec`
4. Verify database: `rails db:setup`

## Options

- `--database postgresql|mysql|sqlite`
- `--css tailwind|importmap|propshaft`
- `--test rspec|minitest`
- `--hotwire` (default: true)

## Best Practices

- Use Rails 7 with Hotwire
- Include Stimulus for interactivity
- Use Propane for CSS
- Set up RSpec for testing
- Add annotation for model documentation

## Usage

```
/init-rails
```

or:

```
/init-rails --database postgresql --css tailwind
```

## With PRD Flag

Use `--prd` to create PRD and plan before scaffolding:

```
/init-rails --prd
```

When `--prd` flag is used:

1. **Create PRD** - Use `create-prd` skill
2. **Create Plan** - Use `prd-to-plan` skill
3. **Scaffold** - Then scaffold based on the plan

## Aliases

- `/init-ruby`
- `/init-ror`