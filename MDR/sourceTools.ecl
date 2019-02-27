import corp2,doxie,codes,_control;
// -- When adding a source code, please do this, PLEASE PLEASE PLEASE, to prevent DUPLICATE 
//    source codes:
// -- 1.  Use MDR.Misc_SourceTools.fGetNewSourceCodes() to find new unused source codes (since
//           there are so many, this should make it easier)
// -- 2.  Once you have chosen one, search for that source code in this attribute, just in case 
//        someone added a source code, but did not add it to the dSource_Codes dataset.  
//        If not found, go on to step 3.
// -- 3.	Add the source code.  This includes(all within this attribute):
//				a. Creating the symbolic value, i.e. src_XXXX  NOTE: as a courtesy to others, 
//           please add any new src_XXXX entries in alphabetic source or source group order.
//				b. Adding it to any sets that are relevant, such as header or business header.
//        c. Creating a set_XXXX for that source. 
//				d. Creating a SourceIsXXXX function to test for that source.
//				e. Adding the source, along with it's description, to the dSource_Codes dataset in this
//           attribute, in alphabetic order.
//				f. Also adding it to the TranslateSource function, in alphabetic order.
// ****** Doing these should ensure that no duplicate source codes are introduced. ********

export sourceTools :=
MODULE
	// -----------------------------------------
	// -- Source Codes
	// -----------------------------------------
	export src_ABMS                      := '0Q';  // American Board of Medical Specialties
	export src_ACA                       := 'AC';  // American Correctional Association	
	export src_Accidents_FL 	           := 'VA';
	export src_Accidents_ECrash          := 'VC'; 
	export src_Accidents_ECrash_CRU      := 'VR'; 
	export src_Accurint_Arrest_Log       := 'AL';
	export src_Accurint_Crim_Court       := 'CC';
	export src_Accurint_DOC              := 'DC';
	export src_Accurint_Sex_offender     := 'AS';
	export src_Accurint_Trade_Show       := 'AT';
	export src_ACF                       := 'CF';  // America's Corporate Financial Directory
	export src_Acquiredweb 							 := 'AW';
	export src_Acquiredweb_plus					 := 'AP';	 // AcquiredWeb Plus - Business names and email addresses
  export src_advo_valassis	           := 'VL';  // US POSTAL SERVICE VIA VALASSIS COMMUNICATIONS, INC. – ADVO file 
	export src_AHA                       := 'AH';  // American Hospital Association for Organization master repositry
	export src_Aircrafts                 := 'AR';  // Aircraft registrations from the FAA
	export src_Airmen                    := 'AM';  // Pilot license info from the FAA
	export src_AK_Busreg                 := 'AB';  // Alaska business registrations
	export src_AK_Fishing_boats          := '^W';  // Alaska commerical fishing vessels permits
	export src_AK_Perm_Fund              := 'AK';  // Alaska permanent fund recipents
	export src_ALC                       := '7O';  // American List Counsel
	export src_AlloyMedia_consumer			 := 'AO';
	export src_AlloyMedia_student_list	 :=	'AY';
	export src_American_Students_List    := 'SL';
	export src_OKC_Students_List         := 'S1';
	export src_AMIDIR                    := 'ML';  // American Medical Info Directory
	export src_AMS                       := 'SJ';  // Advantage Management Solutions
	export src_Anchor										 := 'AN';		// Anchor Computer email data
	export src_Bair_Analytics            := 'B+';  // Bair Analytics agency-reported relational data dump
	export src_Bankruptcy                := 'BA';
	export src_Bankruptcy_Attorney       := 'BY';
	export src_Bankruptcy_Trustee        := 'BT';
	export src_BBB_Member                := 'BM';  // Better Business Bureau members
	export src_BBB_Non_Member            := 'BN';  // Better Business Bureau non-members
	export src_BrightVerify_email				 :=	'BV';		//BrightVerify email deltabase
	export src_Business_Credit					 := 'BC';  // SBFE Business Credit
	export src_Business_Registration     := 'BR';
	export src_Calbus										 := 'C#';  // California business locator/CA sales & use tax permit holders
	export src_Cellphones_kroll					 := '01';
	export src_Cellphones_nextones 			 := '05';
	export src_Cellphones_traffix				 := '02';	
	export src_Certegy                   := 'CY';
	export src_Consumer_Disclosure_feed       := '2R';
	export src_CClue										 := 'FJ';  // Commerical CLUE data for BIP
	export src_FL_CH                     := 'FC';  // CH = Criminal History ---v
	export src_GA_CH                     := 'GC';
	export src_PA_CH                     := 'PC';
	export src_UT_CH                     := 'UC';
	export src_Clarity                   := 'C$';
	export src_CLIA		                   := 'QR';  // Clinical Laboratory Improvement Amendments database
	export src_CNLD_Facilities					 := 'XC';  // Choicepoint National License Database
	export src_CNLD_Practitioner    		 := 'PT';  // Choicepoint National License Database 
	export src_AK_Corporations           := 'C)';  // State level Corporation filing info from Secretary of State or Department of State agencies ----v
	export src_AL_Corporations           := 'C(';
	export src_AR_Corporations           := 'C+';
	export src_AZ_Corporations           := 'C*';
	export src_CA_Corporations           := 'C,';
	export src_CO_Corporations           := 'C-';
	export src_CT_Corporations           := 'C.';
	export src_DC_Corporations           := 'C/';
	export src_FL_Corporations           := 'C0';
	export src_GA_Corporations           := 'C1';
	export src_HI_Corporations           := 'C2';
	export src_IA_Corporations           := 'C6';
	export src_ID_Corporations           := 'C3';
	export src_IL_Corporations           := 'C4';
	export src_IN_Corporations           := 'C5';
	export src_KS_Corporations           := 'C7';
	export src_KY_Corporations           := 'C8';
	export src_LA_Corporations           := 'C9';
	export src_MA_Corporations           := 'C<';
	export src_MD_Corporations           := 'C;';
	export src_ME_Corporations           := 'C:';
	export src_MI_Corporations           := 'C=';
	export src_MN_Corporations           := 'C>';
	export src_MO_Corporations           := 'C@';
	export src_MS_Corporations           := 'C?';
	export src_MT_Corporations           := 'C[';
	export src_NC_Corporations           := 'C|';
	export src_ND_Corporations           := 'C}';
	export src_NE_Corporations           := 'C\\';
	export src_NH_Corporations           := 'C^';
	export src_NJ_Corporations           := 'C_';
	export src_NM_Corporations           := 'C`';
	export src_NV_Corporations           := 'C]';
	export src_NY_Corporations           := 'C{';
	export src_OH_Corporations           := 'C~';
	export src_OK_Corporations           := 'CA';
	export src_OR_Corporations           := 'CB';
	export src_PA_Corporations           := 'CH';
	export src_RI_Corporations           := 'CI';
	export src_SC_Corporations           := 'CJ';
	export src_SD_Corporations           := 'CK';
	export src_TN_Corporations           := 'CM';
	export src_TX_Corporations           := 'CN';
	export src_UT_Corporations           := 'CP';
	export src_VA_Corporations           := 'CR';
	export src_VT_Corporations           := 'CQ';
	export src_WA_Corporations           := 'CS';
	export src_WI_Corporations           := 'CX';
	export src_WV_Corporations           := 'CV';
	export src_WV_Hist_Corporations      := 'C!';
	export src_WY_Corporations           := 'CZ';
	export src_Correctional_Facilities	 := '14';  // Correctional Facilities - Internal
	export src_Cortera                   := 'RR';
	export src_Cortera_Tradeline         := '7K';
	export src_CrashCarrier							 := 'KC';  // aka US DOT "Safer Census" data for BIP
	export src_infutor_narc3             := 'KP';  // infutor_narc3 consumer
	export src_Credit_Unions             := 'CU';
	export src_Datagence								 := 'DG';
	export src_DCA                       := 'DF';  // Directory of Corporate Affiliations; aka LNCA
	export src_DEA                       := 'DA';  // US Drug Enforcement Administration
	export src_Death_Michigan            := 'M4'; // NOT part of Death Master
	export src_Death_Master              := 'DE';
	export src_Death_Restricted					 := 'D$';
	export src_Death_State               := 'DS';
	export src_Death_Tributes						 := 'TR';
	export src_Death_Obituary						 := 'OB';
	export src_Death_CA									 := 'D0';
	export src_Death_CT									 := 'D1';
	export src_Death_FL									 := 'D2';
	export src_Death_GA									 := 'D3';
	export src_Death_KY									 := 'D4';
	export src_Death_MA									 := 'D5';
	export src_Death_ME									 := 'D6';
	export src_Death_MI									 := 'D7';
	export src_Death_MN									 := 'D8';
	export src_Death_MT									 := 'D9';
	export src_Death_NC									 := 'D#';
	export src_Death_NV									 := 'D!';
	export src_Death_OH									 := 'D@';
	export src_Death_VA									 := 'D%';
  export src_Debt_Settlement           := 'DT';
	export src_Diversity_Cert            := 'WB';
	export src_Divorce									 :=	'DV';
	export src_CT_DL                     := 'DD';  // Drivers Licenses ----v
	export src_FL_DL                     := 'FD';
	export src_IA_DL                     := 'JD';
	export src_ID_DL                     := 'ID';
	export src_KY_DL                     := 'KD';
	export src_MA_DL                     := 'PD';
	export src_ME_DL                     := 'AD';
	export src_MI_DL                     := 'CD';
	export src_MN_DL                     := 'ND';
	export src_MO_DL                     := 'MD';
	export src_NC_DL                     := 'QD';
	export src_NE_DL                     := 'HD';
	export src_NM_DL                     := 'ED';
	export src_NV_DL                     := 'BD';
	export src_LA_DL                     := 'GD';	
	export src_OH_DL                     := 'OD';
	export src_OR_DL                     := 'RD';
	export src_TN_DL                     := 'SD';
	export src_TX_DL                     := 'TD';
	export src_UT_DL                     := 'UD';
	export src_WI_DL                     := 'WD';
	export src_WV_DL                     := 'VD';
	export src_WY_DL                     := 'YD';
	export src_CO_Experian_DL            := '1X';
	export src_DE_Experian_DL            := '2X';
	export src_ID_Experian_DL            := '3X';
	export src_IL_Experian_DL            := '4X';
	export src_KY_Experian_DL            := '5X';
	export src_LA_Experian_DL            := '6X';
	export src_MD_Experian_DL            := '7X';
	export src_MS_Experian_DL            := '8X';
	export src_ND_Experian_DL            := '9X';
	export src_NH_Experian_DL            := 'ZX';
	export src_SC_Experian_DL            := 'XX';
	export src_WV_Experian_DL            := 'BX';
	export src_MN_RESTRICTED_DL          := 'G4';
	export src_Experian_DL							 := 'AX';	 // Note: Old Experian, not a header source. It gets translated into header source 1X, 2X, etc. 
	export src_Dummy_Records             := 'DU';  // same as Daily Utility records
	export src_Dummy_Records2            := '8F';  // new dummy source since DU became GLB
	export src_Daily_Utilities           := 'DU';    
	export src_Dunn_Bradstreet           := 'D ';  // aka D&B DMI
	export src_Dunn_Bradstreet_Fein      := 'DN';
	export src_Dunndata_Consumer		      	 := 'A3';  //DF-23679 Dunndata Consumer Masterfile
	export src_Dunn_Data_Email					 := 'DX';	 //EMAIL-103
	export src_EBR                       := 'ER';  // Experian Business Reports	
	export src_Edgar                     := 'E ';  // US Securities and Exchange Commission, "Edgar" system data
	export src_Emdeon                    := '7U';  // Emdeon Healthcare Claims
	export src_EMerge_Boat               := 'EB';
	export src_EMerge_CCW                := 'E3';  // CCW=Concealed Carry Weapon data
	export src_EMerge_CCW_NY             := 'E7';	
	export src_EMerge_Cens               := 'E4';
	export src_EMerge_Fish               := 'E2';
	export src_EMerge_Hunt               := 'E1';
	export src_EMerge_Master             := 'EM';
	export src_Employee_Directories      := 'EY';
	export src_Enclarity								 := '64';
	export src_Entiera 									 := 'ET';	
	export src_Equifax                   := 'EQ';
	export src_Equifax_Business_Data     := 'Z1';
	export src_Equifax_Quick             := 'QH';
	export src_Equifax_Weekly            := 'WH';
	export src_Eq_Employer               := 'QQ';
	export src_Experian_CRDB             := 'Q3';  // Experian Credit Risk Database for BIP
	export src_Experian_Credit_Header    := 'EN';
	export src_Experian_FEIN_Rest        := 'E5';  // Experian FEIN restricted, for BIP
	export src_Experian_FEIN_Unrest      := 'E6';  // Experian FEIN un-restricted, for BIP
	export src_Experian_Phones           := 'EL';
	export src_Fares_Deeds_from_Asrs     := 'FB';
	export src_FBNV2_BusReg						   := 'FH';  // Fictitious Business Names ----v
	export src_FBNV2_CA_Orange_county    := 'GF';
	export src_FBNV2_CA_Santa_Clara      := 'ZF';
	export src_FBNV2_CA_San_Bernadino    := 'BF';
	export src_FBNV2_CA_San_Diego        := 'EF';
	export src_FBNV2_CA_Ventura          := 'VF';
	export src_FBNV2_Experian_Direct     := 'TF';
	export src_FBNV2_FL                  := 'WF';
	export src_FBNV2_Hist_Choicepoint    := 'PF';
	export src_FBNV2_INF                 := 'UF';
	export src_FBNV2_New_York            := 'YF';
	export src_FBNV2_TX_Dallas           := 'XF';
	export src_FBNV2_TX_Harris           := 'HF';
	export src_FCC_Radio_Licenses        := 'FK';  // US Federal Communications Commission
	export src_FCRA_Corrections_record   := 'CO';  // Fair Credit Reporting Act
	export src_FDIC                      := 'FI';  // Federal Deposit Insurance Corporation
	export src_FDIC_SOD                  := 'FZ';  // FDIC Summary of Deposits
	export src_Federal_Explosives        := 'FE';  // US ATF/Alcohol, Tobacco, Firearms & Explosives, explosives data
	export src_Federal_Firearms          := 'FF';  // US ATF/Alcohol, Tobacco, Firearms & Explosives, firearms data
	export src_FL_FBN                    := 'FL';  // Florida fictitious business names
	export src_FL_Non_Profit             := 'FN';  // Florida non-profit businesses
	export src_Foreclosures              := 'FR';
	export src_Foreclosures_Delinquent   := 'NT';  // aka Notice of Default/Delinquency (NOD)
	export src_Frandx										 := 'L0';  // Frandex/franchise data from FRANdata 
	export src_NJ_Gaming_Licenses        := 'NJ';  // New Jersey gaming licenses
	export src_Garnishments	             := 'GR';  // Wage garnishments
	export src_Gong_Business             := 'GB';  // Gong=Electronic Directory Assistance data
	export src_Gong_Government           := 'GG';
	export src_Gong_History              := 'GO';
	export src_Gong_Neustar              := 'GN';
	export src_Gong_phone_append         := 'PH';
	export src_GSA                       := 'H7';  // US General Services Administration
	export src_GSDD                      := 'GX';  // Gold Standard Drug Database
	export src_HMS_PM                    := 'S8';  // Health Management System Provider Master (HMS)
	export src_HXMX											 := 'HX';  // HXMX and Symphony are synonymous - therefore have the same code to avoid a potential duplicate in the future
	export src_Ibehavior								 := 'IB';
	export src_Impulse 									 := 'IM';
	export src_Infogroup                 := 'X3';  // Infogroup - contains Professional License data
	export src_INFOUSA_ABIUS_USABIZ      := 'IA';
	export src_INFOUSA_DEAD_COMPANIES    := 'IC'; // Aka DEADCO
	export src_INFOUSA_IDEXEC            := 'II';
	export src_Infutor_NARB              := 'Z2';
	export src_InfutorCID								 := 'IR';
	export src_InfutorTRK                := 'IF';
	export src_InfutorNarc               := '1F';
	export src_InfutorNare               := '!I';
	export src_Ingenix_Sanctions         := 'IP'; // healthcare related sanctions from Ingenix
	export src_Inhouse_QSent             := 'QT';
  export src_InquiryAcclogs					   := 'IQ';
	export src_Insurance_Certification   := 'IS';
	export src_Intrado						 			 := 'IO';
	export src_IRS_5500                  := 'I ';  // Internal Revenue Service retirement plan info
	export src_IRS_Non_Profit            := 'IN';  // Internal Revenue Service non-profit info, aka IRS 990
	export src_Jigsaw                    := 'JI';
	export src_LaborActions_EBSA				 := 'ES';  // EBSA = Employee Benefits Security Administration
	//export src_LaborActions_MSHA				 := '??';  // MHSA = Mine Safety Health Administration
	export src_LaborActions_WHD 				 := 'WX';  // WHD = Wage & Hour Division
	export src_Lexis_Trans_Union         := 'LT';
	export src_Liens                     := 'LI';
	export src_Liens_and_Judgments       := 'LJ';
	export src_Liens_v2                  := 'L2';
	export src_Liens_v2_CA_Federal       := 'LF';
	export src_Liens_v2_Chicago_Law      := 'LC';
	export src_Liens_v2_Hogan            := 'LH';
	export src_Liens_v2_ILFDLN           := 'LD';
	export src_Liens_v2_MA               := 'LM';
	export src_Liens_v2_NYC              := 'LN';
	export src_Liens_v2_NYFDLN           := 'LY';
	export src_Liens_v2_Service_Abstract := 'LS';
	export src_Liens_v2_Superior_Party   := 'LU';
	export src_Link2Tek									 := 'L9';
	export src_CA_Liquor_Licenses        := 'CL';
	export src_CT_Liquor_Licenses        := 'CT';
	export src_IN_Liquor_Licenses        := 'IL';
	export src_LA_Liquor_Licenses        := 'LL';
	export src_OH_Liquor_Licenses        := 'OL';
	export src_PA_Liquor_Licenses        := 'PI';
	export src_TX_Liquor_Licenses        := 'TL';
	export src_LnPropV2_Fares_Asrs       := 'FA';
	export src_LnPropV2_Fares_Deeds      := 'FP';
	export src_LnPropV2_Lexis_Asrs       := 'LA';
	export src_LnPropV2_Lexis_Deeds_Mtgs := 'LP';
	export src_Lobbyists                 := 'LB';
	export src_Mari_Prof_Lic		 				 :=	'MP'; // Mortgage Assest Research Institute Professional Licenses
	export src_Mari_Public_Sanc					 :=	'MQ'; // Mortgage Assest Research Institute Public sanctions
	export src_Marriage					 				 :=	'MR';
	export src_MartinDale_Hubbell        := 'MH';
	export src_MediaOne									 := 'M1';
	export src_Metronet_Gateway					 := 'MN';
	export src_Miscellaneous             := 'PQ';
	export src_Mixed_DPPA                := 'MA';
	export src_Mixed_Non_DPPA            := 'MI';
	export src_Mixed_Probation           := 'MC';
	export src_Mixed_Utilities           := 'MU';
	export src_MPRD_Individual           := 'QN'; 
	export src_MMCP						           := '61';  // Michigan/Illinois Medicaid Custom Program
	export src_NaturalDisaster_Readiness := 'NR';
	export src_NeustarWireless					 := 'N2';  //Neustar Wireless Phones 
	export src_NCOA                      := 'NC';
	export src_NCPDP                     := 'J2';  // National Council for Prescription Drug Programs
	export src_NPPES                     := 'NP';  // US National Provider & Plan Enumeration System
	export src_OIG                       := 'ZO';  // US Office of Inspector General
	export src_One_Click_Data            := 'OC';
	export src_OSHAIR                    := 'OS';  // US Occupational Safety & Health Administration, incident reports
	export src_OutwardMedia 						 						:= 'OM';
	export src_OKC_Student_List										:= 'O9';  //okc student list	
	export src_OKC_Probate               := 'OP';   //OKC Probate
	export src_PBSA                      := 'QY';  // United States Postal Service
  export src_pcnsr							 			 := 'PN';
	export src_PhoneFraud_OTP						 := 'OT';	 //DF-23525
	export src_Phones_Plus               := 'PP';
	export src_Phones_Accudata_OCN_LNP	 := 'PY';
	export src_Phones_Accudata_CNAM_CNM2 := 'PZ';
	export src_Phones_Disconnect		 		 := 'PX';
	export src_Phones_Gong_History_Disconnect := 'PG';
	export src_Phones_Lerg6							 := 'L6';
	export src_Phones_LIDB				 			 := 'PB';
	export src_PhonesPorted_TCPA				 := 'PJ';  // Landline-to-Cellphone
	export src_PhonesPorted_TCPA_CL			 := 'PM';	 // Cellphone-to-Landline	- DF-23525
	export src_PhonesPorted_iConectiv		 := 'PK';
	export src_PhonesPorted_iConectiv_Rng:= 'PU';
	export src_POS                       := 'PO';  // Provider of Services for Organization master repositry	
	export src_Professional_License      := 'PL';	
	export src_PSS									     := 'P$';	 // Phone Status Service
	export src_QSent_Gateway             := 'QG';
	export src_RealSource																:= 'RS';		//RealSource Inc. Email Addresses
	export src_Redbooks                  := 'RB';  // Redbooks International Advertising & Agency info
	export src_SalesChannel              := 'SC';
	export src_CA_Sales_Tax              := 'FT';  // California sales & use tax permit holders
	export src_IA_Sales_Tax              := 'IT';  // Iowa sales tax 
	export src_SDA                       := 'SA';  // Standard Directory of Advertisers
	export src_SDAA                      := 'AA';  // Standard Directory of Advertising Agencies
	export src_SEC_Broker_Dealer         := 'SB';  // US Securities & Exchange Commission  
  export src_sexoffender               := 'SO';  // Sexoffender	
	export src_Sheila_Greco              := 'SG';
	export src_SKA                       := 'SK';  // contact info for medical related businesses info from a data supplier named SK&A
	export src_FL_SO                     := 'FS';  // State level "Sexual Offenders" data ----v
	export src_GA_SO                     := 'GS';
	export src_MI_SO                     := 'MS';
	export src_PA_SO                     := 'PS';
	export src_UT_SO                     := 'US';
	export src_Spoke                     := 'SP';
