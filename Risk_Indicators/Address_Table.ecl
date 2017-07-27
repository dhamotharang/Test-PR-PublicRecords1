import header, ut, avm_v2;
																	
hf := header.File_Headers(prim_name<>'' and length(trim(zip))=5 and (integer)zip<>0 and ~iid_constants.filtered_source(src));

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


phone_slim := RECORD
	hf_slim.zip;
	hf_slim.prim_range;
	hf_slim.predir;
	hf_slim.prim_name;
	hf_slim.suffix;
	hf_slim.postdir;
	hf_slim.sec_range;
	
	hf_slim.phone;
	dt_first_seen := MIN(GROUP,IF(hf_slim.dt_first_seen=0,999999,hf_slim.dt_first_seen));
	dt_last_seen := MAX(GROUP,hf_slim.dt_last_seen);
	// cnt := COUNT(GROUP);
END;
d_phone := TABLE(hf_slim(TRIM(phone)<>''), phone_slim, zip,prim_range,predir,prim_name,suffix,postdir,sec_range, phone, LOCAL);
// output(d_phone, named('deduped_phones'));


phone_stats := record
	d_phone.zip;
	d_phone.prim_range;
	d_phone.predir;
	d_phone.prim_name;
	d_phone.suffix;
	d_phone.postdir;
	d_phone.sec_range;
	phone_ct := count(group);
	phone_ct_c6 := count(group, ut.DaysApart(sysdate, d_phone.dt_first_seen[1..6]+'31') < 183);
end;
phone_counts := table(d_phone, phone_stats, zip,prim_range,predir,prim_name,suffix,postdir,sec_range, local);
// output(phone_counts, named('phone_counts'));


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


spl := record
	string10 prim_range;
	string2 predir;
	string28 prim_name;
	string4 suffix;
	string2 postdir;
	string8 sec_range;
	string5 zip;
	integer ssn_ct;
	integer ssn_ct_c6;
	integer phone_ct;
	integer phone_ct_c6;
end;


// start the address table by joining ssn_counts and phone_counts together
ssn_phone := join(ssn_counts, phone_counts, left.zip=right.zip and left.prim_range=right.prim_range and left.predir=right.predir and
				 left.prim_name=right.prim_name and left.suffix=right.suffix and left.postdir=right.postdir and left.sec_range=right.sec_range,
				transform(spl, 
							use_right := left.zip='';
							self.prim_range := if(use_right, right.prim_range, left.prim_range),
							self.predir := if(use_right, right.predir , left.predir ),
							self.prim_name  := if(use_right, right.prim_name , left.prim_name ),
							self.suffix := if(use_right, right.suffix , left.suffix ),
							self.postdir := if(use_right, right.postdir , left.postdir ),
							self.sec_range := if(use_right, right.sec_range , left.sec_range ),
							self.zip := if(use_right, right.zip , left.zip ),
							self := left, self := right), 
				full outer, local);
// output(ssn_phone, named('ssn_phone'));

spdl := record
	spl;
	integer did_ct;
	integer did_ct_c6;
end;

// now append the did counts to the table
ssn_phone_did := join(ssn_phone, did_counts, left.zip=right.zip and left.prim_range=right.prim_range and left.predir=right.predir and
				 left.prim_name=right.prim_name and left.suffix=right.suffix and left.postdir=right.postdir and left.sec_range=right.sec_range,
				transform(spdl, 
							use_right := left.zip='';
							self.prim_range := if(use_right, right.prim_range, left.prim_range),
							self.predir := if(use_right, right.predir , left.predir ),
							self.prim_name  := if(use_right, right.prim_name , left.prim_name ),
							self.suffix := if(use_right, right.suffix , left.suffix ),
							self.postdir := if(use_right, right.postdir , left.postdir ),
							self.sec_range := if(use_right, right.sec_range , left.sec_range ),
							self.zip := if(use_right, right.zip , left.zip ),
							self := left, self := right), 
				full outer, local);
// output(ssn_phone_did, named('ssn_phone_did'));


addr_risk := record
	spdl;
	string5 fips_code;
	string7 geo_blk;
	string1 land_use;
	string8 recording_date;
	string4 assessed_value_year;
	string11 sales_price;  
	string11 assessed_total_value;
	string11 market_total_value;
	integer price_index_valuation;
	integer tax_assessment_valuation;
	integer hedonic_valuation;
	integer automated_valuation;
	integer confidence_score;
	integer median_fips_valuation;  
	integer median_tract_valuation;  
	integer median_block_valuation;
end;

// and finally, add the AVM values for the address where available
ssn_phone_did_distr := distribute(ssn_phone_did, hash(zip,prim_range,predir,prim_name,suffix,postdir,sec_range));
avm_distr := distribute(avm_v2.File_AVM_Base(trim(prim_name)<>'' and trim(zip)<>''), hash(zip,prim_range,predir,prim_name,suffix,postdir,sec_range));

addr_rsk_tbl := join(ssn_phone_did_distr, avm_distr, left.zip=right.zip and left.prim_range=right.prim_range and left.predir=right.predir and
				 left.prim_name=right.prim_name and left.suffix=right.suffix and left.postdir=right.postdir and left.sec_range=right.sec_range,
				transform(addr_risk, 
							self.prim_range := left.prim_range,
							self.predir := left.predir ,
							self.prim_name  := left.prim_name,
							self.suffix := left.suffix ,
							self.postdir := left.postdir,
							self.sec_range := left.sec_range,
							self.zip := left.zip,
							self := left, 
							
							// these values are no longer part of the AVM Base File
							// could add a join to the medians file to get them populated if we want, or
							// just zero them out for now since the medians file has it's own key
							// TODO:  create a key release bug to pull these fields from the layout completely
							self.median_fips_valuation := 0, 
							self.median_tract_valuation := 0,  
							self.median_block_valuation := 0,
	
							self := right), 
				left outer, keep(1), local);
// output(addr_rsk_tbl, named('addr_rsk_tbl'));

export Address_Table := addr_rsk_tbl  : PERSIST('persist::address_risk_table');;