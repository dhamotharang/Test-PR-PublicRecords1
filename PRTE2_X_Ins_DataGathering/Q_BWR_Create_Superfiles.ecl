IMPORT promotesupers;

Files := PRTE2_X_Ins_DataGathering.Files;
Main_IN_Name		:= Files.VIN_Data_Name;

OUTPUT(Main_IN_Name);

promotesupers.mac_create_superfiles(Main_IN_Name);

/*	*******************	Using these then works like the following *********************
IMPORT PromoteSupers;
PromoteSupers.Mac_SF_BuildProcess(MainDS, Files.File1_Name, build_main_base,,,TRUE);
************************************************************************************** */
