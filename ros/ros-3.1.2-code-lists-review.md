# Abstract

This document summarize reviews of Code-lists in the Ros database _3.1.2_. 

As we want to get a standalone Ros database, we need to import some code-lists from IOTC_Master and IOTC_Statistics.

We also want to have all code-lists in IOTC_Master to manage them in only one place.

We will disseminate code-lists from IOTC_Master to Ros.

As a state of play, let's:

* see differences between Ros and IOTC_Master databases
* see differences between IOTC_Statistics and IOTC_Master databases and need to be push back in it (and in Ros database also)

# Differences between ROS and IOTC_Master databases

Here is all ROS Code-lists table and their pending in the IOTC_Master database.

| Ros table name                                     | Present in IOTC_Master | IOTC_Master table name                                    |
|----------------------------------------------------|------------------------|-----------------------------------------------------------|
| ROS_analysis.FLAG_TO_FLEET                         | Yes                    | refs_admin.FLEET_TO_FLAGS_AND_FISHERIES                   |
| ROS_references.CL_ACTIVITIES                       | No                     |                                                           |
| ROS_references.CL_BAIT_CONDITIONS                  | Yes                    | refs_biological.BAIT_CONDITIONS                           |
| ROS_references.CL_BAIT_FISHING_METHODS             | Yes                    | refs_fishery.BAIT_FISHING_METHODS                         |
| Ros_references.CL_BAIT_SCHOOL_DETECTION_METHODS    | Yes                    | refs_fishery.BAIT_SCHOOL_DETECTION_METHODS                |
| ROS_references.CL_BIO_COLLECTION_SAMPLING_METHODS  | Yes                    | refs_biological.SAMPLING_METHODS_FOR_SAMPLING_COLLECTIONS |
| Ros_references.CL_CATCH_ESTIMATES_SAMPLING_METHODS | Yes                    | refs_biological.SAMPLING_METHODS_FOR_CATCH_ESTIMATION     |
| ROS_references.CL_COUNTRIES                        | Yes                    | refs_admin.COUNTRIES                                      |
| ROS_references.CL_DEHOOKER_DEVICES                 | Yes                    | refs_fishery.DEHOOKER_TYPES                               |
| ROS_references.CL_DISPOSAL_METHODS                 | No                     | refs_fishery.WASTE_DISPOSAL_METHODS                       |
| ROS_references.CL_FAD_RAFT_DESIGNS                 | Yes                    | refs_fishery.FAD_RAFT_DESIGNS                             |
| ROS_references.CL_FAD_TAIL_DESIGNS                 | Yes                    | refs_fishery.FAD_TAIL_DESIGNS                             |
| Ros_references.CL_FATES                            | Yes                    | refs_biological.FATES                                     |
| Ros_references.CL_FISHING_GROUND                   | Yes                    | refs_gis.AREAS                                            |
| Ros_references.CL_FISHING_GROUND_TYPES             | Yes                    | refs_gis.AREA_TYPES                                       |
| ROS_references.CL_FISH_PRESERVATION_METHODS        | Yes                    | refs_fishery.FISH_PRESERVATION_METHODS                    |
| ROS_references.CL_FISH_STORAGE_TYPES               | Yes                    | refs_fishery.FISH_STORAGE_TYPES                           |
| ROS_references.CL_FLOAT_TYPES                      | Yes                    | refs_fishery.FLOAT_TYPES                                  |
| ROS_references.CL_GEAR_INTERACTIONS                | Yes                    | refs_biological.GEAR_INTERACTIONS                         |
| Ros_references.CL_GEAR_TYPES                       | Yes                    | refs_fishery_config.GEARS                                 |
| Ros_references.CL_GILLNET_MATERIAL_TYPES           | Yes                    | refs_fishery.GILLNET_MATERIAL_TYPES                       |
| ROS_references.CL_HANDLING_METHODS                 | Yes                    | refs_biological.HANDLING_METHODS                          |
| Ros_references.CL_HOOKS                            | Yes                    | refs_fishery.HOOK_TYPES                                   |
| ROS_references.CL_HULL_MATERIALS                   | No                     | refs_fishery.HULL_MATERIAL_TYPES                          |
| ROS_references.CL_INCIDENTAL_CAPTURES_CONDITIONS   | No                     |                                                           |
| Ros_references.CL_LENGTH_MEASUREMENT_TYPES         | Yes                    | refs_biological.MEASUREMENTS                              |
| ROS_references.CL_LENGTH_MEASURING_TOOLS           | Yes                    | refs_biological.MEASUREMENT_TOOLS.Table                   |
| ROS_references.CL_LIGHT_COLOURS                    | Yes                    | refs_fishery.LIGHT_COLOURS                                |
| ROS_references.CL_LIGHT_TYPES                      | Yes                    | refs_fishery.LIGHT_TYPES                                  |
| ROS_references.CL_LINE_MATERIAL_TYPES              | Yes                    | refs_fishery.LINE_MATERIAL_TYPES                          |
| ROS_references.CL_MITIGATION_DEVICES               | Yes                    | refs_fishery.MITIGATION_DEVICES                           |
| ROS_references.CL_NET_COLOURS                      | Yes                    | refs_fishery.NET_COLOURS                                  |
| ROS_references.CL_NET_CONDITIONS                   | Yes                    | refs_fishery.NET_CONDITIONS                               |
| ROS_references.CL_NET_CONFIGURATIONS               | Yes                    | refs_fishery.NET_CONFIGURATIONS                           |
| Ros_references.CL_NET_DEPLOY_DEPTHS                | Yes                    | refs_fishery_config.GEAR_CONFIGURATIONS                   |
| ROS_references.CL_NET_SETTING_STRATEGIES           | Yes                    | refs_fishery.NET_SETTING_STRATEGIES                       |
| Ros_references.CL_PORTS                            | Yes                    | refs_legacy.UN_LOCODE_PORTS                               |
| Ros_references.CL_PROCESSING_TYPES                 | Yes                    | refs_fishery.FISH_PROCESSING_TYPES                        |
| ROS_references.CL_SAMPLING_PROTOCOLS               | Yes                    | refs_biological.SAMPLING_PROTOCOLS                        |
| ROS_references.CL_SCARS                            | No                     |                                                           |
| ROS_references.CL_SCHOOL_DETECTION_METHODS         | Yes                    | refs_fishery.SCHOOL_DETECTION_METHODS                     |
| Ros_references.CL_SCHOOL_SIGHTING_CUES             | Yes                    | refs_fishery.SCHOOL_SIGHTING_CUES                         |
| Ros_references.CL_SCHOOL_TYPE_CATEGORIES           | Yes                    | refs_fishery_config.FISHING_MODES                         |
| Ros_references.CL_SEXES                            | Yes                    | refs_biological.SEX                                       |
| ROS_references.CL_SINKER_MATERIAL_TYPES            | Yes                    | refs_fishery.SINKER_MATERIAL_TYPES                        |
| Ros_references.CL_SPECIES                          | Yes                    | refs_biological.SPECIES                                   |
| Ros_references.CL_STUNNING_METHODS                 | Yes                    | refs_fishery.STUNNING_METHODS                             |
| ROS_references.CL_TAG_TYPES                        | Yes                    | refs_biological.TAG_TYPES                                 |
| ROS_references.CL_WASTE_CATEGORIES                 | Yes                    | refs_fishery.WASTE_CATEGORIES                             |
| ROS_references.CL_WEIGHT_ESTIMATION_METHODS        | Yes                    | refs_biological.MEASUREMENT_TOOLS                         |
| Ros_references.CL_WIND_SCALES                      | Yes                    | refs_fishery.WIND_SCALES                                  |
| Ros_references.SCHOOL_DETECTION_METHODS            | Yes                    | refs_fishery.SCHOOL_DETECTION_METHODS                     |

