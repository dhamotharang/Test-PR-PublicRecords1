IMPORT SALT311;
EXPORT Fields := MODULE

EXPORT NumFields := 41;

// Processing for each FieldType
EXPORT SALT311.StrType FieldTypeName(UNSIGNED2 i) := CHOOSE(i,'number','alpha','NAME');
EXPORT FieldTypeNum(SALT311.StrType fn) := CASE(fn,'number' => 1,'alpha' => 2,'NAME' => 3,0);

EXPORT MakeFT_number(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringfilter(s0,'0123456789'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_number(SALT311.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT311.StringFilter(s,'0123456789'))));
EXPORT InValidMessageFT_number(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInChars('0123456789'),SALT311.HygieneErrors.Good);

EXPORT MakeFT_alpha(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringtouppercase(s0); // Force to upper case
  s2 := SALT311.stringfilter(s1,'ABCDEFGHIJKLMNOPQRSTUVWXYZ'); // Only allow valid symbols
  RETURN  s2;
END;
EXPORT InValidFT_alpha(SALT311.StrType s) := WHICH(SALT311.stringtouppercase(s)<>s,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT311.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZ'))));
EXPORT InValidMessageFT_alpha(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotCaps,SALT311.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWXYZ'),SALT311.HygieneErrors.Good);

EXPORT MakeFT_NAME(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringtouppercase(s0); // Force to upper case
  s2 := SALT311.stringfilter(s1,'ABCDEFGHIJKLMNOPQRSTUVWXYZ -\''); // Only allow valid symbols
  RETURN  s2;
END;
EXPORT InValidFT_NAME(SALT311.StrType s) := WHICH(SALT311.stringtouppercase(s)<>s,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT311.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZ -\''))));
EXPORT InValidMessageFT_NAME(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotCaps,SALT311.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWXYZ -\''),SALT311.HygieneErrors.Good);


EXPORT SALT311.StrType FieldName(UNSIGNED2 i) := CHOOSE(i,'pflag1','pflag2','pflag3','src','dt_first_seen','dt_last_seen','dt_vendor_last_reported','dt_vendor_first_reported','dt_nonglb_last_seen','rec_type','phone','ssn','dob','title','fname','mname','lname','name_suffix','prim_range','predir','prim_name','suffix','postdir','unit_desig','sec_range','city_name','st','zip','zip4','tnt','valid_ssn','jflag1','jflag2','jflag3','rawaid','dodgy_tracking','address_ind','name_ind','persistent_record_id','ssnum','address');
EXPORT SALT311.StrType FlatName(UNSIGNED2 i) := CHOOSE(i,'pflag1','pflag2','pflag3','src','dt_first_seen','dt_last_seen','dt_vendor_last_reported','dt_vendor_first_reported','dt_nonglb_last_seen','rec_type','phone','ssn','dob','title','fname','mname','lname','name_suffix','prim_range','predir','prim_name','suffix','postdir','unit_desig','sec_range','city_name','st','zip','zip4','tnt','valid_ssn','jflag1','jflag2','jflag3','rawaid','dodgy_tracking','address_ind','name_ind','persistent_record_id','ssnum','address');
EXPORT FieldNum(SALT311.StrType fn) := CASE(fn,'pflag1' => 0,'pflag2' => 1,'pflag3' => 2,'src' => 3,'dt_first_seen' => 4,'dt_last_seen' => 5,'dt_vendor_last_reported' => 6,'dt_vendor_first_reported' => 7,'dt_nonglb_last_seen' => 8,'rec_type' => 9,'phone' => 10,'ssn' => 11,'dob' => 12,'title' => 13,'fname' => 14,'mname' => 15,'lname' => 16,'name_suffix' => 17,'prim_range' => 18,'predir' => 19,'prim_name' => 20,'suffix' => 21,'postdir' => 22,'unit_desig' => 23,'sec_range' => 24,'city_name' => 25,'st' => 26,'zip' => 27,'zip4' => 28,'tnt' => 29,'valid_ssn' => 30,'jflag1' => 31,'jflag2' => 32,'jflag3' => 33,'rawaid' => 34,'dodgy_tracking' => 35,'address_ind' => 36,'name_ind' => 37,'persistent_record_id' => 38,'ssnum' => 39,'address' => 40,0);
EXPORT SET OF SALT311.StrType FieldRules(UNSIGNED2 i) := CHOOSE(i,[],[],[],[],[],[],[],[],[],[],['ALLOW'],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[]);
EXPORT BOOLEAN InBaseLayout(UNSIGNED2 i) := CHOOSE(i,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,FALSE,FALSE,FALSE);

