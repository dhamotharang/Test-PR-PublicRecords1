EXPORT Files := MODULE
IMPORT RealSource, Data_Services, PRTE2, ut, STD;

	Raw_In	:= DATASET('~thor_data400::in::email::RealSource',RealSource.Layouts.Raw, CSV(HEADING(1), SEPARATOR(','),TERMINATOR('\n'), QUOTE('"')));
																																			
	//Clean invalid characters from input fields
	PRTE2.CleanFields(Raw_in, dsCleanOut);
	
	EXPORT Raw_out	:= dsCleanOut;
	
	//EXPORT IngestBase	:= DATASET(RealSource.thor_cluster +'ingest::email::RealSource',RealSource.Layouts.Base, THOR); //Was just used for testing initial
	EXPORT Base_BIP	:= DATASET(RealSource.thor_cluster +'base::email::RealSource',RealSource.Layouts.Base_w_bip, THOR,OPT);											
	
	EXPORT Base_out	:= PROJECT(Base_BIP, TRANSFORM(RealSource.Layouts.Base, SELF := LEFT));
	
END;