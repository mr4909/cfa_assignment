#' Style a gt Table for CFA Reports
#'
#' Applies standardized formatting to a `gt` table using Source Sans 3 font,
#' muted header background, and consistent padding. Designed for visual consistency
#' across CFA outputs.
#'
#' @param gt_tbl A `gt` table object created using [gt::gt()].
#'
#' @return A styled `gt` table object.
#' @export
#'
#' @examples
#' library(gt)
#' gt_tbl <- gt(head(mtcars))
#' fnc_style_gt_table(gt_tbl)
fnc_style_gt_table <- function(gt_tbl) {
  stopifnot("Input must be a gt table" = inherits(gt_tbl, "gt_tbl"))
  
  gt_tbl |>
    gt::tab_options(
      table.font.names = "Source Sans 3",
      column_labels.font.weight = "bold",
      column_labels.background.color = "#ece9f9",
      heading.title.font.size = 16,
      data_row.padding = gt::px(4),
      table.width = gt::pct(100)
    )
}

#' Custom CFA ggplot Theme
#'
#' Creates a minimal ggplot2 theme using Source Sans font and adjusted font sizes.
#' Designed for visual consistency with CFA deliverables.
#'
#' @return A ggplot2 theme object.
#' @export
#'
#' @examples
#' library(ggplot2)
#' ggplot(mtcars, aes(mpg)) +
#'   geom_histogram() +
#'   fnc_theme_cfa()
fnc_theme_cfa <- function() {
  ggplot2::theme_minimal(base_family = "sourcesans", base_size = 14) +
    ggplot2::theme(
      plot.title = ggplot2::element_text(size = 16, face = "bold", margin = ggplot2::margin(b = 10)),
      axis.title = ggplot2::element_text(size = 13),
      axis.text = ggplot2::element_text(size = 12)
    )
}

#' Plot a Histogram of a Variable Using CFA Theme
#'
#' Generates a histogram of a numeric variable from a data frame using ggplot2.
#' Automatically applies CFA styling and optional x-axis limit.
#'
#' @param var A string naming the variable to plot (must exist in `exercise_data`).
#' @param title Optional custom title for the plot.
#' @param max_x Optional numeric value to cap the x-axis (e.g., to remove extreme outliers).
#'
#' @return A ggplot object (histogram).
#' @export
#'
#' @examples
#' fnc_plot_var("income", "Monthly Income", max_x = 2000)
fnc_plot_var <- function(var, title = NULL, max_x = NULL) {
  stopifnot("Variable name must be a single character string" = is.character(var) && length(var) == 1)
  stopifnot("Variable must exist in `exercise_data`" = var %in% names(exercise_data))
  stopifnot("Missing `binwidths` object" = exists("binwidths", inherits = TRUE))
  stopifnot("Missing `cfa_colors` object" = exists("cfa_colors", inherits = TRUE))
  
  data <- exercise_data
  if (!is.null(max_x)) {
    stopifnot("max_x must be numeric" = is.numeric(max_x))
    data <- dplyr::filter(data, .data[[var]] <= max_x)
  }
  
  ggplot2::ggplot(data, ggplot2::aes(.data[[var]])) +
    ggplot2::geom_histogram(
      binwidth = binwidths[[var]],
      fill = cfa_colors$blue,
      color = "white",
      na.rm = TRUE
    ) +
    ggplot2::labs(
      title = title %||% var,
      x = var,
      y = "Count"
    ) +
    fnc_theme_cfa()
}

#' Summarize Approval Rates by Group
#'
#' Computes approval rates across a categorical variable and returns a formatted
#' gt table. Highlights the group with the lowest approval rate in red.
#'
#' @param data A data frame that includes a logical `approved` column and a grouping variable.
#' @param var The unquoted name of the grouping variable (e.g., `zip` or `had_interview`).
#'
#' @return A styled `gt` table summarizing approval rate by group.
#' @export
#'
#' @examples
#' fnc_approval_summary(exercise_data, had_interview)
fnc_approval_summary <- function(data, var) {
  stopifnot("Input must be a data frame" = is.data.frame(data))
  stopifnot("`approved` column must exist and be logical" = "approved" %in% names(data) && is.logical(data$approved))
  
  var_enquo <- rlang::enquo(var)
  
  summarized <- data |>
    dplyr::group_by(!!var_enquo) |>
    dplyr::summarize(
      n = dplyr::n(),
      approval_rate = mean(approved, na.rm = TRUE),
      .groups = "drop"
    ) |>
    dplyr::mutate(approval_rate = round(approval_rate * 100, 1))
  
  min_rate <- min(summarized$approval_rate, na.rm = TRUE)
  
  summarized |>
    gt::gt() |>
    gt::cols_label(
      !!var_enquo := "Group",
      n = "N",
      approval_rate = "Approval Rate (%)"
    ) |>
    gt::fmt_number(columns = n, decimals = 0) |>
    fnc_style_gt_table() |>
    gt::tab_style(
      style = gt::cell_text(color = "#AF121D", weight = "bold"),
      locations = gt::cells_body(
        columns = approval_rate,
        rows = approval_rate == min_rate
      )
    )
}


# # Helper function for styling gt tables
# fnc_style_gt_table <- function(gt_tbl) {
#   gt_tbl |>
#     gt::tab_options(
#       table.font.names = "Source Sans 3",
#       column_labels.font.weight = "bold",
#       column_labels.background.color = "#ece9f9",
#       heading.title.font.size = 16,
#       data_row.padding = gt::px(4),
#       table.width = gt::pct(100)
#     )
# }
# 
# # Create a base plot theme
# fnc_theme_cfa <- function() {
#   theme_minimal(base_family = "sourcesans", base_size = 14) +
#     theme(
#       plot.title = element_text(size = 16, face = "bold", margin = margin(b = 10)),
#       axis.title = element_text(size = 13),
#       axis.text = element_text(size = 12)
#     )
# }
# 
# # Histogram function
# fnc_plot_var <- function(var, title = NULL, max_x = NULL) {
#   data <- exercise_data
#   if (!is.null(max_x)) {
#     data <- data |> filter(.data[[var]] <= max_x)
#   }
#   
#   ggplot(data, aes(.data[[var]])) +
#     geom_histogram(
#       binwidth = binwidths[[var]],
#       fill = cfa_colors$blue,
#       color = "white",
#       na.rm = TRUE
#     ) +
#     labs(
#       title = title %||% var,
#       x = var,
#       y = "Count"
#     ) +
#     fnc_theme_cfa()
# }
# 
# # Function to summarize approval rates across any categorical variable
# fnc_approval_summary <- function(data, var) {
#   var_enquo <- rlang::enquo(var)
#   
#   summarized <- data |>
#     dplyr::group_by(!!var_enquo) |>
#     dplyr::summarize(
#       n = dplyr::n(),
#       approval_rate = mean(approved, na.rm = TRUE),
#       .groups = "drop"
#     ) |>
#     dplyr::mutate(approval_rate = round(approval_rate * 100, 1))
#   
#   min_rate <- min(summarized$approval_rate, na.rm = TRUE)
#   
#   summarized |>
#     gt::gt() |>
#     gt::cols_label(
#       !!var_enquo := "Group",
#       n = "N",
#       approval_rate = "Approval Rate (%)"
#     ) |>
#     gt::fmt_number(columns = n, decimals = 0) |>
#     fnc_style_gt_table() |> 
#     gt::tab_style(
#       style = gt::cell_text(color = "#AF121D", weight = "bold"),
#       locations = gt::cells_body(
#         columns = approval_rate,
#         rows = approval_rate == min_rate
#       )
#     ) 
# }