IMPORT SALT311;
EXPORT Fields := MODULE
 
EXPORT NumFields := 12;
 
// Processing for each FieldType
EXPORT SALT311.StrType FieldTypeName(UNSIGNED2 i) := CHOOSE(i,'Invalid_Num','Invalid_TB','Invalid_CompanyType','Invalid_dialind','Invalid_PointID');
EXPORT FieldTypeNum(SALT311.StrType fn) := CASE(fn,'Invalid_Num' => 1,'Invalid_TB' => 2,'Invalid_CompanyType' => 3,'Invalid_dialind' => 4,'Invalid_PointID' => 5,0);
 
EXPORT MakeFT_Invalid_Num(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringfilter(s0,'0123456789'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_Invalid_Num(SALT311.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT311.StringFilter(s,'0123456789'))));
EXPORT InValidMessageFT_Invalid_Num(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInChars('0123456789'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_Invalid_TB(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringfilter(s0,'0123456789A'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_Invalid_TB(SALT311.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT311.StringFilter(s,'0123456789A'))));
EXPORT InValidMessageFT_Invalid_TB(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInChars('0123456789A'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_Invalid_CompanyType(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_Invalid_CompanyType(SALT311.StrType s) := WHICH(((SALT311.StrType) s) NOT IN ['0','7','5','1','8','4','6','9','3']);
EXPORT InValidMessageFT_Invalid_CompanyType(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInEnum('0|7|5|1|8|4|6|9|3'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_Invalid_dialind(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_Invalid_dialind(SALT311.StrType s) := WHICH(((SALT311.StrType) s) NOT IN ['1','0']);
EXPORT InValidMessageFT_Invalid_dialind(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInEnum('1|0'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_Invalid_PointID(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_Invalid_PointID(SALT311.StrType s) := WHICH(((SALT311.StrType) s) NOT IN ['0','2','4','6','3','C']);
EXPORT InValidMessageFT_Invalid_PointID(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInEnum('0|2|4|6|3|C'),SALT311.HygieneErrors.Good);
 
EXPORT SALT311.StrType FieldName(UNSIGNED2 i) := CHOOSE(i,'npa','nxx','tb','city','st','ocn','company_type','nxx_type','dial_ind','point_id','lf','zip');
EXPORT SALT311.StrType FlatName(UNSIGNED2 i) := CHOOSE(i,'npa','nxx','tb','city','st','ocn','company_type','nxx_type','dial_ind','point_id','lf','zip');
EXPORT FieldNum(SALT311.StrType fn) := CASE(fn,'npa' => 0,'nxx' => 1,'tb' => 2,'city' => 3,'st' => 4,'ocn' => 5,'company_type' => 6,'nxx_type' => 7,'dial_ind' => 8,'point_id' => 9,'lf' => 10,'zip' => 11,0);
EXPORT SET OF SALT311.StrType FieldRules(UNSIGNED2 i) := CHOOSE(i,['ALLOW'],['ALLOW'],['ALLOW'],[],[],[],['ENUM'],['ALLOW'],['ENUM'],['ENUM'],[],['ALLOW'],[]);
EXPORT BOOLEAN InBaseLayout(UNSIGNED2 i) := CHOOSE(i,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,FALSE);
 
//Individual field level validation
 
EXPORT Make_npa(SALT311.StrType s0) := MakeFT_Invalid_Num(s0);
EXPORT InValid_npa(SALT311.StrType s) := InValidFT_Invalid_Num(s);
EXPORT InValidMessage_npa(UNSIGNED1 wh) := InValidMessageFT_Invalid_Num(wh);
 
EXPORT Make_nxx(SALT311.StrType s0) := MakeFT_Invalid_Num(s0);
EXPORT InValid_nxx(SALT311.StrType s) := InValidFT_Invalid_Num(s);
EXPORT InValidMessage_nxx(UNSIGNED1 wh) := InValidMessageFT_Invalid_Num(wh);
 
EXPORT Make_tb(SALT311.StrType s0) := MakeFT_Invalid_TB(s0);
EXPORT InValid_tb(SALT311.StrType s) := InValidFT_Invalid_TB(s);
EXPORT InValidMessage_tb(UNSIGNED1 wh) := InValidMessageFT_Invalid_TB(wh);
 
EXPORT Make_city(SALT311.StrType s0) := s0;
EXPORT InValid_city(SALT311.StrType s) := 0;
EXPORT InValidMessage_city(UNSIGNED1 wh) := '';
 
EXPORT Make_st(SALT311.StrType s0) := s0;
EXPORT InValid_st(SALT311.StrType s) := 0;
EXPORT InValidMessage_st(UNSIGNED1 wh) := '';
 
EXPORT Make_ocn(SALT311.StrType s0) := s0;
EXPORT InValid_ocn(SALT311.StrType s) := 0;
EXPORT InValidMessage_ocn(UNSIGNED1 wh) := '';
 
EXPORT Make_company_type(SALT311.StrType s0) := MakeFT_Invalid_CompanyType(s0);
EXPORT InValid_company_type(SALT311.StrType s) := InValidFT_Invalid_CompanyType(s);
EXPORT InValidMessage_company_type(UNSIGNED1 wh) := InValidMessageFT_Invalid_CompanyType(wh);
 
EXPORT Make_nxx_type(SALT311.StrType s0) := MakeFT_Invalid_Num(s0);
EXPORT InValid_nxx_type(SALT311.StrType s) := InValidFT_Invalid_Num(s);
EXPORT InValidMessage_nxx_type(UNSIGNED1 wh) := InValidMessageFT_Invalid_Num(wh);
 
EXPORT Make_dial_ind(SALT311.StrType s0) := MakeFT_Invalid_dialind(s0);
EXPORT InValid_dial_ind(SALT311.StrType s) := InValidFT_Invalid_dialind(s);
EXPORT InValidMessage_dial_ind(UNSIGNED1 wh) := InValidMessageFT_Invalid_dialind(wh);
 
EXPORT Make_point_id(SALT311.StrType s0) := MakeFT_Invalid_PointID(s0);
EXPORT InValid_point_id(SALT311.StrType s) := InValidFT_Invalid_PointID(s);
EXPORT InValidMessage_point_id(UNSIGNED1 wh) := InValidMessageFT_Invalid_PointID(wh);
 
EXPORT Make_lf(SALT311.StrType s0) := s0;
EXPORT InValid_lf(SALT311.StrType s) := 0;
EXPORT InValidMessage_lf(UNSIGNED1 wh) := '';
 
EXPORT Make_zip(SALT311.StrType s0) := MakeFT_Invalid_Num(s0);
EXPORT InValid_zip(SALT311.StrType s) := InValidFT_Invalid_Num(s);
EXPORT InValidMessage_zip(UNSIGNED1 wh) := InValidMessageFT_Invalid_Num(wh);
 
// This macro will compute and count field level differences based upon a pivot expression
export MAC_CountDifferencesByPivot(in_left,in_right,pivot_exp,bad_pivots,out_counts) := MACRO
  IMPORT SALT311,Scrubs_TelcordiaTPM;
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
    BOOLEAN Diff_npa;
    BOOLEAN Diff_nxx;
    BOOLEAN Diff_tb;
    BOOLEAN Diff_city;
    BOOLEAN Diff_st;
    BOOLEAN Diff_ocn;
    BOOLEAN Diff_company_type;
    BOOLEAN Diff_nxx_type;
    BOOLEAN Diff_dial_ind;
    BOOLEAN Diff_point_id;
    BOOLEAN Diff_lf;
    BOOLEAN Diff_zip;
    UNSIGNED Num_Diffs;
    SALT311.StrType Val {MAXLENGTH(1024)};
  END;
#uniquename(fd)
  %dl% %fd%(in_left le,in_right ri) := TRANSFORM
    SELF.Diff_npa := le.npa <> ri.npa;
    SELF.Diff_nxx := le.nxx <> ri.nxx;
    SELF.Diff_tb := le.tb <> ri.tb;
    SELF.Diff_city := le.city <> ri.city;
    SELF.Diff_st := le.st <> ri.st;
    SELF.Diff_ocn := le.ocn <> ri.ocn;
    SELF.Diff_company_type := le.company_type <> ri.company_type;
    SELF.Diff_nxx_type := le.nxx_type <> ri.nxx_type;
    SELF.Diff_dial_ind := le.dial_ind <> ri.dial_ind;
    SELF.Diff_point_id := le.point_id <> ri.point_id;
    SELF.Diff_lf := le.lf <> ri.lf;
    SELF.Diff_zip := le.zip <> ri.zip;
    SELF.Val := (SALT311.StrType)evaluate(le,pivot_exp);
    SELF.Num_Diffs := 0+ IF( SELF.Diff_npa,1,0)+ IF( SELF.Diff_nxx,1,0)+ IF( SELF.Diff_tb,1,0)+ IF( SELF.Diff_city,1,0)+ IF( SELF.Diff_st,1,0)+ IF( SELF.Diff_ocn,1,0)+ IF( SELF.Diff_company_type,1,0)+ IF( SELF.Diff_nxx_type,1,0)+ IF( SELF.Diff_dial_ind,1,0)+ IF( SELF.Diff_point_id,1,0)+ IF( SELF.Diff_lf,1,0)+ IF( SELF.Diff_zip,1,0);
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
    Count_Diff_npa := COUNT(GROUP,%Closest%.Diff_npa);
    Count_Diff_nxx := COUNT(GROUP,%Closest%.Diff_nxx);
    Count_Diff_tb := COUNT(GROUP,%Closest%.Diff_tb);
    Count_Diff_city := COUNT(GROUP,%Closest%.Diff_city);
    Count_Diff_st := COUNT(GROUP,%Closest%.Diff_st);
    Count_Diff_ocn := COUNT(GROUP,%Closest%.Diff_ocn);
    Count_Diff_company_type := COUNT(GROUP,%Closest%.Diff_company_type);
    Count_Diff_nxx_type := COUNT(GROUP,%Closest%.Diff_nxx_type);
    Count_Diff_dial_ind := COUNT(GROUP,%Closest%.Diff_dial_ind);
    Count_Diff_point_id := COUNT(GROUP,%Closest%.Diff_point_id);
    Count_Diff_lf := COUNT(GROUP,%Closest%.Diff_lf);
    Count_Diff_zip := COUNT(GROUP,%Closest%.Diff_zip);
  END;
  out_counts := table(%Closest%,%AggRec%,true);
ENDMACRO;
END;
