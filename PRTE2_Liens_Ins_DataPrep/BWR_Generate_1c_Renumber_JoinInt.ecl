/* ************************************************************************************
PRTE2_Liens_Ins_DataPrep.BWR_Generate_1c_Renumber_JoinInt
************************************************************************************ */

IMPORT PRTE2_X_Ins_DataCleanse, PRTE2_Liens_Ins, PRTE2_Liens_Ins_DataPrep, PromoteSupers, PRTE2_Common,STD;

ExistingIncomingBase := Files.Incoming_IHDR_DS;
	
ExistingIncomingBase trxBase(ExistingIncomingBase L, INTEGER CNT) := TRANSFORM
		SELF.joinint := CNT;
		SELF := L
END;
G_Base := GROUP(SORT(ExistingIncomingBase,state),state);
NewBase := UNGROUP(PROJECT(G_Base,trxBase(LEFT,COUNTER)));

PromoteSupers.Mac_SF_BuildProcess(NewBase, Files.Incoming_IHDR_Name, buildBase1,2);

buildBase1;
