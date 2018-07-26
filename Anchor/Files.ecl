EXPORT Files := MODULE

IMPORT Anchor, Data_Services, PRTE2, ut, STD;

	Raw_in	:= DATASET(Anchor.thor_cluster+'in::email::anchor', Anchor.Layouts.Raw, CSV(HEADING(0), SEPARATOR('\t'),TERMINATOR('\n'), QUOTE('"')));
	
		//Clean invalid characters from input fields
	PRTE2.CleanFields(Raw_in, dsCleanOut);
	
	EXPORT Raw_out	:= dsCleanOut;
													
	EXPORT Base_out	:= DATASET(Anchor.thor_cluster+'base::email::anchor', Anchor.Layouts.Base, THOR,OPT);											
													
END;