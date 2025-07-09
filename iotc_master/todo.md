# Abstract

Main actions to perform on **IOTC_Master** to produce version **1.0.0**

[draft]

# General 

* [ ] Add ```description_en``` and ```description_fr``` on each code-lists
* [ ] Review ```refs_admin.countries``` code-list (use common field names ```name_en,name_fr,description_en,description_fr```)
* [ ] Review ```refs_admin.entities``` code-list (use common field names ```name_en,name_fr,description_en,description_fr```)
* [x] Rename code-list foreign keys name from ```xxx_id``` to ```xxx_code```
* [ ] Remove plural in any code-list name
* [ ] Remove ```id,create_date``` for any code-list
* [ ] Remove some views (with no extra value)
* [ ] Add a new historisation system (linked with **Zenodo DOI**)
  * [ ] Delete ```refs_meta.code_lists_versions``` table and replace it by ```refs_admin.history```
  * [ ] Delete ```refs_meta``` schema
  * [ ] Add triggers on code-list tables to record any change in the ```refs_admin.history``` table. 