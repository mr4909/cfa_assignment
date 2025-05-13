# ------------------------
# Purpose:
# Set global options and load libraries for CalFresh analysis.
# Includes CFA branding styles.
# ------------------------

# ------------------------
# Package Loading (assumes installed via renv or manually)
# ------------------------

required_packages <- c(
  "tidyverse", 
  "janitor",
  "quarto",
  "htmltools",
  "htmlwidgets",
  "scales",
  "here",
  "broom",
  "naniar",
  "patchwork",
  "showtext",
  "car",
  "corrplot",
  "forcats",
  "gt",
  "reactable",
  "pscl",
  "ResourceSelection",
  "pROC"
)

# Load packages quietly
invisible(lapply(required_packages, library, character.only = TRUE))

# ------------------------
# Load custom package
# ------------------------

# Install the 'databookR' package if it's not already installed.
# This package was custom-built by Mari Roberts.

# Uncomment and run the following line if not already installed:
# remotes::install_github("mr4909/databookR")

# Load databook package
library(databookR)

# ------------------------
# Activate renv
# ------------------------

# Activate renv if used
if (file.exists("renv.lock")) {
  renv::activate()
}

# ------------------------
# CFA Branding – Colors and Fonts
# ------------------------

cfa_colors <- list(
  purple = "#2b1a78",
  blue   = "#0076D6",
  red    = "#D73A49"
)

# Use Source Sans 3 from Google Fonts
font_add_google("Source Sans 3", "sourcesans")
showtext_auto()