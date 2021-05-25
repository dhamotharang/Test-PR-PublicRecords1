import prof_licenseV2, riskwise, ut, risk_indicators, doxie, Suppress, _Control;
onThor := _Control.Environment.OnThor;

export Boca_Shell_Proflic(GROUPED DATASET(risk_indicators.Layout_Boca_Shell_ids) ids_only, 
integer bsVersion, 
unsigned1 LexIdSourceOptout = 1,
string TransactionID = '',
string BatchUID = '',
unsigned6 GlobalCompanyId = 0 ) := FUNCTION

   mod_access := MODULE(Doxie.IDataAccess)
      EXPORT unsigned1 lexid_source_optout := LexIdSourceOptout;
      EXPORT string transaction_id := TransactionID; // esp transaction id or batch uid
      EXPORT unsigned6 global_company_id := GlobalCompanyId; // mbs gcid
    END;

string8 proflic_build_date := Risk_Indicators.get_Build_date('proflic_build_version');

PL_Plus_temp := record
	string source_st;
	string license_number;
	string license_number_cleaned;
	RiskWise.Layouts.Layout_Professional_License_Plus;
	unsigned tmp_MostRecent; //as need to perserve the date in the data for output
end;

PL_Plus_temp_CCPA := record
    integer8 did; // CCPA changes
    unsigned4 global_sid; // CCPA changes
	PL_Plus_temp;
end;

checkDays(string8 d1, string8 d2, unsigned2 days) := ut.DaysApart(d1,d2) <= days and d1>d2;

key_did := prof_licenseV2.Key_Proflic_Did ();

PL_Plus_temp_CCPA PL_nonFCRA(ids_only le, key_did rt) := transform
	hit := trim(rt.prolic_key)!='';	// check to see that we have a good record
	earliest_date := min(proflic_build_date, risk_indicators.iid_constants.full_history_date(le.historydate));
	myGetDate := if(le.historydate=999999, proflic_build_date, earliest_date);

	self.prolic_key := rt.prolic_key;
	self.date_first_seen := if(hit, rt.date_first_seen, '');
	self.professional_license_flag := hit;
	self.source_st := if(hit, rt.source_st, '');
	self.license_type := if(hit, rt.license_type, '');
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

	self.date_most_recent := if(hit, (unsigned)rt.date_last_seen, 0);
	self.expiration_date := if(hit, (unsigned)rt.expiration_date, 0);
	self.proflic_source := if(hit, 'PL', '');
	self.proflic_build_date := proflic_build_date;
	self.license_number := if(hit, rt.license_number, '');		
	self.jobCategory := if(hit, risk_indicators.getPLinfo(rt.license_type).jobCategory, '');
	self.PLcategory := if(hit, risk_indicators.getPLinfo(rt.license_type).PLcategory, '');
	self.license_number_cleaned := if(hit, Risk_Indicators.iid_constants.stripLeadingZeros(rt.license_number), '');	
  self.tmp_MostRecent := self.date_most_recent;
    self.global_sid := rt.global_sid;
	self := le;
	self := [];  // setting sanctions to blank
end;

license_recs_original_join_roxie := join(ids_only, key_did,
                                         left.did!=0 and keyed(right.did = left.did) and
                                         (unsigned)right.date_first_seen[1..6] < left.historydate,
                                         PL_nonFCRA(left,right), atmost(right.did = left.did, riskwise.max_atmost));
                      
license_recs_original_join_thor := join(DISTRIBUTE(ids_only(did!=0), HASH64(did)), 
                                        DISTRIBUTE(PULL(key_did), HASH64(did)),
                                        right.did = left.did and
                                        (unsigned)right.date_first_seen[1..6] < left.historydate,
                                        PL_nonFCRA(left,right), atmost(right.did = left.did, riskwise.max_atmost), LOCAL);
                      
                      
#IF(onThor)
	license_recs_original_join_correct := license_recs_original_join_thor;
