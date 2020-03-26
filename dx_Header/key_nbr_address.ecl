IMPORT $;

keyed_fields := RECORD
  $.layouts.i_nbr_address.prim_name;
  $.layouts.i_nbr_address.zip;
  $.layouts.i_nbr_address.z2;
  $.layouts.i_nbr_address.suffix;
  $.layouts.i_nbr_address.prim_range;
END;

payload := RECORD
  $.layouts.i_nbr_address.did;
  $.layouts.i_nbr_address.sec_range;
  $.layouts.i_nbr_address.dt_first_seen;
  $.layouts.i_nbr_address.dt_last_seen;
  $.layouts.i_nbr_address.RawAID;
END;

EXPORT key_nbr_address (integer data_category = 0) := 
  INDEX (keyed_fields, payload, $.names().i_nbr_address);
  