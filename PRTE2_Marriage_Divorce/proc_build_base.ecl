IMPORT PRTE2_Marriage_Divorce, marriage_divorce_v2, ut, PromoteSupers, Address, STD, PRTE2, NID;

EXPORT proc_build_base := FUNCTION

//Base Input
// ds_in := Files.Main_in;
prte2.CleanFields(Files.Main_in,Main_Clean);


//Normalize Base(multiple names with different DID in input: party2, party2a)
Layouts.Main_Base_out NormBase(Main_Clean le, integer c) := TRANSFORM
 //SELF.process_date := (string8)STD.Date.Today(); future use
	SELF.party1_csz := IF(trim(le.party1_city_name) <> '', trim(le.party1_city_name)+ ', ', '')
																						+ trim(le.party1_state) + ' ' + trim(le.party1_zip);
	SELF.party2_name	:= choose(c,le.party2_name, le.party2a_name);
	SELF.party2_alias	:= choose(c,le.party2_alias, IF(trim(le.party2a_name) = trim(le.party2_alias),'',le.party2_alias));
 	SELF.party2_csz			:= IF(trim(le.party2_city_name) <> '', trim(le.party2_city_name)+ ', ', '')
																						+ trim(le.party2_state) + ' ' + trim(le.party2_zip);
	SELF.persistent_record_id := HASH64(le.filing_type
																		+ le.filing_subtype
																		+ le.state_origin
																		+ le.party1_name
																		+ le.party1_alias
																		+ le.party1_dob
																		+ le.party1_birth_state
																		+ le.party1_age
																		+ le.party1_race
																		+ le.party1_addr1
																		+ le.party1_city_name
																		+ le.party1_state
																		+ le.party1_zip
																		+ le.party1_county
																		+ le.party1_previous_marital_status
																		+ le.party1_how_marriage_ended
																		+ le.party1_times_married
																		+ le.party1_last_marriage_end_dt
																		+ le.party2_name
																		+ le.party2_alias
																		+ le.party2_dob
																		+ le.party2_birth_state
																		+ le.party2_age
																		+ le.party2_race
																		+ le.party2_addr1
																		+ le.party2_city_name
																		+ le.party2_state
																		+ le.party2_zip
																		+ le.party2_county
																		+ le.party2_previous_marital_status
																		+ le.party2_how_marriage_ended
																		+ le.party2_times_married
																		+ le.party2_last_marriage_end_dt
																		+ le.number_of_children
																		+ le.marriage_filing_dt
																		+ le.marriage_dt
																		+ le.marriage_city
																		+ le.marriage_county
																		+ le.place_of_marriage
																		+ le.type_of_ceremony
																		+ le.marriage_filing_number
																		+ le.marriage_docket_volume
																		+ le.divorce_filing_dt
																		+ le.divorce_dt
																		+ le.divorce_docket_volume
																		+ le.divorce_filing_number
																		+ le.divorce_city
																		+ le.divorce_county
																		+ le.grounds_for_divorce
																		+ le.marriage_duration_cd
																		+ le.marriage_duration);
	
 self.party1_age			:= if(le.cust_name <> '' and le.party1_age = '', (string)ut.Age((integer)le.party1_dob), le.party1_age);
	self.party2_age			:= if(le.cust_name <> '' and le.party2_age = '', (string)ut.Age((integer)le.party2_dob), le.party2_age);
	SELF          			:= le;
	SELF := [];
END;

nMainBase	:= NORMALIZE(Main_Clean,IF(trim(left.party2a_name) <> '',2,1),NormBase(left,counter));
dMainBase := DEDUP(SORT(nMainBase, record_id, party1_name, party2_name), ALL); 

//Normalize for Search Base
lPartyNorm := RECORD
	Layouts.Search_Base;
	STRING2		orig_residence_st;
	STRING50  party_addr;
	STRING50  party_csz;
	STRING9		SSN;
	STRING20	cust_name;
	STRING10	bug_num;
	STRING8		link_dob;
	STRING9		link_ssn;
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
	tmp_party1_csz := IF(trim(le.party1_city_name) <> '', trim(le.party1_city_name)+ ', ', '')
																						+ trim(le.party1_state) + ' ' + trim(le.party1_zip);
	tmp_party2_csz := IF(trim(le.party2_city_name) <> '', trim(le.party2_city_name)+ ', ', '')
																						+ trim(le.party2_state) + ' ' + trim(le.party2_zip);
	SELF.party_csz	:= choose(c,tmp_party1_csz, tmp_party2_csz, tmp_party1_csz, tmp_party2_csz);
	SELF.SSN				:= choose(c,le.party1_ssn, le.party2_ssn, le.party1_ssn, le.party2_ssn);

//Adding link fields
	SELF.LINK_DOB		:= choose(c, le.link_party1_dob, le.link_party2_dob, le.link_party1_dob, le.link_party2_dob);
	SELF.LINK_SSN		:= choose(c, le.link_party1_ssn, le.link_party2_ssn, le.link_party1_ssn, le.link_party2_ssn);	
	SELF          	:= le;
	SELF 						:= [];
END;


n_prep_rec := NORMALIZE(Main_Clean(party1_name<>''),IF(trim(left.party2a_name) <> '',4,
																										IF(trim(left.party1_alias) <> '',3,
																										IF(trim(left.party2_name) <> '',2,1))),t_did_prep_rec(left,counter));