#ELSE
	license_recs_original_join_correct := license_recs_original_join_roxie;
#END
                      
license_recs_original_suppressed := Suppress.MAC_SuppressSource(license_recs_original_join_correct, mod_access);

license_recs_original_pre := PROJECT(license_recs_original_suppressed, TRANSFORM(PL_Plus_temp,
                                                  SELF := LEFT));
											
isFCRA := false;
isPrescreen := false;

mari_data := risk_indicators.Boca_Shell_Mari(ids_only, isFCRA, isPreScreen, mod_access);
ingenix_data := risk_indicators.Boca_Shell_Ingenix(ids_only);

// initially not so sure we trust the dates on the MARI file to be accurate.  
// ie, date_first_seen is newer than the expire date
mari_recs := join (ids_only, mari_data,
		left.seq=right.seq,
		transform (PL_Plus_temp, 			
			hit := trim(right.license_nbr)!='';	// check to see that we have a good record
			myGetDate := risk_indicators.iid_constants.myGetDate(left.historydate);
			self.prolic_key := right.license_nbr;
			self.date_first_seen := if(hit, (string)right.date_first_seen, '');
			self.professional_license_flag := hit;
			self.license_type := if(hit, right.most_recent_license_type, '');
			self.proflic_count := if(hit and right.expiration_date>=(unsigned)myGetDate, 1, 0);	
			self.date_most_recent := if(hit, right.date_first_seen, 0);
			self.expiration_date := if(hit, right.expiration_date, 0);
			self.proflic_source := if(hit, 'PM', '');
			self.source_st := if(hit, right.license_st, '');
			self.license_number := if(hit, right.license_nbr, ''); 	
			self.license_number_cleaned := if(hit, Risk_Indicators.iid_constants.stripLeadingZeros(right.license_nbr), '');	
			self.tmp_MostRecent := (unsigned) self.date_most_recent;	
			self := left,
			self := [];  // setting sanctions to blank
			),
    atmost(riskwise.max_atmost),
		keep(100)
  );

ingenix_recs := join (ids_only, ingenix_data,
		left.seq=right.seq,
		transform (PL_Plus_temp, 			
			hit := right.provider_license_count!=0;	// check to see that we have a good record
			myGetDate := risk_indicators.iid_constants.myGetDate(left.historydate);
			self.prolic_key := (string)right.provider_license_count;  //  only have 1 record returned from ingenix, just use the count here
			self.date_first_seen := if(hit, (string)right.provider_date_first_reported, '');
			self.professional_license_flag := hit;
			self.license_type := if(hit, right.most_recent_speciality_name, '');
			self.proflic_count := if(hit, 1, 0);	
			self.date_most_recent := if(hit, right.provider_date_first_reported, 0);
			self.expiration_date := if(hit, right.provider_termination_date, 0);
			self.proflic_source := if(hit, 'IN', '');	
			self.sanctions_count := if(hit, right.sanctions_count, 0);
			self.sanctions_date_first_seen := if(hit, right.sanctions_date_first_seen, 0);
			self.sanctions_date_last_seen :=if(hit, right.sanctions_date_last_seen, 0);
			self.most_recent_sanction_type := if(hit, right.most_recent_sanction_type, '');
			self.source_st := if(hit, right.license_st, '');
			self.license_number := if(hit, right.licensenumber, ''); 	
			self.license_number_cleaned := if(hit, Risk_Indicators.iid_constants.stripLeadingZeros(right.licensenumber), '');	
			self.tmp_MostRecent := (unsigned) self.date_most_recent;
			self := left),
    atmost(riskwise.max_atmost),
		keep(100)
  );
	
license_recs_original := map(
										bsversion>=50 => ungroup(license_recs_original_pre) + ungroup(mari_recs) + ungroup(ingenix_recs),
										ungroup(license_recs_original_pre));

klt := Prof_LicenseV2.Key_LicenseType_lookup(false);

