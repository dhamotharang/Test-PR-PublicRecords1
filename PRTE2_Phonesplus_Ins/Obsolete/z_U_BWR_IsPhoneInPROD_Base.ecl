IMPORT PRTE2_Phonesplus_Ins;

DS := PRTE2_Phonesplus_Ins.Files.PhonesPlus_Base_SF_DS_Prod;
DS2 := DS(cellphone='9075551212' OR homephone='9075551212');
OUTPUT(DS2);