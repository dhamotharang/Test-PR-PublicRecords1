IMPORT SALT311;
EXPORT Base_Fields := MODULE
 
EXPORT NumFields := 49;
 
// Processing for each FieldType
EXPORT SALT311.StrType FieldTypeName(UNSIGNED2 i) := CHOOSE(i,'item_source','source_code','display_name','description','status','data_notes','coverage_1','coverage_2','orbit_item_name','orbit_source','orbit_number','website','notes','date_added','input_file_id','market_restrict_flag','clean_phone','clean_fax','prepped_addr1','prepped_addr2','v_prim_name','v_zip','v_zip4','prim_range','predir','prim_name','addr_suffix','postdir','unit_desig','sec_range','p_city_name','v_city_name','st','zip','zip4','cart','cr_sort_sz','lot','lot_order','dbpc','chk_digit','rec_type','county','geo_lat','geo_long','msa','geo_blk','geo_match','err_stat');
EXPORT FieldTypeNum(SALT311.StrType fn) := CASE(fn,'item_source' => 1,'source_code' => 2,'display_name' => 3,'description' => 4,'status' => 5,'data_notes' => 6,'coverage_1' => 7,'coverage_2' => 8,'orbit_item_name' => 9,'orbit_source' => 10,'orbit_number' => 11,'website' => 12,'notes' => 13,'date_added' => 14,'input_file_id' => 15,'market_restrict_flag' => 16,'clean_phone' => 17,'clean_fax' => 18,'prepped_addr1' => 19,'prepped_addr2' => 20,'v_prim_name' => 21,'v_zip' => 22,'v_zip4' => 23,'prim_range' => 24,'predir' => 25,'prim_name' => 26,'addr_suffix' => 27,'postdir' => 28,'unit_desig' => 29,'sec_range' => 30,'p_city_name' => 31,'v_city_name' => 32,'st' => 33,'zip' => 34,'zip4' => 35,'cart' => 36,'cr_sort_sz' => 37,'lot' => 38,'lot_order' => 39,'dbpc' => 40,'chk_digit' => 41,'rec_type' => 42,'county' => 43,'geo_lat' => 44,'geo_long' => 45,'msa' => 46,'geo_blk' => 47,'geo_match' => 48,'err_stat' => 49,0);
 
