IMPORT $;

keyed_fields := RECORD
  $.layouts.i_zip_did_full.p_lname;
  $.layouts.i_zip_did_full.p_fname;
  $.layouts.i_zip_did_full.zip;
  $.layouts.i_zip_did_full.lname;
  $.layouts.i_zip_did_full.fname;
END;

EXPORT key_zip_did_full (integer data_category = 0) := 
         INDEX (keyed_fields, $.layouts.i_zip_did_full - keyed_fields, $.names().i_zip_did_full);
