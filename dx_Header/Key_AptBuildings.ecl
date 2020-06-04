IMPORT _Control, data_services;
IMPORT $;
#IF(_Control.Environment.onVault) IMPORT vault; #END;


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
#IF(_Control.Environment.onVault) // when running on vault cluster, we need to use the file pointer instead of the roxie key in boca
    vault.dx_header.key_AptBuildings(data_category);
#ELSE
    INDEX (keyed_fields, payload, fname(data_category));
#END;

