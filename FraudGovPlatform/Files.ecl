﻿import tools, FraudShared, NAC, Inquiry_AccLogs;
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
		
		// tools.mac_FilesBase(Filenames(pversion,pUseProd).Base.AddressCache,Layouts.Base.kel_customeraddress,kel_customeraddress);
		// tools.mac_FilesBase(Filenames(pversion,pUseProd).Base.AddressCache,Layouts.Base.kel_personstats,kel_personstats);
		// tools.mac_FilesBase(Filenames(pversion,pUseProd).Base.AddressCache,Layouts.Base.kel_personevents,kel_personevents);
		// tools.mac_FilesBase(Filenames(pversion,pUseProd).Base.AddressCache,Layouts.Base.kel_customerstats,kel_customerstats);
		// tools.mac_FilesBase(Filenames(pversion,pUseProd).Base.AddressCache,Layouts.Base.kel_fullgraph,kel_fullgraph);
		// tools.mac_FilesBase(Filenames(pversion,pUseProd).Base.AddressCache,Layouts.Base.kel_entitystats,kel_entitystats);
		// tools.mac_FilesBase(Filenames(pversion,pUseProd).Base.AddressCache,Layouts.Base.kel_person_associations_stats,kel_person_associations_stats);
		// tools.mac_FilesBase(Filenames(pversion,pUseProd).Base.AddressCache,Layouts.Base.kel_person_associations_details,kel_person_associations_details);
		// tools.mac_FilesBase(Filenames(pversion,pUseProd).Base.AddressCache,Layouts.Base.kel_entity_scorebreakdown,kel_entity_scorebreakdown);

	end;


	
end;