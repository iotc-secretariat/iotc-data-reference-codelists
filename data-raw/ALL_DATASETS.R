# LIBRARIES ####
library(iotc.base.common.data)
library(usethis)
library(data.table)

# CONNECTION TO IOTC_REFERENCEDATA
C_REFERENCE_DATA = 
DBI::dbConnect(drv = RPostgres::Postgres(),
               host = Sys.getenv("IOTC_REFERENCE_DATA_DB_SERVER"),
               dbname = 'IOTC_ReferenceData_2025_07_23',
               port = 5432,
               user = Sys.getenv("IOTC_REFERENCE_DATA_DB_USER"),
               password = Sys.getenv("IOTC_REFERENCE_DATA_DB_PWD")
)

# COMMON REFERENCE DATA MANAGEMENT FUNCTIONS ####

load_codelist = function(codelist_domain, codelist_name, columns = NULL, connection = DB_IOTC_MASTER()) {
  if(is.null(columns)) columns = "*"
  else columns = paste0(columns, collapse = ", ")
  
  CL = 
    query(
      connection,
      paste0("SELECT ", columns, " FROM ", codelist_domain, ".", codelist_name)
    )
  setnames(CL, new = toupper(names(CL)))
  return(CL)
}

admin_domain = function(codelist_name, columns = NULL, connection = C_REFERENCE_DATA) {
  return(load_codelist("refs_admin", codelist_name, columns, connection))
}

gis_domain = function(codelist_name, columns = NULL, connection = DB_IOTC_MASTER()) {
  return(load_codelist("refs_gis", codelist_name, columns, connection))
}

fishery_domain = function(codelist_name, columns = NULL, connection = C_REFERENCE_DATA) {
  return(load_codelist("refs_fishery", codelist_name, columns, connection))
}

biology_domain = function(codelist_name, columns = NULL, connection = C_REFERENCE_DATA) {
  return(load_codelist("refs_biology", codelist_name, columns, connection))
}

data_domain = function(codelist_name, columns = NULL, connection = C_REFERENCE_DATA) {
  return(load_codelist("refs_data", codelist_name, columns, connection))
}

legacy_domain = function(codelist_name, columns = NULL, connection = C_REFERENCE_DATA) {
  return(load_codelist("refs_legacy", codelist_name, columns, connection))
}

socio_economics_domain = function(codelist_name, columns = NULL, connection = C_REFERENCE_DATA) {
  return(load_codelist("refs_socio_economics", codelist_name, columns, connection))
}

# ADMIN REFERENCES ####

## Extract the data from IOTC database ####
COUNTRIES                      = admin_domain("countries")
CPC_HISTORY                    = admin_domain("cpc_history")  # Added for version 2
CPC_TO_FLAGS                   = admin_domain("cpc_to_flags") # Added for version 2
CPCS                           = admin_domain("cpcs")         # Added for version 2
ENTITIES                       = admin_domain("entities")
# FLEETS_FLAGS_FISHERIES = admin_domain("fleet_to_flags_and_fisheries") # Added for version 2
FLEETS                         = admin_domain("v_fleets_out")
FLEETS_FLAGS                   = merge(FLEETS[, .(FLEET_CODE = CODE, FLAG_CODE)], ENTITIES, by.x = "FLAG_CODE", by.y = "CODE") %>% setcolorder(neworder = "FLEET_CODE")
IO_MAIN_AREAS                  = admin_domain("io_main_areas") # Added for version 2
PORTS                          = admin_domain("ports")         # Added for version 2
SPECIES_REPORTING_REQUIREMENTS = admin_domain("species_reporting_requirements") # Added for version 2

## Save package data as rda in data folder ####
use_data(COUNTRIES, overwrite = TRUE)
use_data(CPC_HISTORY, overwrite = TRUE)
use_data(CPC_TO_FLAGS, overwrite = TRUE)
use_data(CPCS, overwrite = TRUE)
use_data(ENTITIES, overwrite = TRUE)
use_data(FLEETS, overwrite = TRUE)
use_data(FLEETS_FLAGS, overwrite = TRUE)
use_data(IO_MAIN_AREAS, overwrite = TRUE)
use_data(PORTS, overwrite = TRUE)
use_data(SPECIES_REPORTING_REQUIREMENTS, overwrite = TRUE)

