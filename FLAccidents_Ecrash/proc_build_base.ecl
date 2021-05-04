IMPORT RoxieKeyBuild;
#OPTION('multiplePersistInstances', FALSE);

EXPORT Proc_Build_Base(STRING FileDate ) := FUNCTION

// ###########################################################################
//                           Create Super Files 
// ###########################################################################
   CreateSF := CreateSuperFiles;
	 
// ###########################################################################
//                  Promotion of eCrash Base files
// ###########################################################################
   RoxieKeyBuild.Mac_SF_BuildProcess_V2(Map_eCrashAccidents_To_SupplementalBase, Files_eCrash.BASE_ECRASH_PREFIX, Files_eCrash.SUFFIX_BASE_SUPPLEMENTAL, FileDate, BuildSupplemental, 3, FALSE, TRUE); 
   RoxieKeyBuild.Mac_SF_BuildProcess_V2(Map_eCrashAccidents_To_eCrashBase, Files_eCrash.BASE_ECRASH_PREFIX, Files_eCrash.SUFFIX_BASE_ECRASH, FileDate, BuildeCrash, 3, FALSE, TRUE); 
   RoxieKeyBuild.Mac_SF_BuildProcess_V2(Map_eCrashAccidents_To_ClaimsClarityBase,Files_eCrash.BASE_ECRASH_PREFIX, Files_eCrash.SUFFIX_BASE_ClaimsClarity, FileDate, BuildClaimsClarity, 3, FALSE, TRUE); 
   RoxieKeyBuild.Mac_SF_BuildProcess_V2(Map_eCrashAccidents_To_DocumentBase, Files_eCrash.BASE_ECRASH_PREFIX, Files_eCrash.SUFFIX_BASE_DOCUMENT, FileDate, BuildDocument, 3, FALSE, TRUE); 
   RoxieKeyBuild.Mac_SF_BuildProcess_V2(Map_eCrashAccidents_To_CRUVehicleIncidentsBase, Files_eCrash.BASE_ECRASH_PREFIX, Files_eCrash.SUFFIX_BASE_CRUVehicleIncidents, FileDate, BuildCRUVehicleIncidents, 3, FALSE, TRUE); 

// ###########################################################################
//                   Promotion of Consolidation eCrash Base files
// ###########################################################################
   RoxieKeyBuild.Mac_SF_BuildProcess_V2(Infiles.Agencycmbnd, Files_eCrash.BASE_ECRASH_PREFIX, Files_eCrash.SUFFIX_CONSOLIDATION_MBSAgency, FileDate, BuildConsolidationMBSAgency, 3, FALSE, TRUE);
   RoxieKeyBuild.Mac_SF_BuildProcess_V2(File_KeybuildV2.CRU, Files_eCrash.BASE_ECRASH_PREFIX, Files_eCrash.SUFFIX_CONSOLIDATION_CRU, FileDate, BuildConsolidationeCRU, 3, FALSE, TRUE); 
   RoxieKeyBuild.Mac_SF_BuildProcess_V2(File_KeybuildV2.out, Files_eCrash.BASE_ECRASH_PREFIX, Files_eCrash.SUFFIX_CONSOLIDATION_ECRASH, FileDate, BuildConsolidationeCrash, 3, FALSE, TRUE); 
   RoxieKeyBuild.Mac_SF_BuildProcess_V2(File_KeybuildV2.prout, Files_eCrash.BASE_ECRASH_PREFIX, Files_eCrash.SUFFIX_CONSOLIDATION_PR, FileDate, BuildConsolidationPR, 3, FALSE, TRUE); 
	 
// ###########################################################################
//                  Validation of eCrash & Supplemental Base
// ##########################################################################
    ValidateEcrashSuppBase := fn_Validate_eCrashSuppBase();

// ###########################################################################
//                  Validation of CRU Base & Trigger CRU build
// ##########################################################################
    ValidateCRUBase := fn_Validate_CRUBase(FileDate);	

// ###########################################################################
//                  Ecrash Base Builds
// ##########################################################################
	 BuildBase := SEQUENTIAL(
	                         BuildSupplemental, 
	                         BuildeCrash,
													 BuildClaimsClarity, 
													 BuildDocument, 
													 BuildConsolidationMBSAgency,
													 ValidateEcrashSuppBase,
													 BuildCRUVehicleIncidents,
													 BuildConsolidationeCRU,
													 BuildConsolidationeCrash,
													 BuildConsolidationPR, 
                           ValidateCRUBase
													);
	 RETURN BuildBase;	 
END;
