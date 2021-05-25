IMPORT iesp, Gateway, MDR, ut;
EXPORT Constants :=
MODULE

  EXPORT LexIdCntType := ENUM(Blank = 0, Single = 1);

  EXPORT UNSIGNED1 MaxDIDs             := 100;
  EXPORT UNSIGNED2 MaxGongPhones       := 2000;
  EXPORT UNSIGNED1 MaxPhones           := 100;
  EXPORT UNSIGNED1 MaxGatewayMatches   := 100;
  EXPORT UNSIGNED1 MaxTUGatewayResults := 30;
  EXPORT UNSIGNED1 MaxPhoneMatches     := 10;
  EXPORT UNSIGNED1 MaxRoyalties        := 11;
  EXPORT INTEGER   MaxOtherPhones      := 5; // MaxOtherPhones default


  // Phone Porting
  EXPORT UNSIGNED1 MaxPortedMatches     := 100;
  EXPORT UNSIGNED1 MaxSpoofedMatches    := 100;
  EXPORT UNSIGNED1 MaxOTPMatches        := 100;
  EXPORT UNSIGNED1 MaxOTPBatch	        := 30;
  EXPORT UNSIGNED1 PortingMarginOfError := 5; // plus or minus 5 days from the date fields
  EXPORT UNSIGNED  MetadataLimit        := 10000;
  EXPORT UNSIGNED1 MaxAlertCategories   := 3;
  EXPORT UNSIGNED1 SQLSelectLimit       := 100;  // Limit SQL select for each phone
  EXPORT UNSIGNED1 gatewayTimeout       := 2;
  EXPORT UNSIGNED1 gatewayRetries       := 0;
  EXPORT UNSIGNED1 NoPenalty            := 0;
  EXPORT UNSIGNED1 LERG6_LastActivityThreshold := 30;
  EXPORT UNSIGNED1 MaxIconectivElepGwHistBatch := 2; // Added for the 2021-06-02 Phone Porting Date for LE project
  EXPORT UNSIGNED1 MaxIconectivElepPortHist    := 5; // Added for the 2021-06-02 Phone Porting Date for LE project
  EXPORT STRING1   CarrierKey_Arec             := 'A'; // Added for the 2021-06-02 Phone Porting Date for LE project
  EXPORT STRING1   CarrierKey_Brec             := 'B'; // Added for the 2021-06-02 Phone Porting Date for LE project

  // Enum for TransactionType and Phone source
  EXPORT TransType   := ENUM(Basic = 0,Premium = 1,Ultimate = 2, PhoneRiskAssessment = 3, Blank = 255);
  SHARED TransTypeCodes := DATASET([
        {TransType.Basic, 'BASIC'},
        {TransType.Premium, 'PREMIUM'},
        {TransType.Ultimate, 'ULTIMATE'},
        {TransType.PhoneRiskAssessment, 'PHONERISKASSESSMENT'},
        {TransType.Blank, 'BLANK'}
        ], {unsigned1 tcode; string ttype;});

  TransCodeTypeDCT := DICTIONARY(TransTypeCodes, {tcode => ttype});
  EXPORT MapTransCode2Type(UNSIGNED1 t) := TransCodeTypeDCT[t].ttype;

  TransTypeCodeDCT := DICTIONARY(TransTypeCodes, {ttype => tcode});
  EXPORT MapTransType2Code(STRING t) := TransTypeCodeDCT[ut.CleanSpacesAndUpper(t)].tcode;

  EXPORT PrimarySearchCriteria := 'PII';

  EXPORT PhoneSource := ENUM(UNSIGNED1,Waterfall,QSentGateway,TargusGateway,EquifaxPhones,ExpFileOne,Gong,PhonesPlus,InHouseQSent,LastResort);

  EXPORT set of UNSIGNED1 WaterfallPhoneSources := [PhoneSource.Waterfall,PhoneSource.EquifaxPhones,PhoneSource.InHouseQSent,PhoneSource.LastResort];
  EXPORT set of UNSIGNED1 GatewaySources := [PhoneSource.QSentGateway,PhoneSource.TargusGateway,PhoneSource.EquifaxPhones,
                                            PhoneSource.InHouseQSent,PhoneSource.LastResort];

  EXPORT SOURCES :=
  MODULE
    EXPORT Gateway := 'GATEWAY';
    EXPORT Internal := 'INTERNAL';
  END;

  // Phone types
  EXPORT PhoneType :=
  MODULE
    EXPORT Landline := 'LANDLINE';
    EXPORT Wireless := 'POSSIBLE WIRELESS';
    EXPORT Pager    := 'PAGER';
    EXPORT VoIP     := 'POSSIBLE VOIP';
    EXPORT Other    := 'OTHER/UNKNOWN';
    EXPORT Cable    := 'CABLE';
  END;

  EXPORT serviceType   := ENUM(LandLine = 0,Wireless = 1,VOIP = 2,Unknown = 3);
  EXPORT STRING PhoneActiveStatus := '13'; //'Active-Unknown Line Type'
  EXPORT STRING PhoneInactiveStatus := '33'; //'Inactive-Unknown Line Type'

  EXPORT PhoneStatus :=
  MODULE
    EXPORT Inactive     := 'INACTIVE';
    EXPORT Active       := 'ACTIVE';
    EXPORT NotAvailable := 'NOT AVAILABLE';

  END;

  // Listing types
  EXPORT ListingType :=
  MODULE
    EXPORT Business    := 'BUSINESS';
    EXPORT Government  := 'GOVERNMENT';
    EXPORT Residential := 'RESIDENTIAL';
    EXPORT BusGov      := 'BUSINESS AND GOVERNMENT';
    EXPORT BusGovRes   := 'BUSINESS, GOVERNMENT AND RESIDENTIAL';
  END;

  // Waterfall phones constants
  EXPORT WFConstants :=
  MODULE
    EXPORT UNSIGNED1 MaxPhones        := 6;
    EXPORT UNSIGNED1 MaxSubjects      := 5;
    EXPORT UNSIGNED1 MaxPremiumSource := 2; //PHPR-95 update to return 2 equifax phones
    EXPORT UNSIGNED1 MaxSectionLimit  := 35;
  END;

  // Ported metadata phones constants
  EXPORT PortingStatus:=
  MODULE
    EXPORT Disconnected := 'DE'; //SU-suspend
    EXPORT UNSIGNED1 DisconnectedPhoneThreshold := 180; // no of days threshold for phone disconnect status
  END;

  EXPORT SET OF STRING OTPVerifyTransactions := ['mfaverifyotp','mfaverifyotponce'];
  EXPORT SET OF STRING RiskIndicator := ['PASS','WARN','FAIL'];
  EXPORT RiskLevel		 := ENUM(PASS=1,WARN=2,FAILED=3);
  EXPORT UNSIGNED1 OTPRiskLimit := 5;
  EXPORT UNSIGNED1 InquiryDayLimit := 1;
  EXPORT DefaultRiskIndicatorRules := DATASET([ {'Phone Association','H','1','0','No Identity',0,0,'',true,true},
                                                {'Phone Association','H','1','-1','No phone associated with subject',0,0,'',true,true}
                                              ],
                                              iesp.phonefinder.t_PhoneFinderRiskIndicator);

  EXPORT SET OF STRING enumCategory := ['Phone Association','Phone Activity','Phone Criteria'];
  EXPORT SET OF INTEGER PhoneRiskAssessmentExceptions := [1, 5];// Phone Association exceptions reqested in LRA

  EXPORT SpoofPhoneOrigin :=
    MODULE
      EXPORT STRING1 Spoofed      := 'S';
      EXPORT STRING1 Destination  := 'D';
      EXPORT STRING1 Source       := 'C';
    END;

  EXPORT MaxCheckIdentities := 10;

  EXPORT VerifyMessage :=
		MODULE
            EXPORT PhoneCannotBeVerified := 'Input phone number cannot be verified';
            EXPORT PhoneNotEntered := 'No phone number was entered';
            EXPORT PhoneMatchesNameAddress := 'Input phone number matches name and address';
            EXPORT PhoneMatchesName := 'Input phone number matches name';
            EXPORT PhoneIsActive := 'Input phone number is verified as Active for the defined threshold period';
            EXPORT PhoneNotActive := 'Input phone number is NOT verified as Active for the defined threshold period';
            EXPORT PhoneMatchesLastName := 'Input phone number matches last name';
		END;

  EXPORT VARSTRING ErrorCodes(INTEGER c) :=
    CASE(c,
          100 => 'More than one verification type selected',
          101 => 'No Phone number was entered for the verification request',
          102 => 'No transaction type specified',
          'Unspecified Failure');

  EXPORT PhoneRiskAssessmentGateways  := [Gateway.Constants.ServiceName.PhonesMetaData, Gateway.Constants.ServiceName.AccuDataOCN,
                                            Gateway.Constants.ServiceName.ZumigoIdentity, Gateway.Constants.ServiceName.ThreatMetrix]; // phonerisk assessment gateways
  // Debugging
  EXPORT Debug :=
  MODULE
    EXPORT Main         := FALSE;
    EXPORT Intermediate := FALSE;
    EXPORT PhoneNoSearch:= FALSE;
    EXPORT PIISearch    := FALSE;
    EXPORT Waterfall    := FALSE;
    EXPORT Gong         := FALSE;
    EXPORT QSent        := FALSE;
    EXPORT EquifaxPhones:= FALSE;
    EXPORT Targus       := FALSE;
    EXPORT PhoneMetadata:= FALSE;
  END;

  EXPORT ZumigoConstants := MODULE
    EXPORT STRING20 Usecase     := 'FCIP';
    EXPORT STRING3  productCode := 'ACC';
    EXPORT STRING20 productName := 'PHONE FINDER';
    EXPORT STRING10 optInType   := 'Whitelist';
    EXPORT STRING5  optInMethod := 'TCO';
    EXPORT STRING3  optinDuration := 'ONG';
    EXPORT UNSIGNED1 IdentityDateThreshold := 61;
    EXPORT UNSIGNED1 MonthlyDays := 31;
  END;

  EXPORT ThreatMetrixConstants := MODULE
    EXPORT STRING20 OrgId    := '9hxmziuy';
    EXPORT STRING50 ApiKey   := 'tmvy1fr36dfpqpq9';
    EXPORT STRING30 Policy   := 'Digital Insights';
    EXPORT STRING30 ApiType  := 'AttributeQuery';
    EXPORT STRING20 serviceType := 'all';
    EXPORT BOOLEAN  NoPIIPersistence := TRUE;
  END;

  EXPORT ConsentLevels := MODULE
    EXPORT UNSIGNED1 SingleConsumer := 2;
    EXPORT UNSIGNED1 FullConsumer   := 3;
  END;

  EXPORT RiskRules := MODULE
    EXPORT UNSIGNED1 CallForwarding:= 31;
    EXPORT UNSIGNED1 SimCardInfo   := 35;
    EXPORT UNSIGNED1 DeviceInfo    := 36;
    EXPORT UNSIGNED1 IdentityCount := 45;
    EXPORT UNSIGNED1 PhoneTransactionCount := 47;
  END;

  EXPORT ThreatMetrixRiskRules := MODULE
    //DIN = Digital Identity Network
    EXPORT UNSIGNED1 RejectedTransaction  := 37;
    EXPORT UNSIGNED1 Blacklist            := 38;
    EXPORT UNSIGNED1 FraudInDIN           := 39;
    EXPORT UNSIGNED1 BadReputation        := 40;
    EXPORT UNSIGNED1 FirstSeenInDIN       := 41;
    EXPORT UNSIGNED1 HighDeviceCount      := 42;
    EXPORT UNSIGNED1 HighEmailCount       := 43;
    EXPORT UNSIGNED1 HighCountriesCount   := 44;
  END;

  EXPORT AllThreatMetrixRules :=[ ThreatMetrixRiskRules.RejectedTransaction,
                                  ThreatMetrixRiskRules.Blacklist,
                                  ThreatMetrixRiskRules.FraudInDIN,
                                  ThreatMetrixRiskRules.BadReputation,
                                  ThreatMetrixRiskRules.FirstSeenInDIN,
                                  ThreatMetrixRiskRules.HighDeviceCount,
                                  ThreatMetrixRiskRules.HighEmailCount,
                                  ThreatMetrixRiskRules.HighCountriesCount];

  EXPORT PfResSnapshotErrorMessages := module
    EXPORT STRING50 Companyid := 'Too Many Transactions by CompanyId';
    EXPORT STRING50 UserId := 'Too Many Transactions by UserId';
    EXPORT STRING50 ReferenceCode := 'Too Many Transactions by ReferenceCode';
    EXPORT STRING50 PhoneNumber := 'Too Many Transactions by PhoneNumber';
    EXPORT STRING50 LexId := 'Too Many Transactions by LexId';
    EXPORT STRING50 CmpId_Refrcode := 'Too Many Transactions by Companyid and Reference Code';
  END;

  EXPORT PfResSnapshot := module
    EXPORT UNSIGNED2 MaxSearchRecords := 10000;
    EXPORT UNSIGNED2 MaxRecords := 50000;
    EXPORT UNSIGNED2 MaxRIs := 100;
    EXPORT UNSIGNED2 MaxIdentities := 100;
    EXPORT UNSIGNED2 MaxOtherPhones := 100;
    EXPORT UNSIGNED2 MaxSources := 1500;
  END;

   EXPORT PFSourceCategory := MODULE
     EXPORT STRING Inquiry := 'Inquiry';
     EXPORT STRING VehicleRegistration := 'VehicleRegistration';
     EXPORT STRING CreditHeader := 'CreditHeader';
     EXPORT STRING CreditInquiry := 'CreditInquiry';
     EXPORT STRING DirectoryAssistance := 'DirectoryAssistance';
     EXPORT STRING DriverLicense := 'DriverLicense';
     EXPORT STRING MarketingData := 'MarketingData';
     EXPORT STRING LNRSInquiry := 'LNRSInquiry';
     EXPORT STRING MNOCarrier := 'MNOCarrier';
     EXPORT STRING NonProfessionalLicense := 'NonProfessionalLicense';
     EXPORT STRING ProfessionalLicense := 'ProfessionalLicense';
     EXPORT STRING PropertyRecord := 'PropertyRecord';
     EXPORT STRING StudentData := 'StudentData';
     EXPORT STRING UtilityRecord := 'UtilityRecord';
     EXPORT STRING VoterRecords := 'VoterRecords';
     EXPORT STRING WhitePages := 'WhitePages';
     EXPORT STRING WirelessPhoneContent := 'WirelessPhoneContent';
     EXPORT STRING EmploymentData := 'EmploymentData';
     EXPORT STRING Other := 'Other';
  END;

  EXPORT PFSourceType := MODULE
     EXPORT STRING SelfReported := 'SelfReported';
     EXPORT STRING SelfReported_CreditInquiry := 'Self Reported-Credit Inquiry';
     EXPORT STRING Account := 'Account';
  END;

  EXPORT PFSourceCodes := MODULE
    EXPORT STRING QsentIQ411 := 'I';
    EXPORT STRING EquifaxPhoneMart := 'EQ';
    EXPORT STRING EDALA := 'ES';
    EXPORT STRING EDACA := 'AP';
    EXPORT STRING EDADID := 'SE';
    EXPORT STRING Zumigo := 'MNO';
    EXPORT STRING UNDEFINED := 'UNDEFINED';
    EXPORT STRING PeopleAtWork := 'WK';
    EXPORT STRING Spouse := 'SP';
  END;

  EXPORT GatewayMaxTimeout := MODULE

    EXPORT DECIMAL AccuData_CallerID_RequestTimeout := 1;
    EXPORT DECIMAL AccuData_OCN_RequestTimeout := 1.7;
    EXPORT DECIMAL QSENT_RequestTimeout := 3;
    EXPORT INTEGER Targus_RequestTimeout := 2;
  END;



  EXPORT CategoryCodes := DATASET([
        {PFSourceCategory.Inquiry, MDR.sourceTools.src_Wired_Assets_Royalty, PFSourceType.SelfReported}, //WR
        {PFSourceCategory.Inquiry, MDR.sourceTools.src_Wired_Assets_Owned, PFSourceType.SelfReported}, //WO
        {PFSourceCategory.VehicleRegistration, MDR.sourceTools.src_MO_Watercraft, PFSourceType.Account},//BW
        {PFSourceCategory.VehicleRegistration, MDR.sourceTools.src_MD_Watercraft, PFSourceType.Account},//DW
        {PFSourceCategory.VehicleRegistration, MDR.sourceTools.src_EMerge_Boat, PFSourceType.Account},//EB
        {PFSourceCategory.VehicleRegistration, MDR.sourceTools.src_KY_Watercraft, PFSourceType.Account},//KW
        {PFSourceCategory.VehicleRegistration, MDR.sourceTools.src_VA_Watercraft, PFSourceType.Account},//VW
        {PFSourceCategory.VehicleRegistration, MDR.sourceTools.src_MO_Experian_Veh, PFSourceType.Account},//YE
        {PFSourceCategory.CreditHeader, MDR.sourceTools.src_Experian_Credit_Header, PFSourceType.Account},//EN
        {PFSourceCategory.CreditHeader, MDR.sourceTools.src_Equifax, PFSourceType.Account},//EQ
        {PFSourceCategory.CreditHeader, MDR.sourceTools.src_TU_CreditHeader, PFSourceType.Account},//TN
        {PFSourceCategory.CreditHeader, MDR.sourceTools.src_TUCS_Ptrack, PFSourceType.Account},//TS
        {PFSourceCategory.CreditInquiry, PFSourceCodes.QsentIQ411, PFSourceType.SelfReported_CreditInquiry}, //I
        {PFSourceCategory.CreditInquiry, PFSourceCodes.EquifaxPhoneMart, PFSourceType.SelfReported_CreditInquiry},//EQ  ??
        {PFSourceCategory.DirectoryAssistance, PFSourceCodes.EDALA, PFSourceType.Account},//EDA ES
        {PFSourceCategory.DirectoryAssistance, PFSourceCodes.EDACA, PFSourceType.Account},//EDA AP
        {PFSourceCategory.DirectoryAssistance, PFSourceCodes.EDADID, PFSourceType.Account},//EDA SE
        {PFSourceCategory.DirectoryAssistance, MDR.sourceTools.src_Intrado, PFSourceType.Account},//IO
        {PFSourceCategory.DirectoryAssistance, MDR.sourceTools.src_Gong_History, PFSourceType.Account},//GO
        {PFSourceCategory.DirectoryAssistance, MDR.sourceTools.src_Gong_phone_append, PFSourceType.Account},//PH
        {PFSourceCategory.DriverLicense, MDR.sourceTools.src_Certegy, PFSourceType.Account},//CY
        {PFSourceCategory.DriverLicense, MDR.sourceTools.src_MO_DL, PFSourceType.Account},//MD
        {PFSourceCategory.EmploymentData, MDR.sourceTools.src_Thrive_LT, PFSourceType.Account},//TM
        {PFSourceCategory.EmploymentData, MDR.sourceTools.src_Thrive_PD, PFSourceType.Account},//T$
        {PFSourceCategory.LNRSInquiry, MDR.sourceTools.src_InquiryAcclogs, PFSourceType.SelfReported_CreditInquiry},//IQ
        {PFSourceCategory.MarketingData, MDR.sourceTools.src_InfutorCID, PFSourceType.SelfReported},//IR
        {PFSourceCategory.MarketingData, MDR.sourceTools.src_Ibehavior, PFSourceType.SelfReported},//IB
        {PFSourceCategory.MarketingData, MDR.sourceTools.src_AlloyMedia_consumer, PFSourceType.SelfReported},//AO
        {PFSourceCategory.MarketingData, MDR.sourceTools.src_Cellphones_nextones, PFSourceType.SelfReported},//05
        {PFSourceCategory.MarketingData, MDR.sourceTools.src_Cellphones_traffix, PFSourceType.SelfReported},//02
        {PFSourceCategory.MarketingData, MDR.sourceTools.src_Cellphones_kroll, PFSourceType.SelfReported},//01
        {PFSourceCategory.MNOCarrier, PFSourceCodes.Zumigo, PFSourceType.Account},//MNO
        {PFSourceCategory.NonProfessionalLicense, MDR.sourceTools.src_MO_Veh, PFSourceType.Account},//SV
        {PFSourceCategory.NonProfessionalLicense, MDR.sourceTools.src_NC_Watercraft, PFSourceType.Account},//NW
        {PFSourceCategory.NonProfessionalLicense, MDR.sourceTools.src_Federal_Firearms, PFSourceType.Account},//FF
        {PFSourceCategory.NonProfessionalLicense, MDR.sourceTools.src_Federal_Explosives, PFSourceType.Account},//FE
        {PFSourceCategory.NonProfessionalLicense, MDR.sourceTools.src_EMerge_Master, PFSourceType.Account},//EM
        {PFSourceCategory.NonProfessionalLicense, MDR.sourceTools.src_EMerge_Cens, PFSourceType.Account},//E4
        {PFSourceCategory.NonProfessionalLicense, MDR.sourceTools.src_EMerge_Fish, PFSourceType.Account},//E2
        {PFSourceCategory.NonProfessionalLicense, MDR.sourceTools.src_EMerge_Hunt, PFSourceType.Account},//E1
        {PFSourceCategory.Other, PFSourceCodes.UNDEFINED, PFSourceType.Account},
        {PFSourceCategory.Other, MDR.sourceTools.src_Miscellaneous, PFSourceType.Account},//PQ
        {PFSourceCategory.EmploymentData, PFSourceCodes.Spouse, PFSourceType.Account},//SP
        {PFSourceCategory.EmploymentData, MDR.sourceTools.src_Professional_License, PFSourceType.Account},//PL
        {PFSourceCategory.PropertyRecord, MDR.sourceTools.src_LnPropV2_Lexis_Deeds_Mtgs, PFSourceType.Account},//LP
        {PFSourceCategory.PropertyRecord, MDR.sourceTools.src_LnPropV2_Lexis_Asrs, PFSourceType.Account},//LA
        {PFSourceCategory.PropertyRecord, MDR.sourceTools.src_LnPropV2_Fares_Asrs, PFSourceType.Account},//FA
        {PFSourceCategory.StudentData, MDR.sourceTools.src_American_Students_List, PFSourceType.Account},//SL
        {PFSourceCategory.UtilityRecord, MDR.sourceTools.src_ZUtilities, PFSourceType.Account},//ZT
        {PFSourceCategory.UtilityRecord, MDR.sourceTools.src_ZUtil_Work_Phone, PFSourceType.Account},//ZK
        {PFSourceCategory.UtilityRecord, MDR.sourceTools.src_Util_Work_Phone, PFSourceType.Account},//UW
        {PFSourceCategory.UtilityRecord, MDR.sourceTools.src_Utilities, PFSourceType.Account},//UT
        {PFSourceCategory.VoterRecords, MDR.sourceTools.src_Voters_v2, PFSourceType.Account},//VO
        {PFSourceCategory.WhitePages, MDR.sourceTools.src_Targus_White_pages, PFSourceType.Account},//WP
        {PFSourceCategory.WhitePages, MDR.sourceTools.src_pcnsr, PFSourceType.Account},//PN
        {PFSourceCategory.WirelessPhoneContent, MDR.sourceTools.src_NeustarWireless, PFSourceType.Account},//N2
        {PFSourceCategory.WirelessPhoneContent, MDR.sourceTools.src_Targus_Gateway, PFSourceType.Account},//TG
        {PFSourceCategory.EmploymentData, PFSourceCodes.PeopleAtWork, PFSourceType.Account}//People at Work - WK
        ], {string35 ctg; string3 src; string35 src_type;});

        CategoryDCT := DICTIONARY(CategoryCodes, {src => ctg});
        EXPORT MapCategoryDCT(STRING3 src) := CategoryDCT[src].ctg;
        SourceTypeDCT := DICTIONARY(CategoryCodes, {src => src_type});
        EXPORT MapSourceTypeDCT(STRING3 src) := SourceTypeDCT[src].src_type;
  // Batch only
  EXPORT BatchRestrictedDirectMarketingSourcesSet :=
                                      [MDR.sourceTools.src_AL_Experian_Veh,
                                        MDR.SourceTools.src_Voters_v2,
                                        MDR.SourceTools.src_Wither_and_Die,
                                        MDR.SourceTools.src_AK_Watercraft,
                                        MDR.SourceTOols.src_AK_Experian_Veh,
                                        MDR.SourceTools.src_CO_Experian_Veh,
                                        MDR.SourceTools.src_CO_Experian_DL,
                                        MDR.SourceTools.src_CT_Experian_Veh,
                                        MDR.SourceTools.src_CT_DL,
                                        MDR.SourceTools.src_DE_Experian_Veh,
                                        MDR.SourceTools.src_DE_Experian_DL,
                                        MDR.SourceTools.src_DC_Experian_Veh,
                                        MDR.SourceTools.src_FL_Experian_Veh,
                                        MDR.SourceTOols.src_FL_Veh,
                                        MDR.SourceTOols.src_FL_Watercraft,
                                        MDR.SourceTOols.src_FL_Veh,
                                        MDR.SourceTools.src_FL_DL,
                                        MDR.SourceTools.src_ID_Experian_DL,
                                        MDR.SourceTOols.src_ID_Veh,
                                        MDR.SourceTools.src_ID_Experian_Veh,
                                        MDR.SourceTOols.src_IL_Experian_Veh,
                                        MDR.SourceTOols.src_IL_Experian_DL,
                                        MDR.SourceTools.src_KS_Watercraft,
                                        MDR.SourceTools.src_KY_Watercraft,
                                        MDR.SourceTools.src_KY_Experian_Veh,
                                        MDR.SourceTools.src_KY_Veh,
                                        MDR.SourceTools.src_KY_Watercraft,
                                        MDR.SourceTools.src_KY_Experian_DL,
                                        MDR.SourceTools.src_LA_Experian_DL,
                                        MDR.SourceTools.src_LA_Experian_Veh,
                                        MDR.SourceTools.src_LA_DL,
                                        MDR.SourceTools.src_ME_DL,
                                        MDR.SourceTools.src_ME_Veh,
                                        MDR.SourceTools.src_ME_Experian_Veh,
                                        MDR.SourceTools.src_MD_Experian_DL,
                                        MDR.SourceTools.src_MD_Watercraft,
                                        MDR.SourceTools.src_MD_Experian_Veh,
                                        MDR.SourceTools.src_MA_DL,
                                        MDR.SourceTools.src_MA_Experian_Veh,
                                        MDR.SourceTools.src_MI_Watercraft,
                                        MDR.SourceTools.src_MI_Experian_Veh,
                                        MDR.SourceTools.src_MI_DL,
                                        MDR.SourceTools.src_MN_Veh,
                                        MDR.SourceTools.src_MN_Experian_Veh,
                                          MDR.SourceTools.src_MN_DL  ,
                                          MDR.SourceTools.src_MS_Experian_DL  ,
                                          MDR.SourceTools.src_MS_Experian_Veh ,
                                          MDR.SourceTools.src_MS_Veh,
                                          MDR.SourceTools.src_MS_Veh,
                                          MDR.SourceTools.src_MO_Experian_Veh,
                                          MDR.SourceTools.src_MO_Veh,
                                          MDR.SourceTools.src_MO_Watercraft,
                                          MDR.SourceTools.src_MT_Watercraft,
                                          MDR.SourceTools.src_MT_Experian_Veh,
                                          MDR.SourceTools.src_MT_Veh,
                                          MDR.SourceTools.src_NE_Veh,
                                          MDR.SourceTools.src_NE_Watercraft,
                                          MDR.SourceTools.src_NV_Experian_Veh,
                                          MDR.SourceTools.src_NV_Veh,
                                          MDR.SourceTools.src_NV_DL ,
                                          MDR.SourceTools.src_NH_Watercraft,
                                          MDR.SourceTools.src_NH_Experian_DL,
                                          MDR.SourceTools.src_NM_Experian_Veh,
                                          MDR.SourceTools.src_NY_Experian_Veh,
                                          MDR.SourceTools.src_EMerge_CCW,
                                          MDR.SourceTools.src_NC_Veh,
                                          MDR.SourceTools.src_ND_Experian_DL,
                                          MDR.SourceTools.src_ND_Experian_Veh ,
                                          MDR.SourceTools.src_ND_Veh ,
                                          MDR.SourceTools.src_ND_Watercraft,
                                          MDR.SourceTools.src_OH_Experian_Veh,
                                          MDR.SourceTools.src_OH_Veh,
                                          MDR.SourceTools.src_OH_DL,
                                          MDR.SourceTools.src_OK_Experian_Veh ,
                                          MDR.SourceTools.src_SC_Experian_Veh ,
                                          MDR.SourceTools.src_SC_Watercraft,
                                          MDR.SourceTools.src_Professional_License,
                                          MDR.SourceTools.src_SC_Experian_DL,
                                          MDR.SourceTools.src_TN_DL,
                                          MDR.SourceTools.src_TN_Experian_Veh,
                                          MDR.SourceTools.src_TX_DL,
                                          MDR.SourceTools.src_TX_Veh,
                                          MDR.SourceTools.src_TX_Experian_Veh,
                                          MDR.SourceTools.src_UT_Watercraft,
                                          MDR.SourceTools.src_UT_Experian_Veh ,
                                          MDR.SourceTools.src_VA_Watercraft ,
                                          MDR.SourceTools.src_WA_Watercraft ,
                                          MDR.SourceTools.src_WI_Veh ,
                                          MDR.SourceTools.src_WV_DL ,
                                          MDR.SourceTools.src_WI_Experian_Veh,
                                          MDR.SourceTools.src_WI_DL ,
                                          MDR.SourceTools.src_WY_DL,
                                          MDR.SourceTools.src_WY_Experian_Veh ,
                                          MDR.SourceTools.src_WY_Veh ,
                                          MDR.SourceTools.src_Targus_White_pages,
                                          MDR.SourceTools.src_LnPropV2_Fares_Asrs ,
                                          MDR.SourceTools.src_Foreclosures ,
                                          MDR.SourceTools.src_Equifax ,
                                          MDR.SourceTools.src_EBR ,
                                          MDR.SourceTools.src_Experian_Credit_Header  ,
                                          MDR.SourceTools.src_Certegy ,
                                          MDR.SourceTools.src_Yellow_Pages ,
                                          MDR.SourceTools.src_Wired_Assets_Email ,
                                          MDR.SourceTools.src_TUCS_Ptrack ,
                                          MDR.SourceTools.src_Entiera ,
                                          MDR.SourceTools.src_Wired_Assets_Owned,
                                          MDR.SourceTools.src_TU_CreditHeader
                                          ];
END;
