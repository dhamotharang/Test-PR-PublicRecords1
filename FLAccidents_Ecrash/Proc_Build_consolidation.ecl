IMPORT RoxieKeybuild,Std,PromoteSupers;

EXPORT Proc_Build_Consolidation (string filedate) := FUNCTION
Consolidation_Ecrash := File_KeybuildV2.out;
Consolidation_Pr := File_KeybuildV2.prout;

PromoteSupers.Mac_SF_BuildProcess(BuildIncidentsExtract,'~thor_data400::base::ecrash_Incidents',buildIncidents_Extract,,,true);
                PromoteSupers.Mac_SF_BuildProcess(File_KeybuildV2.Alpha,'~thor_data400::base::accidents_alpha',buildBase,,,true);
                RoxieKeyBuild.Mac_SF_BuildProcess_V2(Consolidation_Ecrash, Files_eCrash.BASE_ECRASH_PREFIX, Files_eCrash.SUFFIX_NAME_CONSOLIDATION_ECRASH, filedate, BuildAccConsolidationeCrash, 3, FALSE, TRUE); 
								RoxieKeyBuild.Mac_SF_BuildProcess_V2(Consolidation_Pr,Files_eCrash.BASE_ECRASH_PREFIX, Files_eCrash.SUFFIX_NAME_CONSOLIDATION_PR, filedate, BuildAccConsolidationPR, 3, FALSE, TRUE); 

RETURN SEQUENTIAL(buildIncidents_Extract,buildBase, BuildAccConsolidationeCrash, BuildAccConsolidationPR); 

END;
