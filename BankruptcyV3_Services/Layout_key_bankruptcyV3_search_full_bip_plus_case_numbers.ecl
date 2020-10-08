IMPORT bankruptcyv3;

EXPORT Layout_key_bankruptcyV3_search_full_bip_plus_case_numbers :=
  RECORD
    bankruptcyv3.key_bankruptcyv3_search_full_bip();
    BankruptcyV3_Services.layouts.layout_rollup.full_case_number;
  END;
