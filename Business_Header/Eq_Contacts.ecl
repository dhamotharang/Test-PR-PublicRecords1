IMPORT Header, Business_Header_SS, Watchdog, Business_Header, ut, did_Add;

eqf := Header.File_Eq_Employer;

layout_co_match := RECORD
	eqf.did;
	eqf.fname;
	eqf.dt_first_seen;
	eqf.dt_last_seen;
	eqf.occupation_employer;
	eqf.occupation_position;
	eqf.employer_type;
	eqf.zip;
END;

SetBunkEmployers := ['SELF', 'SELF EMPLOYED', 'RETIRED', 'NONE', 
					'UNKNOWN', 'NA', 'HOMEMAKER', 'HOUSEWIFE',
					'STUDENT', 'NONE', 'UNEMPLOYED', 'RT', 'DISABLED',
					'DISABILITY', 'X', 'SELF EMP', '000000000000000',
					'HM', 'SS', 'MISCELLANEOUS', 'SOC SEC', 'U K',
					'RET', 'ST', 'RETI', 'UNK', 'SELFEMPLOYED', 'N A',
					'HOME MAKER', 'BLANK', 'INTERNET APP', 'NOT LISTED',
					'ILLEGIBLE', 'V', 'SELF-EMPLOYED', 'SELF EMPL',
					'NOT EMPLOYED', 'FARMER', 'RETIREMENT', 'TEACHER',
					'RTRD', 'NOT GIVEN', 'DISABLE', 'OWNER', '0', 'XXX'];

RankEmployer(STRING1 et) :=	MAP(et = 'C' => 1,
								et = 'F' => 2,
								et = 'G' => 3,
								et = 'O' => 4,
								5);
		
layout_co_match TakePerson(eqf l) := TRANSFORM
	SELF := l;
END;

has_employer := PROJECT(eqf(occupation_employer != '',
	occupation_employer NOT IN SetBunkEmployers),
	TakePerson(LEFT));

//OUTPUT(COUNT(DEDUP(has_employer, did, ALL)), NAMED('BDIDable_DIDs'));

did_emp_zip := DEDUP(
	SORT(
	DISTRIBUTE(has_employer, HASH(occupation_employer)),
		occupation_employer, did, zip, RankEmployer(employer_type), -occupation_position, LOCAL),
		occupation_employer, did, zip, LOCAL)
			: PERSIST('adtemp::did_emp_zip1');

// Take just the unique employer names to bdid.
layout_bdid := RECORD
	did_emp_zip.occupation_employer;
	UNSIGNED6 bdid := 0;
	UNSIGNED1 score := 0;
END;

to_match := TABLE(did_emp_zip, layout_bdid, occupation_employer, LOCAL);

matchset := ['N'];
Business_Header_SS.MAC_Match_Flex(
	to_match, matchset,
	occupation_employer,
	prange_field, pname_field, zip_field,
	srange_field, state_field,
	phone_field, fein_field,
	bdid,	
	layout_bdid,
	true, score,  //these should default to zero in definition
	bdid_assigned,
	50, 0)

// Join with business headers to get zips.
bh_cands := Business_Header.File_Business_Header_Base(zip != 0);

layout_bdid_zip := record
bh_cands.bdid;
bh_cands.zip;
end;

bh_cands_zips := table(bh_cands, layout_bdid_zip);
bh_cands_zips_dedup := dedup(bh_cands_zips, bdid, all);

layout_bh_match := RECORD
	layout_bdid;
	UNSIGNED3 bh_zip;
END;

layout_bh_match GetZip(bdid_assigned l, bh_cands_zips_dedup r) := TRANSFORM
	SELF.bh_zip := r.zip;
	SELF := l;
END;

bh_recs := JOIN(
	DISTRIBUTE(bdid_assigned(bdid != 0), HASH(bdid)),
	DISTRIBUTE(bh_cands_zips_dedup, HASH(bdid)),
	LEFT.bdid = RIGHT.bdid,
	GetZip(LEFT, RIGHT),
	LOCAL);

// Dedup by employer and zip.
bh_ded := DEDUP(SORT(bh_recs, bdid, occupation_employer, bh_zip, LOCAL), 
							bdid, occupation_employer, bh_zip, LOCAL);

bh_recs_dist := DISTRIBUTE(
	bh_ded, HASH(occupation_employer));

// Take the did/employer/zip records based on employer name
// and zip distance.
layout_did_bdid := RECORD
	layout_co_match;
	layout_bh_match.bdid;
	layout_bh_match.score;
END;
	
layout_did_bdid TakeMatch(did_emp_zip l, bh_recs_dist r) := TRANSFORM
	SELF := l;
	SELF := r;
END;

