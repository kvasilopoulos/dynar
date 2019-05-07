endo_names <- function(x) {
  x %>%
    pluck("M") %>%
    pluck("endo.names")
}

n_endo_names <- function(x) {
  length(endo_names(x))
}

exo_names <- function(x) {
  x %>%
    pluck("M") %>%
    pluck("exo.names")
}

n_exo_names <- function(x) {
  length(exo_names(x))
}


param_names <- function(x) {
  x %>%
    pluck("M") %>%
    pluck("param.names")
}

n_param_names <- function(x) {
  length(param_names(x))
}


n_periods <- function(x) {
  x %>%
    pluck("options") %>%
    pluck("irf")
}
