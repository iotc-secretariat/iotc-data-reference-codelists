
# Abstract

This document summarizes all updates to do on **ROS** from version _3.1.2_ to _3.2.0_ using the _final agreed ros 
revision_ compiled in 2025.

We will list all updates to perform by their type:

* Removed fields
* Added fields
* Modified fields (renamed, upgraded to Mandatory, downgraded to Optional)

For each modified field, we point their location in the ROS 3.1.2 database (could be schema + table or 
schema + table + column).

_FK_ means _foreign key_.

Bold fields mean **mandatory**, italic fields mean _optional_ in fields table description.

# Form general vessel and trip info for all types of vessels

## Subform observer trip details

### Added fields

Add a new table named _ps_observer_embarkation_details_ in the schema _ros_ps_ (since it is only for ps submodel).

→ Rename **ps_trip_details**

| Field name                                | column  (2)                     | Type                              |
|-------------------------------------------|---------------------------------|-----------------------------------|
| _Observation starting port_               | observation_starting_port_id    | fk to ros_references.cl_port      |
| _Observation starting country or EEZ_ (1) | observation_starting_country_id | fk to ros_references.cl_countries |
| **Observation starting latitude**         | observation_starting_latitude   | decimal                           |
| **Observation starting longitude**        | observation_starting_longitude  | decimal                           |
| **Observation starting date / time**      | observation_starting_date_time  | timestamp                         |
| _Observation ending port_                 | observation_ending_port_id      | fk to ros_references.cl_port      |
| _Observation ending country or EEZ_ (1)   | observation_ending_country_id   | fk to ros_references.cl_countries |
| **Observation ending latitude**           | observation_ending_latitude     | decimal                           |
| **Observation ending longitude**          | observation_ending_longitude    | decimal                           |
| **Observation ending date / time**        | observation_ending_date_time    | timestamp                         |

Notes: 

