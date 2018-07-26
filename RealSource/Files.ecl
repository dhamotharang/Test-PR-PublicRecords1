EXPORT Files := MODULE
IMPORT RealSource, Data_Services, PRTE2, ut, STD;

	Raw_In	:= DATASET(RealSource.thor_cluster +'in::email::RealSource',RealSource.Layouts.Raw, CSV(HEADING(1), SEPARATOR(','),TERMINATOR('\n'), QUOTE('"')));
																																			
	//Clean invalid characters from input fields
	PRTE2.CleanFields(Raw_in, dsCleanOut);
	
	EXPORT Raw_out	:= dsCleanOut;
	
	//EXPORT IngestBase	:= DATASET(RealSource.thor_cluster +'ingest::email::RealSource',RealSource.Layouts.Base, THOR); //Was just used for testing initial
													
	EXPORT Base_out	:= DATASET(RealSource.thor_cluster +'base::email::RealSource',RealSource.Layouts.Base, THOR,OPT);
	
END;