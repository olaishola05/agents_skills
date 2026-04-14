---
name: Optimize
description: Performance optimization for code across any language
tags: performance, optimization, profiling, efficiency
---

# Optimize

Performance optimization for code across any language.

Analyze and optimize code for better performance.

## Detection

Auto-detect language and framework:

- **Node.js**: `package.json` exists
- **Python**: `pyproject.toml` or `requirements.txt` exists
- **Ruby**: `Gemfile` exists
- **Go**: `go.mod` exists
- **Rust**: `Cargo.toml` exists

## Optimization Features

### 1. Memory Leaks

Find unreleased resources and circular references:

- **Check for**: Unclosed file handles, unclosed connections, event listeners not removed
- **Check for**: Circular references preventing garbage collection
- **Check for**: Global variables accumulating data
- **Check for**: Timers/intervals not cleared

### 2. Algorithm Improvements

Suggest better algorithms or data structures:

- **Check for**: Inefficient loops or nested iterations
- **Check for**: O(n²) operations that could be O(n)
- **Check for**: Linear search that could use hash lookup
- **Check for**: Arrays used as stacks/queues (use proper data structures)
- **Check for**: Repeated sorting (cache sorted results)

### 3. Caching Opportunities

Identify repeated computations:

- **Check for**: Expensive operations called multiple times
- **Check for**: Repeated API calls with same parameters
- **Check for**: Repeated regex compilations
- **Check for**: Repeated date/time formatting
- **Check for**: Repeated JSON parsing

### 4. Concurrency Issues

Find race conditions or threading problems:

- **Check for**: Shared mutable state without locks
- **Check for**: Race conditions in async operations
- **Check for**: Missing await/async issues
- **Check for**: Unbounded concurrency (no rate limiting)
- **Check for**: Deadlock-prone patterns

## Output Format

For each issue found, format as:

```
### [Issue Title]

**Severity**: [Critical/High/Medium/Low]

**Location**: [file:line or function name]

**Explanation**: [Description of the issue and why it matters]
```

## Example Output

```
## Performance Optimization Report

### Memory Leak - Unclosed Event Listener

**Severity**: High

**Location**: src/app.ts:45

**Explanation**: Event listener added on line 45 is never removed. This causes memory to accumulate over time as each navigation adds a new listener without cleaning up previous ones.

### Algorithm Improvement - Linear Search

**Severity**: Medium

**Location**: src/users.ts:23

**Explanation**: Using .find() inside a loop results in O(n²) complexity. Consider using a Map for O(1) lookups.

### Caching Opportunity - Repeated API Call

**Severity**: High

**Location**: src/api.ts:12

**Explanation**: The same API endpoint is called with identical parameters multiple times. Implement request caching.

### Concurrency Issue - Race Condition

**Severity**: Critical

**Location**: src/counter.ts:8

**Explanation**: Non-atomic increment operation can cause race conditions in concurrent code. Use proper atomic operations or locks.
```

## Language-Specific Tools

### Node.js

- Use `node --prof` for profiling
- Use `clinic.js` for detailed analysis
- Use `memwatch-next` for memory leaks

### Python

- Use `cProfile`
- Use `tracemalloc`
- Use `memory_profiler`

### Ruby

- Use `ruby-prof`
- Use `stackprof`

### Go

- Use `pprof`
- Use `benchstat`

## Validation Steps

1. Run memory leak detection
2. Analyze algorithm complexity
3. Find caching opportunities
4. Check for concurrency issues
5. Run performance benchmarks
6. Verify all tests pass

## Options

- `--profile`: Run profiling
- `--benchmark`: Run benchmarks
- `--memory`: Focus on memory leaks
- `--concurrency`: Focus on concurrency issues
- `--dry-run`: Show optimizations without applying

## Usage

```
/optimize
```

or:

```
/optimize --memory
/optimize --concurrency
/optimize --profile
```

## Best Practices

- Profile before optimizing
- Measure improvement
- Don't over-optimize
- Keep code readable
- Fix Critical/High issues first

## Aliases

- `/perf`
- `/performance`
- `/opt`
