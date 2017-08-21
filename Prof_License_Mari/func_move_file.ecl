IMPORT Prof_License_Mari, Lib_FileServices;

EXPORT func_move_file := MODULE

	EXPORT MyClearSuperFile(STRING fname) := FUNCTION
			RETURN SEQUENTIAL(FileServices.StartSuperFileTransaction();
												FileServices.ClearSuperFile(fname);
												FileServices.FinishSuperFileTransaction();
			);
	END;	
	
/* EXPORT MyCreateSuperFile(STRING code, STRING sub_dirname, STRING fname) := FUNCTION
   		dirname := Common_Prof_Lic_Mari.SourcesFolder + code + '::';
   		RETURN FileServices.CreateSuperFile(dirname + sub_dirname + '::' + fname);
   END;	
*/

	/****************************************************************************************************************
	* This function move a super file from one lcoation to another. There are 4 parameters:													*
	*	 - code: eg ARS0835, AKS0376, ect      																																				*
	*	 - filename: name of the super file to be moved. eg active for ARS0835, apr_web for ARS0824										*
	*  - src_dir: it can be sprayed, using, or used. The source directory will be																		* 
	*    Common_Prof_Lic_Mari.SourcesFolder + code + '::' + src_dir + '::' + filename																*
	*		 eg ~thor_data400::in::proflic_mari::ars0835::using::active																									*
	*  - dest_dir: it can be sprayed, using, or used. The destination directory will be															* 
	*    Common_Prof_Lic_Mari.SourcesFolder + code + '::' + dest_dir + '::' + filename															*
	*		 eg ~thor_data400::in::proflic_mari::ars0835::used::active																									*
	*****************************************************************************************************************/		
	EXPORT MyMoveFile(STRING code, STRING filename, STRING src_dir, STRING dest_dir) := FUNCTION

			dirname 	:= Common_Prof_Lic_Mari.SourcesFolder + code + '::';	
			src_file := dirname + src_dir + '::' + filename;
			dest_file := dirname + dest_dir + '::' + filename;
			//Create a superfile in dest if it does not already exists. Clear it if it already exists.
			IF(FileServices.SuperFileExists(dest_file),
				 MyClearSuperFile(dest_file),
				 FileServices.CreateSuperFile(dest_file)
	//			 MyCreateSuperFile(dest_dir, filename)
			);
			//swap superfile in src and dest	 
			RETURN SEQUENTIAL(
				FileServices.StartSuperFileTransaction();
				FileServices.SwapSuperFile(src_file, dest_file);
				FileServices.FinishSuperFileTransaction();
			);

	END;
	
END;