AppendNPIAttributes HIPIE Plugin

This plugin appends dataset that contains client provided NPI number with NPI related info (entity type code).

Input Parameters
Prefix: The prefix for all the appended columns. 
DATASET dsInput: input dataset with client provided NPI number.
CLientNPI: client provided NPI number.

Resource Requirements
This plugin is dependant on index thor_data400::key::nppes::qa::npi.
It cannot be used outside of our core environments and data.
