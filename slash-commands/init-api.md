---
name: Init API
description: Scaffold a backend API project with repository pattern and services
tags: scaffolding, backend, api, nestjs, express, fastapi, django, golang, repository, services
---

# Init API

Scaffold a backend API project with repository pattern, services, and best practices.

## Detection

Auto-detect the appropriate API framework based on project dependencies:

- **NestJS**: If `package.json` contains `@nestjs/core`
- **Express**: If `package.json` contains `express`
- **Fastify**: If `package.json` contains `fastify`
- **Go**: If `go.mod` exists
- **FastAPI**: If `pyproject.toml` or `requirements.txt` contains `fastapi`
- **Django**: If `requirements.txt` contains `django`

If no dependencies detected, prompt user to choose.

## Folder Structure (Layered Architecture)

```
src/
├── config/              # App configuration (env, constants)
├── models/              # Database entities/tables
├── repositories/       # Data access (one file per entity)
│   └── user.repository.ts
├── services/           # Business logic
├── controllers/       # HTTP handlers (routes)
├── dtos/              # Request/Response objects
├── middleware/        # Custom middleware (auth, logging)
└── main.ts            # Entry point
```
src/
├── config/              # App configuration (env, constants)
├── models/              # Database entities/tables
├── repositories/
│   ├── interfaces/     # Repository interfaces (abstractions)
│   │   └── user.repository.interface.ts
│   ├── implementations/ # ORM-specific implementations
│   │   ├── prisma/
│   │   ├── drizzle/
│   │   └── typeorm/
├── services/           # Business logic (depends on interface only)
├── controllers/       # HTTP handlers (routes)
├── dtos/              # Request/Response objects
├── middleware/        # Custom middleware (auth, logging)
└── main.ts            # Entry point
```

## Scaffold Templates

### For NestJS/Express/Fastify (Node.js)

```
project/
├── src/
│   ├── config/
│   │   ├── database.config.ts
│   │   └── app.config.ts
│   ├── models/
│   │   ├── user.model.ts
│   │   └── index.ts
│   ├── repositories/
│   │   ├── user.repository.ts
│   │   ├── post.repository.ts
│   │   └── index.ts
│   ├── services/
│   │   ├── user.service.ts
│   │   └── index.ts
│   ├── controllers/
│   │   ├── user.controller.ts
│   │   └── index.ts
│   ├── dtos/
│   │   ├── create-user.dto.ts
│   │   ├── update-user.dto.ts
│   │   ├── user-response.dto.ts
│   │   └── index.ts
│   ├── middleware/
│   │   ├── error-handler.middleware.ts
│   │   ├── auth.middleware.ts
│   │   ├── logger.middleware.ts
│   │   └── index.ts
│   ├── main.ts
│   ├── app.module.ts (NestJS)
│   └── app.ts (Express/Fastify)
├── test/
│   ├── user.service.spec.ts
│   ├── user.controller.spec.ts
│   └── user.repository.spec.ts
├── docker-compose.yml
├── Dockerfile
├── package.json
├── tsconfig.json
├── nest-cli.json (NestJS)
├── vitest.config.ts
├── .eslintrc.json
└── .env.example
```

### For Go (Golang)

```
project/
├── src/
│   ├── config/
│   │   ├── config.go
│   │   └── database.go
│   ├── models/
│   │   ├── user.go
│   │   └── index.go
│   ├── repositories/
│   │   ├── user_repository.go
│   │   └── index.go
│   ├── services/
│   │   ├── user_service.go
│   │   └── index.go
│   ├── controllers/
│   │   ├── user_controller.go
│   │   └── index.go
│   ├── dtos/
│   │   ├── create_user.go
│   │   ├── user_response.go
│   │   └── index.go
│   ├── middleware/
│   │   ├── error_handler.go
│   │   ├── auth.go
│   │   └── logger.go
│   └── main.go
├── test/
│   ├── user_service_test.go
│   ├── user_repository_test.go
├── docker-compose.yml
├── Dockerfile
├── go.mod
├── go.sum
└── .env.example
```
project/
├── src/
│   ├── config/
│   │   ├── config.go
│   │   └── database.go
│   ├── models/
│   │   ├── user.go
│   │   └── index.go
│   ├── repositories/
│   │   ├── interfaces/
│   │   │   ├── user_repository.go
│   │   │   └── index.go
│   │   ├── implementations/
│   │   │   ├── gorm/
│   │   │   │   └── user_repository.go
│   │   │   └── index.go
│   │   └── index.go
│   ├── services/
│   │   ├── user_service.go
│   │   └── index.go
│   ├── controllers/
│   │   ├── user_controller.go
│   │   └── index.go
│   ├── dtos/
│   │   ├── create_user.go
│   │   ├── user_response.go
│   │   └── index.go
│   ├── middleware/
│   │   ├── error_handler.go
│   │   ├── auth.go
│   │   └── logger.go
│   └── main.go
├── test/
│   ├── user_service_test.go
│   └── user_repository_test.go
├── docker-compose.yml
├── Dockerfile
├── go.mod
├── go.sum
└── .env.example
```

