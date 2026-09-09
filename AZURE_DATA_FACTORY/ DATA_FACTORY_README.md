### Metadata-Driven Ingestion
 
Rather than building one Copy Activity per source file, the ingestion pipeline is **config-driven**:
 
1. A **Lookup Activity** reads a parameter file listing every source file to ingest — each entry defines a `file_url` (source), plus a `file_folder` and `file_name` (destination in Bronze).
2. A **ForEach Activity** loops through that list and runs a single reusable Copy Activity per entry, pulling each file directly from its public HTTP source into the Bronze container.
This means adding a new source file to the pipeline (e.g. a 9th Olist table) only requires adding a row to the parameter file — no new activities or pipeline changes required.