1. If EEZ is needed, need then to add another column _starting_eez_id_ and _ending_eez_id_ pointing to an eez reference table 
   (that I did not find). [_**Should be the [NJA](https://data.iotc.org/reference/latest/domain/admin/#IOareasNJA) spatial layer**_]
2. Maybe we could remove _observation_ prefix on each field? [_**AGREED**_]

## Subform Observed trip summary

### Modified fields

In table _ros_common.observed_trip_summary_

* Rename _Number of fishing events / sets conducted by the vessel while the observer was on-board._ to 
_Number of fishing events / sets conducted by the vessel during the observed period_. [_**AGREED**_]

In table, the column is named _number_of_conducted_fishing_events_with_observer_onboard_, anything to do? [_**I WILL EXPLAIN**_]

→ _number_of_fishing_events_ and _number_of_observed_fishing_events_

* Rename _Number of fishing events / sets observed_ to 
_Number of fishing events / sets with objective data collection_. [_**HUM**_]

In table, the column is named _number_of_observed_fishing_events_, anything to do?

* Rename _Number of days searching_ to 
_Record the total number of days/hours that the vessel was engaged in actively searching for fish (this does not include active fishing day(s)) (PL)_.

In table, the column is named _number_of_days_searching_, anything to do?

The field should be mandatory for PS and PL and optional for LL, but in database is optional... Should we move this 
field into specialized tables for each submodel (PS,PL,LL,GN)? [_**TO DISCUSS**_]

→ Duplicate the table _ps_observer_trip_summary_ and _pl_observer_trip_summary_ ?

→ May be create a view to compute this values.

Same remark for fields _Number active fishing days_ and _Number of days lost_.

## Subform observer identification 

### Removed fields

| Field name           | schema     | table                   | column         |
|----------------------|------------|-------------------------|----------------|
| Observer nationality | ros_common | observer_identification | nationality_id |

### Modified fields

Rename _Observed trip number_ to _Observed trip ID_. [**AGREED**]

Could not find the location of this data. [**NOT SURE**]

* Rename _Observer IOTC registration number_ to _IOTC registration number of observer or EM observer/reviewer_.

Is it _ros_common.observer_identification.iotc_number_ or _ros_meta.ros_observers.iotc_number_?

In the first table the column is optional, in the second it is mandatory.

And what is the revised new name?

* Rename _Observer name_ to _Observer or EM observer/reviewer name_.

→ Nothing to rename

Is it _ros_common.observer_identification.full_name_?

→ Move ros_meta.ros_observers to ros_common and merge it with observers (observer_identification), add column date_of_birth.

And what is the revised new name?

## Subform vessel trip details

### Added fields

Add a new table named _ps_vessel_trip_details_ in the schema _ros_ps_ (since it is only for ps submodel). [**AGREED**]

| Field name                                    | column (2)                       | Type                                 |
|-----------------------------------------------|----------------------------------|--------------------------------------|
| _Vessel trip port of departure_               | vessel_trip_departure_port_id    | fk to ros_references.cl_port         |
| _Vessel trip country or EEZ of departure_ (1) | vessel_trip_departure_country_id | fk to ros_references.cl_countries    |
| **Vessel trip latitude of departure**         | vessel_trip_departure_latitude   | decimal                              |
| **Vessel trip longitude of departure**        | vessel_trip_departure_longitude  | decimal                              |
| **Vessel trip date / time of departure**      | vessel_trip_departure_date_time  | timestamp                            |
| _Vessel trip port of return_                  | vessel_trip_return_port_id       | fk to ros_references.cl_port         |
| _Vessel trip country or EEZ of return_ (1)    | vessel_trip_return_country_id    | fk to ros_references.cl_countries    |
| **Vessel trip latitude of return**            | vessel_trip_return_latitude      | decimal                              |
| **Vessel trip longitude of return**           | vessel_trip_return_longitude     | decimal                              |
| **Vessel trip date / time of return**         | vessel_trip_return_date_time     | timestamp                            |
| **Vessel trip detail**  (3)                   | vessel_trip_detail_id            | fk to ros_common.vessel_trip_details |

Notes: 

1. If EEZ is needed, need then to add another column departure_eez_id and return_eez_id pointing to an eez reference table 
   (that I did not find). [**[NJA spatial layer](https://data.iotc.org/reference/latest/domain/admin/#Indian_Ocean_National_Jurisdiction_Areas)**]
2. Maybe we could remove _vessel_trip_ prefix on each field? [**AGREED**]
3. The _ros_common.vessel_trip_details_ is linked with the _ros_common.general_vessel_and_trip_information_ table (via the
   _vessel_trip_details_id_ field), we need then to link the new table with _ros_common.vessel_trip_details_, we propose to
   add a field in the new table (since this one can't exist without the first one (composition link)), another solution 
   is to create another association between the two tables. [**MAKES SENSE YES**]

## Subform vessel identification

### Removed fields

| Field name   | schema     | table                       | column |
|--------------|------------|-----------------------------|--------|
| Vessel phone | ros_common | vessel_identification_phone | -      |
| Vessel fax   | ros_common | vessel_identification_fax   | -      |
| Vessel email | ros_common | vessel_identification_email | -      |

## Subform vessel owner & personnel

### Removed fields

| Field name           | schema     | table                      | column                     |
|----------------------|------------|----------------------------|----------------------------|
| Registered owner     | ros_common | vessel_owner_and_personnel | registered_vessel_owner_id |
| Charterer / operator | ros_common | vessel_owner_and_personnel | charter_or_operator_id     |

## Subform vessel electronics

### Removed fields

| Field name                          | schema     | table              | column                        |
|-------------------------------------|------------|--------------------|-------------------------------|
| Sea Surface Temperature (SST) gauge | ros_common | vessel_electronics | sea_surface_temperature_gauge |
| Weather facsimile                   | ros_common | vessel_electronics | weather_facsimile             |

# Form longline information

## Subform general gear attributes

### Removed fields

| Field name        | schema | table                      | column                |
|-------------------|--------|----------------------------|-----------------------|
| Mainline Material | ros_ll | ll_general_gear_attributes | line_material_type_id |
| Mainline Length   | ros_ll | ll_general_gear_attributes | mainline_length_id    |
| Mainline Diameter | ros_ll | ll_general_gear_attributes | mainline_diameter_id  |

Removing these three columns make the table empty, so at the end remove _ros_ll.ll_general_gear_attributes_ table. [**There are some values in this table**]

As a side effect, we need then to remove also field _ros_ll.ll_gear_specifications.ll_general_gear_attributes_id_

## Subform ll special equipment or machinery

### Modified fields

* Rename _Line setter_ to _Line setter/ line shooter_.

In table _ros_ll.ll_special_equipment_, rename column _line_setter_ to _line_setter_or_line_shooter_.

## Subform setting operations

### Removed fields

| Field name | schema | table                 | column |
|------------|--------|-----------------------|--------|
| VMS on     | ros_ll | ll_setting_operations | vms_on |

### Added fields

Around table _ros_ll.ll_setting_operations_ add the following data:

* Type and colour of attached lights
* Leader material type
* % by leader material type
* Total branch line length

#### Type and colour of attached lights

_Proportion of lights attached to the branchlines per type and colour._

There is already a table _ros_ll.lights_by_type_and_colour_ with this definition:

| schema | table                     | column                                | type                        |
|--------|---------------------------|---------------------------------------|-----------------------------|
| ros_ll | lights_by_type_and_colour | **id**                                | generated unique id         |
| ros_ll | lights_by_type_and_colour | _number_of_lights_by_type_and_colour_ | number                      |
| ros_ll | lights_by_type_and_colour | _light_colour_id_                     | fk to cl_light_colours      |
| ros_ll | lights_by_type_and_colour | _light_type_id_                       | fk to cl_light_types        |
| ros_ll | lights_by_type_and_colour | _ll_setting_operation_id_             | fk to ll_setting_operations |

Could we reuse this table? or do we have to create something else?

→ Add proportion column here

#### Leader material type

_Specify each leader type used in the set (based on Table T16 – line material types)._

If I well understood, we need to add a new association table between _ll_setting_operations_ and _cl_line_material_types_

| schema | table                                       | column                      | type                        |
|--------|---------------------------------------------|-----------------------------|-----------------------------|
| ros_ll | ll_setting_operations_leader_material_types | **id**                      | generated unique id         |
| ros_ll | ll_setting_operations_leader_material_types | **ll_setting_operation_id** | fk to ll_setting_operation  |
| ros_ll | ll_setting_operations_leader_material_types | **line_material_type_id**   | fk to cl_line_material_type |

#### % by leader material type

_For each leader type used in the set, estimate the percentage of total branchlines in the set using that leader type. 
Estimate by counting the number of branchlines in a basket by leader type and dividing each count by the total hooks 
in the basket. This assumes uniform use of leader types across baskets in a set. Estimates should be adjusted if there 
is variation across baskets (within a set) in leader proportions_

Add in table described in the previous section an integer column:

| schema | table                                       | column             |
|--------|---------------------------------------------|--------------------|
| ros_ll | ll_setting_operations_leader_material_types | **percent_in_set** |


#### Total branch line length

_Specify the minimum and maximum total branchline lengths observed in the set. Total branchline length is measured 
(in meters) from the mainline clip to the hook. If total branchline lengths are uniform across the set, write the 
same number in the minimum and maximum fields._

Description is talking about minimum total and maximum total, what exactly should be added?

| schema | table                                       | column                      | Type    |
|--------|---------------------------------------------|-----------------------------|---------|
| ros_ll | ll_setting_operations_leader_material_types | **total_branchline_length** | integer |

→ Maybe change to real

→ Move to table _ll_setting_operations_

### Modified fields

* Downgrade _Mainline set length_ to optional.

In table _ros_ll.ll_setting_operations_, the column _mainline_set_length_id_ is already optional.

## Subform ll setting operations - mitigation measures

### Modified fields

* Downgrade _Branchline weighted_ to optional.

In table _ros_ll.ll_mitigation_measures_, the column _branchline_weighted_ is already optional.

* Rename _Underwater setting_ to _Hook pods_.

In table _ros_ll.ll_mitigation_measures_, rename column _underwater_setting_ to _hook_pods_.

* Downgrade _% hooks set by type_ to optional.

In table _ros_ll.hooks_by_type_, the column _percentage_of_set_ is already optional.

* Rename _Bait ratio (%)_ to _Bait proportion (%)_.

I found in table _ros_ll.baits_by_conditions_ the column _ratio_,is it the good one?

In table _ros_ll.baits_by_conditions_ rename column _ratio_ to _proportion_.

## Subform hauling operations
 
### Removed fields

| Field name             | schema | table                                  | column |
|------------------------|--------|----------------------------------------|--------|
| Method(s) to stun fish | ros_ll | ll_hauling_operations_stunning_methods |        |

Removing this association table between _ross_ll.ll_hauling_operations_ and _ros_references.cl_stunning_methods_.

**The code list (_ros_references.cl_stunning_methods_) is no more used, should we remove it?**

Actual content of this code list:

| id | code | name\_en                | name\_fr                      | update\_date               |
|:---|:-----|:------------------------|:------------------------------|:---------------------------|
| 1  | CO2  | Carbon dioxide narcosis | Le dioxyde de carbone narcose | 2016-12-12 13:55:56.000000 |
| 2  | PS   | Percussive stunning     | null                          | 2016-12-12 13:56:11.000000 |
| 3  | SP   | Spiking                 | null                          | 2016-12-12 13:56:23.000000 |
| 4  | ELC  | Electrocution           | Électrocution                 | 2016-12-12 13:57:10.000000 |

→ Remove this stunning code-list

### Modified fields

* Rename _Number of retrieved hooks observed_ to _No of branchline haulings observed_.

In table, rename column _number_of_hooks_observed_ to _number_of_branchline_hauling_observed_.

→ No do not rename 
→ Add _number_of_branchline_hauling_observed_ Optional for the moment... Validate at loading 

## Subform ll - depredation details

### Modified fields

* Downgrade _Depredation source_ to optional.

This data is located is _ros_common.depredation_details.depredation_source_id_ and is already optional.

* Downgrade _Predator observed_ to optional.

This data is located is _ros_common.depredation_details.predator_observed_id_ and is already optional.

More over the column _ros_ll.ll_specimens.ll_depredation_detail_id_ is also optional.

## Subform ll - specimen information

### Modified fields

* Rename _Set Number_ to _Set id_.

Did not find this one.

In fact do rename _ll_fishing_events.event_number_ to _event_identifier_.

* Rename _Catch detail number_ to _Catch id_.

In table _ros_ll.ll_catch_details_, rename column _catch_detail_number_ to _catch_identifier_.

Note: Using a ```_id``` suffix might not be coherent with other columns (a such column should a foreign key)

→ Do rename but may be ask fabio about the meaning ```xxx_number``` column 

## Subform ll - additional details on non-target species

### Modified fields

* Upgrade _Condition at capture_ to mandatory.

This data is located is _ros_common.additional_details_on_non_target_species.condition_at_capture_id_ which is optional.

We might need to move this information in _ros_ll_ schema? 

* Upgrade _Condition at release_ to mandatory.

This data is located is _ros_common.additional_details_on_non_target_species.condition_at_release_id_ which is optional.

We might need to move this information in _ros_ll_ schema?

## Subform ll - additional catch details on ssis 

### Modified fields

* Upgrade _Gear interaction_ to mandatory.

This data is located is _ros_ll.ll_additional_catch_details_on_ssi.gear_interaction_id_ which is optional, make it then mandatory.

* Upgrade _Leader  material_ to mandatory.

This data is located is _ros_ll.ll_additional_catch_details_on_ssi.leader_material_type_id_ which is optional, make it then mandatory.

# Form purse seine information

## Subform ps special equipment or machinery

### Modified fields

* Downgrade _Power block_ to optional

Column _rs_ps.ps_special_equipment.power_block_ is already optional, nothing to do.

* Downgrade _Purse winch_ to optional

Column _rs_ps.ps_special_equipment.purse_winch_ is already optional, nothing to do.

## Subform general gear attributes

### Removed fields

| Field name  | schema | table                      | column         |
|-------------|--------|----------------------------|----------------|
| Skiff power | ros_ps | ps_general_gear_attributes | skiff_power_id |

Removing this foreign key between _ros_ps.ps_general_gear_attributes_ and _ros_common.powers_.

**The code list (_ros_common.powers_) is no more used, should we remove it?** Actually this code list is empty

### Modified fields

* Downgrade _Maximum length of the net_ to optional

Column _rs_ps.ps_general_gear_attributes._ is already optional, nothing to do.

* Downgrade _Maximum depth of the net_ to optional

Column _rs_ps.ps_general_gear_attributes._ is already optional, nothing to do.

* Downgrade _Bag stretched mesh size_ to optional

Column _rs_ps.ps_general_gear_attributes._ is already optional, nothing to do.

* Downgrade _Mid-net stretched mesh size_ to optional

Column _rs_ps.ps_general_gear_attributes.mid_net_stretched_mesh_size_id_ is already optional, nothing to do.

* Downgrade _Maximum brail capacity_ to optional

Column _rs_ps.ps_general_gear_attributes.maximum_brail_capacity_ is already optional, nothing to do.

## Subform fishing operations

### Removed fields

| Field name | schema | table                 | column        |
|------------|--------|-----------------------|---------------|
| Beaufort   | ros_ps | ps_setting_operations | wind_scale_id |

### Modified fields

* Downgrade _School sighting cues_ to optional
* Downgrade _Time net pursed_ to optional

## Subform support vessel details

### Removed fields

| Field name                   | schema | table                  | column                       |
|------------------------------|--------|------------------------|------------------------------|
| Support  vessel presence     | ros_ps | support_vessel_details | support_vessel_presence      |
| Support  vessel name         | ros_ps | support_vessel_details | support_vessel_name          |
| Support vessel participation | ros_ps | support_vessel_details | support_vessel_participation |

Removing these three columns leave on this table only two columns:

* _id_
* _support_vessel_participation_description_
* _ps_setting_operation_id_

**Should we remove the hole table (_ros_ps.support_vessel_details_) then?**

## Subform ps object  details

### Modified fields

* Rename _Buoy equipped with artificial lights_ to _FAD equipped with artificial lights_
* Rename _Artificial FAD design_ to _FAD design_

## Subform ps cetaceans and whale sharks sightings during setting

### Modified fields

* Upgrade _Sighting occurred before setting_ to mandatory
* Upgrade _Species_ to mandatory
* Upgrade _Number sighted_ to mandatory
* Upgrade _Caught inside the net_ to mandatory

## Subform catch details

### Added fields

In table _ros_ll.ll_catch_details_ add one field:

| Field name | column | Type    |
|------------|--------|---------|
| **Number** | number | integer |

## Subform details on current

### Removed fields

| Field name        | schema | table           | column            |
|-------------------|--------|-----------------|-------------------|
| Current direction | ros_ps | current_details | current_direction |
| Current speed     | ros_ps | current_details | current_speed     |
| Current depth     | ros_ps | current_details | current_depth     |

Removing these three columns leaves on this table only two columns:

* _id_
* _ps_setting_operation_id_

**As a side effect, we should remove the hole table (_ros_ps.current_details_)**

## Subform additional details on non-target species

### Removed fields

| Field name           | schema     | table                                    | column                  |
|----------------------|------------|------------------------------------------|-------------------------|
| Condition at capture | ros_common | additional_details_on_non_target_species | condition_at_capture_id |
| Condition at release | ros_common | additional_details_on_non_target_species | condition_at_release_id |

We cannot remove this table used by other business submodels (ll, pl and gn).

This code list is used in two _ros_ps_ schema tables:

| schema | table            | column                                            |
|--------|------------------|---------------------------------------------------|
| ros_ps | ps_specimens     | additional_specimen_details_non_target_species_id |
| ros_ps | ps_catch_details | ps_additional_catch_details_non_target_species_id |

We should then remove these two columns.

## Subform ps - tag details

### Modified fields

* Downgrade _Tag release_ to optional
* Downgrade _Tag recovery_ to optional
* Downgrade _Tag type_ to optional
* Downgrade _Tag number_ to optional
* Downgrade _Tag finder_ to optional
* Downgrade _Well_ to optional

# Form pole and line information

## Subform pl tuna fishing trip

### Added fields

This is a new section, add a new table _pl_tuna_fishing_trip_ in _ros_pl_ schema.

| Field name               | column             | Type                                       |
|--------------------------|--------------------|--------------------------------------------|
| **Species**              | species_id         | fk to ros_common.species                   |
| **Fate**                 | fate               | fk to ros_references.fates                 |
| **Sampling methods** (1) | sampling_method_id | fk to ros_references.cl_sampling_protocols |
| **Number**               | number             | integer                                    |
| **Weight**               | weight             | decimal                                    |

Note:

1. Sampling methods to get total catch estimates per species: check if sample method is sampling protocol.

## Subform general gear attributes

### Removed fields

| Field name         | schema | table                    | column    |
|--------------------|--------|--------------------------|-----------|
| Type of lures used | ros_pl | lures_or_jiggers_by_type | lure_type |

## Subform pl tuna fishing event

### Modified fields

* Rename _Set Number_ to _Event Number_

## Subform fishing operations

### Removed fields

| Field name                            | schema | table                      | column                          |
|---------------------------------------|--------|----------------------------|---------------------------------|
| Beaufort                              | ros_pl | pl_tuna_fishing_operations | wind_scale_id                   |
| Buoys equipped with artificial lights | ros_pl | pl_object_details          | equipped_with_artificial_lights |
| Sampling protocol                     | ros_pl | pl_tuna_fishing_operations | sampling_protocol_id            |

### Modified fields

* Rename _Sampling methods for the collection of biological information_ to _Sampling methods for the collection of biometric information_
* Downgrade _Bait used_ to optional
* Downgrade _Bait type_ to optional
* Downgrade _Bait species_ to optional
* Downgrade _Number of hooks lost_ to optional

## Subform catch details 

### Removed fields

| Field name   | schema | table            | column              |
|--------------|--------|------------------|---------------------|
| Event number | ros_pl | pl_catch_details | catch_detail_number |

### Modified fields

* Rename _Event number_ to _Event ID_
* Downgrade _Event number_ to optional
* Downgrade _Species_ to optional
* Downgrade _Fate_ to optional
* Downgrade _Sampling methods for obtaining total catch estimates per species_ to optional
* Downgrade _Number_ to optional
* Downgrade _Weight_ to optional
* Downgrade _Weight estimation method_ to optional
* Downgrade _Weight code_ to optional

## Subform pl - depredation details

### Modified fields

* Downgrade _Depredation source_ to optional
* Downgrade _Predator observed_ to optional
 
## Subform bait fishing event

### Removed fields

| Field name                            | schema | table                                           | column                          |
|---------------------------------------|--------|-------------------------------------------------|---------------------------------|
| Distance from the coast               | ros_pl | bait_fishing_operations                         | distance_from_the_coast_id      |
| Beaufort                              | ros_pl | bait_fishing_operations                         | wind_scale_id                   |
| School sighting cues and school types | ros_pl | bait_fishing_operations_cl_school_sighting_cues |                                 |
| Detection method                      | ros_pl | bait_fishing_operations                         | bait_school_detection_method_id |
| Object ID                             | ros_pl | pl_object_details                               | buoy_identifier                 |
| Buoys equipped with artificial lights | ros_pl | pl_object_details                               | equipped_with_artificial_lights |
| Sampling protocol                     | ros_pl | bait_fishing_operations                         | sampling_protocol_id            |

Removing these two columns on _ros_pl.pl_object_details_ leave on this table only one column:

* _id_

We should then remove this table and his usages:

| schema | table               | column              |
|--------|---------------------|---------------------|
| ros_pl | bait_fishing_events | pl_object_detail_id |
| ros_pl | tuna_fishing_events | pl_object_detail_id |

## Subform pl bait catch details

### Removed fields

| Field name                                                       | schema | table               | column                              |
|------------------------------------------------------------------|--------|---------------------|-------------------------------------|
| Event number                                                     | ros_pl | bait_fishing_events | event_number                        |
| Catch detail number                                              | ros_pl | pl_catch_details    | catch_detail_number                 |
| Species                                                          | ros_pl | pl_catch_details    | species_id                          |
| Fate                                                             | ros_pl | pl_catch_details    | fates_id                            |
| Sampling methods for obtaining total catch estimates per species | ros_pl | pl_catch_details    | estimated_weight_sampling_method_id |
| Number                                                           | ros_pl | pl_catch_details    | estimated_catch_in_numbers          |

The table _ros_pl.pl_catch_details_ is shared with 3 other tables :

| schema | table                                 | column             |
|--------|---------------------------------------|--------------------|
| ros_pl | pl_bait_fishing_event_pl_catch_detail | pl_catch_detail_id |
| ros_pl | pl_tuna_fishing_event_pl_catch_detail | pl_catch_detail_id |
| ros_pl | pl_specimens                          | pl_catch_detail_id |

**Make sure this is what you want**.

### Modified fields

* Downgrade _Weight_ to optional
* Downgrade _Weight estimation method_ to optional

## Subform pl - tag details

### Modified fields

* Downgrade _Tag release_ to optional
* Downgrade _Tag recovery_ to optional
* Downgrade _Tag type_ to optional
* Downgrade _Tag number_ to optional
* Downgrade _Tag finder _ to optional

## Subform bait specimen information

### Removed fields

| Field name          | schema | table               | column              |
|---------------------|--------|---------------------|---------------------|
| Event Number        | ros_pl | bait_fishing_events | event_number        |
| Catch detail number | ros_pl | pl_catch_details    | catch_detail_number |
| Specimen number     | ros_pl | pl_specimens        | specimen_number     |

**Need to double-check for the *Event Number* and *Catch detail number* **

## Subform pl - bait fishing event

### Modified fields

* Downgrade _Event number_ to optional
* Downgrade _Event start date and time_ to optional
* Downgrade _Event depth_ to optional
* Rename _Fishing method_ to _Fishing gear_ 

## Subform bait additional details on non-target species

### Removed fields

| Field name           | schema     | table                                    | column                  |
|----------------------|------------|------------------------------------------|-------------------------|
| Condition at capture | ros_common | additional_details_on_non_target_species | condition_at_capture_id |
| Condition at release | ros_common | additional_details_on_non_target_species | condition_at_release_id |

We cannot remove this table used by other business submodel (ll, pl and gn).

This code list is used in one ros_pl schema table:

| schema | table        | column                                            |
|--------|--------------|---------------------------------------------------|
| ros_pl | pl_specimens | additional_specimen_details_non_target_species_id |

We should then remove this column.

## Subform pl - bait additional catch details on ssis

### Added fields

Add on table named _pl_additional_catch_details_on_ssi_ in schema _ros_pl_ a fk:

| Field name       | column                                         | Type                                                        |
|------------------|------------------------------------------------|-------------------------------------------------------------|
| _Conditions_ (1) | additional_catch_details_non_target_species_id | fk to ros_common / additional_details_on_non_target_species |

Note:

1. Condition at capture and release: check if this is the good way of doing this.

## Subform bait biometric information

### Removed fields

| Field name                                                    | schema | table | column |
|---------------------------------------------------------------|--------|-------|--------|
| Sampling methods for the collection of biological information | ros_pl |       |        |
| Length code 1                                                 | ros_pl |       |        |
| Length 1                                                      | ros_pl |       |        |
| Length code 2                                                 | ros_pl |       |        |
| Length 2                                                      | ros_pl |       |        |
| Weight code                                                   | ros_pl |       |        |
| Weight                                                        | ros_pl |       |        |
| Weight estimation method                                      | ros_pl |       |        |
| Sex                                                           | ros_pl |       |        |
| Maturity stage                                                | ros_pl |       |        |
| Sample collected                                              | ros_pl |       |        |

**Did not find database location for these fields in the ros_pl schema, do you mean to remove any biometric information 
from the _ros_pl.specimen_ table?** 

## Subform bait tag details

### Removed fields

| Field name   | schema | table          | column        |
|--------------|--------|----------------|---------------|
| Tag release  | ros_pl | pl_tag_details | tag_release   |
| Tag recovery | ros_pl | pl_tag_details | tag_recovery  |
| Tag type     | ros_pl | pl_tag_details | tag_type_id   |
| Tag number   | ros_pl | pl_tag_details | tag_number    |
| Tag finder   | ros_pl | pl_tag_details | tag_finder_id |

Removing these five columns on _ros_pl.pl_tag_details_ leave on this table only two columns:

* _id_
* _alternate_tag_number_

**Should we remove the hole table? if so we should also remove the following field:**

| schema | table        | column           |
|--------|--------------|------------------|
| ros_pl | pl_specimens | pl_tag_detail_id |

## Subform vessel daily activity information

### Removed fields

| Field name | schema     | table                             | column |
|------------|------------|-----------------------------------|--------|
| Activity   | ros_common | pl_observer_data_daily_activities |        |

**Double-check that we want to remove the hole association table, should we do something else?**
