IMPORT promotesupers, PRTE2_Liens_Ins;

Main_IN_Name		:= PRTE2_Liens_Ins.Files.Main_IN_Name;
Party_IN_Name		:= PRTE2_Liens_Ins.Files.Party_IN_Name;
Main_Name_SF		:= PRTE2_Liens_Ins.Files.Main_Name_SF;
Party_Name_SF		:= PRTE2_Liens_Ins.Files.Party_Name_SF;

OUTPUT(Main_IN_Name);
OUTPUT(Party_IN_Name);
OUTPUT(Main_Name_SF);
OUTPUT(Party_Name_SF);

promotesupers.mac_create_superfiles(Main_IN_Name);
promotesupers.mac_create_superfiles(Party_IN_Name);
promotesupers.mac_create_superfiles(Main_Name_SF);
promotesupers.mac_create_superfiles(Party_Name_SF);

