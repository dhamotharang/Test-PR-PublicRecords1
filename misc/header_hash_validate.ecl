layout_header_hash := record
unsigned8	hash_val;
unsigned6 	did;
end;

ds := dataset('~thor_data400::base::header_hashes', layout_header_hash, flat);

validation_rec := record
string1	hash_val_char;
string1	did_char;
unsigned8 total :=0;
end;

validation_rec to_validation(ds l) := transform
self.hash_val_char := ((string) l.hash_val)[5..6];
self.did_char := ((string) l.did)[5..6];
self.total :=0;
end;

ds_slim := project(ds,to_validation(left));

validation_record :=  record
hash_val_char := ds_slim.hash_val_char;
did_char := ds_slim.did_char;
total := count(group);
end;

stats := table(ds_slim,validation_record,hash_val_char,did_char,few);

stats_sorted := sort(stats,hash_val_char,did_char);

export header_hash_validate := output(choosen(stats_sorted,500));