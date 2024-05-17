FROM scratch
ADD performance_test.wasm /
CMD ["/performance_test.wasm"]