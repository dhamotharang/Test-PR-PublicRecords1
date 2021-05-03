IMPORT ut;

export Layouts_Voters := MODULE

	export Voters := record
		 unsigned6  vtid;
		 string8	  process_date;
		 string8    date_first_seen;
		 string8    date_last_seen;
		 string7    Source;
		 string4    file_id;
		 string13 	vendor_id;
		 string2    source_state;
		 string2    source_code;
		 string8    file_acquired_date;
		 string2    use_code;
		 string10 	prefix_title;
		 string30 	last_name;
		 string30 	first_name;
		 string30 	middle_name;
		 string30 	maiden_prior;
		 string30 	clean_maiden_pri;
		 string3    name_suffix_in;
		 string15 	voterfiller;
		 string12 	source_voterId;
		 string8    dob;
		 string2    ageCat;
		 string10   ageCat_exp;
		 string2    headHousehold;
		 string18 	place_of_birth;
		 string30 	occupation;
		 string30 	maiden_name;
		 string15 	motorVoterId;
		 string10 	regSource;
		 string8    regDate;
		 string2    race;
		 string25   race_exp;
		 string1    gender;
		 string2    political_party;
		 string25	  politicalparty_exp;
		 string10 	phone;
		 string10 	work_phone;
		 string10 	other_phone;
		 string1    active_status;
		 string20	  active_status_exp;
		 string1    GenderSurNamGuess; //voterfiller2;
		 string1    active_other;	 
		 string2    voter_status;
		 string50	  voter_status_exp;
		 string40 	res_Addr1;
		 string40 	res_Addr2;
		 string40 	res_city;
		 string2    res_state;
		 string9    res_zip;
		 string3    res_county;
		 string40 	mail_addr1;
		 string40 	mail_addr2;
		 string40 	mail_city;
		 string2    mail_state;
		 string9    mail_zip;
		 string3    mail_county;
		 string40 	addr_filler1;
		 string40 	addr_filler2;
		 string40 	city_filler;
		 string2    state_filler;
		 string9    zip_filler;
		 string3    TimeZoneTbl;  //county_filler;
		 string5    towncode;
		 string5    distcode;
		 string5    countycode;
		 string5    schoolcode;
		 string1    cityInOut;
		 string20 	spec_dist1;
		 string20 	spec_dist2;
		 string7    precinct1;
		 string7    precinct2;
		 string7    precinct3;
		 string7    villagePrecinct;
		 string7    schoolPrecinct;
		 string7    ward;
		 string7    precinct_cityTown;
		 string7    ANCSMDinDC;
		 string4    cityCouncilDist;
		 string4    countyCommDist;
		 string3    stateHouse;
		 string3    stateSenate;
		 string3    USHouse;
		 string4    elemSchoolDist;
		 string4    schoolDist;
		 string5    schoolFiller;
		 string4    CommCollDist;
		 string5    dist_filler;
		 string4    municipal;
		 string4    VillageDist;
		 string4    PoliceJury;
		 string4    PoliceDist;
		 string4    PublicServComm;
		 string4    Rescue;
		 string4    Fire;
		 string4    Sanitary;
		 string4    SewerDist;
		 string4    WaterDist;
		 string4    MosquitoDist;
		 string4    TaxDist;
		 string4    SupremeCourt;
		 string4    JusticeOfPeace;
		 string4    JudicialDist;
		 string4    SuperiorCtDist;
		 string4    AppealsCt;
		 string4    CourtFIller;
		 string2    CassAddrTypTbl;    
		 string2    CassDelivPointCd;  
		 string8    CassCarrierRteTbl; 
		 string7    BlkGrpEnumDist;    
		 string3    CongressionalDist; 
		 string7    Lattitude;         
		 string21 	CountyFips;        
		 string21 	CensusTract;       
		 string5    FipsStCountyCd;    
		 string15 	Longitude;         
		 string2    ContributorParty := '';  // old base fields
		 string2    RecipientParty   := '';  // old base fields
		 string8    DateOfContr      := '';  // old base fields
		 string7    DollarAmt        := '';  // old base fields
		 string3    OfficeContTo     := '';  // old base fields
		 string7    CumulDollarAmt   := '';  // old base fields
		 string21 	ContFiller1      := '';  // old base fields  
		 string21 	ContFiller2      := '';  // old base fields
		 string5    ContType         := '';  // old base fields
		 string15 	ContFiller4      := '';  // old base fields
		 string8    LastDateVote;         //LastDayVote;
		 string10   MiscVoteHist;
		 string5    title;
		 string20 	fname;
		 string20 	mname;
		 string20 	lname;
		 string5    name_suffix;
		 string3    name_score;
		 string10 	prim_range;
		 string2    predir;
		 string28 	prim_name;
		 string4    addr_suffix;
		 string2    postdir;
		 string10 	unit_desig;
		 string8    sec_range;
		 string25 	p_city_name;
		 string25 	v_city_name;
		 string2    st;
		 string5    zip;
		 string4    zip4;
		 string4    cart;
		 string1    cr_sort_sz;
		 string4    lot;
		 string1    lot_order;
		 string2    dpbc;
		 string1    chk_digit;
		 string2    rec_type;
		 string2    ace_fips_st;
		 string3    fips_county;
		 string10 	geo_lat;
		 string11 	geo_long;
		 string4    msa;
		 string7    geo_blk;
		 string1    geo_match;
		 string4    err_stat;
		 string10 	mail_prim_range;
		 string2 	  mail_predir;
		 string28 	mail_prim_name;
		 string4 	  mail_addr_suffix;
		 string2 	  mail_postdir;
		 string10 	mail_unit_desig;
		 string8 	  mail_sec_range;
		 string25 	mail_p_city_name;
		 string25 	mail_v_city_name;
		 string2 	  mail_st;
		 string5 	  mail_ace_zip;
		 string4 	  mail_zip4;
		 string4 	  mail_cart;
		 string1 	  mail_cr_sort_sz;
		 string4 	  mail_lot;
		 string1 	  mail_lot_order;
		 string2 	  mail_dpbc;
		 string1 	  mail_chk_digit;
		 string2 	  mail_rec_type;
		 string2 	  mail_ace_fips_st;
		 string3 	  mail_fips_county;
		 string10	  mail_geo_lat;
		 string11 	mail_geo_long;
		 string4 	  mail_msa;
		 string7 	  mail_geo_blk;
		 string1 	  mail_geo_match;
		 string4 	  mail_err_stat;
	end;
	
	export Voters_new := record
		 Voters;
     // Adding new fields that replaced other fields after 9/23/2011
		 string15 	IDTypes;
		 string30 	precinct;
		 string10 	ward1;
		 string1    IDCode;	 
		 string40 	PrecinctPartTextDesig;
		 string40 	PrecinctPartTextName;
		 string40 	PrecinctTextDesig;
		 string2    MarriedAppend;
		 string9    SupervisorDistrict;
		 string20 	district;
		 string20 	ward2;
		 string7    CityCountyCouncil;
		 string7    CountyPrecinct;
		 string7    CountyCommis;
		 string7    SchoolBoard;
		 string7    ward3;
		 string7    TownCityCouncil1;
		 string4    TownCityCouncil2;
		 string4    regents;
		 string5    WaterShed;
		 string5    education;
		 string4    PoliceConstable;
		 string4    FreeHolder;
		 string4    MuniCourt;
		 string10   ChangeDate;
	end;
	
	// Leave this layout alone
	shared VoteHistory := record
	   string2    Primary2008;     
		 string2    Special12008;    
		 string2    Other2008;       
		 string2    Special22008;   
		 string2    General2008;  
		 string2    PresPrimary2008; 
		 string2    Primary2007;     
		 string2    Special12007;    
		 string2    Other2007;       
		 string2    Special22007;   
		 string2    General2007;    
		 string2    Primary2006;    
		 string2    Special12006;   
		 string2    Other2006;      
		 string2    Special22006;   
		 string2    General2006;    
		 string2    Primary2005;    
		 string2    Special12005;    
		 string2    Other2005;      
		 string2    Special22005;   
		 string2    General2005;    
		 string2    PresPrimary2004;
		 string2    Primary2004;    
		 string2    Special12004;   
		 string2    Other2004;      
		 string2    Special22004;   
		 string2    General2004;    
		 string2    Primary2003;     
		 string2    Special12003;    
		 string2    Other2003;       
		 string2    Special22003;    
		 string2    General2003;
		 string2    Primary2002;
		 string2    Special12002;
		 string2    Other2002;
		 string2    Special22002;
		 string2    General2002;
		 string2    Primary2001     := '';     // old base fields (2008)
		 string2    Special2001     := '';     // old base fields
		 string2    Other2001       := '';     // old base fields
		 string2    Special22001    := '';     // old base fields
		 string2    General2001     := '';     // old base fields   
		 string2    PresPrimary2000 := '';     // old base fields (2008) 
		 string2    Primary2000     := '';     // old base fields (2008)
		 string2    Special2000     := '';     // old base fields
		 string2    Other2000       := '';     // old base fields
		 string2    Special22000    := '';     // old base fields
		 string2    General2000     := '';     // old base fields (2008)
		 string2    Primary1999     := '';     // old base fields
		 string2    Special1999     := '';     // old base fields
		 string2    Other1999       := '';     // old base fields
		 string2    Special21999    := '';     // old base fields
		 string2    General1999     := '';     // old base fields
		 string2    Primary1998     := '';     // old base fields
		 string2    Special1998     := '';     // old base fields
		 string2    Other1998       := '';     // old base fields
		 string2    Special21998    := '';     // old base fields
		 string2    General1998     := '';     // old base fields
		 string2    Primary1997     := '';     // old base fields
		 string2    Special1997     := '';     // old base fields
		 string2    Other1997       := '';     // old base fields
		 string2    Special21997    := '';     // old base fields
		 string2    General1997     := '';     // old base fields
		 string2    PresPrimary1996 := '';     // old base fields
		 string2    Primary1996     := '';     // old base fields
		 string2    Special1996     := '';     // old base fields
		 string2    Other1996       := '';     // old base fields
		 string2    Special21996    := '';     // old base fields
		 string2    General1996     := '';     // old base fields
	end;
	
	// Vote History Fields
	// Note: Modify this layout begning of every year to accommodiate the new vendor layout 
	// to add the new vote history year fields.
	// As of code changes in 2015, the layout accomodates up to 2020 and back to 2004.
	shared VoteHistory_new := record
		 string1    Primary2020;
		 string1    Special12020;
		 string1    Other2020;
		 string1    Special22020;
		 string1    General2020;
		 string1    PresPrimary2020;
		 string1    Primary2019;
		 string1    Special12019;
		 string1    Other2019;
		 string1    Special22019;
		 string1    General2019;
		 string1    Primary2018;
		 string1    Special12018;
		 string3    Other2018;
		 string1    Special22018;
		 string1    General2018;
		 string1    Primary2017;
		 string1    Special12017;
		 string1    Other2017;
		 string1    Special22017;
		 string1    General2017;
		 string1    Primary2016;
		 string1    Special12016;
		 string1    Other2016;
		 string1    Special22016;
		 string1    General2016;
		 string1    PresPrimary2016;
		 string1    Primary2015;
		 string1    Special12015;
		 string1    Other2015;
		 string1    Special22015;
		 string1    General2015;
		 string1    Primary2014;
		 string1    Special12014;
		 string1    Other2014;
		 string1    Special22014;
		 string1    General2014;
		 string1    Primary2013;
		 string1    Special12013;
		 string1    Other2013;
		 string1    Special22013;
		 string1    General2013;
		 string2    Primary2012;
		 string2    Special12012;
		 string2    Other2012;
		 string2    Special22012;
		 string2    General2012;
		 string2    PresPrimary2012;
		 string2    Primary2011;
		 string2    Special12011;
		 string2    Other2011;
		 string2    Special22011;
		 string2    General2011;
		 string2    Primary2010;
		 string2    Special12010;
		 string2    Other2010;
		 string2    Special22010;
		 string2    General2010;
		 string2    Primary2009;
		 string2    Special12009;
		 string2    Other2009;
		 string2    Special22009;
		 string2    General2009;
	   VoteHistory;
	end;
	
	Export Layout_Voters_Common := record
	  Voters;
		VoteHistory;
	end;
	
	Export Layout_Voters_Common_new := record
	  Voters_new;
		VoteHistory_new;
		unsigned6 rid := 0;
	end;
	
	Export Layout_Voters_base := record
		unsigned6  rid;
		unsigned6  did;
		unsigned1  did_score;
		string9    ssn;
		Voters;
		string1    name_type;
		string1    addr_type;
	end;
	
//Added AID Fields	
//DF-27577 Added prep address fields
	Export Layout_Voters_base_new := record
		unsigned6  rid;
		unsigned6  did;
		unsigned1  did_score;
		string9    ssn;
		Voters_new;
		string1    name_type;
		string1    addr_type;
	  unsigned8	 raw_aid := 0;
	  unsigned8	 ace_aid := 0;	
	  string100	 prep_addr_line1 := '';
	  string50	 prep_addr_line_last := '';	
	end;
	
	Export Layout_Voters_Autokeys := record
		Layout_Voters_base.rid;
		Layout_Voters_base.did;
		Layout_Voters_base.ssn;
		Voters.vtid;		 
		Voters.fname;
		Voters.mname;
		Voters.lname;
		Voters.dob;
		Voters.prim_range;
		Voters.predir;
		Voters.prim_name;
		Voters.addr_suffix;
		Voters.postdir;
		Voters.unit_desig;
		Voters.sec_range;
		Voters.p_city_name;
		Voters.v_city_name;
		Voters.st;
		Voters.zip;
		Voters.phone;
		unsigned1 zero  := 0;
	  string1   blank := '';
	end;

end;