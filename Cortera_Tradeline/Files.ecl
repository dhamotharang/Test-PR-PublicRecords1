IMPORT $, tools;

EXPORT Files(string pversion = '',boolean pUseOtherEnvironment = false) := MODULE
/*
	export Adds := DATASET($.Promote().sfAdds, $.Layout_Tradeline, CSV(
																								SEPARATOR('|')
																							, TERMINATOR(['\n', '\r\n'])
																							, HEADING(1)
																							, MAXLENGTH(1024)
																							));

	export Dels := DATASET($.Promote().sfDels, $.Layout_Delete, CSV(
																								SEPARATOR('|')
																							, TERMINATOR(['\n', '\r\n'])
																							, HEADING(1)
																							, MAXLENGTH(1024)
																							));
																							
	export Base := Dataset($.Promote().sfBase, $.layout_Tradeline_Base, THOR);
*/	
	//////////////////////////////////////////////////////////////////
	// -- Input File Versions
	//////////////////////////////////////////////////////////////////
	EXPORT Input := MODULE
		tools.mac_FilesInput($.Filenames(pversion,pUseOtherEnvironment).Input.Adds	,$.Layout_Tradeline		,Tradeline_Adds		,'CSV'	, ,pTerminator := ['\n','\r\n'] ,pSeparator := '|' ,pHeading := 1);
		tools.mac_FilesInput($.Filenames(pversion,pUseOtherEnvironment).Input.Dels	,$.Layout_Delete			,Tradeline_Dels		,'CSV'	, ,pTerminator := ['\n','\r\n'] ,pSeparator := '|' ,pHeading := 1);
	END;
	
	//////////////////////////////////////////////////////////////////
	// -- Base File Versions
	//////////////////////////////////////////////////////////////////
	EXPORT Base := MODULE
		tools.mac_FilesBase	($.Filenames(pversion,pUseOtherEnvironment).Base.Tradeline	,$.layout_Tradeline_Base	,Tradeline	);
	END;

END;
