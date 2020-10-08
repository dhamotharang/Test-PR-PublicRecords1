IMPORT uccv2, ffd, UCCv2_Services;

EXPORT layout_ucc_party_raw := RECORD
  UCCv2_Services.layout_ucc_party_raw_src;
  UNSIGNED8 persistent_record_id:=0;
  FFD.Layouts.CommonRawRecordElements;
END;
