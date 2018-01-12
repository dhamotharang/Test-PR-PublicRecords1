IMPORT SALT38;
IMPORT Scrubs; // Import modules for FieldTypes attribute definitions
EXPORT RawFileNonFCRA_Fields := MODULE
 
EXPORT NumFields := 48;
 
// Processing for each FieldType
EXPORT SALT38.StrType FieldTypeName(UNSIGNED2 i) := CHOOSE(i,'Invalid_Number','Invalid_Date','Invalid_Phone','Invalid_Name','Invalid_State');
EXPORT FieldTypeNum(SALT38.StrType fn) := CASE(fn,'Invalid_Number' => 1,'Invalid_Date' => 2,'Invalid_Phone' => 3,'Invalid_Name' => 4,'Invalid_State' => 5,0);
 
EXPORT MakeFT_Invalid_Number(SALT38.StrType s0) := FUNCTION
  s1 := SALT38.stringfilter(s0,'0123456789'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_Invalid_Number(SALT38.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT38.StringFilter(s,'0123456789'))));
EXPORT InValidMessageFT_Invalid_Number(UNSIGNED1 wh) := CHOOSE(wh,SALT38.HygieneErrors.NotInChars('0123456789'),SALT38.HygieneErrors.Good);
 
EXPORT MakeFT_Invalid_Date(SALT38.StrType s0) := FUNCTION
  s1 := SALT38.stringfilter(s0,'0123456789 :-'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_Invalid_Date(SALT38.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT38.StringFilter(s,'0123456789 :-'))));
EXPORT InValidMessageFT_Invalid_Date(UNSIGNED1 wh) := CHOOSE(wh,SALT38.HygieneErrors.NotInChars('0123456789 :-'),SALT38.HygieneErrors.Good);
 
EXPORT MakeFT_Invalid_Phone(SALT38.StrType s0) := FUNCTION
  s1 := SALT38.stringfilter(s0,'0123456789'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_Invalid_Phone(SALT38.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT38.StringFilter(s,'0123456789'))),~(LENGTH(TRIM(s)) = 0 OR LENGTH(TRIM(s)) = 10));
EXPORT InValidMessageFT_Invalid_Phone(UNSIGNED1 wh) := CHOOSE(wh,SALT38.HygieneErrors.NotInChars('0123456789'),SALT38.HygieneErrors.NotLength('0,10'),SALT38.HygieneErrors.Good);
 
EXPORT MakeFT_Invalid_Name(SALT38.StrType s0) := FUNCTION
  s1 := SALT38.stringfilter(s0,'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz-\' '); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_Invalid_Name(SALT38.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT38.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz-\' '))));
EXPORT InValidMessageFT_Invalid_Name(UNSIGNED1 wh) := CHOOSE(wh,SALT38.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz-\' '),SALT38.HygieneErrors.Good);
 
