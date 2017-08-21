import tools, FraudShared;
export Files(

	 string		pversion = ''
	,boolean	pUseProd = false

) :=
module

	//////////////////////////////////////////////////////////////////
	// -- Sprayed Files
	//////////////////////////////////////////////////////////////////
	export Sprayed := module

		
		export IdentityData := dataset(Filenames().Sprayed.IdentityData,
											{string75 fn { virtual(logicalfilename)},Layouts.Sprayed.IdentityData},
											CSV(separator(['~|~']),quote(''),terminator('~<EOL>~')));
		export KnownFraud := dataset(Filenames().Sprayed.KnownFraud,
											{string75 fn { virtual(logicalfilename)},Layouts.Sprayed.KnownFraud},
											CSV(separator(['~|~']),quote(''),terminator('~<EOL>~')));											
	end;
	//////////////////////////////////////////////////////////////////
	// -- Input File Versions
	//////////////////////////////////////////////////////////////////
	export Input := module
		tools.mac_FilesInput(Filenames(pversion,pUseProd).Input.IdentityData					,Layouts.Input.IdentityData		,IdentityData		, 'CSV'      ,,'~<EOL>~','~|~'	,,,true      );
		tools.mac_FilesInput(Filenames(pversion,pUseProd).Input.KnownFraud						,Layouts.Input.KnownFraud			,KnownFraud			, 'CSV'      ,,'~<EOL>~','~|~'	,,,true      );
		tools.mac_FilesInput(Filenames(pversion,pUseProd).Input.ByPassed_IdentityData	,Layouts.Input.IdentityData		,ByPassed_IdentityData	, 'CSV'      ,,'~<EOL>~','~|~'	,,,true     );
		tools.mac_FilesInput(Filenames(pversion,pUseProd).Input.ByPassed_KnownFraud		,Layouts.Input.KnownFraud			,ByPassed_KnownFraud		, 'CSV'      ,,'~<EOL>~','~|~'	,,,true     );
	end;
	
	//////////////////////////////////////////////////////////////////
	// -- Base File Versions
	//////////////////////////////////////////////////////////////////
	export Base := module
		tools.mac_FilesBase(Filenames(pversion,pUseProd).Base.IdentityData					,Layouts.Base.IdentityData					,IdentityData		);
		tools.mac_FilesBase(Filenames(pversion,pUseProd).Base.KnownFraud						,Layouts.Base.KnownFraud						,KnownFraud		);		
	end;
end;