import tools;

export Build_Base(

	 string															pversion
	,dataset(layouts.Input.Sprayed		)	pUpdateFile			= Files().Input.Using
	,dataset(Layouts.Base							)	pBaseFile				= Files().Base.QA
	,dataset(Layouts.Input.rawXML			)	pUpdateXMLFile	= Files().InputXML.Using
) :=
module

	export create_base 			:= Update_Base(_Filters.Input(pUpdateFile), _Filters.Base(pBaseFile), pversion);
	export create_XML_base	:= Standardize_InputXML.fAll(pUpdateXMLFile, pversion);

	tools.mac_WriteFile(Filenames(pversion).base.new		,create_base			,Build_Base_File		);
	tools.mac_WriteFile(Filenames(pversion).baseXML.new	,create_XML_base	,Build_XML_Base_File);

	export full_build :=
		 sequential(
			 Build_Base_File
			,Promote(pversion).buildfiles.New2Built

		);
		
		export full_XML_build :=
		 sequential(
			 Build_XML_Base_File
			,Promote(pversion).buildfiles.New2Built

		);

	export All :=
	if(tools.fun_IsValidVersion(pversion)
		,sequential(
				 Promote().Inputfiles.Sprayed2Using
				,parallel(full_build,full_XML_Build)		
		)
		,output('No Valid version parameter passed, skipping zoom.build_base atribute')
	);
		
end;