IMPORT _control,ut,PromoteSupers, RealSource, SALT38, Scrubs_RealSource;

//Version = input filedate
EXPORT proc_build_all(STRING version) := FUNCTION
  #workunit('name', 'Yogurt: RealSource email build');
	
	//Run Spray
	spray_all := RealSource.SprayFiles(version);
	
	//Build basefile
	base_f := RealSource.proc_build_base(version);
	
RETURN If(EXISTS(FileServices.RemoteDirectory(IF(_control.thisenvironment.name='Dataland',
																																																	_control.IPAddress.bctlpedata12,
																																																	_control.IPAddress.bctlpedata11),'/data/hds_180/RealSource/data/'+ version,'*.csv')),
						SEQUENTIAL(spray_all
																,Scrubs_RealSource.PreBuildScrubs(version)
																,base_f
																,RealSource.Strata_Population_Stats(version).all
																),
						Output('No input file, skip RealSource build'));
	
END;