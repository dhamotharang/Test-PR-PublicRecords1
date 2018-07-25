IMPORT ut,SALT34;
EXPORT Fields := MODULE
 
EXPORT SALT34.StrType FieldName(UNSIGNED2 i) := CHOOSE(i,'process_date','dotid','dotscore','dotweight','empid','empscore','empweight','powid','powscore','powweight','proxid','proxscore','proxweight','seleid','selescore','seleweight','orgid','orgscore','orgweight','ultid','ultscore','ultweight','did','did_score','dt_first_seen','dt_last_seen','dt_vendor_first_reported','dt_vendor_last_reported','record_type','pid','record_id','ein','busname','tradename','house','predirection','street','strtype','postdirection','apttype','aptnbr','city','state','zip5','ziplast4','dpc','carrier_route','address_type_code','dpv_code','mailable','county_code','censustract','censusblockgroup','censusblock','congress_code','msacode','timezonecode','latitude','longitude','url','telephone','toll_free_number','fax','sic1','sic2','sic3','sic4','sic5','stdclass','heading1','heading2','heading3','heading4','heading5','business_specialty','sales_code','employee_code','location_type','parent_company','parent_address','parent_city','parent_state','parent_zip','parent_phone','stock_symbol','stock_exchange','public','number_of_pcs','square_footage','business_type','incorporation_state','minority','woman','government','small','home_office','soho','franchise','phoneable','prefix','first_name','middle_name','surname','suffix','birth_year','ethnicity','gender','email','contact_title','year_started','date_added','validationdate','internal1','dacd','normcompany_type','normcompany_name','normcompany_street','normcompany_city','normcompany_state','normcompany_zip','normcompany_phone','clean_company_name','title','fname','mname','lname','name_suffix','name_score','prim_range','predir','prim_name','addr_suffix','postdir','unit_desig','sec_range','p_city_name','v_city_name','st','zip','zip4','cart','cr_sort_sz','lot','lot_order','dbpc','chk_digit','rec_type','fips_state','fips_county','geo_lat','geo_long','msa','geo_blk','geo_match','err_stat','clean_phone','raw_aid','ace_aid','prep_address_line1','prep_address_line_last');
EXPORT FieldNum(SALT34.StrType fn) := CASE(fn,'process_date' => 0,'dotid' => 1,'dotscore' => 2,'dotweight' => 3,'empid' => 4,'empscore' => 5,'empweight' => 6,'powid' => 7,'powscore' => 8,'powweight' => 9,'proxid' => 10,'proxscore' => 11,'proxweight' => 12,'seleid' => 13,'selescore' => 14,'seleweight' => 15,'orgid' => 16,'orgscore' => 17,'orgweight' => 18,'ultid' => 19,'ultscore' => 20,'ultweight' => 21,'did' => 22,'did_score' => 23,'dt_first_seen' => 24,'dt_last_seen' => 25,'dt_vendor_first_reported' => 26,'dt_vendor_last_reported' => 27,'record_type' => 28,'pid' => 29,'record_id' => 30,'ein' => 31,'busname' => 32,'tradename' => 33,'house' => 34,'predirection' => 35,'street' => 36,'strtype' => 37,'postdirection' => 38,'apttype' => 39,'aptnbr' => 40,'city' => 41,'state' => 42,'zip5' => 43,'ziplast4' => 44,'dpc' => 45,'carrier_route' => 46,'address_type_code' => 47,'dpv_code' => 48,'mailable' => 49,'county_code' => 50,'censustract' => 51,'censusblockgroup' => 52,'censusblock' => 53,'congress_code' => 54,'msacode' => 55,'timezonecode' => 56,'latitude' => 57,'longitude' => 58,'url' => 59,'telephone' => 60,'toll_free_number' => 61,'fax' => 62,'sic1' => 63,'sic2' => 64,'sic3' => 65,'sic4' => 66,'sic5' => 67,'stdclass' => 68,'heading1' => 69,'heading2' => 70,'heading3' => 71,'heading4' => 72,'heading5' => 73,'business_specialty' => 74,'sales_code' => 75,'employee_code' => 76,'location_type' => 77,'parent_company' => 78,'parent_address' => 79,'parent_city' => 80,'parent_state' => 81,'parent_zip' => 82,'parent_phone' => 83,'stock_symbol' => 84,'stock_exchange' => 85,'public' => 86,'number_of_pcs' => 87,'square_footage' => 88,'business_type' => 89,'incorporation_state' => 90,'minority' => 91,'woman' => 92,'government' => 93,'small' => 94,'home_office' => 95,'soho' => 96,'franchise' => 97,'phoneable' => 98,'prefix' => 99,'first_name' => 100,'middle_name' => 101,'surname' => 102,'suffix' => 103,'birth_year' => 104,'ethnicity' => 105,'gender' => 106,'email' => 107,'contact_title' => 108,'year_started' => 109,'date_added' => 110,'validationdate' => 111,'internal1' => 112,'dacd' => 113,'normcompany_type' => 114,'normcompany_name' => 115,'normcompany_street' => 116,'normcompany_city' => 117,'normcompany_state' => 118,'normcompany_zip' => 119,'normcompany_phone' => 120,'clean_company_name' => 121,'title' => 122,'fname' => 123,'mname' => 124,'lname' => 125,'name_suffix' => 126,'name_score' => 127,'prim_range' => 128,'predir' => 129,'prim_name' => 130,'addr_suffix' => 131,'postdir' => 132,'unit_desig' => 133,'sec_range' => 134,'p_city_name' => 135,'v_city_name' => 136,'st' => 137,'zip' => 138,'zip4' => 139,'cart' => 140,'cr_sort_sz' => 141,'lot' => 142,'lot_order' => 143,'dbpc' => 144,'chk_digit' => 145,'rec_type' => 146,'fips_state' => 147,'fips_county' => 148,'geo_lat' => 149,'geo_long' => 150,'msa' => 151,'geo_blk' => 152,'geo_match' => 153,'err_stat' => 154,'clean_phone' => 155,'raw_aid' => 156,'ace_aid' => 157,'prep_address_line1' => 158,'prep_address_line_last' => 159,0);
 
//Individual field level validation
 
