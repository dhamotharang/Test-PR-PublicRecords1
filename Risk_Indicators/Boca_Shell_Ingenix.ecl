import risk_indicators, riskwise, doxie_files, ingenix_natlprof;

EXPORT Boca_Shell_Ingenix(GROUPED DATASET(risk_indicators.Layout_Boca_Shell_ids) ids_only) := FUNCTION

temp := record
	risk_indicators.Layout_Boca_Shell_ids;
	unsigned providerid := 0;
	UNSIGNED6 SancID := 0;
	string licensenumber := '';
	unsigned speciality_date_first_reported := 0;
	unsigned speciality_date_last_reported := 0;
	
	risk_indicators.layouts.layout_ingenix_summary;
	string license_st := '';
end;

with_provider_ids := join(ids_only, doxie_files.key_provider_did,
													left.did<>0 and	keyed(left.did=right.l_did),
													transform(temp, 
														self.providerid := right.providerid;
														self := left), atmost(riskwise.max_atmost), keep(100));

with_providers := join(with_provider_ids, ingenix_natlprof.key_license_providerid,
	left.providerid<>0 and
	keyed(left.providerid=right.l_providerid) and
	(unsigned)right.dt_vendor_first_reported[1..6] < left.historydate ,
transform(temp,
	self.provider_date_first_reported := (unsigned)right.dt_vendor_first_reported;
	self.provider_date_last_reported := (unsigned)right.dt_vendor_last_reported;
	self.provider_effective_date := (unsigned)right.effective_date;
	self.provider_termination_date := (unsigned)right.termination_date;
	self.provider_license_count := if(trim(right.licensenumber)<>'', 1, 0);
	self.licensenumber := right.licensenumber;
	self.license_st := right.licensestate;
	self := left;
), atmost(riskwise.max_atmost), keep(100) );
	

// rollup the dates per license to get to 1 record per license and tell which license is most recent
sorted_licenses := sort(with_providers, seq, licensenumber, provider_date_first_reported, -provider_date_last_reported, license_st);
rolled_licenses := rollup(sorted_licenses, left.seq=right.seq and left.licensenumber=right.licensenumber,
	transform(temp,
	self.provider_date_first_reported := if(left.provider_date_first_reported<right.provider_date_first_reported and left.provider_date_first_reported<>0, left.provider_date_first_reported, right.provider_date_first_reported);
	self.provider_date_last_reported := if(left.provider_date_last_reported>right.provider_date_last_reported, left.provider_date_last_reported, right.provider_date_last_reported);
	self.provider_effective_date := if(left.provider_effective_date<right.provider_effective_date and left.provider_effective_date<>0, left.provider_effective_date, right.provider_effective_date);
	self.provider_termination_date := if(left.provider_termination_date>right.provider_termination_date, left.provider_termination_date, right.provider_termination_date);
	self.licensenumber := right.licensenumber;
	self.license_st := right.license_st;
	self := left));

sorted_providers := sort(rolled_licenses, seq, -provider_effective_date, -provider_termination_date, licensenumber, license_st);
rolled_providers := rollup(sorted_providers, left.seq=right.seq,
	transform(temp,
	self.provider_license_count := left.provider_license_count + right.provider_license_count;
	self.provider_date_first_reported := if(left.provider_date_first_reported<right.provider_date_first_reported and left.provider_date_first_reported<>0, left.provider_date_first_reported, right.provider_date_first_reported);
	self.provider_date_last_reported := if(left.provider_date_last_reported>right.provider_date_last_reported, left.provider_date_last_reported, right.provider_date_last_reported);
	
	// keep the most recent effective_date, termination_date and license number to check sanctions later 
	self.provider_effective_date := left.provider_effective_date;
	self.provider_termination_date := left.provider_termination_date;
	self.licensenumber := left.licensenumber;
	self.license_st := left.license_st;
	self := left));

with_provider_specialities := join(with_provider_ids, ingenix_natlprof.key_speciality_providerid,
	left.providerid<>0 and
	keyed(left.providerid=right.l_providerid) and
	(unsigned)right.dt_vendor_first_reported[1..6] < left.historydate ,
transform(temp,	
	self.speciality_date_first_reported := (unsigned)right.dt_vendor_first_reported;
	self.speciality_date_last_reported := (unsigned)right.dt_vendor_last_reported;
	self.most_recent_speciality_type := right.filetyp;
	self.most_recent_speciality_name := right.specialityname;
	self.unique_specialties_count := if(right.specialityname<>'', 1, 0);
	self := left;
), atmost(riskwise.max_atmost), keep(100), left outer );
	

// count up the unique specialities and return the most recent
unique_specialities := rollup(sort(with_provider_specialities, seq, -most_recent_speciality_name, -speciality_date_first_reported, -speciality_date_last_reported),
	left.seq=right.seq and left.most_recent_speciality_name=right.most_recent_speciality_name,
	transform(temp,
		self.speciality_date_first_reported := if(left.speciality_date_first_reported < right.speciality_date_first_reported, left.speciality_date_first_reported, right.speciality_date_first_reported);
		self.speciality_date_last_reported := if(left.speciality_date_last_reported > right.speciality_date_last_reported, left.speciality_date_last_reported, right.speciality_date_last_reported);
		self := left;
		));