//Added NID cleaner to clean FULL Names better
NID.Mac_CleanFullNames(n_prep_rec, FileClnName, nameasis,  _nameorder := 'L',	,includeInRepository:=false, normalizeDualNames:=false);
																				 
//Clean Name/Address
Layouts.Search_Base_ext ClnNameAddr(FileClnName le) := TRANSFORM
	SELF.dt_first_seen						:= le.dt_first_seen;
 SELF.dt_last_seen							:= le.dt_last_seen;
 SELF.dt_vendor_first_reported	:= le.dt_vendor_first_reported;
 SELF.dt_vendor_last_reported	:= le.dt_vendor_last_reported;

//Some names are not cleaning at all, added legacy cleaner
isBlankClnName := length(std.str.cleanspaces(le.cln_title + le.cln_fname + le.mname + le.cln_lname + le.cln_suffix)) = 0;
string73 v_pname_party 				:= IF(isBlankClnName and le.nameasis_name_format = 'L' or STD.Str.Find(le.nameasis,',',1) > 0,
																																						address.CleanPersonLFM73(le.nameasis), 
																																						address.CleanPersonFML73(le.nameasis)
																																		);											
																																		 
	SELF.title								:= if(NOT isBlankClnName,le.cln_title,v_pname_party[1..5]);
 SELF.fname	      	:= if(NOT isBlankClnName,le.cln_fname, v_pname_party[6..25]);      
 SELF.mname	      	:= if(NOT isBlankClnName,le.cln_mname,v_pname_party[26..45]);      
 SELF.lname	      	:= if(NOT isBlankClnName,le.cln_lname,v_pname_party[46..65]);
 SELF.name_suffix		:= if(NOT isBlankClnName,le.cln_suffix,v_pname_party[66..70]);
 
	string182 v_clean_addr 				:= address.cleanaddress182(le.party_addr,le.party_csz);
 SELF.prim_range		:= v_clean_addr[1..10];
	SELF.predir						:= v_clean_addr[11..12];
	SELF.prim_name			:= v_clean_addr[13..40];
	SELF.suffix						:= v_clean_addr[41..44];
	SELF.postdir					:= v_clean_addr[45..46];
	SELF.unit_desig		:= v_clean_addr[47..56];
 SELF.sec_range			:= v_clean_addr[57..64];
	SELF.p_city_name	:= v_clean_addr[65..89];
 SELF.v_city_name	:= v_clean_addr[90..114];
	SELF.st										:= IF(v_clean_addr[115..116]<>'', v_clean_addr[115..116], le.orig_residence_st);
	SELF.zip									:= v_clean_addr[117..121];
	SELF.zip4								:= v_clean_addr[122..125];
	SELF.cart								:= v_clean_addr[126..129];
	SELF.cr_sort_sz		:= v_clean_addr[130..130];
 SELF.lot									:= v_clean_addr[131..134];
	SELF.lot_order			:= v_clean_addr[135..135];
	SELF.dbpc								:= v_clean_addr[136..137];
	SELF.chk_digit			:= v_clean_addr[138..138];
	SELF.rec_type				:= v_clean_addr[139..140];
	SELF.county						:= v_clean_addr[141..145];
	SELF.geo_lat					:= v_clean_addr[146..155];
	SELF.geo_long				:= v_clean_addr[156..166];
	SELF.msa									:= v_clean_addr[167..170];
	SELF.geo_blk					:= v_clean_addr[171..177];
	SELF.geo_match			:= v_clean_addr[178..178];
	SELF.err_stat				:= v_clean_addr[179..182];
	
	SELF.persistent_record_id	:= HASH64(le.record_id +','
																																			+ le.vendor +','
																																			+	le.party_type +','
																																			+	le.which_party +','
																																			+	le.nameasis +','
																																			+	le.nameasis_name_format +','
																																			+ le.party_addr +','
																																			+ le.party_csz +','
																																			+ le.dob +','
																																			+ le.age +','
																																			+ le.birth_state +','
																																			+ le.race +','
																																			+ le.party_county +','
																																			+ le.previous_marital_status +','
																																			+ le.how_marriage_ended +','
																																			+ le.times_married +','
																																			+ le.last_marriage_end_dt
																																		 );
	SELF := le;
	END;
	
	dsCleanNameAddr:= PROJECT(FileClnName, ClnNameAddr(LEFT));

Layouts.Search_Base_ext  AppendDid(dsCleanNameAddr le) := TRANSFORM
	SELF.DID			:= IF(TRIM(le.cust_name) <> '', Prte2.fn_AppendFakeID.did(le.fname, le.lname, le.link_ssn, le.link_dob, le.CUST_NAME),le.DID);
	SELF.age			:= if(le.cust_name <> '' and le.age = '', (string)ut.Age((integer)le.dob), le.age);									
	SELF	:= le;
END;

pClnSearch	:= PROJECT(	dsCleanNameAddr(trim(nameasis) <> ''), AppendDid(left));
dClnSearch	:= DEDUP(SORT(pClnSearch,record_id, did, nameasis, prim_range, prim_name, v_city_name, st, zip), did, nameasis, prim_range, prim_name, v_city_name, st, zip);

//Build Base files
PromoteSupers.Mac_SF_BuildProcess(dMainBase, Constants.BASE_PREFIX +'main', build_base);
PromoteSupers.Mac_SF_BuildProcess(dClnSearch, Constants.BASE_PREFIX +'search', build_search);	 

RETURN SEQUENTIAL(build_base, build_search);

END;
