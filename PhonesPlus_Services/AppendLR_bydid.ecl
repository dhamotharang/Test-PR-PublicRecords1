import phonesPlus_v2,doxie,ut,Phones;
LR_index_did := Phonesplus_v2.Key_Royalty_Did;

export AppendLR_bydid(dataset(doxie.layout_references) in_dids,
          string data_restriction_mask = '') := function
doxie.MAC_Header_Field_Declare();	
	
doxie.layout_pp_raw_common LR_trans(recordof(LR_index_did) l) := transform
     
	dls_value := if(l.datelastseen=0, l.datevendorlastreported, l.datelastseen);
	
  self.vendor_id := l.vendor;
  self.src :=  l.src;
	self.tnt :=  '';
	self.ssn := '';
	self.phone := l.cellphone;
	self.listing_type_res := if(trim(l.ListingType, left, right) in ['R','BR','RS','RG','RB'],'R','');	//RG and RB were added for Wired Assets
  self.listing_type_bus := if(trim(l.ListingType, left, right) in ['B','BG','BR','RB'],'B','');
  self.listing_type_gov := if(trim(l.ListingType, left, right) in ['G','BG','RG'],'G','');
	self.dt_last_seen := ut.date6_to_date8(dls_value);
	self.dt_first_seen := ut.date6_to_date8(if(l.datefirstseen<=dls_value, l.datefirstseen, 0));
	self.dob := (integer4)l.dob;
	self.suffix := l.addr_suffix;
	self.city_name := l.p_city_name;
	self.st := l.state;
	self.zip := l.zip5;
	self.vendor_dt_last_seen_used := if(l.datelastseen=0 and l.datevendorlastreported <>0,
	                                    true, false);
	self.penalt := doxie.FN_Tra_Penalty(l.fname,l.mname,l.lname,
                             '',(string)l.dob,(string)l.did,
                             l.predir,l.prim_range,l.prim_name,l.addr_suffix,l.postdir,l.sec_range,
                             l.p_city_name,'',l.state,l.zip5,
                             l.cellphone);
																			
	self := l;
end;

 	LR_results := join(in_dids,LR_index_did,
                         keyed(left.did = right.l_did) and right.confidencescore >= 11
																									and (~Phones.Functions.isPhoneRestricted(right.origstate, 
																															 glb_purpose,
																															 dppa_purpose,
																															 industry_class_value,
																															 , //checkRNA
																															 right.datefirstseen,
																															 right.dt_nonglb_last_seen,
																															 right.rules,
																															 right.src_all,
																															 data_restriction_mask)), 
    	                 LR_trans(right), limit(ut.limits.PHONE_PER_PERSON, skip));
											 
	final_results:= LR_results(penalt<score_threshold_value);
	// output(final_results,named('final_results'));
	return final_results;
END;