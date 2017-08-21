IMPORT PhonesPlus, ut, mdr,business_headerv2;

//********************************************
// Create Contacts List From Person PhonesPlus
//********************************************

// Dates are INTEGER3 of YYYYMM in PhonesPlus
// Dates are INTEGER4 of YYYYMMDD in business PhonesPlus

EXPORT PhonesPlus_Contacts(

	 dataset(Phonesplus.layoutCommonOut	) pPhonesPlus								= business_headerv2.Source_Files.phonesplus.BusinessHeader
	,dataset(Layout_Business_Header_Base) pBusinessHeaders					= Files().Base.Business_Headers.built
	,string																pPersistname							= persistnames().PhonesPlusContacts													
	,boolean															pShouldRecalculatePersist	= true													
                                                      
) :=
function

pplus := filters.phonespluscontacts(pPhonesPlus); // filter out dummy records

//Slim record
Layout_PhonesPlus_Slim := RECORD
	pplus.did;
//	pplus.rid;
	qstring34 vendor_id := ''; // Vendor key
	pplus.prim_range;
	pplus.prim_name;
	pplus.sec_range;
	UNSIGNED3 zip;
	pplus.predir;
  qstring4  suffix;
	pplus.postdir;
	pplus.unit_desig;
	qstring25 city_name;
  string2   st;
	UNSIGNED2 zip4;
  string3   county;
	pplus.msa;
//	pplus.src;
	pplus.title;
	pplus.fname;
	pplus.mname;
	pplus.lname;
	pplus.name_suffix;
//	UNSIGNED4 ssn;		// not in phones plus
	UNSIGNED6 phone;
	unsigned3 date_first;
	unsigned3 date_last;
//	BOOLEAN glb;
//	BOOLEAN dppa;
END;

Layout_PhonesPlus_Slim SlimPhonesPlus(pplus L) := TRANSFORM
	self.suffix := l.addr_suffix;
	self.city_name := l.v_city_name;
	self.st := l.state;
	self.county := l.ace_fips_county;
	SELF.zip := (UNSIGNED3) L.zip5;
	SELF.zip4 := (UNSIGNED2) l.zip4;
	SELF.phone := (UNSIGNED6) l.CellPhone;
//	SELF.ssn := (UNSIGNED4) l.ssn; // not in phones plus
	SELF.date_first := ut.EarliestDate(L.DateFirstSeen, L.DateVendorFirstReported);
	SELF.date_last := max(L.DateLastSeen, L.DateVendorLastReported);
//	SELF.glb := if(l.glb_dppa_flag = 'G' or l.glb_dppa_flag = 'B', true, false);
//	SELF.dppa := if(l.glb_dppa_flag = 'D' or l.glb_dppa_flag = 'B', true, false);
	self.vendor_id := l.vendor + (string)l.CellPhoneIDKey;
	SELF := L;
END;

Layout_PhonesPlus_Slim RollPhonesPlusDates(Layout_PhonesPlus_Slim l, Layout_PhonesPlus_Slim r) := TRANSFORM
	SELF.date_first := ut.EarliestDate(l.date_first, r.date_first);
	SELF.date_last := max(l.date_last, r.date_last);
	SELF := l;
END;

// Rollup Record on address and did, set dates
// filter out glb and dppa records because they are all sourced from headers
// src field is populated only when they record is from headers, so can filter those out because
// I am already matching to headers for contact records in header_contacts
PhonesPlus_Init := pplus(zip5<>'', prim_range<>'', prim_name<>'', vendor <> 'HD');
PhonesPlus_Proj := project(PhonesPlus_Init, SlimPhonesPlus(LEFT));
PhonesPlus_Dist := DISTRIBUTE(PhonesPlus_Proj, HASH(zip, prim_range, prim_name));
PhonesPlus_Sort := SORT(PhonesPlus_Dist, zip, prim_range, prim_name, did, -sec_range, LOCAL);
PhonesPlus_Group := GROUP(PhonesPlus_Sort, zip, prim_range, did, prim_name, LOCAL);
PhonesPlus_Dedup := GROUP(ROLLUP(PhonesPlus_Group, TRUE, RollPhonesPlusDates(LEFT, RIGHT)));

// Eliminate addresses with more than 100 people (did's)
ut.MAC_Remove_Withdups_Local(
		PhonesPlus_Dedup, 
		HASH(zip, prim_range, prim_name),
		100,
		PhonesPlus_Filtered)		

