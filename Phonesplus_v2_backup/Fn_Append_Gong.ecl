//****************Function to append flags/indicators when matching to Gong***************
import Gong_v2;
export Fn_Append_Gong(dataset(recordof(Layout_In_Phonesplus.layout_in_common)) phplus_in) := function

gong	 	:=	gong_v2.file_gongmaster(current_record_flag = 'Y');

phonesplus_v2.Mac_Filter_Bad_Phones (gong,phone10,,,gong_phones)

gong_d1 	:=	distribute(gong_phones, hash(phone10));
gong_d2 	:=	distribute(gong(did > 0), hash(did));
gong_d3 	:=	distribute(gong(name_last <> '' and length(trim(prim_range + prim_name + sec_range + z5, all)) > 5), hash(name_last, prim_range, prim_name, sec_range, z5));

//----Flag for Match to gong by phone - a match will indicate phone is active eda
phplus_in_d1:=  distribute(phplus_in, hash(npa+phone7));

recordof(phplus_in) t_match_gong1(phplus_in_d1 le, gong_d1 ri) := transform
	self.eda_match 	 	 := if(ri.phone10 <> '', le.eda_match | 1b,le.eda_match |0b);
	self.eda_phone_dt	 := if(ri.phone10 <> '', (unsigned)ri.dt_last_seen , 0);
	self:= le;
end;

match_gong1 := join(phplus_in_d1, 
				      gong_d1,
					  left.npa+left.phone7 = right.phone10,
					  t_match_gong1(left, right),
					  left outer,
					  keep(1),
					  local);

//----Flag for Match to gong by did and phone last 7 - a match will indicate phone is active eda
phplus_in_d2:=  distribute(match_gong1, hash(did));

recordof(phplus_in) t_match_gong2a(phplus_in_d2 le, gong_d2 ri) := transform
	self.eda_active_flag := if((ri.did > 0 and le.pdid = 0) or le.eda_active_flag, true, false);
	self.eda_match 		 := if(ri.did > 0 and le.pdid = 0, le.eda_match | 10b, le.eda_match |0b);
	self.eda_did_dt		 := if(ri.did > 0 and le.pdid = 0, (unsigned)ri.dt_last_seen , 0);
	self:= le;
end;

match_gong2a := join(phplus_in_d2, 
				      gong_d2,
					  left.did = right.did and
					  left.pdid = 0 and 
					  left.phone7 = right.phone10[4..],
					  t_match_gong2a(left, right),
					  left outer,
					  keep(1),
					  local);
					  
//----Flag for Match to gong by did only - a match will indicate individual has a phone active in eda
recordof(phplus_in) t_match_gong2b(match_gong2a le, gong_d2 ri) := transform
	self.eda_match 	:= if(ri.did > 0 and le.pdid = 0, le.eda_match | 100b, le.eda_match |0b);
	self.eda_did_dt	:= if(ri.did > 0 and le.pdid = 0, (unsigned)ri.dt_last_seen , 0);
	self:= le;
end;

match_gong2b := join(match_gong2a, 
				      gong_d2,
					  left.did = right.did and
					  left.pdid = 0,
					  t_match_gong2b(left, right),
					  left outer,
					  keep(1),
					  local);					  	  
					  
//----Flag for Match to gong by last name, address and phone last 7 - a match will indicate phone is active eda		  
phplus_in_d3:=  distribute(match_gong2b, hash(lname, prim_range, prim_name, sec_range, zip5));

recordof(phplus_in) t_match_gong3a(phplus_in_d3 le, gong_d3 ri) := transform
	self.eda_active_flag := if(ri.name_last <> '' or le.eda_active_flag, true, false);
	self.eda_match 		 := if(ri.name_last <> '', le.eda_match | 1000b, le.eda_match |0b);
	self.eda_nm_addr_dt  := if(ri.name_last <> '' , (unsigned)ri.dt_last_seen  ,0);
	self:= le;
end;

match_gong3a := join(phplus_in_d3, 
				      gong_d3,
					  left.lname = right.name_last and
					  left.prim_range = right.prim_range and
					  left.prim_name = right.prim_name and
					  left.sec_range = right.sec_range and
					  left.zip5 = right.z5 and 
					  left.phone7 = right.phone10[4..],
					  t_match_gong3a(left, right),
					  left outer,
					  keep(1),
					  local);
					  			  
return match_gong3a;

end;
