// Run in Dev and Prod today 1/19/18

IMPORT promotesupers;
// IMPORT promotesupers, PRTE2_WaterCraft_Ins;
// Main_IN_Name		:= PRTE2_WaterCraft_Ins.Files.SuperFile.Internal_All_Slim_Name;
// IE (for PROD before the code):
Main_IN_Name		:= '~prte::internal::prte2::WaterCraft::AllDataSlim_ALPHA';

OUTPUT(Main_IN_Name);

promotesupers.mac_create_superfiles(Main_IN_Name);

/*	*******************	Using these then works like the following *********************
IMPORT PromoteSupers;
PromoteSupers.Mac_SF_BuildProcess(MainDS, Files.File1_Name, build_main_base,,,TRUE);
************************************************************************************** */
