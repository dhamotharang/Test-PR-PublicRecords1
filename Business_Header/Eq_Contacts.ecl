IMPORT Header, Business_Header_SS, Watchdog, Business_Header, ut, did_Add, header_slimsort, didville, Business_Headerv2,mdr;

lIsDataland := _Dataset().IsDataland;

EXPORT Eq_Contacts(
	 dataset(layout_eq_employer												) pEq_Employer_file						= files(,lIsDataland).base.eq_employer.qa
	,dataset(Layout_Business_Header_Base							) pBusiness_header_file				= Files(,lIsDataland).Base.Business_Headers.built
	,dataset(business_header_ss.Layout_CompanyName_SS	) pCompanyname_file						= Files(,lIsDataland).Base.CompanyName.built
	,dataset(watchdog.Layout_Best											) pWatchdog_Best_file					= Watchdog.File_Best_nonglb
	,dataset(Layout_BH_Best														) pBusiness_Header_Best_file	= Files(,lIsDataland).Base.Business_Header_Best.built
	,string																							pPersistnameWithEmployer		= persistnames().EqContactsWithEmployer
	,string																							pPersistname2								= persistnames().EqContacts																
	,boolean																						pShouldRecalculatePersist		= true
	,boolean																						pEnableDebugging						= false
	,string																							pFileVersion								= 'built'
	,boolean																						pUseOtherEnvironment				= _Dataset().IsDataland
                                                                           
) :=
function

dFiltered_Eq_Employer_Base 	:= filters.eqcontacts(pEq_Employer_file);
pPersistname								:= persistnames().EqContacts;	// did this because u can't add to a string parameter
//and make it a persist name.  Says it needs a constant expression.

// -------------------------------------------------
// -- Blank Did on Eq Employer file
// -------------------------------------------------
layout_eq_employer tBlankDID(dFiltered_Eq_Employer_Base L) := transform
 self.did := 0;
 self := l;
end;

dEq_Emp_Blank_DID := project(dFiltered_Eq_Employer_Base,tBlankDID(left));

// -------------------------------------------------
// -- DID the Eq Employer file
// -------------------------------------------------
didmatchset := ['A','D','S','P','4','G','Z'];

did_add.Mac_Match_Flex(
	 dEq_Emp_Blank_DID					
	,didmatchset                   
	,ssn                        
	,dob                        
	,fname                      
	,mname                      
	,lname                      
	,name_suffix                
	,prim_range                 
	,prim_name                  
	,sec_range                  
	,zip                        
	,st                         
	,phone                      
	,did                        
	,layout_eq_employer       
	,true                       
	,did_score                  
	,75                         
	,dEq_Emp_DID_Append                    
);                      

Business_HeaderV2.macFix_Contact_DIDs(
	 dEq_Emp_DID_Append
	,did
	,lname
	,true
	,did_score
	,true
	,true
	,ssn
	,dEq_Emp_DID_Patched
);

dEq_Emp_DID_Patched_With_DID := dEq_Emp_DID_Patched(did>0);

header.Layout_Eq_Employer split1(dEq_Emp_DID_Patched_With_DID L) := transform
 self := l;
end;

dEq_Employer := project(dEq_Emp_DID_Patched_With_DID,split1(LEFT))(occupation_employer!='');

// -------------------------------------------------
// -- Remove Dups from Eq Employer file
// -------------------------------------------------
dEq_Employer_dis := distribute(dEq_Employer,hash(did));
dEq_Employer_srt := sort(dEq_Employer_dis,record,local);
dEq_Employer_dup := dedup(dEq_Employer_srt,local);

// -------------------------------------------------
// -- Rollup date first/last seens on Eq Employer file
// -------------------------------------------------
header.Layout_Eq_Employer rollDates(dEq_Employer L, dEq_Employer R) := transform
  self.dt_last_seen := if(l.dt_last_seen>r.dt_last_seen,l.dt_last_seen,r.dt_last_seen);
  self.dt_first_seen := if(l.dt_first_seen>r.dt_first_seen,r.dt_first_seen,l.dt_first_seen);
  self := r;
end;

dEq_Employer_sort4rollup := sort(dEq_Employer_dup,except dt_last_seen,except dt_first_seen,local);

