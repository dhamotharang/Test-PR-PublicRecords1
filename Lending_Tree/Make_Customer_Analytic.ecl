IMPORT ut, Polk, NID;

// All 50 Contintental States and District of Columbia
states50 := ['AL','AK','AZ','AR','CA','CO','CT','DE','DC','FL',
             'GA','HI','ID','IL','IN','IA','KS','KY','LA','ME',
             'MD','MA','MI','MN','MS','MO','MT','NE','NV','NH',
             'NJ','NM','NY','NC','ND','OH','OK','OR','PA','RI',
             'SC','SD','TN','TX','UT','VT','VA','WA','WV','WI','WY'];

polk_file := Polk.File_Polk_TXL(clean_state IN states50,
						    clean_fname <> '', clean_lname <> '', clean_prim_name <> '',
						    (INTEGER)clean_zip5 <> 0);

life_file := Polk.File_Polk_TLS(ace_state IN states50,
						   name_last <> '', name_first <> '', prim_name <> '',
                           (INTEGER)ace_zip <> 0);

// Selected Fields from Polk File
polk_formatted_layout := record
STRING20 pk_fname;
STRING20 pk_lname;
STRING10 pk_prim_range;
STRING28 pk_prim_name;
STRING8  pk_sec_range;
STRING5  pk_zip5;
STRING4  pk_zip4;
STRING10 pk_geo_lat;
STRING11 pk_geo_long;
STRING10 pk_seq_num;
STRING1  pk_gender_code;
STRING4  pk_msa;
STRING4  pk_smma;
STRING4  pk_dma;
STRING1  pk_nielson_count_size_code;
STRING3  pk_area_code;
STRING1  pk_home_ownership_code;
STRING2  pk_household_type_code;
STRING1  pk_marital_status;
STRING3  pk_housing_size;
STRING1  pk_dwelling_type;
STRING1  pk_len_of_res;
STRING1  pk_narrow_band_income_predictor;
STRING2  pk_income_predictor_code;
STRING3  pk_super_niches;
STRING1  pk_mail_responder_buyer_donor_code;
STRING1  pk_mail_responder_indicator;
STRING1  pk_mail_buyer_indicator;
STRING1  pk_mail_donor_indicator;
  string1 pk_household_credit_card0;
  string1 pk_household_credit_card1;
  string1 pk_household_credit_card2;
  string1 pk_household_credit_card3;
  string1 pk_household_credit_card4;
  string1 pk_household_credit_card5;
  string1 pk_household_credit_card6;
  string1 pk_household_credit_card7;
  string1 pk_household_credit_card8;
STRING1  pk_outdoors_dim_household;
STRING1  pk_athletic_dim_household;
STRING1  pk_fitness_dim_household;
STRING1  pk_domestic_dim_household;
STRING1  pk_good_life__dim_household;
STRING1  pk_bluechip_dim_household;
STRING1  pk_doit_yourself_dim_household;
STRING1  pk_technology_dim_household;
STRING2  pk_occupation_code;
STRING4  pk_comb_market_value_all_vehicles;
STRING1  pk_number_of_cars_reg_own;
STRING2  pk_body_size_car_own;
STRING1  pk_truck_owner_code;
STRING1  pk_new_vehicle_purchase_code;
STRING1  pk_motorcycle_own_code;
STRING1  pk_recreational_vehicle_own_code;
STRING1  pk_householder_age_code;
STRING1  pk_number_of_persons_in_household;
STRING1  pk_number_of_adults_in_household;
STRING1  pk_number_of_children;
STRING1  pk_adults_age_75;
STRING1  pk_adults_age_65_74;
STRING1  pk_adults_age_55_64;
STRING1  pk_adults_age_45_54;
STRING1  pk_adults_age_35_44;
STRING1  pk_adults_age_25_34;
STRING1  pk_adults_age_18_24;
STRING1  pk_adults_age_65_inferred;
STRING1  pk_adults_age_45_64inferred;
STRING1  pk_adults_age_35_44inferred;
STRING1  pk_adults_age_under_35_inferred;
STRING1  pk_child_0_2;
STRING1  pk_child_3_5;
STRING1  pk_child_6_10;
STRING1  pk_child_11_15;
STRING1  pk_child_16_17;
STRING1  pk_child_unknown_gender_0_17;
STRING2  pk_age_code;
STRING6  pk_birth_date;
STRING1  pk_family_member_relationship;
STRING1  pk_smacs_level;
STRING3  pk_median_household_income;
STRING2  pk_percent_households_with_children;
STRING2  pk_median_age_adults_18_or_older;
STRING3  pk_median_years_school_completed_25_ol;
STRING2  pk_percent_employ_tech_manag_occup;
STRING2  pk_percent_owner_occupied_housing_unit;
STRING2  pk_percent_in_singal_unit_structures;
STRING3  pk_median_home_value;
STRING2  pk_percent_motor_vehic_own;
STRING2  pk_percent_white;
STRING3  pk_old_narrow_income;
STRING1  pk_old_income_code;
STRING1  pk_income_plus;
STRING5  pk_clean_title;
STRING2  pk_clean_state;
STRING5  pk_clean_zip5;
END;