//export src_Symphony									 := 'HX'; // HXMX and Symphony are synonymous - therefore have the same code to avoid a potential duplicate in the future
	export src_Targus_Gateway            := 'TG';
	export src_Targus_White_pages        := 'WP';
	export src_Tax_practitioner          := 'TP';
	export src_TCOA_After_Address        := 'TC';
	export src_TCOA_Before_Address       := 'TB';
	export src_Teletrack				         := 'TT';
	export src_Thrive_LT								 := 'TM';
	export src_Thrive_LT_POE_Email  		 := 'MT';
	export src_Thrive_PD								 := 'T$';
	export src_Thrive_PD_POE_Email			 := '$T';
	export src_TransUnion                := 'TU';
	export src_TUCS_Ptrack               := 'TS';  // TUCS=TransUnion Credit Service(?)
	export src_TU_CreditHeader           := 'TN';
	export src_TXBUS                     := 'TX';  // Texas business locator/TX sales & use tax payers
	export src_UCC                       := 'U ';  
	export src_UCCV2                     := 'U2';  // Uniform Commerical Code (Business loans) filings at the state level
	export src_UCCV2_WA_Hist				     := 'UH';
	export src_US_Coastguard             := 'CG';
	export src_Utilities                 := 'UT';
	export src_Util_Work_Phone           := 'UW';
	export src_ZUtilities                := 'ZT';
	export src_ZUtil_Work_Phone          := 'ZK';
	export src_Daily_ZUtilities          := 'ZU';    
	export src_FL_Veh                    := 'FV';  // Vehicles/Motor Vehicle Registrations ----v
	export src_ID_Veh                    := 'IV';
	export src_KY_Veh                    := 'KV';
	export src_MA_Veh                    := '3V';
	export src_ME_Veh                    := 'AV';
	export src_MN_Veh                    := 'NV';
	export src_MO_Veh                    := 'SV';
	export src_MS_Veh                    := 'MV';
	export src_MT_Veh                    := 'LV';
	export src_NC_Veh                    := 'RV';
	export src_ND_Veh                    := 'PV';
	export src_NE_Veh                    := 'EV';
	export src_NM_Veh                    := 'XV';
	export src_NV_Veh                    := 'QV';
	export src_OH_Veh                    := 'OV';
	export src_TX_Veh                    := 'TV';
	export src_UT_Veh                    := 'UV';
	export src_WI_Veh                    := 'WV';
	export src_WY_Veh                    := 'YV';
	export src_AK_Experian_Veh           := 'AE';
	export src_AL_Experian_Veh           := 'BE';
	export src_AR_Experian_Veh           := '71';				//DF-16817
	export src_AZ_Experian_Veh           := '73';				//DF-16817
	export src_CO_Experian_Veh           := 'EE';
	export src_CT_Experian_Veh           := 'CE';
	export src_DC_Experian_Veh           := '&E';
	export src_DE_Experian_Veh           := '$E';
	export src_FL_Experian_Veh           := 'GE';
	export src_GA_Experian_Veh           := 'M ';				//DF-16817
	export src_IA_Experian_Veh           := '74';				//DF-16817
	export src_ID_Experian_Veh           := 'JE';
	export src_IL_Experian_Veh           := 'IE';
	export src_KS_Experian_Veh           := '75';				//DF-16817
	export src_KY_Experian_Veh           := 'KE';
	export src_LA_Experian_Veh           := 'LE';
	export src_MA_Experian_Veh           := 'NE';
	export src_MD_Experian_Veh           := 'ME';
	export src_ME_Experian_Veh           := 'RE';
	export src_MI_Experian_Veh           := 'PE';
	export src_MN_Experian_Veh           := 'VE';
	export src_MO_Experian_Veh           := 'YE';
	export src_MS_Experian_Veh           := 'XE';
	export src_MT_Experian_Veh           := 'ZE';
	export src_NC_Experian_Veh           := '76';				//DF-16817
	export src_ND_Experian_Veh           := '@E';
	export src_NE_Experian_Veh           := 'HE';
	export src_NM_Experian_Veh           := '+E';
	export src_NV_Experian_Veh           := '?E';
	export src_NY_Experian_Veh           := 'QE';
	export src_OH_Experian_Veh           := '!E';
	export src_OK_Experian_Veh           := 'OE';
	export src_OR_Experian_Veh           := '=E';
	export src_RI_Experian_Veh           := '77';				//DF-16817
	export src_SC_Experian_Veh           := 'SE';
	export src_SD_Experian_Veh           := '70';				//DF-16817
	export src_TN_Experian_Veh           := 'TE';
	export src_TX_Experian_Veh           := '.E';
	export src_UT_Experian_Veh           := 'UE';
	export src_VT_Experian_Veh           := '79';				//DF-16817
	export src_WA_Experian_Veh           := 'YH';				//DF-16817
	export src_WI_Experian_Veh           := 'WE';
	export src_WY_Experian_Veh           := '#E';
	export src_Infutor_Veh           		 := '1V';
	export src_Infutor_Motorcycle_Veh    := '2V';
	export src_Vickers                   := 'V ';  // stock market insider trading info from Vickers   
	export src_Voters_v2                 := 'VO';  // Voter Registrations
	export src_AK_Watercraft             := '#W';  // Watercrafts (boats, etc.) registrations ----v
	export src_AL_Watercraft             := 'LW';
	export src_AR_Watercraft             := 'RW';
	export src_AZ_Watercraft             := 'ZW';
	export src_CO_Watercraft             := 'CW';
	export src_CT_Watercraft             := 'EW';
	export src_FL_Watercraft             := 'FW';
	export src_GA_Watercraft             := 'GW';
	export src_IA_Watercraft             := 'IW';
	export src_IL_Watercraft             := 'PW';
	export src_KS_Watercraft             := 'HW';
	export src_KY_Watercraft             := 'KW';
	export src_MA_Watercraft             := 'JW';
	export src_MD_Watercraft             := 'DW';
	export src_ME_Watercraft             := 'QW';
	export src_MI_Watercraft             := 'XW';
	export src_MN_Watercraft             := '1W';
	export src_MO_Watercraft             := 'BW';
	export src_MS_Watercraft             := '2W';
	export src_MT_Watercraft             := '3W';
	export src_NC_Watercraft             := 'NW';
	export src_ND_Watercraft             := '4W';
	export src_NE_Watercraft             := '5W';
	export src_NH_Watercraft             := '6W';
	export src_NM_Watercraft						 := 'W2';
	export src_NV_Watercraft             := '7W';
	export src_NY_Watercraft             := 'YW';
	export src_OH_Watercraft             := 'OW';
	export src_OR_Watercraft             := '8W';
	export src_SC_Watercraft             := 'SW';
	export src_TN_Watercraft             := 'TW';
	export src_TX_Watercraft             := '[W';
	export src_UT_Watercraft             := '9W';
	export src_VA_Watercraft             := 'VW';
	export src_WI_Watercraft             := 'WW';
	export src_WV_Watercraft             := '!W';
	export src_WY_Watercraft             := '@W';
	export src_WA_Watercraft             := '%W';
	export src_FL_Watercraft_LN          := '(W';
	export src_KY_Watercraft_LN          := '$W';
	export src_MO_Watercraft_LN          := ')W';
	export src_Infutor_Watercraft				 := 'W1';
	export src_Whois_domains             := 'W ';
	export src_Wired_Assets_Email 			 := 'W@';
	export src_Wired_Assets_Owned 			 := 'WO';
	export src_Wired_Assets_Royalty			 := 'WR'; 
	export src_Wither_and_Die            := 'WT';
  export src_Workers_Compensation      := 'WK';
	export src_MS_Worker_Comp            := 'MW';  // Mississippi workers compensation info
	export src_OR_Worker_Comp            := 'WC';  // Oregon workers compensation info
	export src_Yellow_Pages              := 'Y ';
	export src_Zumigo_GetLineId  				 := 'ZG';
	export src_ZOOM                      := 'ZM';
	export src_BKFS_Nod                  := 'B7';  //Black Knight Foreclosure Nod info
	export src_BKFS_Reo                  := 'I5';  //Black Knight Foreclosure Deed(Reo) info
	export WH_src                        := 'WH';  // WH=Weekly Equifax Header. Also see src_Equifax_Weekly
	

	// -----------------------------------------
	// -- Sets of Multiple Source Codes
	// -----------------------------------------
	// NOTE: In alphabetic (more or less) set_xxx name/category order.
	// Although, some have to be in a certain order because they reference earlier ones.
	//    i.e. set_GLB uses set_Utility_sources, so set_Utility_sources has to occur before set_GLB

	export set_Accidents                  := [
		 src_Accidents_FL,							src_Accidents_ECrash,						src_Accidents_ECrash_CRU
	];

	export set_Atf                        := [
		 src_Federal_Explosives        ,src_Federal_Firearms          
	];

	export set_BBB                        := [
		 src_BBB_Member                ,src_BBB_Non_Member            
	];

	export set_Bk                         := [
		 src_Bankruptcy                
	];

  // Old/pre-BIP(before June 10, 2014) Business Contacts
	export set_Business_contacts          := [
		 src_Accurint_Trade_Show       ,src_ACF                       ,src_Aircrafts                 ,src_Airmen                    
		,src_AK_Busreg                 ,src_AK_Fishing_boats          ,src_AK_Perm_Fund              ,src_American_Students_List    
		,src_AMIDIR                    ,src_Bankruptcy                ,src_Business_Registration     ,src_Certegy ,src_Diversity_Cert                  
		,src_AK_Corporations           ,src_AL_Corporations           ,src_AR_Corporations           ,src_AZ_Corporations           
		,src_CA_Corporations           ,src_CO_Corporations           ,src_CT_Corporations           ,src_FL_Corporations           
		,src_GA_Corporations           ,src_HI_Corporations           ,src_IA_Corporations           ,src_ID_Corporations           
		,src_IL_Corporations           ,src_IN_Corporations           ,src_KS_Corporations           ,src_KY_Corporations           
		,src_LA_Corporations           ,src_MA_Corporations           ,src_MD_Corporations           ,src_ME_Corporations           
		,src_MI_Corporations           ,src_MN_Corporations           ,src_MS_Corporations           ,src_MT_Corporations           
		,src_NC_Corporations           ,src_ND_Corporations           ,src_NE_Corporations           ,src_NH_Corporations           
		,src_NM_Corporations           ,src_NV_Corporations           ,src_NY_Corporations           ,src_OH_Corporations           
		,src_OK_Corporations           ,src_OR_Corporations           ,src_PA_Corporations           ,src_RI_Corporations           
		,src_SD_Corporations           ,src_TX_Corporations           ,src_UT_Corporations           ,src_VA_Corporations           
		,src_VT_Corporations           ,src_WA_Corporations           ,src_WI_Corporations           ,src_WV_Corporations           
		,src_WY_Corporations           ,src_Credit_Unions             ,src_DCA                       ,src_DEA                       
		,src_Death_Master              ,src_Death_State               ,src_CT_DL                     ,src_FL_DL                     
		,src_ID_DL                     ,src_KY_DL                     ,src_MA_DL                     ,src_ME_DL                     
		,src_MI_DL                     ,src_MN_DL                     ,src_NC_DL                     ,src_NE_DL    
		,src_NM_DL                     ,src_NV_DL                 		,src_LA_DL										 ,src_OH_DL                     
		,src_TN_DL                     ,src_TX_DL                     ,src_WI_DL                     ,src_WV_DL                     
		,src_WY_DL                     ,src_CO_Experian_DL            ,src_DE_Experian_DL            ,src_ID_Experian_DL            
		,src_IL_Experian_DL            ,src_KY_Experian_DL            ,src_LA_Experian_DL            ,src_MD_Experian_DL            
		,src_MS_Experian_DL            ,src_ND_Experian_DL            ,src_NH_Experian_DL            ,src_SC_Experian_DL            
		,src_WV_Experian_DL            ,src_Dummy_Records             ,src_Dunn_Bradstreet           ,src_Dunn_Bradstreet_Fein      
		,src_EBR                       ,src_Edgar                     ,src_EMerge_Boat               ,src_EMerge_CCW                          ,src_EMerge_CCW_NY              
		,src_EMerge_Cens               ,src_EMerge_Fish               ,src_EMerge_Hunt               ,src_EMerge_Master             
		,src_Employee_Directories      ,src_Equifax                   ,src_Eq_Employer               ,src_Fares_Deeds_from_Asrs     
		,src_FBNV2_CA_Orange_county    ,src_FBNV2_CA_Santa_Clara      ,src_FBNV2_CA_San_Bernadino    ,src_FBNV2_CA_San_Diego        
		,src_FBNV2_CA_Ventura          ,src_FBNV2_Experian_Direct     ,src_FBNV2_FL                  ,src_FBNV2_Hist_Choicepoint    
		,src_FBNV2_INF                 ,src_FBNV2_New_York            ,src_FBNV2_TX_Dallas           ,src_FBNV2_TX_Harris           
		,src_FCC_Radio_Licenses        ,src_Federal_Explosives        ,src_Federal_Firearms          ,src_FL_FBN                    
		,src_FL_Non_Profit             ,src_Foreclosures              ,src_NJ_Gaming_Licenses        ,src_Gong_Business             
		,src_Gong_Government           ,src_INFOUSA_ABIUS_USABIZ      ,src_INFOUSA_DEAD_COMPANIES    ,src_INFOUSA_IDEXEC            
		,src_IRS_5500                  ,src_IRS_Non_Profit            /*,src_Jigsaw */    					 ,src_Liens                     
		,src_Liens_v2                  ,src_CA_Liquor_Licenses        ,src_CT_Liquor_Licenses        ,src_IN_Liquor_Licenses        
		,src_LA_Liquor_Licenses        ,src_OH_Liquor_Licenses        ,src_PA_Liquor_Licenses        ,src_TX_Liquor_Licenses        
		,src_LnPropV2_Fares_Asrs       ,src_LnPropV2_Fares_Deeds      ,src_LnPropV2_Lexis_Asrs       ,src_LnPropV2_Lexis_Deeds_Mtgs 
		,src_Lobbyists                 ,src_MartinDale_Hubbell        ,src_Miscellaneous             ,src_Phones_Plus               
		,src_Professional_License      ,src_Redbooks                  ,src_CA_Sales_Tax              ,src_IA_Sales_Tax              
		,src_SDA                       ,src_SDAA                      ,src_SEC_Broker_Dealer         ,src_Sheila_Greco              
		,src_SKA                       ,src_Spoke                     ,src_Targus_White_pages        ,src_Tax_practitioner          
		,src_TUCS_Ptrack               ,src_TXBUS                     ,src_US_Coastguard             ,src_Utilities                 
    ,src_ZUtilities                ,src_ZUtil_Work_Phone
		,src_Util_Work_Phone           ,src_FL_Veh                    ,src_ID_Veh                    ,src_KY_Veh  
		,src_MA_Veh
		,src_ME_Veh                    ,src_MN_Veh                    ,src_MS_Veh                    ,src_MT_Veh                    
		,src_NC_Veh                    ,src_ND_Veh                    ,src_NE_Veh                    ,src_NM_Veh                    
		,src_NV_Veh                    ,src_OH_Veh                    ,src_TX_Veh                    ,src_WI_Veh 
		//DF16817 - add 12 Experian new states - AR,AZ,GA,IA,KS,NC,RI,SC,SD,VT,WA
		,src_WY_Veh                    ,src_AK_Experian_Veh           ,src_AL_Experian_Veh           ,src_AR_Experian_Veh
		,src_AZ_Experian_Veh           ,src_CO_Experian_Veh 				 	,src_CT_Experian_Veh           ,src_DC_Experian_Veh
		,src_DE_Experian_Veh           ,src_FL_Experian_Veh 		 			,src_GA_Experian_Veh					 ,src_IA_Experian_Veh
		,src_ID_Experian_Veh					 ,src_IL_Experian_Veh					  ,src_KS_Experian_Veh			 		 ,src_KY_Experian_Veh
		,src_LA_Experian_Veh					 ,src_MA_Experian_Veh           ,src_MD_Experian_Veh           ,src_ME_Experian_Veh
		,src_MI_Experian_Veh           ,src_MN_Experian_Veh           ,src_MS_Experian_Veh           ,src_MT_Experian_Veh
		,src_NC_Experian_Veh					 ,src_ND_Experian_Veh           ,src_NE_Experian_Veh           ,src_NM_Experian_Veh
		,src_NV_Experian_Veh           ,src_NY_Experian_Veh  		 			,src_OH_Experian_Veh           ,src_OK_Experian_Veh
		,src_RI_Experian_Veh           ,src_SC_Experian_Veh						,src_SD_Experian_Veh   				 ,src_TN_Experian_Veh
		,src_TX_Experian_Veh           ,src_UT_Experian_Veh           ,src_VT_Experian_Veh           ,src_WA_Experian_Veh
		,src_WI_Experian_Veh			  	 ,src_WY_Experian_Veh   
		/*,src_Infutor_Veh           		 ,src_Infutor_Motorcycle_Veh*/
		,src_Vickers                   ,src_Voters_v2                 ,src_AK_Watercraft             ,src_AL_Watercraft             
		,src_AR_Watercraft             ,src_AZ_Watercraft             ,src_CO_Watercraft             ,src_CT_Watercraft             
		,src_FL_Watercraft             ,src_GA_Watercraft             ,src_IA_Watercraft             ,src_IL_Watercraft             
		,src_KS_Watercraft             ,src_KY_Watercraft             ,src_MA_Watercraft             ,src_MD_Watercraft             
		,src_ME_Watercraft             ,src_MI_Watercraft             ,src_MN_Watercraft             ,src_MS_Watercraft             
		,src_MT_Watercraft             ,src_NC_Watercraft             ,src_ND_Watercraft             ,src_NE_Watercraft             
		,src_NH_Watercraft             ,src_NM_Watercraft							,src_NV_Watercraft             ,src_NY_Watercraft             
		,src_OH_Watercraft						 ,src_SC_Watercraft             ,src_TN_Watercraft             ,src_TX_Watercraft             
		,src_UT_Watercraft						 ,src_VA_Watercraft             ,src_WI_Watercraft             ,src_WV_Watercraft             
		,src_WY_Watercraft						 ,src_Whois_domains             ,src_Wither_and_Die            ,src_MS_Worker_Comp            
		,src_OR_Worker_Comp						 ,src_Yellow_Pages              ,src_ZOOM                      ,src_Bankruptcy_Attorney
		,src_WV_Hist_Corporations			 ,src_AlloyMedia_student_list		,src_Death_Tributes							,src_Death_CA	
		,src_Death_CT									 ,src_Death_FL									,src_Death_GA										,src_Death_KY
		,src_Death_MA									 ,src_Death_ME									,src_Death_MI										,src_Death_MN
		,src_Death_MT									 ,src_Death_NC									,src_Death_NV										,src_Death_OH
		,src_Death_VA									 ,src_Death_Restricted					,src_OKC_Probate					
		/*,src_Death_Obituary					,src_Infutor_Watercraft*/
	];

  // Old/pre-BIP(before June 10, 2014) Business Header
	export set_Business_header            := [
		 src_Accurint_Trade_Show       ,src_ACF                       ,src_Aircrafts                 ,src_AK_Busreg                 
		,src_AK_Fishing_boats          ,src_AMIDIR                    ,src_Bankruptcy                ,src_BBB_Member                
		,src_BBB_Non_Member            ,src_Business_Registration     ,src_AK_Corporations           ,src_AL_Corporations           
		,src_AR_Corporations           ,src_AZ_Corporations           ,src_CA_Corporations           ,src_CO_Corporations           
		,src_CT_Corporations           ,src_DC_Corporations           ,src_FL_Corporations           ,src_GA_Corporations           
		,src_HI_Corporations           ,src_IA_Corporations           ,src_ID_Corporations           ,src_IL_Corporations           
		,src_IN_Corporations           ,src_KS_Corporations           ,src_KY_Corporations           ,src_LA_Corporations           
		,src_MA_Corporations           ,src_MD_Corporations           ,src_ME_Corporations           ,src_MI_Corporations           
		,src_MN_Corporations           ,src_MO_Corporations           ,src_MS_Corporations           ,src_MT_Corporations           
		,src_NC_Corporations           ,src_ND_Corporations           ,src_NE_Corporations           ,src_NH_Corporations           
		,src_NJ_Corporations           ,src_NM_Corporations           ,src_NV_Corporations           ,src_NY_Corporations           
		,src_OH_Corporations           ,src_OK_Corporations           ,src_OR_Corporations           ,src_PA_Corporations           
		,src_RI_Corporations           ,src_SC_Corporations           ,src_SD_Corporations           ,src_TN_Corporations           
		,src_TX_Corporations           ,src_UT_Corporations           ,src_VA_Corporations           ,src_VT_Corporations           
		,src_WA_Corporations           ,src_WI_Corporations           ,src_WV_Corporations           ,src_WV_Hist_Corporations           
		,src_WY_Corporations
		,src_Credit_Unions             ,src_DCA                       ,src_DEA                       ,src_Dummy_Records             
		,src_Dunn_Bradstreet           ,src_Dunn_Bradstreet_Fein      ,src_EBR                       ,src_Edgar                     
		,src_Employee_Directories      ,src_FBNV2_CA_Orange_county    ,src_FBNV2_CA_Santa_Clara      ,src_FBNV2_CA_San_Bernadino    
		,src_FBNV2_CA_San_Diego        ,src_FBNV2_CA_Ventura          ,src_FBNV2_Experian_Direct     ,src_FBNV2_FL                  
		,src_FBNV2_Hist_Choicepoint    ,src_FBNV2_INF                 ,src_FBNV2_New_York            ,src_FBNV2_TX_Dallas           
		,src_FBNV2_TX_Harris           ,src_FCC_Radio_Licenses        ,src_FDIC                      ,src_Federal_Explosives        
		,src_Federal_Firearms          ,src_FL_FBN                    ,src_FL_Non_Profit             ,src_NJ_Gaming_Licenses        
		,src_Gong_Business             ,src_Gong_Government           ,src_INFOUSA_ABIUS_USABIZ      ,src_INFOUSA_DEAD_COMPANIES    
		,src_INFOUSA_IDEXEC            ,src_IRS_5500                  ,src_IRS_Non_Profit            //,src_Jigsaw     -  Removed due to expiration of contract with the vendor             
		,src_Liens_and_Judgments       ,src_Liens_v2                  ,src_CA_Liquor_Licenses        ,src_CT_Liquor_Licenses        
		,src_IN_Liquor_Licenses        ,src_LA_Liquor_Licenses        ,src_OH_Liquor_Licenses        ,src_PA_Liquor_Licenses        
		,src_TX_Liquor_Licenses        ,src_LnPropV2_Fares_Asrs       ,src_LnPropV2_Fares_Deeds      ,src_LnPropV2_Lexis_Asrs       
		,src_LnPropV2_Lexis_Deeds_Mtgs ,src_Lobbyists                 ,src_MartinDale_Hubbell        ,src_OSHAIR                    
		,src_Professional_License      ,src_Redbooks                  ,src_CA_Sales_Tax              ,src_IA_Sales_Tax              
		,src_SDA                       ,src_SDAA                      ,src_SEC_Broker_Dealer         ,src_Sheila_Greco              
		,src_SKA                       ,src_Spoke                     ,src_Tax_practitioner          ,src_TXBUS                     
		,src_UCC                       ,src_UCCV2                     ,src_US_Coastguard             ,src_Utilities                 
    ,src_ZUtilities                ,src_UCCV2_WA_Hist
		,src_FL_Veh                    ,src_ID_Veh                    ,src_KY_Veh                    ,src_MA_Veh
		,src_ME_Veh                    
		,src_MN_Veh                    ,src_MS_Veh                    ,src_MT_Veh                    ,src_NC_Veh                    
		,src_ND_Veh                    ,src_NE_Veh                    ,src_NM_Veh                    ,src_NV_Veh                    
		,src_OH_Veh                    ,src_TX_Veh                    ,src_UT_Veh                    ,src_WI_Veh 
		//DF16817 - add 12 Experian new states - AR,AZ,GA,IA,KS,NC,RI,SC,SD,VT,WA
		,src_WY_Veh                    ,src_AK_Experian_Veh           ,src_AL_Experian_Veh           ,src_AR_Experian_Veh
		,src_AZ_Experian_Veh           ,src_CO_Experian_Veh           ,src_CT_Experian_Veh           ,src_DC_Experian_Veh
		,src_DE_Experian_Veh           ,src_FL_Experian_Veh						,src_GA_Experian_Veh           ,src_IA_Experian_Veh
		,src_ID_Experian_Veh           ,src_IL_Experian_Veh           ,src_KS_Experian_Veh           ,src_KY_Experian_Veh
		,src_LA_Experian_Veh           ,src_MA_Experian_Veh           ,src_MD_Experian_Veh           ,src_ME_Experian_Veh
		,src_MI_Experian_Veh           ,src_MN_Experian_Veh           ,src_MS_Experian_Veh           ,src_MT_Experian_Veh
		,src_NC_Experian_Veh           ,src_ND_Experian_Veh 					,src_NE_Experian_Veh           ,src_NM_Experian_Veh
		,src_NV_Experian_Veh           ,src_NY_Experian_Veh           ,src_OH_Experian_Veh           ,src_OK_Experian_Veh
		,src_OR_Experian_Veh           ,src_RI_Experian_Veh           ,src_SC_Experian_Veh           ,src_SD_Experian_Veh
		,src_TN_Experian_Veh           ,src_TX_Experian_Veh           ,src_UT_Experian_Veh					 ,src_VT_Experian_Veh           
		,src_WA_Experian_Veh           ,src_WI_Experian_Veh           ,src_WY_Experian_Veh           
		/*,src_Infutor_Veh           		,src_Infutor_Motorcycle_Veh*/ ,src_Vickers
    ,src_AK_Watercraft             ,src_AL_Watercraft             
		,src_AR_Watercraft             ,src_AZ_Watercraft             ,src_CO_Watercraft             ,src_CT_Watercraft             
		,src_FL_Watercraft             ,src_GA_Watercraft             ,src_IA_Watercraft             ,src_IL_Watercraft             
		,src_KS_Watercraft             ,src_KY_Watercraft             ,src_MA_Watercraft             ,src_MD_Watercraft             
		,src_ME_Watercraft             ,src_MI_Watercraft             ,src_MN_Watercraft             ,src_MS_Watercraft             
		,src_MT_Watercraft             ,src_NC_Watercraft             ,src_ND_Watercraft             ,src_NE_Watercraft             
		,src_NH_Watercraft             ,src_NV_Watercraft             ,src_NY_Watercraft             ,src_OH_Watercraft             
		,src_SC_Watercraft             ,src_TN_Watercraft             ,src_TX_Watercraft             ,src_UT_Watercraft             
		,src_VA_Watercraft             ,src_WI_Watercraft             ,src_WV_Watercraft             ,src_WY_Watercraft             
		,src_Whois_domains             ,src_Wither_and_Die            ,src_MS_Worker_Comp            ,src_OR_Worker_Comp            
		,src_Yellow_Pages              ,src_ZOOM                      ,src_Bankruptcy_Attorney			 ,src_Bankruptcy_Trustee
		,src_WA_Watercraft						 ,src_Workers_Compensation			,src_LaborActions_WHD          ,src_Insurance_Certification
    ,src_Experian_FEIN_Rest				 ,src_Experian_FEIN_Unrest			,src_NM_Watercraft						/*,src_Infutor_Watercraft*/      									
	];

	export set_CorpV2                     := [
		 src_AK_Corporations           ,src_AL_Corporations           ,src_AR_Corporations           ,src_AZ_Corporations           
		,src_CA_Corporations           ,src_CO_Corporations           ,src_CT_Corporations           ,src_DC_Corporations           
		,src_FL_Corporations           ,src_GA_Corporations           ,src_HI_Corporations           ,src_IA_Corporations           
		,src_ID_Corporations           ,src_IL_Corporations           ,src_IN_Corporations           ,src_KS_Corporations           
		,src_KY_Corporations           ,src_LA_Corporations           ,src_MA_Corporations           ,src_MD_Corporations           
		,src_ME_Corporations           ,src_MI_Corporations           ,src_MN_Corporations           ,src_MO_Corporations           
		,src_MS_Corporations           ,src_MT_Corporations           ,src_NC_Corporations           ,src_ND_Corporations           
		,src_NE_Corporations           ,src_NH_Corporations           ,src_NJ_Corporations           ,src_NM_Corporations           
		,src_NV_Corporations           ,src_NY_Corporations           ,src_OH_Corporations           ,src_OK_Corporations           
		,src_OR_Corporations           ,src_PA_Corporations           ,src_RI_Corporations           ,src_SC_Corporations           
		,src_SD_Corporations           ,src_TN_Corporations           ,src_TX_Corporations           ,src_UT_Corporations           
		,src_VA_Corporations           ,src_VT_Corporations           ,src_WA_Corporations           ,src_WI_Corporations           
		,src_WV_Hist_Corporations      ,src_WV_Corporations						,src_WY_Corporations           
	];

	export set_Criminal_History           := [
		 src_FL_CH                     ,src_GA_CH                     ,src_PA_CH                     ,src_UT_CH                     
		
	];

	export set_Daily_Utility_sources        := [
		 src_Daily_ZUtilities          ,src_Daily_Utilities                 
	];

	export set_Utility_sources            := [
		 src_Mixed_Utilities           ,src_Utilities                 ,src_Util_Work_Phone           
    ,src_ZUtilities                ,src_ZUtil_Work_Phone
	] + set_Daily_Utility_sources;
	
	export set_Dea                        := [
		 src_DEA                       
	];

	export set_Death                      := [
		 src_Death_Master	,src_Death_State	,src_Death_Tributes	,src_Death_CA		,src_Death_CT		,src_Death_FL
		 ,src_Death_GA	  ,src_Death_KY			,src_Death_MA				,src_Death_ME		,src_Death_MI		,src_Death_MN
		 ,src_Death_MT	  ,src_Death_NC			,src_Death_NV				,src_Death_OH		,src_Death_VA		,src_Death_Obituary
		 ,src_Death_Restricted, src_OKC_Probate
	];

	export set_Marriage_Divorce           := [
		 src_Divorce	,src_Marriage
	];

	export set_DMV_restricted             := [
		 src_CT_DL ,src_FL_DL ,src_LA_DL ,src_MI_DL ,src_MO_DL ,src_OH_DL ,src_TX_DL ,src_WV_DL ,src_NC_DL , src_SC_Experian_DL
		,src_FL_Veh ,src_MO_Veh ,src_OH_Veh ,src_TX_Veh ,src_SC_Experian_Veh //, src_WV_Veh
	];

	export set_Direct_dl                  := [
		 src_CT_DL                     ,src_FL_DL                     ,src_IA_DL                     ,src_ID_DL                     
		,src_KY_DL                     ,src_MA_DL                     ,src_ME_DL                     ,src_MI_DL                     
		,src_MN_DL                     ,src_MO_DL                     ,src_NC_DL                     ,src_NE_DL    
		,src_NM_DL                     ,src_NV_DL                 		,src_LA_DL										 ,src_OH_DL                     
		,src_OR_DL                     ,src_TN_DL                     ,src_TX_DL                     ,src_UT_DL                     
		,src_WI_DL                     ,src_WV_DL                     ,src_WY_DL                     
	];

	export set_Direct_vehicles            := [
		 src_FL_Veh                    ,src_ID_Veh                    ,src_KY_Veh                    ,src_MA_Veh
		,src_ME_Veh                    ,src_MN_Veh                    ,src_MO_Veh                    ,src_MS_Veh
		,src_MT_Veh                    ,src_NC_Veh                    ,src_ND_Veh                    ,src_NE_Veh
		,src_NM_Veh                    ,src_NV_Veh                    ,src_OH_Veh                    ,src_TX_Veh
		,src_UT_Veh                    ,src_WI_Veh                    ,src_WY_Veh                    
	];

	export set_DL                         := [
		 src_CT_DL                     ,src_FL_DL                     ,src_IA_DL                     ,src_ID_DL                     
		,src_KY_DL                     ,src_MA_DL                     ,src_ME_DL                     ,src_MI_DL                     
		,src_MN_DL                     ,src_MO_DL                     ,src_NC_DL                     ,src_NE_DL   
		,src_NM_DL                     ,src_NV_DL                 		,src_LA_DL									   ,src_OH_DL                     
		,src_OR_DL                     ,src_TN_DL                     ,src_TX_DL                     ,src_UT_DL                     
		,src_WI_DL                     ,src_WV_DL                     ,src_WY_DL                     ,src_CO_Experian_DL            
		,src_DE_Experian_DL            ,src_ID_Experian_DL            ,src_IL_Experian_DL            ,src_KY_Experian_DL            
		,src_LA_Experian_DL            ,src_MD_Experian_DL            ,src_MS_Experian_DL            ,src_ND_Experian_DL            
		,src_NH_Experian_DL            ,src_SC_Experian_DL            ,src_WV_Experian_DL            
	];

	export set_DPPA_Probation_sources     := [
		 
	];

	export set_DPPA_sources               := [
		 src_AK_Fishing_boats          ,src_CT_DL                     ,src_FL_DL                     ,src_IA_DL                     
		,src_ID_DL                     ,src_KY_DL                     ,src_MA_DL                     ,src_ME_DL                     
		,src_MI_DL                     ,src_MN_DL                     ,src_MO_DL                     ,src_NC_DL
		,src_NE_DL                     ,src_NM_DL                     ,src_NV_DL										 ,src_LA_DL
		,src_OH_DL                     ,src_OR_DL                     ,src_TN_DL                     ,src_TX_DL                     
		,src_WI_DL                     ,src_WV_DL                     ,src_WY_DL                     ,src_CO_Experian_DL            
		,src_DE_Experian_DL            ,src_ID_Experian_DL            ,src_IL_Experian_DL            ,src_KY_Experian_DL            
		,src_LA_Experian_DL            ,src_MD_Experian_DL            ,src_MS_Experian_DL            ,src_ND_Experian_DL            
		,src_NH_Experian_DL            ,src_SC_Experian_DL            ,src_WV_Experian_DL            ,src_Mixed_DPPA                
		,src_FL_Veh                    ,src_ID_Veh                    ,src_KY_Veh                    ,src_MA_Veh
		,src_ME_Veh                    
		,src_MN_Veh                    ,src_MO_Veh                    ,src_MS_Veh                    ,src_MT_Veh                    
		,src_NC_Veh                    ,src_ND_Veh                    ,src_NE_Veh                    ,src_NM_Veh                    
		,src_NV_Veh                    ,src_OH_Veh                    ,src_TX_Veh                    ,src_WI_Veh                    
		//DF16817 - add 12 Experian new states - AR,AZ,GA,IA,KS,NC,RI,SC,SD,VT,WA
		,src_WY_Veh                    ,src_AK_Experian_Veh           ,src_AL_Experian_Veh           ,src_AR_Experian_Veh
		,src_AZ_Experian_Veh           ,src_CO_Experian_Veh           ,src_CT_Experian_Veh           ,src_DC_Experian_Veh
		,src_DE_Experian_Veh           ,src_FL_Experian_Veh						,src_GA_Experian_Veh           ,src_IA_Experian_Veh
		,src_ID_Experian_Veh           ,src_IL_Experian_Veh           ,src_KS_Experian_Veh           ,src_KY_Experian_Veh
		,src_LA_Experian_Veh           ,src_MA_Experian_Veh           ,src_MD_Experian_Veh           ,src_ME_Experian_Veh
		,src_MI_Experian_Veh           ,src_MN_Experian_Veh           ,src_MO_Experian_Veh           ,src_MS_Experian_Veh
		,src_MT_Experian_Veh           ,src_NC_Experian_Veh           ,src_ND_Experian_Veh           ,src_NE_Experian_Veh
		,src_NM_Experian_Veh           ,src_NV_Experian_Veh           ,src_NY_Experian_Veh           ,src_OH_Experian_Veh
		,src_OK_Experian_Veh           ,src_OR_Experian_Veh           ,src_RI_Experian_Veh           ,src_SC_Experian_Veh
		,src_SD_Experian_Veh           ,src_TN_Experian_Veh           ,src_TX_Experian_Veh           ,src_UT_Experian_Veh
		,src_VT_Experian_Veh           ,src_WA_Experian_Veh           ,src_WI_Experian_Veh           ,src_WY_Experian_Veh
		,src_AK_Watercraft             ,src_AL_Watercraft             
		,src_AR_Watercraft             ,src_AZ_Watercraft             ,src_CO_Watercraft             ,src_CT_Watercraft             
		,src_FL_Watercraft             ,src_GA_Watercraft             ,src_IA_Watercraft             ,src_IL_Watercraft             
		,src_KS_Watercraft             ,src_KY_Watercraft             ,src_MA_Watercraft             ,src_MD_Watercraft             
		,src_ME_Watercraft             ,src_MI_Watercraft             ,src_MN_Watercraft             ,src_MO_Watercraft             
		,src_MS_Watercraft             ,src_MT_Watercraft             ,src_NC_Watercraft             ,src_ND_Watercraft             
		,src_NE_Watercraft             ,src_NH_Watercraft             ,src_NV_Watercraft             ,src_NY_Watercraft             
		,src_OH_Watercraft             ,src_OR_Watercraft             ,src_SC_Watercraft             ,src_TN_Watercraft             
		,src_TX_Watercraft             ,src_UT_Watercraft             ,src_VA_Watercraft             ,src_WI_Watercraft             
		,src_WV_Watercraft             ,src_WY_Watercraft             ,src_FL_Watercraft_LN          ,src_KY_Watercraft_LN          
		,src_MO_Watercraft_LN          ,src_NM_Watercraft							,src_Accidents_FL
	];

	export set_email	:= [
		src_Acquiredweb								,src_Entiera										, src_Impulse									,src_Wired_Assets_Email, 	 src_MediaOne, 	src_OutwardMedia
		,src_thrive_lt								, src_thrive_pd									,src_Ibehavior               , src_AlloyMedia_consumer,  src_SalesChannel, src_Datagence
		,src_InfutorNare					,src_Anchor													,src_RealSource								,src_Acquiredweb_plus			,src_Dunn_Data_Email];
		
	export set_email_poe	:= [
		src_Acquiredweb								,src_Entiera										, src_Impulse									,src_Wired_Assets_Email, 	 src_MediaOne, 	src_OutwardMedia
		,src_thrive_lt_poe_email								, src_thrive_pd_poe_email									,src_Ibehavior               , src_AlloyMedia_consumer
		,src_InfutorNare			,src_Anchor											,src_RealSource							,src_Acquiredweb_plus					,src_Dunn_Data_Email];
		
	export set_digital_email_cookie_matching := [
		src_Impulse										,src_Wired_Assets_Email					,src_Ibehavior               , src_AlloyMedia_consumer										, src_InfutorNare];		

	export set_email_flat := [
		src_Wired_Assets_Email				,src_Impulse										,src_thrive_lt								, src_thrive_pd		
		,src_Ibehavior								,src_AlloyMedia_consumer	 ,src_InfutorNare	,src_Anchor		,src_RealSource			,src_Dunn_Data_Email];
		
	export set_Emerges                    := [
		 src_EMerge_Boat               ,src_EMerge_CCW                           ,src_EMerge_CCW_NY     ,src_EMerge_Cens               ,src_EMerge_Fish               
		,src_EMerge_Hunt               ,src_EMerge_Master             
	];

	export set_Equifax                    := [
		 src_Equifax                   ,src_Equifax_Quick             ,src_Equifax_Weekly            ,src_Eq_Employer               
		
	];

	export set_Experian_dl                := [
		 src_CO_Experian_DL            ,src_DE_Experian_DL            ,src_ID_Experian_DL            ,src_IL_Experian_DL            
		,src_KY_Experian_DL            ,src_LA_Experian_DL            ,src_MD_Experian_DL            ,src_MS_Experian_DL            
		,src_ND_Experian_DL            ,src_NH_Experian_DL            ,src_SC_Experian_DL            ,src_WV_Experian_DL            
		,src_Experian_DL
	];

	export set_Experian_FEIN                := [
		 src_Experian_FEIN_Rest        ,src_Experian_FEIN_Unrest           
	];

	export set_Experian_vehicles          := [
		//DF16817 - add 12 Experian new states - AR,AZ,GA,IA,KS,NC,RI,SC,SD,VT,WA
		 src_AK_Experian_Veh           ,src_AL_Experian_Veh           ,src_AR_Experian_Veh           ,src_AZ_Experian_Veh
		,src_CO_Experian_Veh           ,src_CT_Experian_Veh           ,src_DC_Experian_Veh           ,src_DE_Experian_Veh
		,src_FL_Experian_Veh           ,src_GA_Experian_Veh           ,src_IA_Experian_Veh           ,src_ID_Experian_Veh           
		,src_IL_Experian_Veh           ,src_KS_Experian_Veh           ,src_KY_Experian_Veh           ,src_LA_Experian_Veh
		,src_MA_Experian_Veh           ,src_MD_Experian_Veh           ,src_ME_Experian_Veh           ,src_MI_Experian_Veh
		,src_MN_Experian_Veh           ,src_MO_Experian_Veh           ,src_MS_Experian_Veh           ,src_MT_Experian_Veh
		,src_NC_Experian_Veh           ,src_ND_Experian_Veh           ,src_NE_Experian_Veh           ,src_NM_Experian_Veh
		,src_NV_Experian_Veh           ,src_NY_Experian_Veh           ,src_OH_Experian_Veh           ,src_OK_Experian_Veh
		,src_OR_Experian_Veh           ,src_RI_Experian_Veh           ,src_SC_Experian_Veh           ,src_SD_Experian_Veh
		,src_TN_Experian_Veh           ,src_TX_Experian_Veh           ,src_UT_Experian_Veh           ,src_VT_Experian_Veh
		,src_WA_Experian_Veh           ,src_WI_Experian_Veh           ,src_WY_Experian_Veh  
	];

	export set_FAA                        := [
		 src_Aircrafts                 ,src_Airmen                    
	];

	export set_Fbnv2                      := [
		 src_FBNV2_CA_Orange_county    ,src_FBNV2_CA_Santa_Clara      ,src_FBNV2_CA_San_Bernadino    ,src_FBNV2_CA_San_Diego        
		,src_FBNV2_CA_Ventura          ,src_FBNV2_Experian_Direct     ,src_FBNV2_FL                  ,src_FBNV2_Hist_Choicepoint    
		,src_FBNV2_INF                 ,src_FBNV2_New_York            ,src_FBNV2_TX_Dallas           ,src_FBNV2_TX_Harris           
		,src_FBNV2_BusReg
	];
	
	export set_FCRA_Probation_sources     := [
		 src_Accurint_Arrest_Log       ,src_Accurint_Crim_Court       ,src_Accurint_DOC              
	];

	export set_FCRA_sources               := [
		 src_Bankruptcy                ,src_Liens                     ,src_MS_Worker_Comp            
	];

	export set_GLB                        := [
		 src_Equifax                   ,src_Experian_Credit_Header    ,src_Equifax_Quick             ,src_TU_CreditHeader
    ,src_Experian_FEIN_Rest
	] + set_Utility_sources;

	export set_AlwaysGLB                        := [
		 src_Experian_Credit_Header, src_Equifax_Quick, src_TU_CreditHeader
	] + set_Utility_sources;
  
	export set_Gong                       := [
		 src_Gong_Business             ,src_Gong_Government           ,src_Gong_History,	src_Gong_Neustar              
	];

  // Person Header
	export set_Header                     := [
		 src_Aircrafts                 ,src_Airmen                    ,src_AK_Fishing_boats          ,src_AK_Perm_Fund              
		,src_American_Students_List    ,src_Bankruptcy                ,src_Certegy                   ,src_DEA           ,src_Consumer_Disclosure_feed            
		,src_Death_Master              ,src_Death_State               ,src_Death_Tributes						 ,src_CT_DL                     
		,src_FL_DL										 ,src_ID_DL                     ,src_KY_DL                     ,src_MA_DL                     
		,src_ME_DL										 ,src_MI_DL                     ,src_MN_DL                     ,src_NC_DL
		,src_NM_DL                 	   ,src_NV_DL										  ,src_LA_DL                  	 ,src_OH_DL                     
		,src_TN_DL                     ,src_TX_DL                     ,src_WI_DL                     ,src_WV_DL                     
		,src_WY_DL                     ,src_CO_Experian_DL            ,src_DE_Experian_DL            ,src_ID_Experian_DL            
		,src_IL_Experian_DL            ,src_KY_Experian_DL            ,src_LA_Experian_DL            ,src_MD_Experian_DL            
		,src_MS_Experian_DL            ,src_ND_Experian_DL            ,src_NH_Experian_DL            ,src_SC_Experian_DL            
		,src_WV_Experian_DL            ,src_Dummy_Records          ,src_EMerge_Boat     ,src_EMerge_CCW    ,src_EMerge_CCW_NY            
		,src_EMerge_Cens               ,src_EMerge_Fish               ,src_EMerge_Hunt               ,src_EMerge_Master             
		,src_Equifax                   ,src_Fares_Deeds_from_Asrs     ,src_Federal_Explosives        ,src_Federal_Firearms          
		,src_Foreclosures              ,src_Liens                     ,src_Liens_v2                  ,src_LnPropV2_Fares_Asrs       
		,src_LnPropV2_Fares_Deeds      ,src_LnPropV2_Lexis_Asrs       ,src_LnPropV2_Lexis_Deeds_Mtgs ,src_Miscellaneous             
		,src_Professional_License      ,src_Targus_White_pages        ,src_TUCS_Ptrack               ,src_US_Coastguard             
		,src_Utilities                 ,src_Util_Work_Phone           ,src_FL_Veh                    ,src_ID_Veh                    
    ,src_ZUtilities                ,src_ZUtil_Work_Phone          ,src_TU_CreditHeader					 ,src_KY_Veh 
		,src_MA_Veh                    ,src_ME_Veh                    ,src_MN_Veh                    ,src_MS_Veh                    
		,src_MT_Veh                    ,src_NC_Veh                    ,src_ND_Veh                    ,src_NE_Veh                    
		,src_NM_Veh                    ,src_NV_Veh                    ,src_OH_Veh                    ,src_TX_Veh 
		//DF16817 - add 12 Experian new states - AR,AZ,GA,IA,KS,NC,RI,SC,SD,VT,WA		
		,src_WI_Veh                    ,src_WY_Veh                    ,src_AK_Experian_Veh           ,src_AL_Experian_Veh           
		,src_AR_Experian_Veh           ,src_AZ_Experian_Veh           ,src_CO_Experian_Veh           ,src_CT_Experian_Veh
		,src_DC_Experian_Veh           ,src_DE_Experian_Veh           ,src_FL_Experian_Veh           ,src_GA_Experian_Veh
		,src_IA_Experian_Veh           ,src_ID_Experian_Veh           ,src_IL_Experian_Veh           ,src_KS_Experian_Veh
		,src_KY_Experian_Veh           ,src_LA_Experian_Veh           ,src_MA_Experian_Veh           ,src_MD_Experian_Veh
		,src_ME_Experian_Veh           ,src_MI_Experian_Veh           ,src_MN_Experian_Veh           ,src_MS_Experian_Veh
		,src_MT_Experian_Veh           ,src_NC_Experian_Veh           ,src_ND_Experian_Veh           ,src_NE_Experian_Veh
		,src_NM_Experian_Veh           ,src_NV_Experian_Veh           ,src_NY_Experian_Veh           ,src_OH_Experian_Veh
		,src_OK_Experian_Veh           ,src_RI_Experian_Veh           ,src_SC_Experian_Veh           ,src_SD_Experian_Veh
		,src_TN_Experian_Veh           ,src_TX_Experian_Veh           ,src_UT_Experian_Veh           ,src_VT_Experian_Veh
		,src_WA_Experian_Veh           ,src_WI_Experian_Veh					  ,src_WY_Experian_Veh
		/*,src_Infutor_Veh 						 ,src_Infutor_Motorcycle_Veh*/ ,src_Voters_v2   
		,src_AK_Watercraft             ,src_AL_Watercraft             
		,src_AR_Watercraft             ,src_AZ_Watercraft             ,src_CO_Watercraft             ,src_CT_Watercraft             
		,src_FL_Watercraft             ,src_GA_Watercraft             ,src_IA_Watercraft             ,src_IL_Watercraft             
		,src_KS_Watercraft             ,src_KY_Watercraft             ,src_MA_Watercraft             ,src_MD_Watercraft             
		,src_ME_Watercraft             ,src_MI_Watercraft             ,src_MN_Watercraft             ,src_MS_Watercraft             
		,src_MT_Watercraft             ,src_NC_Watercraft             ,src_ND_Watercraft             ,src_NE_Watercraft             
		,src_NH_Watercraft             ,src_NV_Watercraft             ,src_NY_Watercraft             ,src_OH_Watercraft             
		,src_SC_Watercraft             ,src_TN_Watercraft             ,src_TX_Watercraft             ,src_UT_Watercraft             
		,src_VA_Watercraft             ,src_WI_Watercraft             ,src_WV_Watercraft             ,src_WY_Watercraft
		,src_WA_Watercraft						 ,src_NM_Watercraft             
		,src_MS_Worker_Comp            ,src_Experian_Credit_Header    ,src_Experian_Phones           ,src_NPPES
		,src_AlloyMedia_student_list	 ,src_Death_CA									,src_Death_CT									 ,src_Death_FL
		,src_Death_GA									 ,src_Death_KY									,src_Death_MA									 ,src_Death_ME
		,src_Death_MI									 ,src_Death_MN									,src_Death_MT									 ,src_Death_NC
		,src_Death_NV									 ,src_Death_OH                  ,src_Death_VA									 ,src_Dummy_Records2
		,src_OKC_Probate
	/*,src_Death_Obituary					 ,src_Infutor_Watercraft*/
	];

  // "Quick" Person Header
	export set_quick_header := [
			src_Bankruptcy,							src_Equifax_Quick,						src_Equifax_Weekly, 						src_Experian_Credit_Header,
			src_TU_CreditHeader,				src_CT_DL,										src_FL_DL,											src_IA_DL,
			src_ID_DL,									src_KY_DL,										src_LA_DL,											src_MA_DL,
			src_ME_DL,									src_MI_DL,										src_MN_DL,											src_MO_DL,
			src_NC_DL,                  
			src_NM_DL,									src_NV_DL,										src_OH_DL,											src_OR_DL,
			src_TN_DL,									src_TX_DL,										src_UT_DL,											src_WI_DL,
			src_WV_DL,									src_WY_DL,										src_CO_Experian_DL,							src_DE_Experian_DL,
			src_ID_Experian_DL,					src_IL_Experian_DL,						src_KY_Experian_DL,							src_LA_Experian_DL,
			src_MD_Experian_DL,					src_MS_Experian_DL,						src_ND_Experian_DL,							src_NH_Experian_DL,
			src_SC_Experian_DL,					src_WV_Experian_DL,						src_LnPropV2_Fares_Asrs,				src_LnPropV2_Fares_Deeds,
			src_LnPropV2_Lexis_Asrs,		src_LnPropV2_Lexis_Deeds_Mtgs,src_Liens_v2,										src_FL_Veh,
			src_ID_Veh,									src_KY_Veh,										src_MA_Veh,											src_ME_Veh,
			src_MN_Veh,
			src_MO_Veh,									src_MS_Veh,										src_MT_Veh,											src_NC_Veh,
			src_ND_Veh,									src_NE_Veh,										src_NM_Veh,											src_NV_Veh,
			src_OH_Veh,									src_TX_Veh,										src_UT_Veh,											src_WI_Veh,
		//DF16817 - add 12 Experian new states - AR,AZ,GA,IA,KS,NC,RI,SC,SD,VT,WA					
			src_WY_Veh,									src_AK_Experian_Veh,					src_AL_Experian_Veh,						src_AR_Experian_Veh,
			src_AZ_Experian_Veh,        src_CO_Experian_Veh,				 	src_CT_Experian_Veh,						src_DC_Experian_Veh,
			src_DE_Experian_Veh,				src_FL_Experian_Veh,					src_GA_Experian_Veh,            src_IA_Experian_Veh,
			src_ID_Experian_Veh,				src_IL_Experian_Veh,					src_KS_Experian_Veh,         		src_KY_Experian_Veh,
			src_LA_Experian_Veh,				src_MA_Experian_Veh,					src_MD_Experian_Veh,						src_ME_Experian_Veh,
			src_MI_Experian_Veh,				src_MN_Experian_Veh,					src_MO_Experian_Veh,						src_MS_Experian_Veh,
			src_MT_Experian_Veh,			  src_NC_Experian_Veh,          src_ND_Experian_Veh,						src_NE_Experian_Veh,
			src_NM_Experian_Veh,				src_NV_Experian_Veh,					src_NY_Experian_Veh,						src_OH_Experian_Veh,
			src_OK_Experian_Veh,				src_OR_Experian_Veh,					src_RI_Experian_Veh,						src_SC_Experian_Veh,
			src_SD_Experian_Veh,        src_TN_Experian_Veh,					src_TX_Experian_Veh,						src_UT_Experian_Veh,
			src_VT_Experian_Veh,				src_WA_Experian_Veh,      		src_WI_Experian_Veh,						src_WY_Experian_Veh
/*,		src_Infutor_Veh,								src_Infutor_Motorcycle_Veh*/
	];

	export set_Infousa                    := [
		 src_INFOUSA_ABIUS_USABIZ      ,src_INFOUSA_DEAD_COMPANIES    ,src_INFOUSA_IDEXEC            
	];

	export set_Liens                      := [
		 src_Liens                     ,src_Liens_v2_CA_Federal       ,src_Liens_v2_Chicago_Law      ,src_Liens_v2_Hogan            
		,src_Liens_v2_ILFDLN           ,src_Liens_v2_MA               ,src_Liens_v2_NYC              ,src_Liens_v2_NYFDLN           
		,src_Liens_v2_Service_Abstract ,src_Liens_v2_Superior_Party   ,src_Liens_v2   
	];

	export set_Liquor_Licenses            := [
		 src_CA_Liquor_Licenses        ,src_CT_Liquor_Licenses        ,src_IN_Liquor_Licenses        ,src_LA_Liquor_Licenses        
		,src_OH_Liquor_Licenses        ,src_PA_Liquor_Licenses        ,src_TX_Liquor_Licenses        
	];

	export set_LNOnly                     := [
		 
	];

	export set_LnPropertyV2               := [
		 src_LnPropV2_Fares_Asrs       ,src_LnPropV2_Fares_Deeds      ,src_LnPropV2_Lexis_Asrs       ,src_LnPropV2_Lexis_Deeds_Mtgs 
		
	];

  //New source code sets for Marketing Attributes
	export set_Marketing_Veh              := [  /* Motor Vehicle Registration sources allowed for Marketing */
		 src_NE_Veh										 ,src_Infutor_Veh								,src_Infutor_Motorcycle_Veh
	];

	export set_Marketing_WC       				:= [  /* Watercraft sources allowed for Marketing */
		 src_AL_Watercraft						 ,src_AR_Watercraft						  ,src_AZ_Watercraft						 ,src_CO_Watercraft 
		,src_CT_Watercraft						 ,src_GA_Watercraft							,src_IA_Watercraft						 ,src_ME_Watercraft
		,src_MA_Watercraft						 ,src_MN_Watercraft							,src_MS_Watercraft						 ,src_NE_Watercraft 
		,src_NY_Watercraft						 ,src_NC_Watercraft							,src_OH_Watercraft						 ,src_TN_Watercraft
		,src_TX_Watercraft						 ,src_WV_Watercraft							,src_WI_Watercraft						 ,src_WY_Watercraft
	];

	export set_Marketing_Corp     				:= [  /* Corporation sources allowed for Marketing */
		 src_AK_Corporations					 ,src_AL_Corporations						,src_AZ_Corporations					 ,src_AR_Corporations 
		,src_CA_Corporations					 ,src_CO_Corporations						,src_CT_Corporations					 ,src_DC_Corporations
		,src_FL_Corporations					 ,src_GA_Corporations						,src_HI_Corporations					 ,src_IA_Corporations 
		,src_IN_Corporations					 ,src_KY_Corporations						,src_LA_Corporations					 ,src_ME_Corporations 
		,src_MD_Corporations					 ,src_MA_Corporations						,src_MI_Corporations					 ,src_MN_Corporations
		,src_MS_Corporations					 ,src_MO_Corporations						,src_MT_Corporations					 ,src_NE_Corporations
		,src_NV_Corporations					 ,src_NJ_Corporations						,src_NC_Corporations					 ,src_NY_Corporations
		,src_ND_Corporations					 ,src_OH_Corporations						,src_OK_Corporations					 ,src_OR_Corporations
		,src_RI_Corporations					 ,src_SD_Corporations						,src_TN_Corporations					 ,src_TX_Corporations
		,src_UT_Corporations					 ,src_VT_Corporations						,src_VA_Corporations					 ,src_WI_Corporations
		,src_WY_Corporations
	];

	export set_Marketing_FBN       				:= [  /* Fictitious Business Name sources allowed for Marketing */
		 src_FBNV2_CA_San_Bernadino 	 ,src_FBNV2_CA_Orange_county		,src_FBNV2_TX_Harris					 ,src_FBNV2_CA_Ventura
		,src_FBNV2_FL 								 ,src_FBNV2_CA_Santa_Clara			,src_FBNV2_New_York						 ,src_FBNV2_CA_San_Diego
	];

	export set_Marketing_Header           := [
		 set_Marketing_Veh             ,src_Aircrafts                 ,src_Airmen						         ,set_Marketing_WC              
		,src_AK_Busreg    						 ,set_Marketing_Corp            ,set_Marketing_FBN             ,src_DEA 
		,src_Death_Master							 ,src_Death_CA									,src_Death_CT  								 ,src_Death_FL
		,src_Death_GA									 ,src_Death_KY									,src_Death_ME									 ,src_Death_NC
		,src_Death_MA									 ,src_Death_MN									,src_Death_OH									 ,src_Death_MT 
		,src_Death_Tributes 					 ,src_Death_NV									,src_Death_Michigan						 ,src_AK_Perm_Fund
		,src_EMerge_Boat     					 ,src_EMerge_CCW    						,src_EMerge_CCW_NY 						 ,src_AlloyMedia_consumer           
		,src_EMerge_Fish               ,src_EMerge_Hunt								,src_Employee_Directories			 ,src_FCC_Radio_Licenses
		,src_Federal_Explosives        ,src_Federal_Firearms  				,src_Accurint_Trade_Show  		 ,src_AMS      
		,src_Foreclosures              ,src_Liens                     ,src_Liens_v2   							 ,src_Bankruptcy_Attorney                      
		,src_LnPropV2_Lexis_Asrs       ,src_LnPropV2_Lexis_Deeds_Mtgs ,src_Bankruptcy  							 ,src_Bankruptcy_Trustee         
		,src_US_Coastguard 						 ,src_Accurint_Arrest_Log 			,src_sexoffender 							 ,src_BBB_Member          
		,src_MS_Worker_Comp            ,src_NPPES										  ,src_BBB_Non_Member
		,src_AlloyMedia_student_list	 ,src_American_Students_List		,src_Dummy_Records2						 ,src_Cellphones_traffix
		,src_CNLD_Practitioner				 ,src_Diversity_Cert						,src_Divorce
		,src_Dunn_Bradstreet_Fein			 ,src_Edgar											,src_FDIC											 ,src_NJ_Gaming_Licenses
		,src_GSA											 ,src_Impulse										,src_InfutorCID								 ,src_InfutorTRK
		,src_InfutorNarc							 ,src_InfutorNare								,src_Ingenix_Sanctions				 ,src_IRS_5500
		,src_IRS_Non_Profit						 ,src_Jigsaw										,src_LaborActions_EBSA				 ,src_LaborActions_WHD
		,set_Liens										 ,set_Liquor_Licenses						,src_Lobbyists								 ,src_Marriage
		,src_MediaOne									 ,src_OSHAIR										,src_PBSA											 ,src_SalesChannel
		,src_CA_Sales_Tax							 ,src_IA_Sales_Tax							,src_TXBUS										 ,src_UCCV2
		,src_UCCV2_WA_Hist						 ,src_Vickers										,src_Workers_Compensation			 ,src_OR_Worker_Comp
		,src_ZOOM
	]; 

