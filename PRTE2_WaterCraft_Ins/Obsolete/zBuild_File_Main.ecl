/********************************************************************************************************** 
	Name: 			Build_File_Main
	Created On: 07/20/2013
	By: 				ssivasubramanian
	Desc: 			This does the following:
							1. Take the dataset which has all the source data
							2. Project it to the main layout,sort and dedup to get the main file
							3. Overwrite the last generated main file with the new one (while keeping the old copies)
***********************************************************************************************************/

IMPORT RoxieKeyBuild;

EXPORT Build_File_Main(STRING fileVersion) := FUNCTION
	
	Main_Temp							:= PROJECT(_Datasets.All_Base(source_code_Main <> ''),
																	TRANSFORM(_Layouts.main, 
																						SELF := LEFT;
																						SELF.Source_code  := LEFT.source_code_Main;
																						SELF.Hull_number  := LEFT.hull_number_Main;
																						SELF.history_flag := LEFT.history_flag_Main;
																						SELF := [];));
								
	Main									:= DEDUP(SORT(Main_Temp,RECORD),RECORD);
	
	// update superfile
	RoxieKeyBuild.Mac_SF_BuildProcess_V2(Main,
																			 _Files.Base_Prefix, 
																		   _Files.Main_Suffix, 
																			 fileVersion, buildFileMain, 3);
	
	RETURN buildFileMain;

END;