dEq_Employer_date_rollup := rollup(dEq_Employer_sort4rollup,rolldates(left,right),except dt_last_seen,except dt_first_seen,local);

// -------------------------------------------------
// -- Remove Bunk Employers from Eq Employer file
// -------------------------------------------------
eqf := dEq_Employer_date_rollup;

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

layout_co_match TakePerson(eqf l) := TRANSFORM
	SELF := l;
END;

dEq_Employer_Good_Employers := PROJECT(eqf(occupation_employer != '',
	occupation_employer NOT IN SetBunkEmployers),
	TakePerson(LEFT));

// -------------------------------------------------
// -- Create Employer ranking table per DID from Eq Employer file
// -------------------------------------------------
RankEmployer(STRING1 et) :=	MAP(et = 'C' => 1,
								et = 'F' => 2,
								et = 'G' => 3,
								et = 'O' => 4,
								5);

employer_ranking_table_per_bdid := DEDUP(
	SORT(
	DISTRIBUTE(dEq_Employer_Good_Employers, HASH(occupation_employer)),
		occupation_employer, did, zip, RankEmployer(employer_type), -occupation_position, LOCAL),
		occupation_employer, did, zip, LOCAL)
			: PERSIST(pPersistnameWithEmployer);

//employer_ranking_table_per_bdid := dataset(pPersistnameWithEmployer	,layout_co_match						,flat);
// -------------------------------------------------
// -- Take just the unique employer names to bdid.
// -------------------------------------------------
layout_bdid := RECORD
	employer_ranking_table_per_bdid.occupation_employer;
	UNSIGNED6 bdid := 0;
	UNSIGNED1 score := 0;
END;

to_match := TABLE(employer_ranking_table_per_bdid, layout_bdid, occupation_employer, LOCAL);

// -------------------------------------------------
// -- Bdid Employer names only, with minimum 4 score(low)
// -------------------------------------------------
matchset := ['N'];
Business_Header_SS.MAC_Match_Flex(
	 to_match									// infile
	,matchset									// matchset
	,occupation_employer			// company_name_field
	,prange_field             // prange_field
	,pname_field              // pname_field
	,zip_field                // zip_field
	,srange_field             // srange_field
	,state_field              // state_field
	,phone_field              // phone_field
	,fein_field               // fein_field
	,bdid                  		// BDID_field
	,layout_bdid              // outrec
	,true                   	// bool_outrec_has_score
	,score                    // BDID_Score_field  			
	,bdid_assigned           	// outfile
	,75                       // keep_count = '1'
	,4                      	// score_threshold = '75'
	,pFileVersion							// Version of business header file to join against
	,pUseOtherEnvironment			// Pull above file from other environment?
);                             			
                            
bdid_assigned_persist := bdid_assigned : persist(pPersistname + '::bdid_assigned');

bdid_assigned_ := if(pEnableDebugging, bdid_assigned_persist, bdid_assigned);
// -------------------------------------------------
// -- Dedup business header file on bdid(must have zip code)
// -------------------------------------------------
bh_cands := pBusiness_header_file(zip != 0);

layout_bdid_zip :=
record
	bh_cands.bdid;
	bh_cands.zip;
end;

bh_cands_zips := table(bh_cands, layout_bdid_zip);
bh_cands_zips_dedup := dedup(bh_cands_zips, bdid, all);

bh_cands_zips_dedup_persist := bh_cands_zips_dedup
 	: persist(pPersistname + '::bh_cands_zips_dedup')
	;

bh_cands_zips_dedup_ := if(pEnableDebugging, bh_cands_zips_dedup_persist, bh_cands_zips_dedup);

// -------------------------------------------------
// -- Join to Slim Business header to get zip for each assigned bdid
// -------------------------------------------------
layout_bh_match := RECORD
	layout_bdid;
	UNSIGNED3 bh_zip;
END;

layout_bh_match GetZip(bdid_assigned l, bh_cands_zips_dedup_ r) := TRANSFORM
	SELF.bh_zip := r.zip;
	SELF := l;
END;

bh_recs := JOIN(
	DISTRIBUTE(bdid_assigned_(bdid != 0), HASH(bdid)),
	DISTRIBUTE(bh_cands_zips_dedup_, HASH(bdid)),
	LEFT.bdid = RIGHT.bdid,
	GetZip(LEFT, RIGHT),
	LOCAL)
	;
