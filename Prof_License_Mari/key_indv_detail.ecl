import doxie, Data_Services;

// ---------------------------------------------------------------
// For delta rollup logic (dx_common.mac_incremental_rollup) use:
//  $.key_individual_detail_delta_rid
// ---------------------------------------------------------------

base_file := Prof_License_Mari.files_base.individual_detail;

KeyName := 'thor_data400::key::proflic_mari::';

//Blank out default dates
//DF-28229
Prof_License_Mari.layouts.Individual_Reg_Base  	xformDetail(Prof_License_Mari.layouts.Individual_Reg_Base L) := transform
  self.CLN_START_DTE := IF(L.CLN_START_DTE = '17530101','',L.CLN_START_DTE);
  self.CLN_END_DTE   := IF(L.CLN_END_DTE = '17530101','',L.CLN_END_DTE);
  self := L;
  self := [];
end;

ds_detail := project(base_file, xformDetail(left));

export key_indv_detail := index(ds_detail
                                ,{INDIVIDUAL_NMLS_ID}
                                ,{ds_detail}
                                ,Data_Services.Data_location.Prefix('mari')+ KeyName+ doxie.Version_SuperKey+'::individual_detail');
