// The following attribute sprays a portfolio update to disk.
EXPORT proc_input_portfolio_update( UNSIGNED1 pseudo_environment,
                                    STRING    spray_ip_address, 
                                    STRING    spray_path,
												STRING    timestamp ) := 

	FUNCTION
		// Make sure the passed in spray fields are not blank
		valid_spray_criteria   := spray_ip_address != '' AND spray_path != '';
		
		// If there is spray criteria, check to see the path needs the '/' appended, adds it if necessary
		// then sets the valid path.  
		valid_spray_path := IF( valid_spray_criteria,
		                        IF( spray_path[LENGTH(spray_path)] != '/',
		                            spray_path + '/',
		                            spray_path
		                           ),
		                        ''
		                       );
													
		
		process_input_file(STRING remote_filename, string thor_filename) := MODULE
		
			SHARED logical_file_name := thor_filename + timestamp;
			
			// SHARED file_exists := EXISTS(FileServices.RemoteDirectory(spray_ip_address,valid_spray_path,remote_filename));
			SHARED file_exists := FileServices.RemoteDirectory(spray_ip_address,valid_spray_path,remote_filename)[1].size > 0;
			
			// the input portfolio or product update file is sprayed onto the thor
			EXPORT spray := FUNCTION
				COMPRESS               := TRUE;
				
				RETURN NOTHOR(IF(file_exists,FileServices.SprayVariable(
					spray_ip_address,                     // source ip    
					valid_spray_path + remote_filename,   // sourcepath
					,                                     // maxrecordsize
					'|',                                  // srcCSVseparator
					,                                     // srcCSVterminator
					',',                                  // srcCSVquote
					AccountMonitoring.constants.spray_groupname,   // destinationgroup
					logical_file_name,                    // destination logical filename
					,,,,,COMPRESS)));
			END;
			
			// Booleans set for the super file save to roll current to father, and father to grandfather 
			EXPORT update := FUNCTION
				DELETE_SUBFILE      := TRUE;
				COPY_FILE_CONTENTS  := TRUE;
				RETURN IF(NOTHOR(file_exists),
					       Utilities.fn_update_superfiles(thor_filename, logical_file_name, DELETE_SUBFILE, COPY_FILE_CONTENTS) );
			END;
		
		END;
		
		fnms := AccountMonitoring.filenames(pseudo_environment);
		
		process_portfolio                   := process_input_file(fnms.portfolio.remote                  ,fnms.portfolio.update);
		process_documents_bankruptcy        := process_input_file(fnms.documents.bankruptcy.remote       ,fnms.documents.bankruptcy.update);
		process_documents_deceased          := process_input_file(fnms.documents.deceased.remote         ,fnms.documents.deceased.update);
		process_documents_address           := process_input_file(fnms.documents.address.remote          ,fnms.documents.address.update);
		process_documents_phone             := process_input_file(fnms.documents.phone.remote            ,fnms.documents.phone.update);
		process_documents_paw               := process_input_file(fnms.documents.paw.remote              ,fnms.documents.paw.update);
		process_documents_property          := process_input_file(fnms.documents.property.remote         ,fnms.documents.property.update);
		process_documents_litigiousdebtor   := process_input_file(fnms.documents.litigiousdebtor.remote  ,fnms.documents.litigiousdebtor.update);
		process_documents_liens             := process_input_file(fnms.documents.liens.remote            ,fnms.documents.liens.update);
		process_documents_criminal          := process_input_file(fnms.documents.criminal.remote         ,fnms.documents.criminal.update);
		process_documents_phonefeedback     := process_input_file(fnms.documents.phonefeedback.remote    ,fnms.documents.phonefeedback.update);
		process_documents_foreclosure       := process_input_file(fnms.documents.foreclosure.remote      ,fnms.documents.foreclosure.update);
		process_documents_workplace         := process_input_file(fnms.documents.workplace.remote        ,fnms.documents.workplace.update);
		process_documents_reverseaddress    := process_input_file(fnms.documents.reverseaddress.remote   ,fnms.documents.reverseaddress.update);
		process_documents_didupdate    			:= process_input_file(fnms.documents.didupdate.remote   		 ,fnms.documents.didupdate.update);
		process_documents_bdidupdate   			:= process_input_file(fnms.documents.bdidupdate.remote   		 ,fnms.documents.bdidupdate.update);
		process_documents_phoneownership		:= process_input_file(fnms.documents.phoneownership.remote   ,fnms.documents.phoneownership.update);
		process_documents_bipbestupdate			:= process_input_file(fnms.documents.bipbestupdate.remote    ,fnms.documents.bipbestupdate.update);
		process_documents_sbfe							:= process_input_file(fnms.documents.sbfe.remote    				 ,fnms.documents.sbfe.update);
		process_documents_ucc								:= process_input_file(fnms.documents.ucc.remote    				 	 ,fnms.documents.ucc.update);
		process_documents_govtdebarred			:= process_input_file(fnms.documents.govtdebarred.remote     ,fnms.documents.govtdebarred.update);
		process_documents_inquiry						:= process_input_file(fnms.documents.inquiry.remote    		 	 ,fnms.documents.inquiry.update);
		process_documents_corp							:= process_input_file(fnms.documents.corp.remote    			 	 ,fnms.documents.corp.update);
		process_documents_mvr								:= process_input_file(fnms.documents.mvr.remote    				 	 ,fnms.documents.mvr.update);
		process_documents_aircraft					:= process_input_file(fnms.documents.aircraft.remote			 	 ,fnms.documents.aircraft.update);
		process_documents_watercraft				:= process_input_file(fnms.documents.watercraft.remote   	 	 ,fnms.documents.watercraft.update);


		spray_all_files := PARALLEL(
			process_portfolio.spray,
			process_documents_bankruptcy.spray,
			process_documents_deceased.spray,
			process_documents_address.spray,
			process_documents_phone.spray,
			process_documents_paw.spray,
			process_documents_property.spray,
			process_documents_litigiousdebtor.spray,
			process_documents_liens.spray,
			process_documents_criminal.spray,
			process_documents_phonefeedback.spray,
			process_documents_foreclosure.spray,
			process_documents_workplace.spray,
			process_documents_reverseaddress.spray,
			process_documents_didupdate.spray,
			process_documents_bdidupdate.spray,
			process_documents_phoneownership.spray,
			process_documents_bipbestupdate.spray,
			process_documents_sbfe.spray,
			process_documents_ucc.spray,
			process_documents_govtdebarred.spray,
			process_documents_inquiry.spray,
			process_documents_corp.spray,
			process_documents_mvr.spray,
			process_documents_aircraft.spray,
			process_documents_watercraft.spray
		);
		
		update_all_superfiles := PARALLEL(
			process_portfolio.update,
			process_documents_bankruptcy.update,
			process_documents_deceased.update,
			process_documents_address.update,
			process_documents_phone.update,
			process_documents_paw.update,
			process_documents_property.update,
			process_documents_litigiousdebtor.update,
			process_documents_liens.update,
			process_documents_criminal.update,
			process_documents_phonefeedback.update,
			process_documents_foreclosure.update,
			process_documents_workplace.update,
			process_documents_reverseaddress.update,
			process_documents_didupdate.update,
			process_documents_bdidupdate.update,
			process_documents_phoneownership.update,
			process_documents_bipbestupdate.update,
			process_documents_sbfe.update,
			process_documents_ucc.update,
			process_documents_govtdebarred.update,
			process_documents_inquiry.update,
			process_documents_corp.update,
			process_documents_mvr.update,
			process_documents_aircraft.update,
			process_documents_watercraft.update
		);
			
		RETURN SEQUENTIAL( IF( NOT valid_spray_criteria, 
                             FAIL('Must provide valid spray criteria.')),
			                spray_all_files,
			                update_all_superfiles
							  );
			
	END;