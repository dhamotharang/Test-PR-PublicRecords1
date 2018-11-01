IMPORT SALT311;
EXPORT Fields := MODULE
 
EXPORT NumFields := 12;
 
EXPORT SALT311.StrType FieldName(UNSIGNED2 i) := CHOOSE(i,'deleted','fid','id','resource','source','summary.type','type','value','status','useinaddress','link_href','link_rel');
EXPORT SALT311.StrType FlatName(UNSIGNED2 i) := CHOOSE(i,'deleted','fid','id','resource','source','summary_type','type','value','status','useinaddress','link_href','link_rel');
EXPORT FieldNum(SALT311.StrType fn) := CASE(fn,'deleted' => 0,'fid' => 1,'id' => 2,'resource' => 3,'source' => 4,'summary.type' => 5,'type' => 6,'value' => 7,'status' => 8,'useinaddress' => 9,'link_href' => 10,'link_rel' => 11,0);
EXPORT SET OF SALT311.StrType FieldRules(UNSIGNED2 i) := CHOOSE(i,[],[],[],[],[],[],[],[],[],[],[],[],[]);
EXPORT BOOLEAN InBaseLayout(UNSIGNED2 i) := CHOOSE(i,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,FALSE);
 
//Individual field level validation
 
EXPORT Make_deleted(SALT311.StrType s0) := s0;
EXPORT InValid_deleted(SALT311.StrType s) := 0;
EXPORT InValidMessage_deleted(UNSIGNED1 wh) := '';
 
EXPORT Make_fid(SALT311.StrType s0) := s0;
EXPORT InValid_fid(SALT311.StrType s) := 0;
EXPORT InValidMessage_fid(UNSIGNED1 wh) := '';
 
EXPORT Make_id(SALT311.StrType s0) := s0;
EXPORT InValid_id(SALT311.StrType s) := 0;
EXPORT InValidMessage_id(UNSIGNED1 wh) := '';
 
EXPORT Make_resource(SALT311.StrType s0) := s0;
EXPORT InValid_resource(SALT311.StrType s) := 0;
EXPORT InValidMessage_resource(UNSIGNED1 wh) := '';
 
EXPORT Make_source(SALT311.StrType s0) := s0;
EXPORT InValid_source(SALT311.StrType s) := 0;
EXPORT InValidMessage_source(UNSIGNED1 wh) := '';
 
EXPORT Make_summary_type(SALT311.StrType s0) := s0;
EXPORT InValid_summary_type(SALT311.StrType s) := 0;
EXPORT InValidMessage_summary_type(UNSIGNED1 wh) := '';
 
EXPORT Make_type(SALT311.StrType s0) := s0;
EXPORT InValid_type(SALT311.StrType s) := 0;
EXPORT InValidMessage_type(UNSIGNED1 wh) := '';
 
EXPORT Make_value(SALT311.StrType s0) := s0;
EXPORT InValid_value(SALT311.StrType s) := 0;
EXPORT InValidMessage_value(UNSIGNED1 wh) := '';
 
EXPORT Make_status(SALT311.StrType s0) := s0;
EXPORT InValid_status(SALT311.StrType s) := 0;
EXPORT InValidMessage_status(UNSIGNED1 wh) := '';
 
EXPORT Make_useinaddress(SALT311.StrType s0) := s0;
EXPORT InValid_useinaddress(SALT311.StrType s) := 0;
EXPORT InValidMessage_useinaddress(UNSIGNED1 wh) := '';
 
EXPORT Make_link_href(SALT311.StrType s0) := s0;
EXPORT InValid_link_href(SALT311.StrType s) := 0;
EXPORT InValidMessage_link_href(UNSIGNED1 wh) := '';
 
EXPORT Make_link_rel(SALT311.StrType s0) := s0;
EXPORT InValid_link_rel(SALT311.StrType s) := 0;
EXPORT InValidMessage_link_rel(UNSIGNED1 wh) := '';
 
// This macro will compute and count field level differences based upon a pivot expression
export MAC_CountDifferencesByPivot(in_left,in_right,pivot_exp,bad_pivots,out_counts) := MACRO
  IMPORT SALT311,Ares_SALT;
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
    BOOLEAN Diff_deleted;
    BOOLEAN Diff_fid;
    BOOLEAN Diff_id;
    BOOLEAN Diff_resource;
    BOOLEAN Diff_source;
    BOOLEAN Diff_summary_type;
    BOOLEAN Diff_type;
    BOOLEAN Diff_value;
    BOOLEAN Diff_status;
    BOOLEAN Diff_useinaddress;
    BOOLEAN Diff_link_href;
    BOOLEAN Diff_link_rel;
    UNSIGNED Num_Diffs;
    SALT311.StrType Val {MAXLENGTH(1024)};
  END;
#uniquename(fd)
  %dl% %fd%(in_left le,in_right ri) := TRANSFORM
    SELF.Diff_deleted := le.deleted <> ri.deleted;
    SELF.Diff_fid := le.fid <> ri.fid;
    SELF.Diff_id := le.id <> ri.id;
    SELF.Diff_resource := le.resource <> ri.resource;
    SELF.Diff_source := le.source <> ri.source;
    SELF.Diff_summary_type := le.summary.type <> ri.summary.type;
    SELF.Diff_type := le.type <> ri.type;
    SELF.Diff_value := le.value <> ri.value;
    SELF.Diff_status := le.status <> ri.status;
    SELF.Diff_useinaddress := le.useinaddress <> ri.useinaddress;
    SELF.Diff_link_href := le.link_href <> ri.link_href;
    SELF.Diff_link_rel := le.link_rel <> ri.link_rel;
    SELF.Val := (SALT311.StrType)evaluate(le,pivot_exp);
    SELF.Num_Diffs := 0+ IF( SELF.Diff_deleted,1,0)+ IF( SELF.Diff_fid,1,0)+ IF( SELF.Diff_id,1,0)+ IF( SELF.Diff_resource,1,0)+ IF( SELF.Diff_source,1,0)+ IF( SELF.Diff_summary.type,1,0)+ IF( SELF.Diff_type,1,0)+ IF( SELF.Diff_value,1,0)+ IF( SELF.Diff_status,1,0)+ IF( SELF.Diff_useinaddress,1,0)+ IF( SELF.Diff_link_href,1,0)+ IF( SELF.Diff_link_rel,1,0);
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
    Count_Diff_deleted := COUNT(GROUP,%Closest%.Diff_deleted);
    Count_Diff_fid := COUNT(GROUP,%Closest%.Diff_fid);
    Count_Diff_id := COUNT(GROUP,%Closest%.Diff_id);
    Count_Diff_resource := COUNT(GROUP,%Closest%.Diff_resource);
    Count_Diff_source := COUNT(GROUP,%Closest%.Diff_source);
    Count_Diff_summary_type := COUNT(GROUP,%Closest%.Diff_summary_type);
    Count_Diff_type := COUNT(GROUP,%Closest%.Diff_type);
    Count_Diff_value := COUNT(GROUP,%Closest%.Diff_value);
    Count_Diff_status := COUNT(GROUP,%Closest%.Diff_status);
    Count_Diff_useinaddress := COUNT(GROUP,%Closest%.Diff_useinaddress);
    Count_Diff_link_href := COUNT(GROUP,%Closest%.Diff_link_href);
    Count_Diff_link_rel := COUNT(GROUP,%Closest%.Diff_link_rel);
  END;
  out_counts := table(%Closest%,%AggRec%,true);
ENDMACRO;
END;
