IMPORT ut,SALT30;
EXPORT Fields := MODULE
// Processing for each FieldType
EXPORT SALT30.StrType FieldTypeName(UNSIGNED2 i) := CHOOSE(i,'invalid_alphanum','invalid_alpha','invalid_ssn','invalid_phone','invalid_address','invalid_name','invalid_zip','invalid_date','invalid_addr_type','invalid_num');
EXPORT FieldTypeNum(SALT30.StrType fn) := CASE(fn,'invalid_alphanum' => 1,'invalid_alpha' => 2,'invalid_ssn' => 3,'invalid_phone' => 4,'invalid_address' => 5,'invalid_name' => 6,'invalid_zip' => 7,'invalid_date' => 8,'invalid_addr_type' => 9,'invalid_num' => 10,0);
EXPORT MakeFT_invalid_alphanum(SALT30.StrType s0) := FUNCTION
  s1 := SALT30.stringfilter(s0,'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789 -_;,"*'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_alphanum(SALT30.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT30.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789 -_;,"*'))),~(LENGTH(TRIM(s)) >= 0));
EXPORT InValidMessageFT_invalid_alphanum(UNSIGNED1 wh) := CHOOSE(wh,SALT30.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789 -_;,"*'),SALT30.HygieneErrors.NotLength('0..'),SALT30.HygieneErrors.Good);
EXPORT MakeFT_invalid_alpha(SALT30.StrType s0) := FUNCTION
  s1 := SALT30.stringfilter(s0,'ABCDEFGHIJKLMNOPQRSTUVWXYZ'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_alpha(SALT30.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT30.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZ'))),~(LENGTH(TRIM(s)) >= 0));
EXPORT InValidMessageFT_invalid_alpha(UNSIGNED1 wh) := CHOOSE(wh,SALT30.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWXYZ'),SALT30.HygieneErrors.NotLength('0..'),SALT30.HygieneErrors.Good);
EXPORT MakeFT_invalid_ssn(SALT30.StrType s0) := FUNCTION
  s1 := SALT30.stringfilter(s0,'0123456789'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_ssn(SALT30.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT30.StringFilter(s,'0123456789'))),~(LENGTH(TRIM(s)) = 0 OR LENGTH(TRIM(s)) = 4 OR LENGTH(TRIM(s)) = 9));
EXPORT InValidMessageFT_invalid_ssn(UNSIGNED1 wh) := CHOOSE(wh,SALT30.HygieneErrors.NotInChars('0123456789'),SALT30.HygieneErrors.NotLength('0,4,9'),SALT30.HygieneErrors.Good);
EXPORT MakeFT_invalid_phone(SALT30.StrType s0) := FUNCTION
  s1 := SALT30.stringfilter(s0,'0123456789'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_phone(SALT30.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT30.StringFilter(s,'0123456789'))),~(LENGTH(TRIM(s)) = 0 OR LENGTH(TRIM(s)) = 10));
EXPORT InValidMessageFT_invalid_phone(UNSIGNED1 wh) := CHOOSE(wh,SALT30.HygieneErrors.NotInChars('0123456789'),SALT30.HygieneErrors.NotLength('0,10'),SALT30.HygieneErrors.Good);
EXPORT MakeFT_invalid_address(SALT30.StrType s0) := FUNCTION
  s1 := SALT30.stringfilter(s0,'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789 -/#.\'&'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_address(SALT30.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT30.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789 -/#.\'&'))),~(LENGTH(TRIM(s)) >= 0));
EXPORT InValidMessageFT_invalid_address(UNSIGNED1 wh) := CHOOSE(wh,SALT30.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789 -/#.\'&'),SALT30.HygieneErrors.NotLength('0..'),SALT30.HygieneErrors.Good);
EXPORT MakeFT_invalid_name(SALT30.StrType s0) := FUNCTION
  s1 := SALT30.stringfilter(s0,'ABCDEFGHIJKLMNOPQRSTUVWXYZ -'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_name(SALT30.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT30.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZ -'))),~(LENGTH(TRIM(s)) >= 0));
EXPORT InValidMessageFT_invalid_name(UNSIGNED1 wh) := CHOOSE(wh,SALT30.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWXYZ -'),SALT30.HygieneErrors.NotLength('0..'),SALT30.HygieneErrors.Good);
EXPORT MakeFT_invalid_zip(SALT30.StrType s0) := FUNCTION
  s1 := SALT30.stringfilter(s0,'0123456789-'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_zip(SALT30.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT30.StringFilter(s,'0123456789-'))),~(LENGTH(TRIM(s)) = 0 OR LENGTH(TRIM(s)) = 4 OR LENGTH(TRIM(s)) = 5 OR LENGTH(TRIM(s)) = 9 OR LENGTH(TRIM(s)) = 10));
EXPORT InValidMessageFT_invalid_zip(UNSIGNED1 wh) := CHOOSE(wh,SALT30.HygieneErrors.NotInChars('0123456789-'),SALT30.HygieneErrors.NotLength('0,4,5,9,10'),SALT30.HygieneErrors.Good);
EXPORT MakeFT_invalid_date(SALT30.StrType s0) := FUNCTION
  s1 := SALT30.stringfilter(s0,'0123456789'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_date(SALT30.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT30.StringFilter(s,'0123456789'))),~(LENGTH(TRIM(s)) = 0 OR LENGTH(TRIM(s)) = 6 OR LENGTH(TRIM(s)) = 8));
EXPORT InValidMessageFT_invalid_date(UNSIGNED1 wh) := CHOOSE(wh,SALT30.HygieneErrors.NotInChars('0123456789'),SALT30.HygieneErrors.NotLength('0,6,8'),SALT30.HygieneErrors.Good);
EXPORT MakeFT_invalid_addr_type(SALT30.StrType s0) := FUNCTION
  s1 := SALT30.stringfilter(s0,'SB'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_addr_type(SALT30.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT30.StringFilter(s,'SB'))),~(LENGTH(TRIM(s)) = 0 OR LENGTH(TRIM(s)) = 1));
EXPORT InValidMessageFT_invalid_addr_type(UNSIGNED1 wh) := CHOOSE(wh,SALT30.HygieneErrors.NotInChars('SB'),SALT30.HygieneErrors.NotLength('0,1'),SALT30.HygieneErrors.Good);
EXPORT MakeFT_invalid_num(SALT30.StrType s0) := FUNCTION
  s1 := SALT30.stringfilter(s0,'0123456789'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_num(SALT30.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT30.StringFilter(s,'0123456789'))),~(LENGTH(TRIM(s)) >= 0));
EXPORT InValidMessageFT_invalid_num(UNSIGNED1 wh) := CHOOSE(wh,SALT30.HygieneErrors.NotInChars('0123456789'),SALT30.HygieneErrors.NotLength('0..'),SALT30.HygieneErrors.Good);
EXPORT SALT30.StrType FieldName(UNSIGNED2 i) := CHOOSE(i,'QUESTIONSETID','STRINGCODE','QUESTIONSETTYPEFIELD','CREATIONTIME','ACCOUNTNAME','SUBSETNUMBER','TRANSACTIONID','STARTTIME','ENDTIME','GRADE','SUBSETGRADEOUTCOMETYPEFIELD','QUESTIONID','QUESTIONTYPEFIELD','PRESENTATIONPOSITION','SHUFFLEWEIGHT','GRADEMULTICHOICERULETYPEFIELD','STARTDATE','ENDDATE','QUESTIONGRADEOUTCOMETYPEFIELD','SELECTEDCOUNT','CORRECTCOUNT','WASNONEOFTHEABOVESELECTED','VERITEID','LANGUAGETYPEFIELD','QUESTIONTIERTYPEFIELD','QUESTIONSTATEMENT','CORRECTANSWER','SELECTEDANSWER','DATASOURCETYPEFIELD');
EXPORT FieldNum(SALT30.StrType fn) := CASE(fn,'QUESTIONSETID' => 1,'STRINGCODE' => 2,'QUESTIONSETTYPEFIELD' => 3,'CREATIONTIME' => 4,'ACCOUNTNAME' => 5,'SUBSETNUMBER' => 6,'TRANSACTIONID' => 7,'STARTTIME' => 8,'ENDTIME' => 9,'GRADE' => 10,'SUBSETGRADEOUTCOMETYPEFIELD' => 11,'QUESTIONID' => 12,'QUESTIONTYPEFIELD' => 13,'PRESENTATIONPOSITION' => 14,'SHUFFLEWEIGHT' => 15,'GRADEMULTICHOICERULETYPEFIELD' => 16,'STARTDATE' => 17,'ENDDATE' => 18,'QUESTIONGRADEOUTCOMETYPEFIELD' => 19,'SELECTEDCOUNT' => 20,'CORRECTCOUNT' => 21,'WASNONEOFTHEABOVESELECTED' => 22,'VERITEID' => 23,'LANGUAGETYPEFIELD' => 24,'QUESTIONTIERTYPEFIELD' => 25,'QUESTIONSTATEMENT' => 26,'CORRECTANSWER' => 27,'SELECTEDANSWER' => 28,'DATASOURCETYPEFIELD' => 29,0);
//Individual field level validation
EXPORT Make_QUESTIONSETID(SALT30.StrType s0) := MakeFT_invalid_num(s0);
EXPORT InValid_QUESTIONSETID(SALT30.StrType s) := InValidFT_invalid_num(s);
EXPORT InValidMessage_QUESTIONSETID(UNSIGNED1 wh) := InValidMessageFT_invalid_num(wh);
EXPORT Make_STRINGCODE(SALT30.StrType s0) := MakeFT_invalid_num(s0);
EXPORT InValid_STRINGCODE(SALT30.StrType s) := InValidFT_invalid_num(s);
EXPORT InValidMessage_STRINGCODE(UNSIGNED1 wh) := InValidMessageFT_invalid_num(wh);
EXPORT Make_QUESTIONSETTYPEFIELD(SALT30.StrType s0) := MakeFT_invalid_alphanum(s0);
EXPORT InValid_QUESTIONSETTYPEFIELD(SALT30.StrType s) := InValidFT_invalid_alphanum(s);
EXPORT InValidMessage_QUESTIONSETTYPEFIELD(UNSIGNED1 wh) := InValidMessageFT_invalid_alphanum(wh);
EXPORT Make_CREATIONTIME(SALT30.StrType s0) := MakeFT_invalid_date(s0);
EXPORT InValid_CREATIONTIME(SALT30.StrType s) := InValidFT_invalid_date(s);
EXPORT InValidMessage_CREATIONTIME(UNSIGNED1 wh) := InValidMessageFT_invalid_date(wh);
EXPORT Make_ACCOUNTNAME(SALT30.StrType s0) := MakeFT_invalid_alpha(s0);
EXPORT InValid_ACCOUNTNAME(SALT30.StrType s) := InValidFT_invalid_alpha(s);
EXPORT InValidMessage_ACCOUNTNAME(UNSIGNED1 wh) := InValidMessageFT_invalid_alpha(wh);
EXPORT Make_SUBSETNUMBER(SALT30.StrType s0) := MakeFT_invalid_num(s0);
EXPORT InValid_SUBSETNUMBER(SALT30.StrType s) := InValidFT_invalid_num(s);
EXPORT InValidMessage_SUBSETNUMBER(UNSIGNED1 wh) := InValidMessageFT_invalid_num(wh);
EXPORT Make_TRANSACTIONID(SALT30.StrType s0) := MakeFT_invalid_num(s0);
EXPORT InValid_TRANSACTIONID(SALT30.StrType s) := InValidFT_invalid_num(s);
EXPORT InValidMessage_TRANSACTIONID(UNSIGNED1 wh) := InValidMessageFT_invalid_num(wh);
EXPORT Make_STARTTIME(SALT30.StrType s0) := MakeFT_invalid_date(s0);
EXPORT InValid_STARTTIME(SALT30.StrType s) := InValidFT_invalid_date(s);
EXPORT InValidMessage_STARTTIME(UNSIGNED1 wh) := InValidMessageFT_invalid_date(wh);
EXPORT Make_ENDTIME(SALT30.StrType s0) := MakeFT_invalid_date(s0);
EXPORT InValid_ENDTIME(SALT30.StrType s) := InValidFT_invalid_date(s);
EXPORT InValidMessage_ENDTIME(UNSIGNED1 wh) := InValidMessageFT_invalid_date(wh);
EXPORT Make_GRADE(SALT30.StrType s0) := MakeFT_invalid_alphanum(s0);
EXPORT InValid_GRADE(SALT30.StrType s) := InValidFT_invalid_alphanum(s);
EXPORT InValidMessage_GRADE(UNSIGNED1 wh) := InValidMessageFT_invalid_alphanum(wh);
EXPORT Make_SUBSETGRADEOUTCOMETYPEFIELD(SALT30.StrType s0) := MakeFT_invalid_alphanum(s0);
EXPORT InValid_SUBSETGRADEOUTCOMETYPEFIELD(SALT30.StrType s) := InValidFT_invalid_alphanum(s);
EXPORT InValidMessage_SUBSETGRADEOUTCOMETYPEFIELD(UNSIGNED1 wh) := InValidMessageFT_invalid_alphanum(wh);
EXPORT Make_QUESTIONID(SALT30.StrType s0) := MakeFT_invalid_num(s0);
EXPORT InValid_QUESTIONID(SALT30.StrType s) := InValidFT_invalid_num(s);
EXPORT InValidMessage_QUESTIONID(UNSIGNED1 wh) := InValidMessageFT_invalid_num(wh);
EXPORT Make_QUESTIONTYPEFIELD(SALT30.StrType s0) := MakeFT_invalid_alphanum(s0);
EXPORT InValid_QUESTIONTYPEFIELD(SALT30.StrType s) := InValidFT_invalid_alphanum(s);
EXPORT InValidMessage_QUESTIONTYPEFIELD(UNSIGNED1 wh) := InValidMessageFT_invalid_alphanum(wh);
EXPORT Make_PRESENTATIONPOSITION(SALT30.StrType s0) := MakeFT_invalid_alphanum(s0);
EXPORT InValid_PRESENTATIONPOSITION(SALT30.StrType s) := InValidFT_invalid_alphanum(s);
EXPORT InValidMessage_PRESENTATIONPOSITION(UNSIGNED1 wh) := InValidMessageFT_invalid_alphanum(wh);
EXPORT Make_SHUFFLEWEIGHT(SALT30.StrType s0) := MakeFT_invalid_alphanum(s0);
EXPORT InValid_SHUFFLEWEIGHT(SALT30.StrType s) := InValidFT_invalid_alphanum(s);
EXPORT InValidMessage_SHUFFLEWEIGHT(UNSIGNED1 wh) := InValidMessageFT_invalid_alphanum(wh);
EXPORT Make_GRADEMULTICHOICERULETYPEFIELD(SALT30.StrType s0) := MakeFT_invalid_alphanum(s0);
EXPORT InValid_GRADEMULTICHOICERULETYPEFIELD(SALT30.StrType s) := InValidFT_invalid_alphanum(s);
EXPORT InValidMessage_GRADEMULTICHOICERULETYPEFIELD(UNSIGNED1 wh) := InValidMessageFT_invalid_alphanum(wh);
EXPORT Make_STARTDATE(SALT30.StrType s0) := MakeFT_invalid_date(s0);
EXPORT InValid_STARTDATE(SALT30.StrType s) := InValidFT_invalid_date(s);
EXPORT InValidMessage_STARTDATE(UNSIGNED1 wh) := InValidMessageFT_invalid_date(wh);
EXPORT Make_ENDDATE(SALT30.StrType s0) := MakeFT_invalid_date(s0);
EXPORT InValid_ENDDATE(SALT30.StrType s) := InValidFT_invalid_date(s);
EXPORT InValidMessage_ENDDATE(UNSIGNED1 wh) := InValidMessageFT_invalid_date(wh);
EXPORT Make_QUESTIONGRADEOUTCOMETYPEFIELD(SALT30.StrType s0) := MakeFT_invalid_alphanum(s0);
EXPORT InValid_QUESTIONGRADEOUTCOMETYPEFIELD(SALT30.StrType s) := InValidFT_invalid_alphanum(s);
EXPORT InValidMessage_QUESTIONGRADEOUTCOMETYPEFIELD(UNSIGNED1 wh) := InValidMessageFT_invalid_alphanum(wh);
EXPORT Make_SELECTEDCOUNT(SALT30.StrType s0) := MakeFT_invalid_num(s0);
EXPORT InValid_SELECTEDCOUNT(SALT30.StrType s) := InValidFT_invalid_num(s);
EXPORT InValidMessage_SELECTEDCOUNT(UNSIGNED1 wh) := InValidMessageFT_invalid_num(wh);
EXPORT Make_CORRECTCOUNT(SALT30.StrType s0) := MakeFT_invalid_num(s0);
EXPORT InValid_CORRECTCOUNT(SALT30.StrType s) := InValidFT_invalid_num(s);
EXPORT InValidMessage_CORRECTCOUNT(UNSIGNED1 wh) := InValidMessageFT_invalid_num(wh);
EXPORT Make_WASNONEOFTHEABOVESELECTED(SALT30.StrType s0) := MakeFT_invalid_alphanum(s0);
EXPORT InValid_WASNONEOFTHEABOVESELECTED(SALT30.StrType s) := InValidFT_invalid_alphanum(s);
EXPORT InValidMessage_WASNONEOFTHEABOVESELECTED(UNSIGNED1 wh) := InValidMessageFT_invalid_alphanum(wh);
EXPORT Make_VERITEID(SALT30.StrType s0) := MakeFT_invalid_num(s0);
EXPORT InValid_VERITEID(SALT30.StrType s) := InValidFT_invalid_num(s);
EXPORT InValidMessage_VERITEID(UNSIGNED1 wh) := InValidMessageFT_invalid_num(wh);
EXPORT Make_LANGUAGETYPEFIELD(SALT30.StrType s0) := MakeFT_invalid_alphanum(s0);
EXPORT InValid_LANGUAGETYPEFIELD(SALT30.StrType s) := InValidFT_invalid_alphanum(s);
EXPORT InValidMessage_LANGUAGETYPEFIELD(UNSIGNED1 wh) := InValidMessageFT_invalid_alphanum(wh);
EXPORT Make_QUESTIONTIERTYPEFIELD(SALT30.StrType s0) := MakeFT_invalid_alphanum(s0);
EXPORT InValid_QUESTIONTIERTYPEFIELD(SALT30.StrType s) := InValidFT_invalid_alphanum(s);
EXPORT InValidMessage_QUESTIONTIERTYPEFIELD(UNSIGNED1 wh) := InValidMessageFT_invalid_alphanum(wh);
EXPORT Make_QUESTIONSTATEMENT(SALT30.StrType s0) := MakeFT_invalid_alpha(s0);
EXPORT InValid_QUESTIONSTATEMENT(SALT30.StrType s) := InValidFT_invalid_alpha(s);
EXPORT InValidMessage_QUESTIONSTATEMENT(UNSIGNED1 wh) := InValidMessageFT_invalid_alpha(wh);
EXPORT Make_CORRECTANSWER(SALT30.StrType s0) := MakeFT_invalid_alphanum(s0);
EXPORT InValid_CORRECTANSWER(SALT30.StrType s) := InValidFT_invalid_alphanum(s);
EXPORT InValidMessage_CORRECTANSWER(UNSIGNED1 wh) := InValidMessageFT_invalid_alphanum(wh);
EXPORT Make_SELECTEDANSWER(SALT30.StrType s0) := MakeFT_invalid_alphanum(s0);
EXPORT InValid_SELECTEDANSWER(SALT30.StrType s) := InValidFT_invalid_alphanum(s);
EXPORT InValidMessage_SELECTEDANSWER(UNSIGNED1 wh) := InValidMessageFT_invalid_alphanum(wh);
EXPORT Make_DATASOURCETYPEFIELD(SALT30.StrType s0) := MakeFT_invalid_alphanum(s0);
EXPORT InValid_DATASOURCETYPEFIELD(SALT30.StrType s) := InValidFT_invalid_alphanum(s);
EXPORT InValidMessage_DATASOURCETYPEFIELD(UNSIGNED1 wh) := InValidMessageFT_invalid_alphanum(wh);
// This macro will compute and count field level differences based upon a pivot expression
export MAC_CountDifferencesByPivot(in_left,in_right,pivot_exp,bad_pivots,out_counts) := MACRO
  IMPORT SALT30,Scrubs_verid_question;
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
    BOOLEAN Diff_QUESTIONSETID;
    BOOLEAN Diff_STRINGCODE;
    BOOLEAN Diff_QUESTIONSETTYPEFIELD;
    BOOLEAN Diff_CREATIONTIME;
    BOOLEAN Diff_ACCOUNTNAME;
    BOOLEAN Diff_SUBSETNUMBER;
    BOOLEAN Diff_TRANSACTIONID;
    BOOLEAN Diff_STARTTIME;
    BOOLEAN Diff_ENDTIME;
    BOOLEAN Diff_GRADE;
    BOOLEAN Diff_SUBSETGRADEOUTCOMETYPEFIELD;
    BOOLEAN Diff_QUESTIONID;
    BOOLEAN Diff_QUESTIONTYPEFIELD;
    BOOLEAN Diff_PRESENTATIONPOSITION;
    BOOLEAN Diff_SHUFFLEWEIGHT;
    BOOLEAN Diff_GRADEMULTICHOICERULETYPEFIELD;
    BOOLEAN Diff_STARTDATE;
    BOOLEAN Diff_ENDDATE;
    BOOLEAN Diff_QUESTIONGRADEOUTCOMETYPEFIELD;
    BOOLEAN Diff_SELECTEDCOUNT;
    BOOLEAN Diff_CORRECTCOUNT;
    BOOLEAN Diff_WASNONEOFTHEABOVESELECTED;
    BOOLEAN Diff_VERITEID;
    BOOLEAN Diff_LANGUAGETYPEFIELD;
    BOOLEAN Diff_QUESTIONTIERTYPEFIELD;
    BOOLEAN Diff_QUESTIONSTATEMENT;
    BOOLEAN Diff_CORRECTANSWER;
    BOOLEAN Diff_SELECTEDANSWER;
    BOOLEAN Diff_DATASOURCETYPEFIELD;
    UNSIGNED Num_Diffs;
    SALT30.StrType Val {MAXLENGTH(1024)};
  END;
#uniquename(fd)
  %dl% %fd%(in_left le,in_right ri) := TRANSFORM
    SELF.Diff_QUESTIONSETID := le.QUESTIONSETID <> ri.QUESTIONSETID;
    SELF.Diff_STRINGCODE := le.STRINGCODE <> ri.STRINGCODE;
    SELF.Diff_QUESTIONSETTYPEFIELD := le.QUESTIONSETTYPEFIELD <> ri.QUESTIONSETTYPEFIELD;
    SELF.Diff_CREATIONTIME := le.CREATIONTIME <> ri.CREATIONTIME;
    SELF.Diff_ACCOUNTNAME := le.ACCOUNTNAME <> ri.ACCOUNTNAME;
    SELF.Diff_SUBSETNUMBER := le.SUBSETNUMBER <> ri.SUBSETNUMBER;
    SELF.Diff_TRANSACTIONID := le.TRANSACTIONID <> ri.TRANSACTIONID;
    SELF.Diff_STARTTIME := le.STARTTIME <> ri.STARTTIME;
    SELF.Diff_ENDTIME := le.ENDTIME <> ri.ENDTIME;
    SELF.Diff_GRADE := le.GRADE <> ri.GRADE;
    SELF.Diff_SUBSETGRADEOUTCOMETYPEFIELD := le.SUBSETGRADEOUTCOMETYPEFIELD <> ri.SUBSETGRADEOUTCOMETYPEFIELD;
    SELF.Diff_QUESTIONID := le.QUESTIONID <> ri.QUESTIONID;
    SELF.Diff_QUESTIONTYPEFIELD := le.QUESTIONTYPEFIELD <> ri.QUESTIONTYPEFIELD;
    SELF.Diff_PRESENTATIONPOSITION := le.PRESENTATIONPOSITION <> ri.PRESENTATIONPOSITION;
    SELF.Diff_SHUFFLEWEIGHT := le.SHUFFLEWEIGHT <> ri.SHUFFLEWEIGHT;
    SELF.Diff_GRADEMULTICHOICERULETYPEFIELD := le.GRADEMULTICHOICERULETYPEFIELD <> ri.GRADEMULTICHOICERULETYPEFIELD;
    SELF.Diff_STARTDATE := le.STARTDATE <> ri.STARTDATE;
    SELF.Diff_ENDDATE := le.ENDDATE <> ri.ENDDATE;
    SELF.Diff_QUESTIONGRADEOUTCOMETYPEFIELD := le.QUESTIONGRADEOUTCOMETYPEFIELD <> ri.QUESTIONGRADEOUTCOMETYPEFIELD;
    SELF.Diff_SELECTEDCOUNT := le.SELECTEDCOUNT <> ri.SELECTEDCOUNT;
    SELF.Diff_CORRECTCOUNT := le.CORRECTCOUNT <> ri.CORRECTCOUNT;
    SELF.Diff_WASNONEOFTHEABOVESELECTED := le.WASNONEOFTHEABOVESELECTED <> ri.WASNONEOFTHEABOVESELECTED;
    SELF.Diff_VERITEID := le.VERITEID <> ri.VERITEID;
    SELF.Diff_LANGUAGETYPEFIELD := le.LANGUAGETYPEFIELD <> ri.LANGUAGETYPEFIELD;
    SELF.Diff_QUESTIONTIERTYPEFIELD := le.QUESTIONTIERTYPEFIELD <> ri.QUESTIONTIERTYPEFIELD;
    SELF.Diff_QUESTIONSTATEMENT := le.QUESTIONSTATEMENT <> ri.QUESTIONSTATEMENT;
    SELF.Diff_CORRECTANSWER := le.CORRECTANSWER <> ri.CORRECTANSWER;
    SELF.Diff_SELECTEDANSWER := le.SELECTEDANSWER <> ri.SELECTEDANSWER;
    SELF.Diff_DATASOURCETYPEFIELD := le.DATASOURCETYPEFIELD <> ri.DATASOURCETYPEFIELD;
    SELF.Val := (SALT30.StrType)evaluate(le,pivot_exp);
    SELF.Num_Diffs := 0+ IF( SELF.Diff_QUESTIONSETID,1,0)+ IF( SELF.Diff_STRINGCODE,1,0)+ IF( SELF.Diff_QUESTIONSETTYPEFIELD,1,0)+ IF( SELF.Diff_CREATIONTIME,1,0)+ IF( SELF.Diff_ACCOUNTNAME,1,0)+ IF( SELF.Diff_SUBSETNUMBER,1,0)+ IF( SELF.Diff_TRANSACTIONID,1,0)+ IF( SELF.Diff_STARTTIME,1,0)+ IF( SELF.Diff_ENDTIME,1,0)+ IF( SELF.Diff_GRADE,1,0)+ IF( SELF.Diff_SUBSETGRADEOUTCOMETYPEFIELD,1,0)+ IF( SELF.Diff_QUESTIONID,1,0)+ IF( SELF.Diff_QUESTIONTYPEFIELD,1,0)+ IF( SELF.Diff_PRESENTATIONPOSITION,1,0)+ IF( SELF.Diff_SHUFFLEWEIGHT,1,0)+ IF( SELF.Diff_GRADEMULTICHOICERULETYPEFIELD,1,0)+ IF( SELF.Diff_STARTDATE,1,0)+ IF( SELF.Diff_ENDDATE,1,0)+ IF( SELF.Diff_QUESTIONGRADEOUTCOMETYPEFIELD,1,0)+ IF( SELF.Diff_SELECTEDCOUNT,1,0)+ IF( SELF.Diff_CORRECTCOUNT,1,0)+ IF( SELF.Diff_WASNONEOFTHEABOVESELECTED,1,0)+ IF( SELF.Diff_VERITEID,1,0)+ IF( SELF.Diff_LANGUAGETYPEFIELD,1,0)+ IF( SELF.Diff_QUESTIONTIERTYPEFIELD,1,0)+ IF( SELF.Diff_QUESTIONSTATEMENT,1,0)+ IF( SELF.Diff_CORRECTANSWER,1,0)+ IF( SELF.Diff_SELECTEDANSWER,1,0)+ IF( SELF.Diff_DATASOURCETYPEFIELD,1,0);
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
    Count_Diff_QUESTIONSETID := COUNT(GROUP,%Closest%.Diff_QUESTIONSETID);
    Count_Diff_STRINGCODE := COUNT(GROUP,%Closest%.Diff_STRINGCODE);
    Count_Diff_QUESTIONSETTYPEFIELD := COUNT(GROUP,%Closest%.Diff_QUESTIONSETTYPEFIELD);
    Count_Diff_CREATIONTIME := COUNT(GROUP,%Closest%.Diff_CREATIONTIME);
    Count_Diff_ACCOUNTNAME := COUNT(GROUP,%Closest%.Diff_ACCOUNTNAME);
    Count_Diff_SUBSETNUMBER := COUNT(GROUP,%Closest%.Diff_SUBSETNUMBER);
    Count_Diff_TRANSACTIONID := COUNT(GROUP,%Closest%.Diff_TRANSACTIONID);
    Count_Diff_STARTTIME := COUNT(GROUP,%Closest%.Diff_STARTTIME);
    Count_Diff_ENDTIME := COUNT(GROUP,%Closest%.Diff_ENDTIME);
    Count_Diff_GRADE := COUNT(GROUP,%Closest%.Diff_GRADE);
    Count_Diff_SUBSETGRADEOUTCOMETYPEFIELD := COUNT(GROUP,%Closest%.Diff_SUBSETGRADEOUTCOMETYPEFIELD);
    Count_Diff_QUESTIONID := COUNT(GROUP,%Closest%.Diff_QUESTIONID);
    Count_Diff_QUESTIONTYPEFIELD := COUNT(GROUP,%Closest%.Diff_QUESTIONTYPEFIELD);
    Count_Diff_PRESENTATIONPOSITION := COUNT(GROUP,%Closest%.Diff_PRESENTATIONPOSITION);
    Count_Diff_SHUFFLEWEIGHT := COUNT(GROUP,%Closest%.Diff_SHUFFLEWEIGHT);
    Count_Diff_GRADEMULTICHOICERULETYPEFIELD := COUNT(GROUP,%Closest%.Diff_GRADEMULTICHOICERULETYPEFIELD);
    Count_Diff_STARTDATE := COUNT(GROUP,%Closest%.Diff_STARTDATE);
    Count_Diff_ENDDATE := COUNT(GROUP,%Closest%.Diff_ENDDATE);
    Count_Diff_QUESTIONGRADEOUTCOMETYPEFIELD := COUNT(GROUP,%Closest%.Diff_QUESTIONGRADEOUTCOMETYPEFIELD);
    Count_Diff_SELECTEDCOUNT := COUNT(GROUP,%Closest%.Diff_SELECTEDCOUNT);
    Count_Diff_CORRECTCOUNT := COUNT(GROUP,%Closest%.Diff_CORRECTCOUNT);
    Count_Diff_WASNONEOFTHEABOVESELECTED := COUNT(GROUP,%Closest%.Diff_WASNONEOFTHEABOVESELECTED);
    Count_Diff_VERITEID := COUNT(GROUP,%Closest%.Diff_VERITEID);
    Count_Diff_LANGUAGETYPEFIELD := COUNT(GROUP,%Closest%.Diff_LANGUAGETYPEFIELD);
    Count_Diff_QUESTIONTIERTYPEFIELD := COUNT(GROUP,%Closest%.Diff_QUESTIONTIERTYPEFIELD);
    Count_Diff_QUESTIONSTATEMENT := COUNT(GROUP,%Closest%.Diff_QUESTIONSTATEMENT);
    Count_Diff_CORRECTANSWER := COUNT(GROUP,%Closest%.Diff_CORRECTANSWER);
    Count_Diff_SELECTEDANSWER := COUNT(GROUP,%Closest%.Diff_SELECTEDANSWER);
    Count_Diff_DATASOURCETYPEFIELD := COUNT(GROUP,%Closest%.Diff_DATASOURCETYPEFIELD);
  END;
  out_counts := table(%Closest%,%AggRec%,true);
ENDMACRO;
END;
