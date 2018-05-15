IMPORT promotesupers;

Main_IN_Name		:= PRTE2_Gong_Ins.Files.Gong_Base_SF;

OUTPUT(Main_IN_Name);

promotesupers.mac_create_superfiles(Main_IN_Name);

/*	*******************	Using these then works like the following *********************
IMPORT PromoteSupers;
PromoteSupers.Mac_SF_BuildProcess(MainDS, Files.File1_Name, build_main_base,,,TRUE);
************************************************************************************** */
