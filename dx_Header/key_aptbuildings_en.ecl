IMPORT data_services;
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

fname (integer data_category) := $.names().i_aptbuildings_fcra_en; // doesn't exist on non-FCRA side

//TODO: only on FCRA side? Then "fname" above is not needed.
EXPORT key_aptbuildings_en (integer data_category = 0) := 
         INDEX (keyed_fields, payload, fname(data_category));
