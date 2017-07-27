import ut, data_services;

string_rec := RECORD
	string12	DID;		// need to cleam up these string sizes, done when file was bad
	string3	DID_Score;
	string20	cln_FNAME;
	string20	cln_MNAME;
	string20	cln_LNAME;
	string5		cln_NAME_SUFFIX;
	string10	AID;
	string10	cln_PRIM_RANGE;
	string28	cln_PRIM_NAME;
	string8		cln_SEC_RANGE;
	string2		cln_ST;
	string5		cln_ZIP;
	string9		ln_SSN;
	string8		ln_DOB;
	string10		ln_ANNUALINCOME;
	string6	 ProcessDate;
	string6	DateVendorFirstReported;
	string6	DateVendorLastReported;
	string20 SOURCENAME;
	string80 EMAIL;
	string30 FIRSTNAME;
	string20 MIDDLENAME;
	string30 LASTNAME;
	string80 ADDRESS1;
	string45 ADDRESS2;
	string20 CITY;
	string2 STATE;
	string5 ZIP;
	string10 HOMEPHONE;
	string8 DOB;
	string8 CREATED;
	string4 SITEID;
	string9 SSN;
	string19 CAMPAIGNID;
	string8 LASTMODIFIED;
	string15 IPADDRESS;
	string10 TOTALINCOME;
	string10 CELLPHONE;
	string4 YEAROB;
	string4 FRAUD;
	string2 DAYOB;
	string2 MONTHOB;
	string2 BIGHIP_DBLOPT;
	string20 LICENSE_NUM;
	string2 LICENSE_STATE;
	string10 INCOME_MONTHLY_NET;
	string1 INCOME_DIRECTDEPOSIT;
	string45 REJECTEDREASON;
	string12 INCOME_MONTHLY;
	string12 ANNUAL_INCOME;
	string1 ERRORFLAG;
	string10 MONTHSALARY;
	string10 GROSSMONTHLYINCOME;
	string12 KRAFTBLOCK;
	string10 SCRAPED;
	string2 source;
	string20 flag_file_id;
END;

ds := dedup(sort(dataset('~thor_data400::base::override::fcra::qa::impulse', string_rec, csv(separator('\t'),quote('\"'),terminator('\r\n')),opt),-flag_file_id),except flag_file_id,keep(1));

fcra.Layout_Override_Impulse proj_recs(ds l) := transform
	self.did := (integer8)l.did;
	self.did_score := (integer8)l.did_score;
	self.aid := (unsigned4)l.aid;
	self.ln_ANNUALINCOME := (integer)l.ln_ANNUALINCOME;
	self.DateVendorFirstReported := (unsigned3)l.DateVendorFirstReported;
	self.DateVendorLastReported := (unsigned3)l.DateVendorLastReported;
	self := l;
end;

kf := project(ds,proj_recs(left));

export Key_Override_Impulse_FFID := index(kf,{flag_file_id}, {kf},
data_services.data_location.prefix('fcra_overrides')+'thor_data400::key::override::fcra::impulse::qa::ffid');