// Selected Fields from Lifestyle File
lifestyle_formatted_layout := record
STRING20 ls_name_first;
STRING20 ls_name_last;
STRING10 ls_prim_range;
STRING28 ls_prim_name;
STRING8  ls_sec_range;
STRING5  ls_zip5;
STRING4  ls_zip4;
STRING10 ls_geo_lat;
STRING11 ls_geo_long;
STRING10 ls_seq_num;
STRING1  ls_gender;
STRING1  ls_marital_status;
STRING6  ls_dob;
STRING1  ls_income;
STRING1  ls_occupation_respondent;
STRING1  ls_occupation_spouse;
STRING1  ls_self_emp_respondent;
STRING1  ls_education_respondent;
STRING3  ls_credit_cards;
STRING1  ls_home_ownership;
STRING1  ls_art_antique_collecting;
STRING1  ls_automotive_work;
STRING1  ls_bible_reading;
STRING1  ls_bicycling;
STRING1  ls_boating_sailing;
STRING1  ls_book_reading;
STRING1  ls_cable_tv_viewing;
STRING1  ls_camping_hiking;
STRING1  ls_career_oriented_activities;
STRING1  ls_casino_gambling;
STRING1  ls_collectibles;
STRING1  ls_community_activities;
STRING1  ls_crafts;
STRING1  ls_cultural_arts_events;
STRING1  ls_current_affairs_politics;
STRING1  ls_dieting_weight_control;
STRING1  ls_donate_to_charity;
STRING1  ls_fishing;
STRING1  ls_foreign_travel;
STRING1  ls_gardening;
STRING1  ls_golf;
STRING1  ls_gourmet_cooking;
STRING1  ls_grandchildren;
STRING1  ls_health_natural_foods;
STRING1  ls_home_personal_computer;
STRING1  ls_home_workshop;
STRING1  ls_household_pets;
STRING1  ls_hunting;
STRING1  ls_mail_order;
STRING1  ls_military_veteran;
STRING1  ls_money_making_opportunities;
STRING1  ls_needlework_knitting;
STRING1  ls_our_nations_heritage;
STRING1  ls_photography;
STRING1  ls_physical_fitness_exercise;
STRING1  ls_real_estate_investment;
STRING1  ls_running_jogging;
STRING1  ls_science_fiction;
STRING1  ls_science_new_technology;
STRING1  ls_self_improvement;
STRING1  ls_sewing;
STRING1  ls_stock_bond_investments;
STRING1  ls_sweepstakes_contests;
STRING1  ls_tennis;
STRING1  ls_travel_usa;
STRING1  ls_walking_for_health;
STRING1  ls_watch_sports_on_tv;
STRING1  ls_wildlife_environmental_issues;
// lifestyle_composites
STRING1  ls_comp_sports;
STRING1  ls_comp_traditional;
STRING1  ls_comp_professional;
STRING1  ls_comp_investor;
STRING1  ls_comp_audio_visual;
STRING1  ls_comp_campgrounder;
STRING1  ls_comp_intelligentsia;
STRING1  ls_comp_mechanic;
STRING1  ls_comp_reader;
STRING1  ls_comp_chiphead;
STRING1  ls_comp_home_garden;
STRING1  ls_comp_triathlete;
STRING1  ls_comp_connoisseur;
STRING1  ls_comp_ecologist;
STRING1  ls_comp_tv_guide;
STRING1  ls_comp_collector;
STRING1  ls_comp_handicrafts;
STRING1  ls_comp_field_stream;
END;


