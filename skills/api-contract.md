---
name: api-contract
description: Design an API contract (OpenAPI/Swagger) before starting implementation.
---

# api-contract

Design and document an API contract before writing implementation code.

## Workflow

1. Ask the user about the required endpoints, HTTP methods, authentication requirements, and payload structures.
2. Draft an OpenAPI (Swagger) 3.0 specification in YAML or JSON format.
3. Review the endpoints and data models with the user.
4. Iterate on the design until the user is satisfied.
5. Once approved, save the contract to `api-contract.yaml` (or similar) in the project.

## Usage

```
/api-contract
```
