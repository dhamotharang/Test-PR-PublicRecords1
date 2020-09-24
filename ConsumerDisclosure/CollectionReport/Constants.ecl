IMPORT iesp;
EXPORT Constants := MODULE
  EXPORT MaxCollectionRecords := iesp.Constants.CollectionReport.MaxCollectionRecords;
  EXPORT DateFormat := ENUM(YYYYMMDD = 1, YYYYMM = 2);

  // Collection names below cannot change or it will break CD tools. 
  EXPORT Collection := MODULE
    EXPORT STRING ALLOY := 'AlloyKeys'; 
    EXPORT STRING ASL := 'AmericanstudentKeys'; 
    EXPORT STRING BIP := 'BipV2FullKeys'; 
    EXPORT STRING BUSINESS_HEADER := 'BusinessHeaderKeys'; 
    EXPORT STRING CANADIAN_PHONES := 'CanadianPhonesV2Keys'; 
    EXPORT STRING CORTERA := 'CorteraKeys'; 
    EXPORT STRING DCA := 'DCAKeys'; 
    EXPORT STRING DEATH_MASTER := 'DeathMasterSsaKeys'; 
    EXPORT STRING EMAIL := 'EmailV2Keys'; 
    EXPORT STRING EXPERIAN_CRDB := 'ExperianCRDBKeys'; 
    EXPORT STRING FBN_CONTACTS := 'FbnV2KeysContacts'; 
    EXPORT STRING FBN_BUSINESS := 'FbnV2KeysBusiness'; 
    EXPORT STRING GONG := 'GongKeys'; 
    EXPORT STRING IMPULSE_EMAIL := 'ImpulseEmailKeys'; 
    EXPORT STRING INFUTOR := 'InfutorKeys'; 
    EXPORT STRING INFUTOR_CID := 'InfutorCIDKeys'; 
    EXPORT STRING INFUTOR_NARC := 'InfutorNARCKeys'; 
    EXPORT STRING INQUIRY_TABLE := 'InquiryTableKeys'; 
    EXPORT STRING INQUIRY_TABLE_UPDATE := 'InquiryTableUpdateKeys'; 
    EXPORT STRING MARI := 'MariKeys'; 
    EXPORT STRING ONECLICK_DATA := 'OneClickDataKeys'; 
    EXPORT STRING PATRIOT := 'PatriotKeys'; 
    EXPORT STRING PAW := 'PAWV2Keys'; 
    EXPORT STRING PCNRS := 'PCNSRKeys'; 
    EXPORT STRING PERSON_HEADER := 'PersonHeaderKeys'; 
    EXPORT STRING PHONE_FEEDBACK := 'PhoneFeedbackKeys'; 
    EXPORT STRING PHONESPLUS := 'PhonesPlusV2Keys'; 
    EXPORT STRING PHONESPLUS_ROYALTY := 'PhonesPlusV2KeysRoyalty'; 
    // EXPORT STRING INFUTOR := 'PhonemartKeys'; 
    EXPORT STRING PROF_LICENSE := 'ProfLicenseKeys'; 
    EXPORT STRING POE := 'POEKeys'; 
    EXPORT STRING POE_FROM_EMAIL := 'POEsFromEmailsKeys'; 
    EXPORT STRING QSENT := 'QSentKeys'; 
    EXPORT STRING QUICK_HEADER := 'QuickHeaderKeys'; 
    EXPORT STRING SALES_CHANNEL := 'SalesChannelKeys'; 
    EXPORT STRING SANCTN := 'SanctnKeys'; 
    EXPORT STRING SBFE := 'SBFECVKeys'; 
    EXPORT STRING SPOKE := 'SpokeKeys'; 
    EXPORT STRING TARGUS := 'TargusKeys'; 
    EXPORT STRING THRIVE := 'ThriveKeys'; 
    EXPORT STRING VEHICLE_PARTY := 'VehicleV2KeysParty'; 
    EXPORT STRING VEHICLE_MAIN := 'VehicleV2KeysMain'; 
    EXPORT STRING WHOIS := 'WhoisKeys'; 
    EXPORT STRING WHOIS_INTERNET := 'WhoisKeysInternetServices'; 
    EXPORT STRING ZOOM := 'ZoomKeys'; 
  END;

END;
