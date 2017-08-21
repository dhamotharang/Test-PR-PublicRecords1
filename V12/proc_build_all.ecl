IMPORT _control,ut,RoxieKeyBuild;

EXPORT proc_build_all(STRING version) := FUNCTION
  #workunit('name', 'V12 build');
	
	//Run V12 Spray
	spray_all := V12.proc_spray_V12_files(version);
	
	//Build basefile
	base_f := V12.proc_build_base(version);
	
  ut.mac_sf_buildprocess(base_f,V12.thor_cluster+'base::V12',buildnewbasefile,3,,true);
	
	//Move raw input file to history
	mv_V12_raw := SEQUENTIAL
									(
										FileServices.StartSuperFileTransaction(),
										FileServices.AddSuperFile('~thor_data400::in::email::v12_epostal_history','~thor_data400::in::email::v12_epostal',,TRUE),
										FileServices.ClearSuperFile('~thor_data400::in::email::v12_epostal'),
										FileServices.AddSuperFile('~thor_data400::in::email::v12_ezip_history','~thor_data400::in::email::v12_ezip',,TRUE),
										FileServices.ClearSuperFile('~thor_data400::in::email::v12_ezip'),
										FileServices.AddSuperFile('~thor_data400::in::email::v12_optout_history','~thor_data400::in::email::v12_optout',,TRUE),
										FileServices.ClearSuperFile('~thor_data400::in::email::v12_optout'),
										FileServices.AddSuperFile('~thor_data400::in::email::v12_hb_history','~thor_data400::in::email::v12_hb',,TRUE),
										FileServices.ClearSuperFile('~thor_data400::in::email::v12_hb'),
										FileServices.FinishSuperFileTransaction()
									);

		
  RETURN If(EXISTS(FileServices.RemoteDirectory(_control.IPAddress.bctlpedata11,'/data/hds_180/V12/data/'+ version,'*.txt')),
					SEQUENTIAL(spray_all
										 ,buildnewbasefile
										 ,V12.proc_build_strata(version)
										 ,mv_V12_raw
										 ),
					Output('No input file, skip V12 build'));
	
END;