bh_recs_persist := bh_recs
 	: persist(pPersistname + '::bh_recs')
	;

bh_recs_ := if(pEnableDebugging, bh_recs_persist, bh_recs);

// -------------------------------------------------
// -- Dedup by bdid, employer, and zip
// -------------------------------------------------
bh_ded := DEDUP(SORT(bh_recs_, bdid, occupation_employer, bh_zip, LOCAL), 
							bdid, occupation_employer, bh_zip, LOCAL);

bh_recs_dist := DISTRIBUTE(bh_ded, HASH(occupation_employer))
	;
bh_recs_dist_persist := bh_recs_dist
 	: persist(pPersistname + '::bh_recs_dist')
	;

bh_recs_dist_ := if(pEnableDebugging, bh_recs_dist_persist, bh_recs_dist);

// Take the did/employer/zip records based on employer name
// and zip distance.
layout_did_bdid := RECORD
	layout_co_match;
	layout_bh_match.bdid;
	layout_bh_match.score;
END;
	
layout_did_bdid TakeMatch(employer_ranking_table_per_bdid l, bh_recs_dist_ r) := TRANSFORM
	SELF := l;
	SELF := r;
END;

j_all := JOIN(
	employer_ranking_table_per_bdid,
	bh_recs_dist_,
	LEFT.occupation_employer = RIGHT.occupation_employer,
	TakeMatch(LEFT, RIGHT), KEEP(1), LOCAL)
	;

j_all_persist := j_all
 	: persist(pPersistname + '::j_all')
	;

j_all_ := if(pEnableDebugging, j_all_persist, j_all);

//OUTPUT(COUNT(j_all), named('count_of_eq_recs_with_bdid'));
//OUTPUT(COUNT(DEDUP(j_all, did, ALL)), named('count_of_eq_dids_with_bdid'));

// In the zip range joins, we need to only know if a did-employer
// combination matched none, 1, or more bdids.
j_z15 := JOIN(
	employer_ranking_table_per_bdid,
	bh_recs_dist_,
	LEFT.occupation_employer = RIGHT.occupation_employer AND
	ut.zip_Dist(LEFT.zip, INTFORMAT(RIGHT.bh_zip, 5, 1)) < 15,
	TakeMatch(LEFT, RIGHT), KEEP(2), LOCAL)
		;
j_z15_persist := j_z15
	 	: persist(pPersistname + '::j_z15')
	;

j_z15_ := if(pEnableDebugging, j_z15_persist, j_z15);

j_z50 := JOIN(
	employer_ranking_table_per_bdid,
	bh_recs_dist_,
	LEFT.occupation_employer = RIGHT.occupation_employer AND
	ut.zip_Dist(LEFT.zip, INTFORMAT(RIGHT.bh_zip, 5, 1)) < 50,
	TakeMatch(LEFT, RIGHT), KEEP(2), LOCAL)
	;

j_z50_persist := j_z50
 	: persist(pPersistname + '::j_z50')
	;

j_z50_ := if(pEnableDebugging, j_z50_persist, j_z50);

layout_companies_per_did_15 := RECORD
	j_z15_.occupation_employer;
	j_z15_.did;
	UNSIGNED4 companiess := COUNT(GROUP);
END;

emp_stat_15 := TABLE(DEDUP(sort(j_z15_, occupation_employer, did, bdid, local), 
													 occupation_employer, did, bdid, LOCAL), 
	layout_companies_per_did_15, occupation_employer, did, LOCAL)
	;

emp_stat_15_persist := emp_stat_15
 	: persist(pPersistname + '::emp_stat_15')
	;

emp_stat_15_ := if(pEnableDebugging, emp_stat_15_persist, emp_stat_15);

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
	j_z15_, emp_stat_15_(companiess = 1),
	LEFT.occupation_employer = RIGHT.occupation_employer AND
	LEFT.did = RIGHT.did,
	MakeContact(LEFT), LOCAL)
	;

c15_persist := c15
 	: persist(pPersistname + '::c15')
	;

c15_ := if(pEnableDebugging, c15_persist, c15);

