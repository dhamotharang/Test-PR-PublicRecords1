IMPORT SALT311;
IMPORT Scrubs; // Import modules for FieldTypes attribute definitions
EXPORT Fields := MODULE
 
EXPORT NumFields := 109;
 
// Processing for each FieldType
EXPORT SALT311.StrType FieldTypeName(UNSIGNED2 i) := CHOOSE(i,'Invalid_No','Invalid_Float','Invalid_Alpha','Invalid_AlphaChar','Invalid_AlphaNumChar','Invalid_State','Invalid_Zip','Invalid_Date');
EXPORT FieldTypeNum(SALT311.StrType fn) := CASE(fn,'Invalid_No' => 1,'Invalid_Float' => 2,'Invalid_Alpha' => 3,'Invalid_AlphaChar' => 4,'Invalid_AlphaNumChar' => 5,'Invalid_State' => 6,'Invalid_Zip' => 7,'Invalid_Date' => 8,0);
 
EXPORT MakeFT_Invalid_No(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_Invalid_No(SALT311.StrType s) := WHICH(~Scrubs.Fn_Allow_ws(s,'Num')>0);
EXPORT InValidMessageFT_Invalid_No(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('Scrubs.Fn_Allow_ws'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_Invalid_Float(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringfilter(s0,'0123456789 .'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_Invalid_Float(SALT311.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT311.StringFilter(s,'0123456789 .'))));
EXPORT InValidMessageFT_Invalid_Float(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInChars('0123456789 .'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_Invalid_Alpha(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_Invalid_Alpha(SALT311.StrType s) := WHICH(~Scrubs.Fn_Allow_ws(s,'Alpha')>0);
EXPORT InValidMessageFT_Invalid_Alpha(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('Scrubs.Fn_Allow_ws'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_Invalid_AlphaChar(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_Invalid_AlphaChar(SALT311.StrType s) := WHICH(~Scrubs.Fn_Allow_ws(s,'AlphaChar')>0);
EXPORT InValidMessageFT_Invalid_AlphaChar(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('Scrubs.Fn_Allow_ws'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_Invalid_AlphaNumChar(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_Invalid_AlphaNumChar(SALT311.StrType s) := WHICH(~Scrubs.Fn_Allow_ws(s,'AlphaNumChar')>0);
EXPORT InValidMessageFT_Invalid_AlphaNumChar(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('Scrubs.Fn_Allow_ws'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_Invalid_State(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringfilter(s0,'ABCDEFGHIJKLMNOPQRSTUVWXYZ'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_Invalid_State(SALT311.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT311.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZ'))),~(LENGTH(TRIM(s)) = 0 OR LENGTH(TRIM(s)) = 2));
EXPORT InValidMessageFT_Invalid_State(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWXYZ'),SALT311.HygieneErrors.NotLength('0,2'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_Invalid_Zip(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_Invalid_Zip(SALT311.StrType s) := WHICH(~Scrubs.Fn_Valid_Zip(s)>0);
EXPORT InValidMessageFT_Invalid_Zip(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('Scrubs.Fn_Valid_Zip'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_Invalid_Date(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_Invalid_Date(SALT311.StrType s) := WHICH(~Scrubs.Fn_Valid_Date(s)>0);
EXPORT InValidMessageFT_Invalid_Date(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('Scrubs.Fn_Valid_Date'),SALT311.HygieneErrors.Good);
 
EXPORT SALT311.StrType FieldName(UNSIGNED2 i) := CHOOSE(i,'dartid','dateadded','dateupdated','website','state','caseid','employername','address1','city','employerstate','zipcode','naicscode','totalviolations','bw_totalagreedamount','cmp_totalassessments','ee_totalviolations','ee_totalagreedcount','ca_countviolations','ca_bw_agreedamount','ca_ee_agreedcount','ccpa_countviolations','ccpa_bw_agreedamount','ccpa_ee_agreedcount','crew_countviolations','crew_bw_agreedamount','crew_cmp_assessedamount','crew_ee_agreedcount','cwhssa_countviolations','cwhssa_bw_agreedamount','cwhssa_ee_agreedcount','dbra_cl_countviolations','dbra_bw_agreedamount','dbra_ee_agreedcount','eev_countviolations','eppa_countviolations','eppa_bw_agreedamount','eppa_cmp_assessedamount','eppa_ee_agreedcount','flsa_countviolations','flsa_bw_15a3_agreedamount','flsa_bw_agreedamount','flsa_bw_minwage_agreedamount','flsa_bw_overtime_agreedamount','flsa_cmp_assessedamount','flsa_ee_agreedcount','flsa_cl_countviolations','flsa_cl_countminorsemployed','flsa_cl_cmp_assessedamount','flsa_hmwkr_countviolations','flsa_hmwkr_bw_agreedamount','flsa_hmwkr_cmp_assessedamount','flsa_hmwkr_ee_agreedcount','flsa_smw14_bw_agreedamount','flsa_smw14_countviolations','flsa_smw14_ee_agreedcount','flsa_smwap_countviolations','flsa_smwap_bw_agreedamount','flsa_smwap_ee_agreedcount','flsa_smwft_countviolations','flsa_smwft_bw_agreedamount','flsa_smwft_ee_agreedcount','flsa_smwl_countviolations','flsa_smwl_bw_agreedamount','flsa_smwl_ee_agreedcount','flsa_smwmg_countviolations','flsa_smwmg_bw_agreedamount','flsa_smwmg_ee_agreedcount','flsa_smwpw_countviolations','flsa_smwpw_bw_agreedamount','flsa_smwpw_ee_agreedcount','flsa_smwsl_countviolations','flsa_smwsl_bw_agreedamount','flsa_smwsl_ee_agreedcount','fmla_countviolations','fmla_bw_agreedamount','fmla_cmp_assessedamount','fmla_ee_agreedcount','h1a_countviolations','h1a_bw_agreedamount','h1a_cmp_assessedamount','h1a_ee_agreedcount','h1b_countviolations','h1b_bw_agreedamount','h1b_cmp_assessedamount','h1b_ee_agreedcount','h2a_countviolations','h2a_bw_agreedamount','h2a_cmp_assessedamount','h2a_ee_agreedcount','h2b_countviolations','h2b_bw_agreedamount','h2b_ee_agreedcount','mpsa_countviolations','mpsa_bw_agreedamount','mpsa_cmp_assessedamount','mpsa_ee_agreedcount','osha_countviolations','osha_bw_agreedamount','osha_cmp_assessedamount','osha_ee_agreedcount','pca_countviolations','pca_bw_agreedamount','pca_ee_agreedcount','sca_countviolations','sca_bw_agreedamount','sca_ee_agreedcount','sraw_countviolations','sraw_bw_agreedamount','sraw_ee_agreedcount');
EXPORT SALT311.StrType FlatName(UNSIGNED2 i) := CHOOSE(i,'dartid','dateadded','dateupdated','website','state','caseid','employername','address1','city','employerstate','zipcode','naicscode','totalviolations','bw_totalagreedamount','cmp_totalassessments','ee_totalviolations','ee_totalagreedcount','ca_countviolations','ca_bw_agreedamount','ca_ee_agreedcount','ccpa_countviolations','ccpa_bw_agreedamount','ccpa_ee_agreedcount','crew_countviolations','crew_bw_agreedamount','crew_cmp_assessedamount','crew_ee_agreedcount','cwhssa_countviolations','cwhssa_bw_agreedamount','cwhssa_ee_agreedcount','dbra_cl_countviolations','dbra_bw_agreedamount','dbra_ee_agreedcount','eev_countviolations','eppa_countviolations','eppa_bw_agreedamount','eppa_cmp_assessedamount','eppa_ee_agreedcount','flsa_countviolations','flsa_bw_15a3_agreedamount','flsa_bw_agreedamount','flsa_bw_minwage_agreedamount','flsa_bw_overtime_agreedamount','flsa_cmp_assessedamount','flsa_ee_agreedcount','flsa_cl_countviolations','flsa_cl_countminorsemployed','flsa_cl_cmp_assessedamount','flsa_hmwkr_countviolations','flsa_hmwkr_bw_agreedamount','flsa_hmwkr_cmp_assessedamount','flsa_hmwkr_ee_agreedcount','flsa_smw14_bw_agreedamount','flsa_smw14_countviolations','flsa_smw14_ee_agreedcount','flsa_smwap_countviolations','flsa_smwap_bw_agreedamount','flsa_smwap_ee_agreedcount','flsa_smwft_countviolations','flsa_smwft_bw_agreedamount','flsa_smwft_ee_agreedcount','flsa_smwl_countviolations','flsa_smwl_bw_agreedamount','flsa_smwl_ee_agreedcount','flsa_smwmg_countviolations','flsa_smwmg_bw_agreedamount','flsa_smwmg_ee_agreedcount','flsa_smwpw_countviolations','flsa_smwpw_bw_agreedamount','flsa_smwpw_ee_agreedcount','flsa_smwsl_countviolations','flsa_smwsl_bw_agreedamount','flsa_smwsl_ee_agreedcount','fmla_countviolations','fmla_bw_agreedamount','fmla_cmp_assessedamount','fmla_ee_agreedcount','h1a_countviolations','h1a_bw_agreedamount','h1a_cmp_assessedamount','h1a_ee_agreedcount','h1b_countviolations','h1b_bw_agreedamount','h1b_cmp_assessedamount','h1b_ee_agreedcount','h2a_countviolations','h2a_bw_agreedamount','h2a_cmp_assessedamount','h2a_ee_agreedcount','h2b_countviolations','h2b_bw_agreedamount','h2b_ee_agreedcount','mpsa_countviolations','mpsa_bw_agreedamount','mpsa_cmp_assessedamount','mpsa_ee_agreedcount','osha_countviolations','osha_bw_agreedamount','osha_cmp_assessedamount','osha_ee_agreedcount','pca_countviolations','pca_bw_agreedamount','pca_ee_agreedcount','sca_countviolations','sca_bw_agreedamount','sca_ee_agreedcount','sraw_countviolations','sraw_bw_agreedamount','sraw_ee_agreedcount');
EXPORT FieldNum(SALT311.StrType fn) := CASE(fn,'dartid' => 0,'dateadded' => 1,'dateupdated' => 2,'website' => 3,'state' => 4,'caseid' => 5,'employername' => 6,'address1' => 7,'city' => 8,'employerstate' => 9,'zipcode' => 10,'naicscode' => 11,'totalviolations' => 12,'bw_totalagreedamount' => 13,'cmp_totalassessments' => 14,'ee_totalviolations' => 15,'ee_totalagreedcount' => 16,'ca_countviolations' => 17,'ca_bw_agreedamount' => 18,'ca_ee_agreedcount' => 19,'ccpa_countviolations' => 20,'ccpa_bw_agreedamount' => 21,'ccpa_ee_agreedcount' => 22,'crew_countviolations' => 23,'crew_bw_agreedamount' => 24,'crew_cmp_assessedamount' => 25,'crew_ee_agreedcount' => 26,'cwhssa_countviolations' => 27,'cwhssa_bw_agreedamount' => 28,'cwhssa_ee_agreedcount' => 29,'dbra_cl_countviolations' => 30,'dbra_bw_agreedamount' => 31,'dbra_ee_agreedcount' => 32,'eev_countviolations' => 33,'eppa_countviolations' => 34,'eppa_bw_agreedamount' => 35,'eppa_cmp_assessedamount' => 36,'eppa_ee_agreedcount' => 37,'flsa_countviolations' => 38,'flsa_bw_15a3_agreedamount' => 39,'flsa_bw_agreedamount' => 40,'flsa_bw_minwage_agreedamount' => 41,'flsa_bw_overtime_agreedamount' => 42,'flsa_cmp_assessedamount' => 43,'flsa_ee_agreedcount' => 44,'flsa_cl_countviolations' => 45,'flsa_cl_countminorsemployed' => 46,'flsa_cl_cmp_assessedamount' => 47,'flsa_hmwkr_countviolations' => 48,'flsa_hmwkr_bw_agreedamount' => 49,'flsa_hmwkr_cmp_assessedamount' => 50,'flsa_hmwkr_ee_agreedcount' => 51,'flsa_smw14_bw_agreedamount' => 52,'flsa_smw14_countviolations' => 53,'flsa_smw14_ee_agreedcount' => 54,'flsa_smwap_countviolations' => 55,'flsa_smwap_bw_agreedamount' => 56,'flsa_smwap_ee_agreedcount' => 57,'flsa_smwft_countviolations' => 58,'flsa_smwft_bw_agreedamount' => 59,'flsa_smwft_ee_agreedcount' => 60,'flsa_smwl_countviolations' => 61,'flsa_smwl_bw_agreedamount' => 62,'flsa_smwl_ee_agreedcount' => 63,'flsa_smwmg_countviolations' => 64,'flsa_smwmg_bw_agreedamount' => 65,'flsa_smwmg_ee_agreedcount' => 66,'flsa_smwpw_countviolations' => 67,'flsa_smwpw_bw_agreedamount' => 68,'flsa_smwpw_ee_agreedcount' => 69,'flsa_smwsl_countviolations' => 70,'flsa_smwsl_bw_agreedamount' => 71,'flsa_smwsl_ee_agreedcount' => 72,'fmla_countviolations' => 73,'fmla_bw_agreedamount' => 74,'fmla_cmp_assessedamount' => 75,'fmla_ee_agreedcount' => 76,'h1a_countviolations' => 77,'h1a_bw_agreedamount' => 78,'h1a_cmp_assessedamount' => 79,'h1a_ee_agreedcount' => 80,'h1b_countviolations' => 81,'h1b_bw_agreedamount' => 82,'h1b_cmp_assessedamount' => 83,'h1b_ee_agreedcount' => 84,'h2a_countviolations' => 85,'h2a_bw_agreedamount' => 86,'h2a_cmp_assessedamount' => 87,'h2a_ee_agreedcount' => 88,'h2b_countviolations' => 89,'h2b_bw_agreedamount' => 90,'h2b_ee_agreedcount' => 91,'mpsa_countviolations' => 92,'mpsa_bw_agreedamount' => 93,'mpsa_cmp_assessedamount' => 94,'mpsa_ee_agreedcount' => 95,'osha_countviolations' => 96,'osha_bw_agreedamount' => 97,'osha_cmp_assessedamount' => 98,'osha_ee_agreedcount' => 99,'pca_countviolations' => 100,'pca_bw_agreedamount' => 101,'pca_ee_agreedcount' => 102,'sca_countviolations' => 103,'sca_bw_agreedamount' => 104,'sca_ee_agreedcount' => 105,'sraw_countviolations' => 106,'sraw_bw_agreedamount' => 107,'sraw_ee_agreedcount' => 108,0);
EXPORT SET OF SALT311.StrType FieldRules(UNSIGNED2 i) := CHOOSE(i,['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['ALLOW','LENGTHS'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['ALLOW','LENGTHS'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['ALLOW'],['ALLOW'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['ALLOW'],['CUSTOM'],['CUSTOM'],['ALLOW'],['CUSTOM'],['CUSTOM'],['ALLOW'],['ALLOW'],['CUSTOM'],['CUSTOM'],['ALLOW'],['CUSTOM'],['CUSTOM'],['ALLOW'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['ALLOW'],['ALLOW'],['CUSTOM'],['CUSTOM'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['ALLOW'],['CUSTOM'],['ALLOW'],['ALLOW'],['CUSTOM'],['ALLOW'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['ALLOW'],['CUSTOM'],['CUSTOM'],['ALLOW'],['CUSTOM'],['CUSTOM'],['ALLOW'],['CUSTOM'],['CUSTOM'],['ALLOW'],['CUSTOM'],['CUSTOM'],['ALLOW'],['CUSTOM'],['CUSTOM'],['ALLOW'],['CUSTOM'],['CUSTOM'],['ALLOW'],['ALLOW'],['CUSTOM'],['CUSTOM'],['ALLOW'],['ALLOW'],['CUSTOM'],['CUSTOM'],['ALLOW'],['ALLOW'],['CUSTOM'],['CUSTOM'],['ALLOW'],['ALLOW'],['CUSTOM'],['CUSTOM'],['ALLOW'],['CUSTOM'],['CUSTOM'],['ALLOW'],['ALLOW'],['CUSTOM'],['CUSTOM'],['ALLOW'],['ALLOW'],['CUSTOM'],['CUSTOM'],['ALLOW'],['CUSTOM'],['CUSTOM'],['ALLOW'],['CUSTOM'],['CUSTOM'],['ALLOW'],['CUSTOM'],[]);
EXPORT BOOLEAN InBaseLayout(UNSIGNED2 i) := CHOOSE(i,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,FALSE);
 
//Individual field level validation
 
EXPORT Make_dartid(SALT311.StrType s0) := MakeFT_Invalid_No(s0);
EXPORT InValid_dartid(SALT311.StrType s) := InValidFT_Invalid_No(s);
EXPORT InValidMessage_dartid(UNSIGNED1 wh) := InValidMessageFT_Invalid_No(wh);
 
EXPORT Make_dateadded(SALT311.StrType s0) := MakeFT_Invalid_Date(s0);
EXPORT InValid_dateadded(SALT311.StrType s) := InValidFT_Invalid_Date(s);
EXPORT InValidMessage_dateadded(UNSIGNED1 wh) := InValidMessageFT_Invalid_Date(wh);
 
EXPORT Make_dateupdated(SALT311.StrType s0) := MakeFT_Invalid_Date(s0);
EXPORT InValid_dateupdated(SALT311.StrType s) := InValidFT_Invalid_Date(s);
EXPORT InValidMessage_dateupdated(UNSIGNED1 wh) := InValidMessageFT_Invalid_Date(wh);
 
EXPORT Make_website(SALT311.StrType s0) := MakeFT_Invalid_Alpha(s0);
EXPORT InValid_website(SALT311.StrType s) := InValidFT_Invalid_Alpha(s);
EXPORT InValidMessage_website(UNSIGNED1 wh) := InValidMessageFT_Invalid_Alpha(wh);
 
EXPORT Make_state(SALT311.StrType s0) := MakeFT_Invalid_State(s0);
EXPORT InValid_state(SALT311.StrType s) := InValidFT_Invalid_State(s);
EXPORT InValidMessage_state(UNSIGNED1 wh) := InValidMessageFT_Invalid_State(wh);
 
EXPORT Make_caseid(SALT311.StrType s0) := MakeFT_Invalid_No(s0);
EXPORT InValid_caseid(SALT311.StrType s) := InValidFT_Invalid_No(s);
EXPORT InValidMessage_caseid(UNSIGNED1 wh) := InValidMessageFT_Invalid_No(wh);
 
EXPORT Make_employername(SALT311.StrType s0) := MakeFT_Invalid_AlphaNumChar(s0);
EXPORT InValid_employername(SALT311.StrType s) := InValidFT_Invalid_AlphaNumChar(s);
EXPORT InValidMessage_employername(UNSIGNED1 wh) := InValidMessageFT_Invalid_AlphaNumChar(wh);
 
EXPORT Make_address1(SALT311.StrType s0) := MakeFT_Invalid_AlphaNumChar(s0);
EXPORT InValid_address1(SALT311.StrType s) := InValidFT_Invalid_AlphaNumChar(s);
EXPORT InValidMessage_address1(UNSIGNED1 wh) := InValidMessageFT_Invalid_AlphaNumChar(wh);
 
EXPORT Make_city(SALT311.StrType s0) := MakeFT_Invalid_AlphaChar(s0);
EXPORT InValid_city(SALT311.StrType s) := InValidFT_Invalid_AlphaChar(s);
EXPORT InValidMessage_city(UNSIGNED1 wh) := InValidMessageFT_Invalid_AlphaChar(wh);
 
EXPORT Make_employerstate(SALT311.StrType s0) := MakeFT_Invalid_State(s0);
EXPORT InValid_employerstate(SALT311.StrType s) := InValidFT_Invalid_State(s);
EXPORT InValidMessage_employerstate(UNSIGNED1 wh) := InValidMessageFT_Invalid_State(wh);
 
EXPORT Make_zipcode(SALT311.StrType s0) := MakeFT_Invalid_Zip(s0);
EXPORT InValid_zipcode(SALT311.StrType s) := InValidFT_Invalid_Zip(s);
EXPORT InValidMessage_zipcode(UNSIGNED1 wh) := InValidMessageFT_Invalid_Zip(wh);
 
EXPORT Make_naicscode(SALT311.StrType s0) := MakeFT_Invalid_No(s0);
EXPORT InValid_naicscode(SALT311.StrType s) := InValidFT_Invalid_No(s);
EXPORT InValidMessage_naicscode(UNSIGNED1 wh) := InValidMessageFT_Invalid_No(wh);
 
EXPORT Make_totalviolations(SALT311.StrType s0) := MakeFT_Invalid_No(s0);
EXPORT InValid_totalviolations(SALT311.StrType s) := InValidFT_Invalid_No(s);
EXPORT InValidMessage_totalviolations(UNSIGNED1 wh) := InValidMessageFT_Invalid_No(wh);
 
EXPORT Make_bw_totalagreedamount(SALT311.StrType s0) := MakeFT_Invalid_Float(s0);
EXPORT InValid_bw_totalagreedamount(SALT311.StrType s) := InValidFT_Invalid_Float(s);
EXPORT InValidMessage_bw_totalagreedamount(UNSIGNED1 wh) := InValidMessageFT_Invalid_Float(wh);
 
EXPORT Make_cmp_totalassessments(SALT311.StrType s0) := MakeFT_Invalid_Float(s0);
EXPORT InValid_cmp_totalassessments(SALT311.StrType s) := InValidFT_Invalid_Float(s);
EXPORT InValidMessage_cmp_totalassessments(UNSIGNED1 wh) := InValidMessageFT_Invalid_Float(wh);
 
EXPORT Make_ee_totalviolations(SALT311.StrType s0) := MakeFT_Invalid_No(s0);
EXPORT InValid_ee_totalviolations(SALT311.StrType s) := InValidFT_Invalid_No(s);
EXPORT InValidMessage_ee_totalviolations(UNSIGNED1 wh) := InValidMessageFT_Invalid_No(wh);
 
EXPORT Make_ee_totalagreedcount(SALT311.StrType s0) := MakeFT_Invalid_No(s0);
EXPORT InValid_ee_totalagreedcount(SALT311.StrType s) := InValidFT_Invalid_No(s);
EXPORT InValidMessage_ee_totalagreedcount(UNSIGNED1 wh) := InValidMessageFT_Invalid_No(wh);
 
EXPORT Make_ca_countviolations(SALT311.StrType s0) := MakeFT_Invalid_No(s0);
EXPORT InValid_ca_countviolations(SALT311.StrType s) := InValidFT_Invalid_No(s);
EXPORT InValidMessage_ca_countviolations(UNSIGNED1 wh) := InValidMessageFT_Invalid_No(wh);
 
EXPORT Make_ca_bw_agreedamount(SALT311.StrType s0) := MakeFT_Invalid_Float(s0);
EXPORT InValid_ca_bw_agreedamount(SALT311.StrType s) := InValidFT_Invalid_Float(s);
EXPORT InValidMessage_ca_bw_agreedamount(UNSIGNED1 wh) := InValidMessageFT_Invalid_Float(wh);
 
EXPORT Make_ca_ee_agreedcount(SALT311.StrType s0) := MakeFT_Invalid_No(s0);
EXPORT InValid_ca_ee_agreedcount(SALT311.StrType s) := InValidFT_Invalid_No(s);
EXPORT InValidMessage_ca_ee_agreedcount(UNSIGNED1 wh) := InValidMessageFT_Invalid_No(wh);
 
EXPORT Make_ccpa_countviolations(SALT311.StrType s0) := MakeFT_Invalid_No(s0);
EXPORT InValid_ccpa_countviolations(SALT311.StrType s) := InValidFT_Invalid_No(s);
EXPORT InValidMessage_ccpa_countviolations(UNSIGNED1 wh) := InValidMessageFT_Invalid_No(wh);
 
EXPORT Make_ccpa_bw_agreedamount(SALT311.StrType s0) := MakeFT_Invalid_Float(s0);
EXPORT InValid_ccpa_bw_agreedamount(SALT311.StrType s) := InValidFT_Invalid_Float(s);
EXPORT InValidMessage_ccpa_bw_agreedamount(UNSIGNED1 wh) := InValidMessageFT_Invalid_Float(wh);
 
EXPORT Make_ccpa_ee_agreedcount(SALT311.StrType s0) := MakeFT_Invalid_No(s0);
EXPORT InValid_ccpa_ee_agreedcount(SALT311.StrType s) := InValidFT_Invalid_No(s);
EXPORT InValidMessage_ccpa_ee_agreedcount(UNSIGNED1 wh) := InValidMessageFT_Invalid_No(wh);
 
EXPORT Make_crew_countviolations(SALT311.StrType s0) := MakeFT_Invalid_No(s0);
EXPORT InValid_crew_countviolations(SALT311.StrType s) := InValidFT_Invalid_No(s);
EXPORT InValidMessage_crew_countviolations(UNSIGNED1 wh) := InValidMessageFT_Invalid_No(wh);
 
EXPORT Make_crew_bw_agreedamount(SALT311.StrType s0) := MakeFT_Invalid_Float(s0);
EXPORT InValid_crew_bw_agreedamount(SALT311.StrType s) := InValidFT_Invalid_Float(s);
EXPORT InValidMessage_crew_bw_agreedamount(UNSIGNED1 wh) := InValidMessageFT_Invalid_Float(wh);
 
EXPORT Make_crew_cmp_assessedamount(SALT311.StrType s0) := MakeFT_Invalid_Float(s0);
EXPORT InValid_crew_cmp_assessedamount(SALT311.StrType s) := InValidFT_Invalid_Float(s);
EXPORT InValidMessage_crew_cmp_assessedamount(UNSIGNED1 wh) := InValidMessageFT_Invalid_Float(wh);
 
EXPORT Make_crew_ee_agreedcount(SALT311.StrType s0) := MakeFT_Invalid_No(s0);
EXPORT InValid_crew_ee_agreedcount(SALT311.StrType s) := InValidFT_Invalid_No(s);
EXPORT InValidMessage_crew_ee_agreedcount(UNSIGNED1 wh) := InValidMessageFT_Invalid_No(wh);
 
EXPORT Make_cwhssa_countviolations(SALT311.StrType s0) := MakeFT_Invalid_No(s0);
EXPORT InValid_cwhssa_countviolations(SALT311.StrType s) := InValidFT_Invalid_No(s);
EXPORT InValidMessage_cwhssa_countviolations(UNSIGNED1 wh) := InValidMessageFT_Invalid_No(wh);
 
EXPORT Make_cwhssa_bw_agreedamount(SALT311.StrType s0) := MakeFT_Invalid_Float(s0);
EXPORT InValid_cwhssa_bw_agreedamount(SALT311.StrType s) := InValidFT_Invalid_Float(s);
EXPORT InValidMessage_cwhssa_bw_agreedamount(UNSIGNED1 wh) := InValidMessageFT_Invalid_Float(wh);
 
EXPORT Make_cwhssa_ee_agreedcount(SALT311.StrType s0) := MakeFT_Invalid_No(s0);
EXPORT InValid_cwhssa_ee_agreedcount(SALT311.StrType s) := InValidFT_Invalid_No(s);
EXPORT InValidMessage_cwhssa_ee_agreedcount(UNSIGNED1 wh) := InValidMessageFT_Invalid_No(wh);
 
EXPORT Make_dbra_cl_countviolations(SALT311.StrType s0) := MakeFT_Invalid_No(s0);
EXPORT InValid_dbra_cl_countviolations(SALT311.StrType s) := InValidFT_Invalid_No(s);
EXPORT InValidMessage_dbra_cl_countviolations(UNSIGNED1 wh) := InValidMessageFT_Invalid_No(wh);
 
EXPORT Make_dbra_bw_agreedamount(SALT311.StrType s0) := MakeFT_Invalid_Float(s0);
EXPORT InValid_dbra_bw_agreedamount(SALT311.StrType s) := InValidFT_Invalid_Float(s);
EXPORT InValidMessage_dbra_bw_agreedamount(UNSIGNED1 wh) := InValidMessageFT_Invalid_Float(wh);
 
EXPORT Make_dbra_ee_agreedcount(SALT311.StrType s0) := MakeFT_Invalid_No(s0);
EXPORT InValid_dbra_ee_agreedcount(SALT311.StrType s) := InValidFT_Invalid_No(s);
EXPORT InValidMessage_dbra_ee_agreedcount(UNSIGNED1 wh) := InValidMessageFT_Invalid_No(wh);
 
EXPORT Make_eev_countviolations(SALT311.StrType s0) := MakeFT_Invalid_No(s0);
EXPORT InValid_eev_countviolations(SALT311.StrType s) := InValidFT_Invalid_No(s);
EXPORT InValidMessage_eev_countviolations(UNSIGNED1 wh) := InValidMessageFT_Invalid_No(wh);
 
EXPORT Make_eppa_countviolations(SALT311.StrType s0) := MakeFT_Invalid_No(s0);
EXPORT InValid_eppa_countviolations(SALT311.StrType s) := InValidFT_Invalid_No(s);
EXPORT InValidMessage_eppa_countviolations(UNSIGNED1 wh) := InValidMessageFT_Invalid_No(wh);
 
EXPORT Make_eppa_bw_agreedamount(SALT311.StrType s0) := MakeFT_Invalid_Float(s0);
EXPORT InValid_eppa_bw_agreedamount(SALT311.StrType s) := InValidFT_Invalid_Float(s);
EXPORT InValidMessage_eppa_bw_agreedamount(UNSIGNED1 wh) := InValidMessageFT_Invalid_Float(wh);
 
EXPORT Make_eppa_cmp_assessedamount(SALT311.StrType s0) := MakeFT_Invalid_Float(s0);
EXPORT InValid_eppa_cmp_assessedamount(SALT311.StrType s) := InValidFT_Invalid_Float(s);
EXPORT InValidMessage_eppa_cmp_assessedamount(UNSIGNED1 wh) := InValidMessageFT_Invalid_Float(wh);
 
EXPORT Make_eppa_ee_agreedcount(SALT311.StrType s0) := MakeFT_Invalid_No(s0);
EXPORT InValid_eppa_ee_agreedcount(SALT311.StrType s) := InValidFT_Invalid_No(s);
EXPORT InValidMessage_eppa_ee_agreedcount(UNSIGNED1 wh) := InValidMessageFT_Invalid_No(wh);
 
EXPORT Make_flsa_countviolations(SALT311.StrType s0) := MakeFT_Invalid_No(s0);
EXPORT InValid_flsa_countviolations(SALT311.StrType s) := InValidFT_Invalid_No(s);
EXPORT InValidMessage_flsa_countviolations(UNSIGNED1 wh) := InValidMessageFT_Invalid_No(wh);
 
EXPORT Make_flsa_bw_15a3_agreedamount(SALT311.StrType s0) := MakeFT_Invalid_Float(s0);
EXPORT InValid_flsa_bw_15a3_agreedamount(SALT311.StrType s) := InValidFT_Invalid_Float(s);
EXPORT InValidMessage_flsa_bw_15a3_agreedamount(UNSIGNED1 wh) := InValidMessageFT_Invalid_Float(wh);
 
EXPORT Make_flsa_bw_agreedamount(SALT311.StrType s0) := MakeFT_Invalid_Float(s0);
EXPORT InValid_flsa_bw_agreedamount(SALT311.StrType s) := InValidFT_Invalid_Float(s);
EXPORT InValidMessage_flsa_bw_agreedamount(UNSIGNED1 wh) := InValidMessageFT_Invalid_Float(wh);
 
EXPORT Make_flsa_bw_minwage_agreedamount(SALT311.StrType s0) := MakeFT_Invalid_Float(s0);
EXPORT InValid_flsa_bw_minwage_agreedamount(SALT311.StrType s) := InValidFT_Invalid_Float(s);
EXPORT InValidMessage_flsa_bw_minwage_agreedamount(UNSIGNED1 wh) := InValidMessageFT_Invalid_Float(wh);
 
EXPORT Make_flsa_bw_overtime_agreedamount(SALT311.StrType s0) := MakeFT_Invalid_Float(s0);
EXPORT InValid_flsa_bw_overtime_agreedamount(SALT311.StrType s) := InValidFT_Invalid_Float(s);
EXPORT InValidMessage_flsa_bw_overtime_agreedamount(UNSIGNED1 wh) := InValidMessageFT_Invalid_Float(wh);
 
EXPORT Make_flsa_cmp_assessedamount(SALT311.StrType s0) := MakeFT_Invalid_Float(s0);
EXPORT InValid_flsa_cmp_assessedamount(SALT311.StrType s) := InValidFT_Invalid_Float(s);
EXPORT InValidMessage_flsa_cmp_assessedamount(UNSIGNED1 wh) := InValidMessageFT_Invalid_Float(wh);
 
EXPORT Make_flsa_ee_agreedcount(SALT311.StrType s0) := MakeFT_Invalid_No(s0);
EXPORT InValid_flsa_ee_agreedcount(SALT311.StrType s) := InValidFT_Invalid_No(s);
EXPORT InValidMessage_flsa_ee_agreedcount(UNSIGNED1 wh) := InValidMessageFT_Invalid_No(wh);
 
EXPORT Make_flsa_cl_countviolations(SALT311.StrType s0) := MakeFT_Invalid_No(s0);
EXPORT InValid_flsa_cl_countviolations(SALT311.StrType s) := InValidFT_Invalid_No(s);
EXPORT InValidMessage_flsa_cl_countviolations(UNSIGNED1 wh) := InValidMessageFT_Invalid_No(wh);
 
EXPORT Make_flsa_cl_countminorsemployed(SALT311.StrType s0) := MakeFT_Invalid_No(s0);
EXPORT InValid_flsa_cl_countminorsemployed(SALT311.StrType s) := InValidFT_Invalid_No(s);
EXPORT InValidMessage_flsa_cl_countminorsemployed(UNSIGNED1 wh) := InValidMessageFT_Invalid_No(wh);
 
EXPORT Make_flsa_cl_cmp_assessedamount(SALT311.StrType s0) := MakeFT_Invalid_Float(s0);
EXPORT InValid_flsa_cl_cmp_assessedamount(SALT311.StrType s) := InValidFT_Invalid_Float(s);
EXPORT InValidMessage_flsa_cl_cmp_assessedamount(UNSIGNED1 wh) := InValidMessageFT_Invalid_Float(wh);
 
EXPORT Make_flsa_hmwkr_countviolations(SALT311.StrType s0) := MakeFT_Invalid_No(s0);
EXPORT InValid_flsa_hmwkr_countviolations(SALT311.StrType s) := InValidFT_Invalid_No(s);
EXPORT InValidMessage_flsa_hmwkr_countviolations(UNSIGNED1 wh) := InValidMessageFT_Invalid_No(wh);
 
EXPORT Make_flsa_hmwkr_bw_agreedamount(SALT311.StrType s0) := MakeFT_Invalid_Float(s0);
EXPORT InValid_flsa_hmwkr_bw_agreedamount(SALT311.StrType s) := InValidFT_Invalid_Float(s);
EXPORT InValidMessage_flsa_hmwkr_bw_agreedamount(UNSIGNED1 wh) := InValidMessageFT_Invalid_Float(wh);
 
EXPORT Make_flsa_hmwkr_cmp_assessedamount(SALT311.StrType s0) := MakeFT_Invalid_Float(s0);
EXPORT InValid_flsa_hmwkr_cmp_assessedamount(SALT311.StrType s) := InValidFT_Invalid_Float(s);
EXPORT InValidMessage_flsa_hmwkr_cmp_assessedamount(UNSIGNED1 wh) := InValidMessageFT_Invalid_Float(wh);
 
EXPORT Make_flsa_hmwkr_ee_agreedcount(SALT311.StrType s0) := MakeFT_Invalid_No(s0);
EXPORT InValid_flsa_hmwkr_ee_agreedcount(SALT311.StrType s) := InValidFT_Invalid_No(s);
EXPORT InValidMessage_flsa_hmwkr_ee_agreedcount(UNSIGNED1 wh) := InValidMessageFT_Invalid_No(wh);
 
EXPORT Make_flsa_smw14_bw_agreedamount(SALT311.StrType s0) := MakeFT_Invalid_Float(s0);
EXPORT InValid_flsa_smw14_bw_agreedamount(SALT311.StrType s) := InValidFT_Invalid_Float(s);
EXPORT InValidMessage_flsa_smw14_bw_agreedamount(UNSIGNED1 wh) := InValidMessageFT_Invalid_Float(wh);
 
EXPORT Make_flsa_smw14_countviolations(SALT311.StrType s0) := MakeFT_Invalid_No(s0);
EXPORT InValid_flsa_smw14_countviolations(SALT311.StrType s) := InValidFT_Invalid_No(s);
EXPORT InValidMessage_flsa_smw14_countviolations(UNSIGNED1 wh) := InValidMessageFT_Invalid_No(wh);
 
EXPORT Make_flsa_smw14_ee_agreedcount(SALT311.StrType s0) := MakeFT_Invalid_No(s0);
EXPORT InValid_flsa_smw14_ee_agreedcount(SALT311.StrType s) := InValidFT_Invalid_No(s);
EXPORT InValidMessage_flsa_smw14_ee_agreedcount(UNSIGNED1 wh) := InValidMessageFT_Invalid_No(wh);
 
EXPORT Make_flsa_smwap_countviolations(SALT311.StrType s0) := MakeFT_Invalid_No(s0);
EXPORT InValid_flsa_smwap_countviolations(SALT311.StrType s) := InValidFT_Invalid_No(s);
EXPORT InValidMessage_flsa_smwap_countviolations(UNSIGNED1 wh) := InValidMessageFT_Invalid_No(wh);
 
EXPORT Make_flsa_smwap_bw_agreedamount(SALT311.StrType s0) := MakeFT_Invalid_Float(s0);
EXPORT InValid_flsa_smwap_bw_agreedamount(SALT311.StrType s) := InValidFT_Invalid_Float(s);
EXPORT InValidMessage_flsa_smwap_bw_agreedamount(UNSIGNED1 wh) := InValidMessageFT_Invalid_Float(wh);
 
EXPORT Make_flsa_smwap_ee_agreedcount(SALT311.StrType s0) := MakeFT_Invalid_No(s0);
EXPORT InValid_flsa_smwap_ee_agreedcount(SALT311.StrType s) := InValidFT_Invalid_No(s);
EXPORT InValidMessage_flsa_smwap_ee_agreedcount(UNSIGNED1 wh) := InValidMessageFT_Invalid_No(wh);
 
EXPORT Make_flsa_smwft_countviolations(SALT311.StrType s0) := MakeFT_Invalid_No(s0);
EXPORT InValid_flsa_smwft_countviolations(SALT311.StrType s) := InValidFT_Invalid_No(s);
EXPORT InValidMessage_flsa_smwft_countviolations(UNSIGNED1 wh) := InValidMessageFT_Invalid_No(wh);
 
EXPORT Make_flsa_smwft_bw_agreedamount(SALT311.StrType s0) := MakeFT_Invalid_Float(s0);
EXPORT InValid_flsa_smwft_bw_agreedamount(SALT311.StrType s) := InValidFT_Invalid_Float(s);
EXPORT InValidMessage_flsa_smwft_bw_agreedamount(UNSIGNED1 wh) := InValidMessageFT_Invalid_Float(wh);
 
EXPORT Make_flsa_smwft_ee_agreedcount(SALT311.StrType s0) := MakeFT_Invalid_No(s0);
EXPORT InValid_flsa_smwft_ee_agreedcount(SALT311.StrType s) := InValidFT_Invalid_No(s);
EXPORT InValidMessage_flsa_smwft_ee_agreedcount(UNSIGNED1 wh) := InValidMessageFT_Invalid_No(wh);
 
EXPORT Make_flsa_smwl_countviolations(SALT311.StrType s0) := MakeFT_Invalid_No(s0);
EXPORT InValid_flsa_smwl_countviolations(SALT311.StrType s) := InValidFT_Invalid_No(s);
EXPORT InValidMessage_flsa_smwl_countviolations(UNSIGNED1 wh) := InValidMessageFT_Invalid_No(wh);
 
EXPORT Make_flsa_smwl_bw_agreedamount(SALT311.StrType s0) := MakeFT_Invalid_Float(s0);
EXPORT InValid_flsa_smwl_bw_agreedamount(SALT311.StrType s) := InValidFT_Invalid_Float(s);
EXPORT InValidMessage_flsa_smwl_bw_agreedamount(UNSIGNED1 wh) := InValidMessageFT_Invalid_Float(wh);
 
EXPORT Make_flsa_smwl_ee_agreedcount(SALT311.StrType s0) := MakeFT_Invalid_No(s0);
EXPORT InValid_flsa_smwl_ee_agreedcount(SALT311.StrType s) := InValidFT_Invalid_No(s);
EXPORT InValidMessage_flsa_smwl_ee_agreedcount(UNSIGNED1 wh) := InValidMessageFT_Invalid_No(wh);
 
EXPORT Make_flsa_smwmg_countviolations(SALT311.StrType s0) := MakeFT_Invalid_No(s0);
EXPORT InValid_flsa_smwmg_countviolations(SALT311.StrType s) := InValidFT_Invalid_No(s);
EXPORT InValidMessage_flsa_smwmg_countviolations(UNSIGNED1 wh) := InValidMessageFT_Invalid_No(wh);
 
EXPORT Make_flsa_smwmg_bw_agreedamount(SALT311.StrType s0) := MakeFT_Invalid_Float(s0);
EXPORT InValid_flsa_smwmg_bw_agreedamount(SALT311.StrType s) := InValidFT_Invalid_Float(s);
EXPORT InValidMessage_flsa_smwmg_bw_agreedamount(UNSIGNED1 wh) := InValidMessageFT_Invalid_Float(wh);
 
EXPORT Make_flsa_smwmg_ee_agreedcount(SALT311.StrType s0) := MakeFT_Invalid_No(s0);
EXPORT InValid_flsa_smwmg_ee_agreedcount(SALT311.StrType s) := InValidFT_Invalid_No(s);
EXPORT InValidMessage_flsa_smwmg_ee_agreedcount(UNSIGNED1 wh) := InValidMessageFT_Invalid_No(wh);
 
EXPORT Make_flsa_smwpw_countviolations(SALT311.StrType s0) := MakeFT_Invalid_No(s0);
EXPORT InValid_flsa_smwpw_countviolations(SALT311.StrType s) := InValidFT_Invalid_No(s);
EXPORT InValidMessage_flsa_smwpw_countviolations(UNSIGNED1 wh) := InValidMessageFT_Invalid_No(wh);
 
EXPORT Make_flsa_smwpw_bw_agreedamount(SALT311.StrType s0) := MakeFT_Invalid_Float(s0);
EXPORT InValid_flsa_smwpw_bw_agreedamount(SALT311.StrType s) := InValidFT_Invalid_Float(s);
EXPORT InValidMessage_flsa_smwpw_bw_agreedamount(UNSIGNED1 wh) := InValidMessageFT_Invalid_Float(wh);
 
EXPORT Make_flsa_smwpw_ee_agreedcount(SALT311.StrType s0) := MakeFT_Invalid_No(s0);
EXPORT InValid_flsa_smwpw_ee_agreedcount(SALT311.StrType s) := InValidFT_Invalid_No(s);
EXPORT InValidMessage_flsa_smwpw_ee_agreedcount(UNSIGNED1 wh) := InValidMessageFT_Invalid_No(wh);
 
EXPORT Make_flsa_smwsl_countviolations(SALT311.StrType s0) := MakeFT_Invalid_No(s0);
EXPORT InValid_flsa_smwsl_countviolations(SALT311.StrType s) := InValidFT_Invalid_No(s);
EXPORT InValidMessage_flsa_smwsl_countviolations(UNSIGNED1 wh) := InValidMessageFT_Invalid_No(wh);
 
EXPORT Make_flsa_smwsl_bw_agreedamount(SALT311.StrType s0) := MakeFT_Invalid_Float(s0);
EXPORT InValid_flsa_smwsl_bw_agreedamount(SALT311.StrType s) := InValidFT_Invalid_Float(s);
EXPORT InValidMessage_flsa_smwsl_bw_agreedamount(UNSIGNED1 wh) := InValidMessageFT_Invalid_Float(wh);
 
EXPORT Make_flsa_smwsl_ee_agreedcount(SALT311.StrType s0) := MakeFT_Invalid_No(s0);
EXPORT InValid_flsa_smwsl_ee_agreedcount(SALT311.StrType s) := InValidFT_Invalid_No(s);
EXPORT InValidMessage_flsa_smwsl_ee_agreedcount(UNSIGNED1 wh) := InValidMessageFT_Invalid_No(wh);
 
EXPORT Make_fmla_countviolations(SALT311.StrType s0) := MakeFT_Invalid_No(s0);
EXPORT InValid_fmla_countviolations(SALT311.StrType s) := InValidFT_Invalid_No(s);
EXPORT InValidMessage_fmla_countviolations(UNSIGNED1 wh) := InValidMessageFT_Invalid_No(wh);
 
EXPORT Make_fmla_bw_agreedamount(SALT311.StrType s0) := MakeFT_Invalid_Float(s0);
EXPORT InValid_fmla_bw_agreedamount(SALT311.StrType s) := InValidFT_Invalid_Float(s);
EXPORT InValidMessage_fmla_bw_agreedamount(UNSIGNED1 wh) := InValidMessageFT_Invalid_Float(wh);
 
EXPORT Make_fmla_cmp_assessedamount(SALT311.StrType s0) := MakeFT_Invalid_Float(s0);
EXPORT InValid_fmla_cmp_assessedamount(SALT311.StrType s) := InValidFT_Invalid_Float(s);
EXPORT InValidMessage_fmla_cmp_assessedamount(UNSIGNED1 wh) := InValidMessageFT_Invalid_Float(wh);
 
EXPORT Make_fmla_ee_agreedcount(SALT311.StrType s0) := MakeFT_Invalid_No(s0);
EXPORT InValid_fmla_ee_agreedcount(SALT311.StrType s) := InValidFT_Invalid_No(s);
EXPORT InValidMessage_fmla_ee_agreedcount(UNSIGNED1 wh) := InValidMessageFT_Invalid_No(wh);
 
EXPORT Make_h1a_countviolations(SALT311.StrType s0) := MakeFT_Invalid_No(s0);
EXPORT InValid_h1a_countviolations(SALT311.StrType s) := InValidFT_Invalid_No(s);
EXPORT InValidMessage_h1a_countviolations(UNSIGNED1 wh) := InValidMessageFT_Invalid_No(wh);
 
EXPORT Make_h1a_bw_agreedamount(SALT311.StrType s0) := MakeFT_Invalid_Float(s0);
EXPORT InValid_h1a_bw_agreedamount(SALT311.StrType s) := InValidFT_Invalid_Float(s);
EXPORT InValidMessage_h1a_bw_agreedamount(UNSIGNED1 wh) := InValidMessageFT_Invalid_Float(wh);
 
EXPORT Make_h1a_cmp_assessedamount(SALT311.StrType s0) := MakeFT_Invalid_Float(s0);
EXPORT InValid_h1a_cmp_assessedamount(SALT311.StrType s) := InValidFT_Invalid_Float(s);
EXPORT InValidMessage_h1a_cmp_assessedamount(UNSIGNED1 wh) := InValidMessageFT_Invalid_Float(wh);
 
EXPORT Make_h1a_ee_agreedcount(SALT311.StrType s0) := MakeFT_Invalid_No(s0);
EXPORT InValid_h1a_ee_agreedcount(SALT311.StrType s) := InValidFT_Invalid_No(s);
EXPORT InValidMessage_h1a_ee_agreedcount(UNSIGNED1 wh) := InValidMessageFT_Invalid_No(wh);
 
EXPORT Make_h1b_countviolations(SALT311.StrType s0) := MakeFT_Invalid_No(s0);
EXPORT InValid_h1b_countviolations(SALT311.StrType s) := InValidFT_Invalid_No(s);
EXPORT InValidMessage_h1b_countviolations(UNSIGNED1 wh) := InValidMessageFT_Invalid_No(wh);
 
EXPORT Make_h1b_bw_agreedamount(SALT311.StrType s0) := MakeFT_Invalid_Float(s0);
EXPORT InValid_h1b_bw_agreedamount(SALT311.StrType s) := InValidFT_Invalid_Float(s);
EXPORT InValidMessage_h1b_bw_agreedamount(UNSIGNED1 wh) := InValidMessageFT_Invalid_Float(wh);
 
EXPORT Make_h1b_cmp_assessedamount(SALT311.StrType s0) := MakeFT_Invalid_Float(s0);
EXPORT InValid_h1b_cmp_assessedamount(SALT311.StrType s) := InValidFT_Invalid_Float(s);
EXPORT InValidMessage_h1b_cmp_assessedamount(UNSIGNED1 wh) := InValidMessageFT_Invalid_Float(wh);
 
EXPORT Make_h1b_ee_agreedcount(SALT311.StrType s0) := MakeFT_Invalid_No(s0);
EXPORT InValid_h1b_ee_agreedcount(SALT311.StrType s) := InValidFT_Invalid_No(s);
EXPORT InValidMessage_h1b_ee_agreedcount(UNSIGNED1 wh) := InValidMessageFT_Invalid_No(wh);
 
EXPORT Make_h2a_countviolations(SALT311.StrType s0) := MakeFT_Invalid_No(s0);
EXPORT InValid_h2a_countviolations(SALT311.StrType s) := InValidFT_Invalid_No(s);
EXPORT InValidMessage_h2a_countviolations(UNSIGNED1 wh) := InValidMessageFT_Invalid_No(wh);
 
EXPORT Make_h2a_bw_agreedamount(SALT311.StrType s0) := MakeFT_Invalid_Float(s0);
EXPORT InValid_h2a_bw_agreedamount(SALT311.StrType s) := InValidFT_Invalid_Float(s);
EXPORT InValidMessage_h2a_bw_agreedamount(UNSIGNED1 wh) := InValidMessageFT_Invalid_Float(wh);
 
EXPORT Make_h2a_cmp_assessedamount(SALT311.StrType s0) := MakeFT_Invalid_Float(s0);
EXPORT InValid_h2a_cmp_assessedamount(SALT311.StrType s) := InValidFT_Invalid_Float(s);
EXPORT InValidMessage_h2a_cmp_assessedamount(UNSIGNED1 wh) := InValidMessageFT_Invalid_Float(wh);
 
EXPORT Make_h2a_ee_agreedcount(SALT311.StrType s0) := MakeFT_Invalid_No(s0);
EXPORT InValid_h2a_ee_agreedcount(SALT311.StrType s) := InValidFT_Invalid_No(s);
EXPORT InValidMessage_h2a_ee_agreedcount(UNSIGNED1 wh) := InValidMessageFT_Invalid_No(wh);
 
EXPORT Make_h2b_countviolations(SALT311.StrType s0) := MakeFT_Invalid_No(s0);
EXPORT InValid_h2b_countviolations(SALT311.StrType s) := InValidFT_Invalid_No(s);
EXPORT InValidMessage_h2b_countviolations(UNSIGNED1 wh) := InValidMessageFT_Invalid_No(wh);
 
EXPORT Make_h2b_bw_agreedamount(SALT311.StrType s0) := MakeFT_Invalid_Float(s0);
EXPORT InValid_h2b_bw_agreedamount(SALT311.StrType s) := InValidFT_Invalid_Float(s);
EXPORT InValidMessage_h2b_bw_agreedamount(UNSIGNED1 wh) := InValidMessageFT_Invalid_Float(wh);
 
EXPORT Make_h2b_ee_agreedcount(SALT311.StrType s0) := MakeFT_Invalid_No(s0);
EXPORT InValid_h2b_ee_agreedcount(SALT311.StrType s) := InValidFT_Invalid_No(s);
EXPORT InValidMessage_h2b_ee_agreedcount(UNSIGNED1 wh) := InValidMessageFT_Invalid_No(wh);
 
EXPORT Make_mpsa_countviolations(SALT311.StrType s0) := MakeFT_Invalid_No(s0);
EXPORT InValid_mpsa_countviolations(SALT311.StrType s) := InValidFT_Invalid_No(s);
EXPORT InValidMessage_mpsa_countviolations(UNSIGNED1 wh) := InValidMessageFT_Invalid_No(wh);
 
EXPORT Make_mpsa_bw_agreedamount(SALT311.StrType s0) := MakeFT_Invalid_Float(s0);
EXPORT InValid_mpsa_bw_agreedamount(SALT311.StrType s) := InValidFT_Invalid_Float(s);
EXPORT InValidMessage_mpsa_bw_agreedamount(UNSIGNED1 wh) := InValidMessageFT_Invalid_Float(wh);
 
EXPORT Make_mpsa_cmp_assessedamount(SALT311.StrType s0) := MakeFT_Invalid_Float(s0);
EXPORT InValid_mpsa_cmp_assessedamount(SALT311.StrType s) := InValidFT_Invalid_Float(s);
EXPORT InValidMessage_mpsa_cmp_assessedamount(UNSIGNED1 wh) := InValidMessageFT_Invalid_Float(wh);
 
EXPORT Make_mpsa_ee_agreedcount(SALT311.StrType s0) := MakeFT_Invalid_No(s0);
EXPORT InValid_mpsa_ee_agreedcount(SALT311.StrType s) := InValidFT_Invalid_No(s);
EXPORT InValidMessage_mpsa_ee_agreedcount(UNSIGNED1 wh) := InValidMessageFT_Invalid_No(wh);
 
EXPORT Make_osha_countviolations(SALT311.StrType s0) := MakeFT_Invalid_No(s0);
EXPORT InValid_osha_countviolations(SALT311.StrType s) := InValidFT_Invalid_No(s);
EXPORT InValidMessage_osha_countviolations(UNSIGNED1 wh) := InValidMessageFT_Invalid_No(wh);
 
EXPORT Make_osha_bw_agreedamount(SALT311.StrType s0) := MakeFT_Invalid_Float(s0);
EXPORT InValid_osha_bw_agreedamount(SALT311.StrType s) := InValidFT_Invalid_Float(s);
EXPORT InValidMessage_osha_bw_agreedamount(UNSIGNED1 wh) := InValidMessageFT_Invalid_Float(wh);
 
EXPORT Make_osha_cmp_assessedamount(SALT311.StrType s0) := MakeFT_Invalid_Float(s0);
EXPORT InValid_osha_cmp_assessedamount(SALT311.StrType s) := InValidFT_Invalid_Float(s);
EXPORT InValidMessage_osha_cmp_assessedamount(UNSIGNED1 wh) := InValidMessageFT_Invalid_Float(wh);
 
EXPORT Make_osha_ee_agreedcount(SALT311.StrType s0) := MakeFT_Invalid_No(s0);
EXPORT InValid_osha_ee_agreedcount(SALT311.StrType s) := InValidFT_Invalid_No(s);
EXPORT InValidMessage_osha_ee_agreedcount(UNSIGNED1 wh) := InValidMessageFT_Invalid_No(wh);
 
EXPORT Make_pca_countviolations(SALT311.StrType s0) := MakeFT_Invalid_No(s0);
EXPORT InValid_pca_countviolations(SALT311.StrType s) := InValidFT_Invalid_No(s);
EXPORT InValidMessage_pca_countviolations(UNSIGNED1 wh) := InValidMessageFT_Invalid_No(wh);
 
EXPORT Make_pca_bw_agreedamount(SALT311.StrType s0) := MakeFT_Invalid_Float(s0);
EXPORT InValid_pca_bw_agreedamount(SALT311.StrType s) := InValidFT_Invalid_Float(s);
EXPORT InValidMessage_pca_bw_agreedamount(UNSIGNED1 wh) := InValidMessageFT_Invalid_Float(wh);
 
EXPORT Make_pca_ee_agreedcount(SALT311.StrType s0) := MakeFT_Invalid_No(s0);
EXPORT InValid_pca_ee_agreedcount(SALT311.StrType s) := InValidFT_Invalid_No(s);
EXPORT InValidMessage_pca_ee_agreedcount(UNSIGNED1 wh) := InValidMessageFT_Invalid_No(wh);
 
EXPORT Make_sca_countviolations(SALT311.StrType s0) := MakeFT_Invalid_No(s0);
EXPORT InValid_sca_countviolations(SALT311.StrType s) := InValidFT_Invalid_No(s);
EXPORT InValidMessage_sca_countviolations(UNSIGNED1 wh) := InValidMessageFT_Invalid_No(wh);
 
EXPORT Make_sca_bw_agreedamount(SALT311.StrType s0) := MakeFT_Invalid_Float(s0);
EXPORT InValid_sca_bw_agreedamount(SALT311.StrType s) := InValidFT_Invalid_Float(s);
EXPORT InValidMessage_sca_bw_agreedamount(UNSIGNED1 wh) := InValidMessageFT_Invalid_Float(wh);
 
EXPORT Make_sca_ee_agreedcount(SALT311.StrType s0) := MakeFT_Invalid_No(s0);
EXPORT InValid_sca_ee_agreedcount(SALT311.StrType s) := InValidFT_Invalid_No(s);
EXPORT InValidMessage_sca_ee_agreedcount(UNSIGNED1 wh) := InValidMessageFT_Invalid_No(wh);
 
EXPORT Make_sraw_countviolations(SALT311.StrType s0) := MakeFT_Invalid_No(s0);
EXPORT InValid_sraw_countviolations(SALT311.StrType s) := InValidFT_Invalid_No(s);
EXPORT InValidMessage_sraw_countviolations(UNSIGNED1 wh) := InValidMessageFT_Invalid_No(wh);
 
EXPORT Make_sraw_bw_agreedamount(SALT311.StrType s0) := MakeFT_Invalid_Float(s0);
EXPORT InValid_sraw_bw_agreedamount(SALT311.StrType s) := InValidFT_Invalid_Float(s);
EXPORT InValidMessage_sraw_bw_agreedamount(UNSIGNED1 wh) := InValidMessageFT_Invalid_Float(wh);
 
EXPORT Make_sraw_ee_agreedcount(SALT311.StrType s0) := MakeFT_Invalid_No(s0);
EXPORT InValid_sraw_ee_agreedcount(SALT311.StrType s) := InValidFT_Invalid_No(s);
EXPORT InValidMessage_sraw_ee_agreedcount(UNSIGNED1 wh) := InValidMessageFT_Invalid_No(wh);
 
// This macro will compute and count field level differences based upon a pivot expression
export MAC_CountDifferencesByPivot(in_left,in_right,pivot_exp,bad_pivots,out_counts) := MACRO
  IMPORT SALT311,Scrubs_LaborActions_WHD;
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
    BOOLEAN Diff_dartid;
    BOOLEAN Diff_dateadded;
    BOOLEAN Diff_dateupdated;
    BOOLEAN Diff_website;
    BOOLEAN Diff_state;
    BOOLEAN Diff_caseid;
    BOOLEAN Diff_employername;
    BOOLEAN Diff_address1;
    BOOLEAN Diff_city;
    BOOLEAN Diff_employerstate;
    BOOLEAN Diff_zipcode;
    BOOLEAN Diff_naicscode;
    BOOLEAN Diff_totalviolations;
    BOOLEAN Diff_bw_totalagreedamount;
    BOOLEAN Diff_cmp_totalassessments;
    BOOLEAN Diff_ee_totalviolations;
    BOOLEAN Diff_ee_totalagreedcount;
    BOOLEAN Diff_ca_countviolations;
    BOOLEAN Diff_ca_bw_agreedamount;
    BOOLEAN Diff_ca_ee_agreedcount;
    BOOLEAN Diff_ccpa_countviolations;
    BOOLEAN Diff_ccpa_bw_agreedamount;
    BOOLEAN Diff_ccpa_ee_agreedcount;
    BOOLEAN Diff_crew_countviolations;
    BOOLEAN Diff_crew_bw_agreedamount;
    BOOLEAN Diff_crew_cmp_assessedamount;
    BOOLEAN Diff_crew_ee_agreedcount;
    BOOLEAN Diff_cwhssa_countviolations;
    BOOLEAN Diff_cwhssa_bw_agreedamount;
    BOOLEAN Diff_cwhssa_ee_agreedcount;
    BOOLEAN Diff_dbra_cl_countviolations;
    BOOLEAN Diff_dbra_bw_agreedamount;
    BOOLEAN Diff_dbra_ee_agreedcount;
    BOOLEAN Diff_eev_countviolations;
    BOOLEAN Diff_eppa_countviolations;
    BOOLEAN Diff_eppa_bw_agreedamount;
    BOOLEAN Diff_eppa_cmp_assessedamount;
    BOOLEAN Diff_eppa_ee_agreedcount;
    BOOLEAN Diff_flsa_countviolations;
    BOOLEAN Diff_flsa_bw_15a3_agreedamount;
    BOOLEAN Diff_flsa_bw_agreedamount;
    BOOLEAN Diff_flsa_bw_minwage_agreedamount;
    BOOLEAN Diff_flsa_bw_overtime_agreedamount;
    BOOLEAN Diff_flsa_cmp_assessedamount;
    BOOLEAN Diff_flsa_ee_agreedcount;
    BOOLEAN Diff_flsa_cl_countviolations;
    BOOLEAN Diff_flsa_cl_countminorsemployed;
    BOOLEAN Diff_flsa_cl_cmp_assessedamount;
    BOOLEAN Diff_flsa_hmwkr_countviolations;
    BOOLEAN Diff_flsa_hmwkr_bw_agreedamount;
    BOOLEAN Diff_flsa_hmwkr_cmp_assessedamount;
    BOOLEAN Diff_flsa_hmwkr_ee_agreedcount;
    BOOLEAN Diff_flsa_smw14_bw_agreedamount;
    BOOLEAN Diff_flsa_smw14_countviolations;
    BOOLEAN Diff_flsa_smw14_ee_agreedcount;
    BOOLEAN Diff_flsa_smwap_countviolations;
    BOOLEAN Diff_flsa_smwap_bw_agreedamount;
    BOOLEAN Diff_flsa_smwap_ee_agreedcount;
    BOOLEAN Diff_flsa_smwft_countviolations;
    BOOLEAN Diff_flsa_smwft_bw_agreedamount;
    BOOLEAN Diff_flsa_smwft_ee_agreedcount;
    BOOLEAN Diff_flsa_smwl_countviolations;
    BOOLEAN Diff_flsa_smwl_bw_agreedamount;
    BOOLEAN Diff_flsa_smwl_ee_agreedcount;
    BOOLEAN Diff_flsa_smwmg_countviolations;
    BOOLEAN Diff_flsa_smwmg_bw_agreedamount;
    BOOLEAN Diff_flsa_smwmg_ee_agreedcount;
    BOOLEAN Diff_flsa_smwpw_countviolations;
    BOOLEAN Diff_flsa_smwpw_bw_agreedamount;
    BOOLEAN Diff_flsa_smwpw_ee_agreedcount;
    BOOLEAN Diff_flsa_smwsl_countviolations;
    BOOLEAN Diff_flsa_smwsl_bw_agreedamount;
    BOOLEAN Diff_flsa_smwsl_ee_agreedcount;
    BOOLEAN Diff_fmla_countviolations;
    BOOLEAN Diff_fmla_bw_agreedamount;
    BOOLEAN Diff_fmla_cmp_assessedamount;
    BOOLEAN Diff_fmla_ee_agreedcount;
    BOOLEAN Diff_h1a_countviolations;
    BOOLEAN Diff_h1a_bw_agreedamount;
    BOOLEAN Diff_h1a_cmp_assessedamount;
    BOOLEAN Diff_h1a_ee_agreedcount;
    BOOLEAN Diff_h1b_countviolations;
    BOOLEAN Diff_h1b_bw_agreedamount;
    BOOLEAN Diff_h1b_cmp_assessedamount;
    BOOLEAN Diff_h1b_ee_agreedcount;
    BOOLEAN Diff_h2a_countviolations;
    BOOLEAN Diff_h2a_bw_agreedamount;
    BOOLEAN Diff_h2a_cmp_assessedamount;
    BOOLEAN Diff_h2a_ee_agreedcount;
    BOOLEAN Diff_h2b_countviolations;
    BOOLEAN Diff_h2b_bw_agreedamount;
    BOOLEAN Diff_h2b_ee_agreedcount;
    BOOLEAN Diff_mpsa_countviolations;
    BOOLEAN Diff_mpsa_bw_agreedamount;
    BOOLEAN Diff_mpsa_cmp_assessedamount;
    BOOLEAN Diff_mpsa_ee_agreedcount;
    BOOLEAN Diff_osha_countviolations;
    BOOLEAN Diff_osha_bw_agreedamount;
    BOOLEAN Diff_osha_cmp_assessedamount;
    BOOLEAN Diff_osha_ee_agreedcount;
    BOOLEAN Diff_pca_countviolations;
    BOOLEAN Diff_pca_bw_agreedamount;
    BOOLEAN Diff_pca_ee_agreedcount;
    BOOLEAN Diff_sca_countviolations;
    BOOLEAN Diff_sca_bw_agreedamount;
    BOOLEAN Diff_sca_ee_agreedcount;
    BOOLEAN Diff_sraw_countviolations;
    BOOLEAN Diff_sraw_bw_agreedamount;
    BOOLEAN Diff_sraw_ee_agreedcount;
    UNSIGNED Num_Diffs;
    SALT311.StrType Val {MAXLENGTH(1024)};
  END;
#uniquename(fd)
  %dl% %fd%(in_left le,in_right ri) := TRANSFORM
    SELF.Diff_dartid := le.dartid <> ri.dartid;
    SELF.Diff_dateadded := le.dateadded <> ri.dateadded;
    SELF.Diff_dateupdated := le.dateupdated <> ri.dateupdated;
    SELF.Diff_website := le.website <> ri.website;
    SELF.Diff_state := le.state <> ri.state;
    SELF.Diff_caseid := le.caseid <> ri.caseid;
    SELF.Diff_employername := le.employername <> ri.employername;
    SELF.Diff_address1 := le.address1 <> ri.address1;
    SELF.Diff_city := le.city <> ri.city;
    SELF.Diff_employerstate := le.employerstate <> ri.employerstate;
    SELF.Diff_zipcode := le.zipcode <> ri.zipcode;
    SELF.Diff_naicscode := le.naicscode <> ri.naicscode;
    SELF.Diff_totalviolations := le.totalviolations <> ri.totalviolations;
    SELF.Diff_bw_totalagreedamount := le.bw_totalagreedamount <> ri.bw_totalagreedamount;
    SELF.Diff_cmp_totalassessments := le.cmp_totalassessments <> ri.cmp_totalassessments;
    SELF.Diff_ee_totalviolations := le.ee_totalviolations <> ri.ee_totalviolations;
    SELF.Diff_ee_totalagreedcount := le.ee_totalagreedcount <> ri.ee_totalagreedcount;
    SELF.Diff_ca_countviolations := le.ca_countviolations <> ri.ca_countviolations;
    SELF.Diff_ca_bw_agreedamount := le.ca_bw_agreedamount <> ri.ca_bw_agreedamount;
    SELF.Diff_ca_ee_agreedcount := le.ca_ee_agreedcount <> ri.ca_ee_agreedcount;
    SELF.Diff_ccpa_countviolations := le.ccpa_countviolations <> ri.ccpa_countviolations;
    SELF.Diff_ccpa_bw_agreedamount := le.ccpa_bw_agreedamount <> ri.ccpa_bw_agreedamount;
    SELF.Diff_ccpa_ee_agreedcount := le.ccpa_ee_agreedcount <> ri.ccpa_ee_agreedcount;
    SELF.Diff_crew_countviolations := le.crew_countviolations <> ri.crew_countviolations;
    SELF.Diff_crew_bw_agreedamount := le.crew_bw_agreedamount <> ri.crew_bw_agreedamount;
    SELF.Diff_crew_cmp_assessedamount := le.crew_cmp_assessedamount <> ri.crew_cmp_assessedamount;
    SELF.Diff_crew_ee_agreedcount := le.crew_ee_agreedcount <> ri.crew_ee_agreedcount;
    SELF.Diff_cwhssa_countviolations := le.cwhssa_countviolations <> ri.cwhssa_countviolations;
    SELF.Diff_cwhssa_bw_agreedamount := le.cwhssa_bw_agreedamount <> ri.cwhssa_bw_agreedamount;
    SELF.Diff_cwhssa_ee_agreedcount := le.cwhssa_ee_agreedcount <> ri.cwhssa_ee_agreedcount;
    SELF.Diff_dbra_cl_countviolations := le.dbra_cl_countviolations <> ri.dbra_cl_countviolations;
    SELF.Diff_dbra_bw_agreedamount := le.dbra_bw_agreedamount <> ri.dbra_bw_agreedamount;
    SELF.Diff_dbra_ee_agreedcount := le.dbra_ee_agreedcount <> ri.dbra_ee_agreedcount;
    SELF.Diff_eev_countviolations := le.eev_countviolations <> ri.eev_countviolations;
    SELF.Diff_eppa_countviolations := le.eppa_countviolations <> ri.eppa_countviolations;
    SELF.Diff_eppa_bw_agreedamount := le.eppa_bw_agreedamount <> ri.eppa_bw_agreedamount;
    SELF.Diff_eppa_cmp_assessedamount := le.eppa_cmp_assessedamount <> ri.eppa_cmp_assessedamount;
    SELF.Diff_eppa_ee_agreedcount := le.eppa_ee_agreedcount <> ri.eppa_ee_agreedcount;
    SELF.Diff_flsa_countviolations := le.flsa_countviolations <> ri.flsa_countviolations;
    SELF.Diff_flsa_bw_15a3_agreedamount := le.flsa_bw_15a3_agreedamount <> ri.flsa_bw_15a3_agreedamount;
    SELF.Diff_flsa_bw_agreedamount := le.flsa_bw_agreedamount <> ri.flsa_bw_agreedamount;
    SELF.Diff_flsa_bw_minwage_agreedamount := le.flsa_bw_minwage_agreedamount <> ri.flsa_bw_minwage_agreedamount;
    SELF.Diff_flsa_bw_overtime_agreedamount := le.flsa_bw_overtime_agreedamount <> ri.flsa_bw_overtime_agreedamount;
    SELF.Diff_flsa_cmp_assessedamount := le.flsa_cmp_assessedamount <> ri.flsa_cmp_assessedamount;
    SELF.Diff_flsa_ee_agreedcount := le.flsa_ee_agreedcount <> ri.flsa_ee_agreedcount;
    SELF.Diff_flsa_cl_countviolations := le.flsa_cl_countviolations <> ri.flsa_cl_countviolations;
    SELF.Diff_flsa_cl_countminorsemployed := le.flsa_cl_countminorsemployed <> ri.flsa_cl_countminorsemployed;
    SELF.Diff_flsa_cl_cmp_assessedamount := le.flsa_cl_cmp_assessedamount <> ri.flsa_cl_cmp_assessedamount;
    SELF.Diff_flsa_hmwkr_countviolations := le.flsa_hmwkr_countviolations <> ri.flsa_hmwkr_countviolations;
    SELF.Diff_flsa_hmwkr_bw_agreedamount := le.flsa_hmwkr_bw_agreedamount <> ri.flsa_hmwkr_bw_agreedamount;
    SELF.Diff_flsa_hmwkr_cmp_assessedamount := le.flsa_hmwkr_cmp_assessedamount <> ri.flsa_hmwkr_cmp_assessedamount;
    SELF.Diff_flsa_hmwkr_ee_agreedcount := le.flsa_hmwkr_ee_agreedcount <> ri.flsa_hmwkr_ee_agreedcount;
    SELF.Diff_flsa_smw14_bw_agreedamount := le.flsa_smw14_bw_agreedamount <> ri.flsa_smw14_bw_agreedamount;
    SELF.Diff_flsa_smw14_countviolations := le.flsa_smw14_countviolations <> ri.flsa_smw14_countviolations;
    SELF.Diff_flsa_smw14_ee_agreedcount := le.flsa_smw14_ee_agreedcount <> ri.flsa_smw14_ee_agreedcount;
    SELF.Diff_flsa_smwap_countviolations := le.flsa_smwap_countviolations <> ri.flsa_smwap_countviolations;
    SELF.Diff_flsa_smwap_bw_agreedamount := le.flsa_smwap_bw_agreedamount <> ri.flsa_smwap_bw_agreedamount;
    SELF.Diff_flsa_smwap_ee_agreedcount := le.flsa_smwap_ee_agreedcount <> ri.flsa_smwap_ee_agreedcount;
    SELF.Diff_flsa_smwft_countviolations := le.flsa_smwft_countviolations <> ri.flsa_smwft_countviolations;
    SELF.Diff_flsa_smwft_bw_agreedamount := le.flsa_smwft_bw_agreedamount <> ri.flsa_smwft_bw_agreedamount;
    SELF.Diff_flsa_smwft_ee_agreedcount := le.flsa_smwft_ee_agreedcount <> ri.flsa_smwft_ee_agreedcount;
    SELF.Diff_flsa_smwl_countviolations := le.flsa_smwl_countviolations <> ri.flsa_smwl_countviolations;
    SELF.Diff_flsa_smwl_bw_agreedamount := le.flsa_smwl_bw_agreedamount <> ri.flsa_smwl_bw_agreedamount;
    SELF.Diff_flsa_smwl_ee_agreedcount := le.flsa_smwl_ee_agreedcount <> ri.flsa_smwl_ee_agreedcount;
    SELF.Diff_flsa_smwmg_countviolations := le.flsa_smwmg_countviolations <> ri.flsa_smwmg_countviolations;
    SELF.Diff_flsa_smwmg_bw_agreedamount := le.flsa_smwmg_bw_agreedamount <> ri.flsa_smwmg_bw_agreedamount;
    SELF.Diff_flsa_smwmg_ee_agreedcount := le.flsa_smwmg_ee_agreedcount <> ri.flsa_smwmg_ee_agreedcount;
    SELF.Diff_flsa_smwpw_countviolations := le.flsa_smwpw_countviolations <> ri.flsa_smwpw_countviolations;
    SELF.Diff_flsa_smwpw_bw_agreedamount := le.flsa_smwpw_bw_agreedamount <> ri.flsa_smwpw_bw_agreedamount;
    SELF.Diff_flsa_smwpw_ee_agreedcount := le.flsa_smwpw_ee_agreedcount <> ri.flsa_smwpw_ee_agreedcount;
    SELF.Diff_flsa_smwsl_countviolations := le.flsa_smwsl_countviolations <> ri.flsa_smwsl_countviolations;
    SELF.Diff_flsa_smwsl_bw_agreedamount := le.flsa_smwsl_bw_agreedamount <> ri.flsa_smwsl_bw_agreedamount;
    SELF.Diff_flsa_smwsl_ee_agreedcount := le.flsa_smwsl_ee_agreedcount <> ri.flsa_smwsl_ee_agreedcount;
    SELF.Diff_fmla_countviolations := le.fmla_countviolations <> ri.fmla_countviolations;
    SELF.Diff_fmla_bw_agreedamount := le.fmla_bw_agreedamount <> ri.fmla_bw_agreedamount;
    SELF.Diff_fmla_cmp_assessedamount := le.fmla_cmp_assessedamount <> ri.fmla_cmp_assessedamount;
    SELF.Diff_fmla_ee_agreedcount := le.fmla_ee_agreedcount <> ri.fmla_ee_agreedcount;
    SELF.Diff_h1a_countviolations := le.h1a_countviolations <> ri.h1a_countviolations;
    SELF.Diff_h1a_bw_agreedamount := le.h1a_bw_agreedamount <> ri.h1a_bw_agreedamount;
    SELF.Diff_h1a_cmp_assessedamount := le.h1a_cmp_assessedamount <> ri.h1a_cmp_assessedamount;
    SELF.Diff_h1a_ee_agreedcount := le.h1a_ee_agreedcount <> ri.h1a_ee_agreedcount;
    SELF.Diff_h1b_countviolations := le.h1b_countviolations <> ri.h1b_countviolations;
    SELF.Diff_h1b_bw_agreedamount := le.h1b_bw_agreedamount <> ri.h1b_bw_agreedamount;
    SELF.Diff_h1b_cmp_assessedamount := le.h1b_cmp_assessedamount <> ri.h1b_cmp_assessedamount;
    SELF.Diff_h1b_ee_agreedcount := le.h1b_ee_agreedcount <> ri.h1b_ee_agreedcount;
    SELF.Diff_h2a_countviolations := le.h2a_countviolations <> ri.h2a_countviolations;
    SELF.Diff_h2a_bw_agreedamount := le.h2a_bw_agreedamount <> ri.h2a_bw_agreedamount;
    SELF.Diff_h2a_cmp_assessedamount := le.h2a_cmp_assessedamount <> ri.h2a_cmp_assessedamount;
    SELF.Diff_h2a_ee_agreedcount := le.h2a_ee_agreedcount <> ri.h2a_ee_agreedcount;
    SELF.Diff_h2b_countviolations := le.h2b_countviolations <> ri.h2b_countviolations;
    SELF.Diff_h2b_bw_agreedamount := le.h2b_bw_agreedamount <> ri.h2b_bw_agreedamount;
    SELF.Diff_h2b_ee_agreedcount := le.h2b_ee_agreedcount <> ri.h2b_ee_agreedcount;
    SELF.Diff_mpsa_countviolations := le.mpsa_countviolations <> ri.mpsa_countviolations;
    SELF.Diff_mpsa_bw_agreedamount := le.mpsa_bw_agreedamount <> ri.mpsa_bw_agreedamount;
    SELF.Diff_mpsa_cmp_assessedamount := le.mpsa_cmp_assessedamount <> ri.mpsa_cmp_assessedamount;
    SELF.Diff_mpsa_ee_agreedcount := le.mpsa_ee_agreedcount <> ri.mpsa_ee_agreedcount;
    SELF.Diff_osha_countviolations := le.osha_countviolations <> ri.osha_countviolations;
    SELF.Diff_osha_bw_agreedamount := le.osha_bw_agreedamount <> ri.osha_bw_agreedamount;
    SELF.Diff_osha_cmp_assessedamount := le.osha_cmp_assessedamount <> ri.osha_cmp_assessedamount;
    SELF.Diff_osha_ee_agreedcount := le.osha_ee_agreedcount <> ri.osha_ee_agreedcount;
    SELF.Diff_pca_countviolations := le.pca_countviolations <> ri.pca_countviolations;
    SELF.Diff_pca_bw_agreedamount := le.pca_bw_agreedamount <> ri.pca_bw_agreedamount;
    SELF.Diff_pca_ee_agreedcount := le.pca_ee_agreedcount <> ri.pca_ee_agreedcount;
    SELF.Diff_sca_countviolations := le.sca_countviolations <> ri.sca_countviolations;
    SELF.Diff_sca_bw_agreedamount := le.sca_bw_agreedamount <> ri.sca_bw_agreedamount;
    SELF.Diff_sca_ee_agreedcount := le.sca_ee_agreedcount <> ri.sca_ee_agreedcount;
    SELF.Diff_sraw_countviolations := le.sraw_countviolations <> ri.sraw_countviolations;
    SELF.Diff_sraw_bw_agreedamount := le.sraw_bw_agreedamount <> ri.sraw_bw_agreedamount;
    SELF.Diff_sraw_ee_agreedcount := le.sraw_ee_agreedcount <> ri.sraw_ee_agreedcount;
    SELF.Val := (SALT311.StrType)evaluate(le,pivot_exp);
    SELF.Num_Diffs := 0+ IF( SELF.Diff_dartid,1,0)+ IF( SELF.Diff_dateadded,1,0)+ IF( SELF.Diff_dateupdated,1,0)+ IF( SELF.Diff_website,1,0)+ IF( SELF.Diff_state,1,0)+ IF( SELF.Diff_caseid,1,0)+ IF( SELF.Diff_employername,1,0)+ IF( SELF.Diff_address1,1,0)+ IF( SELF.Diff_city,1,0)+ IF( SELF.Diff_employerstate,1,0)+ IF( SELF.Diff_zipcode,1,0)+ IF( SELF.Diff_naicscode,1,0)+ IF( SELF.Diff_totalviolations,1,0)+ IF( SELF.Diff_bw_totalagreedamount,1,0)+ IF( SELF.Diff_cmp_totalassessments,1,0)+ IF( SELF.Diff_ee_totalviolations,1,0)+ IF( SELF.Diff_ee_totalagreedcount,1,0)+ IF( SELF.Diff_ca_countviolations,1,0)+ IF( SELF.Diff_ca_bw_agreedamount,1,0)+ IF( SELF.Diff_ca_ee_agreedcount,1,0)+ IF( SELF.Diff_ccpa_countviolations,1,0)+ IF( SELF.Diff_ccpa_bw_agreedamount,1,0)+ IF( SELF.Diff_ccpa_ee_agreedcount,1,0)+ IF( SELF.Diff_crew_countviolations,1,0)+ IF( SELF.Diff_crew_bw_agreedamount,1,0)+ IF( SELF.Diff_crew_cmp_assessedamount,1,0)+ IF( SELF.Diff_crew_ee_agreedcount,1,0)+ IF( SELF.Diff_cwhssa_countviolations,1,0)+ IF( SELF.Diff_cwhssa_bw_agreedamount,1,0)+ IF( SELF.Diff_cwhssa_ee_agreedcount,1,0)+ IF( SELF.Diff_dbra_cl_countviolations,1,0)+ IF( SELF.Diff_dbra_bw_agreedamount,1,0)+ IF( SELF.Diff_dbra_ee_agreedcount,1,0)+ IF( SELF.Diff_eev_countviolations,1,0)+ IF( SELF.Diff_eppa_countviolations,1,0)+ IF( SELF.Diff_eppa_bw_agreedamount,1,0)+ IF( SELF.Diff_eppa_cmp_assessedamount,1,0)+ IF( SELF.Diff_eppa_ee_agreedcount,1,0)+ IF( SELF.Diff_flsa_countviolations,1,0)+ IF( SELF.Diff_flsa_bw_15a3_agreedamount,1,0)+ IF( SELF.Diff_flsa_bw_agreedamount,1,0)+ IF( SELF.Diff_flsa_bw_minwage_agreedamount,1,0)+ IF( SELF.Diff_flsa_bw_overtime_agreedamount,1,0)+ IF( SELF.Diff_flsa_cmp_assessedamount,1,0)+ IF( SELF.Diff_flsa_ee_agreedcount,1,0)+ IF( SELF.Diff_flsa_cl_countviolations,1,0)+ IF( SELF.Diff_flsa_cl_countminorsemployed,1,0)+ IF( SELF.Diff_flsa_cl_cmp_assessedamount,1,0)+ IF( SELF.Diff_flsa_hmwkr_countviolations,1,0)+ IF( SELF.Diff_flsa_hmwkr_bw_agreedamount,1,0)+ IF( SELF.Diff_flsa_hmwkr_cmp_assessedamount,1,0)+ IF( SELF.Diff_flsa_hmwkr_ee_agreedcount,1,0)+ IF( SELF.Diff_flsa_smw14_bw_agreedamount,1,0)+ IF( SELF.Diff_flsa_smw14_countviolations,1,0)+ IF( SELF.Diff_flsa_smw14_ee_agreedcount,1,0)+ IF( SELF.Diff_flsa_smwap_countviolations,1,0)+ IF( SELF.Diff_flsa_smwap_bw_agreedamount,1,0)+ IF( SELF.Diff_flsa_smwap_ee_agreedcount,1,0)+ IF( SELF.Diff_flsa_smwft_countviolations,1,0)+ IF( SELF.Diff_flsa_smwft_bw_agreedamount,1,0)+ IF( SELF.Diff_flsa_smwft_ee_agreedcount,1,0)+ IF( SELF.Diff_flsa_smwl_countviolations,1,0)+ IF( SELF.Diff_flsa_smwl_bw_agreedamount,1,0)+ IF( SELF.Diff_flsa_smwl_ee_agreedcount,1,0)+ IF( SELF.Diff_flsa_smwmg_countviolations,1,0)+ IF( SELF.Diff_flsa_smwmg_bw_agreedamount,1,0)+ IF( SELF.Diff_flsa_smwmg_ee_agreedcount,1,0)+ IF( SELF.Diff_flsa_smwpw_countviolations,1,0)+ IF( SELF.Diff_flsa_smwpw_bw_agreedamount,1,0)+ IF( SELF.Diff_flsa_smwpw_ee_agreedcount,1,0)+ IF( SELF.Diff_flsa_smwsl_countviolations,1,0)+ IF( SELF.Diff_flsa_smwsl_bw_agreedamount,1,0)+ IF( SELF.Diff_flsa_smwsl_ee_agreedcount,1,0)+ IF( SELF.Diff_fmla_countviolations,1,0)+ IF( SELF.Diff_fmla_bw_agreedamount,1,0)+ IF( SELF.Diff_fmla_cmp_assessedamount,1,0)+ IF( SELF.Diff_fmla_ee_agreedcount,1,0)+ IF( SELF.Diff_h1a_countviolations,1,0)+ IF( SELF.Diff_h1a_bw_agreedamount,1,0)+ IF( SELF.Diff_h1a_cmp_assessedamount,1,0)+ IF( SELF.Diff_h1a_ee_agreedcount,1,0)+ IF( SELF.Diff_h1b_countviolations,1,0)+ IF( SELF.Diff_h1b_bw_agreedamount,1,0)+ IF( SELF.Diff_h1b_cmp_assessedamount,1,0)+ IF( SELF.Diff_h1b_ee_agreedcount,1,0)+ IF( SELF.Diff_h2a_countviolations,1,0)+ IF( SELF.Diff_h2a_bw_agreedamount,1,0)+ IF( SELF.Diff_h2a_cmp_assessedamount,1,0)+ IF( SELF.Diff_h2a_ee_agreedcount,1,0)+ IF( SELF.Diff_h2b_countviolations,1,0)+ IF( SELF.Diff_h2b_bw_agreedamount,1,0)+ IF( SELF.Diff_h2b_ee_agreedcount,1,0)+ IF( SELF.Diff_mpsa_countviolations,1,0)+ IF( SELF.Diff_mpsa_bw_agreedamount,1,0)+ IF( SELF.Diff_mpsa_cmp_assessedamount,1,0)+ IF( SELF.Diff_mpsa_ee_agreedcount,1,0)+ IF( SELF.Diff_osha_countviolations,1,0)+ IF( SELF.Diff_osha_bw_agreedamount,1,0)+ IF( SELF.Diff_osha_cmp_assessedamount,1,0)+ IF( SELF.Diff_osha_ee_agreedcount,1,0)+ IF( SELF.Diff_pca_countviolations,1,0)+ IF( SELF.Diff_pca_bw_agreedamount,1,0)+ IF( SELF.Diff_pca_ee_agreedcount,1,0)+ IF( SELF.Diff_sca_countviolations,1,0)+ IF( SELF.Diff_sca_bw_agreedamount,1,0)+ IF( SELF.Diff_sca_ee_agreedcount,1,0)+ IF( SELF.Diff_sraw_countviolations,1,0)+ IF( SELF.Diff_sraw_bw_agreedamount,1,0)+ IF( SELF.Diff_sraw_ee_agreedcount,1,0);
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
    Count_Diff_dartid := COUNT(GROUP,%Closest%.Diff_dartid);
    Count_Diff_dateadded := COUNT(GROUP,%Closest%.Diff_dateadded);
    Count_Diff_dateupdated := COUNT(GROUP,%Closest%.Diff_dateupdated);
    Count_Diff_website := COUNT(GROUP,%Closest%.Diff_website);
    Count_Diff_state := COUNT(GROUP,%Closest%.Diff_state);
    Count_Diff_caseid := COUNT(GROUP,%Closest%.Diff_caseid);
    Count_Diff_employername := COUNT(GROUP,%Closest%.Diff_employername);
    Count_Diff_address1 := COUNT(GROUP,%Closest%.Diff_address1);
    Count_Diff_city := COUNT(GROUP,%Closest%.Diff_city);
    Count_Diff_employerstate := COUNT(GROUP,%Closest%.Diff_employerstate);
    Count_Diff_zipcode := COUNT(GROUP,%Closest%.Diff_zipcode);
    Count_Diff_naicscode := COUNT(GROUP,%Closest%.Diff_naicscode);
    Count_Diff_totalviolations := COUNT(GROUP,%Closest%.Diff_totalviolations);
    Count_Diff_bw_totalagreedamount := COUNT(GROUP,%Closest%.Diff_bw_totalagreedamount);
    Count_Diff_cmp_totalassessments := COUNT(GROUP,%Closest%.Diff_cmp_totalassessments);
    Count_Diff_ee_totalviolations := COUNT(GROUP,%Closest%.Diff_ee_totalviolations);
    Count_Diff_ee_totalagreedcount := COUNT(GROUP,%Closest%.Diff_ee_totalagreedcount);
    Count_Diff_ca_countviolations := COUNT(GROUP,%Closest%.Diff_ca_countviolations);
    Count_Diff_ca_bw_agreedamount := COUNT(GROUP,%Closest%.Diff_ca_bw_agreedamount);
    Count_Diff_ca_ee_agreedcount := COUNT(GROUP,%Closest%.Diff_ca_ee_agreedcount);
    Count_Diff_ccpa_countviolations := COUNT(GROUP,%Closest%.Diff_ccpa_countviolations);
    Count_Diff_ccpa_bw_agreedamount := COUNT(GROUP,%Closest%.Diff_ccpa_bw_agreedamount);
    Count_Diff_ccpa_ee_agreedcount := COUNT(GROUP,%Closest%.Diff_ccpa_ee_agreedcount);
    Count_Diff_crew_countviolations := COUNT(GROUP,%Closest%.Diff_crew_countviolations);
    Count_Diff_crew_bw_agreedamount := COUNT(GROUP,%Closest%.Diff_crew_bw_agreedamount);
    Count_Diff_crew_cmp_assessedamount := COUNT(GROUP,%Closest%.Diff_crew_cmp_assessedamount);
    Count_Diff_crew_ee_agreedcount := COUNT(GROUP,%Closest%.Diff_crew_ee_agreedcount);
    Count_Diff_cwhssa_countviolations := COUNT(GROUP,%Closest%.Diff_cwhssa_countviolations);
    Count_Diff_cwhssa_bw_agreedamount := COUNT(GROUP,%Closest%.Diff_cwhssa_bw_agreedamount);
    Count_Diff_cwhssa_ee_agreedcount := COUNT(GROUP,%Closest%.Diff_cwhssa_ee_agreedcount);
    Count_Diff_dbra_cl_countviolations := COUNT(GROUP,%Closest%.Diff_dbra_cl_countviolations);
    Count_Diff_dbra_bw_agreedamount := COUNT(GROUP,%Closest%.Diff_dbra_bw_agreedamount);
    Count_Diff_dbra_ee_agreedcount := COUNT(GROUP,%Closest%.Diff_dbra_ee_agreedcount);
    Count_Diff_eev_countviolations := COUNT(GROUP,%Closest%.Diff_eev_countviolations);
    Count_Diff_eppa_countviolations := COUNT(GROUP,%Closest%.Diff_eppa_countviolations);
    Count_Diff_eppa_bw_agreedamount := COUNT(GROUP,%Closest%.Diff_eppa_bw_agreedamount);
    Count_Diff_eppa_cmp_assessedamount := COUNT(GROUP,%Closest%.Diff_eppa_cmp_assessedamount);
    Count_Diff_eppa_ee_agreedcount := COUNT(GROUP,%Closest%.Diff_eppa_ee_agreedcount);
    Count_Diff_flsa_countviolations := COUNT(GROUP,%Closest%.Diff_flsa_countviolations);
    Count_Diff_flsa_bw_15a3_agreedamount := COUNT(GROUP,%Closest%.Diff_flsa_bw_15a3_agreedamount);
    Count_Diff_flsa_bw_agreedamount := COUNT(GROUP,%Closest%.Diff_flsa_bw_agreedamount);
    Count_Diff_flsa_bw_minwage_agreedamount := COUNT(GROUP,%Closest%.Diff_flsa_bw_minwage_agreedamount);
    Count_Diff_flsa_bw_overtime_agreedamount := COUNT(GROUP,%Closest%.Diff_flsa_bw_overtime_agreedamount);
    Count_Diff_flsa_cmp_assessedamount := COUNT(GROUP,%Closest%.Diff_flsa_cmp_assessedamount);
    Count_Diff_flsa_ee_agreedcount := COUNT(GROUP,%Closest%.Diff_flsa_ee_agreedcount);
    Count_Diff_flsa_cl_countviolations := COUNT(GROUP,%Closest%.Diff_flsa_cl_countviolations);
    Count_Diff_flsa_cl_countminorsemployed := COUNT(GROUP,%Closest%.Diff_flsa_cl_countminorsemployed);
    Count_Diff_flsa_cl_cmp_assessedamount := COUNT(GROUP,%Closest%.Diff_flsa_cl_cmp_assessedamount);
    Count_Diff_flsa_hmwkr_countviolations := COUNT(GROUP,%Closest%.Diff_flsa_hmwkr_countviolations);
    Count_Diff_flsa_hmwkr_bw_agreedamount := COUNT(GROUP,%Closest%.Diff_flsa_hmwkr_bw_agreedamount);
    Count_Diff_flsa_hmwkr_cmp_assessedamount := COUNT(GROUP,%Closest%.Diff_flsa_hmwkr_cmp_assessedamount);
    Count_Diff_flsa_hmwkr_ee_agreedcount := COUNT(GROUP,%Closest%.Diff_flsa_hmwkr_ee_agreedcount);
    Count_Diff_flsa_smw14_bw_agreedamount := COUNT(GROUP,%Closest%.Diff_flsa_smw14_bw_agreedamount);
    Count_Diff_flsa_smw14_countviolations := COUNT(GROUP,%Closest%.Diff_flsa_smw14_countviolations);
    Count_Diff_flsa_smw14_ee_agreedcount := COUNT(GROUP,%Closest%.Diff_flsa_smw14_ee_agreedcount);
    Count_Diff_flsa_smwap_countviolations := COUNT(GROUP,%Closest%.Diff_flsa_smwap_countviolations);
    Count_Diff_flsa_smwap_bw_agreedamount := COUNT(GROUP,%Closest%.Diff_flsa_smwap_bw_agreedamount);
    Count_Diff_flsa_smwap_ee_agreedcount := COUNT(GROUP,%Closest%.Diff_flsa_smwap_ee_agreedcount);
    Count_Diff_flsa_smwft_countviolations := COUNT(GROUP,%Closest%.Diff_flsa_smwft_countviolations);
    Count_Diff_flsa_smwft_bw_agreedamount := COUNT(GROUP,%Closest%.Diff_flsa_smwft_bw_agreedamount);
    Count_Diff_flsa_smwft_ee_agreedcount := COUNT(GROUP,%Closest%.Diff_flsa_smwft_ee_agreedcount);
    Count_Diff_flsa_smwl_countviolations := COUNT(GROUP,%Closest%.Diff_flsa_smwl_countviolations);
    Count_Diff_flsa_smwl_bw_agreedamount := COUNT(GROUP,%Closest%.Diff_flsa_smwl_bw_agreedamount);
    Count_Diff_flsa_smwl_ee_agreedcount := COUNT(GROUP,%Closest%.Diff_flsa_smwl_ee_agreedcount);
    Count_Diff_flsa_smwmg_countviolations := COUNT(GROUP,%Closest%.Diff_flsa_smwmg_countviolations);
    Count_Diff_flsa_smwmg_bw_agreedamount := COUNT(GROUP,%Closest%.Diff_flsa_smwmg_bw_agreedamount);
    Count_Diff_flsa_smwmg_ee_agreedcount := COUNT(GROUP,%Closest%.Diff_flsa_smwmg_ee_agreedcount);
    Count_Diff_flsa_smwpw_countviolations := COUNT(GROUP,%Closest%.Diff_flsa_smwpw_countviolations);
    Count_Diff_flsa_smwpw_bw_agreedamount := COUNT(GROUP,%Closest%.Diff_flsa_smwpw_bw_agreedamount);
    Count_Diff_flsa_smwpw_ee_agreedcount := COUNT(GROUP,%Closest%.Diff_flsa_smwpw_ee_agreedcount);
    Count_Diff_flsa_smwsl_countviolations := COUNT(GROUP,%Closest%.Diff_flsa_smwsl_countviolations);
    Count_Diff_flsa_smwsl_bw_agreedamount := COUNT(GROUP,%Closest%.Diff_flsa_smwsl_bw_agreedamount);
    Count_Diff_flsa_smwsl_ee_agreedcount := COUNT(GROUP,%Closest%.Diff_flsa_smwsl_ee_agreedcount);
    Count_Diff_fmla_countviolations := COUNT(GROUP,%Closest%.Diff_fmla_countviolations);
    Count_Diff_fmla_bw_agreedamount := COUNT(GROUP,%Closest%.Diff_fmla_bw_agreedamount);
    Count_Diff_fmla_cmp_assessedamount := COUNT(GROUP,%Closest%.Diff_fmla_cmp_assessedamount);
    Count_Diff_fmla_ee_agreedcount := COUNT(GROUP,%Closest%.Diff_fmla_ee_agreedcount);
    Count_Diff_h1a_countviolations := COUNT(GROUP,%Closest%.Diff_h1a_countviolations);
    Count_Diff_h1a_bw_agreedamount := COUNT(GROUP,%Closest%.Diff_h1a_bw_agreedamount);
    Count_Diff_h1a_cmp_assessedamount := COUNT(GROUP,%Closest%.Diff_h1a_cmp_assessedamount);
    Count_Diff_h1a_ee_agreedcount := COUNT(GROUP,%Closest%.Diff_h1a_ee_agreedcount);
    Count_Diff_h1b_countviolations := COUNT(GROUP,%Closest%.Diff_h1b_countviolations);
    Count_Diff_h1b_bw_agreedamount := COUNT(GROUP,%Closest%.Diff_h1b_bw_agreedamount);
    Count_Diff_h1b_cmp_assessedamount := COUNT(GROUP,%Closest%.Diff_h1b_cmp_assessedamount);
    Count_Diff_h1b_ee_agreedcount := COUNT(GROUP,%Closest%.Diff_h1b_ee_agreedcount);
    Count_Diff_h2a_countviolations := COUNT(GROUP,%Closest%.Diff_h2a_countviolations);
    Count_Diff_h2a_bw_agreedamount := COUNT(GROUP,%Closest%.Diff_h2a_bw_agreedamount);
    Count_Diff_h2a_cmp_assessedamount := COUNT(GROUP,%Closest%.Diff_h2a_cmp_assessedamount);
    Count_Diff_h2a_ee_agreedcount := COUNT(GROUP,%Closest%.Diff_h2a_ee_agreedcount);
    Count_Diff_h2b_countviolations := COUNT(GROUP,%Closest%.Diff_h2b_countviolations);
    Count_Diff_h2b_bw_agreedamount := COUNT(GROUP,%Closest%.Diff_h2b_bw_agreedamount);
    Count_Diff_h2b_ee_agreedcount := COUNT(GROUP,%Closest%.Diff_h2b_ee_agreedcount);
    Count_Diff_mpsa_countviolations := COUNT(GROUP,%Closest%.Diff_mpsa_countviolations);
    Count_Diff_mpsa_bw_agreedamount := COUNT(GROUP,%Closest%.Diff_mpsa_bw_agreedamount);
    Count_Diff_mpsa_cmp_assessedamount := COUNT(GROUP,%Closest%.Diff_mpsa_cmp_assessedamount);
    Count_Diff_mpsa_ee_agreedcount := COUNT(GROUP,%Closest%.Diff_mpsa_ee_agreedcount);
    Count_Diff_osha_countviolations := COUNT(GROUP,%Closest%.Diff_osha_countviolations);
    Count_Diff_osha_bw_agreedamount := COUNT(GROUP,%Closest%.Diff_osha_bw_agreedamount);
    Count_Diff_osha_cmp_assessedamount := COUNT(GROUP,%Closest%.Diff_osha_cmp_assessedamount);
    Count_Diff_osha_ee_agreedcount := COUNT(GROUP,%Closest%.Diff_osha_ee_agreedcount);
    Count_Diff_pca_countviolations := COUNT(GROUP,%Closest%.Diff_pca_countviolations);
    Count_Diff_pca_bw_agreedamount := COUNT(GROUP,%Closest%.Diff_pca_bw_agreedamount);
    Count_Diff_pca_ee_agreedcount := COUNT(GROUP,%Closest%.Diff_pca_ee_agreedcount);
    Count_Diff_sca_countviolations := COUNT(GROUP,%Closest%.Diff_sca_countviolations);
    Count_Diff_sca_bw_agreedamount := COUNT(GROUP,%Closest%.Diff_sca_bw_agreedamount);
    Count_Diff_sca_ee_agreedcount := COUNT(GROUP,%Closest%.Diff_sca_ee_agreedcount);
    Count_Diff_sraw_countviolations := COUNT(GROUP,%Closest%.Diff_sraw_countviolations);
    Count_Diff_sraw_bw_agreedamount := COUNT(GROUP,%Closest%.Diff_sraw_bw_agreedamount);
    Count_Diff_sraw_ee_agreedcount := COUNT(GROUP,%Closest%.Diff_sraw_ee_agreedcount);
  END;
  out_counts := table(%Closest%,%AggRec%,true);
ENDMACRO;
END;
