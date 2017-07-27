//Use the same date for both parameters when there is no full file date
export BWR_Transunion_Build (full_filedate, update_filedate) := MACRO

  #workunit('name','Transunion_PTrak Build ' + update_filedate);

	import Transunion_PTrak;  
	
	Proc_Spray_Update		:= Transunion_PTrak.Spray_Transunion_Update_Fixed (update_filedate)   
							: 	success(OUTPUT('Transunion PTrak Base Files updated successfully.')), 
								failure(OUTPUT('Failed to spray update file'));
								
	Proc_Clean_Address		:= Transunion_PTrak.Clean_Transunion_Address  						 
							: 	success(OUTPUT('Cash address was updated successfully.')), 
								failure(OUTPUT('Failed to update cash address file'));
								
	Proc_Clean_Names		:= Transunion_PTrak.Join_Transunion_Normalized_Clean (full_filedate, update_filedate)               
							: 	success(OUTPUT('Name and address cleansing, and file standardization completed successfully')), 
								failure(OUTPUT('Failed Name and address cleansing, and file standardization process'));
								
    Proc_DID				:= Transunion_PTrak.Proc_Transunion_DID
							: 	success(OUTPUT('Final base file with DIDs was created successfully')), 
								failure(OUTPUT('Failed to create final file with DIDs'));
								
	Proc_delete_persist		:= Transunion_PTrak.Delete_Persist_Files           						 
							: 	success(OUTPUT('Persist files were deleted successfully')), 
								failure(OUTPUT('Failed to delete persist files'));
	
	Proc_clear_superfiles   := Transunion_PTrak.Clear_Superfiles (full_filedate, update_filedate)       								 
							: 	success(OUTPUT('Superfile were cleared successfully')), 
								failure(OUTPUT('Failed to clear superfiles'));
	
	SEQUENTIAL(
	    Proc_Spray_Update
	   ,Proc_Clean_Address
	   ,Proc_Clean_Names
	   ,Proc_DID
	   ,Proc_delete_persist
	   ,Proc_clear_superfiles
	);
 endmacro
 ;

