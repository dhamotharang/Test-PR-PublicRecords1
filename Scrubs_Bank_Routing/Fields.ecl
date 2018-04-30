IMPORT SALT38;
EXPORT Fields := MODULE
 
EXPORT NumFields := 38;
 
// Processing for each FieldType
EXPORT SALT38.StrType FieldTypeName(UNSIGNED2 i) := CHOOSE(i,'DEFAULT','NUMBER','ALPHA','WORDBAG','CITY','ST','NAME','UPPERNAME','STREET_ADDR','FULL_ADDRESS','ZIP5','HASZIP4');
EXPORT FieldTypeNum(SALT38.StrType fn) := CASE(fn,'DEFAULT' => 1,'NUMBER' => 2,'ALPHA' => 3,'WORDBAG' => 4,'CITY' => 5,'ST' => 6,'NAME' => 7,'UPPERNAME' => 8,'STREET_ADDR' => 9,'FULL_ADDRESS' => 10,'ZIP5' => 11,'HASZIP4' => 12,0);
 
EXPORT MakeFT_DEFAULT(SALT38.StrType s0) := FUNCTION
  s1 := if ( SALT38.StringFind('"\'',s0[1],1)>0 and SALT38.StringFind('"\'',s0[LENGTH(TRIM(s0))],1)>0,s0[2..LENGTH(TRIM(s0))-1],s0 );// Remove quotes if required
  s2 := TRIM(s1,LEFT); // Left trim
  RETURN  s2;
END;
EXPORT InValidFT_DEFAULT(SALT38.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,SALT38.StringFind('"\'',s[1],1)<>0 and SALT38.StringFind('"\'',s[LENGTH(TRIM(s))],1)<>0);
EXPORT InValidMessageFT_DEFAULT(UNSIGNED1 wh) := CHOOSE(wh,SALT38.HygieneErrors.NotLeft,SALT38.HygieneErrors.Inquotes('"\''),SALT38.HygieneErrors.Good);
 
EXPORT MakeFT_NUMBER(SALT38.StrType s0) := FUNCTION
  s1 := SALT38.stringfilter(s0,'0123456789'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_NUMBER(SALT38.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT38.StringFilter(s,'0123456789'))));
EXPORT InValidMessageFT_NUMBER(UNSIGNED1 wh) := CHOOSE(wh,SALT38.HygieneErrors.NotInChars('0123456789'),SALT38.HygieneErrors.Good);
 
EXPORT MakeFT_ALPHA(SALT38.StrType s0) := FUNCTION
  s1 := SALT38.stringtouppercase(s0); // Force to upper case
  s2 := SALT38.stringfilter(s1,'ABCDEFGHIJKLMNOPQRSTUVWXYZ'); // Only allow valid symbols
  RETURN  s2;
END;
EXPORT InValidFT_ALPHA(SALT38.StrType s) := WHICH(SALT38.stringtouppercase(s)<>s,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT38.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZ'))));
EXPORT InValidMessageFT_ALPHA(UNSIGNED1 wh) := CHOOSE(wh,SALT38.HygieneErrors.NotCaps,SALT38.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWXYZ'),SALT38.HygieneErrors.Good);
 
EXPORT MakeFT_WORDBAG(SALT38.StrType s0) := FUNCTION
  s1 := SALT38.stringtouppercase(s0); // Force to upper case
  s2 := SALT38.stringfilter(s1,'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789\' <>{}[]-^=!+&,./'); // Only allow valid symbols
  s3 := SALT38.stringcleanspaces( SALT38.stringsubstituteout(s2,' <>{}[]-^=!+&,./',' ') ); // Insert spaces but avoid doubles
  RETURN  s3;
END;
EXPORT InValidFT_WORDBAG(SALT38.StrType s) := WHICH(SALT38.stringtouppercase(s)<>s,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT38.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789\' <>{}[]-^=!+&,./'))));
EXPORT InValidMessageFT_WORDBAG(UNSIGNED1 wh) := CHOOSE(wh,SALT38.HygieneErrors.NotCaps,SALT38.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789\' <>{}[]-^=!+&,./'),SALT38.HygieneErrors.Good);
 
EXPORT MakeFT_CITY(SALT38.StrType s0) := FUNCTION
  s1 := SALT38.stringtouppercase(s0); // Force to upper case
  s2 := SALT38.stringfilter(s1,'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789\' <>{}[]-^=!+&,./'); // Only allow valid symbols
  s3 := SALT38.stringcleanspaces( SALT38.stringsubstituteout(s2,' <>{}[]-^=!+&,./',' ') ); // Insert spaces but avoid doubles
  RETURN  MakeFT_WORDBAG(s3);
END;
EXPORT InValidFT_CITY(SALT38.StrType s) := WHICH(SALT38.stringtouppercase(s)<>s,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT38.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789\' <>{}[]-^=!+&,./'))),~(LENGTH(TRIM(s)) = 0 OR LENGTH(TRIM(s)) >= 4),~(SALT38.WordCount(SALT38.StringSubstituteOut(s,' <>{}[]-^=!+&,./',' ')) >= 0 AND SALT38.WordCount(SALT38.StringSubstituteOut(s,' <>{}[]-^=!+&,./',' ')) <= 3));
EXPORT InValidMessageFT_CITY(UNSIGNED1 wh) := CHOOSE(wh,SALT38.HygieneErrors.NotCaps,SALT38.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789\' <>{}[]-^=!+&,./'),SALT38.HygieneErrors.NotLength('0,4..'),SALT38.HygieneErrors.NotWords('0..3'),SALT38.HygieneErrors.Good);
 
