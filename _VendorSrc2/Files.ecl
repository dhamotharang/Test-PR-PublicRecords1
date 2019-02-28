IMPORT tools, _VendorSrc2, ut,data_services;

EXPORT Files(STRING pversion = '', BOOLEAN pUseProd = FALSE) := MODULE

  /* Input File Versions */
	
  EXPORT Bankruptcy_input  		                := DATASET(Filenames(pversion,pUseProd).BankCourt_lInputTemplate, layouts.Bank_Court, 	CSV(SEPARATOR([',']), HEADING(1), TERMINATOR(['\n','\r\n' ]), QUOTE(['\"'])));
	EXPORT Bankruptcy_father                    := DATASET(Filenames(pversion,pUseProd).BankCourt_lInputFatherTemplate, layouts.Bank_Court, 	CSV(SEPARATOR([',']), HEADING(1), TERMINATOR(['\n','\r\n' ]), QUOTE(['\"'])));
	
	EXPORT Lien_input       		                := DATASET(Filenames(pversion,pUseProd).LienCourt_lInputTemplate, layouts.Lien_Court, CSV(SEPARATOR([',']), HEADING(1), TERMINATOR(['\n','\r\n']), QUOTE(['\"'])));
	EXPORT Lien_father                          := DATASET(Filenames(pversion,pUseProd).LienCourt_lInputFatherTemplate, layouts.Lien_Court, CSV(SEPARATOR([',']), HEADING(1), TERMINATOR(['\n','\r\n']), QUOTE(['\"'])));
	
	EXPORT RiskviewFFD_input       		          := DATASET(Filenames(pversion,pUseProd).RiskView_lInputTemplate, layouts.Riskview_FFD, thor);
	EXPORT RiskviewFFD_father                   := DATASET(Filenames(pversion,pUseProd).RiskView_lInputFatherTemplate, layouts.Riskview_FFD, thor);
	
	EXPORT CourtLocations_input                 := DATASET(Filenames(pversion,pUseProd).CourtLocations_lInputTemplate, layouts.Court_Locations, CSV(SEPARATOR(['|']), TERMINATOR(['\n','\r\n']), QUOTE(['\"']),HEADING(1)));
	EXPORT CourtLocations_father                := DATASET(Filenames(pversion,pUseProd).CourtLocations_lInputFatherTemplate, layouts.Court_Locations, CSV(SEPARATOR(['|']), TERMINATOR(['\n','\r\n']), QUOTE(['\"']),HEADING(1)));
	
	EXPORT MasterList_input      		            := DATASET(Filenames(pversion,pUseProd).MasterList_lInputTemplate, layouts.MasterList, CSV(SEPARATOR([',']), TERMINATOR(['\n','\r\n']), QUOTE(['"']),HEADING(1)));
	EXPORT MasterList_history                   := DATASET(Filenames(pversion,pUseProd).MasterList_lInputFatherTemplate, layouts.MasterList, CSV(SEPARATOR([',']), TERMINATOR(['\n','\r\n']), QUOTE(['"']),HEADING(1)));
	
	EXPORT CollegeLocator_input       		      := DATASET(Filenames(pversion,pUseProd).CollegeLocator_lInputTemplate, layouts.MasterList, CSV(SEPARATOR(['|']), TERMINATOR(['\n','\r\n']), QUOTE(['"']),HEADING(1)));
	EXPORT CollegeLocator_father                := DATASET(Filenames(pversion,pUseProd).CollegeLocator_lInputFatherTemplate, layouts.MasterList, CSV(SEPARATOR(['|']), TERMINATOR(['\n','\r\n']), QUOTE(['"']),HEADING(1)));
	
  
//Maualy																		
                                                                					
//EXPORT Bankruptcy		 	 := DATASET(data_services.foreign_prod+'thor_data400::in::vendor_src::court_bank_20190204', Layout_VendorSrc.Bank_Court,
																																												
