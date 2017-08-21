ds_hdr := dataset('~thor_data400::base::header',header.Layout_Header,flat);
ds_tu1 := dataset('~thor_data400::base::header_transunion',header.layout_header,flat);
ds_tu2 := header.transunion_did;

hdr_dist := distribute(ds_hdr,hash(did,prim_range,prim_name,sec_range,zip));
tu_dist1 := distribute(ds_tu1, hash(did,prim_range,prim_name,sec_range,zip));
tu_dist2 := distribute(ds_tu2, hash(did,prim_range,prim_name,sec_range,zip));

hdr_sort := sort(hdr_dist,did,prim_range,prim_name,sec_range,zip,local);
tu_sort1 := sort(tu_dist1, did,prim_range,prim_name,sec_range,zip,local);
tu_sort2 := sort(tu_dist2, did,prim_range,prim_name,sec_range,zip,local);

hdr_dupd := dedup(hdr_sort,did,prim_range,prim_name,sec_range,zip,local);
tu_dupd1 := dedup(tu_sort1, did,prim_range,prim_name,sec_range,zip,local);
tu_dupd2 := dedup(tu_sort2, did,prim_range,prim_name,sec_range,zip,local);

header.layout_header t_tu_only(header.Layout_Header le, header.Layout_Header ri) := transform
 self := le;
end;

j_tu1_only := join(tu_dupd1,hdr_dupd,
                   left.did=right.did and 
				   left.prim_range=right.prim_range and
				   left.prim_name=right.prim_name and
				   left.sec_range=right.sec_range and
				   left.zip=right.zip,
				   t_tu_only(left,right),
				   left only,
				   local
				  );

j_tu2_only := join(tu_dupd2,hdr_dupd,
                   left.did=right.did and 
				   left.prim_range=right.prim_range and
				   left.prim_name=right.prim_name and
				   left.sec_range=right.sec_range and
				   left.zip=right.zip,
				   t_tu_only(left,right),
				   left only,
				   local
				  );				  
				  
output(j_tu1_only);
output(j_tu2_only);				  

output(count(j_tu1_only),named('based_on_TU_DIDs_as_they_were_in_July_Header'));
output(count(j_tu2_only),named('based_on_externally_DIDing_TU_records'));
//export transunion_only := 'todo';