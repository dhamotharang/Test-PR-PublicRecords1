/********************************************************************************************************** 
	Name: 			Build_File_Search
	Created On: 07/20/2013
	By: 				ssivasubramanian
	Desc: 			This does the following:
							1. Take the dataset which has all the source data
							2. Project it to the Search layout,sort and dedup to get the Search file
							3. Overwrite the last generated Search file with the new one (while keeping the old copies)
***********************************************************************************************************/

IMPORT RoxieKeyBuild;

EXPORT Build_File_Search(STRING fileVersion) := FUNCTION
	
	Search_Temp							:= PROJECT(_Datasets.All_Base(source_code_Search <> ''),
																		TRANSFORM(_Layouts.Search, 
																							SELF := LEFT;
																							SELF.Source_code  := LEFT.source_code_Search;
																							SELF.history_flag  := LEFT.history_flag_Search;
																							SELF := [];));
									
	Search									:= DEDUP(SORT(Search_Temp,RECORD),RECORD);
	
	// update superfile
	RoxieKeyBuild.Mac_SF_BuildProcess_V2(Search,
																			 _Files.Base_Prefix, 
																		   _Files.Search_Suffix, 
																			 fileVersion, buildFileSearch, 3);
	
	RETURN buildFileSearch;

END;