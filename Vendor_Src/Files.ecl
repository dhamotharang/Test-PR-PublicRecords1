IMPORT tools, Vendor_Src, ut,data_services;

EXPORT Files(STRING pversion = '', BOOLEAN pUseProd = FALSE) := MODULE

  /* Input File Versions */
	
  EXPORT Bankruptcy_input  		                := DATASET(Filenames(pversion,pUseProd).BankCourt_lInputTemplate, layouts.Bank_Court, 	CSV(SEPARATOR([',']), HEADING(1), TERMINATOR(['\n','\r\n' ]), QUOTE(['\"'])));
	EXPORT Bankruptcy_father                    := DATASET(Filenames(pversion,pUseProd).BankCourt_lInputFatherTemplate, layouts.Bank_Court, 	CSV(SEPARATOR([',']), HEADING(1), TERMINATOR(['\n','\r\n' ]), QUOTE(['\"'])));
	
	EXPORT Lien_input       		                := DATASET(Filenames(pversion,pUseProd).LienCourt_lInputTemplate, layouts.Lien_Court, CSV(SEPARATOR([',']), HEADING(1), TERMINATOR(['\n','\r\n']), QUOTE(['\"'])));
	EXPORT Lien_father                          := DATASET(Filenames(pversion,pUseProd).LienCourt_lInputFatherTemplate, layouts.Lien_Court, CSV(SEPARATOR([',']), HEADING(1), TERMINATOR(['\n','\r\n']), QUOTE(['\"'])));
	
	EXPORT Orbit_input       		                := DATASET(Filenames(pversion,pUseProd).Orbit_lInputTemplate, layouts.Orbit, thor);
	EXPORT Orbit_father                         := DATASET(Filenames(pversion,pUseProd).Orbit_lInputFatherTemplate, layouts.Orbit, thor);
	
	EXPORT CourtLocator_input                   := DATASET(Filenames(pversion,pUseProd).CourtLocator_lInputTemplate, layouts.Court_Locator, CSV(SEPARATOR(['|']), TERMINATOR(['\n','\r\n']), QUOTE(['\"']),HEADING(1)));
	EXPORT CourtLocator_father                  := DATASET(Filenames(pversion,pUseProd).CourtLocator_lInputFatherTemplate, layouts.Court_Locator, CSV(SEPARATOR(['|']), TERMINATOR(['\n','\r\n']), QUOTE(['\"']),HEADING(1)));
	
	EXPORT MasterList_input      		            := DATASET(Filenames(pversion,pUseProd).MasterList_lInputTemplate, layouts.MasterList, CSV(SEPARATOR([',']), TERMINATOR(['\n','\r\n']), QUOTE(['"']),HEADING(1)));
	EXPORT MasterList_history                   := DATASET(Filenames(pversion,pUseProd).MasterList_lInputFatherTemplate, layouts.MasterList, CSV(SEPARATOR([',']), TERMINATOR(['\n','\r\n']), QUOTE(['"']),HEADING(1)));
	
	EXPORT CollegeLocator_input       		      := DATASET(Filenames(pversion,pUseProd).CollegeLocator_lInputTemplate, layouts.College_Locator, CSV(SEPARATOR(['|']), TERMINATOR(['\n','\r\n']), QUOTE(['"']),HEADING(1)));
	EXPORT CollegeLocator_father                := DATASET(Filenames(pversion,pUseProd).CollegeLocator_lInputFatherTemplate, layouts.College_Locator, CSV(SEPARATOR(['|']), TERMINATOR(['\n','\r\n']), QUOTE(['"']),HEADING(1)));
	
  
//Manualy																		
                                                                					
//EXPORT Bankruptcy		 	 := DATASET(data_services.foreign_prod+'thor_data400::in::vendor_src::court_bank_20190204', Layout_VendorSrc.Bank_Court,
																						
// ***** New Files for Crims
shared rMasterSources := RECORD
	string		st;
	string		source;
	string		sourceName;
	string		DataDesc;
	string		frequency;
	string		dateadded;
	string		Address1;
	string		Address2;
	string		City;
	string		State;
	string		ZipCode;
	string		phone;
	string		unk;
END;

shared rCrimSources := RECORD
	string		vendor;
	string		source_file;
	string		fullname;
	string		Source;
	string		Address1;
	string		Address2;
	string		City;
	string		State;
	string		ZipCode;
	string		Phone;
	string		Fax;
END;

shared rCrimOffenses := RECORD
	string		vendor;
	string		source_file;
	string		court_desc;
END;

shared rSO_Offenses := RECORD
	string		StateCode;
	string		sourcename;
END;

shared rSO_Main :=  RECORD
	string		source_file;
END;

	EXPORT dsCrimSources		:= DATASET(Vendor_Src.VendorSrc_SF_List(pVersion).CrimSources, rCrimSources,CSV(SEPARATOR([',']), TERMINATOR(['\n','\r\n']), QUOTE(['\"']),HEADING(1)));
                                                               
	EXPORT Combined_Base		:= DATASET(Vendor_Src.VendorSrc_SF_List(pVersion).Source_List_Base, layouts.Base, FLAT);
	
  /* Base File Versions */
		
  tools.mac_FilesBase(Vendor_src.Filenames(pversion,pUseProd).Base, layouts.Base, base);																
																					
END;