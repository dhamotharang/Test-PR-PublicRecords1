IMPORT $, doxie, Data_Services;

// ---------------------------------------------------------------
// For delta rollup logic (dx_common.mac_incremental_rollup) use:
//  $.key_normalized_delta_rid
// ---------------------------------------------------------------


inFile := $.Layouts.i_address;
							
EXPORT key_foreclosures_addr := INDEX({inFile.situs1_zip, 
																			inFile.situs1_prim_range, 
																			inFile.situs1_prim_name, 
																			inFile.situs1_addr_suffix, 
																			inFile.situs1_predir},
																			{inFile},Data_Services.Data_Location.Prefix('foreclosure') + 'thor_data400::key::foreclosure_address_' + doxie.Version_SuperKey);