EXPORT MakeFT_ST(SALT38.StrType s0) := FUNCTION
  s1 := SALT38.stringtouppercase(s0); // Force to upper case
  s2 := SALT38.stringfilter(s1,'ABCDEFGHIJKLMNOPQRSTUVWXYZ&.,;: -'); // Only allow valid symbols
  s3 := SALT38.stringcleanspaces( SALT38.stringsubstituteout(s2,'&.,;: -',' ') ); // Insert spaces but avoid doubles
  RETURN  MakeFT_ALPHA(s3);
END;
EXPORT InValidFT_ST(SALT38.StrType s) := WHICH(SALT38.stringtouppercase(s)<>s,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT38.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZ&.,;: -'))),~(LENGTH(TRIM(s)) = 0 OR LENGTH(TRIM(s)) >= 2),~(SALT38.WordCount(SALT38.StringSubstituteOut(s,'&.,;: -',' ')) = 1));
EXPORT InValidMessageFT_ST(UNSIGNED1 wh) := CHOOSE(wh,SALT38.HygieneErrors.NotCaps,SALT38.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWXYZ&.,;: -'),SALT38.HygieneErrors.NotLength('0,2..'),SALT38.HygieneErrors.NotWords('1'),SALT38.HygieneErrors.Good);
 
EXPORT MakeFT_NAME(SALT38.StrType s0) := FUNCTION
  s1 := SALT38.stringtouppercase(s0); // Force to upper case
  s2 := SALT38.stringfilter(s1,'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789\' <>{}[]-^=!+&,./'); // Only allow valid symbols
  s3 := SALT38.stringcleanspaces( SALT38.stringsubstituteout(s2,' <>{}[]-^=!+&,./',' ') ); // Insert spaces but avoid doubles
  RETURN  MakeFT_WORDBAG(s3);
END;
EXPORT InValidFT_NAME(SALT38.StrType s) := WHICH(SALT38.stringtouppercase(s)<>s,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT38.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789\' <>{}[]-^=!+&,./'))));
EXPORT InValidMessageFT_NAME(UNSIGNED1 wh) := CHOOSE(wh,SALT38.HygieneErrors.NotCaps,SALT38.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789\' <>{}[]-^=!+&,./'),SALT38.HygieneErrors.Good);
 
EXPORT MakeFT_UPPERNAME(SALT38.StrType s0) := FUNCTION
  s1 := SALT38.stringtouppercase(s0); // Force to upper case
  s2 := SALT38.stringfilter(s1,'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789\' <>{}[]-^=!+&,./'); // Only allow valid symbols
  s3 := SALT38.stringcleanspaces( SALT38.stringsubstituteout(s2,' <>{}[]-^=!+&,./',' ') ); // Insert spaces but avoid doubles
  RETURN  MakeFT_WORDBAG(s3);
END;
EXPORT InValidFT_UPPERNAME(SALT38.StrType s) := WHICH(SALT38.stringtouppercase(s)<>s,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT38.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789\' <>{}[]-^=!+&,./'))));
EXPORT InValidMessageFT_UPPERNAME(UNSIGNED1 wh) := CHOOSE(wh,SALT38.HygieneErrors.NotCaps,SALT38.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789\' <>{}[]-^=!+&,./'),SALT38.HygieneErrors.Good);
 
EXPORT MakeFT_STREET_ADDR(SALT38.StrType s0) := FUNCTION
  s1 := SALT38.stringtouppercase(s0); // Force to upper case
  s2 := SALT38.stringfilter(s1,'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789\' <>{}[]-^=!+&,./'); // Only allow valid symbols
  s3 := SALT38.stringcleanspaces( SALT38.stringsubstituteout(s2,' <>{}[]-^=!+&,./',' ') ); // Insert spaces but avoid doubles
  RETURN  MakeFT_WORDBAG(s3);
END;
EXPORT InValidFT_STREET_ADDR(SALT38.StrType s) := WHICH(SALT38.stringtouppercase(s)<>s,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT38.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789\' <>{}[]-^=!+&,./'))));
EXPORT InValidMessageFT_STREET_ADDR(UNSIGNED1 wh) := CHOOSE(wh,SALT38.HygieneErrors.NotCaps,SALT38.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789\' <>{}[]-^=!+&,./'),SALT38.HygieneErrors.Good);
 
EXPORT MakeFT_FULL_ADDRESS(SALT38.StrType s0) := FUNCTION
  s1 := SALT38.stringtouppercase(s0); // Force to upper case
  s2 := SALT38.stringfilter(s1,'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789\' <>{}[]-^=!+&,./'); // Only allow valid symbols
  s3 := SALT38.stringcleanspaces( SALT38.stringsubstituteout(s2,' <>{}[]-^=!+&,./',' ') ); // Insert spaces but avoid doubles
  RETURN  MakeFT_WORDBAG(s3);
