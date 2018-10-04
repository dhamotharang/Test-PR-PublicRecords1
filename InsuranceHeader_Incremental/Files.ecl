IMPORT Header, idl_header,InsuranceHeader_Address;
EXPORT Files := MODULE
  
	// Full Super file for incremental just to avoid incremental not to use new fullbase before full xlink keys are done 
	
 EXPORT dsBase  := DATASET(Filenames.dsBase_SF.current, idl_header.Layout_Header_Link, THOR);
	
	// Suppression Input 	
	EXPORT IncSuppression_Current_DS			  := DATASET(Filenames.IncSuppression_SF.current, Layout_Base, THOR, OPT);
	EXPORT IncSuppression_Father_DS			   := DATASET(Filenames.IncSuppression_SF.father, Layout_Base, THOR);
	EXPORT IncSuppression_Grandfather_DS	:= DATASET(Filenames.IncSuppression_SF.grandfather, Layout_Base, THOR);
	// Link Correction Input 	
	EXPORT IncCorrection_Current_DS			  := DATASET(Filenames.IncCorrection_SF.current, Layout_Base, THOR, OPT);
	EXPORT IncCorrection_Father_DS			   := DATASET(Filenames.IncCorrection_SF.father,  Layout_Base, THOR);
	EXPORT IncCorrection_Grandfather_DS	:= DATASET(Filenames.IncCorrection_SF.grandfather, Layout_Base, THOR);

	// incremental base
	EXPORT IncBase_Current_DS			  := DATASET(Filenames.IncBase_SF.current, Layout_Header_Incremental, THOR, OPT);
	EXPORT IncBase_Father_DS			   := DATASET(Filenames.IncBase_SF.father, Layout_Header_Incremental, THOR);
	EXPORT IncBase_Grandfather_DS	:= DATASET(Filenames.IncBase_SF.grandfather, Layout_Header_Incremental, THOR);
	
		// incremental base All 
		
	EXPORT IncBaseAll_Current_DS			  := DATASET(Filenames.IncBaseAll_SF.current, Layout_Header_Incremental, THOR, OPT);
	EXPORT IncBaseAll_Father_DS			   := DATASET(Filenames.IncBaseAll_SF.father, Layout_Header_Incremental, THOR);
	EXPORT IncBaseAll_Grandfather_DS	:= DATASET(Filenames.IncBaseAll_SF.grandfather, Layout_Header_Incremental, THOR);
		
	// incremental archive
	EXPORT IncBase_Archive_Current_DS			  := DATASET(Filenames.IncBase_Archive_SF.current, Layout_Header_Incremental, THOR, OPT);
	EXPORT IncBase_Archive_Father_DS			   := DATASET(Filenames.IncBase_Archive_SF.father, Layout_Header_Incremental, THOR);
	EXPORT IncBase_Archive_Grandfather_DS	:= DATASET(Filenames.IncBase_Archive_SF.grandfather, Layout_Header_Incremental, THOR);
	
	// SALT input
	EXPORT SALT_Input_Current_DS			  := DATASET(Filenames.SALT_Input_SF.current, Layout_Header, THOR, OPT);
	EXPORT SALT_Input_Father_DS			   := DATASET(Filenames.SALT_Input_SF.father, Layout_Header, THOR);
	EXPORT SALT_Input_Grandfather_DS	:= DATASET(Filenames.SALT_Input_SF.grandfather, Layout_Header, THOR);
	
	// SALT output
	EXPORT SALT_Output_Current_DS			  := DATASET(Filenames.SALT_Output_SF.current, Layout_Header, THOR, OPT);
	EXPORT SALT_Output_Father_DS			   := DATASET(Filenames.SALT_Output_SF.father, Layout_Header, THOR);
	EXPORT SALT_Output_Grandfather_DS	:= DATASET(Filenames.SALT_Output_SF.grandfather, Layout_Header, THOR);
	
	// public records raw as header
	EXPORT RawAsHeader_Boca_Current_DS    		  := PROJECT(DATASET(Filenames.RawAsHeader_Boca_SF.current, Header.layout_header_v2_dl, THOR, OPT), Header.layout_header_v2_dl);
	EXPORT RawAsHeader_Boca_Father_DS    			  := PROJECT(DATASET(Filenames.RawAsHeader_Boca_SF.father, Header.layout_header_v2_dl, THOR), Header.layout_header_v2_dl);
	EXPORT RawAsHeader_Boca_Grandfather_DS    := PROJECT(DATASET(Filenames.RawAsHeader_Boca_SF.grandfather, Header.layout_header_v2_dl, THOR), Header.layout_header_v2_dl);
	
	// built as header, all records
	EXPORT AsHeaderAll_Current_DS    		 := DATASET(Filenames.AsHeaderAll_SF.current, Layout_Header_Delta, THOR, OPT);
	EXPORT AsHeaderAll_Father_DS    		  := DATASET(Filenames.AsHeaderAll_SF.father, Layout_Header_Delta, THOR);
	EXPORT AsHeaderAll_Grandfather_DS   := DATASET(Filenames.AsHeaderAll_SF.grandfather, Layout_Header_Delta, THOR);
	
	// latest as header 
	
	EXPORT AsHeader_Current_DS    		  := DATASET(Filenames.AsHeader_SF.current, Layout_Header_Plus, THOR, OPT);
	EXPORT AsHeader_Father_DS    		   := DATASET(Filenames.AsHeader_SF.father, Layout_Header_Plus, THOR);
	EXPORT AsHeader_Grandfather_DS    := DATASET(Filenames.AsHeader_SF.grandfather, Layout_Header_Plus, THOR);


	// built as header, new records only
	EXPORT AsHeaderNewOnly_Current_DS    		:= DATASET(Filenames.AsHeaderNewOnly_SF.current, Layout_Header_Plus, THOR, OPT);
	EXPORT AsHeaderNewOnly_Father_DS    		 := DATASET(Filenames.AsHeaderNewOnly_SF.father, Layout_Header_Plus, THOR);
	EXPORT AsHeaderNewOnly_Grandfather_DS  := DATASET(Filenames.AsHeaderNewOnly_SF.grandfather, Layout_Header_Plus, THOR);
	
	// stats files
	// ingest
	EXPORT StatsIngest_Current_DS    		:= DATASET(Filenames.StatsIngest_SF.current, Layout_Stats, THOR, OPT);
	EXPORT StatsIngest_Father_DS    		 := DATASET(Filenames.StatsIngest_SF.father, Layout_Stats, THOR);
	EXPORT StatsIngest_Grandfather_DS  := DATASET(Filenames.StatsIngest_SF.grandfather, Layout_Stats, THOR);
	
	// new entity only records
	EXPORT StatsNewOnly_Current_DS    	  := DATASET(Filenames.StatsNewOnly_SF.current, Layout_Stats, THOR, OPT);
	EXPORT StatsNewOnly_Father_DS    		  := DATASET(Filenames.StatsNewOnly_SF.father, Layout_Stats, THOR);
	EXPORT StatsNewOnly_Grandfather_DS   := DATASET(Filenames.StatsNewOnly_SF.grandfather, Layout_Stats, THOR);
	
	// internal linking
	EXPORT StatsILink_Current_DS    	 := DATASET(Filenames.StatsILink_SF.current, Layout_Stats, THOR, OPT);
	EXPORT StatsILink_Father_DS    		 := DATASET(Filenames.StatsILink_SF.father, Layout_Stats, THOR);
	EXPORT StatsILink_Grandfather_DS  := DATASET(Filenames.StatsILink_SF.grandfather, Layout_Stats, THOR);
	
	// incremental base file stats
	EXPORT StatsIncBase_Current_DS    	 := DATASET(Filenames.StatsIncBase_SF.current, Layout_Stats, THOR, OPT);
	EXPORT StatsIncBase_Father_DS    		 := DATASET(Filenames.StatsIncBase_SF.father, Layout_Stats, THOR);
	EXPORT StatsIncBase_Grandfather_DS  := DATASET(Filenames.StatsIncBase_SF.grandfather, Layout_Stats, THOR);
	
	// Build Date Tracking file 
	EXPORT BuildDate_Current_DS    	  := DATASET(Filenames.BuildDate_SF.current, Layout_date, THOR, OPT);
	EXPORT BuildDate_Father_DS    		  := DATASET(Filenames.BuildDate_SF.father, Layout_date, THOR);
	EXPORT BuildDate_Grandfather_DS   := DATASET(Filenames.BuildDate_SF.grandfather, Layout_date, THOR);
	
	// workman process files
	EXPORT DS_MasterWorkmanOutput		:= DATASET(Filenames.MasterWorkmanOutputSF, Layout_WUSummary.WUInfo, THOR);
	
	// Existing Base 
	
	EXPORT AsHeaderExisting_Current_DS    		:= DATASET(Filenames.AsHeaderExisting_SF.current, Layout_Header_Plus, THOR, OPT);
	EXPORT AsHeaderExisting_Father_DS    		 := DATASET(Filenames.AsHeaderExisting_SF.father, Layout_Header_Plus, THOR);
	EXPORT AsHeaderExisting_Grandfather_DS  := DATASET(Filenames.AsHeaderExisting_SF.grandfather, Layout_Header_Plus, THOR);

