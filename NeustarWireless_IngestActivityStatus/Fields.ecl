IMPORT SALT311;
EXPORT Fields := MODULE
 
EXPORT NumFields := 9;
 
EXPORT SALT311.StrType FieldName(UNSIGNED2 i) := CHOOSE(i,'phone','activity_status','raw_file_name','rcid','source','date_first_seen','date_last_seen','date_vendor_first_reported','date_vendor_last_reported');
EXPORT SALT311.StrType FlatName(UNSIGNED2 i) := CHOOSE(i,'phone','activity_status','raw_file_name','rcid','source','date_first_seen','date_last_seen','date_vendor_first_reported','date_vendor_last_reported');
EXPORT FieldNum(SALT311.StrType fn) := CASE(fn,'phone' => 0,'activity_status' => 1,'raw_file_name' => 2,'rcid' => 3,'source' => 4,'date_first_seen' => 5,'date_last_seen' => 6,'date_vendor_first_reported' => 7,'date_vendor_last_reported' => 8,0);
EXPORT SET OF SALT311.StrType FieldRules(UNSIGNED2 i) := CHOOSE(i,[],[],[],[],[],[],[],[],[],[]);
EXPORT BOOLEAN InBaseLayout(UNSIGNED2 i) := CHOOSE(i,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,FALSE);
 
//Individual field level validation
 
EXPORT Make_phone(SALT311.StrType s0) := s0;
EXPORT InValid_phone(SALT311.StrType s) := 0;
EXPORT InValidMessage_phone(UNSIGNED1 wh) := '';
 
EXPORT Make_activity_status(SALT311.StrType s0) := s0;
EXPORT InValid_activity_status(SALT311.StrType s) := 0;
EXPORT InValidMessage_activity_status(UNSIGNED1 wh) := '';
 
EXPORT Make_raw_file_name(SALT311.StrType s0) := s0;
EXPORT InValid_raw_file_name(SALT311.StrType s) := 0;
EXPORT InValidMessage_raw_file_name(UNSIGNED1 wh) := '';
 
EXPORT Make_rcid(SALT311.StrType s0) := s0;
EXPORT InValid_rcid(SALT311.StrType s) := 0;
EXPORT InValidMessage_rcid(UNSIGNED1 wh) := '';
 
EXPORT Make_source(SALT311.StrType s0) := s0;
EXPORT InValid_source(SALT311.StrType s) := 0;
EXPORT InValidMessage_source(UNSIGNED1 wh) := '';
 
EXPORT Make_date_first_seen(SALT311.StrType s0) := s0;
EXPORT InValid_date_first_seen(SALT311.StrType s) := 0;
EXPORT InValidMessage_date_first_seen(UNSIGNED1 wh) := '';
 
EXPORT Make_date_last_seen(SALT311.StrType s0) := s0;
EXPORT InValid_date_last_seen(SALT311.StrType s) := 0;
EXPORT InValidMessage_date_last_seen(UNSIGNED1 wh) := '';
 
EXPORT Make_date_vendor_first_reported(SALT311.StrType s0) := s0;
EXPORT InValid_date_vendor_first_reported(SALT311.StrType s) := 0;
EXPORT InValidMessage_date_vendor_first_reported(UNSIGNED1 wh) := '';
 
EXPORT Make_date_vendor_last_reported(SALT311.StrType s0) := s0;
EXPORT InValid_date_vendor_last_reported(SALT311.StrType s) := 0;
EXPORT InValidMessage_date_vendor_last_reported(UNSIGNED1 wh) := '';
 
// This macro will compute and count field level differences based upon a pivot expression
export MAC_CountDifferencesByPivot(in_left,in_right,pivot_exp,bad_pivots,out_counts) := MACRO
  IMPORT SALT311,NeustarWireless_IngestActivityStatus;
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
    BOOLEAN Diff_phone;
    BOOLEAN Diff_activity_status;
    BOOLEAN Diff_raw_file_name;
    BOOLEAN Diff_rcid;
    BOOLEAN Diff_source;
    BOOLEAN Diff_date_first_seen;
    BOOLEAN Diff_date_last_seen;
    BOOLEAN Diff_date_vendor_first_reported;
    BOOLEAN Diff_date_vendor_last_reported;
    SALT311.StrType SourceField {MAXLENGTH(30)};
    UNSIGNED Num_Diffs;
    SALT311.StrType Val {MAXLENGTH(1024)};
  END;
#uniquename(fd)
  %dl% %fd%(in_left le,in_right ri) := TRANSFORM
    SELF.Diff_phone := le.phone <> ri.phone;
    SELF.Diff_activity_status := le.activity_status <> ri.activity_status;
    SELF.Diff_raw_file_name := le.raw_file_name <> ri.raw_file_name;
    SELF.Diff_rcid := le.rcid <> ri.rcid;
    SELF.Diff_source := le.source <> ri.source;
    SELF.Diff_date_first_seen := le.date_first_seen <> ri.date_first_seen;
    SELF.Diff_date_last_seen := le.date_last_seen <> ri.date_last_seen;
    SELF.Diff_date_vendor_first_reported := le.date_vendor_first_reported <> ri.date_vendor_first_reported;
    SELF.Diff_date_vendor_last_reported := le.date_vendor_last_reported <> ri.date_vendor_last_reported;
    SELF.Val := (SALT311.StrType)evaluate(le,pivot_exp);
    SELF.SourceField := le.source;
    SELF.Num_Diffs := 0+ IF( SELF.Diff_phone,1,0)+ IF( SELF.Diff_activity_status,1,0)+ IF( SELF.Diff_raw_file_name,1,0)+ IF( SELF.Diff_rcid,1,0)+ IF( SELF.Diff_source,1,0);
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
    Count_Diff_phone := COUNT(GROUP,%Closest%.Diff_phone);
    Count_Diff_activity_status := COUNT(GROUP,%Closest%.Diff_activity_status);
    Count_Diff_raw_file_name := COUNT(GROUP,%Closest%.Diff_raw_file_name);
    Count_Diff_rcid := COUNT(GROUP,%Closest%.Diff_rcid);
    Count_Diff_source := COUNT(GROUP,%Closest%.Diff_source);
    Count_Diff_date_first_seen := COUNT(GROUP,%Closest%.Diff_date_first_seen);
    Count_Diff_date_last_seen := COUNT(GROUP,%Closest%.Diff_date_last_seen);
    Count_Diff_date_vendor_first_reported := COUNT(GROUP,%Closest%.Diff_date_vendor_first_reported);
    Count_Diff_date_vendor_last_reported := COUNT(GROUP,%Closest%.Diff_date_vendor_last_reported);
    %Closest%.SourceField;
  END;
  out_counts := table(%Closest%,%AggRec%,SourceField,few);
ENDMACRO;
END;
