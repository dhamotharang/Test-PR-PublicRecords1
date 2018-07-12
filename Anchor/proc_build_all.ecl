IMPORT _control,ut,PromoteSupers, Anchor, Scrubs_Anchor;

//Version = input filedate
EXPORT proc_build_all(STRING version) := FUNCTION
  #workunit('name', 'Yogurt: Anchor email build');
	
	//Run Spray
	spray_all := Anchor.SprayFiles(version);
	
	//Build basefile
	base_f := Anchor.proc_build_base(version);
 
RETURN If(EXISTS(FileServices.RemoteDirectory(IF(_control.thisenvironment.name='Dataland',
																									_control.IPAddress.bctlpedata12,
																									_control.IPAddress.bctlpedata11),'/data/hds_180/Anchor/data/'+ version,'*.txt')),
				SEQUENTIAL(spray_all
									,Scrubs_Anchor.PreBuildScrubs(version)
									,base_f
									,Anchor.Strata_Population_Stats(version).all
									),
						Output('No input file, skip Anchor build'));
	
END;