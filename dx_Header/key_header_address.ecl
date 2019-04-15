IMPORT $;

keyed_fields := RECORD
  $.layouts.i_header_address.prim_name;
  $.layouts.i_header_address.zip;
  $.layouts.i_header_address.prim_range;
  $.layouts.i_header_address.sec_range;
END;

EXPORT key_header_address (integer data_category = 0) := 
         INDEX (keyed_fields, $.layouts.i_header_address, $.names().i_header_address);