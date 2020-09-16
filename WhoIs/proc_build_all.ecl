IMPORT _control,ut,PromoteSupers, DunnData_Email, SALT38;

//Version = input filedate
EXPORT proc_build_all(STRING version) := FUNCTION
  #workunit('name', 'Yogurt: WhoIs email build');
	
	//Run Spray
	spray_all := WhoIs.SprayFiles(version);
	
	//Build basefile
	base_f := WhoIs.proc_build_base(version);
	
RETURN If(EXISTS(FileServices.RemoteDirectory(IF(_control.thisenvironment.name='Dataland',
																																																	_control.IPAddress.bctlpedata12,
																																																	_control.IPAddress.bctlpedata11),'/data/temp/reederkx/repository/build_library/builds/WhoIs_Data/data/'+ version,'*.csv')),
						SEQUENTIAL(spray_all
																//,Scrubs_WhoIs.PreBuildScrubs(version)
																,base_f
																,WhoIs.Strata_Population_Stats(version).all
																),
						Output('No input file, skip WhoIs build'));
	
END;