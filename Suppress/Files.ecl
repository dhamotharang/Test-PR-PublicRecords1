IMPORT	tools, ut, std, PRTE2;
EXPORT Files := MODULE

	EXPORT OptOut := MODULE
		EXPORT	Input_Raw	:=  DATASET(Filenames().OptOut.Input.Sprayed, Layout_OptOut_In, CSV(HEADING(1), SEPARATOR('|'), QUOTE('')));	
		EXPORT	Basefile	:=  DATASET(Filenames().OptOut.Base, Layout_OptOut_Base, THOR, OPT);
	END;

END;