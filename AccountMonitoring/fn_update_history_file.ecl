// The following function writes a new history dataset to file. It returns, strictly speaking, no 
// datatype but rather an Action.

IMPORT AccountMonitoring;

EXPORT fn_update_history_file( DATASET(layouts.history) ds_candidates,
                               AccountMonitoring.i_Monitoring_Product_Config mod_cfg, 
										 STRING time_stamp ) := 
	FUNCTION
	
	// Write new history file, and then update superfiles by moving father to grandfather and 
	// current to father. Check the update file size to avoid writing an empty file..
	superfile_stem_name := mod_cfg.history_file_name;
	logical_file_name   := superfile_stem_name + time_stamp;
	DELETE_SUBFILE      := TRUE;
	COPY_FILE_CONTENTS  := TRUE;

	output_file         := OUTPUT(ds_candidates,,logical_file_name,COMPRESSED);
	file_size           := Utilities.Get_FileRowCount(logical_file_name);
	update_superfiles   := Utilities.fn_update_superfiles(superfile_stem_name, logical_file_name, DELETE_SUBFILE, COPY_FILE_CONTENTS);
	
	// If the current history file has no records, then only output the file for auditing (Iinquiry 
	// Tracking) purposes and do not update the superfiles (so that we don't loose all history by 
	// rolling consecutive empty files)  History note: deleting the logical file is not longer done 
	// we need to keep history that file was run but that no candidates were found for auditing/inquiry
	// tracking purposes.
   update_history_file :=
      SEQUENTIAL(
                 output_file,
					  IF( 
					     file_size != 0,
                    update_superfiles
                   )
                );

	
	RETURN update_history_file;
	
END;