# Abstract

Main actions to perform on **IOTC_Master** to produce version **1.0.0**

**draft**

# General 

* [x] Add column ```code_orig``` on some code-lists to be able to import ROS (1)
* [x] Add ```description_en``` and ```description_fr``` on each code-lists (2)
* [x] Review ```refs_admin.countries``` code-list (use common field names ```name_en,name_fr,description_en,description_fr```) (2)
* [x] Review ```refs_admin.entities``` code-list (use common field names ```name_en,name_fr,description_en,description_fr```) (2)
* [x] Rename code-list foreign keys name from ```xxx_id``` to ```xxx_code```
* [ ] Remove plural in any code-list name
* [x] Remove ```id,creation_date,list_en,list_fr``` for any code-list (3)
* [ ] Remove some views (with no extra value) (4)
* [x] Review ```Ports``` code-list to make code unique (5)
* [x] Add some rows in ```Species``` code-list for Ros import (6)
* [x] Add a new historisation system (linked with **Zenodo DOI**) (7)
  * [x] Delete ```refs_meta.code_lists_versions``` table and replace it by ```history.history```
  * [x] Delete ```refs_meta``` schema
  * [x] Add triggers on code-list tables to record any change in the ```refs_history.history``` table. 
* [x] Rename column ```refs_fishery.vessel_types.vessel_type_code``` to ```refs_fishery.vessel_types.code```

## Note 1

See [03-add-code-orig.sql file](03-add-code-orig.sql). Impacted tables:

```
refs_fishery_config.GEARS
refs_biological.FATES
refs_fishery.fish_preservation_methods
refs_biological.measurements
```

## Note 2

See [02-add-descriptions.sql file](02-add-descriptions.sql). We exclude the following tables:

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

## Note 3

See [06-remove-columns.sql file](06-remove-columns.sql). We exclude the ```refs_legacy``` schema and remove the following columns:

```
id
creation_date
update_date
list_name_en
list_name_fr
remarkable
remarks
comment
```

## Note 4

Here are the views; Manu please validate which views should be removed.

| Table                                                | Remove ? |
|------------------------------------------------------|----------|
| refs_admin.v_current_cpcs                            | ?        |
| refs_admin.v_entities                                | ?        |
| refs_admin.v_fleets_out                              | ?        |
| refs_biological.v_discard_reasons                    | ?        |
| refs_biological.v_length_measurement_tools           | ?        |
| refs_biological.v_length_measurements                | ?        |
| refs_biological.v_recommended_length_measurements    | ?        |
| refs_biological.v_recommended_measurements           | ?        |
| refs_biological.v_recommended_weight_measurements    | ?        |
| refs_biological.v_retain_reasons                     | Yes      |
| refs_biological.v_species                            | ?        |
| refs_biological.v_species_baits                      | ?        |
| refs_biological.v_species_cetaceans                  | ?        |
| refs_biological.v_species_cetaceans_and_whale_sharks | ?        |
| refs_biological.v_species_iotc                       | ?        |
| refs_biological.v_species_others                     | ?        |
| refs_biological.v_species_predators                  | ?        |
| refs_biological.v_species_seabirds                   | ?        |
| refs_biological.v_species_sharks_and_rays            | ?        |
| refs_biological.v_species_ssi                        | ?        |
| refs_biological.v_species_target                     | ?        |
| refs_biological.v_species_turtles                    | ?        |
| refs_biological.v_weight_measurement_tools           | Yes      |
| refs_biological.v_weight_measurements                | Yes      |
| refs_fishery.v_afob_activity_types                   | ?        |
| refs_fishery.v_afob_types                            | ?        |
| refs_fishery.v_dfob_activity_types                   | ?        |
| refs_fishery.v_dfob_types                            | ?        |
| refs_fishery.v_fisheries_details                     | ?        |
| refs_fishery.v_fisheries_out                         | ?        |
| refs_legacy.v_fishery_groups                         | ?        |
| refs_legacy.v_fishery_types                          | ?        |
| refs_legacy.v_gear_types                             | ?        |
| refs_socio_economics.v_countries_currencies          | ?        |

# Note 5

In table ```refs_admin.Ports``` column ```id``` is not unique ?, neither the column ```code```.

The following _SQL_ request gives 54 rows which need to be clarified

```sql
SELECT p1.* FROM refs_admin.ports p1,refs_admin.ports p2 WHERE p1.code = p2.code AND p1.id != p2.id ORDER BY p1.id, p1.code;
```

See [csv file](IOTC_Master_refs_admin_ports.csv).

To do :

* [x] Remove row with id ```4003```
* [x] Remove row with id ```4592```
* [x] Remove row with id ```7869```
* [x] Remove row with id ```7926```
* [x] Remove row with id ```8663```
* [x] Remove row with id ```8874```
* [x] Keep one row with id ```4330```
* [x] Keep one row with id ```4927```
* [x] Keep one row with id ```5090```
* [x] Keep one row with id ```5240```
* [x] Keep one row with id ```5619```
* [x] Keep one row with id ```5921```
* [x] Keep one row with id ```5965```

See [sql file](04-clean-ports.sql)

The following mapping will be used in ROS

| id   | code     |
|------|----------|
| 3999 | FJILEV   |
| 4330 | FRAGPBBR |
| 4592 | FRACEP   |
| 4927 | FRAMQFDF |
| 5090 | FRAGRANT |
| 5240 | FRARELPT |
| 5619 | FRAGPPTP |
| 5921 | FRAGFSLM |
| 5965 | FRAPMFSP |

# Note 6

See [05-add-missing-species.sql file](05-add-missing-species.sql). 

# Note 7

[Code inspired from iloveitaly/audit-trigger](https://github.com/iloveitaly/audit-trigger/blob/master/audit.sql).

The new table ```refs_history.history``` contains all modifications for each code-list. Two columns were added (```doi``` and ```doi_version```) 
to push here _DOI_ information. 

See 

* [00-audit-ddl.sql file](00-audit-ddl.sql)
* [01-add-audit.sql file](01-add-audit.sql)
