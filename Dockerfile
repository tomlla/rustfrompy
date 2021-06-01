# ------------------------------------
FROM rust as builder
WORKDIR /example-rust-ffi-lib
COPY example-rust-ffi-lib /example-rust-ffi-lib
RUN cargo build --release


# ------------------------------------
FROM python:3.9.1-slim as production

RUN pip install poetry
WORKDIR /pyapp

COPY /pyapp/pyproject.toml /pyapp/poetry.lock /pyapp/
RUN poetry install --no-interaction --no-ansi 

RUN mkdir /example-rust-ffi-lib
COPY --from=builder /example-rust-ffi-lib/target/release/libexample_rust_ffi_lib.so /example-rust-ffi-lib/libexample_rust_ffi_lib.so

COPY pyapp/ /pyapp
CMD poetry run python entrypoint.py
