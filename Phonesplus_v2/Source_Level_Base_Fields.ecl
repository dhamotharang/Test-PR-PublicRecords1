IMPORT SALT311;
EXPORT Source_Level_Base_Fields := MODULE
 
EXPORT NumFields := 73;
 
EXPORT SALT311.StrType FieldName(UNSIGNED2 i) := CHOOSE(i,'cellphoneidkey','source','src_bitmap','household_flag','rules','cellphone','npa','phone7','phone7_did_key','pdid','did','did_score','datefirstseen','datelastseen','datevendorfirstreported','datevendorlastreported','dt_nonglb_last_seen','glb_dppa_flag','did_type','origname','address1','address2','origcity','origstate','origzip','orig_phone','orig_carrier_name','prim_range','predir','prim_name','addr_suffix','postdir','unit_desig','sec_range','p_city_name','v_city_name','state','zip5','zip4','cart','cr_sort_sz','lot','lot_order','dpbc','chk_digit','rec_type','ace_fips_st','ace_fips_county','geo_lat','geo_long','msa','geo_blk','geo_match','err_stat','title','fname','mname','lname','name_suffix','name_score','dob','rawaid','cleanaid','current_rec','first_build_date','last_build_date','ingest_tpe','verified','cord_cutter','activity_status','prepaid','global_sid','record_sid');
EXPORT SALT311.StrType FlatName(UNSIGNED2 i) := CHOOSE(i,'cellphoneidkey','source','src_bitmap','household_flag','rules','cellphone','npa','phone7','phone7_did_key','pdid','did','did_score','datefirstseen','datelastseen','datevendorfirstreported','datevendorlastreported','dt_nonglb_last_seen','glb_dppa_flag','did_type','origname','address1','address2','origcity','origstate','origzip','orig_phone','orig_carrier_name','prim_range','predir','prim_name','addr_suffix','postdir','unit_desig','sec_range','p_city_name','v_city_name','state','zip5','zip4','cart','cr_sort_sz','lot','lot_order','dpbc','chk_digit','rec_type','ace_fips_st','ace_fips_county','geo_lat','geo_long','msa','geo_blk','geo_match','err_stat','title','fname','mname','lname','name_suffix','name_score','dob','rawaid','cleanaid','current_rec','first_build_date','last_build_date','ingest_tpe','verified','cord_cutter','activity_status','prepaid','global_sid','record_sid');
EXPORT FieldNum(SALT311.StrType fn) := CASE(fn,'cellphoneidkey' => 0,'source' => 1,'src_bitmap' => 2,'household_flag' => 3,'rules' => 4,'cellphone' => 5,'npa' => 6,'phone7' => 7,'phone7_did_key' => 8,'pdid' => 9,'did' => 10,'did_score' => 11,'datefirstseen' => 12,'datelastseen' => 13,'datevendorfirstreported' => 14,'datevendorlastreported' => 15,'dt_nonglb_last_seen' => 16,'glb_dppa_flag' => 17,'did_type' => 18,'origname' => 19,'address1' => 20,'address2' => 21,'origcity' => 22,'origstate' => 23,'origzip' => 24,'orig_phone' => 25,'orig_carrier_name' => 26,'prim_range' => 27,'predir' => 28,'prim_name' => 29,'addr_suffix' => 30,'postdir' => 31,'unit_desig' => 32,'sec_range' => 33,'p_city_name' => 34,'v_city_name' => 35,'state' => 36,'zip5' => 37,'zip4' => 38,'cart' => 39,'cr_sort_sz' => 40,'lot' => 41,'lot_order' => 42,'dpbc' => 43,'chk_digit' => 44,'rec_type' => 45,'ace_fips_st' => 46,'ace_fips_county' => 47,'geo_lat' => 48,'geo_long' => 49,'msa' => 50,'geo_blk' => 51,'geo_match' => 52,'err_stat' => 53,'title' => 54,'fname' => 55,'mname' => 56,'lname' => 57,'name_suffix' => 58,'name_score' => 59,'dob' => 60,'rawaid' => 61,'cleanaid' => 62,'current_rec' => 63,'first_build_date' => 64,'last_build_date' => 65,'ingest_tpe' => 66,'verified' => 67,'cord_cutter' => 68,'activity_status' => 69,'prepaid' => 70,'global_sid' => 71,'record_sid' => 72,0);
EXPORT SET OF SALT311.StrType FieldRules(UNSIGNED2 i) := CHOOSE(i,[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[]);
EXPORT BOOLEAN InBaseLayout(UNSIGNED2 i) := CHOOSE(i,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,FALSE);
 
//Individual field level validation
 
EXPORT Make_cellphoneidkey(SALT311.StrType s0) := s0;
EXPORT InValid_cellphoneidkey(SALT311.StrType s) := 0;
EXPORT InValidMessage_cellphoneidkey(UNSIGNED1 wh) := '';
 
EXPORT Make_source(SALT311.StrType s0) := s0;
EXPORT InValid_source(SALT311.StrType s) := 0;
EXPORT InValidMessage_source(UNSIGNED1 wh) := '';
 
EXPORT Make_src_bitmap(SALT311.StrType s0) := s0;
EXPORT InValid_src_bitmap(SALT311.StrType s) := 0;
EXPORT InValidMessage_src_bitmap(UNSIGNED1 wh) := '';
 
EXPORT Make_household_flag(SALT311.StrType s0) := s0;
EXPORT InValid_household_flag(SALT311.StrType s) := 0;
EXPORT InValidMessage_household_flag(UNSIGNED1 wh) := '';
 
EXPORT Make_rules(SALT311.StrType s0) := s0;
EXPORT InValid_rules(SALT311.StrType s) := 0;
EXPORT InValidMessage_rules(UNSIGNED1 wh) := '';
 
EXPORT Make_cellphone(SALT311.StrType s0) := s0;
EXPORT InValid_cellphone(SALT311.StrType s) := 0;
EXPORT InValidMessage_cellphone(UNSIGNED1 wh) := '';
 
EXPORT Make_npa(SALT311.StrType s0) := s0;
EXPORT InValid_npa(SALT311.StrType s) := 0;
EXPORT InValidMessage_npa(UNSIGNED1 wh) := '';
 
EXPORT Make_phone7(SALT311.StrType s0) := s0;
EXPORT InValid_phone7(SALT311.StrType s) := 0;
EXPORT InValidMessage_phone7(UNSIGNED1 wh) := '';
 
EXPORT Make_phone7_did_key(SALT311.StrType s0) := s0;
EXPORT InValid_phone7_did_key(SALT311.StrType s) := 0;
EXPORT InValidMessage_phone7_did_key(UNSIGNED1 wh) := '';
 
EXPORT Make_pdid(SALT311.StrType s0) := s0;
EXPORT InValid_pdid(SALT311.StrType s) := 0;
EXPORT InValidMessage_pdid(UNSIGNED1 wh) := '';
 
EXPORT Make_did(SALT311.StrType s0) := s0;
EXPORT InValid_did(SALT311.StrType s) := 0;
EXPORT InValidMessage_did(UNSIGNED1 wh) := '';
 
EXPORT Make_did_score(SALT311.StrType s0) := s0;
EXPORT InValid_did_score(SALT311.StrType s) := 0;
EXPORT InValidMessage_did_score(UNSIGNED1 wh) := '';
 
EXPORT Make_datefirstseen(SALT311.StrType s0) := s0;
EXPORT InValid_datefirstseen(SALT311.StrType s) := 0;
EXPORT InValidMessage_datefirstseen(UNSIGNED1 wh) := '';
 
EXPORT Make_datelastseen(SALT311.StrType s0) := s0;
EXPORT InValid_datelastseen(SALT311.StrType s) := 0;
EXPORT InValidMessage_datelastseen(UNSIGNED1 wh) := '';
 
EXPORT Make_datevendorfirstreported(SALT311.StrType s0) := s0;
EXPORT InValid_datevendorfirstreported(SALT311.StrType s) := 0;
EXPORT InValidMessage_datevendorfirstreported(UNSIGNED1 wh) := '';
 
EXPORT Make_datevendorlastreported(SALT311.StrType s0) := s0;
EXPORT InValid_datevendorlastreported(SALT311.StrType s) := 0;
EXPORT InValidMessage_datevendorlastreported(UNSIGNED1 wh) := '';
 
EXPORT Make_dt_nonglb_last_seen(SALT311.StrType s0) := s0;
EXPORT InValid_dt_nonglb_last_seen(SALT311.StrType s) := 0;
EXPORT InValidMessage_dt_nonglb_last_seen(UNSIGNED1 wh) := '';
 
EXPORT Make_glb_dppa_flag(SALT311.StrType s0) := s0;
EXPORT InValid_glb_dppa_flag(SALT311.StrType s) := 0;
EXPORT InValidMessage_glb_dppa_flag(UNSIGNED1 wh) := '';
 
EXPORT Make_did_type(SALT311.StrType s0) := s0;
EXPORT InValid_did_type(SALT311.StrType s) := 0;
EXPORT InValidMessage_did_type(UNSIGNED1 wh) := '';
 
EXPORT Make_origname(SALT311.StrType s0) := s0;
EXPORT InValid_origname(SALT311.StrType s) := 0;
EXPORT InValidMessage_origname(UNSIGNED1 wh) := '';
 
EXPORT Make_address1(SALT311.StrType s0) := s0;
EXPORT InValid_address1(SALT311.StrType s) := 0;
EXPORT InValidMessage_address1(UNSIGNED1 wh) := '';
 
EXPORT Make_address2(SALT311.StrType s0) := s0;
EXPORT InValid_address2(SALT311.StrType s) := 0;
EXPORT InValidMessage_address2(UNSIGNED1 wh) := '';
 
EXPORT Make_origcity(SALT311.StrType s0) := s0;
EXPORT InValid_origcity(SALT311.StrType s) := 0;
EXPORT InValidMessage_origcity(UNSIGNED1 wh) := '';
 
EXPORT Make_origstate(SALT311.StrType s0) := s0;
EXPORT InValid_origstate(SALT311.StrType s) := 0;
EXPORT InValidMessage_origstate(UNSIGNED1 wh) := '';
 
EXPORT Make_origzip(SALT311.StrType s0) := s0;
EXPORT InValid_origzip(SALT311.StrType s) := 0;
EXPORT InValidMessage_origzip(UNSIGNED1 wh) := '';
 
EXPORT Make_orig_phone(SALT311.StrType s0) := s0;
EXPORT InValid_orig_phone(SALT311.StrType s) := 0;
EXPORT InValidMessage_orig_phone(UNSIGNED1 wh) := '';
 
EXPORT Make_orig_carrier_name(SALT311.StrType s0) := s0;
EXPORT InValid_orig_carrier_name(SALT311.StrType s) := 0;
EXPORT InValidMessage_orig_carrier_name(UNSIGNED1 wh) := '';
 
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
 
EXPORT Make_state(SALT311.StrType s0) := s0;
EXPORT InValid_state(SALT311.StrType s) := 0;
EXPORT InValidMessage_state(UNSIGNED1 wh) := '';
 
EXPORT Make_zip5(SALT311.StrType s0) := s0;
EXPORT InValid_zip5(SALT311.StrType s) := 0;
EXPORT InValidMessage_zip5(UNSIGNED1 wh) := '';
 
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
 
EXPORT Make_rec_type(SALT311.StrType s0) := s0;
EXPORT InValid_rec_type(SALT311.StrType s) := 0;
EXPORT InValidMessage_rec_type(UNSIGNED1 wh) := '';
 
EXPORT Make_ace_fips_st(SALT311.StrType s0) := s0;
EXPORT InValid_ace_fips_st(SALT311.StrType s) := 0;
EXPORT InValidMessage_ace_fips_st(UNSIGNED1 wh) := '';
 
EXPORT Make_ace_fips_county(SALT311.StrType s0) := s0;
EXPORT InValid_ace_fips_county(SALT311.StrType s) := 0;
EXPORT InValidMessage_ace_fips_county(UNSIGNED1 wh) := '';
 
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
 
EXPORT Make_dob(SALT311.StrType s0) := s0;
EXPORT InValid_dob(SALT311.StrType s) := 0;
EXPORT InValidMessage_dob(UNSIGNED1 wh) := '';
 
EXPORT Make_rawaid(SALT311.StrType s0) := s0;
EXPORT InValid_rawaid(SALT311.StrType s) := 0;
EXPORT InValidMessage_rawaid(UNSIGNED1 wh) := '';
 
EXPORT Make_cleanaid(SALT311.StrType s0) := s0;
EXPORT InValid_cleanaid(SALT311.StrType s) := 0;
EXPORT InValidMessage_cleanaid(UNSIGNED1 wh) := '';
 
EXPORT Make_current_rec(SALT311.StrType s0) := s0;
EXPORT InValid_current_rec(SALT311.StrType s) := 0;
EXPORT InValidMessage_current_rec(UNSIGNED1 wh) := '';
 
EXPORT Make_first_build_date(SALT311.StrType s0) := s0;
EXPORT InValid_first_build_date(SALT311.StrType s) := 0;
EXPORT InValidMessage_first_build_date(UNSIGNED1 wh) := '';
 
EXPORT Make_last_build_date(SALT311.StrType s0) := s0;
EXPORT InValid_last_build_date(SALT311.StrType s) := 0;
EXPORT InValidMessage_last_build_date(UNSIGNED1 wh) := '';
 
EXPORT Make_ingest_tpe(SALT311.StrType s0) := s0;
EXPORT InValid_ingest_tpe(SALT311.StrType s) := 0;
EXPORT InValidMessage_ingest_tpe(UNSIGNED1 wh) := '';
 
EXPORT Make_verified(SALT311.StrType s0) := s0;
EXPORT InValid_verified(SALT311.StrType s) := 0;
EXPORT InValidMessage_verified(UNSIGNED1 wh) := '';
 
EXPORT Make_cord_cutter(SALT311.StrType s0) := s0;
EXPORT InValid_cord_cutter(SALT311.StrType s) := 0;
EXPORT InValidMessage_cord_cutter(UNSIGNED1 wh) := '';
 
EXPORT Make_activity_status(SALT311.StrType s0) := s0;
EXPORT InValid_activity_status(SALT311.StrType s) := 0;
EXPORT InValidMessage_activity_status(UNSIGNED1 wh) := '';
 
EXPORT Make_prepaid(SALT311.StrType s0) := s0;
EXPORT InValid_prepaid(SALT311.StrType s) := 0;
EXPORT InValidMessage_prepaid(UNSIGNED1 wh) := '';
 
EXPORT Make_global_sid(SALT311.StrType s0) := s0;
EXPORT InValid_global_sid(SALT311.StrType s) := 0;
EXPORT InValidMessage_global_sid(UNSIGNED1 wh) := '';
 
EXPORT Make_record_sid(SALT311.StrType s0) := s0;
EXPORT InValid_record_sid(SALT311.StrType s) := 0;
EXPORT InValidMessage_record_sid(UNSIGNED1 wh) := '';
 
// This macro will compute and count field level differences based upon a pivot expression
export MAC_CountDifferencesByPivot(in_left,in_right,pivot_exp,bad_pivots,out_counts) := MACRO
  IMPORT SALT311,PhonesPlus_V2;
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
    BOOLEAN Diff_cellphoneidkey;
    BOOLEAN Diff_source;
    BOOLEAN Diff_src_bitmap;
    BOOLEAN Diff_household_flag;
    BOOLEAN Diff_rules;
    BOOLEAN Diff_cellphone;
    BOOLEAN Diff_npa;
    BOOLEAN Diff_phone7;
    BOOLEAN Diff_phone7_did_key;
    BOOLEAN Diff_pdid;
    BOOLEAN Diff_did;
    BOOLEAN Diff_did_score;
    BOOLEAN Diff_datefirstseen;
    BOOLEAN Diff_datelastseen;
    BOOLEAN Diff_datevendorfirstreported;
    BOOLEAN Diff_datevendorlastreported;
    BOOLEAN Diff_dt_nonglb_last_seen;
    BOOLEAN Diff_glb_dppa_flag;
    BOOLEAN Diff_did_type;
    BOOLEAN Diff_origname;
    BOOLEAN Diff_address1;
    BOOLEAN Diff_address2;
    BOOLEAN Diff_origcity;
    BOOLEAN Diff_origstate;
    BOOLEAN Diff_origzip;
    BOOLEAN Diff_orig_phone;
    BOOLEAN Diff_orig_carrier_name;
    BOOLEAN Diff_prim_range;
    BOOLEAN Diff_predir;
    BOOLEAN Diff_prim_name;
    BOOLEAN Diff_addr_suffix;
    BOOLEAN Diff_postdir;
    BOOLEAN Diff_unit_desig;
    BOOLEAN Diff_sec_range;
    BOOLEAN Diff_p_city_name;
    BOOLEAN Diff_v_city_name;
    BOOLEAN Diff_state;
    BOOLEAN Diff_zip5;
    BOOLEAN Diff_zip4;
    BOOLEAN Diff_cart;
    BOOLEAN Diff_cr_sort_sz;
    BOOLEAN Diff_lot;
    BOOLEAN Diff_lot_order;
    BOOLEAN Diff_dpbc;
    BOOLEAN Diff_chk_digit;
    BOOLEAN Diff_rec_type;
    BOOLEAN Diff_ace_fips_st;
    BOOLEAN Diff_ace_fips_county;
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
    BOOLEAN Diff_dob;
    BOOLEAN Diff_rawaid;
    BOOLEAN Diff_cleanaid;
    BOOLEAN Diff_current_rec;
    BOOLEAN Diff_first_build_date;
    BOOLEAN Diff_last_build_date;
    BOOLEAN Diff_ingest_tpe;
    BOOLEAN Diff_verified;
    BOOLEAN Diff_cord_cutter;
    BOOLEAN Diff_activity_status;
    BOOLEAN Diff_prepaid;
    BOOLEAN Diff_global_sid;
    BOOLEAN Diff_record_sid;
    SALT311.StrType SourceField {MAXLENGTH(30)};
    UNSIGNED Num_Diffs;
    SALT311.StrType Val {MAXLENGTH(1024)};
  END;
#uniquename(fd)
  %dl% %fd%(in_left le,in_right ri) := TRANSFORM
    SELF.Diff_cellphoneidkey := le.cellphoneidkey <> ri.cellphoneidkey;
    SELF.Diff_source := le.source <> ri.source;
    SELF.Diff_src_bitmap := le.src_bitmap <> ri.src_bitmap;
    SELF.Diff_household_flag := le.household_flag <> ri.household_flag;
    SELF.Diff_rules := le.rules <> ri.rules;
    SELF.Diff_cellphone := le.cellphone <> ri.cellphone;
    SELF.Diff_npa := le.npa <> ri.npa;
    SELF.Diff_phone7 := le.phone7 <> ri.phone7;
    SELF.Diff_phone7_did_key := le.phone7_did_key <> ri.phone7_did_key;
    SELF.Diff_pdid := le.pdid <> ri.pdid;
    SELF.Diff_did := le.did <> ri.did;
    SELF.Diff_did_score := le.did_score <> ri.did_score;
    SELF.Diff_datefirstseen := le.datefirstseen <> ri.datefirstseen;
    SELF.Diff_datelastseen := le.datelastseen <> ri.datelastseen;
    SELF.Diff_datevendorfirstreported := le.datevendorfirstreported <> ri.datevendorfirstreported;
    SELF.Diff_datevendorlastreported := le.datevendorlastreported <> ri.datevendorlastreported;
    SELF.Diff_dt_nonglb_last_seen := le.dt_nonglb_last_seen <> ri.dt_nonglb_last_seen;
    SELF.Diff_glb_dppa_flag := le.glb_dppa_flag <> ri.glb_dppa_flag;
    SELF.Diff_did_type := le.did_type <> ri.did_type;
    SELF.Diff_origname := le.origname <> ri.origname;
    SELF.Diff_address1 := le.address1 <> ri.address1;
    SELF.Diff_address2 := le.address2 <> ri.address2;
    SELF.Diff_origcity := le.origcity <> ri.origcity;
    SELF.Diff_origstate := le.origstate <> ri.origstate;
    SELF.Diff_origzip := le.origzip <> ri.origzip;
    SELF.Diff_orig_phone := le.orig_phone <> ri.orig_phone;
    SELF.Diff_orig_carrier_name := le.orig_carrier_name <> ri.orig_carrier_name;
    SELF.Diff_prim_range := le.prim_range <> ri.prim_range;
    SELF.Diff_predir := le.predir <> ri.predir;
    SELF.Diff_prim_name := le.prim_name <> ri.prim_name;
    SELF.Diff_addr_suffix := le.addr_suffix <> ri.addr_suffix;
    SELF.Diff_postdir := le.postdir <> ri.postdir;
    SELF.Diff_unit_desig := le.unit_desig <> ri.unit_desig;
    SELF.Diff_sec_range := le.sec_range <> ri.sec_range;
    SELF.Diff_p_city_name := le.p_city_name <> ri.p_city_name;
    SELF.Diff_v_city_name := le.v_city_name <> ri.v_city_name;
    SELF.Diff_state := le.state <> ri.state;
    SELF.Diff_zip5 := le.zip5 <> ri.zip5;
    SELF.Diff_zip4 := le.zip4 <> ri.zip4;
    SELF.Diff_cart := le.cart <> ri.cart;
    SELF.Diff_cr_sort_sz := le.cr_sort_sz <> ri.cr_sort_sz;
    SELF.Diff_lot := le.lot <> ri.lot;
    SELF.Diff_lot_order := le.lot_order <> ri.lot_order;
    SELF.Diff_dpbc := le.dpbc <> ri.dpbc;
    SELF.Diff_chk_digit := le.chk_digit <> ri.chk_digit;
    SELF.Diff_rec_type := le.rec_type <> ri.rec_type;
    SELF.Diff_ace_fips_st := le.ace_fips_st <> ri.ace_fips_st;
    SELF.Diff_ace_fips_county := le.ace_fips_county <> ri.ace_fips_county;
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
    SELF.Diff_dob := le.dob <> ri.dob;
    SELF.Diff_rawaid := le.rawaid <> ri.rawaid;
    SELF.Diff_cleanaid := le.cleanaid <> ri.cleanaid;
    SELF.Diff_current_rec := le.current_rec <> ri.current_rec;
    SELF.Diff_first_build_date := le.first_build_date <> ri.first_build_date;
    SELF.Diff_last_build_date := le.last_build_date <> ri.last_build_date;
    SELF.Diff_ingest_tpe := le.ingest_tpe <> ri.ingest_tpe;
    SELF.Diff_verified := le.verified <> ri.verified;
    SELF.Diff_cord_cutter := le.cord_cutter <> ri.cord_cutter;
    SELF.Diff_activity_status := le.activity_status <> ri.activity_status;
    SELF.Diff_prepaid := le.prepaid <> ri.prepaid;
    SELF.Diff_global_sid := le.global_sid <> ri.global_sid;
    SELF.Diff_record_sid := le.record_sid <> ri.record_sid;
    SELF.Val := (SALT311.StrType)evaluate(le,pivot_exp);
    SELF.SourceField := le.source;
    SELF.Num_Diffs := 0+ IF( SELF.Diff_cellphoneidkey,1,0)+ IF( SELF.Diff_source,1,0)+ IF( SELF.Diff_src_bitmap,1,0)+ IF( SELF.Diff_household_flag,1,0)+ IF( SELF.Diff_rules,1,0)+ IF( SELF.Diff_cellphone,1,0)+ IF( SELF.Diff_npa,1,0)+ IF( SELF.Diff_phone7,1,0)+ IF( SELF.Diff_phone7_did_key,1,0)+ IF( SELF.Diff_pdid,1,0)+ IF( SELF.Diff_did,1,0)+ IF( SELF.Diff_did_score,1,0)+ IF( SELF.Diff_datefirstseen,1,0)+ IF( SELF.Diff_datelastseen,1,0)+ IF( SELF.Diff_datevendorfirstreported,1,0)+ IF( SELF.Diff_datevendorlastreported,1,0)+ IF( SELF.Diff_dt_nonglb_last_seen,1,0)+ IF( SELF.Diff_glb_dppa_flag,1,0)+ IF( SELF.Diff_did_type,1,0)+ IF( SELF.Diff_origname,1,0)+ IF( SELF.Diff_address1,1,0)+ IF( SELF.Diff_address2,1,0)+ IF( SELF.Diff_origcity,1,0)+ IF( SELF.Diff_origstate,1,0)+ IF( SELF.Diff_origzip,1,0)+ IF( SELF.Diff_orig_phone,1,0)+ IF( SELF.Diff_orig_carrier_name,1,0)+ IF( SELF.Diff_prim_range,1,0)+ IF( SELF.Diff_predir,1,0)+ IF( SELF.Diff_prim_name,1,0)+ IF( SELF.Diff_addr_suffix,1,0)+ IF( SELF.Diff_postdir,1,0)+ IF( SELF.Diff_unit_desig,1,0)+ IF( SELF.Diff_sec_range,1,0)+ IF( SELF.Diff_p_city_name,1,0)+ IF( SELF.Diff_v_city_name,1,0)+ IF( SELF.Diff_state,1,0)+ IF( SELF.Diff_zip5,1,0)+ IF( SELF.Diff_zip4,1,0)+ IF( SELF.Diff_cart,1,0)+ IF( SELF.Diff_cr_sort_sz,1,0)+ IF( SELF.Diff_lot,1,0)+ IF( SELF.Diff_lot_order,1,0)+ IF( SELF.Diff_dpbc,1,0)+ IF( SELF.Diff_chk_digit,1,0)+ IF( SELF.Diff_rec_type,1,0)+ IF( SELF.Diff_ace_fips_st,1,0)+ IF( SELF.Diff_ace_fips_county,1,0)+ IF( SELF.Diff_geo_lat,1,0)+ IF( SELF.Diff_geo_long,1,0)+ IF( SELF.Diff_msa,1,0)+ IF( SELF.Diff_geo_blk,1,0)+ IF( SELF.Diff_geo_match,1,0)+ IF( SELF.Diff_err_stat,1,0)+ IF( SELF.Diff_title,1,0)+ IF( SELF.Diff_fname,1,0)+ IF( SELF.Diff_mname,1,0)+ IF( SELF.Diff_lname,1,0)+ IF( SELF.Diff_name_suffix,1,0)+ IF( SELF.Diff_name_score,1,0)+ IF( SELF.Diff_dob,1,0)+ IF( SELF.Diff_rawaid,1,0)+ IF( SELF.Diff_cleanaid,1,0)+ IF( SELF.Diff_current_rec,1,0)+ IF( SELF.Diff_first_build_date,1,0)+ IF( SELF.Diff_last_build_date,1,0)+ IF( SELF.Diff_ingest_tpe,1,0)+ IF( SELF.Diff_verified,1,0)+ IF( SELF.Diff_cord_cutter,1,0)+ IF( SELF.Diff_activity_status,1,0)+ IF( SELF.Diff_prepaid,1,0)+ IF( SELF.Diff_global_sid,1,0)+ IF( SELF.Diff_record_sid,1,0);
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
    Count_Diff_cellphoneidkey := COUNT(GROUP,%Closest%.Diff_cellphoneidkey);
    Count_Diff_source := COUNT(GROUP,%Closest%.Diff_source);
    Count_Diff_src_bitmap := COUNT(GROUP,%Closest%.Diff_src_bitmap);
    Count_Diff_household_flag := COUNT(GROUP,%Closest%.Diff_household_flag);
    Count_Diff_rules := COUNT(GROUP,%Closest%.Diff_rules);
    Count_Diff_cellphone := COUNT(GROUP,%Closest%.Diff_cellphone);
    Count_Diff_npa := COUNT(GROUP,%Closest%.Diff_npa);
    Count_Diff_phone7 := COUNT(GROUP,%Closest%.Diff_phone7);
    Count_Diff_phone7_did_key := COUNT(GROUP,%Closest%.Diff_phone7_did_key);
    Count_Diff_pdid := COUNT(GROUP,%Closest%.Diff_pdid);
    Count_Diff_did := COUNT(GROUP,%Closest%.Diff_did);
    Count_Diff_did_score := COUNT(GROUP,%Closest%.Diff_did_score);
    Count_Diff_datefirstseen := COUNT(GROUP,%Closest%.Diff_datefirstseen);
    Count_Diff_datelastseen := COUNT(GROUP,%Closest%.Diff_datelastseen);
    Count_Diff_datevendorfirstreported := COUNT(GROUP,%Closest%.Diff_datevendorfirstreported);
    Count_Diff_datevendorlastreported := COUNT(GROUP,%Closest%.Diff_datevendorlastreported);
    Count_Diff_dt_nonglb_last_seen := COUNT(GROUP,%Closest%.Diff_dt_nonglb_last_seen);
    Count_Diff_glb_dppa_flag := COUNT(GROUP,%Closest%.Diff_glb_dppa_flag);
    Count_Diff_did_type := COUNT(GROUP,%Closest%.Diff_did_type);
    Count_Diff_origname := COUNT(GROUP,%Closest%.Diff_origname);
    Count_Diff_address1 := COUNT(GROUP,%Closest%.Diff_address1);
    Count_Diff_address2 := COUNT(GROUP,%Closest%.Diff_address2);
    Count_Diff_origcity := COUNT(GROUP,%Closest%.Diff_origcity);
    Count_Diff_origstate := COUNT(GROUP,%Closest%.Diff_origstate);
    Count_Diff_origzip := COUNT(GROUP,%Closest%.Diff_origzip);
    Count_Diff_orig_phone := COUNT(GROUP,%Closest%.Diff_orig_phone);
    Count_Diff_orig_carrier_name := COUNT(GROUP,%Closest%.Diff_orig_carrier_name);
    Count_Diff_prim_range := COUNT(GROUP,%Closest%.Diff_prim_range);
    Count_Diff_predir := COUNT(GROUP,%Closest%.Diff_predir);
    Count_Diff_prim_name := COUNT(GROUP,%Closest%.Diff_prim_name);
    Count_Diff_addr_suffix := COUNT(GROUP,%Closest%.Diff_addr_suffix);
    Count_Diff_postdir := COUNT(GROUP,%Closest%.Diff_postdir);
    Count_Diff_unit_desig := COUNT(GROUP,%Closest%.Diff_unit_desig);
    Count_Diff_sec_range := COUNT(GROUP,%Closest%.Diff_sec_range);
    Count_Diff_p_city_name := COUNT(GROUP,%Closest%.Diff_p_city_name);
    Count_Diff_v_city_name := COUNT(GROUP,%Closest%.Diff_v_city_name);
    Count_Diff_state := COUNT(GROUP,%Closest%.Diff_state);
    Count_Diff_zip5 := COUNT(GROUP,%Closest%.Diff_zip5);
    Count_Diff_zip4 := COUNT(GROUP,%Closest%.Diff_zip4);
    Count_Diff_cart := COUNT(GROUP,%Closest%.Diff_cart);
    Count_Diff_cr_sort_sz := COUNT(GROUP,%Closest%.Diff_cr_sort_sz);
    Count_Diff_lot := COUNT(GROUP,%Closest%.Diff_lot);
    Count_Diff_lot_order := COUNT(GROUP,%Closest%.Diff_lot_order);
    Count_Diff_dpbc := COUNT(GROUP,%Closest%.Diff_dpbc);
    Count_Diff_chk_digit := COUNT(GROUP,%Closest%.Diff_chk_digit);
    Count_Diff_rec_type := COUNT(GROUP,%Closest%.Diff_rec_type);
    Count_Diff_ace_fips_st := COUNT(GROUP,%Closest%.Diff_ace_fips_st);
    Count_Diff_ace_fips_county := COUNT(GROUP,%Closest%.Diff_ace_fips_county);
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
    Count_Diff_dob := COUNT(GROUP,%Closest%.Diff_dob);
    Count_Diff_rawaid := COUNT(GROUP,%Closest%.Diff_rawaid);
    Count_Diff_cleanaid := COUNT(GROUP,%Closest%.Diff_cleanaid);
    Count_Diff_current_rec := COUNT(GROUP,%Closest%.Diff_current_rec);
    Count_Diff_first_build_date := COUNT(GROUP,%Closest%.Diff_first_build_date);
    Count_Diff_last_build_date := COUNT(GROUP,%Closest%.Diff_last_build_date);
    Count_Diff_ingest_tpe := COUNT(GROUP,%Closest%.Diff_ingest_tpe);
    Count_Diff_verified := COUNT(GROUP,%Closest%.Diff_verified);
    Count_Diff_cord_cutter := COUNT(GROUP,%Closest%.Diff_cord_cutter);
    Count_Diff_activity_status := COUNT(GROUP,%Closest%.Diff_activity_status);
    Count_Diff_prepaid := COUNT(GROUP,%Closest%.Diff_prepaid);
    Count_Diff_global_sid := COUNT(GROUP,%Closest%.Diff_global_sid);
    Count_Diff_record_sid := COUNT(GROUP,%Closest%.Diff_record_sid);
    %Closest%.SourceField;
  END;
  out_counts := table(%Closest%,%AggRec%,SourceField,few);
ENDMACRO;
END;
