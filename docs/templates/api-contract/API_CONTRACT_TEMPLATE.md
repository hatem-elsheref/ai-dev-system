# API Contract Template

## Endpoint
- Name:
- Version: `v1`
- Method: `GET|POST|PUT|PATCH|DELETE`
- Full Path: `/api/v1/...`
- Auth: `public|sanctum|role-based`

## Request
- Content-Type: `application/json|multipart/form-data`
- Headers:
- Query Params:
- Path Params:
- Body Payload:
```json
{}
```

## Response
- Success Status:
- Success Body:
```json
{}
```
- Error Status Codes:
  - `400` Bad Request
  - `401` Unauthorized
  - `403` Forbidden
  - `404` Not Found
  - `422` Validation Error
  - `500` Server Error
- Error Body format:
```json
{
  "message": "Validation failed",
  "errors": {}
}
```

## Changelog
- Created on:
- Updated on:
- Updated by:
