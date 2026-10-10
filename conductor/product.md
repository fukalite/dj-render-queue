# Product Definition: dj-render-queue

## Overview
`dj-render-queue` is a lightweight, request-scoped render queue library for Django. It enables views, middleware, templates, and sub-components to enqueue scripts, stylesheets, and custom HTML fragments into named queues. The unique, deduplicated entries are deterministically injected into the final rendered output.

Originally developed inside `dj-layouts`, this library extracts the render queue engine into a standalone package usable across any standard Django application.

## Core Value Proposition
- **Decoupled Asset Management:** Allows nested template partials, components, and views to declare their own asset dependencies without polluting global base templates.
- **Pipeline-Wide Enqueueing:** Works across the entire Django request lifecycle—middleware on ingress, view execution, nested template includes, and middleware on egress.
- **O(1) Exact Deduplication:** Scripts and styles are deduplicated by exact match (hashing and whitespace stripping), preventing redundant `<script>` or `<link>` tags.
- **Deterministic Ordering:** Elements are emitted in the exact order they are enqueued, with full support for concurrent sub-task merging.
- **Sub-Request Isolation & Caching Safe:** Snapshotting and replaying primitives allow asset requirements to be cached alongside HTML fragments and replayed on cache hits.
