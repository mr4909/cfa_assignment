# ------------------------
# Purpose:
# Sets global options and defines directory paths.
# Assumes required packages are installed.
# ------------------------

# ------------------------
# Prerequisites
# ------------------------

# Install the 'databookR' package if it's not already installed.
# This package was custom-built by Mari Roberts.

# Uncomment and run the following line if not already installed:
# remotes::install_github("mr4909/databookR")

# Load databook package
library(databookR)

# Load additional libraries 
library(tidyverse)
library(janitor)
library(quarto)

required_packages <- c(
  "tidyverse", 
  "janitor",
  "quarto",
  "sf",
  "tigris",
  "tidycensus",
  "leaflet",
  "htmltools",
  "htmlwidgets",
  "dplyr",
  "stringr",
  "scales"
)

# Load packages quietly
invisible(lapply(required_packages, library, character.only = TRUE))



# # Activate renv if used
# if (file.exists("renv.lock")) {
#   renv::activate()
# }

# ------------------------
# Code for America Brand Styles
# ------------------------

# Colors
cfa_colors <- list(
  purple = "#2b1a78",
  blue   = "#0076D6",
  red    = "#D73A49",
  teal   = "#17BEBB",
  gray   = "#9B9B9B",
  black  = "#111111"
)

# Fonts (for visualizations)
# Use "Source Sans 3" — free and available via Google Fonts
cfa_font <- "Source Sans 3"

# Named color scale for CFA palette
scale_color_cfa <- function(...) {
  scale_color_manual(values = unlist(cfa_colors), ...)
}

scale_fill_cfa <- function(...) {
  scale_fill_manual(values = unlist(cfa_colors), ...)
}
