IMPORT tools, data_services;

EXPORT Files(boolean isDaily = true, boolean isFCRA = true, string pVersion = '') := MODULE
 
 // Sprayed file  
 export Input
		:= dataset(INQL_FFD.Filenames(isDaily,isFCRA,pVersion).Input, INQL_FFD.layouts.Input, csv(separator('|\t|'),quote(''),terminator('|\n')), opt);

 // To process file 
 export InputBuilding
		:= dataset(INQL_FFD.Filenames(isDaily,isFCRA,pVersion).InputBuilding, INQL_FFD.layouts.Input, csv(separator('|\t|'),quote(''),terminator('|\n')), opt);

 // Processed file 
 export InputBuilt
		:= dataset(INQL_FFD.Filenames(isDaily,isFCRA,pVersion).InputBuilt, INQL_FFD.layouts.Input, csv(separator('|\t|'),quote(''),terminator('|\n')), opt);
 
 // Archived file 		
 export InputHistory
		:= dataset(INQL_FFD.Filenames(isDaily,isFCRA,pVersion).InputHistory, INQL_FFD.layouts.Input_History, csv(separator('|\t|'),quote(''),terminator('|\n')), opt);
	
/* Base File pVersions */
 tools.mac_FilesBase(INQL_FFD.Filenames(isDaily,isFCRA,pVersion).Base, INQL_FFD.Layouts.Base,popt:=true, Base);
	
 export PPC_Mapping
		:=dataset(INQL_FFD.Filenames().PPC_Mapping,INQL_FFD.layouts.PPC_Mapping,csv(separator(','),quote(''),terminator('|\n'),heading(1)), opt);
 
END;