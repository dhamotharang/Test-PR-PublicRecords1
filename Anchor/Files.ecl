EXPORT Files := MODULE

IMPORT Anchor, Data_Services, PRTE2, ut, STD;

	Raw_in	:= DATASET('~thor_data400::in::email::anchor', Anchor.Layouts.Raw, CSV(HEADING(0), SEPARATOR('\t'),TERMINATOR('\n'), QUOTE('"')));
	
		//Clean invalid characters from input fields
	PRTE2.CleanFields(Raw_in, dsCleanOut);
	
	EXPORT Raw_out	:= dsCleanOut;
	
	EXPORT Base_BIP	:= DATASET(Anchor.thor_cluster+'base::email::anchor', Anchor.Layouts.Base_w_bip, THOR,OPT);
													
	EXPORT Base_out	:= PROJECT(Base_BIP, TRANSFORM(Anchor.Layouts.Base, SELF := LEFT));											
													
END;