EXPORT MakeFT_item_source(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringfilter(s0,' \\:~=+^%"|#!*${}[]?\'&<>@/,();-!.0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ_'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_item_source(SALT311.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT311.StringFilter(s,' \\:~=+^%"|#!*${}[]?\'&<>@/,();-!.0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ_'))));
EXPORT InValidMessageFT_item_source(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInChars(' \\:~=+^%"|#!*${}[]?\'&<>@/,();-!.0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ_'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_source_code(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringfilter(s0,' \\:~=+^%"|#!*${}[]?\'&<>@/,();-!.0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ_'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_source_code(SALT311.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT311.StringFilter(s,' \\:~=+^%"|#!*${}[]?\'&<>@/,();-!.0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ_'))));
EXPORT InValidMessageFT_source_code(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInChars(' \\:~=+^%"|#!*${}[]?\'&<>@/,();-!.0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ_'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_display_name(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringfilter(s0,' :+@%"\\*_$\';#&(),--./0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_display_name(SALT311.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT311.StringFilter(s,' :+@%"\\*_$\';#&(),--./0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ'))));
EXPORT InValidMessageFT_display_name(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInChars(' :+@%"\\*_$\';#&(),--./0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_description(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringfilter(s0,' ~@=<>:+[]%"\\*_$\';#/&(),-.0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_description(SALT311.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT311.StringFilter(s,' ~@=<>:+[]%"\\*_$\';#/&(),-.0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ'))));
EXPORT InValidMessageFT_description(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInChars(' ~@=<>:+[]%"\\*_$\';#/&(),-.0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_status(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringfilter(s0,' \\&()#/,\'-.0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_status(SALT311.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT311.StringFilter(s,' \\&()#/,\'-.0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ'))));
EXPORT InValidMessageFT_status(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInChars(' \\&()#/,\'-.0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_data_notes(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringfilter(s0,''); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_data_notes(SALT311.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT311.StringFilter(s,''))));
EXPORT InValidMessageFT_data_notes(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInChars(''),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_coverage_1(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringfilter(s0,' ()-\'.abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_coverage_1(SALT311.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT311.StringFilter(s,' ()-\'.abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ'))));
EXPORT InValidMessageFT_coverage_1(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInChars(' ()-\'.abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_coverage_2(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringfilter(s0,' ()-\'.abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_coverage_2(SALT311.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT311.StringFilter(s,' ()-\'.abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ'))));
EXPORT InValidMessageFT_coverage_2(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInChars(' ()-\'.abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_orbit_item_name(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringfilter(s0,' :%$&()*,+-/\'._0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_orbit_item_name(SALT311.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT311.StringFilter(s,' :%$&()*,+-/\'._0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ'))));
EXPORT InValidMessageFT_orbit_item_name(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInChars(' :%$&()*,+-/\'._0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_orbit_source(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringfilter(s0,'0123456789'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_orbit_source(SALT311.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT311.StringFilter(s,'0123456789'))));
EXPORT InValidMessageFT_orbit_source(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInChars('0123456789'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_orbit_number(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringfilter(s0,'0123456789'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_orbit_number(SALT311.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT311.StringFilter(s,'0123456789'))));
EXPORT InValidMessageFT_orbit_number(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInChars('0123456789'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_website(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringfilter(s0,' ()%\\"~&-./,#0123456789:=?@abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ_'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_website(SALT311.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT311.StringFilter(s,' ()%\\"~&-./,#0123456789:=?@abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ_'))));
EXPORT InValidMessageFT_website(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInChars(' ()%\\"~&-./,#0123456789:=?@abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ_'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_notes(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringfilter(s0,''); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_notes(SALT311.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT311.StringFilter(s,''))));
EXPORT InValidMessageFT_notes(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInChars(''),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_date_added(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringfilter(s0,'0123456789'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_date_added(SALT311.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT311.StringFilter(s,'0123456789'))));
EXPORT InValidMessageFT_date_added(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInChars('0123456789'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_input_file_id(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringfilter(s0,'0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_input_file_id(SALT311.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT311.StringFilter(s,'0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ'))));
EXPORT InValidMessageFT_input_file_id(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInChars('0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_market_restrict_flag(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringfilter(s0,'ENOSTY'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_market_restrict_flag(SALT311.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT311.StringFilter(s,'ENOSTY'))));
EXPORT InValidMessageFT_market_restrict_flag(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInChars('ENOSTY'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_clean_phone(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringfilter(s0,'0123456789'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_clean_phone(SALT311.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT311.StringFilter(s,'0123456789'))));
EXPORT InValidMessageFT_clean_phone(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInChars('0123456789'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_clean_fax(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringfilter(s0,''); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_clean_fax(SALT311.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT311.StringFilter(s,''))));
EXPORT InValidMessageFT_clean_fax(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInChars(''),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_prepped_addr1(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringfilter(s0,' _[]?$`"():/&#\',-.;0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_prepped_addr1(SALT311.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT311.StringFilter(s,' _[]?$`"():/&#\',-.;0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ'))));
EXPORT InValidMessageFT_prepped_addr1(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInChars(' _[]?$`"():/&#\',-.;0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_prepped_addr2(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringfilter(s0,' _[]?$`"():/&#\',-.;0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_prepped_addr2(SALT311.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT311.StringFilter(s,' _[]?$`"():/&#\',-.;0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ'))));
EXPORT InValidMessageFT_prepped_addr2(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInChars(' _[]?$`"():/&#\',-.;0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_v_prim_name(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringfilter(s0,''); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_v_prim_name(SALT311.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT311.StringFilter(s,''))));
EXPORT InValidMessageFT_v_prim_name(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInChars(''),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_v_zip(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringfilter(s0,''); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_v_zip(SALT311.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT311.StringFilter(s,''))));
EXPORT InValidMessageFT_v_zip(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInChars(''),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_v_zip4(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringfilter(s0,''); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_v_zip4(SALT311.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT311.StringFilter(s,''))));
EXPORT InValidMessageFT_v_zip4(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInChars(''),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_prim_range(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringfilter(s0,' -/.0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_prim_range(SALT311.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT311.StringFilter(s,' -/.0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ'))));
EXPORT InValidMessageFT_prim_range(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInChars(' -/.0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_predir(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringfilter(s0,'ENSW'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_predir(SALT311.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT311.StringFilter(s,'ENSW'))));
EXPORT InValidMessageFT_predir(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInChars('ENSW'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_prim_name(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringfilter(s0,' -\'/&$.0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_prim_name(SALT311.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT311.StringFilter(s,' -\'/&$.0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ'))));
EXPORT InValidMessageFT_prim_name(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInChars(' -\'/&$.0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_addr_suffix(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringfilter(s0,' abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_addr_suffix(SALT311.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT311.StringFilter(s,' abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ'))));
EXPORT InValidMessageFT_addr_suffix(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInChars(' abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_postdir(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringfilter(s0,'ENSW'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_postdir(SALT311.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT311.StringFilter(s,'ENSW'))));
EXPORT InValidMessageFT_postdir(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInChars('ENSW'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_unit_desig(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringfilter(s0,' #-abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_unit_desig(SALT311.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT311.StringFilter(s,' #-abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ'))));
EXPORT InValidMessageFT_unit_desig(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInChars(' #-abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_sec_range(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringfilter(s0,' &-./0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_sec_range(SALT311.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT311.StringFilter(s,' &-./0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ'))));
EXPORT InValidMessageFT_sec_range(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInChars(' &-./0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_p_city_name(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringfilter(s0,' /0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_p_city_name(SALT311.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT311.StringFilter(s,' /0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ'))));
EXPORT InValidMessageFT_p_city_name(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInChars(' /0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_v_city_name(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringfilter(s0,' /0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_v_city_name(SALT311.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT311.StringFilter(s,' /0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ'))));
EXPORT InValidMessageFT_v_city_name(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInChars(' /0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_st(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringfilter(s0,'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_st(SALT311.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT311.StringFilter(s,'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ'))));
EXPORT InValidMessageFT_st(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInChars('abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_zip(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringfilter(s0,'0123456789'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_zip(SALT311.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT311.StringFilter(s,'0123456789'))));
EXPORT InValidMessageFT_zip(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInChars('0123456789'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_zip4(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringfilter(s0,'0123456789'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_zip4(SALT311.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT311.StringFilter(s,'0123456789'))));
EXPORT InValidMessageFT_zip4(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInChars('0123456789'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_cart(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringfilter(s0,'0123456789BCHR'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_cart(SALT311.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT311.StringFilter(s,'0123456789BCHR'))));
EXPORT InValidMessageFT_cart(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInChars('0123456789BCHR'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_cr_sort_sz(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringfilter(s0,'BCD'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_cr_sort_sz(SALT311.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT311.StringFilter(s,'BCD'))));
EXPORT InValidMessageFT_cr_sort_sz(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInChars('BCD'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_lot(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringfilter(s0,'0123456789'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_lot(SALT311.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT311.StringFilter(s,'0123456789'))));
EXPORT InValidMessageFT_lot(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInChars('0123456789'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_lot_order(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringfilter(s0,'AD'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_lot_order(SALT311.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT311.StringFilter(s,'AD'))));
EXPORT InValidMessageFT_lot_order(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInChars('AD'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_dbpc(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringfilter(s0,'0123456789'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_dbpc(SALT311.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT311.StringFilter(s,'0123456789'))));
EXPORT InValidMessageFT_dbpc(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInChars('0123456789'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_chk_digit(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringfilter(s0,'0123456789'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_chk_digit(SALT311.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT311.StringFilter(s,'0123456789'))));
EXPORT InValidMessageFT_chk_digit(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInChars('0123456789'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_rec_type(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringfilter(s0,'DFHPRSU'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_rec_type(SALT311.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT311.StringFilter(s,'DFHPRSU'))));
EXPORT InValidMessageFT_rec_type(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInChars('DFHPRSU'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_county(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringfilter(s0,'0123456789'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_county(SALT311.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT311.StringFilter(s,'0123456789'))));
EXPORT InValidMessageFT_county(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInChars('0123456789'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_geo_lat(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringfilter(s0,'.0123456789'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_geo_lat(SALT311.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT311.StringFilter(s,'.0123456789'))));
EXPORT InValidMessageFT_geo_lat(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInChars('.0123456789'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_geo_long(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringfilter(s0,'-.0123456789'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_geo_long(SALT311.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT311.StringFilter(s,'-.0123456789'))));
EXPORT InValidMessageFT_geo_long(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInChars('-.0123456789'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_msa(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringfilter(s0,'0'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_msa(SALT311.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT311.StringFilter(s,'0'))));
EXPORT InValidMessageFT_msa(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInChars('0'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_geo_blk(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringfilter(s0,'0123456789'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_geo_blk(SALT311.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT311.StringFilter(s,'0123456789'))));
EXPORT InValidMessageFT_geo_blk(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInChars('0123456789'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_geo_match(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringfilter(s0,'0145'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_geo_match(SALT311.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT311.StringFilter(s,'0145'))));
EXPORT InValidMessageFT_geo_match(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInChars('0145'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_err_stat(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringfilter(s0,'0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_err_stat(SALT311.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT311.StringFilter(s,'0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ'))));
EXPORT InValidMessageFT_err_stat(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInChars('0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ'),SALT311.HygieneErrors.Good);
 
EXPORT SALT311.StrType FieldName(UNSIGNED2 i) := CHOOSE(i,'item_source','source_code','display_name','description','status','data_notes','coverage_1','coverage_2','orbit_item_name','orbit_source','orbit_number','website','notes','date_added','input_file_id','market_restrict_flag','clean_phone','clean_fax','prepped_addr1','prepped_addr2','v_prim_name','v_zip','v_zip4','prim_range','predir','prim_name','addr_suffix','postdir','unit_desig','sec_range','p_city_name','v_city_name','st','zip','zip4','cart','cr_sort_sz','lot','lot_order','dbpc','chk_digit','rec_type','county','geo_lat','geo_long','msa','geo_blk','geo_match','err_stat');
EXPORT SALT311.StrType FlatName(UNSIGNED2 i) := CHOOSE(i,'item_source','source_code','display_name','description','status','data_notes','coverage_1','coverage_2','orbit_item_name','orbit_source','orbit_number','website','notes','date_added','input_file_id','market_restrict_flag','clean_phone','clean_fax','prepped_addr1','prepped_addr2','v_prim_name','v_zip','v_zip4','prim_range','predir','prim_name','addr_suffix','postdir','unit_desig','sec_range','p_city_name','v_city_name','st','zip','zip4','cart','cr_sort_sz','lot','lot_order','dbpc','chk_digit','rec_type','county','geo_lat','geo_long','msa','geo_blk','geo_match','err_stat');
EXPORT FieldNum(SALT311.StrType fn) := CASE(fn,'item_source' => 0,'source_code' => 1,'display_name' => 2,'description' => 3,'status' => 4,'data_notes' => 5,'coverage_1' => 6,'coverage_2' => 7,'orbit_item_name' => 8,'orbit_source' => 9,'orbit_number' => 10,'website' => 11,'notes' => 12,'date_added' => 13,'input_file_id' => 14,'market_restrict_flag' => 15,'clean_phone' => 16,'clean_fax' => 17,'prepped_addr1' => 18,'prepped_addr2' => 19,'v_prim_name' => 20,'v_zip' => 21,'v_zip4' => 22,'prim_range' => 23,'predir' => 24,'prim_name' => 25,'addr_suffix' => 26,'postdir' => 27,'unit_desig' => 28,'sec_range' => 29,'p_city_name' => 30,'v_city_name' => 31,'st' => 32,'zip' => 33,'zip4' => 34,'cart' => 35,'cr_sort_sz' => 36,'lot' => 37,'lot_order' => 38,'dbpc' => 39,'chk_digit' => 40,'rec_type' => 41,'county' => 42,'geo_lat' => 43,'geo_long' => 44,'msa' => 45,'geo_blk' => 46,'geo_match' => 47,'err_stat' => 48,0);
EXPORT SET OF SALT311.StrType FieldRules(UNSIGNED2 i) := CHOOSE(i,['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],[]);
EXPORT BOOLEAN InBaseLayout(UNSIGNED2 i) := CHOOSE(i,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,FALSE);
 
//Individual field level validation
 
EXPORT Make_item_source(SALT311.StrType s0) := MakeFT_item_source(s0);
EXPORT InValid_item_source(SALT311.StrType s) := InValidFT_item_source(s);
EXPORT InValidMessage_item_source(UNSIGNED1 wh) := InValidMessageFT_item_source(wh);
 
EXPORT Make_source_code(SALT311.StrType s0) := MakeFT_source_code(s0);
EXPORT InValid_source_code(SALT311.StrType s) := InValidFT_source_code(s);
EXPORT InValidMessage_source_code(UNSIGNED1 wh) := InValidMessageFT_source_code(wh);
 
EXPORT Make_display_name(SALT311.StrType s0) := MakeFT_display_name(s0);
EXPORT InValid_display_name(SALT311.StrType s) := InValidFT_display_name(s);
EXPORT InValidMessage_display_name(UNSIGNED1 wh) := InValidMessageFT_display_name(wh);
 
EXPORT Make_description(SALT311.StrType s0) := MakeFT_description(s0);
EXPORT InValid_description(SALT311.StrType s) := InValidFT_description(s);
EXPORT InValidMessage_description(UNSIGNED1 wh) := InValidMessageFT_description(wh);
 
EXPORT Make_status(SALT311.StrType s0) := MakeFT_status(s0);
EXPORT InValid_status(SALT311.StrType s) := InValidFT_status(s);
EXPORT InValidMessage_status(UNSIGNED1 wh) := InValidMessageFT_status(wh);
 
EXPORT Make_data_notes(SALT311.StrType s0) := MakeFT_data_notes(s0);
EXPORT InValid_data_notes(SALT311.StrType s) := InValidFT_data_notes(s);
EXPORT InValidMessage_data_notes(UNSIGNED1 wh) := InValidMessageFT_data_notes(wh);
 
EXPORT Make_coverage_1(SALT311.StrType s0) := MakeFT_coverage_1(s0);
EXPORT InValid_coverage_1(SALT311.StrType s) := InValidFT_coverage_1(s);
EXPORT InValidMessage_coverage_1(UNSIGNED1 wh) := InValidMessageFT_coverage_1(wh);
 
EXPORT Make_coverage_2(SALT311.StrType s0) := MakeFT_coverage_2(s0);
EXPORT InValid_coverage_2(SALT311.StrType s) := InValidFT_coverage_2(s);
EXPORT InValidMessage_coverage_2(UNSIGNED1 wh) := InValidMessageFT_coverage_2(wh);
 
EXPORT Make_orbit_item_name(SALT311.StrType s0) := MakeFT_orbit_item_name(s0);
EXPORT InValid_orbit_item_name(SALT311.StrType s) := InValidFT_orbit_item_name(s);
EXPORT InValidMessage_orbit_item_name(UNSIGNED1 wh) := InValidMessageFT_orbit_item_name(wh);
 
EXPORT Make_orbit_source(SALT311.StrType s0) := MakeFT_orbit_source(s0);
EXPORT InValid_orbit_source(SALT311.StrType s) := InValidFT_orbit_source(s);
EXPORT InValidMessage_orbit_source(UNSIGNED1 wh) := InValidMessageFT_orbit_source(wh);
 
EXPORT Make_orbit_number(SALT311.StrType s0) := MakeFT_orbit_number(s0);
EXPORT InValid_orbit_number(SALT311.StrType s) := InValidFT_orbit_number(s);
EXPORT InValidMessage_orbit_number(UNSIGNED1 wh) := InValidMessageFT_orbit_number(wh);
 
EXPORT Make_website(SALT311.StrType s0) := MakeFT_website(s0);
EXPORT InValid_website(SALT311.StrType s) := InValidFT_website(s);
EXPORT InValidMessage_website(UNSIGNED1 wh) := InValidMessageFT_website(wh);
 
EXPORT Make_notes(SALT311.StrType s0) := MakeFT_notes(s0);
EXPORT InValid_notes(SALT311.StrType s) := InValidFT_notes(s);
EXPORT InValidMessage_notes(UNSIGNED1 wh) := InValidMessageFT_notes(wh);
 
EXPORT Make_date_added(SALT311.StrType s0) := MakeFT_date_added(s0);
EXPORT InValid_date_added(SALT311.StrType s) := InValidFT_date_added(s);
EXPORT InValidMessage_date_added(UNSIGNED1 wh) := InValidMessageFT_date_added(wh);
 
EXPORT Make_input_file_id(SALT311.StrType s0) := MakeFT_input_file_id(s0);
EXPORT InValid_input_file_id(SALT311.StrType s) := InValidFT_input_file_id(s);
EXPORT InValidMessage_input_file_id(UNSIGNED1 wh) := InValidMessageFT_input_file_id(wh);
 
EXPORT Make_market_restrict_flag(SALT311.StrType s0) := MakeFT_market_restrict_flag(s0);
EXPORT InValid_market_restrict_flag(SALT311.StrType s) := InValidFT_market_restrict_flag(s);
EXPORT InValidMessage_market_restrict_flag(UNSIGNED1 wh) := InValidMessageFT_market_restrict_flag(wh);
 
EXPORT Make_clean_phone(SALT311.StrType s0) := MakeFT_clean_phone(s0);
EXPORT InValid_clean_phone(SALT311.StrType s) := InValidFT_clean_phone(s);
EXPORT InValidMessage_clean_phone(UNSIGNED1 wh) := InValidMessageFT_clean_phone(wh);
 
EXPORT Make_clean_fax(SALT311.StrType s0) := MakeFT_clean_fax(s0);
EXPORT InValid_clean_fax(SALT311.StrType s) := InValidFT_clean_fax(s);
EXPORT InValidMessage_clean_fax(UNSIGNED1 wh) := InValidMessageFT_clean_fax(wh);
 
EXPORT Make_prepped_addr1(SALT311.StrType s0) := MakeFT_prepped_addr1(s0);
EXPORT InValid_prepped_addr1(SALT311.StrType s) := InValidFT_prepped_addr1(s);
EXPORT InValidMessage_prepped_addr1(UNSIGNED1 wh) := InValidMessageFT_prepped_addr1(wh);
 
EXPORT Make_prepped_addr2(SALT311.StrType s0) := MakeFT_prepped_addr2(s0);
EXPORT InValid_prepped_addr2(SALT311.StrType s) := InValidFT_prepped_addr2(s);
EXPORT InValidMessage_prepped_addr2(UNSIGNED1 wh) := InValidMessageFT_prepped_addr2(wh);
 
EXPORT Make_v_prim_name(SALT311.StrType s0) := MakeFT_v_prim_name(s0);
EXPORT InValid_v_prim_name(SALT311.StrType s) := InValidFT_v_prim_name(s);
EXPORT InValidMessage_v_prim_name(UNSIGNED1 wh) := InValidMessageFT_v_prim_name(wh);
 
EXPORT Make_v_zip(SALT311.StrType s0) := MakeFT_v_zip(s0);
EXPORT InValid_v_zip(SALT311.StrType s) := InValidFT_v_zip(s);
EXPORT InValidMessage_v_zip(UNSIGNED1 wh) := InValidMessageFT_v_zip(wh);
 
EXPORT Make_v_zip4(SALT311.StrType s0) := MakeFT_v_zip4(s0);
EXPORT InValid_v_zip4(SALT311.StrType s) := InValidFT_v_zip4(s);
EXPORT InValidMessage_v_zip4(UNSIGNED1 wh) := InValidMessageFT_v_zip4(wh);
 
EXPORT Make_prim_range(SALT311.StrType s0) := MakeFT_prim_range(s0);
EXPORT InValid_prim_range(SALT311.StrType s) := InValidFT_prim_range(s);
EXPORT InValidMessage_prim_range(UNSIGNED1 wh) := InValidMessageFT_prim_range(wh);
 
EXPORT Make_predir(SALT311.StrType s0) := MakeFT_predir(s0);
EXPORT InValid_predir(SALT311.StrType s) := InValidFT_predir(s);
EXPORT InValidMessage_predir(UNSIGNED1 wh) := InValidMessageFT_predir(wh);
 
EXPORT Make_prim_name(SALT311.StrType s0) := MakeFT_prim_name(s0);
EXPORT InValid_prim_name(SALT311.StrType s) := InValidFT_prim_name(s);
EXPORT InValidMessage_prim_name(UNSIGNED1 wh) := InValidMessageFT_prim_name(wh);
 
EXPORT Make_addr_suffix(SALT311.StrType s0) := MakeFT_addr_suffix(s0);
EXPORT InValid_addr_suffix(SALT311.StrType s) := InValidFT_addr_suffix(s);
EXPORT InValidMessage_addr_suffix(UNSIGNED1 wh) := InValidMessageFT_addr_suffix(wh);
 
EXPORT Make_postdir(SALT311.StrType s0) := MakeFT_postdir(s0);
EXPORT InValid_postdir(SALT311.StrType s) := InValidFT_postdir(s);
EXPORT InValidMessage_postdir(UNSIGNED1 wh) := InValidMessageFT_postdir(wh);
 
EXPORT Make_unit_desig(SALT311.StrType s0) := MakeFT_unit_desig(s0);
EXPORT InValid_unit_desig(SALT311.StrType s) := InValidFT_unit_desig(s);
EXPORT InValidMessage_unit_desig(UNSIGNED1 wh) := InValidMessageFT_unit_desig(wh);
 
EXPORT Make_sec_range(SALT311.StrType s0) := MakeFT_sec_range(s0);
EXPORT InValid_sec_range(SALT311.StrType s) := InValidFT_sec_range(s);
EXPORT InValidMessage_sec_range(UNSIGNED1 wh) := InValidMessageFT_sec_range(wh);
 
EXPORT Make_p_city_name(SALT311.StrType s0) := MakeFT_p_city_name(s0);
EXPORT InValid_p_city_name(SALT311.StrType s) := InValidFT_p_city_name(s);
EXPORT InValidMessage_p_city_name(UNSIGNED1 wh) := InValidMessageFT_p_city_name(wh);
 
EXPORT Make_v_city_name(SALT311.StrType s0) := MakeFT_v_city_name(s0);
EXPORT InValid_v_city_name(SALT311.StrType s) := InValidFT_v_city_name(s);
EXPORT InValidMessage_v_city_name(UNSIGNED1 wh) := InValidMessageFT_v_city_name(wh);
 
EXPORT Make_st(SALT311.StrType s0) := MakeFT_st(s0);
EXPORT InValid_st(SALT311.StrType s) := InValidFT_st(s);
EXPORT InValidMessage_st(UNSIGNED1 wh) := InValidMessageFT_st(wh);
 
EXPORT Make_zip(SALT311.StrType s0) := MakeFT_zip(s0);
EXPORT InValid_zip(SALT311.StrType s) := InValidFT_zip(s);
EXPORT InValidMessage_zip(UNSIGNED1 wh) := InValidMessageFT_zip(wh);
 
EXPORT Make_zip4(SALT311.StrType s0) := MakeFT_zip4(s0);
EXPORT InValid_zip4(SALT311.StrType s) := InValidFT_zip4(s);
EXPORT InValidMessage_zip4(UNSIGNED1 wh) := InValidMessageFT_zip4(wh);
 
EXPORT Make_cart(SALT311.StrType s0) := MakeFT_cart(s0);
EXPORT InValid_cart(SALT311.StrType s) := InValidFT_cart(s);
EXPORT InValidMessage_cart(UNSIGNED1 wh) := InValidMessageFT_cart(wh);
 
EXPORT Make_cr_sort_sz(SALT311.StrType s0) := MakeFT_cr_sort_sz(s0);
EXPORT InValid_cr_sort_sz(SALT311.StrType s) := InValidFT_cr_sort_sz(s);
EXPORT InValidMessage_cr_sort_sz(UNSIGNED1 wh) := InValidMessageFT_cr_sort_sz(wh);
 
EXPORT Make_lot(SALT311.StrType s0) := MakeFT_lot(s0);
EXPORT InValid_lot(SALT311.StrType s) := InValidFT_lot(s);
EXPORT InValidMessage_lot(UNSIGNED1 wh) := InValidMessageFT_lot(wh);
 
EXPORT Make_lot_order(SALT311.StrType s0) := MakeFT_lot_order(s0);
EXPORT InValid_lot_order(SALT311.StrType s) := InValidFT_lot_order(s);
EXPORT InValidMessage_lot_order(UNSIGNED1 wh) := InValidMessageFT_lot_order(wh);
 
EXPORT Make_dbpc(SALT311.StrType s0) := MakeFT_dbpc(s0);
EXPORT InValid_dbpc(SALT311.StrType s) := InValidFT_dbpc(s);
EXPORT InValidMessage_dbpc(UNSIGNED1 wh) := InValidMessageFT_dbpc(wh);
 
EXPORT Make_chk_digit(SALT311.StrType s0) := MakeFT_chk_digit(s0);
EXPORT InValid_chk_digit(SALT311.StrType s) := InValidFT_chk_digit(s);
EXPORT InValidMessage_chk_digit(UNSIGNED1 wh) := InValidMessageFT_chk_digit(wh);
 
EXPORT Make_rec_type(SALT311.StrType s0) := MakeFT_rec_type(s0);
EXPORT InValid_rec_type(SALT311.StrType s) := InValidFT_rec_type(s);
EXPORT InValidMessage_rec_type(UNSIGNED1 wh) := InValidMessageFT_rec_type(wh);
 
EXPORT Make_county(SALT311.StrType s0) := MakeFT_county(s0);
EXPORT InValid_county(SALT311.StrType s) := InValidFT_county(s);
EXPORT InValidMessage_county(UNSIGNED1 wh) := InValidMessageFT_county(wh);
 
EXPORT Make_geo_lat(SALT311.StrType s0) := MakeFT_geo_lat(s0);
EXPORT InValid_geo_lat(SALT311.StrType s) := InValidFT_geo_lat(s);
EXPORT InValidMessage_geo_lat(UNSIGNED1 wh) := InValidMessageFT_geo_lat(wh);
 
EXPORT Make_geo_long(SALT311.StrType s0) := MakeFT_geo_long(s0);
EXPORT InValid_geo_long(SALT311.StrType s) := InValidFT_geo_long(s);
EXPORT InValidMessage_geo_long(UNSIGNED1 wh) := InValidMessageFT_geo_long(wh);
 
EXPORT Make_msa(SALT311.StrType s0) := MakeFT_msa(s0);
EXPORT InValid_msa(SALT311.StrType s) := InValidFT_msa(s);
EXPORT InValidMessage_msa(UNSIGNED1 wh) := InValidMessageFT_msa(wh);
 
EXPORT Make_geo_blk(SALT311.StrType s0) := MakeFT_geo_blk(s0);
EXPORT InValid_geo_blk(SALT311.StrType s) := InValidFT_geo_blk(s);
EXPORT InValidMessage_geo_blk(UNSIGNED1 wh) := InValidMessageFT_geo_blk(wh);
 
EXPORT Make_geo_match(SALT311.StrType s0) := MakeFT_geo_match(s0);
EXPORT InValid_geo_match(SALT311.StrType s) := InValidFT_geo_match(s);
EXPORT InValidMessage_geo_match(UNSIGNED1 wh) := InValidMessageFT_geo_match(wh);
 
EXPORT Make_err_stat(SALT311.StrType s0) := MakeFT_err_stat(s0);
EXPORT InValid_err_stat(SALT311.StrType s) := InValidFT_err_stat(s);
EXPORT InValidMessage_err_stat(UNSIGNED1 wh) := InValidMessageFT_err_stat(wh);
 
// This macro will compute and count field level differences based upon a pivot expression
export MAC_CountDifferencesByPivot(in_left,in_right,pivot_exp,bad_pivots,out_counts) := MACRO
  IMPORT SALT311,Scrubs_Vendor_Src;
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
    BOOLEAN Diff_item_source;
    BOOLEAN Diff_source_code;
    BOOLEAN Diff_display_name;
    BOOLEAN Diff_description;
    BOOLEAN Diff_status;
    BOOLEAN Diff_data_notes;
    BOOLEAN Diff_coverage_1;
    BOOLEAN Diff_coverage_2;
    BOOLEAN Diff_orbit_item_name;
    BOOLEAN Diff_orbit_source;
    BOOLEAN Diff_orbit_number;
    BOOLEAN Diff_website;
    BOOLEAN Diff_notes;
    BOOLEAN Diff_date_added;
    BOOLEAN Diff_input_file_id;
    BOOLEAN Diff_market_restrict_flag;
    BOOLEAN Diff_clean_phone;
    BOOLEAN Diff_clean_fax;
    BOOLEAN Diff_prepped_addr1;
    BOOLEAN Diff_prepped_addr2;
    BOOLEAN Diff_v_prim_name;
    BOOLEAN Diff_v_zip;
    BOOLEAN Diff_v_zip4;
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
    UNSIGNED Num_Diffs;
    SALT311.StrType Val {MAXLENGTH(1024)};
  END;
#uniquename(fd)
  %dl% %fd%(in_left le,in_right ri) := TRANSFORM
    SELF.Diff_item_source := le.item_source <> ri.item_source;
    SELF.Diff_source_code := le.source_code <> ri.source_code;
    SELF.Diff_display_name := le.display_name <> ri.display_name;
    SELF.Diff_description := le.description <> ri.description;
    SELF.Diff_status := le.status <> ri.status;
    SELF.Diff_data_notes := le.data_notes <> ri.data_notes;
    SELF.Diff_coverage_1 := le.coverage_1 <> ri.coverage_1;
    SELF.Diff_coverage_2 := le.coverage_2 <> ri.coverage_2;
    SELF.Diff_orbit_item_name := le.orbit_item_name <> ri.orbit_item_name;
    SELF.Diff_orbit_source := le.orbit_source <> ri.orbit_source;
    SELF.Diff_orbit_number := le.orbit_number <> ri.orbit_number;
    SELF.Diff_website := le.website <> ri.website;
    SELF.Diff_notes := le.notes <> ri.notes;
    SELF.Diff_date_added := le.date_added <> ri.date_added;
    SELF.Diff_input_file_id := le.input_file_id <> ri.input_file_id;
    SELF.Diff_market_restrict_flag := le.market_restrict_flag <> ri.market_restrict_flag;
    SELF.Diff_clean_phone := le.clean_phone <> ri.clean_phone;
    SELF.Diff_clean_fax := le.clean_fax <> ri.clean_fax;
    SELF.Diff_prepped_addr1 := le.prepped_addr1 <> ri.prepped_addr1;
    SELF.Diff_prepped_addr2 := le.prepped_addr2 <> ri.prepped_addr2;
    SELF.Diff_v_prim_name := le.v_prim_name <> ri.v_prim_name;
    SELF.Diff_v_zip := le.v_zip <> ri.v_zip;
    SELF.Diff_v_zip4 := le.v_zip4 <> ri.v_zip4;
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
    SELF.Val := (SALT311.StrType)evaluate(le,pivot_exp);
    SELF.Num_Diffs := 0+ IF( SELF.Diff_item_source,1,0)+ IF( SELF.Diff_source_code,1,0)+ IF( SELF.Diff_display_name,1,0)+ IF( SELF.Diff_description,1,0)+ IF( SELF.Diff_status,1,0)+ IF( SELF.Diff_data_notes,1,0)+ IF( SELF.Diff_coverage_1,1,0)+ IF( SELF.Diff_coverage_2,1,0)+ IF( SELF.Diff_orbit_item_name,1,0)+ IF( SELF.Diff_orbit_source,1,0)+ IF( SELF.Diff_orbit_number,1,0)+ IF( SELF.Diff_website,1,0)+ IF( SELF.Diff_notes,1,0)+ IF( SELF.Diff_date_added,1,0)+ IF( SELF.Diff_input_file_id,1,0)+ IF( SELF.Diff_market_restrict_flag,1,0)+ IF( SELF.Diff_clean_phone,1,0)+ IF( SELF.Diff_clean_fax,1,0)+ IF( SELF.Diff_prepped_addr1,1,0)+ IF( SELF.Diff_prepped_addr2,1,0)+ IF( SELF.Diff_v_prim_name,1,0)+ IF( SELF.Diff_v_zip,1,0)+ IF( SELF.Diff_v_zip4,1,0)+ IF( SELF.Diff_prim_range,1,0)+ IF( SELF.Diff_predir,1,0)+ IF( SELF.Diff_prim_name,1,0)+ IF( SELF.Diff_addr_suffix,1,0)+ IF( SELF.Diff_postdir,1,0)+ IF( SELF.Diff_unit_desig,1,0)+ IF( SELF.Diff_sec_range,1,0)+ IF( SELF.Diff_p_city_name,1,0)+ IF( SELF.Diff_v_city_name,1,0)+ IF( SELF.Diff_st,1,0)+ IF( SELF.Diff_zip,1,0)+ IF( SELF.Diff_zip4,1,0)+ IF( SELF.Diff_cart,1,0)+ IF( SELF.Diff_cr_sort_sz,1,0)+ IF( SELF.Diff_lot,1,0)+ IF( SELF.Diff_lot_order,1,0)+ IF( SELF.Diff_dbpc,1,0)+ IF( SELF.Diff_chk_digit,1,0)+ IF( SELF.Diff_rec_type,1,0)+ IF( SELF.Diff_county,1,0)+ IF( SELF.Diff_geo_lat,1,0)+ IF( SELF.Diff_geo_long,1,0)+ IF( SELF.Diff_msa,1,0)+ IF( SELF.Diff_geo_blk,1,0)+ IF( SELF.Diff_geo_match,1,0)+ IF( SELF.Diff_err_stat,1,0);
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
    Count_Diff_item_source := COUNT(GROUP,%Closest%.Diff_item_source);
    Count_Diff_source_code := COUNT(GROUP,%Closest%.Diff_source_code);
    Count_Diff_display_name := COUNT(GROUP,%Closest%.Diff_display_name);
    Count_Diff_description := COUNT(GROUP,%Closest%.Diff_description);
    Count_Diff_status := COUNT(GROUP,%Closest%.Diff_status);
    Count_Diff_data_notes := COUNT(GROUP,%Closest%.Diff_data_notes);
    Count_Diff_coverage_1 := COUNT(GROUP,%Closest%.Diff_coverage_1);
    Count_Diff_coverage_2 := COUNT(GROUP,%Closest%.Diff_coverage_2);
    Count_Diff_orbit_item_name := COUNT(GROUP,%Closest%.Diff_orbit_item_name);
    Count_Diff_orbit_source := COUNT(GROUP,%Closest%.Diff_orbit_source);
    Count_Diff_orbit_number := COUNT(GROUP,%Closest%.Diff_orbit_number);
    Count_Diff_website := COUNT(GROUP,%Closest%.Diff_website);
    Count_Diff_notes := COUNT(GROUP,%Closest%.Diff_notes);
    Count_Diff_date_added := COUNT(GROUP,%Closest%.Diff_date_added);
    Count_Diff_input_file_id := COUNT(GROUP,%Closest%.Diff_input_file_id);
    Count_Diff_market_restrict_flag := COUNT(GROUP,%Closest%.Diff_market_restrict_flag);
    Count_Diff_clean_phone := COUNT(GROUP,%Closest%.Diff_clean_phone);
    Count_Diff_clean_fax := COUNT(GROUP,%Closest%.Diff_clean_fax);
    Count_Diff_prepped_addr1 := COUNT(GROUP,%Closest%.Diff_prepped_addr1);
    Count_Diff_prepped_addr2 := COUNT(GROUP,%Closest%.Diff_prepped_addr2);
    Count_Diff_v_prim_name := COUNT(GROUP,%Closest%.Diff_v_prim_name);
    Count_Diff_v_zip := COUNT(GROUP,%Closest%.Diff_v_zip);
    Count_Diff_v_zip4 := COUNT(GROUP,%Closest%.Diff_v_zip4);
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
  END;
  out_counts := table(%Closest%,%AggRec%,true);
ENDMACRO;
END;
