IMPORT ut,SALT34;
IMPORT Scrubs_DNB_DMI; // Import modules for FieldTypes attribute definitions
EXPORT Raw_Fields := MODULE
 
// Processing for each FieldType
EXPORT SALT34.StrType FieldTypeName(UNSIGNED2 i) := CHOOSE(i,'invalid__duns','invalid__mandatory','invalid__street','invalid__city','invalid__state','invalid__zip','invalid__phone','invalid__county','invalid__msa','invalid__sic','invalid__industry','invalid__year','invalid__chars','invalid__optional_date','invalid__code','invalid__square_ft','invalid__code5','invalid__owns_rent','invalid__all_digits','invalid__hierarchy','invalid__yes_no','invalid__4orBlank','invalid__5orBlank','invalid__6orBlank','invalid__7orBlank','invalid__8orBlank','invalid__report_date','invalid__delete_indicator');
EXPORT FieldTypeNum(SALT34.StrType fn) := CASE(fn,'invalid__duns' => 1,'invalid__mandatory' => 2,'invalid__street' => 3,'invalid__city' => 4,'invalid__state' => 5,'invalid__zip' => 6,'invalid__phone' => 7,'invalid__county' => 8,'invalid__msa' => 9,'invalid__sic' => 10,'invalid__industry' => 11,'invalid__year' => 12,'invalid__chars' => 13,'invalid__optional_date' => 14,'invalid__code' => 15,'invalid__square_ft' => 16,'invalid__code5' => 17,'invalid__owns_rent' => 18,'invalid__all_digits' => 19,'invalid__hierarchy' => 20,'invalid__yes_no' => 21,'invalid__4orBlank' => 22,'invalid__5orBlank' => 23,'invalid__6orBlank' => 24,'invalid__7orBlank' => 25,'invalid__8orBlank' => 26,'invalid__report_date' => 27,'invalid__delete_indicator' => 28,0);
 
EXPORT MakeFT_invalid__duns(SALT34.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid__duns(SALT34.StrType s) := WHICH(~Scrubs_DNB_DMI.Functions.invalid_duns(s)>0);
EXPORT InValidMessageFT_invalid__duns(UNSIGNED1 wh) := CHOOSE(wh,SALT34.HygieneErrors.CustomFail('Scrubs_DNB_DMI.Functions.invalid_duns'),SALT34.HygieneErrors.Good);
 
EXPORT MakeFT_invalid__mandatory(SALT34.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid__mandatory(SALT34.StrType s) := WHICH(~(LENGTH(TRIM(s)) >= 1));
EXPORT InValidMessageFT_invalid__mandatory(UNSIGNED1 wh) := CHOOSE(wh,SALT34.HygieneErrors.NotLength('1..'),SALT34.HygieneErrors.Good);
 
EXPORT MakeFT_invalid__street(SALT34.StrType s0) := FUNCTION
  s1 := SALT34.stringfilter(s0,'0123456789 AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz\'-&(),./#'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid__street(SALT34.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT34.StringFilter(s,'0123456789 AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz\'-&(),./#'))));
EXPORT InValidMessageFT_invalid__street(UNSIGNED1 wh) := CHOOSE(wh,SALT34.HygieneErrors.NotInChars('0123456789 AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz\'-&(),./#'),SALT34.HygieneErrors.Good);
 
EXPORT MakeFT_invalid__city(SALT34.StrType s0) := FUNCTION
  s1 := SALT34.stringfilter(s0,' AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz-0123456789'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid__city(SALT34.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT34.StringFilter(s,' AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz-0123456789'))));
EXPORT InValidMessageFT_invalid__city(UNSIGNED1 wh) := CHOOSE(wh,SALT34.HygieneErrors.NotInChars(' AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz-0123456789'),SALT34.HygieneErrors.Good);
 
EXPORT MakeFT_invalid__state(SALT34.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid__state(SALT34.StrType s) := WHICH(((SALT34.StrType) s) NOT IN Scrubs_DNB_DMI.Functions.set_valid_states);
EXPORT InValidMessageFT_invalid__state(UNSIGNED1 wh) := CHOOSE(wh,SALT34.HygieneErrors.NotInEnum('Scrubs_DNB_DMI.Functions.set_valid_states'),SALT34.HygieneErrors.Good);
 
EXPORT MakeFT_invalid__zip(SALT34.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid__zip(SALT34.StrType s) := WHICH(~Scrubs_DNB_DMI.Functions.invalid_zip(s)>0);
EXPORT InValidMessageFT_invalid__zip(UNSIGNED1 wh) := CHOOSE(wh,SALT34.HygieneErrors.CustomFail('Scrubs_DNB_DMI.Functions.invalid_zip'),SALT34.HygieneErrors.Good);
 
EXPORT MakeFT_invalid__phone(SALT34.StrType s0) := FUNCTION
  s1 := SALT34.stringfilter(s0,'0123456789'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid__phone(SALT34.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT34.StringFilter(s,'0123456789'))),~(LENGTH(TRIM(s)) = 10));
EXPORT InValidMessageFT_invalid__phone(UNSIGNED1 wh) := CHOOSE(wh,SALT34.HygieneErrors.NotInChars('0123456789'),SALT34.HygieneErrors.NotLength('10'),SALT34.HygieneErrors.Good);
 
EXPORT MakeFT_invalid__county(SALT34.StrType s0) := FUNCTION
  s1 := SALT34.stringfilter(s0,' AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz\'-&.'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid__county(SALT34.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT34.StringFilter(s,' AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz\'-&.'))));
EXPORT InValidMessageFT_invalid__county(UNSIGNED1 wh) := CHOOSE(wh,SALT34.HygieneErrors.NotInChars(' AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz\'-&.'),SALT34.HygieneErrors.Good);
 
EXPORT MakeFT_invalid__msa(SALT34.StrType s0) := FUNCTION
  s1 := SALT34.stringfilter(s0,'0123456789'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid__msa(SALT34.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT34.StringFilter(s,'0123456789'))),~(LENGTH(TRIM(s)) = 4));
EXPORT InValidMessageFT_invalid__msa(UNSIGNED1 wh) := CHOOSE(wh,SALT34.HygieneErrors.NotInChars('0123456789'),SALT34.HygieneErrors.NotLength('4'),SALT34.HygieneErrors.Good);
 
EXPORT MakeFT_invalid__sic(SALT34.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid__sic(SALT34.StrType s) := WHICH(~Scrubs_DNB_DMI.Functions.invalid_sic(s)>0);
EXPORT InValidMessageFT_invalid__sic(UNSIGNED1 wh) := CHOOSE(wh,SALT34.HygieneErrors.CustomFail('Scrubs_DNB_DMI.Functions.invalid_sic'),SALT34.HygieneErrors.Good);
 
EXPORT MakeFT_invalid__industry(SALT34.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid__industry(SALT34.StrType s) := WHICH(((SALT34.StrType) s) NOT IN Scrubs_DNB_DMI.Functions.set_valid_industry);
EXPORT InValidMessageFT_invalid__industry(UNSIGNED1 wh) := CHOOSE(wh,SALT34.HygieneErrors.NotInEnum('Scrubs_DNB_DMI.Functions.set_valid_industry'),SALT34.HygieneErrors.Good);
 
EXPORT MakeFT_invalid__year(SALT34.StrType s0) := FUNCTION
  s1 := SALT34.stringfilter(s0,'0123456789'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid__year(SALT34.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT34.StringFilter(s,'0123456789'))),~(LENGTH(TRIM(s)) = 0 OR LENGTH(TRIM(s)) = 4));
EXPORT InValidMessageFT_invalid__year(UNSIGNED1 wh) := CHOOSE(wh,SALT34.HygieneErrors.NotInChars('0123456789'),SALT34.HygieneErrors.NotLength('0,4'),SALT34.HygieneErrors.Good);
 
EXPORT MakeFT_invalid__chars(SALT34.StrType s0) := FUNCTION
  s1 := SALT34.stringfilter(s0,' 0123456789/'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid__chars(SALT34.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT34.StringFilter(s,' 0123456789/'))));
EXPORT InValidMessageFT_invalid__chars(UNSIGNED1 wh) := CHOOSE(wh,SALT34.HygieneErrors.NotInChars(' 0123456789/'),SALT34.HygieneErrors.Good);
 
