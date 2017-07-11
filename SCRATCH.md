# SCRATCH.md

---
## Compose requests in series, with a final call to send.

- Pros:
  - good for filtering using the API filters as well as local logic

### References:
- https://github.com/thoughtbot/bamboo#composing-with-pipes-for-default-from-address-default-layouts-etc

---
## Use a `gen_server` or `gen_stage` to implement rate limiting.

- Would go well with the above composition method.
  Final call would send to to the queue.

- Could listen for header responses and update the limit.
