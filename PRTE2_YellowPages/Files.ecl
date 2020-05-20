IMPORT BBB2, bipv2, YellowPages;

export Files := module

	EXPORT YellowPages_In		:= DATASET(Constants.IN_NAME, 		Layouts.Layout_YellowPages_In,	CSV(HEADING(1), SEPARATOR('\t'), TERMINATOR(['\n','\r\n']), QUOTE('"')) );
	EXPORT YellowPages_Ins_In	:= DATASET(Constants.IN_NAME+'_ins',Layouts.Layout_YellowPages_In,	CSV(HEADING(1), SEPARATOR('\t'), TERMINATOR(['\n','\r\n']), QUOTE('"')) );
		
	EXPORT YellowPages_Base	:= DATASET(Constants.BASE_NAME, Layouts.Layout_YellowPages_Base, FLAT);

	EXPORT File_Keybuild := PROJECT(YellowPages_Base,YellowPages.Layout_YellowPages_Base_Slim);
	
	EXPORT File_Base_v2_Bip := PROJECT(YellowPages_Base,YellowPages.Layout_YellowPages_Base_v2_bip_Slim);
	
END;