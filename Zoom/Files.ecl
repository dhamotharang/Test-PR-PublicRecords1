import tools;
export Files(

	 string		pversion = ''
	,boolean	pUseOtherEnvironment = false

) :=
module

	//////////////////////////////////////////////////////////////////
	// -- Input File Versions
	//////////////////////////////////////////////////////////////////
	tools.mac_FilesInput(Filenames(pversion,pUseOtherEnvironment).Input			,layouts.Input.Sprayed		,Input		,'CSV'											,pTerminator := '\n');
	tools.mac_FilesInput(Filenames(pversion,pUseOtherEnvironment).InputXML	,layouts.Input.rawXML			,InputXML	,'CSV',pQuote := '~~~~~@@'	,pTerminator := '</personData>',pSeparator := '~~~~&&',pMaxLength := _Dataset().max_record_size * 40);	
	
	//////////////////////////////////////////////////////////////////
	// -- Base File Versions
	//////////////////////////////////////////////////////////////////
	tools.mac_FilesBase(Filenames(pversion,pUseOtherEnvironment).Base			,layouts.Base				,Base		);
	tools.mac_FilesBase(Filenames(pversion,pUseOtherEnvironment).BaseXML	,layouts.BaseXML		,BaseXML);
	tools.mac_FilesBase(Filenames(pversion,pUseOtherEnvironment).Base			,layouts_OLD.Base		,BaseOLD);

end;