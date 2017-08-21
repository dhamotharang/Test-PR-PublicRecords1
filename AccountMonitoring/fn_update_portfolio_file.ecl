// The following function writes a new/updated portfolio dataset to file. It 
// returns, strictly speaking, no datatype but rather an Action.
IMPORT AccountMonitoring;

EXPORT fn_update_portfolio_file( DATASET(AccountMonitoring.layouts.portfolio.base) ds_portfolio,
                                 UNSIGNED1 pseudo_environment,
											           STRING time_stamp,
											           STRING file_type ) := 
	FUNCTION
	
	// Write new portfolio file, and then update superfiles by moving father to grandfather and 
	// current to father. Check the update file size to avoid writing an empty file.
	// There is a new archive superfile (12/2011). This file contains the entire portfolio.
	// The archive file deduped and with product_mask = 0 records filtered out will now be 
	// the new portfolio base file (used in Run Account Monitoring (AM) so that the dedup process 
	// does not have to take place during the AM process).
	superfile_stem_name := IF( file_type = 'archive',
	                           filenames(pseudo_environment).portfolio.archive,
										         filenames(pseudo_environment).portfolio.base
									          );
	logical_file_name   := superfile_stem_name + time_stamp;
	DELETE_SUBFILE      := TRUE;
	COPY_FILE_CONTENTS  := TRUE;
	
	output_file         := OUTPUT(ds_portfolio,,logical_file_name,COMPRESSED);
	file_size           := Utilities.Get_FileRowCount(logical_file_name);
	delete_logical_file := FileServices.DeleteLogicalFile(logical_file_name);
	update_superfiles   := Utilities.fn_update_superfiles(superfile_stem_name, logical_file_name, DELETE_SUBFILE, COPY_FILE_CONTENTS);
	
	// The updated portfolio file is written to the correct file structure
	// then if the file size is greater than zero (meaning a good portfolio
	// update, then the superfiles are updated (grandfather deleted, father to
	// grandfather, current to father and the new updated portfolio file is 
	// saved and used in the next monitoring process).
	update_portfolio_file :=
		SEQUENTIAL( output_file,
			         IF( file_size = 0,
				          NOTHOR(delete_logical_file),
				          update_superfiles
			           )
		          );
	
	RETURN update_portfolio_file;
	
END;