//Individual field level validation


EXPORT Make_pflag1(SALT311.StrType s0) := s0;
EXPORT InValid_pflag1(SALT311.StrType s) := 0;
EXPORT InValidMessage_pflag1(UNSIGNED1 wh) := '';


EXPORT Make_pflag2(SALT311.StrType s0) := s0;
EXPORT InValid_pflag2(SALT311.StrType s) := 0;
EXPORT InValidMessage_pflag2(UNSIGNED1 wh) := '';


EXPORT Make_pflag3(SALT311.StrType s0) := s0;
EXPORT InValid_pflag3(SALT311.StrType s) := 0;
EXPORT InValidMessage_pflag3(UNSIGNED1 wh) := '';


EXPORT Make_src(SALT311.StrType s0) := s0;
EXPORT InValid_src(SALT311.StrType s) := 0;
EXPORT InValidMessage_src(UNSIGNED1 wh) := '';


EXPORT Make_dt_first_seen(SALT311.StrType s0) := s0;
EXPORT InValid_dt_first_seen(SALT311.StrType s) := 0;
EXPORT InValidMessage_dt_first_seen(UNSIGNED1 wh) := '';


EXPORT Make_dt_last_seen(SALT311.StrType s0) := s0;
EXPORT InValid_dt_last_seen(SALT311.StrType s) := 0;
EXPORT InValidMessage_dt_last_seen(UNSIGNED1 wh) := '';


EXPORT Make_dt_vendor_last_reported(SALT311.StrType s0) := s0;
EXPORT InValid_dt_vendor_last_reported(SALT311.StrType s) := 0;
EXPORT InValidMessage_dt_vendor_last_reported(UNSIGNED1 wh) := '';


EXPORT Make_dt_vendor_first_reported(SALT311.StrType s0) := s0;
EXPORT InValid_dt_vendor_first_reported(SALT311.StrType s) := 0;
EXPORT InValidMessage_dt_vendor_first_reported(UNSIGNED1 wh) := '';


EXPORT Make_dt_nonglb_last_seen(SALT311.StrType s0) := s0;
EXPORT InValid_dt_nonglb_last_seen(SALT311.StrType s) := 0;
EXPORT InValidMessage_dt_nonglb_last_seen(UNSIGNED1 wh) := '';


EXPORT Make_rec_type(SALT311.StrType s0) := s0;
EXPORT InValid_rec_type(SALT311.StrType s) := 0;
EXPORT InValidMessage_rec_type(UNSIGNED1 wh) := '';


EXPORT Make_phone(SALT311.StrType s0) := MakeFT_number(s0);
EXPORT InValid_phone(SALT311.StrType s) := InValidFT_number(s);
EXPORT InValidMessage_phone(UNSIGNED1 wh) := InValidMessageFT_number(wh);


EXPORT Make_ssn(SALT311.StrType s0) := s0;
EXPORT InValid_ssn(SALT311.StrType s) := 0;
EXPORT InValidMessage_ssn(UNSIGNED1 wh) := '';


EXPORT Make_dob(SALT311.StrType s0) := s0;
EXPORT InValid_dob(SALT311.StrType s) := 0;
EXPORT InValidMessage_dob(UNSIGNED1 wh) := '';


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


