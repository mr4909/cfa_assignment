
source("R/setup.R")

# Import exercise data
exercise_data <- read_csv("D:/code_for_america/exercise_data.csv")

# Add descriptions to variables
var_desc <- list(
  app_id               = "Unique identifier for each application",
  completion_time_mins = "Time taken to complete the application, in minutes",
  household_size       = "Number of people applying for CalFresh in the household",
  income               = "Total household income in the last 30 days (randomized slightly for privacy)",
  docs_with_app        = "Count of verification documents uploaded with the initial application",
  docs_after_app       = "Count of verification documents uploaded after application (via Later Docs)",
  under18_n            = "Number of children age 17 or younger included in the application",
  over_59_n            = "Number of adults age 60 or older included in the application",
  stable_housing       = "TRUE if applicant rents or owns the place they sleep; FALSE otherwise",
  had_interview        = "TRUE if applicant reported completing the required interview; may be missing",
  zip                  = "ZIP code where the applicant lives or stays",
  approved             = "TRUE if the application was approved for CalFresh by the county"
)

# Use custom R package built by Mari Roberts
databookR::databook(exercise_data, var_descriptions = var_desc)