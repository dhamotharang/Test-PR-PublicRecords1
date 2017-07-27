export layout_voters_out := record
   string8		process_date;
   string8      date_first_seen;
   string8      date_last_seen;
   string3      score;
   string9      best_ssn;
   string12 	did_out;
   string7      Source;
   string4      file_id;
   string13 	vendor_id;
   string2      source_state;
   string2      source_code;
   string8      file_acquired_date;
   string2      _use;
   string10 	title_in;
   string30 	lname_in;
   string30 	fname_in;
   string30 	mname_in;
   string30 	maiden_prior;
   string3      name_suffix_in;
   string15 	votefiller;
   string12 	source_voterId;
   string8      dob;
   string2      ageCat;
   string2      headHousehold;
   string18 	place_of_birth;
   string30 	occupation;
   string30 	maiden_name;
   string15 	motorVoterId;
   string10 	regSource;
   string8      regDate;
   string2      race;
   string1      gender;
   string2      poliparty;
   string25		poliparty_Mapped;
   string10 	phone;
   string10 	work_phone;
   string10 	other_phone;
   string1      active_status;
   string20		active_status_mapped;
   string1      votefiller2;
   string1      active_other;
   string2      voterStatus;
   string50		voterStatus_Mapped;
   string40 	resAddr1;
   string40 	resAddr2;
   string40 	res_city;
   string2      res_state;
   string9      res_zip;
   string3      res_county;
   string40 	mail_addr1;
   string40 	mail_addr2;
   string40 	mail_city;
   string2      mail_state;
   string9      mail_zip;
   string3      mail_county;
   string40 	addr_filler1;
   string40 	addr_filler2;
   string40 	city_filler;
   string2      state_filler;
   string9      zip_filler;
   string3      county_filler;
   string5      towncode;
   string5      distcode;
   string5      countycode;
   string5      schoolcode;
   string1      cityInOut;
   string20 	spec_dist1;
   string20 	spec_dist2;
   string7      precinct1;
   string7      precinct2;
   string7      precinct3;
   string7      villagePrecinct;
   string7      schoolPrecinct;
   string7      ward;
   string7      precinct_cityTown;
   string7      ANCSMDinDC;
   string4      cityCouncilDist;
   string4      countyCommDist;
   string3      stateHouse;
   string3      stateSenate;
   string3      USHouse;
   string4      elemSchoolDist;
   string4      schoolDist;
   string5      schoolFiller;
   string4      CommCollDist;
   string5      dist_filler;
   string4      municipal;
   string4      VillageDist;
   string4      PoliceJury;
   string4      PoliceDist;
   string4      PublicServComm;
   string4      Rescue;
   string4      Fire;
   string4      Sanitary;
   string4      SewerDist;
   string4      WaterDist;
   string4      MosquitoDist;
   string4      TaxDist;
   string4      SupremeCourt;
   string4      JusticeOfPeace;
   string4      JudicialDist;
   string4      SuperiorCtDist;
   string4      AppealsCt;
   string4      CourtFIller;
   string2      ContributorParty;
   string2      RecptParty;
   string8      DateOfContr;
   string7      DollarAmt;
   string3      OfficeContTo;
   string7      CumulDollarAmt;
   string21 	ContFiller1;
   string21 	ContFiller2;
   string5      ContType;
   string15 	ContFiller3;
   string2      Primary02;
   string2      Special02;
   string2      Other02;
   string2      Special202;
   string2      General02;
   string2      Primary01;
   string2      Special01;
   string2      Other01;
   string2      Special201;
   string2      General01;
   string2      Pres00;
   string2      Primary00;
   string2      Special00;
   string2      Other00;
   string2      Special200;
   string2      General00;
   string2      Primary99;
   string2      Special99;
   string2      Other99;
   string2      Special299;
   string2      General99;
   string2      Primary98;
   string2      Special98;
   string2      Other98;
   string2      Special298;
   string2      General98;
   string2      Primary97;
   string2      Special97;
   string2      Other97;
   string2      Special297;
   string2      General97;
   string2      Pres96;
   string2      Primary96;
   string2      Special96;
   string2      Other96;
   string2      Special296;
   string2      General96;
   string8      LastDayVote;
   string5      title;
   string20 	fname;
   string20 	mname;
   string20 	lname;
   string5      name_suffix;
   string3      score_on_input;
   string10 	prim_range;
   string2      predir;
   string28 	prim_name;
   string4      suffix;
   string2      postdir;
   string10 	unit_desig;
   string8      sec_range;
   string25 	p_city_name;
   string25 	city_name;
   string2      st;
   string5      zip;
   string4      zip4;
   string4      cart;
   string1      cr_sort_sz;
   string4      lot;
   string1      lot_order;
   string2      dpbc;
   string1      chk_digit;
   string2      record_type;
   string2      ace_fips_st;
   string3      county;
   string18		county_name;
   string10 	geo_lat;
   string11 	geo_long;
   string4      msa;
   string7      geo_blk;
   string1      geo_match;
   string4      err_stat;
   string10 	mail_prim_range;
   string2 		mail_predir;
   string28 	mail_prim_name;
   string4 		mail_addr_suffix;
   string2 		mail_postdir;
   string10 	mail_unit_desig;
   string8 		mail_sec_range;
   string25 	mail_p_city_name;
   string25 	mail_v_city_name;
   string2 		mail_st;
   string5 		mail_ace_zip;
   string4 		mail_zip4;
   string4 		mail_cart;
   string1 		mail_cr_sort_sz;
   string4 		mail_lot;
   string1 		mail_lot_order;
   string2 		mail_dpbc;
   string1 		mail_chk_digit;
   string2 		mail_record_type;
   string2 		mail_ace_fips_st;
   string3 		mail_fipscounty;
   string10		mail_geo_lat;
   string11 	mail_geo_long;
   string4 		mail_msa;
   string7 		mail_geo_blk;
   string1 		mail_geo_match;
   string4 		mail_err_stat;
end;