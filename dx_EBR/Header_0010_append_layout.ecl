IMPORT dx_common, EBR;

// This layout defines the field used for append macros. There are 72 fields in this key, better to only keep the ones we need.
key_layout := RECORDOF(ebr.Key_0010_Header_BDID);

EXPORT Header_0010_append_layout := MODULE

  EXPORT slim := RECORD
    key_layout.sic_code;
    key_layout.business_desc;
  END;

  EXPORT key := RECORD(key_layout) END;

END;
