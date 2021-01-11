import doxie, Data_Services;

// ---------------------------------------------------------------
// For delta rollup logic (dx_common.mac_incremental_rollup) use:
//  $.key_regulatory_actions_delta_rid
// ---------------------------------------------------------------

base_file := Prof_License_Mari.files_base.regulatory_actions;

KeyName := 'thor_data400::key::proflic_mari::';

// Blank Out Default Dates
// DF-28229
dsRegulatory := project(base_file,transform(Prof_License_Mari.layouts.Regulatory_Action_Base,
  self.CLN_ACTION_DTE := IF(LEFT.CLN_ACTION_DTE = '17530101','',LEFT.CLN_ACTION_DTE);
  self:=left,self:=[])
);

// Blank Out Default Dates
export key_regulatory := 	index(dsRegulatory
                                ,{NMLS_ID,AFFIL_TYPE_CD}
                                ,{dsRegulatory}
                                ,Data_Services.Data_location.Prefix('mari')+ KeyName+ doxie.Version_SuperKey+'::regulatory_actions');

