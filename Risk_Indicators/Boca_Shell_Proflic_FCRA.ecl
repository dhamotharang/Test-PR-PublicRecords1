import _Control, prof_licenseV2, FCRA, riskwise, ut, RiskView;
onThor := _Control.Environment.OnThor;

export Boca_Shell_Proflic_FCRA(GROUPED DATASET(Risk_Indicators.Layout_Boca_Shell_ids) ids_only, integer bsversion, 
				boolean isPrescreen, boolean isDirectToConsumerPurpose = false) := FUNCTION

string8 proflic_build_date := Risk_Indicators.get_Build_date('proflic_build_version');
myGetDate := proflic_build_date;
checkDays(string8 d1, string8 d2, unsigned2 days) := ut.DaysApart(d1,d2) <= days and d1>d2;

PL_Plus_temp := record
	string source_st;
	string license_number;
	string license_number_cleaned;
	RiskWise.Layouts.Layout_Professional_License_Plus;
	unsigned tmp_MostRecent; //as need to perserve the date in the data for output
end;

PL_Plus_temp PL_corr(ids_only le, FCRA.key_override_proflic_ffid rt) := transform
		hit := trim(rt.prolic_key)!='';	// check to see that we have a good record
		
		self.prolic_key := rt.prolic_key;
		self.date_first_seen := if(hit, rt.date_first_seen, '');
		self.professional_license_flag := hit;
		self.source_st := if(hit, rt.source_st, '');
		
		license_type := if(hit, rt.license_type, '');
		self.license_type := license_type;
		self.jobCategory := Risk_Indicators.getPLinfo(license_type).jobCategory;
		self.PLcategory := Risk_Indicators.getPLinfo(license_type).PLcategory;
		expire_date := if(hit, (unsigned)rt.expiration_date, 0);
    isExpired := expire_date<(unsigned)myGetDate and expire_date<>0;
		
		self.proflic_count := if(hit and ~isExpired, 1, 0);
		self.proflic_count30 := if(hit and checkDays(myGetDate,rt.date_last_seen,30), 1, 0);
		self.proflic_count90 := if(hit and checkDays(myGetDate,rt.date_last_seen,90), 1, 0);
		self.proflic_count180 := if(hit and checkDays(myGetDate,rt.date_last_seen,180), 1, 0);
		self.proflic_count12 := if(hit and checkDays(myGetDate,rt.date_last_seen,ut.DaysInNYears(1)), 1, 0);
		self.proflic_count24 := if(hit and checkDays(myGetDate,rt.date_last_seen,ut.DaysInNYears(2)), 1, 0);
		self.proflic_count36 := if(hit and checkDays(myGetDate,rt.date_last_seen,ut.DaysInNYears(3)), 1, 0);
		self.proflic_count60 := if(hit and checkDays(myGetDate,rt.date_last_seen,ut.DaysInNYears(5)), 1, 0);
		
		self.expire_count30 := if(hit and isExpired and checkDays(myGetDate,rt.expiration_date,30), 1, 0);
		self.expire_count90 := if(hit and isExpired and checkDays(myGetDate,rt.expiration_date,90), 1, 0);
		self.expire_count180 := if(hit and isExpired and checkDays(myGetDate,rt.expiration_date,180), 1, 0);
		self.expire_count12 := if(hit and isExpired and checkDays(myGetDate,rt.expiration_date,ut.DaysInNYears(1)), 1, 0);
		self.expire_count24 := if(hit and isExpired and checkDays(myGetDate,rt.expiration_date,ut.DaysInNYears(2)), 1, 0);
		self.expire_count36 := if(hit and isExpired and checkDays(myGetDate,rt.expiration_date,ut.DaysInNYears(3)), 1, 0);
		self.expire_count60 := if(hit and isExpired and checkDays(myGetDate,rt.expiration_date,ut.DaysInNYears(5)), 1, 0);	
		
		self.date_most_recent := if(hit, (unsigned)rt.date_last_seen, 0);// seems to be the issue date, should we check prolic_key<>'' here?
		self.expiration_date := if(hit, (unsigned)rt.expiration_date, 0);//should we check prolic_key<>'' here?
		self.proflic_source := if(hit, 'PL', '');	
		self.license_number := if(hit, rt.license_number, '');	
		self.license_number_cleaned := if(hit, Risk_Indicators.iid_constants.stripLeadingZeros(rt.license_number), '');		
		self.proflic_build_date := proflic_build_date;
		self.tmp_MostRecent := self.date_most_recent;
		self := le;
		self := [];  // sanctions are not pop in FCRA
