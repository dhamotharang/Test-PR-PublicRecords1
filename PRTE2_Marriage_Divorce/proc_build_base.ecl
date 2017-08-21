IMPORT PRTE2_Marriage_Divorce, marriage_divorce_v2, ut, PromoteSupers, Address, STD, PRTE2;

EXPORT proc_build_base := FUNCTION

//Base Input
ds_in := Files.Main_in;

//Normalize Base(multiple names with different DID in input: party2, party2a)
Layouts.Main_Base_out NormBase(ds_in le, integer c) := TRANSFORM
 //SELF.process_date := (string8)STD.Date.Today(); future use
	SELF.party1_csz := ut.CleanSpacesAndUpper(IF(trim(le.party1_city_name) <> '', trim(le.party1_city_name)+ ', ', '')
																						+ trim(le.party1_state) + ' ' + trim(le.party1_zip));
	SELF.party2_name	:= choose(c,le.party2_name, le.party2a_name);
	SELF.party2_alias	:= choose(c,le.party2_alias, IF(trim(le.party2a_name) = trim(le.party2_alias),'',le.party2_alias));
 	SELF.party2_csz			:= ut.CleanSpacesAndUpper(IF(trim(le.party2_city_name) <> '', trim(le.party2_city_name)+ ', ', '')
																						+ trim(le.party2_state) + ' ' + trim(le.party2_zip));
	SELF.persistent_record_id := HASH64(ut.CleanSpacesAndUpper(le.filing_type)
																		+ ut.CleanSpacesAndUpper(le.filing_subtype)
																		+ ut.CleanSpacesAndUpper(le.state_origin)
																		+ ut.CleanSpacesAndUpper(le.party1_name)
																		+ ut.CleanSpacesAndUpper(le.party1_alias)
																		+ ut.CleanSpacesAndUpper(le.party1_dob)
																		+ ut.CleanSpacesAndUpper(le.party1_birth_state)
																		+ ut.CleanSpacesAndUpper(le.party1_age)
																		+ ut.CleanSpacesAndUpper(le.party1_race)
																		+ ut.CleanSpacesAndUpper(le.party1_addr1)
																		+ ut.CleanSpacesAndUpper(le.party1_city_name)
																		+ ut.CleanSpacesAndUpper(le.party1_state)
																		+ ut.CleanSpacesAndUpper(le.party1_zip)
																		+ ut.CleanSpacesAndUpper(le.party1_county)
																		+ ut.CleanSpacesAndUpper(le.party1_previous_marital_status)
																		+ ut.CleanSpacesAndUpper(le.party1_how_marriage_ended)
																		+ ut.CleanSpacesAndUpper(le.party1_times_married)
																		+ ut.CleanSpacesAndUpper(le.party1_last_marriage_end_dt)
																		+ ut.CleanSpacesAndUpper(le.party2_name)
																		+ ut.CleanSpacesAndUpper(le.party2_alias)
																		+ ut.CleanSpacesAndUpper(le.party2_dob)
																		+ ut.CleanSpacesAndUpper(le.party2_birth_state)
																		+ ut.CleanSpacesAndUpper(le.party2_age)
																		+ ut.CleanSpacesAndUpper(le.party2_race)
																		+ ut.CleanSpacesAndUpper(le.party2_addr1)
																		+ ut.CleanSpacesAndUpper(le.party2_city_name)
																		+ ut.CleanSpacesAndUpper(le.party2_state)
																		+ ut.CleanSpacesAndUpper(le.party2_zip)
																		+ ut.CleanSpacesAndUpper(le.party2_county)
																		+ ut.CleanSpacesAndUpper(le.party2_previous_marital_status)
																		+ ut.CleanSpacesAndUpper(le.party2_how_marriage_ended)
																		+ ut.CleanSpacesAndUpper(le.party2_times_married)
																		+ ut.CleanSpacesAndUpper(le.party2_last_marriage_end_dt)
																		+ ut.CleanSpacesAndUpper(le.number_of_children)
																		+ ut.CleanSpacesAndUpper(le.marriage_filing_dt)
																		+ ut.CleanSpacesAndUpper(le.marriage_dt)
																		+ ut.CleanSpacesAndUpper(le.marriage_city)
																		+ ut.CleanSpacesAndUpper(le.marriage_county)
																		+ ut.CleanSpacesAndUpper(le.place_of_marriage)
																		+ ut.CleanSpacesAndUpper(le.type_of_ceremony)
																		+ ut.CleanSpacesAndUpper(le.marriage_filing_number)
																		+ ut.CleanSpacesAndUpper(le.marriage_docket_volume)
																		+ ut.CleanSpacesAndUpper(le.divorce_filing_dt)
																		+ ut.CleanSpacesAndUpper(le.divorce_dt)
																		+ ut.CleanSpacesAndUpper(le.divorce_docket_volume)
																		+ ut.CleanSpacesAndUpper(le.divorce_filing_number)
																		+ ut.CleanSpacesAndUpper(le.divorce_city)
																		+ ut.CleanSpacesAndUpper(le.divorce_county)
																		+ ut.CleanSpacesAndUpper(le.grounds_for_divorce)
																		+ ut.CleanSpacesAndUpper(le.marriage_duration_cd)
																		+ ut.CleanSpacesAndUpper(le.marriage_duration));
	SELF          			:= le;
	SELF := [];