Layout_Company_Slim := RECORD
	unsigned6 bdid ;
	boolean   current;
	qstring120 company_name;
	qstring34 company_source_group;
	qstring10 company_prim_range;
	string2   company_predir;
	qstring28 company_prim_name;
	qstring4  company_addr_suffix;
	string2   company_postdir;
	qstring5  company_unit_desig;
	qstring8  company_sec_range;
	qstring25 company_city;
	string2   company_state;
	unsigned3 company_zip;
	unsigned2 company_zip4;
	qstring10 company_geo_lat;
	qstring11 company_geo_long;
	unsigned6 company_phone;
	unsigned4 company_fein;
	unsigned3 company_date_first;
	unsigned3 company_date_last;
END;

Layout_Company_Slim SlimCompanies(Business_Header.Layout_Business_Header_Base L) := TRANSFORM
	SELF.company_date_first := ut.EarliestDate(L.dt_first_seen div 100, L.dt_vendor_first_reported div 100);
	SELF.company_date_last := max(L.dt_last_seen div 100, L.dt_vendor_last_reported div 100);
	SELF.company_source_group := L.source_group;
	SELF.company_name := L.company_name;
	SELF.company_prim_range := L.prim_range;
	SELF.company_predir := L.predir;
	SELF.company_prim_name := L.prim_name;
	SELF.company_addr_suffix := L.addr_suffix;
	SELF.company_postdir := L.postdir;
	SELF.company_unit_desig := L.unit_desig;
	SELF.company_sec_range := L.sec_range;
	SELF.company_city := L.city;
	SELF.company_state := L.state;
	SELF.company_zip := L.zip;
	SELF.company_zip4 := L.zip4;
	SELF.company_geo_lat := L.geo_lat;
	SELF.company_geo_long := L.geo_long;
	SELF.company_phone := L.phone;
	SELF.company_fein := L.fein;
	SELF := L;
END;

Layout_Company_Slim RollCompanyDates(Layout_Company_Slim l, Layout_Company_Slim r) := TRANSFORM
	SELF.company_date_first := ut.EarliestDate(l.company_date_first, r.company_date_first);
	SELF.company_date_last := max(l.company_date_last, r.company_date_last);
	SELF.current := l.current OR r.current;
	SELF := l;
END;

bh_file := pBusinessHeaders;

// Longest company name at address wins for now......
Companies_Proj := PROJECT(bh_file(zip<>0, prim_range<>'', prim_name<>''), SlimCompanies(LEFT));
Companies_Dist := DISTRIBUTE(Companies_Proj, HASH(company_zip, company_prim_range, company_prim_name));
Companies_Sort := SORT(Companies_Dist, company_zip, company_prim_range, company_prim_name, bdid, -LENGTH((STRING)company_name), -company_sec_range, LOCAL);
Companies_Group := GROUP(Companies_Sort, company_zip, company_prim_range, company_prim_name, bdid, LOCAL);
Companies_Dedup := GROUP(ROLLUP(Companies_Group, true, RollCompanyDates(LEFT, RIGHT)));

// Eliminate addresses with more than 25 companies (bdid's)
layout_bdid_count := RECORD
	Companies_Dedup.company_zip;
	Companies_Dedup.company_prim_range;
	Companies_Dedup.company_prim_name;
	UNSIGNED4 bdid_count := COUNT(GROUP);
END;

bdid_count := TABLE(Companies_Dedup, layout_bdid_count, company_zip, company_prim_range, company_prim_name, LOCAL);

TYPEOF(Companies_Dedup) TakeLeft(Companies_Dedup l) := TRANSFORM
	SELF := l;
END;

Companies_Filtered := JOIN(Companies_Dedup, bdid_count(bdid_count <= 25),
				LEFT.company_zip = RIGHT.company_zip AND
				LEFT.company_prim_range = RIGHT.company_prim_range AND
				LEFT.company_prim_name = RIGHT.company_prim_name,
				TakeLeft(LEFT), LOCAL);
		
Layout_PhonesPlus_Contact_Match := RECORD
	Layout_PhonesPlus_Slim;
	Layout_Company_Slim;
END;

Layout_PhonesPlus_Contact_Match SelectContacts(Layout_Company_Slim l, Layout_PhonesPlus_Slim r) := TRANSFORM
	SELF := r;
	SELF := l;
END;