end;
PL_correct_roxie := join(ids_only, FCRA.key_override_proflic_ffid,
										keyed(right.flag_file_id in left.proflic_correct_ffid) and
										(isDirectToConsumerPurpose = false or (
											isDirectToConsumerPurpose = true and StringLib.StringToUpperCase(trim(right.vendor)) != trim(RiskView.Constants.directToConsumerPL_sources))),
										PL_corr(left, right),left outer, atmost(right.flag_file_id in left.proflic_correct_ffid, 100));

PL_correct_thor := join(ids_only, pull(FCRA.key_override_proflic_ffid),
										right.flag_file_id in left.proflic_correct_ffid and
										(isDirectToConsumerPurpose = false or (
											isDirectToConsumerPurpose = true and StringLib.StringToUpperCase(trim(right.vendor)) != trim(RiskView.Constants.directToConsumerPL_sources))),
										PL_corr(left, right),left outer, LOCAL, ALL);
										
#IF(onThor)
	PL_correct := PL_correct_thor;
#ELSE
	PL_correct := PL_correct_roxie;
#END

key_did := prof_licenseV2.Key_Proflic_Did (true);

PL_Plus_temp PL_FCRA(PL_correct le, key_did rt) := transform
		hit := trim(rt.prolic_key)!='';	// check to see that we have a good record

		self.prolic_key := rt.prolic_key;
		self.professional_license_flag := hit;
		self.source_st := if(hit, rt.source_st, '');
		
		license_type := if(hit, rt.license_type, '');
		self.license_type := license_type;
		self.jobCategory := Risk_Indicators.getPLinfo(license_type).jobCategory;
		self.PLcategory := Risk_Indicators.getPLinfo(license_type).PLcategory;
		expire_date := if(hit, (unsigned)rt.expiration_date, 0);
    isExpired := expire_date<(unsigned)myGetDate and expire_date<>0;
	
		self.proflic_count := if(hit and ~isExpired, 1, 0);
		self.proflic_count30 := if(hit and checkDays(myGetDate,rt.date_last_seen,30), 1, 0);
		self.proflic_count90 := if(hit and checkDays(myGetDate,rt.date_last_seen,90), 1, 0);
		self.proflic_count180 := if(hit and checkDays(myGetDate,rt.date_last_seen,180), 1, 0);
		self.proflic_count12 := if(hit and checkDays(myGetDate,rt.date_last_seen,ut.DaysInNYears(1)), 1, 0);
		self.proflic_count24 := if(hit and checkDays(myGetDate,rt.date_last_seen,ut.DaysInNYears(2)), 1, 0);
		self.proflic_count36 := if(hit and checkDays(myGetDate,rt.date_last_seen,ut.DaysInNYears(3)), 1, 0);
		self.proflic_count60 := if(hit and checkDays(myGetDate,rt.date_last_seen,ut.DaysInNYears(5)), 1, 0);
		
		self.expire_count30 := if(hit and isExpired and checkDays(myGetDate,rt.expiration_date,30), 1, 0);
		self.expire_count90 := if(hit and isExpired and checkDays(myGetDate,rt.expiration_date,90), 1, 0);
		self.expire_count180 := if(hit and isExpired and checkDays(myGetDate,rt.expiration_date,180), 1, 0);
		self.expire_count12 := if(hit and isExpired and checkDays(myGetDate,rt.expiration_date,ut.DaysInNYears(1)), 1, 0);
		self.expire_count24 := if(hit and isExpired and checkDays(myGetDate,rt.expiration_date,ut.DaysInNYears(2)), 1, 0);
		self.expire_count36 := if(hit and isExpired and checkDays(myGetDate,rt.expiration_date,ut.DaysInNYears(3)), 1, 0);
		self.expire_count60 := if(hit and isExpired and checkDays(myGetDate,rt.expiration_date,ut.DaysInNYears(5)), 1, 0);
		self.date_first_seen := if(hit, rt.date_first_seen, '');
		
		self.date_most_recent := if(hit, (unsigned)rt.date_last_seen, 0);// seems to be the issue date, should we check prolic_key<>'' here?
		self.expiration_date := if(hit, (unsigned)rt.expiration_date, 0);//should we check prolic_key<>'' here?

		self.license_number := if(hit, rt.license_number, '');	
		self.license_number_cleaned := if(hit, Risk_Indicators.iid_constants.stripLeadingZeros(rt.license_number), '');	
		self.tmp_MostRecent := self.date_most_recent;
		self.proflic_source := if(hit, 'PL', '');	
		self := le;
		self := [];  // sanctions are not pop in FCRA
