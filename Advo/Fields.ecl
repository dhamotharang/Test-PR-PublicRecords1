IMPORT ut,SALT30;
EXPORT Fields := MODULE
// Processing for each FieldType
EXPORT SALT30.StrType FieldTypeName(UNSIGNED2 i) := CHOOSE(i,'invalid_street','invalid_prepostdir','invalid_num','invalid_alpha','invalid_AddrUsg','invalid_zip','invalid_route_num','invalid_SupDate','invalid_Dates','invalid_Vacdate','invalid_cda','invalid_ResBusInd','invalid_addr_type','invalid_addrtype','invalid_YN','invalid_YNE','invalid_AddrStyleFlag','invalid_YNC','invalid_RTC');
EXPORT FieldTypeNum(SALT30.StrType fn) := CASE(fn,'invalid_street' => 1,'invalid_prepostdir' => 2,'invalid_num' => 3,'invalid_alpha' => 4,'invalid_AddrUsg' => 5,'invalid_zip' => 6,'invalid_route_num' => 7,'invalid_SupDate' => 8,'invalid_Dates' => 9,'invalid_Vacdate' => 10,'invalid_cda' => 11,'invalid_ResBusInd' => 12,'invalid_addr_type' => 13,'invalid_addrtype' => 14,'invalid_YN' => 15,'invalid_YNE' => 16,'invalid_AddrStyleFlag' => 17,'invalid_YNC' => 18,'invalid_RTC' => 19,0);
EXPORT MakeFT_invalid_street(SALT30.StrType s0) := FUNCTION
  s1 := SALT30.stringfilter(s0,'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789 /-.'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_street(SALT30.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT30.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789 /-.'))),~(LENGTH(TRIM(s)) >= 0));
EXPORT InValidMessageFT_invalid_street(UNSIGNED1 wh) := CHOOSE(wh,SALT30.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789 /-.'),SALT30.HygieneErrors.NotLength('0..'),SALT30.HygieneErrors.Good);
EXPORT MakeFT_invalid_prepostdir(SALT30.StrType s0) := FUNCTION
  s1 := SALT30.stringfilter(s0,'NEWS'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_prepostdir(SALT30.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT30.StringFilter(s,'NEWS'))),~(LENGTH(TRIM(s)) = 0 OR LENGTH(TRIM(s)) = 1 OR LENGTH(TRIM(s)) = 2));
EXPORT InValidMessageFT_invalid_prepostdir(UNSIGNED1 wh) := CHOOSE(wh,SALT30.HygieneErrors.NotInChars('NEWS'),SALT30.HygieneErrors.NotLength('0,1,2'),SALT30.HygieneErrors.Good);
EXPORT MakeFT_invalid_num(SALT30.StrType s0) := FUNCTION
  s1 := SALT30.stringfilter(s0,'0123456789'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_num(SALT30.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT30.StringFilter(s,'0123456789'))),~(LENGTH(TRIM(s)) >= 0));
EXPORT InValidMessageFT_invalid_num(UNSIGNED1 wh) := CHOOSE(wh,SALT30.HygieneErrors.NotInChars('0123456789'),SALT30.HygieneErrors.NotLength('0..'),SALT30.HygieneErrors.Good);
EXPORT MakeFT_invalid_alpha(SALT30.StrType s0) := FUNCTION
  s1 := SALT30.stringfilter(s0,'ABCDEFGHIJKLMNOPQRSTUVWXYZ '); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_alpha(SALT30.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT30.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZ '))),~(LENGTH(TRIM(s)) >= 0));
EXPORT InValidMessageFT_invalid_alpha(UNSIGNED1 wh) := CHOOSE(wh,SALT30.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWXYZ '),SALT30.HygieneErrors.NotLength('0..'),SALT30.HygieneErrors.Good);
EXPORT MakeFT_invalid_AddrUsg(SALT30.StrType s0) := FUNCTION
  s1 := SALT30.stringfilter(s0,'ABCDEFGHSTUV'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_AddrUsg(SALT30.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT30.StringFilter(s,'ABCDEFGHSTUV'))),~(LENGTH(TRIM(s)) = 1));
EXPORT InValidMessageFT_invalid_AddrUsg(UNSIGNED1 wh) := CHOOSE(wh,SALT30.HygieneErrors.NotInChars('ABCDEFGHSTUV'),SALT30.HygieneErrors.NotLength('1'),SALT30.HygieneErrors.Good);
EXPORT MakeFT_invalid_zip(SALT30.StrType s0) := FUNCTION
  s1 := SALT30.stringfilter(s0,'0123456789'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_zip(SALT30.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT30.StringFilter(s,'0123456789'))),~(LENGTH(TRIM(s)) = 0 OR LENGTH(TRIM(s)) = 4 OR LENGTH(TRIM(s)) = 5));
EXPORT InValidMessageFT_invalid_zip(UNSIGNED1 wh) := CHOOSE(wh,SALT30.HygieneErrors.NotInChars('0123456789'),SALT30.HygieneErrors.NotLength('0,4,5'),SALT30.HygieneErrors.Good);
EXPORT MakeFT_invalid_route_num(SALT30.StrType s0) := FUNCTION
  s1 := SALT30.stringfilter(s0,'0123456789BHGRC'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_route_num(SALT30.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT30.StringFilter(s,'0123456789BHGRC'))),~(LENGTH(TRIM(s)) = 4));
EXPORT InValidMessageFT_invalid_route_num(UNSIGNED1 wh) := CHOOSE(wh,SALT30.HygieneErrors.NotInChars('0123456789BHGRC'),SALT30.HygieneErrors.NotLength('4'),SALT30.HygieneErrors.Good);
EXPORT MakeFT_invalid_SupDate(SALT30.StrType s0) := FUNCTION
  s1 := SALT30.stringfilter(s0,'0123456789/'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_SupDate(SALT30.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT30.StringFilter(s,'0123456789/'))),~(LENGTH(TRIM(s)) = 0 OR LENGTH(TRIM(s)) = 5));
EXPORT InValidMessageFT_invalid_SupDate(UNSIGNED1 wh) := CHOOSE(wh,SALT30.HygieneErrors.NotInChars('0123456789/'),SALT30.HygieneErrors.NotLength('0,5'),SALT30.HygieneErrors.Good);
EXPORT MakeFT_invalid_Dates(SALT30.StrType s0) := FUNCTION
  s1 := SALT30.stringfilter(s0,'0123456789-'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_Dates(SALT30.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT30.StringFilter(s,'0123456789-'))),~(LENGTH(TRIM(s)) = 0 OR LENGTH(TRIM(s)) = 10));
EXPORT InValidMessageFT_invalid_Dates(UNSIGNED1 wh) := CHOOSE(wh,SALT30.HygieneErrors.NotInChars('0123456789-'),SALT30.HygieneErrors.NotLength('0,10'),SALT30.HygieneErrors.Good);
EXPORT MakeFT_invalid_Vacdate(SALT30.StrType s0) := FUNCTION
  s1 := SALT30.stringfilter(s0,'0123456789'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_Vacdate(SALT30.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT30.StringFilter(s,'0123456789'))),~(LENGTH(TRIM(s)) = 0 OR LENGTH(TRIM(s)) = 1 OR LENGTH(TRIM(s)) = 2 OR LENGTH(TRIM(s)) = 8));
EXPORT InValidMessageFT_invalid_Vacdate(UNSIGNED1 wh) := CHOOSE(wh,SALT30.HygieneErrors.NotInChars('0123456789'),SALT30.HygieneErrors.NotLength('0,1,2,8'),SALT30.HygieneErrors.Good);
EXPORT MakeFT_invalid_cda(SALT30.StrType s0) := FUNCTION
  s1 := SALT30.stringfilter(s0,'0123456789LA'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_cda(SALT30.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT30.StringFilter(s,'0123456789LA'))),~(LENGTH(TRIM(s)) = 1 OR LENGTH(TRIM(s)) = 2));
