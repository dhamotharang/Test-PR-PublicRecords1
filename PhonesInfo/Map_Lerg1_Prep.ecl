//Prep the Lerg1 and Lerg1Con Files for the Address Cleaner

EXPORT Map_Lerg1_Prep(string version) := FUNCTION 

	inFile 		:= PhonesInfo.Reform_Common_Lerg(version).Lerg1 + PhonesInfo.Reform_Common_Lerg(version).Lerg1Con;
	cleanFile := PhonesInfo.Map_Lerg_Prep(inFile);
	
	return	cleanFile;

END;