.onLoad <- function(libname, pkgname) {
  if (interactive()) {
    reticulate::py_require(c("numpy", "scipy"))
  }
}