j_all := JOIN(
	did_emp_zip,
	bh_recs_dist,
	LEFT.occupation_employer = RIGHT.occupation_employer,
	TakeMatch(LEFT, RIGHT), KEEP(1), LOCAL);
//OUTPUT(COUNT(j_all), named('count_of_eq_recs_with_bdid'));
//OUTPUT(COUNT(DEDUP(j_all, did, ALL)), named('count_of_eq_dids_with_bdid'));

// In the zip range joins, we need to only know if a did-employer
// combination matched none, 1, or more bdids.
j_z15 := JOIN(
	did_emp_zip,
	bh_recs_dist,
	LEFT.occupation_employer = RIGHT.occupation_employer AND
	ut.zip_Dist(LEFT.zip, INTFORMAT(RIGHT.bh_zip, 5, 1)) < 15,
	TakeMatch(LEFT, RIGHT), KEEP(2), LOCAL);
	
j_z50 := JOIN(
	did_emp_zip,
	bh_recs_dist,
	LEFT.occupation_employer = RIGHT.occupation_employer AND
	ut.zip_Dist(LEFT.zip, INTFORMAT(RIGHT.bh_zip, 5, 1)) < 50,
	TakeMatch(LEFT, RIGHT), KEEP(2), LOCAL);

layout_companies_per_did_15 := RECORD
	j_z15.occupation_employer;
	j_z15.did;
	UNSIGNED4 companiess := COUNT(GROUP);
END;

emp_stat_15 := TABLE(DEDUP(sort(j_z15, occupation_employer, did, bdid, local), 
													 occupation_employer, did, bdid, LOCAL), 
	layout_companies_per_did_15, occupation_employer, did, LOCAL);

// Take the did-employer -> single bdid records.
layout_contact := RECORD
	layout_co_match.did;
	layout_co_match.fname;
	layout_co_match.dt_first_seen;
	layout_co_match.dt_last_seen;
	layout_co_match.occupation_employer;
	layout_co_match.occupation_position;
	layout_co_match.employer_type;
	layout_bh_match.bdid;
END;

layout_contact MakeContact(layout_did_bdid l) := TRANSFORM
	SELF := l;
END;

c15 := JOIN(
	j_z15, emp_stat_15(companiess = 1),
	LEFT.occupation_employer = RIGHT.occupation_employer AND
	LEFT.did = RIGHT.did,
	MakeContact(LEFT), LOCAL);

// Get rid of multiple zips and employers that map to the same bdid.
c15_ded := DEDUP(
			SORT(
				DISTRIBUTE(c15, HASH(did)), did, bdid, -occupation_position, LOCAL),
				did, bdid, LOCAL);

layout_companies_per_did_50 := RECORD
	j_z50.occupation_employer;
	j_z50.did;
	UNSIGNED4 companiess := COUNT(GROUP);
END;

emp_stat_50 := TABLE(DEDUP(sort(j_z50, occupation_employer, did, bdid, LOCAL),
													 occupation_employer, did, bdid, LOCAL), 
										 layout_companies_per_did_50, occupation_employer, did, LOCAL);
c50 := JOIN(
	j_z50, emp_stat_50(companiess = 1),
	LEFT.occupation_employer = RIGHT.occupation_employer AND
	LEFT.did = RIGHT.did,
	MakeContact(LEFT), LOCAL);

c_primary_ded := DEDUP(
			SORT(
				c15_ded + DISTRIBUTE(c50, HASH(did)), did, bdid, -occupation_position, LOCAL),
				did, bdid, LOCAL);

// If we can bdid the un-bdid'd employers using a looser company
// name match, include them with a 0 bdid.
looser_name := bdid_assigned(bdid = 0);
co_names := Business_Header_SS.File_BH_CompanyName;

layout_bdid TakeEmployer(looser_name l) := TRANSFORM
	SELF.score := 0;
	SELF.bdid := 0;
	SELF := l;
END;

loose_bdid_assigned := JOIN(
	DISTRIBUTE(looser_name, HASH(occupation_employer[1..8])),
	DISTRIBUTE(co_names, HASH(clean_company_name[1..8])),
	LEFT.occupation_employer[1..8] = RIGHT.clean_company_name[1..8] AND
	ut.CompanySimilar100(LEFT.occupation_employer, RIGHT.clean_company_name[1..35]) < 25,
	TakeEmployer(LEFT), KEEP(1), LOCAL);
	
layout_did_bdid TakeDID(did_emp_zip l, loose_bdid_assigned r) := TRANSFORM
	SELF := l;
	SELF := r;
END;

j_loose := JOIN(
	did_emp_zip, 
	DISTRIBUTE(loose_bdid_assigned, HASH(occupation_employer)),
	LEFT.occupation_employer = RIGHT.occupation_employer,
	TakeDID(LEFT, RIGHT), KEEP(1), LOCAL);

