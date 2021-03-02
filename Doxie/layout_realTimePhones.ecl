IMPORT Doxie_raw, Gateway, Risk_Indicators, Royalty;
  EXPORT layout_realTimePhones := MODULE
  EXPORT rtp_in_layout := RECORD
    UNSIGNED1 DPPAPurpose;
    UNSIGNED1 GLBPurpose;
    STRING11  SSN;
    STRING30  LastName;
    BOOLEAN   GetSSNBest; 
    BOOLEAN   SuppressBlankNameAddress;
    BOOLEAN   IncludeFullPhonesPlus;
    BOOLEAN   IncludeLastResort;
    BOOLEAN   IncludeRealTimePhones;
    BOOLEAN   UseQSentV2;
    BOOLEAN   IncludeHRI;
    STRING    DataPermissionMask;
    STRING    DataRestrictionMask; 
    STRING32  ApplicationType;
    STRING    IndustryClass;
    STRING    SSNMask;
    STRING    DOBMask;
    DATASET(Gateway.Layouts.Config) Gateways := DATASET([], Gateway.Layouts.Config);
  END;

  EXPORT layout_out1 := Royalty.Layouts.Royalty;
  EXPORT layout_out2  := Doxie_Raw.PhonesPlus_Layouts.preFinalLayout;
  
  RecsAvailableRec := RECORD
    UNSIGNED RecordsAvailable {xpath('RecordsAvailable')};
  END;

  EXPORT finalRec := RECORD
    DATASET(RecsAvailableRec) RecAvail {xpath('Dataset[@name=\'RecordsAvailable\']/Row')};
    DATASET(layout_out1) RoyaltySet {xpath('Dataset[@name=\'RoyaltySet\']/Row')};
    DATASET(layout_out2) Results {xpath('Dataset[@name=\'Results\']/Row')};
  END;
		
  // rtp_out_layout is a subset of Doxie_Raw.PhonesPlus_Layouts.preFinalLayout
  EXPORT rtp_out_layout :=  RECORD
    doxie_raw.PhonesPlus_Layouts.finalLayout.did;
    doxie_raw.PhonesPlus_Layouts.finalLayout.SSN;
    doxie_raw.PhonesPlus_Layouts.finalLayout.listed_name;
    doxie_raw.PhonesPlus_Layouts.finalLayout.phone;
    doxie_raw.PhonesPlus_Layouts.finalLayout.title;
    doxie_raw.PhonesPlus_Layouts.finalLayout.fname;
    doxie_raw.PhonesPlus_Layouts.finalLayout.mname;
    doxie_raw.PhonesPlus_Layouts.finalLayout.lname;
    doxie_raw.PhonesPlus_Layouts.finalLayout.name_suffix;	
    doxie_raw.PhonesPlus_Layouts.finalLayout.prim_range;
    doxie_raw.PhonesPlus_Layouts.finalLayout.predir;
    doxie_raw.PhonesPlus_Layouts.finalLayout.prim_name;
    doxie_raw.PhonesPlus_Layouts.finalLayout.suffix;
    doxie_raw.PhonesPlus_Layouts.finalLayout.postdir;
    doxie_raw.PhonesPlus_Layouts.finalLayout.unit_desig;
    doxie_raw.PhonesPlus_Layouts.finalLayout.sec_range;
    doxie_raw.PhonesPlus_Layouts.finalLayout.city_name;
    doxie_raw.PhonesPlus_Layouts.finalLayout.st;
    doxie_raw.PhonesPlus_Layouts.finalLayout.zip;
    doxie_raw.PhonesPlus_Layouts.finalLayout.zip4;
    doxie_raw.PhonesPlus_Layouts.finalLayout.listing_type_bus;
    doxie_raw.PhonesPlus_Layouts.finalLayout.listing_type_res;
    doxie_raw.PhonesPlus_Layouts.finalLayout.listing_type_gov;	
    doxie_raw.PhonesPlus_Layouts.finalLayout.Carrier_Name;  //Original Carrier Name?  e.g. Sprint
    doxie_raw.PhonesPlus_Layouts.finalLayout.phone_region_city; // Telcordia city
    doxie_raw.PhonesPlus_Layouts.finalLayout.phone_region_st; // telcordia state
    doxie_raw.PhonesPlus_Layouts.preFinalLayout.timezone;
    doxie_raw.PhonesPlus_Layouts.preFinalLayout.new_type; //Possible Wireless, etc.
    doxie_raw.PhonesPlus_Layouts.preFinalLayout.typeflag;
    doxie_raw.PhonesPlus_Layouts.preFinalLayout.dt_first_seen;
    doxie_raw.PhonesPlus_Layouts.preFinalLayout.dt_last_seen;
    DATASET(Risk_Indicators.Layout_Desc) hri_phone {MAXCOUNT(10)};
  END;	

  EXPORT rtp_out_layout_final :=  RECORD
    rtp_out_layout - [typeflag];
  END;

  EXPORT rtp_out_layout_royalty :=  RECORD
    DATASET(layout_out1) RoyaltySet;
  END;
END;