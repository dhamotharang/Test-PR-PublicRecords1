//  PRTE2_PropertyInfo_Ins.Q_SETUP_Create_SuperFiles_BWR 

IMPORT promotesupers, PRTE2_PropertyInfo_Ins;

Alpha_PII_Final_Base_Name		:= PRTE2_PropertyInfo_Ins.Files.Alpha_PII_Final_Base_Name;

OUTPUT(Alpha_PII_Final_Base_Name);

promotesupers.mac_create_superfiles(Alpha_PII_Final_Base_Name);
