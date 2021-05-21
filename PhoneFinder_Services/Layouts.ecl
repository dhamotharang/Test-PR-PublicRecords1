IMPORT Autokey_batch,BatchShare,doxie,Doxie_Raw,iesp,Royalty,PhoneFraud, ThreatMetrix, Phones, iesp;

  EXPORT Layouts :=
  MODULE

  EXPORT BatchIn :=
  RECORD
    STRING20	acctno;

    STRING20	name_first;
    STRING20	name_middle;
    STRING20	name_last;
    STRING5		name_suffix;

    STRING10  prim_range;
    STRING2   predir;
    STRING28  prim_name;
    STRING4   addr_suffix;
    STRING2   postdir;
    STRING10  unit_desig;
    STRING8   sec_range;
    STRING25  p_city_name;
    STRING2   st;
    STRING5   z5;
    STRING4   z4;

    STRING12	ssn;
    STRING10  phone;

    UNSIGNED6 did;
  END;

  EXPORT BatchInAppendAcctno :=
  RECORD(BatchIn)
    STRING20 orig_acctno; // [internal]
    UNSIGNED2 did_count := 0;
    UNSIGNED6 orig_did;
    BatchShare.Layouts.ShareErrors;
  END;

  // Batch input with DID appended to the layout
  EXPORT BatchInAppendDID :=
  RECORD(Autokey_batch.Layouts.rec_inBatchMaster)
    UNSIGNED2 did_count := 0;
    UNSIGNED6 orig_did;
    STRING8   dod := '';
  END;

  // Carrier information
  EXPORT CarrierInfo :=
  MODULE

    EXPORT Base :=
    RECORD
      STRING3  carrier_type;
      STRING60 carrier_name;
      STRING50 carrier_city;
      STRING2  carrier_state;
      STRING1  dial_ind;
      STRING3  coctype;
      STRING4  ssc;
      STRING   coc_description;
      STRING   ssc_description;
    END;

  END;

  // Phone finder layouts
  EXPORT PhoneFinder :=
  MODULE

    EXPORT Src_Rec :=
    RECORD
      STRING3 Src;
    END;

    EXPORT _type := RECORD
      STRING40 _Type;
    END;

    // Phones common layout
    EXPORT Common :=
    RECORD(doxie.layout_pp_raw_common)
      BatchInAppendDID batch_in;
      UNSIGNED1        phone_source;
      DATASET(Src_Rec) Phn_src_all;
    END;
    // ACCUDATA IN LAYOUT
    EXPORT Accudata_in := RECORD
        STRING20      acctno;
        STRING10      phone;
    END;

   // v---- Added next 7 lines for the 2021-06-02 Phone Porting Data for LE project
    EXPORT ServiceProviderInfo := RECORD
      STRING10 id;
      STRING40 company;
      STRING100 contact;
      STRING20 contact_phone;
    END;

    EXPORT PortHistory :=
    RECORD
      STRING ServiceProvider;
      UNSIGNED4 PortStartDate;
      UNSIGNED4 PortEndDate;
      // v---- Added next 4 lines for the 2021-06-02 Phone Porting Data for LE project
      ServiceProviderInfo ServiceProviderInfo;
      UNSIGNED4 DateOfChange;
      ServiceProviderInfo AltServiceProviderInfo;
      ServiceProviderInfo LastAltServiceProviderInfo;
    END;

    EXPORT Porting :=
    RECORD
      STRING PortingCode;
      UNSIGNED1 PortingCount;
      DATASET(PortHistory) PortingHistory;
      UNSIGNED4 FirstPortedDate;
      UNSIGNED4 LastPortedDate;
      STRING15 PhoneStatus;
      UNSIGNED4 ActivationDate;
      UNSIGNED4 DisconnectDate;
      BOOLEAN 	NoContractCarrier;
      BOOLEAN 	Prepaid;
      UNSIGNED1 serviceType;
      STRING PortingStatus;
      // v---- Added next 4 lines for the 2021-06-02 Phone Porting Data for LE project
      ServiceProviderInfo ServiceProviderInfo;
      UNSIGNED4 DateOfChange;
      ServiceProviderInfo AltServiceProviderInfo;
      ServiceProviderInfo LastAltServiceProviderInfo;
    END;

    EXPORT SpoofHistory :=
    RECORD
      STRING1 PhoneOrigin;
      STRING8 EventDate;
    END;
    EXPORT SpoofCommon :=
    RECORD
      BOOLEAN Spoofed;
      UNSIGNED SpoofedCount;
      UNSIGNED4 FirstSpoofedDate;
      UNSIGNED4 LastSpoofedDate;
    END;

    EXPORT SpoofingData :=
    RECORD
      SpoofCommon Spoof;
      SpoofCommon Destination;
      SpoofCommon Source;
      UNSIGNED TotalSpoofedCount;
      UNSIGNED4 FirstEventSpoofedDate;
      UNSIGNED4 LastEventSpoofedDate;
      DATASET(SpoofHistory) SpoofingHistory;
    END;

    EXPORT OTPs :=
    RECORD
      BOOLEAN 	OTPStatus;
      STRING8 	EventDate;
    END;

    EXPORT OneTimePassword :=
    RECORD
      BOOLEAN 	OTP;
      UNSIGNED2 OTPCount;
      UNSIGNED4 FirstOTPDate;
      UNSIGNED4 LastOTPDate;
      BOOLEAN 	LastOTPStatus;
      DATASET(OTPs) OTPHistory;
    END;

    EXPORT	Alert :=
    RECORD
      STRING flag;
      DATASET(iesp.share.t_STRINGArrayItem) messages;
    END;

    // Phone finder common layout with carrier information
    EXPORT Final :=
    RECORD
      // Batch input fields
      // BatchInAppendDID                                  batch_in;
      STRING20                                          acctno;
      UNSIGNED8                                         seq;
      UNSIGNED6                                         did;
      UNSIGNED6                                         InputDID;
      UNSIGNED2                                         penalt;
      STRING2                                           vendor_id;
      STRING2                                           src;
      STRING2                                           phone_vendor;
      STRING1                                           typeflag;
      STRING8                                           dt_first_seen;
      STRING8                                           dt_last_seen;
      STRING25	                                        append_phone_type;
      STRING10                                          phone;
      STRING2	                                          phoneState;
      STRING9                                           ssn;
      STRING2                                           SSNMatch;
      UNSIGNED4                                         dob;
      UNSIGNED4                                         dod;
      STRING1                                           deceased;
      STRING20                                          fname;
      STRING20                                          mname;
      STRING20                                          lname;
      STRING5                                           name_suffix;
      STRING10                                          prim_range;
      STRING2                                           predir;
      STRING28                                          prim_name;
      STRING4                                           suffix;
      STRING2                                           postdir;
      STRING10                                          unit_desig;
      STRING8                                           sec_range;
      STRING25                                          city_name;
      STRING2                                           st;
      STRING5                                           zip;
      STRING4                                           zip4;
      STRING5                                           county_code;
      STRING18                                          county_name;
      STRING1                                           tnt;
      STRING40                                          primary_address_type;
      STRING120                                         listed_name;
      STRING120                                         Full_name;
      STRING120                                         listed_name_targus;
      STRING10                                          listed_phone;
      STRING1                                           listing_type_res;
      STRING1                                           listing_type_bus;
      STRING1                                           listing_type_gov;
      STRING254                                         caption_text;
      UNSIGNED2	                                        ConfidenceScore;
      STRING1		                                        ActiveFlag;
      STRING2                                           TargusType;
      BOOLEAN                                           vendor_dt_last_seen_used;
      STRING1                                           dial_indicator;
      STRING60                                          carrier_name;
      STRING50                                          phone_region_city;
      STRING2                                           phone_region_st;
      STRING3                                           coctype;
      STRING                                            coc_description;
      STRING4                                           ssc;
      STRING                                            ssc_description;
      BOOLEAN                                           telcordia_only;
      BOOLEAN                                           isPrimaryPhone;
      BOOLEAN                                           isPrimaryIdentity;
      UNSIGNED1                                         phone_source;
      // Fields pertaining only to waterfall process
      STRING8                                           matchcodes;
      UNSIGNED                                          error_code;
      STRING2                                           subj_phone_type;
      STRING2                                           subj_phone_type_new;
      UNSIGNED                                          sort_order;
      UNSIGNED                                          sort_order_internal;
      UNSIGNED                                          sub_rule_number;
      STRING3                                           phone_score;
      // Experian File One
      STRING3                                           Phone_Digits;
      STRING15                                          Encrypted_Experian_PIN;
      // QSent phone detail fields
      Doxie_Raw.PhonesPlus_Layouts.t_RealTimePhone_Ext RealTimePhone_Ext;
      Porting;
      SpoofingData;
      OneTimePassword;
      STRING4                                               PhoneRiskIndicator;
      BOOLEAN                                               OTPRIFailed;
      DATASET(Alert)                                        Alerts;
      DATASET(iesp.phonefinder.t_PhoneFinderAlertIndicator) AlertIndicators;
      DATASET({STRING17 InquiryDate})									      InquiryDates;
      UNSIGNED                                              RECORDsReturned;
      BOOLEAN                                               PhoneOwnershipIndicator;
      STRING                                                rec_source;
      STRING15                                              CallForwardingIndicator;
      STRING                                                imsi_seensince;
      STRING8                                               imsi_changedate;
      STRING8                                               imsi_ActivationDate;
      UNSIGNED                                              imsi_changedthis_time;
      UNSIGNED                                              iccid_changedthis_time;
      STRING                                                iccid_seensince;
      STRING                                                imei_seensince;
      STRING8                                               imei_changedate;
      UNSIGNED                                              imei_changedthis_time;
      STRING8                                               imei_ActivationDate;
      UNSIGNED                                              loststolen;
      STRING8                                               loststolen_date;
      BOOLEAN                                               is_verified;
      STRING100                                             verification_desc;
      ThreatMetrix.gateway_trustdefender.t_TrustDefenderDetailedResponse.ReasonCodes;
      ThreatMetrix.gateway_trustdefender.t_TrustDefenderDetailedResponse.TmxVariables;
      UNSIGNED2                                             identity_count := 0;
      UNSIGNED                                              phone_inresponse_count;
      BOOLEAN                                               isLNameMatch;
      UNSIGNED                                              imsi_Tenure_MinDays;
      UNSIGNED                                              imsi_Tenure_MaxDays;
      UNSIGNED                                              imei_Tenure_MinDays;
      UNSIGNED                                              imei_Tenure_MaxDays;
      UNSIGNED                                              sim_Tenure_MinDays;
      UNSIGNED                                              sim_Tenure_MaxDays;
      DATASET(Src_Rec)                                      Phn_src_all;
      DATASET(iesp.phonefinder.t_PhoneFinderSourceIndicator) SourceInfo;
      BOOLEAN                                               SelfReportedSourcesOnly;
      UNSIGNED                                              TotalSourceCount;
      UNSIGNED                                              identity_id;
      UNSIGNED                                              phone_id;
      STRING1                                               phone_starRating;
    END;

    EXPORT ExcludePhones :=
    RECORD
      STRING20 acctno;
      STRING10 phone;
    END;

    EXPORT IdentitySlim :=
    RECORD
      STRING20  acctno;
      UNSIGNED6 did;
      UNSIGNED6 InputDID;
      BOOLEAN   isPrimaryIdentity;
      UNSIGNED2 penalt;
      STRING2   vendor_id;
      STRING2   src;
      STRING1   typeflag;
      UNSIGNED4 dt_first_seen;
      UNSIGNED4 dt_last_seen;
      STRING10  phone;
      UNSIGNED4 dob;
      STRING9   ssn;
      STRING1   deceased;
      STRING20  fname;
      STRING20  mname;
      STRING20  lname;
      STRING5   name_suffix;
      STRING120 Full_name;
      STRING120 listed_name;
      STRING10  prim_range;
      STRING2   predir;
      STRING28  prim_name;
      STRING4   suffix;
      STRING2   postdir;
      STRING10  unit_desig;
      STRING8   sec_range;
      STRING25  city_name;
      STRING2   st;
      STRING5   zip;
      STRING4   zip4;
      STRING5   county_code;
      STRING18  county_name;
      STRING40  primary_address_type;
      UNSIGNED1 phone_source;
      STRING1   tnt;
      BOOLEAN   PhoneOwnershipIndicator;
      BOOLEAN   is_identity_verified;
      BOOLEAN   is_phone_verified;
      STRING100 verification_desc;
      DATASET(Src_Rec) Phn_src_all;
      INTEGER  sim_Tenure_MinDays;
      INTEGER  sim_Tenure_MaxDays;
      INTEGER  imei_Tenure_MinDays;
      INTEGER  imei_Tenure_MaxDays;
    END;

    EXPORT PhoneSlim :=
    RECORD(Doxie_Raw.PhonesPlus_Layouts.t_RealTimePhone_Ext)
      STRING20  acctno;
      UNSIGNED2 penalt;
      STRING2   vendor_id;
      STRING2   src;
      STRING1   typeflag;
      STRING10  orig_phone;
      STRING10  phone;
      BOOLEAN   isPrimaryPhone;
      STRING2   phone_state;
      STRING60  carrier_name;
      STRING50  phone_region_city;
      STRING2   phone_region_st;
      STRING    coc_description;
      UNSIGNED1 phone_source;
      STRING3   phone_score;
      STRING2   subj_phone_type_new;
      UNSIGNED4 dt_first_seen;
      UNSIGNED4 dt_last_seen;
      STRING10  prim_range;
      STRING2   predir;
      STRING28  prim_name;
      STRING4   suffix;
      STRING2   postdir;
      STRING10  unit_desig;
      STRING8   sec_range;
      STRING25  city_name;
      STRING2   st;
      STRING5   zip;
      STRING4   zip4;
      STRING5   county_code;
      STRING18  county_name;
      Porting - PortingCode;
      SpoofingData;
      OneTimePassword;
      STRING4 PhoneRiskIndicator;
      BOOLEAN OTPRIFailed;
      DATASET(Alert) Alerts;
      DATASET({STRING17 InquiryDate})	InquiryDates;
      UNSIGNED RecordsReturned;
      BOOLEAN  PhoneOwnershipIndicator;
      STRING15 CallForwardingIndicator;
      STRING   imsi_seensince;
      STRING8  imsi_changedate;
      STRING8  imsi_ActivationDate;
      INTEGER  imsi_changedthis_time;
      INTEGER  iccid_changedthis_time;
      STRING   iccid_seensince;
      STRING   imei_seensince;
      STRING8  imei_changedate;
      INTEGER  imei_changedthis_time;
      STRING8  imei_ActivationDate;
      INTEGER  loststolen;
      STRING8  loststolen_date;
      ThreatMetrix.gateway_trustdefender.t_TrustDefenderDetailedResponse.ReasonCodes;
      ThreatMetrix.gateway_trustdefender.t_TrustDefenderDetailedResponse.TmxVariables;
      UNSIGNED2  identity_count := 0;
      INTEGER  sim_Tenure_MinDays;
      INTEGER  sim_Tenure_MaxDays;
      INTEGER  imei_Tenure_MinDays;
      INTEGER  imei_Tenure_MaxDays;
      DATASET(Src_Rec) Phn_src_all;
      STRING1  phone_starrating;
    END;

    EXPORT IdentityIesp :=
    RECORD(iesp.phonefinder.t_PhoneIdentityInfo)
      STRING20 acctno;
      STRING10  phone;
      STRING2   vendor_id; // for zumigo logging dataset
    END;

    EXPORT PhoneIesp :=
    RECORD(iesp.phonefinder.t_PhoneFinderDetailedInfo)
      STRING20 acctno;
    END;

    EXPORT OtherPhoneIesp :=
    RECORD(iesp.phonefinder.t_PhoneFinderInfo)
      STRING20 acctno;
    END;

    EXPORT TempOut :=
    RECORD(BatchInAppendAcctno)
      DATASET(iesp.phonefinder.t_PhoneIdentityInfo) identity_info;
      DATASET(iesp.phonefinder.t_PhoneFinderInfo)   other_phones;
      iesp.phonefinder.t_PhoneFinderDetailedInfo    phone_info;
      iesp.phonefinder.t_PhoneIdentityInfo          primary_identity;
    END;

    LOADXML('<xml/>');
    #DECLARE(IdentityInfo);
    #DECLARE(cntIdentity);

    #SET(IdentityInfo,'');
    #SET(cntIdentity,1);

    #LOOP
      #IF(%cntIdentity% > iesp.Constants.Phone_Finder.MaxIdentities)
        #BREAK;
      #ELSE
        #APPEND(IdentityInfo,
                'STRING   Identity' + %'cntIdentity'% + '_DID;' +
                'STRING62 Identity' + %'cntIdentity'% + '_Full;' +
                'STRING20 Identity' + %'cntIdentity'% + '_First;' +
                'STRING20 Identity' + %'cntIdentity'% + '_Middle;' +
                'STRING20 Identity' + %'cntIdentity'% + '_Last;' +
                'STRING5  Identity' + %'cntIdentity'% + '_Suffix;' +
                'STRING9 Identity' + %'cntIdentity'% + '_SSN;' +
                'STRING1  Identity' + %'cntIdentity'% + '_Deceased;' +
                'STRING10 Identity' + %'cntIdentity'% + '_StreetNumber;' +
                'STRING2  Identity' + %'cntIdentity'% + '_StreetPreDirection;' +
                'STRING28 Identity' + %'cntIdentity'% + '_StreetName;' +
                'STRING4  Identity' + %'cntIdentity'% + '_StreetSuffix;' +
                'STRING2  Identity' + %'cntIdentity'% + '_StreetPostDirection;' +
                'STRING10 Identity' + %'cntIdentity'% + '_UnitDesignation;' +
                'STRING8  Identity' + %'cntIdentity'% + '_UnitNumber;' +
                'STRING25 Identity' + %'cntIdentity'% + '_City;' +
                'STRING2  Identity' + %'cntIdentity'% + '_State;' +
                'STRING5  Identity' + %'cntIdentity'% + '_Zip5;' +
                'STRING4  Identity' + %'cntIdentity'% + '_Zip4;' +
                'STRING18 Identity' + %'cntIdentity'% + '_County;' +
                'STRING40 Identity' + %'cntIdentity'% + '_PrimaryAddressType;' +
                'STRING1  Identity' + %'cntIdentity'% + '_RECORDType;' +
                'STRING8  Identity' + %'cntIdentity'% + '_FirstSeenWithPrimaryPhone;' +
                'STRING8  Identity' + %'cntIdentity'% + '_LastSeenWithPrimaryPhone;' +
                'STRING8  Identity' + %'cntIdentity'% + '_TimeWithPrimaryPhone;' +
                'STRING8  Identity' + %'cntIdentity'% + '_TimeSinceLastSeenWithPrimaryPhone;' +
                'BOOLEAN  Identity' + %'cntIdentity'% + '_PhoneOwnershipIndicator;');
        #SET(cntIdentity,%cntIdentity% + 1)
      #END
    #END

    #DECLARE(Alerts);
    #DECLARE(cntAlerts);

    #SET(Alerts,'');
    #SET(cntAlerts,1);

    #LOOP
      #IF(%cntAlerts% > PhoneFinder_Services.Constants.MaxAlertCategories)
        #BREAK;
      #ELSE
        #APPEND(Alerts,
                'STRING Alerts' + %'cntAlerts'% + '_Flag;' +
                'STRING Alerts' + %'cntAlerts'% + '_Messages;');
        #SET(cntAlerts,%cntAlerts% + 1)
      #END
    #END

    #DECLARE(OtherPhones);
    #DECLARE(cntPhone);

    #SET(OtherPhones,'');
    #SET(cntPhone,1);

    #LOOP
      #IF(%cntPhone% > iesp.Constants.Phone_Finder.MaxOtherPhones)
        #BREAK;
      #ELSE
        #APPEND(OtherPhones,
                'STRING OtherPhone' + %'cntPhone'% + '_PhoneNumber;' +
                'STRING OtherPhone' + %'cntPhone'% + '_PhoneType;' +
                'STRING OtherPhone' + %'cntPhone'% + '_ListingName;' +
                'STRING OtherPhone' + %'cntPhone'% + '_Carrier;' +
                'STRING OtherPhone' + %'cntPhone'% + '_CarrierCity;' +
                'STRING OtherPhone' + %'cntPhone'% + '_CarrierState;' +
                'STRING OtherPhone' + %'cntPhone'% + '_PhoneStatus;' +
                'STRING OtherPhone' + %'cntPhone'% + '_Source;' +
                'STRING OtherPhone' + %'cntPhone'% + '_PortCode;' +
                'STRING OtherPhone' + %'cntPhone'% + '_PhoneRiskIndicator;' +
                'BOOLEAN OtherPhone' + %'cntPhone'% + '_OTPRIFailed;' +
                'STRING8 OtherPhone' + %'cntPhone'% + '_LastPortedDate;' +
                'STRING10 OtherPhone' + %'cntPhone'% + '_StreetNumber;' +
                'STRING2  OtherPhone' + %'cntPhone'% + '_StreetPreDirection;' +
                'STRING28 OtherPhone' + %'cntPhone'% + '_StreetName;' +
                'STRING4  OtherPhone' + %'cntPhone'% + '_StreetSuffix;' +
                'STRING2  OtherPhone' + %'cntPhone'% + '_StreetPostDirection;' +
                'STRING10 OtherPhone' + %'cntPhone'% + '_UnitDesignation;' +
                'STRING8  OtherPhone' + %'cntPhone'% + '_UnitNumber;' +
                'STRING25 OtherPhone' + %'cntPhone'% + '_City;' +
                'STRING2  OtherPhone' + %'cntPhone'% + '_State;' +
                'STRING5  OtherPhone' + %'cntPhone'% + '_Zip5;' +
                'STRING4  OtherPhone' + %'cntPhone'% + '_Zip4;' +
                'STRING18 OtherPhone' + %'cntPhone'% + '_County;' +
                'STRING8  OtherPhone' + %'cntPhone'% + '_DateFirstSeen;' +
                'STRING8  OtherPhone' + %'cntPhone'% + '_DateLastSeen;' +
                'STRING8  OtherPhone' + %'cntPhone'% + '_MonthsWithPhone;' +
                'STRING8  OtherPhone' + %'cntPhone'% + '_MonthsSinceLastSeen;' +
                'BOOLEAN  OtherPhone' + %'cntPhone'% + '_PhoneOwnershipIndicator;' +
                'STRING15  OtherPhone' + %'cntPhone'% + '_CallForwardingIndicator;' +
                'STRING1  OtherPhone' + %'cntPhone'% + '_PhoneStarRating;');
        #SET(cntPhone,%cntPhone% + 1)
      #END
    #END

    #DECLARE(PhoneHistoryInfo);
    #DECLARE(cntPhoneHist);

    #SET(PhoneHistoryInfo,'');
    #SET(cntPhoneHist,1);

    #LOOP
      #IF(%cntPhoneHist% > iesp.Constants.Phone_Finder.MaxPhoneHistory)
        #BREAK;
      #ELSE
        #APPEND(PhoneHistoryInfo,
                'STRING62 PhoneHist' + %'cntPhoneHist'% + '_Full;' +
                'STRING20 PhoneHist' + %'cntPhoneHist'% + '_First;' +
                'STRING20 PhoneHist' + %'cntPhoneHist'% + '_Middle;' +
                'STRING20 PhoneHist' + %'cntPhoneHist'% + '_Last;' +
                'STRING5  PhoneHist' + %'cntPhoneHist'% + '_Suffix;' +
                'STRING3  PhoneHist' + %'cntPhoneHist'% + '_Prefix;' +
                'STRING10 PhoneHist' + %'cntPhoneHist'% + '_StreetNumber;' +
                'STRING2  PhoneHist' + %'cntPhoneHist'% + '_StreetPreDirection;' +
                'STRING28 PhoneHist' + %'cntPhoneHist'% + '_StreetName;' +
                'STRING4  PhoneHist' + %'cntPhoneHist'% + '_StreetSuffix;' +
                'STRING2  PhoneHist' + %'cntPhoneHist'% + '_StreetPostDirection;' +
                'STRING10 PhoneHist' + %'cntPhoneHist'% + '_UnitDesignation;' +
                'STRING8  PhoneHist' + %'cntPhoneHist'% + '_UnitNumber;' +
                'STRING25 PhoneHist' + %'cntPhoneHist'% + '_City;' +
                'STRING2  PhoneHist' + %'cntPhoneHist'% + '_State;' +
                'STRING5  PhoneHist' + %'cntPhoneHist'% + '_Zip5;' +
                'STRING4  PhoneHist' + %'cntPhoneHist'% + '_Zip4;' +
                'STRING18 PhoneHist' + %'cntPhoneHist'% + '_County;' +
                'STRING8  PhoneHist' + %'cntPhoneHist'% + '_FirstSeen;' +
                'STRING8  PhoneHist' + %'cntPhoneHist'% + '_LastSeen;');
        #SET(cntPhoneHist,%cntPhoneHist% + 1)
      #END
    #END


    #DECLARE(PortingHistory);
    #DECLARE(cntPorts);

    #SET(PortingHistory,'');
    #SET(cntPorts,1);

    #LOOP
      #IF(%cntPorts% > iesp.Constants.Phone_Finder.MaxPorts)
        #BREAK;
      #ELSE
        #APPEND(PortingHistory,
                'STRING PortingHistory' + %'cntPorts'% + '_ServiceProvider;' +
                'STRING8 PortingHistory' + %'cntPorts'% + '_PortStartDate;' +
                'STRING8 PortingHistory' + %'cntPorts'% + '_PortEndDate;' +
                // Revised the 1 line above(---^) and added the next 13 lines(---v) for the 2021-06-02 Phone Porting Data for LE project
                'STRING4   PortingHistory' + %'cntPorts'% + '_ServiceProviderId;' +
                'STRING60  PortingHistory' + %'cntPorts'% + '_ServiceProviderCompany;' +
                'STRING60  PortingHistory' + %'cntPorts'% + '_ServiceProviderContact;' +
                'STRING10  PortingHistory' + %'cntPorts'% + '_ServiceProviderContactPhone;' +
                'STRING8   PortingHistory' + %'cntPorts'% + '_DateOfChange;' +
                'STRING4   PortingHistory' + %'cntPorts'% + '_AltServiceProviderId;' +
                'STRING60  PortingHistory' + %'cntPorts'% + '_AltServiceProviderCompany;' +
                'STRING60  PortingHistory' + %'cntPorts'% + '_AltServiceProviderContact;' +
                'STRING10  PortingHistory' + %'cntPorts'% + '_AltServiceProviderContactPhone;' +
                'STRING4   PortingHistory' + %'cntPorts'% + '_LastAltServiceProviderId;' +
                'STRING60  PortingHistory' + %'cntPorts'% + '_LastAltServiceProviderCompany;' +
                'STRING60  PortingHistory' + %'cntPorts'% + '_LastAltServiceProviderContact;' +
                'STRING10  PortingHistory' + %'cntPorts'% + '_LastAltServiceProviderContactPhone;');
        #SET(cntPorts,%cntPorts% + 1)
      #END
    #END

    #DECLARE(SpoofingHistory);
    #DECLARE(cntSpoofs);

    #SET(SpoofingHistory,'');
    #SET(cntSpoofs,1);

    #LOOP
      #IF(%cntSpoofs% > iesp.Constants.Phone_Finder.MaxSpoofs)
        #BREAK;
      #ELSE
        #APPEND(SpoofingHistory,
                'STRING1 SpoofingHistory' + %'cntSpoofs'% + '_PhoneOrigin;' +
                'STRING8 SpoofingHistory' + %'cntSpoofs'% + '_EventDate;');
        #SET(cntSpoofs,%cntSpoofs% + 1)
      #END
    #END

    #DECLARE(OTPHistory);
    #DECLARE(cntOTPs);

    #SET(OTPHistory,'');
    #SET(cntOTPs,1);

    #LOOP
      #IF(%cntOTPs% > PhoneFinder_Services.Constants.MaxOTPMatches)
        #BREAK;
      #ELSE
        #APPEND(OTPHistory,
                'BOOLEAN OTPHistory' + %'cntOTPs'% + '_OTPStatus;' +
                'STRING8 OTPHistory' + %'cntOTPs'% + '_EventDate;');
        #SET(cntOTPs,%cntOTPs% + 1)
      #END
    #END

    #DECLARE(RoyaltyInfo);
    #DECLARE(cntRoyalty);

    #SET(RoyaltyInfo,'');
    #SET(cntRoyalty,1);

    #LOOP
      #IF(%cntRoyalty% > PhoneFinder_Services.Constants.MaxRoyalties)
        #BREAK;
      #ELSE
        #APPEND(RoyaltyInfo,
                'TYPEOF(Royalty.Layouts.Royalty.royalty_type) royalty_type_' + %'cntRoyalty'% + ';' +
                'TYPEOF(Royalty.Layouts.RoyaltySrc.royalty_src) royalty_src_' + %'cntRoyalty'% + ';');
        #SET(cntRoyalty,%cntRoyalty% + 1)
      #END
    #END

    EXPORT BatchOut :=
    RECORD,MAXLENGTH(61000) 
    //NOTE: ^--- This length may seem excessive, but it had to be increased for the 2021-06-02 Phone Porting Data for 
    //      LE project due to adding 13 new PortingHistory fields(410 bytes each) * 100 (MaxPorts) = 41000 + 20000 = 61000
      BatchIn;
      %IdentityInfo%
      %OtherPhones%
      %PhoneHistoryInfo%
      STRING   Number;
      STRING1 PhoneStarRating;
      STRING   _Type;
      STRING   Carrier;
      STRING   CarrierCity;
      STRING   CarrierState;
      STRING   ListingName;
      STRING   PhoneStatus;
      STRING   Source;
      STRING   ListingType;
      STRING   PrivacyIndicator;
      STRING   MSA;
      STRING   CMSA;
      STRING   FIPS;
      STRING   CarrierRoute;
      STRING   CarrierRouteZoneCode;
      STRING   CongressionalDistrict;
      STRING   DeliveryPointCode;
      STRING10 Latitude;
      STRING11 Longitude;
      STRING   AddressType;
      STRING   PortingCode;
      UNSIGNED1 PortingCount;
      UNSIGNED4 FirstPortedDate;
      UNSIGNED4 LastPortedDate;
      UNSIGNED4 ActivationDate;
      UNSIGNED4 DisconnectDate;
      BOOLEAN 	NoContractCarrier;
      BOOLEAN 	Prepaid;
      STRING10 PortingStatus;
      %PortingHistory%
      BOOLEAN Spoof_Spoofed;
      UNSIGNED Spoof_SpoofedCount;
      UNSIGNED4 Spoof_FirstSpoofedDate;
      UNSIGNED4 Spoof_LastSpoofedDate;
      BOOLEAN Destination_Spoofed;
      UNSIGNED Destination_SpoofedCount;
      UNSIGNED4 Destination_FirstSpoofedDate;
      UNSIGNED4 Destination_LastSpoofedDate;
      BOOLEAN Source_Spoofed;
      UNSIGNED Source_SpoofedCount;
      UNSIGNED4 Source_FirstSpoofedDate;
      UNSIGNED4 Source_LastSpoofedDate;
      UNSIGNED TotalSpoofedCount;
      UNSIGNED4 FirstEventSpoofedDate;
      UNSIGNED4 LastEventSpoofedDate;
      %SpoofingHistory%
      BOOLEAN 	OTPMatch;
      UNSIGNED2 OTPCount;
      UNSIGNED4 FirstOTPDate;
      UNSIGNED4 LastOTPDate;
      BOOLEAN 	LastOTPStatus;
      %OTPHistory%
      STRING4 PhoneRiskIndicator;
      BOOLEAN OTPRIFailed;
      %Alerts%
      STRING15 CallForwardingIndicator;
      STRING100 PhoneVerificationDescription;
      boolean PhoneVerified;
      STRING   CallerID;
      STRING   CompanyNumber;
      STRING   Name;
      STRING10 StreetNumber;
      STRING2  StreetPreDirection;
      STRING28 StreetName;
      STRING4  StreetSuffix;
      STRING2  StreetPostDirection;
      STRING10 UnitDesignation;
      STRING8  UnitNumber;
      STRING60 StreetAddress1;
      STRING60 StreetAddress2;
      STRING25 City;
      STRING2  State;
      STRING5  Zip5;
      STRING4  Zip4;
      STRING18 County;
      STRING9  PostalCode;
      STRING50 StateCityZip;
      STRING   AffiliatedTo;
      STRING62 ContactName_Full;
      STRING20 ContactName_First;
      STRING20 ContactName_Middle;
      STRING20 ContactName_Last;
      STRING5  ContactName_Suffix;
      STRING3  ContactName_Prefix;
      STRING10 ContactAddress_StreetNumber;
      STRING2  ContactAddress_StreetPreDirection;
      STRING28 ContactAddress_StreetName;
      STRING4  ContactAddress_StreetSuffix;
      STRING2  ContactAddress_StreetPostDirection;
      STRING10 ContactAddress_UnitDesignation;
      STRING8  ContactAddress_UnitNumber;
      STRING60 ContactAddress_StreetAddress1;
      STRING60 ContactAddress_StreetAddress2;
      STRING25 ContactAddress_City;
      STRING2  ContactAddress_State;
      STRING5  ContactAddress_Zip5;
      STRING4  ContactAddress_Zip4;
      STRING18 ContactAddress_County;
      STRING9  ContactAddress_PostalCode;
      STRING50 ContactAddress_StateCityZip;
      STRING   Email;
      STRING   ContactPhone;
      STRING   ContactPhoneExt;
      STRING   Fax;
      // v---- Added the next 4 lines for the 2021-06-02 Phone Porting Data for LE project
      ServiceProviderInfo ServiceProvider;
      UNSIGNED4 DateOfChange;
      ServiceProviderInfo AltServiceProvider;
      ServiceProviderInfo LastAltServiceProvider; 
      %RoyaltyInfo%
      BatchShare.Layouts.ShareErrors;
    END;

  END;
