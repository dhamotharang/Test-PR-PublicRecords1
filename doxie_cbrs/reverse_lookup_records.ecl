import doxie, doxie_cbrs, dx_Gong, Suppress;

export reverse_lookup_records(DATASET(doxie_cbrs.layout_references) bdids, 
                              doxie.IDataAccess mod_access,
                              BOOLEAN Include_ReversePhone) := FUNCTION

phones := dedup(doxie_cbrs.best_records_bdids(bdids)(Include_ReversePhone AND (integer)phone <> 0), phone, ALL);
k := dx_Gong.key_phone10();

{unsigned1 level, k} keepk(unsigned1 l, k r) := transform
	self.level := l;
	self := r;
end;

jnd := join(phones, k, 
         KEYED(left.phone = right.phone10) AND
         right.z5 <> '' AND 
         (right.prim_range <> '' OR right.prim_name <> ''), 
         keepk(left.level, right), 
         KEEP(10), 
         LIMIT(100,SKIP));

ds_out := Suppress.MAC_SuppressSource(jnd, mod_access, did);

RETURN ds_out;
END;
	