EXPORT MakeFT_Invalid_State(SALT38.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_Invalid_State(SALT38.StrType s) := WHICH(~Scrubs.fn_Valid_StateAbbrev(s)>0);
EXPORT InValidMessageFT_Invalid_State(UNSIGNED1 wh) := CHOOSE(wh,SALT38.HygieneErrors.CustomFail('Scrubs.fn_Valid_StateAbbrev'),SALT38.HygieneErrors.Good);
 
EXPORT SALT38.StrType FieldName(UNSIGNED2 i) := CHOOSE(i,'statement_id','orig_fname','orig_lname','orig_mname','orig_cname','orig_address','orig_city','orig_st','orig_zip','orig_zip4','phone','title','fname','mname','lname','name_suffix','name_score','prim_range','predir','prim_name','addr_suffix','postdir','unit_desig','sec_range','p_city_name','v_city_name','st','zip','zip4','cart','cr_sort_sz','lot','lot_order','dbpc','chk_digit','rec_type','county','geo_lat','geo_long','msa','geo_blk','geo_match','err_stat','date_submitted','date_created','did','consumer_text','override_flag');
EXPORT SALT38.StrType FlatName(UNSIGNED2 i) := CHOOSE(i,'statement_id','orig_fname','orig_lname','orig_mname','orig_cname','orig_address','orig_city','orig_st','orig_zip','orig_zip4','phone','title','fname','mname','lname','name_suffix','name_score','prim_range','predir','prim_name','addr_suffix','postdir','unit_desig','sec_range','p_city_name','v_city_name','st','zip','zip4','cart','cr_sort_sz','lot','lot_order','dbpc','chk_digit','rec_type','county','geo_lat','geo_long','msa','geo_blk','geo_match','err_stat','date_submitted','date_created','did','consumer_text','override_flag');
EXPORT FieldNum(SALT38.StrType fn) := CASE(fn,'statement_id' => 0,'orig_fname' => 1,'orig_lname' => 2,'orig_mname' => 3,'orig_cname' => 4,'orig_address' => 5,'orig_city' => 6,'orig_st' => 7,'orig_zip' => 8,'orig_zip4' => 9,'phone' => 10,'title' => 11,'fname' => 12,'mname' => 13,'lname' => 14,'name_suffix' => 15,'name_score' => 16,'prim_range' => 17,'predir' => 18,'prim_name' => 19,'addr_suffix' => 20,'postdir' => 21,'unit_desig' => 22,'sec_range' => 23,'p_city_name' => 24,'v_city_name' => 25,'st' => 26,'zip' => 27,'zip4' => 28,'cart' => 29,'cr_sort_sz' => 30,'lot' => 31,'lot_order' => 32,'dbpc' => 33,'chk_digit' => 34,'rec_type' => 35,'county' => 36,'geo_lat' => 37,'geo_long' => 38,'msa' => 39,'geo_blk' => 40,'geo_match' => 41,'err_stat' => 42,'date_submitted' => 43,'date_created' => 44,'did' => 45,'consumer_text' => 46,'override_flag' => 47,0);
EXPORT SET OF SALT38.StrType FieldRules(UNSIGNED2 i) := CHOOSE(i,['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],[],[],['CUSTOM'],['ALLOW'],['ALLOW'],['ALLOW','LENGTH'],[],['ALLOW'],['ALLOW'],['ALLOW'],[],[],[],[],[],[],[],[],[],[],[],['CUSTOM'],['ALLOW'],['ALLOW'],[],[],[],[],[],[],[],[],[],[],[],[],[],[],['ALLOW'],['ALLOW'],['ALLOW'],[],['ALLOW'],[]);
EXPORT BOOLEAN InBaseLayout(UNSIGNED2 i) := CHOOSE(i,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,FALSE);
 
//Individual field level validation
 
EXPORT Make_statement_id(SALT38.StrType s0) := MakeFT_Invalid_Number(s0);
EXPORT InValid_statement_id(SALT38.StrType s) := InValidFT_Invalid_Number(s);
EXPORT InValidMessage_statement_id(UNSIGNED1 wh) := InValidMessageFT_Invalid_Number(wh);
 
EXPORT Make_orig_fname(SALT38.StrType s0) := MakeFT_Invalid_Name(s0);
EXPORT InValid_orig_fname(SALT38.StrType s) := InValidFT_Invalid_Name(s);
EXPORT InValidMessage_orig_fname(UNSIGNED1 wh) := InValidMessageFT_Invalid_Name(wh);
 
EXPORT Make_orig_lname(SALT38.StrType s0) := MakeFT_Invalid_Name(s0);
EXPORT InValid_orig_lname(SALT38.StrType s) := InValidFT_Invalid_Name(s);
EXPORT InValidMessage_orig_lname(UNSIGNED1 wh) := InValidMessageFT_Invalid_Name(wh);
 
EXPORT Make_orig_mname(SALT38.StrType s0) := MakeFT_Invalid_Name(s0);
EXPORT InValid_orig_mname(SALT38.StrType s) := InValidFT_Invalid_Name(s);
EXPORT InValidMessage_orig_mname(UNSIGNED1 wh) := InValidMessageFT_Invalid_Name(wh);
 
EXPORT Make_orig_cname(SALT38.StrType s0) := MakeFT_Invalid_Name(s0);
EXPORT InValid_orig_cname(SALT38.StrType s) := InValidFT_Invalid_Name(s);
EXPORT InValidMessage_orig_cname(UNSIGNED1 wh) := InValidMessageFT_Invalid_Name(wh);
 
EXPORT Make_orig_address(SALT38.StrType s0) := s0;
EXPORT InValid_orig_address(SALT38.StrType s) := 0;
EXPORT InValidMessage_orig_address(UNSIGNED1 wh) := '';
 
EXPORT Make_orig_city(SALT38.StrType s0) := s0;
EXPORT InValid_orig_city(SALT38.StrType s) := 0;
EXPORT InValidMessage_orig_city(UNSIGNED1 wh) := '';
 
EXPORT Make_orig_st(SALT38.StrType s0) := MakeFT_Invalid_State(s0);
EXPORT InValid_orig_st(SALT38.StrType s) := InValidFT_Invalid_State(s);
EXPORT InValidMessage_orig_st(UNSIGNED1 wh) := InValidMessageFT_Invalid_State(wh);
 
EXPORT Make_orig_zip(SALT38.StrType s0) := MakeFT_Invalid_Number(s0);
EXPORT InValid_orig_zip(SALT38.StrType s) := InValidFT_Invalid_Number(s);
EXPORT InValidMessage_orig_zip(UNSIGNED1 wh) := InValidMessageFT_Invalid_Number(wh);
 
EXPORT Make_orig_zip4(SALT38.StrType s0) := MakeFT_Invalid_Number(s0);
EXPORT InValid_orig_zip4(SALT38.StrType s) := InValidFT_Invalid_Number(s);
EXPORT InValidMessage_orig_zip4(UNSIGNED1 wh) := InValidMessageFT_Invalid_Number(wh);
 
EXPORT Make_phone(SALT38.StrType s0) := MakeFT_Invalid_Phone(s0);
EXPORT InValid_phone(SALT38.StrType s) := InValidFT_Invalid_Phone(s);
EXPORT InValidMessage_phone(UNSIGNED1 wh) := InValidMessageFT_Invalid_Phone(wh);
 
EXPORT Make_title(SALT38.StrType s0) := s0;
EXPORT InValid_title(SALT38.StrType s) := 0;
EXPORT InValidMessage_title(UNSIGNED1 wh) := '';
 
EXPORT Make_fname(SALT38.StrType s0) := MakeFT_Invalid_Name(s0);
EXPORT InValid_fname(SALT38.StrType s) := InValidFT_Invalid_Name(s);
EXPORT InValidMessage_fname(UNSIGNED1 wh) := InValidMessageFT_Invalid_Name(wh);
 
EXPORT Make_mname(SALT38.StrType s0) := MakeFT_Invalid_Name(s0);
EXPORT InValid_mname(SALT38.StrType s) := InValidFT_Invalid_Name(s);
EXPORT InValidMessage_mname(UNSIGNED1 wh) := InValidMessageFT_Invalid_Name(wh);
 
EXPORT Make_lname(SALT38.StrType s0) := MakeFT_Invalid_Name(s0);
EXPORT InValid_lname(SALT38.StrType s) := InValidFT_Invalid_Name(s);
EXPORT InValidMessage_lname(UNSIGNED1 wh) := InValidMessageFT_Invalid_Name(wh);
 
EXPORT Make_name_suffix(SALT38.StrType s0) := s0;
EXPORT InValid_name_suffix(SALT38.StrType s) := 0;
EXPORT InValidMessage_name_suffix(UNSIGNED1 wh) := '';
 
EXPORT Make_name_score(SALT38.StrType s0) := s0;
EXPORT InValid_name_score(SALT38.StrType s) := 0;
EXPORT InValidMessage_name_score(UNSIGNED1 wh) := '';
 
EXPORT Make_prim_range(SALT38.StrType s0) := s0;
EXPORT InValid_prim_range(SALT38.StrType s) := 0;
EXPORT InValidMessage_prim_range(UNSIGNED1 wh) := '';
 
EXPORT Make_predir(SALT38.StrType s0) := s0;
EXPORT InValid_predir(SALT38.StrType s) := 0;
EXPORT InValidMessage_predir(UNSIGNED1 wh) := '';
 
EXPORT Make_prim_name(SALT38.StrType s0) := s0;
EXPORT InValid_prim_name(SALT38.StrType s) := 0;
EXPORT InValidMessage_prim_name(UNSIGNED1 wh) := '';
 
EXPORT Make_addr_suffix(SALT38.StrType s0) := s0;
EXPORT InValid_addr_suffix(SALT38.StrType s) := 0;
EXPORT InValidMessage_addr_suffix(UNSIGNED1 wh) := '';
 
EXPORT Make_postdir(SALT38.StrType s0) := s0;
EXPORT InValid_postdir(SALT38.StrType s) := 0;
EXPORT InValidMessage_postdir(UNSIGNED1 wh) := '';
 
EXPORT Make_unit_desig(SALT38.StrType s0) := s0;
EXPORT InValid_unit_desig(SALT38.StrType s) := 0;
EXPORT InValidMessage_unit_desig(UNSIGNED1 wh) := '';
 
EXPORT Make_sec_range(SALT38.StrType s0) := s0;
EXPORT InValid_sec_range(SALT38.StrType s) := 0;
EXPORT InValidMessage_sec_range(UNSIGNED1 wh) := '';
 
EXPORT Make_p_city_name(SALT38.StrType s0) := s0;
EXPORT InValid_p_city_name(SALT38.StrType s) := 0;
EXPORT InValidMessage_p_city_name(UNSIGNED1 wh) := '';
 
EXPORT Make_v_city_name(SALT38.StrType s0) := s0;
EXPORT InValid_v_city_name(SALT38.StrType s) := 0;
EXPORT InValidMessage_v_city_name(UNSIGNED1 wh) := '';
 
EXPORT Make_st(SALT38.StrType s0) := MakeFT_Invalid_State(s0);
EXPORT InValid_st(SALT38.StrType s) := InValidFT_Invalid_State(s);
EXPORT InValidMessage_st(UNSIGNED1 wh) := InValidMessageFT_Invalid_State(wh);
 
EXPORT Make_zip(SALT38.StrType s0) := MakeFT_Invalid_Number(s0);
EXPORT InValid_zip(SALT38.StrType s) := InValidFT_Invalid_Number(s);
EXPORT InValidMessage_zip(UNSIGNED1 wh) := InValidMessageFT_Invalid_Number(wh);
 
EXPORT Make_zip4(SALT38.StrType s0) := MakeFT_Invalid_Number(s0);
EXPORT InValid_zip4(SALT38.StrType s) := InValidFT_Invalid_Number(s);
EXPORT InValidMessage_zip4(UNSIGNED1 wh) := InValidMessageFT_Invalid_Number(wh);
 
EXPORT Make_cart(SALT38.StrType s0) := s0;
EXPORT InValid_cart(SALT38.StrType s) := 0;
EXPORT InValidMessage_cart(UNSIGNED1 wh) := '';
 
EXPORT Make_cr_sort_sz(SALT38.StrType s0) := s0;
EXPORT InValid_cr_sort_sz(SALT38.StrType s) := 0;
EXPORT InValidMessage_cr_sort_sz(UNSIGNED1 wh) := '';
 
EXPORT Make_lot(SALT38.StrType s0) := s0;
EXPORT InValid_lot(SALT38.StrType s) := 0;
EXPORT InValidMessage_lot(UNSIGNED1 wh) := '';
 
EXPORT Make_lot_order(SALT38.StrType s0) := s0;
EXPORT InValid_lot_order(SALT38.StrType s) := 0;
EXPORT InValidMessage_lot_order(UNSIGNED1 wh) := '';
 
EXPORT Make_dbpc(SALT38.StrType s0) := s0;
EXPORT InValid_dbpc(SALT38.StrType s) := 0;
EXPORT InValidMessage_dbpc(UNSIGNED1 wh) := '';
 
EXPORT Make_chk_digit(SALT38.StrType s0) := s0;
EXPORT InValid_chk_digit(SALT38.StrType s) := 0;
EXPORT InValidMessage_chk_digit(UNSIGNED1 wh) := '';
 
EXPORT Make_rec_type(SALT38.StrType s0) := s0;
EXPORT InValid_rec_type(SALT38.StrType s) := 0;
EXPORT InValidMessage_rec_type(UNSIGNED1 wh) := '';
 
EXPORT Make_county(SALT38.StrType s0) := s0;
EXPORT InValid_county(SALT38.StrType s) := 0;
EXPORT InValidMessage_county(UNSIGNED1 wh) := '';
 
EXPORT Make_geo_lat(SALT38.StrType s0) := s0;
EXPORT InValid_geo_lat(SALT38.StrType s) := 0;
EXPORT InValidMessage_geo_lat(UNSIGNED1 wh) := '';
 
EXPORT Make_geo_long(SALT38.StrType s0) := s0;
EXPORT InValid_geo_long(SALT38.StrType s) := 0;
EXPORT InValidMessage_geo_long(UNSIGNED1 wh) := '';
 
EXPORT Make_msa(SALT38.StrType s0) := s0;
EXPORT InValid_msa(SALT38.StrType s) := 0;
EXPORT InValidMessage_msa(UNSIGNED1 wh) := '';
 
EXPORT Make_geo_blk(SALT38.StrType s0) := s0;
EXPORT InValid_geo_blk(SALT38.StrType s) := 0;
EXPORT InValidMessage_geo_blk(UNSIGNED1 wh) := '';
 
EXPORT Make_geo_match(SALT38.StrType s0) := s0;
EXPORT InValid_geo_match(SALT38.StrType s) := 0;
EXPORT InValidMessage_geo_match(UNSIGNED1 wh) := '';
 
EXPORT Make_err_stat(SALT38.StrType s0) := s0;
EXPORT InValid_err_stat(SALT38.StrType s) := 0;
EXPORT InValidMessage_err_stat(UNSIGNED1 wh) := '';
 
EXPORT Make_date_submitted(SALT38.StrType s0) := MakeFT_Invalid_Date(s0);
EXPORT InValid_date_submitted(SALT38.StrType s) := InValidFT_Invalid_Date(s);
EXPORT InValidMessage_date_submitted(UNSIGNED1 wh) := InValidMessageFT_Invalid_Date(wh);
 
EXPORT Make_date_created(SALT38.StrType s0) := MakeFT_Invalid_Date(s0);
EXPORT InValid_date_created(SALT38.StrType s) := InValidFT_Invalid_Date(s);
EXPORT InValidMessage_date_created(UNSIGNED1 wh) := InValidMessageFT_Invalid_Date(wh);
 
EXPORT Make_did(SALT38.StrType s0) := MakeFT_Invalid_Number(s0);
EXPORT InValid_did(SALT38.StrType s) := InValidFT_Invalid_Number(s);
EXPORT InValidMessage_did(UNSIGNED1 wh) := InValidMessageFT_Invalid_Number(wh);
 
EXPORT Make_consumer_text(SALT38.StrType s0) := s0;
EXPORT InValid_consumer_text(SALT38.StrType s) := 0;
EXPORT InValidMessage_consumer_text(UNSIGNED1 wh) := '';
 
EXPORT Make_override_flag(SALT38.StrType s0) := MakeFT_Invalid_Number(s0);
EXPORT InValid_override_flag(SALT38.StrType s) := InValidFT_Invalid_Number(s);
EXPORT InValidMessage_override_flag(UNSIGNED1 wh) := InValidMessageFT_Invalid_Number(wh);
 
// This macro will compute and count field level differences based upon a pivot expression
export MAC_CountDifferencesByPivot(in_left,in_right,pivot_exp,bad_pivots,out_counts) := MACRO
  IMPORT SALT38,Scrubs_ConsumerStatement;
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
    BOOLEAN Diff_statement_id;
    BOOLEAN Diff_orig_fname;
    BOOLEAN Diff_orig_lname;
    BOOLEAN Diff_orig_mname;
    BOOLEAN Diff_orig_cname;
    BOOLEAN Diff_orig_address;
    BOOLEAN Diff_orig_city;
    BOOLEAN Diff_orig_st;
    BOOLEAN Diff_orig_zip;
    BOOLEAN Diff_orig_zip4;
    BOOLEAN Diff_phone;
    BOOLEAN Diff_title;
    BOOLEAN Diff_fname;
    BOOLEAN Diff_mname;
    BOOLEAN Diff_lname;
    BOOLEAN Diff_name_suffix;
    BOOLEAN Diff_name_score;
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
    BOOLEAN Diff_date_submitted;
    BOOLEAN Diff_date_created;
    BOOLEAN Diff_did;
    BOOLEAN Diff_consumer_text;
    BOOLEAN Diff_override_flag;
    UNSIGNED Num_Diffs;
    SALT38.StrType Val {MAXLENGTH(1024)};
  END;
#uniquename(fd)
  %dl% %fd%(in_left le,in_right ri) := TRANSFORM
    SELF.Diff_statement_id := le.statement_id <> ri.statement_id;
    SELF.Diff_orig_fname := le.orig_fname <> ri.orig_fname;
    SELF.Diff_orig_lname := le.orig_lname <> ri.orig_lname;
    SELF.Diff_orig_mname := le.orig_mname <> ri.orig_mname;
    SELF.Diff_orig_cname := le.orig_cname <> ri.orig_cname;
    SELF.Diff_orig_address := le.orig_address <> ri.orig_address;
    SELF.Diff_orig_city := le.orig_city <> ri.orig_city;
    SELF.Diff_orig_st := le.orig_st <> ri.orig_st;
    SELF.Diff_orig_zip := le.orig_zip <> ri.orig_zip;
    SELF.Diff_orig_zip4 := le.orig_zip4 <> ri.orig_zip4;
    SELF.Diff_phone := le.phone <> ri.phone;
    SELF.Diff_title := le.title <> ri.title;
    SELF.Diff_fname := le.fname <> ri.fname;
    SELF.Diff_mname := le.mname <> ri.mname;
    SELF.Diff_lname := le.lname <> ri.lname;
    SELF.Diff_name_suffix := le.name_suffix <> ri.name_suffix;
    SELF.Diff_name_score := le.name_score <> ri.name_score;
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
    SELF.Diff_date_submitted := le.date_submitted <> ri.date_submitted;
    SELF.Diff_date_created := le.date_created <> ri.date_created;
    SELF.Diff_did := le.did <> ri.did;
    SELF.Diff_consumer_text := le.consumer_text <> ri.consumer_text;
    SELF.Diff_override_flag := le.override_flag <> ri.override_flag;
    SELF.Val := (SALT38.StrType)evaluate(le,pivot_exp);
    SELF.Num_Diffs := 0+ IF( SELF.Diff_statement_id,1,0)+ IF( SELF.Diff_orig_fname,1,0)+ IF( SELF.Diff_orig_lname,1,0)+ IF( SELF.Diff_orig_mname,1,0)+ IF( SELF.Diff_orig_cname,1,0)+ IF( SELF.Diff_orig_address,1,0)+ IF( SELF.Diff_orig_city,1,0)+ IF( SELF.Diff_orig_st,1,0)+ IF( SELF.Diff_orig_zip,1,0)+ IF( SELF.Diff_orig_zip4,1,0)+ IF( SELF.Diff_phone,1,0)+ IF( SELF.Diff_title,1,0)+ IF( SELF.Diff_fname,1,0)+ IF( SELF.Diff_mname,1,0)+ IF( SELF.Diff_lname,1,0)+ IF( SELF.Diff_name_suffix,1,0)+ IF( SELF.Diff_name_score,1,0)+ IF( SELF.Diff_prim_range,1,0)+ IF( SELF.Diff_predir,1,0)+ IF( SELF.Diff_prim_name,1,0)+ IF( SELF.Diff_addr_suffix,1,0)+ IF( SELF.Diff_postdir,1,0)+ IF( SELF.Diff_unit_desig,1,0)+ IF( SELF.Diff_sec_range,1,0)+ IF( SELF.Diff_p_city_name,1,0)+ IF( SELF.Diff_v_city_name,1,0)+ IF( SELF.Diff_st,1,0)+ IF( SELF.Diff_zip,1,0)+ IF( SELF.Diff_zip4,1,0)+ IF( SELF.Diff_cart,1,0)+ IF( SELF.Diff_cr_sort_sz,1,0)+ IF( SELF.Diff_lot,1,0)+ IF( SELF.Diff_lot_order,1,0)+ IF( SELF.Diff_dbpc,1,0)+ IF( SELF.Diff_chk_digit,1,0)+ IF( SELF.Diff_rec_type,1,0)+ IF( SELF.Diff_county,1,0)+ IF( SELF.Diff_geo_lat,1,0)+ IF( SELF.Diff_geo_long,1,0)+ IF( SELF.Diff_msa,1,0)+ IF( SELF.Diff_geo_blk,1,0)+ IF( SELF.Diff_geo_match,1,0)+ IF( SELF.Diff_err_stat,1,0)+ IF( SELF.Diff_date_submitted,1,0)+ IF( SELF.Diff_date_created,1,0)+ IF( SELF.Diff_did,1,0)+ IF( SELF.Diff_consumer_text,1,0)+ IF( SELF.Diff_override_flag,1,0);
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
    Count_Diff_statement_id := COUNT(GROUP,%Closest%.Diff_statement_id);
    Count_Diff_orig_fname := COUNT(GROUP,%Closest%.Diff_orig_fname);
    Count_Diff_orig_lname := COUNT(GROUP,%Closest%.Diff_orig_lname);
    Count_Diff_orig_mname := COUNT(GROUP,%Closest%.Diff_orig_mname);
    Count_Diff_orig_cname := COUNT(GROUP,%Closest%.Diff_orig_cname);
    Count_Diff_orig_address := COUNT(GROUP,%Closest%.Diff_orig_address);
    Count_Diff_orig_city := COUNT(GROUP,%Closest%.Diff_orig_city);
    Count_Diff_orig_st := COUNT(GROUP,%Closest%.Diff_orig_st);
    Count_Diff_orig_zip := COUNT(GROUP,%Closest%.Diff_orig_zip);
    Count_Diff_orig_zip4 := COUNT(GROUP,%Closest%.Diff_orig_zip4);
    Count_Diff_phone := COUNT(GROUP,%Closest%.Diff_phone);
    Count_Diff_title := COUNT(GROUP,%Closest%.Diff_title);
    Count_Diff_fname := COUNT(GROUP,%Closest%.Diff_fname);
    Count_Diff_mname := COUNT(GROUP,%Closest%.Diff_mname);
    Count_Diff_lname := COUNT(GROUP,%Closest%.Diff_lname);
    Count_Diff_name_suffix := COUNT(GROUP,%Closest%.Diff_name_suffix);
    Count_Diff_name_score := COUNT(GROUP,%Closest%.Diff_name_score);
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
    Count_Diff_date_submitted := COUNT(GROUP,%Closest%.Diff_date_submitted);
    Count_Diff_date_created := COUNT(GROUP,%Closest%.Diff_date_created);
    Count_Diff_did := COUNT(GROUP,%Closest%.Diff_did);
    Count_Diff_consumer_text := COUNT(GROUP,%Closest%.Diff_consumer_text);
    Count_Diff_override_flag := COUNT(GROUP,%Closest%.Diff_override_flag);
  END;
  out_counts := table(%Closest%,%AggRec%,true);
ENDMACRO;
END;
