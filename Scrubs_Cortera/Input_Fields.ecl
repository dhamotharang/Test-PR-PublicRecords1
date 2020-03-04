IMPORT SALT311;
IMPORT Scrubs; // Import modules for FieldTypes attribute definitions
EXPORT Input_Fields := MODULE
 
EXPORT NumFields := 54;
 
// Processing for each FieldType
EXPORT SALT311.StrType FieldTypeName(UNSIGNED2 i) := CHOOSE(i,'alpha','feintype','Invalid_Date','OwnershipTypes','StatusTypes','YesNo','CorpHierarchy','StateAbrv','Numeric','Invalid_LatLong','invalid_sic','invalid_naics');
EXPORT FieldTypeNum(SALT311.StrType fn) := CASE(fn,'alpha' => 1,'feintype' => 2,'Invalid_Date' => 3,'OwnershipTypes' => 4,'StatusTypes' => 5,'YesNo' => 6,'CorpHierarchy' => 7,'StateAbrv' => 8,'Numeric' => 9,'Invalid_LatLong' => 10,'invalid_sic' => 11,'invalid_naics' => 12,0);
 
EXPORT MakeFT_alpha(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_alpha(SALT311.StrType s) := WHICH(~Scrubs.functions.fn_ASCII_printable(s)>0);
EXPORT InValidMessageFT_alpha(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('Scrubs.functions.fn_ASCII_printable'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_feintype(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringfilter(s0,'0123456789'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_feintype(SALT311.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT311.StringFilter(s,'0123456789'))),~(LENGTH(TRIM(s)) = 0 OR LENGTH(TRIM(s)) = 9));
EXPORT InValidMessageFT_feintype(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInChars('0123456789'),SALT311.HygieneErrors.NotLength('0,9'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_Invalid_Date(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_Invalid_Date(SALT311.StrType s) := WHICH(~Scrubs.functions.fn_valid_date(s,'future')>0);
EXPORT InValidMessageFT_Invalid_Date(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('Scrubs.functions.fn_valid_date'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_OwnershipTypes(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_OwnershipTypes(SALT311.StrType s) := WHICH(((SALT311.StrType) s) NOT IN ['P','V',' ']);
EXPORT InValidMessageFT_OwnershipTypes(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInEnum('P|V| '),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_StatusTypes(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_StatusTypes(SALT311.StrType s) := WHICH(((SALT311.StrType) s) NOT IN ['A','D',' ']);
EXPORT InValidMessageFT_StatusTypes(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInEnum('A|D| '),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_YesNo(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_YesNo(SALT311.StrType s) := WHICH(((SALT311.StrType) s) NOT IN ['Y','N',' ']);
EXPORT InValidMessageFT_YesNo(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInEnum('Y|N| '),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_CorpHierarchy(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_CorpHierarchy(SALT311.StrType s) := WHICH(((SALT311.StrType) s) NOT IN ['S','B','H',' ']);
EXPORT InValidMessageFT_CorpHierarchy(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInEnum('S|B|H| '),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_StateAbrv(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_StateAbrv(SALT311.StrType s) := WHICH(~Scrubs.functions.fn_alpha_optional(s,2)>0);
EXPORT InValidMessageFT_StateAbrv(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('Scrubs.functions.fn_alpha_optional'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_Numeric(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_Numeric(SALT311.StrType s) := WHICH(~Scrubs.functions.fn_numeric(s)>0);
EXPORT InValidMessageFT_Numeric(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('Scrubs.functions.fn_numeric'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_Invalid_LatLong(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_Invalid_LatLong(SALT311.StrType s) := WHICH(~Scrubs.functions.fn_geo_coord(s)>0);
EXPORT InValidMessageFT_Invalid_LatLong(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('Scrubs.functions.fn_geo_coord'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_sic(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_sic(SALT311.StrType s) := WHICH(~Scrubs.fn_valid_SicCode(s)>0);
EXPORT InValidMessageFT_invalid_sic(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('Scrubs.fn_valid_SicCode'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_naics(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_naics(SALT311.StrType s) := WHICH(~Scrubs.fn_valid_NAICSCode(s)>0);
EXPORT InValidMessageFT_invalid_naics(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('Scrubs.fn_valid_NAICSCode'),SALT311.HygieneErrors.Good);
 
EXPORT SALT311.StrType FieldName(UNSIGNED2 i) := CHOOSE(i,'link_id','name','alternate_business_name','address','address2','city','state','country','postalcode','phone','fax','latitude','longitude','url','fein','position_type','ultimate_linkid','ultimate_name','loc_date_last_seen','primary_sic','sic_desc','primary_naics','naics_desc','segment_id','segment_desc','year_start','ownership','total_employees','employee_range','total_sales','sales_range','executive_name1','title1','executive_name2','title2','executive_name3','title3','executive_name4','title4','executive_name5','title5','executive_name6','title6','executive_name7','title7','executive_name8','title8','executive_name9','title9','executive_name10','title10','status','is_closed','closed_date');
EXPORT SALT311.StrType FlatName(UNSIGNED2 i) := CHOOSE(i,'link_id','name','alternate_business_name','address','address2','city','state','country','postalcode','phone','fax','latitude','longitude','url','fein','position_type','ultimate_linkid','ultimate_name','loc_date_last_seen','primary_sic','sic_desc','primary_naics','naics_desc','segment_id','segment_desc','year_start','ownership','total_employees','employee_range','total_sales','sales_range','executive_name1','title1','executive_name2','title2','executive_name3','title3','executive_name4','title4','executive_name5','title5','executive_name6','title6','executive_name7','title7','executive_name8','title8','executive_name9','title9','executive_name10','title10','status','is_closed','closed_date');
EXPORT FieldNum(SALT311.StrType fn) := CASE(fn,'link_id' => 0,'name' => 1,'alternate_business_name' => 2,'address' => 3,'address2' => 4,'city' => 5,'state' => 6,'country' => 7,'postalcode' => 8,'phone' => 9,'fax' => 10,'latitude' => 11,'longitude' => 12,'url' => 13,'fein' => 14,'position_type' => 15,'ultimate_linkid' => 16,'ultimate_name' => 17,'loc_date_last_seen' => 18,'primary_sic' => 19,'sic_desc' => 20,'primary_naics' => 21,'naics_desc' => 22,'segment_id' => 23,'segment_desc' => 24,'year_start' => 25,'ownership' => 26,'total_employees' => 27,'employee_range' => 28,'total_sales' => 29,'sales_range' => 30,'executive_name1' => 31,'title1' => 32,'executive_name2' => 33,'title2' => 34,'executive_name3' => 35,'title3' => 36,'executive_name4' => 37,'title4' => 38,'executive_name5' => 39,'title5' => 40,'executive_name6' => 41,'title6' => 42,'executive_name7' => 43,'title7' => 44,'executive_name8' => 45,'title8' => 46,'executive_name9' => 47,'title9' => 48,'executive_name10' => 49,'title10' => 50,'status' => 51,'is_closed' => 52,'closed_date' => 53,0);
EXPORT SET OF SALT311.StrType FieldRules(UNSIGNED2 i) := CHOOSE(i,['CUSTOM'],[],[],[],[],[],[],['CUSTOM'],[],[],[],['CUSTOM'],['CUSTOM'],[],['ALLOW','LENGTHS'],['ENUM'],['CUSTOM'],[],['CUSTOM'],['CUSTOM'],[],['CUSTOM'],[],[],[],[],['ENUM'],[],[],[],[],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['ENUM'],['ENUM'],[],[]);
EXPORT BOOLEAN InBaseLayout(UNSIGNED2 i) := CHOOSE(i,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,FALSE);
 
//Individual field level validation
 
EXPORT Make_link_id(SALT311.StrType s0) := MakeFT_Numeric(s0);
EXPORT InValid_link_id(SALT311.StrType s) := InValidFT_Numeric(s);
EXPORT InValidMessage_link_id(UNSIGNED1 wh) := InValidMessageFT_Numeric(wh);
 
EXPORT Make_name(SALT311.StrType s0) := s0;
EXPORT InValid_name(SALT311.StrType s) := 0;
EXPORT InValidMessage_name(UNSIGNED1 wh) := '';
 
EXPORT Make_alternate_business_name(SALT311.StrType s0) := s0;
EXPORT InValid_alternate_business_name(SALT311.StrType s) := 0;
EXPORT InValidMessage_alternate_business_name(UNSIGNED1 wh) := '';
 
EXPORT Make_address(SALT311.StrType s0) := s0;
EXPORT InValid_address(SALT311.StrType s) := 0;
EXPORT InValidMessage_address(UNSIGNED1 wh) := '';
 
EXPORT Make_address2(SALT311.StrType s0) := s0;
EXPORT InValid_address2(SALT311.StrType s) := 0;
EXPORT InValidMessage_address2(UNSIGNED1 wh) := '';
 
EXPORT Make_city(SALT311.StrType s0) := s0;
EXPORT InValid_city(SALT311.StrType s) := 0;
EXPORT InValidMessage_city(UNSIGNED1 wh) := '';
 
EXPORT Make_state(SALT311.StrType s0) := s0;
EXPORT InValid_state(SALT311.StrType s) := 0;
EXPORT InValidMessage_state(UNSIGNED1 wh) := '';
 
EXPORT Make_country(SALT311.StrType s0) := MakeFT_StateAbrv(s0);
EXPORT InValid_country(SALT311.StrType s) := InValidFT_StateAbrv(s);
EXPORT InValidMessage_country(UNSIGNED1 wh) := InValidMessageFT_StateAbrv(wh);
 
EXPORT Make_postalcode(SALT311.StrType s0) := s0;
EXPORT InValid_postalcode(SALT311.StrType s) := 0;
EXPORT InValidMessage_postalcode(UNSIGNED1 wh) := '';
 
EXPORT Make_phone(SALT311.StrType s0) := s0;
EXPORT InValid_phone(SALT311.StrType s) := 0;
EXPORT InValidMessage_phone(UNSIGNED1 wh) := '';
 
EXPORT Make_fax(SALT311.StrType s0) := s0;
EXPORT InValid_fax(SALT311.StrType s) := 0;
EXPORT InValidMessage_fax(UNSIGNED1 wh) := '';
 
EXPORT Make_latitude(SALT311.StrType s0) := MakeFT_Invalid_LatLong(s0);
EXPORT InValid_latitude(SALT311.StrType s) := InValidFT_Invalid_LatLong(s);
EXPORT InValidMessage_latitude(UNSIGNED1 wh) := InValidMessageFT_Invalid_LatLong(wh);
 
EXPORT Make_longitude(SALT311.StrType s0) := MakeFT_Invalid_LatLong(s0);
EXPORT InValid_longitude(SALT311.StrType s) := InValidFT_Invalid_LatLong(s);
EXPORT InValidMessage_longitude(UNSIGNED1 wh) := InValidMessageFT_Invalid_LatLong(wh);
 
EXPORT Make_url(SALT311.StrType s0) := s0;
EXPORT InValid_url(SALT311.StrType s) := 0;
EXPORT InValidMessage_url(UNSIGNED1 wh) := '';
 
EXPORT Make_fein(SALT311.StrType s0) := MakeFT_feintype(s0);
EXPORT InValid_fein(SALT311.StrType s) := InValidFT_feintype(s);
EXPORT InValidMessage_fein(UNSIGNED1 wh) := InValidMessageFT_feintype(wh);
 
EXPORT Make_position_type(SALT311.StrType s0) := MakeFT_CorpHierarchy(s0);
EXPORT InValid_position_type(SALT311.StrType s) := InValidFT_CorpHierarchy(s);
EXPORT InValidMessage_position_type(UNSIGNED1 wh) := InValidMessageFT_CorpHierarchy(wh);
 
EXPORT Make_ultimate_linkid(SALT311.StrType s0) := MakeFT_Numeric(s0);
EXPORT InValid_ultimate_linkid(SALT311.StrType s) := InValidFT_Numeric(s);
EXPORT InValidMessage_ultimate_linkid(UNSIGNED1 wh) := InValidMessageFT_Numeric(wh);
 
EXPORT Make_ultimate_name(SALT311.StrType s0) := s0;
EXPORT InValid_ultimate_name(SALT311.StrType s) := 0;
EXPORT InValidMessage_ultimate_name(UNSIGNED1 wh) := '';
 
EXPORT Make_loc_date_last_seen(SALT311.StrType s0) := MakeFT_Invalid_Date(s0);
EXPORT InValid_loc_date_last_seen(SALT311.StrType s) := InValidFT_Invalid_Date(s);
EXPORT InValidMessage_loc_date_last_seen(UNSIGNED1 wh) := InValidMessageFT_Invalid_Date(wh);
 
EXPORT Make_primary_sic(SALT311.StrType s0) := MakeFT_invalid_sic(s0);
EXPORT InValid_primary_sic(SALT311.StrType s) := InValidFT_invalid_sic(s);
EXPORT InValidMessage_primary_sic(UNSIGNED1 wh) := InValidMessageFT_invalid_sic(wh);
 
EXPORT Make_sic_desc(SALT311.StrType s0) := s0;
EXPORT InValid_sic_desc(SALT311.StrType s) := 0;
EXPORT InValidMessage_sic_desc(UNSIGNED1 wh) := '';
 
EXPORT Make_primary_naics(SALT311.StrType s0) := MakeFT_invalid_naics(s0);
EXPORT InValid_primary_naics(SALT311.StrType s) := InValidFT_invalid_naics(s);
EXPORT InValidMessage_primary_naics(UNSIGNED1 wh) := InValidMessageFT_invalid_naics(wh);
 
EXPORT Make_naics_desc(SALT311.StrType s0) := s0;
EXPORT InValid_naics_desc(SALT311.StrType s) := 0;
EXPORT InValidMessage_naics_desc(UNSIGNED1 wh) := '';
 
EXPORT Make_segment_id(SALT311.StrType s0) := s0;
EXPORT InValid_segment_id(SALT311.StrType s) := 0;
EXPORT InValidMessage_segment_id(UNSIGNED1 wh) := '';
 
EXPORT Make_segment_desc(SALT311.StrType s0) := s0;
EXPORT InValid_segment_desc(SALT311.StrType s) := 0;
EXPORT InValidMessage_segment_desc(UNSIGNED1 wh) := '';
 
EXPORT Make_year_start(SALT311.StrType s0) := s0;
EXPORT InValid_year_start(SALT311.StrType s) := 0;
EXPORT InValidMessage_year_start(UNSIGNED1 wh) := '';
 
EXPORT Make_ownership(SALT311.StrType s0) := MakeFT_OwnershipTypes(s0);
EXPORT InValid_ownership(SALT311.StrType s) := InValidFT_OwnershipTypes(s);
EXPORT InValidMessage_ownership(UNSIGNED1 wh) := InValidMessageFT_OwnershipTypes(wh);
 
EXPORT Make_total_employees(SALT311.StrType s0) := s0;
EXPORT InValid_total_employees(SALT311.StrType s) := 0;
EXPORT InValidMessage_total_employees(UNSIGNED1 wh) := '';
 
EXPORT Make_employee_range(SALT311.StrType s0) := s0;
EXPORT InValid_employee_range(SALT311.StrType s) := 0;
EXPORT InValidMessage_employee_range(UNSIGNED1 wh) := '';
 
EXPORT Make_total_sales(SALT311.StrType s0) := s0;
EXPORT InValid_total_sales(SALT311.StrType s) := 0;
EXPORT InValidMessage_total_sales(UNSIGNED1 wh) := '';
 
EXPORT Make_sales_range(SALT311.StrType s0) := s0;
EXPORT InValid_sales_range(SALT311.StrType s) := 0;
EXPORT InValidMessage_sales_range(UNSIGNED1 wh) := '';
 
EXPORT Make_executive_name1(SALT311.StrType s0) := MakeFT_alpha(s0);
EXPORT InValid_executive_name1(SALT311.StrType s) := InValidFT_alpha(s);
EXPORT InValidMessage_executive_name1(UNSIGNED1 wh) := InValidMessageFT_alpha(wh);
 
EXPORT Make_title1(SALT311.StrType s0) := MakeFT_alpha(s0);
EXPORT InValid_title1(SALT311.StrType s) := InValidFT_alpha(s);
EXPORT InValidMessage_title1(UNSIGNED1 wh) := InValidMessageFT_alpha(wh);
 
EXPORT Make_executive_name2(SALT311.StrType s0) := MakeFT_alpha(s0);
EXPORT InValid_executive_name2(SALT311.StrType s) := InValidFT_alpha(s);
EXPORT InValidMessage_executive_name2(UNSIGNED1 wh) := InValidMessageFT_alpha(wh);
 
EXPORT Make_title2(SALT311.StrType s0) := MakeFT_alpha(s0);
EXPORT InValid_title2(SALT311.StrType s) := InValidFT_alpha(s);
EXPORT InValidMessage_title2(UNSIGNED1 wh) := InValidMessageFT_alpha(wh);
 
EXPORT Make_executive_name3(SALT311.StrType s0) := MakeFT_alpha(s0);
EXPORT InValid_executive_name3(SALT311.StrType s) := InValidFT_alpha(s);
EXPORT InValidMessage_executive_name3(UNSIGNED1 wh) := InValidMessageFT_alpha(wh);
 
EXPORT Make_title3(SALT311.StrType s0) := MakeFT_alpha(s0);
EXPORT InValid_title3(SALT311.StrType s) := InValidFT_alpha(s);
EXPORT InValidMessage_title3(UNSIGNED1 wh) := InValidMessageFT_alpha(wh);
 
EXPORT Make_executive_name4(SALT311.StrType s0) := MakeFT_alpha(s0);
EXPORT InValid_executive_name4(SALT311.StrType s) := InValidFT_alpha(s);
EXPORT InValidMessage_executive_name4(UNSIGNED1 wh) := InValidMessageFT_alpha(wh);
 
EXPORT Make_title4(SALT311.StrType s0) := MakeFT_alpha(s0);
EXPORT InValid_title4(SALT311.StrType s) := InValidFT_alpha(s);
EXPORT InValidMessage_title4(UNSIGNED1 wh) := InValidMessageFT_alpha(wh);
 
EXPORT Make_executive_name5(SALT311.StrType s0) := MakeFT_alpha(s0);
EXPORT InValid_executive_name5(SALT311.StrType s) := InValidFT_alpha(s);
EXPORT InValidMessage_executive_name5(UNSIGNED1 wh) := InValidMessageFT_alpha(wh);
 
EXPORT Make_title5(SALT311.StrType s0) := MakeFT_alpha(s0);
EXPORT InValid_title5(SALT311.StrType s) := InValidFT_alpha(s);
EXPORT InValidMessage_title5(UNSIGNED1 wh) := InValidMessageFT_alpha(wh);
 
EXPORT Make_executive_name6(SALT311.StrType s0) := MakeFT_alpha(s0);
EXPORT InValid_executive_name6(SALT311.StrType s) := InValidFT_alpha(s);
EXPORT InValidMessage_executive_name6(UNSIGNED1 wh) := InValidMessageFT_alpha(wh);
 
EXPORT Make_title6(SALT311.StrType s0) := MakeFT_alpha(s0);
EXPORT InValid_title6(SALT311.StrType s) := InValidFT_alpha(s);
EXPORT InValidMessage_title6(UNSIGNED1 wh) := InValidMessageFT_alpha(wh);
 
EXPORT Make_executive_name7(SALT311.StrType s0) := MakeFT_alpha(s0);
EXPORT InValid_executive_name7(SALT311.StrType s) := InValidFT_alpha(s);
EXPORT InValidMessage_executive_name7(UNSIGNED1 wh) := InValidMessageFT_alpha(wh);
 
EXPORT Make_title7(SALT311.StrType s0) := MakeFT_alpha(s0);
EXPORT InValid_title7(SALT311.StrType s) := InValidFT_alpha(s);
EXPORT InValidMessage_title7(UNSIGNED1 wh) := InValidMessageFT_alpha(wh);
 
EXPORT Make_executive_name8(SALT311.StrType s0) := MakeFT_alpha(s0);
EXPORT InValid_executive_name8(SALT311.StrType s) := InValidFT_alpha(s);
EXPORT InValidMessage_executive_name8(UNSIGNED1 wh) := InValidMessageFT_alpha(wh);
 
EXPORT Make_title8(SALT311.StrType s0) := MakeFT_alpha(s0);
EXPORT InValid_title8(SALT311.StrType s) := InValidFT_alpha(s);
EXPORT InValidMessage_title8(UNSIGNED1 wh) := InValidMessageFT_alpha(wh);
 
EXPORT Make_executive_name9(SALT311.StrType s0) := MakeFT_alpha(s0);
EXPORT InValid_executive_name9(SALT311.StrType s) := InValidFT_alpha(s);
EXPORT InValidMessage_executive_name9(UNSIGNED1 wh) := InValidMessageFT_alpha(wh);
 
EXPORT Make_title9(SALT311.StrType s0) := MakeFT_alpha(s0);
EXPORT InValid_title9(SALT311.StrType s) := InValidFT_alpha(s);
EXPORT InValidMessage_title9(UNSIGNED1 wh) := InValidMessageFT_alpha(wh);
 
EXPORT Make_executive_name10(SALT311.StrType s0) := MakeFT_alpha(s0);
EXPORT InValid_executive_name10(SALT311.StrType s) := InValidFT_alpha(s);
EXPORT InValidMessage_executive_name10(UNSIGNED1 wh) := InValidMessageFT_alpha(wh);
 
EXPORT Make_title10(SALT311.StrType s0) := MakeFT_alpha(s0);
EXPORT InValid_title10(SALT311.StrType s) := InValidFT_alpha(s);
EXPORT InValidMessage_title10(UNSIGNED1 wh) := InValidMessageFT_alpha(wh);
 
EXPORT Make_status(SALT311.StrType s0) := MakeFT_StatusTypes(s0);
EXPORT InValid_status(SALT311.StrType s) := InValidFT_StatusTypes(s);
EXPORT InValidMessage_status(UNSIGNED1 wh) := InValidMessageFT_StatusTypes(wh);
 
EXPORT Make_is_closed(SALT311.StrType s0) := MakeFT_YesNo(s0);
EXPORT InValid_is_closed(SALT311.StrType s) := InValidFT_YesNo(s);
EXPORT InValidMessage_is_closed(UNSIGNED1 wh) := InValidMessageFT_YesNo(wh);
 
EXPORT Make_closed_date(SALT311.StrType s0) := s0;
EXPORT InValid_closed_date(SALT311.StrType s) := 0;
EXPORT InValidMessage_closed_date(UNSIGNED1 wh) := '';
 
// This macro will compute and count field level differences based upon a pivot expression
export MAC_CountDifferencesByPivot(in_left,in_right,pivot_exp,bad_pivots,out_counts) := MACRO
  IMPORT SALT311,Scrubs_Cortera;
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
    BOOLEAN Diff_link_id;
    BOOLEAN Diff_name;
    BOOLEAN Diff_alternate_business_name;
    BOOLEAN Diff_address;
    BOOLEAN Diff_address2;
    BOOLEAN Diff_city;
    BOOLEAN Diff_state;
    BOOLEAN Diff_country;
    BOOLEAN Diff_postalcode;
    BOOLEAN Diff_phone;
    BOOLEAN Diff_fax;
    BOOLEAN Diff_latitude;
    BOOLEAN Diff_longitude;
    BOOLEAN Diff_url;
    BOOLEAN Diff_fein;
    BOOLEAN Diff_position_type;
    BOOLEAN Diff_ultimate_linkid;
    BOOLEAN Diff_ultimate_name;
    BOOLEAN Diff_loc_date_last_seen;
    BOOLEAN Diff_primary_sic;
    BOOLEAN Diff_sic_desc;
    BOOLEAN Diff_primary_naics;
    BOOLEAN Diff_naics_desc;
    BOOLEAN Diff_segment_id;
    BOOLEAN Diff_segment_desc;
    BOOLEAN Diff_year_start;
    BOOLEAN Diff_ownership;
    BOOLEAN Diff_total_employees;
    BOOLEAN Diff_employee_range;
    BOOLEAN Diff_total_sales;
    BOOLEAN Diff_sales_range;
    BOOLEAN Diff_executive_name1;
    BOOLEAN Diff_title1;
    BOOLEAN Diff_executive_name2;
    BOOLEAN Diff_title2;
    BOOLEAN Diff_executive_name3;
    BOOLEAN Diff_title3;
    BOOLEAN Diff_executive_name4;
    BOOLEAN Diff_title4;
    BOOLEAN Diff_executive_name5;
    BOOLEAN Diff_title5;
    BOOLEAN Diff_executive_name6;
    BOOLEAN Diff_title6;
    BOOLEAN Diff_executive_name7;
    BOOLEAN Diff_title7;
    BOOLEAN Diff_executive_name8;
    BOOLEAN Diff_title8;
    BOOLEAN Diff_executive_name9;
    BOOLEAN Diff_title9;
    BOOLEAN Diff_executive_name10;
    BOOLEAN Diff_title10;
    BOOLEAN Diff_status;
    BOOLEAN Diff_is_closed;
    BOOLEAN Diff_closed_date;
    UNSIGNED Num_Diffs;
    SALT311.StrType Val {MAXLENGTH(1024)};
  END;
#uniquename(fd)
  %dl% %fd%(in_left le,in_right ri) := TRANSFORM
    SELF.Diff_link_id := le.link_id <> ri.link_id;
    SELF.Diff_name := le.name <> ri.name;
    SELF.Diff_alternate_business_name := le.alternate_business_name <> ri.alternate_business_name;
    SELF.Diff_address := le.address <> ri.address;
    SELF.Diff_address2 := le.address2 <> ri.address2;
    SELF.Diff_city := le.city <> ri.city;
    SELF.Diff_state := le.state <> ri.state;
    SELF.Diff_country := le.country <> ri.country;
    SELF.Diff_postalcode := le.postalcode <> ri.postalcode;
    SELF.Diff_phone := le.phone <> ri.phone;
    SELF.Diff_fax := le.fax <> ri.fax;
    SELF.Diff_latitude := le.latitude <> ri.latitude;
    SELF.Diff_longitude := le.longitude <> ri.longitude;
    SELF.Diff_url := le.url <> ri.url;
    SELF.Diff_fein := le.fein <> ri.fein;
    SELF.Diff_position_type := le.position_type <> ri.position_type;
    SELF.Diff_ultimate_linkid := le.ultimate_linkid <> ri.ultimate_linkid;
    SELF.Diff_ultimate_name := le.ultimate_name <> ri.ultimate_name;
    SELF.Diff_loc_date_last_seen := le.loc_date_last_seen <> ri.loc_date_last_seen;
    SELF.Diff_primary_sic := le.primary_sic <> ri.primary_sic;
    SELF.Diff_sic_desc := le.sic_desc <> ri.sic_desc;
    SELF.Diff_primary_naics := le.primary_naics <> ri.primary_naics;
    SELF.Diff_naics_desc := le.naics_desc <> ri.naics_desc;
    SELF.Diff_segment_id := le.segment_id <> ri.segment_id;
    SELF.Diff_segment_desc := le.segment_desc <> ri.segment_desc;
    SELF.Diff_year_start := le.year_start <> ri.year_start;
    SELF.Diff_ownership := le.ownership <> ri.ownership;
    SELF.Diff_total_employees := le.total_employees <> ri.total_employees;
    SELF.Diff_employee_range := le.employee_range <> ri.employee_range;
    SELF.Diff_total_sales := le.total_sales <> ri.total_sales;
    SELF.Diff_sales_range := le.sales_range <> ri.sales_range;
    SELF.Diff_executive_name1 := le.executive_name1 <> ri.executive_name1;
    SELF.Diff_title1 := le.title1 <> ri.title1;
    SELF.Diff_executive_name2 := le.executive_name2 <> ri.executive_name2;
    SELF.Diff_title2 := le.title2 <> ri.title2;
    SELF.Diff_executive_name3 := le.executive_name3 <> ri.executive_name3;
    SELF.Diff_title3 := le.title3 <> ri.title3;
    SELF.Diff_executive_name4 := le.executive_name4 <> ri.executive_name4;
    SELF.Diff_title4 := le.title4 <> ri.title4;
    SELF.Diff_executive_name5 := le.executive_name5 <> ri.executive_name5;
    SELF.Diff_title5 := le.title5 <> ri.title5;
    SELF.Diff_executive_name6 := le.executive_name6 <> ri.executive_name6;
    SELF.Diff_title6 := le.title6 <> ri.title6;
    SELF.Diff_executive_name7 := le.executive_name7 <> ri.executive_name7;
    SELF.Diff_title7 := le.title7 <> ri.title7;
    SELF.Diff_executive_name8 := le.executive_name8 <> ri.executive_name8;
    SELF.Diff_title8 := le.title8 <> ri.title8;
    SELF.Diff_executive_name9 := le.executive_name9 <> ri.executive_name9;
    SELF.Diff_title9 := le.title9 <> ri.title9;
    SELF.Diff_executive_name10 := le.executive_name10 <> ri.executive_name10;
    SELF.Diff_title10 := le.title10 <> ri.title10;
    SELF.Diff_status := le.status <> ri.status;
    SELF.Diff_is_closed := le.is_closed <> ri.is_closed;
    SELF.Diff_closed_date := le.closed_date <> ri.closed_date;
    SELF.Val := (SALT311.StrType)evaluate(le,pivot_exp);
    SELF.Num_Diffs := 0+ IF( SELF.Diff_link_id,1,0)+ IF( SELF.Diff_name,1,0)+ IF( SELF.Diff_alternate_business_name,1,0)+ IF( SELF.Diff_address,1,0)+ IF( SELF.Diff_address2,1,0)+ IF( SELF.Diff_city,1,0)+ IF( SELF.Diff_state,1,0)+ IF( SELF.Diff_country,1,0)+ IF( SELF.Diff_postalcode,1,0)+ IF( SELF.Diff_phone,1,0)+ IF( SELF.Diff_fax,1,0)+ IF( SELF.Diff_latitude,1,0)+ IF( SELF.Diff_longitude,1,0)+ IF( SELF.Diff_url,1,0)+ IF( SELF.Diff_fein,1,0)+ IF( SELF.Diff_position_type,1,0)+ IF( SELF.Diff_ultimate_linkid,1,0)+ IF( SELF.Diff_ultimate_name,1,0)+ IF( SELF.Diff_loc_date_last_seen,1,0)+ IF( SELF.Diff_primary_sic,1,0)+ IF( SELF.Diff_sic_desc,1,0)+ IF( SELF.Diff_primary_naics,1,0)+ IF( SELF.Diff_naics_desc,1,0)+ IF( SELF.Diff_segment_id,1,0)+ IF( SELF.Diff_segment_desc,1,0)+ IF( SELF.Diff_year_start,1,0)+ IF( SELF.Diff_ownership,1,0)+ IF( SELF.Diff_total_employees,1,0)+ IF( SELF.Diff_employee_range,1,0)+ IF( SELF.Diff_total_sales,1,0)+ IF( SELF.Diff_sales_range,1,0)+ IF( SELF.Diff_executive_name1,1,0)+ IF( SELF.Diff_title1,1,0)+ IF( SELF.Diff_executive_name2,1,0)+ IF( SELF.Diff_title2,1,0)+ IF( SELF.Diff_executive_name3,1,0)+ IF( SELF.Diff_title3,1,0)+ IF( SELF.Diff_executive_name4,1,0)+ IF( SELF.Diff_title4,1,0)+ IF( SELF.Diff_executive_name5,1,0)+ IF( SELF.Diff_title5,1,0)+ IF( SELF.Diff_executive_name6,1,0)+ IF( SELF.Diff_title6,1,0)+ IF( SELF.Diff_executive_name7,1,0)+ IF( SELF.Diff_title7,1,0)+ IF( SELF.Diff_executive_name8,1,0)+ IF( SELF.Diff_title8,1,0)+ IF( SELF.Diff_executive_name9,1,0)+ IF( SELF.Diff_title9,1,0)+ IF( SELF.Diff_executive_name10,1,0)+ IF( SELF.Diff_title10,1,0)+ IF( SELF.Diff_status,1,0)+ IF( SELF.Diff_is_closed,1,0)+ IF( SELF.Diff_closed_date,1,0);
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
    Count_Diff_link_id := COUNT(GROUP,%Closest%.Diff_link_id);
    Count_Diff_name := COUNT(GROUP,%Closest%.Diff_name);
    Count_Diff_alternate_business_name := COUNT(GROUP,%Closest%.Diff_alternate_business_name);
    Count_Diff_address := COUNT(GROUP,%Closest%.Diff_address);
    Count_Diff_address2 := COUNT(GROUP,%Closest%.Diff_address2);
    Count_Diff_city := COUNT(GROUP,%Closest%.Diff_city);
    Count_Diff_state := COUNT(GROUP,%Closest%.Diff_state);
    Count_Diff_country := COUNT(GROUP,%Closest%.Diff_country);
    Count_Diff_postalcode := COUNT(GROUP,%Closest%.Diff_postalcode);
    Count_Diff_phone := COUNT(GROUP,%Closest%.Diff_phone);
    Count_Diff_fax := COUNT(GROUP,%Closest%.Diff_fax);
    Count_Diff_latitude := COUNT(GROUP,%Closest%.Diff_latitude);
    Count_Diff_longitude := COUNT(GROUP,%Closest%.Diff_longitude);
    Count_Diff_url := COUNT(GROUP,%Closest%.Diff_url);
    Count_Diff_fein := COUNT(GROUP,%Closest%.Diff_fein);
    Count_Diff_position_type := COUNT(GROUP,%Closest%.Diff_position_type);
    Count_Diff_ultimate_linkid := COUNT(GROUP,%Closest%.Diff_ultimate_linkid);
    Count_Diff_ultimate_name := COUNT(GROUP,%Closest%.Diff_ultimate_name);
    Count_Diff_loc_date_last_seen := COUNT(GROUP,%Closest%.Diff_loc_date_last_seen);
    Count_Diff_primary_sic := COUNT(GROUP,%Closest%.Diff_primary_sic);
    Count_Diff_sic_desc := COUNT(GROUP,%Closest%.Diff_sic_desc);
    Count_Diff_primary_naics := COUNT(GROUP,%Closest%.Diff_primary_naics);
    Count_Diff_naics_desc := COUNT(GROUP,%Closest%.Diff_naics_desc);
    Count_Diff_segment_id := COUNT(GROUP,%Closest%.Diff_segment_id);
    Count_Diff_segment_desc := COUNT(GROUP,%Closest%.Diff_segment_desc);
    Count_Diff_year_start := COUNT(GROUP,%Closest%.Diff_year_start);
    Count_Diff_ownership := COUNT(GROUP,%Closest%.Diff_ownership);
    Count_Diff_total_employees := COUNT(GROUP,%Closest%.Diff_total_employees);
    Count_Diff_employee_range := COUNT(GROUP,%Closest%.Diff_employee_range);
    Count_Diff_total_sales := COUNT(GROUP,%Closest%.Diff_total_sales);
    Count_Diff_sales_range := COUNT(GROUP,%Closest%.Diff_sales_range);
    Count_Diff_executive_name1 := COUNT(GROUP,%Closest%.Diff_executive_name1);
    Count_Diff_title1 := COUNT(GROUP,%Closest%.Diff_title1);
    Count_Diff_executive_name2 := COUNT(GROUP,%Closest%.Diff_executive_name2);
    Count_Diff_title2 := COUNT(GROUP,%Closest%.Diff_title2);
    Count_Diff_executive_name3 := COUNT(GROUP,%Closest%.Diff_executive_name3);
    Count_Diff_title3 := COUNT(GROUP,%Closest%.Diff_title3);
    Count_Diff_executive_name4 := COUNT(GROUP,%Closest%.Diff_executive_name4);
    Count_Diff_title4 := COUNT(GROUP,%Closest%.Diff_title4);
    Count_Diff_executive_name5 := COUNT(GROUP,%Closest%.Diff_executive_name5);
    Count_Diff_title5 := COUNT(GROUP,%Closest%.Diff_title5);
    Count_Diff_executive_name6 := COUNT(GROUP,%Closest%.Diff_executive_name6);
    Count_Diff_title6 := COUNT(GROUP,%Closest%.Diff_title6);
    Count_Diff_executive_name7 := COUNT(GROUP,%Closest%.Diff_executive_name7);
    Count_Diff_title7 := COUNT(GROUP,%Closest%.Diff_title7);
    Count_Diff_executive_name8 := COUNT(GROUP,%Closest%.Diff_executive_name8);
    Count_Diff_title8 := COUNT(GROUP,%Closest%.Diff_title8);
    Count_Diff_executive_name9 := COUNT(GROUP,%Closest%.Diff_executive_name9);
    Count_Diff_title9 := COUNT(GROUP,%Closest%.Diff_title9);
    Count_Diff_executive_name10 := COUNT(GROUP,%Closest%.Diff_executive_name10);
    Count_Diff_title10 := COUNT(GROUP,%Closest%.Diff_title10);
    Count_Diff_status := COUNT(GROUP,%Closest%.Diff_status);
    Count_Diff_is_closed := COUNT(GROUP,%Closest%.Diff_is_closed);
    Count_Diff_closed_date := COUNT(GROUP,%Closest%.Diff_closed_date);
  END;
  out_counts := table(%Closest%,%AggRec%,true);
ENDMACRO;
END;