# DATA REFERENCES ####

## Extract the data from IOTC database ####
DATA_TYPES       = data_domain("TYPES")
DATA_RAISINGS    = data_domain("RAISINGS")

# These shall be further specialized by type of dataset...
DATA_SOURCES        = data_domain("SOURCES")
DATA_PROCESSINGS    = data_domain("PROCESSINGS")
DATA_ESTIMATIONS    = data_domain("ESTIMATIONS")
DATA_COVERAGE_TYPES = data_domain("COVERAGE_TYPES")

## Save package data as rda in data folder ####
use_data(DATA_TYPES,    overwrite = TRUE)
use_data(DATA_RAISINGS, overwrite = TRUE)
use_data(DATA_SOURCES,        overwrite = TRUE)
use_data(DATA_PROCESSINGS,    overwrite = TRUE)
use_data(DATA_ESTIMATIONS,    overwrite = TRUE)
use_data(DATA_COVERAGE_TYPES, overwrite = TRUE)

# GIS REFERENCES ####

## Extract the data from IOTC database ####
AREAS_COLUMNS = c("CODE", "NAME_EN", "NAME_FR", "OCEAN_AREA_KM2", "OCEAN_AREA_IO_KM2", "OCEAN_AREA_IOTC_KM2", "CENTER_LAT", "CENTER_LON")

IOTC_AREA            = gis_domain("V_IOTC_AREA_OF_COMPETENCE", columns = AREAS_COLUMNS)
IOTC_AREAS           = gis_domain("V_IOTC_AREAS",          columns = AREAS_COLUMNS)
IOTC_MAIN_AREAS      = gis_domain("V_IOTC_MAIN_AREAS",     columns = AREAS_COLUMNS)
IOTC_GRIDS_CE_SF     = gis_domain("V_IOTC_GRIDS_CE_SF",    columns = AREAS_COLUMNS)
IOTC_GRIDS_CE_SF_AR  = gis_domain("V_IOTC_GRIDS_CE_SF_AR", columns = AREAS_COLUMNS)

IOTC_GRIDS_01x01     = gis_domain("V_IOTC_GRIDS_01x01", columns = AREAS_COLUMNS)
IOTC_GRIDS_05x05     = gis_domain("V_IOTC_GRIDS_05x05", columns = AREAS_COLUMNS)
IOTC_GRIDS_10x10     = gis_domain("V_IOTC_GRIDS_10x10", columns = AREAS_COLUMNS)
IOTC_GRIDS_10x20     = gis_domain("V_IOTC_GRIDS_10x20", columns = AREAS_COLUMNS)
IOTC_GRIDS_20x20     = gis_domain("V_IOTC_GRIDS_20x20", columns = AREAS_COLUMNS)
IOTC_GRIDS_30x30     = gis_domain("V_IOTC_GRIDS_30x30", columns = AREAS_COLUMNS)

IO_GRIDS_01x01       = gis_domain("V_IO_GRIDS_01x01",   columns = AREAS_COLUMNS)
IO_GRIDS_05x05       = gis_domain("V_IO_GRIDS_05x05",   columns = AREAS_COLUMNS)
IO_GRIDS_10x10       = gis_domain("V_IO_GRIDS_10x10",   columns = AREAS_COLUMNS)
IO_GRIDS_10x20       = gis_domain("V_IO_GRIDS_10x20",   columns = AREAS_COLUMNS)
IO_GRIDS_20x20       = gis_domain("V_IO_GRIDS_20x20",   columns = AREAS_COLUMNS)
IO_GRIDS_30x30       = gis_domain("V_IO_GRIDS_30x30",   columns = AREAS_COLUMNS)

## Save package data as rda in data folder ####
use_data(IOTC_AREA,           overwrite = TRUE)
use_data(IOTC_AREAS,          overwrite = TRUE)
use_data(IOTC_MAIN_AREAS,     overwrite = TRUE)
use_data(IOTC_GRIDS_CE_SF,    overwrite = TRUE)
use_data(IOTC_GRIDS_CE_SF_AR, overwrite = TRUE)

