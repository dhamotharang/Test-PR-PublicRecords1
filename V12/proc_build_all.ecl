IMPORT _control,ut,RoxieKeyBuild, PromoteSupers, Orbit3;

EXPORT proc_build_all(STRING version) := FUNCTION
  #workunit('name', 'Yogurt:V12 build');
	
	//Run V12 Spray
	spray_all := V12.proc_spray_V12_files(version);
	
	//Build basefile
	base_f := V12.proc_build_base(version);
	
  PromoteSupers.Mac_SF_BuildProcess(base_f,V12.thor_cluster+'base::V12',buildnewbasefile,3,,true);
	
	//Move raw input file to history
	mv_V12_raw := SEQUENTIAL
									(
										FileServices.StartSuperFileTransaction(),
										FileServices.AddSuperFile('~thor_data400::in::email::v12_epostal_history','~thor_data400::in::email::v12_epostal',,TRUE),
										FileServices.ClearSuperFile('~thor_data400::in::email::v12_epostal'),
									//No longer receiving these files
										// FileServices.AddSuperFile('~thor_data400::in::email::v12_ezip_history','~thor_data400::in::email::v12_ezip',,TRUE),
										// FileServices.ClearSuperFile('~thor_data400::in::email::v12_ezip'),
										// FileServices.AddSuperFile('~thor_data400::in::email::v12_optout_history','~thor_data400::in::email::v12_optout',,TRUE),
										// FileServices.ClearSuperFile('~thor_data400::in::email::v12_optout'),
										// FileServices.AddSuperFile('~thor_data400::in::email::v12_hb_history','~thor_data400::in::email::v12_hb',,TRUE),
										// FileServices.ClearSuperFile('~thor_data400::in::email::v12_hb'),
										FileServices.FinishSuperFileTransaction()
									);
									
  create_orbit_build:= Orbit3.Proc_Orbit3_CreateBuild_npf ('V12 Group',version);
		
  RETURN If(EXISTS(FileServices.RemoteDirectory(_control.IPAddress.bctlpedata11,'/data/hds_180/V12/data/'+ version,'*.txt')),
					SEQUENTIAL(spray_all
										 ,buildnewbasefile
										 ,V12.proc_build_strata(version)
										 ,mv_V12_raw
										 ,create_orbit_build
										 ),
					Output('No input file, skip V12 build'));
	
END;