EXPORT InValidMessageFT_invalid_cda(UNSIGNED1 wh) := CHOOSE(wh,SALT30.HygieneErrors.NotInChars('0123456789LA'),SALT30.HygieneErrors.NotLength('1,2'),SALT30.HygieneErrors.Good);
EXPORT MakeFT_invalid_ResBusInd(SALT30.StrType s0) := FUNCTION
  s1 := SALT30.stringfilter(s0,'ABCD'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_ResBusInd(SALT30.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT30.StringFilter(s,'ABCD'))),~(LENGTH(TRIM(s)) = 0 OR LENGTH(TRIM(s)) = 1));
EXPORT InValidMessageFT_invalid_ResBusInd(UNSIGNED1 wh) := CHOOSE(wh,SALT30.HygieneErrors.NotInChars('ABCD'),SALT30.HygieneErrors.NotLength('0,1'),SALT30.HygieneErrors.Good);
EXPORT MakeFT_invalid_addr_type(SALT30.StrType s0) := FUNCTION
  s1 := SALT30.stringfilter(s0,'0129'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_addr_type(SALT30.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT30.StringFilter(s,'0129'))),~(LENGTH(TRIM(s)) = 0 OR LENGTH(TRIM(s)) = 1));
EXPORT InValidMessageFT_invalid_addr_type(UNSIGNED1 wh) := CHOOSE(wh,SALT30.HygieneErrors.NotInChars('0129'),SALT30.HygieneErrors.NotLength('0,1'),SALT30.HygieneErrors.Good);
EXPORT MakeFT_invalid_addrtype(SALT30.StrType s0) := FUNCTION
  s1 := SALT30.stringfilter(s0,'A'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_addrtype(SALT30.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT30.StringFilter(s,'A'))),~(LENGTH(TRIM(s)) = 0 OR LENGTH(TRIM(s)) = 1));
EXPORT InValidMessageFT_invalid_addrtype(UNSIGNED1 wh) := CHOOSE(wh,SALT30.HygieneErrors.NotInChars('A'),SALT30.HygieneErrors.NotLength('0,1'),SALT30.HygieneErrors.Good);
EXPORT MakeFT_invalid_YN(SALT30.StrType s0) := FUNCTION
  s1 := SALT30.stringfilter(s0,'YN'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_YN(SALT30.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT30.StringFilter(s,'YN'))),~(LENGTH(TRIM(s)) = 0 OR LENGTH(TRIM(s)) = 1));
EXPORT InValidMessageFT_invalid_YN(UNSIGNED1 wh) := CHOOSE(wh,SALT30.HygieneErrors.NotInChars('YN'),SALT30.HygieneErrors.NotLength('0,1'),SALT30.HygieneErrors.Good);
EXPORT MakeFT_invalid_YNE(SALT30.StrType s0) := FUNCTION
  s1 := SALT30.stringfilter(s0,'YNE'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_YNE(SALT30.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT30.StringFilter(s,'YNE'))),~(LENGTH(TRIM(s)) = 0 OR LENGTH(TRIM(s)) = 1));
EXPORT InValidMessageFT_invalid_YNE(UNSIGNED1 wh) := CHOOSE(wh,SALT30.HygieneErrors.NotInChars('YNE'),SALT30.HygieneErrors.NotLength('0,1'),SALT30.HygieneErrors.Good);
EXPORT MakeFT_invalid_AddrStyleFlag(SALT30.StrType s0) := FUNCTION
  s1 := SALT30.stringfilter(s0,'CS'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_AddrStyleFlag(SALT30.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT30.StringFilter(s,'CS'))),~(LENGTH(TRIM(s)) = 0 OR LENGTH(TRIM(s)) = 1));
EXPORT InValidMessageFT_invalid_AddrStyleFlag(UNSIGNED1 wh) := CHOOSE(wh,SALT30.HygieneErrors.NotInChars('CS'),SALT30.HygieneErrors.NotLength('0,1'),SALT30.HygieneErrors.Good);
EXPORT MakeFT_invalid_YNC(SALT30.StrType s0) := FUNCTION
  s1 := SALT30.stringfilter(s0,'YNC'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_YNC(SALT30.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT30.StringFilter(s,'YNC'))),~(LENGTH(TRIM(s)) = 0 OR LENGTH(TRIM(s)) = 1));
EXPORT InValidMessageFT_invalid_YNC(UNSIGNED1 wh) := CHOOSE(wh,SALT30.HygieneErrors.NotInChars('YNC'),SALT30.HygieneErrors.NotLength('0,1'),SALT30.HygieneErrors.Good);
EXPORT MakeFT_invalid_RTC(SALT30.StrType s0) := FUNCTION
  s1 := SALT30.stringfilter(s0,'SHPR'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_RTC(SALT30.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT30.StringFilter(s,'SHPR'))),~(LENGTH(TRIM(s)) = 0 OR LENGTH(TRIM(s)) = 1));
