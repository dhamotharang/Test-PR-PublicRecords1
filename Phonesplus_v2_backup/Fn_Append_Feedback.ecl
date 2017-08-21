//****************Function to append flags/indicators when matching to Feedback***************
import phonesfeedback;
export Fn_Append_Feedback(dataset(recordof(Layout_In_Phonesplus.layout_in_common)) phplus_in) := function

Feedback := phonesfeedback.file_phonesfeedback_base;

Feedback_d1 := distribute(Feedback(phone_number <> ''), hash((unsigned)phone_number))  ;
Feedback_d2 := distribute(Feedback((unsigned)did > 0 and phone_number <> ''), hash((unsigned)Did));
Feedback_d3 := distribute(Feedback(lname <> '' and trim(street_number + street_name + zip5, left, right) <> ''), hash(trim(lname, left, right), trim(street_number, left, right), trim(street_name, left, right), trim(zip5, left, right)));

//----Match to feeback by phone
phplus_in_d1:=  distribute(phplus_in, hash((unsigned)(npa+phone7)));

recordof(phplus_in) t_match_feedback1(phplus_in_d1 le, Feedback_d1 ri) := transform
	self.append_feedback_phone 	 	:= if(ri.phone_number <> '',ri.phone_contact_type ,'');
	self.append_feedback_phone_dt	:= if(ri.phone_number <> '',(unsigned)phonesFeedback.dateMMMDDYYYY(trim(ri.date_time_added,left,right))[..8],0);
	self:= le;
end;

match_feedback1 := join(phplus_in_d1, 
				       Feedback_d1,
					  (unsigned)(left.npa+left.phone7) = (unsigned)right.phone_number,
					  t_match_feedback1(left, right),
					  keep (1),
					  left outer,
					  local);


//----Match to feeback by did and phone7
phplus_in_d2:=  distribute(match_feedback1, hash((unsigned)did));

recordof(phplus_in) t_match_feedback2(phplus_in_d2 le, Feedback_d2 ri) := transform
	self.append_feedback_phone7_did			:= if(ri.did > 0 and le.pdid = 0 and ri.phone_number <> '' ,ri.phone_contact_type,'');
	self.append_feedback_phone7_did_dt	:= if(ri.did > 0 and le.pdid = 0 and ri.phone_number <> '' ,(unsigned)phonesFeedback.dateMMMDDYYYY(trim(ri.date_time_added,left,right))[..8],0);;
	self:= le;
end;

match_feedback2 := join(phplus_in_d2, 
				      Feedback_d2,
					  (unsigned)left.did = (unsigned)right.did and
					  left.pdid = 0 and
					  left.phone7 = right.phone_number[length(trim(right.phone_number,all)) - 6 ..length(trim(right.phone_number,all))],
					  t_match_feedback2(left, right),
					  keep (1),
					  left outer,
					  local);

//----Match to feeback by name and address and phone7				  
phplus_in_d3:=  distribute(match_feedback2, hash(trim(lname, left, right), trim(prim_range, left, right), trim(prim_name, left, right), trim(zip5, left, right)));

recordof(phplus_in) t_match_feedback3(phplus_in_d3 le, Feedback_d3 ri) := transform
	self.append_feedback_phone7_nm_addr := if(ri.lname <> '' and ri.phone_number <> '',ri.phone_contact_type,'');
	self.append_feedback_phone7_nm_addr_dt		:= if(ri.lname <> '' and ri.phone_number <> '',(unsigned)phonesFeedback.dateMMMDDYYYY(trim(ri.date_time_added,left,right))[..8],0);
	self:= le;
end;

match_feedback3 := join(phplus_in_d3, 
				      Feedback_d3,
					  trim(left.lname, left, right) = trim(right.lname, left, right) and
					  trim(left.prim_range, left, right) = trim(right.street_number, left, right) and
					  trim(left.prim_name, left, right) = trim(right.street_name, left, right) and
					  trim(left.zip5, left, right) = trim(right.zip5, left, right) and
					  left.phone7 = right.phone_number[length(trim(right.phone_number,all)) - 6 ..length(trim(right.phone_number,all))],
					  t_match_feedback3(left, right),
					  keep (1),
					  left outer,
					  local);

return match_feedback3;

end;