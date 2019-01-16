IMPORT $;

//df := $.layouts.i_nbr_headers;

keyed_fields := RECORD
  $.layouts.i_nbr_headers.zip;
  $.layouts.i_nbr_headers.prim_name;
  $.layouts.i_nbr_headers.suffix;
  $.layouts.i_nbr_headers.predir;
  $.layouts.i_nbr_headers.postdir;
  $.layouts.i_nbr_headers.prim_range;
  $.layouts.i_nbr_headers.sec_range;
END;

payload := RECORD
  $.layouts.i_nbr_headers.uid;
  $.layouts.i_nbr_headers.RawAID;
END;

EXPORT key_nbr_headers (integer data_category = 0) := 
  INDEX (keyed_fields, payload, $.names().i_nbr_headers);