EXPORT InValidMessageFT_invalid_RTC(UNSIGNED1 wh) := CHOOSE(wh,SALT30.HygieneErrors.NotInChars('SHPR'),SALT30.HygieneErrors.NotLength('0,1'),SALT30.HygieneErrors.Good);
EXPORT SALT30.StrType FieldName(UNSIGNED2 i) := CHOOSE(i,'ZIP_5','Route_Num','ZIP_4','WALK_Sequence','STREET_NUM','STREET_PRE_DIRectional','STREET_NAME','STREET_POST_DIRectional','STREET_SUFFIX','Secondary_Unit_Designator','Secondary_Unit_Number','Address_Vacancy_Indicator','Throw_Back_Indicator','Seasonal_Delivery_Indicator','Seasonal_Start_Suppression_Date','Seasonal_End_Suppression_Date','DND_Indicator','College_Indicator','College_Start_Suppression_Date','College_End_Suppression_Date','Address_Style_Flag','Simplify_Address_Count','Drop_Indicator','Residential_or_Business_Ind','DPBC_Digit','DPBC_Check_Digit','Update_Date','File_Release_Date','Override_file_release_date','County_Num','County_Name','City_Name','State_Code','State_Num','Congressional_District_Number','OWGM_Indicator','Record_Type_Code','ADVO_Key','Address_Type','Mixed_Address_Usage','date_first_seen','date_last_seen','date_vendor_first_reported','date_vendor_last_reported','VAC_BEGDT','VAC_ENDDT','MONTHS_VAC_CURR','MONTHS_VAC_MAX','VAC_COUNT','prim_range','predir','prim_name','addr_suffix','postdir','unit_desig','sec_range','p_city_name','v_city_name','st','zip','zip4','cart','cr_sort_sz','lot','lot_order','dbpc','chk_digit','rec_type','fips_county','county','geo_lat','geo_long','msa','geo_blk','geo_match','err_stat','RawAID','cleanaid','addresstype','Active_flag');
EXPORT FieldNum(SALT30.StrType fn) := CASE(fn,'ZIP_5' => 1,'Route_Num' => 2,'ZIP_4' => 3,'WALK_Sequence' => 4,'STREET_NUM' => 5,'STREET_PRE_DIRectional' => 6,'STREET_NAME' => 7,'STREET_POST_DIRectional' => 8,'STREET_SUFFIX' => 9,'Secondary_Unit_Designator' => 10,'Secondary_Unit_Number' => 11,'Address_Vacancy_Indicator' => 12,'Throw_Back_Indicator' => 13,'Seasonal_Delivery_Indicator' => 14,'Seasonal_Start_Suppression_Date' => 15,'Seasonal_End_Suppression_Date' => 16,'DND_Indicator' => 17,'College_Indicator' => 18,'College_Start_Suppression_Date' => 19,'College_End_Suppression_Date' => 20,'Address_Style_Flag' => 21,'Simplify_Address_Count' => 22,'Drop_Indicator' => 23,'Residential_or_Business_Ind' => 24,'DPBC_Digit' => 25,'DPBC_Check_Digit' => 26,'Update_Date' => 27,'File_Release_Date' => 28,'Override_file_release_date' => 29,'County_Num' => 30,'County_Name' => 31,'City_Name' => 32,'State_Code' => 33,'State_Num' => 34,'Congressional_District_Number' => 35,'OWGM_Indicator' => 36,'Record_Type_Code' => 37,'ADVO_Key' => 38,'Address_Type' => 39,'Mixed_Address_Usage' => 40,'date_first_seen' => 41,'date_last_seen' => 42,'date_vendor_first_reported' => 43,'date_vendor_last_reported' => 44,'VAC_BEGDT' => 45,'VAC_ENDDT' => 46,'MONTHS_VAC_CURR' => 47,'MONTHS_VAC_MAX' => 48,'VAC_COUNT' => 49,'prim_range' => 50,'predir' => 51,'prim_name' => 52,'addr_suffix' => 53,'postdir' => 54,'unit_desig' => 55,'sec_range' => 56,'p_city_name' => 57,'v_city_name' => 58,'st' => 59,'zip' => 60,'zip4' => 61,'cart' => 62,'cr_sort_sz' => 63,'lot' => 64,'lot_order' => 65,'dbpc' => 66,'chk_digit' => 67,'rec_type' => 68,'fips_county' => 69,'county' => 70,'geo_lat' => 71,'geo_long' => 72,'msa' => 73,'geo_blk' => 74,'geo_match' => 75,'err_stat' => 76,'RawAID' => 77,'cleanaid' => 78,'addresstype' => 79,'Active_flag' => 80,0);
//Individual field level validation
EXPORT Make_ZIP_5(SALT30.StrType s0) := MakeFT_invalid_zip(s0);
EXPORT InValid_ZIP_5(SALT30.StrType s) := InValidFT_invalid_zip(s);
EXPORT InValidMessage_ZIP_5(UNSIGNED1 wh) := InValidMessageFT_invalid_zip(wh);
EXPORT Make_Route_Num(SALT30.StrType s0) := MakeFT_invalid_route_num(s0);
EXPORT InValid_Route_Num(SALT30.StrType s) := InValidFT_invalid_route_num(s);
EXPORT InValidMessage_Route_Num(UNSIGNED1 wh) := InValidMessageFT_invalid_route_num(wh);
EXPORT Make_ZIP_4(SALT30.StrType s0) := MakeFT_invalid_zip(s0);
EXPORT InValid_ZIP_4(SALT30.StrType s) := InValidFT_invalid_zip(s);
EXPORT InValidMessage_ZIP_4(UNSIGNED1 wh) := InValidMessageFT_invalid_zip(wh);
EXPORT Make_WALK_Sequence(SALT30.StrType s0) := MakeFT_invalid_num(s0);
EXPORT InValid_WALK_Sequence(SALT30.StrType s) := InValidFT_invalid_num(s);
EXPORT InValidMessage_WALK_Sequence(UNSIGNED1 wh) := InValidMessageFT_invalid_num(wh);
EXPORT Make_STREET_NUM(SALT30.StrType s0) := MakeFT_invalid_street(s0);
EXPORT InValid_STREET_NUM(SALT30.StrType s) := InValidFT_invalid_street(s);
EXPORT InValidMessage_STREET_NUM(UNSIGNED1 wh) := InValidMessageFT_invalid_street(wh);
EXPORT Make_STREET_PRE_DIRectional(SALT30.StrType s0) := MakeFT_invalid_prepostdir(s0);
EXPORT InValid_STREET_PRE_DIRectional(SALT30.StrType s) := InValidFT_invalid_prepostdir(s);
EXPORT InValidMessage_STREET_PRE_DIRectional(UNSIGNED1 wh) := InValidMessageFT_invalid_prepostdir(wh);
EXPORT Make_STREET_NAME(SALT30.StrType s0) := MakeFT_invalid_street(s0);
EXPORT InValid_STREET_NAME(SALT30.StrType s) := InValidFT_invalid_street(s);
EXPORT InValidMessage_STREET_NAME(UNSIGNED1 wh) := InValidMessageFT_invalid_street(wh);
EXPORT Make_STREET_POST_DIRectional(SALT30.StrType s0) := MakeFT_invalid_prepostdir(s0);
EXPORT InValid_STREET_POST_DIRectional(SALT30.StrType s) := InValidFT_invalid_prepostdir(s);
EXPORT InValidMessage_STREET_POST_DIRectional(UNSIGNED1 wh) := InValidMessageFT_invalid_prepostdir(wh);
EXPORT Make_STREET_SUFFIX(SALT30.StrType s0) := MakeFT_invalid_alpha(s0);
EXPORT InValid_STREET_SUFFIX(SALT30.StrType s) := InValidFT_invalid_alpha(s);
EXPORT InValidMessage_STREET_SUFFIX(UNSIGNED1 wh) := InValidMessageFT_invalid_alpha(wh);
EXPORT Make_Secondary_Unit_Designator(SALT30.StrType s0) := MakeFT_invalid_alpha(s0);
EXPORT InValid_Secondary_Unit_Designator(SALT30.StrType s) := InValidFT_invalid_alpha(s);
EXPORT InValidMessage_Secondary_Unit_Designator(UNSIGNED1 wh) := InValidMessageFT_invalid_alpha(wh);
EXPORT Make_Secondary_Unit_Number(SALT30.StrType s0) := MakeFT_invalid_street(s0);
EXPORT InValid_Secondary_Unit_Number(SALT30.StrType s) := InValidFT_invalid_street(s);
EXPORT InValidMessage_Secondary_Unit_Number(UNSIGNED1 wh) := InValidMessageFT_invalid_street(wh);
EXPORT Make_Address_Vacancy_Indicator(SALT30.StrType s0) := MakeFT_invalid_YN(s0);
EXPORT InValid_Address_Vacancy_Indicator(SALT30.StrType s) := InValidFT_invalid_YN(s);
EXPORT InValidMessage_Address_Vacancy_Indicator(UNSIGNED1 wh) := InValidMessageFT_invalid_YN(wh);
EXPORT Make_Throw_Back_Indicator(SALT30.StrType s0) := MakeFT_invalid_YN(s0);
EXPORT InValid_Throw_Back_Indicator(SALT30.StrType s) := InValidFT_invalid_YN(s);
EXPORT InValidMessage_Throw_Back_Indicator(UNSIGNED1 wh) := InValidMessageFT_invalid_YN(wh);
EXPORT Make_Seasonal_Delivery_Indicator(SALT30.StrType s0) := MakeFT_invalid_YNE(s0);
EXPORT InValid_Seasonal_Delivery_Indicator(SALT30.StrType s) := InValidFT_invalid_YNE(s);
EXPORT InValidMessage_Seasonal_Delivery_Indicator(UNSIGNED1 wh) := InValidMessageFT_invalid_YNE(wh);
EXPORT Make_Seasonal_Start_Suppression_Date(SALT30.StrType s0) := MakeFT_invalid_SupDate(s0);
EXPORT InValid_Seasonal_Start_Suppression_Date(SALT30.StrType s) := InValidFT_invalid_SupDate(s);
EXPORT InValidMessage_Seasonal_Start_Suppression_Date(UNSIGNED1 wh) := InValidMessageFT_invalid_SupDate(wh);
EXPORT Make_Seasonal_End_Suppression_Date(SALT30.StrType s0) := MakeFT_invalid_SupDate(s0);
EXPORT InValid_Seasonal_End_Suppression_Date(SALT30.StrType s) := InValidFT_invalid_SupDate(s);
EXPORT InValidMessage_Seasonal_End_Suppression_Date(UNSIGNED1 wh) := InValidMessageFT_invalid_SupDate(wh);
EXPORT Make_DND_Indicator(SALT30.StrType s0) := MakeFT_invalid_YN(s0);
EXPORT InValid_DND_Indicator(SALT30.StrType s) := InValidFT_invalid_YN(s);
EXPORT InValidMessage_DND_Indicator(UNSIGNED1 wh) := InValidMessageFT_invalid_YN(wh);
EXPORT Make_College_Indicator(SALT30.StrType s0) := MakeFT_invalid_YN(s0);
EXPORT InValid_College_Indicator(SALT30.StrType s) := InValidFT_invalid_YN(s);
EXPORT InValidMessage_College_Indicator(UNSIGNED1 wh) := InValidMessageFT_invalid_YN(wh);
EXPORT Make_College_Start_Suppression_Date(SALT30.StrType s0) := MakeFT_invalid_Dates(s0);
EXPORT InValid_College_Start_Suppression_Date(SALT30.StrType s) := InValidFT_invalid_Dates(s);
EXPORT InValidMessage_College_Start_Suppression_Date(UNSIGNED1 wh) := InValidMessageFT_invalid_Dates(wh);
EXPORT Make_College_End_Suppression_Date(SALT30.StrType s0) := MakeFT_invalid_Dates(s0);
EXPORT InValid_College_End_Suppression_Date(SALT30.StrType s) := InValidFT_invalid_Dates(s);
EXPORT InValidMessage_College_End_Suppression_Date(UNSIGNED1 wh) := InValidMessageFT_invalid_Dates(wh);
EXPORT Make_Address_Style_Flag(SALT30.StrType s0) := MakeFT_invalid_AddrStyleFlag(s0);
EXPORT InValid_Address_Style_Flag(SALT30.StrType s) := InValidFT_invalid_AddrStyleFlag(s);
EXPORT InValidMessage_Address_Style_Flag(UNSIGNED1 wh) := InValidMessageFT_invalid_AddrStyleFlag(wh);
EXPORT Make_Simplify_Address_Count(SALT30.StrType s0) := MakeFT_invalid_num(s0);
EXPORT InValid_Simplify_Address_Count(SALT30.StrType s) := InValidFT_invalid_num(s);
EXPORT InValidMessage_Simplify_Address_Count(UNSIGNED1 wh) := InValidMessageFT_invalid_num(wh);
EXPORT Make_Drop_Indicator(SALT30.StrType s0) := MakeFT_invalid_YNC(s0);
EXPORT InValid_Drop_Indicator(SALT30.StrType s) := InValidFT_invalid_YNC(s);
EXPORT InValidMessage_Drop_Indicator(UNSIGNED1 wh) := InValidMessageFT_invalid_YNC(wh);
EXPORT Make_Residential_or_Business_Ind(SALT30.StrType s0) := MakeFT_invalid_ResBusInd(s0);
EXPORT InValid_Residential_or_Business_Ind(SALT30.StrType s) := InValidFT_invalid_ResBusInd(s);
EXPORT InValidMessage_Residential_or_Business_Ind(UNSIGNED1 wh) := InValidMessageFT_invalid_ResBusInd(wh);
EXPORT Make_DPBC_Digit(SALT30.StrType s0) := MakeFT_invalid_num(s0);
EXPORT InValid_DPBC_Digit(SALT30.StrType s) := InValidFT_invalid_num(s);
EXPORT InValidMessage_DPBC_Digit(UNSIGNED1 wh) := InValidMessageFT_invalid_num(wh);
EXPORT Make_DPBC_Check_Digit(SALT30.StrType s0) := MakeFT_invalid_num(s0);
EXPORT InValid_DPBC_Check_Digit(SALT30.StrType s) := InValidFT_invalid_num(s);
EXPORT InValidMessage_DPBC_Check_Digit(UNSIGNED1 wh) := InValidMessageFT_invalid_num(wh);
EXPORT Make_Update_Date(SALT30.StrType s0) := MakeFT_invalid_Dates(s0);
EXPORT InValid_Update_Date(SALT30.StrType s) := InValidFT_invalid_Dates(s);
EXPORT InValidMessage_Update_Date(UNSIGNED1 wh) := InValidMessageFT_invalid_Dates(wh);
EXPORT Make_File_Release_Date(SALT30.StrType s0) := MakeFT_invalid_Dates(s0);
EXPORT InValid_File_Release_Date(SALT30.StrType s) := InValidFT_invalid_Dates(s);
EXPORT InValidMessage_File_Release_Date(UNSIGNED1 wh) := InValidMessageFT_invalid_Dates(wh);
EXPORT Make_Override_file_release_date(SALT30.StrType s0) := MakeFT_invalid_Dates(s0);
EXPORT InValid_Override_file_release_date(SALT30.StrType s) := InValidFT_invalid_Dates(s);
EXPORT InValidMessage_Override_file_release_date(UNSIGNED1 wh) := InValidMessageFT_invalid_Dates(wh);
EXPORT Make_County_Num(SALT30.StrType s0) := MakeFT_invalid_num(s0);
EXPORT InValid_County_Num(SALT30.StrType s) := InValidFT_invalid_num(s);
EXPORT InValidMessage_County_Num(UNSIGNED1 wh) := InValidMessageFT_invalid_num(wh);
EXPORT Make_County_Name(SALT30.StrType s0) := MakeFT_invalid_street(s0);
EXPORT InValid_County_Name(SALT30.StrType s) := InValidFT_invalid_street(s);
EXPORT InValidMessage_County_Name(UNSIGNED1 wh) := InValidMessageFT_invalid_street(wh);
EXPORT Make_City_Name(SALT30.StrType s0) := MakeFT_invalid_street(s0);
EXPORT InValid_City_Name(SALT30.StrType s) := InValidFT_invalid_street(s);
EXPORT InValidMessage_City_Name(UNSIGNED1 wh) := InValidMessageFT_invalid_street(wh);
EXPORT Make_State_Code(SALT30.StrType s0) := MakeFT_invalid_alpha(s0);
EXPORT InValid_State_Code(SALT30.StrType s) := InValidFT_invalid_alpha(s);
EXPORT InValidMessage_State_Code(UNSIGNED1 wh) := InValidMessageFT_invalid_alpha(wh);
EXPORT Make_State_Num(SALT30.StrType s0) := MakeFT_invalid_num(s0);
EXPORT InValid_State_Num(SALT30.StrType s) := InValidFT_invalid_num(s);
EXPORT InValidMessage_State_Num(UNSIGNED1 wh) := InValidMessageFT_invalid_num(wh);
EXPORT Make_Congressional_District_Number(SALT30.StrType s0) := MakeFT_invalid_cda(s0);
EXPORT InValid_Congressional_District_Number(SALT30.StrType s) := InValidFT_invalid_cda(s);
EXPORT InValidMessage_Congressional_District_Number(UNSIGNED1 wh) := InValidMessageFT_invalid_cda(wh);
EXPORT Make_OWGM_Indicator(SALT30.StrType s0) := MakeFT_invalid_YN(s0);
EXPORT InValid_OWGM_Indicator(SALT30.StrType s) := InValidFT_invalid_YN(s);
EXPORT InValidMessage_OWGM_Indicator(UNSIGNED1 wh) := InValidMessageFT_invalid_YN(wh);
EXPORT Make_Record_Type_Code(SALT30.StrType s0) := MakeFT_invalid_RTC(s0);
EXPORT InValid_Record_Type_Code(SALT30.StrType s) := InValidFT_invalid_RTC(s);
EXPORT InValidMessage_Record_Type_Code(UNSIGNED1 wh) := InValidMessageFT_invalid_RTC(wh);
EXPORT Make_ADVO_Key(SALT30.StrType s0) := MakeFT_invalid_num(s0);
EXPORT InValid_ADVO_Key(SALT30.StrType s) := InValidFT_invalid_num(s);
EXPORT InValidMessage_ADVO_Key(UNSIGNED1 wh) := InValidMessageFT_invalid_num(wh);
EXPORT Make_Address_Type(SALT30.StrType s0) := MakeFT_invalid_addr_type(s0);
EXPORT InValid_Address_Type(SALT30.StrType s) := InValidFT_invalid_addr_type(s);
EXPORT InValidMessage_Address_Type(UNSIGNED1 wh) := InValidMessageFT_invalid_addr_type(wh);
EXPORT Make_Mixed_Address_Usage(SALT30.StrType s0) := MakeFT_invalid_AddrUsg(s0);
EXPORT InValid_Mixed_Address_Usage(SALT30.StrType s) := InValidFT_invalid_AddrUsg(s);
EXPORT InValidMessage_Mixed_Address_Usage(UNSIGNED1 wh) := InValidMessageFT_invalid_AddrUsg(wh);
EXPORT Make_date_first_seen(SALT30.StrType s0) := MakeFT_invalid_Vacdate(s0);
EXPORT InValid_date_first_seen(SALT30.StrType s) := InValidFT_invalid_Vacdate(s);
EXPORT InValidMessage_date_first_seen(UNSIGNED1 wh) := InValidMessageFT_invalid_Vacdate(wh);
EXPORT Make_date_last_seen(SALT30.StrType s0) := MakeFT_invalid_Vacdate(s0);
EXPORT InValid_date_last_seen(SALT30.StrType s) := InValidFT_invalid_Vacdate(s);
EXPORT InValidMessage_date_last_seen(UNSIGNED1 wh) := InValidMessageFT_invalid_Vacdate(wh);
EXPORT Make_date_vendor_first_reported(SALT30.StrType s0) := MakeFT_invalid_Vacdate(s0);
EXPORT InValid_date_vendor_first_reported(SALT30.StrType s) := InValidFT_invalid_Vacdate(s);
EXPORT InValidMessage_date_vendor_first_reported(UNSIGNED1 wh) := InValidMessageFT_invalid_Vacdate(wh);
EXPORT Make_date_vendor_last_reported(SALT30.StrType s0) := MakeFT_invalid_Vacdate(s0);
EXPORT InValid_date_vendor_last_reported(SALT30.StrType s) := InValidFT_invalid_Vacdate(s);
EXPORT InValidMessage_date_vendor_last_reported(UNSIGNED1 wh) := InValidMessageFT_invalid_Vacdate(wh);
EXPORT Make_VAC_BEGDT(SALT30.StrType s0) := MakeFT_invalid_Vacdate(s0);
EXPORT InValid_VAC_BEGDT(SALT30.StrType s) := InValidFT_invalid_Vacdate(s);
EXPORT InValidMessage_VAC_BEGDT(UNSIGNED1 wh) := InValidMessageFT_invalid_Vacdate(wh);
EXPORT Make_VAC_ENDDT(SALT30.StrType s0) := MakeFT_invalid_Vacdate(s0);
EXPORT InValid_VAC_ENDDT(SALT30.StrType s) := InValidFT_invalid_Vacdate(s);
EXPORT InValidMessage_VAC_ENDDT(UNSIGNED1 wh) := InValidMessageFT_invalid_Vacdate(wh);
EXPORT Make_MONTHS_VAC_CURR(SALT30.StrType s0) := MakeFT_invalid_Vacdate(s0);
EXPORT InValid_MONTHS_VAC_CURR(SALT30.StrType s) := InValidFT_invalid_Vacdate(s);
EXPORT InValidMessage_MONTHS_VAC_CURR(UNSIGNED1 wh) := InValidMessageFT_invalid_Vacdate(wh);
EXPORT Make_MONTHS_VAC_MAX(SALT30.StrType s0) := MakeFT_invalid_Vacdate(s0);
EXPORT InValid_MONTHS_VAC_MAX(SALT30.StrType s) := InValidFT_invalid_Vacdate(s);
EXPORT InValidMessage_MONTHS_VAC_MAX(UNSIGNED1 wh) := InValidMessageFT_invalid_Vacdate(wh);
EXPORT Make_VAC_COUNT(SALT30.StrType s0) := MakeFT_invalid_Vacdate(s0);
EXPORT InValid_VAC_COUNT(SALT30.StrType s) := InValidFT_invalid_Vacdate(s);
EXPORT InValidMessage_VAC_COUNT(UNSIGNED1 wh) := InValidMessageFT_invalid_Vacdate(wh);
EXPORT Make_prim_range(SALT30.StrType s0) := s0;
EXPORT InValid_prim_range(SALT30.StrType s) := FALSE;
EXPORT InValidMessage_prim_range(UNSIGNED1 wh) := '';
EXPORT Make_predir(SALT30.StrType s0) := s0;
EXPORT InValid_predir(SALT30.StrType s) := FALSE;
EXPORT InValidMessage_predir(UNSIGNED1 wh) := '';
EXPORT Make_prim_name(SALT30.StrType s0) := s0;
EXPORT InValid_prim_name(SALT30.StrType s) := FALSE;
EXPORT InValidMessage_prim_name(UNSIGNED1 wh) := '';
EXPORT Make_addr_suffix(SALT30.StrType s0) := s0;
EXPORT InValid_addr_suffix(SALT30.StrType s) := FALSE;
EXPORT InValidMessage_addr_suffix(UNSIGNED1 wh) := '';
EXPORT Make_postdir(SALT30.StrType s0) := s0;
EXPORT InValid_postdir(SALT30.StrType s) := FALSE;
EXPORT InValidMessage_postdir(UNSIGNED1 wh) := '';
EXPORT Make_unit_desig(SALT30.StrType s0) := s0;
EXPORT InValid_unit_desig(SALT30.StrType s) := FALSE;
EXPORT InValidMessage_unit_desig(UNSIGNED1 wh) := '';
EXPORT Make_sec_range(SALT30.StrType s0) := s0;
EXPORT InValid_sec_range(SALT30.StrType s) := FALSE;
EXPORT InValidMessage_sec_range(UNSIGNED1 wh) := '';
EXPORT Make_p_city_name(SALT30.StrType s0) := s0;
EXPORT InValid_p_city_name(SALT30.StrType s) := FALSE;
EXPORT InValidMessage_p_city_name(UNSIGNED1 wh) := '';
EXPORT Make_v_city_name(SALT30.StrType s0) := s0;
EXPORT InValid_v_city_name(SALT30.StrType s) := FALSE;
EXPORT InValidMessage_v_city_name(UNSIGNED1 wh) := '';
EXPORT Make_st(SALT30.StrType s0) := s0;
EXPORT InValid_st(SALT30.StrType s) := FALSE;
EXPORT InValidMessage_st(UNSIGNED1 wh) := '';
EXPORT Make_zip(SALT30.StrType s0) := s0;
EXPORT InValid_zip(SALT30.StrType s) := FALSE;
EXPORT InValidMessage_zip(UNSIGNED1 wh) := '';
EXPORT Make_zip4(SALT30.StrType s0) := s0;
EXPORT InValid_zip4(SALT30.StrType s) := FALSE;
EXPORT InValidMessage_zip4(UNSIGNED1 wh) := '';
EXPORT Make_cart(SALT30.StrType s0) := s0;
EXPORT InValid_cart(SALT30.StrType s) := FALSE;
EXPORT InValidMessage_cart(UNSIGNED1 wh) := '';
EXPORT Make_cr_sort_sz(SALT30.StrType s0) := s0;
EXPORT InValid_cr_sort_sz(SALT30.StrType s) := FALSE;
EXPORT InValidMessage_cr_sort_sz(UNSIGNED1 wh) := '';
EXPORT Make_lot(SALT30.StrType s0) := s0;
EXPORT InValid_lot(SALT30.StrType s) := FALSE;
EXPORT InValidMessage_lot(UNSIGNED1 wh) := '';
EXPORT Make_lot_order(SALT30.StrType s0) := s0;
EXPORT InValid_lot_order(SALT30.StrType s) := FALSE;
EXPORT InValidMessage_lot_order(UNSIGNED1 wh) := '';
EXPORT Make_dbpc(SALT30.StrType s0) := s0;
EXPORT InValid_dbpc(SALT30.StrType s) := FALSE;
EXPORT InValidMessage_dbpc(UNSIGNED1 wh) := '';
EXPORT Make_chk_digit(SALT30.StrType s0) := s0;
EXPORT InValid_chk_digit(SALT30.StrType s) := FALSE;
EXPORT InValidMessage_chk_digit(UNSIGNED1 wh) := '';
EXPORT Make_rec_type(SALT30.StrType s0) := s0;
EXPORT InValid_rec_type(SALT30.StrType s) := FALSE;
EXPORT InValidMessage_rec_type(UNSIGNED1 wh) := '';
EXPORT Make_fips_county(SALT30.StrType s0) := s0;
EXPORT InValid_fips_county(SALT30.StrType s) := FALSE;
EXPORT InValidMessage_fips_county(UNSIGNED1 wh) := '';
EXPORT Make_county(SALT30.StrType s0) := s0;
EXPORT InValid_county(SALT30.StrType s) := FALSE;
EXPORT InValidMessage_county(UNSIGNED1 wh) := '';
EXPORT Make_geo_lat(SALT30.StrType s0) := s0;
EXPORT InValid_geo_lat(SALT30.StrType s) := FALSE;
EXPORT InValidMessage_geo_lat(UNSIGNED1 wh) := '';
EXPORT Make_geo_long(SALT30.StrType s0) := s0;
EXPORT InValid_geo_long(SALT30.StrType s) := FALSE;
EXPORT InValidMessage_geo_long(UNSIGNED1 wh) := '';
EXPORT Make_msa(SALT30.StrType s0) := s0;
EXPORT InValid_msa(SALT30.StrType s) := FALSE;
EXPORT InValidMessage_msa(UNSIGNED1 wh) := '';
EXPORT Make_geo_blk(SALT30.StrType s0) := s0;
EXPORT InValid_geo_blk(SALT30.StrType s) := FALSE;
EXPORT InValidMessage_geo_blk(UNSIGNED1 wh) := '';
EXPORT Make_geo_match(SALT30.StrType s0) := s0;
EXPORT InValid_geo_match(SALT30.StrType s) := FALSE;
EXPORT InValidMessage_geo_match(UNSIGNED1 wh) := '';
EXPORT Make_err_stat(SALT30.StrType s0) := s0;
EXPORT InValid_err_stat(SALT30.StrType s) := FALSE;
EXPORT InValidMessage_err_stat(UNSIGNED1 wh) := '';
EXPORT Make_RawAID(SALT30.StrType s0) := s0;
EXPORT InValid_RawAID(SALT30.StrType s) := FALSE;
EXPORT InValidMessage_RawAID(UNSIGNED1 wh) := '';
EXPORT Make_cleanaid(SALT30.StrType s0) := s0;
EXPORT InValid_cleanaid(SALT30.StrType s) := FALSE;
EXPORT InValidMessage_cleanaid(UNSIGNED1 wh) := '';
EXPORT Make_addresstype(SALT30.StrType s0) := MakeFT_invalid_addrtype(s0);
EXPORT InValid_addresstype(SALT30.StrType s) := InValidFT_invalid_addrtype(s);
EXPORT InValidMessage_addresstype(UNSIGNED1 wh) := InValidMessageFT_invalid_addrtype(wh);
EXPORT Make_Active_flag(SALT30.StrType s0) := MakeFT_invalid_YN(s0);
EXPORT InValid_Active_flag(SALT30.StrType s) := InValidFT_invalid_YN(s);
EXPORT InValidMessage_Active_flag(UNSIGNED1 wh) := InValidMessageFT_invalid_YN(wh);
// This macro will compute and count field level differences based upon a pivot expression
export MAC_CountDifferencesByPivot(in_left,in_right,pivot_exp,bad_pivots,out_counts) := MACRO
  IMPORT SALT30,Advo;
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
    BOOLEAN Diff_ZIP_5;
    BOOLEAN Diff_Route_Num;
    BOOLEAN Diff_ZIP_4;
    BOOLEAN Diff_WALK_Sequence;
    BOOLEAN Diff_STREET_NUM;
    BOOLEAN Diff_STREET_PRE_DIRectional;
    BOOLEAN Diff_STREET_NAME;
    BOOLEAN Diff_STREET_POST_DIRectional;
    BOOLEAN Diff_STREET_SUFFIX;
    BOOLEAN Diff_Secondary_Unit_Designator;
    BOOLEAN Diff_Secondary_Unit_Number;
    BOOLEAN Diff_Address_Vacancy_Indicator;
    BOOLEAN Diff_Throw_Back_Indicator;
    BOOLEAN Diff_Seasonal_Delivery_Indicator;
    BOOLEAN Diff_Seasonal_Start_Suppression_Date;
    BOOLEAN Diff_Seasonal_End_Suppression_Date;
    BOOLEAN Diff_DND_Indicator;
    BOOLEAN Diff_College_Indicator;
    BOOLEAN Diff_College_Start_Suppression_Date;
    BOOLEAN Diff_College_End_Suppression_Date;
    BOOLEAN Diff_Address_Style_Flag;
    BOOLEAN Diff_Simplify_Address_Count;
    BOOLEAN Diff_Drop_Indicator;
    BOOLEAN Diff_Residential_or_Business_Ind;
    BOOLEAN Diff_DPBC_Digit;
    BOOLEAN Diff_DPBC_Check_Digit;
    BOOLEAN Diff_Update_Date;
    BOOLEAN Diff_File_Release_Date;
    BOOLEAN Diff_Override_file_release_date;
    BOOLEAN Diff_County_Num;
    BOOLEAN Diff_County_Name;
    BOOLEAN Diff_City_Name;
    BOOLEAN Diff_State_Code;
    BOOLEAN Diff_State_Num;
    BOOLEAN Diff_Congressional_District_Number;
    BOOLEAN Diff_OWGM_Indicator;
    BOOLEAN Diff_Record_Type_Code;
    BOOLEAN Diff_ADVO_Key;
    BOOLEAN Diff_Address_Type;
    BOOLEAN Diff_Mixed_Address_Usage;
    BOOLEAN Diff_date_first_seen;
    BOOLEAN Diff_date_last_seen;
    BOOLEAN Diff_date_vendor_first_reported;
    BOOLEAN Diff_date_vendor_last_reported;
    BOOLEAN Diff_VAC_BEGDT;
    BOOLEAN Diff_VAC_ENDDT;
    BOOLEAN Diff_MONTHS_VAC_CURR;
    BOOLEAN Diff_MONTHS_VAC_MAX;
    BOOLEAN Diff_VAC_COUNT;
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
    BOOLEAN Diff_fips_county;
    BOOLEAN Diff_county;
    BOOLEAN Diff_geo_lat;
    BOOLEAN Diff_geo_long;
    BOOLEAN Diff_msa;
    BOOLEAN Diff_geo_blk;
    BOOLEAN Diff_geo_match;
    BOOLEAN Diff_err_stat;
    BOOLEAN Diff_RawAID;
    BOOLEAN Diff_cleanaid;
    BOOLEAN Diff_addresstype;
    BOOLEAN Diff_Active_flag;
    UNSIGNED Num_Diffs;
    SALT30.StrType Val {MAXLENGTH(1024)};
  END;
