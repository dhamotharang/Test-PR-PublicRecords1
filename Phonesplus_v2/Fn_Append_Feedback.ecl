//****************Function to append flags/indicators when matching to Feedback***************
import phonesfeedback, ut;
export Fn_Append_Feedback(dataset(recordof(Layout_In_Phonesplus.layout_in_common)) phplus_in) := function

Feedback := project(phonesfeedback.file_phonesfeedback_base, transform({unsigned did,
																																				string20 lname,
																																				string10 street_number,
																																				string28 street_name,
																																				string5 zip5,
																																				string10 phone_number, 
																																				string1 phone_contact_type,
																																				unsigned date_added},
																																				self.phone_number := trim(left.phone_number,all),
																																				self.date_added := (unsigned)phonesFeedback.dateMMMDDYYYY(trim(left.date_time_added,left,right))[..8];
																																				self := left));

Feedback_d1 := dedup(sort(distribute(Feedback(phone_number <> '' and phone_contact_type <> '' and phone_contact_type <= '4'), hash(phone_number)), phone_number, -date_added, local), phone_number, local)  ;
Feedback_d2 := distribute(Feedback_d1(did > 0), hash(Did));
Feedback_d3 := Feedback_d1(lname <> '');
Feedback_d4 := distribute(Feedback_d1(trim(street_number + street_name + zip5, left, right) <> ''), hash(phone_number[4..10]));

//----Match to feeback by phone
phplus_in_d1:=  distribute(phplus_in, hash((npa+phone7)));

recordof(phplus_in) t_match_feedback1(phplus_in_d1 le, Feedback_d1 ri) := transform
	self.append_feedback_phone 	 	:= if(ri.phone_number <> '',ri.phone_contact_type ,le.append_feedback_phone);
	self.append_feedback_phone_dt	:= if(ri.phone_number <> '',ri.date_added, le.append_feedback_phone_dt);
	self:= le;
end;

match_feedback1 := join(phplus_in_d1, 
				       Feedback_d1,
					  left.npa+left.phone7 = right.phone_number,
					  t_match_feedback1(left, right),
					  left outer,
					  local);

//----Match to feeback by did and phone7 and last name phone10
phplus_in_d2:=  distribute(match_feedback1(did > 0), hash(did));

recordof(phplus_in) t_match_feedback2(phplus_in_d2 le, Feedback_d2 ri) := transform
	self.append_feedback_phone7_did			:= if(le.did = ri.did, ri.phone_contact_type,le.append_feedback_phone7_did	);
	self.append_feedback_phone7_did_dt	:= if(le.did = ri.did, ri.date_added,le.append_feedback_phone7_did_dt);
	self:= le;
end;

match_feedback2 := join(phplus_in_d2 , 
				      Feedback_d2,
					  left.did = right.did and
					  left.phone7 = right.phone_number[4..10],
					  t_match_feedback2(left, right),
					  keep (1),
					  left outer,local);
						
						
match_feedback2_all := distribute(match_feedback2 + match_feedback1(did = 0), hash(npa+phone7));

recordof(phplus_in) t_match_feedback3(match_feedback2_all le, Feedback_d3 ri) := transform
	self.append_feedback_phone7_did			:= if(le.append_feedback_phone7_did = '' and ri.phone_number <> '' and ri.lname <> '',ri.phone_contact_type, le.append_feedback_phone7_did);
	self.append_feedback_phone7_did_dt	:= if(le.append_feedback_phone7_did = '' and ri.phone_number <> '' and ri.lname <> '',ri.date_added,le.append_feedback_phone7_did_dt);
	self:= le;
end;

match_feedback3 := join(match_feedback2_all, 
				    distribute(Feedback_d3, hash(phone_number)),
					  left.npa+left.phone7 = right.phone_number and
						ut.StringSimilar(left.lname ,right.lname) < 3,
					  t_match_feedback3(left, right),
					  keep (1),
					  left outer,local);
						
						
//----Match to feeback by name and address and phone7				  
phplus_in_d4:=  distribute(match_feedback3, hash(phone7));

recordof(phplus_in) t_match_feedback4(phplus_in_d4 le, Feedback_d4 ri) := transform
	self.append_feedback_phone7_nm_addr := if(ri.phone_number[4..10] <> '',ri.phone_contact_type,'');
	self.append_feedback_phone7_nm_addr_dt		:= if(ri.phone_number[4..10] <> '',ri.date_added,0);
	self:= le;
end;

match_feedback4 := join(phplus_in_d4, 
				    Feedback_d4,
					  trim(left.prim_range, left, right) = trim(right.street_number, left, right) and
					  trim(left.prim_name, left, right) = trim(right.street_name, left, right) and
					  trim(left.zip5, left, right) = trim(right.zip5, left, right) and
					  left.phone7 = right.phone_number[4..10],
					  t_match_feedback4(left, right),
					  keep (1),
					  left outer,
					  local);

return match_feedback4;

end;