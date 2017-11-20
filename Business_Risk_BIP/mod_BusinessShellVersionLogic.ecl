IMPORT ut;

EXPORT mod_BusinessShellVersionLogic(Business_Risk_BIP.LIB_Business_Shell_LIBIN Options) := MODULE

  // Some aliases to keep things tidy.
  SHARED busShellVersion     := Options.BusShellVersion;  
  SHARED fieldDelimiter      := Business_Risk_BIP.Constants.FieldDelimiter;
  
  // Function to blank out attributes that are not to be returned in the requested business shell version.
  SHARED checkVersion(STRING fieldValue, UNSIGNED minVersion = 2) := IF(busShellVersion < minVersion, '', fieldValue);

  // Make sure that something is populated, even if we don't get a hit on the key, and verify that the attribute is included in the version we are running
  SHARED checkBlank(STRING field, STRING default_val, UNSIGNED minVersion=2) := 
    MAP(Options.BusShellVersion < minVersion => '',
        field = '' => default_val, 
        field);
	
	// Starting in business shell version 3.0, if the business did not exist as of the archive date (VerInputIDTruebiz = '0'), 
	// return the default value like we do when BIP IDs are not assigned.
	EXPORT checkTrueBiz(STRING fieldValue, STRING VerInputIDTruebiz, STRING DefaultValue = '-1') := 
																	IF(BusShellVersion < Business_Risk_BIP.Constants.BusShellVersion_v30 OR VerInputIDTruebiz = '1', fieldValue, DefaultValue);

	EXPORT checkBestAddr(STRING fieldValue, STRING BestSourceCount) := 
																	IF(BusShellVersion < Business_Risk_BIP.Constants.BusShellVersion_v30 OR (INTEGER)BestSourceCount > 0, fieldValue, '-1');

		EXPORT _InputAddrValidNoID( STRING InputAddrValid ) := 
    checkVersion(InputAddrValid, Business_Risk_BIP.Constants.BusShellVersion_v22);	// This value will be returned regardless of whether BIP IDs are assigned																																									 

		EXPORT _InputPhoneValidNoID( STRING InputPhoneValid ) := 
    checkVersion(InputPhoneValid, Business_Risk_BIP.Constants.BusShellVersion_v22); // This value will be returned regardless of whether BIP IDs are assigned	

		EXPORT _InputFEINValidNoID( STRING InputFEINValid ) := 
    checkVersion(InputFEINValid, Business_Risk_BIP.Constants.BusShellVersion_v22);		// This value will be returned regardless of whether BIP IDs are assigned	

		EXPORT _SourceDateFirstSeenListV( DATASET(Business_Risk_BIP.Layouts.LayoutSources) SeqSources ) := 
    checkVersion(Business_Risk_BIP.Common.convertDelimited(SeqSources, DateVendorFirstSeen, fieldDelimiter), Business_Risk_BIP.Constants.BusShellVersion_v22);

		EXPORT _SourceDateLastSeenListV( DATASET(Business_Risk_BIP.Layouts.LayoutSources) SeqSources ) := 
    checkVersion(Business_Risk_BIP.Common.convertDelimited(SeqSources, DateVendorLastSeen, fieldDelimiter), Business_Risk_BIP.Constants.BusShellVersion_v22);

		EXPORT _NameMatchSourceFSList( DATASET(Business_Risk_BIP.Layouts.LayoutSources) SeqNameSources ) := 
    checkVersion(Business_Risk_BIP.Common.convertDelimited(SeqNameSources, DateVendorFirstSeen, fieldDelimiter), Business_Risk_BIP.Constants.BusShellVersion_v22);

		EXPORT _NameMatchSourceLSList( DATASET(Business_Risk_BIP.Layouts.LayoutSources) SeqNameSources ) := 
    checkVersion(Business_Risk_BIP.Common.convertDelimited(SeqNameSources, DateVendorLastSeen, fieldDelimiter), Business_Risk_BIP.Constants.BusShellVersion_v22);

		EXPORT _AddrMatchSourceFSList( BOOLEAN cantVerifyAddress, DATASET(Business_Risk_BIP.Layouts.LayoutSources) SeqAddressVerSources ) := 
    checkVersion(IF(cantVerifyAddress, '', Business_Risk_BIP.Common.convertDelimited(SeqAddressVerSources, DateVendorFirstSeen, fieldDelimiter)), Business_Risk_BIP.Constants.BusShellVersion_v22);

		EXPORT _AddrMatchSourceLSList( BOOLEAN cantVerifyAddress, DATASET(Business_Risk_BIP.Layouts.LayoutSources) SeqAddressVerSources ) := 
    checkVersion(IF(cantVerifyAddress, '', Business_Risk_BIP.Common.convertDelimited(SeqAddressVerSources, DateVendorLastSeen, fieldDelimiter)), Business_Risk_BIP.Constants.BusShellVersion_v22);

		EXPORT _PhoneMatchSourceDateFSList( DATASET(Business_Risk_BIP.Layouts.LayoutSources) SeqPhoneSources ) := 
    checkVersion(Business_Risk_BIP.Common.convertDelimited(SeqPhoneSources, DateVendorFirstSeen, fieldDelimiter), Business_Risk_BIP.Constants.BusShellVersion_v22);

		EXPORT _PhoneMatchSourceDateLSList( DATASET(Business_Risk_BIP.Layouts.LayoutSources) SeqPhoneSources ) := 
    checkVersion(Business_Risk_BIP.Common.convertDelimited(SeqPhoneSources, DateVendorLastSeen, fieldDelimiter), Business_Risk_BIP.Constants.BusShellVersion_v22);

		EXPORT _FEINMatchSourceDateFSList( DATASET(Business_Risk_BIP.Layouts.LayoutSources) SeqFEINSources ) := 
    checkVersion(Business_Risk_BIP.Common.convertDelimited(SeqFEINSources, DateVendorFirstSeen, fieldDelimiter), Business_Risk_BIP.Constants.BusShellVersion_v22);

		EXPORT _FEINMatchSourceDateLSList( DATASET(Business_Risk_BIP.Layouts.LayoutSources) SeqFEINSources ) := 
    checkVersion(Business_Risk_BIP.Common.convertDelimited(SeqFEINSources, DateVendorLastSeen, fieldDelimiter), Business_Risk_BIP.Constants.BusShellVersion_v22);

		EXPORT _SourceIDDateFirstSeenList( DATASET(Business_Risk_BIP.Layouts.LayoutSources) SeqSourcesLinkIds ) := 
    checkVersion(Business_Risk_BIP.Common.convertDelimited(SeqSourcesLinkIds, DateVendorFirstSeen, fieldDelimiter), Business_Risk_BIP.Constants.BusShellVersion_v22);

		EXPORT _SourceIDDateLastSeenList( DATASET(Business_Risk_BIP.Layouts.LayoutSources) SeqSourcesLinkIds ) := 
    checkVersion(Business_Risk_BIP.Common.convertDelimited(SeqSourcesLinkIds, DateVendorLastSeen, fieldDelimiter), Business_Risk_BIP.Constants.BusShellVersion_v22);

		EXPORT _VerInputIDTruebiz( DATASET(Business_Risk_BIP.Layouts.LayoutSources) SeqSourcesLinkIds ) := 
    checkVersion(IF(COUNT(SeqSourcesLinkIds) > 0, '1', '0'), Business_Risk_BIP.Constants.BusShellVersion_v22);

		EXPORT _PhoneMatchIDSourceDateFSList( DATASET(Business_Risk_BIP.Layouts.LayoutSources) SeqPhoneIDSources ) := 
    checkVersion(Business_Risk_BIP.Common.convertDelimited(SeqPhoneIDSources, DateVendorFirstSeen, fieldDelimiter), Business_Risk_BIP.Constants.BusShellVersion_v22);

		EXPORT _PhoneMatchIDSourceDateLSList( DATASET(Business_Risk_BIP.Layouts.LayoutSources) SeqPhoneIDSources ) := 
    checkVersion(Business_Risk_BIP.Common.convertDelimited(SeqPhoneIDSources, DateVendorLastSeen, fieldDelimiter), Business_Risk_BIP.Constants.BusShellVersion_v22);

		EXPORT _InputIDMatchCategory( BOOLEAN IsLargeBusinessCategory, STRING InputIDMatchCategory ) := 
    checkVersion(IF(IsLargeBusinessCategory, Business_Risk_BIP.Constants.Category_LargeBus, InputIDMatchCategory), Business_Risk_BIP.Constants.BusShellVersion_v22);
		
		EXPORT _InputIDMatchStatus( BOOLEAN IsLargeBusinessCategory, STRING InputIDMatchStatus ) := 
    checkVersion(IF(IsLargeBusinessCategory, 'UNKNOWN', InputIDMatchStatus), Business_Risk_BIP.Constants.BusShellVersion_v22);

		EXPORT _InputIDMatchStatusBHeader( STRING RawInputIDMatchStatus, BOOLEAN GoldStatus) := 
			FUNCTION
					InputIDMatchStatus_1 := MAP(
						RawInputIDMatchStatus IN ['3','2','1','T','E']  => 'ACTIVE',
						RawInputIDMatchStatus IN ['I','D']						  => 'INACTIVE',
																															 'UNKNOWN');
					InputIDMatchStatus_2 := MAP(
						GoldStatus																												=> 'GOLD',
						RawInputIDMatchStatus IN ['3','2','1','T','E'] AND NOT GoldStatus => 'ACTIVE',
						RawInputIDMatchStatus = 'I' AND NOT GoldStatus										=> 'INACTIVE',
						RawInputIDMatchStatus = 'D' AND NOT GoldStatus										=> 'DEFUNCT',
																																								 'UNKNOWN');
        result := IF( busShellVersion < Business_Risk_BIP.Constants.BusShellVersion_v30, InputIDMatchStatus_1, InputIDMatchStatus_2 );
        
        RETURN result;						
		END;	

  EXPORT _InputCheckAuthRepsSSN(STRING filteredSSN) :=
    FUNCTION
        checkAuthRepSSN_1 := 
          MAP((INTEGER)filteredSSN <= 0			=> '0',
            LENGTH(TRIM(filteredSSN)) = 4 => '1',
            LENGTH(TRIM(filteredSSN)) = 9 => '2',
            '0');  
            
        checkAuthRepSSN_2 := 
          IF( LENGTH(TRIM(filteredSSN)) IN [4,9], '1', '0' );
        
        result := IF( busShellVersion < Business_Risk_BIP.Constants.BusShellVersion_v30, checkAuthRepSSN_1, checkAuthRepSSN_2 );
    RETURN result;
	END;	
		
	EXPORT _OrgLegalEntityCount(INTEGER OrgLegalEntityCount) := 
  IF(busShellVersion < Business_Risk_BIP.Constants.BusShellVersion_v30, OrgLegalEntityCount - 1, OrgLegalEntityCount);
	
	EXPORT _OrgRelatedCount(INTEGER OrgRelatedCount) := 
  IF(busShellVersion < Business_Risk_BIP.Constants.BusShellVersion_v30, OrgRelatedCount - 1, OrgRelatedCount);
	
  EXPORT _OrgAddrLegalEntityCount(STRING OrgAddrLegalEntityCount) := 
  IF(busShellVersion < Business_Risk_BIP.Constants.BusShellVersion_v30, (STRING)MAX(1, (INTEGER)OrgAddrLegalEntityCount), OrgAddrLegalEntityCount);
  
	EXPORT _BusNameAuthRepMatch(STRING CompanyName, STRING RepName) := FUNCTION
		NameMatch_1 := StringLib.StringFind(CompanyName, RepName, 1) > 0;
		NameMatch_2 := Business_Risk_BIP.Common.fn_isFoundInCompanyName(CompanyName, RepName);
    result := IF( busShellVersion < Business_Risk_BIP.Constants.BusShellVersion_v30, NameMatch_1, NameMatch_2 );
		RETURN result;
	END;
	
	EXPORT _FirmReportedSales(STRING FirmReportedSales) := 
	IF(BusShellVersion < Business_Risk_BIP.Constants.BusShellVersion_v30, (STRING)MIN((INTEGER)FirmReportedSales, 999999999), FirmReportedSales);

	EXPORT _InputAddrVacancyNoID(STRING InputAddrVacancy) := 
  FUNCTION   
    result_older :=
      MAP(
        InputAddrVacancy = '-1' => '-1',
        InputAddrVacancy = 'N'  => 'N',
        InputAddrVacancy = 'Y'  => 'Y',
        ''
      );
    
    result_newer :=
      MAP(
        InputAddrVacancy = '-1' => '-1',
        InputAddrVacancy = 'N'  => '1',
        InputAddrVacancy = 'Y'  => '2',
        ''
      );
      
    RETURN IF( busShellVersion < Business_Risk_BIP.Constants.BusShellVersion_v30, result_older, result_newer ); 
  END;

	EXPORT _BusTypeAddress( Business_Risk_BIP.Layouts.LayoutInputCheck InpChk, STRING BusTypeAddress) := 
  FUNCTION   
    addressNotProvided := 
      InpChk.InputCheckBusAddr = '0' OR 
      InpChk.InputCheckBusCity = '0' OR
      InpChk.InputCheckBusState = '0' OR
      InpChk.InputCheckBusZip = '0';
    
    result_older := BusTypeAddress;
    
    result_newer := IF( addressNotProvided, '-1', checkBlank(BusTypeAddress, '-1') );
      
    RETURN IF( busShellVersion < Business_Risk_BIP.Constants.BusShellVersion_v30, result_older, result_newer ); 
  END;

	EXPORT _AssetPropertyField( STRING AssetPropertyField ) := 
  FUNCTION   
    result_older := checkBlank(AssetPropertyField, '0');
    result_newer := checkBlank(AssetPropertyField, '-1');
      
    RETURN IF( busShellVersion < Business_Risk_BIP.Constants.BusShellVersion_v30, result_older, result_newer ); 
  END;
  
  EXPORT _newestAddrDate(DATASET(Business_Risk_BIP.Layouts.LayoutSources) SeqAddressVerSources, UNSIGNED6 HistoryDate) := FUNCTION
    newestAddrDate_1 := Business_Risk_BIP.Common.checkInvalidDate(TOPN(SeqAddressVerSources, 1, -DateLastSeen)[1].DateLastSeen, Business_Risk_BIP.Constants.MissingDate, HistoryDate);
    newestAddrDate_2 := Business_Risk_BIP.Common.checkInvalidDate(TOPN(SeqAddressVerSources((INTEGER)DateLastSeen>0), 1, -DateLastSeen)[1].DateLastSeen, Business_Risk_BIP.Constants.MissingDate, HistoryDate);
    
    RETURN IF( busShellVersion < Business_Risk_BIP.Constants.BusShellVersion_v30, newestAddrDate_1, newestAddrDate_2 ); 
  END;
  
   EXPORT _oldestAddrDate(DATASET(Business_Risk_BIP.Layouts.LayoutSources) SeqAddressVerSources, UNSIGNED6 HistoryDate) := FUNCTION
    oldestAddrDate_1 := Business_Risk_BIP.Common.checkInvalidDate(TOPN(SeqAddressVerSources, 1, DateFirstSeen)[1].DateFirstSeen, Business_Risk_BIP.Constants.MissingDate, HistoryDate);
    oldestAddrDate_2 := Business_Risk_BIP.Common.checkInvalidDate(TOPN(SeqAddressVerSources((INTEGER)DateFirstSeen>0), 1, DateFirstSeen)[1].DateFirstSeen, Business_Risk_BIP.Constants.MissingDate, HistoryDate);
    
    RETURN IF( busShellVersion < Business_Risk_BIP.Constants.BusShellVersion_v30, oldestAddrDate_1, oldestAddrDate_2 ); 
  END;
  
  EXPORT _PhoneResidential(BOOLEAN Business_Flag, STRING Prim_Name, STRING InputCheckBusPhone) := FUNCTION
    PhoneResidential_1 := MAP(Business_Flag = FALSE AND Prim_Name <> '' => '1', 
															Business_Flag = TRUE AND Prim_Name <> ''  => '0',
																																					 '-1');
    PhoneResidential_2 := MAP(InputCheckBusPhone = '0'                  => '-1',
                              Business_Flag = FALSE AND Prim_Name <> '' => '1', 
                                                                           '0');
    RETURN  IF( busShellVersion < Business_Risk_BIP.Constants.BusShellVersion_v30, PhoneResidential_1, PhoneResidential_2 ); 
  END;  
  
  EXPORT _FirmAgeEstablished(STRING FirmAgeEstablished) := 
    IF(busShellVersion >= Business_Risk_BIP.Constants.BusShellVersion_v30 AND FirmAgeEstablished = '-1', '0', FirmAgeEstablished);
  
  EXPORT _IndustryNAICRecent(STRING IndustryNAICRecent) :=
    IF(busShellVersion >= Business_Risk_BIP.Constants.BusShellVersion_v30 AND TRIM(IndustryNAICRecent) = '', '-1', IndustryNAICRecent);

  EXPORT _IndustrySICRecent(STRING IndustrySICRecent) :=
    IF(busShellVersion >= Business_Risk_BIP.Constants.BusShellVersion_v30 AND TRIM(IndustrySICRecent) = '', '-1', IndustrySICRecent);

  EXPORT _UCCFiling( Business_Risk_BIP.Layouts.LayoutTempUCCRec tempUCC ) := 
    MODULE
      SHARED isBSv30       := busShellVersion >= Business_Risk_BIP.Constants.BusShellVersion_v30;
      SHARED SIX_YEARS_AGO := (INTEGER)(((STRING)tempUCC.historydate)[1..6]) - 600;
      SHARED EXPIRED       := 8; 
      
      SHARED current_filing_status := tempUCC.filing_status[1].filing_status_desc;
      
      // Sort the most recent filing to the top, dropping any records that came after 
      // the history date.
      SHARED filings := 
        SORT(
          tempUCC.filings( ((INTEGER)(filing_date[1..6])) <= tempUCC.historydate ), 
          -filing_date, -filing_time, -vendor_entry_date, -filing_number, -rmsid
        ); 
      
      SHARED mostrecentFiling := filings[1];
      
      // If the recent FilingType is blank, attempt to check for previous FilingTypes. 
      // Only if all are blank consider it an Initial Filing (7)
      SHARED recentNonBlankFilingType := filings(TRIM(filing_type) <> '');
      
      SHARED mapFilingType(STRING filing_type) := 
        CASE( StringLib.StringToUpperCase(TRIM(filing_type)),
            'TERMINATION'              => 1,
            'CORRECTION'               => 2,
            'AMENDMENT'                => 3,
            'ASSIGNMENT'               => 4,
            'CONTINUATION'             => 5,
            'FILING OFFICER STATEMENT' => 6,
            'INITIAL FILING'           => 7,
            7 );
            
      SHARED mapFilingStatus := 
        CASE( StringLib.StringToUpperCase(TRIM(filings[1].status_type)),
            'ACTIVE'     => 1,
            'LAPSED'     => 2,
            'TERMINATED'	=> 3,
            'DELETED'    => 4,
            'EXPUNGED'   => 5,
            1 );
          
      EXPORT mostrecentFilingDate := mostrecentFiling.filing_date;

      EXPORT FilingType := 
        MAP(
          isBSv30 AND TRIM(mostrecentFiling.filing_type) IN ['UCC-3 TERMINATION','TERMINATION'] => 1,
          TRIM(mostrecentFiling.filing_type) <> ''	=> mapFilingType(mostrecentFiling.filing_type), // Most recent filing type is populated, use RecentFilingType
          ut.Exists2(recentNonBlankFilingType)	=> mapFilingType(recentNonBlankFilingType[1].filing_type), // Most recent filing type is blank, however one of the next most recent filing types is populated, use that instead
          7 ); // Most recent filing type is blank, and no other recent filings have a populated filing_type, consider this an "Initial Filing (7)"
        
      SHARED mapInferredStatus := 
        MAP(
          FilingType = 1	=> 3, // Terminated
          1 ); // Consider active, can't determine any others

      EXPORT FilingStatus := 
        MAP( 
          isBSv30 AND TRIM(mostrecentFiling.filing_type) IN ['UCC-3 TERMINATION','TERMINATION'] => 3,
          isBSv30 AND current_filing_status = 'ACTIVE' AND MAX((INTEGER)mostrecentFiling.filing_date[1..6], (INTEGER)tempUCC.orig_filing_date[1..6]) < SIX_YEARS_AGO => EXPIRED,
          mostrecentFiling.status_type <> '' => mapFilingStatus, 
          mapInferredStatus 
        );
        
    END; // module _UCCFiling
  
  
  EXPORT _UCCActiveCount( DATASET(Business_Risk_BIP.Layouts.LayoutTempUCCFiling) filings ) := 
      IF( 
        busShellVersion >= Business_Risk_BIP.Constants.BusShellVersion_v30, 
        COUNT(filings(FilingStatus = 1)), 
        COUNT(filings(FilingStatus IN [1,8])) 
      );
  


END;