use_data(IOTC_GRIDS_01x01, overwrite = TRUE)
use_data(IOTC_GRIDS_05x05, overwrite = TRUE)
use_data(IOTC_GRIDS_10x10, overwrite = TRUE)
use_data(IOTC_GRIDS_10x20, overwrite = TRUE)
use_data(IOTC_GRIDS_20x20, overwrite = TRUE)
use_data(IOTC_GRIDS_30x30, overwrite = TRUE)

use_data(IO_GRIDS_01x01, overwrite = TRUE)
use_data(IO_GRIDS_05x05, overwrite = TRUE)
use_data(IO_GRIDS_10x10, overwrite = TRUE)
use_data(IO_GRIDS_10x20, overwrite = TRUE)
use_data(IO_GRIDS_20x20, overwrite = TRUE)
use_data(IO_GRIDS_30x30, overwrite = TRUE)

# FISHERY REFERENCES ####

## Extract the data from IOTC database ####
FISHERIES = fishery_domain("FISHERIES")
FISHERIES[, IS_AGGREGATE := str_detect(CODE, "\\+")]

CATCH_UNITS          = fishery_domain("CATCH_UNITS")
DISCARD_UNITS        = CATCH_UNITS
EFFORT_UNITS         = fishery_domain("EFFORT_UNITS")
#BOAT_TYPES           = fishery_domain("BOAT_TYPES")
VESSEL_ARCHITECTURES = fishery_domain("VESSEL_ARCHITECTURES")
#BOAT_CLASS_TYPES     = fishery_domain("BOAT_CLASS_TYPES")
VESSEL_SIZE_TYPES    = fishery_domain("VESSEL_SIZE_TYPES")
MECHANISATION_TYPES  = fishery_domain("MECHANISATION_TYPES")
PRESERVATION_METHODS = fishery_domain("FISH_PRESERVATION_METHODS")
PROCESSING_TYPES     = fishery_domain("FISH_PROCESSING_TYPES")
FOB_TYPES            = fishery_domain("FOB_TYPES")
FOB_ACTIVITY_TYPES   = fishery_domain("FOB_ACTIVITY_TYPES")

# Temp fix pour EFFORT_UNITS to feed the Data Browser
LEGACY_EFFORT_UNITS_IOTDB = query(DB_IOTDB(), "SELECT * FROM meta.EFFORT_UNITS")

## Save package data as rda in data folder ####
use_data(FISHERIES,            overwrite = TRUE)
use_data(CATCH_UNITS,          overwrite = TRUE)
use_data(DISCARD_UNITS,        overwrite = TRUE)
use_data(EFFORT_UNITS,         overwrite = TRUE)
use_data(VESSEL_ARCHITECTURES, overwrite = TRUE)
use_data(VESSEL_SIZE_TYPES,    overwrite = TRUE)
use_data(MECHANISATION_TYPES,  overwrite = TRUE)
use_data(PRESERVATION_METHODS, overwrite = TRUE)
use_data(PROCESSING_TYPES,     overwrite = TRUE)
use_data(FOB_TYPES,            overwrite = TRUE)
use_data(FOB_ACTIVITY_TYPES,   overwrite = TRUE)
use_data(LEGACY_EFFORT_UNITS_IOTDB, overwrite = TRUE)

# BIOLOGY REFERENCES ####

## Extract the data from IOTC database ####
SPECIES = biology_domain("V_SPECIES", columns = toupper(c("code", "name_en", "name_fr", "name_scientific", "is_iotc", "is_aggregate", "species_category_code", "species_category_name_en", "species_category_name_fr")))

