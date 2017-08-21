import ln_propertyv2;
EXPORT Convert_Property(string infiledate) := module

	searchds := dataset('~thor_data400::in::override::fcra::'+infiledate+'::flag',fcra.Layout_override_flag,flat,opt)(file_id = 'property');

	property_search := Ln_propertyv2.key_search_fid(true);



	fcra.Layout_override_flag proj_recs(searchds l,property_search r) := transform
		self.file_id := 'property_search';
		self.record_id := (string100)r.persistent_record_id;
		self := l;
	end;

	export flag_search := join(searchds,property_search,
										keyed(trim(left.record_id,left,right) = right.ln_fares_id),
										proj_recs(left,right));
	
		
	deedds := dataset('~thor_data400::in::override::fcra::'+infiledate+'::flag',fcra.Layout_override_flag,flat,opt)(file_id = 'property');

	property_deed := Ln_propertyv2.key_deed_fid(true);

	fcra.Layout_override_flag proj_recs(deedds l,property_deed r) := transform
		self.file_id := 'deed';
		//	self.record_id := (string100)r.persistent_record_id;
		self := l;
	end;

	flag_deed := join(deedds,property_deed,
										keyed(trim(left.record_id,left,right) = right.ln_fares_id),
										proj_recs(left,right));
										
	
	assessmentds := dataset('~thor_data400::in::override::fcra::'+infiledate+'::flag',fcra.Layout_override_flag,flat,opt)(file_id = 'property');

	property_assessment := Ln_propertyv2.key_assessor_fid(true);

	fcra.Layout_override_flag proj_recs(assessmentds l,property_assessment r) := transform
		self.file_id := 'assessment';
	//	self.record_id := (string100)r.persistent_record_id;
		self := l;
	end;

	flag_assessment := join(assessmentds,property_assessment,
										keyed(trim(left.record_id,left,right) = right.ln_fares_id),
										proj_recs(left,right));
						
	
end;