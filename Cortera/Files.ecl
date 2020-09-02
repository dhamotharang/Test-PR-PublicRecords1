import business_header, tools;
EXPORT Files(string pversion = '',boolean pUseOtherEnvironment = false) := MODULE

	//////////////////////////////////////////////////////////////////
	// -- Input File Versions
	//////////////////////////////////////////////////////////////////
	export Input := module
		tools.mac_FilesInput(Filenames(pversion,pUseOtherEnvironment).Input.bugatti_hdr		,cortera.Layout_Header			,In_hdr			,'CSV'	, ,pTerminator := ['\n','\r\n'] ,pSeparator := '|' ,pHeading := 1);
		tools.mac_FilesInput(Filenames(pversion,pUseOtherEnvironment).Input.bugatti_stats	,cortera.Layout_Attributes	,In_stats		,'CSV'	, ,pTerminator := ['\n','\r\n'] ,pSeparator := '|' ,pHeading := 1);
	end;
	
	//////////////////////////////////////////////////////////////////
	// -- Base File Versions
	//////////////////////////////////////////////////////////////////
	export Base := module
		tools.mac_FilesBase	(Filenames(pversion,pUseOtherEnvironment).Base.Header				,cortera.Layout_Header_Out				,Header					);
		tools.mac_FilesBase	(Filenames(pversion,pUseOtherEnvironment).Base.Attributes		,cortera.Layout_Attributes_Out		,Attributes			);
		tools.mac_FilesBase	(Filenames(pversion,pUseOtherEnvironment).Base.Executives		,cortera.Layout_Executives				,Executives			);		
	end;

END;