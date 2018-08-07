
//Barb O'Neill created when working on DOPS-461

IMPORT std,VotersV2,_Control;

//fileDate := '20180320';

//#workunit('name','Voters Build '+fileDate);
//#option('multiplePersistInstances',FALSE);

export proc_buildfinal( string fileDate) := function

cleaned_superfile := VotersV2.cluster + 'in::Voters::main::Superfile';

clear_main := sequential(FileServices.StartSuperFileTransaction(),
															FileServices.ClearSuperFile(cleaned_superfile),
															FileServices.FinishSuperFileTransaction());	

spray_main := VotersV2.fSprayAndPromoteVoters(fileDate);
					 
 return sequential(
           clear_main
           ,spray_main
					 ,VotersV2.proc_build_all(fileDate)
					 );		
					 
end;