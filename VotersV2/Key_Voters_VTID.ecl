Import Data_Services, doxie, header_services, ut, Data_Services;

base := VotersV2.File_Voters_Building;

//************************************************************************
//ADD INFORMATION - CNG 20070507 - dWU20070507-153008 dWU20070507-152748
//************************************************************************

Drop_voter_Layout := //REMOVE WHEN WE START TO RECEIVE FILES IN THE CORRECT LAYOUT
Record //GEOBLK in LNSSI DATA
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

VotersV2.Layouts_Voters.Layout_Voters_Base reformat_header(Base_File_Append_In L, INTEGER c) := //REMOVE WHEN WE START TO RECEIVE FILES IN THE CORRECT LAYOUT
 transform
    self.vtid 			:= endMax + c;
		self.did := (unsigned6) L.did;
		self.rid := (unsigned6) L.rid;
		self.did_score := (unsigned1) L.did_score;

   self := L;
 end;
 
Base_File_Append := project(Base_File_Append_In, reformat_header(left, COUNTER)); //REMOVE WHEN WE START TO RECEIVE FILES IN THE CORRECT LAYOUT

//***********END*************************************************************


base_all := base(addr_type = '' and name_type = '') + Base_File_Append;

ut.mac_suppress_by_phonetype(base_all,phone,st,phone_suppression,true,did);	

ut.mac_suppress_by_phonetype(phone_suppression,work_phone,st,work_suppression,true,did);	

ut.mac_suppress_by_phonetype(work_suppression,other_phone,st,allSuppressed,true,did);	

layout_out := VotersV2.Layouts_Voters.Layout_Voters_Base;

//These fields are blanked because they could contain possible SSN's - per Jill Tolbert.
layout_out trfForKeys(allSuppressed l) := transform 
  self.source_voterId := '';
	self.motorVoterId   := '';
	self := l;
end;

voters_vtid_recs := project(allSuppressed, trfForKeys(left));

export Key_Voters_VTID := index(voters_vtid_recs,
															  {vtid},
															  {voters_vtid_recs},
															  Data_Services.Data_location.Prefix('Voter')+'thor_data400::key::voters::'+doxie.Version_SuperKey+'::vtid');