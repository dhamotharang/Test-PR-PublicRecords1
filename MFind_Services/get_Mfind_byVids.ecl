import doxie,MFind,ut;

export get_MFind_byVids(dataset(MFind_services.Layout_Search_ids)in_Vids) := MODULE
		
	shared V_key := MFind.Key_MFind_VID;

	shared Layout_MFind_Report get_vids_r(V_Key r) := transform
		self.trim_vid := R.trim_vid;
		self := R;
	END;
	
	doxie.MAC_Header_Field_Declare()
	
	shared Layout_MFind_Search get_vids_s(in_Vids l, V_Key r) := transform
		ms(string70 a, string70 b, string70 c) :=map(a=''=>b,b=''=>a,ut.StringSimilar(a,c)<=ut.StringSimilar(b,c)=>a,b);	
		self.penalt:=
								doxie.FN_Tra_Penalty_DID((string) r.did) +
								doxie.FN_Tra_Penalty_Name(r.fname,r.mname,r.lname) +
								doxie.FN_Tra_Penalty_Addr(r.predir,r.prim_range,r.prim_name,
									r.addr_suffix,r.postdir,r.sec_range,ms(r.p_city_name,r.v_city_name,city_value),r.st,r.zip) +
								MFind_Services.FN_Tra_Penalty_Milbranch(r.Mil_Branch) +
								MFind_Services.FN_Tra_Penalty_Gender(r.curr_name_gender);
		Self.IsDeepDive := l.isDeepDive;
		Self.Trim_vid := R.trim_vid;
		self := R;								
	END;
	

	shared with_payload_report := join(in_Vids, V_Key, keyed(left.Vid =right.trim_Vid), get_vids_r(right),keep(1));
	shared with_payload_search := join(in_Vids, V_key, keyed(left.Vid = right.trim_Vid),get_vids_s(left,right),keep(1));
	
	shared res_report := dedup(with_payload_report,record,all);
	shared res_search := dedup(with_payload_search,record,all);
									
	export report := res_report;
	export search := res_search;

END;

