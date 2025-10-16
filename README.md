# Overview
This dataset contains the complete set of reference data (code lists) maintained by the IOTC Secretariat to support the standardisation, validation, and integration of fisheries statistical data. These code lists are used across all data collection and reporting frameworks under the IOTC mandate and include controlled vocabularies for vessel types, gear types, species, areas, flag States, and other attributes relevant to tuna and tuna-like species fisheries.

# Access
The code lists are distributed as an R library 

```{r iotcGithubCodeListExtraction, echo = TRUE, eval = FALSE}
# Install the IOTC data reference codelists package from GitHub
remotes::install_github("iotc-secretariat/iotc-data-reference-codelists")

# Load the library
library(iotc.data.reference.codelists)

# Access the code lists
iotc.data.reference.codelists::FLEETS
```

All IOTC code lists are also available from the [IOTC Reference Data Catalogue](https://data.iotc.org/reference/latest/) and as CSV files from the github repository of the Fisheries Data Interoperability Working Group ([fdiwg](https://github.com/fdiwg/fdi-codelists/tree/main/regional/iotc/fisheries)). In addition, the code lists have been published on the Zenodo platform to support versioning, citation, and long-term accessibility (https://doi.org/10.5281/zenodo.15743874).

# Contact
The code lists are maintained and published by the IOTC Secretariat, which serves as the hosting institution responsible for their curation and periodic updates.
Please contact the IOTC Secretariat for any comment or question regarding this repository at: [IOTC-Statistics@fao.org](IOTC-Statistics@fao.org).
