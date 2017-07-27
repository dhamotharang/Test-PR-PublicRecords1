IMPORT Business_Header, Domains;

//*************************************************************************
// Translate Whois to Common Business Header Format
//*************************************************************************

Whois_Companies := Domains.File_Whois();

Business_Header.Layout_Business_Header  Translate_Whois_to_BHF(Domains.Layout_Whois_BASE L) := TRANSFORM
SELF.company_name := Stringlib.StringToUpperCase(L.registrant_name);
SELF.vendor_id := L.domain_name;
SELF.zip := (UNSIGNED3)L.zip;
SELF.zip4 := (UNSIGNED2)L.zip4;
SELF.phone := 0;
SELF.phone_score := 0;
SELF.addr_suffix := L.suffix;
SELF.city := L.p_city_name;
SELF.source := 'W';
SELF.source_group := L.domain_name;
SELF.dt_first_seen := (UNSIGNED4)L.date_first_seen;
SELF.dt_last_seen := (UNSIGNED4)L.date_last_seen;
SELF.dt_vendor_first_reported := (UNSIGNED4)L.date_first_seen;
SELF.dt_vendor_last_reported := (UNSIGNED4)L.date_last_seen;
SELF.current := IF(L.current_flag='Y', TRUE, FALSE);
SELF.county := l.county[3..5];
SELF := L;
END;

EXPORT Whois_As_Business_Header := PROJECT(Domains.File_Whois_BASE(registrant_name<>''), Translate_Whois_to_BHF(LEFT));