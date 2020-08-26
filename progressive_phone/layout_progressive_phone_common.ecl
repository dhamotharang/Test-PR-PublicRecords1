IMPORT Progressive_Phone;

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
  STRING8   Meta_ServLine_Type := '';
END;