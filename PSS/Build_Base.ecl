import tools;

export Build_Base(
   string 								jobid,	 
	 string									pversion,
	 boolean	pFileUseOtherEnvironment	= false

) :=
module

	pUpdatedBase := Update_Base(jobid, pversion, pFileUseOtherEnvironment);
  all_data := if(nothor(FileServices.GetSuperFileSubCount(Filenames(pversion).base.qa) = 0),
								 pUpdatedBase,
								 pUpdatedBase + Files().base.qa);
	
	all_data_dedp := dedup(sort(all_data, record),all, except dt_vendor_last_reported, dt_vendor_first_reported);	
	tools.mac_WriteFile(Filenames(pversion).base.new	,all_data_dedp,Build_Base_File	);
	
	export full_build :=
	sequential(
		 Build_Base_File
		,Promote(pversion).New2Built

	);
		
	export All :=
	if(tools.fun_IsValidVersion(pversion)
		,full_build		
		,output('No Valid version parameter passed, skipping PSS.Build_Base attribute')
	);
		
end;