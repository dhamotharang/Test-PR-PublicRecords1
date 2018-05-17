// Run in Dev and Prod today 1/19/18

IMPORT promotesupers,PRTE2_WaterCraft_Ins;

promotesupers.mac_create_superfiles(PRTE2_WaterCraft_Ins.Utilities.Files.FakePIIGatherName);

/*	*******************	Using these then works like the following *********************
IMPORT PromoteSupers;
PromoteSupers.Mac_SF_BuildProcess(MainDS, Files.File1_Name, build_main_base,,,TRUE);
************************************************************************************** */