// Get rid of multiple zips and employers that map to the same bdid.
c15_ded := DEDUP(
			SORT(
				DISTRIBUTE(c15_, HASH(did)), did, bdid, -occupation_position, LOCAL),
				did, bdid, LOCAL)
				;

c15_ded_persist := c15_ded
			 	: persist(pPersistname + '::c15_ded')
	;

c15_ded_ := if(pEnableDebugging, c15_ded_persist, c15_ded);
				

layout_companies_per_did_50 := RECORD
	j_z50_.occupation_employer;
	j_z50_.did;
	UNSIGNED4 companiess := COUNT(GROUP);
END;

emp_stat_50 := TABLE(DEDUP(sort(j_z50_, occupation_employer, did, bdid, LOCAL),
													 occupation_employer, did, bdid, LOCAL), 
										 layout_companies_per_did_50, occupation_employer, did, LOCAL)
;

emp_stat_50_persist := emp_stat_50
			 	: persist(pPersistname + '::emp_stat_50')
	;

emp_stat_50_ := if(pEnableDebugging, emp_stat_50_persist, emp_stat_50);

c50 := JOIN(
	j_z50_, emp_stat_50_(companiess = 1),
	LEFT.occupation_employer = RIGHT.occupation_employer AND
	LEFT.did = RIGHT.did,
	MakeContact(LEFT), LOCAL)
	;

c50_persist := c50
	: persist(pPersistname + '::c50')
	;

c50_ := if(pEnableDebugging, c50_persist, c50);

c_primary_ded := DEDUP(
			SORT(
				c15_ded_ + DISTRIBUTE(c50_, HASH(did)), did, bdid, -occupation_position, LOCAL),
				did, bdid, LOCAL)
;
c_primary_ded_persist := c_primary_ded
	: persist(pPersistname + '::c_primary_ded')
	;

c_primary_ded_ := if(pEnableDebugging, c_primary_ded_persist, c_primary_ded);

// If we can bdid the un-bdid'd employers using a looser company
// name match, include them with a 0 bdid.
looser_name := bdid_assigned(bdid = 0);
co_names := pCompanyname_file;

//add rid to looser name, dedup to cut down records
dedup_looser_name := dedup(sort(DISTRIBUTE(looser_name, HASH(occupation_employer)),occupation_employer,local),occupation_employer,local);
looser_name_rid   := project(dedup_looser_name,transform({recordof(looser_name),unsigned8 rid},self.rid := counter,self := left));

//cut down co_names record, dedup before join
slim_co_names   := project(co_names, transform({qstring35 clean_company_name}, self.clean_company_name := (qstring35)left.clean_company_name[1..35]));
dedup_co_names  := dedup(sort(DISTRIBUTE(slim_co_names, HASH(clean_company_name)),clean_company_name,local),clean_company_name,local);

layout_bdid_xtra := {layout_bdid,boolean issimilar,unsigned8 rid};
layout_bdid_xtra TakeEmployer(looser_name_rid l,dedup_co_names r) := TRANSFORM
	SELF.score              := 0;
	SELF.bdid               := 0;
  self.issimilar          := ut.CompanySimilar100(l.occupation_employer, r.clean_company_name[1..35]) < 25;
  self.rid                := l.rid;
	SELF := l;
END;

loose_bdid_assigned_join := JOIN(
   DISTRIBUTE(looser_name_rid ,HASH(occupation_employer [1..8]))
  ,DISTRIBUTE(dedup_co_names  ,HASH(clean_company_name  [1..8]))
  ,LEFT.occupation_employer[1..8] = RIGHT.clean_company_name[1..8]
  ,TakeEmployer(LEFT,right)
  ,LOCAL
  ,keep(20)
)(issimilar = true);

loose_bdid_assigned := project(dedup(sort(distribute(loose_bdid_assigned_join,rid),rid,local),rid,local),layout_bdid);

loose_bdid_assigned_persist := loose_bdid_assigned
	: persist(pPersistname + '::loose_bdid_assigned')
	;

loose_bdid_assigned_ := if(pEnableDebugging, loose_bdid_assigned_persist, loose_bdid_assigned);

	
layout_did_bdid TakeDID(employer_ranking_table_per_bdid l, loose_bdid_assigned_ r) := TRANSFORM
	SELF := l;
	SELF := r;
