import doxie, header, data_services;

hdr := header.File_Headers;

name_did_rec := record
  hdr.fname;
  hdr.lname;
  hdr.did;
end;

hdr_sl_dst := distribute(table(hdr(fname<>'',lname<>''), name_did_rec), hash(fname,lname));

name_rec := record
  hdr_sl_dst.fname;
  hdr_sl_dst.lname;
  unsigned6 cnt := count(group);
end;

hdr_rar_name := table(hdr_sl_dst, name_rec, fname, lname, local)(cnt<50);
 
hdr_sl_dep := dedup(sort(hdr_sl_dst, record, local), record, local);

did_cnt_rec := record
  hdr_sl_dep.fname;
  hdr_sl_dep.lname;
  unsigned6 did_cnt := count(group);
end;

hdr_uni_did := table(hdr_sl_dep, did_cnt_rec, fname, lname, local)(did_cnt=1);

name_did_rec refine_it(name_did_rec l) := transform
	self := l;
end;

hdr_final_ready := join(hdr_sl_dep, hdr_rar_name, 
                        left.fname = right.fname and 
				    left.lname = right.lname, refine_it(left), local);
				    
hdr_final := join(hdr_final_ready, hdr_uni_did,
                  left.fname = right.fname and 
			   left.lname = right.lname, refine_it(left), local) : persist('per_hdr_final');
			   
export key_name_unique_did := 
       index(hdr_final, {fname, lname}, {did}, 
	        data_services.data_location.prefix() + 'thor_data400::key::fname.lname.unique.did_' + doxie.Version_SuperKey);