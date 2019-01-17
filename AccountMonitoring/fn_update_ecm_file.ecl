
// Verifies that spray data exists and then sprays the ecm (Enterprise Company Management) 
// file to the specified pseudo environment then rolls the exisitng files
// (deletes the grandfather version then moves father version to grandfather,
// current to father, and new (logical file name) file to the current 
// version (including the timestamp). 


EXPORT fn_update_ecm_file(UNSIGNED1 pseudo_environment,
                          STRING    spray_ip_address = '', 
                          STRING    spray_path = '') := 
	FUNCTION
		timestamp := thorlib.wuid();
		// Make sure the passed in spray fields are not blank
		valid_spray_criteria := spray_ip_address != '' AND spray_path != '';
		
		// If there is spray criteria, check to see the path needs the '/' appended, adds it if necessary
		// then sets the valid path.  
		valid_spray_path := IF( valid_spray_criteria,
		                        IF( spray_path[LENGTH(spray_path)] != '/',
		                            spray_path + '/',
		                            spray_path
		                           ),
		                        ''
		                       );
													
		process_input_file(STRING remote_filename, STRING thor_filename) := 
		   MODULE
		
			   SHARED logical_file_name := thor_filename + timestamp;
			
			   SHARED file_exists := EXISTS(FileServices.RemoteDirectory(spray_ip_address,valid_spray_path,remote_filename));
			
			   EXPORT spray := FUNCTION
				   COMPRESS        := TRUE;
				   ALLOW_OVERWRITE := TRUE;
				
				RETURN NOTHOR(IF(file_exists,FileServices.SprayVariable(
					spray_ip_address,                   // source ip
					valid_spray_path + remote_filename, // sourcepath
					,                                   // maxrecordsize
					'|',                                // srcCSVseparator
					,                                   // srcCSVterminator
					',',                                // srcCSVquote
					if(AccountMonitoring.constants.spray_groupname = 'thor400_dev' or 
					   AccountMonitoring.constants.spray_groupname = 'thor400_dev_eclcc', 'thor400_dev01', AccountMonitoring.constants.spray_groupname),            // destinationgroup
					logical_file_name,                  // destinationlogicalfilename
					,,,ALLOW_OVERWRITE,,COMPRESS)));
			END;
			
			// Booleans set for the super file save to roll current to father, and father to grandfather 
			EXPORT update := FUNCTION
				DELETE_SUBFILE      := TRUE;
				COPY_FILE_CONTENTS  := TRUE;
				RETURN IF(NOTHOR(file_exists),
					Utilities.fn_update_superfiles(thor_filename, logical_file_name, DELETE_SUBFILE, COPY_FILE_CONTENTS) );
			END;
		
		END;
		
		process_ecm_update_file := 
			process_input_file(AccountMonitoring.filenames(pseudo_environment).ecm.remote,
                            AccountMonitoring.filenames(pseudo_environment).ecm.base);

		spray_all_files       := process_ecm_update_file.spray;
		update_all_superfiles := process_ecm_update_file.update;
			
		RETURN SEQUENTIAL(
			IF(NOT valid_spray_criteria, FAIL('Must provide valid spray criteria.')),
            spray_all_files,
            update_all_superfiles);
			
	END;