EXPORT Make_prim_range(SALT311.StrType s0) := s0;
EXPORT InValid_prim_range(SALT311.StrType s) := 0;
EXPORT InValidMessage_prim_range(UNSIGNED1 wh) := '';


EXPORT Make_predir(SALT311.StrType s0) := s0;
EXPORT InValid_predir(SALT311.StrType s) := 0;
EXPORT InValidMessage_predir(UNSIGNED1 wh) := '';


EXPORT Make_prim_name(SALT311.StrType s0) := s0;
EXPORT InValid_prim_name(SALT311.StrType s) := 0;
EXPORT InValidMessage_prim_name(UNSIGNED1 wh) := '';


EXPORT Make_suffix(SALT311.StrType s0) := s0;
EXPORT InValid_suffix(SALT311.StrType s) := 0;
EXPORT InValidMessage_suffix(UNSIGNED1 wh) := '';


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


EXPORT Make_tnt(SALT311.StrType s0) := s0;
EXPORT InValid_tnt(SALT311.StrType s) := 0;
EXPORT InValidMessage_tnt(UNSIGNED1 wh) := '';


EXPORT Make_valid_ssn(SALT311.StrType s0) := s0;
EXPORT InValid_valid_ssn(SALT311.StrType s) := 0;
EXPORT InValidMessage_valid_ssn(UNSIGNED1 wh) := '';


EXPORT Make_jflag1(SALT311.StrType s0) := s0;
EXPORT InValid_jflag1(SALT311.StrType s) := 0;
EXPORT InValidMessage_jflag1(UNSIGNED1 wh) := '';


EXPORT Make_jflag2(SALT311.StrType s0) := s0;
EXPORT InValid_jflag2(SALT311.StrType s) := 0;
EXPORT InValidMessage_jflag2(UNSIGNED1 wh) := '';


EXPORT Make_jflag3(SALT311.StrType s0) := s0;
EXPORT InValid_jflag3(SALT311.StrType s) := 0;
EXPORT InValidMessage_jflag3(UNSIGNED1 wh) := '';


EXPORT Make_rawaid(SALT311.StrType s0) := s0;
EXPORT InValid_rawaid(SALT311.StrType s) := 0;
EXPORT InValidMessage_rawaid(UNSIGNED1 wh) := '';


EXPORT Make_dodgy_tracking(SALT311.StrType s0) := s0;
EXPORT InValid_dodgy_tracking(SALT311.StrType s) := 0;
EXPORT InValidMessage_dodgy_tracking(UNSIGNED1 wh) := '';


EXPORT Make_address_ind(SALT311.StrType s0) := s0;
EXPORT InValid_address_ind(SALT311.StrType s) := 0;
EXPORT InValidMessage_address_ind(UNSIGNED1 wh) := '';


EXPORT Make_name_ind(SALT311.StrType s0) := s0;
EXPORT InValid_name_ind(SALT311.StrType s) := 0;
EXPORT InValidMessage_name_ind(UNSIGNED1 wh) := '';


EXPORT Make_persistent_record_id(SALT311.StrType s0) := s0;
EXPORT InValid_persistent_record_id(SALT311.StrType s) := 0;
EXPORT InValidMessage_persistent_record_id(UNSIGNED1 wh) := '';


EXPORT Make_ssnum(SALT311.StrType s0) := s0;
EXPORT InValid_ssnum(SALT311.StrType ssn,SALT311.StrType valid_ssn) := WHICH(InValid_ssn(ssn)>0,InValid_valid_ssn(valid_ssn)>0);
EXPORT InValidMessage_ssnum(UNSIGNED1 wh) := '';