// Format selected Polk Data
polk_formatted_layout FormatPolkData(polk_file L) := TRANSFORM
SELF.pk_fname := L.clean_fname;
SELF.pk_lname := L.clean_lname;
SELF.pk_prim_range := L.clean_prim_range;
SELF.pk_prim_name := L.clean_prim_name;
SELF.pk_sec_range := L.clean_sec_range;
SELF.pk_zip5 := L.clean_zip5;
SELF.pk_zip4 := L.clean_zip4;
SELF.pk_geo_lat := L.clean_geo_lat;
SELF.pk_geo_long := L.clean_geo_long;
SELF.pk_seq_num := L.seq_num;
SELF.pk_gender_code := L.gender_code;
SELF.pk_msa := L.msa;
SELF.pk_smma := L.smma;
SELF.pk_dma := L.dma;
SELF.pk_nielson_count_size_code := L.nielson_count_size_code;
SELF.pk_area_code := L.area_code;
SELF.pk_home_ownership_code := MAP(L.home_ownership_code = '' => '0',
                                   L.home_ownership_code = '1' => '2',
                                   L.home_ownership_code = '3' => '4',
                                   L.home_ownership_code);
SELF.pk_household_type_code := IF(L.household_type_code = '', '00', L.household_type_code);
SELF.pk_marital_status := L.marital_status;
SELF.pk_housing_size := L.housing_size;
SELF.pk_dwelling_type := if(L.dwelling_type = '','0',L.dwelling_type);
SELF.pk_len_of_res := L.len_of_res;
SELF.pk_narrow_band_income_predictor := L.narrow_band_income_predictor;
SELF.pk_income_predictor_code := MAP(L.income_predictor_code = '' => '0', 
									 L.income_predictor_code = 'A' => '10',
									 L.income_predictor_code);
SELF.pk_super_niches := L.super_niches;
SELF.pk_mail_responder_buyer_donor_code := L.mail_responder_buyer_donor_code;
SELF.pk_mail_responder_indicator := IF(L.mail_responder_indicator = '', '0', L.mail_responder_indicator);
SELF.pk_mail_buyer_indicator := IF(L.mail_buyer_indicator = '', '0', L.mail_buyer_indicator);
SELF.pk_mail_donor_indicator := L.mail_donor_indicator;
SELF.pk_household_credit_card0 := if(((integer)L.household_credit_card & 32768) <> 0,'Y','N');
SELF.pk_household_credit_card1 := if(((integer)L.household_credit_card & 16384) <> 0,'Y','N');
SELF.pk_household_credit_card2 := if(((integer)L.household_credit_card & 8192) <> 0,'Y','N');
SELF.pk_household_credit_card3 := if(((integer)L.household_credit_card & 4096) <> 0,'Y','N');
SELF.pk_household_credit_card4 := if(((integer)L.household_credit_card & 2048) <> 0,'Y','N');
SELF.pk_household_credit_card5 := if(((integer)L.household_credit_card & 1024) <> 0,'Y','N');
SELF.pk_household_credit_card6 := if(((integer)L.household_credit_card & 512) <> 0,'Y','N');
SELF.pk_household_credit_card7 := if(((integer)L.household_credit_card & 256) <> 0,'Y','N');
SELF.pk_household_credit_card8 := if(((integer)L.household_credit_card & 128) <> 0,'Y','N');
SELF.pk_outdoors_dim_household := L.outdoors_dim_household;
SELF.pk_athletic_dim_household := L.athletic_dim_household;
SELF.pk_fitness_dim_household := L.fitness_dim_household;
SELF.pk_domestic_dim_household := L.domestic_dim_household;
SELF.pk_good_life__dim_household := L.good_life__dim_household;
SELF.pk_bluechip_dim_household := L.bluechip_dim_household;
SELF.pk_doit_yourself_dim_household := L.doit_yourself_dim_household;
SELF.pk_technology_dim_household := L.technology_dim_household;
SELF.pk_occupation_code := MAP(L.occupation_code = '' OR L.occupation_code = '70' => '00',
                               L.occupation_code IN ['10','11','12','13'] => '10',
                               L.occupation_code IN ['20','21','22','23'] => '20',
                               L.occupation_code IN ['50','51','52','60','61','62'] => '50',
                               L.occupation_code);