END;
EXPORT InValidFT_FULL_ADDRESS(SALT38.StrType s) := WHICH(SALT38.stringtouppercase(s)<>s,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT38.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789\' <>{}[]-^=!+&,./'))));
EXPORT InValidMessageFT_FULL_ADDRESS(UNSIGNED1 wh) := CHOOSE(wh,SALT38.HygieneErrors.NotCaps,SALT38.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789\' <>{}[]-^=!+&,./'),SALT38.HygieneErrors.Good);
 
EXPORT MakeFT_ZIP5(SALT38.StrType s0) := FUNCTION
  s1 := SALT38.stringfilter(s0,'0123456789'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_ZIP5(SALT38.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT38.StringFilter(s,'0123456789'))),~(LENGTH(TRIM(s)) = 0 OR LENGTH(TRIM(s)) = 5));
EXPORT InValidMessageFT_ZIP5(UNSIGNED1 wh) := CHOOSE(wh,SALT38.HygieneErrors.NotInChars('0123456789'),SALT38.HygieneErrors.NotLength('0,5'),SALT38.HygieneErrors.Good);
 
EXPORT MakeFT_HASZIP4(SALT38.StrType s0) := FUNCTION
  s1 := SALT38.stringfilter(s0,'0123456789'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_HASZIP4(SALT38.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT38.StringFilter(s,'0123456789'))),~(LENGTH(TRIM(s)) = 0 OR LENGTH(TRIM(s)) = 4));
EXPORT InValidMessageFT_HASZIP4(UNSIGNED1 wh) := CHOOSE(wh,SALT38.HygieneErrors.NotInChars('0123456789'),SALT38.HygieneErrors.NotLength('0,4'),SALT38.HygieneErrors.Good);
 
