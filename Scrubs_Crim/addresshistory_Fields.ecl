IMPORT SALT311;
EXPORT addresshistory_Fields := MODULE
 
EXPORT NumFields := 11;
 
// Processing for each FieldType
EXPORT SALT311.StrType FieldTypeName(UNSIGNED2 i) := CHOOSE(i,'Invalid_Record_ID','Invalid_State','Invalid_Source_ID','Invalid_ZIP','Invalid_City');
EXPORT FieldTypeNum(SALT311.StrType fn) := CASE(fn,'Invalid_Record_ID' => 1,'Invalid_State' => 2,'Invalid_Source_ID' => 3,'Invalid_ZIP' => 4,'Invalid_City' => 5,0);
 
EXPORT MakeFT_Invalid_Record_ID(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringfilter(s0,'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_Invalid_Record_ID(SALT311.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT311.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789'))));
EXPORT InValidMessageFT_Invalid_Record_ID(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_Invalid_State(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringfilter(s0,'ABCDEFGHIJKLMNOPQRSTUVWXYZ'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_Invalid_State(SALT311.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT311.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZ'))));
EXPORT InValidMessageFT_Invalid_State(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWXYZ'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_Invalid_Source_ID(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringfilter(s0,'0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ_ '); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_Invalid_Source_ID(SALT311.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT311.StringFilter(s,'0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ_ '))));
EXPORT InValidMessageFT_Invalid_Source_ID(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInChars('0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ_ '),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_Invalid_ZIP(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringfilter(s0,'0123456789'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_Invalid_ZIP(SALT311.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT311.StringFilter(s,'0123456789'))));
EXPORT InValidMessageFT_Invalid_ZIP(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInChars('0123456789'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_Invalid_City(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringfilter(s0,'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz.- '); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_Invalid_City(SALT311.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT311.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz.- '))));
EXPORT InValidMessageFT_Invalid_City(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz.- '),SALT311.HygieneErrors.Good);
 
EXPORT SALT311.StrType FieldName(UNSIGNED2 i) := CHOOSE(i,'recordid','statecode','street','unit','city','orig_state','orig_zip','addresstype','sourcename','sourceid','vendor');
EXPORT SALT311.StrType FlatName(UNSIGNED2 i) := CHOOSE(i,'recordid','statecode','street','unit','city','orig_state','orig_zip','addresstype','sourcename','sourceid','vendor');
EXPORT FieldNum(SALT311.StrType fn) := CASE(fn,'recordid' => 0,'statecode' => 1,'street' => 2,'unit' => 3,'city' => 4,'orig_state' => 5,'orig_zip' => 6,'addresstype' => 7,'sourcename' => 8,'sourceid' => 9,'vendor' => 10,0);
EXPORT SET OF SALT311.StrType FieldRules(UNSIGNED2 i) := CHOOSE(i,['ALLOW'],['ALLOW'],[],[],['ALLOW'],[],['ALLOW'],[],[],['ALLOW'],[],[]);
EXPORT BOOLEAN InBaseLayout(UNSIGNED2 i) := CHOOSE(i,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,FALSE);
 
//Individual field level validation
 
EXPORT Make_recordid(SALT311.StrType s0) := MakeFT_Invalid_Record_ID(s0);
EXPORT InValid_recordid(SALT311.StrType s) := InValidFT_Invalid_Record_ID(s);
EXPORT InValidMessage_recordid(UNSIGNED1 wh) := InValidMessageFT_Invalid_Record_ID(wh);
 
EXPORT Make_statecode(SALT311.StrType s0) := MakeFT_Invalid_State(s0);
EXPORT InValid_statecode(SALT311.StrType s) := InValidFT_Invalid_State(s);
EXPORT InValidMessage_statecode(UNSIGNED1 wh) := InValidMessageFT_Invalid_State(wh);
 
EXPORT Make_street(SALT311.StrType s0) := s0;
EXPORT InValid_street(SALT311.StrType s) := 0;
EXPORT InValidMessage_street(UNSIGNED1 wh) := '';
 
EXPORT Make_unit(SALT311.StrType s0) := s0;
EXPORT InValid_unit(SALT311.StrType s) := 0;
EXPORT InValidMessage_unit(UNSIGNED1 wh) := '';
 
EXPORT Make_city(SALT311.StrType s0) := MakeFT_Invalid_City(s0);
EXPORT InValid_city(SALT311.StrType s) := InValidFT_Invalid_City(s);
EXPORT InValidMessage_city(UNSIGNED1 wh) := InValidMessageFT_Invalid_City(wh);
 
EXPORT Make_orig_state(SALT311.StrType s0) := s0;
EXPORT InValid_orig_state(SALT311.StrType s) := 0;
EXPORT InValidMessage_orig_state(UNSIGNED1 wh) := '';
 
EXPORT Make_orig_zip(SALT311.StrType s0) := MakeFT_Invalid_ZIP(s0);
EXPORT InValid_orig_zip(SALT311.StrType s) := InValidFT_Invalid_ZIP(s);
EXPORT InValidMessage_orig_zip(UNSIGNED1 wh) := InValidMessageFT_Invalid_ZIP(wh);
 
EXPORT Make_addresstype(SALT311.StrType s0) := s0;
EXPORT InValid_addresstype(SALT311.StrType s) := 0;
EXPORT InValidMessage_addresstype(UNSIGNED1 wh) := '';
 
EXPORT Make_sourcename(SALT311.StrType s0) := s0;
EXPORT InValid_sourcename(SALT311.StrType s) := 0;
EXPORT InValidMessage_sourcename(UNSIGNED1 wh) := '';
 
EXPORT Make_sourceid(SALT311.StrType s0) := MakeFT_Invalid_Source_ID(s0);
EXPORT InValid_sourceid(SALT311.StrType s) := InValidFT_Invalid_Source_ID(s);
EXPORT InValidMessage_sourceid(UNSIGNED1 wh) := InValidMessageFT_Invalid_Source_ID(wh);
 
EXPORT Make_vendor(SALT311.StrType s0) := s0;
EXPORT InValid_vendor(SALT311.StrType s) := 0;
EXPORT InValidMessage_vendor(UNSIGNED1 wh) := '';
 
// This macro will compute and count field level differences based upon a pivot expression
export MAC_CountDifferencesByPivot(in_left,in_right,pivot_exp,bad_pivots,out_counts) := MACRO
  IMPORT SALT311,Scrubs_Crim;
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
    BOOLEAN Diff_recordid;
    BOOLEAN Diff_statecode;
    BOOLEAN Diff_street;
    BOOLEAN Diff_unit;
    BOOLEAN Diff_city;
    BOOLEAN Diff_orig_state;
    BOOLEAN Diff_orig_zip;
    BOOLEAN Diff_addresstype;
    BOOLEAN Diff_sourcename;
    BOOLEAN Diff_sourceid;
    BOOLEAN Diff_vendor;
    SALT311.StrType SourceField {MAXLENGTH(30)};
    UNSIGNED Num_Diffs;
    SALT311.StrType Val {MAXLENGTH(1024)};
  END;
#uniquename(fd)
  %dl% %fd%(in_left le,in_right ri) := TRANSFORM
    SELF.Diff_recordid := le.recordid <> ri.recordid;
    SELF.Diff_statecode := le.statecode <> ri.statecode;
    SELF.Diff_street := le.street <> ri.street;
    SELF.Diff_unit := le.unit <> ri.unit;
    SELF.Diff_city := le.city <> ri.city;
    SELF.Diff_orig_state := le.orig_state <> ri.orig_state;
    SELF.Diff_orig_zip := le.orig_zip <> ri.orig_zip;
    SELF.Diff_addresstype := le.addresstype <> ri.addresstype;
    SELF.Diff_sourcename := le.sourcename <> ri.sourcename;
    SELF.Diff_sourceid := le.sourceid <> ri.sourceid;
    SELF.Diff_vendor := le.vendor <> ri.vendor;
    SELF.Val := (SALT311.StrType)evaluate(le,pivot_exp);
    SELF.SourceField := le.vendor;
    SELF.Num_Diffs := 0+ IF( SELF.Diff_recordid,1,0)+ IF( SELF.Diff_statecode,1,0)+ IF( SELF.Diff_street,1,0)+ IF( SELF.Diff_unit,1,0)+ IF( SELF.Diff_city,1,0)+ IF( SELF.Diff_orig_state,1,0)+ IF( SELF.Diff_orig_zip,1,0)+ IF( SELF.Diff_addresstype,1,0)+ IF( SELF.Diff_sourcename,1,0)+ IF( SELF.Diff_sourceid,1,0)+ IF( SELF.Diff_vendor,1,0);
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
    Count_Diff_recordid := COUNT(GROUP,%Closest%.Diff_recordid);
    Count_Diff_statecode := COUNT(GROUP,%Closest%.Diff_statecode);
    Count_Diff_street := COUNT(GROUP,%Closest%.Diff_street);
    Count_Diff_unit := COUNT(GROUP,%Closest%.Diff_unit);
    Count_Diff_city := COUNT(GROUP,%Closest%.Diff_city);
    Count_Diff_orig_state := COUNT(GROUP,%Closest%.Diff_orig_state);
    Count_Diff_orig_zip := COUNT(GROUP,%Closest%.Diff_orig_zip);
    Count_Diff_addresstype := COUNT(GROUP,%Closest%.Diff_addresstype);
    Count_Diff_sourcename := COUNT(GROUP,%Closest%.Diff_sourcename);
    Count_Diff_sourceid := COUNT(GROUP,%Closest%.Diff_sourceid);
    Count_Diff_vendor := COUNT(GROUP,%Closest%.Diff_vendor);
    %Closest%.SourceField;
  END;
  out_counts := table(%Closest%,%AggRec%,SourceField,few);
ENDMACRO;
END;