//OUTPUT(CHOOSEN(loose_bdid_assigned, 100), NAMED('Loosely_matched_employers_sample'));

// Now we want the eq did-employers that we could bdid, although not uniquely, and
// the did-employers that we could bdid only with a loose company name match.
// If we have a unique match for this did at another company, we don't
// want it.
c_unique_match_dids := DEDUP(c_primary_ded, did, LOCAL);

layout_contact MakeSecondaryContact(layout_did_bdid l) := TRANSFORM
	SELF.bdid := 0;
	SELF := l;
END;

c_secondary := JOIN(
	DISTRIBUTE(j_all + j_loose, HASH(did)),
	c_unique_match_dids,
	LEFT.did = RIGHT.did,
	MakeSecondaryContact(LEFT),
	LEFT ONLY, LOCAL);

c_sec_ded := DEDUP(
			SORT(c_secondary, did, occupation_employer, -occupation_position, LOCAL),
			 did, occupation_employer, LOCAL);

c_all := c_primary_ded + c_sec_ded;

//OUTPUT(COUNT(DEDUP(c_all, did)), NAMED('total_dids_added'));

// Get best info for all DIDs
bst_hdr := Watchdog.File_Best_nonglb;

cntct_tmp := Business_Header.Layout_Business_Contacts_Temp;
cntct_tmp AddPersonInfo(bst_hdr l, c_all r) := TRANSFORM
	SELF.bdid := r.bdid;
	SELF.did := r.did;
	SELF.contact_score := IF(r.bdid = 0, 3, 5) 
				+ IF(r.employer_type = 'C', 1, 0);
	SELF.from_hdr := 'E';
	SELF.dt_first_seen := r.dt_first_seen * 100 + 1;
	SELF.dt_last_seen := r.dt_last_seen * 100 + 1;
	SELF.company_name := r.occupation_employer;
	SELF.company_department := '';
	SELF.fname := IF(l.fname = '', r.fname, l.fname);
	SELF.company_title := r.occupation_position;
	SELF.zip := (UNSIGNED3) l.zip;
	SELF.zip4 := (UNSIGNED2) l.zip4;
	SELF.phone := (UNSIGNED6) l.phone;
	SELF.ssn := (UNSIGNED4) l.ssn;
	SELF.source := 'QQ';
	SELF.record_type := IF(r.employer_type = 'C', 'C', 'H');
	SELF.name_score := Business_Header.CleanName(
			l.fname, l.mname, l.lname, l.name_suffix)[142];
	SELF.addr_suffix := l.suffix;
	SELF.city := l.city_name;
	SELF.state := l.st;
	SELF.county := '';
	SELF.msa := '';
	SELF.geo_lat := '';
	SELF.geo_long := '';
	SELF.email_address := '';
	SELF.company_prim_range := '';
	SELF.company_predir := '';
	SELF.company_prim_name := '';
	SELF.company_addr_suffix := '';
	SELF.company_postdir := '';
	SELF.company_unit_desig := '';
	SELF.company_sec_range := '';
	SELF.company_city := '';
	SELF.company_state := '';
	SELF.company_zip := 0;
	SELF.company_zip4 := 0;
	SELF.company_phone := 0;
	SELF := l;
END;

contact_person := JOIN(
	DISTRIBUTE(bst_hdr, HASH(did)), 
	c_all,
	LEFT.did = RIGHT.did AND
	LEFT.lname != '',
	AddPersonInfo(LEFT, RIGHT), LOCAL);

bst_bus_hdr := Business_Header.File_Business_Header_Best;

cntct_tmp AddCompanyInfo(bst_bus_hdr l, contact_person r) := TRANSFORM
	SELF.company_name := l.company_name;
	SELF.company_prim_range := l.prim_range;
	SELF.company_predir := l.predir;
	SELF.company_prim_name := l.prim_name;
	SELF.company_addr_suffix := l.addr_suffix;
	SELF.company_postdir := l.postdir;
	SELF.company_unit_desig := l.unit_desig;
	SELF.company_sec_range := l.sec_range;
	SELF.company_city := l.city;
	SELF.company_state := l.state;
	SELF.company_zip := l.zip;
	SELF.company_zip4 := l.zip4;
	SELF.company_phone := l.phone;
	SELF.company_fein := l.fein;
	SELF := r;
END;

contact_business := JOIN(
	DISTRIBUTE(bst_bus_hdr, HASH(bdid)),
	DISTRIBUTE(contact_person(bdid != 0), HASH(bdid)),
	LEFT.bdid = RIGHT.bdid,
	AddCompanyInfo(LEFT, RIGHT), LOCAL);

contact_full := contact_person(bdid = 0)
	+ contact_business;

EXPORT Eq_Contacts := contact_full : PERSIST('TEMP::eq_contacts');