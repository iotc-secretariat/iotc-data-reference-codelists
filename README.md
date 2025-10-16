# Overview
This repository contains the complete set of reference data (code lists) maintained by the IOTC Secretariat to support the standardisation, validation, and integration of fisheries statistical data.
These code lists are applied across all data collection and reporting frameworks under the IOTC mandate and include controlled vocabularies for vessel types, gear types, species, statistical areas, flag States, and other attributes relevant to tuna and tuna-like species fisheries.

# Access
The code lists are distributed as an **R package**:

```{r iotcGithubCodeListExtraction, echo = TRUE, eval = FALSE}
# Install the IOTC data reference codelists package from GitHub
remotes::install_github("iotc-secretariat/iotc-data-reference-codelists")

# Load the library
library(iotc.data.reference.codelists)

# Access the code lists
iotc.data.reference.codelists::FLEETS
```

All IOTC code lists are also available from the [IOTC Reference Data Catalogue](https://data.iotc.org/reference/latest/) and as CSV files via the Fisheries Data Interoperability Working Group ([FDIWG](https://github.com/fdiwg/fdi-codelists/tree/main/regional/iotc/fisheries)) repository. In addition, the code lists are archived on [Zenodo](https://doi.org/10.5281/zenodo.15743874) to support versioning, citation, and long-term accessibility.

# Citation
Please cite the IOTC code lists as follows:
Indian Ocean Tuna Commission. (2025). Reference Data – IOTC Code Lists for Fisheries Statistics [Data set]. Zenodo. https://doi.org/10.5281/zenodo.15743875

# License
The IOTC code lists are released under the Creative Commons Attribution 4.0 International (CC BY 4.0) license, which permits use, redistribution, and adaptation with appropriate attribution.

# Contact
The code lists are maintained and published by the IOTC Secretariat, which serves as the hosting institution responsible for their curation and periodic updates.
For any comments, questions, or suggestions regarding this repository, please contact: [IOTC-Statistics@fao.org](IOTC-Statistics@fao.org).
