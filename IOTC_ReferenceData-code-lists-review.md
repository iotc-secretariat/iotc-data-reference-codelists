# Abstract

This document describes the ongoing improvements in the IOTC code lists.

# Reference Tables To Add

## Legacy Tables

Historical tables which include a SORT column and are required by in some IOTC R libraries. Note those tables were extracted from the SQL Server database IOTDB and exported to Zenodo/GitHub. Including them in IOTC_ReferenceData will remove the dependency on the IOTDB database.

-   refs_meta.CONDITION_TYPES

```         
CREATE TABLE refs_meta.CONDITION_TYPES(
  SORT INTEGER, 
  CODE VARCHAR(16) PRIMARY KEY NOT NULL,  
  NAME_EN VARCHAR(64) 
)
```

-   refs_meta.FATE_TYPES
-   refs_meta.FISHERY_TYPES
-   refs_meta.FISHING_GROUNDS
-   refs_meta.IUCN_STATUS
-   refs_meta.RAISINGS
-   refs_meta.SPECIES_CATEGORIES
-   refs_meta.SPECIES_GROUPS
-   refs_meta.WORKING_PARTIES

# To Modify

## refs_socio_economics.currencies

```{sql}
ALTER TABLE refs_socio_economics.currencies
RENAME COLUMN currency_code TO code;

ALTER TABLE refs_socio_economics.currencies
RENAME COLUMN currency_name TO name_en;

ALTER TABLE refs_socio_economics.currencies
ADD COLUMN name_fr VARCHAR(255);

COMMENT ON TABLE refs_socio_economics.currencies IS 'Stores information on currencies following ISO 4217 currency codes';

COMMENT ON COLUMN refs_socio_economics.currencies.code IS 'Alphabetic code from list of ISO 4217 currency codes';
```

# Changes in ROS Code List Component

## Changes in Structure

| Schema | Table | Revisions |
|:-----------------|:-------------------|:----------------------------------|
| refs_biology | BAIT_CONDITIONS | "ALTER TABLE refs_biology.bait_conditions DROP COLUMN description_fr, DROP COLUMN description_en;" |
| refs_biology | BAIT_TYPES | "ALTER TABLE refs_biology.bait_types DROP COLUMN description_fr, DROP COLUMN description_en;" |
| refs_biology | DEPREDATION_SOURCES | "ALTER TABLE refs_biology.depredation_sources DROP COLUMN description_fr, DROP COLUMN description_en;" |
| refs_biology | MEASUREMENT_TOOLS | descriptions = definitions |
| refs_biology | SAMPLING_METHODS_FOR_CATCH_ESTIMATION | "ALTER TABLE refs_biology.sampling_methods_for_catch_estimation DROP COLUMN description_fr, DROP COLUMN description_en;" |
| refs_biology | SAMPLING_METHODS_FOR_SAMPLING_COLLECTIONS | "ALTER TABLE refs_biology.sampling_methods_for_sampling_collections DROP COLUMN description_fr, DROP COLUMN description_en;" |
| refs_biology | SAMPLING_PERIODS | "ALTER TABLE refs_biology.sampling_periods DROP COLUMN description_fr, DROP COLUMN description_en;" |
| refs_biology | SAMPLING_PROTOCOLS | "ALTER TABLE refs_biology.sampling_protocols DROP COLUMN description_fr, DROP COLUMN description_en;" |
| refs_biology | SEX | description = definition |
| refs_biology | TYPES_OF_FATE | descriptions = definitions |
| refs_data | ESTIMATIONS | descriptions = definitions |
| refs_data | TYPES | descriptions = definitions |
| refs_fishery | BAIT_FISHING_METHODS | descriptions = definitions |
| refs_fishery | BRANCHLINE_STORAGE | descriptions = definitions |
| refs_fishery | BUOY_ACTIVITY_TYPES | descriptions = definitions |
| refs_fishery | CATCH_UNITS | descriptions = definitions |
| refs_fishery | DEHOOKER_TYPES | descriptions = definitions |
| refs_fishery | FISH_STORAGE_TYPES | descriptions = definitions |
| refs_fishery | FLOAT_TYPES | description = definition |
| refs_fishery | FOB_ACTIVITY_TYPES | descriptions = definitions |
| refs_fishery | FISH_PRESERVATION_METHODS | descriptions = definitions |
| refs_fishery | GEAR_TYPES | descriptions = definitions |
| refs_fishery | GILLNET_MATERIAL_TYPES | descriptions = definitions |
| refs_fishery | HOOK_TYPES | descriptions = definitions |
| refs_fishery | HULL_MATERIAL_TYPES | descriptions = definitions |
| refs_fishery | LIGHT_COLOURS | descriptions = definitions |
| refs_fishery | LINE_MATERIAL_TYPES | descriptions = definitions |
| refs_fishery | MECHANIZATION_TYPES | descriptions = definitions |
| refs_fishery | MITIGATION_DEVICES | descriptions = definitions |
| refs_fishery | NET_COLOURS | descriptions = definitions |
| refs_fishery | NET_CONFIGURATIONS | descriptions = definitions |
| refs_fishery | NET_DEPLOY_DEPTH | descriptions = definitions |
| refs_fishery | NET_SETTING_STRATEGIES | descriptions = definitions |
| refs_fishery | OFFAL_MANAGEMENT_TYPES | descriptions = definitions |
| refs_fishery | POLE_MATERIAL_TYPES | descriptions = definitions |
| refs_fishery | REASONS_DAYS_LOST | descriptions = definitions |
| refs_fishery | SCHOOL_DETECTION_METHOD | descriptions = definitions |
| refs_fishery | SCHOOL_TYPE_CATEGORIES | descriptions = definitions |
| refs_fishery | SINKER_MATERIAL_TYPES | descriptions = definitions |
| refs_fishery | STREAMER_TYPES | descriptions = definitions |
| refs_fishery | STUNNING_METHODS | descriptions = definitions |
| refs_fishery | TRANSHIPMENT_CATEGORIES | descriptions = definitions |
| refs_fishery | VESSEL_ARCHITECTURES | descriptions =definitions |
| refs_fishery | VESSEL_SECTIONS | descriptions = definitions |
| refs_fishery | VESSEL_SIZE_TYPES | descriptions = definitions |
| refs_fishery | WASTE_CATEGORIES | descriptions = definitions |
| refs_fishery | WASTE_DISPOSAL_METHODS | descriptions = definitions |
| refs_fishery | WIND_SCALES | description = definitions |