end;
license_recs1_roxie := join(PL_correct, key_did,
											left.did!=0 and left.prolic_key<>right.prolic_key and left.date_first_seen<>right.date_first_seen and
											keyed(right.did = left.did) AND
											(isDirectToConsumerPurpose = false or (
											 isDirectToConsumerPurpose = true and StringLib.StringToUpperCase(trim(right.vendor)) != trim(RiskView.Constants.directToConsumerPL_sources))),
											PL_FCRA(left,right), left outer, atmost(right.did = left.did, riskwise.max_atmost));

license_recs1_thor_did := join(distribute(PL_correct(did!=0), hash64(did)), 
											distribute(pull(key_did), hash64(did)),
											left.prolic_key<>right.prolic_key and left.date_first_seen<>right.date_first_seen and
											(right.did = left.did) AND
											(isDirectToConsumerPurpose = false or (
											 isDirectToConsumerPurpose = true and StringLib.StringToUpperCase(trim(right.vendor)) != trim(RiskView.Constants.directToConsumerPL_sources))),
											PL_FCRA(left,right), left outer, atmost(right.did = left.did, riskwise.max_atmost), LOCAL);
		
license_recs1_thor := license_recs1_thor_did + PL_correct(did=0);

#IF(onThor)
	license_recs_original := ungroup(PL_correct + license_recs1_thor);
#ELSE
	license_recs_original := ungroup(PL_correct + license_Recs1_roxie);
#END

isFCRA := true;

mari_data := risk_indicators.Boca_Shell_Mari(ids_only, isFCRA, isPreScreen);

// initially not so sure we trust the dates on the MARI file to be accurate.  
// ie, date_first_seen is newer than the expire date
mari_recs := join (ids_only, mari_data,
		left.seq=right.seq,
		transform (PL_Plus_temp, 					
			hit := trim(right.license_nbr)!='';	// check to see that we have a good record
			myGetDate := Risk_Indicators.iid_constants.myGetDate(left.historydate);
			self.prolic_key := right.license_nbr;
			self.date_first_seen := if(hit, (string)right.date_first_seen, '');
			self.professional_license_flag := hit;
			license_type := if(hit, right.most_recent_license_type, '');
			self.license_type := license_type;
			self.jobCategory := Risk_Indicators.getPLinfo(license_type).jobCategory;
			self.PLcategory := Risk_Indicators.getPLinfo(license_type).PLcategory;
			self.proflic_count := if(hit and right.expiration_date>=(unsigned)myGetDate, 1, 0);	
			self.date_most_recent := if(hit, right.date_first_seen, 0);
			self.tmp_MostRecent := (unsigned) self.date_most_recent;	
			self.expiration_date := if(hit, right.expiration_date, 0);
			self.proflic_source := if(hit, 'PM', '');	
			self.source_st := if(hit, right.license_st, '');
			self.license_number := if(hit, right.license_nbr, ''); 
			self.license_number_cleaned := if(hit, Risk_Indicators.iid_constants.stripLeadingZeros(right.license_nbr), '');		
			self := left,
			self := []),
    atmost(riskwise.max_atmost),
		keep(100)
  );	


