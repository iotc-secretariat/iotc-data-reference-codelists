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
| ROS_references.CL_DISPOSAL_METHODS                 | Yes                    | refs_fishery.WASTE_DISPOSAL_METHODS                       |
| ROS_references.CL_FAD_RAFT_DESIGNS                 | Yes                    | refs_fishery.FAD_RAFT_DESIGNS                             |
| ROS_references.CL_FAD_TAIL_DESIGNS                 | Yes                    | refs_fishery.FAD_TAIL_DESIGNS                             |
| Ros_references.CL_HULL_MATERIALS                   | Yes                    | refs_fishery.HULL_MATERIAL_TYPES                          |
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
| ROS_references.CL_LENGTH_MEASURING_TOOLS           | Yes                    | refs_biological.MEASUREMENT_TOOLS                         |
| ROS_references.CL_LIGHT_COLOURS                    | Yes                    | refs_fishery.LIGHT_COLOURS                                |
| ROS_references.CL_LIGHT_TYPES                      | Yes                    | refs_fishery.LIGHT_TYPES                                  |
| ROS_references.CL_LINE_MATERIAL_TYPES              | Yes                    | refs_fishery.LINE_MATERIAL_TYPES                          |
| ROS_references.CL_MITIGATION_DEVICES               | Yes                    | refs_fishery.MITIGATION_DEVICES                           |
| ROS_references.CL_NET_COLOURS                      | Yes                    | refs_fishery.NET_COLOURS                                  |
| ROS_references.CL_NET_CONDITIONS                   | Yes                    | refs_fishery.NET_CONDITIONS                               |
| ROS_references.CL_NET_CONFIGURATIONS               | Yes                    | refs_fishery.NET_CONFIGURATIONS                           |
| Ros_references.CL_NET_DEPLOY_DEPTHS                | Yes                    | refs_fishery.NET_DEPLOY_DEPTHS                            |
| ROS_references.CL_NET_SETTING_STRATEGIES           | Yes                    | refs_fishery.NET_SETTING_STRATEGIES                       |
| Ros_references.CL_PORTS                            | Yes                    | refs_admin.PORTS                                          |
| Ros_references.CL_PROCESSING_TYPES                 | Yes                    | refs_fishery.FISH_PROCESSING_TYPES                        |
| ROS_references.CL_SAMPLING_PROTOCOLS               | Yes                    | refs_biological.SAMPLING_PROTOCOLS                        |
| ROS_references.CL_SCARS                            | No                     |                                                           |
| ROS_references.CL_SCHOOL_DETECTION_METHODS         | Yes                    | refs_fishery.SCHOOL_DETECTION_METHODS                     |
| Ros_references.CL_SCHOOL_SIGHTING_CUES             | Yes                    | refs_fishery.SCHOOL_SIGHTING_CUES                         |
| Ros_references.CL_SCHOOL_TYPE_CATEGORIES           | Yes                    | refs_fishery.SCHOOL_TYPE_CATEGORIES                       |
| Ros_references.CL_SEXES                            | Yes                    | refs_biological.SEX                                       |
| ROS_references.CL_SINKER_MATERIAL_TYPES            | Yes                    | refs_fishery.SINKER_MATERIAL_TYPES                        |
| Ros_references.CL_SPECIES                          | Yes                    | refs_biological.SPECIES                                   |
| Ros_references.CL_STUNNING_METHODS                 | Yes                    | refs_fishery.STUNNING_METHODS                             |
| ROS_references.CL_TAG_TYPES                        | Yes                    | refs_biological.TAG_TYPES                                 |
| ROS_references.CL_WASTE_CATEGORIES                 | Yes                    | refs_fishery.WASTE_CATEGORIES                             |
| ROS_references.CL_WEIGHT_ESTIMATION_METHODS        | Yes                    | refs_biological.MEASUREMENT_TOOLS                         |
| Ros_references.CL_WIND_SCALES                      | Yes                    | refs_fishery.WIND_SCALES                                  |

## Actions

For all these tables:

1.disseminate them back to Ros (use the exactly same schema than in IOTC_Master)
2.replace the existing ros_references.XXX table by this one
3.remove the existing ros_references.XXX table

# Differences between ROS and IOTC_Statistics

We list here only tables not covered by the previous section and that are needed by some functions, procedures or views 
in Ros database.