## Changes in Values

Some improvements were made to the ROS code lists:

| Schema | Table | Revisions |
|:-----------------|:-------------------|:----------------------------------|
| refs_biology | DEPREDATION_SOURCES | "Requins / Baleines odontocètes" changed to "Requins / baleines odontocètes" |
| refs_biology | FATES | simplified definitions, descriptions are original definitions (refs_biological.FATES.edited.csv) |
| refs_biology | GEAR_INTERACTIONS | simplified definitions, descriptions are original definitions |
| refs_biology | HANDLING_METHODS | removed "using a" from definitions, descriptions are original definitions |
| refs_biology | INCIDENTAL_CAPTURE_CONDITIONS | descriptions = definitions, maybe "stunned" needs better distinction from unknown |
| refs_biology | INDIVIDUAL CONDITIONS | descriptions = definitions, maybe "stunned" needs better distinction from unknown |
| refs_biology | SCARS | revised definition: sharks or cetaceans. Description identifies cetaceans as false killer whales,short-finned pilot whales, killer whales |
| refs_biology | SPECIES | description = definition, there are separate species for scientific names and other classifications. Should those be included in definitions |
| refs_biology | SPECIES_AGGREGATES | added columns "name_en", "name_fr", and "name_scientific". The descriptions = the names in fr and en respectively. NOTE\* species have multiple aggregate codes. Would they report multiple codes? or do we need to include a distinction in the descriptions? |
| refs_biology | SPECIES_CATEGORIES | description = definition, but do you want to identify individual species? |
| refs_biology | SPECIES_GROUPS | description = definition, but do you want to identify individual species? |
| refs_biology | TAG_TYPES | shortened definitions, original definitions used for descriptions |
| refs_biology | TYPES_OF_MEASUREMENT | shortened definitions, original definitions used for descriptions |
| refs_biology | RECOMMENDED_MEASUREMENTS | copied file but did not edit, unsure what to define/describe |
| refs_data | COVERAGE_TYPES | descriptions = definitions, should agree on / add definitions for sets/events\* |
| refs_data | DATASETS | removed "datasets" from each definition label, original definitions as descriptions |
| refs_data | PROCESSINGS | HARD TO DO - we should revisit definitions |
| refs_data | RAISINGS | descriptions + definitions |
| refs_data | SOURCES | descriptions = definitions, definitions revised |
| refs_fishery | ACTIVITIES | descriptions = definitions, definitions revised |
| refs_fishery | BAIT_SCHOOL_DETECTION_METHODS | descriptions = definitions, definitions shortened |
| refs_fishery | CARDINAL_POINTS | descriptions = definitions, but are their specific decimal degrees we want to use?? |
| refs_fishery | EFFORT_UNITS | descriptions = definitions, definitions shortened, \*\* how are we defining sets and trips?? |
| refs_fishery | FAD_RAFT_DESIGNS | descriptions = definitions, definitions shortened |
| refs_fishery | FAD_TAIL_DESIGNS | descriptions = definitions, definitions shortened |
| refs_fishery | FISH_PROCESSING_TYPES | descriptions = definitions, definitions shortened |
| refs_fishery | FISHERIES | description = definitions \*\*do we want to shorten?? will become acronyms |
| refs_fishery | FOB_TYPES | descriptions = definitions \*\* review French translations |
| refs_fishery | NET_CONDITIONS | descriptions = definitions, definitions revised |
| refs_fishery | SCHOOL_SIGHTING_CUES | descriptions = definitions, definitions shortened |
| refs_fishery | SURFACE_FISHERY_ACTIVITIES | descriptions = definitions, definitions shortened |
