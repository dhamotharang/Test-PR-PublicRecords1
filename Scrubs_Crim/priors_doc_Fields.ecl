IMPORT ut,SALT33;
IMPORT Scrubs; // Import modules for FieldTypes attribute definitions
EXPORT priors_doc_Fields := MODULE
// Processing for each FieldType
EXPORT SALT33.StrType FieldTypeName(UNSIGNED2 i) := CHOOSE(i,'Invalid_Record_ID','Invalid_Char','Non_Blank','Invalid_Current_Date','Invalid_Future_Date','Invalid_Num');
EXPORT FieldTypeNum(SALT33.StrType fn) := CASE(fn,'Invalid_Record_ID' => 1,'Invalid_Char' => 2,'Non_Blank' => 3,'Invalid_Current_Date' => 4,'Invalid_Future_Date' => 5,'Invalid_Num' => 6,0);
EXPORT MakeFT_Invalid_Record_ID(SALT33.StrType s0) := FUNCTION
  s1 := SALT33.stringfilter(s0,'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789_'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_Invalid_Record_ID(SALT33.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT33.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789_'))));
EXPORT InValidMessageFT_Invalid_Record_ID(UNSIGNED1 wh) := CHOOSE(wh,SALT33.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789_'),SALT33.HygieneErrors.Good);
EXPORT MakeFT_Invalid_Char(SALT33.StrType s0) := FUNCTION
  s1 := SALT33.stringfilter(s0,'ABCDEFGHIJKLMNOPQRSTUVWXYZ'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_Invalid_Char(SALT33.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT33.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZ'))));
EXPORT InValidMessageFT_Invalid_Char(UNSIGNED1 wh) := CHOOSE(wh,SALT33.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWXYZ'),SALT33.HygieneErrors.Good);
EXPORT MakeFT_Non_Blank(SALT33.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_Non_Blank(SALT33.StrType s) := WHICH(~(LENGTH(TRIM(s)) >= 1));
EXPORT InValidMessageFT_Non_Blank(UNSIGNED1 wh) := CHOOSE(wh,SALT33.HygieneErrors.NotLength('1..'),SALT33.HygieneErrors.Good);
EXPORT MakeFT_Invalid_Current_Date(SALT33.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_Invalid_Current_Date(SALT33.StrType s) := WHICH(~Scrubs.fn_valid_date(s)>0);
EXPORT InValidMessageFT_Invalid_Current_Date(UNSIGNED1 wh) := CHOOSE(wh,SALT33.HygieneErrors.CustomFail('Scrubs.fn_valid_date'),SALT33.HygieneErrors.Good);
EXPORT MakeFT_Invalid_Future_Date(SALT33.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_Invalid_Future_Date(SALT33.StrType s) := WHICH(~Scrubs.fn_valid_date(s,'future')>0);
EXPORT InValidMessageFT_Invalid_Future_Date(UNSIGNED1 wh) := CHOOSE(wh,SALT33.HygieneErrors.CustomFail('Scrubs.fn_valid_date'),SALT33.HygieneErrors.Good);
EXPORT MakeFT_Invalid_Num(SALT33.StrType s0) := FUNCTION
  s1 := SALT33.stringfilter(s0,'0123456789.'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_Invalid_Num(SALT33.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT33.StringFilter(s,'0123456789.'))));
EXPORT InValidMessageFT_Invalid_Num(UNSIGNED1 wh) := CHOOSE(wh,SALT33.HygieneErrors.NotInChars('0123456789.'),SALT33.HygieneErrors.Good);
EXPORT SALT33.StrType FieldName(UNSIGNED2 i) := CHOOSE(i,'recordid','statecode','caseid','casenumber','offensedesc','offensedate','offensetype','offensedegree','offenseclass','disposition','dispositiondate','sentencedate','sentencebegindate','sentenceenddate','sentencetype','sentencemaxyears','sentencemaxmonths','sentencemaxdays','sentenceminyears','sentenceminmonths','sentencemindays','scheduledreleasedate','actualreleasedate','sentencestatus','communitysupervisioncounty','communitysupervisionyears','communitysupervisionmonths','communitysupervisiondays','sourcename','sourceid','vendor');
EXPORT FieldNum(SALT33.StrType fn) := CASE(fn,'recordid' => 0,'statecode' => 1,'caseid' => 2,'casenumber' => 3,'offensedesc' => 4,'offensedate' => 5,'offensetype' => 6,'offensedegree' => 7,'offenseclass' => 8,'disposition' => 9,'dispositiondate' => 10,'sentencedate' => 11,'sentencebegindate' => 12,'sentenceenddate' => 13,'sentencetype' => 14,'sentencemaxyears' => 15,'sentencemaxmonths' => 16,'sentencemaxdays' => 17,'sentenceminyears' => 18,'sentenceminmonths' => 19,'sentencemindays' => 20,'scheduledreleasedate' => 21,'actualreleasedate' => 22,'sentencestatus' => 23,'communitysupervisioncounty' => 24,'communitysupervisionyears' => 25,'communitysupervisionmonths' => 26,'communitysupervisiondays' => 27,'sourcename' => 28,'sourceid' => 29,'vendor' => 30,0);
//Individual field level validation
EXPORT Make_recordid(SALT33.StrType s0) := MakeFT_Invalid_Record_ID(s0);
EXPORT InValid_recordid(SALT33.StrType s) := InValidFT_Invalid_Record_ID(s);
EXPORT InValidMessage_recordid(UNSIGNED1 wh) := InValidMessageFT_Invalid_Record_ID(wh);
EXPORT Make_statecode(SALT33.StrType s0) := MakeFT_Invalid_Char(s0);
EXPORT InValid_statecode(SALT33.StrType s) := InValidFT_Invalid_Char(s);
EXPORT InValidMessage_statecode(UNSIGNED1 wh) := InValidMessageFT_Invalid_Char(wh);
EXPORT Make_caseid(SALT33.StrType s0) := MakeFT_Non_Blank(s0);
EXPORT InValid_caseid(SALT33.StrType s) := InValidFT_Non_Blank(s);
EXPORT InValidMessage_caseid(UNSIGNED1 wh) := InValidMessageFT_Non_Blank(wh);
EXPORT Make_casenumber(SALT33.StrType s0) := s0;
EXPORT InValid_casenumber(SALT33.StrType s) := FALSE;
EXPORT InValidMessage_casenumber(UNSIGNED1 wh) := '';
EXPORT Make_offensedesc(SALT33.StrType s0) := s0;
EXPORT InValid_offensedesc(SALT33.StrType s) := FALSE;
EXPORT InValidMessage_offensedesc(UNSIGNED1 wh) := '';
EXPORT Make_offensedate(SALT33.StrType s0) := MakeFT_Invalid_Current_Date(s0);
EXPORT InValid_offensedate(SALT33.StrType s) := InValidFT_Invalid_Current_Date(s);
EXPORT InValidMessage_offensedate(UNSIGNED1 wh) := InValidMessageFT_Invalid_Current_Date(wh);
EXPORT Make_offensetype(SALT33.StrType s0) := s0;
EXPORT InValid_offensetype(SALT33.StrType s) := FALSE;
EXPORT InValidMessage_offensetype(UNSIGNED1 wh) := '';
EXPORT Make_offensedegree(SALT33.StrType s0) := s0;
EXPORT InValid_offensedegree(SALT33.StrType s) := FALSE;
EXPORT InValidMessage_offensedegree(UNSIGNED1 wh) := '';
EXPORT Make_offenseclass(SALT33.StrType s0) := s0;
EXPORT InValid_offenseclass(SALT33.StrType s) := FALSE;
EXPORT InValidMessage_offenseclass(UNSIGNED1 wh) := '';
EXPORT Make_disposition(SALT33.StrType s0) := s0;
EXPORT InValid_disposition(SALT33.StrType s) := FALSE;
EXPORT InValidMessage_disposition(UNSIGNED1 wh) := '';
EXPORT Make_dispositiondate(SALT33.StrType s0) := MakeFT_Invalid_Current_Date(s0);
EXPORT InValid_dispositiondate(SALT33.StrType s) := InValidFT_Invalid_Current_Date(s);
EXPORT InValidMessage_dispositiondate(UNSIGNED1 wh) := InValidMessageFT_Invalid_Current_Date(wh);
EXPORT Make_sentencedate(SALT33.StrType s0) := MakeFT_Invalid_Future_Date(s0);
EXPORT InValid_sentencedate(SALT33.StrType s) := InValidFT_Invalid_Future_Date(s);
EXPORT InValidMessage_sentencedate(UNSIGNED1 wh) := InValidMessageFT_Invalid_Future_Date(wh);
EXPORT Make_sentencebegindate(SALT33.StrType s0) := MakeFT_Invalid_Future_Date(s0);
EXPORT InValid_sentencebegindate(SALT33.StrType s) := InValidFT_Invalid_Future_Date(s);
EXPORT InValidMessage_sentencebegindate(UNSIGNED1 wh) := InValidMessageFT_Invalid_Future_Date(wh);
EXPORT Make_sentenceenddate(SALT33.StrType s0) := MakeFT_Invalid_Future_Date(s0);
EXPORT InValid_sentenceenddate(SALT33.StrType s) := InValidFT_Invalid_Future_Date(s);
EXPORT InValidMessage_sentenceenddate(UNSIGNED1 wh) := InValidMessageFT_Invalid_Future_Date(wh);
EXPORT Make_sentencetype(SALT33.StrType s0) := s0;
EXPORT InValid_sentencetype(SALT33.StrType s) := FALSE;
EXPORT InValidMessage_sentencetype(UNSIGNED1 wh) := '';
EXPORT Make_sentencemaxyears(SALT33.StrType s0) := MakeFT_Invalid_Num(s0);
EXPORT InValid_sentencemaxyears(SALT33.StrType s) := InValidFT_Invalid_Num(s);
EXPORT InValidMessage_sentencemaxyears(UNSIGNED1 wh) := InValidMessageFT_Invalid_Num(wh);
EXPORT Make_sentencemaxmonths(SALT33.StrType s0) := MakeFT_Invalid_Num(s0);
EXPORT InValid_sentencemaxmonths(SALT33.StrType s) := InValidFT_Invalid_Num(s);
EXPORT InValidMessage_sentencemaxmonths(UNSIGNED1 wh) := InValidMessageFT_Invalid_Num(wh);
EXPORT Make_sentencemaxdays(SALT33.StrType s0) := MakeFT_Invalid_Num(s0);
EXPORT InValid_sentencemaxdays(SALT33.StrType s) := InValidFT_Invalid_Num(s);
EXPORT InValidMessage_sentencemaxdays(UNSIGNED1 wh) := InValidMessageFT_Invalid_Num(wh);
EXPORT Make_sentenceminyears(SALT33.StrType s0) := MakeFT_Invalid_Num(s0);
EXPORT InValid_sentenceminyears(SALT33.StrType s) := InValidFT_Invalid_Num(s);
EXPORT InValidMessage_sentenceminyears(UNSIGNED1 wh) := InValidMessageFT_Invalid_Num(wh);
EXPORT Make_sentenceminmonths(SALT33.StrType s0) := MakeFT_Invalid_Num(s0);
EXPORT InValid_sentenceminmonths(SALT33.StrType s) := InValidFT_Invalid_Num(s);
EXPORT InValidMessage_sentenceminmonths(UNSIGNED1 wh) := InValidMessageFT_Invalid_Num(wh);
EXPORT Make_sentencemindays(SALT33.StrType s0) := MakeFT_Invalid_Num(s0);
EXPORT InValid_sentencemindays(SALT33.StrType s) := InValidFT_Invalid_Num(s);
EXPORT InValidMessage_sentencemindays(UNSIGNED1 wh) := InValidMessageFT_Invalid_Num(wh);
EXPORT Make_scheduledreleasedate(SALT33.StrType s0) := MakeFT_Invalid_Future_Date(s0);
EXPORT InValid_scheduledreleasedate(SALT33.StrType s) := InValidFT_Invalid_Future_Date(s);
EXPORT InValidMessage_scheduledreleasedate(UNSIGNED1 wh) := InValidMessageFT_Invalid_Future_Date(wh);
EXPORT Make_actualreleasedate(SALT33.StrType s0) := MakeFT_Invalid_Future_Date(s0);
EXPORT InValid_actualreleasedate(SALT33.StrType s) := InValidFT_Invalid_Future_Date(s);
EXPORT InValidMessage_actualreleasedate(UNSIGNED1 wh) := InValidMessageFT_Invalid_Future_Date(wh);
EXPORT Make_sentencestatus(SALT33.StrType s0) := s0;
EXPORT InValid_sentencestatus(SALT33.StrType s) := FALSE;
EXPORT InValidMessage_sentencestatus(UNSIGNED1 wh) := '';
EXPORT Make_communitysupervisioncounty(SALT33.StrType s0) := s0;
EXPORT InValid_communitysupervisioncounty(SALT33.StrType s) := FALSE;
EXPORT InValidMessage_communitysupervisioncounty(UNSIGNED1 wh) := '';
EXPORT Make_communitysupervisionyears(SALT33.StrType s0) := MakeFT_Invalid_Num(s0);
EXPORT InValid_communitysupervisionyears(SALT33.StrType s) := InValidFT_Invalid_Num(s);
EXPORT InValidMessage_communitysupervisionyears(UNSIGNED1 wh) := InValidMessageFT_Invalid_Num(wh);
EXPORT Make_communitysupervisionmonths(SALT33.StrType s0) := MakeFT_Invalid_Num(s0);
EXPORT InValid_communitysupervisionmonths(SALT33.StrType s) := InValidFT_Invalid_Num(s);
EXPORT InValidMessage_communitysupervisionmonths(UNSIGNED1 wh) := InValidMessageFT_Invalid_Num(wh);
EXPORT Make_communitysupervisiondays(SALT33.StrType s0) := MakeFT_Invalid_Num(s0);
EXPORT InValid_communitysupervisiondays(SALT33.StrType s) := InValidFT_Invalid_Num(s);
EXPORT InValidMessage_communitysupervisiondays(UNSIGNED1 wh) := InValidMessageFT_Invalid_Num(wh);
EXPORT Make_sourcename(SALT33.StrType s0) := MakeFT_Non_Blank(s0);
EXPORT InValid_sourcename(SALT33.StrType s) := InValidFT_Non_Blank(s);
EXPORT InValidMessage_sourcename(UNSIGNED1 wh) := InValidMessageFT_Non_Blank(wh);
EXPORT Make_sourceid(SALT33.StrType s0) := MakeFT_Invalid_Num(s0);
EXPORT InValid_sourceid(SALT33.StrType s) := InValidFT_Invalid_Num(s);
EXPORT InValidMessage_sourceid(UNSIGNED1 wh) := InValidMessageFT_Invalid_Num(wh);
EXPORT Make_vendor(SALT33.StrType s0) := s0;
EXPORT InValid_vendor(SALT33.StrType s) := FALSE;
EXPORT InValidMessage_vendor(UNSIGNED1 wh) := '';
// This macro will compute and count field level differences based upon a pivot expression
export MAC_CountDifferencesByPivot(in_left,in_right,pivot_exp,bad_pivots,out_counts) := MACRO
  IMPORT SALT33,Scrubs_Crim;
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
    BOOLEAN Diff_caseid;
    BOOLEAN Diff_casenumber;
    BOOLEAN Diff_offensedesc;
    BOOLEAN Diff_offensedate;
    BOOLEAN Diff_offensetype;
    BOOLEAN Diff_offensedegree;
    BOOLEAN Diff_offenseclass;
    BOOLEAN Diff_disposition;
    BOOLEAN Diff_dispositiondate;
    BOOLEAN Diff_sentencedate;
    BOOLEAN Diff_sentencebegindate;
    BOOLEAN Diff_sentenceenddate;
    BOOLEAN Diff_sentencetype;
    BOOLEAN Diff_sentencemaxyears;
    BOOLEAN Diff_sentencemaxmonths;
    BOOLEAN Diff_sentencemaxdays;
    BOOLEAN Diff_sentenceminyears;
    BOOLEAN Diff_sentenceminmonths;
    BOOLEAN Diff_sentencemindays;
    BOOLEAN Diff_scheduledreleasedate;
    BOOLEAN Diff_actualreleasedate;
    BOOLEAN Diff_sentencestatus;
    BOOLEAN Diff_communitysupervisioncounty;
    BOOLEAN Diff_communitysupervisionyears;
    BOOLEAN Diff_communitysupervisionmonths;
    BOOLEAN Diff_communitysupervisiondays;
    BOOLEAN Diff_sourcename;
    BOOLEAN Diff_sourceid;
    BOOLEAN Diff_vendor;
    SALT33.StrType SourceField {MAXLENGTH(30)};
    UNSIGNED Num_Diffs;
    SALT33.StrType Val {MAXLENGTH(1024)};
  END;
#uniquename(fd)
  %dl% %fd%(in_left le,in_right ri) := TRANSFORM
    SELF.Diff_recordid := le.recordid <> ri.recordid;
    SELF.Diff_statecode := le.statecode <> ri.statecode;
    SELF.Diff_caseid := le.caseid <> ri.caseid;
    SELF.Diff_casenumber := le.casenumber <> ri.casenumber;
    SELF.Diff_offensedesc := le.offensedesc <> ri.offensedesc;
    SELF.Diff_offensedate := le.offensedate <> ri.offensedate;
    SELF.Diff_offensetype := le.offensetype <> ri.offensetype;
    SELF.Diff_offensedegree := le.offensedegree <> ri.offensedegree;
    SELF.Diff_offenseclass := le.offenseclass <> ri.offenseclass;
    SELF.Diff_disposition := le.disposition <> ri.disposition;
    SELF.Diff_dispositiondate := le.dispositiondate <> ri.dispositiondate;
    SELF.Diff_sentencedate := le.sentencedate <> ri.sentencedate;
    SELF.Diff_sentencebegindate := le.sentencebegindate <> ri.sentencebegindate;
    SELF.Diff_sentenceenddate := le.sentenceenddate <> ri.sentenceenddate;
    SELF.Diff_sentencetype := le.sentencetype <> ri.sentencetype;
    SELF.Diff_sentencemaxyears := le.sentencemaxyears <> ri.sentencemaxyears;
    SELF.Diff_sentencemaxmonths := le.sentencemaxmonths <> ri.sentencemaxmonths;
    SELF.Diff_sentencemaxdays := le.sentencemaxdays <> ri.sentencemaxdays;
    SELF.Diff_sentenceminyears := le.sentenceminyears <> ri.sentenceminyears;
    SELF.Diff_sentenceminmonths := le.sentenceminmonths <> ri.sentenceminmonths;
    SELF.Diff_sentencemindays := le.sentencemindays <> ri.sentencemindays;
    SELF.Diff_scheduledreleasedate := le.scheduledreleasedate <> ri.scheduledreleasedate;
    SELF.Diff_actualreleasedate := le.actualreleasedate <> ri.actualreleasedate;
    SELF.Diff_sentencestatus := le.sentencestatus <> ri.sentencestatus;
    SELF.Diff_communitysupervisioncounty := le.communitysupervisioncounty <> ri.communitysupervisioncounty;
    SELF.Diff_communitysupervisionyears := le.communitysupervisionyears <> ri.communitysupervisionyears;
    SELF.Diff_communitysupervisionmonths := le.communitysupervisionmonths <> ri.communitysupervisionmonths;
    SELF.Diff_communitysupervisiondays := le.communitysupervisiondays <> ri.communitysupervisiondays;
    SELF.Diff_sourcename := le.sourcename <> ri.sourcename;
    SELF.Diff_sourceid := le.sourceid <> ri.sourceid;
    SELF.Diff_vendor := le.vendor <> ri.vendor;
    SELF.Val := (SALT33.StrType)evaluate(le,pivot_exp);
    SELF.SourceField := le.vendor;
    SELF.Num_Diffs := 0+ IF( SELF.Diff_recordid,1,0)+ IF( SELF.Diff_statecode,1,0)+ IF( SELF.Diff_caseid,1,0)+ IF( SELF.Diff_casenumber,1,0)+ IF( SELF.Diff_offensedesc,1,0)+ IF( SELF.Diff_offensedate,1,0)+ IF( SELF.Diff_offensetype,1,0)+ IF( SELF.Diff_offensedegree,1,0)+ IF( SELF.Diff_offenseclass,1,0)+ IF( SELF.Diff_disposition,1,0)+ IF( SELF.Diff_dispositiondate,1,0)+ IF( SELF.Diff_sentencedate,1,0)+ IF( SELF.Diff_sentencebegindate,1,0)+ IF( SELF.Diff_sentenceenddate,1,0)+ IF( SELF.Diff_sentencetype,1,0)+ IF( SELF.Diff_sentencemaxyears,1,0)+ IF( SELF.Diff_sentencemaxmonths,1,0)+ IF( SELF.Diff_sentencemaxdays,1,0)+ IF( SELF.Diff_sentenceminyears,1,0)+ IF( SELF.Diff_sentenceminmonths,1,0)+ IF( SELF.Diff_sentencemindays,1,0)+ IF( SELF.Diff_scheduledreleasedate,1,0)+ IF( SELF.Diff_actualreleasedate,1,0)+ IF( SELF.Diff_sentencestatus,1,0)+ IF( SELF.Diff_communitysupervisioncounty,1,0)+ IF( SELF.Diff_communitysupervisionyears,1,0)+ IF( SELF.Diff_communitysupervisionmonths,1,0)+ IF( SELF.Diff_communitysupervisiondays,1,0)+ IF( SELF.Diff_sourcename,1,0)+ IF( SELF.Diff_sourceid,1,0)+ IF( SELF.Diff_vendor,1,0);
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
    Count_Diff_caseid := COUNT(GROUP,%Closest%.Diff_caseid);
    Count_Diff_casenumber := COUNT(GROUP,%Closest%.Diff_casenumber);
    Count_Diff_offensedesc := COUNT(GROUP,%Closest%.Diff_offensedesc);
    Count_Diff_offensedate := COUNT(GROUP,%Closest%.Diff_offensedate);
    Count_Diff_offensetype := COUNT(GROUP,%Closest%.Diff_offensetype);
    Count_Diff_offensedegree := COUNT(GROUP,%Closest%.Diff_offensedegree);
    Count_Diff_offenseclass := COUNT(GROUP,%Closest%.Diff_offenseclass);
    Count_Diff_disposition := COUNT(GROUP,%Closest%.Diff_disposition);
    Count_Diff_dispositiondate := COUNT(GROUP,%Closest%.Diff_dispositiondate);
    Count_Diff_sentencedate := COUNT(GROUP,%Closest%.Diff_sentencedate);
    Count_Diff_sentencebegindate := COUNT(GROUP,%Closest%.Diff_sentencebegindate);
    Count_Diff_sentenceenddate := COUNT(GROUP,%Closest%.Diff_sentenceenddate);
    Count_Diff_sentencetype := COUNT(GROUP,%Closest%.Diff_sentencetype);
    Count_Diff_sentencemaxyears := COUNT(GROUP,%Closest%.Diff_sentencemaxyears);
    Count_Diff_sentencemaxmonths := COUNT(GROUP,%Closest%.Diff_sentencemaxmonths);
    Count_Diff_sentencemaxdays := COUNT(GROUP,%Closest%.Diff_sentencemaxdays);
    Count_Diff_sentenceminyears := COUNT(GROUP,%Closest%.Diff_sentenceminyears);
    Count_Diff_sentenceminmonths := COUNT(GROUP,%Closest%.Diff_sentenceminmonths);
    Count_Diff_sentencemindays := COUNT(GROUP,%Closest%.Diff_sentencemindays);
    Count_Diff_scheduledreleasedate := COUNT(GROUP,%Closest%.Diff_scheduledreleasedate);
    Count_Diff_actualreleasedate := COUNT(GROUP,%Closest%.Diff_actualreleasedate);
    Count_Diff_sentencestatus := COUNT(GROUP,%Closest%.Diff_sentencestatus);
    Count_Diff_communitysupervisioncounty := COUNT(GROUP,%Closest%.Diff_communitysupervisioncounty);
    Count_Diff_communitysupervisionyears := COUNT(GROUP,%Closest%.Diff_communitysupervisionyears);
    Count_Diff_communitysupervisionmonths := COUNT(GROUP,%Closest%.Diff_communitysupervisionmonths);
    Count_Diff_communitysupervisiondays := COUNT(GROUP,%Closest%.Diff_communitysupervisiondays);
    Count_Diff_sourcename := COUNT(GROUP,%Closest%.Diff_sourcename);
    Count_Diff_sourceid := COUNT(GROUP,%Closest%.Diff_sourceid);
    Count_Diff_vendor := COUNT(GROUP,%Closest%.Diff_vendor);
    %Closest%.SourceField;
  END;
  out_counts := table(%Closest%,%AggRec%,SourceField,few);
ENDMACRO;
END;
