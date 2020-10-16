IMPORT $, doxie, data_services; 

key_rec := RECORD
  $.Layouts.Layout_inspection;
  integer1 __internal_fpos__ := 0;    //for platform?
END;

EXPORT key_payload_inspection := INDEX({key_rec.Activity_Number}, key_rec, $.names().inspection);