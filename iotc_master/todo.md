# Abstract

Main actions to perform on **IOTC_Master** to produce version **1.0.0**

[draft]

# General 

* [x] Add ```description_en``` and ```description_fr``` on each code-lists (1)
* [x] Review ```refs_admin.countries``` code-list (use common field names ```name_en,name_fr,description_en,description_fr```) (1)
* [x] Review ```refs_admin.entities``` code-list (use common field names ```name_en,name_fr,description_en,description_fr```) (1)
* [x] Rename code-list foreign keys name from ```xxx_id``` to ```xxx_code```
* [ ] Remove plural in any code-list name
* [x] Remove ```id,creation_date,list_en,list_fr``` for any code-list (2)
* [ ] Remove some views (with no extra value) (3)
* [ ] Add a new historisation system (linked with **Zenodo DOI**)
  * [ ] Delete ```refs_meta.code_lists_versions``` table and replace it by ```refs_admin.history```
  * [ ] Delete ```refs_meta``` schema
  * [ ] Add triggers on code-list tables to record any change in the ```refs_admin.history``` table. 

## Note 1

See [sql file](01-add-descriptions.sql). We exclude the following tables:

```
codelists_versions
cpc_history
cpc_to_flags
fleet_to_flags_and_fisheries
species_reporting_requirements
recommended_measurements
gear_fishery_type_to_configuration_bkp
gear_fishery_type_to_configuration
gear_fishery_type_to_fishing_mode
gear_fishery_type_to_fishing_mode_bkp
gear_to_fishery_type
gear_to_fishery_type_bkp
gear_to_fishery_type_new
gear_to_target_species
currencies
```

## Note 2

See [sql file](02-remove-columns.sql). We exclude the ```refs_legacy``` schema and the following tables:

```
ports
species
```

and remove the following columns:

```
id
creation_date
list_name_en
list_name_fr
```

## Note 3

Here are the views, Manu please validate which views should be removed.

| Table                                                | Remove ? |
|------------------------------------------------------|----------|
| refs_admin.v_current_cpcs                            | [ ]      |
| refs_admin.v_entities                                | [ ]      |
| refs_admin.v_fleets_out                              | [ ]      |
| refs_biological.v_discard_reasons                    | [ ]      |
| refs_biological.v_length_measurement_tools           | [ ]      |
| refs_biological.v_length_measurements                | [ ]      |
| refs_biological.v_recommended_length_measurements    | [ ]      |
| refs_biological.v_recommended_measurements           | [ ]      |
| refs_biological.v_recommended_weight_measurements    | [ ]      |
| refs_biological.v_retain_reasons                     | [x]      |
| refs_biological.v_species                            | [ ]      |
| refs_biological.v_species_baits                      | [ ]      |
| refs_biological.v_species_cetaceans                  | [ ]      |
| refs_biological.v_species_cetaceans_and_whale_sharks | [ ]      |
| refs_biological.v_species_iotc                       | [ ]      |
| refs_biological.v_species_others                     | [ ]      |
| refs_biological.v_species_predators                  | [ ]      |
| refs_biological.v_species_seabirds                   | [ ]      |
| refs_biological.v_species_sharks_and_rays            | [ ]      |
| refs_biological.v_species_ssi                        | [ ]      |
| refs_biological.v_species_target                     | [ ]      |
| refs_biological.v_species_turtles                    | [ ]      |
| refs_biological.v_weight_measurement_tools           | [x]      |
| refs_biological.v_weight_measurements                | [x]      |
| refs_fishery.v_afob_activity_types                   | [ ]      |
| refs_fishery.v_afob_types                            | [ ]      |
| refs_fishery.v_dfob_activity_types                   | [ ]      |
| refs_fishery.v_dfob_types                            | [ ]      |
| refs_fishery.v_fisheries_details                     | [ ]      |
| refs_fishery.v_fisheries_out                         | [ ]      |
| refs_legacy.v_fishery_groups                         | [ ]      |
| refs_legacy.v_fishery_types                          | [ ]      |
| refs_legacy.v_gear_types                             | [ ]      |
| refs_socio_economics.v_countries_currencies          | [ ]      |