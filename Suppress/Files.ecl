IMPORT	tools, ut, std, PRTE2;
EXPORT Files := MODULE

	EXPORT OptOut := MODULE
		EXPORT	Input_Raw		:=  DATASET($.Filenames().OptOut.Input.Sprayed, $.Layout_OptOut_In, CSV(HEADING(1), SEPARATOR('|'), QUOTE('')),OPT);	
		EXPORT	Basefile		:=  DATASET($.Filenames().OptOut.Base, $.Layout_OptOut_Base, THOR, OPT);
		EXPORT	Basefile_FCRA	:=  DATASET($.Filenames().OptOut.Base_FCRA, $.Layout_OptOut_Base, THOR, OPT);
	END;

	EXPORT Exemptions := MODULE
		EXPORT	Input_PR		:=  DATASET($.Filenames().Exemptions.Input_PR.Sprayed, $.Layout_Exemptions_In, CSV(HEADING(1), SEPARATOR(','), QUOTE('"')),OPT);
		EXPORT	Input_HC		:=  DATASET($.Filenames().Exemptions.Input_HC.Sprayed, $.Layout_Exemptions_In, CSV(HEADING(1), SEPARATOR(','), QUOTE('"')),OPT);
		EXPORT	Input_Ins		:=  DATASET($.Filenames().Exemptions.Input_Ins.Sprayed, $.Layout_Exemptions_In, CSV(HEADING(1), SEPARATOR(','), QUOTE('"')),OPT);
		EXPORT	Basefile		:=	DATASET($.Filenames().Exemptions.Base, $.Layout_Exemptions_Base, THOR, OPT);	
	END;

	EXPORT Global_Sid := MODULE
		EXPORT	Basefile		:=	DATASET($.Filenames().Global_Sid.Base, $.Layout_Global_Sid_Base, THOR, OPT);	
	END;

END;