EXPORT Make_address(SALT311.StrType s0) := s0;
EXPORT InValid_address(SALT311.StrType prim_range,SALT311.StrType predir,SALT311.StrType prim_name,SALT311.StrType suffix,SALT311.StrType postdir,SALT311.StrType unit_desig,SALT311.StrType sec_range,SALT311.StrType city_name,SALT311.StrType st,SALT311.StrType zip,SALT311.StrType zip4,SALT311.StrType tnt,SALT311.StrType rawaid,SALT311.StrType dt_first_seen,SALT311.StrType dt_last_seen,SALT311.StrType dt_vendor_first_reported,SALT311.StrType dt_vendor_last_reported) := WHICH(InValid_prim_range(prim_range)>0,InValid_predir(predir)>0,InValid_prim_name(prim_name)>0,InValid_suffix(suffix)>0,InValid_postdir(postdir)>0,InValid_unit_desig(unit_desig)>0,InValid_sec_range(sec_range)>0,InValid_city_name(city_name)>0,InValid_st(st)>0,InValid_zip(zip)>0,InValid_zip4(zip4)>0,InValid_tnt(tnt)>0,InValid_rawaid(rawaid)>0,InValid_dt_first_seen(dt_first_seen)>0,InValid_dt_last_seen(dt_last_seen)>0,InValid_dt_vendor_first_reported(dt_vendor_first_reported)>0,InValid_dt_vendor_last_reported(dt_vendor_last_reported)>0);
EXPORT InValidMessage_address(UNSIGNED1 wh) := '';
// This macro will compute and count field level differences based upon a pivot expression
export MAC_CountDifferencesByPivot(in_left,in_right,pivot_exp,bad_pivots,out_counts) := MACRO
  IMPORT SALT311,Watchdog_best;
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
    BOOLEAN Diff_pflag1;
    BOOLEAN Diff_pflag2;
    BOOLEAN Diff_pflag3;
    BOOLEAN Diff_src;
    BOOLEAN Diff_dt_first_seen;
    BOOLEAN Diff_dt_last_seen;
    BOOLEAN Diff_dt_vendor_last_reported;
    BOOLEAN Diff_dt_vendor_first_reported;
    BOOLEAN Diff_dt_nonglb_last_seen;
    BOOLEAN Diff_rec_type;
    BOOLEAN Diff_phone;
    BOOLEAN Diff_ssn;
    BOOLEAN Diff_dob;
    BOOLEAN Diff_title;
    BOOLEAN Diff_fname;
    BOOLEAN Diff_mname;
    BOOLEAN Diff_lname;
    BOOLEAN Diff_name_suffix;
    BOOLEAN Diff_prim_range;
    BOOLEAN Diff_predir;
    BOOLEAN Diff_prim_name;
    BOOLEAN Diff_suffix;
    BOOLEAN Diff_postdir;
    BOOLEAN Diff_unit_desig;
    BOOLEAN Diff_sec_range;
    BOOLEAN Diff_city_name;
    BOOLEAN Diff_st;
    BOOLEAN Diff_zip;
    BOOLEAN Diff_zip4;
    BOOLEAN Diff_tnt;
    BOOLEAN Diff_valid_ssn;
    BOOLEAN Diff_jflag1;
    BOOLEAN Diff_jflag2;
    BOOLEAN Diff_jflag3;
    BOOLEAN Diff_rawaid;
    BOOLEAN Diff_dodgy_tracking;
    BOOLEAN Diff_address_ind;
    BOOLEAN Diff_name_ind;
    BOOLEAN Diff_persistent_record_id;
    SALT311.StrType SourceField {MAXLENGTH(30)};
    UNSIGNED Num_Diffs;
    SALT311.StrType Val {MAXLENGTH(1024)};
  END;