PL_Plus_temp with_category_v5_transform(license_recs_original le, klt ri) := TRANSFORM
  self.jobCategory := ri.occupation;  
  self.PLcategory := if(trim(ri.category) != '', ri.category, '0');
  self := le;
END;

with_category_v5_roxie := JOIN(license_recs_original, klt, 
                               LEFT.license_type <> '' AND
                               KEYED(LEFT.license_type = RIGHT.license_type), 	
                               with_category_v5_transform(LEFT, RIGHT), 
                               LEFT OUTER, 
                               ATMOST(100), 
                               KEEP(1));

//10-8 remove filter from dataset                               
with_category_v5_thor := JOIN(DISTRIBUTE(license_recs_original, HASH64(license_type)), 
                              DISTRIBUTE(PULL(klt), HASH64(license_type)),
                              LEFT.license_type <> '' AND
                              LEFT.license_type = RIGHT.license_type, 	
                              with_category_v5_transform(LEFT, RIGHT), 
                              LEFT OUTER, 
                              ATMOST(100), 
                              KEEP(1), LOCAL);

#IF(onThor)
	with_category_v5_correct := with_category_v5_thor;
#ELSE
	with_category_v5_correct := with_category_v5_roxie;
#END

// with_category_v5 := join(license_recs_original, Prof_LicenseV2.Key_LicenseType_lookup(false), 
		// left.license_type<>'' and
		// keyed(left.license_type=right.license_type), 	
			// transform(PL_Plus_temp, 
			// self.jobCategory := right.occupation;  
			// self.PLcategory := if(trim(right.category) != '', right.category, '0');
			// self := left), left outer, atmost(100), keep(1));

license_recs := if(bsversion >= 4, with_category_v5_correct, ungroup(license_recs_original_pre));
			
PL_Plus_temp roll_licenses(PL_Plus_temp le, PL_Plus_temp rt) := transform
	self.professional_license_flag := le.professional_license_flag or rt.professional_license_flag;
  SameInfo := IF(le.did = rt.did and le.source_st = rt.source_st and 
		le.license_number_cleaned = rt.license_number_cleaned, true, false);
	self.tmp_MostRecent := max(le.tmp_MostRecent,rt.tmp_MostRecent);
	self.proflic_count := le.proflic_count+IF(SameInfo, 0, rt.proflic_count);
	self.expiration_date := max(le.expiration_date,rt.expiration_date);
	self.proflic_count30 := le.proflic_count30+IF(SameInfo,0,rt.proflic_count30);
	self.proflic_count90 := le.proflic_count90+IF(SameInfo,0,rt.proflic_count90);
	self.proflic_count180 := le.proflic_count180+IF(SameInfo,0,rt.proflic_count180);
	self.proflic_count12 := le.proflic_count12+IF(SameInfo,0,rt.proflic_count12);
	self.proflic_count24 := le.proflic_count24+IF(SameInfo,0,rt.proflic_count24);
	self.proflic_count36 := le.proflic_count36+IF(SameInfo,0,rt.proflic_count36);
	self.proflic_count60 := le.proflic_count60+IF(SameInfo,0,rt.proflic_count60);
	self.expire_count30 := le.expire_count30+IF(SameInfo,0,rt.expire_count30);
	self.expire_count90 := le.expire_count90+IF(SameInfo,0,rt.expire_count90);
	self.expire_count180 := le.expire_count180+IF(SameInfo,0,rt.expire_count180);
	self.expire_count12 := le.expire_count12+IF(SameInfo,0,rt.expire_count12);
	self.expire_count24 := le.expire_count24+IF(SameInfo,0,rt.expire_count24);
	self.expire_count36 := le.expire_count36+IF(SameInfo,0,rt.expire_count36);
	self.expire_count60 := le.expire_count60+IF(SameInfo,0,rt.expire_count60);
	self.sanctions_count := max(le.sanctions_count, rt.sanctions_count);
	self.sanctions_date_first_seen := if(le.sanctions_date_first_seen=0, rt.sanctions_date_first_seen, le.sanctions_date_first_seen);
	self.sanctions_date_last_seen :=if(le.sanctions_date_last_seen=0, rt.sanctions_date_last_seen, le.sanctions_date_last_seen);
	self.most_recent_sanction_type := if(le.most_recent_sanction_type='', rt.most_recent_sanction_type, le.most_recent_sanction_type);
