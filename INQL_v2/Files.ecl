IMPORT tools;

EXPORT Files(STRING pversion = '', boolean pUseProd = false) := MODULE

	/* Input File Versions */
	export Accurint_input
		:= dataset(INQL_v2.Filenames(pversion,pUseProd).Accurint_lInputTemplate, INQL_v2.layouts.Accurint_In, csv( separator('~~'), terminator(['\n', '\r\n'])));
	export Accurint_input_history
		:= dataset(INQL_v2.Filenames(pversion,pUseProd).Accurint_lInputHistTemplate, INQL_v2.layouts.Accurint_In, csv( separator('~~'), terminator(['\n', '\r\n'])));
		
	export Custom_input
		:= dataset(INQL_v2.Filenames(pversion,pUseProd).Custom_lInputTemplate, INQL_v2.layouts.Custom_In, csv( separator('~~'), terminator(['\n', '\r\n'])));
	export Custom_input_history
		:= dataset(INQL_v2.Filenames(pversion,pUseProd).Custom_lInputHistTemplate, INQL_v2.layouts.Custom_In, csv( separator('~~'), terminator(['\n', '\r\n'])));

	export Banko_input
		:= dataset(INQL_v2.Filenames(pversion,pUseProd).Banko_lInputTemplate, INQL_v2.layouts.Banko_In, csv( separator('~~'), terminator(['\n', '\r\n'])));
	export Banko_input_history
		:= dataset(INQL_v2.Filenames(pversion,pUseProd).Banko_lInputHistTemplate, INQL_v2.layouts.Banko_In, csv( separator('~~'), terminator(['\n', '\r\n'])));

	export Batch_input
		:= dataset(INQL_v2.Filenames(pversion,pUseProd).Batch_lInputTemplate, INQL_v2.layouts.Batch_In, csv( separator('~~'), terminator(['\n', '\r\n'])));
	export Batch_input_history
		:= dataset(INQL_v2.Filenames(pversion,pUseProd).Batch_lInputHistTemplate, INQL_v2.layouts.Batch_In, csv( separator('~~'), terminator(['\n', '\r\n'])));
	
	export BatchR3_input
		:= dataset(INQL_v2.Filenames(pversion,pUseProd).BatchR3_lInputTemplate, INQL_v2.layouts.BatchR3_In, csv( separator('~~'), terminator(['\n', '\r\n'])));
	export BatchR3_input_history
		:= dataset(INQL_v2.Filenames(pversion,pUseProd).BatchR3_lInputHistTemplate, INQL_v2.layouts.BatchR3_In, csv( separator('~~'), terminator(['\n', '\r\n'])));

	export Bridger_input
		:= dataset(INQL_v2.Filenames(pversion,pUseProd).Bridger_lInputTemplate, INQL_v2.layouts.Bridger_In, csv( separator('~~'), terminator(['\n', '\r\n'])));
	export Bridger_input_history
		:= dataset(INQL_v2.Filenames(pversion,pUseProd).Bridger_lInputHistTemplate, INQL_v2.layouts.Bridger_In, csv( separator('~~'), terminator(['\n', '\r\n'])));

	export Riskwise_input
		:= dataset(INQL_v2.Filenames(pversion,pUseProd).Riskwise_lInputTemplate, INQL_v2.layouts.Riskwise_In, csv( separator('~~'), terminator(['\n', '\r\n'])));
	export Riskwise_input_history
		:= dataset(INQL_v2.Filenames(pversion,pUseProd).Riskwise_lInputHistTemplate, INQL_v2.layouts.Riskwise_In, csv( separator('~~'), terminator(['\n', '\r\n'])));
	
	export IDM_input
		:= dataset(INQL_v2.Filenames(pversion,pUseProd).IDM_lInputTemplate, INQL_v2.layouts.IDM_In, csv( separator('~~'), terminator(['\n', '\r\n'])));
	export IDM_input_history
		:= dataset(INQL_v2.Filenames(pversion,pUseProd).IDM_lInputHistTemplate, INQL_v2.layouts.IDM_In, csv( separator('~~'), terminator(['\n', '\r\n'])));
	
	export SBA_input
		:= dataset(INQL_v2.Filenames(pversion,pUseProd).SBA_lInputTemplate, INQL_v2.layouts.SBA_In, csv( separator('~~'), terminator(['\n', '\r\n'])));
	export SBA_input_history
		:= dataset(INQL_v2.Filenames(pversion,pUseProd).SBA_lInputHistTemplate, INQL_v2.layouts.SBA_In, csv( separator('~~'), terminator(['\n', '\r\n'])));

	/* Base File Versions */
	tools.mac_FilesBase(INQL_v2.Filenames(pversion,pUseProd).Accurint_Base, INQL_v2.layouts.Accurint_Base, 	Accurint_base);
	tools.mac_FilesBase(INQL_v2.Filenames(pversion,pUseProd).Custom_Base, 	INQL_v2.layouts.Custom_Base, 		Custom_base);
	tools.mac_FilesBase(INQL_v2.Filenames(pversion,pUseProd).Banko_Base, 		INQL_v2.layouts.Banko_Base, 		Banko_base);
	tools.mac_FilesBase(INQL_v2.Filenames(pversion,pUseProd).Batch_Base, 		INQL_v2.layouts.Batch_Base, 		Batch_base);
	tools.mac_FilesBase(INQL_v2.Filenames(pversion,pUseProd).BatchR3_Base, 	INQL_v2.layouts.BatchR3_Base, 	BatchR3_base);
	tools.mac_FilesBase(INQL_v2.Filenames(pversion,pUseProd).Bridger_Base, 	INQL_v2.layouts.Bridger_Base, 	Bridger_base);
	tools.mac_FilesBase(INQL_v2.Filenames(pversion,pUseProd).Riskwise_Base, INQL_v2.layouts.Riskwise_Base, 	Riskwise_base);
	tools.mac_FilesBase(INQL_v2.Filenames(pversion,pUseProd).IDM_Base, 			INQL_v2.layouts.IDM_Base, 			IDM_base);
	tools.mac_FilesBase(INQL_v2.Filenames(pversion,pUseProd).SBA_Base, 			INQL_v2.layouts.SBA_Base, 			SBA_base);
	 
	/* Keybuild File */
	//versioncontrol.macBuildFileVersions(Filenames(pversion).keybuild, layouts.keybuild, keybuild); 
	 
END;