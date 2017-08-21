// Layouts common for Monitor processing
IMPORT Standard, doxie;

EXPORT layouts := MODULE
  ///////////////////////////////////////////////////////////////////////////////
  // ========================================================================= //
  // ========================= THOR INTERNAL LAYOUTS ========================= //
  // ========================================================================= //
  //////////////////////////////////////////////////////////////////////////// //

  // LN unique ID (for internal usage)
  export id := RECORD
    string10 customer_id;
    string30 record_id;
  end;

  // extended ID; to enforce using WUID in all internal layouts
  export wid := RECORD
    string16 wuid;
    id;
  end;

  // -------------------------------------------------------------------------
  // history (address, etc.): used for storing data customer already has 
  // (customer's own, obtained from real-time batch, THOR Monitoring system, etc.)
  // -------------------------------------------------------------------------

  // ADDRESS
  export address_slim := RECORD
    Standard.L_Address.base AND NOT [fips_state, fips_county];
    string4  err_stat;
  end;

  export address_history := record
    wid;
    address_slim;
    string6 addr_dt_last_seen;
    string6 addr_dt_first_seen; 
    string2 src;
    unsigned1 best_address_count;
    standard.Name_Slim; // do we need name?
    string8 addr_version_number;
  end;

  export address_history_ext := RECORD (address_history)
    unsigned1 seq;         // "importance" of this address for this account
    boolean IsBatchOutput; // specifies if this address comes from batch portion
  end;

  // PHONE
  export phone_history := record
    wid;
    string10  phone10;
    string8   phone_dt_last_seen;
    string8   phone_dt_first_seen;
    standard.Name_Slim;
    string2   phone_type;
    string1   dual_name_flag;
    string3   listing_type;
    string1   publish_code;  
    string30  carrier_name;
    string25  carrier_city;
    string2   carrier_state;
    string8   phone_version_number; 
    unsigned1 best_phone_number;
  end;
  export phone_history_ext := RECORD (phone_history)
    unsigned1 seq;         // "importance" of this phone for this account (not used so far)
    boolean IsBatchOutput; // specifies if this address comes from batch portion
  end;


  // PROPERTY
  export property_history := record
    wid;
    string45 parcel_number;
    string62 name_owner_1;
    string62 name_owner_2;
    address_slim;
  end;
  export property_history_ext := RECORD (property_history)
    unsigned1 seq;         // "importance" of this property for this account (not used so far)
    boolean IsBatchOutput; // left here for uniformity sake only; should be TRUE for properties
  end;

  // PEOPLE AT WORK
  export paw_history := record
    wid;
    standard.Name_Slim;
    string9  ssn;
    string35 title;
    string120 company;
    string35 department;
    string9  fein;
    address_slim; //pawk_address, pawk_city, pawk_state, pawk_zip, pawk_zip4
    string10 phone10;
    string3  verified;
    string60 email;
    // string6 addr_dt_last_seen; //?pawk_last-seen -- address or what?
    // string6 addr_dt_first_seen; //? pawk_first-seen 
    string1 confidence_level;
  end;

  export paw_history_ext := RECORD (paw_history)
    unsigned1 seq;         // "importance" of this property for this account (not used so far)
    boolean IsBatchOutput; // left here for uniformity sake only; should be TRUE for properties
  end;


  //////////////////////////////////////////////////////////////////////////////
  // ======================================================================== //
  // ========================= MAIN MONITOR LAYOUTS ========================= //
  // ======================================================================== //
  /////////////////////////////////////////////////////////////////////////// //
  // "old style" settings
  export m_settings_flat := RECORD
    unsigned1 best_address_number; // number of "new found" address(es) to return (client's specific)
    unsigned1 best_phone_number;   // number of "new found" phone(s)
    boolean   phone_level_ta;
    boolean   phone_level_tb;
    boolean   phone_level_td;
    boolean   phone_level_tg;
    boolean   phone_level_other1; // not used, reserved for future needs
    boolean   phone_level_other2; // ...
    boolean   phone_level_other3; // ...

    string1   frequency_type; //so far only day, week, month
    unsigned2 frequency_time;
    string1   delay_type;
    unsigned2 delay_time;
  end;

  // monitoring settings:
  export m_settings := RECORD
    unsigned2 subject;
    unsigned2 sub_type;
    string1   delay_type;
    unsigned2 delay_time;
    string1   frequency_type; //so far only day, week, month
    unsigned2 frequency_time;
    unsigned1 best_number;    // maximum number of best records to return
    boolean   first_run;      // in case of delay != 0, defines whether to run first time (not used)
    string2   misc;           // reserved
  end;

  // Main
  export monitor := RECORD
    wid;
    standard.Name_Slim;
    string9   ssn;
    string8   dob;
    string10  phoneno;
    address_slim; 
    unsigned1 glb_purpose;
    unsigned1 dppa_purpose;
    boolean   market_restriction;
    string8   addr_version_number;
    string8   phone_version_number;
    string1   transaction_type; //change to boolean is_new_record;

    // m_settings_flat;
    dataset (m_settings) matrix {MAXCOUNT (Constants.MAX_SUBJECTS)};
  end;

  export base_did := RECORD (monitor)
    DATASET (doxie.layout_references) dids {MAXCOUNT (5)};
  end;

  // Common for all clients batch report format
  export error_report := RECORD
    unsigned6 seq; // sequencing of original (input) records (in case we have few revords per ID)
    boolean new_id   := true;  // TRUE if no such ID exists in Monitor DB
    boolean executed := false; // atmost one request from within given ID is to be actually processed (usually last)
    unsigned1 err    := 0;     // see Constants
    string64 status  := '';    // description
  end;

  export batch_report := RECORD
    wid;  // internal LN monitoring id
    string1  request_code;
    // 2 custom-specific ID fields (originally provided to accomodate NCO needs)
    string24 account_identifier := '';
    string65 transaction_id := '';
    error_report;
  end;



  ///////////////////////////////////////////////////////////////////////////////
  // ========================================================================= //
  // ===================== THOR-BATCH STANDARD INTERFACE ===================== //
  // ========================================================================= //
  //////////////////////////////////////////////////////////////////////////// //
  shared batch_address := record    //len=97
    string60 address;
    string25 city;
    string2  state;
    string10 zip;
  end;

  shared customer_address := record    //len=117
    string60 line_1;
    string20 line_2;
    string25 city;
    string2  state;
    string10 zip;
  end;

  // Note: record_id is needed for linking separate results files together.
  export unique_id := RECORD, MAXLENGTH (42) // 4 additional bytes (length) will be stored for every string
    string UniqueID_1;
    string UniqueID_2;
    string UniqueID_3;
  end;


  // =========================================================================
  // -------------------------- THOR INPUT LAYOUTS ---------------------------
  // =========================================================================
  export batch_in_address := RECORD
    unique_id rec;
    standard.Name_Slim; //65
    batch_address; //97
    string8  date_first; //First Reported Date
    string8  date_last;  //Last Reported Date
  end;

  export batch_in_phone := RECORD
    unique_id rec;
    string10 phone;
    string60 listing_name; // Listing Name
    string8  date_first; //First Reported Date
    string8  date_last;  //Last Reported Date
    string2  phone_type; // TODO: or string3? (bus + res + gov)
  end;

  export batch_in_property := RECORD
    unique_id rec;
    string45 parcel_number;
    string62 name_owner_1;
    string62 name_owner_2;
    string60 address; //70?
    string25 prop_city;
    string2  prop_state;
    string10 prop_zipcode;
    string11 total_value;
    string8  sale_date;
    string11 sale_price;
    string60 name_seller;
    string11 mortgage_amount;
    string11 assessed_value;
    string11 total_market_value;
    string250 legal_description; //250?
  end;

  export batch_in_paw := RECORD
    unique_id rec;
    standard.Name_Slim;
    string9  ssn;
    string35 title;
    string120 company;
    string35 department;
    string9  fein;
    string60 address; //70?
    string25 city;
    string2  state;
    string5  zip5;
    string4  zip4;
    string10 phone;
    string3  verified;
    string60 email;
    string8  date_first;
    string8  date_last;
    string1  confidence_level;
  end;

  // this represents "customer" input:
  export batch_in_customer := RECORD // 1789 + 2 (?? misterious adjustment to the unique_id)
    string1 request_code;
    string20 request_type;
    unique_id rec;
    unsigned2  Score; // defines monitor settings
    standard.Name_Slim;
    string60 full_name;
    string9 ssn;
    string8 dob;
    customer_address addr_1; // Address_1_1, Address_1_2, City_1, State_1, Zip_1
    customer_address addr_2;
    customer_address addr_3;
    customer_address addr_4;
    customer_address addr_5;
    customer_address addr_6;
    customer_address addr_7;
    customer_address addr_8;
    customer_address addr_9;
    customer_address addr_10;
    customer_address addr_11;
    customer_address addr_12;
    string10 phone_1;
    string10 Phone_2;
    string10 Phone_3;
    string10 Phone_4;
    string10 Phone_5;
    string10 Phone_6;
    string10 Phone_7;
    string10 Phone_8;
    string10 Phone_9;
    string10 Phone_10;
    string10 Phone_11;
    string10 Phone_12;
    string10 Phone_13;
    string10 Phone_14;
    string10 Phone_15;
    string10 Phone_16;
    string10 Phone_17;
    string10 Phone_18;
    string10 Phone_19;
    string10 Phone_20;
  end;

  export batch_raw := RECORD
    wid;
    batch_in_customer;
  end;

  export verification := RECORD (batch_raw)
    error_report;
  end;


  // Layout for Normalization by address. It plays a particular role, since Monitor accepts up to 3 customer 
  // input addresses for identification purposes. Address history specific fields are appended.
  // Used for address short-term history and for updating monitor DB (identification sake).
  export address_norm := RECORD (monitor)
    unsigned1 seq;                      // "importance" of this address for this account
    boolean IsBatchOutput := false;     // specifies whether address comes from LN batch
    string6 addr_dt_last_seen := '';
    string6 addr_dt_first_seen := '';
    string2 src;
    unsigned1 best_address_count;
    // need this when dealing with multiple records per record_id
    verification.executed;
    verification.err;
  end;


  // =========================================================================
  // -------------------------- THOR OUTPUT LAYOUTS --------------------------
  // =========================================================================
  export out_address := RECORD, MAXLENGTH (288 + 90) // TODO: find why it fails without adjustment
    id.record_id;           //30 
    unique_id;              //max=30
    standard.Name_Slim;     //65
    batch_address;          //97
    string50 address_type;
    string8  date_first;
    string8  date_last;
    // ... and that's what more we could have from internal results:
	  // string2   src;
	  // unsigned1 best_phone_number;
	  // boolean   phone_level_ta;
	  // boolean   phone_level_tb;
	  // boolean   phone_level_td;
	  // boolean   phone_level_tg;
	  // unsigned6 did;
	  // unsigned1 best_address_count;
	  // unsigned1 name_score := 0;
	  // unsigned1 ssn_score := 0;
  end;

  export out_phone := RECORD, MAXLENGTH (149 + 90)
    id.record_id;
    unique_id;
    string60 listing_name; // Listing Name
    standard.Name_Slim;     //65
    string10 phone;
    string1  switch_type;
    string2  phone_type; // TODO: or string3? (bus + res + gov)
    string8  date_first;
    string8  date_last;
    // ... and that's what more we could have from internal results:
	  // standard.Addr_Slim;
    // string1   dual_name_flag;
    // string3   listing_type;
    // string1   publish_code;  
    // string30  carrier_name;
    // string25  carrier_city;
    // string2   carrier_state;
	  // unsigned1 best_phone_number;
	  // unsigned1 best_phone_count;
  end;

  export out_property := RECORD, MAXLENGTH (695 + 90) //so far
    id.record_id;
    unique_id;
    string45 parcel_number;
    string60 name_owner_1;
    string60 name_owner_2;
    batch_address;
    string11 total_value;
    string8  sale_date;
    string11 sale_price;
    string60 name_seller;
    // standard.Name_Slim seller;
    string11 mortgage_amount;
    string11 assessed_value;
    string11 total_market_value;
    string250 legal_description; //250?
  end;

  export out_paw := RECORD, MAXLENGTH (600 + 90)
    id.record_id;
    unique_id;
    standard.Name_Slim;
    string9  ssn; //? are we sure about exposing ssn?
    string35 title;
    string120 company;
    string35 department;
    string9  fein;
    batch_address;
    string4 zip4;
    string10 phone10;
    string1  verified;
    string60 email;
    string8 date_first; //First Reported Date
    string8 date_last;  //Last Reported Date
    string3 confidence_level;
  end;

END;