// This file is no longer being retrieved from Unix via a spray, it is being extracted from Orbit directly
// (see OrbitDataHandling)
//	EXPORT RiskviewFFD										:= DATASET(Misc.VendorSrc_SF_List(pVersion).Update_RiskView, Layout_VendorSrc.Riskview_FFD,
//																							CSV(SEPARATOR([',']), HEADING(1), TERMINATOR(['\r\n']), QUOTE(['\"'])));

																							
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

    
	
	EXPORT dsCrimSources		:= DATASET(_VendorSrc2.VendorSrc_SF_List(pVersion).CrimSources, rCrimSources,
																							CSV(SEPARATOR([',']), TERMINATOR(['\n','\r\n']), QUOTE(['\"']),HEADING(1)));
                                                               
	EXPORT Combined_Base		:= DATASET(_VendorSrc2.VendorSrc_SF_List(pVersion).Source_List_Base, layouts.Base, FLAT);
	
	// EXPORT Market_restrict	:= DATASET([{'!E','YES'},		 {'!W','UNKNOWN'},{'#E','YES'},		 {'#W','YES'}
																									 // ,{'$E','YES'},		 {'%W','YES'},    {'&E','YES'},		 {'.E','YES'}
																									 // ,{'?E','YES'},		 {'@E','YES'},	  {'@W','UNKNOWN'},{'[W','UNKNOWN'}
																									 // ,{'1W','UNKNOWN'},{'1X','YES'},	  {'2W','UNKNOWN'},{'2X','YES'}
																									 // ,{'3W','YES'},		 {'3X','YES'},	  {'4W','YES'},  	 {'4X','YES'}
																									 // ,{'5W','YES'},  	 {'5X','YES'},		{'6W','YES'},		 {'6X','YES'}
																									 // ,{'7W','UNKNOWN'},{'7X','YES'},		{'8W','UNKNOWN'},{'8X','YES'}
																									 // ,{'9W','YES'},		 {'9X','YES'},		{'AA','YES'},		 {'AB','UNKNOWN'}
																									 // ,{'AC','YES'},		 {'AD','YES'},		{'AE','YES'},		 {'AK','UNKNOWN'}
																									 // ,{'AM','UNKNOWN'},{'AR','UNKNOWN'},{'AT','UNKNOWN'},{'AV','YES'}
																									 // ,{'AW','YES'},		 {'AY','UNKNOWN'},{'BA','UNKNOWN'},{'BD','YES'}
																									 // ,{'BE','YES'},		 {'BF','UNKNOWN'},{'BM','UNKNOWN'},{'BN','UNKNOWN'}
																									 // ,{'BR','YES'},		 {'BW','YES'},		{'BY','UNKNOWN'},{'C-','UNKNOWN'}
																									 // ,{'C!','UNKNOWN'},{'C(','UNKNOWN'},{'C)','UNKNOWN'},{'C*','UNKNOWN'}
																									 // ,{'C,','UNKNOWN'},{'C.','UNKNOWN'},{'C/','UNKNOWN'},{'C:','UNKNOWN'}
																									 // ,{'C;','UNKNOWN'},{'C?','UNKNOWN'},{'C@','UNKNOWN'},{'C[','UNKNOWN'}
																									 // ,{'C\\','UNKNOWN'},{'C]','UNKNOWN'},{'C^','UNKNOWN'},{'C_','UNKNOWN'}
																									 // ,{'C{','UNKNOWN'},{'C|','UNKNOWN'},{'C}','UNKNOWN'},{'C~','UNKNOWN'}
																									 // ,{'C+','UNKNOWN'},{'C<','UNKNOWN'},{'C=','UNKNOWN'},{'C>','UNKNOWN'}
																									 // ,{'C0','UNKNOWN'},{'C1','UNKNOWN'},{'C2','UNKNOWN'},{'C3','YES'}
																									 // ,{'C4','YES'},		 {'C4','UNKNOWN'},{'C5','UNKNOWN'},{'C6','UNKNOWN'}
																									 // ,{'C7','YES'},		 {'C8','UNKNOWN'},{'C9','UNKNOWN'},{'CA','UNKNOWN'}
																									 // ,{'CB','UNKNOWN'},{'CD','YES'},		{'CE','YES'},		 {'CF','YES'}
																									 // ,{'CG','UNKNOWN'},{'CH','UNKNOWN'},{'CI','UNKNOWN'},{'CJ','YES'}
																									 // ,{'CK','UNKNOWN'},{'CL','UNKNOWN'},{'CM','UNKNOWN'},{'CN','UNKNOWN'}
																									 // ,{'CP','UNKNOWN'},{'CQ','UNKNOWN'},{'CR','UNKNOWN'},{'CS','YES'}
																									 // ,{'CT','UNKNOWN'},{'CU','UNKNOWN'},{'CV','UNKNOWN'},{'CW','UNKNOWN'}
																									 // ,{'CX','UNKNOWN'},{'CY','YES'},		{'CZ','UNKNOWN'},{'D','UNKNOWN'}
																									 // ,{'D!','UNKNOWN'},{'D#','UNKNOWN'},{'DE','UNKNOWN'},{'D@','UNKNOWN'}
																									 // ,{'D0','UNKNOWN'},{'DE','UNKNOWN'},{'D1','UNKNOWN'},{'DE','UNKNOWN'}
																									 // ,{'D2','UNKNOWN'},{'D2','UNKNOWN'},{'DE','UNKNOWN'},{'D3','UNKNOWN'}
																									 // ,{'D4','UNKNOWN'},{'DE','UNKNOWN'},{'D5','UNKNOWN'},{'DE','UNKNOWN'}
																									 // ,{'D6','UNKNOWN'},{'DE','UNKNOWN'},{'D7','YES'},		 {'D7','UNKNOWN'}
																									 // ,{'D8','UNKNOWN'},{'DE','UNKNOWN'},{'D9','UNKNOWN'},{'DA','UNKNOWN'}
																									 // ,{'DD','YES'},		 {'DE','UNKNOWN'},{'DF','YES'},		 {'DG','YES'}
																									 // ,{'DN','UNKNOWN'},{'DW','YES'},		{'E','UNKNOWN'},{'E1','UNKNOWN'}
																									 // ,{'E2','UNKNOWN'},{'E3','UNKNOWN'},{'E3','YES'},		{'ED','UNKNOWN'}
																									 // ,{'EE','YES'},		 {'EN','YES'},		{'ER','YES'},		{'ET','YES'}
																									 // ,{'ET','UNKNOWN'},{'EV','UNKNOWN'},{'EW','UNKNOWN'},{'FA','YES'}
																									 // ,{'FD','YES'},		 {'FE','UNKNOWN'},{'FE','UNKNOWN'},{'FF','UNKNOWN'}
																									 // ,{'FI','UNKNOWN'},{'FK','UNKNOWN'},{'FN','UNKNOWN'},{'FP','YES'}
																									 // ,{'FR','YES'},		 {'FT','UNKNOWN'},{'FV','YES'},		 {'FW','YES'}
																									 // ,{'GD','YES'},		 {'GE','YES'},		{'GF','UNKNOWN'},{'GO','YES'}
																									 // ,{'GW','UNKNOWN'},{'HF','UNKNOWN'},{'HW','YES'},		 {'I','UNKNOWN'}
																									 // ,{'IA','YES'},		 {'IB','YES'},		{'IB','UNKNOWN'},{'ID','YES'}
																									 // ,{'IE','YES'},		 {'II','YES'},		{'IL','YES'},		 {'IM','UNKNOWN'}
																									 // ,{'IN','UNKNOWN'},{'IT','UNKNOWN'},{'IV','YES'},		 {'IW','UNKNOWN'}
																									 // ,{'JE','YES'},		 {'JI','UNKNOWN'},{'JW','UNKNOWN'},{'KD','YES'}
																									 // ,{'KE','YES'},		 {'KV','YES'},		{'KW','YES'},		 {'L2','UNKNOWN'}
																									 // ,{'LA','UNKNOWN'},{'LB','UNKNOWN'},{'LC','UNKNOWN'},{'LE','YES'}
																									 // ,{'LL','UNKNOWN'},{'LP','UNKNOWN'},{'LV','YES'},		 {'LW','UNKNOWN'}
																									 // ,{'M1','UNKNOWN'},{'MD','UNKNOWN'},{'ME','YES'},		 {'MH','YES'}
																									 // ,{'ML','YES'},		 {'MV','YES'},		{'MW','UNKNOWN'},{'ND','YES'}
																									 // ,{'NE','YES'},		 {'NJ','UNKNOWN'},{'NV','YES'},		 {'NW','UNKNOWN'}
																									 // ,{'OD','YES'},		 {'OE','YES'},		{'OL','UNKNOWN'},{'OM','YES'}
																									 // ,{'OS','UNKNOWN'},{'OV','YES'},		{'OW','UNKNOWN'},{'PD','YES'}
																									 // ,{'PE','YES'},		 {'PI','UNKNOWN'},{'PL','UNKNOWN'},{'PL','YES'}
																									 // ,{'PV','YES'},		 {'PW','YES'},		{'QE','YES'},		 {'QV','YES'}
																									 // ,{'QW','UNKNOWN'},{'QY','UNKNOWN'},{'RB','YES'},		 {'RE','YES'}
																									 // ,{'RV','YES'},		 {'RW','UNKNOWN'},{'SA','YES'},		 {'SD','YES'}
																									 // ,{'SE','YES'},		 {'SG','YES'},		{'SK','YES'},		 {'SK','UNKNOWN'}
																									 // ,{'SL','UNKNOWN'},{'SO','UNKNOWN'},{'SP','YES'},		 {'SV','YES'}
																									 // ,{'SW','YES'},		 {'TD','YES'},		{'TE','YES'},		 {'TL','UNKNOWN'}
																									 // ,{'TR','UNKNOWN'},{'TV','YES'},		{'TW','UNKNOWN'},{'TX','UNKNOWN'}
																									 // ,{'U','UNKNOWN'}, {'U','YES'},			{'U2','UNKNOWN'},{'U2','YES'}
																									 // ,{'UE','YES'},		 {'UF','YES'},		{'UT','YES'},		 {'V','UNKNOWN'}
																									 // ,{'VE','YES'},		 {'VF','UNKNOWN'},{'VO','YES'},		 {'VO','UNKNOWN'}
																									 // ,{'VW','YES'},		 {'W','UNKNOWN'}, {'W@','YES'},		 {'W1','UNKNOWN'}
																									 // ,{'WC','UNKNOWN'},{'WD','YES'},		{'WE','YES'},		 {'WF','UNKNOWN'}
																									 // ,{'WP','YES'},		 {'WT','YES'},		{'WV','YES'},		 {'WW','UNKNOWN'}
																									 // ,{'XE','YES'},		 {'XF','UNKNOWN'},{'XV','UNKNOWN'},{'XW','YES'}
																									 // ,{'XX','YES'},		 {'Y','YES'},			{'YD','YES'},		 {'YE','YES'}
																									 // ,{'YV','YES'},		 {'YW','UNKNOWN'},{'ZE','YES'},		 {'ZF','UNKNOWN'}
																									 // ,{'ZM','UNKNOWN'},{'ZW','UNKNOWN'},{'ZX','YES'},		 {'+E','YES'}
																					// ],{STRING75 SOURCE_CODE,STRING50 MARKETINGRESTRICTED});		
	
	
    /* Base File Versions */
		
     tools.mac_FilesBase(_Vendorsrc2.Filenames(pversion,pUseProd).Base, layouts.Base, base);																
																					


END;