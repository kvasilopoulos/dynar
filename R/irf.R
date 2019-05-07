
#' @importFrom dplyr select
#' @importFrom rlang enexpr
len_levels <- function(x, var) {

  x %>%
    select(!!enexpr(var)) %>%
    unique() %>%
    nrow()
}


#' @importFrom dplyr as_tibble
#' @importFrom rlang set_names
#' @importFrom purrr reduce pluck map
.irf <- function(x) {

  irf_list <- x %>%
    pluck("oo") %>%
    pluck("irfs") %>%
    map(t)

  nm <- names(irf_list)

  irf_out <-
    irf_list %>%
    reduce(cbind) %>%
    as_tibble() %>%
    set_names(nm)

  structure(
    irf_out,
    n_periods = n_periods(x)
    )
}

#' Extract the irfs into wide format
#'
#' @param x a result object after cleanning.
#'
#' @export
irf_wide <- function(x) {

  irf_df <- .irf(x)

  structure(
    irf_df,
    n_periods = attr(irf_df, "n_periods"),
    class = append(class(irf_df), "irf_wide")
  )
}

#' Extract the irfs into long format
#'
#' @inheritParams irf_wide
#' @param regexpr regular expression for seperation
#'
#' @importFrom tidyr gather separate
#' @importFrom rlang is_character
#' @importFrom dplyr mutate_if
#'
#' @export
irf_long <- function(x, regexpr = "\\.e\\.") {

   irf_df <- .irf(x)

   irf_out <- irf_df %>%
     gather(name, value) %>%
     separate(name, c("var", "shock"), sep = regexpr) %>%
     mutate_if(is.character, ~ gsub("\\.","_", .)) %>%
     mutate_if(is_character, as.factor)

   structure(
    irf_out,
    n_periods = attr(irf_df, "n_periods"),
    n_vars = len_levels(irf_out, var),
    n_shocks = len_levels(irf_out, shock),
    class = append(class(irf_df), "irf_long")
  )

}

#'Plotting irf from long format
#' @param object of class irf_long
#' @param filter_shock choose shocks to be plotted
#' @param filter_var choose variables to be plotted
#' @param ... pass to facet_wrap
#'
#' @importFrom purrr when
#' @importFrom dplyr filter group_by mutate
#' @import ggplot2
#'
#' @export
autoplot.irf_long <- function(object,
                         filter_shock = NULL,
                         filter_var = NULL, ...) {

  plot_df <- object %>%
    when(!is.null(filter_shock) ~
           filter(., shock %in% filter_shock), ~ . ) %>%
    when(!is.null(filter_var) ~
           filter(., var %in% filter_var), ~ . ) %>%
    group_by(var, shock) %>%
    mutate(periods = 1:attr(object, "n_periods"))

  plot_df %>%
    ggplot() +
    geom_line(aes(periods, value), col = "blue") +
    # geom_hline(yintercept = 0, color = "red") +
    theme_minimal() +
    theme(panel.border = element_rect(fill = NA)) +
    xlab("") + ylab("") +
    facet_wrap(shock ~ var, scales = "free_y", ...)
}
