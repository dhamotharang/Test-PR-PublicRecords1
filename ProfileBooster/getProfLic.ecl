import _Control, prof_licenseV2, riskwise, ut, ProfileBooster, Risk_Indicators;
onThor := _Control.Environment.OnThor;

export getProfLic(DATASET(ProfileBooster.Layouts.Layout_PB_Slim) PBslim) := FUNCTION

string8 proflic_build_date := Risk_Indicators.get_Build_date('proflic_build_version');

checkDays(string8 d1, string8 d2, unsigned2 days) := ut.DaysApart(d1,d2) <= days and d1>d2;

key_did := prof_licenseV2.key_proflic_did(false);

ProfileBooster.Layouts.Layout_PB_Slim_profLic addProfLic(PBslim le, key_did rt) := transform
	hit := trim(rt.prolic_key)!='';	// make sure we have a good record
	myGetDate := Risk_Indicators.iid_constants.myGetDate(le.historydate);
	self.prolic_key := if(hit, rt.prolic_key, '');
	self.date_first_seen := if(hit, rt.date_first_seen, '');
	self.professional_license_flag := hit;
	self.license_type := if(hit, rt.license_type, '');
	expire_date := if(hit, (unsigned)rt.expiration_date, 0);
	isExpired := expire_date<(unsigned)myGetDate and expire_date<>0;
	self.proflic_count := if(hit and ~isExpired, 1, 0);
	self.jobCategory := ''; 
	self.PLcategory := '';	
	self := le;
end;
license_recs_original_roxie := join(PBslim, key_did,
											left.did2!=0 and keyed(right.did = left.did2) and
										  (stringlib.stringtouppercase(right.source_st) not in ProfileBooster.Constants.setProfLicStatesRes) and 
											(unsigned)(right.date_last_seen[1..6]) < left.historydate,
											addProfLic(left,right), left outer, atmost(right.did = left.did2, riskwise.max_atmost));

license_recs_original_thor := join(
distribute(PBslim(did2<>0), did2), 
distribute(pull(key_did(stringlib.stringtouppercase(source_st) not in ProfileBooster.Constants.setProfLicStatesRes)), did),
											left.did2=right.did and
											(unsigned)(right.date_last_seen[1..6]) < left.historydate,
											addProfLic(left,right), left outer, atmost(left.did2=right.did,riskwise.max_atmost),
		local);

#IF(onThor)
	license_recs_original := license_recs_original_thor;
#ELSE
	license_recs_original := license_recs_original_roxie;
#END

preMari := group(project(PBslim,  
												transform(Risk_Indicators.Layout_Boca_Shell_ids,
																	self.seq 					:= left.seq;
																	self.did 					:= left.did2;  
																	self.historydate 	:= left.historydate;
																	self.fname := (string)left.rec_type;   // temporarily use the fname field to hang onto the rec_type until mari_recs join below
																	self 							:= [])), seq);
isFCRA 			:= false;
isPreScreen := false;

mari_data := risk_indicators.Boca_Shell_Mari(preMari, isFCRA, isPreScreen);

// initially not so sure we trust the dates on the MARI file to be accurate.  
// ie, date_first_seen is newer than the expire date
mari_recs := join (preMari, mari_data,
		left.seq=right.seq and
		left.did=right.did,
		transform (ProfileBooster.Layouts.Layout_PB_Slim_profLic, 
			self.rec_type := (unsigned)left.fname;
			hit := trim(right.license_nbr)!='';	// check to see that we have a good record
			myGetDate := Risk_Indicators.iid_constants.myGetDate(left.historydate);
			self.prolic_key := right.license_nbr;
			self.date_first_seen := if(hit, (string)right.date_first_seen, '');
			self.professional_license_flag := hit;
			self.license_type := if(hit, right.most_recent_license_type, '');
			self.proflic_count := if(hit and right.expiration_date>=(unsigned)myGetDate, 1, 0);	
			self.did2 := left.did,
			self := left,
			self := []),
    atmost(riskwise.max_atmost),
		keep(100)
  );	


license_recs := ungroup(license_recs_original) + ungroup(mari_recs);
										
ProfileBooster.Layouts.Layout_PB_Slim_profLic roll_licenses(ProfileBooster.Layouts.Layout_PB_Slim_profLic le, ProfileBooster.Layouts.Layout_PB_Slim_profLic rt) := transform
	self.professional_license_flag := le.professional_license_flag or rt.professional_license_flag;
	self.proflic_count := Max(le.proflic_count, rt.proflic_count);
	self.license_type := if(le.license_type<>'', le.license_type, rt.license_type);	// keep the most current license type
	self := rt;
end;

rolled_licenses := rollup(group(sort(license_recs, seq, did2, prolic_key), seq, did2, prolic_key), true, roll_licenses(left,right));	

ProfileBooster.Layouts.Layout_PB_Slim_profLic roll_licenses2(ProfileBooster.Layouts.Layout_PB_Slim_profLic le, ProfileBooster.Layouts.Layout_PB_Slim_profLic rt) := transform
	self.professional_license_flag := le.professional_license_flag or rt.professional_license_flag;
	self.proflic_count := le.proflic_count+rt.proflic_count;
	self.license_type := if(le.license_type<>'', le.license_type, rt.license_type);	// keep the most current license type
	self := rt;
end;
rolled_licenses2 := rollup(group(sort(ungroup(rolled_licenses), seq, did2), seq, did2), true, roll_licenses2(left,right));

with_category_v5_roxie := join(rolled_licenses2, Prof_LicenseV2.Key_LicenseType_lookup(false), 
		left.license_type<>'' and
		keyed(left.license_type=right.license_type), 	
			transform(ProfileBooster.Layouts.Layout_PB_Slim_profLic, 
			self.jobCategory := right.occupation; 
			self.PLcategory := right.category;
			self := left), left outer, atmost(100), keep(1));

with_category_v5_thor1 := join(
	distribute(rolled_licenses2(license_type<>''), hash(license_type)), 
	distribute(pull(Prof_LicenseV2.Key_LicenseType_lookup(false)), hash(license_type)), 
		left.license_type=right.license_type, 	
			transform(ProfileBooster.Layouts.Layout_PB_Slim_profLic, 
			self.jobCategory := right.occupation; 
			self.PLcategory := right.category;
			self := left), left outer, atmost(100), keep(1),
		local);
with_category_v5_thor := with_category_v5_thor1 + rolled_licenses2(license_type='');  // add back the records with empty license type

#IF(onThor)
	with_category_v5 := group(with_category_v5_thor, seq, did2);
#ELSE
	with_category_v5 := with_category_v5_roxie;
#END

 // output(PBslim, named('PBslim'));
 // output(license_recs_original, named('license_recs_original'));
 // output(mari_recs, named('mari_recs'));
 // output(license_recs, named('license_recs'));
 // output(rolled_licenses, named('rolled_licenses'));
 // output(rolled_licenses2, named('rolled_licenses2'));
 // output(with_category_v5, named('with_category_v5'));

return with_category_v5;

end;