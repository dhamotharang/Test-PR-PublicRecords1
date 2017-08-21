//import ut,misc,vehlic;

h := header_slimsort.header_hash;
//
ds1 := dataset('~thor_data400::base::header_hashesw20080627-152451', {h.hash_val, h.did}, flat);
ds2 := dataset('~thor_data400::base::header_hashesw20080814-184423', {h.hash_val, h.did}, flat);
//
count(ds1);
count(ds2);
//

dso:= distribute(ds1,hash_val);
dsn := distribute(ds2,hash_val);
//
ds1 for_changes(dso l, dsn r) := transform
self:=l;
end;
o_only := join(dso,dsn,left.hash_val=right.hash_val and left.did=right.did,for_changes(left,right), local,left only);
count(o_only);
n_only := join(dsn,dso,left.hash_val=right.hash_val and left.did=right.did,for_changes(left,right), local, left only);
count(n_only);


output(o_only,,'~thor_data400::base::header_hashes_deletes_20080815',overwrite);
output(n_only,,'~thor_data400::base::header_hashes_adds_20080815',overwrite);
