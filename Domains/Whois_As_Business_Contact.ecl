IMPORT ut, Business_Header, Domains;

//*************************************************************************
// Translate Whois Contacts to Common Business Contact Format
//*************************************************************************

BH_File := Business_Header.File_Business_Header;

// Select Matching Domain Records
Layout_Domains_Temp := RECORD
unsigned6 rcid := 0;
Layout_Whois;
END;

Layout_Domains_Temp InitDomains(Layout_Whois_BASE L) := TRANSFORM
SELF := L;
END;

Domains_Init := PROJECT(Domains.File_Whois_Base((UNSIGNED3)zip<>0, registrant_name<>''), InitDomains(LEFT));

ut.MAC_Sequence_Records(Domains_Init, rcid, Domains_Seq)

Domains_Dist := DISTRIBUTE(Domains_Seq, HASH((UNSIGNED3)zip, TRIM((qstring28)prim_name), TRIM((qstring10)prim_range), TRIM((QSTRING34)domain_name)));

// Slim the Business Headers
Layout_BH_Slim := RECORD
  qstring120 company_name;
  qstring34 vendor_id;
  qstring10 prim_range;
  qstring28 prim_name;
  qstring8  sec_range;
  unsigned3 zip;
END;

Layout_BH_Slim InitBH(Business_Header.Layout_Business_Header_Base L) := TRANSFORM
SELF := L;
END;

BH_Init := PROJECT(BH_File(source = 'W'), InitBH(LEFT));

BH_Init_Dedup := DEDUP(BH_Init, company_name, vendor_id, zip, prim_name, prim_range, sec_range, ALL);
BH_Init_Dist := DISTRIBUTE(BH_Init_Dedup, HASH(zip, TRIM(prim_name), TRIM(prim_range), TRIM(vendor_id)));

Layout_Domains_Temp SelectDomains(Layout_Domains_Temp L, Layout_BH_Slim R) := TRANSFORM
SELF := L;
END;

// Match Business Header Whois Records to Domain Records
Domains_Match := JOIN(Domains_Dist,
                      BH_Init_Dist,
                        (UNSIGNED3)LEFT.zip = RIGHT.zip AND
                        (qstring28)LEFT.prim_name = RIGHT.prim_name AND
                        (qstring10)LEFT.prim_range = RIGHT.prim_range AND
				    (qstring34)LEFT.domain_name = RIGHT.vendor_id AND
				    (QSTRING120)Stringlib.StringToUpperCase(LEFT.registrant_name) = RIGHT.company_name AND
                        ut.NNEQ((qstring8)LEFT.sec_range, RIGHT.sec_range),
                      SelectDomains(LEFT, RIGHT),
                      LOCAL);

Domains_Match_Dedup := DEDUP(Domains_Match, rcid, ALL);

// Normalize Contact Records from matching domains
Business_Header.Layout_Business_Contact_Full Translate_Whois_to_BCF(Layout_Domains_Temp L, INTEGER C) := TRANSFORM
SELF.company_source_group := L.domain_name; // Source group
SELF.company_name := Stringlib.StringToUpperCase(L.registrant_name);
SELF.company_prim_range := L.prim_range;
SELF.company_predir := L.predir;
SELF.company_prim_name := L.prim_name;
SELF.company_addr_suffix := L.suffix;
SELF.company_postdir := L.postdir;
SELF.company_unit_desig := L.unit_desig;
SELF.company_sec_range := L.sec_range;
SELF.company_city := L.p_city_name;
SELF.company_state := L.state;
SELF.company_zip := (UNSIGNED3)L.zip;
SELF.company_zip4 := (UNSIGNED2)L.zip4;
SELF.company_phone := 0;
SELF.source := 'W';
SELF.dt_first_seen := (UNSIGNED4)L.date_first_seen;
SELF.dt_last_seen := (UNSIGNED4)L.date_last_seen;
SELF.vendor_id := L.domain_name;
SELF.record_type := IF(L.current_flag='Y', 'C', 'H');
SELF.company_title := CHOOSE(C, (QSTRING35)'DOMAIN ADMINISTRATIVE CONTACT', (QSTRING35)'DOMAIN TECHNICAL CONTACT');   // Title of Contact at Company if available
SELF.title := '';
SELF.fname := CHOOSE(C, Datalib.NameClean(L.admin_name)[1..40],
                             Datalib.NameClean(L.tech_name)[1..40]);
SELF.mname := CHOOSE(C, Datalib.NameClean(L.admin_name)[41..80],
                             Datalib.NameClean(L.tech_name)[41..80]);
SELF.lname := CHOOSE(C, Datalib.NameClean(L.admin_name)[81..120],
                             Datalib.NameClean(L.tech_name)[81..120]);
SELF.name_suffix := CHOOSE(C, Datalib.NameClean(L.admin_name)[131..140],
                             Datalib.NameClean(L.tech_name)[131..140]);
SELF.name_score := CHOOSE(C, Datalib.NameClean(L.admin_name)[142],
                             Datalib.NameClean(L.tech_name)[142]);
SELF.prim_range := CHOOSE(C, L.admin_prim_range, L.tech_prim_range);
SELF.predir := CHOOSE(C, L.admin_predir, L.tech_predir);
SELF.prim_name := CHOOSE(C, L.admin_prim_name, L.tech_prim_name);
SELF.addr_suffix := CHOOSE(C, L.admin_suffix, L.tech_suffix);
SELF.postdir := CHOOSE(C, L.admin_postdir, L.tech_postdir);
SELF.unit_desig := CHOOSE(C, L.admin_unit_desig, L.tech_unit_desig);
SELF.sec_range := CHOOSE(C, L.admin_sec_range, L.tech_sec_range);
SELF.city := CHOOSE(C, L.admin_p_city_name, L.tech_p_city_name);
SELF.state := CHOOSE(C, L.admin_state, L.tech_state);
SELF.zip := CHOOSE(C, (UNSIGNED3)L.admin_zip, (UNSIGNED3)L.tech_zip);
SELF.zip4 := CHOOSE(C, (UNSIGNED2)L.admin_zip4, (UNSIGNED2)L.tech_zip4);
SELF.county := CHOOSE(C, L.admin_county[3..5], L.tech_county[3..5]);
SELF.msa := CHOOSE(C, L.admin_msa, L.tech_msa);
SELF.geo_lat := CHOOSE(C, L.admin_geo_lat, L.tech_geo_lat);
SELF.geo_long := CHOOSE(C, L.admin_geo_long, L.tech_geo_long);
SELF.email_address := CHOOSE(C, L.admin_email, L.tech_email);
SELF.ssn := 0;
SELF.phone := 0;
END;

Domains_Contacts := NORMALIZE(Domains_Match_Dedup, 2, Translate_Whois_to_BCF(LEFT, COUNTER));

Domains_Contacts_noroll := Domains_Contacts((INTEGER)name_score < 3, Business_Header.CheckPersonName(fname, mname, lname, name_suffix));


EXPORT Whois_As_Business_Contact := Domains_Contacts_noroll  : PERSIST('TEMP::Domains_Contacts_As_BC');