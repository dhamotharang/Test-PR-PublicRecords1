IMPORT SALT311;
IMPORT Scrubs,Scrubs_BK_Events; // Import modules for FieldTypes attribute definitions
EXPORT Fields := MODULE
 
EXPORT NumFields := 23;
 
// Processing for each FieldType
EXPORT SALT311.StrType FieldTypeName(UNSIGNED2 i) := CHOOSE(i,'Invalid_No','Invalid_Int','Invalid_Float','Invalid_CaseNo','Invalid_URL','Invalid_Alpha','Invalid_AlphaNum','Invalid_AlphaNumChar','Invalid_Date');
EXPORT FieldTypeNum(SALT311.StrType fn) := CASE(fn,'Invalid_No' => 1,'Invalid_Int' => 2,'Invalid_Float' => 3,'Invalid_CaseNo' => 4,'Invalid_URL' => 5,'Invalid_Alpha' => 6,'Invalid_AlphaNum' => 7,'Invalid_AlphaNumChar' => 8,'Invalid_Date' => 9,0);
 
EXPORT MakeFT_Invalid_No(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringfilter(s0,'0123456789'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_Invalid_No(SALT311.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT311.StringFilter(s,'0123456789'))));
EXPORT InValidMessageFT_Invalid_No(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInChars('0123456789'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_Invalid_Int(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringfilter(s0,'0123456789- '); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_Invalid_Int(SALT311.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT311.StringFilter(s,'0123456789- '))));
EXPORT InValidMessageFT_Invalid_Int(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInChars('0123456789- '),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_Invalid_Float(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringfilter(s0,'0123456789., '); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_Invalid_Float(SALT311.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT311.StringFilter(s,'0123456789., '))));
EXPORT InValidMessageFT_Invalid_Float(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInChars('0123456789., '),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_Invalid_CaseNo(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringfilter(s0,'0123456789-: ABCDEFGHIJKLMNOPQRSTUVWXYZ'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_Invalid_CaseNo(SALT311.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT311.StringFilter(s,'0123456789-: ABCDEFGHIJKLMNOPQRSTUVWXYZ'))));
EXPORT InValidMessageFT_Invalid_CaseNo(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInChars('0123456789-: ABCDEFGHIJKLMNOPQRSTUVWXYZ'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_Invalid_URL(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringfilter(s0,'0123456789:;-_=&./? abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_Invalid_URL(SALT311.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT311.StringFilter(s,'0123456789:;-_=&./? abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ'))));
EXPORT InValidMessageFT_Invalid_URL(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInChars('0123456789:;-_=&./? abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_Invalid_Alpha(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_Invalid_Alpha(SALT311.StrType s) := WHICH(~Scrubs.Fn_Allow_ws(s,'Alpha')>0);
EXPORT InValidMessageFT_Invalid_Alpha(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('Scrubs.Fn_Allow_ws'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_Invalid_AlphaNum(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_Invalid_AlphaNum(SALT311.StrType s) := WHICH(~Scrubs.Fn_Allow_ws(s,'AlphaNum',true)>0);
EXPORT InValidMessageFT_Invalid_AlphaNum(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('Scrubs.Fn_Allow_ws'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_Invalid_AlphaNumChar(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_Invalid_AlphaNumChar(SALT311.StrType s) := WHICH(~Scrubs.Fn_Allow_ws(s,'AlphaNumChar',true)>0);
EXPORT InValidMessageFT_Invalid_AlphaNumChar(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('Scrubs.Fn_Allow_ws'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_Invalid_Date(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_Invalid_Date(SALT311.StrType s) := WHICH(~Scrubs_BK_Events.Functions.Fn_Valid_Date(s)>0);
EXPORT InValidMessageFT_Invalid_Date(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('Scrubs_BK_Events.Functions.Fn_Valid_Date'),SALT311.HygieneErrors.Good);
 
EXPORT SALT311.StrType FieldName(UNSIGNED2 i) := CHOOSE(i,'dractivitytypecode','docketentryid','courtid','casekey','casetype','bkcasenumber','bkcasenumberurl','proceedingscasenumber','proceedingscasenumberurl','caseid','pacercaseid','attachmenturl','entrynumber','entereddate','pacer_entereddate','fileddate','score','drcategoryeventid','court_code','district','boca_court','catevent_description','catevent_category');
EXPORT SALT311.StrType FlatName(UNSIGNED2 i) := CHOOSE(i,'dractivitytypecode','docketentryid','courtid','casekey','casetype','bkcasenumber','bkcasenumberurl','proceedingscasenumber','proceedingscasenumberurl','caseid','pacercaseid','attachmenturl','entrynumber','entereddate','pacer_entereddate','fileddate','score','drcategoryeventid','court_code','district','boca_court','catevent_description','catevent_category');
EXPORT FieldNum(SALT311.StrType fn) := CASE(fn,'dractivitytypecode' => 0,'docketentryid' => 1,'courtid' => 2,'casekey' => 3,'casetype' => 4,'bkcasenumber' => 5,'bkcasenumberurl' => 6,'proceedingscasenumber' => 7,'proceedingscasenumberurl' => 8,'caseid' => 9,'pacercaseid' => 10,'attachmenturl' => 11,'entrynumber' => 12,'entereddate' => 13,'pacer_entereddate' => 14,'fileddate' => 15,'score' => 16,'drcategoryeventid' => 17,'court_code' => 18,'district' => 19,'boca_court' => 20,'catevent_description' => 21,'catevent_category' => 22,0);
EXPORT SET OF SALT311.StrType FieldRules(UNSIGNED2 i) := CHOOSE(i,['CUSTOM'],['ALLOW'],['ALLOW'],['ALLOW'],['CUSTOM'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['ALLOW'],['ALLOW'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],[]);
EXPORT BOOLEAN InBaseLayout(UNSIGNED2 i) := CHOOSE(i,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,FALSE);
 
//Individual field level validation
 
EXPORT Make_dractivitytypecode(SALT311.StrType s0) := MakeFT_Invalid_Alpha(s0);
EXPORT InValid_dractivitytypecode(SALT311.StrType s) := InValidFT_Invalid_Alpha(s);
EXPORT InValidMessage_dractivitytypecode(UNSIGNED1 wh) := InValidMessageFT_Invalid_Alpha(wh);
 
EXPORT Make_docketentryid(SALT311.StrType s0) := MakeFT_Invalid_No(s0);
EXPORT InValid_docketentryid(SALT311.StrType s) := InValidFT_Invalid_No(s);
EXPORT InValidMessage_docketentryid(UNSIGNED1 wh) := InValidMessageFT_Invalid_No(wh);
 
EXPORT Make_courtid(SALT311.StrType s0) := MakeFT_Invalid_No(s0);
EXPORT InValid_courtid(SALT311.StrType s) := InValidFT_Invalid_No(s);
EXPORT InValidMessage_courtid(UNSIGNED1 wh) := InValidMessageFT_Invalid_No(wh);
 
EXPORT Make_casekey(SALT311.StrType s0) := MakeFT_Invalid_No(s0);
EXPORT InValid_casekey(SALT311.StrType s) := InValidFT_Invalid_No(s);
EXPORT InValidMessage_casekey(UNSIGNED1 wh) := InValidMessageFT_Invalid_No(wh);
 
EXPORT Make_casetype(SALT311.StrType s0) := MakeFT_Invalid_Alpha(s0);
EXPORT InValid_casetype(SALT311.StrType s) := InValidFT_Invalid_Alpha(s);
EXPORT InValidMessage_casetype(UNSIGNED1 wh) := InValidMessageFT_Invalid_Alpha(wh);
 
EXPORT Make_bkcasenumber(SALT311.StrType s0) := MakeFT_Invalid_CaseNo(s0);
EXPORT InValid_bkcasenumber(SALT311.StrType s) := InValidFT_Invalid_CaseNo(s);
EXPORT InValidMessage_bkcasenumber(UNSIGNED1 wh) := InValidMessageFT_Invalid_CaseNo(wh);
 
EXPORT Make_bkcasenumberurl(SALT311.StrType s0) := MakeFT_Invalid_URL(s0);
EXPORT InValid_bkcasenumberurl(SALT311.StrType s) := InValidFT_Invalid_URL(s);
EXPORT InValidMessage_bkcasenumberurl(UNSIGNED1 wh) := InValidMessageFT_Invalid_URL(wh);
 
EXPORT Make_proceedingscasenumber(SALT311.StrType s0) := MakeFT_Invalid_CaseNo(s0);
EXPORT InValid_proceedingscasenumber(SALT311.StrType s) := InValidFT_Invalid_CaseNo(s);
EXPORT InValidMessage_proceedingscasenumber(UNSIGNED1 wh) := InValidMessageFT_Invalid_CaseNo(wh);
 
EXPORT Make_proceedingscasenumberurl(SALT311.StrType s0) := MakeFT_Invalid_URL(s0);
EXPORT InValid_proceedingscasenumberurl(SALT311.StrType s) := InValidFT_Invalid_URL(s);
EXPORT InValidMessage_proceedingscasenumberurl(UNSIGNED1 wh) := InValidMessageFT_Invalid_URL(wh);
 
EXPORT Make_caseid(SALT311.StrType s0) := MakeFT_Invalid_No(s0);
EXPORT InValid_caseid(SALT311.StrType s) := InValidFT_Invalid_No(s);
EXPORT InValidMessage_caseid(UNSIGNED1 wh) := InValidMessageFT_Invalid_No(wh);
 
EXPORT Make_pacercaseid(SALT311.StrType s0) := MakeFT_Invalid_Int(s0);
EXPORT InValid_pacercaseid(SALT311.StrType s) := InValidFT_Invalid_Int(s);
EXPORT InValidMessage_pacercaseid(UNSIGNED1 wh) := InValidMessageFT_Invalid_Int(wh);
 
EXPORT Make_attachmenturl(SALT311.StrType s0) := MakeFT_Invalid_URL(s0);
EXPORT InValid_attachmenturl(SALT311.StrType s) := InValidFT_Invalid_URL(s);
EXPORT InValidMessage_attachmenturl(UNSIGNED1 wh) := InValidMessageFT_Invalid_URL(wh);
 
EXPORT Make_entrynumber(SALT311.StrType s0) := MakeFT_Invalid_Int(s0);
EXPORT InValid_entrynumber(SALT311.StrType s) := InValidFT_Invalid_Int(s);
EXPORT InValidMessage_entrynumber(UNSIGNED1 wh) := InValidMessageFT_Invalid_Int(wh);
 
EXPORT Make_entereddate(SALT311.StrType s0) := MakeFT_Invalid_Date(s0);
EXPORT InValid_entereddate(SALT311.StrType s) := InValidFT_Invalid_Date(s);
EXPORT InValidMessage_entereddate(UNSIGNED1 wh) := InValidMessageFT_Invalid_Date(wh);
 
EXPORT Make_pacer_entereddate(SALT311.StrType s0) := MakeFT_Invalid_Date(s0);
EXPORT InValid_pacer_entereddate(SALT311.StrType s) := InValidFT_Invalid_Date(s);
EXPORT InValidMessage_pacer_entereddate(UNSIGNED1 wh) := InValidMessageFT_Invalid_Date(wh);
 
EXPORT Make_fileddate(SALT311.StrType s0) := MakeFT_Invalid_Date(s0);
EXPORT InValid_fileddate(SALT311.StrType s) := InValidFT_Invalid_Date(s);
EXPORT InValidMessage_fileddate(UNSIGNED1 wh) := InValidMessageFT_Invalid_Date(wh);
 
EXPORT Make_score(SALT311.StrType s0) := MakeFT_Invalid_Float(s0);
EXPORT InValid_score(SALT311.StrType s) := InValidFT_Invalid_Float(s);
EXPORT InValidMessage_score(UNSIGNED1 wh) := InValidMessageFT_Invalid_Float(wh);
 
EXPORT Make_drcategoryeventid(SALT311.StrType s0) := MakeFT_Invalid_No(s0);
EXPORT InValid_drcategoryeventid(SALT311.StrType s) := InValidFT_Invalid_No(s);
EXPORT InValidMessage_drcategoryeventid(UNSIGNED1 wh) := InValidMessageFT_Invalid_No(wh);
 
EXPORT Make_court_code(SALT311.StrType s0) := MakeFT_Invalid_AlphaNum(s0);
EXPORT InValid_court_code(SALT311.StrType s) := InValidFT_Invalid_AlphaNum(s);
EXPORT InValidMessage_court_code(UNSIGNED1 wh) := InValidMessageFT_Invalid_AlphaNum(wh);
 
EXPORT Make_district(SALT311.StrType s0) := MakeFT_Invalid_Alpha(s0);
EXPORT InValid_district(SALT311.StrType s) := InValidFT_Invalid_Alpha(s);
EXPORT InValidMessage_district(UNSIGNED1 wh) := InValidMessageFT_Invalid_Alpha(wh);
 
EXPORT Make_boca_court(SALT311.StrType s0) := MakeFT_Invalid_Alpha(s0);
EXPORT InValid_boca_court(SALT311.StrType s) := InValidFT_Invalid_Alpha(s);
EXPORT InValidMessage_boca_court(UNSIGNED1 wh) := InValidMessageFT_Invalid_Alpha(wh);
 
EXPORT Make_catevent_description(SALT311.StrType s0) := MakeFT_Invalid_AlphaNumChar(s0);
EXPORT InValid_catevent_description(SALT311.StrType s) := InValidFT_Invalid_AlphaNumChar(s);
EXPORT InValidMessage_catevent_description(UNSIGNED1 wh) := InValidMessageFT_Invalid_AlphaNumChar(wh);
 
EXPORT Make_catevent_category(SALT311.StrType s0) := MakeFT_Invalid_AlphaNumChar(s0);
EXPORT InValid_catevent_category(SALT311.StrType s) := InValidFT_Invalid_AlphaNumChar(s);
EXPORT InValidMessage_catevent_category(UNSIGNED1 wh) := InValidMessageFT_Invalid_AlphaNumChar(wh);
 
// This macro will compute and count field level differences based upon a pivot expression
export MAC_CountDifferencesByPivot(in_left,in_right,pivot_exp,bad_pivots,out_counts) := MACRO
  IMPORT SALT311,Scrubs_BK_Events;
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
    BOOLEAN Diff_dractivitytypecode;
    BOOLEAN Diff_docketentryid;
    BOOLEAN Diff_courtid;
    BOOLEAN Diff_casekey;
    BOOLEAN Diff_casetype;
    BOOLEAN Diff_bkcasenumber;
    BOOLEAN Diff_bkcasenumberurl;
    BOOLEAN Diff_proceedingscasenumber;
    BOOLEAN Diff_proceedingscasenumberurl;
    BOOLEAN Diff_caseid;
    BOOLEAN Diff_pacercaseid;
    BOOLEAN Diff_attachmenturl;
    BOOLEAN Diff_entrynumber;
    BOOLEAN Diff_entereddate;
    BOOLEAN Diff_pacer_entereddate;
    BOOLEAN Diff_fileddate;
    BOOLEAN Diff_score;
    BOOLEAN Diff_drcategoryeventid;
    BOOLEAN Diff_court_code;
    BOOLEAN Diff_district;
    BOOLEAN Diff_boca_court;
    BOOLEAN Diff_catevent_description;
    BOOLEAN Diff_catevent_category;
    UNSIGNED Num_Diffs;
    SALT311.StrType Val {MAXLENGTH(1024)};
  END;
#uniquename(fd)
  %dl% %fd%(in_left le,in_right ri) := TRANSFORM
    SELF.Diff_dractivitytypecode := le.dractivitytypecode <> ri.dractivitytypecode;
    SELF.Diff_docketentryid := le.docketentryid <> ri.docketentryid;
    SELF.Diff_courtid := le.courtid <> ri.courtid;
    SELF.Diff_casekey := le.casekey <> ri.casekey;
    SELF.Diff_casetype := le.casetype <> ri.casetype;
    SELF.Diff_bkcasenumber := le.bkcasenumber <> ri.bkcasenumber;
    SELF.Diff_bkcasenumberurl := le.bkcasenumberurl <> ri.bkcasenumberurl;
    SELF.Diff_proceedingscasenumber := le.proceedingscasenumber <> ri.proceedingscasenumber;
    SELF.Diff_proceedingscasenumberurl := le.proceedingscasenumberurl <> ri.proceedingscasenumberurl;
    SELF.Diff_caseid := le.caseid <> ri.caseid;
    SELF.Diff_pacercaseid := le.pacercaseid <> ri.pacercaseid;
    SELF.Diff_attachmenturl := le.attachmenturl <> ri.attachmenturl;
    SELF.Diff_entrynumber := le.entrynumber <> ri.entrynumber;
    SELF.Diff_entereddate := le.entereddate <> ri.entereddate;
    SELF.Diff_pacer_entereddate := le.pacer_entereddate <> ri.pacer_entereddate;
    SELF.Diff_fileddate := le.fileddate <> ri.fileddate;
    SELF.Diff_score := le.score <> ri.score;
    SELF.Diff_drcategoryeventid := le.drcategoryeventid <> ri.drcategoryeventid;
    SELF.Diff_court_code := le.court_code <> ri.court_code;
    SELF.Diff_district := le.district <> ri.district;
    SELF.Diff_boca_court := le.boca_court <> ri.boca_court;
    SELF.Diff_catevent_description := le.catevent_description <> ri.catevent_description;
    SELF.Diff_catevent_category := le.catevent_category <> ri.catevent_category;
    SELF.Val := (SALT311.StrType)evaluate(le,pivot_exp);
    SELF.Num_Diffs := 0+ IF( SELF.Diff_dractivitytypecode,1,0)+ IF( SELF.Diff_docketentryid,1,0)+ IF( SELF.Diff_courtid,1,0)+ IF( SELF.Diff_casekey,1,0)+ IF( SELF.Diff_casetype,1,0)+ IF( SELF.Diff_bkcasenumber,1,0)+ IF( SELF.Diff_bkcasenumberurl,1,0)+ IF( SELF.Diff_proceedingscasenumber,1,0)+ IF( SELF.Diff_proceedingscasenumberurl,1,0)+ IF( SELF.Diff_caseid,1,0)+ IF( SELF.Diff_pacercaseid,1,0)+ IF( SELF.Diff_attachmenturl,1,0)+ IF( SELF.Diff_entrynumber,1,0)+ IF( SELF.Diff_entereddate,1,0)+ IF( SELF.Diff_pacer_entereddate,1,0)+ IF( SELF.Diff_fileddate,1,0)+ IF( SELF.Diff_score,1,0)+ IF( SELF.Diff_drcategoryeventid,1,0)+ IF( SELF.Diff_court_code,1,0)+ IF( SELF.Diff_district,1,0)+ IF( SELF.Diff_boca_court,1,0)+ IF( SELF.Diff_catevent_description,1,0)+ IF( SELF.Diff_catevent_category,1,0);
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
    Count_Diff_dractivitytypecode := COUNT(GROUP,%Closest%.Diff_dractivitytypecode);
    Count_Diff_docketentryid := COUNT(GROUP,%Closest%.Diff_docketentryid);
    Count_Diff_courtid := COUNT(GROUP,%Closest%.Diff_courtid);
    Count_Diff_casekey := COUNT(GROUP,%Closest%.Diff_casekey);
    Count_Diff_casetype := COUNT(GROUP,%Closest%.Diff_casetype);
    Count_Diff_bkcasenumber := COUNT(GROUP,%Closest%.Diff_bkcasenumber);
    Count_Diff_bkcasenumberurl := COUNT(GROUP,%Closest%.Diff_bkcasenumberurl);
    Count_Diff_proceedingscasenumber := COUNT(GROUP,%Closest%.Diff_proceedingscasenumber);
    Count_Diff_proceedingscasenumberurl := COUNT(GROUP,%Closest%.Diff_proceedingscasenumberurl);
    Count_Diff_caseid := COUNT(GROUP,%Closest%.Diff_caseid);
    Count_Diff_pacercaseid := COUNT(GROUP,%Closest%.Diff_pacercaseid);
    Count_Diff_attachmenturl := COUNT(GROUP,%Closest%.Diff_attachmenturl);
    Count_Diff_entrynumber := COUNT(GROUP,%Closest%.Diff_entrynumber);
    Count_Diff_entereddate := COUNT(GROUP,%Closest%.Diff_entereddate);
    Count_Diff_pacer_entereddate := COUNT(GROUP,%Closest%.Diff_pacer_entereddate);
    Count_Diff_fileddate := COUNT(GROUP,%Closest%.Diff_fileddate);
    Count_Diff_score := COUNT(GROUP,%Closest%.Diff_score);
    Count_Diff_drcategoryeventid := COUNT(GROUP,%Closest%.Diff_drcategoryeventid);
    Count_Diff_court_code := COUNT(GROUP,%Closest%.Diff_court_code);
    Count_Diff_district := COUNT(GROUP,%Closest%.Diff_district);
    Count_Diff_boca_court := COUNT(GROUP,%Closest%.Diff_boca_court);
    Count_Diff_catevent_description := COUNT(GROUP,%Closest%.Diff_catevent_description);
    Count_Diff_catevent_category := COUNT(GROUP,%Closest%.Diff_catevent_category);
  END;
  out_counts := table(%Closest%,%AggRec%,true);
ENDMACRO;
END;
