
//Use the same date for both parameters when there is no full file date
export BWR_Transunion_Build (full_filedate = '', update_filedate = '') := MACRO

#workunit('protect',true);
#workunit('name','Yogurt:Transunion_PTrak Build ' + update_filedate);
#workunit('priority','high');
#OPTION('multiplePersistInstances',FALSE);
  

	import Transunion_PTrak, Orbit3;  
	
	Proc_Spray_Update		:= Transunion_PTrak.Spray_Transunion_Update_Fixed (full_filedate, update_filedate)   
							: 	success(OUTPUT('Transunion PTrak Base Files updated successfully.')), 
								failure(OUTPUT('Failed to spray update file'));
								
	Proc_Clean_Address		:= Transunion_PTrak.Clean_Transunion_Address  						 
							: 	success(OUTPUT('Cash address was updated successfully.')), 
								failure(OUTPUT('Failed to update cash address file'));
														
    Proc_DID				:= Transunion_PTrak.Proc_Transunion_DID(full_filedate, update_filedate) 
							: 	success(OUTPUT('Final base file with DIDs was created successfully')), 
								failure(OUTPUT('Failed to create final file with DIDs'));
    
	proc_promonitor         := Transunion_PTrak.Proc_Promonitor_TUCS(full_filedate,update_filedate); 
	Proc_delete_persist		:= Transunion_PTrak.Delete_Persist_Files           						 
							: 	success(OUTPUT('Persist files were deleted successfully')), 
								failure(OUTPUT('Failed to delete persist files'));
	
	Proc_clear_superfiles   := Transunion_PTrak.Clear_Superfiles (full_filedate, update_filedate)       								 
							: 	success(OUTPUT('Superfile were cleared successfully')), 
								failure(OUTPUT('Failed to clear superfiles'));
								
	strata_rep := Transunion_PTrak.strata(update_filedate);
	SEQUENTIAL(
	   Proc_Spray_Update
	  ,Proc_Clean_Address
	   ,Proc_DID
	   ,proc_promonitor
	   ,Proc_delete_persist
	   ,Proc_clear_superfiles
		 ,strata_rep
		 	,Orbit3.Proc_Orbit3_CreateBuild_npf('TUCS PTrak',update_filedate)
			,Orbit3.proc_Orbit3_CreateBuild_AddItem ('TUCS PTrak',update_filedate,'N',runaddcomponentsonly := true)
		 ,_control.fSubmitNewWorkunit('#workunit(\'name\',\'Scrubs_TUCS\');\r\n'+
																	'Scrubs_TUCS.proc_generate_report();','thor400_60')
	);
 endmacro
 ;

