import VotersV2, ut, doxie, autokey, AutokeyB2, RoxieKeyBuild, header_services;

export Proc_Build_Voters_Keys(string filedate) := function

RoxieKeyBuild.MAC_SK_BuildProcess_v2_local(VotersV2.Key_Voters_DID,
                       '~thor_data400::key::voters::@version@::did','~thor_data400::key::voters::'+filedate+'::did',
                       bld_did_key);

RoxieKeyBuild.MAC_SK_BuildProcess_v2_local(Key_Voters_VTID,
											 '~thor_data400::key::voters::@version@::VTID','~thor_data400::key::voters::'+filedate+'::VTID',
											 bld_VTID_key);

RoxieKeyBuild.MAC_SK_BuildProcess_v2_local(Key_Voters_History_VTID,
											 '~thor_data400::key::voters::@version@::History_VTID','~thor_data400::key::voters::'+filedate+'::History_VTID',
											 bld_History_VTID_key);

RoxieKeyBuild.MAC_SK_BuildProcess_v2_local(Key_Voters_States(),
											 '~thor_data400::key::votersv2::@version@::bocashell_voters_source_states_lookup',
											 '~thor_data400::key::votersv2::'+filedate+'::bocashell_voters_source_states_lookup',
											 bld_state_key);
											 
RoxieKeyBuild.MAC_SK_BuildProcess_v2_local(Key_Voters_States(true),
											 '~thor_data400::key::votersv2::fcra::@version@::bocashell_voters_source_states_lookup',
											 '~thor_data400::key::votersv2::fcra::'+filedate+'::bocashell_voters_source_states_lookup',
											 bld_state_key2);
											 


//start voters autokeys

base := PROJECT(VotersV2.File_Voters_Building, VotersV2.Layouts_Voters.Layout_Voters_Base);

Drop_voter_Layout := //REMOVE WHEN WE START TO RECEIVE FILES IN THE CORRECT LAYOUT
Record
string15	rid;
string15	did;
string3	did_score;
string9	ssn;
string15	vtid;
string8	process_date;
string8	date_first_seen;
string8	date_last_seen;
string7	Source;
string4	file_id;
string13	vendor_id;
string2	source_state;
string2	source_code;
string8	file_acquired_date;
string2	use_code;
string10	prefix_title;
string30	last_name;
string30	first_name;
string30	middle_name;
string30	maiden_prior;
string30	clean_maiden_pri;
string3	name_suffix_in;
string15	voterfiller;
string12	source_voterId;
string8	dob;
string2	ageCat;
string10	ageCat_exp;
string2	headHousehold;
string18	place_of_birth;
string30	occupation;
string30	maiden_name;
string15	motorVoterId;
string10	regSource;
string8	regDate;
string2	race;
string25	race_exp;
string1	gender;
string2	political_party;
string25	politicalparty_exp;
string10	phone;
string10	work_phone;
string10	other_phone;
string1	active_status;
string20	active_status_exp;
string1	GenderSurNamGuess; 
string1	active_other;
string2	voter_status;
string50	voter_status_exp;
string40	res_Addr1;
string40	res_Addr2;
string40	res_city;
string2	res_state;
string9	res_zip;
string3	res_county;
string40	mail_addr1;
string40	mail_addr2;
string40	mail_city;
string2	mail_state;
string9	mail_zip;
string3	mail_county;
string40	addr_filler1;
string40	addr_filler2;
string40	city_filler;
string2	state_filler;
string9	zip_filler;
string3	TimeZoneTbl;  //county_filler;
string5	towncode;
string5	distcode;
string5	countycode;
string5	schoolcode;
string1	cityInOut;
string20	spec_dist1;
string20	spec_dist2;
string7	precinct1;
string7	precinct2;
string7	precinct3;
string7	villagePrecinct;
string7	schoolPrecinct;
string7	ward;
string7	precinct_cityTown;
string7	ANCSMDinDC;
string4	cityCouncilDist;
string4	countyCommDist;
string3	stateHouse;
string3	stateSenate;
string3	USHouse;
string4	elemSchoolDist;
string4	schoolDist;
string5	schoolFiller;
string4	CommCollDist;
string5	dist_filler;
string4	municipal;
string4	VillageDist;
string4	PoliceJury;
string4	PoliceDist;
string4	PublicServComm;
string4	Rescue;
string4	Fire;
string4	Sanitary;
string4	SewerDist;
string4	WaterDist;
string4	MosquitoDist;
string4	TaxDist;
string4	SupremeCourt;
string4	JusticeOfPeace;
string4	JudicialDist;
string4	SuperiorCtDist;
string4	AppealsCt;
string4	CourtFIller;
string2	CassAddrTypTbl;
string2	CassDelivPointCd;
string8	CassCarrierRteTbl;
string7	BlkGrpEnumDist;
string3	CongressionalDist;
string7	Lattitude;
string21	CountyFips;        
string21	CensusTract;       
string5	FipsStCountyCd;
string15	Longitude;         
string2	ContributorParty := '';  // old base fields
string2	RecipientParty   := '';  // old base fields
string8	DateOfContr      := '';  // old base fields
string7	DollarAmt        := '';  // old base fields
string3	OfficeContTo     := '';  // old base fields
string7	CumulDollarAmt   := '';  // old base fields
string21	ContFiller1;
string21	ContFiller2;
string5	ContType         := '';  // old base fields
string15	ContFiller4;
string8	LastDateVote;         //LastDayVote;
string10	MiscVoteHist;
string5	title;
string20	fname;
string20	mname;
string20	lname;
string5	name_suffix;
string3	name_score;
string10	prim_range;
string2	predir;
string28	prim_name;
string4	addr_suffix;
string2	postdir;
string10	unit_desig;
string8	sec_range;
string25	p_city_name;
string25	v_city_name;
string2	st;
string5	zip;
string4	zip4;
string4	cart;
string1	cr_sort_sz;
string4	lot;
string1	lot_order;
string2	dpbc;
string1	chk_digit;
string2	rec_type;
string2	ace_fips_st;
string3	fips_county;
string10	geo_lat;
string11	geo_long;
string4	msa;
string7	geo_blk;
string1	geo_match;
string4	err_stat;
string10	mail_prim_range;
string2	mail_predir;
string28	mail_prim_name;
string4	mail_addr_suffix;
string2	mail_postdir;
string10	mail_unit_desig;
string8	mail_sec_range;
string25	mail_p_city_name;
string25	mail_v_city_name;
string2	mail_st;
string5	mail_ace_zip;
string4	mail_zip4;
string4	mail_cart;
string1	mail_cr_sort_sz;
string4	mail_lot;
string1	mail_lot_order;
string2	mail_dpbc;
string1	mail_chk_digit;
string2	mail_rec_type;
string2	mail_ace_fips_st;
string3	mail_fips_county;
string10	mail_geo_lat;
string11	mail_geo_long;
string4	mail_msa;
string7	mail_geo_blk;
string1	mail_geo_match;
string4	mail_err_stat;
string1	name_type;
string1	addr_type;
string2                       eor := '\r\n';
end;
 