END;

nMainBase	:= NORMALIZE(ds_in,IF(trim(left.party2a_name) <> '',2,1),NormBase(left,counter));
dMainBase := DEDUP(SORT(nMainBase, record_id, party1_name, party2_name), ALL); 

//Normalize for Search Base
lPartyNorm := RECORD
	Layouts.Search_Base;
	STRING2		orig_residence_st;
	STRING50  party_addr;
	STRING50  party_csz;
	STRING9		SSN;
	STRING20	CUST_NAME;
END;
	
lPartyNorm t_did_prep_rec(Layouts.Main_in le, integer c) := TRANSFORM
	SELF.did				 := choose(c,le.party1_did, le.party2_did, le.party1_did, le.party2a_did);
	SELF.party_type  := choose(c,le.party1_type, le.party2_type, le.party1_type, le.party2a_type);
	SELF.which_party := choose(c,'P1','P2','P1A','P2A');
	self.name_sequence := '';
	SELF.nameasis    := choose(c,le.party1_name, le.party2_name, le.party1_alias, le.party2a_name);
	SELF.nameasis_name_format := choose(c,le.party1_name_format,le.party2_name_format,le.party1_name_format,le.party2a_name_format);
	SELF.dob      := choose(c,le.party1_dob, le.party2_dob, le.party1_dob, le.party2_dob);
	SELF.age      := choose(c,le.party1_age, le.party2_age, le.party1_age, le.party2_age);
	SELF.birth_state	:= choose(c,le.party1_birth_state, le.party2_birth_state, le.party1_birth_state, le.party2_birth_state);
	SELF.race					:= choose(c,le.party1_race, le.party2_race, le.party1_race, le.party2_race);
	SELF.party_county	:= choose(c,le.party1_county, le.party2_county, le.party1_county, le.party2_county);
	SELF.previous_marital_status:= choose(c,le.party1_previous_marital_status, le.party2_previous_marital_status, le.party1_previous_marital_status, le.party2_previous_marital_status);
	SELF.how_marriage_ended			:= choose(c,le.party1_how_marriage_ended, le.party2_how_marriage_ended, le.party1_how_marriage_ended, le.party2_how_marriage_ended);
	SELF.times_married					:= choose(c,le.party1_times_married, le.party2_times_married, le.party1_times_married, le.party2_times_married);
	SELF.last_marriage_end_dt		:= choose(c,le.party1_last_marriage_end_dt, le.party2_last_marriage_end_dt, le.party1_last_marriage_end_dt, le.party2_last_marriage_end_dt);
	SELF.orig_residence_st			:= choose(c,if(trim(le.party1_state)<> '',le.party1_state,''),
																					if(trim(le.party2_state)<> '',le.party2_state,''),
																					if(trim(le.party1_state)<> '',le.party1_state,''),
																					if(trim(le.party2_state)<> '',le.party2_state,'')
																				);
	SELF.party_addr	:= choose(c,le.party1_addr1, le.party2_addr1, le.party1_addr1, le.party2_addr1);
	tmp_party1_csz := ut.CleanSpacesAndUpper(IF(trim(le.party1_city_name) <> '', trim(le.party1_city_name)+ ', ', '')
																						+ trim(le.party1_state) + ' ' + trim(le.party1_zip));
	tmp_party2_csz := ut.CleanSpacesAndUpper(IF(trim(le.party2_city_name) <> '', trim(le.party2_city_name)+ ', ', '')
																						+ trim(le.party2_state) + ' ' + trim(le.party2_zip));
	SELF.party_csz	:= choose(c,tmp_party1_csz, tmp_party2_csz, tmp_party1_csz, tmp_party2_csz);
	SELF.SSN				:= choose(c,le.party1_ssn, le.party2_ssn, le.party1_ssn, le.party2_ssn);
	SELF          	:= le;
	SELF 						:= [];
END;

n_prep_rec := NORMALIZE(ds_in(party1_name<>''),IF(trim(left.party2a_name) <> '',4,
																								IF(trim(left.party1_alias) <> '',3,
																								IF(trim(left.party2_name) <> '',2,1))),t_did_prep_rec(left,counter));
																				 
