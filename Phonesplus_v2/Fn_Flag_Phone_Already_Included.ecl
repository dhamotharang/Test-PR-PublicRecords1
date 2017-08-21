//****************Function to determine if a phone10 has alredy been included/excluded for someone else********************
export Fn_Flag_Phone_Already_Included (dataset(recordof(Layout_In_Phonesplus.layout_in_common)) phplus_in) := function

already_classified := Fn_Phone_Already_Classified(phplus_in);

recordof(phplus_in) t_flag_already_included(phplus_in le, already_classified ri) := transform					
	already_included_caption := Translation_Codes.rules_bitmap_code('Included-for-someone-else');					
	
	self.rules  		:=  if (~le.in_flag and 
						        le.npa = ri.npa and 
								le.phone7 = ri.phone7 and
	                           ~Translation_Codes.fFlagIsOn(le.rules, Translation_Codes.rules_bitmap_code('Low-Vendor-Conf')) and
														 ~Translation_Codes.fFlagIsOn(le.rules, Translation_Codes.rules_bitmap_code('Deceased')) and
														 ~Translation_Codes.fFlagIsOn(le.rules, Translation_Codes.rules_bitmap_code('Non-pub-for-someone-else')) and
														 ~Translation_Codes.fFlagIsOn(le.rules, Translation_Codes.rules_bitmap_code('Gongh-Disconnect')) and
														 ~Translation_Codes.fFlagIsOn(le.rules, Translation_Codes.rules_bitmap_code('Consortium-Disconnect'))
								 ,
							   le.rules | 
							   already_included_caption,
							   le.rules);
	self := le;					
					
end;

already_included :=  join(distribute(phplus_in, hash(npa+phone7)),
						   distribute(already_classified, hash(npa+phone7)),
						   left.npa+left.phone7 = right.npa+right.phone7,
						   t_flag_already_included(left, right),
						   left outer,
						   local);								

return already_included;
end;
