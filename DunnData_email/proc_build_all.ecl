IMPORT _control,ut,PromoteSupers, DunnData_Email, SALT38;

//Version = input filedate
EXPORT proc_build_all(STRING version) := FUNCTION
  #workunit('name', 'Yogurt: DunnData email build');
	
	//Run Spray
	spray_all := DunnData_Email.SprayFiles(version);
	
	//Build basefile
	base_f := DunnData_Email.proc_build_base(version);
	
RETURN If(EXISTS(FileServices.RemoteDirectory(IF(_control.thisenvironment.name='Dataland',
																																																	_control.IPAddress.bctlpedata12,
																																																	_control.IPAddress.bctlpedata11),'/data/hds_180/RealSource/data/'+ version,'*.csv')),
						SEQUENTIAL(spray_all
																//,Scrubs_DunnData_Email.PreBuildScrubs(version)
																,base_f
																,DunnData_email.Strata_Population_Stats(version).all
																),
						Output('No input file, skip DunnData_email build'));
	
END;