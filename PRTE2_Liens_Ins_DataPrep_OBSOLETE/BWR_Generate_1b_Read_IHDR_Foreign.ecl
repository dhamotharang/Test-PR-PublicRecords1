/* ************************************************************************************
PRTE2_Liens_Ins_DataPrep.BWR_Generate_1b_Read_IHDR_Foreign
Same as BWR_Generate_1a_Spray_IHDR_Records except read from Foreign base with filter
==> This also has an added option to replace the data or append to existing data.
************************************************************************************ */
IMPORT PRTE2_X_Ins_DataCleanse, PRTE2_Liens_Ins, PRTE2_Liens_Ins_DataPrep, PromoteSupers, PRTE2_Common,STD;

	appendToExisting := TRUE;			// TRUE means keep existing data in the Incoming_IHDR_DS base and append the spray data
	// appendToExisting := FALSE;			// This means overwrite Files.Incoming_IHDR_DS base and we start with new data.

	Constants := PRTE2_Liens_Ins.Constants;
	FilesLJ		:= PRTE2_Liens_Ins.Files;
	Files			:= PRTE2_Liens_Ins_DataPrep.Files;
	Layouts		:= PRTE2_Liens_Ins_DataPrep.Layouts;

	IHDR_MAIN := PRTE2_X_Ins_DataCleanse.Files_Alpha.InsHeadDLDeath_Base_DS_PROD;
	IHDR_Filtered1 := IHDR_MAIN(ln_product_tie='TU_Data');
	IHDR_Filtered2 := IHDR_MAIN(ln_product_tie='Eqfx_data');
	IHDR_Filtered := IHDR_Filtered1+IHDR_Filtered2;
	
	SprayedIncoming := PROJECT(SORT(IHDR_Filtered,STATE),
																TRANSFORM(Layouts.IHDR_DL_Death_Joinable,
																SELF.JoinInt := COUNTER, 
																SELF := LEFT));

	ExistingIncomingBase := Files.Incoming_IHDR_DS;
	NewBase := IF(appendToExisting, ExistingIncomingBase+SprayedIncoming, SprayedIncoming);
	NewBase trxBase(NewBase L, INTEGER CNT) := TRANSFORM
			SELF.joinint := CNT;
			SELF := L
	END;
	G_Base := GROUP(SORT(NewBase,state),state);
	FinalData := UNGROUP(PROJECT(G_Base,trxBase(LEFT,COUNTER)));
	
	PromoteSupers.Mac_SF_BuildProcess(FinalData, Files.Incoming_IHDR_Name, buildBase1,2);
																				 
	// --------------------------------------------------
	delSprayedFile  := FileServices.DeleteLogicalFile (Files.Spray_IIHDR_Name);
	// --------------------------------------------------
	BaseBuiltDS := Files.Incoming_IHDR_DS;
	ShowResults := CHOOSEN(BaseBuiltDS, 200);	
	// --------------------------------------------------
	SEQUENTIAL ( OUTPUT(COUNT(IHDR_Filtered)),OUTPUT(COUNT(FinalData))
							, buildBase1
							, delSprayedFile
							);