// Join Slim PhonesPlus to Slim Companies Master to obtain additional contacts
PhonesPlus_Contacts_Select := JOIN(Companies_Filtered,
                              PhonesPlus_Filtered,
							  LEFT.company_zip = RIGHT.zip AND 
							  LEFT.company_prim_range = RIGHT.prim_range AND 
							  LEFT.company_prim_name = RIGHT.prim_name AND
							  LEFT.company_sec_range = RIGHT.sec_range AND
							  ut.NNEQ(LEFT.company_addr_suffix, RIGHT.suffix) AND
							  ut.date_overlap(LEFT.company_date_first, LEFT.company_date_last,
								  RIGHT.date_first, RIGHT.date_last) > 0,
                              SelectContacts(LEFT, RIGHT),
                              LOCAL);

// We don't care which address matched to the company for the person
PhonesPlus_Contacts_Dedup := DEDUP(PhonesPlus_Contacts_Select, bdid, did, ALL);

Business_Header.Layout_Business_Contacts_Temp ScoreContacts(
	PhonesPlus_Contacts_Dedup l, bdid_count r) := TRANSFORM
	SELF.source := mdr.sourcetools.src_Phones_Plus;
	SELF.record_type := IF(l.current, 'C', 'H');
	SELF.from_hdr := 'Y';
	SELF.company_title := '';
	SELF.addr_suffix := l.suffix;
	SELF.city := l.city_name;
	SELF.state := l.st;
	SELF.name_score := Business_Header.CleanName(
			l.fname, l.mname, l.lname, l.name_suffix)[142];
//     SELF.msa := l.cbsa[1..4];
	SELF.geo_lat := l.company_geo_lat;
	SELF.geo_long := l.company_geo_long;
	SELF.email_address := '';

	// Use the date intersection   YYYYMMDD
	SELF.dt_first_seen := (max(l.date_first, l.company_date_first) * 100) + 1;
	SELF.dt_last_seen := (ut.EarliestDate(l.date_last, l.company_date_last) * 100) + 1;
	SELF.contact_score := IF(r.bdid_count < 5, 3, 2);
	SELF := l;
END;

PhonesPlus_Contacts_Init := JOIN(
	DISTRIBUTE(PhonesPlus_Contacts_Dedup, HASH(company_zip, company_prim_range, company_prim_name)),
	bdid_count,
	LEFT.company_zip = RIGHT.company_zip AND
	LEFT.company_prim_range = RIGHT.company_prim_range AND
	LEFT.company_prim_name = RIGHT.company_prim_name,
	ScoreContacts(LEFT, RIGHT), LOCAL);

PhonesPlus_Contacts_Filt := PhonesPlus_Contacts_Init(
	(INTEGER)name_score < 3, 
	Business_Header.CheckPersonName(fname, mname, lname, name_suffix));

// Check for phone number matches to increase score
layout_did_phone := record
PhonesPlus_Proj.did;
PhonesPlus_Proj.phone;
end;

PhonesPlus_Phones := table(PhonesPlus_Proj(phone <> 0), layout_did_phone);
PhonesPlus_Phones_Dedup := dedup(PhonesPlus_Phones, all);

layout_bdid_phone := record
Companies_Proj.bdid;
unsigned6 phone := Companies_Proj.company_phone;
end;

Companies_Phones := table(Companies_Proj(company_phone <> 0), layout_bdid_phone);
Companies_Phones_Dedup := dedup(Companies_Phones, all);

layout_bdid_did := record
unsigned6 bdid;
unsigned6 did;
end;

PhonesPlus_Company_Phone_Match := join(PhonesPlus_Phones_Dedup,
                                   Companies_Phones_Dedup,
							left.phone = right.phone,
							transform(layout_bdid_did, self.did := left.did, self.bdid := right.bdid),
							hash);
							
PhonesPlus_Company_Phone_Match_Dedup := dedup(PhonesPlus_Company_Phone_Match, all);

// Increase contact scores for company-person phone matches
PhonesPlus_Contacts_Out := join(PhonesPlus_Contacts_Filt,
                            PhonesPlus_Company_Phone_Match_Dedup,
					   left.bdid = right.bdid and
					     left.did = right.did,
					   transform(Business_Header.Layout_Business_Contacts_Temp,
					             self.contact_score := left.contact_score + if(right.bdid <> 0, 5, 0),
							   self := left),
					   left outer,
					   hash)  : PERSIST(pPersistname);

returndataset := if(pShouldRecalculatePersist = true, PhonesPlus_Contacts_Out
																										, persists().PhonesPlusContacts
									);
return returndataset;

end;