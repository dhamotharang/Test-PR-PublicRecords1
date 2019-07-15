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

fname (integer data_category) := IF (data_category = data_services.data_env.iFCRA,
                                     $.names().i_aptbuildings_fcra,
                                     $.names().i_aptbuildings); 

EXPORT key_AptBuildings (integer data_category = 0) := 
         INDEX (keyed_fields, payload, fname(data_category));
