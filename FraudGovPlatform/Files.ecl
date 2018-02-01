import tools, FraudShared, NAC;
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
		export InquiryLogs := dataset(Filenames().Sprayed.InquiryLogs,
											{string75 fn { virtual(logicalfilename)},Layouts.Sprayed.InquiryLogs},
											CSV(separator(['|\t|']),quote(''),terminator('|\n')));	
		export NAC := dataset(Filenames().Sprayed.NAC,
											{string75 fn { virtual(logicalfilename)},NAC.Layouts.MSH},
											FLAT, OPT);												
	end;
	//////////////////////////////////////////////////////////////////
	// -- Input File Versions
	//////////////////////////////////////////////////////////////////
	export Input := module
		tools.mac_FilesInput(Filenames(pversion,pUseProd).Input.IdentityData,Layouts.Input.IdentityData,IdentityData,'CSV',,'~<EOL>~','~|~',,,true);
		tools.mac_FilesInput(Filenames(pversion,pUseProd).Input.ByPassed_IdentityData,Layouts.Input.IdentityData,ByPassed_IdentityData,'CSV',,'~<EOL>~','~|~',,,true);

		tools.mac_FilesInput(Filenames(pversion,pUseProd).Input.KnownFraud,Layouts.Input.KnownFraud,KnownFraud,'CSV',,'~<EOL>~','~|~',,,true);
		tools.mac_FilesInput(Filenames(pversion,pUseProd).Input.ByPassed_KnownFraud,Layouts.Input.KnownFraud,ByPassed_KnownFraud,'CSV',,'~<EOL>~','~|~',,,true);

		tools.mac_FilesInput(Filenames(pversion,pUseProd).Input.InquiryLogs,Layouts.Input.InquiryLogs,InquiryLogs,'CSV',,'~<EOL>~','~|~',,,true);
		tools.mac_FilesInput(Filenames(pversion,pUseProd).Input.ByPassed_InquiryLogs,Layouts.Input.InquiryLogs,ByPassed_InquiryLogs,'CSV',,'~<EOL>~','~|~',,,true);

		tools.mac_FilesInput(Filenames(pversion,pUseProd).Input.NAC,Layouts.Input.NAC,NAC,'CSV',,'~<EOL>~','~|~',,,true);
		// tools.mac_FilesInput(Filenames(pversion,pUseProd).Input.ByPassed_NAC,NAC.Layouts.MSH,ByPassed_NAC,'CSV',,'~<EOL>~','~|~',,,true);
	
	end;
	
	//////////////////////////////////////////////////////////////////
	// -- Base File Versions
	//////////////////////////////////////////////////////////////////
	export Base := module
		tools.mac_FilesBase(Filenames(pversion,pUseProd).Base.IdentityData,Layouts.Base.IdentityData,IdentityData);
		tools.mac_FilesBase(Filenames(pversion,pUseProd).Base.KnownFraud,Layouts.Base.KnownFraud,KnownFraud);
		tools.mac_FilesBase(Filenames(pversion,pUseProd).Base.InquiryLogs,Layouts.Base.InquiryLogs,InquiryLogs);
	end;
end;