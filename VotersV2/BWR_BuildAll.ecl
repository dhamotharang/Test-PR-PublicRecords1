//Barb O'Neill created when working on DOPS-461

IMPORT std,VotersV2,_Control, tools;

//Date format needs to be YYYYMMDD
pVersion := '20210113';
sourceIP := 'bctlpedata11';
sourcePath := '/data/load01/voters/sprays/';

#workunit('name','Voters Build '+pVersion);
#option('multiplePersistInstances',FALSE);

cleaned_superfile := VotersV2.cluster + 'in::Voters::main::Superfile';

clear_main := sequential(FileServices.StartSuperFileTransaction(),
															FileServices.ClearSuperFile(cleaned_superfile),
															FileServices.FinishSuperFileTransaction());	

spray_main := VotersV2.fSprayAndPromoteVoters(pVersion,sourceIP,sourcePath);
					 
full_build := sequential(           
           clear_main,
           spray_main,
					 VotersV2.proc_build_all(pVersion)
					 );		
					 
return
    //check to see if date is valid
		if(tools.fun_IsValidVersion(pVersion),
			full_build,
			output('No Valid version parameter passed, skipping VotersV2.proc_build_all')
		);