SELF.pk_comb_market_value_all_vehicles := L.comb_market_value_all_vehicles;
SELF.pk_number_of_cars_reg_own := L.number_of_cars_reg_own;
SELF.pk_body_size_car_own := L.body_size_car_own;
SELF.pk_truck_owner_code := L.truck_owner_code;
SELF.pk_new_vehicle_purchase_code := L.new_vehicle_purchase_code;
SELF.pk_motorcycle_own_code := L.motorcycle_own_code;
SELF.pk_recreational_vehicle_own_code := L.recreational_vehicle_own_code;
SELF.pk_householder_age_code := IF(L.householder_age_code = '', '0', L.householder_age_code);
SELF.pk_number_of_persons_in_household := L.number_of_persons_in_household;
SELF.pk_number_of_adults_in_household := L.number_of_adults_in_household;
SELF.pk_number_of_children := L.number_of_children;
SELF.pk_adults_age_75 := L.adults_age_75;
SELF.pk_adults_age_65_74 := L.adults_age_65_74;
SELF.pk_adults_age_55_64 := L.adults_age_55_64;
SELF.pk_adults_age_45_54 := L.adults_age_45_54;
SELF.pk_adults_age_35_44 := L.adults_age_35_44;
SELF.pk_adults_age_25_34 := L.adults_age_25_34;
SELF.pk_adults_age_18_24 := L.adults_age_18_24;
SELF.pk_adults_age_65_inferred := L.adults_age_65_inferred;
SELF.pk_adults_age_45_64inferred := L.adults_age_45_64inferred;
SELF.pk_adults_age_35_44inferred := L.adults_age_35_44inferred;
SELF.pk_adults_age_under_35_inferred := L.adults_age_under_35_inferred;
SELF.pk_child_0_2 := L.child_0_2;
SELF.pk_child_3_5 := L.child_3_5;
SELF.pk_child_6_10 := L.child_6_10;
SELF.pk_child_11_15 := L.child_11_15;
SELF.pk_child_16_17 := L.child_16_17;
SELF.pk_child_unknown_gender_0_17 := L.child_unknown_gender_0_17;
SELF.pk_age_code := L.age_code;
SELF.pk_birth_date := L.birth_date;
SELF.pk_family_member_relationship := L.family_member_relationship;
SELF.pk_smacs_level := L.smacs_level;
SELF.pk_median_household_income := L.median_household_income;
SELF.pk_percent_households_with_children := L.percent_households_with_children;
SELF.pk_median_age_adults_18_or_older := L.median_age_adults_18_or_older;
SELF.pk_median_years_school_completed_25_ol := L.median_years_school_completed_25_ol;
SELF.pk_percent_employ_tech_manag_occup := L.percent_employ_tech_manag_occup;
SELF.pk_percent_owner_occupied_housing_unit := L.percent_owner_occupied_housing_unit;
SELF.pk_percent_in_singal_unit_structures := L.percent_in_singal_unit_structures;
SELF.pk_median_home_value := L.median_home_value;
SELF.pk_percent_motor_vehic_own := L.percent_motor_vehic_own;
SELF.pk_percent_white := L.percent_white;
SELF.pk_old_narrow_income := L.old_narrow_income;
SELF.pk_old_income_code := L.old_income_code;
SELF.pk_income_plus := L.income_plus;
SELF.pk_clean_title := L.clean_title;
SELF.pk_clean_state := L.clean_state;
SELF.pk_clean_zip5 := L.clean_zip5;
end;


