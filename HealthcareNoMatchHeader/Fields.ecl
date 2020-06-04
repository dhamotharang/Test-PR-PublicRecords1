IMPORT SALT311;
EXPORT Fields := MODULE
 
EXPORT NumFields := 61;
 
EXPORT SALT311.StrType FieldName(UNSIGNED2 i) := CHOOSE(i,'nomatch_id','rid','lexid','lexid_score','guardian_lexid','guardian_lexid_score','crk','src','source_rid','dt_first_seen','dt_last_seen','dt_vendor_first_reported','dt_vendor_last_reported','member_id','customer_id','account_id','subscriber_id','group_id','relationship_code','title','fname','mname','lname','suffix','input_full_name','dob','gender','ssn','home_phone','alt_phone','primary_email_address','prim_range','predir','prim_name','addr_suffix','postdir','unit_desig','sec_range','city_name','st','zip','zip4','rec_type','county','geo_lat','geo_long','msa','geo_blk','geo_match','err_stat','guardian_fname','guardian_mname','guardian_lname','guardian_dob','guardian_ssn','udf1','udf2','udf3','persistent_rid','global_sid','record_sid');
EXPORT SALT311.StrType FlatName(UNSIGNED2 i) := CHOOSE(i,'nomatch_id','rid','lexid','lexid_score','guardian_lexid','guardian_lexid_score','crk','src','source_rid','dt_first_seen','dt_last_seen','dt_vendor_first_reported','dt_vendor_last_reported','member_id','customer_id','account_id','subscriber_id','group_id','relationship_code','title','fname','mname','lname','suffix','input_full_name','dob','gender','ssn','home_phone','alt_phone','primary_email_address','prim_range','predir','prim_name','addr_suffix','postdir','unit_desig','sec_range','city_name','st','zip','zip4','rec_type','county','geo_lat','geo_long','msa','geo_blk','geo_match','err_stat','guardian_fname','guardian_mname','guardian_lname','guardian_dob','guardian_ssn','udf1','udf2','udf3','persistent_rid','global_sid','record_sid');
EXPORT FieldNum(SALT311.StrType fn) := CASE(fn,'nomatch_id' => 0,'rid' => 1,'lexid' => 2,'lexid_score' => 3,'guardian_lexid' => 4,'guardian_lexid_score' => 5,'crk' => 6,'src' => 7,'source_rid' => 8,'dt_first_seen' => 9,'dt_last_seen' => 10,'dt_vendor_first_reported' => 11,'dt_vendor_last_reported' => 12,'member_id' => 13,'customer_id' => 14,'account_id' => 15,'subscriber_id' => 16,'group_id' => 17,'relationship_code' => 18,'title' => 19,'fname' => 20,'mname' => 21,'lname' => 22,'suffix' => 23,'input_full_name' => 24,'dob' => 25,'gender' => 26,'ssn' => 27,'home_phone' => 28,'alt_phone' => 29,'primary_email_address' => 30,'prim_range' => 31,'predir' => 32,'prim_name' => 33,'addr_suffix' => 34,'postdir' => 35,'unit_desig' => 36,'sec_range' => 37,'city_name' => 38,'st' => 39,'zip' => 40,'zip4' => 41,'rec_type' => 42,'county' => 43,'geo_lat' => 44,'geo_long' => 45,'msa' => 46,'geo_blk' => 47,'geo_match' => 48,'err_stat' => 49,'guardian_fname' => 50,'guardian_mname' => 51,'guardian_lname' => 52,'guardian_dob' => 53,'guardian_ssn' => 54,'udf1' => 55,'udf2' => 56,'udf3' => 57,'persistent_rid' => 58,'global_sid' => 59,'record_sid' => 60,0);
EXPORT SET OF SALT311.StrType FieldRules(UNSIGNED2 i) := CHOOSE(i,[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[]);
EXPORT BOOLEAN InBaseLayout(UNSIGNED2 i) := CHOOSE(i,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,FALSE);
 
//Individual field level validation
 
EXPORT Make_nomatch_id(SALT311.StrType s0) := s0;
EXPORT InValid_nomatch_id(SALT311.StrType s) := 0;
EXPORT InValidMessage_nomatch_id(UNSIGNED1 wh) := '';
 
EXPORT Make_rid(SALT311.StrType s0) := s0;
EXPORT InValid_rid(SALT311.StrType s) := 0;
EXPORT InValidMessage_rid(UNSIGNED1 wh) := '';
 
EXPORT Make_lexid(SALT311.StrType s0) := s0;
EXPORT InValid_lexid(SALT311.StrType s) := 0;
EXPORT InValidMessage_lexid(UNSIGNED1 wh) := '';
 
EXPORT Make_lexid_score(SALT311.StrType s0) := s0;
EXPORT InValid_lexid_score(SALT311.StrType s) := 0;
EXPORT InValidMessage_lexid_score(UNSIGNED1 wh) := '';
 
EXPORT Make_guardian_lexid(SALT311.StrType s0) := s0;
EXPORT InValid_guardian_lexid(SALT311.StrType s) := 0;
EXPORT InValidMessage_guardian_lexid(UNSIGNED1 wh) := '';
 
EXPORT Make_guardian_lexid_score(SALT311.StrType s0) := s0;
EXPORT InValid_guardian_lexid_score(SALT311.StrType s) := 0;
EXPORT InValidMessage_guardian_lexid_score(UNSIGNED1 wh) := '';
 
EXPORT Make_crk(SALT311.StrType s0) := s0;
EXPORT InValid_crk(SALT311.StrType s) := 0;
EXPORT InValidMessage_crk(UNSIGNED1 wh) := '';
 
EXPORT Make_src(SALT311.StrType s0) := s0;
EXPORT InValid_src(SALT311.StrType s) := 0;
EXPORT InValidMessage_src(UNSIGNED1 wh) := '';
 
EXPORT Make_source_rid(SALT311.StrType s0) := s0;
EXPORT InValid_source_rid(SALT311.StrType s) := 0;
EXPORT InValidMessage_source_rid(UNSIGNED1 wh) := '';
 
EXPORT Make_dt_first_seen(SALT311.StrType s0) := s0;
EXPORT InValid_dt_first_seen(SALT311.StrType s) := 0;
EXPORT InValidMessage_dt_first_seen(UNSIGNED1 wh) := '';
 
EXPORT Make_dt_last_seen(SALT311.StrType s0) := s0;
EXPORT InValid_dt_last_seen(SALT311.StrType s) := 0;
EXPORT InValidMessage_dt_last_seen(UNSIGNED1 wh) := '';
 
EXPORT Make_dt_vendor_first_reported(SALT311.StrType s0) := s0;
EXPORT InValid_dt_vendor_first_reported(SALT311.StrType s) := 0;
EXPORT InValidMessage_dt_vendor_first_reported(UNSIGNED1 wh) := '';
 
EXPORT Make_dt_vendor_last_reported(SALT311.StrType s0) := s0;
EXPORT InValid_dt_vendor_last_reported(SALT311.StrType s) := 0;
EXPORT InValidMessage_dt_vendor_last_reported(UNSIGNED1 wh) := '';
 
EXPORT Make_member_id(SALT311.StrType s0) := s0;
EXPORT InValid_member_id(SALT311.StrType s) := 0;
EXPORT InValidMessage_member_id(UNSIGNED1 wh) := '';
 
EXPORT Make_customer_id(SALT311.StrType s0) := s0;
EXPORT InValid_customer_id(SALT311.StrType s) := 0;
EXPORT InValidMessage_customer_id(UNSIGNED1 wh) := '';
 
EXPORT Make_account_id(SALT311.StrType s0) := s0;
EXPORT InValid_account_id(SALT311.StrType s) := 0;
EXPORT InValidMessage_account_id(UNSIGNED1 wh) := '';
 
EXPORT Make_subscriber_id(SALT311.StrType s0) := s0;
EXPORT InValid_subscriber_id(SALT311.StrType s) := 0;
EXPORT InValidMessage_subscriber_id(UNSIGNED1 wh) := '';
 
EXPORT Make_group_id(SALT311.StrType s0) := s0;
EXPORT InValid_group_id(SALT311.StrType s) := 0;
EXPORT InValidMessage_group_id(UNSIGNED1 wh) := '';
 
EXPORT Make_relationship_code(SALT311.StrType s0) := s0;
EXPORT InValid_relationship_code(SALT311.StrType s) := 0;
EXPORT InValidMessage_relationship_code(UNSIGNED1 wh) := '';
 
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
 
EXPORT Make_suffix(SALT311.StrType s0) := s0;
EXPORT InValid_suffix(SALT311.StrType s) := 0;
EXPORT InValidMessage_suffix(UNSIGNED1 wh) := '';
 
EXPORT Make_input_full_name(SALT311.StrType s0) := s0;
EXPORT InValid_input_full_name(SALT311.StrType s) := 0;
EXPORT InValidMessage_input_full_name(UNSIGNED1 wh) := '';
 
EXPORT Make_dob(SALT311.StrType s0) := s0;
EXPORT InValid_dob(SALT311.StrType s) := 0;
EXPORT InValidMessage_dob(UNSIGNED1 wh) := '';
 
EXPORT Make_gender(SALT311.StrType s0) := s0;
EXPORT InValid_gender(SALT311.StrType s) := 0;
EXPORT InValidMessage_gender(UNSIGNED1 wh) := '';
 
EXPORT Make_ssn(SALT311.StrType s0) := s0;
EXPORT InValid_ssn(SALT311.StrType s) := 0;
EXPORT InValidMessage_ssn(UNSIGNED1 wh) := '';
 
EXPORT Make_home_phone(SALT311.StrType s0) := s0;
EXPORT InValid_home_phone(SALT311.StrType s) := 0;
EXPORT InValidMessage_home_phone(UNSIGNED1 wh) := '';
 
EXPORT Make_alt_phone(SALT311.StrType s0) := s0;
EXPORT InValid_alt_phone(SALT311.StrType s) := 0;
EXPORT InValidMessage_alt_phone(UNSIGNED1 wh) := '';
 
EXPORT Make_primary_email_address(SALT311.StrType s0) := s0;
EXPORT InValid_primary_email_address(SALT311.StrType s) := 0;
EXPORT InValidMessage_primary_email_address(UNSIGNED1 wh) := '';
 
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
 
EXPORT Make_city_name(SALT311.StrType s0) := s0;
EXPORT InValid_city_name(SALT311.StrType s) := 0;
EXPORT InValidMessage_city_name(UNSIGNED1 wh) := '';
 
EXPORT Make_st(SALT311.StrType s0) := s0;
EXPORT InValid_st(SALT311.StrType s) := 0;
EXPORT InValidMessage_st(UNSIGNED1 wh) := '';
 
EXPORT Make_zip(SALT311.StrType s0) := s0;
EXPORT InValid_zip(SALT311.StrType s) := 0;
EXPORT InValidMessage_zip(UNSIGNED1 wh) := '';
 
EXPORT Make_zip4(SALT311.StrType s0) := s0;
EXPORT InValid_zip4(SALT311.StrType s) := 0;
EXPORT InValidMessage_zip4(UNSIGNED1 wh) := '';
 
EXPORT Make_rec_type(SALT311.StrType s0) := s0;
EXPORT InValid_rec_type(SALT311.StrType s) := 0;
EXPORT InValidMessage_rec_type(UNSIGNED1 wh) := '';
 
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
 
EXPORT Make_guardian_fname(SALT311.StrType s0) := s0;
EXPORT InValid_guardian_fname(SALT311.StrType s) := 0;
EXPORT InValidMessage_guardian_fname(UNSIGNED1 wh) := '';
 
EXPORT Make_guardian_mname(SALT311.StrType s0) := s0;
EXPORT InValid_guardian_mname(SALT311.StrType s) := 0;
EXPORT InValidMessage_guardian_mname(UNSIGNED1 wh) := '';
 
EXPORT Make_guardian_lname(SALT311.StrType s0) := s0;
EXPORT InValid_guardian_lname(SALT311.StrType s) := 0;
EXPORT InValidMessage_guardian_lname(UNSIGNED1 wh) := '';
 
EXPORT Make_guardian_dob(SALT311.StrType s0) := s0;
EXPORT InValid_guardian_dob(SALT311.StrType s) := 0;
EXPORT InValidMessage_guardian_dob(UNSIGNED1 wh) := '';
 
EXPORT Make_guardian_ssn(SALT311.StrType s0) := s0;
EXPORT InValid_guardian_ssn(SALT311.StrType s) := 0;
EXPORT InValidMessage_guardian_ssn(UNSIGNED1 wh) := '';
 
EXPORT Make_udf1(SALT311.StrType s0) := s0;
EXPORT InValid_udf1(SALT311.StrType s) := 0;
EXPORT InValidMessage_udf1(UNSIGNED1 wh) := '';
 
EXPORT Make_udf2(SALT311.StrType s0) := s0;
EXPORT InValid_udf2(SALT311.StrType s) := 0;
EXPORT InValidMessage_udf2(UNSIGNED1 wh) := '';
 
EXPORT Make_udf3(SALT311.StrType s0) := s0;
EXPORT InValid_udf3(SALT311.StrType s) := 0;
EXPORT InValidMessage_udf3(UNSIGNED1 wh) := '';
 
EXPORT Make_persistent_rid(SALT311.StrType s0) := s0;
EXPORT InValid_persistent_rid(SALT311.StrType s) := 0;
EXPORT InValidMessage_persistent_rid(UNSIGNED1 wh) := '';
 
EXPORT Make_global_sid(SALT311.StrType s0) := s0;
EXPORT InValid_global_sid(SALT311.StrType s) := 0;
EXPORT InValidMessage_global_sid(UNSIGNED1 wh) := '';
 
EXPORT Make_record_sid(SALT311.StrType s0) := s0;
EXPORT InValid_record_sid(SALT311.StrType s) := 0;
EXPORT InValidMessage_record_sid(UNSIGNED1 wh) := '';
 
// This macro will compute and count field level differences based upon a pivot expression
export MAC_CountDifferencesByPivot(in_left,in_right,pivot_exp,bad_pivots,out_counts) := MACRO
  IMPORT SALT311,HealthcareNoMatchHeader;
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
    BOOLEAN Diff_nomatch_id;
    BOOLEAN Diff_rid;
    BOOLEAN Diff_lexid;
    BOOLEAN Diff_lexid_score;
    BOOLEAN Diff_guardian_lexid;
    BOOLEAN Diff_guardian_lexid_score;
    BOOLEAN Diff_crk;
    BOOLEAN Diff_src;
    BOOLEAN Diff_source_rid;
    BOOLEAN Diff_dt_first_seen;
    BOOLEAN Diff_dt_last_seen;
    BOOLEAN Diff_dt_vendor_first_reported;
    BOOLEAN Diff_dt_vendor_last_reported;
    BOOLEAN Diff_member_id;
    BOOLEAN Diff_customer_id;
    BOOLEAN Diff_account_id;
    BOOLEAN Diff_subscriber_id;
    BOOLEAN Diff_group_id;
    BOOLEAN Diff_relationship_code;
    BOOLEAN Diff_title;
    BOOLEAN Diff_fname;
    BOOLEAN Diff_mname;
    BOOLEAN Diff_lname;
    BOOLEAN Diff_suffix;
    BOOLEAN Diff_input_full_name;
    BOOLEAN Diff_dob;
    BOOLEAN Diff_gender;
    BOOLEAN Diff_ssn;
    BOOLEAN Diff_home_phone;
    BOOLEAN Diff_alt_phone;
    BOOLEAN Diff_primary_email_address;
    BOOLEAN Diff_prim_range;
    BOOLEAN Diff_predir;
    BOOLEAN Diff_prim_name;
    BOOLEAN Diff_addr_suffix;
    BOOLEAN Diff_postdir;
    BOOLEAN Diff_unit_desig;
    BOOLEAN Diff_sec_range;
    BOOLEAN Diff_city_name;
    BOOLEAN Diff_st;
    BOOLEAN Diff_zip;
    BOOLEAN Diff_zip4;
    BOOLEAN Diff_rec_type;
    BOOLEAN Diff_county;
    BOOLEAN Diff_geo_lat;
    BOOLEAN Diff_geo_long;
    BOOLEAN Diff_msa;
    BOOLEAN Diff_geo_blk;
    BOOLEAN Diff_geo_match;
    BOOLEAN Diff_err_stat;
    BOOLEAN Diff_guardian_fname;
    BOOLEAN Diff_guardian_mname;
    BOOLEAN Diff_guardian_lname;
    BOOLEAN Diff_guardian_dob;
    BOOLEAN Diff_guardian_ssn;
    BOOLEAN Diff_udf1;
    BOOLEAN Diff_udf2;
    BOOLEAN Diff_udf3;
    BOOLEAN Diff_persistent_rid;
    BOOLEAN Diff_global_sid;
    BOOLEAN Diff_record_sid;
    UNSIGNED Num_Diffs;
    SALT311.StrType Val {MAXLENGTH(1024)};
  END;
#uniquename(fd)
  %dl% %fd%(in_left le,in_right ri) := TRANSFORM
    SELF.Diff_nomatch_id := le.nomatch_id <> ri.nomatch_id;
    SELF.Diff_rid := le.rid <> ri.rid;
    SELF.Diff_lexid := le.lexid <> ri.lexid;
    SELF.Diff_lexid_score := le.lexid_score <> ri.lexid_score;
    SELF.Diff_guardian_lexid := le.guardian_lexid <> ri.guardian_lexid;
    SELF.Diff_guardian_lexid_score := le.guardian_lexid_score <> ri.guardian_lexid_score;
    SELF.Diff_crk := le.crk <> ri.crk;
    SELF.Diff_src := le.src <> ri.src;
    SELF.Diff_source_rid := le.source_rid <> ri.source_rid;
    SELF.Diff_dt_first_seen := le.dt_first_seen <> ri.dt_first_seen;
    SELF.Diff_dt_last_seen := le.dt_last_seen <> ri.dt_last_seen;
    SELF.Diff_dt_vendor_first_reported := le.dt_vendor_first_reported <> ri.dt_vendor_first_reported;
    SELF.Diff_dt_vendor_last_reported := le.dt_vendor_last_reported <> ri.dt_vendor_last_reported;
    SELF.Diff_member_id := le.member_id <> ri.member_id;
    SELF.Diff_customer_id := le.customer_id <> ri.customer_id;
    SELF.Diff_account_id := le.account_id <> ri.account_id;
    SELF.Diff_subscriber_id := le.subscriber_id <> ri.subscriber_id;
    SELF.Diff_group_id := le.group_id <> ri.group_id;
    SELF.Diff_relationship_code := le.relationship_code <> ri.relationship_code;
    SELF.Diff_title := le.title <> ri.title;
    SELF.Diff_fname := le.fname <> ri.fname;
    SELF.Diff_mname := le.mname <> ri.mname;
    SELF.Diff_lname := le.lname <> ri.lname;
    SELF.Diff_suffix := le.suffix <> ri.suffix;
    SELF.Diff_input_full_name := le.input_full_name <> ri.input_full_name;
    SELF.Diff_dob := le.dob <> ri.dob;
    SELF.Diff_gender := le.gender <> ri.gender;
    SELF.Diff_ssn := le.ssn <> ri.ssn;
    SELF.Diff_home_phone := le.home_phone <> ri.home_phone;
    SELF.Diff_alt_phone := le.alt_phone <> ri.alt_phone;
    SELF.Diff_primary_email_address := le.primary_email_address <> ri.primary_email_address;
    SELF.Diff_prim_range := le.prim_range <> ri.prim_range;
    SELF.Diff_predir := le.predir <> ri.predir;
    SELF.Diff_prim_name := le.prim_name <> ri.prim_name;
    SELF.Diff_addr_suffix := le.addr_suffix <> ri.addr_suffix;
    SELF.Diff_postdir := le.postdir <> ri.postdir;
    SELF.Diff_unit_desig := le.unit_desig <> ri.unit_desig;
    SELF.Diff_sec_range := le.sec_range <> ri.sec_range;
    SELF.Diff_city_name := le.city_name <> ri.city_name;
    SELF.Diff_st := le.st <> ri.st;
    SELF.Diff_zip := le.zip <> ri.zip;
    SELF.Diff_zip4 := le.zip4 <> ri.zip4;
    SELF.Diff_rec_type := le.rec_type <> ri.rec_type;
    SELF.Diff_county := le.county <> ri.county;
    SELF.Diff_geo_lat := le.geo_lat <> ri.geo_lat;
    SELF.Diff_geo_long := le.geo_long <> ri.geo_long;
    SELF.Diff_msa := le.msa <> ri.msa;
    SELF.Diff_geo_blk := le.geo_blk <> ri.geo_blk;
    SELF.Diff_geo_match := le.geo_match <> ri.geo_match;
    SELF.Diff_err_stat := le.err_stat <> ri.err_stat;
    SELF.Diff_guardian_fname := le.guardian_fname <> ri.guardian_fname;
    SELF.Diff_guardian_mname := le.guardian_mname <> ri.guardian_mname;
    SELF.Diff_guardian_lname := le.guardian_lname <> ri.guardian_lname;
    SELF.Diff_guardian_dob := le.guardian_dob <> ri.guardian_dob;
    SELF.Diff_guardian_ssn := le.guardian_ssn <> ri.guardian_ssn;
    SELF.Diff_udf1 := le.udf1 <> ri.udf1;
    SELF.Diff_udf2 := le.udf2 <> ri.udf2;
    SELF.Diff_udf3 := le.udf3 <> ri.udf3;
    SELF.Diff_persistent_rid := le.persistent_rid <> ri.persistent_rid;
    SELF.Diff_global_sid := le.global_sid <> ri.global_sid;
    SELF.Diff_record_sid := le.record_sid <> ri.record_sid;
    SELF.Val := (SALT311.StrType)evaluate(le,pivot_exp);
    SELF.Num_Diffs := 0+ IF( SELF.Diff_nomatch_id,1,0)+ IF( SELF.Diff_rid,1,0)+ IF( SELF.Diff_lexid,1,0)+ IF( SELF.Diff_lexid_score,1,0)+ IF( SELF.Diff_guardian_lexid,1,0)+ IF( SELF.Diff_guardian_lexid_score,1,0)+ IF( SELF.Diff_crk,1,0)+ IF( SELF.Diff_src,1,0)+ IF( SELF.Diff_source_rid,1,0)+ IF( SELF.Diff_dt_first_seen,1,0)+ IF( SELF.Diff_dt_last_seen,1,0)+ IF( SELF.Diff_dt_vendor_first_reported,1,0)+ IF( SELF.Diff_dt_vendor_last_reported,1,0)+ IF( SELF.Diff_member_id,1,0)+ IF( SELF.Diff_customer_id,1,0)+ IF( SELF.Diff_account_id,1,0)+ IF( SELF.Diff_subscriber_id,1,0)+ IF( SELF.Diff_group_id,1,0)+ IF( SELF.Diff_relationship_code,1,0)+ IF( SELF.Diff_title,1,0)+ IF( SELF.Diff_fname,1,0)+ IF( SELF.Diff_mname,1,0)+ IF( SELF.Diff_lname,1,0)+ IF( SELF.Diff_suffix,1,0)+ IF( SELF.Diff_input_full_name,1,0)+ IF( SELF.Diff_dob,1,0)+ IF( SELF.Diff_gender,1,0)+ IF( SELF.Diff_ssn,1,0)+ IF( SELF.Diff_home_phone,1,0)+ IF( SELF.Diff_alt_phone,1,0)+ IF( SELF.Diff_primary_email_address,1,0)+ IF( SELF.Diff_prim_range,1,0)+ IF( SELF.Diff_predir,1,0)+ IF( SELF.Diff_prim_name,1,0)+ IF( SELF.Diff_addr_suffix,1,0)+ IF( SELF.Diff_postdir,1,0)+ IF( SELF.Diff_unit_desig,1,0)+ IF( SELF.Diff_sec_range,1,0)+ IF( SELF.Diff_city_name,1,0)+ IF( SELF.Diff_st,1,0)+ IF( SELF.Diff_zip,1,0)+ IF( SELF.Diff_zip4,1,0)+ IF( SELF.Diff_rec_type,1,0)+ IF( SELF.Diff_county,1,0)+ IF( SELF.Diff_geo_lat,1,0)+ IF( SELF.Diff_geo_long,1,0)+ IF( SELF.Diff_msa,1,0)+ IF( SELF.Diff_geo_blk,1,0)+ IF( SELF.Diff_geo_match,1,0)+ IF( SELF.Diff_err_stat,1,0)+ IF( SELF.Diff_guardian_fname,1,0)+ IF( SELF.Diff_guardian_mname,1,0)+ IF( SELF.Diff_guardian_lname,1,0)+ IF( SELF.Diff_guardian_dob,1,0)+ IF( SELF.Diff_guardian_ssn,1,0)+ IF( SELF.Diff_udf1,1,0)+ IF( SELF.Diff_udf2,1,0)+ IF( SELF.Diff_udf3,1,0)+ IF( SELF.Diff_persistent_rid,1,0)+ IF( SELF.Diff_global_sid,1,0)+ IF( SELF.Diff_record_sid,1,0);
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
    Count_Diff_nomatch_id := COUNT(GROUP,%Closest%.Diff_nomatch_id);
    Count_Diff_rid := COUNT(GROUP,%Closest%.Diff_rid);
    Count_Diff_lexid := COUNT(GROUP,%Closest%.Diff_lexid);
    Count_Diff_lexid_score := COUNT(GROUP,%Closest%.Diff_lexid_score);
    Count_Diff_guardian_lexid := COUNT(GROUP,%Closest%.Diff_guardian_lexid);
    Count_Diff_guardian_lexid_score := COUNT(GROUP,%Closest%.Diff_guardian_lexid_score);
    Count_Diff_crk := COUNT(GROUP,%Closest%.Diff_crk);
    Count_Diff_src := COUNT(GROUP,%Closest%.Diff_src);
    Count_Diff_source_rid := COUNT(GROUP,%Closest%.Diff_source_rid);
    Count_Diff_dt_first_seen := COUNT(GROUP,%Closest%.Diff_dt_first_seen);
    Count_Diff_dt_last_seen := COUNT(GROUP,%Closest%.Diff_dt_last_seen);
    Count_Diff_dt_vendor_first_reported := COUNT(GROUP,%Closest%.Diff_dt_vendor_first_reported);
    Count_Diff_dt_vendor_last_reported := COUNT(GROUP,%Closest%.Diff_dt_vendor_last_reported);
    Count_Diff_member_id := COUNT(GROUP,%Closest%.Diff_member_id);
    Count_Diff_customer_id := COUNT(GROUP,%Closest%.Diff_customer_id);
    Count_Diff_account_id := COUNT(GROUP,%Closest%.Diff_account_id);
    Count_Diff_subscriber_id := COUNT(GROUP,%Closest%.Diff_subscriber_id);
    Count_Diff_group_id := COUNT(GROUP,%Closest%.Diff_group_id);
    Count_Diff_relationship_code := COUNT(GROUP,%Closest%.Diff_relationship_code);
    Count_Diff_title := COUNT(GROUP,%Closest%.Diff_title);
    Count_Diff_fname := COUNT(GROUP,%Closest%.Diff_fname);
    Count_Diff_mname := COUNT(GROUP,%Closest%.Diff_mname);
    Count_Diff_lname := COUNT(GROUP,%Closest%.Diff_lname);
    Count_Diff_suffix := COUNT(GROUP,%Closest%.Diff_suffix);
    Count_Diff_input_full_name := COUNT(GROUP,%Closest%.Diff_input_full_name);
    Count_Diff_dob := COUNT(GROUP,%Closest%.Diff_dob);
    Count_Diff_gender := COUNT(GROUP,%Closest%.Diff_gender);
    Count_Diff_ssn := COUNT(GROUP,%Closest%.Diff_ssn);
    Count_Diff_home_phone := COUNT(GROUP,%Closest%.Diff_home_phone);
    Count_Diff_alt_phone := COUNT(GROUP,%Closest%.Diff_alt_phone);
    Count_Diff_primary_email_address := COUNT(GROUP,%Closest%.Diff_primary_email_address);
    Count_Diff_prim_range := COUNT(GROUP,%Closest%.Diff_prim_range);
    Count_Diff_predir := COUNT(GROUP,%Closest%.Diff_predir);
    Count_Diff_prim_name := COUNT(GROUP,%Closest%.Diff_prim_name);
    Count_Diff_addr_suffix := COUNT(GROUP,%Closest%.Diff_addr_suffix);
    Count_Diff_postdir := COUNT(GROUP,%Closest%.Diff_postdir);
    Count_Diff_unit_desig := COUNT(GROUP,%Closest%.Diff_unit_desig);
    Count_Diff_sec_range := COUNT(GROUP,%Closest%.Diff_sec_range);
    Count_Diff_city_name := COUNT(GROUP,%Closest%.Diff_city_name);
    Count_Diff_st := COUNT(GROUP,%Closest%.Diff_st);
    Count_Diff_zip := COUNT(GROUP,%Closest%.Diff_zip);
    Count_Diff_zip4 := COUNT(GROUP,%Closest%.Diff_zip4);
    Count_Diff_rec_type := COUNT(GROUP,%Closest%.Diff_rec_type);
    Count_Diff_county := COUNT(GROUP,%Closest%.Diff_county);
    Count_Diff_geo_lat := COUNT(GROUP,%Closest%.Diff_geo_lat);
    Count_Diff_geo_long := COUNT(GROUP,%Closest%.Diff_geo_long);
    Count_Diff_msa := COUNT(GROUP,%Closest%.Diff_msa);
    Count_Diff_geo_blk := COUNT(GROUP,%Closest%.Diff_geo_blk);
    Count_Diff_geo_match := COUNT(GROUP,%Closest%.Diff_geo_match);
    Count_Diff_err_stat := COUNT(GROUP,%Closest%.Diff_err_stat);
    Count_Diff_guardian_fname := COUNT(GROUP,%Closest%.Diff_guardian_fname);
    Count_Diff_guardian_mname := COUNT(GROUP,%Closest%.Diff_guardian_mname);
    Count_Diff_guardian_lname := COUNT(GROUP,%Closest%.Diff_guardian_lname);
    Count_Diff_guardian_dob := COUNT(GROUP,%Closest%.Diff_guardian_dob);
    Count_Diff_guardian_ssn := COUNT(GROUP,%Closest%.Diff_guardian_ssn);
    Count_Diff_udf1 := COUNT(GROUP,%Closest%.Diff_udf1);
    Count_Diff_udf2 := COUNT(GROUP,%Closest%.Diff_udf2);
    Count_Diff_udf3 := COUNT(GROUP,%Closest%.Diff_udf3);
    Count_Diff_persistent_rid := COUNT(GROUP,%Closest%.Diff_persistent_rid);
    Count_Diff_global_sid := COUNT(GROUP,%Closest%.Diff_global_sid);
    Count_Diff_record_sid := COUNT(GROUP,%Closest%.Diff_record_sid);
  END;
  out_counts := table(%Closest%,%AggRec%,true);
ENDMACRO;
END;
