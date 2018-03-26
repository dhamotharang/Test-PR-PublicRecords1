/********************************************************************************************************** 
	Name: 			Build_File_CoastGuard
	Created On: 07/20/2013
	By: 				ssivasubramanian
	Desc: 			This does the following:
							1. Take the dataset which has all the source data
							2. Project it to the CoastGuard layout,sort and dedup to get the CoastGuard file
							3. Overwrite the last generated CoastGuard file with the new one (while keeping the old copies)
***********************************************************************************************************/

IMPORT RoxieKeyBuild;

EXPORT Build_File_CoastGuard(STRING fileVersion) := FUNCTION
	
	CoastGuard_Temp				:= PROJECT(_Datasets.All_Base(source_code_CG <> ''),
																		TRANSFORM(_Layouts.Coastguard, 
																							SELF := LEFT;
																							SELF.Source_code  := LEFT.source_code_CG;
																							SELF.Hull_number  := LEFT.hull_number_CG;
																							SELF := [];));
									
	CoastGuard	:= DEDUP(SORT(CoastGuard_Temp,RECORD),RECORD);
	
	// update superfile
	RoxieKeyBuild.Mac_SF_BuildProcess_V2(CoastGuard,
																			 _Files.Base_Prefix, 
																		   _Files.CoastGuard_Suffix, 
																			 fileVersion, buildFileCoastGuard, 3);
	
	RETURN buildFileCoastGuard;

END;