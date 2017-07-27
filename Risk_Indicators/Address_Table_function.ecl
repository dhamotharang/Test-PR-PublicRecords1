import header, ut;

export Address_Table_function(dataset(header.layout_header) hf, string version='') := function


hdr_slim := RECORD
	string10 prim_range := (string10)hf.prim_range;
	string2 predir := hf.predir;
	string28 prim_name := (string28)hf.prim_name;
	string4 suffix := (string4)hf.suffix;
	string2 postdir := hf.postdir;
	string8 sec_range := (string8)hf.sec_range;
	string5 zip := (string5)hf.zip;
	hf.Did;
	hf.ssn;
	hf.phone;
	hf.dt_first_seen;
	hf.dt_last_seen;
	hf.src;  // hang onto the source in case we need to filter out specific sources for the FCRA version
END;

hf_slim := DISTRIBUTE(table(hf, hdr_slim), HASH(zip,prim_range,predir,prim_name,suffix,postdir,sec_range));
// output(hf_slim);


ssn_slim := RECORD
	hf_slim.zip;
	hf_slim.prim_range;
	hf_slim.predir;
	hf_slim.prim_name;
	hf_slim.suffix;
	hf_slim.postdir;
	hf_slim.sec_range;
	
	hf_slim.ssn;
	dt_first_seen := MIN(GROUP,IF(hf_slim.dt_first_seen=0,999999,hf_slim.dt_first_seen));
	dt_last_seen := MAX(GROUP,hf_slim.dt_last_seen);
	// cnt := COUNT(GROUP);
END;
d_ssn := TABLE(hf_slim(LENGTH(TRIM(ssn))=9), ssn_slim, zip,prim_range,predir,prim_name,suffix,postdir,sec_range, ssn, LOCAL);
// output(d_ssn, named('deduped_ssns'));


sysdate := ut.GetDate[1..6] + '31';
ssn_stats := record
	d_ssn.zip;
	d_ssn.prim_range;
	d_ssn.predir;
	d_ssn.prim_name;
	d_ssn.suffix;
	d_ssn.postdir;
	d_ssn.sec_range;
	ssn_ct := count(group);
	ssn_ct_c6 := count(group, ut.DaysApart(sysdate, d_ssn.dt_first_seen[1..6]+'31') < 183);
end;
ssn_counts := table(d_ssn, ssn_stats, zip,prim_range,predir,prim_name,suffix,postdir,sec_range, local);
// output(ssn_counts, named('ssn_counts'));

did_slim := RECORD
	hf_slim.zip;
	hf_slim.prim_range;
	hf_slim.predir;
	hf_slim.prim_name;
	hf_slim.suffix;
	hf_slim.postdir;
	hf_slim.sec_range;
	
	hf_slim.did;
	dt_first_seen := MIN(GROUP,IF(hf_slim.dt_first_seen=0,999999,hf_slim.dt_first_seen));
	dt_last_seen := MAX(GROUP,hf_slim.dt_last_seen);
	// cnt := COUNT(GROUP);
END;
d_did := TABLE(hf_slim(did<>0), did_slim, zip,prim_range,predir,prim_name,suffix,postdir,sec_range, did, LOCAL);
// output(d_did, named('deduped_dids'));


did_stats := record
	d_did.zip;
	d_did.prim_range;
	d_did.predir;
	d_did.prim_name;
	d_did.suffix;
	d_did.postdir;
	d_did.sec_range;
	did_ct := count(group);
	did_ct_c6 := count(group, ut.DaysApart(sysdate, d_did.dt_first_seen[1..6]+'31') < 183);
end;
did_counts := table(d_did, did_stats, zip,prim_range,predir,prim_name,suffix,postdir,sec_range, local);
// output(did_counts, named('did_counts'));


common_layout := record
	string10 prim_range;
	string2 predir;
	string28 prim_name;
	string4 suffix;
	string2 postdir;
	string8 sec_range;
	string5 zip;
	integer ssn_ct;
	integer ssn_ct_c6;
	integer did_ct;
	integer did_ct_c6;
end;


// joining ssn_counts and did_counts together
merged := join(ssn_counts, did_counts, left.zip=right.zip and left.prim_range=right.prim_range and left.predir=right.predir and
				 left.prim_name=right.prim_name and left.suffix=right.suffix and left.postdir=right.postdir and left.sec_range=right.sec_range,
				transform(common_layout, 
							use_right := left.zip='';
							self.prim_range := if(use_right, right.prim_range, left.prim_range),
							self.predir := if(use_right, right.predir , left.predir ),
							self.prim_name  := if(use_right, right.prim_name , left.prim_name ),
							self.suffix := if(use_right, right.suffix , left.suffix ),
							self.postdir := if(use_right, right.postdir , left.postdir ),
							self.sec_range := if(use_right, right.sec_range , left.sec_range ),
							self.zip := if(use_right, right.zip , left.zip ),
							self := left, 
							self := right), 
				full outer, local);

// output(ssn_phone_did, named('ssn_phone_did'));

return merged;

end;