SEX                  = biology_domain("SEX")
TYPES_OF_FATE        = biology_domain("TYPES_OF_FATE")
FATES                = biology_domain("FATES")
DISCARD_REASONS      = biology_domain("V_DISCARD_REASONS", columns = c("code", "name_en", "name_fr"))
RETAIN_REASONS       = biology_domain("V_RETAIN_REASONS",  columns = c("code", "name_en", "name_fr"))
CONDITIONS           = biology_domain("INDIVIDUAL_CONDITIONS")
TYPES_OF_MEASUREMENT = biology_domain("TYPES_OF_MEASUREMENT")
MEASUREMENTS         = biology_domain("MEASUREMENTS")
MEASUREMENT_TOOLS    = biology_domain("MEASUREMENT_TOOLS")

## Save package data as rda in data folder ####
use_data(SPECIES,              overwrite = TRUE)
use_data(SEX,                  overwrite = TRUE)
use_data(TYPES_OF_FATE,        overwrite = TRUE)
use_data(FATES,                overwrite = TRUE)
use_data(DISCARD_REASONS,      overwrite = TRUE)
use_data(RETAIN_REASONS,       overwrite = TRUE)
use_data(CONDITIONS,           overwrite = TRUE)
use_data(TYPES_OF_MEASUREMENT, overwrite = TRUE)
use_data(MEASUREMENTS,         overwrite = TRUE)
use_data(MEASUREMENT_TOOLS,    overwrite = TRUE)

# LEGACY REFERENCES ####

# There are currently two possible versions of the LEGACY CODE LISTS, depending on whether they come from the IOTDB database or from IOTC_master. The tables from IOTDB do include a SORT column which is required in the library 'iotc.base.common.data' for the factorisation process of the main variables (e.g., species) 

LEGACY_FLEETS       = legacy_domain("FLEETS")
LEGACY_FLEETS_IOTDB = query(DB_IOTDB(), "SELECT * FROM meta.FLEETS")

LEGACY_MAIN_AREAS = legacy_domain("MAIN_AREAS") 

LEGACY_DATA_TYPES = legacy_domain("DATA_TYPES")

LEGACY_DATA_COVERAGE_TYPES = legacy_domain("COVERAGE_TYPES")

LEGACY_DATA_SOURCES = legacy_domain("DATA_SOURCES")

LEGACY_DATA_PROCESSINGS = legacy_domain("DATA_PROCESSINGS")

LEGACY_ESTIMATION_TYPES = legacy_domain("ESTIMATION_TYPES")

LEGACY_GEARS = legacy_domain("GEARS")

LEGACY_GEARS_IOTDB = query(DB_IOTDB(), "SELECT * FROM meta.gears")  # includes SORT for factorisation

LEGACY_GEAR_TYPES = legacy_domain("GEAR_TYPES")

LEGACY_FISHERY_TYPES = legacy_domain("V_FISHERY_TYPES")

LEGACY_FISHERY_GROUPS = legacy_domain("V_FISHERY_GROUPS")

LEGACY_FISHERY_GROUPS_IOTDB = query(DB_IOTDB(), "SELECT * FROM meta.FISHERY_GROUPS") # includes SORT for factorisation

LEGACY_FISHERIES = legacy_domain("FISHERIES", columns = toupper(c("code", "name_en", "name_fr", "fishery_group_code", "fishery_group_name_fr", "fishery_type_code", "fishery_type_name_fr", "is_aggregate")))

LEGACY_FISHERIES[, FISHERY_CATEGORY_CODE := ifelse(FISHERY_TYPE_CODE != "IN", 
                                                   "COASTAL", 
                                                    ifelse(FISHERY_GROUP_CODE == "LL", 
                                                      "LONGLINE", 
                                                      "SURFACE"))]

LEGACY_FISHERIES[, IS_AGGREGATE := ifelse(IS_AGGREGATE == 1, TRUE, FALSE)]

LEGACY_FISHERIES_IOTDB = query(DB_IOTDB(), "SELECT * FROM meta.FISHERIES;")

LEGACY_SPECIES = legacy_domain("SPECIES", columns = c("CODE", "NAME_EN", "NAME_FR", "NAME_SCIENTIFIC", "IS_AGGREGATE", "IS_IOTC"))                                

LEGACY_SPECIES_IOTDB = query(DB_IOTDB(), "SELECT CODE, SORT, NAME_EN, NAME_LT AS NAME_SCIENTIFIC, IS_AGGREGATE, IS_IOTC, SPECIES_CATEGORY_CODE FROM meta.species")

