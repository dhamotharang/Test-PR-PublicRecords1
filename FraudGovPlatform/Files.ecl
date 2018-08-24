import tools, FraudShared, NAC, Inquiry_AccLogs;
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
		export Deltabase := dataset(Filenames().Sprayed.Deltabase,
											{string75 fn { virtual(logicalfilename)},Layouts.Sprayed.Deltabase},
											CSV(separator(['|\t|']),quote(''),terminator('|\n')));	
		export NAC := dataset(Filenames().Sprayed.NAC,
											{string75 fn { virtual(logicalfilename)},NAC.Layouts.MSH},
											FLAT, OPT);		
		export InquiryLogs := dataset(Filenames().Sprayed.InquiryLogs,
											Inquiry_AccLogs.Layout.Common_ThorAdditions,
											CSV(separator(['~|~']),quote(''),terminator('~<EOL>~')));												
	end;
	//////////////////////////////////////////////////////////////////
	// -- Input File Versions
	//////////////////////////////////////////////////////////////////
	export Input := module
		tools.mac_FilesInput(Filenames(pversion,pUseProd).Input.IdentityData,Layouts.Input.IdentityData,IdentityData,'CSV',,'~<EOL>~','~|~',,,true);
		tools.mac_FilesInput(Filenames(pversion,pUseProd).Input.ByPassed_IdentityData,Layouts.Input.IdentityData,ByPassed_IdentityData,'CSV',,'~<EOL>~','~|~',,,true);

		tools.mac_FilesInput(Filenames(pversion,pUseProd).Input.KnownFraud,Layouts.Input.KnownFraud,KnownFraud,'CSV',,'~<EOL>~','~|~',,,true);
		tools.mac_FilesInput(Filenames(pversion,pUseProd).Input.ByPassed_KnownFraud,Layouts.Input.KnownFraud,ByPassed_KnownFraud,'CSV',,'~<EOL>~','~|~',,,true);
		
		tools.mac_FilesInput(Filenames(pversion,pUseProd).Input.AddressCache_IDDT,Layouts.Base.AddressCache,AddressCache_IDDT,'CSV',,'~<EOL>~','~|~',,,true);
		tools.mac_FilesInput(Filenames(pversion,pUseProd).Input.AddressCache_KNFD,Layouts.Base.AddressCache,AddressCache_KNFD,'CSV',,'~<EOL>~','~|~',,,true);

		
	end;
	
	//////////////////////////////////////////////////////////////////
	// -- Base File Versions
	//////////////////////////////////////////////////////////////////
	export Base := module
		tools.mac_FilesBase(Filenames(pversion,pUseProd).Base.IdentityData,Layouts.Base.IdentityData,IdentityData);
		tools.mac_FilesBase(Filenames(pversion,pUseProd).Base.KnownFraud,Layouts.Base.KnownFraud,KnownFraud);
		tools.mac_FilesBase(Filenames(pversion,pUseProd).Base.AddressCache,Layouts.Base.AddressCache,AddressCache);
		tools.mac_FilesBase(Filenames(pversion,pUseProd).Base.Pii,Layouts.Pii,Pii);
		tools.mac_FilesBase(Filenames(pversion,pUseProd).Base.CIID,Layouts.CIID,CIID);
		tools.mac_FilesBase(Filenames(pversion,pUseProd).Base.Crim,Layouts.Crim,Crim);
		tools.mac_FilesBase(Filenames(pversion,pUseProd).Base.Death,Layouts.Death,Death);
		tools.mac_FilesBase(Filenames(pversion,pUseProd).Base.FraudPoint,Layouts.FraudPoint,FraudPoint);
	end;

	export OutputF := module
		export FraudgovInfoFile	:= dataset(Filenames().OutputF.FraudgovInfoFn,Layouts.OutputF.FraudgovInfoRec,thor,opt);
	end;
	
end;