| Ros table name                                   | IOTC_Statistics table name        | New schema name |
|--------------------------------------------------|-----------------------------------|-----------------|
| ROS_references.CL_ACTIVITIES                     | CL_ACTIVITIES                     | refs_fishery    |
| ROS_references.CL_INCIDENTAL_CAPTURES_CONDITIONS | CL_INCIDENTAL_CAPTURES_CONDITIONS | refs_biological |
| ROS_references.CL_SCARS                          | CL_SCARS                          | refs_biological |

## Actions

For all these tables:

1.clean them (remove columns CREATOR_ID, CREATION_DATE, UPDATER_ID, UPDATE_DATE)
2.remove the ```CL_``` prefix on the table name
3.import them to IOTC_Master in the correct schema
4.disseminate them back to ROS
5.replace the existing ros_references.XXX table 
6.remove the existing ros_references.XXX table 

# Changes to make to IOTC_master (code-lists tables) (manu)

| Action | IOTC_Master table name         | IOTC_Statistics table name        | Comment |
|--------|--------------------------------|-----------------------------------|---------|
| Add    | refs_legacy.SPECIES_CONDITIONS | SPECIES_CONDITIONS                | (1)     |
| Rename | refs_fishery.BOAT_CLASS_TYPES  | refs_fishery.VESSEL_SIZE_TYPES    | (2)     |
| Rename | refs_fishery.BOAT_LOCATIONS    | refs_fishery.VESSEL_SECTIONS      |         |
| Rename | refs_fishery.BOAT_TYPES        | refs_fishery.VESSEL_ARCHITECTURES |         |
| Move   | dbo.BOAT_SIZE_CLASS            | refs_legacy.BOAT_SIZE_CLASS       | (3)     |

Notes:
1.Remove the view which comes from IOTCStatistics
2.I actually cannot find the table BOAT_LOCATIONS in the ROS model while it is supposed to be required in the hauling 
   operations of longline.If not used anywhere in the ROS, the table should be removed (to check with Cynthia)
3.table improved

# Changes to make to IOTC_master (other tables) (manu)

- Rename IOTC_master.dbo.1_DI to IOTC_master.dataset.DISCARDS (done)
- Rename IOTC_master.dbo.1_RC to IOTC_master.dataset.RETAINED_CATCHES (to do)
- Remove IOTC_master.dbo.3_BU since this dataset -- managed in a dedicated Postgres database (done)
- Rename IOTC_master.dbo.3_EF to IOTC_master.dataset.EFFORTS (to do)
- Rename IOTC_master.dbo.3_EF_CA to IOTC_master.dataset.EFFORTS_CATCHES (to do)
- Rename IOTC_master.dbo.4_SF to IOTC_master.dataset.SIZE_FREQUENCIES (to do)
- Remove IOTC_master.dbo.TEMP_TRADUCTION_AREAS when sure it is not useful (done)

Also, all table and view names could become singular.This should be done in a second step as the code lists are 
exported to the library iotc.data.reference.codelist which is required by the Shiny Apps of the Data Validators and 
Data Browser (ongoing work led by manu Blondel).

# Changes to apply to replace Ros code-lists to IOTC_Master code-lists

