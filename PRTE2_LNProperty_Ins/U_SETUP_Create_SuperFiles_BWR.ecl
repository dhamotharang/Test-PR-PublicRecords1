IMPORT promotesupers, PRTE2_LNProperty_Ins;

// Base_Name		:= PRTE2_LNProperty_Ins.Files.ALP_LNP_SF_NAME;
Base_Name		:= PRTE2_LNProperty_Ins.Files.ALP_IN_SF_NAME;

OUTPUT(Base_Name);

promotesupers.mac_create_superfiles(Base_Name);

