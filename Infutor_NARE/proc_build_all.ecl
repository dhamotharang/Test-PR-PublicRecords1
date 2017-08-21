
IMPORT _control,ut,RoxieKeyBuild;

EXPORT proc_build_all(STRING version) := FUNCTION
  #workunit('name', 'Infutor Email build');
	
	//Run Spray
	spray_all := Infutor_NARE.proc_spray_nare(version);
	
	//Clean raw file for base input
	Clean_raw := Infutor_NARE.file_prep_raw(version);
	
	//Build basefile
	Build_base := Infutor_NARE.proc_build_base(version);

		
  RETURN IF(COUNT(FileServices.RemoteDirectory(_control.IPAddress.bctlpedata12,'/data/data_build_4/infutor_nare/'+ version[1..8],'*.txt',false)(size <>0 )) > 0,
					SEQUENTIAL(spray_all
										 ,Clean_raw
										 ,Build_base
										 ,Infutor_NARE.proc_build_strata(version)
										 ),
					Output('No input file, skip Infutor email build'));
	
END;