lifestyle_formatted_layout FormatLifeStyleData(life_file L) := TRANSFORM
SELF.ls_name_first := L.name_First;
SELF.ls_name_last := L.name_last;
SELF.ls_prim_range := L.prim_range;
SELF.ls_prim_name := L.prim_name;
SELF.ls_sec_range := L.sec_range;
SELF.ls_zip5 := L.ace_zip;
SELF.ls_zip4 := L.ace_zip4;
SELF.ls_geo_lat := L.geo_lat;
SELF.ls_geo_long := L.geo_long;
SELF.ls_seq_num := L.seq_num;
SELF.ls_gender := L.gender;
SELF.ls_marital_status := L.marital_status;
SELF.ls_dob := L.dob;
SELF.ls_income := L.income;
SELF.ls_occupation_respondent := L.occupation_respondent;
SELF.ls_occupation_spouse := L.occupation_spouse;
SELF.ls_self_emp_respondent := L.self_emp_respondent;
SELF.ls_education_respondent := L.education_respondent;
SELF.ls_credit_cards := L.credit_cards;
SELF.ls_home_ownership := L.home_ownership;
SELF.ls_art_antique_collecting := L.art_antique_collecting;
SELF.ls_automotive_work := L.automotive_work;
SELF.ls_bible_reading := L.bible_reading;
SELF.ls_bicycling := L.bicycling;
SELF.ls_boating_sailing := L.boating_sailing;
SELF.ls_book_reading := L.book_reading;
SELF.ls_cable_tv_viewing := L.cable_tv_viewing;
SELF.ls_camping_hiking := L.camping_hiking;
SELF.ls_career_oriented_activities := L.career_oriented_activities;
SELF.ls_casino_gambling := L.casino_gambling;
SELF.ls_collectibles := L.collectibles;
SELF.ls_community_activities := L.community_activities;
SELF.ls_crafts := L.crafts;
SELF.ls_cultural_arts_events := L.cultural_arts_events;
SELF.ls_current_affairs_politics := L.current_affairs_politics;
SELF.ls_dieting_weight_control := L.dieting_weight_control;
SELF.ls_donate_to_charity := L.donate_to_charity;
SELF.ls_fishing := L.fishing;
SELF.ls_foreign_travel := L.foreign_travel;
SELF.ls_gardening := L.gardening;
SELF.ls_golf := L.golf;
SELF.ls_gourmet_cooking := L.gourmet_cooking;
SELF.ls_grandchildren := L.grandchildren;
SELF.ls_health_natural_foods := L.health_natural_foods;
SELF.ls_home_personal_computer := L.home_personal_computer;
SELF.ls_home_workshop := L.home_workshop;
SELF.ls_household_pets := L.household_pets;
SELF.ls_hunting := L.hunting;
SELF.ls_mail_order := L.mail_order;
SELF.ls_military_veteran := L.military_veteran;
SELF.ls_money_making_opportunities := L.money_making_opportunities;
SELF.ls_needlework_knitting := L.needlework_knitting;
SELF.ls_our_nations_heritage := L.our_nations_heritage;
SELF.ls_photography := L.photography;
SELF.ls_physical_fitness_exercise := L.physical_fitness_exercise;
SELF.ls_real_estate_investment := L.real_estate_investment;
SELF.ls_running_jogging := L.running_jogging;
SELF.ls_science_fiction := L.science_fiction;
SELF.ls_science_new_technology := L.science_new_technology;
SELF.ls_self_improvement := L.self_improvement;
SELF.ls_sewing := L.sewing;
SELF.ls_stock_bond_investments := L.stock_bond_investments;
SELF.ls_sweepstakes_contests := L.sweepstakes_contests;
SELF.ls_tennis := L.tennis;
SELF.ls_travel_usa := L.travel_usa;
SELF.ls_walking_for_health := L.walking_for_health;
SELF.ls_watch_sports_on_tv := L.watch_sports_on_tv;
SELF.ls_wildlife_environmental_issues := L.wildlife_environmental_issues;
// lifestyle_composites
SELF.ls_comp_sports := L.comp_sports;
SELF.ls_comp_traditional := L.comp_traditional;
SELF.ls_comp_professional := L.comp_professional;
SELF.ls_comp_investor := L.comp_investor;
SELF.ls_comp_audio_visual := L.comp_audio_visual;
SELF.ls_comp_campgrounder := L.comp_campgrounder;
SELF.ls_comp_intelligentsia := L.comp_intelligentsia;
SELF.ls_comp_mechanic := L.comp_mechanic;
SELF.ls_comp_reader := L.comp_reader;
SELF.ls_comp_chiphead := L.comp_chiphead;
SELF.ls_comp_home_garden := L.comp_home_garden;
SELF.ls_comp_triathlete := L.comp_triathlete;
SELF.ls_comp_connoisseur := L.comp_connoisseur;
SELF.ls_comp_ecologist := L.comp_ecologist;
SELF.ls_comp_tv_guide := L.comp_tv_guide;
SELF.ls_comp_collector := L.comp_collector;
SELF.ls_comp_handicrafts := L.comp_handicrafts;
SELF.ls_comp_field_stream := L.comp_field_stream;
END;

