import did_add,didville,header,business_header,Address,ut,header_slimsort,business_header_ss,_control, ut, idl_header, BIPV2;

export fn_did_bdid_hhid_trg(dataset(recordof(layout_gongMaster)) history_init0) := function

//the original temp_ assignments omitted temp_prim_range, temp_st, and temp_z5
//in an attempt to mimic proc_roxie_keybuild_prep_current
layout_temp_addr_fields t1(history_init0 le) := transform
 self.temp_prim_range   := if(le.prim_range  = '',le.appnd_prim_range ,le.prim_range);
 self.temp_predir 		:= if(le.predir      = '',le.appnd_predir     ,le.predir);
 self.temp_prim_name 	:= if(le.prim_name   = '',le.appnd_prim_name  ,le.prim_name);
 self.temp_suffix  	    := if(le.suffix      = '',le.appnd_suffix     ,le.suffix);
 self.temp_postdir 	    := if(le.postdir     = '',le.appnd_postdir    ,le.postdir);
 self.temp_p_city_name	:= if(le.p_city_name = '',le.appnd_p_city_name,le.p_city_name);
 self.temp_sec_range  	:= if(le.sec_range   = '',le.appnd_sec_range  ,le.sec_range);
 self.temp_st 	        := if(le.st          = '',le.appnd_st         ,le.st);
 self.temp_z5 	        := if(le.z5          = '',le.appnd_z5         ,le.z5);
 self                   := le;
end;

history_init := project(history_init0,t1(left));

history_matchset := ['A', 'P', 'Z'];

did_add.MAC_Match_Flex(history_init,history_matchset,
                       foo,foo,name_first,name_middle,name_last,name_suffix,
				       temp_prim_range,temp_prim_name,temp_sec_range,temp_z5,temp_st,phone10,
				       did,layout_temp_addr_fields,true,did_score,75,history_did);
				  
//filtering on these fields based on the hash in the macro
//without it there's a huge skew because of the businesses in gong
hhid_by_addr_candidates     := history_did(  name_last<>'' and temp_prim_name<>'');
not_hhid_by_addr_candidates := history_did(~(name_last<>'' and temp_prim_name<>''));
				  
didville.MAC_HHID_Append_By_Address(hhid_by_addr_candidates,hhid_by_addr_append,hhid,name_last,temp_prim_range,temp_prim_name,temp_sec_range,temp_st,temp_z5)		

concat := hhid_by_addr_append+not_hhid_by_addr_candidates;

bdid_matchset := ['A','P'];
			   
business_header_ss.MAC_match_FLEX(concat,bdid_matchset,company_name,
				temp_prim_range,temp_prim_name,temp_z5,temp_sec_range,temp_st,phone10,fein,
				bdid,layout_temp_addr_fields,true,bdid_score,
				history_bdid
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
				)
				 
out_with_hhid :=            history_bdid(~(did>0 and hhid=0));
out_no_hhid   := distribute(history_bdid(  did>0 and hhid=0),hash(did));

hhid_file := distribute(header.file_hhid_current(ver=1),hash(did));

layout_temp_addr_fields get_hhid_by_did(out_no_hhid l, hhid_file r) := transform
	self.hhid := r.hhid;
	self      := l;
end;

history_out := join(out_no_hhid,hhid_file,left.did=right.did,get_hhid_by_did(left,right),left outer,keep(1),local)
             + out_with_hhid;
			 
persist_it := history_out;	// : persist('~thor_data400::persist::neustar::gongmaster_did');

//based on v1 code a record has to meet the following for it to be allowed thru
//at least keep them in the persist file should we need to try and find them
//filter_it  := persist_it(publish_code IN ['P','U']);

slim_it    := project(persist_it,layout_gongMaster);

return slim_it;

end;