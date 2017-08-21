export proc_build_all(filedate) := macro

	import infutor,RoxieKeyBuild;

		
	Infutor.out_STRATA_population_stats(Infutor.File_Infutor_DID
									   	,filedate
									    ,zDoPopulationStats);
									   
	Proc_Build_Base	  := Infutor.Proc_Clean_and_DID : success(output('Infutor Base Files created successfully.'));
	Proc_Build_Keys	  := Infutor.proc_build_key(filedate) : failure(FileServices.sendemail('akayttala@seisint.com', 'Infutor tracker file roxie Build Failure', failmessage));
 	Proc_Build_stats  := zDoPopulationStats ; 
	new_records_sample_for_qa := Infutor.New_records_sample : success(Infutor.Email_notification_lists(filedate));
	
  sequential(Proc_Build_Base
						,Proc_Build_Keys
						,Proc_Build_stats
						,new_records_sample_for_qa
						);

endmacro;