// Format selected fields from the Polk and Lifestyle files
formatted_polk := project(polk_file,FormatPolkData(left));
formatted_life := project(life_file,FormatLifeStyleData(left));

COUNT(formatted_polk);
COUNT(formatted_life);

formatted_polk_dist := distribute(formatted_polk,hash(pk_zip5, pk_prim_name));
formatted_lifestyle_dist := distribute(formatted_life,hash(ls_zip5, ls_prim_name));

// Add unique record id to Customer file for deduping
Layout_Customer_Analytic_Seq := RECORD
INTEGER8 record_id;
Lending_Tree.Layout_Customer_Analytic;
END;

Layout_Customer_Analytic_Seq InitRecordID(Lending_Tree.Layout_Customer_HH L) := TRANSFORM
SELF.record_id := 0;
SELF := L;
END;

Customer_HH_Init := PROJECT(Lending_Tree.File_Customers_HH, InitRecordID(LEFT));

ut.MAC_Sequence_Records(Customer_HH_Init, record_id, Customer_HH_Seq)

Customer_HH_Dist := distribute(Customer_HH_Seq, hash(ace_zip, prim_name));


// Create the Analytic Customer file by joining the Customers to
// Polk and Lifestyle files
Layout_Customer_Analytic_Seq AppendPolktoCustomer(Layout_Customer_Analytic_Seq L, polk_formatted_layout R) := TRANSFORM
SELF.Polk_Flag := IF(R.pk_seq_num <> '', 'Y', 'N');
SELF := R;
SELF := L;
END;

Customer_Analytic_Polk := JOIN(Customer_HH_Dist,
                               formatted_polk_dist,
                               LEFT.ace_zip = RIGHT.pk_zip5 AND
                                 LEFT.prim_name = RIGHT.pk_prim_name AND
                                 LEFT.prim_range = RIGHT.pk_prim_range AND
                                 LEFT.name_last = RIGHT.pk_lname AND
                                 ut.NNEQ(LEFT.sec_range, RIGHT.pk_sec_range),
                               AppendPolktoCustomer(LEFT, RIGHT),
                               LEFT OUTER,
                               LOCAL);

