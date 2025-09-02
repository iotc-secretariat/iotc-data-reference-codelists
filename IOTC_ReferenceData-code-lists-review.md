# Abstract

This document describes the ongoing improvements in the IOTC code lists.

# References Tables To Remove

Remove a few backup tables (_bkp) used to update the inputs for the fishery wizard. The SQL server IOTC_master database can be used as sandbox.

```
DROP TABLE IF EXISTS refs_fishery_config.gear_to_fishery_type_new;
DROP TABLE IF EXISTS refs_fishery_config.fishery_types_new;
DROP TABLE IF EXISTS refs_fishery_config.gear_to_fishery_type_bkp;
DROP TABLE IF EXISTS refs_fishery_config.fishery_types_bkp;
DROP TABLE IF EXISTS refs_fishery_config.gear_fishery_type_to_configuration_bkp;
DROP TABLE IF EXISTS refs_fishery_config.gear_fishery_type_to_fishing_mode_bkp;
``` 

# Reference Tables To Add

## Legacy Tables

Historical tables which include a SORT column and are required by in some IOTC R libraries. Note those tables were extracted from the SQL Server database IOTDB and exported to Zenodo/GitHub. Including them in IOTC_ReferenceData will remove the dependency on the IOTDB database.

-   refs_meta.CONDITION_TYPES
<!--```         
CREATE TABLE refs_legacy.CONDITION_TYPES(
  SORT INTEGER, 
  CODE VARCHAR(16) PRIMARY KEY NOT NULL,  
  NAME_EN VARCHAR(64) 
)
``` -->
-   refs_meta.FATE_TYPES
-   refs_meta.FISHERY_TYPES
-   refs_meta.FISHING_GROUNDS
-   refs_meta.IUCN_STATUS
-   refs_meta.RAISINGS
-   refs_meta.SPECIES_CATEGORIES
-   refs_meta.SPECIES_GROUPS
-   refs_meta.WORKING_PARTIES

## New tables for ROS

These reference tables aim to support the collection of biological samples by the observer. They are in the data dictionary but currently miss from the reporting forms.

