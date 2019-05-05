#' @importFrom stringr str_remove word
#' @importFrom stringi stri_remove_empty
#' @importFrom rlang set_names
#' @importFrom utils capture.output
set_names_co <- function(x) {

  nm <- capture.output(x) %>%
    word(1, 1) %>%
    str_remove(",") %>%
    stringi::stri_remove_empty(x = .)

  if (is.null(names(x))) {
    set_names(x, nm) %>%
      drop()
  }else{
    x
  }
}

# predicate ---------------------------------------------------------------

is_empty_obj <- function(x) {
  if ((is.list(x) || is.numeric(x)) && length(x) == 0) TRUE else FALSE
}

#' @importFrom purrr map_lgl
has_empty_obj <- function(x) {
  map_lgl(x, is_empty_obj) %>% all()
}

# Cleaning ----------------------------------------------------------------

clean_empty <- function(x) {
  x %>%
    map_if(has_empty_obj,  ~ NULL) %>%
    map_if(is_empty_obj, ~ NULL)
}

#' @importFrom purrr compose map map_if is_character
#' @importFrom stringr str_trim
clean_sublist <-
  purrr::compose(
    set_names_co,
    ~ map(.x, drop),
    ~ map_if(.x, is_character, str_trim),
    clean_empty
  )

# single function ---------------------------------------------------------

#' Clean the imported matlab .mat matrix
#'
#' @param x an imported *_results.mat file
#'
#' @importFrom purrr map_if
#'
#' @export
clean_dynare <- function(x) {

  nm <- names(x)

  x %>%
    clean_empty() %>%
    map_if(~ !is.null(.x), set_names_co) %>%
    set_names(nm = stringr::str_replace(nm, '\\.$', '')) %>%
    map_if(~ !is.null(.x), clean_sublist)
}