### For FastAPI (Python)

```
project/
├── src/
│   ├── config/
│   │   ├── config.py
│   │   └── database.py
│   ├── models/
│   │   ├── user.py
│   │   └── __init__.py
│   ├── repositories/
│   │   ├── user_repository.py
│   │   ├── post_repository.py
│   │   └── __init__.py
│   ├── services/
│   │   ├── user_service.py
│   │   └── __init__.py
│   ├── controllers/
│   │   ├── user_controller.py
│   │   └── __init__.py
│   ├── dtos/
│   │   ├── create_user.py
│   │   ├── update_user.py
│   │   ├── user_response.py
│   │   └── __init__.py
│   ├── middleware/
│   │   ├── error_handler.py
│   │   ├── auth.py
│   │   ├── logger.py
│   │   └── __init__.py
│   ├── main.py
│   └── database.py
├── test/
│   ├── test_user_service.py
│   └── test_user_repository.py
├── docker-compose.yml
├── Dockerfile
├── pyproject.toml
├── requirements.txt
└── .env.example
```

### For Django (Python)

```
project/
├── src/
│   ├── config/
│   │   ├── settings.py
│   │   └── database.py
│   ├── models/
│   │   ├── user.py
│   │   └── __init__.py
│   ├── repositories/
│   │   ├── user_repository.py
│   │   └── __init__.py
│   ├── services/
│   │   ├── user_service.py
│   │   └── __init__.py
│   ├── views/
│   │   ├── user_view.py
│   │   └── __init__.py
│   ├── dtos/
│   │   ├── create_user.py
│   │   ├── user_response.py
│   │   └── __init__.py
│   ├── middleware/
│   │   ├── error_handler.py
│   │   ├── auth.py
│   │   ├── logger.py
│   │   └── __init__.py
│   ├── urls.py
│   └── asgi.py
├── test/
│   ├── test_user_service.py
│   └── test_user_repository.py
├── docker-compose.yml
├── Dockerfile
├── manage.py
├── pyproject.toml
├── requirements.txt
└── .env.example
```

## Repository Pattern (Simple Switch)

One file per repository with **simple ORM switch** - change import at top to swap ORM.

### Repository File

```typescript
// src/repositories/user.repository.ts

// === ORM SWITCH: Change this import to switch ORM ===
import { PrismaClient } from '@prisma/client';
// import { DrizzleClient } from '@/database';    // Uncomment for Drizzle
// import { DataSource } from 'typeorm';   // Uncomment for TypeORM
// =============================================

// === ORM SWITCH: Change this class to switch ORM ===
export class UserRepository {
  constructor(private readonly prisma: PrismaClient) {}
  // constructor(private readonly db: DrizzleClient) {}  // For Drizzle
  // constructor(private readonly dataSource: DataSource) {}  // For TypeORM
  // =============================================

  async findById(id: string): Promise<User | null> {
    return this.prisma.user.findUnique({ where: { id } });
    // return this.db.query.users.findFirst(...)  // For Drizzle
    // return this.dataSource.getRepository(User).findOne(id)  // For TypeORM
  }

  async findByEmail(email: string): Promise<User | null> {
    return this.prisma.user.findUnique({ where: { email } });
  }

  async findAll(): Promise<User[]> {
    return this.prisma.user.findMany();
  }

  async create(data: CreateUserDTO): Promise<User> {
    return this.prisma.user.create({ data });
  }

  async update(id: string, data: UpdateUserDTO): Promise<User> {
    return this.prisma.user.update({ where: { id }, data });
  }

  async delete(id: string): Promise<void> {
    await this.prisma.user.delete({ where: { id } });
  }
}
```

### Service (No Changes Needed)

Services use the repository the same way regardless of ORM:

