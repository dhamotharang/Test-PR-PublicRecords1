IMPORT SALT311;
IMPORT Scrubs; // Import modules for FieldTypes attribute definitions
EXPORT sentence_counties_Fields := MODULE
 
EXPORT NumFields := 49;
 
// Processing for each FieldType
EXPORT SALT311.StrType FieldTypeName(UNSIGNED2 i) := CHOOSE(i,'Invalid_Record_ID','Invalid_Char','Non_Blank','Invalid_Future_Date','Invalid_Num','Invalid_Time');
EXPORT FieldTypeNum(SALT311.StrType fn) := CASE(fn,'Invalid_Record_ID' => 1,'Invalid_Char' => 2,'Non_Blank' => 3,'Invalid_Future_Date' => 4,'Invalid_Num' => 5,'Invalid_Time' => 6,0);
 
EXPORT MakeFT_Invalid_Record_ID(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringfilter(s0,'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789_'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_Invalid_Record_ID(SALT311.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT311.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789_'))));
EXPORT InValidMessageFT_Invalid_Record_ID(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789_'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_Invalid_Char(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringfilter(s0,'ABCDEFGHIJKLMNOPQRSTUVWXYZ'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_Invalid_Char(SALT311.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT311.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZ'))));
EXPORT InValidMessageFT_Invalid_Char(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWXYZ'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_Non_Blank(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_Non_Blank(SALT311.StrType s) := WHICH(~(LENGTH(TRIM(s)) >= 1));
EXPORT InValidMessageFT_Non_Blank(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotLength('1..'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_Invalid_Future_Date(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_Invalid_Future_Date(SALT311.StrType s) := WHICH(~Scrubs.fn_valid_date(s,'future')>0);
EXPORT InValidMessageFT_Invalid_Future_Date(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('Scrubs.fn_valid_date'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_Invalid_Num(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringfilter(s0,'0123456789.'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_Invalid_Num(SALT311.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT311.StringFilter(s,'0123456789.'))));
EXPORT InValidMessageFT_Invalid_Num(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInChars('0123456789.'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_Invalid_Time(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringfilter(s0,'0123456789. DAYSMONTHYERLIF/'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_Invalid_Time(SALT311.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT311.StringFilter(s,'0123456789. DAYSMONTHYERLIF/'))));
EXPORT InValidMessageFT_Invalid_Time(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInChars('0123456789. DAYSMONTHYERLIF/'),SALT311.HygieneErrors.Good);
 
EXPORT SALT311.StrType FieldName(UNSIGNED2 i) := CHOOSE(i,'recordid','statecode','caseid','sentencedate','sentencebegindate','sentenceenddate','sentencetype','sentencemaxyears','sentencemaxmonths','sentencemaxdays','sentenceminyears','sentenceminmonths','sentencemindays','scheduledreleasedate','actualreleasedate','sentencestatus','timeservedyears','timeservedmonths','timeserveddays','publicservicehours','sentenceadditionalinfo','communitysupervisioncounty','communitysupervisionyears','communitysupervisionmonths','communitysupervisiondays','parolebegindate','paroleenddate','paroleeligibilitydate','parolehearingdate','parolemaxyears','parolemaxmonths','parolemaxdays','paroleminyears','paroleminmonths','parolemindays','parolestatus','paroleofficer','paroleoffcerphone','probationbegindate','probationenddate','probationmaxyears','probationmaxmonths','probationmaxdays','probationminyears','probationminmonths','probationmindays','probationstatus','sourcename','vendor');
EXPORT SALT311.StrType FlatName(UNSIGNED2 i) := CHOOSE(i,'recordid','statecode','caseid','sentencedate','sentencebegindate','sentenceenddate','sentencetype','sentencemaxyears','sentencemaxmonths','sentencemaxdays','sentenceminyears','sentenceminmonths','sentencemindays','scheduledreleasedate','actualreleasedate','sentencestatus','timeservedyears','timeservedmonths','timeserveddays','publicservicehours','sentenceadditionalinfo','communitysupervisioncounty','communitysupervisionyears','communitysupervisionmonths','communitysupervisiondays','parolebegindate','paroleenddate','paroleeligibilitydate','parolehearingdate','parolemaxyears','parolemaxmonths','parolemaxdays','paroleminyears','paroleminmonths','parolemindays','parolestatus','paroleofficer','paroleoffcerphone','probationbegindate','probationenddate','probationmaxyears','probationmaxmonths','probationmaxdays','probationminyears','probationminmonths','probationmindays','probationstatus','sourcename','vendor');
EXPORT FieldNum(SALT311.StrType fn) := CASE(fn,'recordid' => 0,'statecode' => 1,'caseid' => 2,'sentencedate' => 3,'sentencebegindate' => 4,'sentenceenddate' => 5,'sentencetype' => 6,'sentencemaxyears' => 7,'sentencemaxmonths' => 8,'sentencemaxdays' => 9,'sentenceminyears' => 10,'sentenceminmonths' => 11,'sentencemindays' => 12,'scheduledreleasedate' => 13,'actualreleasedate' => 14,'sentencestatus' => 15,'timeservedyears' => 16,'timeservedmonths' => 17,'timeserveddays' => 18,'publicservicehours' => 19,'sentenceadditionalinfo' => 20,'communitysupervisioncounty' => 21,'communitysupervisionyears' => 22,'communitysupervisionmonths' => 23,'communitysupervisiondays' => 24,'parolebegindate' => 25,'paroleenddate' => 26,'paroleeligibilitydate' => 27,'parolehearingdate' => 28,'parolemaxyears' => 29,'parolemaxmonths' => 30,'parolemaxdays' => 31,'paroleminyears' => 32,'paroleminmonths' => 33,'parolemindays' => 34,'parolestatus' => 35,'paroleofficer' => 36,'paroleoffcerphone' => 37,'probationbegindate' => 38,'probationenddate' => 39,'probationmaxyears' => 40,'probationmaxmonths' => 41,'probationmaxdays' => 42,'probationminyears' => 43,'probationminmonths' => 44,'probationmindays' => 45,'probationstatus' => 46,'sourcename' => 47,'vendor' => 48,0);
EXPORT SET OF SALT311.StrType FieldRules(UNSIGNED2 i) := CHOOSE(i,['ALLOW'],['ALLOW'],['LENGTHS'],['CUSTOM'],['CUSTOM'],['CUSTOM'],[],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['CUSTOM'],['CUSTOM'],[],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],[],[],['ALLOW'],['ALLOW'],['ALLOW'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],[],[],[],['CUSTOM'],['CUSTOM'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],[],['LENGTHS'],[],[]);
EXPORT BOOLEAN InBaseLayout(UNSIGNED2 i) := CHOOSE(i,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,FALSE);
 
//Individual field level validation
 
EXPORT Make_recordid(SALT311.StrType s0) := MakeFT_Invalid_Record_ID(s0);
EXPORT InValid_recordid(SALT311.StrType s) := InValidFT_Invalid_Record_ID(s);
EXPORT InValidMessage_recordid(UNSIGNED1 wh) := InValidMessageFT_Invalid_Record_ID(wh);
 
EXPORT Make_statecode(SALT311.StrType s0) := MakeFT_Invalid_Char(s0);
EXPORT InValid_statecode(SALT311.StrType s) := InValidFT_Invalid_Char(s);
EXPORT InValidMessage_statecode(UNSIGNED1 wh) := InValidMessageFT_Invalid_Char(wh);
 
EXPORT Make_caseid(SALT311.StrType s0) := MakeFT_Non_Blank(s0);
EXPORT InValid_caseid(SALT311.StrType s) := InValidFT_Non_Blank(s);
EXPORT InValidMessage_caseid(UNSIGNED1 wh) := InValidMessageFT_Non_Blank(wh);
 
EXPORT Make_sentencedate(SALT311.StrType s0) := MakeFT_Invalid_Future_Date(s0);
EXPORT InValid_sentencedate(SALT311.StrType s) := InValidFT_Invalid_Future_Date(s);
EXPORT InValidMessage_sentencedate(UNSIGNED1 wh) := InValidMessageFT_Invalid_Future_Date(wh);
 
EXPORT Make_sentencebegindate(SALT311.StrType s0) := MakeFT_Invalid_Future_Date(s0);
EXPORT InValid_sentencebegindate(SALT311.StrType s) := InValidFT_Invalid_Future_Date(s);
EXPORT InValidMessage_sentencebegindate(UNSIGNED1 wh) := InValidMessageFT_Invalid_Future_Date(wh);
 
EXPORT Make_sentenceenddate(SALT311.StrType s0) := MakeFT_Invalid_Future_Date(s0);
EXPORT InValid_sentenceenddate(SALT311.StrType s) := InValidFT_Invalid_Future_Date(s);
EXPORT InValidMessage_sentenceenddate(UNSIGNED1 wh) := InValidMessageFT_Invalid_Future_Date(wh);
 
EXPORT Make_sentencetype(SALT311.StrType s0) := s0;
EXPORT InValid_sentencetype(SALT311.StrType s) := 0;
EXPORT InValidMessage_sentencetype(UNSIGNED1 wh) := '';
 
EXPORT Make_sentencemaxyears(SALT311.StrType s0) := MakeFT_Invalid_Time(s0);
EXPORT InValid_sentencemaxyears(SALT311.StrType s) := InValidFT_Invalid_Time(s);
EXPORT InValidMessage_sentencemaxyears(UNSIGNED1 wh) := InValidMessageFT_Invalid_Time(wh);
 
EXPORT Make_sentencemaxmonths(SALT311.StrType s0) := MakeFT_Invalid_Time(s0);
EXPORT InValid_sentencemaxmonths(SALT311.StrType s) := InValidFT_Invalid_Time(s);
EXPORT InValidMessage_sentencemaxmonths(UNSIGNED1 wh) := InValidMessageFT_Invalid_Time(wh);
 
EXPORT Make_sentencemaxdays(SALT311.StrType s0) := MakeFT_Invalid_Time(s0);
EXPORT InValid_sentencemaxdays(SALT311.StrType s) := InValidFT_Invalid_Time(s);
EXPORT InValidMessage_sentencemaxdays(UNSIGNED1 wh) := InValidMessageFT_Invalid_Time(wh);
 
EXPORT Make_sentenceminyears(SALT311.StrType s0) := MakeFT_Invalid_Time(s0);
EXPORT InValid_sentenceminyears(SALT311.StrType s) := InValidFT_Invalid_Time(s);
EXPORT InValidMessage_sentenceminyears(UNSIGNED1 wh) := InValidMessageFT_Invalid_Time(wh);
 
EXPORT Make_sentenceminmonths(SALT311.StrType s0) := MakeFT_Invalid_Time(s0);
EXPORT InValid_sentenceminmonths(SALT311.StrType s) := InValidFT_Invalid_Time(s);
EXPORT InValidMessage_sentenceminmonths(UNSIGNED1 wh) := InValidMessageFT_Invalid_Time(wh);
 
EXPORT Make_sentencemindays(SALT311.StrType s0) := MakeFT_Invalid_Time(s0);
EXPORT InValid_sentencemindays(SALT311.StrType s) := InValidFT_Invalid_Time(s);
EXPORT InValidMessage_sentencemindays(UNSIGNED1 wh) := InValidMessageFT_Invalid_Time(wh);
 
EXPORT Make_scheduledreleasedate(SALT311.StrType s0) := MakeFT_Invalid_Future_Date(s0);
EXPORT InValid_scheduledreleasedate(SALT311.StrType s) := InValidFT_Invalid_Future_Date(s);
EXPORT InValidMessage_scheduledreleasedate(UNSIGNED1 wh) := InValidMessageFT_Invalid_Future_Date(wh);
 
EXPORT Make_actualreleasedate(SALT311.StrType s0) := MakeFT_Invalid_Future_Date(s0);
EXPORT InValid_actualreleasedate(SALT311.StrType s) := InValidFT_Invalid_Future_Date(s);
EXPORT InValidMessage_actualreleasedate(UNSIGNED1 wh) := InValidMessageFT_Invalid_Future_Date(wh);
 
EXPORT Make_sentencestatus(SALT311.StrType s0) := s0;
EXPORT InValid_sentencestatus(SALT311.StrType s) := 0;
EXPORT InValidMessage_sentencestatus(UNSIGNED1 wh) := '';
 
EXPORT Make_timeservedyears(SALT311.StrType s0) := MakeFT_Invalid_Time(s0);
EXPORT InValid_timeservedyears(SALT311.StrType s) := InValidFT_Invalid_Time(s);
EXPORT InValidMessage_timeservedyears(UNSIGNED1 wh) := InValidMessageFT_Invalid_Time(wh);
 
EXPORT Make_timeservedmonths(SALT311.StrType s0) := MakeFT_Invalid_Time(s0);
EXPORT InValid_timeservedmonths(SALT311.StrType s) := InValidFT_Invalid_Time(s);
EXPORT InValidMessage_timeservedmonths(UNSIGNED1 wh) := InValidMessageFT_Invalid_Time(wh);
 
EXPORT Make_timeserveddays(SALT311.StrType s0) := MakeFT_Invalid_Time(s0);
EXPORT InValid_timeserveddays(SALT311.StrType s) := InValidFT_Invalid_Time(s);
EXPORT InValidMessage_timeserveddays(UNSIGNED1 wh) := InValidMessageFT_Invalid_Time(wh);
 
EXPORT Make_publicservicehours(SALT311.StrType s0) := MakeFT_Invalid_Num(s0);
EXPORT InValid_publicservicehours(SALT311.StrType s) := InValidFT_Invalid_Num(s);
EXPORT InValidMessage_publicservicehours(UNSIGNED1 wh) := InValidMessageFT_Invalid_Num(wh);
 
EXPORT Make_sentenceadditionalinfo(SALT311.StrType s0) := s0;
EXPORT InValid_sentenceadditionalinfo(SALT311.StrType s) := 0;
EXPORT InValidMessage_sentenceadditionalinfo(UNSIGNED1 wh) := '';
 
EXPORT Make_communitysupervisioncounty(SALT311.StrType s0) := s0;
EXPORT InValid_communitysupervisioncounty(SALT311.StrType s) := 0;
EXPORT InValidMessage_communitysupervisioncounty(UNSIGNED1 wh) := '';
 
EXPORT Make_communitysupervisionyears(SALT311.StrType s0) := MakeFT_Invalid_Time(s0);
EXPORT InValid_communitysupervisionyears(SALT311.StrType s) := InValidFT_Invalid_Time(s);
EXPORT InValidMessage_communitysupervisionyears(UNSIGNED1 wh) := InValidMessageFT_Invalid_Time(wh);
 
EXPORT Make_communitysupervisionmonths(SALT311.StrType s0) := MakeFT_Invalid_Time(s0);
EXPORT InValid_communitysupervisionmonths(SALT311.StrType s) := InValidFT_Invalid_Time(s);
EXPORT InValidMessage_communitysupervisionmonths(UNSIGNED1 wh) := InValidMessageFT_Invalid_Time(wh);
 
EXPORT Make_communitysupervisiondays(SALT311.StrType s0) := MakeFT_Invalid_Time(s0);
EXPORT InValid_communitysupervisiondays(SALT311.StrType s) := InValidFT_Invalid_Time(s);
EXPORT InValidMessage_communitysupervisiondays(UNSIGNED1 wh) := InValidMessageFT_Invalid_Time(wh);
 
EXPORT Make_parolebegindate(SALT311.StrType s0) := MakeFT_Invalid_Future_Date(s0);
EXPORT InValid_parolebegindate(SALT311.StrType s) := InValidFT_Invalid_Future_Date(s);
EXPORT InValidMessage_parolebegindate(UNSIGNED1 wh) := InValidMessageFT_Invalid_Future_Date(wh);
 
EXPORT Make_paroleenddate(SALT311.StrType s0) := MakeFT_Invalid_Future_Date(s0);
EXPORT InValid_paroleenddate(SALT311.StrType s) := InValidFT_Invalid_Future_Date(s);
EXPORT InValidMessage_paroleenddate(UNSIGNED1 wh) := InValidMessageFT_Invalid_Future_Date(wh);
 
EXPORT Make_paroleeligibilitydate(SALT311.StrType s0) := MakeFT_Invalid_Future_Date(s0);
EXPORT InValid_paroleeligibilitydate(SALT311.StrType s) := InValidFT_Invalid_Future_Date(s);
EXPORT InValidMessage_paroleeligibilitydate(UNSIGNED1 wh) := InValidMessageFT_Invalid_Future_Date(wh);
 
EXPORT Make_parolehearingdate(SALT311.StrType s0) := MakeFT_Invalid_Future_Date(s0);
EXPORT InValid_parolehearingdate(SALT311.StrType s) := InValidFT_Invalid_Future_Date(s);
EXPORT InValidMessage_parolehearingdate(UNSIGNED1 wh) := InValidMessageFT_Invalid_Future_Date(wh);
 
EXPORT Make_parolemaxyears(SALT311.StrType s0) := MakeFT_Invalid_Time(s0);
EXPORT InValid_parolemaxyears(SALT311.StrType s) := InValidFT_Invalid_Time(s);
EXPORT InValidMessage_parolemaxyears(UNSIGNED1 wh) := InValidMessageFT_Invalid_Time(wh);
 
EXPORT Make_parolemaxmonths(SALT311.StrType s0) := MakeFT_Invalid_Time(s0);
EXPORT InValid_parolemaxmonths(SALT311.StrType s) := InValidFT_Invalid_Time(s);
EXPORT InValidMessage_parolemaxmonths(UNSIGNED1 wh) := InValidMessageFT_Invalid_Time(wh);
 
EXPORT Make_parolemaxdays(SALT311.StrType s0) := MakeFT_Invalid_Time(s0);
EXPORT InValid_parolemaxdays(SALT311.StrType s) := InValidFT_Invalid_Time(s);
EXPORT InValidMessage_parolemaxdays(UNSIGNED1 wh) := InValidMessageFT_Invalid_Time(wh);
 
EXPORT Make_paroleminyears(SALT311.StrType s0) := MakeFT_Invalid_Time(s0);
EXPORT InValid_paroleminyears(SALT311.StrType s) := InValidFT_Invalid_Time(s);
EXPORT InValidMessage_paroleminyears(UNSIGNED1 wh) := InValidMessageFT_Invalid_Time(wh);
 
EXPORT Make_paroleminmonths(SALT311.StrType s0) := MakeFT_Invalid_Time(s0);
EXPORT InValid_paroleminmonths(SALT311.StrType s) := InValidFT_Invalid_Time(s);
EXPORT InValidMessage_paroleminmonths(UNSIGNED1 wh) := InValidMessageFT_Invalid_Time(wh);
 
EXPORT Make_parolemindays(SALT311.StrType s0) := MakeFT_Invalid_Time(s0);
EXPORT InValid_parolemindays(SALT311.StrType s) := InValidFT_Invalid_Time(s);
EXPORT InValidMessage_parolemindays(UNSIGNED1 wh) := InValidMessageFT_Invalid_Time(wh);
 
EXPORT Make_parolestatus(SALT311.StrType s0) := s0;
EXPORT InValid_parolestatus(SALT311.StrType s) := 0;
EXPORT InValidMessage_parolestatus(UNSIGNED1 wh) := '';
 
EXPORT Make_paroleofficer(SALT311.StrType s0) := s0;
EXPORT InValid_paroleofficer(SALT311.StrType s) := 0;
EXPORT InValidMessage_paroleofficer(UNSIGNED1 wh) := '';
 
EXPORT Make_paroleoffcerphone(SALT311.StrType s0) := s0;
EXPORT InValid_paroleoffcerphone(SALT311.StrType s) := 0;
EXPORT InValidMessage_paroleoffcerphone(UNSIGNED1 wh) := '';
 
EXPORT Make_probationbegindate(SALT311.StrType s0) := MakeFT_Invalid_Future_Date(s0);
EXPORT InValid_probationbegindate(SALT311.StrType s) := InValidFT_Invalid_Future_Date(s);
EXPORT InValidMessage_probationbegindate(UNSIGNED1 wh) := InValidMessageFT_Invalid_Future_Date(wh);
 
EXPORT Make_probationenddate(SALT311.StrType s0) := MakeFT_Invalid_Future_Date(s0);
EXPORT InValid_probationenddate(SALT311.StrType s) := InValidFT_Invalid_Future_Date(s);
EXPORT InValidMessage_probationenddate(UNSIGNED1 wh) := InValidMessageFT_Invalid_Future_Date(wh);
 
EXPORT Make_probationmaxyears(SALT311.StrType s0) := MakeFT_Invalid_Time(s0);
EXPORT InValid_probationmaxyears(SALT311.StrType s) := InValidFT_Invalid_Time(s);
EXPORT InValidMessage_probationmaxyears(UNSIGNED1 wh) := InValidMessageFT_Invalid_Time(wh);
 
EXPORT Make_probationmaxmonths(SALT311.StrType s0) := MakeFT_Invalid_Time(s0);
EXPORT InValid_probationmaxmonths(SALT311.StrType s) := InValidFT_Invalid_Time(s);
EXPORT InValidMessage_probationmaxmonths(UNSIGNED1 wh) := InValidMessageFT_Invalid_Time(wh);
 
EXPORT Make_probationmaxdays(SALT311.StrType s0) := MakeFT_Invalid_Time(s0);
EXPORT InValid_probationmaxdays(SALT311.StrType s) := InValidFT_Invalid_Time(s);
EXPORT InValidMessage_probationmaxdays(UNSIGNED1 wh) := InValidMessageFT_Invalid_Time(wh);
 
EXPORT Make_probationminyears(SALT311.StrType s0) := MakeFT_Invalid_Time(s0);
EXPORT InValid_probationminyears(SALT311.StrType s) := InValidFT_Invalid_Time(s);
EXPORT InValidMessage_probationminyears(UNSIGNED1 wh) := InValidMessageFT_Invalid_Time(wh);
 
EXPORT Make_probationminmonths(SALT311.StrType s0) := MakeFT_Invalid_Time(s0);
EXPORT InValid_probationminmonths(SALT311.StrType s) := InValidFT_Invalid_Time(s);
EXPORT InValidMessage_probationminmonths(UNSIGNED1 wh) := InValidMessageFT_Invalid_Time(wh);
 
EXPORT Make_probationmindays(SALT311.StrType s0) := MakeFT_Invalid_Time(s0);
EXPORT InValid_probationmindays(SALT311.StrType s) := InValidFT_Invalid_Time(s);
EXPORT InValidMessage_probationmindays(UNSIGNED1 wh) := InValidMessageFT_Invalid_Time(wh);
 
EXPORT Make_probationstatus(SALT311.StrType s0) := s0;
EXPORT InValid_probationstatus(SALT311.StrType s) := 0;
EXPORT InValidMessage_probationstatus(UNSIGNED1 wh) := '';
 
EXPORT Make_sourcename(SALT311.StrType s0) := MakeFT_Non_Blank(s0);
EXPORT InValid_sourcename(SALT311.StrType s) := InValidFT_Non_Blank(s);
EXPORT InValidMessage_sourcename(UNSIGNED1 wh) := InValidMessageFT_Non_Blank(wh);
 
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
    BOOLEAN Diff_caseid;
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
    BOOLEAN Diff_timeservedyears;
    BOOLEAN Diff_timeservedmonths;
    BOOLEAN Diff_timeserveddays;
    BOOLEAN Diff_publicservicehours;
    BOOLEAN Diff_sentenceadditionalinfo;
    BOOLEAN Diff_communitysupervisioncounty;
    BOOLEAN Diff_communitysupervisionyears;
    BOOLEAN Diff_communitysupervisionmonths;
    BOOLEAN Diff_communitysupervisiondays;
    BOOLEAN Diff_parolebegindate;
    BOOLEAN Diff_paroleenddate;
    BOOLEAN Diff_paroleeligibilitydate;
    BOOLEAN Diff_parolehearingdate;
    BOOLEAN Diff_parolemaxyears;
    BOOLEAN Diff_parolemaxmonths;
    BOOLEAN Diff_parolemaxdays;
    BOOLEAN Diff_paroleminyears;
    BOOLEAN Diff_paroleminmonths;
    BOOLEAN Diff_parolemindays;
    BOOLEAN Diff_parolestatus;
    BOOLEAN Diff_paroleofficer;
    BOOLEAN Diff_paroleoffcerphone;
    BOOLEAN Diff_probationbegindate;
    BOOLEAN Diff_probationenddate;
    BOOLEAN Diff_probationmaxyears;
    BOOLEAN Diff_probationmaxmonths;
    BOOLEAN Diff_probationmaxdays;
    BOOLEAN Diff_probationminyears;
    BOOLEAN Diff_probationminmonths;
    BOOLEAN Diff_probationmindays;
    BOOLEAN Diff_probationstatus;
    BOOLEAN Diff_sourcename;
    BOOLEAN Diff_vendor;
    SALT311.StrType SourceField {MAXLENGTH(30)};
    UNSIGNED Num_Diffs;
    SALT311.StrType Val {MAXLENGTH(1024)};
  END;
#uniquename(fd)
  %dl% %fd%(in_left le,in_right ri) := TRANSFORM
    SELF.Diff_recordid := le.recordid <> ri.recordid;
    SELF.Diff_statecode := le.statecode <> ri.statecode;
    SELF.Diff_caseid := le.caseid <> ri.caseid;
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
    SELF.Diff_timeservedyears := le.timeservedyears <> ri.timeservedyears;
    SELF.Diff_timeservedmonths := le.timeservedmonths <> ri.timeservedmonths;
    SELF.Diff_timeserveddays := le.timeserveddays <> ri.timeserveddays;
    SELF.Diff_publicservicehours := le.publicservicehours <> ri.publicservicehours;
    SELF.Diff_sentenceadditionalinfo := le.sentenceadditionalinfo <> ri.sentenceadditionalinfo;
    SELF.Diff_communitysupervisioncounty := le.communitysupervisioncounty <> ri.communitysupervisioncounty;
    SELF.Diff_communitysupervisionyears := le.communitysupervisionyears <> ri.communitysupervisionyears;
    SELF.Diff_communitysupervisionmonths := le.communitysupervisionmonths <> ri.communitysupervisionmonths;
    SELF.Diff_communitysupervisiondays := le.communitysupervisiondays <> ri.communitysupervisiondays;
    SELF.Diff_parolebegindate := le.parolebegindate <> ri.parolebegindate;
    SELF.Diff_paroleenddate := le.paroleenddate <> ri.paroleenddate;
    SELF.Diff_paroleeligibilitydate := le.paroleeligibilitydate <> ri.paroleeligibilitydate;
    SELF.Diff_parolehearingdate := le.parolehearingdate <> ri.parolehearingdate;
    SELF.Diff_parolemaxyears := le.parolemaxyears <> ri.parolemaxyears;
    SELF.Diff_parolemaxmonths := le.parolemaxmonths <> ri.parolemaxmonths;
    SELF.Diff_parolemaxdays := le.parolemaxdays <> ri.parolemaxdays;
    SELF.Diff_paroleminyears := le.paroleminyears <> ri.paroleminyears;
    SELF.Diff_paroleminmonths := le.paroleminmonths <> ri.paroleminmonths;
    SELF.Diff_parolemindays := le.parolemindays <> ri.parolemindays;
    SELF.Diff_parolestatus := le.parolestatus <> ri.parolestatus;
    SELF.Diff_paroleofficer := le.paroleofficer <> ri.paroleofficer;
    SELF.Diff_paroleoffcerphone := le.paroleoffcerphone <> ri.paroleoffcerphone;
    SELF.Diff_probationbegindate := le.probationbegindate <> ri.probationbegindate;
    SELF.Diff_probationenddate := le.probationenddate <> ri.probationenddate;
    SELF.Diff_probationmaxyears := le.probationmaxyears <> ri.probationmaxyears;
    SELF.Diff_probationmaxmonths := le.probationmaxmonths <> ri.probationmaxmonths;
    SELF.Diff_probationmaxdays := le.probationmaxdays <> ri.probationmaxdays;
    SELF.Diff_probationminyears := le.probationminyears <> ri.probationminyears;
    SELF.Diff_probationminmonths := le.probationminmonths <> ri.probationminmonths;
    SELF.Diff_probationmindays := le.probationmindays <> ri.probationmindays;
    SELF.Diff_probationstatus := le.probationstatus <> ri.probationstatus;
    SELF.Diff_sourcename := le.sourcename <> ri.sourcename;
    SELF.Diff_vendor := le.vendor <> ri.vendor;
    SELF.Val := (SALT311.StrType)evaluate(le,pivot_exp);
    SELF.SourceField := le.vendor;
    SELF.Num_Diffs := 0+ IF( SELF.Diff_recordid,1,0)+ IF( SELF.Diff_statecode,1,0)+ IF( SELF.Diff_caseid,1,0)+ IF( SELF.Diff_sentencedate,1,0)+ IF( SELF.Diff_sentencebegindate,1,0)+ IF( SELF.Diff_sentenceenddate,1,0)+ IF( SELF.Diff_sentencetype,1,0)+ IF( SELF.Diff_sentencemaxyears,1,0)+ IF( SELF.Diff_sentencemaxmonths,1,0)+ IF( SELF.Diff_sentencemaxdays,1,0)+ IF( SELF.Diff_sentenceminyears,1,0)+ IF( SELF.Diff_sentenceminmonths,1,0)+ IF( SELF.Diff_sentencemindays,1,0)+ IF( SELF.Diff_scheduledreleasedate,1,0)+ IF( SELF.Diff_actualreleasedate,1,0)+ IF( SELF.Diff_sentencestatus,1,0)+ IF( SELF.Diff_timeservedyears,1,0)+ IF( SELF.Diff_timeservedmonths,1,0)+ IF( SELF.Diff_timeserveddays,1,0)+ IF( SELF.Diff_publicservicehours,1,0)+ IF( SELF.Diff_sentenceadditionalinfo,1,0)+ IF( SELF.Diff_communitysupervisioncounty,1,0)+ IF( SELF.Diff_communitysupervisionyears,1,0)+ IF( SELF.Diff_communitysupervisionmonths,1,0)+ IF( SELF.Diff_communitysupervisiondays,1,0)+ IF( SELF.Diff_parolebegindate,1,0)+ IF( SELF.Diff_paroleenddate,1,0)+ IF( SELF.Diff_paroleeligibilitydate,1,0)+ IF( SELF.Diff_parolehearingdate,1,0)+ IF( SELF.Diff_parolemaxyears,1,0)+ IF( SELF.Diff_parolemaxmonths,1,0)+ IF( SELF.Diff_parolemaxdays,1,0)+ IF( SELF.Diff_paroleminyears,1,0)+ IF( SELF.Diff_paroleminmonths,1,0)+ IF( SELF.Diff_parolemindays,1,0)+ IF( SELF.Diff_parolestatus,1,0)+ IF( SELF.Diff_paroleofficer,1,0)+ IF( SELF.Diff_paroleoffcerphone,1,0)+ IF( SELF.Diff_probationbegindate,1,0)+ IF( SELF.Diff_probationenddate,1,0)+ IF( SELF.Diff_probationmaxyears,1,0)+ IF( SELF.Diff_probationmaxmonths,1,0)+ IF( SELF.Diff_probationmaxdays,1,0)+ IF( SELF.Diff_probationminyears,1,0)+ IF( SELF.Diff_probationminmonths,1,0)+ IF( SELF.Diff_probationmindays,1,0)+ IF( SELF.Diff_probationstatus,1,0)+ IF( SELF.Diff_sourcename,1,0)+ IF( SELF.Diff_vendor,1,0);
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
    Count_Diff_timeservedyears := COUNT(GROUP,%Closest%.Diff_timeservedyears);
    Count_Diff_timeservedmonths := COUNT(GROUP,%Closest%.Diff_timeservedmonths);
    Count_Diff_timeserveddays := COUNT(GROUP,%Closest%.Diff_timeserveddays);
    Count_Diff_publicservicehours := COUNT(GROUP,%Closest%.Diff_publicservicehours);
    Count_Diff_sentenceadditionalinfo := COUNT(GROUP,%Closest%.Diff_sentenceadditionalinfo);
    Count_Diff_communitysupervisioncounty := COUNT(GROUP,%Closest%.Diff_communitysupervisioncounty);
    Count_Diff_communitysupervisionyears := COUNT(GROUP,%Closest%.Diff_communitysupervisionyears);
    Count_Diff_communitysupervisionmonths := COUNT(GROUP,%Closest%.Diff_communitysupervisionmonths);
    Count_Diff_communitysupervisiondays := COUNT(GROUP,%Closest%.Diff_communitysupervisiondays);
    Count_Diff_parolebegindate := COUNT(GROUP,%Closest%.Diff_parolebegindate);
    Count_Diff_paroleenddate := COUNT(GROUP,%Closest%.Diff_paroleenddate);
    Count_Diff_paroleeligibilitydate := COUNT(GROUP,%Closest%.Diff_paroleeligibilitydate);
    Count_Diff_parolehearingdate := COUNT(GROUP,%Closest%.Diff_parolehearingdate);
    Count_Diff_parolemaxyears := COUNT(GROUP,%Closest%.Diff_parolemaxyears);
    Count_Diff_parolemaxmonths := COUNT(GROUP,%Closest%.Diff_parolemaxmonths);
    Count_Diff_parolemaxdays := COUNT(GROUP,%Closest%.Diff_parolemaxdays);
    Count_Diff_paroleminyears := COUNT(GROUP,%Closest%.Diff_paroleminyears);
    Count_Diff_paroleminmonths := COUNT(GROUP,%Closest%.Diff_paroleminmonths);
    Count_Diff_parolemindays := COUNT(GROUP,%Closest%.Diff_parolemindays);
    Count_Diff_parolestatus := COUNT(GROUP,%Closest%.Diff_parolestatus);
    Count_Diff_paroleofficer := COUNT(GROUP,%Closest%.Diff_paroleofficer);
    Count_Diff_paroleoffcerphone := COUNT(GROUP,%Closest%.Diff_paroleoffcerphone);
    Count_Diff_probationbegindate := COUNT(GROUP,%Closest%.Diff_probationbegindate);
    Count_Diff_probationenddate := COUNT(GROUP,%Closest%.Diff_probationenddate);
    Count_Diff_probationmaxyears := COUNT(GROUP,%Closest%.Diff_probationmaxyears);
    Count_Diff_probationmaxmonths := COUNT(GROUP,%Closest%.Diff_probationmaxmonths);
    Count_Diff_probationmaxdays := COUNT(GROUP,%Closest%.Diff_probationmaxdays);
    Count_Diff_probationminyears := COUNT(GROUP,%Closest%.Diff_probationminyears);
    Count_Diff_probationminmonths := COUNT(GROUP,%Closest%.Diff_probationminmonths);
    Count_Diff_probationmindays := COUNT(GROUP,%Closest%.Diff_probationmindays);
    Count_Diff_probationstatus := COUNT(GROUP,%Closest%.Diff_probationstatus);
    Count_Diff_sourcename := COUNT(GROUP,%Closest%.Diff_sourcename);
    Count_Diff_vendor := COUNT(GROUP,%Closest%.Diff_vendor);
    %Closest%.SourceField;
  END;
  out_counts := table(%Closest%,%AggRec%,SourceField,few);
ENDMACRO;
END;