LEGACY_SPECIES_IOTDB = LEGACY_SPECIES_IOTDB[CODE %in% LEGACY_SPECIES$CODE] # includes SORT for factorisation

LEGACY_FATES = legacy_domain("FATES")

LEGACY_SAMPLED_CATCH_TYPES = legacy_domain("SAMPLED_CATCH_TYPES")

LEGACY_CATCH_UNITS = legacy_domain("CATCH_UNITS")

LEGACY_EFFORT_UNITS = legacy_domain("EFFORT_UNITS")

LEGACY_SCHOOL_TYPES = legacy_domain("SCHOOL_TYPES")

LEGACY_MEASUREMENT_TYPES = legacy_domain("MEASUREMENT_TYPES")

LEGACY_MEASUREMENT_TOOLS = legacy_domain("MEASUREMENT_TOOLS")

LEGACY_RAISINGS = legacy_domain("RAISINGS")

LEGACY_BOAT_TYPES = legacy_domain("BOAT_TYPES")

LEGACY_FAD_ACTIVITY_TYPES = legacy_domain("FAD_ACTIVITY_TYPES")

LEGACY_FAD_TYPES = legacy_domain("FAD_TYPES")

LEGACY_FAD_OWNERSHIPS = legacy_domain("FAD_OWNERSHIPS")

## Save package data as rda in data folder ####
use_data(LEGACY_FLEETS, overwrite = TRUE)
use_data(LEGACY_FLEETS_IOTDB, overwrite = TRUE)
use_data(LEGACY_MAIN_AREAS, overwrite = TRUE)
use_data(LEGACY_DATA_TYPES, overwrite = TRUE)
use_data(LEGACY_DATA_COVERAGE_TYPES, overwrite = TRUE)
use_data(LEGACY_DATA_SOURCES, overwrite = TRUE)
use_data(LEGACY_DATA_PROCESSINGS, overwrite = TRUE)
use_data(LEGACY_ESTIMATION_TYPES, overwrite = TRUE)
use_data(LEGACY_GEARS, overwrite = TRUE)
use_data(LEGACY_GEARS_IOTDB, overwrite = TRUE)
use_data(LEGACY_GEAR_TYPES, overwrite = TRUE)
use_data(LEGACY_GEARS_IOTDB, overwrite = TRUE)
use_data(LEGACY_GEAR_TYPES, overwrite = TRUE)
use_data(LEGACY_FISHERY_TYPES, overwrite = TRUE)
use_data(LEGACY_FISHERY_GROUPS, overwrite = TRUE)
use_data(LEGACY_FISHERY_GROUPS_IOTDB, overwrite = TRUE)
use_data(LEGACY_FISHERIES, overwrite = TRUE)
use_data(LEGACY_FISHERIES_IOTDB, overwrite = TRUE)
use_data(LEGACY_SPECIES, overwrite = TRUE)
use_data(LEGACY_SPECIES_IOTDB, overwrite = TRUE)
use_data(LEGACY_FATES, overwrite = TRUE)
use_data(LEGACY_SAMPLED_CATCH_TYPES, overwrite = TRUE)
use_data(LEGACY_CATCH_UNITS, overwrite = TRUE)
use_data(LEGACY_EFFORT_UNITS, overwrite = TRUE)
use_data(LEGACY_SCHOOL_TYPES, overwrite = TRUE)
use_data(LEGACY_MEASUREMENT_TYPES, overwrite = TRUE)
use_data(LEGACY_MEASUREMENT_TOOLS, overwrite = TRUE)
use_data(LEGACY_RAISINGS, overwrite = TRUE)
use_data(LEGACY_BOAT_TYPES, overwrite = TRUE)    # To rename
use_data(LEGACY_FAD_ACTIVITY_TYPES, overwrite = TRUE)
use_data(LEGACY_FAD_TYPES, overwrite = TRUE)
use_data(LEGACY_FAD_OWNERSHIPS, overwrite = TRUE)

