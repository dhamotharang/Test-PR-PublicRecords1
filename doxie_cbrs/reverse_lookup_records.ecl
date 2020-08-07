IMPORT doxie, doxie_cbrs, dx_Gong, Suppress;

EXPORT reverse_lookup_records(DATASET(doxie_cbrs.layout_references) bdids,
                              doxie.IDataAccess mod_access,
                              BOOLEAN Include_ReversePhone) := FUNCTION

phones := DEDUP(doxie_cbrs.best_records_bdids(bdids)(Include_ReversePhone AND (INTEGER)phone <> 0), phone, ALL);
k := dx_Gong.key_phone10();

{UNSIGNED1 level, k} keepk(UNSIGNED1 l, k r) := TRANSFORM
  SELF.level := l;
  SELF := r;
END;

jnd := JOIN(phones, k,
  KEYED(LEFT.phone = RIGHT.phone10) AND
  RIGHT.z5 <> '' AND
  (RIGHT.prim_range <> '' OR RIGHT.prim_name <> ''),
  keepk(LEFT.level, RIGHT),
  KEEP(10),
  LIMIT(100,SKIP));

ds_out := Suppress.MAC_SuppressSource(jnd, mod_access, did);

RETURN ds_out;
END;
  