header_services.Supplemental_Data.mac_verify('file_voters_inj.txt', Drop_voter_Layout, attr);

Base_File_Append_In := attr();

UNSIGNED6 endMax := MAX(Base, vtid);

VotersV2.Layouts_Voters.Layout_Voters_Base reformat_header(Base_File_Append_In L, INTEGER c) 
												:= //REMOVE WHEN WE START TO RECEIVE FILES IN THE CORRECT LAYOUT
 transform
    self.vtid 			:= endMax + c;
		self.did 				:= (unsigned6) L.did;
		self.rid 				:= (unsigned6) L.rid;
		self.did_score 	:= (unsigned1) L.did_score;

		self := L;
 end;
 
Base_File_Append := PROJECT(Base_File_Append_In, reformat_header(left, COUNTER)); //REMOVE WHEN WE START TO RECEIVE FILES IN THE CORRECT LAYOUT
//***********END*************************************************************

voters_base := base + base_file_append;

Layout_Autokeys := Layouts_Voters.Layout_Voters_Autokeys;

//capture all phones
Layout_Autokeys NormWorkPhone(voters_base l, unsigned c) := transform
	self.phone := choose(c,l.phone,l.work_phone);
	self := l;
end;

// Normalize the work_phone 
Voters_Norm_base := NORMALIZE(voters_base
												  ,if(trim(left.phone,left,right) <> trim(left.work_phone,left,right) and 
												      trim(left.work_phone,left,right) <> '', 2,1)
												  ,NormWorkPhone(left,counter));
													
ut.mac_suppress_by_phonetype(Voters_Norm_base,Phone,st,phone_suppression,true,did);													

// holds logical base name for a autokeys.
logicalname := VotersV2.Constants(filedate).autokey_logical;

// holds key base name for autokeys 
keyname     := VotersV2.Constants(filedate).autokey_keyname;

skip_set := ['B','F','Q'];