## Actions

For all these tables:

1. disseminate them back to Ros (use the exactly same schema than in IOTC_Master)
2. replace the existing ros_references.XXX table by this one
3. remove the existing ros_references.XXX table

# Differences between ROS and IOTC_Statistics

We list here only tables not covered by the previous section and that are need by some functions or views in Ros database.

| Ros table name                                   | Present in IOTC_Statistics | IOTC_Statistics table name        |
|--------------------------------------------------|----------------------------|-----------------------------------|
| ROS_references.CL_ACTIVITIES                     | Yes                        | CL_ACTIVITIES                     |
| ROS_references.CL_DISPOSAL_METHODS               | Yes                        | CL_DISPOSAL_METHODS               |
| ROS_references.CL_HULL_MATERIALS                 | Yes                        | CL_HULL_MATERIAL                  |
| ROS_references.CL_INCIDENTAL_CAPTURES_CONDITIONS | Yes                        | CL_INCIDENTAL_CAPTURES_CONDITIONS |
| ROS_references.CL_SCARS                          | Yes                        | CL_SCARS                          |

## Actions

For all these tables:

1. clean them (remove columns CREATOR_ID, CREATION_DATE, UPDATER_ID, UPDATE_DATE)
2. remove the ```CL_``` prefix on the table name
3. import them to IOTC_Master in the correct schema
4. disseminate them back to ROS
5. replace the existing ros_references.XXX table 
6. remove the existing ros_references.XXX table 

# Changes to make to IOTC_master (manu)

- Create [IOTC_master].[refs_legacy].[SPECIES_CONDITIONS] from [IOTC_master].[refs_legacy].[V_SPECIES_CONDITIONS] and remove the view which comes from IOTCStatistics - [x]
- Rename [IOTC_master].[refs_fishery].[BOAT_CLASS_TYPES] to [IOTC_master].[refs_fishery].[VESSEL_SIZE_TYPES]
- Rename [IOTC_master].[refs_fishery].[BOAT_LOCATIONS] to [IOTC_master].[refs_fishery].[VESSEL_LOCATIONS]
- Rename [IOTC_master].[refs_fishery].[BOAT_TYPES] to [IOTC_master].[refs_fishery].[VESSEL_ARCHITECTURES]
- Change schema of [IOTC_master].[dbo].[BOAT_SIZE_CLASS] to [refs_legacy].[dbo].[BOAT_SIZE_CLASS]
- Rename [IOTC_master].[dbo].[1_DI] to [IOTC_master].[dataset].[DISCARD] - [x]
- Rename [IOTC_master].[dbo].[1_RC] to [IOTC_master].[dataset].[RETAINED_CATCH] - [x]
- Remove [IOTC_master].[dbo].[3_BU] since this dataset will be _a priori_managed in a dedicated Postgres database - [x]
- Rename [IOTC_master].[dbo].[3_EF] to [IOTC_master].[dataset].[EFFORT] - [x]
- Rename [IOTC_master].[dbo].[3_EF_CA] to [IOTC_master].[dataset].[EFFORT_CATCH] - [x]
- Rename [IOTC_master].[dbo].[4_SF] to [IOTC_master].[dataset].[SIZE_FREQUENCY] - [x]
- Remove [IOTC_master].[dbo].[TEMP_TRADUCTION_AREAS] when sure it is not useful

Also, all table and view names coould become singular. This should be done in a second step as the code lists are exported to the library iotc.data.reference.codelist which is required by the Shiny Apps of the Data Validators and Data Browser (ongoing work led by manu Blondel).





