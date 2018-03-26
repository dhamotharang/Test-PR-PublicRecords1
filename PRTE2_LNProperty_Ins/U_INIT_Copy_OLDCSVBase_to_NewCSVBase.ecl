/* *********************************************************************************************
PRTE2_LNProperty_Ins.U_INIT_Copy_OLDCSVBase_to_NewCSVBase

NEW EARLY INITIALIZATION - 
Takes the OLD LNProperty Alpha Base file and copies it to the new logical and SF naming structure.
Same layout for now - just creating new file to start fresh.  
All old files can be known now as being obsolete once we move to this.
********************************************************************************************* */


IMPORT PromoteSupers,PRTE2_LNProperty_Ins,PRTE2_LNProperty_Ins_Old;

// ------- Phase 1 ---------------------------------------------------------------------------------
// DataDS := PRTE2_LNProperty_Ins_Old.Files.ALP_LNP_SF_DS_Prod;
// PromoteSupers.Mac_SF_BuildProcess(DataDS, PRTE2_LNProperty_Ins.Files.ALP_LNP_SF_NAME, build_main_base);
// SEQUENTIAL(build_main_base);
// OUTPUT(PRTE2_LNProperty_Ins.Files.ALP_LNP_SF_DS);  		// test success..
// -------------------------------------------------------------------------------------------------


// ------- Phase 2 ---------------------------------------------------------------------------------
DataDS := PRTE2_LNProperty_Ins.Files.ALP_LNP_SF_DS;
PromoteSupers.Mac_SF_BuildProcess(DataDS, PRTE2_LNProperty_Ins.Files.ALP_IN_SF_NAME, build_main_base);
SEQUENTIAL(build_main_base);
// -------------------------------------------------------------------------------------------------
OUTPUT(PRTE2_LNProperty_Ins.Files.ALP_IN_SF_DS);				// test success..
