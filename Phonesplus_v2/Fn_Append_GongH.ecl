//****************Function to append flags/indicators when matching to Gong History***************
import ut,Gong_Neustar;
export Fn_Append_GongH(dataset(recordof(Layout_In_Phonesplus.layout_in_common)) phplus_in) := function

// VC - Using newer file DF-23004. As per Charles Gong.File_History redirects to Gong_Neustar.File_History
// gongh	 	:=	Gong.File_History(current_record_flag <> 'Y');
gongh	 	:=	Gong_Neustar.File_History(current_record_flag <> 'Y');


phonesplus_v2.Mac_Filter_Bad_Phones (gongh,phone10,,,gongh_phones);


gongh_d1 	:=	sort(distribute(gongh_phones, hash(phone10)), phone10, -dt_last_seen, local);
gongh_d2 	:=	sort(distribute(gongh_phones(did > 0), hash(did)), did, -dt_last_seen, local) ;
gongh_d3 	:=	sort(distribute(gongh_phones(length(trim(prim_range + prim_name + sec_range + z5, all)) > 5), hash(name_last, prim_range, prim_name, sec_range, z5)), name_last, prim_range, prim_name, sec_range, z5, -dt_last_seen, local);

//----Match to gongh by phone - a match will indicate phone was active in eda, but it was disconnected or ported or some other change
phplus_in_d1:=  distribute(phplus_in, hash(npa+phone7));

recordof(phplus_in) t_match_gongh1(phplus_in_d1 le, gongh_d1 ri) := transform
	self.eda_hist_match 	 	:= if(ri.phone10 <> '', le.eda_hist_match | 1b,le.eda_hist_match |0b);
	self.eda_hist_phone_dt		:= if(ri.phone10 <> '', (unsigned)ri.dt_last_seen , 0);
	self:= le;
end;

match_gongh1 := join(phplus_in_d1, 
				      gongh_d1,
					  left.npa+left.phone7 = right.phone10,
					  t_match_gongh1(left, right),
					  left outer,
					  keep(1),
					  local);

//----Match to gongh by did and phone last 7 - a match will indicate phone was active in eda, but it was disconnected or ported or some other change
phplus_in_d2:=  distribute(match_gongh1(did > 0), hash(did));

recordof(phplus_in) t_match_gongh2a(phplus_in_d2 le, gongh_d2 ri) := transform
	self.eda_hist_match 	:= if(ri.did > 0 and le.pdid = 0, le.eda_hist_match | 10b, le.eda_hist_match |0b);
	self.eda_hist_did_dt	:= if(ri.did > 0 and le.pdid = 0, (unsigned)ri.dt_last_seen , 0);
//Attempting to improve dt_first_seen and dt_last_seen with Gong H	
	self.DateLastSeen		:= if((unsigned) ri.dt_last_seen[..6] > 0, (unsigned) ri.dt_last_seen[..6], le.DateLastSeen);
	self.DateFirstSeen		:= if((unsigned) ri.dt_first_seen[..6] > 0, (unsigned) ri.dt_first_seen[..6], le.DateFirstSeen);
	self:= le;
end;

match_gongh2a := join(phplus_in_d2, 
				      gongh_d2,
					  left.did = right.did and
					  left.pdid = 0 and 
					  left.phone7 = right.phone10[4..],
					  t_match_gongh2a(left, right),
					  left outer,
					  keep(1),
					  local);
					  
//----Match to gongh by did only - a match will indicate individual had an active phone in eda, but the phone was disconected or ported or some other change
recordof(phplus_in) t_match_gongh2b(match_gongh2a le, gongh_d2 ri) := transform
	self.eda_hist_match 	:= if(ri.did > 0 and le.pdid = 0, le.eda_hist_match | 100b, le.eda_hist_match |0b);
	self.eda_hist_did_dt	:= if(ri.did > 0 and le.pdid = 0, (unsigned)ri.dt_last_seen , 0);
	self:= le;
end;

match_gongh2b := join(match_gongh2a, 
				      gongh_d2,
					  left.did = right.did and
					  left.pdid = 0,
					  t_match_gongh2b(left, right),
					  left outer,
					  keep(1),
					  local);					  	  
	
	match_gongh2b_all := 	match_gongh2b + 	match_gongh1(did = 0);	
//----Match to gongh by last name, address and phone last 7 -  a match will indicate phone was active in eda, but it was disconnected or ported or other change
phplus_in_d3:=  distribute(match_gongh2b_all(trim(prim_range + prim_name + sec_range) <> ''), hash(lname, prim_range, prim_name, sec_range, zip5));

recordof(phplus_in) t_match_gongh3a(phplus_in_d3 le, gongh_d3 ri) := transform
	self.eda_hist_match := if(ri.name_last <> '', le.eda_hist_match | 1000b, le.eda_hist_match |0b);
	self.eda_hist_nm_addr_dt	:= if(ri.name_last <> '' , (unsigned)ri.dt_last_seen  ,0);
//Attempting to improve dt_first_seen and dt_last_seen with Gong H		
	self.DateLastSeen		:= if((unsigned) ri.dt_last_seen[..6] > 0, (unsigned) ri.dt_last_seen[..6], le.DateLastSeen);
	self.DateFirstSeen		:= if((unsigned) ri.dt_first_seen[..6] > 0, (unsigned) ri.dt_first_seen[..6], le.DateFirstSeen);
	self:= le;
end;

match_gongh3a := join(phplus_in_d3, 
				      gongh_d3,
					  left.lname = right.name_last and
					  left.prim_range = right.prim_range and
					  left.prim_name = right.prim_name and
					  left.sec_range = right.sec_range and
					  left.zip5 = right.z5 and 
					  left.phone7 = right.phone10[4..],
					  t_match_gongh3a(left, right),
					  left outer,
					  keep(1),
					  local);
					  
return match_gongh3a + match_gongh2b_all(trim(prim_range + prim_name + sec_range) = '');
end;






