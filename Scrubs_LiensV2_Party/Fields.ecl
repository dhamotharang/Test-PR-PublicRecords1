IMPORT ut,SALT30;
EXPORT Fields := MODULE
// Processing for each FieldType
EXPORT SALT30.StrType FieldTypeName(UNSIGNED2 i) := CHOOSE(i,'number','alpha','invalid_alpha','invalid_only_alpha','invalid_zip','invalid_date','invalid_phone','invalid_ssn','invalid_name_suffix','invalid_name');
EXPORT FieldTypeNum(SALT30.StrType fn) := CASE(fn,'number' => 1,'alpha' => 2,'invalid_alpha' => 3,'invalid_only_alpha' => 4,'invalid_zip' => 5,'invalid_date' => 6,'invalid_phone' => 7,'invalid_ssn' => 8,'invalid_name_suffix' => 9,'invalid_name' => 10,0);
EXPORT MakeFT_number(SALT30.StrType s0) := FUNCTION
  s1 := SALT30.stringfilter(s0,'0123456789'); // Only allow valid symbols
  s2 := if ( SALT30.StringFind('"\'',s1[1],1)>0 and SALT30.StringFind('"\'',s1[LENGTH(TRIM(s1))],1)>0,s1[2..LENGTH(TRIM(s1))-1],s1 );// Remove quotes if required
  RETURN  s2;
END;
EXPORT InValidFT_number(SALT30.StrType s) := WHICH(SALT30.StringFind('"\'',s[1],1)<>0 and SALT30.StringFind('"\'',s[LENGTH(TRIM(s))],1)<>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT30.StringFilter(s,'0123456789'))));
EXPORT InValidMessageFT_number(UNSIGNED1 wh) := CHOOSE(wh,SALT30.HygieneErrors.Inquotes('"\''),SALT30.HygieneErrors.NotInChars('0123456789'),SALT30.HygieneErrors.Good);
EXPORT MakeFT_alpha(SALT30.StrType s0) := FUNCTION
  s1 := SALT30.stringfilter(s0,'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefqhijklmnopqrstuvwxyz -,.'); // Only allow valid symbols
  s2 := SALT30.stringcleanspaces( SALT30.stringsubstituteout(s1,' -,.',' ') ); // Insert spaces but avoid doubles
  s3 := if ( SALT30.StringFind('"\'',s2[1],1)>0 and SALT30.StringFind('"\'',s2[LENGTH(TRIM(s2))],1)>0,s2[2..LENGTH(TRIM(s2))-1],s2 );// Remove quotes if required
  RETURN  s3;
