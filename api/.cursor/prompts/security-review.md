# Security Review

Run a full security review for the current feature/module.

## Checklist
- Access control and policy coverage
- Input validation and sanitization
- SQL injection/XSS/SSRF/path traversal checks
- Secret handling and logging safety
- File upload restrictions and execution prevention
- Dependency vulnerabilities (`composer audit`)

## Output Format
- Critical findings
- High findings
- Medium findings
- Low findings
- Required fixes before merge
- Residual risk notes
