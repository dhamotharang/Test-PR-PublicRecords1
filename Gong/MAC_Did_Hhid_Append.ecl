import gong, did_add, didville, header;

export mac_did_hhid_append(history_in, history_out) := macro

#uniquename(layout_history_did_hhid_bdid)
%layout_history_did_hhid_bdid% := record
	gong.Layout_bscurrent_raw,
	unsigned6 did,
	unsigned1 did_score,
	unsigned6 hhid,
	unsigned1 hhid_score,
	unsigned6	bdid,
	unsigned1 bdid_score,
	string8 dt_first_seen,
	string8 dt_last_seen,
	string1 current_record_flag,
	string8 deletion_date,
	unsigned2 disc_cnt6;
	unsigned2 disc_cnt12;
	unsigned2 disc_cnt18;
end;

#uniquename(init_did_hhid)
%layout_history_did_hhid_bdid% %init_did_hhid%(history_in l) := transform
	self.did := 0;
	self.did_score := 0;
	self.hhid := 0;
	self.hhid_score := 0;
	self.bdid := 0;
	self.bdid_score := 0;
	self := l;
end;

#uniquename(history_init)
%history_init% := project(history_in, %init_did_hhid%(left));


#uniquename(history_matchset)
%history_matchset% := ['A', 'P', 'Z'];

#uniquename(history_did)
did_add.MAC_Match_Flex(%history_init%,%history_matchset%,
                       foo,foo,name_first,name_middle,name_last,name_suffix,
				   prim_range,prim_name,sec_range,z5,st,phone10,
				   did,%layout_history_did_hhid_bdid%,true,did_score,75,%history_did%);

#uniquename(history_did_dist)		
%history_did_dist% := distribute(%history_did%(name_last<>''), hash(name_last,prim_name));		

#uniquename(history_hhid)		
didville.MAC_HHID_Append_By_Address(
	%history_did_dist%, %history_hhid%, hhid, name_last,
	prim_range, prim_name, sec_range, st, z5)		

#uniquename(bdid_matchset)
#uniquename(history_bdid)
#uniquename(bdid_inrecs)
%bdid_matchset% := ['A','P'];
%bdid_inrecs% := %history_hhid%(listing_type_bus<>'',publish_code IN ['P','U']) + %history_did%(name_last = '', listing_type_bus<>'',publish_code IN ['P','U']);
business_header_ss.MAC_match_FLEX(%bdid_inrecs%,%bdid_matchset%,listed_name,
				prim_range,prim_name,z5,sec_range,st,phone10,fein,
				bdid,%layout_history_did_hhid_bdid%,true,bdid_score,
				%history_bdid%)
	
#uniquename(layout_history_out)
%layout_history_out% := record
	gong.Layout_bscurrent_raw,
	unsigned6 did,
	unsigned6 hhid,
	unsigned6	bdid,
	string8 dt_first_seen,
	string8 dt_last_seen,
	string1 current_record_flag,
	string8 deletion_date,
	unsigned2 disc_cnt6;
	unsigned2 disc_cnt12;
	unsigned2 disc_cnt18;
end;

#uniquename(get_history_out)
%layout_history_out% %get_history_out%(%history_hhid% l) := transform
	self := l;
end;

#uniquename(out_raw)
%out_raw% := project(%history_bdid% + 
		  	      %history_hhid%(~(listing_type_bus<>'' and publish_code IN ['P','U'])) + 
				 %history_did% (name_last='' and ~(listing_type_bus<>'' and publish_code IN ['P','U'])), 
				 %get_history_out%(left));
				 
#uniquename(out_with_hhid)				 
%out_with_hhid% := %out_raw%(hhid<>0);	

#uniquename(out_no_hhid)
%out_no_hhid% := %out_raw%(hhid=0);

#uniquename(get_hhid_by_did)
%layout_history_out% %get_hhid_by_did%(%out_no_hhid% l, header.File_HHID_Current r) := transform
	self.hhid := r.hhid;
	self := l;
end;
		
history_out := join(%out_no_hhid%(did<>0), header.File_HHID_Current(ver=1),
                    left.did = right.did, %get_hhid_by_did%(left,right),
				left outer, hash) + %out_no_hhid%(did=0) + %out_with_hhid%;					   

endmacro;