rolled_specialities := rollup(sort(unique_specialities, seq,  -speciality_date_first_reported, -speciality_date_last_reported, -most_recent_speciality_name),
	left.seq=right.seq,
	transform(temp,
		self.unique_specialties_count := left.unique_specialties_count + right.unique_specialties_count;
		self.speciality_date_first_reported := if(left.speciality_date_first_reported < right.speciality_date_first_reported, left.speciality_date_first_reported, right.speciality_date_first_reported);
		self.speciality_date_last_reported := if(left.speciality_date_last_reported > right.speciality_date_last_reported, left.speciality_date_last_reported, right.speciality_date_last_reported);
		self := left;
		));
		
// right now, they don't care about the medical school information, they just want to plug ingenix into existing shell fields.
// will leave this in here in case they change their minds again
// with_medical_school := join(with_provider_ids, ingenix_natlprof.key_medschool_providerid,
	// left.providerid<>0 and
	// keyed(left.providerid=right.l_providerid) and
	// (unsigned)right.dt_vendor_first_reported[1..6] < left.historydate ,
// transform(temp,	
	// self.Medical_school_record_found := right.l_providerid<>0;
	// self := left),
	// atmost(riskwise.max_atmost), keep(1)) ;
	

// put specialities, medical school, and providers results together
provider_details := join(rolled_providers, rolled_specialities, left.seq=right.seq,
	transform(temp,
		self.most_recent_speciality_type := right.most_recent_speciality_type;
		self.most_recent_speciality_name := right.most_recent_speciality_name;
		self.unique_specialties_count := right.unique_specialties_count;
		self.speciality_date_first_reported := right.speciality_date_first_reported;
		self.speciality_date_last_reported := right.speciality_date_last_reported;

		self := left),
		left outer, keep(1));
		
// provider_details := join(provider_details1, with_medical_school, left.seq=right.seq and right.Medical_school_record_found,
	// transform(temp,
		// self.Medical_school_record_found := right.Medical_school_record_found;
		// self := left),
		// left outer, keep(1));
	
with_sanction_ids := JOIN(provider_details, doxie_files.key_sanctions_did, 
												LEFT.did <> 0 AND KEYED(LEFT.did = RIGHT.l_did), 
											TRANSFORM(temp, SELF.SancID := (UNSIGNED6)RIGHT.sanc_id; SELF := LEFT),  
											ATMOST(RiskWise.max_atmost), KEEP(100), left outer);

with_sanctions := join(with_sanction_ids, doxie_files.key_sanctions_sancid,
	KEYED(LEFT.sancid = RIGHT.l_sancid) and
	(unsigned)right.date_first_seen < (unsigned)risk_indicators.iid_constants.mygetdate(left.historydate),
	transform(temp,
		self.sanctions_count := if(right.l_sancid<>0, 1, 0);
		self.sanctions_date_first_seen := (unsigned)right.date_first_seen;
		self.sanctions_date_last_seen := (unsigned)right.date_last_seen;
		self.most_recent_sanction_type := right.sanc_type;
		self.most_recent_license_revoked := trim(left.licensenumber)<>'' and right.l_sancid<>0 and 
																				stringlib.stringfind(left.licensenumber, right.sanc_licnbr, 1) > 0;
		self := left), 
		atmost(riskwise.max_atmost), left outer, keep(1));

sanctions_sorted := sort(with_sanctions, seq, -sanctions_date_last_seen, -sanctions_date_first_seen);

rolled_sanctions := rollup(with_sanctions, left.seq=right.seq, 
	transform(temp,
		self.sanctions_count := left.sanctions_count + right.sanctions_count;
		self.sanctions_date_first_seen := min(left.sanctions_date_first_seen, right.sanctions_date_first_seen);
		self.sanctions_date_last_seen := max(left.sanctions_date_last_seen, right.sanctions_date_last_seen); 
		self.most_recent_sanction_type := left.most_recent_sanction_type;
		self.most_recent_license_revoked := left.most_recent_license_revoked or right.most_recent_license_revoked;
		self := left));

// output(ids_only, named('ids_only'));
// output(with_provider_ids, named('with_provider_ids'));
// output(with_providers, named('with_providers'));
// output(rolled_licenses, named('rolled_licenses'));
// output(rolled_providers, named('rolled_providers'));
// output(with_provider_specialities, named('with_provider_specialities'));
// output(unique_specialities, named('unique_specialities'));
// output(rolled_specialities, named('rolled_specialities'));
// output(with_medical_school, named('with_medical_school'));
// output(provider_details1, named('provider_details1'));
// output(provider_details, named('provider_details'));		
// output(with_sanction_ids, named('with_sanction_ids'));
// output(with_sanctions, named('with_sanctions'));
// output(rolled_sanctions, named('rolled_sanctions'));

return rolled_sanctions;

end;