// Address Hierarchy Base 
 
 	EXPORT IncHierarchy_Current_DS    		:= DATASET(Filenames.IncHierarchy_SF.current, InsuranceHeader_Address.Layout_Address_Link, THOR, OPT);
	EXPORT  IncHierarchy_Father_DS    		 := DATASET(Filenames.IncHierarchy_SF.father, InsuranceHeader_Address.Layout_Address_Link, THOR);
	EXPORT  IncHierarchy_Grandfather_DS  := DATASET(Filenames.IncHierarchy_SF.grandfather, InsuranceHeader_Address.Layout_Address_Link, THOR);
 
// Best Base file(Full+inc)
	EXPORT  Best_Current_DS    		:= DATASET(Filenames.Best_SF.current, idl_header.Layout_Header_Link, THOR, OPT);
	EXPORT  Best_Father_DS    		 := DATASET(Filenames.Best_SF.father, idl_header.Layout_Header_Link, THOR);
	EXPORT  Best_Grandfather_DS  := DATASET(Filenames.Best_SF.grandfather,idl_header.Layout_Header_Link, THOR);
	
	EXPORT	FCRA_Current_DS			:= DATASET(Filenames.FCRA_SF.current, idl_header.Layout_Header_Link, THOR);
	EXPORT	FCRA_Father_DS			:= DATASET(Filenames.FCRA_SF.father, idl_header.Layout_Header_Link, THOR);
	EXPORT	FCRA_Grandfather_DS			:= DATASET(Filenames.FCRA_SF.grandfather, idl_header.Layout_Header_Link, THOR);
 
END;