| Ros_table                                          | IOTC_Master_table                                         | target_table                                              | target_column                       | target_column_new_name                |
|----------------------------------------------------|-----------------------------------------------------------|-----------------------------------------------------------|-------------------------------------|---------------------------------------|
| ROS_analysis.FLAG_TO_FLEET                         | refs_admin.FLEET_TO_FLAGS_AND_FISHERIES                   |                                                           |                                     |                                       |
| ROS_references.cl_fishing_ground_types             | refs_gis.AREA_TYPES                                       |                                                           |                                     |                                       |
| Ros_references.CL_SCHOOL_TYPE_CATEGORIES           | refs_fishery.SCHOOL_TYPE_CATEGORIES                       |                                                           |                                     |                                       |
| ROS_references.CL_COUNTRIES                        | refs_admin.COUNTRIES                                      |                                                           |                                     |                                       |
| ROS_references.CL_FISH_STORAGE_TYPES               | refs_fishery.FISH_STORAGE_TYPES                           |                                                           |                                     |                                       |
| ROS_references.CL_FLOAT_TYPES                      | refs_fishery.FLOAT_TYPES                                  |                                                           |                                     |                                       |
| Ros_references.CL_GEAR_TYPES                       | refs_fishery_config.GEARS                                 |                                                           |                                     |                                       |
| Ros_references.CL_GILLNET_MATERIAL_TYPES           | refs_fishery.GILLNET_MATERIAL_TYPES                       |                                                           |                                     |                                       |
| ROS_references.CL_ACTIVITIES                       | refs_biological.BAIT_CONDITIONS                           | ros_common.activity_details                               | activity_id                         | activity_code                         |
| ROS_references.CL_BAIT_CONDITIONS                  | refs_biological.BAIT_CONDITIONS                           | ros_ll.ll_additional_catch_details_on_ssi                 | bait_condition_id                   | bait_condition_code                   |
| ROS_references.CL_BAIT_CONDITIONS                  | refs_biological.BAIT_CONDITIONS                           | ros_pl.baits_and_conditions                               | bait_condition_id                   | bait_condition_code                   |
| ROS_references.CL_BAIT_CONDITIONS                  | refs_biological.BAIT_CONDITIONS                           | ros_ll.baits_by_conditions                                | bait_condition_id                   | bait_condition_code                   |
| ROS_references.CL_BAIT_FISHING_METHODS             | refs_fishery.BAIT_FISHING_METHODS                         | ros_pl.bait_fishing_operations                            | bait_fishing_method_id              | bait_fishing_method_code              |
| ROS_references.CL_BAIT_SCHOOL_DETECTION_METHODS    | refs_fishery.BAIT_SCHOOL_DETECTION_METHODS                | ros_pl.bait_fishing_operations                            | bait_school_detection_method_id     | bait_school_detection_method_code     |
| ROS_references.CL_BIO_COLLECTION_SAMPLING_METHODS  | refs_biological.SAMPLING_METHODS_FOR_SAMPLING_COLLECTIONS | ros_common.biometric_information                          | bio_collection_sampling_method_id   | bio_collection_sampling_method_code   |
| Ros_references.CL_CATCH_ESTIMATES_SAMPLING_METHODS | refs_biological.SAMPLING_METHODS_FOR_CATCH_ESTIMATION     | ros_pl.pl_catch_details                                   | estimated_weight_sampling_method_id | estimated_weight_sampling_method_code |
| Ros_references.CL_CATCH_ESTIMATES_SAMPLING_METHODS | refs_biological.SAMPLING_METHODS_FOR_CATCH_ESTIMATION     | ros_ll.ll_catch_details                                   | estimated_weight_sampling_method_id | estimated_weight_sampling_method_code |
| Ros_references.CL_CATCH_ESTIMATES_SAMPLING_METHODS | refs_biological.SAMPLING_METHODS_FOR_CATCH_ESTIMATION     | ros_gn.gn_catch_details                                   | estimated_weight_sampling_method_id | estimated_weight_sampling_method_code |
| Ros_references.CL_CATCH_ESTIMATES_SAMPLING_METHODS | refs_biological.SAMPLING_METHODS_FOR_CATCH_ESTIMATION     | ros_ps.ps_catch_details                                   | estimated_weight_sampling_method_id | estimated_weight_sampling_method_code |
| ROS_references.CL_COUNTRIES                        | refs_admin.COUNTRIES                                      | ros_gn.gn_observer_data                                   | reporting_country_id                | reporting_country_code                |
| ROS_references.CL_COUNTRIES                        | refs_admin.COUNTRIES                                      | ros_common.person_details                                 | nationality_id                      | nationality_code                      |
| ROS_references.CL_COUNTRIES                        | refs_admin.COUNTRIES                                      | ros_common.carrier_vessel_identification                  | vessel_flag_id                      | vessel_flag_code                      |
| ROS_references.CL_COUNTRIES                        | refs_admin.COUNTRIES                                      | ros_common.iotc_person_details                            | nationality_id                      | nationality_code                      |
| ROS_references.CL_COUNTRIES                        | refs_admin.COUNTRIES                                      | ros_common.observer_identification                        | nationality_id                      | nationality_code                      |
| ROS_references.CL_COUNTRIES                        | refs_admin.COUNTRIES                                      | ros_common.person_contact_details                         | nationality_id                      | nationality_code                      |
| ROS_references.CL_COUNTRIES                        | refs_admin.COUNTRIES                                      | ros_ps.ps_observer_data                                   | reporting_country_id                | reporting_country_code                |
| ROS_references.CL_COUNTRIES                        | refs_admin.COUNTRIES                                      | ros_common.iotc_person_contact_details                    | nationality_id                      | nationality_code                      |
| ROS_references.CL_COUNTRIES                        | refs_admin.COUNTRIES                                      | ros_common.vessel_identification                          | flag_id                             | flag_code                             |
| ROS_references.CL_COUNTRIES                        | refs_admin.COUNTRIES                                      | ros_common.locations                                      | country_id                          | country_code                          |
| ROS_references.CL_COUNTRIES                        | refs_admin.COUNTRIES                                      | ros_ll.ll_observer_data                                   | reporting_country_id                | reporting_country_code                |
| ROS_references.CL_COUNTRIES                        | refs_admin.COUNTRIES                                      | ros_pl.pl_observer_data                                   | reporting_country_id                | reporting_country_code                |
| ROS_references.CL_DEHOOKER_DEVICES                 | refs_fishery.DEHOOKER_TYPES                               | ros_ll.ll_additional_catch_details_on_ssi                 | dehooker_device_id                  | dehooker_device_code                  |
| ROS_references.CL_DISPOSAL_METHODS                 | refs_fishery.WASTE_DISPOSAL_METHODS                       | ros_common.waste_managements                              | waste_storage_or_disposal_method_id | waste_storage_or_disposal_method_code |
| ROS_references.CL_FAD_RAFT_DESIGNS                 | refs_fishery.FAD_RAFT_DESIGNS                             | ros_ps.ps_object_details                                  | fad_raft_design_id                  | fad_raft_design_code                  |
| ROS_references.CL_FAD_TAIL_DESIGNS                 | refs_fishery.FAD_TAIL_DESIGNS                             | ros_ps.ps_object_details                                  | fad_tail_design_id                  | fad_tail_design_code                  |
| Ros_references.CL_FATES                            | refs_biological.FATES                                     | ros_ll.ll_catch_details                                   | fates_id                            | fates_code                            |
| Ros_references.CL_FATES                            | refs_biological.FATES                                     | ros_ps.ps_catch_details                                   | fates_id                            | fates_code                            |
| Ros_references.CL_FATES                            | refs_biological.FATES                                     | ros_pl.pl_catch_details                                   | fates_id                            | fates_code                            |
| Ros_references.CL_FATES                            | refs_biological.FATES                                     | ros_gn.gn_catch_details                                   | fates_id                            | fates_code                            |
| ROS_references.CL_FISH_PRESERVATION_METHODS        | refs_fishery.FISH_PRESERVATION_METHODS                    | ros_common.vessel_attributes_fish_preservation_method     | fish_preservation_method_id         | fish_preservation_method_code         |
| ROS_references.CL_GEAR_INTERACTIONS                | refs_biological.GEAR_INTERACTIONS                         | ros_gn.gn_additional_catch_details_on_ssi                 | gear_interaction_id                 | gear_interaction_code                 |
| ROS_references.CL_GEAR_INTERACTIONS                | refs_biological.GEAR_INTERACTIONS                         | ros_pl.pl_additional_catch_details_on_ssi                 | gear_interaction_id                 | gear_interaction_code                 |
| ROS_references.CL_GEAR_INTERACTIONS                | refs_biological.GEAR_INTERACTIONS                         | ros_ll.ll_additional_catch_details_on_ssi                 | gear_interaction_id                 | gear_interaction_code                 |
| ROS_references.CL_GEAR_INTERACTIONS                | refs_biological.GEAR_INTERACTIONS                         | ros_ps.ps_additional_catch_details_on_ssi                 | gear_interaction_id                 | gear_interaction_code                 |
| ROS_references.CL_HANDLING_METHODS                 | refs_biological.HANDLING_METHODS                          | ros_gn.gn_additional_catch_details_on_ssi                 | handling_method_id                  | handling_method_code                  |
| ROS_references.CL_HANDLING_METHODS                 | refs_biological.HANDLING_METHODS                          | ros_pl.pl_additional_catch_details_on_ssi                 | handling_method_id                  | handling_method_code                  |
| ROS_references.CL_HANDLING_METHODS                 | refs_biological.HANDLING_METHODS                          | ros_ll.ll_additional_catch_details_on_ssi                 | handling_method_id                  | handling_method_code                  |
| ROS_references.CL_HANDLING_METHODS                 | refs_biological.HANDLING_METHODS                          | ros_ps.ps_additional_catch_details_on_ssi                 | handling_method_id                  | handling_method_code                  |
| Ros_references.CL_HOOKS                            | refs_fishery.HOOK_TYPES                                   | ros_pl.pl_general_gear_attributes                         | hook_type_id                        | hook_type_code                        |
| ROS_references.CL_HOOKS                            | refs_fishery.HOOK_TYPES                                   | ros_pl.lures_or_jiggers_by_type                           | hook_type_id                        | hook_type_code                        |
| ROS_references.CL_HOOKS                            | refs_fishery.HOOK_TYPES                                   | ros_ll.hooks_by_type                                      | hook_type_id                        | hook_type_code                        |
| ROS_references.CL_HULL_MATERIALS                   | refs_fishery.HULL_MATERIAL_TYPES                          | ros_common.vessel_attributes                              | hull_material_id                    | hull_material_code                    |
| ROS_references.CL_INCIDENTAL_CAPTURES_CONDITIONS   | refs_biological.INCIDENTAL_CAPTURES_CONDITIONS            | ros_common.additional_details_on_non_target_species       | condition_at_capture_id             | condition_at_capture_code             |
| ROS_references.CL_INCIDENTAL_CAPTURES_CONDITIONS   | refs_biological.INCIDENTAL_CAPTURES_CONDITIONS            | ros_common.additional_details_on_non_target_species       | condition_at_release_id             | condition_at_release_code             |
| Ros_references.CL_LENGTH_MEASUREMENT_TYPES         | refs_biological.MEASUREMENTS                              | ros_common.measured_lengths                               | measured_length_type_id             | measured_length_type_code             |
| ROS_references.CL_LENGTH_MEASURING_TOOLS           | refs_biological.MEASUREMENT_TOOLS                         | ros_common.measured_lengths                               | length_measuring_tool_id            | length_measuring_tool_code            |
| ROS_references.CL_LIGHT_COLOURS                    | refs_fishery.LIGHT_COLOURS                                | ros_ll.lights_by_type_and_colour                          | light_colour_id                     | light_colour_code                     |
| ROS_references.CL_LIGHT_TYPES                      | refs_fishery.LIGHT_TYPES                                  | ros_ll.lights_by_type_and_colour                          | light_type_id                       | light_type_code                       |
| ROS_references.CL_LINE_MATERIAL_TYPES              | refs_fishery.LINE_MATERIAL_TYPES                          | ros_ll.branchline_sections                                | branchline_material_type_id         | branchline_material_type_code         |
| ROS_references.CL_LINE_MATERIAL_TYPES              | refs_fishery.LINE_MATERIAL_TYPES                          | ros_ll.ll_additional_catch_details_on_ssi                 | leader_material_type_id             | leader_material_type_code             |
| ROS_references.CL_LINE_MATERIAL_TYPES              | refs_fishery.LINE_MATERIAL_TYPES                          | ros_ll.ll_general_gear_attributes                         | line_material_type_id               | line_material_type_code               |
| ROS_references.CL_MITIGATION_DEVICES               | refs_fishery.MITIGATION_DEVICES                           | ros_gn.gn_mitigation_measures_mitigation_devices          | mitigation_device_id                | mitigation_device_code                |
| ROS_references.CL_MITIGATION_DEVICES               | refs_fishery.MITIGATION_DEVICES                           | ros_ll.ll_mitigation_measures_mitigation_devices          | mitigation_device_id                | mitigation_device_code                |
| ROS_references.CL_MITIGATION_DEVICES               | refs_fishery.MITIGATION_DEVICES                           | ros_ll.ll_gear_specifications_mitigation_device           | mitigation_device_id                | mitigation_device_code                |
| ROS_references.CL_NET_COLOURS                      | refs_fishery.NET_COLOURS                                  | ros_gn.gn_gillnet_configuration_net_web_colours           | net_colour_id                       | net_colour_code                       |
| ROS_references.CL_NET_CONDITIONS                   | refs_fishery.NET_CONDITIONS                               | ros_gn.gn_hauling_operations                              | net_condition_id                    | net_condition_code                    |
| ROS_references.CL_NET_CONFIGURATIONS               | refs_fishery.NET_CONFIGURATIONS                           | ros_gn.gn_setting_operations                              | net_configuration_id                | net_configuration_code                |
| Ros_references.CL_NET_DEPLOY_DEPTHS                | refs_fishery.NET_DEPLOY_DEPTHS                            | ros_gn.gn_setting_operations                              | net_deploy_depth_id                 | net_deploy_depth_code                 |
| ROS_references.CL_NET_SETTING_STRATEGIES           | refs_fishery.NET_SETTING_STRATEGIES                       | ros_gn.gn_setting_operations                              | net_setting_strategy_id             | net_setting_strategy_code             |
| Ros_references.CL_PORTS                            | refs_admin.PORTS                                          | ros_common.carrier_vessel_identification                  | vessel_registration_port_id         | vessel_registration_port_code         |
| Ros_references.CL_PORTS                            | refs_admin.PORTS                                          | ros_common.vessel_identification                          | port_id                             | port_code                             |
| Ros_references.CL_PORTS                            | refs_admin.PORTS                                          | ros_common.vessel_trip_details                            | departure_port_id                   | departure_port_code                   |
| Ros_references.CL_PORTS                            | refs_admin.PORTS                                          | ros_common.vessel_trip_details                            | return_port_id                      | return_port_code                      |
| Ros_references.CL_PROCESSING_TYPES                 | refs_fishery.FISH_PROCESSING_TYPES                        | ros_common.species_by_product_type                        | processing_type_id                  | processing_type_code                  |
| Ros_references.CL_PROCESSING_TYPES                 | refs_fishery.FISH_PROCESSING_TYPES                        | ros_common.estimated_weights                              | processing_type_id                  | processing_type_code                  |
| Ros_references.CL_PROCESSING_TYPES                 | refs_fishery.FISH_PROCESSING_TYPES                        | ros_common.measured_weights                               | processing_type_id                  | processing_type_code                  |
| ROS_references.CL_SAMPLING_PROTOCOLS               | refs_biological.SAMPLING_PROTOCOLS                        | ros_ll.ll_hauling_operations                              | sampling_protocol_id                | sampling_protocol_code                |
| ROS_references.CL_SAMPLING_PROTOCOLS               | refs_biological.SAMPLING_PROTOCOLS                        | ros_pl.pl_tuna_fishing_operations                         | sampling_protocol_id                | sampling_protocol_code                |
| ROS_references.CL_SAMPLING_PROTOCOLS               | refs_biological.SAMPLING_PROTOCOLS                        | ros_pl.bait_fishing_operations                            | sampling_protocol_id                | sampling_protocol_code                |
| ROS_references.CL_SAMPLING_PROTOCOLS               | refs_biological.SAMPLING_PROTOCOLS                        | ros_gn.gn_hauling_operations                              | sampling_protocol_id                | sampling_protocol_code                |
| ROS_references.CL_SCARS                            | refs_biological.SCARS                                     | ros_common.depredation_details                            | depredation_source_id               | depredation_source_code               |
| ROS_references.CL_SCHOOL_DETECTION_METHODS         | refs_fishery.SCHOOL_DETECTION_METHODS                     | ros_ps.ps_setting_operations                              | first_school_detection_method_id    | first_school_detection_method_code    |
| Ros_references.CL_SCHOOL_SIGHTING_CUES             | refs_fishery.SCHOOL_SIGHTING_CUES                         | ros_pl.bait_fishing_operations_cl_school_sighting_cues    | school_sighting_cue_id              | school_sighting_cue_code              |
| Ros_references.CL_SCHOOL_SIGHTING_CUES             | refs_fishery.SCHOOL_SIGHTING_CUES                         | ros_ps.ps_setting_operations_cl_school_sighting_cues      | school_sighting_cue_id              | school_sighting_cue_code              |
| Ros_references.CL_SCHOOL_SIGHTING_CUES             | refs_fishery.SCHOOL_SIGHTING_CUES                         | ros_pl.pl_tuna_fishing_operations_cl_school_sighting_cues | school_sighting_cue_id              | school_sighting_cue_code              |               
| Ros_references.CL_SEXES                            | refs_biological.SEX                                       | ros_common.biometric_information                          | sex_id                              | sex_code                              |
| ROS_references.CL_SINKER_MATERIAL_TYPES            | refs_fishery.SINKER_MATERIAL_TYPES                        | ros_gn.sinkers_by_type                                    | sinker_material_type_id             | sinker_material_type_code             |
| Ros_references.CL_SPECIES                          | refs_biological.SPECIES                                   | ros_common.depredation_details                            | predator_observed_id                | predator_observed_code                |
| Ros_references.CL_SPECIES                          | refs_biological.SPECIES                                   | ros_pl.pl_catch_details                                   | species_id                          | species_code                          |
| Ros_references.CL_SPECIES                          | refs_biological.SPECIES                                   | ros_ps.ps_catch_details                                   | species_id                          | species_code                          |
| Ros_references.CL_SPECIES                          | refs_biological.SPECIES                                   | ros_pl.pl_tuna_fishing_operations_target_species          | target_species_id                   | target_species_code                   |
| Ros_references.CL_SPECIES                          | refs_biological.SPECIES                                   | ros_gn.gn_catch_details                                   | species_id                          | species_code                          |
| Ros_references.CL_SPECIES                          | refs_biological.SPECIES                                   | ros_ll.ll_setting_operations_target_species               | target_species_id                   | target_species_code                   |
| Ros_references.CL_SPECIES                          | refs_biological.SPECIES                                   | ros_common.vessel_identification_licensed_target_species  | licensed_target_species_id          | licensed_target_species_code          |
| Ros_references.CL_SPECIES                          | refs_biological.SPECIES                                   | ros_ll.ll_catch_details                                   | species_id                          | species_code                          |
| Ros_references.CL_SPECIES                          | refs_biological.SPECIES                                   | ros_ps.cetaceans_whale_shark_sightings                    | species_id                          | species_code                          |
| Ros_references.CL_SPECIES                          | refs_biological.SPECIES                                   | ros_common.species_by_product_type                        | species_id                          | species_code                          |
| Ros_references.CL_SPECIES                          | refs_biological.SPECIES                                   | ros_pl.baits_and_conditions                               | species_id                          | species_code                          |
| Ros_references.CL_SPECIES                          | refs_biological.SPECIES                                   | ros_ll.baits_by_conditions                                | species_id                          | species_code                          |
| Ros_references.CL_STUNNING_METHODS                 | refs_fishery.STUNNING_METHODS                             | ros_ll.ll_hauling_operations_stunning_methods             | stunning_method_id                  | stunning_method_code                  |
| ROS_references.CL_TAG_TYPES                        | refs_biological.TAG_TYPES                                 | ros_pl.pl_tag_details                                     | tag_type_id                         | tag_type_code                         |
| ROS_references.CL_TAG_TYPES                        | refs_biological.TAG_TYPES                                 | ros_ps.ps_tag_details                                     | tag_type_id                         | tag_type_code                         |
| ROS_references.CL_TAG_TYPES                        | refs_biological.TAG_TYPES                                 | ros_gn.gn_tag_details                                     | tag_type_id                         | tag_type_code                         |
| ROS_references.CL_TAG_TYPES                        | refs_biological.TAG_TYPES                                 | ros_ll.ll_tag_details                                     | tag_type_id                         | tag_type_code                         |
| ROS_references.CL_WASTE_CATEGORIES                 | refs_fishery.WASTE_CATEGORIES                             | ros_common.waste_managements                              | waste_category_id                   | waste_category_code                   |
| ROS_references.CL_WEIGHT_ESTIMATION_METHODS        | refs_biological.MEASUREMENT_TOOLS                         | ros_common.estimated_weights                              | weight_estimation_method_id         | weight_estimation_method_code         |
| Ros_references.CL_WIND_SCALES                      | refs_fishery.WIND_SCALES                                  | ros_ps.ps_setting_operations                              | wind_scale_id                       | wind_scale_code                       |
| Ros_references.CL_WIND_SCALES                      | refs_fishery.WIND_SCALES                                  | ros_pl.pl_tuna_fishing_operations                         | wind_scale_id                       | wind_scale_code                       |
| Ros_references.CL_WIND_SCALES                      | refs_fishery.WIND_SCALES                                  | ros_pl.bait_fishing_operations                            | wind_scale_id                       | wind_scale_code                       |

