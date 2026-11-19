# Libraries
library(DBI)
library(RPostgres)
library(data.table)
library(usethis)
library(iotc.base.common.data)

# ----------------------------------------------------------------------
# Connect to IOTCReferenceData
# ----------------------------------------------------------------------

C_REFERENCE_DATA <- dbConnect(
  Postgres(),
  host     = Sys.getenv("IOTC_DATA_DB_SERVER"),
  dbname   = Sys.getenv("IOTC_REFERENCE_DATA_DB_NAME"),
  port     = Sys.getenv("IOTC_DATA_DB_PORT"),
  user     = Sys.getenv("IOTC_REFERENCE_DATA_DB_USER"),
  password = Sys.getenv("IOTC_REFERENCE_DATA_DB_PASSWORD")
)

# ----------------------------------------------------------------------
# Generate the .rda data files
# ----------------------------------------------------------------------
source("data-raw/01_generate_rda.R")

# ----------------------------------------------------------------------
# Generate the .Rd documentation files
# ----------------------------------------------------------------------
source("data-raw/02_generate_data_R.R")
devtools::document()
devtools::load_all()
