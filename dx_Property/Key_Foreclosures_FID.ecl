IMPORT $, doxie, Data_Services;

// ---------------------------------------------------------------
// For delta rollup logic (dx_common.mac_incremental_rollup) use:
//  $.key_foreclosure_delta_rid
// ---------------------------------------------------------------

inFile := $.Layouts.i_FID;

EXPORT Key_Foreclosures_FID := INDEX({inFile.fid},{inFile}
																		,Data_Services.Data_location.prefix('foreclosure') + 'thor_Data400::key::foreclosure_fid_' + doxie.Version_SuperKey);
