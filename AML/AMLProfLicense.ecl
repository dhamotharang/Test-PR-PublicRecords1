import prof_licenseV2, riskwise, ut, risk_indicators;

export AMLProflicense(GROUPED DATASET(risk_indicators.Layout_Boca_Shell_ids) ids_only) := FUNCTION


Layout_PL_Plus := RECORD
	boolean HRProfLicProv;
	boolean professional_license_flag := false;
	string60 license_type := '';
	// string100 jobCategory := '';
	// string1 plCategory := '';
	unsigned1 proflic_count := 0;
	unsigned date_most_recent := 0;
	unsigned expiration_date := 0;
	string50 prolic_key;
	STRING8  date_first_seen;
	unsigned6 did;
	unsigned4 seq;
END;

checkDays(string8 d1, string8 d2, unsigned2 days) := ut.DaysApart(d1,d2) <= days and d1>d2;

key_did := prof_licenseV2.Key_Proflic_Did ();

Layout_PL_Plus PL_nonFCRA(ids_only le, key_did rt) := transform
	hit := trim(rt.prolic_key)!='';	// check to see that we have a good record
	myGetDate := risk_indicators.iid_constants.myGetDate(le.historydate);
	self.prolic_key := rt.prolic_key;
	self.date_first_seen := if(hit, rt.date_first_seen, '');
	self.professional_license_flag := hit;
	self.license_type := if(hit, rt.license_type, '');
	self.proflic_count := if(hit and (unsigned)rt.expiration_date>=(unsigned)myGetDate, 1, 0);	// not really current here, just total
	self.date_most_recent := if(hit, (unsigned)rt.date_last_seen, 0);// seems to be the issue date, should we check prolic_key<>'' here?
	self.expiration_date := if(hit, (unsigned)rt.expiration_date, 0);//should we check prolic_key<>'' here?
	self.HRProfLicProv := if(hit and rt.license_type in AML.AMLConstants.setHRProfLic, 1, 0);
	self := le;
end;
license_recs := join(ids_only, key_did,
											left.did!=0 and keyed(right.did = left.did) and
											(unsigned)right.date_first_seen[1..6] < left.historydate,
											PL_nonFCRA(left,right), left outer, 
											atmost(right.did = left.did, riskwise.max_atmost));


Layout_PL_Plus roll_licenses(Layout_PL_Plus le, Layout_PL_Plus rt) := transform
	self.professional_license_flag := le.professional_license_flag or rt.professional_license_flag;
	self.proflic_count := le.proflic_count+IF(le.prolic_key=rt.prolic_key,0,rt.proflic_count);
	self.date_most_recent := Max(le.date_most_recent,rt.date_most_recent);
	self.expiration_date := Max(le.expiration_date,rt.expiration_date);
	self.license_type := if(le.license_type<>'', trim(le.license_type), trim(rt.license_type));	// keep the most current license type;
	self.HRProfLicProv := if(le.HRProfLicProv, le.HRProfLicProv, rt.HRProfLicProv);
	self := rt;
end;
rolled_licenses := rollup(sort(license_recs, prolic_key,-date_most_recent), true, roll_licenses(left,right));	



// output(license_recs, named('license_recs'), overwrite);					
// output(rolled_licenses, named('rolled_licenses'), overwrite);					

return rolled_licenses;

end;