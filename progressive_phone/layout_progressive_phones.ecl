IMPORT iesp, progressive_phone;

EXPORT layout_progressive_phones := MODULE

  EXPORT Phone_Last3Digits := RECORD
    STRING3 digits;
  END;

  EXPORT layout_exp_multiple_phones := RECORD
    progressive_phone.layout_experian_phones;
    DATASET(Phone_Last3Digits) Phones_Last3Digits{MAXCOUNT(iesp.Constants.MaxCountLast3Digits)};
  END;

  EXPORT batch_out_plus := RECORD(Progressive_Phone.Layout_Progressive_Batch_Out_With_DID)
    STRING17  phone_line_type_desc := '';
    UNSIGNED1 Phone_StarRating := 0;
  END;

END;
