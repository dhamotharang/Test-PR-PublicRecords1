IMPORT ut, VotersV2, emerges, standard,doxie;

EXPORT layouts := MODULE

  export AddressTranslated := RECORD
    standard.L_Address.base;
//    standard.L_Address.translated;  // no one ask to translate a state so far.
    string35 county;
  end;

  export Voter := RECORD
//    unsigned6  did;
    string12 did;
    unsigned6 vtid;
    string9 ssn; //appended, actually
    string8 process_date; //or file_acquired_date?
    string2 source_state;

    standard.Name name; // named layout (to distinguish cleaned names from vendor's provided) 
    string8  dob;
    string10 phone;
    string10 work_phone;
    string30 Occupation;	
    string8  RegDate;	
    string2  Race;
    string1  Gender;
    string2  political_party;
    string2  voter_status;
    string1  active_status;

    string35 source_state_exp;
    string25 race_exp;
    string7  gender_exp;
    string25 politicalparty_exp;
    string50 voter_status_exp;
    string20 active_status_exp;
    string8	LastDateVote;
  end; 

  export VoterExp := RECORD
    Voter;
    string30 Maiden_Prior;
    string2  ageCat;
    string2  headHousehold;
    string18 place_of_birth;
    string30 clean_maiden_pri;		
    string10 ageCat_exp;
  end; 

  export Districts := RECORD
    string5	TownCode;
    string5	distcode;
    string5	CountyCode;
    string5	SchoolCode;
    string1	CityInOut;
    string20 spec_dist1;
    string20 spec_dist2;
    string7	Precinct1;
    string7	Precinct2;
    string7	Precinct3;
    string7	VillagePrecinct;
    string7	SchoolPrecinct;
    string7	Ward;
    string7	Precinct_CityTown;
    string7	ANCSMDinDC;
    string4	CityCouncilDist;
    string4	CountyCommDist;
    string3	StateHouse;
    string3	StateSenate;
    string3	USHouse;
    string4	ElemSchoolDist;
    string4	SchoolDist;
    string5 schoolFiller;
    string4	CommCollDist;
    string5 dist_filler;
    string4	Municipal;
    string4	VillageDist;
    string4	PoliceJury;
    string4	PoliceDist;
    string4	PublicServComm;
    string4	Rescue;
    string4	Fire;
    string4	Sanitary;
    string4	SewerDist;
    string4	WaterDist;
    string4 MosquitoDist;
    string4	TaxDist;
    string4	SupremeCourt;
    string4	JusticeofPeace;
    string4	JudicialDist;
    string4	SuperiorCtDist;
    string4	AppealsCt;
    string4 CourtFiller;
    string3	CongressionalDist;
    // Do we need those?
    // string2    CassAddrTypTbl;    
    // string2    CassDelivPointCd;  
    // string8    CassCarrierRteTbl; 
    // string7    BlkGrpEnumDist;    
  end;

  // this is export between Embedded and Search layout
  EXPORT ReportSearchShared := RECORD
    unsigned2 penalt := 0;
 
    VoterExp;
    AddressTranslated Res;
    AddressTranslated Mail;
  END; 


  EXPORT SearchOutput := RECORD
    unsigned2 penalt := 0;

    Voter;
    AddressTranslated Res;
    AddressTranslated Mail;
  END; 

  // output layout when embedded in a report, like CRS
  EXPORT EmbeddedOutput := RECORD
	  VoterExp;
    AddressTranslated Res;
    AddressTranslated Mail;
  END; 

  EXPORT HistoryByYear := RECORD
    string4 voted_year := '';
    string2 primary   := '';
    string2 special_1 := '';
    string2 other     := '';
    string2 special_2 := '';
    string2 general   := '';
    string2 pres      := '';
    string8 vote_date := '';
  END;

  // Output in case of a stand-alone Report or Source service
  EXPORT SourceOutput := RECORD
    VoterExp;
    unsigned1  did_score;
    string1	voterfiller;
    AddressTranslated Res;
    AddressTranslated Mail;
    Districts;
    DATASET (HistoryByYear) History {MAXCOUNT(ut.limits.VOTERS_HISTORY_MAX)};
  END; 

  // same layout so far
  EXPORT DataOutput := RECORD (SourceOutput)
  END; 

  EXPORT LegacyOutput := RECORD
    emerges.layout_voters_out;