END;
EXPORT InValidFT_alpha(SALT30.StrType s) := WHICH(SALT30.StringFind('"\'',s[1],1)<>0 and SALT30.StringFind('"\'',s[LENGTH(TRIM(s))],1)<>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT30.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefqhijklmnopqrstuvwxyz -,.'))));
EXPORT InValidMessageFT_alpha(UNSIGNED1 wh) := CHOOSE(wh,SALT30.HygieneErrors.Inquotes('"\''),SALT30.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefqhijklmnopqrstuvwxyz -,.'),SALT30.HygieneErrors.Good);
EXPORT MakeFT_invalid_alpha(SALT30.StrType s0) := FUNCTION
  s1 := SALT30.stringfilter(s0,'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789 <>{}[]-^=!+&,.;/#()_"\''); // Only allow valid symbols
  s2 := SALT30.stringcleanspaces( SALT30.stringsubstituteout(s1,' <>{}[]-^=!+&,.;/#()_"\'',' ') ); // Insert spaces but avoid doubles
  RETURN  s2;
END;
EXPORT InValidFT_invalid_alpha(SALT30.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT30.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789 <>{}[]-^=!+&,.;/#()_"\''))));
EXPORT InValidMessageFT_invalid_alpha(UNSIGNED1 wh) := CHOOSE(wh,SALT30.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789 <>{}[]-^=!+&,.;/#()_"\''),SALT30.HygieneErrors.Good);
EXPORT MakeFT_invalid_only_alpha(SALT30.StrType s0) := FUNCTION
  s1 := SALT30.stringfilter(s0,'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz -,.'); // Only allow valid symbols
  s2 := SALT30.stringcleanspaces( SALT30.stringsubstituteout(s1,' -,.',' ') ); // Insert spaces but avoid doubles
  RETURN  s2;
END;
EXPORT InValidFT_invalid_only_alpha(SALT30.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT30.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz -,.'))));
EXPORT InValidMessageFT_invalid_only_alpha(UNSIGNED1 wh) := CHOOSE(wh,SALT30.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz -,.'),SALT30.HygieneErrors.Good);
EXPORT MakeFT_invalid_zip(SALT30.StrType s0) := FUNCTION
  s1 := SALT30.stringfilter(s0,'0123456789-'); // Only allow valid symbols
  s2 := SALT30.stringcleanspaces( SALT30.stringsubstituteout(s1,'-',' ') ); // Insert spaces but avoid doubles
  s3 := if ( SALT30.StringFind('"\'',s2[1],1)>0 and SALT30.StringFind('"\'',s2[LENGTH(TRIM(s2))],1)>0,s2[2..LENGTH(TRIM(s2))-1],s2 );// Remove quotes if required
  RETURN  MakeFT_number(s3);
END;
EXPORT InValidFT_invalid_zip(SALT30.StrType s) := WHICH(SALT30.StringFind('"\'',s[1],1)<>0 and SALT30.StringFind('"\'',s[LENGTH(TRIM(s))],1)<>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT30.StringFilter(s,'0123456789-'))),~(LENGTH(TRIM(s)) = 0 OR LENGTH(TRIM(s)) = 5 OR LENGTH(TRIM(s)) = 9 OR LENGTH(TRIM(s)) = 10));
EXPORT InValidMessageFT_invalid_zip(UNSIGNED1 wh) := CHOOSE(wh,SALT30.HygieneErrors.Inquotes('"\''),SALT30.HygieneErrors.NotInChars('0123456789-'),SALT30.HygieneErrors.NotLength('0,5,9,10'),SALT30.HygieneErrors.Good);
EXPORT MakeFT_invalid_date(SALT30.StrType s0) := FUNCTION
  s1 := SALT30.stringfilter(s0,'0123456789'); // Only allow valid symbols
  s2 := if ( SALT30.StringFind('"\'',s1[1],1)>0 and SALT30.StringFind('"\'',s1[LENGTH(TRIM(s1))],1)>0,s1[2..LENGTH(TRIM(s1))-1],s1 );// Remove quotes if required
  RETURN  MakeFT_number(s2);
END;
EXPORT InValidFT_invalid_date(SALT30.StrType s) := WHICH(SALT30.StringFind('"\'',s[1],1)<>0 and SALT30.StringFind('"\'',s[LENGTH(TRIM(s))],1)<>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT30.StringFilter(s,'0123456789'))),~(LENGTH(TRIM(s)) = 0 OR LENGTH(TRIM(s)) = 4 OR LENGTH(TRIM(s)) = 6 OR LENGTH(TRIM(s)) = 8));
EXPORT InValidMessageFT_invalid_date(UNSIGNED1 wh) := CHOOSE(wh,SALT30.HygieneErrors.Inquotes('"\''),SALT30.HygieneErrors.NotInChars('0123456789'),SALT30.HygieneErrors.NotLength('0,4,6,8'),SALT30.HygieneErrors.Good);
EXPORT MakeFT_invalid_phone(SALT30.StrType s0) := FUNCTION
  s1 := SALT30.stringfilter(s0,'0123456789'); // Only allow valid symbols
  s2 := if ( SALT30.StringFind('"\'',s1[1],1)>0 and SALT30.StringFind('"\'',s1[LENGTH(TRIM(s1))],1)>0,s1[2..LENGTH(TRIM(s1))-1],s1 );// Remove quotes if required
  RETURN  MakeFT_number(s2);
END;
EXPORT InValidFT_invalid_phone(SALT30.StrType s) := WHICH(SALT30.StringFind('"\'',s[1],1)<>0 and SALT30.StringFind('"\'',s[LENGTH(TRIM(s))],1)<>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT30.StringFilter(s,'0123456789'))),~(LENGTH(TRIM(s)) = 0 OR LENGTH(TRIM(s)) = 7 OR LENGTH(TRIM(s)) = 10));
EXPORT InValidMessageFT_invalid_phone(UNSIGNED1 wh) := CHOOSE(wh,SALT30.HygieneErrors.Inquotes('"\''),SALT30.HygieneErrors.NotInChars('0123456789'),SALT30.HygieneErrors.NotLength('0,7,10'),SALT30.HygieneErrors.Good);
EXPORT MakeFT_invalid_ssn(SALT30.StrType s0) := FUNCTION
  s1 := SALT30.stringfilter(s0,'0123456789Xx*'); // Only allow valid symbols
  s2 := SALT30.stringcleanspaces( SALT30.stringsubstituteout(s1,'*',' ') ); // Insert spaces but avoid doubles
  RETURN  s2;