#uniquename(fd)
  %dl% %fd%(in_left le,in_right ri) := TRANSFORM
    SELF.Diff_ZIP_5 := le.ZIP_5 <> ri.ZIP_5;
    SELF.Diff_Route_Num := le.Route_Num <> ri.Route_Num;
    SELF.Diff_ZIP_4 := le.ZIP_4 <> ri.ZIP_4;
    SELF.Diff_WALK_Sequence := le.WALK_Sequence <> ri.WALK_Sequence;
    SELF.Diff_STREET_NUM := le.STREET_NUM <> ri.STREET_NUM;
    SELF.Diff_STREET_PRE_DIRectional := le.STREET_PRE_DIRectional <> ri.STREET_PRE_DIRectional;
    SELF.Diff_STREET_NAME := le.STREET_NAME <> ri.STREET_NAME;
    SELF.Diff_STREET_POST_DIRectional := le.STREET_POST_DIRectional <> ri.STREET_POST_DIRectional;
    SELF.Diff_STREET_SUFFIX := le.STREET_SUFFIX <> ri.STREET_SUFFIX;
    SELF.Diff_Secondary_Unit_Designator := le.Secondary_Unit_Designator <> ri.Secondary_Unit_Designator;
    SELF.Diff_Secondary_Unit_Number := le.Secondary_Unit_Number <> ri.Secondary_Unit_Number;
    SELF.Diff_Address_Vacancy_Indicator := le.Address_Vacancy_Indicator <> ri.Address_Vacancy_Indicator;
    SELF.Diff_Throw_Back_Indicator := le.Throw_Back_Indicator <> ri.Throw_Back_Indicator;
    SELF.Diff_Seasonal_Delivery_Indicator := le.Seasonal_Delivery_Indicator <> ri.Seasonal_Delivery_Indicator;
    SELF.Diff_Seasonal_Start_Suppression_Date := le.Seasonal_Start_Suppression_Date <> ri.Seasonal_Start_Suppression_Date;
    SELF.Diff_Seasonal_End_Suppression_Date := le.Seasonal_End_Suppression_Date <> ri.Seasonal_End_Suppression_Date;
    SELF.Diff_DND_Indicator := le.DND_Indicator <> ri.DND_Indicator;
    SELF.Diff_College_Indicator := le.College_Indicator <> ri.College_Indicator;
    SELF.Diff_College_Start_Suppression_Date := le.College_Start_Suppression_Date <> ri.College_Start_Suppression_Date;
    SELF.Diff_College_End_Suppression_Date := le.College_End_Suppression_Date <> ri.College_End_Suppression_Date;
    SELF.Diff_Address_Style_Flag := le.Address_Style_Flag <> ri.Address_Style_Flag;
    SELF.Diff_Simplify_Address_Count := le.Simplify_Address_Count <> ri.Simplify_Address_Count;
    SELF.Diff_Drop_Indicator := le.Drop_Indicator <> ri.Drop_Indicator;
    SELF.Diff_Residential_or_Business_Ind := le.Residential_or_Business_Ind <> ri.Residential_or_Business_Ind;
    SELF.Diff_DPBC_Digit := le.DPBC_Digit <> ri.DPBC_Digit;
    SELF.Diff_DPBC_Check_Digit := le.DPBC_Check_Digit <> ri.DPBC_Check_Digit;
    SELF.Diff_Update_Date := le.Update_Date <> ri.Update_Date;
    SELF.Diff_File_Release_Date := le.File_Release_Date <> ri.File_Release_Date;
    SELF.Diff_Override_file_release_date := le.Override_file_release_date <> ri.Override_file_release_date;
    SELF.Diff_County_Num := le.County_Num <> ri.County_Num;
    SELF.Diff_County_Name := le.County_Name <> ri.County_Name;
    SELF.Diff_City_Name := le.City_Name <> ri.City_Name;
    SELF.Diff_State_Code := le.State_Code <> ri.State_Code;
    SELF.Diff_State_Num := le.State_Num <> ri.State_Num;
    SELF.Diff_Congressional_District_Number := le.Congressional_District_Number <> ri.Congressional_District_Number;
    SELF.Diff_OWGM_Indicator := le.OWGM_Indicator <> ri.OWGM_Indicator;
    SELF.Diff_Record_Type_Code := le.Record_Type_Code <> ri.Record_Type_Code;
    SELF.Diff_ADVO_Key := le.ADVO_Key <> ri.ADVO_Key;
    SELF.Diff_Address_Type := le.Address_Type <> ri.Address_Type;
    SELF.Diff_Mixed_Address_Usage := le.Mixed_Address_Usage <> ri.Mixed_Address_Usage;
    SELF.Diff_date_first_seen := le.date_first_seen <> ri.date_first_seen;
    SELF.Diff_date_last_seen := le.date_last_seen <> ri.date_last_seen;
    SELF.Diff_date_vendor_first_reported := le.date_vendor_first_reported <> ri.date_vendor_first_reported;
    SELF.Diff_date_vendor_last_reported := le.date_vendor_last_reported <> ri.date_vendor_last_reported;
    SELF.Diff_VAC_BEGDT := le.VAC_BEGDT <> ri.VAC_BEGDT;
    SELF.Diff_VAC_ENDDT := le.VAC_ENDDT <> ri.VAC_ENDDT;
    SELF.Diff_MONTHS_VAC_CURR := le.MONTHS_VAC_CURR <> ri.MONTHS_VAC_CURR;
    SELF.Diff_MONTHS_VAC_MAX := le.MONTHS_VAC_MAX <> ri.MONTHS_VAC_MAX;
    SELF.Diff_VAC_COUNT := le.VAC_COUNT <> ri.VAC_COUNT;
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
    SELF.Diff_fips_county := le.fips_county <> ri.fips_county;
    SELF.Diff_county := le.county <> ri.county;
    SELF.Diff_geo_lat := le.geo_lat <> ri.geo_lat;
    SELF.Diff_geo_long := le.geo_long <> ri.geo_long;
    SELF.Diff_msa := le.msa <> ri.msa;
    SELF.Diff_geo_blk := le.geo_blk <> ri.geo_blk;
    SELF.Diff_geo_match := le.geo_match <> ri.geo_match;
    SELF.Diff_err_stat := le.err_stat <> ri.err_stat;
    SELF.Diff_RawAID := le.RawAID <> ri.RawAID;
    SELF.Diff_cleanaid := le.cleanaid <> ri.cleanaid;
    SELF.Diff_addresstype := le.addresstype <> ri.addresstype;
    SELF.Diff_Active_flag := le.Active_flag <> ri.Active_flag;
    SELF.Val := (SALT30.StrType)evaluate(le,pivot_exp);
    SELF.Num_Diffs := 0+ IF( SELF.Diff_ZIP_5,1,0)+ IF( SELF.Diff_Route_Num,1,0)+ IF( SELF.Diff_ZIP_4,1,0)+ IF( SELF.Diff_WALK_Sequence,1,0)+ IF( SELF.Diff_STREET_NUM,1,0)+ IF( SELF.Diff_STREET_PRE_DIRectional,1,0)+ IF( SELF.Diff_STREET_NAME,1,0)+ IF( SELF.Diff_STREET_POST_DIRectional,1,0)+ IF( SELF.Diff_STREET_SUFFIX,1,0)+ IF( SELF.Diff_Secondary_Unit_Designator,1,0)+ IF( SELF.Diff_Secondary_Unit_Number,1,0)+ IF( SELF.Diff_Address_Vacancy_Indicator,1,0)+ IF( SELF.Diff_Throw_Back_Indicator,1,0)+ IF( SELF.Diff_Seasonal_Delivery_Indicator,1,0)+ IF( SELF.Diff_Seasonal_Start_Suppression_Date,1,0)+ IF( SELF.Diff_Seasonal_End_Suppression_Date,1,0)+ IF( SELF.Diff_DND_Indicator,1,0)+ IF( SELF.Diff_College_Indicator,1,0)+ IF( SELF.Diff_College_Start_Suppression_Date,1,0)+ IF( SELF.Diff_College_End_Suppression_Date,1,0)+ IF( SELF.Diff_Address_Style_Flag,1,0)+ IF( SELF.Diff_Simplify_Address_Count,1,0)+ IF( SELF.Diff_Drop_Indicator,1,0)+ IF( SELF.Diff_Residential_or_Business_Ind,1,0)+ IF( SELF.Diff_DPBC_Digit,1,0)+ IF( SELF.Diff_DPBC_Check_Digit,1,0)+ IF( SELF.Diff_Update_Date,1,0)+ IF( SELF.Diff_File_Release_Date,1,0)+ IF( SELF.Diff_Override_file_release_date,1,0)+ IF( SELF.Diff_County_Num,1,0)+ IF( SELF.Diff_County_Name,1,0)+ IF( SELF.Diff_City_Name,1,0)+ IF( SELF.Diff_State_Code,1,0)+ IF( SELF.Diff_State_Num,1,0)+ IF( SELF.Diff_Congressional_District_Number,1,0)+ IF( SELF.Diff_OWGM_Indicator,1,0)+ IF( SELF.Diff_Record_Type_Code,1,0)+ IF( SELF.Diff_ADVO_Key,1,0)+ IF( SELF.Diff_Address_Type,1,0)+ IF( SELF.Diff_Mixed_Address_Usage,1,0)+ IF( SELF.Diff_date_first_seen,1,0)+ IF( SELF.Diff_date_last_seen,1,0)+ IF( SELF.Diff_date_vendor_first_reported,1,0)+ IF( SELF.Diff_date_vendor_last_reported,1,0)+ IF( SELF.Diff_VAC_BEGDT,1,0)+ IF( SELF.Diff_VAC_ENDDT,1,0)+ IF( SELF.Diff_MONTHS_VAC_CURR,1,0)+ IF( SELF.Diff_MONTHS_VAC_MAX,1,0)+ IF( SELF.Diff_VAC_COUNT,1,0)+ IF( SELF.Diff_prim_range,1,0)+ IF( SELF.Diff_predir,1,0)+ IF( SELF.Diff_prim_name,1,0)+ IF( SELF.Diff_addr_suffix,1,0)+ IF( SELF.Diff_postdir,1,0)+ IF( SELF.Diff_unit_desig,1,0)+ IF( SELF.Diff_sec_range,1,0)+ IF( SELF.Diff_p_city_name,1,0)+ IF( SELF.Diff_v_city_name,1,0)+ IF( SELF.Diff_st,1,0)+ IF( SELF.Diff_zip,1,0)+ IF( SELF.Diff_zip4,1,0)+ IF( SELF.Diff_cart,1,0)+ IF( SELF.Diff_cr_sort_sz,1,0)+ IF( SELF.Diff_lot,1,0)+ IF( SELF.Diff_lot_order,1,0)+ IF( SELF.Diff_dbpc,1,0)+ IF( SELF.Diff_chk_digit,1,0)+ IF( SELF.Diff_rec_type,1,0)+ IF( SELF.Diff_fips_county,1,0)+ IF( SELF.Diff_county,1,0)+ IF( SELF.Diff_geo_lat,1,0)+ IF( SELF.Diff_geo_long,1,0)+ IF( SELF.Diff_msa,1,0)+ IF( SELF.Diff_geo_blk,1,0)+ IF( SELF.Diff_geo_match,1,0)+ IF( SELF.Diff_err_stat,1,0)+ IF( SELF.Diff_RawAID,1,0)+ IF( SELF.Diff_cleanaid,1,0)+ IF( SELF.Diff_addresstype,1,0)+ IF( SELF.Diff_Active_flag,1,0);
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
    Count_Diff_ZIP_5 := COUNT(GROUP,%Closest%.Diff_ZIP_5);
    Count_Diff_Route_Num := COUNT(GROUP,%Closest%.Diff_Route_Num);
    Count_Diff_ZIP_4 := COUNT(GROUP,%Closest%.Diff_ZIP_4);
    Count_Diff_WALK_Sequence := COUNT(GROUP,%Closest%.Diff_WALK_Sequence);
    Count_Diff_STREET_NUM := COUNT(GROUP,%Closest%.Diff_STREET_NUM);
    Count_Diff_STREET_PRE_DIRectional := COUNT(GROUP,%Closest%.Diff_STREET_PRE_DIRectional);
    Count_Diff_STREET_NAME := COUNT(GROUP,%Closest%.Diff_STREET_NAME);
    Count_Diff_STREET_POST_DIRectional := COUNT(GROUP,%Closest%.Diff_STREET_POST_DIRectional);
    Count_Diff_STREET_SUFFIX := COUNT(GROUP,%Closest%.Diff_STREET_SUFFIX);
    Count_Diff_Secondary_Unit_Designator := COUNT(GROUP,%Closest%.Diff_Secondary_Unit_Designator);
    Count_Diff_Secondary_Unit_Number := COUNT(GROUP,%Closest%.Diff_Secondary_Unit_Number);
    Count_Diff_Address_Vacancy_Indicator := COUNT(GROUP,%Closest%.Diff_Address_Vacancy_Indicator);
    Count_Diff_Throw_Back_Indicator := COUNT(GROUP,%Closest%.Diff_Throw_Back_Indicator);
    Count_Diff_Seasonal_Delivery_Indicator := COUNT(GROUP,%Closest%.Diff_Seasonal_Delivery_Indicator);
    Count_Diff_Seasonal_Start_Suppression_Date := COUNT(GROUP,%Closest%.Diff_Seasonal_Start_Suppression_Date);
    Count_Diff_Seasonal_End_Suppression_Date := COUNT(GROUP,%Closest%.Diff_Seasonal_End_Suppression_Date);
    Count_Diff_DND_Indicator := COUNT(GROUP,%Closest%.Diff_DND_Indicator);
    Count_Diff_College_Indicator := COUNT(GROUP,%Closest%.Diff_College_Indicator);
    Count_Diff_College_Start_Suppression_Date := COUNT(GROUP,%Closest%.Diff_College_Start_Suppression_Date);
    Count_Diff_College_End_Suppression_Date := COUNT(GROUP,%Closest%.Diff_College_End_Suppression_Date);
    Count_Diff_Address_Style_Flag := COUNT(GROUP,%Closest%.Diff_Address_Style_Flag);
    Count_Diff_Simplify_Address_Count := COUNT(GROUP,%Closest%.Diff_Simplify_Address_Count);
    Count_Diff_Drop_Indicator := COUNT(GROUP,%Closest%.Diff_Drop_Indicator);
    Count_Diff_Residential_or_Business_Ind := COUNT(GROUP,%Closest%.Diff_Residential_or_Business_Ind);
    Count_Diff_DPBC_Digit := COUNT(GROUP,%Closest%.Diff_DPBC_Digit);
    Count_Diff_DPBC_Check_Digit := COUNT(GROUP,%Closest%.Diff_DPBC_Check_Digit);
    Count_Diff_Update_Date := COUNT(GROUP,%Closest%.Diff_Update_Date);
    Count_Diff_File_Release_Date := COUNT(GROUP,%Closest%.Diff_File_Release_Date);
    Count_Diff_Override_file_release_date := COUNT(GROUP,%Closest%.Diff_Override_file_release_date);
    Count_Diff_County_Num := COUNT(GROUP,%Closest%.Diff_County_Num);
    Count_Diff_County_Name := COUNT(GROUP,%Closest%.Diff_County_Name);
    Count_Diff_City_Name := COUNT(GROUP,%Closest%.Diff_City_Name);
    Count_Diff_State_Code := COUNT(GROUP,%Closest%.Diff_State_Code);
    Count_Diff_State_Num := COUNT(GROUP,%Closest%.Diff_State_Num);
    Count_Diff_Congressional_District_Number := COUNT(GROUP,%Closest%.Diff_Congressional_District_Number);
    Count_Diff_OWGM_Indicator := COUNT(GROUP,%Closest%.Diff_OWGM_Indicator);
    Count_Diff_Record_Type_Code := COUNT(GROUP,%Closest%.Diff_Record_Type_Code);
    Count_Diff_ADVO_Key := COUNT(GROUP,%Closest%.Diff_ADVO_Key);
    Count_Diff_Address_Type := COUNT(GROUP,%Closest%.Diff_Address_Type);
    Count_Diff_Mixed_Address_Usage := COUNT(GROUP,%Closest%.Diff_Mixed_Address_Usage);
    Count_Diff_date_first_seen := COUNT(GROUP,%Closest%.Diff_date_first_seen);
    Count_Diff_date_last_seen := COUNT(GROUP,%Closest%.Diff_date_last_seen);
    Count_Diff_date_vendor_first_reported := COUNT(GROUP,%Closest%.Diff_date_vendor_first_reported);
    Count_Diff_date_vendor_last_reported := COUNT(GROUP,%Closest%.Diff_date_vendor_last_reported);
    Count_Diff_VAC_BEGDT := COUNT(GROUP,%Closest%.Diff_VAC_BEGDT);
    Count_Diff_VAC_ENDDT := COUNT(GROUP,%Closest%.Diff_VAC_ENDDT);
    Count_Diff_MONTHS_VAC_CURR := COUNT(GROUP,%Closest%.Diff_MONTHS_VAC_CURR);
    Count_Diff_MONTHS_VAC_MAX := COUNT(GROUP,%Closest%.Diff_MONTHS_VAC_MAX);
    Count_Diff_VAC_COUNT := COUNT(GROUP,%Closest%.Diff_VAC_COUNT);
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
    Count_Diff_fips_county := COUNT(GROUP,%Closest%.Diff_fips_county);
    Count_Diff_county := COUNT(GROUP,%Closest%.Diff_county);
    Count_Diff_geo_lat := COUNT(GROUP,%Closest%.Diff_geo_lat);
    Count_Diff_geo_long := COUNT(GROUP,%Closest%.Diff_geo_long);
    Count_Diff_msa := COUNT(GROUP,%Closest%.Diff_msa);
    Count_Diff_geo_blk := COUNT(GROUP,%Closest%.Diff_geo_blk);
    Count_Diff_geo_match := COUNT(GROUP,%Closest%.Diff_geo_match);
    Count_Diff_err_stat := COUNT(GROUP,%Closest%.Diff_err_stat);
    Count_Diff_RawAID := COUNT(GROUP,%Closest%.Diff_RawAID);
    Count_Diff_cleanaid := COUNT(GROUP,%Closest%.Diff_cleanaid);
    Count_Diff_addresstype := COUNT(GROUP,%Closest%.Diff_addresstype);
    Count_Diff_Active_flag := COUNT(GROUP,%Closest%.Diff_Active_flag);
  END;
  out_counts := table(%Closest%,%AggRec%,true);
ENDMACRO;
END;