#uniquename(fd)
  %dl% %fd%(in_left le,in_right ri) := TRANSFORM
    SELF.Diff_pflag1 := le.pflag1 <> ri.pflag1;
    SELF.Diff_pflag2 := le.pflag2 <> ri.pflag2;
    SELF.Diff_pflag3 := le.pflag3 <> ri.pflag3;
    SELF.Diff_src := le.src <> ri.src;
    SELF.Diff_dt_first_seen := le.dt_first_seen <> ri.dt_first_seen;
    SELF.Diff_dt_last_seen := le.dt_last_seen <> ri.dt_last_seen;
    SELF.Diff_dt_vendor_last_reported := le.dt_vendor_last_reported <> ri.dt_vendor_last_reported;
    SELF.Diff_dt_vendor_first_reported := le.dt_vendor_first_reported <> ri.dt_vendor_first_reported;
    SELF.Diff_dt_nonglb_last_seen := le.dt_nonglb_last_seen <> ri.dt_nonglb_last_seen;
    SELF.Diff_rec_type := le.rec_type <> ri.rec_type;
    SELF.Diff_phone := le.phone <> ri.phone;
    SELF.Diff_ssn := le.ssn <> ri.ssn;
    SELF.Diff_dob := le.dob <> ri.dob;
    SELF.Diff_title := le.title <> ri.title;
    SELF.Diff_fname := le.fname <> ri.fname;
    SELF.Diff_mname := le.mname <> ri.mname;
    SELF.Diff_lname := le.lname <> ri.lname;
    SELF.Diff_name_suffix := le.name_suffix <> ri.name_suffix;
    SELF.Diff_prim_range := le.prim_range <> ri.prim_range;
    SELF.Diff_predir := le.predir <> ri.predir;
    SELF.Diff_prim_name := le.prim_name <> ri.prim_name;
    SELF.Diff_suffix := le.suffix <> ri.suffix;
    SELF.Diff_postdir := le.postdir <> ri.postdir;
    SELF.Diff_unit_desig := le.unit_desig <> ri.unit_desig;
    SELF.Diff_sec_range := le.sec_range <> ri.sec_range;
    SELF.Diff_city_name := le.city_name <> ri.city_name;
    SELF.Diff_st := le.st <> ri.st;
    SELF.Diff_zip := le.zip <> ri.zip;
    SELF.Diff_zip4 := le.zip4 <> ri.zip4;
    SELF.Diff_tnt := le.tnt <> ri.tnt;
    SELF.Diff_valid_ssn := le.valid_ssn <> ri.valid_ssn;
    SELF.Diff_jflag1 := le.jflag1 <> ri.jflag1;
    SELF.Diff_jflag2 := le.jflag2 <> ri.jflag2;
    SELF.Diff_jflag3 := le.jflag3 <> ri.jflag3;
    SELF.Diff_rawaid := le.rawaid <> ri.rawaid;
    SELF.Diff_dodgy_tracking := le.dodgy_tracking <> ri.dodgy_tracking;
    SELF.Diff_address_ind := le.address_ind <> ri.address_ind;
    SELF.Diff_name_ind := le.name_ind <> ri.name_ind;
    SELF.Diff_persistent_record_id := le.persistent_record_id <> ri.persistent_record_id;
    SELF.Val := (SALT311.StrType)evaluate(le,pivot_exp);
    SELF.SourceField := le.src;
    SELF.Num_Diffs := 0+ IF( SELF.Diff_pflag1,1,0)+ IF( SELF.Diff_pflag2,1,0)+ IF( SELF.Diff_pflag3,1,0)+ IF( SELF.Diff_src,1,0)+ IF( SELF.Diff_dt_first_seen,1,0)+ IF( SELF.Diff_dt_last_seen,1,0)+ IF( SELF.Diff_dt_vendor_last_reported,1,0)+ IF( SELF.Diff_dt_vendor_first_reported,1,0)+ IF( SELF.Diff_dt_nonglb_last_seen,1,0)+ IF( SELF.Diff_rec_type,1,0)+ IF( SELF.Diff_phone,1,0)+ IF( SELF.Diff_ssn,1,0)+ IF( SELF.Diff_dob,1,0)+ IF( SELF.Diff_title,1,0)+ IF( SELF.Diff_fname,1,0)+ IF( SELF.Diff_mname,1,0)+ IF( SELF.Diff_lname,1,0)+ IF( SELF.Diff_name_suffix,1,0)+ IF( SELF.Diff_prim_range,1,0)+ IF( SELF.Diff_predir,1,0)+ IF( SELF.Diff_prim_name,1,0)+ IF( SELF.Diff_suffix,1,0)+ IF( SELF.Diff_postdir,1,0)+ IF( SELF.Diff_unit_desig,1,0)+ IF( SELF.Diff_sec_range,1,0)+ IF( SELF.Diff_city_name,1,0)+ IF( SELF.Diff_st,1,0)+ IF( SELF.Diff_zip,1,0)+ IF( SELF.Diff_zip4,1,0)+ IF( SELF.Diff_tnt,1,0)+ IF( SELF.Diff_valid_ssn,1,0)+ IF( SELF.Diff_jflag1,1,0)+ IF( SELF.Diff_jflag2,1,0)+ IF( SELF.Diff_jflag3,1,0)+ IF( SELF.Diff_rawaid,1,0)+ IF( SELF.Diff_dodgy_tracking,1,0)+ IF( SELF.Diff_address_ind,1,0)+ IF( SELF.Diff_name_ind,1,0)+ IF( SELF.Diff_persistent_record_id,1,0);
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
    Count_Diff_pflag1 := COUNT(GROUP,%Closest%.Diff_pflag1);
    Count_Diff_pflag2 := COUNT(GROUP,%Closest%.Diff_pflag2);
    Count_Diff_pflag3 := COUNT(GROUP,%Closest%.Diff_pflag3);
    Count_Diff_src := COUNT(GROUP,%Closest%.Diff_src);
    Count_Diff_dt_first_seen := COUNT(GROUP,%Closest%.Diff_dt_first_seen);
    Count_Diff_dt_last_seen := COUNT(GROUP,%Closest%.Diff_dt_last_seen);
    Count_Diff_dt_vendor_last_reported := COUNT(GROUP,%Closest%.Diff_dt_vendor_last_reported);
    Count_Diff_dt_vendor_first_reported := COUNT(GROUP,%Closest%.Diff_dt_vendor_first_reported);
    Count_Diff_dt_nonglb_last_seen := COUNT(GROUP,%Closest%.Diff_dt_nonglb_last_seen);
    Count_Diff_rec_type := COUNT(GROUP,%Closest%.Diff_rec_type);
    Count_Diff_phone := COUNT(GROUP,%Closest%.Diff_phone);
    Count_Diff_ssn := COUNT(GROUP,%Closest%.Diff_ssn);
    Count_Diff_dob := COUNT(GROUP,%Closest%.Diff_dob);
    Count_Diff_title := COUNT(GROUP,%Closest%.Diff_title);
    Count_Diff_fname := COUNT(GROUP,%Closest%.Diff_fname);
    Count_Diff_mname := COUNT(GROUP,%Closest%.Diff_mname);
    Count_Diff_lname := COUNT(GROUP,%Closest%.Diff_lname);
    Count_Diff_name_suffix := COUNT(GROUP,%Closest%.Diff_name_suffix);
    Count_Diff_prim_range := COUNT(GROUP,%Closest%.Diff_prim_range);
    Count_Diff_predir := COUNT(GROUP,%Closest%.Diff_predir);
    Count_Diff_prim_name := COUNT(GROUP,%Closest%.Diff_prim_name);
    Count_Diff_suffix := COUNT(GROUP,%Closest%.Diff_suffix);
    Count_Diff_postdir := COUNT(GROUP,%Closest%.Diff_postdir);
    Count_Diff_unit_desig := COUNT(GROUP,%Closest%.Diff_unit_desig);
    Count_Diff_sec_range := COUNT(GROUP,%Closest%.Diff_sec_range);
    Count_Diff_city_name := COUNT(GROUP,%Closest%.Diff_city_name);
    Count_Diff_st := COUNT(GROUP,%Closest%.Diff_st);
    Count_Diff_zip := COUNT(GROUP,%Closest%.Diff_zip);
    Count_Diff_zip4 := COUNT(GROUP,%Closest%.Diff_zip4);
    Count_Diff_tnt := COUNT(GROUP,%Closest%.Diff_tnt);
    Count_Diff_valid_ssn := COUNT(GROUP,%Closest%.Diff_valid_ssn);
    Count_Diff_jflag1 := COUNT(GROUP,%Closest%.Diff_jflag1);
    Count_Diff_jflag2 := COUNT(GROUP,%Closest%.Diff_jflag2);
    Count_Diff_jflag3 := COUNT(GROUP,%Closest%.Diff_jflag3);
    Count_Diff_rawaid := COUNT(GROUP,%Closest%.Diff_rawaid);
    Count_Diff_dodgy_tracking := COUNT(GROUP,%Closest%.Diff_dodgy_tracking);
    Count_Diff_address_ind := COUNT(GROUP,%Closest%.Diff_address_ind);
    Count_Diff_name_ind := COUNT(GROUP,%Closest%.Diff_name_ind);
    Count_Diff_persistent_record_id := COUNT(GROUP,%Closest%.Diff_persistent_record_id);
    %Closest%.SourceField;
  END;
  out_counts := table(%Closest%,%AggRec%,SourceField,few);
