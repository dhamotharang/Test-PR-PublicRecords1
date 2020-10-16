IMPORT $, doxie, data_services; 

key_rec := RECORD
  $.Layouts.Layout_hazardous_substance;
  integer1 __internal_fpos__ := 0;    //for platform?
END;

EXPORT key_payload_hazardous_substance := INDEX({key_rec.Activity_Number}, key_rec, $.names().hazardous_substance);