export set_Marketing_Restricted := [
  src_Aircrafts,             src_AK_Corporations,        src_AL_Corporations,        src_AL_Watercraft,             src_AR_Corporations,
  src_AR_Watercraft,         src_AZ_Corporations,        src_AZ_Watercraft,          src_BBB_Member,                src_BBB_Non_Member,
  src_Business_Registration, src_CA_Corporations,        src_CA_Sales_Tax,           src_CO_Corporations,           src_CO_Watercraft,
  src_CT_Corporations,       src_CT_Watercraft,          src_DC_Corporations,        src_DEA,                       src_Dunn_Bradstreet_Fein,  
  src_EBR,                   src_FBNV2_CA_Orange_county, src_FBNV2_CA_San_Bernadino, src_FBNV2_CA_Santa_Clara,      src_FBNV2_CA_Ventura,
  src_FBNV2_FL,              src_FBNV2_Hist_Choicepoint, src_FBNV2_INF,              src_FBNV2_New_York,            src_FBNV2_TX_Dallas,
  src_FBNV2_TX_Harris,       src_FDIC,                   src_FL_Corporations,        src_GA_Corporations,           src_GA_Watercraft,
  src_HI_Corporations,       src_IA_Corporations,        src_IA_Watercraft,          src_ID_Corporations,           src_IL_Corporations,      
  src_IL_Watercraft,         src_IN_Corporations,        src_IRS_Non_Profit,         src_KS_Corporations,           src_KY_Corporations,
  src_LA_Corporations,       src_LA_Experian_Veh,        src_Liens_v2,               src_LnPropV2_Lexis_Deeds_Mtgs, src_MA_Corporations,      
  src_MA_Watercraft,         src_MD_Corporations,        src_ME_Corporations,        src_ME_Watercraft,             src_MI_Corporations,
  src_MN_Corporations,       src_MN_Watercraft,          src_MO_Corporations,        src_MS_Corporations,           src_MS_Watercraft,
  src_MT_Corporations,       src_NC_Corporations,        src_NC_Watercraft,          src_ND_Corporations,           src_ND_Veh,
  src_NE_Corporations,       src_NH_Corporations,        src_NJ_Corporations,        src_NV_Corporations,           src_NV_Watercraft,
  src_NY_Corporations,       src_NY_Watercraft,          src_OH_Veh,                 src_OH_Watercraft,             src_OK_Corporations,
  src_OR_Corporations,       src_OR_Watercraft,          src_OSHAIR,                 src_PA_Corporations,           src_RI_Corporations,
  src_SD_Corporations,       src_TN_Corporations,        src_TN_Watercraft,          src_TX_Corporations,           src_TX_Watercraft,
  src_TXBUS,                 src_UCC,                    src_UCCV2,                  src_US_Coastguard,             src_UT_Corporations,
  src_VA_Corporations,       src_VT_Corporations,        src_WI_Corporations,        src_WI_Watercraft,             src_WV_Corporations,
  src_WV_Watercraft,         src_WY_Corporations,        src_WY_Watercraft,           src_Bankruptcy,               src_Experian_CRDB,
	 src_Business_Credit,       src_DCA,                    src_Dunn_Bradstreet,        src_IRS_5500
 ];
  

	export set_NonDerog_FCRA_sources := [
		src_Aircrafts              			,src_Airmen                 	,src_AK_Fishing_boats          ,src_AK_Perm_Fund                 	,
		src_American_Students_List      ,src_DEA                 			,src_Death_Master              ,src_Death_State                  	,src_Death_Restricted							,
		src_EMerge_Boat                 ,src_EMerge_CCW               ,src_EMerge_Cens               ,src_EMerge_Fish                  	,
		src_EMerge_Hunt                 ,src_EMerge_Master            ,src_Equifax                   ,src_Equifax_Quick									,
		src_Equifax_Weekly							,src_FCRA_Corrections_record	,src_Federal_Explosives        ,src_Federal_Firearms         			,
		src_Gong_History,src_Gong_Neustar							,src_LnPropV2_Lexis_Asrs      ,src_LnPropV2_Lexis_Deeds_Mtgs ,
		src_MS_Worker_Comp              ,src_Professional_License     ,src_Targus_White_pages        ,src_TUCS_Ptrack                  	,	// white pages and Tucs are included here, but will be removed from fcra header key
		src_US_Coastguard               ,src_Voters_v2                ,src_AK_Watercraft             ,src_AL_Watercraft                 ,src_AR_Watercraft                 ,
		src_AZ_Watercraft               ,src_CO_Watercraft            ,src_CT_Watercraft             ,src_FL_Watercraft                 ,src_GA_Watercraft                 ,
		src_IA_Watercraft               ,src_IL_Watercraft            ,src_KS_Watercraft             ,src_KY_Watercraft                 ,src_MA_Watercraft                 ,
		src_MD_Watercraft               ,src_ME_Watercraft            ,src_MI_Watercraft             ,src_MN_Watercraft                 ,src_MO_Watercraft                 ,
		src_MS_Watercraft               ,src_MT_Watercraft            ,src_NC_Watercraft             ,src_ND_Watercraft                 ,src_NE_Watercraft                 ,
		src_NH_Watercraft               ,src_NV_Watercraft            ,src_NY_Watercraft             ,src_OH_Watercraft                 ,src_OR_Watercraft                 ,
		src_SC_Watercraft               ,src_TN_Watercraft            ,src_TX_Watercraft             ,src_UT_Watercraft                 ,src_VA_Watercraft                 ,
		src_WI_Watercraft               ,src_WV_Watercraft            ,src_WY_Watercraft						 ,src_NM_Watercraft									,src_AlloyMedia_student_list       ,
		src_Experian_Credit_Header				 /*,
		src_Death_Tributes							,src_Death_CA									,src_Death_CT									 ,src_Death_FL											,src_Death_GA											 ,
		src_Death_KY										,src_Death_MA									,src_Death_ME									 ,src_Death_MI											,src_Death_MN											 ,
		src_Death_MT										,src_Death_NC									,src_Death_NV									 ,src_Death_OH											,src_Death_VA											 ,
		src_Death_Obituary							,src_Infutor_Watercraft*/ //Not cleared by modeling for use in FCRA				
	];

