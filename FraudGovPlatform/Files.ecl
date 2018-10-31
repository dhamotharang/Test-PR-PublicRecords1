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
		
		tools.mac_FilesInput(Filenames(pversion,pUseProd).Input.Deltabase,Layouts.Input.Deltabase,Deltabase,'CSV',,'~<EOL>~','~|~',,,true);
		tools.mac_FilesInput(Filenames(pversion,pUseProd).Input.ByPassed_Deltabase,Layouts.Input.Deltabase,ByPassed_Deltabase,'CSV',,'~<EOL>~','~|~',,,true);
		tools.mac_FilesInput(Filenames(pversion,pUseProd).Input.AddressCache_IDDT,Layouts.Base.AddressCache,AddressCache_IDDT,'CSV',,'~<EOL>~','~|~',,,true);
		tools.mac_FilesInput(Filenames(pversion,pUseProd).Input.AddressCache_KNFD,Layouts.Base.AddressCache,AddressCache_KNFD,'CSV',,'~<EOL>~','~|~',,,true);
		tools.mac_FilesInput(Filenames(pversion,pUseProd).Input.AddressCache_Deltabase,Layouts.Base.AddressCache,AddressCache_Deltabase,'CSV',,'~<EOL>~','~|~',,,true);

		tools.mac_FilesInput(Filenames(pversion,pUseProd).Input.DemoData,FraudShared.Layouts.Base.Main,DemoData);
		tools.mac_FilesInput(Filenames(pversion,pUseProd).Input.SourcesToAnonymize,Layouts.Input.SourcesToAnonymize,SourcesToAnonymize);
		
		tools.mac_FilesInput(Filenames(pversion,pUseProd).Input.ConfigRiskLevel,Layouts.Input.ConfigRiskLevel,ConfigRiskLevel,'CSV',,'\r\n',',',true);
		
		tools.mac_FilesInput(Filenames(pversion,pUseProd).Input.MBSInclusionDemoData,FraudShared.Layouts.Input.MbsFdnMasterIDIndTypeInclusion,MBSInclusionDemoData,'CSV',,'|\n','|\t|');
		
		tools.mac_FilesInput(Filenames(pversion,pUseProd).Input.MBSDemoData,FraudShared.Layouts.Input.Mbs,MBSDemoData,'CSV',,'|\n','|\t|');

		

		
	
	end;
	
	//////////////////////////////////////////////////////////////////
	// -- Base File Versions
	//////////////////////////////////////////////////////////////////
	export Base := module
		tools.mac_FilesBase(Filenames(pversion,pUseProd).Base.IdentityData,Layouts.Base.IdentityData,IdentityData);
		tools.mac_FilesBase(Filenames(pversion,pUseProd).Base.KnownFraud,Layouts.Base.KnownFraud,KnownFraud);
		tools.mac_FilesBase(Filenames(pversion,pUseProd).Base.Deltabase,Layouts.Base.Deltabase,Deltabase);
		tools.mac_FilesBase(Filenames(pversion,pUseProd).Base.AddressCache,Layouts.Base.AddressCache,AddressCache);
		tools.mac_FilesBase(Filenames(pversion,pUseProd).Base.Pii,Layouts.Pii,Pii);
		tools.mac_FilesBase(Filenames(pversion,pUseProd).Base.CIID,Layouts.CIID,CIID);
		tools.mac_FilesBase(Filenames(pversion,pUseProd).Base.Crim,Layouts.Crim,Crim);
		tools.mac_FilesBase(Filenames(pversion,pUseProd).Base.Death,Layouts.Death,Death);
		tools.mac_FilesBase(Filenames(pversion,pUseProd).Base.FraudPoint,Layouts.FraudPoint,FraudPoint);
		tools.mac_FilesBase(Filenames(pversion,pUseProd).Base.Main_Orig,FraudShared.Layouts.Base.Main,Main_Orig);
		tools.mac_FilesBase(Filenames(pversion,pUseProd).Base.Main_Anon,FraudShared.Layouts.Base.Main,Main_Anon);
		tools.mac_FilesBase(Filenames(pversion,pUseProd).Base.Pii_Demo,Layouts.Pii,Pii_Demo);
		tools.mac_FilesBase(Filenames(pversion,pUseProd).Base.CIID_Demo,Layouts.CIID,CIID_Demo);
		tools.mac_FilesBase(Filenames(pversion,pUseProd).Base.Crim_Demo,Layouts.Crim,Crim_Demo);
		tools.mac_FilesBase(Filenames(pversion,pUseProd).Base.Death_Demo,Layouts.Death,Death_Demo);
		tools.mac_FilesBase(Filenames(pversion,pUseProd).Base.FraudPoint_Demo,Layouts.FraudPoint,FraudPoint_Demo);
		tools.mac_FilesBase(Filenames(pversion,pUseProd).Base.CIID_Demo_Anon,Layouts.CIID,CIID_Demo_Anon);
		tools.mac_FilesBase(Filenames(pversion,pUseProd).Base.Crim_Demo_Anon,Layouts.Crim,Crim_Demo_Anon,,,,,,true);
		tools.mac_FilesBase(Filenames(pversion,pUseProd).Base.Death_Demo_Anon,Layouts.Death,Death_Demo_Anon);
		tools.mac_FilesBase(Filenames(pversion,pUseProd).Base.CIID_Orig,Layouts.CIID,CIID_Orig,,,,,,true);
		tools.mac_FilesBase(Filenames(pversion,pUseProd).Base.Crim_Orig,Layouts.Crim,Crim_Orig,,,,,,true);
		tools.mac_FilesBase(Filenames(pversion,pUseProd).Base.Death_Orig,Layouts.Death,Death_Orig,,,,,,true);
		tools.mac_FilesBase(Filenames(pversion,pUseProd).Base.FraudPoint_Orig,Layouts.FraudPoint,FraudPoint_Orig,,,,,,true);
		tools.mac_FilesBase(Filenames(pversion,pUseProd).Base.CIID_Anon,Layouts.CIID,CIID_Anon,,,,,,true);
		tools.mac_FilesBase(Filenames(pversion,pUseProd).Base.Crim_Anon,Layouts.Crim,Crim_Anon,,,,,,true);
		tools.mac_FilesBase(Filenames(pversion,pUseProd).Base.Death_Anon,Layouts.Death,Death_Anon,,,,,,true);
	end;

	export OutputF := module
		export FraudgovInfoFile	:= dataset(Filenames().OutputF.FraudgovInfoFn,Layouts.OutputF.FraudgovInfoRec,thor,opt);
	end;
	
end;