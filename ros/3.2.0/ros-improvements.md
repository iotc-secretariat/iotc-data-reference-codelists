# Abstract

This document lists some improvements to perform on **Ros** database version **3.1.2**

[draft]

# General advices

* [ ] Remove the prefix on the table which is already named in the schema name (See [file](./tables_to_rename.csv)).
* [ ] Move some tables from ```ros_common``` to their dedicated specific schema (See [file](./tables_to_move.csv)).
* [ ] Merge values tables such as ```capacities,depths,diameters,heights,lengths,ranges,sizes,texts,thicknesses,tonnages```, maybe use a unique table with a discriminant value ?
* [ ] Replace the old code-lists system with a mirror of **IOTC_Master 1.0.0** database
  * [ ] Use the **IOTC_Master** ```refs_admin.Species``` code-list
  * [ ] Review the **IOTC_Master** ```refs_biological.Ports``` code-list 
  * [x] Rename code-list foreign keys name from ```xxx_id``` to ```xxx_code```