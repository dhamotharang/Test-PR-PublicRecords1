IMPORT iesp;

EXPORT layout_progressive_phones := MODULE

  EXPORT Phone_Last3Digits := RECORD
      STRING3 digits;
  END;

EXPORT layout_exp_multiple_phones := RECORD
    progressive_phone.layout_experian_phones;
    DATASET(Phone_Last3Digits) Phones_Last3Digits{maxcount(iesp.Constants.MaxCountLast3Digits)};
  END;

  EXPORT common_with_meta_rec := RECORD(Progressive_Phone.Layout_Progressive_Batch_Out_With_DID)
    STRING1   Meta_Line := '';
    STRING1   Meta_Serv := '';
    STRING60  Meta_Carrier_Name := '';
    STRING17  Meta_ServLine_Type := '';
    STRING30  Meta_Carrier_City  := '';
    STRING2   Meta_Carrier_State := '';
    STRING17  phone_line_type_desc := '';

  END;

END;