//    unsigned6 did;
    string12 did;
    string10 gender_mapped := '';
    string10 race_mapped := '';
    string20 source_state_mapped := '';
  END;
		
	EXPORT BatchOutput := RECORD
	  doxie.layout_inBatchMaster.acctno;
		String12 vtid;
		Standard.Name;
		Voter-Name-vtid;
    VoterExp-Voter;
    string10 res_prim_range;
    string2  res_predir;
    string28 res_prim_name;
    string4  res_addr_suffix;
    string2  res_postdir;
    string10 res_unit_desig;
    string8  res_sec_range;
    string25 res_p_city_name;
    string25 res_v_city_name;
    string2  res_st;
    string5  res_zip5;
    string4  res_zip4;
    string2  res_fips_state;
    string3  res_fips_county;
		string35 res_county;
		string10 mail_prim_range;
    string2  mail_predir;
    string28 mail_prim_name;
    string4  mail_addr_suffix;
    string2  mail_postdir;
    string10 mail_unit_desig;
    string8  mail_sec_range;
    string25 mail_p_city_name;
    string25 mail_v_city_name;
    string2  mail_st;
    string5  mail_zip5;
    string4  mail_zip4;
    string2  mail_fips_state;
    string3  mail_fips_county;
		string35 mail_county;
    Districts;	
    string4 voted_year_1 := '';
    string2 primary_1 := '';
    string2 special_1_1 := '';
    string2 other_1 := '';
    string2 special_2_1 := '';
    string2 general_1 := '';
    string2 pres_1 := '';
    string8 vote_date_1 := '';
		string4 voted_year_2 := '';
    string2 primary_2 := '';
    string2 special_1_2 := '';
    string2 other_2 := '';
    string2 special_2_2 := '';
    string2 general_2 := '';
    string2 pres_2 := '';
    string8 vote_date_2 := '';
    string4 voted_year_3 := '';
    string2 primary_3 := '';
    string2 special_1_3 := '';
    string2 other_3 := '';
    string2 special_2_3 := '';
    string2 general_3 := '';
    string2 pres_3 := '';
    string8 vote_date_3 := '';		
    string4 voted_year_4 := '';
    string2 primary_4 := '';
    string2 special_1_4 := '';
    string2 other_4 := '';
    string2 special_2_4 := '';
    string2 general_4 := '';
    string2 pres_4 := '';
    string8 vote_date_4 := '';
		string4 voted_year_5 := '';
    string2 primary_5 := '';
    string2 special_1_5 := '';
    string2 other_5 := '';
    string2 special_2_5 := '';
    string2 general_5 := '';
    string2 pres_5 := '';
    string8 vote_date_5 := '';
    string4 voted_year_6 := '';
    string2 primary_6 := '';
    string2 special_1_6 := '';
    string2 other_6 := '';
    string2 special_2_6 := '';
    string2 general_6 := '';
    string2 pres_6 := '';
    string8 vote_date_6 := '';	
    string4 voted_year_7 := '';
    string2 primary_7 := '';
    string2 special_1_7 := '';
    string2 other_7 := '';
    string2 special_2_7 := '';
    string2 general_7 := '';
    string2 pres_7 := '';
    string8 vote_date_7 := '';
		string4 voted_year_8 := '';
    string2 primary_8 := '';
    string2 special_1_8 := '';
    string2 other_8 := '';
    string2 special_2_8 := '';
    string2 general_8 := '';
    string2 pres_8 := '';
    string8 vote_date_8 := '';
    string4 voted_year_9 := '';
    string2 primary_9 := '';
    string2 special_1_9 := '';
    string2 other_9 := '';
    string2 special_2_9 := '';
    string2 general_9 := '';
    string2 pres_9 := '';
    string8 vote_date_9 := '';		
    string4 voted_year_10 := '';
    string2 primary_10 := '';
    string2 special_1_10 := '';
    string2 other_10 := '';
    string2 special_2_10 := '';
    string2 general_10 := '';
    string2 pres_10 := '';
    string8 vote_date_10 := '';
		string4 voted_year_11 := '';
    string2 primary_11 := '';
    string2 special_1_11 := '';
    string2 other_11 := '';
    string2 special_2_11 := '';
    string2 general_11 := '';
    string2 pres_11 := '';
    string8 vote_date_11 := '';
    string4 voted_year_12 := '';
    string2 primary_12 := '';
    string2 special_1_12 := '';
    string2 other_12 := '';
    string2 special_2_12 := '';
    string2 general_12 := '';
    string2 pres_12 := '';
    string8 vote_date_12 := '';		
    string4 voted_year_13 := '';
    string2 primary_13 := '';
    string2 special_1_13 := '';
    string2 other_13 := '';
    string2 special_2_13 := '';
    string2 general_13 := '';
    string2 pres_13 := '';
    string8 vote_date_13 := '';
		string4 voted_year_14 := '';
    string2 primary_14 := '';
    string2 special_1_14 := '';
    string2 other_14 := '';
    string2 special_2_14 := '';
    string2 general_14 := '';
    string2 pres_14 := '';
    string8 vote_date_14 := '';
    string4 voted_year_15 := '';
    string2 primary_15 := '';
    string2 special_1_15 := '';
    string2 other_15 := '';
    string2 special_2_15 := '';
    string2 general_15 := '';
    string2 pres_15 := '';
    string8 vote_date_15 := '';		
    string4 voted_year_16 := '';
    string2 primary_16 := '';
    string2 special_1_16 := '';
    string2 other_16 := '';
    string2 special_2_16 := '';
    string2 general_16 := '';
    string2 pres_16 := '';
    string8 vote_date_16 := '';
		string4 voted_year_17 := '';
    string2 primary_17 := '';
    string2 special_1_17 := '';
    string2 other_17 := '';
    string2 special_2_17 := '';
    string2 general_17 := '';
    string2 pres_17 := '';
    string8 vote_date_17 := '';
    string4 voted_year_18 := '';
    string2 primary_18 := '';
    string2 special_1_18 := '';
    string2 other_18 := '';
    string2 special_2_18 := '';
    string2 general_18 := '';
    string2 pres_18 := '';
    string8 vote_date_18 := '';	
    string4 voted_year_19 := '';
    string2 primary_19 := '';
    string2 special_1_19 := '';
    string2 other_19 := '';
    string2 special_2_19 := '';
    string2 general_19 := '';
    string2 pres_19 := '';
    string8 vote_date_19 := '';
    string4 voted_year_20 := '';
    string2 primary_20 := '';
    string2 special_1_20 := '';
    string2 other_20 := '';
    string2 special_2_20 := '';
    string2 general_20 := '';
    string2 pres_20 := '';
    string8 vote_date_20 := '';		
	END;
	

END;