//former: Gong_Neustar.Key_address_current
IMPORT $;

rec := $.layouts.i_address_current;

keyed_fields := RECORD
  rec.prim_name;
  rec.st;
  rec.z5;
  rec.prim_range;
  rec.sec_range;
  rec.predir;
  rec.suffix;
END;


EXPORT key_address_current (integer data_category = 0) := 
         INDEX (keyed_fields, {rec - keyed_fields}, $.names().i_address_current);