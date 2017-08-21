import header,ln_property,LN_PropertyV2 ;

export V1_to_V2_LN_search(dataset(recordof(LN_Property.Layout_Deed_Mortgage_Property_Search)) inSearchV1,
                      dataset(recordof(LN_PropertyV2.Layout_Deed_Mortgage_Common_Model_BASE)) inDeedsV2,
                      dataset(recordof(LN_PropertyV2.layout_property_common_model_base)) inAssessorV2
					  	  ) := function

/*
inSearchV1     := dataset(ln_property.filenames.inSearch, LN_Property.Layout_Deed_Mortgage_Property_Search, thor); 
inSearchReplV1 := dataset(ln_property.filenames.inSearchRepl, LN_Property.Layout_Deed_Mortgage_Property_Search, thor); 

inAssessorV2 := dataset(ln_propertyV2.filenames.inAssessor, LN_PropertyV2.Layout_Property_Common_Model_BASE, thor);
inAssessorReplV2 := dataset(ln_propertyV2.filenames.inAssessorRepl, LN_PropertyV2.Layout_Property_Common_Model_BASE, thor); 

inDeedsV2     := dataset(ln_propertyV2.filenames.inDeeds, LN_PropertyV2.Layout_Deed_Mortgage_Common_Model_BASE, thor); 
*/
//slim the assessor rec to id,phone, date
assessor_slim_rec := record
	inAssessorV2.ln_fares_id;
	inAssessorV2.assessee_phone_number;
	inAssessorV2.tax_year;
	inAssessorV2.recording_date;
	inAssessorV2.sale_date;
	inAssessorV2.process_date;
	inAssessorV2.vendor_source_flag;
end;

assessor_slim := table(inAssessorV2, assessor_slim_rec);

//slim the deeds rec to id, date
deed_slim_rec := record
	inDeedsV2.ln_fares_id;
	inDeedsV2.recording_date;
	inDeedsV2.process_date;
	inDeedsV2.vendor_source_flag;
	inDeedsV2.phone_number;

end;

deed_slim := table(inDeedsV2, deed_slim_rec);

//append the data and transform to a header type rec
sear_dist := distribute(inSearchV1, hash(ln_fares_id));
asse_dist := distribute(assessor_slim, hash(ln_fares_id));
deed_dist := distribute(deed_slim, hash(ln_fares_id));

LN_PropertyV2.Layout_Deed_Mortgage_Property_Search add_asse(sear_dist l, asse_dist r) := transform
	
	//same for seller and buyer
	self.dt_first_seen := (unsigned3)(map(l.source_code[2]='O' => (r.tax_year + '00'),
	 					 (integer)r.recording_date > 19000000 => (r.recording_date[1..6]), 
						      (integer)r.sale_date >      19000000 => (r.sale_date[1..6]),
							  (r.tax_year + '00')));
	//tax year for buyer
	self.dt_last_seen :=  (unsigned3)(if(l.source_code[1] = 'O',   
							 // when buyer
							 (r.tax_year + '00'),
							 // when seller
							 if((integer)r.recording_date > 19000000, (r.recording_date[1..6]), (r.sale_date[1..6]))));
	self.dt_vendor_last_reported := (unsigned3)(r.process_date[1..6]);
	self.dt_vendor_first_reported := (unsigned3)(r.process_date[1..6]);
	self.phone_number := if((integer)r.assessee_phone_number > 0 and l.source_code[1] = 'O', r.assessee_phone_number, '');
	self.conjunctive_name_seq := '' ;
	self := l;
end;

two := join(sear_dist, asse_dist, left.ln_fares_id = right.ln_fares_id,
			add_asse(left, right),local);



		
LN_PropertyV2.Layout_Deed_Mortgage_Property_Search add_deed(sear_dist l, deed_dist r) := transform
	self.dt_first_seen := (unsigned3)(r.recording_date[1..6]);
	self.dt_last_seen := (unsigned3)(r.recording_date[1..6]);
	self.dt_vendor_last_reported := (unsigned3)(r.process_date[1..6]);
	self.dt_vendor_first_reported := (unsigned3)(r.process_date[1..6]);
	self.phone_number := if((integer)r.phone_number > 0 and l.source_code[1] = 'O', r.phone_number, '');
	self.conjunctive_name_seq := '' ;

	self := l;
end;

three := join(sear_dist, deed_dist, left.ln_fares_id = right.ln_fares_id,
			  add_deed(left, right), local);
			  					  
/*
LN_PropertyV2.Layout_Deed_Mortgage_Property_Search easy_way(three l) := transform
	self.dt_vendor_first_reported := l.dt_first_seen;
	self.dt_last_seen := if(l.dt_last_seen < l.dt_first_seen, l.dt_first_seen, l.dt_last_seen);
	self.dt_vendor_last_reported := self.dt_last_seen;
	self := l;
end;

final := project(three, easy_way(left));
*/
final := two + three;

return final;

end;
