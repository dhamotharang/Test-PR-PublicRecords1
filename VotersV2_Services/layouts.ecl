IMPORT ut, VotersV2, emerges, standard,doxie;

EXPORT layouts := MODULE

  EXPORT AddressTranslated := RECORD
    standard.L_Address.base;
    //standard.L_Address.translated; // no one ask to translate a state so far.
    STRING35 county;
  END;

  EXPORT Voter := RECORD
    //unsigned6 did;
    STRING12 did;
    UNSIGNED6 vtid;
    STRING9 ssn; //appended, actually
    STRING8 process_date; //or file_acquired_date?
    STRING2 source_state;

    standard.Name name; // named layout (to distinguish cleaned names from vendor's provided)
    STRING8 dob;
    STRING10 phone;
    STRING10 work_phone;
    STRING30 Occupation;
    STRING8 RegDate;
    STRING2 Race;
    STRING1 Gender;
    STRING2 political_party;
    STRING2 voter_status;
    STRING1 active_status;

    STRING35 source_state_exp;
    STRING25 race_exp;
    STRING7 gender_exp;
    STRING25 politicalparty_exp;
    STRING50 voter_status_exp;
    STRING20 active_status_exp;
    STRING8 LastDateVote;
  END;

  EXPORT VoterExp := RECORD
    Voter;
    STRING30 Maiden_Prior;
    STRING2 ageCat;
    STRING2 headHousehold;
    STRING18 place_of_birth;
    STRING30 clean_maiden_pri;
    STRING10 ageCat_exp;
  END;

  EXPORT Districts := RECORD
    STRING5 TownCode;
    STRING5 distcode;
    STRING5 CountyCode;
    STRING5 SchoolCode;
    STRING1 CityInOut;
    STRING20 spec_dist1;
    STRING20 spec_dist2;
    STRING7 Precinct1;
    STRING7 Precinct2;
    STRING7 Precinct3;
    STRING7 VillagePrecinct;
    STRING7 SchoolPrecinct;
    STRING7 Ward;
    STRING7 Precinct_CityTown;
    STRING7 ANCSMDinDC;
    STRING4 CityCouncilDist;
    STRING4 CountyCommDist;
    STRING3 StateHouse;
    STRING3 StateSenate;
    STRING3 USHouse;
    STRING4 ElemSchoolDist;
    STRING4 SchoolDist;
    STRING5 schoolFiller;
    STRING4 CommCollDist;
    STRING5 dist_filler;
    STRING4 Municipal;
    STRING4 VillageDist;
    STRING4 PoliceJury;
    STRING4 PoliceDist;
    STRING4 PublicServComm;
    STRING4 Rescue;
    STRING4 Fire;
    STRING4 Sanitary;
    STRING4 SewerDist;
    STRING4 WaterDist;
    STRING4 MosquitoDist;
    STRING4 TaxDist;
    STRING4 SupremeCourt;
    STRING4 JusticeofPeace;
    STRING4 JudicialDist;
    STRING4 SuperiorCtDist;
    STRING4 AppealsCt;
    STRING4 CourtFiller;
    STRING3 CongressionalDist;
    // Do we need those?
    // string2 CassAddrTypTbl;
    // string2 CassDelivPointCd;
    // string8 CassCarrierRteTbl;
    // string7 BlkGrpEnumDist;
  END;

  // this is export between Embedded and Search layout
  EXPORT ReportSearchShared := RECORD
    UNSIGNED2 penalt := 0;
    VoterExp;
    AddressTranslated Res;
    AddressTranslated Mail;
  END;


  EXPORT SearchOutput := RECORD
    UNSIGNED2 penalt := 0;
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
    STRING4 voted_year := '';
    STRING2 primary := '';
    STRING2 special_1 := '';
    STRING2 other := '';
    STRING2 special_2 := '';
    STRING2 general := '';
    STRING2 pres := '';
    STRING8 vote_date := '';
  END;

  // Output in case of a stand-alone Report or Source service
  EXPORT SourceOutput := RECORD
    VoterExp;
    UNSIGNED1 did_score;
    STRING1 voterfiller;
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
    //unsigned6 did;
    STRING12 did;
    STRING10 gender_mapped := '';
    STRING10 race_mapped := '';
    STRING20 source_state_mapped := '';
  END;
    
  EXPORT BatchOutput := RECORD
    doxie.layout_inBatchMaster.acctno;
    STRING12 vtid;
    Standard.Name;
    Voter-Name-vtid;
    VoterExp-Voter;
    STRING10 res_prim_range;
    STRING2 res_predir;
    STRING28 res_prim_name;
    STRING4 res_addr_suffix;
    STRING2 res_postdir;
    STRING10 res_unit_desig;
    STRING8 res_sec_range;
    STRING25 res_p_city_name;
    STRING25 res_v_city_name;
    STRING2 res_st;
    STRING5 res_zip5;
    STRING4 res_zip4;
    STRING2 res_fips_state;
    STRING3 res_fips_county;
    STRING35 res_county;
    STRING10 mail_prim_range;
    STRING2 mail_predir;
    STRING28 mail_prim_name;
    STRING4 mail_addr_suffix;
    STRING2 mail_postdir;
    STRING10 mail_unit_desig;
    STRING8 mail_sec_range;
    STRING25 mail_p_city_name;
    STRING25 mail_v_city_name;
    STRING2 mail_st;
    STRING5 mail_zip5;
    STRING4 mail_zip4;
    STRING2 mail_fips_state;
    STRING3 mail_fips_county;
    STRING35 mail_county;
    Districts;
    STRING4 voted_year_1 := '';
    STRING2 primary_1 := '';
    STRING2 special_1_1 := '';
    STRING2 other_1 := '';
    STRING2 special_2_1 := '';
    STRING2 general_1 := '';
    STRING2 pres_1 := '';
    STRING8 vote_date_1 := '';
    STRING4 voted_year_2 := '';
    STRING2 primary_2 := '';
    STRING2 special_1_2 := '';
    STRING2 other_2 := '';
    STRING2 special_2_2 := '';
    STRING2 general_2 := '';
    STRING2 pres_2 := '';
    STRING8 vote_date_2 := '';
    STRING4 voted_year_3 := '';
    STRING2 primary_3 := '';
    STRING2 special_1_3 := '';
    STRING2 other_3 := '';
    STRING2 special_2_3 := '';
    STRING2 general_3 := '';
    STRING2 pres_3 := '';
    STRING8 vote_date_3 := '';
    STRING4 voted_year_4 := '';
    STRING2 primary_4 := '';
    STRING2 special_1_4 := '';
    STRING2 other_4 := '';
    STRING2 special_2_4 := '';
    STRING2 general_4 := '';
    STRING2 pres_4 := '';
    STRING8 vote_date_4 := '';
    STRING4 voted_year_5 := '';
    STRING2 primary_5 := '';
    STRING2 special_1_5 := '';
    STRING2 other_5 := '';
    STRING2 special_2_5 := '';
    STRING2 general_5 := '';
    STRING2 pres_5 := '';
    STRING8 vote_date_5 := '';
    STRING4 voted_year_6 := '';
    STRING2 primary_6 := '';
    STRING2 special_1_6 := '';
    STRING2 other_6 := '';
    STRING2 special_2_6 := '';
    STRING2 general_6 := '';
    STRING2 pres_6 := '';
    STRING8 vote_date_6 := '';
    STRING4 voted_year_7 := '';
    STRING2 primary_7 := '';
    STRING2 special_1_7 := '';
    STRING2 other_7 := '';
    STRING2 special_2_7 := '';
    STRING2 general_7 := '';
    STRING2 pres_7 := '';
    STRING8 vote_date_7 := '';
    STRING4 voted_year_8 := '';
    STRING2 primary_8 := '';
    STRING2 special_1_8 := '';
    STRING2 other_8 := '';
    STRING2 special_2_8 := '';
    STRING2 general_8 := '';
    STRING2 pres_8 := '';
    STRING8 vote_date_8 := '';
    STRING4 voted_year_9 := '';
    STRING2 primary_9 := '';
    STRING2 special_1_9 := '';
    STRING2 other_9 := '';
    STRING2 special_2_9 := '';
    STRING2 general_9 := '';
    STRING2 pres_9 := '';
    STRING8 vote_date_9 := '';
    STRING4 voted_year_10 := '';
    STRING2 primary_10 := '';
    STRING2 special_1_10 := '';
    STRING2 other_10 := '';
    STRING2 special_2_10 := '';
    STRING2 general_10 := '';
    STRING2 pres_10 := '';
    STRING8 vote_date_10 := '';
    STRING4 voted_year_11 := '';
    STRING2 primary_11 := '';
    STRING2 special_1_11 := '';
    STRING2 other_11 := '';
    STRING2 special_2_11 := '';
    STRING2 general_11 := '';
    STRING2 pres_11 := '';
    STRING8 vote_date_11 := '';
    STRING4 voted_year_12 := '';
    STRING2 primary_12 := '';
    STRING2 special_1_12 := '';
    STRING2 other_12 := '';
    STRING2 special_2_12 := '';
    STRING2 general_12 := '';
    STRING2 pres_12 := '';
    STRING8 vote_date_12 := '';
    STRING4 voted_year_13 := '';
    STRING2 primary_13 := '';
    STRING2 special_1_13 := '';
    STRING2 other_13 := '';
    STRING2 special_2_13 := '';
    STRING2 general_13 := '';
    STRING2 pres_13 := '';
    STRING8 vote_date_13 := '';
    STRING4 voted_year_14 := '';
    STRING2 primary_14 := '';
    STRING2 special_1_14 := '';
    STRING2 other_14 := '';
    STRING2 special_2_14 := '';
    STRING2 general_14 := '';
    STRING2 pres_14 := '';
    STRING8 vote_date_14 := '';
    STRING4 voted_year_15 := '';
    STRING2 primary_15 := '';
    STRING2 special_1_15 := '';
    STRING2 other_15 := '';
    STRING2 special_2_15 := '';
    STRING2 general_15 := '';
    STRING2 pres_15 := '';
    STRING8 vote_date_15 := '';
    STRING4 voted_year_16 := '';
    STRING2 primary_16 := '';
    STRING2 special_1_16 := '';
    STRING2 other_16 := '';
    STRING2 special_2_16 := '';
    STRING2 general_16 := '';
    STRING2 pres_16 := '';
    STRING8 vote_date_16 := '';
    STRING4 voted_year_17 := '';
    STRING2 primary_17 := '';
    STRING2 special_1_17 := '';
    STRING2 other_17 := '';
    STRING2 special_2_17 := '';
    STRING2 general_17 := '';
    STRING2 pres_17 := '';
    STRING8 vote_date_17 := '';
    STRING4 voted_year_18 := '';
    STRING2 primary_18 := '';
    STRING2 special_1_18 := '';
    STRING2 other_18 := '';
    STRING2 special_2_18 := '';
    STRING2 general_18 := '';
    STRING2 pres_18 := '';
    STRING8 vote_date_18 := '';
    STRING4 voted_year_19 := '';
    STRING2 primary_19 := '';
    STRING2 special_1_19 := '';
    STRING2 other_19 := '';
    STRING2 special_2_19 := '';
    STRING2 general_19 := '';
    STRING2 pres_19 := '';
    STRING8 vote_date_19 := '';
    STRING4 voted_year_20 := '';
    STRING2 primary_20 := '';
    STRING2 special_1_20 := '';
    STRING2 other_20 := '';
    STRING2 special_2_20 := '';
    STRING2 general_20 := '';
    STRING2 pres_20 := '';
    STRING8 vote_date_20 := '';
  END;
  
END;
