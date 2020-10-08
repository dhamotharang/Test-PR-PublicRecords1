IMPORT bankruptcyv3;
EXPORT layout_casenumber_ext :=
  RECORD
    bankruptcyv3.key_bankruptcyv3_main_full().orig_case_number;
    bankruptcyv3.key_bankruptcyv3_main_full().filing_jurisdiction;
    BOOLEAN isdeepdive;
  END;
  