```typescript
// src/services/user.service.ts
import { UserRepository } from '../repositories/user.repository';

export class UserService {
  constructor(private readonly userRepository: UserRepository) {}

  async createUser(data: CreateUserDTO): Promise<User> {
    const existingUser = await this.userRepository.findByEmail(data.email);
    if (existingUser) {
      throw new BadRequestException('Email already exists');
    }
    return this.userRepository.create(data);
  }

  async getUser(id: string): Promise<User> {
    const user = await this.userRepository.findById(id);
    if (!user) {
      throw new NotFoundException('User not found');
    }
    return user;
  }
}
```

### Switching ORM (Prisma → Drizzle)

**Only 2 changes needed:**

1. Replace the import:

```typescript
// Before (Prisma)
import { PrismaClient } from '@prisma/client';

// After (Drizzle)
import { DrizzleClient } from '@/database';
```

2. Replace the constructor:

```typescript
// Before (Prisma)
constructor(private readonly prisma: PrismaClient) {}

// After (Drizzle)
constructor(private readonly db: DrizzleClient) {}
```

3. Replace the method calls:

```typescript
// Before (Prisma)
return this.prisma.user.findUnique({ where: { id } });

// After (Drizzle)
return this.db.query.users.findFirst({
  where: (users, { eq }) => eq(users.id, id),
});
```

**That's it.** No changes to services, controllers, or anywhere else.

### Python Example (SQLAlchemy)

```python
# src/repositories/user_repository.py

# === ORM SWITCH: Change this import to switch ORM ===
from sqlalchemy.orm import Session
# =============================================

class UserRepository:
    def __init__(self, session: Session):
        self.session = session

    def find_by_id(self, id: str) -> Optional[User]:
        return self.session.query(User).filter(User.id == id).first()

    def find_by_email(self, email: str) -> Optional[User]:
        return self.session.query(User).filter(User.email == email).first()

    def find_all(self) -> List[User]:
        return self.session.query(User).all()

    def create(self, data: dict) -> User:
        user = User(**data)
        self.session.add(user)
        self.session.commit()
        return user

    def update(self, id: str, data: dict) -> User:
        user = self.session.query(User).filter(User.id == id).first()
        for key, value in data.items():
            setattr(user, key, value)
        self.session.commit()
        return user

    def delete(self, id: str) -> None:
        user = self.session.query(User).filter(User.id == id).first()
        self.session.delete(user)
        self.session.commit()
```

### Go Example (GORM)

```go
// src/repositories/user_repository.go

import "gorm.io/gorm"

type UserRepository struct {
    db *gorm.DB
}

func NewUserRepository(db *gorm.DB) *UserRepository {
    return &UserRepository{db: db}
}

func (r *UserRepository) FindByID(id string) (*User, error) {
    var user User
    result := r.db.First(&user, id)
    return &user, result.Error
}

func (r *UserRepository) FindByEmail(email string) (*User, error) {
    var user User
    result := r.db.Where("email = ?", email).First(&user)
    return &user, result.Error
}

func (r *UserRepository) FindAll() ([]User, error) {
    var users []User
    result := r.db.Find(&users)
    return users, result.Error
}

func (r *UserRepository) Create(user *User) error {
    return r.db.Create(user).Error
}

func (r *UserRepository) Update(user *User) error {
    return r.db.Save(user).Error
}

func (r *UserRepository) Delete(id string) error {
    return r.db.Delete(&User{}, id).Error
}
```

### Summary: Switch ORM in One File

| To Switch | Change In |
|----------|----------|
| Prisma → Drizzle | `src/repositories/user.repository.ts` (import + methods) |
| Drizzle → TypeORM | `src/repositories/user.repository.ts` (import + methods) |
| SQLAlchemy | `src/repositories/user_repository.py` (import + methods) |
| GORM | `src/repositories/user_repository.go` (import + methods) |

**No changes to services, controllers, or business logic.**

## Service Layer

Services contain business logic and use repositories:

```typescript
// src/services/user.service.ts
export class UserService {
  constructor(private readonly userRepository: UserRepository) {}

  async createUser(data: CreateUserDTO): Promise<User> {
    const existingUser = await this.userRepository.findByEmail(data.email);
    if (existingUser) {
      throw new BadRequestException('Email already exists');
    }
    return this.userRepository.create(data);
  }

  async getUser(id: string): Promise<User> {
    const user = await this.userRepository.findById(id);
    if (!user) {
      throw new NotFoundException('User not found');
    }
    return user;
  }
}
```

