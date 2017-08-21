import standard;

EXPORT layouts_PRA := MODULE

  export pra_id := RECORD
    string24 account;
    string2  rel_pos;
  end;

  // PRA-client input part (their request sent to LN; we need it for identification)
  export pra_in := record
    pra_id;
    string20 first_name;
    string20 last_name;
    string9  SSN;
    string60 address;
    string30 city;
    string2  state;
    string5  zip;
    string12 home_phone;
    string12 work_phone;
    string12 other_phone;
    string12 Phone_4;
    string12 phone_5;
    string12 phone_6;
    string12 phone_7;
    string12 phone_8;
  end;

  // batch request input layout (most complete)
  export batch := pra_in;

  // "raw" monitor: used for linking back to the originals the results of monitoring;
  // same layout is used to archive all batch requests (monitor state can be restored from this file, if needed)
  export batch_raw := RECORD
    layouts.wid;
    string1 request_code; //1
    pra_in;
  end;


  //-------------------------------------------------------------------------------
  // Batch output format: sent to PRA (serves as an input for THOR).
  //-------------------------------------------------------------------------------
  // LN calculated addresses (copy of what was sent to the client in LN reply)
  export batch_address := record
    pra_id;
    // all "best" values
    standard.Name_Slim;
    string60 address; //50?
    string25 city;
    string2  state;
    string5  zip; //10?
    string8  date_first;
    string8  date_last;
    string50 address_type;
  end;

  // LN calculated phones (copy of what was sent to the client in LN reply)
  export batch_phone := record
    pra_id;
    standard.Name_Slim;
    string10 phone;
    string30 name_dual; //?
    string2  subj_phone_type;
    string8  date_first;
    string8  date_last;
  end;

  // LN calculated property (copy of what was sent to the client in LN reply)
  export batch_property := record
    pra_id;
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

  // LN calculated people at work (copy of what was sent to the client in LN reply)
  export batch_paw := record
    pra_id;
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


  export verification := RECORD (batch_raw)
    layouts.error_report;
  end;

END;