<!-- - Position of offal disposal (position code) - use [refs_fishery.vessel_sections](https://data.iotc.org/reference/latest/domain/fisheries/#vesselSections) -->
- refs_biology.macro_maturity_stage: Maturity scale and stage
- refs_biology.sample_type: e.g., otoliths, spine clippings, and genetic samples
- refs_biology.sample_preservation_method: e.g., preservation method (e.g., alcohol, frozen, etc.)
- refs_biology.sample_destination: destination, i.e., location to be sent/stored

# To Modify

## refs_socio_economics.currencies

```
ALTER TABLE refs_socio_economics.currencies
RENAME COLUMN currency_code TO code;

ALTER TABLE refs_socio_economics.currencies
RENAME COLUMN currency_name TO name_en;

ALTER TABLE refs_socio_economics.currencies
ADD COLUMN name_fr VARCHAR(255);

COMMENT ON TABLE refs_socio_economics.currencies IS 'Stores information on currencies following ISO 4217 currency codes';

COMMENT ON COLUMN refs_socio_economics.currencies.code IS 'Alphabetic code from list of ISO 4217 currency codes';
```

# Changes in Common Code Lists

| Schema | Table | Revisions |
|:-----------------|:-------------------|:----------------------------------|
| refs_admin | PORTS | ```ALTER TABLE refs_admin.ports DROP COLUMN description_fr, DROP COLUMN description_en;``` |
| refs_admin | IO_MAIN_AREAS | ```UPDATE refs_admin.io_main_areas SET description_fr = 'Partie Est de la zone de compétence de la CTOI correspondant à la zone FAO 57', description_en = 'Eastern part of the IOTC area of competence corresponding to FAO area 57' WHERE code = 'IREASIO'``` |
| refs_admin | IO_MAIN_AREAS | ```UPDATE refs_admin.io_main_areas SET description_fr = 'Partie ouest de la zone de compétence de la CTOI correspondant à la zone FAO 51 dont la ligne occidentale a été étendue de 20 à 30 degrés est', description_en = 'Western part of the IOTC area of competence corresponding to FAO area 51, whose western boundary has been extended from 20 to 30 degrees east' WHERE code = 'IRWESIO'``` |
| refs_data | ESTIMATIONS | ```ALTER TABLE refs_data.estimations DROP COLUMN description_fr, DROP COLUMN description_en;``` |
| refs_data | TYPES | ```UPDATE refs_data.types SET description_fr = 'TO DO', description_en = 'TO DO'``` |
| refs_data | COVERAGE_TYPES | **Add Events and include descriptions for all fields, especially to differentiate sets/events** |
| refs_data | DATASETS | **removed "datasets" from each definition label, original definitions as descriptions |
| refs_data | PROCESSINGS | **HARD TO DO - we should revisit definitions** |
| refs_data | RAISINGS | descriptions + definitions |
| refs_data | SOURCES | descriptions = definitions, definitions revised |
| refs_biology | SAMPLING_PERIODS | ```ALTER TABLE refs_biology.sampling_periods DROP COLUMN description_fr, DROP COLUMN description_en;``` |
| refs_biology | SAMPLING_PROTOCOLS | ```ALTER TABLE refs_biology.sampling_protocols DROP COLUMN description_fr, DROP COLUMN description_en;``` |
| refs_biology | SEX | ```ALTER TABLE refs_biology.sex DROP COLUMN description_fr, DROP COLUMN description_en;``` |
| refs_biology | TYPES_OF_FATE | ```ALTER TABLE refs_biology.types_of_fate DROP COLUMN description_fr, DROP COLUMN description_en;``` |
| refs_biology | SPECIES | ```ALTER TABLE refs_biology.species DROP COLUMN description_fr, DROP COLUMN description_en;``` |
| refs_biology | SPECIES_AGGREGATES | **added columns "name_en", "name_fr", and "name_scientific". The descriptions = the names in fr and en respectively. NOTE\* species have multiple aggregate codes. Would they report multiple codes? or do we need to include a distinction in the descriptions?** |
| refs_biology | SPECIES_CATEGORIES | ```ALTER TABLE refs_biology.species_categories DROP COLUMN description_fr, DROP COLUMN description_en;``` |
| refs_biology | SPECIES_GROUPS | ```ALTER TABLE refs_biology.species_groups DROP COLUMN description_fr, DROP COLUMN description_en;``` |
| refs_fishery | FISHERIES | description = definitions **To shorten??** |
| refs_fishery | FOB_TYPES | descriptions = definitions **review French translations** |

# Changes in ROS Code List Component

## Changes in Structure

| Schema | Table | Revisions |
|:-----------------|:-------------------|:----------------------------------|
| refs_biology | BAIT_CONDITIONS | ```ALTER TABLE refs_biology.bait_conditions DROP COLUMN description_fr, DROP COLUMN description_en;``` |
| refs_biology | BAIT_TYPES | ```ALTER TABLE refs_biology.bait_types DROP COLUMN description_fr, DROP COLUMN description_en;``` |
| refs_biology | DEPREDATION_SOURCES | ```ALTER TABLE refs_biology.depredation_sources DROP COLUMN description_fr, DROP COLUMN description_en;``` |
| refs_biology | MEASUREMENT_TOOLS | ```ALTER TABLE refs_biology.measurement_tools DROP COLUMN description_fr, DROP COLUMN description_en;``` |
| refs_biology | SAMPLING_METHODS_FOR_CATCH_ESTIMATION | ```ALTER TABLE refs_biology.sampling_methods_for_catch_estimation DROP COLUMN description_fr, DROP COLUMN description_en;``` |
| refs_biology | SAMPLING_METHODS_FOR_SAMPLING_COLLECTIONS | ```ALTER TABLE refs_biology.sampling_methods_for_sampling_collections DROP COLUMN description_fr, DROP COLUMN description_en;``` |
| refs_fishery | BAIT_FISHING_METHODS | ```ALTER TABLE refs_fishery.bait_fishing_methods DROP COLUMN description_fr, DROP COLUMN description_en;``` |
| refs_fishery | BRANCHLINE_STORAGES | ```ALTER TABLE refs_fishery.branchline_storages DROP COLUMN description_fr, DROP COLUMN description_en;``` |
| refs_fishery | BUOY_ACTIVITY_TYPES | **To define descriptions** |
| refs_fishery | CATCH_UNITS | ```ALTER TABLE refs_fishery.branchline_storages DROP COLUMN description_fr, DROP COLUMN description_en;``` |
| refs_fishery | DEHOOKER_TYPES | ```ALTER TABLE refs_fishery.dehooker_types DROP COLUMN description_fr, DROP COLUMN description_en;``` |
| refs_fishery | FISH_STORAGE_TYPES | ```ALTER TABLE refs_fishery.fish_storage_types DROP COLUMN description_fr, DROP COLUMN description_en;``` |
| refs_fishery | FLOAT_TYPES | ```ALTER TABLE refs_fishery.float_types DROP COLUMN description_fr, DROP COLUMN description_en;``` |
| refs_fishery | FOB_ACTIVITY_TYPES | **To do** |
| refs_fishery | FISH_PRESERVATION_METHODS | ```ALTER TABLE refs_fishery.fish_preservation_methods DROP COLUMN description_fr, DROP COLUMN description_en;``` |
| refs_fishery | GEAR_TYPES | ```ALTER TABLE refs_fishery.gear_types DROP COLUMN description_fr, DROP COLUMN description_en;``` **table to remove and replace by refs_fishery_config.gear_groups** |
| refs_fishery | GILLNET_MATERIAL_TYPES | ```ALTER TABLE refs_fishery.gillnet_material_types DROP COLUMN description_fr, DROP COLUMN description_en;``` |
| refs_fishery | HOOK_TYPES | ```ALTER TABLE refs_fishery.hook_types DROP COLUMN description_fr, DROP COLUMN description_en;``` |
| refs_fishery | HULL_MATERIAL_TYPES | ```ALTER TABLE refs_fishery.hull_material_types DROP COLUMN description_fr, DROP COLUMN description_en;``` |
| refs_fishery | LIGHT_TYPES | ```ALTER TABLE refs_fishery.light_types DROP COLUMN description_fr, DROP COLUMN description_en;``` |
| refs_fishery | LIGHT_COLOURS | ```ALTER TABLE refs_fishery.light_colours DROP COLUMN description_fr, DROP COLUMN description_en;``` |
| refs_fishery | LINE_MATERIAL_TYPES | ```ALTER TABLE refs_fishery.line_material_types DROP COLUMN description_fr, DROP COLUMN description_en;``` |
| refs_fishery | MECHANIZATION_TYPES | ```ALTER TABLE refs_fishery.mechanization_types RENAME TO mechanisation_types; ALTER TABLE refs_fishery.mechanisation_types DROP COLUMN description_fr, DROP COLUMN description_en; UPDATE refs_fishery.mechanisation_types SET name_fr = 'Inconnu' WHERE code LIKE 'UN';``` |
| refs_fishery | MITIGATION_DEVICES | ```ALTER TABLE refs_fishery.mitigation_devices DROP COLUMN description_fr, DROP COLUMN description_en;``` |
| refs_fishery | NET_COLOURS | ```ALTER TABLE refs_fishery.net_colours DROP COLUMN description_fr, DROP COLUMN description_en;``` |
| refs_fishery | NET_CONFIGURATIONS | ```ALTER TABLE refs_fishery.net_configurations DROP COLUMN description_fr, DROP COLUMN description_en;``` |
| refs_fishery | NET_DEPLOY_DEPTHS | ```ALTER TABLE refs_fishery.net_deploy_depths DROP COLUMN description_fr, DROP COLUMN description_en;``` |
| refs_fishery | NET_SETTING_STRATEGIES | ```ALTER TABLE refs_fishery.net_setting_strategies DROP COLUMN description_fr, DROP COLUMN description_en;``` |
| refs_fishery | OFFAL_MANAGEMENT_TYPES | **code_orig to remove;** ```ALTER TABLE refs_fishery.offal_management_types DROP COLUMN description_fr, DROP COLUMN description_en;``` |
| refs_fishery | POLE_MATERIAL_TYPES | ```ALTER TABLE refs_fishery.pole_material_types DROP COLUMN description_fr, DROP COLUMN description_en;``` |
| refs_fishery | REASONS_DAYS_LOST | ```ALTER TABLE refs_fishery.reasons_days_lost DROP COLUMN description_fr, DROP COLUMN description_en;``` |
| refs_fishery | SCHOOL_DETECTION_METHODS | ```ALTER TABLE refs_fishery.school_detection_methods DROP COLUMN description_fr, DROP COLUMN description_en;``` |
| refs_fishery | SCHOOL_TYPE_CATEGORIES | ```ALTER TABLE refs_fishery.school_type_categories DROP COLUMN description_fr, DROP COLUMN description_en;``` **Would benefit from descriptions*** |
| refs_fishery | SINKER_MATERIAL_TYPES | ```ALTER TABLE refs_fishery.sinker_material_types DROP COLUMN description_fr, DROP COLUMN description_en;``` |
| refs_fishery | STREAMER_TYPES | **code_orig to remove;** ```ALTER TABLE refs_fishery.streamer_types DROP COLUMN description_fr, DROP COLUMN description_en;``` |
| refs_fishery | STUNNING_METHODS | ```ALTER TABLE refs_fishery.stunning_methods DROP COLUMN description_fr, DROP COLUMN description_en;``` |
| refs_fishery | TRANSHIPMENT_CATEGORIES | ```ALTER TABLE refs_fishery.transhipment_categories DROP COLUMN description_fr, DROP COLUMN description_en;``` |
| refs_fishery | VESSEL_ARCHITECTURES | ```ALTER TABLE refs_fishery.vessel_architectures DROP COLUMN description_fr, DROP COLUMN description_en;``` |
| refs_fishery | VESSEL_SECTIONS | ```ALTER TABLE refs_fishery.vessel_sections DROP COLUMN description_fr, DROP COLUMN description_en;``` |
| refs_fishery | VESSEL_SIZE_TYPES | ```ALTER TABLE refs_fishery.vessel_size_types DROP COLUMN description_fr, DROP COLUMN description_en;``` |
| refs_fishery | WASTE_CATEGORIES | ```ALTER TABLE refs_fishery.waste_categories DROP COLUMN description_fr, DROP COLUMN description_en;``` |
| refs_fishery | WASTE_DISPOSAL_METHODS | ```ALTER TABLE refs_fishery.waste_disposal_methods DROP COLUMN description_fr, DROP COLUMN description_en;``` |
| refs_fishery | WIND_SCALES | **Add descriptions available [here](https://www.weather.gov/mfl/beaufort) - To remove as not required?**  |

## Changes in Values

Some improvements were made to the ROS code lists. The tables must now be imported in the ROS and IOTC_ReferenceData databases.

| Schema | Table | Revisions |
|:-----------------|:-------------------|:----------------------------------|
| refs_biology | DEPREDATION_SOURCES | ```UPDATE refs_biology.depredation_sources SET name_fr = 'Requins / baleines odontocètes' WHERE code = 'SW';``` |
| refs_biology | FATES | simplified definitions, descriptions are original definitions (refs_biological.FATES.edited.csv) |
| refs_biology | GEAR_INTERACTIONS | simplified definitions, descriptions are original definitions |
| refs_biology | HANDLING_METHODS | removed "using a" from definitions, descriptions are original definitions |
| refs_biology | INCIDENTAL_CAPTURE_CONDITIONS | descriptions = definitions, maybe "stunned" needs better distinction from unknown |
| refs_biology | INDIVIDUAL CONDITIONS | descriptions = definitions, maybe "stunned" needs better distinction from unknown |
| refs_biology | SCARS | revised definition: sharks or cetaceans. Description identifies cetaceans as false killer whales,short-finned pilot whales, killer whales |
| refs_biology | TAG_TYPES | shortened definitions, original definitions used for descriptions |
| refs_biology | TYPES_OF_MEASUREMENT | shortened definitions, original definitions used for descriptions |
| refs_biology | RECOMMENDED_MEASUREMENTS | copied file but did not edit, unsure what to define/describe |
| refs_fishery | ACTIVITIES | descriptions = definitions, definitions revised |
| refs_fishery | BAIT_SCHOOL_DETECTION_METHODS | descriptions = definitions, definitions shortened |
| refs_fishery | CARDINAL_POINTS | descriptions = definitions, but are their specific decimal degrees we want to use?? |
| refs_fishery | EFFORT_UNITS | descriptions = definitions, definitions shortened, \*\* how are we defining sets and trips?? |
| refs_fishery | FAD_RAFT_DESIGNS | descriptions = definitions, definitions shortened |
| refs_fishery | FAD_TAIL_DESIGNS | descriptions = definitions, definitions shortened |
| refs_fishery | FISH_PROCESSING_TYPES | descriptions = definitions, definitions shortened |
| refs_fishery | NET_CONDITIONS | descriptions = definitions, definitions revised |
| refs_fishery | SCHOOL_SIGHTING_CUES | descriptions = definitions, definitions shortened |
| refs_fishery | SURFACE_FISHERY_ACTIVITIES | descriptions = definitions, definitions shortened |

## Update Table refs_meta.codelists_versions

This tables provides information on the version of each table and date of last update. It is required for generating these two fields for each code list in the IOTC Reference Data Catalogue as well as in the webpages describing the forms. The new tables added (see section [Reference Tables To Add](#reference-tables-to-add))

| Schema | Table | Revisions |
|:-----------------|:-------------------|:----------------------------------|
refs_meta | codelists_versions | ```INSERT INTO refs_meta.codelists_versions(cl_schema, cl_name, version, last_update) VALUES ('refs_admin', 'PORTS', 0, '2025-08-25 11:30:00');``` |
refs_meta | codelists_versions | ```INSERT INTO refs_meta.codelists_versions(cl_schema, cl_name, version, last_update) VALUES ('refs_biology', 'RECOMMENDED_MEASUREMENTS', 0, '2024-02-13 00:00:00');``` |
refs_meta | codelists_versions | ```UPDATE refs_meta.codelists_versions SET cl_schema = REPLACE(cl_schema, 'refs_biological', 'refs_biology');``` |
refs_meta | codelists_versions | ```DELETE FROM refs_meta.codelists_versions WHERE cl_schema = 'refs_biological_config';``` |
refs_meta | codelists_versions | ```UPDATE refs_meta.codelists_versions SET last_update = '2023-11-02 00:00:00' WHERE CL_NAME = 'FOB_ACTIVITY_TYPES';``` |
refs_meta | codelists_versions | ```INSERT INTO refs_meta.codelists_versions(cl_schema, cl_name, version, last_update) VALUES ('refs_fishery', 'WASTE_DISPOSAL_METHODS', 0, '2025-08-25 11:30:00');``` |
refs_meta | codelists_versions | ```DELETE FROM refs_meta.codelists_versions WHERE CL_NAME = 'SAMPLING_METHODS_FOR_CATCH_ESTIM';``` |
refs_meta | codelists_versions | ```INSERT INTO refs_meta.codelists_versions(cl_schema, cl_name, version, last_update) VALUES ('refs_biology', 'WEIGHT_ESTIMATION_METHODS', 0, '2023-05-12 00:00:00');``` |