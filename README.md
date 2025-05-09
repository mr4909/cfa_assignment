# Take-Home Assignment – Code for America

This repository contains my work for the Code for America take-home assignment.

## Project Structure

    ├── README.md           # Project overview and setup instructions  
    ├── data/               # Input data (if provided)  
    ├── outputs/            # Generated plots, tables, or reports  
    ├── R/                  # R scripts  
    │   ├── run_all.R  
    │   ├── file.R  
    │   ├── file.R  
    │   └── file.R  
    ├── scripts/            # Main execution script  
    │   └── run_all.R  
    ├── utils/              # Helper functions  
    │   └── utils_helpers.R  
    ├── .Rproj              # RStudio project file  
    └── renv/               # Environment management directory (via `renv`)  

## How to Run

To execute the full workflow from start to finish:

1. Open the RStudio project (`.Rproj` file)
2. Set your working directory to the project root
3. Restore the project environment using `renv`:

    ```r
    install.packages("renv")
    renv::restore()
    ```

4. Run the main script:

    ```r
    source("R/run_all.R")
    ```

This script will:

- Load all necessary packages
- Import and clean the input data
- Run the core analysis
- Generate outputs (plots, tables, reports) into the `outputs/` folder

## Branching and Collaboration

This project follows a standard Git workflow:
- Development work is done in branches 
- The main branch contains the production-ready version

## Contact

For any questions about this repository or the take-home assignment, please contact:

Mari Roberts
Email: [marialexandriaroberts@gmail.com]





