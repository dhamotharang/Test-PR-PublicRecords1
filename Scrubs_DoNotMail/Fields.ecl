IMPORT SALT311;
EXPORT Fields := MODULE
 
EXPORT NumFields := 32;
 
// Processing for each FieldType
EXPORT SALT311.StrType FieldTypeName(UNSIGNED2 i) := CHOOSE(i,'Invalid_Char','Invalid_Num','Invalid_Dir','Invalid_State','Invalid_CR','Invalid_LotOrder','Invalid_RecType','Invalid_ErrStat');
EXPORT FieldTypeNum(SALT311.StrType fn) := CASE(fn,'Invalid_Char' => 1,'Invalid_Num' => 2,'Invalid_Dir' => 3,'Invalid_State' => 4,'Invalid_CR' => 5,'Invalid_LotOrder' => 6,'Invalid_RecType' => 7,'Invalid_ErrStat' => 8,0);
 
EXPORT MakeFT_Invalid_Char(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringfilter(s0,'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789.-\'/ &'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_Invalid_Char(SALT311.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT311.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789.-\'/ &'))));
EXPORT InValidMessageFT_Invalid_Char(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789.-\'/ &'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_Invalid_Num(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringfilter(s0,'0123456789 '); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_Invalid_Num(SALT311.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT311.StringFilter(s,'0123456789 '))));
EXPORT InValidMessageFT_Invalid_Num(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInChars('0123456789 '),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_Invalid_Dir(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_Invalid_Dir(SALT311.StrType s) := WHICH(((SALT311.StrType) s) NOT IN ['W','E','N','S','SW','NE','NW','SE','']);
EXPORT InValidMessageFT_Invalid_Dir(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInEnum('W|E|N|S|SW|NE|NW|SE|'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_Invalid_State(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringfilter(s0,'ABCDEFGHIJKLMNOPQRSTUVWXYZ'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_Invalid_State(SALT311.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT311.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZ'))));
EXPORT InValidMessageFT_Invalid_State(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWXYZ'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_Invalid_CR(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_Invalid_CR(SALT311.StrType s) := WHICH(((SALT311.StrType) s) NOT IN ['D','B','C','']);
EXPORT InValidMessageFT_Invalid_CR(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInEnum('D|B|C|'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_Invalid_LotOrder(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_Invalid_LotOrder(SALT311.StrType s) := WHICH(((SALT311.StrType) s) NOT IN ['A','D','']);
EXPORT InValidMessageFT_Invalid_LotOrder(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInEnum('A|D|'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_Invalid_RecType(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_Invalid_RecType(SALT311.StrType s) := WHICH(((SALT311.StrType) s) NOT IN ['S','H','P','HD','SD','M','F','R','UD','G','RD','']);
EXPORT InValidMessageFT_Invalid_RecType(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInEnum('S|H|P|HD|SD|M|F|R|UD|G|RD|'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_Invalid_ErrStat(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringfilter(s0,'0S281E4A9365BCD7F'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_Invalid_ErrStat(SALT311.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT311.StringFilter(s,'0S281E4A9365BCD7F'))));
EXPORT InValidMessageFT_Invalid_ErrStat(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInChars('0S281E4A9365BCD7F'),SALT311.HygieneErrors.Good);
 
EXPORT SALT311.StrType FieldName(UNSIGNED2 i) := CHOOSE(i,'title','fname','mname','lname','name_suffix','name_score','prim_range','predir','prim_name','addr_suffix','postdir','unit_desig','sec_range','p_city_name','v_city_name','st','zip','zip4','cart','cr_sort_sz','lot','lot_order','dpbc','chk_digit','rec_type','ace_fips_st','fips_county','geo_lat','geo_long','msa','geo_match','err_stat');
EXPORT SALT311.StrType FlatName(UNSIGNED2 i) := CHOOSE(i,'title','fname','mname','lname','name_suffix','name_score','prim_range','predir','prim_name','addr_suffix','postdir','unit_desig','sec_range','p_city_name','v_city_name','st','zip','zip4','cart','cr_sort_sz','lot','lot_order','dpbc','chk_digit','rec_type','ace_fips_st','fips_county','geo_lat','geo_long','msa','geo_match','err_stat');
EXPORT FieldNum(SALT311.StrType fn) := CASE(fn,'title' => 0,'fname' => 1,'mname' => 2,'lname' => 3,'name_suffix' => 4,'name_score' => 5,'prim_range' => 6,'predir' => 7,'prim_name' => 8,'addr_suffix' => 9,'postdir' => 10,'unit_desig' => 11,'sec_range' => 12,'p_city_name' => 13,'v_city_name' => 14,'st' => 15,'zip' => 16,'zip4' => 17,'cart' => 18,'cr_sort_sz' => 19,'lot' => 20,'lot_order' => 21,'dpbc' => 22,'chk_digit' => 23,'rec_type' => 24,'ace_fips_st' => 25,'fips_county' => 26,'geo_lat' => 27,'geo_long' => 28,'msa' => 29,'geo_match' => 30,'err_stat' => 31,0);
EXPORT SET OF SALT311.StrType FieldRules(UNSIGNED2 i) := CHOOSE(i,['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ENUM'],['ALLOW'],['ALLOW'],['ENUM'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ENUM'],['ALLOW'],['ENUM'],['ALLOW'],['ALLOW'],['ENUM'],['ALLOW'],['ALLOW'],[],[],[],['ALLOW'],[],[]);
EXPORT BOOLEAN InBaseLayout(UNSIGNED2 i) := CHOOSE(i,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,FALSE);
 
//Individual field level validation
 
EXPORT Make_title(SALT311.StrType s0) := MakeFT_Invalid_Char(s0);
EXPORT InValid_title(SALT311.StrType s) := InValidFT_Invalid_Char(s);
EXPORT InValidMessage_title(UNSIGNED1 wh) := InValidMessageFT_Invalid_Char(wh);
 
EXPORT Make_fname(SALT311.StrType s0) := MakeFT_Invalid_Char(s0);
EXPORT InValid_fname(SALT311.StrType s) := InValidFT_Invalid_Char(s);
EXPORT InValidMessage_fname(UNSIGNED1 wh) := InValidMessageFT_Invalid_Char(wh);
 
EXPORT Make_mname(SALT311.StrType s0) := MakeFT_Invalid_Char(s0);
EXPORT InValid_mname(SALT311.StrType s) := InValidFT_Invalid_Char(s);
EXPORT InValidMessage_mname(UNSIGNED1 wh) := InValidMessageFT_Invalid_Char(wh);
 
EXPORT Make_lname(SALT311.StrType s0) := MakeFT_Invalid_Char(s0);
EXPORT InValid_lname(SALT311.StrType s) := InValidFT_Invalid_Char(s);
EXPORT InValidMessage_lname(UNSIGNED1 wh) := InValidMessageFT_Invalid_Char(wh);
 
EXPORT Make_name_suffix(SALT311.StrType s0) := MakeFT_Invalid_Char(s0);
EXPORT InValid_name_suffix(SALT311.StrType s) := InValidFT_Invalid_Char(s);
EXPORT InValidMessage_name_suffix(UNSIGNED1 wh) := InValidMessageFT_Invalid_Char(wh);
 
EXPORT Make_name_score(SALT311.StrType s0) := MakeFT_Invalid_Num(s0);
EXPORT InValid_name_score(SALT311.StrType s) := InValidFT_Invalid_Num(s);
EXPORT InValidMessage_name_score(UNSIGNED1 wh) := InValidMessageFT_Invalid_Num(wh);
 
EXPORT Make_prim_range(SALT311.StrType s0) := MakeFT_Invalid_Char(s0);
EXPORT InValid_prim_range(SALT311.StrType s) := InValidFT_Invalid_Char(s);
EXPORT InValidMessage_prim_range(UNSIGNED1 wh) := InValidMessageFT_Invalid_Char(wh);
 
EXPORT Make_predir(SALT311.StrType s0) := MakeFT_Invalid_Dir(s0);
EXPORT InValid_predir(SALT311.StrType s) := InValidFT_Invalid_Dir(s);
EXPORT InValidMessage_predir(UNSIGNED1 wh) := InValidMessageFT_Invalid_Dir(wh);
 
EXPORT Make_prim_name(SALT311.StrType s0) := MakeFT_Invalid_Char(s0);
EXPORT InValid_prim_name(SALT311.StrType s) := InValidFT_Invalid_Char(s);
EXPORT InValidMessage_prim_name(UNSIGNED1 wh) := InValidMessageFT_Invalid_Char(wh);
 
EXPORT Make_addr_suffix(SALT311.StrType s0) := MakeFT_Invalid_Char(s0);
EXPORT InValid_addr_suffix(SALT311.StrType s) := InValidFT_Invalid_Char(s);
EXPORT InValidMessage_addr_suffix(UNSIGNED1 wh) := InValidMessageFT_Invalid_Char(wh);
 
EXPORT Make_postdir(SALT311.StrType s0) := MakeFT_Invalid_Dir(s0);
EXPORT InValid_postdir(SALT311.StrType s) := InValidFT_Invalid_Dir(s);
EXPORT InValidMessage_postdir(UNSIGNED1 wh) := InValidMessageFT_Invalid_Dir(wh);
 
EXPORT Make_unit_desig(SALT311.StrType s0) := MakeFT_Invalid_Char(s0);
EXPORT InValid_unit_desig(SALT311.StrType s) := InValidFT_Invalid_Char(s);
EXPORT InValidMessage_unit_desig(UNSIGNED1 wh) := InValidMessageFT_Invalid_Char(wh);
 
EXPORT Make_sec_range(SALT311.StrType s0) := MakeFT_Invalid_Char(s0);
EXPORT InValid_sec_range(SALT311.StrType s) := InValidFT_Invalid_Char(s);
EXPORT InValidMessage_sec_range(UNSIGNED1 wh) := InValidMessageFT_Invalid_Char(wh);
 
EXPORT Make_p_city_name(SALT311.StrType s0) := MakeFT_Invalid_Char(s0);
EXPORT InValid_p_city_name(SALT311.StrType s) := InValidFT_Invalid_Char(s);
EXPORT InValidMessage_p_city_name(UNSIGNED1 wh) := InValidMessageFT_Invalid_Char(wh);
 
EXPORT Make_v_city_name(SALT311.StrType s0) := MakeFT_Invalid_Char(s0);
EXPORT InValid_v_city_name(SALT311.StrType s) := InValidFT_Invalid_Char(s);
EXPORT InValidMessage_v_city_name(UNSIGNED1 wh) := InValidMessageFT_Invalid_Char(wh);
 
EXPORT Make_st(SALT311.StrType s0) := MakeFT_Invalid_State(s0);
EXPORT InValid_st(SALT311.StrType s) := InValidFT_Invalid_State(s);
EXPORT InValidMessage_st(UNSIGNED1 wh) := InValidMessageFT_Invalid_State(wh);
 
EXPORT Make_zip(SALT311.StrType s0) := MakeFT_Invalid_Num(s0);
EXPORT InValid_zip(SALT311.StrType s) := InValidFT_Invalid_Num(s);
EXPORT InValidMessage_zip(UNSIGNED1 wh) := InValidMessageFT_Invalid_Num(wh);
 
EXPORT Make_zip4(SALT311.StrType s0) := MakeFT_Invalid_Num(s0);
EXPORT InValid_zip4(SALT311.StrType s) := InValidFT_Invalid_Num(s);
EXPORT InValidMessage_zip4(UNSIGNED1 wh) := InValidMessageFT_Invalid_Num(wh);
 
EXPORT Make_cart(SALT311.StrType s0) := MakeFT_Invalid_Char(s0);
EXPORT InValid_cart(SALT311.StrType s) := InValidFT_Invalid_Char(s);
EXPORT InValidMessage_cart(UNSIGNED1 wh) := InValidMessageFT_Invalid_Char(wh);
 
EXPORT Make_cr_sort_sz(SALT311.StrType s0) := MakeFT_Invalid_CR(s0);
EXPORT InValid_cr_sort_sz(SALT311.StrType s) := InValidFT_Invalid_CR(s);
EXPORT InValidMessage_cr_sort_sz(UNSIGNED1 wh) := InValidMessageFT_Invalid_CR(wh);
 
EXPORT Make_lot(SALT311.StrType s0) := MakeFT_Invalid_Num(s0);
EXPORT InValid_lot(SALT311.StrType s) := InValidFT_Invalid_Num(s);
EXPORT InValidMessage_lot(UNSIGNED1 wh) := InValidMessageFT_Invalid_Num(wh);
 
EXPORT Make_lot_order(SALT311.StrType s0) := MakeFT_Invalid_LotOrder(s0);
EXPORT InValid_lot_order(SALT311.StrType s) := InValidFT_Invalid_LotOrder(s);
EXPORT InValidMessage_lot_order(UNSIGNED1 wh) := InValidMessageFT_Invalid_LotOrder(wh);
 
EXPORT Make_dpbc(SALT311.StrType s0) := MakeFT_Invalid_Num(s0);
EXPORT InValid_dpbc(SALT311.StrType s) := InValidFT_Invalid_Num(s);
EXPORT InValidMessage_dpbc(UNSIGNED1 wh) := InValidMessageFT_Invalid_Num(wh);
 
EXPORT Make_chk_digit(SALT311.StrType s0) := MakeFT_Invalid_Num(s0);
EXPORT InValid_chk_digit(SALT311.StrType s) := InValidFT_Invalid_Num(s);
EXPORT InValidMessage_chk_digit(UNSIGNED1 wh) := InValidMessageFT_Invalid_Num(wh);
 
EXPORT Make_rec_type(SALT311.StrType s0) := MakeFT_Invalid_RecType(s0);
EXPORT InValid_rec_type(SALT311.StrType s) := InValidFT_Invalid_RecType(s);
EXPORT InValidMessage_rec_type(UNSIGNED1 wh) := InValidMessageFT_Invalid_RecType(wh);
 
EXPORT Make_ace_fips_st(SALT311.StrType s0) := MakeFT_Invalid_Num(s0);
EXPORT InValid_ace_fips_st(SALT311.StrType s) := InValidFT_Invalid_Num(s);
EXPORT InValidMessage_ace_fips_st(UNSIGNED1 wh) := InValidMessageFT_Invalid_Num(wh);
 
EXPORT Make_fips_county(SALT311.StrType s0) := MakeFT_Invalid_Num(s0);
EXPORT InValid_fips_county(SALT311.StrType s) := InValidFT_Invalid_Num(s);
EXPORT InValidMessage_fips_county(UNSIGNED1 wh) := InValidMessageFT_Invalid_Num(wh);
 
EXPORT Make_geo_lat(SALT311.StrType s0) := s0;
EXPORT InValid_geo_lat(SALT311.StrType s) := 0;
EXPORT InValidMessage_geo_lat(UNSIGNED1 wh) := '';
 
EXPORT Make_geo_long(SALT311.StrType s0) := s0;
EXPORT InValid_geo_long(SALT311.StrType s) := 0;
EXPORT InValidMessage_geo_long(UNSIGNED1 wh) := '';
 
EXPORT Make_msa(SALT311.StrType s0) := s0;
EXPORT InValid_msa(SALT311.StrType s) := 0;
EXPORT InValidMessage_msa(UNSIGNED1 wh) := '';
 
EXPORT Make_geo_match(SALT311.StrType s0) := MakeFT_Invalid_Num(s0);
EXPORT InValid_geo_match(SALT311.StrType s) := InValidFT_Invalid_Num(s);
EXPORT InValidMessage_geo_match(UNSIGNED1 wh) := InValidMessageFT_Invalid_Num(wh);
 
EXPORT Make_err_stat(SALT311.StrType s0) := s0;
EXPORT InValid_err_stat(SALT311.StrType s) := 0;
EXPORT InValidMessage_err_stat(UNSIGNED1 wh) := '';
 
// This macro will compute and count field level differences based upon a pivot expression
export MAC_CountDifferencesByPivot(in_left,in_right,pivot_exp,bad_pivots,out_counts) := MACRO
  IMPORT SALT311,Scrubs_DoNotMail;
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
    BOOLEAN Diff_dpbc;
    BOOLEAN Diff_chk_digit;
    BOOLEAN Diff_rec_type;
    BOOLEAN Diff_ace_fips_st;
    BOOLEAN Diff_fips_county;
    BOOLEAN Diff_geo_lat;
    BOOLEAN Diff_geo_long;
    BOOLEAN Diff_msa;
    BOOLEAN Diff_geo_match;
    BOOLEAN Diff_err_stat;
    UNSIGNED Num_Diffs;
    SALT311.StrType Val {MAXLENGTH(1024)};
  END;
#uniquename(fd)
  %dl% %fd%(in_left le,in_right ri) := TRANSFORM
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
    SELF.Diff_dpbc := le.dpbc <> ri.dpbc;
    SELF.Diff_chk_digit := le.chk_digit <> ri.chk_digit;
    SELF.Diff_rec_type := le.rec_type <> ri.rec_type;
    SELF.Diff_ace_fips_st := le.ace_fips_st <> ri.ace_fips_st;
    SELF.Diff_fips_county := le.fips_county <> ri.fips_county;
    SELF.Diff_geo_lat := le.geo_lat <> ri.geo_lat;
    SELF.Diff_geo_long := le.geo_long <> ri.geo_long;
    SELF.Diff_msa := le.msa <> ri.msa;
    SELF.Diff_geo_match := le.geo_match <> ri.geo_match;
    SELF.Diff_err_stat := le.err_stat <> ri.err_stat;
    SELF.Val := (SALT311.StrType)evaluate(le,pivot_exp);
    SELF.Num_Diffs := 0+ IF( SELF.Diff_title,1,0)+ IF( SELF.Diff_fname,1,0)+ IF( SELF.Diff_mname,1,0)+ IF( SELF.Diff_lname,1,0)+ IF( SELF.Diff_name_suffix,1,0)+ IF( SELF.Diff_name_score,1,0)+ IF( SELF.Diff_prim_range,1,0)+ IF( SELF.Diff_predir,1,0)+ IF( SELF.Diff_prim_name,1,0)+ IF( SELF.Diff_addr_suffix,1,0)+ IF( SELF.Diff_postdir,1,0)+ IF( SELF.Diff_unit_desig,1,0)+ IF( SELF.Diff_sec_range,1,0)+ IF( SELF.Diff_p_city_name,1,0)+ IF( SELF.Diff_v_city_name,1,0)+ IF( SELF.Diff_st,1,0)+ IF( SELF.Diff_zip,1,0)+ IF( SELF.Diff_zip4,1,0)+ IF( SELF.Diff_cart,1,0)+ IF( SELF.Diff_cr_sort_sz,1,0)+ IF( SELF.Diff_lot,1,0)+ IF( SELF.Diff_lot_order,1,0)+ IF( SELF.Diff_dpbc,1,0)+ IF( SELF.Diff_chk_digit,1,0)+ IF( SELF.Diff_rec_type,1,0)+ IF( SELF.Diff_ace_fips_st,1,0)+ IF( SELF.Diff_fips_county,1,0)+ IF( SELF.Diff_geo_lat,1,0)+ IF( SELF.Diff_geo_long,1,0)+ IF( SELF.Diff_msa,1,0)+ IF( SELF.Diff_geo_match,1,0)+ IF( SELF.Diff_err_stat,1,0);
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
    Count_Diff_dpbc := COUNT(GROUP,%Closest%.Diff_dpbc);
    Count_Diff_chk_digit := COUNT(GROUP,%Closest%.Diff_chk_digit);
    Count_Diff_rec_type := COUNT(GROUP,%Closest%.Diff_rec_type);
    Count_Diff_ace_fips_st := COUNT(GROUP,%Closest%.Diff_ace_fips_st);
    Count_Diff_fips_county := COUNT(GROUP,%Closest%.Diff_fips_county);
    Count_Diff_geo_lat := COUNT(GROUP,%Closest%.Diff_geo_lat);
    Count_Diff_geo_long := COUNT(GROUP,%Closest%.Diff_geo_long);
    Count_Diff_msa := COUNT(GROUP,%Closest%.Diff_msa);
    Count_Diff_geo_match := COUNT(GROUP,%Closest%.Diff_geo_match);
    Count_Diff_err_stat := COUNT(GROUP,%Closest%.Diff_err_stat);
  END;
  out_counts := table(%Closest%,%AggRec%,true);
ENDMACRO;
END;
