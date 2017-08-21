// The following attribute accepts an aggregate of all candidates that Thor must write to disk.
// Called from AccountMonitoring.Run and outputs the candidates to the despray path and then 
// updates the superfiles.
EXPORT proc_output_results( DATASET(AccountMonitoring.layouts.results) candidates_rolled = DATASET([], AccountMonitoring.layouts.results), 
                            UNSIGNED1 pseudo_environment,
                            STRING14 timestamp = Thorlib.WUID(),
                            STRING  despray_ip_address = '', 
                            STRING  despray_path = '' ) := 
	FUNCTION
		valid_despray_criteria := despray_ip_address != '' AND despray_path != '';
		ALLOW_OVERWRITE        := TRUE;
		superfile_stem_name    := AccountMonitoring.filenames(pseudo_environment).results;
		logical_file_name      := superfile_stem_name + timestamp;
		
		DELETE_SUBFILE      := TRUE;
		COPY_FILE_CONTENTS  := TRUE;
		update_superfiles := SEQUENTIAL(
						OUTPUT(candidates_rolled,,logical_file_name,CSV(HEADING(1),SEPARATOR('|'),TERMINATOR('\n')),OVERWRITE),
						Utilities.fn_update_superfiles(superfile_stem_name, logical_file_name, DELETE_SUBFILE, COPY_FILE_CONTENTS) );
		
		despray_file  := FileServices.DeSpray(logical_file_name, despray_ip_address, despray_path, -1, , , ALLOW_OVERWRITE);
		RETURN SEQUENTIAL(update_superfiles, IF(valid_despray_criteria, NOTHOR(despray_file)));
	END;