END;

j_loose := JOIN(
	employer_ranking_table_per_bdid, 
	DISTRIBUTE(loose_bdid_assigned_, HASH(occupation_employer)),
	LEFT.occupation_employer = RIGHT.occupation_employer,
	TakeDID(LEFT, RIGHT), KEEP(1), LOCAL)
	;

j_loose_persist := j_loose
	: persist(pPersistname + '::j_loose')
	;

j_loose_ := if(pEnableDebugging, j_loose_persist, j_loose);

//OUTPUT(CHOOSEN(loose_bdid_assigned_, 100), NAMED('Loosely_matched_employers_sample'));

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
	DISTRIBUTE(j_all_ + j_loose_, HASH(did)),
	c_unique_match_dids,
	LEFT.did = RIGHT.did,
	MakeSecondaryContact(LEFT),
	LEFT ONLY, LOCAL);

c_sec_ded := DEDUP(
			SORT(c_secondary, did, occupation_employer, -occupation_position, LOCAL),
			 did, occupation_employer, LOCAL)
	;

c_sec_ded_persist := c_sec_ded
	: persist(pPersistname + '::c_sec_ded')
	;

c_sec_ded_ := if(pEnableDebugging, c_sec_ded_persist, c_sec_ded);

c_all := c_primary_ded + c_sec_ded;

c_all_persist := c_all
	: persist(pPersistname + '::c_all')
	;

c_all_ := if(pEnableDebugging, c_all_persist, c_all);

//OUTPUT(COUNT(DEDUP(c_all_, did)), NAMED('total_dids_added'));

// Get best info for all DIDs
bst_hdr := pWatchdog_Best_file;

cntct_tmp := Business_Header.Layout_Business_Contacts_Temp;
cntct_tmp AddPersonInfo(bst_hdr l, c_all_ r) := TRANSFORM
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
	SELF.source := MDR.sourceTools.src_Eq_Employer;
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
	c_all_,
	LEFT.did = RIGHT.did AND
	LEFT.lname != '',
	AddPersonInfo(LEFT, RIGHT), LOCAL, right outer)
	;

contact_person_persist := contact_person
	: persist(pPersistname + '::contact_person')
	;

contact_person_ := if(pEnableDebugging, contact_person_persist, contact_person);


bst_bus_hdr := pBusiness_Header_Best_file;

cntct_tmp AddCompanyInfo(bst_bus_hdr l, contact_person_ r) := TRANSFORM
	
	nomatch := if(l.bdid = 0, true, false);
	
	// if bdid does not match bh best file, use the company name from eq employer
	SELF.company_name					:= if(nomatch,r.company_name	,l.company_name	);
	// eq employer doesn't have address, phone or fein information so not losing anything by taking only matches
	SELF.company_prim_range		:= l.prim_range		;
	SELF.company_predir				:= l.predir				;
	SELF.company_prim_name		:= l.prim_name		;
	SELF.company_addr_suffix	:= l.addr_suffix	;
	SELF.company_postdir			:= l.postdir			;
	SELF.company_unit_desig		:= l.unit_desig		;
	SELF.company_sec_range		:= l.sec_range		;
	SELF.company_city					:= l.city					;
	SELF.company_state				:= l.state				;
	SELF.company_zip					:= l.zip					;
	SELF.company_zip4					:= l.zip4					;
	SELF.company_phone				:= l.phone				;
	SELF.company_fein					:= l.fein					;
	SELF											:= r;         
END;

contact_business := JOIN(
	DISTRIBUTE(bst_bus_hdr, HASH(bdid)),
	DISTRIBUTE(contact_person_(bdid != 0), HASH(bdid)),
	LEFT.bdid = RIGHT.bdid,
	AddCompanyInfo(LEFT, RIGHT), LOCAL, right outer)
	;

contact_business_persist := contact_business
	: persist(pPersistname + '::contact_business')
	;

contact_business_ := if(pEnableDebugging, contact_business_persist, contact_business);

contact_full := contact_person_(bdid = 0)
							+ contact_business_
							: PERSIST(pPersistname);

returndataset := if(pShouldRecalculatePersist = true, contact_full
																										, persists().EqContacts
									);
return returndataset;

end;