# Other codelists (that should be added in IOTC_master)
# Currently downloaded in the R library: iotc-lib-base-common-data/R/iotc_base_common_data_factors.R
LEGACY_CONDITION_TYPES_IOTDB    = query(DB_IOTDB(), "SELECT * FROM meta.CONDITION_TYPES")
LEGACY_FATE_TYPES_IOTDB         = query(DB_IOTDB(), "SELECT * FROM meta.FATE_TYPES")

LEGACY_WORKING_PARTIES_IOTDB    = query(DB_IOTDB(), "SELECT * FROM meta.WORKING_PARTIES")
LEGACY_SPECIES_GROUPS_IOTDB     = query(DB_IOTDB(), "SELECT * FROM meta.SPECIES_GROUPS")
LEGACY_SPECIES_CATEGORIES_IOTDB = query(DB_IOTDB(), "SELECT * FROM meta.SPECIES_CATEGORIES")
LEGACY_IUCN_STATUS_IOTDB        = query(DB_IOTDB(), "SELECT * FROM meta.IUCN_STATUS")
LEGACY_RAISINGS_IOTDB           = query(DB_IOTDB(), "SELECT * FROM meta.RAISINGS")
LEGACY_FISHERY_TYPES_IOTDB      = query(DB_IOTDB(), "SELECT * FROM meta.FISHERY_TYPES")
LEGACY_FISHING_GROUNDS_IOTDB    = query(DB_IOTDB(), "SELECT * FROM meta.FISHING_GROUNDS")

## Save package data as rda in data folder ####
use_data(LEGACY_WORKING_PARTIES_IOTDB, overwrite = TRUE)
use_data(LEGACY_SPECIES_GROUPS_IOTDB, overwrite = TRUE)
use_data(LEGACY_SPECIES_CATEGORIES_IOTDB, overwrite = TRUE)
use_data(LEGACY_IUCN_STATUS_IOTDB, overwrite = TRUE)
use_data(LEGACY_RAISINGS_IOTDB, overwrite = TRUE)
use_data(LEGACY_FISHERY_TYPES_IOTDB, overwrite = TRUE)
use_data(LEGACY_CONDITION_TYPES_IOTDB, overwrite = TRUE)
use_data(LEGACY_FISHING_GROUNDS_IOTDB, overwrite = TRUE)
use_data(LEGACY_FATE_TYPES_IOTDB, overwrite = TRUE)

# SOCIO-ECONOMIC REFERENCES ####

## Extract the data from IOTC database ####
CURRENCIES          = socio_economics_domain("CURRENCIES")
PRICING_LOCATIONS   = socio_economics_domain("PRICING_LOCATIONS")
PRODUCT_TYPES       = socio_economics_domain("PRODUCT_TYPES")
DESTINATION_MARKETS = socio_economics_domain("DESTINATION_MARKETS")

## Save package data as rda in data folder ####
use_data(CURRENCIES,          overwrite = TRUE)
use_data(PRICING_LOCATIONS,   overwrite = TRUE)
use_data(PRODUCT_TYPES,       overwrite = TRUE)
use_data(DESTINATION_MARKETS, overwrite = TRUE)

# OTHER TYPES OF DATA ####

## Extract the data from IOTC database ####
### ISSUE: IOTC_EAST missing from AREA_INTERSECTIONS and AREA_INTERSECTIONS_IOTC
# EEZ_TO_IOTC_MAIN_AREAS = query(DB_IOTC_MASTER(), "
#   SELECT DISTINCT
#   	RIGHT(TARGET_CODE, 3) AS FLAG_CODE,
#   	SOURCE_CODE AS MAIN_IOTC_AREA_CODE
#   FROM [IOTC_master].[refs_gis].[AREA_INTERSECTIONS_IOTC]
#   WHERE SOURCE_CODE IN ('IOTC_EAST', 'IOTC_WEST')
#   AND TARGET_CODE LIKE 'NJA_%'
#   AND LEN(TARGET_CODE) = 7    -- to remove disputed NJAs
# ")

## Save package data as rda in data folder ####
#use_data(EEZ_TO_IOTC_MAIN_AREAS, overwrite = TRUE)

