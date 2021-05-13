EXPORT eCrash_DataDeletion (STRING logicalfilename) := FUNCTION

  eCrash_Deletion_Senario := '':STORED('eCrashDeletionSenario');

	//Senario 1:Based on logic given by ecrash team
	DeleteUsingLogic := fn_Data_Deletion_eCrash_Logic(logicalfilename);

	//Senario 2:Based on Incident file given by ecrash team
	DeleteUsingIncidentFile := fn_Data_Deletion_Incident_File(logicalfilename);

	//Senario 3:Based on Individual Input files provided from eCrash team
	DeleteUsingIndividualInputFiles := fn_Data_Deletion_Input_Files(logicalfilename);

	//Senario 4:Based on Individual cru_order_id
	DeleteUsingCruOrderIdList := fn_Data_Deletion_Individual_Order_List(logicalfilename);

	//Senario 5:Based on Individual incident_id
	DeleteUsingIncidentIdList := fn_Data_Deletion_Individual_Incident_List(logicalfilename);
	
	//Note other possiblities
	//Based on cru extract get the Incident file from eCrash team and run Senario 2 
	
  exec_deletion := MAP( 
											 eCrash_Deletion_Senario = 'DeleteUsingLogic' => DeleteUsingLogic,  
									     eCrash_Deletion_Senario = 'DeleteUsingIncidentFile' => DeleteUsingIncidentFile,  
									     eCrash_Deletion_Senario = 'DeleteUsingIndividualInputFiles' => DeleteUsingIndividualInputFiles,  
									     eCrash_Deletion_Senario = 'DeleteUsingCruOrderIdList' => DeleteUsingCruOrderIdList,  
									     eCrash_Deletion_Senario = 'DeleteUsingIncidentIdList' => DeleteUsingIncidentIdList,  
									     OUTPUT('No deletion senario selected')
                       );

RETURN exec_deletion;

END;