IMPORT iesp;
EXPORT Constants := MODULE
  EXPORT MaxCollectionRecords := iesp.Constants.CollectionReport.MaxCollectionRecords;
  EXPORT DateFormat := ENUM(YYYYMMDD = 1, YYYYMM = 2);

  // Collection names below cannot change or it will break CD tools. 
  EXPORT Collection := MODULE
    EXPORT STRING ALLOY := 'AlloyKeys'; 
    EXPORT STRING ASL := 'AmericanstudentKeys'; 
    EXPORT STRING DEATH_MASTER := 'DeathMasterSsaKeys'; 
    EXPORT STRING EMAIL := 'EmailV2Keys'; 
    EXPORT STRING EXPERIAN_CRDB := 'ExperianCRDBKeys'; 
    EXPORT STRING IMPULSE_EMAIL := 'ImpulseEmailKeys'; 
    EXPORT STRING INFUTOR := 'InfutorKeys'; 
    EXPORT STRING INFUTOR_CID := 'InfutorCIDKeys'; 
    EXPORT STRING INFUTOR_NARC := 'InfutorNARCKeys'; 
    EXPORT STRING INQUIRY_TABLE := 'InquiryTableKeys'; 
    EXPORT STRING INQUIRY_TABLE_UPDATE := 'InquiryTableUpdateKeys'; 
    EXPORT STRING MARI := 'MariKeys'; 
    EXPORT STRING ONECLICK_DATA := 'OneClickDataKeys'; 
    EXPORT STRING PAW := 'PAWV2Keys'; 
    EXPORT STRING PCNRS := 'PCNSRKeys'; 
    EXPORT STRING PERSON_HEADER := 'PersonHeaderKeys'; 
    EXPORT STRING PHONE_FEEDBACK := 'PhoneFeedbackKeys'; 
    // EXPORT STRING INFUTOR := 'PhonemartKeys'; 
    EXPORT STRING PROF_LICENSE := 'ProfLicenseKeys'; 
    EXPORT STRING POE := 'POEKeys'; 
    EXPORT STRING POE_FROM_EMAIL := 'POEsFromEmailsKeys'; 
    EXPORT STRING QSENT := 'QSentKeys'; 
    EXPORT STRING QUICK_HEADER := 'QuickHeaderKeys'; 
    EXPORT STRING SALES_CHANNEL := 'SalesChannelKeys'; 
    EXPORT STRING SANCTN := 'SanctnKeys'; 
    EXPORT STRING SPOKE := 'SpokeKeys'; 
    EXPORT STRING TARGUS := 'TargusKeys'; 
    EXPORT STRING THRIVE := 'ThriveKeys'; 
    EXPORT STRING VEHICLE_PARTY := 'VehicleV2KeysParty'; 
    EXPORT STRING VEHICLE_MAIN := 'VehicleV2KeysMain'; 
    EXPORT STRING WHOIS := 'WhoisKeys'; 
    EXPORT STRING ZOOM := 'ZoomKeys'; 
  END;


END;