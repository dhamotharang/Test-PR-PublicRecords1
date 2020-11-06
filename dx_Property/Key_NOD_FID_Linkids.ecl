IMPORT $, doxie, Data_Services;

// ---------------------------------------------------------------
// For delta rollup logic (dx_common.mac_incremental_rollup) use:
//  $.key_foreclosure_delta_rid
// ---------------------------------------------------------------

inFile := $.Layouts.i_FID_Linkids;

EXPORT Key_NOD_FID_Linkids := INDEX({inFile.fid},{inFile}
																		,Data_Services.Data_location.prefix('foreclosure') + 'thor_Data400::key::nod::' + doxie.Version_SuperKey + '::fid::linkids');