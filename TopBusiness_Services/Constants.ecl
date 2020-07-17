import MDR, TopBusiness, BIPV2;

export constants:= module;

  EXPORT STRINGSIMILARCONSTANT := 5;
  //v--- per the product requirements document, "... data is in hundreds(?) of thousands",
  //     but on 09/21/12 Debra Winkleman in Risk Data Receiving contacted the data  
  //     supplier and their contact person says it is in thousands.
  // RQ-14844 - Sales is now in 100s;	
  // RQ-16262 - Sales back to 1000s
  EXPORT EbrAnnSalesMultiplier :=	1000;
  
  // v--- leftover from BIP1?, no longer needed?
     export unsigned4 section_ContactID                     :=  1 << 1;
	//section_feinID                                       := 2;
     export unsigned4 section_FinanceID                     :=  1 << 2;
     export unsigned4 section_IncorporationID               :=  1 << 3;
     export unsigned4 section_IndustryID                    :=  1 << 4;
     export unsigned4 section_uccID                         :=  1 << 5;
     export unsigned4 section_URLID                         :=  1 << 6;
     export unsigned4 section_TradelineID                   :=  1 << 7;
     export unsigned4 section_LiensID                       :=  1 << 8;
     export unsigned4 section_AircraftID                    :=  1 << 9;
     export unsigned4 section_WatercraftID                  :=  1 << 10;
     export unsigned4 section_MotorVehicleID                :=  1 << 11;
	export unsigned4 section_PropertyID                    :=  1 << 12;
     export unsigned4 section_BankruptcyID                  :=  1 << 13;
     export unsigned4 section_ForeclosureNODID              :=  1 << 14;
     export unsigned4 section_Associates_RegisteredAgentsID :=  1 << 15;
     export unsigned4 section_Associates_PeopleID           :=  1 << 16;
      export unsigned4 section_Associates_businessesID       :=  1 << 17;

  // v--- Remove these "*_max_* fields here and revise the appropriate report section to use
	//      the correct max value from iesp.Constants.TOPBUSINESS.MAX_COUNT_BIZRPT_***
  export unsigned2 associate_max_busper_recs  := 100; // reqs 1280 & 1410

  export unsigned2 incorp_max_incorp_recs := 10; // req 0510

  export unsigned2 industry_max_abs_recs  := 100000; //bip2, not used???
  export unsigned2 industry_max_ind_recs  := 100000; //bip2, not used???
	
  export unsigned2 liens_max_main_recs    := 100;
  export unsigned2 liens_max_party_recs   := 100;

  export unsigned2 motorvehicle_max_curpri_recs  := 50; // req 1090

  export unsigned4 opsites_max_addrphone_recs := 200000;  //no longer needed for bip2???
  export unsigned2 opsites_max_addr_recs      := 50; // req 0470???
  //export unsigned2 opsites_max_incorp_recs    := 100; // renamed for bip2, see above
  export unsigned2 opsites_max_phone_recs     := 5;  // req 0482
	
  export unsigned2 ucc_max_byrole_recs           := 100; // req 0770

  export unsigned2 watercraft_max_curpri_recs    := 50; // req 1090
	
	// used as param to pass into *Key_LinkIds.kfetch
     export unsigned4 defaultJoinLimit := 10000; 
     
     export unsigned4 SlimKeepLimit := 10000; 
     export unsigned4 SmallKeepLimit := 5000; 
     export unsigned4 SmallerKeepLimit := 2500;
     export unsigned4 SmallestKeepLimit := 1000;
     export unsigned4 PropertySectionKeepLimit := 5000; 
     export unsigned4 SearchFidKeyConstant := 10;	
     export unsigned4 PropertyKeepConstant := 5;
     export unsigned4 PropertyKeepDeedConstant := 50;
     export unsigned4 PropertyKfetchMaxLimit := 5000;
     export unsigned4 ForeclosureNODKfetchMaxLimit := 500;    
     export unsigned4 ForeclosureSrcDocsKfetchMaxLimit := 5;   
     export unsigned4 NodSrcDocskfetchMaxLimit := 5;  
     export unsigned4 ForeclosureSourceDocsFidLimit := 50;    
     export unsigned4 NodSourceDocsFidLimit := 50; 
     
     export unsigned4 OtherCompanyNamesVariationsMax := 199;
  
     export unsigned4  OTHERCNAMES_SRCDOC_RECORDS := 50; 
     // value here is less than iesp.constants.MAX_COUNT_BIZRPT_SRCDOC_RECORDS
     
     export unsigned4 BusHeaderKfetchMaxLimitLarger := 17000;
     export unsigned4 BusHeaderKfetchMaxLimit := 10000;
     export unsigned4 DirectoriesKfetchMaxLimit := 2500; // used to be 5000
     export unsigned4 GongKfetchMaxLimit := 5000; // used to be 10000
     export unsigned4 AtfSourceDocsKfetchMaxLimit := 5000;
     export unsigned4 DeaSourceDocsKfetchMaxLimit := 5000;
     export unsigned4 FCCSourceDocsKfetchMaxLimit := 5000;
     export unsigned4 ProfLicSourceDocsKfetchMaxLimit := 5000;
     export unsigned4 CalBusKfetchMaxLimit := 5000;
     export unsigned4 SpokeKfetchMaxLimit := 5000;
     export unsigned4 BestKfetchMaxLimit := 1000;
     export unsigned4 BestKfetchMaxLimitConnectedBusinesses := 100;
     export unsigned4 ConnectedBusinessesKfetchMaxLimit := 2500;
     export unsigned4 UCCKfetchMaxLimit := 10000;	
     export unsigned4 ContactsKfetchMaxLimit := 20000;
     export unsigned4 ContactsKfetchSlimLimit := 15000;
     export unsigned2 AddressSourceOrder(string2 src) := which(
		MDR.SourceTools.SourceIsDCA(src),
		MDR.SourceTools.SourceIsDunn_Bradstreet(src),
		MDR.SourceTools.SourceIsSDA(src),
		MDR.SourceTools.SourceIsSDAA(src),
		MDR.SourceTools.SourceIsMartindale_Hubbell(src),
		MDR.SourceTools.SourceIsFDIC(src),
		MDR.SourceTools.SourceIsBankruptcy(src),
		MDR.SourceTools.SourceIsLiens(src),
		MDR.SourceTools.SourceIsUCCs(src),
		MDR.SourceTools.SourceIsIRS_5500(src),
		MDR.SourceTools.SourceIsDunn_Bradstreet_FEIN(src),
		MDR.SourceTools.SourceIsEBR(src),
		MDR.SourceTools.SourceIsProperty(src),
		MDR.SourceTools.SourceIsGong(src),
		MDR.SourceTools.SourceIsCorpV2(src),
		MDR.SourceTools.SourceIsFBNv2(src),
		MDR.SourceTools.SourceIsIRS_Non_Profit(src),
		MDR.SourceTools.SourceIsWorkmans_Comp(src),
		MDR.SourceTools.SourceIsVehicle(src) or MDR.SourceTools.SourceIsBBB(src),
		MDR.SourceTools.SourceIsWhois_Domains(src),
		MDR.SourceTools.SourceIsSheila_Greco(src),
		MDR.SourceTools.SourceIsSpoke(src),
		//MDR.SourceTools.SourceIsJigsaw(src), // data agreement terminated as of 12/31/13
		MDR.SourceTools.SourceIsZoom(src),
		MDR.SourceTools.SourceIsTXBUS(src) or MDR.SourceTools.SourceIsCalbus(src) or
		MDR.SourceTools.SourceIsINFOUSA_DEAD_COMPANIES(src) or MDR.SourceTools.SourceIsINFOUSA_ABIUS_USABIZ(src),
		true);

     export unsigned2 BusinessDescSourceOrder(string2 src) := which(
		MDR.SourceTools.SourceIsDCA(src),
		MDR.SourceTools.SourceIsSheila_Greco(src),
		MDR.SourceTools.SourceIsINFOUSA_DEAD_COMPANIES(src),
		MDR.SourceTools.SourceIsSpoke(src),
		MDR.SourceTools.SourceIsEquifax_Business_Data(src),
		MDR.SourceTools.SourceIsInfutor_NARB (src),
		true);

     export unsigned2 CompanyNameSourceOrder(string2 src) := which(
		MDR.SourceTools.SourceIsDCA(src),
		MDR.SourceTools.SourceIsCorpV2(src),
		MDR.SourceTools.SourceIsBankruptcy(src),
		MDR.SourceTools.SourceIsDunn_Bradstreet(src),
		MDR.SourceTools.SourceIsSDA(src),
		MDR.SourceTools.SourceIsSDAA(src),
		MDR.SourceTools.SourceIsMartindale_Hubbell(src),
		MDR.SourceTools.SourceIsEBR(src),
		MDR.SourceTools.SourceIsIRS_5500(src),
		MDR.SourceTools.SourceIsFDIC(src),
		MDR.SourceTools.SourceIsIRS_Non_Profit(src),
		MDR.SourceTools.SourceIsWorkmans_Comp(src),
		MDR.SourceTools.SourceIsDunn_Bradstreet_FEIN(src),
		MDR.SourceTools.SourceIsLiens(src),
		MDR.SourceTools.SourceIsUCCs(src),
		MDR.SourceTools.SourceIsVehicle(src),
		MDR.SourceTools.SourceIsGong(src),
		MDR.SourceTools.SourceIsWhois_Domains(src),
		MDR.SourceTools.SourceIsYellow_Pages(src),
		MDR.SourceTools.SourceIsTargus_White_Pages(src),
		MDR.SourceTools.SourceIsProperty(src),
		MDR.SourceTools.SourceIsFBNv2(src),
		MDR.SourceTools.SourceIsBBB(src),
		MDR.SourceTools.SourceIsSheila_Greco(src),
		MDR.SourceTools.SourceIsSpoke(src),
		//MDR.SourceTools.SourceIsJigsaw(src), // data agreement terminated as of 12/31/13
		MDR.SourceTools.SourceIsZoom(src),
		MDR.SourceTools.SourceIsTXBUS(src) or MDR.SourceTools.SourceIsCalbus(src) or
		MDR.SourceTools.SourceIsINFOUSA_DEAD_COMPANIES(src) or MDR.SourceTools.SourceIsINFOUSA_ABIUS_USABIZ(src),
		true);
		
     export unsigned2 IndustryDescSourceOrder(string2 src) := which(
		MDR.SourceTools.SourceIsDunn_Bradstreet(src),
		MDR.SourceTools.SourceIsFrandx(src),
		MDR.SourceTools.SourceIsEBR(src),
		MDR.SourceTools.SourceIsFBNv2(src),
		MDR.SourceTools.SourceIsBusiness_Registration(src),
		MDR.SourceTools.SourceIsCorpV2(src),
		MDR.SourceTools.SourceIsCalbus(src),
		MDR.SourceTools.SourceIsIRS_Non_Profit(src),
		MDR.SourceTools.SourceIsSheila_Greco(src),
		MDR.SourceTools.SourceIsZoom(src),
		MDR.SourceTools.SourceIsEquifax_Business_Data(src),
		MDR.SourceTools.SourceIsInfutor_NARB (src),
		true);

     export unsigned2 PhoneSourceOrder(string2 src) := which(
		MDR.SourceTools.SourceIsGong(src),
		true);

     export unsigned2 ProfileSourceOrder(string2 src) := which(
		MDR.SourceTools.SourceIsDCA(src),
		MDR.SourceTools.SourceIsEBR(src),
		MDR.SourceTools.SourceIsDunn_Bradstreet(src),
		MDR.SourceTools.SourceIsSDA(src),
		MDR.SourceTools.SourceIsSDAA(src),
		MDR.SourceTools.SourceIsMartindale_Hubbell(src),
		MDR.SourceTools.SourceIsCorpV2(src),
		MDR.SourceTools.SourceIsIRS_5500(src),
		MDR.SourceTools.SourceIsFDIC(src),
		MDR.SourceTools.SourceIsDunn_Bradstreet_FEIN(src),
		MDR.SourceTools.SourceIsBankruptcy(src),
		MDR.SourceTools.SourceIsFBNv2(src),
		MDR.SourceTools.SourceIsLiens(src),
		MDR.SourceTools.SourceIsUCCs(src),
		MDR.SourceTools.SourceIsVehicle(src),
		true);
	
     export unsigned2 UrlSourceOrder(string2 src) := which(
		MDR.SourceTools.SourceIsDCA(src),
		//not MDR.SourceTools.SourceIsJigsaw(src), // data agreement terminated as of 12/31/13
		true);
	
     export unsigned2 YearsInBusinessSourceOrder(string2 src) := which(
		MDR.SourceTools.SourceIsDunn_Bradstreet(src),
		MDR.SourceTools.SourceIsCorpV2(src),
		MDR.SourceTools.SourceIsCalbus(src),
		MDR.SourceTools.SourceIsTXBUS(src),
		MDR.SourceTools.SourceIsINFOUSA_DEAD_COMPANIES(src),
		MDR.SourceTools.SourceIsINFOUSA_ABIUS_USABIZ(src),
		true);

   // Associate Section "Role" types
      export string ASSOCIATE_ROLE_BANKR := 'Bankruptcy';
      export string ASSOCIATE_ROLE_FC    := 'Foreclosure';
      export string ASSOCIATE_ROLE_JL    := 'Judgment/Lien';
      export string ASSOCIATE_ROLE_MVR   := 'MVR';
      export string ASSOCIATE_ROLE_NOD   := 'NOD';
      export string ASSOCIATE_ROLE_RP    := 'Real Property'; //???
      export string ASSOCIATE_ROLE_UCC   := 'UCC';
      export string ASSOCIATE_ROLE_WC    := 'Watercraft';
		
 	 // Judgments&Liens and UCCs party-type values
   export string1 ATTORNEY     := 'A'; // On J&Ls only 
	 //also create a string2 one for Attorney for Debtor = 'AD';??? //in J/Ls only???
   export string1 CREDITOR     := 'C'; // On J&Ls only 
   export string1 THIRDPARTY   := 'T'; // On J&Ls only 
   export string1 DEBTOR       := 'D'; // On both
   export string1 ASSIGNEE     := 'A'; // on UCCs only
   export string1 SECUREDPARTY := 'S'; // on UCCs only

	 // Vehicle "party" key orig_name_type values
      export string1 VEH_OWNER		 		:= '1';
      export string1 VEH_LESSOR			:= '2';
      export string1 VEH_REGISTRANT 	:= '4';
      export string1 VEH_LESSEE			:= '5';
      export string1 VEH_LIENHOLDER  := '7';
	 
   // Used in multiple sections
   export string1 CURRENT    := 'C';
   export string1 PRIOR      := 'P';
      export string1 ACTIVE     := 'A';
      export string1 TERMINATED := 'T';
   export string1 BUSINESS   := 'B';
   export string1 PERSON     := 'P';
      export string2 OTHERBUSINESSFILINGS := 'OB';
	 
      export string1 POSITION_TYPE_CURRENT := 'C';
      export string1 POSITION_TYPE_REGISTERED_AGENT := 'R';
      export string1 POSITION_TYPE_OTHERS := 'O';
	

   // Source Summary Section, category number(order) and name (from req BIZ2.0-1430 + emails)
      export string LncaCategoryName      := '01LexisNexis Corporate Affiliations'; // or just LNCA???
      export string EbrCategoryName       := '02Experian Business Data'; // source name changed
	 //NOTE1: category 3 intentionally left out. It used to be for D&B DMI, but that data is not to be returned 
      export string RealPropCategoryName  := '04Real Property'; 
      export string PersPropCategoryName  := '05Personal Property'; 
   export string CorpCategoryName      := '06Corporate Filings';
      export string BankrCategoryName     := '07Bankruptcy'; 
	 //NOTE2: category 8 intentionally left out. It used to be for Default Notice/Foreclosure, but that data was combined into category 4
   export string LiensCategoryName     := '09Judgment & Liens'; 
   export string UccCategoryName       := '10UCC';
      export string GovAgCategoryName     := '11Government Agency';
      export string OtherDirCategoryName  := '12Other Directories';
      export string TelecoCategoryName    := '13Telco';
      export string ExperianFEINCategoryName := '14Experian FEIN';
      export string ExperianCRDBCategoryName := '15Experian'; // source name changed
      export string SaferCensusCategoryName  := '16Dept. Of Transportation SAFER Crash Carrier';
	 //export string CommClueCategoryName     := '17Business Exchange';  //cat name???
      export string FranchiseDirCategoryName := '18Franchise Directory';

   // Source Docs/Source Service related
   //	
	 // Linkids key fetch default level
      export sourceLinkIdLevel := BIPV2.IDconstants.Fetch_Level_SELEID;

	 // Report Section names
      export string AircraftSectionName     := 'Aircraft';
      export string AssociateSectionName    := 'Associate';
      export string BankruptcySectionName   := 'Bankruptcy';
      export string BestSectionName         := 'Best';
      export string ConnectedBusSectionName := 'ConnectedBus';
      export string ContactSectionname      := 'Contact';
      export string CorpSectionName         := 'Corp';
      export string FinanceSectionName      := 'Finance';
      export string ForeclosureNODSectionName := 'ForeclosureNOD';
      export string IndustrySectionName     := 'Industry';
      export string LicenseSectionName      := 'License';
      export string LienSectionName         := 'Lien';
      export string MVRSectionName          := 'MVR';
      export string OpSitesSectionName      := 'OpSites';
      export string ParentSectionName       := 'Parent';
      export string PropertySectionName     := 'Property';
      export string RegAgentSectionName     := 'RegAgent';
      export string SourceSectionName       := 'Source';
      export string UCCSectionName          := 'UCC';
      export string URLSectionName          := 'URL';
      export string WatercraftSectionName   := 'Watercraft';

   // Source Docs IdType values
      export string corpkey          := 'corpkey';          // for Corp/Incorporation data
      export string enterprisenumber := 'enterprisenumber'; // for DCAV2/LNCA
      export string filenumber       := 'filenumber';       // for EBR
      export string efxid := 'efx_id';  // for Experian bus data
      export string foreclosureid    := 'foreclosureid';    // for foreclosure & nod
      export string propertykeys     := 'ln_fares_id';      // for real property
      export string sourcerecid      := 'source_rec_id';    // for BusRegs & ???
      export string tmsid            := 'tmsid';            // for Bankruptcy, Liens & UCCs
      export string taxid	          := 'taxid';            // for Experian Fein
      export string vehiclekeys      := 'vehiclekeys';      // for MVR/VehicleV2, idvalue is vehicle_key//iteration_key//sequence_key
      export string vehiclesrcrec    := 'vehiclesrcrec';    // for MVR/VehicleV2, idvalue is source rec id
      export string watercraftkeys   := 'watercraftkeys';   // for Watercraft, idvalues is st//watercraft_key//sequence_key
      export string watercraftsrcrec := 'watercraftsrcrec'; // for watercraft, idvalue is source rec
      export string lienkeys   			:= 'lienkeys';   			 // for Lien, idvalue is tmside
      export string liensrcrec 			:= 'liensrcrec'; 			 // for lien, idvalue is source rec id
      export string sourcedocid			:= 'sourcedocid';		   // unique indentifier per source doc.	
      export string busvlid 					:= 'vl_id'; 			 		 // indicates that value is from bus header vl_id field.
	//others???
	
	// Listing types
     EXPORT PhoneTypeDescription :=		MODULE
           EXPORT Business    := 'BUSINESS';
           EXPORT Government  := 'GOVERNMENT';
           EXPORT Residential := 'RESIDENTIAL';
     END;
	
	// Foreign Domestic Description
     EXPORT ForeignDomesticDescription :=		MODULE
           EXPORT Foreign    := 'Foreign';
           EXPORT Domestic  	:= 'Domestic';
     END;
     
      EXPORT BusinessInsight := MODULE
           EXPORT unsigned4 UCCBusinessInsightKfetchMaxLimit := 1000;
           EXPORT unsigned2 MaxIndicatorCodesReturned := 20;
      END;
      
END;