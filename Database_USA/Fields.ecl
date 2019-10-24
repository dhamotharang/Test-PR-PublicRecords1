IMPORT SALT311;
EXPORT Fields := MODULE
 
EXPORT NumFields := 322;
 
EXPORT SALT311.StrType FieldName(UNSIGNED2 i) := CHOOSE(i,'dt_first_seen','dt_last_seen','dt_vendor_first_reported','dt_vendor_last_reported','process_date','dotid','dotscore','dotweight','empid','empscore','empweight','powid','powscore','powweight','proxid','proxscore','proxweight','selescore','seleweight','orgid','orgscore','orgweight','ultid','ultscore','ultweight','record_type','global_sid','dbusa_business_id','dbusa_executive_id','subhq_parent_id','hq_id','ind_frm_indicator','company_name','full_name','prefix','first_name','middle_initial','last_name','suffix','gender','standardized_title','sourcetitle','executive_title_rank','primary_exec_flag','exec_type','executive_department','executive_level','phy_addr_standardized','phy_addr_city','phy_addr_state','phy_addr_zip','phy_addr_zip4','phy_addr_carrierroute','phy_addr_deliverypt','phy_addr_deliveryptchkdig','mail_addr_standardized','mail_addr_city','mail_addr_state','mail_addr_zip','mail_addr_zip4','mail_addr_carrierroute','mail_addr_deliverypt','mail_addr_deliveryptchkdig','mail_score','mail_score_desc','phone','area_code','fax','email','email_available_indicator','url','url_facebook','url_googleplus','url_instagram','url_linkedin','url_twitter','url_youtube','business_status_code','business_status_desc','franchise_flag','franchise_type','franchise_desc','ticker_symbol','stock_exchange','fortune_1000_flag','fortune_1000_rank','fortune_1000_branches','num_linked_locations','county_code','county_desc','cbsa_code','cbsa_desc','geo_match_level','latitude','longitude','scf','timezone','censustract','censusblock','city_population_code','city_population_descr','primary_sic','primary_sic_desc','sic02','sic02_desc','sic03','sic03_desc','sic04','sic04_desc','sic05','sic05_desc','sic06','sic06_desc','primarysic2','primary_2_digit_sic_desc','primarysic4','primary_4_digit_sic_desc','naics01','naics01_desc','naics02','naics02_desc','naics03','naics03_desc','naics04','naics04_desc','naics05','naics05_desc','naics06','naics06_desc','location_employees_total','location_employee_code','location_employee_desc','location_sales_total','location_sales_code','location_sales_desc','corporate_employee_total','corporate_employee_code','corporate_employee_desc','year_established','years_in_business_range','female_owned','minority_owned_flag','minority_type','home_based_indicator','small_business_indicator','import_export','manufacturing_location','public_indicator','ein','non_profit_org','square_footage','square_footage_code','square_footage_desc','creditscore','creditcode','credit_desc','credit_capacity','credit_capacity_code','credit_capacity_desc','advertising_expenses_code','expense_advertising_desc','technology_expenses_code','expense_technology_desc','office_equip_expenses_code','expense_office_equip_desc','rent_expenses_code','expense_rent_desc','telecom_expenses_code','expense_telecom_desc','accounting_expenses_code','expense_accounting_desc','bus_insurance_expense_code','expense_bus_insurance_desc','legal_expenses_code','expense_legal_desc','utilities_expenses_code','expense_utilities_desc','number_of_pcs_code','number_of_pcs_desc','nb_flag','hq_company_name','hq_city','hq_state','subhq_parent_name','subhq_parent_city','subhq_parent_state','domestic_foreign_owner_flag','foreign_parent_company_name','foreign_parent_city','foreign_parent_country','db_cons_matchkey','databaseusa_individual_id','db_cons_full_name','db_cons_full_name_prefix','db_cons_first_name','db_cons_middle_initial','db_cons_last_name','db_cons_email','db_cons_gender','db_cons_date_of_birth_year','db_cons_date_of_birth_month','db_cons_age','db_cons_age_code_desc','db_cons_age_in_two_year_hh','db_cons_ethnic_code','db_cons_religious_affil','db_cons_language_pref','db_cons_phy_addr_std','db_cons_phy_addr_city','db_cons_phy_addr_state','db_cons_phy_addr_zip','db_cons_phy_addr_zip4','db_cons_phy_addr_carrierroute','db_cons_phy_addr_deliverypt','db_cons_line_of_travel','db_cons_geocode_results','db_cons_latitude','db_cons_longitude','db_cons_time_zone_code','db_cons_time_zone_desc','db_cons_census_tract','db_cons_census_block','db_cons_countyfips','db_countyname','db_cons_cbsa_code','db_cons_cbsa_desc','db_cons_walk_sequence','db_cons_phone','db_cons_dnc','db_cons_scrubbed_phoneable','db_cons_children_present','db_cons_home_value_code','db_cons_home_value_desc','db_cons_donor_capacity','db_cons_donor_capacity_code','db_cons_donor_capacity_desc','db_cons_home_owner_renter','db_cons_length_of_res','db_cons_length_of_res_code','db_cons_length_of_res_desc','db_cons_dwelling_type','db_cons_recent_home_buyer','db_cons_income_code','db_cons_income_desc','db_cons_unsecuredcredcap','db_cons_unsecuredcredcapcode','db_cons_unsecuredcredcapdesc','db_cons_networthhomeval','db_cons_networthhomevalcode','db_cons_net_worth_desc','db_cons_discretincome','db_cons_discretincomecode','db_cons_discretincomedesc','db_cons_marital_status','db_cons_new_parent','db_cons_child_near_hs_grad','db_cons_college_graduate','db_cons_intend_purchase_veh','db_cons_recent_divorce','db_cons_newlywed','db_cons_new_teen_driver','db_cons_home_year_built','db_cons_home_sqft_ranges','db_cons_poli_party_ind','db_cons_home_sqft_actual','db_cons_occupation_ind','db_cons_credit_card_user','db_cons_home_property_type','db_cons_education_hh','db_cons_education_ind','db_cons_other_pet_owner','businesstypedesc','genderdesc','executivetypedesc','dbconsgenderdesc','dbconsethnicdesc','dbconsreligiousdesc','dbconslangprefdesc','dbconsownerrenter','dbconsdwellingtypedesc','dbconsmaritaldesc','dbconsnewparentdesc','dbconsteendriverdesc','dbconspolipartydesc','dbconsoccupationdesc','dbconspropertytypedesc','dbconsheadhouseeducdesc','dbconseducationdesc','title','fname','mname','lname','name_score','prim_range','predir','prim_name','addr_suffix','postdir','unit_desig','sec_range','p_city_name','v_city_name','st','cart','cr_sort_sz','lot','lot_order','dbpc','chk_digit','rec_type','fips_state','fips_county','geo_lat','geo_long','msa','geo_blk','geo_match','err_stat','raw_aid','ace_aid','prep_address_line1','prep_address_line_last');
EXPORT SALT311.StrType FlatName(UNSIGNED2 i) := CHOOSE(i,'dt_first_seen','dt_last_seen','dt_vendor_first_reported','dt_vendor_last_reported','process_date','dotid','dotscore','dotweight','empid','empscore','empweight','powid','powscore','powweight','proxid','proxscore','proxweight','selescore','seleweight','orgid','orgscore','orgweight','ultid','ultscore','ultweight','record_type','global_sid','dbusa_business_id','dbusa_executive_id','subhq_parent_id','hq_id','ind_frm_indicator','company_name','full_name','prefix','first_name','middle_initial','last_name','suffix','gender','standardized_title','sourcetitle','executive_title_rank','primary_exec_flag','exec_type','executive_department','executive_level','phy_addr_standardized','phy_addr_city','phy_addr_state','phy_addr_zip','phy_addr_zip4','phy_addr_carrierroute','phy_addr_deliverypt','phy_addr_deliveryptchkdig','mail_addr_standardized','mail_addr_city','mail_addr_state','mail_addr_zip','mail_addr_zip4','mail_addr_carrierroute','mail_addr_deliverypt','mail_addr_deliveryptchkdig','mail_score','mail_score_desc','phone','area_code','fax','email','email_available_indicator','url','url_facebook','url_googleplus','url_instagram','url_linkedin','url_twitter','url_youtube','business_status_code','business_status_desc','franchise_flag','franchise_type','franchise_desc','ticker_symbol','stock_exchange','fortune_1000_flag','fortune_1000_rank','fortune_1000_branches','num_linked_locations','county_code','county_desc','cbsa_code','cbsa_desc','geo_match_level','latitude','longitude','scf','timezone','censustract','censusblock','city_population_code','city_population_descr','primary_sic','primary_sic_desc','sic02','sic02_desc','sic03','sic03_desc','sic04','sic04_desc','sic05','sic05_desc','sic06','sic06_desc','primarysic2','primary_2_digit_sic_desc','primarysic4','primary_4_digit_sic_desc','naics01','naics01_desc','naics02','naics02_desc','naics03','naics03_desc','naics04','naics04_desc','naics05','naics05_desc','naics06','naics06_desc','location_employees_total','location_employee_code','location_employee_desc','location_sales_total','location_sales_code','location_sales_desc','corporate_employee_total','corporate_employee_code','corporate_employee_desc','year_established','years_in_business_range','female_owned','minority_owned_flag','minority_type','home_based_indicator','small_business_indicator','import_export','manufacturing_location','public_indicator','ein','non_profit_org','square_footage','square_footage_code','square_footage_desc','creditscore','creditcode','credit_desc','credit_capacity','credit_capacity_code','credit_capacity_desc','advertising_expenses_code','expense_advertising_desc','technology_expenses_code','expense_technology_desc','office_equip_expenses_code','expense_office_equip_desc','rent_expenses_code','expense_rent_desc','telecom_expenses_code','expense_telecom_desc','accounting_expenses_code','expense_accounting_desc','bus_insurance_expense_code','expense_bus_insurance_desc','legal_expenses_code','expense_legal_desc','utilities_expenses_code','expense_utilities_desc','number_of_pcs_code','number_of_pcs_desc','nb_flag','hq_company_name','hq_city','hq_state','subhq_parent_name','subhq_parent_city','subhq_parent_state','domestic_foreign_owner_flag','foreign_parent_company_name','foreign_parent_city','foreign_parent_country','db_cons_matchkey','databaseusa_individual_id','db_cons_full_name','db_cons_full_name_prefix','db_cons_first_name','db_cons_middle_initial','db_cons_last_name','db_cons_email','db_cons_gender','db_cons_date_of_birth_year','db_cons_date_of_birth_month','db_cons_age','db_cons_age_code_desc','db_cons_age_in_two_year_hh','db_cons_ethnic_code','db_cons_religious_affil','db_cons_language_pref','db_cons_phy_addr_std','db_cons_phy_addr_city','db_cons_phy_addr_state','db_cons_phy_addr_zip','db_cons_phy_addr_zip4','db_cons_phy_addr_carrierroute','db_cons_phy_addr_deliverypt','db_cons_line_of_travel','db_cons_geocode_results','db_cons_latitude','db_cons_longitude','db_cons_time_zone_code','db_cons_time_zone_desc','db_cons_census_tract','db_cons_census_block','db_cons_countyfips','db_countyname','db_cons_cbsa_code','db_cons_cbsa_desc','db_cons_walk_sequence','db_cons_phone','db_cons_dnc','db_cons_scrubbed_phoneable','db_cons_children_present','db_cons_home_value_code','db_cons_home_value_desc','db_cons_donor_capacity','db_cons_donor_capacity_code','db_cons_donor_capacity_desc','db_cons_home_owner_renter','db_cons_length_of_res','db_cons_length_of_res_code','db_cons_length_of_res_desc','db_cons_dwelling_type','db_cons_recent_home_buyer','db_cons_income_code','db_cons_income_desc','db_cons_unsecuredcredcap','db_cons_unsecuredcredcapcode','db_cons_unsecuredcredcapdesc','db_cons_networthhomeval','db_cons_networthhomevalcode','db_cons_net_worth_desc','db_cons_discretincome','db_cons_discretincomecode','db_cons_discretincomedesc','db_cons_marital_status','db_cons_new_parent','db_cons_child_near_hs_grad','db_cons_college_graduate','db_cons_intend_purchase_veh','db_cons_recent_divorce','db_cons_newlywed','db_cons_new_teen_driver','db_cons_home_year_built','db_cons_home_sqft_ranges','db_cons_poli_party_ind','db_cons_home_sqft_actual','db_cons_occupation_ind','db_cons_credit_card_user','db_cons_home_property_type','db_cons_education_hh','db_cons_education_ind','db_cons_other_pet_owner','businesstypedesc','genderdesc','executivetypedesc','dbconsgenderdesc','dbconsethnicdesc','dbconsreligiousdesc','dbconslangprefdesc','dbconsownerrenter','dbconsdwellingtypedesc','dbconsmaritaldesc','dbconsnewparentdesc','dbconsteendriverdesc','dbconspolipartydesc','dbconsoccupationdesc','dbconspropertytypedesc','dbconsheadhouseeducdesc','dbconseducationdesc','title','fname','mname','lname','name_score','prim_range','predir','prim_name','addr_suffix','postdir','unit_desig','sec_range','p_city_name','v_city_name','st','cart','cr_sort_sz','lot','lot_order','dbpc','chk_digit','rec_type','fips_state','fips_county','geo_lat','geo_long','msa','geo_blk','geo_match','err_stat','raw_aid','ace_aid','prep_address_line1','prep_address_line_last');
EXPORT FieldNum(SALT311.StrType fn) := CASE(fn,'dt_first_seen' => 0,'dt_last_seen' => 1,'dt_vendor_first_reported' => 2,'dt_vendor_last_reported' => 3,'process_date' => 4,'dotid' => 5,'dotscore' => 6,'dotweight' => 7,'empid' => 8,'empscore' => 9,'empweight' => 10,'powid' => 11,'powscore' => 12,'powweight' => 13,'proxid' => 14,'proxscore' => 15,'proxweight' => 16,'selescore' => 17,'seleweight' => 18,'orgid' => 19,'orgscore' => 20,'orgweight' => 21,'ultid' => 22,'ultscore' => 23,'ultweight' => 24,'record_type' => 25,'global_sid' => 26,'dbusa_business_id' => 27,'dbusa_executive_id' => 28,'subhq_parent_id' => 29,'hq_id' => 30,'ind_frm_indicator' => 31,'company_name' => 32,'full_name' => 33,'prefix' => 34,'first_name' => 35,'middle_initial' => 36,'last_name' => 37,'suffix' => 38,'gender' => 39,'standardized_title' => 40,'sourcetitle' => 41,'executive_title_rank' => 42,'primary_exec_flag' => 43,'exec_type' => 44,'executive_department' => 45,'executive_level' => 46,'phy_addr_standardized' => 47,'phy_addr_city' => 48,'phy_addr_state' => 49,'phy_addr_zip' => 50,'phy_addr_zip4' => 51,'phy_addr_carrierroute' => 52,'phy_addr_deliverypt' => 53,'phy_addr_deliveryptchkdig' => 54,'mail_addr_standardized' => 55,'mail_addr_city' => 56,'mail_addr_state' => 57,'mail_addr_zip' => 58,'mail_addr_zip4' => 59,'mail_addr_carrierroute' => 60,'mail_addr_deliverypt' => 61,'mail_addr_deliveryptchkdig' => 62,'mail_score' => 63,'mail_score_desc' => 64,'phone' => 65,'area_code' => 66,'fax' => 67,'email' => 68,'email_available_indicator' => 69,'url' => 70,'url_facebook' => 71,'url_googleplus' => 72,'url_instagram' => 73,'url_linkedin' => 74,'url_twitter' => 75,'url_youtube' => 76,'business_status_code' => 77,'business_status_desc' => 78,'franchise_flag' => 79,'franchise_type' => 80,'franchise_desc' => 81,'ticker_symbol' => 82,'stock_exchange' => 83,'fortune_1000_flag' => 84,'fortune_1000_rank' => 85,'fortune_1000_branches' => 86,'num_linked_locations' => 87,'county_code' => 88,'county_desc' => 89,'cbsa_code' => 90,'cbsa_desc' => 91,'geo_match_level' => 92,'latitude' => 93,'longitude' => 94,'scf' => 95,'timezone' => 96,'censustract' => 97,'censusblock' => 98,'city_population_code' => 99,'city_population_descr' => 100,'primary_sic' => 101,'primary_sic_desc' => 102,'sic02' => 103,'sic02_desc' => 104,'sic03' => 105,'sic03_desc' => 106,'sic04' => 107,'sic04_desc' => 108,'sic05' => 109,'sic05_desc' => 110,'sic06' => 111,'sic06_desc' => 112,'primarysic2' => 113,'primary_2_digit_sic_desc' => 114,'primarysic4' => 115,'primary_4_digit_sic_desc' => 116,'naics01' => 117,'naics01_desc' => 118,'naics02' => 119,'naics02_desc' => 120,'naics03' => 121,'naics03_desc' => 122,'naics04' => 123,'naics04_desc' => 124,'naics05' => 125,'naics05_desc' => 126,'naics06' => 127,'naics06_desc' => 128,'location_employees_total' => 129,'location_employee_code' => 130,'location_employee_desc' => 131,'location_sales_total' => 132,'location_sales_code' => 133,'location_sales_desc' => 134,'corporate_employee_total' => 135,'corporate_employee_code' => 136,'corporate_employee_desc' => 137,'year_established' => 138,'years_in_business_range' => 139,'female_owned' => 140,'minority_owned_flag' => 141,'minority_type' => 142,'home_based_indicator' => 143,'small_business_indicator' => 144,'import_export' => 145,'manufacturing_location' => 146,'public_indicator' => 147,'ein' => 148,'non_profit_org' => 149,'square_footage' => 150,'square_footage_code' => 151,'square_footage_desc' => 152,'creditscore' => 153,'creditcode' => 154,'credit_desc' => 155,'credit_capacity' => 156,'credit_capacity_code' => 157,'credit_capacity_desc' => 158,'advertising_expenses_code' => 159,'expense_advertising_desc' => 160,'technology_expenses_code' => 161,'expense_technology_desc' => 162,'office_equip_expenses_code' => 163,'expense_office_equip_desc' => 164,'rent_expenses_code' => 165,'expense_rent_desc' => 166,'telecom_expenses_code' => 167,'expense_telecom_desc' => 168,'accounting_expenses_code' => 169,'expense_accounting_desc' => 170,'bus_insurance_expense_code' => 171,'expense_bus_insurance_desc' => 172,'legal_expenses_code' => 173,'expense_legal_desc' => 174,'utilities_expenses_code' => 175,'expense_utilities_desc' => 176,'number_of_pcs_code' => 177,'number_of_pcs_desc' => 178,'nb_flag' => 179,'hq_company_name' => 180,'hq_city' => 181,'hq_state' => 182,'subhq_parent_name' => 183,'subhq_parent_city' => 184,'subhq_parent_state' => 185,'domestic_foreign_owner_flag' => 186,'foreign_parent_company_name' => 187,'foreign_parent_city' => 188,'foreign_parent_country' => 189,'db_cons_matchkey' => 190,'databaseusa_individual_id' => 191,'db_cons_full_name' => 192,'db_cons_full_name_prefix' => 193,'db_cons_first_name' => 194,'db_cons_middle_initial' => 195,'db_cons_last_name' => 196,'db_cons_email' => 197,'db_cons_gender' => 198,'db_cons_date_of_birth_year' => 199,'db_cons_date_of_birth_month' => 200,'db_cons_age' => 201,'db_cons_age_code_desc' => 202,'db_cons_age_in_two_year_hh' => 203,'db_cons_ethnic_code' => 204,'db_cons_religious_affil' => 205,'db_cons_language_pref' => 206,'db_cons_phy_addr_std' => 207,'db_cons_phy_addr_city' => 208,'db_cons_phy_addr_state' => 209,'db_cons_phy_addr_zip' => 210,'db_cons_phy_addr_zip4' => 211,'db_cons_phy_addr_carrierroute' => 212,'db_cons_phy_addr_deliverypt' => 213,'db_cons_line_of_travel' => 214,'db_cons_geocode_results' => 215,'db_cons_latitude' => 216,'db_cons_longitude' => 217,'db_cons_time_zone_code' => 218,'db_cons_time_zone_desc' => 219,'db_cons_census_tract' => 220,'db_cons_census_block' => 221,'db_cons_countyfips' => 222,'db_countyname' => 223,'db_cons_cbsa_code' => 224,'db_cons_cbsa_desc' => 225,'db_cons_walk_sequence' => 226,'db_cons_phone' => 227,'db_cons_dnc' => 228,'db_cons_scrubbed_phoneable' => 229,'db_cons_children_present' => 230,'db_cons_home_value_code' => 231,'db_cons_home_value_desc' => 232,'db_cons_donor_capacity' => 233,'db_cons_donor_capacity_code' => 234,'db_cons_donor_capacity_desc' => 235,'db_cons_home_owner_renter' => 236,'db_cons_length_of_res' => 237,'db_cons_length_of_res_code' => 238,'db_cons_length_of_res_desc' => 239,'db_cons_dwelling_type' => 240,'db_cons_recent_home_buyer' => 241,'db_cons_income_code' => 242,'db_cons_income_desc' => 243,'db_cons_unsecuredcredcap' => 244,'db_cons_unsecuredcredcapcode' => 245,'db_cons_unsecuredcredcapdesc' => 246,'db_cons_networthhomeval' => 247,'db_cons_networthhomevalcode' => 248,'db_cons_net_worth_desc' => 249,'db_cons_discretincome' => 250,'db_cons_discretincomecode' => 251,'db_cons_discretincomedesc' => 252,'db_cons_marital_status' => 253,'db_cons_new_parent' => 254,'db_cons_child_near_hs_grad' => 255,'db_cons_college_graduate' => 256,'db_cons_intend_purchase_veh' => 257,'db_cons_recent_divorce' => 258,'db_cons_newlywed' => 259,'db_cons_new_teen_driver' => 260,'db_cons_home_year_built' => 261,'db_cons_home_sqft_ranges' => 262,'db_cons_poli_party_ind' => 263,'db_cons_home_sqft_actual' => 264,'db_cons_occupation_ind' => 265,'db_cons_credit_card_user' => 266,'db_cons_home_property_type' => 267,'db_cons_education_hh' => 268,'db_cons_education_ind' => 269,'db_cons_other_pet_owner' => 270,'businesstypedesc' => 271,'genderdesc' => 272,'executivetypedesc' => 273,'dbconsgenderdesc' => 274,'dbconsethnicdesc' => 275,'dbconsreligiousdesc' => 276,'dbconslangprefdesc' => 277,'dbconsownerrenter' => 278,'dbconsdwellingtypedesc' => 279,'dbconsmaritaldesc' => 280,'dbconsnewparentdesc' => 281,'dbconsteendriverdesc' => 282,'dbconspolipartydesc' => 283,'dbconsoccupationdesc' => 284,'dbconspropertytypedesc' => 285,'dbconsheadhouseeducdesc' => 286,'dbconseducationdesc' => 287,'title' => 288,'fname' => 289,'mname' => 290,'lname' => 291,'name_score' => 292,'prim_range' => 293,'predir' => 294,'prim_name' => 295,'addr_suffix' => 296,'postdir' => 297,'unit_desig' => 298,'sec_range' => 299,'p_city_name' => 300,'v_city_name' => 301,'st' => 302,'cart' => 303,'cr_sort_sz' => 304,'lot' => 305,'lot_order' => 306,'dbpc' => 307,'chk_digit' => 308,'rec_type' => 309,'fips_state' => 310,'fips_county' => 311,'geo_lat' => 312,'geo_long' => 313,'msa' => 314,'geo_blk' => 315,'geo_match' => 316,'err_stat' => 317,'raw_aid' => 318,'ace_aid' => 319,'prep_address_line1' => 320,'prep_address_line_last' => 321,0);
EXPORT SET OF SALT311.StrType FieldRules(UNSIGNED2 i) := CHOOSE(i,[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[]);
EXPORT BOOLEAN InBaseLayout(UNSIGNED2 i) := CHOOSE(i,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,FALSE);
 
//Individual field level validation
 
EXPORT Make_dt_first_seen(SALT311.StrType s0) := s0;
EXPORT InValid_dt_first_seen(SALT311.StrType s) := 0;
EXPORT InValidMessage_dt_first_seen(UNSIGNED1 wh) := '';
 
EXPORT Make_dt_last_seen(SALT311.StrType s0) := s0;
EXPORT InValid_dt_last_seen(SALT311.StrType s) := 0;
EXPORT InValidMessage_dt_last_seen(UNSIGNED1 wh) := '';
 
EXPORT Make_dt_vendor_first_reported(SALT311.StrType s0) := s0;
EXPORT InValid_dt_vendor_first_reported(SALT311.StrType s) := 0;
EXPORT InValidMessage_dt_vendor_first_reported(UNSIGNED1 wh) := '';
 
EXPORT Make_dt_vendor_last_reported(SALT311.StrType s0) := s0;
EXPORT InValid_dt_vendor_last_reported(SALT311.StrType s) := 0;
EXPORT InValidMessage_dt_vendor_last_reported(UNSIGNED1 wh) := '';
 
EXPORT Make_process_date(SALT311.StrType s0) := s0;
EXPORT InValid_process_date(SALT311.StrType s) := 0;
EXPORT InValidMessage_process_date(UNSIGNED1 wh) := '';
 
EXPORT Make_dotid(SALT311.StrType s0) := s0;
EXPORT InValid_dotid(SALT311.StrType s) := 0;
EXPORT InValidMessage_dotid(UNSIGNED1 wh) := '';
 
EXPORT Make_dotscore(SALT311.StrType s0) := s0;
EXPORT InValid_dotscore(SALT311.StrType s) := 0;
EXPORT InValidMessage_dotscore(UNSIGNED1 wh) := '';
 
EXPORT Make_dotweight(SALT311.StrType s0) := s0;
EXPORT InValid_dotweight(SALT311.StrType s) := 0;
EXPORT InValidMessage_dotweight(UNSIGNED1 wh) := '';
 
EXPORT Make_empid(SALT311.StrType s0) := s0;
EXPORT InValid_empid(SALT311.StrType s) := 0;
EXPORT InValidMessage_empid(UNSIGNED1 wh) := '';
 
EXPORT Make_empscore(SALT311.StrType s0) := s0;
EXPORT InValid_empscore(SALT311.StrType s) := 0;
EXPORT InValidMessage_empscore(UNSIGNED1 wh) := '';
 
EXPORT Make_empweight(SALT311.StrType s0) := s0;
EXPORT InValid_empweight(SALT311.StrType s) := 0;
EXPORT InValidMessage_empweight(UNSIGNED1 wh) := '';
 
EXPORT Make_powid(SALT311.StrType s0) := s0;
EXPORT InValid_powid(SALT311.StrType s) := 0;
EXPORT InValidMessage_powid(UNSIGNED1 wh) := '';
 
EXPORT Make_powscore(SALT311.StrType s0) := s0;
EXPORT InValid_powscore(SALT311.StrType s) := 0;
EXPORT InValidMessage_powscore(UNSIGNED1 wh) := '';
 
EXPORT Make_powweight(SALT311.StrType s0) := s0;
EXPORT InValid_powweight(SALT311.StrType s) := 0;
EXPORT InValidMessage_powweight(UNSIGNED1 wh) := '';
 
EXPORT Make_proxid(SALT311.StrType s0) := s0;
EXPORT InValid_proxid(SALT311.StrType s) := 0;
EXPORT InValidMessage_proxid(UNSIGNED1 wh) := '';
 
EXPORT Make_proxscore(SALT311.StrType s0) := s0;
EXPORT InValid_proxscore(SALT311.StrType s) := 0;
EXPORT InValidMessage_proxscore(UNSIGNED1 wh) := '';
 
EXPORT Make_proxweight(SALT311.StrType s0) := s0;
EXPORT InValid_proxweight(SALT311.StrType s) := 0;
EXPORT InValidMessage_proxweight(UNSIGNED1 wh) := '';
 
EXPORT Make_selescore(SALT311.StrType s0) := s0;
EXPORT InValid_selescore(SALT311.StrType s) := 0;
EXPORT InValidMessage_selescore(UNSIGNED1 wh) := '';
 
EXPORT Make_seleweight(SALT311.StrType s0) := s0;
EXPORT InValid_seleweight(SALT311.StrType s) := 0;
EXPORT InValidMessage_seleweight(UNSIGNED1 wh) := '';
 
EXPORT Make_orgid(SALT311.StrType s0) := s0;
EXPORT InValid_orgid(SALT311.StrType s) := 0;
EXPORT InValidMessage_orgid(UNSIGNED1 wh) := '';
 
EXPORT Make_orgscore(SALT311.StrType s0) := s0;
EXPORT InValid_orgscore(SALT311.StrType s) := 0;
EXPORT InValidMessage_orgscore(UNSIGNED1 wh) := '';
 
EXPORT Make_orgweight(SALT311.StrType s0) := s0;
EXPORT InValid_orgweight(SALT311.StrType s) := 0;
EXPORT InValidMessage_orgweight(UNSIGNED1 wh) := '';
 
EXPORT Make_ultid(SALT311.StrType s0) := s0;
EXPORT InValid_ultid(SALT311.StrType s) := 0;
EXPORT InValidMessage_ultid(UNSIGNED1 wh) := '';
 
EXPORT Make_ultscore(SALT311.StrType s0) := s0;
EXPORT InValid_ultscore(SALT311.StrType s) := 0;
EXPORT InValidMessage_ultscore(UNSIGNED1 wh) := '';
 
EXPORT Make_ultweight(SALT311.StrType s0) := s0;
EXPORT InValid_ultweight(SALT311.StrType s) := 0;
EXPORT InValidMessage_ultweight(UNSIGNED1 wh) := '';
 
EXPORT Make_record_type(SALT311.StrType s0) := s0;
EXPORT InValid_record_type(SALT311.StrType s) := 0;
EXPORT InValidMessage_record_type(UNSIGNED1 wh) := '';
 
EXPORT Make_global_sid(SALT311.StrType s0) := s0;
EXPORT InValid_global_sid(SALT311.StrType s) := 0;
EXPORT InValidMessage_global_sid(UNSIGNED1 wh) := '';
 
EXPORT Make_dbusa_business_id(SALT311.StrType s0) := s0;
EXPORT InValid_dbusa_business_id(SALT311.StrType s) := 0;
EXPORT InValidMessage_dbusa_business_id(UNSIGNED1 wh) := '';
 
EXPORT Make_dbusa_executive_id(SALT311.StrType s0) := s0;
EXPORT InValid_dbusa_executive_id(SALT311.StrType s) := 0;
EXPORT InValidMessage_dbusa_executive_id(UNSIGNED1 wh) := '';
 
EXPORT Make_subhq_parent_id(SALT311.StrType s0) := s0;
EXPORT InValid_subhq_parent_id(SALT311.StrType s) := 0;
EXPORT InValidMessage_subhq_parent_id(UNSIGNED1 wh) := '';
 
EXPORT Make_hq_id(SALT311.StrType s0) := s0;
EXPORT InValid_hq_id(SALT311.StrType s) := 0;
EXPORT InValidMessage_hq_id(UNSIGNED1 wh) := '';
 
EXPORT Make_ind_frm_indicator(SALT311.StrType s0) := s0;
EXPORT InValid_ind_frm_indicator(SALT311.StrType s) := 0;
EXPORT InValidMessage_ind_frm_indicator(UNSIGNED1 wh) := '';
 
EXPORT Make_company_name(SALT311.StrType s0) := s0;
EXPORT InValid_company_name(SALT311.StrType s) := 0;
EXPORT InValidMessage_company_name(UNSIGNED1 wh) := '';
 
EXPORT Make_full_name(SALT311.StrType s0) := s0;
EXPORT InValid_full_name(SALT311.StrType s) := 0;
EXPORT InValidMessage_full_name(UNSIGNED1 wh) := '';
 
EXPORT Make_prefix(SALT311.StrType s0) := s0;
EXPORT InValid_prefix(SALT311.StrType s) := 0;
EXPORT InValidMessage_prefix(UNSIGNED1 wh) := '';
 
EXPORT Make_first_name(SALT311.StrType s0) := s0;
EXPORT InValid_first_name(SALT311.StrType s) := 0;
EXPORT InValidMessage_first_name(UNSIGNED1 wh) := '';
 
EXPORT Make_middle_initial(SALT311.StrType s0) := s0;
EXPORT InValid_middle_initial(SALT311.StrType s) := 0;
EXPORT InValidMessage_middle_initial(UNSIGNED1 wh) := '';
 
EXPORT Make_last_name(SALT311.StrType s0) := s0;
EXPORT InValid_last_name(SALT311.StrType s) := 0;
EXPORT InValidMessage_last_name(UNSIGNED1 wh) := '';
 
EXPORT Make_suffix(SALT311.StrType s0) := s0;
EXPORT InValid_suffix(SALT311.StrType s) := 0;
EXPORT InValidMessage_suffix(UNSIGNED1 wh) := '';
 
EXPORT Make_gender(SALT311.StrType s0) := s0;
EXPORT InValid_gender(SALT311.StrType s) := 0;
EXPORT InValidMessage_gender(UNSIGNED1 wh) := '';
 
EXPORT Make_standardized_title(SALT311.StrType s0) := s0;
EXPORT InValid_standardized_title(SALT311.StrType s) := 0;
EXPORT InValidMessage_standardized_title(UNSIGNED1 wh) := '';
 
EXPORT Make_sourcetitle(SALT311.StrType s0) := s0;
EXPORT InValid_sourcetitle(SALT311.StrType s) := 0;
EXPORT InValidMessage_sourcetitle(UNSIGNED1 wh) := '';
 
EXPORT Make_executive_title_rank(SALT311.StrType s0) := s0;
EXPORT InValid_executive_title_rank(SALT311.StrType s) := 0;
EXPORT InValidMessage_executive_title_rank(UNSIGNED1 wh) := '';
 
EXPORT Make_primary_exec_flag(SALT311.StrType s0) := s0;
EXPORT InValid_primary_exec_flag(SALT311.StrType s) := 0;
EXPORT InValidMessage_primary_exec_flag(UNSIGNED1 wh) := '';
 
EXPORT Make_exec_type(SALT311.StrType s0) := s0;
EXPORT InValid_exec_type(SALT311.StrType s) := 0;
EXPORT InValidMessage_exec_type(UNSIGNED1 wh) := '';
 
EXPORT Make_executive_department(SALT311.StrType s0) := s0;
EXPORT InValid_executive_department(SALT311.StrType s) := 0;
EXPORT InValidMessage_executive_department(UNSIGNED1 wh) := '';
 
EXPORT Make_executive_level(SALT311.StrType s0) := s0;
EXPORT InValid_executive_level(SALT311.StrType s) := 0;
EXPORT InValidMessage_executive_level(UNSIGNED1 wh) := '';
 
EXPORT Make_phy_addr_standardized(SALT311.StrType s0) := s0;
EXPORT InValid_phy_addr_standardized(SALT311.StrType s) := 0;
EXPORT InValidMessage_phy_addr_standardized(UNSIGNED1 wh) := '';
 
EXPORT Make_phy_addr_city(SALT311.StrType s0) := s0;
EXPORT InValid_phy_addr_city(SALT311.StrType s) := 0;
EXPORT InValidMessage_phy_addr_city(UNSIGNED1 wh) := '';
 
EXPORT Make_phy_addr_state(SALT311.StrType s0) := s0;
EXPORT InValid_phy_addr_state(SALT311.StrType s) := 0;
EXPORT InValidMessage_phy_addr_state(UNSIGNED1 wh) := '';
 
EXPORT Make_phy_addr_zip(SALT311.StrType s0) := s0;
EXPORT InValid_phy_addr_zip(SALT311.StrType s) := 0;
EXPORT InValidMessage_phy_addr_zip(UNSIGNED1 wh) := '';
 
EXPORT Make_phy_addr_zip4(SALT311.StrType s0) := s0;
EXPORT InValid_phy_addr_zip4(SALT311.StrType s) := 0;
EXPORT InValidMessage_phy_addr_zip4(UNSIGNED1 wh) := '';
 
EXPORT Make_phy_addr_carrierroute(SALT311.StrType s0) := s0;
EXPORT InValid_phy_addr_carrierroute(SALT311.StrType s) := 0;
EXPORT InValidMessage_phy_addr_carrierroute(UNSIGNED1 wh) := '';
 
EXPORT Make_phy_addr_deliverypt(SALT311.StrType s0) := s0;
EXPORT InValid_phy_addr_deliverypt(SALT311.StrType s) := 0;
EXPORT InValidMessage_phy_addr_deliverypt(UNSIGNED1 wh) := '';
 
EXPORT Make_phy_addr_deliveryptchkdig(SALT311.StrType s0) := s0;
EXPORT InValid_phy_addr_deliveryptchkdig(SALT311.StrType s) := 0;
EXPORT InValidMessage_phy_addr_deliveryptchkdig(UNSIGNED1 wh) := '';
 
EXPORT Make_mail_addr_standardized(SALT311.StrType s0) := s0;
EXPORT InValid_mail_addr_standardized(SALT311.StrType s) := 0;
EXPORT InValidMessage_mail_addr_standardized(UNSIGNED1 wh) := '';
 
EXPORT Make_mail_addr_city(SALT311.StrType s0) := s0;
EXPORT InValid_mail_addr_city(SALT311.StrType s) := 0;
EXPORT InValidMessage_mail_addr_city(UNSIGNED1 wh) := '';
 
EXPORT Make_mail_addr_state(SALT311.StrType s0) := s0;
EXPORT InValid_mail_addr_state(SALT311.StrType s) := 0;
EXPORT InValidMessage_mail_addr_state(UNSIGNED1 wh) := '';
 
EXPORT Make_mail_addr_zip(SALT311.StrType s0) := s0;
EXPORT InValid_mail_addr_zip(SALT311.StrType s) := 0;
EXPORT InValidMessage_mail_addr_zip(UNSIGNED1 wh) := '';
 
EXPORT Make_mail_addr_zip4(SALT311.StrType s0) := s0;
EXPORT InValid_mail_addr_zip4(SALT311.StrType s) := 0;
EXPORT InValidMessage_mail_addr_zip4(UNSIGNED1 wh) := '';
 
EXPORT Make_mail_addr_carrierroute(SALT311.StrType s0) := s0;
EXPORT InValid_mail_addr_carrierroute(SALT311.StrType s) := 0;
EXPORT InValidMessage_mail_addr_carrierroute(UNSIGNED1 wh) := '';
 
EXPORT Make_mail_addr_deliverypt(SALT311.StrType s0) := s0;
EXPORT InValid_mail_addr_deliverypt(SALT311.StrType s) := 0;
EXPORT InValidMessage_mail_addr_deliverypt(UNSIGNED1 wh) := '';
 
EXPORT Make_mail_addr_deliveryptchkdig(SALT311.StrType s0) := s0;
EXPORT InValid_mail_addr_deliveryptchkdig(SALT311.StrType s) := 0;
EXPORT InValidMessage_mail_addr_deliveryptchkdig(UNSIGNED1 wh) := '';
 
EXPORT Make_mail_score(SALT311.StrType s0) := s0;
EXPORT InValid_mail_score(SALT311.StrType s) := 0;
EXPORT InValidMessage_mail_score(UNSIGNED1 wh) := '';
 
EXPORT Make_mail_score_desc(SALT311.StrType s0) := s0;
EXPORT InValid_mail_score_desc(SALT311.StrType s) := 0;
EXPORT InValidMessage_mail_score_desc(UNSIGNED1 wh) := '';
 
EXPORT Make_phone(SALT311.StrType s0) := s0;
EXPORT InValid_phone(SALT311.StrType s) := 0;
EXPORT InValidMessage_phone(UNSIGNED1 wh) := '';
 
EXPORT Make_area_code(SALT311.StrType s0) := s0;
EXPORT InValid_area_code(SALT311.StrType s) := 0;
EXPORT InValidMessage_area_code(UNSIGNED1 wh) := '';
 
EXPORT Make_fax(SALT311.StrType s0) := s0;
EXPORT InValid_fax(SALT311.StrType s) := 0;
EXPORT InValidMessage_fax(UNSIGNED1 wh) := '';
 
EXPORT Make_email(SALT311.StrType s0) := s0;
EXPORT InValid_email(SALT311.StrType s) := 0;
EXPORT InValidMessage_email(UNSIGNED1 wh) := '';
 
EXPORT Make_email_available_indicator(SALT311.StrType s0) := s0;
EXPORT InValid_email_available_indicator(SALT311.StrType s) := 0;
EXPORT InValidMessage_email_available_indicator(UNSIGNED1 wh) := '';
 
EXPORT Make_url(SALT311.StrType s0) := s0;
EXPORT InValid_url(SALT311.StrType s) := 0;
EXPORT InValidMessage_url(UNSIGNED1 wh) := '';
 
EXPORT Make_url_facebook(SALT311.StrType s0) := s0;
EXPORT InValid_url_facebook(SALT311.StrType s) := 0;
EXPORT InValidMessage_url_facebook(UNSIGNED1 wh) := '';
 
EXPORT Make_url_googleplus(SALT311.StrType s0) := s0;
EXPORT InValid_url_googleplus(SALT311.StrType s) := 0;
EXPORT InValidMessage_url_googleplus(UNSIGNED1 wh) := '';
 
EXPORT Make_url_instagram(SALT311.StrType s0) := s0;
EXPORT InValid_url_instagram(SALT311.StrType s) := 0;
EXPORT InValidMessage_url_instagram(UNSIGNED1 wh) := '';
 
EXPORT Make_url_linkedin(SALT311.StrType s0) := s0;
EXPORT InValid_url_linkedin(SALT311.StrType s) := 0;
EXPORT InValidMessage_url_linkedin(UNSIGNED1 wh) := '';
 
EXPORT Make_url_twitter(SALT311.StrType s0) := s0;
EXPORT InValid_url_twitter(SALT311.StrType s) := 0;
EXPORT InValidMessage_url_twitter(UNSIGNED1 wh) := '';
 
EXPORT Make_url_youtube(SALT311.StrType s0) := s0;
EXPORT InValid_url_youtube(SALT311.StrType s) := 0;
EXPORT InValidMessage_url_youtube(UNSIGNED1 wh) := '';
 
EXPORT Make_business_status_code(SALT311.StrType s0) := s0;
EXPORT InValid_business_status_code(SALT311.StrType s) := 0;
EXPORT InValidMessage_business_status_code(UNSIGNED1 wh) := '';
 
EXPORT Make_business_status_desc(SALT311.StrType s0) := s0;
EXPORT InValid_business_status_desc(SALT311.StrType s) := 0;
EXPORT InValidMessage_business_status_desc(UNSIGNED1 wh) := '';
 
EXPORT Make_franchise_flag(SALT311.StrType s0) := s0;
EXPORT InValid_franchise_flag(SALT311.StrType s) := 0;
EXPORT InValidMessage_franchise_flag(UNSIGNED1 wh) := '';
 
EXPORT Make_franchise_type(SALT311.StrType s0) := s0;
EXPORT InValid_franchise_type(SALT311.StrType s) := 0;
EXPORT InValidMessage_franchise_type(UNSIGNED1 wh) := '';
 
EXPORT Make_franchise_desc(SALT311.StrType s0) := s0;
EXPORT InValid_franchise_desc(SALT311.StrType s) := 0;
EXPORT InValidMessage_franchise_desc(UNSIGNED1 wh) := '';
 
EXPORT Make_ticker_symbol(SALT311.StrType s0) := s0;
EXPORT InValid_ticker_symbol(SALT311.StrType s) := 0;
EXPORT InValidMessage_ticker_symbol(UNSIGNED1 wh) := '';
 
EXPORT Make_stock_exchange(SALT311.StrType s0) := s0;
EXPORT InValid_stock_exchange(SALT311.StrType s) := 0;
EXPORT InValidMessage_stock_exchange(UNSIGNED1 wh) := '';
 
EXPORT Make_fortune_1000_flag(SALT311.StrType s0) := s0;
EXPORT InValid_fortune_1000_flag(SALT311.StrType s) := 0;
EXPORT InValidMessage_fortune_1000_flag(UNSIGNED1 wh) := '';
 
EXPORT Make_fortune_1000_rank(SALT311.StrType s0) := s0;
EXPORT InValid_fortune_1000_rank(SALT311.StrType s) := 0;
EXPORT InValidMessage_fortune_1000_rank(UNSIGNED1 wh) := '';
 
EXPORT Make_fortune_1000_branches(SALT311.StrType s0) := s0;
EXPORT InValid_fortune_1000_branches(SALT311.StrType s) := 0;
EXPORT InValidMessage_fortune_1000_branches(UNSIGNED1 wh) := '';
 
EXPORT Make_num_linked_locations(SALT311.StrType s0) := s0;
EXPORT InValid_num_linked_locations(SALT311.StrType s) := 0;
EXPORT InValidMessage_num_linked_locations(UNSIGNED1 wh) := '';
 
EXPORT Make_county_code(SALT311.StrType s0) := s0;
EXPORT InValid_county_code(SALT311.StrType s) := 0;
EXPORT InValidMessage_county_code(UNSIGNED1 wh) := '';
 
EXPORT Make_county_desc(SALT311.StrType s0) := s0;
EXPORT InValid_county_desc(SALT311.StrType s) := 0;
EXPORT InValidMessage_county_desc(UNSIGNED1 wh) := '';
 
EXPORT Make_cbsa_code(SALT311.StrType s0) := s0;
EXPORT InValid_cbsa_code(SALT311.StrType s) := 0;
EXPORT InValidMessage_cbsa_code(UNSIGNED1 wh) := '';
 
EXPORT Make_cbsa_desc(SALT311.StrType s0) := s0;
EXPORT InValid_cbsa_desc(SALT311.StrType s) := 0;
EXPORT InValidMessage_cbsa_desc(UNSIGNED1 wh) := '';
 
EXPORT Make_geo_match_level(SALT311.StrType s0) := s0;
EXPORT InValid_geo_match_level(SALT311.StrType s) := 0;
EXPORT InValidMessage_geo_match_level(UNSIGNED1 wh) := '';
 
EXPORT Make_latitude(SALT311.StrType s0) := s0;
EXPORT InValid_latitude(SALT311.StrType s) := 0;
EXPORT InValidMessage_latitude(UNSIGNED1 wh) := '';
 
EXPORT Make_longitude(SALT311.StrType s0) := s0;
EXPORT InValid_longitude(SALT311.StrType s) := 0;
EXPORT InValidMessage_longitude(UNSIGNED1 wh) := '';
 
EXPORT Make_scf(SALT311.StrType s0) := s0;
EXPORT InValid_scf(SALT311.StrType s) := 0;
EXPORT InValidMessage_scf(UNSIGNED1 wh) := '';
 
EXPORT Make_timezone(SALT311.StrType s0) := s0;
EXPORT InValid_timezone(SALT311.StrType s) := 0;
EXPORT InValidMessage_timezone(UNSIGNED1 wh) := '';
 
EXPORT Make_censustract(SALT311.StrType s0) := s0;
EXPORT InValid_censustract(SALT311.StrType s) := 0;
EXPORT InValidMessage_censustract(UNSIGNED1 wh) := '';
 
EXPORT Make_censusblock(SALT311.StrType s0) := s0;
EXPORT InValid_censusblock(SALT311.StrType s) := 0;
EXPORT InValidMessage_censusblock(UNSIGNED1 wh) := '';
 
EXPORT Make_city_population_code(SALT311.StrType s0) := s0;
EXPORT InValid_city_population_code(SALT311.StrType s) := 0;
EXPORT InValidMessage_city_population_code(UNSIGNED1 wh) := '';
 
EXPORT Make_city_population_descr(SALT311.StrType s0) := s0;
EXPORT InValid_city_population_descr(SALT311.StrType s) := 0;
EXPORT InValidMessage_city_population_descr(UNSIGNED1 wh) := '';
 
EXPORT Make_primary_sic(SALT311.StrType s0) := s0;
EXPORT InValid_primary_sic(SALT311.StrType s) := 0;
EXPORT InValidMessage_primary_sic(UNSIGNED1 wh) := '';
 
EXPORT Make_primary_sic_desc(SALT311.StrType s0) := s0;
EXPORT InValid_primary_sic_desc(SALT311.StrType s) := 0;
EXPORT InValidMessage_primary_sic_desc(UNSIGNED1 wh) := '';
 
EXPORT Make_sic02(SALT311.StrType s0) := s0;
EXPORT InValid_sic02(SALT311.StrType s) := 0;
EXPORT InValidMessage_sic02(UNSIGNED1 wh) := '';
 
EXPORT Make_sic02_desc(SALT311.StrType s0) := s0;
EXPORT InValid_sic02_desc(SALT311.StrType s) := 0;
EXPORT InValidMessage_sic02_desc(UNSIGNED1 wh) := '';
 
EXPORT Make_sic03(SALT311.StrType s0) := s0;
EXPORT InValid_sic03(SALT311.StrType s) := 0;
EXPORT InValidMessage_sic03(UNSIGNED1 wh) := '';
 
EXPORT Make_sic03_desc(SALT311.StrType s0) := s0;
EXPORT InValid_sic03_desc(SALT311.StrType s) := 0;
EXPORT InValidMessage_sic03_desc(UNSIGNED1 wh) := '';
 
EXPORT Make_sic04(SALT311.StrType s0) := s0;
EXPORT InValid_sic04(SALT311.StrType s) := 0;
EXPORT InValidMessage_sic04(UNSIGNED1 wh) := '';
 
EXPORT Make_sic04_desc(SALT311.StrType s0) := s0;
EXPORT InValid_sic04_desc(SALT311.StrType s) := 0;
EXPORT InValidMessage_sic04_desc(UNSIGNED1 wh) := '';
 
EXPORT Make_sic05(SALT311.StrType s0) := s0;
EXPORT InValid_sic05(SALT311.StrType s) := 0;
EXPORT InValidMessage_sic05(UNSIGNED1 wh) := '';
 
EXPORT Make_sic05_desc(SALT311.StrType s0) := s0;
EXPORT InValid_sic05_desc(SALT311.StrType s) := 0;
EXPORT InValidMessage_sic05_desc(UNSIGNED1 wh) := '';
 
EXPORT Make_sic06(SALT311.StrType s0) := s0;
EXPORT InValid_sic06(SALT311.StrType s) := 0;
EXPORT InValidMessage_sic06(UNSIGNED1 wh) := '';
 
EXPORT Make_sic06_desc(SALT311.StrType s0) := s0;
EXPORT InValid_sic06_desc(SALT311.StrType s) := 0;
EXPORT InValidMessage_sic06_desc(UNSIGNED1 wh) := '';
 
EXPORT Make_primarysic2(SALT311.StrType s0) := s0;
EXPORT InValid_primarysic2(SALT311.StrType s) := 0;
EXPORT InValidMessage_primarysic2(UNSIGNED1 wh) := '';
 
EXPORT Make_primary_2_digit_sic_desc(SALT311.StrType s0) := s0;
EXPORT InValid_primary_2_digit_sic_desc(SALT311.StrType s) := 0;
EXPORT InValidMessage_primary_2_digit_sic_desc(UNSIGNED1 wh) := '';
 
EXPORT Make_primarysic4(SALT311.StrType s0) := s0;
EXPORT InValid_primarysic4(SALT311.StrType s) := 0;
EXPORT InValidMessage_primarysic4(UNSIGNED1 wh) := '';
 
EXPORT Make_primary_4_digit_sic_desc(SALT311.StrType s0) := s0;
EXPORT InValid_primary_4_digit_sic_desc(SALT311.StrType s) := 0;
EXPORT InValidMessage_primary_4_digit_sic_desc(UNSIGNED1 wh) := '';
 
EXPORT Make_naics01(SALT311.StrType s0) := s0;
EXPORT InValid_naics01(SALT311.StrType s) := 0;
EXPORT InValidMessage_naics01(UNSIGNED1 wh) := '';
 
EXPORT Make_naics01_desc(SALT311.StrType s0) := s0;
EXPORT InValid_naics01_desc(SALT311.StrType s) := 0;
EXPORT InValidMessage_naics01_desc(UNSIGNED1 wh) := '';
 
EXPORT Make_naics02(SALT311.StrType s0) := s0;
EXPORT InValid_naics02(SALT311.StrType s) := 0;
EXPORT InValidMessage_naics02(UNSIGNED1 wh) := '';
 
EXPORT Make_naics02_desc(SALT311.StrType s0) := s0;
EXPORT InValid_naics02_desc(SALT311.StrType s) := 0;
EXPORT InValidMessage_naics02_desc(UNSIGNED1 wh) := '';
 
EXPORT Make_naics03(SALT311.StrType s0) := s0;
EXPORT InValid_naics03(SALT311.StrType s) := 0;
EXPORT InValidMessage_naics03(UNSIGNED1 wh) := '';
 
EXPORT Make_naics03_desc(SALT311.StrType s0) := s0;
EXPORT InValid_naics03_desc(SALT311.StrType s) := 0;
EXPORT InValidMessage_naics03_desc(UNSIGNED1 wh) := '';
 
EXPORT Make_naics04(SALT311.StrType s0) := s0;
EXPORT InValid_naics04(SALT311.StrType s) := 0;
EXPORT InValidMessage_naics04(UNSIGNED1 wh) := '';
 
EXPORT Make_naics04_desc(SALT311.StrType s0) := s0;
EXPORT InValid_naics04_desc(SALT311.StrType s) := 0;
EXPORT InValidMessage_naics04_desc(UNSIGNED1 wh) := '';
 
EXPORT Make_naics05(SALT311.StrType s0) := s0;
EXPORT InValid_naics05(SALT311.StrType s) := 0;
EXPORT InValidMessage_naics05(UNSIGNED1 wh) := '';
 
EXPORT Make_naics05_desc(SALT311.StrType s0) := s0;
EXPORT InValid_naics05_desc(SALT311.StrType s) := 0;
EXPORT InValidMessage_naics05_desc(UNSIGNED1 wh) := '';
 
EXPORT Make_naics06(SALT311.StrType s0) := s0;
EXPORT InValid_naics06(SALT311.StrType s) := 0;
EXPORT InValidMessage_naics06(UNSIGNED1 wh) := '';
 
EXPORT Make_naics06_desc(SALT311.StrType s0) := s0;
EXPORT InValid_naics06_desc(SALT311.StrType s) := 0;
EXPORT InValidMessage_naics06_desc(UNSIGNED1 wh) := '';
 
EXPORT Make_location_employees_total(SALT311.StrType s0) := s0;
EXPORT InValid_location_employees_total(SALT311.StrType s) := 0;
EXPORT InValidMessage_location_employees_total(UNSIGNED1 wh) := '';
 
EXPORT Make_location_employee_code(SALT311.StrType s0) := s0;
EXPORT InValid_location_employee_code(SALT311.StrType s) := 0;
EXPORT InValidMessage_location_employee_code(UNSIGNED1 wh) := '';
 
EXPORT Make_location_employee_desc(SALT311.StrType s0) := s0;
EXPORT InValid_location_employee_desc(SALT311.StrType s) := 0;
EXPORT InValidMessage_location_employee_desc(UNSIGNED1 wh) := '';
 
EXPORT Make_location_sales_total(SALT311.StrType s0) := s0;
EXPORT InValid_location_sales_total(SALT311.StrType s) := 0;
EXPORT InValidMessage_location_sales_total(UNSIGNED1 wh) := '';
 
EXPORT Make_location_sales_code(SALT311.StrType s0) := s0;
EXPORT InValid_location_sales_code(SALT311.StrType s) := 0;
EXPORT InValidMessage_location_sales_code(UNSIGNED1 wh) := '';
 
EXPORT Make_location_sales_desc(SALT311.StrType s0) := s0;
EXPORT InValid_location_sales_desc(SALT311.StrType s) := 0;
EXPORT InValidMessage_location_sales_desc(UNSIGNED1 wh) := '';
 
EXPORT Make_corporate_employee_total(SALT311.StrType s0) := s0;
EXPORT InValid_corporate_employee_total(SALT311.StrType s) := 0;
EXPORT InValidMessage_corporate_employee_total(UNSIGNED1 wh) := '';
 
EXPORT Make_corporate_employee_code(SALT311.StrType s0) := s0;
EXPORT InValid_corporate_employee_code(SALT311.StrType s) := 0;
EXPORT InValidMessage_corporate_employee_code(UNSIGNED1 wh) := '';
 
EXPORT Make_corporate_employee_desc(SALT311.StrType s0) := s0;
EXPORT InValid_corporate_employee_desc(SALT311.StrType s) := 0;
EXPORT InValidMessage_corporate_employee_desc(UNSIGNED1 wh) := '';
 
EXPORT Make_year_established(SALT311.StrType s0) := s0;
EXPORT InValid_year_established(SALT311.StrType s) := 0;
EXPORT InValidMessage_year_established(UNSIGNED1 wh) := '';
 
EXPORT Make_years_in_business_range(SALT311.StrType s0) := s0;
EXPORT InValid_years_in_business_range(SALT311.StrType s) := 0;
EXPORT InValidMessage_years_in_business_range(UNSIGNED1 wh) := '';
 
EXPORT Make_female_owned(SALT311.StrType s0) := s0;
EXPORT InValid_female_owned(SALT311.StrType s) := 0;
EXPORT InValidMessage_female_owned(UNSIGNED1 wh) := '';
 
EXPORT Make_minority_owned_flag(SALT311.StrType s0) := s0;
EXPORT InValid_minority_owned_flag(SALT311.StrType s) := 0;
EXPORT InValidMessage_minority_owned_flag(UNSIGNED1 wh) := '';
 
EXPORT Make_minority_type(SALT311.StrType s0) := s0;
EXPORT InValid_minority_type(SALT311.StrType s) := 0;
EXPORT InValidMessage_minority_type(UNSIGNED1 wh) := '';
 
EXPORT Make_home_based_indicator(SALT311.StrType s0) := s0;
EXPORT InValid_home_based_indicator(SALT311.StrType s) := 0;
EXPORT InValidMessage_home_based_indicator(UNSIGNED1 wh) := '';
 
EXPORT Make_small_business_indicator(SALT311.StrType s0) := s0;
EXPORT InValid_small_business_indicator(SALT311.StrType s) := 0;
EXPORT InValidMessage_small_business_indicator(UNSIGNED1 wh) := '';
 
EXPORT Make_import_export(SALT311.StrType s0) := s0;
EXPORT InValid_import_export(SALT311.StrType s) := 0;
EXPORT InValidMessage_import_export(UNSIGNED1 wh) := '';
 
EXPORT Make_manufacturing_location(SALT311.StrType s0) := s0;
EXPORT InValid_manufacturing_location(SALT311.StrType s) := 0;
EXPORT InValidMessage_manufacturing_location(UNSIGNED1 wh) := '';
 
EXPORT Make_public_indicator(SALT311.StrType s0) := s0;
EXPORT InValid_public_indicator(SALT311.StrType s) := 0;
EXPORT InValidMessage_public_indicator(UNSIGNED1 wh) := '';
 
EXPORT Make_ein(SALT311.StrType s0) := s0;
EXPORT InValid_ein(SALT311.StrType s) := 0;
EXPORT InValidMessage_ein(UNSIGNED1 wh) := '';
 
EXPORT Make_non_profit_org(SALT311.StrType s0) := s0;
EXPORT InValid_non_profit_org(SALT311.StrType s) := 0;
EXPORT InValidMessage_non_profit_org(UNSIGNED1 wh) := '';
 
EXPORT Make_square_footage(SALT311.StrType s0) := s0;
EXPORT InValid_square_footage(SALT311.StrType s) := 0;
EXPORT InValidMessage_square_footage(UNSIGNED1 wh) := '';
 
EXPORT Make_square_footage_code(SALT311.StrType s0) := s0;
EXPORT InValid_square_footage_code(SALT311.StrType s) := 0;
EXPORT InValidMessage_square_footage_code(UNSIGNED1 wh) := '';
 
EXPORT Make_square_footage_desc(SALT311.StrType s0) := s0;
EXPORT InValid_square_footage_desc(SALT311.StrType s) := 0;
EXPORT InValidMessage_square_footage_desc(UNSIGNED1 wh) := '';
 
EXPORT Make_creditscore(SALT311.StrType s0) := s0;
EXPORT InValid_creditscore(SALT311.StrType s) := 0;
EXPORT InValidMessage_creditscore(UNSIGNED1 wh) := '';
 
EXPORT Make_creditcode(SALT311.StrType s0) := s0;
EXPORT InValid_creditcode(SALT311.StrType s) := 0;
EXPORT InValidMessage_creditcode(UNSIGNED1 wh) := '';
 
EXPORT Make_credit_desc(SALT311.StrType s0) := s0;
EXPORT InValid_credit_desc(SALT311.StrType s) := 0;
EXPORT InValidMessage_credit_desc(UNSIGNED1 wh) := '';
 
EXPORT Make_credit_capacity(SALT311.StrType s0) := s0;
EXPORT InValid_credit_capacity(SALT311.StrType s) := 0;
EXPORT InValidMessage_credit_capacity(UNSIGNED1 wh) := '';
 
EXPORT Make_credit_capacity_code(SALT311.StrType s0) := s0;
EXPORT InValid_credit_capacity_code(SALT311.StrType s) := 0;
EXPORT InValidMessage_credit_capacity_code(UNSIGNED1 wh) := '';
 
EXPORT Make_credit_capacity_desc(SALT311.StrType s0) := s0;
EXPORT InValid_credit_capacity_desc(SALT311.StrType s) := 0;
EXPORT InValidMessage_credit_capacity_desc(UNSIGNED1 wh) := '';
 
EXPORT Make_advertising_expenses_code(SALT311.StrType s0) := s0;
EXPORT InValid_advertising_expenses_code(SALT311.StrType s) := 0;
EXPORT InValidMessage_advertising_expenses_code(UNSIGNED1 wh) := '';
 
EXPORT Make_expense_advertising_desc(SALT311.StrType s0) := s0;
EXPORT InValid_expense_advertising_desc(SALT311.StrType s) := 0;
EXPORT InValidMessage_expense_advertising_desc(UNSIGNED1 wh) := '';
 
EXPORT Make_technology_expenses_code(SALT311.StrType s0) := s0;
EXPORT InValid_technology_expenses_code(SALT311.StrType s) := 0;
EXPORT InValidMessage_technology_expenses_code(UNSIGNED1 wh) := '';
 
EXPORT Make_expense_technology_desc(SALT311.StrType s0) := s0;
EXPORT InValid_expense_technology_desc(SALT311.StrType s) := 0;
EXPORT InValidMessage_expense_technology_desc(UNSIGNED1 wh) := '';
 
EXPORT Make_office_equip_expenses_code(SALT311.StrType s0) := s0;
EXPORT InValid_office_equip_expenses_code(SALT311.StrType s) := 0;
EXPORT InValidMessage_office_equip_expenses_code(UNSIGNED1 wh) := '';
 
EXPORT Make_expense_office_equip_desc(SALT311.StrType s0) := s0;
EXPORT InValid_expense_office_equip_desc(SALT311.StrType s) := 0;
EXPORT InValidMessage_expense_office_equip_desc(UNSIGNED1 wh) := '';
 
EXPORT Make_rent_expenses_code(SALT311.StrType s0) := s0;
EXPORT InValid_rent_expenses_code(SALT311.StrType s) := 0;
EXPORT InValidMessage_rent_expenses_code(UNSIGNED1 wh) := '';
 
EXPORT Make_expense_rent_desc(SALT311.StrType s0) := s0;
EXPORT InValid_expense_rent_desc(SALT311.StrType s) := 0;
EXPORT InValidMessage_expense_rent_desc(UNSIGNED1 wh) := '';
 
EXPORT Make_telecom_expenses_code(SALT311.StrType s0) := s0;
EXPORT InValid_telecom_expenses_code(SALT311.StrType s) := 0;
EXPORT InValidMessage_telecom_expenses_code(UNSIGNED1 wh) := '';
 
EXPORT Make_expense_telecom_desc(SALT311.StrType s0) := s0;
EXPORT InValid_expense_telecom_desc(SALT311.StrType s) := 0;
EXPORT InValidMessage_expense_telecom_desc(UNSIGNED1 wh) := '';
 
EXPORT Make_accounting_expenses_code(SALT311.StrType s0) := s0;
EXPORT InValid_accounting_expenses_code(SALT311.StrType s) := 0;
EXPORT InValidMessage_accounting_expenses_code(UNSIGNED1 wh) := '';
 
EXPORT Make_expense_accounting_desc(SALT311.StrType s0) := s0;
EXPORT InValid_expense_accounting_desc(SALT311.StrType s) := 0;
EXPORT InValidMessage_expense_accounting_desc(UNSIGNED1 wh) := '';
 
EXPORT Make_bus_insurance_expense_code(SALT311.StrType s0) := s0;
EXPORT InValid_bus_insurance_expense_code(SALT311.StrType s) := 0;
EXPORT InValidMessage_bus_insurance_expense_code(UNSIGNED1 wh) := '';
 
EXPORT Make_expense_bus_insurance_desc(SALT311.StrType s0) := s0;
EXPORT InValid_expense_bus_insurance_desc(SALT311.StrType s) := 0;
EXPORT InValidMessage_expense_bus_insurance_desc(UNSIGNED1 wh) := '';
 
EXPORT Make_legal_expenses_code(SALT311.StrType s0) := s0;
EXPORT InValid_legal_expenses_code(SALT311.StrType s) := 0;
EXPORT InValidMessage_legal_expenses_code(UNSIGNED1 wh) := '';
 
EXPORT Make_expense_legal_desc(SALT311.StrType s0) := s0;
EXPORT InValid_expense_legal_desc(SALT311.StrType s) := 0;
EXPORT InValidMessage_expense_legal_desc(UNSIGNED1 wh) := '';
 
EXPORT Make_utilities_expenses_code(SALT311.StrType s0) := s0;
EXPORT InValid_utilities_expenses_code(SALT311.StrType s) := 0;
EXPORT InValidMessage_utilities_expenses_code(UNSIGNED1 wh) := '';
 
EXPORT Make_expense_utilities_desc(SALT311.StrType s0) := s0;
EXPORT InValid_expense_utilities_desc(SALT311.StrType s) := 0;
EXPORT InValidMessage_expense_utilities_desc(UNSIGNED1 wh) := '';
 
EXPORT Make_number_of_pcs_code(SALT311.StrType s0) := s0;
EXPORT InValid_number_of_pcs_code(SALT311.StrType s) := 0;
EXPORT InValidMessage_number_of_pcs_code(UNSIGNED1 wh) := '';
 
EXPORT Make_number_of_pcs_desc(SALT311.StrType s0) := s0;
EXPORT InValid_number_of_pcs_desc(SALT311.StrType s) := 0;
EXPORT InValidMessage_number_of_pcs_desc(UNSIGNED1 wh) := '';
 
EXPORT Make_nb_flag(SALT311.StrType s0) := s0;
EXPORT InValid_nb_flag(SALT311.StrType s) := 0;
EXPORT InValidMessage_nb_flag(UNSIGNED1 wh) := '';
 
EXPORT Make_hq_company_name(SALT311.StrType s0) := s0;
EXPORT InValid_hq_company_name(SALT311.StrType s) := 0;
EXPORT InValidMessage_hq_company_name(UNSIGNED1 wh) := '';
 
EXPORT Make_hq_city(SALT311.StrType s0) := s0;
EXPORT InValid_hq_city(SALT311.StrType s) := 0;
EXPORT InValidMessage_hq_city(UNSIGNED1 wh) := '';
 
EXPORT Make_hq_state(SALT311.StrType s0) := s0;
EXPORT InValid_hq_state(SALT311.StrType s) := 0;
EXPORT InValidMessage_hq_state(UNSIGNED1 wh) := '';
 
EXPORT Make_subhq_parent_name(SALT311.StrType s0) := s0;
EXPORT InValid_subhq_parent_name(SALT311.StrType s) := 0;
EXPORT InValidMessage_subhq_parent_name(UNSIGNED1 wh) := '';
 
EXPORT Make_subhq_parent_city(SALT311.StrType s0) := s0;
EXPORT InValid_subhq_parent_city(SALT311.StrType s) := 0;
EXPORT InValidMessage_subhq_parent_city(UNSIGNED1 wh) := '';
 
EXPORT Make_subhq_parent_state(SALT311.StrType s0) := s0;
EXPORT InValid_subhq_parent_state(SALT311.StrType s) := 0;
EXPORT InValidMessage_subhq_parent_state(UNSIGNED1 wh) := '';
 
EXPORT Make_domestic_foreign_owner_flag(SALT311.StrType s0) := s0;
EXPORT InValid_domestic_foreign_owner_flag(SALT311.StrType s) := 0;
EXPORT InValidMessage_domestic_foreign_owner_flag(UNSIGNED1 wh) := '';
 
EXPORT Make_foreign_parent_company_name(SALT311.StrType s0) := s0;
EXPORT InValid_foreign_parent_company_name(SALT311.StrType s) := 0;
EXPORT InValidMessage_foreign_parent_company_name(UNSIGNED1 wh) := '';
 
EXPORT Make_foreign_parent_city(SALT311.StrType s0) := s0;
EXPORT InValid_foreign_parent_city(SALT311.StrType s) := 0;
EXPORT InValidMessage_foreign_parent_city(UNSIGNED1 wh) := '';
 
EXPORT Make_foreign_parent_country(SALT311.StrType s0) := s0;
EXPORT InValid_foreign_parent_country(SALT311.StrType s) := 0;
EXPORT InValidMessage_foreign_parent_country(UNSIGNED1 wh) := '';
 
EXPORT Make_db_cons_matchkey(SALT311.StrType s0) := s0;
EXPORT InValid_db_cons_matchkey(SALT311.StrType s) := 0;
EXPORT InValidMessage_db_cons_matchkey(UNSIGNED1 wh) := '';
 
EXPORT Make_databaseusa_individual_id(SALT311.StrType s0) := s0;
EXPORT InValid_databaseusa_individual_id(SALT311.StrType s) := 0;
EXPORT InValidMessage_databaseusa_individual_id(UNSIGNED1 wh) := '';
 
EXPORT Make_db_cons_full_name(SALT311.StrType s0) := s0;
EXPORT InValid_db_cons_full_name(SALT311.StrType s) := 0;
EXPORT InValidMessage_db_cons_full_name(UNSIGNED1 wh) := '';
 
EXPORT Make_db_cons_full_name_prefix(SALT311.StrType s0) := s0;
EXPORT InValid_db_cons_full_name_prefix(SALT311.StrType s) := 0;
EXPORT InValidMessage_db_cons_full_name_prefix(UNSIGNED1 wh) := '';
 
EXPORT Make_db_cons_first_name(SALT311.StrType s0) := s0;
EXPORT InValid_db_cons_first_name(SALT311.StrType s) := 0;
EXPORT InValidMessage_db_cons_first_name(UNSIGNED1 wh) := '';
 
EXPORT Make_db_cons_middle_initial(SALT311.StrType s0) := s0;
EXPORT InValid_db_cons_middle_initial(SALT311.StrType s) := 0;
EXPORT InValidMessage_db_cons_middle_initial(UNSIGNED1 wh) := '';
 
EXPORT Make_db_cons_last_name(SALT311.StrType s0) := s0;
EXPORT InValid_db_cons_last_name(SALT311.StrType s) := 0;
EXPORT InValidMessage_db_cons_last_name(UNSIGNED1 wh) := '';
 
EXPORT Make_db_cons_email(SALT311.StrType s0) := s0;
EXPORT InValid_db_cons_email(SALT311.StrType s) := 0;
EXPORT InValidMessage_db_cons_email(UNSIGNED1 wh) := '';
 
EXPORT Make_db_cons_gender(SALT311.StrType s0) := s0;
EXPORT InValid_db_cons_gender(SALT311.StrType s) := 0;
EXPORT InValidMessage_db_cons_gender(UNSIGNED1 wh) := '';
 
EXPORT Make_db_cons_date_of_birth_year(SALT311.StrType s0) := s0;
EXPORT InValid_db_cons_date_of_birth_year(SALT311.StrType s) := 0;
EXPORT InValidMessage_db_cons_date_of_birth_year(UNSIGNED1 wh) := '';
 
EXPORT Make_db_cons_date_of_birth_month(SALT311.StrType s0) := s0;
EXPORT InValid_db_cons_date_of_birth_month(SALT311.StrType s) := 0;
EXPORT InValidMessage_db_cons_date_of_birth_month(UNSIGNED1 wh) := '';
 
EXPORT Make_db_cons_age(SALT311.StrType s0) := s0;
EXPORT InValid_db_cons_age(SALT311.StrType s) := 0;
EXPORT InValidMessage_db_cons_age(UNSIGNED1 wh) := '';
 
EXPORT Make_db_cons_age_code_desc(SALT311.StrType s0) := s0;
EXPORT InValid_db_cons_age_code_desc(SALT311.StrType s) := 0;
EXPORT InValidMessage_db_cons_age_code_desc(UNSIGNED1 wh) := '';
 
EXPORT Make_db_cons_age_in_two_year_hh(SALT311.StrType s0) := s0;
EXPORT InValid_db_cons_age_in_two_year_hh(SALT311.StrType s) := 0;
EXPORT InValidMessage_db_cons_age_in_two_year_hh(UNSIGNED1 wh) := '';
 
EXPORT Make_db_cons_ethnic_code(SALT311.StrType s0) := s0;
EXPORT InValid_db_cons_ethnic_code(SALT311.StrType s) := 0;
EXPORT InValidMessage_db_cons_ethnic_code(UNSIGNED1 wh) := '';
 
EXPORT Make_db_cons_religious_affil(SALT311.StrType s0) := s0;
EXPORT InValid_db_cons_religious_affil(SALT311.StrType s) := 0;
EXPORT InValidMessage_db_cons_religious_affil(UNSIGNED1 wh) := '';
 
EXPORT Make_db_cons_language_pref(SALT311.StrType s0) := s0;
EXPORT InValid_db_cons_language_pref(SALT311.StrType s) := 0;
EXPORT InValidMessage_db_cons_language_pref(UNSIGNED1 wh) := '';
 
EXPORT Make_db_cons_phy_addr_std(SALT311.StrType s0) := s0;
EXPORT InValid_db_cons_phy_addr_std(SALT311.StrType s) := 0;
EXPORT InValidMessage_db_cons_phy_addr_std(UNSIGNED1 wh) := '';
 
EXPORT Make_db_cons_phy_addr_city(SALT311.StrType s0) := s0;
EXPORT InValid_db_cons_phy_addr_city(SALT311.StrType s) := 0;
EXPORT InValidMessage_db_cons_phy_addr_city(UNSIGNED1 wh) := '';
 
EXPORT Make_db_cons_phy_addr_state(SALT311.StrType s0) := s0;
EXPORT InValid_db_cons_phy_addr_state(SALT311.StrType s) := 0;
EXPORT InValidMessage_db_cons_phy_addr_state(UNSIGNED1 wh) := '';
 
EXPORT Make_db_cons_phy_addr_zip(SALT311.StrType s0) := s0;
EXPORT InValid_db_cons_phy_addr_zip(SALT311.StrType s) := 0;
EXPORT InValidMessage_db_cons_phy_addr_zip(UNSIGNED1 wh) := '';
 
EXPORT Make_db_cons_phy_addr_zip4(SALT311.StrType s0) := s0;
EXPORT InValid_db_cons_phy_addr_zip4(SALT311.StrType s) := 0;
EXPORT InValidMessage_db_cons_phy_addr_zip4(UNSIGNED1 wh) := '';
 
EXPORT Make_db_cons_phy_addr_carrierroute(SALT311.StrType s0) := s0;
EXPORT InValid_db_cons_phy_addr_carrierroute(SALT311.StrType s) := 0;
EXPORT InValidMessage_db_cons_phy_addr_carrierroute(UNSIGNED1 wh) := '';
 
EXPORT Make_db_cons_phy_addr_deliverypt(SALT311.StrType s0) := s0;
EXPORT InValid_db_cons_phy_addr_deliverypt(SALT311.StrType s) := 0;
EXPORT InValidMessage_db_cons_phy_addr_deliverypt(UNSIGNED1 wh) := '';
 
EXPORT Make_db_cons_line_of_travel(SALT311.StrType s0) := s0;
EXPORT InValid_db_cons_line_of_travel(SALT311.StrType s) := 0;
EXPORT InValidMessage_db_cons_line_of_travel(UNSIGNED1 wh) := '';
 
EXPORT Make_db_cons_geocode_results(SALT311.StrType s0) := s0;
EXPORT InValid_db_cons_geocode_results(SALT311.StrType s) := 0;
EXPORT InValidMessage_db_cons_geocode_results(UNSIGNED1 wh) := '';
 
EXPORT Make_db_cons_latitude(SALT311.StrType s0) := s0;
EXPORT InValid_db_cons_latitude(SALT311.StrType s) := 0;
EXPORT InValidMessage_db_cons_latitude(UNSIGNED1 wh) := '';
 
EXPORT Make_db_cons_longitude(SALT311.StrType s0) := s0;
EXPORT InValid_db_cons_longitude(SALT311.StrType s) := 0;
EXPORT InValidMessage_db_cons_longitude(UNSIGNED1 wh) := '';
 
EXPORT Make_db_cons_time_zone_code(SALT311.StrType s0) := s0;
EXPORT InValid_db_cons_time_zone_code(SALT311.StrType s) := 0;
EXPORT InValidMessage_db_cons_time_zone_code(UNSIGNED1 wh) := '';
 
EXPORT Make_db_cons_time_zone_desc(SALT311.StrType s0) := s0;
EXPORT InValid_db_cons_time_zone_desc(SALT311.StrType s) := 0;
EXPORT InValidMessage_db_cons_time_zone_desc(UNSIGNED1 wh) := '';
 
EXPORT Make_db_cons_census_tract(SALT311.StrType s0) := s0;
EXPORT InValid_db_cons_census_tract(SALT311.StrType s) := 0;
EXPORT InValidMessage_db_cons_census_tract(UNSIGNED1 wh) := '';
 
EXPORT Make_db_cons_census_block(SALT311.StrType s0) := s0;
EXPORT InValid_db_cons_census_block(SALT311.StrType s) := 0;
EXPORT InValidMessage_db_cons_census_block(UNSIGNED1 wh) := '';
 
EXPORT Make_db_cons_countyfips(SALT311.StrType s0) := s0;
EXPORT InValid_db_cons_countyfips(SALT311.StrType s) := 0;
EXPORT InValidMessage_db_cons_countyfips(UNSIGNED1 wh) := '';
 
EXPORT Make_db_countyname(SALT311.StrType s0) := s0;
EXPORT InValid_db_countyname(SALT311.StrType s) := 0;
EXPORT InValidMessage_db_countyname(UNSIGNED1 wh) := '';
 
EXPORT Make_db_cons_cbsa_code(SALT311.StrType s0) := s0;
EXPORT InValid_db_cons_cbsa_code(SALT311.StrType s) := 0;
EXPORT InValidMessage_db_cons_cbsa_code(UNSIGNED1 wh) := '';
 
EXPORT Make_db_cons_cbsa_desc(SALT311.StrType s0) := s0;
EXPORT InValid_db_cons_cbsa_desc(SALT311.StrType s) := 0;
EXPORT InValidMessage_db_cons_cbsa_desc(UNSIGNED1 wh) := '';
 
EXPORT Make_db_cons_walk_sequence(SALT311.StrType s0) := s0;
EXPORT InValid_db_cons_walk_sequence(SALT311.StrType s) := 0;
EXPORT InValidMessage_db_cons_walk_sequence(UNSIGNED1 wh) := '';
 
EXPORT Make_db_cons_phone(SALT311.StrType s0) := s0;
EXPORT InValid_db_cons_phone(SALT311.StrType s) := 0;
EXPORT InValidMessage_db_cons_phone(UNSIGNED1 wh) := '';
 
EXPORT Make_db_cons_dnc(SALT311.StrType s0) := s0;
EXPORT InValid_db_cons_dnc(SALT311.StrType s) := 0;
EXPORT InValidMessage_db_cons_dnc(UNSIGNED1 wh) := '';
 
EXPORT Make_db_cons_scrubbed_phoneable(SALT311.StrType s0) := s0;
EXPORT InValid_db_cons_scrubbed_phoneable(SALT311.StrType s) := 0;
EXPORT InValidMessage_db_cons_scrubbed_phoneable(UNSIGNED1 wh) := '';
 
EXPORT Make_db_cons_children_present(SALT311.StrType s0) := s0;
EXPORT InValid_db_cons_children_present(SALT311.StrType s) := 0;
EXPORT InValidMessage_db_cons_children_present(UNSIGNED1 wh) := '';
 
EXPORT Make_db_cons_home_value_code(SALT311.StrType s0) := s0;
EXPORT InValid_db_cons_home_value_code(SALT311.StrType s) := 0;
EXPORT InValidMessage_db_cons_home_value_code(UNSIGNED1 wh) := '';
 
EXPORT Make_db_cons_home_value_desc(SALT311.StrType s0) := s0;
EXPORT InValid_db_cons_home_value_desc(SALT311.StrType s) := 0;
EXPORT InValidMessage_db_cons_home_value_desc(UNSIGNED1 wh) := '';
 
EXPORT Make_db_cons_donor_capacity(SALT311.StrType s0) := s0;
EXPORT InValid_db_cons_donor_capacity(SALT311.StrType s) := 0;
EXPORT InValidMessage_db_cons_donor_capacity(UNSIGNED1 wh) := '';
 
EXPORT Make_db_cons_donor_capacity_code(SALT311.StrType s0) := s0;
EXPORT InValid_db_cons_donor_capacity_code(SALT311.StrType s) := 0;
EXPORT InValidMessage_db_cons_donor_capacity_code(UNSIGNED1 wh) := '';
 
EXPORT Make_db_cons_donor_capacity_desc(SALT311.StrType s0) := s0;
EXPORT InValid_db_cons_donor_capacity_desc(SALT311.StrType s) := 0;
EXPORT InValidMessage_db_cons_donor_capacity_desc(UNSIGNED1 wh) := '';
 
EXPORT Make_db_cons_home_owner_renter(SALT311.StrType s0) := s0;
EXPORT InValid_db_cons_home_owner_renter(SALT311.StrType s) := 0;
EXPORT InValidMessage_db_cons_home_owner_renter(UNSIGNED1 wh) := '';
 
EXPORT Make_db_cons_length_of_res(SALT311.StrType s0) := s0;
EXPORT InValid_db_cons_length_of_res(SALT311.StrType s) := 0;
EXPORT InValidMessage_db_cons_length_of_res(UNSIGNED1 wh) := '';
 
EXPORT Make_db_cons_length_of_res_code(SALT311.StrType s0) := s0;
EXPORT InValid_db_cons_length_of_res_code(SALT311.StrType s) := 0;
EXPORT InValidMessage_db_cons_length_of_res_code(UNSIGNED1 wh) := '';
 
EXPORT Make_db_cons_length_of_res_desc(SALT311.StrType s0) := s0;
EXPORT InValid_db_cons_length_of_res_desc(SALT311.StrType s) := 0;
EXPORT InValidMessage_db_cons_length_of_res_desc(UNSIGNED1 wh) := '';
 
EXPORT Make_db_cons_dwelling_type(SALT311.StrType s0) := s0;
EXPORT InValid_db_cons_dwelling_type(SALT311.StrType s) := 0;
EXPORT InValidMessage_db_cons_dwelling_type(UNSIGNED1 wh) := '';
 
EXPORT Make_db_cons_recent_home_buyer(SALT311.StrType s0) := s0;
EXPORT InValid_db_cons_recent_home_buyer(SALT311.StrType s) := 0;
EXPORT InValidMessage_db_cons_recent_home_buyer(UNSIGNED1 wh) := '';
 
EXPORT Make_db_cons_income_code(SALT311.StrType s0) := s0;
EXPORT InValid_db_cons_income_code(SALT311.StrType s) := 0;
EXPORT InValidMessage_db_cons_income_code(UNSIGNED1 wh) := '';
 
EXPORT Make_db_cons_income_desc(SALT311.StrType s0) := s0;
EXPORT InValid_db_cons_income_desc(SALT311.StrType s) := 0;
EXPORT InValidMessage_db_cons_income_desc(UNSIGNED1 wh) := '';
 
EXPORT Make_db_cons_unsecuredcredcap(SALT311.StrType s0) := s0;
EXPORT InValid_db_cons_unsecuredcredcap(SALT311.StrType s) := 0;
EXPORT InValidMessage_db_cons_unsecuredcredcap(UNSIGNED1 wh) := '';
 
EXPORT Make_db_cons_unsecuredcredcapcode(SALT311.StrType s0) := s0;
EXPORT InValid_db_cons_unsecuredcredcapcode(SALT311.StrType s) := 0;
EXPORT InValidMessage_db_cons_unsecuredcredcapcode(UNSIGNED1 wh) := '';
 
EXPORT Make_db_cons_unsecuredcredcapdesc(SALT311.StrType s0) := s0;
EXPORT InValid_db_cons_unsecuredcredcapdesc(SALT311.StrType s) := 0;
EXPORT InValidMessage_db_cons_unsecuredcredcapdesc(UNSIGNED1 wh) := '';
 
EXPORT Make_db_cons_networthhomeval(SALT311.StrType s0) := s0;
EXPORT InValid_db_cons_networthhomeval(SALT311.StrType s) := 0;
EXPORT InValidMessage_db_cons_networthhomeval(UNSIGNED1 wh) := '';
 
EXPORT Make_db_cons_networthhomevalcode(SALT311.StrType s0) := s0;
EXPORT InValid_db_cons_networthhomevalcode(SALT311.StrType s) := 0;
EXPORT InValidMessage_db_cons_networthhomevalcode(UNSIGNED1 wh) := '';
 
EXPORT Make_db_cons_net_worth_desc(SALT311.StrType s0) := s0;
EXPORT InValid_db_cons_net_worth_desc(SALT311.StrType s) := 0;
EXPORT InValidMessage_db_cons_net_worth_desc(UNSIGNED1 wh) := '';
 
EXPORT Make_db_cons_discretincome(SALT311.StrType s0) := s0;
EXPORT InValid_db_cons_discretincome(SALT311.StrType s) := 0;
EXPORT InValidMessage_db_cons_discretincome(UNSIGNED1 wh) := '';
 
EXPORT Make_db_cons_discretincomecode(SALT311.StrType s0) := s0;
EXPORT InValid_db_cons_discretincomecode(SALT311.StrType s) := 0;
EXPORT InValidMessage_db_cons_discretincomecode(UNSIGNED1 wh) := '';
 
EXPORT Make_db_cons_discretincomedesc(SALT311.StrType s0) := s0;
EXPORT InValid_db_cons_discretincomedesc(SALT311.StrType s) := 0;
EXPORT InValidMessage_db_cons_discretincomedesc(UNSIGNED1 wh) := '';
 
EXPORT Make_db_cons_marital_status(SALT311.StrType s0) := s0;
EXPORT InValid_db_cons_marital_status(SALT311.StrType s) := 0;
EXPORT InValidMessage_db_cons_marital_status(UNSIGNED1 wh) := '';
 
EXPORT Make_db_cons_new_parent(SALT311.StrType s0) := s0;
EXPORT InValid_db_cons_new_parent(SALT311.StrType s) := 0;
EXPORT InValidMessage_db_cons_new_parent(UNSIGNED1 wh) := '';
 
EXPORT Make_db_cons_child_near_hs_grad(SALT311.StrType s0) := s0;
EXPORT InValid_db_cons_child_near_hs_grad(SALT311.StrType s) := 0;
EXPORT InValidMessage_db_cons_child_near_hs_grad(UNSIGNED1 wh) := '';
 
EXPORT Make_db_cons_college_graduate(SALT311.StrType s0) := s0;
EXPORT InValid_db_cons_college_graduate(SALT311.StrType s) := 0;
EXPORT InValidMessage_db_cons_college_graduate(UNSIGNED1 wh) := '';
 
EXPORT Make_db_cons_intend_purchase_veh(SALT311.StrType s0) := s0;
EXPORT InValid_db_cons_intend_purchase_veh(SALT311.StrType s) := 0;
EXPORT InValidMessage_db_cons_intend_purchase_veh(UNSIGNED1 wh) := '';
 
EXPORT Make_db_cons_recent_divorce(SALT311.StrType s0) := s0;
EXPORT InValid_db_cons_recent_divorce(SALT311.StrType s) := 0;
EXPORT InValidMessage_db_cons_recent_divorce(UNSIGNED1 wh) := '';
 
EXPORT Make_db_cons_newlywed(SALT311.StrType s0) := s0;
EXPORT InValid_db_cons_newlywed(SALT311.StrType s) := 0;
EXPORT InValidMessage_db_cons_newlywed(UNSIGNED1 wh) := '';
 
EXPORT Make_db_cons_new_teen_driver(SALT311.StrType s0) := s0;
EXPORT InValid_db_cons_new_teen_driver(SALT311.StrType s) := 0;
EXPORT InValidMessage_db_cons_new_teen_driver(UNSIGNED1 wh) := '';
 
EXPORT Make_db_cons_home_year_built(SALT311.StrType s0) := s0;
EXPORT InValid_db_cons_home_year_built(SALT311.StrType s) := 0;
EXPORT InValidMessage_db_cons_home_year_built(UNSIGNED1 wh) := '';
 
EXPORT Make_db_cons_home_sqft_ranges(SALT311.StrType s0) := s0;
EXPORT InValid_db_cons_home_sqft_ranges(SALT311.StrType s) := 0;
EXPORT InValidMessage_db_cons_home_sqft_ranges(UNSIGNED1 wh) := '';
 
EXPORT Make_db_cons_poli_party_ind(SALT311.StrType s0) := s0;
EXPORT InValid_db_cons_poli_party_ind(SALT311.StrType s) := 0;
EXPORT InValidMessage_db_cons_poli_party_ind(UNSIGNED1 wh) := '';
 
EXPORT Make_db_cons_home_sqft_actual(SALT311.StrType s0) := s0;
EXPORT InValid_db_cons_home_sqft_actual(SALT311.StrType s) := 0;
EXPORT InValidMessage_db_cons_home_sqft_actual(UNSIGNED1 wh) := '';
 
EXPORT Make_db_cons_occupation_ind(SALT311.StrType s0) := s0;
EXPORT InValid_db_cons_occupation_ind(SALT311.StrType s) := 0;
EXPORT InValidMessage_db_cons_occupation_ind(UNSIGNED1 wh) := '';
 
EXPORT Make_db_cons_credit_card_user(SALT311.StrType s0) := s0;
EXPORT InValid_db_cons_credit_card_user(SALT311.StrType s) := 0;
EXPORT InValidMessage_db_cons_credit_card_user(UNSIGNED1 wh) := '';
 
EXPORT Make_db_cons_home_property_type(SALT311.StrType s0) := s0;
EXPORT InValid_db_cons_home_property_type(SALT311.StrType s) := 0;
EXPORT InValidMessage_db_cons_home_property_type(UNSIGNED1 wh) := '';
 
EXPORT Make_db_cons_education_hh(SALT311.StrType s0) := s0;
EXPORT InValid_db_cons_education_hh(SALT311.StrType s) := 0;
EXPORT InValidMessage_db_cons_education_hh(UNSIGNED1 wh) := '';
 
EXPORT Make_db_cons_education_ind(SALT311.StrType s0) := s0;
EXPORT InValid_db_cons_education_ind(SALT311.StrType s) := 0;
EXPORT InValidMessage_db_cons_education_ind(UNSIGNED1 wh) := '';
 
EXPORT Make_db_cons_other_pet_owner(SALT311.StrType s0) := s0;
EXPORT InValid_db_cons_other_pet_owner(SALT311.StrType s) := 0;
EXPORT InValidMessage_db_cons_other_pet_owner(UNSIGNED1 wh) := '';
 
EXPORT Make_businesstypedesc(SALT311.StrType s0) := s0;
EXPORT InValid_businesstypedesc(SALT311.StrType s) := 0;
EXPORT InValidMessage_businesstypedesc(UNSIGNED1 wh) := '';
 
EXPORT Make_genderdesc(SALT311.StrType s0) := s0;
EXPORT InValid_genderdesc(SALT311.StrType s) := 0;
EXPORT InValidMessage_genderdesc(UNSIGNED1 wh) := '';
 
EXPORT Make_executivetypedesc(SALT311.StrType s0) := s0;
EXPORT InValid_executivetypedesc(SALT311.StrType s) := 0;
EXPORT InValidMessage_executivetypedesc(UNSIGNED1 wh) := '';
 
EXPORT Make_dbconsgenderdesc(SALT311.StrType s0) := s0;
EXPORT InValid_dbconsgenderdesc(SALT311.StrType s) := 0;
EXPORT InValidMessage_dbconsgenderdesc(UNSIGNED1 wh) := '';
 
EXPORT Make_dbconsethnicdesc(SALT311.StrType s0) := s0;
EXPORT InValid_dbconsethnicdesc(SALT311.StrType s) := 0;
EXPORT InValidMessage_dbconsethnicdesc(UNSIGNED1 wh) := '';
 
EXPORT Make_dbconsreligiousdesc(SALT311.StrType s0) := s0;
EXPORT InValid_dbconsreligiousdesc(SALT311.StrType s) := 0;
EXPORT InValidMessage_dbconsreligiousdesc(UNSIGNED1 wh) := '';
 
EXPORT Make_dbconslangprefdesc(SALT311.StrType s0) := s0;
EXPORT InValid_dbconslangprefdesc(SALT311.StrType s) := 0;
EXPORT InValidMessage_dbconslangprefdesc(UNSIGNED1 wh) := '';
 
EXPORT Make_dbconsownerrenter(SALT311.StrType s0) := s0;
EXPORT InValid_dbconsownerrenter(SALT311.StrType s) := 0;
EXPORT InValidMessage_dbconsownerrenter(UNSIGNED1 wh) := '';
 
EXPORT Make_dbconsdwellingtypedesc(SALT311.StrType s0) := s0;
EXPORT InValid_dbconsdwellingtypedesc(SALT311.StrType s) := 0;
EXPORT InValidMessage_dbconsdwellingtypedesc(UNSIGNED1 wh) := '';
 
EXPORT Make_dbconsmaritaldesc(SALT311.StrType s0) := s0;
EXPORT InValid_dbconsmaritaldesc(SALT311.StrType s) := 0;
EXPORT InValidMessage_dbconsmaritaldesc(UNSIGNED1 wh) := '';
 
EXPORT Make_dbconsnewparentdesc(SALT311.StrType s0) := s0;
EXPORT InValid_dbconsnewparentdesc(SALT311.StrType s) := 0;
EXPORT InValidMessage_dbconsnewparentdesc(UNSIGNED1 wh) := '';
 
EXPORT Make_dbconsteendriverdesc(SALT311.StrType s0) := s0;
EXPORT InValid_dbconsteendriverdesc(SALT311.StrType s) := 0;
EXPORT InValidMessage_dbconsteendriverdesc(UNSIGNED1 wh) := '';
 
EXPORT Make_dbconspolipartydesc(SALT311.StrType s0) := s0;
EXPORT InValid_dbconspolipartydesc(SALT311.StrType s) := 0;
EXPORT InValidMessage_dbconspolipartydesc(UNSIGNED1 wh) := '';
 
EXPORT Make_dbconsoccupationdesc(SALT311.StrType s0) := s0;
EXPORT InValid_dbconsoccupationdesc(SALT311.StrType s) := 0;
EXPORT InValidMessage_dbconsoccupationdesc(UNSIGNED1 wh) := '';
 
EXPORT Make_dbconspropertytypedesc(SALT311.StrType s0) := s0;
EXPORT InValid_dbconspropertytypedesc(SALT311.StrType s) := 0;
EXPORT InValidMessage_dbconspropertytypedesc(UNSIGNED1 wh) := '';
 
EXPORT Make_dbconsheadhouseeducdesc(SALT311.StrType s0) := s0;
EXPORT InValid_dbconsheadhouseeducdesc(SALT311.StrType s) := 0;
EXPORT InValidMessage_dbconsheadhouseeducdesc(UNSIGNED1 wh) := '';
 
EXPORT Make_dbconseducationdesc(SALT311.StrType s0) := s0;
EXPORT InValid_dbconseducationdesc(SALT311.StrType s) := 0;
EXPORT InValidMessage_dbconseducationdesc(UNSIGNED1 wh) := '';
 
EXPORT Make_title(SALT311.StrType s0) := s0;
EXPORT InValid_title(SALT311.StrType s) := 0;
EXPORT InValidMessage_title(UNSIGNED1 wh) := '';
 
EXPORT Make_fname(SALT311.StrType s0) := s0;
EXPORT InValid_fname(SALT311.StrType s) := 0;
EXPORT InValidMessage_fname(UNSIGNED1 wh) := '';
 
EXPORT Make_mname(SALT311.StrType s0) := s0;
EXPORT InValid_mname(SALT311.StrType s) := 0;
EXPORT InValidMessage_mname(UNSIGNED1 wh) := '';
 
EXPORT Make_lname(SALT311.StrType s0) := s0;
EXPORT InValid_lname(SALT311.StrType s) := 0;
EXPORT InValidMessage_lname(UNSIGNED1 wh) := '';
 
EXPORT Make_name_score(SALT311.StrType s0) := s0;
EXPORT InValid_name_score(SALT311.StrType s) := 0;
EXPORT InValidMessage_name_score(UNSIGNED1 wh) := '';
 
EXPORT Make_prim_range(SALT311.StrType s0) := s0;
EXPORT InValid_prim_range(SALT311.StrType s) := 0;
EXPORT InValidMessage_prim_range(UNSIGNED1 wh) := '';
 
EXPORT Make_predir(SALT311.StrType s0) := s0;
EXPORT InValid_predir(SALT311.StrType s) := 0;
EXPORT InValidMessage_predir(UNSIGNED1 wh) := '';
 
EXPORT Make_prim_name(SALT311.StrType s0) := s0;
EXPORT InValid_prim_name(SALT311.StrType s) := 0;
EXPORT InValidMessage_prim_name(UNSIGNED1 wh) := '';
 
EXPORT Make_addr_suffix(SALT311.StrType s0) := s0;
EXPORT InValid_addr_suffix(SALT311.StrType s) := 0;
EXPORT InValidMessage_addr_suffix(UNSIGNED1 wh) := '';
 
EXPORT Make_postdir(SALT311.StrType s0) := s0;
EXPORT InValid_postdir(SALT311.StrType s) := 0;
EXPORT InValidMessage_postdir(UNSIGNED1 wh) := '';
 
EXPORT Make_unit_desig(SALT311.StrType s0) := s0;
EXPORT InValid_unit_desig(SALT311.StrType s) := 0;
EXPORT InValidMessage_unit_desig(UNSIGNED1 wh) := '';
 
EXPORT Make_sec_range(SALT311.StrType s0) := s0;
EXPORT InValid_sec_range(SALT311.StrType s) := 0;
EXPORT InValidMessage_sec_range(UNSIGNED1 wh) := '';
 
EXPORT Make_p_city_name(SALT311.StrType s0) := s0;
EXPORT InValid_p_city_name(SALT311.StrType s) := 0;
EXPORT InValidMessage_p_city_name(UNSIGNED1 wh) := '';
 
EXPORT Make_v_city_name(SALT311.StrType s0) := s0;
EXPORT InValid_v_city_name(SALT311.StrType s) := 0;
EXPORT InValidMessage_v_city_name(UNSIGNED1 wh) := '';
 
EXPORT Make_st(SALT311.StrType s0) := s0;
EXPORT InValid_st(SALT311.StrType s) := 0;
EXPORT InValidMessage_st(UNSIGNED1 wh) := '';
 
EXPORT Make_cart(SALT311.StrType s0) := s0;
EXPORT InValid_cart(SALT311.StrType s) := 0;
EXPORT InValidMessage_cart(UNSIGNED1 wh) := '';
 
EXPORT Make_cr_sort_sz(SALT311.StrType s0) := s0;
EXPORT InValid_cr_sort_sz(SALT311.StrType s) := 0;
EXPORT InValidMessage_cr_sort_sz(UNSIGNED1 wh) := '';
 
EXPORT Make_lot(SALT311.StrType s0) := s0;
EXPORT InValid_lot(SALT311.StrType s) := 0;
EXPORT InValidMessage_lot(UNSIGNED1 wh) := '';
 
EXPORT Make_lot_order(SALT311.StrType s0) := s0;
EXPORT InValid_lot_order(SALT311.StrType s) := 0;
EXPORT InValidMessage_lot_order(UNSIGNED1 wh) := '';
 
EXPORT Make_dbpc(SALT311.StrType s0) := s0;
EXPORT InValid_dbpc(SALT311.StrType s) := 0;
EXPORT InValidMessage_dbpc(UNSIGNED1 wh) := '';
 
EXPORT Make_chk_digit(SALT311.StrType s0) := s0;
EXPORT InValid_chk_digit(SALT311.StrType s) := 0;
EXPORT InValidMessage_chk_digit(UNSIGNED1 wh) := '';
 
EXPORT Make_rec_type(SALT311.StrType s0) := s0;
EXPORT InValid_rec_type(SALT311.StrType s) := 0;
EXPORT InValidMessage_rec_type(UNSIGNED1 wh) := '';
 
EXPORT Make_fips_state(SALT311.StrType s0) := s0;
EXPORT InValid_fips_state(SALT311.StrType s) := 0;
EXPORT InValidMessage_fips_state(UNSIGNED1 wh) := '';
 
EXPORT Make_fips_county(SALT311.StrType s0) := s0;
EXPORT InValid_fips_county(SALT311.StrType s) := 0;
EXPORT InValidMessage_fips_county(UNSIGNED1 wh) := '';
 
EXPORT Make_geo_lat(SALT311.StrType s0) := s0;
EXPORT InValid_geo_lat(SALT311.StrType s) := 0;
EXPORT InValidMessage_geo_lat(UNSIGNED1 wh) := '';
 
EXPORT Make_geo_long(SALT311.StrType s0) := s0;
EXPORT InValid_geo_long(SALT311.StrType s) := 0;
EXPORT InValidMessage_geo_long(UNSIGNED1 wh) := '';
 
EXPORT Make_msa(SALT311.StrType s0) := s0;
EXPORT InValid_msa(SALT311.StrType s) := 0;
EXPORT InValidMessage_msa(UNSIGNED1 wh) := '';
 
EXPORT Make_geo_blk(SALT311.StrType s0) := s0;
EXPORT InValid_geo_blk(SALT311.StrType s) := 0;
EXPORT InValidMessage_geo_blk(UNSIGNED1 wh) := '';
 
EXPORT Make_geo_match(SALT311.StrType s0) := s0;
EXPORT InValid_geo_match(SALT311.StrType s) := 0;
EXPORT InValidMessage_geo_match(UNSIGNED1 wh) := '';
 
EXPORT Make_err_stat(SALT311.StrType s0) := s0;
EXPORT InValid_err_stat(SALT311.StrType s) := 0;
EXPORT InValidMessage_err_stat(UNSIGNED1 wh) := '';
 
EXPORT Make_raw_aid(SALT311.StrType s0) := s0;
EXPORT InValid_raw_aid(SALT311.StrType s) := 0;
EXPORT InValidMessage_raw_aid(UNSIGNED1 wh) := '';
 
EXPORT Make_ace_aid(SALT311.StrType s0) := s0;
EXPORT InValid_ace_aid(SALT311.StrType s) := 0;
EXPORT InValidMessage_ace_aid(UNSIGNED1 wh) := '';
 
EXPORT Make_prep_address_line1(SALT311.StrType s0) := s0;
EXPORT InValid_prep_address_line1(SALT311.StrType s) := 0;
EXPORT InValidMessage_prep_address_line1(UNSIGNED1 wh) := '';
 
EXPORT Make_prep_address_line_last(SALT311.StrType s0) := s0;
EXPORT InValid_prep_address_line_last(SALT311.StrType s) := 0;
EXPORT InValidMessage_prep_address_line_last(UNSIGNED1 wh) := '';
 
// This macro will compute and count field level differences based upon a pivot expression
export MAC_CountDifferencesByPivot(in_left,in_right,pivot_exp,bad_pivots,out_counts) := MACRO
  IMPORT SALT311,Database_USA;
//Find those highly occuring pivot values to remove them from consideration
#uniquename(tr)
  %tr% := table(in_left+in_right,{ val := pivot_exp; });
#uniquename(r1)
  %r1% := record
    %tr%.val;    unsigned Cnt := COUNT(GROUP);
  end;
#uniquename(t1)
  %t1% := table(%tr%,%r1%,val,local); // Pre-aggregate before distribute
#uniquename(r2)
  %r2% := record
    %t1%.val;    unsigned Cnt := SUM(GROUP,%t1%.Cnt);
  end;
#uniquename(t2)
  %t2% := table(%t1%,%r2%,val); // Now do global aggregate
Bad_Pivots := %t2%(Cnt>100);
#uniquename(dl)
  %dl% := RECORD
    BOOLEAN Diff_dt_first_seen;
    BOOLEAN Diff_dt_last_seen;
    BOOLEAN Diff_dt_vendor_first_reported;
    BOOLEAN Diff_dt_vendor_last_reported;
    BOOLEAN Diff_process_date;
    BOOLEAN Diff_dotid;
    BOOLEAN Diff_dotscore;
    BOOLEAN Diff_dotweight;
    BOOLEAN Diff_empid;
    BOOLEAN Diff_empscore;
    BOOLEAN Diff_empweight;
    BOOLEAN Diff_powid;
    BOOLEAN Diff_powscore;
    BOOLEAN Diff_powweight;
    BOOLEAN Diff_proxid;
    BOOLEAN Diff_proxscore;
    BOOLEAN Diff_proxweight;
    BOOLEAN Diff_selescore;
    BOOLEAN Diff_seleweight;
    BOOLEAN Diff_orgid;
    BOOLEAN Diff_orgscore;
    BOOLEAN Diff_orgweight;
    BOOLEAN Diff_ultid;
    BOOLEAN Diff_ultscore;
    BOOLEAN Diff_ultweight;
    BOOLEAN Diff_record_type;
    BOOLEAN Diff_global_sid;
    BOOLEAN Diff_dbusa_business_id;
    BOOLEAN Diff_dbusa_executive_id;
    BOOLEAN Diff_subhq_parent_id;
    BOOLEAN Diff_hq_id;
    BOOLEAN Diff_ind_frm_indicator;
    BOOLEAN Diff_company_name;
    BOOLEAN Diff_full_name;
    BOOLEAN Diff_prefix;
    BOOLEAN Diff_first_name;
    BOOLEAN Diff_middle_initial;
    BOOLEAN Diff_last_name;
    BOOLEAN Diff_suffix;
    BOOLEAN Diff_gender;
    BOOLEAN Diff_standardized_title;
    BOOLEAN Diff_sourcetitle;
    BOOLEAN Diff_executive_title_rank;
    BOOLEAN Diff_primary_exec_flag;
    BOOLEAN Diff_exec_type;
    BOOLEAN Diff_executive_department;
    BOOLEAN Diff_executive_level;
    BOOLEAN Diff_phy_addr_standardized;
    BOOLEAN Diff_phy_addr_city;
    BOOLEAN Diff_phy_addr_state;
    BOOLEAN Diff_phy_addr_zip;
    BOOLEAN Diff_phy_addr_zip4;
    BOOLEAN Diff_phy_addr_carrierroute;
    BOOLEAN Diff_phy_addr_deliverypt;
    BOOLEAN Diff_phy_addr_deliveryptchkdig;
    BOOLEAN Diff_mail_addr_standardized;
    BOOLEAN Diff_mail_addr_city;
    BOOLEAN Diff_mail_addr_state;
    BOOLEAN Diff_mail_addr_zip;
    BOOLEAN Diff_mail_addr_zip4;
    BOOLEAN Diff_mail_addr_carrierroute;
    BOOLEAN Diff_mail_addr_deliverypt;
    BOOLEAN Diff_mail_addr_deliveryptchkdig;
    BOOLEAN Diff_mail_score;
    BOOLEAN Diff_mail_score_desc;
    BOOLEAN Diff_phone;
    BOOLEAN Diff_area_code;
    BOOLEAN Diff_fax;
    BOOLEAN Diff_email;
    BOOLEAN Diff_email_available_indicator;
    BOOLEAN Diff_url;
    BOOLEAN Diff_url_facebook;
    BOOLEAN Diff_url_googleplus;
    BOOLEAN Diff_url_instagram;
    BOOLEAN Diff_url_linkedin;
    BOOLEAN Diff_url_twitter;
    BOOLEAN Diff_url_youtube;
    BOOLEAN Diff_business_status_code;
    BOOLEAN Diff_business_status_desc;
    BOOLEAN Diff_franchise_flag;
    BOOLEAN Diff_franchise_type;
    BOOLEAN Diff_franchise_desc;
    BOOLEAN Diff_ticker_symbol;
    BOOLEAN Diff_stock_exchange;
    BOOLEAN Diff_fortune_1000_flag;
    BOOLEAN Diff_fortune_1000_rank;
    BOOLEAN Diff_fortune_1000_branches;
    BOOLEAN Diff_num_linked_locations;
    BOOLEAN Diff_county_code;
    BOOLEAN Diff_county_desc;
    BOOLEAN Diff_cbsa_code;
    BOOLEAN Diff_cbsa_desc;
    BOOLEAN Diff_geo_match_level;
    BOOLEAN Diff_latitude;
    BOOLEAN Diff_longitude;
    BOOLEAN Diff_scf;
    BOOLEAN Diff_timezone;
    BOOLEAN Diff_censustract;
    BOOLEAN Diff_censusblock;
    BOOLEAN Diff_city_population_code;
    BOOLEAN Diff_city_population_descr;
    BOOLEAN Diff_primary_sic;
    BOOLEAN Diff_primary_sic_desc;
    BOOLEAN Diff_sic02;
    BOOLEAN Diff_sic02_desc;
    BOOLEAN Diff_sic03;
    BOOLEAN Diff_sic03_desc;
    BOOLEAN Diff_sic04;
    BOOLEAN Diff_sic04_desc;
    BOOLEAN Diff_sic05;
    BOOLEAN Diff_sic05_desc;
    BOOLEAN Diff_sic06;
    BOOLEAN Diff_sic06_desc;
    BOOLEAN Diff_primarysic2;
    BOOLEAN Diff_primary_2_digit_sic_desc;
    BOOLEAN Diff_primarysic4;
    BOOLEAN Diff_primary_4_digit_sic_desc;
    BOOLEAN Diff_naics01;
    BOOLEAN Diff_naics01_desc;
    BOOLEAN Diff_naics02;
    BOOLEAN Diff_naics02_desc;
    BOOLEAN Diff_naics03;
    BOOLEAN Diff_naics03_desc;
    BOOLEAN Diff_naics04;
    BOOLEAN Diff_naics04_desc;
    BOOLEAN Diff_naics05;
    BOOLEAN Diff_naics05_desc;
    BOOLEAN Diff_naics06;
    BOOLEAN Diff_naics06_desc;
    BOOLEAN Diff_location_employees_total;
    BOOLEAN Diff_location_employee_code;
    BOOLEAN Diff_location_employee_desc;
    BOOLEAN Diff_location_sales_total;
    BOOLEAN Diff_location_sales_code;
    BOOLEAN Diff_location_sales_desc;
    BOOLEAN Diff_corporate_employee_total;
    BOOLEAN Diff_corporate_employee_code;
    BOOLEAN Diff_corporate_employee_desc;
    BOOLEAN Diff_year_established;
    BOOLEAN Diff_years_in_business_range;
    BOOLEAN Diff_female_owned;
    BOOLEAN Diff_minority_owned_flag;
    BOOLEAN Diff_minority_type;
    BOOLEAN Diff_home_based_indicator;
    BOOLEAN Diff_small_business_indicator;
    BOOLEAN Diff_import_export;
    BOOLEAN Diff_manufacturing_location;
    BOOLEAN Diff_public_indicator;
    BOOLEAN Diff_ein;
    BOOLEAN Diff_non_profit_org;
    BOOLEAN Diff_square_footage;
    BOOLEAN Diff_square_footage_code;
    BOOLEAN Diff_square_footage_desc;
    BOOLEAN Diff_creditscore;
    BOOLEAN Diff_creditcode;
    BOOLEAN Diff_credit_desc;
    BOOLEAN Diff_credit_capacity;
    BOOLEAN Diff_credit_capacity_code;
    BOOLEAN Diff_credit_capacity_desc;
    BOOLEAN Diff_advertising_expenses_code;
    BOOLEAN Diff_expense_advertising_desc;
    BOOLEAN Diff_technology_expenses_code;
    BOOLEAN Diff_expense_technology_desc;
    BOOLEAN Diff_office_equip_expenses_code;
    BOOLEAN Diff_expense_office_equip_desc;
    BOOLEAN Diff_rent_expenses_code;
    BOOLEAN Diff_expense_rent_desc;
    BOOLEAN Diff_telecom_expenses_code;
    BOOLEAN Diff_expense_telecom_desc;
    BOOLEAN Diff_accounting_expenses_code;
    BOOLEAN Diff_expense_accounting_desc;
    BOOLEAN Diff_bus_insurance_expense_code;
    BOOLEAN Diff_expense_bus_insurance_desc;
    BOOLEAN Diff_legal_expenses_code;
    BOOLEAN Diff_expense_legal_desc;
    BOOLEAN Diff_utilities_expenses_code;
    BOOLEAN Diff_expense_utilities_desc;
    BOOLEAN Diff_number_of_pcs_code;
    BOOLEAN Diff_number_of_pcs_desc;
    BOOLEAN Diff_nb_flag;
    BOOLEAN Diff_hq_company_name;
    BOOLEAN Diff_hq_city;
    BOOLEAN Diff_hq_state;
    BOOLEAN Diff_subhq_parent_name;
    BOOLEAN Diff_subhq_parent_city;
    BOOLEAN Diff_subhq_parent_state;
    BOOLEAN Diff_domestic_foreign_owner_flag;
    BOOLEAN Diff_foreign_parent_company_name;
    BOOLEAN Diff_foreign_parent_city;
    BOOLEAN Diff_foreign_parent_country;
    BOOLEAN Diff_db_cons_matchkey;
    BOOLEAN Diff_databaseusa_individual_id;
    BOOLEAN Diff_db_cons_full_name;
    BOOLEAN Diff_db_cons_full_name_prefix;
    BOOLEAN Diff_db_cons_first_name;
    BOOLEAN Diff_db_cons_middle_initial;
    BOOLEAN Diff_db_cons_last_name;
    BOOLEAN Diff_db_cons_email;
    BOOLEAN Diff_db_cons_gender;
    BOOLEAN Diff_db_cons_date_of_birth_year;
    BOOLEAN Diff_db_cons_date_of_birth_month;
    BOOLEAN Diff_db_cons_age;
    BOOLEAN Diff_db_cons_age_code_desc;
    BOOLEAN Diff_db_cons_age_in_two_year_hh;
    BOOLEAN Diff_db_cons_ethnic_code;
    BOOLEAN Diff_db_cons_religious_affil;
    BOOLEAN Diff_db_cons_language_pref;
    BOOLEAN Diff_db_cons_phy_addr_std;
    BOOLEAN Diff_db_cons_phy_addr_city;
    BOOLEAN Diff_db_cons_phy_addr_state;
    BOOLEAN Diff_db_cons_phy_addr_zip;
    BOOLEAN Diff_db_cons_phy_addr_zip4;
    BOOLEAN Diff_db_cons_phy_addr_carrierroute;
    BOOLEAN Diff_db_cons_phy_addr_deliverypt;
    BOOLEAN Diff_db_cons_line_of_travel;
    BOOLEAN Diff_db_cons_geocode_results;
    BOOLEAN Diff_db_cons_latitude;
    BOOLEAN Diff_db_cons_longitude;
    BOOLEAN Diff_db_cons_time_zone_code;
    BOOLEAN Diff_db_cons_time_zone_desc;
    BOOLEAN Diff_db_cons_census_tract;
    BOOLEAN Diff_db_cons_census_block;
    BOOLEAN Diff_db_cons_countyfips;
    BOOLEAN Diff_db_countyname;
    BOOLEAN Diff_db_cons_cbsa_code;
    BOOLEAN Diff_db_cons_cbsa_desc;
    BOOLEAN Diff_db_cons_walk_sequence;
    BOOLEAN Diff_db_cons_phone;
    BOOLEAN Diff_db_cons_dnc;
    BOOLEAN Diff_db_cons_scrubbed_phoneable;
    BOOLEAN Diff_db_cons_children_present;
    BOOLEAN Diff_db_cons_home_value_code;
    BOOLEAN Diff_db_cons_home_value_desc;
    BOOLEAN Diff_db_cons_donor_capacity;
    BOOLEAN Diff_db_cons_donor_capacity_code;
    BOOLEAN Diff_db_cons_donor_capacity_desc;
    BOOLEAN Diff_db_cons_home_owner_renter;
    BOOLEAN Diff_db_cons_length_of_res;
    BOOLEAN Diff_db_cons_length_of_res_code;
    BOOLEAN Diff_db_cons_length_of_res_desc;
    BOOLEAN Diff_db_cons_dwelling_type;
    BOOLEAN Diff_db_cons_recent_home_buyer;
    BOOLEAN Diff_db_cons_income_code;
    BOOLEAN Diff_db_cons_income_desc;
    BOOLEAN Diff_db_cons_unsecuredcredcap;
    BOOLEAN Diff_db_cons_unsecuredcredcapcode;
    BOOLEAN Diff_db_cons_unsecuredcredcapdesc;
    BOOLEAN Diff_db_cons_networthhomeval;
    BOOLEAN Diff_db_cons_networthhomevalcode;
    BOOLEAN Diff_db_cons_net_worth_desc;
    BOOLEAN Diff_db_cons_discretincome;
    BOOLEAN Diff_db_cons_discretincomecode;
    BOOLEAN Diff_db_cons_discretincomedesc;
    BOOLEAN Diff_db_cons_marital_status;
    BOOLEAN Diff_db_cons_new_parent;
    BOOLEAN Diff_db_cons_child_near_hs_grad;
    BOOLEAN Diff_db_cons_college_graduate;
    BOOLEAN Diff_db_cons_intend_purchase_veh;
    BOOLEAN Diff_db_cons_recent_divorce;
    BOOLEAN Diff_db_cons_newlywed;
    BOOLEAN Diff_db_cons_new_teen_driver;
    BOOLEAN Diff_db_cons_home_year_built;
    BOOLEAN Diff_db_cons_home_sqft_ranges;
    BOOLEAN Diff_db_cons_poli_party_ind;
    BOOLEAN Diff_db_cons_home_sqft_actual;
    BOOLEAN Diff_db_cons_occupation_ind;
    BOOLEAN Diff_db_cons_credit_card_user;
    BOOLEAN Diff_db_cons_home_property_type;
    BOOLEAN Diff_db_cons_education_hh;
    BOOLEAN Diff_db_cons_education_ind;
    BOOLEAN Diff_db_cons_other_pet_owner;
    BOOLEAN Diff_businesstypedesc;
    BOOLEAN Diff_genderdesc;
    BOOLEAN Diff_executivetypedesc;
    BOOLEAN Diff_dbconsgenderdesc;
    BOOLEAN Diff_dbconsethnicdesc;
    BOOLEAN Diff_dbconsreligiousdesc;
    BOOLEAN Diff_dbconslangprefdesc;
    BOOLEAN Diff_dbconsownerrenter;
    BOOLEAN Diff_dbconsdwellingtypedesc;
    BOOLEAN Diff_dbconsmaritaldesc;
    BOOLEAN Diff_dbconsnewparentdesc;
    BOOLEAN Diff_dbconsteendriverdesc;
    BOOLEAN Diff_dbconspolipartydesc;
    BOOLEAN Diff_dbconsoccupationdesc;
    BOOLEAN Diff_dbconspropertytypedesc;
    BOOLEAN Diff_dbconsheadhouseeducdesc;
    BOOLEAN Diff_dbconseducationdesc;
    BOOLEAN Diff_title;
    BOOLEAN Diff_fname;
    BOOLEAN Diff_mname;
    BOOLEAN Diff_lname;
    BOOLEAN Diff_name_score;
    BOOLEAN Diff_phy_prim_range;
    BOOLEAN Diff_phy_predir;
    BOOLEAN Diff_phy_prim_name;
    BOOLEAN Diff_phy_addr_suffix;
    BOOLEAN Diff_phy_postdir;
    BOOLEAN Diff_phy_unit_desig;
    BOOLEAN Diff_phy_sec_range;
    BOOLEAN Diff_phy_p_city_name;
    BOOLEAN Diff_phy_v_city_name;
    BOOLEAN Diff_phy_st;
    BOOLEAN Diff_phy_cart;
    BOOLEAN Diff_phy_cr_sort_sz;
    BOOLEAN Diff_phy_lot;
    BOOLEAN Diff_phy_lot_order;
    BOOLEAN Diff_phy_dbpc;
    BOOLEAN Diff_phy_chk_digit;
    BOOLEAN Diff_phy_rec_type;
    BOOLEAN Diff_phy_fips_state;
    BOOLEAN Diff_phy_fips_county;
    BOOLEAN Diff_phy_geo_lat;
    BOOLEAN Diff_phy_geo_long;
    BOOLEAN Diff_phy_msa;
    BOOLEAN Diff_phy_geo_blk;
    BOOLEAN Diff_phy_geo_match;
    BOOLEAN Diff_phy_err_stat;
    BOOLEAN Diff_phy_raw_aid;
    BOOLEAN Diff_phy_ace_aid;
    BOOLEAN Diff_phy_prep_address_line1;
    BOOLEAN Diff_phy_prep_address_line_last;
		
		BOOLEAN Diff_mail_prim_range;
    BOOLEAN Diff_mail_predir;
    BOOLEAN Diff_mail_prim_name;
    BOOLEAN Diff_mail_addr_suffix;
    BOOLEAN Diff_mail_postdir;
    BOOLEAN Diff_mail_unit_desig;
    BOOLEAN Diff_mail_sec_range;
    BOOLEAN Diff_mail_p_city_name;
    BOOLEAN Diff_mail_v_city_name;
    BOOLEAN Diff_mail_st;
    BOOLEAN Diff_mail_cart;
    BOOLEAN Diff_mail_cr_sort_sz;
    BOOLEAN Diff_mail_lot;
    BOOLEAN Diff_mail_lot_order;
    BOOLEAN Diff_mail_dbpc;
    BOOLEAN Diff_mail_chk_digit;
    BOOLEAN Diff_mail_rec_type;
    BOOLEAN Diff_mail_fips_state;
    BOOLEAN Diff_mail_fips_county;
    BOOLEAN Diff_mail_geo_lat;
    BOOLEAN Diff_mail_geo_long;
    BOOLEAN Diff_mail_msa;
    BOOLEAN Diff_mail_geo_blk;
    BOOLEAN Diff_mail_geo_match;
    BOOLEAN Diff_mail_err_stat;
    BOOLEAN Diff_mail_raw_aid;
    BOOLEAN Diff_mail_ace_aid;
    BOOLEAN Diff_mail_prep_address_line1;
    BOOLEAN Diff_mail_prep_address_line_last;
		
		BOOLEAN Diff_db_cons_prim_range;
    BOOLEAN Diff_db_cons_predir;
    BOOLEAN Diff_db_cons_prim_name;
    BOOLEAN Diff_db_cons_addr_suffix;
    BOOLEAN Diff_db_cons_postdir;
    BOOLEAN Diff_db_cons_unit_desig;
    BOOLEAN Diff_db_cons_sec_range;
    BOOLEAN Diff_db_cons_p_city_name;
    BOOLEAN Diff_db_cons_v_city_name;
    BOOLEAN Diff_db_cons_st;
    BOOLEAN Diff_db_cons_cart;
    BOOLEAN Diff_db_cons_cr_sort_sz;
    BOOLEAN Diff_db_cons_lot;
    BOOLEAN Diff_db_cons_lot_order;
    BOOLEAN Diff_db_cons_dbpc;
    BOOLEAN Diff_db_cons_chk_digit;
    BOOLEAN Diff_db_cons_rec_type;
    BOOLEAN Diff_db_cons_fips_state;
    BOOLEAN Diff_db_cons_fips_county;
    BOOLEAN Diff_db_cons_geo_lat;
    BOOLEAN Diff_db_cons_geo_long;
    BOOLEAN Diff_db_cons_msa;
    BOOLEAN Diff_db_cons_geo_blk;
    BOOLEAN Diff_db_cons_geo_match;
    BOOLEAN Diff_db_cons_err_stat;
    BOOLEAN Diff_db_cons_raw_aid;
    BOOLEAN Diff_db_cons_ace_aid;
    BOOLEAN Diff_db_cons_prep_address_line1;
    BOOLEAN Diff_db_cons_prep_address_line_last;
    SALT311.StrType SourceField {MAXLENGTH(30)};
    UNSIGNED Num_Diffs;
    SALT311.StrType Val {MAXLENGTH(1024)};
  END;
#uniquename(fd)
  %dl% %fd%(in_left le,in_right ri) := TRANSFORM
    SELF.Diff_dt_first_seen := le.dt_first_seen <> ri.dt_first_seen;
    SELF.Diff_dt_last_seen := le.dt_last_seen <> ri.dt_last_seen;
    SELF.Diff_dt_vendor_first_reported := le.dt_vendor_first_reported <> ri.dt_vendor_first_reported;
    SELF.Diff_dt_vendor_last_reported := le.dt_vendor_last_reported <> ri.dt_vendor_last_reported;
    SELF.Diff_process_date := le.process_date <> ri.process_date;
    SELF.Diff_dotid := le.dotid <> ri.dotid;
    SELF.Diff_dotscore := le.dotscore <> ri.dotscore;
    SELF.Diff_dotweight := le.dotweight <> ri.dotweight;
    SELF.Diff_empid := le.empid <> ri.empid;
    SELF.Diff_empscore := le.empscore <> ri.empscore;
    SELF.Diff_empweight := le.empweight <> ri.empweight;
    SELF.Diff_powid := le.powid <> ri.powid;
    SELF.Diff_powscore := le.powscore <> ri.powscore;
    SELF.Diff_powweight := le.powweight <> ri.powweight;
    SELF.Diff_proxid := le.proxid <> ri.proxid;
    SELF.Diff_proxscore := le.proxscore <> ri.proxscore;
    SELF.Diff_proxweight := le.proxweight <> ri.proxweight;
    SELF.Diff_selescore := le.selescore <> ri.selescore;
    SELF.Diff_seleweight := le.seleweight <> ri.seleweight;
    SELF.Diff_orgid := le.orgid <> ri.orgid;
    SELF.Diff_orgscore := le.orgscore <> ri.orgscore;
    SELF.Diff_orgweight := le.orgweight <> ri.orgweight;
    SELF.Diff_ultid := le.ultid <> ri.ultid;
    SELF.Diff_ultscore := le.ultscore <> ri.ultscore;
    SELF.Diff_ultweight := le.ultweight <> ri.ultweight;
    SELF.Diff_record_type := le.record_type <> ri.record_type;
    SELF.Diff_global_sid := le.global_sid <> ri.global_sid;
    SELF.Diff_dbusa_business_id := le.dbusa_business_id <> ri.dbusa_business_id;
    SELF.Diff_dbusa_executive_id := le.dbusa_executive_id <> ri.dbusa_executive_id;
    SELF.Diff_subhq_parent_id := le.subhq_parent_id <> ri.subhq_parent_id;
    SELF.Diff_hq_id := le.hq_id <> ri.hq_id;
    SELF.Diff_ind_frm_indicator := le.ind_frm_indicator <> ri.ind_frm_indicator;
    SELF.Diff_company_name := le.company_name <> ri.company_name;
    SELF.Diff_full_name := le.full_name <> ri.full_name;
    SELF.Diff_prefix := le.prefix <> ri.prefix;
    SELF.Diff_first_name := le.first_name <> ri.first_name;
    SELF.Diff_middle_initial := le.middle_initial <> ri.middle_initial;
    SELF.Diff_last_name := le.last_name <> ri.last_name;
    SELF.Diff_suffix := le.suffix <> ri.suffix;
    SELF.Diff_gender := le.gender <> ri.gender;
    SELF.Diff_standardized_title := le.standardized_title <> ri.standardized_title;
    SELF.Diff_sourcetitle := le.sourcetitle <> ri.sourcetitle;
    SELF.Diff_executive_title_rank := le.executive_title_rank <> ri.executive_title_rank;
    SELF.Diff_primary_exec_flag := le.primary_exec_flag <> ri.primary_exec_flag;
    SELF.Diff_exec_type := le.exec_type <> ri.exec_type;
    SELF.Diff_executive_department := le.executive_department <> ri.executive_department;
    SELF.Diff_executive_level := le.executive_level <> ri.executive_level;
    SELF.Diff_phy_addr_standardized := le.phy_addr_standardized <> ri.phy_addr_standardized;
    SELF.Diff_phy_addr_city := le.phy_addr_city <> ri.phy_addr_city;
    SELF.Diff_phy_addr_state := le.phy_addr_state <> ri.phy_addr_state;
    SELF.Diff_phy_addr_zip := le.phy_addr_zip <> ri.phy_addr_zip;
    SELF.Diff_phy_addr_zip4 := le.phy_addr_zip4 <> ri.phy_addr_zip4;
    SELF.Diff_phy_addr_carrierroute := le.phy_addr_carrierroute <> ri.phy_addr_carrierroute;
    SELF.Diff_phy_addr_deliverypt := le.phy_addr_deliverypt <> ri.phy_addr_deliverypt;
    SELF.Diff_phy_addr_deliveryptchkdig := le.phy_addr_deliveryptchkdig <> ri.phy_addr_deliveryptchkdig;
    SELF.Diff_mail_addr_standardized := le.mail_addr_standardized <> ri.mail_addr_standardized;
    SELF.Diff_mail_addr_city := le.mail_addr_city <> ri.mail_addr_city;
    SELF.Diff_mail_addr_state := le.mail_addr_state <> ri.mail_addr_state;
    SELF.Diff_mail_addr_zip := le.mail_addr_zip <> ri.mail_addr_zip;
    SELF.Diff_mail_addr_zip4 := le.mail_addr_zip4 <> ri.mail_addr_zip4;
    SELF.Diff_mail_addr_carrierroute := le.mail_addr_carrierroute <> ri.mail_addr_carrierroute;
    SELF.Diff_mail_addr_deliverypt := le.mail_addr_deliverypt <> ri.mail_addr_deliverypt;
    SELF.Diff_mail_addr_deliveryptchkdig := le.mail_addr_deliveryptchkdig <> ri.mail_addr_deliveryptchkdig;
    SELF.Diff_mail_score := le.mail_score <> ri.mail_score;
    SELF.Diff_mail_score_desc := le.mail_score_desc <> ri.mail_score_desc;
    SELF.Diff_phone := le.phone <> ri.phone;
    SELF.Diff_area_code := le.area_code <> ri.area_code;
    SELF.Diff_fax := le.fax <> ri.fax;
    SELF.Diff_email := le.email <> ri.email;
    SELF.Diff_email_available_indicator := le.email_available_indicator <> ri.email_available_indicator;
    SELF.Diff_url := le.url <> ri.url;
    SELF.Diff_url_facebook := le.url_facebook <> ri.url_facebook;
    SELF.Diff_url_googleplus := le.url_googleplus <> ri.url_googleplus;
    SELF.Diff_url_instagram := le.url_instagram <> ri.url_instagram;
    SELF.Diff_url_linkedin := le.url_linkedin <> ri.url_linkedin;
    SELF.Diff_url_twitter := le.url_twitter <> ri.url_twitter;
    SELF.Diff_url_youtube := le.url_youtube <> ri.url_youtube;
    SELF.Diff_business_status_code := le.business_status_code <> ri.business_status_code;
    SELF.Diff_business_status_desc := le.business_status_desc <> ri.business_status_desc;
    SELF.Diff_franchise_flag := le.franchise_flag <> ri.franchise_flag;
    SELF.Diff_franchise_type := le.franchise_type <> ri.franchise_type;
    SELF.Diff_franchise_desc := le.franchise_desc <> ri.franchise_desc;
    SELF.Diff_ticker_symbol := le.ticker_symbol <> ri.ticker_symbol;
    SELF.Diff_stock_exchange := le.stock_exchange <> ri.stock_exchange;
    SELF.Diff_fortune_1000_flag := le.fortune_1000_flag <> ri.fortune_1000_flag;
    SELF.Diff_fortune_1000_rank := le.fortune_1000_rank <> ri.fortune_1000_rank;
    SELF.Diff_fortune_1000_branches := le.fortune_1000_branches <> ri.fortune_1000_branches;
    SELF.Diff_num_linked_locations := le.num_linked_locations <> ri.num_linked_locations;
    SELF.Diff_county_code := le.county_code <> ri.county_code;
    SELF.Diff_county_desc := le.county_desc <> ri.county_desc;
    SELF.Diff_cbsa_code := le.cbsa_code <> ri.cbsa_code;
    SELF.Diff_cbsa_desc := le.cbsa_desc <> ri.cbsa_desc;
    SELF.Diff_geo_match_level := le.geo_match_level <> ri.geo_match_level;
    SELF.Diff_latitude := le.latitude <> ri.latitude;
    SELF.Diff_longitude := le.longitude <> ri.longitude;
    SELF.Diff_scf := le.scf <> ri.scf;
    SELF.Diff_timezone := le.timezone <> ri.timezone;
    SELF.Diff_censustract := le.censustract <> ri.censustract;
    SELF.Diff_censusblock := le.censusblock <> ri.censusblock;
    SELF.Diff_city_population_code := le.city_population_code <> ri.city_population_code;
    SELF.Diff_city_population_descr := le.city_population_descr <> ri.city_population_descr;
    SELF.Diff_primary_sic := le.primary_sic <> ri.primary_sic;
    SELF.Diff_primary_sic_desc := le.primary_sic_desc <> ri.primary_sic_desc;
    SELF.Diff_sic02 := le.sic02 <> ri.sic02;
    SELF.Diff_sic02_desc := le.sic02_desc <> ri.sic02_desc;
    SELF.Diff_sic03 := le.sic03 <> ri.sic03;
    SELF.Diff_sic03_desc := le.sic03_desc <> ri.sic03_desc;
    SELF.Diff_sic04 := le.sic04 <> ri.sic04;
    SELF.Diff_sic04_desc := le.sic04_desc <> ri.sic04_desc;
    SELF.Diff_sic05 := le.sic05 <> ri.sic05;
    SELF.Diff_sic05_desc := le.sic05_desc <> ri.sic05_desc;
    SELF.Diff_sic06 := le.sic06 <> ri.sic06;
    SELF.Diff_sic06_desc := le.sic06_desc <> ri.sic06_desc;
    SELF.Diff_primarysic2 := le.primarysic2 <> ri.primarysic2;
    SELF.Diff_primary_2_digit_sic_desc := le.primary_2_digit_sic_desc <> ri.primary_2_digit_sic_desc;
    SELF.Diff_primarysic4 := le.primarysic4 <> ri.primarysic4;
    SELF.Diff_primary_4_digit_sic_desc := le.primary_4_digit_sic_desc <> ri.primary_4_digit_sic_desc;
    SELF.Diff_naics01 := le.naics01 <> ri.naics01;
    SELF.Diff_naics01_desc := le.naics01_desc <> ri.naics01_desc;
    SELF.Diff_naics02 := le.naics02 <> ri.naics02;
    SELF.Diff_naics02_desc := le.naics02_desc <> ri.naics02_desc;
    SELF.Diff_naics03 := le.naics03 <> ri.naics03;
    SELF.Diff_naics03_desc := le.naics03_desc <> ri.naics03_desc;
    SELF.Diff_naics04 := le.naics04 <> ri.naics04;
    SELF.Diff_naics04_desc := le.naics04_desc <> ri.naics04_desc;
    SELF.Diff_naics05 := le.naics05 <> ri.naics05;
    SELF.Diff_naics05_desc := le.naics05_desc <> ri.naics05_desc;
    SELF.Diff_naics06 := le.naics06 <> ri.naics06;
    SELF.Diff_naics06_desc := le.naics06_desc <> ri.naics06_desc;
    SELF.Diff_location_employees_total := le.location_employees_total <> ri.location_employees_total;
    SELF.Diff_location_employee_code := le.location_employee_code <> ri.location_employee_code;
    SELF.Diff_location_employee_desc := le.location_employee_desc <> ri.location_employee_desc;
    SELF.Diff_location_sales_total := le.location_sales_total <> ri.location_sales_total;
    SELF.Diff_location_sales_code := le.location_sales_code <> ri.location_sales_code;
    SELF.Diff_location_sales_desc := le.location_sales_desc <> ri.location_sales_desc;
    SELF.Diff_corporate_employee_total := le.corporate_employee_total <> ri.corporate_employee_total;
    SELF.Diff_corporate_employee_code := le.corporate_employee_code <> ri.corporate_employee_code;
    SELF.Diff_corporate_employee_desc := le.corporate_employee_desc <> ri.corporate_employee_desc;
    SELF.Diff_year_established := le.year_established <> ri.year_established;
    SELF.Diff_years_in_business_range := le.years_in_business_range <> ri.years_in_business_range;
    SELF.Diff_female_owned := le.female_owned <> ri.female_owned;
    SELF.Diff_minority_owned_flag := le.minority_owned_flag <> ri.minority_owned_flag;
    SELF.Diff_minority_type := le.minority_type <> ri.minority_type;
    SELF.Diff_home_based_indicator := le.home_based_indicator <> ri.home_based_indicator;
    SELF.Diff_small_business_indicator := le.small_business_indicator <> ri.small_business_indicator;
    SELF.Diff_import_export := le.import_export <> ri.import_export;
    SELF.Diff_manufacturing_location := le.manufacturing_location <> ri.manufacturing_location;
    SELF.Diff_public_indicator := le.public_indicator <> ri.public_indicator;
    SELF.Diff_ein := le.ein <> ri.ein;
    SELF.Diff_non_profit_org := le.non_profit_org <> ri.non_profit_org;
    SELF.Diff_square_footage := le.square_footage <> ri.square_footage;
    SELF.Diff_square_footage_code := le.square_footage_code <> ri.square_footage_code;
    SELF.Diff_square_footage_desc := le.square_footage_desc <> ri.square_footage_desc;
    SELF.Diff_creditscore := le.creditscore <> ri.creditscore;
    SELF.Diff_creditcode := le.creditcode <> ri.creditcode;
    SELF.Diff_credit_desc := le.credit_desc <> ri.credit_desc;
    SELF.Diff_credit_capacity := le.credit_capacity <> ri.credit_capacity;
    SELF.Diff_credit_capacity_code := le.credit_capacity_code <> ri.credit_capacity_code;
    SELF.Diff_credit_capacity_desc := le.credit_capacity_desc <> ri.credit_capacity_desc;
    SELF.Diff_advertising_expenses_code := le.advertising_expenses_code <> ri.advertising_expenses_code;
    SELF.Diff_expense_advertising_desc := le.expense_advertising_desc <> ri.expense_advertising_desc;
    SELF.Diff_technology_expenses_code := le.technology_expenses_code <> ri.technology_expenses_code;
    SELF.Diff_expense_technology_desc := le.expense_technology_desc <> ri.expense_technology_desc;
    SELF.Diff_office_equip_expenses_code := le.office_equip_expenses_code <> ri.office_equip_expenses_code;
    SELF.Diff_expense_office_equip_desc := le.expense_office_equip_desc <> ri.expense_office_equip_desc;
    SELF.Diff_rent_expenses_code := le.rent_expenses_code <> ri.rent_expenses_code;
    SELF.Diff_expense_rent_desc := le.expense_rent_desc <> ri.expense_rent_desc;
    SELF.Diff_telecom_expenses_code := le.telecom_expenses_code <> ri.telecom_expenses_code;
    SELF.Diff_expense_telecom_desc := le.expense_telecom_desc <> ri.expense_telecom_desc;
    SELF.Diff_accounting_expenses_code := le.accounting_expenses_code <> ri.accounting_expenses_code;
    SELF.Diff_expense_accounting_desc := le.expense_accounting_desc <> ri.expense_accounting_desc;
    SELF.Diff_bus_insurance_expense_code := le.bus_insurance_expense_code <> ri.bus_insurance_expense_code;
    SELF.Diff_expense_bus_insurance_desc := le.expense_bus_insurance_desc <> ri.expense_bus_insurance_desc;
    SELF.Diff_legal_expenses_code := le.legal_expenses_code <> ri.legal_expenses_code;
    SELF.Diff_expense_legal_desc := le.expense_legal_desc <> ri.expense_legal_desc;
    SELF.Diff_utilities_expenses_code := le.utilities_expenses_code <> ri.utilities_expenses_code;
    SELF.Diff_expense_utilities_desc := le.expense_utilities_desc <> ri.expense_utilities_desc;
    SELF.Diff_number_of_pcs_code := le.number_of_pcs_code <> ri.number_of_pcs_code;
    SELF.Diff_number_of_pcs_desc := le.number_of_pcs_desc <> ri.number_of_pcs_desc;
    SELF.Diff_nb_flag := le.nb_flag <> ri.nb_flag;
    SELF.Diff_hq_company_name := le.hq_company_name <> ri.hq_company_name;
    SELF.Diff_hq_city := le.hq_city <> ri.hq_city;
    SELF.Diff_hq_state := le.hq_state <> ri.hq_state;
    SELF.Diff_subhq_parent_name := le.subhq_parent_name <> ri.subhq_parent_name;
    SELF.Diff_subhq_parent_city := le.subhq_parent_city <> ri.subhq_parent_city;
    SELF.Diff_subhq_parent_state := le.subhq_parent_state <> ri.subhq_parent_state;
    SELF.Diff_domestic_foreign_owner_flag := le.domestic_foreign_owner_flag <> ri.domestic_foreign_owner_flag;
    SELF.Diff_foreign_parent_company_name := le.foreign_parent_company_name <> ri.foreign_parent_company_name;
    SELF.Diff_foreign_parent_city := le.foreign_parent_city <> ri.foreign_parent_city;
    SELF.Diff_foreign_parent_country := le.foreign_parent_country <> ri.foreign_parent_country;
    SELF.Diff_db_cons_matchkey := le.db_cons_matchkey <> ri.db_cons_matchkey;
    SELF.Diff_databaseusa_individual_id := le.databaseusa_individual_id <> ri.databaseusa_individual_id;
    SELF.Diff_db_cons_full_name := le.db_cons_full_name <> ri.db_cons_full_name;
    SELF.Diff_db_cons_full_name_prefix := le.db_cons_full_name_prefix <> ri.db_cons_full_name_prefix;
    SELF.Diff_db_cons_first_name := le.db_cons_first_name <> ri.db_cons_first_name;
    SELF.Diff_db_cons_middle_initial := le.db_cons_middle_initial <> ri.db_cons_middle_initial;
    SELF.Diff_db_cons_last_name := le.db_cons_last_name <> ri.db_cons_last_name;
    SELF.Diff_db_cons_email := le.db_cons_email <> ri.db_cons_email;
    SELF.Diff_db_cons_gender := le.db_cons_gender <> ri.db_cons_gender;
    SELF.Diff_db_cons_date_of_birth_year := le.db_cons_date_of_birth_year <> ri.db_cons_date_of_birth_year;
    SELF.Diff_db_cons_date_of_birth_month := le.db_cons_date_of_birth_month <> ri.db_cons_date_of_birth_month;
    SELF.Diff_db_cons_age := le.db_cons_age <> ri.db_cons_age;
    SELF.Diff_db_cons_age_code_desc := le.db_cons_age_code_desc <> ri.db_cons_age_code_desc;
    SELF.Diff_db_cons_age_in_two_year_hh := le.db_cons_age_in_two_year_hh <> ri.db_cons_age_in_two_year_hh;
    SELF.Diff_db_cons_ethnic_code := le.db_cons_ethnic_code <> ri.db_cons_ethnic_code;
    SELF.Diff_db_cons_religious_affil := le.db_cons_religious_affil <> ri.db_cons_religious_affil;
    SELF.Diff_db_cons_language_pref := le.db_cons_language_pref <> ri.db_cons_language_pref;
    SELF.Diff_db_cons_phy_addr_std := le.db_cons_phy_addr_std <> ri.db_cons_phy_addr_std;
    SELF.Diff_db_cons_phy_addr_city := le.db_cons_phy_addr_city <> ri.db_cons_phy_addr_city;
    SELF.Diff_db_cons_phy_addr_state := le.db_cons_phy_addr_state <> ri.db_cons_phy_addr_state;
    SELF.Diff_db_cons_phy_addr_zip := le.db_cons_phy_addr_zip <> ri.db_cons_phy_addr_zip;
    SELF.Diff_db_cons_phy_addr_zip4 := le.db_cons_phy_addr_zip4 <> ri.db_cons_phy_addr_zip4;
    SELF.Diff_db_cons_phy_addr_carrierroute := le.db_cons_phy_addr_carrierroute <> ri.db_cons_phy_addr_carrierroute;
    SELF.Diff_db_cons_phy_addr_deliverypt := le.db_cons_phy_addr_deliverypt <> ri.db_cons_phy_addr_deliverypt;
    SELF.Diff_db_cons_line_of_travel := le.db_cons_line_of_travel <> ri.db_cons_line_of_travel;
    SELF.Diff_db_cons_geocode_results := le.db_cons_geocode_results <> ri.db_cons_geocode_results;
    SELF.Diff_db_cons_latitude := le.db_cons_latitude <> ri.db_cons_latitude;
    SELF.Diff_db_cons_longitude := le.db_cons_longitude <> ri.db_cons_longitude;
    SELF.Diff_db_cons_time_zone_code := le.db_cons_time_zone_code <> ri.db_cons_time_zone_code;
    SELF.Diff_db_cons_time_zone_desc := le.db_cons_time_zone_desc <> ri.db_cons_time_zone_desc;
    SELF.Diff_db_cons_census_tract := le.db_cons_census_tract <> ri.db_cons_census_tract;
    SELF.Diff_db_cons_census_block := le.db_cons_census_block <> ri.db_cons_census_block;
    SELF.Diff_db_cons_countyfips := le.db_cons_countyfips <> ri.db_cons_countyfips;
    SELF.Diff_db_countyname := le.db_countyname <> ri.db_countyname;
    SELF.Diff_db_cons_cbsa_code := le.db_cons_cbsa_code <> ri.db_cons_cbsa_code;
    SELF.Diff_db_cons_cbsa_desc := le.db_cons_cbsa_desc <> ri.db_cons_cbsa_desc;
    SELF.Diff_db_cons_walk_sequence := le.db_cons_walk_sequence <> ri.db_cons_walk_sequence;
    SELF.Diff_db_cons_phone := le.db_cons_phone <> ri.db_cons_phone;
    SELF.Diff_db_cons_dnc := le.db_cons_dnc <> ri.db_cons_dnc;
    SELF.Diff_db_cons_scrubbed_phoneable := le.db_cons_scrubbed_phoneable <> ri.db_cons_scrubbed_phoneable;
    SELF.Diff_db_cons_children_present := le.db_cons_children_present <> ri.db_cons_children_present;
    SELF.Diff_db_cons_home_value_code := le.db_cons_home_value_code <> ri.db_cons_home_value_code;
    SELF.Diff_db_cons_home_value_desc := le.db_cons_home_value_desc <> ri.db_cons_home_value_desc;
    SELF.Diff_db_cons_donor_capacity := le.db_cons_donor_capacity <> ri.db_cons_donor_capacity;
    SELF.Diff_db_cons_donor_capacity_code := le.db_cons_donor_capacity_code <> ri.db_cons_donor_capacity_code;
    SELF.Diff_db_cons_donor_capacity_desc := le.db_cons_donor_capacity_desc <> ri.db_cons_donor_capacity_desc;
    SELF.Diff_db_cons_home_owner_renter := le.db_cons_home_owner_renter <> ri.db_cons_home_owner_renter;
    SELF.Diff_db_cons_length_of_res := le.db_cons_length_of_res <> ri.db_cons_length_of_res;
    SELF.Diff_db_cons_length_of_res_code := le.db_cons_length_of_res_code <> ri.db_cons_length_of_res_code;
    SELF.Diff_db_cons_length_of_res_desc := le.db_cons_length_of_res_desc <> ri.db_cons_length_of_res_desc;
    SELF.Diff_db_cons_dwelling_type := le.db_cons_dwelling_type <> ri.db_cons_dwelling_type;
    SELF.Diff_db_cons_recent_home_buyer := le.db_cons_recent_home_buyer <> ri.db_cons_recent_home_buyer;
    SELF.Diff_db_cons_income_code := le.db_cons_income_code <> ri.db_cons_income_code;
    SELF.Diff_db_cons_income_desc := le.db_cons_income_desc <> ri.db_cons_income_desc;
    SELF.Diff_db_cons_unsecuredcredcap := le.db_cons_unsecuredcredcap <> ri.db_cons_unsecuredcredcap;
    SELF.Diff_db_cons_unsecuredcredcapcode := le.db_cons_unsecuredcredcapcode <> ri.db_cons_unsecuredcredcapcode;
    SELF.Diff_db_cons_unsecuredcredcapdesc := le.db_cons_unsecuredcredcapdesc <> ri.db_cons_unsecuredcredcapdesc;
    SELF.Diff_db_cons_networthhomeval := le.db_cons_networthhomeval <> ri.db_cons_networthhomeval;
    SELF.Diff_db_cons_networthhomevalcode := le.db_cons_networthhomevalcode <> ri.db_cons_networthhomevalcode;
    SELF.Diff_db_cons_net_worth_desc := le.db_cons_net_worth_desc <> ri.db_cons_net_worth_desc;
    SELF.Diff_db_cons_discretincome := le.db_cons_discretincome <> ri.db_cons_discretincome;
    SELF.Diff_db_cons_discretincomecode := le.db_cons_discretincomecode <> ri.db_cons_discretincomecode;
    SELF.Diff_db_cons_discretincomedesc := le.db_cons_discretincomedesc <> ri.db_cons_discretincomedesc;
    SELF.Diff_db_cons_marital_status := le.db_cons_marital_status <> ri.db_cons_marital_status;
    SELF.Diff_db_cons_new_parent := le.db_cons_new_parent <> ri.db_cons_new_parent;
    SELF.Diff_db_cons_child_near_hs_grad := le.db_cons_child_near_hs_grad <> ri.db_cons_child_near_hs_grad;
    SELF.Diff_db_cons_college_graduate := le.db_cons_college_graduate <> ri.db_cons_college_graduate;
    SELF.Diff_db_cons_intend_purchase_veh := le.db_cons_intend_purchase_veh <> ri.db_cons_intend_purchase_veh;
    SELF.Diff_db_cons_recent_divorce := le.db_cons_recent_divorce <> ri.db_cons_recent_divorce;
    SELF.Diff_db_cons_newlywed := le.db_cons_newlywed <> ri.db_cons_newlywed;
    SELF.Diff_db_cons_new_teen_driver := le.db_cons_new_teen_driver <> ri.db_cons_new_teen_driver;
    SELF.Diff_db_cons_home_year_built := le.db_cons_home_year_built <> ri.db_cons_home_year_built;
    SELF.Diff_db_cons_home_sqft_ranges := le.db_cons_home_sqft_ranges <> ri.db_cons_home_sqft_ranges;
    SELF.Diff_db_cons_poli_party_ind := le.db_cons_poli_party_ind <> ri.db_cons_poli_party_ind;
    SELF.Diff_db_cons_home_sqft_actual := le.db_cons_home_sqft_actual <> ri.db_cons_home_sqft_actual;
    SELF.Diff_db_cons_occupation_ind := le.db_cons_occupation_ind <> ri.db_cons_occupation_ind;
    SELF.Diff_db_cons_credit_card_user := le.db_cons_credit_card_user <> ri.db_cons_credit_card_user;
    SELF.Diff_db_cons_home_property_type := le.db_cons_home_property_type <> ri.db_cons_home_property_type;
    SELF.Diff_db_cons_education_hh := le.db_cons_education_hh <> ri.db_cons_education_hh;
    SELF.Diff_db_cons_education_ind := le.db_cons_education_ind <> ri.db_cons_education_ind;
    SELF.Diff_db_cons_other_pet_owner := le.db_cons_other_pet_owner <> ri.db_cons_other_pet_owner;
    SELF.Diff_businesstypedesc := le.businesstypedesc <> ri.businesstypedesc;
    SELF.Diff_genderdesc := le.genderdesc <> ri.genderdesc;
    SELF.Diff_executivetypedesc := le.executivetypedesc <> ri.executivetypedesc;
    SELF.Diff_dbconsgenderdesc := le.dbconsgenderdesc <> ri.dbconsgenderdesc;
    SELF.Diff_dbconsethnicdesc := le.dbconsethnicdesc <> ri.dbconsethnicdesc;
    SELF.Diff_dbconsreligiousdesc := le.dbconsreligiousdesc <> ri.dbconsreligiousdesc;
    SELF.Diff_dbconslangprefdesc := le.dbconslangprefdesc <> ri.dbconslangprefdesc;
    SELF.Diff_dbconsownerrenter := le.dbconsownerrenter <> ri.dbconsownerrenter;
    SELF.Diff_dbconsdwellingtypedesc := le.dbconsdwellingtypedesc <> ri.dbconsdwellingtypedesc;
    SELF.Diff_dbconsmaritaldesc := le.dbconsmaritaldesc <> ri.dbconsmaritaldesc;
    SELF.Diff_dbconsnewparentdesc := le.dbconsnewparentdesc <> ri.dbconsnewparentdesc;
    SELF.Diff_dbconsteendriverdesc := le.dbconsteendriverdesc <> ri.dbconsteendriverdesc;
    SELF.Diff_dbconspolipartydesc := le.dbconspolipartydesc <> ri.dbconspolipartydesc;
    SELF.Diff_dbconsoccupationdesc := le.dbconsoccupationdesc <> ri.dbconsoccupationdesc;
    SELF.Diff_dbconspropertytypedesc := le.dbconspropertytypedesc <> ri.dbconspropertytypedesc;
    SELF.Diff_dbconsheadhouseeducdesc := le.dbconsheadhouseeducdesc <> ri.dbconsheadhouseeducdesc;
    SELF.Diff_dbconseducationdesc := le.dbconseducationdesc <> ri.dbconseducationdesc;
    SELF.Diff_title := le.title <> ri.title;
    SELF.Diff_fname := le.fname <> ri.fname;
    SELF.Diff_mname := le.mname <> ri.mname;
    SELF.Diff_lname := le.lname <> ri.lname;
    SELF.Diff_name_score := le.name_score <> ri.name_score;
    SELF.Diff_phy_prim_range := le.phy_prim_range <> ri.phy_prim_range;
    SELF.Diff_phy_predir := le.phy_predir <> ri.phy_predir;
    SELF.Diff_phy_prim_name := le.phy_prim_name <> ri.phy_prim_name;
    SELF.Diff_phy_addr_suffix := le.phy_addr_suffix <> ri.phy_addr_suffix;
    SELF.Diff_phy_postdir := le.phy_postdir <> ri.phy_postdir;
    SELF.Diff_phy_unit_desig := le.phy_unit_desig <> ri.phy_unit_desig;
    SELF.Diff_phy_sec_range := le.phy_sec_range <> ri.phy_sec_range;
    SELF.Diff_phy_p_city_name := le.phy_p_city_name <> ri.phy_p_city_name;
    SELF.Diff_phy_v_city_name := le.phy_v_city_name <> ri.phy_v_city_name;
    SELF.Diff_phy_st := le.phy_st <> ri.phy_st;
    SELF.Diff_phy_cart := le.phy_cart <> ri.phy_cart;
    SELF.Diff_phy_cr_sort_sz := le.phy_cr_sort_sz <> ri.phy_cr_sort_sz;
    SELF.Diff_phy_lot := le.phy_lot <> ri.phy_lot;
    SELF.Diff_phy_lot_order := le.phy_lot_order <> ri.phy_lot_order;
    SELF.Diff_phy_dbpc := le.phy_dbpc <> ri.phy_dbpc;
    SELF.Diff_phy_chk_digit := le.phy_chk_digit <> ri.phy_chk_digit;
    SELF.Diff_phy_rec_type := le.phy_rec_type <> ri.phy_rec_type;
    SELF.Diff_phy_fips_state := le.phy_fips_state <> ri.phy_fips_state;
    SELF.Diff_phy_fips_county := le.phy_fips_county <> ri.phy_fips_county;
    SELF.Diff_phy_geo_lat := le.phy_geo_lat <> ri.phy_geo_lat;
    SELF.Diff_phy_geo_long := le.phy_geo_long <> ri.phy_geo_long;
    SELF.Diff_phy_msa := le.phy_msa <> ri.phy_msa;
    SELF.Diff_phy_geo_blk := le.phy_geo_blk <> ri.phy_geo_blk;
    SELF.Diff_phy_geo_match := le.phy_geo_match <> ri.phy_geo_match;
    SELF.Diff_phy_err_stat := le.phy_err_stat <> ri.phy_err_stat;
    SELF.Diff_phy_raw_aid := le.phy_raw_aid <> ri.phy_raw_aid;
    SELF.Diff_phy_ace_aid := le.phy_ace_aid <> ri.phy_ace_aid;
    SELF.Diff_phy_prep_address_line1 := le.phy_prep_address_line1 <> ri.phy_prep_address_line1;
    SELF.Diff_phy_prep_address_line_last := le.phy_prep_address_line_last <> ri.phy_prep_address_line_last;
		
	  SELF.Diff_mail_prim_range := le.mail_prim_range <> ri.mail_prim_range;
    SELF.Diff_mail_predir := le.mail_predir <> ri.mail_predir;
    SELF.Diff_mail_prim_name := le.mail_prim_name <> ri.mail_prim_name;
    SELF.Diff_mail_addr_suffix := le.mail_addr_suffix <> ri.mail_addr_suffix;
    SELF.Diff_mail_postdir := le.mail_postdir <> ri.mail_postdir;
    SELF.Diff_mail_unit_desig := le.mail_unit_desig <> ri.mail_unit_desig;
    SELF.Diff_mail_sec_range := le.mail_sec_range <> ri.mail_sec_range;
    SELF.Diff_mail_p_city_name := le.mail_p_city_name <> ri.mail_p_city_name;
    SELF.Diff_mail_v_city_name := le.mail_v_city_name <> ri.mail_v_city_name;
    SELF.Diff_mail_st := le.mail_st <> ri.mail_st;
    SELF.Diff_mail_cart := le.mail_cart <> ri.mail_cart;
    SELF.Diff_mail_cr_sort_sz := le.mail_cr_sort_sz <> ri.mail_cr_sort_sz;
    SELF.Diff_mail_lot := le.mail_lot <> ri.mail_lot;
    SELF.Diff_mail_lot_order := le.mail_lot_order <> ri.mail_lot_order;
    SELF.Diff_mail_dbpc := le.mail_dbpc <> ri.mail_dbpc;
    SELF.Diff_mail_chk_digit := le.mail_chk_digit <> ri.mail_chk_digit;
    SELF.Diff_mail_rec_type := le.mail_rec_type <> ri.mail_rec_type;
    SELF.Diff_mail_fips_state := le.mail_fips_state <> ri.mail_fips_state;
    SELF.Diff_mail_fips_county := le.mail_fips_county <> ri.mail_fips_county;
    SELF.Diff_mail_geo_lat := le.mail_geo_lat <> ri.mail_geo_lat;
    SELF.Diff_mail_geo_long := le.mail_geo_long <> ri.mail_geo_long;
    SELF.Diff_mail_msa := le.mail_msa <> ri.mail_msa;
    SELF.Diff_mail_geo_blk := le.mail_geo_blk <> ri.mail_geo_blk;
    SELF.Diff_mail_geo_match := le.mail_geo_match <> ri.mail_geo_match;
    SELF.Diff_mail_err_stat := le.mail_err_stat <> ri.mail_err_stat;
    SELF.Diff_mail_raw_aid := le.mail_raw_aid <> ri.mail_raw_aid;
    SELF.Diff_mail_ace_aid := le.mail_ace_aid <> ri.mail_ace_aid;
    SELF.Diff_mail_prep_address_line1 := le.mail_prep_address_line1 <> ri.mail_prep_address_line1;
    SELF.Diff_mail_prep_address_line_last := le.mail_prep_address_line_last <> ri.mail_prep_address_line_last;
		
		SELF.Diff_db_cons_prim_range := le.db_cons_prim_range <> ri.db_cons_prim_range;
    SELF.Diff_db_cons_predir := le.db_cons_predir <> ri.db_cons_predir;
    SELF.Diff_db_cons_prim_name := le.db_cons_prim_name <> ri.db_cons_prim_name;
    SELF.Diff_db_cons_addr_suffix := le.db_cons_addr_suffix <> ri.db_cons_addr_suffix;
    SELF.Diff_db_cons_postdir := le.db_cons_postdir <> ri.db_cons_postdir;
    SELF.Diff_db_cons_unit_desig := le.db_cons_unit_desig <> ri.db_cons_unit_desig;
    SELF.Diff_db_cons_sec_range := le.db_cons_sec_range <> ri.db_cons_sec_range;
    SELF.Diff_db_cons_p_city_name := le.db_cons_p_city_name <> ri.db_cons_p_city_name;
    SELF.Diff_db_cons_v_city_name := le.db_cons_v_city_name <> ri.db_cons_v_city_name;
    SELF.Diff_db_cons_st := le.db_cons_st <> ri.db_cons_st;
    SELF.Diff_db_cons_cart := le.db_cons_cart <> ri.db_cons_cart;
    SELF.Diff_db_cons_cr_sort_sz := le.db_cons_cr_sort_sz <> ri.db_cons_cr_sort_sz;
    SELF.Diff_db_cons_lot := le.db_cons_lot <> ri.db_cons_lot;
    SELF.Diff_db_cons_lot_order := le.db_cons_lot_order <> ri.db_cons_lot_order;
    SELF.Diff_db_cons_dbpc := le.db_cons_dbpc <> ri.db_cons_dbpc;
    SELF.Diff_db_cons_chk_digit := le.db_cons_chk_digit <> ri.db_cons_chk_digit;
    SELF.Diff_db_cons_rec_type := le.db_cons_rec_type <> ri.db_cons_rec_type;
    SELF.Diff_db_cons_fips_state := le.db_cons_fips_state <> ri.db_cons_fips_state;
    SELF.Diff_db_cons_fips_county := le.db_cons_fips_county <> ri.db_cons_fips_county;
    SELF.Diff_db_cons_geo_lat := le.db_cons_geo_lat <> ri.db_cons_geo_lat;
    SELF.Diff_db_cons_geo_long := le.db_cons_geo_long <> ri.db_cons_geo_long;
    SELF.Diff_db_cons_msa := le.db_cons_msa <> ri.db_cons_msa;
    SELF.Diff_db_cons_geo_blk := le.db_cons_geo_blk <> ri.db_cons_geo_blk;
    SELF.Diff_db_cons_geo_match := le.db_cons_geo_match <> ri.db_cons_geo_match;
    SELF.Diff_db_cons_err_stat := le.db_cons_err_stat <> ri.db_cons_err_stat;
    SELF.Diff_db_cons_raw_aid := le.db_cons_raw_aid <> ri.db_cons_raw_aid;
    SELF.Diff_db_cons_ace_aid := le.db_cons_ace_aid <> ri.db_cons_ace_aid;
    SELF.Diff_db_cons_prep_address_line1 := le.db_cons_prep_address_line1 <> ri.db_cons_prep_address_line1;
    SELF.Diff_db_cons_prep_address_line_last := le.db_cons_prep_address_line_last <> ri.db_cons_prep_address_line_last;
    SELF.Val := (SALT311.StrType)evaluate(le,pivot_exp);
    SELF.SourceField := le.source;
    SELF.Num_Diffs := 0+ 	IF( SELF.Diff_process_date,1,0)+ IF( SELF.Diff_dotid,1,0)+ 
													IF( SELF.Diff_dotscore,1,0)+ IF( SELF.Diff_dotweight,1,0)+ 
													IF( SELF.Diff_empid,1,0)+ IF( SELF.Diff_empscore,1,0)+ 
													IF( SELF.Diff_empweight,1,0)+ IF( SELF.Diff_powid,1,0)+ 
													IF( SELF.Diff_powscore,1,0)+ IF( SELF.Diff_powweight,1,0)+ 
													IF( SELF.Diff_proxid,1,0)+ IF( SELF.Diff_proxscore,1,0)+ 
													IF( SELF.Diff_proxweight,1,0)+ IF( SELF.Diff_selescore,1,0)+ 
													IF( SELF.Diff_seleweight,1,0)+ IF( SELF.Diff_orgid,1,0)+ 
													IF( SELF.Diff_orgscore,1,0)+ IF( SELF.Diff_orgweight,1,0)+ 
													IF( SELF.Diff_ultid,1,0)+ IF( SELF.Diff_ultscore,1,0)+ 
													IF( SELF.Diff_ultweight,1,0)+ IF( SELF.Diff_record_type,1,0)+ 
													IF( SELF.Diff_global_sid,1,0)+ IF( SELF.Diff_dbusa_business_id,1,0)+ 
													IF( SELF.Diff_dbusa_executive_id,1,0)+ IF( SELF.Diff_subhq_parent_id,1,0)+ 
													IF( SELF.Diff_hq_id,1,0)+ IF( SELF.Diff_ind_frm_indicator,1,0)+ 
													IF( SELF.Diff_company_name,1,0)+ IF( SELF.Diff_full_name,1,0)+ 
													IF( SELF.Diff_prefix,1,0)+ IF( SELF.Diff_first_name,1,0)+ 
													IF( SELF.Diff_middle_initial,1,0)+ IF( SELF.Diff_last_name,1,0)+ 
													IF( SELF.Diff_suffix,1,0)+ IF( SELF.Diff_gender,1,0)+ 
													IF( SELF.Diff_standardized_title,1,0)+ IF( SELF.Diff_sourcetitle,1,0)+ 
													IF( SELF.Diff_executive_title_rank,1,0)+ IF( SELF.Diff_primary_exec_flag,1,0)+ 
													IF( SELF.Diff_exec_type,1,0)+ IF( SELF.Diff_executive_department,1,0)+ 
													IF( SELF.Diff_executive_level,1,0)+ IF( SELF.Diff_phy_addr_standardized,1,0)+ 
													IF( SELF.Diff_phy_addr_city,1,0)+ IF( SELF.Diff_phy_addr_state,1,0)+ 
													IF( SELF.Diff_phy_addr_zip,1,0)+ IF( SELF.Diff_phy_addr_zip4,1,0)+ 
													IF( SELF.Diff_phy_addr_carrierroute,1,0)+ IF( SELF.Diff_phy_addr_deliverypt,1,0)+ 
													IF( SELF.Diff_phy_addr_deliveryptchkdig,1,0)+ IF( SELF.Diff_mail_addr_standardized,1,0)+ 
													IF( SELF.Diff_mail_addr_city,1,0)+ IF( SELF.Diff_mail_addr_state,1,0)+ 
													IF( SELF.Diff_mail_addr_zip,1,0)+ IF( SELF.Diff_mail_addr_zip4,1,0)+ 
													IF( SELF.Diff_mail_addr_carrierroute,1,0)+ IF( SELF.Diff_mail_addr_deliverypt,1,0)+ 
													IF( SELF.Diff_mail_addr_deliveryptchkdig,1,0)+ IF( SELF.Diff_mail_score,1,0)+ 
													IF( SELF.Diff_mail_score_desc,1,0)+ IF( SELF.Diff_phone,1,0)+ IF( SELF.Diff_area_code,1,0)+ 
													IF( SELF.Diff_fax,1,0)+ IF( SELF.Diff_email,1,0)+ 
													IF( SELF.Diff_email_available_indicator,1,0)+ IF( SELF.Diff_url,1,0)+ 
													IF( SELF.Diff_url_facebook,1,0)+ IF( SELF.Diff_url_googleplus,1,0)+ 
													IF( SELF.Diff_url_instagram,1,0)+ IF( SELF.Diff_url_linkedin,1,0)+ 
													IF( SELF.Diff_url_twitter,1,0)+ IF( SELF.Diff_url_youtube,1,0)+ 
													IF( SELF.Diff_business_status_code,1,0)+ IF( SELF.Diff_business_status_desc,1,0)+ 
													IF( SELF.Diff_franchise_flag,1,0)+ IF( SELF.Diff_franchise_type,1,0)+ 
													IF( SELF.Diff_franchise_desc,1,0)+ IF( SELF.Diff_ticker_symbol,1,0)+ 
													IF( SELF.Diff_stock_exchange,1,0)+ IF( SELF.Diff_fortune_1000_flag,1,0)+ 
													IF( SELF.Diff_fortune_1000_rank,1,0)+ IF( SELF.Diff_fortune_1000_branches,1,0)+ 
													IF( SELF.Diff_num_linked_locations,1,0)+ IF( SELF.Diff_county_code,1,0)+ 
													IF( SELF.Diff_county_desc,1,0)+ IF( SELF.Diff_cbsa_code,1,0)+ IF( SELF.Diff_cbsa_desc,1,0)+ 
													IF( SELF.Diff_geo_match_level,1,0)+ IF( SELF.Diff_latitude,1,0)+ 
													IF( SELF.Diff_longitude,1,0)+ IF( SELF.Diff_scf,1,0)+ IF( SELF.Diff_timezone,1,0)+ 
													IF( SELF.Diff_censustract,1,0)+ IF( SELF.Diff_censusblock,1,0)+ 
													IF( SELF.Diff_city_population_code,1,0)+ IF( SELF.Diff_city_population_descr,1,0)+ 
													IF( SELF.Diff_primary_sic,1,0)+ IF( SELF.Diff_primary_sic_desc,1,0)+ 
													IF( SELF.Diff_sic02,1,0)+ IF( SELF.Diff_sic02_desc,1,0)+ IF( SELF.Diff_sic03,1,0)+ 
													IF( SELF.Diff_sic03_desc,1,0)+ IF( SELF.Diff_sic04,1,0)+ IF( SELF.Diff_sic04_desc,1,0)+ 
													IF( SELF.Diff_sic05,1,0)+ IF( SELF.Diff_sic05_desc,1,0)+ IF( SELF.Diff_sic06,1,0)+ 
													IF( SELF.Diff_sic06_desc,1,0)+ IF( SELF.Diff_primarysic2,1,0)+ 
													IF( SELF.Diff_primary_2_digit_sic_desc,1,0)+ IF( SELF.Diff_primarysic4,1,0)+ 
													IF( SELF.Diff_primary_4_digit_sic_desc,1,0)+ IF( SELF.Diff_naics01,1,0)+ 
													IF( SELF.Diff_naics01_desc,1,0)+ IF( SELF.Diff_naics02,1,0)+ IF( SELF.Diff_naics02_desc,1,0)+ 
													IF( SELF.Diff_naics03,1,0)+ IF( SELF.Diff_naics03_desc,1,0)+ IF( SELF.Diff_naics04,1,0)+ 
													IF( SELF.Diff_naics04_desc,1,0)+ IF( SELF.Diff_naics05,1,0)+ IF( SELF.Diff_naics05_desc,1,0)+ 
													IF( SELF.Diff_naics06,1,0)+ IF( SELF.Diff_naics06_desc,1,0)+ 
													IF( SELF.Diff_location_employees_total,1,0)+ IF( SELF.Diff_location_employee_code,1,0)+ 
													IF( SELF.Diff_location_employee_desc,1,0)+ IF( SELF.Diff_location_sales_total,1,0)+ 
													IF( SELF.Diff_location_sales_code,1,0)+ IF( SELF.Diff_location_sales_desc,1,0)+ 
													IF( SELF.Diff_corporate_employee_total,1,0)+ IF( SELF.Diff_corporate_employee_code,1,0)+ 
													IF( SELF.Diff_corporate_employee_desc,1,0)+ IF( SELF.Diff_year_established,1,0)+ 
													IF( SELF.Diff_years_in_business_range,1,0)+ IF( SELF.Diff_female_owned,1,0)+ 
													IF( SELF.Diff_minority_owned_flag,1,0)+ IF( SELF.Diff_minority_type,1,0)+ 
													IF( SELF.Diff_home_based_indicator,1,0)+ IF( SELF.Diff_small_business_indicator,1,0)+ 
													IF( SELF.Diff_import_export,1,0)+ IF( SELF.Diff_manufacturing_location,1,0)+ 
													IF( SELF.Diff_public_indicator,1,0)+ IF( SELF.Diff_ein,1,0)+ 
													IF( SELF.Diff_non_profit_org,1,0)+ IF( SELF.Diff_square_footage,1,0)+ 
													IF( SELF.Diff_square_footage_code,1,0)+ IF( SELF.Diff_square_footage_desc,1,0)+ 
													IF( SELF.Diff_creditscore,1,0)+ IF( SELF.Diff_creditcode,1,0)+ 
													IF( SELF.Diff_credit_desc,1,0)+ IF( SELF.Diff_credit_capacity,1,0)+ 
													IF( SELF.Diff_credit_capacity_code,1,0)+ IF( SELF.Diff_credit_capacity_desc,1,0)+ 
													IF( SELF.Diff_advertising_expenses_code,1,0)+ IF( SELF.Diff_expense_advertising_desc,1,0)+ 
													IF( SELF.Diff_technology_expenses_code,1,0)+ IF( SELF.Diff_expense_technology_desc,1,0)+ 
													IF( SELF.Diff_office_equip_expenses_code,1,0)+ IF( SELF.Diff_expense_office_equip_desc,1,0)+ 
													IF( SELF.Diff_rent_expenses_code,1,0)+ IF( SELF.Diff_expense_rent_desc,1,0)+ 
													IF( SELF.Diff_telecom_expenses_code,1,0)+ IF( SELF.Diff_expense_telecom_desc,1,0)+ 
													IF( SELF.Diff_accounting_expenses_code,1,0)+ IF( SELF.Diff_expense_accounting_desc,1,0)+ 
													IF( SELF.Diff_bus_insurance_expense_code,1,0)+ IF( SELF.Diff_expense_bus_insurance_desc,1,0)+ 
													IF( SELF.Diff_legal_expenses_code,1,0)+ IF( SELF.Diff_expense_legal_desc,1,0)+ 
													IF( SELF.Diff_utilities_expenses_code,1,0)+ IF( SELF.Diff_expense_utilities_desc,1,0)+ 
													IF( SELF.Diff_number_of_pcs_code,1,0)+ IF( SELF.Diff_number_of_pcs_desc,1,0)+ 
													IF( SELF.Diff_nb_flag,1,0)+ IF( SELF.Diff_hq_company_name,1,0)+ IF( SELF.Diff_hq_city,1,0)+ 
													IF( SELF.Diff_hq_state,1,0)+ IF( SELF.Diff_subhq_parent_name,1,0)+ 
													IF( SELF.Diff_subhq_parent_city,1,0)+ IF( SELF.Diff_subhq_parent_state,1,0)+ 
													IF( SELF.Diff_domestic_foreign_owner_flag,1,0)+ IF( SELF.Diff_foreign_parent_company_name,1,0)+ 
													IF( SELF.Diff_foreign_parent_city,1,0)+ IF( SELF.Diff_foreign_parent_country,1,0)+ 
													IF( SELF.Diff_db_cons_matchkey,1,0)+ IF( SELF.Diff_databaseusa_individual_id,1,0)+ 
													IF( SELF.Diff_db_cons_full_name,1,0)+ IF( SELF.Diff_db_cons_full_name_prefix,1,0)+ 
													IF( SELF.Diff_db_cons_first_name,1,0)+ IF( SELF.Diff_db_cons_middle_initial,1,0)+ 
													IF( SELF.Diff_db_cons_last_name,1,0)+ IF( SELF.Diff_db_cons_email,1,0)+ 
													IF( SELF.Diff_db_cons_gender,1,0)+ IF( SELF.Diff_db_cons_date_of_birth_year,1,0)+ 
													IF( SELF.Diff_db_cons_date_of_birth_month,1,0)+ IF( SELF.Diff_db_cons_age,1,0)+ 
													IF( SELF.Diff_db_cons_age_code_desc,1,0)+ IF( SELF.Diff_db_cons_age_in_two_year_hh,1,0)+ 
													IF( SELF.Diff_db_cons_ethnic_code,1,0)+ IF( SELF.Diff_db_cons_religious_affil,1,0)+ 
													IF( SELF.Diff_db_cons_language_pref,1,0)+ IF( SELF.Diff_db_cons_phy_addr_std,1,0)+ 
													IF( SELF.Diff_db_cons_phy_addr_city,1,0)+ IF( SELF.Diff_db_cons_phy_addr_state,1,0)+ 
													IF( SELF.Diff_db_cons_phy_addr_zip,1,0)+ IF( SELF.Diff_db_cons_phy_addr_zip4,1,0)+ 
													IF( SELF.Diff_db_cons_phy_addr_carrierroute,1,0)+ 
													IF( SELF.Diff_db_cons_phy_addr_deliverypt,1,0)+ 
													IF( SELF.Diff_db_cons_line_of_travel,1,0)+ IF( SELF.Diff_db_cons_geocode_results,1,0)+ 
													IF( SELF.Diff_db_cons_latitude,1,0)+ IF( SELF.Diff_db_cons_longitude,1,0)+ 
													IF( SELF.Diff_db_cons_time_zone_code,1,0)+ IF( SELF.Diff_db_cons_time_zone_desc,1,0)+ 
													IF( SELF.Diff_db_cons_census_tract,1,0)+ IF( SELF.Diff_db_cons_census_block,1,0)+ 
													IF( SELF.Diff_db_cons_countyfips,1,0)+ IF( SELF.Diff_db_countyname,1,0)+ 
													IF( SELF.Diff_db_cons_cbsa_code,1,0)+ IF( SELF.Diff_db_cons_cbsa_desc,1,0)+ 
													IF( SELF.Diff_db_cons_walk_sequence,1,0)+ IF( SELF.Diff_db_cons_phone,1,0)+ 
													IF( SELF.Diff_db_cons_dnc,1,0)+ IF( SELF.Diff_db_cons_scrubbed_phoneable,1,0)+ 
													IF( SELF.Diff_db_cons_children_present,1,0)+ IF( SELF.Diff_db_cons_home_value_code,1,0)+ 
													IF( SELF.Diff_db_cons_home_value_desc,1,0)+ IF( SELF.Diff_db_cons_donor_capacity,1,0)+ 
													IF( SELF.Diff_db_cons_donor_capacity_code,1,0)+ IF( SELF.Diff_db_cons_donor_capacity_desc,1,0)+ 
													IF( SELF.Diff_db_cons_home_owner_renter,1,0)+ IF( SELF.Diff_db_cons_length_of_res,1,0)+ 
													IF( SELF.Diff_db_cons_length_of_res_code,1,0)+ IF( SELF.Diff_db_cons_length_of_res_desc,1,0)+ 
													IF( SELF.Diff_db_cons_dwelling_type,1,0)+ IF( SELF.Diff_db_cons_recent_home_buyer,1,0)+ 
													IF( SELF.Diff_db_cons_income_code,1,0)+ IF( SELF.Diff_db_cons_income_desc,1,0)+ 
													IF( SELF.Diff_db_cons_unsecuredcredcap,1,0)+ IF( SELF.Diff_db_cons_unsecuredcredcapcode,1,0)+
													IF( SELF.Diff_db_cons_unsecuredcredcapdesc,1,0)+ IF( SELF.Diff_db_cons_networthhomeval,1,0)+ 
													IF( SELF.Diff_db_cons_networthhomevalcode,1,0)+ IF( SELF.Diff_db_cons_net_worth_desc,1,0)+ 
													IF( SELF.Diff_db_cons_discretincome,1,0)+ IF( SELF.Diff_db_cons_discretincomecode,1,0)+ 
													IF( SELF.Diff_db_cons_discretincomedesc,1,0)+ IF( SELF.Diff_db_cons_marital_status,1,0)+ 
													IF( SELF.Diff_db_cons_new_parent,1,0)+ IF( SELF.Diff_db_cons_child_near_hs_grad,1,0)+ 
													IF( SELF.Diff_db_cons_college_graduate,1,0)+ IF( SELF.Diff_db_cons_intend_purchase_veh,1,0)+ 
													IF( SELF.Diff_db_cons_recent_divorce,1,0)+ IF( SELF.Diff_db_cons_newlywed,1,0)+ 
													IF( SELF.Diff_db_cons_new_teen_driver,1,0)+ IF( SELF.Diff_db_cons_home_year_built,1,0)+ 
													IF( SELF.Diff_db_cons_home_sqft_ranges,1,0)+ IF( SELF.Diff_db_cons_poli_party_ind,1,0)+ 
													IF( SELF.Diff_db_cons_home_sqft_actual,1,0)+ IF( SELF.Diff_db_cons_occupation_ind,1,0)+ 
													IF( SELF.Diff_db_cons_credit_card_user,1,0)+ IF( SELF.Diff_db_cons_home_property_type,1,0)+ 
													IF( SELF.Diff_db_cons_education_hh,1,0)+ IF( SELF.Diff_db_cons_education_ind,1,0)+ 
													IF( SELF.Diff_db_cons_other_pet_owner,1,0)+ IF( SELF.Diff_businesstypedesc,1,0)+ 
													IF( SELF.Diff_genderdesc,1,0)+ IF( SELF.Diff_executivetypedesc,1,0)+ 
													IF( SELF.Diff_dbconsgenderdesc,1,0)+ IF( SELF.Diff_dbconsethnicdesc,1,0)+ 
													IF( SELF.Diff_dbconsreligiousdesc,1,0)+ IF( SELF.Diff_dbconslangprefdesc,1,0)+ 
													IF( SELF.Diff_dbconsownerrenter,1,0)+ IF( SELF.Diff_dbconsdwellingtypedesc,1,0)+ 
													IF( SELF.Diff_dbconsmaritaldesc,1,0)+ IF( SELF.Diff_dbconsnewparentdesc,1,0)+ 
													IF( SELF.Diff_dbconsteendriverdesc,1,0)+ IF( SELF.Diff_dbconspolipartydesc,1,0)+ 
													IF( SELF.Diff_dbconsoccupationdesc,1,0)+ IF( SELF.Diff_dbconspropertytypedesc,1,0)+ 
													IF( SELF.Diff_dbconsheadhouseeducdesc,1,0)+ IF( SELF.Diff_dbconseducationdesc,1,0)+ 
													IF( SELF.Diff_title,1,0)+ IF( SELF.Diff_fname,1,0)+ IF( SELF.Diff_mname,1,0)+ 
													IF( SELF.Diff_lname,1,0)+ IF( SELF.Diff_name_score,1,0)+ IF( SELF.Diff_phy_prim_range,1,0)+ 
													IF( SELF.Diff_phy_predir,1,0)+ IF( SELF.Diff_phy_prim_name,1,0)+ 
													IF( SELF.Diff_phy_addr_suffix,1,0)+ IF( SELF.Diff_phy_postdir,1,0)+ 
													IF( SELF.Diff_phy_unit_desig,1,0)+ IF( SELF.Diff_phy_sec_range,1,0)+ 
													IF( SELF.Diff_phy_p_city_name,1,0)+ IF( SELF.Diff_phy_v_city_name,1,0)+ 
													IF( SELF.Diff_phy_st,1,0)+ IF( SELF.Diff_phy_cart,1,0)+ IF( SELF.Diff_phy_cr_sort_sz,1,0)+ 
													IF( SELF.Diff_phy_lot,1,0)+ IF( SELF.Diff_phy_lot_order,1,0)+ IF( SELF.Diff_phy_dbpc,1,0)+ 
													IF( SELF.Diff_phy_chk_digit,1,0)+ IF( SELF.Diff_phy_rec_type,1,0)+ 
													IF( SELF.Diff_phy_fips_state,1,0)+ IF( SELF.Diff_phy_fips_county,1,0)+ 
													IF( SELF.Diff_phy_geo_lat,1,0)+ IF( SELF.Diff_phy_geo_long,1,0)+ IF( SELF.Diff_phy_msa,1,0)+ 
													IF( SELF.Diff_phy_geo_blk,1,0)+ IF( SELF.Diff_phy_geo_match,1,0)+ 
													IF( SELF.Diff_phy_err_stat,1,0)+ IF( SELF.Diff_phy_raw_aid,1,0)+ 
													IF( SELF.Diff_phy_ace_aid,1,0)+ IF( SELF.Diff_phy_prep_address_line1,1,0)+ 
													IF( SELF.Diff_phy_prep_address_line_last,1,0) +	IF( SELF.Diff_mail_prim_range,1,0)+ 
													IF( SELF.Diff_mail_predir,1,0)+ IF( SELF.Diff_mail_prim_name,1,0)+ 
													IF( SELF.Diff_mail_addr_suffix,1,0)+ IF( SELF.Diff_mail_postdir,1,0)+ 
													IF( SELF.Diff_mail_unit_desig,1,0)+ IF( SELF.Diff_mail_sec_range,1,0)+ 
													IF( SELF.Diff_mail_p_city_name,1,0)+ IF( SELF.Diff_mail_v_city_name,1,0)+ 
													IF( SELF.Diff_mail_st,1,0)+ IF( SELF.Diff_mail_cart,1,0)+ IF( SELF.Diff_mail_cr_sort_sz,1,0)+ 
													IF( SELF.Diff_mail_lot,1,0)+ IF( SELF.Diff_mail_lot_order,1,0)+ IF( SELF.Diff_mail_dbpc,1,0)+ 
													IF( SELF.Diff_mail_chk_digit,1,0)+ IF( SELF.Diff_mail_rec_type,1,0)+ 
													IF( SELF.Diff_mail_fips_state,1,0)+ IF( SELF.Diff_mail_fips_county,1,0)+ 
													IF( SELF.Diff_mail_geo_lat,1,0)+ IF( SELF.Diff_mail_geo_long,1,0)+ 
													IF( SELF.Diff_mail_msa,1,0)+ IF( SELF.Diff_mail_geo_blk,1,0)+ 
													IF( SELF.Diff_mail_geo_match,1,0)+ IF( SELF.Diff_mail_err_stat,1,0)+ 
													IF( SELF.Diff_mail_raw_aid,1,0)+ IF( SELF.Diff_mail_ace_aid,1,0)+ 
													IF( SELF.Diff_mail_prep_address_line1,1,0)+ IF( SELF.Diff_mail_prep_address_line_last,1,0) +
													IF( SELF.Diff_db_cons_prim_range,1,0)+ IF( SELF.Diff_db_cons_predir,1,0)+ 
													IF( SELF.Diff_db_cons_prim_name,1,0)+ IF( SELF.Diff_db_cons_addr_suffix,1,0)+ 
													IF( SELF.Diff_db_cons_postdir,1,0)+ IF( SELF.Diff_db_cons_unit_desig,1,0)+ 
													IF( SELF.Diff_db_cons_sec_range,1,0)+ IF( SELF.Diff_db_cons_p_city_name,1,0)+ 
													IF( SELF.Diff_db_cons_v_city_name,1,0)+ IF( SELF.Diff_db_cons_st,1,0)+ 
													IF( SELF.Diff_db_cons_cart,1,0)+ IF( SELF.Diff_db_cons_cr_sort_sz,1,0)+ 
													IF( SELF.Diff_db_cons_lot,1,0)+ IF( SELF.Diff_db_cons_lot_order,1,0)+ 
													IF( SELF.Diff_db_cons_dbpc,1,0)+ IF( SELF.Diff_db_cons_chk_digit,1,0)+ 
													IF( SELF.Diff_db_cons_rec_type,1,0)+ IF( SELF.Diff_db_cons_fips_state,1,0)+ 
													IF( SELF.Diff_db_cons_fips_county,1,0)+ IF( SELF.Diff_db_cons_geo_lat,1,0)+ 
													IF( SELF.Diff_db_cons_geo_long,1,0)+ IF( SELF.Diff_db_cons_msa,1,0)+ 
													IF( SELF.Diff_db_cons_geo_blk,1,0)+ IF( SELF.Diff_db_cons_geo_match,1,0)+ 
													IF( SELF.Diff_db_cons_err_stat,1,0)+ IF( SELF.Diff_db_cons_raw_aid,1,0)+ 
													IF( SELF.Diff_db_cons_ace_aid,1,0)+ IF( SELF.Diff_db_cons_prep_address_line1,1,0)+ 
													IF( SELF.Diff_db_cons_prep_address_line_last,1,0);
  END;
// Now need to remove bad pivots from comparison
#uniquename(L)
  %L% := JOIN(in_left,bad_pivots,evaluate(LEFT,pivot_exp)=right.val,transform(left),left only,lookup);
#uniquename(R)
  %R% := JOIN(in_right,bad_pivots,evaluate(LEFT,pivot_exp)=right.val,transform(left),left only,lookup);
#uniquename(DiffL)
  %DiffL% := JOIN(%L%,%R%,evaluate(left,pivot_exp)=evaluate(right,pivot_exp),%fd%(left,right),hash);
#uniquename(Closest)
  %Closest% := DEDUP(SORT(%DiffL%,Val,Num_Diffs,local),Val,local); // Join will have distributed by pivot_exp
#uniquename(AggRec)
  %AggRec% := RECORD
    Count_Diff_dt_first_seen := COUNT(GROUP,%Closest%.Diff_dt_first_seen);
    Count_Diff_dt_last_seen := COUNT(GROUP,%Closest%.Diff_dt_last_seen);
    Count_Diff_dt_vendor_first_reported := COUNT(GROUP,%Closest%.Diff_dt_vendor_first_reported);
    Count_Diff_dt_vendor_last_reported := COUNT(GROUP,%Closest%.Diff_dt_vendor_last_reported);
    Count_Diff_process_date := COUNT(GROUP,%Closest%.Diff_process_date);
    Count_Diff_dotid := COUNT(GROUP,%Closest%.Diff_dotid);
    Count_Diff_dotscore := COUNT(GROUP,%Closest%.Diff_dotscore);
    Count_Diff_dotweight := COUNT(GROUP,%Closest%.Diff_dotweight);
    Count_Diff_empid := COUNT(GROUP,%Closest%.Diff_empid);
    Count_Diff_empscore := COUNT(GROUP,%Closest%.Diff_empscore);
    Count_Diff_empweight := COUNT(GROUP,%Closest%.Diff_empweight);
    Count_Diff_powid := COUNT(GROUP,%Closest%.Diff_powid);
    Count_Diff_powscore := COUNT(GROUP,%Closest%.Diff_powscore);
    Count_Diff_powweight := COUNT(GROUP,%Closest%.Diff_powweight);
    Count_Diff_proxid := COUNT(GROUP,%Closest%.Diff_proxid);
    Count_Diff_proxscore := COUNT(GROUP,%Closest%.Diff_proxscore);
    Count_Diff_proxweight := COUNT(GROUP,%Closest%.Diff_proxweight);
    Count_Diff_selescore := COUNT(GROUP,%Closest%.Diff_selescore);
    Count_Diff_seleweight := COUNT(GROUP,%Closest%.Diff_seleweight);
    Count_Diff_orgid := COUNT(GROUP,%Closest%.Diff_orgid);
    Count_Diff_orgscore := COUNT(GROUP,%Closest%.Diff_orgscore);
    Count_Diff_orgweight := COUNT(GROUP,%Closest%.Diff_orgweight);
    Count_Diff_ultid := COUNT(GROUP,%Closest%.Diff_ultid);
    Count_Diff_ultscore := COUNT(GROUP,%Closest%.Diff_ultscore);
    Count_Diff_ultweight := COUNT(GROUP,%Closest%.Diff_ultweight);
    Count_Diff_record_type := COUNT(GROUP,%Closest%.Diff_record_type);
    Count_Diff_global_sid := COUNT(GROUP,%Closest%.Diff_global_sid);
    Count_Diff_dbusa_business_id := COUNT(GROUP,%Closest%.Diff_dbusa_business_id);
    Count_Diff_dbusa_executive_id := COUNT(GROUP,%Closest%.Diff_dbusa_executive_id);
    Count_Diff_subhq_parent_id := COUNT(GROUP,%Closest%.Diff_subhq_parent_id);
    Count_Diff_hq_id := COUNT(GROUP,%Closest%.Diff_hq_id);
    Count_Diff_ind_frm_indicator := COUNT(GROUP,%Closest%.Diff_ind_frm_indicator);
    Count_Diff_company_name := COUNT(GROUP,%Closest%.Diff_company_name);
    Count_Diff_full_name := COUNT(GROUP,%Closest%.Diff_full_name);
    Count_Diff_prefix := COUNT(GROUP,%Closest%.Diff_prefix);
    Count_Diff_first_name := COUNT(GROUP,%Closest%.Diff_first_name);
    Count_Diff_middle_initial := COUNT(GROUP,%Closest%.Diff_middle_initial);
    Count_Diff_last_name := COUNT(GROUP,%Closest%.Diff_last_name);
    Count_Diff_suffix := COUNT(GROUP,%Closest%.Diff_suffix);
    Count_Diff_gender := COUNT(GROUP,%Closest%.Diff_gender);
    Count_Diff_standardized_title := COUNT(GROUP,%Closest%.Diff_standardized_title);
    Count_Diff_sourcetitle := COUNT(GROUP,%Closest%.Diff_sourcetitle);
    Count_Diff_executive_title_rank := COUNT(GROUP,%Closest%.Diff_executive_title_rank);
    Count_Diff_primary_exec_flag := COUNT(GROUP,%Closest%.Diff_primary_exec_flag);
    Count_Diff_exec_type := COUNT(GROUP,%Closest%.Diff_exec_type);
    Count_Diff_executive_department := COUNT(GROUP,%Closest%.Diff_executive_department);
    Count_Diff_executive_level := COUNT(GROUP,%Closest%.Diff_executive_level);
    Count_Diff_phy_addr_standardized := COUNT(GROUP,%Closest%.Diff_phy_addr_standardized);
    Count_Diff_phy_addr_city := COUNT(GROUP,%Closest%.Diff_phy_addr_city);
    Count_Diff_phy_addr_state := COUNT(GROUP,%Closest%.Diff_phy_addr_state);
    Count_Diff_phy_addr_zip := COUNT(GROUP,%Closest%.Diff_phy_addr_zip);
    Count_Diff_phy_addr_zip4 := COUNT(GROUP,%Closest%.Diff_phy_addr_zip4);
    Count_Diff_phy_addr_carrierroute := COUNT(GROUP,%Closest%.Diff_phy_addr_carrierroute);
    Count_Diff_phy_addr_deliverypt := COUNT(GROUP,%Closest%.Diff_phy_addr_deliverypt);
    Count_Diff_phy_addr_deliveryptchkdig := COUNT(GROUP,%Closest%.Diff_phy_addr_deliveryptchkdig);
    Count_Diff_mail_addr_standardized := COUNT(GROUP,%Closest%.Diff_mail_addr_standardized);
    Count_Diff_mail_addr_city := COUNT(GROUP,%Closest%.Diff_mail_addr_city);
    Count_Diff_mail_addr_state := COUNT(GROUP,%Closest%.Diff_mail_addr_state);
    Count_Diff_mail_addr_zip := COUNT(GROUP,%Closest%.Diff_mail_addr_zip);
    Count_Diff_mail_addr_zip4 := COUNT(GROUP,%Closest%.Diff_mail_addr_zip4);
    Count_Diff_mail_addr_carrierroute := COUNT(GROUP,%Closest%.Diff_mail_addr_carrierroute);
    Count_Diff_mail_addr_deliverypt := COUNT(GROUP,%Closest%.Diff_mail_addr_deliverypt);
    Count_Diff_mail_addr_deliveryptchkdig := COUNT(GROUP,%Closest%.Diff_mail_addr_deliveryptchkdig);
    Count_Diff_mail_score := COUNT(GROUP,%Closest%.Diff_mail_score);
    Count_Diff_mail_score_desc := COUNT(GROUP,%Closest%.Diff_mail_score_desc);
    Count_Diff_phone := COUNT(GROUP,%Closest%.Diff_phone);
    Count_Diff_area_code := COUNT(GROUP,%Closest%.Diff_area_code);
    Count_Diff_fax := COUNT(GROUP,%Closest%.Diff_fax);
    Count_Diff_email := COUNT(GROUP,%Closest%.Diff_email);
    Count_Diff_email_available_indicator := COUNT(GROUP,%Closest%.Diff_email_available_indicator);
    Count_Diff_url := COUNT(GROUP,%Closest%.Diff_url);
    Count_Diff_url_facebook := COUNT(GROUP,%Closest%.Diff_url_facebook);
    Count_Diff_url_googleplus := COUNT(GROUP,%Closest%.Diff_url_googleplus);
    Count_Diff_url_instagram := COUNT(GROUP,%Closest%.Diff_url_instagram);
    Count_Diff_url_linkedin := COUNT(GROUP,%Closest%.Diff_url_linkedin);
    Count_Diff_url_twitter := COUNT(GROUP,%Closest%.Diff_url_twitter);
    Count_Diff_url_youtube := COUNT(GROUP,%Closest%.Diff_url_youtube);
    Count_Diff_business_status_code := COUNT(GROUP,%Closest%.Diff_business_status_code);
    Count_Diff_business_status_desc := COUNT(GROUP,%Closest%.Diff_business_status_desc);
    Count_Diff_franchise_flag := COUNT(GROUP,%Closest%.Diff_franchise_flag);
    Count_Diff_franchise_type := COUNT(GROUP,%Closest%.Diff_franchise_type);
    Count_Diff_franchise_desc := COUNT(GROUP,%Closest%.Diff_franchise_desc);
    Count_Diff_ticker_symbol := COUNT(GROUP,%Closest%.Diff_ticker_symbol);
    Count_Diff_stock_exchange := COUNT(GROUP,%Closest%.Diff_stock_exchange);
    Count_Diff_fortune_1000_flag := COUNT(GROUP,%Closest%.Diff_fortune_1000_flag);
    Count_Diff_fortune_1000_rank := COUNT(GROUP,%Closest%.Diff_fortune_1000_rank);
    Count_Diff_fortune_1000_branches := COUNT(GROUP,%Closest%.Diff_fortune_1000_branches);
    Count_Diff_num_linked_locations := COUNT(GROUP,%Closest%.Diff_num_linked_locations);
    Count_Diff_county_code := COUNT(GROUP,%Closest%.Diff_county_code);
    Count_Diff_county_desc := COUNT(GROUP,%Closest%.Diff_county_desc);
    Count_Diff_cbsa_code := COUNT(GROUP,%Closest%.Diff_cbsa_code);
    Count_Diff_cbsa_desc := COUNT(GROUP,%Closest%.Diff_cbsa_desc);
    Count_Diff_geo_match_level := COUNT(GROUP,%Closest%.Diff_geo_match_level);
    Count_Diff_latitude := COUNT(GROUP,%Closest%.Diff_latitude);
    Count_Diff_longitude := COUNT(GROUP,%Closest%.Diff_longitude);
    Count_Diff_scf := COUNT(GROUP,%Closest%.Diff_scf);
    Count_Diff_timezone := COUNT(GROUP,%Closest%.Diff_timezone);
    Count_Diff_censustract := COUNT(GROUP,%Closest%.Diff_censustract);
    Count_Diff_censusblock := COUNT(GROUP,%Closest%.Diff_censusblock);
    Count_Diff_city_population_code := COUNT(GROUP,%Closest%.Diff_city_population_code);
    Count_Diff_city_population_descr := COUNT(GROUP,%Closest%.Diff_city_population_descr);
    Count_Diff_primary_sic := COUNT(GROUP,%Closest%.Diff_primary_sic);
    Count_Diff_primary_sic_desc := COUNT(GROUP,%Closest%.Diff_primary_sic_desc);
    Count_Diff_sic02 := COUNT(GROUP,%Closest%.Diff_sic02);
    Count_Diff_sic02_desc := COUNT(GROUP,%Closest%.Diff_sic02_desc);
    Count_Diff_sic03 := COUNT(GROUP,%Closest%.Diff_sic03);
    Count_Diff_sic03_desc := COUNT(GROUP,%Closest%.Diff_sic03_desc);
    Count_Diff_sic04 := COUNT(GROUP,%Closest%.Diff_sic04);
    Count_Diff_sic04_desc := COUNT(GROUP,%Closest%.Diff_sic04_desc);
    Count_Diff_sic05 := COUNT(GROUP,%Closest%.Diff_sic05);
    Count_Diff_sic05_desc := COUNT(GROUP,%Closest%.Diff_sic05_desc);
    Count_Diff_sic06 := COUNT(GROUP,%Closest%.Diff_sic06);
    Count_Diff_sic06_desc := COUNT(GROUP,%Closest%.Diff_sic06_desc);
    Count_Diff_primarysic2 := COUNT(GROUP,%Closest%.Diff_primarysic2);
    Count_Diff_primary_2_digit_sic_desc := COUNT(GROUP,%Closest%.Diff_primary_2_digit_sic_desc);
    Count_Diff_primarysic4 := COUNT(GROUP,%Closest%.Diff_primarysic4);
    Count_Diff_primary_4_digit_sic_desc := COUNT(GROUP,%Closest%.Diff_primary_4_digit_sic_desc);
    Count_Diff_naics01 := COUNT(GROUP,%Closest%.Diff_naics01);
    Count_Diff_naics01_desc := COUNT(GROUP,%Closest%.Diff_naics01_desc);
    Count_Diff_naics02 := COUNT(GROUP,%Closest%.Diff_naics02);
    Count_Diff_naics02_desc := COUNT(GROUP,%Closest%.Diff_naics02_desc);
    Count_Diff_naics03 := COUNT(GROUP,%Closest%.Diff_naics03);
    Count_Diff_naics03_desc := COUNT(GROUP,%Closest%.Diff_naics03_desc);
    Count_Diff_naics04 := COUNT(GROUP,%Closest%.Diff_naics04);
    Count_Diff_naics04_desc := COUNT(GROUP,%Closest%.Diff_naics04_desc);
    Count_Diff_naics05 := COUNT(GROUP,%Closest%.Diff_naics05);
    Count_Diff_naics05_desc := COUNT(GROUP,%Closest%.Diff_naics05_desc);
    Count_Diff_naics06 := COUNT(GROUP,%Closest%.Diff_naics06);
    Count_Diff_naics06_desc := COUNT(GROUP,%Closest%.Diff_naics06_desc);
    Count_Diff_location_employees_total := COUNT(GROUP,%Closest%.Diff_location_employees_total);
    Count_Diff_location_employee_code := COUNT(GROUP,%Closest%.Diff_location_employee_code);
    Count_Diff_location_employee_desc := COUNT(GROUP,%Closest%.Diff_location_employee_desc);
    Count_Diff_location_sales_total := COUNT(GROUP,%Closest%.Diff_location_sales_total);
    Count_Diff_location_sales_code := COUNT(GROUP,%Closest%.Diff_location_sales_code);
    Count_Diff_location_sales_desc := COUNT(GROUP,%Closest%.Diff_location_sales_desc);
    Count_Diff_corporate_employee_total := COUNT(GROUP,%Closest%.Diff_corporate_employee_total);
    Count_Diff_corporate_employee_code := COUNT(GROUP,%Closest%.Diff_corporate_employee_code);
    Count_Diff_corporate_employee_desc := COUNT(GROUP,%Closest%.Diff_corporate_employee_desc);
    Count_Diff_year_established := COUNT(GROUP,%Closest%.Diff_year_established);
    Count_Diff_years_in_business_range := COUNT(GROUP,%Closest%.Diff_years_in_business_range);
    Count_Diff_female_owned := COUNT(GROUP,%Closest%.Diff_female_owned);
    Count_Diff_minority_owned_flag := COUNT(GROUP,%Closest%.Diff_minority_owned_flag);
    Count_Diff_minority_type := COUNT(GROUP,%Closest%.Diff_minority_type);
    Count_Diff_home_based_indicator := COUNT(GROUP,%Closest%.Diff_home_based_indicator);
    Count_Diff_small_business_indicator := COUNT(GROUP,%Closest%.Diff_small_business_indicator);
    Count_Diff_import_export := COUNT(GROUP,%Closest%.Diff_import_export);
    Count_Diff_manufacturing_location := COUNT(GROUP,%Closest%.Diff_manufacturing_location);
    Count_Diff_public_indicator := COUNT(GROUP,%Closest%.Diff_public_indicator);
    Count_Diff_ein := COUNT(GROUP,%Closest%.Diff_ein);
    Count_Diff_non_profit_org := COUNT(GROUP,%Closest%.Diff_non_profit_org);
    Count_Diff_square_footage := COUNT(GROUP,%Closest%.Diff_square_footage);
    Count_Diff_square_footage_code := COUNT(GROUP,%Closest%.Diff_square_footage_code);
    Count_Diff_square_footage_desc := COUNT(GROUP,%Closest%.Diff_square_footage_desc);
    Count_Diff_creditscore := COUNT(GROUP,%Closest%.Diff_creditscore);
    Count_Diff_creditcode := COUNT(GROUP,%Closest%.Diff_creditcode);
    Count_Diff_credit_desc := COUNT(GROUP,%Closest%.Diff_credit_desc);
    Count_Diff_credit_capacity := COUNT(GROUP,%Closest%.Diff_credit_capacity);
    Count_Diff_credit_capacity_code := COUNT(GROUP,%Closest%.Diff_credit_capacity_code);
    Count_Diff_credit_capacity_desc := COUNT(GROUP,%Closest%.Diff_credit_capacity_desc);
    Count_Diff_advertising_expenses_code := COUNT(GROUP,%Closest%.Diff_advertising_expenses_code);
    Count_Diff_expense_advertising_desc := COUNT(GROUP,%Closest%.Diff_expense_advertising_desc);
    Count_Diff_technology_expenses_code := COUNT(GROUP,%Closest%.Diff_technology_expenses_code);
    Count_Diff_expense_technology_desc := COUNT(GROUP,%Closest%.Diff_expense_technology_desc);
    Count_Diff_office_equip_expenses_code := COUNT(GROUP,%Closest%.Diff_office_equip_expenses_code);
    Count_Diff_expense_office_equip_desc := COUNT(GROUP,%Closest%.Diff_expense_office_equip_desc);
    Count_Diff_rent_expenses_code := COUNT(GROUP,%Closest%.Diff_rent_expenses_code);
    Count_Diff_expense_rent_desc := COUNT(GROUP,%Closest%.Diff_expense_rent_desc);
    Count_Diff_telecom_expenses_code := COUNT(GROUP,%Closest%.Diff_telecom_expenses_code);
    Count_Diff_expense_telecom_desc := COUNT(GROUP,%Closest%.Diff_expense_telecom_desc);
    Count_Diff_accounting_expenses_code := COUNT(GROUP,%Closest%.Diff_accounting_expenses_code);
    Count_Diff_expense_accounting_desc := COUNT(GROUP,%Closest%.Diff_expense_accounting_desc);
    Count_Diff_bus_insurance_expense_code := COUNT(GROUP,%Closest%.Diff_bus_insurance_expense_code);
    Count_Diff_expense_bus_insurance_desc := COUNT(GROUP,%Closest%.Diff_expense_bus_insurance_desc);
    Count_Diff_legal_expenses_code := COUNT(GROUP,%Closest%.Diff_legal_expenses_code);
    Count_Diff_expense_legal_desc := COUNT(GROUP,%Closest%.Diff_expense_legal_desc);
    Count_Diff_utilities_expenses_code := COUNT(GROUP,%Closest%.Diff_utilities_expenses_code);
    Count_Diff_expense_utilities_desc := COUNT(GROUP,%Closest%.Diff_expense_utilities_desc);
    Count_Diff_number_of_pcs_code := COUNT(GROUP,%Closest%.Diff_number_of_pcs_code);
    Count_Diff_number_of_pcs_desc := COUNT(GROUP,%Closest%.Diff_number_of_pcs_desc);
    Count_Diff_nb_flag := COUNT(GROUP,%Closest%.Diff_nb_flag);
    Count_Diff_hq_company_name := COUNT(GROUP,%Closest%.Diff_hq_company_name);
    Count_Diff_hq_city := COUNT(GROUP,%Closest%.Diff_hq_city);
    Count_Diff_hq_state := COUNT(GROUP,%Closest%.Diff_hq_state);
    Count_Diff_subhq_parent_name := COUNT(GROUP,%Closest%.Diff_subhq_parent_name);
    Count_Diff_subhq_parent_city := COUNT(GROUP,%Closest%.Diff_subhq_parent_city);
    Count_Diff_subhq_parent_state := COUNT(GROUP,%Closest%.Diff_subhq_parent_state);
    Count_Diff_domestic_foreign_owner_flag := COUNT(GROUP,%Closest%.Diff_domestic_foreign_owner_flag);
    Count_Diff_foreign_parent_company_name := COUNT(GROUP,%Closest%.Diff_foreign_parent_company_name);
    Count_Diff_foreign_parent_city := COUNT(GROUP,%Closest%.Diff_foreign_parent_city);
    Count_Diff_foreign_parent_country := COUNT(GROUP,%Closest%.Diff_foreign_parent_country);
    Count_Diff_db_cons_matchkey := COUNT(GROUP,%Closest%.Diff_db_cons_matchkey);
    Count_Diff_databaseusa_individual_id := COUNT(GROUP,%Closest%.Diff_databaseusa_individual_id);
    Count_Diff_db_cons_full_name := COUNT(GROUP,%Closest%.Diff_db_cons_full_name);
    Count_Diff_db_cons_full_name_prefix := COUNT(GROUP,%Closest%.Diff_db_cons_full_name_prefix);
    Count_Diff_db_cons_first_name := COUNT(GROUP,%Closest%.Diff_db_cons_first_name);
    Count_Diff_db_cons_middle_initial := COUNT(GROUP,%Closest%.Diff_db_cons_middle_initial);
    Count_Diff_db_cons_last_name := COUNT(GROUP,%Closest%.Diff_db_cons_last_name);
    Count_Diff_db_cons_email := COUNT(GROUP,%Closest%.Diff_db_cons_email);
    Count_Diff_db_cons_gender := COUNT(GROUP,%Closest%.Diff_db_cons_gender);
    Count_Diff_db_cons_date_of_birth_year := COUNT(GROUP,%Closest%.Diff_db_cons_date_of_birth_year);
    Count_Diff_db_cons_date_of_birth_month := COUNT(GROUP,%Closest%.Diff_db_cons_date_of_birth_month);
    Count_Diff_db_cons_age := COUNT(GROUP,%Closest%.Diff_db_cons_age);
    Count_Diff_db_cons_age_code_desc := COUNT(GROUP,%Closest%.Diff_db_cons_age_code_desc);
    Count_Diff_db_cons_age_in_two_year_hh := COUNT(GROUP,%Closest%.Diff_db_cons_age_in_two_year_hh);
    Count_Diff_db_cons_ethnic_code := COUNT(GROUP,%Closest%.Diff_db_cons_ethnic_code);
    Count_Diff_db_cons_religious_affil := COUNT(GROUP,%Closest%.Diff_db_cons_religious_affil);
    Count_Diff_db_cons_language_pref := COUNT(GROUP,%Closest%.Diff_db_cons_language_pref);
    Count_Diff_db_cons_phy_addr_std := COUNT(GROUP,%Closest%.Diff_db_cons_phy_addr_std);
    Count_Diff_db_cons_phy_addr_city := COUNT(GROUP,%Closest%.Diff_db_cons_phy_addr_city);
    Count_Diff_db_cons_phy_addr_state := COUNT(GROUP,%Closest%.Diff_db_cons_phy_addr_state);
    Count_Diff_db_cons_phy_addr_zip := COUNT(GROUP,%Closest%.Diff_db_cons_phy_addr_zip);
    Count_Diff_db_cons_phy_addr_zip4 := COUNT(GROUP,%Closest%.Diff_db_cons_phy_addr_zip4);
    Count_Diff_db_cons_phy_addr_carrierroute := COUNT(GROUP,%Closest%.Diff_db_cons_phy_addr_carrierroute);
    Count_Diff_db_cons_phy_addr_deliverypt := COUNT(GROUP,%Closest%.Diff_db_cons_phy_addr_deliverypt);
    Count_Diff_db_cons_line_of_travel := COUNT(GROUP,%Closest%.Diff_db_cons_line_of_travel);
    Count_Diff_db_cons_geocode_results := COUNT(GROUP,%Closest%.Diff_db_cons_geocode_results);
    Count_Diff_db_cons_latitude := COUNT(GROUP,%Closest%.Diff_db_cons_latitude);
    Count_Diff_db_cons_longitude := COUNT(GROUP,%Closest%.Diff_db_cons_longitude);
    Count_Diff_db_cons_time_zone_code := COUNT(GROUP,%Closest%.Diff_db_cons_time_zone_code);
    Count_Diff_db_cons_time_zone_desc := COUNT(GROUP,%Closest%.Diff_db_cons_time_zone_desc);
    Count_Diff_db_cons_census_tract := COUNT(GROUP,%Closest%.Diff_db_cons_census_tract);
    Count_Diff_db_cons_census_block := COUNT(GROUP,%Closest%.Diff_db_cons_census_block);
    Count_Diff_db_cons_countyfips := COUNT(GROUP,%Closest%.Diff_db_cons_countyfips);
    Count_Diff_db_countyname := COUNT(GROUP,%Closest%.Diff_db_countyname);
    Count_Diff_db_cons_cbsa_code := COUNT(GROUP,%Closest%.Diff_db_cons_cbsa_code);
    Count_Diff_db_cons_cbsa_desc := COUNT(GROUP,%Closest%.Diff_db_cons_cbsa_desc);
    Count_Diff_db_cons_walk_sequence := COUNT(GROUP,%Closest%.Diff_db_cons_walk_sequence);
    Count_Diff_db_cons_phone := COUNT(GROUP,%Closest%.Diff_db_cons_phone);
    Count_Diff_db_cons_dnc := COUNT(GROUP,%Closest%.Diff_db_cons_dnc);
    Count_Diff_db_cons_scrubbed_phoneable := COUNT(GROUP,%Closest%.Diff_db_cons_scrubbed_phoneable);
    Count_Diff_db_cons_children_present := COUNT(GROUP,%Closest%.Diff_db_cons_children_present);
    Count_Diff_db_cons_home_value_code := COUNT(GROUP,%Closest%.Diff_db_cons_home_value_code);
    Count_Diff_db_cons_home_value_desc := COUNT(GROUP,%Closest%.Diff_db_cons_home_value_desc);
    Count_Diff_db_cons_donor_capacity := COUNT(GROUP,%Closest%.Diff_db_cons_donor_capacity);
    Count_Diff_db_cons_donor_capacity_code := COUNT(GROUP,%Closest%.Diff_db_cons_donor_capacity_code);
    Count_Diff_db_cons_donor_capacity_desc := COUNT(GROUP,%Closest%.Diff_db_cons_donor_capacity_desc);
    Count_Diff_db_cons_home_owner_renter := COUNT(GROUP,%Closest%.Diff_db_cons_home_owner_renter);
    Count_Diff_db_cons_length_of_res := COUNT(GROUP,%Closest%.Diff_db_cons_length_of_res);
    Count_Diff_db_cons_length_of_res_code := COUNT(GROUP,%Closest%.Diff_db_cons_length_of_res_code);
    Count_Diff_db_cons_length_of_res_desc := COUNT(GROUP,%Closest%.Diff_db_cons_length_of_res_desc);
    Count_Diff_db_cons_dwelling_type := COUNT(GROUP,%Closest%.Diff_db_cons_dwelling_type);
    Count_Diff_db_cons_recent_home_buyer := COUNT(GROUP,%Closest%.Diff_db_cons_recent_home_buyer);
    Count_Diff_db_cons_income_code := COUNT(GROUP,%Closest%.Diff_db_cons_income_code);
    Count_Diff_db_cons_income_desc := COUNT(GROUP,%Closest%.Diff_db_cons_income_desc);
    Count_Diff_db_cons_unsecuredcredcap := COUNT(GROUP,%Closest%.Diff_db_cons_unsecuredcredcap);
    Count_Diff_db_cons_unsecuredcredcapcode := COUNT(GROUP,%Closest%.Diff_db_cons_unsecuredcredcapcode);
    Count_Diff_db_cons_unsecuredcredcapdesc := COUNT(GROUP,%Closest%.Diff_db_cons_unsecuredcredcapdesc);
    Count_Diff_db_cons_networthhomeval := COUNT(GROUP,%Closest%.Diff_db_cons_networthhomeval);
    Count_Diff_db_cons_networthhomevalcode := COUNT(GROUP,%Closest%.Diff_db_cons_networthhomevalcode);
    Count_Diff_db_cons_net_worth_desc := COUNT(GROUP,%Closest%.Diff_db_cons_net_worth_desc);
    Count_Diff_db_cons_discretincome := COUNT(GROUP,%Closest%.Diff_db_cons_discretincome);
    Count_Diff_db_cons_discretincomecode := COUNT(GROUP,%Closest%.Diff_db_cons_discretincomecode);
    Count_Diff_db_cons_discretincomedesc := COUNT(GROUP,%Closest%.Diff_db_cons_discretincomedesc);
    Count_Diff_db_cons_marital_status := COUNT(GROUP,%Closest%.Diff_db_cons_marital_status);
    Count_Diff_db_cons_new_parent := COUNT(GROUP,%Closest%.Diff_db_cons_new_parent);
    Count_Diff_db_cons_child_near_hs_grad := COUNT(GROUP,%Closest%.Diff_db_cons_child_near_hs_grad);
    Count_Diff_db_cons_college_graduate := COUNT(GROUP,%Closest%.Diff_db_cons_college_graduate);
    Count_Diff_db_cons_intend_purchase_veh := COUNT(GROUP,%Closest%.Diff_db_cons_intend_purchase_veh);
    Count_Diff_db_cons_recent_divorce := COUNT(GROUP,%Closest%.Diff_db_cons_recent_divorce);
    Count_Diff_db_cons_newlywed := COUNT(GROUP,%Closest%.Diff_db_cons_newlywed);
    Count_Diff_db_cons_new_teen_driver := COUNT(GROUP,%Closest%.Diff_db_cons_new_teen_driver);
    Count_Diff_db_cons_home_year_built := COUNT(GROUP,%Closest%.Diff_db_cons_home_year_built);
    Count_Diff_db_cons_home_sqft_ranges := COUNT(GROUP,%Closest%.Diff_db_cons_home_sqft_ranges);
    Count_Diff_db_cons_poli_party_ind := COUNT(GROUP,%Closest%.Diff_db_cons_poli_party_ind);
    Count_Diff_db_cons_home_sqft_actual := COUNT(GROUP,%Closest%.Diff_db_cons_home_sqft_actual);
    Count_Diff_db_cons_occupation_ind := COUNT(GROUP,%Closest%.Diff_db_cons_occupation_ind);
    Count_Diff_db_cons_credit_card_user := COUNT(GROUP,%Closest%.Diff_db_cons_credit_card_user);
    Count_Diff_db_cons_home_property_type := COUNT(GROUP,%Closest%.Diff_db_cons_home_property_type);
    Count_Diff_db_cons_education_hh := COUNT(GROUP,%Closest%.Diff_db_cons_education_hh);
    Count_Diff_db_cons_education_ind := COUNT(GROUP,%Closest%.Diff_db_cons_education_ind);
    Count_Diff_db_cons_other_pet_owner := COUNT(GROUP,%Closest%.Diff_db_cons_other_pet_owner);
    Count_Diff_businesstypedesc := COUNT(GROUP,%Closest%.Diff_businesstypedesc);
    Count_Diff_genderdesc := COUNT(GROUP,%Closest%.Diff_genderdesc);
    Count_Diff_executivetypedesc := COUNT(GROUP,%Closest%.Diff_executivetypedesc);
    Count_Diff_dbconsgenderdesc := COUNT(GROUP,%Closest%.Diff_dbconsgenderdesc);
    Count_Diff_dbconsethnicdesc := COUNT(GROUP,%Closest%.Diff_dbconsethnicdesc);
    Count_Diff_dbconsreligiousdesc := COUNT(GROUP,%Closest%.Diff_dbconsreligiousdesc);
    Count_Diff_dbconslangprefdesc := COUNT(GROUP,%Closest%.Diff_dbconslangprefdesc);
    Count_Diff_dbconsownerrenter := COUNT(GROUP,%Closest%.Diff_dbconsownerrenter);
    Count_Diff_dbconsdwellingtypedesc := COUNT(GROUP,%Closest%.Diff_dbconsdwellingtypedesc);
    Count_Diff_dbconsmaritaldesc := COUNT(GROUP,%Closest%.Diff_dbconsmaritaldesc);
    Count_Diff_dbconsnewparentdesc := COUNT(GROUP,%Closest%.Diff_dbconsnewparentdesc);
    Count_Diff_dbconsteendriverdesc := COUNT(GROUP,%Closest%.Diff_dbconsteendriverdesc);
    Count_Diff_dbconspolipartydesc := COUNT(GROUP,%Closest%.Diff_dbconspolipartydesc);
    Count_Diff_dbconsoccupationdesc := COUNT(GROUP,%Closest%.Diff_dbconsoccupationdesc);
    Count_Diff_dbconspropertytypedesc := COUNT(GROUP,%Closest%.Diff_dbconspropertytypedesc);
    Count_Diff_dbconsheadhouseeducdesc := COUNT(GROUP,%Closest%.Diff_dbconsheadhouseeducdesc);
    Count_Diff_dbconseducationdesc := COUNT(GROUP,%Closest%.Diff_dbconseducationdesc);
    Count_Diff_title := COUNT(GROUP,%Closest%.Diff_title);
    Count_Diff_fname := COUNT(GROUP,%Closest%.Diff_fname);
    Count_Diff_mname := COUNT(GROUP,%Closest%.Diff_mname);
    Count_Diff_lname := COUNT(GROUP,%Closest%.Diff_lname);
    Count_Diff_name_score := COUNT(GROUP,%Closest%.Diff_name_score);
    Count_Diff_phy_prim_range := COUNT(GROUP,%Closest%.Diff_phy_prim_range);
    Count_Diff_phy_predir := COUNT(GROUP,%Closest%.Diff_phy_predir);
    Count_Diff_phy_prim_name := COUNT(GROUP,%Closest%.Diff_phy_prim_name);
    Count_Diff_phy_addr_suffix := COUNT(GROUP,%Closest%.Diff_phy_addr_suffix);
    Count_Diff_phy_postdir := COUNT(GROUP,%Closest%.Diff_phy_postdir);
    Count_Diff_phy_unit_desig := COUNT(GROUP,%Closest%.Diff_phy_unit_desig);
    Count_Diff_phy_sec_range := COUNT(GROUP,%Closest%.Diff_phy_sec_range);
    Count_Diff_phy_p_city_name := COUNT(GROUP,%Closest%.Diff_phy_p_city_name);
    Count_Diff_phy_v_city_name := COUNT(GROUP,%Closest%.Diff_phy_v_city_name);
    Count_Diff_phy_st := COUNT(GROUP,%Closest%.Diff_phy_st);
    Count_Diff_phy_cart := COUNT(GROUP,%Closest%.Diff_phy_cart);
    Count_Diff_phy_cr_sort_sz := COUNT(GROUP,%Closest%.Diff_phy_cr_sort_sz);
    Count_Diff_phy_lot := COUNT(GROUP,%Closest%.Diff_phy_lot);
    Count_Diff_phy_lot_order := COUNT(GROUP,%Closest%.Diff_phy_lot_order);
    Count_Diff_phy_dbpc := COUNT(GROUP,%Closest%.Diff_phy_dbpc);
    Count_Diff_phy_chk_digit := COUNT(GROUP,%Closest%.Diff_phy_chk_digit);
    Count_Diff_phy_rec_type := COUNT(GROUP,%Closest%.Diff_phy_rec_type);
    Count_Diff_phy_fips_state := COUNT(GROUP,%Closest%.Diff_phy_fips_state);
    Count_Diff_phy_fips_county := COUNT(GROUP,%Closest%.Diff_phy_fips_county);
    Count_Diff_phy_geo_lat := COUNT(GROUP,%Closest%.Diff_phy_geo_lat);
    Count_Diff_phy_geo_long := COUNT(GROUP,%Closest%.Diff_phy_geo_long);
    Count_Diff_phy_msa := COUNT(GROUP,%Closest%.Diff_phy_msa);
    Count_Diff_phy_geo_blk := COUNT(GROUP,%Closest%.Diff_phy_geo_blk);
    Count_Diff_phy_geo_match := COUNT(GROUP,%Closest%.Diff_phy_geo_match);
    Count_Diff_phy_err_stat := COUNT(GROUP,%Closest%.Diff_phy_err_stat);
    Count_Diff_phy_raw_aid := COUNT(GROUP,%Closest%.Diff_phy_raw_aid);
    Count_Diff_phy_ace_aid := COUNT(GROUP,%Closest%.Diff_phy_ace_aid);
    Count_Diff_phy_prep_address_line1 := COUNT(GROUP,%Closest%.Diff_phy_prep_address_line1);
    Count_Diff_phy_prep_address_line_last := COUNT(GROUP,%Closest%.Diff_phy_prep_address_line_last);
    Count_Diff_mail_prim_range := COUNT(GROUP,%Closest%.Diff_mail_prim_range);
    Count_Diff_mail_predir := COUNT(GROUP,%Closest%.Diff_mail_predir);
    Count_Diff_mail_prim_name := COUNT(GROUP,%Closest%.Diff_mail_prim_name);
    Count_Diff_mail_addr_suffix := COUNT(GROUP,%Closest%.Diff_mail_addr_suffix);
    Count_Diff_mail_postdir := COUNT(GROUP,%Closest%.Diff_mail_postdir);
    Count_Diff_mail_unit_desig := COUNT(GROUP,%Closest%.Diff_mail_unit_desig);
    Count_Diff_mail_sec_range := COUNT(GROUP,%Closest%.Diff_mail_sec_range);
    Count_Diff_mail_p_city_name := COUNT(GROUP,%Closest%.Diff_mail_p_city_name);
    Count_Diff_mail_v_city_name := COUNT(GROUP,%Closest%.Diff_mail_v_city_name);
    Count_Diff_mail_st := COUNT(GROUP,%Closest%.Diff_mail_st);
    Count_Diff_mail_cart := COUNT(GROUP,%Closest%.Diff_mail_cart);
    Count_Diff_mail_cr_sort_sz := COUNT(GROUP,%Closest%.Diff_mail_cr_sort_sz);
    Count_Diff_mail_lot := COUNT(GROUP,%Closest%.Diff_mail_lot);
    Count_Diff_mail_lot_order := COUNT(GROUP,%Closest%.Diff_mail_lot_order);
    Count_Diff_mail_dbpc := COUNT(GROUP,%Closest%.Diff_mail_dbpc);
    Count_Diff_mail_chk_digit := COUNT(GROUP,%Closest%.Diff_mail_chk_digit);
    Count_Diff_mail_rec_type := COUNT(GROUP,%Closest%.Diff_mail_rec_type);
    Count_Diff_mail_fips_state := COUNT(GROUP,%Closest%.Diff_mail_fips_state);
    Count_Diff_mail_fips_county := COUNT(GROUP,%Closest%.Diff_mail_fips_county);
    Count_Diff_mail_geo_lat := COUNT(GROUP,%Closest%.Diff_mail_geo_lat);
    Count_Diff_mail_geo_long := COUNT(GROUP,%Closest%.Diff_mail_geo_long);
    Count_Diff_mail_msa := COUNT(GROUP,%Closest%.Diff_mail_msa);
    Count_Diff_mail_geo_blk := COUNT(GROUP,%Closest%.Diff_mail_geo_blk);
    Count_Diff_mail_geo_match := COUNT(GROUP,%Closest%.Diff_mail_geo_match);
    Count_Diff_mail_err_stat := COUNT(GROUP,%Closest%.Diff_mail_err_stat);
    Count_Diff_mail_raw_aid := COUNT(GROUP,%Closest%.Diff_mail_raw_aid);
    Count_Diff_mail_ace_aid := COUNT(GROUP,%Closest%.Diff_mail_ace_aid);
    Count_Diff_mail_prep_address_line1 := COUNT(GROUP,%Closest%.Diff_mail_prep_address_line1);
    Count_Diff_mail_prep_address_line_last := COUNT(GROUP,%Closest%.Diff_mail_prep_address_line_last);
		Count_Diff_db_cons_prim_range := COUNT(GROUP,%Closest%.Diff_db_cons_prim_range);
    Count_Diff_db_cons_predir := COUNT(GROUP,%Closest%.Diff_db_cons_predir);
    Count_Diff_db_cons_prim_name := COUNT(GROUP,%Closest%.Diff_db_cons_prim_name);
    Count_Diff_db_cons_addr_suffix := COUNT(GROUP,%Closest%.Diff_db_cons_addr_suffix);
    Count_Diff_db_cons_postdir := COUNT(GROUP,%Closest%.Diff_db_cons_postdir);
    Count_Diff_db_cons_unit_desig := COUNT(GROUP,%Closest%.Diff_db_cons_unit_desig);
    Count_Diff_db_cons_sec_range := COUNT(GROUP,%Closest%.Diff_db_cons_sec_range);
    Count_Diff_db_cons_p_city_name := COUNT(GROUP,%Closest%.Diff_db_cons_p_city_name);
    Count_Diff_db_cons_v_city_name := COUNT(GROUP,%Closest%.Diff_db_cons_v_city_name);
    Count_Diff_db_cons_st := COUNT(GROUP,%Closest%.Diff_db_cons_st);
    Count_Diff_db_cons_cart := COUNT(GROUP,%Closest%.Diff_db_cons_cart);
    Count_Diff_db_cons_cr_sort_sz := COUNT(GROUP,%Closest%.Diff_db_cons_cr_sort_sz);
    Count_Diff_db_cons_lot := COUNT(GROUP,%Closest%.Diff_db_cons_lot);
    Count_Diff_db_cons_lot_order := COUNT(GROUP,%Closest%.Diff_db_cons_lot_order);
    Count_Diff_db_cons_dbpc := COUNT(GROUP,%Closest%.Diff_db_cons_dbpc);
    Count_Diff_db_cons_chk_digit := COUNT(GROUP,%Closest%.Diff_db_cons_chk_digit);
    Count_Diff_db_cons_rec_type := COUNT(GROUP,%Closest%.Diff_db_cons_rec_type);
    Count_Diff_db_cons_fips_state := COUNT(GROUP,%Closest%.Diff_db_cons_fips_state);
    Count_Diff_db_cons_fips_county := COUNT(GROUP,%Closest%.Diff_db_cons_fips_county);
    Count_Diff_db_cons_geo_lat := COUNT(GROUP,%Closest%.Diff_db_cons_geo_lat);
    Count_Diff_db_cons_geo_long := COUNT(GROUP,%Closest%.Diff_db_cons_geo_long);
    Count_Diff_db_cons_msa := COUNT(GROUP,%Closest%.Diff_db_cons_msa);
    Count_Diff_db_cons_geo_blk := COUNT(GROUP,%Closest%.Diff_db_cons_geo_blk);
    Count_Diff_db_cons_geo_match := COUNT(GROUP,%Closest%.Diff_db_cons_geo_match);
    Count_Diff_db_cons_err_stat := COUNT(GROUP,%Closest%.Diff_db_cons_err_stat);
    Count_Diff_db_cons_raw_aid := COUNT(GROUP,%Closest%.Diff_db_cons_raw_aid);
    Count_Diff_db_cons_ace_aid := COUNT(GROUP,%Closest%.Diff_db_cons_ace_aid);
    Count_Diff_db_cons_prep_address_line1 := COUNT(GROUP,%Closest%.Diff_db_cons_prep_address_line1);
    Count_Diff_db_cons_prep_address_line_last := COUNT(GROUP,%Closest%.Diff_db_cons_prep_address_line_last);
    %Closest%.SourceField;
  END;
  out_counts := table(%Closest%,%AggRec%,SourceField,few);
ENDMACRO;
// Now determine the consistency of the identifiers
EXPORT UIDConsistency(infile) := FUNCTIONMACRO
  IMPORT Database_USA,SALT311;
  f := TABLE(infile,{record_sid,seleid}) : GLOBAL; // Consistent type independent of input
  m := MODULE
    r := RECORD
      UNSIGNED record_sid_null0 := COUNT(GROUP,(UNSIGNED)f.record_sid=0);
      UNSIGNED record_sid_belowparent0 := COUNT(GROUP,(UNSIGNED)f.record_sid<(UNSIGNED)f.seleid);
      UNSIGNED record_sid_atparent := COUNT(GROUP,(UNSIGNED)f.seleid=(UNSIGNED)f.record_sid);
      UNSIGNED seleid_null0 := COUNT(GROUP,(UNSIGNED)f.seleid=0);
    END;
    EXPORT Basic0 := TABLE(f,r);
    EXPORT record_sid_Clusters := SALT311.MOD_ClusterStats.Counts(f,record_sid);
    EXPORT seleid_Clusters := SALT311.MOD_ClusterStats.Counts(f,seleid);
    EXPORT IdCounts := DATASET([{'record_sid_Cnt', SUM(record_sid_Clusters,NumberOfClusters)},{'seleid_Cnt', SUM(seleid_Clusters,NumberOfClusters)}],{STRING10 Count_Type, UNSIGNED Cnt}); // The counts of each ID
    // For deeper debugging; provide the unbased parents
    bases := f((UNSIGNED)seleid=(UNSIGNED)record_sid); // Get the bases
    EXPORT seleid_Unbased := JOIN(f(seleid<>0),bases,LEFT.seleid=RIGHT.seleid,TRANSFORM(LEFT),LEFT ONLY,HASH);
    // Children with two parents
    f_thin := TABLE(f(record_sid<>0,seleid<>0),{record_sid,seleid},record_sid,seleid,MERGE);
    EXPORT record_sid_Twoparents := DEDUP(JOIN(f_thin,f_thin,LEFT.record_sid=RIGHT.record_sid AND LEFT.seleid>RIGHT.seleid,TRANSFORM({SALT311.UIDType seleid1,SALT311.UIDType record_sid,SALT311.UIDType seleid2},SELF.seleid1:=LEFT.seleid,SELF.seleid2:=RIGHT.seleid,SELF.record_sid:=LEFT.record_sid),HASH),WHOLE RECORD,ALL);
    // Now compute the more involved consistency checks
    r := RECORD
      {Basic0} AND NOT [record_sid_atparent];
      INTEGER seleid_unbased0 := IdCounts[2].Cnt-Basic0.record_sid_atparent-IF(Basic0.seleid_null0>0,1,0);
      INTEGER record_sid_Twoparents0 := COUNT(record_sid_Twoparents);
    END;
    Advanced00 := TABLE(Basic0,r);
    Advanced0Layout := {STRING label, INTEGER null0, INTEGER belowparent0, INTEGER unbased0, INTEGER Twoparents0};
    EXPORT Advanced0 := SORT(SALT311.MAC_Pivot(Advanced00,Advanced0Layout), MAP(label='record_sid'=>0,1));
  END;
  RETURN m;
ENDMACRO;
END;