Layout_Customer_Analytic_Seq AppendLifestyletoCustomer(Layout_Customer_Analytic_Seq L, lifestyle_formatted_layout R) := TRANSFORM
SELF.Lifestyle_Flag := IF(R.ls_seq_num <> '', 'Y', 'N');
SELF := R;
SELF := L;
END;

Customer_Analytic_Polk_Lifestyle := JOIN(Customer_Analytic_Polk,
                                         formatted_lifestyle_dist,
                                         LEFT.ace_zip = RIGHT.ls_zip5 AND
                                           LEFT.prim_name = RIGHT.ls_prim_name AND
                                           LEFT.prim_range = RIGHT.ls_prim_range AND
                                           LEFT.name_last = RIGHT.ls_name_last AND
                                           NID.PreferredFirstVersionedStr(LEFT.name_first, NID.version) = NID.PreferredFirstVersionedStr(RIGHT.ls_name_first, NID.version) AND
                                           ut.NNEQ(LEFT.sec_range, RIGHT.ls_sec_range),
                                         AppendLifestyletoCustomer(LEFT, RIGHT),
                                         LEFT OUTER,
                                         LOCAL);

Customer_Analytic_Polk_Lifestyle_Dedup := DEDUP(Customer_Analytic_Polk_Lifestyle, record_id, ALL);

Lending_Tree.Layout_Customer_Analytic RemoveRecordID(Layout_Customer_Analytic_Seq L) := TRANSFORM
SELF := L;
END;

Customer_Analytic_Polk_Lifestyle_Final := PROJECT(Customer_Analytic_Polk_Lifestyle_Dedup, RemoveRecordID(LEFT));

OUTPUT(Customer_Analytic_Polk_Lifestyle_Final,,'LendTree::Customer_Analytic');
COUNT(Customer_Analytic_Polk_Lifestyle_Final);

// Create the Random Polk-Lifestyle file by an left outer join between
// the formatted Polk file and the formatted Lifestyle file
Lending_Tree.Layout_Polk_Lifestyle_Random CombinePolkLifestyle(polk_formatted_layout L, lifestyle_formatted_layout R) := TRANSFORM
SELF.Polk_Flag := IF(L.pk_seq_num <> '', 'Y', 'N');
SELF.Lifestyle_Flag := IF(R.ls_seq_num <> '', 'Y', 'N');
SELF := R;
SELF := L;
END;

Polk_Lifestyle_Random := JOIN(formatted_polk_dist,
                              formatted_lifestyle_dist,
                              LEFT.pk_zip5 = RIGHT.ls_zip5 AND
                                LEFT.pk_prim_name = RIGHT.ls_prim_name AND
                                LEFT.pk_prim_range = RIGHT.ls_prim_range AND
                                LEFT.pk_lname = RIGHT.ls_name_last AND
                                NID.PreferredFirstVersionedStr(LEFT.pk_fname, NID.version) = NID.PreferredFirstVersionedStr(RIGHT.ls_name_first, NID.version) AND
                                ut.NNEQ(LEFT.pk_sec_range, RIGHT.ls_sec_range),
                              CombinePolkLifestyle(LEFT, RIGHT),
                              LEFT OUTER,
                              LOCAL);

Polk_Lifestyle_Random_Dedup := DEDUP(Polk_Lifestyle_Random, pk_seq_num, ALL);

COUNT(Polk_Lifestyle_Random_Dedup);

Polk_Lifestyle_Random_Sample := ENTH(Polk_Lifestyle_Random_Dedup, 200000);

OUTPUT(Polk_Lifestyle_Random_Sample,,'LendTree::Polk_Lifestyle_Random');
COUNT(Polk_Lifestyle_Random_Sample);