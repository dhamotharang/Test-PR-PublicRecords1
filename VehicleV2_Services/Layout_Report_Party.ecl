IMPORT VehicleV2;

EXPORT Layout_Report_Party := RECORD
  UNSIGNED2 party_penalty; // for search results
  VehicleV2.Layout_Base_Party.Sequence_Key;
  VehicleV2.Layout_Base_Party.Latest_Vehicle_Flag; // for search results
  VehicleV2.Layout_Base_Party.History; // for search results
  STRING30 history_desc;
  VehicleV2.Layout_Base_Party.Orig_Party_Type; // for search results
  VehicleV2.Layout_Base_Party.Orig_Conjunction; // for search results
  VehicleV2.Layout_Base_Party.Append_Clean_Name; // customer name
  VehicleV2.Layout_Base_Party.Orig_Name; // customer name
  VehicleV2.Layout_Base_Party.Orig_DL_Number; // driver license number
  VehicleV2.Layout_Base_Party.Orig_DOB; // dob
  VehicleV2.Layout_Base_Party.Orig_Sex; // sex
  STRING10 orig_sex_desc;
  VehicleV2.Layout_Base_Party.Append_Clean_Address; // street address
  STRING18 county_name; //decoded county name
  VehicleV2.Layout_Base_Party.Orig_Address; // street address
  VehicleV2.Layout_Base_Party.Orig_City; // city
  VehicleV2.Layout_Base_Party.Orig_State; // state
  VehicleV2.Layout_Base_Party.Orig_Zip; // zip
  
  VehicleV2.Layout_Base_Party.Orig_SSN; // ssn (mapping append)
  VehicleV2.Layout_Base_Party.Append_Clean_CName; // company name (mapping append)
  
  // for search results
  STRING12 Append_DID;
  VehicleV2.Layout_Base_Party.Append_DID_Score;
  STRING12 Append_BDID;
  STRING3 age;
  VehicleV2.Layout_Base_Party.Append_BDID_Score;
  VehicleV2.Layout_Base_Party.Append_SSN;
  VehicleV2.Layout_Base_Party.Date_Vendor_first_Reported;
  VehicleV2.Layout_Base_Party.Date_Vendor_Last_Reported;
  
  // for registrations
  VehicleV2.Layout_Base_Party.Reg_First_Date; // first registration date
  VehicleV2.Layout_Base_Party.Reg_Earliest_Effective_Date; // registration effective date
  VehicleV2.Layout_Base_Party.Reg_Latest_Effective_Date; // registration effective date
  VehicleV2.Layout_Base_Party.Reg_Latest_Expiration_Date; // registration expiration date
  VehicleV2.Layout_Base_Party.Reg_Decal_Number; // decal number
  VehicleV2.Layout_Base_Party.Reg_Decal_Year; // decal year
  VehicleV2.Layout_Base_Party.Reg_Status_Code; // registration status code
  VehicleV2.Layout_Base_Party.Reg_Status_Desc; // registration status description
  
  vehiclev2_services.Layout_Report_Plate;
  vehiclev2_services.Layout_Report_Title;

END;
