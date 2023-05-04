library(iotc.base.common.data)

### COMMON REFERENCE DATA MANAGEMENT

load_codelist = function(codelist_domain, codelist_name, columns = NULL, connection = DB_IOTC_MASTER()) {
  if(is.null(columns)) columns = "*"
  else columns = paste0(columns, collapse = ", ")
  return(
    query(
      connection,
      paste0("SELECT ", columns, " FROM [", codelist_domain, "].[", codelist_name, "]")
    )
  )
}

admin_domain = function(codelist_name, columns = NULL, connection = DB_IOTC_MASTER()) {
  return(load_codelist("refs_admin", codelist_name, columns, connection))
}

gis_domain = function(codelist_name, columns = NULL, connection = DB_IOTC_MASTER()) {
  return(load_codelist("refs_gis", codelist_name, columns, connection))
}

fishery_domain = function(codelist_name, columns = NULL, connection = DB_IOTC_MASTER()) {
  return(load_codelist("refs_fishery", codelist_name, columns, connection))
}

biological_domain = function(codelist_name, columns = NULL, connection = DB_IOTC_MASTER()) {
  return(load_codelist("refs_biological", codelist_name, columns, connection))
}

data_domain = function(codelist_name, columns = NULL, connection = DB_IOTC_MASTER()) {
  return(load_codelist("refs_data", codelist_name, columns, connection))
}

legacy_domain = function(codelist_name, columns = NULL, connection = DB_IOTC_MASTER()) {
  return(load_codelist("refs_legacy", codelist_name, columns, connection))
}

### ADMIN REFERENCES

ENTITIES  = admin_domain("ENTITIES")
COUNTRIES = admin_domain("COUNTRIES")

FLEETS       = admin_domain("FLEETS")
FLEETS_FLAGS = admin_domain("FLEET_TO_FLAGS_AND_FISHERIES")
FLEETS_FLAGS = merge(FLEETS_FLAGS, FLEETS, by.x = "FLEET_CODE", by.y = "CODE")

usethis::use_data(FLEETS,       overwrite = TRUE)
usethis::use_data(COUNTRIES,    overwrite = TRUE)
usethis::use_data(ENTITIES,     overwrite = TRUE)
usethis::use_data(FLEETS_FLAGS, overwrite = TRUE)

### DATA REFERENCES

DATA_TYPES       = data_domain("TYPES")
DATA_RAISINGS    = data_domain("RAISINGS")

usethis::use_data(DATA_TYPES,    overwrite = TRUE)
usethis::use_data(DATA_RAISINGS, overwrite = TRUE)

# These shall be further specialized by type of dataset...
DATA_SOURCES     = data_domain("SOURCES")
DATA_PROCESSINGS = data_domain("PROCESSINGS")
DATA_ESTIMATIONS = data_domain("ESTIMATIONS")

DATA_COVERAGE_TYPES = data_domain("COVERAGE_TYPES")

usethis::use_data(DATA_SOURCES,        overwrite = TRUE)
usethis::use_data(DATA_PROCESSINGS,    overwrite = TRUE)
usethis::use_data(DATA_ESTIMATIONS,    overwrite = TRUE)

usethis::use_data(DATA_COVERAGE_TYPES, overwrite = TRUE)

### GIS REFERENCES

IOTC_AREA            = gis_domain("V_IOTC_MAIN_AREAS",  columns = c("CODE", "NAME_EN", "NAME_FR"))
IOTC_GRIDS_AR        = gis_domain("V_IOTC_GRIDS_AR",    columns = c("CODE", "NAME_EN", "NAME_FR"))
IOTC_GRIDS_CE_SF     = gis_domain("V_IOTC_GRIDS_CE_SF", columns = c("CODE", "NAME_EN", "NAME_FR"))

IOTC_GRIDS_01x01     = gis_domain("V_IOTC_GRIDS_01x01", columns = c("CODE", "NAME_EN", "NAME_FR"))
IOTC_GRIDS_05x05     = gis_domain("V_IOTC_GRIDS_05x05", columns = c("CODE", "NAME_EN", "NAME_FR"))

usethis::use_data(IOTC_AREA,        overwrite = TRUE)
usethis::use_data(IOTC_GRIDS_AR,    overwrite = TRUE)
usethis::use_data(IOTC_GRIDS_CE_SF, overwrite = TRUE)

usethis::use_data(IOTC_GRIDS_01x01, overwrite = TRUE)
usethis::use_data(IOTC_GRIDS_05x05, overwrite = TRUE)

### FISHERY REFERENCES

