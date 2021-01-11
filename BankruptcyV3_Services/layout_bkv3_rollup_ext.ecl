IMPORT bankruptcyv3;

EXPORT layout_bkv3_rollup_ext := RECORD
  bankruptcyv3_services.layouts.layout_rollup;
  bankruptcyv3.layout_courts court;
END;
