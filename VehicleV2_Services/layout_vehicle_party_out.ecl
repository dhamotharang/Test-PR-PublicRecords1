IMPORT VehicleV2;

EXPORT layout_vehicle_party_out := MODULE

  EXPORT layout_standard_name := RECORD
    STRING20 fname;
    STRING20 mname;
    STRING20 lname;
    STRING5 name_suffix;
  END;
  
  EXPORT layout_standard_address := RECORD
    STRING10 prim_range;
    STRING2 predir;
    STRING28 prim_name;
    STRING4 addr_suffix;
    STRING2 postdir;
    STRING10 unit_desig;
    STRING8 sec_range;
    STRING25 v_city_name;
    STRING2 st;
    STRING5 zip5;
    STRING4 zip4;
  END;
  
  EXPORT layout_vehicle_party_registrant := RECORD
    UNSIGNED2 party_penalty;
    VehicleV2.Layout_Base_Party.Sequence_Key;
    VehicleV2.Layout_Base_Party.Latest_Vehicle_Flag;
    STRING30 history_desc;
    layout_standard_name;
    layout_standard_address;
    STRING18 county_name;
    VehicleV2.Layout_Base_Party.orig_name;
    VehicleV2.Layout_Base_Party.Orig_DL_Number;
    VehicleV2.Layout_Base_Party.Orig_DOB;
    VehicleV2.Layout_Base_Party.Orig_Sex;
    STRING10 orig_sex_desc;
    VehicleV2.Layout_Base_Party.Orig_SSN;
    VehicleV2.Layout_Base_Party.Orig_Fein;
    VehicleV2.Layout_Base_Party.Append_Clean_CName;
    VehicleV2.Layout_Base_Party.Append_DID;
    VehicleV2.Layout_Base_Party.Append_BDID;
    VehicleV2.Layout_Base_Party.Append_SSN;
    VehicleV2.Layout_Base_Party.Append_Fein;
    VehicleV2.Layout_Base_Party.Reg_First_Date;
    VehicleV2.Layout_Base_Party.Reg_Earliest_Effective_Date;
    VehicleV2.Layout_Base_Party.Reg_Latest_Effective_Date;
    VehicleV2.Layout_Base_Party.Reg_Latest_Expiration_Date;
    VehicleV2.Layout_Base_Party.Reg_Decal_Number;
    VehicleV2.Layout_Base_Party.Reg_Decal_Year;
    VehicleV2.Layout_Base_Party.Reg_Status_Desc;
    vehiclev2_services.Layout_Report_Plate;
    VehicleV2.Layout_Base_Party.Date_Vendor_first_Reported;
    VehicleV2.Layout_Base_Party.Date_Vendor_Last_Reported;
  END;

  EXPORT layout_vehicle_party_owner := RECORD
    UNSIGNED2 party_penalty;
    VehicleV2.Layout_Base_Party.Sequence_Key;
    VehicleV2.Layout_Base_Party.Latest_Vehicle_Flag;
    STRING30 history_desc;
    layout_standard_name;
    layout_standard_address;
    STRING18 county_name;
    VehicleV2.Layout_Base_Party.orig_name;
    VehicleV2.Layout_Base_Party.Orig_DL_Number;
    VehicleV2.Layout_Base_Party.Orig_DOB;
    VehicleV2.Layout_Base_Party.Orig_Sex;
    STRING10 orig_sex_desc;
    VehicleV2.Layout_Base_Party.Orig_SSN;
    VehicleV2.Layout_Base_Party.Orig_Fein;
    VehicleV2.Layout_Base_Party.Append_Clean_CName;
    VehicleV2.Layout_Base_Party.Append_DID;
    VehicleV2.Layout_Base_Party.Append_BDID;
    VehicleV2.Layout_Base_Party.Append_SSN;
    VehicleV2.Layout_Base_Party.Append_Fein;
    vehiclev2_services.Layout_Report_Title;
    VehicleV2.Layout_Base_Party.Date_Vendor_first_Reported;
    VehicleV2.Layout_Base_Party.Date_Vendor_Last_Reported;
    VehicleV2.Layout_Base_Party.SRC_FIRST_DATE;
    VehicleV2.Layout_Base_Party.SRC_LAST_DATE;
  END;
  
  EXPORT layout_vehicle_party_lienholder := RECORD
    UNSIGNED2 party_penalty;
    VehicleV2.Layout_Base_Party.Orig_Party_Type;
    VehicleV2.Layout_Base_Party.Sequence_Key;
    VehicleV2.Layout_Base_Party.Latest_Vehicle_Flag;
    STRING30 history_desc;
    layout_standard_name;
    layout_standard_address;
    STRING18 county_name;
    VehicleV2.Layout_Base_Party.orig_name;
    VehicleV2.Layout_Base_Party.Orig_DL_Number;
    VehicleV2.Layout_Base_Party.Orig_DOB;
    VehicleV2.Layout_Base_Party.Orig_Sex;
    STRING10 orig_sex_desc;
    VehicleV2.Layout_Base_Party.Orig_SSN;
    VehicleV2.Layout_Base_Party.Orig_Fein;
    VehicleV2.Layout_Base_Party.Orig_Lien_Date;
    VehicleV2.Layout_Base_Party.Append_Clean_CName;
    VehicleV2.Layout_Base_Party.Append_DID;
    VehicleV2.Layout_Base_Party.Append_BDID;
    VehicleV2.Layout_Base_Party.Append_SSN;
    VehicleV2.Layout_Base_Party.Append_Fein;
    VehicleV2.Layout_Base_Party.Date_Vendor_first_Reported;
    VehicleV2.Layout_Base_Party.Date_Vendor_Last_Reported;
  END;

  EXPORT layout_vehicle_party_lessor := RECORD
    UNSIGNED2 party_penalty;
    VehicleV2.Layout_Base_Party.Orig_Party_Type;
    VehicleV2.Layout_Base_Party.Sequence_Key;
    VehicleV2.Layout_Base_Party.Latest_Vehicle_Flag;
    STRING30 history_desc;
    layout_standard_name;
    layout_standard_address;
    STRING18 county_name;
    VehicleV2.Layout_Base_Party.orig_name;
    VehicleV2.Layout_Base_Party.Orig_DL_Number;
    VehicleV2.Layout_Base_Party.Orig_DOB;
    VehicleV2.Layout_Base_Party.Orig_Sex;
    STRING10 orig_sex_desc;
    VehicleV2.Layout_Base_Party.Orig_SSN;
    VehicleV2.Layout_Base_Party.Orig_Fein;
    VehicleV2.Layout_Base_Party.Append_Clean_CName;
    VehicleV2.Layout_Base_Party.Append_DID;
    VehicleV2.Layout_Base_Party.Append_BDID;
    VehicleV2.Layout_Base_Party.Append_SSN;
    VehicleV2.Layout_Base_Party.Append_Fein;
    VehicleV2.Layout_Base_Party.Date_Vendor_first_Reported;
    VehicleV2.Layout_Base_Party.Date_Vendor_Last_Reported;
  END;
  
  EXPORT layout_vehicle_party_lessee := RECORD
    layout_vehicle_party_lessor;
    VehicleV2.Layout_Base_Party.Reg_First_Date;
    VehicleV2.Layout_Base_Party.Reg_Earliest_Effective_Date;
    VehicleV2.Layout_Base_Party.Reg_Latest_Effective_Date;
    VehicleV2.Layout_Base_Party.Reg_Latest_Expiration_Date;
    VehicleV2.Layout_Base_Party.Reg_Decal_Number;
    VehicleV2.Layout_Base_Party.Reg_Decal_Year;
    VehicleV2.Layout_Base_Party.Reg_Status_Desc;
    vehiclev2_services.Layout_Report_Plate;
    END;
END;