EXPORT SALT38.StrType FieldName(UNSIGNED2 i) := CHOOSE(i,'file_key','dt_first_seen','dt_last_seen','dt_vendor_first_reported','dt_vendor_last_reported','date_updated','type_instituon_code','head_office_branch_codes','routing_number_micr','routing_number_fractional','institution_name_full','institution_name_abbreviated','street_address','city_town','state','zip_code','zip_4','mail_address','mail_city_town','mail_state','mail_zip_code','mail_zip_4','branch_office_name','head_office_routing_number','phone_number_area_code','phone_number','phone_number_extension','fax_area_code','fax_number','fax_extension','head_office_asset_size','federal_reserve_district_code','year_2000_date_last_updated','head_office_file_key','routing_number_type','routing_number_status','employer_tax_id','institution_identifier');
EXPORT SALT38.StrType FlatName(UNSIGNED2 i) := CHOOSE(i,'file_key','dt_first_seen','dt_last_seen','dt_vendor_first_reported','dt_vendor_last_reported','date_updated','type_instituon_code','head_office_branch_codes','routing_number_micr','routing_number_fractional','institution_name_full','institution_name_abbreviated','street_address','city_town','state','zip_code','zip_4','mail_address','mail_city_town','mail_state','mail_zip_code','mail_zip_4','branch_office_name','head_office_routing_number','phone_number_area_code','phone_number','phone_number_extension','fax_area_code','fax_number','fax_extension','head_office_asset_size','federal_reserve_district_code','year_2000_date_last_updated','head_office_file_key','routing_number_type','routing_number_status','employer_tax_id','institution_identifier');
EXPORT FieldNum(SALT38.StrType fn) := CASE(fn,'file_key' => 0,'dt_first_seen' => 1,'dt_last_seen' => 2,'dt_vendor_first_reported' => 3,'dt_vendor_last_reported' => 4,'date_updated' => 5,'type_instituon_code' => 6,'head_office_branch_codes' => 7,'routing_number_micr' => 8,'routing_number_fractional' => 9,'institution_name_full' => 10,'institution_name_abbreviated' => 11,'street_address' => 12,'city_town' => 13,'state' => 14,'zip_code' => 15,'zip_4' => 16,'mail_address' => 17,'mail_city_town' => 18,'mail_state' => 19,'mail_zip_code' => 20,'mail_zip_4' => 21,'branch_office_name' => 22,'head_office_routing_number' => 23,'phone_number_area_code' => 24,'phone_number' => 25,'phone_number_extension' => 26,'fax_area_code' => 27,'fax_number' => 28,'fax_extension' => 29,'head_office_asset_size' => 30,'federal_reserve_district_code' => 31,'year_2000_date_last_updated' => 32,'head_office_file_key' => 33,'routing_number_type' => 34,'routing_number_status' => 35,'employer_tax_id' => 36,'institution_identifier' => 37,0);
EXPORT SET OF SALT38.StrType FieldRules(UNSIGNED2 i) := CHOOSE(i,['ALLOW'],['LEFTTRIM','QUOTES'],['LEFTTRIM','QUOTES'],['LEFTTRIM','QUOTES'],['LEFTTRIM','QUOTES'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['CAPS','ALLOW'],['CAPS','ALLOW'],['CAPS','ALLOW'],['CAPS','ALLOW','LENGTH','WORDS'],['CAPS','ALLOW','LENGTH','WORDS'],['ALLOW','LENGTH'],['ALLOW','LENGTH'],['CAPS','ALLOW'],['CAPS','ALLOW','LENGTH','WORDS'],['CAPS','ALLOW','LENGTH','WORDS'],['ALLOW','LENGTH'],['ALLOW','LENGTH'],['CAPS','ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['LEFTTRIM','QUOTES'],['ALLOW'],['ALLOW'],['CAPS','ALLOW'],['CAPS','ALLOW'],['ALLOW'],['ALLOW'],[]);
EXPORT BOOLEAN InBaseLayout(UNSIGNED2 i) := CHOOSE(i,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,FALSE);
 
//Individual field level validation
 
EXPORT Make_file_key(SALT38.StrType s0) := MakeFT_NUMBER(s0);
EXPORT InValid_file_key(SALT38.StrType s) := InValidFT_NUMBER(s);
EXPORT InValidMessage_file_key(UNSIGNED1 wh) := InValidMessageFT_NUMBER(wh);
 
EXPORT Make_dt_first_seen(SALT38.StrType s0) := MakeFT_DEFAULT(s0);
EXPORT InValid_dt_first_seen(SALT38.StrType s) := InValidFT_DEFAULT(s);
EXPORT InValidMessage_dt_first_seen(UNSIGNED1 wh) := InValidMessageFT_DEFAULT(wh);
 
EXPORT Make_dt_last_seen(SALT38.StrType s0) := MakeFT_DEFAULT(s0);
EXPORT InValid_dt_last_seen(SALT38.StrType s) := InValidFT_DEFAULT(s);
EXPORT InValidMessage_dt_last_seen(UNSIGNED1 wh) := InValidMessageFT_DEFAULT(wh);
 
EXPORT Make_dt_vendor_first_reported(SALT38.StrType s0) := MakeFT_DEFAULT(s0);
EXPORT InValid_dt_vendor_first_reported(SALT38.StrType s) := InValidFT_DEFAULT(s);
EXPORT InValidMessage_dt_vendor_first_reported(UNSIGNED1 wh) := InValidMessageFT_DEFAULT(wh);
 
EXPORT Make_dt_vendor_last_reported(SALT38.StrType s0) := MakeFT_DEFAULT(s0);
EXPORT InValid_dt_vendor_last_reported(SALT38.StrType s) := InValidFT_DEFAULT(s);
EXPORT InValidMessage_dt_vendor_last_reported(UNSIGNED1 wh) := InValidMessageFT_DEFAULT(wh);
 
EXPORT Make_date_updated(SALT38.StrType s0) := MakeFT_NUMBER(s0);
EXPORT InValid_date_updated(SALT38.StrType s) := InValidFT_NUMBER(s);
EXPORT InValidMessage_date_updated(UNSIGNED1 wh) := InValidMessageFT_NUMBER(wh);
 
EXPORT Make_type_instituon_code(SALT38.StrType s0) := MakeFT_NUMBER(s0);
EXPORT InValid_type_instituon_code(SALT38.StrType s) := InValidFT_NUMBER(s);
EXPORT InValidMessage_type_instituon_code(UNSIGNED1 wh) := InValidMessageFT_NUMBER(wh);
 
EXPORT Make_head_office_branch_codes(SALT38.StrType s0) := MakeFT_NUMBER(s0);
EXPORT InValid_head_office_branch_codes(SALT38.StrType s) := InValidFT_NUMBER(s);
EXPORT InValidMessage_head_office_branch_codes(UNSIGNED1 wh) := InValidMessageFT_NUMBER(wh);
 
EXPORT Make_routing_number_micr(SALT38.StrType s0) := MakeFT_NUMBER(s0);
EXPORT InValid_routing_number_micr(SALT38.StrType s) := InValidFT_NUMBER(s);
EXPORT InValidMessage_routing_number_micr(UNSIGNED1 wh) := InValidMessageFT_NUMBER(wh);
 
EXPORT Make_routing_number_fractional(SALT38.StrType s0) := MakeFT_NUMBER(s0);
EXPORT InValid_routing_number_fractional(SALT38.StrType s) := InValidFT_NUMBER(s);
EXPORT InValidMessage_routing_number_fractional(UNSIGNED1 wh) := InValidMessageFT_NUMBER(wh);
 
EXPORT Make_institution_name_full(SALT38.StrType s0) := MakeFT_UPPERNAME(s0);
EXPORT InValid_institution_name_full(SALT38.StrType s) := InValidFT_UPPERNAME(s);
EXPORT InValidMessage_institution_name_full(UNSIGNED1 wh) := InValidMessageFT_UPPERNAME(wh);
 
EXPORT Make_institution_name_abbreviated(SALT38.StrType s0) := MakeFT_UPPERNAME(s0);
EXPORT InValid_institution_name_abbreviated(SALT38.StrType s) := InValidFT_UPPERNAME(s);
EXPORT InValidMessage_institution_name_abbreviated(UNSIGNED1 wh) := InValidMessageFT_UPPERNAME(wh);
 
EXPORT Make_street_address(SALT38.StrType s0) := MakeFT_STREET_ADDR(s0);
EXPORT InValid_street_address(SALT38.StrType s) := InValidFT_STREET_ADDR(s);
EXPORT InValidMessage_street_address(UNSIGNED1 wh) := InValidMessageFT_STREET_ADDR(wh);
 
EXPORT Make_city_town(SALT38.StrType s0) := MakeFT_CITY(s0);
EXPORT InValid_city_town(SALT38.StrType s) := InValidFT_CITY(s);
EXPORT InValidMessage_city_town(UNSIGNED1 wh) := InValidMessageFT_CITY(wh);
 
EXPORT Make_state(SALT38.StrType s0) := MakeFT_ST(s0);
EXPORT InValid_state(SALT38.StrType s) := InValidFT_ST(s);
EXPORT InValidMessage_state(UNSIGNED1 wh) := InValidMessageFT_ST(wh);
 
EXPORT Make_zip_code(SALT38.StrType s0) := MakeFT_ZIP5(s0);
EXPORT InValid_zip_code(SALT38.StrType s) := InValidFT_ZIP5(s);
EXPORT InValidMessage_zip_code(UNSIGNED1 wh) := InValidMessageFT_ZIP5(wh);
 
EXPORT Make_zip_4(SALT38.StrType s0) := MakeFT_HASZIP4(s0);
EXPORT InValid_zip_4(SALT38.StrType s) := InValidFT_HASZIP4(s);
EXPORT InValidMessage_zip_4(UNSIGNED1 wh) := InValidMessageFT_HASZIP4(wh);
 
EXPORT Make_mail_address(SALT38.StrType s0) := MakeFT_STREET_ADDR(s0);
EXPORT InValid_mail_address(SALT38.StrType s) := InValidFT_STREET_ADDR(s);
EXPORT InValidMessage_mail_address(UNSIGNED1 wh) := InValidMessageFT_STREET_ADDR(wh);
 
EXPORT Make_mail_city_town(SALT38.StrType s0) := MakeFT_CITY(s0);
EXPORT InValid_mail_city_town(SALT38.StrType s) := InValidFT_CITY(s);
EXPORT InValidMessage_mail_city_town(UNSIGNED1 wh) := InValidMessageFT_CITY(wh);
 
EXPORT Make_mail_state(SALT38.StrType s0) := MakeFT_ST(s0);
EXPORT InValid_mail_state(SALT38.StrType s) := InValidFT_ST(s);
EXPORT InValidMessage_mail_state(UNSIGNED1 wh) := InValidMessageFT_ST(wh);
 
EXPORT Make_mail_zip_code(SALT38.StrType s0) := MakeFT_ZIP5(s0);
EXPORT InValid_mail_zip_code(SALT38.StrType s) := InValidFT_ZIP5(s);
EXPORT InValidMessage_mail_zip_code(UNSIGNED1 wh) := InValidMessageFT_ZIP5(wh);
 
EXPORT Make_mail_zip_4(SALT38.StrType s0) := MakeFT_HASZIP4(s0);
EXPORT InValid_mail_zip_4(SALT38.StrType s) := InValidFT_HASZIP4(s);
EXPORT InValidMessage_mail_zip_4(UNSIGNED1 wh) := InValidMessageFT_HASZIP4(wh);
 
EXPORT Make_branch_office_name(SALT38.StrType s0) := MakeFT_UPPERNAME(s0);
EXPORT InValid_branch_office_name(SALT38.StrType s) := InValidFT_UPPERNAME(s);
EXPORT InValidMessage_branch_office_name(UNSIGNED1 wh) := InValidMessageFT_UPPERNAME(wh);
 
EXPORT Make_head_office_routing_number(SALT38.StrType s0) := MakeFT_NUMBER(s0);
EXPORT InValid_head_office_routing_number(SALT38.StrType s) := InValidFT_NUMBER(s);
EXPORT InValidMessage_head_office_routing_number(UNSIGNED1 wh) := InValidMessageFT_NUMBER(wh);
 
EXPORT Make_phone_number_area_code(SALT38.StrType s0) := MakeFT_NUMBER(s0);
EXPORT InValid_phone_number_area_code(SALT38.StrType s) := InValidFT_NUMBER(s);
EXPORT InValidMessage_phone_number_area_code(UNSIGNED1 wh) := InValidMessageFT_NUMBER(wh);
 
EXPORT Make_phone_number(SALT38.StrType s0) := MakeFT_NUMBER(s0);
EXPORT InValid_phone_number(SALT38.StrType s) := InValidFT_NUMBER(s);
EXPORT InValidMessage_phone_number(UNSIGNED1 wh) := InValidMessageFT_NUMBER(wh);
 
EXPORT Make_phone_number_extension(SALT38.StrType s0) := MakeFT_NUMBER(s0);
EXPORT InValid_phone_number_extension(SALT38.StrType s) := InValidFT_NUMBER(s);
EXPORT InValidMessage_phone_number_extension(UNSIGNED1 wh) := InValidMessageFT_NUMBER(wh);
 
EXPORT Make_fax_area_code(SALT38.StrType s0) := MakeFT_NUMBER(s0);
EXPORT InValid_fax_area_code(SALT38.StrType s) := InValidFT_NUMBER(s);
EXPORT InValidMessage_fax_area_code(UNSIGNED1 wh) := InValidMessageFT_NUMBER(wh);
 
EXPORT Make_fax_number(SALT38.StrType s0) := MakeFT_NUMBER(s0);
EXPORT InValid_fax_number(SALT38.StrType s) := InValidFT_NUMBER(s);
EXPORT InValidMessage_fax_number(UNSIGNED1 wh) := InValidMessageFT_NUMBER(wh);
 
EXPORT Make_fax_extension(SALT38.StrType s0) := MakeFT_NUMBER(s0);
EXPORT InValid_fax_extension(SALT38.StrType s) := InValidFT_NUMBER(s);
EXPORT InValidMessage_fax_extension(UNSIGNED1 wh) := InValidMessageFT_NUMBER(wh);
 
EXPORT Make_head_office_asset_size(SALT38.StrType s0) := MakeFT_NUMBER(s0);
EXPORT InValid_head_office_asset_size(SALT38.StrType s) := InValidFT_NUMBER(s);
EXPORT InValidMessage_head_office_asset_size(UNSIGNED1 wh) := InValidMessageFT_NUMBER(wh);
 
EXPORT Make_federal_reserve_district_code(SALT38.StrType s0) := MakeFT_DEFAULT(s0);
EXPORT InValid_federal_reserve_district_code(SALT38.StrType s) := InValidFT_DEFAULT(s);
EXPORT InValidMessage_federal_reserve_district_code(UNSIGNED1 wh) := InValidMessageFT_DEFAULT(wh);
 
EXPORT Make_year_2000_date_last_updated(SALT38.StrType s0) := MakeFT_NUMBER(s0);
EXPORT InValid_year_2000_date_last_updated(SALT38.StrType s) := InValidFT_NUMBER(s);
EXPORT InValidMessage_year_2000_date_last_updated(UNSIGNED1 wh) := InValidMessageFT_NUMBER(wh);
 
EXPORT Make_head_office_file_key(SALT38.StrType s0) := MakeFT_NUMBER(s0);
EXPORT InValid_head_office_file_key(SALT38.StrType s) := InValidFT_NUMBER(s);
EXPORT InValidMessage_head_office_file_key(UNSIGNED1 wh) := InValidMessageFT_NUMBER(wh);
 
EXPORT Make_routing_number_type(SALT38.StrType s0) := MakeFT_UPPERNAME(s0);
EXPORT InValid_routing_number_type(SALT38.StrType s) := InValidFT_UPPERNAME(s);
EXPORT InValidMessage_routing_number_type(UNSIGNED1 wh) := InValidMessageFT_UPPERNAME(wh);
 
EXPORT Make_routing_number_status(SALT38.StrType s0) := MakeFT_ALPHA(s0);
EXPORT InValid_routing_number_status(SALT38.StrType s) := InValidFT_ALPHA(s);
EXPORT InValidMessage_routing_number_status(UNSIGNED1 wh) := InValidMessageFT_ALPHA(wh);
 
EXPORT Make_employer_tax_id(SALT38.StrType s0) := MakeFT_NUMBER(s0);
EXPORT InValid_employer_tax_id(SALT38.StrType s) := InValidFT_NUMBER(s);
EXPORT InValidMessage_employer_tax_id(UNSIGNED1 wh) := InValidMessageFT_NUMBER(wh);
 
EXPORT Make_institution_identifier(SALT38.StrType s0) := MakeFT_NUMBER(s0);
EXPORT InValid_institution_identifier(SALT38.StrType s) := InValidFT_NUMBER(s);
EXPORT InValidMessage_institution_identifier(UNSIGNED1 wh) := InValidMessageFT_NUMBER(wh);
 
// This macro will compute and count field level differences based upon a pivot expression
export MAC_CountDifferencesByPivot(in_left,in_right,pivot_exp,bad_pivots,out_counts) := MACRO
  IMPORT SALT38,scrubs_bank_routing;
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
    BOOLEAN Diff_file_key;
    BOOLEAN Diff_dt_first_seen;
    BOOLEAN Diff_dt_last_seen;
    BOOLEAN Diff_dt_vendor_first_reported;
    BOOLEAN Diff_dt_vendor_last_reported;
    BOOLEAN Diff_date_updated;
    BOOLEAN Diff_type_instituon_code;
    BOOLEAN Diff_head_office_branch_codes;
    BOOLEAN Diff_routing_number_micr;
    BOOLEAN Diff_routing_number_fractional;
    BOOLEAN Diff_institution_name_full;
    BOOLEAN Diff_institution_name_abbreviated;
    BOOLEAN Diff_street_address;
    BOOLEAN Diff_city_town;
    BOOLEAN Diff_state;
    BOOLEAN Diff_zip_code;
    BOOLEAN Diff_zip_4;
    BOOLEAN Diff_mail_address;
    BOOLEAN Diff_mail_city_town;
    BOOLEAN Diff_mail_state;
    BOOLEAN Diff_mail_zip_code;
    BOOLEAN Diff_mail_zip_4;
    BOOLEAN Diff_branch_office_name;
    BOOLEAN Diff_head_office_routing_number;
    BOOLEAN Diff_phone_number_area_code;
    BOOLEAN Diff_phone_number;
    BOOLEAN Diff_phone_number_extension;
    BOOLEAN Diff_fax_area_code;
    BOOLEAN Diff_fax_number;
    BOOLEAN Diff_fax_extension;
    BOOLEAN Diff_head_office_asset_size;
    BOOLEAN Diff_federal_reserve_district_code;
    BOOLEAN Diff_year_2000_date_last_updated;
    BOOLEAN Diff_head_office_file_key;
    BOOLEAN Diff_routing_number_type;
    BOOLEAN Diff_routing_number_status;
    BOOLEAN Diff_employer_tax_id;
    BOOLEAN Diff_institution_identifier;
    UNSIGNED Num_Diffs;
    SALT38.StrType Val {MAXLENGTH(1024)};
  END;
#uniquename(fd)
  %dl% %fd%(in_left le,in_right ri) := TRANSFORM
    SELF.Diff_file_key := le.file_key <> ri.file_key;
    SELF.Diff_dt_first_seen := le.dt_first_seen <> ri.dt_first_seen;
    SELF.Diff_dt_last_seen := le.dt_last_seen <> ri.dt_last_seen;
    SELF.Diff_dt_vendor_first_reported := le.dt_vendor_first_reported <> ri.dt_vendor_first_reported;
    SELF.Diff_dt_vendor_last_reported := le.dt_vendor_last_reported <> ri.dt_vendor_last_reported;
    SELF.Diff_date_updated := le.date_updated <> ri.date_updated;
    SELF.Diff_type_instituon_code := le.type_instituon_code <> ri.type_instituon_code;
    SELF.Diff_head_office_branch_codes := le.head_office_branch_codes <> ri.head_office_branch_codes;
    SELF.Diff_routing_number_micr := le.routing_number_micr <> ri.routing_number_micr;
    SELF.Diff_routing_number_fractional := le.routing_number_fractional <> ri.routing_number_fractional;
    SELF.Diff_institution_name_full := le.institution_name_full <> ri.institution_name_full;
    SELF.Diff_institution_name_abbreviated := le.institution_name_abbreviated <> ri.institution_name_abbreviated;
    SELF.Diff_street_address := le.street_address <> ri.street_address;
    SELF.Diff_city_town := le.city_town <> ri.city_town;
    SELF.Diff_state := le.state <> ri.state;
    SELF.Diff_zip_code := le.zip_code <> ri.zip_code;
    SELF.Diff_zip_4 := le.zip_4 <> ri.zip_4;
    SELF.Diff_mail_address := le.mail_address <> ri.mail_address;
    SELF.Diff_mail_city_town := le.mail_city_town <> ri.mail_city_town;
    SELF.Diff_mail_state := le.mail_state <> ri.mail_state;
    SELF.Diff_mail_zip_code := le.mail_zip_code <> ri.mail_zip_code;
    SELF.Diff_mail_zip_4 := le.mail_zip_4 <> ri.mail_zip_4;
    SELF.Diff_branch_office_name := le.branch_office_name <> ri.branch_office_name;
    SELF.Diff_head_office_routing_number := le.head_office_routing_number <> ri.head_office_routing_number;
    SELF.Diff_phone_number_area_code := le.phone_number_area_code <> ri.phone_number_area_code;
    SELF.Diff_phone_number := le.phone_number <> ri.phone_number;
    SELF.Diff_phone_number_extension := le.phone_number_extension <> ri.phone_number_extension;
    SELF.Diff_fax_area_code := le.fax_area_code <> ri.fax_area_code;
    SELF.Diff_fax_number := le.fax_number <> ri.fax_number;
    SELF.Diff_fax_extension := le.fax_extension <> ri.fax_extension;
    SELF.Diff_head_office_asset_size := le.head_office_asset_size <> ri.head_office_asset_size;
    SELF.Diff_federal_reserve_district_code := le.federal_reserve_district_code <> ri.federal_reserve_district_code;
    SELF.Diff_year_2000_date_last_updated := le.year_2000_date_last_updated <> ri.year_2000_date_last_updated;
    SELF.Diff_head_office_file_key := le.head_office_file_key <> ri.head_office_file_key;
    SELF.Diff_routing_number_type := le.routing_number_type <> ri.routing_number_type;
    SELF.Diff_routing_number_status := le.routing_number_status <> ri.routing_number_status;
    SELF.Diff_employer_tax_id := le.employer_tax_id <> ri.employer_tax_id;
    SELF.Diff_institution_identifier := le.institution_identifier <> ri.institution_identifier;
    SELF.Val := (SALT38.StrType)evaluate(le,pivot_exp);
    SELF.Num_Diffs := 0+ IF( SELF.Diff_file_key,1,0)+ IF( SELF.Diff_date_updated,1,0)+ IF( SELF.Diff_type_instituon_code,1,0)+ IF( SELF.Diff_head_office_branch_codes,1,0)+ IF( SELF.Diff_routing_number_micr,1,0)+ IF( SELF.Diff_routing_number_fractional,1,0)+ IF( SELF.Diff_institution_name_full,1,0)+ IF( SELF.Diff_institution_name_abbreviated,1,0)+ IF( SELF.Diff_street_address,1,0)+ IF( SELF.Diff_city_town,1,0)+ IF( SELF.Diff_state,1,0)+ IF( SELF.Diff_zip_code,1,0)+ IF( SELF.Diff_zip_4,1,0)+ IF( SELF.Diff_mail_address,1,0)+ IF( SELF.Diff_mail_city_town,1,0)+ IF( SELF.Diff_mail_state,1,0)+ IF( SELF.Diff_mail_zip_code,1,0)+ IF( SELF.Diff_mail_zip_4,1,0)+ IF( SELF.Diff_branch_office_name,1,0)+ IF( SELF.Diff_head_office_routing_number,1,0)+ IF( SELF.Diff_phone_number_area_code,1,0)+ IF( SELF.Diff_phone_number,1,0)+ IF( SELF.Diff_phone_number_extension,1,0)+ IF( SELF.Diff_fax_area_code,1,0)+ IF( SELF.Diff_fax_number,1,0)+ IF( SELF.Diff_fax_extension,1,0)+ IF( SELF.Diff_head_office_asset_size,1,0)+ IF( SELF.Diff_federal_reserve_district_code,1,0)+ IF( SELF.Diff_year_2000_date_last_updated,1,0)+ IF( SELF.Diff_head_office_file_key,1,0)+ IF( SELF.Diff_routing_number_type,1,0)+ IF( SELF.Diff_routing_number_status,1,0)+ IF( SELF.Diff_employer_tax_id,1,0)+ IF( SELF.Diff_institution_identifier,1,0);
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
    Count_Diff_file_key := COUNT(GROUP,%Closest%.Diff_file_key);
    Count_Diff_dt_first_seen := COUNT(GROUP,%Closest%.Diff_dt_first_seen);
    Count_Diff_dt_last_seen := COUNT(GROUP,%Closest%.Diff_dt_last_seen);
    Count_Diff_dt_vendor_first_reported := COUNT(GROUP,%Closest%.Diff_dt_vendor_first_reported);
    Count_Diff_dt_vendor_last_reported := COUNT(GROUP,%Closest%.Diff_dt_vendor_last_reported);
    Count_Diff_date_updated := COUNT(GROUP,%Closest%.Diff_date_updated);
    Count_Diff_type_instituon_code := COUNT(GROUP,%Closest%.Diff_type_instituon_code);
    Count_Diff_head_office_branch_codes := COUNT(GROUP,%Closest%.Diff_head_office_branch_codes);
    Count_Diff_routing_number_micr := COUNT(GROUP,%Closest%.Diff_routing_number_micr);
    Count_Diff_routing_number_fractional := COUNT(GROUP,%Closest%.Diff_routing_number_fractional);
    Count_Diff_institution_name_full := COUNT(GROUP,%Closest%.Diff_institution_name_full);
    Count_Diff_institution_name_abbreviated := COUNT(GROUP,%Closest%.Diff_institution_name_abbreviated);
    Count_Diff_street_address := COUNT(GROUP,%Closest%.Diff_street_address);
    Count_Diff_city_town := COUNT(GROUP,%Closest%.Diff_city_town);
    Count_Diff_state := COUNT(GROUP,%Closest%.Diff_state);
    Count_Diff_zip_code := COUNT(GROUP,%Closest%.Diff_zip_code);
    Count_Diff_zip_4 := COUNT(GROUP,%Closest%.Diff_zip_4);
    Count_Diff_mail_address := COUNT(GROUP,%Closest%.Diff_mail_address);
    Count_Diff_mail_city_town := COUNT(GROUP,%Closest%.Diff_mail_city_town);
    Count_Diff_mail_state := COUNT(GROUP,%Closest%.Diff_mail_state);
    Count_Diff_mail_zip_code := COUNT(GROUP,%Closest%.Diff_mail_zip_code);
    Count_Diff_mail_zip_4 := COUNT(GROUP,%Closest%.Diff_mail_zip_4);
    Count_Diff_branch_office_name := COUNT(GROUP,%Closest%.Diff_branch_office_name);
    Count_Diff_head_office_routing_number := COUNT(GROUP,%Closest%.Diff_head_office_routing_number);
    Count_Diff_phone_number_area_code := COUNT(GROUP,%Closest%.Diff_phone_number_area_code);
    Count_Diff_phone_number := COUNT(GROUP,%Closest%.Diff_phone_number);
    Count_Diff_phone_number_extension := COUNT(GROUP,%Closest%.Diff_phone_number_extension);
    Count_Diff_fax_area_code := COUNT(GROUP,%Closest%.Diff_fax_area_code);
    Count_Diff_fax_number := COUNT(GROUP,%Closest%.Diff_fax_number);
    Count_Diff_fax_extension := COUNT(GROUP,%Closest%.Diff_fax_extension);
    Count_Diff_head_office_asset_size := COUNT(GROUP,%Closest%.Diff_head_office_asset_size);
    Count_Diff_federal_reserve_district_code := COUNT(GROUP,%Closest%.Diff_federal_reserve_district_code);
    Count_Diff_year_2000_date_last_updated := COUNT(GROUP,%Closest%.Diff_year_2000_date_last_updated);
    Count_Diff_head_office_file_key := COUNT(GROUP,%Closest%.Diff_head_office_file_key);
    Count_Diff_routing_number_type := COUNT(GROUP,%Closest%.Diff_routing_number_type);
    Count_Diff_routing_number_status := COUNT(GROUP,%Closest%.Diff_routing_number_status);
    Count_Diff_employer_tax_id := COUNT(GROUP,%Closest%.Diff_employer_tax_id);
    Count_Diff_institution_identifier := COUNT(GROUP,%Closest%.Diff_institution_identifier);
  END;
  out_counts := table(%Closest%,%AggRec%,true);
ENDMACRO;
END;
