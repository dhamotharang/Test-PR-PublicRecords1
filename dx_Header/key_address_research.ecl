IMPORT $;

rec := $.layouts.i_address_research;

keyed_fields := RECORD
  rec.zip;
  rec.addr_type;
END;

EXPORT key_address_research (integer data_category = 0) := 
         INDEX (keyed_fields, rec, $.names().i_address_research);
