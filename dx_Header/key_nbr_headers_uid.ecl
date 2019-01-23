IMPORT $;

keyed_fields := RECORD
  $.layouts.i_nbr_uid.zip;
  $.layouts.i_nbr_uid.prim_name;
  $.layouts.i_nbr_uid.suffix;
  $.layouts.i_nbr_uid.predir;
  $.layouts.i_nbr_uid.postdir;
  $.layouts.i_nbr_uid.uid;
END;

EXPORT key_nbr_headers_uid (integer data_category = 0) := 
  INDEX (keyed_fields, $.layouts.i_nbr_uid, $.names().i_nbr_uid);
