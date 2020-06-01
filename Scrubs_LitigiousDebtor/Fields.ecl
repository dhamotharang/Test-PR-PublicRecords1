IMPORT SALT311;
IMPORT Scrubs; // Import modules for FieldTypes attribute definitions
EXPORT Fields := MODULE
 
EXPORT NumFields := 95;
 
// Processing for each FieldType
EXPORT SALT311.StrType FieldTypeName(UNSIGNED2 i) := CHOOSE(i,'Invalid_No','Invalid_Float','Invalid_Alpha','Invalid_AlphaChar','Invalid_AlphaNum','Invalid_AlphaNumChar','Invalid_Date','Invalid_State','Invalid_ID','Invalid_Zip','Invalid_YOrN');
EXPORT FieldTypeNum(SALT311.StrType fn) := CASE(fn,'Invalid_No' => 1,'Invalid_Float' => 2,'Invalid_Alpha' => 3,'Invalid_AlphaChar' => 4,'Invalid_AlphaNum' => 5,'Invalid_AlphaNumChar' => 6,'Invalid_Date' => 7,'Invalid_State' => 8,'Invalid_ID' => 9,'Invalid_Zip' => 10,'Invalid_YOrN' => 11,0);
 
EXPORT MakeFT_Invalid_No(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_Invalid_No(SALT311.StrType s) := WHICH(~Scrubs.Fn_Allow_ws(s,'Num')>0);
EXPORT InValidMessageFT_Invalid_No(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('Scrubs.Fn_Allow_ws'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_Invalid_Float(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringfilter(s0,'0123456789.,-:'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_Invalid_Float(SALT311.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT311.StringFilter(s,'0123456789.,-:'))));
EXPORT InValidMessageFT_Invalid_Float(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInChars('0123456789.,-:'),SALT311.HygieneErrors.Good);
 
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
 
EXPORT MakeFT_Invalid_AlphaNum(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_Invalid_AlphaNum(SALT311.StrType s) := WHICH(~Scrubs.Fn_Allow_ws(s,'AlphaNum')>0);
EXPORT InValidMessageFT_Invalid_AlphaNum(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('Scrubs.Fn_Allow_ws'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_Invalid_AlphaNumChar(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_Invalid_AlphaNumChar(SALT311.StrType s) := WHICH(~Scrubs.Fn_Allow_ws(s,'AlphaNumChar')>0);
EXPORT InValidMessageFT_Invalid_AlphaNumChar(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('Scrubs.Fn_Allow_ws'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_Invalid_Date(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_Invalid_Date(SALT311.StrType s) := WHICH(~Scrubs.Fn_valid_Date(s)>0);
EXPORT InValidMessageFT_Invalid_Date(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('Scrubs.Fn_valid_Date'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_Invalid_State(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringfilter(s0,'ABCDEFGHIJKLMNOPQRSTUVWXYZ'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_Invalid_State(SALT311.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT311.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZ'))),~(LENGTH(TRIM(s)) = 0 OR LENGTH(TRIM(s)) = 2));
EXPORT InValidMessageFT_Invalid_State(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWXYZ'),SALT311.HygieneErrors.NotLength('0,2'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_Invalid_ID(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringfilter(s0,'ABCDEFGHIJKLMNOPQRSTUVWXYZ-'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_Invalid_ID(SALT311.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT311.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZ-'))),~(LENGTH(TRIM(s)) = 0 OR LENGTH(TRIM(s)) = 6));
EXPORT InValidMessageFT_Invalid_ID(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWXYZ-'),SALT311.HygieneErrors.NotLength('0,6'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_Invalid_Zip(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringfilter(s0,'0123456789.,-:'); // Only allow valid symbols
  RETURN  MakeFT_Invalid_Float(s1);
END;
EXPORT InValidFT_Invalid_Zip(SALT311.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT311.StringFilter(s,'0123456789.,-:'))),~(LENGTH(TRIM(s)) = 0 OR LENGTH(TRIM(s)) = 5 OR LENGTH(TRIM(s)) = 9 OR LENGTH(TRIM(s)) = 10));
EXPORT InValidMessageFT_Invalid_Zip(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInChars('0123456789.,-:'),SALT311.HygieneErrors.NotLength('0,5,9,10'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_Invalid_YOrN(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringfilter(s0,'YN'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_Invalid_YOrN(SALT311.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT311.StringFilter(s,'YN'))),~(LENGTH(TRIM(s)) = 0 OR LENGTH(TRIM(s)) = 1));
EXPORT InValidMessageFT_Invalid_YOrN(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInChars('YN'),SALT311.HygieneErrors.NotLength('0,1'),SALT311.HygieneErrors.Good);
 
EXPORT SALT311.StrType FieldName(UNSIGNED2 i) := CHOOSE(i,'dt_first_seen','dt_last_seen','dt_vendor_first_reported','dt_vendor_last_reported','record_type','recid','courtstate','courtid','courtname','docketnumber','officename','asofdate','classcode','casecaption','datefiled','judgetitle','judgename','referredtojudgetitle','referredtojudge','jurydemand','demandamount','suitnaturecode','suitnaturedesc','leaddocketnumber','jurisdiction','cause','statute','ca','caseclosed','dateretrieved','otherdocketnumber','litigantname','litigantlabel','layoutcode','terminationdate','attorneyname','attorneylabel','firmname','address','city','state','zipcode','country','addtlinfo','termdate','bdid','did','causecode','judge_title','judge_fname','judge_mname','judge_lname','judge_suffix','judge_score','business_person','debtor','debtor_title','debtor_fname','debtor_mname','debtor_lname','debtor_suffix','debtor_score','attorney_title','attorney_fname','attorney_mname','attorney_lname','attorney_suffix','attorney_score','prim_range','predir','prim_name','addr_suffix','postdir','unit_desig','sec_range','p_city_name','v_city_name','st','zip','zip4','cart','cr_sort_sz','lot','lot_order','dbpc','chk_digit','rec_type','fips_state','fips_county','geo_lat','geo_long','msa','geo_blk','geo_match','err_stat');
EXPORT SALT311.StrType FlatName(UNSIGNED2 i) := CHOOSE(i,'dt_first_seen','dt_last_seen','dt_vendor_first_reported','dt_vendor_last_reported','record_type','recid','courtstate','courtid','courtname','docketnumber','officename','asofdate','classcode','casecaption','datefiled','judgetitle','judgename','referredtojudgetitle','referredtojudge','jurydemand','demandamount','suitnaturecode','suitnaturedesc','leaddocketnumber','jurisdiction','cause','statute','ca','caseclosed','dateretrieved','otherdocketnumber','litigantname','litigantlabel','layoutcode','terminationdate','attorneyname','attorneylabel','firmname','address','city','state','zipcode','country','addtlinfo','termdate','bdid','did','causecode','judge_title','judge_fname','judge_mname','judge_lname','judge_suffix','judge_score','business_person','debtor','debtor_title','debtor_fname','debtor_mname','debtor_lname','debtor_suffix','debtor_score','attorney_title','attorney_fname','attorney_mname','attorney_lname','attorney_suffix','attorney_score','prim_range','predir','prim_name','addr_suffix','postdir','unit_desig','sec_range','p_city_name','v_city_name','st','zip','zip4','cart','cr_sort_sz','lot','lot_order','dbpc','chk_digit','rec_type','fips_state','fips_county','geo_lat','geo_long','msa','geo_blk','geo_match','err_stat');
EXPORT FieldNum(SALT311.StrType fn) := CASE(fn,'dt_first_seen' => 0,'dt_last_seen' => 1,'dt_vendor_first_reported' => 2,'dt_vendor_last_reported' => 3,'record_type' => 4,'recid' => 5,'courtstate' => 6,'courtid' => 7,'courtname' => 8,'docketnumber' => 9,'officename' => 10,'asofdate' => 11,'classcode' => 12,'casecaption' => 13,'datefiled' => 14,'judgetitle' => 15,'judgename' => 16,'referredtojudgetitle' => 17,'referredtojudge' => 18,'jurydemand' => 19,'demandamount' => 20,'suitnaturecode' => 21,'suitnaturedesc' => 22,'leaddocketnumber' => 23,'jurisdiction' => 24,'cause' => 25,'statute' => 26,'ca' => 27,'caseclosed' => 28,'dateretrieved' => 29,'otherdocketnumber' => 30,'litigantname' => 31,'litigantlabel' => 32,'layoutcode' => 33,'terminationdate' => 34,'attorneyname' => 35,'attorneylabel' => 36,'firmname' => 37,'address' => 38,'city' => 39,'state' => 40,'zipcode' => 41,'country' => 42,'addtlinfo' => 43,'termdate' => 44,'bdid' => 45,'did' => 46,'causecode' => 47,'judge_title' => 48,'judge_fname' => 49,'judge_mname' => 50,'judge_lname' => 51,'judge_suffix' => 52,'judge_score' => 53,'business_person' => 54,'debtor' => 55,'debtor_title' => 56,'debtor_fname' => 57,'debtor_mname' => 58,'debtor_lname' => 59,'debtor_suffix' => 60,'debtor_score' => 61,'attorney_title' => 62,'attorney_fname' => 63,'attorney_mname' => 64,'attorney_lname' => 65,'attorney_suffix' => 66,'attorney_score' => 67,'prim_range' => 68,'predir' => 69,'prim_name' => 70,'addr_suffix' => 71,'postdir' => 72,'unit_desig' => 73,'sec_range' => 74,'p_city_name' => 75,'v_city_name' => 76,'st' => 77,'zip' => 78,'zip4' => 79,'cart' => 80,'cr_sort_sz' => 81,'lot' => 82,'lot_order' => 83,'dbpc' => 84,'chk_digit' => 85,'rec_type' => 86,'fips_state' => 87,'fips_county' => 88,'geo_lat' => 89,'geo_long' => 90,'msa' => 91,'geo_blk' => 92,'geo_match' => 93,'err_stat' => 94,0);
EXPORT SET OF SALT311.StrType FieldRules(UNSIGNED2 i) := CHOOSE(i,['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['ALLOW','LENGTHS'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['ALLOW'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['ALLOW'],['ALLOW','LENGTHS'],['ALLOW','LENGTHS'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['ALLOW','LENGTHS'],['ALLOW','LENGTHS'],['CUSTOM'],[],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['ALLOW','LENGTHS'],['ALLOW','LENGTHS'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['ALLOW'],['ALLOW'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],[]);
EXPORT BOOLEAN InBaseLayout(UNSIGNED2 i) := CHOOSE(i,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,FALSE);
 
//Individual field level validation
 
EXPORT Make_dt_first_seen(SALT311.StrType s0) := MakeFT_Invalid_Date(s0);
EXPORT InValid_dt_first_seen(SALT311.StrType s) := InValidFT_Invalid_Date(s);
EXPORT InValidMessage_dt_first_seen(UNSIGNED1 wh) := InValidMessageFT_Invalid_Date(wh);
 
EXPORT Make_dt_last_seen(SALT311.StrType s0) := MakeFT_Invalid_Date(s0);
EXPORT InValid_dt_last_seen(SALT311.StrType s) := InValidFT_Invalid_Date(s);
EXPORT InValidMessage_dt_last_seen(UNSIGNED1 wh) := InValidMessageFT_Invalid_Date(wh);
 
EXPORT Make_dt_vendor_first_reported(SALT311.StrType s0) := MakeFT_Invalid_Date(s0);
EXPORT InValid_dt_vendor_first_reported(SALT311.StrType s) := InValidFT_Invalid_Date(s);
EXPORT InValidMessage_dt_vendor_first_reported(UNSIGNED1 wh) := InValidMessageFT_Invalid_Date(wh);
 
EXPORT Make_dt_vendor_last_reported(SALT311.StrType s0) := MakeFT_Invalid_Date(s0);
EXPORT InValid_dt_vendor_last_reported(SALT311.StrType s) := InValidFT_Invalid_Date(s);
EXPORT InValidMessage_dt_vendor_last_reported(UNSIGNED1 wh) := InValidMessageFT_Invalid_Date(wh);
 
EXPORT Make_record_type(SALT311.StrType s0) := MakeFT_Invalid_Alpha(s0);
EXPORT InValid_record_type(SALT311.StrType s) := InValidFT_Invalid_Alpha(s);
EXPORT InValidMessage_record_type(UNSIGNED1 wh) := InValidMessageFT_Invalid_Alpha(wh);
 
EXPORT Make_recid(SALT311.StrType s0) := MakeFT_Invalid_No(s0);
EXPORT InValid_recid(SALT311.StrType s) := InValidFT_Invalid_No(s);
EXPORT InValidMessage_recid(UNSIGNED1 wh) := InValidMessageFT_Invalid_No(wh);
 
EXPORT Make_courtstate(SALT311.StrType s0) := MakeFT_Invalid_State(s0);
EXPORT InValid_courtstate(SALT311.StrType s) := InValidFT_Invalid_State(s);
EXPORT InValidMessage_courtstate(UNSIGNED1 wh) := InValidMessageFT_Invalid_State(wh);
 
EXPORT Make_courtid(SALT311.StrType s0) := MakeFT_Invalid_AlphaChar(s0);
EXPORT InValid_courtid(SALT311.StrType s) := InValidFT_Invalid_AlphaChar(s);
EXPORT InValidMessage_courtid(UNSIGNED1 wh) := InValidMessageFT_Invalid_AlphaChar(wh);
 
EXPORT Make_courtname(SALT311.StrType s0) := MakeFT_Invalid_Alpha(s0);
EXPORT InValid_courtname(SALT311.StrType s) := InValidFT_Invalid_Alpha(s);
EXPORT InValidMessage_courtname(UNSIGNED1 wh) := InValidMessageFT_Invalid_Alpha(wh);
 
EXPORT Make_docketnumber(SALT311.StrType s0) := MakeFT_Invalid_AlphaNumChar(s0);
EXPORT InValid_docketnumber(SALT311.StrType s) := InValidFT_Invalid_AlphaNumChar(s);
EXPORT InValidMessage_docketnumber(UNSIGNED1 wh) := InValidMessageFT_Invalid_AlphaNumChar(wh);
 
EXPORT Make_officename(SALT311.StrType s0) := MakeFT_Invalid_AlphaChar(s0);
EXPORT InValid_officename(SALT311.StrType s) := InValidFT_Invalid_AlphaChar(s);
EXPORT InValidMessage_officename(UNSIGNED1 wh) := InValidMessageFT_Invalid_AlphaChar(wh);
 
EXPORT Make_asofdate(SALT311.StrType s0) := MakeFT_Invalid_Date(s0);
EXPORT InValid_asofdate(SALT311.StrType s) := InValidFT_Invalid_Date(s);
EXPORT InValidMessage_asofdate(UNSIGNED1 wh) := InValidMessageFT_Invalid_Date(wh);
 
EXPORT Make_classcode(SALT311.StrType s0) := MakeFT_Invalid_AlphaNumChar(s0);
EXPORT InValid_classcode(SALT311.StrType s) := InValidFT_Invalid_AlphaNumChar(s);
EXPORT InValidMessage_classcode(UNSIGNED1 wh) := InValidMessageFT_Invalid_AlphaNumChar(wh);
 
EXPORT Make_casecaption(SALT311.StrType s0) := MakeFT_Invalid_AlphaChar(s0);
EXPORT InValid_casecaption(SALT311.StrType s) := InValidFT_Invalid_AlphaChar(s);
EXPORT InValidMessage_casecaption(UNSIGNED1 wh) := InValidMessageFT_Invalid_AlphaChar(wh);
 
EXPORT Make_datefiled(SALT311.StrType s0) := MakeFT_Invalid_Date(s0);
EXPORT InValid_datefiled(SALT311.StrType s) := InValidFT_Invalid_Date(s);
EXPORT InValidMessage_datefiled(UNSIGNED1 wh) := InValidMessageFT_Invalid_Date(wh);
 
EXPORT Make_judgetitle(SALT311.StrType s0) := MakeFT_Invalid_Alpha(s0);
EXPORT InValid_judgetitle(SALT311.StrType s) := InValidFT_Invalid_Alpha(s);
EXPORT InValidMessage_judgetitle(UNSIGNED1 wh) := InValidMessageFT_Invalid_Alpha(wh);
 
EXPORT Make_judgename(SALT311.StrType s0) := MakeFT_Invalid_AlphaChar(s0);
EXPORT InValid_judgename(SALT311.StrType s) := InValidFT_Invalid_AlphaChar(s);
EXPORT InValidMessage_judgename(UNSIGNED1 wh) := InValidMessageFT_Invalid_AlphaChar(wh);
 
EXPORT Make_referredtojudgetitle(SALT311.StrType s0) := MakeFT_Invalid_Alpha(s0);
EXPORT InValid_referredtojudgetitle(SALT311.StrType s) := InValidFT_Invalid_Alpha(s);
EXPORT InValidMessage_referredtojudgetitle(UNSIGNED1 wh) := InValidMessageFT_Invalid_Alpha(wh);
 
EXPORT Make_referredtojudge(SALT311.StrType s0) := MakeFT_Invalid_AlphaChar(s0);
EXPORT InValid_referredtojudge(SALT311.StrType s) := InValidFT_Invalid_AlphaChar(s);
EXPORT InValidMessage_referredtojudge(UNSIGNED1 wh) := InValidMessageFT_Invalid_AlphaChar(wh);
 
EXPORT Make_jurydemand(SALT311.StrType s0) := MakeFT_Invalid_Alpha(s0);
EXPORT InValid_jurydemand(SALT311.StrType s) := InValidFT_Invalid_Alpha(s);
EXPORT InValidMessage_jurydemand(UNSIGNED1 wh) := InValidMessageFT_Invalid_Alpha(wh);
 
EXPORT Make_demandamount(SALT311.StrType s0) := MakeFT_Invalid_Float(s0);
EXPORT InValid_demandamount(SALT311.StrType s) := InValidFT_Invalid_Float(s);
EXPORT InValidMessage_demandamount(UNSIGNED1 wh) := InValidMessageFT_Invalid_Float(wh);
 
EXPORT Make_suitnaturecode(SALT311.StrType s0) := MakeFT_Invalid_No(s0);
EXPORT InValid_suitnaturecode(SALT311.StrType s) := InValidFT_Invalid_No(s);
EXPORT InValidMessage_suitnaturecode(UNSIGNED1 wh) := InValidMessageFT_Invalid_No(wh);
 
EXPORT Make_suitnaturedesc(SALT311.StrType s0) := MakeFT_Invalid_AlphaChar(s0);
EXPORT InValid_suitnaturedesc(SALT311.StrType s) := InValidFT_Invalid_AlphaChar(s);
EXPORT InValidMessage_suitnaturedesc(UNSIGNED1 wh) := InValidMessageFT_Invalid_AlphaChar(wh);
 
EXPORT Make_leaddocketnumber(SALT311.StrType s0) := MakeFT_Invalid_Alpha(s0);
EXPORT InValid_leaddocketnumber(SALT311.StrType s) := InValidFT_Invalid_Alpha(s);
EXPORT InValidMessage_leaddocketnumber(UNSIGNED1 wh) := InValidMessageFT_Invalid_Alpha(wh);
 
EXPORT Make_jurisdiction(SALT311.StrType s0) := MakeFT_Invalid_AlphaChar(s0);
EXPORT InValid_jurisdiction(SALT311.StrType s) := InValidFT_Invalid_AlphaChar(s);
EXPORT InValidMessage_jurisdiction(UNSIGNED1 wh) := InValidMessageFT_Invalid_AlphaChar(wh);
 
EXPORT Make_cause(SALT311.StrType s0) := MakeFT_Invalid_Alpha(s0);
EXPORT InValid_cause(SALT311.StrType s) := InValidFT_Invalid_Alpha(s);
EXPORT InValidMessage_cause(UNSIGNED1 wh) := InValidMessageFT_Invalid_Alpha(wh);
 
EXPORT Make_statute(SALT311.StrType s0) := MakeFT_Invalid_Float(s0);
EXPORT InValid_statute(SALT311.StrType s) := InValidFT_Invalid_Float(s);
EXPORT InValidMessage_statute(UNSIGNED1 wh) := InValidMessageFT_Invalid_Float(wh);
 
EXPORT Make_ca(SALT311.StrType s0) := MakeFT_Invalid_YOrN(s0);
EXPORT InValid_ca(SALT311.StrType s) := InValidFT_Invalid_YOrN(s);
EXPORT InValidMessage_ca(UNSIGNED1 wh) := InValidMessageFT_Invalid_YOrN(wh);
 
EXPORT Make_caseclosed(SALT311.StrType s0) := MakeFT_Invalid_YOrN(s0);
EXPORT InValid_caseclosed(SALT311.StrType s) := InValidFT_Invalid_YOrN(s);
EXPORT InValidMessage_caseclosed(UNSIGNED1 wh) := InValidMessageFT_Invalid_YOrN(wh);
 
EXPORT Make_dateretrieved(SALT311.StrType s0) := MakeFT_Invalid_Date(s0);
EXPORT InValid_dateretrieved(SALT311.StrType s) := InValidFT_Invalid_Date(s);
EXPORT InValidMessage_dateretrieved(UNSIGNED1 wh) := InValidMessageFT_Invalid_Date(wh);
 
EXPORT Make_otherdocketnumber(SALT311.StrType s0) := MakeFT_Invalid_AlphaNumChar(s0);
EXPORT InValid_otherdocketnumber(SALT311.StrType s) := InValidFT_Invalid_AlphaNumChar(s);
EXPORT InValidMessage_otherdocketnumber(UNSIGNED1 wh) := InValidMessageFT_Invalid_AlphaNumChar(wh);
 
EXPORT Make_litigantname(SALT311.StrType s0) := MakeFT_Invalid_AlphaChar(s0);
EXPORT InValid_litigantname(SALT311.StrType s) := InValidFT_Invalid_AlphaChar(s);
EXPORT InValidMessage_litigantname(UNSIGNED1 wh) := InValidMessageFT_Invalid_AlphaChar(wh);
 
EXPORT Make_litigantlabel(SALT311.StrType s0) := MakeFT_Invalid_Alpha(s0);
EXPORT InValid_litigantlabel(SALT311.StrType s) := InValidFT_Invalid_Alpha(s);
EXPORT InValidMessage_litigantlabel(UNSIGNED1 wh) := InValidMessageFT_Invalid_Alpha(wh);
 
EXPORT Make_layoutcode(SALT311.StrType s0) := MakeFT_Invalid_Alpha(s0);
EXPORT InValid_layoutcode(SALT311.StrType s) := InValidFT_Invalid_Alpha(s);
EXPORT InValidMessage_layoutcode(UNSIGNED1 wh) := InValidMessageFT_Invalid_Alpha(wh);
 
EXPORT Make_terminationdate(SALT311.StrType s0) := MakeFT_Invalid_Date(s0);
EXPORT InValid_terminationdate(SALT311.StrType s) := InValidFT_Invalid_Date(s);
EXPORT InValidMessage_terminationdate(UNSIGNED1 wh) := InValidMessageFT_Invalid_Date(wh);
 
EXPORT Make_attorneyname(SALT311.StrType s0) := MakeFT_Invalid_AlphaChar(s0);
EXPORT InValid_attorneyname(SALT311.StrType s) := InValidFT_Invalid_AlphaChar(s);
EXPORT InValidMessage_attorneyname(UNSIGNED1 wh) := InValidMessageFT_Invalid_AlphaChar(wh);
 
EXPORT Make_attorneylabel(SALT311.StrType s0) := MakeFT_Invalid_AlphaChar(s0);
EXPORT InValid_attorneylabel(SALT311.StrType s) := InValidFT_Invalid_AlphaChar(s);
EXPORT InValidMessage_attorneylabel(UNSIGNED1 wh) := InValidMessageFT_Invalid_AlphaChar(wh);
 
EXPORT Make_firmname(SALT311.StrType s0) := MakeFT_Invalid_AlphaChar(s0);
EXPORT InValid_firmname(SALT311.StrType s) := InValidFT_Invalid_AlphaChar(s);
EXPORT InValidMessage_firmname(UNSIGNED1 wh) := InValidMessageFT_Invalid_AlphaChar(wh);
 
EXPORT Make_address(SALT311.StrType s0) := MakeFT_Invalid_AlphaNumChar(s0);
EXPORT InValid_address(SALT311.StrType s) := InValidFT_Invalid_AlphaNumChar(s);
EXPORT InValidMessage_address(UNSIGNED1 wh) := InValidMessageFT_Invalid_AlphaNumChar(wh);
 
EXPORT Make_city(SALT311.StrType s0) := MakeFT_Invalid_Alpha(s0);
EXPORT InValid_city(SALT311.StrType s) := InValidFT_Invalid_Alpha(s);
EXPORT InValidMessage_city(UNSIGNED1 wh) := InValidMessageFT_Invalid_Alpha(wh);
 
EXPORT Make_state(SALT311.StrType s0) := MakeFT_Invalid_State(s0);
EXPORT InValid_state(SALT311.StrType s) := InValidFT_Invalid_State(s);
EXPORT InValidMessage_state(UNSIGNED1 wh) := InValidMessageFT_Invalid_State(wh);
 
EXPORT Make_zipcode(SALT311.StrType s0) := MakeFT_Invalid_Zip(s0);
EXPORT InValid_zipcode(SALT311.StrType s) := InValidFT_Invalid_Zip(s);
EXPORT InValidMessage_zipcode(UNSIGNED1 wh) := InValidMessageFT_Invalid_Zip(wh);
 
EXPORT Make_country(SALT311.StrType s0) := MakeFT_Invalid_Alpha(s0);
EXPORT InValid_country(SALT311.StrType s) := InValidFT_Invalid_Alpha(s);
EXPORT InValidMessage_country(UNSIGNED1 wh) := InValidMessageFT_Invalid_Alpha(wh);
 
EXPORT Make_addtlinfo(SALT311.StrType s0) := s0;
EXPORT InValid_addtlinfo(SALT311.StrType s) := 0;
EXPORT InValidMessage_addtlinfo(UNSIGNED1 wh) := '';
 
EXPORT Make_termdate(SALT311.StrType s0) := MakeFT_Invalid_Date(s0);
EXPORT InValid_termdate(SALT311.StrType s) := InValidFT_Invalid_Date(s);
EXPORT InValidMessage_termdate(UNSIGNED1 wh) := InValidMessageFT_Invalid_Date(wh);
 
EXPORT Make_bdid(SALT311.StrType s0) := MakeFT_Invalid_No(s0);
EXPORT InValid_bdid(SALT311.StrType s) := InValidFT_Invalid_No(s);
EXPORT InValidMessage_bdid(UNSIGNED1 wh) := InValidMessageFT_Invalid_No(wh);
 
EXPORT Make_did(SALT311.StrType s0) := MakeFT_Invalid_No(s0);
EXPORT InValid_did(SALT311.StrType s) := InValidFT_Invalid_No(s);
EXPORT InValidMessage_did(UNSIGNED1 wh) := InValidMessageFT_Invalid_No(wh);
 
EXPORT Make_causecode(SALT311.StrType s0) := MakeFT_Invalid_No(s0);
EXPORT InValid_causecode(SALT311.StrType s) := InValidFT_Invalid_No(s);
EXPORT InValidMessage_causecode(UNSIGNED1 wh) := InValidMessageFT_Invalid_No(wh);
 
EXPORT Make_judge_title(SALT311.StrType s0) := MakeFT_Invalid_Alpha(s0);
EXPORT InValid_judge_title(SALT311.StrType s) := InValidFT_Invalid_Alpha(s);
EXPORT InValidMessage_judge_title(UNSIGNED1 wh) := InValidMessageFT_Invalid_Alpha(wh);
 
EXPORT Make_judge_fname(SALT311.StrType s0) := MakeFT_Invalid_Alpha(s0);
EXPORT InValid_judge_fname(SALT311.StrType s) := InValidFT_Invalid_Alpha(s);
EXPORT InValidMessage_judge_fname(UNSIGNED1 wh) := InValidMessageFT_Invalid_Alpha(wh);
 
EXPORT Make_judge_mname(SALT311.StrType s0) := MakeFT_Invalid_Alpha(s0);
EXPORT InValid_judge_mname(SALT311.StrType s) := InValidFT_Invalid_Alpha(s);
EXPORT InValidMessage_judge_mname(UNSIGNED1 wh) := InValidMessageFT_Invalid_Alpha(wh);
 
EXPORT Make_judge_lname(SALT311.StrType s0) := MakeFT_Invalid_Alpha(s0);
EXPORT InValid_judge_lname(SALT311.StrType s) := InValidFT_Invalid_Alpha(s);
EXPORT InValidMessage_judge_lname(UNSIGNED1 wh) := InValidMessageFT_Invalid_Alpha(wh);
 
EXPORT Make_judge_suffix(SALT311.StrType s0) := MakeFT_Invalid_Alpha(s0);
EXPORT InValid_judge_suffix(SALT311.StrType s) := InValidFT_Invalid_Alpha(s);
EXPORT InValidMessage_judge_suffix(UNSIGNED1 wh) := InValidMessageFT_Invalid_Alpha(wh);
 
EXPORT Make_judge_score(SALT311.StrType s0) := MakeFT_Invalid_No(s0);
EXPORT InValid_judge_score(SALT311.StrType s) := InValidFT_Invalid_No(s);
EXPORT InValidMessage_judge_score(UNSIGNED1 wh) := InValidMessageFT_Invalid_No(wh);
 
EXPORT Make_business_person(SALT311.StrType s0) := MakeFT_Invalid_Alpha(s0);
EXPORT InValid_business_person(SALT311.StrType s) := InValidFT_Invalid_Alpha(s);
EXPORT InValidMessage_business_person(UNSIGNED1 wh) := InValidMessageFT_Invalid_Alpha(wh);
 
EXPORT Make_debtor(SALT311.StrType s0) := MakeFT_Invalid_AlphaChar(s0);
EXPORT InValid_debtor(SALT311.StrType s) := InValidFT_Invalid_AlphaChar(s);
EXPORT InValidMessage_debtor(UNSIGNED1 wh) := InValidMessageFT_Invalid_AlphaChar(wh);
 
EXPORT Make_debtor_title(SALT311.StrType s0) := MakeFT_Invalid_Alpha(s0);
EXPORT InValid_debtor_title(SALT311.StrType s) := InValidFT_Invalid_Alpha(s);
EXPORT InValidMessage_debtor_title(UNSIGNED1 wh) := InValidMessageFT_Invalid_Alpha(wh);
 
EXPORT Make_debtor_fname(SALT311.StrType s0) := MakeFT_Invalid_Alpha(s0);
EXPORT InValid_debtor_fname(SALT311.StrType s) := InValidFT_Invalid_Alpha(s);
EXPORT InValidMessage_debtor_fname(UNSIGNED1 wh) := InValidMessageFT_Invalid_Alpha(wh);
 
EXPORT Make_debtor_mname(SALT311.StrType s0) := MakeFT_Invalid_Alpha(s0);
EXPORT InValid_debtor_mname(SALT311.StrType s) := InValidFT_Invalid_Alpha(s);
EXPORT InValidMessage_debtor_mname(UNSIGNED1 wh) := InValidMessageFT_Invalid_Alpha(wh);
 
EXPORT Make_debtor_lname(SALT311.StrType s0) := MakeFT_Invalid_Alpha(s0);
EXPORT InValid_debtor_lname(SALT311.StrType s) := InValidFT_Invalid_Alpha(s);
EXPORT InValidMessage_debtor_lname(UNSIGNED1 wh) := InValidMessageFT_Invalid_Alpha(wh);
 
EXPORT Make_debtor_suffix(SALT311.StrType s0) := MakeFT_Invalid_Alpha(s0);
EXPORT InValid_debtor_suffix(SALT311.StrType s) := InValidFT_Invalid_Alpha(s);
EXPORT InValidMessage_debtor_suffix(UNSIGNED1 wh) := InValidMessageFT_Invalid_Alpha(wh);
 
EXPORT Make_debtor_score(SALT311.StrType s0) := MakeFT_Invalid_Alpha(s0);
EXPORT InValid_debtor_score(SALT311.StrType s) := InValidFT_Invalid_Alpha(s);
EXPORT InValidMessage_debtor_score(UNSIGNED1 wh) := InValidMessageFT_Invalid_Alpha(wh);
 
EXPORT Make_attorney_title(SALT311.StrType s0) := MakeFT_Invalid_Alpha(s0);
EXPORT InValid_attorney_title(SALT311.StrType s) := InValidFT_Invalid_Alpha(s);
EXPORT InValidMessage_attorney_title(UNSIGNED1 wh) := InValidMessageFT_Invalid_Alpha(wh);
 
EXPORT Make_attorney_fname(SALT311.StrType s0) := MakeFT_Invalid_Alpha(s0);
EXPORT InValid_attorney_fname(SALT311.StrType s) := InValidFT_Invalid_Alpha(s);
EXPORT InValidMessage_attorney_fname(UNSIGNED1 wh) := InValidMessageFT_Invalid_Alpha(wh);
 
EXPORT Make_attorney_mname(SALT311.StrType s0) := MakeFT_Invalid_Alpha(s0);
EXPORT InValid_attorney_mname(SALT311.StrType s) := InValidFT_Invalid_Alpha(s);
EXPORT InValidMessage_attorney_mname(UNSIGNED1 wh) := InValidMessageFT_Invalid_Alpha(wh);
 
EXPORT Make_attorney_lname(SALT311.StrType s0) := MakeFT_Invalid_Alpha(s0);
EXPORT InValid_attorney_lname(SALT311.StrType s) := InValidFT_Invalid_Alpha(s);
EXPORT InValidMessage_attorney_lname(UNSIGNED1 wh) := InValidMessageFT_Invalid_Alpha(wh);
 
EXPORT Make_attorney_suffix(SALT311.StrType s0) := MakeFT_Invalid_Alpha(s0);
EXPORT InValid_attorney_suffix(SALT311.StrType s) := InValidFT_Invalid_Alpha(s);
EXPORT InValidMessage_attorney_suffix(UNSIGNED1 wh) := InValidMessageFT_Invalid_Alpha(wh);
 
EXPORT Make_attorney_score(SALT311.StrType s0) := MakeFT_Invalid_No(s0);
EXPORT InValid_attorney_score(SALT311.StrType s) := InValidFT_Invalid_No(s);
EXPORT InValidMessage_attorney_score(UNSIGNED1 wh) := InValidMessageFT_Invalid_No(wh);
 
EXPORT Make_prim_range(SALT311.StrType s0) := MakeFT_Invalid_No(s0);
EXPORT InValid_prim_range(SALT311.StrType s) := InValidFT_Invalid_No(s);
EXPORT InValidMessage_prim_range(UNSIGNED1 wh) := InValidMessageFT_Invalid_No(wh);
 
EXPORT Make_predir(SALT311.StrType s0) := MakeFT_Invalid_Alpha(s0);
EXPORT InValid_predir(SALT311.StrType s) := InValidFT_Invalid_Alpha(s);
EXPORT InValidMessage_predir(UNSIGNED1 wh) := InValidMessageFT_Invalid_Alpha(wh);
 
EXPORT Make_prim_name(SALT311.StrType s0) := MakeFT_Invalid_AlphaNum(s0);
EXPORT InValid_prim_name(SALT311.StrType s) := InValidFT_Invalid_AlphaNum(s);
EXPORT InValidMessage_prim_name(UNSIGNED1 wh) := InValidMessageFT_Invalid_AlphaNum(wh);
 
EXPORT Make_addr_suffix(SALT311.StrType s0) := MakeFT_Invalid_Alpha(s0);
EXPORT InValid_addr_suffix(SALT311.StrType s) := InValidFT_Invalid_Alpha(s);
EXPORT InValidMessage_addr_suffix(UNSIGNED1 wh) := InValidMessageFT_Invalid_Alpha(wh);
 
EXPORT Make_postdir(SALT311.StrType s0) := MakeFT_Invalid_Alpha(s0);
EXPORT InValid_postdir(SALT311.StrType s) := InValidFT_Invalid_Alpha(s);
EXPORT InValidMessage_postdir(UNSIGNED1 wh) := InValidMessageFT_Invalid_Alpha(wh);
 
EXPORT Make_unit_desig(SALT311.StrType s0) := MakeFT_Invalid_AlphaChar(s0);
EXPORT InValid_unit_desig(SALT311.StrType s) := InValidFT_Invalid_AlphaChar(s);
EXPORT InValidMessage_unit_desig(UNSIGNED1 wh) := InValidMessageFT_Invalid_AlphaChar(wh);
 
EXPORT Make_sec_range(SALT311.StrType s0) := MakeFT_Invalid_AlphaNum(s0);
EXPORT InValid_sec_range(SALT311.StrType s) := InValidFT_Invalid_AlphaNum(s);
EXPORT InValidMessage_sec_range(UNSIGNED1 wh) := InValidMessageFT_Invalid_AlphaNum(wh);
 
EXPORT Make_p_city_name(SALT311.StrType s0) := MakeFT_Invalid_Alpha(s0);
EXPORT InValid_p_city_name(SALT311.StrType s) := InValidFT_Invalid_Alpha(s);
EXPORT InValidMessage_p_city_name(UNSIGNED1 wh) := InValidMessageFT_Invalid_Alpha(wh);
 
EXPORT Make_v_city_name(SALT311.StrType s0) := MakeFT_Invalid_Alpha(s0);
EXPORT InValid_v_city_name(SALT311.StrType s) := InValidFT_Invalid_Alpha(s);
EXPORT InValidMessage_v_city_name(UNSIGNED1 wh) := InValidMessageFT_Invalid_Alpha(wh);
 
EXPORT Make_st(SALT311.StrType s0) := MakeFT_Invalid_State(s0);
EXPORT InValid_st(SALT311.StrType s) := InValidFT_Invalid_State(s);
EXPORT InValidMessage_st(UNSIGNED1 wh) := InValidMessageFT_Invalid_State(wh);
 
EXPORT Make_zip(SALT311.StrType s0) := MakeFT_Invalid_Zip(s0);
EXPORT InValid_zip(SALT311.StrType s) := InValidFT_Invalid_Zip(s);
EXPORT InValidMessage_zip(UNSIGNED1 wh) := InValidMessageFT_Invalid_Zip(wh);
 
EXPORT Make_zip4(SALT311.StrType s0) := MakeFT_Invalid_No(s0);
EXPORT InValid_zip4(SALT311.StrType s) := InValidFT_Invalid_No(s);
EXPORT InValidMessage_zip4(UNSIGNED1 wh) := InValidMessageFT_Invalid_No(wh);
 
EXPORT Make_cart(SALT311.StrType s0) := MakeFT_Invalid_AlphaNum(s0);
EXPORT InValid_cart(SALT311.StrType s) := InValidFT_Invalid_AlphaNum(s);
EXPORT InValidMessage_cart(UNSIGNED1 wh) := InValidMessageFT_Invalid_AlphaNum(wh);
 
EXPORT Make_cr_sort_sz(SALT311.StrType s0) := MakeFT_Invalid_Alpha(s0);
EXPORT InValid_cr_sort_sz(SALT311.StrType s) := InValidFT_Invalid_Alpha(s);
EXPORT InValidMessage_cr_sort_sz(UNSIGNED1 wh) := InValidMessageFT_Invalid_Alpha(wh);
 
EXPORT Make_lot(SALT311.StrType s0) := MakeFT_Invalid_No(s0);
EXPORT InValid_lot(SALT311.StrType s) := InValidFT_Invalid_No(s);
EXPORT InValidMessage_lot(UNSIGNED1 wh) := InValidMessageFT_Invalid_No(wh);
 
EXPORT Make_lot_order(SALT311.StrType s0) := MakeFT_Invalid_Alpha(s0);
EXPORT InValid_lot_order(SALT311.StrType s) := InValidFT_Invalid_Alpha(s);
EXPORT InValidMessage_lot_order(UNSIGNED1 wh) := InValidMessageFT_Invalid_Alpha(wh);
 
EXPORT Make_dbpc(SALT311.StrType s0) := MakeFT_Invalid_No(s0);
EXPORT InValid_dbpc(SALT311.StrType s) := InValidFT_Invalid_No(s);
EXPORT InValidMessage_dbpc(UNSIGNED1 wh) := InValidMessageFT_Invalid_No(wh);
 
EXPORT Make_chk_digit(SALT311.StrType s0) := MakeFT_Invalid_No(s0);
EXPORT InValid_chk_digit(SALT311.StrType s) := InValidFT_Invalid_No(s);
EXPORT InValidMessage_chk_digit(UNSIGNED1 wh) := InValidMessageFT_Invalid_No(wh);
 
EXPORT Make_rec_type(SALT311.StrType s0) := MakeFT_Invalid_Alpha(s0);
EXPORT InValid_rec_type(SALT311.StrType s) := InValidFT_Invalid_Alpha(s);
EXPORT InValidMessage_rec_type(UNSIGNED1 wh) := InValidMessageFT_Invalid_Alpha(wh);
 
EXPORT Make_fips_state(SALT311.StrType s0) := MakeFT_Invalid_No(s0);
EXPORT InValid_fips_state(SALT311.StrType s) := InValidFT_Invalid_No(s);
EXPORT InValidMessage_fips_state(UNSIGNED1 wh) := InValidMessageFT_Invalid_No(wh);
 
EXPORT Make_fips_county(SALT311.StrType s0) := MakeFT_Invalid_No(s0);
EXPORT InValid_fips_county(SALT311.StrType s) := InValidFT_Invalid_No(s);
EXPORT InValidMessage_fips_county(UNSIGNED1 wh) := InValidMessageFT_Invalid_No(wh);
 
EXPORT Make_geo_lat(SALT311.StrType s0) := MakeFT_Invalid_Float(s0);
EXPORT InValid_geo_lat(SALT311.StrType s) := InValidFT_Invalid_Float(s);
EXPORT InValidMessage_geo_lat(UNSIGNED1 wh) := InValidMessageFT_Invalid_Float(wh);
 
EXPORT Make_geo_long(SALT311.StrType s0) := MakeFT_Invalid_Float(s0);
EXPORT InValid_geo_long(SALT311.StrType s) := InValidFT_Invalid_Float(s);
EXPORT InValidMessage_geo_long(UNSIGNED1 wh) := InValidMessageFT_Invalid_Float(wh);
 
EXPORT Make_msa(SALT311.StrType s0) := MakeFT_Invalid_No(s0);
EXPORT InValid_msa(SALT311.StrType s) := InValidFT_Invalid_No(s);
EXPORT InValidMessage_msa(UNSIGNED1 wh) := InValidMessageFT_Invalid_No(wh);
 
EXPORT Make_geo_blk(SALT311.StrType s0) := MakeFT_Invalid_No(s0);
EXPORT InValid_geo_blk(SALT311.StrType s) := InValidFT_Invalid_No(s);
EXPORT InValidMessage_geo_blk(UNSIGNED1 wh) := InValidMessageFT_Invalid_No(wh);
 
EXPORT Make_geo_match(SALT311.StrType s0) := MakeFT_Invalid_No(s0);
EXPORT InValid_geo_match(SALT311.StrType s) := InValidFT_Invalid_No(s);
EXPORT InValidMessage_geo_match(UNSIGNED1 wh) := InValidMessageFT_Invalid_No(wh);
 
EXPORT Make_err_stat(SALT311.StrType s0) := MakeFT_Invalid_AlphaNum(s0);
EXPORT InValid_err_stat(SALT311.StrType s) := InValidFT_Invalid_AlphaNum(s);
EXPORT InValidMessage_err_stat(UNSIGNED1 wh) := InValidMessageFT_Invalid_AlphaNum(wh);
 
// This macro will compute and count field level differences based upon a pivot expression
export MAC_CountDifferencesByPivot(in_left,in_right,pivot_exp,bad_pivots,out_counts) := MACRO
  IMPORT SALT311,Scrubs_LitigiousDebtor;
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
    BOOLEAN Diff_record_type;
    BOOLEAN Diff_recid;
    BOOLEAN Diff_courtstate;
    BOOLEAN Diff_courtid;
    BOOLEAN Diff_courtname;
    BOOLEAN Diff_docketnumber;
    BOOLEAN Diff_officename;
    BOOLEAN Diff_asofdate;
    BOOLEAN Diff_classcode;
    BOOLEAN Diff_casecaption;
    BOOLEAN Diff_datefiled;
    BOOLEAN Diff_judgetitle;
    BOOLEAN Diff_judgename;
    BOOLEAN Diff_referredtojudgetitle;
    BOOLEAN Diff_referredtojudge;
    BOOLEAN Diff_jurydemand;
    BOOLEAN Diff_demandamount;
    BOOLEAN Diff_suitnaturecode;
    BOOLEAN Diff_suitnaturedesc;
    BOOLEAN Diff_leaddocketnumber;
    BOOLEAN Diff_jurisdiction;
    BOOLEAN Diff_cause;
    BOOLEAN Diff_statute;
    BOOLEAN Diff_ca;
    BOOLEAN Diff_caseclosed;
    BOOLEAN Diff_dateretrieved;
    BOOLEAN Diff_otherdocketnumber;
    BOOLEAN Diff_litigantname;
    BOOLEAN Diff_litigantlabel;
    BOOLEAN Diff_layoutcode;
    BOOLEAN Diff_terminationdate;
    BOOLEAN Diff_attorneyname;
    BOOLEAN Diff_attorneylabel;
    BOOLEAN Diff_firmname;
    BOOLEAN Diff_address;
    BOOLEAN Diff_city;
    BOOLEAN Diff_state;
    BOOLEAN Diff_zipcode;
    BOOLEAN Diff_country;
    BOOLEAN Diff_addtlinfo;
    BOOLEAN Diff_termdate;
    BOOLEAN Diff_bdid;
    BOOLEAN Diff_did;
    BOOLEAN Diff_causecode;
    BOOLEAN Diff_judge_title;
    BOOLEAN Diff_judge_fname;
    BOOLEAN Diff_judge_mname;
    BOOLEAN Diff_judge_lname;
    BOOLEAN Diff_judge_suffix;
    BOOLEAN Diff_judge_score;
    BOOLEAN Diff_business_person;
    BOOLEAN Diff_debtor;
    BOOLEAN Diff_debtor_title;
    BOOLEAN Diff_debtor_fname;
    BOOLEAN Diff_debtor_mname;
    BOOLEAN Diff_debtor_lname;
    BOOLEAN Diff_debtor_suffix;
    BOOLEAN Diff_debtor_score;
    BOOLEAN Diff_attorney_title;
    BOOLEAN Diff_attorney_fname;
    BOOLEAN Diff_attorney_mname;
    BOOLEAN Diff_attorney_lname;
    BOOLEAN Diff_attorney_suffix;
    BOOLEAN Diff_attorney_score;
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
    UNSIGNED Num_Diffs;
    SALT311.StrType Val {MAXLENGTH(1024)};
  END;
#uniquename(fd)
  %dl% %fd%(in_left le,in_right ri) := TRANSFORM
    SELF.Diff_dt_first_seen := le.dt_first_seen <> ri.dt_first_seen;
    SELF.Diff_dt_last_seen := le.dt_last_seen <> ri.dt_last_seen;
    SELF.Diff_dt_vendor_first_reported := le.dt_vendor_first_reported <> ri.dt_vendor_first_reported;
    SELF.Diff_dt_vendor_last_reported := le.dt_vendor_last_reported <> ri.dt_vendor_last_reported;
    SELF.Diff_record_type := le.record_type <> ri.record_type;
    SELF.Diff_recid := le.recid <> ri.recid;
    SELF.Diff_courtstate := le.courtstate <> ri.courtstate;
    SELF.Diff_courtid := le.courtid <> ri.courtid;
    SELF.Diff_courtname := le.courtname <> ri.courtname;
    SELF.Diff_docketnumber := le.docketnumber <> ri.docketnumber;
    SELF.Diff_officename := le.officename <> ri.officename;
    SELF.Diff_asofdate := le.asofdate <> ri.asofdate;
    SELF.Diff_classcode := le.classcode <> ri.classcode;
    SELF.Diff_casecaption := le.casecaption <> ri.casecaption;
    SELF.Diff_datefiled := le.datefiled <> ri.datefiled;
    SELF.Diff_judgetitle := le.judgetitle <> ri.judgetitle;
    SELF.Diff_judgename := le.judgename <> ri.judgename;
    SELF.Diff_referredtojudgetitle := le.referredtojudgetitle <> ri.referredtojudgetitle;
    SELF.Diff_referredtojudge := le.referredtojudge <> ri.referredtojudge;
    SELF.Diff_jurydemand := le.jurydemand <> ri.jurydemand;
    SELF.Diff_demandamount := le.demandamount <> ri.demandamount;
    SELF.Diff_suitnaturecode := le.suitnaturecode <> ri.suitnaturecode;
    SELF.Diff_suitnaturedesc := le.suitnaturedesc <> ri.suitnaturedesc;
    SELF.Diff_leaddocketnumber := le.leaddocketnumber <> ri.leaddocketnumber;
    SELF.Diff_jurisdiction := le.jurisdiction <> ri.jurisdiction;
    SELF.Diff_cause := le.cause <> ri.cause;
    SELF.Diff_statute := le.statute <> ri.statute;
    SELF.Diff_ca := le.ca <> ri.ca;
    SELF.Diff_caseclosed := le.caseclosed <> ri.caseclosed;
    SELF.Diff_dateretrieved := le.dateretrieved <> ri.dateretrieved;
    SELF.Diff_otherdocketnumber := le.otherdocketnumber <> ri.otherdocketnumber;
    SELF.Diff_litigantname := le.litigantname <> ri.litigantname;
    SELF.Diff_litigantlabel := le.litigantlabel <> ri.litigantlabel;
    SELF.Diff_layoutcode := le.layoutcode <> ri.layoutcode;
    SELF.Diff_terminationdate := le.terminationdate <> ri.terminationdate;
    SELF.Diff_attorneyname := le.attorneyname <> ri.attorneyname;
    SELF.Diff_attorneylabel := le.attorneylabel <> ri.attorneylabel;
    SELF.Diff_firmname := le.firmname <> ri.firmname;
    SELF.Diff_address := le.address <> ri.address;
    SELF.Diff_city := le.city <> ri.city;
    SELF.Diff_state := le.state <> ri.state;
    SELF.Diff_zipcode := le.zipcode <> ri.zipcode;
    SELF.Diff_country := le.country <> ri.country;
    SELF.Diff_addtlinfo := le.addtlinfo <> ri.addtlinfo;
    SELF.Diff_termdate := le.termdate <> ri.termdate;
    SELF.Diff_bdid := le.bdid <> ri.bdid;
    SELF.Diff_did := le.did <> ri.did;
    SELF.Diff_causecode := le.causecode <> ri.causecode;
    SELF.Diff_judge_title := le.judge_title <> ri.judge_title;
    SELF.Diff_judge_fname := le.judge_fname <> ri.judge_fname;
    SELF.Diff_judge_mname := le.judge_mname <> ri.judge_mname;
    SELF.Diff_judge_lname := le.judge_lname <> ri.judge_lname;
    SELF.Diff_judge_suffix := le.judge_suffix <> ri.judge_suffix;
    SELF.Diff_judge_score := le.judge_score <> ri.judge_score;
    SELF.Diff_business_person := le.business_person <> ri.business_person;
    SELF.Diff_debtor := le.debtor <> ri.debtor;
    SELF.Diff_debtor_title := le.debtor_title <> ri.debtor_title;
    SELF.Diff_debtor_fname := le.debtor_fname <> ri.debtor_fname;
    SELF.Diff_debtor_mname := le.debtor_mname <> ri.debtor_mname;
    SELF.Diff_debtor_lname := le.debtor_lname <> ri.debtor_lname;
    SELF.Diff_debtor_suffix := le.debtor_suffix <> ri.debtor_suffix;
    SELF.Diff_debtor_score := le.debtor_score <> ri.debtor_score;
    SELF.Diff_attorney_title := le.attorney_title <> ri.attorney_title;
    SELF.Diff_attorney_fname := le.attorney_fname <> ri.attorney_fname;
    SELF.Diff_attorney_mname := le.attorney_mname <> ri.attorney_mname;
    SELF.Diff_attorney_lname := le.attorney_lname <> ri.attorney_lname;
    SELF.Diff_attorney_suffix := le.attorney_suffix <> ri.attorney_suffix;
    SELF.Diff_attorney_score := le.attorney_score <> ri.attorney_score;
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
    SELF.Val := (SALT311.StrType)evaluate(le,pivot_exp);
    SELF.Num_Diffs := 0+ IF( SELF.Diff_dt_first_seen,1,0)+ IF( SELF.Diff_dt_last_seen,1,0)+ IF( SELF.Diff_dt_vendor_first_reported,1,0)+ IF( SELF.Diff_dt_vendor_last_reported,1,0)+ IF( SELF.Diff_record_type,1,0)+ IF( SELF.Diff_recid,1,0)+ IF( SELF.Diff_courtstate,1,0)+ IF( SELF.Diff_courtid,1,0)+ IF( SELF.Diff_courtname,1,0)+ IF( SELF.Diff_docketnumber,1,0)+ IF( SELF.Diff_officename,1,0)+ IF( SELF.Diff_asofdate,1,0)+ IF( SELF.Diff_classcode,1,0)+ IF( SELF.Diff_casecaption,1,0)+ IF( SELF.Diff_datefiled,1,0)+ IF( SELF.Diff_judgetitle,1,0)+ IF( SELF.Diff_judgename,1,0)+ IF( SELF.Diff_referredtojudgetitle,1,0)+ IF( SELF.Diff_referredtojudge,1,0)+ IF( SELF.Diff_jurydemand,1,0)+ IF( SELF.Diff_demandamount,1,0)+ IF( SELF.Diff_suitnaturecode,1,0)+ IF( SELF.Diff_suitnaturedesc,1,0)+ IF( SELF.Diff_leaddocketnumber,1,0)+ IF( SELF.Diff_jurisdiction,1,0)+ IF( SELF.Diff_cause,1,0)+ IF( SELF.Diff_statute,1,0)+ IF( SELF.Diff_ca,1,0)+ IF( SELF.Diff_caseclosed,1,0)+ IF( SELF.Diff_dateretrieved,1,0)+ IF( SELF.Diff_otherdocketnumber,1,0)+ IF( SELF.Diff_litigantname,1,0)+ IF( SELF.Diff_litigantlabel,1,0)+ IF( SELF.Diff_layoutcode,1,0)+ IF( SELF.Diff_terminationdate,1,0)+ IF( SELF.Diff_attorneyname,1,0)+ IF( SELF.Diff_attorneylabel,1,0)+ IF( SELF.Diff_firmname,1,0)+ IF( SELF.Diff_address,1,0)+ IF( SELF.Diff_city,1,0)+ IF( SELF.Diff_state,1,0)+ IF( SELF.Diff_zipcode,1,0)+ IF( SELF.Diff_country,1,0)+ IF( SELF.Diff_addtlinfo,1,0)+ IF( SELF.Diff_termdate,1,0)+ IF( SELF.Diff_bdid,1,0)+ IF( SELF.Diff_did,1,0)+ IF( SELF.Diff_causecode,1,0)+ IF( SELF.Diff_judge_title,1,0)+ IF( SELF.Diff_judge_fname,1,0)+ IF( SELF.Diff_judge_mname,1,0)+ IF( SELF.Diff_judge_lname,1,0)+ IF( SELF.Diff_judge_suffix,1,0)+ IF( SELF.Diff_judge_score,1,0)+ IF( SELF.Diff_business_person,1,0)+ IF( SELF.Diff_debtor,1,0)+ IF( SELF.Diff_debtor_title,1,0)+ IF( SELF.Diff_debtor_fname,1,0)+ IF( SELF.Diff_debtor_mname,1,0)+ IF( SELF.Diff_debtor_lname,1,0)+ IF( SELF.Diff_debtor_suffix,1,0)+ IF( SELF.Diff_debtor_score,1,0)+ IF( SELF.Diff_attorney_title,1,0)+ IF( SELF.Diff_attorney_fname,1,0)+ IF( SELF.Diff_attorney_mname,1,0)+ IF( SELF.Diff_attorney_lname,1,0)+ IF( SELF.Diff_attorney_suffix,1,0)+ IF( SELF.Diff_attorney_score,1,0)+ IF( SELF.Diff_prim_range,1,0)+ IF( SELF.Diff_predir,1,0)+ IF( SELF.Diff_prim_name,1,0)+ IF( SELF.Diff_addr_suffix,1,0)+ IF( SELF.Diff_postdir,1,0)+ IF( SELF.Diff_unit_desig,1,0)+ IF( SELF.Diff_sec_range,1,0)+ IF( SELF.Diff_p_city_name,1,0)+ IF( SELF.Diff_v_city_name,1,0)+ IF( SELF.Diff_st,1,0)+ IF( SELF.Diff_zip,1,0)+ IF( SELF.Diff_zip4,1,0)+ IF( SELF.Diff_cart,1,0)+ IF( SELF.Diff_cr_sort_sz,1,0)+ IF( SELF.Diff_lot,1,0)+ IF( SELF.Diff_lot_order,1,0)+ IF( SELF.Diff_dbpc,1,0)+ IF( SELF.Diff_chk_digit,1,0)+ IF( SELF.Diff_rec_type,1,0)+ IF( SELF.Diff_fips_state,1,0)+ IF( SELF.Diff_fips_county,1,0)+ IF( SELF.Diff_geo_lat,1,0)+ IF( SELF.Diff_geo_long,1,0)+ IF( SELF.Diff_msa,1,0)+ IF( SELF.Diff_geo_blk,1,0)+ IF( SELF.Diff_geo_match,1,0)+ IF( SELF.Diff_err_stat,1,0);
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
    Count_Diff_record_type := COUNT(GROUP,%Closest%.Diff_record_type);
    Count_Diff_recid := COUNT(GROUP,%Closest%.Diff_recid);
    Count_Diff_courtstate := COUNT(GROUP,%Closest%.Diff_courtstate);
    Count_Diff_courtid := COUNT(GROUP,%Closest%.Diff_courtid);
    Count_Diff_courtname := COUNT(GROUP,%Closest%.Diff_courtname);
    Count_Diff_docketnumber := COUNT(GROUP,%Closest%.Diff_docketnumber);
    Count_Diff_officename := COUNT(GROUP,%Closest%.Diff_officename);
    Count_Diff_asofdate := COUNT(GROUP,%Closest%.Diff_asofdate);
    Count_Diff_classcode := COUNT(GROUP,%Closest%.Diff_classcode);
    Count_Diff_casecaption := COUNT(GROUP,%Closest%.Diff_casecaption);
    Count_Diff_datefiled := COUNT(GROUP,%Closest%.Diff_datefiled);
    Count_Diff_judgetitle := COUNT(GROUP,%Closest%.Diff_judgetitle);
    Count_Diff_judgename := COUNT(GROUP,%Closest%.Diff_judgename);
    Count_Diff_referredtojudgetitle := COUNT(GROUP,%Closest%.Diff_referredtojudgetitle);
    Count_Diff_referredtojudge := COUNT(GROUP,%Closest%.Diff_referredtojudge);
    Count_Diff_jurydemand := COUNT(GROUP,%Closest%.Diff_jurydemand);
    Count_Diff_demandamount := COUNT(GROUP,%Closest%.Diff_demandamount);
    Count_Diff_suitnaturecode := COUNT(GROUP,%Closest%.Diff_suitnaturecode);
    Count_Diff_suitnaturedesc := COUNT(GROUP,%Closest%.Diff_suitnaturedesc);
    Count_Diff_leaddocketnumber := COUNT(GROUP,%Closest%.Diff_leaddocketnumber);
    Count_Diff_jurisdiction := COUNT(GROUP,%Closest%.Diff_jurisdiction);
    Count_Diff_cause := COUNT(GROUP,%Closest%.Diff_cause);
    Count_Diff_statute := COUNT(GROUP,%Closest%.Diff_statute);
    Count_Diff_ca := COUNT(GROUP,%Closest%.Diff_ca);
    Count_Diff_caseclosed := COUNT(GROUP,%Closest%.Diff_caseclosed);
    Count_Diff_dateretrieved := COUNT(GROUP,%Closest%.Diff_dateretrieved);
    Count_Diff_otherdocketnumber := COUNT(GROUP,%Closest%.Diff_otherdocketnumber);
    Count_Diff_litigantname := COUNT(GROUP,%Closest%.Diff_litigantname);
    Count_Diff_litigantlabel := COUNT(GROUP,%Closest%.Diff_litigantlabel);
    Count_Diff_layoutcode := COUNT(GROUP,%Closest%.Diff_layoutcode);
    Count_Diff_terminationdate := COUNT(GROUP,%Closest%.Diff_terminationdate);
    Count_Diff_attorneyname := COUNT(GROUP,%Closest%.Diff_attorneyname);
    Count_Diff_attorneylabel := COUNT(GROUP,%Closest%.Diff_attorneylabel);
    Count_Diff_firmname := COUNT(GROUP,%Closest%.Diff_firmname);
    Count_Diff_address := COUNT(GROUP,%Closest%.Diff_address);
    Count_Diff_city := COUNT(GROUP,%Closest%.Diff_city);
    Count_Diff_state := COUNT(GROUP,%Closest%.Diff_state);
    Count_Diff_zipcode := COUNT(GROUP,%Closest%.Diff_zipcode);
    Count_Diff_country := COUNT(GROUP,%Closest%.Diff_country);
    Count_Diff_addtlinfo := COUNT(GROUP,%Closest%.Diff_addtlinfo);
    Count_Diff_termdate := COUNT(GROUP,%Closest%.Diff_termdate);
    Count_Diff_bdid := COUNT(GROUP,%Closest%.Diff_bdid);
    Count_Diff_did := COUNT(GROUP,%Closest%.Diff_did);
    Count_Diff_causecode := COUNT(GROUP,%Closest%.Diff_causecode);
    Count_Diff_judge_title := COUNT(GROUP,%Closest%.Diff_judge_title);
    Count_Diff_judge_fname := COUNT(GROUP,%Closest%.Diff_judge_fname);
    Count_Diff_judge_mname := COUNT(GROUP,%Closest%.Diff_judge_mname);
    Count_Diff_judge_lname := COUNT(GROUP,%Closest%.Diff_judge_lname);
    Count_Diff_judge_suffix := COUNT(GROUP,%Closest%.Diff_judge_suffix);
    Count_Diff_judge_score := COUNT(GROUP,%Closest%.Diff_judge_score);
    Count_Diff_business_person := COUNT(GROUP,%Closest%.Diff_business_person);
    Count_Diff_debtor := COUNT(GROUP,%Closest%.Diff_debtor);
    Count_Diff_debtor_title := COUNT(GROUP,%Closest%.Diff_debtor_title);
    Count_Diff_debtor_fname := COUNT(GROUP,%Closest%.Diff_debtor_fname);
    Count_Diff_debtor_mname := COUNT(GROUP,%Closest%.Diff_debtor_mname);
    Count_Diff_debtor_lname := COUNT(GROUP,%Closest%.Diff_debtor_lname);
    Count_Diff_debtor_suffix := COUNT(GROUP,%Closest%.Diff_debtor_suffix);
    Count_Diff_debtor_score := COUNT(GROUP,%Closest%.Diff_debtor_score);
    Count_Diff_attorney_title := COUNT(GROUP,%Closest%.Diff_attorney_title);
    Count_Diff_attorney_fname := COUNT(GROUP,%Closest%.Diff_attorney_fname);
    Count_Diff_attorney_mname := COUNT(GROUP,%Closest%.Diff_attorney_mname);
    Count_Diff_attorney_lname := COUNT(GROUP,%Closest%.Diff_attorney_lname);
    Count_Diff_attorney_suffix := COUNT(GROUP,%Closest%.Diff_attorney_suffix);
    Count_Diff_attorney_score := COUNT(GROUP,%Closest%.Diff_attorney_score);
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
  END;
  out_counts := table(%Closest%,%AggRec%,true);
ENDMACRO;
END;
