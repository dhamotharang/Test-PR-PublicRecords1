IMPORT $;

rec := $.layouts.i_aptbuildings;

keyed_fields := RECORD
  rec.prim_range;
  rec.prim_name;
  rec.zip;
  rec.suffix;
  rec.predir;
END;

//TODO: check if I can use just record, instead of defining payload explicitely.

payload := RECORD
  rec.apt_cnt;
  rec.did_cnt;
END;

EXPORT key_AptBuildings (integer data_category = 0) := 
         INDEX (keyed_fields, payload, $.names().i_aptbuildings);
