
strip_slashes <- function(x) {
  x <- sub("/*$", "", x)
  x
}

dynare_file <- function(..., path = ".") {
  if (!is.character(path) || length(path) != 1) {
    stop("`path` must be a string.", call. = FALSE)
  }
  path <- strip_slashes(normalizePath(path, mustWork = FALSE))
  if (!file.exists(path)) {
    stop("Can't find '", path, "'.", call. = FALSE)
  }
  # path <- dirname(path = path)
  file.path(path, ...)
}

#' Imports from matlab to R
#'
#' @param matfile a .mat file.
#' @param path the specified path to find the file.
#'
#' @importFrom R.matlab readMat
#' @export
mat2r <- function(matfile = NULL, path = ".") {

  dyn_path <- dynare_file(matfile, path = path)
  if (!file.exists(dyn_path)) {
    stop("Can't find '", dyn_path, "'.", call. = FALSE)
  }
  mat <- R.matlab::readMat(dyn_path)
  mat
}


