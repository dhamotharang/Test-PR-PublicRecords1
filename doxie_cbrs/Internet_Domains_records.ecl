import doxie_Raw, domains, doxie_cbrs_raw, census_data;
doxie_cbrs.mac_Selection_Declare()

export Internet_Domains_records(dataset(doxie_cbrs.layout_references) bdids) := FUNCTION

wsr := doxie_cbrs_raw.internet_domains(bdids,Include_InternetDomains_val,max_InternetDomains).records;

outrec := record
    unsigned1 level; //defined Level field as it is missing in Domains.Layout_Whois_Base which is added to "WSR" in doxie_cbrs.mac_RollStart
	Domains.Layout_Whois_Base - [global_sid, record_sid];
	string8 update_date_decode; 
	string8 expire_date_decode;
	string8 create_date_decode;
	string18 county_name := '';
	string18 admin_county_name := '';
	string18 tech_county_name := '';
end;

outrec tra(wsr l) := transform
	self.update_date_decode := domains.convertDate(l.update_date);
	self.expire_date_decode := domains.convertDate(l.expire_date);
	self.create_date_decode := domains.convertDate(l.create_date);
	self := l;
end;

wdates := project(wsr, tra(left));

//Populate county_name.
census_data.MAC_Fips2County_Keyed(wdates,state,county[3..5],county_name,wdates2);

//Populate county_name.
census_data.MAC_Fips2County_Keyed(wdates2,admin_state,admin_county[3..5],admin_county_name,wdates3);

//Populate county_name.
census_data.MAC_Fips2County_Keyed(wdates3,tech_state,tech_county[3..5],tech_county_name,wdates4);

return sort(wdates4, domain_name);
END;