license_recs := map(
										bsversion>=50 and ~isPrescreen => ungroup(license_recs_original) + ungroup(mari_recs),
										ungroup(license_recs_original));

PL_Plus_temp roll_licenses(PL_Plus_temp le, PL_Plus_temp rt) := transform	
	self.professional_license_flag := le.professional_license_flag or rt.professional_license_flag;
	self.tmp_MostRecent :=  max(le.tmp_MostRecent,rt.tmp_MostRecent);
	self.expiration_date := max(le.expiration_date,rt.expiration_date);
	
	SameInfo := IF(le.did = rt.did and le.source_st = rt.source_st and 
		le.license_number_cleaned = rt.license_number_cleaned, true, false);	
	self.proflic_count := le.proflic_count +  IF(SameInfo, 0, rt.proflic_count);
	self.source_st := if(SameInfo, le.source_st, rt.source_st);
	self.license_number := if(SameInfo, le.license_number, rt.license_number);	
	self.license_number_cleaned := if(SameInfo, le.license_number_cleaned, rt.license_number_cleaned);	

	self.proflic_count30 := if(SameInfo,le.proflic_count30,max(le.proflic_count30,rt.proflic_count30));
	self.proflic_count90 := if(SameInfo,le.proflic_count90,max(le.proflic_count90,rt.proflic_count90));
	self.proflic_count180 := if(SameInfo,le.proflic_count180,max(le.proflic_count180,rt.proflic_count180));
	self.proflic_count12 := if(SameInfo,le.proflic_count12,max(le.proflic_count12,rt.proflic_count12));
	self.proflic_count24 := if(SameInfo,le.proflic_count24,max(le.proflic_count24,rt.proflic_count24));
	self.proflic_count36 := if(SameInfo,le.proflic_count36,max(le.proflic_count36,rt.proflic_count36));
	self.proflic_count60 := if(SameInfo,le.proflic_count60,max(le.proflic_count60,rt.proflic_count60));
	
	self.expire_count30 := if(SameInfo,le.expire_count30,max(le.expire_count30,rt.expire_count30));	
	self.expire_count90 := if(SameInfo,le.expire_count90,max(le.expire_count90,rt.expire_count90));
	self.expire_count180 := if(SameInfo,le.expire_count180,max(le.expire_count180,rt.expire_count180));
	self.expire_count12 := if(SameInfo,le.expire_count12,max(le.expire_count12,rt.expire_count12));
	self.expire_count24 := if(SameInfo,le.expire_count24,max(le.expire_count24,rt.expire_count24));
	self.expire_count36 := if(SameInfo,le.expire_count36,max(le.expire_count36,rt.expire_count36));
	self.expire_count60 := if(SameInfo,le.expire_count60,max(le.expire_count60,rt.expire_count60));
	
	side_to_use := if(le.license_type<>'', le, rt);
	self.license_type := side_to_use.license_type;	// keep the most current license type
	self.jobCategory := side_to_use.jobCategory;

  self.date_most_recent := max(le.date_most_recent,rt.date_most_recent);
	self.PLcategory := side_to_use.PLcategory;
	self.proflic_source := if(le.proflic_count<>0, le.proflic_source, rt.proflic_source);

	self := le;
end;

// rollup now by license_number and source_st instead of proflic_source and proflic_key
license_recs_true := license_recs(professional_license_flag = true);
license_recs_dates:= project(license_recs_true, transform(PL_Plus_temp, 
	self.tmp_MostRecent := if(LENGTH(trim((string8) left.date_most_recent)) < 8 and left.date_most_recent != 0,
		(unsigned)	(((string)left.date_most_recent)[1..6] + '01'), left.date_most_recent), self := left));
		

license_recs_good := sort(license_recs_dates, seq, did, -license_number_cleaned, source_st, -tmp_MostRecent, -proflic_count);

rolled_licenses_pre := rollup(group(license_recs_good, seq, did, license_number_cleaned, source_st), true, roll_licenses(left,right));	