EXPORT Make_process_date(SALT34.StrType s0) := s0;
EXPORT InValid_process_date(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_process_date(UNSIGNED1 wh) := '';
 
EXPORT Make_dotid(SALT34.StrType s0) := s0;
EXPORT InValid_dotid(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_dotid(UNSIGNED1 wh) := '';
 
EXPORT Make_dotscore(SALT34.StrType s0) := s0;
EXPORT InValid_dotscore(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_dotscore(UNSIGNED1 wh) := '';
 
EXPORT Make_dotweight(SALT34.StrType s0) := s0;
EXPORT InValid_dotweight(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_dotweight(UNSIGNED1 wh) := '';
 
EXPORT Make_empid(SALT34.StrType s0) := s0;
EXPORT InValid_empid(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_empid(UNSIGNED1 wh) := '';
 
EXPORT Make_empscore(SALT34.StrType s0) := s0;
EXPORT InValid_empscore(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_empscore(UNSIGNED1 wh) := '';
 
EXPORT Make_empweight(SALT34.StrType s0) := s0;
EXPORT InValid_empweight(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_empweight(UNSIGNED1 wh) := '';
 
EXPORT Make_powid(SALT34.StrType s0) := s0;
EXPORT InValid_powid(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_powid(UNSIGNED1 wh) := '';
 
EXPORT Make_powscore(SALT34.StrType s0) := s0;
EXPORT InValid_powscore(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_powscore(UNSIGNED1 wh) := '';
 
EXPORT Make_powweight(SALT34.StrType s0) := s0;
EXPORT InValid_powweight(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_powweight(UNSIGNED1 wh) := '';
 
EXPORT Make_proxid(SALT34.StrType s0) := s0;
EXPORT InValid_proxid(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_proxid(UNSIGNED1 wh) := '';
 
EXPORT Make_proxscore(SALT34.StrType s0) := s0;
EXPORT InValid_proxscore(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_proxscore(UNSIGNED1 wh) := '';
 
EXPORT Make_proxweight(SALT34.StrType s0) := s0;
EXPORT InValid_proxweight(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_proxweight(UNSIGNED1 wh) := '';
 
EXPORT Make_seleid(SALT34.StrType s0) := s0;
EXPORT InValid_seleid(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_seleid(UNSIGNED1 wh) := '';
 
EXPORT Make_selescore(SALT34.StrType s0) := s0;
EXPORT InValid_selescore(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_selescore(UNSIGNED1 wh) := '';
 
EXPORT Make_seleweight(SALT34.StrType s0) := s0;
EXPORT InValid_seleweight(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_seleweight(UNSIGNED1 wh) := '';
 
EXPORT Make_orgid(SALT34.StrType s0) := s0;
EXPORT InValid_orgid(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_orgid(UNSIGNED1 wh) := '';
 
EXPORT Make_orgscore(SALT34.StrType s0) := s0;
EXPORT InValid_orgscore(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_orgscore(UNSIGNED1 wh) := '';
 
EXPORT Make_orgweight(SALT34.StrType s0) := s0;
EXPORT InValid_orgweight(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_orgweight(UNSIGNED1 wh) := '';
 
EXPORT Make_ultid(SALT34.StrType s0) := s0;
EXPORT InValid_ultid(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_ultid(UNSIGNED1 wh) := '';
 
EXPORT Make_ultscore(SALT34.StrType s0) := s0;
EXPORT InValid_ultscore(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_ultscore(UNSIGNED1 wh) := '';
 
EXPORT Make_ultweight(SALT34.StrType s0) := s0;
EXPORT InValid_ultweight(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_ultweight(UNSIGNED1 wh) := '';
 
EXPORT Make_did(SALT34.StrType s0) := s0;
EXPORT InValid_did(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_did(UNSIGNED1 wh) := '';
 
EXPORT Make_did_score(SALT34.StrType s0) := s0;
EXPORT InValid_did_score(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_did_score(UNSIGNED1 wh) := '';
 
EXPORT Make_dt_first_seen(SALT34.StrType s0) := s0;
EXPORT InValid_dt_first_seen(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_dt_first_seen(UNSIGNED1 wh) := '';
 
EXPORT Make_dt_last_seen(SALT34.StrType s0) := s0;
EXPORT InValid_dt_last_seen(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_dt_last_seen(UNSIGNED1 wh) := '';
 
EXPORT Make_dt_vendor_first_reported(SALT34.StrType s0) := s0;
EXPORT InValid_dt_vendor_first_reported(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_dt_vendor_first_reported(UNSIGNED1 wh) := '';
 
EXPORT Make_dt_vendor_last_reported(SALT34.StrType s0) := s0;
EXPORT InValid_dt_vendor_last_reported(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_dt_vendor_last_reported(UNSIGNED1 wh) := '';
 
EXPORT Make_record_type(SALT34.StrType s0) := s0;
EXPORT InValid_record_type(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_record_type(UNSIGNED1 wh) := '';
 
EXPORT Make_pid(SALT34.StrType s0) := s0;
EXPORT InValid_pid(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_pid(UNSIGNED1 wh) := '';
 
EXPORT Make_record_id(SALT34.StrType s0) := s0;
EXPORT InValid_record_id(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_record_id(UNSIGNED1 wh) := '';
 
EXPORT Make_ein(SALT34.StrType s0) := s0;
EXPORT InValid_ein(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_ein(UNSIGNED1 wh) := '';
 
EXPORT Make_busname(SALT34.StrType s0) := s0;
EXPORT InValid_busname(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_busname(UNSIGNED1 wh) := '';
 
EXPORT Make_tradename(SALT34.StrType s0) := s0;
EXPORT InValid_tradename(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_tradename(UNSIGNED1 wh) := '';
 
EXPORT Make_house(SALT34.StrType s0) := s0;
EXPORT InValid_house(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_house(UNSIGNED1 wh) := '';
 
EXPORT Make_predirection(SALT34.StrType s0) := s0;
EXPORT InValid_predirection(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_predirection(UNSIGNED1 wh) := '';
 
EXPORT Make_street(SALT34.StrType s0) := s0;
EXPORT InValid_street(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_street(UNSIGNED1 wh) := '';
 
EXPORT Make_strtype(SALT34.StrType s0) := s0;
EXPORT InValid_strtype(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_strtype(UNSIGNED1 wh) := '';
 
EXPORT Make_postdirection(SALT34.StrType s0) := s0;
EXPORT InValid_postdirection(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_postdirection(UNSIGNED1 wh) := '';
 
EXPORT Make_apttype(SALT34.StrType s0) := s0;
EXPORT InValid_apttype(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_apttype(UNSIGNED1 wh) := '';
 
EXPORT Make_aptnbr(SALT34.StrType s0) := s0;
EXPORT InValid_aptnbr(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_aptnbr(UNSIGNED1 wh) := '';
 
EXPORT Make_city(SALT34.StrType s0) := s0;
EXPORT InValid_city(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_city(UNSIGNED1 wh) := '';
 
EXPORT Make_state(SALT34.StrType s0) := s0;
EXPORT InValid_state(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_state(UNSIGNED1 wh) := '';
 
EXPORT Make_zip5(SALT34.StrType s0) := s0;
EXPORT InValid_zip5(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_zip5(UNSIGNED1 wh) := '';
 
EXPORT Make_ziplast4(SALT34.StrType s0) := s0;
EXPORT InValid_ziplast4(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_ziplast4(UNSIGNED1 wh) := '';
 
EXPORT Make_dpc(SALT34.StrType s0) := s0;
EXPORT InValid_dpc(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_dpc(UNSIGNED1 wh) := '';
 
EXPORT Make_carrier_route(SALT34.StrType s0) := s0;
EXPORT InValid_carrier_route(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_carrier_route(UNSIGNED1 wh) := '';
 
EXPORT Make_address_type_code(SALT34.StrType s0) := s0;
EXPORT InValid_address_type_code(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_address_type_code(UNSIGNED1 wh) := '';
 
EXPORT Make_dpv_code(SALT34.StrType s0) := s0;
EXPORT InValid_dpv_code(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_dpv_code(UNSIGNED1 wh) := '';
 
EXPORT Make_mailable(SALT34.StrType s0) := s0;
EXPORT InValid_mailable(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_mailable(UNSIGNED1 wh) := '';
 
EXPORT Make_county_code(SALT34.StrType s0) := s0;
EXPORT InValid_county_code(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_county_code(UNSIGNED1 wh) := '';
 
EXPORT Make_censustract(SALT34.StrType s0) := s0;
EXPORT InValid_censustract(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_censustract(UNSIGNED1 wh) := '';
 
EXPORT Make_censusblockgroup(SALT34.StrType s0) := s0;
EXPORT InValid_censusblockgroup(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_censusblockgroup(UNSIGNED1 wh) := '';
 
EXPORT Make_censusblock(SALT34.StrType s0) := s0;
EXPORT InValid_censusblock(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_censusblock(UNSIGNED1 wh) := '';
 
EXPORT Make_congress_code(SALT34.StrType s0) := s0;
EXPORT InValid_congress_code(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_congress_code(UNSIGNED1 wh) := '';
 
EXPORT Make_msacode(SALT34.StrType s0) := s0;
EXPORT InValid_msacode(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_msacode(UNSIGNED1 wh) := '';
 
EXPORT Make_timezonecode(SALT34.StrType s0) := s0;
EXPORT InValid_timezonecode(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_timezonecode(UNSIGNED1 wh) := '';
 
EXPORT Make_latitude(SALT34.StrType s0) := s0;
EXPORT InValid_latitude(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_latitude(UNSIGNED1 wh) := '';
 
EXPORT Make_longitude(SALT34.StrType s0) := s0;
EXPORT InValid_longitude(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_longitude(UNSIGNED1 wh) := '';
 
EXPORT Make_url(SALT34.StrType s0) := s0;
EXPORT InValid_url(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_url(UNSIGNED1 wh) := '';
 
EXPORT Make_telephone(SALT34.StrType s0) := s0;
EXPORT InValid_telephone(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_telephone(UNSIGNED1 wh) := '';
 
EXPORT Make_toll_free_number(SALT34.StrType s0) := s0;
EXPORT InValid_toll_free_number(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_toll_free_number(UNSIGNED1 wh) := '';
 
EXPORT Make_fax(SALT34.StrType s0) := s0;
EXPORT InValid_fax(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_fax(UNSIGNED1 wh) := '';
 
EXPORT Make_sic1(SALT34.StrType s0) := s0;
EXPORT InValid_sic1(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_sic1(UNSIGNED1 wh) := '';
 
EXPORT Make_sic2(SALT34.StrType s0) := s0;
EXPORT InValid_sic2(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_sic2(UNSIGNED1 wh) := '';
 
EXPORT Make_sic3(SALT34.StrType s0) := s0;
EXPORT InValid_sic3(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_sic3(UNSIGNED1 wh) := '';
 
EXPORT Make_sic4(SALT34.StrType s0) := s0;
EXPORT InValid_sic4(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_sic4(UNSIGNED1 wh) := '';
 
EXPORT Make_sic5(SALT34.StrType s0) := s0;
EXPORT InValid_sic5(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_sic5(UNSIGNED1 wh) := '';
 
EXPORT Make_stdclass(SALT34.StrType s0) := s0;
EXPORT InValid_stdclass(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_stdclass(UNSIGNED1 wh) := '';
 
EXPORT Make_heading1(SALT34.StrType s0) := s0;
EXPORT InValid_heading1(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_heading1(UNSIGNED1 wh) := '';
 
EXPORT Make_heading2(SALT34.StrType s0) := s0;
EXPORT InValid_heading2(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_heading2(UNSIGNED1 wh) := '';
 
EXPORT Make_heading3(SALT34.StrType s0) := s0;
EXPORT InValid_heading3(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_heading3(UNSIGNED1 wh) := '';
 
EXPORT Make_heading4(SALT34.StrType s0) := s0;
EXPORT InValid_heading4(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_heading4(UNSIGNED1 wh) := '';
 
EXPORT Make_heading5(SALT34.StrType s0) := s0;
EXPORT InValid_heading5(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_heading5(UNSIGNED1 wh) := '';
 
EXPORT Make_business_specialty(SALT34.StrType s0) := s0;
EXPORT InValid_business_specialty(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_business_specialty(UNSIGNED1 wh) := '';
 
EXPORT Make_sales_code(SALT34.StrType s0) := s0;
EXPORT InValid_sales_code(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_sales_code(UNSIGNED1 wh) := '';
 
EXPORT Make_employee_code(SALT34.StrType s0) := s0;
EXPORT InValid_employee_code(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_employee_code(UNSIGNED1 wh) := '';
 
EXPORT Make_location_type(SALT34.StrType s0) := s0;
EXPORT InValid_location_type(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_location_type(UNSIGNED1 wh) := '';
 
EXPORT Make_parent_company(SALT34.StrType s0) := s0;
EXPORT InValid_parent_company(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_parent_company(UNSIGNED1 wh) := '';
 
EXPORT Make_parent_address(SALT34.StrType s0) := s0;
EXPORT InValid_parent_address(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_parent_address(UNSIGNED1 wh) := '';
 
EXPORT Make_parent_city(SALT34.StrType s0) := s0;
EXPORT InValid_parent_city(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_parent_city(UNSIGNED1 wh) := '';
 
EXPORT Make_parent_state(SALT34.StrType s0) := s0;
EXPORT InValid_parent_state(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_parent_state(UNSIGNED1 wh) := '';
 
EXPORT Make_parent_zip(SALT34.StrType s0) := s0;
EXPORT InValid_parent_zip(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_parent_zip(UNSIGNED1 wh) := '';
 
EXPORT Make_parent_phone(SALT34.StrType s0) := s0;
EXPORT InValid_parent_phone(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_parent_phone(UNSIGNED1 wh) := '';
 
EXPORT Make_stock_symbol(SALT34.StrType s0) := s0;
EXPORT InValid_stock_symbol(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_stock_symbol(UNSIGNED1 wh) := '';
 
EXPORT Make_stock_exchange(SALT34.StrType s0) := s0;
EXPORT InValid_stock_exchange(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_stock_exchange(UNSIGNED1 wh) := '';
 
EXPORT Make_public(SALT34.StrType s0) := s0;
EXPORT InValid_public(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_public(UNSIGNED1 wh) := '';
 
EXPORT Make_number_of_pcs(SALT34.StrType s0) := s0;
EXPORT InValid_number_of_pcs(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_number_of_pcs(UNSIGNED1 wh) := '';
 
EXPORT Make_square_footage(SALT34.StrType s0) := s0;
EXPORT InValid_square_footage(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_square_footage(UNSIGNED1 wh) := '';
 
EXPORT Make_business_type(SALT34.StrType s0) := s0;
EXPORT InValid_business_type(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_business_type(UNSIGNED1 wh) := '';
 
EXPORT Make_incorporation_state(SALT34.StrType s0) := s0;
EXPORT InValid_incorporation_state(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_incorporation_state(UNSIGNED1 wh) := '';
 
EXPORT Make_minority(SALT34.StrType s0) := s0;
EXPORT InValid_minority(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_minority(UNSIGNED1 wh) := '';
 
EXPORT Make_woman(SALT34.StrType s0) := s0;
EXPORT InValid_woman(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_woman(UNSIGNED1 wh) := '';
 
EXPORT Make_government(SALT34.StrType s0) := s0;
EXPORT InValid_government(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_government(UNSIGNED1 wh) := '';
 
EXPORT Make_small(SALT34.StrType s0) := s0;
EXPORT InValid_small(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_small(UNSIGNED1 wh) := '';
 
EXPORT Make_home_office(SALT34.StrType s0) := s0;
EXPORT InValid_home_office(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_home_office(UNSIGNED1 wh) := '';
 
EXPORT Make_soho(SALT34.StrType s0) := s0;
EXPORT InValid_soho(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_soho(UNSIGNED1 wh) := '';
 
EXPORT Make_franchise(SALT34.StrType s0) := s0;
EXPORT InValid_franchise(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_franchise(UNSIGNED1 wh) := '';
 
EXPORT Make_phoneable(SALT34.StrType s0) := s0;
EXPORT InValid_phoneable(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_phoneable(UNSIGNED1 wh) := '';
 
EXPORT Make_prefix(SALT34.StrType s0) := s0;
EXPORT InValid_prefix(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_prefix(UNSIGNED1 wh) := '';
 
EXPORT Make_first_name(SALT34.StrType s0) := s0;
EXPORT InValid_first_name(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_first_name(UNSIGNED1 wh) := '';
 
EXPORT Make_middle_name(SALT34.StrType s0) := s0;
EXPORT InValid_middle_name(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_middle_name(UNSIGNED1 wh) := '';
 
EXPORT Make_surname(SALT34.StrType s0) := s0;
EXPORT InValid_surname(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_surname(UNSIGNED1 wh) := '';
 
EXPORT Make_suffix(SALT34.StrType s0) := s0;
EXPORT InValid_suffix(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_suffix(UNSIGNED1 wh) := '';
 
EXPORT Make_birth_year(SALT34.StrType s0) := s0;
EXPORT InValid_birth_year(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_birth_year(UNSIGNED1 wh) := '';
 
EXPORT Make_ethnicity(SALT34.StrType s0) := s0;
EXPORT InValid_ethnicity(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_ethnicity(UNSIGNED1 wh) := '';
 
EXPORT Make_gender(SALT34.StrType s0) := s0;
EXPORT InValid_gender(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_gender(UNSIGNED1 wh) := '';
 
EXPORT Make_email(SALT34.StrType s0) := s0;
EXPORT InValid_email(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_email(UNSIGNED1 wh) := '';
 
EXPORT Make_contact_title(SALT34.StrType s0) := s0;
EXPORT InValid_contact_title(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_contact_title(UNSIGNED1 wh) := '';
 
EXPORT Make_year_started(SALT34.StrType s0) := s0;
EXPORT InValid_year_started(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_year_started(UNSIGNED1 wh) := '';
 
EXPORT Make_date_added(SALT34.StrType s0) := s0;
EXPORT InValid_date_added(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_date_added(UNSIGNED1 wh) := '';
 
EXPORT Make_validationdate(SALT34.StrType s0) := s0;
EXPORT InValid_validationdate(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_validationdate(UNSIGNED1 wh) := '';
 
EXPORT Make_internal1(SALT34.StrType s0) := s0;
EXPORT InValid_internal1(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_internal1(UNSIGNED1 wh) := '';
 
EXPORT Make_dacd(SALT34.StrType s0) := s0;
EXPORT InValid_dacd(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_dacd(UNSIGNED1 wh) := '';
 
EXPORT Make_normcompany_type(SALT34.StrType s0) := s0;
EXPORT InValid_normcompany_type(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_normcompany_type(UNSIGNED1 wh) := '';
 
EXPORT Make_normcompany_name(SALT34.StrType s0) := s0;
EXPORT InValid_normcompany_name(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_normcompany_name(UNSIGNED1 wh) := '';
 
EXPORT Make_normcompany_street(SALT34.StrType s0) := s0;
EXPORT InValid_normcompany_street(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_normcompany_street(UNSIGNED1 wh) := '';
 
EXPORT Make_normcompany_city(SALT34.StrType s0) := s0;
EXPORT InValid_normcompany_city(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_normcompany_city(UNSIGNED1 wh) := '';
 
EXPORT Make_normcompany_state(SALT34.StrType s0) := s0;
EXPORT InValid_normcompany_state(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_normcompany_state(UNSIGNED1 wh) := '';
 
EXPORT Make_normcompany_zip(SALT34.StrType s0) := s0;
EXPORT InValid_normcompany_zip(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_normcompany_zip(UNSIGNED1 wh) := '';
 
EXPORT Make_normcompany_phone(SALT34.StrType s0) := s0;
EXPORT InValid_normcompany_phone(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_normcompany_phone(UNSIGNED1 wh) := '';
 
EXPORT Make_clean_company_name(SALT34.StrType s0) := s0;
EXPORT InValid_clean_company_name(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_clean_company_name(UNSIGNED1 wh) := '';
 
EXPORT Make_title(SALT34.StrType s0) := s0;
EXPORT InValid_title(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_title(UNSIGNED1 wh) := '';
 
EXPORT Make_fname(SALT34.StrType s0) := s0;
EXPORT InValid_fname(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_fname(UNSIGNED1 wh) := '';
 
EXPORT Make_mname(SALT34.StrType s0) := s0;
EXPORT InValid_mname(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_mname(UNSIGNED1 wh) := '';
 
EXPORT Make_lname(SALT34.StrType s0) := s0;
EXPORT InValid_lname(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_lname(UNSIGNED1 wh) := '';
 
EXPORT Make_name_suffix(SALT34.StrType s0) := s0;
EXPORT InValid_name_suffix(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_name_suffix(UNSIGNED1 wh) := '';
 
EXPORT Make_name_score(SALT34.StrType s0) := s0;
EXPORT InValid_name_score(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_name_score(UNSIGNED1 wh) := '';
 
EXPORT Make_prim_range(SALT34.StrType s0) := s0;
EXPORT InValid_prim_range(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_prim_range(UNSIGNED1 wh) := '';
 
EXPORT Make_predir(SALT34.StrType s0) := s0;
EXPORT InValid_predir(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_predir(UNSIGNED1 wh) := '';
 
EXPORT Make_prim_name(SALT34.StrType s0) := s0;
EXPORT InValid_prim_name(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_prim_name(UNSIGNED1 wh) := '';
 
EXPORT Make_addr_suffix(SALT34.StrType s0) := s0;
EXPORT InValid_addr_suffix(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_addr_suffix(UNSIGNED1 wh) := '';
 
EXPORT Make_postdir(SALT34.StrType s0) := s0;
EXPORT InValid_postdir(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_postdir(UNSIGNED1 wh) := '';
 
EXPORT Make_unit_desig(SALT34.StrType s0) := s0;
EXPORT InValid_unit_desig(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_unit_desig(UNSIGNED1 wh) := '';
 
EXPORT Make_sec_range(SALT34.StrType s0) := s0;
EXPORT InValid_sec_range(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_sec_range(UNSIGNED1 wh) := '';
 
EXPORT Make_p_city_name(SALT34.StrType s0) := s0;
EXPORT InValid_p_city_name(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_p_city_name(UNSIGNED1 wh) := '';
 
EXPORT Make_v_city_name(SALT34.StrType s0) := s0;
EXPORT InValid_v_city_name(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_v_city_name(UNSIGNED1 wh) := '';
 
EXPORT Make_st(SALT34.StrType s0) := s0;
EXPORT InValid_st(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_st(UNSIGNED1 wh) := '';
 
EXPORT Make_zip(SALT34.StrType s0) := s0;
EXPORT InValid_zip(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_zip(UNSIGNED1 wh) := '';
 
EXPORT Make_zip4(SALT34.StrType s0) := s0;
EXPORT InValid_zip4(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_zip4(UNSIGNED1 wh) := '';
 
EXPORT Make_cart(SALT34.StrType s0) := s0;
EXPORT InValid_cart(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_cart(UNSIGNED1 wh) := '';
 
EXPORT Make_cr_sort_sz(SALT34.StrType s0) := s0;
EXPORT InValid_cr_sort_sz(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_cr_sort_sz(UNSIGNED1 wh) := '';
 
EXPORT Make_lot(SALT34.StrType s0) := s0;
EXPORT InValid_lot(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_lot(UNSIGNED1 wh) := '';
 
EXPORT Make_lot_order(SALT34.StrType s0) := s0;
EXPORT InValid_lot_order(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_lot_order(UNSIGNED1 wh) := '';
 
EXPORT Make_dbpc(SALT34.StrType s0) := s0;
EXPORT InValid_dbpc(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_dbpc(UNSIGNED1 wh) := '';
 
EXPORT Make_chk_digit(SALT34.StrType s0) := s0;
EXPORT InValid_chk_digit(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_chk_digit(UNSIGNED1 wh) := '';
 
EXPORT Make_rec_type(SALT34.StrType s0) := s0;
EXPORT InValid_rec_type(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_rec_type(UNSIGNED1 wh) := '';
 
EXPORT Make_fips_state(SALT34.StrType s0) := s0;
EXPORT InValid_fips_state(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_fips_state(UNSIGNED1 wh) := '';
 
EXPORT Make_fips_county(SALT34.StrType s0) := s0;
EXPORT InValid_fips_county(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_fips_county(UNSIGNED1 wh) := '';
 
EXPORT Make_geo_lat(SALT34.StrType s0) := s0;
EXPORT InValid_geo_lat(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_geo_lat(UNSIGNED1 wh) := '';
 
EXPORT Make_geo_long(SALT34.StrType s0) := s0;
EXPORT InValid_geo_long(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_geo_long(UNSIGNED1 wh) := '';
 
EXPORT Make_msa(SALT34.StrType s0) := s0;
EXPORT InValid_msa(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_msa(UNSIGNED1 wh) := '';
 
EXPORT Make_geo_blk(SALT34.StrType s0) := s0;
EXPORT InValid_geo_blk(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_geo_blk(UNSIGNED1 wh) := '';
 
EXPORT Make_geo_match(SALT34.StrType s0) := s0;
EXPORT InValid_geo_match(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_geo_match(UNSIGNED1 wh) := '';
 
EXPORT Make_err_stat(SALT34.StrType s0) := s0;
EXPORT InValid_err_stat(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_err_stat(UNSIGNED1 wh) := '';
 
EXPORT Make_clean_phone(SALT34.StrType s0) := s0;
EXPORT InValid_clean_phone(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_clean_phone(UNSIGNED1 wh) := '';
 
EXPORT Make_raw_aid(SALT34.StrType s0) := s0;
EXPORT InValid_raw_aid(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_raw_aid(UNSIGNED1 wh) := '';
 
EXPORT Make_ace_aid(SALT34.StrType s0) := s0;
EXPORT InValid_ace_aid(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_ace_aid(UNSIGNED1 wh) := '';
 
EXPORT Make_prep_address_line1(SALT34.StrType s0) := s0;
EXPORT InValid_prep_address_line1(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_prep_address_line1(UNSIGNED1 wh) := '';
 
EXPORT Make_prep_address_line_last(SALT34.StrType s0) := s0;
EXPORT InValid_prep_address_line_last(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_prep_address_line_last(UNSIGNED1 wh) := '';
 
// This macro will compute and count field level differences based upon a pivot expression
export MAC_CountDifferencesByPivot(in_left,in_right,pivot_exp,bad_pivots,out_counts) := MACRO
  IMPORT SALT34,infutor_narb;
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
    BOOLEAN Diff_seleid;
    BOOLEAN Diff_selescore;
    BOOLEAN Diff_seleweight;
    BOOLEAN Diff_orgid;
    BOOLEAN Diff_orgscore;
    BOOLEAN Diff_orgweight;
    BOOLEAN Diff_ultid;
    BOOLEAN Diff_ultscore;
    BOOLEAN Diff_ultweight;
    BOOLEAN Diff_did;
    BOOLEAN Diff_did_score;
    BOOLEAN Diff_dt_first_seen;
    BOOLEAN Diff_dt_last_seen;
    BOOLEAN Diff_dt_vendor_first_reported;
    BOOLEAN Diff_dt_vendor_last_reported;
    BOOLEAN Diff_record_type;
    BOOLEAN Diff_pid;
    BOOLEAN Diff_record_id;
    BOOLEAN Diff_ein;
    BOOLEAN Diff_busname;
    BOOLEAN Diff_tradename;
    BOOLEAN Diff_house;
    BOOLEAN Diff_predirection;
    BOOLEAN Diff_street;
    BOOLEAN Diff_strtype;
    BOOLEAN Diff_postdirection;
    BOOLEAN Diff_apttype;
    BOOLEAN Diff_aptnbr;
    BOOLEAN Diff_city;
    BOOLEAN Diff_state;
    BOOLEAN Diff_zip5;
    BOOLEAN Diff_ziplast4;
    BOOLEAN Diff_dpc;
    BOOLEAN Diff_carrier_route;
    BOOLEAN Diff_address_type_code;
    BOOLEAN Diff_dpv_code;
    BOOLEAN Diff_mailable;
    BOOLEAN Diff_county_code;
    BOOLEAN Diff_censustract;
    BOOLEAN Diff_censusblockgroup;
    BOOLEAN Diff_censusblock;
    BOOLEAN Diff_congress_code;
    BOOLEAN Diff_msacode;
    BOOLEAN Diff_timezonecode;
    BOOLEAN Diff_latitude;
    BOOLEAN Diff_longitude;
    BOOLEAN Diff_url;
    BOOLEAN Diff_telephone;
    BOOLEAN Diff_toll_free_number;
    BOOLEAN Diff_fax;
    BOOLEAN Diff_sic1;
    BOOLEAN Diff_sic2;
    BOOLEAN Diff_sic3;
    BOOLEAN Diff_sic4;
    BOOLEAN Diff_sic5;
    BOOLEAN Diff_stdclass;
    BOOLEAN Diff_heading1;
    BOOLEAN Diff_heading2;
    BOOLEAN Diff_heading3;
    BOOLEAN Diff_heading4;
    BOOLEAN Diff_heading5;
    BOOLEAN Diff_business_specialty;
    BOOLEAN Diff_sales_code;
    BOOLEAN Diff_employee_code;
    BOOLEAN Diff_location_type;
    BOOLEAN Diff_parent_company;
    BOOLEAN Diff_parent_address;
    BOOLEAN Diff_parent_city;
    BOOLEAN Diff_parent_state;
    BOOLEAN Diff_parent_zip;
    BOOLEAN Diff_parent_phone;
    BOOLEAN Diff_stock_symbol;
    BOOLEAN Diff_stock_exchange;
    BOOLEAN Diff_public;
    BOOLEAN Diff_number_of_pcs;
    BOOLEAN Diff_square_footage;
    BOOLEAN Diff_business_type;
    BOOLEAN Diff_incorporation_state;
    BOOLEAN Diff_minority;
    BOOLEAN Diff_woman;
    BOOLEAN Diff_government;
    BOOLEAN Diff_small;
    BOOLEAN Diff_home_office;
    BOOLEAN Diff_soho;
    BOOLEAN Diff_franchise;
    BOOLEAN Diff_phoneable;
    BOOLEAN Diff_prefix;
    BOOLEAN Diff_first_name;
    BOOLEAN Diff_middle_name;
    BOOLEAN Diff_surname;
    BOOLEAN Diff_suffix;
    BOOLEAN Diff_birth_year;
    BOOLEAN Diff_ethnicity;
    BOOLEAN Diff_gender;
    BOOLEAN Diff_email;
    BOOLEAN Diff_contact_title;
    BOOLEAN Diff_year_started;
    BOOLEAN Diff_date_added;
    BOOLEAN Diff_validationdate;
    BOOLEAN Diff_internal1;
    BOOLEAN Diff_dacd;
    BOOLEAN Diff_normcompany_type;
    BOOLEAN Diff_normcompany_name;
    BOOLEAN Diff_normcompany_street;
    BOOLEAN Diff_normcompany_city;
    BOOLEAN Diff_normcompany_state;
    BOOLEAN Diff_normcompany_zip;
    BOOLEAN Diff_normcompany_phone;
    BOOLEAN Diff_clean_company_name;
    BOOLEAN Diff_title;
    BOOLEAN Diff_fname;
    BOOLEAN Diff_mname;
    BOOLEAN Diff_lname;
    BOOLEAN Diff_name_suffix;
    BOOLEAN Diff_name_score;
    BOOLEAN Diff_prim_range;
    BOOLEAN Diff_predir;
    BOOLEAN Diff_prim_name;
    BOOLEAN Diff_addr_suffix;
    BOOLEAN Diff_postdir;
    BOOLEAN Diff_unit_desig;
    BOOLEAN Diff_sec_range;
    BOOLEAN Diff_p_city_name;
    BOOLEAN Diff_v_city_name;
    BOOLEAN Diff_st;
    BOOLEAN Diff_zip;
    BOOLEAN Diff_zip4;
    BOOLEAN Diff_cart;
    BOOLEAN Diff_cr_sort_sz;
    BOOLEAN Diff_lot;
    BOOLEAN Diff_lot_order;
    BOOLEAN Diff_dbpc;
    BOOLEAN Diff_chk_digit;
    BOOLEAN Diff_rec_type;
    BOOLEAN Diff_fips_state;
    BOOLEAN Diff_fips_county;
    BOOLEAN Diff_geo_lat;
    BOOLEAN Diff_geo_long;
    BOOLEAN Diff_msa;
    BOOLEAN Diff_geo_blk;
    BOOLEAN Diff_geo_match;
    BOOLEAN Diff_err_stat;
    BOOLEAN Diff_clean_phone;
    BOOLEAN Diff_raw_aid;
    BOOLEAN Diff_ace_aid;
    BOOLEAN Diff_prep_address_line1;
    BOOLEAN Diff_prep_address_line_last;
    SALT34.StrType SourceField {MAXLENGTH(30)};
    UNSIGNED Num_Diffs;
    SALT34.StrType Val {MAXLENGTH(1024)};
  END;
#uniquename(fd)
  %dl% %fd%(in_left le,in_right ri) := TRANSFORM
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
    SELF.Diff_seleid := le.seleid <> ri.seleid;
    SELF.Diff_selescore := le.selescore <> ri.selescore;
    SELF.Diff_seleweight := le.seleweight <> ri.seleweight;
    SELF.Diff_orgid := le.orgid <> ri.orgid;
    SELF.Diff_orgscore := le.orgscore <> ri.orgscore;
    SELF.Diff_orgweight := le.orgweight <> ri.orgweight;
    SELF.Diff_ultid := le.ultid <> ri.ultid;
    SELF.Diff_ultscore := le.ultscore <> ri.ultscore;
    SELF.Diff_ultweight := le.ultweight <> ri.ultweight;
    SELF.Diff_did := le.did <> ri.did;
    SELF.Diff_did_score := le.did_score <> ri.did_score;
    SELF.Diff_dt_first_seen := le.dt_first_seen <> ri.dt_first_seen;
    SELF.Diff_dt_last_seen := le.dt_last_seen <> ri.dt_last_seen;
    SELF.Diff_dt_vendor_first_reported := le.dt_vendor_first_reported <> ri.dt_vendor_first_reported;
    SELF.Diff_dt_vendor_last_reported := le.dt_vendor_last_reported <> ri.dt_vendor_last_reported;
    SELF.Diff_record_type := le.record_type <> ri.record_type;
    SELF.Diff_pid := le.pid <> ri.pid;
    SELF.Diff_record_id := le.record_id <> ri.record_id;
    SELF.Diff_ein := le.ein <> ri.ein;
    SELF.Diff_busname := le.busname <> ri.busname;
    SELF.Diff_tradename := le.tradename <> ri.tradename;
    SELF.Diff_house := le.house <> ri.house;
    SELF.Diff_predirection := le.predirection <> ri.predirection;
    SELF.Diff_street := le.street <> ri.street;
    SELF.Diff_strtype := le.strtype <> ri.strtype;
    SELF.Diff_postdirection := le.postdirection <> ri.postdirection;
    SELF.Diff_apttype := le.apttype <> ri.apttype;
    SELF.Diff_aptnbr := le.aptnbr <> ri.aptnbr;
    SELF.Diff_city := le.city <> ri.city;
    SELF.Diff_state := le.state <> ri.state;
    SELF.Diff_zip5 := le.zip5 <> ri.zip5;
    SELF.Diff_ziplast4 := le.ziplast4 <> ri.ziplast4;
    SELF.Diff_dpc := le.dpc <> ri.dpc;
    SELF.Diff_carrier_route := le.carrier_route <> ri.carrier_route;
    SELF.Diff_address_type_code := le.address_type_code <> ri.address_type_code;
    SELF.Diff_dpv_code := le.dpv_code <> ri.dpv_code;
    SELF.Diff_mailable := le.mailable <> ri.mailable;
    SELF.Diff_county_code := le.county_code <> ri.county_code;
    SELF.Diff_censustract := le.censustract <> ri.censustract;
    SELF.Diff_censusblockgroup := le.censusblockgroup <> ri.censusblockgroup;
    SELF.Diff_censusblock := le.censusblock <> ri.censusblock;
    SELF.Diff_congress_code := le.congress_code <> ri.congress_code;
    SELF.Diff_msacode := le.msacode <> ri.msacode;
    SELF.Diff_timezonecode := le.timezonecode <> ri.timezonecode;
    SELF.Diff_latitude := le.latitude <> ri.latitude;
    SELF.Diff_longitude := le.longitude <> ri.longitude;
    SELF.Diff_url := le.url <> ri.url;
    SELF.Diff_telephone := le.telephone <> ri.telephone;
    SELF.Diff_toll_free_number := le.toll_free_number <> ri.toll_free_number;
    SELF.Diff_fax := le.fax <> ri.fax;
    SELF.Diff_sic1 := le.sic1 <> ri.sic1;
    SELF.Diff_sic2 := le.sic2 <> ri.sic2;
    SELF.Diff_sic3 := le.sic3 <> ri.sic3;
    SELF.Diff_sic4 := le.sic4 <> ri.sic4;
    SELF.Diff_sic5 := le.sic5 <> ri.sic5;
    SELF.Diff_stdclass := le.stdclass <> ri.stdclass;
    SELF.Diff_heading1 := le.heading1 <> ri.heading1;
    SELF.Diff_heading2 := le.heading2 <> ri.heading2;
    SELF.Diff_heading3 := le.heading3 <> ri.heading3;
    SELF.Diff_heading4 := le.heading4 <> ri.heading4;
    SELF.Diff_heading5 := le.heading5 <> ri.heading5;
    SELF.Diff_business_specialty := le.business_specialty <> ri.business_specialty;
    SELF.Diff_sales_code := le.sales_code <> ri.sales_code;
    SELF.Diff_employee_code := le.employee_code <> ri.employee_code;
    SELF.Diff_location_type := le.location_type <> ri.location_type;
    SELF.Diff_parent_company := le.parent_company <> ri.parent_company;
    SELF.Diff_parent_address := le.parent_address <> ri.parent_address;
    SELF.Diff_parent_city := le.parent_city <> ri.parent_city;
    SELF.Diff_parent_state := le.parent_state <> ri.parent_state;
    SELF.Diff_parent_zip := le.parent_zip <> ri.parent_zip;
    SELF.Diff_parent_phone := le.parent_phone <> ri.parent_phone;
    SELF.Diff_stock_symbol := le.stock_symbol <> ri.stock_symbol;
    SELF.Diff_stock_exchange := le.stock_exchange <> ri.stock_exchange;
    SELF.Diff_public := le.public <> ri.public;
    SELF.Diff_number_of_pcs := le.number_of_pcs <> ri.number_of_pcs;
    SELF.Diff_square_footage := le.square_footage <> ri.square_footage;
    SELF.Diff_business_type := le.business_type <> ri.business_type;
    SELF.Diff_incorporation_state := le.incorporation_state <> ri.incorporation_state;
    SELF.Diff_minority := le.minority <> ri.minority;
    SELF.Diff_woman := le.woman <> ri.woman;
    SELF.Diff_government := le.government <> ri.government;
    SELF.Diff_small := le.small <> ri.small;
    SELF.Diff_home_office := le.home_office <> ri.home_office;
    SELF.Diff_soho := le.soho <> ri.soho;
    SELF.Diff_franchise := le.franchise <> ri.franchise;
    SELF.Diff_phoneable := le.phoneable <> ri.phoneable;
    SELF.Diff_prefix := le.prefix <> ri.prefix;
    SELF.Diff_first_name := le.first_name <> ri.first_name;
    SELF.Diff_middle_name := le.middle_name <> ri.middle_name;
    SELF.Diff_surname := le.surname <> ri.surname;
    SELF.Diff_suffix := le.suffix <> ri.suffix;
    SELF.Diff_birth_year := le.birth_year <> ri.birth_year;
    SELF.Diff_ethnicity := le.ethnicity <> ri.ethnicity;
    SELF.Diff_gender := le.gender <> ri.gender;
    SELF.Diff_email := le.email <> ri.email;
    SELF.Diff_contact_title := le.contact_title <> ri.contact_title;
    SELF.Diff_year_started := le.year_started <> ri.year_started;
    SELF.Diff_date_added := le.date_added <> ri.date_added;
    SELF.Diff_validationdate := le.validationdate <> ri.validationdate;
    SELF.Diff_internal1 := le.internal1 <> ri.internal1;
    SELF.Diff_dacd := le.dacd <> ri.dacd;
    SELF.Diff_normcompany_type := le.normcompany_type <> ri.normcompany_type;
    SELF.Diff_normcompany_name := le.normcompany_name <> ri.normcompany_name;
    SELF.Diff_normcompany_street := le.normcompany_street <> ri.normcompany_street;
    SELF.Diff_normcompany_city := le.normcompany_city <> ri.normcompany_city;
    SELF.Diff_normcompany_state := le.normcompany_state <> ri.normcompany_state;
    SELF.Diff_normcompany_zip := le.normcompany_zip <> ri.normcompany_zip;
    SELF.Diff_normcompany_phone := le.normcompany_phone <> ri.normcompany_phone;
    SELF.Diff_clean_company_name := le.clean_company_name <> ri.clean_company_name;
    SELF.Diff_title := le.title <> ri.title;
    SELF.Diff_fname := le.fname <> ri.fname;
    SELF.Diff_mname := le.mname <> ri.mname;
    SELF.Diff_lname := le.lname <> ri.lname;
    SELF.Diff_name_suffix := le.name_suffix <> ri.name_suffix;
    SELF.Diff_name_score := le.name_score <> ri.name_score;
    SELF.Diff_prim_range := le.prim_range <> ri.prim_range;
    SELF.Diff_predir := le.predir <> ri.predir;
    SELF.Diff_prim_name := le.prim_name <> ri.prim_name;
    SELF.Diff_addr_suffix := le.addr_suffix <> ri.addr_suffix;
    SELF.Diff_postdir := le.postdir <> ri.postdir;
    SELF.Diff_unit_desig := le.unit_desig <> ri.unit_desig;
    SELF.Diff_sec_range := le.sec_range <> ri.sec_range;
    SELF.Diff_p_city_name := le.p_city_name <> ri.p_city_name;
    SELF.Diff_v_city_name := le.v_city_name <> ri.v_city_name;
    SELF.Diff_st := le.st <> ri.st;
    SELF.Diff_zip := le.zip <> ri.zip;
    SELF.Diff_zip4 := le.zip4 <> ri.zip4;
    SELF.Diff_cart := le.cart <> ri.cart;
    SELF.Diff_cr_sort_sz := le.cr_sort_sz <> ri.cr_sort_sz;
    SELF.Diff_lot := le.lot <> ri.lot;
    SELF.Diff_lot_order := le.lot_order <> ri.lot_order;
    SELF.Diff_dbpc := le.dbpc <> ri.dbpc;
    SELF.Diff_chk_digit := le.chk_digit <> ri.chk_digit;
    SELF.Diff_rec_type := le.rec_type <> ri.rec_type;
    SELF.Diff_fips_state := le.fips_state <> ri.fips_state;
    SELF.Diff_fips_county := le.fips_county <> ri.fips_county;
    SELF.Diff_geo_lat := le.geo_lat <> ri.geo_lat;
    SELF.Diff_geo_long := le.geo_long <> ri.geo_long;
    SELF.Diff_msa := le.msa <> ri.msa;
    SELF.Diff_geo_blk := le.geo_blk <> ri.geo_blk;
    SELF.Diff_geo_match := le.geo_match <> ri.geo_match;
    SELF.Diff_err_stat := le.err_stat <> ri.err_stat;
    SELF.Diff_clean_phone := le.clean_phone <> ri.clean_phone;
    SELF.Diff_raw_aid := le.raw_aid <> ri.raw_aid;
    SELF.Diff_ace_aid := le.ace_aid <> ri.ace_aid;
    SELF.Diff_prep_address_line1 := le.prep_address_line1 <> ri.prep_address_line1;
    SELF.Diff_prep_address_line_last := le.prep_address_line_last <> ri.prep_address_line_last;
    SELF.Val := (SALT34.StrType)evaluate(le,pivot_exp);
    SELF.SourceField := le.source;
    SELF.Num_Diffs := 0+ IF( SELF.Diff_process_date,1,0)+ IF( SELF.Diff_dotid,1,0)+ IF( SELF.Diff_dotscore,1,0)+ IF( SELF.Diff_dotweight,1,0)+ IF( SELF.Diff_empid,1,0)+ IF( SELF.Diff_empscore,1,0)+ IF( SELF.Diff_empweight,1,0)+ IF( SELF.Diff_powid,1,0)+ IF( SELF.Diff_powscore,1,0)+ IF( SELF.Diff_powweight,1,0)+ IF( SELF.Diff_proxid,1,0)+ IF( SELF.Diff_proxscore,1,0)+ IF( SELF.Diff_proxweight,1,0)+ IF( SELF.Diff_seleid,1,0)+ IF( SELF.Diff_selescore,1,0)+ IF( SELF.Diff_seleweight,1,0)+ IF( SELF.Diff_orgid,1,0)+ IF( SELF.Diff_orgscore,1,0)+ IF( SELF.Diff_orgweight,1,0)+ IF( SELF.Diff_ultid,1,0)+ IF( SELF.Diff_ultscore,1,0)+ IF( SELF.Diff_ultweight,1,0)+ IF( SELF.Diff_did,1,0)+ IF( SELF.Diff_did_score,1,0)+ IF( SELF.Diff_dt_first_seen,1,0)+ IF( SELF.Diff_dt_last_seen,1,0)+ IF( SELF.Diff_dt_vendor_first_reported,1,0)+ IF( SELF.Diff_dt_vendor_last_reported,1,0)+ IF( SELF.Diff_record_type,1,0)+ IF( SELF.Diff_pid,1,0)+ IF( SELF.Diff_record_id,1,0)+ IF( SELF.Diff_ein,1,0)+ IF( SELF.Diff_busname,1,0)+ IF( SELF.Diff_tradename,1,0)+ IF( SELF.Diff_house,1,0)+ IF( SELF.Diff_predirection,1,0)+ IF( SELF.Diff_street,1,0)+ IF( SELF.Diff_strtype,1,0)+ IF( SELF.Diff_postdirection,1,0)+ IF( SELF.Diff_apttype,1,0)+ IF( SELF.Diff_aptnbr,1,0)+ IF( SELF.Diff_city,1,0)+ IF( SELF.Diff_state,1,0)+ IF( SELF.Diff_zip5,1,0)+ IF( SELF.Diff_ziplast4,1,0)+ IF( SELF.Diff_dpc,1,0)+ IF( SELF.Diff_carrier_route,1,0)+ IF( SELF.Diff_address_type_code,1,0)+ IF( SELF.Diff_dpv_code,1,0)+ IF( SELF.Diff_mailable,1,0)+ IF( SELF.Diff_county_code,1,0)+ IF( SELF.Diff_censustract,1,0)+ IF( SELF.Diff_censusblockgroup,1,0)+ IF( SELF.Diff_censusblock,1,0)+ IF( SELF.Diff_congress_code,1,0)+ IF( SELF.Diff_msacode,1,0)+ IF( SELF.Diff_timezonecode,1,0)+ IF( SELF.Diff_latitude,1,0)+ IF( SELF.Diff_longitude,1,0)+ IF( SELF.Diff_url,1,0)+ IF( SELF.Diff_telephone,1,0)+ IF( SELF.Diff_toll_free_number,1,0)+ IF( SELF.Diff_fax,1,0)+ IF( SELF.Diff_sic1,1,0)+ IF( SELF.Diff_sic2,1,0)+ IF( SELF.Diff_sic3,1,0)+ IF( SELF.Diff_sic4,1,0)+ IF( SELF.Diff_sic5,1,0)+ IF( SELF.Diff_stdclass,1,0)+ IF( SELF.Diff_heading1,1,0)+ IF( SELF.Diff_heading2,1,0)+ IF( SELF.Diff_heading3,1,0)+ IF( SELF.Diff_heading4,1,0)+ IF( SELF.Diff_heading5,1,0)+ IF( SELF.Diff_business_specialty,1,0)+ IF( SELF.Diff_sales_code,1,0)+ IF( SELF.Diff_employee_code,1,0)+ IF( SELF.Diff_location_type,1,0)+ IF( SELF.Diff_parent_company,1,0)+ IF( SELF.Diff_parent_address,1,0)+ IF( SELF.Diff_parent_city,1,0)+ IF( SELF.Diff_parent_state,1,0)+ IF( SELF.Diff_parent_zip,1,0)+ IF( SELF.Diff_parent_phone,1,0)+ IF( SELF.Diff_stock_symbol,1,0)+ IF( SELF.Diff_stock_exchange,1,0)+ IF( SELF.Diff_public,1,0)+ IF( SELF.Diff_number_of_pcs,1,0)+ IF( SELF.Diff_square_footage,1,0)+ IF( SELF.Diff_business_type,1,0)+ IF( SELF.Diff_incorporation_state,1,0)+ IF( SELF.Diff_minority,1,0)+ IF( SELF.Diff_woman,1,0)+ IF( SELF.Diff_government,1,0)+ IF( SELF.Diff_small,1,0)+ IF( SELF.Diff_home_office,1,0)+ IF( SELF.Diff_soho,1,0)+ IF( SELF.Diff_franchise,1,0)+ IF( SELF.Diff_phoneable,1,0)+ IF( SELF.Diff_prefix,1,0)+ IF( SELF.Diff_first_name,1,0)+ IF( SELF.Diff_middle_name,1,0)+ IF( SELF.Diff_surname,1,0)+ IF( SELF.Diff_suffix,1,0)+ IF( SELF.Diff_birth_year,1,0)+ IF( SELF.Diff_ethnicity,1,0)+ IF( SELF.Diff_gender,1,0)+ IF( SELF.Diff_email,1,0)+ IF( SELF.Diff_contact_title,1,0)+ IF( SELF.Diff_year_started,1,0)+ IF( SELF.Diff_date_added,1,0)+ IF( SELF.Diff_validationdate,1,0)+ IF( SELF.Diff_internal1,1,0)+ IF( SELF.Diff_dacd,1,0)+ IF( SELF.Diff_normcompany_type,1,0)+ IF( SELF.Diff_normcompany_name,1,0)+ IF( SELF.Diff_normcompany_street,1,0)+ IF( SELF.Diff_normcompany_city,1,0)+ IF( SELF.Diff_normcompany_state,1,0)+ IF( SELF.Diff_normcompany_zip,1,0)+ IF( SELF.Diff_normcompany_phone,1,0)+ IF( SELF.Diff_clean_company_name,1,0)+ IF( SELF.Diff_title,1,0)+ IF( SELF.Diff_fname,1,0)+ IF( SELF.Diff_mname,1,0)+ IF( SELF.Diff_lname,1,0)+ IF( SELF.Diff_name_suffix,1,0)+ IF( SELF.Diff_name_score,1,0)+ IF( SELF.Diff_prim_range,1,0)+ IF( SELF.Diff_predir,1,0)+ IF( SELF.Diff_prim_name,1,0)+ IF( SELF.Diff_addr_suffix,1,0)+ IF( SELF.Diff_postdir,1,0)+ IF( SELF.Diff_unit_desig,1,0)+ IF( SELF.Diff_sec_range,1,0)+ IF( SELF.Diff_p_city_name,1,0)+ IF( SELF.Diff_v_city_name,1,0)+ IF( SELF.Diff_st,1,0)+ IF( SELF.Diff_zip,1,0)+ IF( SELF.Diff_zip4,1,0)+ IF( SELF.Diff_cart,1,0)+ IF( SELF.Diff_cr_sort_sz,1,0)+ IF( SELF.Diff_lot,1,0)+ IF( SELF.Diff_lot_order,1,0)+ IF( SELF.Diff_dbpc,1,0)+ IF( SELF.Diff_chk_digit,1,0)+ IF( SELF.Diff_rec_type,1,0)+ IF( SELF.Diff_fips_state,1,0)+ IF( SELF.Diff_fips_county,1,0)+ IF( SELF.Diff_geo_lat,1,0)+ IF( SELF.Diff_geo_long,1,0)+ IF( SELF.Diff_msa,1,0)+ IF( SELF.Diff_geo_blk,1,0)+ IF( SELF.Diff_geo_match,1,0)+ IF( SELF.Diff_err_stat,1,0)+ IF( SELF.Diff_clean_phone,1,0)+ IF( SELF.Diff_raw_aid,1,0)+ IF( SELF.Diff_ace_aid,1,0)+ IF( SELF.Diff_prep_address_line1,1,0)+ IF( SELF.Diff_prep_address_line_last,1,0);
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
    Count_Diff_seleid := COUNT(GROUP,%Closest%.Diff_seleid);
    Count_Diff_selescore := COUNT(GROUP,%Closest%.Diff_selescore);
    Count_Diff_seleweight := COUNT(GROUP,%Closest%.Diff_seleweight);
    Count_Diff_orgid := COUNT(GROUP,%Closest%.Diff_orgid);
    Count_Diff_orgscore := COUNT(GROUP,%Closest%.Diff_orgscore);
    Count_Diff_orgweight := COUNT(GROUP,%Closest%.Diff_orgweight);
    Count_Diff_ultid := COUNT(GROUP,%Closest%.Diff_ultid);
    Count_Diff_ultscore := COUNT(GROUP,%Closest%.Diff_ultscore);
    Count_Diff_ultweight := COUNT(GROUP,%Closest%.Diff_ultweight);
    Count_Diff_did := COUNT(GROUP,%Closest%.Diff_did);
    Count_Diff_did_score := COUNT(GROUP,%Closest%.Diff_did_score);
    Count_Diff_dt_first_seen := COUNT(GROUP,%Closest%.Diff_dt_first_seen);
    Count_Diff_dt_last_seen := COUNT(GROUP,%Closest%.Diff_dt_last_seen);
    Count_Diff_dt_vendor_first_reported := COUNT(GROUP,%Closest%.Diff_dt_vendor_first_reported);
    Count_Diff_dt_vendor_last_reported := COUNT(GROUP,%Closest%.Diff_dt_vendor_last_reported);
    Count_Diff_record_type := COUNT(GROUP,%Closest%.Diff_record_type);
    Count_Diff_pid := COUNT(GROUP,%Closest%.Diff_pid);
    Count_Diff_record_id := COUNT(GROUP,%Closest%.Diff_record_id);
    Count_Diff_ein := COUNT(GROUP,%Closest%.Diff_ein);
    Count_Diff_busname := COUNT(GROUP,%Closest%.Diff_busname);
    Count_Diff_tradename := COUNT(GROUP,%Closest%.Diff_tradename);
    Count_Diff_house := COUNT(GROUP,%Closest%.Diff_house);
    Count_Diff_predirection := COUNT(GROUP,%Closest%.Diff_predirection);
    Count_Diff_street := COUNT(GROUP,%Closest%.Diff_street);
    Count_Diff_strtype := COUNT(GROUP,%Closest%.Diff_strtype);
    Count_Diff_postdirection := COUNT(GROUP,%Closest%.Diff_postdirection);
    Count_Diff_apttype := COUNT(GROUP,%Closest%.Diff_apttype);
    Count_Diff_aptnbr := COUNT(GROUP,%Closest%.Diff_aptnbr);
    Count_Diff_city := COUNT(GROUP,%Closest%.Diff_city);
    Count_Diff_state := COUNT(GROUP,%Closest%.Diff_state);
    Count_Diff_zip5 := COUNT(GROUP,%Closest%.Diff_zip5);
    Count_Diff_ziplast4 := COUNT(GROUP,%Closest%.Diff_ziplast4);
    Count_Diff_dpc := COUNT(GROUP,%Closest%.Diff_dpc);
    Count_Diff_carrier_route := COUNT(GROUP,%Closest%.Diff_carrier_route);
    Count_Diff_address_type_code := COUNT(GROUP,%Closest%.Diff_address_type_code);
    Count_Diff_dpv_code := COUNT(GROUP,%Closest%.Diff_dpv_code);
    Count_Diff_mailable := COUNT(GROUP,%Closest%.Diff_mailable);
    Count_Diff_county_code := COUNT(GROUP,%Closest%.Diff_county_code);
    Count_Diff_censustract := COUNT(GROUP,%Closest%.Diff_censustract);
    Count_Diff_censusblockgroup := COUNT(GROUP,%Closest%.Diff_censusblockgroup);
    Count_Diff_censusblock := COUNT(GROUP,%Closest%.Diff_censusblock);
    Count_Diff_congress_code := COUNT(GROUP,%Closest%.Diff_congress_code);
    Count_Diff_msacode := COUNT(GROUP,%Closest%.Diff_msacode);
    Count_Diff_timezonecode := COUNT(GROUP,%Closest%.Diff_timezonecode);
    Count_Diff_latitude := COUNT(GROUP,%Closest%.Diff_latitude);
    Count_Diff_longitude := COUNT(GROUP,%Closest%.Diff_longitude);
    Count_Diff_url := COUNT(GROUP,%Closest%.Diff_url);
    Count_Diff_telephone := COUNT(GROUP,%Closest%.Diff_telephone);
    Count_Diff_toll_free_number := COUNT(GROUP,%Closest%.Diff_toll_free_number);
    Count_Diff_fax := COUNT(GROUP,%Closest%.Diff_fax);
    Count_Diff_sic1 := COUNT(GROUP,%Closest%.Diff_sic1);
    Count_Diff_sic2 := COUNT(GROUP,%Closest%.Diff_sic2);
    Count_Diff_sic3 := COUNT(GROUP,%Closest%.Diff_sic3);
    Count_Diff_sic4 := COUNT(GROUP,%Closest%.Diff_sic4);
    Count_Diff_sic5 := COUNT(GROUP,%Closest%.Diff_sic5);
    Count_Diff_stdclass := COUNT(GROUP,%Closest%.Diff_stdclass);
    Count_Diff_heading1 := COUNT(GROUP,%Closest%.Diff_heading1);
    Count_Diff_heading2 := COUNT(GROUP,%Closest%.Diff_heading2);
    Count_Diff_heading3 := COUNT(GROUP,%Closest%.Diff_heading3);
    Count_Diff_heading4 := COUNT(GROUP,%Closest%.Diff_heading4);
    Count_Diff_heading5 := COUNT(GROUP,%Closest%.Diff_heading5);
    Count_Diff_business_specialty := COUNT(GROUP,%Closest%.Diff_business_specialty);
    Count_Diff_sales_code := COUNT(GROUP,%Closest%.Diff_sales_code);
    Count_Diff_employee_code := COUNT(GROUP,%Closest%.Diff_employee_code);
    Count_Diff_location_type := COUNT(GROUP,%Closest%.Diff_location_type);
    Count_Diff_parent_company := COUNT(GROUP,%Closest%.Diff_parent_company);
    Count_Diff_parent_address := COUNT(GROUP,%Closest%.Diff_parent_address);
    Count_Diff_parent_city := COUNT(GROUP,%Closest%.Diff_parent_city);
    Count_Diff_parent_state := COUNT(GROUP,%Closest%.Diff_parent_state);
    Count_Diff_parent_zip := COUNT(GROUP,%Closest%.Diff_parent_zip);
    Count_Diff_parent_phone := COUNT(GROUP,%Closest%.Diff_parent_phone);
    Count_Diff_stock_symbol := COUNT(GROUP,%Closest%.Diff_stock_symbol);
    Count_Diff_stock_exchange := COUNT(GROUP,%Closest%.Diff_stock_exchange);
    Count_Diff_public := COUNT(GROUP,%Closest%.Diff_public);
    Count_Diff_number_of_pcs := COUNT(GROUP,%Closest%.Diff_number_of_pcs);
    Count_Diff_square_footage := COUNT(GROUP,%Closest%.Diff_square_footage);
    Count_Diff_business_type := COUNT(GROUP,%Closest%.Diff_business_type);
    Count_Diff_incorporation_state := COUNT(GROUP,%Closest%.Diff_incorporation_state);
    Count_Diff_minority := COUNT(GROUP,%Closest%.Diff_minority);
    Count_Diff_woman := COUNT(GROUP,%Closest%.Diff_woman);
    Count_Diff_government := COUNT(GROUP,%Closest%.Diff_government);
    Count_Diff_small := COUNT(GROUP,%Closest%.Diff_small);
    Count_Diff_home_office := COUNT(GROUP,%Closest%.Diff_home_office);
    Count_Diff_soho := COUNT(GROUP,%Closest%.Diff_soho);
    Count_Diff_franchise := COUNT(GROUP,%Closest%.Diff_franchise);
    Count_Diff_phoneable := COUNT(GROUP,%Closest%.Diff_phoneable);
    Count_Diff_prefix := COUNT(GROUP,%Closest%.Diff_prefix);
    Count_Diff_first_name := COUNT(GROUP,%Closest%.Diff_first_name);
    Count_Diff_middle_name := COUNT(GROUP,%Closest%.Diff_middle_name);
    Count_Diff_surname := COUNT(GROUP,%Closest%.Diff_surname);
    Count_Diff_suffix := COUNT(GROUP,%Closest%.Diff_suffix);
    Count_Diff_birth_year := COUNT(GROUP,%Closest%.Diff_birth_year);
    Count_Diff_ethnicity := COUNT(GROUP,%Closest%.Diff_ethnicity);
    Count_Diff_gender := COUNT(GROUP,%Closest%.Diff_gender);
    Count_Diff_email := COUNT(GROUP,%Closest%.Diff_email);
    Count_Diff_contact_title := COUNT(GROUP,%Closest%.Diff_contact_title);
    Count_Diff_year_started := COUNT(GROUP,%Closest%.Diff_year_started);
    Count_Diff_date_added := COUNT(GROUP,%Closest%.Diff_date_added);
    Count_Diff_validationdate := COUNT(GROUP,%Closest%.Diff_validationdate);
    Count_Diff_internal1 := COUNT(GROUP,%Closest%.Diff_internal1);
    Count_Diff_dacd := COUNT(GROUP,%Closest%.Diff_dacd);
    Count_Diff_normcompany_type := COUNT(GROUP,%Closest%.Diff_normcompany_type);
    Count_Diff_normcompany_name := COUNT(GROUP,%Closest%.Diff_normcompany_name);
    Count_Diff_normcompany_street := COUNT(GROUP,%Closest%.Diff_normcompany_street);
    Count_Diff_normcompany_city := COUNT(GROUP,%Closest%.Diff_normcompany_city);
    Count_Diff_normcompany_state := COUNT(GROUP,%Closest%.Diff_normcompany_state);
    Count_Diff_normcompany_zip := COUNT(GROUP,%Closest%.Diff_normcompany_zip);
    Count_Diff_normcompany_phone := COUNT(GROUP,%Closest%.Diff_normcompany_phone);
    Count_Diff_clean_company_name := COUNT(GROUP,%Closest%.Diff_clean_company_name);
    Count_Diff_title := COUNT(GROUP,%Closest%.Diff_title);
    Count_Diff_fname := COUNT(GROUP,%Closest%.Diff_fname);
    Count_Diff_mname := COUNT(GROUP,%Closest%.Diff_mname);
    Count_Diff_lname := COUNT(GROUP,%Closest%.Diff_lname);
    Count_Diff_name_suffix := COUNT(GROUP,%Closest%.Diff_name_suffix);
    Count_Diff_name_score := COUNT(GROUP,%Closest%.Diff_name_score);
    Count_Diff_prim_range := COUNT(GROUP,%Closest%.Diff_prim_range);
    Count_Diff_predir := COUNT(GROUP,%Closest%.Diff_predir);
    Count_Diff_prim_name := COUNT(GROUP,%Closest%.Diff_prim_name);
    Count_Diff_addr_suffix := COUNT(GROUP,%Closest%.Diff_addr_suffix);
    Count_Diff_postdir := COUNT(GROUP,%Closest%.Diff_postdir);
    Count_Diff_unit_desig := COUNT(GROUP,%Closest%.Diff_unit_desig);
    Count_Diff_sec_range := COUNT(GROUP,%Closest%.Diff_sec_range);
    Count_Diff_p_city_name := COUNT(GROUP,%Closest%.Diff_p_city_name);
    Count_Diff_v_city_name := COUNT(GROUP,%Closest%.Diff_v_city_name);
    Count_Diff_st := COUNT(GROUP,%Closest%.Diff_st);
    Count_Diff_zip := COUNT(GROUP,%Closest%.Diff_zip);
    Count_Diff_zip4 := COUNT(GROUP,%Closest%.Diff_zip4);
    Count_Diff_cart := COUNT(GROUP,%Closest%.Diff_cart);
    Count_Diff_cr_sort_sz := COUNT(GROUP,%Closest%.Diff_cr_sort_sz);
    Count_Diff_lot := COUNT(GROUP,%Closest%.Diff_lot);
    Count_Diff_lot_order := COUNT(GROUP,%Closest%.Diff_lot_order);
    Count_Diff_dbpc := COUNT(GROUP,%Closest%.Diff_dbpc);
    Count_Diff_chk_digit := COUNT(GROUP,%Closest%.Diff_chk_digit);
    Count_Diff_rec_type := COUNT(GROUP,%Closest%.Diff_rec_type);
    Count_Diff_fips_state := COUNT(GROUP,%Closest%.Diff_fips_state);
    Count_Diff_fips_county := COUNT(GROUP,%Closest%.Diff_fips_county);
    Count_Diff_geo_lat := COUNT(GROUP,%Closest%.Diff_geo_lat);
    Count_Diff_geo_long := COUNT(GROUP,%Closest%.Diff_geo_long);
    Count_Diff_msa := COUNT(GROUP,%Closest%.Diff_msa);
    Count_Diff_geo_blk := COUNT(GROUP,%Closest%.Diff_geo_blk);
    Count_Diff_geo_match := COUNT(GROUP,%Closest%.Diff_geo_match);
    Count_Diff_err_stat := COUNT(GROUP,%Closest%.Diff_err_stat);
    Count_Diff_clean_phone := COUNT(GROUP,%Closest%.Diff_clean_phone);
    Count_Diff_raw_aid := COUNT(GROUP,%Closest%.Diff_raw_aid);
    Count_Diff_ace_aid := COUNT(GROUP,%Closest%.Diff_ace_aid);
    Count_Diff_prep_address_line1 := COUNT(GROUP,%Closest%.Diff_prep_address_line1);
    Count_Diff_prep_address_line_last := COUNT(GROUP,%Closest%.Diff_prep_address_line_last);
    %Closest%.SourceField;
  END;
  out_counts := table(%Closest%,%AggRec%,SourceField,few);
ENDMACRO;
// Now determine the consistency of the identifiers
EXPORT UIDConsistency(infile) := FUNCTIONMACRO
  f := TABLE(infile,{rcid,seleid}) : GLOBAL; // Consistent type independent of input
  m := MODULE
    r := RECORD
      UNSIGNED rcid_null0 := COUNT(GROUP,(UNSIGNED)f.rcid=0);
      UNSIGNED rcid_belowparent0 := COUNT(GROUP,(UNSIGNED)f.rcid<(UNSIGNED)f.seleid);
      UNSIGNED rcid_atparent := COUNT(GROUP,(UNSIGNED)f.seleid=(UNSIGNED)f.rcid);
      UNSIGNED seleid_null0 := COUNT(GROUP,(UNSIGNED)f.seleid=0);
    END;
  EXPORT Basic0 := TABLE(f,r);
  EXPORT rcid_Clusters := SALT34.MOD_ClusterStats.Counts(f,rcid);
  EXPORT seleid_Clusters := SALT34.MOD_ClusterStats.Counts(f,seleid);
  EXPORT IdCounts := DATASET([{'rcid_Cnt', SUM(rcid_Clusters,NumberOfClusters)},{'seleid_Cnt', SUM(seleid_Clusters,NumberOfClusters)}],{STRING10 Count_Type, UNSIGNED Cnt}); // The counts of each ID
 // For deeper debugging; provide the unbased parents
    bases := f((UNSIGNED)seleid=(UNSIGNED)rcid); // Get the bases
  EXPORT seleid_Unbased := JOIN(f(seleid<>0),bases,LEFT.seleid=RIGHT.seleid,TRANSFORM(LEFT),LEFT ONLY,HASH);
 // Children with two parents
    f_thin := TABLE(f(rcid<>0,seleid<>0),{rcid,seleid},rcid,seleid,MERGE);
  EXPORT rcid_Twoparents := DEDUP(JOIN(f_thin,f_thin,LEFT.rcid=RIGHT.rcid AND LEFT.seleid>RIGHT.seleid,TRANSFORM({SALT34.UIDType seleid1,SALT34.UIDType rcid,SALT34.UIDType seleid2},SELF.seleid1:=LEFT.seleid,SELF.seleid2:=RIGHT.seleid,SELF.rcid:=LEFT.rcid),HASH),WHOLE RECORD,ALL);
 // Now compute the more involved consistency checks
    r := RECORD
      {Basic0} AND NOT [rcid_atparent];
      INTEGER seleid_unbased0 := IdCounts[2].Cnt-Basic0.rcid_atparent-IF(Basic0.seleid_null0>0,1,0);
      INTEGER rcid_Twoparents0 := COUNT(rcid_Twoparents);
    END;
  Advanced00 := TABLE(Basic0,r);
  Advanced0Layout := {STRING label, INTEGER null0, INTEGER belowparent0, INTEGER unbased0, INTEGER Twoparents0};
  EXPORT Advanced0 := SORT(SALT34.MAC_Pivot(Advanced00,Advanced0Layout), MAP(label='rcid'=>0,1));
  END;
  RETURN m;
ENDMACRO;
END;