END;
EXPORT InValidFT_invalid_ssn(SALT30.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT30.StringFilter(s,'0123456789Xx*'))));
EXPORT InValidMessageFT_invalid_ssn(UNSIGNED1 wh) := CHOOSE(wh,SALT30.HygieneErrors.NotInChars('0123456789Xx*'),SALT30.HygieneErrors.Good);
EXPORT MakeFT_invalid_name_suffix(SALT30.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_name_suffix(SALT30.StrType s) := WHICH(((SALT30.StrType) s) NOT IN ['JR','SR','I','II','III','IV','V','VI','VII','VIII','IX','X','XI','XII','XIII','XVII',' ']);
EXPORT InValidMessageFT_invalid_name_suffix(UNSIGNED1 wh) := CHOOSE(wh,SALT30.HygieneErrors.NotInEnum('JR|SR|I|II|III|IV|V|VI|VII|VIII|IX|X|XI|XII|XIII|XVII| '),SALT30.HygieneErrors.Good);
EXPORT MakeFT_invalid_name(SALT30.StrType s0) := FUNCTION
  s1 := SALT30.stringfilter(s0,'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789\' -,.&()'); // Only allow valid symbols
  s2 := SALT30.stringcleanspaces( SALT30.stringsubstituteout(s1,' -,.&()',' ') ); // Insert spaces but avoid doubles
  RETURN  s2;
END;
EXPORT InValidFT_invalid_name(SALT30.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT30.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789\' -,.&()'))),~(LENGTH(TRIM(s)) = 0 OR LENGTH(TRIM(s)) >= 3));
EXPORT InValidMessageFT_invalid_name(UNSIGNED1 wh) := CHOOSE(wh,SALT30.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789\' -,.&()'),SALT30.HygieneErrors.NotLength('0,3..'),SALT30.HygieneErrors.Good);
EXPORT SALT30.StrType FieldName(UNSIGNED2 i) := CHOOSE(i,'tmsid','rmsid','orig_rmsid','orig_full_debtorname','orig_name','orig_lname','orig_fname','orig_mname','orig_suffix','tax_id','ssn','title','fname','mname','lname','name_suffix','name_score','cname','orig_address1','orig_address2','orig_city','orig_state','orig_zip5','orig_zip4','orig_county','orig_country','prim_range','predir','prim_name','addr_suffix','postdir','unit_desig','sec_range','p_city_name','v_city_name','st','zip','zip4','cart','cr_sort_sz','lot','lot_order','dbpc','chk_digit','rec_type','county','geo_lat','geo_long','msa','geo_blk','geo_match','err_stat','phone','name_type','did','bdid','date_first_seen','date_last_seen','date_vendor_first_reported','date_vendor_last_reported','persistent_record_id','source_file');
EXPORT FieldNum(SALT30.StrType fn) := CASE(fn,'tmsid' => 1,'rmsid' => 2,'orig_rmsid' => 3,'orig_full_debtorname' => 4,'orig_name' => 5,'orig_lname' => 6,'orig_fname' => 7,'orig_mname' => 8,'orig_suffix' => 9,'tax_id' => 10,'ssn' => 11,'title' => 12,'fname' => 13,'mname' => 14,'lname' => 15,'name_suffix' => 16,'name_score' => 17,'cname' => 18,'orig_address1' => 19,'orig_address2' => 20,'orig_city' => 21,'orig_state' => 22,'orig_zip5' => 23,'orig_zip4' => 24,'orig_county' => 25,'orig_country' => 26,'prim_range' => 27,'predir' => 28,'prim_name' => 29,'addr_suffix' => 30,'postdir' => 31,'unit_desig' => 32,'sec_range' => 33,'p_city_name' => 34,'v_city_name' => 35,'st' => 36,'zip' => 37,'zip4' => 38,'cart' => 39,'cr_sort_sz' => 40,'lot' => 41,'lot_order' => 42,'dbpc' => 43,'chk_digit' => 44,'rec_type' => 45,'county' => 46,'geo_lat' => 47,'geo_long' => 48,'msa' => 49,'geo_blk' => 50,'geo_match' => 51,'err_stat' => 52,'phone' => 53,'name_type' => 54,'did' => 55,'bdid' => 56,'date_first_seen' => 57,'date_last_seen' => 58,'date_vendor_first_reported' => 59,'date_vendor_last_reported' => 60,'persistent_record_id' => 61,'source_file' => 62,0);
//Individual field level validation
EXPORT Make_tmsid(SALT30.StrType s0) := s0;
EXPORT InValid_tmsid(SALT30.StrType s) := FALSE;
EXPORT InValidMessage_tmsid(UNSIGNED1 wh) := '';
EXPORT Make_rmsid(SALT30.StrType s0) := s0;
EXPORT InValid_rmsid(SALT30.StrType s) := FALSE;
EXPORT InValidMessage_rmsid(UNSIGNED1 wh) := '';
EXPORT Make_orig_rmsid(SALT30.StrType s0) := s0;
EXPORT InValid_orig_rmsid(SALT30.StrType s) := FALSE;
EXPORT InValidMessage_orig_rmsid(UNSIGNED1 wh) := '';
EXPORT Make_orig_full_debtorname(SALT30.StrType s0) := MakeFT_invalid_alpha(s0);
EXPORT InValid_orig_full_debtorname(SALT30.StrType s) := InValidFT_invalid_alpha(s);
EXPORT InValidMessage_orig_full_debtorname(UNSIGNED1 wh) := InValidMessageFT_invalid_alpha(wh);
EXPORT Make_orig_name(SALT30.StrType s0) := MakeFT_invalid_alpha(s0);
EXPORT InValid_orig_name(SALT30.StrType s) := InValidFT_invalid_alpha(s);
EXPORT InValidMessage_orig_name(UNSIGNED1 wh) := InValidMessageFT_invalid_alpha(wh);
EXPORT Make_orig_lname(SALT30.StrType s0) := MakeFT_invalid_name(s0);
EXPORT InValid_orig_lname(SALT30.StrType s) := InValidFT_invalid_name(s);
EXPORT InValidMessage_orig_lname(UNSIGNED1 wh) := InValidMessageFT_invalid_name(wh);
EXPORT Make_orig_fname(SALT30.StrType s0) := s0;
EXPORT InValid_orig_fname(SALT30.StrType s) := FALSE;
EXPORT InValidMessage_orig_fname(UNSIGNED1 wh) := '';
EXPORT Make_orig_mname(SALT30.StrType s0) := s0;
EXPORT InValid_orig_mname(SALT30.StrType s) := FALSE;
EXPORT InValidMessage_orig_mname(UNSIGNED1 wh) := '';
EXPORT Make_orig_suffix(SALT30.StrType s0) := MakeFT_invalid_name_suffix(s0);
EXPORT InValid_orig_suffix(SALT30.StrType s) := InValidFT_invalid_name_suffix(s);
EXPORT InValidMessage_orig_suffix(UNSIGNED1 wh) := InValidMessageFT_invalid_name_suffix(wh);
EXPORT Make_tax_id(SALT30.StrType s0) := MakeFT_invalid_ssn(s0);
EXPORT InValid_tax_id(SALT30.StrType s) := InValidFT_invalid_ssn(s);
EXPORT InValidMessage_tax_id(UNSIGNED1 wh) := InValidMessageFT_invalid_ssn(wh);
EXPORT Make_ssn(SALT30.StrType s0) := MakeFT_invalid_ssn(s0);
EXPORT InValid_ssn(SALT30.StrType s) := InValidFT_invalid_ssn(s);
EXPORT InValidMessage_ssn(UNSIGNED1 wh) := InValidMessageFT_invalid_ssn(wh);
EXPORT Make_title(SALT30.StrType s0) := s0;
EXPORT InValid_title(SALT30.StrType s) := FALSE;
EXPORT InValidMessage_title(UNSIGNED1 wh) := '';
EXPORT Make_fname(SALT30.StrType s0) := s0;
EXPORT InValid_fname(SALT30.StrType s) := FALSE;
EXPORT InValidMessage_fname(UNSIGNED1 wh) := '';
EXPORT Make_mname(SALT30.StrType s0) := s0;
EXPORT InValid_mname(SALT30.StrType s) := FALSE;
EXPORT InValidMessage_mname(UNSIGNED1 wh) := '';
EXPORT Make_lname(SALT30.StrType s0) := s0;
EXPORT InValid_lname(SALT30.StrType s) := FALSE;
EXPORT InValidMessage_lname(UNSIGNED1 wh) := '';
EXPORT Make_name_suffix(SALT30.StrType s0) := MakeFT_invalid_name_suffix(s0);
EXPORT InValid_name_suffix(SALT30.StrType s) := InValidFT_invalid_name_suffix(s);
EXPORT InValidMessage_name_suffix(UNSIGNED1 wh) := InValidMessageFT_invalid_name_suffix(wh);
EXPORT Make_name_score(SALT30.StrType s0) := s0;
EXPORT InValid_name_score(SALT30.StrType s) := FALSE;
EXPORT InValidMessage_name_score(UNSIGNED1 wh) := '';
EXPORT Make_cname(SALT30.StrType s0) := s0;
EXPORT InValid_cname(SALT30.StrType s) := FALSE;
EXPORT InValidMessage_cname(UNSIGNED1 wh) := '';
EXPORT Make_orig_address1(SALT30.StrType s0) := MakeFT_invalid_alpha(s0);
EXPORT InValid_orig_address1(SALT30.StrType s) := InValidFT_invalid_alpha(s);
EXPORT InValidMessage_orig_address1(UNSIGNED1 wh) := InValidMessageFT_invalid_alpha(wh);
EXPORT Make_orig_address2(SALT30.StrType s0) := MakeFT_invalid_alpha(s0);
EXPORT InValid_orig_address2(SALT30.StrType s) := InValidFT_invalid_alpha(s);
EXPORT InValidMessage_orig_address2(UNSIGNED1 wh) := InValidMessageFT_invalid_alpha(wh);
EXPORT Make_orig_city(SALT30.StrType s0) := MakeFT_invalid_only_alpha(s0);
EXPORT InValid_orig_city(SALT30.StrType s) := InValidFT_invalid_only_alpha(s);
EXPORT InValidMessage_orig_city(UNSIGNED1 wh) := InValidMessageFT_invalid_only_alpha(wh);
EXPORT Make_orig_state(SALT30.StrType s0) := MakeFT_invalid_only_alpha(s0);
EXPORT InValid_orig_state(SALT30.StrType s) := InValidFT_invalid_only_alpha(s);
EXPORT InValidMessage_orig_state(UNSIGNED1 wh) := InValidMessageFT_invalid_only_alpha(wh);
EXPORT Make_orig_zip5(SALT30.StrType s0) := MakeFT_invalid_zip(s0);
EXPORT InValid_orig_zip5(SALT30.StrType s) := InValidFT_invalid_zip(s);
EXPORT InValidMessage_orig_zip5(UNSIGNED1 wh) := InValidMessageFT_invalid_zip(wh);
EXPORT Make_orig_zip4(SALT30.StrType s0) := s0;
EXPORT InValid_orig_zip4(SALT30.StrType s) := FALSE;
EXPORT InValidMessage_orig_zip4(UNSIGNED1 wh) := '';
EXPORT Make_orig_county(SALT30.StrType s0) := MakeFT_invalid_only_alpha(s0);
EXPORT InValid_orig_county(SALT30.StrType s) := InValidFT_invalid_only_alpha(s);
EXPORT InValidMessage_orig_county(UNSIGNED1 wh) := InValidMessageFT_invalid_only_alpha(wh);
EXPORT Make_orig_country(SALT30.StrType s0) := MakeFT_invalid_only_alpha(s0);
EXPORT InValid_orig_country(SALT30.StrType s) := InValidFT_invalid_only_alpha(s);
EXPORT InValidMessage_orig_country(UNSIGNED1 wh) := InValidMessageFT_invalid_only_alpha(wh);
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
EXPORT Make_phone(SALT30.StrType s0) := s0;
EXPORT InValid_phone(SALT30.StrType s) := FALSE;
EXPORT InValidMessage_phone(UNSIGNED1 wh) := '';
EXPORT Make_name_type(SALT30.StrType s0) := s0;
EXPORT InValid_name_type(SALT30.StrType s) := FALSE;
EXPORT InValidMessage_name_type(UNSIGNED1 wh) := '';
EXPORT Make_did(SALT30.StrType s0) := s0;
EXPORT InValid_did(SALT30.StrType s) := FALSE;
EXPORT InValidMessage_did(UNSIGNED1 wh) := '';
EXPORT Make_bdid(SALT30.StrType s0) := s0;
EXPORT InValid_bdid(SALT30.StrType s) := FALSE;
EXPORT InValidMessage_bdid(UNSIGNED1 wh) := '';
EXPORT Make_date_first_seen(SALT30.StrType s0) := MakeFT_invalid_date(s0);
EXPORT InValid_date_first_seen(SALT30.StrType s) := InValidFT_invalid_date(s);
EXPORT InValidMessage_date_first_seen(UNSIGNED1 wh) := InValidMessageFT_invalid_date(wh);
EXPORT Make_date_last_seen(SALT30.StrType s0) := MakeFT_invalid_date(s0);
EXPORT InValid_date_last_seen(SALT30.StrType s) := InValidFT_invalid_date(s);
EXPORT InValidMessage_date_last_seen(UNSIGNED1 wh) := InValidMessageFT_invalid_date(wh);
EXPORT Make_date_vendor_first_reported(SALT30.StrType s0) := MakeFT_invalid_date(s0);
EXPORT InValid_date_vendor_first_reported(SALT30.StrType s) := InValidFT_invalid_date(s);
EXPORT InValidMessage_date_vendor_first_reported(UNSIGNED1 wh) := InValidMessageFT_invalid_date(wh);
EXPORT Make_date_vendor_last_reported(SALT30.StrType s0) := MakeFT_invalid_date(s0);
EXPORT InValid_date_vendor_last_reported(SALT30.StrType s) := InValidFT_invalid_date(s);
EXPORT InValidMessage_date_vendor_last_reported(UNSIGNED1 wh) := InValidMessageFT_invalid_date(wh);
EXPORT Make_persistent_record_id(SALT30.StrType s0) := s0;
EXPORT InValid_persistent_record_id(SALT30.StrType s) := FALSE;
EXPORT InValidMessage_persistent_record_id(UNSIGNED1 wh) := '';
EXPORT Make_source_file(SALT30.StrType s0) := s0;
EXPORT InValid_source_file(SALT30.StrType s) := FALSE;
EXPORT InValidMessage_source_file(UNSIGNED1 wh) := '';
// This macro will compute and count field level differences based upon a pivot expression
export MAC_CountDifferencesByPivot(in_left,in_right,pivot_exp,bad_pivots,out_counts) := MACRO
  IMPORT SALT30,Scrubs_LiensV2_party;
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
    BOOLEAN Diff_tmsid;
    BOOLEAN Diff_rmsid;
    BOOLEAN Diff_orig_rmsid;
    BOOLEAN Diff_orig_full_debtorname;
    BOOLEAN Diff_orig_name;
    BOOLEAN Diff_orig_lname;
    BOOLEAN Diff_orig_fname;
    BOOLEAN Diff_orig_mname;
    BOOLEAN Diff_orig_suffix;
    BOOLEAN Diff_tax_id;
    BOOLEAN Diff_ssn;
    BOOLEAN Diff_title;
    BOOLEAN Diff_fname;
    BOOLEAN Diff_mname;
    BOOLEAN Diff_lname;
    BOOLEAN Diff_name_suffix;
    BOOLEAN Diff_name_score;
    BOOLEAN Diff_cname;
    BOOLEAN Diff_orig_address1;
    BOOLEAN Diff_orig_address2;
    BOOLEAN Diff_orig_city;
    BOOLEAN Diff_orig_state;
    BOOLEAN Diff_orig_zip5;
    BOOLEAN Diff_orig_zip4;
    BOOLEAN Diff_orig_county;
    BOOLEAN Diff_orig_country;
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
    BOOLEAN Diff_phone;
    BOOLEAN Diff_name_type;
    BOOLEAN Diff_did;
    BOOLEAN Diff_bdid;
    BOOLEAN Diff_date_first_seen;
    BOOLEAN Diff_date_last_seen;
    BOOLEAN Diff_date_vendor_first_reported;
    BOOLEAN Diff_date_vendor_last_reported;
    BOOLEAN Diff_persistent_record_id;
    BOOLEAN Diff_source_file;
    SALT30.StrType SourceField {MAXLENGTH(30)};
    UNSIGNED Num_Diffs;
    SALT30.StrType Val {MAXLENGTH(1024)};
  END;
