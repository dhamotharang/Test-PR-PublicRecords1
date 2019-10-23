IMPORT SALT39;
EXPORT Fields := MODULE
 
EXPORT NumFields := 292;
 
// Processing for each FieldType
EXPORT SALT39.StrType FieldTypeName(UNSIGNED2 i) := CHOOSE(i,'DEFAULT','ALPHA','NAME','NUMBER','WORDBAG','orig_datetime_stamp','orig_global_company_id','orig_company_id','orig_product_cd','orig_method','orig_vertical','orig_function_name','orig_transaction_type','orig_login_history_id','orig_job_id','orig_sequence_number','orig_first_name','orig_middle_name','orig_last_name','orig_ssn','orig_dob','orig_dl_num','orig_dl_state','orig_address1_addressline1','orig_address1_addressline2','orig_address1_prim_range','orig_address1_predir','orig_address1_prim_name','orig_address1_suffix','orig_address1_postdir','orig_address1_unit_desig','orig_address1_sec_range','orig_address1_city','orig_address1_st','orig_address1_z5','orig_address1_z4','orig_address2_addressline1','orig_address2_addressline2','orig_address2_prim_range','orig_address2_predir','orig_address2_prim_name','orig_address2_suffix','orig_address2_postdir','orig_address2_unit_desig','orig_address2_sec_range','orig_address2_city','orig_address2_st','orig_address2_z5','orig_address2_z4','orig_bdid','orig_bdl','orig_did','orig_company_name','orig_fein','orig_phone','orig_work_phone','orig_company_phone','orig_reference_code','orig_ip_address_initiated','orig_ip_address_executed','orig_charter_number','orig_ucc_original_filing_number','orig_email_address','orig_domain_name','orig_full_name','orig_dl_purpose','orig_glb_purpose','orig_fcra_purpose','orig_process_id','orig_suffix_name','orig_former_last_name','orig_business_title','orig_company_addressline1','orig_company_addressline2','orig_company_address_prim_range','orig_company_address_predir','orig_company_address_prim_name','orig_company_address_suffix','orig_company_address_postdir','orig_company_address_unit_desig','orig_company_address_sec_range','orig_company_address_city','orig_company_address_st','orig_company_address_zip5','orig_company_address_zip4','orig_company_fax_number','orig_company_start_date','orig_company_years_in_business','orig_company_sic_code','orig_company_naic_code','orig_company_structure','orig_company_yearly_revenue','orig_subj2_first_name','orig_subj2_middle_name','orig_subj2_last_name','orig_subj2_suffix_name','orig_subj2_full_name','orig_subj2_ssn','orig_subj2_dob','orig_subj2_dl_num','orig_subj2_dl_state','orig_subj2_former_last_name','orig_subj2_address_addressline1','orig_subj2_address_addressline2','orig_subj2_address_prim_range','orig_subj2_address_predir','orig_subj2_address_prim_name','orig_subj2_address_suffix','orig_subj2_address_postdir','orig_subj2_address_unit_desig','orig_subj2_address_sec_range','orig_subj2_address_city','orig_subj2_address_st','orig_subj2_address_z5','orig_subj2_address_z4','orig_subj2_phone','orig_subj2_work_phone','orig_subj2_business_title','orig_subj3_first_name','orig_subj3_middle_name','orig_subj3_last_name','orig_subj3_suffix_name','orig_subj3_full_name','orig_subj3_ssn','orig_subj3_dob','orig_subj3_dl_num','orig_subj3_dl_state','orig_subj3_former_last_name','orig_subj3_address_addressline1','orig_subj3_address_addressline2','orig_subj3_address_prim_range','orig_subj3_address_predir','orig_subj3_address_prim_name','orig_subj3_address_suffix','orig_subj3_address_postdir','orig_subj3_address_unit_desig','orig_subj3_address_sec_range','orig_subj3_address_city','orig_subj3_address_st','orig_subj3_address_z5','orig_subj3_address_z4','orig_subj3_phone','orig_subj3_work_phone','orig_subj3_business_title','orig_email','orig_subj2_email','orig_subj2_company_name','orig_subj2_fein','orig_subj3_email','orig_subj3_company_name','orig_subj3_fein','orig_subj4_first_name','orig_subj4_middle_name','orig_subj4_last_name','orig_subj4_suffix_name','orig_subj4_full_name','orig_subj4_ssn','orig_subj4_dob','orig_subj4_dl_num','orig_subj4_dl_state','orig_subj4_former_last_name','orig_subj4_address_addressline1','orig_subj4_address_addressline2','orig_subj4_address_prim_range','orig_subj4_address_predir','orig_subj4_address_prim_name','orig_subj4_address_suffix','orig_subj4_address_postdir','orig_subj4_address_unit_desig','orig_subj4_address_sec_range','orig_subj4_address_city','orig_subj4_address_st','orig_subj4_address_z5','orig_subj4_address_z4','orig_subj4_phone','orig_subj4_work_phone','orig_subj4_business_title','orig_subj4_email','orig_subj4_company_name','orig_subj4_fein','orig_subj5_first_name','orig_subj5_middle_name','orig_subj5_last_name','orig_subj5_suffix_name','orig_subj5_full_name','orig_subj5_ssn','orig_subj5_dob','orig_subj5_dl_num','orig_subj5_dl_state','orig_subj5_former_last_name','orig_subj5_address_addressline1','orig_subj5_address_addressline2','orig_subj5_address_prim_range','orig_subj5_address_predir','orig_subj5_address_prim_name','orig_subj5_address_suffix','orig_subj5_address_postdir','orig_subj5_address_unit_desig','orig_subj5_address_sec_range','orig_subj5_address_city','orig_subj5_address_st','orig_subj5_address_z5','orig_subj5_address_z4','orig_subj5_phone','orig_subj5_work_phone','orig_subj5_business_title','orig_subj5_email','orig_subj5_company_name','orig_subj5_fein','orig_subj6_first_name','orig_subj6_middle_name','orig_subj6_last_name','orig_subj6_suffix_name','orig_subj6_full_name','orig_subj6_ssn','orig_subj6_dob','orig_subj6_dl_num','orig_subj6_dl_state','orig_subj6_former_last_name','orig_subj6_address_addressline1','orig_subj6_address_addressline2','orig_subj6_address_prim_range','orig_subj6_address_predir','orig_subj6_address_prim_name','orig_subj6_address_suffix','orig_subj6_address_postdir','orig_subj6_address_unit_desig','orig_subj6_address_sec_range','orig_subj6_address_city','orig_subj6_address_st','orig_subj6_address_z5','orig_subj6_address_z4','orig_subj6_phone','orig_subj6_work_phone','orig_subj6_business_title','orig_subj6_email','orig_subj6_company_name','orig_subj6_fein','orig_subj7_first_name','orig_subj7_middle_name','orig_subj7_last_name','orig_subj7_suffix_name','orig_subj7_full_name','orig_subj7_ssn','orig_subj7_dob','orig_subj7_dl_num','orig_subj7_dl_state','orig_subj7_former_last_name','orig_subj7_address_addressline1','orig_subj7_address_addressline2','orig_subj7_address_prim_range','orig_subj7_address_predir','orig_subj7_address_prim_name','orig_subj7_address_suffix','orig_subj7_address_postdir','orig_subj7_address_unit_desig','orig_subj7_address_sec_range','orig_subj7_address_city','orig_subj7_address_st','orig_subj7_address_z5','orig_subj7_address_z4','orig_subj7_phone','orig_subj7_work_phone','orig_subj7_business_title','orig_subj7_email','orig_subj7_company_name','orig_subj7_fein','orig_subj8_first_name','orig_subj8_middle_name','orig_subj8_last_name','orig_subj8_suffix_name','orig_subj8_full_name','orig_subj8_ssn','orig_subj8_dob','orig_subj8_dl_num','orig_subj8_dl_state','orig_subj8_former_last_name','orig_subj8_address_addressline1','orig_subj8_address_addressline2','orig_subj8_address_prim_range','orig_subj8_address_predir','orig_subj8_address_prim_name','orig_subj8_address_suffix','orig_subj8_address_postdir','orig_subj8_address_unit_desig','orig_subj8_address_sec_range','orig_subj8_address_city','orig_subj8_address_st','orig_subj8_address_z5','orig_subj8_address_z4','orig_subj8_phone','orig_subj8_work_phone','orig_subj8_business_title','orig_subj8_email','orig_subj8_company_name','orig_subj8_fein','orig_company_alternate_name');
EXPORT FieldTypeNum(SALT39.StrType fn) := CASE(fn,'DEFAULT' => 1,'ALPHA' => 2,'NAME' => 3,'NUMBER' => 4,'WORDBAG' => 5,'orig_datetime_stamp' => 6,'orig_global_company_id' => 7,'orig_company_id' => 8,'orig_product_cd' => 9,'orig_method' => 10,'orig_vertical' => 11,'orig_function_name' => 12,'orig_transaction_type' => 13,'orig_login_history_id' => 14,'orig_job_id' => 15,'orig_sequence_number' => 16,'orig_first_name' => 17,'orig_middle_name' => 18,'orig_last_name' => 19,'orig_ssn' => 20,'orig_dob' => 21,'orig_dl_num' => 22,'orig_dl_state' => 23,'orig_address1_addressline1' => 24,'orig_address1_addressline2' => 25,'orig_address1_prim_range' => 26,'orig_address1_predir' => 27,'orig_address1_prim_name' => 28,'orig_address1_suffix' => 29,'orig_address1_postdir' => 30,'orig_address1_unit_desig' => 31,'orig_address1_sec_range' => 32,'orig_address1_city' => 33,'orig_address1_st' => 34,'orig_address1_z5' => 35,'orig_address1_z4' => 36,'orig_address2_addressline1' => 37,'orig_address2_addressline2' => 38,'orig_address2_prim_range' => 39,'orig_address2_predir' => 40,'orig_address2_prim_name' => 41,'orig_address2_suffix' => 42,'orig_address2_postdir' => 43,'orig_address2_unit_desig' => 44,'orig_address2_sec_range' => 45,'orig_address2_city' => 46,'orig_address2_st' => 47,'orig_address2_z5' => 48,'orig_address2_z4' => 49,'orig_bdid' => 50,'orig_bdl' => 51,'orig_did' => 52,'orig_company_name' => 53,'orig_fein' => 54,'orig_phone' => 55,'orig_work_phone' => 56,'orig_company_phone' => 57,'orig_reference_code' => 58,'orig_ip_address_initiated' => 59,'orig_ip_address_executed' => 60,'orig_charter_number' => 61,'orig_ucc_original_filing_number' => 62,'orig_email_address' => 63,'orig_domain_name' => 64,'orig_full_name' => 65,'orig_dl_purpose' => 66,'orig_glb_purpose' => 67,'orig_fcra_purpose' => 68,'orig_process_id' => 69,'orig_suffix_name' => 70,'orig_former_last_name' => 71,'orig_business_title' => 72,'orig_company_addressline1' => 73,'orig_company_addressline2' => 74,'orig_company_address_prim_range' => 75,'orig_company_address_predir' => 76,'orig_company_address_prim_name' => 77,'orig_company_address_suffix' => 78,'orig_company_address_postdir' => 79,'orig_company_address_unit_desig' => 80,'orig_company_address_sec_range' => 81,'orig_company_address_city' => 82,'orig_company_address_st' => 83,'orig_company_address_zip5' => 84,'orig_company_address_zip4' => 85,'orig_company_fax_number' => 86,'orig_company_start_date' => 87,'orig_company_years_in_business' => 88,'orig_company_sic_code' => 89,'orig_company_naic_code' => 90,'orig_company_structure' => 91,'orig_company_yearly_revenue' => 92,'orig_subj2_first_name' => 93,'orig_subj2_middle_name' => 94,'orig_subj2_last_name' => 95,'orig_subj2_suffix_name' => 96,'orig_subj2_full_name' => 97,'orig_subj2_ssn' => 98,'orig_subj2_dob' => 99,'orig_subj2_dl_num' => 100,'orig_subj2_dl_state' => 101,'orig_subj2_former_last_name' => 102,'orig_subj2_address_addressline1' => 103,'orig_subj2_address_addressline2' => 104,'orig_subj2_address_prim_range' => 105,'orig_subj2_address_predir' => 106,'orig_subj2_address_prim_name' => 107,'orig_subj2_address_suffix' => 108,'orig_subj2_address_postdir' => 109,'orig_subj2_address_unit_desig' => 110,'orig_subj2_address_sec_range' => 111,'orig_subj2_address_city' => 112,'orig_subj2_address_st' => 113,'orig_subj2_address_z5' => 114,'orig_subj2_address_z4' => 115,'orig_subj2_phone' => 116,'orig_subj2_work_phone' => 117,'orig_subj2_business_title' => 118,'orig_subj3_first_name' => 119,'orig_subj3_middle_name' => 120,'orig_subj3_last_name' => 121,'orig_subj3_suffix_name' => 122,'orig_subj3_full_name' => 123,'orig_subj3_ssn' => 124,'orig_subj3_dob' => 125,'orig_subj3_dl_num' => 126,'orig_subj3_dl_state' => 127,'orig_subj3_former_last_name' => 128,'orig_subj3_address_addressline1' => 129,'orig_subj3_address_addressline2' => 130,'orig_subj3_address_prim_range' => 131,'orig_subj3_address_predir' => 132,'orig_subj3_address_prim_name' => 133,'orig_subj3_address_suffix' => 134,'orig_subj3_address_postdir' => 135,'orig_subj3_address_unit_desig' => 136,'orig_subj3_address_sec_range' => 137,'orig_subj3_address_city' => 138,'orig_subj3_address_st' => 139,'orig_subj3_address_z5' => 140,'orig_subj3_address_z4' => 141,'orig_subj3_phone' => 142,'orig_subj3_work_phone' => 143,'orig_subj3_business_title' => 144,'orig_email' => 145,'orig_subj2_email' => 146,'orig_subj2_company_name' => 147,'orig_subj2_fein' => 148,'orig_subj3_email' => 149,'orig_subj3_company_name' => 150,'orig_subj3_fein' => 151,'orig_subj4_first_name' => 152,'orig_subj4_middle_name' => 153,'orig_subj4_last_name' => 154,'orig_subj4_suffix_name' => 155,'orig_subj4_full_name' => 156,'orig_subj4_ssn' => 157,'orig_subj4_dob' => 158,'orig_subj4_dl_num' => 159,'orig_subj4_dl_state' => 160,'orig_subj4_former_last_name' => 161,'orig_subj4_address_addressline1' => 162,'orig_subj4_address_addressline2' => 163,'orig_subj4_address_prim_range' => 164,'orig_subj4_address_predir' => 165,'orig_subj4_address_prim_name' => 166,'orig_subj4_address_suffix' => 167,'orig_subj4_address_postdir' => 168,'orig_subj4_address_unit_desig' => 169,'orig_subj4_address_sec_range' => 170,'orig_subj4_address_city' => 171,'orig_subj4_address_st' => 172,'orig_subj4_address_z5' => 173,'orig_subj4_address_z4' => 174,'orig_subj4_phone' => 175,'orig_subj4_work_phone' => 176,'orig_subj4_business_title' => 177,'orig_subj4_email' => 178,'orig_subj4_company_name' => 179,'orig_subj4_fein' => 180,'orig_subj5_first_name' => 181,'orig_subj5_middle_name' => 182,'orig_subj5_last_name' => 183,'orig_subj5_suffix_name' => 184,'orig_subj5_full_name' => 185,'orig_subj5_ssn' => 186,'orig_subj5_dob' => 187,'orig_subj5_dl_num' => 188,'orig_subj5_dl_state' => 189,'orig_subj5_former_last_name' => 190,'orig_subj5_address_addressline1' => 191,'orig_subj5_address_addressline2' => 192,'orig_subj5_address_prim_range' => 193,'orig_subj5_address_predir' => 194,'orig_subj5_address_prim_name' => 195,'orig_subj5_address_suffix' => 196,'orig_subj5_address_postdir' => 197,'orig_subj5_address_unit_desig' => 198,'orig_subj5_address_sec_range' => 199,'orig_subj5_address_city' => 200,'orig_subj5_address_st' => 201,'orig_subj5_address_z5' => 202,'orig_subj5_address_z4' => 203,'orig_subj5_phone' => 204,'orig_subj5_work_phone' => 205,'orig_subj5_business_title' => 206,'orig_subj5_email' => 207,'orig_subj5_company_name' => 208,'orig_subj5_fein' => 209,'orig_subj6_first_name' => 210,'orig_subj6_middle_name' => 211,'orig_subj6_last_name' => 212,'orig_subj6_suffix_name' => 213,'orig_subj6_full_name' => 214,'orig_subj6_ssn' => 215,'orig_subj6_dob' => 216,'orig_subj6_dl_num' => 217,'orig_subj6_dl_state' => 218,'orig_subj6_former_last_name' => 219,'orig_subj6_address_addressline1' => 220,'orig_subj6_address_addressline2' => 221,'orig_subj6_address_prim_range' => 222,'orig_subj6_address_predir' => 223,'orig_subj6_address_prim_name' => 224,'orig_subj6_address_suffix' => 225,'orig_subj6_address_postdir' => 226,'orig_subj6_address_unit_desig' => 227,'orig_subj6_address_sec_range' => 228,'orig_subj6_address_city' => 229,'orig_subj6_address_st' => 230,'orig_subj6_address_z5' => 231,'orig_subj6_address_z4' => 232,'orig_subj6_phone' => 233,'orig_subj6_work_phone' => 234,'orig_subj6_business_title' => 235,'orig_subj6_email' => 236,'orig_subj6_company_name' => 237,'orig_subj6_fein' => 238,'orig_subj7_first_name' => 239,'orig_subj7_middle_name' => 240,'orig_subj7_last_name' => 241,'orig_subj7_suffix_name' => 242,'orig_subj7_full_name' => 243,'orig_subj7_ssn' => 244,'orig_subj7_dob' => 245,'orig_subj7_dl_num' => 246,'orig_subj7_dl_state' => 247,'orig_subj7_former_last_name' => 248,'orig_subj7_address_addressline1' => 249,'orig_subj7_address_addressline2' => 250,'orig_subj7_address_prim_range' => 251,'orig_subj7_address_predir' => 252,'orig_subj7_address_prim_name' => 253,'orig_subj7_address_suffix' => 254,'orig_subj7_address_postdir' => 255,'orig_subj7_address_unit_desig' => 256,'orig_subj7_address_sec_range' => 257,'orig_subj7_address_city' => 258,'orig_subj7_address_st' => 259,'orig_subj7_address_z5' => 260,'orig_subj7_address_z4' => 261,'orig_subj7_phone' => 262,'orig_subj7_work_phone' => 263,'orig_subj7_business_title' => 264,'orig_subj7_email' => 265,'orig_subj7_company_name' => 266,'orig_subj7_fein' => 267,'orig_subj8_first_name' => 268,'orig_subj8_middle_name' => 269,'orig_subj8_last_name' => 270,'orig_subj8_suffix_name' => 271,'orig_subj8_full_name' => 272,'orig_subj8_ssn' => 273,'orig_subj8_dob' => 274,'orig_subj8_dl_num' => 275,'orig_subj8_dl_state' => 276,'orig_subj8_former_last_name' => 277,'orig_subj8_address_addressline1' => 278,'orig_subj8_address_addressline2' => 279,'orig_subj8_address_prim_range' => 280,'orig_subj8_address_predir' => 281,'orig_subj8_address_prim_name' => 282,'orig_subj8_address_suffix' => 283,'orig_subj8_address_postdir' => 284,'orig_subj8_address_unit_desig' => 285,'orig_subj8_address_sec_range' => 286,'orig_subj8_address_city' => 287,'orig_subj8_address_st' => 288,'orig_subj8_address_z5' => 289,'orig_subj8_address_z4' => 290,'orig_subj8_phone' => 291,'orig_subj8_work_phone' => 292,'orig_subj8_business_title' => 293,'orig_subj8_email' => 294,'orig_subj8_company_name' => 295,'orig_subj8_fein' => 296,'orig_company_alternate_name' => 297,0);
 
EXPORT MakeFT_DEFAULT(SALT39.StrType s0) := FUNCTION
  s1 := if ( SALT39.StringFind('"\'',s0[1],1)>0 and SALT39.StringFind('"\'',s0[LENGTH(TRIM(s0))],1)>0,s0[2..LENGTH(TRIM(s0))-1],s0 );// Remove quotes if required
  s2 := TRIM(s1,LEFT); // Left trim
  RETURN  s2;
END;
EXPORT InValidFT_DEFAULT(SALT39.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,SALT39.StringFind('"\'',s[1],1)<>0 and SALT39.StringFind('"\'',s[LENGTH(TRIM(s))],1)<>0);
EXPORT InValidMessageFT_DEFAULT(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.NotLeft,SALT39.HygieneErrors.Inquotes('"\''),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_ALPHA(SALT39.StrType s0) := FUNCTION
  s1 := SALT39.stringfilter(s0,'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_ALPHA(SALT39.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT39.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz'))));
EXPORT InValidMessageFT_ALPHA(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz'),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_NAME(SALT39.StrType s0) := FUNCTION
  s1 := SALT39.stringfilter(s0,'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz-,\'.'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_NAME(SALT39.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT39.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz-,\'.'))));
EXPORT InValidMessageFT_NAME(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz-,\'.'),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_NUMBER(SALT39.StrType s0) := FUNCTION
  s1 := SALT39.stringfilter(s0,'0123456789'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_NUMBER(SALT39.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT39.StringFilter(s,'0123456789'))));
EXPORT InValidMessageFT_NUMBER(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.NotInChars('0123456789'),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_WORDBAG(SALT39.StrType s0) := FUNCTION
  s1 := SALT39.stringfilter(s0,'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789<>{}[]-^=!+&,./:|#_@$ '); // Only allow valid symbols
  s2 := SALT39.stringcleanspaces( SALT39.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  RETURN  s2;
END;
EXPORT InValidFT_WORDBAG(SALT39.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT39.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789<>{}[]-^=!+&,./:|#_@$ '))));
EXPORT InValidMessageFT_WORDBAG(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789<>{}[]-^=!+&,./:|#_@$ '),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_orig_datetime_stamp(SALT39.StrType s0) := FUNCTION
  s1 := SALT39.stringfilter(s0,'0123456789 '); // Only allow valid symbols
  s2 := SALT39.stringcleanspaces( SALT39.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  RETURN  MakeFT_NUMBER(s2);
END;
EXPORT InValidFT_orig_datetime_stamp(SALT39.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT39.StringFilter(s,'0123456789 '))),~(LENGTH(TRIM(s)) = 14),~(SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_orig_datetime_stamp(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.NotInChars('0123456789 '),SALT39.HygieneErrors.NotLength('14'),SALT39.HygieneErrors.NotWords('1'),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_orig_global_company_id(SALT39.StrType s0) := FUNCTION
  s1 := SALT39.stringfilter(s0,'0123456789 '); // Only allow valid symbols
  s2 := SALT39.stringcleanspaces( SALT39.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  RETURN  MakeFT_NUMBER(s2);
END;
EXPORT InValidFT_orig_global_company_id(SALT39.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT39.StringFilter(s,'0123456789 '))),~(SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_orig_global_company_id(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.NotInChars('0123456789 '),SALT39.HygieneErrors.NotWords('1'),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_orig_company_id(SALT39.StrType s0) := FUNCTION
  s1 := SALT39.stringfilter(s0,'0123456789 '); // Only allow valid symbols
  s2 := SALT39.stringcleanspaces( SALT39.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  RETURN  MakeFT_NUMBER(s2);
END;
EXPORT InValidFT_orig_company_id(SALT39.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT39.StringFilter(s,'0123456789 '))),~(SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_orig_company_id(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.NotInChars('0123456789 '),SALT39.HygieneErrors.NotWords('1'),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_orig_product_cd(SALT39.StrType s0) := FUNCTION
  s1 := SALT39.stringfilter(s0,'CDOPRTU_ '); // Only allow valid symbols
  s2 := SALT39.stringcleanspaces( SALT39.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_orig_product_cd(SALT39.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT39.StringFilter(s,'CDOPRTU_ '))),~(LENGTH(TRIM(s)) = 0),~(SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 0));
EXPORT InValidMessageFT_orig_product_cd(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.NotLeft,SALT39.HygieneErrors.NotInChars('CDOPRTU_ '),SALT39.HygieneErrors.NotLength('0'),SALT39.HygieneErrors.NotWords('0'),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_orig_method(SALT39.StrType s0) := FUNCTION
  s1 := SALT39.stringfilter(s0,'Bacht '); // Only allow valid symbols
  s2 := SALT39.stringcleanspaces( SALT39.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_orig_method(SALT39.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT39.StringFilter(s,'Bacht '))),~(LENGTH(TRIM(s)) = 5),~(SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_orig_method(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.NotLeft,SALT39.HygieneErrors.NotInChars('Bacht '),SALT39.HygieneErrors.NotLength('5'),SALT39.HygieneErrors.NotWords('1'),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_orig_vertical(SALT39.StrType s0) := FUNCTION
  s1 := SALT39.stringfilter(s0,'ACEILRTV '); // Only allow valid symbols
  s2 := SALT39.stringcleanspaces( SALT39.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_orig_vertical(SALT39.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT39.StringFilter(s,'ACEILRTV '))),~(LENGTH(TRIM(s)) = 0),~(SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 0));
EXPORT InValidMessageFT_orig_vertical(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.NotLeft,SALT39.HygieneErrors.NotInChars('ACEILRTV '),SALT39.HygieneErrors.NotLength('0'),SALT39.HygieneErrors.NotWords('0'),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_orig_function_name(SALT39.StrType s0) := FUNCTION
  s1 := SALT39.stringfilter(s0,'.ABDFILMPRSVW_abcdeghiklnoprstuvw '); // Only allow valid symbols
  s2 := SALT39.stringcleanspaces( SALT39.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  RETURN  s2;
END;
EXPORT InValidFT_orig_function_name(SALT39.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT39.StringFilter(s,'.ABDFILMPRSVW_abcdeghiklnoprstuvw '))),~(SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_orig_function_name(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.NotInChars('.ABDFILMPRSVW_abcdeghiklnoprstuvw '),SALT39.HygieneErrors.NotWords('1'),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_orig_transaction_type(SALT39.StrType s0) := FUNCTION
  s1 := SALT39.stringfilter(s0,'ACEINOPRSTY_ '); // Only allow valid symbols
  s2 := SALT39.stringcleanspaces( SALT39.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_orig_transaction_type(SALT39.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT39.StringFilter(s,'ACEINOPRSTY_ '))),~(LENGTH(TRIM(s)) = 0),~(SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 0));
EXPORT InValidMessageFT_orig_transaction_type(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.NotLeft,SALT39.HygieneErrors.NotInChars('ACEINOPRSTY_ '),SALT39.HygieneErrors.NotLength('0'),SALT39.HygieneErrors.NotWords('0'),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_orig_login_history_id(SALT39.StrType s0) := FUNCTION
  s1 := SALT39.stringfilter(s0,'DGHILNORSTY_ '); // Only allow valid symbols
  s2 := SALT39.stringcleanspaces( SALT39.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_orig_login_history_id(SALT39.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT39.StringFilter(s,'DGHILNORSTY_ '))),~(LENGTH(TRIM(s)) = 0),~(SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 0));
EXPORT InValidMessageFT_orig_login_history_id(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.NotLeft,SALT39.HygieneErrors.NotInChars('DGHILNORSTY_ '),SALT39.HygieneErrors.NotLength('0'),SALT39.HygieneErrors.NotWords('0'),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_orig_job_id(SALT39.StrType s0) := FUNCTION
  s1 := SALT39.stringfilter(s0,'0123456789 '); // Only allow valid symbols
  s2 := SALT39.stringcleanspaces( SALT39.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  RETURN  MakeFT_NUMBER(s2);
END;
EXPORT InValidFT_orig_job_id(SALT39.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT39.StringFilter(s,'0123456789 '))),~(LENGTH(TRIM(s)) = 8),~(SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_orig_job_id(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.NotInChars('0123456789 '),SALT39.HygieneErrors.NotLength('8'),SALT39.HygieneErrors.NotWords('1'),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_orig_sequence_number(SALT39.StrType s0) := FUNCTION
  s1 := SALT39.stringfilter(s0,'0123456789 '); // Only allow valid symbols
  s2 := SALT39.stringcleanspaces( SALT39.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  RETURN  MakeFT_NUMBER(s2);
END;
EXPORT InValidFT_orig_sequence_number(SALT39.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT39.StringFilter(s,'0123456789 '))),~(SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_orig_sequence_number(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.NotInChars('0123456789 '),SALT39.HygieneErrors.NotWords('1'),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_orig_first_name(SALT39.StrType s0) := FUNCTION
  s1 := SALT39.stringfilter(s0,'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz '); // Only allow valid symbols
  s2 := SALT39.stringcleanspaces( SALT39.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  RETURN  MakeFT_ALPHA(s2);
END;
EXPORT InValidFT_orig_first_name(SALT39.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT39.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz '))),~(SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 0 OR SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 1 OR SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 2));
EXPORT InValidMessageFT_orig_first_name(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz '),SALT39.HygieneErrors.NotWords('0,1,2'),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_orig_middle_name(SALT39.StrType s0) := FUNCTION
  s1 := SALT39.stringfilter(s0,'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz '); // Only allow valid symbols
  s2 := SALT39.stringcleanspaces( SALT39.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  RETURN  MakeFT_ALPHA(s2);
END;
EXPORT InValidFT_orig_middle_name(SALT39.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT39.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz '))),~(SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 0 OR SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 1 OR SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 2));
EXPORT InValidMessageFT_orig_middle_name(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz '),SALT39.HygieneErrors.NotWords('0,1,2'),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_orig_last_name(SALT39.StrType s0) := FUNCTION
  s1 := SALT39.stringfilter(s0,'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz '); // Only allow valid symbols
  s2 := SALT39.stringcleanspaces( SALT39.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  RETURN  MakeFT_ALPHA(s2);
END;
EXPORT InValidFT_orig_last_name(SALT39.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT39.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz '))),~(SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 1 OR SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 2 OR SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 0));
EXPORT InValidMessageFT_orig_last_name(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz '),SALT39.HygieneErrors.NotWords('1,2,0'),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_orig_ssn(SALT39.StrType s0) := FUNCTION
  s1 := SALT39.stringfilter(s0,'0123456789 '); // Only allow valid symbols
  s2 := SALT39.stringcleanspaces( SALT39.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  RETURN  MakeFT_NUMBER(s2);
END;
EXPORT InValidFT_orig_ssn(SALT39.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT39.StringFilter(s,'0123456789 '))),~(LENGTH(TRIM(s)) >= 0 AND LENGTH(TRIM(s)) <= 9),~(SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 0 OR SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_orig_ssn(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.NotInChars('0123456789 '),SALT39.HygieneErrors.NotLength('0..9'),SALT39.HygieneErrors.NotWords('0,1'),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_orig_dob(SALT39.StrType s0) := FUNCTION
  s1 := SALT39.stringfilter(s0,'0123456789 '); // Only allow valid symbols
  s2 := SALT39.stringcleanspaces( SALT39.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  RETURN  MakeFT_NUMBER(s2);
END;
EXPORT InValidFT_orig_dob(SALT39.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT39.StringFilter(s,'0123456789 '))),~(LENGTH(TRIM(s)) >= 0 AND LENGTH(TRIM(s)) <= 8),~(SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 0 OR SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_orig_dob(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.NotInChars('0123456789 '),SALT39.HygieneErrors.NotLength('0..8'),SALT39.HygieneErrors.NotWords('0,1'),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_orig_dl_num(SALT39.StrType s0) := FUNCTION
  s1 := SALT39.stringfilter(s0,'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789<>{}[]-^=!+&,./:|#_@$ '); // Only allow valid symbols
  s2 := SALT39.stringcleanspaces( SALT39.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  RETURN  MakeFT_WORDBAG(s2);
END;
EXPORT InValidFT_orig_dl_num(SALT39.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT39.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789<>{}[]-^=!+&,./:|#_@$ '))),~(LENGTH(TRIM(s)) = 0),~(SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 0));
EXPORT InValidMessageFT_orig_dl_num(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789<>{}[]-^=!+&,./:|#_@$ '),SALT39.HygieneErrors.NotLength('0'),SALT39.HygieneErrors.NotWords('0'),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_orig_dl_state(SALT39.StrType s0) := FUNCTION
  s1 := SALT39.stringfilter(s0,'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789<>{}[]-^=!+&,./:|#_@$ '); // Only allow valid symbols
  s2 := SALT39.stringcleanspaces( SALT39.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  RETURN  MakeFT_WORDBAG(s2);
END;
EXPORT InValidFT_orig_dl_state(SALT39.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT39.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789<>{}[]-^=!+&,./:|#_@$ '))),~(LENGTH(TRIM(s)) = 0),~(SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 0));
EXPORT InValidMessageFT_orig_dl_state(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789<>{}[]-^=!+&,./:|#_@$ '),SALT39.HygieneErrors.NotLength('0'),SALT39.HygieneErrors.NotWords('0'),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_orig_address1_addressline1(SALT39.StrType s0) := FUNCTION
  s1 := SALT39.stringfilter(s0,'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789<>{}[]-^=!+&,./:|#_@$ '); // Only allow valid symbols
  s2 := SALT39.stringcleanspaces( SALT39.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  RETURN  MakeFT_WORDBAG(s2);
END;
EXPORT InValidFT_orig_address1_addressline1(SALT39.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT39.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789<>{}[]-^=!+&,./:|#_@$ '))));
EXPORT InValidMessageFT_orig_address1_addressline1(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789<>{}[]-^=!+&,./:|#_@$ '),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_orig_address1_addressline2(SALT39.StrType s0) := FUNCTION
  s1 := SALT39.stringfilter(s0,'12ADEILNRS_ '); // Only allow valid symbols
  s2 := SALT39.stringcleanspaces( SALT39.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_orig_address1_addressline2(SALT39.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT39.StringFilter(s,'12ADEILNRS_ '))),~(LENGTH(TRIM(s)) = 0),~(SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 0));
EXPORT InValidMessageFT_orig_address1_addressline2(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.NotLeft,SALT39.HygieneErrors.NotInChars('12ADEILNRS_ '),SALT39.HygieneErrors.NotLength('0'),SALT39.HygieneErrors.NotWords('0'),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_orig_address1_prim_range(SALT39.StrType s0) := FUNCTION
  s1 := SALT39.stringfilter(s0,' -/0123456789ABNW '); // Only allow valid symbols
  s2 := SALT39.stringcleanspaces( SALT39.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_orig_address1_prim_range(SALT39.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT39.StringFilter(s,' -/0123456789ABNW '))),~(LENGTH(TRIM(s)) = 0 OR LENGTH(TRIM(s)) = 4 OR LENGTH(TRIM(s)) = 3 OR LENGTH(TRIM(s)) = 5 OR LENGTH(TRIM(s)) = 2 OR LENGTH(TRIM(s)) = 1 OR LENGTH(TRIM(s)) = 6 OR LENGTH(TRIM(s)) = 7),~(SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 1 OR SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 0));
EXPORT InValidMessageFT_orig_address1_prim_range(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.NotLeft,SALT39.HygieneErrors.NotInChars(' -/0123456789ABNW '),SALT39.HygieneErrors.NotLength('0,4,3,5,2,1,6,7'),SALT39.HygieneErrors.NotWords('1,0'),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_orig_address1_predir(SALT39.StrType s0) := FUNCTION
  s1 := SALT39.stringfilter(s0,'ENSW '); // Only allow valid symbols
  s2 := SALT39.stringcleanspaces( SALT39.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_orig_address1_predir(SALT39.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT39.StringFilter(s,'ENSW '))),~(LENGTH(TRIM(s)) = 0 OR LENGTH(TRIM(s)) = 1 OR LENGTH(TRIM(s)) = 2),~(SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 0 OR SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_orig_address1_predir(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.NotLeft,SALT39.HygieneErrors.NotInChars('ENSW '),SALT39.HygieneErrors.NotLength('0,1,2'),SALT39.HygieneErrors.NotWords('0,1'),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_orig_address1_prim_name(SALT39.StrType s0) := FUNCTION
  s1 := SALT39.stringfilter(s0,'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789<>{}[]-^=!+&,./:|#_@$ '); // Only allow valid symbols
  s2 := SALT39.stringcleanspaces( SALT39.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  RETURN  MakeFT_WORDBAG(s2);
END;
EXPORT InValidFT_orig_address1_prim_name(SALT39.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT39.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789<>{}[]-^=!+&,./:|#_@$ '))));
EXPORT InValidMessageFT_orig_address1_prim_name(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789<>{}[]-^=!+&,./:|#_@$ '),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_orig_address1_suffix(SALT39.StrType s0) := FUNCTION
  s1 := SALT39.stringfilter(s0,'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz '); // Only allow valid symbols
  s2 := SALT39.stringcleanspaces( SALT39.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  RETURN  MakeFT_ALPHA(s2);
END;
EXPORT InValidFT_orig_address1_suffix(SALT39.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT39.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz '))),~(SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 1 OR SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 0));
EXPORT InValidMessageFT_orig_address1_suffix(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz '),SALT39.HygieneErrors.NotWords('1,0'),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_orig_address1_postdir(SALT39.StrType s0) := FUNCTION
  s1 := SALT39.stringfilter(s0,'ADENPRSW_ '); // Only allow valid symbols
  s2 := SALT39.stringcleanspaces( SALT39.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_orig_address1_postdir(SALT39.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT39.StringFilter(s,'ADENPRSW_ '))),~(SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 0 OR SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_orig_address1_postdir(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.NotLeft,SALT39.HygieneErrors.NotInChars('ADENPRSW_ '),SALT39.HygieneErrors.NotWords('0,1'),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_orig_address1_unit_desig(SALT39.StrType s0) := FUNCTION
  s1 := SALT39.stringfilter(s0,'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz '); // Only allow valid symbols
  s2 := SALT39.stringcleanspaces( SALT39.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  MakeFT_ALPHA(s3);
END;
EXPORT InValidFT_orig_address1_unit_desig(SALT39.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT39.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz '))),~(SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 0 OR SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_orig_address1_unit_desig(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.NotLeft,SALT39.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz '),SALT39.HygieneErrors.NotWords('0,1'),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_orig_address1_sec_range(SALT39.StrType s0) := FUNCTION
  s1 := SALT39.stringfilter(s0,'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789<>{}[]-^=!+&,./:|#_@$ '); // Only allow valid symbols
  s2 := SALT39.stringcleanspaces( SALT39.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  MakeFT_WORDBAG(s3);
END;
EXPORT InValidFT_orig_address1_sec_range(SALT39.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT39.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789<>{}[]-^=!+&,./:|#_@$ '))),~(SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 0 OR SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_orig_address1_sec_range(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.NotLeft,SALT39.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789<>{}[]-^=!+&,./:|#_@$ '),SALT39.HygieneErrors.NotWords('0,1'),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_orig_address1_city(SALT39.StrType s0) := FUNCTION
  s1 := SALT39.stringfilter(s0,'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz '); // Only allow valid symbols
  s2 := SALT39.stringcleanspaces( SALT39.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  RETURN  MakeFT_ALPHA(s2);
END;
EXPORT InValidFT_orig_address1_city(SALT39.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT39.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz '))),~(SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 1 OR SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 2 OR SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 0 OR SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 3));
EXPORT InValidMessageFT_orig_address1_city(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz '),SALT39.HygieneErrors.NotWords('1,2,0,3'),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_orig_address1_st(SALT39.StrType s0) := FUNCTION
  s1 := SALT39.stringfilter(s0,'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz '); // Only allow valid symbols
  s2 := SALT39.stringcleanspaces( SALT39.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  RETURN  MakeFT_ALPHA(s2);
END;
EXPORT InValidFT_orig_address1_st(SALT39.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT39.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz '))),~(LENGTH(TRIM(s)) = 2 OR LENGTH(TRIM(s)) = 0),~(SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 1 OR SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 0));
EXPORT InValidMessageFT_orig_address1_st(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz '),SALT39.HygieneErrors.NotLength('2,0'),SALT39.HygieneErrors.NotWords('1,0'),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_orig_address1_z5(SALT39.StrType s0) := FUNCTION
  s1 := SALT39.stringfilter(s0,'0123456789 '); // Only allow valid symbols
  s2 := SALT39.stringcleanspaces( SALT39.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  RETURN  MakeFT_NUMBER(s2);
END;
EXPORT InValidFT_orig_address1_z5(SALT39.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT39.StringFilter(s,'0123456789 '))),~(LENGTH(TRIM(s)) = 5 OR LENGTH(TRIM(s)) = 0),~(SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 1 OR SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 0));
EXPORT InValidMessageFT_orig_address1_z5(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.NotInChars('0123456789 '),SALT39.HygieneErrors.NotLength('5,0'),SALT39.HygieneErrors.NotWords('1,0'),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_orig_address1_z4(SALT39.StrType s0) := FUNCTION
  s1 := SALT39.stringfilter(s0,'0123456789 '); // Only allow valid symbols
  s2 := SALT39.stringcleanspaces( SALT39.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  RETURN  MakeFT_NUMBER(s2);
END;
EXPORT InValidFT_orig_address1_z4(SALT39.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT39.StringFilter(s,'0123456789 '))),~(LENGTH(TRIM(s)) = 0 OR LENGTH(TRIM(s)) = 4),~(SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 0 OR SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_orig_address1_z4(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.NotInChars('0123456789 '),SALT39.HygieneErrors.NotLength('0,4'),SALT39.HygieneErrors.NotWords('0,1'),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_orig_address2_addressline1(SALT39.StrType s0) := FUNCTION
  s1 := SALT39.stringfilter(s0,'12ADEILNRS_ '); // Only allow valid symbols
  s2 := SALT39.stringcleanspaces( SALT39.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_orig_address2_addressline1(SALT39.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT39.StringFilter(s,'12ADEILNRS_ '))),~(LENGTH(TRIM(s)) = 0),~(SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 0));
EXPORT InValidMessageFT_orig_address2_addressline1(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.NotLeft,SALT39.HygieneErrors.NotInChars('12ADEILNRS_ '),SALT39.HygieneErrors.NotLength('0'),SALT39.HygieneErrors.NotWords('0'),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_orig_address2_addressline2(SALT39.StrType s0) := FUNCTION
  s1 := SALT39.stringfilter(s0,'2ADEILNRS_ '); // Only allow valid symbols
  s2 := SALT39.stringcleanspaces( SALT39.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_orig_address2_addressline2(SALT39.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT39.StringFilter(s,'2ADEILNRS_ '))),~(LENGTH(TRIM(s)) = 0),~(SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 0));
EXPORT InValidMessageFT_orig_address2_addressline2(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.NotLeft,SALT39.HygieneErrors.NotInChars('2ADEILNRS_ '),SALT39.HygieneErrors.NotLength('0'),SALT39.HygieneErrors.NotWords('0'),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_orig_address2_prim_range(SALT39.StrType s0) := FUNCTION
  s1 := SALT39.stringfilter(s0,'2ADEGIMNPRS_ '); // Only allow valid symbols
  s2 := SALT39.stringcleanspaces( SALT39.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_orig_address2_prim_range(SALT39.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT39.StringFilter(s,'2ADEGIMNPRS_ '))),~(LENGTH(TRIM(s)) = 0),~(SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 0));
EXPORT InValidMessageFT_orig_address2_prim_range(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.NotLeft,SALT39.HygieneErrors.NotInChars('2ADEGIMNPRS_ '),SALT39.HygieneErrors.NotLength('0'),SALT39.HygieneErrors.NotWords('0'),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_orig_address2_predir(SALT39.StrType s0) := FUNCTION
  s1 := SALT39.stringfilter(s0,'2ADEIPRS_ '); // Only allow valid symbols
  s2 := SALT39.stringcleanspaces( SALT39.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_orig_address2_predir(SALT39.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT39.StringFilter(s,'2ADEIPRS_ '))),~(LENGTH(TRIM(s)) = 0),~(SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 0));
EXPORT InValidMessageFT_orig_address2_predir(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.NotLeft,SALT39.HygieneErrors.NotInChars('2ADEIPRS_ '),SALT39.HygieneErrors.NotLength('0'),SALT39.HygieneErrors.NotWords('0'),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_orig_address2_prim_name(SALT39.StrType s0) := FUNCTION
  s1 := SALT39.stringfilter(s0,'2ADEIMNPRS_ '); // Only allow valid symbols
  s2 := SALT39.stringcleanspaces( SALT39.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_orig_address2_prim_name(SALT39.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT39.StringFilter(s,'2ADEIMNPRS_ '))),~(LENGTH(TRIM(s)) = 0),~(SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 0));
EXPORT InValidMessageFT_orig_address2_prim_name(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.NotLeft,SALT39.HygieneErrors.NotInChars('2ADEIMNPRS_ '),SALT39.HygieneErrors.NotLength('0'),SALT39.HygieneErrors.NotWords('0'),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_orig_address2_suffix(SALT39.StrType s0) := FUNCTION
  s1 := SALT39.stringfilter(s0,'2ADEFIRSUX_ '); // Only allow valid symbols
  s2 := SALT39.stringcleanspaces( SALT39.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_orig_address2_suffix(SALT39.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT39.StringFilter(s,'2ADEFIRSUX_ '))),~(LENGTH(TRIM(s)) = 0),~(SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 0));
EXPORT InValidMessageFT_orig_address2_suffix(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.NotLeft,SALT39.HygieneErrors.NotInChars('2ADEFIRSUX_ '),SALT39.HygieneErrors.NotLength('0'),SALT39.HygieneErrors.NotWords('0'),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_orig_address2_postdir(SALT39.StrType s0) := FUNCTION
  s1 := SALT39.stringfilter(s0,'2ADEIOPRST_ '); // Only allow valid symbols
  s2 := SALT39.stringcleanspaces( SALT39.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_orig_address2_postdir(SALT39.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT39.StringFilter(s,'2ADEIOPRST_ '))),~(LENGTH(TRIM(s)) = 0),~(SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 0));
EXPORT InValidMessageFT_orig_address2_postdir(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.NotLeft,SALT39.HygieneErrors.NotInChars('2ADEIOPRST_ '),SALT39.HygieneErrors.NotLength('0'),SALT39.HygieneErrors.NotWords('0'),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_orig_address2_unit_desig(SALT39.StrType s0) := FUNCTION
  s1 := SALT39.stringfilter(s0,'2ADEGINRSTU_ '); // Only allow valid symbols
  s2 := SALT39.stringcleanspaces( SALT39.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_orig_address2_unit_desig(SALT39.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT39.StringFilter(s,'2ADEGINRSTU_ '))),~(LENGTH(TRIM(s)) = 0),~(SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 0));
EXPORT InValidMessageFT_orig_address2_unit_desig(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.NotLeft,SALT39.HygieneErrors.NotInChars('2ADEGINRSTU_ '),SALT39.HygieneErrors.NotLength('0'),SALT39.HygieneErrors.NotWords('0'),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_orig_address2_sec_range(SALT39.StrType s0) := FUNCTION
  s1 := SALT39.stringfilter(s0,'2ACDEGNRS_ '); // Only allow valid symbols
  s2 := SALT39.stringcleanspaces( SALT39.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_orig_address2_sec_range(SALT39.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT39.StringFilter(s,'2ACDEGNRS_ '))),~(LENGTH(TRIM(s)) = 0),~(SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 0));
EXPORT InValidMessageFT_orig_address2_sec_range(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.NotLeft,SALT39.HygieneErrors.NotInChars('2ACDEGNRS_ '),SALT39.HygieneErrors.NotLength('0'),SALT39.HygieneErrors.NotWords('0'),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_orig_address2_city(SALT39.StrType s0) := FUNCTION
  s1 := SALT39.stringfilter(s0,'2ACDEIRSTY_ '); // Only allow valid symbols
  s2 := SALT39.stringcleanspaces( SALT39.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_orig_address2_city(SALT39.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT39.StringFilter(s,'2ACDEIRSTY_ '))),~(LENGTH(TRIM(s)) = 0),~(SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 0));
EXPORT InValidMessageFT_orig_address2_city(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.NotLeft,SALT39.HygieneErrors.NotInChars('2ACDEIRSTY_ '),SALT39.HygieneErrors.NotLength('0'),SALT39.HygieneErrors.NotWords('0'),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_orig_address2_st(SALT39.StrType s0) := FUNCTION
  s1 := SALT39.stringfilter(s0,'2ADERST_ '); // Only allow valid symbols
  s2 := SALT39.stringcleanspaces( SALT39.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_orig_address2_st(SALT39.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT39.StringFilter(s,'2ADERST_ '))),~(LENGTH(TRIM(s)) = 0),~(SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 0));
EXPORT InValidMessageFT_orig_address2_st(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.NotLeft,SALT39.HygieneErrors.NotInChars('2ADERST_ '),SALT39.HygieneErrors.NotLength('0'),SALT39.HygieneErrors.NotWords('0'),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_orig_address2_z5(SALT39.StrType s0) := FUNCTION
  s1 := SALT39.stringfilter(s0,'25ADERSZ_ '); // Only allow valid symbols
  s2 := SALT39.stringcleanspaces( SALT39.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_orig_address2_z5(SALT39.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT39.StringFilter(s,'25ADERSZ_ '))),~(LENGTH(TRIM(s)) = 0),~(SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 0));
EXPORT InValidMessageFT_orig_address2_z5(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.NotLeft,SALT39.HygieneErrors.NotInChars('25ADERSZ_ '),SALT39.HygieneErrors.NotLength('0'),SALT39.HygieneErrors.NotWords('0'),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_orig_address2_z4(SALT39.StrType s0) := FUNCTION
  s1 := SALT39.stringfilter(s0,'24ADERSZ_ '); // Only allow valid symbols
  s2 := SALT39.stringcleanspaces( SALT39.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_orig_address2_z4(SALT39.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT39.StringFilter(s,'24ADERSZ_ '))),~(LENGTH(TRIM(s)) = 0),~(SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 0));
EXPORT InValidMessageFT_orig_address2_z4(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.NotLeft,SALT39.HygieneErrors.NotInChars('24ADERSZ_ '),SALT39.HygieneErrors.NotLength('0'),SALT39.HygieneErrors.NotWords('0'),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_orig_bdid(SALT39.StrType s0) := FUNCTION
  s1 := SALT39.stringfilter(s0,'0D '); // Only allow valid symbols
  s2 := SALT39.stringcleanspaces( SALT39.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_orig_bdid(SALT39.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT39.StringFilter(s,'0D '))),~(LENGTH(TRIM(s)) = 0 OR LENGTH(TRIM(s)) = 3),~(SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 0 OR SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_orig_bdid(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.NotLeft,SALT39.HygieneErrors.NotInChars('0D '),SALT39.HygieneErrors.NotLength('0,3'),SALT39.HygieneErrors.NotWords('0,1'),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_orig_bdl(SALT39.StrType s0) := FUNCTION
  s1 := SALT39.stringfilter(s0,'BDL '); // Only allow valid symbols
  s2 := SALT39.stringcleanspaces( SALT39.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_orig_bdl(SALT39.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT39.StringFilter(s,'BDL '))),~(LENGTH(TRIM(s)) = 0),~(SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 0));
EXPORT InValidMessageFT_orig_bdl(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.NotLeft,SALT39.HygieneErrors.NotInChars('BDL '),SALT39.HygieneErrors.NotLength('0'),SALT39.HygieneErrors.NotWords('0'),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_orig_did(SALT39.StrType s0) := FUNCTION
  s1 := SALT39.stringfilter(s0,'0123456789 '); // Only allow valid symbols
  s2 := SALT39.stringcleanspaces( SALT39.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  MakeFT_NUMBER(s3);
END;
EXPORT InValidFT_orig_did(SALT39.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT39.StringFilter(s,'0123456789 '))),~(LENGTH(TRIM(s)) = 0 OR LENGTH(TRIM(s)) = 12),~(SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 0 OR SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_orig_did(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.NotLeft,SALT39.HygieneErrors.NotInChars('0123456789 '),SALT39.HygieneErrors.NotLength('0,12'),SALT39.HygieneErrors.NotWords('0,1'),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_orig_company_name(SALT39.StrType s0) := FUNCTION
  s1 := SALT39.stringfilter(s0,'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789<>{}[]-^=!+&,./:|#_@$ '); // Only allow valid symbols
  s2 := SALT39.stringcleanspaces( SALT39.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  MakeFT_WORDBAG(s3);
END;
EXPORT InValidFT_orig_company_name(SALT39.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT39.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789<>{}[]-^=!+&,./:|#_@$ '))),~(LENGTH(TRIM(s)) = 0),~(SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 0));
EXPORT InValidMessageFT_orig_company_name(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.NotLeft,SALT39.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789<>{}[]-^=!+&,./:|#_@$ '),SALT39.HygieneErrors.NotLength('0'),SALT39.HygieneErrors.NotWords('0'),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_orig_fein(SALT39.StrType s0) := FUNCTION
  s1 := SALT39.stringfilter(s0,'0123456789 '); // Only allow valid symbols
  s2 := SALT39.stringcleanspaces( SALT39.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  MakeFT_NUMBER(s3);
END;
EXPORT InValidFT_orig_fein(SALT39.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT39.StringFilter(s,'0123456789 '))),~(LENGTH(TRIM(s)) = 0 OR LENGTH(TRIM(s)) = 9),~(SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 0 OR SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_orig_fein(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.NotLeft,SALT39.HygieneErrors.NotInChars('0123456789 '),SALT39.HygieneErrors.NotLength('0,9'),SALT39.HygieneErrors.NotWords('0,1'),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_orig_phone(SALT39.StrType s0) := FUNCTION
  s1 := SALT39.stringfilter(s0,'0123456789 '); // Only allow valid symbols
  s2 := SALT39.stringcleanspaces( SALT39.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  MakeFT_NUMBER(s3);
END;
EXPORT InValidFT_orig_phone(SALT39.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT39.StringFilter(s,'0123456789 '))),~(LENGTH(TRIM(s)) = 0 OR LENGTH(TRIM(s)) = 10),~(SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 0 OR SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_orig_phone(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.NotLeft,SALT39.HygieneErrors.NotInChars('0123456789 '),SALT39.HygieneErrors.NotLength('0,10'),SALT39.HygieneErrors.NotWords('0,1'),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_orig_work_phone(SALT39.StrType s0) := FUNCTION
  s1 := SALT39.stringfilter(s0,'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789<>{}[]-^=!+&,./:|#_@$ '); // Only allow valid symbols
  s2 := SALT39.stringcleanspaces( SALT39.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  MakeFT_WORDBAG(s3);
END;
EXPORT InValidFT_orig_work_phone(SALT39.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT39.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789<>{}[]-^=!+&,./:|#_@$ '))),~(LENGTH(TRIM(s)) = 0),~(SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 0));
EXPORT InValidMessageFT_orig_work_phone(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.NotLeft,SALT39.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789<>{}[]-^=!+&,./:|#_@$ '),SALT39.HygieneErrors.NotLength('0'),SALT39.HygieneErrors.NotWords('0'),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_orig_company_phone(SALT39.StrType s0) := FUNCTION
  s1 := SALT39.stringfilter(s0,'ACEHMNOPY_ '); // Only allow valid symbols
  s2 := SALT39.stringcleanspaces( SALT39.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_orig_company_phone(SALT39.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT39.StringFilter(s,'ACEHMNOPY_ '))),~(LENGTH(TRIM(s)) = 0),~(SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 0));
EXPORT InValidMessageFT_orig_company_phone(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.NotLeft,SALT39.HygieneErrors.NotInChars('ACEHMNOPY_ '),SALT39.HygieneErrors.NotLength('0'),SALT39.HygieneErrors.NotWords('0'),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_orig_reference_code(SALT39.StrType s0) := FUNCTION
  s1 := SALT39.stringfilter(s0,'CDEFNOR_ '); // Only allow valid symbols
  s2 := SALT39.stringcleanspaces( SALT39.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_orig_reference_code(SALT39.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT39.StringFilter(s,'CDEFNOR_ '))),~(LENGTH(TRIM(s)) = 0),~(SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 0));
EXPORT InValidMessageFT_orig_reference_code(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.NotLeft,SALT39.HygieneErrors.NotInChars('CDEFNOR_ '),SALT39.HygieneErrors.NotLength('0'),SALT39.HygieneErrors.NotWords('0'),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_orig_ip_address_initiated(SALT39.StrType s0) := FUNCTION
  s1 := SALT39.stringfilter(s0,'ADEINPRST_ '); // Only allow valid symbols
  s2 := SALT39.stringcleanspaces( SALT39.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_orig_ip_address_initiated(SALT39.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT39.StringFilter(s,'ADEINPRST_ '))),~(LENGTH(TRIM(s)) = 0),~(SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 0));
EXPORT InValidMessageFT_orig_ip_address_initiated(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.NotLeft,SALT39.HygieneErrors.NotInChars('ADEINPRST_ '),SALT39.HygieneErrors.NotLength('0'),SALT39.HygieneErrors.NotWords('0'),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_orig_ip_address_executed(SALT39.StrType s0) := FUNCTION
  s1 := SALT39.stringfilter(s0,'.01234568 '); // Only allow valid symbols
  s2 := SALT39.stringcleanspaces( SALT39.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_orig_ip_address_executed(SALT39.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT39.StringFilter(s,'.01234568 '))),~(LENGTH(TRIM(s)) = 14 OR LENGTH(TRIM(s)) = 13),~(SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_orig_ip_address_executed(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.NotLeft,SALT39.HygieneErrors.NotInChars('.01234568 '),SALT39.HygieneErrors.NotLength('14,13'),SALT39.HygieneErrors.NotWords('1'),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_orig_charter_number(SALT39.StrType s0) := FUNCTION
  s1 := SALT39.stringfilter(s0,'ABCEHMNRTU_ '); // Only allow valid symbols
  s2 := SALT39.stringcleanspaces( SALT39.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_orig_charter_number(SALT39.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT39.StringFilter(s,'ABCEHMNRTU_ '))),~(LENGTH(TRIM(s)) = 0),~(SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 0));
EXPORT InValidMessageFT_orig_charter_number(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.NotLeft,SALT39.HygieneErrors.NotInChars('ABCEHMNRTU_ '),SALT39.HygieneErrors.NotLength('0'),SALT39.HygieneErrors.NotWords('0'),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_orig_ucc_original_filing_number(SALT39.StrType s0) := FUNCTION
  s1 := SALT39.stringfilter(s0,'ABCEFGILMNORU_ '); // Only allow valid symbols
  s2 := SALT39.stringcleanspaces( SALT39.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_orig_ucc_original_filing_number(SALT39.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT39.StringFilter(s,'ABCEFGILMNORU_ '))),~(LENGTH(TRIM(s)) = 0),~(SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 0));
EXPORT InValidMessageFT_orig_ucc_original_filing_number(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.NotLeft,SALT39.HygieneErrors.NotInChars('ABCEFGILMNORU_ '),SALT39.HygieneErrors.NotLength('0'),SALT39.HygieneErrors.NotWords('0'),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_orig_email_address(SALT39.StrType s0) := FUNCTION
  s1 := SALT39.stringfilter(s0,'ADEILMRS_ '); // Only allow valid symbols
  s2 := SALT39.stringcleanspaces( SALT39.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_orig_email_address(SALT39.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT39.StringFilter(s,'ADEILMRS_ '))),~(LENGTH(TRIM(s)) = 0),~(SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 0));
EXPORT InValidMessageFT_orig_email_address(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.NotLeft,SALT39.HygieneErrors.NotInChars('ADEILMRS_ '),SALT39.HygieneErrors.NotLength('0'),SALT39.HygieneErrors.NotWords('0'),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_orig_domain_name(SALT39.StrType s0) := FUNCTION
  s1 := SALT39.stringfilter(s0,'ADEIMNO_ '); // Only allow valid symbols
  s2 := SALT39.stringcleanspaces( SALT39.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_orig_domain_name(SALT39.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT39.StringFilter(s,'ADEIMNO_ '))),~(LENGTH(TRIM(s)) = 0),~(SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 0));
EXPORT InValidMessageFT_orig_domain_name(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.NotLeft,SALT39.HygieneErrors.NotInChars('ADEIMNO_ '),SALT39.HygieneErrors.NotLength('0'),SALT39.HygieneErrors.NotWords('0'),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_orig_full_name(SALT39.StrType s0) := FUNCTION
  s1 := SALT39.stringfilter(s0,' -ABCDEFGHIJKLMNOPRSTUVWXYZ_ '); // Only allow valid symbols
  s2 := SALT39.stringcleanspaces( SALT39.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_orig_full_name(SALT39.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT39.StringFilter(s,' -ABCDEFGHIJKLMNOPRSTUVWXYZ_ '))),~(LENGTH(TRIM(s)) = 0),~(SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 0));
EXPORT InValidMessageFT_orig_full_name(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.NotLeft,SALT39.HygieneErrors.NotInChars(' -ABCDEFGHIJKLMNOPRSTUVWXYZ_ '),SALT39.HygieneErrors.NotLength('0'),SALT39.HygieneErrors.NotWords('0'),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_orig_dl_purpose(SALT39.StrType s0) := FUNCTION
  s1 := SALT39.stringfilter(s0,'034 '); // Only allow valid symbols
  s2 := SALT39.stringcleanspaces( SALT39.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_orig_dl_purpose(SALT39.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT39.StringFilter(s,'034 '))),~(LENGTH(TRIM(s)) = 1),~(SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_orig_dl_purpose(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.NotLeft,SALT39.HygieneErrors.NotInChars('034 '),SALT39.HygieneErrors.NotLength('1'),SALT39.HygieneErrors.NotWords('1'),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_orig_glb_purpose(SALT39.StrType s0) := FUNCTION
  s1 := SALT39.stringfilter(s0,'0135 '); // Only allow valid symbols
  s2 := SALT39.stringcleanspaces( SALT39.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_orig_glb_purpose(SALT39.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT39.StringFilter(s,'0135 '))),~(LENGTH(TRIM(s)) = 1 OR LENGTH(TRIM(s)) = 2),~(SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_orig_glb_purpose(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.NotLeft,SALT39.HygieneErrors.NotInChars('0135 '),SALT39.HygieneErrors.NotLength('1,2'),SALT39.HygieneErrors.NotWords('1'),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_orig_fcra_purpose(SALT39.StrType s0) := FUNCTION
  s1 := SALT39.stringfilter(s0,'ACEFOPRSU_ '); // Only allow valid symbols
  s2 := SALT39.stringcleanspaces( SALT39.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_orig_fcra_purpose(SALT39.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT39.StringFilter(s,'ACEFOPRSU_ '))),~(LENGTH(TRIM(s)) = 0),~(SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 0));
EXPORT InValidMessageFT_orig_fcra_purpose(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.NotLeft,SALT39.HygieneErrors.NotInChars('ACEFOPRSU_ '),SALT39.HygieneErrors.NotLength('0'),SALT39.HygieneErrors.NotWords('0'),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_orig_process_id(SALT39.StrType s0) := FUNCTION
  s1 := SALT39.stringfilter(s0,'0123456789 '); // Only allow valid symbols
  s2 := SALT39.stringcleanspaces( SALT39.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  MakeFT_NUMBER(s3);
END;
EXPORT InValidFT_orig_process_id(SALT39.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT39.StringFilter(s,'0123456789 '))),~(LENGTH(TRIM(s)) = 1 OR LENGTH(TRIM(s)) = 3 OR LENGTH(TRIM(s)) = 2),~(SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_orig_process_id(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.NotLeft,SALT39.HygieneErrors.NotInChars('0123456789 '),SALT39.HygieneErrors.NotLength('1,3,2'),SALT39.HygieneErrors.NotWords('1'),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_orig_suffix_name(SALT39.StrType s0) := FUNCTION
  s1 := SALT39.stringfilter(s0,'AEFIMNSUX_ '); // Only allow valid symbols
  s2 := SALT39.stringcleanspaces( SALT39.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_orig_suffix_name(SALT39.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT39.StringFilter(s,'AEFIMNSUX_ '))),~(LENGTH(TRIM(s)) = 0),~(SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 0));
EXPORT InValidMessageFT_orig_suffix_name(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.NotLeft,SALT39.HygieneErrors.NotInChars('AEFIMNSUX_ '),SALT39.HygieneErrors.NotLength('0'),SALT39.HygieneErrors.NotWords('0'),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_orig_former_last_name(SALT39.StrType s0) := FUNCTION
  s1 := SALT39.stringfilter(s0,'AEFLMNORST_ '); // Only allow valid symbols
  s2 := SALT39.stringcleanspaces( SALT39.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_orig_former_last_name(SALT39.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT39.StringFilter(s,'AEFLMNORST_ '))),~(LENGTH(TRIM(s)) = 0),~(SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 0));
EXPORT InValidMessageFT_orig_former_last_name(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.NotLeft,SALT39.HygieneErrors.NotInChars('AEFLMNORST_ '),SALT39.HygieneErrors.NotLength('0'),SALT39.HygieneErrors.NotWords('0'),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_orig_business_title(SALT39.StrType s0) := FUNCTION
  s1 := SALT39.stringfilter(s0,'BEILNSTU_ '); // Only allow valid symbols
  s2 := SALT39.stringcleanspaces( SALT39.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_orig_business_title(SALT39.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT39.StringFilter(s,'BEILNSTU_ '))),~(LENGTH(TRIM(s)) = 0),~(SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 0));
EXPORT InValidMessageFT_orig_business_title(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.NotLeft,SALT39.HygieneErrors.NotInChars('BEILNSTU_ '),SALT39.HygieneErrors.NotLength('0'),SALT39.HygieneErrors.NotWords('0'),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_orig_company_addressline1(SALT39.StrType s0) := FUNCTION
  s1 := SALT39.stringfilter(s0,'1ACDEILMNOPRSY_ '); // Only allow valid symbols
  s2 := SALT39.stringcleanspaces( SALT39.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_orig_company_addressline1(SALT39.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT39.StringFilter(s,'1ACDEILMNOPRSY_ '))),~(LENGTH(TRIM(s)) = 0),~(SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 0));
EXPORT InValidMessageFT_orig_company_addressline1(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.NotLeft,SALT39.HygieneErrors.NotInChars('1ACDEILMNOPRSY_ '),SALT39.HygieneErrors.NotLength('0'),SALT39.HygieneErrors.NotWords('0'),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_orig_company_addressline2(SALT39.StrType s0) := FUNCTION
  s1 := SALT39.stringfilter(s0,'2ACDEILMNOPRSY_ '); // Only allow valid symbols
  s2 := SALT39.stringcleanspaces( SALT39.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_orig_company_addressline2(SALT39.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT39.StringFilter(s,'2ACDEILMNOPRSY_ '))),~(LENGTH(TRIM(s)) = 0),~(SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 0));
EXPORT InValidMessageFT_orig_company_addressline2(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.NotLeft,SALT39.HygieneErrors.NotInChars('2ACDEILMNOPRSY_ '),SALT39.HygieneErrors.NotLength('0'),SALT39.HygieneErrors.NotWords('0'),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_orig_company_address_prim_range(SALT39.StrType s0) := FUNCTION
  s1 := SALT39.stringfilter(s0,'ACDEGIMNOPRSY_ '); // Only allow valid symbols
  s2 := SALT39.stringcleanspaces( SALT39.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_orig_company_address_prim_range(SALT39.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT39.StringFilter(s,'ACDEGIMNOPRSY_ '))),~(LENGTH(TRIM(s)) = 0),~(SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 0));
EXPORT InValidMessageFT_orig_company_address_prim_range(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.NotLeft,SALT39.HygieneErrors.NotInChars('ACDEGIMNOPRSY_ '),SALT39.HygieneErrors.NotLength('0'),SALT39.HygieneErrors.NotWords('0'),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_orig_company_address_predir(SALT39.StrType s0) := FUNCTION
  s1 := SALT39.stringfilter(s0,'ACDEIMNOPRSY_ '); // Only allow valid symbols
  s2 := SALT39.stringcleanspaces( SALT39.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_orig_company_address_predir(SALT39.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT39.StringFilter(s,'ACDEIMNOPRSY_ '))),~(LENGTH(TRIM(s)) = 0),~(SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 0));
EXPORT InValidMessageFT_orig_company_address_predir(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.NotLeft,SALT39.HygieneErrors.NotInChars('ACDEIMNOPRSY_ '),SALT39.HygieneErrors.NotLength('0'),SALT39.HygieneErrors.NotWords('0'),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_orig_company_address_prim_name(SALT39.StrType s0) := FUNCTION
  s1 := SALT39.stringfilter(s0,'ACDEIMNOPRSY_ '); // Only allow valid symbols
  s2 := SALT39.stringcleanspaces( SALT39.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_orig_company_address_prim_name(SALT39.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT39.StringFilter(s,'ACDEIMNOPRSY_ '))),~(LENGTH(TRIM(s)) = 0),~(SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 0));
EXPORT InValidMessageFT_orig_company_address_prim_name(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.NotLeft,SALT39.HygieneErrors.NotInChars('ACDEIMNOPRSY_ '),SALT39.HygieneErrors.NotLength('0'),SALT39.HygieneErrors.NotWords('0'),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_orig_company_address_suffix(SALT39.StrType s0) := FUNCTION
  s1 := SALT39.stringfilter(s0,'ACDEFIMNOPRSUXY_ '); // Only allow valid symbols
  s2 := SALT39.stringcleanspaces( SALT39.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_orig_company_address_suffix(SALT39.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT39.StringFilter(s,'ACDEFIMNOPRSUXY_ '))),~(LENGTH(TRIM(s)) = 0),~(SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 0));
EXPORT InValidMessageFT_orig_company_address_suffix(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.NotLeft,SALT39.HygieneErrors.NotInChars('ACDEFIMNOPRSUXY_ '),SALT39.HygieneErrors.NotLength('0'),SALT39.HygieneErrors.NotWords('0'),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_orig_company_address_postdir(SALT39.StrType s0) := FUNCTION
  s1 := SALT39.stringfilter(s0,'ACDEIMNOPRSTY_ '); // Only allow valid symbols
  s2 := SALT39.stringcleanspaces( SALT39.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_orig_company_address_postdir(SALT39.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT39.StringFilter(s,'ACDEIMNOPRSTY_ '))),~(LENGTH(TRIM(s)) = 0),~(SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 0));
EXPORT InValidMessageFT_orig_company_address_postdir(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.NotLeft,SALT39.HygieneErrors.NotInChars('ACDEIMNOPRSTY_ '),SALT39.HygieneErrors.NotLength('0'),SALT39.HygieneErrors.NotWords('0'),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_orig_company_address_unit_desig(SALT39.StrType s0) := FUNCTION
  s1 := SALT39.stringfilter(s0,'ACDEGIMNOPRSTUY_ '); // Only allow valid symbols
  s2 := SALT39.stringcleanspaces( SALT39.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_orig_company_address_unit_desig(SALT39.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT39.StringFilter(s,'ACDEGIMNOPRSTUY_ '))),~(LENGTH(TRIM(s)) = 0),~(SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 0));
EXPORT InValidMessageFT_orig_company_address_unit_desig(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.NotLeft,SALT39.HygieneErrors.NotInChars('ACDEGIMNOPRSTUY_ '),SALT39.HygieneErrors.NotLength('0'),SALT39.HygieneErrors.NotWords('0'),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_orig_company_address_sec_range(SALT39.StrType s0) := FUNCTION
  s1 := SALT39.stringfilter(s0,'ACDEGMNOPRSY_ '); // Only allow valid symbols
  s2 := SALT39.stringcleanspaces( SALT39.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_orig_company_address_sec_range(SALT39.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT39.StringFilter(s,'ACDEGMNOPRSY_ '))),~(LENGTH(TRIM(s)) = 0),~(SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 0));
EXPORT InValidMessageFT_orig_company_address_sec_range(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.NotLeft,SALT39.HygieneErrors.NotInChars('ACDEGMNOPRSY_ '),SALT39.HygieneErrors.NotLength('0'),SALT39.HygieneErrors.NotWords('0'),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_orig_company_address_city(SALT39.StrType s0) := FUNCTION
  s1 := SALT39.stringfilter(s0,'ACDEIMNOPRSTY_ '); // Only allow valid symbols
  s2 := SALT39.stringcleanspaces( SALT39.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_orig_company_address_city(SALT39.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT39.StringFilter(s,'ACDEIMNOPRSTY_ '))),~(LENGTH(TRIM(s)) = 0),~(SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 0));
EXPORT InValidMessageFT_orig_company_address_city(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.NotLeft,SALT39.HygieneErrors.NotInChars('ACDEIMNOPRSTY_ '),SALT39.HygieneErrors.NotLength('0'),SALT39.HygieneErrors.NotWords('0'),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_orig_company_address_st(SALT39.StrType s0) := FUNCTION
  s1 := SALT39.stringfilter(s0,'ACDEMNOPRSTY_ '); // Only allow valid symbols
  s2 := SALT39.stringcleanspaces( SALT39.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_orig_company_address_st(SALT39.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT39.StringFilter(s,'ACDEMNOPRSTY_ '))),~(LENGTH(TRIM(s)) = 0),~(SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 0));
EXPORT InValidMessageFT_orig_company_address_st(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.NotLeft,SALT39.HygieneErrors.NotInChars('ACDEMNOPRSTY_ '),SALT39.HygieneErrors.NotLength('0'),SALT39.HygieneErrors.NotWords('0'),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_orig_company_address_zip5(SALT39.StrType s0) := FUNCTION
  s1 := SALT39.stringfilter(s0,'5ACDEIMNOPRSYZ_ '); // Only allow valid symbols
  s2 := SALT39.stringcleanspaces( SALT39.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_orig_company_address_zip5(SALT39.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT39.StringFilter(s,'5ACDEIMNOPRSYZ_ '))),~(LENGTH(TRIM(s)) = 0),~(SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 0));
EXPORT InValidMessageFT_orig_company_address_zip5(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.NotLeft,SALT39.HygieneErrors.NotInChars('5ACDEIMNOPRSYZ_ '),SALT39.HygieneErrors.NotLength('0'),SALT39.HygieneErrors.NotWords('0'),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_orig_company_address_zip4(SALT39.StrType s0) := FUNCTION
  s1 := SALT39.stringfilter(s0,'4ACDEIMNOPRSYZ_ '); // Only allow valid symbols
  s2 := SALT39.stringcleanspaces( SALT39.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_orig_company_address_zip4(SALT39.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT39.StringFilter(s,'4ACDEIMNOPRSYZ_ '))),~(LENGTH(TRIM(s)) = 0),~(SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 0));
EXPORT InValidMessageFT_orig_company_address_zip4(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.NotLeft,SALT39.HygieneErrors.NotInChars('4ACDEIMNOPRSYZ_ '),SALT39.HygieneErrors.NotLength('0'),SALT39.HygieneErrors.NotWords('0'),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_orig_company_fax_number(SALT39.StrType s0) := FUNCTION
  s1 := SALT39.stringfilter(s0,'ABCEFMNOPRUXY_ '); // Only allow valid symbols
  s2 := SALT39.stringcleanspaces( SALT39.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_orig_company_fax_number(SALT39.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT39.StringFilter(s,'ABCEFMNOPRUXY_ '))),~(LENGTH(TRIM(s)) = 0),~(SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 0));
EXPORT InValidMessageFT_orig_company_fax_number(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.NotLeft,SALT39.HygieneErrors.NotInChars('ABCEFMNOPRUXY_ '),SALT39.HygieneErrors.NotLength('0'),SALT39.HygieneErrors.NotWords('0'),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_orig_company_start_date(SALT39.StrType s0) := FUNCTION
  s1 := SALT39.stringfilter(s0,'ACDEMNOPRSTY_ '); // Only allow valid symbols
  s2 := SALT39.stringcleanspaces( SALT39.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_orig_company_start_date(SALT39.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT39.StringFilter(s,'ACDEMNOPRSTY_ '))),~(LENGTH(TRIM(s)) = 0),~(SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 0));
EXPORT InValidMessageFT_orig_company_start_date(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.NotLeft,SALT39.HygieneErrors.NotInChars('ACDEMNOPRSTY_ '),SALT39.HygieneErrors.NotLength('0'),SALT39.HygieneErrors.NotWords('0'),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_orig_company_years_in_business(SALT39.StrType s0) := FUNCTION
  s1 := SALT39.stringfilter(s0,'ABCEIMNOPRSUY_ '); // Only allow valid symbols
  s2 := SALT39.stringcleanspaces( SALT39.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_orig_company_years_in_business(SALT39.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT39.StringFilter(s,'ABCEIMNOPRSUY_ '))),~(LENGTH(TRIM(s)) = 0),~(SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 0));
EXPORT InValidMessageFT_orig_company_years_in_business(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.NotLeft,SALT39.HygieneErrors.NotInChars('ABCEIMNOPRSUY_ '),SALT39.HygieneErrors.NotLength('0'),SALT39.HygieneErrors.NotWords('0'),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_orig_company_sic_code(SALT39.StrType s0) := FUNCTION
  s1 := SALT39.stringfilter(s0,'ACDEIMNOPSY_ '); // Only allow valid symbols
  s2 := SALT39.stringcleanspaces( SALT39.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_orig_company_sic_code(SALT39.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT39.StringFilter(s,'ACDEIMNOPSY_ '))),~(LENGTH(TRIM(s)) = 0),~(SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 0));
EXPORT InValidMessageFT_orig_company_sic_code(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.NotLeft,SALT39.HygieneErrors.NotInChars('ACDEIMNOPSY_ '),SALT39.HygieneErrors.NotLength('0'),SALT39.HygieneErrors.NotWords('0'),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_orig_company_naic_code(SALT39.StrType s0) := FUNCTION
  s1 := SALT39.stringfilter(s0,'ACDEIMNOPY_ '); // Only allow valid symbols
  s2 := SALT39.stringcleanspaces( SALT39.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_orig_company_naic_code(SALT39.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT39.StringFilter(s,'ACDEIMNOPY_ '))),~(LENGTH(TRIM(s)) = 0),~(SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 0));
EXPORT InValidMessageFT_orig_company_naic_code(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.NotLeft,SALT39.HygieneErrors.NotInChars('ACDEIMNOPY_ '),SALT39.HygieneErrors.NotLength('0'),SALT39.HygieneErrors.NotWords('0'),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_orig_company_structure(SALT39.StrType s0) := FUNCTION
  s1 := SALT39.stringfilter(s0,'ACEMNOPRSTUY_ '); // Only allow valid symbols
  s2 := SALT39.stringcleanspaces( SALT39.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_orig_company_structure(SALT39.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT39.StringFilter(s,'ACEMNOPRSTUY_ '))),~(LENGTH(TRIM(s)) = 0),~(SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 0));
EXPORT InValidMessageFT_orig_company_structure(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.NotLeft,SALT39.HygieneErrors.NotInChars('ACEMNOPRSTUY_ '),SALT39.HygieneErrors.NotLength('0'),SALT39.HygieneErrors.NotWords('0'),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_orig_company_yearly_revenue(SALT39.StrType s0) := FUNCTION
  s1 := SALT39.stringfilter(s0,'ACELMNOPRUVY_ '); // Only allow valid symbols
  s2 := SALT39.stringcleanspaces( SALT39.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_orig_company_yearly_revenue(SALT39.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT39.StringFilter(s,'ACELMNOPRUVY_ '))),~(LENGTH(TRIM(s)) = 0),~(SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 0));
EXPORT InValidMessageFT_orig_company_yearly_revenue(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.NotLeft,SALT39.HygieneErrors.NotInChars('ACELMNOPRUVY_ '),SALT39.HygieneErrors.NotLength('0'),SALT39.HygieneErrors.NotWords('0'),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_orig_subj2_first_name(SALT39.StrType s0) := FUNCTION
  s1 := SALT39.stringfilter(s0,'2ABEFIJMNRSTU_ '); // Only allow valid symbols
  s2 := SALT39.stringcleanspaces( SALT39.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_orig_subj2_first_name(SALT39.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT39.StringFilter(s,'2ABEFIJMNRSTU_ '))),~(LENGTH(TRIM(s)) = 0),~(SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 0));
EXPORT InValidMessageFT_orig_subj2_first_name(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.NotLeft,SALT39.HygieneErrors.NotInChars('2ABEFIJMNRSTU_ '),SALT39.HygieneErrors.NotLength('0'),SALT39.HygieneErrors.NotWords('0'),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_orig_subj2_middle_name(SALT39.StrType s0) := FUNCTION
  s1 := SALT39.stringfilter(s0,'2ABDEIJLMNSU_ '); // Only allow valid symbols
  s2 := SALT39.stringcleanspaces( SALT39.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_orig_subj2_middle_name(SALT39.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT39.StringFilter(s,'2ABDEIJLMNSU_ '))),~(LENGTH(TRIM(s)) = 0),~(SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 0));
EXPORT InValidMessageFT_orig_subj2_middle_name(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.NotLeft,SALT39.HygieneErrors.NotInChars('2ABDEIJLMNSU_ '),SALT39.HygieneErrors.NotLength('0'),SALT39.HygieneErrors.NotWords('0'),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_orig_subj2_last_name(SALT39.StrType s0) := FUNCTION
  s1 := SALT39.stringfilter(s0,'2ABEJLMNSTU_ '); // Only allow valid symbols
  s2 := SALT39.stringcleanspaces( SALT39.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_orig_subj2_last_name(SALT39.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT39.StringFilter(s,'2ABEJLMNSTU_ '))),~(LENGTH(TRIM(s)) = 0),~(SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 0));
EXPORT InValidMessageFT_orig_subj2_last_name(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.NotLeft,SALT39.HygieneErrors.NotInChars('2ABEJLMNSTU_ '),SALT39.HygieneErrors.NotLength('0'),SALT39.HygieneErrors.NotWords('0'),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_orig_subj2_suffix_name(SALT39.StrType s0) := FUNCTION
  s1 := SALT39.stringfilter(s0,'2ABEFIJMNSUX_ '); // Only allow valid symbols
  s2 := SALT39.stringcleanspaces( SALT39.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_orig_subj2_suffix_name(SALT39.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT39.StringFilter(s,'2ABEFIJMNSUX_ '))),~(LENGTH(TRIM(s)) = 0),~(SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 0));
EXPORT InValidMessageFT_orig_subj2_suffix_name(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.NotLeft,SALT39.HygieneErrors.NotInChars('2ABEFIJMNSUX_ '),SALT39.HygieneErrors.NotLength('0'),SALT39.HygieneErrors.NotWords('0'),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_orig_subj2_full_name(SALT39.StrType s0) := FUNCTION
  s1 := SALT39.stringfilter(s0,'2ABEFJLMNSU_ '); // Only allow valid symbols
  s2 := SALT39.stringcleanspaces( SALT39.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_orig_subj2_full_name(SALT39.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT39.StringFilter(s,'2ABEFJLMNSU_ '))),~(LENGTH(TRIM(s)) = 0),~(SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 0));
EXPORT InValidMessageFT_orig_subj2_full_name(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.NotLeft,SALT39.HygieneErrors.NotInChars('2ABEFJLMNSU_ '),SALT39.HygieneErrors.NotLength('0'),SALT39.HygieneErrors.NotWords('0'),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_orig_subj2_ssn(SALT39.StrType s0) := FUNCTION
  s1 := SALT39.stringfilter(s0,'2BJNSU_ '); // Only allow valid symbols
  s2 := SALT39.stringcleanspaces( SALT39.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_orig_subj2_ssn(SALT39.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT39.StringFilter(s,'2BJNSU_ '))),~(LENGTH(TRIM(s)) = 0),~(SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 0));
EXPORT InValidMessageFT_orig_subj2_ssn(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.NotLeft,SALT39.HygieneErrors.NotInChars('2BJNSU_ '),SALT39.HygieneErrors.NotLength('0'),SALT39.HygieneErrors.NotWords('0'),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_orig_subj2_dob(SALT39.StrType s0) := FUNCTION
  s1 := SALT39.stringfilter(s0,'2BDJOSU_ '); // Only allow valid symbols
  s2 := SALT39.stringcleanspaces( SALT39.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_orig_subj2_dob(SALT39.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT39.StringFilter(s,'2BDJOSU_ '))),~(LENGTH(TRIM(s)) = 0),~(SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 0));
EXPORT InValidMessageFT_orig_subj2_dob(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.NotLeft,SALT39.HygieneErrors.NotInChars('2BDJOSU_ '),SALT39.HygieneErrors.NotLength('0'),SALT39.HygieneErrors.NotWords('0'),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_orig_subj2_dl_num(SALT39.StrType s0) := FUNCTION
  s1 := SALT39.stringfilter(s0,'2BDJLMNSU_ '); // Only allow valid symbols
  s2 := SALT39.stringcleanspaces( SALT39.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_orig_subj2_dl_num(SALT39.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT39.StringFilter(s,'2BDJLMNSU_ '))),~(LENGTH(TRIM(s)) = 0),~(SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 0));
EXPORT InValidMessageFT_orig_subj2_dl_num(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.NotLeft,SALT39.HygieneErrors.NotInChars('2BDJLMNSU_ '),SALT39.HygieneErrors.NotLength('0'),SALT39.HygieneErrors.NotWords('0'),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_orig_subj2_dl_state(SALT39.StrType s0) := FUNCTION
  s1 := SALT39.stringfilter(s0,'2ABDEJLSTU_ '); // Only allow valid symbols
  s2 := SALT39.stringcleanspaces( SALT39.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_orig_subj2_dl_state(SALT39.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT39.StringFilter(s,'2ABDEJLSTU_ '))),~(LENGTH(TRIM(s)) = 0),~(SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 0));
EXPORT InValidMessageFT_orig_subj2_dl_state(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.NotLeft,SALT39.HygieneErrors.NotInChars('2ABDEJLSTU_ '),SALT39.HygieneErrors.NotLength('0'),SALT39.HygieneErrors.NotWords('0'),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_orig_subj2_former_last_name(SALT39.StrType s0) := FUNCTION
  s1 := SALT39.stringfilter(s0,'2ABEFJLMNORSTU_ '); // Only allow valid symbols
  s2 := SALT39.stringcleanspaces( SALT39.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_orig_subj2_former_last_name(SALT39.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT39.StringFilter(s,'2ABEFJLMNORSTU_ '))),~(LENGTH(TRIM(s)) = 0),~(SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 0));
EXPORT InValidMessageFT_orig_subj2_former_last_name(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.NotLeft,SALT39.HygieneErrors.NotInChars('2ABEFJLMNORSTU_ '),SALT39.HygieneErrors.NotLength('0'),SALT39.HygieneErrors.NotWords('0'),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_orig_subj2_address_addressline1(SALT39.StrType s0) := FUNCTION
  s1 := SALT39.stringfilter(s0,'12ABDEIJLNRSU_ '); // Only allow valid symbols
  s2 := SALT39.stringcleanspaces( SALT39.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_orig_subj2_address_addressline1(SALT39.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT39.StringFilter(s,'12ABDEIJLNRSU_ '))),~(LENGTH(TRIM(s)) = 0),~(SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 0));
EXPORT InValidMessageFT_orig_subj2_address_addressline1(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.NotLeft,SALT39.HygieneErrors.NotInChars('12ABDEIJLNRSU_ '),SALT39.HygieneErrors.NotLength('0'),SALT39.HygieneErrors.NotWords('0'),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_orig_subj2_address_addressline2(SALT39.StrType s0) := FUNCTION
  s1 := SALT39.stringfilter(s0,'2ABDEIJLNRSU_ '); // Only allow valid symbols
  s2 := SALT39.stringcleanspaces( SALT39.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_orig_subj2_address_addressline2(SALT39.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT39.StringFilter(s,'2ABDEIJLNRSU_ '))),~(LENGTH(TRIM(s)) = 0),~(SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 0));
EXPORT InValidMessageFT_orig_subj2_address_addressline2(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.NotLeft,SALT39.HygieneErrors.NotInChars('2ABDEIJLNRSU_ '),SALT39.HygieneErrors.NotLength('0'),SALT39.HygieneErrors.NotWords('0'),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_orig_subj2_address_prim_range(SALT39.StrType s0) := FUNCTION
  s1 := SALT39.stringfilter(s0,'2ABDEGIJMNPRSU_ '); // Only allow valid symbols
  s2 := SALT39.stringcleanspaces( SALT39.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_orig_subj2_address_prim_range(SALT39.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT39.StringFilter(s,'2ABDEGIJMNPRSU_ '))),~(LENGTH(TRIM(s)) = 0),~(SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 0));
EXPORT InValidMessageFT_orig_subj2_address_prim_range(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.NotLeft,SALT39.HygieneErrors.NotInChars('2ABDEGIJMNPRSU_ '),SALT39.HygieneErrors.NotLength('0'),SALT39.HygieneErrors.NotWords('0'),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_orig_subj2_address_predir(SALT39.StrType s0) := FUNCTION
  s1 := SALT39.stringfilter(s0,'2ABDEIJPRSU_ '); // Only allow valid symbols
  s2 := SALT39.stringcleanspaces( SALT39.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_orig_subj2_address_predir(SALT39.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT39.StringFilter(s,'2ABDEIJPRSU_ '))),~(LENGTH(TRIM(s)) = 0),~(SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 0));
EXPORT InValidMessageFT_orig_subj2_address_predir(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.NotLeft,SALT39.HygieneErrors.NotInChars('2ABDEIJPRSU_ '),SALT39.HygieneErrors.NotLength('0'),SALT39.HygieneErrors.NotWords('0'),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_orig_subj2_address_prim_name(SALT39.StrType s0) := FUNCTION
  s1 := SALT39.stringfilter(s0,'2ABDEIJMNPRSU_ '); // Only allow valid symbols
  s2 := SALT39.stringcleanspaces( SALT39.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_orig_subj2_address_prim_name(SALT39.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT39.StringFilter(s,'2ABDEIJMNPRSU_ '))),~(LENGTH(TRIM(s)) = 0),~(SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 0));
EXPORT InValidMessageFT_orig_subj2_address_prim_name(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.NotLeft,SALT39.HygieneErrors.NotInChars('2ABDEIJMNPRSU_ '),SALT39.HygieneErrors.NotLength('0'),SALT39.HygieneErrors.NotWords('0'),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_orig_subj2_address_suffix(SALT39.StrType s0) := FUNCTION
  s1 := SALT39.stringfilter(s0,'2ABDEFIJRSUX_ '); // Only allow valid symbols
  s2 := SALT39.stringcleanspaces( SALT39.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_orig_subj2_address_suffix(SALT39.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT39.StringFilter(s,'2ABDEFIJRSUX_ '))),~(LENGTH(TRIM(s)) = 0),~(SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 0));
EXPORT InValidMessageFT_orig_subj2_address_suffix(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.NotLeft,SALT39.HygieneErrors.NotInChars('2ABDEFIJRSUX_ '),SALT39.HygieneErrors.NotLength('0'),SALT39.HygieneErrors.NotWords('0'),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_orig_subj2_address_postdir(SALT39.StrType s0) := FUNCTION
  s1 := SALT39.stringfilter(s0,'2ABDEIJOPRSTU_ '); // Only allow valid symbols
  s2 := SALT39.stringcleanspaces( SALT39.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_orig_subj2_address_postdir(SALT39.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT39.StringFilter(s,'2ABDEIJOPRSTU_ '))),~(LENGTH(TRIM(s)) = 0),~(SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 0));
EXPORT InValidMessageFT_orig_subj2_address_postdir(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.NotLeft,SALT39.HygieneErrors.NotInChars('2ABDEIJOPRSTU_ '),SALT39.HygieneErrors.NotLength('0'),SALT39.HygieneErrors.NotWords('0'),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_orig_subj2_address_unit_desig(SALT39.StrType s0) := FUNCTION
  s1 := SALT39.stringfilter(s0,'2ABDEGIJNRSTU_ '); // Only allow valid symbols
  s2 := SALT39.stringcleanspaces( SALT39.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_orig_subj2_address_unit_desig(SALT39.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT39.StringFilter(s,'2ABDEGIJNRSTU_ '))),~(LENGTH(TRIM(s)) = 0),~(SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 0));
EXPORT InValidMessageFT_orig_subj2_address_unit_desig(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.NotLeft,SALT39.HygieneErrors.NotInChars('2ABDEGIJNRSTU_ '),SALT39.HygieneErrors.NotLength('0'),SALT39.HygieneErrors.NotWords('0'),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_orig_subj2_address_sec_range(SALT39.StrType s0) := FUNCTION
  s1 := SALT39.stringfilter(s0,'2ABCDEGJNRSU_ '); // Only allow valid symbols
  s2 := SALT39.stringcleanspaces( SALT39.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_orig_subj2_address_sec_range(SALT39.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT39.StringFilter(s,'2ABCDEGJNRSU_ '))),~(LENGTH(TRIM(s)) = 0),~(SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 0));
EXPORT InValidMessageFT_orig_subj2_address_sec_range(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.NotLeft,SALT39.HygieneErrors.NotInChars('2ABCDEGJNRSU_ '),SALT39.HygieneErrors.NotLength('0'),SALT39.HygieneErrors.NotWords('0'),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_orig_subj2_address_city(SALT39.StrType s0) := FUNCTION
  s1 := SALT39.stringfilter(s0,'2ABCDEIJRSTUY_aelnos '); // Only allow valid symbols
  s2 := SALT39.stringcleanspaces( SALT39.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_orig_subj2_address_city(SALT39.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT39.StringFilter(s,'2ABCDEIJRSTUY_aelnos '))),~(LENGTH(TRIM(s)) = 0),~(SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 0));
EXPORT InValidMessageFT_orig_subj2_address_city(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.NotLeft,SALT39.HygieneErrors.NotInChars('2ABCDEIJRSTUY_aelnos '),SALT39.HygieneErrors.NotLength('0'),SALT39.HygieneErrors.NotWords('0'),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_orig_subj2_address_st(SALT39.StrType s0) := FUNCTION
  s1 := SALT39.stringfilter(s0,'2ABDEJRSTU_ '); // Only allow valid symbols
  s2 := SALT39.stringcleanspaces( SALT39.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_orig_subj2_address_st(SALT39.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT39.StringFilter(s,'2ABDEJRSTU_ '))),~(LENGTH(TRIM(s)) = 0),~(SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 0));
EXPORT InValidMessageFT_orig_subj2_address_st(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.NotLeft,SALT39.HygieneErrors.NotInChars('2ABDEJRSTU_ '),SALT39.HygieneErrors.NotLength('0'),SALT39.HygieneErrors.NotWords('0'),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_orig_subj2_address_z5(SALT39.StrType s0) := FUNCTION
  s1 := SALT39.stringfilter(s0,'025ABDEJRSUZ_ '); // Only allow valid symbols
  s2 := SALT39.stringcleanspaces( SALT39.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_orig_subj2_address_z5(SALT39.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT39.StringFilter(s,'025ABDEJRSUZ_ '))),~(LENGTH(TRIM(s)) = 0),~(SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 0));
EXPORT InValidMessageFT_orig_subj2_address_z5(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.NotLeft,SALT39.HygieneErrors.NotInChars('025ABDEJRSUZ_ '),SALT39.HygieneErrors.NotLength('0'),SALT39.HygieneErrors.NotWords('0'),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_orig_subj2_address_z4(SALT39.StrType s0) := FUNCTION
  s1 := SALT39.stringfilter(s0,'24ABDEJRSUZ_ '); // Only allow valid symbols
  s2 := SALT39.stringcleanspaces( SALT39.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_orig_subj2_address_z4(SALT39.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT39.StringFilter(s,'24ABDEJRSUZ_ '))),~(LENGTH(TRIM(s)) = 0),~(SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 0));
EXPORT InValidMessageFT_orig_subj2_address_z4(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.NotLeft,SALT39.HygieneErrors.NotInChars('24ABDEJRSUZ_ '),SALT39.HygieneErrors.NotLength('0'),SALT39.HygieneErrors.NotWords('0'),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_orig_subj2_phone(SALT39.StrType s0) := FUNCTION
  s1 := SALT39.stringfilter(s0,'2BEHJNOPSU_ '); // Only allow valid symbols
  s2 := SALT39.stringcleanspaces( SALT39.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_orig_subj2_phone(SALT39.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT39.StringFilter(s,'2BEHJNOPSU_ '))),~(LENGTH(TRIM(s)) = 0),~(SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 0));
EXPORT InValidMessageFT_orig_subj2_phone(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.NotLeft,SALT39.HygieneErrors.NotInChars('2BEHJNOPSU_ '),SALT39.HygieneErrors.NotLength('0'),SALT39.HygieneErrors.NotWords('0'),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_orig_subj2_work_phone(SALT39.StrType s0) := FUNCTION
  s1 := SALT39.stringfilter(s0,'2BEHJKNOPRSUW_ '); // Only allow valid symbols
  s2 := SALT39.stringcleanspaces( SALT39.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_orig_subj2_work_phone(SALT39.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT39.StringFilter(s,'2BEHJKNOPRSUW_ '))),~(LENGTH(TRIM(s)) = 0),~(SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 0));
EXPORT InValidMessageFT_orig_subj2_work_phone(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.NotLeft,SALT39.HygieneErrors.NotInChars('2BEHJKNOPRSUW_ '),SALT39.HygieneErrors.NotLength('0'),SALT39.HygieneErrors.NotWords('0'),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_orig_subj2_business_title(SALT39.StrType s0) := FUNCTION
  s1 := SALT39.stringfilter(s0,'2BEIJLNSTU_ '); // Only allow valid symbols
  s2 := SALT39.stringcleanspaces( SALT39.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_orig_subj2_business_title(SALT39.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT39.StringFilter(s,'2BEIJLNSTU_ '))),~(LENGTH(TRIM(s)) = 0),~(SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 0));
EXPORT InValidMessageFT_orig_subj2_business_title(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.NotLeft,SALT39.HygieneErrors.NotInChars('2BEIJLNSTU_ '),SALT39.HygieneErrors.NotLength('0'),SALT39.HygieneErrors.NotWords('0'),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_orig_subj3_first_name(SALT39.StrType s0) := FUNCTION
  s1 := SALT39.stringfilter(s0,'3ABEFIJMNRSTU_ '); // Only allow valid symbols
  s2 := SALT39.stringcleanspaces( SALT39.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_orig_subj3_first_name(SALT39.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT39.StringFilter(s,'3ABEFIJMNRSTU_ '))),~(LENGTH(TRIM(s)) = 0),~(SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 0));
EXPORT InValidMessageFT_orig_subj3_first_name(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.NotLeft,SALT39.HygieneErrors.NotInChars('3ABEFIJMNRSTU_ '),SALT39.HygieneErrors.NotLength('0'),SALT39.HygieneErrors.NotWords('0'),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_orig_subj3_middle_name(SALT39.StrType s0) := FUNCTION
  s1 := SALT39.stringfilter(s0,'3ABDEIJLMNSU_ '); // Only allow valid symbols
  s2 := SALT39.stringcleanspaces( SALT39.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_orig_subj3_middle_name(SALT39.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT39.StringFilter(s,'3ABDEIJLMNSU_ '))),~(LENGTH(TRIM(s)) = 0),~(SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 0));
EXPORT InValidMessageFT_orig_subj3_middle_name(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.NotLeft,SALT39.HygieneErrors.NotInChars('3ABDEIJLMNSU_ '),SALT39.HygieneErrors.NotLength('0'),SALT39.HygieneErrors.NotWords('0'),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_orig_subj3_last_name(SALT39.StrType s0) := FUNCTION
  s1 := SALT39.stringfilter(s0,'3ABEJLMNSTU_ '); // Only allow valid symbols
  s2 := SALT39.stringcleanspaces( SALT39.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_orig_subj3_last_name(SALT39.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT39.StringFilter(s,'3ABEJLMNSTU_ '))),~(LENGTH(TRIM(s)) = 0),~(SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 0));
EXPORT InValidMessageFT_orig_subj3_last_name(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.NotLeft,SALT39.HygieneErrors.NotInChars('3ABEJLMNSTU_ '),SALT39.HygieneErrors.NotLength('0'),SALT39.HygieneErrors.NotWords('0'),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_orig_subj3_suffix_name(SALT39.StrType s0) := FUNCTION
  s1 := SALT39.stringfilter(s0,'3ABEFIJMNSUX_ '); // Only allow valid symbols
  s2 := SALT39.stringcleanspaces( SALT39.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_orig_subj3_suffix_name(SALT39.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT39.StringFilter(s,'3ABEFIJMNSUX_ '))),~(LENGTH(TRIM(s)) = 0),~(SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 0));
EXPORT InValidMessageFT_orig_subj3_suffix_name(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.NotLeft,SALT39.HygieneErrors.NotInChars('3ABEFIJMNSUX_ '),SALT39.HygieneErrors.NotLength('0'),SALT39.HygieneErrors.NotWords('0'),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_orig_subj3_full_name(SALT39.StrType s0) := FUNCTION
  s1 := SALT39.stringfilter(s0,'3ABEFJLMNSU_ '); // Only allow valid symbols
  s2 := SALT39.stringcleanspaces( SALT39.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_orig_subj3_full_name(SALT39.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT39.StringFilter(s,'3ABEFJLMNSU_ '))),~(LENGTH(TRIM(s)) = 0),~(SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 0));
EXPORT InValidMessageFT_orig_subj3_full_name(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.NotLeft,SALT39.HygieneErrors.NotInChars('3ABEFJLMNSU_ '),SALT39.HygieneErrors.NotLength('0'),SALT39.HygieneErrors.NotWords('0'),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_orig_subj3_ssn(SALT39.StrType s0) := FUNCTION
  s1 := SALT39.stringfilter(s0,'3BJNSU_ '); // Only allow valid symbols
  s2 := SALT39.stringcleanspaces( SALT39.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_orig_subj3_ssn(SALT39.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT39.StringFilter(s,'3BJNSU_ '))),~(LENGTH(TRIM(s)) = 0),~(SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 0));
EXPORT InValidMessageFT_orig_subj3_ssn(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.NotLeft,SALT39.HygieneErrors.NotInChars('3BJNSU_ '),SALT39.HygieneErrors.NotLength('0'),SALT39.HygieneErrors.NotWords('0'),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_orig_subj3_dob(SALT39.StrType s0) := FUNCTION
  s1 := SALT39.stringfilter(s0,'3BDJOSU_ '); // Only allow valid symbols
  s2 := SALT39.stringcleanspaces( SALT39.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_orig_subj3_dob(SALT39.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT39.StringFilter(s,'3BDJOSU_ '))),~(LENGTH(TRIM(s)) = 0),~(SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 0));
EXPORT InValidMessageFT_orig_subj3_dob(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.NotLeft,SALT39.HygieneErrors.NotInChars('3BDJOSU_ '),SALT39.HygieneErrors.NotLength('0'),SALT39.HygieneErrors.NotWords('0'),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_orig_subj3_dl_num(SALT39.StrType s0) := FUNCTION
  s1 := SALT39.stringfilter(s0,'3BDJLMNSU_ '); // Only allow valid symbols
  s2 := SALT39.stringcleanspaces( SALT39.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_orig_subj3_dl_num(SALT39.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT39.StringFilter(s,'3BDJLMNSU_ '))),~(LENGTH(TRIM(s)) = 0),~(SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 0));
EXPORT InValidMessageFT_orig_subj3_dl_num(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.NotLeft,SALT39.HygieneErrors.NotInChars('3BDJLMNSU_ '),SALT39.HygieneErrors.NotLength('0'),SALT39.HygieneErrors.NotWords('0'),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_orig_subj3_dl_state(SALT39.StrType s0) := FUNCTION
  s1 := SALT39.stringfilter(s0,'3ABDEJLSTU_ '); // Only allow valid symbols
  s2 := SALT39.stringcleanspaces( SALT39.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_orig_subj3_dl_state(SALT39.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT39.StringFilter(s,'3ABDEJLSTU_ '))),~(LENGTH(TRIM(s)) = 0),~(SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 0));
EXPORT InValidMessageFT_orig_subj3_dl_state(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.NotLeft,SALT39.HygieneErrors.NotInChars('3ABDEJLSTU_ '),SALT39.HygieneErrors.NotLength('0'),SALT39.HygieneErrors.NotWords('0'),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_orig_subj3_former_last_name(SALT39.StrType s0) := FUNCTION
  s1 := SALT39.stringfilter(s0,'3ABEFJLMNORSTU_ '); // Only allow valid symbols
  s2 := SALT39.stringcleanspaces( SALT39.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_orig_subj3_former_last_name(SALT39.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT39.StringFilter(s,'3ABEFJLMNORSTU_ '))),~(LENGTH(TRIM(s)) = 0),~(SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 0));
EXPORT InValidMessageFT_orig_subj3_former_last_name(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.NotLeft,SALT39.HygieneErrors.NotInChars('3ABEFJLMNORSTU_ '),SALT39.HygieneErrors.NotLength('0'),SALT39.HygieneErrors.NotWords('0'),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_orig_subj3_address_addressline1(SALT39.StrType s0) := FUNCTION
  s1 := SALT39.stringfilter(s0,'13ABDEIJLNRSU_ '); // Only allow valid symbols
  s2 := SALT39.stringcleanspaces( SALT39.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_orig_subj3_address_addressline1(SALT39.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT39.StringFilter(s,'13ABDEIJLNRSU_ '))),~(LENGTH(TRIM(s)) = 0),~(SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 0));
EXPORT InValidMessageFT_orig_subj3_address_addressline1(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.NotLeft,SALT39.HygieneErrors.NotInChars('13ABDEIJLNRSU_ '),SALT39.HygieneErrors.NotLength('0'),SALT39.HygieneErrors.NotWords('0'),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_orig_subj3_address_addressline2(SALT39.StrType s0) := FUNCTION
  s1 := SALT39.stringfilter(s0,'23ABDEIJLNRSU_ '); // Only allow valid symbols
  s2 := SALT39.stringcleanspaces( SALT39.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_orig_subj3_address_addressline2(SALT39.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT39.StringFilter(s,'23ABDEIJLNRSU_ '))),~(LENGTH(TRIM(s)) = 0),~(SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 0));
EXPORT InValidMessageFT_orig_subj3_address_addressline2(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.NotLeft,SALT39.HygieneErrors.NotInChars('23ABDEIJLNRSU_ '),SALT39.HygieneErrors.NotLength('0'),SALT39.HygieneErrors.NotWords('0'),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_orig_subj3_address_prim_range(SALT39.StrType s0) := FUNCTION
  s1 := SALT39.stringfilter(s0,'3ABDEGIJMNPRSU_ '); // Only allow valid symbols
  s2 := SALT39.stringcleanspaces( SALT39.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_orig_subj3_address_prim_range(SALT39.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT39.StringFilter(s,'3ABDEGIJMNPRSU_ '))),~(LENGTH(TRIM(s)) = 0),~(SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 0));
EXPORT InValidMessageFT_orig_subj3_address_prim_range(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.NotLeft,SALT39.HygieneErrors.NotInChars('3ABDEGIJMNPRSU_ '),SALT39.HygieneErrors.NotLength('0'),SALT39.HygieneErrors.NotWords('0'),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_orig_subj3_address_predir(SALT39.StrType s0) := FUNCTION
  s1 := SALT39.stringfilter(s0,'3ABDEIJPRSU_ '); // Only allow valid symbols
  s2 := SALT39.stringcleanspaces( SALT39.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_orig_subj3_address_predir(SALT39.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT39.StringFilter(s,'3ABDEIJPRSU_ '))),~(LENGTH(TRIM(s)) = 0),~(SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 0));
EXPORT InValidMessageFT_orig_subj3_address_predir(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.NotLeft,SALT39.HygieneErrors.NotInChars('3ABDEIJPRSU_ '),SALT39.HygieneErrors.NotLength('0'),SALT39.HygieneErrors.NotWords('0'),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_orig_subj3_address_prim_name(SALT39.StrType s0) := FUNCTION
  s1 := SALT39.stringfilter(s0,'3ABDEIJMNPRSU_ '); // Only allow valid symbols
  s2 := SALT39.stringcleanspaces( SALT39.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_orig_subj3_address_prim_name(SALT39.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT39.StringFilter(s,'3ABDEIJMNPRSU_ '))),~(LENGTH(TRIM(s)) = 0),~(SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 0));
EXPORT InValidMessageFT_orig_subj3_address_prim_name(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.NotLeft,SALT39.HygieneErrors.NotInChars('3ABDEIJMNPRSU_ '),SALT39.HygieneErrors.NotLength('0'),SALT39.HygieneErrors.NotWords('0'),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_orig_subj3_address_suffix(SALT39.StrType s0) := FUNCTION
  s1 := SALT39.stringfilter(s0,'3ABDEFIJRSUX_ '); // Only allow valid symbols
  s2 := SALT39.stringcleanspaces( SALT39.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_orig_subj3_address_suffix(SALT39.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT39.StringFilter(s,'3ABDEFIJRSUX_ '))),~(LENGTH(TRIM(s)) = 0),~(SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 0));
EXPORT InValidMessageFT_orig_subj3_address_suffix(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.NotLeft,SALT39.HygieneErrors.NotInChars('3ABDEFIJRSUX_ '),SALT39.HygieneErrors.NotLength('0'),SALT39.HygieneErrors.NotWords('0'),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_orig_subj3_address_postdir(SALT39.StrType s0) := FUNCTION
  s1 := SALT39.stringfilter(s0,'3ABDEIJOPRSTU_ '); // Only allow valid symbols
  s2 := SALT39.stringcleanspaces( SALT39.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_orig_subj3_address_postdir(SALT39.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT39.StringFilter(s,'3ABDEIJOPRSTU_ '))),~(LENGTH(TRIM(s)) = 0),~(SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 0));
EXPORT InValidMessageFT_orig_subj3_address_postdir(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.NotLeft,SALT39.HygieneErrors.NotInChars('3ABDEIJOPRSTU_ '),SALT39.HygieneErrors.NotLength('0'),SALT39.HygieneErrors.NotWords('0'),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_orig_subj3_address_unit_desig(SALT39.StrType s0) := FUNCTION
  s1 := SALT39.stringfilter(s0,'3ABDEGIJNRSTU_ '); // Only allow valid symbols
  s2 := SALT39.stringcleanspaces( SALT39.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_orig_subj3_address_unit_desig(SALT39.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT39.StringFilter(s,'3ABDEGIJNRSTU_ '))),~(LENGTH(TRIM(s)) = 0),~(SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 0));
EXPORT InValidMessageFT_orig_subj3_address_unit_desig(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.NotLeft,SALT39.HygieneErrors.NotInChars('3ABDEGIJNRSTU_ '),SALT39.HygieneErrors.NotLength('0'),SALT39.HygieneErrors.NotWords('0'),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_orig_subj3_address_sec_range(SALT39.StrType s0) := FUNCTION
  s1 := SALT39.stringfilter(s0,'3ABCDEGJNRSU_ '); // Only allow valid symbols
  s2 := SALT39.stringcleanspaces( SALT39.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_orig_subj3_address_sec_range(SALT39.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT39.StringFilter(s,'3ABCDEGJNRSU_ '))),~(LENGTH(TRIM(s)) = 0),~(SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 0));
EXPORT InValidMessageFT_orig_subj3_address_sec_range(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.NotLeft,SALT39.HygieneErrors.NotInChars('3ABCDEGJNRSU_ '),SALT39.HygieneErrors.NotLength('0'),SALT39.HygieneErrors.NotWords('0'),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_orig_subj3_address_city(SALT39.StrType s0) := FUNCTION
  s1 := SALT39.stringfilter(s0,'3ABCDEIJRSTUY_ '); // Only allow valid symbols
  s2 := SALT39.stringcleanspaces( SALT39.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_orig_subj3_address_city(SALT39.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT39.StringFilter(s,'3ABCDEIJRSTUY_ '))),~(LENGTH(TRIM(s)) = 0),~(SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 0));
EXPORT InValidMessageFT_orig_subj3_address_city(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.NotLeft,SALT39.HygieneErrors.NotInChars('3ABCDEIJRSTUY_ '),SALT39.HygieneErrors.NotLength('0'),SALT39.HygieneErrors.NotWords('0'),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_orig_subj3_address_st(SALT39.StrType s0) := FUNCTION
  s1 := SALT39.stringfilter(s0,'3ABDEJRSTU_ '); // Only allow valid symbols
  s2 := SALT39.stringcleanspaces( SALT39.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_orig_subj3_address_st(SALT39.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT39.StringFilter(s,'3ABDEJRSTU_ '))),~(LENGTH(TRIM(s)) = 0),~(SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 0));
EXPORT InValidMessageFT_orig_subj3_address_st(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.NotLeft,SALT39.HygieneErrors.NotInChars('3ABDEJRSTU_ '),SALT39.HygieneErrors.NotLength('0'),SALT39.HygieneErrors.NotWords('0'),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_orig_subj3_address_z5(SALT39.StrType s0) := FUNCTION
  s1 := SALT39.stringfilter(s0,'35ABDEJRSUZ_ '); // Only allow valid symbols
  s2 := SALT39.stringcleanspaces( SALT39.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_orig_subj3_address_z5(SALT39.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT39.StringFilter(s,'35ABDEJRSUZ_ '))),~(LENGTH(TRIM(s)) = 0),~(SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 0));
EXPORT InValidMessageFT_orig_subj3_address_z5(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.NotLeft,SALT39.HygieneErrors.NotInChars('35ABDEJRSUZ_ '),SALT39.HygieneErrors.NotLength('0'),SALT39.HygieneErrors.NotWords('0'),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_orig_subj3_address_z4(SALT39.StrType s0) := FUNCTION
  s1 := SALT39.stringfilter(s0,'34ABDEJRSUZ_ '); // Only allow valid symbols
  s2 := SALT39.stringcleanspaces( SALT39.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_orig_subj3_address_z4(SALT39.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT39.StringFilter(s,'34ABDEJRSUZ_ '))),~(LENGTH(TRIM(s)) = 0),~(SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 0));
EXPORT InValidMessageFT_orig_subj3_address_z4(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.NotLeft,SALT39.HygieneErrors.NotInChars('34ABDEJRSUZ_ '),SALT39.HygieneErrors.NotLength('0'),SALT39.HygieneErrors.NotWords('0'),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_orig_subj3_phone(SALT39.StrType s0) := FUNCTION
  s1 := SALT39.stringfilter(s0,'3BEHJNOPSU_ '); // Only allow valid symbols
  s2 := SALT39.stringcleanspaces( SALT39.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_orig_subj3_phone(SALT39.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT39.StringFilter(s,'3BEHJNOPSU_ '))),~(LENGTH(TRIM(s)) = 0),~(SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 0));
EXPORT InValidMessageFT_orig_subj3_phone(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.NotLeft,SALT39.HygieneErrors.NotInChars('3BEHJNOPSU_ '),SALT39.HygieneErrors.NotLength('0'),SALT39.HygieneErrors.NotWords('0'),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_orig_subj3_work_phone(SALT39.StrType s0) := FUNCTION
  s1 := SALT39.stringfilter(s0,'3BEHJKNOPRSUW_ '); // Only allow valid symbols
  s2 := SALT39.stringcleanspaces( SALT39.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_orig_subj3_work_phone(SALT39.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT39.StringFilter(s,'3BEHJKNOPRSUW_ '))),~(LENGTH(TRIM(s)) = 0),~(SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 0));
EXPORT InValidMessageFT_orig_subj3_work_phone(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.NotLeft,SALT39.HygieneErrors.NotInChars('3BEHJKNOPRSUW_ '),SALT39.HygieneErrors.NotLength('0'),SALT39.HygieneErrors.NotWords('0'),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_orig_subj3_business_title(SALT39.StrType s0) := FUNCTION
  s1 := SALT39.stringfilter(s0,'3BEIJLNSTU_ '); // Only allow valid symbols
  s2 := SALT39.stringcleanspaces( SALT39.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_orig_subj3_business_title(SALT39.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT39.StringFilter(s,'3BEIJLNSTU_ '))),~(LENGTH(TRIM(s)) = 0),~(SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 0));
EXPORT InValidMessageFT_orig_subj3_business_title(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.NotLeft,SALT39.HygieneErrors.NotInChars('3BEIJLNSTU_ '),SALT39.HygieneErrors.NotLength('0'),SALT39.HygieneErrors.NotWords('0'),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_orig_email(SALT39.StrType s0) := FUNCTION
  s1 := SALT39.stringfilter(s0,'AEILM '); // Only allow valid symbols
  s2 := SALT39.stringcleanspaces( SALT39.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_orig_email(SALT39.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT39.StringFilter(s,'AEILM '))),~(LENGTH(TRIM(s)) = 0),~(SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 0));
EXPORT InValidMessageFT_orig_email(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.NotLeft,SALT39.HygieneErrors.NotInChars('AEILM '),SALT39.HygieneErrors.NotLength('0'),SALT39.HygieneErrors.NotWords('0'),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_orig_subj2_email(SALT39.StrType s0) := FUNCTION
  s1 := SALT39.stringfilter(s0,'2ABEIJLMSU_ '); // Only allow valid symbols
  s2 := SALT39.stringcleanspaces( SALT39.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_orig_subj2_email(SALT39.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT39.StringFilter(s,'2ABEIJLMSU_ '))),~(LENGTH(TRIM(s)) = 0),~(SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 0));
EXPORT InValidMessageFT_orig_subj2_email(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.NotLeft,SALT39.HygieneErrors.NotInChars('2ABEIJLMSU_ '),SALT39.HygieneErrors.NotLength('0'),SALT39.HygieneErrors.NotWords('0'),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_orig_subj2_company_name(SALT39.StrType s0) := FUNCTION
  s1 := SALT39.stringfilter(s0,'2ABCEJMNOPSUY_ '); // Only allow valid symbols
  s2 := SALT39.stringcleanspaces( SALT39.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_orig_subj2_company_name(SALT39.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT39.StringFilter(s,'2ABCEJMNOPSUY_ '))),~(LENGTH(TRIM(s)) = 0),~(SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 0));
EXPORT InValidMessageFT_orig_subj2_company_name(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.NotLeft,SALT39.HygieneErrors.NotInChars('2ABCEJMNOPSUY_ '),SALT39.HygieneErrors.NotLength('0'),SALT39.HygieneErrors.NotWords('0'),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_orig_subj2_fein(SALT39.StrType s0) := FUNCTION
  s1 := SALT39.stringfilter(s0,'2BEFIJNSU_ '); // Only allow valid symbols
  s2 := SALT39.stringcleanspaces( SALT39.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_orig_subj2_fein(SALT39.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT39.StringFilter(s,'2BEFIJNSU_ '))),~(LENGTH(TRIM(s)) = 0),~(SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 0));
EXPORT InValidMessageFT_orig_subj2_fein(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.NotLeft,SALT39.HygieneErrors.NotInChars('2BEFIJNSU_ '),SALT39.HygieneErrors.NotLength('0'),SALT39.HygieneErrors.NotWords('0'),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_orig_subj3_email(SALT39.StrType s0) := FUNCTION
  s1 := SALT39.stringfilter(s0,'3ABEIJLMSU_ '); // Only allow valid symbols
  s2 := SALT39.stringcleanspaces( SALT39.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_orig_subj3_email(SALT39.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT39.StringFilter(s,'3ABEIJLMSU_ '))),~(LENGTH(TRIM(s)) = 0),~(SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 0));
EXPORT InValidMessageFT_orig_subj3_email(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.NotLeft,SALT39.HygieneErrors.NotInChars('3ABEIJLMSU_ '),SALT39.HygieneErrors.NotLength('0'),SALT39.HygieneErrors.NotWords('0'),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_orig_subj3_company_name(SALT39.StrType s0) := FUNCTION
  s1 := SALT39.stringfilter(s0,'3ABCEJMNOPSUY_ '); // Only allow valid symbols
  s2 := SALT39.stringcleanspaces( SALT39.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_orig_subj3_company_name(SALT39.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT39.StringFilter(s,'3ABCEJMNOPSUY_ '))),~(LENGTH(TRIM(s)) = 0),~(SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 0));
EXPORT InValidMessageFT_orig_subj3_company_name(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.NotLeft,SALT39.HygieneErrors.NotInChars('3ABCEJMNOPSUY_ '),SALT39.HygieneErrors.NotLength('0'),SALT39.HygieneErrors.NotWords('0'),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_orig_subj3_fein(SALT39.StrType s0) := FUNCTION
  s1 := SALT39.stringfilter(s0,'3BEFIJNSU_ '); // Only allow valid symbols
  s2 := SALT39.stringcleanspaces( SALT39.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_orig_subj3_fein(SALT39.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT39.StringFilter(s,'3BEFIJNSU_ '))),~(LENGTH(TRIM(s)) = 0),~(SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 0));
EXPORT InValidMessageFT_orig_subj3_fein(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.NotLeft,SALT39.HygieneErrors.NotInChars('3BEFIJNSU_ '),SALT39.HygieneErrors.NotLength('0'),SALT39.HygieneErrors.NotWords('0'),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_orig_subj4_first_name(SALT39.StrType s0) := FUNCTION
  s1 := SALT39.stringfilter(s0,'4ABEFIJMNRSTU_ '); // Only allow valid symbols
  s2 := SALT39.stringcleanspaces( SALT39.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_orig_subj4_first_name(SALT39.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT39.StringFilter(s,'4ABEFIJMNRSTU_ '))),~(LENGTH(TRIM(s)) = 0),~(SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 0));
EXPORT InValidMessageFT_orig_subj4_first_name(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.NotLeft,SALT39.HygieneErrors.NotInChars('4ABEFIJMNRSTU_ '),SALT39.HygieneErrors.NotLength('0'),SALT39.HygieneErrors.NotWords('0'),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_orig_subj4_middle_name(SALT39.StrType s0) := FUNCTION
  s1 := SALT39.stringfilter(s0,'4ABDEIJLMNSU_ '); // Only allow valid symbols
  s2 := SALT39.stringcleanspaces( SALT39.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_orig_subj4_middle_name(SALT39.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT39.StringFilter(s,'4ABDEIJLMNSU_ '))),~(LENGTH(TRIM(s)) = 0),~(SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 0));
EXPORT InValidMessageFT_orig_subj4_middle_name(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.NotLeft,SALT39.HygieneErrors.NotInChars('4ABDEIJLMNSU_ '),SALT39.HygieneErrors.NotLength('0'),SALT39.HygieneErrors.NotWords('0'),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_orig_subj4_last_name(SALT39.StrType s0) := FUNCTION
  s1 := SALT39.stringfilter(s0,'4ABEJLMNSTU_ '); // Only allow valid symbols
  s2 := SALT39.stringcleanspaces( SALT39.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_orig_subj4_last_name(SALT39.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT39.StringFilter(s,'4ABEJLMNSTU_ '))),~(LENGTH(TRIM(s)) = 0),~(SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 0));
EXPORT InValidMessageFT_orig_subj4_last_name(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.NotLeft,SALT39.HygieneErrors.NotInChars('4ABEJLMNSTU_ '),SALT39.HygieneErrors.NotLength('0'),SALT39.HygieneErrors.NotWords('0'),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_orig_subj4_suffix_name(SALT39.StrType s0) := FUNCTION
  s1 := SALT39.stringfilter(s0,'4ABEFIJMNSUX_ '); // Only allow valid symbols
  s2 := SALT39.stringcleanspaces( SALT39.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_orig_subj4_suffix_name(SALT39.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT39.StringFilter(s,'4ABEFIJMNSUX_ '))),~(LENGTH(TRIM(s)) = 0),~(SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 0));
EXPORT InValidMessageFT_orig_subj4_suffix_name(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.NotLeft,SALT39.HygieneErrors.NotInChars('4ABEFIJMNSUX_ '),SALT39.HygieneErrors.NotLength('0'),SALT39.HygieneErrors.NotWords('0'),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_orig_subj4_full_name(SALT39.StrType s0) := FUNCTION
  s1 := SALT39.stringfilter(s0,'4ABEFJLMNSU_ '); // Only allow valid symbols
  s2 := SALT39.stringcleanspaces( SALT39.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_orig_subj4_full_name(SALT39.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT39.StringFilter(s,'4ABEFJLMNSU_ '))),~(LENGTH(TRIM(s)) = 0),~(SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 0));
EXPORT InValidMessageFT_orig_subj4_full_name(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.NotLeft,SALT39.HygieneErrors.NotInChars('4ABEFJLMNSU_ '),SALT39.HygieneErrors.NotLength('0'),SALT39.HygieneErrors.NotWords('0'),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_orig_subj4_ssn(SALT39.StrType s0) := FUNCTION
  s1 := SALT39.stringfilter(s0,'4BJNSU_ '); // Only allow valid symbols
  s2 := SALT39.stringcleanspaces( SALT39.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_orig_subj4_ssn(SALT39.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT39.StringFilter(s,'4BJNSU_ '))),~(LENGTH(TRIM(s)) = 0),~(SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 0));
EXPORT InValidMessageFT_orig_subj4_ssn(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.NotLeft,SALT39.HygieneErrors.NotInChars('4BJNSU_ '),SALT39.HygieneErrors.NotLength('0'),SALT39.HygieneErrors.NotWords('0'),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_orig_subj4_dob(SALT39.StrType s0) := FUNCTION
  s1 := SALT39.stringfilter(s0,'4BDJOSU_ '); // Only allow valid symbols
  s2 := SALT39.stringcleanspaces( SALT39.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_orig_subj4_dob(SALT39.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT39.StringFilter(s,'4BDJOSU_ '))),~(LENGTH(TRIM(s)) = 0),~(SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 0));
EXPORT InValidMessageFT_orig_subj4_dob(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.NotLeft,SALT39.HygieneErrors.NotInChars('4BDJOSU_ '),SALT39.HygieneErrors.NotLength('0'),SALT39.HygieneErrors.NotWords('0'),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_orig_subj4_dl_num(SALT39.StrType s0) := FUNCTION
  s1 := SALT39.stringfilter(s0,'4BDJLMNSU_ '); // Only allow valid symbols
  s2 := SALT39.stringcleanspaces( SALT39.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_orig_subj4_dl_num(SALT39.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT39.StringFilter(s,'4BDJLMNSU_ '))),~(LENGTH(TRIM(s)) = 0),~(SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 0));
EXPORT InValidMessageFT_orig_subj4_dl_num(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.NotLeft,SALT39.HygieneErrors.NotInChars('4BDJLMNSU_ '),SALT39.HygieneErrors.NotLength('0'),SALT39.HygieneErrors.NotWords('0'),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_orig_subj4_dl_state(SALT39.StrType s0) := FUNCTION
  s1 := SALT39.stringfilter(s0,'4ABDEJLSTU_ '); // Only allow valid symbols
  s2 := SALT39.stringcleanspaces( SALT39.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_orig_subj4_dl_state(SALT39.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT39.StringFilter(s,'4ABDEJLSTU_ '))),~(LENGTH(TRIM(s)) = 0),~(SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 0));
EXPORT InValidMessageFT_orig_subj4_dl_state(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.NotLeft,SALT39.HygieneErrors.NotInChars('4ABDEJLSTU_ '),SALT39.HygieneErrors.NotLength('0'),SALT39.HygieneErrors.NotWords('0'),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_orig_subj4_former_last_name(SALT39.StrType s0) := FUNCTION
  s1 := SALT39.stringfilter(s0,'4ABEFJLMNORSTU_ '); // Only allow valid symbols
  s2 := SALT39.stringcleanspaces( SALT39.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_orig_subj4_former_last_name(SALT39.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT39.StringFilter(s,'4ABEFJLMNORSTU_ '))),~(LENGTH(TRIM(s)) = 0),~(SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 0));
EXPORT InValidMessageFT_orig_subj4_former_last_name(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.NotLeft,SALT39.HygieneErrors.NotInChars('4ABEFJLMNORSTU_ '),SALT39.HygieneErrors.NotLength('0'),SALT39.HygieneErrors.NotWords('0'),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_orig_subj4_address_addressline1(SALT39.StrType s0) := FUNCTION
  s1 := SALT39.stringfilter(s0,'14ABDEIJLNRSU_ '); // Only allow valid symbols
  s2 := SALT39.stringcleanspaces( SALT39.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_orig_subj4_address_addressline1(SALT39.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT39.StringFilter(s,'14ABDEIJLNRSU_ '))),~(LENGTH(TRIM(s)) = 0),~(SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 0));
EXPORT InValidMessageFT_orig_subj4_address_addressline1(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.NotLeft,SALT39.HygieneErrors.NotInChars('14ABDEIJLNRSU_ '),SALT39.HygieneErrors.NotLength('0'),SALT39.HygieneErrors.NotWords('0'),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_orig_subj4_address_addressline2(SALT39.StrType s0) := FUNCTION
  s1 := SALT39.stringfilter(s0,'24ABDEIJLNRSU_ '); // Only allow valid symbols
  s2 := SALT39.stringcleanspaces( SALT39.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_orig_subj4_address_addressline2(SALT39.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT39.StringFilter(s,'24ABDEIJLNRSU_ '))),~(LENGTH(TRIM(s)) = 0),~(SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 0));
EXPORT InValidMessageFT_orig_subj4_address_addressline2(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.NotLeft,SALT39.HygieneErrors.NotInChars('24ABDEIJLNRSU_ '),SALT39.HygieneErrors.NotLength('0'),SALT39.HygieneErrors.NotWords('0'),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_orig_subj4_address_prim_range(SALT39.StrType s0) := FUNCTION
  s1 := SALT39.stringfilter(s0,'4ABDEGIJMNPRSU_ '); // Only allow valid symbols
  s2 := SALT39.stringcleanspaces( SALT39.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_orig_subj4_address_prim_range(SALT39.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT39.StringFilter(s,'4ABDEGIJMNPRSU_ '))),~(LENGTH(TRIM(s)) = 0),~(SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 0));
EXPORT InValidMessageFT_orig_subj4_address_prim_range(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.NotLeft,SALT39.HygieneErrors.NotInChars('4ABDEGIJMNPRSU_ '),SALT39.HygieneErrors.NotLength('0'),SALT39.HygieneErrors.NotWords('0'),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_orig_subj4_address_predir(SALT39.StrType s0) := FUNCTION
  s1 := SALT39.stringfilter(s0,'4ABDEIJPRSU_ '); // Only allow valid symbols
  s2 := SALT39.stringcleanspaces( SALT39.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_orig_subj4_address_predir(SALT39.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT39.StringFilter(s,'4ABDEIJPRSU_ '))),~(LENGTH(TRIM(s)) = 0),~(SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 0));
EXPORT InValidMessageFT_orig_subj4_address_predir(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.NotLeft,SALT39.HygieneErrors.NotInChars('4ABDEIJPRSU_ '),SALT39.HygieneErrors.NotLength('0'),SALT39.HygieneErrors.NotWords('0'),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_orig_subj4_address_prim_name(SALT39.StrType s0) := FUNCTION
  s1 := SALT39.stringfilter(s0,'4ABDEIJMNPRSU_ '); // Only allow valid symbols
  s2 := SALT39.stringcleanspaces( SALT39.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_orig_subj4_address_prim_name(SALT39.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT39.StringFilter(s,'4ABDEIJMNPRSU_ '))),~(LENGTH(TRIM(s)) = 0),~(SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 0));
EXPORT InValidMessageFT_orig_subj4_address_prim_name(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.NotLeft,SALT39.HygieneErrors.NotInChars('4ABDEIJMNPRSU_ '),SALT39.HygieneErrors.NotLength('0'),SALT39.HygieneErrors.NotWords('0'),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_orig_subj4_address_suffix(SALT39.StrType s0) := FUNCTION
  s1 := SALT39.stringfilter(s0,'4ABDEFIJRSUX_ '); // Only allow valid symbols
  s2 := SALT39.stringcleanspaces( SALT39.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_orig_subj4_address_suffix(SALT39.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT39.StringFilter(s,'4ABDEFIJRSUX_ '))),~(LENGTH(TRIM(s)) = 0),~(SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 0));
EXPORT InValidMessageFT_orig_subj4_address_suffix(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.NotLeft,SALT39.HygieneErrors.NotInChars('4ABDEFIJRSUX_ '),SALT39.HygieneErrors.NotLength('0'),SALT39.HygieneErrors.NotWords('0'),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_orig_subj4_address_postdir(SALT39.StrType s0) := FUNCTION
  s1 := SALT39.stringfilter(s0,'4ABDEIJOPRSTU_ '); // Only allow valid symbols
  s2 := SALT39.stringcleanspaces( SALT39.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_orig_subj4_address_postdir(SALT39.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT39.StringFilter(s,'4ABDEIJOPRSTU_ '))),~(LENGTH(TRIM(s)) = 0),~(SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 0));
EXPORT InValidMessageFT_orig_subj4_address_postdir(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.NotLeft,SALT39.HygieneErrors.NotInChars('4ABDEIJOPRSTU_ '),SALT39.HygieneErrors.NotLength('0'),SALT39.HygieneErrors.NotWords('0'),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_orig_subj4_address_unit_desig(SALT39.StrType s0) := FUNCTION
  s1 := SALT39.stringfilter(s0,'4ABDEGIJNRSTU_ '); // Only allow valid symbols
  s2 := SALT39.stringcleanspaces( SALT39.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_orig_subj4_address_unit_desig(SALT39.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT39.StringFilter(s,'4ABDEGIJNRSTU_ '))),~(LENGTH(TRIM(s)) = 0),~(SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 0));
EXPORT InValidMessageFT_orig_subj4_address_unit_desig(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.NotLeft,SALT39.HygieneErrors.NotInChars('4ABDEGIJNRSTU_ '),SALT39.HygieneErrors.NotLength('0'),SALT39.HygieneErrors.NotWords('0'),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_orig_subj4_address_sec_range(SALT39.StrType s0) := FUNCTION
  s1 := SALT39.stringfilter(s0,'4ABCDEGJNRSU_ '); // Only allow valid symbols
  s2 := SALT39.stringcleanspaces( SALT39.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_orig_subj4_address_sec_range(SALT39.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT39.StringFilter(s,'4ABCDEGJNRSU_ '))),~(LENGTH(TRIM(s)) = 0),~(SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 0));
EXPORT InValidMessageFT_orig_subj4_address_sec_range(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.NotLeft,SALT39.HygieneErrors.NotInChars('4ABCDEGJNRSU_ '),SALT39.HygieneErrors.NotLength('0'),SALT39.HygieneErrors.NotWords('0'),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_orig_subj4_address_city(SALT39.StrType s0) := FUNCTION
  s1 := SALT39.stringfilter(s0,'4ABCDEIJRSTUY_ '); // Only allow valid symbols
  s2 := SALT39.stringcleanspaces( SALT39.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_orig_subj4_address_city(SALT39.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT39.StringFilter(s,'4ABCDEIJRSTUY_ '))),~(LENGTH(TRIM(s)) = 0),~(SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 0));
EXPORT InValidMessageFT_orig_subj4_address_city(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.NotLeft,SALT39.HygieneErrors.NotInChars('4ABCDEIJRSTUY_ '),SALT39.HygieneErrors.NotLength('0'),SALT39.HygieneErrors.NotWords('0'),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_orig_subj4_address_st(SALT39.StrType s0) := FUNCTION
  s1 := SALT39.stringfilter(s0,'4ABDEJRSTU_ '); // Only allow valid symbols
  s2 := SALT39.stringcleanspaces( SALT39.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_orig_subj4_address_st(SALT39.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT39.StringFilter(s,'4ABDEJRSTU_ '))),~(LENGTH(TRIM(s)) = 0),~(SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 0));
EXPORT InValidMessageFT_orig_subj4_address_st(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.NotLeft,SALT39.HygieneErrors.NotInChars('4ABDEJRSTU_ '),SALT39.HygieneErrors.NotLength('0'),SALT39.HygieneErrors.NotWords('0'),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_orig_subj4_address_z5(SALT39.StrType s0) := FUNCTION
  s1 := SALT39.stringfilter(s0,'45ABDEJRSUZ_ '); // Only allow valid symbols
  s2 := SALT39.stringcleanspaces( SALT39.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_orig_subj4_address_z5(SALT39.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT39.StringFilter(s,'45ABDEJRSUZ_ '))),~(LENGTH(TRIM(s)) = 0),~(SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 0));
EXPORT InValidMessageFT_orig_subj4_address_z5(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.NotLeft,SALT39.HygieneErrors.NotInChars('45ABDEJRSUZ_ '),SALT39.HygieneErrors.NotLength('0'),SALT39.HygieneErrors.NotWords('0'),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_orig_subj4_address_z4(SALT39.StrType s0) := FUNCTION
  s1 := SALT39.stringfilter(s0,'4ABDEJRSUZ_ '); // Only allow valid symbols
  s2 := SALT39.stringcleanspaces( SALT39.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_orig_subj4_address_z4(SALT39.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT39.StringFilter(s,'4ABDEJRSUZ_ '))),~(LENGTH(TRIM(s)) = 0),~(SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 0));
EXPORT InValidMessageFT_orig_subj4_address_z4(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.NotLeft,SALT39.HygieneErrors.NotInChars('4ABDEJRSUZ_ '),SALT39.HygieneErrors.NotLength('0'),SALT39.HygieneErrors.NotWords('0'),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_orig_subj4_phone(SALT39.StrType s0) := FUNCTION
  s1 := SALT39.stringfilter(s0,'4BEHJNOPSU_ '); // Only allow valid symbols
  s2 := SALT39.stringcleanspaces( SALT39.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_orig_subj4_phone(SALT39.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT39.StringFilter(s,'4BEHJNOPSU_ '))),~(LENGTH(TRIM(s)) = 0),~(SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 0));
EXPORT InValidMessageFT_orig_subj4_phone(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.NotLeft,SALT39.HygieneErrors.NotInChars('4BEHJNOPSU_ '),SALT39.HygieneErrors.NotLength('0'),SALT39.HygieneErrors.NotWords('0'),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_orig_subj4_work_phone(SALT39.StrType s0) := FUNCTION
  s1 := SALT39.stringfilter(s0,'4BEHJKNOPRSUW_ '); // Only allow valid symbols
  s2 := SALT39.stringcleanspaces( SALT39.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_orig_subj4_work_phone(SALT39.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT39.StringFilter(s,'4BEHJKNOPRSUW_ '))),~(LENGTH(TRIM(s)) = 0),~(SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 0));
EXPORT InValidMessageFT_orig_subj4_work_phone(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.NotLeft,SALT39.HygieneErrors.NotInChars('4BEHJKNOPRSUW_ '),SALT39.HygieneErrors.NotLength('0'),SALT39.HygieneErrors.NotWords('0'),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_orig_subj4_business_title(SALT39.StrType s0) := FUNCTION
  s1 := SALT39.stringfilter(s0,'4BEIJLNSTU_ '); // Only allow valid symbols
  s2 := SALT39.stringcleanspaces( SALT39.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_orig_subj4_business_title(SALT39.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT39.StringFilter(s,'4BEIJLNSTU_ '))),~(LENGTH(TRIM(s)) = 0),~(SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 0));
EXPORT InValidMessageFT_orig_subj4_business_title(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.NotLeft,SALT39.HygieneErrors.NotInChars('4BEIJLNSTU_ '),SALT39.HygieneErrors.NotLength('0'),SALT39.HygieneErrors.NotWords('0'),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_orig_subj4_email(SALT39.StrType s0) := FUNCTION
  s1 := SALT39.stringfilter(s0,'4ABEIJLMSU_ '); // Only allow valid symbols
  s2 := SALT39.stringcleanspaces( SALT39.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_orig_subj4_email(SALT39.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT39.StringFilter(s,'4ABEIJLMSU_ '))),~(LENGTH(TRIM(s)) = 0),~(SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 0));
EXPORT InValidMessageFT_orig_subj4_email(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.NotLeft,SALT39.HygieneErrors.NotInChars('4ABEIJLMSU_ '),SALT39.HygieneErrors.NotLength('0'),SALT39.HygieneErrors.NotWords('0'),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_orig_subj4_company_name(SALT39.StrType s0) := FUNCTION
  s1 := SALT39.stringfilter(s0,'4ABCEJMNOPSUY_ '); // Only allow valid symbols
  s2 := SALT39.stringcleanspaces( SALT39.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_orig_subj4_company_name(SALT39.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT39.StringFilter(s,'4ABCEJMNOPSUY_ '))),~(LENGTH(TRIM(s)) = 0),~(SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 0));
EXPORT InValidMessageFT_orig_subj4_company_name(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.NotLeft,SALT39.HygieneErrors.NotInChars('4ABCEJMNOPSUY_ '),SALT39.HygieneErrors.NotLength('0'),SALT39.HygieneErrors.NotWords('0'),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_orig_subj4_fein(SALT39.StrType s0) := FUNCTION
  s1 := SALT39.stringfilter(s0,'4BEFIJNSU_ '); // Only allow valid symbols
  s2 := SALT39.stringcleanspaces( SALT39.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_orig_subj4_fein(SALT39.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT39.StringFilter(s,'4BEFIJNSU_ '))),~(LENGTH(TRIM(s)) = 0),~(SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 0));
EXPORT InValidMessageFT_orig_subj4_fein(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.NotLeft,SALT39.HygieneErrors.NotInChars('4BEFIJNSU_ '),SALT39.HygieneErrors.NotLength('0'),SALT39.HygieneErrors.NotWords('0'),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_orig_subj5_first_name(SALT39.StrType s0) := FUNCTION
  s1 := SALT39.stringfilter(s0,'5ABEFIJMNRSTU_ '); // Only allow valid symbols
  s2 := SALT39.stringcleanspaces( SALT39.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_orig_subj5_first_name(SALT39.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT39.StringFilter(s,'5ABEFIJMNRSTU_ '))),~(LENGTH(TRIM(s)) = 0),~(SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 0));
EXPORT InValidMessageFT_orig_subj5_first_name(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.NotLeft,SALT39.HygieneErrors.NotInChars('5ABEFIJMNRSTU_ '),SALT39.HygieneErrors.NotLength('0'),SALT39.HygieneErrors.NotWords('0'),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_orig_subj5_middle_name(SALT39.StrType s0) := FUNCTION
  s1 := SALT39.stringfilter(s0,'5ABDEIJLMNSU_ '); // Only allow valid symbols
  s2 := SALT39.stringcleanspaces( SALT39.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_orig_subj5_middle_name(SALT39.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT39.StringFilter(s,'5ABDEIJLMNSU_ '))),~(LENGTH(TRIM(s)) = 0),~(SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 0));
EXPORT InValidMessageFT_orig_subj5_middle_name(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.NotLeft,SALT39.HygieneErrors.NotInChars('5ABDEIJLMNSU_ '),SALT39.HygieneErrors.NotLength('0'),SALT39.HygieneErrors.NotWords('0'),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_orig_subj5_last_name(SALT39.StrType s0) := FUNCTION
  s1 := SALT39.stringfilter(s0,'5ABEJLMNSTU_ '); // Only allow valid symbols
  s2 := SALT39.stringcleanspaces( SALT39.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_orig_subj5_last_name(SALT39.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT39.StringFilter(s,'5ABEJLMNSTU_ '))),~(LENGTH(TRIM(s)) = 0),~(SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 0));
EXPORT InValidMessageFT_orig_subj5_last_name(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.NotLeft,SALT39.HygieneErrors.NotInChars('5ABEJLMNSTU_ '),SALT39.HygieneErrors.NotLength('0'),SALT39.HygieneErrors.NotWords('0'),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_orig_subj5_suffix_name(SALT39.StrType s0) := FUNCTION
  s1 := SALT39.stringfilter(s0,'5ABEFIJMNSUX_ '); // Only allow valid symbols
  s2 := SALT39.stringcleanspaces( SALT39.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_orig_subj5_suffix_name(SALT39.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT39.StringFilter(s,'5ABEFIJMNSUX_ '))),~(LENGTH(TRIM(s)) = 0),~(SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 0));
EXPORT InValidMessageFT_orig_subj5_suffix_name(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.NotLeft,SALT39.HygieneErrors.NotInChars('5ABEFIJMNSUX_ '),SALT39.HygieneErrors.NotLength('0'),SALT39.HygieneErrors.NotWords('0'),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_orig_subj5_full_name(SALT39.StrType s0) := FUNCTION
  s1 := SALT39.stringfilter(s0,'5ABEFJLMNSU_ '); // Only allow valid symbols
  s2 := SALT39.stringcleanspaces( SALT39.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_orig_subj5_full_name(SALT39.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT39.StringFilter(s,'5ABEFJLMNSU_ '))),~(LENGTH(TRIM(s)) = 0),~(SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 0));
EXPORT InValidMessageFT_orig_subj5_full_name(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.NotLeft,SALT39.HygieneErrors.NotInChars('5ABEFJLMNSU_ '),SALT39.HygieneErrors.NotLength('0'),SALT39.HygieneErrors.NotWords('0'),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_orig_subj5_ssn(SALT39.StrType s0) := FUNCTION
  s1 := SALT39.stringfilter(s0,'5BJNSU_ '); // Only allow valid symbols
  s2 := SALT39.stringcleanspaces( SALT39.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_orig_subj5_ssn(SALT39.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT39.StringFilter(s,'5BJNSU_ '))),~(LENGTH(TRIM(s)) = 0),~(SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 0));
EXPORT InValidMessageFT_orig_subj5_ssn(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.NotLeft,SALT39.HygieneErrors.NotInChars('5BJNSU_ '),SALT39.HygieneErrors.NotLength('0'),SALT39.HygieneErrors.NotWords('0'),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_orig_subj5_dob(SALT39.StrType s0) := FUNCTION
  s1 := SALT39.stringfilter(s0,'5BDJOSU_ '); // Only allow valid symbols
  s2 := SALT39.stringcleanspaces( SALT39.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_orig_subj5_dob(SALT39.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT39.StringFilter(s,'5BDJOSU_ '))),~(LENGTH(TRIM(s)) = 0),~(SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 0));
EXPORT InValidMessageFT_orig_subj5_dob(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.NotLeft,SALT39.HygieneErrors.NotInChars('5BDJOSU_ '),SALT39.HygieneErrors.NotLength('0'),SALT39.HygieneErrors.NotWords('0'),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_orig_subj5_dl_num(SALT39.StrType s0) := FUNCTION
  s1 := SALT39.stringfilter(s0,'5BDJLMNSU_ '); // Only allow valid symbols
  s2 := SALT39.stringcleanspaces( SALT39.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_orig_subj5_dl_num(SALT39.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT39.StringFilter(s,'5BDJLMNSU_ '))),~(LENGTH(TRIM(s)) = 0),~(SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 0));
EXPORT InValidMessageFT_orig_subj5_dl_num(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.NotLeft,SALT39.HygieneErrors.NotInChars('5BDJLMNSU_ '),SALT39.HygieneErrors.NotLength('0'),SALT39.HygieneErrors.NotWords('0'),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_orig_subj5_dl_state(SALT39.StrType s0) := FUNCTION
  s1 := SALT39.stringfilter(s0,'5ABDEJLSTU_ '); // Only allow valid symbols
  s2 := SALT39.stringcleanspaces( SALT39.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_orig_subj5_dl_state(SALT39.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT39.StringFilter(s,'5ABDEJLSTU_ '))),~(LENGTH(TRIM(s)) = 0),~(SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 0));
EXPORT InValidMessageFT_orig_subj5_dl_state(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.NotLeft,SALT39.HygieneErrors.NotInChars('5ABDEJLSTU_ '),SALT39.HygieneErrors.NotLength('0'),SALT39.HygieneErrors.NotWords('0'),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_orig_subj5_former_last_name(SALT39.StrType s0) := FUNCTION
  s1 := SALT39.stringfilter(s0,'5ABEFJLMNORSTU_ '); // Only allow valid symbols
  s2 := SALT39.stringcleanspaces( SALT39.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_orig_subj5_former_last_name(SALT39.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT39.StringFilter(s,'5ABEFJLMNORSTU_ '))),~(LENGTH(TRIM(s)) = 0),~(SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 0));
EXPORT InValidMessageFT_orig_subj5_former_last_name(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.NotLeft,SALT39.HygieneErrors.NotInChars('5ABEFJLMNORSTU_ '),SALT39.HygieneErrors.NotLength('0'),SALT39.HygieneErrors.NotWords('0'),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_orig_subj5_address_addressline1(SALT39.StrType s0) := FUNCTION
  s1 := SALT39.stringfilter(s0,'15ABDEIJLNRSU_ '); // Only allow valid symbols
  s2 := SALT39.stringcleanspaces( SALT39.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_orig_subj5_address_addressline1(SALT39.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT39.StringFilter(s,'15ABDEIJLNRSU_ '))),~(LENGTH(TRIM(s)) = 0),~(SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 0));
EXPORT InValidMessageFT_orig_subj5_address_addressline1(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.NotLeft,SALT39.HygieneErrors.NotInChars('15ABDEIJLNRSU_ '),SALT39.HygieneErrors.NotLength('0'),SALT39.HygieneErrors.NotWords('0'),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_orig_subj5_address_addressline2(SALT39.StrType s0) := FUNCTION
  s1 := SALT39.stringfilter(s0,'25ABDEIJLNRSU_ '); // Only allow valid symbols
  s2 := SALT39.stringcleanspaces( SALT39.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_orig_subj5_address_addressline2(SALT39.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT39.StringFilter(s,'25ABDEIJLNRSU_ '))),~(LENGTH(TRIM(s)) = 0),~(SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 0));
EXPORT InValidMessageFT_orig_subj5_address_addressline2(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.NotLeft,SALT39.HygieneErrors.NotInChars('25ABDEIJLNRSU_ '),SALT39.HygieneErrors.NotLength('0'),SALT39.HygieneErrors.NotWords('0'),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_orig_subj5_address_prim_range(SALT39.StrType s0) := FUNCTION
  s1 := SALT39.stringfilter(s0,'5ABDEGIJMNPRSU_ '); // Only allow valid symbols
  s2 := SALT39.stringcleanspaces( SALT39.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_orig_subj5_address_prim_range(SALT39.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT39.StringFilter(s,'5ABDEGIJMNPRSU_ '))),~(LENGTH(TRIM(s)) = 0),~(SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 0));
EXPORT InValidMessageFT_orig_subj5_address_prim_range(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.NotLeft,SALT39.HygieneErrors.NotInChars('5ABDEGIJMNPRSU_ '),SALT39.HygieneErrors.NotLength('0'),SALT39.HygieneErrors.NotWords('0'),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_orig_subj5_address_predir(SALT39.StrType s0) := FUNCTION
  s1 := SALT39.stringfilter(s0,'5ABDEIJPRSU_ '); // Only allow valid symbols
  s2 := SALT39.stringcleanspaces( SALT39.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_orig_subj5_address_predir(SALT39.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT39.StringFilter(s,'5ABDEIJPRSU_ '))),~(LENGTH(TRIM(s)) = 0),~(SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 0));
EXPORT InValidMessageFT_orig_subj5_address_predir(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.NotLeft,SALT39.HygieneErrors.NotInChars('5ABDEIJPRSU_ '),SALT39.HygieneErrors.NotLength('0'),SALT39.HygieneErrors.NotWords('0'),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_orig_subj5_address_prim_name(SALT39.StrType s0) := FUNCTION
  s1 := SALT39.stringfilter(s0,'5ABDEIJMNPRSU_ '); // Only allow valid symbols
  s2 := SALT39.stringcleanspaces( SALT39.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_orig_subj5_address_prim_name(SALT39.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT39.StringFilter(s,'5ABDEIJMNPRSU_ '))),~(LENGTH(TRIM(s)) = 0),~(SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 0));
EXPORT InValidMessageFT_orig_subj5_address_prim_name(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.NotLeft,SALT39.HygieneErrors.NotInChars('5ABDEIJMNPRSU_ '),SALT39.HygieneErrors.NotLength('0'),SALT39.HygieneErrors.NotWords('0'),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_orig_subj5_address_suffix(SALT39.StrType s0) := FUNCTION
  s1 := SALT39.stringfilter(s0,'5ABDEFIJRSUX_ '); // Only allow valid symbols
  s2 := SALT39.stringcleanspaces( SALT39.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_orig_subj5_address_suffix(SALT39.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT39.StringFilter(s,'5ABDEFIJRSUX_ '))),~(LENGTH(TRIM(s)) = 0),~(SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 0));
EXPORT InValidMessageFT_orig_subj5_address_suffix(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.NotLeft,SALT39.HygieneErrors.NotInChars('5ABDEFIJRSUX_ '),SALT39.HygieneErrors.NotLength('0'),SALT39.HygieneErrors.NotWords('0'),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_orig_subj5_address_postdir(SALT39.StrType s0) := FUNCTION
  s1 := SALT39.stringfilter(s0,'5ABDEIJOPRSTU_ '); // Only allow valid symbols
  s2 := SALT39.stringcleanspaces( SALT39.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_orig_subj5_address_postdir(SALT39.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT39.StringFilter(s,'5ABDEIJOPRSTU_ '))),~(LENGTH(TRIM(s)) = 0),~(SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 0));
EXPORT InValidMessageFT_orig_subj5_address_postdir(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.NotLeft,SALT39.HygieneErrors.NotInChars('5ABDEIJOPRSTU_ '),SALT39.HygieneErrors.NotLength('0'),SALT39.HygieneErrors.NotWords('0'),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_orig_subj5_address_unit_desig(SALT39.StrType s0) := FUNCTION
  s1 := SALT39.stringfilter(s0,'5ABDEGIJNRSTU_ '); // Only allow valid symbols
  s2 := SALT39.stringcleanspaces( SALT39.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_orig_subj5_address_unit_desig(SALT39.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT39.StringFilter(s,'5ABDEGIJNRSTU_ '))),~(LENGTH(TRIM(s)) = 0),~(SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 0));
EXPORT InValidMessageFT_orig_subj5_address_unit_desig(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.NotLeft,SALT39.HygieneErrors.NotInChars('5ABDEGIJNRSTU_ '),SALT39.HygieneErrors.NotLength('0'),SALT39.HygieneErrors.NotWords('0'),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_orig_subj5_address_sec_range(SALT39.StrType s0) := FUNCTION
  s1 := SALT39.stringfilter(s0,'5ABCDEGJNRSU_ '); // Only allow valid symbols
  s2 := SALT39.stringcleanspaces( SALT39.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_orig_subj5_address_sec_range(SALT39.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT39.StringFilter(s,'5ABCDEGJNRSU_ '))),~(LENGTH(TRIM(s)) = 0),~(SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 0));
EXPORT InValidMessageFT_orig_subj5_address_sec_range(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.NotLeft,SALT39.HygieneErrors.NotInChars('5ABCDEGJNRSU_ '),SALT39.HygieneErrors.NotLength('0'),SALT39.HygieneErrors.NotWords('0'),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_orig_subj5_address_city(SALT39.StrType s0) := FUNCTION
  s1 := SALT39.stringfilter(s0,'5ABCDEIJRSTUY_ '); // Only allow valid symbols
  s2 := SALT39.stringcleanspaces( SALT39.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_orig_subj5_address_city(SALT39.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT39.StringFilter(s,'5ABCDEIJRSTUY_ '))),~(LENGTH(TRIM(s)) = 0),~(SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 0));
EXPORT InValidMessageFT_orig_subj5_address_city(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.NotLeft,SALT39.HygieneErrors.NotInChars('5ABCDEIJRSTUY_ '),SALT39.HygieneErrors.NotLength('0'),SALT39.HygieneErrors.NotWords('0'),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_orig_subj5_address_st(SALT39.StrType s0) := FUNCTION
  s1 := SALT39.stringfilter(s0,'5ABDEJRSTU_ '); // Only allow valid symbols
  s2 := SALT39.stringcleanspaces( SALT39.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_orig_subj5_address_st(SALT39.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT39.StringFilter(s,'5ABDEJRSTU_ '))),~(LENGTH(TRIM(s)) = 0),~(SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 0));
EXPORT InValidMessageFT_orig_subj5_address_st(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.NotLeft,SALT39.HygieneErrors.NotInChars('5ABDEJRSTU_ '),SALT39.HygieneErrors.NotLength('0'),SALT39.HygieneErrors.NotWords('0'),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_orig_subj5_address_z5(SALT39.StrType s0) := FUNCTION
  s1 := SALT39.stringfilter(s0,'5ABDEJRSUZ_ '); // Only allow valid symbols
  s2 := SALT39.stringcleanspaces( SALT39.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_orig_subj5_address_z5(SALT39.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT39.StringFilter(s,'5ABDEJRSUZ_ '))),~(LENGTH(TRIM(s)) = 0),~(SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 0));
EXPORT InValidMessageFT_orig_subj5_address_z5(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.NotLeft,SALT39.HygieneErrors.NotInChars('5ABDEJRSUZ_ '),SALT39.HygieneErrors.NotLength('0'),SALT39.HygieneErrors.NotWords('0'),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_orig_subj5_address_z4(SALT39.StrType s0) := FUNCTION
  s1 := SALT39.stringfilter(s0,'45ABDEJRSUZ_ '); // Only allow valid symbols
  s2 := SALT39.stringcleanspaces( SALT39.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_orig_subj5_address_z4(SALT39.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT39.StringFilter(s,'45ABDEJRSUZ_ '))),~(LENGTH(TRIM(s)) = 0),~(SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 0));
EXPORT InValidMessageFT_orig_subj5_address_z4(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.NotLeft,SALT39.HygieneErrors.NotInChars('45ABDEJRSUZ_ '),SALT39.HygieneErrors.NotLength('0'),SALT39.HygieneErrors.NotWords('0'),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_orig_subj5_phone(SALT39.StrType s0) := FUNCTION
  s1 := SALT39.stringfilter(s0,'5BEHJNOPSU_ '); // Only allow valid symbols
  s2 := SALT39.stringcleanspaces( SALT39.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_orig_subj5_phone(SALT39.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT39.StringFilter(s,'5BEHJNOPSU_ '))),~(LENGTH(TRIM(s)) = 0),~(SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 0));
EXPORT InValidMessageFT_orig_subj5_phone(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.NotLeft,SALT39.HygieneErrors.NotInChars('5BEHJNOPSU_ '),SALT39.HygieneErrors.NotLength('0'),SALT39.HygieneErrors.NotWords('0'),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_orig_subj5_work_phone(SALT39.StrType s0) := FUNCTION
  s1 := SALT39.stringfilter(s0,'5BEHJKNOPRSUW_ '); // Only allow valid symbols
  s2 := SALT39.stringcleanspaces( SALT39.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_orig_subj5_work_phone(SALT39.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT39.StringFilter(s,'5BEHJKNOPRSUW_ '))),~(LENGTH(TRIM(s)) = 0),~(SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 0));
EXPORT InValidMessageFT_orig_subj5_work_phone(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.NotLeft,SALT39.HygieneErrors.NotInChars('5BEHJKNOPRSUW_ '),SALT39.HygieneErrors.NotLength('0'),SALT39.HygieneErrors.NotWords('0'),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_orig_subj5_business_title(SALT39.StrType s0) := FUNCTION
  s1 := SALT39.stringfilter(s0,'5BEIJLNSTU_ '); // Only allow valid symbols
  s2 := SALT39.stringcleanspaces( SALT39.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_orig_subj5_business_title(SALT39.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT39.StringFilter(s,'5BEIJLNSTU_ '))),~(LENGTH(TRIM(s)) = 0),~(SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 0));
EXPORT InValidMessageFT_orig_subj5_business_title(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.NotLeft,SALT39.HygieneErrors.NotInChars('5BEIJLNSTU_ '),SALT39.HygieneErrors.NotLength('0'),SALT39.HygieneErrors.NotWords('0'),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_orig_subj5_email(SALT39.StrType s0) := FUNCTION
  s1 := SALT39.stringfilter(s0,'5ABEIJLMSU_ '); // Only allow valid symbols
  s2 := SALT39.stringcleanspaces( SALT39.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_orig_subj5_email(SALT39.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT39.StringFilter(s,'5ABEIJLMSU_ '))),~(LENGTH(TRIM(s)) = 0),~(SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 0));
EXPORT InValidMessageFT_orig_subj5_email(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.NotLeft,SALT39.HygieneErrors.NotInChars('5ABEIJLMSU_ '),SALT39.HygieneErrors.NotLength('0'),SALT39.HygieneErrors.NotWords('0'),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_orig_subj5_company_name(SALT39.StrType s0) := FUNCTION
  s1 := SALT39.stringfilter(s0,'5ABCEJMNOPSUY_ '); // Only allow valid symbols
  s2 := SALT39.stringcleanspaces( SALT39.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_orig_subj5_company_name(SALT39.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT39.StringFilter(s,'5ABCEJMNOPSUY_ '))),~(LENGTH(TRIM(s)) = 0),~(SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 0));
EXPORT InValidMessageFT_orig_subj5_company_name(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.NotLeft,SALT39.HygieneErrors.NotInChars('5ABCEJMNOPSUY_ '),SALT39.HygieneErrors.NotLength('0'),SALT39.HygieneErrors.NotWords('0'),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_orig_subj5_fein(SALT39.StrType s0) := FUNCTION
  s1 := SALT39.stringfilter(s0,'5BEFIJNSU_ '); // Only allow valid symbols
  s2 := SALT39.stringcleanspaces( SALT39.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_orig_subj5_fein(SALT39.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT39.StringFilter(s,'5BEFIJNSU_ '))),~(LENGTH(TRIM(s)) = 0),~(SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 0));
EXPORT InValidMessageFT_orig_subj5_fein(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.NotLeft,SALT39.HygieneErrors.NotInChars('5BEFIJNSU_ '),SALT39.HygieneErrors.NotLength('0'),SALT39.HygieneErrors.NotWords('0'),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_orig_subj6_first_name(SALT39.StrType s0) := FUNCTION
  s1 := SALT39.stringfilter(s0,'6ABEFIJMNRSTU_ '); // Only allow valid symbols
  s2 := SALT39.stringcleanspaces( SALT39.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_orig_subj6_first_name(SALT39.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT39.StringFilter(s,'6ABEFIJMNRSTU_ '))),~(LENGTH(TRIM(s)) = 0),~(SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 0));
EXPORT InValidMessageFT_orig_subj6_first_name(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.NotLeft,SALT39.HygieneErrors.NotInChars('6ABEFIJMNRSTU_ '),SALT39.HygieneErrors.NotLength('0'),SALT39.HygieneErrors.NotWords('0'),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_orig_subj6_middle_name(SALT39.StrType s0) := FUNCTION
  s1 := SALT39.stringfilter(s0,'6ABDEIJLMNSU_ '); // Only allow valid symbols
  s2 := SALT39.stringcleanspaces( SALT39.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_orig_subj6_middle_name(SALT39.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT39.StringFilter(s,'6ABDEIJLMNSU_ '))),~(LENGTH(TRIM(s)) = 0),~(SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 0));
EXPORT InValidMessageFT_orig_subj6_middle_name(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.NotLeft,SALT39.HygieneErrors.NotInChars('6ABDEIJLMNSU_ '),SALT39.HygieneErrors.NotLength('0'),SALT39.HygieneErrors.NotWords('0'),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_orig_subj6_last_name(SALT39.StrType s0) := FUNCTION
  s1 := SALT39.stringfilter(s0,'6ABEJLMNSTU_ '); // Only allow valid symbols
  s2 := SALT39.stringcleanspaces( SALT39.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_orig_subj6_last_name(SALT39.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT39.StringFilter(s,'6ABEJLMNSTU_ '))),~(LENGTH(TRIM(s)) = 0),~(SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 0));
EXPORT InValidMessageFT_orig_subj6_last_name(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.NotLeft,SALT39.HygieneErrors.NotInChars('6ABEJLMNSTU_ '),SALT39.HygieneErrors.NotLength('0'),SALT39.HygieneErrors.NotWords('0'),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_orig_subj6_suffix_name(SALT39.StrType s0) := FUNCTION
  s1 := SALT39.stringfilter(s0,'6ABEFIJMNSUX_ '); // Only allow valid symbols
  s2 := SALT39.stringcleanspaces( SALT39.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_orig_subj6_suffix_name(SALT39.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT39.StringFilter(s,'6ABEFIJMNSUX_ '))),~(LENGTH(TRIM(s)) = 0),~(SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 0));
EXPORT InValidMessageFT_orig_subj6_suffix_name(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.NotLeft,SALT39.HygieneErrors.NotInChars('6ABEFIJMNSUX_ '),SALT39.HygieneErrors.NotLength('0'),SALT39.HygieneErrors.NotWords('0'),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_orig_subj6_full_name(SALT39.StrType s0) := FUNCTION
  s1 := SALT39.stringfilter(s0,'6ABEFJLMNSU_ '); // Only allow valid symbols
  s2 := SALT39.stringcleanspaces( SALT39.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_orig_subj6_full_name(SALT39.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT39.StringFilter(s,'6ABEFJLMNSU_ '))),~(LENGTH(TRIM(s)) = 0),~(SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 0));
EXPORT InValidMessageFT_orig_subj6_full_name(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.NotLeft,SALT39.HygieneErrors.NotInChars('6ABEFJLMNSU_ '),SALT39.HygieneErrors.NotLength('0'),SALT39.HygieneErrors.NotWords('0'),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_orig_subj6_ssn(SALT39.StrType s0) := FUNCTION
  s1 := SALT39.stringfilter(s0,'6BJNSU_ '); // Only allow valid symbols
  s2 := SALT39.stringcleanspaces( SALT39.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_orig_subj6_ssn(SALT39.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT39.StringFilter(s,'6BJNSU_ '))),~(LENGTH(TRIM(s)) = 0),~(SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 0));
EXPORT InValidMessageFT_orig_subj6_ssn(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.NotLeft,SALT39.HygieneErrors.NotInChars('6BJNSU_ '),SALT39.HygieneErrors.NotLength('0'),SALT39.HygieneErrors.NotWords('0'),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_orig_subj6_dob(SALT39.StrType s0) := FUNCTION
  s1 := SALT39.stringfilter(s0,'6BDJOSU_ '); // Only allow valid symbols
  s2 := SALT39.stringcleanspaces( SALT39.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_orig_subj6_dob(SALT39.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT39.StringFilter(s,'6BDJOSU_ '))),~(LENGTH(TRIM(s)) = 0),~(SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 0));
EXPORT InValidMessageFT_orig_subj6_dob(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.NotLeft,SALT39.HygieneErrors.NotInChars('6BDJOSU_ '),SALT39.HygieneErrors.NotLength('0'),SALT39.HygieneErrors.NotWords('0'),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_orig_subj6_dl_num(SALT39.StrType s0) := FUNCTION
  s1 := SALT39.stringfilter(s0,'6BDJLMNSU_ '); // Only allow valid symbols
  s2 := SALT39.stringcleanspaces( SALT39.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_orig_subj6_dl_num(SALT39.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT39.StringFilter(s,'6BDJLMNSU_ '))),~(LENGTH(TRIM(s)) = 0),~(SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 0));
EXPORT InValidMessageFT_orig_subj6_dl_num(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.NotLeft,SALT39.HygieneErrors.NotInChars('6BDJLMNSU_ '),SALT39.HygieneErrors.NotLength('0'),SALT39.HygieneErrors.NotWords('0'),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_orig_subj6_dl_state(SALT39.StrType s0) := FUNCTION
  s1 := SALT39.stringfilter(s0,'6ABDEJLSTU_ '); // Only allow valid symbols
  s2 := SALT39.stringcleanspaces( SALT39.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_orig_subj6_dl_state(SALT39.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT39.StringFilter(s,'6ABDEJLSTU_ '))),~(LENGTH(TRIM(s)) = 0),~(SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 0));
EXPORT InValidMessageFT_orig_subj6_dl_state(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.NotLeft,SALT39.HygieneErrors.NotInChars('6ABDEJLSTU_ '),SALT39.HygieneErrors.NotLength('0'),SALT39.HygieneErrors.NotWords('0'),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_orig_subj6_former_last_name(SALT39.StrType s0) := FUNCTION
  s1 := SALT39.stringfilter(s0,'6ABEFJLMNORSTU_ '); // Only allow valid symbols
  s2 := SALT39.stringcleanspaces( SALT39.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_orig_subj6_former_last_name(SALT39.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT39.StringFilter(s,'6ABEFJLMNORSTU_ '))),~(LENGTH(TRIM(s)) = 0),~(SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 0));
EXPORT InValidMessageFT_orig_subj6_former_last_name(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.NotLeft,SALT39.HygieneErrors.NotInChars('6ABEFJLMNORSTU_ '),SALT39.HygieneErrors.NotLength('0'),SALT39.HygieneErrors.NotWords('0'),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_orig_subj6_address_addressline1(SALT39.StrType s0) := FUNCTION
  s1 := SALT39.stringfilter(s0,'16ABDEIJLNRSU_ '); // Only allow valid symbols
  s2 := SALT39.stringcleanspaces( SALT39.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_orig_subj6_address_addressline1(SALT39.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT39.StringFilter(s,'16ABDEIJLNRSU_ '))),~(LENGTH(TRIM(s)) = 0),~(SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 0));
EXPORT InValidMessageFT_orig_subj6_address_addressline1(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.NotLeft,SALT39.HygieneErrors.NotInChars('16ABDEIJLNRSU_ '),SALT39.HygieneErrors.NotLength('0'),SALT39.HygieneErrors.NotWords('0'),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_orig_subj6_address_addressline2(SALT39.StrType s0) := FUNCTION
  s1 := SALT39.stringfilter(s0,'26ABDEIJLNRSU_ '); // Only allow valid symbols
  s2 := SALT39.stringcleanspaces( SALT39.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_orig_subj6_address_addressline2(SALT39.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT39.StringFilter(s,'26ABDEIJLNRSU_ '))),~(LENGTH(TRIM(s)) = 0),~(SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 0));
EXPORT InValidMessageFT_orig_subj6_address_addressline2(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.NotLeft,SALT39.HygieneErrors.NotInChars('26ABDEIJLNRSU_ '),SALT39.HygieneErrors.NotLength('0'),SALT39.HygieneErrors.NotWords('0'),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_orig_subj6_address_prim_range(SALT39.StrType s0) := FUNCTION
  s1 := SALT39.stringfilter(s0,'6ABDEGIJMNPRSU_ '); // Only allow valid symbols
  s2 := SALT39.stringcleanspaces( SALT39.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_orig_subj6_address_prim_range(SALT39.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT39.StringFilter(s,'6ABDEGIJMNPRSU_ '))),~(LENGTH(TRIM(s)) = 0),~(SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 0));
EXPORT InValidMessageFT_orig_subj6_address_prim_range(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.NotLeft,SALT39.HygieneErrors.NotInChars('6ABDEGIJMNPRSU_ '),SALT39.HygieneErrors.NotLength('0'),SALT39.HygieneErrors.NotWords('0'),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_orig_subj6_address_predir(SALT39.StrType s0) := FUNCTION
  s1 := SALT39.stringfilter(s0,'6ABDEIJPRSU_ '); // Only allow valid symbols
  s2 := SALT39.stringcleanspaces( SALT39.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_orig_subj6_address_predir(SALT39.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT39.StringFilter(s,'6ABDEIJPRSU_ '))),~(LENGTH(TRIM(s)) = 0),~(SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 0));
EXPORT InValidMessageFT_orig_subj6_address_predir(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.NotLeft,SALT39.HygieneErrors.NotInChars('6ABDEIJPRSU_ '),SALT39.HygieneErrors.NotLength('0'),SALT39.HygieneErrors.NotWords('0'),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_orig_subj6_address_prim_name(SALT39.StrType s0) := FUNCTION
  s1 := SALT39.stringfilter(s0,'6ABDEIJMNPRSU_ '); // Only allow valid symbols
  s2 := SALT39.stringcleanspaces( SALT39.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_orig_subj6_address_prim_name(SALT39.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT39.StringFilter(s,'6ABDEIJMNPRSU_ '))),~(LENGTH(TRIM(s)) = 0),~(SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 0));
EXPORT InValidMessageFT_orig_subj6_address_prim_name(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.NotLeft,SALT39.HygieneErrors.NotInChars('6ABDEIJMNPRSU_ '),SALT39.HygieneErrors.NotLength('0'),SALT39.HygieneErrors.NotWords('0'),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_orig_subj6_address_suffix(SALT39.StrType s0) := FUNCTION
  s1 := SALT39.stringfilter(s0,'6ABDEFIJRSUX_ '); // Only allow valid symbols
  s2 := SALT39.stringcleanspaces( SALT39.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_orig_subj6_address_suffix(SALT39.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT39.StringFilter(s,'6ABDEFIJRSUX_ '))),~(LENGTH(TRIM(s)) = 0),~(SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 0));
EXPORT InValidMessageFT_orig_subj6_address_suffix(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.NotLeft,SALT39.HygieneErrors.NotInChars('6ABDEFIJRSUX_ '),SALT39.HygieneErrors.NotLength('0'),SALT39.HygieneErrors.NotWords('0'),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_orig_subj6_address_postdir(SALT39.StrType s0) := FUNCTION
  s1 := SALT39.stringfilter(s0,'6ABDEIJOPRSTU_ '); // Only allow valid symbols
  s2 := SALT39.stringcleanspaces( SALT39.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_orig_subj6_address_postdir(SALT39.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT39.StringFilter(s,'6ABDEIJOPRSTU_ '))),~(LENGTH(TRIM(s)) = 0),~(SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 0));
EXPORT InValidMessageFT_orig_subj6_address_postdir(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.NotLeft,SALT39.HygieneErrors.NotInChars('6ABDEIJOPRSTU_ '),SALT39.HygieneErrors.NotLength('0'),SALT39.HygieneErrors.NotWords('0'),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_orig_subj6_address_unit_desig(SALT39.StrType s0) := FUNCTION
  s1 := SALT39.stringfilter(s0,'6ABDEGIJNRSTU_ '); // Only allow valid symbols
  s2 := SALT39.stringcleanspaces( SALT39.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_orig_subj6_address_unit_desig(SALT39.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT39.StringFilter(s,'6ABDEGIJNRSTU_ '))),~(LENGTH(TRIM(s)) = 0),~(SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 0));
EXPORT InValidMessageFT_orig_subj6_address_unit_desig(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.NotLeft,SALT39.HygieneErrors.NotInChars('6ABDEGIJNRSTU_ '),SALT39.HygieneErrors.NotLength('0'),SALT39.HygieneErrors.NotWords('0'),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_orig_subj6_address_sec_range(SALT39.StrType s0) := FUNCTION
  s1 := SALT39.stringfilter(s0,'6ABCDEGJNRSU_ '); // Only allow valid symbols
  s2 := SALT39.stringcleanspaces( SALT39.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_orig_subj6_address_sec_range(SALT39.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT39.StringFilter(s,'6ABCDEGJNRSU_ '))),~(LENGTH(TRIM(s)) = 0),~(SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 0));
EXPORT InValidMessageFT_orig_subj6_address_sec_range(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.NotLeft,SALT39.HygieneErrors.NotInChars('6ABCDEGJNRSU_ '),SALT39.HygieneErrors.NotLength('0'),SALT39.HygieneErrors.NotWords('0'),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_orig_subj6_address_city(SALT39.StrType s0) := FUNCTION
  s1 := SALT39.stringfilter(s0,'6ABCDEIJRSTUY_ '); // Only allow valid symbols
  s2 := SALT39.stringcleanspaces( SALT39.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_orig_subj6_address_city(SALT39.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT39.StringFilter(s,'6ABCDEIJRSTUY_ '))),~(LENGTH(TRIM(s)) = 0),~(SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 0));
EXPORT InValidMessageFT_orig_subj6_address_city(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.NotLeft,SALT39.HygieneErrors.NotInChars('6ABCDEIJRSTUY_ '),SALT39.HygieneErrors.NotLength('0'),SALT39.HygieneErrors.NotWords('0'),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_orig_subj6_address_st(SALT39.StrType s0) := FUNCTION
  s1 := SALT39.stringfilter(s0,'6ABDEJRSTU_ '); // Only allow valid symbols
  s2 := SALT39.stringcleanspaces( SALT39.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_orig_subj6_address_st(SALT39.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT39.StringFilter(s,'6ABDEJRSTU_ '))),~(LENGTH(TRIM(s)) = 0),~(SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 0));
EXPORT InValidMessageFT_orig_subj6_address_st(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.NotLeft,SALT39.HygieneErrors.NotInChars('6ABDEJRSTU_ '),SALT39.HygieneErrors.NotLength('0'),SALT39.HygieneErrors.NotWords('0'),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_orig_subj6_address_z5(SALT39.StrType s0) := FUNCTION
  s1 := SALT39.stringfilter(s0,'56ABDEJRSUZ_ '); // Only allow valid symbols
  s2 := SALT39.stringcleanspaces( SALT39.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_orig_subj6_address_z5(SALT39.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT39.StringFilter(s,'56ABDEJRSUZ_ '))),~(LENGTH(TRIM(s)) = 0),~(SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 0));
EXPORT InValidMessageFT_orig_subj6_address_z5(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.NotLeft,SALT39.HygieneErrors.NotInChars('56ABDEJRSUZ_ '),SALT39.HygieneErrors.NotLength('0'),SALT39.HygieneErrors.NotWords('0'),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_orig_subj6_address_z4(SALT39.StrType s0) := FUNCTION
  s1 := SALT39.stringfilter(s0,'46ABDEJRSUZ_ '); // Only allow valid symbols
  s2 := SALT39.stringcleanspaces( SALT39.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_orig_subj6_address_z4(SALT39.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT39.StringFilter(s,'46ABDEJRSUZ_ '))),~(LENGTH(TRIM(s)) = 0),~(SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 0));
EXPORT InValidMessageFT_orig_subj6_address_z4(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.NotLeft,SALT39.HygieneErrors.NotInChars('46ABDEJRSUZ_ '),SALT39.HygieneErrors.NotLength('0'),SALT39.HygieneErrors.NotWords('0'),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_orig_subj6_phone(SALT39.StrType s0) := FUNCTION
  s1 := SALT39.stringfilter(s0,'6BEHJNOPSU_ '); // Only allow valid symbols
  s2 := SALT39.stringcleanspaces( SALT39.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_orig_subj6_phone(SALT39.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT39.StringFilter(s,'6BEHJNOPSU_ '))),~(LENGTH(TRIM(s)) = 0),~(SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 0));
EXPORT InValidMessageFT_orig_subj6_phone(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.NotLeft,SALT39.HygieneErrors.NotInChars('6BEHJNOPSU_ '),SALT39.HygieneErrors.NotLength('0'),SALT39.HygieneErrors.NotWords('0'),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_orig_subj6_work_phone(SALT39.StrType s0) := FUNCTION
  s1 := SALT39.stringfilter(s0,'6BEHJKNOPRSUW_ '); // Only allow valid symbols
  s2 := SALT39.stringcleanspaces( SALT39.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_orig_subj6_work_phone(SALT39.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT39.StringFilter(s,'6BEHJKNOPRSUW_ '))),~(LENGTH(TRIM(s)) = 0),~(SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 0));
EXPORT InValidMessageFT_orig_subj6_work_phone(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.NotLeft,SALT39.HygieneErrors.NotInChars('6BEHJKNOPRSUW_ '),SALT39.HygieneErrors.NotLength('0'),SALT39.HygieneErrors.NotWords('0'),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_orig_subj6_business_title(SALT39.StrType s0) := FUNCTION
  s1 := SALT39.stringfilter(s0,'6BEIJLNSTU_ '); // Only allow valid symbols
  s2 := SALT39.stringcleanspaces( SALT39.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_orig_subj6_business_title(SALT39.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT39.StringFilter(s,'6BEIJLNSTU_ '))),~(LENGTH(TRIM(s)) = 0),~(SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 0));
EXPORT InValidMessageFT_orig_subj6_business_title(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.NotLeft,SALT39.HygieneErrors.NotInChars('6BEIJLNSTU_ '),SALT39.HygieneErrors.NotLength('0'),SALT39.HygieneErrors.NotWords('0'),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_orig_subj6_email(SALT39.StrType s0) := FUNCTION
  s1 := SALT39.stringfilter(s0,'6ABEIJLMSU_ '); // Only allow valid symbols
  s2 := SALT39.stringcleanspaces( SALT39.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_orig_subj6_email(SALT39.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT39.StringFilter(s,'6ABEIJLMSU_ '))),~(LENGTH(TRIM(s)) = 0),~(SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 0));
EXPORT InValidMessageFT_orig_subj6_email(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.NotLeft,SALT39.HygieneErrors.NotInChars('6ABEIJLMSU_ '),SALT39.HygieneErrors.NotLength('0'),SALT39.HygieneErrors.NotWords('0'),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_orig_subj6_company_name(SALT39.StrType s0) := FUNCTION
  s1 := SALT39.stringfilter(s0,'6ABCEJMNOPSUY_ '); // Only allow valid symbols
  s2 := SALT39.stringcleanspaces( SALT39.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_orig_subj6_company_name(SALT39.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT39.StringFilter(s,'6ABCEJMNOPSUY_ '))),~(LENGTH(TRIM(s)) = 0),~(SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 0));
EXPORT InValidMessageFT_orig_subj6_company_name(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.NotLeft,SALT39.HygieneErrors.NotInChars('6ABCEJMNOPSUY_ '),SALT39.HygieneErrors.NotLength('0'),SALT39.HygieneErrors.NotWords('0'),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_orig_subj6_fein(SALT39.StrType s0) := FUNCTION
  s1 := SALT39.stringfilter(s0,'6BEFIJNSU_ '); // Only allow valid symbols
  s2 := SALT39.stringcleanspaces( SALT39.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_orig_subj6_fein(SALT39.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT39.StringFilter(s,'6BEFIJNSU_ '))),~(LENGTH(TRIM(s)) = 0),~(SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 0));
EXPORT InValidMessageFT_orig_subj6_fein(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.NotLeft,SALT39.HygieneErrors.NotInChars('6BEFIJNSU_ '),SALT39.HygieneErrors.NotLength('0'),SALT39.HygieneErrors.NotWords('0'),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_orig_subj7_first_name(SALT39.StrType s0) := FUNCTION
  s1 := SALT39.stringfilter(s0,'7ABEFIJMNRSTU_ '); // Only allow valid symbols
  s2 := SALT39.stringcleanspaces( SALT39.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_orig_subj7_first_name(SALT39.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT39.StringFilter(s,'7ABEFIJMNRSTU_ '))),~(LENGTH(TRIM(s)) = 0),~(SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 0));
EXPORT InValidMessageFT_orig_subj7_first_name(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.NotLeft,SALT39.HygieneErrors.NotInChars('7ABEFIJMNRSTU_ '),SALT39.HygieneErrors.NotLength('0'),SALT39.HygieneErrors.NotWords('0'),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_orig_subj7_middle_name(SALT39.StrType s0) := FUNCTION
  s1 := SALT39.stringfilter(s0,'7ABDEIJLMNSU_ '); // Only allow valid symbols
  s2 := SALT39.stringcleanspaces( SALT39.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_orig_subj7_middle_name(SALT39.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT39.StringFilter(s,'7ABDEIJLMNSU_ '))),~(LENGTH(TRIM(s)) = 0),~(SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 0));
EXPORT InValidMessageFT_orig_subj7_middle_name(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.NotLeft,SALT39.HygieneErrors.NotInChars('7ABDEIJLMNSU_ '),SALT39.HygieneErrors.NotLength('0'),SALT39.HygieneErrors.NotWords('0'),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_orig_subj7_last_name(SALT39.StrType s0) := FUNCTION
  s1 := SALT39.stringfilter(s0,'7ABEJLMNSTU_ '); // Only allow valid symbols
  s2 := SALT39.stringcleanspaces( SALT39.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_orig_subj7_last_name(SALT39.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT39.StringFilter(s,'7ABEJLMNSTU_ '))),~(LENGTH(TRIM(s)) = 0),~(SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 0));
EXPORT InValidMessageFT_orig_subj7_last_name(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.NotLeft,SALT39.HygieneErrors.NotInChars('7ABEJLMNSTU_ '),SALT39.HygieneErrors.NotLength('0'),SALT39.HygieneErrors.NotWords('0'),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_orig_subj7_suffix_name(SALT39.StrType s0) := FUNCTION
  s1 := SALT39.stringfilter(s0,'7ABEFIJMNSUX_ '); // Only allow valid symbols
  s2 := SALT39.stringcleanspaces( SALT39.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_orig_subj7_suffix_name(SALT39.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT39.StringFilter(s,'7ABEFIJMNSUX_ '))),~(LENGTH(TRIM(s)) = 0),~(SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 0));
EXPORT InValidMessageFT_orig_subj7_suffix_name(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.NotLeft,SALT39.HygieneErrors.NotInChars('7ABEFIJMNSUX_ '),SALT39.HygieneErrors.NotLength('0'),SALT39.HygieneErrors.NotWords('0'),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_orig_subj7_full_name(SALT39.StrType s0) := FUNCTION
  s1 := SALT39.stringfilter(s0,'7ABEFJLMNSU_ '); // Only allow valid symbols
  s2 := SALT39.stringcleanspaces( SALT39.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_orig_subj7_full_name(SALT39.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT39.StringFilter(s,'7ABEFJLMNSU_ '))),~(LENGTH(TRIM(s)) = 0),~(SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 0));
EXPORT InValidMessageFT_orig_subj7_full_name(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.NotLeft,SALT39.HygieneErrors.NotInChars('7ABEFJLMNSU_ '),SALT39.HygieneErrors.NotLength('0'),SALT39.HygieneErrors.NotWords('0'),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_orig_subj7_ssn(SALT39.StrType s0) := FUNCTION
  s1 := SALT39.stringfilter(s0,'7BJNSU_ '); // Only allow valid symbols
  s2 := SALT39.stringcleanspaces( SALT39.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_orig_subj7_ssn(SALT39.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT39.StringFilter(s,'7BJNSU_ '))),~(LENGTH(TRIM(s)) = 0),~(SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 0));
EXPORT InValidMessageFT_orig_subj7_ssn(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.NotLeft,SALT39.HygieneErrors.NotInChars('7BJNSU_ '),SALT39.HygieneErrors.NotLength('0'),SALT39.HygieneErrors.NotWords('0'),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_orig_subj7_dob(SALT39.StrType s0) := FUNCTION
  s1 := SALT39.stringfilter(s0,'7BDJOSU_ '); // Only allow valid symbols
  s2 := SALT39.stringcleanspaces( SALT39.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_orig_subj7_dob(SALT39.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT39.StringFilter(s,'7BDJOSU_ '))),~(LENGTH(TRIM(s)) = 0),~(SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 0));
EXPORT InValidMessageFT_orig_subj7_dob(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.NotLeft,SALT39.HygieneErrors.NotInChars('7BDJOSU_ '),SALT39.HygieneErrors.NotLength('0'),SALT39.HygieneErrors.NotWords('0'),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_orig_subj7_dl_num(SALT39.StrType s0) := FUNCTION
  s1 := SALT39.stringfilter(s0,'7BDJLMNSU_ '); // Only allow valid symbols
  s2 := SALT39.stringcleanspaces( SALT39.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_orig_subj7_dl_num(SALT39.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT39.StringFilter(s,'7BDJLMNSU_ '))),~(LENGTH(TRIM(s)) = 0),~(SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 0));
EXPORT InValidMessageFT_orig_subj7_dl_num(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.NotLeft,SALT39.HygieneErrors.NotInChars('7BDJLMNSU_ '),SALT39.HygieneErrors.NotLength('0'),SALT39.HygieneErrors.NotWords('0'),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_orig_subj7_dl_state(SALT39.StrType s0) := FUNCTION
  s1 := SALT39.stringfilter(s0,'7ABDEJLSTU_ '); // Only allow valid symbols
  s2 := SALT39.stringcleanspaces( SALT39.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_orig_subj7_dl_state(SALT39.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT39.StringFilter(s,'7ABDEJLSTU_ '))),~(LENGTH(TRIM(s)) = 0),~(SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 0));
EXPORT InValidMessageFT_orig_subj7_dl_state(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.NotLeft,SALT39.HygieneErrors.NotInChars('7ABDEJLSTU_ '),SALT39.HygieneErrors.NotLength('0'),SALT39.HygieneErrors.NotWords('0'),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_orig_subj7_former_last_name(SALT39.StrType s0) := FUNCTION
  s1 := SALT39.stringfilter(s0,'7ABEFJLMNORSTU_ '); // Only allow valid symbols
  s2 := SALT39.stringcleanspaces( SALT39.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_orig_subj7_former_last_name(SALT39.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT39.StringFilter(s,'7ABEFJLMNORSTU_ '))),~(LENGTH(TRIM(s)) = 0),~(SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 0));
EXPORT InValidMessageFT_orig_subj7_former_last_name(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.NotLeft,SALT39.HygieneErrors.NotInChars('7ABEFJLMNORSTU_ '),SALT39.HygieneErrors.NotLength('0'),SALT39.HygieneErrors.NotWords('0'),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_orig_subj7_address_addressline1(SALT39.StrType s0) := FUNCTION
  s1 := SALT39.stringfilter(s0,'17ABDEIJLNRSU_ '); // Only allow valid symbols
  s2 := SALT39.stringcleanspaces( SALT39.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_orig_subj7_address_addressline1(SALT39.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT39.StringFilter(s,'17ABDEIJLNRSU_ '))),~(LENGTH(TRIM(s)) = 0),~(SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 0));
EXPORT InValidMessageFT_orig_subj7_address_addressline1(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.NotLeft,SALT39.HygieneErrors.NotInChars('17ABDEIJLNRSU_ '),SALT39.HygieneErrors.NotLength('0'),SALT39.HygieneErrors.NotWords('0'),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_orig_subj7_address_addressline2(SALT39.StrType s0) := FUNCTION
  s1 := SALT39.stringfilter(s0,'27ABDEIJLNRSU_ '); // Only allow valid symbols
  s2 := SALT39.stringcleanspaces( SALT39.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_orig_subj7_address_addressline2(SALT39.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT39.StringFilter(s,'27ABDEIJLNRSU_ '))),~(LENGTH(TRIM(s)) = 0),~(SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 0));
EXPORT InValidMessageFT_orig_subj7_address_addressline2(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.NotLeft,SALT39.HygieneErrors.NotInChars('27ABDEIJLNRSU_ '),SALT39.HygieneErrors.NotLength('0'),SALT39.HygieneErrors.NotWords('0'),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_orig_subj7_address_prim_range(SALT39.StrType s0) := FUNCTION
  s1 := SALT39.stringfilter(s0,'7ABDEGIJMNPRSU_ '); // Only allow valid symbols
  s2 := SALT39.stringcleanspaces( SALT39.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_orig_subj7_address_prim_range(SALT39.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT39.StringFilter(s,'7ABDEGIJMNPRSU_ '))),~(LENGTH(TRIM(s)) = 0),~(SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 0));
EXPORT InValidMessageFT_orig_subj7_address_prim_range(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.NotLeft,SALT39.HygieneErrors.NotInChars('7ABDEGIJMNPRSU_ '),SALT39.HygieneErrors.NotLength('0'),SALT39.HygieneErrors.NotWords('0'),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_orig_subj7_address_predir(SALT39.StrType s0) := FUNCTION
  s1 := SALT39.stringfilter(s0,'7ABDEIJPRSU_ '); // Only allow valid symbols
  s2 := SALT39.stringcleanspaces( SALT39.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_orig_subj7_address_predir(SALT39.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT39.StringFilter(s,'7ABDEIJPRSU_ '))),~(LENGTH(TRIM(s)) = 0),~(SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 0));
EXPORT InValidMessageFT_orig_subj7_address_predir(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.NotLeft,SALT39.HygieneErrors.NotInChars('7ABDEIJPRSU_ '),SALT39.HygieneErrors.NotLength('0'),SALT39.HygieneErrors.NotWords('0'),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_orig_subj7_address_prim_name(SALT39.StrType s0) := FUNCTION
  s1 := SALT39.stringfilter(s0,'7ABDEIJMNPRSU_ '); // Only allow valid symbols
  s2 := SALT39.stringcleanspaces( SALT39.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_orig_subj7_address_prim_name(SALT39.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT39.StringFilter(s,'7ABDEIJMNPRSU_ '))),~(LENGTH(TRIM(s)) = 0),~(SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 0));
EXPORT InValidMessageFT_orig_subj7_address_prim_name(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.NotLeft,SALT39.HygieneErrors.NotInChars('7ABDEIJMNPRSU_ '),SALT39.HygieneErrors.NotLength('0'),SALT39.HygieneErrors.NotWords('0'),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_orig_subj7_address_suffix(SALT39.StrType s0) := FUNCTION
  s1 := SALT39.stringfilter(s0,'7ABDEFIJRSUX_ '); // Only allow valid symbols
  s2 := SALT39.stringcleanspaces( SALT39.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_orig_subj7_address_suffix(SALT39.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT39.StringFilter(s,'7ABDEFIJRSUX_ '))),~(LENGTH(TRIM(s)) = 0),~(SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 0));
EXPORT InValidMessageFT_orig_subj7_address_suffix(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.NotLeft,SALT39.HygieneErrors.NotInChars('7ABDEFIJRSUX_ '),SALT39.HygieneErrors.NotLength('0'),SALT39.HygieneErrors.NotWords('0'),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_orig_subj7_address_postdir(SALT39.StrType s0) := FUNCTION
  s1 := SALT39.stringfilter(s0,'7ABDEIJOPRSTU_ '); // Only allow valid symbols
  s2 := SALT39.stringcleanspaces( SALT39.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_orig_subj7_address_postdir(SALT39.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT39.StringFilter(s,'7ABDEIJOPRSTU_ '))),~(LENGTH(TRIM(s)) = 0),~(SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 0));
EXPORT InValidMessageFT_orig_subj7_address_postdir(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.NotLeft,SALT39.HygieneErrors.NotInChars('7ABDEIJOPRSTU_ '),SALT39.HygieneErrors.NotLength('0'),SALT39.HygieneErrors.NotWords('0'),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_orig_subj7_address_unit_desig(SALT39.StrType s0) := FUNCTION
  s1 := SALT39.stringfilter(s0,'7ABDEGIJNRSTU_ '); // Only allow valid symbols
  s2 := SALT39.stringcleanspaces( SALT39.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_orig_subj7_address_unit_desig(SALT39.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT39.StringFilter(s,'7ABDEGIJNRSTU_ '))),~(LENGTH(TRIM(s)) = 0),~(SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 0));
EXPORT InValidMessageFT_orig_subj7_address_unit_desig(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.NotLeft,SALT39.HygieneErrors.NotInChars('7ABDEGIJNRSTU_ '),SALT39.HygieneErrors.NotLength('0'),SALT39.HygieneErrors.NotWords('0'),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_orig_subj7_address_sec_range(SALT39.StrType s0) := FUNCTION
  s1 := SALT39.stringfilter(s0,'7ABCDEGJNRSU_ '); // Only allow valid symbols
  s2 := SALT39.stringcleanspaces( SALT39.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_orig_subj7_address_sec_range(SALT39.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT39.StringFilter(s,'7ABCDEGJNRSU_ '))),~(LENGTH(TRIM(s)) = 0),~(SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 0));
EXPORT InValidMessageFT_orig_subj7_address_sec_range(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.NotLeft,SALT39.HygieneErrors.NotInChars('7ABCDEGJNRSU_ '),SALT39.HygieneErrors.NotLength('0'),SALT39.HygieneErrors.NotWords('0'),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_orig_subj7_address_city(SALT39.StrType s0) := FUNCTION
  s1 := SALT39.stringfilter(s0,'7ABCDEIJRSTUY_ '); // Only allow valid symbols
  s2 := SALT39.stringcleanspaces( SALT39.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_orig_subj7_address_city(SALT39.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT39.StringFilter(s,'7ABCDEIJRSTUY_ '))),~(LENGTH(TRIM(s)) = 0),~(SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 0));
EXPORT InValidMessageFT_orig_subj7_address_city(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.NotLeft,SALT39.HygieneErrors.NotInChars('7ABCDEIJRSTUY_ '),SALT39.HygieneErrors.NotLength('0'),SALT39.HygieneErrors.NotWords('0'),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_orig_subj7_address_st(SALT39.StrType s0) := FUNCTION
  s1 := SALT39.stringfilter(s0,'7ABDEJRSTU_ '); // Only allow valid symbols
  s2 := SALT39.stringcleanspaces( SALT39.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_orig_subj7_address_st(SALT39.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT39.StringFilter(s,'7ABDEJRSTU_ '))),~(LENGTH(TRIM(s)) = 0),~(SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 0));
EXPORT InValidMessageFT_orig_subj7_address_st(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.NotLeft,SALT39.HygieneErrors.NotInChars('7ABDEJRSTU_ '),SALT39.HygieneErrors.NotLength('0'),SALT39.HygieneErrors.NotWords('0'),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_orig_subj7_address_z5(SALT39.StrType s0) := FUNCTION
  s1 := SALT39.stringfilter(s0,'57ABDEJRSUZ_ '); // Only allow valid symbols
  s2 := SALT39.stringcleanspaces( SALT39.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_orig_subj7_address_z5(SALT39.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT39.StringFilter(s,'57ABDEJRSUZ_ '))),~(LENGTH(TRIM(s)) = 0),~(SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 0));
EXPORT InValidMessageFT_orig_subj7_address_z5(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.NotLeft,SALT39.HygieneErrors.NotInChars('57ABDEJRSUZ_ '),SALT39.HygieneErrors.NotLength('0'),SALT39.HygieneErrors.NotWords('0'),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_orig_subj7_address_z4(SALT39.StrType s0) := FUNCTION
  s1 := SALT39.stringfilter(s0,'47ABDEJRSUZ_ '); // Only allow valid symbols
  s2 := SALT39.stringcleanspaces( SALT39.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_orig_subj7_address_z4(SALT39.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT39.StringFilter(s,'47ABDEJRSUZ_ '))),~(LENGTH(TRIM(s)) = 0),~(SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 0));
EXPORT InValidMessageFT_orig_subj7_address_z4(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.NotLeft,SALT39.HygieneErrors.NotInChars('47ABDEJRSUZ_ '),SALT39.HygieneErrors.NotLength('0'),SALT39.HygieneErrors.NotWords('0'),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_orig_subj7_phone(SALT39.StrType s0) := FUNCTION
  s1 := SALT39.stringfilter(s0,'7BEHJNOPSU_ '); // Only allow valid symbols
  s2 := SALT39.stringcleanspaces( SALT39.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_orig_subj7_phone(SALT39.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT39.StringFilter(s,'7BEHJNOPSU_ '))),~(LENGTH(TRIM(s)) = 0),~(SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 0));
EXPORT InValidMessageFT_orig_subj7_phone(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.NotLeft,SALT39.HygieneErrors.NotInChars('7BEHJNOPSU_ '),SALT39.HygieneErrors.NotLength('0'),SALT39.HygieneErrors.NotWords('0'),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_orig_subj7_work_phone(SALT39.StrType s0) := FUNCTION
  s1 := SALT39.stringfilter(s0,'7BEHJKNOPRSUW_ '); // Only allow valid symbols
  s2 := SALT39.stringcleanspaces( SALT39.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_orig_subj7_work_phone(SALT39.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT39.StringFilter(s,'7BEHJKNOPRSUW_ '))),~(LENGTH(TRIM(s)) = 0),~(SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 0));
EXPORT InValidMessageFT_orig_subj7_work_phone(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.NotLeft,SALT39.HygieneErrors.NotInChars('7BEHJKNOPRSUW_ '),SALT39.HygieneErrors.NotLength('0'),SALT39.HygieneErrors.NotWords('0'),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_orig_subj7_business_title(SALT39.StrType s0) := FUNCTION
  s1 := SALT39.stringfilter(s0,'7BEIJLNSTU_ '); // Only allow valid symbols
  s2 := SALT39.stringcleanspaces( SALT39.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_orig_subj7_business_title(SALT39.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT39.StringFilter(s,'7BEIJLNSTU_ '))),~(LENGTH(TRIM(s)) = 0),~(SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 0));
EXPORT InValidMessageFT_orig_subj7_business_title(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.NotLeft,SALT39.HygieneErrors.NotInChars('7BEIJLNSTU_ '),SALT39.HygieneErrors.NotLength('0'),SALT39.HygieneErrors.NotWords('0'),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_orig_subj7_email(SALT39.StrType s0) := FUNCTION
  s1 := SALT39.stringfilter(s0,'7ABEIJLMSU_ '); // Only allow valid symbols
  s2 := SALT39.stringcleanspaces( SALT39.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_orig_subj7_email(SALT39.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT39.StringFilter(s,'7ABEIJLMSU_ '))),~(LENGTH(TRIM(s)) = 0),~(SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 0));
EXPORT InValidMessageFT_orig_subj7_email(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.NotLeft,SALT39.HygieneErrors.NotInChars('7ABEIJLMSU_ '),SALT39.HygieneErrors.NotLength('0'),SALT39.HygieneErrors.NotWords('0'),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_orig_subj7_company_name(SALT39.StrType s0) := FUNCTION
  s1 := SALT39.stringfilter(s0,'7ABCEJMNOPSUY_ '); // Only allow valid symbols
  s2 := SALT39.stringcleanspaces( SALT39.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_orig_subj7_company_name(SALT39.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT39.StringFilter(s,'7ABCEJMNOPSUY_ '))),~(LENGTH(TRIM(s)) = 0),~(SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 0));
EXPORT InValidMessageFT_orig_subj7_company_name(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.NotLeft,SALT39.HygieneErrors.NotInChars('7ABCEJMNOPSUY_ '),SALT39.HygieneErrors.NotLength('0'),SALT39.HygieneErrors.NotWords('0'),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_orig_subj7_fein(SALT39.StrType s0) := FUNCTION
  s1 := SALT39.stringfilter(s0,'7BEFIJNSU_ '); // Only allow valid symbols
  s2 := SALT39.stringcleanspaces( SALT39.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_orig_subj7_fein(SALT39.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT39.StringFilter(s,'7BEFIJNSU_ '))),~(LENGTH(TRIM(s)) = 0),~(SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 0));
EXPORT InValidMessageFT_orig_subj7_fein(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.NotLeft,SALT39.HygieneErrors.NotInChars('7BEFIJNSU_ '),SALT39.HygieneErrors.NotLength('0'),SALT39.HygieneErrors.NotWords('0'),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_orig_subj8_first_name(SALT39.StrType s0) := FUNCTION
  s1 := SALT39.stringfilter(s0,'8ABEFIJMNRSTU_ '); // Only allow valid symbols
  s2 := SALT39.stringcleanspaces( SALT39.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_orig_subj8_first_name(SALT39.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT39.StringFilter(s,'8ABEFIJMNRSTU_ '))),~(LENGTH(TRIM(s)) = 0),~(SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 0));
EXPORT InValidMessageFT_orig_subj8_first_name(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.NotLeft,SALT39.HygieneErrors.NotInChars('8ABEFIJMNRSTU_ '),SALT39.HygieneErrors.NotLength('0'),SALT39.HygieneErrors.NotWords('0'),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_orig_subj8_middle_name(SALT39.StrType s0) := FUNCTION
  s1 := SALT39.stringfilter(s0,'8ABDEIJLMNSU_ '); // Only allow valid symbols
  s2 := SALT39.stringcleanspaces( SALT39.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_orig_subj8_middle_name(SALT39.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT39.StringFilter(s,'8ABDEIJLMNSU_ '))),~(LENGTH(TRIM(s)) = 0),~(SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 0));
EXPORT InValidMessageFT_orig_subj8_middle_name(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.NotLeft,SALT39.HygieneErrors.NotInChars('8ABDEIJLMNSU_ '),SALT39.HygieneErrors.NotLength('0'),SALT39.HygieneErrors.NotWords('0'),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_orig_subj8_last_name(SALT39.StrType s0) := FUNCTION
  s1 := SALT39.stringfilter(s0,'8ABEJLMNSTU_ '); // Only allow valid symbols
  s2 := SALT39.stringcleanspaces( SALT39.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_orig_subj8_last_name(SALT39.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT39.StringFilter(s,'8ABEJLMNSTU_ '))),~(LENGTH(TRIM(s)) = 0),~(SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 0));
EXPORT InValidMessageFT_orig_subj8_last_name(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.NotLeft,SALT39.HygieneErrors.NotInChars('8ABEJLMNSTU_ '),SALT39.HygieneErrors.NotLength('0'),SALT39.HygieneErrors.NotWords('0'),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_orig_subj8_suffix_name(SALT39.StrType s0) := FUNCTION
  s1 := SALT39.stringfilter(s0,'8ABEFIJMNSUX_ '); // Only allow valid symbols
  s2 := SALT39.stringcleanspaces( SALT39.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_orig_subj8_suffix_name(SALT39.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT39.StringFilter(s,'8ABEFIJMNSUX_ '))),~(LENGTH(TRIM(s)) = 0),~(SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 0));
EXPORT InValidMessageFT_orig_subj8_suffix_name(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.NotLeft,SALT39.HygieneErrors.NotInChars('8ABEFIJMNSUX_ '),SALT39.HygieneErrors.NotLength('0'),SALT39.HygieneErrors.NotWords('0'),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_orig_subj8_full_name(SALT39.StrType s0) := FUNCTION
  s1 := SALT39.stringfilter(s0,'8ABEFJLMNSU_ '); // Only allow valid symbols
  s2 := SALT39.stringcleanspaces( SALT39.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_orig_subj8_full_name(SALT39.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT39.StringFilter(s,'8ABEFJLMNSU_ '))),~(LENGTH(TRIM(s)) = 0),~(SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 0));
EXPORT InValidMessageFT_orig_subj8_full_name(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.NotLeft,SALT39.HygieneErrors.NotInChars('8ABEFJLMNSU_ '),SALT39.HygieneErrors.NotLength('0'),SALT39.HygieneErrors.NotWords('0'),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_orig_subj8_ssn(SALT39.StrType s0) := FUNCTION
  s1 := SALT39.stringfilter(s0,'8BJNSU_ '); // Only allow valid symbols
  s2 := SALT39.stringcleanspaces( SALT39.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_orig_subj8_ssn(SALT39.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT39.StringFilter(s,'8BJNSU_ '))),~(LENGTH(TRIM(s)) = 0),~(SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 0));
EXPORT InValidMessageFT_orig_subj8_ssn(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.NotLeft,SALT39.HygieneErrors.NotInChars('8BJNSU_ '),SALT39.HygieneErrors.NotLength('0'),SALT39.HygieneErrors.NotWords('0'),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_orig_subj8_dob(SALT39.StrType s0) := FUNCTION
  s1 := SALT39.stringfilter(s0,'8BDJOSU_ '); // Only allow valid symbols
  s2 := SALT39.stringcleanspaces( SALT39.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_orig_subj8_dob(SALT39.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT39.StringFilter(s,'8BDJOSU_ '))),~(LENGTH(TRIM(s)) = 0),~(SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 0));
EXPORT InValidMessageFT_orig_subj8_dob(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.NotLeft,SALT39.HygieneErrors.NotInChars('8BDJOSU_ '),SALT39.HygieneErrors.NotLength('0'),SALT39.HygieneErrors.NotWords('0'),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_orig_subj8_dl_num(SALT39.StrType s0) := FUNCTION
  s1 := SALT39.stringfilter(s0,'8BDJLMNSU_ '); // Only allow valid symbols
  s2 := SALT39.stringcleanspaces( SALT39.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_orig_subj8_dl_num(SALT39.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT39.StringFilter(s,'8BDJLMNSU_ '))),~(LENGTH(TRIM(s)) = 0),~(SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 0));
EXPORT InValidMessageFT_orig_subj8_dl_num(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.NotLeft,SALT39.HygieneErrors.NotInChars('8BDJLMNSU_ '),SALT39.HygieneErrors.NotLength('0'),SALT39.HygieneErrors.NotWords('0'),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_orig_subj8_dl_state(SALT39.StrType s0) := FUNCTION
  s1 := SALT39.stringfilter(s0,'8ABDEJLSTU_ '); // Only allow valid symbols
  s2 := SALT39.stringcleanspaces( SALT39.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_orig_subj8_dl_state(SALT39.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT39.StringFilter(s,'8ABDEJLSTU_ '))),~(LENGTH(TRIM(s)) = 0),~(SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 0));
EXPORT InValidMessageFT_orig_subj8_dl_state(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.NotLeft,SALT39.HygieneErrors.NotInChars('8ABDEJLSTU_ '),SALT39.HygieneErrors.NotLength('0'),SALT39.HygieneErrors.NotWords('0'),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_orig_subj8_former_last_name(SALT39.StrType s0) := FUNCTION
  s1 := SALT39.stringfilter(s0,'8ABEFJLMNORSTU_ '); // Only allow valid symbols
  s2 := SALT39.stringcleanspaces( SALT39.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_orig_subj8_former_last_name(SALT39.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT39.StringFilter(s,'8ABEFJLMNORSTU_ '))),~(LENGTH(TRIM(s)) = 0),~(SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 0));
EXPORT InValidMessageFT_orig_subj8_former_last_name(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.NotLeft,SALT39.HygieneErrors.NotInChars('8ABEFJLMNORSTU_ '),SALT39.HygieneErrors.NotLength('0'),SALT39.HygieneErrors.NotWords('0'),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_orig_subj8_address_addressline1(SALT39.StrType s0) := FUNCTION
  s1 := SALT39.stringfilter(s0,'18ABDEIJLNRSU_ '); // Only allow valid symbols
  s2 := SALT39.stringcleanspaces( SALT39.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_orig_subj8_address_addressline1(SALT39.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT39.StringFilter(s,'18ABDEIJLNRSU_ '))),~(LENGTH(TRIM(s)) = 0),~(SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 0));
EXPORT InValidMessageFT_orig_subj8_address_addressline1(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.NotLeft,SALT39.HygieneErrors.NotInChars('18ABDEIJLNRSU_ '),SALT39.HygieneErrors.NotLength('0'),SALT39.HygieneErrors.NotWords('0'),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_orig_subj8_address_addressline2(SALT39.StrType s0) := FUNCTION
  s1 := SALT39.stringfilter(s0,'28ABDEIJLNRSU_ '); // Only allow valid symbols
  s2 := SALT39.stringcleanspaces( SALT39.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_orig_subj8_address_addressline2(SALT39.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT39.StringFilter(s,'28ABDEIJLNRSU_ '))),~(LENGTH(TRIM(s)) = 0),~(SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 0));
EXPORT InValidMessageFT_orig_subj8_address_addressline2(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.NotLeft,SALT39.HygieneErrors.NotInChars('28ABDEIJLNRSU_ '),SALT39.HygieneErrors.NotLength('0'),SALT39.HygieneErrors.NotWords('0'),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_orig_subj8_address_prim_range(SALT39.StrType s0) := FUNCTION
  s1 := SALT39.stringfilter(s0,'8ABDEGIJMNPRSU_ '); // Only allow valid symbols
  s2 := SALT39.stringcleanspaces( SALT39.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_orig_subj8_address_prim_range(SALT39.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT39.StringFilter(s,'8ABDEGIJMNPRSU_ '))),~(LENGTH(TRIM(s)) = 0),~(SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 0));
EXPORT InValidMessageFT_orig_subj8_address_prim_range(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.NotLeft,SALT39.HygieneErrors.NotInChars('8ABDEGIJMNPRSU_ '),SALT39.HygieneErrors.NotLength('0'),SALT39.HygieneErrors.NotWords('0'),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_orig_subj8_address_predir(SALT39.StrType s0) := FUNCTION
  s1 := SALT39.stringfilter(s0,'8ABDEIJPRSU_ '); // Only allow valid symbols
  s2 := SALT39.stringcleanspaces( SALT39.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_orig_subj8_address_predir(SALT39.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT39.StringFilter(s,'8ABDEIJPRSU_ '))),~(LENGTH(TRIM(s)) = 0),~(SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 0));
EXPORT InValidMessageFT_orig_subj8_address_predir(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.NotLeft,SALT39.HygieneErrors.NotInChars('8ABDEIJPRSU_ '),SALT39.HygieneErrors.NotLength('0'),SALT39.HygieneErrors.NotWords('0'),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_orig_subj8_address_prim_name(SALT39.StrType s0) := FUNCTION
  s1 := SALT39.stringfilter(s0,'8ABDEIJMNPRSU_ '); // Only allow valid symbols
  s2 := SALT39.stringcleanspaces( SALT39.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_orig_subj8_address_prim_name(SALT39.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT39.StringFilter(s,'8ABDEIJMNPRSU_ '))),~(LENGTH(TRIM(s)) = 0),~(SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 0));
EXPORT InValidMessageFT_orig_subj8_address_prim_name(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.NotLeft,SALT39.HygieneErrors.NotInChars('8ABDEIJMNPRSU_ '),SALT39.HygieneErrors.NotLength('0'),SALT39.HygieneErrors.NotWords('0'),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_orig_subj8_address_suffix(SALT39.StrType s0) := FUNCTION
  s1 := SALT39.stringfilter(s0,'8ABDEFIJRSUX_ '); // Only allow valid symbols
  s2 := SALT39.stringcleanspaces( SALT39.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_orig_subj8_address_suffix(SALT39.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT39.StringFilter(s,'8ABDEFIJRSUX_ '))),~(LENGTH(TRIM(s)) = 0),~(SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 0));
EXPORT InValidMessageFT_orig_subj8_address_suffix(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.NotLeft,SALT39.HygieneErrors.NotInChars('8ABDEFIJRSUX_ '),SALT39.HygieneErrors.NotLength('0'),SALT39.HygieneErrors.NotWords('0'),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_orig_subj8_address_postdir(SALT39.StrType s0) := FUNCTION
  s1 := SALT39.stringfilter(s0,'8ABDEIJOPRSTU_ '); // Only allow valid symbols
  s2 := SALT39.stringcleanspaces( SALT39.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_orig_subj8_address_postdir(SALT39.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT39.StringFilter(s,'8ABDEIJOPRSTU_ '))),~(LENGTH(TRIM(s)) = 0),~(SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 0));
EXPORT InValidMessageFT_orig_subj8_address_postdir(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.NotLeft,SALT39.HygieneErrors.NotInChars('8ABDEIJOPRSTU_ '),SALT39.HygieneErrors.NotLength('0'),SALT39.HygieneErrors.NotWords('0'),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_orig_subj8_address_unit_desig(SALT39.StrType s0) := FUNCTION
  s1 := SALT39.stringfilter(s0,'8ABDEGIJNRSTU_ '); // Only allow valid symbols
  s2 := SALT39.stringcleanspaces( SALT39.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_orig_subj8_address_unit_desig(SALT39.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT39.StringFilter(s,'8ABDEGIJNRSTU_ '))),~(LENGTH(TRIM(s)) = 0),~(SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 0));
EXPORT InValidMessageFT_orig_subj8_address_unit_desig(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.NotLeft,SALT39.HygieneErrors.NotInChars('8ABDEGIJNRSTU_ '),SALT39.HygieneErrors.NotLength('0'),SALT39.HygieneErrors.NotWords('0'),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_orig_subj8_address_sec_range(SALT39.StrType s0) := FUNCTION
  s1 := SALT39.stringfilter(s0,'8ABCDEGJNRSU_ '); // Only allow valid symbols
  s2 := SALT39.stringcleanspaces( SALT39.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_orig_subj8_address_sec_range(SALT39.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT39.StringFilter(s,'8ABCDEGJNRSU_ '))),~(LENGTH(TRIM(s)) = 0),~(SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 0));
EXPORT InValidMessageFT_orig_subj8_address_sec_range(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.NotLeft,SALT39.HygieneErrors.NotInChars('8ABCDEGJNRSU_ '),SALT39.HygieneErrors.NotLength('0'),SALT39.HygieneErrors.NotWords('0'),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_orig_subj8_address_city(SALT39.StrType s0) := FUNCTION
  s1 := SALT39.stringfilter(s0,'8ABCDEIJRSTUY_ '); // Only allow valid symbols
  s2 := SALT39.stringcleanspaces( SALT39.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_orig_subj8_address_city(SALT39.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT39.StringFilter(s,'8ABCDEIJRSTUY_ '))),~(LENGTH(TRIM(s)) = 0),~(SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 0));
EXPORT InValidMessageFT_orig_subj8_address_city(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.NotLeft,SALT39.HygieneErrors.NotInChars('8ABCDEIJRSTUY_ '),SALT39.HygieneErrors.NotLength('0'),SALT39.HygieneErrors.NotWords('0'),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_orig_subj8_address_st(SALT39.StrType s0) := FUNCTION
  s1 := SALT39.stringfilter(s0,'8ABDEJRSTU_ '); // Only allow valid symbols
  s2 := SALT39.stringcleanspaces( SALT39.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_orig_subj8_address_st(SALT39.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT39.StringFilter(s,'8ABDEJRSTU_ '))),~(LENGTH(TRIM(s)) = 0),~(SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 0));
EXPORT InValidMessageFT_orig_subj8_address_st(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.NotLeft,SALT39.HygieneErrors.NotInChars('8ABDEJRSTU_ '),SALT39.HygieneErrors.NotLength('0'),SALT39.HygieneErrors.NotWords('0'),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_orig_subj8_address_z5(SALT39.StrType s0) := FUNCTION
  s1 := SALT39.stringfilter(s0,'58ABDEJRSUZ_ '); // Only allow valid symbols
  s2 := SALT39.stringcleanspaces( SALT39.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_orig_subj8_address_z5(SALT39.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT39.StringFilter(s,'58ABDEJRSUZ_ '))),~(LENGTH(TRIM(s)) = 0),~(SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 0));
EXPORT InValidMessageFT_orig_subj8_address_z5(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.NotLeft,SALT39.HygieneErrors.NotInChars('58ABDEJRSUZ_ '),SALT39.HygieneErrors.NotLength('0'),SALT39.HygieneErrors.NotWords('0'),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_orig_subj8_address_z4(SALT39.StrType s0) := FUNCTION
  s1 := SALT39.stringfilter(s0,'48ABDEJRSUZ_ '); // Only allow valid symbols
  s2 := SALT39.stringcleanspaces( SALT39.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_orig_subj8_address_z4(SALT39.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT39.StringFilter(s,'48ABDEJRSUZ_ '))),~(LENGTH(TRIM(s)) = 0),~(SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 0));
EXPORT InValidMessageFT_orig_subj8_address_z4(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.NotLeft,SALT39.HygieneErrors.NotInChars('48ABDEJRSUZ_ '),SALT39.HygieneErrors.NotLength('0'),SALT39.HygieneErrors.NotWords('0'),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_orig_subj8_phone(SALT39.StrType s0) := FUNCTION
  s1 := SALT39.stringfilter(s0,'8BEHJNOPSU_ '); // Only allow valid symbols
  s2 := SALT39.stringcleanspaces( SALT39.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_orig_subj8_phone(SALT39.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT39.StringFilter(s,'8BEHJNOPSU_ '))),~(LENGTH(TRIM(s)) = 0),~(SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 0));
EXPORT InValidMessageFT_orig_subj8_phone(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.NotLeft,SALT39.HygieneErrors.NotInChars('8BEHJNOPSU_ '),SALT39.HygieneErrors.NotLength('0'),SALT39.HygieneErrors.NotWords('0'),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_orig_subj8_work_phone(SALT39.StrType s0) := FUNCTION
  s1 := SALT39.stringfilter(s0,'8BEHJKNOPRSUW_ '); // Only allow valid symbols
  s2 := SALT39.stringcleanspaces( SALT39.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_orig_subj8_work_phone(SALT39.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT39.StringFilter(s,'8BEHJKNOPRSUW_ '))),~(LENGTH(TRIM(s)) = 0),~(SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 0));
EXPORT InValidMessageFT_orig_subj8_work_phone(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.NotLeft,SALT39.HygieneErrors.NotInChars('8BEHJKNOPRSUW_ '),SALT39.HygieneErrors.NotLength('0'),SALT39.HygieneErrors.NotWords('0'),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_orig_subj8_business_title(SALT39.StrType s0) := FUNCTION
  s1 := SALT39.stringfilter(s0,'8BEIJLNSTU_ '); // Only allow valid symbols
  s2 := SALT39.stringcleanspaces( SALT39.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_orig_subj8_business_title(SALT39.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT39.StringFilter(s,'8BEIJLNSTU_ '))),~(LENGTH(TRIM(s)) = 0),~(SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 0));
EXPORT InValidMessageFT_orig_subj8_business_title(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.NotLeft,SALT39.HygieneErrors.NotInChars('8BEIJLNSTU_ '),SALT39.HygieneErrors.NotLength('0'),SALT39.HygieneErrors.NotWords('0'),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_orig_subj8_email(SALT39.StrType s0) := FUNCTION
  s1 := SALT39.stringfilter(s0,'8ABEIJLMSU_ '); // Only allow valid symbols
  s2 := SALT39.stringcleanspaces( SALT39.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_orig_subj8_email(SALT39.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT39.StringFilter(s,'8ABEIJLMSU_ '))),~(LENGTH(TRIM(s)) = 0),~(SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 0));
EXPORT InValidMessageFT_orig_subj8_email(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.NotLeft,SALT39.HygieneErrors.NotInChars('8ABEIJLMSU_ '),SALT39.HygieneErrors.NotLength('0'),SALT39.HygieneErrors.NotWords('0'),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_orig_subj8_company_name(SALT39.StrType s0) := FUNCTION
  s1 := SALT39.stringfilter(s0,'8ABCEJMNOPSUY_ '); // Only allow valid symbols
  s2 := SALT39.stringcleanspaces( SALT39.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_orig_subj8_company_name(SALT39.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT39.StringFilter(s,'8ABCEJMNOPSUY_ '))),~(LENGTH(TRIM(s)) = 0),~(SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 0));
EXPORT InValidMessageFT_orig_subj8_company_name(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.NotLeft,SALT39.HygieneErrors.NotInChars('8ABCEJMNOPSUY_ '),SALT39.HygieneErrors.NotLength('0'),SALT39.HygieneErrors.NotWords('0'),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_orig_subj8_fein(SALT39.StrType s0) := FUNCTION
  s1 := SALT39.stringfilter(s0,'8BEFIJNSU_ '); // Only allow valid symbols
  s2 := SALT39.stringcleanspaces( SALT39.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_orig_subj8_fein(SALT39.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT39.StringFilter(s,'8BEFIJNSU_ '))),~(LENGTH(TRIM(s)) = 0),~(SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 0));
EXPORT InValidMessageFT_orig_subj8_fein(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.NotLeft,SALT39.HygieneErrors.NotInChars('8BEFIJNSU_ '),SALT39.HygieneErrors.NotLength('0'),SALT39.HygieneErrors.NotWords('0'),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_orig_company_alternate_name(SALT39.StrType s0) := FUNCTION
  s1 := SALT39.stringfilter(s0,'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789<>{}[]-^=!+&,./:|#_@$ '); // Only allow valid symbols
  s2 := SALT39.stringcleanspaces( SALT39.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  MakeFT_WORDBAG(s3);
END;
EXPORT InValidFT_orig_company_alternate_name(SALT39.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT39.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789<>{}[]-^=!+&,./:|#_@$ '))),~(LENGTH(TRIM(s)) = 0),~(SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 0));
EXPORT InValidMessageFT_orig_company_alternate_name(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.NotLeft,SALT39.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789<>{}[]-^=!+&,./:|#_@$ '),SALT39.HygieneErrors.NotLength('0'),SALT39.HygieneErrors.NotWords('0'),SALT39.HygieneErrors.Good);
 
EXPORT SALT39.StrType FieldName(UNSIGNED2 i) := CHOOSE(i,'orig_datetime_stamp','orig_global_company_id','orig_company_id','orig_product_cd','orig_method','orig_vertical','orig_function_name','orig_transaction_type','orig_login_history_id','orig_job_id','orig_sequence_number','orig_first_name','orig_middle_name','orig_last_name','orig_ssn','orig_dob','orig_dl_num','orig_dl_state','orig_address1_addressline1','orig_address1_addressline2','orig_address1_prim_range','orig_address1_predir','orig_address1_prim_name','orig_address1_suffix','orig_address1_postdir','orig_address1_unit_desig','orig_address1_sec_range','orig_address1_city','orig_address1_st','orig_address1_z5','orig_address1_z4','orig_address2_addressline1','orig_address2_addressline2','orig_address2_prim_range','orig_address2_predir','orig_address2_prim_name','orig_address2_suffix','orig_address2_postdir','orig_address2_unit_desig','orig_address2_sec_range','orig_address2_city','orig_address2_st','orig_address2_z5','orig_address2_z4','orig_bdid','orig_bdl','orig_did','orig_company_name','orig_fein','orig_phone','orig_work_phone','orig_company_phone','orig_reference_code','orig_ip_address_initiated','orig_ip_address_executed','orig_charter_number','orig_ucc_original_filing_number','orig_email_address','orig_domain_name','orig_full_name','orig_dl_purpose','orig_glb_purpose','orig_fcra_purpose','orig_process_id','orig_suffix_name','orig_former_last_name','orig_business_title','orig_company_addressline1','orig_company_addressline2','orig_company_address_prim_range','orig_company_address_predir','orig_company_address_prim_name','orig_company_address_suffix','orig_company_address_postdir','orig_company_address_unit_desig','orig_company_address_sec_range','orig_company_address_city','orig_company_address_st','orig_company_address_zip5','orig_company_address_zip4','orig_company_fax_number','orig_company_start_date','orig_company_years_in_business','orig_company_sic_code','orig_company_naic_code','orig_company_structure','orig_company_yearly_revenue','orig_subj2_first_name','orig_subj2_middle_name','orig_subj2_last_name','orig_subj2_suffix_name','orig_subj2_full_name','orig_subj2_ssn','orig_subj2_dob','orig_subj2_dl_num','orig_subj2_dl_state','orig_subj2_former_last_name','orig_subj2_address_addressline1','orig_subj2_address_addressline2','orig_subj2_address_prim_range','orig_subj2_address_predir','orig_subj2_address_prim_name','orig_subj2_address_suffix','orig_subj2_address_postdir','orig_subj2_address_unit_desig','orig_subj2_address_sec_range','orig_subj2_address_city','orig_subj2_address_st','orig_subj2_address_z5','orig_subj2_address_z4','orig_subj2_phone','orig_subj2_work_phone','orig_subj2_business_title','orig_subj3_first_name','orig_subj3_middle_name','orig_subj3_last_name','orig_subj3_suffix_name','orig_subj3_full_name','orig_subj3_ssn','orig_subj3_dob','orig_subj3_dl_num','orig_subj3_dl_state','orig_subj3_former_last_name','orig_subj3_address_addressline1','orig_subj3_address_addressline2','orig_subj3_address_prim_range','orig_subj3_address_predir','orig_subj3_address_prim_name','orig_subj3_address_suffix','orig_subj3_address_postdir','orig_subj3_address_unit_desig','orig_subj3_address_sec_range','orig_subj3_address_city','orig_subj3_address_st','orig_subj3_address_z5','orig_subj3_address_z4','orig_subj3_phone','orig_subj3_work_phone','orig_subj3_business_title','orig_email','orig_subj2_email','orig_subj2_company_name','orig_subj2_fein','orig_subj3_email','orig_subj3_company_name','orig_subj3_fein','orig_subj4_first_name','orig_subj4_middle_name','orig_subj4_last_name','orig_subj4_suffix_name','orig_subj4_full_name','orig_subj4_ssn','orig_subj4_dob','orig_subj4_dl_num','orig_subj4_dl_state','orig_subj4_former_last_name','orig_subj4_address_addressline1','orig_subj4_address_addressline2','orig_subj4_address_prim_range','orig_subj4_address_predir','orig_subj4_address_prim_name','orig_subj4_address_suffix','orig_subj4_address_postdir','orig_subj4_address_unit_desig','orig_subj4_address_sec_range','orig_subj4_address_city','orig_subj4_address_st','orig_subj4_address_z5','orig_subj4_address_z4','orig_subj4_phone','orig_subj4_work_phone','orig_subj4_business_title','orig_subj4_email','orig_subj4_company_name','orig_subj4_fein','orig_subj5_first_name','orig_subj5_middle_name','orig_subj5_last_name','orig_subj5_suffix_name','orig_subj5_full_name','orig_subj5_ssn','orig_subj5_dob','orig_subj5_dl_num','orig_subj5_dl_state','orig_subj5_former_last_name','orig_subj5_address_addressline1','orig_subj5_address_addressline2','orig_subj5_address_prim_range','orig_subj5_address_predir','orig_subj5_address_prim_name','orig_subj5_address_suffix','orig_subj5_address_postdir','orig_subj5_address_unit_desig','orig_subj5_address_sec_range','orig_subj5_address_city','orig_subj5_address_st','orig_subj5_address_z5','orig_subj5_address_z4','orig_subj5_phone','orig_subj5_work_phone','orig_subj5_business_title','orig_subj5_email','orig_subj5_company_name','orig_subj5_fein','orig_subj6_first_name','orig_subj6_middle_name','orig_subj6_last_name','orig_subj6_suffix_name','orig_subj6_full_name','orig_subj6_ssn','orig_subj6_dob','orig_subj6_dl_num','orig_subj6_dl_state','orig_subj6_former_last_name','orig_subj6_address_addressline1','orig_subj6_address_addressline2','orig_subj6_address_prim_range','orig_subj6_address_predir','orig_subj6_address_prim_name','orig_subj6_address_suffix','orig_subj6_address_postdir','orig_subj6_address_unit_desig','orig_subj6_address_sec_range','orig_subj6_address_city','orig_subj6_address_st','orig_subj6_address_z5','orig_subj6_address_z4','orig_subj6_phone','orig_subj6_work_phone','orig_subj6_business_title','orig_subj6_email','orig_subj6_company_name','orig_subj6_fein','orig_subj7_first_name','orig_subj7_middle_name','orig_subj7_last_name','orig_subj7_suffix_name','orig_subj7_full_name','orig_subj7_ssn','orig_subj7_dob','orig_subj7_dl_num','orig_subj7_dl_state','orig_subj7_former_last_name','orig_subj7_address_addressline1','orig_subj7_address_addressline2','orig_subj7_address_prim_range','orig_subj7_address_predir','orig_subj7_address_prim_name','orig_subj7_address_suffix','orig_subj7_address_postdir','orig_subj7_address_unit_desig','orig_subj7_address_sec_range','orig_subj7_address_city','orig_subj7_address_st','orig_subj7_address_z5','orig_subj7_address_z4','orig_subj7_phone','orig_subj7_work_phone','orig_subj7_business_title','orig_subj7_email','orig_subj7_company_name','orig_subj7_fein','orig_subj8_first_name','orig_subj8_middle_name','orig_subj8_last_name','orig_subj8_suffix_name','orig_subj8_full_name','orig_subj8_ssn','orig_subj8_dob','orig_subj8_dl_num','orig_subj8_dl_state','orig_subj8_former_last_name','orig_subj8_address_addressline1','orig_subj8_address_addressline2','orig_subj8_address_prim_range','orig_subj8_address_predir','orig_subj8_address_prim_name','orig_subj8_address_suffix','orig_subj8_address_postdir','orig_subj8_address_unit_desig','orig_subj8_address_sec_range','orig_subj8_address_city','orig_subj8_address_st','orig_subj8_address_z5','orig_subj8_address_z4','orig_subj8_phone','orig_subj8_work_phone','orig_subj8_business_title','orig_subj8_email','orig_subj8_company_name','orig_subj8_fein','orig_company_alternate_name');
EXPORT SALT39.StrType FlatName(UNSIGNED2 i) := CHOOSE(i,'orig_datetime_stamp','orig_global_company_id','orig_company_id','orig_product_cd','orig_method','orig_vertical','orig_function_name','orig_transaction_type','orig_login_history_id','orig_job_id','orig_sequence_number','orig_first_name','orig_middle_name','orig_last_name','orig_ssn','orig_dob','orig_dl_num','orig_dl_state','orig_address1_addressline1','orig_address1_addressline2','orig_address1_prim_range','orig_address1_predir','orig_address1_prim_name','orig_address1_suffix','orig_address1_postdir','orig_address1_unit_desig','orig_address1_sec_range','orig_address1_city','orig_address1_st','orig_address1_z5','orig_address1_z4','orig_address2_addressline1','orig_address2_addressline2','orig_address2_prim_range','orig_address2_predir','orig_address2_prim_name','orig_address2_suffix','orig_address2_postdir','orig_address2_unit_desig','orig_address2_sec_range','orig_address2_city','orig_address2_st','orig_address2_z5','orig_address2_z4','orig_bdid','orig_bdl','orig_did','orig_company_name','orig_fein','orig_phone','orig_work_phone','orig_company_phone','orig_reference_code','orig_ip_address_initiated','orig_ip_address_executed','orig_charter_number','orig_ucc_original_filing_number','orig_email_address','orig_domain_name','orig_full_name','orig_dl_purpose','orig_glb_purpose','orig_fcra_purpose','orig_process_id','orig_suffix_name','orig_former_last_name','orig_business_title','orig_company_addressline1','orig_company_addressline2','orig_company_address_prim_range','orig_company_address_predir','orig_company_address_prim_name','orig_company_address_suffix','orig_company_address_postdir','orig_company_address_unit_desig','orig_company_address_sec_range','orig_company_address_city','orig_company_address_st','orig_company_address_zip5','orig_company_address_zip4','orig_company_fax_number','orig_company_start_date','orig_company_years_in_business','orig_company_sic_code','orig_company_naic_code','orig_company_structure','orig_company_yearly_revenue','orig_subj2_first_name','orig_subj2_middle_name','orig_subj2_last_name','orig_subj2_suffix_name','orig_subj2_full_name','orig_subj2_ssn','orig_subj2_dob','orig_subj2_dl_num','orig_subj2_dl_state','orig_subj2_former_last_name','orig_subj2_address_addressline1','orig_subj2_address_addressline2','orig_subj2_address_prim_range','orig_subj2_address_predir','orig_subj2_address_prim_name','orig_subj2_address_suffix','orig_subj2_address_postdir','orig_subj2_address_unit_desig','orig_subj2_address_sec_range','orig_subj2_address_city','orig_subj2_address_st','orig_subj2_address_z5','orig_subj2_address_z4','orig_subj2_phone','orig_subj2_work_phone','orig_subj2_business_title','orig_subj3_first_name','orig_subj3_middle_name','orig_subj3_last_name','orig_subj3_suffix_name','orig_subj3_full_name','orig_subj3_ssn','orig_subj3_dob','orig_subj3_dl_num','orig_subj3_dl_state','orig_subj3_former_last_name','orig_subj3_address_addressline1','orig_subj3_address_addressline2','orig_subj3_address_prim_range','orig_subj3_address_predir','orig_subj3_address_prim_name','orig_subj3_address_suffix','orig_subj3_address_postdir','orig_subj3_address_unit_desig','orig_subj3_address_sec_range','orig_subj3_address_city','orig_subj3_address_st','orig_subj3_address_z5','orig_subj3_address_z4','orig_subj3_phone','orig_subj3_work_phone','orig_subj3_business_title','orig_email','orig_subj2_email','orig_subj2_company_name','orig_subj2_fein','orig_subj3_email','orig_subj3_company_name','orig_subj3_fein','orig_subj4_first_name','orig_subj4_middle_name','orig_subj4_last_name','orig_subj4_suffix_name','orig_subj4_full_name','orig_subj4_ssn','orig_subj4_dob','orig_subj4_dl_num','orig_subj4_dl_state','orig_subj4_former_last_name','orig_subj4_address_addressline1','orig_subj4_address_addressline2','orig_subj4_address_prim_range','orig_subj4_address_predir','orig_subj4_address_prim_name','orig_subj4_address_suffix','orig_subj4_address_postdir','orig_subj4_address_unit_desig','orig_subj4_address_sec_range','orig_subj4_address_city','orig_subj4_address_st','orig_subj4_address_z5','orig_subj4_address_z4','orig_subj4_phone','orig_subj4_work_phone','orig_subj4_business_title','orig_subj4_email','orig_subj4_company_name','orig_subj4_fein','orig_subj5_first_name','orig_subj5_middle_name','orig_subj5_last_name','orig_subj5_suffix_name','orig_subj5_full_name','orig_subj5_ssn','orig_subj5_dob','orig_subj5_dl_num','orig_subj5_dl_state','orig_subj5_former_last_name','orig_subj5_address_addressline1','orig_subj5_address_addressline2','orig_subj5_address_prim_range','orig_subj5_address_predir','orig_subj5_address_prim_name','orig_subj5_address_suffix','orig_subj5_address_postdir','orig_subj5_address_unit_desig','orig_subj5_address_sec_range','orig_subj5_address_city','orig_subj5_address_st','orig_subj5_address_z5','orig_subj5_address_z4','orig_subj5_phone','orig_subj5_work_phone','orig_subj5_business_title','orig_subj5_email','orig_subj5_company_name','orig_subj5_fein','orig_subj6_first_name','orig_subj6_middle_name','orig_subj6_last_name','orig_subj6_suffix_name','orig_subj6_full_name','orig_subj6_ssn','orig_subj6_dob','orig_subj6_dl_num','orig_subj6_dl_state','orig_subj6_former_last_name','orig_subj6_address_addressline1','orig_subj6_address_addressline2','orig_subj6_address_prim_range','orig_subj6_address_predir','orig_subj6_address_prim_name','orig_subj6_address_suffix','orig_subj6_address_postdir','orig_subj6_address_unit_desig','orig_subj6_address_sec_range','orig_subj6_address_city','orig_subj6_address_st','orig_subj6_address_z5','orig_subj6_address_z4','orig_subj6_phone','orig_subj6_work_phone','orig_subj6_business_title','orig_subj6_email','orig_subj6_company_name','orig_subj6_fein','orig_subj7_first_name','orig_subj7_middle_name','orig_subj7_last_name','orig_subj7_suffix_name','orig_subj7_full_name','orig_subj7_ssn','orig_subj7_dob','orig_subj7_dl_num','orig_subj7_dl_state','orig_subj7_former_last_name','orig_subj7_address_addressline1','orig_subj7_address_addressline2','orig_subj7_address_prim_range','orig_subj7_address_predir','orig_subj7_address_prim_name','orig_subj7_address_suffix','orig_subj7_address_postdir','orig_subj7_address_unit_desig','orig_subj7_address_sec_range','orig_subj7_address_city','orig_subj7_address_st','orig_subj7_address_z5','orig_subj7_address_z4','orig_subj7_phone','orig_subj7_work_phone','orig_subj7_business_title','orig_subj7_email','orig_subj7_company_name','orig_subj7_fein','orig_subj8_first_name','orig_subj8_middle_name','orig_subj8_last_name','orig_subj8_suffix_name','orig_subj8_full_name','orig_subj8_ssn','orig_subj8_dob','orig_subj8_dl_num','orig_subj8_dl_state','orig_subj8_former_last_name','orig_subj8_address_addressline1','orig_subj8_address_addressline2','orig_subj8_address_prim_range','orig_subj8_address_predir','orig_subj8_address_prim_name','orig_subj8_address_suffix','orig_subj8_address_postdir','orig_subj8_address_unit_desig','orig_subj8_address_sec_range','orig_subj8_address_city','orig_subj8_address_st','orig_subj8_address_z5','orig_subj8_address_z4','orig_subj8_phone','orig_subj8_work_phone','orig_subj8_business_title','orig_subj8_email','orig_subj8_company_name','orig_subj8_fein','orig_company_alternate_name');
EXPORT FieldNum(SALT39.StrType fn) := CASE(fn,'orig_datetime_stamp' => 0,'orig_global_company_id' => 1,'orig_company_id' => 2,'orig_product_cd' => 3,'orig_method' => 4,'orig_vertical' => 5,'orig_function_name' => 6,'orig_transaction_type' => 7,'orig_login_history_id' => 8,'orig_job_id' => 9,'orig_sequence_number' => 10,'orig_first_name' => 11,'orig_middle_name' => 12,'orig_last_name' => 13,'orig_ssn' => 14,'orig_dob' => 15,'orig_dl_num' => 16,'orig_dl_state' => 17,'orig_address1_addressline1' => 18,'orig_address1_addressline2' => 19,'orig_address1_prim_range' => 20,'orig_address1_predir' => 21,'orig_address1_prim_name' => 22,'orig_address1_suffix' => 23,'orig_address1_postdir' => 24,'orig_address1_unit_desig' => 25,'orig_address1_sec_range' => 26,'orig_address1_city' => 27,'orig_address1_st' => 28,'orig_address1_z5' => 29,'orig_address1_z4' => 30,'orig_address2_addressline1' => 31,'orig_address2_addressline2' => 32,'orig_address2_prim_range' => 33,'orig_address2_predir' => 34,'orig_address2_prim_name' => 35,'orig_address2_suffix' => 36,'orig_address2_postdir' => 37,'orig_address2_unit_desig' => 38,'orig_address2_sec_range' => 39,'orig_address2_city' => 40,'orig_address2_st' => 41,'orig_address2_z5' => 42,'orig_address2_z4' => 43,'orig_bdid' => 44,'orig_bdl' => 45,'orig_did' => 46,'orig_company_name' => 47,'orig_fein' => 48,'orig_phone' => 49,'orig_work_phone' => 50,'orig_company_phone' => 51,'orig_reference_code' => 52,'orig_ip_address_initiated' => 53,'orig_ip_address_executed' => 54,'orig_charter_number' => 55,'orig_ucc_original_filing_number' => 56,'orig_email_address' => 57,'orig_domain_name' => 58,'orig_full_name' => 59,'orig_dl_purpose' => 60,'orig_glb_purpose' => 61,'orig_fcra_purpose' => 62,'orig_process_id' => 63,'orig_suffix_name' => 64,'orig_former_last_name' => 65,'orig_business_title' => 66,'orig_company_addressline1' => 67,'orig_company_addressline2' => 68,'orig_company_address_prim_range' => 69,'orig_company_address_predir' => 70,'orig_company_address_prim_name' => 71,'orig_company_address_suffix' => 72,'orig_company_address_postdir' => 73,'orig_company_address_unit_desig' => 74,'orig_company_address_sec_range' => 75,'orig_company_address_city' => 76,'orig_company_address_st' => 77,'orig_company_address_zip5' => 78,'orig_company_address_zip4' => 79,'orig_company_fax_number' => 80,'orig_company_start_date' => 81,'orig_company_years_in_business' => 82,'orig_company_sic_code' => 83,'orig_company_naic_code' => 84,'orig_company_structure' => 85,'orig_company_yearly_revenue' => 86,'orig_subj2_first_name' => 87,'orig_subj2_middle_name' => 88,'orig_subj2_last_name' => 89,'orig_subj2_suffix_name' => 90,'orig_subj2_full_name' => 91,'orig_subj2_ssn' => 92,'orig_subj2_dob' => 93,'orig_subj2_dl_num' => 94,'orig_subj2_dl_state' => 95,'orig_subj2_former_last_name' => 96,'orig_subj2_address_addressline1' => 97,'orig_subj2_address_addressline2' => 98,'orig_subj2_address_prim_range' => 99,'orig_subj2_address_predir' => 100,'orig_subj2_address_prim_name' => 101,'orig_subj2_address_suffix' => 102,'orig_subj2_address_postdir' => 103,'orig_subj2_address_unit_desig' => 104,'orig_subj2_address_sec_range' => 105,'orig_subj2_address_city' => 106,'orig_subj2_address_st' => 107,'orig_subj2_address_z5' => 108,'orig_subj2_address_z4' => 109,'orig_subj2_phone' => 110,'orig_subj2_work_phone' => 111,'orig_subj2_business_title' => 112,'orig_subj3_first_name' => 113,'orig_subj3_middle_name' => 114,'orig_subj3_last_name' => 115,'orig_subj3_suffix_name' => 116,'orig_subj3_full_name' => 117,'orig_subj3_ssn' => 118,'orig_subj3_dob' => 119,'orig_subj3_dl_num' => 120,'orig_subj3_dl_state' => 121,'orig_subj3_former_last_name' => 122,'orig_subj3_address_addressline1' => 123,'orig_subj3_address_addressline2' => 124,'orig_subj3_address_prim_range' => 125,'orig_subj3_address_predir' => 126,'orig_subj3_address_prim_name' => 127,'orig_subj3_address_suffix' => 128,'orig_subj3_address_postdir' => 129,'orig_subj3_address_unit_desig' => 130,'orig_subj3_address_sec_range' => 131,'orig_subj3_address_city' => 132,'orig_subj3_address_st' => 133,'orig_subj3_address_z5' => 134,'orig_subj3_address_z4' => 135,'orig_subj3_phone' => 136,'orig_subj3_work_phone' => 137,'orig_subj3_business_title' => 138,'orig_email' => 139,'orig_subj2_email' => 140,'orig_subj2_company_name' => 141,'orig_subj2_fein' => 142,'orig_subj3_email' => 143,'orig_subj3_company_name' => 144,'orig_subj3_fein' => 145,'orig_subj4_first_name' => 146,'orig_subj4_middle_name' => 147,'orig_subj4_last_name' => 148,'orig_subj4_suffix_name' => 149,'orig_subj4_full_name' => 150,'orig_subj4_ssn' => 151,'orig_subj4_dob' => 152,'orig_subj4_dl_num' => 153,'orig_subj4_dl_state' => 154,'orig_subj4_former_last_name' => 155,'orig_subj4_address_addressline1' => 156,'orig_subj4_address_addressline2' => 157,'orig_subj4_address_prim_range' => 158,'orig_subj4_address_predir' => 159,'orig_subj4_address_prim_name' => 160,'orig_subj4_address_suffix' => 161,'orig_subj4_address_postdir' => 162,'orig_subj4_address_unit_desig' => 163,'orig_subj4_address_sec_range' => 164,'orig_subj4_address_city' => 165,'orig_subj4_address_st' => 166,'orig_subj4_address_z5' => 167,'orig_subj4_address_z4' => 168,'orig_subj4_phone' => 169,'orig_subj4_work_phone' => 170,'orig_subj4_business_title' => 171,'orig_subj4_email' => 172,'orig_subj4_company_name' => 173,'orig_subj4_fein' => 174,'orig_subj5_first_name' => 175,'orig_subj5_middle_name' => 176,'orig_subj5_last_name' => 177,'orig_subj5_suffix_name' => 178,'orig_subj5_full_name' => 179,'orig_subj5_ssn' => 180,'orig_subj5_dob' => 181,'orig_subj5_dl_num' => 182,'orig_subj5_dl_state' => 183,'orig_subj5_former_last_name' => 184,'orig_subj5_address_addressline1' => 185,'orig_subj5_address_addressline2' => 186,'orig_subj5_address_prim_range' => 187,'orig_subj5_address_predir' => 188,'orig_subj5_address_prim_name' => 189,'orig_subj5_address_suffix' => 190,'orig_subj5_address_postdir' => 191,'orig_subj5_address_unit_desig' => 192,'orig_subj5_address_sec_range' => 193,'orig_subj5_address_city' => 194,'orig_subj5_address_st' => 195,'orig_subj5_address_z5' => 196,'orig_subj5_address_z4' => 197,'orig_subj5_phone' => 198,'orig_subj5_work_phone' => 199,'orig_subj5_business_title' => 200,'orig_subj5_email' => 201,'orig_subj5_company_name' => 202,'orig_subj5_fein' => 203,'orig_subj6_first_name' => 204,'orig_subj6_middle_name' => 205,'orig_subj6_last_name' => 206,'orig_subj6_suffix_name' => 207,'orig_subj6_full_name' => 208,'orig_subj6_ssn' => 209,'orig_subj6_dob' => 210,'orig_subj6_dl_num' => 211,'orig_subj6_dl_state' => 212,'orig_subj6_former_last_name' => 213,'orig_subj6_address_addressline1' => 214,'orig_subj6_address_addressline2' => 215,'orig_subj6_address_prim_range' => 216,'orig_subj6_address_predir' => 217,'orig_subj6_address_prim_name' => 218,'orig_subj6_address_suffix' => 219,'orig_subj6_address_postdir' => 220,'orig_subj6_address_unit_desig' => 221,'orig_subj6_address_sec_range' => 222,'orig_subj6_address_city' => 223,'orig_subj6_address_st' => 224,'orig_subj6_address_z5' => 225,'orig_subj6_address_z4' => 226,'orig_subj6_phone' => 227,'orig_subj6_work_phone' => 228,'orig_subj6_business_title' => 229,'orig_subj6_email' => 230,'orig_subj6_company_name' => 231,'orig_subj6_fein' => 232,'orig_subj7_first_name' => 233,'orig_subj7_middle_name' => 234,'orig_subj7_last_name' => 235,'orig_subj7_suffix_name' => 236,'orig_subj7_full_name' => 237,'orig_subj7_ssn' => 238,'orig_subj7_dob' => 239,'orig_subj7_dl_num' => 240,'orig_subj7_dl_state' => 241,'orig_subj7_former_last_name' => 242,'orig_subj7_address_addressline1' => 243,'orig_subj7_address_addressline2' => 244,'orig_subj7_address_prim_range' => 245,'orig_subj7_address_predir' => 246,'orig_subj7_address_prim_name' => 247,'orig_subj7_address_suffix' => 248,'orig_subj7_address_postdir' => 249,'orig_subj7_address_unit_desig' => 250,'orig_subj7_address_sec_range' => 251,'orig_subj7_address_city' => 252,'orig_subj7_address_st' => 253,'orig_subj7_address_z5' => 254,'orig_subj7_address_z4' => 255,'orig_subj7_phone' => 256,'orig_subj7_work_phone' => 257,'orig_subj7_business_title' => 258,'orig_subj7_email' => 259,'orig_subj7_company_name' => 260,'orig_subj7_fein' => 261,'orig_subj8_first_name' => 262,'orig_subj8_middle_name' => 263,'orig_subj8_last_name' => 264,'orig_subj8_suffix_name' => 265,'orig_subj8_full_name' => 266,'orig_subj8_ssn' => 267,'orig_subj8_dob' => 268,'orig_subj8_dl_num' => 269,'orig_subj8_dl_state' => 270,'orig_subj8_former_last_name' => 271,'orig_subj8_address_addressline1' => 272,'orig_subj8_address_addressline2' => 273,'orig_subj8_address_prim_range' => 274,'orig_subj8_address_predir' => 275,'orig_subj8_address_prim_name' => 276,'orig_subj8_address_suffix' => 277,'orig_subj8_address_postdir' => 278,'orig_subj8_address_unit_desig' => 279,'orig_subj8_address_sec_range' => 280,'orig_subj8_address_city' => 281,'orig_subj8_address_st' => 282,'orig_subj8_address_z5' => 283,'orig_subj8_address_z4' => 284,'orig_subj8_phone' => 285,'orig_subj8_work_phone' => 286,'orig_subj8_business_title' => 287,'orig_subj8_email' => 288,'orig_subj8_company_name' => 289,'orig_subj8_fein' => 290,'orig_company_alternate_name' => 291,0);
EXPORT SET OF SALT39.StrType FieldRules(UNSIGNED2 i) := CHOOSE(i,['ALLOW','LENGTHS','WORDS'],['ALLOW','WORDS'],['ALLOW','WORDS'],['LEFTTRIM','ALLOW','LENGTHS','WORDS'],['LEFTTRIM','ALLOW','LENGTHS','WORDS'],['LEFTTRIM','ALLOW','LENGTHS','WORDS'],['ALLOW','WORDS'],['LEFTTRIM','ALLOW','LENGTHS','WORDS'],['LEFTTRIM','ALLOW','LENGTHS','WORDS'],['ALLOW','LENGTHS','WORDS'],['ALLOW','WORDS'],['ALLOW','WORDS'],['ALLOW','WORDS'],['ALLOW','WORDS'],['ALLOW','LENGTHS','WORDS'],['ALLOW','LENGTHS','WORDS'],['ALLOW','LENGTHS','WORDS'],['ALLOW','LENGTHS','WORDS'],['ALLOW'],['LEFTTRIM','ALLOW','LENGTHS','WORDS'],['LEFTTRIM','ALLOW','LENGTHS','WORDS'],['LEFTTRIM','ALLOW','LENGTHS','WORDS'],['ALLOW'],['ALLOW','WORDS'],['LEFTTRIM','ALLOW','WORDS'],['LEFTTRIM','ALLOW','WORDS'],['LEFTTRIM','ALLOW','WORDS'],['ALLOW','WORDS'],['ALLOW','LENGTHS','WORDS'],['ALLOW','LENGTHS','WORDS'],['ALLOW','LENGTHS','WORDS'],['LEFTTRIM','ALLOW','LENGTHS','WORDS'],['LEFTTRIM','ALLOW','LENGTHS','WORDS'],['LEFTTRIM','ALLOW','LENGTHS','WORDS'],['LEFTTRIM','ALLOW','LENGTHS','WORDS'],['LEFTTRIM','ALLOW','LENGTHS','WORDS'],['LEFTTRIM','ALLOW','LENGTHS','WORDS'],['LEFTTRIM','ALLOW','LENGTHS','WORDS'],['LEFTTRIM','ALLOW','LENGTHS','WORDS'],['LEFTTRIM','ALLOW','LENGTHS','WORDS'],['LEFTTRIM','ALLOW','LENGTHS','WORDS'],['LEFTTRIM','ALLOW','LENGTHS','WORDS'],['LEFTTRIM','ALLOW','LENGTHS','WORDS'],['LEFTTRIM','ALLOW','LENGTHS','WORDS'],['LEFTTRIM','ALLOW','LENGTHS','WORDS'],['LEFTTRIM','ALLOW','LENGTHS','WORDS'],['LEFTTRIM','ALLOW','LENGTHS','WORDS'],['LEFTTRIM','ALLOW','LENGTHS','WORDS'],['LEFTTRIM','ALLOW','LENGTHS','WORDS'],['LEFTTRIM','ALLOW','LENGTHS','WORDS'],['LEFTTRIM','ALLOW','LENGTHS','WORDS'],['LEFTTRIM','ALLOW','LENGTHS','WORDS'],['LEFTTRIM','ALLOW','LENGTHS','WORDS'],['LEFTTRIM','ALLOW','LENGTHS','WORDS'],['LEFTTRIM','ALLOW','LENGTHS','WORDS'],['LEFTTRIM','ALLOW','LENGTHS','WORDS'],['LEFTTRIM','ALLOW','LENGTHS','WORDS'],['LEFTTRIM','ALLOW','LENGTHS','WORDS'],['LEFTTRIM','ALLOW','LENGTHS','WORDS'],['LEFTTRIM','ALLOW','LENGTHS','WORDS'],['LEFTTRIM','ALLOW','LENGTHS','WORDS'],['LEFTTRIM','ALLOW','LENGTHS','WORDS'],['LEFTTRIM','ALLOW','LENGTHS','WORDS'],['LEFTTRIM','ALLOW','LENGTHS','WORDS'],['LEFTTRIM','ALLOW','LENGTHS','WORDS'],['LEFTTRIM','ALLOW','LENGTHS','WORDS'],['LEFTTRIM','ALLOW','LENGTHS','WORDS'],['LEFTTRIM','ALLOW','LENGTHS','WORDS'],['LEFTTRIM','ALLOW','LENGTHS','WORDS'],['LEFTTRIM','ALLOW','LENGTHS','WORDS'],['LEFTTRIM','ALLOW','LENGTHS','WORDS'],['LEFTTRIM','ALLOW','LENGTHS','WORDS'],['LEFTTRIM','ALLOW','LENGTHS','WORDS'],['LEFTTRIM','ALLOW','LENGTHS','WORDS'],['LEFTTRIM','ALLOW','LENGTHS','WORDS'],[],['LEFTTRIM','ALLOW','LENGTHS','WORDS'],['LEFTTRIM','ALLOW','LENGTHS','WORDS'],['LEFTTRIM','ALLOW','LENGTHS','WORDS'],['LEFTTRIM','ALLOW','LENGTHS','WORDS'],['LEFTTRIM','ALLOW','LENGTHS','WORDS'],['LEFTTRIM','ALLOW','LENGTHS','WORDS'],['LEFTTRIM','ALLOW','LENGTHS','WORDS'],['LEFTTRIM','ALLOW','LENGTHS','WORDS'],['LEFTTRIM','ALLOW','LENGTHS','WORDS'],['LEFTTRIM','ALLOW','LENGTHS','WORDS'],['LEFTTRIM','ALLOW','LENGTHS','WORDS'],['LEFTTRIM','ALLOW','LENGTHS','WORDS'],['LEFTTRIM','ALLOW','LENGTHS','WORDS'],['LEFTTRIM','ALLOW','LENGTHS','WORDS'],['LEFTTRIM','ALLOW','LENGTHS','WORDS'],['LEFTTRIM','ALLOW','LENGTHS','WORDS'],['LEFTTRIM','ALLOW','LENGTHS','WORDS'],['LEFTTRIM','ALLOW','LENGTHS','WORDS'],['LEFTTRIM','ALLOW','LENGTHS','WORDS'],['LEFTTRIM','ALLOW','LENGTHS','WORDS'],['LEFTTRIM','ALLOW','LENGTHS','WORDS'],['LEFTTRIM','ALLOW','LENGTHS','WORDS'],['LEFTTRIM','ALLOW','LENGTHS','WORDS'],['LEFTTRIM','ALLOW','LENGTHS','WORDS'],['LEFTTRIM','ALLOW','LENGTHS','WORDS'],['LEFTTRIM','ALLOW','LENGTHS','WORDS'],['LEFTTRIM','ALLOW','LENGTHS','WORDS'],['LEFTTRIM','ALLOW','LENGTHS','WORDS'],['LEFTTRIM','ALLOW','LENGTHS','WORDS'],['LEFTTRIM','ALLOW','LENGTHS','WORDS'],['LEFTTRIM','ALLOW','LENGTHS','WORDS'],['LEFTTRIM','ALLOW','LENGTHS','WORDS'],['LEFTTRIM','ALLOW','LENGTHS','WORDS'],['LEFTTRIM','ALLOW','LENGTHS','WORDS'],['LEFTTRIM','ALLOW','LENGTHS','WORDS'],['LEFTTRIM','ALLOW','LENGTHS','WORDS'],['LEFTTRIM','ALLOW','LENGTHS','WORDS'],['LEFTTRIM','ALLOW','LENGTHS','WORDS'],['LEFTTRIM','ALLOW','LENGTHS','WORDS'],['LEFTTRIM','ALLOW','LENGTHS','WORDS'],['LEFTTRIM','ALLOW','LENGTHS','WORDS'],['LEFTTRIM','ALLOW','LENGTHS','WORDS'],['LEFTTRIM','ALLOW','LENGTHS','WORDS'],['LEFTTRIM','ALLOW','LENGTHS','WORDS'],['LEFTTRIM','ALLOW','LENGTHS','WORDS'],['LEFTTRIM','ALLOW','LENGTHS','WORDS'],['LEFTTRIM','ALLOW','LENGTHS','WORDS'],['LEFTTRIM','ALLOW','LENGTHS','WORDS'],['LEFTTRIM','ALLOW','LENGTHS','WORDS'],['LEFTTRIM','ALLOW','LENGTHS','WORDS'],['LEFTTRIM','ALLOW','LENGTHS','WORDS'],['LEFTTRIM','ALLOW','LENGTHS','WORDS'],['LEFTTRIM','ALLOW','LENGTHS','WORDS'],['LEFTTRIM','ALLOW','LENGTHS','WORDS'],['LEFTTRIM','ALLOW','LENGTHS','WORDS'],['LEFTTRIM','ALLOW','LENGTHS','WORDS'],['LEFTTRIM','ALLOW','LENGTHS','WORDS'],['LEFTTRIM','ALLOW','LENGTHS','WORDS'],['LEFTTRIM','ALLOW','LENGTHS','WORDS'],['LEFTTRIM','ALLOW','LENGTHS','WORDS'],['LEFTTRIM','ALLOW','LENGTHS','WORDS'],['LEFTTRIM','ALLOW','LENGTHS','WORDS'],['LEFTTRIM','ALLOW','LENGTHS','WORDS'],['LEFTTRIM','ALLOW','LENGTHS','WORDS'],['LEFTTRIM','ALLOW','LENGTHS','WORDS'],['LEFTTRIM','ALLOW','LENGTHS','WORDS'],['LEFTTRIM','ALLOW','LENGTHS','WORDS'],['LEFTTRIM','ALLOW','LENGTHS','WORDS'],['LEFTTRIM','ALLOW','LENGTHS','WORDS'],['LEFTTRIM','ALLOW','LENGTHS','WORDS'],['LEFTTRIM','ALLOW','LENGTHS','WORDS'],['LEFTTRIM','ALLOW','LENGTHS','WORDS'],['LEFTTRIM','ALLOW','LENGTHS','WORDS'],['LEFTTRIM','ALLOW','LENGTHS','WORDS'],['LEFTTRIM','ALLOW','LENGTHS','WORDS'],['LEFTTRIM','ALLOW','LENGTHS','WORDS'],['LEFTTRIM','ALLOW','LENGTHS','WORDS'],['LEFTTRIM','ALLOW','LENGTHS','WORDS'],['LEFTTRIM','ALLOW','LENGTHS','WORDS'],['LEFTTRIM','ALLOW','LENGTHS','WORDS'],['LEFTTRIM','ALLOW','LENGTHS','WORDS'],['LEFTTRIM','ALLOW','LENGTHS','WORDS'],['LEFTTRIM','ALLOW','LENGTHS','WORDS'],['LEFTTRIM','ALLOW','LENGTHS','WORDS'],['LEFTTRIM','ALLOW','LENGTHS','WORDS'],['LEFTTRIM','ALLOW','LENGTHS','WORDS'],['LEFTTRIM','ALLOW','LENGTHS','WORDS'],['LEFTTRIM','ALLOW','LENGTHS','WORDS'],['LEFTTRIM','ALLOW','LENGTHS','WORDS'],['LEFTTRIM','ALLOW','LENGTHS','WORDS'],['LEFTTRIM','ALLOW','LENGTHS','WORDS'],['LEFTTRIM','ALLOW','LENGTHS','WORDS'],['LEFTTRIM','ALLOW','LENGTHS','WORDS'],['LEFTTRIM','ALLOW','LENGTHS','WORDS'],['LEFTTRIM','ALLOW','LENGTHS','WORDS'],['LEFTTRIM','ALLOW','LENGTHS','WORDS'],['LEFTTRIM','ALLOW','LENGTHS','WORDS'],['LEFTTRIM','ALLOW','LENGTHS','WORDS'],['LEFTTRIM','ALLOW','LENGTHS','WORDS'],['LEFTTRIM','ALLOW','LENGTHS','WORDS'],['LEFTTRIM','ALLOW','LENGTHS','WORDS'],['LEFTTRIM','ALLOW','LENGTHS','WORDS'],['LEFTTRIM','ALLOW','LENGTHS','WORDS'],['LEFTTRIM','ALLOW','LENGTHS','WORDS'],['LEFTTRIM','ALLOW','LENGTHS','WORDS'],['LEFTTRIM','ALLOW','LENGTHS','WORDS'],['LEFTTRIM','ALLOW','LENGTHS','WORDS'],['LEFTTRIM','ALLOW','LENGTHS','WORDS'],['LEFTTRIM','ALLOW','LENGTHS','WORDS'],['LEFTTRIM','ALLOW','LENGTHS','WORDS'],['LEFTTRIM','ALLOW','LENGTHS','WORDS'],['LEFTTRIM','ALLOW','LENGTHS','WORDS'],['LEFTTRIM','ALLOW','LENGTHS','WORDS'],['LEFTTRIM','ALLOW','LENGTHS','WORDS'],['LEFTTRIM','ALLOW','LENGTHS','WORDS'],['LEFTTRIM','ALLOW','LENGTHS','WORDS'],['LEFTTRIM','ALLOW','LENGTHS','WORDS'],['LEFTTRIM','ALLOW','LENGTHS','WORDS'],['LEFTTRIM','ALLOW','LENGTHS','WORDS'],['LEFTTRIM','ALLOW','LENGTHS','WORDS'],['LEFTTRIM','ALLOW','LENGTHS','WORDS'],['LEFTTRIM','ALLOW','LENGTHS','WORDS'],['LEFTTRIM','ALLOW','LENGTHS','WORDS'],['LEFTTRIM','ALLOW','LENGTHS','WORDS'],['LEFTTRIM','ALLOW','LENGTHS','WORDS'],['LEFTTRIM','ALLOW','LENGTHS','WORDS'],['LEFTTRIM','ALLOW','LENGTHS','WORDS'],['LEFTTRIM','ALLOW','LENGTHS','WORDS'],['LEFTTRIM','ALLOW','LENGTHS','WORDS'],['LEFTTRIM','ALLOW','LENGTHS','WORDS'],['LEFTTRIM','ALLOW','LENGTHS','WORDS'],['LEFTTRIM','ALLOW','LENGTHS','WORDS'],['LEFTTRIM','ALLOW','LENGTHS','WORDS'],['LEFTTRIM','ALLOW','LENGTHS','WORDS'],['LEFTTRIM','ALLOW','LENGTHS','WORDS'],['LEFTTRIM','ALLOW','LENGTHS','WORDS'],['LEFTTRIM','ALLOW','LENGTHS','WORDS'],['LEFTTRIM','ALLOW','LENGTHS','WORDS'],['LEFTTRIM','ALLOW','LENGTHS','WORDS'],['LEFTTRIM','ALLOW','LENGTHS','WORDS'],['LEFTTRIM','ALLOW','LENGTHS','WORDS'],['LEFTTRIM','ALLOW','LENGTHS','WORDS'],['LEFTTRIM','ALLOW','LENGTHS','WORDS'],['LEFTTRIM','ALLOW','LENGTHS','WORDS'],['LEFTTRIM','ALLOW','LENGTHS','WORDS'],['LEFTTRIM','ALLOW','LENGTHS','WORDS'],['LEFTTRIM','ALLOW','LENGTHS','WORDS'],['LEFTTRIM','ALLOW','LENGTHS','WORDS'],['LEFTTRIM','ALLOW','LENGTHS','WORDS'],['LEFTTRIM','ALLOW','LENGTHS','WORDS'],['LEFTTRIM','ALLOW','LENGTHS','WORDS'],['LEFTTRIM','ALLOW','LENGTHS','WORDS'],['LEFTTRIM','ALLOW','LENGTHS','WORDS'],['LEFTTRIM','ALLOW','LENGTHS','WORDS'],['LEFTTRIM','ALLOW','LENGTHS','WORDS'],['LEFTTRIM','ALLOW','LENGTHS','WORDS'],['LEFTTRIM','ALLOW','LENGTHS','WORDS'],['LEFTTRIM','ALLOW','LENGTHS','WORDS'],['LEFTTRIM','ALLOW','LENGTHS','WORDS'],['LEFTTRIM','ALLOW','LENGTHS','WORDS'],['LEFTTRIM','ALLOW','LENGTHS','WORDS'],['LEFTTRIM','ALLOW','LENGTHS','WORDS'],['LEFTTRIM','ALLOW','LENGTHS','WORDS'],['LEFTTRIM','ALLOW','LENGTHS','WORDS'],['LEFTTRIM','ALLOW','LENGTHS','WORDS'],['LEFTTRIM','ALLOW','LENGTHS','WORDS'],['LEFTTRIM','ALLOW','LENGTHS','WORDS'],['LEFTTRIM','ALLOW','LENGTHS','WORDS'],['LEFTTRIM','ALLOW','LENGTHS','WORDS'],['LEFTTRIM','ALLOW','LENGTHS','WORDS'],['LEFTTRIM','ALLOW','LENGTHS','WORDS'],['LEFTTRIM','ALLOW','LENGTHS','WORDS'],['LEFTTRIM','ALLOW','LENGTHS','WORDS'],['LEFTTRIM','ALLOW','LENGTHS','WORDS'],['LEFTTRIM','ALLOW','LENGTHS','WORDS'],['LEFTTRIM','ALLOW','LENGTHS','WORDS'],['LEFTTRIM','ALLOW','LENGTHS','WORDS'],['LEFTTRIM','ALLOW','LENGTHS','WORDS'],['LEFTTRIM','ALLOW','LENGTHS','WORDS'],['LEFTTRIM','ALLOW','LENGTHS','WORDS'],['LEFTTRIM','ALLOW','LENGTHS','WORDS'],['LEFTTRIM','ALLOW','LENGTHS','WORDS'],['LEFTTRIM','ALLOW','LENGTHS','WORDS'],['LEFTTRIM','ALLOW','LENGTHS','WORDS'],['LEFTTRIM','ALLOW','LENGTHS','WORDS'],['LEFTTRIM','ALLOW','LENGTHS','WORDS'],['LEFTTRIM','ALLOW','LENGTHS','WORDS'],['LEFTTRIM','ALLOW','LENGTHS','WORDS'],['LEFTTRIM','ALLOW','LENGTHS','WORDS'],['LEFTTRIM','ALLOW','LENGTHS','WORDS'],['LEFTTRIM','ALLOW','LENGTHS','WORDS'],['LEFTTRIM','ALLOW','LENGTHS','WORDS'],['LEFTTRIM','ALLOW','LENGTHS','WORDS'],['LEFTTRIM','ALLOW','LENGTHS','WORDS'],['LEFTTRIM','ALLOW','LENGTHS','WORDS'],['LEFTTRIM','ALLOW','LENGTHS','WORDS'],['LEFTTRIM','ALLOW','LENGTHS','WORDS'],['LEFTTRIM','ALLOW','LENGTHS','WORDS'],['LEFTTRIM','ALLOW','LENGTHS','WORDS'],['LEFTTRIM','ALLOW','LENGTHS','WORDS'],['LEFTTRIM','ALLOW','LENGTHS','WORDS'],['LEFTTRIM','ALLOW','LENGTHS','WORDS'],['LEFTTRIM','ALLOW','LENGTHS','WORDS'],['LEFTTRIM','ALLOW','LENGTHS','WORDS'],['LEFTTRIM','ALLOW','LENGTHS','WORDS'],['LEFTTRIM','ALLOW','LENGTHS','WORDS'],['LEFTTRIM','ALLOW','LENGTHS','WORDS'],['LEFTTRIM','ALLOW','LENGTHS','WORDS'],['LEFTTRIM','ALLOW','LENGTHS','WORDS'],['LEFTTRIM','ALLOW','LENGTHS','WORDS'],['LEFTTRIM','ALLOW','LENGTHS','WORDS'],['LEFTTRIM','ALLOW','LENGTHS','WORDS'],['LEFTTRIM','ALLOW','LENGTHS','WORDS'],['LEFTTRIM','ALLOW','LENGTHS','WORDS'],['LEFTTRIM','ALLOW','LENGTHS','WORDS'],['LEFTTRIM','ALLOW','LENGTHS','WORDS'],[]);
EXPORT BOOLEAN InBaseLayout(UNSIGNED2 i) := CHOOSE(i,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,FALSE);
 
//Individual field level validation
 
EXPORT Make_orig_datetime_stamp(SALT39.StrType s0) := MakeFT_orig_datetime_stamp(s0);
EXPORT InValid_orig_datetime_stamp(SALT39.StrType s) := InValidFT_orig_datetime_stamp(s);
EXPORT InValidMessage_orig_datetime_stamp(UNSIGNED1 wh) := InValidMessageFT_orig_datetime_stamp(wh);
 
EXPORT Make_orig_global_company_id(SALT39.StrType s0) := MakeFT_orig_global_company_id(s0);
EXPORT InValid_orig_global_company_id(SALT39.StrType s) := InValidFT_orig_global_company_id(s);
EXPORT InValidMessage_orig_global_company_id(UNSIGNED1 wh) := InValidMessageFT_orig_global_company_id(wh);
 
EXPORT Make_orig_company_id(SALT39.StrType s0) := MakeFT_orig_company_id(s0);
EXPORT InValid_orig_company_id(SALT39.StrType s) := InValidFT_orig_company_id(s);
EXPORT InValidMessage_orig_company_id(UNSIGNED1 wh) := InValidMessageFT_orig_company_id(wh);
 
EXPORT Make_orig_product_cd(SALT39.StrType s0) := MakeFT_orig_product_cd(s0);
EXPORT InValid_orig_product_cd(SALT39.StrType s) := InValidFT_orig_product_cd(s);
EXPORT InValidMessage_orig_product_cd(UNSIGNED1 wh) := InValidMessageFT_orig_product_cd(wh);
 
EXPORT Make_orig_method(SALT39.StrType s0) := MakeFT_orig_method(s0);
EXPORT InValid_orig_method(SALT39.StrType s) := InValidFT_orig_method(s);
EXPORT InValidMessage_orig_method(UNSIGNED1 wh) := InValidMessageFT_orig_method(wh);
 
EXPORT Make_orig_vertical(SALT39.StrType s0) := MakeFT_orig_vertical(s0);
EXPORT InValid_orig_vertical(SALT39.StrType s) := InValidFT_orig_vertical(s);
EXPORT InValidMessage_orig_vertical(UNSIGNED1 wh) := InValidMessageFT_orig_vertical(wh);
 
EXPORT Make_orig_function_name(SALT39.StrType s0) := MakeFT_orig_function_name(s0);
EXPORT InValid_orig_function_name(SALT39.StrType s) := InValidFT_orig_function_name(s);
EXPORT InValidMessage_orig_function_name(UNSIGNED1 wh) := InValidMessageFT_orig_function_name(wh);
 
EXPORT Make_orig_transaction_type(SALT39.StrType s0) := MakeFT_orig_transaction_type(s0);
EXPORT InValid_orig_transaction_type(SALT39.StrType s) := InValidFT_orig_transaction_type(s);
EXPORT InValidMessage_orig_transaction_type(UNSIGNED1 wh) := InValidMessageFT_orig_transaction_type(wh);
 
EXPORT Make_orig_login_history_id(SALT39.StrType s0) := MakeFT_orig_login_history_id(s0);
EXPORT InValid_orig_login_history_id(SALT39.StrType s) := InValidFT_orig_login_history_id(s);
EXPORT InValidMessage_orig_login_history_id(UNSIGNED1 wh) := InValidMessageFT_orig_login_history_id(wh);
 
EXPORT Make_orig_job_id(SALT39.StrType s0) := MakeFT_orig_job_id(s0);
EXPORT InValid_orig_job_id(SALT39.StrType s) := InValidFT_orig_job_id(s);
EXPORT InValidMessage_orig_job_id(UNSIGNED1 wh) := InValidMessageFT_orig_job_id(wh);
 
EXPORT Make_orig_sequence_number(SALT39.StrType s0) := MakeFT_orig_sequence_number(s0);
EXPORT InValid_orig_sequence_number(SALT39.StrType s) := InValidFT_orig_sequence_number(s);
EXPORT InValidMessage_orig_sequence_number(UNSIGNED1 wh) := InValidMessageFT_orig_sequence_number(wh);
 
EXPORT Make_orig_first_name(SALT39.StrType s0) := MakeFT_orig_first_name(s0);
EXPORT InValid_orig_first_name(SALT39.StrType s) := InValidFT_orig_first_name(s);
EXPORT InValidMessage_orig_first_name(UNSIGNED1 wh) := InValidMessageFT_orig_first_name(wh);
 
EXPORT Make_orig_middle_name(SALT39.StrType s0) := MakeFT_orig_middle_name(s0);
EXPORT InValid_orig_middle_name(SALT39.StrType s) := InValidFT_orig_middle_name(s);
EXPORT InValidMessage_orig_middle_name(UNSIGNED1 wh) := InValidMessageFT_orig_middle_name(wh);
 
EXPORT Make_orig_last_name(SALT39.StrType s0) := MakeFT_orig_last_name(s0);
EXPORT InValid_orig_last_name(SALT39.StrType s) := InValidFT_orig_last_name(s);
EXPORT InValidMessage_orig_last_name(UNSIGNED1 wh) := InValidMessageFT_orig_last_name(wh);
 
EXPORT Make_orig_ssn(SALT39.StrType s0) := MakeFT_orig_ssn(s0);
EXPORT InValid_orig_ssn(SALT39.StrType s) := InValidFT_orig_ssn(s);
EXPORT InValidMessage_orig_ssn(UNSIGNED1 wh) := InValidMessageFT_orig_ssn(wh);
 
EXPORT Make_orig_dob(SALT39.StrType s0) := MakeFT_orig_dob(s0);
EXPORT InValid_orig_dob(SALT39.StrType s) := InValidFT_orig_dob(s);
EXPORT InValidMessage_orig_dob(UNSIGNED1 wh) := InValidMessageFT_orig_dob(wh);
 
EXPORT Make_orig_dl_num(SALT39.StrType s0) := MakeFT_orig_dl_num(s0);
EXPORT InValid_orig_dl_num(SALT39.StrType s) := InValidFT_orig_dl_num(s);
EXPORT InValidMessage_orig_dl_num(UNSIGNED1 wh) := InValidMessageFT_orig_dl_num(wh);
 
EXPORT Make_orig_dl_state(SALT39.StrType s0) := MakeFT_orig_dl_state(s0);
EXPORT InValid_orig_dl_state(SALT39.StrType s) := InValidFT_orig_dl_state(s);
EXPORT InValidMessage_orig_dl_state(UNSIGNED1 wh) := InValidMessageFT_orig_dl_state(wh);
 
EXPORT Make_orig_address1_addressline1(SALT39.StrType s0) := MakeFT_orig_address1_addressline1(s0);
EXPORT InValid_orig_address1_addressline1(SALT39.StrType s) := InValidFT_orig_address1_addressline1(s);
EXPORT InValidMessage_orig_address1_addressline1(UNSIGNED1 wh) := InValidMessageFT_orig_address1_addressline1(wh);
 
EXPORT Make_orig_address1_addressline2(SALT39.StrType s0) := MakeFT_orig_address1_addressline2(s0);
EXPORT InValid_orig_address1_addressline2(SALT39.StrType s) := InValidFT_orig_address1_addressline2(s);
EXPORT InValidMessage_orig_address1_addressline2(UNSIGNED1 wh) := InValidMessageFT_orig_address1_addressline2(wh);
 
EXPORT Make_orig_address1_prim_range(SALT39.StrType s0) := MakeFT_orig_address1_prim_range(s0);
EXPORT InValid_orig_address1_prim_range(SALT39.StrType s) := InValidFT_orig_address1_prim_range(s);
EXPORT InValidMessage_orig_address1_prim_range(UNSIGNED1 wh) := InValidMessageFT_orig_address1_prim_range(wh);
 
EXPORT Make_orig_address1_predir(SALT39.StrType s0) := MakeFT_orig_address1_predir(s0);
EXPORT InValid_orig_address1_predir(SALT39.StrType s) := InValidFT_orig_address1_predir(s);
EXPORT InValidMessage_orig_address1_predir(UNSIGNED1 wh) := InValidMessageFT_orig_address1_predir(wh);
 
EXPORT Make_orig_address1_prim_name(SALT39.StrType s0) := MakeFT_orig_address1_prim_name(s0);
EXPORT InValid_orig_address1_prim_name(SALT39.StrType s) := InValidFT_orig_address1_prim_name(s);
EXPORT InValidMessage_orig_address1_prim_name(UNSIGNED1 wh) := InValidMessageFT_orig_address1_prim_name(wh);
 
EXPORT Make_orig_address1_suffix(SALT39.StrType s0) := MakeFT_orig_address1_suffix(s0);
EXPORT InValid_orig_address1_suffix(SALT39.StrType s) := InValidFT_orig_address1_suffix(s);
EXPORT InValidMessage_orig_address1_suffix(UNSIGNED1 wh) := InValidMessageFT_orig_address1_suffix(wh);
 
EXPORT Make_orig_address1_postdir(SALT39.StrType s0) := MakeFT_orig_address1_postdir(s0);
EXPORT InValid_orig_address1_postdir(SALT39.StrType s) := InValidFT_orig_address1_postdir(s);
EXPORT InValidMessage_orig_address1_postdir(UNSIGNED1 wh) := InValidMessageFT_orig_address1_postdir(wh);
 
EXPORT Make_orig_address1_unit_desig(SALT39.StrType s0) := MakeFT_orig_address1_unit_desig(s0);
EXPORT InValid_orig_address1_unit_desig(SALT39.StrType s) := InValidFT_orig_address1_unit_desig(s);
EXPORT InValidMessage_orig_address1_unit_desig(UNSIGNED1 wh) := InValidMessageFT_orig_address1_unit_desig(wh);
 
EXPORT Make_orig_address1_sec_range(SALT39.StrType s0) := MakeFT_orig_address1_sec_range(s0);
EXPORT InValid_orig_address1_sec_range(SALT39.StrType s) := InValidFT_orig_address1_sec_range(s);
EXPORT InValidMessage_orig_address1_sec_range(UNSIGNED1 wh) := InValidMessageFT_orig_address1_sec_range(wh);
 
EXPORT Make_orig_address1_city(SALT39.StrType s0) := MakeFT_orig_address1_city(s0);
EXPORT InValid_orig_address1_city(SALT39.StrType s) := InValidFT_orig_address1_city(s);
EXPORT InValidMessage_orig_address1_city(UNSIGNED1 wh) := InValidMessageFT_orig_address1_city(wh);
 
EXPORT Make_orig_address1_st(SALT39.StrType s0) := MakeFT_orig_address1_st(s0);
EXPORT InValid_orig_address1_st(SALT39.StrType s) := InValidFT_orig_address1_st(s);
EXPORT InValidMessage_orig_address1_st(UNSIGNED1 wh) := InValidMessageFT_orig_address1_st(wh);
 
EXPORT Make_orig_address1_z5(SALT39.StrType s0) := MakeFT_orig_address1_z5(s0);
EXPORT InValid_orig_address1_z5(SALT39.StrType s) := InValidFT_orig_address1_z5(s);
EXPORT InValidMessage_orig_address1_z5(UNSIGNED1 wh) := InValidMessageFT_orig_address1_z5(wh);
 
EXPORT Make_orig_address1_z4(SALT39.StrType s0) := MakeFT_orig_address1_z4(s0);
EXPORT InValid_orig_address1_z4(SALT39.StrType s) := InValidFT_orig_address1_z4(s);
EXPORT InValidMessage_orig_address1_z4(UNSIGNED1 wh) := InValidMessageFT_orig_address1_z4(wh);
 
EXPORT Make_orig_address2_addressline1(SALT39.StrType s0) := MakeFT_orig_address2_addressline1(s0);
EXPORT InValid_orig_address2_addressline1(SALT39.StrType s) := InValidFT_orig_address2_addressline1(s);
EXPORT InValidMessage_orig_address2_addressline1(UNSIGNED1 wh) := InValidMessageFT_orig_address2_addressline1(wh);
 
EXPORT Make_orig_address2_addressline2(SALT39.StrType s0) := MakeFT_orig_address2_addressline2(s0);
EXPORT InValid_orig_address2_addressline2(SALT39.StrType s) := InValidFT_orig_address2_addressline2(s);
EXPORT InValidMessage_orig_address2_addressline2(UNSIGNED1 wh) := InValidMessageFT_orig_address2_addressline2(wh);
 
EXPORT Make_orig_address2_prim_range(SALT39.StrType s0) := MakeFT_orig_address2_prim_range(s0);
EXPORT InValid_orig_address2_prim_range(SALT39.StrType s) := InValidFT_orig_address2_prim_range(s);
EXPORT InValidMessage_orig_address2_prim_range(UNSIGNED1 wh) := InValidMessageFT_orig_address2_prim_range(wh);
 
EXPORT Make_orig_address2_predir(SALT39.StrType s0) := MakeFT_orig_address2_predir(s0);
EXPORT InValid_orig_address2_predir(SALT39.StrType s) := InValidFT_orig_address2_predir(s);
EXPORT InValidMessage_orig_address2_predir(UNSIGNED1 wh) := InValidMessageFT_orig_address2_predir(wh);
 
EXPORT Make_orig_address2_prim_name(SALT39.StrType s0) := MakeFT_orig_address2_prim_name(s0);
EXPORT InValid_orig_address2_prim_name(SALT39.StrType s) := InValidFT_orig_address2_prim_name(s);
EXPORT InValidMessage_orig_address2_prim_name(UNSIGNED1 wh) := InValidMessageFT_orig_address2_prim_name(wh);
 
EXPORT Make_orig_address2_suffix(SALT39.StrType s0) := MakeFT_orig_address2_suffix(s0);
EXPORT InValid_orig_address2_suffix(SALT39.StrType s) := InValidFT_orig_address2_suffix(s);
EXPORT InValidMessage_orig_address2_suffix(UNSIGNED1 wh) := InValidMessageFT_orig_address2_suffix(wh);
 
EXPORT Make_orig_address2_postdir(SALT39.StrType s0) := MakeFT_orig_address2_postdir(s0);
EXPORT InValid_orig_address2_postdir(SALT39.StrType s) := InValidFT_orig_address2_postdir(s);
EXPORT InValidMessage_orig_address2_postdir(UNSIGNED1 wh) := InValidMessageFT_orig_address2_postdir(wh);
 
EXPORT Make_orig_address2_unit_desig(SALT39.StrType s0) := MakeFT_orig_address2_unit_desig(s0);
EXPORT InValid_orig_address2_unit_desig(SALT39.StrType s) := InValidFT_orig_address2_unit_desig(s);
EXPORT InValidMessage_orig_address2_unit_desig(UNSIGNED1 wh) := InValidMessageFT_orig_address2_unit_desig(wh);
 
EXPORT Make_orig_address2_sec_range(SALT39.StrType s0) := MakeFT_orig_address2_sec_range(s0);
EXPORT InValid_orig_address2_sec_range(SALT39.StrType s) := InValidFT_orig_address2_sec_range(s);
EXPORT InValidMessage_orig_address2_sec_range(UNSIGNED1 wh) := InValidMessageFT_orig_address2_sec_range(wh);
 
EXPORT Make_orig_address2_city(SALT39.StrType s0) := MakeFT_orig_address2_city(s0);
EXPORT InValid_orig_address2_city(SALT39.StrType s) := InValidFT_orig_address2_city(s);
EXPORT InValidMessage_orig_address2_city(UNSIGNED1 wh) := InValidMessageFT_orig_address2_city(wh);
 
EXPORT Make_orig_address2_st(SALT39.StrType s0) := MakeFT_orig_address2_st(s0);
EXPORT InValid_orig_address2_st(SALT39.StrType s) := InValidFT_orig_address2_st(s);
EXPORT InValidMessage_orig_address2_st(UNSIGNED1 wh) := InValidMessageFT_orig_address2_st(wh);
 
EXPORT Make_orig_address2_z5(SALT39.StrType s0) := MakeFT_orig_address2_z5(s0);
EXPORT InValid_orig_address2_z5(SALT39.StrType s) := InValidFT_orig_address2_z5(s);
EXPORT InValidMessage_orig_address2_z5(UNSIGNED1 wh) := InValidMessageFT_orig_address2_z5(wh);
 
EXPORT Make_orig_address2_z4(SALT39.StrType s0) := MakeFT_orig_address2_z4(s0);
EXPORT InValid_orig_address2_z4(SALT39.StrType s) := InValidFT_orig_address2_z4(s);
EXPORT InValidMessage_orig_address2_z4(UNSIGNED1 wh) := InValidMessageFT_orig_address2_z4(wh);
 
EXPORT Make_orig_bdid(SALT39.StrType s0) := MakeFT_orig_bdid(s0);
EXPORT InValid_orig_bdid(SALT39.StrType s) := InValidFT_orig_bdid(s);
EXPORT InValidMessage_orig_bdid(UNSIGNED1 wh) := InValidMessageFT_orig_bdid(wh);
 
EXPORT Make_orig_bdl(SALT39.StrType s0) := MakeFT_orig_bdl(s0);
EXPORT InValid_orig_bdl(SALT39.StrType s) := InValidFT_orig_bdl(s);
EXPORT InValidMessage_orig_bdl(UNSIGNED1 wh) := InValidMessageFT_orig_bdl(wh);
 
EXPORT Make_orig_did(SALT39.StrType s0) := MakeFT_orig_did(s0);
EXPORT InValid_orig_did(SALT39.StrType s) := InValidFT_orig_did(s);
EXPORT InValidMessage_orig_did(UNSIGNED1 wh) := InValidMessageFT_orig_did(wh);
 
EXPORT Make_orig_company_name(SALT39.StrType s0) := MakeFT_orig_company_name(s0);
EXPORT InValid_orig_company_name(SALT39.StrType s) := InValidFT_orig_company_name(s);
EXPORT InValidMessage_orig_company_name(UNSIGNED1 wh) := InValidMessageFT_orig_company_name(wh);
 
EXPORT Make_orig_fein(SALT39.StrType s0) := MakeFT_orig_fein(s0);
EXPORT InValid_orig_fein(SALT39.StrType s) := InValidFT_orig_fein(s);
EXPORT InValidMessage_orig_fein(UNSIGNED1 wh) := InValidMessageFT_orig_fein(wh);
 
EXPORT Make_orig_phone(SALT39.StrType s0) := MakeFT_orig_phone(s0);
EXPORT InValid_orig_phone(SALT39.StrType s) := InValidFT_orig_phone(s);
EXPORT InValidMessage_orig_phone(UNSIGNED1 wh) := InValidMessageFT_orig_phone(wh);
 
EXPORT Make_orig_work_phone(SALT39.StrType s0) := MakeFT_orig_work_phone(s0);
EXPORT InValid_orig_work_phone(SALT39.StrType s) := InValidFT_orig_work_phone(s);
EXPORT InValidMessage_orig_work_phone(UNSIGNED1 wh) := InValidMessageFT_orig_work_phone(wh);
 
EXPORT Make_orig_company_phone(SALT39.StrType s0) := MakeFT_orig_company_phone(s0);
EXPORT InValid_orig_company_phone(SALT39.StrType s) := InValidFT_orig_company_phone(s);
EXPORT InValidMessage_orig_company_phone(UNSIGNED1 wh) := InValidMessageFT_orig_company_phone(wh);
 
EXPORT Make_orig_reference_code(SALT39.StrType s0) := MakeFT_orig_reference_code(s0);
EXPORT InValid_orig_reference_code(SALT39.StrType s) := InValidFT_orig_reference_code(s);
EXPORT InValidMessage_orig_reference_code(UNSIGNED1 wh) := InValidMessageFT_orig_reference_code(wh);
 
EXPORT Make_orig_ip_address_initiated(SALT39.StrType s0) := MakeFT_orig_ip_address_initiated(s0);
EXPORT InValid_orig_ip_address_initiated(SALT39.StrType s) := InValidFT_orig_ip_address_initiated(s);
EXPORT InValidMessage_orig_ip_address_initiated(UNSIGNED1 wh) := InValidMessageFT_orig_ip_address_initiated(wh);
 
EXPORT Make_orig_ip_address_executed(SALT39.StrType s0) := MakeFT_orig_ip_address_executed(s0);
EXPORT InValid_orig_ip_address_executed(SALT39.StrType s) := InValidFT_orig_ip_address_executed(s);
EXPORT InValidMessage_orig_ip_address_executed(UNSIGNED1 wh) := InValidMessageFT_orig_ip_address_executed(wh);
 
EXPORT Make_orig_charter_number(SALT39.StrType s0) := MakeFT_orig_charter_number(s0);
EXPORT InValid_orig_charter_number(SALT39.StrType s) := InValidFT_orig_charter_number(s);
EXPORT InValidMessage_orig_charter_number(UNSIGNED1 wh) := InValidMessageFT_orig_charter_number(wh);
 
EXPORT Make_orig_ucc_original_filing_number(SALT39.StrType s0) := MakeFT_orig_ucc_original_filing_number(s0);
EXPORT InValid_orig_ucc_original_filing_number(SALT39.StrType s) := InValidFT_orig_ucc_original_filing_number(s);
EXPORT InValidMessage_orig_ucc_original_filing_number(UNSIGNED1 wh) := InValidMessageFT_orig_ucc_original_filing_number(wh);
 
EXPORT Make_orig_email_address(SALT39.StrType s0) := MakeFT_orig_email_address(s0);
EXPORT InValid_orig_email_address(SALT39.StrType s) := InValidFT_orig_email_address(s);
EXPORT InValidMessage_orig_email_address(UNSIGNED1 wh) := InValidMessageFT_orig_email_address(wh);
 
EXPORT Make_orig_domain_name(SALT39.StrType s0) := MakeFT_orig_domain_name(s0);
EXPORT InValid_orig_domain_name(SALT39.StrType s) := InValidFT_orig_domain_name(s);
EXPORT InValidMessage_orig_domain_name(UNSIGNED1 wh) := InValidMessageFT_orig_domain_name(wh);
 
EXPORT Make_orig_full_name(SALT39.StrType s0) := MakeFT_orig_full_name(s0);
EXPORT InValid_orig_full_name(SALT39.StrType s) := InValidFT_orig_full_name(s);
EXPORT InValidMessage_orig_full_name(UNSIGNED1 wh) := InValidMessageFT_orig_full_name(wh);
 
EXPORT Make_orig_dl_purpose(SALT39.StrType s0) := MakeFT_orig_dl_purpose(s0);
EXPORT InValid_orig_dl_purpose(SALT39.StrType s) := InValidFT_orig_dl_purpose(s);
EXPORT InValidMessage_orig_dl_purpose(UNSIGNED1 wh) := InValidMessageFT_orig_dl_purpose(wh);
 
EXPORT Make_orig_glb_purpose(SALT39.StrType s0) := MakeFT_orig_glb_purpose(s0);
EXPORT InValid_orig_glb_purpose(SALT39.StrType s) := InValidFT_orig_glb_purpose(s);
EXPORT InValidMessage_orig_glb_purpose(UNSIGNED1 wh) := InValidMessageFT_orig_glb_purpose(wh);
 
EXPORT Make_orig_fcra_purpose(SALT39.StrType s0) := MakeFT_orig_fcra_purpose(s0);
EXPORT InValid_orig_fcra_purpose(SALT39.StrType s) := InValidFT_orig_fcra_purpose(s);
EXPORT InValidMessage_orig_fcra_purpose(UNSIGNED1 wh) := InValidMessageFT_orig_fcra_purpose(wh);
 
EXPORT Make_orig_process_id(SALT39.StrType s0) := MakeFT_orig_process_id(s0);
EXPORT InValid_orig_process_id(SALT39.StrType s) := InValidFT_orig_process_id(s);
EXPORT InValidMessage_orig_process_id(UNSIGNED1 wh) := InValidMessageFT_orig_process_id(wh);
 
EXPORT Make_orig_suffix_name(SALT39.StrType s0) := MakeFT_orig_suffix_name(s0);
EXPORT InValid_orig_suffix_name(SALT39.StrType s) := InValidFT_orig_suffix_name(s);
EXPORT InValidMessage_orig_suffix_name(UNSIGNED1 wh) := InValidMessageFT_orig_suffix_name(wh);
 
EXPORT Make_orig_former_last_name(SALT39.StrType s0) := MakeFT_orig_former_last_name(s0);
EXPORT InValid_orig_former_last_name(SALT39.StrType s) := InValidFT_orig_former_last_name(s);
EXPORT InValidMessage_orig_former_last_name(UNSIGNED1 wh) := InValidMessageFT_orig_former_last_name(wh);
 
EXPORT Make_orig_business_title(SALT39.StrType s0) := MakeFT_orig_business_title(s0);
EXPORT InValid_orig_business_title(SALT39.StrType s) := InValidFT_orig_business_title(s);
EXPORT InValidMessage_orig_business_title(UNSIGNED1 wh) := InValidMessageFT_orig_business_title(wh);
 
EXPORT Make_orig_company_addressline1(SALT39.StrType s0) := MakeFT_orig_company_addressline1(s0);
EXPORT InValid_orig_company_addressline1(SALT39.StrType s) := InValidFT_orig_company_addressline1(s);
EXPORT InValidMessage_orig_company_addressline1(UNSIGNED1 wh) := InValidMessageFT_orig_company_addressline1(wh);
 
EXPORT Make_orig_company_addressline2(SALT39.StrType s0) := MakeFT_orig_company_addressline2(s0);
EXPORT InValid_orig_company_addressline2(SALT39.StrType s) := InValidFT_orig_company_addressline2(s);
EXPORT InValidMessage_orig_company_addressline2(UNSIGNED1 wh) := InValidMessageFT_orig_company_addressline2(wh);
 
EXPORT Make_orig_company_address_prim_range(SALT39.StrType s0) := MakeFT_orig_company_address_prim_range(s0);
EXPORT InValid_orig_company_address_prim_range(SALT39.StrType s) := InValidFT_orig_company_address_prim_range(s);
EXPORT InValidMessage_orig_company_address_prim_range(UNSIGNED1 wh) := InValidMessageFT_orig_company_address_prim_range(wh);
 
EXPORT Make_orig_company_address_predir(SALT39.StrType s0) := MakeFT_orig_company_address_predir(s0);
EXPORT InValid_orig_company_address_predir(SALT39.StrType s) := InValidFT_orig_company_address_predir(s);
EXPORT InValidMessage_orig_company_address_predir(UNSIGNED1 wh) := InValidMessageFT_orig_company_address_predir(wh);
 
EXPORT Make_orig_company_address_prim_name(SALT39.StrType s0) := MakeFT_orig_company_address_prim_name(s0);
EXPORT InValid_orig_company_address_prim_name(SALT39.StrType s) := InValidFT_orig_company_address_prim_name(s);
EXPORT InValidMessage_orig_company_address_prim_name(UNSIGNED1 wh) := InValidMessageFT_orig_company_address_prim_name(wh);
 
EXPORT Make_orig_company_address_suffix(SALT39.StrType s0) := MakeFT_orig_company_address_suffix(s0);
EXPORT InValid_orig_company_address_suffix(SALT39.StrType s) := InValidFT_orig_company_address_suffix(s);
EXPORT InValidMessage_orig_company_address_suffix(UNSIGNED1 wh) := InValidMessageFT_orig_company_address_suffix(wh);
 
EXPORT Make_orig_company_address_postdir(SALT39.StrType s0) := MakeFT_orig_company_address_postdir(s0);
EXPORT InValid_orig_company_address_postdir(SALT39.StrType s) := InValidFT_orig_company_address_postdir(s);
EXPORT InValidMessage_orig_company_address_postdir(UNSIGNED1 wh) := InValidMessageFT_orig_company_address_postdir(wh);
 
EXPORT Make_orig_company_address_unit_desig(SALT39.StrType s0) := MakeFT_orig_company_address_unit_desig(s0);
EXPORT InValid_orig_company_address_unit_desig(SALT39.StrType s) := InValidFT_orig_company_address_unit_desig(s);
EXPORT InValidMessage_orig_company_address_unit_desig(UNSIGNED1 wh) := InValidMessageFT_orig_company_address_unit_desig(wh);
 
EXPORT Make_orig_company_address_sec_range(SALT39.StrType s0) := s0;
EXPORT InValid_orig_company_address_sec_range(SALT39.StrType s) := 0;
EXPORT InValidMessage_orig_company_address_sec_range(UNSIGNED1 wh) := '';
 
EXPORT Make_orig_company_address_city(SALT39.StrType s0) := MakeFT_orig_company_address_sec_range(s0);
EXPORT InValid_orig_company_address_city(SALT39.StrType s) := InValidFT_orig_company_address_sec_range(s);
EXPORT InValidMessage_orig_company_address_city(UNSIGNED1 wh) := InValidMessageFT_orig_company_address_sec_range(wh);
 
EXPORT Make_orig_company_address_st(SALT39.StrType s0) := MakeFT_orig_company_address_st(s0);
EXPORT InValid_orig_company_address_st(SALT39.StrType s) := InValidFT_orig_company_address_st(s);
EXPORT InValidMessage_orig_company_address_st(UNSIGNED1 wh) := InValidMessageFT_orig_company_address_st(wh);
 
EXPORT Make_orig_company_address_zip5(SALT39.StrType s0) := MakeFT_orig_company_address_zip5(s0);
EXPORT InValid_orig_company_address_zip5(SALT39.StrType s) := InValidFT_orig_company_address_zip5(s);
EXPORT InValidMessage_orig_company_address_zip5(UNSIGNED1 wh) := InValidMessageFT_orig_company_address_zip5(wh);
 
EXPORT Make_orig_company_address_zip4(SALT39.StrType s0) := MakeFT_orig_company_address_zip4(s0);
EXPORT InValid_orig_company_address_zip4(SALT39.StrType s) := InValidFT_orig_company_address_zip4(s);
EXPORT InValidMessage_orig_company_address_zip4(UNSIGNED1 wh) := InValidMessageFT_orig_company_address_zip4(wh);
 
EXPORT Make_orig_company_fax_number(SALT39.StrType s0) := MakeFT_orig_company_fax_number(s0);
EXPORT InValid_orig_company_fax_number(SALT39.StrType s) := InValidFT_orig_company_fax_number(s);
EXPORT InValidMessage_orig_company_fax_number(UNSIGNED1 wh) := InValidMessageFT_orig_company_fax_number(wh);
 
EXPORT Make_orig_company_start_date(SALT39.StrType s0) := MakeFT_orig_company_start_date(s0);
EXPORT InValid_orig_company_start_date(SALT39.StrType s) := InValidFT_orig_company_start_date(s);
EXPORT InValidMessage_orig_company_start_date(UNSIGNED1 wh) := InValidMessageFT_orig_company_start_date(wh);
 
EXPORT Make_orig_company_years_in_business(SALT39.StrType s0) := MakeFT_orig_company_years_in_business(s0);
EXPORT InValid_orig_company_years_in_business(SALT39.StrType s) := InValidFT_orig_company_years_in_business(s);
EXPORT InValidMessage_orig_company_years_in_business(UNSIGNED1 wh) := InValidMessageFT_orig_company_years_in_business(wh);
 
EXPORT Make_orig_company_sic_code(SALT39.StrType s0) := MakeFT_orig_company_sic_code(s0);
EXPORT InValid_orig_company_sic_code(SALT39.StrType s) := InValidFT_orig_company_sic_code(s);
EXPORT InValidMessage_orig_company_sic_code(UNSIGNED1 wh) := InValidMessageFT_orig_company_sic_code(wh);
 
EXPORT Make_orig_company_naic_code(SALT39.StrType s0) := MakeFT_orig_company_naic_code(s0);
EXPORT InValid_orig_company_naic_code(SALT39.StrType s) := InValidFT_orig_company_naic_code(s);
EXPORT InValidMessage_orig_company_naic_code(UNSIGNED1 wh) := InValidMessageFT_orig_company_naic_code(wh);
 
EXPORT Make_orig_company_structure(SALT39.StrType s0) := MakeFT_orig_company_structure(s0);
EXPORT InValid_orig_company_structure(SALT39.StrType s) := InValidFT_orig_company_structure(s);
EXPORT InValidMessage_orig_company_structure(UNSIGNED1 wh) := InValidMessageFT_orig_company_structure(wh);
 
EXPORT Make_orig_company_yearly_revenue(SALT39.StrType s0) := MakeFT_orig_company_yearly_revenue(s0);
EXPORT InValid_orig_company_yearly_revenue(SALT39.StrType s) := InValidFT_orig_company_yearly_revenue(s);
EXPORT InValidMessage_orig_company_yearly_revenue(UNSIGNED1 wh) := InValidMessageFT_orig_company_yearly_revenue(wh);
 
EXPORT Make_orig_subj2_first_name(SALT39.StrType s0) := MakeFT_orig_subj2_first_name(s0);
EXPORT InValid_orig_subj2_first_name(SALT39.StrType s) := InValidFT_orig_subj2_first_name(s);
EXPORT InValidMessage_orig_subj2_first_name(UNSIGNED1 wh) := InValidMessageFT_orig_subj2_first_name(wh);
 
EXPORT Make_orig_subj2_middle_name(SALT39.StrType s0) := MakeFT_orig_subj2_middle_name(s0);
EXPORT InValid_orig_subj2_middle_name(SALT39.StrType s) := InValidFT_orig_subj2_middle_name(s);
EXPORT InValidMessage_orig_subj2_middle_name(UNSIGNED1 wh) := InValidMessageFT_orig_subj2_middle_name(wh);
 
EXPORT Make_orig_subj2_last_name(SALT39.StrType s0) := MakeFT_orig_subj2_last_name(s0);
EXPORT InValid_orig_subj2_last_name(SALT39.StrType s) := InValidFT_orig_subj2_last_name(s);
EXPORT InValidMessage_orig_subj2_last_name(UNSIGNED1 wh) := InValidMessageFT_orig_subj2_last_name(wh);
 
EXPORT Make_orig_subj2_suffix_name(SALT39.StrType s0) := MakeFT_orig_subj2_suffix_name(s0);
EXPORT InValid_orig_subj2_suffix_name(SALT39.StrType s) := InValidFT_orig_subj2_suffix_name(s);
EXPORT InValidMessage_orig_subj2_suffix_name(UNSIGNED1 wh) := InValidMessageFT_orig_subj2_suffix_name(wh);
 
EXPORT Make_orig_subj2_full_name(SALT39.StrType s0) := MakeFT_orig_subj2_full_name(s0);
EXPORT InValid_orig_subj2_full_name(SALT39.StrType s) := InValidFT_orig_subj2_full_name(s);
EXPORT InValidMessage_orig_subj2_full_name(UNSIGNED1 wh) := InValidMessageFT_orig_subj2_full_name(wh);
 
EXPORT Make_orig_subj2_ssn(SALT39.StrType s0) := MakeFT_orig_subj2_ssn(s0);
EXPORT InValid_orig_subj2_ssn(SALT39.StrType s) := InValidFT_orig_subj2_ssn(s);
EXPORT InValidMessage_orig_subj2_ssn(UNSIGNED1 wh) := InValidMessageFT_orig_subj2_ssn(wh);
 
EXPORT Make_orig_subj2_dob(SALT39.StrType s0) := MakeFT_orig_subj2_dob(s0);
EXPORT InValid_orig_subj2_dob(SALT39.StrType s) := InValidFT_orig_subj2_dob(s);
EXPORT InValidMessage_orig_subj2_dob(UNSIGNED1 wh) := InValidMessageFT_orig_subj2_dob(wh);
 
EXPORT Make_orig_subj2_dl_num(SALT39.StrType s0) := MakeFT_orig_subj2_dl_num(s0);
EXPORT InValid_orig_subj2_dl_num(SALT39.StrType s) := InValidFT_orig_subj2_dl_num(s);
EXPORT InValidMessage_orig_subj2_dl_num(UNSIGNED1 wh) := InValidMessageFT_orig_subj2_dl_num(wh);
 
EXPORT Make_orig_subj2_dl_state(SALT39.StrType s0) := MakeFT_orig_subj2_dl_state(s0);
EXPORT InValid_orig_subj2_dl_state(SALT39.StrType s) := InValidFT_orig_subj2_dl_state(s);
EXPORT InValidMessage_orig_subj2_dl_state(UNSIGNED1 wh) := InValidMessageFT_orig_subj2_dl_state(wh);
 
EXPORT Make_orig_subj2_former_last_name(SALT39.StrType s0) := MakeFT_orig_subj2_former_last_name(s0);
EXPORT InValid_orig_subj2_former_last_name(SALT39.StrType s) := InValidFT_orig_subj2_former_last_name(s);
EXPORT InValidMessage_orig_subj2_former_last_name(UNSIGNED1 wh) := InValidMessageFT_orig_subj2_former_last_name(wh);
 
EXPORT Make_orig_subj2_address_addressline1(SALT39.StrType s0) := MakeFT_orig_subj2_address_addressline1(s0);
EXPORT InValid_orig_subj2_address_addressline1(SALT39.StrType s) := InValidFT_orig_subj2_address_addressline1(s);
EXPORT InValidMessage_orig_subj2_address_addressline1(UNSIGNED1 wh) := InValidMessageFT_orig_subj2_address_addressline1(wh);
 
EXPORT Make_orig_subj2_address_addressline2(SALT39.StrType s0) := MakeFT_orig_subj2_address_addressline2(s0);
EXPORT InValid_orig_subj2_address_addressline2(SALT39.StrType s) := InValidFT_orig_subj2_address_addressline2(s);
EXPORT InValidMessage_orig_subj2_address_addressline2(UNSIGNED1 wh) := InValidMessageFT_orig_subj2_address_addressline2(wh);
 
EXPORT Make_orig_subj2_address_prim_range(SALT39.StrType s0) := MakeFT_orig_subj2_address_prim_range(s0);
EXPORT InValid_orig_subj2_address_prim_range(SALT39.StrType s) := InValidFT_orig_subj2_address_prim_range(s);
EXPORT InValidMessage_orig_subj2_address_prim_range(UNSIGNED1 wh) := InValidMessageFT_orig_subj2_address_prim_range(wh);
 
EXPORT Make_orig_subj2_address_predir(SALT39.StrType s0) := MakeFT_orig_subj2_address_predir(s0);
EXPORT InValid_orig_subj2_address_predir(SALT39.StrType s) := InValidFT_orig_subj2_address_predir(s);
EXPORT InValidMessage_orig_subj2_address_predir(UNSIGNED1 wh) := InValidMessageFT_orig_subj2_address_predir(wh);
 
EXPORT Make_orig_subj2_address_prim_name(SALT39.StrType s0) := MakeFT_orig_subj2_address_prim_name(s0);
EXPORT InValid_orig_subj2_address_prim_name(SALT39.StrType s) := InValidFT_orig_subj2_address_prim_name(s);
EXPORT InValidMessage_orig_subj2_address_prim_name(UNSIGNED1 wh) := InValidMessageFT_orig_subj2_address_prim_name(wh);
 
EXPORT Make_orig_subj2_address_suffix(SALT39.StrType s0) := MakeFT_orig_subj2_address_suffix(s0);
EXPORT InValid_orig_subj2_address_suffix(SALT39.StrType s) := InValidFT_orig_subj2_address_suffix(s);
EXPORT InValidMessage_orig_subj2_address_suffix(UNSIGNED1 wh) := InValidMessageFT_orig_subj2_address_suffix(wh);
 
EXPORT Make_orig_subj2_address_postdir(SALT39.StrType s0) := MakeFT_orig_subj2_address_postdir(s0);
EXPORT InValid_orig_subj2_address_postdir(SALT39.StrType s) := InValidFT_orig_subj2_address_postdir(s);
EXPORT InValidMessage_orig_subj2_address_postdir(UNSIGNED1 wh) := InValidMessageFT_orig_subj2_address_postdir(wh);
 
EXPORT Make_orig_subj2_address_unit_desig(SALT39.StrType s0) := MakeFT_orig_subj2_address_unit_desig(s0);
EXPORT InValid_orig_subj2_address_unit_desig(SALT39.StrType s) := InValidFT_orig_subj2_address_unit_desig(s);
EXPORT InValidMessage_orig_subj2_address_unit_desig(UNSIGNED1 wh) := InValidMessageFT_orig_subj2_address_unit_desig(wh);
 
EXPORT Make_orig_subj2_address_sec_range(SALT39.StrType s0) := MakeFT_orig_subj2_address_sec_range(s0);
EXPORT InValid_orig_subj2_address_sec_range(SALT39.StrType s) := InValidFT_orig_subj2_address_sec_range(s);
EXPORT InValidMessage_orig_subj2_address_sec_range(UNSIGNED1 wh) := InValidMessageFT_orig_subj2_address_sec_range(wh);
 
EXPORT Make_orig_subj2_address_city(SALT39.StrType s0) := MakeFT_orig_subj2_address_city(s0);
EXPORT InValid_orig_subj2_address_city(SALT39.StrType s) := InValidFT_orig_subj2_address_city(s);
EXPORT InValidMessage_orig_subj2_address_city(UNSIGNED1 wh) := InValidMessageFT_orig_subj2_address_city(wh);
 
EXPORT Make_orig_subj2_address_st(SALT39.StrType s0) := MakeFT_orig_subj2_address_st(s0);
EXPORT InValid_orig_subj2_address_st(SALT39.StrType s) := InValidFT_orig_subj2_address_st(s);
EXPORT InValidMessage_orig_subj2_address_st(UNSIGNED1 wh) := InValidMessageFT_orig_subj2_address_st(wh);
 
EXPORT Make_orig_subj2_address_z5(SALT39.StrType s0) := MakeFT_orig_subj2_address_z5(s0);
EXPORT InValid_orig_subj2_address_z5(SALT39.StrType s) := InValidFT_orig_subj2_address_z5(s);
EXPORT InValidMessage_orig_subj2_address_z5(UNSIGNED1 wh) := InValidMessageFT_orig_subj2_address_z5(wh);
 
EXPORT Make_orig_subj2_address_z4(SALT39.StrType s0) := MakeFT_orig_subj2_address_z4(s0);
EXPORT InValid_orig_subj2_address_z4(SALT39.StrType s) := InValidFT_orig_subj2_address_z4(s);
EXPORT InValidMessage_orig_subj2_address_z4(UNSIGNED1 wh) := InValidMessageFT_orig_subj2_address_z4(wh);
 
EXPORT Make_orig_subj2_phone(SALT39.StrType s0) := MakeFT_orig_subj2_phone(s0);
EXPORT InValid_orig_subj2_phone(SALT39.StrType s) := InValidFT_orig_subj2_phone(s);
EXPORT InValidMessage_orig_subj2_phone(UNSIGNED1 wh) := InValidMessageFT_orig_subj2_phone(wh);
 
EXPORT Make_orig_subj2_work_phone(SALT39.StrType s0) := MakeFT_orig_subj2_work_phone(s0);
EXPORT InValid_orig_subj2_work_phone(SALT39.StrType s) := InValidFT_orig_subj2_work_phone(s);
EXPORT InValidMessage_orig_subj2_work_phone(UNSIGNED1 wh) := InValidMessageFT_orig_subj2_work_phone(wh);
 
EXPORT Make_orig_subj2_business_title(SALT39.StrType s0) := MakeFT_orig_subj2_business_title(s0);
EXPORT InValid_orig_subj2_business_title(SALT39.StrType s) := InValidFT_orig_subj2_business_title(s);
EXPORT InValidMessage_orig_subj2_business_title(UNSIGNED1 wh) := InValidMessageFT_orig_subj2_business_title(wh);
 
EXPORT Make_orig_subj3_first_name(SALT39.StrType s0) := MakeFT_orig_subj3_first_name(s0);
EXPORT InValid_orig_subj3_first_name(SALT39.StrType s) := InValidFT_orig_subj3_first_name(s);
EXPORT InValidMessage_orig_subj3_first_name(UNSIGNED1 wh) := InValidMessageFT_orig_subj3_first_name(wh);
 
EXPORT Make_orig_subj3_middle_name(SALT39.StrType s0) := MakeFT_orig_subj3_middle_name(s0);
EXPORT InValid_orig_subj3_middle_name(SALT39.StrType s) := InValidFT_orig_subj3_middle_name(s);
EXPORT InValidMessage_orig_subj3_middle_name(UNSIGNED1 wh) := InValidMessageFT_orig_subj3_middle_name(wh);
 
EXPORT Make_orig_subj3_last_name(SALT39.StrType s0) := MakeFT_orig_subj3_last_name(s0);
EXPORT InValid_orig_subj3_last_name(SALT39.StrType s) := InValidFT_orig_subj3_last_name(s);
EXPORT InValidMessage_orig_subj3_last_name(UNSIGNED1 wh) := InValidMessageFT_orig_subj3_last_name(wh);
 
EXPORT Make_orig_subj3_suffix_name(SALT39.StrType s0) := MakeFT_orig_subj3_suffix_name(s0);
EXPORT InValid_orig_subj3_suffix_name(SALT39.StrType s) := InValidFT_orig_subj3_suffix_name(s);
EXPORT InValidMessage_orig_subj3_suffix_name(UNSIGNED1 wh) := InValidMessageFT_orig_subj3_suffix_name(wh);
 
EXPORT Make_orig_subj3_full_name(SALT39.StrType s0) := MakeFT_orig_subj3_full_name(s0);
EXPORT InValid_orig_subj3_full_name(SALT39.StrType s) := InValidFT_orig_subj3_full_name(s);
EXPORT InValidMessage_orig_subj3_full_name(UNSIGNED1 wh) := InValidMessageFT_orig_subj3_full_name(wh);
 
EXPORT Make_orig_subj3_ssn(SALT39.StrType s0) := MakeFT_orig_subj3_ssn(s0);
EXPORT InValid_orig_subj3_ssn(SALT39.StrType s) := InValidFT_orig_subj3_ssn(s);
EXPORT InValidMessage_orig_subj3_ssn(UNSIGNED1 wh) := InValidMessageFT_orig_subj3_ssn(wh);
 
EXPORT Make_orig_subj3_dob(SALT39.StrType s0) := MakeFT_orig_subj3_dob(s0);
EXPORT InValid_orig_subj3_dob(SALT39.StrType s) := InValidFT_orig_subj3_dob(s);
EXPORT InValidMessage_orig_subj3_dob(UNSIGNED1 wh) := InValidMessageFT_orig_subj3_dob(wh);
 
EXPORT Make_orig_subj3_dl_num(SALT39.StrType s0) := MakeFT_orig_subj3_dl_num(s0);
EXPORT InValid_orig_subj3_dl_num(SALT39.StrType s) := InValidFT_orig_subj3_dl_num(s);
EXPORT InValidMessage_orig_subj3_dl_num(UNSIGNED1 wh) := InValidMessageFT_orig_subj3_dl_num(wh);
 
EXPORT Make_orig_subj3_dl_state(SALT39.StrType s0) := MakeFT_orig_subj3_dl_state(s0);
EXPORT InValid_orig_subj3_dl_state(SALT39.StrType s) := InValidFT_orig_subj3_dl_state(s);
EXPORT InValidMessage_orig_subj3_dl_state(UNSIGNED1 wh) := InValidMessageFT_orig_subj3_dl_state(wh);
 
EXPORT Make_orig_subj3_former_last_name(SALT39.StrType s0) := MakeFT_orig_subj3_former_last_name(s0);
EXPORT InValid_orig_subj3_former_last_name(SALT39.StrType s) := InValidFT_orig_subj3_former_last_name(s);
EXPORT InValidMessage_orig_subj3_former_last_name(UNSIGNED1 wh) := InValidMessageFT_orig_subj3_former_last_name(wh);
 
EXPORT Make_orig_subj3_address_addressline1(SALT39.StrType s0) := MakeFT_orig_subj3_address_addressline1(s0);
EXPORT InValid_orig_subj3_address_addressline1(SALT39.StrType s) := InValidFT_orig_subj3_address_addressline1(s);
EXPORT InValidMessage_orig_subj3_address_addressline1(UNSIGNED1 wh) := InValidMessageFT_orig_subj3_address_addressline1(wh);
 
EXPORT Make_orig_subj3_address_addressline2(SALT39.StrType s0) := MakeFT_orig_subj3_address_addressline2(s0);
EXPORT InValid_orig_subj3_address_addressline2(SALT39.StrType s) := InValidFT_orig_subj3_address_addressline2(s);
EXPORT InValidMessage_orig_subj3_address_addressline2(UNSIGNED1 wh) := InValidMessageFT_orig_subj3_address_addressline2(wh);
 
EXPORT Make_orig_subj3_address_prim_range(SALT39.StrType s0) := MakeFT_orig_subj3_address_prim_range(s0);
EXPORT InValid_orig_subj3_address_prim_range(SALT39.StrType s) := InValidFT_orig_subj3_address_prim_range(s);
EXPORT InValidMessage_orig_subj3_address_prim_range(UNSIGNED1 wh) := InValidMessageFT_orig_subj3_address_prim_range(wh);
 
EXPORT Make_orig_subj3_address_predir(SALT39.StrType s0) := MakeFT_orig_subj3_address_predir(s0);
EXPORT InValid_orig_subj3_address_predir(SALT39.StrType s) := InValidFT_orig_subj3_address_predir(s);
EXPORT InValidMessage_orig_subj3_address_predir(UNSIGNED1 wh) := InValidMessageFT_orig_subj3_address_predir(wh);
 
EXPORT Make_orig_subj3_address_prim_name(SALT39.StrType s0) := MakeFT_orig_subj3_address_prim_name(s0);
EXPORT InValid_orig_subj3_address_prim_name(SALT39.StrType s) := InValidFT_orig_subj3_address_prim_name(s);
EXPORT InValidMessage_orig_subj3_address_prim_name(UNSIGNED1 wh) := InValidMessageFT_orig_subj3_address_prim_name(wh);
 
EXPORT Make_orig_subj3_address_suffix(SALT39.StrType s0) := MakeFT_orig_subj3_address_suffix(s0);
EXPORT InValid_orig_subj3_address_suffix(SALT39.StrType s) := InValidFT_orig_subj3_address_suffix(s);
EXPORT InValidMessage_orig_subj3_address_suffix(UNSIGNED1 wh) := InValidMessageFT_orig_subj3_address_suffix(wh);
 
EXPORT Make_orig_subj3_address_postdir(SALT39.StrType s0) := MakeFT_orig_subj3_address_postdir(s0);
EXPORT InValid_orig_subj3_address_postdir(SALT39.StrType s) := InValidFT_orig_subj3_address_postdir(s);
EXPORT InValidMessage_orig_subj3_address_postdir(UNSIGNED1 wh) := InValidMessageFT_orig_subj3_address_postdir(wh);
 
EXPORT Make_orig_subj3_address_unit_desig(SALT39.StrType s0) := MakeFT_orig_subj3_address_unit_desig(s0);
EXPORT InValid_orig_subj3_address_unit_desig(SALT39.StrType s) := InValidFT_orig_subj3_address_unit_desig(s);
EXPORT InValidMessage_orig_subj3_address_unit_desig(UNSIGNED1 wh) := InValidMessageFT_orig_subj3_address_unit_desig(wh);
 
EXPORT Make_orig_subj3_address_sec_range(SALT39.StrType s0) := MakeFT_orig_subj3_address_sec_range(s0);
EXPORT InValid_orig_subj3_address_sec_range(SALT39.StrType s) := InValidFT_orig_subj3_address_sec_range(s);
EXPORT InValidMessage_orig_subj3_address_sec_range(UNSIGNED1 wh) := InValidMessageFT_orig_subj3_address_sec_range(wh);
 
EXPORT Make_orig_subj3_address_city(SALT39.StrType s0) := MakeFT_orig_subj3_address_city(s0);
EXPORT InValid_orig_subj3_address_city(SALT39.StrType s) := InValidFT_orig_subj3_address_city(s);
EXPORT InValidMessage_orig_subj3_address_city(UNSIGNED1 wh) := InValidMessageFT_orig_subj3_address_city(wh);
 
EXPORT Make_orig_subj3_address_st(SALT39.StrType s0) := MakeFT_orig_subj3_address_st(s0);
EXPORT InValid_orig_subj3_address_st(SALT39.StrType s) := InValidFT_orig_subj3_address_st(s);
EXPORT InValidMessage_orig_subj3_address_st(UNSIGNED1 wh) := InValidMessageFT_orig_subj3_address_st(wh);
 
EXPORT Make_orig_subj3_address_z5(SALT39.StrType s0) := MakeFT_orig_subj3_address_z5(s0);
EXPORT InValid_orig_subj3_address_z5(SALT39.StrType s) := InValidFT_orig_subj3_address_z5(s);
EXPORT InValidMessage_orig_subj3_address_z5(UNSIGNED1 wh) := InValidMessageFT_orig_subj3_address_z5(wh);
 
EXPORT Make_orig_subj3_address_z4(SALT39.StrType s0) := MakeFT_orig_subj3_address_z4(s0);
EXPORT InValid_orig_subj3_address_z4(SALT39.StrType s) := InValidFT_orig_subj3_address_z4(s);
EXPORT InValidMessage_orig_subj3_address_z4(UNSIGNED1 wh) := InValidMessageFT_orig_subj3_address_z4(wh);
 
EXPORT Make_orig_subj3_phone(SALT39.StrType s0) := MakeFT_orig_subj3_phone(s0);
EXPORT InValid_orig_subj3_phone(SALT39.StrType s) := InValidFT_orig_subj3_phone(s);
EXPORT InValidMessage_orig_subj3_phone(UNSIGNED1 wh) := InValidMessageFT_orig_subj3_phone(wh);
 
EXPORT Make_orig_subj3_work_phone(SALT39.StrType s0) := MakeFT_orig_subj3_work_phone(s0);
EXPORT InValid_orig_subj3_work_phone(SALT39.StrType s) := InValidFT_orig_subj3_work_phone(s);
EXPORT InValidMessage_orig_subj3_work_phone(UNSIGNED1 wh) := InValidMessageFT_orig_subj3_work_phone(wh);
 
EXPORT Make_orig_subj3_business_title(SALT39.StrType s0) := MakeFT_orig_subj3_business_title(s0);
EXPORT InValid_orig_subj3_business_title(SALT39.StrType s) := InValidFT_orig_subj3_business_title(s);
EXPORT InValidMessage_orig_subj3_business_title(UNSIGNED1 wh) := InValidMessageFT_orig_subj3_business_title(wh);
 
EXPORT Make_orig_email(SALT39.StrType s0) := MakeFT_orig_email(s0);
EXPORT InValid_orig_email(SALT39.StrType s) := InValidFT_orig_email(s);
EXPORT InValidMessage_orig_email(UNSIGNED1 wh) := InValidMessageFT_orig_email(wh);
 
EXPORT Make_orig_subj2_email(SALT39.StrType s0) := MakeFT_orig_subj2_email(s0);
EXPORT InValid_orig_subj2_email(SALT39.StrType s) := InValidFT_orig_subj2_email(s);
EXPORT InValidMessage_orig_subj2_email(UNSIGNED1 wh) := InValidMessageFT_orig_subj2_email(wh);
 
EXPORT Make_orig_subj2_company_name(SALT39.StrType s0) := MakeFT_orig_subj2_company_name(s0);
EXPORT InValid_orig_subj2_company_name(SALT39.StrType s) := InValidFT_orig_subj2_company_name(s);
EXPORT InValidMessage_orig_subj2_company_name(UNSIGNED1 wh) := InValidMessageFT_orig_subj2_company_name(wh);
 
EXPORT Make_orig_subj2_fein(SALT39.StrType s0) := MakeFT_orig_subj2_fein(s0);
EXPORT InValid_orig_subj2_fein(SALT39.StrType s) := InValidFT_orig_subj2_fein(s);
EXPORT InValidMessage_orig_subj2_fein(UNSIGNED1 wh) := InValidMessageFT_orig_subj2_fein(wh);
 
EXPORT Make_orig_subj3_email(SALT39.StrType s0) := MakeFT_orig_subj3_email(s0);
EXPORT InValid_orig_subj3_email(SALT39.StrType s) := InValidFT_orig_subj3_email(s);
EXPORT InValidMessage_orig_subj3_email(UNSIGNED1 wh) := InValidMessageFT_orig_subj3_email(wh);
 
EXPORT Make_orig_subj3_company_name(SALT39.StrType s0) := MakeFT_orig_subj3_company_name(s0);
EXPORT InValid_orig_subj3_company_name(SALT39.StrType s) := InValidFT_orig_subj3_company_name(s);
EXPORT InValidMessage_orig_subj3_company_name(UNSIGNED1 wh) := InValidMessageFT_orig_subj3_company_name(wh);
 
EXPORT Make_orig_subj3_fein(SALT39.StrType s0) := MakeFT_orig_subj3_fein(s0);
EXPORT InValid_orig_subj3_fein(SALT39.StrType s) := InValidFT_orig_subj3_fein(s);
EXPORT InValidMessage_orig_subj3_fein(UNSIGNED1 wh) := InValidMessageFT_orig_subj3_fein(wh);
 
EXPORT Make_orig_subj4_first_name(SALT39.StrType s0) := MakeFT_orig_subj4_first_name(s0);
EXPORT InValid_orig_subj4_first_name(SALT39.StrType s) := InValidFT_orig_subj4_first_name(s);
EXPORT InValidMessage_orig_subj4_first_name(UNSIGNED1 wh) := InValidMessageFT_orig_subj4_first_name(wh);
 
EXPORT Make_orig_subj4_middle_name(SALT39.StrType s0) := MakeFT_orig_subj4_middle_name(s0);
EXPORT InValid_orig_subj4_middle_name(SALT39.StrType s) := InValidFT_orig_subj4_middle_name(s);
EXPORT InValidMessage_orig_subj4_middle_name(UNSIGNED1 wh) := InValidMessageFT_orig_subj4_middle_name(wh);
 
EXPORT Make_orig_subj4_last_name(SALT39.StrType s0) := MakeFT_orig_subj4_last_name(s0);
EXPORT InValid_orig_subj4_last_name(SALT39.StrType s) := InValidFT_orig_subj4_last_name(s);
EXPORT InValidMessage_orig_subj4_last_name(UNSIGNED1 wh) := InValidMessageFT_orig_subj4_last_name(wh);
 
EXPORT Make_orig_subj4_suffix_name(SALT39.StrType s0) := MakeFT_orig_subj4_suffix_name(s0);
EXPORT InValid_orig_subj4_suffix_name(SALT39.StrType s) := InValidFT_orig_subj4_suffix_name(s);
EXPORT InValidMessage_orig_subj4_suffix_name(UNSIGNED1 wh) := InValidMessageFT_orig_subj4_suffix_name(wh);
 
EXPORT Make_orig_subj4_full_name(SALT39.StrType s0) := MakeFT_orig_subj4_full_name(s0);
EXPORT InValid_orig_subj4_full_name(SALT39.StrType s) := InValidFT_orig_subj4_full_name(s);
EXPORT InValidMessage_orig_subj4_full_name(UNSIGNED1 wh) := InValidMessageFT_orig_subj4_full_name(wh);
 
EXPORT Make_orig_subj4_ssn(SALT39.StrType s0) := MakeFT_orig_subj4_ssn(s0);
EXPORT InValid_orig_subj4_ssn(SALT39.StrType s) := InValidFT_orig_subj4_ssn(s);
EXPORT InValidMessage_orig_subj4_ssn(UNSIGNED1 wh) := InValidMessageFT_orig_subj4_ssn(wh);
 
EXPORT Make_orig_subj4_dob(SALT39.StrType s0) := MakeFT_orig_subj4_dob(s0);
EXPORT InValid_orig_subj4_dob(SALT39.StrType s) := InValidFT_orig_subj4_dob(s);
EXPORT InValidMessage_orig_subj4_dob(UNSIGNED1 wh) := InValidMessageFT_orig_subj4_dob(wh);
 
EXPORT Make_orig_subj4_dl_num(SALT39.StrType s0) := MakeFT_orig_subj4_dl_num(s0);
EXPORT InValid_orig_subj4_dl_num(SALT39.StrType s) := InValidFT_orig_subj4_dl_num(s);
EXPORT InValidMessage_orig_subj4_dl_num(UNSIGNED1 wh) := InValidMessageFT_orig_subj4_dl_num(wh);
 
EXPORT Make_orig_subj4_dl_state(SALT39.StrType s0) := MakeFT_orig_subj4_dl_state(s0);
EXPORT InValid_orig_subj4_dl_state(SALT39.StrType s) := InValidFT_orig_subj4_dl_state(s);
EXPORT InValidMessage_orig_subj4_dl_state(UNSIGNED1 wh) := InValidMessageFT_orig_subj4_dl_state(wh);
 
EXPORT Make_orig_subj4_former_last_name(SALT39.StrType s0) := MakeFT_orig_subj4_former_last_name(s0);
EXPORT InValid_orig_subj4_former_last_name(SALT39.StrType s) := InValidFT_orig_subj4_former_last_name(s);
EXPORT InValidMessage_orig_subj4_former_last_name(UNSIGNED1 wh) := InValidMessageFT_orig_subj4_former_last_name(wh);
 
EXPORT Make_orig_subj4_address_addressline1(SALT39.StrType s0) := MakeFT_orig_subj4_address_addressline1(s0);
EXPORT InValid_orig_subj4_address_addressline1(SALT39.StrType s) := InValidFT_orig_subj4_address_addressline1(s);
EXPORT InValidMessage_orig_subj4_address_addressline1(UNSIGNED1 wh) := InValidMessageFT_orig_subj4_address_addressline1(wh);
 
EXPORT Make_orig_subj4_address_addressline2(SALT39.StrType s0) := MakeFT_orig_subj4_address_addressline2(s0);
EXPORT InValid_orig_subj4_address_addressline2(SALT39.StrType s) := InValidFT_orig_subj4_address_addressline2(s);
EXPORT InValidMessage_orig_subj4_address_addressline2(UNSIGNED1 wh) := InValidMessageFT_orig_subj4_address_addressline2(wh);
 
EXPORT Make_orig_subj4_address_prim_range(SALT39.StrType s0) := MakeFT_orig_subj4_address_prim_range(s0);
EXPORT InValid_orig_subj4_address_prim_range(SALT39.StrType s) := InValidFT_orig_subj4_address_prim_range(s);
EXPORT InValidMessage_orig_subj4_address_prim_range(UNSIGNED1 wh) := InValidMessageFT_orig_subj4_address_prim_range(wh);
 
EXPORT Make_orig_subj4_address_predir(SALT39.StrType s0) := MakeFT_orig_subj4_address_predir(s0);
EXPORT InValid_orig_subj4_address_predir(SALT39.StrType s) := InValidFT_orig_subj4_address_predir(s);
EXPORT InValidMessage_orig_subj4_address_predir(UNSIGNED1 wh) := InValidMessageFT_orig_subj4_address_predir(wh);
 
EXPORT Make_orig_subj4_address_prim_name(SALT39.StrType s0) := MakeFT_orig_subj4_address_prim_name(s0);
EXPORT InValid_orig_subj4_address_prim_name(SALT39.StrType s) := InValidFT_orig_subj4_address_prim_name(s);
EXPORT InValidMessage_orig_subj4_address_prim_name(UNSIGNED1 wh) := InValidMessageFT_orig_subj4_address_prim_name(wh);
 
EXPORT Make_orig_subj4_address_suffix(SALT39.StrType s0) := MakeFT_orig_subj4_address_suffix(s0);
EXPORT InValid_orig_subj4_address_suffix(SALT39.StrType s) := InValidFT_orig_subj4_address_suffix(s);
EXPORT InValidMessage_orig_subj4_address_suffix(UNSIGNED1 wh) := InValidMessageFT_orig_subj4_address_suffix(wh);
 
EXPORT Make_orig_subj4_address_postdir(SALT39.StrType s0) := MakeFT_orig_subj4_address_postdir(s0);
EXPORT InValid_orig_subj4_address_postdir(SALT39.StrType s) := InValidFT_orig_subj4_address_postdir(s);
EXPORT InValidMessage_orig_subj4_address_postdir(UNSIGNED1 wh) := InValidMessageFT_orig_subj4_address_postdir(wh);
 
EXPORT Make_orig_subj4_address_unit_desig(SALT39.StrType s0) := MakeFT_orig_subj4_address_unit_desig(s0);
EXPORT InValid_orig_subj4_address_unit_desig(SALT39.StrType s) := InValidFT_orig_subj4_address_unit_desig(s);
EXPORT InValidMessage_orig_subj4_address_unit_desig(UNSIGNED1 wh) := InValidMessageFT_orig_subj4_address_unit_desig(wh);
 
EXPORT Make_orig_subj4_address_sec_range(SALT39.StrType s0) := MakeFT_orig_subj4_address_sec_range(s0);
EXPORT InValid_orig_subj4_address_sec_range(SALT39.StrType s) := InValidFT_orig_subj4_address_sec_range(s);
EXPORT InValidMessage_orig_subj4_address_sec_range(UNSIGNED1 wh) := InValidMessageFT_orig_subj4_address_sec_range(wh);
 
EXPORT Make_orig_subj4_address_city(SALT39.StrType s0) := MakeFT_orig_subj4_address_city(s0);
EXPORT InValid_orig_subj4_address_city(SALT39.StrType s) := InValidFT_orig_subj4_address_city(s);
EXPORT InValidMessage_orig_subj4_address_city(UNSIGNED1 wh) := InValidMessageFT_orig_subj4_address_city(wh);
 
EXPORT Make_orig_subj4_address_st(SALT39.StrType s0) := MakeFT_orig_subj4_address_st(s0);
EXPORT InValid_orig_subj4_address_st(SALT39.StrType s) := InValidFT_orig_subj4_address_st(s);
EXPORT InValidMessage_orig_subj4_address_st(UNSIGNED1 wh) := InValidMessageFT_orig_subj4_address_st(wh);
 
EXPORT Make_orig_subj4_address_z5(SALT39.StrType s0) := MakeFT_orig_subj4_address_z5(s0);
EXPORT InValid_orig_subj4_address_z5(SALT39.StrType s) := InValidFT_orig_subj4_address_z5(s);
EXPORT InValidMessage_orig_subj4_address_z5(UNSIGNED1 wh) := InValidMessageFT_orig_subj4_address_z5(wh);
 
EXPORT Make_orig_subj4_address_z4(SALT39.StrType s0) := MakeFT_orig_subj4_address_z4(s0);
EXPORT InValid_orig_subj4_address_z4(SALT39.StrType s) := InValidFT_orig_subj4_address_z4(s);
EXPORT InValidMessage_orig_subj4_address_z4(UNSIGNED1 wh) := InValidMessageFT_orig_subj4_address_z4(wh);
 
EXPORT Make_orig_subj4_phone(SALT39.StrType s0) := MakeFT_orig_subj4_phone(s0);
EXPORT InValid_orig_subj4_phone(SALT39.StrType s) := InValidFT_orig_subj4_phone(s);
EXPORT InValidMessage_orig_subj4_phone(UNSIGNED1 wh) := InValidMessageFT_orig_subj4_phone(wh);
 
EXPORT Make_orig_subj4_work_phone(SALT39.StrType s0) := MakeFT_orig_subj4_work_phone(s0);
EXPORT InValid_orig_subj4_work_phone(SALT39.StrType s) := InValidFT_orig_subj4_work_phone(s);
EXPORT InValidMessage_orig_subj4_work_phone(UNSIGNED1 wh) := InValidMessageFT_orig_subj4_work_phone(wh);
 
EXPORT Make_orig_subj4_business_title(SALT39.StrType s0) := MakeFT_orig_subj4_business_title(s0);
EXPORT InValid_orig_subj4_business_title(SALT39.StrType s) := InValidFT_orig_subj4_business_title(s);
EXPORT InValidMessage_orig_subj4_business_title(UNSIGNED1 wh) := InValidMessageFT_orig_subj4_business_title(wh);
 
EXPORT Make_orig_subj4_email(SALT39.StrType s0) := MakeFT_orig_subj4_email(s0);
EXPORT InValid_orig_subj4_email(SALT39.StrType s) := InValidFT_orig_subj4_email(s);
EXPORT InValidMessage_orig_subj4_email(UNSIGNED1 wh) := InValidMessageFT_orig_subj4_email(wh);
 
EXPORT Make_orig_subj4_company_name(SALT39.StrType s0) := MakeFT_orig_subj4_company_name(s0);
EXPORT InValid_orig_subj4_company_name(SALT39.StrType s) := InValidFT_orig_subj4_company_name(s);
EXPORT InValidMessage_orig_subj4_company_name(UNSIGNED1 wh) := InValidMessageFT_orig_subj4_company_name(wh);
 
EXPORT Make_orig_subj4_fein(SALT39.StrType s0) := MakeFT_orig_subj4_fein(s0);
EXPORT InValid_orig_subj4_fein(SALT39.StrType s) := InValidFT_orig_subj4_fein(s);
EXPORT InValidMessage_orig_subj4_fein(UNSIGNED1 wh) := InValidMessageFT_orig_subj4_fein(wh);
 
EXPORT Make_orig_subj5_first_name(SALT39.StrType s0) := MakeFT_orig_subj5_first_name(s0);
EXPORT InValid_orig_subj5_first_name(SALT39.StrType s) := InValidFT_orig_subj5_first_name(s);
EXPORT InValidMessage_orig_subj5_first_name(UNSIGNED1 wh) := InValidMessageFT_orig_subj5_first_name(wh);
 
EXPORT Make_orig_subj5_middle_name(SALT39.StrType s0) := MakeFT_orig_subj5_middle_name(s0);
EXPORT InValid_orig_subj5_middle_name(SALT39.StrType s) := InValidFT_orig_subj5_middle_name(s);
EXPORT InValidMessage_orig_subj5_middle_name(UNSIGNED1 wh) := InValidMessageFT_orig_subj5_middle_name(wh);
 
EXPORT Make_orig_subj5_last_name(SALT39.StrType s0) := MakeFT_orig_subj5_last_name(s0);
EXPORT InValid_orig_subj5_last_name(SALT39.StrType s) := InValidFT_orig_subj5_last_name(s);
EXPORT InValidMessage_orig_subj5_last_name(UNSIGNED1 wh) := InValidMessageFT_orig_subj5_last_name(wh);
 
EXPORT Make_orig_subj5_suffix_name(SALT39.StrType s0) := MakeFT_orig_subj5_suffix_name(s0);
EXPORT InValid_orig_subj5_suffix_name(SALT39.StrType s) := InValidFT_orig_subj5_suffix_name(s);
EXPORT InValidMessage_orig_subj5_suffix_name(UNSIGNED1 wh) := InValidMessageFT_orig_subj5_suffix_name(wh);
 
EXPORT Make_orig_subj5_full_name(SALT39.StrType s0) := MakeFT_orig_subj5_full_name(s0);
EXPORT InValid_orig_subj5_full_name(SALT39.StrType s) := InValidFT_orig_subj5_full_name(s);
EXPORT InValidMessage_orig_subj5_full_name(UNSIGNED1 wh) := InValidMessageFT_orig_subj5_full_name(wh);
 
EXPORT Make_orig_subj5_ssn(SALT39.StrType s0) := MakeFT_orig_subj5_ssn(s0);
EXPORT InValid_orig_subj5_ssn(SALT39.StrType s) := InValidFT_orig_subj5_ssn(s);
EXPORT InValidMessage_orig_subj5_ssn(UNSIGNED1 wh) := InValidMessageFT_orig_subj5_ssn(wh);
 
EXPORT Make_orig_subj5_dob(SALT39.StrType s0) := MakeFT_orig_subj5_dob(s0);
EXPORT InValid_orig_subj5_dob(SALT39.StrType s) := InValidFT_orig_subj5_dob(s);
EXPORT InValidMessage_orig_subj5_dob(UNSIGNED1 wh) := InValidMessageFT_orig_subj5_dob(wh);
 
EXPORT Make_orig_subj5_dl_num(SALT39.StrType s0) := MakeFT_orig_subj5_dl_num(s0);
EXPORT InValid_orig_subj5_dl_num(SALT39.StrType s) := InValidFT_orig_subj5_dl_num(s);
EXPORT InValidMessage_orig_subj5_dl_num(UNSIGNED1 wh) := InValidMessageFT_orig_subj5_dl_num(wh);
 
EXPORT Make_orig_subj5_dl_state(SALT39.StrType s0) := MakeFT_orig_subj5_dl_state(s0);
EXPORT InValid_orig_subj5_dl_state(SALT39.StrType s) := InValidFT_orig_subj5_dl_state(s);
EXPORT InValidMessage_orig_subj5_dl_state(UNSIGNED1 wh) := InValidMessageFT_orig_subj5_dl_state(wh);
 
EXPORT Make_orig_subj5_former_last_name(SALT39.StrType s0) := MakeFT_orig_subj5_former_last_name(s0);
EXPORT InValid_orig_subj5_former_last_name(SALT39.StrType s) := InValidFT_orig_subj5_former_last_name(s);
EXPORT InValidMessage_orig_subj5_former_last_name(UNSIGNED1 wh) := InValidMessageFT_orig_subj5_former_last_name(wh);
 
EXPORT Make_orig_subj5_address_addressline1(SALT39.StrType s0) := MakeFT_orig_subj5_address_addressline1(s0);
EXPORT InValid_orig_subj5_address_addressline1(SALT39.StrType s) := InValidFT_orig_subj5_address_addressline1(s);
EXPORT InValidMessage_orig_subj5_address_addressline1(UNSIGNED1 wh) := InValidMessageFT_orig_subj5_address_addressline1(wh);
 
EXPORT Make_orig_subj5_address_addressline2(SALT39.StrType s0) := MakeFT_orig_subj5_address_addressline2(s0);
EXPORT InValid_orig_subj5_address_addressline2(SALT39.StrType s) := InValidFT_orig_subj5_address_addressline2(s);
EXPORT InValidMessage_orig_subj5_address_addressline2(UNSIGNED1 wh) := InValidMessageFT_orig_subj5_address_addressline2(wh);
 
EXPORT Make_orig_subj5_address_prim_range(SALT39.StrType s0) := MakeFT_orig_subj5_address_prim_range(s0);
EXPORT InValid_orig_subj5_address_prim_range(SALT39.StrType s) := InValidFT_orig_subj5_address_prim_range(s);
EXPORT InValidMessage_orig_subj5_address_prim_range(UNSIGNED1 wh) := InValidMessageFT_orig_subj5_address_prim_range(wh);
 
EXPORT Make_orig_subj5_address_predir(SALT39.StrType s0) := MakeFT_orig_subj5_address_predir(s0);
EXPORT InValid_orig_subj5_address_predir(SALT39.StrType s) := InValidFT_orig_subj5_address_predir(s);
EXPORT InValidMessage_orig_subj5_address_predir(UNSIGNED1 wh) := InValidMessageFT_orig_subj5_address_predir(wh);
 
EXPORT Make_orig_subj5_address_prim_name(SALT39.StrType s0) := MakeFT_orig_subj5_address_prim_name(s0);
EXPORT InValid_orig_subj5_address_prim_name(SALT39.StrType s) := InValidFT_orig_subj5_address_prim_name(s);
EXPORT InValidMessage_orig_subj5_address_prim_name(UNSIGNED1 wh) := InValidMessageFT_orig_subj5_address_prim_name(wh);
 
EXPORT Make_orig_subj5_address_suffix(SALT39.StrType s0) := MakeFT_orig_subj5_address_suffix(s0);
EXPORT InValid_orig_subj5_address_suffix(SALT39.StrType s) := InValidFT_orig_subj5_address_suffix(s);
EXPORT InValidMessage_orig_subj5_address_suffix(UNSIGNED1 wh) := InValidMessageFT_orig_subj5_address_suffix(wh);
 
EXPORT Make_orig_subj5_address_postdir(SALT39.StrType s0) := MakeFT_orig_subj5_address_postdir(s0);
EXPORT InValid_orig_subj5_address_postdir(SALT39.StrType s) := InValidFT_orig_subj5_address_postdir(s);
EXPORT InValidMessage_orig_subj5_address_postdir(UNSIGNED1 wh) := InValidMessageFT_orig_subj5_address_postdir(wh);
 
EXPORT Make_orig_subj5_address_unit_desig(SALT39.StrType s0) := MakeFT_orig_subj5_address_unit_desig(s0);
EXPORT InValid_orig_subj5_address_unit_desig(SALT39.StrType s) := InValidFT_orig_subj5_address_unit_desig(s);
EXPORT InValidMessage_orig_subj5_address_unit_desig(UNSIGNED1 wh) := InValidMessageFT_orig_subj5_address_unit_desig(wh);
 
EXPORT Make_orig_subj5_address_sec_range(SALT39.StrType s0) := MakeFT_orig_subj5_address_sec_range(s0);
EXPORT InValid_orig_subj5_address_sec_range(SALT39.StrType s) := InValidFT_orig_subj5_address_sec_range(s);
EXPORT InValidMessage_orig_subj5_address_sec_range(UNSIGNED1 wh) := InValidMessageFT_orig_subj5_address_sec_range(wh);
 
EXPORT Make_orig_subj5_address_city(SALT39.StrType s0) := MakeFT_orig_subj5_address_city(s0);
EXPORT InValid_orig_subj5_address_city(SALT39.StrType s) := InValidFT_orig_subj5_address_city(s);
EXPORT InValidMessage_orig_subj5_address_city(UNSIGNED1 wh) := InValidMessageFT_orig_subj5_address_city(wh);
 
EXPORT Make_orig_subj5_address_st(SALT39.StrType s0) := MakeFT_orig_subj5_address_st(s0);
EXPORT InValid_orig_subj5_address_st(SALT39.StrType s) := InValidFT_orig_subj5_address_st(s);
EXPORT InValidMessage_orig_subj5_address_st(UNSIGNED1 wh) := InValidMessageFT_orig_subj5_address_st(wh);
 
EXPORT Make_orig_subj5_address_z5(SALT39.StrType s0) := MakeFT_orig_subj5_address_z5(s0);
EXPORT InValid_orig_subj5_address_z5(SALT39.StrType s) := InValidFT_orig_subj5_address_z5(s);
EXPORT InValidMessage_orig_subj5_address_z5(UNSIGNED1 wh) := InValidMessageFT_orig_subj5_address_z5(wh);
 
EXPORT Make_orig_subj5_address_z4(SALT39.StrType s0) := MakeFT_orig_subj5_address_z4(s0);
EXPORT InValid_orig_subj5_address_z4(SALT39.StrType s) := InValidFT_orig_subj5_address_z4(s);
EXPORT InValidMessage_orig_subj5_address_z4(UNSIGNED1 wh) := InValidMessageFT_orig_subj5_address_z4(wh);
 
EXPORT Make_orig_subj5_phone(SALT39.StrType s0) := MakeFT_orig_subj5_phone(s0);
EXPORT InValid_orig_subj5_phone(SALT39.StrType s) := InValidFT_orig_subj5_phone(s);
EXPORT InValidMessage_orig_subj5_phone(UNSIGNED1 wh) := InValidMessageFT_orig_subj5_phone(wh);
 
EXPORT Make_orig_subj5_work_phone(SALT39.StrType s0) := MakeFT_orig_subj5_work_phone(s0);
EXPORT InValid_orig_subj5_work_phone(SALT39.StrType s) := InValidFT_orig_subj5_work_phone(s);
EXPORT InValidMessage_orig_subj5_work_phone(UNSIGNED1 wh) := InValidMessageFT_orig_subj5_work_phone(wh);
 
EXPORT Make_orig_subj5_business_title(SALT39.StrType s0) := MakeFT_orig_subj5_business_title(s0);
EXPORT InValid_orig_subj5_business_title(SALT39.StrType s) := InValidFT_orig_subj5_business_title(s);
EXPORT InValidMessage_orig_subj5_business_title(UNSIGNED1 wh) := InValidMessageFT_orig_subj5_business_title(wh);
 
EXPORT Make_orig_subj5_email(SALT39.StrType s0) := MakeFT_orig_subj5_email(s0);
EXPORT InValid_orig_subj5_email(SALT39.StrType s) := InValidFT_orig_subj5_email(s);
EXPORT InValidMessage_orig_subj5_email(UNSIGNED1 wh) := InValidMessageFT_orig_subj5_email(wh);
 
EXPORT Make_orig_subj5_company_name(SALT39.StrType s0) := MakeFT_orig_subj5_company_name(s0);
EXPORT InValid_orig_subj5_company_name(SALT39.StrType s) := InValidFT_orig_subj5_company_name(s);
EXPORT InValidMessage_orig_subj5_company_name(UNSIGNED1 wh) := InValidMessageFT_orig_subj5_company_name(wh);
 
EXPORT Make_orig_subj5_fein(SALT39.StrType s0) := MakeFT_orig_subj5_fein(s0);
EXPORT InValid_orig_subj5_fein(SALT39.StrType s) := InValidFT_orig_subj5_fein(s);
EXPORT InValidMessage_orig_subj5_fein(UNSIGNED1 wh) := InValidMessageFT_orig_subj5_fein(wh);
 
EXPORT Make_orig_subj6_first_name(SALT39.StrType s0) := MakeFT_orig_subj6_first_name(s0);
EXPORT InValid_orig_subj6_first_name(SALT39.StrType s) := InValidFT_orig_subj6_first_name(s);
EXPORT InValidMessage_orig_subj6_first_name(UNSIGNED1 wh) := InValidMessageFT_orig_subj6_first_name(wh);
 
EXPORT Make_orig_subj6_middle_name(SALT39.StrType s0) := MakeFT_orig_subj6_middle_name(s0);
EXPORT InValid_orig_subj6_middle_name(SALT39.StrType s) := InValidFT_orig_subj6_middle_name(s);
EXPORT InValidMessage_orig_subj6_middle_name(UNSIGNED1 wh) := InValidMessageFT_orig_subj6_middle_name(wh);
 
EXPORT Make_orig_subj6_last_name(SALT39.StrType s0) := MakeFT_orig_subj6_last_name(s0);
EXPORT InValid_orig_subj6_last_name(SALT39.StrType s) := InValidFT_orig_subj6_last_name(s);
EXPORT InValidMessage_orig_subj6_last_name(UNSIGNED1 wh) := InValidMessageFT_orig_subj6_last_name(wh);
 
EXPORT Make_orig_subj6_suffix_name(SALT39.StrType s0) := MakeFT_orig_subj6_suffix_name(s0);
EXPORT InValid_orig_subj6_suffix_name(SALT39.StrType s) := InValidFT_orig_subj6_suffix_name(s);
EXPORT InValidMessage_orig_subj6_suffix_name(UNSIGNED1 wh) := InValidMessageFT_orig_subj6_suffix_name(wh);
 
EXPORT Make_orig_subj6_full_name(SALT39.StrType s0) := MakeFT_orig_subj6_full_name(s0);
EXPORT InValid_orig_subj6_full_name(SALT39.StrType s) := InValidFT_orig_subj6_full_name(s);
EXPORT InValidMessage_orig_subj6_full_name(UNSIGNED1 wh) := InValidMessageFT_orig_subj6_full_name(wh);
 
EXPORT Make_orig_subj6_ssn(SALT39.StrType s0) := MakeFT_orig_subj6_ssn(s0);
EXPORT InValid_orig_subj6_ssn(SALT39.StrType s) := InValidFT_orig_subj6_ssn(s);
EXPORT InValidMessage_orig_subj6_ssn(UNSIGNED1 wh) := InValidMessageFT_orig_subj6_ssn(wh);
 
EXPORT Make_orig_subj6_dob(SALT39.StrType s0) := MakeFT_orig_subj6_dob(s0);
EXPORT InValid_orig_subj6_dob(SALT39.StrType s) := InValidFT_orig_subj6_dob(s);
EXPORT InValidMessage_orig_subj6_dob(UNSIGNED1 wh) := InValidMessageFT_orig_subj6_dob(wh);
 
EXPORT Make_orig_subj6_dl_num(SALT39.StrType s0) := MakeFT_orig_subj6_dl_num(s0);
EXPORT InValid_orig_subj6_dl_num(SALT39.StrType s) := InValidFT_orig_subj6_dl_num(s);
EXPORT InValidMessage_orig_subj6_dl_num(UNSIGNED1 wh) := InValidMessageFT_orig_subj6_dl_num(wh);
 
EXPORT Make_orig_subj6_dl_state(SALT39.StrType s0) := MakeFT_orig_subj6_dl_state(s0);
EXPORT InValid_orig_subj6_dl_state(SALT39.StrType s) := InValidFT_orig_subj6_dl_state(s);
EXPORT InValidMessage_orig_subj6_dl_state(UNSIGNED1 wh) := InValidMessageFT_orig_subj6_dl_state(wh);
 
EXPORT Make_orig_subj6_former_last_name(SALT39.StrType s0) := MakeFT_orig_subj6_former_last_name(s0);
EXPORT InValid_orig_subj6_former_last_name(SALT39.StrType s) := InValidFT_orig_subj6_former_last_name(s);
EXPORT InValidMessage_orig_subj6_former_last_name(UNSIGNED1 wh) := InValidMessageFT_orig_subj6_former_last_name(wh);
 
EXPORT Make_orig_subj6_address_addressline1(SALT39.StrType s0) := MakeFT_orig_subj6_address_addressline1(s0);
EXPORT InValid_orig_subj6_address_addressline1(SALT39.StrType s) := InValidFT_orig_subj6_address_addressline1(s);
EXPORT InValidMessage_orig_subj6_address_addressline1(UNSIGNED1 wh) := InValidMessageFT_orig_subj6_address_addressline1(wh);
 
EXPORT Make_orig_subj6_address_addressline2(SALT39.StrType s0) := MakeFT_orig_subj6_address_addressline2(s0);
EXPORT InValid_orig_subj6_address_addressline2(SALT39.StrType s) := InValidFT_orig_subj6_address_addressline2(s);
EXPORT InValidMessage_orig_subj6_address_addressline2(UNSIGNED1 wh) := InValidMessageFT_orig_subj6_address_addressline2(wh);
 
EXPORT Make_orig_subj6_address_prim_range(SALT39.StrType s0) := MakeFT_orig_subj6_address_prim_range(s0);
EXPORT InValid_orig_subj6_address_prim_range(SALT39.StrType s) := InValidFT_orig_subj6_address_prim_range(s);
EXPORT InValidMessage_orig_subj6_address_prim_range(UNSIGNED1 wh) := InValidMessageFT_orig_subj6_address_prim_range(wh);
 
EXPORT Make_orig_subj6_address_predir(SALT39.StrType s0) := MakeFT_orig_subj6_address_predir(s0);
EXPORT InValid_orig_subj6_address_predir(SALT39.StrType s) := InValidFT_orig_subj6_address_predir(s);
EXPORT InValidMessage_orig_subj6_address_predir(UNSIGNED1 wh) := InValidMessageFT_orig_subj6_address_predir(wh);
 
EXPORT Make_orig_subj6_address_prim_name(SALT39.StrType s0) := MakeFT_orig_subj6_address_prim_name(s0);
EXPORT InValid_orig_subj6_address_prim_name(SALT39.StrType s) := InValidFT_orig_subj6_address_prim_name(s);
EXPORT InValidMessage_orig_subj6_address_prim_name(UNSIGNED1 wh) := InValidMessageFT_orig_subj6_address_prim_name(wh);
 
EXPORT Make_orig_subj6_address_suffix(SALT39.StrType s0) := MakeFT_orig_subj6_address_suffix(s0);
EXPORT InValid_orig_subj6_address_suffix(SALT39.StrType s) := InValidFT_orig_subj6_address_suffix(s);
EXPORT InValidMessage_orig_subj6_address_suffix(UNSIGNED1 wh) := InValidMessageFT_orig_subj6_address_suffix(wh);
 
EXPORT Make_orig_subj6_address_postdir(SALT39.StrType s0) := MakeFT_orig_subj6_address_postdir(s0);
EXPORT InValid_orig_subj6_address_postdir(SALT39.StrType s) := InValidFT_orig_subj6_address_postdir(s);
EXPORT InValidMessage_orig_subj6_address_postdir(UNSIGNED1 wh) := InValidMessageFT_orig_subj6_address_postdir(wh);
 
EXPORT Make_orig_subj6_address_unit_desig(SALT39.StrType s0) := MakeFT_orig_subj6_address_unit_desig(s0);
EXPORT InValid_orig_subj6_address_unit_desig(SALT39.StrType s) := InValidFT_orig_subj6_address_unit_desig(s);
EXPORT InValidMessage_orig_subj6_address_unit_desig(UNSIGNED1 wh) := InValidMessageFT_orig_subj6_address_unit_desig(wh);
 
EXPORT Make_orig_subj6_address_sec_range(SALT39.StrType s0) := MakeFT_orig_subj6_address_sec_range(s0);
EXPORT InValid_orig_subj6_address_sec_range(SALT39.StrType s) := InValidFT_orig_subj6_address_sec_range(s);
EXPORT InValidMessage_orig_subj6_address_sec_range(UNSIGNED1 wh) := InValidMessageFT_orig_subj6_address_sec_range(wh);
 
EXPORT Make_orig_subj6_address_city(SALT39.StrType s0) := MakeFT_orig_subj6_address_city(s0);
EXPORT InValid_orig_subj6_address_city(SALT39.StrType s) := InValidFT_orig_subj6_address_city(s);
EXPORT InValidMessage_orig_subj6_address_city(UNSIGNED1 wh) := InValidMessageFT_orig_subj6_address_city(wh);
 
EXPORT Make_orig_subj6_address_st(SALT39.StrType s0) := MakeFT_orig_subj6_address_st(s0);
EXPORT InValid_orig_subj6_address_st(SALT39.StrType s) := InValidFT_orig_subj6_address_st(s);
EXPORT InValidMessage_orig_subj6_address_st(UNSIGNED1 wh) := InValidMessageFT_orig_subj6_address_st(wh);
 
EXPORT Make_orig_subj6_address_z5(SALT39.StrType s0) := MakeFT_orig_subj6_address_z5(s0);
EXPORT InValid_orig_subj6_address_z5(SALT39.StrType s) := InValidFT_orig_subj6_address_z5(s);
EXPORT InValidMessage_orig_subj6_address_z5(UNSIGNED1 wh) := InValidMessageFT_orig_subj6_address_z5(wh);
 
EXPORT Make_orig_subj6_address_z4(SALT39.StrType s0) := MakeFT_orig_subj6_address_z4(s0);
EXPORT InValid_orig_subj6_address_z4(SALT39.StrType s) := InValidFT_orig_subj6_address_z4(s);
EXPORT InValidMessage_orig_subj6_address_z4(UNSIGNED1 wh) := InValidMessageFT_orig_subj6_address_z4(wh);
 
EXPORT Make_orig_subj6_phone(SALT39.StrType s0) := MakeFT_orig_subj6_phone(s0);
EXPORT InValid_orig_subj6_phone(SALT39.StrType s) := InValidFT_orig_subj6_phone(s);
EXPORT InValidMessage_orig_subj6_phone(UNSIGNED1 wh) := InValidMessageFT_orig_subj6_phone(wh);
 
EXPORT Make_orig_subj6_work_phone(SALT39.StrType s0) := MakeFT_orig_subj6_work_phone(s0);
EXPORT InValid_orig_subj6_work_phone(SALT39.StrType s) := InValidFT_orig_subj6_work_phone(s);
EXPORT InValidMessage_orig_subj6_work_phone(UNSIGNED1 wh) := InValidMessageFT_orig_subj6_work_phone(wh);
 
EXPORT Make_orig_subj6_business_title(SALT39.StrType s0) := MakeFT_orig_subj6_business_title(s0);
EXPORT InValid_orig_subj6_business_title(SALT39.StrType s) := InValidFT_orig_subj6_business_title(s);
EXPORT InValidMessage_orig_subj6_business_title(UNSIGNED1 wh) := InValidMessageFT_orig_subj6_business_title(wh);
 
EXPORT Make_orig_subj6_email(SALT39.StrType s0) := MakeFT_orig_subj6_email(s0);
EXPORT InValid_orig_subj6_email(SALT39.StrType s) := InValidFT_orig_subj6_email(s);
EXPORT InValidMessage_orig_subj6_email(UNSIGNED1 wh) := InValidMessageFT_orig_subj6_email(wh);
 
EXPORT Make_orig_subj6_company_name(SALT39.StrType s0) := MakeFT_orig_subj6_company_name(s0);
EXPORT InValid_orig_subj6_company_name(SALT39.StrType s) := InValidFT_orig_subj6_company_name(s);
EXPORT InValidMessage_orig_subj6_company_name(UNSIGNED1 wh) := InValidMessageFT_orig_subj6_company_name(wh);
 
EXPORT Make_orig_subj6_fein(SALT39.StrType s0) := MakeFT_orig_subj6_fein(s0);
EXPORT InValid_orig_subj6_fein(SALT39.StrType s) := InValidFT_orig_subj6_fein(s);
EXPORT InValidMessage_orig_subj6_fein(UNSIGNED1 wh) := InValidMessageFT_orig_subj6_fein(wh);
 
EXPORT Make_orig_subj7_first_name(SALT39.StrType s0) := MakeFT_orig_subj7_first_name(s0);
EXPORT InValid_orig_subj7_first_name(SALT39.StrType s) := InValidFT_orig_subj7_first_name(s);
EXPORT InValidMessage_orig_subj7_first_name(UNSIGNED1 wh) := InValidMessageFT_orig_subj7_first_name(wh);
 
EXPORT Make_orig_subj7_middle_name(SALT39.StrType s0) := MakeFT_orig_subj7_middle_name(s0);
EXPORT InValid_orig_subj7_middle_name(SALT39.StrType s) := InValidFT_orig_subj7_middle_name(s);
EXPORT InValidMessage_orig_subj7_middle_name(UNSIGNED1 wh) := InValidMessageFT_orig_subj7_middle_name(wh);
 
EXPORT Make_orig_subj7_last_name(SALT39.StrType s0) := MakeFT_orig_subj7_last_name(s0);
EXPORT InValid_orig_subj7_last_name(SALT39.StrType s) := InValidFT_orig_subj7_last_name(s);
EXPORT InValidMessage_orig_subj7_last_name(UNSIGNED1 wh) := InValidMessageFT_orig_subj7_last_name(wh);
 
EXPORT Make_orig_subj7_suffix_name(SALT39.StrType s0) := MakeFT_orig_subj7_suffix_name(s0);
EXPORT InValid_orig_subj7_suffix_name(SALT39.StrType s) := InValidFT_orig_subj7_suffix_name(s);
EXPORT InValidMessage_orig_subj7_suffix_name(UNSIGNED1 wh) := InValidMessageFT_orig_subj7_suffix_name(wh);
 
EXPORT Make_orig_subj7_full_name(SALT39.StrType s0) := MakeFT_orig_subj7_full_name(s0);
EXPORT InValid_orig_subj7_full_name(SALT39.StrType s) := InValidFT_orig_subj7_full_name(s);
EXPORT InValidMessage_orig_subj7_full_name(UNSIGNED1 wh) := InValidMessageFT_orig_subj7_full_name(wh);
 
EXPORT Make_orig_subj7_ssn(SALT39.StrType s0) := MakeFT_orig_subj7_ssn(s0);
EXPORT InValid_orig_subj7_ssn(SALT39.StrType s) := InValidFT_orig_subj7_ssn(s);
EXPORT InValidMessage_orig_subj7_ssn(UNSIGNED1 wh) := InValidMessageFT_orig_subj7_ssn(wh);
 
EXPORT Make_orig_subj7_dob(SALT39.StrType s0) := MakeFT_orig_subj7_dob(s0);
EXPORT InValid_orig_subj7_dob(SALT39.StrType s) := InValidFT_orig_subj7_dob(s);
EXPORT InValidMessage_orig_subj7_dob(UNSIGNED1 wh) := InValidMessageFT_orig_subj7_dob(wh);
 
EXPORT Make_orig_subj7_dl_num(SALT39.StrType s0) := MakeFT_orig_subj7_dl_num(s0);
EXPORT InValid_orig_subj7_dl_num(SALT39.StrType s) := InValidFT_orig_subj7_dl_num(s);
EXPORT InValidMessage_orig_subj7_dl_num(UNSIGNED1 wh) := InValidMessageFT_orig_subj7_dl_num(wh);
 
EXPORT Make_orig_subj7_dl_state(SALT39.StrType s0) := MakeFT_orig_subj7_dl_state(s0);
EXPORT InValid_orig_subj7_dl_state(SALT39.StrType s) := InValidFT_orig_subj7_dl_state(s);
EXPORT InValidMessage_orig_subj7_dl_state(UNSIGNED1 wh) := InValidMessageFT_orig_subj7_dl_state(wh);
 
EXPORT Make_orig_subj7_former_last_name(SALT39.StrType s0) := MakeFT_orig_subj7_former_last_name(s0);
EXPORT InValid_orig_subj7_former_last_name(SALT39.StrType s) := InValidFT_orig_subj7_former_last_name(s);
EXPORT InValidMessage_orig_subj7_former_last_name(UNSIGNED1 wh) := InValidMessageFT_orig_subj7_former_last_name(wh);
 
EXPORT Make_orig_subj7_address_addressline1(SALT39.StrType s0) := MakeFT_orig_subj7_address_addressline1(s0);
EXPORT InValid_orig_subj7_address_addressline1(SALT39.StrType s) := InValidFT_orig_subj7_address_addressline1(s);
EXPORT InValidMessage_orig_subj7_address_addressline1(UNSIGNED1 wh) := InValidMessageFT_orig_subj7_address_addressline1(wh);
 
EXPORT Make_orig_subj7_address_addressline2(SALT39.StrType s0) := MakeFT_orig_subj7_address_addressline2(s0);
EXPORT InValid_orig_subj7_address_addressline2(SALT39.StrType s) := InValidFT_orig_subj7_address_addressline2(s);
EXPORT InValidMessage_orig_subj7_address_addressline2(UNSIGNED1 wh) := InValidMessageFT_orig_subj7_address_addressline2(wh);
 
EXPORT Make_orig_subj7_address_prim_range(SALT39.StrType s0) := MakeFT_orig_subj7_address_prim_range(s0);
EXPORT InValid_orig_subj7_address_prim_range(SALT39.StrType s) := InValidFT_orig_subj7_address_prim_range(s);
EXPORT InValidMessage_orig_subj7_address_prim_range(UNSIGNED1 wh) := InValidMessageFT_orig_subj7_address_prim_range(wh);
 
EXPORT Make_orig_subj7_address_predir(SALT39.StrType s0) := MakeFT_orig_subj7_address_predir(s0);
EXPORT InValid_orig_subj7_address_predir(SALT39.StrType s) := InValidFT_orig_subj7_address_predir(s);
EXPORT InValidMessage_orig_subj7_address_predir(UNSIGNED1 wh) := InValidMessageFT_orig_subj7_address_predir(wh);
 
EXPORT Make_orig_subj7_address_prim_name(SALT39.StrType s0) := MakeFT_orig_subj7_address_prim_name(s0);
EXPORT InValid_orig_subj7_address_prim_name(SALT39.StrType s) := InValidFT_orig_subj7_address_prim_name(s);
EXPORT InValidMessage_orig_subj7_address_prim_name(UNSIGNED1 wh) := InValidMessageFT_orig_subj7_address_prim_name(wh);
 
EXPORT Make_orig_subj7_address_suffix(SALT39.StrType s0) := MakeFT_orig_subj7_address_suffix(s0);
EXPORT InValid_orig_subj7_address_suffix(SALT39.StrType s) := InValidFT_orig_subj7_address_suffix(s);
EXPORT InValidMessage_orig_subj7_address_suffix(UNSIGNED1 wh) := InValidMessageFT_orig_subj7_address_suffix(wh);
 
EXPORT Make_orig_subj7_address_postdir(SALT39.StrType s0) := MakeFT_orig_subj7_address_postdir(s0);
EXPORT InValid_orig_subj7_address_postdir(SALT39.StrType s) := InValidFT_orig_subj7_address_postdir(s);
EXPORT InValidMessage_orig_subj7_address_postdir(UNSIGNED1 wh) := InValidMessageFT_orig_subj7_address_postdir(wh);
 
EXPORT Make_orig_subj7_address_unit_desig(SALT39.StrType s0) := MakeFT_orig_subj7_address_unit_desig(s0);
EXPORT InValid_orig_subj7_address_unit_desig(SALT39.StrType s) := InValidFT_orig_subj7_address_unit_desig(s);
EXPORT InValidMessage_orig_subj7_address_unit_desig(UNSIGNED1 wh) := InValidMessageFT_orig_subj7_address_unit_desig(wh);
 
EXPORT Make_orig_subj7_address_sec_range(SALT39.StrType s0) := MakeFT_orig_subj7_address_sec_range(s0);
EXPORT InValid_orig_subj7_address_sec_range(SALT39.StrType s) := InValidFT_orig_subj7_address_sec_range(s);
EXPORT InValidMessage_orig_subj7_address_sec_range(UNSIGNED1 wh) := InValidMessageFT_orig_subj7_address_sec_range(wh);
 
EXPORT Make_orig_subj7_address_city(SALT39.StrType s0) := MakeFT_orig_subj7_address_city(s0);
EXPORT InValid_orig_subj7_address_city(SALT39.StrType s) := InValidFT_orig_subj7_address_city(s);
EXPORT InValidMessage_orig_subj7_address_city(UNSIGNED1 wh) := InValidMessageFT_orig_subj7_address_city(wh);
 
EXPORT Make_orig_subj7_address_st(SALT39.StrType s0) := MakeFT_orig_subj7_address_st(s0);
EXPORT InValid_orig_subj7_address_st(SALT39.StrType s) := InValidFT_orig_subj7_address_st(s);
EXPORT InValidMessage_orig_subj7_address_st(UNSIGNED1 wh) := InValidMessageFT_orig_subj7_address_st(wh);
 
EXPORT Make_orig_subj7_address_z5(SALT39.StrType s0) := MakeFT_orig_subj7_address_z5(s0);
EXPORT InValid_orig_subj7_address_z5(SALT39.StrType s) := InValidFT_orig_subj7_address_z5(s);
EXPORT InValidMessage_orig_subj7_address_z5(UNSIGNED1 wh) := InValidMessageFT_orig_subj7_address_z5(wh);
 
EXPORT Make_orig_subj7_address_z4(SALT39.StrType s0) := MakeFT_orig_subj7_address_z4(s0);
EXPORT InValid_orig_subj7_address_z4(SALT39.StrType s) := InValidFT_orig_subj7_address_z4(s);
EXPORT InValidMessage_orig_subj7_address_z4(UNSIGNED1 wh) := InValidMessageFT_orig_subj7_address_z4(wh);
 
EXPORT Make_orig_subj7_phone(SALT39.StrType s0) := MakeFT_orig_subj7_phone(s0);
EXPORT InValid_orig_subj7_phone(SALT39.StrType s) := InValidFT_orig_subj7_phone(s);
EXPORT InValidMessage_orig_subj7_phone(UNSIGNED1 wh) := InValidMessageFT_orig_subj7_phone(wh);
 
EXPORT Make_orig_subj7_work_phone(SALT39.StrType s0) := MakeFT_orig_subj7_work_phone(s0);
EXPORT InValid_orig_subj7_work_phone(SALT39.StrType s) := InValidFT_orig_subj7_work_phone(s);
EXPORT InValidMessage_orig_subj7_work_phone(UNSIGNED1 wh) := InValidMessageFT_orig_subj7_work_phone(wh);
 
EXPORT Make_orig_subj7_business_title(SALT39.StrType s0) := MakeFT_orig_subj7_business_title(s0);
EXPORT InValid_orig_subj7_business_title(SALT39.StrType s) := InValidFT_orig_subj7_business_title(s);
EXPORT InValidMessage_orig_subj7_business_title(UNSIGNED1 wh) := InValidMessageFT_orig_subj7_business_title(wh);
 
EXPORT Make_orig_subj7_email(SALT39.StrType s0) := MakeFT_orig_subj7_email(s0);
EXPORT InValid_orig_subj7_email(SALT39.StrType s) := InValidFT_orig_subj7_email(s);
EXPORT InValidMessage_orig_subj7_email(UNSIGNED1 wh) := InValidMessageFT_orig_subj7_email(wh);
 
EXPORT Make_orig_subj7_company_name(SALT39.StrType s0) := MakeFT_orig_subj7_company_name(s0);
EXPORT InValid_orig_subj7_company_name(SALT39.StrType s) := InValidFT_orig_subj7_company_name(s);
EXPORT InValidMessage_orig_subj7_company_name(UNSIGNED1 wh) := InValidMessageFT_orig_subj7_company_name(wh);
 
EXPORT Make_orig_subj7_fein(SALT39.StrType s0) := MakeFT_orig_subj7_fein(s0);
EXPORT InValid_orig_subj7_fein(SALT39.StrType s) := InValidFT_orig_subj7_fein(s);
EXPORT InValidMessage_orig_subj7_fein(UNSIGNED1 wh) := InValidMessageFT_orig_subj7_fein(wh);
 
EXPORT Make_orig_subj8_first_name(SALT39.StrType s0) := MakeFT_orig_subj8_first_name(s0);
EXPORT InValid_orig_subj8_first_name(SALT39.StrType s) := InValidFT_orig_subj8_first_name(s);
EXPORT InValidMessage_orig_subj8_first_name(UNSIGNED1 wh) := InValidMessageFT_orig_subj8_first_name(wh);
 
EXPORT Make_orig_subj8_middle_name(SALT39.StrType s0) := MakeFT_orig_subj8_middle_name(s0);
EXPORT InValid_orig_subj8_middle_name(SALT39.StrType s) := InValidFT_orig_subj8_middle_name(s);
EXPORT InValidMessage_orig_subj8_middle_name(UNSIGNED1 wh) := InValidMessageFT_orig_subj8_middle_name(wh);
 
EXPORT Make_orig_subj8_last_name(SALT39.StrType s0) := MakeFT_orig_subj8_last_name(s0);
EXPORT InValid_orig_subj8_last_name(SALT39.StrType s) := InValidFT_orig_subj8_last_name(s);
EXPORT InValidMessage_orig_subj8_last_name(UNSIGNED1 wh) := InValidMessageFT_orig_subj8_last_name(wh);
 
EXPORT Make_orig_subj8_suffix_name(SALT39.StrType s0) := MakeFT_orig_subj8_suffix_name(s0);
EXPORT InValid_orig_subj8_suffix_name(SALT39.StrType s) := InValidFT_orig_subj8_suffix_name(s);
EXPORT InValidMessage_orig_subj8_suffix_name(UNSIGNED1 wh) := InValidMessageFT_orig_subj8_suffix_name(wh);
 
EXPORT Make_orig_subj8_full_name(SALT39.StrType s0) := MakeFT_orig_subj8_full_name(s0);
EXPORT InValid_orig_subj8_full_name(SALT39.StrType s) := InValidFT_orig_subj8_full_name(s);
EXPORT InValidMessage_orig_subj8_full_name(UNSIGNED1 wh) := InValidMessageFT_orig_subj8_full_name(wh);
 
EXPORT Make_orig_subj8_ssn(SALT39.StrType s0) := MakeFT_orig_subj8_ssn(s0);
EXPORT InValid_orig_subj8_ssn(SALT39.StrType s) := InValidFT_orig_subj8_ssn(s);
EXPORT InValidMessage_orig_subj8_ssn(UNSIGNED1 wh) := InValidMessageFT_orig_subj8_ssn(wh);
 
EXPORT Make_orig_subj8_dob(SALT39.StrType s0) := MakeFT_orig_subj8_dob(s0);
EXPORT InValid_orig_subj8_dob(SALT39.StrType s) := InValidFT_orig_subj8_dob(s);
EXPORT InValidMessage_orig_subj8_dob(UNSIGNED1 wh) := InValidMessageFT_orig_subj8_dob(wh);
 
EXPORT Make_orig_subj8_dl_num(SALT39.StrType s0) := MakeFT_orig_subj8_dl_num(s0);
EXPORT InValid_orig_subj8_dl_num(SALT39.StrType s) := InValidFT_orig_subj8_dl_num(s);
EXPORT InValidMessage_orig_subj8_dl_num(UNSIGNED1 wh) := InValidMessageFT_orig_subj8_dl_num(wh);
 
EXPORT Make_orig_subj8_dl_state(SALT39.StrType s0) := MakeFT_orig_subj8_dl_state(s0);
EXPORT InValid_orig_subj8_dl_state(SALT39.StrType s) := InValidFT_orig_subj8_dl_state(s);
EXPORT InValidMessage_orig_subj8_dl_state(UNSIGNED1 wh) := InValidMessageFT_orig_subj8_dl_state(wh);
 
EXPORT Make_orig_subj8_former_last_name(SALT39.StrType s0) := MakeFT_orig_subj8_former_last_name(s0);
EXPORT InValid_orig_subj8_former_last_name(SALT39.StrType s) := InValidFT_orig_subj8_former_last_name(s);
EXPORT InValidMessage_orig_subj8_former_last_name(UNSIGNED1 wh) := InValidMessageFT_orig_subj8_former_last_name(wh);
 
EXPORT Make_orig_subj8_address_addressline1(SALT39.StrType s0) := MakeFT_orig_subj8_address_addressline1(s0);
EXPORT InValid_orig_subj8_address_addressline1(SALT39.StrType s) := InValidFT_orig_subj8_address_addressline1(s);
EXPORT InValidMessage_orig_subj8_address_addressline1(UNSIGNED1 wh) := InValidMessageFT_orig_subj8_address_addressline1(wh);
 
EXPORT Make_orig_subj8_address_addressline2(SALT39.StrType s0) := MakeFT_orig_subj8_address_addressline2(s0);
EXPORT InValid_orig_subj8_address_addressline2(SALT39.StrType s) := InValidFT_orig_subj8_address_addressline2(s);
EXPORT InValidMessage_orig_subj8_address_addressline2(UNSIGNED1 wh) := InValidMessageFT_orig_subj8_address_addressline2(wh);
 
EXPORT Make_orig_subj8_address_prim_range(SALT39.StrType s0) := MakeFT_orig_subj8_address_prim_range(s0);
EXPORT InValid_orig_subj8_address_prim_range(SALT39.StrType s) := InValidFT_orig_subj8_address_prim_range(s);
EXPORT InValidMessage_orig_subj8_address_prim_range(UNSIGNED1 wh) := InValidMessageFT_orig_subj8_address_prim_range(wh);
 
EXPORT Make_orig_subj8_address_predir(SALT39.StrType s0) := MakeFT_orig_subj8_address_predir(s0);
EXPORT InValid_orig_subj8_address_predir(SALT39.StrType s) := InValidFT_orig_subj8_address_predir(s);
EXPORT InValidMessage_orig_subj8_address_predir(UNSIGNED1 wh) := InValidMessageFT_orig_subj8_address_predir(wh);
 
EXPORT Make_orig_subj8_address_prim_name(SALT39.StrType s0) := MakeFT_orig_subj8_address_prim_name(s0);
EXPORT InValid_orig_subj8_address_prim_name(SALT39.StrType s) := InValidFT_orig_subj8_address_prim_name(s);
EXPORT InValidMessage_orig_subj8_address_prim_name(UNSIGNED1 wh) := InValidMessageFT_orig_subj8_address_prim_name(wh);
 
EXPORT Make_orig_subj8_address_suffix(SALT39.StrType s0) := MakeFT_orig_subj8_address_suffix(s0);
EXPORT InValid_orig_subj8_address_suffix(SALT39.StrType s) := InValidFT_orig_subj8_address_suffix(s);
EXPORT InValidMessage_orig_subj8_address_suffix(UNSIGNED1 wh) := InValidMessageFT_orig_subj8_address_suffix(wh);
 
EXPORT Make_orig_subj8_address_postdir(SALT39.StrType s0) := MakeFT_orig_subj8_address_postdir(s0);
EXPORT InValid_orig_subj8_address_postdir(SALT39.StrType s) := InValidFT_orig_subj8_address_postdir(s);
EXPORT InValidMessage_orig_subj8_address_postdir(UNSIGNED1 wh) := InValidMessageFT_orig_subj8_address_postdir(wh);
 
EXPORT Make_orig_subj8_address_unit_desig(SALT39.StrType s0) := MakeFT_orig_subj8_address_unit_desig(s0);
EXPORT InValid_orig_subj8_address_unit_desig(SALT39.StrType s) := InValidFT_orig_subj8_address_unit_desig(s);
EXPORT InValidMessage_orig_subj8_address_unit_desig(UNSIGNED1 wh) := InValidMessageFT_orig_subj8_address_unit_desig(wh);
 
EXPORT Make_orig_subj8_address_sec_range(SALT39.StrType s0) := MakeFT_orig_subj8_address_sec_range(s0);
EXPORT InValid_orig_subj8_address_sec_range(SALT39.StrType s) := InValidFT_orig_subj8_address_sec_range(s);
EXPORT InValidMessage_orig_subj8_address_sec_range(UNSIGNED1 wh) := InValidMessageFT_orig_subj8_address_sec_range(wh);
 
EXPORT Make_orig_subj8_address_city(SALT39.StrType s0) := MakeFT_orig_subj8_address_city(s0);
EXPORT InValid_orig_subj8_address_city(SALT39.StrType s) := InValidFT_orig_subj8_address_city(s);
EXPORT InValidMessage_orig_subj8_address_city(UNSIGNED1 wh) := InValidMessageFT_orig_subj8_address_city(wh);
 
EXPORT Make_orig_subj8_address_st(SALT39.StrType s0) := MakeFT_orig_subj8_address_st(s0);
EXPORT InValid_orig_subj8_address_st(SALT39.StrType s) := InValidFT_orig_subj8_address_st(s);
EXPORT InValidMessage_orig_subj8_address_st(UNSIGNED1 wh) := InValidMessageFT_orig_subj8_address_st(wh);
 
EXPORT Make_orig_subj8_address_z5(SALT39.StrType s0) := MakeFT_orig_subj8_address_z5(s0);
EXPORT InValid_orig_subj8_address_z5(SALT39.StrType s) := InValidFT_orig_subj8_address_z5(s);
EXPORT InValidMessage_orig_subj8_address_z5(UNSIGNED1 wh) := InValidMessageFT_orig_subj8_address_z5(wh);
 
EXPORT Make_orig_subj8_address_z4(SALT39.StrType s0) := MakeFT_orig_subj8_address_z4(s0);
EXPORT InValid_orig_subj8_address_z4(SALT39.StrType s) := InValidFT_orig_subj8_address_z4(s);
EXPORT InValidMessage_orig_subj8_address_z4(UNSIGNED1 wh) := InValidMessageFT_orig_subj8_address_z4(wh);
 
EXPORT Make_orig_subj8_phone(SALT39.StrType s0) := MakeFT_orig_subj8_phone(s0);
EXPORT InValid_orig_subj8_phone(SALT39.StrType s) := InValidFT_orig_subj8_phone(s);
EXPORT InValidMessage_orig_subj8_phone(UNSIGNED1 wh) := InValidMessageFT_orig_subj8_phone(wh);
 
EXPORT Make_orig_subj8_work_phone(SALT39.StrType s0) := MakeFT_orig_subj8_work_phone(s0);
EXPORT InValid_orig_subj8_work_phone(SALT39.StrType s) := InValidFT_orig_subj8_work_phone(s);
EXPORT InValidMessage_orig_subj8_work_phone(UNSIGNED1 wh) := InValidMessageFT_orig_subj8_work_phone(wh);
 
EXPORT Make_orig_subj8_business_title(SALT39.StrType s0) := MakeFT_orig_subj8_business_title(s0);
EXPORT InValid_orig_subj8_business_title(SALT39.StrType s) := InValidFT_orig_subj8_business_title(s);
EXPORT InValidMessage_orig_subj8_business_title(UNSIGNED1 wh) := InValidMessageFT_orig_subj8_business_title(wh);
 
EXPORT Make_orig_subj8_email(SALT39.StrType s0) := MakeFT_orig_subj8_email(s0);
EXPORT InValid_orig_subj8_email(SALT39.StrType s) := InValidFT_orig_subj8_email(s);
EXPORT InValidMessage_orig_subj8_email(UNSIGNED1 wh) := InValidMessageFT_orig_subj8_email(wh);
 
EXPORT Make_orig_subj8_company_name(SALT39.StrType s0) := MakeFT_orig_subj8_company_name(s0);
EXPORT InValid_orig_subj8_company_name(SALT39.StrType s) := InValidFT_orig_subj8_company_name(s);
EXPORT InValidMessage_orig_subj8_company_name(UNSIGNED1 wh) := InValidMessageFT_orig_subj8_company_name(wh);
 
EXPORT Make_orig_subj8_fein(SALT39.StrType s0) := MakeFT_orig_subj8_fein(s0);
EXPORT InValid_orig_subj8_fein(SALT39.StrType s) := InValidFT_orig_subj8_fein(s);
EXPORT InValidMessage_orig_subj8_fein(UNSIGNED1 wh) := InValidMessageFT_orig_subj8_fein(wh);
 
EXPORT Make_orig_company_alternate_name(SALT39.StrType s0) := MakeFT_orig_company_alternate_name(s0);
EXPORT InValid_orig_company_alternate_name(SALT39.StrType s) := InValidFT_orig_company_alternate_name(s);
EXPORT InValidMessage_orig_company_alternate_name(UNSIGNED1 wh) := InValidMessageFT_orig_company_alternate_name(wh);
 
// This macro will compute and count field level differences based upon a pivot expression
export MAC_CountDifferencesByPivot(in_left,in_right,pivot_exp,bad_pivots,out_counts) := MACRO
  IMPORT SALT39,Scrubs_Inql_Nfcra_Batch;
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
    BOOLEAN Diff_orig_datetime_stamp;
    BOOLEAN Diff_orig_global_company_id;
    BOOLEAN Diff_orig_company_id;
    BOOLEAN Diff_orig_product_cd;
    BOOLEAN Diff_orig_method;
    BOOLEAN Diff_orig_vertical;
    BOOLEAN Diff_orig_function_name;
    BOOLEAN Diff_orig_transaction_type;
    BOOLEAN Diff_orig_login_history_id;
    BOOLEAN Diff_orig_job_id;
    BOOLEAN Diff_orig_sequence_number;
    BOOLEAN Diff_orig_first_name;
    BOOLEAN Diff_orig_middle_name;
    BOOLEAN Diff_orig_last_name;
    BOOLEAN Diff_orig_ssn;
    BOOLEAN Diff_orig_dob;
    BOOLEAN Diff_orig_dl_num;
    BOOLEAN Diff_orig_dl_state;
    BOOLEAN Diff_orig_address1_addressline1;
    BOOLEAN Diff_orig_address1_addressline2;
    BOOLEAN Diff_orig_address1_prim_range;
    BOOLEAN Diff_orig_address1_predir;
    BOOLEAN Diff_orig_address1_prim_name;
    BOOLEAN Diff_orig_address1_suffix;
    BOOLEAN Diff_orig_address1_postdir;
    BOOLEAN Diff_orig_address1_unit_desig;
    BOOLEAN Diff_orig_address1_sec_range;
    BOOLEAN Diff_orig_address1_city;
    BOOLEAN Diff_orig_address1_st;
    BOOLEAN Diff_orig_address1_z5;
    BOOLEAN Diff_orig_address1_z4;
    BOOLEAN Diff_orig_address2_addressline1;
    BOOLEAN Diff_orig_address2_addressline2;
    BOOLEAN Diff_orig_address2_prim_range;
    BOOLEAN Diff_orig_address2_predir;
    BOOLEAN Diff_orig_address2_prim_name;
    BOOLEAN Diff_orig_address2_suffix;
    BOOLEAN Diff_orig_address2_postdir;
    BOOLEAN Diff_orig_address2_unit_desig;
    BOOLEAN Diff_orig_address2_sec_range;
    BOOLEAN Diff_orig_address2_city;
    BOOLEAN Diff_orig_address2_st;
    BOOLEAN Diff_orig_address2_z5;
    BOOLEAN Diff_orig_address2_z4;
    BOOLEAN Diff_orig_bdid;
    BOOLEAN Diff_orig_bdl;
    BOOLEAN Diff_orig_did;
    BOOLEAN Diff_orig_company_name;
    BOOLEAN Diff_orig_fein;
    BOOLEAN Diff_orig_phone;
    BOOLEAN Diff_orig_work_phone;
    BOOLEAN Diff_orig_company_phone;
    BOOLEAN Diff_orig_reference_code;
    BOOLEAN Diff_orig_ip_address_initiated;
    BOOLEAN Diff_orig_ip_address_executed;
    BOOLEAN Diff_orig_charter_number;
    BOOLEAN Diff_orig_ucc_original_filing_number;
    BOOLEAN Diff_orig_email_address;
    BOOLEAN Diff_orig_domain_name;
    BOOLEAN Diff_orig_full_name;
    BOOLEAN Diff_orig_dl_purpose;
    BOOLEAN Diff_orig_glb_purpose;
    BOOLEAN Diff_orig_fcra_purpose;
    BOOLEAN Diff_orig_process_id;
    BOOLEAN Diff_orig_suffix_name;
    BOOLEAN Diff_orig_former_last_name;
    BOOLEAN Diff_orig_business_title;
    BOOLEAN Diff_orig_company_addressline1;
    BOOLEAN Diff_orig_company_addressline2;
    BOOLEAN Diff_orig_company_address_prim_range;
    BOOLEAN Diff_orig_company_address_predir;
    BOOLEAN Diff_orig_company_address_prim_name;
    BOOLEAN Diff_orig_company_address_suffix;
    BOOLEAN Diff_orig_company_address_postdir;
    BOOLEAN Diff_orig_company_address_unit_desig;
    BOOLEAN Diff_orig_company_address_sec_range;
    BOOLEAN Diff_orig_company_address_city;
    BOOLEAN Diff_orig_company_address_st;
    BOOLEAN Diff_orig_company_address_zip5;
    BOOLEAN Diff_orig_company_address_zip4;
    BOOLEAN Diff_orig_company_fax_number;
    BOOLEAN Diff_orig_company_start_date;
    BOOLEAN Diff_orig_company_years_in_business;
    BOOLEAN Diff_orig_company_sic_code;
    BOOLEAN Diff_orig_company_naic_code;
    BOOLEAN Diff_orig_company_structure;
    BOOLEAN Diff_orig_company_yearly_revenue;
    BOOLEAN Diff_orig_subj2_first_name;
    BOOLEAN Diff_orig_subj2_middle_name;
    BOOLEAN Diff_orig_subj2_last_name;
    BOOLEAN Diff_orig_subj2_suffix_name;
    BOOLEAN Diff_orig_subj2_full_name;
    BOOLEAN Diff_orig_subj2_ssn;
    BOOLEAN Diff_orig_subj2_dob;
    BOOLEAN Diff_orig_subj2_dl_num;
    BOOLEAN Diff_orig_subj2_dl_state;
    BOOLEAN Diff_orig_subj2_former_last_name;
    BOOLEAN Diff_orig_subj2_address_addressline1;
    BOOLEAN Diff_orig_subj2_address_addressline2;
    BOOLEAN Diff_orig_subj2_address_prim_range;
    BOOLEAN Diff_orig_subj2_address_predir;
    BOOLEAN Diff_orig_subj2_address_prim_name;
    BOOLEAN Diff_orig_subj2_address_suffix;
    BOOLEAN Diff_orig_subj2_address_postdir;
    BOOLEAN Diff_orig_subj2_address_unit_desig;
    BOOLEAN Diff_orig_subj2_address_sec_range;
    BOOLEAN Diff_orig_subj2_address_city;
    BOOLEAN Diff_orig_subj2_address_st;
    BOOLEAN Diff_orig_subj2_address_z5;
    BOOLEAN Diff_orig_subj2_address_z4;
    BOOLEAN Diff_orig_subj2_phone;
    BOOLEAN Diff_orig_subj2_work_phone;
    BOOLEAN Diff_orig_subj2_business_title;
    BOOLEAN Diff_orig_subj3_first_name;
    BOOLEAN Diff_orig_subj3_middle_name;
    BOOLEAN Diff_orig_subj3_last_name;
    BOOLEAN Diff_orig_subj3_suffix_name;
    BOOLEAN Diff_orig_subj3_full_name;
    BOOLEAN Diff_orig_subj3_ssn;
    BOOLEAN Diff_orig_subj3_dob;
    BOOLEAN Diff_orig_subj3_dl_num;
    BOOLEAN Diff_orig_subj3_dl_state;
    BOOLEAN Diff_orig_subj3_former_last_name;
    BOOLEAN Diff_orig_subj3_address_addressline1;
    BOOLEAN Diff_orig_subj3_address_addressline2;
    BOOLEAN Diff_orig_subj3_address_prim_range;
    BOOLEAN Diff_orig_subj3_address_predir;
    BOOLEAN Diff_orig_subj3_address_prim_name;
    BOOLEAN Diff_orig_subj3_address_suffix;
    BOOLEAN Diff_orig_subj3_address_postdir;
    BOOLEAN Diff_orig_subj3_address_unit_desig;
    BOOLEAN Diff_orig_subj3_address_sec_range;
    BOOLEAN Diff_orig_subj3_address_city;
    BOOLEAN Diff_orig_subj3_address_st;
    BOOLEAN Diff_orig_subj3_address_z5;
    BOOLEAN Diff_orig_subj3_address_z4;
    BOOLEAN Diff_orig_subj3_phone;
    BOOLEAN Diff_orig_subj3_work_phone;
    BOOLEAN Diff_orig_subj3_business_title;
    BOOLEAN Diff_orig_email;
    BOOLEAN Diff_orig_subj2_email;
    BOOLEAN Diff_orig_subj2_company_name;
    BOOLEAN Diff_orig_subj2_fein;
    BOOLEAN Diff_orig_subj3_email;
    BOOLEAN Diff_orig_subj3_company_name;
    BOOLEAN Diff_orig_subj3_fein;
    BOOLEAN Diff_orig_subj4_first_name;
    BOOLEAN Diff_orig_subj4_middle_name;
    BOOLEAN Diff_orig_subj4_last_name;
    BOOLEAN Diff_orig_subj4_suffix_name;
    BOOLEAN Diff_orig_subj4_full_name;
    BOOLEAN Diff_orig_subj4_ssn;
    BOOLEAN Diff_orig_subj4_dob;
    BOOLEAN Diff_orig_subj4_dl_num;
    BOOLEAN Diff_orig_subj4_dl_state;
    BOOLEAN Diff_orig_subj4_former_last_name;
    BOOLEAN Diff_orig_subj4_address_addressline1;
    BOOLEAN Diff_orig_subj4_address_addressline2;
    BOOLEAN Diff_orig_subj4_address_prim_range;
    BOOLEAN Diff_orig_subj4_address_predir;
    BOOLEAN Diff_orig_subj4_address_prim_name;
    BOOLEAN Diff_orig_subj4_address_suffix;
    BOOLEAN Diff_orig_subj4_address_postdir;
    BOOLEAN Diff_orig_subj4_address_unit_desig;
    BOOLEAN Diff_orig_subj4_address_sec_range;
    BOOLEAN Diff_orig_subj4_address_city;
    BOOLEAN Diff_orig_subj4_address_st;
    BOOLEAN Diff_orig_subj4_address_z5;
    BOOLEAN Diff_orig_subj4_address_z4;
    BOOLEAN Diff_orig_subj4_phone;
    BOOLEAN Diff_orig_subj4_work_phone;
    BOOLEAN Diff_orig_subj4_business_title;
    BOOLEAN Diff_orig_subj4_email;
    BOOLEAN Diff_orig_subj4_company_name;
    BOOLEAN Diff_orig_subj4_fein;
    BOOLEAN Diff_orig_subj5_first_name;
    BOOLEAN Diff_orig_subj5_middle_name;
    BOOLEAN Diff_orig_subj5_last_name;
    BOOLEAN Diff_orig_subj5_suffix_name;
    BOOLEAN Diff_orig_subj5_full_name;
    BOOLEAN Diff_orig_subj5_ssn;
    BOOLEAN Diff_orig_subj5_dob;
    BOOLEAN Diff_orig_subj5_dl_num;
    BOOLEAN Diff_orig_subj5_dl_state;
    BOOLEAN Diff_orig_subj5_former_last_name;
    BOOLEAN Diff_orig_subj5_address_addressline1;
    BOOLEAN Diff_orig_subj5_address_addressline2;
    BOOLEAN Diff_orig_subj5_address_prim_range;
    BOOLEAN Diff_orig_subj5_address_predir;
    BOOLEAN Diff_orig_subj5_address_prim_name;
    BOOLEAN Diff_orig_subj5_address_suffix;
    BOOLEAN Diff_orig_subj5_address_postdir;
    BOOLEAN Diff_orig_subj5_address_unit_desig;
    BOOLEAN Diff_orig_subj5_address_sec_range;
    BOOLEAN Diff_orig_subj5_address_city;
    BOOLEAN Diff_orig_subj5_address_st;
    BOOLEAN Diff_orig_subj5_address_z5;
    BOOLEAN Diff_orig_subj5_address_z4;
    BOOLEAN Diff_orig_subj5_phone;
    BOOLEAN Diff_orig_subj5_work_phone;
    BOOLEAN Diff_orig_subj5_business_title;
    BOOLEAN Diff_orig_subj5_email;
    BOOLEAN Diff_orig_subj5_company_name;
    BOOLEAN Diff_orig_subj5_fein;
    BOOLEAN Diff_orig_subj6_first_name;
    BOOLEAN Diff_orig_subj6_middle_name;
    BOOLEAN Diff_orig_subj6_last_name;
    BOOLEAN Diff_orig_subj6_suffix_name;
    BOOLEAN Diff_orig_subj6_full_name;
    BOOLEAN Diff_orig_subj6_ssn;
    BOOLEAN Diff_orig_subj6_dob;
    BOOLEAN Diff_orig_subj6_dl_num;
    BOOLEAN Diff_orig_subj6_dl_state;
    BOOLEAN Diff_orig_subj6_former_last_name;
    BOOLEAN Diff_orig_subj6_address_addressline1;
    BOOLEAN Diff_orig_subj6_address_addressline2;
    BOOLEAN Diff_orig_subj6_address_prim_range;
    BOOLEAN Diff_orig_subj6_address_predir;
    BOOLEAN Diff_orig_subj6_address_prim_name;
    BOOLEAN Diff_orig_subj6_address_suffix;
    BOOLEAN Diff_orig_subj6_address_postdir;
    BOOLEAN Diff_orig_subj6_address_unit_desig;
    BOOLEAN Diff_orig_subj6_address_sec_range;
    BOOLEAN Diff_orig_subj6_address_city;
    BOOLEAN Diff_orig_subj6_address_st;
    BOOLEAN Diff_orig_subj6_address_z5;
    BOOLEAN Diff_orig_subj6_address_z4;
    BOOLEAN Diff_orig_subj6_phone;
    BOOLEAN Diff_orig_subj6_work_phone;
    BOOLEAN Diff_orig_subj6_business_title;
    BOOLEAN Diff_orig_subj6_email;
    BOOLEAN Diff_orig_subj6_company_name;
    BOOLEAN Diff_orig_subj6_fein;
    BOOLEAN Diff_orig_subj7_first_name;
    BOOLEAN Diff_orig_subj7_middle_name;
    BOOLEAN Diff_orig_subj7_last_name;
    BOOLEAN Diff_orig_subj7_suffix_name;
    BOOLEAN Diff_orig_subj7_full_name;
    BOOLEAN Diff_orig_subj7_ssn;
    BOOLEAN Diff_orig_subj7_dob;
    BOOLEAN Diff_orig_subj7_dl_num;
    BOOLEAN Diff_orig_subj7_dl_state;
    BOOLEAN Diff_orig_subj7_former_last_name;
    BOOLEAN Diff_orig_subj7_address_addressline1;
    BOOLEAN Diff_orig_subj7_address_addressline2;
    BOOLEAN Diff_orig_subj7_address_prim_range;
    BOOLEAN Diff_orig_subj7_address_predir;
    BOOLEAN Diff_orig_subj7_address_prim_name;
    BOOLEAN Diff_orig_subj7_address_suffix;
    BOOLEAN Diff_orig_subj7_address_postdir;
    BOOLEAN Diff_orig_subj7_address_unit_desig;
    BOOLEAN Diff_orig_subj7_address_sec_range;
    BOOLEAN Diff_orig_subj7_address_city;
    BOOLEAN Diff_orig_subj7_address_st;
    BOOLEAN Diff_orig_subj7_address_z5;
    BOOLEAN Diff_orig_subj7_address_z4;
    BOOLEAN Diff_orig_subj7_phone;
    BOOLEAN Diff_orig_subj7_work_phone;
    BOOLEAN Diff_orig_subj7_business_title;
    BOOLEAN Diff_orig_subj7_email;
    BOOLEAN Diff_orig_subj7_company_name;
    BOOLEAN Diff_orig_subj7_fein;
    BOOLEAN Diff_orig_subj8_first_name;
    BOOLEAN Diff_orig_subj8_middle_name;
    BOOLEAN Diff_orig_subj8_last_name;
    BOOLEAN Diff_orig_subj8_suffix_name;
    BOOLEAN Diff_orig_subj8_full_name;
    BOOLEAN Diff_orig_subj8_ssn;
    BOOLEAN Diff_orig_subj8_dob;
    BOOLEAN Diff_orig_subj8_dl_num;
    BOOLEAN Diff_orig_subj8_dl_state;
    BOOLEAN Diff_orig_subj8_former_last_name;
    BOOLEAN Diff_orig_subj8_address_addressline1;
    BOOLEAN Diff_orig_subj8_address_addressline2;
    BOOLEAN Diff_orig_subj8_address_prim_range;
    BOOLEAN Diff_orig_subj8_address_predir;
    BOOLEAN Diff_orig_subj8_address_prim_name;
    BOOLEAN Diff_orig_subj8_address_suffix;
    BOOLEAN Diff_orig_subj8_address_postdir;
    BOOLEAN Diff_orig_subj8_address_unit_desig;
    BOOLEAN Diff_orig_subj8_address_sec_range;
    BOOLEAN Diff_orig_subj8_address_city;
    BOOLEAN Diff_orig_subj8_address_st;
    BOOLEAN Diff_orig_subj8_address_z5;
    BOOLEAN Diff_orig_subj8_address_z4;
    BOOLEAN Diff_orig_subj8_phone;
    BOOLEAN Diff_orig_subj8_work_phone;
    BOOLEAN Diff_orig_subj8_business_title;
    BOOLEAN Diff_orig_subj8_email;
    BOOLEAN Diff_orig_subj8_company_name;
    BOOLEAN Diff_orig_subj8_fein;
    BOOLEAN Diff_orig_company_alternate_name;
    UNSIGNED Num_Diffs;
    SALT39.StrType Val {MAXLENGTH(1024)};
  END;
#uniquename(fd)
  %dl% %fd%(in_left le,in_right ri) := TRANSFORM
    SELF.Diff_orig_datetime_stamp := le.orig_datetime_stamp <> ri.orig_datetime_stamp;
    SELF.Diff_orig_global_company_id := le.orig_global_company_id <> ri.orig_global_company_id;
    SELF.Diff_orig_company_id := le.orig_company_id <> ri.orig_company_id;
    SELF.Diff_orig_product_cd := le.orig_product_cd <> ri.orig_product_cd;
    SELF.Diff_orig_method := le.orig_method <> ri.orig_method;
    SELF.Diff_orig_vertical := le.orig_vertical <> ri.orig_vertical;
    SELF.Diff_orig_function_name := le.orig_function_name <> ri.orig_function_name;
    SELF.Diff_orig_transaction_type := le.orig_transaction_type <> ri.orig_transaction_type;
    SELF.Diff_orig_login_history_id := le.orig_login_history_id <> ri.orig_login_history_id;
    SELF.Diff_orig_job_id := le.orig_job_id <> ri.orig_job_id;
    SELF.Diff_orig_sequence_number := le.orig_sequence_number <> ri.orig_sequence_number;
    SELF.Diff_orig_first_name := le.orig_first_name <> ri.orig_first_name;
    SELF.Diff_orig_middle_name := le.orig_middle_name <> ri.orig_middle_name;
    SELF.Diff_orig_last_name := le.orig_last_name <> ri.orig_last_name;
    SELF.Diff_orig_ssn := le.orig_ssn <> ri.orig_ssn;
    SELF.Diff_orig_dob := le.orig_dob <> ri.orig_dob;
    SELF.Diff_orig_dl_num := le.orig_dl_num <> ri.orig_dl_num;
    SELF.Diff_orig_dl_state := le.orig_dl_state <> ri.orig_dl_state;
    SELF.Diff_orig_address1_addressline1 := le.orig_address1_addressline1 <> ri.orig_address1_addressline1;
    SELF.Diff_orig_address1_addressline2 := le.orig_address1_addressline2 <> ri.orig_address1_addressline2;
    SELF.Diff_orig_address1_prim_range := le.orig_address1_prim_range <> ri.orig_address1_prim_range;
    SELF.Diff_orig_address1_predir := le.orig_address1_predir <> ri.orig_address1_predir;
    SELF.Diff_orig_address1_prim_name := le.orig_address1_prim_name <> ri.orig_address1_prim_name;
    SELF.Diff_orig_address1_suffix := le.orig_address1_suffix <> ri.orig_address1_suffix;
    SELF.Diff_orig_address1_postdir := le.orig_address1_postdir <> ri.orig_address1_postdir;
    SELF.Diff_orig_address1_unit_desig := le.orig_address1_unit_desig <> ri.orig_address1_unit_desig;
    SELF.Diff_orig_address1_sec_range := le.orig_address1_sec_range <> ri.orig_address1_sec_range;
    SELF.Diff_orig_address1_city := le.orig_address1_city <> ri.orig_address1_city;
    SELF.Diff_orig_address1_st := le.orig_address1_st <> ri.orig_address1_st;
    SELF.Diff_orig_address1_z5 := le.orig_address1_z5 <> ri.orig_address1_z5;
    SELF.Diff_orig_address1_z4 := le.orig_address1_z4 <> ri.orig_address1_z4;
    SELF.Diff_orig_address2_addressline1 := le.orig_address2_addressline1 <> ri.orig_address2_addressline1;
    SELF.Diff_orig_address2_addressline2 := le.orig_address2_addressline2 <> ri.orig_address2_addressline2;
    SELF.Diff_orig_address2_prim_range := le.orig_address2_prim_range <> ri.orig_address2_prim_range;
    SELF.Diff_orig_address2_predir := le.orig_address2_predir <> ri.orig_address2_predir;
    SELF.Diff_orig_address2_prim_name := le.orig_address2_prim_name <> ri.orig_address2_prim_name;
    SELF.Diff_orig_address2_suffix := le.orig_address2_suffix <> ri.orig_address2_suffix;
    SELF.Diff_orig_address2_postdir := le.orig_address2_postdir <> ri.orig_address2_postdir;
    SELF.Diff_orig_address2_unit_desig := le.orig_address2_unit_desig <> ri.orig_address2_unit_desig;
    SELF.Diff_orig_address2_sec_range := le.orig_address2_sec_range <> ri.orig_address2_sec_range;
    SELF.Diff_orig_address2_city := le.orig_address2_city <> ri.orig_address2_city;
    SELF.Diff_orig_address2_st := le.orig_address2_st <> ri.orig_address2_st;
    SELF.Diff_orig_address2_z5 := le.orig_address2_z5 <> ri.orig_address2_z5;
    SELF.Diff_orig_address2_z4 := le.orig_address2_z4 <> ri.orig_address2_z4;
    SELF.Diff_orig_bdid := le.orig_bdid <> ri.orig_bdid;
    SELF.Diff_orig_bdl := le.orig_bdl <> ri.orig_bdl;
    SELF.Diff_orig_did := le.orig_did <> ri.orig_did;
    SELF.Diff_orig_company_name := le.orig_company_name <> ri.orig_company_name;
    SELF.Diff_orig_fein := le.orig_fein <> ri.orig_fein;
    SELF.Diff_orig_phone := le.orig_phone <> ri.orig_phone;
    SELF.Diff_orig_work_phone := le.orig_work_phone <> ri.orig_work_phone;
    SELF.Diff_orig_company_phone := le.orig_company_phone <> ri.orig_company_phone;
    SELF.Diff_orig_reference_code := le.orig_reference_code <> ri.orig_reference_code;
    SELF.Diff_orig_ip_address_initiated := le.orig_ip_address_initiated <> ri.orig_ip_address_initiated;
    SELF.Diff_orig_ip_address_executed := le.orig_ip_address_executed <> ri.orig_ip_address_executed;
    SELF.Diff_orig_charter_number := le.orig_charter_number <> ri.orig_charter_number;
    SELF.Diff_orig_ucc_original_filing_number := le.orig_ucc_original_filing_number <> ri.orig_ucc_original_filing_number;
    SELF.Diff_orig_email_address := le.orig_email_address <> ri.orig_email_address;
    SELF.Diff_orig_domain_name := le.orig_domain_name <> ri.orig_domain_name;
    SELF.Diff_orig_full_name := le.orig_full_name <> ri.orig_full_name;
    SELF.Diff_orig_dl_purpose := le.orig_dl_purpose <> ri.orig_dl_purpose;
    SELF.Diff_orig_glb_purpose := le.orig_glb_purpose <> ri.orig_glb_purpose;
    SELF.Diff_orig_fcra_purpose := le.orig_fcra_purpose <> ri.orig_fcra_purpose;
    SELF.Diff_orig_process_id := le.orig_process_id <> ri.orig_process_id;
    SELF.Diff_orig_suffix_name := le.orig_suffix_name <> ri.orig_suffix_name;
    SELF.Diff_orig_former_last_name := le.orig_former_last_name <> ri.orig_former_last_name;
    SELF.Diff_orig_business_title := le.orig_business_title <> ri.orig_business_title;
    SELF.Diff_orig_company_addressline1 := le.orig_company_addressline1 <> ri.orig_company_addressline1;
    SELF.Diff_orig_company_addressline2 := le.orig_company_addressline2 <> ri.orig_company_addressline2;
    SELF.Diff_orig_company_address_prim_range := le.orig_company_address_prim_range <> ri.orig_company_address_prim_range;
    SELF.Diff_orig_company_address_predir := le.orig_company_address_predir <> ri.orig_company_address_predir;
    SELF.Diff_orig_company_address_prim_name := le.orig_company_address_prim_name <> ri.orig_company_address_prim_name;
    SELF.Diff_orig_company_address_suffix := le.orig_company_address_suffix <> ri.orig_company_address_suffix;
    SELF.Diff_orig_company_address_postdir := le.orig_company_address_postdir <> ri.orig_company_address_postdir;
    SELF.Diff_orig_company_address_unit_desig := le.orig_company_address_unit_desig <> ri.orig_company_address_unit_desig;
    SELF.Diff_orig_company_address_sec_range := le.orig_company_address_sec_range <> ri.orig_company_address_sec_range;
    SELF.Diff_orig_company_address_city := le.orig_company_address_city <> ri.orig_company_address_city;
    SELF.Diff_orig_company_address_st := le.orig_company_address_st <> ri.orig_company_address_st;
    SELF.Diff_orig_company_address_zip5 := le.orig_company_address_zip5 <> ri.orig_company_address_zip5;
    SELF.Diff_orig_company_address_zip4 := le.orig_company_address_zip4 <> ri.orig_company_address_zip4;
    SELF.Diff_orig_company_fax_number := le.orig_company_fax_number <> ri.orig_company_fax_number;
    SELF.Diff_orig_company_start_date := le.orig_company_start_date <> ri.orig_company_start_date;
    SELF.Diff_orig_company_years_in_business := le.orig_company_years_in_business <> ri.orig_company_years_in_business;
    SELF.Diff_orig_company_sic_code := le.orig_company_sic_code <> ri.orig_company_sic_code;
    SELF.Diff_orig_company_naic_code := le.orig_company_naic_code <> ri.orig_company_naic_code;
    SELF.Diff_orig_company_structure := le.orig_company_structure <> ri.orig_company_structure;
    SELF.Diff_orig_company_yearly_revenue := le.orig_company_yearly_revenue <> ri.orig_company_yearly_revenue;
    SELF.Diff_orig_subj2_first_name := le.orig_subj2_first_name <> ri.orig_subj2_first_name;
    SELF.Diff_orig_subj2_middle_name := le.orig_subj2_middle_name <> ri.orig_subj2_middle_name;
    SELF.Diff_orig_subj2_last_name := le.orig_subj2_last_name <> ri.orig_subj2_last_name;
    SELF.Diff_orig_subj2_suffix_name := le.orig_subj2_suffix_name <> ri.orig_subj2_suffix_name;
    SELF.Diff_orig_subj2_full_name := le.orig_subj2_full_name <> ri.orig_subj2_full_name;
    SELF.Diff_orig_subj2_ssn := le.orig_subj2_ssn <> ri.orig_subj2_ssn;
    SELF.Diff_orig_subj2_dob := le.orig_subj2_dob <> ri.orig_subj2_dob;
    SELF.Diff_orig_subj2_dl_num := le.orig_subj2_dl_num <> ri.orig_subj2_dl_num;
    SELF.Diff_orig_subj2_dl_state := le.orig_subj2_dl_state <> ri.orig_subj2_dl_state;
    SELF.Diff_orig_subj2_former_last_name := le.orig_subj2_former_last_name <> ri.orig_subj2_former_last_name;
    SELF.Diff_orig_subj2_address_addressline1 := le.orig_subj2_address_addressline1 <> ri.orig_subj2_address_addressline1;
    SELF.Diff_orig_subj2_address_addressline2 := le.orig_subj2_address_addressline2 <> ri.orig_subj2_address_addressline2;
    SELF.Diff_orig_subj2_address_prim_range := le.orig_subj2_address_prim_range <> ri.orig_subj2_address_prim_range;
    SELF.Diff_orig_subj2_address_predir := le.orig_subj2_address_predir <> ri.orig_subj2_address_predir;
    SELF.Diff_orig_subj2_address_prim_name := le.orig_subj2_address_prim_name <> ri.orig_subj2_address_prim_name;
    SELF.Diff_orig_subj2_address_suffix := le.orig_subj2_address_suffix <> ri.orig_subj2_address_suffix;
    SELF.Diff_orig_subj2_address_postdir := le.orig_subj2_address_postdir <> ri.orig_subj2_address_postdir;
    SELF.Diff_orig_subj2_address_unit_desig := le.orig_subj2_address_unit_desig <> ri.orig_subj2_address_unit_desig;
    SELF.Diff_orig_subj2_address_sec_range := le.orig_subj2_address_sec_range <> ri.orig_subj2_address_sec_range;
    SELF.Diff_orig_subj2_address_city := le.orig_subj2_address_city <> ri.orig_subj2_address_city;
    SELF.Diff_orig_subj2_address_st := le.orig_subj2_address_st <> ri.orig_subj2_address_st;
    SELF.Diff_orig_subj2_address_z5 := le.orig_subj2_address_z5 <> ri.orig_subj2_address_z5;
    SELF.Diff_orig_subj2_address_z4 := le.orig_subj2_address_z4 <> ri.orig_subj2_address_z4;
    SELF.Diff_orig_subj2_phone := le.orig_subj2_phone <> ri.orig_subj2_phone;
    SELF.Diff_orig_subj2_work_phone := le.orig_subj2_work_phone <> ri.orig_subj2_work_phone;
    SELF.Diff_orig_subj2_business_title := le.orig_subj2_business_title <> ri.orig_subj2_business_title;
    SELF.Diff_orig_subj3_first_name := le.orig_subj3_first_name <> ri.orig_subj3_first_name;
    SELF.Diff_orig_subj3_middle_name := le.orig_subj3_middle_name <> ri.orig_subj3_middle_name;
    SELF.Diff_orig_subj3_last_name := le.orig_subj3_last_name <> ri.orig_subj3_last_name;
    SELF.Diff_orig_subj3_suffix_name := le.orig_subj3_suffix_name <> ri.orig_subj3_suffix_name;
    SELF.Diff_orig_subj3_full_name := le.orig_subj3_full_name <> ri.orig_subj3_full_name;
    SELF.Diff_orig_subj3_ssn := le.orig_subj3_ssn <> ri.orig_subj3_ssn;
    SELF.Diff_orig_subj3_dob := le.orig_subj3_dob <> ri.orig_subj3_dob;
    SELF.Diff_orig_subj3_dl_num := le.orig_subj3_dl_num <> ri.orig_subj3_dl_num;
    SELF.Diff_orig_subj3_dl_state := le.orig_subj3_dl_state <> ri.orig_subj3_dl_state;
    SELF.Diff_orig_subj3_former_last_name := le.orig_subj3_former_last_name <> ri.orig_subj3_former_last_name;
    SELF.Diff_orig_subj3_address_addressline1 := le.orig_subj3_address_addressline1 <> ri.orig_subj3_address_addressline1;
    SELF.Diff_orig_subj3_address_addressline2 := le.orig_subj3_address_addressline2 <> ri.orig_subj3_address_addressline2;
    SELF.Diff_orig_subj3_address_prim_range := le.orig_subj3_address_prim_range <> ri.orig_subj3_address_prim_range;
    SELF.Diff_orig_subj3_address_predir := le.orig_subj3_address_predir <> ri.orig_subj3_address_predir;
    SELF.Diff_orig_subj3_address_prim_name := le.orig_subj3_address_prim_name <> ri.orig_subj3_address_prim_name;
    SELF.Diff_orig_subj3_address_suffix := le.orig_subj3_address_suffix <> ri.orig_subj3_address_suffix;
    SELF.Diff_orig_subj3_address_postdir := le.orig_subj3_address_postdir <> ri.orig_subj3_address_postdir;
    SELF.Diff_orig_subj3_address_unit_desig := le.orig_subj3_address_unit_desig <> ri.orig_subj3_address_unit_desig;
    SELF.Diff_orig_subj3_address_sec_range := le.orig_subj3_address_sec_range <> ri.orig_subj3_address_sec_range;
    SELF.Diff_orig_subj3_address_city := le.orig_subj3_address_city <> ri.orig_subj3_address_city;
    SELF.Diff_orig_subj3_address_st := le.orig_subj3_address_st <> ri.orig_subj3_address_st;
    SELF.Diff_orig_subj3_address_z5 := le.orig_subj3_address_z5 <> ri.orig_subj3_address_z5;
    SELF.Diff_orig_subj3_address_z4 := le.orig_subj3_address_z4 <> ri.orig_subj3_address_z4;
    SELF.Diff_orig_subj3_phone := le.orig_subj3_phone <> ri.orig_subj3_phone;
    SELF.Diff_orig_subj3_work_phone := le.orig_subj3_work_phone <> ri.orig_subj3_work_phone;
    SELF.Diff_orig_subj3_business_title := le.orig_subj3_business_title <> ri.orig_subj3_business_title;
    SELF.Diff_orig_email := le.orig_email <> ri.orig_email;
    SELF.Diff_orig_subj2_email := le.orig_subj2_email <> ri.orig_subj2_email;
    SELF.Diff_orig_subj2_company_name := le.orig_subj2_company_name <> ri.orig_subj2_company_name;
    SELF.Diff_orig_subj2_fein := le.orig_subj2_fein <> ri.orig_subj2_fein;
    SELF.Diff_orig_subj3_email := le.orig_subj3_email <> ri.orig_subj3_email;
    SELF.Diff_orig_subj3_company_name := le.orig_subj3_company_name <> ri.orig_subj3_company_name;
    SELF.Diff_orig_subj3_fein := le.orig_subj3_fein <> ri.orig_subj3_fein;
    SELF.Diff_orig_subj4_first_name := le.orig_subj4_first_name <> ri.orig_subj4_first_name;
    SELF.Diff_orig_subj4_middle_name := le.orig_subj4_middle_name <> ri.orig_subj4_middle_name;
    SELF.Diff_orig_subj4_last_name := le.orig_subj4_last_name <> ri.orig_subj4_last_name;
    SELF.Diff_orig_subj4_suffix_name := le.orig_subj4_suffix_name <> ri.orig_subj4_suffix_name;
    SELF.Diff_orig_subj4_full_name := le.orig_subj4_full_name <> ri.orig_subj4_full_name;
    SELF.Diff_orig_subj4_ssn := le.orig_subj4_ssn <> ri.orig_subj4_ssn;
    SELF.Diff_orig_subj4_dob := le.orig_subj4_dob <> ri.orig_subj4_dob;
    SELF.Diff_orig_subj4_dl_num := le.orig_subj4_dl_num <> ri.orig_subj4_dl_num;
    SELF.Diff_orig_subj4_dl_state := le.orig_subj4_dl_state <> ri.orig_subj4_dl_state;
    SELF.Diff_orig_subj4_former_last_name := le.orig_subj4_former_last_name <> ri.orig_subj4_former_last_name;
    SELF.Diff_orig_subj4_address_addressline1 := le.orig_subj4_address_addressline1 <> ri.orig_subj4_address_addressline1;
    SELF.Diff_orig_subj4_address_addressline2 := le.orig_subj4_address_addressline2 <> ri.orig_subj4_address_addressline2;
    SELF.Diff_orig_subj4_address_prim_range := le.orig_subj4_address_prim_range <> ri.orig_subj4_address_prim_range;
    SELF.Diff_orig_subj4_address_predir := le.orig_subj4_address_predir <> ri.orig_subj4_address_predir;
    SELF.Diff_orig_subj4_address_prim_name := le.orig_subj4_address_prim_name <> ri.orig_subj4_address_prim_name;
    SELF.Diff_orig_subj4_address_suffix := le.orig_subj4_address_suffix <> ri.orig_subj4_address_suffix;
    SELF.Diff_orig_subj4_address_postdir := le.orig_subj4_address_postdir <> ri.orig_subj4_address_postdir;
    SELF.Diff_orig_subj4_address_unit_desig := le.orig_subj4_address_unit_desig <> ri.orig_subj4_address_unit_desig;
    SELF.Diff_orig_subj4_address_sec_range := le.orig_subj4_address_sec_range <> ri.orig_subj4_address_sec_range;
    SELF.Diff_orig_subj4_address_city := le.orig_subj4_address_city <> ri.orig_subj4_address_city;
    SELF.Diff_orig_subj4_address_st := le.orig_subj4_address_st <> ri.orig_subj4_address_st;
    SELF.Diff_orig_subj4_address_z5 := le.orig_subj4_address_z5 <> ri.orig_subj4_address_z5;
    SELF.Diff_orig_subj4_address_z4 := le.orig_subj4_address_z4 <> ri.orig_subj4_address_z4;
    SELF.Diff_orig_subj4_phone := le.orig_subj4_phone <> ri.orig_subj4_phone;
    SELF.Diff_orig_subj4_work_phone := le.orig_subj4_work_phone <> ri.orig_subj4_work_phone;
    SELF.Diff_orig_subj4_business_title := le.orig_subj4_business_title <> ri.orig_subj4_business_title;
    SELF.Diff_orig_subj4_email := le.orig_subj4_email <> ri.orig_subj4_email;
    SELF.Diff_orig_subj4_company_name := le.orig_subj4_company_name <> ri.orig_subj4_company_name;
    SELF.Diff_orig_subj4_fein := le.orig_subj4_fein <> ri.orig_subj4_fein;
    SELF.Diff_orig_subj5_first_name := le.orig_subj5_first_name <> ri.orig_subj5_first_name;
    SELF.Diff_orig_subj5_middle_name := le.orig_subj5_middle_name <> ri.orig_subj5_middle_name;
    SELF.Diff_orig_subj5_last_name := le.orig_subj5_last_name <> ri.orig_subj5_last_name;
    SELF.Diff_orig_subj5_suffix_name := le.orig_subj5_suffix_name <> ri.orig_subj5_suffix_name;
    SELF.Diff_orig_subj5_full_name := le.orig_subj5_full_name <> ri.orig_subj5_full_name;
    SELF.Diff_orig_subj5_ssn := le.orig_subj5_ssn <> ri.orig_subj5_ssn;
    SELF.Diff_orig_subj5_dob := le.orig_subj5_dob <> ri.orig_subj5_dob;
    SELF.Diff_orig_subj5_dl_num := le.orig_subj5_dl_num <> ri.orig_subj5_dl_num;
    SELF.Diff_orig_subj5_dl_state := le.orig_subj5_dl_state <> ri.orig_subj5_dl_state;
    SELF.Diff_orig_subj5_former_last_name := le.orig_subj5_former_last_name <> ri.orig_subj5_former_last_name;
    SELF.Diff_orig_subj5_address_addressline1 := le.orig_subj5_address_addressline1 <> ri.orig_subj5_address_addressline1;
    SELF.Diff_orig_subj5_address_addressline2 := le.orig_subj5_address_addressline2 <> ri.orig_subj5_address_addressline2;
    SELF.Diff_orig_subj5_address_prim_range := le.orig_subj5_address_prim_range <> ri.orig_subj5_address_prim_range;
    SELF.Diff_orig_subj5_address_predir := le.orig_subj5_address_predir <> ri.orig_subj5_address_predir;
    SELF.Diff_orig_subj5_address_prim_name := le.orig_subj5_address_prim_name <> ri.orig_subj5_address_prim_name;
    SELF.Diff_orig_subj5_address_suffix := le.orig_subj5_address_suffix <> ri.orig_subj5_address_suffix;
    SELF.Diff_orig_subj5_address_postdir := le.orig_subj5_address_postdir <> ri.orig_subj5_address_postdir;
    SELF.Diff_orig_subj5_address_unit_desig := le.orig_subj5_address_unit_desig <> ri.orig_subj5_address_unit_desig;
    SELF.Diff_orig_subj5_address_sec_range := le.orig_subj5_address_sec_range <> ri.orig_subj5_address_sec_range;
    SELF.Diff_orig_subj5_address_city := le.orig_subj5_address_city <> ri.orig_subj5_address_city;
    SELF.Diff_orig_subj5_address_st := le.orig_subj5_address_st <> ri.orig_subj5_address_st;
    SELF.Diff_orig_subj5_address_z5 := le.orig_subj5_address_z5 <> ri.orig_subj5_address_z5;
    SELF.Diff_orig_subj5_address_z4 := le.orig_subj5_address_z4 <> ri.orig_subj5_address_z4;
    SELF.Diff_orig_subj5_phone := le.orig_subj5_phone <> ri.orig_subj5_phone;
    SELF.Diff_orig_subj5_work_phone := le.orig_subj5_work_phone <> ri.orig_subj5_work_phone;
    SELF.Diff_orig_subj5_business_title := le.orig_subj5_business_title <> ri.orig_subj5_business_title;
    SELF.Diff_orig_subj5_email := le.orig_subj5_email <> ri.orig_subj5_email;
    SELF.Diff_orig_subj5_company_name := le.orig_subj5_company_name <> ri.orig_subj5_company_name;
    SELF.Diff_orig_subj5_fein := le.orig_subj5_fein <> ri.orig_subj5_fein;
    SELF.Diff_orig_subj6_first_name := le.orig_subj6_first_name <> ri.orig_subj6_first_name;
    SELF.Diff_orig_subj6_middle_name := le.orig_subj6_middle_name <> ri.orig_subj6_middle_name;
    SELF.Diff_orig_subj6_last_name := le.orig_subj6_last_name <> ri.orig_subj6_last_name;
    SELF.Diff_orig_subj6_suffix_name := le.orig_subj6_suffix_name <> ri.orig_subj6_suffix_name;
    SELF.Diff_orig_subj6_full_name := le.orig_subj6_full_name <> ri.orig_subj6_full_name;
    SELF.Diff_orig_subj6_ssn := le.orig_subj6_ssn <> ri.orig_subj6_ssn;
    SELF.Diff_orig_subj6_dob := le.orig_subj6_dob <> ri.orig_subj6_dob;
    SELF.Diff_orig_subj6_dl_num := le.orig_subj6_dl_num <> ri.orig_subj6_dl_num;
    SELF.Diff_orig_subj6_dl_state := le.orig_subj6_dl_state <> ri.orig_subj6_dl_state;
    SELF.Diff_orig_subj6_former_last_name := le.orig_subj6_former_last_name <> ri.orig_subj6_former_last_name;
    SELF.Diff_orig_subj6_address_addressline1 := le.orig_subj6_address_addressline1 <> ri.orig_subj6_address_addressline1;
    SELF.Diff_orig_subj6_address_addressline2 := le.orig_subj6_address_addressline2 <> ri.orig_subj6_address_addressline2;
    SELF.Diff_orig_subj6_address_prim_range := le.orig_subj6_address_prim_range <> ri.orig_subj6_address_prim_range;
    SELF.Diff_orig_subj6_address_predir := le.orig_subj6_address_predir <> ri.orig_subj6_address_predir;
    SELF.Diff_orig_subj6_address_prim_name := le.orig_subj6_address_prim_name <> ri.orig_subj6_address_prim_name;
    SELF.Diff_orig_subj6_address_suffix := le.orig_subj6_address_suffix <> ri.orig_subj6_address_suffix;
    SELF.Diff_orig_subj6_address_postdir := le.orig_subj6_address_postdir <> ri.orig_subj6_address_postdir;
    SELF.Diff_orig_subj6_address_unit_desig := le.orig_subj6_address_unit_desig <> ri.orig_subj6_address_unit_desig;
    SELF.Diff_orig_subj6_address_sec_range := le.orig_subj6_address_sec_range <> ri.orig_subj6_address_sec_range;
    SELF.Diff_orig_subj6_address_city := le.orig_subj6_address_city <> ri.orig_subj6_address_city;
    SELF.Diff_orig_subj6_address_st := le.orig_subj6_address_st <> ri.orig_subj6_address_st;
    SELF.Diff_orig_subj6_address_z5 := le.orig_subj6_address_z5 <> ri.orig_subj6_address_z5;
    SELF.Diff_orig_subj6_address_z4 := le.orig_subj6_address_z4 <> ri.orig_subj6_address_z4;
    SELF.Diff_orig_subj6_phone := le.orig_subj6_phone <> ri.orig_subj6_phone;
    SELF.Diff_orig_subj6_work_phone := le.orig_subj6_work_phone <> ri.orig_subj6_work_phone;
    SELF.Diff_orig_subj6_business_title := le.orig_subj6_business_title <> ri.orig_subj6_business_title;
    SELF.Diff_orig_subj6_email := le.orig_subj6_email <> ri.orig_subj6_email;
    SELF.Diff_orig_subj6_company_name := le.orig_subj6_company_name <> ri.orig_subj6_company_name;
    SELF.Diff_orig_subj6_fein := le.orig_subj6_fein <> ri.orig_subj6_fein;
    SELF.Diff_orig_subj7_first_name := le.orig_subj7_first_name <> ri.orig_subj7_first_name;
    SELF.Diff_orig_subj7_middle_name := le.orig_subj7_middle_name <> ri.orig_subj7_middle_name;
    SELF.Diff_orig_subj7_last_name := le.orig_subj7_last_name <> ri.orig_subj7_last_name;
    SELF.Diff_orig_subj7_suffix_name := le.orig_subj7_suffix_name <> ri.orig_subj7_suffix_name;
    SELF.Diff_orig_subj7_full_name := le.orig_subj7_full_name <> ri.orig_subj7_full_name;
    SELF.Diff_orig_subj7_ssn := le.orig_subj7_ssn <> ri.orig_subj7_ssn;
    SELF.Diff_orig_subj7_dob := le.orig_subj7_dob <> ri.orig_subj7_dob;
    SELF.Diff_orig_subj7_dl_num := le.orig_subj7_dl_num <> ri.orig_subj7_dl_num;
    SELF.Diff_orig_subj7_dl_state := le.orig_subj7_dl_state <> ri.orig_subj7_dl_state;
    SELF.Diff_orig_subj7_former_last_name := le.orig_subj7_former_last_name <> ri.orig_subj7_former_last_name;
    SELF.Diff_orig_subj7_address_addressline1 := le.orig_subj7_address_addressline1 <> ri.orig_subj7_address_addressline1;
    SELF.Diff_orig_subj7_address_addressline2 := le.orig_subj7_address_addressline2 <> ri.orig_subj7_address_addressline2;
    SELF.Diff_orig_subj7_address_prim_range := le.orig_subj7_address_prim_range <> ri.orig_subj7_address_prim_range;
    SELF.Diff_orig_subj7_address_predir := le.orig_subj7_address_predir <> ri.orig_subj7_address_predir;
    SELF.Diff_orig_subj7_address_prim_name := le.orig_subj7_address_prim_name <> ri.orig_subj7_address_prim_name;
    SELF.Diff_orig_subj7_address_suffix := le.orig_subj7_address_suffix <> ri.orig_subj7_address_suffix;
    SELF.Diff_orig_subj7_address_postdir := le.orig_subj7_address_postdir <> ri.orig_subj7_address_postdir;
    SELF.Diff_orig_subj7_address_unit_desig := le.orig_subj7_address_unit_desig <> ri.orig_subj7_address_unit_desig;
    SELF.Diff_orig_subj7_address_sec_range := le.orig_subj7_address_sec_range <> ri.orig_subj7_address_sec_range;
    SELF.Diff_orig_subj7_address_city := le.orig_subj7_address_city <> ri.orig_subj7_address_city;
    SELF.Diff_orig_subj7_address_st := le.orig_subj7_address_st <> ri.orig_subj7_address_st;
    SELF.Diff_orig_subj7_address_z5 := le.orig_subj7_address_z5 <> ri.orig_subj7_address_z5;
    SELF.Diff_orig_subj7_address_z4 := le.orig_subj7_address_z4 <> ri.orig_subj7_address_z4;
    SELF.Diff_orig_subj7_phone := le.orig_subj7_phone <> ri.orig_subj7_phone;
    SELF.Diff_orig_subj7_work_phone := le.orig_subj7_work_phone <> ri.orig_subj7_work_phone;
    SELF.Diff_orig_subj7_business_title := le.orig_subj7_business_title <> ri.orig_subj7_business_title;
    SELF.Diff_orig_subj7_email := le.orig_subj7_email <> ri.orig_subj7_email;
    SELF.Diff_orig_subj7_company_name := le.orig_subj7_company_name <> ri.orig_subj7_company_name;
    SELF.Diff_orig_subj7_fein := le.orig_subj7_fein <> ri.orig_subj7_fein;
    SELF.Diff_orig_subj8_first_name := le.orig_subj8_first_name <> ri.orig_subj8_first_name;
    SELF.Diff_orig_subj8_middle_name := le.orig_subj8_middle_name <> ri.orig_subj8_middle_name;
    SELF.Diff_orig_subj8_last_name := le.orig_subj8_last_name <> ri.orig_subj8_last_name;
    SELF.Diff_orig_subj8_suffix_name := le.orig_subj8_suffix_name <> ri.orig_subj8_suffix_name;
    SELF.Diff_orig_subj8_full_name := le.orig_subj8_full_name <> ri.orig_subj8_full_name;
    SELF.Diff_orig_subj8_ssn := le.orig_subj8_ssn <> ri.orig_subj8_ssn;
    SELF.Diff_orig_subj8_dob := le.orig_subj8_dob <> ri.orig_subj8_dob;
    SELF.Diff_orig_subj8_dl_num := le.orig_subj8_dl_num <> ri.orig_subj8_dl_num;
    SELF.Diff_orig_subj8_dl_state := le.orig_subj8_dl_state <> ri.orig_subj8_dl_state;
    SELF.Diff_orig_subj8_former_last_name := le.orig_subj8_former_last_name <> ri.orig_subj8_former_last_name;
    SELF.Diff_orig_subj8_address_addressline1 := le.orig_subj8_address_addressline1 <> ri.orig_subj8_address_addressline1;
    SELF.Diff_orig_subj8_address_addressline2 := le.orig_subj8_address_addressline2 <> ri.orig_subj8_address_addressline2;
    SELF.Diff_orig_subj8_address_prim_range := le.orig_subj8_address_prim_range <> ri.orig_subj8_address_prim_range;
    SELF.Diff_orig_subj8_address_predir := le.orig_subj8_address_predir <> ri.orig_subj8_address_predir;
    SELF.Diff_orig_subj8_address_prim_name := le.orig_subj8_address_prim_name <> ri.orig_subj8_address_prim_name;
    SELF.Diff_orig_subj8_address_suffix := le.orig_subj8_address_suffix <> ri.orig_subj8_address_suffix;
    SELF.Diff_orig_subj8_address_postdir := le.orig_subj8_address_postdir <> ri.orig_subj8_address_postdir;
    SELF.Diff_orig_subj8_address_unit_desig := le.orig_subj8_address_unit_desig <> ri.orig_subj8_address_unit_desig;
    SELF.Diff_orig_subj8_address_sec_range := le.orig_subj8_address_sec_range <> ri.orig_subj8_address_sec_range;
    SELF.Diff_orig_subj8_address_city := le.orig_subj8_address_city <> ri.orig_subj8_address_city;
    SELF.Diff_orig_subj8_address_st := le.orig_subj8_address_st <> ri.orig_subj8_address_st;
    SELF.Diff_orig_subj8_address_z5 := le.orig_subj8_address_z5 <> ri.orig_subj8_address_z5;
    SELF.Diff_orig_subj8_address_z4 := le.orig_subj8_address_z4 <> ri.orig_subj8_address_z4;
    SELF.Diff_orig_subj8_phone := le.orig_subj8_phone <> ri.orig_subj8_phone;
    SELF.Diff_orig_subj8_work_phone := le.orig_subj8_work_phone <> ri.orig_subj8_work_phone;
    SELF.Diff_orig_subj8_business_title := le.orig_subj8_business_title <> ri.orig_subj8_business_title;
    SELF.Diff_orig_subj8_email := le.orig_subj8_email <> ri.orig_subj8_email;
    SELF.Diff_orig_subj8_company_name := le.orig_subj8_company_name <> ri.orig_subj8_company_name;
    SELF.Diff_orig_subj8_fein := le.orig_subj8_fein <> ri.orig_subj8_fein;
    SELF.Diff_orig_company_alternate_name := le.orig_company_alternate_name <> ri.orig_company_alternate_name;
    SELF.Val := (SALT39.StrType)evaluate(le,pivot_exp);
    SELF.Num_Diffs := 0+ IF( SELF.Diff_orig_datetime_stamp,1,0)+ IF( SELF.Diff_orig_global_company_id,1,0)+ IF( SELF.Diff_orig_company_id,1,0)+ IF( SELF.Diff_orig_product_cd,1,0)+ IF( SELF.Diff_orig_method,1,0)+ IF( SELF.Diff_orig_vertical,1,0)+ IF( SELF.Diff_orig_function_name,1,0)+ IF( SELF.Diff_orig_transaction_type,1,0)+ IF( SELF.Diff_orig_login_history_id,1,0)+ IF( SELF.Diff_orig_job_id,1,0)+ IF( SELF.Diff_orig_sequence_number,1,0)+ IF( SELF.Diff_orig_first_name,1,0)+ IF( SELF.Diff_orig_middle_name,1,0)+ IF( SELF.Diff_orig_last_name,1,0)+ IF( SELF.Diff_orig_ssn,1,0)+ IF( SELF.Diff_orig_dob,1,0)+ IF( SELF.Diff_orig_dl_num,1,0)+ IF( SELF.Diff_orig_dl_state,1,0)+ IF( SELF.Diff_orig_address1_addressline1,1,0)+ IF( SELF.Diff_orig_address1_addressline2,1,0)+ IF( SELF.Diff_orig_address1_prim_range,1,0)+ IF( SELF.Diff_orig_address1_predir,1,0)+ IF( SELF.Diff_orig_address1_prim_name,1,0)+ IF( SELF.Diff_orig_address1_suffix,1,0)+ IF( SELF.Diff_orig_address1_postdir,1,0)+ IF( SELF.Diff_orig_address1_unit_desig,1,0)+ IF( SELF.Diff_orig_address1_sec_range,1,0)+ IF( SELF.Diff_orig_address1_city,1,0)+ IF( SELF.Diff_orig_address1_st,1,0)+ IF( SELF.Diff_orig_address1_z5,1,0)+ IF( SELF.Diff_orig_address1_z4,1,0)+ IF( SELF.Diff_orig_address2_addressline1,1,0)+ IF( SELF.Diff_orig_address2_addressline2,1,0)+ IF( SELF.Diff_orig_address2_prim_range,1,0)+ IF( SELF.Diff_orig_address2_predir,1,0)+ IF( SELF.Diff_orig_address2_prim_name,1,0)+ IF( SELF.Diff_orig_address2_suffix,1,0)+ IF( SELF.Diff_orig_address2_postdir,1,0)+ IF( SELF.Diff_orig_address2_unit_desig,1,0)+ IF( SELF.Diff_orig_address2_sec_range,1,0)+ IF( SELF.Diff_orig_address2_city,1,0)+ IF( SELF.Diff_orig_address2_st,1,0)+ IF( SELF.Diff_orig_address2_z5,1,0)+ IF( SELF.Diff_orig_address2_z4,1,0)+ IF( SELF.Diff_orig_bdid,1,0)+ IF( SELF.Diff_orig_bdl,1,0)+ IF( SELF.Diff_orig_did,1,0)+ IF( SELF.Diff_orig_company_name,1,0)+ IF( SELF.Diff_orig_fein,1,0)+ IF( SELF.Diff_orig_phone,1,0)+ IF( SELF.Diff_orig_work_phone,1,0)+ IF( SELF.Diff_orig_company_phone,1,0)+ IF( SELF.Diff_orig_reference_code,1,0)+ IF( SELF.Diff_orig_ip_address_initiated,1,0)+ IF( SELF.Diff_orig_ip_address_executed,1,0)+ IF( SELF.Diff_orig_charter_number,1,0)+ IF( SELF.Diff_orig_ucc_original_filing_number,1,0)+ IF( SELF.Diff_orig_email_address,1,0)+ IF( SELF.Diff_orig_domain_name,1,0)+ IF( SELF.Diff_orig_full_name,1,0)+ IF( SELF.Diff_orig_dl_purpose,1,0)+ IF( SELF.Diff_orig_glb_purpose,1,0)+ IF( SELF.Diff_orig_fcra_purpose,1,0)+ IF( SELF.Diff_orig_process_id,1,0)+ IF( SELF.Diff_orig_suffix_name,1,0)+ IF( SELF.Diff_orig_former_last_name,1,0)+ IF( SELF.Diff_orig_business_title,1,0)+ IF( SELF.Diff_orig_company_addressline1,1,0)+ IF( SELF.Diff_orig_company_addressline2,1,0)+ IF( SELF.Diff_orig_company_address_prim_range,1,0)+ IF( SELF.Diff_orig_company_address_predir,1,0)+ IF( SELF.Diff_orig_company_address_prim_name,1,0)+ IF( SELF.Diff_orig_company_address_suffix,1,0)+ IF( SELF.Diff_orig_company_address_postdir,1,0)+ IF( SELF.Diff_orig_company_address_unit_desig,1,0)+ IF( SELF.Diff_orig_company_address_sec_range,1,0)+ IF( SELF.Diff_orig_company_address_city,1,0)+ IF( SELF.Diff_orig_company_address_st,1,0)+ IF( SELF.Diff_orig_company_address_zip5,1,0)+ IF( SELF.Diff_orig_company_address_zip4,1,0)+ IF( SELF.Diff_orig_company_fax_number,1,0)+ IF( SELF.Diff_orig_company_start_date,1,0)+ IF( SELF.Diff_orig_company_years_in_business,1,0)+ IF( SELF.Diff_orig_company_sic_code,1,0)+ IF( SELF.Diff_orig_company_naic_code,1,0)+ IF( SELF.Diff_orig_company_structure,1,0)+ IF( SELF.Diff_orig_company_yearly_revenue,1,0)+ IF( SELF.Diff_orig_subj2_first_name,1,0)+ IF( SELF.Diff_orig_subj2_middle_name,1,0)+ IF( SELF.Diff_orig_subj2_last_name,1,0)+ IF( SELF.Diff_orig_subj2_suffix_name,1,0)+ IF( SELF.Diff_orig_subj2_full_name,1,0)+ IF( SELF.Diff_orig_subj2_ssn,1,0)+ IF( SELF.Diff_orig_subj2_dob,1,0)+ IF( SELF.Diff_orig_subj2_dl_num,1,0)+ IF( SELF.Diff_orig_subj2_dl_state,1,0)+ IF( SELF.Diff_orig_subj2_former_last_name,1,0)+ IF( SELF.Diff_orig_subj2_address_addressline1,1,0)+ IF( SELF.Diff_orig_subj2_address_addressline2,1,0)+ IF( SELF.Diff_orig_subj2_address_prim_range,1,0)+ IF( SELF.Diff_orig_subj2_address_predir,1,0)+ IF( SELF.Diff_orig_subj2_address_prim_name,1,0)+ IF( SELF.Diff_orig_subj2_address_suffix,1,0)+ IF( SELF.Diff_orig_subj2_address_postdir,1,0)+ IF( SELF.Diff_orig_subj2_address_unit_desig,1,0)+ IF( SELF.Diff_orig_subj2_address_sec_range,1,0)+ IF( SELF.Diff_orig_subj2_address_city,1,0)+ IF( SELF.Diff_orig_subj2_address_st,1,0)+ IF( SELF.Diff_orig_subj2_address_z5,1,0)+ IF( SELF.Diff_orig_subj2_address_z4,1,0)+ IF( SELF.Diff_orig_subj2_phone,1,0)+ IF( SELF.Diff_orig_subj2_work_phone,1,0)+ IF( SELF.Diff_orig_subj2_business_title,1,0)+ IF( SELF.Diff_orig_subj3_first_name,1,0)+ IF( SELF.Diff_orig_subj3_middle_name,1,0)+ IF( SELF.Diff_orig_subj3_last_name,1,0)+ IF( SELF.Diff_orig_subj3_suffix_name,1,0)+ IF( SELF.Diff_orig_subj3_full_name,1,0)+ IF( SELF.Diff_orig_subj3_ssn,1,0)+ IF( SELF.Diff_orig_subj3_dob,1,0)+ IF( SELF.Diff_orig_subj3_dl_num,1,0)+ IF( SELF.Diff_orig_subj3_dl_state,1,0)+ IF( SELF.Diff_orig_subj3_former_last_name,1,0)+ IF( SELF.Diff_orig_subj3_address_addressline1,1,0)+ IF( SELF.Diff_orig_subj3_address_addressline2,1,0)+ IF( SELF.Diff_orig_subj3_address_prim_range,1,0)+ IF( SELF.Diff_orig_subj3_address_predir,1,0)+ IF( SELF.Diff_orig_subj3_address_prim_name,1,0)+ IF( SELF.Diff_orig_subj3_address_suffix,1,0)+ IF( SELF.Diff_orig_subj3_address_postdir,1,0)+ IF( SELF.Diff_orig_subj3_address_unit_desig,1,0)+ IF( SELF.Diff_orig_subj3_address_sec_range,1,0)+ IF( SELF.Diff_orig_subj3_address_city,1,0)+ IF( SELF.Diff_orig_subj3_address_st,1,0)+ IF( SELF.Diff_orig_subj3_address_z5,1,0)+ IF( SELF.Diff_orig_subj3_address_z4,1,0)+ IF( SELF.Diff_orig_subj3_phone,1,0)+ IF( SELF.Diff_orig_subj3_work_phone,1,0)+ IF( SELF.Diff_orig_subj3_business_title,1,0)+ IF( SELF.Diff_orig_email,1,0)+ IF( SELF.Diff_orig_subj2_email,1,0)+ IF( SELF.Diff_orig_subj2_company_name,1,0)+ IF( SELF.Diff_orig_subj2_fein,1,0)+ IF( SELF.Diff_orig_subj3_email,1,0)+ IF( SELF.Diff_orig_subj3_company_name,1,0)+ IF( SELF.Diff_orig_subj3_fein,1,0)+ IF( SELF.Diff_orig_subj4_first_name,1,0)+ IF( SELF.Diff_orig_subj4_middle_name,1,0)+ IF( SELF.Diff_orig_subj4_last_name,1,0)+ IF( SELF.Diff_orig_subj4_suffix_name,1,0)+ IF( SELF.Diff_orig_subj4_full_name,1,0)+ IF( SELF.Diff_orig_subj4_ssn,1,0)+ IF( SELF.Diff_orig_subj4_dob,1,0)+ IF( SELF.Diff_orig_subj4_dl_num,1,0)+ IF( SELF.Diff_orig_subj4_dl_state,1,0)+ IF( SELF.Diff_orig_subj4_former_last_name,1,0)+ IF( SELF.Diff_orig_subj4_address_addressline1,1,0)+ IF( SELF.Diff_orig_subj4_address_addressline2,1,0)+ IF( SELF.Diff_orig_subj4_address_prim_range,1,0)+ IF( SELF.Diff_orig_subj4_address_predir,1,0)+ IF( SELF.Diff_orig_subj4_address_prim_name,1,0)+ IF( SELF.Diff_orig_subj4_address_suffix,1,0)+ IF( SELF.Diff_orig_subj4_address_postdir,1,0)+ IF( SELF.Diff_orig_subj4_address_unit_desig,1,0)+ IF( SELF.Diff_orig_subj4_address_sec_range,1,0)+ IF( SELF.Diff_orig_subj4_address_city,1,0)+ IF( SELF.Diff_orig_subj4_address_st,1,0)+ IF( SELF.Diff_orig_subj4_address_z5,1,0)+ IF( SELF.Diff_orig_subj4_address_z4,1,0)+ IF( SELF.Diff_orig_subj4_phone,1,0)+ IF( SELF.Diff_orig_subj4_work_phone,1,0)+ IF( SELF.Diff_orig_subj4_business_title,1,0)+ IF( SELF.Diff_orig_subj4_email,1,0)+ IF( SELF.Diff_orig_subj4_company_name,1,0)+ IF( SELF.Diff_orig_subj4_fein,1,0)+ IF( SELF.Diff_orig_subj5_first_name,1,0)+ IF( SELF.Diff_orig_subj5_middle_name,1,0)+ IF( SELF.Diff_orig_subj5_last_name,1,0)+ IF( SELF.Diff_orig_subj5_suffix_name,1,0)+ IF( SELF.Diff_orig_subj5_full_name,1,0)+ IF( SELF.Diff_orig_subj5_ssn,1,0)+ IF( SELF.Diff_orig_subj5_dob,1,0)+ IF( SELF.Diff_orig_subj5_dl_num,1,0)+ IF( SELF.Diff_orig_subj5_dl_state,1,0)+ IF( SELF.Diff_orig_subj5_former_last_name,1,0)+ IF( SELF.Diff_orig_subj5_address_addressline1,1,0)+ IF( SELF.Diff_orig_subj5_address_addressline2,1,0)+ IF( SELF.Diff_orig_subj5_address_prim_range,1,0)+ IF( SELF.Diff_orig_subj5_address_predir,1,0)+ IF( SELF.Diff_orig_subj5_address_prim_name,1,0)+ IF( SELF.Diff_orig_subj5_address_suffix,1,0)+ IF( SELF.Diff_orig_subj5_address_postdir,1,0)+ IF( SELF.Diff_orig_subj5_address_unit_desig,1,0)+ IF( SELF.Diff_orig_subj5_address_sec_range,1,0)+ IF( SELF.Diff_orig_subj5_address_city,1,0)+ IF( SELF.Diff_orig_subj5_address_st,1,0)+ IF( SELF.Diff_orig_subj5_address_z5,1,0)+ IF( SELF.Diff_orig_subj5_address_z4,1,0)+ IF( SELF.Diff_orig_subj5_phone,1,0)+ IF( SELF.Diff_orig_subj5_work_phone,1,0)+ IF( SELF.Diff_orig_subj5_business_title,1,0)+ IF( SELF.Diff_orig_subj5_email,1,0)+ IF( SELF.Diff_orig_subj5_company_name,1,0)+ IF( SELF.Diff_orig_subj5_fein,1,0)+ IF( SELF.Diff_orig_subj6_first_name,1,0)+ IF( SELF.Diff_orig_subj6_middle_name,1,0)+ IF( SELF.Diff_orig_subj6_last_name,1,0)+ IF( SELF.Diff_orig_subj6_suffix_name,1,0)+ IF( SELF.Diff_orig_subj6_full_name,1,0)+ IF( SELF.Diff_orig_subj6_ssn,1,0)+ IF( SELF.Diff_orig_subj6_dob,1,0)+ IF( SELF.Diff_orig_subj6_dl_num,1,0)+ IF( SELF.Diff_orig_subj6_dl_state,1,0)+ IF( SELF.Diff_orig_subj6_former_last_name,1,0)+ IF( SELF.Diff_orig_subj6_address_addressline1,1,0)+ IF( SELF.Diff_orig_subj6_address_addressline2,1,0)+ IF( SELF.Diff_orig_subj6_address_prim_range,1,0)+ IF( SELF.Diff_orig_subj6_address_predir,1,0)+ IF( SELF.Diff_orig_subj6_address_prim_name,1,0)+ IF( SELF.Diff_orig_subj6_address_suffix,1,0)+ IF( SELF.Diff_orig_subj6_address_postdir,1,0)+ IF( SELF.Diff_orig_subj6_address_unit_desig,1,0)+ IF( SELF.Diff_orig_subj6_address_sec_range,1,0)+ IF( SELF.Diff_orig_subj6_address_city,1,0)+ IF( SELF.Diff_orig_subj6_address_st,1,0)+ IF( SELF.Diff_orig_subj6_address_z5,1,0)+ IF( SELF.Diff_orig_subj6_address_z4,1,0)+ IF( SELF.Diff_orig_subj6_phone,1,0)+ IF( SELF.Diff_orig_subj6_work_phone,1,0)+ IF( SELF.Diff_orig_subj6_business_title,1,0)+ IF( SELF.Diff_orig_subj6_email,1,0)+ IF( SELF.Diff_orig_subj6_company_name,1,0)+ IF( SELF.Diff_orig_subj6_fein,1,0)+ IF( SELF.Diff_orig_subj7_first_name,1,0)+ IF( SELF.Diff_orig_subj7_middle_name,1,0)+ IF( SELF.Diff_orig_subj7_last_name,1,0)+ IF( SELF.Diff_orig_subj7_suffix_name,1,0)+ IF( SELF.Diff_orig_subj7_full_name,1,0)+ IF( SELF.Diff_orig_subj7_ssn,1,0)+ IF( SELF.Diff_orig_subj7_dob,1,0)+ IF( SELF.Diff_orig_subj7_dl_num,1,0)+ IF( SELF.Diff_orig_subj7_dl_state,1,0)+ IF( SELF.Diff_orig_subj7_former_last_name,1,0)+ IF( SELF.Diff_orig_subj7_address_addressline1,1,0)+ IF( SELF.Diff_orig_subj7_address_addressline2,1,0)+ IF( SELF.Diff_orig_subj7_address_prim_range,1,0)+ IF( SELF.Diff_orig_subj7_address_predir,1,0)+ IF( SELF.Diff_orig_subj7_address_prim_name,1,0)+ IF( SELF.Diff_orig_subj7_address_suffix,1,0)+ IF( SELF.Diff_orig_subj7_address_postdir,1,0)+ IF( SELF.Diff_orig_subj7_address_unit_desig,1,0)+ IF( SELF.Diff_orig_subj7_address_sec_range,1,0)+ IF( SELF.Diff_orig_subj7_address_city,1,0)+ IF( SELF.Diff_orig_subj7_address_st,1,0)+ IF( SELF.Diff_orig_subj7_address_z5,1,0)+ IF( SELF.Diff_orig_subj7_address_z4,1,0)+ IF( SELF.Diff_orig_subj7_phone,1,0)+ IF( SELF.Diff_orig_subj7_work_phone,1,0)+ IF( SELF.Diff_orig_subj7_business_title,1,0)+ IF( SELF.Diff_orig_subj7_email,1,0)+ IF( SELF.Diff_orig_subj7_company_name,1,0)+ IF( SELF.Diff_orig_subj7_fein,1,0)+ IF( SELF.Diff_orig_subj8_first_name,1,0)+ IF( SELF.Diff_orig_subj8_middle_name,1,0)+ IF( SELF.Diff_orig_subj8_last_name,1,0)+ IF( SELF.Diff_orig_subj8_suffix_name,1,0)+ IF( SELF.Diff_orig_subj8_full_name,1,0)+ IF( SELF.Diff_orig_subj8_ssn,1,0)+ IF( SELF.Diff_orig_subj8_dob,1,0)+ IF( SELF.Diff_orig_subj8_dl_num,1,0)+ IF( SELF.Diff_orig_subj8_dl_state,1,0)+ IF( SELF.Diff_orig_subj8_former_last_name,1,0)+ IF( SELF.Diff_orig_subj8_address_addressline1,1,0)+ IF( SELF.Diff_orig_subj8_address_addressline2,1,0)+ IF( SELF.Diff_orig_subj8_address_prim_range,1,0)+ IF( SELF.Diff_orig_subj8_address_predir,1,0)+ IF( SELF.Diff_orig_subj8_address_prim_name,1,0)+ IF( SELF.Diff_orig_subj8_address_suffix,1,0)+ IF( SELF.Diff_orig_subj8_address_postdir,1,0)+ IF( SELF.Diff_orig_subj8_address_unit_desig,1,0)+ IF( SELF.Diff_orig_subj8_address_sec_range,1,0)+ IF( SELF.Diff_orig_subj8_address_city,1,0)+ IF( SELF.Diff_orig_subj8_address_st,1,0)+ IF( SELF.Diff_orig_subj8_address_z5,1,0)+ IF( SELF.Diff_orig_subj8_address_z4,1,0)+ IF( SELF.Diff_orig_subj8_phone,1,0)+ IF( SELF.Diff_orig_subj8_work_phone,1,0)+ IF( SELF.Diff_orig_subj8_business_title,1,0)+ IF( SELF.Diff_orig_subj8_email,1,0)+ IF( SELF.Diff_orig_subj8_company_name,1,0)+ IF( SELF.Diff_orig_subj8_fein,1,0)+ IF( SELF.Diff_orig_company_alternate_name,1,0);
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
    Count_Diff_orig_datetime_stamp := COUNT(GROUP,%Closest%.Diff_orig_datetime_stamp);
    Count_Diff_orig_global_company_id := COUNT(GROUP,%Closest%.Diff_orig_global_company_id);
    Count_Diff_orig_company_id := COUNT(GROUP,%Closest%.Diff_orig_company_id);
    Count_Diff_orig_product_cd := COUNT(GROUP,%Closest%.Diff_orig_product_cd);
    Count_Diff_orig_method := COUNT(GROUP,%Closest%.Diff_orig_method);
    Count_Diff_orig_vertical := COUNT(GROUP,%Closest%.Diff_orig_vertical);
    Count_Diff_orig_function_name := COUNT(GROUP,%Closest%.Diff_orig_function_name);
    Count_Diff_orig_transaction_type := COUNT(GROUP,%Closest%.Diff_orig_transaction_type);
    Count_Diff_orig_login_history_id := COUNT(GROUP,%Closest%.Diff_orig_login_history_id);
    Count_Diff_orig_job_id := COUNT(GROUP,%Closest%.Diff_orig_job_id);
    Count_Diff_orig_sequence_number := COUNT(GROUP,%Closest%.Diff_orig_sequence_number);
    Count_Diff_orig_first_name := COUNT(GROUP,%Closest%.Diff_orig_first_name);
    Count_Diff_orig_middle_name := COUNT(GROUP,%Closest%.Diff_orig_middle_name);
    Count_Diff_orig_last_name := COUNT(GROUP,%Closest%.Diff_orig_last_name);
    Count_Diff_orig_ssn := COUNT(GROUP,%Closest%.Diff_orig_ssn);
    Count_Diff_orig_dob := COUNT(GROUP,%Closest%.Diff_orig_dob);
    Count_Diff_orig_dl_num := COUNT(GROUP,%Closest%.Diff_orig_dl_num);
    Count_Diff_orig_dl_state := COUNT(GROUP,%Closest%.Diff_orig_dl_state);
    Count_Diff_orig_address1_addressline1 := COUNT(GROUP,%Closest%.Diff_orig_address1_addressline1);
    Count_Diff_orig_address1_addressline2 := COUNT(GROUP,%Closest%.Diff_orig_address1_addressline2);
    Count_Diff_orig_address1_prim_range := COUNT(GROUP,%Closest%.Diff_orig_address1_prim_range);
    Count_Diff_orig_address1_predir := COUNT(GROUP,%Closest%.Diff_orig_address1_predir);
    Count_Diff_orig_address1_prim_name := COUNT(GROUP,%Closest%.Diff_orig_address1_prim_name);
    Count_Diff_orig_address1_suffix := COUNT(GROUP,%Closest%.Diff_orig_address1_suffix);
    Count_Diff_orig_address1_postdir := COUNT(GROUP,%Closest%.Diff_orig_address1_postdir);
    Count_Diff_orig_address1_unit_desig := COUNT(GROUP,%Closest%.Diff_orig_address1_unit_desig);
    Count_Diff_orig_address1_sec_range := COUNT(GROUP,%Closest%.Diff_orig_address1_sec_range);
    Count_Diff_orig_address1_city := COUNT(GROUP,%Closest%.Diff_orig_address1_city);
    Count_Diff_orig_address1_st := COUNT(GROUP,%Closest%.Diff_orig_address1_st);
    Count_Diff_orig_address1_z5 := COUNT(GROUP,%Closest%.Diff_orig_address1_z5);
    Count_Diff_orig_address1_z4 := COUNT(GROUP,%Closest%.Diff_orig_address1_z4);
    Count_Diff_orig_address2_addressline1 := COUNT(GROUP,%Closest%.Diff_orig_address2_addressline1);
    Count_Diff_orig_address2_addressline2 := COUNT(GROUP,%Closest%.Diff_orig_address2_addressline2);
    Count_Diff_orig_address2_prim_range := COUNT(GROUP,%Closest%.Diff_orig_address2_prim_range);
    Count_Diff_orig_address2_predir := COUNT(GROUP,%Closest%.Diff_orig_address2_predir);
    Count_Diff_orig_address2_prim_name := COUNT(GROUP,%Closest%.Diff_orig_address2_prim_name);
    Count_Diff_orig_address2_suffix := COUNT(GROUP,%Closest%.Diff_orig_address2_suffix);
    Count_Diff_orig_address2_postdir := COUNT(GROUP,%Closest%.Diff_orig_address2_postdir);
    Count_Diff_orig_address2_unit_desig := COUNT(GROUP,%Closest%.Diff_orig_address2_unit_desig);
    Count_Diff_orig_address2_sec_range := COUNT(GROUP,%Closest%.Diff_orig_address2_sec_range);
    Count_Diff_orig_address2_city := COUNT(GROUP,%Closest%.Diff_orig_address2_city);
    Count_Diff_orig_address2_st := COUNT(GROUP,%Closest%.Diff_orig_address2_st);
    Count_Diff_orig_address2_z5 := COUNT(GROUP,%Closest%.Diff_orig_address2_z5);
    Count_Diff_orig_address2_z4 := COUNT(GROUP,%Closest%.Diff_orig_address2_z4);
    Count_Diff_orig_bdid := COUNT(GROUP,%Closest%.Diff_orig_bdid);
    Count_Diff_orig_bdl := COUNT(GROUP,%Closest%.Diff_orig_bdl);
    Count_Diff_orig_did := COUNT(GROUP,%Closest%.Diff_orig_did);
    Count_Diff_orig_company_name := COUNT(GROUP,%Closest%.Diff_orig_company_name);
    Count_Diff_orig_fein := COUNT(GROUP,%Closest%.Diff_orig_fein);
    Count_Diff_orig_phone := COUNT(GROUP,%Closest%.Diff_orig_phone);
    Count_Diff_orig_work_phone := COUNT(GROUP,%Closest%.Diff_orig_work_phone);
    Count_Diff_orig_company_phone := COUNT(GROUP,%Closest%.Diff_orig_company_phone);
    Count_Diff_orig_reference_code := COUNT(GROUP,%Closest%.Diff_orig_reference_code);
    Count_Diff_orig_ip_address_initiated := COUNT(GROUP,%Closest%.Diff_orig_ip_address_initiated);
    Count_Diff_orig_ip_address_executed := COUNT(GROUP,%Closest%.Diff_orig_ip_address_executed);
    Count_Diff_orig_charter_number := COUNT(GROUP,%Closest%.Diff_orig_charter_number);
    Count_Diff_orig_ucc_original_filing_number := COUNT(GROUP,%Closest%.Diff_orig_ucc_original_filing_number);
    Count_Diff_orig_email_address := COUNT(GROUP,%Closest%.Diff_orig_email_address);
    Count_Diff_orig_domain_name := COUNT(GROUP,%Closest%.Diff_orig_domain_name);
    Count_Diff_orig_full_name := COUNT(GROUP,%Closest%.Diff_orig_full_name);
    Count_Diff_orig_dl_purpose := COUNT(GROUP,%Closest%.Diff_orig_dl_purpose);
    Count_Diff_orig_glb_purpose := COUNT(GROUP,%Closest%.Diff_orig_glb_purpose);
    Count_Diff_orig_fcra_purpose := COUNT(GROUP,%Closest%.Diff_orig_fcra_purpose);
    Count_Diff_orig_process_id := COUNT(GROUP,%Closest%.Diff_orig_process_id);
    Count_Diff_orig_suffix_name := COUNT(GROUP,%Closest%.Diff_orig_suffix_name);
    Count_Diff_orig_former_last_name := COUNT(GROUP,%Closest%.Diff_orig_former_last_name);
    Count_Diff_orig_business_title := COUNT(GROUP,%Closest%.Diff_orig_business_title);
    Count_Diff_orig_company_addressline1 := COUNT(GROUP,%Closest%.Diff_orig_company_addressline1);
    Count_Diff_orig_company_addressline2 := COUNT(GROUP,%Closest%.Diff_orig_company_addressline2);
    Count_Diff_orig_company_address_prim_range := COUNT(GROUP,%Closest%.Diff_orig_company_address_prim_range);
    Count_Diff_orig_company_address_predir := COUNT(GROUP,%Closest%.Diff_orig_company_address_predir);
    Count_Diff_orig_company_address_prim_name := COUNT(GROUP,%Closest%.Diff_orig_company_address_prim_name);
    Count_Diff_orig_company_address_suffix := COUNT(GROUP,%Closest%.Diff_orig_company_address_suffix);
    Count_Diff_orig_company_address_postdir := COUNT(GROUP,%Closest%.Diff_orig_company_address_postdir);
    Count_Diff_orig_company_address_unit_desig := COUNT(GROUP,%Closest%.Diff_orig_company_address_unit_desig);
    Count_Diff_orig_company_address_sec_range := COUNT(GROUP,%Closest%.Diff_orig_company_address_sec_range);
    Count_Diff_orig_company_address_city := COUNT(GROUP,%Closest%.Diff_orig_company_address_city);
    Count_Diff_orig_company_address_st := COUNT(GROUP,%Closest%.Diff_orig_company_address_st);
    Count_Diff_orig_company_address_zip5 := COUNT(GROUP,%Closest%.Diff_orig_company_address_zip5);
    Count_Diff_orig_company_address_zip4 := COUNT(GROUP,%Closest%.Diff_orig_company_address_zip4);
    Count_Diff_orig_company_fax_number := COUNT(GROUP,%Closest%.Diff_orig_company_fax_number);
    Count_Diff_orig_company_start_date := COUNT(GROUP,%Closest%.Diff_orig_company_start_date);
    Count_Diff_orig_company_years_in_business := COUNT(GROUP,%Closest%.Diff_orig_company_years_in_business);
    Count_Diff_orig_company_sic_code := COUNT(GROUP,%Closest%.Diff_orig_company_sic_code);
    Count_Diff_orig_company_naic_code := COUNT(GROUP,%Closest%.Diff_orig_company_naic_code);
    Count_Diff_orig_company_structure := COUNT(GROUP,%Closest%.Diff_orig_company_structure);
    Count_Diff_orig_company_yearly_revenue := COUNT(GROUP,%Closest%.Diff_orig_company_yearly_revenue);
    Count_Diff_orig_subj2_first_name := COUNT(GROUP,%Closest%.Diff_orig_subj2_first_name);
    Count_Diff_orig_subj2_middle_name := COUNT(GROUP,%Closest%.Diff_orig_subj2_middle_name);
    Count_Diff_orig_subj2_last_name := COUNT(GROUP,%Closest%.Diff_orig_subj2_last_name);
    Count_Diff_orig_subj2_suffix_name := COUNT(GROUP,%Closest%.Diff_orig_subj2_suffix_name);
    Count_Diff_orig_subj2_full_name := COUNT(GROUP,%Closest%.Diff_orig_subj2_full_name);
    Count_Diff_orig_subj2_ssn := COUNT(GROUP,%Closest%.Diff_orig_subj2_ssn);
    Count_Diff_orig_subj2_dob := COUNT(GROUP,%Closest%.Diff_orig_subj2_dob);
    Count_Diff_orig_subj2_dl_num := COUNT(GROUP,%Closest%.Diff_orig_subj2_dl_num);
    Count_Diff_orig_subj2_dl_state := COUNT(GROUP,%Closest%.Diff_orig_subj2_dl_state);
    Count_Diff_orig_subj2_former_last_name := COUNT(GROUP,%Closest%.Diff_orig_subj2_former_last_name);
    Count_Diff_orig_subj2_address_addressline1 := COUNT(GROUP,%Closest%.Diff_orig_subj2_address_addressline1);
    Count_Diff_orig_subj2_address_addressline2 := COUNT(GROUP,%Closest%.Diff_orig_subj2_address_addressline2);
    Count_Diff_orig_subj2_address_prim_range := COUNT(GROUP,%Closest%.Diff_orig_subj2_address_prim_range);
    Count_Diff_orig_subj2_address_predir := COUNT(GROUP,%Closest%.Diff_orig_subj2_address_predir);
    Count_Diff_orig_subj2_address_prim_name := COUNT(GROUP,%Closest%.Diff_orig_subj2_address_prim_name);
    Count_Diff_orig_subj2_address_suffix := COUNT(GROUP,%Closest%.Diff_orig_subj2_address_suffix);
    Count_Diff_orig_subj2_address_postdir := COUNT(GROUP,%Closest%.Diff_orig_subj2_address_postdir);
    Count_Diff_orig_subj2_address_unit_desig := COUNT(GROUP,%Closest%.Diff_orig_subj2_address_unit_desig);
    Count_Diff_orig_subj2_address_sec_range := COUNT(GROUP,%Closest%.Diff_orig_subj2_address_sec_range);
    Count_Diff_orig_subj2_address_city := COUNT(GROUP,%Closest%.Diff_orig_subj2_address_city);
    Count_Diff_orig_subj2_address_st := COUNT(GROUP,%Closest%.Diff_orig_subj2_address_st);
    Count_Diff_orig_subj2_address_z5 := COUNT(GROUP,%Closest%.Diff_orig_subj2_address_z5);
    Count_Diff_orig_subj2_address_z4 := COUNT(GROUP,%Closest%.Diff_orig_subj2_address_z4);
    Count_Diff_orig_subj2_phone := COUNT(GROUP,%Closest%.Diff_orig_subj2_phone);
    Count_Diff_orig_subj2_work_phone := COUNT(GROUP,%Closest%.Diff_orig_subj2_work_phone);
    Count_Diff_orig_subj2_business_title := COUNT(GROUP,%Closest%.Diff_orig_subj2_business_title);
    Count_Diff_orig_subj3_first_name := COUNT(GROUP,%Closest%.Diff_orig_subj3_first_name);
    Count_Diff_orig_subj3_middle_name := COUNT(GROUP,%Closest%.Diff_orig_subj3_middle_name);
    Count_Diff_orig_subj3_last_name := COUNT(GROUP,%Closest%.Diff_orig_subj3_last_name);
    Count_Diff_orig_subj3_suffix_name := COUNT(GROUP,%Closest%.Diff_orig_subj3_suffix_name);
    Count_Diff_orig_subj3_full_name := COUNT(GROUP,%Closest%.Diff_orig_subj3_full_name);
    Count_Diff_orig_subj3_ssn := COUNT(GROUP,%Closest%.Diff_orig_subj3_ssn);
    Count_Diff_orig_subj3_dob := COUNT(GROUP,%Closest%.Diff_orig_subj3_dob);
    Count_Diff_orig_subj3_dl_num := COUNT(GROUP,%Closest%.Diff_orig_subj3_dl_num);
    Count_Diff_orig_subj3_dl_state := COUNT(GROUP,%Closest%.Diff_orig_subj3_dl_state);
    Count_Diff_orig_subj3_former_last_name := COUNT(GROUP,%Closest%.Diff_orig_subj3_former_last_name);
    Count_Diff_orig_subj3_address_addressline1 := COUNT(GROUP,%Closest%.Diff_orig_subj3_address_addressline1);
    Count_Diff_orig_subj3_address_addressline2 := COUNT(GROUP,%Closest%.Diff_orig_subj3_address_addressline2);
    Count_Diff_orig_subj3_address_prim_range := COUNT(GROUP,%Closest%.Diff_orig_subj3_address_prim_range);
    Count_Diff_orig_subj3_address_predir := COUNT(GROUP,%Closest%.Diff_orig_subj3_address_predir);
    Count_Diff_orig_subj3_address_prim_name := COUNT(GROUP,%Closest%.Diff_orig_subj3_address_prim_name);
    Count_Diff_orig_subj3_address_suffix := COUNT(GROUP,%Closest%.Diff_orig_subj3_address_suffix);
    Count_Diff_orig_subj3_address_postdir := COUNT(GROUP,%Closest%.Diff_orig_subj3_address_postdir);
    Count_Diff_orig_subj3_address_unit_desig := COUNT(GROUP,%Closest%.Diff_orig_subj3_address_unit_desig);
    Count_Diff_orig_subj3_address_sec_range := COUNT(GROUP,%Closest%.Diff_orig_subj3_address_sec_range);
    Count_Diff_orig_subj3_address_city := COUNT(GROUP,%Closest%.Diff_orig_subj3_address_city);
    Count_Diff_orig_subj3_address_st := COUNT(GROUP,%Closest%.Diff_orig_subj3_address_st);
    Count_Diff_orig_subj3_address_z5 := COUNT(GROUP,%Closest%.Diff_orig_subj3_address_z5);
    Count_Diff_orig_subj3_address_z4 := COUNT(GROUP,%Closest%.Diff_orig_subj3_address_z4);
    Count_Diff_orig_subj3_phone := COUNT(GROUP,%Closest%.Diff_orig_subj3_phone);
    Count_Diff_orig_subj3_work_phone := COUNT(GROUP,%Closest%.Diff_orig_subj3_work_phone);
    Count_Diff_orig_subj3_business_title := COUNT(GROUP,%Closest%.Diff_orig_subj3_business_title);
    Count_Diff_orig_email := COUNT(GROUP,%Closest%.Diff_orig_email);
    Count_Diff_orig_subj2_email := COUNT(GROUP,%Closest%.Diff_orig_subj2_email);
    Count_Diff_orig_subj2_company_name := COUNT(GROUP,%Closest%.Diff_orig_subj2_company_name);
    Count_Diff_orig_subj2_fein := COUNT(GROUP,%Closest%.Diff_orig_subj2_fein);
    Count_Diff_orig_subj3_email := COUNT(GROUP,%Closest%.Diff_orig_subj3_email);
    Count_Diff_orig_subj3_company_name := COUNT(GROUP,%Closest%.Diff_orig_subj3_company_name);
    Count_Diff_orig_subj3_fein := COUNT(GROUP,%Closest%.Diff_orig_subj3_fein);
    Count_Diff_orig_subj4_first_name := COUNT(GROUP,%Closest%.Diff_orig_subj4_first_name);
    Count_Diff_orig_subj4_middle_name := COUNT(GROUP,%Closest%.Diff_orig_subj4_middle_name);
    Count_Diff_orig_subj4_last_name := COUNT(GROUP,%Closest%.Diff_orig_subj4_last_name);
    Count_Diff_orig_subj4_suffix_name := COUNT(GROUP,%Closest%.Diff_orig_subj4_suffix_name);
    Count_Diff_orig_subj4_full_name := COUNT(GROUP,%Closest%.Diff_orig_subj4_full_name);
    Count_Diff_orig_subj4_ssn := COUNT(GROUP,%Closest%.Diff_orig_subj4_ssn);
    Count_Diff_orig_subj4_dob := COUNT(GROUP,%Closest%.Diff_orig_subj4_dob);
    Count_Diff_orig_subj4_dl_num := COUNT(GROUP,%Closest%.Diff_orig_subj4_dl_num);
    Count_Diff_orig_subj4_dl_state := COUNT(GROUP,%Closest%.Diff_orig_subj4_dl_state);
    Count_Diff_orig_subj4_former_last_name := COUNT(GROUP,%Closest%.Diff_orig_subj4_former_last_name);
    Count_Diff_orig_subj4_address_addressline1 := COUNT(GROUP,%Closest%.Diff_orig_subj4_address_addressline1);
    Count_Diff_orig_subj4_address_addressline2 := COUNT(GROUP,%Closest%.Diff_orig_subj4_address_addressline2);
    Count_Diff_orig_subj4_address_prim_range := COUNT(GROUP,%Closest%.Diff_orig_subj4_address_prim_range);
    Count_Diff_orig_subj4_address_predir := COUNT(GROUP,%Closest%.Diff_orig_subj4_address_predir);
    Count_Diff_orig_subj4_address_prim_name := COUNT(GROUP,%Closest%.Diff_orig_subj4_address_prim_name);
    Count_Diff_orig_subj4_address_suffix := COUNT(GROUP,%Closest%.Diff_orig_subj4_address_suffix);
    Count_Diff_orig_subj4_address_postdir := COUNT(GROUP,%Closest%.Diff_orig_subj4_address_postdir);
    Count_Diff_orig_subj4_address_unit_desig := COUNT(GROUP,%Closest%.Diff_orig_subj4_address_unit_desig);
    Count_Diff_orig_subj4_address_sec_range := COUNT(GROUP,%Closest%.Diff_orig_subj4_address_sec_range);
    Count_Diff_orig_subj4_address_city := COUNT(GROUP,%Closest%.Diff_orig_subj4_address_city);
    Count_Diff_orig_subj4_address_st := COUNT(GROUP,%Closest%.Diff_orig_subj4_address_st);
    Count_Diff_orig_subj4_address_z5 := COUNT(GROUP,%Closest%.Diff_orig_subj4_address_z5);
    Count_Diff_orig_subj4_address_z4 := COUNT(GROUP,%Closest%.Diff_orig_subj4_address_z4);
    Count_Diff_orig_subj4_phone := COUNT(GROUP,%Closest%.Diff_orig_subj4_phone);
    Count_Diff_orig_subj4_work_phone := COUNT(GROUP,%Closest%.Diff_orig_subj4_work_phone);
    Count_Diff_orig_subj4_business_title := COUNT(GROUP,%Closest%.Diff_orig_subj4_business_title);
    Count_Diff_orig_subj4_email := COUNT(GROUP,%Closest%.Diff_orig_subj4_email);
    Count_Diff_orig_subj4_company_name := COUNT(GROUP,%Closest%.Diff_orig_subj4_company_name);
    Count_Diff_orig_subj4_fein := COUNT(GROUP,%Closest%.Diff_orig_subj4_fein);
    Count_Diff_orig_subj5_first_name := COUNT(GROUP,%Closest%.Diff_orig_subj5_first_name);
    Count_Diff_orig_subj5_middle_name := COUNT(GROUP,%Closest%.Diff_orig_subj5_middle_name);
    Count_Diff_orig_subj5_last_name := COUNT(GROUP,%Closest%.Diff_orig_subj5_last_name);
    Count_Diff_orig_subj5_suffix_name := COUNT(GROUP,%Closest%.Diff_orig_subj5_suffix_name);
    Count_Diff_orig_subj5_full_name := COUNT(GROUP,%Closest%.Diff_orig_subj5_full_name);
    Count_Diff_orig_subj5_ssn := COUNT(GROUP,%Closest%.Diff_orig_subj5_ssn);
    Count_Diff_orig_subj5_dob := COUNT(GROUP,%Closest%.Diff_orig_subj5_dob);
    Count_Diff_orig_subj5_dl_num := COUNT(GROUP,%Closest%.Diff_orig_subj5_dl_num);
    Count_Diff_orig_subj5_dl_state := COUNT(GROUP,%Closest%.Diff_orig_subj5_dl_state);
    Count_Diff_orig_subj5_former_last_name := COUNT(GROUP,%Closest%.Diff_orig_subj5_former_last_name);
    Count_Diff_orig_subj5_address_addressline1 := COUNT(GROUP,%Closest%.Diff_orig_subj5_address_addressline1);
    Count_Diff_orig_subj5_address_addressline2 := COUNT(GROUP,%Closest%.Diff_orig_subj5_address_addressline2);
    Count_Diff_orig_subj5_address_prim_range := COUNT(GROUP,%Closest%.Diff_orig_subj5_address_prim_range);
    Count_Diff_orig_subj5_address_predir := COUNT(GROUP,%Closest%.Diff_orig_subj5_address_predir);
    Count_Diff_orig_subj5_address_prim_name := COUNT(GROUP,%Closest%.Diff_orig_subj5_address_prim_name);
    Count_Diff_orig_subj5_address_suffix := COUNT(GROUP,%Closest%.Diff_orig_subj5_address_suffix);
    Count_Diff_orig_subj5_address_postdir := COUNT(GROUP,%Closest%.Diff_orig_subj5_address_postdir);
    Count_Diff_orig_subj5_address_unit_desig := COUNT(GROUP,%Closest%.Diff_orig_subj5_address_unit_desig);
    Count_Diff_orig_subj5_address_sec_range := COUNT(GROUP,%Closest%.Diff_orig_subj5_address_sec_range);
    Count_Diff_orig_subj5_address_city := COUNT(GROUP,%Closest%.Diff_orig_subj5_address_city);
    Count_Diff_orig_subj5_address_st := COUNT(GROUP,%Closest%.Diff_orig_subj5_address_st);
    Count_Diff_orig_subj5_address_z5 := COUNT(GROUP,%Closest%.Diff_orig_subj5_address_z5);
    Count_Diff_orig_subj5_address_z4 := COUNT(GROUP,%Closest%.Diff_orig_subj5_address_z4);
    Count_Diff_orig_subj5_phone := COUNT(GROUP,%Closest%.Diff_orig_subj5_phone);
    Count_Diff_orig_subj5_work_phone := COUNT(GROUP,%Closest%.Diff_orig_subj5_work_phone);
    Count_Diff_orig_subj5_business_title := COUNT(GROUP,%Closest%.Diff_orig_subj5_business_title);
    Count_Diff_orig_subj5_email := COUNT(GROUP,%Closest%.Diff_orig_subj5_email);
    Count_Diff_orig_subj5_company_name := COUNT(GROUP,%Closest%.Diff_orig_subj5_company_name);
    Count_Diff_orig_subj5_fein := COUNT(GROUP,%Closest%.Diff_orig_subj5_fein);
    Count_Diff_orig_subj6_first_name := COUNT(GROUP,%Closest%.Diff_orig_subj6_first_name);
    Count_Diff_orig_subj6_middle_name := COUNT(GROUP,%Closest%.Diff_orig_subj6_middle_name);
    Count_Diff_orig_subj6_last_name := COUNT(GROUP,%Closest%.Diff_orig_subj6_last_name);
    Count_Diff_orig_subj6_suffix_name := COUNT(GROUP,%Closest%.Diff_orig_subj6_suffix_name);
    Count_Diff_orig_subj6_full_name := COUNT(GROUP,%Closest%.Diff_orig_subj6_full_name);
    Count_Diff_orig_subj6_ssn := COUNT(GROUP,%Closest%.Diff_orig_subj6_ssn);
    Count_Diff_orig_subj6_dob := COUNT(GROUP,%Closest%.Diff_orig_subj6_dob);
    Count_Diff_orig_subj6_dl_num := COUNT(GROUP,%Closest%.Diff_orig_subj6_dl_num);
    Count_Diff_orig_subj6_dl_state := COUNT(GROUP,%Closest%.Diff_orig_subj6_dl_state);
    Count_Diff_orig_subj6_former_last_name := COUNT(GROUP,%Closest%.Diff_orig_subj6_former_last_name);
    Count_Diff_orig_subj6_address_addressline1 := COUNT(GROUP,%Closest%.Diff_orig_subj6_address_addressline1);
    Count_Diff_orig_subj6_address_addressline2 := COUNT(GROUP,%Closest%.Diff_orig_subj6_address_addressline2);
    Count_Diff_orig_subj6_address_prim_range := COUNT(GROUP,%Closest%.Diff_orig_subj6_address_prim_range);
    Count_Diff_orig_subj6_address_predir := COUNT(GROUP,%Closest%.Diff_orig_subj6_address_predir);
    Count_Diff_orig_subj6_address_prim_name := COUNT(GROUP,%Closest%.Diff_orig_subj6_address_prim_name);
    Count_Diff_orig_subj6_address_suffix := COUNT(GROUP,%Closest%.Diff_orig_subj6_address_suffix);
    Count_Diff_orig_subj6_address_postdir := COUNT(GROUP,%Closest%.Diff_orig_subj6_address_postdir);
    Count_Diff_orig_subj6_address_unit_desig := COUNT(GROUP,%Closest%.Diff_orig_subj6_address_unit_desig);
    Count_Diff_orig_subj6_address_sec_range := COUNT(GROUP,%Closest%.Diff_orig_subj6_address_sec_range);
    Count_Diff_orig_subj6_address_city := COUNT(GROUP,%Closest%.Diff_orig_subj6_address_city);
    Count_Diff_orig_subj6_address_st := COUNT(GROUP,%Closest%.Diff_orig_subj6_address_st);
    Count_Diff_orig_subj6_address_z5 := COUNT(GROUP,%Closest%.Diff_orig_subj6_address_z5);
    Count_Diff_orig_subj6_address_z4 := COUNT(GROUP,%Closest%.Diff_orig_subj6_address_z4);
    Count_Diff_orig_subj6_phone := COUNT(GROUP,%Closest%.Diff_orig_subj6_phone);
    Count_Diff_orig_subj6_work_phone := COUNT(GROUP,%Closest%.Diff_orig_subj6_work_phone);
    Count_Diff_orig_subj6_business_title := COUNT(GROUP,%Closest%.Diff_orig_subj6_business_title);
    Count_Diff_orig_subj6_email := COUNT(GROUP,%Closest%.Diff_orig_subj6_email);
    Count_Diff_orig_subj6_company_name := COUNT(GROUP,%Closest%.Diff_orig_subj6_company_name);
    Count_Diff_orig_subj6_fein := COUNT(GROUP,%Closest%.Diff_orig_subj6_fein);
    Count_Diff_orig_subj7_first_name := COUNT(GROUP,%Closest%.Diff_orig_subj7_first_name);
    Count_Diff_orig_subj7_middle_name := COUNT(GROUP,%Closest%.Diff_orig_subj7_middle_name);
    Count_Diff_orig_subj7_last_name := COUNT(GROUP,%Closest%.Diff_orig_subj7_last_name);
    Count_Diff_orig_subj7_suffix_name := COUNT(GROUP,%Closest%.Diff_orig_subj7_suffix_name);
    Count_Diff_orig_subj7_full_name := COUNT(GROUP,%Closest%.Diff_orig_subj7_full_name);
    Count_Diff_orig_subj7_ssn := COUNT(GROUP,%Closest%.Diff_orig_subj7_ssn);
    Count_Diff_orig_subj7_dob := COUNT(GROUP,%Closest%.Diff_orig_subj7_dob);
    Count_Diff_orig_subj7_dl_num := COUNT(GROUP,%Closest%.Diff_orig_subj7_dl_num);
    Count_Diff_orig_subj7_dl_state := COUNT(GROUP,%Closest%.Diff_orig_subj7_dl_state);
    Count_Diff_orig_subj7_former_last_name := COUNT(GROUP,%Closest%.Diff_orig_subj7_former_last_name);
    Count_Diff_orig_subj7_address_addressline1 := COUNT(GROUP,%Closest%.Diff_orig_subj7_address_addressline1);
    Count_Diff_orig_subj7_address_addressline2 := COUNT(GROUP,%Closest%.Diff_orig_subj7_address_addressline2);
    Count_Diff_orig_subj7_address_prim_range := COUNT(GROUP,%Closest%.Diff_orig_subj7_address_prim_range);
    Count_Diff_orig_subj7_address_predir := COUNT(GROUP,%Closest%.Diff_orig_subj7_address_predir);
    Count_Diff_orig_subj7_address_prim_name := COUNT(GROUP,%Closest%.Diff_orig_subj7_address_prim_name);
    Count_Diff_orig_subj7_address_suffix := COUNT(GROUP,%Closest%.Diff_orig_subj7_address_suffix);
    Count_Diff_orig_subj7_address_postdir := COUNT(GROUP,%Closest%.Diff_orig_subj7_address_postdir);
    Count_Diff_orig_subj7_address_unit_desig := COUNT(GROUP,%Closest%.Diff_orig_subj7_address_unit_desig);
    Count_Diff_orig_subj7_address_sec_range := COUNT(GROUP,%Closest%.Diff_orig_subj7_address_sec_range);
    Count_Diff_orig_subj7_address_city := COUNT(GROUP,%Closest%.Diff_orig_subj7_address_city);
    Count_Diff_orig_subj7_address_st := COUNT(GROUP,%Closest%.Diff_orig_subj7_address_st);
    Count_Diff_orig_subj7_address_z5 := COUNT(GROUP,%Closest%.Diff_orig_subj7_address_z5);
    Count_Diff_orig_subj7_address_z4 := COUNT(GROUP,%Closest%.Diff_orig_subj7_address_z4);
    Count_Diff_orig_subj7_phone := COUNT(GROUP,%Closest%.Diff_orig_subj7_phone);
    Count_Diff_orig_subj7_work_phone := COUNT(GROUP,%Closest%.Diff_orig_subj7_work_phone);
    Count_Diff_orig_subj7_business_title := COUNT(GROUP,%Closest%.Diff_orig_subj7_business_title);
    Count_Diff_orig_subj7_email := COUNT(GROUP,%Closest%.Diff_orig_subj7_email);
    Count_Diff_orig_subj7_company_name := COUNT(GROUP,%Closest%.Diff_orig_subj7_company_name);
    Count_Diff_orig_subj7_fein := COUNT(GROUP,%Closest%.Diff_orig_subj7_fein);
    Count_Diff_orig_subj8_first_name := COUNT(GROUP,%Closest%.Diff_orig_subj8_first_name);
    Count_Diff_orig_subj8_middle_name := COUNT(GROUP,%Closest%.Diff_orig_subj8_middle_name);
    Count_Diff_orig_subj8_last_name := COUNT(GROUP,%Closest%.Diff_orig_subj8_last_name);
    Count_Diff_orig_subj8_suffix_name := COUNT(GROUP,%Closest%.Diff_orig_subj8_suffix_name);
    Count_Diff_orig_subj8_full_name := COUNT(GROUP,%Closest%.Diff_orig_subj8_full_name);
    Count_Diff_orig_subj8_ssn := COUNT(GROUP,%Closest%.Diff_orig_subj8_ssn);
    Count_Diff_orig_subj8_dob := COUNT(GROUP,%Closest%.Diff_orig_subj8_dob);
    Count_Diff_orig_subj8_dl_num := COUNT(GROUP,%Closest%.Diff_orig_subj8_dl_num);
    Count_Diff_orig_subj8_dl_state := COUNT(GROUP,%Closest%.Diff_orig_subj8_dl_state);
    Count_Diff_orig_subj8_former_last_name := COUNT(GROUP,%Closest%.Diff_orig_subj8_former_last_name);
    Count_Diff_orig_subj8_address_addressline1 := COUNT(GROUP,%Closest%.Diff_orig_subj8_address_addressline1);
    Count_Diff_orig_subj8_address_addressline2 := COUNT(GROUP,%Closest%.Diff_orig_subj8_address_addressline2);
    Count_Diff_orig_subj8_address_prim_range := COUNT(GROUP,%Closest%.Diff_orig_subj8_address_prim_range);
    Count_Diff_orig_subj8_address_predir := COUNT(GROUP,%Closest%.Diff_orig_subj8_address_predir);
    Count_Diff_orig_subj8_address_prim_name := COUNT(GROUP,%Closest%.Diff_orig_subj8_address_prim_name);
    Count_Diff_orig_subj8_address_suffix := COUNT(GROUP,%Closest%.Diff_orig_subj8_address_suffix);
    Count_Diff_orig_subj8_address_postdir := COUNT(GROUP,%Closest%.Diff_orig_subj8_address_postdir);
    Count_Diff_orig_subj8_address_unit_desig := COUNT(GROUP,%Closest%.Diff_orig_subj8_address_unit_desig);
    Count_Diff_orig_subj8_address_sec_range := COUNT(GROUP,%Closest%.Diff_orig_subj8_address_sec_range);
    Count_Diff_orig_subj8_address_city := COUNT(GROUP,%Closest%.Diff_orig_subj8_address_city);
    Count_Diff_orig_subj8_address_st := COUNT(GROUP,%Closest%.Diff_orig_subj8_address_st);
    Count_Diff_orig_subj8_address_z5 := COUNT(GROUP,%Closest%.Diff_orig_subj8_address_z5);
    Count_Diff_orig_subj8_address_z4 := COUNT(GROUP,%Closest%.Diff_orig_subj8_address_z4);
    Count_Diff_orig_subj8_phone := COUNT(GROUP,%Closest%.Diff_orig_subj8_phone);
    Count_Diff_orig_subj8_work_phone := COUNT(GROUP,%Closest%.Diff_orig_subj8_work_phone);
    Count_Diff_orig_subj8_business_title := COUNT(GROUP,%Closest%.Diff_orig_subj8_business_title);
    Count_Diff_orig_subj8_email := COUNT(GROUP,%Closest%.Diff_orig_subj8_email);
    Count_Diff_orig_subj8_company_name := COUNT(GROUP,%Closest%.Diff_orig_subj8_company_name);
    Count_Diff_orig_subj8_fein := COUNT(GROUP,%Closest%.Diff_orig_subj8_fein);
    Count_Diff_orig_company_alternate_name := COUNT(GROUP,%Closest%.Diff_orig_company_alternate_name);
  END;
  out_counts := table(%Closest%,%AggRec%,true);
ENDMACRO;
END;