LicenseType_Key := Prof_LicenseV2.Key_LicenseType_lookup(true);

PL_Plus_temp getv5category(rolled_licenses_pre le, LicenseType_Key ri) := transform
	self.jobCategory := ri.occupation;  
			self.PLcategory := if(trim(ri.category) != '', ri.category, '0');
	self := le;
END;

with_category_v5_roxie := join(rolled_licenses_pre, LicenseType_Key, 
		left.license_type<>'' and
		keyed(left.license_type=right.license_type), 	
			getv5category(LEFT,RIGHT), left outer, atmost(100), keep(1));
	
with_category_v5_thor := join(rolled_licenses_pre, pull(LicenseType_Key), 
		left.license_type<>'' and
		(left.license_type=right.license_type), 	
			getv5category(LEFT,RIGHT), left outer, atmost(100), keep(1), MANY LOOKUP);
			
#IF(onThor)
	with_category_v5 := with_category_v5_thor;
#ELSE
	with_category_v5 := with_category_v5_roxie;
#END

rolled_licenses := if(bsversion >= 4, with_category_v5, rolled_licenses_pre);

PL_Plus_temp roll_licenses2(PL_Plus_temp le, PL_Plus_temp rt) := transform
	self.proflic_count30 := le.proflic_count30+rt.proflic_count30;
	self.proflic_count90 := le.proflic_count90+rt.proflic_count90;
	self.proflic_count180 := le.proflic_count180+rt.proflic_count180;
	self.proflic_count12 := le.proflic_count12+rt.proflic_count12;
	self.proflic_count24 := le.proflic_count24+rt.proflic_count24;
	self.proflic_count36 := le.proflic_count36+rt.proflic_count36;
	self.proflic_count60 := le.proflic_count60+rt.proflic_count60;
	
	self.expire_count30 := le.expire_count30+rt.expire_count30;	
	self.expire_count90 := le.expire_count90+rt.expire_count90;
	self.expire_count180 := le.expire_count180+rt.expire_count180;
	self.expire_count12 := le.expire_count12+rt.expire_count12;
	self.expire_count24 := le.expire_count24+rt.expire_count24;
	self.expire_count36 := le.expire_count36+rt.expire_count36;
	self.expire_count60 := le.expire_count60+rt.expire_count60;
	
	self.professional_license_flag := le.professional_license_flag or rt.professional_license_flag;
	self.proflic_count := le.proflic_count+rt.proflic_count;
	side_to_use := if(rt.tmp_MostRecent > le.tmp_MostRecent OR 
		(le.tmp_MostRecent = rt.tmp_MostRecent AND rt.PLCategory > le.PLCategory), rt, le) ;

	self.date_most_recent := side_to_use.date_most_recent;// ut.max2(le.date_most_recent,rt.date_most_recent);
	self.tmp_MostRecent := max(le.tmp_MostRecent,rt.tmp_MostRecent);
	self.expiration_date := max(le.expiration_date,rt.expiration_date);
	self.license_type := if(le.license_type<>'', le.license_type, rt.license_type);	// keep the most current license type
	self.proflic_source := if(le.proflic_count<>0, le.proflic_source, rt.proflic_source);
	self := le;
end;

rolled_licenses2 := rollup(group(sort(ungroup(rolled_licenses), seq, -tmp_MostRecent, -PLCategory, prolic_key), seq), true, roll_licenses2(left,right));

rolled_licenses_final := project(rolled_licenses2, transform(RiskWise.Layouts.Layout_Professional_License_Plus, self := left));
// output(license_recs1, named('license_recs1'));
// output(PL_correct, named('PL_correct'));
// output(license_recs,NAMED('license_recs'));
// output(rolled_licenses_pre,NAMED('rolled_licenses_pre'));
// output(rolled_licenses,NAMED('rolled_licenses'));
// output(rolled_licenses2,NAMED('rolled_licenses2'));
// output(license_recs_good, named('license_recs_good'));
// output(mari_recs, named('mari_recs'));

return rolled_licenses_final;

end;