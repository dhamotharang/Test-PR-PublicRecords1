IMPORT HealthCareFacilityHeader, HealthCareProvider;
#OPTION('multiplePersistInstances',FALSE);
EXPORT Run_Iteration (STRING iter = thorlib.wuid()) := FUNCTION 
	#WORKUNIT ('NAME','Health Care Facility - Internal Linking');
		
	Salt_Iteration := HealthCareFacilityHeader.Proc_Iterate (iter, HealthCareFacility.Files.Facility_Salt_Input_DS).DoAll;
	
	Salt_Output	:=	Dataset (HealthCareFacility.Files.Facility_Salt_Output+iter,HealthCareFacility.Layout_HealthProvider.HealthCareProvider_Header,thor);
	
	HealthCareProvider.Mac_SF_BuildProcess(Salt_Output,
																					HealthCareFacility.Files.HealthCare_Prefix, 
																					HealthCareFacility.Files.Facility_out_Suffix, 
																					iter, SaltOut, 3, ,true, false);

	// AddPossibleMatch	:=	SEQUENTIAL (FileServices.StartSuperFileTransaction(),
																		// FileServices.AddSuperFile(HealthCareProvider.Files.PossibleMatch_SF,HealthCareProvider.Files.Person_PossibleMatches+iter),
																		// FileServices.FinishSuperFileTransaction());

	// ArchiveDeleteData	:=	OUTPUT (ExtractDeleteRecords (HealthCareProvider.Files.Person_Salt_Output_DS,HealthCareProvider.Files.Person_Salt_Output_Father_DS),,'~' + HealthCareProvider.Files.Person_DeletedData + iter,COMPRESSED,OVERWRITE);
	
	// AddDeletedData	:=	SEQUENTIAL (FileServices.StartSuperFileTransaction(),
																	// FileServices.AddSuperFile(HealthCareProvider.Files.Person_Deleted_SF,HealthCareProvider.Files.Person_DeletedData+iter),
																	// FileServices.FinishSuperFileTransaction());
	
	HealthCareProvider.Mac_SF_BuildProcess(Salt_Output,
																					HealthCareFacility.Files.HealthCare_Prefix, 
																					HealthCareFacility.Files.Facility_In_Suffix, 
																					iter, SaltIn, 3, ,true, true);


	AddPossibleMatch	:=	SEQUENTIAL (FileServices.StartSuperFileTransaction(),
																		FileServices.AddSuperFile(HealthCareFacility.Files.PossibleMatch_SF,HealthCareFacility.Files.Facility_PossibleMatches+iter),
																		FileServices.FinishSuperFileTransaction());

	// Delete_Salt_Output := FileServices.DeleteLogicalFile (HealthCareProvider.Files.Person_Salt_Output+iter);

	RETURN SEQUENTIAL (Salt_Iteration,SaltOut,SaltIn);	
	// RETURN SEQUENTIAL (Salt_Iteration,SaltOut,AddPossibleMatch,ArchiveDeleteData,AddDeletedData,SaltIn,Delete_Salt_Output);
	// RETURN SEQUENTIAL (Salt_Iteration,SaltOut,SaltIn,AddPossibleMatch,ArchiveDeleteData,Delete_Salt_Output);	
End;


