/* ************************************************************************************************************
PRTE2_Liens_Ins_DataPrep.Q_SETUP_Create_SuperFiles_BWR

NOTE: for purposes of just doing data prep and research, I am only using 2 generations of SFs
************************************************************************************************************ */
IMPORT PRTE2_Common, PRTE2_Liens_Ins_DataPrep;

TU_File		:= PRTE2_Liens_Ins_DataPrep.Files.Save_TU_Name;
EQ_File		:= PRTE2_Liens_Ins_DataPrep.Files.Save_EQ_Name;
TTU_File	:= PRTE2_Liens_Ins_DataPrep.Files.TMP_TU_Name;
TEQ_File	:= PRTE2_Liens_Ins_DataPrep.Files.TMP_EQ_Name;
Save_ProdParty_Name		:= PRTE2_Liens_Ins_DataPrep.Files.Save_ProdParty_Name;
Save_ProdMain_Name		:= PRTE2_Liens_Ins_DataPrep.Files.Save_ProdMain_Name;
Incoming_IHDR_Name		:= PRTE2_Liens_Ins_DataPrep.Files.Incoming_IHDR_Name;
Save_PartyWIP_Name		:= PRTE2_Liens_Ins_DataPrep.Files.Save_PartyWIP_Name;
Save_MainWIP_Name		:= PRTE2_Liens_Ins_DataPrep.Files.Save_MainWIP_Name;
Incoming_BocaHit_Name		:= PRTE2_Liens_Ins_DataPrep.Files.Incoming_BocaHit_Name;
// PRTE2_Common.mac_create_superfiles(TU_File,2);
// PRTE2_Common.mac_create_superfiles(TTU_File,2);
// PRTE2_Common.mac_create_superfiles(EQ_File,2);
// PRTE2_Common.mac_create_superfiles(TEQ_File,2);
// PRTE2_Common.mac_create_superfiles(Save_ProdParty_Name,2);
// PRTE2_Common.mac_create_superfiles(Save_ProdMain_Name,2);
// PRTE2_Common.mac_create_superfiles(Incoming_IHDR_Name,2);
PRTE2_Common.mac_create_superfiles(Save_PartyWIP_Name,2);
PRTE2_Common.mac_create_superfiles(Save_MainWIP_Name,2);
// PRTE2_Common.mac_create_superfiles(Incoming_BocaHit_Name,2);
