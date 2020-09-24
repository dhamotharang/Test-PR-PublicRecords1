﻿IMPORT Progressive_Phone;

EXPORT layout_progressive_phone_common := RECORD
  BOOLEAN match_name;
  BOOLEAN match_street_address;
  BOOLEAN match_city;
  BOOLEAN match_state;
  BOOLEAN match_zip;
  BOOLEAN match_ssn;
  BOOLEAN match_did;
  BOOLEAN matches;
  Progressive_Phone.Layout_Progressive_Batch_Out_With_DID;
  DATASET({STRING3 src}) Phn_src_all;
  STRING1   Meta_Line := '';
  STRING1   Meta_Serv := '';
  STRING60  Meta_Carrier_Name := '';
  STRING8   Meta_Most_Recent_OTP_Dt := '';
  UNSIGNED2 Meta_Count_OTP_30 := 0;
  UNSIGNED2 Meta_Count_OTP_60 := 0;
  STRING32  Meta_Phone_Status := '';
  STRING17  Meta_ServLine_Type := '';
  STRING2   Meta_Prepaid := '';
  STRING8   Meta_Dt_Last_Reported := '';
  STRING30  Meta_Carrier_City  := '';
  STRING2   Meta_Carrier_State := '';
  STRING4   Meta_Carrier_Route := '';
  STRING1   Meta_Carrier_Route_Zonecode := '';
  STRING6   Meta_Operator_ID := '';
  STRING6   Meta_Carrier_ID  := '';
  STRING25  Meta_OCN_Abbr_Name := '';
  STRING80  Meta_Affiliated_To := '';
  STRING60  Meta_Contact_Name  := '';
  STRING30  Meta_Contact_Address1 := '';
  STRING30  Meta_Contact_Address2 := '';
  STRING30  Meta_Contact_City  := '';
  STRING2   Meta_Contact_State := '';
  STRING9   Meta_Contact_Zip   := '';
  STRING60  Meta_Contact_Email := '';
  STRING10  Meta_Contact_Phone := '';
  STRING10  Meta_Contact_Fax   := '';
END;
