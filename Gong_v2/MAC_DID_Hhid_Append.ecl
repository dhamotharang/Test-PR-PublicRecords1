


export mac_did_hhid_append(history_in, history_out) := macro

import gong,gong_v2, did_add, didville, header, business_header,Address,ut, header_slimsort;

#uniquename(layout_history_did_hhid_bdid)
%layout_history_did_hhid_bdid% := record
	Gong_v2.layout_gongMaster,
	unsigned1 did_score,
	unsigned1 hhid_score,
	unsigned1 bdid_score,

end;

#uniquename(init_did_hhid)
%layout_history_did_hhid_bdid% %init_did_hhid%(history_in l) := transform
	self.did_score := 0;
	self.hhid_score := 0;
	self.bdid_score := 0;
	self := l;
end;

#uniquename(history_init)
%history_init% := project(history_in, %init_did_hhid%(left));


#uniquename(history_matchset)
%history_matchset% := ['A', 'P', 'Z'];
//appending DID to input file
#uniquename(history_did)
did_add.MAC_Match_Flex(%history_init%,%history_matchset%,
                       foo,foo,name_first,name_middle,name_last,name_suffix,
				   prim_range,prim_name,sec_range,z5,st,phone10,
				   did,%layout_history_did_hhid_bdid%,true,did_score,75,%history_did%);
  
#uniquename(history_did_dist)		
%history_did_dist% := distribute(%history_did%, hash(name_last,prim_name));		
//appending HHID 
#uniquename(history_hhid)		
didville.MAC_HHID_Append_By_Address(
	%history_did_dist%, %history_hhid%, hhid, name_last,
	prim_range, prim_name, sec_range, st, z5)		

#uniquename(bdid_matchset)
#uniquename(history_bdid)
#uniquename(bdid_inrecs)
%bdid_matchset% := ['A','P'];
//appending bdid
business_header_ss.MAC_match_FLEX(%history_hhid%,%bdid_matchset%,company_name,
				prim_range,prim_name,z5,sec_range,st,phone10,fein,
				bdid,%layout_history_did_hhid_bdid%,true,bdid_score,
				%history_bdid%)
	


#uniquename(get_history_out)
Gong_v2.layout_gongMaster %get_history_out%(%history_bdid% l) := transform
	self := l;
end;

#uniquename(out_raw)
%out_raw% := project(%history_bdid%,%get_history_out%(left));
				 
#uniquename(out_with_hhid)				 
%out_with_hhid% := %out_raw%(hhid<>0);	

#uniquename(out_no_hhid)
%out_no_hhid% := %out_raw%(hhid=0);

#uniquename(get_hhid_by_did)
Gong_v2.layout_gongMaster %get_hhid_by_did%(%out_no_hhid% l, header.File_HHID_Current r) := transform
	self.hhid := r.hhid;
	self := l;
end;
		
history_out := join(%out_no_hhid%(did<>0), header.File_HHID_Current(ver=1),
                    left.did = right.did, %get_hhid_by_did%(left,right),
				left outer, hash) + %out_no_hhid%(did=0) + %out_with_hhid%;					   

endmacro;