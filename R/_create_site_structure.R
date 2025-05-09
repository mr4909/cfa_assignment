# ------------------------
# Purpose:
# This script sets up a standardized directory and file structure for a Code for America
# take home assignment website using the `quartositebuildr` R package (author: Mari Roberts)
# It helps ensure:
# - Reproducibility across research projects
# - Consistent folder structure for collaboration
# - Compatibility with GitHub and Netlify deployment
# ------------------------

# ------------------------
# Prerequisites
# ------------------------

# Install the 'quartositebuildr' package if it's not already installed.
# This package was custom-built to support Code for America project site creation.

# Uncomment and run the following line if not already installed:
# remotes::install_github("mr4909/quartositebuildr")

# Load required library
library(quartositebuildr)

# ------------------------
# Create Site Structure
# ------------------------

# This function initializes a folder and file scaffold suitable for
# a Code for America project website. It includes:
# - R/               : Folder for modular scripts
# - _site/           : Rendered site output (excluded from version control)
# - img/             : Custom assets
# - styles.css       : CSS styles pre-loaded with Source Sans 3 and Code for America purple
# - _quarto.yml      : Quarto site configuration
# - index.qmd        : Homepage
# - Additional pages : Executive summary, analysis plan, etc.

# Call function with valid site type: "cfa" (Code for America)
create_site_structure(type = "cfa")
