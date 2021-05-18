IMPORT tools, data_services, inql_ffd;

EXPORT Files(boolean isDaily = true, boolean isFCRA = true, string pVersion = '') := MODULE
 
 // Sprayed file  
 export Input
		:= dataset(INQL_FFD.Filenames(isDaily,isFCRA,pVersion).Input, INQL_FFD.layouts.Input, csv(separator('|\t|'),quote(''),terminator('|\n')), opt);
 export InputEncrypted 
		:= dataset(INQL_FFD.Filenames(isDaily,isFCRA,pVersion,true).Input, INQL_FFD.layouts.Input_Encrypted, csv(separator('~~~'),quote(''),terminator('~~^~~')), opt);
 
 // To process file 
 export InputBuilding
		:= dataset(INQL_FFD.Filenames(isDaily,isFCRA,pVersion).InputBuilding, INQL_FFD.layouts.Input, csv(separator('|\t|'),quote(''),terminator('|\n')), opt);
 export InputEncryptedBuilding 
		:= dataset(INQL_FFD.Filenames(isDaily,isFCRA,pVersion,true).InputBuilding, INQL_FFD.layouts.Input_Encrypted, csv(separator('~~~'),quote(''),terminator('~~^~~')), opt);
 	
 // Processed file 
 export InputBuilt
		:= dataset(INQL_FFD.Filenames(isDaily,isFCRA,pVersion).InputBuilt, INQL_FFD.layouts.Input, csv(separator('|\t|'),quote(''),terminator('|\n')), opt);
 export InputEncryptedBuilt 
		:= dataset(INQL_FFD.Filenames(isDaily,isFCRA,pVersion,true).InputBuilt, INQL_FFD.layouts.Input_Encrypted, csv(separator('~~~'),quote(''),terminator('~~^~~')), opt);
 	
 // Archived file 		
 export InputHistory
		:= dataset(INQL_FFD.Filenames(isDaily,isFCRA,pVersion).InputHistory, INQL_FFD.layouts.Input_History, csv(separator('|\t|'),quote(''),terminator('|\n')), opt);
 export InputEncryptedHistory
		:= dataset(INQL_FFD.Filenames(isDaily,isFCRA,pVersion,true).InputHistory, INQL_FFD.layouts.Input_Encrypted_History, csv(separator('~~~'),quote(''),terminator('~~^~~')), opt);
 	
/* Base File pVersions */
 tools.mac_FilesBase(INQL_FFD.Filenames(isDaily,isFCRA,pVersion).Base, INQL_FFD.Layouts.Base,popt:=true, Base);
 tools.mac_FilesBase(INQL_FFD.Filenames(isDaily,isFCRA,pVersion,true).Base, INQL_FFD.Layouts.Base_Encrypted,popt:=true, Base_Encrypted);
 
 export PPC_Mapping
		:=dataset(INQL_FFD.Filenames().PPC_Mapping,INQL_FFD.layouts.PPC_Mapping,csv(separator(','),quote(''),terminator('|\n'),heading(1)), opt);
 
END;