## Controller Layer

Controllers handle HTTP requests:

```typescript
// src/controllers/user.controller.ts
export class UserController {
  constructor(private readonly userService: UserService) {}

  @Post('/users')
  async createUser(@Body() createUserDTO: CreateUserDTO) {
    const user = await this.userService.createUser(createUserDTO);
    return new UserResponseDTO(user);
  }

  @Get('/users/:id')
  async getUser(@Param('id') id: string) {
    const user = await this.userService.getUser(id);
    return new UserResponseDTO(user);
  }
}
```

## DTOs

Request/Response objects for validation:

```typescript
// src/dtos/create-user.dto.ts
export class CreateUserDTO {
  @IsEmail()
  email: string;

  @IsString()
  @MinLength(8)
  password: string;

  @IsString()
  name: string;
}

// src/dtos/user-response.dto.ts
export class UserResponseDTO {
  id: string;
  email: string;
  name: string;
  createdAt: Date;

  constructor(user: User) {
    this.id = user.id;
    this.email = user.email;
    this.name = user.name;
    this.createdAt = user.createdAt;
  }
}
```

## Middleware

### Error Handler

```typescript
// src/middleware/error-handler.middleware.ts
export function errorHandler(err: Error, req: Request, res: Response, next: NextFunction) {
  console.error('Error:', err.message);

  if (err instanceof ValidationException) {
    return res.status(400).json({
      error: 'Validation Error',
      message: err.message,
    });
  }

  if (err instanceof NotFoundException) {
    return res.status(404).json({
      error: 'Not Found',
      message: err.message,
    });
  }

  return res.status(500).json({
    error: 'Internal Server Error',
    message: 'Something went wrong',
  });
}
```

### Auth Middleware

```typescript
// src/middleware/auth.middleware.ts
export function authMiddleware(req: Request, res: Response, next: NextFunction) {
  const token = req.headers.authorization?.split(' ')[1];

  if (!token) {
    return res.status(401).json({ error: 'No token provided' });
  }

  try {
    const decoded = jwt.verify(token, process.env.JWT_SECRET);
    req.user = decoded;
    next();
  } catch {
    return res.status(401).json({ error: 'Invalid token' });
  }
}
```

### Logger Middleware

```typescript
// src/middleware/logger.middleware.ts
export function loggerMiddleware(req: Request, res: Response, next: NextFunction) {
  const start = Date.now();

  res.on('finish', () => {
    const duration = Date.now() - start;
    console.log(`${req.method} ${req.url} ${res.statusCode} ${duration}ms`);
  });

  next();
}
```

## Health Check

```typescript
// src/controllers/health.controller.ts
export class HealthController {
  @Get('/health')
  check() {
    return {
      status: 'ok',
      timestamp: new Date().toISOString(),
    };
  }
}
```

## API Versioning

```
/api/v1/users
/api/v2/users
```

## Supported ORMs

| Framework | ORM |
|-----------|-----|
| Node.js | Prisma, TypeORM, Drizzle |
| Python | SQLAlchemy |
| Go | GORM |

## Validation Steps

After scaffolding:

1. Install dependencies: `npm install` or `pip install -r requirements.txt` or `go mod download`
2. Run lint: `npm run lint` or `ruff check .` or `golangci-lint run`
3. Run typecheck: `npm run typecheck` or `mypy .` or `go build`
4. Run tests: `npm run test` or `pytest` or `go test ./...`
5. Verify build: `npm run build` or `python -m py_compile .` or `go build -o bin/server`

## Best Practices

- Use TypeScript for Node.js projects
- Use Go for Node.js projects
- Include Docker configuration
- Set up proper module structure
- Add health check endpoint
- Include basic unit tests
- Use environment variables for config
- Use DTOs for request/response validation
- Implement repository pattern for data access
- Separate concerns: controllers → services → repositories → models

## Usage

```
/init-api
```

or with options:

```
/init-api --framework nestjs --name my-api
```

## With PRD Flag

Use `--prd` to create PRD and plan before scaffolding:

```
/init-api --prd
```

When `--prd` flag is used:

1. **Create PRD** - Use `create-prd` skill to interview user about the feature
2. **Create Plan** - Use `prd-to-plan` skill to break into phases
3. **Scaffold** - Then scaffold based on the plan

This ensures you build what you planned.

## Aliases

- `/init-backend`
- `/init-server`
- `/init-api-full`