IMPORT SALT38;
EXPORT New_Fields := MODULE
 
EXPORT NumFields := 9;
 
// Processing for each FieldType
EXPORT SALT38.StrType FieldTypeName(UNSIGNED2 i) := CHOOSE(i,'invalid_product','invalid_linking_type','invalid_num','invalid_document_type','invlid_document_id');
EXPORT FieldTypeNum(SALT38.StrType fn) := CASE(fn,'invalid_product' => 1,'invalid_linking_type' => 2,'invalid_num' => 3,'invalid_document_type' => 4,'invlid_document_id' => 5,0);
 
EXPORT MakeFT_invalid_product(SALT38.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_product(SALT38.StrType s) := WHICH(((SALT38.StrType) s) NOT IN ['ACCURINT','CONSUMER','LE','ALL']);
EXPORT InValidMessageFT_invalid_product(UNSIGNED1 wh) := CHOOSE(wh,SALT38.HygieneErrors.NotInEnum('ACCURINT|CONSUMER|LE|ALL'),SALT38.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_linking_type(SALT38.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_linking_type(SALT38.StrType s) := WHICH(((SALT38.StrType) s) NOT IN ['DID','SSN','BDID','']);
EXPORT InValidMessageFT_invalid_linking_type(UNSIGNED1 wh) := CHOOSE(wh,SALT38.HygieneErrors.NotInEnum('DID|SSN|BDID|'),SALT38.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_num(SALT38.StrType s0) := FUNCTION
  s1 := SALT38.stringfilter(s0,'0123456789'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_num(SALT38.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT38.StringFilter(s,'0123456789'))));
EXPORT InValidMessageFT_invalid_num(UNSIGNED1 wh) := CHOOSE(wh,SALT38.HygieneErrors.NotInChars('0123456789'),SALT38.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_document_type(SALT38.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_document_type(SALT38.StrType s) := WHICH(((SALT38.StrType) s) NOT IN ['OFFENDER KEY','FARES ID','OFFICIAL RECORD','']);
EXPORT InValidMessageFT_invalid_document_type(UNSIGNED1 wh) := CHOOSE(wh,SALT38.HygieneErrors.NotInEnum('OFFENDER KEY|FARES ID|OFFICIAL RECORD|'),SALT38.HygieneErrors.Good);
 
EXPORT MakeFT_invlid_document_id(SALT38.StrType s0) := FUNCTION
  s1 := SALT38.stringfilter(s0,'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789- /'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invlid_document_id(SALT38.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT38.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789- /'))));
EXPORT InValidMessageFT_invlid_document_id(UNSIGNED1 wh) := CHOOSE(wh,SALT38.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789- /'),SALT38.HygieneErrors.Good);
 
EXPORT SALT38.StrType FieldName(UNSIGNED2 i) := CHOOSE(i,'product','linking_type','linking_id','document_type','document_id','date_added','user','compliance_id','comment');
EXPORT SALT38.StrType FlatName(UNSIGNED2 i) := CHOOSE(i,'product','linking_type','linking_id','document_type','document_id','date_added','user','compliance_id','comment');
EXPORT FieldNum(SALT38.StrType fn) := CASE(fn,'product' => 0,'linking_type' => 1,'linking_id' => 2,'document_type' => 3,'document_id' => 4,'date_added' => 5,'user' => 6,'compliance_id' => 7,'comment' => 8,0);
EXPORT SET OF SALT38.StrType FieldRules(UNSIGNED2 i) := CHOOSE(i,['ENUM'],['ENUM'],['ALLOW'],['ENUM'],['ALLOW'],[],[],['ALLOW'],[],[]);
EXPORT BOOLEAN InBaseLayout(UNSIGNED2 i) := CHOOSE(i,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,FALSE);
 
//Individual field level validation
 
EXPORT Make_product(SALT38.StrType s0) := MakeFT_invalid_product(s0);
EXPORT InValid_product(SALT38.StrType s) := InValidFT_invalid_product(s);
EXPORT InValidMessage_product(UNSIGNED1 wh) := InValidMessageFT_invalid_product(wh);
 
EXPORT Make_linking_type(SALT38.StrType s0) := MakeFT_invalid_linking_type(s0);
EXPORT InValid_linking_type(SALT38.StrType s) := InValidFT_invalid_linking_type(s);
EXPORT InValidMessage_linking_type(UNSIGNED1 wh) := InValidMessageFT_invalid_linking_type(wh);
 
EXPORT Make_linking_id(SALT38.StrType s0) := MakeFT_invalid_num(s0);
EXPORT InValid_linking_id(SALT38.StrType s) := InValidFT_invalid_num(s);
EXPORT InValidMessage_linking_id(UNSIGNED1 wh) := InValidMessageFT_invalid_num(wh);
 
EXPORT Make_document_type(SALT38.StrType s0) := MakeFT_invalid_document_type(s0);
EXPORT InValid_document_type(SALT38.StrType s) := InValidFT_invalid_document_type(s);
EXPORT InValidMessage_document_type(UNSIGNED1 wh) := InValidMessageFT_invalid_document_type(wh);
 
EXPORT Make_document_id(SALT38.StrType s0) := MakeFT_invlid_document_id(s0);
EXPORT InValid_document_id(SALT38.StrType s) := InValidFT_invlid_document_id(s);
EXPORT InValidMessage_document_id(UNSIGNED1 wh) := InValidMessageFT_invlid_document_id(wh);
 
EXPORT Make_date_added(SALT38.StrType s0) := s0;
EXPORT InValid_date_added(SALT38.StrType s) := 0;
EXPORT InValidMessage_date_added(UNSIGNED1 wh) := '';
 
EXPORT Make_user(SALT38.StrType s0) := s0;
EXPORT InValid_user(SALT38.StrType s) := 0;
EXPORT InValidMessage_user(UNSIGNED1 wh) := '';
 
EXPORT Make_compliance_id(SALT38.StrType s0) := MakeFT_invalid_num(s0);
EXPORT InValid_compliance_id(SALT38.StrType s) := InValidFT_invalid_num(s);
EXPORT InValidMessage_compliance_id(UNSIGNED1 wh) := InValidMessageFT_invalid_num(wh);
 
EXPORT Make_comment(SALT38.StrType s0) := s0;
EXPORT InValid_comment(SALT38.StrType s) := 0;
EXPORT InValidMessage_comment(UNSIGNED1 wh) := '';
 
// This macro will compute and count field level differences based upon a pivot expression
export MAC_CountDifferencesByPivot(in_left,in_right,pivot_exp,bad_pivots,out_counts) := MACRO
  IMPORT SALT38,Scrubs_Suppress;
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
    BOOLEAN Diff_product;
    BOOLEAN Diff_linking_type;
    BOOLEAN Diff_linking_id;
    BOOLEAN Diff_document_type;
    BOOLEAN Diff_document_id;
    BOOLEAN Diff_date_added;
    BOOLEAN Diff_user;
    BOOLEAN Diff_compliance_id;
    BOOLEAN Diff_comment;
    UNSIGNED Num_Diffs;
    SALT38.StrType Val {MAXLENGTH(1024)};
  END;
#uniquename(fd)
  %dl% %fd%(in_left le,in_right ri) := TRANSFORM
    SELF.Diff_product := le.product <> ri.product;
    SELF.Diff_linking_type := le.linking_type <> ri.linking_type;
    SELF.Diff_linking_id := le.linking_id <> ri.linking_id;
    SELF.Diff_document_type := le.document_type <> ri.document_type;
    SELF.Diff_document_id := le.document_id <> ri.document_id;
    SELF.Diff_date_added := le.date_added <> ri.date_added;
    SELF.Diff_user := le.user <> ri.user;
    SELF.Diff_compliance_id := le.compliance_id <> ri.compliance_id;
    SELF.Diff_comment := le.comment <> ri.comment;
    SELF.Val := (SALT38.StrType)evaluate(le,pivot_exp);
    SELF.Num_Diffs := 0+ IF( SELF.Diff_product,1,0)+ IF( SELF.Diff_linking_type,1,0)+ IF( SELF.Diff_linking_id,1,0)+ IF( SELF.Diff_document_type,1,0)+ IF( SELF.Diff_document_id,1,0)+ IF( SELF.Diff_date_added,1,0)+ IF( SELF.Diff_user,1,0)+ IF( SELF.Diff_compliance_id,1,0)+ IF( SELF.Diff_comment,1,0);
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
    Count_Diff_product := COUNT(GROUP,%Closest%.Diff_product);
    Count_Diff_linking_type := COUNT(GROUP,%Closest%.Diff_linking_type);
    Count_Diff_linking_id := COUNT(GROUP,%Closest%.Diff_linking_id);
    Count_Diff_document_type := COUNT(GROUP,%Closest%.Diff_document_type);
    Count_Diff_document_id := COUNT(GROUP,%Closest%.Diff_document_id);
    Count_Diff_date_added := COUNT(GROUP,%Closest%.Diff_date_added);
    Count_Diff_user := COUNT(GROUP,%Closest%.Diff_user);
    Count_Diff_compliance_id := COUNT(GROUP,%Closest%.Diff_compliance_id);
    Count_Diff_comment := COUNT(GROUP,%Closest%.Diff_comment);
  END;
  out_counts := table(%Closest%,%AggRec%,true);
ENDMACRO;
END;