ENDMACRO;
// Now determine the consistency of the identifiers
EXPORT UIDConsistency(infile) := FUNCTIONMACRO
  IMPORT Watchdog_best,SALT311;
  f := TABLE(infile,{rid,did}) : GLOBAL; // Consistent type independent of input
  m := MODULE
    r := RECORD
      UNSIGNED rid_null0 := COUNT(GROUP,(UNSIGNED)f.rid=0);
      UNSIGNED rid_belowparent0 := COUNT(GROUP,(UNSIGNED)f.rid<(UNSIGNED)f.did);
      UNSIGNED rid_atparent := COUNT(GROUP,(UNSIGNED)f.did=(UNSIGNED)f.rid);
      UNSIGNED did_null0 := COUNT(GROUP,(UNSIGNED)f.did=0);
    END;
    EXPORT Basic0 := TABLE(f,r);
    EXPORT rid_Clusters := SALT311.MOD_ClusterStats.Counts(f,rid);
    EXPORT did_Clusters := SALT311.MOD_ClusterStats.Counts(f,did);
    EXPORT IdCounts := DATASET([{'rid_Cnt', SUM(rid_Clusters,NumberOfClusters)},{'did_Cnt', SUM(did_Clusters,NumberOfClusters)}],{STRING10 Count_Type, UNSIGNED Cnt}); // The counts of each ID
    // For deeper debugging; provide the unbased parents
    bases := f((UNSIGNED)did=(UNSIGNED)rid); // Get the bases
    EXPORT did_Unbased := JOIN(f(did<>0),bases,LEFT.did=RIGHT.did,TRANSFORM(LEFT),LEFT ONLY,HASH);
    // Children with two parents
    f_thin := TABLE(f(rid<>0,did<>0),{rid,did},rid,did,MERGE);
    EXPORT rid_Twoparents := DEDUP(JOIN(f_thin,f_thin,LEFT.rid=RIGHT.rid AND LEFT.did>RIGHT.did,TRANSFORM({SALT311.UIDType did1,SALT311.UIDType rid,SALT311.UIDType did2},SELF.did1:=LEFT.did,SELF.did2:=RIGHT.did,SELF.rid:=LEFT.rid),HASH),WHOLE RECORD,ALL);
    // Now compute the more involved consistency checks
    r := RECORD
      {Basic0} AND NOT [rid_atparent];
      INTEGER did_unbased0 := IdCounts[2].Cnt-Basic0.rid_atparent-IF(Basic0.did_null0>0,1,0);
      INTEGER rid_Twoparents0 := COUNT(rid_Twoparents);
    END;
    Advanced00 := TABLE(Basic0,r);
    Advanced0Layout := {STRING label, INTEGER null0, INTEGER belowparent0, INTEGER unbased0, INTEGER Twoparents0};
    EXPORT Advanced0 := SORT(SALT311.MAC_Pivot(Advanced00,Advanced0Layout), MAP(label='rid'=>0,1));
  END;
  RETURN m;
ENDMACRO;
END;
