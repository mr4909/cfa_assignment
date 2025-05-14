# Take-Home Assignment – Code for America

This repository contains my submission for the Code for America Senior Data Scientist take-home assignment. It includes exploratory data analysis, model development, and stakeholder-focused insights using CalFresh application data from San Diego County.

View the full project site here:
[https://calfresh-cfa-exercise.netlify.app/](https://calfresh-cfa-exercise.netlify.app/)

Everything written up in this repo — including all analysis, models, and summaries — can be viewed directly on the website or reproduced locally by running the code in this repository.

## Project Structure

```         
├── README.md               # Project overview and instructions  
├── _quarto.yml             # Quarto site configuration  
├── analysis.qmd            # Full walkthrough of the data analysis  
├── key_findings.qmd        # Stakeholder-facing summary of results  
├── index.qmd               # Home page for the rendered site  
├── about.qmd, contact.qmd  # Additional project content  
├── styles.css              # Custom styles for Quarto outputs  
├── data/                   # Input data (manually placed here)  
├── img/                    # Screenshots from application walkthrough  
├── models/                 # Saved model objects  
├── R/                      # R scripts and helper functions  
│   ├── setup.R             # Packages, fonts, colors, binwidths  
│   └── utils_helpers.R     # Custom plotting and table styling functions  
├── _site/                  # Rendered HTML output  
├── _freeze/                # Quarto cache directory  
├── renv/                   # Environment management (via `renv`)  
├── renv.lock               # Package versions and reproducibility  
└── cfa_assignment.Rproj    # RStudio project file  
```

## How to Run

To execute the full workflow from start to finish:

1.  Open the RStudio project (`.Rproj` file)

2.  Set your working directory to the project root

3.  Restore the project environment using `renv`:

    ``` r
    install.packages("renv")
    renv::restore()
    ```

    This will install all required packages in a project-specific library without affecting your system-wide R setup.

4.  Download the data file from the link provided by Code for America.

5.  Create a data/ folder in the project root (if it doesn't exist) and place the downloaded .csv file inside it.

6.  Render the Quarto site:

    ``` r
    quarto::quarto_render()
    ```

    You can also open `_site/index.html` directly in your browser to view the full rendered site if you have already rendered it.

## Outputs

-   `analysis.qmd`: Full analysis, including data exploration, logistic regression, and interpretation.
-   `key_findings.qmd`: Simplified summary for assignment.
-   Saved model: models/approval_model.rds
-   Rendered outputs are saved to `_site/` by Quarto. You can open `index.html` to explore the full report.

## Data Notes

-   The data file must be downloaded manually from the Google Drive link provided by the recruiter.
-   After downloading, place the .csv file into the data/ folder in the project directory.
-   No private or sensitive data is used. All work is reproducible with provided scripts.

## Branching and Collaboration

This project uses a two-branch Git workflow:

-   `main`: Contains the polished, production-ready version of the project
-   `develop`: Used for drafting, testing, and refining code and analysis before merging into `main`

All development work — including exploratory analysis, function building, and documentation — was done in the develop branch, then reviewed and merged into main once finalized.

## Contact

For any questions about this repository or the take-home assignment, please contact:

**Mari Roberts** Email: [marialexandriaroberts\@gmail.com](mailto:marialexandriaroberts@gmail.com)