// in version 5.0, remove gong, targus white pages, death, emerge_master, emerge_cens, src_FCRA_Corrections_record, and workers comp
export set_NonDerog_FCRA_sources_v50 := [
		src_Aircrafts              			,src_Airmen                 	,src_AK_Fishing_boats								,src_AK_Perm_Fund                 	,
		src_American_Students_List      ,src_DEA                 			,src_Death_Master										,src_Death_State                  	,src_Death_Restricted				,
		src_EMerge_Boat                 ,src_EMerge_CCW                 ,src_EMerge_Fish                  	,
		src_EMerge_Hunt                 ,src_Equifax                   ,src_Equifax_Quick									,
		src_Equifax_Weekly							,src_Federal_Explosives        ,src_Federal_Firearms         			,
		src_Gong_History,src_Gong_Neustar								,src_LnPropV2_Lexis_Asrs      ,src_LnPropV2_Lexis_Deeds_Mtgs ,
    src_Professional_License     ,
		src_US_Coastguard               ,src_Voters_v2                ,src_AK_Watercraft             ,src_AL_Watercraft                 ,src_AR_Watercraft                 ,
		src_AZ_Watercraft               ,src_CO_Watercraft            ,src_CT_Watercraft             ,src_FL_Watercraft                 ,src_GA_Watercraft                 ,
		src_IA_Watercraft               ,src_IL_Watercraft            ,src_KS_Watercraft             ,src_KY_Watercraft                 ,src_MA_Watercraft                 ,
		src_MD_Watercraft               ,src_ME_Watercraft            ,src_MI_Watercraft             ,src_MN_Watercraft                 ,src_MO_Watercraft                 ,
		src_MS_Watercraft               ,src_MT_Watercraft            ,src_NC_Watercraft             ,src_ND_Watercraft                 ,src_NE_Watercraft                 ,
		src_NH_Watercraft               ,src_NV_Watercraft            ,src_NY_Watercraft             ,src_OH_Watercraft                 ,src_OR_Watercraft                 ,
		src_SC_Watercraft               ,src_TN_Watercraft            ,src_TX_Watercraft             ,src_UT_Watercraft                 ,src_VA_Watercraft                 ,
		src_WI_Watercraft               ,src_WV_Watercraft            ,src_WY_Watercraft						 ,src_NM_Watercraft									,src_AlloyMedia_student_list       ,
		src_Experian_Credit_Header
	];

	export set_NoMix                      := [
		 src_Accurint_Arrest_Log       ,src_Accurint_Crim_Court       ,src_Accurint_DOC              
	];

	export set_NonDPPA_sources            := [
		 src_Aircrafts                 ,src_Airmen                    ,src_AK_Perm_Fund              ,src_American_Students_List    
		,src_Certegy                   ,src_DEA                       ,src_Death_Master              ,src_Death_State               ,src_Consumer_Disclosure_feed
		,src_Dummy_Records             ,src_EMerge_Boat               ,src_EMerge_CCW 	,src_EMerge_CCW_NY                ,src_EMerge_Cens               
		,src_EMerge_Fish               ,src_EMerge_Hunt               ,src_EMerge_Master             ,src_Equifax                   
		,src_Equifax_Quick             ,src_Equifax_Weekly            ,src_Experian_Credit_Header    ,src_Fares_Deeds_from_Asrs     
		,src_Federal_Explosives        ,src_Federal_Firearms          ,src_Foreclosures              ,src_Foreclosures_Delinquent   
		,src_Gong_History,src_Gong_Neustar              ,src_Gong_phone_append         ,src_Lexis_Trans_Union         ,src_Liens_v2                  
		,src_LnPropV2_Fares_Asrs       ,src_LnPropV2_Fares_Deeds      ,src_LnPropV2_Lexis_Asrs       ,src_LnPropV2_Lexis_Deeds_Mtgs 
		,src_Miscellaneous             ,src_Mixed_Non_DPPA            ,src_NCOA                      ,src_Professional_License      
		,src_Targus_White_pages        ,src_TCOA_After_Address        ,src_TCOA_Before_Address       ,src_TransUnion                
		,src_TUCS_Ptrack               ,src_US_Coastguard             ,src_Voters_v2                 ,src_Experian_Phones 
		,src_infutorTRK                ,src_NPPES                     ,src_TU_CreditHeader           ,src_pcnsr
		,src_AlloyMedia_student_list   ,src_PSS												,src_Death_Tributes						 ,src_Death_CA
		,src_Death_CT									 ,src_Death_FL									,src_Death_GA									 ,src_Death_KY
		,src_Death_MA									 ,src_Death_ME									,src_Death_MI									 ,src_Death_MN
		,src_Death_MT									 ,src_Death_NC									,src_Death_NV									 ,src_Death_OH
		,src_Death_VA									 ,src_OKC_Probate 							,src_Dummy_Records2						 ,src_Infutor_Watercraft				 
		,src_InfutorNarc               ,src_Infutor_Veh							  ,src_Infutor_Motorcycle_Veh		 ,src_Death_Obituary						 
		,src_Death_Restricted
	];

	export set_NonUpdatingSrc             := [
		 src_Accurint_Trade_Show       ,src_AMIDIR                    ,src_Credit_Unions             ,src_Edgar                     
		,src_Employee_Directories      ,src_Eq_Employer               ,src_FL_Non_Profit             ,src_INFOUSA_ABIUS_USABIZ      
		,src_INFOUSA_DEAD_COMPANIES    ,src_INFOUSA_IDEXEC            ,src_Liens_and_Judgments       ,src_Lobbyists                 
		,src_Tax_practitioner          ,src_UCC                       ,src_UCCV2_WA_Hist						 
		//DF16817 - add 12 Experian new states - AR,AZ,GA,IA,KS,NC,RI,SC,SD,VT,WA							
		,src_AK_Experian_Veh					 ,src_AL_Experian_Veh 					,src_AR_Experian_Veh           ,src_AZ_Experian_Veh                     
		,src_CO_Experian_Veh           ,src_CT_Experian_Veh           ,src_DC_Experian_Veh           ,src_DE_Experian_Veh           
		,src_FL_Experian_Veh           ,src_GA_Experian_Veh           ,src_IA_Experian_Veh           ,src_ID_Experian_Veh
		,src_IL_Experian_Veh           ,src_KS_Experian_Veh           ,src_KY_Experian_Veh           ,src_LA_Experian_Veh
		,src_MA_Experian_Veh           ,src_MD_Experian_Veh           ,src_ME_Experian_Veh           ,src_MI_Experian_Veh
		,src_MN_Experian_Veh           ,src_MO_Experian_Veh           ,src_MS_Experian_Veh           ,src_MT_Experian_Veh
		,src_NC_Experian_Veh           ,src_ND_Experian_Veh           ,src_NE_Experian_Veh           ,src_NM_Experian_Veh
		,src_NV_Experian_Veh           ,src_NY_Experian_Veh           ,src_OH_Experian_Veh           ,src_OK_Experian_Veh           
		,src_OR_Experian_Veh           ,src_RI_Experian_Veh           ,src_SC_Experian_Veh           ,src_SD_Experian_Veh
		,src_TN_Experian_Veh           ,src_TX_Experian_Veh           ,src_UT_Experian_Veh           ,src_VT_Experian_Veh
		,src_WA_Experian_Veh           ,src_WI_Experian_Veh           ,src_WY_Experian_Veh
		,src_Whois_domains             
		,src_Wither_and_Die            
	];

	export set_Paw                        := [
		 src_Accurint_Trade_Show       ,src_ACF                       ,src_Aircrafts                 ,src_Airmen                    
		,src_AK_Busreg                 ,src_AK_Fishing_boats          ,src_AK_Perm_Fund              ,src_American_Students_List    
		,src_AMIDIR                    ,src_Bankruptcy                ,src_Business_Registration     ,src_Certegy                   
		,src_AK_Corporations           ,src_AL_Corporations           ,src_AR_Corporations           ,src_AZ_Corporations           
		,src_CA_Corporations           ,src_CO_Corporations           ,src_CT_Corporations           ,src_FL_Corporations           
		,src_GA_Corporations           ,src_HI_Corporations           ,src_IA_Corporations           ,src_ID_Corporations           
		,src_IL_Corporations           ,src_IN_Corporations           ,src_KS_Corporations           ,src_KY_Corporations           
		,src_LA_Corporations           ,src_MA_Corporations           ,src_MD_Corporations           ,src_ME_Corporations           
		,src_MI_Corporations           ,src_MN_Corporations           ,src_MS_Corporations           ,src_MT_Corporations           
		,src_NC_Corporations           ,src_ND_Corporations           ,src_NE_Corporations           ,src_NH_Corporations           
		,src_NM_Corporations           ,src_NV_Corporations           ,src_NY_Corporations           ,src_OH_Corporations           
		,src_OK_Corporations           ,src_OR_Corporations           ,src_PA_Corporations           ,src_RI_Corporations           
		,src_SD_Corporations           ,src_TX_Corporations           ,src_UT_Corporations           ,src_VA_Corporations           
		,src_VT_Corporations           ,src_WA_Corporations           ,src_WI_Corporations           ,src_WV_Corporations           
		,src_WY_Corporations           ,src_Credit_Unions             ,src_DCA                       ,src_DEA                       
		,src_Death_Master              ,src_Death_State               ,src_CT_DL                     ,src_FL_DL                     
		,src_ID_DL                     ,src_KY_DL                     ,src_MA_DL                     ,src_ME_DL                     
		,src_MI_DL                     ,src_MN_DL                     ,src_NC_DL                      
		,src_NM_DL                     ,src_NV_DL                 		,src_LA_DL										 ,src_OH_DL                     
		,src_TN_DL                     ,src_TX_DL                     ,src_WI_DL                     ,src_WV_DL                     
		,src_WY_DL                     ,src_CO_Experian_DL            ,src_DE_Experian_DL            ,src_ID_Experian_DL            
		,src_IL_Experian_DL            ,src_KY_Experian_DL            ,src_LA_Experian_DL            ,src_MD_Experian_DL            
		,src_MS_Experian_DL            ,src_ND_Experian_DL            ,src_NH_Experian_DL            ,src_SC_Experian_DL            
		,src_WV_Experian_DL            ,src_Dummy_Records             ,src_Dunn_Bradstreet           ,src_Dunn_Bradstreet_Fein      
		,src_Edgar                     ,src_EMerge_Boat               ,src_EMerge_CCW           ,src_EMerge_CCW_NY      ,src_EMerge_Cens               
		,src_EMerge_Fish               ,src_EMerge_Hunt               ,src_EMerge_Master             ,src_Employee_Directories      
		,src_Equifax                   ,src_Eq_Employer               ,src_Fares_Deeds_from_Asrs     ,src_FBNV2_CA_Orange_county    
		,src_FBNV2_CA_Santa_Clara      ,src_FBNV2_CA_San_Bernadino    ,src_FBNV2_CA_San_Diego        ,src_FBNV2_CA_Ventura          
		,src_FBNV2_Experian_Direct     ,src_FBNV2_FL                  ,src_FBNV2_Hist_Choicepoint    ,src_FBNV2_INF                 
		,src_FBNV2_New_York            ,src_FBNV2_TX_Dallas           ,src_FBNV2_TX_Harris           ,src_FCC_Radio_Licenses        
		,src_Federal_Explosives        ,src_Federal_Firearms          ,src_FL_FBN                    ,src_FL_Non_Profit             
		,src_Foreclosures              ,src_NJ_Gaming_Licenses        ,src_Gong_Business             ,src_Gong_Government           
		,src_INFOUSA_ABIUS_USABIZ      ,src_INFOUSA_DEAD_COMPANIES    ,src_INFOUSA_IDEXEC            ,src_IRS_5500                  
		,src_IRS_Non_Profit            /*,src_Jigsaw  */              ,src_Liens                     ,src_Liens_v2                  
		,src_CA_Liquor_Licenses        ,src_CT_Liquor_Licenses        ,src_IN_Liquor_Licenses        ,src_LA_Liquor_Licenses        
		,src_OH_Liquor_Licenses        ,src_PA_Liquor_Licenses        ,src_TX_Liquor_Licenses        ,src_LnPropV2_Fares_Asrs       
		,src_LnPropV2_Fares_Deeds      ,src_LnPropV2_Lexis_Asrs       ,src_LnPropV2_Lexis_Deeds_Mtgs ,src_Lobbyists                 
		,src_MartinDale_Hubbell        ,src_Miscellaneous             ,src_Phones_Plus               ,src_Professional_License      
		,src_Redbooks                  ,src_CA_Sales_Tax              ,src_IA_Sales_Tax              ,src_SDA                       
		,src_SDAA                      ,src_SEC_Broker_Dealer         ,src_Sheila_Greco              ,src_SKA                       
		,src_Spoke                     ,src_Targus_White_pages        ,src_Tax_practitioner          ,src_TUCS_Ptrack               
		,src_TXBUS                     ,src_US_Coastguard             ,src_Utilities                 ,src_Util_Work_Phone           
    ,src_ZUtilities                ,src_ZUtil_Work_Phone
		,src_FL_Veh                    ,src_ID_Veh                    ,src_KY_Veh                    ,src_MA_Veh
		,src_ME_Veh
		,src_MN_Veh                    ,src_MS_Veh                    ,src_MT_Veh                    ,src_NC_Veh                    
		,src_ND_Veh                    ,src_NE_Veh                    ,src_NM_Veh                    ,src_NV_Veh                    
		,src_OH_Veh                    ,src_TX_Veh                    ,src_WI_Veh                    ,src_WY_Veh      
		//DF16817 - add 12 Experian new states - AR,AZ,GA,IA,KS,NC,RI,SC,SD,VT,WA									
		,src_AK_Experian_Veh           ,src_AL_Experian_Veh           ,src_AR_Experian_Veh           ,src_AZ_Experian_Veh
		,src_CO_Experian_Veh           ,src_CT_Experian_Veh           ,src_DC_Experian_Veh           ,src_DE_Experian_Veh
		,src_FL_Experian_Veh           ,src_GA_Experian_Veh           ,src_IA_Experian_Veh           ,src_ID_Experian_Veh
		,src_IL_Experian_Veh           ,src_KS_Experian_Veh           ,src_KY_Experian_Veh           ,src_LA_Experian_Veh
		,src_MA_Experian_Veh           ,src_MD_Experian_Veh           ,src_ME_Experian_Veh           ,src_MI_Experian_Veh
		,src_MN_Experian_Veh           ,src_MS_Experian_Veh           ,src_MT_Experian_Veh           ,src_NC_Experian_Veh
		,src_ND_Experian_Veh           ,src_NE_Experian_Veh           ,src_NM_Experian_Veh           ,src_NV_Experian_Veh
		,src_NY_Experian_Veh           ,src_OH_Experian_Veh           ,src_OK_Experian_Veh           ,src_RI_Experian_Veh
		,src_SC_Experian_Veh           ,src_SD_Experian_Veh           ,src_TN_Experian_Veh           ,src_TX_Experian_Veh           
		,src_UT_Experian_Veh           ,src_VT_Experian_Veh           ,src_WA_Experian_Veh           ,src_WI_Experian_Veh
		,src_WY_Experian_Veh          
		/*,src_Infutor_Veh						 ,src_Infutor_Motorcycle_Veh*/	,src_Vickers                   
		,src_Voters_v2                 ,src_AK_Watercraft             ,src_AL_Watercraft             ,src_AR_Watercraft             
		,src_AZ_Watercraft             ,src_CO_Watercraft             ,src_CT_Watercraft             ,src_FL_Watercraft             
		,src_GA_Watercraft             ,src_IA_Watercraft             ,src_IL_Watercraft             ,src_KS_Watercraft             
		,src_KY_Watercraft             ,src_MA_Watercraft             ,src_MD_Watercraft             ,src_ME_Watercraft             
		,src_MI_Watercraft             ,src_MN_Watercraft             ,src_MS_Watercraft             ,src_MT_Watercraft             
		,src_NC_Watercraft             ,src_ND_Watercraft             ,src_NE_Watercraft             ,src_NH_Watercraft             
		,src_NV_Watercraft             ,src_NY_Watercraft             ,src_OH_Watercraft             ,src_SC_Watercraft             
		,src_TN_Watercraft             ,src_TX_Watercraft             ,src_UT_Watercraft             ,src_VA_Watercraft             
		,src_WI_Watercraft             ,src_WV_Watercraft             ,src_WY_Watercraft             ,src_Whois_domains             
		,src_Wither_and_Die            ,src_MS_Worker_Comp            ,src_OR_Worker_Comp            ,src_Yellow_Pages              
		,src_ZOOM                      ,src_Bankruptcy_Attorney				,src_WV_Hist_Corporations      ,src_WY_Watercraft
		,src_AlloyMedia_student_list	 ,src_Death_Tributes						,src_Death_CA									 ,src_Death_CT
		,src_Death_FL									 ,src_Death_GA									,src_Death_KY									 ,src_Death_MA
		,src_Death_ME									 ,src_Death_MI									,src_Death_MN									 ,src_Death_MT
		,src_Death_NC									 ,src_Death_NV									,src_Death_OH									 ,src_Death_VA
		,src_Death_Restricted					 ,src_NM_Watercraft							,src_OKC_Probate
		/*,src_Death_Obituary					 ,src_Infutor_Watercraft*/
	];

  // POE = Place of Employment, now known as WorkPlace Locator
	export set_POE := [
		 /*src_jigsaw	 ,*/							src_spoke											,src_zoom											 ,src_teletrack
	  ,src_one_click_data						 ,src_Clarity										,src_Garnishments							 ,src_Thrive_LT
		,src_Thrive_PD
	] 
	+ set_CorpV2
	+ set_email
	;

	export set_Phonesplus := [
	 src_InfutorCID									, src_Cellphones_Kroll					,src_Cellphones_Traffix				,src_Cellphones_Nextones
	,src_Intrado										,src_Pcnsr											,src_Wired_Assets_Owned 			,src_Wired_Assets_Royalty
	,src_Targus_White_pages					,src_Gong_History,src_Gong_Neustar								,src_InquiryAcclogs						,src_Ibehavior
	,src_thrive_lt									, src_thrive_pd									,src_AlloyMedia_student_list	,src_Link2tek];
	
	//DF-22944
	export set_Phonesplus_Header := [
		src_Equifax										,src_LnPropV2_Fares_Asrs				,src_Voters_v2								,src_American_Students_List
		,src_Professional_License			,src_Certegy										,src_EMerge_Hunt							,src_EMerge_Master
		,src_TU_CreditHeader					,src_LnPropV2_Lexis_Asrs				,src_KY_Watercraft						,src_EMerge_Boat
		,src_VA_Watercraft						,src_NC_Watercraft							,src_EMerge_Cens							,src_Federal_Firearms
		,src_EMerge_Fish							,src_Federal_Explosives					,src_MD_Watercraft						,src_Miscellaneous
		,src_MO_Veh										,src_MO_DL											,src_MO_Experian_Veh					,src_Experian_Credit_Header
		,src_MO_Watercraft						,src_LnPropV2_Lexis_Deeds_Mtgs 
	];
	
	export set_Phonesplus_Royalty := [src_Wired_Assets_Royalty];
	
	export set_Prolic											:= [
			src_Professional_License		,src_AMIDIR
	];

	export set_Property                   := [
		 src_Fares_Deeds_from_Asrs     ,src_LnPropV2_Fares_Asrs       ,src_LnPropV2_Fares_Deeds      ,src_LnPropV2_Lexis_Asrs       
		,src_LnPropV2_Lexis_Deeds_Mtgs 
	];

	export set_scoring_FCRA_non_gov := [
		src_EMerge_Boat, src_EMerge_CCW, src_EMerge_Cens, src_EMerge_Fish, src_EMerge_Hunt, src_EMerge_Master,
		src_American_Students_List, src_AlloyMedia_student_list
	];

	export set_scoring_FCRA_gov := [
		src_Aircrafts, src_MS_Worker_Comp, src_AK_Perm_Fund, src_LnPropV2_Lexis_Asrs, src_Bankruptcy, src_Death_Master, src_Death_Restricted,
		src_Death_State, /*src_Death_Tributes,*/ src_LnPropV2_Lexis_Deeds_Mtgs, src_DEA, src_Federal_Explosives, src_Federal_Firearms,
		src_Airmen,	src_Liens_v2, src_Professional_License, src_US_Coastguard, src_Voters_v2 /*src_Death_CA, src_Death_CT, src_Death_FL,
		src_Death_GA, src_Death_KY, src_Death_MA, src_Death_ME, src_Death_MI, src_Death_MN, src_Death_MT, src_Death_NC, src_Death_NV,
		src_Death_OH, src_Death_VA, src_Death_Obituary*/ //Not cleared by modeling for use in FCRA
	];

	export set_scoring_FCRA_retro_test := [
			src_Experian_Credit_Header
	];

	export set_scoring_FCRA := [
			src_Aircrafts,                src_Airmen,                     /*src_AK_Perm_Fund,*/    src_AK_Watercraft,
			src_AL_Watercraft,            src_American_Students_List,     src_AR_Watercraft,       src_AZ_Watercraft,
			src_Bankruptcy,               src_CO_Watercraft,              src_CT_Watercraft,       src_DEA,
      src_Death_Master,             src_Death_State,                src_EMerge_Boat,         src_EMerge_CCW,
      src_EMerge_Cens,              src_EMerge_Fish,                src_EMerge_Hunt,         src_EMerge_Master,
      src_Equifax,                  src_Equifax_Quick,							src_Equifax_Weekly,			 src_Federal_Explosives,         
			src_Federal_Firearms,    			src_FL_Watercraft,							// removed TUCS 1/11/2012
      src_GA_Watercraft,            src_IA_Watercraft,              src_IL_Watercraft,       src_KS_Watercraft,
      src_KY_Watercraft,            src_Liens_v2,                   src_LnPropV2_Lexis_Asrs, src_LnPropV2_Lexis_Deeds_Mtgs,
      src_MA_Watercraft,            src_MD_Watercraft,              src_ME_Watercraft,       src_MI_Watercraft,
      src_MN_Watercraft,            src_MO_Watercraft,              src_MS_Watercraft,       src_MS_Worker_Comp,
      src_MT_Watercraft,            src_NC_Watercraft,              src_ND_Watercraft,       src_NE_Watercraft,
      src_NH_Watercraft,            src_NM_Watercraft,							src_NV_Watercraft,       src_NY_Watercraft,
      src_OH_Watercraft,						src_Professional_License,     	src_SC_Watercraft,       src_Targus_White_pages,
      src_TN_Watercraft,						src_TX_Watercraft,            	src_US_Coastguard,       src_US_Coastguard,
      src_UT_Watercraft,						src_VA_Watercraft,            	src_Voters_v2,           src_WI_Watercraft,
      src_WV_Watercraft,            src_WY_Watercraft,              src_OR_Watercraft,			 src_Death_Restricted,
			src_AK_Fishing_boats,					src_AlloyMedia_student_list, src_Experian_Credit_Header		/*,
			src_Death_CA, 								src_Death_CT, 									src_Death_FL,							src_Death_GA,
			src_Death_KY, 								src_Death_MA, 									src_Death_ME, 						src_Death_MI,
			src_Death_MN, 								src_Death_MT, 									src_Death_NC, 						src_Death_NV,
			src_Death_OH,									src_Death_VA,										src_Infutor_Watercraft,					src_Death_Obituary*/ //Not cleared by modeling for use in FCRA
	];

	export set_Sex_Offender               := [
		 src_Accurint_Sex_offender     ,src_FL_SO                     ,src_GA_SO                     ,src_MI_SO                     
		,src_PA_SO                     ,src_UT_SO ,src_sexoffender                    
	];

	export set_SIM                        := [
			src_LaborActions_EBSA
		 ,src_LaborActions_WHD
		 ,src_Insurance_Certification
		 ,src_NaturalDisaster_Readiness
		 ,src_Workers_Compensation
		 ];

	export set_State_Sales_Tax            := [
		 src_CA_Sales_Tax              ,src_IA_Sales_Tax              
	];
	
	export set_TCOA                       := [
		 src_TCOA_After_Address        ,src_TCOA_Before_Address       
	];

	export set_TEMP_Probation_sources     := [
		 src_Experian_Phones
	];

	export set_Transunion                 := [
		 src_Lexis_Trans_Union         ,src_TransUnion              ,src_TU_CreditHeader
	];

	export set_UCCS                       := [
		 src_UCC                       ,src_UCCV2										,src_UCCV2_WA_Hist                     
	];

	export set_Util_WorkPH            := [
		 src_Util_Work_Phone           ,src_ZUtil_Work_Phone
	];

	export set_Util_noWorkPH            := [
		 src_Utilities                 ,src_ZUtilities
	];

	export set_Vehicles                   := [
		 src_FL_Veh                    ,src_ID_Veh                    ,src_KY_Veh                    ,src_MA_Veh
		,src_ME_Veh
		,src_MN_Veh                    ,src_MO_Veh                    ,src_MS_Veh                    ,src_MT_Veh                    
		,src_NC_Veh                    ,src_ND_Veh                    ,src_NE_Veh                    ,src_NM_Veh                    
		,src_NV_Veh                    ,src_OH_Veh                    ,src_TX_Veh                    ,src_UT_Veh                    
		,src_WI_Veh                    ,src_WY_Veh                    ,src_AK_Experian_Veh           ,src_AL_Experian_Veh 
		//DF16817 - add 12 Experian new states - AR,AZ,GA,IA,KS,NC,RI,SC,SD,VT,WA									
		,src_AR_Experian_Veh           ,src_AZ_Experian_Veh           ,src_CO_Experian_Veh           ,src_CT_Experian_Veh
		,src_DC_Experian_Veh           ,src_DE_Experian_Veh           ,src_FL_Experian_Veh           ,src_GA_Experian_Veh
		,src_IA_Experian_Veh           ,src_ID_Experian_Veh           ,src_IL_Experian_Veh           ,src_KS_Experian_Veh
		,src_KY_Experian_Veh           ,src_LA_Experian_Veh           ,src_MA_Experian_Veh           ,src_MD_Experian_Veh
		,src_ME_Experian_Veh           ,src_MI_Experian_Veh           ,src_MN_Experian_Veh           ,src_MO_Experian_Veh
		,src_MS_Experian_Veh           ,src_MT_Experian_Veh           ,src_NC_Experian_Veh           ,src_ND_Experian_Veh
		,src_NE_Experian_Veh           ,src_NM_Experian_Veh           ,src_NV_Experian_Veh           ,src_NY_Experian_Veh
		,src_OH_Experian_Veh           ,src_OK_Experian_Veh           ,src_OR_Experian_Veh           ,src_RI_Experian_Veh
		,src_SC_Experian_Veh           ,src_SD_Experian_Veh           ,src_TN_Experian_Veh           ,src_TX_Experian_Veh           
		,src_UT_Experian_Veh           ,src_VT_Experian_Veh           ,src_WA_Experian_Veh           ,src_WI_Experian_Veh
		,src_WY_Experian_Veh					 ,src_Infutor_Veh								,src_Infutor_Motorcycle_Veh
	];

  // WC = Watercrafts
	export set_WC                         := [
		 src_AK_Fishing_boats          ,src_US_Coastguard             ,src_AK_Watercraft             ,src_AL_Watercraft             
		,src_AR_Watercraft             ,src_AZ_Watercraft             ,src_CO_Watercraft             ,src_CT_Watercraft             
		,src_FL_Watercraft             ,src_GA_Watercraft             ,src_IA_Watercraft             ,src_IL_Watercraft             
		,src_KS_Watercraft             ,src_KY_Watercraft             ,src_MA_Watercraft             ,src_MD_Watercraft             
		,src_ME_Watercraft             ,src_MI_Watercraft             ,src_MN_Watercraft             ,src_MO_Watercraft             
		,src_MS_Watercraft             ,src_MT_Watercraft             ,src_NC_Watercraft             ,src_ND_Watercraft             
		,src_NE_Watercraft             ,src_NH_Watercraft             ,src_NM_Watercraft						 ,src_NV_Watercraft             
		,src_NY_Watercraft						 ,src_OH_Watercraft             ,src_OR_Watercraft						 ,src_SC_Watercraft             
		,src_TN_Watercraft						 ,src_TX_Watercraft						  ,src_UT_Watercraft             ,src_VA_Watercraft             
		,src_WI_Watercraft						 ,src_WV_Watercraft						  ,src_WY_Watercraft             ,src_WA_Watercraft
		,src_Infutor_Watercraft
	]; 

	export set_Workmans_Comp              := [
		 src_MS_Worker_Comp            ,src_OR_Worker_Comp            
	];

 /* Not sure if we will need these yet for BIP2, but added them as commented out for now 
 //   just in case.            Dave Wright, 06/26/14
	export set_BIP_Business_Header_Partial_1 := [
	   // BIP Business Header indivdual sources plus applicable already existing sets
		 src_Aircrafts                 ,src_Bankruptcy                // BBB (see below)
    ,src_Business_Registration     ,src_CA_Sales_Tax              //,Corp2 (see below)
		,src_CrashCarrier              ,src_Credit_Unions             
		,src_DCA                       ,src_DEA                       ,src_Dunn_Bradstreet_Fein           
		//,src_Dunn_Bradstreet
		,src_EBR                       ,src_Experian_CRDB             //Experian_FEIN (see below)    
		//FBNV2 (see below)
    ,src_FDIC                      ,src_Frandx                    
		,src_Gong_Business             ,src_Gong_Government
    ,src_INFOUSA_ABIUS_USABIZ      ,src_INFOUSA_DEAD_COMPANIES    
		,src_IRS_5500                  ,src_IRS_Non_Profit
    ,src_Liens_v2                  //other src_liens_v2_***???    //,src_Liens_and_Judgments???
    //LN propertyv2 (see below)
    ,src_OSHAIR                    
		,src_Professional_License      ,src_SKA                       ,src_TXBUS
		//,src_UCC??? 
    ,src_UCCV2                     //,src_UCCV2_WA_Hist???
    ,src_Utilities                 //,src_ZUtilities???
		//Vehicles (see below), may need indivdual src_*** codes here??
    //Watercraft (see below), may need indivdual src_*** codes here???
		,src_Workers_Compensation			 ,src_Yellow_Pages
	 ]
   + set_BBB
	 + set_CorpV2 // minus src_WV_Hist_Corporations???
   + set_Experian_FEIN
   + set_Fbnv2
	 + set_LnPropertyV2 
   + set_Vehicles //minus src_Infutor_Veh???		,src_Infutor_Motorcycle_Veh ???
   + set_WC //minus src_AK_Fishing_boats???
  ;

	export set_BIP_Business_Header_All := [
     src_Dunn_Bradstreet           ,src_Zoom
   ]
	 + set_BIP_Business_Header_Partial_1
  ;

	export set_BIP_Business_Contacts := [      // <--- this OR this ---v???
  //???export set_BIP_ContactKey_sources := [ 
	   // Should match BIPV2_Build.key_contact_linkids shared contacts_sources
		 // BIP Business Header sources, minus D&B & Zoom (see below), plus indivdual sources 
		 src_ACF                       ,src_Diversity_Cert            ,src_FL_Non_Profit
		,src_GSA                       ,src_IA_Sales_Tax              ,src_Insurance_Certification
		,src_MartinDale_Hubbell        ,src_MS_Worker_Comp            ,src_NCPDP
		,src_OIG                      
		//POEsFromUtilites has the same source code as src_Utilites in set_BIP_Business_Header_Partial_1
		,src_Redbooks                  ,src_SDA                       ,src_SDAA
	 ]
   + set_BIP_Business_Header_Partial_1
  ;
	
	export set_BIP_IndustryKey_sources := [  
     // might need split out for set_BIP_DirectoriesKey_sources below???
	   // Should match BIPV2.Industry_Sources
		 src_AMIDIR                    //BBB (see below)
		,src_Business_Registration     ,src_Calbus                    //Corp2 (see below)
		,src_DCA                       ,src_Diversity_Cert            ,src_Dunn_Bradstreet_Fein
		,src_EBR                       ,src_Experian_CRDB // to be added 06/16 bug 157240
		,src_Edgar                     //FBNV2 (see below)
		,src_Frandx                    ,src_INFOUSA_ABIUS_USABIZ      ,src_INFOUSA_DEAD_COMPANIES
		,src_IRS_Non_Profit            ,src_laborActions_WHD          ,src_NCPDP
		,src_OIG                       ,src_OR_Worker_Comp            ,src_OSHAIR
    ,src_Spoke                     ,src_TXBUS                    	,src_Yellow_Pages	
	 ]
   + set_BBB
	 + set_CorpV2 // minus src_WV_Hist_Corporations???
   + set_Fbnv2
  ;
	
	//export set_BIP_DirectoriesKey_sources := [    ????????????
	   // Should match BIPV2_Build.key_directories_linkids
		 // Contact key sources + Industry key sources, minus duplcates???
	//]
	//+ set_BIP_Business_Contacts 
	//+ set_BIP_IndustryKey_sources_partial_1
  // what about sources that are in both sets??? 
	//;

	export set_BIP_LicenseKey_sources := [
	   // Should match BIPV2.License_Sources
		 src_AMS                       ,src_CNLD_Facilities
	 ];
/*  */ // end of special BIP2 sets

		
	// -----------------------------------------
	// -- Sets of Individual Source Codes
	// -----------------------------------------
	export set_ABMS                      := [src_ABMS                      ];
	export set_ACA                       := [src_ACA                       ];
	export set_Accidents_FL              := [src_Accidents_FL              ];
	export set_Accidents_ECrash          := [src_Accidents_ECrash          ];
	export set_Accidents_ECrash_CRU      := [src_Accidents_ECrash_CRU      ];
	export set_Accurint_Arrest_Log       := [src_Accurint_Arrest_Log       ];
	export set_Accurint_Crim_Court       := [src_Accurint_Crim_Court       ];
	export set_Accurint_DOC              := [src_Accurint_DOC              ];
	export set_Accurint_Sex_offender     := [src_Accurint_Sex_offender     ];
	export set_Accurint_Trade_Show       := [src_Accurint_Trade_Show       ];
	export set_ACF                       := [src_ACF                       ];
	export set_Acquiredweb               := [src_Acquiredweb               ];
	export set_Acquiredweb_plus					 := [src_Acquiredweb_plus					 ];
  export set_advo_valassis	           := [src_advo_valassis             ]; 
	export set_AHA                       := [src_AHA											 ];  
	export set_Aircrafts                 := [src_Aircrafts                 ];
	export set_Airmen                    := [src_Airmen                    ];
	export set_AK_Busreg                 := [src_AK_Busreg                 ];
	export set_AK_Fishing_boats          := [src_AK_Fishing_boats          ];
	export set_AK_Perm_Fund              := [src_AK_Perm_Fund              ];
	export set_ALC                       := [src_ALC                       ];
	export set_AlloyMedia_consumer			 :=	[src_AlloyMedia_consumer			 ];
	export set_AlloyMedia_student_list	 :=	[src_AlloyMedia_student_list	 ];
	export set_American_Students_List    := [src_American_Students_List    ];
	export set_OKC_Students_List         := [src_OKC_Students_List         ];
	export set_AMIDIR                    := [src_AMIDIR                    ];
	export set_AMS                       := [src_AMS                       ];
	export set_Anchor										 := [src_Anchor										 ];
	export set_Bair_Analytics            := [src_Bair_Analytics            ];
	export set_Bankruptcy_Attorney       := [src_Bankruptcy_Attorney       ];
	export set_Bankruptcy_Trustee        := [src_Bankruptcy_Trustee        ];
	export set_BBB_Member                := [src_BBB_Member                ];
	export set_BBB_Non_Member            := [src_BBB_Non_Member            ];
	export set_BrightVerify_email				 := [src_BrightVerify_email				 ];
	export set_Business_Credit			     := [src_Business_Credit           ];
	export set_Business_Registration     := [src_Business_Registration     ];
	export set_Calbus                    := [src_Calbus	       	           ];
	export set_Cellphones_Kroll 	     	 := [src_Cellphones_Kroll	       	 ];
	export set_Cellphones_Nextones 			 := [src_Cellphones_Nextones			 ];	
	export set_Cellphones_Traffix 	     := [src_Cellphones_Traffix				 ];	
	export set_Certegy                   := [src_Certegy                   ];
	export set_Consumer_Disclosure_feed                   := [src_Consumer_Disclosure_feed                   ];
	export set_CClue	                   := [src_CClue	                   ];
	export set_Correctional_Facilities   := [src_Correctional_Facilities   ];
	export set_Cortera                   := [src_Cortera                   ];
	export set_FL_CH                     := [src_FL_CH                     ];
	export set_GA_CH                     := [src_GA_CH                     ];
	export set_PA_CH                     := [src_PA_CH                     ];
	export set_UT_CH                     := [src_UT_CH                     ];
	export set_Clarity				           := [src_Clarity				           ];
	export set_CLIA		                   := [src_CLIA		                   ];
  export set_CNLD_Facilities	  			 := [src_CNLD_Facilities					 ];
  export set_CNLD_Practitioner         := [src_CNLD_Practitioner         ];
	export set_AK_Corporations           := [src_AK_Corporations           ];
	export set_AL_Corporations           := [src_AL_Corporations           ];
	export set_AR_Corporations           := [src_AR_Corporations           ];
	export set_AZ_Corporations           := [src_AZ_Corporations           ];
	export set_CA_Corporations           := [src_CA_Corporations           ];
	export set_CO_Corporations           := [src_CO_Corporations           ];
	export set_CT_Corporations           := [src_CT_Corporations           ];
	export set_DC_Corporations           := [src_DC_Corporations           ];
	export set_FL_Corporations           := [src_FL_Corporations           ];
	export set_GA_Corporations           := [src_GA_Corporations           ];
	export set_HI_Corporations           := [src_HI_Corporations           ];
	export set_IA_Corporations           := [src_IA_Corporations           ];
	export set_ID_Corporations           := [src_ID_Corporations           ];
	export set_IL_Corporations           := [src_IL_Corporations           ];
	export set_IN_Corporations           := [src_IN_Corporations           ];
	export set_KS_Corporations           := [src_KS_Corporations           ];
	export set_KY_Corporations           := [src_KY_Corporations           ];
	export set_LA_Corporations           := [src_LA_Corporations           ];
	export set_MA_Corporations           := [src_MA_Corporations           ];
	export set_MD_Corporations           := [src_MD_Corporations           ];
	export set_ME_Corporations           := [src_ME_Corporations           ];
	export set_MI_Corporations           := [src_MI_Corporations           ];
	export set_MN_Corporations           := [src_MN_Corporations           ];
	export set_MO_Corporations           := [src_MO_Corporations           ];
	export set_MS_Corporations           := [src_MS_Corporations           ];
	export set_MT_Corporations           := [src_MT_Corporations           ];
	export set_NC_Corporations           := [src_NC_Corporations           ];
	export set_ND_Corporations           := [src_ND_Corporations           ];
	export set_NE_Corporations           := [src_NE_Corporations           ];
	export set_NH_Corporations           := [src_NH_Corporations           ];
	export set_NJ_Corporations           := [src_NJ_Corporations           ];
	export set_NM_Corporations           := [src_NM_Corporations           ];
	export set_NV_Corporations           := [src_NV_Corporations           ];
	export set_NY_Corporations           := [src_NY_Corporations           ];
	export set_OH_Corporations           := [src_OH_Corporations           ];
	export set_OK_Corporations           := [src_OK_Corporations           ];
	export set_OR_Corporations           := [src_OR_Corporations           ];
	export set_PA_Corporations           := [src_PA_Corporations           ];
	export set_RI_Corporations           := [src_RI_Corporations           ];
	export set_SC_Corporations           := [src_SC_Corporations           ];
	export set_SD_Corporations           := [src_SD_Corporations           ];
	export set_TN_Corporations           := [src_TN_Corporations           ];
	export set_TX_Corporations           := [src_TX_Corporations           ];
	export set_UT_Corporations           := [src_UT_Corporations           ];
	export set_VA_Corporations           := [src_VA_Corporations           ];
	export set_VT_Corporations           := [src_VT_Corporations           ];
	export set_WA_Corporations           := [src_WA_Corporations           ];
	export set_WI_Corporations           := [src_WI_Corporations           ];
	export set_WV_Corporations           := [src_WV_Corporations           ];
	export set_WV_Hist_Corporations      := [src_WV_Hist_Corporations      ];
	export set_WY_Corporations           := [src_WY_Corporations           ];
	export set_CrashCarrier              := [src_CrashCarrier              ];	
	export set_infutor_narc3             := [src_infutor_narc3             ];
	export set_Credit_Unions             := [src_Credit_Unions             ];
	export set_Datagence                 := [src_Datagence                 ];
	export set_DCA                       := [src_DCA                       ];
	export set_Death_Michigan            := [src_Death_Michigan            ];
	export set_Death_Master              := [src_Death_Master              ];
	export set_Death_Restricted          := [src_Death_Restricted					 ];
	export set_Death_State               := [src_Death_State               ];
	export set_Death_Tributes						 := [src_Death_Tributes						 ];
	export set_Death_Obituary						 := [src_Death_Obituary						 ];
	export set_Death_CA									 := [src_Death_CA									 ];
	export set_Death_CT									 := [src_Death_CT									 ];
	export set_Death_FL									 := [src_Death_FL									 ];
	export set_Death_GA									 := [src_Death_GA									 ];
	export set_Death_KY									 := [src_Death_KY									 ];
	export set_Death_MA									 := [src_Death_MA									 ];
	export set_Death_ME									 := [src_Death_ME									 ];
	export set_Death_MI									 := [src_Death_MI									 ];
	export set_Death_MN									 := [src_Death_MN									 ];
	export set_Death_MT									 := [src_Death_MT									 ];
	export set_Death_NC									 := [src_Death_NC									 ];
	export set_Death_NV									 := [src_Death_NV									 ];
	export set_Death_OH									 := [src_Death_OH									 ];
	export set_Death_VA									 :=	[src_death_VA									 ];
  export set_Debt_Settlement					 := [src_Debt_Settlement           ];
	export set_Diversity_Cert            := [src_Diversity_Cert];
	export set_Divorce					 				 := [src_Divorce									 ];
	export set_CT_DL                     := [src_CT_DL                     ];
	export set_FL_DL                     := [src_FL_DL                     ];
	export set_IA_DL                     := [src_IA_DL                     ];
	export set_ID_DL                     := [src_ID_DL                     ];
	export set_KY_DL                     := [src_KY_DL                     ];
	export set_MA_DL                     := [src_MA_DL                     ];
	export set_ME_DL                     := [src_ME_DL                     ];
	export set_MI_DL                     := [src_MI_DL                     ];
	export set_MN_DL                     := [src_MN_DL                     ];
	export set_MO_DL                     := [src_MO_DL                     ];
	export set_NC_DL                     := [src_NC_DL                     ];
	export set_NE_DL                     := [src_NE_DL                     ];
	export set_NM_DL                     := [src_NM_DL                     ];
	export set_NV_DL                     := [src_NV_DL                     ];
	export set_LA_DL                     := [src_LA_DL                     ];		
	export set_OH_DL                     := [src_OH_DL                     ];
	export set_OR_DL                     := [src_OR_DL                     ];
	export set_TN_DL                     := [src_TN_DL                     ];
	export set_TX_DL                     := [src_TX_DL                     ];
	export set_UT_DL                     := [src_UT_DL                     ];
	export set_WI_DL                     := [src_WI_DL                     ];
	export set_WV_DL                     := [src_WV_DL                     ];
	export set_WY_DL                     := [src_WY_DL                     ];
	export set_CO_Experian_DL            := [src_CO_Experian_DL            ];
	export set_DE_Experian_DL            := [src_DE_Experian_DL            ];
	export set_ID_Experian_DL            := [src_ID_Experian_DL            ];
	export set_IL_Experian_DL            := [src_IL_Experian_DL            ];
	export set_KY_Experian_DL            := [src_KY_Experian_DL            ];
	export set_LA_Experian_DL            := [src_LA_Experian_DL            ];
	export set_MD_Experian_DL            := [src_MD_Experian_DL            ];
	export set_MS_Experian_DL            := [src_MS_Experian_DL            ];
	export set_ND_Experian_DL            := [src_ND_Experian_DL            ];
	export set_NH_Experian_DL            := [src_NH_Experian_DL            ];
	export set_SC_Experian_DL            := [src_SC_Experian_DL            ];
	export set_WV_Experian_DL            := [src_WV_Experian_DL            ];
	export set_MN_RESTRICTED_DL          := [src_MN_RESTRICTED_DL          ];
	export set_Dummy_Records             := [src_Dummy_Records             ];
	export set_Dummy_Records2            := [src_Dummy_Records2            ];
	export set_Dunn_Bradstreet           := [src_Dunn_Bradstreet           ];
	export set_Dunn_Bradstreet_Fein      := [src_Dunn_Bradstreet_Fein      ];
	export set_Dunndata_Consumer         := [src_Dunndata_Consumer         ];
	export set_Dunn_Data_Email					 := [src_Dunn_Data_Email					 ];
	export set_EBR                       := [src_EBR                       ];
	export set_Edgar                     := [src_Edgar                     ];
	export set_Emdeon                    := [src_Emdeon                    ];
	export set_EMerge_Boat               := [src_EMerge_Boat               ];
	export set_EMerge_CCW                := [src_EMerge_CCW                ];
	export set_EMerge_CCW_NY             := [src_EMerge_CCW_NY             ];
	export set_EMerge_Cens               := [src_EMerge_Cens               ];
	export set_EMerge_Fish               := [src_EMerge_Fish               ];
	export set_EMerge_Hunt               := [src_EMerge_Hunt               ];
	export set_EMerge_Master             := [src_EMerge_Master             ];
	export set_Employee_Directories      := [src_Employee_Directories      ];
	export set_Enclarity								 := [src_Enclarity								 ];
	export set_Entiera                   := [src_Entiera                   ];		
	export set_Equifax_Business_Data     := [src_Equifax_Business_Data     ];	
	export set_Equifax_Direct            := [src_Equifax                   ];
	export set_Equifax_Quick             := [src_Equifax_Quick             ];
	export set_Equifax_Weekly            := [src_Equifax_Weekly            ];
	export set_Eq_Employer               := [src_Eq_Employer               ];
	export set_Experian_CRDB    				 := [src_Experian_CRDB    				 ];
	export set_Experian_Credit_Header    := [src_Experian_Credit_Header    ];
	export set_Experian_FEIN_Rest        := [src_Experian_FEIN_Rest        ];
	export set_Experian_FEIN_Unrest      := [src_Experian_FEIN_Unrest      ];
	export set_Experian_Phones           := [src_Experian_Phones           ];
	export set_Fares_Deeds_from_Asrs     := [src_Fares_Deeds_from_Asrs     ];
	export set_FBNV2_BusReg					     := [src_FBNV2_BusReg						   ];
	export set_FBNV2_CA_Orange_county    := [src_FBNV2_CA_Orange_county    ];
	export set_FBNV2_CA_Santa_Clara      := [src_FBNV2_CA_Santa_Clara      ];
	export set_FBNV2_CA_San_Bernadino    := [src_FBNV2_CA_San_Bernadino    ];
	export set_FBNV2_CA_San_Diego        := [src_FBNV2_CA_San_Diego        ];
	export set_FBNV2_CA_Ventura          := [src_FBNV2_CA_Ventura          ];
	export set_FBNV2_Experian_Direct     := [src_FBNV2_Experian_Direct     ];
	export set_FBNV2_FL                  := [src_FBNV2_FL                  ];
	export set_FBNV2_Hist_Choicepoint    := [src_FBNV2_Hist_Choicepoint    ];
	export set_FBNV2_INF                 := [src_FBNV2_INF                 ];
	export set_FBNV2_New_York            := [src_FBNV2_New_York            ];
	export set_FBNV2_TX_Dallas           := [src_FBNV2_TX_Dallas           ];
	export set_FBNV2_TX_Harris           := [src_FBNV2_TX_Harris           ];
	export set_FCC_Radio_Licenses        := [src_FCC_Radio_Licenses        ];
	export set_FCRA_Corrections_record   := [src_FCRA_Corrections_record   ];
	export set_FDIC                      := [src_FDIC                      ];
	export set_FDIC_SOD									 := [src_FDIC_SOD                  ];	
	export set_Federal_Explosives        := [src_Federal_Explosives        ];
	export set_Federal_Firearms          := [src_Federal_Firearms          ];
	export set_FL_FBN                    := [src_FL_FBN                    ];
	export set_FL_Non_Profit             := [src_FL_Non_Profit             ];
	export set_Foreclosures              := [src_Foreclosures              ];
	export set_Foreclosures_Delinquent   := [src_Foreclosures_Delinquent   ];
	export set_Frandx									   := [src_Frandx									   ];
	export set_NJ_Gaming_Licenses        := [src_NJ_Gaming_Licenses        ];
	export set_Garnishments	             := [src_Garnishments	             ];
	export set_Gong_Business             := [src_Gong_Business             ];
	export set_Gong_Government           := [src_Gong_Government           ];
	export set_Gong_History              := [src_Gong_History,src_Gong_Neustar];
	export set_Gong_phone_append         := [src_Gong_phone_append         ];
	export set_GSA                       := [src_GSA                       ];
	export set_GSDD                      := [src_GSDD                      ];
	export set_HMS_PM										 := [src_HMS_PM										 ]; 
	export set_HXMX											 := [src_HXMX											 ]; // HXMX and Symphony are the same
	export set_Symphony									 := [src_HXMX											 ]; // added both to avoid a new source being added
	export set_Ibehavior                 := [src_Ibehavior                 ];	
	export set_Impulse                   := [src_Impulse                   ];	
	export set_Infogroup                 := [src_Infogroup                 ];
	export set_INFOUSA_ABIUS_USABIZ      := [src_INFOUSA_ABIUS_USABIZ      ];
	export set_INFOUSA_DEAD_COMPANIES    := [src_INFOUSA_DEAD_COMPANIES    ];
	export set_INFOUSA_IDEXEC            := [src_INFOUSA_IDEXEC            ];
	export set_Infutor_NARB              := [src_Infutor_NARB              ];
	export set_InfutorCID								 := [src_InfutorCID		       			 ];
	export set_InfutorTRK								 := [src_InfutorTRK		       			 ];
	export set_InfutorNarc               := [src_InfutorNarc               ];
	export set_InfutorNare               := [src_InfutorNare               ];
	export set_Ingenix_Sanctions         := [src_Ingenix_Sanctions         ];
	export set_InquiryAcclogs            := [src_InquiryAcclogs            ];
	export set_Insurance_Certification   := [src_Insurance_Certification   ];
	export set_Intrado 									 := [src_Intrado									 ];		
	export set_IRS_5500                  := [src_IRS_5500                  ];
	export set_IRS_Non_Profit            := [src_IRS_Non_Profit            ];
	export set_Jigsaw                    := [src_Jigsaw                    ];
	export set_LaborActions_EBSA				 := [src_LaborActions_EBSA         ];
	export set_LaborActions_WHD          := [src_LaborActions_WHD          ];
	export set_Lexis_Trans_Union         := [src_Lexis_Trans_Union         ];
	export set_LiensV1                   := [src_Liens                     ];
	export set_Liens_and_Judgments       := [src_Liens_and_Judgments       ];
	export set_Liens_v2                  := [src_Liens_v2                  ];
	export set_Liens_v2_CA_Federal       := [src_Liens_v2_CA_Federal       ];
	export set_Liens_v2_Chicago_Law      := [src_Liens_v2_Chicago_Law      ];
	export set_Liens_v2_Hogan            := [src_Liens_v2_Hogan            ];
	export set_Liens_v2_ILFDLN           := [src_Liens_v2_ILFDLN           ];
	export set_Liens_v2_MA               := [src_Liens_v2_MA               ];
	export set_Liens_v2_NYC              := [src_Liens_v2_NYC              ];
	export set_Liens_v2_NYFDLN           := [src_Liens_v2_NYFDLN           ];
	export set_Liens_v2_Service_Abstract := [src_Liens_v2_Service_Abstract ];
	export set_Liens_v2_Superior_Party   := [src_Liens_v2_Superior_Party   ];
	export set_Link2tek									 := [src_Link2tek									 ];
	export set_CA_Liquor_Licenses        := [src_CA_Liquor_Licenses        ];
	export set_CT_Liquor_Licenses        := [src_CT_Liquor_Licenses        ];
	export set_IN_Liquor_Licenses        := [src_IN_Liquor_Licenses        ];
	export set_LA_Liquor_Licenses        := [src_LA_Liquor_Licenses        ];
	export set_OH_Liquor_Licenses        := [src_OH_Liquor_Licenses        ];
	export set_PA_Liquor_Licenses        := [src_PA_Liquor_Licenses        ];
	export set_TX_Liquor_Licenses        := [src_TX_Liquor_Licenses        ];
	export set_LnPropV2_Fares_Asrs       := [src_LnPropV2_Fares_Asrs       ];
	export set_LnPropV2_Fares_Deeds      := [src_LnPropV2_Fares_Deeds      ];
	export set_LnPropV2_Lexis_Asrs       := [src_LnPropV2_Lexis_Asrs       ];
	export set_LnPropV2_Lexis_Deeds_Mtgs := [src_LnPropV2_Lexis_Deeds_Mtgs ];
	export set_Lobbyists                 := [src_Lobbyists                 ];
	export set_Mari_Prof_Lic	 				   := [src_Mari_Prof_Lic						 ];
	export set_Mari_Public_Sanc	 			   := [src_Mari_Public_Sanc					 ];
	export set_Marriage					 				 := [src_Marriage									 ];
	export set_MartinDale_Hubbell        := [src_MartinDale_Hubbell        ];
	export set_MediaOne		           	   := [src_MediaOne		  		         ];
	export set_Metronet_Gateway          := [src_Metronet_Gateway          ];
	export set_Miscellaneous             := [src_Miscellaneous             ];
	export set_Mixed_DPPA                := [src_Mixed_DPPA                ];
	export set_Mixed_Non_DPPA            := [src_Mixed_Non_DPPA            ];
	export set_Mixed_Probation           := [src_Mixed_Probation           ];
	export set_Mixed_Utilities           := [src_Mixed_Utilities           ];
	export set_MPRD_Individual           := [src_MPRD_Individual           ];
	export set_MMCP						           := [src_MMCP						           ];
  export set_NaturalDisaster_Readiness := [src_NaturalDisaster_Readiness ];
	export set_NCPDP                     := [src_NCPDP                     ];
	export set_NCOA                      := [src_NCOA                      ];
	export set_NeustarWireless					 := [src_NeustarWireless					 ];
	export set_NPPES                     := [src_NPPES                     ];
	export set_OIG                       := [src_OIG                       ];
	export set_One_Click_Data            := [src_One_Click_Data            ];
	export set_OSHAIR                    := [src_OSHAIR                    ];
	export set_OutwardMedia		           	:= [src_OutwardMedia			         ];
	export set_OKC_Probate							 :=	[src_OKC_Probate  						 ];
	export set_OKC_Student_List					 				:= [src_OKC_Student_List					 ];
	export set_PBSA			                 := [src_PBSA 			               ];
	export set_Pcnsr		                 := [src_Pcnsr			               ];
	export set_PhoneFraud								 := [src_PhoneFraud_OTP];	
	export set_Phones_Plus               := [src_Phones_Plus               ];
	export set_Phones_Disconnect				 := [src_Phones_Disconnect				 ];
	export set_Phones_Gong_History_Disconnect := [src_Phones_Gong_History_Disconnect];
	export set_Phones_Accudata_OCN_LNP	 := [src_Phones_Accudata_OCN_LNP	 ];
	export set_Phones_Accudata_CNAM_CNM2 := [src_Phones_Accudata_CNAM_CNM2 ];
	export set_Phones_Lerg6							 := [src_Phones_Lerg6							 ];
	export set_Phones_LIDB				 			 := [src_Phones_LIDB				 			 ];
	export set_PhonesPorted						   := [src_PhonesPorted_TCPA, src_PhonesPorted_TCPA_CL, src_PhonesPorted_iConectiv, src_PhonesPorted_iConectiv_Rng, src_Phones_Accudata_OCN_LNP];
	export set_POS                       := [src_POS                       ];  			
	export set_Professional_License      := [src_Professional_License      ];
	export set_PSS								       := [src_PSS									     ];
	export set_RealSource																:= [src_RealSource																];
	export set_Redbooks                  := [src_Redbooks                  ];
	export set_SalesChannel		           := [src_SalesChannel		           ];
	export set_CA_Sales_Tax              := [src_CA_Sales_Tax              ];
	export set_IA_Sales_Tax              := [src_IA_Sales_Tax              ];
	export set_SDA                       := [src_SDA                       ];
	export set_SDAA                      := [src_SDAA                      ];
	export set_SEC_Broker_Dealer         := [src_SEC_Broker_Dealer         ];
	export set_sexoffender               := [src_sexoffender               ];
	export set_Sheila_Greco              := [src_Sheila_Greco              ];
	export set_SKA                       := [src_SKA                       ];
	export set_FL_SO                     := [src_FL_SO                     ];
	export set_GA_SO                     := [src_GA_SO                     ];
	export set_MI_SO                     := [src_MI_SO                     ];
	export set_PA_SO                     := [src_PA_SO                     ];
	export set_UT_SO                     := [src_UT_SO                     ];
	export set_Spoke                     := [src_Spoke                     ];
	export set_Targus_White_pages        := [src_Targus_White_pages        ];
	export set_Tax_practitioner          := [src_Tax_practitioner          ];
	export set_TCOA_After_Address        := [src_TCOA_After_Address        ];
	export set_TCOA_Before_Address       := [src_TCOA_Before_Address       ];
	export set_Teletrack				         := [src_Teletrack                 ];
	export set_Thrive_LT				         := [src_Thrive_LT                 ];
	export set_Thrive_LT_POE_Email       := [src_Thrive_LT_POE_Email       ];
	export set_Thrive_PD				         := [src_Thrive_PD                 ];
	export set_Thrive_PD_POE_Email			 := [src_Thrive_PD_POE_Email       ];	
	export set_TransUnion_Direct         := [src_TransUnion                ];
	export set_TransUnion_Credit_Header  := [src_TU_CreditHeader           ];
	export set_TUCS_Ptrack               := [src_TUCS_Ptrack               ];
	export set_TXBUS                     := [src_TXBUS                     ];
	export set_UCC                       := [src_UCC                       ];
	export set_UCCV2                     := [src_UCCV2                     ];
	export set_UCCV2_WA_Hist             := [src_UCCV2_WA_Hist             ];
	export set_US_Coastguard             := [src_US_Coastguard             ];
	export set_Utilities                 := [src_Utilities                 ];
	export set_Util_Work_Phone           := [src_Util_Work_Phone           ];
	export set_ZUtilities                := [src_ZUtilities                ];
	export set_ZUtil_Work_Phone          := [src_ZUtil_Work_Phone          ];
	export set_FL_Veh                    := [src_FL_Veh                    ];
	export set_ID_Veh                    := [src_ID_Veh                    ];
	export set_KY_Veh                    := [src_KY_Veh                    ];
	export set_MA_Veh                    := [src_MA_Veh                    ];
	export set_ME_Veh                    := [src_ME_Veh                    ];
	export set_MN_Veh                    := [src_MN_Veh                    ];
	export set_MO_Veh                    := [src_MO_Veh                    ];
	export set_MS_Veh                    := [src_MS_Veh                    ];
	export set_MT_Veh                    := [src_MT_Veh                    ];
	export set_NC_Veh                    := [src_NC_Veh                    ];
	export set_ND_Veh                    := [src_ND_Veh                    ];
	export set_NE_Veh                    := [src_NE_Veh                    ];
	export set_NM_Veh                    := [src_NM_Veh                    ];
	export set_NV_Veh                    := [src_NV_Veh                    ];
	export set_OH_Veh                    := [src_OH_Veh                    ];
	export set_TX_Veh                    := [src_TX_Veh                    ];
	export set_UT_Veh                    := [src_UT_Veh                    ];
	export set_WI_Veh                    := [src_WI_Veh                    ];
	export set_WY_Veh                    := [src_WY_Veh                    ];
	export set_AK_Experian_Veh           := [src_AK_Experian_Veh           ];
	export set_AL_Experian_Veh           := [src_AL_Experian_Veh           ];
	export set_AR_Experian_Veh           := [src_AR_Experian_Veh           ];				//DF16817
	export set_AZ_Experian_Veh           := [src_AZ_Experian_Veh           ];				//DF16817
	export set_CO_Experian_Veh           := [src_CO_Experian_Veh           ];
	export set_CT_Experian_Veh           := [src_CT_Experian_Veh           ];
	export set_DC_Experian_Veh           := [src_DC_Experian_Veh           ];
	export set_DE_Experian_Veh           := [src_DE_Experian_Veh           ];
	export set_FL_Experian_Veh           := [src_FL_Experian_Veh           ];
	export set_GA_Experian_Veh           := [src_GA_Experian_Veh           ];				//DF16817
	export set_IA_Experian_Veh           := [src_IA_Experian_Veh           ];				//DF16817
	export set_ID_Experian_Veh           := [src_ID_Experian_Veh           ];
	export set_IL_Experian_Veh           := [src_IL_Experian_Veh           ];
	export set_KS_Experian_Veh           := [src_KS_Experian_Veh           ];				//DF16817
	export set_KY_Experian_Veh           := [src_KY_Experian_Veh           ];
	export set_LA_Experian_Veh           := [src_LA_Experian_Veh           ];
	export set_MA_Experian_Veh           := [src_MA_Experian_Veh           ];
	export set_MD_Experian_Veh           := [src_MD_Experian_Veh           ];
	export set_ME_Experian_Veh           := [src_ME_Experian_Veh           ];
	export set_MI_Experian_Veh           := [src_MI_Experian_Veh           ];
	export set_MN_Experian_Veh           := [src_MN_Experian_Veh           ];
	export set_MO_Experian_Veh           := [src_MO_Experian_Veh           ];
	export set_MS_Experian_Veh           := [src_MS_Experian_Veh           ];
	export set_MT_Experian_Veh           := [src_MT_Experian_Veh           ];
	export set_NC_Experian_Veh           := [src_NC_Experian_Veh           ];				//DF16817
	export set_ND_Experian_Veh           := [src_ND_Experian_Veh           ];
	export set_NE_Experian_Veh           := [src_NE_Experian_Veh           ];
	export set_NM_Experian_Veh           := [src_NM_Experian_Veh           ];
	export set_NV_Experian_Veh           := [src_NV_Experian_Veh           ];
	export set_NY_Experian_Veh           := [src_NY_Experian_Veh           ];
	export set_OH_Experian_Veh           := [src_OH_Experian_Veh           ];
	export set_OK_Experian_Veh           := [src_OK_Experian_Veh           ];
	export set_OR_Experian_Veh           := [src_OR_Experian_Veh           ];
	export set_RI_Experian_Veh           := [src_RI_Experian_Veh           ];				//DF16817
	export set_SC_Experian_Veh           := [src_SC_Experian_Veh           ];
	export set_SD_Experian_Veh           := [src_SD_Experian_Veh           ];				//DF16817
	export set_TN_Experian_Veh           := [src_TN_Experian_Veh           ];
	export set_TX_Experian_Veh           := [src_TX_Experian_Veh           ];
	export set_UT_Experian_Veh           := [src_UT_Experian_Veh           ];
	export set_VT_Experian_Veh           := [src_VT_Experian_Veh           ];				//DF16817
	export set_WA_Experian_Veh           := [src_WA_Experian_Veh           ];				//DF16817
	export set_WI_Experian_Veh           := [src_WI_Experian_Veh           ];
	export set_WY_Experian_Veh           := [src_WY_Experian_Veh           ];
	export set_Infutor_Veh               := [src_Infutor_Veh		           ];
	export set_Infutor_Motorcycle_Veh		 := [src_Infutor_Motorcycle_Veh    ];
	export set_Infutor_All_Veh		       := [src_Infutor_Veh,src_Infutor_Motorcycle_Veh];
	export set_Vickers                   := [src_Vickers                   ];
	export set_Voters_v2                 := [src_Voters_v2                 ];
	export set_AK_Watercraft             := [src_AK_Watercraft             ];
	export set_AL_Watercraft             := [src_AL_Watercraft             ];
	export set_AR_Watercraft             := [src_AR_Watercraft             ];
	export set_AZ_Watercraft             := [src_AZ_Watercraft             ];
	export set_CO_Watercraft             := [src_CO_Watercraft             ];
	export set_CT_Watercraft             := [src_CT_Watercraft             ];
	export set_FL_Watercraft             := [src_FL_Watercraft             ];
	export set_GA_Watercraft             := [src_GA_Watercraft             ];
	export set_IA_Watercraft             := [src_IA_Watercraft             ];
	export set_IL_Watercraft             := [src_IL_Watercraft             ];
	export set_KS_Watercraft             := [src_KS_Watercraft             ];
	export set_KY_Watercraft             := [src_KY_Watercraft             ];
	export set_MA_Watercraft             := [src_MA_Watercraft             ];
	export set_MD_Watercraft             := [src_MD_Watercraft             ];
	export set_ME_Watercraft             := [src_ME_Watercraft             ];
	export set_MI_Watercraft             := [src_MI_Watercraft             ];
	export set_MN_Watercraft             := [src_MN_Watercraft             ];
	export set_MO_Watercraft             := [src_MO_Watercraft             ];
	export set_MS_Watercraft             := [src_MS_Watercraft             ];
	export set_MT_Watercraft             := [src_MT_Watercraft             ];
	export set_NC_Watercraft             := [src_NC_Watercraft             ];
	export set_ND_Watercraft             := [src_ND_Watercraft             ];
	export set_NE_Watercraft             := [src_NE_Watercraft             ];
	export set_NH_Watercraft             := [src_NH_Watercraft             ];
	export set_NM_Watercraft						 := [src_NM_Watercraft						 ];
	export set_NV_Watercraft             := [src_NV_Watercraft             ];
	export set_NY_Watercraft             := [src_NY_Watercraft             ];
	export set_OH_Watercraft             := [src_OH_Watercraft             ];
	export set_OR_Watercraft             := [src_OR_Watercraft             ];
	export set_SC_Watercraft             := [src_SC_Watercraft             ];
	export set_TN_Watercraft             := [src_TN_Watercraft             ];
	export set_TX_Watercraft             := [src_TX_Watercraft             ];
	export set_UT_Watercraft             := [src_UT_Watercraft             ];
	export set_VA_Watercraft             := [src_VA_Watercraft             ];
	export set_WI_Watercraft             := [src_WI_Watercraft             ];
	export set_WV_Watercraft             := [src_WV_Watercraft             ];
	export set_WY_Watercraft             := [src_WY_Watercraft             ];
	export set_WA_Watercraft             := [src_WA_Watercraft             ];
	export set_FL_Watercraft_LN          := [src_FL_Watercraft_LN          ];
	export set_KY_Watercraft_LN          := [src_KY_Watercraft_LN          ];
	export set_MO_Watercraft_LN          := [src_MO_Watercraft_LN          ];
	export set_Infutor_Watercraft				 := [src_Infutor_Watercraft				 ];
	export set_Whois_domains             := [src_Whois_domains             ];
	export set_Wired_Assets_Email        := [src_Wired_Assets_Email        ];
	export set_Wired_Assets_Owned 			 := [src_Wired_Assets_Owned				 ];
	export set_Wired_Assets_Royalty 		 := [src_Wired_Assets_Royalty			 ];
	export set_Wither_and_Die            := [src_Wither_and_Die            ];
  export set_Workers_Compensation      := [src_Workers_Compensation      ];
	export set_MS_Worker_Comp            := [src_MS_Worker_Comp            ];
	export set_OR_Worker_Comp            := [src_OR_Worker_Comp            ];
	export set_Yellow_Pages              := [src_Yellow_Pages              ];
	export set_ZOOM                      := [src_ZOOM                      ];
	export set_Zumigo_GetLineId  				 := [src_Zumigo_GetLineId 				 ];
	export set_BKFS_Nod                  := [src_BKFS_Nod                  ];
	export set_BKFS_Reo                  := [src_BKFS_Reo                  ];
	export set_credit_header_bureau      := set_Transunion + set_Experian_Credit_Header +
	                                        set_Equifax_Direct + set_Equifax_Quick + set_Equifax_Weekly;

	// -----------------------------------------
	// -- Permissioning of Source Codes
	// -----------------------------------------
	export str_DPPA 						:= 'A';
	export str_DPPA_Probation		:= 'B';
	export str_NonDPPA 					:= ' ';
	export str_Utility					:= 'U';
	export str_FCRA 						:= 'D';
	export str_FCRA_Probation 	:= 'E';
	export str_Other_Probation 	:= 'C';


	export set_FCRA   					:= [str_FCRA, str_FCRA_Probation];
	export set_DPPA   					:= [str_DPPA, str_DPPA_Probation];
	export set_Probation   			:= [str_DPPA_Probation, str_FCRA_Probation, str_Other_Probation];


	export SourceGroup(string2 sr) := 
		MAP( 
			 sr in set_TEMP_Probation_sources	=> str_Other_Probation
			,sr in set_DPPA_Probation_sources	=> str_DPPA_Probation
			,sr in set_DPPA_sources 			 		=> str_DPPA 			 
			,sr in set_NonDPPA_sources				=> str_NonDPPA 
			,sr in set_Utility_sources		 		=> str_Utility 
			,sr in set_FCRA_sources			 			=> str_FCRA 
			,sr in set_FCRA_Probation_sources => str_FCRA_Probation
			,																		 str_Other_Probation
		 ); 


	// -----------------------------------------
	// -- Source Tests
	// -----------------------------------------
	export SourceIsABMS                       (string  sr) := sr               in set_ABMS                       ;
	export SourceIsACA                        (string  sr) := sr               in set_ACA                        ;
	export SourceIsAccidents                  (string  sr) := sr               in set_Accidents                  ;
	export SourceIsAccidents_FL               (string  sr) := sr               in set_Accidents_FL               ;
	export SourceIsAccidents_ECrash           (string  sr) := sr               in set_Accidents_ECrash           ;
	export SourceIsAccidents_ECrash_CRU       (string  sr) := sr               in set_Accidents_ECrash_CRU       ;
	export SourceIsAccurint_Arrest_Log        (string  sr) := sr               in set_Accurint_Arrest_Log        ;
	export SourceIsAccurint_Crim_Court        (string  sr) := sr               in set_Accurint_Crim_Court        ;
	export SourceIsAccurint_DOC               (string  sr) := sr               in set_Accurint_DOC               ;
	export SourceIsAccurint_Sex_offender      (string  sr) := sr               in set_Accurint_Sex_offender      ;
	export SourceIsAccurint_Trade_Show        (string  sr) := sr               in set_Accurint_Trade_Show        ;
	export SourceIsACF                        (string  sr) := sr               in set_ACF                        ;
	export SourceIsAcquiredweb                (string  sr) := sr               in set_Acquiredweb                ;
  export SourceIs_advo_valassis	            (string  sr) := sr               in set_advo_valassis              ;
	export SourceIsAHA                        (string  sr) := sr               in set_AHA                        ;
	export SourceIsPOS                        (string  sr) := sr               in set_POS                        ;
	export SourceIsAircrafts                  (string  sr) := sr               in set_Aircrafts                  ;
	export SourceIsAirmen                     (string  sr) := sr               in set_Airmen                     ;
	export SourceIsAK_Busreg                  (string  sr) := sr               in set_AK_Busreg                  ;
	export SourceIsAK_Fishing_boats           (string  sr) := sr               in set_AK_Fishing_boats           ;
	export SourceIsAK_Perm_Fund               (string  sr) := sr               in set_AK_Perm_Fund               ;
	export SourceIsALC                        (string  sr) := sr               in set_ALC                        ;
	export SourceIsAmerican_Students_List     (string  sr) := sr               in set_American_Students_List     ;
	export SourceIsOKC_Students_List          (string  sr) := sr               in set_OKC_Students_List          ;
	export SourceIsAMIDIR                     (string  sr) := sr               in set_AMIDIR                     ;
	export SourceIsAMS                        (string  sr) := sr               in set_AMS                        ;
	export SourceIsAnchor																					(string		sr)	:= sr															in set_Anchor																					;
	export SourceIsATF                        (string  sr) := sr               in set_atf                        ;
	export SourceIsBair_Analytics             (string  sr) := sr               in set_Bair_Analytics             ;
	export SourceIsBankruptcy                 (string  sr) := sr               in set_bk                         ;
	export SourceIsBankruptcy_Attorney    		(string  sr) := sr               in set_Bankruptcy_Attorney        ;
	export SourceIsBankruptcy_Trustee     		(string  sr) := sr               in set_Bankruptcy_Trustee         ;
	export SourceIsBBB                        (string  sr) := sr               in set_BBB                        ;
	export SourceIsBBB_Member                 (string  sr) := sr               in set_BBB_Member                 ;
	export SourceIsBBB_Non_Member             (string  sr) := sr               in set_BBB_Non_Member             ;
	export SourceIsBrightVerify_email					(string	 sr) := sr							 in set_BrightVerify_email				 ;
	export SourceIsBusinessHeader             (string  sr) := sr               in set_business_header            ;
	export SourceIsBusiness_contacts          (string  sr) := sr               in set_Business_contacts          ;
	export SourceIsBusiness_Credit            (string  sr) := sr               in set_Business_Credit            ;
	export SourceIsBusiness_Registration      (string  sr) := sr               in set_Business_Registration      ;
	export SourceIsCalbus		                  (string  sr) := sr               in set_Calbus					           ;
	export SourceIsCellphones_Kroll		        (string  sr) := sr               in set_Cellphones_Kroll					 ;
	export SourceIsCellphones_Nextones	      (string  sr) := sr               in set_Cellphones_Nextones				 ;
	export SourceIsCellphones_Traffix	        (string  sr) := sr               in set_Cellphones_Traffix				 ;
	export SourceIsCertegy                    (string  sr) := sr               in set_Certegy                    ;
	export SourceIs_Consumer_Disclosure_feed                    (string  sr) := sr               in set_Consumer_Disclosure_feed                    ;
	export SourceIsCClue	                    (string  sr) := sr               in set_CClue 	                   ;
	export SourceIsCorrectional_Facilities    (string  sr) := sr               in set_Correctional_Facilities    ;
	export SourceIsCortera                    (string  sr) := sr               in set_Cortera                    ;
	export SourceIsCortera_Tradeline          (string  sr) := sr               = src_Cortera_Tradeline           ;
	export SourceIsFL_CH                      (string  sr) := sr               in set_FL_CH                      ;
	export SourceIsGA_CH                      (string  sr) := sr               in set_GA_CH                      ;
	export SourceIsPA_CH                      (string  sr) := sr               in set_PA_CH                      ;
	export SourceIsUT_CH                      (string  sr) := sr               in set_UT_CH                      ;
	export SourceIsClarity				            (string  sr) := sr               in set_Clarity					           ;
	export SourceIsCLIA		                    (string  sr) := sr               in set_CLIA		                   ;
	export SourceIsCNLD_Facilities            (string  sr) := sr               in set_CNLD_Facilities            ;
	export SourceIsCNLD_Practitioner          (string  sr) := sr               in set_CNLD_Practitioner          ;
	export SourceIsAK_Corporations            (string  sr) := sr               in set_AK_Corporations            ;
	export SourceIsAL_Corporations            (string  sr) := sr               in set_AL_Corporations            ;
	export SourceIsAR_Corporations            (string  sr) := sr               in set_AR_Corporations            ;
	export SourceIsAZ_Corporations            (string  sr) := sr               in set_AZ_Corporations            ;
	export SourceIsCA_Corporations            (string  sr) := sr               in set_CA_Corporations            ;
	export SourceIsCO_Corporations            (string  sr) := sr               in set_CO_Corporations            ;
	export SourceIsCT_Corporations            (string  sr) := sr               in set_CT_Corporations            ;
	export SourceIsDC_Corporations            (string  sr) := sr               in set_DC_Corporations            ;
	export SourceIsFL_Corporations            (string  sr) := sr               in set_FL_Corporations            ;
	export SourceIsGA_Corporations            (string  sr) := sr               in set_GA_Corporations            ;
	export SourceIsHI_Corporations            (string  sr) := sr               in set_HI_Corporations            ;
	export SourceIsIA_Corporations            (string  sr) := sr               in set_IA_Corporations            ;
	export SourceIsID_Corporations            (string  sr) := sr               in set_ID_Corporations            ;
	export SourceIsIL_Corporations            (string  sr) := sr               in set_IL_Corporations            ;
	export SourceIsIN_Corporations            (string  sr) := sr               in set_IN_Corporations            ;
	export SourceIsKS_Corporations            (string  sr) := sr               in set_KS_Corporations            ;
	export SourceIsKY_Corporations            (string  sr) := sr               in set_KY_Corporations            ;
	export SourceIsLA_Corporations            (string  sr) := sr               in set_LA_Corporations            ;
	export SourceIsMA_Corporations            (string  sr) := sr               in set_MA_Corporations            ;
	export SourceIsMD_Corporations            (string  sr) := sr               in set_MD_Corporations            ;
	export SourceIsME_Corporations            (string  sr) := sr               in set_ME_Corporations            ;
	export SourceIsMI_Corporations            (string  sr) := sr               in set_MI_Corporations            ;
	export SourceIsMN_Corporations            (string  sr) := sr               in set_MN_Corporations            ;
	export SourceIsMO_Corporations            (string  sr) := sr               in set_MO_Corporations            ;
	export SourceIsMS_Corporations            (string  sr) := sr               in set_MS_Corporations            ;
	export SourceIsMT_Corporations            (string  sr) := sr               in set_MT_Corporations            ;
	export SourceIsNC_Corporations            (string  sr) := sr               in set_NC_Corporations            ;
	export SourceIsND_Corporations            (string  sr) := sr               in set_ND_Corporations            ;
	export SourceIsNE_Corporations            (string  sr) := sr               in set_NE_Corporations            ;
	export SourceIsNH_Corporations            (string  sr) := sr               in set_NH_Corporations            ;
	export SourceIsNJ_Corporations            (string  sr) := sr               in set_NJ_Corporations            ;
	export SourceIsNM_Corporations            (string  sr) := sr               in set_NM_Corporations            ;
	export SourceIsNV_Corporations            (string  sr) := sr               in set_NV_Corporations            ;
	export SourceIsNY_Corporations            (string  sr) := sr               in set_NY_Corporations            ;
	export SourceIsOH_Corporations            (string  sr) := sr               in set_OH_Corporations            ;
	export SourceIsOK_Corporations            (string  sr) := sr               in set_OK_Corporations            ;
	export SourceIsOR_Corporations            (string  sr) := sr               in set_OR_Corporations            ;
	export SourceIsPA_Corporations            (string  sr) := sr               in set_PA_Corporations            ;
	export SourceIsRI_Corporations            (string  sr) := sr               in set_RI_Corporations            ;
	export SourceIsSC_Corporations            (string  sr) := sr               in set_SC_Corporations            ;
	export SourceIsSD_Corporations            (string  sr) := sr               in set_SD_Corporations            ;
	export SourceIsTN_Corporations            (string  sr) := sr               in set_TN_Corporations            ;
	export SourceIsTX_Corporations            (string  sr) := sr               in set_TX_Corporations            ;
	export SourceIsUT_Corporations            (string  sr) := sr               in set_UT_Corporations            ;
	export SourceIsVA_Corporations            (string  sr) := sr               in set_VA_Corporations            ;
	export SourceIsVT_Corporations            (string  sr) := sr               in set_VT_Corporations            ;
	export SourceIsWA_Corporations            (string  sr) := sr               in set_WA_Corporations            ;
	export SourceIsWI_Corporations            (string  sr) := sr               in set_WI_Corporations            ;
	export SourceIsWV_Corporations            (string  sr) := sr               in set_WV_Corporations            ;
	export SourceIsWV_Hist_Corporations       (string  sr) := sr               in set_WV_Hist_Corporations       ;
	export SourceIsWY_Corporations            (string  sr) := sr               in set_WY_Corporations            ;
	export SourceIsCorpV2                     (string  sr) := sr               in set_CorpV2                     ;
	export SourceIsCrashCarrier               (string  sr) := sr               in set_CrashCarrier               ;	
	export SourceIsCredit_Unions              (string  sr) := sr               in set_Credit_Unions              ;		
	export SourceIsCriminal_History           (string  sr) := sr               in set_Criminal_History           ;
	export SourceDatagence                    (string  sr) := sr               in set_Datagence;
	export SourceIsDCA                        (string  sr) := sr               in set_DCA                        ;
	export SourceIsDea                        (string  sr) := sr               in set_Dea                        ;
	export SourceIsDeath                      (string  sr) := sr               in set_Death                      ;
	export SourceIsDeath_Michigan             (string  sr) := sr               in set_Death_Michigan             ;
	export SourceIsDeath_Master               (string  sr) := sr               in set_Death_Master               ;
	export SourceIsDeath_Restricted           (string  sr) := sr               in set_Death_Restricted           ;
	export SourceIsDeath_State                (string  sr) := sr               in set_Death_State                ;
	export SourceIsDeath_Tributes             (string  sr) := sr               in set_Death_Tributes             ;
	export SourceIsDeath_CA			              (string  sr) := sr               in set_Death_CA			             ;
	export SourceIsDeath_CT			              (string  sr) := sr               in set_Death_CT			             ;
	export SourceIsDeath_FL			              (string  sr) := sr               in set_Death_FL			             ;
	export SourceIsDeath_GA			              (string  sr) := sr               in set_Death_GA			             ;
	export SourceIsDeath_KY			              (string  sr) := sr               in set_Death_KY			             ;
	export SourceIsDeath_MA			              (string  sr) := sr               in set_Death_MA			             ;
	export SourceIsDeath_ME			              (string  sr) := sr               in set_Death_ME			             ;
	export SourceIsDeath_MI			              (string  sr) := sr               in set_Death_MI			             ;
	export SourceIsDeath_MN			              (string  sr) := sr               in set_Death_MN			             ;
	export SourceIsDeath_MT			              (string  sr) := sr               in set_Death_MT			             ;
	export SourceIsDeath_NC			              (string  sr) := sr               in set_Death_NC			             ;
	export SourceIsDeath_NV			              (string  sr) := sr               in set_Death_NV			             ;
	export SourceIsDeath_OH			              (string  sr) := sr               in set_Death_OH			             ;
	export SourceIsDeath_VA			              (string  sr) := sr               in set_Death_VA			             ;
	export SourceIsDebt_Settlement            (string  sr) := sr               in set_Debt_Settlement		         ;
	export SourceIsDirectDL                   (string  sr) := sr               in set_direct_dl                  ;
	export SourceIsDirectVehicle              (string  sr) := sr               in set_direct_vehicles            ;
	export SourceIsDiversity_Cert             (string  sr) := sr               in set_Diversity_Cert;
	export SourceIsDivorce			              (string  sr) := sr               in set_Divorce				             ;
	export SourceIsDL                         (string  sr) := sr               in set_dl                         ;
	export SourceIsCT_DL                      (string  sr) := sr               in set_CT_DL                      ;
	export SourceIsFL_DL                      (string  sr) := sr               in set_FL_DL                      ;
	export SourceIsIA_DL                      (string  sr) := sr               in set_IA_DL                      ;
	export SourceIsID_DL                      (string  sr) := sr               in set_ID_DL                      ;
	export SourceIsKY_DL                      (string  sr) := sr               in set_KY_DL                      ;
	export SourceIsMA_DL                      (string  sr) := sr               in set_MA_DL                      ;
	export SourceIsME_DL                      (string  sr) := sr               in set_ME_DL                      ;
	export SourceIsMI_DL                      (string  sr) := sr               in set_MI_DL                      ;
	export SourceIsMN_DL                      (string  sr) := sr               in set_MN_DL                      ;
	export SourceIsMO_DL                      (string  sr) := sr               in set_MO_DL                      ;
	export SourceIsNC_DL                      (string  sr) := sr               in set_NC_DL                      ;
	export SourceIsNE_DL                      (string  sr) := sr               in set_NE_DL                      ;
	export SourceIsNM_DL                      (string  sr) := sr               in set_NM_DL                      ;
	export SourceIsNV_DL                      (string  sr) := sr               in set_NV_DL                      ;
	export SourceIsLA_DL                      (string  sr) := sr               in set_LA_DL                      ;
	export SourceIsOH_DL                      (string  sr) := sr               in set_OH_DL                      ;
	export SourceIsOR_DL                      (string  sr) := sr               in set_OR_DL                      ;
	export SourceIsTN_DL                      (string  sr) := sr               in set_TN_DL                      ;
	export SourceIsTX_DL                      (string  sr) := sr               in set_TX_DL                      ;
	export SourceIsUT_DL                      (string  sr) := sr               in set_UT_DL                      ;
	export SourceIsWI_DL                      (string  sr) := sr               in set_WI_DL                      ;
	export SourceIsWV_DL                      (string  sr) := sr               in set_WV_DL                      ;
	export SourceIsWY_DL                      (string  sr) := sr               in set_WY_DL                      ;
	export SourceIsCO_Experian_DL             (string  sr) := sr               in set_CO_Experian_DL             ;
	export SourceIsDE_Experian_DL             (string  sr) := sr               in set_DE_Experian_DL             ;
	export SourceIsID_Experian_DL             (string  sr) := sr               in set_ID_Experian_DL             ;
	export SourceIsIL_Experian_DL             (string  sr) := sr               in set_IL_Experian_DL             ;
	export SourceIsKY_Experian_DL             (string  sr) := sr               in set_KY_Experian_DL             ;
	export SourceIsLA_Experian_DL             (string  sr) := sr               in set_LA_Experian_DL             ;
	export SourceIsMD_Experian_DL             (string  sr) := sr               in set_MD_Experian_DL             ;
	export SourceIsMS_Experian_DL             (string  sr) := sr               in set_MS_Experian_DL             ;
	export SourceIsND_Experian_DL             (string  sr) := sr               in set_ND_Experian_DL             ;
	export SourceIsNH_Experian_DL             (string  sr) := sr               in set_NH_Experian_DL             ;
	export SourceIsSC_Experian_DL             (string  sr) := sr               in set_SC_Experian_DL             ;
	export SourceIsWV_Experian_DL             (string  sr) := sr               in set_WV_Experian_DL             ;
	export SourceIsDMVRestricted              (string  sr) := sr               in set_DMV_restricted             ;
	export SourceIsDPPA                       (string2 sr) := SourceGroup(sr)  in set_DPPA                       ;
	export SourceIsDummy_Records              (string  sr) := sr               in set_Dummy_Records              ;
	export SourceIsDunn_Bradstreet            (string  sr) := sr               in set_Dunn_Bradstreet            ;
	export SourceIsDunn_Bradstreet_Fein       (string  sr) := sr               in set_Dunn_Bradstreet_Fein       ;
	export SourceIsDunndata_Consumer          (string  sr) := sr               in set_Dunndata_Consumer          ;
	export SourceIsDunn_Data_Email			      (string  sr) := sr               in set_Dunn_Data_Email			       ;
	export SourceIsEBR                        (string  sr) := sr               in set_EBR                        ;
	export SourceIsEdgar                      (string  sr) := sr               in set_Edgar                      ;
	export SourceIsEmedon                     (string  sr) := sr               in set_Emdeon                     ;
	export SourceIsEmail								      (string  sr) := sr               in set_Email								       ;
	export SourceIsEmerges                    (string  sr) := sr               in set_Emerges                    ;
	export SourceIsEMerge_Boat                (string  sr) := sr               in set_EMerge_Boat                ;
	export SourceIsEMerge_CCW                 (string  sr) := sr               in set_EMerge_CCW                 ;
	export SourceIsEMerge_CCW_NY                 (string  sr) := sr               in set_EMerge_CCW_NY                 ;
	export SourceIsEMerge_Cens                (string  sr) := sr               in set_EMerge_Cens                ;
	export SourceIsEMerge_Fish                (string  sr) := sr               in set_EMerge_Fish                ;
	export SourceIsEMerge_Hunt                (string  sr) := sr               in set_EMerge_Hunt                ;
	export SourceIsEMerge_Master              (string  sr) := sr               in set_EMerge_Master              ;
	export SourceIsEmployee_Directories       (string  sr) := sr               in set_Employee_Directories       ;
	export SourceIsEnclarity									(string  sr) := sr							 in set_Enclarity									 ;
	export SourceIsEntiera                    (string  sr) := sr               in set_Entiera                    ;
	export SourceIsEquifax                    (string  sr) := sr               in set_Equifax                    ;
	export SourceIsEquifax_Business_Data      (string  sr) := sr               in set_Equifax_Business_Data      ;
	export SourceIsEquifax_Direct             (string  sr) := sr               in set_Equifax_Direct             ;
	export SourceIsEquifax_Quick              (string  sr) := sr               in set_Equifax_Quick              ;
	export SourceIsEquifax_Weekly             (string  sr) := sr               in set_Equifax_Weekly             ;
	export SourceIsEq_Employer                (string  sr) := sr               in set_Eq_Employer                ;
	export SourceIsExperianDL                 (string  sr) := sr               in set_experian_dl                ;
	export SourceIsExperianVehicle            (string  sr) := sr               in set_experian_vehicles          ;
	export SourceIsExperian_CRDB              (string  sr) := sr               in set_Experian_CRDB              ;	
	export SourceIsExperian_Credit_Header     (string  sr) := sr               in set_Experian_Credit_Header     ;	
	export SourceIsExperian_FEIN              (string  sr) := sr               in set_Experian_FEIN              ;
	export SourceIsExperian_FEIN_Rest         (string  sr) := sr               in set_Experian_FEIN_Rest         ;
	export SourceIsExperian_FEIN_Unrest       (string  sr) := sr               in set_Experian_FEIN_Unrest       ;	
	export SourceIsExperian_Phones            (string  sr) := sr               in set_Experian_Phones            ;
	export SourceIsFAA                        (string  sr) := sr               in set_FAA                        ;
	export SourceIsFares_Deeds_from_Asrs      (string  sr) := sr               in set_Fares_Deeds_from_Asrs      ;
	export SourceIsFBNV2                      (string  sr) := sr               in set_fbnv2                      ;
	export SourceIsFBNV2_CA_Orange_county     (string  sr) := sr               in set_FBNV2_CA_Orange_county     ;
	export SourceIsFBNV2_CA_Santa_Clara       (string  sr) := sr               in set_FBNV2_CA_Santa_Clara       ;
	export SourceIsFBNV2_CA_San_Bernadino     (string  sr) := sr               in set_FBNV2_CA_San_Bernadino     ;
	export SourceIsFBNV2_CA_San_Diego         (string  sr) := sr               in set_FBNV2_CA_San_Diego         ;
	export SourceIsFBNV2_CA_Ventura           (string  sr) := sr               in set_FBNV2_CA_Ventura           ;
	export SourceIsFBNV2_Experian_Direct      (string  sr) := sr               in set_FBNV2_Experian_Direct      ;
	export SourceIsFBNV2_FL                   (string  sr) := sr               in set_FBNV2_FL                   ;
	export SourceIsFBNV2_Hist_Choicepoint     (string  sr) := sr               in set_FBNV2_Hist_Choicepoint     ;
	export SourceIsFBNV2_INF                  (string  sr) := sr               in set_FBNV2_INF                  ;
	export SourceIsFBNV2_New_York             (string  sr) := sr               in set_FBNV2_New_York             ;
	export SourceIsFBNV2_TX_Dallas            (string  sr) := sr               in set_FBNV2_TX_Dallas            ;
	export SourceIsFBNV2_TX_Harris            (string  sr) := sr               in set_FBNV2_TX_Harris            ;
	export SourceIsFBNV2_BusReg						    (string  sr) := sr               in set_FBNV2_BusReg					     ;
	export SourceIsFCC_Radio_Licenses         (string  sr) := sr               in set_FCC_Radio_Licenses         ;
	export SourceIsFCRA                       (string2 sr) := SourceGroup(sr)  in set_FCRA                       ;
	export SourceIsFCRA_Corrections_record    (string  sr) := sr               in set_FCRA_Corrections_record    ;
	export SourceIsFDIC                       (string  sr) := sr               in set_FDIC                       ;
	export SourceIsFDIC_SOD                   (string  sr) := sr               in set_FDIC_SOD                   ;
	export SourceIsFederal_Explosives         (string  sr) := sr               in set_Federal_Explosives         ;
	export SourceIsFederal_Firearms           (string  sr) := sr               in set_Federal_Firearms           ;
	export SourceIsFL_FBN                     (string  sr) := sr               in set_FL_FBN                     ;
	export SourceIsFL_Non_Profit              (string  sr) := sr               in set_FL_Non_Profit              ;
	export SourceIsForeclosures               (string  sr) := sr               in set_Foreclosures               ;
	export SourceIsForeclosures_Delinquent    (string  sr) := sr               in set_Foreclosures_Delinquent    ;
	export SourceIsFrandx										  (string  sr) := sr               in set_Frandx									   ;
	export SourceIsNJ_Gaming_Licenses         (string  sr) := sr               in set_NJ_Gaming_Licenses         ;
	export SourceIsGarnishments               (string2 sr) := sr               in set_Garnishments               ;
	export SourceIsGLB                        (string2 sr) := sr               in set_GLB                        ;
	export SourceIsGong                       (string  sr) := sr               in set_Gong                       ;
	export SourceIsGong_Business              (string  sr) := sr               in set_Gong_Business              ;
	export SourceIsGong_Government            (string  sr) := sr               in set_Gong_Government            ;
	export SourceIsGong_History               (string  sr) := sr               in set_Gong_History               ;
	export SourceIsGong_phone_append          (string  sr) := sr               in set_Gong_phone_append          ;
	export SourceIsGSA                        (string  sr) := sr               in set_GSA                        ;
	export SourceIsGSDD                       (string  sr) := sr               in set_GSDD                       ;
	export SourceIsHMS_PM											(string  sr) := sr							 in set_HMS_PM										 ;
	export SourceIsHXMX												(string  sr) := sr							 in set_HXMX											 ;
	export SourceIsIbehavior                  (string  sr) := sr               in set_Ibehavior                  ;
	export SourceIsImpulse                    (string  sr) := sr               in set_Impulse                    ;
	export SourceIsInfogroup                  (string  sr) := sr               in set_Infogroup                  ;
	export SourceIsInfousa                    (string  sr) := sr               in set_Infousa                    ;
	export SourceIsINFOUSA_ABIUS_USABIZ       (string  sr) := sr               in set_INFOUSA_ABIUS_USABIZ       ;
	export SourceIsINFOUSA_DEAD_COMPANIES     (string  sr) := sr               in set_INFOUSA_DEAD_COMPANIES     ;
	export SourceIsINFOUSA_IDEXEC             (string  sr) := sr               in set_INFOUSA_IDEXEC             ;
	export SourceIsInfutor_NARB               (string  sr) := sr               in set_Infutor_NARB               ;
	export SourceIsInfutorCID                 (string  sr) := sr               in set_InfutorCID 								 ;
	export SourceIsInfutorNARC                (string  sr) := sr               in set_InfutorNarc								 ;
  export SourceIsInfutorNARC3               (string  sr) := sr               in set_infutor_narc3              ;
	export SourceIsInfutorNARE								(string	 sr) := sr							 in set_InfutorNare                ;
	export SourceIsIngenix_Sanctions          (string  sr) := sr               in set_Ingenix_Sanctions          ;
	export SourceIsInquiryAcclogs             (string  sr) := sr               in set_InquiryAcclogs             ;
  export SourceIsInsurance_Certification    (string  sr) := sr               in set_Insurance_Certification    ;		
	export SourceIsIntrado 			      				(string  sr) := sr               in set_Intrado										 ;
	export SourceIsIRS_5500                   (string  sr) := sr               in set_IRS_5500                   ;
	export SourceIsIRS_Non_Profit             (string  sr) := sr               in set_IRS_Non_Profit             ;
	export SourceIsJigsaw                     (string  sr) := sr               in set_Jigsaw                     ;
  export SourceIsLaborActions_EBSA          (string  sr) := sr               in set_LaborActions_EBSA          ;	
  export SourceIsLaborActions_WHD           (string  sr) := sr               in set_LaborActions_WHD           ;	
	export SourceIsLexis_Trans_Union          (string  sr) := sr               in set_Lexis_Trans_Union          ;
	export SourceIsLiens                      (string  sr) := sr               in set_liens                      ;
	export SourceIsLiensV1                    (string  sr) := sr               in set_LiensV1                    ;
	export SourceIsLiens_and_Judgments        (string  sr) := sr               in set_Liens_and_Judgments        ;
	export SourceIsLiens_v2                   (string  sr) := sr               in set_Liens_v2                   ;
	export SourceIsLiens_v2_CA_Federal        (string  sr) := sr               in set_Liens_v2_CA_Federal        ;
	export SourceIsLiens_v2_Chicago_Law       (string  sr) := sr               in set_Liens_v2_Chicago_Law       ;
	export SourceIsLiens_v2_Hogan             (string  sr) := sr               in set_Liens_v2_Hogan             ;
	export SourceIsLiens_v2_ILFDLN            (string  sr) := sr               in set_Liens_v2_ILFDLN            ;
	export SourceIsLiens_v2_MA                (string  sr) := sr               in set_Liens_v2_MA                ;
	export SourceIsLiens_v2_NYC               (string  sr) := sr               in set_Liens_v2_NYC               ;
	export SourceIsLiens_v2_NYFDLN            (string  sr) := sr               in set_Liens_v2_NYFDLN            ;
	export SourceIsLiens_v2_Service_Abstract  (string  sr) := sr               in set_Liens_v2_Service_Abstract  ;
	export SourceIsLiens_v2_Superior_Party    (string  sr) := sr               in set_Liens_v2_Superior_Party    ;
	export SourceIsLink2tek										(string  sr) := sr							 in set_Link2tek									 ;
	export SourceIsLiquor_Licenses            (string  sr) := sr               in set_Liquor_Licenses            ;
	export SourceIsCA_Liquor_Licenses         (string  sr) := sr               in set_CA_Liquor_Licenses         ;
	export SourceIsCT_Liquor_Licenses         (string  sr) := sr               in set_CT_Liquor_Licenses         ;
	export SourceIsIN_Liquor_Licenses         (string  sr) := sr               in set_IN_Liquor_Licenses         ;
	export SourceIsLA_Liquor_Licenses         (string  sr) := sr               in set_LA_Liquor_Licenses         ;
	export SourceIsOH_Liquor_Licenses         (string  sr) := sr               in set_OH_Liquor_Licenses         ;
	export SourceIsPA_Liquor_Licenses         (string  sr) := sr               in set_PA_Liquor_Licenses         ;
	export SourceIsTX_Liquor_Licenses         (string  sr) := sr               in set_TX_Liquor_Licenses         ;
	export SourceIsLnPropertyV2               (string  sr) := sr               in set_lnpropertyV2               ;
	export SourceIsLnPropV2_Fares_Asrs        (string  sr) := sr               in set_LnPropV2_Fares_Asrs        ;
	export SourceIsLnPropV2_Fares_Deeds       (string  sr) := sr               in set_LnPropV2_Fares_Deeds       ;
	export SourceIsLnPropV2_Lexis_Asrs        (string  sr) := sr               in set_LnPropV2_Lexis_Asrs        ;
	export SourceIsLnPropV2_Lexis_Deeds_Mtgs  (string  sr) := sr               in set_LnPropV2_Lexis_Deeds_Mtgs  ;
	export SourceIsLobbyists                  (string  sr) := sr               in set_Lobbyists                  ;
	export SourceIsMari_Prof_Lic              (string  sr) := sr               in set_Mari_Prof_Lic              ;
	export SourceIsMari_Public_Sanc           (string  sr) := sr               in set_Mari_Public_Sanc           ;
	export SourceIsMarriage			              (string  sr) := sr               in set_Marriage			             ;
	export SourceIsMarDiv				              (string  sr) := sr               in set_Marriage_Divorce           ;
	export SourceIsMartinDale_Hubbell         (string  sr) := sr               in set_MartinDale_Hubbell         ;
	export SourceIsMediaOne			              (string  sr) := sr               in set_MediaOne                   ;
	export SourceIsMiscellaneous              (string  sr) := sr               in set_Miscellaneous              ;
	export SourceIsMixed_DPPA                 (string  sr) := sr               in set_Mixed_DPPA                 ;
	export SourceIsMixed_Non_DPPA             (string  sr) := sr               in set_Mixed_Non_DPPA             ;
	export SourceIsMixed_Probation            (string  sr) := sr               in set_Mixed_Probation            ;
	export SourceIsMixed_Utilities            (string  sr) := sr               in set_Mixed_Utilities            ;
	export SourceIsMMCP						            (string  sr) := sr               in set_MMCP						           ;
  export SourceIsNaturalDisaster_Readiness  (string  sr) := sr               in set_NaturalDisaster_Readiness  ;
	export SourceIsNCOA                       (string  sr) := sr               in set_NCOA                       ;
	export SourceIsNCPDP                      (string  sr) := sr               in set_NCPDP                      ;
	export SourceIsNPPES                      (string  sr) := sr               in set_NPPES                      ;
	export SourceIsNonUpdatingSrc             (string  sr) := sr               in set_NonUpdatingSrc             ;
	export SourceIsOIG                        (string  sr) := sr               in set_OIG           	           ;
  export SourceIsOKC_Probate                (string  sr) := sr               in set_OKC_Probate		             ;	
	export SourceIsOne_Click_Data             (string  sr) := sr               in set_One_Click_Data	           ;
	export SourceIsOKC_Student_List           (string  sr) := sr               in set_OKC_Student_List           ;
	#if(_Control.ThisEnvironment.IsPlatformThor = true)
		export SourceIsOnProbation                (string  sr) := SourceGroup(sr)  in set_Probation                ;
	#else
		export SourceIsOnProbation                (string  sr) := codes.KeyCodes('HEADER_MASTER_V5','PROBATION',,sr)<>'';
	#end
	export SourceIsOSHAIR                     (string  sr) := sr               in set_OSHAIR                     ;
	export SourceIsOutwardMedia			          (string  sr) := sr               in set_OutwardMedia               ;
	export SourceIsPaw                        (string  sr) := sr               in set_paw                        ;
	export SourceIsPBSA                       (string  sr) := sr               in set_PBSA                       ;
	export SourceIsPcnsr			      					(string  sr) := sr               in set_Pcnsr											 ;
	export SourceIsPeopleHeader               (string  sr) := sr               in set_header                     ;
	export SourceIsPhones_Plus                (string  sr) := sr               in set_Phones_Plus                ;
	export SourceIsProlic  								    (string  sr) := sr               in set_Prolic								     ;
	export SourceIsProfessional_License       (string  sr) := sr               in set_Professional_License       ;
	export SourceIsProperty                   (string  sr) := sr               in set_property                   ;
	export SourceIsPSS									      (string  sr) := sr               in set_PSS 	                     ;
	export	SourceIsRealSource																	(string		sr)	:= sr															in set_RealSource																	;
	export SourceIsRedbooks                   (string  sr) := sr               in set_Redbooks                   ;
	export SourceIsSalesChannel		            (string  sr) := sr               in set_SalesChannel		           ;
	export SourceIsCA_Sales_Tax               (string  sr) := sr               in set_CA_Sales_Tax               ;
	export SourceIsIA_Sales_Tax               (string  sr) := sr               in set_IA_Sales_Tax               ;
	export SourceIsState_Sales_Tax            (string  sr) := sr               in set_State_Sales_Tax            ;
	export SourceIsSDA                        (string  sr) := sr               in set_SDA                        ;
	export SourceIsSDAA                       (string  sr) := sr               in set_SDAA                       ;
	export SourceIsSEC_Broker_Dealer          (string  sr) := sr               in set_SEC_Broker_Dealer          ;
  export SourceIsSexoffender                (string  sr) := sr               in set_sexoffender               ;	
	export SourceIsSex_Offender               (string  sr) := sr               in set_Sex_Offender               ;
	export SourceIsFL_SO                      (string  sr) := sr               in set_FL_SO                      ;
	export SourceIsGA_SO                      (string  sr) := sr               in set_GA_SO                      ;
	export SourceIsMI_SO                      (string  sr) := sr               in set_MI_SO                      ;
	export SourceIsPA_SO                      (string  sr) := sr               in set_PA_SO                      ;
	export SourceIsUT_SO                      (string  sr) := sr               in set_UT_SO                      ;
	export SourceIsSheila_Greco               (string  sr) := sr               in set_Sheila_Greco               ;
	export SourceIsSIM                        (string  sr) := sr               in set_SIM                        ;
	export SourceIsSKA                        (string  sr) := sr               in set_SKA                        ;
	export SourceIsSpoke                      (string  sr) := sr               in set_Spoke                      ;
	export SourceIsSymphony										(string  sr) := sr							 in set_Symphony									 ;
	export SourceIsTargus_White_pages         (string  sr) := sr               in set_Targus_White_pages         ;
	export SourceIsTax_practitioner           (string  sr) := sr               in set_Tax_practitioner           ;
	export SourceIsTCOA                       (string  sr) := sr               in set_TCOA                       ;
	export SourceIsTCOA_After_Address         (string  sr) := sr               in set_TCOA_After_Address         ;
	export SourceIsTCOA_Before_Address        (string  sr) := sr               in set_TCOA_Before_Address        ;
	export SourceIsTeletrack                  (string  sr) := sr               in set_teletrack                  ;
	export SourceIsThrive_LT                  (string  sr) := sr               in set_Thrive_LT                  ;
	export SourceIsThrive_LT_POE_Email        (string  sr) := sr               in set_Thrive_LT_POE_Email        ;
	export SourceIsThrive_PD                  (string  sr) := sr               in set_Thrive_PD                  ;
	export SourceIsThrive_PD_POE_Email        (string  sr) := sr               in set_Thrive_PD_POE_Email        ;
	export SourceIsTransUnion                 (string  sr) := sr               in set_transunion                 ;
	export SourceIsTransUnion_Direct          (string  sr) := sr               in set_TransUnion_Direct          ;
	export SourceIsTransUnion_Credit_Header   (string  sr) := sr               in set_TransUnion_Credit_Header   ;
	export SourceIsTUCS_Ptrack                (string  sr) := sr               in set_TUCS_Ptrack                ;
	export SourceIsTXBUS                      (string  sr) := sr               in set_TXBUS                      ;
	export SourceIsUCC                        (string  sr) := sr               in set_UCC                        ;
	export SourceIsUCCS                       (string  sr) := sr               in set_UCCS                       ;
	export SourceIsUCCV2                      (string  sr) := sr               in set_UCCV2                      ;
	export SourceIsUCCV2_WA_Hist              (string  sr) := sr               in set_UCCV2_WA_Hist              ;
	export SourceIsUS_Coastguard              (string  sr) := sr               in set_US_Coastguard              ;
	export SourceIsUtilities                  (string  sr) := sr               in set_Utilities                  ;
	export SourceIsUtilNoWorkPH               (string  sr) := sr               in set_Util_noWorkPH              ;
	export SourceIsUtilWorkPH                 (string  sr) := sr               in set_Util_WorkPH                ;
	export SourceIsUtility                    (string  sr) := SourceGroup(sr)  =  str_Utility                    ;
	export SourceIsUtil_Work_Phone            (string  sr) := sr               in set_Util_Work_Phone            ;
	export SourceIsFL_Veh                     (string  sr) := sr               in set_FL_Veh                     ;
	export SourceIsID_Veh                     (string  sr) := sr               in set_ID_Veh                     ;
	export SourceIsKY_Veh                     (string  sr) := sr               in set_KY_Veh                     ;
	export SourceIsMA_Veh                     (string  sr) := sr               in set_MA_Veh                     ;
	export SourceIsME_Veh                     (string  sr) := sr               in set_ME_Veh                     ;
	export SourceIsMN_Veh                     (string  sr) := sr               in set_MN_Veh                     ;
	export SourceIsMO_Veh                     (string  sr) := sr               in set_MO_Veh                     ;
	export SourceIsMS_Veh                     (string  sr) := sr               in set_MS_Veh                     ;
	export SourceIsMT_Veh                     (string  sr) := sr               in set_MT_Veh                     ;
	export SourceIsNC_Veh                     (string  sr) := sr               in set_NC_Veh                     ;
	export SourceIsND_Veh                     (string  sr) := sr               in set_ND_Veh                     ;
	export SourceIsNE_Veh                     (string  sr) := sr               in set_NE_Veh                     ;
	export SourceIsNM_Veh                     (string  sr) := sr               in set_NM_Veh                     ;
	export SourceIsNV_Veh                     (string  sr) := sr               in set_NV_Veh                     ;
	export SourceIsOH_Veh                     (string  sr) := sr               in set_OH_Veh                     ;
	export SourceIsTX_Veh                     (string  sr) := sr               in set_TX_Veh                     ;
	export SourceIsUT_Veh                     (string  sr) := sr               in set_UT_Veh                     ;
	export SourceIsWI_Veh                     (string  sr) := sr               in set_WI_Veh                     ;
	export SourceIsWY_Veh                     (string  sr) := sr               in set_WY_Veh                     ;
	export SourceIsVehicle                    (string  sr) := sr               in set_vehicles                   ;
	export SourceIsAK_Experian_Veh            (string  sr) := sr               in set_AK_Experian_Veh            ;
	export SourceIsAL_Experian_Veh            (string  sr) := sr               in set_AL_Experian_Veh            ;
	export SourceIsAR_Experian_Veh            (string  sr) := sr               in set_AR_Experian_Veh            ;	//DF16817
	export SourceIsAZ_Experian_Veh            (string  sr) := sr               in set_AZ_Experian_Veh            ;	//DF16817
	export SourceIsCO_Experian_Veh            (string  sr) := sr               in set_CO_Experian_Veh            ;
	export SourceIsCT_Experian_Veh            (string  sr) := sr               in set_CT_Experian_Veh            ;
	export SourceIsDC_Experian_Veh            (string  sr) := sr               in set_DC_Experian_Veh            ;
	export SourceIsDE_Experian_Veh            (string  sr) := sr               in set_DE_Experian_Veh            ;
	export SourceIsFL_Experian_Veh            (string  sr) := sr               in set_FL_Experian_Veh            ;
	export SourceIsGA_Experian_Veh            (string  sr) := sr               in set_GA_Experian_Veh            ;	//DF16817
	export SourceIsIA_Experian_Veh            (string  sr) := sr               in set_IA_Experian_Veh            ;	//DF16817
	export SourceIsID_Experian_Veh            (string  sr) := sr               in set_ID_Experian_Veh            ;
	export SourceIsIL_Experian_Veh            (string  sr) := sr               in set_IL_Experian_Veh            ;
	export SourceIsKS_Experian_Veh            (string  sr) := sr               in set_KS_Experian_Veh            ;	//DF16817
	export SourceIsKY_Experian_Veh            (string  sr) := sr               in set_KY_Experian_Veh            ;
	export SourceIsLA_Experian_Veh            (string  sr) := sr               in set_LA_Experian_Veh            ;
	export SourceIsMA_Experian_Veh            (string  sr) := sr               in set_MA_Experian_Veh            ;
	export SourceIsMD_Experian_Veh            (string  sr) := sr               in set_MD_Experian_Veh            ;
	export SourceIsME_Experian_Veh            (string  sr) := sr               in set_ME_Experian_Veh            ;
	export SourceIsMI_Experian_Veh            (string  sr) := sr               in set_MI_Experian_Veh            ;
	export SourceIsMN_Experian_Veh            (string  sr) := sr               in set_MN_Experian_Veh            ;
	export SourceIsMO_Experian_Veh            (string  sr) := sr               in set_MO_Experian_Veh            ;
	export SourceIsMS_Experian_Veh            (string  sr) := sr               in set_MS_Experian_Veh            ;
	export SourceIsMT_Experian_Veh            (string  sr) := sr               in set_MT_Experian_Veh            ;
	export SourceIsNC_Experian_Veh            (string  sr) := sr               in set_NC_Experian_Veh            ;	//DF16817
	export SourceIsND_Experian_Veh            (string  sr) := sr               in set_ND_Experian_Veh            ;
	export SourceIsNE_Experian_Veh            (string  sr) := sr               in set_NE_Experian_Veh            ;
	export SourceIsNM_Experian_Veh            (string  sr) := sr               in set_NM_Experian_Veh            ;
	export SourceIsNV_Experian_Veh            (string  sr) := sr               in set_NV_Experian_Veh            ;
	export SourceIsNY_Experian_Veh            (string  sr) := sr               in set_NY_Experian_Veh            ;
	export SourceIsOH_Experian_Veh            (string  sr) := sr               in set_OH_Experian_Veh            ;
	export SourceIsOK_Experian_Veh            (string  sr) := sr               in set_OK_Experian_Veh            ;
	export SourceIsOR_Experian_Veh            (string  sr) := sr               in set_OR_Experian_Veh            ;
	export SourceIsRI_Experian_Veh            (string  sr) := sr               in set_RI_Experian_Veh            ;	//DF16817
	export SourceIsSC_Experian_Veh            (string  sr) := sr               in set_SC_Experian_Veh            ;
	export SourceIsSD_Experian_Veh            (string  sr) := sr               in set_SD_Experian_Veh            ;	//DF16817
	export SourceIsTN_Experian_Veh            (string  sr) := sr               in set_TN_Experian_Veh            ;
	export SourceIsTX_Experian_Veh            (string  sr) := sr               in set_TX_Experian_Veh            ;
	export SourceIsUT_Experian_Veh            (string  sr) := sr               in set_UT_Experian_Veh            ;
	export SourceIsVT_Experian_Veh            (string  sr) := sr               in set_VT_Experian_Veh            ;	//DF16817
	export SourceIsWA_Experian_Veh            (string  sr) := sr               in set_WA_Experian_Veh            ;	//DF16817
	export SourceIsWI_Experian_Veh            (string  sr) := sr               in set_WI_Experian_Veh            ;
	export SourceIsWY_Experian_Veh            (string  sr) := sr               in set_WY_Experian_Veh            ;
	export SourceIsInfutor_Veh                (string  sr) := sr               in set_Infutor_Veh 		           ;
	export SourceIsInfutor_Motorcycle_Veh  		(string  sr) := sr               in set_Infutor_Motorcycle_Veh 		 ;
	export SourceIsInfutor_All_Veh  		      (string  sr) := sr               in set_Infutor_All_Veh 		       ;
	export SourceIsVickers                    (string  sr) := sr               in set_Vickers                    ;
	export SourceIsVoters_v2                  (string  sr) := sr               in set_Voters_v2                  ;
	export SourceIsAK_Watercraft              (string  sr) := sr               in set_AK_Watercraft              ;
	export SourceIsAL_Watercraft              (string  sr) := sr               in set_AL_Watercraft              ;
	export SourceIsAR_Watercraft              (string  sr) := sr               in set_AR_Watercraft              ;
	export SourceIsAZ_Watercraft              (string  sr) := sr               in set_AZ_Watercraft              ;
	export SourceIsCO_Watercraft              (string  sr) := sr               in set_CO_Watercraft              ;
	export SourceIsCT_Watercraft              (string  sr) := sr               in set_CT_Watercraft              ;
	export SourceIsFL_Watercraft              (string  sr) := sr               in set_FL_Watercraft              ;
	export SourceIsGA_Watercraft              (string  sr) := sr               in set_GA_Watercraft              ;
	export SourceIsIA_Watercraft              (string  sr) := sr               in set_IA_Watercraft              ;
	export SourceIsIL_Watercraft              (string  sr) := sr               in set_IL_Watercraft              ;
	export SourceIsKS_Watercraft              (string  sr) := sr               in set_KS_Watercraft              ;
	export SourceIsKY_Watercraft              (string  sr) := sr               in set_KY_Watercraft              ;
	export SourceIsMA_Watercraft              (string  sr) := sr               in set_MA_Watercraft              ;
	export SourceIsMD_Watercraft              (string  sr) := sr               in set_MD_Watercraft              ;
	export SourceIsME_Watercraft              (string  sr) := sr               in set_ME_Watercraft              ;
	export SourceIsMI_Watercraft              (string  sr) := sr               in set_MI_Watercraft              ;
	export SourceIsMN_Watercraft              (string  sr) := sr               in set_MN_Watercraft              ;
	export SourceIsMO_Watercraft              (string  sr) := sr               in set_MO_Watercraft              ;
	export SourceIsMS_Watercraft              (string  sr) := sr               in set_MS_Watercraft              ;
	export SourceIsMT_Watercraft              (string  sr) := sr               in set_MT_Watercraft              ;
	export SourceIsNC_Watercraft              (string  sr) := sr               in set_NC_Watercraft              ;
	export SourceIsND_Watercraft              (string  sr) := sr               in set_ND_Watercraft              ;
	export SourceIsNE_Watercraft              (string  sr) := sr               in set_NE_Watercraft              ;
	export SourceIsNH_Watercraft              (string  sr) := sr               in set_NH_Watercraft              ;
	export SourceIsNM_Watercraft              (string  sr) := sr               in set_NM_Watercraft              ;
	export SourceIsNV_Watercraft              (string  sr) := sr               in set_NV_Watercraft              ;
	export SourceIsNY_Watercraft              (string  sr) := sr               in set_NY_Watercraft              ;
	export SourceIsOH_Watercraft              (string  sr) := sr               in set_OH_Watercraft              ;
	export SourceIsOR_Watercraft              (string  sr) := sr               in set_OR_Watercraft              ;
	export SourceIsSC_Watercraft              (string  sr) := sr               in set_SC_Watercraft              ;
	export SourceIsTN_Watercraft              (string  sr) := sr               in set_TN_Watercraft              ;
	export SourceIsTX_Watercraft              (string  sr) := sr               in set_TX_Watercraft              ;
	export SourceIsUT_Watercraft              (string  sr) := sr               in set_UT_Watercraft              ;
	export SourceIsVA_Watercraft              (string  sr) := sr               in set_VA_Watercraft              ;
	export SourceIsWI_Watercraft              (string  sr) := sr               in set_WI_Watercraft              ;
	export SourceIsWV_Watercraft              (string  sr) := sr               in set_WV_Watercraft              ;
	export SourceIsWY_Watercraft              (string  sr) := sr               in set_WY_Watercraft              ;
	export SourceIsFL_Watercraft_LN           (string  sr) := sr               in set_FL_Watercraft_LN           ;
	export SourceIsKY_Watercraft_LN           (string  sr) := sr               in set_KY_Watercraft_LN           ;
	export SourceIsMO_Watercraft_LN           (string  sr) := sr               in set_MO_Watercraft_LN           ;
	export SourceIsInfutor_Watercraft				  (string	 sr) := sr							 in set_Infutor_Watercraft				 ;
	export SourceIsWC                         (string  sr) := sr               in set_WC                         ;
	export SourceIsWeeklyHeader               (string  sr) := sr               =  src_Equifax_Weekly             ;
	export SourceIsWhois_domains              (string  sr) := sr               in set_Whois_domains              ;
	export SourceIsWired_Assets_Email         (string  sr) := sr               in set_Wired_Assets_Email         ;
	export SourceIsWired_Assets_Owned 	      (string  sr) := sr               in set_wired_assets_owned				 ; 	
	export SourceIsWired_Assets_Royalty	      (string  sr) := sr               in set_Wired_Assets_Royalty  		 ;
	export SourceIsWither_and_Die             (string  sr) := sr               in set_Wither_and_Die             ;
	export SourceIsWorkers_Compensation       (string  sr) := sr               in set_Workers_Compensation       ;
	export SourceIsMS_Worker_Comp             (string  sr) := sr               in set_MS_Worker_Comp             ;
	export SourceIsOR_Worker_Comp             (string  sr) := sr               in set_OR_Worker_Comp             ;
	export SourceIsWorkmans_Comp              (string  sr) := sr               in set_Workmans_Comp              ;
	export SourceIsYellow_Pages               (string  sr) := sr               in set_Yellow_Pages               ;
	export SourceIsZOOM                       (string  sr) := sr               in set_ZOOM                       ;
	export SourceIsBKFS_Nod                   (string  sr) := sr               in set_BKFS_Nod                   ;
	export SourceIsBKFS_Reo                   (string  sr) := sr               in set_BKFS_Reo                   ;
	export SourceNot4Despray                  (string2 sr) := SourceGroup(sr)  in ['none']                       ;


	// -----------------------------------------
	// -- Dataset of Source Codes + Descriptions
	// -----------------------------------------
	export layout_description :=
	RECORD
		STRING2		code												        ;
		STRING100	description									        ;
		boolean		IsBusinessHeaderSource		:= false	;
		boolean		IsPeopleHeaderSource			:= false	;
		boolean		IsBusinessContactsSource	:= false	;
		boolean		IsPawSource								:= false	;
		boolean		IsFCRA										:= false	;
		boolean		IsDPPA										:= false	;
		boolean		IsUtility									:= false	;
		boolean		IsOnProbation							:= false	;
		boolean		IsDeath 									:= false	;
		boolean		IsDL 											:= false	;
		boolean		IsWC											:= false	;
		boolean		IsProperty								:= false	;
		boolean		IsTransUnion							:= false	;
		boolean		isWeeklyHeader						:= false	;
		boolean		isVehicle									:= false	;
		boolean		isLiens										:= false	;
		boolean		isBankruptcy							:= false	;
		boolean		isCorpV2									:= false	;
		boolean		isUpdating								:= true		;
	END;																			

	export dSource_Codes := DATASET([
		 {src_ABMS                      ,'American Board of Medical Specialty'                       }
		,{src_ACA                       ,'American Correctional Association'                         }
		,{src_Accidents_FL              ,'Accidents Florida'                                         }
		,{src_Accidents_ECrash          ,'Accidents ECrash'                                          }
		,{src_Accidents_ECrash_CRU      ,'Accidents ECrash CRU'                                      }
		,{src_Accurint_Arrest_Log       ,'Accurint Arrest Log'                                       }
		,{src_Accurint_Crim_Court       ,'Accurint Crim Court'                                       }
		,{src_Accurint_DOC              ,'Accurint DOC'                                              }
		,{src_Accurint_Sex_offender     ,'Accurint Sex offender'                                     }
		,{src_Accurint_Trade_Show       ,'Accurint Trade Show'                                       }
		,{src_ACF                       ,'ACF - America\'s Corporate Financial Directory'            }
		,{src_Acquiredweb      					,'Acquired Web'                                       			 }
		,{src_Acquiredweb_plus					,'Acquired Web Business'																		 }
	  ,{src_advo_valassis             ,'US Postal Service Via Valassis Communications, Inc. - ADVO'  }
		,{src_AHA                       ,'AHA - American Hospital Association'      			           }
	  ,{src_Aircrafts                 ,'Aircrafts'                                                 }
		,{src_Airmen                    ,'Airmen'                                                    }
		,{src_AK_Busreg                 ,'Alaska Business Registrations'                             }
		,{src_AK_Fishing_boats          ,'AK Commercial Fishing Vessels'                             }
		,{src_AK_Perm_Fund              ,'AK Perm Fund'                                              }
		,{src_ALC                       ,'American List Counsel'                                     }
		,{src_American_Students_List    ,'American Students List'                                    }
		,{src_OKC_Students_List         ,'OKC Students List'                                         }
		,{src_AlloyMedia_student_list		,'Alloy Media Student Directory'														 }
		,{src_AlloyMedia_consumer				,'Alloy Media Opt-in Consumer non-directory'								 }
		,{src_AMIDIR                    ,'Medical Information Directory'                             }
		,{src_AMS                       ,'Advantage Management Solutions'                            }
		,{src_Anchor										,'Anchor Computer Email Addresses'  												 }
		,{src_Bair_Analytics            ,'Bair Analytics agency-reported relational data'            }
		,{src_Bankruptcy                ,'Bankruptcy'                                                }
		,{src_Bankruptcy_Attorney       ,'Bankruptcy Attorneys'                                      }
		,{src_Bankruptcy_Trustee        ,'Bankruptcy Trustees'                                       }
		,{src_BBB_Member                ,'Better Business Bureau Member'                             }
		,{src_BBB_Non_Member            ,'Better Business Bureau Non-Member'                         }
		,{src_BrightVerify_email				,'BrightVerify Email Deltabase'															 }
		,{src_Business_Credit           ,'Business Credit (SBFE)'                                    }
		,{src_Business_Registration     ,'Business Registration'                                     }
		,{src_Calbus	 				          ,'California Sales & Use Tax Businesses'                     }	
		,{src_cellphones_Kroll	 				,'Cellphones Kroll'                                       	 }	
		,{src_cellphones_Nextones   		,'Cellphones Nextones'                                       }	
		,{src_cellphones_Traffix  			,'Cellphones Traffix'                                        }	
		,{src_Certegy                   ,'Certegy'                                                   }
		,{src_Consumer_Disclosure_feed                   ,'Consumer Disclosure feed'                                                   }
		,{src_CClue		                  ,'Commercial Clue'                                           }
		,{src_Clarity					          ,'Clarity'				                                           }
		,{src_CLIA		                  ,'Clinical Laboratory Improvement Amendments'                }
		,{src_CNLD_Facilities           ,'CNLD Facilities'                                           }
		,{src_CNLD_Practitioner         ,'CNLD Practitioner'                                         }
		,{src_Correctional_Facilities   ,'Correctional Facilities - Internal'					               }
		,{src_Cortera		                ,'Cortera'                                                   }
		,{src_Cortera_Tradeline         ,'Cortera Tradeline'                                         }
		,{src_FL_CH                     ,'FL CH'                                                     }
		,{src_GA_CH                     ,'GA CH'                                                     }
		,{src_PA_CH                     ,'PA CH'                                                     }
		,{src_UT_CH                     ,'UT CH'                                                     }
		,{src_AK_Corporations           ,'AK Corporations'                                           }
		,{src_AL_Corporations           ,'AL Corporations'                                           }
		,{src_AR_Corporations           ,'AR Corporations'                                           }
		,{src_AZ_Corporations           ,'AZ Corporations'                                           }
		,{src_CA_Corporations           ,'CA Corporations'                                           }
		,{src_CO_Corporations           ,'CO Corporations'                                           }
		,{src_CT_Corporations           ,'CT Corporations'                                           }
		,{src_DC_Corporations           ,'DC Corporations'                                           }
		,{src_FL_Corporations           ,'FL Corporations'                                           }
		,{src_GA_Corporations           ,'GA Corporations'                                           }
		,{src_HI_Corporations           ,'HI Corporations'                                           }
		,{src_IA_Corporations           ,'IA Corporations'                                           }
		,{src_ID_Corporations           ,'ID Corporations'                                           }
		,{src_IL_Corporations           ,'IL Corporations'                                           }
		,{src_IN_Corporations           ,'IN Corporations'                                           }
		,{src_KS_Corporations           ,'KS Corporations'                                           }
		,{src_KY_Corporations           ,'KY Corporations'                                           }
		,{src_LA_Corporations           ,'LA Corporations'                                           }
		,{src_MA_Corporations           ,'MA Corporations'                                           }
		,{src_MD_Corporations           ,'MD Corporations'                                           }
		,{src_ME_Corporations           ,'ME Corporations'                                           }
		,{src_MI_Corporations           ,'MI Corporations'                                           }
		,{src_MN_Corporations           ,'MN Corporations'                                           }
		,{src_MO_Corporations           ,'MO Corporations'                                           }
		,{src_MS_Corporations           ,'MS Corporations'                                           }
		,{src_MT_Corporations           ,'MT Corporations'                                           }
		,{src_NC_Corporations           ,'NC Corporations'                                           }
		,{src_ND_Corporations           ,'ND Corporations'                                           }
		,{src_NE_Corporations           ,'NE Corporations'                                           }
		,{src_NH_Corporations           ,'NH Corporations'                                           }
		,{src_NJ_Corporations           ,'NJ Corporations'                                           }
		,{src_NM_Corporations           ,'NM Corporations'                                           }
		,{src_NV_Corporations           ,'NV Corporations'                                           }
		,{src_NY_Corporations           ,'NY Corporations'                                           }
		,{src_OH_Corporations           ,'OH Corporations'                                           }
		,{src_OK_Corporations           ,'OK Corporations'                                           }
		,{src_OR_Corporations           ,'OR Corporations'                                           }
		,{src_PA_Corporations           ,'PA Corporations'                                           }
		,{src_RI_Corporations           ,'RI Corporations'                                           }
		,{src_SC_Corporations           ,'SC Corporations'                                           }
		,{src_SD_Corporations           ,'SD Corporations'                                           }
		,{src_TN_Corporations           ,'TN Corporations'                                           }
		,{src_TX_Corporations           ,'TX Corporations'                                           }
		,{src_UT_Corporations           ,'UT Corporations'                                           }
		,{src_VA_Corporations           ,'VA Corporations'                                           }
		,{src_VT_Corporations           ,'VT Corporations'                                           }
		,{src_WA_Corporations           ,'WA Corporations'                                           }
		,{src_WI_Corporations           ,'WI Corporations'                                           }
		,{src_WV_Corporations           ,'WV Corporations'                                           }
		,{src_WV_Hist_Corporations      ,'WV Historical Corporations'                                }
		,{src_WY_Corporations           ,'WY Corporations'                                           }
		,{src_CrashCarrier			        ,'Crash Carrier'		                                         }		
		,{src_Credit_Unions             ,'Credit Unions'                                             }
		,{src_Datagence      						,'Datagence'                                    }
		,{src_DCA                       ,'DCA'                                                       }
		,{src_DEA                       ,'DEA'                                                       }
		,{src_Death_Michigan            ,'Death Michigan (not part of Death Master)'                 }
		,{src_Death_Master              ,'Death Master'                                              }
		,{src_Death_Restricted          ,'Death Master Restricted'                                   }
		,{src_Death_State               ,'Death State'                                               }
		,{src_Death_Tributes            ,'Death Tributes'                                            }
		,{src_Death_Obituary						,'Death Obituary'																						 }
		,{src_Death_CA			            ,'Death California'                                          }
		,{src_Death_CT			            ,'Death Connecticut'                                         }
		,{src_Death_FL			            ,'Death Florida'		                                         }
		,{src_Death_GA			            ,'Death Georgia'		                                         }
		,{src_Death_KY			            ,'Death Kentucky'		                                         }
		,{src_Death_MA			            ,'Death Massachusetts'                                       }
		,{src_Death_ME			            ,'Death Maine'  		                                         }
		,{src_Death_MI			            ,'Death Michigan'		                                         }
		,{src_Death_MN			            ,'Death Minnesota'	                                         }
		,{src_Death_MT			            ,'Death Montana'		                                         }
		,{src_Death_NC			            ,'Death North Carolina'                                      }
		,{src_Death_NV			            ,'Death Nevada'	  	                                         }
		,{src_Death_OH			            ,'Death Ohio'   		                                         }
		,{src_Death_VA			            ,'Death Virginia'		                                         }
		,{src_Debt_Settlement           ,'Debt Settlement'		                                       }
		,{src_Diversity_Cert 						,'DiversityCertification'                                    }
		,{src_Divorce					          ,'Divorce' 					                                         }
		,{src_CT_DL                     ,'CT DL'                                                     }
		,{src_FL_DL                     ,'FL DL'                                                     }
		,{src_IA_DL                     ,'IA DL'                                                     }
		,{src_ID_DL                     ,'ID DL'                                                     }
		,{src_KY_DL                     ,'KY DL'                                                     }
		,{src_MA_DL                     ,'MA DL'                                                     }
		,{src_ME_DL                     ,'ME DL'                                                     }
		,{src_MI_DL                     ,'MI DL'                                                     }
		,{src_MN_DL                     ,'MN DL'                                                     }
		,{src_MO_DL                     ,'MO DL'                                                     }
		,{src_NC_DL                     ,'NC DL'                                                     }
		,{src_NE_DL                     ,'NE DL'                                                     }
		,{src_NM_DL                     ,'NM DL'                                                     }
		,{src_NV_DL                     ,'NV DL'                                                     }
		,{src_LA_DL                     ,'LA DL'                                                     }
		,{src_OH_DL                     ,'OH DL'                                                     }
		,{src_OR_DL                     ,'OR DL'                                                     }
		,{src_TN_DL                     ,'TN DL'                                                     }
		,{src_TX_DL                     ,'TX DL'                                                     }
		,{src_UT_DL                     ,'UT DL'                                                     }
		,{src_WI_DL                     ,'WI DL'                                                     }
		,{src_WV_DL                     ,'WV DL'                                                     }
		,{src_WY_DL                     ,'WY DL'                                                     }
		,{src_CO_Experian_DL            ,'CO Experian DL'                                            }
		,{src_DE_Experian_DL            ,'DE Experian DL'                                            }
		,{src_ID_Experian_DL            ,'ID Experian DL'                                            }
		,{src_IL_Experian_DL            ,'IL Experian DL'                                            }
		,{src_KY_Experian_DL            ,'KY Experian DL'                                            }
		,{src_LA_Experian_DL            ,'LA Experian DL'                                            }
		,{src_MD_Experian_DL            ,'MD Experian DL'                                            }
		,{src_MS_Experian_DL            ,'MS Experian DL'                                            }
		,{src_ND_Experian_DL            ,'ND Experian DL'                                            }
		,{src_NH_Experian_DL            ,'NH Experian DL'                                            }
		,{src_SC_Experian_DL            ,'SC Experian DL'                                            }
		,{src_WV_Experian_DL            ,'WV Experian DL'                                            }
		,{src_MN_RESTRICTED_DL          ,'MN Restricted DL'                                          }
		,{src_Dummy_Records             ,'Dummy Records'                                             }
		,{src_Dummy_Records2            ,'Dummy Records2'                                            }
		,{src_Daily_Utilities						,'Daily Utilities'																					 }
		,{src_Dunn_Bradstreet           ,'Dunn & Bradstreet'                                         }
		,{src_Dunn_Bradstreet_Fein      ,'Dunn & Bradstreet Fein'                                    }
		,{src_Dunndata_Consumer         ,'Dunn Data Consumer Masterfile'                             }
		,{src_Dunn_Data_Email						,'Dunn Data Email Addresses'																 }
		,{src_EBR                       ,'Experian Business Reports'                                 }
		,{src_Edgar                     ,'Edgar'                                                     }
		,{src_Emdeon                    ,'Emdeon Healthcare Claims'                                  }
		,{src_EMerge_Boat               ,'EMerge Boat'                                               }
		,{src_EMerge_CCW                ,'EMerge CCW'                                                }
		,{src_EMerge_CCW_NY                ,'EMerge CCW_NY'                                                }
		,{src_EMerge_Cens               ,'EMerge Cens'                                               }
		,{src_EMerge_Fish               ,'EMerge Fish'                                               }
		,{src_EMerge_Hunt               ,'EMerge Hunt'                                               }
		,{src_EMerge_Master             ,'EMerge Master'                                             }
		,{src_Employee_Directories      ,'Employee Directories'                                      }
		,{src_Enclarity									,'Enclarity'																								 }
		,{src_Entiera       						,'Entiera'                                       						 }
		,{src_Equifax                   ,'Equifax'                                                   }
		,{src_Equifax_Business_Data      ,'Equifax Business Data'                                    }
		,{src_Equifax_Quick             ,'Equifax Quick'                                             }
		,{src_Equifax_Weekly            ,'Equifax Weekly'                                            }
		,{src_Eq_Employer               ,'Eq Employer'                                               }
		,{src_Experian_CRDB							,'Experian Credit Reporting Data Base'											 }
		,{src_Experian_Credit_Header    ,'Experian Credit Header'                                    }
		,{src_Experian_FEIN_Rest        ,'Experian FEIN Restricted'                                  }
		,{src_Experian_FEIN_Unrest      ,'Experian FEIN Unrestricted'                                }		
		,{src_Experian_Phones           ,'Experian Phones'                                           }
		,{src_Fares_Deeds_from_Asrs     ,'Fares Deeds from Assessors'                                }
		,{src_FBNV2_BusReg					    ,'ACU FBNV2 Business Registration'  		                     }
		,{src_FBNV2_CA_Orange_county    ,'CAO FBNV2 California Orange county'                        }
		,{src_FBNV2_CA_Santa_Clara      ,'CSC FBNV2 California Santa Clara'                          }
		,{src_FBNV2_CA_San_Bernadino    ,'CAB FBNV2 California San Bernadino'                        }
		,{src_FBNV2_CA_San_Diego        ,'CAS FBNV2 California San Diego'                            }
		,{src_FBNV2_CA_Ventura          ,'CAV FBNV2 California Ventura'                              }
		,{src_FBNV2_Experian_Direct     ,'EXP FBNV2 Experian Direct'                                 }
		,{src_FBNV2_FL                  ,'FL  FBNV2 Florida'                                         }
		,{src_FBNV2_Hist_Choicepoint    ,'CP  FBNV2 Historical Choicepoint'                          }
		,{src_FBNV2_INF                 ,'INF FBNV2 Infousa'                                         }
		,{src_FBNV2_New_York            ,'NBX,NYN,NKI,NQU,NRI FBNV2 New York'                        }
		,{src_FBNV2_TX_Dallas           ,'TXD FBNV2 Texas Dallas'                                    }
		,{src_FBNV2_TX_Harris           ,'TXH FBNV2 Texas Harris'                                    }
		,{src_FCC_Radio_Licenses        ,'FCC Radio Licenses'                                        }
		,{src_FCRA_Corrections_record   ,'A corrections/override (used in FCRA products) record'     }
		,{src_FDIC                      ,'FDIC'                                                      }
		,{src_FDIC_SOD                  ,'FDIC_SOD'                                                  }
		,{src_Federal_Explosives        ,'Federal Explosives'                                        }
		,{src_Federal_Firearms          ,'Federal Firearms'                                          }
		,{src_FL_FBN                    ,'Florida FBN'                                               }
		,{src_FL_Non_Profit             ,'Florida Non-Profit'                                        }
		,{src_Foreclosures              ,'Foreclosures'                                              }
		,{src_Foreclosures_Delinquent   ,'Foreclosures - Notice of Delinquency'                      }
		,{src_Frandx									  ,'Franchisee Data'											                     }
		,{src_NJ_Gaming_Licenses        ,'New Jersey Gaming Licenses'                                }
		,{src_Garnishments			        ,'Garnishments'								                               }
		,{src_Gong_Business             ,'Gong Business'                                             }
		,{src_Gong_Government           ,'Gong Government'                                           }
		,{src_Gong_History              ,'Gong History'                                              }
		,{src_Gong_Neustar							,'Gong Neustar'																							 }
		,{src_Gong_phone_append         ,'Appended phone from gong file'                             }
		,{src_GSA                       ,'General Services Administration'                           }
		,{src_GSDD                      ,'Gold Standard Drug Database'                               }
		,{src_HMS_PM										,'HMS Healthcare Provider Master'                            }
		,{src_HXMX											,'HXMX (aka Symphony) Healthcare Claims'                     }
		,{src_Ibehavior       					,'Ibehavior'                                     						 }
		,{src_Impulse       						,'Impulse'                                      						 }
		,{src_Infogroup                 ,'Infogroup'                                                 }
		,{src_INFOUSA_ABIUS_USABIZ      ,'INFOUSA ABIUS(USABIZ)'                                     }
		,{src_INFOUSA_DEAD_COMPANIES    ,'INFOUSA DEAD COMPANIES'                                    }
		,{src_INFOUSA_IDEXEC            ,'INFOUSA IDEXEC'                                            }
	  ,{src_Infutor_NARB              ,'Infutor NARB - Name and Address Resource Business'         }
		,{src_InfutorCID	 							,'Infutor CID - Phones'                                      }		
	  ,{src_InfutorTRK	 							,'Infutor TRK - Name and Address Resource'                   }		
		,{src_InfutorNarc	 							,'Infutor Narc  - Consumer Name and Address Resource'        }
		,{src_infutor_narc3             ,'Infutor Narc3 Consumer'                                    }
		,{src_InfutorNare								,'Infutor Nare	- Consumer Name and Email Resource'					 }
		,{src_Ingenix_Sanctions         ,'Ingenix National Provider Sanctions'                       }
		,{src_InquiryAcclogs            ,'Inquiry Tracking Account Logs'                             }
		,{src_Insurance_Certification   ,'Insurance_Certification'                                   }
		,{src_Intrado	 									,'Intrado Phones'                                       		 }
		,{src_IRS_5500                  ,'IRS 5500'                                                  }
		,{src_IRS_Non_Profit            ,'IRS Non-Profit'                                            }
		,{src_Jigsaw                    ,'Jigsaw'                                                    }
		,{src_LaborActions_EBSA					,'LaborActions_EBSA'																				 }
		,{src_LaborActions_WHD          ,'LaborActions_WHD'                                          }
		,{src_Lexis_Trans_Union         ,'Lexis Trans Union'                                         }
		,{src_Liens                     ,'Liens'                                                     }
		,{src_Liens_and_Judgments       ,'Liens and Judgments'                                       }
		,{src_Liens_v2                  ,'Liens v2'                                                  }
		,{src_Liens_v2_CA_Federal       ,'CA Liens v2 CA Federal'                                    }
		,{src_Liens_v2_Chicago_Law      ,'CL,CJ Liens v2 Chicago Law'                                }
		,{src_Liens_v2_Hogan            ,'HG Liens v2 Hogan'                                         }
		,{src_Liens_v2_ILFDLN           ,'IL Liens v2 ILFDLN'                                        }
		,{src_Liens_v2_MA               ,'MA Liens v2 MA'                                            }
		,{src_Liens_v2_NYC              ,'NYC Liens v2 NYC'                                          }
		,{src_Liens_v2_NYFDLN           ,'NY Liens v2 NYFDLN'                                        }
		,{src_Liens_v2_Service_Abstract ,'SA Liens v2 Service Abstract'                              }
		,{src_Liens_v2_Superior_Party   ,'SU Liens v2 Superior Party'                                }
		,{src_Link2tek									,'Link2tek Phones'																					 }
		,{src_CA_Liquor_Licenses        ,'California Liquor Licenses'                                }
		,{src_CT_Liquor_Licenses        ,'Conneticut Liquor Licenses'                                }
		,{src_IN_Liquor_Licenses        ,'Indiana Liquor Licenses'                                   }
		,{src_LA_Liquor_Licenses        ,'Louisana Liquor Licenses'                                  }
		,{src_OH_Liquor_Licenses        ,'Ohio Liquor Licenses'                                      }
		,{src_PA_Liquor_Licenses        ,'Pennsylvania Liquor Licenses'                              }
		,{src_TX_Liquor_Licenses        ,'Texas Liquor Licenses'                                     }
		,{src_LnPropV2_Fares_Asrs       ,'LN_Propertyv2 Fares Assessors'                             }
		,{src_LnPropV2_Fares_Deeds      ,'LN_Propertyv2 Fares Deeds'                                 }
		,{src_LnPropV2_Lexis_Asrs       ,'LN_Propertyv2 Lexis Assessors'                             }
		,{src_LnPropV2_Lexis_Deeds_Mtgs ,'LN_Propertyv2 Lexis Deeds and Mortgages'                   }
		,{src_Lobbyists                 ,'Lobbyists'                                                 }
		,{src_Mari_Prof_Lic				      ,'Mari Professional Licenses'   				                     }
		,{src_Mari_Public_Sanc          ,'Mari Public Sanctions'   				                           }
		,{src_Marriage				          ,'Marriage'   				                                       }
		,{src_MartinDale_Hubbell        ,'MartinDale Hubbell'                                        }
		,{src_MediaOne				          ,'Media One Email'                                       		 }
    ,{src_Metronet_Gateway          ,'Metronet Gateway'                                          }		
		,{src_Miscellaneous             ,'Miscellaneous'                                             }
		,{src_Mixed_DPPA                ,'Mixed DPPA'                                                }
		,{src_Mixed_Non_DPPA            ,'Mixed Non-DPPA'                                            }
		,{src_Mixed_Probation           ,'Mixed Probation'                                           }
		,{src_Mixed_Utilities           ,'Mixed Utilities'                                           }
	  ,{src_MPRD_Individual			      ,'MPRD Individual'                                           }	
		,{src_MMCP						          ,'Michigan Medicaid Custom Program'                          }
		,{src_NaturalDisaster_Readiness	,'NaturalDisaster Readiness'																 }
		,{src_NCOA                      ,'NCOA'                                                      }
		,{src_NCPDP											,'NCPDP'																										 }
		,{src_NeustarWireless						,'Neustar Wireless Phones'																	 }
		,{src_NPPES                     ,'NPPES'                                                     }
		,{src_OIG                       ,'OIG'                                                       }
		,{src_One_Click_Data            ,'One Click Data'                                            }
    ,{src_OKC_Probate               ,'OKC Probate'                                               }
		,{src_OKC_Student_List          ,'OKC Student List'                                          }
		,{src_OSHAIR                    ,'OSHAIR'                                                    }
		,{src_OutwardMedia			        ,'Outward Media Email'                                       }
		,{src_PBSA                      ,'United States Postal Service' 			                       }	  
		,{src_Pcnsr    									,'PCNSR Phones'                                       			 }		
	  ,{src_Phones_Plus               ,'Phones Plus'                                               }
		,{src_POS                       ,'Provider of Services'											           }				
		,{src_Professional_License      ,'Professional License'                                      }
		,{src_PSS									      ,'Phone Status Service'                                      }
		,{src_RealSource																,'RealSource Inc Email Addresses'																											}
		,{src_Redbooks                  ,'Redbooks International Advertisers'                        }
		,{src_SalesChannel							,'Sales Channel'																						 }
		,{src_CA_Sales_Tax              ,'California Sales Tax'                                      }
		,{src_IA_Sales_Tax              ,'Iowa Sales Tax'                                            }
		,{src_SDA                       ,'SDA - Standard Directory of Advertisers'                   }
		,{src_SDAA                      ,'SDAA - Standard Directory of Ad Agencies'                  }
		,{src_SEC_Broker_Dealer         ,'SEC Broker/Dealer'                                         }
    ,{src_sexoffender               ,'Sex Offender'                                               }  		
		,{src_Sheila_Greco              ,'Sheila Greco'                                              }
		,{src_SKA                       ,'SK&A Medical Professionals'                                }
		,{src_FL_SO                     ,'FL SO'                                                     }
		,{src_GA_SO                     ,'GA SO'                                                     }
		,{src_MI_SO                     ,'MI SO'                                                     }
		,{src_PA_SO                     ,'PA SO'                                                     }
		,{src_UT_SO                     ,'UT SO'                                                     }
		,{src_Spoke                     ,'Spoke'                                                     }
 // ,{src_Symphony									,'Symphony (aka HXMX) Healthcare Claims'                     }// purposely commented out because Symphony and HXMX are the same source
		,{src_Targus_White_pages        ,'Targus White pages'                                        }
		,{src_Tax_practitioner          ,'Tax practitioner'                                          }
		,{src_TCOA_After_Address        ,'TCOA After Address'                                        }
		,{src_TCOA_Before_Address       ,'TCOA Before Address'                                       }
		,{src_Teletrack                 ,'Teletrack'                                                 }
		,{src_Thrive_LT                 ,'Thrive LT (Lending Transactions)'                          }
		,{src_Thrive_LT_POE_Email       ,'Thrive LT (Lending Transactions) Used in POE Email'        }
		,{src_Thrive_PD                 ,'Thrive PD (Pay Day)'                         							 }
		,{src_Thrive_PD_POE_Email       ,'Thrive PD (Pay Day) Used in POE Email'                     }
		,{src_TransUnion                ,'TransUnion'                                                }
		,{src_TUCS_Ptrack               ,'TUCS_Ptrack'                                               }
		,{src_TU_CreditHeader           ,'Transunion Credit Header'                                  }
		,{src_TXBUS                     ,'Texas Sales Tax Registrations(TXBUS)'                      }
		,{src_UCC                       ,'UCC'                                                       }
		,{src_UCCV2                     ,'UCCV2'                                                     }
		,{src_UCCV2_WA_Hist             ,'WA Historical UCCV2'                                       }
		,{src_US_Coastguard             ,'US Coastguard'                                             }
		,{src_Utilities                 ,'Utilities'                                                 }
		,{src_Util_Work_Phone           ,'Util Work Phone'                                           }
		,{src_ZUtilities                ,'Z type Utilities'                                          }
		,{src_ZUtil_Work_Phone          ,'Z type Util Work Phone'                                    }
		,{src_Daily_ZUtilities					,'Daily Z Type Utilites'																		 }
		,{src_FL_Veh                    ,'FL Veh'                                                    }
		,{src_ID_Veh                    ,'ID Veh'                                                    }
		,{src_KY_Veh                    ,'KY Veh'                                                    }
		,{src_MA_Veh                    ,'MA Veh'                                                    }
		,{src_ME_Veh                    ,'ME Veh'                                                    }
		,{src_MN_Veh                    ,'MN Veh'                                                    }
		,{src_MO_Veh                    ,'MO Veh'                                                    }
		,{src_MS_Veh                    ,'MS Veh'                                                    }
		,{src_MT_Veh                    ,'MT Veh'                                                    }
		,{src_NC_Veh                    ,'NC Veh'                                                    }
		,{src_ND_Veh                    ,'ND Veh'                                                    }
		,{src_NE_Veh                    ,'NE Veh'                                                    }
		,{src_NM_Veh                    ,'NM Veh'                                                    }
		,{src_NV_Veh                    ,'NV Veh'                                                    }
		,{src_OH_Veh                    ,'OH Veh'                                                    }
		,{src_TX_Veh                    ,'TX Veh'                                                    }
		,{src_UT_Veh                    ,'UT Veh'                                                    }
		,{src_WI_Veh                    ,'WI Veh'                                                    }
		,{src_WY_Veh                    ,'WY Veh'                                                    }
		,{src_AK_Experian_Veh           ,'AK Experian Veh'                                           }
		,{src_AL_Experian_Veh           ,'AL Experian Veh'                                           }
		,{src_AR_Experian_Veh           ,'AR Experian Veh'                                           }		//DF16817
		,{src_AZ_Experian_Veh           ,'AZ Experian Veh'                                           }		//DF16817
		,{src_CO_Experian_Veh           ,'CO Experian Veh'                                           }
		,{src_CT_Experian_Veh           ,'CT Experian Veh'                                           }
		,{src_DC_Experian_Veh           ,'DC Experian Veh'                                           }
		,{src_DE_Experian_Veh           ,'DE Experian Veh'                                           }
		,{src_FL_Experian_Veh           ,'FL Experian Veh'                                           }
		,{src_GA_Experian_Veh           ,'GA Experian Veh'                                           }		//DF16817
		,{src_IA_Experian_Veh           ,'IA Experian Veh'                                           }		//DF16817
		,{src_ID_Experian_Veh           ,'ID Experian Veh'                                           }
		,{src_IL_Experian_Veh           ,'IL Experian Veh'                                           }
		,{src_KS_Experian_Veh           ,'KS Experian Veh'                                           }		//DF16817
		,{src_KY_Experian_Veh           ,'KY Experian Veh'                                           }
		,{src_LA_Experian_Veh           ,'LA Experian Veh'                                           }
		,{src_MA_Experian_Veh           ,'MA Experian Veh'                                           }
		,{src_MD_Experian_Veh           ,'MD Experian Veh'                                           }
		,{src_ME_Experian_Veh           ,'ME Experian Veh'                                           }
		,{src_MI_Experian_Veh           ,'MI Experian Veh'                                           }
		,{src_MN_Experian_Veh           ,'MN Experian Veh'                                           }
		,{src_MO_Experian_Veh           ,'MO Experian Veh'                                           }
		,{src_MS_Experian_Veh           ,'MS Experian Veh'                                           }
		,{src_MT_Experian_Veh           ,'MT Experian Veh'                                           }
		,{src_NC_Experian_Veh           ,'NC Experian Veh'                                           }		//DF16817
		,{src_ND_Experian_Veh           ,'ND Experian Veh'                                           }
		,{src_NE_Experian_Veh           ,'NE Experian Veh'                                           }
		,{src_NM_Experian_Veh           ,'NM Experian Veh'                                           }
		,{src_NV_Experian_Veh           ,'NV Experian Veh'                                           }
		,{src_NY_Experian_Veh           ,'NY Experian Veh'                                           }
		,{src_OH_Experian_Veh           ,'OH Experian Veh'                                           }
		,{src_OK_Experian_Veh           ,'OK Experian Veh'                                           }
		,{src_OR_Experian_Veh           ,'OR Experian Veh'                                           }
		,{src_RI_Experian_Veh           ,'RI Experian Veh'                                           }		//DF16817
		,{src_SC_Experian_Veh           ,'SC Experian Veh'                                           }
		,{src_SD_Experian_Veh           ,'SD Experian Veh'                                           }		//DF16817
		,{src_TN_Experian_Veh           ,'TN Experian Veh'                                           }
		,{src_TX_Experian_Veh           ,'TX Experian Veh'                                           }
		,{src_UT_Experian_Veh           ,'UT Experian Veh'                                           }
		,{src_VT_Experian_Veh           ,'VT Experian Veh'                                           }		//DF16817
		,{src_WA_Experian_Veh           ,'WA Experian Veh'                                           }		//DF16817
		,{src_WI_Experian_Veh           ,'WI Experian Veh'                                           }
		,{src_WY_Experian_Veh           ,'WY Experian Veh'                                           }
		,{src_Infutor_Veh           		,'Infutor Veh'   			                                       }
		,{src_Infutor_Motorcycle_Veh    ,'Infutor Motorcycle Veh'   	                               }
		,{src_Vickers                   ,'Vickers'                                                   }
		,{src_Voters_v2                 ,'Voters v2'                                                 }
		,{src_AK_Watercraft             ,'AK Watercraft'                                             }
		,{src_AL_Watercraft             ,'AL Watercraft'                                             }
		,{src_AR_Watercraft             ,'AR Watercraft'                                             }
		,{src_AZ_Watercraft             ,'AZ Watercraft'                                             }
		,{src_CO_Watercraft             ,'CO Watercraft'                                             }
		,{src_CT_Watercraft             ,'CT Watercraft'                                             }
		,{src_FL_Watercraft             ,'FL Watercraft'                                             }
		,{src_GA_Watercraft             ,'GA Watercraft'                                             }
		,{src_IA_Watercraft             ,'IA Watercraft'                                             }
		,{src_IL_Watercraft             ,'IL Watercraft'                                             }
		,{src_KS_Watercraft             ,'KS Watercraft'                                             }
		,{src_KY_Watercraft             ,'KY Watercraft'                                             }
		,{src_MA_Watercraft             ,'MA Watercraft'                                             }
		,{src_MD_Watercraft             ,'MD Watercraft'                                             }
		,{src_ME_Watercraft             ,'ME Watercraft'                                             }
		,{src_MI_Watercraft             ,'MI Watercraft'                                             }
		,{src_MN_Watercraft             ,'MN Watercraft'                                             }
		,{src_MO_Watercraft             ,'MO Watercraft'                                             }
		,{src_MS_Watercraft             ,'MS Watercraft'                                             }
		,{src_MT_Watercraft             ,'MT Watercraft'                                             }
		,{src_NC_Watercraft             ,'NC Watercraft'                                             }
		,{src_ND_Watercraft             ,'ND Watercraft'                                             }
		,{src_NE_Watercraft             ,'NE Watercraft'                                             }
		,{src_NH_Watercraft             ,'NH Watercraft'                                             }
		,{src_NM_Watercraft							,'NM Watercraft'																						 }
		,{src_NV_Watercraft             ,'NV Watercraft'                                             }
		,{src_NY_Watercraft             ,'NY Watercraft'                                             }
		,{src_OH_Watercraft             ,'OH Watercraft'                                             }
		,{src_OR_Watercraft             ,'OR Watercraft'                                             }
		,{src_SC_Watercraft             ,'SC Watercraft'                                             }
		,{src_TN_Watercraft             ,'TN Watercraft'                                             }
		,{src_TX_Watercraft             ,'TX Watercraft'                                             }
		,{src_UT_Watercraft             ,'UT Watercraft'                                             }
		,{src_VA_Watercraft             ,'VA Watercraft'                                             }
		,{src_WI_Watercraft             ,'WI Watercraft'                                             }
		,{src_WV_Watercraft             ,'WV Watercraft'                                             }
		,{src_WY_Watercraft             ,'WY Watercraft'                                             }
		,{src_WA_Watercraft             ,'WA Watercraft'                                             }
		,{src_FL_Watercraft_LN          ,'FL Watercraft (LN)'                                        }
		,{src_KY_Watercraft_LN          ,'KY Watercraft (LN)'                                        }
		,{src_MO_Watercraft_LN          ,'MO Watercraft (LN)'                                        }
		,{src_Infutor_Watercraft				,'Infutor Watercraft'																				 }
		,{src_Whois_domains             ,'Domain Registrations (WHOIS)'                              }
		,{src_Wired_Assets_Email        ,'Wired Assets Email'                                        }
		,{src_Wired_Assets_Owned  			,'Wired Assets Owned'                                        }	
	  ,{src_Wired_Assets_Royalty  		,'Wired Assets with Royalty'                                 }	
		,{src_Wither_and_Die            ,'Wither and Die'                                            }
		,{src_Workers_Compensation      ,'Workers Compensation'                                      }
		,{src_MS_Worker_Comp            ,'MS Worker Comp'                                            }
		,{src_OR_Worker_Comp            ,'OR Worker Comp'                                            }
		,{src_Yellow_Pages              ,'Yellow Pages'                                              }
		,{src_ZOOM                      ,'ZOOM'                                                      }
		,{src_BKFS_Nod                  ,'Black Knight Foreclosure Nod'                              }
		,{src_BKFS_Reo                  ,'Black Knight Foreclosure Reo'                              }
	], layout_description);            

                                     
	layout_description tSetSources(layout_description l) :=
	transform                          
		self.IsBusinessHeaderSource	  := SourceIsBusinessHeader	   (l.code);
		self.IsPeopleHeaderSource		  := SourceIsPeopleHeader			 (l.code);
		self.IsBusinessContactsSource := SourceIsBusiness_contacts (l.code);
		self.IsPawSource							:= SourceIsPaw							 (l.code);
		self.IsFCRA						 		 		:= SourceIsFCRA							 (l.code);		
		self.IsDPPA						 		 		:= SourceIsDPPA							 (l.code);
		self.IsUtility				 		 		:= SourceIsUtility					 (l.code);
		self.IsOnProbation						:= SourceIsOnProbation			 (l.code);
		self.IsDeath 									:= SourceIsDeath 						 (l.code);
		self.IsDL 										:= SourceIsDL 							 (l.code);
		self.IsWC											:= sourceIsWC								 (l.code);
		self.IsProperty								:= SourceIsProperty					 (l.code);
		self.IsTransUnion							:= SourceIsTransUnion				 (l.code);
		self.isWeeklyHeader						:= sourceisWeeklyHeader			 (l.code);
		self.isVehicle								:= sourceisVehicle					 (l.code);
		self.isLiens									:= sourceisLiens						 (l.code);
		self.isBankruptcy							:= sourceisBankruptcy				 (l.code);
		self.isCorpV2									:= sourceisCorpV2						 (l.code);
		self.isUpdating								:= not SourceIsNonUpdatingSrc(l.code);
		self													:= l                                 ;
	end;

	export dSource_Codes_proj := project(dSource_Codes, tSetSources(left));

	export fTranslateSource(string pSource) :=
	function
		lcode := dSource_Codes_proj.code;
		source_filter 		:= 	(		trim(pSource,left,right) = trim(lcode,left,right)
																);
		dsource 					:= dSource_Codes_proj(source_filter		)[1].description;
		returnDescription := dsource;
		return if(returnDescription != '', returnDescription, '?' + pSource);
	end;

	export TranslateSource(string2 pSource) :=
	case(pSource
		,src_ABMS                      => 'American Board of Medical Specialty'                    
		,src_ACA                       => 'American Correctional Association'                    
		,src_Accidents_FL              => 'Accidents Florida'                 
		,src_Accidents_ECrash          => 'Accidents ECrash'                    
		,src_Accidents_ECrash_CRU      => 'Accidents ECrash CRU'                    
		,src_Accurint_Arrest_Log       => 'Accurint Arrest Log'                                  
		,src_Accurint_Crim_Court       => 'Accurint Crim Court'                                  
		,src_Accurint_DOC              => 'Accurint DOC'                                         
		,src_Accurint_Sex_offender     => 'Accurint Sex offender'                                
		,src_Accurint_Trade_Show       => 'Accurint Trade Show'                                  
		,src_ACF                       => 'ACF - America\'s Corporate Financial Directory'       
		,src_Acquiredweb      				 => 'Acquired Web' 
		,src_Acquiredweb_plus					 =>	'Acquired Web Business'
    ,src_advo_valassis         		 => 'US Postal Service Via Valassis Communications, Inc. - ADVO'
		,src_AHA                       => 'AHA - American Hospital Association'       
		,src_Aircrafts                 => 'Aircrafts'                                            
		,src_Airmen                    => 'Airmen'                                               
		,src_AK_Busreg                 => 'Alaska Business Registrations'                        
		,src_AK_Fishing_boats          => 'AK Commercial Fishing Vessels'                        
		,src_AK_Perm_Fund              => 'AK Perm Fund'                                         
		,src_ALC                       => 'American List Counsel'                                         
		,src_American_Students_List    => 'American Students List'                               
		,src_OKC_Students_List         => 'OKC Students List'                               
		,src_AlloyMedia_student_list	 =>	'Alloy Media Student Directory'												
		,src_AlloyMedia_Consumer			 =>	'Alloy Media Opt-in Consumer non-directory'												
		,src_AMIDIR                    => 'Medical Information Directory'                        
		,src_AMS                       => 'Advantage Management Solutions'
		,src_Anchor										 =>	'Anchor Computer Email Addresses'
		,src_Bair_Analytics            => 'Bair Analytics agency-reported relational data'
		,src_Bankruptcy                => 'Bankruptcy'                                           
		,src_Bankruptcy_Attorney       => 'Bankruptcy Attorneys'                                 
		,src_Bankruptcy_Trustee        => 'Bankruptcy Trustees'                                  
		,src_BBB_Member                => 'Better Business Bureau Member'                        
		,src_BBB_Non_Member            => 'Better Business Bureau Non-Member' 
		,src_BrightVerify_email				 => 'BrightVerify Email Deltabase'
		,src_Business_Credit           => 'Business Credit (SBFE)'
		,src_Business_Registration     => 'Business Registration'                                
		,src_Calbus	 				           => 'California Sales & Use Tax Businesses'                
		,src_cellphones_Kroll	 				 => 'Cellphones Kroll'                                     
		,src_cellphones_Nextones   		 => 'Cellphones Nextones'                                  
		,src_cellphones_Traffix  			 => 'Cellphones Traffix'                                   
		,src_Certegy                   => 'Certegy'
		,src_Consumer_Disclosure_feed                   => 'Consumer Disclosure feed'
		,src_CClue              	     => 'Commercial Clue'
		,src_Clarity					         => 'Clarity'				                                      
		,src_CLIA		                   => 'Clinical Laboratory Improvement Amendments'
		,src_Correctional_Facilities   => 'Correctional Facilities - Internal'
		,src_Cortera                   => 'Cortera'
		,src_Cortera_Tradeline         => 'Cortera Tradeline'
		,src_FL_CH                     => 'FL CH'                                                
		,src_GA_CH                     => 'GA CH'                                                
		,src_PA_CH                     => 'PA CH'                                                
		,src_UT_CH                     => 'UT CH'                                                
		,src_AK_Corporations           => 'AK Corporations'                                      
		,src_AL_Corporations           => 'AL Corporations'                                      
		,src_AR_Corporations           => 'AR Corporations'                                      
		,src_AZ_Corporations           => 'AZ Corporations'                                      
		,src_CA_Corporations           => 'CA Corporations'                                      
		,src_CO_Corporations           => 'CO Corporations'                                      
		,src_CT_Corporations           => 'CT Corporations'                                      
		,src_DC_Corporations           => 'DC Corporations'                                      
		,src_FL_Corporations           => 'FL Corporations'                                      
		,src_GA_Corporations           => 'GA Corporations'                                      
		,src_HI_Corporations           => 'HI Corporations'                                      
		,src_IA_Corporations           => 'IA Corporations'                                      
		,src_ID_Corporations           => 'ID Corporations'                                      
		,src_IL_Corporations           => 'IL Corporations'                                      
		,src_IN_Corporations           => 'IN Corporations'                                      
		,src_KS_Corporations           => 'KS Corporations'                                      
		,src_KY_Corporations           => 'KY Corporations'                                      
		,src_LA_Corporations           => 'LA Corporations'                                      
		,src_MA_Corporations           => 'MA Corporations'                                      
		,src_MD_Corporations           => 'MD Corporations'                                      
		,src_ME_Corporations           => 'ME Corporations'                                      
		,src_MI_Corporations           => 'MI Corporations'                                      
		,src_MN_Corporations           => 'MN Corporations'                                      
		,src_MO_Corporations           => 'MO Corporations'                                      
		,src_MS_Corporations           => 'MS Corporations'                                      
		,src_MT_Corporations           => 'MT Corporations'                                      
		,src_NC_Corporations           => 'NC Corporations'                                      
		,src_ND_Corporations           => 'ND Corporations'                                      
		,src_NE_Corporations           => 'NE Corporations'                                      
		,src_NH_Corporations           => 'NH Corporations'                                      
		,src_NJ_Corporations           => 'NJ Corporations'                                      
		,src_NM_Corporations           => 'NM Corporations'                                      
		,src_NV_Corporations           => 'NV Corporations'                                      
		,src_NY_Corporations           => 'NY Corporations'                                      
		,src_OH_Corporations           => 'OH Corporations'                                      
		,src_OK_Corporations           => 'OK Corporations'                                      
		,src_OR_Corporations           => 'OR Corporations'                                      
		,src_PA_Corporations           => 'PA Corporations'                                      
		,src_RI_Corporations           => 'RI Corporations'                                      
		,src_SC_Corporations           => 'SC Corporations'                                      
		,src_SD_Corporations           => 'SD Corporations'                                      
		,src_TN_Corporations           => 'TN Corporations'                                      
		,src_TX_Corporations           => 'TX Corporations'                                      
		,src_UT_Corporations           => 'UT Corporations'                                      
		,src_VA_Corporations           => 'VA Corporations'                                      
		,src_VT_Corporations           => 'VT Corporations'                                      
		,src_WA_Corporations           => 'WA Corporations'                                      
		,src_WI_Corporations           => 'WI Corporations'                                      
		,src_WV_Corporations           => 'WV Corporations'                                      
		,src_WV_Hist_Corporations      => 'WV Historical Corporations'                           
		,src_WY_Corporations           => 'WY Corporations'                                      
		,src_CrashCarrier							 => 'Crash Carrier'
		,src_Credit_Unions             => 'Credit Unions'                                        
		,src_CNLD_Facilities					 => 'CNLD Facilities'
		,src_CNLD_Practitioner				 => 'CNLD_Practitioner'
		,src_Datagence      					 => 'Datagence'                               
		,src_DCA                       => 'DCA'                                                  
		,src_DEA                       => 'DEA'                                                  
		,src_Death_Michigan            => 'Death Michigan (not part of Death Master)'                                         
		,src_Death_Master              => 'Death Master'                                         
		,src_Death_Restricted          => 'Death Master Restricted'                                         
		,src_Death_State               => 'Death State'
		,src_Death_Tributes            => 'Death Tributes'
		,src_Death_Obituary						 => 'Death Obituary'
		,src_Death_CA									 =>	'Death California'
		,src_Death_CT			             => 'Death Connecticut'  
		,src_Death_FL			             => 'Death Florida'                                               
		,src_Death_GA			             => 'Death Georgia'                                               
		,src_Death_KY			             => 'Death Kentucky'                                                
		,src_Death_MA			             => 'Death Massachusetts'                                               
		,src_Death_ME			             => 'Death Maine'                                                
		,src_Death_MI			             => 'Death Michigan'                                                
		,src_Death_MN			             => 'Death Minnesota'                                               
		,src_Death_MT			             => 'Death Montana'                                               
		,src_Death_NC			             => 'Death North Carolina'                                               
		,src_Death_NV			             => 'Death Nevada'                                                
		,src_Death_OH			             => 'Death Ohio'                                                
		,src_Death_VA			             => 'Death Virginia'                                            
		,src_Debt_Settlement	         => 'Debt Settlement'                                      
		,src_Diversity_Cert 					 => 'DiversityCertification'                               
		,src_Divorce         					 => 'Divorce'                                                
		,src_CT_DL                     => 'CT DL'                                                
		,src_FL_DL                     => 'FL DL'                                                
		,src_IA_DL                     => 'IA DL'                                                
		,src_ID_DL                     => 'ID DL'                                                
		,src_KY_DL                     => 'KY DL'                                                
		,src_MA_DL                     => 'MA DL'                                                
		,src_ME_DL                     => 'ME DL'                                                
		,src_MI_DL                     => 'MI DL'                                                
		,src_MN_DL                     => 'MN DL'                                                
		,src_MO_DL                     => 'MO DL' 
		,src_NC_DL                     => 'NC DL'
		,src_NE_DL                     => 'NE DL'
		,src_NM_DL                     => 'NM DL'                                                
		,src_NV_DL                     => 'NV DL'
		,src_LA_DL                     => 'LA DL'                                                
		,src_OH_DL                     => 'OH DL'                                                
		,src_OR_DL                     => 'OR DL'                                                
		,src_TN_DL                     => 'TN DL'                                                
		,src_TX_DL                     => 'TX DL'                                                
		,src_UT_DL                     => 'UT DL'                                                
		,src_WI_DL                     => 'WI DL'                                                
		,src_WV_DL                     => 'WV DL'                                                
		,src_WY_DL                     => 'WY DL'                                                
		,src_CO_Experian_DL            => 'CO Experian DL'                                       
		,src_DE_Experian_DL            => 'DE Experian DL'                                       
		,src_ID_Experian_DL            => 'ID Experian DL'                                       
		,src_IL_Experian_DL            => 'IL Experian DL'                                       
		,src_KY_Experian_DL            => 'KY Experian DL'                                       
		,src_LA_Experian_DL            => 'LA Experian DL'                                       
		,src_MD_Experian_DL            => 'MD Experian DL'                                       
		,src_MS_Experian_DL            => 'MS Experian DL'                                       
		,src_ND_Experian_DL            => 'ND Experian DL'                                       
		,src_NH_Experian_DL            => 'NH Experian DL'                                       
		,src_SC_Experian_DL            => 'SC Experian DL'                                       
		,src_WV_Experian_DL            => 'WV Experian DL'                                       
		,src_MN_RESTRICTED_DL          => 'MN Restricted DL'                                       
		,src_Dummy_Records             => 'Dummy Records'                                        
		,src_Dummy_Records2            => 'Dummy Records2'                                        
//		,src_Daily_Utilities					 => 'Daily Utilities'																			
		,src_Dunn_Bradstreet           => 'Dunn & Bradstreet'                                    
		,src_Dunn_Bradstreet_Fein      => 'Dunn & Bradstreet Fein'                               
		,src_Dunndata_Consumer         => 'Dunn Data Consumer Masterfile'
		,src_Dunn_Data_Email					 => 'Dunn Data Email Addresses'
		,src_EBR                       => 'Experian Business Reports'                            
		,src_Edgar                     => 'Edgar'                                                
		,src_Emdeon                    => 'Emdeon Healthcare Claims'                                                
		,src_EMerge_Boat               => 'EMerge Boat'                                          
		,src_EMerge_CCW                => 'EMerge CCW'                                           
		,src_EMerge_CCW_NY                => 'EMerge CCW_NY'   //'EMerge CCW_NY_pistols'
		,src_EMerge_Cens               => 'EMerge Cens'                                          
		,src_EMerge_Fish               => 'EMerge Fish'                                          
		,src_EMerge_Hunt               => 'EMerge Hunt'                                          
		,src_EMerge_Master             => 'EMerge Master'                                        
		,src_Employee_Directories      => 'Employee Directories'   
		,src_Enclarity								 => 'Enclarity National Provider/Sanctions'
		,src_Entiera       						 => 'Entiera'                                       				
		,src_Equifax                   => 'Equifax'
		,src_Equifax_Business_Data     => 'Equifax Business Data'                                               
		,src_Equifax_Quick             => 'Equifax Quick'                                        
		,src_Equifax_Weekly            => 'Equifax Weekly'                                       
		,src_Eq_Employer               => 'Eq Employer'
		,src_Experian_CRDB						 => 'Experian Credit Reporting Data Base'				
		,src_Experian_Credit_Header    => 'Experian Credit Header'                               
		,src_Experian_FEIN_Rest        => 'Experian FEIN Restricted'                                      
		,src_Experian_FEIN_Unrest      => 'Experian FEIN Unrestricted'                                      
		,src_Experian_Phones           => 'Experian Phones'                                      
		,src_Fares_Deeds_from_Asrs     => 'Fares Deeds from Assessors'                           
		,src_FBNV2_BusReg					     => 'ACU FBNV2 Business Registration'  		                
		,src_FBNV2_CA_Orange_county    => 'CAO FBNV2 California Orange county'                   
		,src_FBNV2_CA_Santa_Clara      => 'CSC FBNV2 California Santa Clara'                     
		,src_FBNV2_CA_San_Bernadino    => 'CAB FBNV2 California San Bernadino'                   
		,src_FBNV2_CA_San_Diego        => 'CAS FBNV2 California San Diego'                       
		,src_FBNV2_CA_Ventura          => 'CAV FBNV2 California Ventura'                         
		,src_FBNV2_Experian_Direct     => 'EXP FBNV2 Experian Direct'                            
		,src_FBNV2_FL                  => 'FL  FBNV2 Florida'                                    
		,src_FBNV2_Hist_Choicepoint    => 'CP  FBNV2 Historical Choicepoint'                     
		,src_FBNV2_INF                 => 'INF FBNV2 Infousa'                                    
		,src_FBNV2_New_York            => 'NBX,NYN,NKI,NQU,NRI FBNV2 New York'                   
		,src_FBNV2_TX_Dallas           => 'TXD FBNV2 Texas Dallas'                               
		,src_FBNV2_TX_Harris           => 'TXH FBNV2 Texas Harris'                               
		,src_FCC_Radio_Licenses        => 'FCC Radio Licenses'                                   
		,src_FCRA_Corrections_record   => 'A corrections/override (used in FCRA products) record'
		,src_FDIC                      => 'FDIC'                                                 
		,src_FDIC_SOD                  => 'FDIC Summary of Deposits'                             
		,src_Federal_Explosives        => 'Federal Explosives'                                   
		,src_Federal_Firearms          => 'Federal Firearms'                                     
		,src_FL_FBN                    => 'Florida FBN'                                          
		,src_FL_Non_Profit             => 'Florida Non-Profit'                                   
		,src_Foreclosures              => 'Foreclosures'                                         
		,src_Foreclosures_Delinquent   => 'Foreclosures - Notice of Delinquency'                 
		,src_Frandx									   => 'Franchisee Data'                 
		,src_NJ_Gaming_Licenses        => 'New Jersey Gaming Licenses'                           
		,src_Garnishments			         => 'Garnishments'								                          
		,src_Gong_Business             => 'Gong Business'                                        
		,src_Gong_Government           => 'Gong Government'                                      
		,src_Gong_History              => 'Gong History'
		,src_Gong_Neustar							 => 'Gong Neustar'	
		,src_Gong_phone_append         => 'Appended phone from gong file'                        
		,src_GSA                       => 'General Services Administration'
		,src_GSDD                      => 'Gold Standard Drug Database'
		,src_HMS_PM										 => 'HMS (Healthcare) Provider Master'
		,src_HXMX											 => 'HXMX (aka Symphony) Health Care Claims'
		,src_Ibehavior       					 => 'Ibehavior'  
		,src_Impulse       						 => 'Impulse'     
		,src_Infogroup                 => 'Infogroup'                                
		,src_INFOUSA_ABIUS_USABIZ      => 'INFOUSA ABIUS(USABIZ)'                                
	  ,src_INFOUSA_DEAD_COMPANIES    => 'INFOUSA DEAD COMPANIES'                               
	  ,src_INFOUSA_IDEXEC            => 'INFOUSA IDEXEC'                                       
		,src_Infutor_NARB              => 'Infutor NARB - Name and Address Resource Business'
		,src_InfutorCID	 							 => 'Infutor CID - Phones'                                 
		,src_InfutorTRK	 							 => 'Infutor TRK - Name and Address Resource'              
		,src_InfutorNarc	 						 => 'Infutor  Narc - Consumer Name and Address Resource'
		,src_infutor_narc3             => 'Infutor Narc3 Consumer'
		,src_InfutorNare							 => 'Infutor Nare - Consumer Name and Email Resource'
		,src_Ingenix_Sanctions         => 'Ingenix National Provider Sanctions'                  
		,src_InquiryAcclogs            => 'Inquiry Tracking Account Logs'                        
		,src_Insurance_Certification   => 'Insurance_Certification'                              
		,src_Intrado	 								 => 'Intrado Phones'                                       
		,src_IRS_5500                  => 'IRS 5500'                                             
		,src_IRS_Non_Profit            => 'IRS Non-Profit'                                       
		,src_Jigsaw                    => 'Jigsaw'                                               
		,src_LaborActions_EBSA				 => 'LaborActions_EBSA'	
		,src_LaborActions_WHD          => 'LaborActions_WHD'                                     
		,src_Lexis_Trans_Union         => 'Lexis Trans Union'                                    
		,src_Liens                     => 'Liens'                                                
		,src_Liens_and_Judgments       => 'Liens and Judgments'                                  
		,src_Liens_v2                  => 'Liens v2'                                             
		,src_Liens_v2_CA_Federal       => 'CA Liens v2 CA Federal'                               
		,src_Liens_v2_Chicago_Law      => 'CL,CJ Liens v2 Chicago Law'                           
		,src_Liens_v2_Hogan            => 'HG Liens v2 Hogan'                                    
		,src_Liens_v2_ILFDLN           => 'IL Liens v2 ILFDLN'                                   
		,src_Liens_v2_MA               => 'MA Liens v2 MA'                                       
		,src_Liens_v2_NYC              => 'NYC Liens v2 NYC'                                     
		,src_Liens_v2_NYFDLN           => 'NY Liens v2 NYFDLN'                                   
		,src_Liens_v2_Service_Abstract => 'SA Liens v2 Service Abstract'                         
		,src_Liens_v2_Superior_Party   => 'SU Liens v2 Superior Party'                           
		,src_Link2tek									 => 'Link2tek Phones'
		,src_CA_Liquor_Licenses        => 'California Liquor Licenses'                           
		,src_CT_Liquor_Licenses        => 'Conneticut Liquor Licenses'                           
		,src_IN_Liquor_Licenses        => 'Indiana Liquor Licenses'                              
		,src_LA_Liquor_Licenses        => 'Louisana Liquor Licenses'                             
		,src_OH_Liquor_Licenses        => 'Ohio Liquor Licenses'                                 
		,src_PA_Liquor_Licenses        => 'Pennsylvania Liquor Licenses'                         
		,src_TX_Liquor_Licenses        => 'Texas Liquor Licenses'                                
		,src_LnPropV2_Fares_Asrs       => 'LN_Propertyv2 Fares Assessors'                        
		,src_LnPropV2_Fares_Deeds      => 'LN_Propertyv2 Fares Deeds'                            
		,src_LnPropV2_Lexis_Asrs       => 'LN_Propertyv2 Lexis Assessors'                        
		,src_LnPropV2_Lexis_Deeds_Mtgs => 'LN_Propertyv2 Lexis Deeds and Mortgages'              
		,src_Lobbyists                 => 'Lobbyists'                                            
		,src_Mari_Prof_Lic     				 => 'Mari Professional Licenses'                           
		,src_Mari_Public_Sanc          => 'Mari Public Sanctions'                                
		,src_Marriage          				 => 'Marriage'                                                
		,src_MartinDale_Hubbell        => 'MartinDale Hubbell'                                   
		,src_Metronet_Gateway		       => 'Metronet Gateway'                                                  
		,src_MediaOne				           => 'Media One Email'                                      
		,src_Miscellaneous             => 'Miscellaneous'                                        
		,src_Mixed_DPPA                => 'Mixed DPPA'                                                                    
		,src_Mixed_Non_DPPA            => 'Mixed Non-DPPA'                                       
		,src_Mixed_Probation           => 'Mixed Probation'                                      
		,src_Mixed_Utilities           => 'Mixed Utilities' 
		,src_MPRD_Individual           => 'MPRD Individual'
		,src_MMCP						           => 'Michigan Medicaid Custom Program'                                      
		,src_NCOA                      => 'NCOA'                                                 
		,src_NaturalDisaster_Readiness => 'NaturalDisaster Readiness'														
		,src_NCPDP										 => 'NCPDP'							
		,src_NeustarWireless					 => 'Neustar Wireless Phones'
		,src_NPPES                     => 'NPPES'                                                
		,src_OIG                       => 'OIG'                                       
		,src_One_Click_Data            => 'One Click Data'                                       
    ,src_OKC_Probate               => 'OKC Probate' 
		,src_OKC_Student_List					 => 'OKC Student List'
		,src_OSHAIR                    => 'OSHAIR'                                               
		,src_OutwardMedia			         => 'Outward Media Email'                                  
		,src_PBSA	                     => 'United States Postal Service'                   		 	
		,src_Pcnsr    								 => 'PCNSR Phones'                                       	
		,src_Phones_Plus               => 'Phones Plus'
		,src_POS                       => 'Provider of Services'       				
		,src_Professional_License      => 'Professional License'                                 
	  ,src_PSS									     => 'Phone Status Service'
		,src_RealSource																=> 'RealSource Inc Email Addresses'
		,src_Redbooks                  => 'Redbooks International Advertisers'                   
		,src_SalesChannel							 => 'Sales Channel'																				
		,src_CA_Sales_Tax              => 'California Sales Tax'                                 
		,src_IA_Sales_Tax              => 'Iowa Sales Tax'                                       
		,src_SDA                       => 'SDA - Standard Directory of Advertisers'              
		,src_SDAA                      => 'SDAA - Standard Directory of Ad Agencies'             
		,src_SEC_Broker_Dealer         => 'SEC Broker/Dealer'                                    
    ,src_sexoffender               => 'Sex Offender' 		
		,src_Sheila_Greco              => 'Sheila Greco'                                         
		,src_SKA                       => 'SK&A Medical Professionals'                           
		,src_FL_SO                     => 'FL SO'                                                
		,src_GA_SO                     => 'GA SO'                                                
		,src_MI_SO                     => 'MI SO'                                                
		,src_PA_SO                     => 'PA SO'                                                
		,src_UT_SO                     => 'UT SO'                                                
		,src_Spoke                     => 'Spoke'                                                
	//,src_Symphony									 => 'Symphony (aka HXMX) Health Care Claims'// purposely commented out because Symphony and HXMX are the same source
		,src_Targus_White_pages        => 'Targus White pages'                                   
		,src_Tax_practitioner          => 'Tax practitioner'                                     
		,src_TCOA_After_Address        => 'TCOA After Address'                                   
		,src_TCOA_Before_Address       => 'TCOA Before Address'                                  
		,src_Teletrack                 => 'Teletrack'                                            
		,src_Thrive_LT                 => 'Thrive LT (Lending Transactions)'                                            
		,src_Thrive_LT_POE_Email       => 'Thrive LT (Lending Transactions) Used in POE Email'                                            
		,src_Thrive_PD                 => 'Thrive PD (Pay Day)'                                            
		,src_Thrive_PD_POE_Email       => 'Thrive PD (Pay Day) Used in POE Email'                                          
		,src_TransUnion                => 'TransUnion'                                           
		,src_TUCS_Ptrack               => 'TUCS_Ptrack'                                          
		,src_TU_CreditHeader           => 'Transunion Credit Header'                             
		,src_TXBUS                     => 'Texas Sales Tax Registrations(TXBUS)'                 
		,src_UCC                       => 'UCC'                                                  
		,src_UCCV2                     => 'UCCV2'                                                
		,src_UCCV2_WA_Hist             => 'WA Historical UCCV2'                                  
		,src_US_Coastguard             => 'US Coastguard'                                        
		,src_Utilities                 => 'Utilities'                                            
		,src_Util_Work_Phone           => 'Util Work Phone'                                      
		,src_ZUtilities                => 'Z type Utilities'                                     
		,src_ZUtil_Work_Phone          => 'Z type Util Work Phone'                               
		,src_Daily_ZUtilities					 => 'Daily Z Type Utilites'																
		,src_FL_Veh                    => 'FL Veh'                                               
		,src_ID_Veh                    => 'ID Veh'                                               
		,src_KY_Veh                    => 'KY Veh'                                               
		,src_MA_Veh                    => 'MA Veh'                                               
		,src_ME_Veh                    => 'ME Veh'                                               
		,src_MN_Veh                    => 'MN Veh'                                               
		,src_MO_Veh                    => 'MO Veh'                                               
		,src_MS_Veh                    => 'MS Veh'                                               
		,src_MT_Veh                    => 'MT Veh'                                               
		,src_NC_Veh                    => 'NC Veh'                                               
		,src_ND_Veh                    => 'ND Veh'                                               
		,src_NE_Veh                    => 'NE Veh'                                               
		,src_NM_Veh                    => 'NM Veh'                                               
		,src_NV_Veh                    => 'NV Veh'                                               
		,src_OH_Veh                    => 'OH Veh'                                               
		,src_TX_Veh                    => 'TX Veh'                                               
		,src_UT_Veh                    => 'UT Veh'                                               
		,src_WI_Veh                    => 'WI Veh'                                               
		,src_WY_Veh                    => 'WY Veh'  
		,src_AK_Experian_Veh           => 'AK Experian Veh'                                      
		,src_AL_Experian_Veh           => 'AL Experian Veh'                                      
		,src_AR_Experian_Veh           => 'AR Experian Veh' 		//DF16817                                     
		,src_AZ_Experian_Veh           => 'AZ Experian Veh' 		//DF16817                                      
		,src_CO_Experian_Veh           => 'CO Experian Veh'                                      
		,src_CT_Experian_Veh           => 'CT Experian Veh'                                      
		,src_DC_Experian_Veh           => 'DC Experian Veh'                                      
		,src_DE_Experian_Veh           => 'DE Experian Veh'                                      
		,src_FL_Experian_Veh           => 'FL Experian Veh'                                      
		,src_GA_Experian_Veh           => 'GA Experian Veh' 		//DF16817                                      
		,src_IA_Experian_Veh           => 'IA Experian Veh' 		//DF16817                                      
		,src_ID_Experian_Veh           => 'ID Experian Veh'                                      
		,src_IL_Experian_Veh           => 'IL Experian Veh'                                      
		,src_KS_Experian_Veh           => 'KS Experian Veh' 		//DF16817                                      
		,src_KY_Experian_Veh           => 'KY Experian Veh'                                      
		,src_LA_Experian_Veh           => 'LA Experian Veh'                                      
		,src_MA_Experian_Veh           => 'MA Experian Veh'                                      
		,src_MD_Experian_Veh           => 'MD Experian Veh'                                      
		,src_ME_Experian_Veh           => 'ME Experian Veh'                                      
		,src_MI_Experian_Veh           => 'MI Experian Veh'                                      
		,src_MN_Experian_Veh           => 'MN Experian Veh'                                      
		,src_MO_Experian_Veh           => 'MO Experian Veh'                                      
		,src_MS_Experian_Veh           => 'MS Experian Veh'                                      
		,src_MT_Experian_Veh           => 'MT Experian Veh'                                      
		,src_NC_Experian_Veh           => 'NC Experian Veh' 		//DF16817                                      
		,src_ND_Experian_Veh           => 'ND Experian Veh'                                      
		,src_NE_Experian_Veh           => 'NE Experian Veh'                                      
		,src_NM_Experian_Veh           => 'NM Experian Veh'                                      
		,src_NV_Experian_Veh           => 'NV Experian Veh'                                      
		,src_NY_Experian_Veh           => 'NY Experian Veh'                                      
		,src_OH_Experian_Veh           => 'OH Experian Veh'                                      
		,src_OK_Experian_Veh           => 'OK Experian Veh'                                      
		,src_OR_Experian_Veh           => 'OR Experian Veh'                                      
		,src_RI_Experian_Veh           => 'RI Experian Veh' 		//DF16817                                      
		,src_SC_Experian_Veh           => 'SC Experian Veh'                                      
		,src_SD_Experian_Veh           => 'SD Experian Veh' 		//DF16817                                      
		,src_TN_Experian_Veh           => 'TN Experian Veh'                                      
		,src_TX_Experian_Veh           => 'TX Experian Veh'                                      
		,src_UT_Experian_Veh           => 'UT Experian Veh'                                      
		,src_VT_Experian_Veh           => 'VT Experian Veh' 		//DF16817                                      
		,src_WA_Experian_Veh           => 'WA Experian Veh' 		//DF16817                                      
		,src_WI_Experian_Veh           => 'WI Experian Veh'                                      
		,src_WY_Experian_Veh           => 'WY Experian Veh'                                      
		,src_Infutor_Veh           		 => 'Infutor Veh'                                      
		,src_Infutor_Motorcycle_Veh    => 'Infutor Motorcycle Veh'                                      
		,src_Vickers                   => 'Vickers'                                              
		,src_Voters_v2                 => 'Voters v2'                                            
		,src_AK_Watercraft             => 'AK Watercraft'                                        
		,src_AL_Watercraft             => 'AL Watercraft'                                        
		,src_AR_Watercraft             => 'AR Watercraft'                                        
		,src_AZ_Watercraft             => 'AZ Watercraft'                                        
		,src_CO_Watercraft             => 'CO Watercraft'                                        
		,src_CT_Watercraft             => 'CT Watercraft'                                        
		,src_FL_Watercraft             => 'FL Watercraft'                                        
		,src_GA_Watercraft             => 'GA Watercraft'                                        
		,src_IA_Watercraft             => 'IA Watercraft'                                        
		,src_IL_Watercraft             => 'IL Watercraft'                                        
		,src_KS_Watercraft             => 'KS Watercraft'                                        
		,src_KY_Watercraft             => 'KY Watercraft'                                        
		,src_MA_Watercraft             => 'MA Watercraft'                                        
		,src_MD_Watercraft             => 'MD Watercraft'                                        
		,src_ME_Watercraft             => 'ME Watercraft'                                        
		,src_MI_Watercraft             => 'MI Watercraft'                                        
		,src_MN_Watercraft             => 'MN Watercraft'                                        
		,src_MO_Watercraft             => 'MO Watercraft'                                        
		,src_MS_Watercraft             => 'MS Watercraft'                                        
		,src_MT_Watercraft             => 'MT Watercraft'                                        
		,src_NC_Watercraft             => 'NC Watercraft'                                        
		,src_ND_Watercraft             => 'ND Watercraft'                                        
		,src_NE_Watercraft             => 'NE Watercraft'                                        
		,src_NH_Watercraft             => 'NH Watercraft'
		,src_NM_Watercraft						 =>	'NM Watercraft'
		,src_NV_Watercraft             => 'NV Watercraft'                                        
		,src_NY_Watercraft             => 'NY Watercraft'                                        
		,src_OH_Watercraft             => 'OH Watercraft'                                        
		,src_OR_Watercraft             => 'OR Watercraft'                                        
		,src_SC_Watercraft             => 'SC Watercraft'                                        
		,src_TN_Watercraft             => 'TN Watercraft'                                        
		,src_TX_Watercraft             => 'TX Watercraft'                                        
		,src_UT_Watercraft             => 'UT Watercraft'                                        
	  ,src_VA_Watercraft             => 'VA Watercraft'                                        
		,src_WI_Watercraft             => 'WI Watercraft'                                        
		,src_WV_Watercraft             => 'WV Watercraft'                                        
		,src_WY_Watercraft             => 'WY Watercraft'                                        
		,src_WA_Watercraft             => 'WA Watercraft'                                        
		,src_FL_Watercraft_LN          => 'FL Watercraft (LN)'                                   
		,src_KY_Watercraft_LN          => 'KY Watercraft (LN)'                                   
    ,src_MO_Watercraft_LN          => 'MO Watercraft (LN)'
		,src_Infutor_Watercraft				 => 'Infutor Watercraft'
		,src_Whois_domains             => 'Domain Registrations (WHOIS)'                         
		,src_Wired_Assets_Email        => 'Wired Assets Email'                                   
		,src_Wired_Assets_Owned  			 => 'Wired Assets Owned'                                   
		,src_Wired_Assets_Royalty  		 => 'Wired Assets with Royalty'                            
		,src_Wither_and_Die            => 'Wither and Die'                                       
		,src_Workers_Compensation      => 'Workers Compensation'                                 
		,src_MS_Worker_Comp            => 'MS Worker Comp'                                       
		,src_OR_Worker_Comp            => 'OR Worker Comp'                                       
		,src_Yellow_Pages              => 'Yellow Pages'                                         
		,src_ZOOM                      => 'ZOOM' 
		,src_BKFS_Nod                  => 'Black Knight Foreclosure Nod' 
		,src_BKFS_Reo                  => 'Black Knight Foreclosure Reo' 
		,'?' + pSource
	);

	shared dSource_Codes_proj_FBNV2					:= dSource_Codes_proj(regexfind('FBNV2'												,Description	,nocase)) : global;
	shared dSource_Codes_proj_CorpV2				:= dSource_Codes_proj(regexfind('Corporations'								,Description	,nocase)) : global;
	shared dSource_Codes_proj_fLiensV2			:= dSource_Codes_proj(regexfind('liens'												,Description	,nocase)) : global;
	shared dSource_Codes_proj_fProperty			:= dSource_Codes_proj(regexfind('LN_Propertyv2'								,Description	,nocase)) : global;
	shared dSource_Codes_proj_Experian_DL		:= dSource_Codes_proj(regexfind('^(?=.*?Experian.*).*?DL.*$'	,Description	,nocase)) : global;
	shared dSource_Codes_proj_Direct_DL			:= dSource_Codes_proj(regexfind('^(?!.*?Experian.*).*?DL.*$'	,Description	,nocase)) : global;
	shared dSource_Codes_proj_Experian_Veh	:= dSource_Codes_proj(regexfind('^(?=.*?Experian.*).*?Veh.*$'	,Description	,nocase)) : global;
