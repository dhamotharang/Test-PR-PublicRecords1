import doxie, Data_Services;

// ---------------------------------------------------------------
// For delta rollup logic (dx_common.mac_incremental_rollup) use:
//  $.key_disciplinary_actions_delta_rid
// ---------------------------------------------------------------

base_file := Prof_License_Mari.files_base.disciplinary_actions;

KeyName := 'thor_data400::key::proflic_mari::';

// DF-28229
layout_disciplinary	:= RECORD, MAXLENGTH(8000)
  prof_license_mari.layouts.Disciplinary_Action_Base;
END;

// Blank Out Default Dates
dsDisciplinary := project(base_file,transform(layout_disciplinary,
                                              self.CLN_ACTION_DTE := IF(LEFT.CLN_ACTION_DTE = '17530101','',LEFT.CLN_ACTION_DTE);
                                              self:=left,self:=[]));

export key_disciplinary := 	index(dsDisciplinary
                                  ,{INDIVIDUAL_NMLS_ID}
                                  ,{dsDisciplinary}
                                  ,Data_Services.Data_location.Prefix('mari')+ KeyName+ doxie.Version_SuperKey+'::disciplinary_actions');
