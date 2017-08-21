IMPORT Business_Header, Domains,mdr;

export fWhois_As_Business_Header(dataset(Layout_Whois_Base_BIP) pWhois_Base) :=
function

	//*************************************************************************
	// Translate Whois to Common Business Header Format
	//*************************************************************************

	Business_Header.Layout_Business_Header_New  Translate_Whois_to_BHF(Domains.Layout_Whois_Base_BIP L) := TRANSFORM
	SELF.company_name := Stringlib.StringToUpperCase(L.registrant_name);
	SELF.vl_id := L.domain_name;
	SELF.vendor_id := L.domain_name;
	SELF.zip := (UNSIGNED3)L.zip;
	SELF.zip4 := (UNSIGNED2)L.zip4;
	SELF.phone := 0;
	SELF.phone_score := 0;
	SELF.addr_suffix := L.suffix;
	SELF.city := L.p_city_name;
	SELF.source := MDR.sourceTools.src_Whois_domains;
	SELF.source_group := L.domain_name;
	SELF.dt_first_seen := (UNSIGNED4)L.date_first_seen;
	SELF.dt_last_seen := (UNSIGNED4)L.date_last_seen;
	SELF.dt_vendor_first_reported := (UNSIGNED4)L.date_first_seen;
	SELF.dt_vendor_last_reported := (UNSIGNED4)L.date_last_seen;
	SELF.current := IF(L.current_flag='Y', TRUE, FALSE);
	self.county := l.county[3..5];
	SELF := L;
	END;

	return PROJECT(pWhois_Base(registrant_name<>''), Translate_Whois_to_BHF(LEFT));

end;