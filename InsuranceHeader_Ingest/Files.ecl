IMPORT Header;

EXPORT Files := MODULE
	
	// OLD archive
	EXPORT Base_Archive_Current_DS			:= DATASET(Filenames.Base_Archive_SF.current, Layout_Archive, THOR, OPT);
	EXPORT Base_Archive_Father_DS			  := DATASET(Filenames.Base_Archive_SF.father, Layout_Archive, THOR);
	EXPORT Base_Archive_Grandfather_DS	:= DATASET(Filenames.Base_Archive_SF.grandfather, Layout_Archive, THOR);
	
	// built as header, all records
	EXPORT AsHeaderAll_Current_DS    		:= DATASET(Filenames.AsHeaderAll_SF.current, Layout_Header_Plus, THOR, OPT);
	EXPORT AsHeaderAll_Father_DS    		:= DATASET(Filenames.AsHeaderAll_SF.father, Layout_Header_Plus, THOR);
	EXPORT AsHeaderAll_Grandfather_DS   := DATASET(Filenames.AsHeaderAll_SF.grandfather, Layout_Header_Plus, THOR);
	
	// stats files
	EXPORT StatsIngest_Current_DS    		:= DATASET(Filenames.StatsIngest_SF.current, Layout_Stats.Out, THOR, OPT);
	EXPORT StatsIngest_Father_DS    		:= DATASET(Filenames.StatsIngest_SF.father, Layout_Stats.Out, THOR);
	EXPORT StatsIngest_Grandfather_DS   := DATASET(Filenames.StatsIngest_SF.grandfather, Layout_Stats.Out, THOR);
	
	// Boca blank rid's 
	
	EXPORT Base_Bocablankrid_Current_DS			:= DATASET(Filenames.Bocablankrid_SF.current, Layout_Archive, THOR, OPT);
	EXPORT Base_Bocablankrid_Father_DS			:= DATASET(Filenames.Bocablankrid_SF.father, Layout_Archive, THOR);
	EXPORT Base_Bocablankrid_Grandfather_DS	:= DATASET(Filenames.Bocablankrid_SF.grandfather, Layout_Archive, THOR);
	
  // workman process files
	//EXPORT DS_MasterWorkmanOutput		:= DATASET(Filenames.MasterWorkmanOutputSF, Layout_WUSummary.WUInfo, THOR);
END;