//use tmp_MostRecent as that has 8 digits for all mostRecent dates
	side_to_use := if(rt.tmp_MostRecent > le.tmp_MostRecent OR 
		(le.tmp_MostRecent = rt.tmp_MostRecent AND rt.PLCategory > le.PLCategory), rt, le) ;
	self.PLCategory := side_to_use.PLCategory;
	self.jobCategory := side_to_use.jobCategory;
	self.license_type := trim(side_to_use.license_type);
	self.proflic_source := side_to_use.proflic_source;
	self.date_most_recent := side_to_use.date_most_recent;

	self.source_st := if(SameInfo, le.source_st, rt.source_st);
	self.license_number := if(SameInfo, le.license_number, rt.license_number);
  self.license_number_cleaned := if(SameInfo, le.license_number_cleaned, rt.license_number_cleaned);
	self := le;
end;
license_recs_dates:= project(license_recs(professional_license_flag = true), transform(PL_Plus_temp, 
	self.tmp_MostRecent := if(LENGTH(trim((string8) left.date_most_recent)) < 8 and left.date_most_recent != 0,
		(unsigned)	(((string)left.date_most_recent)[1..6] + '01'), left.date_most_recent), self := left));
	
sorted_licenses := group(sort(license_recs_dates, seq, did, -license_number_cleaned, source_st,
	-tmp_MostRecent, -proflic_count,-PLcategory, record), seq);

rolled_licenses := rollup(sorted_licenses, true, roll_licenses(left,right));	

rolled_licenses_final := project(rolled_licenses, transform(RiskWise.Layouts.Layout_Professional_License_Plus, self := left));

// output(license_recs_original, named('license_recs_original'));
// output(mari_data, named('mari_data'));
// output(mari_recs, named('mari_recs'));
// output(ingenix_data, named('ingenix_data'));
// output(ingenix_recs, named('ingenix_recs'));
// output(license_recs, named('license_recs'));
// output(sorted_licenses, named('sorted_licenses_'));
// output(rolled_licenses, named('rolled_licenses'));
// output(license_recs, named('license_recs'));
// output(license_recs_original_pre, named('license_recs_original_pre'));
// output(license_recs_original, named('license_recs_orig_old'));	
	// output(with_category_v5_wBlanks, named('with_category_v5_wBlanks'));
	// output(with_category_v5, named('with_category_v5'));


eyeball := 100;
// OUTPUT(COUNT(license_recs_original_join_correct), NAMED('Count_license_recs_original_join_correct'));
// OUTPUT(COUNT(with_category_v5_correct), NAMED('Count_with_category_v5_correct'));

// OUTPUT(license_recs_original_join_correct, NAMED('license_recs_original_join_correct'));
// OUTPUT(with_category_v5_correct, NAMED('with_category_v5_correct'));

// OUTPUT(bsversion, NAMED('bsversion'));
// OUTPUT(, NAMED(''));
// OUTPUT(with_category_v5_roxie, NAMED('with_category_v5_roxie'));
// OUTPUT(with_category_v5_thor, NAMED('with_category_v5_thor'));
// OUTPUT(license_recs, NAMED('license_recs'));
// OUTPUT(license_recs_dates, NAMED('license_recs_dates'));
// OUTPUT(sorted_licenses, NAMED('sorted_licenses'));
// OUTPUT(rolled_licenses, NAMED('rolled_licenses'));
// OUTPUT(rolled_licenses_final, NAMED('rolled_licenses_final'));
  
return rolled_licenses_final;

end;
