import did_add,didville,header,business_header,Address,ut,header_slimsort,business_header_ss,_control, BIPv2, mdr;

export fmac_did_bdid_hhid(history_in, layout) := functionmacro

layout_history_did_hhid_bdid := record
	layout;
	unsigned1 did_score := 0;
	unsigned1 hhid_score := 0;
	unsigned1 bdid_score := 0;
end;

layout_history_did_hhid_bdid init_did_hhid(history_in l) := transform
	self.did := 0;
	self.did_score := 0;
	self.hhid := 0;
	self.hhid_score := 0;
	self.bdid := 0;
	self.bdid_score := 0;
	self := l;
end;

history_init := project(history_in, init_did_hhid(left));

history_matchset := ['A', 'P', 'Z'];

did_add.MAC_Match_Flex(history_init,history_matchset,
                       foo,foo,name_first,name_middle,name_last,name_suffix,
				   prim_range,prim_name,sec_range,z5,st,phone10,
				   did,layout_history_did_hhid_bdid,true,did_score,75,history_did);

history_did_dist := distribute(history_did(name_last<>''), hash(name_last,prim_name));		

didville.MAC_HHID_Append_By_Address(
	history_did_dist, history_hhid, hhid, name_last,
	prim_range, prim_name, sec_range, st, z5)		

bdid_matchset := ['A','P'];
bdid_inrecs := history_hhid(listing_type_bus<>'' OR listing_type_gov<>'',publish_code IN ['P','U']) +
								history_did(name_last = '', listing_type_bus<>'' OR listing_type_gov<>'',publish_code IN ['P','U']);
business_header_ss.MAC_match_FLEX(bdid_inrecs
																	,bdid_matchset
																	,company_name
																	,prim_range
																	,prim_name
																	,z5
																	,sec_range
																	,st
																	,phone10
																	,fein
																	,bdid
																	,layout_history_did_hhid_bdid
																	,true
																	,bdid_score
																	,history_bdid
																	,														// keep count
																	,														// default threshold
																	,														// use prod version of superfiles
																	,														// default is to hit prod from dataland, and on prod hit prod.		
																	,BIPV2.xlink_version_set		// create BIP keys only
																	,														// url
																	,														// email 
																	,v_city_name								// city
																	,name_first									// fname
																	,name_middle								// mname
																	,name_last									// lname
																	,														// contact ssn
																	,														// source
																	,														// source_record_id
																	,false
																	);												
	

layout get_history_out(history_hhid l) := transform
	self := l;
end;

out_raw := project(history_bdid + 
		  	      history_hhid(~((listing_type_bus<>'' OR listing_type_gov<>'') and publish_code IN ['P','U'])) + 
				 history_did (name_last='' and ~((listing_type_bus<>'' OR listing_type_gov<>'') and publish_code IN ['P','U'])), 
				 get_history_out(left));
				 
out_with_hhid := out_raw(hhid<>0);	

out_no_hhid := out_raw(hhid=0);

layout get_hhid_by_did(out_no_hhid l, header.File_HHID_Current r) := transform
	self.hhid := r.hhid;
	self := l;
end;
		
history_out := join(out_no_hhid(did<>0), header.File_HHID_Current(ver=1),
                    left.did = right.did, get_hhid_by_did(left,right),
				left outer, hash) + out_no_hhid(did=0) + out_with_hhid;					   

return history_out;

endmacro;
