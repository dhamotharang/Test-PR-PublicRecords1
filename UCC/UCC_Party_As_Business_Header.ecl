IMPORT Business_Header, UT, uccd;

//*************************************************************************
// Translate UCC Debtor and Secured Master to Common Business Header Format
//*************************************************************************
cn := uccd.UCC_Parties_Wdates;

Business_Header.Layout_Business_Header Translate_UCC_to_BHF
(
	cn L
) := TRANSFORM
SELF.company_name := L.name;
SELF.vendor_id := (QSTRING34)((STRING34)
	(L.file_state + if(L.orig_filing_num <> '', L.orig_filing_num, L.ucc_key[4..35])));
SELF.zip := (UNSIGNED3)L.zip;
SELF.zip4 := (UNSIGNED2)L.zip4;
SELF.phone := 0;
SELF.phone_score := 0;
SELF.city := L.p_city_name;
SELF.source := 'U';
SELF.dt_first_seen := (unsigned)l.dt_first_seen;
SELF.dt_last_seen := (unsigned)l.dt_last_seen;
SELF.dt_vendor_first_reported := (unsigned)l.dt_first_seen;
SELF.dt_vendor_last_reported := (unsigned)l.dt_last_seen;
SELF.current := IF(l.record_type = 'C', TRUE, FALSE);
self.bdid := 0;
self.state := l.st;
self.county := l.fips_county;
SELF := L;
END;

dups := PROJECT(
		cn, Translate_UCC_to_BHF(LEFT))
			(company_name<>'', (prim_range <> '' or prim_name <> ''))
		;

srtd := sort(dups, 
		   vendor_id, company_name, prim_range, prim_name, zip, 
		   if(current, 0,1));

EXPORT UCC_Party_As_Business_Header := 
	   dedup(srtd,
	   	    vendor_id, company_name, prim_range, prim_name, zip);
