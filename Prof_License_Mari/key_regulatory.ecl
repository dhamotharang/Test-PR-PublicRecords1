import doxie_files, doxie, ut, Data_Services, fcra;


base_file := Prof_License_Mari.files_base.regulatory_actions;

KeyName 			:= 'thor_data400::key::proflic_mari::';

// Blank Out Default Dates
dsRegulatory := project(base_file,transform(Prof_License_Mari.layouts.Regulatory_Action,
																							self.CLN_ACTION_DTE := IF(LEFT.CLN_ACTION_DTE = '17530101','',LEFT.CLN_ACTION_DTE);
																							self:=left));


// Blank Out Default Dates
export key_regulatory := 	index(dsRegulatory
																	,{NMLS_ID,AFFIL_TYPE_CD}
																	,{dsRegulatory}
																	,Data_Services.Data_location.Prefix('mari')+ KeyName+ doxie.Version_SuperKey+'::regulatory_actions');

