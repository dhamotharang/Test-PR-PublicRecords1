IMPORT $, Data_Services;
//DF-27472 Initial Roxie Release
rec := $.Layouts.i_source_level_did;

EXPORT Key_Source_Level_DID (UNSIGNED1 data_env = Data_Services.data_env.iNonFCRA) := INDEX({rec.did}, 
                                                 rec - did,
	                                               $.Names(data_env).i_source_level_did);