ds := dataset('~thor_data400::in::ln_propertyv2::irs.search.new', LN_PropertyV2.Layouts.PreProcess_Search_Layout, flat);

	LN_PropertyV2.Layout_DID_Out searchCmTran(LN_PropertyV2.Layouts.PreProcess_Search_Layout l) := transform
		self.ln_party_status := '';
		self.ln_percentage_ownership := '';
		self.ln_entity_type := '';
		self.ln_estate_trust_date := '';
		self.ln_goverment_type := '';
		self.nid := 0;
		self.xadl2_weight := 0;
		self := l;
	end;
	
export irs_dummy_recs_search := project(ds, searchCmTran(left));
/*
// search conversion

 inSearchV1 := LN_Property.irs_dummy_recs_search;
 output(inSearchV1);
 inDeedsV2 := dataset('~thor_data400::in::ln_propertyv2::irs.Deed',LN_PropertyV2.layout_deed_mortgage_common_model_base,flat);
 inAssessorV2 := dataset('~thor_data400::in::ln_propertyv2::irs.Assessor',LN_PropertyV2.layout_property_common_model_base,flat);
					  	

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

LN_PropertyV2.Layout_DID_Out add_asse(sear_dist l, asse_dist r) := transform
	
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
	self.app_ssn := '';
	self.app_tax_id := '';
	self := l;
end;

two := join(sear_dist, asse_dist, left.ln_fares_id = right.ln_fares_id,
			add_asse(left, right),local);



		
LN_PropertyV2.Layout_DID_Out add_deed(sear_dist l, deed_dist r) := transform
	self.dt_first_seen := (unsigned3)(r.recording_date[1..6]);
	self.dt_last_seen := (unsigned3)(r.recording_date[1..6]);
	self.dt_vendor_last_reported := (unsigned3)(r.process_date[1..6]);
	self.dt_vendor_first_reported := (unsigned3)(r.process_date[1..6]);
	self.phone_number := if((integer)r.phone_number > 0 and l.source_code[1] = 'O', r.phone_number, '');
	self.conjunctive_name_seq := '' ;
    self.app_ssn := '';
	self.app_tax_id := '';
	self := l;
end;

three := join(sear_dist, deed_dist, left.ln_fares_id = right.ln_fares_id,
			  add_deed(left, right), local);
 
out := two + three ; 
//output(out);
output(out ,, '~thor_data400::in::ln_propertyv2::irs.search',overwrite);*/ 
