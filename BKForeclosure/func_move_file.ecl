IMPORT BKForeclosure, Lib_FileServices;

EXPORT func_move_file := MODULE


	EXPORT ClearSuperFile(STRING fname) := FUNCTION
			RETURN SEQUENTIAL(FileServices.StartSuperFileTransaction();
												FileServices.ClearSuperFile(fname);
												FileServices.FinishSuperFileTransaction();
			);
	END;	
	/****************************************************************************************************************
	* This function move a super file from one lcoation to another. There are 3 parameters:													*
	*	 - filename: name of the super file to be moved. eg delete_nod, refresh_nod_orphan		    							      *
	*  - src_dir: it can be using, or used. 																		                                    *
	*		 eg ~thor_data400::in::foreclosure::update_nod::using    																									  *
	*  - dest_dir: it can be using, or used. 															 													    	          *
	*		 eg ~thor_data400::in::foreclosure::update_nod::used																									      *
	*****************************************************************************************************************/ 
 
	EXPORT MoveFile(STRING filename, STRING src_dir, STRING dest_dir) := FUNCTION

			dirname 	:= '~thor_data400::';	
			src_file  := dirname + filename + '::' + src_dir;
			dest_file := dirname + filename + '::' + dest_dir;
			//Create a superfile in dest if it does not already exists. Clear it if it already exists.
			IF(FileServices.SuperFileExists(dest_file),
				 ClearSuperFile(dest_file),
				 FileServices.CreateSuperFile(dest_file)

			);
			//swap superfile in src and dest	 
			RETURN SEQUENTIAL(
				FileServices.StartSuperFileTransaction();
				FileServices.SwapSuperFile(src_file, dest_file);
				FileServices.FinishSuperFileTransaction();
			);

	END;
	
END;