//shared dSource_Codes_proj_Direct_Veh		:= dSource_Codes_proj(regexfind('^(?!.*?Experian.*).*?Veh.*$'	,Description	,nocase)) : global;
	shared dSource_Codes_proj_Direct_Veh		:= dSource_Codes_proj(regexfind('^(?!.*?Experian.*)(?!.*Infutor.*).*?Veh.*$',Description	,nocase)) : global;
	shared dSource_Codes_proj_Infutor_Veh		:= dSource_Codes_proj(regexfind('^Infutor.*Veh.*$'						,Description	,nocase)) : global;
	shared dSource_Codes_proj_Watercraft		:= dSource_Codes_proj(regexfind('Watercraft'									,Description	,nocase)) : global;

	export fSourceCodeSpecific(string pStateFilter = '',dataset(layout_description) psource_codes = dSource_Codes_proj) :=
	function
		State_filter				:= if(pStateFilter != ''
														,regexfind(pStateFilter, psource_codes.Description, nocase)
														,true
												);
		
		dCodes := psource_codes(State_filter);
		
		returncode := dCodes[1].code;
		return returncode;
	end;																																																									

	// --------------------------------------------------------------------------------
	// -- Functions to figure out source codes for builds with multiple source codes
	// -- pass in data to figure out which source code to use
	// --------------------------------------------------------------------------------
	export fSourceCode(string pDescriptionFilter, string pStateFilter = '') :=
	function
		Description_filter	:= regexfind(pDescriptionFilter	, dSource_Codes_proj.Description, nocase);
		State_filter				:= if(pStateFilter != ''
														,regexfind(pStateFilter, dSource_Codes_proj.Description, nocase)
														,true
												);
		
		dCodes := dSource_Codes_proj(Description_filter,State_filter);
		
		returncode := dCodes[1].code;
		return returncode;
	end;

	export fFBNV2(string pTmsid) := 
		case(trim(pTmsid[1..2])
			,'CP'	=>	src_FBNV2_Hist_Choicepoint
			,'FL'	=>	src_FBNV2_FL
			,case(trim(pTmsid[1..3])
				,'ACU'	=>	src_FBNV2_BusReg
				,'CAO'	=>	src_FBNV2_CA_Orange_county
				,'CSC'	=>	src_FBNV2_CA_Santa_Clara  
				,'CAB'	=>	src_FBNV2_CA_San_Bernadino
				,'CAS'	=>	src_FBNV2_CA_San_Diego    
				,'CAV'	=>	src_FBNV2_CA_Ventura      
				,'EXP'	=>	src_FBNV2_Experian_Direct 
				,'INF'	=>	src_FBNV2_INF       
				,'NBX'	=>	src_FBNV2_New_York  
				,'NYN'	=>	src_FBNV2_New_York
				,'NKI'	=>	src_FBNV2_New_York
				,'NQU'	=>	src_FBNV2_New_York
				,'NRI'	=>	src_FBNV2_New_York
				,'TXD'	=>	src_FBNV2_TX_Dallas
				,'TXH'	=>	src_FBNV2_TX_Harris  
				,						''												
		));
	export fCorpV2(string pCorpKey	,string pcorp_state_origin = '') := 
	function
		
		stateabbr := if(trim(pcorpkey) != '', trim(pcorpkey)[1..2], trim(pcorp_state_origin));
		return
		map(
			 stateabbr in ['AK','02']	=>	src_AK_Corporations
			,stateabbr in ['AL','01']	=>	src_AL_Corporations
			,stateabbr in ['AR','05']	=>	src_AR_Corporations
			,stateabbr in ['AZ','04']	=>	src_AZ_Corporations
			,stateabbr in ['CA','06']	=>	src_CA_Corporations
			,stateabbr in ['CO','08']	=>	src_CO_Corporations
			,stateabbr in ['CT','09']	=>	src_CT_Corporations
			,stateabbr in ['DC','11']	=>	src_DC_Corporations
			,stateabbr in ['DE','10']	=>	''										// -- Don't have Delaware
			,stateabbr in ['FL','12']	=>	src_FL_Corporations
			,stateabbr in ['GA','13']	=>	src_GA_Corporations
			,stateabbr in ['HI','15']	=>	src_HI_Corporations
			,stateabbr in ['IA','19']	=>	src_IA_Corporations
			,stateabbr in ['ID','16']	=>	src_ID_Corporations
			,stateabbr in ['IL','17']	=>	src_IL_Corporations
			,stateabbr in ['IN','18']	=>	src_IN_Corporations
			,stateabbr in ['KS','20']	=>	src_KS_Corporations
			,stateabbr in ['KY','21']	=>	src_KY_Corporations
			,stateabbr in ['LA','22']	=>	src_LA_Corporations
			,stateabbr in ['MA','25']	=>	src_MA_Corporations
			,stateabbr in ['MD','24']	=>	src_MD_Corporations
			,stateabbr in ['ME','23']	=>	src_ME_Corporations
			,stateabbr in ['MI','26']	=>	src_MI_Corporations
			,stateabbr in ['MN','27']	=>	src_MN_Corporations
			,stateabbr in ['MO','29']	=>	src_MO_Corporations
			,stateabbr in ['MS','28']	=>	src_MS_Corporations
			,stateabbr in ['MT','30']	=>	src_MT_Corporations
			,stateabbr in ['NC','37']	=>	src_NC_Corporations
			,stateabbr in ['ND','38']	=>	src_ND_Corporations
			,stateabbr in ['NE','31']	=>	src_NE_Corporations
			,stateabbr in ['NH','33']	=>	src_NH_Corporations
			,stateabbr in ['NJ','34']	=>	src_NJ_Corporations
			,stateabbr in ['NM','35']	=>	src_NM_Corporations
			,stateabbr in ['NV','32']	=>	src_NV_Corporations
			,stateabbr in ['NY','36']	=>	src_NY_Corporations
			,stateabbr in ['OH','39']	=>	src_OH_Corporations
			,stateabbr in ['OK','40']	=>	src_OK_Corporations
			,stateabbr in ['OR','41']	=>	src_OR_Corporations
			,stateabbr in ['PA','42']	=>	src_PA_Corporations
			,stateabbr in ['PR','72']	=>	''										// -- Don't have Puerto Rico
			,stateabbr in ['RI','44']	=>	src_RI_Corporations
			,stateabbr in ['SC','45']	=>	src_SC_Corporations
			,stateabbr in ['SD','46']	=>	src_SD_Corporations
			,stateabbr in ['TN','47']	=>	src_TN_Corporations
			,stateabbr in ['TX','48']	=>	src_TX_Corporations
			,stateabbr in ['UT','49']	=>	src_UT_Corporations
			,stateabbr in ['VA','51']	=>	src_VA_Corporations
			,stateabbr in ['VI','78']	=>	''										// -- Don't have Virgin Islands
			,stateabbr in ['VT','50']	=>	src_VT_Corporations
			,stateabbr in ['WA','53']	=>	src_WA_Corporations
			,stateabbr in ['WI','55']	=>	src_WI_Corporations
			,stateabbr in ['WV','54']	=>	src_WV_Corporations
			,stateabbr in ['WY','56']	=>	src_WY_Corporations
			,																''
		);
	end;

	/* -- Not broken out yet.  Future enhancement
	export fLiensV2(string pTmsid) := 
	if(pTmsid[1..3] = 'NYC'	,	src_Liens_v2_NYC
		,case(trim(pTmsid[1..2])
		,'CA'	=>	src_Liens_v2_CA_Federal
		,'CL'	=>	src_Liens_v2_Chicago_Law
		,'CJ'	=>	src_Liens_v2_Chicago_Law
		,'HG'	=>	src_Liens_v2_Hogan
		,'IL'	=>	src_Liens_v2_ILFDLN
		,'MA'	=>	src_Liens_v2_MA    
		,'NY'	=>	src_Liens_v2_NYFDLN
		,'SA'	=>	src_Liens_v2_Service_Abstract
		,'SU'	=>	src_Liens_v2_Superior_Party  
		,					''													
		));
	*/

	export fProperty(string pln_fares_id) := 
	map(
		pln_fares_id[2]  = ''  and pln_fares_id[1] =''  => ''
		,pln_fares_id[2] != 'A' and pln_fares_id[1] ='R' => src_LnPropV2_Fares_Deeds
		,pln_fares_id[2] != 'A' and pln_fares_id[1]!='R' => src_LnPropV2_Lexis_Deeds_Mtgs
		,pln_fares_id[2]  = 'A' and pln_fares_id[1] ='R' => src_LnPropV2_Fares_Asrs
		,pln_fares_id[2]  = 'A' and pln_fares_id[1]!='R' => src_LnPropV2_Lexis_Asrs
		,																										''
	);

	// compare to Drivers.header_src
	export fDLs(string2 pSource, string2 pState) := 
		if(pSource <> src_Experian_DL
			,case(pState			//non-Experian
				,'MO' => src_MO_DL
				,'MN' => src_MN_DL
				,'FL' => src_FL_DL
				,'OH' => src_OH_DL
				,'TX' => src_TX_DL
				,'NM' => src_NM_DL
				,'NV' => src_NV_DL
				,'LA' => src_LA_DL				
				,'WI' => src_WI_DL
				,'ID' => src_ID_DL
				,'OR' => src_OR_DL
				,'ME' => src_ME_DL
				,'WV' => src_WV_DL
				,'MI' => src_MI_DL
				,'UT' => src_UT_DL
				,'IA' => src_IA_DL
				,'MA' => src_MA_DL
				,'TN' => src_TN_DL
				,'WY' => src_WY_DL
				,'KY' => src_KY_DL
				,'CT' => src_CT_DL
				,'NC' => src_NC_DL
				,''             
			)
			,case(pState			//Experian
				,'CO' => src_CO_Experian_DL
				,'DE' => src_DE_Experian_DL
				,'ID' => src_ID_Experian_DL
				,'IL' => src_IL_Experian_DL
				,'KY' => src_KY_Experian_DL
				,'LA' => src_LA_Experian_DL
				,'MD' => src_MD_Experian_DL
				,'MS' => src_MS_Experian_DL
				,'ND' => src_ND_Experian_DL
				,'NH' => src_NH_Experian_DL
				,'SC' => src_SC_Experian_DL
				,'WV' => src_WV_Experian_DL
				,''
			)
		);

	// compare to VehLic.Header_Src
	export fVehicles(string2 pState_Origin, string2 pSource_code) := 
		//if(pSource_code!='AE'
		MAP(pSource_code='AE'				//Experian Vehicles
				=> case(pState_Origin
								,'AK' => src_AK_Experian_Veh
								,'AR' => src_AR_Experian_Veh		//DF16817
								,'AZ' => src_AZ_Experian_Veh		//DF16817
								,'CT' => src_CT_Experian_Veh
								,'DE' => src_DE_Experian_Veh
								,'MD' => src_MD_Experian_Veh
								,'OK' => src_OK_Experian_Veh
								,'SC' => src_SC_Experian_Veh
								,'AL' => src_AL_Experian_Veh
								,'CO' => src_CO_Experian_Veh
								,'DC' => src_DC_Experian_Veh
								,'GA' => src_GA_Experian_Veh		//DF16817
								,'IA' => src_IA_Experian_Veh		//DF16817
								,'IL' => src_IL_Experian_Veh
								,'LA' => src_LA_Experian_Veh
								,'MA' => src_MA_Experian_Veh
								,'MI' => src_MI_Experian_Veh
								,'NY' => src_NY_Experian_Veh
								,'TN' => src_TN_Experian_Veh
								,'UT' => src_UT_Experian_Veh
								,'FL' => src_FL_Experian_Veh
								,'ID' => src_ID_Experian_Veh
								,'KS' => src_KS_Experian_Veh		//DF16817
								,'KY' => src_KY_Experian_Veh
								,'ME' => src_ME_Experian_Veh
								,'MN' => src_MN_Experian_Veh
								,'MS' => src_MS_Experian_Veh
								,'MO' => src_MO_Experian_Veh
								,'MT' => src_MT_Experian_Veh
								,'NC' => src_NC_Experian_Veh		//DF16817
								,'NE' => src_NE_Experian_Veh
								,'NV' => src_NV_Experian_Veh
								,'ND' => src_ND_Experian_Veh
								,'OH' => src_OH_Experian_Veh
								,'RI' => src_RI_Experian_Veh		//DF16817
								,'SD' => src_SD_Experian_Veh		//DF16817
								,'TX' => src_TX_Experian_Veh
								,'VT' => src_VT_Experian_Veh		//DF16817
								,'WA' => src_WA_Experian_Veh		//DF16817
								,'WI' => src_WI_Experian_Veh
								,'WY' => src_WY_Experian_Veh
								,'NM' => src_NM_Experian_Veh
								,'OR' => src_OR_Experian_Veh
								,''
							)
				,pSource_code='1V' => src_Infutor_Veh
				,pSource_code='2V' => src_Infutor_Motorcycle_Veh
		    ,
			     case(pState_Origin
								,'FL' => src_FL_Veh
								,'TX' => src_TX_Veh
								,'MS' => src_MS_Veh
								,'WI' => src_WI_Veh
								,'OH' => src_OH_Veh
								,'MO' => src_MO_Veh
								,'MA' => src_MA_Veh
								,'MN' => src_MN_Veh
								,'ME' => src_ME_Veh
								,'NC' => src_NC_Veh
								,'NM' => src_NM_Veh
								,'NE' => src_NE_Veh
								,'ID' => src_ID_Veh
								,'UT' => src_UT_Veh
								,'ND' => src_ND_Veh
								,'MT' => src_MT_Veh
								,'WY' => src_WY_Veh
								,'NV' => src_NV_Veh
								,'KY' => src_KY_Veh
								,''
							)
		);

	// compare to watercraft.Header_Source_Code
	export fWatercraft(string2 pSource, string2 pState) :=
		if(pSource='CG'
			,src_US_Coastguard
			,if(pSource = 'W1'
				,src_Infutor_Watercraft
				,case(pState
					,'AK'	=> src_AK_Watercraft
					,'AL'	=> src_AL_Watercraft
					,'AR'	=> src_AR_Watercraft
					,'AZ'	=> src_AZ_Watercraft
					,'CO'	=> src_CO_Watercraft
					,'CT'	=> src_CT_Watercraft
					,'GA'	=> src_GA_Watercraft
					,'IA'	=> src_IA_Watercraft
					,'IL'	=> src_IL_Watercraft
					,'KS'	=> src_KS_Watercraft
					,'MA'	=> src_MA_Watercraft
					,'MD'	=> src_MD_Watercraft
					,'ME'	=> src_ME_Watercraft
					,'MI'	=> src_MI_Watercraft
					,'MN'	=> src_MN_Watercraft
					,'MS'	=> src_MS_Watercraft
					,'MT'	=> src_MT_Watercraft
					,'NC'	=> src_NC_Watercraft
					,'ND'	=> src_ND_Watercraft
					,'NE'	=> src_NE_Watercraft
					,'NH'	=> src_NH_Watercraft
					,'NM' => src_NM_Watercraft
					,'NV'	=> src_NV_Watercraft
					,'NY'	=> src_NY_Watercraft
					,'OH'	=> src_OH_Watercraft
					,'OR'	=> src_OR_Watercraft
					,'SC'	=> src_SC_Watercraft
					,'TN'	=> src_TN_Watercraft
					,'TX'	=> src_TX_Watercraft
					,'UT'	=> src_UT_Watercraft
					,'VA'	=> src_VA_Watercraft
					,'WI'	=> src_WI_Watercraft
					,'WV'	=> src_WV_Watercraft
					,'WY'	=> src_WY_Watercraft
					,'FL'	=> src_FL_Watercraft
					,'MO'	=> src_MO_Watercraft
					,'KY'	=> src_KY_Watercraft
					,'FV'	=> src_AK_Fishing_boats
					,'WA' => src_WA_Watercraft
					,''
				)
			)
		);

	// ---------------------------------------------------------------
	// -- Translate Weekly Indicators
	// -- in a normalized record 1, 3, 4, and 7 should never be valid
	// ---------------------------------------------------------------
	export TranslateWeeklyInd(string1 pIn) := 
	case(pIn
		,'W' => 'New'
		,'1' => 'Name Chg,Addr Chg,SSN Chg,Former Name Chg'
		,'2' => 'Name Chg,Addr Chg,SSN Chg'
		,'3' => 'Name Chg,SSN Chg,Former Name Chg'
		,'4' => 'Name Chg,Addr Chg,Former Name Chg'
		,'5' => 'Name Chg,Addr Chg'
		,'6' => 'Name Chg,SSN Chg'
		,'7' => 'Name Chg,Former Name Chg'
		,'N' => 'Name Chg'
		,'8' => 'Addr Chg,SSN Chg,Former Name Chg'
		,'9' => 'Addr Chg,SSN Chg'
		,'Y' => 'Addr Chg,Former Name Chg'
		,'A' => 'Addr Chg'
		,'Z' => 'SSN Chg,Former Name Chg'
		,'S' => 'SSN Chg'
		,'F' => 'Former Name Chg'
		,'-' => 'No Relevant Information'
		,pIn
	);

	//convert multiple sources for source match usage
	export str_convert_property := 'PP';
	export str_convert_utility  := 'UU';
	export str_convert_ATF      := 'AF';
	export str_convert_DL       := 'DR';
	export str_convert_vehicle  := 'VV';
	export str_convert_WC       := 'WC';
	export str_convert_infutor  := 'IF';
	export filter_from_moxie              := [
		 src_Certegy                   ,src_Experian_Credit_Header    ,src_TUCS_Ptrack      ,src_Experian_Phones         
	];

	// external source descriptions
	STRING extATF					:= 'Federal Firearms and Explosives Licenses';
	STRING extBK					:= 'Bankruptcy Records';
	STRING extLIEN				:= 'Liens and Judgments';
	STRING extDL					:= 'Driver Licenses';
	STRING extDEATH				:= 'Deceased';
	STRING extPROFLIC			:= 'Professional Licenses';
	STRING extPSS	  			:= 'Phone Status Service';
	STRING extSANC				:= 'Sanctions';
	STRING extVEH					:= 'Motor Vehicle Registrations';
	STRING extDEA					:= 'DEA Controled Substance Registrations';
	STRING extAIRC				:= 'FAA Aircraft Registrations';
	STRING extPILOTCERT		:= 'FAA Pilot Certifications';
	STRING extEMAIL				:= 'Email addresses';
	STRING extWATERCRAFT	:= 'WaterCraft Registrations';
	STRING extCORPAFFIL		:= 'Corporate Affiliations';
	STRING extVOTER				:= 'Voter Registrations';
	STRING extPP					:= 'PhonesPlus Records';
	STRING extCCW					:= 'Weapon Permits';
	STRING extCCW_NY					:= 'NY Weapon Permits'; // 'NY Pistol Permits';
	STRING extHUNT				:= 'Hunting and Fishing Licenses';
	STRING extWHOIS				:= 'Internet Domain Registrations';
	STRING extPHONE				:= 'Phones';
	STRING extSO					:= 'Sexual Offense';
	STRING extFOR					:= 'Foreclosure Records';
	STRING extNOD					:= 'Notice Of Defaults Records';
	STRING extFBN					:= 'Fictitious Business Names Records';
	STRING extUCC					:= 'UCC Lien Filings';
	STRING extDEED				:= 'Deed Transfers';
	STRING extDOC					:= 'Criminal';
	STRING extASSESSMENT	:= 'Tax Assessor Records';
	STRING extUTIL				:= 'Utility Locator';
	STRING extSTATEDEATH	:= 'State Death Records';
	STRING extPL1					:= 'Person Locator 1';
	STRING extPL2					:= 'Person Locator 2';
	STRING extPL4					:= 'Person Locator 4';
	STRING extPL5					:= 'Person Locator 5';
	STRING extPL6					:= 'Person Locator 6';
	STRING extHistPL			:= 'Historical Person Locator';

	EXPORT TranslateSourceExternal(STRING2 src) :=
	MAP(src IN set_ATF									=> extATF,
			src IN set_BK										=> extBK,
			src IN set_Liens								=> extLIEN,
			src IN set_DL										=> extDL,
			src IN [set_Death_Master,
							set_Death_Restricted]		=> extDEATH,
			src IN set_Professional_License => extPROFLIC,
			src IN set_PSS									=> extPSS,		
			src IN set_Ingenix_Sanctions 		=> extSANC,
			src IN set_Vehicles							=> extVEH,	
			src IN set_DEA									=> extDEA,
			src IN set_Aircrafts						=> extAIRC,
			src IN set_Airmen								=> extPILOTCERT,
			src IN set_email								=> extEMAIL,
			src IN set_WC										=> extWATERCRAFT,
			src IN set_CorpV2								=> extCORPAFFIL,
			src IN set_Voters_v2						=> extVOTER,
			src IN set_EMerge_CCW						=> extCCW,
			src IN set_EMerge_CCW_NY					=> extCCW_NY,
			src IN [src_EMerge_Hunt,
							src_EMerge_Fish]				=> extHUNT,
			src IN set_Whois_domains				=> extWHOIS,
			src IN set_Gong +
						 set_Gong_phone_append		=> extPHONE,
			src IN set_Sex_Offender					=> extSO,
			src IN set_Foreclosures					=> extFOR,
			src IN set_Foreclosures_Delinquent => extNOD,
			src IN set_Fbnv2								=> extFBN,
			src IN set_UCCS									=> extUCC,
			src IN [src_Fares_Deeds_from_Asrs,
							src_LnPropV2_Fares_Deeds,
							src_LnPropV2_Lexis_Deeds_Mtgs] => extDEED,
			src IN set_Criminal_History			=> extDOC,
			src IN [src_LnPropV2_Fares_Asrs,
							src_LnPropV2_Lexis_Asrs]	=> extASSESSMENT,
			src IN set_Utility_sources +
						 set_Certegy							=> extUTIL,
			src IN set_Death_State					=> extSTATEDEATH,
			src IN set_Equifax							=> extPL1,
			src IN set_Transunion						=> extPL2,
			src IN set_Transunion_Credit_Header	=> extPL6,
			src IN set_Targus_White_pages		=> extPL4,
			src IN set_Experian_Credit_Header => extPL5,
			src IN set_FDIC									=> extHistPL,
			src IN set_Phonesplus						=> extPP,
			'Unknown('+src+')'
			);
	
	// State determination from DPPA Sources
	export DPPAOriginState(string2 src) := case(src,
		 src_AK_Fishing_boats => 'AK'
		,src_CT_DL            => 'CT'
		,src_FL_DL            => 'FL'
		,src_IA_DL            => 'IA'
		,src_ID_DL            => 'ID'
		,src_KY_DL            => 'KY'
		,src_MA_DL            => 'MA'  
		,src_ME_DL            => 'ME'
		,src_MI_DL            => 'MI'
		,src_MN_DL            => 'MN'
		,src_MO_DL            => 'MO'
		,src_NC_DL            => 'NC'
		,src_NE_DL            => 'NE'
		,src_NM_DL            => 'NM'
		,src_NV_DL						=> 'NV'	
		,src_LA_DL            => 'LA'
		,src_OH_DL            => 'OH'
		,src_OR_DL            => 'OR'
		,src_TN_DL            => 'TN'
		,src_TX_DL            => 'TX'
		,src_WI_DL            => 'WI'
		,src_WV_DL            => 'WV'
		,src_WY_DL            => 'WY'
		,src_CO_Experian_DL   => 'CO'
		,src_DE_Experian_DL   => 'DE'
		,src_ID_Experian_DL   => 'ID'
		,src_IL_Experian_DL   => 'IL'
		,src_KY_Experian_DL   => 'KY'
		,src_LA_Experian_DL   => 'LA'
		,src_MD_Experian_DL   => 'MD'
		,src_MS_Experian_DL   => 'MS'
		,src_ND_Experian_DL   => 'ND'
		,src_NH_Experian_DL   => 'NH'
		,src_SC_Experian_DL   => 'SC'
		,src_WV_Experian_DL   => 'WV'
		,src_Mixed_DPPA       => ''  
		,src_FL_Veh           => 'FL'
		,src_ID_Veh           => 'ID'
		,src_KY_Veh           => 'KY'
		,src_MA_Veh           => 'MA'
		,src_ME_Veh           => 'ME'
		,src_MN_Veh           => 'MN'
		,src_MO_Veh           => 'MO'
		,src_MS_Veh           => 'MS'
		,src_MT_Veh           => 'MT'
		,src_NC_Veh           => 'NC'
		,src_ND_Veh           => 'ND'
		,src_NE_Veh           => 'NE'
		,src_NM_Veh           => 'NM'    
		,src_NV_Veh           => 'NV'    
		,src_OH_Veh           => 'OH'    
		,src_TX_Veh           => 'TX'    
		,src_WI_Veh           => 'WI'    
		,src_WY_Veh           => 'WY'    
		,src_AK_Experian_Veh  => 'AK'    
		,src_AL_Experian_Veh  => 'AL'  
		,src_AR_Experian_Veh  => 'AR'		//DF16817    
		,src_AZ_Experian_Veh  => 'AZ'		//DF16817    
		,src_CO_Experian_Veh  => 'CO'    
		,src_CT_Experian_Veh  => 'CT'    
		,src_DC_Experian_Veh  => 'DC'    
		,src_DE_Experian_Veh  => 'DE'    
		,src_FL_Experian_Veh  => 'FL'    
		,src_GA_Experian_Veh  => 'GA'		//DF16817    
		,src_IA_Experian_Veh  => 'IA'		//DF16817    
		,src_ID_Experian_Veh  => 'ID'    
		,src_IL_Experian_Veh  => 'IL'    
		,src_KS_Experian_Veh  => 'KS'		//DF16817    
		,src_KY_Experian_Veh  => 'KY'    
		,src_LA_Experian_Veh  => 'LA'    
		,src_MA_Experian_Veh  => 'MA'    
		,src_MD_Experian_Veh  => 'MD'    
		,src_ME_Experian_Veh  => 'ME'    
		,src_MI_Experian_Veh  => 'MI'    
		,src_MN_Experian_Veh  => 'MN'    
		,src_MO_Experian_Veh  => 'MO'    
		,src_MS_Experian_Veh  => 'MS'    
		,src_MT_Experian_Veh  => 'MT'    
		,src_NC_Experian_Veh  => 'NC'		//DF16817    
		,src_ND_Experian_Veh  => 'ND'    
		,src_NE_Experian_Veh  => 'NE'    
		,src_NM_Experian_Veh  => 'NM'    
		,src_NV_Experian_Veh  => 'NV'    
		,src_NY_Experian_Veh  => 'NY'    
		,src_OH_Experian_Veh  => 'OH'    
		,src_OK_Experian_Veh  => 'OK'    
		,src_OR_Experian_Veh  => 'OR'    
		,src_SC_Experian_Veh  => 'SC'    
		,src_SD_Experian_Veh  => 'SD'		//DF16817    
		,src_RI_Experian_Veh  => 'RI'		//DF16817    
		,src_TN_Experian_Veh  => 'TN'    
		,src_TX_Experian_Veh  => 'TX'    
		,src_UT_Experian_Veh  => 'UT'    
		,src_VT_Experian_Veh  => 'VT'		//DF16817    
		,src_WA_Experian_Veh  => 'WA'		//DF16817    
		,src_WI_Experian_Veh  => 'WI'    
		,src_WY_Experian_Veh  => 'WY'    
		,src_AK_Watercraft    => 'AK'    
		,src_AL_Watercraft    => 'AL'    
		,src_AR_Watercraft    => 'AR'    
		,src_AZ_Watercraft    => 'AZ'    
		,src_CO_Watercraft    => 'CO'    
		,src_CT_Watercraft    => 'CT'    
		,src_FL_Watercraft    => 'FL'    
		,src_GA_Watercraft    => 'GA'    
		,src_IA_Watercraft    => 'IA'    
		,src_IL_Watercraft    => 'IL'    
		,src_KS_Watercraft    => 'KS'    
		,src_KY_Watercraft    => 'KY'    
		,src_MA_Watercraft    => 'MA'    
		,src_MD_Watercraft    => 'MD'    
		,src_ME_Watercraft    => 'ME'    
		,src_MI_Watercraft    => 'MI'    
		,src_MN_Watercraft    => 'MN'    
		,src_MO_Watercraft    => 'MO'    
		,src_MS_Watercraft    => 'MS'    
		,src_MT_Watercraft    => 'MT'    
		,src_NC_Watercraft    => 'NC'    
		,src_ND_Watercraft    => 'ND'    
		,src_NE_Watercraft    => 'NE'    
		,src_NH_Watercraft    => 'NH'
    ,src_NM_Watercraft		=> 'NM'
		,src_NV_Watercraft    => 'NV'    
		,src_NY_Watercraft    => 'NY'    
		,src_OH_Watercraft    => 'OH'    
		,src_OR_Watercraft    => 'OR'    
		,src_SC_Watercraft    => 'SC'    
		,src_TN_Watercraft    => 'TN'    
		,src_TX_Watercraft    => 'TX'    
		,src_UT_Watercraft    => 'UT'    
		,src_VA_Watercraft    => 'VA'    
		,src_WI_Watercraft    => 'WI'    
		,src_WV_Watercraft    => 'WV'    
		,src_WY_Watercraft    => 'WY'    
		,src_FL_Watercraft_LN => 'FL'    
		,src_KY_Watercraft_LN => 'KY'    
		,src_MO_Watercraft_LN => 'MO'
		,'');

end;