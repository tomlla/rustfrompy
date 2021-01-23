FROM python:3.8.7-slim as core

RUN pip install pipenv
# RUN apt-get update -qq && apt-get install -y build-essential

WORKDIR /pyapp
COPY pyapp/Pipfile* /pyapp/

# -----------------------------------
FROM rust as builder
WORKDIR /example-rust-ffi-lib
COPY example-rust-ffi-lib /example-rust-ffi-lib
RUN cargo build --release

# -----------------------------------
FROM core as production_base
WORKDIR /pyapp
RUN pipenv install --system --deploy --ignore-pipfile && \
    pip uninstall -y pipenv virtualenv-clone virtualenv

# -----------------------------------
FROM production_base as production_runtime
COPY pyapp/ /pyapp
RUN mkdir /example-rust-ffi-lib
COPY --from=builder /example-rust-ffi-lib/target/release/libexample_rust_ffi_lib.so /example-rust-ffi-lib/libexample_rust_ffi_lib.so
CMD python entrypoint.py