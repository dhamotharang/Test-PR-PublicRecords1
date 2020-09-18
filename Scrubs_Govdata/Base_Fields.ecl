IMPORT SALT311;
IMPORT Scrubs,Scrubs_Govdata; // Import modules for FieldTypes attribute definitions
EXPORT Base_Fields := MODULE
 
EXPORT NumFields := 47;
 
// Processing for each FieldType
EXPORT SALT311.StrType FieldTypeName(UNSIGNED2 i) := CHOOSE(i,'Invalid_Date','Invalid_numeric','Invalid_mandatory_alpha','Invalid_alpha','Invalid_St','Invalid_zip','Invalid_numeric_optional','Invalid_company_flag');
EXPORT FieldTypeNum(SALT311.StrType fn) := CASE(fn,'Invalid_Date' => 1,'Invalid_numeric' => 2,'Invalid_mandatory_alpha' => 3,'Invalid_alpha' => 4,'Invalid_St' => 5,'Invalid_zip' => 6,'Invalid_numeric_optional' => 7,'Invalid_company_flag' => 8,0);
 
EXPORT MakeFT_Invalid_Date(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_Invalid_Date(SALT311.StrType s) := WHICH(~Scrubs.functions.fn_valid_date(s)>0);
EXPORT InValidMessageFT_Invalid_Date(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('Scrubs.functions.fn_valid_date'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_Invalid_numeric(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_Invalid_numeric(SALT311.StrType s) := WHICH(~Scrubs.functions.fn_numeric(s,10)>0);
EXPORT InValidMessageFT_Invalid_numeric(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('Scrubs.functions.fn_numeric'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_Invalid_mandatory_alpha(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_Invalid_mandatory_alpha(SALT311.StrType s) := WHICH(~Scrubs.functions.fn_ASCII_printable(s)>0,~(LENGTH(TRIM(s)) >= 1));
EXPORT InValidMessageFT_Invalid_mandatory_alpha(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('Scrubs.functions.fn_ASCII_printable'),SALT311.HygieneErrors.NotLength('1..'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_Invalid_alpha(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_Invalid_alpha(SALT311.StrType s) := WHICH(~Scrubs.functions.fn_ASCII_printable(s)>0);
EXPORT InValidMessageFT_Invalid_alpha(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('Scrubs.functions.fn_ASCII_printable'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_Invalid_St(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_Invalid_St(SALT311.StrType s) := WHICH(~Scrubs.functions.fn_verify_state(s)>0);
EXPORT InValidMessageFT_Invalid_St(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('Scrubs.functions.fn_verify_state'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_Invalid_zip(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_Invalid_zip(SALT311.StrType s) := WHICH(~Scrubs_Govdata.Functions.fn_verify_zip59(s)>0);
EXPORT InValidMessageFT_Invalid_zip(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('Scrubs_Govdata.Functions.fn_verify_zip59'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_Invalid_numeric_optional(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_Invalid_numeric_optional(SALT311.StrType s) := WHICH(~Scrubs.functions.fn_numeric_optional(s,9)>0);
EXPORT InValidMessageFT_Invalid_numeric_optional(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('Scrubs.functions.fn_numeric_optional'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_Invalid_company_flag(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_Invalid_company_flag(SALT311.StrType s) := WHICH(((SALT311.StrType) s) NOT IN ['0','1']);
EXPORT InValidMessageFT_Invalid_company_flag(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInEnum('0|1'),SALT311.HygieneErrors.Good);
 
EXPORT SALT311.StrType FieldName(UNSIGNED2 i) := CHOOSE(i,'dt_first_reported','dt_last_reported','cik_number','company_name','reporting_file_number','address1','address2','city','state_code','zip_code','irs_taxpayer_id','prim_range','predir','prim_name','addr_suffix','postdir','unit_desig','sec_range','p_city_name','v_city_name','st','zip','zip4','cart','cr_sort_sz','lot','lot_order','dpbc','chk_digit','record_type','ace_fips_st','county','geo_lat','geo_long','msa','geo_blk','geo_match','err_stat','title','fname','mname','lname','name_suffix','name_score','is_company_flag','cname','lf');
EXPORT SALT311.StrType FlatName(UNSIGNED2 i) := CHOOSE(i,'dt_first_reported','dt_last_reported','cik_number','company_name','reporting_file_number','address1','address2','city','state_code','zip_code','irs_taxpayer_id','prim_range','predir','prim_name','addr_suffix','postdir','unit_desig','sec_range','p_city_name','v_city_name','st','zip','zip4','cart','cr_sort_sz','lot','lot_order','dpbc','chk_digit','record_type','ace_fips_st','county','geo_lat','geo_long','msa','geo_blk','geo_match','err_stat','title','fname','mname','lname','name_suffix','name_score','is_company_flag','cname','lf');
EXPORT FieldNum(SALT311.StrType fn) := CASE(fn,'dt_first_reported' => 0,'dt_last_reported' => 1,'cik_number' => 2,'company_name' => 3,'reporting_file_number' => 4,'address1' => 5,'address2' => 6,'city' => 7,'state_code' => 8,'zip_code' => 9,'irs_taxpayer_id' => 10,'prim_range' => 11,'predir' => 12,'prim_name' => 13,'addr_suffix' => 14,'postdir' => 15,'unit_desig' => 16,'sec_range' => 17,'p_city_name' => 18,'v_city_name' => 19,'st' => 20,'zip' => 21,'zip4' => 22,'cart' => 23,'cr_sort_sz' => 24,'lot' => 25,'lot_order' => 26,'dpbc' => 27,'chk_digit' => 28,'record_type' => 29,'ace_fips_st' => 30,'county' => 31,'geo_lat' => 32,'geo_long' => 33,'msa' => 34,'geo_blk' => 35,'geo_match' => 36,'err_stat' => 37,'title' => 38,'fname' => 39,'mname' => 40,'lname' => 41,'name_suffix' => 42,'name_score' => 43,'is_company_flag' => 44,'cname' => 45,'lf' => 46,0);
EXPORT SET OF SALT311.StrType FieldRules(UNSIGNED2 i) := CHOOSE(i,['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM','LENGTHS'],[],['CUSTOM','LENGTHS'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],['ENUM'],[],[],[]);
EXPORT BOOLEAN InBaseLayout(UNSIGNED2 i) := CHOOSE(i,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,FALSE);
 
//Individual field level validation
 
EXPORT Make_dt_first_reported(SALT311.StrType s0) := MakeFT_Invalid_Date(s0);
EXPORT InValid_dt_first_reported(SALT311.StrType s) := InValidFT_Invalid_Date(s);
EXPORT InValidMessage_dt_first_reported(UNSIGNED1 wh) := InValidMessageFT_Invalid_Date(wh);
 
EXPORT Make_dt_last_reported(SALT311.StrType s0) := MakeFT_Invalid_Date(s0);
EXPORT InValid_dt_last_reported(SALT311.StrType s) := InValidFT_Invalid_Date(s);
EXPORT InValidMessage_dt_last_reported(UNSIGNED1 wh) := InValidMessageFT_Invalid_Date(wh);
 
EXPORT Make_cik_number(SALT311.StrType s0) := MakeFT_Invalid_numeric(s0);
EXPORT InValid_cik_number(SALT311.StrType s) := InValidFT_Invalid_numeric(s);
EXPORT InValidMessage_cik_number(UNSIGNED1 wh) := InValidMessageFT_Invalid_numeric(wh);
 
EXPORT Make_company_name(SALT311.StrType s0) := MakeFT_Invalid_mandatory_alpha(s0);
EXPORT InValid_company_name(SALT311.StrType s) := InValidFT_Invalid_mandatory_alpha(s);
EXPORT InValidMessage_company_name(UNSIGNED1 wh) := InValidMessageFT_Invalid_mandatory_alpha(wh);
 
EXPORT Make_reporting_file_number(SALT311.StrType s0) := s0;
EXPORT InValid_reporting_file_number(SALT311.StrType s) := 0;
EXPORT InValidMessage_reporting_file_number(UNSIGNED1 wh) := '';
 
EXPORT Make_address1(SALT311.StrType s0) := MakeFT_Invalid_mandatory_alpha(s0);
EXPORT InValid_address1(SALT311.StrType s) := InValidFT_Invalid_mandatory_alpha(s);
EXPORT InValidMessage_address1(UNSIGNED1 wh) := InValidMessageFT_Invalid_mandatory_alpha(wh);
 
EXPORT Make_address2(SALT311.StrType s0) := MakeFT_Invalid_alpha(s0);
EXPORT InValid_address2(SALT311.StrType s) := InValidFT_Invalid_alpha(s);
EXPORT InValidMessage_address2(UNSIGNED1 wh) := InValidMessageFT_Invalid_alpha(wh);
 
EXPORT Make_city(SALT311.StrType s0) := MakeFT_Invalid_alpha(s0);
EXPORT InValid_city(SALT311.StrType s) := InValidFT_Invalid_alpha(s);
EXPORT InValidMessage_city(UNSIGNED1 wh) := InValidMessageFT_Invalid_alpha(wh);
 
EXPORT Make_state_code(SALT311.StrType s0) := MakeFT_Invalid_St(s0);
EXPORT InValid_state_code(SALT311.StrType s) := InValidFT_Invalid_St(s);
EXPORT InValidMessage_state_code(UNSIGNED1 wh) := InValidMessageFT_Invalid_St(wh);
 
EXPORT Make_zip_code(SALT311.StrType s0) := MakeFT_Invalid_zip(s0);
EXPORT InValid_zip_code(SALT311.StrType s) := InValidFT_Invalid_zip(s);
EXPORT InValidMessage_zip_code(UNSIGNED1 wh) := InValidMessageFT_Invalid_zip(wh);
 
EXPORT Make_irs_taxpayer_id(SALT311.StrType s0) := MakeFT_Invalid_numeric_optional(s0);
EXPORT InValid_irs_taxpayer_id(SALT311.StrType s) := InValidFT_Invalid_numeric_optional(s);
EXPORT InValidMessage_irs_taxpayer_id(UNSIGNED1 wh) := InValidMessageFT_Invalid_numeric_optional(wh);
 
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
 
EXPORT Make_dpbc(SALT311.StrType s0) := s0;
EXPORT InValid_dpbc(SALT311.StrType s) := 0;
EXPORT InValidMessage_dpbc(UNSIGNED1 wh) := '';
 
EXPORT Make_chk_digit(SALT311.StrType s0) := s0;
EXPORT InValid_chk_digit(SALT311.StrType s) := 0;
EXPORT InValidMessage_chk_digit(UNSIGNED1 wh) := '';
 
EXPORT Make_record_type(SALT311.StrType s0) := s0;
EXPORT InValid_record_type(SALT311.StrType s) := 0;
EXPORT InValidMessage_record_type(UNSIGNED1 wh) := '';
 
EXPORT Make_ace_fips_st(SALT311.StrType s0) := s0;
EXPORT InValid_ace_fips_st(SALT311.StrType s) := 0;
EXPORT InValidMessage_ace_fips_st(UNSIGNED1 wh) := '';
 
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
 
EXPORT Make_title(SALT311.StrType s0) := s0;
EXPORT InValid_title(SALT311.StrType s) := 0;
EXPORT InValidMessage_title(UNSIGNED1 wh) := '';
 
EXPORT Make_fname(SALT311.StrType s0) := s0;
EXPORT InValid_fname(SALT311.StrType s) := 0;
EXPORT InValidMessage_fname(UNSIGNED1 wh) := '';
 
EXPORT Make_mname(SALT311.StrType s0) := s0;
EXPORT InValid_mname(SALT311.StrType s) := 0;
EXPORT InValidMessage_mname(UNSIGNED1 wh) := '';
 
EXPORT Make_lname(SALT311.StrType s0) := s0;
EXPORT InValid_lname(SALT311.StrType s) := 0;
EXPORT InValidMessage_lname(UNSIGNED1 wh) := '';
 
EXPORT Make_name_suffix(SALT311.StrType s0) := s0;
EXPORT InValid_name_suffix(SALT311.StrType s) := 0;
EXPORT InValidMessage_name_suffix(UNSIGNED1 wh) := '';
 
EXPORT Make_name_score(SALT311.StrType s0) := s0;
EXPORT InValid_name_score(SALT311.StrType s) := 0;
EXPORT InValidMessage_name_score(UNSIGNED1 wh) := '';
 
EXPORT Make_is_company_flag(SALT311.StrType s0) := MakeFT_Invalid_company_flag(s0);
EXPORT InValid_is_company_flag(SALT311.StrType s) := InValidFT_Invalid_company_flag(s);
EXPORT InValidMessage_is_company_flag(UNSIGNED1 wh) := InValidMessageFT_Invalid_company_flag(wh);
 
EXPORT Make_cname(SALT311.StrType s0) := s0;
EXPORT InValid_cname(SALT311.StrType s) := 0;
EXPORT InValidMessage_cname(UNSIGNED1 wh) := '';
 
EXPORT Make_lf(SALT311.StrType s0) := s0;
EXPORT InValid_lf(SALT311.StrType s) := 0;
EXPORT InValidMessage_lf(UNSIGNED1 wh) := '';
 
// This macro will compute and count field level differences based upon a pivot expression
export MAC_CountDifferencesByPivot(in_left,in_right,pivot_exp,bad_pivots,out_counts) := MACRO
  IMPORT SALT311,Scrubs_Govdata;
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
    BOOLEAN Diff_dt_first_reported;
    BOOLEAN Diff_dt_last_reported;
    BOOLEAN Diff_cik_number;
    BOOLEAN Diff_company_name;
    BOOLEAN Diff_reporting_file_number;
    BOOLEAN Diff_address1;
    BOOLEAN Diff_address2;
    BOOLEAN Diff_city;
    BOOLEAN Diff_state_code;
    BOOLEAN Diff_zip_code;
    BOOLEAN Diff_irs_taxpayer_id;
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
    BOOLEAN Diff_dpbc;
    BOOLEAN Diff_chk_digit;
    BOOLEAN Diff_record_type;
    BOOLEAN Diff_ace_fips_st;
    BOOLEAN Diff_county;
    BOOLEAN Diff_geo_lat;
    BOOLEAN Diff_geo_long;
    BOOLEAN Diff_msa;
    BOOLEAN Diff_geo_blk;
    BOOLEAN Diff_geo_match;
    BOOLEAN Diff_err_stat;
    BOOLEAN Diff_title;
    BOOLEAN Diff_fname;
    BOOLEAN Diff_mname;
    BOOLEAN Diff_lname;
    BOOLEAN Diff_name_suffix;
    BOOLEAN Diff_name_score;
    BOOLEAN Diff_is_company_flag;
    BOOLEAN Diff_cname;
    BOOLEAN Diff_lf;
    UNSIGNED Num_Diffs;
    SALT311.StrType Val {MAXLENGTH(1024)};
  END;
#uniquename(fd)
  %dl% %fd%(in_left le,in_right ri) := TRANSFORM
    SELF.Diff_dt_first_reported := le.dt_first_reported <> ri.dt_first_reported;
    SELF.Diff_dt_last_reported := le.dt_last_reported <> ri.dt_last_reported;
    SELF.Diff_cik_number := le.cik_number <> ri.cik_number;
    SELF.Diff_company_name := le.company_name <> ri.company_name;
    SELF.Diff_reporting_file_number := le.reporting_file_number <> ri.reporting_file_number;
    SELF.Diff_address1 := le.address1 <> ri.address1;
    SELF.Diff_address2 := le.address2 <> ri.address2;
    SELF.Diff_city := le.city <> ri.city;
    SELF.Diff_state_code := le.state_code <> ri.state_code;
    SELF.Diff_zip_code := le.zip_code <> ri.zip_code;
    SELF.Diff_irs_taxpayer_id := le.irs_taxpayer_id <> ri.irs_taxpayer_id;
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
    SELF.Diff_dpbc := le.dpbc <> ri.dpbc;
    SELF.Diff_chk_digit := le.chk_digit <> ri.chk_digit;
    SELF.Diff_record_type := le.record_type <> ri.record_type;
    SELF.Diff_ace_fips_st := le.ace_fips_st <> ri.ace_fips_st;
    SELF.Diff_county := le.county <> ri.county;
    SELF.Diff_geo_lat := le.geo_lat <> ri.geo_lat;
    SELF.Diff_geo_long := le.geo_long <> ri.geo_long;
    SELF.Diff_msa := le.msa <> ri.msa;
    SELF.Diff_geo_blk := le.geo_blk <> ri.geo_blk;
    SELF.Diff_geo_match := le.geo_match <> ri.geo_match;
    SELF.Diff_err_stat := le.err_stat <> ri.err_stat;
    SELF.Diff_title := le.title <> ri.title;
    SELF.Diff_fname := le.fname <> ri.fname;
    SELF.Diff_mname := le.mname <> ri.mname;
    SELF.Diff_lname := le.lname <> ri.lname;
    SELF.Diff_name_suffix := le.name_suffix <> ri.name_suffix;
    SELF.Diff_name_score := le.name_score <> ri.name_score;
    SELF.Diff_is_company_flag := le.is_company_flag <> ri.is_company_flag;
    SELF.Diff_cname := le.cname <> ri.cname;
    SELF.Diff_lf := le.lf <> ri.lf;
    SELF.Val := (SALT311.StrType)evaluate(le,pivot_exp);
    SELF.Num_Diffs := 0+ IF( SELF.Diff_dt_first_reported,1,0)+ IF( SELF.Diff_dt_last_reported,1,0)+ IF( SELF.Diff_cik_number,1,0)+ IF( SELF.Diff_company_name,1,0)+ IF( SELF.Diff_reporting_file_number,1,0)+ IF( SELF.Diff_address1,1,0)+ IF( SELF.Diff_address2,1,0)+ IF( SELF.Diff_city,1,0)+ IF( SELF.Diff_state_code,1,0)+ IF( SELF.Diff_zip_code,1,0)+ IF( SELF.Diff_irs_taxpayer_id,1,0)+ IF( SELF.Diff_prim_range,1,0)+ IF( SELF.Diff_predir,1,0)+ IF( SELF.Diff_prim_name,1,0)+ IF( SELF.Diff_addr_suffix,1,0)+ IF( SELF.Diff_postdir,1,0)+ IF( SELF.Diff_unit_desig,1,0)+ IF( SELF.Diff_sec_range,1,0)+ IF( SELF.Diff_p_city_name,1,0)+ IF( SELF.Diff_v_city_name,1,0)+ IF( SELF.Diff_st,1,0)+ IF( SELF.Diff_zip,1,0)+ IF( SELF.Diff_zip4,1,0)+ IF( SELF.Diff_cart,1,0)+ IF( SELF.Diff_cr_sort_sz,1,0)+ IF( SELF.Diff_lot,1,0)+ IF( SELF.Diff_lot_order,1,0)+ IF( SELF.Diff_dpbc,1,0)+ IF( SELF.Diff_chk_digit,1,0)+ IF( SELF.Diff_record_type,1,0)+ IF( SELF.Diff_ace_fips_st,1,0)+ IF( SELF.Diff_county,1,0)+ IF( SELF.Diff_geo_lat,1,0)+ IF( SELF.Diff_geo_long,1,0)+ IF( SELF.Diff_msa,1,0)+ IF( SELF.Diff_geo_blk,1,0)+ IF( SELF.Diff_geo_match,1,0)+ IF( SELF.Diff_err_stat,1,0)+ IF( SELF.Diff_title,1,0)+ IF( SELF.Diff_fname,1,0)+ IF( SELF.Diff_mname,1,0)+ IF( SELF.Diff_lname,1,0)+ IF( SELF.Diff_name_suffix,1,0)+ IF( SELF.Diff_name_score,1,0)+ IF( SELF.Diff_is_company_flag,1,0)+ IF( SELF.Diff_cname,1,0)+ IF( SELF.Diff_lf,1,0);
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
    Count_Diff_dt_first_reported := COUNT(GROUP,%Closest%.Diff_dt_first_reported);
    Count_Diff_dt_last_reported := COUNT(GROUP,%Closest%.Diff_dt_last_reported);
    Count_Diff_cik_number := COUNT(GROUP,%Closest%.Diff_cik_number);
    Count_Diff_company_name := COUNT(GROUP,%Closest%.Diff_company_name);
    Count_Diff_reporting_file_number := COUNT(GROUP,%Closest%.Diff_reporting_file_number);
    Count_Diff_address1 := COUNT(GROUP,%Closest%.Diff_address1);
    Count_Diff_address2 := COUNT(GROUP,%Closest%.Diff_address2);
    Count_Diff_city := COUNT(GROUP,%Closest%.Diff_city);
    Count_Diff_state_code := COUNT(GROUP,%Closest%.Diff_state_code);
    Count_Diff_zip_code := COUNT(GROUP,%Closest%.Diff_zip_code);
    Count_Diff_irs_taxpayer_id := COUNT(GROUP,%Closest%.Diff_irs_taxpayer_id);
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
    Count_Diff_dpbc := COUNT(GROUP,%Closest%.Diff_dpbc);
    Count_Diff_chk_digit := COUNT(GROUP,%Closest%.Diff_chk_digit);
    Count_Diff_record_type := COUNT(GROUP,%Closest%.Diff_record_type);
    Count_Diff_ace_fips_st := COUNT(GROUP,%Closest%.Diff_ace_fips_st);
    Count_Diff_county := COUNT(GROUP,%Closest%.Diff_county);
    Count_Diff_geo_lat := COUNT(GROUP,%Closest%.Diff_geo_lat);
    Count_Diff_geo_long := COUNT(GROUP,%Closest%.Diff_geo_long);
    Count_Diff_msa := COUNT(GROUP,%Closest%.Diff_msa);
    Count_Diff_geo_blk := COUNT(GROUP,%Closest%.Diff_geo_blk);
    Count_Diff_geo_match := COUNT(GROUP,%Closest%.Diff_geo_match);
    Count_Diff_err_stat := COUNT(GROUP,%Closest%.Diff_err_stat);
    Count_Diff_title := COUNT(GROUP,%Closest%.Diff_title);
    Count_Diff_fname := COUNT(GROUP,%Closest%.Diff_fname);
    Count_Diff_mname := COUNT(GROUP,%Closest%.Diff_mname);
    Count_Diff_lname := COUNT(GROUP,%Closest%.Diff_lname);
    Count_Diff_name_suffix := COUNT(GROUP,%Closest%.Diff_name_suffix);
    Count_Diff_name_score := COUNT(GROUP,%Closest%.Diff_name_score);
    Count_Diff_is_company_flag := COUNT(GROUP,%Closest%.Diff_is_company_flag);
    Count_Diff_cname := COUNT(GROUP,%Closest%.Diff_cname);
    Count_Diff_lf := COUNT(GROUP,%Closest%.Diff_lf);
  END;
  out_counts := table(%Closest%,%AggRec%,true);
ENDMACRO;
END;