FISHERIES            = fishery_domain("FISHERIES")

CATCH_UNITS          = fishery_domain("CATCH_UNITS")
DISCARD_UNITS        = CATCH_UNITS
EFFORT_UNITS         = fishery_domain("EFFORT_UNITS")

BOAT_TYPES           = fishery_domain("BOAT_TYPES")
BOAT_CLASS_TYPES     = fishery_domain("BOAT_CLASS_TYPES")
MECHANIZATION_TYPES  = fishery_domain("MECHANIZATION_TYPES")
PRESERVATION_METHODS = fishery_domain("FISH_PRESERVATION_METHODS")
PROCESSING_TYPES     = fishery_domain("FISH_PROCESSING_TYPES")

FAD_TYPES            = fishery_domain("FAD_TYPES")
FAD_ACTIVITY_TYPES   = fishery_domain("FAD_ACTIVITY_TYPES")
FAD_OWNERSHIP_TYPES  = fishery_domain("FAD_OWNERSHIPS")

usethis::use_data(FISHERIES,            overwrite = TRUE)

usethis::use_data(CATCH_UNITS,          overwrite = TRUE)
usethis::use_data(DISCARD_UNITS,        overwrite = TRUE)
usethis::use_data(EFFORT_UNITS,         overwrite = TRUE)

usethis::use_data(BOAT_TYPES,           overwrite = TRUE)
usethis::use_data(BOAT_CLASS_TYPES,     overwrite = TRUE)
usethis::use_data(MECHANIZATION_TYPES,  overwrite = TRUE)
usethis::use_data(PRESERVATION_METHODS, overwrite = TRUE)
usethis::use_data(PROCESSING_TYPES,     overwrite = TRUE)

usethis::use_data(FAD_TYPES,            overwrite = TRUE)
usethis::use_data(FAD_ACTIVITY_TYPES,   overwrite = TRUE)
usethis::use_data(FAD_OWNERSHIP_TYPES,  overwrite = TRUE)

### BIOLOGICAL REFERENCES

SPECIES              = biological_domain("V_SPECIES", columns = c("CODE", "NAME_EN", "NAME_FR", "NAME_SCIENTIFIC", "IS_IOTC", "IS_AGGREGATE"))
SEX                  = biological_domain("SEX")

TYPES_OF_FATE        = biological_domain("TYPES_OF_FATE")
FATES                = biological_domain("FATES")

DISCARD_REASONS      = biological_domain("V_DISCARD_REASONS")
RETAIN_REASONS       = biological_domain("V_RETAIN_REASONS")
CONDITIONS           = biological_domain("INDIVIDUAL_CONDITIONS")

TYPES_OF_MEASUREMENT = biological_domain("TYPES_OF_MEASUREMENT")
MEASUREMENT_TYPES    = biological_domain("MEASUREMENT_TYPES")
MEASUREMENT_TOOLS    = biological_domain("MEASUREMENT_TOOLS")

usethis::use_data(SPECIES,              overwrite = TRUE)
usethis::use_data(SEX,                  overwrite = TRUE)

usethis::use_data(TYPES_OF_FATE,        overwrite = TRUE)
usethis::use_data(FATES,                overwrite = TRUE)

usethis::use_data(DISCARD_REASONS,      overwrite = TRUE)
usethis::use_data(RETAIN_REASONS,       overwrite = TRUE)
usethis::use_data(CONDITIONS,           overwrite = TRUE)

usethis::use_data(TYPES_OF_MEASUREMENT, overwrite = TRUE)
usethis::use_data(MEASUREMENT_TYPES,    overwrite = TRUE)
usethis::use_data(MEASUREMENT_TOOLS,    overwrite = TRUE)

### LEGACY REFERENCES

LEGACY_FISHERIES = legacy_domain("FISHERIES", columns = c("CODE", "NAME_EN", "NAME_FR", "IS_AGGREGATE"))
LEGACY_FISHERIES[, IS_AGGREGATE := ifelse(IS_AGGREGATE == 1, TRUE, FALSE)]
LEGACY_FLEETS    = legacy_domain("FLEETS")
LEGACY_SPECIES   = legacy_domain("SPECIES", columns = c("CODE", "NAME_EN", "NAME_FR", "NAME_SCIENTIFIC", "IS_IOTC", "IS_AGGREGATE"))

usethis::use_data(LEGACY_FISHERIES, overwrite = TRUE)
usethis::use_data(LEGACY_FLEETS,    overwrite = TRUE)
usethis::use_data(LEGACY_SPECIES,   overwrite = TRUE)