EXPORT MakeFT_invalid__optional_date(SALT34.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid__optional_date(SALT34.StrType s) := WHICH(~Scrubs_DNB_DMI.Functions.invalid_optional_date(s)>0);
EXPORT InValidMessageFT_invalid__optional_date(UNSIGNED1 wh) := CHOOSE(wh,SALT34.HygieneErrors.CustomFail('Scrubs_DNB_DMI.Functions.invalid_optional_date'),SALT34.HygieneErrors.Good);
 
EXPORT MakeFT_invalid__code(SALT34.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid__code(SALT34.StrType s) := WHICH(((SALT34.StrType) s) NOT IN ['0','1','2','3',' ']);
EXPORT InValidMessageFT_invalid__code(UNSIGNED1 wh) := CHOOSE(wh,SALT34.HygieneErrors.NotInEnum('0|1|2|3| '),SALT34.HygieneErrors.Good);
 
EXPORT MakeFT_invalid__square_ft(SALT34.StrType s0) := FUNCTION
  s1 := SALT34.stringfilter(s0,' 0123456789'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid__square_ft(SALT34.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT34.StringFilter(s,' 0123456789'))));
EXPORT InValidMessageFT_invalid__square_ft(UNSIGNED1 wh) := CHOOSE(wh,SALT34.HygieneErrors.NotInChars(' 0123456789'),SALT34.HygieneErrors.Good);
 
EXPORT MakeFT_invalid__code5(SALT34.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid__code5(SALT34.StrType s) := WHICH(((SALT34.StrType) s) NOT IN ['0','1','2','3','4','5',' ']);
EXPORT InValidMessageFT_invalid__code5(UNSIGNED1 wh) := CHOOSE(wh,SALT34.HygieneErrors.NotInEnum('0|1|2|3|4|5| '),SALT34.HygieneErrors.Good);
 
EXPORT MakeFT_invalid__owns_rent(SALT34.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid__owns_rent(SALT34.StrType s) := WHICH(((SALT34.StrType) s) NOT IN ['0','1','2',' ']);
EXPORT InValidMessageFT_invalid__owns_rent(UNSIGNED1 wh) := CHOOSE(wh,SALT34.HygieneErrors.NotInEnum('0|1|2| '),SALT34.HygieneErrors.Good);
 
EXPORT MakeFT_invalid__all_digits(SALT34.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid__all_digits(SALT34.StrType s) := WHICH(~Scrubs_DNB_DMI.Functions.invalid_all_digits(s)>0);
EXPORT InValidMessageFT_invalid__all_digits(UNSIGNED1 wh) := CHOOSE(wh,SALT34.HygieneErrors.CustomFail('Scrubs_DNB_DMI.Functions.invalid_all_digits'),SALT34.HygieneErrors.Good);
 
EXPORT MakeFT_invalid__hierarchy(SALT34.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid__hierarchy(SALT34.StrType s) := WHICH(~Scrubs_DNB_DMI.Functions.invalid_hierarchy(s)>0);
EXPORT InValidMessageFT_invalid__hierarchy(UNSIGNED1 wh) := CHOOSE(wh,SALT34.HygieneErrors.CustomFail('Scrubs_DNB_DMI.Functions.invalid_hierarchy'),SALT34.HygieneErrors.Good);
 
EXPORT MakeFT_invalid__yes_no(SALT34.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid__yes_no(SALT34.StrType s) := WHICH(((SALT34.StrType) s) NOT IN ['Y','N',' ']);
EXPORT InValidMessageFT_invalid__yes_no(UNSIGNED1 wh) := CHOOSE(wh,SALT34.HygieneErrors.NotInEnum('Y|N| '),SALT34.HygieneErrors.Good);
 
EXPORT MakeFT_invalid__4orBlank(SALT34.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid__4orBlank(SALT34.StrType s) := WHICH(((SALT34.StrType) s) NOT IN ['4',' ']);
EXPORT InValidMessageFT_invalid__4orBlank(UNSIGNED1 wh) := CHOOSE(wh,SALT34.HygieneErrors.NotInEnum('4| '),SALT34.HygieneErrors.Good);
 
EXPORT MakeFT_invalid__5orBlank(SALT34.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid__5orBlank(SALT34.StrType s) := WHICH(((SALT34.StrType) s) NOT IN ['5',' ']);
EXPORT InValidMessageFT_invalid__5orBlank(UNSIGNED1 wh) := CHOOSE(wh,SALT34.HygieneErrors.NotInEnum('5| '),SALT34.HygieneErrors.Good);
 
EXPORT MakeFT_invalid__6orBlank(SALT34.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid__6orBlank(SALT34.StrType s) := WHICH(((SALT34.StrType) s) NOT IN ['6',' ']);
EXPORT InValidMessageFT_invalid__6orBlank(UNSIGNED1 wh) := CHOOSE(wh,SALT34.HygieneErrors.NotInEnum('6| '),SALT34.HygieneErrors.Good);
 
EXPORT MakeFT_invalid__7orBlank(SALT34.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid__7orBlank(SALT34.StrType s) := WHICH(((SALT34.StrType) s) NOT IN ['7',' ']);
EXPORT InValidMessageFT_invalid__7orBlank(UNSIGNED1 wh) := CHOOSE(wh,SALT34.HygieneErrors.NotInEnum('7| '),SALT34.HygieneErrors.Good);
 
EXPORT MakeFT_invalid__8orBlank(SALT34.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid__8orBlank(SALT34.StrType s) := WHICH(((SALT34.StrType) s) NOT IN ['8',' ']);
EXPORT InValidMessageFT_invalid__8orBlank(UNSIGNED1 wh) := CHOOSE(wh,SALT34.HygieneErrors.NotInEnum('8| '),SALT34.HygieneErrors.Good);
 
EXPORT MakeFT_invalid__report_date(SALT34.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid__report_date(SALT34.StrType s) := WHICH(~Scrubs_DNB_DMI.Functions.invalid_report_date(s)>0);
EXPORT InValidMessageFT_invalid__report_date(UNSIGNED1 wh) := CHOOSE(wh,SALT34.HygieneErrors.CustomFail('Scrubs_DNB_DMI.Functions.invalid_report_date'),SALT34.HygieneErrors.Good);
 
EXPORT MakeFT_invalid__delete_indicator(SALT34.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid__delete_indicator(SALT34.StrType s) := WHICH(((SALT34.StrType) s) NOT IN ['D',' ']);
EXPORT InValidMessageFT_invalid__delete_indicator(UNSIGNED1 wh) := CHOOSE(wh,SALT34.HygieneErrors.NotInEnum('D| '),SALT34.HygieneErrors.Good);
 
EXPORT SALT34.StrType FieldName(UNSIGNED2 i) := CHOOSE(i,'duns_number','business_name','street','city','state','zip_code','mail_address','mail_city','mail_state','mail_zip_code','telephone_number','county_name','msa_code','sic1','sic1a','sic1b','sic1c','sic1d','sic2','sic2a','sic2b','sic2c','sic2d','sic3','sic3a','sic3b','sic3c','sic3d','sic4','sic4a','sic4b','sic4c','sic4d','sic5','sic5a','sic5b','sic5c','sic5d','sic6','sic6a','sic6b','sic6c','sic6d','industry_group','year_started','date_of_incorporation','state_of_incorporation_abbr','annual_sales_code','employees_here_code','annual_sales_revision_date','square_footage','sals_territory','owns_rents','number_of_accounts','small_business_indicator','minority_owned','cottage_indicator','foreign_owned','manufacturing_here_indicator','public_indicator','importer_exporter_indicator','structure_type','type_of_establishment','parent_duns_number','ultimate_duns_number','headquarters_duns_number','dias_code','hierarchy_code','ultimate_indicator','hot_list_new_indicator','hot_list_ownership_change_indicator','hot_list_ceo_change_indicator','hot_list_company_name_change_ind','hot_list_address_change_indicator','hot_list_telephone_change_indicator','hot_list_new_change_date','hot_list_ownership_change_date','hot_list_ceo_change_date','hot_list_company_name_chg_date','hot_list_address_change_date','hot_list_telephone_change_date','report_date','delete_record_indicator');
EXPORT FieldNum(SALT34.StrType fn) := CASE(fn,'duns_number' => 0,'business_name' => 1,'street' => 2,'city' => 3,'state' => 4,'zip_code' => 5,'mail_address' => 6,'mail_city' => 7,'mail_state' => 8,'mail_zip_code' => 9,'telephone_number' => 10,'county_name' => 11,'msa_code' => 12,'sic1' => 13,'sic1a' => 14,'sic1b' => 15,'sic1c' => 16,'sic1d' => 17,'sic2' => 18,'sic2a' => 19,'sic2b' => 20,'sic2c' => 21,'sic2d' => 22,'sic3' => 23,'sic3a' => 24,'sic3b' => 25,'sic3c' => 26,'sic3d' => 27,'sic4' => 28,'sic4a' => 29,'sic4b' => 30,'sic4c' => 31,'sic4d' => 32,'sic5' => 33,'sic5a' => 34,'sic5b' => 35,'sic5c' => 36,'sic5d' => 37,'sic6' => 38,'sic6a' => 39,'sic6b' => 40,'sic6c' => 41,'sic6d' => 42,'industry_group' => 43,'year_started' => 44,'date_of_incorporation' => 45,'state_of_incorporation_abbr' => 46,'annual_sales_code' => 47,'employees_here_code' => 48,'annual_sales_revision_date' => 49,'square_footage' => 50,'sals_territory' => 51,'owns_rents' => 52,'number_of_accounts' => 53,'small_business_indicator' => 54,'minority_owned' => 55,'cottage_indicator' => 56,'foreign_owned' => 57,'manufacturing_here_indicator' => 58,'public_indicator' => 59,'importer_exporter_indicator' => 60,'structure_type' => 61,'type_of_establishment' => 62,'parent_duns_number' => 63,'ultimate_duns_number' => 64,'headquarters_duns_number' => 65,'dias_code' => 66,'hierarchy_code' => 67,'ultimate_indicator' => 68,'hot_list_new_indicator' => 69,'hot_list_ownership_change_indicator' => 70,'hot_list_ceo_change_indicator' => 71,'hot_list_company_name_change_ind' => 72,'hot_list_address_change_indicator' => 73,'hot_list_telephone_change_indicator' => 74,'hot_list_new_change_date' => 75,'hot_list_ownership_change_date' => 76,'hot_list_ceo_change_date' => 77,'hot_list_company_name_chg_date' => 78,'hot_list_address_change_date' => 79,'hot_list_telephone_change_date' => 80,'report_date' => 81,'delete_record_indicator' => 82,0);
 
//Individual field level validation
 
EXPORT Make_duns_number(SALT34.StrType s0) := MakeFT_invalid__duns(s0);
EXPORT InValid_duns_number(SALT34.StrType s) := InValidFT_invalid__duns(s);
EXPORT InValidMessage_duns_number(UNSIGNED1 wh) := InValidMessageFT_invalid__duns(wh);
 
EXPORT Make_business_name(SALT34.StrType s0) := MakeFT_invalid__mandatory(s0);
EXPORT InValid_business_name(SALT34.StrType s) := InValidFT_invalid__mandatory(s);
EXPORT InValidMessage_business_name(UNSIGNED1 wh) := InValidMessageFT_invalid__mandatory(wh);
 
EXPORT Make_street(SALT34.StrType s0) := MakeFT_invalid__street(s0);
EXPORT InValid_street(SALT34.StrType s) := InValidFT_invalid__street(s);
EXPORT InValidMessage_street(UNSIGNED1 wh) := InValidMessageFT_invalid__street(wh);
 
EXPORT Make_city(SALT34.StrType s0) := MakeFT_invalid__city(s0);
EXPORT InValid_city(SALT34.StrType s) := InValidFT_invalid__city(s);
EXPORT InValidMessage_city(UNSIGNED1 wh) := InValidMessageFT_invalid__city(wh);
 
EXPORT Make_state(SALT34.StrType s0) := MakeFT_invalid__state(s0);
EXPORT InValid_state(SALT34.StrType s) := InValidFT_invalid__state(s);
EXPORT InValidMessage_state(UNSIGNED1 wh) := InValidMessageFT_invalid__state(wh);
 
EXPORT Make_zip_code(SALT34.StrType s0) := MakeFT_invalid__zip(s0);
EXPORT InValid_zip_code(SALT34.StrType s) := InValidFT_invalid__zip(s);
EXPORT InValidMessage_zip_code(UNSIGNED1 wh) := InValidMessageFT_invalid__zip(wh);
 
EXPORT Make_mail_address(SALT34.StrType s0) := MakeFT_invalid__street(s0);
EXPORT InValid_mail_address(SALT34.StrType s) := InValidFT_invalid__street(s);
EXPORT InValidMessage_mail_address(UNSIGNED1 wh) := InValidMessageFT_invalid__street(wh);
 
EXPORT Make_mail_city(SALT34.StrType s0) := MakeFT_invalid__city(s0);
EXPORT InValid_mail_city(SALT34.StrType s) := InValidFT_invalid__city(s);
EXPORT InValidMessage_mail_city(UNSIGNED1 wh) := InValidMessageFT_invalid__city(wh);
 
EXPORT Make_mail_state(SALT34.StrType s0) := MakeFT_invalid__state(s0);
EXPORT InValid_mail_state(SALT34.StrType s) := InValidFT_invalid__state(s);
EXPORT InValidMessage_mail_state(UNSIGNED1 wh) := InValidMessageFT_invalid__state(wh);
 
EXPORT Make_mail_zip_code(SALT34.StrType s0) := MakeFT_invalid__zip(s0);
EXPORT InValid_mail_zip_code(SALT34.StrType s) := InValidFT_invalid__zip(s);
EXPORT InValidMessage_mail_zip_code(UNSIGNED1 wh) := InValidMessageFT_invalid__zip(wh);
 
EXPORT Make_telephone_number(SALT34.StrType s0) := MakeFT_invalid__phone(s0);
EXPORT InValid_telephone_number(SALT34.StrType s) := InValidFT_invalid__phone(s);
EXPORT InValidMessage_telephone_number(UNSIGNED1 wh) := InValidMessageFT_invalid__phone(wh);
 
EXPORT Make_county_name(SALT34.StrType s0) := MakeFT_invalid__county(s0);
EXPORT InValid_county_name(SALT34.StrType s) := InValidFT_invalid__county(s);
EXPORT InValidMessage_county_name(UNSIGNED1 wh) := InValidMessageFT_invalid__county(wh);
 
EXPORT Make_msa_code(SALT34.StrType s0) := MakeFT_invalid__msa(s0);
EXPORT InValid_msa_code(SALT34.StrType s) := InValidFT_invalid__msa(s);
EXPORT InValidMessage_msa_code(UNSIGNED1 wh) := InValidMessageFT_invalid__msa(wh);
 
EXPORT Make_sic1(SALT34.StrType s0) := MakeFT_invalid__sic(s0);
EXPORT InValid_sic1(SALT34.StrType s) := InValidFT_invalid__sic(s);
EXPORT InValidMessage_sic1(UNSIGNED1 wh) := InValidMessageFT_invalid__sic(wh);
 
EXPORT Make_sic1a(SALT34.StrType s0) := MakeFT_invalid__sic(s0);
EXPORT InValid_sic1a(SALT34.StrType s) := InValidFT_invalid__sic(s);
EXPORT InValidMessage_sic1a(UNSIGNED1 wh) := InValidMessageFT_invalid__sic(wh);
 
EXPORT Make_sic1b(SALT34.StrType s0) := MakeFT_invalid__sic(s0);
EXPORT InValid_sic1b(SALT34.StrType s) := InValidFT_invalid__sic(s);
EXPORT InValidMessage_sic1b(UNSIGNED1 wh) := InValidMessageFT_invalid__sic(wh);
 
EXPORT Make_sic1c(SALT34.StrType s0) := MakeFT_invalid__sic(s0);
EXPORT InValid_sic1c(SALT34.StrType s) := InValidFT_invalid__sic(s);
EXPORT InValidMessage_sic1c(UNSIGNED1 wh) := InValidMessageFT_invalid__sic(wh);
 
EXPORT Make_sic1d(SALT34.StrType s0) := MakeFT_invalid__sic(s0);
EXPORT InValid_sic1d(SALT34.StrType s) := InValidFT_invalid__sic(s);
EXPORT InValidMessage_sic1d(UNSIGNED1 wh) := InValidMessageFT_invalid__sic(wh);
 
EXPORT Make_sic2(SALT34.StrType s0) := MakeFT_invalid__sic(s0);
EXPORT InValid_sic2(SALT34.StrType s) := InValidFT_invalid__sic(s);
EXPORT InValidMessage_sic2(UNSIGNED1 wh) := InValidMessageFT_invalid__sic(wh);
 
EXPORT Make_sic2a(SALT34.StrType s0) := MakeFT_invalid__sic(s0);
EXPORT InValid_sic2a(SALT34.StrType s) := InValidFT_invalid__sic(s);
EXPORT InValidMessage_sic2a(UNSIGNED1 wh) := InValidMessageFT_invalid__sic(wh);
 
EXPORT Make_sic2b(SALT34.StrType s0) := MakeFT_invalid__sic(s0);
EXPORT InValid_sic2b(SALT34.StrType s) := InValidFT_invalid__sic(s);
EXPORT InValidMessage_sic2b(UNSIGNED1 wh) := InValidMessageFT_invalid__sic(wh);
 
EXPORT Make_sic2c(SALT34.StrType s0) := MakeFT_invalid__sic(s0);
EXPORT InValid_sic2c(SALT34.StrType s) := InValidFT_invalid__sic(s);
EXPORT InValidMessage_sic2c(UNSIGNED1 wh) := InValidMessageFT_invalid__sic(wh);
 
EXPORT Make_sic2d(SALT34.StrType s0) := MakeFT_invalid__sic(s0);
EXPORT InValid_sic2d(SALT34.StrType s) := InValidFT_invalid__sic(s);
EXPORT InValidMessage_sic2d(UNSIGNED1 wh) := InValidMessageFT_invalid__sic(wh);
 
EXPORT Make_sic3(SALT34.StrType s0) := MakeFT_invalid__sic(s0);
EXPORT InValid_sic3(SALT34.StrType s) := InValidFT_invalid__sic(s);
EXPORT InValidMessage_sic3(UNSIGNED1 wh) := InValidMessageFT_invalid__sic(wh);
 
EXPORT Make_sic3a(SALT34.StrType s0) := MakeFT_invalid__sic(s0);
EXPORT InValid_sic3a(SALT34.StrType s) := InValidFT_invalid__sic(s);
EXPORT InValidMessage_sic3a(UNSIGNED1 wh) := InValidMessageFT_invalid__sic(wh);
 
EXPORT Make_sic3b(SALT34.StrType s0) := MakeFT_invalid__sic(s0);
EXPORT InValid_sic3b(SALT34.StrType s) := InValidFT_invalid__sic(s);
EXPORT InValidMessage_sic3b(UNSIGNED1 wh) := InValidMessageFT_invalid__sic(wh);
 
EXPORT Make_sic3c(SALT34.StrType s0) := MakeFT_invalid__sic(s0);
EXPORT InValid_sic3c(SALT34.StrType s) := InValidFT_invalid__sic(s);
EXPORT InValidMessage_sic3c(UNSIGNED1 wh) := InValidMessageFT_invalid__sic(wh);
 
EXPORT Make_sic3d(SALT34.StrType s0) := MakeFT_invalid__sic(s0);
EXPORT InValid_sic3d(SALT34.StrType s) := InValidFT_invalid__sic(s);
EXPORT InValidMessage_sic3d(UNSIGNED1 wh) := InValidMessageFT_invalid__sic(wh);
 
EXPORT Make_sic4(SALT34.StrType s0) := MakeFT_invalid__sic(s0);
EXPORT InValid_sic4(SALT34.StrType s) := InValidFT_invalid__sic(s);
EXPORT InValidMessage_sic4(UNSIGNED1 wh) := InValidMessageFT_invalid__sic(wh);
 
EXPORT Make_sic4a(SALT34.StrType s0) := MakeFT_invalid__sic(s0);
EXPORT InValid_sic4a(SALT34.StrType s) := InValidFT_invalid__sic(s);
EXPORT InValidMessage_sic4a(UNSIGNED1 wh) := InValidMessageFT_invalid__sic(wh);
 
EXPORT Make_sic4b(SALT34.StrType s0) := MakeFT_invalid__sic(s0);
EXPORT InValid_sic4b(SALT34.StrType s) := InValidFT_invalid__sic(s);
EXPORT InValidMessage_sic4b(UNSIGNED1 wh) := InValidMessageFT_invalid__sic(wh);
 
EXPORT Make_sic4c(SALT34.StrType s0) := MakeFT_invalid__sic(s0);
EXPORT InValid_sic4c(SALT34.StrType s) := InValidFT_invalid__sic(s);
EXPORT InValidMessage_sic4c(UNSIGNED1 wh) := InValidMessageFT_invalid__sic(wh);
 
EXPORT Make_sic4d(SALT34.StrType s0) := MakeFT_invalid__sic(s0);
EXPORT InValid_sic4d(SALT34.StrType s) := InValidFT_invalid__sic(s);
EXPORT InValidMessage_sic4d(UNSIGNED1 wh) := InValidMessageFT_invalid__sic(wh);
 
EXPORT Make_sic5(SALT34.StrType s0) := MakeFT_invalid__sic(s0);
EXPORT InValid_sic5(SALT34.StrType s) := InValidFT_invalid__sic(s);
EXPORT InValidMessage_sic5(UNSIGNED1 wh) := InValidMessageFT_invalid__sic(wh);
 
EXPORT Make_sic5a(SALT34.StrType s0) := MakeFT_invalid__sic(s0);
EXPORT InValid_sic5a(SALT34.StrType s) := InValidFT_invalid__sic(s);
EXPORT InValidMessage_sic5a(UNSIGNED1 wh) := InValidMessageFT_invalid__sic(wh);
 
EXPORT Make_sic5b(SALT34.StrType s0) := MakeFT_invalid__sic(s0);
EXPORT InValid_sic5b(SALT34.StrType s) := InValidFT_invalid__sic(s);
EXPORT InValidMessage_sic5b(UNSIGNED1 wh) := InValidMessageFT_invalid__sic(wh);
 
EXPORT Make_sic5c(SALT34.StrType s0) := MakeFT_invalid__sic(s0);
EXPORT InValid_sic5c(SALT34.StrType s) := InValidFT_invalid__sic(s);
EXPORT InValidMessage_sic5c(UNSIGNED1 wh) := InValidMessageFT_invalid__sic(wh);
 
EXPORT Make_sic5d(SALT34.StrType s0) := MakeFT_invalid__sic(s0);
EXPORT InValid_sic5d(SALT34.StrType s) := InValidFT_invalid__sic(s);
EXPORT InValidMessage_sic5d(UNSIGNED1 wh) := InValidMessageFT_invalid__sic(wh);
 
EXPORT Make_sic6(SALT34.StrType s0) := MakeFT_invalid__sic(s0);
EXPORT InValid_sic6(SALT34.StrType s) := InValidFT_invalid__sic(s);
EXPORT InValidMessage_sic6(UNSIGNED1 wh) := InValidMessageFT_invalid__sic(wh);
 
EXPORT Make_sic6a(SALT34.StrType s0) := MakeFT_invalid__sic(s0);
EXPORT InValid_sic6a(SALT34.StrType s) := InValidFT_invalid__sic(s);
EXPORT InValidMessage_sic6a(UNSIGNED1 wh) := InValidMessageFT_invalid__sic(wh);
 
EXPORT Make_sic6b(SALT34.StrType s0) := MakeFT_invalid__sic(s0);
EXPORT InValid_sic6b(SALT34.StrType s) := InValidFT_invalid__sic(s);
EXPORT InValidMessage_sic6b(UNSIGNED1 wh) := InValidMessageFT_invalid__sic(wh);
 
EXPORT Make_sic6c(SALT34.StrType s0) := MakeFT_invalid__sic(s0);
EXPORT InValid_sic6c(SALT34.StrType s) := InValidFT_invalid__sic(s);
EXPORT InValidMessage_sic6c(UNSIGNED1 wh) := InValidMessageFT_invalid__sic(wh);
 
EXPORT Make_sic6d(SALT34.StrType s0) := MakeFT_invalid__sic(s0);
EXPORT InValid_sic6d(SALT34.StrType s) := InValidFT_invalid__sic(s);
EXPORT InValidMessage_sic6d(UNSIGNED1 wh) := InValidMessageFT_invalid__sic(wh);
 
EXPORT Make_industry_group(SALT34.StrType s0) := MakeFT_invalid__industry(s0);
EXPORT InValid_industry_group(SALT34.StrType s) := InValidFT_invalid__industry(s);
EXPORT InValidMessage_industry_group(UNSIGNED1 wh) := InValidMessageFT_invalid__industry(wh);
 
EXPORT Make_year_started(SALT34.StrType s0) := MakeFT_invalid__year(s0);
EXPORT InValid_year_started(SALT34.StrType s) := InValidFT_invalid__year(s);
EXPORT InValidMessage_year_started(UNSIGNED1 wh) := InValidMessageFT_invalid__year(wh);
 
EXPORT Make_date_of_incorporation(SALT34.StrType s0) := MakeFT_invalid__chars(s0);
EXPORT InValid_date_of_incorporation(SALT34.StrType s) := InValidFT_invalid__chars(s);
EXPORT InValidMessage_date_of_incorporation(UNSIGNED1 wh) := InValidMessageFT_invalid__chars(wh);
 
EXPORT Make_state_of_incorporation_abbr(SALT34.StrType s0) := MakeFT_invalid__state(s0);
EXPORT InValid_state_of_incorporation_abbr(SALT34.StrType s) := InValidFT_invalid__state(s);
EXPORT InValidMessage_state_of_incorporation_abbr(UNSIGNED1 wh) := InValidMessageFT_invalid__state(wh);
 
EXPORT Make_annual_sales_code(SALT34.StrType s0) := MakeFT_invalid__code(s0);
EXPORT InValid_annual_sales_code(SALT34.StrType s) := InValidFT_invalid__code(s);
EXPORT InValidMessage_annual_sales_code(UNSIGNED1 wh) := InValidMessageFT_invalid__code(wh);
 
EXPORT Make_employees_here_code(SALT34.StrType s0) := MakeFT_invalid__code(s0);
EXPORT InValid_employees_here_code(SALT34.StrType s) := InValidFT_invalid__code(s);
EXPORT InValidMessage_employees_here_code(UNSIGNED1 wh) := InValidMessageFT_invalid__code(wh);
 
EXPORT Make_annual_sales_revision_date(SALT34.StrType s0) := MakeFT_invalid__optional_date(s0);
EXPORT InValid_annual_sales_revision_date(SALT34.StrType s) := InValidFT_invalid__optional_date(s);
EXPORT InValidMessage_annual_sales_revision_date(UNSIGNED1 wh) := InValidMessageFT_invalid__optional_date(wh);
 
EXPORT Make_square_footage(SALT34.StrType s0) := MakeFT_invalid__square_ft(s0);
EXPORT InValid_square_footage(SALT34.StrType s) := InValidFT_invalid__square_ft(s);
EXPORT InValidMessage_square_footage(UNSIGNED1 wh) := InValidMessageFT_invalid__square_ft(wh);
 
EXPORT Make_sals_territory(SALT34.StrType s0) := MakeFT_invalid__code5(s0);
EXPORT InValid_sals_territory(SALT34.StrType s) := InValidFT_invalid__code5(s);
EXPORT InValidMessage_sals_territory(UNSIGNED1 wh) := InValidMessageFT_invalid__code5(wh);
 
EXPORT Make_owns_rents(SALT34.StrType s0) := MakeFT_invalid__owns_rent(s0);
EXPORT InValid_owns_rents(SALT34.StrType s) := InValidFT_invalid__owns_rent(s);
EXPORT InValidMessage_owns_rents(UNSIGNED1 wh) := InValidMessageFT_invalid__owns_rent(wh);
 
EXPORT Make_number_of_accounts(SALT34.StrType s0) := MakeFT_invalid__all_digits(s0);
EXPORT InValid_number_of_accounts(SALT34.StrType s) := InValidFT_invalid__all_digits(s);
EXPORT InValidMessage_number_of_accounts(UNSIGNED1 wh) := InValidMessageFT_invalid__all_digits(wh);
 
EXPORT Make_small_business_indicator(SALT34.StrType s0) := MakeFT_invalid__yes_no(s0);
EXPORT InValid_small_business_indicator(SALT34.StrType s) := InValidFT_invalid__yes_no(s);
EXPORT InValidMessage_small_business_indicator(UNSIGNED1 wh) := InValidMessageFT_invalid__yes_no(wh);
 
EXPORT Make_minority_owned(SALT34.StrType s0) := MakeFT_invalid__yes_no(s0);
EXPORT InValid_minority_owned(SALT34.StrType s) := InValidFT_invalid__yes_no(s);
EXPORT InValidMessage_minority_owned(UNSIGNED1 wh) := InValidMessageFT_invalid__yes_no(wh);
 
EXPORT Make_cottage_indicator(SALT34.StrType s0) := MakeFT_invalid__yes_no(s0);
EXPORT InValid_cottage_indicator(SALT34.StrType s) := InValidFT_invalid__yes_no(s);
EXPORT InValidMessage_cottage_indicator(UNSIGNED1 wh) := InValidMessageFT_invalid__yes_no(wh);
 
EXPORT Make_foreign_owned(SALT34.StrType s0) := MakeFT_invalid__yes_no(s0);
EXPORT InValid_foreign_owned(SALT34.StrType s) := InValidFT_invalid__yes_no(s);
EXPORT InValidMessage_foreign_owned(UNSIGNED1 wh) := InValidMessageFT_invalid__yes_no(wh);
 
EXPORT Make_manufacturing_here_indicator(SALT34.StrType s0) := MakeFT_invalid__yes_no(s0);
EXPORT InValid_manufacturing_here_indicator(SALT34.StrType s) := InValidFT_invalid__yes_no(s);
EXPORT InValidMessage_manufacturing_here_indicator(UNSIGNED1 wh) := InValidMessageFT_invalid__yes_no(wh);
 
EXPORT Make_public_indicator(SALT34.StrType s0) := MakeFT_invalid__yes_no(s0);
EXPORT InValid_public_indicator(SALT34.StrType s) := InValidFT_invalid__yes_no(s);
EXPORT InValidMessage_public_indicator(UNSIGNED1 wh) := InValidMessageFT_invalid__yes_no(wh);
 
EXPORT Make_importer_exporter_indicator(SALT34.StrType s0) := MakeFT_invalid__code(s0);
EXPORT InValid_importer_exporter_indicator(SALT34.StrType s) := InValidFT_invalid__code(s);
EXPORT InValidMessage_importer_exporter_indicator(UNSIGNED1 wh) := InValidMessageFT_invalid__code(wh);
 
EXPORT Make_structure_type(SALT34.StrType s0) := MakeFT_invalid__code(s0);
EXPORT InValid_structure_type(SALT34.StrType s) := InValidFT_invalid__code(s);
EXPORT InValidMessage_structure_type(UNSIGNED1 wh) := InValidMessageFT_invalid__code(wh);
 
EXPORT Make_type_of_establishment(SALT34.StrType s0) := MakeFT_invalid__code5(s0);
EXPORT InValid_type_of_establishment(SALT34.StrType s) := InValidFT_invalid__code5(s);
EXPORT InValidMessage_type_of_establishment(UNSIGNED1 wh) := InValidMessageFT_invalid__code5(wh);
 
EXPORT Make_parent_duns_number(SALT34.StrType s0) := MakeFT_invalid__duns(s0);
EXPORT InValid_parent_duns_number(SALT34.StrType s) := InValidFT_invalid__duns(s);
EXPORT InValidMessage_parent_duns_number(UNSIGNED1 wh) := InValidMessageFT_invalid__duns(wh);
 
EXPORT Make_ultimate_duns_number(SALT34.StrType s0) := MakeFT_invalid__duns(s0);
EXPORT InValid_ultimate_duns_number(SALT34.StrType s) := InValidFT_invalid__duns(s);
EXPORT InValidMessage_ultimate_duns_number(UNSIGNED1 wh) := InValidMessageFT_invalid__duns(wh);
 
EXPORT Make_headquarters_duns_number(SALT34.StrType s0) := MakeFT_invalid__duns(s0);
EXPORT InValid_headquarters_duns_number(SALT34.StrType s) := InValidFT_invalid__duns(s);
EXPORT InValidMessage_headquarters_duns_number(UNSIGNED1 wh) := InValidMessageFT_invalid__duns(wh);
 
EXPORT Make_dias_code(SALT34.StrType s0) := MakeFT_invalid__all_digits(s0);
EXPORT InValid_dias_code(SALT34.StrType s) := InValidFT_invalid__all_digits(s);
EXPORT InValidMessage_dias_code(UNSIGNED1 wh) := InValidMessageFT_invalid__all_digits(wh);
 
EXPORT Make_hierarchy_code(SALT34.StrType s0) := MakeFT_invalid__hierarchy(s0);
EXPORT InValid_hierarchy_code(SALT34.StrType s) := InValidFT_invalid__hierarchy(s);
EXPORT InValidMessage_hierarchy_code(UNSIGNED1 wh) := InValidMessageFT_invalid__hierarchy(wh);
 
EXPORT Make_ultimate_indicator(SALT34.StrType s0) := MakeFT_invalid__yes_no(s0);
EXPORT InValid_ultimate_indicator(SALT34.StrType s) := InValidFT_invalid__yes_no(s);
EXPORT InValidMessage_ultimate_indicator(UNSIGNED1 wh) := InValidMessageFT_invalid__yes_no(wh);
 
EXPORT Make_hot_list_new_indicator(SALT34.StrType s0) := MakeFT_invalid__code(s0);
EXPORT InValid_hot_list_new_indicator(SALT34.StrType s) := InValidFT_invalid__code(s);
EXPORT InValidMessage_hot_list_new_indicator(UNSIGNED1 wh) := InValidMessageFT_invalid__code(wh);
 
EXPORT Make_hot_list_ownership_change_indicator(SALT34.StrType s0) := MakeFT_invalid__4orBlank(s0);
EXPORT InValid_hot_list_ownership_change_indicator(SALT34.StrType s) := InValidFT_invalid__4orBlank(s);
EXPORT InValidMessage_hot_list_ownership_change_indicator(UNSIGNED1 wh) := InValidMessageFT_invalid__4orBlank(wh);
 
EXPORT Make_hot_list_ceo_change_indicator(SALT34.StrType s0) := MakeFT_invalid__5orBlank(s0);
EXPORT InValid_hot_list_ceo_change_indicator(SALT34.StrType s) := InValidFT_invalid__5orBlank(s);
EXPORT InValidMessage_hot_list_ceo_change_indicator(UNSIGNED1 wh) := InValidMessageFT_invalid__5orBlank(wh);
 
EXPORT Make_hot_list_company_name_change_ind(SALT34.StrType s0) := MakeFT_invalid__6orBlank(s0);
EXPORT InValid_hot_list_company_name_change_ind(SALT34.StrType s) := InValidFT_invalid__6orBlank(s);
EXPORT InValidMessage_hot_list_company_name_change_ind(UNSIGNED1 wh) := InValidMessageFT_invalid__6orBlank(wh);
 
EXPORT Make_hot_list_address_change_indicator(SALT34.StrType s0) := MakeFT_invalid__7orBlank(s0);
EXPORT InValid_hot_list_address_change_indicator(SALT34.StrType s) := InValidFT_invalid__7orBlank(s);
EXPORT InValidMessage_hot_list_address_change_indicator(UNSIGNED1 wh) := InValidMessageFT_invalid__7orBlank(wh);
 
EXPORT Make_hot_list_telephone_change_indicator(SALT34.StrType s0) := MakeFT_invalid__8orBlank(s0);
EXPORT InValid_hot_list_telephone_change_indicator(SALT34.StrType s) := InValidFT_invalid__8orBlank(s);
EXPORT InValidMessage_hot_list_telephone_change_indicator(UNSIGNED1 wh) := InValidMessageFT_invalid__8orBlank(wh);
 
EXPORT Make_hot_list_new_change_date(SALT34.StrType s0) := MakeFT_invalid__year(s0);
EXPORT InValid_hot_list_new_change_date(SALT34.StrType s) := InValidFT_invalid__year(s);
EXPORT InValidMessage_hot_list_new_change_date(UNSIGNED1 wh) := InValidMessageFT_invalid__year(wh);
 
EXPORT Make_hot_list_ownership_change_date(SALT34.StrType s0) := MakeFT_invalid__year(s0);
EXPORT InValid_hot_list_ownership_change_date(SALT34.StrType s) := InValidFT_invalid__year(s);
EXPORT InValidMessage_hot_list_ownership_change_date(UNSIGNED1 wh) := InValidMessageFT_invalid__year(wh);
 
EXPORT Make_hot_list_ceo_change_date(SALT34.StrType s0) := MakeFT_invalid__year(s0);
EXPORT InValid_hot_list_ceo_change_date(SALT34.StrType s) := InValidFT_invalid__year(s);
EXPORT InValidMessage_hot_list_ceo_change_date(UNSIGNED1 wh) := InValidMessageFT_invalid__year(wh);
 
EXPORT Make_hot_list_company_name_chg_date(SALT34.StrType s0) := MakeFT_invalid__year(s0);
EXPORT InValid_hot_list_company_name_chg_date(SALT34.StrType s) := InValidFT_invalid__year(s);
EXPORT InValidMessage_hot_list_company_name_chg_date(UNSIGNED1 wh) := InValidMessageFT_invalid__year(wh);
 
EXPORT Make_hot_list_address_change_date(SALT34.StrType s0) := MakeFT_invalid__year(s0);
EXPORT InValid_hot_list_address_change_date(SALT34.StrType s) := InValidFT_invalid__year(s);
EXPORT InValidMessage_hot_list_address_change_date(UNSIGNED1 wh) := InValidMessageFT_invalid__year(wh);
 
EXPORT Make_hot_list_telephone_change_date(SALT34.StrType s0) := MakeFT_invalid__year(s0);
EXPORT InValid_hot_list_telephone_change_date(SALT34.StrType s) := InValidFT_invalid__year(s);
EXPORT InValidMessage_hot_list_telephone_change_date(UNSIGNED1 wh) := InValidMessageFT_invalid__year(wh);
 
EXPORT Make_report_date(SALT34.StrType s0) := MakeFT_invalid__report_date(s0);
EXPORT InValid_report_date(SALT34.StrType s) := InValidFT_invalid__report_date(s);
EXPORT InValidMessage_report_date(UNSIGNED1 wh) := InValidMessageFT_invalid__report_date(wh);
 
EXPORT Make_delete_record_indicator(SALT34.StrType s0) := MakeFT_invalid__delete_indicator(s0);
EXPORT InValid_delete_record_indicator(SALT34.StrType s) := InValidFT_invalid__delete_indicator(s);
EXPORT InValidMessage_delete_record_indicator(UNSIGNED1 wh) := InValidMessageFT_invalid__delete_indicator(wh);
 
// This macro will compute and count field level differences based upon a pivot expression
export MAC_CountDifferencesByPivot(in_left,in_right,pivot_exp,bad_pivots,out_counts) := MACRO
  IMPORT SALT34,Scrubs_DNB_DMI;
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
    BOOLEAN Diff_duns_number;
    BOOLEAN Diff_business_name;
    BOOLEAN Diff_street;
    BOOLEAN Diff_city;
    BOOLEAN Diff_state;
    BOOLEAN Diff_zip_code;
    BOOLEAN Diff_mail_address;
    BOOLEAN Diff_mail_city;
    BOOLEAN Diff_mail_state;
    BOOLEAN Diff_mail_zip_code;
    BOOLEAN Diff_telephone_number;
    BOOLEAN Diff_county_name;
    BOOLEAN Diff_msa_code;
    BOOLEAN Diff_sic1;
    BOOLEAN Diff_sic1a;
    BOOLEAN Diff_sic1b;
    BOOLEAN Diff_sic1c;
    BOOLEAN Diff_sic1d;
    BOOLEAN Diff_sic2;
    BOOLEAN Diff_sic2a;
    BOOLEAN Diff_sic2b;
    BOOLEAN Diff_sic2c;
    BOOLEAN Diff_sic2d;
    BOOLEAN Diff_sic3;
    BOOLEAN Diff_sic3a;
    BOOLEAN Diff_sic3b;
    BOOLEAN Diff_sic3c;
    BOOLEAN Diff_sic3d;
    BOOLEAN Diff_sic4;
    BOOLEAN Diff_sic4a;
    BOOLEAN Diff_sic4b;
    BOOLEAN Diff_sic4c;
    BOOLEAN Diff_sic4d;
    BOOLEAN Diff_sic5;
    BOOLEAN Diff_sic5a;
    BOOLEAN Diff_sic5b;
    BOOLEAN Diff_sic5c;
    BOOLEAN Diff_sic5d;
    BOOLEAN Diff_sic6;
    BOOLEAN Diff_sic6a;
    BOOLEAN Diff_sic6b;
    BOOLEAN Diff_sic6c;
    BOOLEAN Diff_sic6d;
    BOOLEAN Diff_industry_group;
    BOOLEAN Diff_year_started;
    BOOLEAN Diff_date_of_incorporation;
    BOOLEAN Diff_state_of_incorporation_abbr;
    BOOLEAN Diff_annual_sales_code;
    BOOLEAN Diff_employees_here_code;
    BOOLEAN Diff_annual_sales_revision_date;
    BOOLEAN Diff_square_footage;
    BOOLEAN Diff_sals_territory;
    BOOLEAN Diff_owns_rents;
    BOOLEAN Diff_number_of_accounts;
    BOOLEAN Diff_small_business_indicator;
    BOOLEAN Diff_minority_owned;
    BOOLEAN Diff_cottage_indicator;
    BOOLEAN Diff_foreign_owned;
    BOOLEAN Diff_manufacturing_here_indicator;
    BOOLEAN Diff_public_indicator;
    BOOLEAN Diff_importer_exporter_indicator;
    BOOLEAN Diff_structure_type;
    BOOLEAN Diff_type_of_establishment;
    BOOLEAN Diff_parent_duns_number;
    BOOLEAN Diff_ultimate_duns_number;
    BOOLEAN Diff_headquarters_duns_number;
    BOOLEAN Diff_dias_code;
    BOOLEAN Diff_hierarchy_code;
    BOOLEAN Diff_ultimate_indicator;
    BOOLEAN Diff_hot_list_new_indicator;
    BOOLEAN Diff_hot_list_ownership_change_indicator;
    BOOLEAN Diff_hot_list_ceo_change_indicator;
    BOOLEAN Diff_hot_list_company_name_change_ind;
    BOOLEAN Diff_hot_list_address_change_indicator;
    BOOLEAN Diff_hot_list_telephone_change_indicator;
    BOOLEAN Diff_hot_list_new_change_date;
    BOOLEAN Diff_hot_list_ownership_change_date;
    BOOLEAN Diff_hot_list_ceo_change_date;
    BOOLEAN Diff_hot_list_company_name_chg_date;
    BOOLEAN Diff_hot_list_address_change_date;
    BOOLEAN Diff_hot_list_telephone_change_date;
    BOOLEAN Diff_report_date;
    BOOLEAN Diff_delete_record_indicator;
    UNSIGNED Num_Diffs;
    SALT34.StrType Val {MAXLENGTH(1024)};
  END;
#uniquename(fd)
  %dl% %fd%(in_left le,in_right ri) := TRANSFORM
    SELF.Diff_duns_number := le.duns_number <> ri.duns_number;
    SELF.Diff_business_name := le.business_name <> ri.business_name;
    SELF.Diff_street := le.street <> ri.street;
    SELF.Diff_city := le.city <> ri.city;
    SELF.Diff_state := le.state <> ri.state;
    SELF.Diff_zip_code := le.zip_code <> ri.zip_code;
    SELF.Diff_mail_address := le.mail_address <> ri.mail_address;
    SELF.Diff_mail_city := le.mail_city <> ri.mail_city;
    SELF.Diff_mail_state := le.mail_state <> ri.mail_state;
    SELF.Diff_mail_zip_code := le.mail_zip_code <> ri.mail_zip_code;
    SELF.Diff_telephone_number := le.telephone_number <> ri.telephone_number;
    SELF.Diff_county_name := le.county_name <> ri.county_name;
    SELF.Diff_msa_code := le.msa_code <> ri.msa_code;
    SELF.Diff_sic1 := le.sic1 <> ri.sic1;
    SELF.Diff_sic1a := le.sic1a <> ri.sic1a;
    SELF.Diff_sic1b := le.sic1b <> ri.sic1b;
    SELF.Diff_sic1c := le.sic1c <> ri.sic1c;
    SELF.Diff_sic1d := le.sic1d <> ri.sic1d;
    SELF.Diff_sic2 := le.sic2 <> ri.sic2;
    SELF.Diff_sic2a := le.sic2a <> ri.sic2a;
    SELF.Diff_sic2b := le.sic2b <> ri.sic2b;
    SELF.Diff_sic2c := le.sic2c <> ri.sic2c;
    SELF.Diff_sic2d := le.sic2d <> ri.sic2d;
    SELF.Diff_sic3 := le.sic3 <> ri.sic3;
    SELF.Diff_sic3a := le.sic3a <> ri.sic3a;
    SELF.Diff_sic3b := le.sic3b <> ri.sic3b;
    SELF.Diff_sic3c := le.sic3c <> ri.sic3c;
    SELF.Diff_sic3d := le.sic3d <> ri.sic3d;
    SELF.Diff_sic4 := le.sic4 <> ri.sic4;
    SELF.Diff_sic4a := le.sic4a <> ri.sic4a;
    SELF.Diff_sic4b := le.sic4b <> ri.sic4b;
    SELF.Diff_sic4c := le.sic4c <> ri.sic4c;
    SELF.Diff_sic4d := le.sic4d <> ri.sic4d;
    SELF.Diff_sic5 := le.sic5 <> ri.sic5;
    SELF.Diff_sic5a := le.sic5a <> ri.sic5a;
    SELF.Diff_sic5b := le.sic5b <> ri.sic5b;
    SELF.Diff_sic5c := le.sic5c <> ri.sic5c;
    SELF.Diff_sic5d := le.sic5d <> ri.sic5d;
    SELF.Diff_sic6 := le.sic6 <> ri.sic6;
    SELF.Diff_sic6a := le.sic6a <> ri.sic6a;
    SELF.Diff_sic6b := le.sic6b <> ri.sic6b;
    SELF.Diff_sic6c := le.sic6c <> ri.sic6c;
    SELF.Diff_sic6d := le.sic6d <> ri.sic6d;
    SELF.Diff_industry_group := le.industry_group <> ri.industry_group;
    SELF.Diff_year_started := le.year_started <> ri.year_started;
    SELF.Diff_date_of_incorporation := le.date_of_incorporation <> ri.date_of_incorporation;
    SELF.Diff_state_of_incorporation_abbr := le.state_of_incorporation_abbr <> ri.state_of_incorporation_abbr;
    SELF.Diff_annual_sales_code := le.annual_sales_code <> ri.annual_sales_code;
    SELF.Diff_employees_here_code := le.employees_here_code <> ri.employees_here_code;
    SELF.Diff_annual_sales_revision_date := le.annual_sales_revision_date <> ri.annual_sales_revision_date;
    SELF.Diff_square_footage := le.square_footage <> ri.square_footage;
    SELF.Diff_sals_territory := le.sals_territory <> ri.sals_territory;
    SELF.Diff_owns_rents := le.owns_rents <> ri.owns_rents;
    SELF.Diff_number_of_accounts := le.number_of_accounts <> ri.number_of_accounts;
    SELF.Diff_small_business_indicator := le.small_business_indicator <> ri.small_business_indicator;
    SELF.Diff_minority_owned := le.minority_owned <> ri.minority_owned;
    SELF.Diff_cottage_indicator := le.cottage_indicator <> ri.cottage_indicator;
    SELF.Diff_foreign_owned := le.foreign_owned <> ri.foreign_owned;
    SELF.Diff_manufacturing_here_indicator := le.manufacturing_here_indicator <> ri.manufacturing_here_indicator;
    SELF.Diff_public_indicator := le.public_indicator <> ri.public_indicator;
    SELF.Diff_importer_exporter_indicator := le.importer_exporter_indicator <> ri.importer_exporter_indicator;
    SELF.Diff_structure_type := le.structure_type <> ri.structure_type;
    SELF.Diff_type_of_establishment := le.type_of_establishment <> ri.type_of_establishment;
    SELF.Diff_parent_duns_number := le.parent_duns_number <> ri.parent_duns_number;
    SELF.Diff_ultimate_duns_number := le.ultimate_duns_number <> ri.ultimate_duns_number;
    SELF.Diff_headquarters_duns_number := le.headquarters_duns_number <> ri.headquarters_duns_number;
    SELF.Diff_dias_code := le.dias_code <> ri.dias_code;
    SELF.Diff_hierarchy_code := le.hierarchy_code <> ri.hierarchy_code;
    SELF.Diff_ultimate_indicator := le.ultimate_indicator <> ri.ultimate_indicator;
    SELF.Diff_hot_list_new_indicator := le.hot_list_new_indicator <> ri.hot_list_new_indicator;
    SELF.Diff_hot_list_ownership_change_indicator := le.hot_list_ownership_change_indicator <> ri.hot_list_ownership_change_indicator;
    SELF.Diff_hot_list_ceo_change_indicator := le.hot_list_ceo_change_indicator <> ri.hot_list_ceo_change_indicator;
    SELF.Diff_hot_list_company_name_change_ind := le.hot_list_company_name_change_ind <> ri.hot_list_company_name_change_ind;
    SELF.Diff_hot_list_address_change_indicator := le.hot_list_address_change_indicator <> ri.hot_list_address_change_indicator;
    SELF.Diff_hot_list_telephone_change_indicator := le.hot_list_telephone_change_indicator <> ri.hot_list_telephone_change_indicator;
    SELF.Diff_hot_list_new_change_date := le.hot_list_new_change_date <> ri.hot_list_new_change_date;
    SELF.Diff_hot_list_ownership_change_date := le.hot_list_ownership_change_date <> ri.hot_list_ownership_change_date;
    SELF.Diff_hot_list_ceo_change_date := le.hot_list_ceo_change_date <> ri.hot_list_ceo_change_date;
    SELF.Diff_hot_list_company_name_chg_date := le.hot_list_company_name_chg_date <> ri.hot_list_company_name_chg_date;
    SELF.Diff_hot_list_address_change_date := le.hot_list_address_change_date <> ri.hot_list_address_change_date;
    SELF.Diff_hot_list_telephone_change_date := le.hot_list_telephone_change_date <> ri.hot_list_telephone_change_date;
    SELF.Diff_report_date := le.report_date <> ri.report_date;
    SELF.Diff_delete_record_indicator := le.delete_record_indicator <> ri.delete_record_indicator;
    SELF.Val := (SALT34.StrType)evaluate(le,pivot_exp);
    SELF.Num_Diffs := 0+ IF( SELF.Diff_duns_number,1,0)+ IF( SELF.Diff_business_name,1,0)+ IF( SELF.Diff_street,1,0)+ IF( SELF.Diff_city,1,0)+ IF( SELF.Diff_state,1,0)+ IF( SELF.Diff_zip_code,1,0)+ IF( SELF.Diff_mail_address,1,0)+ IF( SELF.Diff_mail_city,1,0)+ IF( SELF.Diff_mail_state,1,0)+ IF( SELF.Diff_mail_zip_code,1,0)+ IF( SELF.Diff_telephone_number,1,0)+ IF( SELF.Diff_county_name,1,0)+ IF( SELF.Diff_msa_code,1,0)+ IF( SELF.Diff_sic1,1,0)+ IF( SELF.Diff_sic1a,1,0)+ IF( SELF.Diff_sic1b,1,0)+ IF( SELF.Diff_sic1c,1,0)+ IF( SELF.Diff_sic1d,1,0)+ IF( SELF.Diff_sic2,1,0)+ IF( SELF.Diff_sic2a,1,0)+ IF( SELF.Diff_sic2b,1,0)+ IF( SELF.Diff_sic2c,1,0)+ IF( SELF.Diff_sic2d,1,0)+ IF( SELF.Diff_sic3,1,0)+ IF( SELF.Diff_sic3a,1,0)+ IF( SELF.Diff_sic3b,1,0)+ IF( SELF.Diff_sic3c,1,0)+ IF( SELF.Diff_sic3d,1,0)+ IF( SELF.Diff_sic4,1,0)+ IF( SELF.Diff_sic4a,1,0)+ IF( SELF.Diff_sic4b,1,0)+ IF( SELF.Diff_sic4c,1,0)+ IF( SELF.Diff_sic4d,1,0)+ IF( SELF.Diff_sic5,1,0)+ IF( SELF.Diff_sic5a,1,0)+ IF( SELF.Diff_sic5b,1,0)+ IF( SELF.Diff_sic5c,1,0)+ IF( SELF.Diff_sic5d,1,0)+ IF( SELF.Diff_sic6,1,0)+ IF( SELF.Diff_sic6a,1,0)+ IF( SELF.Diff_sic6b,1,0)+ IF( SELF.Diff_sic6c,1,0)+ IF( SELF.Diff_sic6d,1,0)+ IF( SELF.Diff_industry_group,1,0)+ IF( SELF.Diff_year_started,1,0)+ IF( SELF.Diff_date_of_incorporation,1,0)+ IF( SELF.Diff_state_of_incorporation_abbr,1,0)+ IF( SELF.Diff_annual_sales_code,1,0)+ IF( SELF.Diff_employees_here_code,1,0)+ IF( SELF.Diff_annual_sales_revision_date,1,0)+ IF( SELF.Diff_square_footage,1,0)+ IF( SELF.Diff_sals_territory,1,0)+ IF( SELF.Diff_owns_rents,1,0)+ IF( SELF.Diff_number_of_accounts,1,0)+ IF( SELF.Diff_small_business_indicator,1,0)+ IF( SELF.Diff_minority_owned,1,0)+ IF( SELF.Diff_cottage_indicator,1,0)+ IF( SELF.Diff_foreign_owned,1,0)+ IF( SELF.Diff_manufacturing_here_indicator,1,0)+ IF( SELF.Diff_public_indicator,1,0)+ IF( SELF.Diff_importer_exporter_indicator,1,0)+ IF( SELF.Diff_structure_type,1,0)+ IF( SELF.Diff_type_of_establishment,1,0)+ IF( SELF.Diff_parent_duns_number,1,0)+ IF( SELF.Diff_ultimate_duns_number,1,0)+ IF( SELF.Diff_headquarters_duns_number,1,0)+ IF( SELF.Diff_dias_code,1,0)+ IF( SELF.Diff_hierarchy_code,1,0)+ IF( SELF.Diff_ultimate_indicator,1,0)+ IF( SELF.Diff_hot_list_new_indicator,1,0)+ IF( SELF.Diff_hot_list_ownership_change_indicator,1,0)+ IF( SELF.Diff_hot_list_ceo_change_indicator,1,0)+ IF( SELF.Diff_hot_list_company_name_change_ind,1,0)+ IF( SELF.Diff_hot_list_address_change_indicator,1,0)+ IF( SELF.Diff_hot_list_telephone_change_indicator,1,0)+ IF( SELF.Diff_hot_list_new_change_date,1,0)+ IF( SELF.Diff_hot_list_ownership_change_date,1,0)+ IF( SELF.Diff_hot_list_ceo_change_date,1,0)+ IF( SELF.Diff_hot_list_company_name_chg_date,1,0)+ IF( SELF.Diff_hot_list_address_change_date,1,0)+ IF( SELF.Diff_hot_list_telephone_change_date,1,0)+ IF( SELF.Diff_report_date,1,0)+ IF( SELF.Diff_delete_record_indicator,1,0);
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
    Count_Diff_duns_number := COUNT(GROUP,%Closest%.Diff_duns_number);
    Count_Diff_business_name := COUNT(GROUP,%Closest%.Diff_business_name);
    Count_Diff_street := COUNT(GROUP,%Closest%.Diff_street);
    Count_Diff_city := COUNT(GROUP,%Closest%.Diff_city);
    Count_Diff_state := COUNT(GROUP,%Closest%.Diff_state);
    Count_Diff_zip_code := COUNT(GROUP,%Closest%.Diff_zip_code);
    Count_Diff_mail_address := COUNT(GROUP,%Closest%.Diff_mail_address);
    Count_Diff_mail_city := COUNT(GROUP,%Closest%.Diff_mail_city);
    Count_Diff_mail_state := COUNT(GROUP,%Closest%.Diff_mail_state);
    Count_Diff_mail_zip_code := COUNT(GROUP,%Closest%.Diff_mail_zip_code);
    Count_Diff_telephone_number := COUNT(GROUP,%Closest%.Diff_telephone_number);
    Count_Diff_county_name := COUNT(GROUP,%Closest%.Diff_county_name);
    Count_Diff_msa_code := COUNT(GROUP,%Closest%.Diff_msa_code);
    Count_Diff_sic1 := COUNT(GROUP,%Closest%.Diff_sic1);
    Count_Diff_sic1a := COUNT(GROUP,%Closest%.Diff_sic1a);
    Count_Diff_sic1b := COUNT(GROUP,%Closest%.Diff_sic1b);
    Count_Diff_sic1c := COUNT(GROUP,%Closest%.Diff_sic1c);
    Count_Diff_sic1d := COUNT(GROUP,%Closest%.Diff_sic1d);
    Count_Diff_sic2 := COUNT(GROUP,%Closest%.Diff_sic2);
    Count_Diff_sic2a := COUNT(GROUP,%Closest%.Diff_sic2a);
    Count_Diff_sic2b := COUNT(GROUP,%Closest%.Diff_sic2b);
    Count_Diff_sic2c := COUNT(GROUP,%Closest%.Diff_sic2c);
    Count_Diff_sic2d := COUNT(GROUP,%Closest%.Diff_sic2d);
    Count_Diff_sic3 := COUNT(GROUP,%Closest%.Diff_sic3);
    Count_Diff_sic3a := COUNT(GROUP,%Closest%.Diff_sic3a);
    Count_Diff_sic3b := COUNT(GROUP,%Closest%.Diff_sic3b);
    Count_Diff_sic3c := COUNT(GROUP,%Closest%.Diff_sic3c);
    Count_Diff_sic3d := COUNT(GROUP,%Closest%.Diff_sic3d);
    Count_Diff_sic4 := COUNT(GROUP,%Closest%.Diff_sic4);
    Count_Diff_sic4a := COUNT(GROUP,%Closest%.Diff_sic4a);
    Count_Diff_sic4b := COUNT(GROUP,%Closest%.Diff_sic4b);
    Count_Diff_sic4c := COUNT(GROUP,%Closest%.Diff_sic4c);
    Count_Diff_sic4d := COUNT(GROUP,%Closest%.Diff_sic4d);
    Count_Diff_sic5 := COUNT(GROUP,%Closest%.Diff_sic5);
    Count_Diff_sic5a := COUNT(GROUP,%Closest%.Diff_sic5a);
    Count_Diff_sic5b := COUNT(GROUP,%Closest%.Diff_sic5b);
    Count_Diff_sic5c := COUNT(GROUP,%Closest%.Diff_sic5c);
    Count_Diff_sic5d := COUNT(GROUP,%Closest%.Diff_sic5d);
    Count_Diff_sic6 := COUNT(GROUP,%Closest%.Diff_sic6);
    Count_Diff_sic6a := COUNT(GROUP,%Closest%.Diff_sic6a);
    Count_Diff_sic6b := COUNT(GROUP,%Closest%.Diff_sic6b);
    Count_Diff_sic6c := COUNT(GROUP,%Closest%.Diff_sic6c);
    Count_Diff_sic6d := COUNT(GROUP,%Closest%.Diff_sic6d);
    Count_Diff_industry_group := COUNT(GROUP,%Closest%.Diff_industry_group);
    Count_Diff_year_started := COUNT(GROUP,%Closest%.Diff_year_started);
    Count_Diff_date_of_incorporation := COUNT(GROUP,%Closest%.Diff_date_of_incorporation);
    Count_Diff_state_of_incorporation_abbr := COUNT(GROUP,%Closest%.Diff_state_of_incorporation_abbr);
    Count_Diff_annual_sales_code := COUNT(GROUP,%Closest%.Diff_annual_sales_code);
    Count_Diff_employees_here_code := COUNT(GROUP,%Closest%.Diff_employees_here_code);
    Count_Diff_annual_sales_revision_date := COUNT(GROUP,%Closest%.Diff_annual_sales_revision_date);
    Count_Diff_square_footage := COUNT(GROUP,%Closest%.Diff_square_footage);
    Count_Diff_sals_territory := COUNT(GROUP,%Closest%.Diff_sals_territory);
    Count_Diff_owns_rents := COUNT(GROUP,%Closest%.Diff_owns_rents);
    Count_Diff_number_of_accounts := COUNT(GROUP,%Closest%.Diff_number_of_accounts);
    Count_Diff_small_business_indicator := COUNT(GROUP,%Closest%.Diff_small_business_indicator);
    Count_Diff_minority_owned := COUNT(GROUP,%Closest%.Diff_minority_owned);
    Count_Diff_cottage_indicator := COUNT(GROUP,%Closest%.Diff_cottage_indicator);
    Count_Diff_foreign_owned := COUNT(GROUP,%Closest%.Diff_foreign_owned);
    Count_Diff_manufacturing_here_indicator := COUNT(GROUP,%Closest%.Diff_manufacturing_here_indicator);
    Count_Diff_public_indicator := COUNT(GROUP,%Closest%.Diff_public_indicator);
    Count_Diff_importer_exporter_indicator := COUNT(GROUP,%Closest%.Diff_importer_exporter_indicator);
    Count_Diff_structure_type := COUNT(GROUP,%Closest%.Diff_structure_type);
    Count_Diff_type_of_establishment := COUNT(GROUP,%Closest%.Diff_type_of_establishment);
    Count_Diff_parent_duns_number := COUNT(GROUP,%Closest%.Diff_parent_duns_number);
    Count_Diff_ultimate_duns_number := COUNT(GROUP,%Closest%.Diff_ultimate_duns_number);
    Count_Diff_headquarters_duns_number := COUNT(GROUP,%Closest%.Diff_headquarters_duns_number);
    Count_Diff_dias_code := COUNT(GROUP,%Closest%.Diff_dias_code);
    Count_Diff_hierarchy_code := COUNT(GROUP,%Closest%.Diff_hierarchy_code);
    Count_Diff_ultimate_indicator := COUNT(GROUP,%Closest%.Diff_ultimate_indicator);
    Count_Diff_hot_list_new_indicator := COUNT(GROUP,%Closest%.Diff_hot_list_new_indicator);
    Count_Diff_hot_list_ownership_change_indicator := COUNT(GROUP,%Closest%.Diff_hot_list_ownership_change_indicator);
    Count_Diff_hot_list_ceo_change_indicator := COUNT(GROUP,%Closest%.Diff_hot_list_ceo_change_indicator);
    Count_Diff_hot_list_company_name_change_ind := COUNT(GROUP,%Closest%.Diff_hot_list_company_name_change_ind);
    Count_Diff_hot_list_address_change_indicator := COUNT(GROUP,%Closest%.Diff_hot_list_address_change_indicator);
    Count_Diff_hot_list_telephone_change_indicator := COUNT(GROUP,%Closest%.Diff_hot_list_telephone_change_indicator);
    Count_Diff_hot_list_new_change_date := COUNT(GROUP,%Closest%.Diff_hot_list_new_change_date);
    Count_Diff_hot_list_ownership_change_date := COUNT(GROUP,%Closest%.Diff_hot_list_ownership_change_date);
    Count_Diff_hot_list_ceo_change_date := COUNT(GROUP,%Closest%.Diff_hot_list_ceo_change_date);
    Count_Diff_hot_list_company_name_chg_date := COUNT(GROUP,%Closest%.Diff_hot_list_company_name_chg_date);
    Count_Diff_hot_list_address_change_date := COUNT(GROUP,%Closest%.Diff_hot_list_address_change_date);
    Count_Diff_hot_list_telephone_change_date := COUNT(GROUP,%Closest%.Diff_hot_list_telephone_change_date);
    Count_Diff_report_date := COUNT(GROUP,%Closest%.Diff_report_date);
    Count_Diff_delete_record_indicator := COUNT(GROUP,%Closest%.Diff_delete_record_indicator);
  END;
  out_counts := table(%Closest%,%AggRec%,true);
ENDMACRO;
END;
