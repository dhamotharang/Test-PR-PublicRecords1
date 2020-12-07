IMPORT PromoteSupers, FLAccidents;

EXPORT fn_FL_Ntl_Accidents_ConsolidationBase() := FUNCTION

CreateSuperfiles := SEQUENTIAL (FLAccidents.fn_CreateSuperFiles_FLAccidents(), FLAccidents.fn_CreateSuperFiles_NtlAccidents());

Build_FLAccidents_consolidationBase_file := FLAccidents.FLCrash_BuildConsolidatedBaseFile;
PromoteSupers.MAC_SF_BuildProcess(FLAccidents.Map_NtlAccidents_Consolidation, '~thor_data400::base::ntlcrash_Consolidation', Build_NtlAccidents_Consolidation, 3, FALSE, TRUE);
PromoteSupers.MAC_SF_BuildProcess(FLAccidents.Map_NtlAccidentsInquiry_Consolidation, '~thor_data400::base::ntlcrash_inquiry_Consolidation', Build_NtlAccidentsInquiry_Consolidation, 3, FALSE, TRUE);


BuildFLNtlAccidentsConsolidationBase := SEQUENTIAL(CreateSuperfiles, 
                                          Build_FLAccidents_consolidationBase_file,
																					Build_NtlAccidents_Consolidation, 
																					Build_NtlAccidentsInquiry_Consolidation
																				 );
																				 
RETURN BuildFLNtlAccidentsConsolidationBase;

END;