AutokeyB2.MAC_Build(phone_suppression,fname,mname,lname,
										ssn,
										dob,
										phone,
										prim_name, prim_range, st, p_city_name, zip, sec_range,
										zero,
										zero,zero,zero,
										zero,zero,zero,
										zero,zero,zero,
										zero,				 
										did,
										blank,
						        zero,
						        zero,
						        blank,blank,blank,blank,blank,blank,
						        zero,
										keyname,
										logicalname,bld_auto_keys,false,skip_set,true,,
										true,,,zero); 

//end voters autokeys 
// Move DID, Source VTID & Vote History VTID keys to build
RoxieKeyBuild.Mac_SK_Move_to_Built_v2('~thor_data400::key::voters::@version@::did','~thor_data400::key::voters::'+filedate+'::did',mv_did);
RoxieKeyBuild.Mac_SK_Move_to_Built_v2('~thor_data400::key::voters::@version@::vtid','~thor_data400::key::voters::'+filedate+'::vtid',mv_vtid);
RoxieKeyBuild.Mac_SK_Move_to_Built_v2('~thor_data400::key::voters::@version@::History_VTID','~thor_data400::key::voters::'+filedate+'::History_VTID',mv_vh_vtid);

RoxieKeyBuild.Mac_SK_Move_to_Built_v2('~thor_data400::key::votersv2::@version@::bocashell_voters_source_states_lookup',
																			'~thor_data400::key::votersv2::'+filedate+'::bocashell_voters_source_states_lookup',mv_state);
RoxieKeyBuild.Mac_SK_Move_to_Built_v2('~thor_data400::key::votersv2::fcra::@version@::bocashell_voters_source_states_lookup',
																			'~thor_data400::key::votersv2::fcra::'+filedate+'::bocashell_voters_source_states_lookup',mv_state2);
																			

// Move DID, source VTID, Vote History VTID keys to QA
RoxieKeyBuild.MAC_SK_Move_v2('~thor_data400::key::voters::@version@::did', 'Q', mv_did_key);
RoxieKeyBuild.MAC_SK_Move_v2('~thor_data400::key::voters::@version@::VTID', 'Q', mv_vtid_key);
RoxieKeyBuild.MAC_SK_Move_v2('~thor_data400::key::voters::@version@::History_VTID', 'Q', mv_vhist_vtid_key);

RoxieKeyBuild.MAC_SK_Move_v2('~thor_data400::key::votersv2::@version@::bocashell_voters_source_states_lookup', 'Q', mv_state_key);
RoxieKeyBuild.MAC_SK_Move_v2('~thor_data400::key::votersv2::fcra::@version@::bocashell_voters_source_states_lookup', 'Q', mv_state_key2);

// Move autokeys to QA
RoxieKeyBuild.MAC_SK_Move_v2('~thor_data400::key::voters::autokey::@version@::payload', 'Q', mv_fdids_key);
RoxieKeyBuild.Mac_SK_Move_V2('~thor_data400::key::voters::autokey::@version@::Address','Q',mv_autokey_addr);
RoxieKeyBuild.Mac_SK_Move_V2('~thor_data400::key::voters::autokey::@version@::Name','Q',mv_autokey_name);
RoxieKeyBuild.Mac_SK_Move_V2('~thor_data400::key::voters::autokey::@version@::StName','Q',mv_autokey_stnam);
RoxieKeyBuild.Mac_SK_Move_V2('~thor_data400::key::voters::autokey::@version@::CityStName','Q',mv_autokey_city);
RoxieKeyBuild.Mac_SK_Move_V2('~thor_data400::key::voters::autokey::@version@::Zip','Q',mv_autokey_zip);
RoxieKeyBuild.Mac_SK_Move_V2('~thor_data400::key::voters::autokey::@version@::SSN2','Q',mv_autokey_ssn2);
RoxieKeyBuild.Mac_SK_Move_V2('~thor_data400::key::voters::autokey::@version@::Phone2','Q',mv_autokey_phone2);


Build_Voters_Keys := sequential(parallel(bld_did_key, bld_VTID_key, bld_History_VTID_key, bld_state_key, bld_state_key2,
																				 bld_auto_keys),
																parallel(mv_did, mv_vtid, mv_vh_vtid, mv_state, mv_state2),
								                parallel(mv_did_key, mv_vtid_key, mv_vhist_vtid_key, mv_state_key, mv_state_key2,
																         mv_fdids_key, mv_autokey_ssn2, mv_autokey_addr,
																				 mv_autokey_name, mv_autokey_stnam, mv_autokey_city,
																				 mv_autokey_zip, mv_autokey_phone2));


return Build_Voters_Keys;														

end;
