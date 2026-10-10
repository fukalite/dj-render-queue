# Product Guidelines: dj-render-queue

## Architectural Guidelines
1. **Zero External Dependencies:** Only standard library and Django (>= 5.2). Do not introduce external dependencies.
2. **Framework Alignment:** Emulate idiomatic Django patterns (middleware, request attributes, template tags, settings defaults).
3. **Fail-Safe Design:** If a developer calls `add_script()` or uses template tags without having registered `RenderQueueMiddleware`, fall back gracefully by lazily attaching queues to `request` rather than throwing uncaught `AttributeError`s.
4. **Performance:** Deduplication must remain $\mathcal{O}(1)$ via set lookups. Avoid regex parsing of responses in the middleware layer.
5. **Security:** Items inside generic `RenderQueue` instances must require explicit `|safe` in their rendering templates to prevent XSS vulnerabilities from unescaped user-supplied content.
6. **Backward Compatibility:** Maintain functional parity with `dj-layouts` queue behaviour to ensure seamless migration.
