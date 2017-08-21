EXPORT layouts_BWH := MODULE

  shared bwh_id := RECORD
    string25 account;
  end;

  // BWR-client input part (their request sent to LN; we need it for identification)
  shared bwh_in := record
    string1  request_code; //Monitoring Action: A=Add; U=Update; D=Delete; X=Skip
    string10 products; // String of indicators: B=Bankruptcy, D=Deceased, A=Address, P=Phone
    string25 account;
    string4 score; // to be used to determine monitoring frequency

    string15 first_name;
    string10 middle_name;
    string20 last_name;
    string1  suffix;
    string9  ssn;         // SSN/Tax ID (Must be zero padded, no hyphens allowed)
    string32 address;
    string25 city;
    string2  state;
    string10 Zip;        // May contain ZIP+4
    string10 Phone;      // Must contain area code, no punctuation

    string1 DPPA;
    string1 GLBA;

    string32 Address_2;
    string25 City_2;
    string2  State_2;
    string10 Zip_2;

    string32 Address_3;
    string25 City_3;
    string2  State_3;
    string10 Zip_3;

    string32 Address_4;
    string25 City_4;
    string2  State_4;
    string10 Zip_4;

    string32 Address_5;
    string25 City_5;
    string2  State_5;
    string10 Zip_5;

    string32 Address_6;
    string25 City_6;
    string2  State_6;
    string10 Zip_6;

    string10 Phone_2;
    string10 Phone_3;
    string10 Phone_4;
    string10 Phone_5;
    string10 Phone_6;
    string10 Phone_7;
    string10 Phone_8;
    string10 Phone_9;
    string10 Phone_10;
  end;

  // batch request input layout (most complete)
  export batch := bwh_in;

  // "raw" monitor: used for linking back to the originals the results of monitoring;
  // same layout is used to archive all batch requests (monitor state can be restored from this file, if needed)
  export batch_raw := RECORD
    layouts.wid;
    bwh_in;
  end;


  //-------------------------------------------------------------------------------
  // Batch output sent to BWR (LN calculated copy; serves as an input for THOR).
  //-------------------------------------------------------------------------------
  export batch_thor_input := record
    string1  request_code; //Monitoring Action: A=Add; U=Update; D=Delete; X=Skip
    string25 account;
    string10 products; // String of indicators: B=Bankruptcy, D=Deceased, A=Address, P=Phone

    // string12 Case_Number;
    // string2 Chapter;
    string8 File_Date;
    string8 Status_Date;
    string2 Disposition_Code;
    string1 suffix;
    string32 address;
    string10 Zip;
    string9 ssn;
    string20 City_Filed;
    string2 State_Filed;
    string25 County;
    string15 first_name;
    string10 middle_name;
    string25 last_name;
    string45 Business;
    string45 Business_1;
    string45 Business_2;
    string45 Business_3;
    string30 Debtors_City;
    string2 Debtors_State;
    string1 ECOA;
    string50 Law_Firm;
    string35 Attorney_Name;
    string32 Attorney_Address;
    string25 Attorney_City;
    string2 Attorney_State;
    string10 Attorney_Zip;
    string10 Attorney_Phone;
    string8 f341_Date;
    string5 f341_Time;
    string50 f341_Location;
    string40  Trustee;
    string32 Trustee_Address;
    string25 Trustee_City;
    string2 Trustee_State;
    string10 Trustee_Zip;
    string10 Trustee_Phone;
    string16 Judges_Initials;
    string1 Funds;
    string8 Discharge_Complaint_Bar_Date;
    string10 Match_Code;
    string30 Court_District;
    string35 Court_Address_1;
    string35 Court_Address_2;
    string20 Court_Mailing_City;
    string5 Court_ip;
    string10 Court_Phone;
    string10 Debtor_Phone;
    string1 Voluntary_Involuntary_Dismissal;
    string8 Proof_of_Claim_Bar_Date;
 
    string8 Reinstated_Case_Date;
    string8 Closed_Case_Date;
    string8 Date_of_Birth;
    string8 Date_of_Death;

    string50 New_Address_1;
    string28 New_City_1;
    string2  New_State_1;
    string10 New_Zip_1;

    string50 New_Address_2;
    string28 New_City_2;
    string2  New_State_2;
    string10 New_Zip_2;

    string50 New_Address_3;
    string28 New_City_3;
    string2  New_State_3;
    string10 New_Zip_3;

    string50 New_Address_4;
    string28 New_City_4;
    string2  New_State_4;
    string10 New_Zip_4;

    string50 New_Address_5;
    string28 New_City_5;
    string2  New_State_5;
    string10 New_Zip_5;

    string50 New_Address_6;
    string28 New_City_6;
    string2  New_State_6;
    string10 New_Zip_6;

    string10 New_Phone_1;
    string65 New_Listing_Name_1;
    string2  New_Phone_Type_1;
  
    string10 New_Phone_2;
    string65 New_Listing_Name_2;
    string2  New_Phone_Type_2;

    string10 New_Phone_3;
    string65 New_Listing_Name_3;
    string2  New_Phone_Type_3;

    string10 New_Phone_4;
    string65 New_Listing_Name_4;
    string2  New_Phone_Type_4;

    string10 New_Phone_5;
    string65 New_Listing_Name_5;
    string2  New_Phone_Type_5;

    string10 New_Phone_6;
    string65 New_Listing_Name_6;
    string2  New_Phone_Type_6;

    string10 New_Phone_7;
    string65 New_Listing_Name_7;
    string2  New_Phone_Type_7;

    string10 New_Phone_8;
    string65 New_Listing_Name_8;
    string2  New_Phone_Type_8;

    string10 New_Phone_9;
    string65 New_Listing_Name_9;
    string2  New_Phone_Type_9;

    string10 New_Phone_10;
    string65 New_Listing_Name_10;
    string2  New_Phone_Type_10;
  end;

  export verification := RECORD (batch_raw)
    layouts.error_report;
  end;

END;
