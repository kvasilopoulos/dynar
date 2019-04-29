

#' @importFrom stringr str_remove word
#' @importFrom stringi stri_remove_empty
#' @importFrom rlang set_names
set_names_mat2R <- function(x) {

  nm <- capture.output(x) %>%
    word(1, 1) %>%
    str_remove(",") %>%
    stringi::stri_remove_empty()

  x %>%
    set_names(nm)
}

dyn2r <- function(x) {
  x %>%
    set_names_mat2R() %>%
    drop()
}

