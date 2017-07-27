import AID;

export layout_hunters_out :=
record
	unsigned8 persistent_record_id := 0;
	string8			 process_date;
	string8      date_first_seen;
	string8      date_last_seen;
	string3      score;
	string9      best_ssn;
	string12 		 did_out;
	string7    	 Source;
	string4      file_id;
	string13 		 vendor_id;
	string2      source_state;
	string2      source_code;
	string8      file_acquired_date;
	string2      _use;
	string10 		 title_in;
	string30 		 lname_in;
	string30 		 fname_in;
	string30 		 mname_in;
	string30 		 maiden_prior;
	string3      name_suffix_in;
	string15 		 votefiller;
	string12 		 source_voterId;
	string8      dob;
	string2      ageCat;
	string2      headHousehold;
	string18 		 place_of_birth;
	string30 		 occupation;
	string30 		 maiden_name;
	string15 		 motorVoterId;
	string10 		 regSource;
	string8      regDate;
	string2      race;
	string1      gender;
	string2      poliparty;
	string10 		 phone;
	string10 		 work_phone;
	string10 		 other_phone;
	string1      active_status;
	string1      votefiller2;
	string1      active_other;
	string2      voterStatus;
	string40 		 resAddr1;
	string40 		 resAddr2;
	string40 		 res_city;
	string2      res_state;
	string9      res_zip;
	string3      res_county;
	string40 		 mail_addr1;
	string40 		 mail_addr2;
	string40 		 mail_city;
	string2      mail_state;
	string9      mail_zip;
	string3      mail_county;
	string10 		 HistoryFiller;
	string15 		 HuntFishPerm;
	String20 		 License_type_Mapped;
	string8      DateLicense;
	string2      HomeState;
	string1      Resident;
	string1      NonResident;
	string1      Hunt;
	string1      Fish;
	string1      ComboSuper;
	string1      Sportsman;
	string1      Trap;
	string1      Archery;
	string1      Muzzle;
	string1      Drawing;
	string1      Day1;
	string1      Day3;
	string1      Day7;
	string1      Day14to15;
	string1      DayFiller;
	string1      SeasonAnnual;
	string1      LifeTimePermit;
	string1      LandOwner;
	string1      Family;
	string1      Junior;
	string1      SeniorCit;
	string1      CrewMemeber;
	string1      Retarded;
	string1      Indian;
	string1      Serviceman;
	string1      Disabled;
	string1      LowIncome;
	string3      RegionCounty;
	string1      Blind;
	string47 		 HuntFiller;
	string1      Salmon;
	string1      Freshwater;
	string1      Saltwater;
	string1      LakesandResevoirs;
	string1      SetLineFish;
	string1      Trout;
	string1      FallFishing;
	string1      Steelhead;
	string1      WhiteJubHerring;
	string1      Sturgeon;
	string1      ShellfishCrab;
	string1      ShellfishLobster;
	string1      Deer;
	string1      Bear;
	string1      Elk;
	string1      Moose;
	string1      Buffalo;
	string1      Antelope;
	string1      SikeBull;
	string1      Bighorn;
	string1      Javelina;
	string1      Cougar;
	string1      Anterless;
	string1      Pheasant;
	string1      Goose;
	string1      Duck;
	string1      Turkey;
	string1      SnowMobile;
	string1      BigGame;
	string1      SkiPass;
	string1      MigBird;
	string1      SmallGame;
	string1      Sturgeon2;
	string1      Gun;
	string1      Bonus;
	string1      Lottery;
	string1      OtherBirds;
	string83 		 huntfill1;
	string5      title;
	string20 		 fname;
	string20 		 mname;
	string20 		 lname;
	string5      name_suffix;
	string3      score_on_input;
	string10 		 prim_range;
	string2      predir;
	string28 	 	 prim_name;
	string4      suffix;
	string2      postdir;
	string10 		 unit_desig;
	string8      sec_range;
	string25 		 p_city_name;
	string25 		 city_name;
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
	string18		 county_name;
	string10 		 geo_lat;
	string11 		 geo_long;
	string4      msa;
	string7      geo_blk;
	string1      geo_match;
	string4      err_stat;
	string10 		 mail_prim_range;
	string2      mail_predir;
	string28 		 mail_prim_name;
	string4      mail_addr_suffix;
	string2      mail_postdir;
	string10 		 mail_unit_desig;
	string8      mail_sec_range;
	string25 		 mail_p_city_name;
	string25 		 mail_v_city_name;
	string2      mail_st;
	string5      mail_ace_zip;
	string4      mail_zip4;
	string4      mail_cart;
	string1      mail_cr_sort_sz;
	string4      mail_lot;
	string1      mail_lot_order;
	string2      mail_dpbc;
	string1      mail_chk_digit;
	string2      mail_record_type;
	string2      mail_ace_fips_st;
	string3      mail_fipscounty;
	string10 		 mail_geo_lat;
	string11		 mail_geo_long;
	string4      mail_msa;
	string7      mail_geo_blk;
	string1      mail_geo_match;
	string4      mail_err_stat;
end;