//***** end of PhoneFinder MODULE *****


  EXPORT SubjectPhone := RECORD
    STRING20 	acctno;
    UNSIGNED6 DID;
    STRING10  phone;
    UNSIGNED4 FirstSeenDate;
    UNSIGNED4 LastSeenDate;
  END;

  // Deltabase Layouts
  EXPORT DeltaPortedDataRECORD := RECORD
    UNSIGNED   transaction_id				{XPATH('id')};
    STRING     date_added				  	{XPATH('date_added')};
    STRING10   phone				  				{XPATH('phone')};
    STRING10   spid				  				{XPATH('spid')};
    STRING5    source				  			{XPATH('source')};
    UNSIGNED4  port_start_dt				  {XPATH('port_start_dt')};
    UNSIGNED4  port_end_dt					  {XPATH('port_end_dt')};
    BOOLEAN	  is_ported						  {XPATH('is_ported')};
    // v---- Added next 2 lines for the 2021-06-02 Phone Porting Data for LE project
    STRING10   alt_spid             {XPATH('alt_spid')};
    STRING10   lalt_spid            {XPATH('lalt_spid')};
  END;

  EXPORT PortedMetadata := RECORD
    Phones.Layouts.portedMetadata_Main;
  END;

  // v---- Added the next 3 record layouts for the 2021-06-02 Phone Porting Data for LE project
  EXPORT SubPhone_PortedMetadata_Comb_Plus := RECORD
    SubjectPhone;
    PortedMetadata  -phone; // remove the 1 field(phone) from this one that is also on the SubjectPhone layout above, 
                            // to mimic what the first 3 joins in PhoneFinder_Services.GetPhonesPortedMetadata are doing.
    // v--- Additional fields needed by the project's new coding
    string40  sp_company := '';
    string100 sp_contact := '';
    string20  sp_contact_phone := '';
    string8   sp_dateofchange := ''; 
    string40  alt_sp_company := '';
    string100 alt_sp_contact := '';
    string20  alt_sp_contact_phone := '';
    string40  lalt_sp_company := '';
    string100 lalt_sp_contact := '';
    string20  lalt_sp_contact_phone := '';
    unsigned4 parent_seq := 0;
    unsigned4 child_seq := 0;
    string10  lookup_id := '';
    string40  lookup_company := '';
    string100 lookup_contact := '';
    string20  lookup_contact_phone := '';
  END;

  EXPORT SubPhone_Porting_Comb := RECORD
    SubjectPhone;
    PhoneFinder.Porting;
  END;

  EXPORT IconectivElepRequest_ext:= RECORD
    iesp.iconectiv_elep.t_IconectivElepRequest;
    STRING20 	acctno;
    UNSIGNED6 DID;
  END;
  // ^----- end of the new 3 layouts added for the 2021-06-02 Phone Porting Data for LE project

  EXPORT DeltabaseResponse := RECORD
    DATASET (DeltaPortedDataRECORD) RECORDs	 {XPATH('Records/Rec'), MAXCOUNT(PhoneFinder_Services.Constants.MaxPortedMatches)};
    STRING  RecsReturned                     {XPATH('RecsReturned'),MAXLENGTH(5)};
    STRING  Latency													 {XPATH('Latency')};
    STRING  ExceptionMessage								 {XPATH('Exceptions/Exception/Message')};
  END;

  EXPORT DeltaSpoofedRec := RECORD
    UNSIGNED   id										{XPATH('id')};
    STRING     date_added				  	{XPATH('date_added')};
    STRING45   reference_id					{XPATH('reference_id')};
    STRING20   mode_type						  {XPATH('mode_type')};
    STRING 		event_time						{XPATH('event_time')};
    STRING10   spoofed_phone_number	{XPATH('spoofed_phone_number')};
    STRING10   destination_number		{XPATH('destination_number')};
    STRING10   source_phone_number		{XPATH('source_phone_number')};
  END;

  EXPORT SpoofDeltabaseResponse := RECORD
    DATASET (DeltaSpoofedRec) 			RECORDs	{XPATH('Records/Rec'), MAXCOUNT(PhoneFinder_Services.Constants.MaxSpoofedMatches)};
    STRING  RecsReturned                    {XPATH('RecsReturned'),MAXLENGTH(5)};
    STRING  Latency													{XPATH('Latency')};
    STRING  ExceptionMessage								{XPATH('Exceptions/Exception/Message')};
  END;

  EXPORT DeltaOTPRec := RECORD
    STRING20  transaction_id                 {XPATH('transaction_id')};
    STRING  date_added                       {XPATH('date_added')};
    STRING  event_time                       {XPATH('event_time')};
    STRING10  otp_phone                      {XPATH('otp_phone')};
    STRING  function_name                    {XPATH('function_name')};
    STRING20  otp_id                         {XPATH('otp_id')};
    BOOLEAN  verify_passed                   {XPATH('verify_passed')};
    STRING1  otp_delivery_method             {XPATH('otp_delivery_method')};
  END;

  EXPORT OTPDeltabaseResponse := RECORD
    DATASET (DeltaOTPRec) 					RECORDs		{XPATH('Records/Rec'), MAXCOUNT(PhoneFinder_Services.Constants.MaxOTPMatches)};
    STRING  RecsReturned                     	{XPATH('RecsReturned'),MAXLENGTH(5)};
    STRING  Latency													 	{XPATH('Latency')};
    STRING  ExceptionMessage								 	{XPATH('Exceptions/Exception/Message')};
  END;

  EXPORT SpoofedRec := RECORD
    RECORDOF(PhoneFraud.Key_Spoofing);
  END;

  EXPORT OTPRec := RECORD
    RECORDOF(PhoneFraud.Key_OTP);
  END;

  EXPORT DeltaInquiryDataRECORD := RECORD
    UNSIGNED8    seq {XPATH('Seq')};
    STRING10     phone {XPATH('Phone')};
  END;

  EXPORT DeltaInquiryDeltabaseResponse := RECORD
    DATASET (DeltaInquiryDataRECORD) Response {XPATH('Records/Rec')};
    STRING  RECORDsReturned                  	{XPATH('RecsReturned'),MAXLENGTH(5)};
    STRING  Latency													 	{XPATH('Latency')};
    STRING  ExceptionMessage								 	{XPATH('Exceptions/Exception/Message')};
  END;

  EXPORT DeltaInquiry_recout := RECORD
    UNSIGNED8    seq;
    STRING10     phone;
    UNSIGNED RECORDsReturned;
  END;

  EXPORT Input_CompanyId := RECORD
    STRING16  CompanyId;
  END;

  EXPORT PFResSnapShotSearch := RECORD
    STRING8 StartDate;
    STRING8 EndDate;
    STRING60 UserId;
    DATASET(Input_CompanyId) CompanyIds {MAXCOUNT(iesp.Constants.PfResSnapshot.MaxCompanyIds)};
    STRING15 PhoneNumber;
    STRING60 ReferenceCode;
    UNSIGNED8 UniqueId;
  END;

  EXPORT log_other := RECORD(iesp.phonefinder.t_PhoneFinderInfo)
    INTEGER identity_count;
    UNSIGNED phone_id;
  END;

  EXPORT  log_primary := RECORD(iesp.phonefinder.t_PhoneFinderDetailedInfo)
    INTEGER identity_count;
  END;

   EXPORT  log_identities := RECORD(iesp.phonefinder.t_PhoneIdentityInfo)
    INTEGER identity_id;
  END;

  EXPORT delta_phones_rpt_sources:= RECORD
     STRING16 transaction_id;
     STRING15 phonenumber;
     UNSIGNED lexid;
     UNSIGNED phone_id;
     UNSIGNED identity_id;
     UNSIGNED sequence_number;
     STRING category;
     UNSIGNED totalsourcecount;
     STRING60 source_type;
     STRING3  Source;
    END;

  EXPORT log_PhoneFinderSearchRecord := RECORD
    DATASET(log_identities) Identities {xpath('Identities/Identity'), MAXCOUNT(iesp.Constants.Phone_Finder.MaxIdentities)};
    DATASET(log_other) OtherPhones {xpath('OtherPhones/Phone'), MAXCOUNT(iesp.Constants.Phone_Finder.MaxOtherPhones)};
    DATASET(iesp.phonefinder.t_PhoneFinderHistory) PhonesHistory {xpath('PhonesHistory/Phone'), MAXCOUNT(iesp.Constants.Phone_Finder.MaxPhoneHistory)};
    log_primary PrimaryPhoneDetails {xpath('PrimaryPhoneDetails')};
    DATASET(delta_phones_rpt_sources) log_source;
  END;

  //	DeltaPhones
  EXPORT delta_phones_rpt_transaction := RECORD
    STRING16 transaction_id;
    STRING32 transaction_date;
    STRING60 user_id;
    STRING8 product_code;
    STRING16 company_Id;
    STRING8 source_code;
    STRING60 reference_code;
    STRING32 phonefinder_type;
    //SearchTerms
    STRING32 submitted_lexid;
    STRING15 submitted_phonenumber;
    STRING20 submitted_firstname;
    STRING20 submitted_lastname;
    STRING20 submitted_middlename;
    STRING128 submitted_streetaddress1;
    STRING64 submitted_city;
    STRING16 submitted_state;
    STRING10 submitted_zip;
    //Primary Phone details
    STRING30 data_source;
    STRING30 royalty_used;
    STRING30 carrier;
    STRING15 phonenumber;
    STRING16 risk_indicator;
    STRING32 phone_type;
    STRING32 phone_status;
    INTEGER identity_count;
    INTEGER  ported_count;
    STRING32 last_ported_date;
    INTEGER  otp_count;
    STRING32 last_otp_date;
    INTEGER  spoof_count;
    STRING32 last_spoof_date;
    STRING32 phone_forwarded;
    UNSIGNED1 phone_verified;
    STRING32 verification_type;
    STRING1 phone_star_rating;
  END;

  EXPORT	delta_phones_rpt_otherphones:= RECORD
    STRING16 transaction_id;
    INTEGER sequence_number;
    INTEGER phone_id;
    STRING15 phonenumber;
    STRING16 risk_indicator;
    STRING32 phone_type;
    STRING30 carrier;
    STRING32 phone_status;
    INTEGER identity_count;
    STRING64 listing_name;
    STRING16 porting_code;
    STRING32 phone_forwarded;
    INTEGER1	verified_carrier;
    STRING1 phone_star_rating;
  END;

  EXPORT	delta_phones_rpt_identities:= RECORD
    STRING16 transaction_id;
    INTEGER  sequence_number;
    STRING32 lexid;
    STRING128 full_name;
    STRING128 full_address;
    STRING64 city;
    STRING16 state;
    STRING10 zip;
    INTEGER1	 verified_carrier;
    END;

  EXPORT delta_phones_rpt_riskindicators:= RECORD
    STRING16 transaction_id;
    INTEGER phone_id;
    INTEGER sequence_number;
    STRING256 risk_indicator_text;
    INTEGER risk_indicator_id;
    STRING16 risk_indicator_level;
    STRING32 risk_indicator_category;
    END;

  EXPORT delta_phones_rpt_Usage_RECORDs := RECORD
    DATASET(delta_phones_rpt_transaction) delta_phones_rpt_transaction {xpath('delta__phonefinder_delta__phones_rpt__transaction/Row')};
    DATASET(delta_phones_rpt_otherphones) delta_phones_rpt_otherphones {xpath('delta__phonefinder_delta__phones_rpt__otherphones/Row')};
    DATASET(delta_phones_rpt_identities) delta_phones_rpt_identities {xpath('delta__phonefinder_delta__phones_rpt__identities/Row')};
    DATASET(delta_phones_rpt_riskindicators) delta_phones_rpt_riskindicators {xpath('delta__phonefinder_delta__phones_rpt__riskindicators/Row')};
    DATASET(delta_phones_rpt_sources) delta_phones_rpt_sources {xpath('delta__phonefinder_delta__phones_rpt__sources/Row')};
  END;

END;