#uniquename(fd)
  %dl% %fd%(in_left le,in_right ri) := TRANSFORM
    SELF.Diff_tmsid := le.tmsid <> ri.tmsid;
    SELF.Diff_rmsid := le.rmsid <> ri.rmsid;
    SELF.Diff_orig_rmsid := le.orig_rmsid <> ri.orig_rmsid;
    SELF.Diff_orig_full_debtorname := le.orig_full_debtorname <> ri.orig_full_debtorname;
    SELF.Diff_orig_name := le.orig_name <> ri.orig_name;
    SELF.Diff_orig_lname := le.orig_lname <> ri.orig_lname;
    SELF.Diff_orig_fname := le.orig_fname <> ri.orig_fname;
    SELF.Diff_orig_mname := le.orig_mname <> ri.orig_mname;
    SELF.Diff_orig_suffix := le.orig_suffix <> ri.orig_suffix;
    SELF.Diff_tax_id := le.tax_id <> ri.tax_id;
    SELF.Diff_ssn := le.ssn <> ri.ssn;
    SELF.Diff_title := le.title <> ri.title;
    SELF.Diff_fname := le.fname <> ri.fname;
    SELF.Diff_mname := le.mname <> ri.mname;
    SELF.Diff_lname := le.lname <> ri.lname;
    SELF.Diff_name_suffix := le.name_suffix <> ri.name_suffix;
    SELF.Diff_name_score := le.name_score <> ri.name_score;
    SELF.Diff_cname := le.cname <> ri.cname;
    SELF.Diff_orig_address1 := le.orig_address1 <> ri.orig_address1;
    SELF.Diff_orig_address2 := le.orig_address2 <> ri.orig_address2;
    SELF.Diff_orig_city := le.orig_city <> ri.orig_city;
    SELF.Diff_orig_state := le.orig_state <> ri.orig_state;
    SELF.Diff_orig_zip5 := le.orig_zip5 <> ri.orig_zip5;
    SELF.Diff_orig_zip4 := le.orig_zip4 <> ri.orig_zip4;
    SELF.Diff_orig_county := le.orig_county <> ri.orig_county;
    SELF.Diff_orig_country := le.orig_country <> ri.orig_country;
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
    SELF.Diff_phone := le.phone <> ri.phone;
    SELF.Diff_name_type := le.name_type <> ri.name_type;
    SELF.Diff_did := le.did <> ri.did;
    SELF.Diff_bdid := le.bdid <> ri.bdid;
    SELF.Diff_date_first_seen := le.date_first_seen <> ri.date_first_seen;
    SELF.Diff_date_last_seen := le.date_last_seen <> ri.date_last_seen;
    SELF.Diff_date_vendor_first_reported := le.date_vendor_first_reported <> ri.date_vendor_first_reported;
    SELF.Diff_date_vendor_last_reported := le.date_vendor_last_reported <> ri.date_vendor_last_reported;
    SELF.Diff_persistent_record_id := le.persistent_record_id <> ri.persistent_record_id;
    SELF.Diff_source_file := le.source_file <> ri.source_file;
    SELF.Val := (SALT30.StrType)evaluate(le,pivot_exp);
    SELF.SourceField := le.source_file;
    SELF.Num_Diffs := 0+ IF( SELF.Diff_tmsid,1,0)+ IF( SELF.Diff_rmsid,1,0)+ IF( SELF.Diff_orig_rmsid,1,0)+ IF( SELF.Diff_orig_full_debtorname,1,0)+ IF( SELF.Diff_orig_name,1,0)+ IF( SELF.Diff_orig_lname,1,0)+ IF( SELF.Diff_orig_fname,1,0)+ IF( SELF.Diff_orig_mname,1,0)+ IF( SELF.Diff_orig_suffix,1,0)+ IF( SELF.Diff_tax_id,1,0)+ IF( SELF.Diff_ssn,1,0)+ IF( SELF.Diff_title,1,0)+ IF( SELF.Diff_fname,1,0)+ IF( SELF.Diff_mname,1,0)+ IF( SELF.Diff_lname,1,0)+ IF( SELF.Diff_name_suffix,1,0)+ IF( SELF.Diff_name_score,1,0)+ IF( SELF.Diff_cname,1,0)+ IF( SELF.Diff_orig_address1,1,0)+ IF( SELF.Diff_orig_address2,1,0)+ IF( SELF.Diff_orig_city,1,0)+ IF( SELF.Diff_orig_state,1,0)+ IF( SELF.Diff_orig_zip5,1,0)+ IF( SELF.Diff_orig_zip4,1,0)+ IF( SELF.Diff_orig_county,1,0)+ IF( SELF.Diff_orig_country,1,0)+ IF( SELF.Diff_prim_range,1,0)+ IF( SELF.Diff_predir,1,0)+ IF( SELF.Diff_prim_name,1,0)+ IF( SELF.Diff_addr_suffix,1,0)+ IF( SELF.Diff_postdir,1,0)+ IF( SELF.Diff_unit_desig,1,0)+ IF( SELF.Diff_sec_range,1,0)+ IF( SELF.Diff_p_city_name,1,0)+ IF( SELF.Diff_v_city_name,1,0)+ IF( SELF.Diff_st,1,0)+ IF( SELF.Diff_zip,1,0)+ IF( SELF.Diff_zip4,1,0)+ IF( SELF.Diff_cart,1,0)+ IF( SELF.Diff_cr_sort_sz,1,0)+ IF( SELF.Diff_lot,1,0)+ IF( SELF.Diff_lot_order,1,0)+ IF( SELF.Diff_dbpc,1,0)+ IF( SELF.Diff_chk_digit,1,0)+ IF( SELF.Diff_rec_type,1,0)+ IF( SELF.Diff_county,1,0)+ IF( SELF.Diff_geo_lat,1,0)+ IF( SELF.Diff_geo_long,1,0)+ IF( SELF.Diff_msa,1,0)+ IF( SELF.Diff_geo_blk,1,0)+ IF( SELF.Diff_geo_match,1,0)+ IF( SELF.Diff_err_stat,1,0)+ IF( SELF.Diff_phone,1,0)+ IF( SELF.Diff_name_type,1,0)+ IF( SELF.Diff_did,1,0)+ IF( SELF.Diff_bdid,1,0)+ IF( SELF.Diff_date_first_seen,1,0)+ IF( SELF.Diff_date_last_seen,1,0)+ IF( SELF.Diff_date_vendor_first_reported,1,0)+ IF( SELF.Diff_date_vendor_last_reported,1,0)+ IF( SELF.Diff_persistent_record_id,1,0)+ IF( SELF.Diff_source_file,1,0);
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
    Count_Diff_tmsid := COUNT(GROUP,%Closest%.Diff_tmsid);
    Count_Diff_rmsid := COUNT(GROUP,%Closest%.Diff_rmsid);
    Count_Diff_orig_rmsid := COUNT(GROUP,%Closest%.Diff_orig_rmsid);
    Count_Diff_orig_full_debtorname := COUNT(GROUP,%Closest%.Diff_orig_full_debtorname);
    Count_Diff_orig_name := COUNT(GROUP,%Closest%.Diff_orig_name);
    Count_Diff_orig_lname := COUNT(GROUP,%Closest%.Diff_orig_lname);
    Count_Diff_orig_fname := COUNT(GROUP,%Closest%.Diff_orig_fname);
    Count_Diff_orig_mname := COUNT(GROUP,%Closest%.Diff_orig_mname);
    Count_Diff_orig_suffix := COUNT(GROUP,%Closest%.Diff_orig_suffix);
    Count_Diff_tax_id := COUNT(GROUP,%Closest%.Diff_tax_id);
    Count_Diff_ssn := COUNT(GROUP,%Closest%.Diff_ssn);
    Count_Diff_title := COUNT(GROUP,%Closest%.Diff_title);
    Count_Diff_fname := COUNT(GROUP,%Closest%.Diff_fname);
    Count_Diff_mname := COUNT(GROUP,%Closest%.Diff_mname);
    Count_Diff_lname := COUNT(GROUP,%Closest%.Diff_lname);
    Count_Diff_name_suffix := COUNT(GROUP,%Closest%.Diff_name_suffix);
    Count_Diff_name_score := COUNT(GROUP,%Closest%.Diff_name_score);
    Count_Diff_cname := COUNT(GROUP,%Closest%.Diff_cname);
    Count_Diff_orig_address1 := COUNT(GROUP,%Closest%.Diff_orig_address1);
    Count_Diff_orig_address2 := COUNT(GROUP,%Closest%.Diff_orig_address2);
    Count_Diff_orig_city := COUNT(GROUP,%Closest%.Diff_orig_city);
    Count_Diff_orig_state := COUNT(GROUP,%Closest%.Diff_orig_state);
    Count_Diff_orig_zip5 := COUNT(GROUP,%Closest%.Diff_orig_zip5);
    Count_Diff_orig_zip4 := COUNT(GROUP,%Closest%.Diff_orig_zip4);
    Count_Diff_orig_county := COUNT(GROUP,%Closest%.Diff_orig_county);
    Count_Diff_orig_country := COUNT(GROUP,%Closest%.Diff_orig_country);
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
    Count_Diff_phone := COUNT(GROUP,%Closest%.Diff_phone);
    Count_Diff_name_type := COUNT(GROUP,%Closest%.Diff_name_type);
    Count_Diff_did := COUNT(GROUP,%Closest%.Diff_did);
    Count_Diff_bdid := COUNT(GROUP,%Closest%.Diff_bdid);
    Count_Diff_date_first_seen := COUNT(GROUP,%Closest%.Diff_date_first_seen);
    Count_Diff_date_last_seen := COUNT(GROUP,%Closest%.Diff_date_last_seen);
    Count_Diff_date_vendor_first_reported := COUNT(GROUP,%Closest%.Diff_date_vendor_first_reported);
    Count_Diff_date_vendor_last_reported := COUNT(GROUP,%Closest%.Diff_date_vendor_last_reported);
    Count_Diff_persistent_record_id := COUNT(GROUP,%Closest%.Diff_persistent_record_id);
    Count_Diff_source_file := COUNT(GROUP,%Closest%.Diff_source_file);
    %Closest%.SourceField;
  END;
  out_counts := table(%Closest%,%AggRec%,SourceField,few);
ENDMACRO;
END;
