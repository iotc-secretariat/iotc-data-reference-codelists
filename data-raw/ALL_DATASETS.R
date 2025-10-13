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

fishery_config_domain = function(codelist_name, columns = NULL, connection = C_REFERENCE_DATA) {
  return(load_codelist("refs_fishery_config", codelist_name, columns, connection))
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

# ADMIN DOMAIN ####

## Extract the data from IOTC database
COUNTRIES                      = admin_domain("countries")
ENTITIES                       = admin_domain("entities")
CURRENT_CPCS                   = admin_domain("v_current_cpcs")         # Added for version 2
CPC_HISTORY                    = admin_domain("cpc_history")  # Added for version 2
CPC_TO_FLAGS                   = admin_domain("cpc_to_flags") # Added for version 2
FLEETS                         = admin_domain("v_fleets_out")
FLEETS_FLAGS                   = merge(FLEETS[, .(FLEET_CODE = CODE, FLAG_CODE)], ENTITIES, by.x = "FLAG_CODE", by.y = "CODE") %>% setcolorder(neworder = "FLEET_CODE") # Added for version 2

ENTITY_FLEET_TO_FLAG = unique(admin_domain("fleet_to_flags_and_fisheries")[, .(REPORTING_ENTITY_CODE, FLAG_CODE, FLEET_CODE)]) # Added for version 2

ENTITY_FLEET_TO_FLAG = merge(ENTITY_FLEET_TO_FLAG, FLEETS[, .(CODE, NAME_EN, NAME_FR)], by.x = "FLEET_CODE", by.y = "CODE")

IO_MAIN_AREAS                  = admin_domain("io_main_areas") # Added for version 2
PORTS                          = admin_domain("ports")         # Added for version 2
SPECIES_REPORTING_REQUIREMENTS = admin_domain("species_reporting_requirements") # Added for version 2

## Save package data as rda in data folder
use_data(COUNTRIES, overwrite = TRUE)
use_data(ENTITIES, overwrite = TRUE)
use_data(CURRENT_CPCS, overwrite = TRUE)
use_data(CPC_HISTORY, overwrite = TRUE)
use_data(CPC_TO_FLAGS, overwrite = TRUE)
use_data(FLEETS, overwrite = TRUE)
use_data(FLEETS_FLAGS, overwrite = TRUE)
use_data(ENTITY_FLEET_TO_FLAG, overwrite = TRUE)
use_data(IO_MAIN_AREAS, overwrite = TRUE)
use_data(PORTS, overwrite = TRUE)
use_data(SPECIES_REPORTING_REQUIREMENTS, overwrite = TRUE)

# GIS DOMAIN ####

## Extract the data from IOTC database
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

## Save package data as rda in data folder
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

## Fisheries And Gears ####

## Extract the data from IOTC database
FISHERIES = fishery_domain("V_FISHERIES_OUT")
FISHERIES[, IS_AGGREGATE := str_detect(CODE, "\\+")]

# Fishery configuration sub-domain
FISHERY_CATEGORIES  = fishery_config_domain("FISHERY_CATEGORIES") # Added for version 2
FISHERY_TYPES       = fishery_config_domain("FISHERY_TYPES") # Added for version 2
FISHERY_PURPOSES    = fishery_config_domain("FISHERY_PURPOSES") # Added for version 2
AREAS_OF_OPERATION  = fishery_config_domain("AREAS_OF_OPERATION") # Added for version 2
LOA_CLASSES         = fishery_config_domain("LOA_CLASSES") # Added for version 2
GEAR_GROUPS         = fishery_config_domain("GEAR_GROUPS") # Added for version 2
GEARS               = fishery_config_domain("GEARS") # Added for version 2
GEAR_CONFIGURATIONS = fishery_config_domain("GEAR_CONFIGURATIONS") # Added for version 2
FISHING_MODES       = fishery_config_domain("FISHING_MODES") # Added for version 2
TARGET_SPECIES      = fishery_config_domain("TARGET_SPECIES") # Added for version 2

# Fishing Trip Details ####
REASONS_DAYS_LOST          = fishery_domain("REASONS_DAYS_LOST")
CARDINAL_POINTS            = fishery_domain("CARDINAL_POINTS")
VESSEL_SECTIONS            = fishery_domain("VESSEL_SECTIONS")
VESSEL_TYPES               = fishery_domain("VESSEL_TYPES")
VESSEL_ARCHITECTURES       = fishery_domain("VESSEL_ARCHITECTURES")
VESSEL_SIZE_TYPES          = fishery_domain("VESSEL_SIZE_TYPES")
HULL_MATERIAL_TYPES        = fishery_domain("HULL_MATERIAL_TYPES")
MECHANISATION_TYPES        = fishery_domain("MECHANISATION_TYPES")
FISH_PRESERVATION_METHODS  = fishery_domain("FISH_PRESERVATION_METHODS")
FISH_STORAGE_TYPES         = fishery_domain("FISH_STORAGE_TYPES")
WASTE_CATEGORIES           = fishery_domain("WASTE_CATEGORIES")
WASTE_DISPOSAL_METHODS     = fishery_domain("WASTE_DISPOSAL_METHODS")
OFFAL_MANAGEMENT_TYPES     = fishery_domain("OFFAL_MANAGEMENT_TYPES")
POLE_MATERIAL_TYPES        = fishery_domain("POLE_MATERIAL_TYPES")
LINE_MATERIAL_TYPES        = fishery_domain("LINE_MATERIAL_TYPES")
BRANCHLINE_STORAGES        = fishery_domain("BRANCHLINE_STORAGES")
HOOK_TYPES                 = fishery_domain("HOOK_TYPES")
GILLNET_MATERIAL_TYPES     = fishery_domain("GILLNET_MATERIAL_TYPES")
NET_COLOURS                = fishery_domain("NET_COLOURS")
NET_DEPLOY_DEPTHS          = fishery_domain("NET_DEPLOY_DEPTHS")
NET_SETTING_STRATEGIES     = fishery_domain("NET_SETTING_STRATEGIES")
NET_CONFIGURATIONS         = fishery_domain("NET_CONFIGURATIONS")
NET_CONDITIONS             = fishery_domain("NET_CONDITIONS")
FLOAT_TYPES                = fishery_domain("FLOAT_TYPES")
SINKER_MATERIAL_TYPES      = fishery_domain("SINKER_MATERIAL_TYPES")

## Fishing Activities ####
SURFACE_FISHERY_ACTIVITIES = fishery_domain("SURFACE_FISHERY_ACTIVITIES")
CATCH_UNITS   = fishery_domain("CATCH_UNITS")
EFFORT_UNITS  = fishery_domain("EFFORT_UNITS")
DISCARD_UNITS = CATCH_UNITS
FISH_PROCESSING_TYPES = fishery_domain("FISH_PROCESSING_TYPES")
STUNNING_METHODS      = fishery_domain("STUNNING_METHODS")
BAIT_FISHING_METHODS  = fishery_domain("BAIT_FISHING_METHODS")

SCHOOL_TYPE_CATEGORIES        = fishery_domain("SCHOOL_TYPE_CATEGORIES")
SCHOOL_SIGHTING_CUES          = fishery_domain("SCHOOL_SIGHTING_CUES")
SCHOOL_DETECTION_METHODS      = fishery_domain("SCHOOL_DETECTION_METHODS")
BAIT_SCHOOL_DETECTION_METHODS = fishery_domain("BAIT_SCHOOL_DETECTION_METHODS")

BUOY_MODELS                = fishery_domain("BUOY_MODELS")
BUOY_ACTIVITY_TYPES        = fishery_domain("BUOY_ACTIVITY_TYPES")
FOB_ACTIVITY_TYPES         = fishery_domain("FOB_ACTIVITY_TYPES")
FOB_TYPES                  = fishery_domain("FOB_TYPES")

FAD_RAFT_DESIGNS   = fishery_domain("FAD_RAFT_DESIGNS")
FAD_TAIL_DESIGNS   = fishery_domain("FAD_TAIL_DESIGNS")

## Mitigation Measures ####
MITIGATION_DEVICES = fishery_domain("MITIGATION_DEVICES")
LIGHT_TYPES        = fishery_domain("LIGHT_TYPES")
LIGHT_COLOURS      = fishery_domain("LIGHT_COLOURS")
STREAMER_TYPES     = fishery_domain("STREAMER_TYPES")
DEHOOKER_TYPES     = fishery_domain("DEHOOKER_TYPES")

## Save package data as rda in data folder
use_data(FISHERIES, overwrite = TRUE)
use_data(FISHERY_CATEGORIES, overwrite = TRUE)
use_data(FISHERY_TYPES, overwrite = TRUE)
use_data(FISHERY_PURPOSES, overwrite = TRUE)
use_data(AREAS_OF_OPERATION, overwrite = TRUE)
use_data(LOA_CLASSES, overwrite = TRUE)
use_data(GEAR_GROUPS, overwrite = TRUE)
use_data(GEARS, overwrite = TRUE)
use_data(GEAR_CONFIGURATIONS, overwrite = TRUE)
use_data(FISHING_MODES, overwrite = TRUE)
use_data(TARGET_SPECIES, overwrite = TRUE)
use_data(REASONS_DAYS_LOST, overwrite = TRUE)  # v2
use_data(CARDINAL_POINTS, overwrite = TRUE)    # v2
use_data(VESSEL_SECTIONS, overwrite = TRUE)    # v2
use_data(VESSEL_TYPES, overwrite = TRUE)       # v2
use_data(VESSEL_ARCHITECTURES, overwrite = TRUE)
use_data(VESSEL_SIZE_TYPES, overwrite = TRUE)
use_data(HULL_MATERIAL_TYPES, overwrite = TRUE)  # v2
use_data(MECHANISATION_TYPES, overwrite = TRUE)
use_data(FISH_PRESERVATION_METHODS, overwrite = TRUE) # renamed from preservation_methods
use_data(FISH_STORAGE_TYPES, overwrite = TRUE)        # v2
use_data(WASTE_CATEGORIES, overwrite = TRUE) # v2
use_data(WASTE_DISPOSAL_METHODS, overwrite = TRUE) # v2
use_data(OFFAL_MANAGEMENT_TYPES, overwrite = TRUE) # v2
use_data(POLE_MATERIAL_TYPES, overwrite = TRUE) # v2
use_data(LINE_MATERIAL_TYPES, overwrite = TRUE) # v2
use_data(BRANCHLINE_STORAGES, overwrite = TRUE) # v2
use_data(HOOK_TYPES, overwrite = TRUE) # v2
use_data(GILLNET_MATERIAL_TYPES, overwrite = TRUE)  # v2
use_data(NET_COLOURS, overwrite = TRUE) # v2NET_DEPLOY_DEPTHS # v2
use_data(NET_SETTING_STRATEGIES, overwrite = TRUE) # v2
use_data(NET_CONFIGURATIONS, overwrite = TRUE) # v2
use_data(NET_CONDITIONS, overwrite = TRUE) # v2
use_data(FLOAT_TYPES, overwrite = TRUE) # v2
use_data(SINKER_MATERIAL_TYPES, overwrite = TRUE) # v2 
use_data(SURFACE_FISHERY_ACTIVITIES, overwrite = TRUE) # v2 

use_data(CATCH_UNITS, overwrite = TRUE)
use_data(DISCARD_UNITS, overwrite = TRUE)
use_data(EFFORT_UNITS, overwrite = TRUE)
use_data(FISH_PROCESSING_TYPES, overwrite = TRUE) # renamed from PROCESSING_TYPES
use_data(STUNNING_METHODS, overwrite = TRUE) # v2
use_data(BAIT_FISHING_METHODS, overwrite = TRUE) # v2
use_data(SCHOOL_TYPE_CATEGORIES, overwrite = TRUE) #v2
use_data(SCHOOL_SIGHTING_CUES, overwrite = TRUE) #v2
use_data(SCHOOL_DETECTION_METHODS, overwrite = TRUE) #v2
use_data(BAIT_SCHOOL_DETECTION_METHODS, overwrite = TRUE) #v2
use_data(BUOY_MODELS, overwrite = TRUE) # v2
use_data(BUOY_ACTIVITY_TYPES, overwrite = TRUE)
use_data(FOB_ACTIVITY_TYPES,  overwrite = TRUE)
use_data(FOB_TYPES, overwrite = TRUE)
use_data(FAD_RAFT_DESIGNS, overwrite = TRUE) #v2
use_data(FAD_TAIL_DESIGNS, overwrite = TRUE) #v2
use_data(MITIGATION_DEVICES, overwrite = TRUE) #v2
use_data(LIGHT_TYPES, overwrite = TRUE) #v2
use_data(LIGHT_COLOURS, overwrite = TRUE) #v2
use_data(STREAMER_TYPES, overwrite = TRUE) #v2
use_data(DEHOOKER_TYPES, overwrite = TRUE) #v2

# BIOLOGY DOMAIN ####

## Extract the data from IOTC database
SPECIES = biology_domain("V_SPECIES", columns = toupper(c("code", "name_en", "name_fr", "name_scientific", "is_iotc", "is_aggregate", "species_category_code", "species_category_name_en", "species_category_name_fr")))

TYPES_OF_FATE        = biology_domain("TYPES_OF_FATE")
FATES                = biology_domain("FATES")
RETAIN_REASONS       = biology_domain("V_RETAIN_REASONS",  columns = c("code", "name_en", "name_fr"))
DISCARD_REASONS      = biology_domain("V_DISCARD_REASONS", columns = c("code", "name_en", "name_fr"))
CONDITIONS           = biology_domain("INDIVIDUAL_CONDITIONS")
DEPREDATION_SOURCES  = biology_domain("DEPREDATION_SOURCES")
SCARS                = biology_domain("SCARS")
TAG_TYPES            = biology_domain("TAG_TYPES")

## Sampling ####
SAMPLING_PERIODS     = biology_domain("SAMPLING_PERIODS")
SAMPLING_PROTOCOLS   = biology_domain("SAMPLING_PROTOCOLS")
SAMPLE_TYPES         = biology_domain("SAMPLE_TYPES")
SEX                  = biology_domain("SEX")
MATURITY_STAGES      = biology_domain("MATURITY_STAGES")
SAMPLING_METHODS_FOR_SAMPLING_COLLECTIONS = biology_domain("SAMPLING_METHODS_FOR_SAMPLING_COLLECTIONS")
SAMPLING_METHODS_FOR_CATCH_ESTIMATION = biology_domain("SAMPLING_METHODS_FOR_CATCH_ESTIMATION")
SAMPLE_PRESERVATION_METHODS = biology_domain("SAMPLE_PRESERVATION_METHODS")

## Morphometrics ####
TYPES_OF_MEASUREMENT = biology_domain("TYPES_OF_MEASUREMENT")
MEASUREMENTS         = biology_domain("MEASUREMENTS")
MEASUREMENT_TOOLS    = biology_domain("MEASUREMENT_TOOLS")

## Save package data as rda in data folder
use_data(SPECIES,              overwrite = TRUE)
use_data(TYPES_OF_FATE,        overwrite = TRUE)
use_data(FATES,                overwrite = TRUE)
use_data(DISCARD_REASONS,      overwrite = TRUE)
use_data(RETAIN_REASONS,       overwrite = TRUE)
use_data(CONDITIONS,           overwrite = TRUE)
use_data(DEPREDATION_SOURCES,  overwrite = TRUE)  #v2
use_data(SCARS,                overwrite = TRUE)  #v2
use_data(TAG_TYPES,            overwrite = TRUE)  #v2
use_data(SAMPLING_PERIODS,     overwrite = TRUE)  #v2
use_data(SAMPLING_PROTOCOLS,   overwrite = TRUE)  #v2
use_data(SAMPLE_TYPES,         overwrite = TRUE)  #v2
use_data(SEX,                  overwrite = TRUE)  #v2
use_data(MATURITY_STAGES,      overwrite = TRUE)  #v2
use_data(SAMPLING_METHODS_FOR_SAMPLING_COLLECTIONS, overwrite = TRUE) #v2
use_data(SAMPLING_METHODS_FOR_CATCH_ESTIMATION, overwrite = TRUE) #v2
use_data(SAMPLE_PRESERVATION_METHODS, overwrite = TRUE) #v2
use_data(TYPES_OF_MEASUREMENT, overwrite = TRUE)
use_data(MEASUREMENTS,         overwrite = TRUE)
use_data(MEASUREMENT_TOOLS,    overwrite = TRUE)

# DATA DOMAIN ####

## Extract the data from IOTC database
DATA_TYPES       = data_domain("TYPES")
DATA_RAISINGS    = data_domain("RAISINGS")

# These shall be further specialized by type of dataset...
DATA_SOURCES        = data_domain("SOURCES")
DATA_PROCESSINGS    = data_domain("PROCESSINGS")
DATA_ESTIMATIONS    = data_domain("ESTIMATIONS")
DATA_COVERAGE_TYPES = data_domain("COVERAGE_TYPES")

## Save package data as rda in data folder
use_data(DATA_TYPES,       overwrite = TRUE)
use_data(DATA_RAISINGS,    overwrite = TRUE)
use_data(DATA_SOURCES,     overwrite = TRUE)
use_data(DATA_PROCESSINGS, overwrite = TRUE)
use_data(DATA_ESTIMATIONS, overwrite = TRUE)
use_data(DATA_COVERAGE_TYPES, overwrite = TRUE)

# LEGACY DOMAIN ####

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
LEGACY_FISHERY_TYPES = legacy_domain("FISHERY_TYPES")
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

LEGACY_SPECIES_IOTDB = query(DB_IOTDB(), "SELECT * FROM meta.species")
LEGACY_SPECIES_IOTDB = LEGACY_SPECIES_IOTDB[CODE %in% LEGACY_SPECIES$CODE] # includes SORT for factorisation

LEGACY_FATES = legacy_domain("FATES")

LEGACY_SAMPLED_CATCH_TYPES = legacy_domain("SAMPLED_CATCH_TYPES")

LEGACY_CATCH_UNITS = legacy_domain("CATCH_UNITS")

LEGACY_EFFORT_UNITS = legacy_domain("EFFORT_UNITS")

# Temp fix pour EFFORT_UNITS to feed the Data Browser
LEGACY_EFFORT_UNITS_IOTDB = query(DB_IOTDB(), "SELECT * FROM meta.EFFORT_UNITS")
LEGACY_SCHOOL_TYPES = legacy_domain("SCHOOL_TYPES")
LEGACY_MEASUREMENT_TYPES = legacy_domain("MEASUREMENT_TYPES")
LEGACY_MEASURE_TYPES_IOTDB = query(DB_IOTDB(), "SELECT * FROM meta.MEASURE_TYPES")
LEGACY_MEASUREMENT_TOOLS = legacy_domain("MEASUREMENT_TOOLS")
LEGACY_RAISINGS = legacy_domain("RAISINGS")
LEGACY_BOAT_TYPES = legacy_domain("BOAT_TYPES")
LEGACY_FAD_ACTIVITY_TYPES = legacy_domain("FAD_ACTIVITY_TYPES")
LEGACY_FAD_TYPES = legacy_domain("FAD_TYPES")
LEGACY_FAD_OWNERSHIPS = legacy_domain("FAD_OWNERSHIPS")

## Save package data as rda in data folder
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
use_data(LEGACY_EFFORT_UNITS_IOTDB, overwrite = TRUE)
use_data(LEGACY_SCHOOL_TYPES, overwrite = TRUE)
use_data(LEGACY_MEASUREMENT_TYPES, overwrite = TRUE)
use_data(LEGACY_MEASURE_TYPES_IOTDB, overwrite = TRUE)
use_data(LEGACY_MEASUREMENT_TOOLS, overwrite = TRUE)
use_data(LEGACY_RAISINGS, overwrite = TRUE)
use_data(LEGACY_BOAT_TYPES, overwrite = TRUE)    # To rename
use_data(LEGACY_FAD_ACTIVITY_TYPES, overwrite = TRUE)
use_data(LEGACY_FAD_TYPES, overwrite = TRUE)
use_data(LEGACY_FAD_OWNERSHIPS, overwrite = TRUE)

# Other codelists (that should be added in IOTC_master)
# Currently downloaded in the R library: iotc-lib-base-common-data/R/iotc_base_common_data_factors.R

LEGACY_CONDITION_TYPES_IOTDB = legacy_domain("condition_types")
LEGACY_FATE_TYPES_IOTDB = legacy_domain("fate_types")

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