//Clean Name/Address
Layouts.Search_base ClnNameAddr(n_prep_rec le) := TRANSFORM
	SELF.dt_first_seen	:= le.dt_first_seen;
  SELF.dt_last_seen		:= le.dt_last_seen;
  SELF.dt_vendor_first_reported	:= le.dt_vendor_first_reported;
  SELF.dt_vendor_last_reported	:= le.dt_vendor_last_reported;
	string73 v_pname_party := IF(le.nameasis_name_format = 'L' or STD.Str.Find(le.nameasis,',',1) > 0, address.CleanPersonLFM73(le.nameasis),	address.CleanPersonFML73(le.nameasis));
	string182 v_clean_addr := address.cleanaddress182(le.party_addr,le.party_csz);
	
	SELF.title				:= v_pname_party[1..5];
	SELF.fname				:= v_pname_party[6..25];
	SELF.mname				:= v_pname_party[26..45];
	SELF.lname				:= v_pname_party[46..65];
	SELF.name_suffix	:= v_pname_party[66..70];
	
	SELF.prim_range		:= v_clean_addr[1..10];
	SELF.predir				:= v_clean_addr[11..12];
	SELF.prim_name		:= v_clean_addr[13..40];
	SELF.suffix				:= v_clean_addr[41..44];
	SELF.postdir			:= v_clean_addr[45..46];
	SELF.unit_desig		:= v_clean_addr[47..56];
 	SELF.sec_range		:= v_clean_addr[57..64];
	SELF.p_city_name	:= v_clean_addr[65..89];
 	SELF.v_city_name	:= v_clean_addr[90..114];
	SELF.st						:= IF(v_clean_addr[115..116]<>'', v_clean_addr[115..116], le.orig_residence_st);
	SELF.zip					:= v_clean_addr[117..121];
	SELF.zip4					:= v_clean_addr[122..125];
	SELF.cart					:= v_clean_addr[126..129];
	SELF.cr_sort_sz		:= v_clean_addr[130..130];
 	SELF.lot					:= v_clean_addr[131..134];
	SELF.lot_order		:= v_clean_addr[135..135];
	SELF.dbpc					:= v_clean_addr[136..137];
	SELF.chk_digit		:= v_clean_addr[138..138];
	SELF.rec_type			:= v_clean_addr[139..140];
	SELF.county				:= v_clean_addr[141..145];
	SELF.geo_lat			:= v_clean_addr[146..155];
	SELF.geo_long			:= v_clean_addr[156..166];
	SELF.msa					:= v_clean_addr[167..170];
	SELF.geo_blk			:= v_clean_addr[171..177];
	SELF.geo_match		:= v_clean_addr[178..178];
	SELF.err_stat			:= v_clean_addr[179..182];
	SELF.persistent_record_id	:= HASH64(le.record_id +','
																		+ STD.Str.ToUpperCase(le.vendor) +','
																		+	STD.Str.ToUpperCase(le.party_type) +','
																		+	STD.Str.ToUpperCase(le.which_party) +','
																		+	STD.Str.ToUpperCase(le.nameasis) +','
																		+	STD.Str.ToUpperCase(le.nameasis_name_format) +','
																		+ STD.Str.ToUpperCase(le.party_addr) +','
																		+ STD.Str.ToUpperCase(le.party_csz) +','
																		+ STD.Str.ToUpperCase(le.dob) +','
																		+ STD.Str.ToUpperCase(le.age) +','
																		+ STD.Str.ToUpperCase(le.birth_state) +','
																		+ STD.Str.ToUpperCase(le.race) +','
																		+ STD.Str.ToUpperCase(le.party_county) +','
																		+ STD.Str.ToUpperCase(le.previous_marital_status) +','
																		+ STD.Str.ToUpperCase(le.how_marriage_ended) +','
																		+ STD.Str.ToUpperCase(le.times_married) +','
																		+ STD.Str.ToUpperCase(le.last_marriage_end_dt)
																			);
	SELF.DID			:= IF(TRIM(le.cust_name) <> '',
										Prte2.fn_AppendFakeID.did(SELF.fname, SELF.lname, le.SSN, le.DOB, le.CUST_NAME),le.DID);
	SELF	:= le;
END;

pClnSearch	:= PROJECT(n_prep_rec(trim(nameasis) <> ''), ClnNameAddr(left));
dClnSearch	:= DEDUP(SORT(pClnSearch,record_id, did, nameasis, prim_range, prim_name, v_city_name, st, zip), did, nameasis, prim_range, prim_name, v_city_name, st, zip);

//Build Base files
PromoteSupers.Mac_SF_BuildProcess(dMainBase, Constants.BASE_PREFIX +'main', build_base);
PromoteSupers.Mac_SF_BuildProcess(dClnSearch, Constants.BASE_PREFIX +'search', build_search);	 

RETURN SEQUENTIAL(build_base, build_search);

END;
