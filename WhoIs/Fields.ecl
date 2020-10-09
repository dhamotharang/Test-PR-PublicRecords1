IMPORT SALT311;
EXPORT Fields := MODULE
 
EXPORT NumFields := 175;
 
EXPORT SALT311.StrType FieldName(UNSIGNED2 i) := CHOOSE(i,'did','did_score','process_date','date_first_seen','date_last_seen','date_vendor_first_reported','date_vendor_last_reported','clean_cname','current_rec','dotid','dotscore','dotweight','empid','empscore','empweight','powid','powscore','powweight','proxid','proxscore','proxweight','seleid','selescore','seleweight','orgid','orgscore','orgweight','ultid','ultscore','ultweight','clean_title','clean_fname','clean_mname','clean_lname','clean_name_suffix','clean_name_score','rawaid','append_prep_address_situs','append_prep_address_last_situs','prim_range','predir','prim_name','addr_suffix','postdir','unit_desig','sec_range','p_city_name','v_city_name','st','zip','zip4','cart','cr_sort_sz','lot','lot_order','dbpc','chk_digit','rec_type','county','geo_lat','geo_long','msa','geo_blk','geo_match','err_stat','emailtype','rawtext','email','name','organization','street1','street2','street3','street4','city','state','postalcode','country','fax','faxext','phone','phoneext','domainname','registrarname','contactemail','whoisserver','nameservers','createddate','updateddate','expiresdate','standardregcreateddate','standardregupdateddate','standardregexpiresdate','status','audit_auditupdateddate','registrant_rawtext','registrant_email','registrant_name','registrant_organization','registrant_street1','registrant_street2','registrant_street3','registrant_street4','registrant_city','registrant_state','registrant_postalcode','registrant_country','registrant_fax','registrant_faxext','registrant_phone','registrant_phoneext','administrativecontact_rawtext','administrativecontact_email','administrativecontact_name','administrativecontact_organization','administrativecontact_street1','administrativecontact_street2','administrativecontact_street3','administrativecontact_street4','administrativecontact_city','administrativecontact_state','administrativecontact_postalcode','administrativecontact_country','administrativecontact_fax','administrativecontact_faxext','administrativecontact_phone','administrativecontact_phoneext','billingcontact_rawtext','billingcontact_email','billingcontact_name','billingcontact_organization','billingcontact_street1','billingcontact_street2','billingcontact_street3','billingcontact_street4','billingcontact_city','billingcontact_state','billingcontact_postalcode','billingcontact_country','billingcontact_fax','billingcontact_faxext','billingcontact_phone','billingcontact_phoneext','technicalcontact_rawtext','technicalcontact_email','technicalcontact_name','technicalcontact_organization','technicalcontact_street1','technicalcontact_street2','technicalcontact_street3','technicalcontact_street4','technicalcontact_city','technicalcontact_state','technicalcontact_postalcode','technicalcontact_country','technicalcontact_fax','technicalcontact_faxext','technicalcontact_phone','technicalcontact_phoneext','zonecontact_rawtext','zonecontact_email','zonecontact_name','zonecontact_organization','zonecontact_street1','zonecontact_street2','zonecontact_street3','zonecontact_street4','zonecontact_city','zonecontact_state','zonecontact_postalcode','zonecontact_country','zonecontact_fax','zonecontact_faxext','zonecontact_phone','zonecontact_phoneext');
EXPORT SALT311.StrType FlatName(UNSIGNED2 i) := CHOOSE(i,'did','did_score','process_date','date_first_seen','date_last_seen','date_vendor_first_reported','date_vendor_last_reported','clean_cname','current_rec','dotid','dotscore','dotweight','empid','empscore','empweight','powid','powscore','powweight','proxid','proxscore','proxweight','seleid','selescore','seleweight','orgid','orgscore','orgweight','ultid','ultscore','ultweight','clean_title','clean_fname','clean_mname','clean_lname','clean_name_suffix','clean_name_score','rawaid','append_prep_address_situs','append_prep_address_last_situs','prim_range','predir','prim_name','addr_suffix','postdir','unit_desig','sec_range','p_city_name','v_city_name','st','zip','zip4','cart','cr_sort_sz','lot','lot_order','dbpc','chk_digit','rec_type','county','geo_lat','geo_long','msa','geo_blk','geo_match','err_stat','emailtype','rawtext','email','name','organization','street1','street2','street3','street4','city','state','postalcode','country','fax','faxext','phone','phoneext','domainname','registrarname','contactemail','whoisserver','nameservers','createddate','updateddate','expiresdate','standardregcreateddate','standardregupdateddate','standardregexpiresdate','status','audit_auditupdateddate','registrant_rawtext','registrant_email','registrant_name','registrant_organization','registrant_street1','registrant_street2','registrant_street3','registrant_street4','registrant_city','registrant_state','registrant_postalcode','registrant_country','registrant_fax','registrant_faxext','registrant_phone','registrant_phoneext','administrativecontact_rawtext','administrativecontact_email','administrativecontact_name','administrativecontact_organization','administrativecontact_street1','administrativecontact_street2','administrativecontact_street3','administrativecontact_street4','administrativecontact_city','administrativecontact_state','administrativecontact_postalcode','administrativecontact_country','administrativecontact_fax','administrativecontact_faxext','administrativecontact_phone','administrativecontact_phoneext','billingcontact_rawtext','billingcontact_email','billingcontact_name','billingcontact_organization','billingcontact_street1','billingcontact_street2','billingcontact_street3','billingcontact_street4','billingcontact_city','billingcontact_state','billingcontact_postalcode','billingcontact_country','billingcontact_fax','billingcontact_faxext','billingcontact_phone','billingcontact_phoneext','technicalcontact_rawtext','technicalcontact_email','technicalcontact_name','technicalcontact_organization','technicalcontact_street1','technicalcontact_street2','technicalcontact_street3','technicalcontact_street4','technicalcontact_city','technicalcontact_state','technicalcontact_postalcode','technicalcontact_country','technicalcontact_fax','technicalcontact_faxext','technicalcontact_phone','technicalcontact_phoneext','zonecontact_rawtext','zonecontact_email','zonecontact_name','zonecontact_organization','zonecontact_street1','zonecontact_street2','zonecontact_street3','zonecontact_street4','zonecontact_city','zonecontact_state','zonecontact_postalcode','zonecontact_country','zonecontact_fax','zonecontact_faxext','zonecontact_phone','zonecontact_phoneext');
EXPORT FieldNum(SALT311.StrType fn) := CASE(fn,'did' => 0,'did_score' => 1,'process_date' => 2,'date_first_seen' => 3,'date_last_seen' => 4,'date_vendor_first_reported' => 5,'date_vendor_last_reported' => 6,'clean_cname' => 7,'current_rec' => 8,'dotid' => 9,'dotscore' => 10,'dotweight' => 11,'empid' => 12,'empscore' => 13,'empweight' => 14,'powid' => 15,'powscore' => 16,'powweight' => 17,'proxid' => 18,'proxscore' => 19,'proxweight' => 20,'seleid' => 21,'selescore' => 22,'seleweight' => 23,'orgid' => 24,'orgscore' => 25,'orgweight' => 26,'ultid' => 27,'ultscore' => 28,'ultweight' => 29,'clean_title' => 30,'clean_fname' => 31,'clean_mname' => 32,'clean_lname' => 33,'clean_name_suffix' => 34,'clean_name_score' => 35,'rawaid' => 36,'append_prep_address_situs' => 37,'append_prep_address_last_situs' => 38,'prim_range' => 39,'predir' => 40,'prim_name' => 41,'addr_suffix' => 42,'postdir' => 43,'unit_desig' => 44,'sec_range' => 45,'p_city_name' => 46,'v_city_name' => 47,'st' => 48,'zip' => 49,'zip4' => 50,'cart' => 51,'cr_sort_sz' => 52,'lot' => 53,'lot_order' => 54,'dbpc' => 55,'chk_digit' => 56,'rec_type' => 57,'county' => 58,'geo_lat' => 59,'geo_long' => 60,'msa' => 61,'geo_blk' => 62,'geo_match' => 63,'err_stat' => 64,'emailtype' => 65,'rawtext' => 66,'email' => 67,'name' => 68,'organization' => 69,'street1' => 70,'street2' => 71,'street3' => 72,'street4' => 73,'city' => 74,'state' => 75,'postalcode' => 76,'country' => 77,'fax' => 78,'faxext' => 79,'phone' => 80,'phoneext' => 81,'domainname' => 82,'registrarname' => 83,'contactemail' => 84,'whoisserver' => 85,'nameservers' => 86,'createddate' => 87,'updateddate' => 88,'expiresdate' => 89,'standardregcreateddate' => 90,'standardregupdateddate' => 91,'standardregexpiresdate' => 92,'status' => 93,'audit_auditupdateddate' => 94,'registrant_rawtext' => 95,'registrant_email' => 96,'registrant_name' => 97,'registrant_organization' => 98,'registrant_street1' => 99,'registrant_street2' => 100,'registrant_street3' => 101,'registrant_street4' => 102,'registrant_city' => 103,'registrant_state' => 104,'registrant_postalcode' => 105,'registrant_country' => 106,'registrant_fax' => 107,'registrant_faxext' => 108,'registrant_phone' => 109,'registrant_phoneext' => 110,'administrativecontact_rawtext' => 111,'administrativecontact_email' => 112,'administrativecontact_name' => 113,'administrativecontact_organization' => 114,'administrativecontact_street1' => 115,'administrativecontact_street2' => 116,'administrativecontact_street3' => 117,'administrativecontact_street4' => 118,'administrativecontact_city' => 119,'administrativecontact_state' => 120,'administrativecontact_postalcode' => 121,'administrativecontact_country' => 122,'administrativecontact_fax' => 123,'administrativecontact_faxext' => 124,'administrativecontact_phone' => 125,'administrativecontact_phoneext' => 126,'billingcontact_rawtext' => 127,'billingcontact_email' => 128,'billingcontact_name' => 129,'billingcontact_organization' => 130,'billingcontact_street1' => 131,'billingcontact_street2' => 132,'billingcontact_street3' => 133,'billingcontact_street4' => 134,'billingcontact_city' => 135,'billingcontact_state' => 136,'billingcontact_postalcode' => 137,'billingcontact_country' => 138,'billingcontact_fax' => 139,'billingcontact_faxext' => 140,'billingcontact_phone' => 141,'billingcontact_phoneext' => 142,'technicalcontact_rawtext' => 143,'technicalcontact_email' => 144,'technicalcontact_name' => 145,'technicalcontact_organization' => 146,'technicalcontact_street1' => 147,'technicalcontact_street2' => 148,'technicalcontact_street3' => 149,'technicalcontact_street4' => 150,'technicalcontact_city' => 151,'technicalcontact_state' => 152,'technicalcontact_postalcode' => 153,'technicalcontact_country' => 154,'technicalcontact_fax' => 155,'technicalcontact_faxext' => 156,'technicalcontact_phone' => 157,'technicalcontact_phoneext' => 158,'zonecontact_rawtext' => 159,'zonecontact_email' => 160,'zonecontact_name' => 161,'zonecontact_organization' => 162,'zonecontact_street1' => 163,'zonecontact_street2' => 164,'zonecontact_street3' => 165,'zonecontact_street4' => 166,'zonecontact_city' => 167,'zonecontact_state' => 168,'zonecontact_postalcode' => 169,'zonecontact_country' => 170,'zonecontact_fax' => 171,'zonecontact_faxext' => 172,'zonecontact_phone' => 173,'zonecontact_phoneext' => 174,0);
EXPORT SET OF SALT311.StrType FieldRules(UNSIGNED2 i) := CHOOSE(i,[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[]);
EXPORT BOOLEAN InBaseLayout(UNSIGNED2 i) := CHOOSE(i,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,FALSE);
 
//Individual field level validation
 
EXPORT Make_did(SALT311.StrType s0) := s0;
EXPORT InValid_did(SALT311.StrType s) := 0;
EXPORT InValidMessage_did(UNSIGNED1 wh) := '';
 
EXPORT Make_did_score(SALT311.StrType s0) := s0;
EXPORT InValid_did_score(SALT311.StrType s) := 0;
EXPORT InValidMessage_did_score(UNSIGNED1 wh) := '';
 
EXPORT Make_process_date(SALT311.StrType s0) := s0;
EXPORT InValid_process_date(SALT311.StrType s) := 0;
EXPORT InValidMessage_process_date(UNSIGNED1 wh) := '';
 
EXPORT Make_date_first_seen(SALT311.StrType s0) := s0;
EXPORT InValid_date_first_seen(SALT311.StrType s) := 0;
EXPORT InValidMessage_date_first_seen(UNSIGNED1 wh) := '';
 
EXPORT Make_date_last_seen(SALT311.StrType s0) := s0;
EXPORT InValid_date_last_seen(SALT311.StrType s) := 0;
EXPORT InValidMessage_date_last_seen(UNSIGNED1 wh) := '';
 
EXPORT Make_date_vendor_first_reported(SALT311.StrType s0) := s0;
EXPORT InValid_date_vendor_first_reported(SALT311.StrType s) := 0;
EXPORT InValidMessage_date_vendor_first_reported(UNSIGNED1 wh) := '';
 
EXPORT Make_date_vendor_last_reported(SALT311.StrType s0) := s0;
EXPORT InValid_date_vendor_last_reported(SALT311.StrType s) := 0;
EXPORT InValidMessage_date_vendor_last_reported(UNSIGNED1 wh) := '';
 
EXPORT Make_clean_cname(SALT311.StrType s0) := s0;
EXPORT InValid_clean_cname(SALT311.StrType s) := 0;
EXPORT InValidMessage_clean_cname(UNSIGNED1 wh) := '';
 
EXPORT Make_current_rec(SALT311.StrType s0) := s0;
EXPORT InValid_current_rec(SALT311.StrType s) := 0;
EXPORT InValidMessage_current_rec(UNSIGNED1 wh) := '';
 
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
 
EXPORT Make_seleid(SALT311.StrType s0) := s0;
EXPORT InValid_seleid(SALT311.StrType s) := 0;
EXPORT InValidMessage_seleid(UNSIGNED1 wh) := '';
 
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
 
EXPORT Make_clean_title(SALT311.StrType s0) := s0;
EXPORT InValid_clean_title(SALT311.StrType s) := 0;
EXPORT InValidMessage_clean_title(UNSIGNED1 wh) := '';
 
EXPORT Make_clean_fname(SALT311.StrType s0) := s0;
EXPORT InValid_clean_fname(SALT311.StrType s) := 0;
EXPORT InValidMessage_clean_fname(UNSIGNED1 wh) := '';
 
EXPORT Make_clean_mname(SALT311.StrType s0) := s0;
EXPORT InValid_clean_mname(SALT311.StrType s) := 0;
EXPORT InValidMessage_clean_mname(UNSIGNED1 wh) := '';
 
EXPORT Make_clean_lname(SALT311.StrType s0) := s0;
EXPORT InValid_clean_lname(SALT311.StrType s) := 0;
EXPORT InValidMessage_clean_lname(UNSIGNED1 wh) := '';
 
EXPORT Make_clean_name_suffix(SALT311.StrType s0) := s0;
EXPORT InValid_clean_name_suffix(SALT311.StrType s) := 0;
EXPORT InValidMessage_clean_name_suffix(UNSIGNED1 wh) := '';
 
EXPORT Make_clean_name_score(SALT311.StrType s0) := s0;
EXPORT InValid_clean_name_score(SALT311.StrType s) := 0;
EXPORT InValidMessage_clean_name_score(UNSIGNED1 wh) := '';
 
EXPORT Make_rawaid(SALT311.StrType s0) := s0;
EXPORT InValid_rawaid(SALT311.StrType s) := 0;
EXPORT InValidMessage_rawaid(UNSIGNED1 wh) := '';
 
EXPORT Make_append_prep_address_situs(SALT311.StrType s0) := s0;
EXPORT InValid_append_prep_address_situs(SALT311.StrType s) := 0;
EXPORT InValidMessage_append_prep_address_situs(UNSIGNED1 wh) := '';
 
EXPORT Make_append_prep_address_last_situs(SALT311.StrType s0) := s0;
EXPORT InValid_append_prep_address_last_situs(SALT311.StrType s) := 0;
EXPORT InValidMessage_append_prep_address_last_situs(UNSIGNED1 wh) := '';
 
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
 
EXPORT Make_zip(SALT311.StrType s0) := s0;
EXPORT InValid_zip(SALT311.StrType s) := 0;
EXPORT InValidMessage_zip(UNSIGNED1 wh) := '';
 
EXPORT Make_zip4(SALT311.StrType s0) := s0;
EXPORT InValid_zip4(SALT311.StrType s) := 0;
EXPORT InValidMessage_zip4(UNSIGNED1 wh) := '';
 
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
 
EXPORT Make_county(SALT311.StrType s0) := s0;
EXPORT InValid_county(SALT311.StrType s) := 0;
EXPORT InValidMessage_county(UNSIGNED1 wh) := '';
 
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
 
EXPORT Make_emailtype(SALT311.StrType s0) := s0;
EXPORT InValid_emailtype(SALT311.StrType s) := 0;
EXPORT InValidMessage_emailtype(UNSIGNED1 wh) := '';
 
EXPORT Make_rawtext(SALT311.StrType s0) := s0;
EXPORT InValid_rawtext(SALT311.StrType s) := 0;
EXPORT InValidMessage_rawtext(UNSIGNED1 wh) := '';
 
EXPORT Make_email(SALT311.StrType s0) := s0;
EXPORT InValid_email(SALT311.StrType s) := 0;
EXPORT InValidMessage_email(UNSIGNED1 wh) := '';
 
EXPORT Make_name(SALT311.StrType s0) := s0;
EXPORT InValid_name(SALT311.StrType s) := 0;
EXPORT InValidMessage_name(UNSIGNED1 wh) := '';
 
EXPORT Make_organization(SALT311.StrType s0) := s0;
EXPORT InValid_organization(SALT311.StrType s) := 0;
EXPORT InValidMessage_organization(UNSIGNED1 wh) := '';
 
EXPORT Make_street1(SALT311.StrType s0) := s0;
EXPORT InValid_street1(SALT311.StrType s) := 0;
EXPORT InValidMessage_street1(UNSIGNED1 wh) := '';
 
EXPORT Make_street2(SALT311.StrType s0) := s0;
EXPORT InValid_street2(SALT311.StrType s) := 0;
EXPORT InValidMessage_street2(UNSIGNED1 wh) := '';
 
EXPORT Make_street3(SALT311.StrType s0) := s0;
EXPORT InValid_street3(SALT311.StrType s) := 0;
EXPORT InValidMessage_street3(UNSIGNED1 wh) := '';
 
EXPORT Make_street4(SALT311.StrType s0) := s0;
EXPORT InValid_street4(SALT311.StrType s) := 0;
EXPORT InValidMessage_street4(UNSIGNED1 wh) := '';
 
EXPORT Make_city(SALT311.StrType s0) := s0;
EXPORT InValid_city(SALT311.StrType s) := 0;
EXPORT InValidMessage_city(UNSIGNED1 wh) := '';
 
EXPORT Make_state(SALT311.StrType s0) := s0;
EXPORT InValid_state(SALT311.StrType s) := 0;
EXPORT InValidMessage_state(UNSIGNED1 wh) := '';
 
EXPORT Make_postalcode(SALT311.StrType s0) := s0;
EXPORT InValid_postalcode(SALT311.StrType s) := 0;
EXPORT InValidMessage_postalcode(UNSIGNED1 wh) := '';
 
EXPORT Make_country(SALT311.StrType s0) := s0;
EXPORT InValid_country(SALT311.StrType s) := 0;
EXPORT InValidMessage_country(UNSIGNED1 wh) := '';
 
EXPORT Make_fax(SALT311.StrType s0) := s0;
EXPORT InValid_fax(SALT311.StrType s) := 0;
EXPORT InValidMessage_fax(UNSIGNED1 wh) := '';
 
EXPORT Make_faxext(SALT311.StrType s0) := s0;
EXPORT InValid_faxext(SALT311.StrType s) := 0;
EXPORT InValidMessage_faxext(UNSIGNED1 wh) := '';
 
EXPORT Make_phone(SALT311.StrType s0) := s0;
EXPORT InValid_phone(SALT311.StrType s) := 0;
EXPORT InValidMessage_phone(UNSIGNED1 wh) := '';
 
EXPORT Make_phoneext(SALT311.StrType s0) := s0;
EXPORT InValid_phoneext(SALT311.StrType s) := 0;
EXPORT InValidMessage_phoneext(UNSIGNED1 wh) := '';
 
EXPORT Make_domainname(SALT311.StrType s0) := s0;
EXPORT InValid_domainname(SALT311.StrType s) := 0;
EXPORT InValidMessage_domainname(UNSIGNED1 wh) := '';
 
EXPORT Make_registrarname(SALT311.StrType s0) := s0;
EXPORT InValid_registrarname(SALT311.StrType s) := 0;
EXPORT InValidMessage_registrarname(UNSIGNED1 wh) := '';
 
EXPORT Make_contactemail(SALT311.StrType s0) := s0;
EXPORT InValid_contactemail(SALT311.StrType s) := 0;
EXPORT InValidMessage_contactemail(UNSIGNED1 wh) := '';
 
EXPORT Make_whoisserver(SALT311.StrType s0) := s0;
EXPORT InValid_whoisserver(SALT311.StrType s) := 0;
EXPORT InValidMessage_whoisserver(UNSIGNED1 wh) := '';
 
EXPORT Make_nameservers(SALT311.StrType s0) := s0;
EXPORT InValid_nameservers(SALT311.StrType s) := 0;
EXPORT InValidMessage_nameservers(UNSIGNED1 wh) := '';
 
EXPORT Make_createddate(SALT311.StrType s0) := s0;
EXPORT InValid_createddate(SALT311.StrType s) := 0;
EXPORT InValidMessage_createddate(UNSIGNED1 wh) := '';
 
EXPORT Make_updateddate(SALT311.StrType s0) := s0;
EXPORT InValid_updateddate(SALT311.StrType s) := 0;
EXPORT InValidMessage_updateddate(UNSIGNED1 wh) := '';
 
EXPORT Make_expiresdate(SALT311.StrType s0) := s0;
EXPORT InValid_expiresdate(SALT311.StrType s) := 0;
EXPORT InValidMessage_expiresdate(UNSIGNED1 wh) := '';
 
EXPORT Make_standardregcreateddate(SALT311.StrType s0) := s0;
EXPORT InValid_standardregcreateddate(SALT311.StrType s) := 0;
EXPORT InValidMessage_standardregcreateddate(UNSIGNED1 wh) := '';
 
EXPORT Make_standardregupdateddate(SALT311.StrType s0) := s0;
EXPORT InValid_standardregupdateddate(SALT311.StrType s) := 0;
EXPORT InValidMessage_standardregupdateddate(UNSIGNED1 wh) := '';
 
EXPORT Make_standardregexpiresdate(SALT311.StrType s0) := s0;
EXPORT InValid_standardregexpiresdate(SALT311.StrType s) := 0;
EXPORT InValidMessage_standardregexpiresdate(UNSIGNED1 wh) := '';
 
EXPORT Make_status(SALT311.StrType s0) := s0;
EXPORT InValid_status(SALT311.StrType s) := 0;
EXPORT InValidMessage_status(UNSIGNED1 wh) := '';
 
EXPORT Make_audit_auditupdateddate(SALT311.StrType s0) := s0;
EXPORT InValid_audit_auditupdateddate(SALT311.StrType s) := 0;
EXPORT InValidMessage_audit_auditupdateddate(UNSIGNED1 wh) := '';
 
EXPORT Make_registrant_rawtext(SALT311.StrType s0) := s0;
EXPORT InValid_registrant_rawtext(SALT311.StrType s) := 0;
EXPORT InValidMessage_registrant_rawtext(UNSIGNED1 wh) := '';
 
EXPORT Make_registrant_email(SALT311.StrType s0) := s0;
EXPORT InValid_registrant_email(SALT311.StrType s) := 0;
EXPORT InValidMessage_registrant_email(UNSIGNED1 wh) := '';
 
EXPORT Make_registrant_name(SALT311.StrType s0) := s0;
EXPORT InValid_registrant_name(SALT311.StrType s) := 0;
EXPORT InValidMessage_registrant_name(UNSIGNED1 wh) := '';
 
EXPORT Make_registrant_organization(SALT311.StrType s0) := s0;
EXPORT InValid_registrant_organization(SALT311.StrType s) := 0;
EXPORT InValidMessage_registrant_organization(UNSIGNED1 wh) := '';
 
EXPORT Make_registrant_street1(SALT311.StrType s0) := s0;
EXPORT InValid_registrant_street1(SALT311.StrType s) := 0;
EXPORT InValidMessage_registrant_street1(UNSIGNED1 wh) := '';
 
EXPORT Make_registrant_street2(SALT311.StrType s0) := s0;
EXPORT InValid_registrant_street2(SALT311.StrType s) := 0;
EXPORT InValidMessage_registrant_street2(UNSIGNED1 wh) := '';
 
EXPORT Make_registrant_street3(SALT311.StrType s0) := s0;
EXPORT InValid_registrant_street3(SALT311.StrType s) := 0;
EXPORT InValidMessage_registrant_street3(UNSIGNED1 wh) := '';
 
EXPORT Make_registrant_street4(SALT311.StrType s0) := s0;
EXPORT InValid_registrant_street4(SALT311.StrType s) := 0;
EXPORT InValidMessage_registrant_street4(UNSIGNED1 wh) := '';
 
EXPORT Make_registrant_city(SALT311.StrType s0) := s0;
EXPORT InValid_registrant_city(SALT311.StrType s) := 0;
EXPORT InValidMessage_registrant_city(UNSIGNED1 wh) := '';
 
EXPORT Make_registrant_state(SALT311.StrType s0) := s0;
EXPORT InValid_registrant_state(SALT311.StrType s) := 0;
EXPORT InValidMessage_registrant_state(UNSIGNED1 wh) := '';
 
EXPORT Make_registrant_postalcode(SALT311.StrType s0) := s0;
EXPORT InValid_registrant_postalcode(SALT311.StrType s) := 0;
EXPORT InValidMessage_registrant_postalcode(UNSIGNED1 wh) := '';
 
EXPORT Make_registrant_country(SALT311.StrType s0) := s0;
EXPORT InValid_registrant_country(SALT311.StrType s) := 0;
EXPORT InValidMessage_registrant_country(UNSIGNED1 wh) := '';
 
EXPORT Make_registrant_fax(SALT311.StrType s0) := s0;
EXPORT InValid_registrant_fax(SALT311.StrType s) := 0;
EXPORT InValidMessage_registrant_fax(UNSIGNED1 wh) := '';
 
EXPORT Make_registrant_faxext(SALT311.StrType s0) := s0;
EXPORT InValid_registrant_faxext(SALT311.StrType s) := 0;
EXPORT InValidMessage_registrant_faxext(UNSIGNED1 wh) := '';
 
EXPORT Make_registrant_phone(SALT311.StrType s0) := s0;
EXPORT InValid_registrant_phone(SALT311.StrType s) := 0;
EXPORT InValidMessage_registrant_phone(UNSIGNED1 wh) := '';
 
EXPORT Make_registrant_phoneext(SALT311.StrType s0) := s0;
EXPORT InValid_registrant_phoneext(SALT311.StrType s) := 0;
EXPORT InValidMessage_registrant_phoneext(UNSIGNED1 wh) := '';
 
EXPORT Make_administrativecontact_rawtext(SALT311.StrType s0) := s0;
EXPORT InValid_administrativecontact_rawtext(SALT311.StrType s) := 0;
EXPORT InValidMessage_administrativecontact_rawtext(UNSIGNED1 wh) := '';
 
EXPORT Make_administrativecontact_email(SALT311.StrType s0) := s0;
EXPORT InValid_administrativecontact_email(SALT311.StrType s) := 0;
EXPORT InValidMessage_administrativecontact_email(UNSIGNED1 wh) := '';
 
EXPORT Make_administrativecontact_name(SALT311.StrType s0) := s0;
EXPORT InValid_administrativecontact_name(SALT311.StrType s) := 0;
EXPORT InValidMessage_administrativecontact_name(UNSIGNED1 wh) := '';
 
EXPORT Make_administrativecontact_organization(SALT311.StrType s0) := s0;
EXPORT InValid_administrativecontact_organization(SALT311.StrType s) := 0;
EXPORT InValidMessage_administrativecontact_organization(UNSIGNED1 wh) := '';
 
EXPORT Make_administrativecontact_street1(SALT311.StrType s0) := s0;
EXPORT InValid_administrativecontact_street1(SALT311.StrType s) := 0;
EXPORT InValidMessage_administrativecontact_street1(UNSIGNED1 wh) := '';
 
EXPORT Make_administrativecontact_street2(SALT311.StrType s0) := s0;
EXPORT InValid_administrativecontact_street2(SALT311.StrType s) := 0;
EXPORT InValidMessage_administrativecontact_street2(UNSIGNED1 wh) := '';
 
EXPORT Make_administrativecontact_street3(SALT311.StrType s0) := s0;
EXPORT InValid_administrativecontact_street3(SALT311.StrType s) := 0;
EXPORT InValidMessage_administrativecontact_street3(UNSIGNED1 wh) := '';
 
EXPORT Make_administrativecontact_street4(SALT311.StrType s0) := s0;
EXPORT InValid_administrativecontact_street4(SALT311.StrType s) := 0;
EXPORT InValidMessage_administrativecontact_street4(UNSIGNED1 wh) := '';
 
EXPORT Make_administrativecontact_city(SALT311.StrType s0) := s0;
EXPORT InValid_administrativecontact_city(SALT311.StrType s) := 0;
EXPORT InValidMessage_administrativecontact_city(UNSIGNED1 wh) := '';
 
EXPORT Make_administrativecontact_state(SALT311.StrType s0) := s0;
EXPORT InValid_administrativecontact_state(SALT311.StrType s) := 0;
EXPORT InValidMessage_administrativecontact_state(UNSIGNED1 wh) := '';
 
EXPORT Make_administrativecontact_postalcode(SALT311.StrType s0) := s0;
EXPORT InValid_administrativecontact_postalcode(SALT311.StrType s) := 0;
EXPORT InValidMessage_administrativecontact_postalcode(UNSIGNED1 wh) := '';
 
EXPORT Make_administrativecontact_country(SALT311.StrType s0) := s0;
EXPORT InValid_administrativecontact_country(SALT311.StrType s) := 0;
EXPORT InValidMessage_administrativecontact_country(UNSIGNED1 wh) := '';
 
EXPORT Make_administrativecontact_fax(SALT311.StrType s0) := s0;
EXPORT InValid_administrativecontact_fax(SALT311.StrType s) := 0;
EXPORT InValidMessage_administrativecontact_fax(UNSIGNED1 wh) := '';
 
EXPORT Make_administrativecontact_faxext(SALT311.StrType s0) := s0;
EXPORT InValid_administrativecontact_faxext(SALT311.StrType s) := 0;
EXPORT InValidMessage_administrativecontact_faxext(UNSIGNED1 wh) := '';
 
EXPORT Make_administrativecontact_phone(SALT311.StrType s0) := s0;
EXPORT InValid_administrativecontact_phone(SALT311.StrType s) := 0;
EXPORT InValidMessage_administrativecontact_phone(UNSIGNED1 wh) := '';
 
EXPORT Make_administrativecontact_phoneext(SALT311.StrType s0) := s0;
EXPORT InValid_administrativecontact_phoneext(SALT311.StrType s) := 0;
EXPORT InValidMessage_administrativecontact_phoneext(UNSIGNED1 wh) := '';
 
EXPORT Make_billingcontact_rawtext(SALT311.StrType s0) := s0;
EXPORT InValid_billingcontact_rawtext(SALT311.StrType s) := 0;
EXPORT InValidMessage_billingcontact_rawtext(UNSIGNED1 wh) := '';
 
EXPORT Make_billingcontact_email(SALT311.StrType s0) := s0;
EXPORT InValid_billingcontact_email(SALT311.StrType s) := 0;
EXPORT InValidMessage_billingcontact_email(UNSIGNED1 wh) := '';
 
EXPORT Make_billingcontact_name(SALT311.StrType s0) := s0;
EXPORT InValid_billingcontact_name(SALT311.StrType s) := 0;
EXPORT InValidMessage_billingcontact_name(UNSIGNED1 wh) := '';
 
EXPORT Make_billingcontact_organization(SALT311.StrType s0) := s0;
EXPORT InValid_billingcontact_organization(SALT311.StrType s) := 0;
EXPORT InValidMessage_billingcontact_organization(UNSIGNED1 wh) := '';
 
EXPORT Make_billingcontact_street1(SALT311.StrType s0) := s0;
EXPORT InValid_billingcontact_street1(SALT311.StrType s) := 0;
EXPORT InValidMessage_billingcontact_street1(UNSIGNED1 wh) := '';
 
EXPORT Make_billingcontact_street2(SALT311.StrType s0) := s0;
EXPORT InValid_billingcontact_street2(SALT311.StrType s) := 0;
EXPORT InValidMessage_billingcontact_street2(UNSIGNED1 wh) := '';
 
EXPORT Make_billingcontact_street3(SALT311.StrType s0) := s0;
EXPORT InValid_billingcontact_street3(SALT311.StrType s) := 0;
EXPORT InValidMessage_billingcontact_street3(UNSIGNED1 wh) := '';
 
EXPORT Make_billingcontact_street4(SALT311.StrType s0) := s0;
EXPORT InValid_billingcontact_street4(SALT311.StrType s) := 0;
EXPORT InValidMessage_billingcontact_street4(UNSIGNED1 wh) := '';
 
EXPORT Make_billingcontact_city(SALT311.StrType s0) := s0;
EXPORT InValid_billingcontact_city(SALT311.StrType s) := 0;
EXPORT InValidMessage_billingcontact_city(UNSIGNED1 wh) := '';
 
EXPORT Make_billingcontact_state(SALT311.StrType s0) := s0;
EXPORT InValid_billingcontact_state(SALT311.StrType s) := 0;
EXPORT InValidMessage_billingcontact_state(UNSIGNED1 wh) := '';
 
EXPORT Make_billingcontact_postalcode(SALT311.StrType s0) := s0;
EXPORT InValid_billingcontact_postalcode(SALT311.StrType s) := 0;
EXPORT InValidMessage_billingcontact_postalcode(UNSIGNED1 wh) := '';
 
EXPORT Make_billingcontact_country(SALT311.StrType s0) := s0;
EXPORT InValid_billingcontact_country(SALT311.StrType s) := 0;
EXPORT InValidMessage_billingcontact_country(UNSIGNED1 wh) := '';
 
EXPORT Make_billingcontact_fax(SALT311.StrType s0) := s0;
EXPORT InValid_billingcontact_fax(SALT311.StrType s) := 0;
EXPORT InValidMessage_billingcontact_fax(UNSIGNED1 wh) := '';
 
EXPORT Make_billingcontact_faxext(SALT311.StrType s0) := s0;
EXPORT InValid_billingcontact_faxext(SALT311.StrType s) := 0;
EXPORT InValidMessage_billingcontact_faxext(UNSIGNED1 wh) := '';
 
EXPORT Make_billingcontact_phone(SALT311.StrType s0) := s0;
EXPORT InValid_billingcontact_phone(SALT311.StrType s) := 0;
EXPORT InValidMessage_billingcontact_phone(UNSIGNED1 wh) := '';
 
EXPORT Make_billingcontact_phoneext(SALT311.StrType s0) := s0;
EXPORT InValid_billingcontact_phoneext(SALT311.StrType s) := 0;
EXPORT InValidMessage_billingcontact_phoneext(UNSIGNED1 wh) := '';
 
EXPORT Make_technicalcontact_rawtext(SALT311.StrType s0) := s0;
EXPORT InValid_technicalcontact_rawtext(SALT311.StrType s) := 0;
EXPORT InValidMessage_technicalcontact_rawtext(UNSIGNED1 wh) := '';
 
EXPORT Make_technicalcontact_email(SALT311.StrType s0) := s0;
EXPORT InValid_technicalcontact_email(SALT311.StrType s) := 0;
EXPORT InValidMessage_technicalcontact_email(UNSIGNED1 wh) := '';
 
EXPORT Make_technicalcontact_name(SALT311.StrType s0) := s0;
EXPORT InValid_technicalcontact_name(SALT311.StrType s) := 0;
EXPORT InValidMessage_technicalcontact_name(UNSIGNED1 wh) := '';
 
EXPORT Make_technicalcontact_organization(SALT311.StrType s0) := s0;
EXPORT InValid_technicalcontact_organization(SALT311.StrType s) := 0;
EXPORT InValidMessage_technicalcontact_organization(UNSIGNED1 wh) := '';
 
EXPORT Make_technicalcontact_street1(SALT311.StrType s0) := s0;
EXPORT InValid_technicalcontact_street1(SALT311.StrType s) := 0;
EXPORT InValidMessage_technicalcontact_street1(UNSIGNED1 wh) := '';
 
EXPORT Make_technicalcontact_street2(SALT311.StrType s0) := s0;
EXPORT InValid_technicalcontact_street2(SALT311.StrType s) := 0;
EXPORT InValidMessage_technicalcontact_street2(UNSIGNED1 wh) := '';
 
EXPORT Make_technicalcontact_street3(SALT311.StrType s0) := s0;
EXPORT InValid_technicalcontact_street3(SALT311.StrType s) := 0;
EXPORT InValidMessage_technicalcontact_street3(UNSIGNED1 wh) := '';
 
EXPORT Make_technicalcontact_street4(SALT311.StrType s0) := s0;
EXPORT InValid_technicalcontact_street4(SALT311.StrType s) := 0;
EXPORT InValidMessage_technicalcontact_street4(UNSIGNED1 wh) := '';
 
EXPORT Make_technicalcontact_city(SALT311.StrType s0) := s0;
EXPORT InValid_technicalcontact_city(SALT311.StrType s) := 0;
EXPORT InValidMessage_technicalcontact_city(UNSIGNED1 wh) := '';
 
EXPORT Make_technicalcontact_state(SALT311.StrType s0) := s0;
EXPORT InValid_technicalcontact_state(SALT311.StrType s) := 0;
EXPORT InValidMessage_technicalcontact_state(UNSIGNED1 wh) := '';
 
EXPORT Make_technicalcontact_postalcode(SALT311.StrType s0) := s0;
EXPORT InValid_technicalcontact_postalcode(SALT311.StrType s) := 0;
EXPORT InValidMessage_technicalcontact_postalcode(UNSIGNED1 wh) := '';
 
EXPORT Make_technicalcontact_country(SALT311.StrType s0) := s0;
EXPORT InValid_technicalcontact_country(SALT311.StrType s) := 0;
EXPORT InValidMessage_technicalcontact_country(UNSIGNED1 wh) := '';
 
EXPORT Make_technicalcontact_fax(SALT311.StrType s0) := s0;
EXPORT InValid_technicalcontact_fax(SALT311.StrType s) := 0;
EXPORT InValidMessage_technicalcontact_fax(UNSIGNED1 wh) := '';
 
EXPORT Make_technicalcontact_faxext(SALT311.StrType s0) := s0;
EXPORT InValid_technicalcontact_faxext(SALT311.StrType s) := 0;
EXPORT InValidMessage_technicalcontact_faxext(UNSIGNED1 wh) := '';
 
EXPORT Make_technicalcontact_phone(SALT311.StrType s0) := s0;
EXPORT InValid_technicalcontact_phone(SALT311.StrType s) := 0;
EXPORT InValidMessage_technicalcontact_phone(UNSIGNED1 wh) := '';
 
EXPORT Make_technicalcontact_phoneext(SALT311.StrType s0) := s0;
EXPORT InValid_technicalcontact_phoneext(SALT311.StrType s) := 0;
EXPORT InValidMessage_technicalcontact_phoneext(UNSIGNED1 wh) := '';
 
EXPORT Make_zonecontact_rawtext(SALT311.StrType s0) := s0;
EXPORT InValid_zonecontact_rawtext(SALT311.StrType s) := 0;
EXPORT InValidMessage_zonecontact_rawtext(UNSIGNED1 wh) := '';
 
EXPORT Make_zonecontact_email(SALT311.StrType s0) := s0;
EXPORT InValid_zonecontact_email(SALT311.StrType s) := 0;
EXPORT InValidMessage_zonecontact_email(UNSIGNED1 wh) := '';
 
EXPORT Make_zonecontact_name(SALT311.StrType s0) := s0;
EXPORT InValid_zonecontact_name(SALT311.StrType s) := 0;
EXPORT InValidMessage_zonecontact_name(UNSIGNED1 wh) := '';
 
EXPORT Make_zonecontact_organization(SALT311.StrType s0) := s0;
EXPORT InValid_zonecontact_organization(SALT311.StrType s) := 0;
EXPORT InValidMessage_zonecontact_organization(UNSIGNED1 wh) := '';
 
EXPORT Make_zonecontact_street1(SALT311.StrType s0) := s0;
EXPORT InValid_zonecontact_street1(SALT311.StrType s) := 0;
EXPORT InValidMessage_zonecontact_street1(UNSIGNED1 wh) := '';
 
EXPORT Make_zonecontact_street2(SALT311.StrType s0) := s0;
EXPORT InValid_zonecontact_street2(SALT311.StrType s) := 0;
EXPORT InValidMessage_zonecontact_street2(UNSIGNED1 wh) := '';
 
EXPORT Make_zonecontact_street3(SALT311.StrType s0) := s0;
EXPORT InValid_zonecontact_street3(SALT311.StrType s) := 0;
EXPORT InValidMessage_zonecontact_street3(UNSIGNED1 wh) := '';
 
EXPORT Make_zonecontact_street4(SALT311.StrType s0) := s0;
EXPORT InValid_zonecontact_street4(SALT311.StrType s) := 0;
EXPORT InValidMessage_zonecontact_street4(UNSIGNED1 wh) := '';
 
EXPORT Make_zonecontact_city(SALT311.StrType s0) := s0;
EXPORT InValid_zonecontact_city(SALT311.StrType s) := 0;
EXPORT InValidMessage_zonecontact_city(UNSIGNED1 wh) := '';
 
EXPORT Make_zonecontact_state(SALT311.StrType s0) := s0;
EXPORT InValid_zonecontact_state(SALT311.StrType s) := 0;
EXPORT InValidMessage_zonecontact_state(UNSIGNED1 wh) := '';
 
EXPORT Make_zonecontact_postalcode(SALT311.StrType s0) := s0;
EXPORT InValid_zonecontact_postalcode(SALT311.StrType s) := 0;
EXPORT InValidMessage_zonecontact_postalcode(UNSIGNED1 wh) := '';
 
EXPORT Make_zonecontact_country(SALT311.StrType s0) := s0;
EXPORT InValid_zonecontact_country(SALT311.StrType s) := 0;
EXPORT InValidMessage_zonecontact_country(UNSIGNED1 wh) := '';
 
EXPORT Make_zonecontact_fax(SALT311.StrType s0) := s0;
EXPORT InValid_zonecontact_fax(SALT311.StrType s) := 0;
EXPORT InValidMessage_zonecontact_fax(UNSIGNED1 wh) := '';
 
EXPORT Make_zonecontact_faxext(SALT311.StrType s0) := s0;
EXPORT InValid_zonecontact_faxext(SALT311.StrType s) := 0;
EXPORT InValidMessage_zonecontact_faxext(UNSIGNED1 wh) := '';
 
EXPORT Make_zonecontact_phone(SALT311.StrType s0) := s0;
EXPORT InValid_zonecontact_phone(SALT311.StrType s) := 0;
EXPORT InValidMessage_zonecontact_phone(UNSIGNED1 wh) := '';
 
EXPORT Make_zonecontact_phoneext(SALT311.StrType s0) := s0;
EXPORT InValid_zonecontact_phoneext(SALT311.StrType s) := 0;
EXPORT InValidMessage_zonecontact_phoneext(UNSIGNED1 wh) := '';
 
// This macro will compute and count field level differences based upon a pivot expression
export MAC_CountDifferencesByPivot(in_left,in_right,pivot_exp,bad_pivots,out_counts) := MACRO
  IMPORT SALT311,WhoIs;
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
    BOOLEAN Diff_did;
    BOOLEAN Diff_did_score;
    BOOLEAN Diff_process_date;
    BOOLEAN Diff_date_first_seen;
    BOOLEAN Diff_date_last_seen;
    BOOLEAN Diff_date_vendor_first_reported;
    BOOLEAN Diff_date_vendor_last_reported;
    BOOLEAN Diff_clean_cname;
    BOOLEAN Diff_current_rec;
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
    BOOLEAN Diff_clean_title;
    BOOLEAN Diff_clean_fname;
    BOOLEAN Diff_clean_mname;
    BOOLEAN Diff_clean_lname;
    BOOLEAN Diff_clean_name_suffix;
    BOOLEAN Diff_clean_name_score;
    BOOLEAN Diff_rawaid;
    BOOLEAN Diff_append_prep_address_situs;
    BOOLEAN Diff_append_prep_address_last_situs;
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
    BOOLEAN Diff_county;
    BOOLEAN Diff_geo_lat;
    BOOLEAN Diff_geo_long;
    BOOLEAN Diff_msa;
    BOOLEAN Diff_geo_blk;
    BOOLEAN Diff_geo_match;
    BOOLEAN Diff_err_stat;
    BOOLEAN Diff_emailtype;
    BOOLEAN Diff_rawtext;
    BOOLEAN Diff_email;
    BOOLEAN Diff_name;
    BOOLEAN Diff_organization;
    BOOLEAN Diff_street1;
    BOOLEAN Diff_street2;
    BOOLEAN Diff_street3;
    BOOLEAN Diff_street4;
    BOOLEAN Diff_city;
    BOOLEAN Diff_state;
    BOOLEAN Diff_postalcode;
    BOOLEAN Diff_country;
    BOOLEAN Diff_fax;
    BOOLEAN Diff_faxext;
    BOOLEAN Diff_phone;
    BOOLEAN Diff_phoneext;
    BOOLEAN Diff_domainname;
    BOOLEAN Diff_registrarname;
    BOOLEAN Diff_contactemail;
    BOOLEAN Diff_whoisserver;
    BOOLEAN Diff_nameservers;
    BOOLEAN Diff_createddate;
    BOOLEAN Diff_updateddate;
    BOOLEAN Diff_expiresdate;
    BOOLEAN Diff_standardregcreateddate;
    BOOLEAN Diff_standardregupdateddate;
    BOOLEAN Diff_standardregexpiresdate;
    BOOLEAN Diff_status;
    BOOLEAN Diff_audit_auditupdateddate;
    BOOLEAN Diff_registrant_rawtext;
    BOOLEAN Diff_registrant_email;
    BOOLEAN Diff_registrant_name;
    BOOLEAN Diff_registrant_organization;
    BOOLEAN Diff_registrant_street1;
    BOOLEAN Diff_registrant_street2;
    BOOLEAN Diff_registrant_street3;
    BOOLEAN Diff_registrant_street4;
    BOOLEAN Diff_registrant_city;
    BOOLEAN Diff_registrant_state;
    BOOLEAN Diff_registrant_postalcode;
    BOOLEAN Diff_registrant_country;
    BOOLEAN Diff_registrant_fax;
    BOOLEAN Diff_registrant_faxext;
    BOOLEAN Diff_registrant_phone;
    BOOLEAN Diff_registrant_phoneext;
    BOOLEAN Diff_administrativecontact_rawtext;
    BOOLEAN Diff_administrativecontact_email;
    BOOLEAN Diff_administrativecontact_name;
    BOOLEAN Diff_administrativecontact_organization;
    BOOLEAN Diff_administrativecontact_street1;
    BOOLEAN Diff_administrativecontact_street2;
    BOOLEAN Diff_administrativecontact_street3;
    BOOLEAN Diff_administrativecontact_street4;
    BOOLEAN Diff_administrativecontact_city;
    BOOLEAN Diff_administrativecontact_state;
    BOOLEAN Diff_administrativecontact_postalcode;
    BOOLEAN Diff_administrativecontact_country;
    BOOLEAN Diff_administrativecontact_fax;
    BOOLEAN Diff_administrativecontact_faxext;
    BOOLEAN Diff_administrativecontact_phone;
    BOOLEAN Diff_administrativecontact_phoneext;
    BOOLEAN Diff_billingcontact_rawtext;
    BOOLEAN Diff_billingcontact_email;
    BOOLEAN Diff_billingcontact_name;
    BOOLEAN Diff_billingcontact_organization;
    BOOLEAN Diff_billingcontact_street1;
    BOOLEAN Diff_billingcontact_street2;
    BOOLEAN Diff_billingcontact_street3;
    BOOLEAN Diff_billingcontact_street4;
    BOOLEAN Diff_billingcontact_city;
    BOOLEAN Diff_billingcontact_state;
    BOOLEAN Diff_billingcontact_postalcode;
    BOOLEAN Diff_billingcontact_country;
    BOOLEAN Diff_billingcontact_fax;
    BOOLEAN Diff_billingcontact_faxext;
    BOOLEAN Diff_billingcontact_phone;
    BOOLEAN Diff_billingcontact_phoneext;
    BOOLEAN Diff_technicalcontact_rawtext;
    BOOLEAN Diff_technicalcontact_email;
    BOOLEAN Diff_technicalcontact_name;
    BOOLEAN Diff_technicalcontact_organization;
    BOOLEAN Diff_technicalcontact_street1;
    BOOLEAN Diff_technicalcontact_street2;
    BOOLEAN Diff_technicalcontact_street3;
    BOOLEAN Diff_technicalcontact_street4;
    BOOLEAN Diff_technicalcontact_city;
    BOOLEAN Diff_technicalcontact_state;
    BOOLEAN Diff_technicalcontact_postalcode;
    BOOLEAN Diff_technicalcontact_country;
    BOOLEAN Diff_technicalcontact_fax;
    BOOLEAN Diff_technicalcontact_faxext;
    BOOLEAN Diff_technicalcontact_phone;
    BOOLEAN Diff_technicalcontact_phoneext;
    BOOLEAN Diff_zonecontact_rawtext;
    BOOLEAN Diff_zonecontact_email;
    BOOLEAN Diff_zonecontact_name;
    BOOLEAN Diff_zonecontact_organization;
    BOOLEAN Diff_zonecontact_street1;
    BOOLEAN Diff_zonecontact_street2;
    BOOLEAN Diff_zonecontact_street3;
    BOOLEAN Diff_zonecontact_street4;
    BOOLEAN Diff_zonecontact_city;
    BOOLEAN Diff_zonecontact_state;
    BOOLEAN Diff_zonecontact_postalcode;
    BOOLEAN Diff_zonecontact_country;
    BOOLEAN Diff_zonecontact_fax;
    BOOLEAN Diff_zonecontact_faxext;
    BOOLEAN Diff_zonecontact_phone;
    BOOLEAN Diff_zonecontact_phoneext;
    UNSIGNED Num_Diffs;
    SALT311.StrType Val {MAXLENGTH(1024)};
  END;
#uniquename(fd)
  %dl% %fd%(in_left le,in_right ri) := TRANSFORM
    SELF.Diff_did := le.did <> ri.did;
    SELF.Diff_did_score := le.did_score <> ri.did_score;
    SELF.Diff_process_date := le.process_date <> ri.process_date;
    SELF.Diff_date_first_seen := le.date_first_seen <> ri.date_first_seen;
    SELF.Diff_date_last_seen := le.date_last_seen <> ri.date_last_seen;
    SELF.Diff_date_vendor_first_reported := le.date_vendor_first_reported <> ri.date_vendor_first_reported;
    SELF.Diff_date_vendor_last_reported := le.date_vendor_last_reported <> ri.date_vendor_last_reported;
    SELF.Diff_clean_cname := le.clean_cname <> ri.clean_cname;
    SELF.Diff_current_rec := le.current_rec <> ri.current_rec;
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
    SELF.Diff_clean_title := le.clean_title <> ri.clean_title;
    SELF.Diff_clean_fname := le.clean_fname <> ri.clean_fname;
    SELF.Diff_clean_mname := le.clean_mname <> ri.clean_mname;
    SELF.Diff_clean_lname := le.clean_lname <> ri.clean_lname;
    SELF.Diff_clean_name_suffix := le.clean_name_suffix <> ri.clean_name_suffix;
    SELF.Diff_clean_name_score := le.clean_name_score <> ri.clean_name_score;
    SELF.Diff_rawaid := le.rawaid <> ri.rawaid;
    SELF.Diff_append_prep_address_situs := le.append_prep_address_situs <> ri.append_prep_address_situs;
    SELF.Diff_append_prep_address_last_situs := le.append_prep_address_last_situs <> ri.append_prep_address_last_situs;
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
    SELF.Diff_county := le.county <> ri.county;
    SELF.Diff_geo_lat := le.geo_lat <> ri.geo_lat;
    SELF.Diff_geo_long := le.geo_long <> ri.geo_long;
    SELF.Diff_msa := le.msa <> ri.msa;
    SELF.Diff_geo_blk := le.geo_blk <> ri.geo_blk;
    SELF.Diff_geo_match := le.geo_match <> ri.geo_match;
    SELF.Diff_err_stat := le.err_stat <> ri.err_stat;
    SELF.Diff_emailtype := le.emailtype <> ri.emailtype;
    SELF.Diff_rawtext := le.rawtext <> ri.rawtext;
    SELF.Diff_email := le.email <> ri.email;
    SELF.Diff_name := le.name <> ri.name;
    SELF.Diff_organization := le.organization <> ri.organization;
    SELF.Diff_street1 := le.street1 <> ri.street1;
    SELF.Diff_street2 := le.street2 <> ri.street2;
    SELF.Diff_street3 := le.street3 <> ri.street3;
    SELF.Diff_street4 := le.street4 <> ri.street4;
    SELF.Diff_city := le.city <> ri.city;
    SELF.Diff_state := le.state <> ri.state;
    SELF.Diff_postalcode := le.postalcode <> ri.postalcode;
    SELF.Diff_country := le.country <> ri.country;
    SELF.Diff_fax := le.fax <> ri.fax;
    SELF.Diff_faxext := le.faxext <> ri.faxext;
    SELF.Diff_phone := le.phone <> ri.phone;
    SELF.Diff_phoneext := le.phoneext <> ri.phoneext;
    SELF.Diff_domainname := le.domainname <> ri.domainname;
    SELF.Diff_registrarname := le.registrarname <> ri.registrarname;
    SELF.Diff_contactemail := le.contactemail <> ri.contactemail;
    SELF.Diff_whoisserver := le.whoisserver <> ri.whoisserver;
    SELF.Diff_nameservers := le.nameservers <> ri.nameservers;
    SELF.Diff_createddate := le.createddate <> ri.createddate;
    SELF.Diff_updateddate := le.updateddate <> ri.updateddate;
    SELF.Diff_expiresdate := le.expiresdate <> ri.expiresdate;
    SELF.Diff_standardregcreateddate := le.standardregcreateddate <> ri.standardregcreateddate;
    SELF.Diff_standardregupdateddate := le.standardregupdateddate <> ri.standardregupdateddate;
    SELF.Diff_standardregexpiresdate := le.standardregexpiresdate <> ri.standardregexpiresdate;
    SELF.Diff_status := le.status <> ri.status;
    SELF.Diff_audit_auditupdateddate := le.audit_auditupdateddate <> ri.audit_auditupdateddate;
    SELF.Diff_registrant_rawtext := le.registrant_rawtext <> ri.registrant_rawtext;
    SELF.Diff_registrant_email := le.registrant_email <> ri.registrant_email;
    SELF.Diff_registrant_name := le.registrant_name <> ri.registrant_name;
    SELF.Diff_registrant_organization := le.registrant_organization <> ri.registrant_organization;
    SELF.Diff_registrant_street1 := le.registrant_street1 <> ri.registrant_street1;
    SELF.Diff_registrant_street2 := le.registrant_street2 <> ri.registrant_street2;
    SELF.Diff_registrant_street3 := le.registrant_street3 <> ri.registrant_street3;
    SELF.Diff_registrant_street4 := le.registrant_street4 <> ri.registrant_street4;
    SELF.Diff_registrant_city := le.registrant_city <> ri.registrant_city;
    SELF.Diff_registrant_state := le.registrant_state <> ri.registrant_state;
    SELF.Diff_registrant_postalcode := le.registrant_postalcode <> ri.registrant_postalcode;
    SELF.Diff_registrant_country := le.registrant_country <> ri.registrant_country;
    SELF.Diff_registrant_fax := le.registrant_fax <> ri.registrant_fax;
    SELF.Diff_registrant_faxext := le.registrant_faxext <> ri.registrant_faxext;
    SELF.Diff_registrant_phone := le.registrant_phone <> ri.registrant_phone;
    SELF.Diff_registrant_phoneext := le.registrant_phoneext <> ri.registrant_phoneext;
    SELF.Diff_administrativecontact_rawtext := le.administrativecontact_rawtext <> ri.administrativecontact_rawtext;
    SELF.Diff_administrativecontact_email := le.administrativecontact_email <> ri.administrativecontact_email;
    SELF.Diff_administrativecontact_name := le.administrativecontact_name <> ri.administrativecontact_name;
    SELF.Diff_administrativecontact_organization := le.administrativecontact_organization <> ri.administrativecontact_organization;
    SELF.Diff_administrativecontact_street1 := le.administrativecontact_street1 <> ri.administrativecontact_street1;
    SELF.Diff_administrativecontact_street2 := le.administrativecontact_street2 <> ri.administrativecontact_street2;
    SELF.Diff_administrativecontact_street3 := le.administrativecontact_street3 <> ri.administrativecontact_street3;
    SELF.Diff_administrativecontact_street4 := le.administrativecontact_street4 <> ri.administrativecontact_street4;
    SELF.Diff_administrativecontact_city := le.administrativecontact_city <> ri.administrativecontact_city;
    SELF.Diff_administrativecontact_state := le.administrativecontact_state <> ri.administrativecontact_state;
    SELF.Diff_administrativecontact_postalcode := le.administrativecontact_postalcode <> ri.administrativecontact_postalcode;
    SELF.Diff_administrativecontact_country := le.administrativecontact_country <> ri.administrativecontact_country;
    SELF.Diff_administrativecontact_fax := le.administrativecontact_fax <> ri.administrativecontact_fax;
    SELF.Diff_administrativecontact_faxext := le.administrativecontact_faxext <> ri.administrativecontact_faxext;
    SELF.Diff_administrativecontact_phone := le.administrativecontact_phone <> ri.administrativecontact_phone;
    SELF.Diff_administrativecontact_phoneext := le.administrativecontact_phoneext <> ri.administrativecontact_phoneext;
    SELF.Diff_billingcontact_rawtext := le.billingcontact_rawtext <> ri.billingcontact_rawtext;
    SELF.Diff_billingcontact_email := le.billingcontact_email <> ri.billingcontact_email;
    SELF.Diff_billingcontact_name := le.billingcontact_name <> ri.billingcontact_name;
    SELF.Diff_billingcontact_organization := le.billingcontact_organization <> ri.billingcontact_organization;
    SELF.Diff_billingcontact_street1 := le.billingcontact_street1 <> ri.billingcontact_street1;
    SELF.Diff_billingcontact_street2 := le.billingcontact_street2 <> ri.billingcontact_street2;
    SELF.Diff_billingcontact_street3 := le.billingcontact_street3 <> ri.billingcontact_street3;
    SELF.Diff_billingcontact_street4 := le.billingcontact_street4 <> ri.billingcontact_street4;
    SELF.Diff_billingcontact_city := le.billingcontact_city <> ri.billingcontact_city;
    SELF.Diff_billingcontact_state := le.billingcontact_state <> ri.billingcontact_state;
    SELF.Diff_billingcontact_postalcode := le.billingcontact_postalcode <> ri.billingcontact_postalcode;
    SELF.Diff_billingcontact_country := le.billingcontact_country <> ri.billingcontact_country;
    SELF.Diff_billingcontact_fax := le.billingcontact_fax <> ri.billingcontact_fax;
    SELF.Diff_billingcontact_faxext := le.billingcontact_faxext <> ri.billingcontact_faxext;
    SELF.Diff_billingcontact_phone := le.billingcontact_phone <> ri.billingcontact_phone;
    SELF.Diff_billingcontact_phoneext := le.billingcontact_phoneext <> ri.billingcontact_phoneext;
    SELF.Diff_technicalcontact_rawtext := le.technicalcontact_rawtext <> ri.technicalcontact_rawtext;
    SELF.Diff_technicalcontact_email := le.technicalcontact_email <> ri.technicalcontact_email;
    SELF.Diff_technicalcontact_name := le.technicalcontact_name <> ri.technicalcontact_name;
    SELF.Diff_technicalcontact_organization := le.technicalcontact_organization <> ri.technicalcontact_organization;
    SELF.Diff_technicalcontact_street1 := le.technicalcontact_street1 <> ri.technicalcontact_street1;
    SELF.Diff_technicalcontact_street2 := le.technicalcontact_street2 <> ri.technicalcontact_street2;
    SELF.Diff_technicalcontact_street3 := le.technicalcontact_street3 <> ri.technicalcontact_street3;
    SELF.Diff_technicalcontact_street4 := le.technicalcontact_street4 <> ri.technicalcontact_street4;
    SELF.Diff_technicalcontact_city := le.technicalcontact_city <> ri.technicalcontact_city;
    SELF.Diff_technicalcontact_state := le.technicalcontact_state <> ri.technicalcontact_state;
    SELF.Diff_technicalcontact_postalcode := le.technicalcontact_postalcode <> ri.technicalcontact_postalcode;
    SELF.Diff_technicalcontact_country := le.technicalcontact_country <> ri.technicalcontact_country;
    SELF.Diff_technicalcontact_fax := le.technicalcontact_fax <> ri.technicalcontact_fax;
    SELF.Diff_technicalcontact_faxext := le.technicalcontact_faxext <> ri.technicalcontact_faxext;
    SELF.Diff_technicalcontact_phone := le.technicalcontact_phone <> ri.technicalcontact_phone;
    SELF.Diff_technicalcontact_phoneext := le.technicalcontact_phoneext <> ri.technicalcontact_phoneext;
    SELF.Diff_zonecontact_rawtext := le.zonecontact_rawtext <> ri.zonecontact_rawtext;
    SELF.Diff_zonecontact_email := le.zonecontact_email <> ri.zonecontact_email;
    SELF.Diff_zonecontact_name := le.zonecontact_name <> ri.zonecontact_name;
    SELF.Diff_zonecontact_organization := le.zonecontact_organization <> ri.zonecontact_organization;
    SELF.Diff_zonecontact_street1 := le.zonecontact_street1 <> ri.zonecontact_street1;
    SELF.Diff_zonecontact_street2 := le.zonecontact_street2 <> ri.zonecontact_street2;
    SELF.Diff_zonecontact_street3 := le.zonecontact_street3 <> ri.zonecontact_street3;
    SELF.Diff_zonecontact_street4 := le.zonecontact_street4 <> ri.zonecontact_street4;
    SELF.Diff_zonecontact_city := le.zonecontact_city <> ri.zonecontact_city;
    SELF.Diff_zonecontact_state := le.zonecontact_state <> ri.zonecontact_state;
    SELF.Diff_zonecontact_postalcode := le.zonecontact_postalcode <> ri.zonecontact_postalcode;
    SELF.Diff_zonecontact_country := le.zonecontact_country <> ri.zonecontact_country;
    SELF.Diff_zonecontact_fax := le.zonecontact_fax <> ri.zonecontact_fax;
    SELF.Diff_zonecontact_faxext := le.zonecontact_faxext <> ri.zonecontact_faxext;
    SELF.Diff_zonecontact_phone := le.zonecontact_phone <> ri.zonecontact_phone;
    SELF.Diff_zonecontact_phoneext := le.zonecontact_phoneext <> ri.zonecontact_phoneext;
    SELF.Val := (SALT311.StrType)evaluate(le,pivot_exp);
    SELF.Num_Diffs := 0+ IF( SELF.Diff_did,1,0)+ IF( SELF.Diff_did_score,1,0)+ IF( SELF.Diff_clean_cname,1,0)+ IF( SELF.Diff_current_rec,1,0)+ IF( SELF.Diff_dotid,1,0)+ IF( SELF.Diff_dotscore,1,0)+ IF( SELF.Diff_dotweight,1,0)+ IF( SELF.Diff_empid,1,0)+ IF( SELF.Diff_empscore,1,0)+ IF( SELF.Diff_empweight,1,0)+ IF( SELF.Diff_powid,1,0)+ IF( SELF.Diff_powscore,1,0)+ IF( SELF.Diff_powweight,1,0)+ IF( SELF.Diff_proxid,1,0)+ IF( SELF.Diff_proxscore,1,0)+ IF( SELF.Diff_proxweight,1,0)+ IF( SELF.Diff_seleid,1,0)+ IF( SELF.Diff_selescore,1,0)+ IF( SELF.Diff_seleweight,1,0)+ IF( SELF.Diff_orgid,1,0)+ IF( SELF.Diff_orgscore,1,0)+ IF( SELF.Diff_orgweight,1,0)+ IF( SELF.Diff_ultid,1,0)+ IF( SELF.Diff_ultscore,1,0)+ IF( SELF.Diff_ultweight,1,0)+ IF( SELF.Diff_clean_title,1,0)+ IF( SELF.Diff_clean_fname,1,0)+ IF( SELF.Diff_clean_mname,1,0)+ IF( SELF.Diff_clean_lname,1,0)+ IF( SELF.Diff_clean_name_suffix,1,0)+ IF( SELF.Diff_clean_name_score,1,0)+ IF( SELF.Diff_rawaid,1,0)+ IF( SELF.Diff_append_prep_address_situs,1,0)+ IF( SELF.Diff_append_prep_address_last_situs,1,0)+ IF( SELF.Diff_prim_range,1,0)+ IF( SELF.Diff_predir,1,0)+ IF( SELF.Diff_prim_name,1,0)+ IF( SELF.Diff_addr_suffix,1,0)+ IF( SELF.Diff_postdir,1,0)+ IF( SELF.Diff_unit_desig,1,0)+ IF( SELF.Diff_sec_range,1,0)+ IF( SELF.Diff_p_city_name,1,0)+ IF( SELF.Diff_v_city_name,1,0)+ IF( SELF.Diff_st,1,0)+ IF( SELF.Diff_zip,1,0)+ IF( SELF.Diff_zip4,1,0)+ IF( SELF.Diff_cart,1,0)+ IF( SELF.Diff_cr_sort_sz,1,0)+ IF( SELF.Diff_lot,1,0)+ IF( SELF.Diff_lot_order,1,0)+ IF( SELF.Diff_dbpc,1,0)+ IF( SELF.Diff_chk_digit,1,0)+ IF( SELF.Diff_rec_type,1,0)+ IF( SELF.Diff_county,1,0)+ IF( SELF.Diff_geo_lat,1,0)+ IF( SELF.Diff_geo_long,1,0)+ IF( SELF.Diff_msa,1,0)+ IF( SELF.Diff_geo_blk,1,0)+ IF( SELF.Diff_geo_match,1,0)+ IF( SELF.Diff_err_stat,1,0)+ IF( SELF.Diff_emailtype,1,0)+ IF( SELF.Diff_rawtext,1,0)+ IF( SELF.Diff_email,1,0)+ IF( SELF.Diff_name,1,0)+ IF( SELF.Diff_organization,1,0)+ IF( SELF.Diff_street1,1,0)+ IF( SELF.Diff_street2,1,0)+ IF( SELF.Diff_street3,1,0)+ IF( SELF.Diff_street4,1,0)+ IF( SELF.Diff_city,1,0)+ IF( SELF.Diff_state,1,0)+ IF( SELF.Diff_postalcode,1,0)+ IF( SELF.Diff_country,1,0)+ IF( SELF.Diff_fax,1,0)+ IF( SELF.Diff_faxext,1,0)+ IF( SELF.Diff_phone,1,0)+ IF( SELF.Diff_phoneext,1,0)+ IF( SELF.Diff_domainname,1,0)+ IF( SELF.Diff_registrarname,1,0)+ IF( SELF.Diff_contactemail,1,0)+ IF( SELF.Diff_whoisserver,1,0)+ IF( SELF.Diff_nameservers,1,0)+ IF( SELF.Diff_createddate,1,0)+ IF( SELF.Diff_updateddate,1,0)+ IF( SELF.Diff_expiresdate,1,0)+ IF( SELF.Diff_standardregcreateddate,1,0)+ IF( SELF.Diff_standardregupdateddate,1,0)+ IF( SELF.Diff_standardregexpiresdate,1,0)+ IF( SELF.Diff_status,1,0)+ IF( SELF.Diff_audit_auditupdateddate,1,0)+ IF( SELF.Diff_registrant_rawtext,1,0)+ IF( SELF.Diff_registrant_email,1,0)+ IF( SELF.Diff_registrant_name,1,0)+ IF( SELF.Diff_registrant_organization,1,0)+ IF( SELF.Diff_registrant_street1,1,0)+ IF( SELF.Diff_registrant_street2,1,0)+ IF( SELF.Diff_registrant_street3,1,0)+ IF( SELF.Diff_registrant_street4,1,0)+ IF( SELF.Diff_registrant_city,1,0)+ IF( SELF.Diff_registrant_state,1,0)+ IF( SELF.Diff_registrant_postalcode,1,0)+ IF( SELF.Diff_registrant_country,1,0)+ IF( SELF.Diff_registrant_fax,1,0)+ IF( SELF.Diff_registrant_faxext,1,0)+ IF( SELF.Diff_registrant_phone,1,0)+ IF( SELF.Diff_registrant_phoneext,1,0)+ IF( SELF.Diff_administrativecontact_rawtext,1,0)+ IF( SELF.Diff_administrativecontact_email,1,0)+ IF( SELF.Diff_administrativecontact_name,1,0)+ IF( SELF.Diff_administrativecontact_organization,1,0)+ IF( SELF.Diff_administrativecontact_street1,1,0)+ IF( SELF.Diff_administrativecontact_street2,1,0)+ IF( SELF.Diff_administrativecontact_street3,1,0)+ IF( SELF.Diff_administrativecontact_street4,1,0)+ IF( SELF.Diff_administrativecontact_city,1,0)+ IF( SELF.Diff_administrativecontact_state,1,0)+ IF( SELF.Diff_administrativecontact_postalcode,1,0)+ IF( SELF.Diff_administrativecontact_country,1,0)+ IF( SELF.Diff_administrativecontact_fax,1,0)+ IF( SELF.Diff_administrativecontact_faxext,1,0)+ IF( SELF.Diff_administrativecontact_phone,1,0)+ IF( SELF.Diff_administrativecontact_phoneext,1,0)+ IF( SELF.Diff_billingcontact_rawtext,1,0)+ IF( SELF.Diff_billingcontact_email,1,0)+ IF( SELF.Diff_billingcontact_name,1,0)+ IF( SELF.Diff_billingcontact_organization,1,0)+ IF( SELF.Diff_billingcontact_street1,1,0)+ IF( SELF.Diff_billingcontact_street2,1,0)+ IF( SELF.Diff_billingcontact_street3,1,0)+ IF( SELF.Diff_billingcontact_street4,1,0)+ IF( SELF.Diff_billingcontact_city,1,0)+ IF( SELF.Diff_billingcontact_state,1,0)+ IF( SELF.Diff_billingcontact_postalcode,1,0)+ IF( SELF.Diff_billingcontact_country,1,0)+ IF( SELF.Diff_billingcontact_fax,1,0)+ IF( SELF.Diff_billingcontact_faxext,1,0)+ IF( SELF.Diff_billingcontact_phone,1,0)+ IF( SELF.Diff_billingcontact_phoneext,1,0)+ IF( SELF.Diff_technicalcontact_rawtext,1,0)+ IF( SELF.Diff_technicalcontact_email,1,0)+ IF( SELF.Diff_technicalcontact_name,1,0)+ IF( SELF.Diff_technicalcontact_organization,1,0)+ IF( SELF.Diff_technicalcontact_street1,1,0)+ IF( SELF.Diff_technicalcontact_street2,1,0)+ IF( SELF.Diff_technicalcontact_street3,1,0)+ IF( SELF.Diff_technicalcontact_street4,1,0)+ IF( SELF.Diff_technicalcontact_city,1,0)+ IF( SELF.Diff_technicalcontact_state,1,0)+ IF( SELF.Diff_technicalcontact_postalcode,1,0)+ IF( SELF.Diff_technicalcontact_country,1,0)+ IF( SELF.Diff_technicalcontact_fax,1,0)+ IF( SELF.Diff_technicalcontact_faxext,1,0)+ IF( SELF.Diff_technicalcontact_phone,1,0)+ IF( SELF.Diff_technicalcontact_phoneext,1,0)+ IF( SELF.Diff_zonecontact_rawtext,1,0)+ IF( SELF.Diff_zonecontact_email,1,0)+ IF( SELF.Diff_zonecontact_name,1,0)+ IF( SELF.Diff_zonecontact_organization,1,0)+ IF( SELF.Diff_zonecontact_street1,1,0)+ IF( SELF.Diff_zonecontact_street2,1,0)+ IF( SELF.Diff_zonecontact_street3,1,0)+ IF( SELF.Diff_zonecontact_street4,1,0)+ IF( SELF.Diff_zonecontact_city,1,0)+ IF( SELF.Diff_zonecontact_state,1,0)+ IF( SELF.Diff_zonecontact_postalcode,1,0)+ IF( SELF.Diff_zonecontact_country,1,0)+ IF( SELF.Diff_zonecontact_fax,1,0)+ IF( SELF.Diff_zonecontact_faxext,1,0)+ IF( SELF.Diff_zonecontact_phone,1,0)+ IF( SELF.Diff_zonecontact_phoneext,1,0);
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
    Count_Diff_did := COUNT(GROUP,%Closest%.Diff_did);
    Count_Diff_did_score := COUNT(GROUP,%Closest%.Diff_did_score);
    Count_Diff_process_date := COUNT(GROUP,%Closest%.Diff_process_date);
    Count_Diff_date_first_seen := COUNT(GROUP,%Closest%.Diff_date_first_seen);
    Count_Diff_date_last_seen := COUNT(GROUP,%Closest%.Diff_date_last_seen);
    Count_Diff_date_vendor_first_reported := COUNT(GROUP,%Closest%.Diff_date_vendor_first_reported);
    Count_Diff_date_vendor_last_reported := COUNT(GROUP,%Closest%.Diff_date_vendor_last_reported);
    Count_Diff_clean_cname := COUNT(GROUP,%Closest%.Diff_clean_cname);
    Count_Diff_current_rec := COUNT(GROUP,%Closest%.Diff_current_rec);
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
    Count_Diff_clean_title := COUNT(GROUP,%Closest%.Diff_clean_title);
    Count_Diff_clean_fname := COUNT(GROUP,%Closest%.Diff_clean_fname);
    Count_Diff_clean_mname := COUNT(GROUP,%Closest%.Diff_clean_mname);
    Count_Diff_clean_lname := COUNT(GROUP,%Closest%.Diff_clean_lname);
    Count_Diff_clean_name_suffix := COUNT(GROUP,%Closest%.Diff_clean_name_suffix);
    Count_Diff_clean_name_score := COUNT(GROUP,%Closest%.Diff_clean_name_score);
    Count_Diff_rawaid := COUNT(GROUP,%Closest%.Diff_rawaid);
    Count_Diff_append_prep_address_situs := COUNT(GROUP,%Closest%.Diff_append_prep_address_situs);
    Count_Diff_append_prep_address_last_situs := COUNT(GROUP,%Closest%.Diff_append_prep_address_last_situs);
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
    Count_Diff_county := COUNT(GROUP,%Closest%.Diff_county);
    Count_Diff_geo_lat := COUNT(GROUP,%Closest%.Diff_geo_lat);
    Count_Diff_geo_long := COUNT(GROUP,%Closest%.Diff_geo_long);
    Count_Diff_msa := COUNT(GROUP,%Closest%.Diff_msa);
    Count_Diff_geo_blk := COUNT(GROUP,%Closest%.Diff_geo_blk);
    Count_Diff_geo_match := COUNT(GROUP,%Closest%.Diff_geo_match);
    Count_Diff_err_stat := COUNT(GROUP,%Closest%.Diff_err_stat);
    Count_Diff_emailtype := COUNT(GROUP,%Closest%.Diff_emailtype);
    Count_Diff_rawtext := COUNT(GROUP,%Closest%.Diff_rawtext);
    Count_Diff_email := COUNT(GROUP,%Closest%.Diff_email);
    Count_Diff_name := COUNT(GROUP,%Closest%.Diff_name);
    Count_Diff_organization := COUNT(GROUP,%Closest%.Diff_organization);
    Count_Diff_street1 := COUNT(GROUP,%Closest%.Diff_street1);
    Count_Diff_street2 := COUNT(GROUP,%Closest%.Diff_street2);
    Count_Diff_street3 := COUNT(GROUP,%Closest%.Diff_street3);
    Count_Diff_street4 := COUNT(GROUP,%Closest%.Diff_street4);
    Count_Diff_city := COUNT(GROUP,%Closest%.Diff_city);
    Count_Diff_state := COUNT(GROUP,%Closest%.Diff_state);
    Count_Diff_postalcode := COUNT(GROUP,%Closest%.Diff_postalcode);
    Count_Diff_country := COUNT(GROUP,%Closest%.Diff_country);
    Count_Diff_fax := COUNT(GROUP,%Closest%.Diff_fax);
    Count_Diff_faxext := COUNT(GROUP,%Closest%.Diff_faxext);
    Count_Diff_phone := COUNT(GROUP,%Closest%.Diff_phone);
    Count_Diff_phoneext := COUNT(GROUP,%Closest%.Diff_phoneext);
    Count_Diff_domainname := COUNT(GROUP,%Closest%.Diff_domainname);
    Count_Diff_registrarname := COUNT(GROUP,%Closest%.Diff_registrarname);
    Count_Diff_contactemail := COUNT(GROUP,%Closest%.Diff_contactemail);
    Count_Diff_whoisserver := COUNT(GROUP,%Closest%.Diff_whoisserver);
    Count_Diff_nameservers := COUNT(GROUP,%Closest%.Diff_nameservers);
    Count_Diff_createddate := COUNT(GROUP,%Closest%.Diff_createddate);
    Count_Diff_updateddate := COUNT(GROUP,%Closest%.Diff_updateddate);
    Count_Diff_expiresdate := COUNT(GROUP,%Closest%.Diff_expiresdate);
    Count_Diff_standardregcreateddate := COUNT(GROUP,%Closest%.Diff_standardregcreateddate);
    Count_Diff_standardregupdateddate := COUNT(GROUP,%Closest%.Diff_standardregupdateddate);
    Count_Diff_standardregexpiresdate := COUNT(GROUP,%Closest%.Diff_standardregexpiresdate);
    Count_Diff_status := COUNT(GROUP,%Closest%.Diff_status);
    Count_Diff_audit_auditupdateddate := COUNT(GROUP,%Closest%.Diff_audit_auditupdateddate);
    Count_Diff_registrant_rawtext := COUNT(GROUP,%Closest%.Diff_registrant_rawtext);
    Count_Diff_registrant_email := COUNT(GROUP,%Closest%.Diff_registrant_email);
    Count_Diff_registrant_name := COUNT(GROUP,%Closest%.Diff_registrant_name);
    Count_Diff_registrant_organization := COUNT(GROUP,%Closest%.Diff_registrant_organization);
    Count_Diff_registrant_street1 := COUNT(GROUP,%Closest%.Diff_registrant_street1);
    Count_Diff_registrant_street2 := COUNT(GROUP,%Closest%.Diff_registrant_street2);
    Count_Diff_registrant_street3 := COUNT(GROUP,%Closest%.Diff_registrant_street3);
    Count_Diff_registrant_street4 := COUNT(GROUP,%Closest%.Diff_registrant_street4);
    Count_Diff_registrant_city := COUNT(GROUP,%Closest%.Diff_registrant_city);
    Count_Diff_registrant_state := COUNT(GROUP,%Closest%.Diff_registrant_state);
    Count_Diff_registrant_postalcode := COUNT(GROUP,%Closest%.Diff_registrant_postalcode);
    Count_Diff_registrant_country := COUNT(GROUP,%Closest%.Diff_registrant_country);
    Count_Diff_registrant_fax := COUNT(GROUP,%Closest%.Diff_registrant_fax);
    Count_Diff_registrant_faxext := COUNT(GROUP,%Closest%.Diff_registrant_faxext);
    Count_Diff_registrant_phone := COUNT(GROUP,%Closest%.Diff_registrant_phone);
    Count_Diff_registrant_phoneext := COUNT(GROUP,%Closest%.Diff_registrant_phoneext);
    Count_Diff_administrativecontact_rawtext := COUNT(GROUP,%Closest%.Diff_administrativecontact_rawtext);
    Count_Diff_administrativecontact_email := COUNT(GROUP,%Closest%.Diff_administrativecontact_email);
    Count_Diff_administrativecontact_name := COUNT(GROUP,%Closest%.Diff_administrativecontact_name);
    Count_Diff_administrativecontact_organization := COUNT(GROUP,%Closest%.Diff_administrativecontact_organization);
    Count_Diff_administrativecontact_street1 := COUNT(GROUP,%Closest%.Diff_administrativecontact_street1);
    Count_Diff_administrativecontact_street2 := COUNT(GROUP,%Closest%.Diff_administrativecontact_street2);
    Count_Diff_administrativecontact_street3 := COUNT(GROUP,%Closest%.Diff_administrativecontact_street3);
    Count_Diff_administrativecontact_street4 := COUNT(GROUP,%Closest%.Diff_administrativecontact_street4);
    Count_Diff_administrativecontact_city := COUNT(GROUP,%Closest%.Diff_administrativecontact_city);
    Count_Diff_administrativecontact_state := COUNT(GROUP,%Closest%.Diff_administrativecontact_state);
    Count_Diff_administrativecontact_postalcode := COUNT(GROUP,%Closest%.Diff_administrativecontact_postalcode);
    Count_Diff_administrativecontact_country := COUNT(GROUP,%Closest%.Diff_administrativecontact_country);
    Count_Diff_administrativecontact_fax := COUNT(GROUP,%Closest%.Diff_administrativecontact_fax);
    Count_Diff_administrativecontact_faxext := COUNT(GROUP,%Closest%.Diff_administrativecontact_faxext);
    Count_Diff_administrativecontact_phone := COUNT(GROUP,%Closest%.Diff_administrativecontact_phone);
    Count_Diff_administrativecontact_phoneext := COUNT(GROUP,%Closest%.Diff_administrativecontact_phoneext);
    Count_Diff_billingcontact_rawtext := COUNT(GROUP,%Closest%.Diff_billingcontact_rawtext);
    Count_Diff_billingcontact_email := COUNT(GROUP,%Closest%.Diff_billingcontact_email);
    Count_Diff_billingcontact_name := COUNT(GROUP,%Closest%.Diff_billingcontact_name);
    Count_Diff_billingcontact_organization := COUNT(GROUP,%Closest%.Diff_billingcontact_organization);
    Count_Diff_billingcontact_street1 := COUNT(GROUP,%Closest%.Diff_billingcontact_street1);
    Count_Diff_billingcontact_street2 := COUNT(GROUP,%Closest%.Diff_billingcontact_street2);
    Count_Diff_billingcontact_street3 := COUNT(GROUP,%Closest%.Diff_billingcontact_street3);
    Count_Diff_billingcontact_street4 := COUNT(GROUP,%Closest%.Diff_billingcontact_street4);
    Count_Diff_billingcontact_city := COUNT(GROUP,%Closest%.Diff_billingcontact_city);
    Count_Diff_billingcontact_state := COUNT(GROUP,%Closest%.Diff_billingcontact_state);
    Count_Diff_billingcontact_postalcode := COUNT(GROUP,%Closest%.Diff_billingcontact_postalcode);
    Count_Diff_billingcontact_country := COUNT(GROUP,%Closest%.Diff_billingcontact_country);
    Count_Diff_billingcontact_fax := COUNT(GROUP,%Closest%.Diff_billingcontact_fax);
    Count_Diff_billingcontact_faxext := COUNT(GROUP,%Closest%.Diff_billingcontact_faxext);
    Count_Diff_billingcontact_phone := COUNT(GROUP,%Closest%.Diff_billingcontact_phone);
    Count_Diff_billingcontact_phoneext := COUNT(GROUP,%Closest%.Diff_billingcontact_phoneext);
    Count_Diff_technicalcontact_rawtext := COUNT(GROUP,%Closest%.Diff_technicalcontact_rawtext);
    Count_Diff_technicalcontact_email := COUNT(GROUP,%Closest%.Diff_technicalcontact_email);
    Count_Diff_technicalcontact_name := COUNT(GROUP,%Closest%.Diff_technicalcontact_name);
    Count_Diff_technicalcontact_organization := COUNT(GROUP,%Closest%.Diff_technicalcontact_organization);
    Count_Diff_technicalcontact_street1 := COUNT(GROUP,%Closest%.Diff_technicalcontact_street1);
    Count_Diff_technicalcontact_street2 := COUNT(GROUP,%Closest%.Diff_technicalcontact_street2);
    Count_Diff_technicalcontact_street3 := COUNT(GROUP,%Closest%.Diff_technicalcontact_street3);
    Count_Diff_technicalcontact_street4 := COUNT(GROUP,%Closest%.Diff_technicalcontact_street4);
    Count_Diff_technicalcontact_city := COUNT(GROUP,%Closest%.Diff_technicalcontact_city);
    Count_Diff_technicalcontact_state := COUNT(GROUP,%Closest%.Diff_technicalcontact_state);
    Count_Diff_technicalcontact_postalcode := COUNT(GROUP,%Closest%.Diff_technicalcontact_postalcode);
    Count_Diff_technicalcontact_country := COUNT(GROUP,%Closest%.Diff_technicalcontact_country);
    Count_Diff_technicalcontact_fax := COUNT(GROUP,%Closest%.Diff_technicalcontact_fax);
    Count_Diff_technicalcontact_faxext := COUNT(GROUP,%Closest%.Diff_technicalcontact_faxext);
    Count_Diff_technicalcontact_phone := COUNT(GROUP,%Closest%.Diff_technicalcontact_phone);
    Count_Diff_technicalcontact_phoneext := COUNT(GROUP,%Closest%.Diff_technicalcontact_phoneext);
    Count_Diff_zonecontact_rawtext := COUNT(GROUP,%Closest%.Diff_zonecontact_rawtext);
    Count_Diff_zonecontact_email := COUNT(GROUP,%Closest%.Diff_zonecontact_email);
    Count_Diff_zonecontact_name := COUNT(GROUP,%Closest%.Diff_zonecontact_name);
    Count_Diff_zonecontact_organization := COUNT(GROUP,%Closest%.Diff_zonecontact_organization);
    Count_Diff_zonecontact_street1 := COUNT(GROUP,%Closest%.Diff_zonecontact_street1);
    Count_Diff_zonecontact_street2 := COUNT(GROUP,%Closest%.Diff_zonecontact_street2);
    Count_Diff_zonecontact_street3 := COUNT(GROUP,%Closest%.Diff_zonecontact_street3);
    Count_Diff_zonecontact_street4 := COUNT(GROUP,%Closest%.Diff_zonecontact_street4);
    Count_Diff_zonecontact_city := COUNT(GROUP,%Closest%.Diff_zonecontact_city);
    Count_Diff_zonecontact_state := COUNT(GROUP,%Closest%.Diff_zonecontact_state);
    Count_Diff_zonecontact_postalcode := COUNT(GROUP,%Closest%.Diff_zonecontact_postalcode);
    Count_Diff_zonecontact_country := COUNT(GROUP,%Closest%.Diff_zonecontact_country);
    Count_Diff_zonecontact_fax := COUNT(GROUP,%Closest%.Diff_zonecontact_fax);
    Count_Diff_zonecontact_faxext := COUNT(GROUP,%Closest%.Diff_zonecontact_faxext);
    Count_Diff_zonecontact_phone := COUNT(GROUP,%Closest%.Diff_zonecontact_phone);
    Count_Diff_zonecontact_phoneext := COUNT(GROUP,%Closest%.Diff_zonecontact_phoneext);
  END;
  out_counts := table(%Closest%,%AggRec%,true);
ENDMACRO;
END;
