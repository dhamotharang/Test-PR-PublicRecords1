EXPORT MAC_PopulationStatistics(infile,Ref='',Input_QUESTIONSETID = '',Input_STRINGCODE = '',Input_QUESTIONSETTYPEFIELD = '',Input_CREATIONTIME = '',Input_ACCOUNTNAME = '',Input_SUBSETNUMBER = '',Input_TRANSACTIONID = '',Input_STARTTIME = '',Input_ENDTIME = '',Input_GRADE = '',Input_SUBSETGRADEOUTCOMETYPEFIELD = '',Input_QUESTIONID = '',Input_QUESTIONTYPEFIELD = '',Input_PRESENTATIONPOSITION = '',Input_SHUFFLEWEIGHT = '',Input_GRADEMULTICHOICERULETYPEFIELD = '',Input_STARTDATE = '',Input_ENDDATE = '',Input_QUESTIONGRADEOUTCOMETYPEFIELD = '',Input_SELECTEDCOUNT = '',Input_CORRECTCOUNT = '',Input_WASNONEOFTHEABOVESELECTED = '',Input_VERITEID = '',Input_LANGUAGETYPEFIELD = '',Input_QUESTIONTIERTYPEFIELD = '',Input_QUESTIONSTATEMENT = '',Input_CORRECTANSWER = '',Input_SELECTEDANSWER = '',Input_DATASOURCETYPEFIELD = '',OutFile) := MACRO
  IMPORT SALT30,Scrubs_verid_question;
  #uniquename(of)
  %of% := RECORD
    SALT30.Str512Type fields;
  END;
  #uniquename(ot)
  %of% %ot%(infile le) := TRANSFORM
    SELF.fields :=
    #IF( #TEXT(Input_QUESTIONSETID)='' )
      '' 
    #ELSE
        IF( le.Input_QUESTIONSETID = (TYPEOF(le.Input_QUESTIONSETID))'','',':QUESTIONSETID')
    #END
+    #IF( #TEXT(Input_STRINGCODE)='' )
      '' 
    #ELSE
        IF( le.Input_STRINGCODE = (TYPEOF(le.Input_STRINGCODE))'','',':STRINGCODE')
    #END
+    #IF( #TEXT(Input_QUESTIONSETTYPEFIELD)='' )
      '' 
    #ELSE
        IF( le.Input_QUESTIONSETTYPEFIELD = (TYPEOF(le.Input_QUESTIONSETTYPEFIELD))'','',':QUESTIONSETTYPEFIELD')
    #END
+    #IF( #TEXT(Input_CREATIONTIME)='' )
      '' 
    #ELSE
        IF( le.Input_CREATIONTIME = (TYPEOF(le.Input_CREATIONTIME))'','',':CREATIONTIME')
    #END
+    #IF( #TEXT(Input_ACCOUNTNAME)='' )
      '' 
    #ELSE
        IF( le.Input_ACCOUNTNAME = (TYPEOF(le.Input_ACCOUNTNAME))'','',':ACCOUNTNAME')
    #END
+    #IF( #TEXT(Input_SUBSETNUMBER)='' )
      '' 
    #ELSE
        IF( le.Input_SUBSETNUMBER = (TYPEOF(le.Input_SUBSETNUMBER))'','',':SUBSETNUMBER')
    #END
+    #IF( #TEXT(Input_TRANSACTIONID)='' )
      '' 
    #ELSE
        IF( le.Input_TRANSACTIONID = (TYPEOF(le.Input_TRANSACTIONID))'','',':TRANSACTIONID')
    #END
+    #IF( #TEXT(Input_STARTTIME)='' )
      '' 
    #ELSE
        IF( le.Input_STARTTIME = (TYPEOF(le.Input_STARTTIME))'','',':STARTTIME')
    #END
+    #IF( #TEXT(Input_ENDTIME)='' )
      '' 
    #ELSE
        IF( le.Input_ENDTIME = (TYPEOF(le.Input_ENDTIME))'','',':ENDTIME')
    #END
+    #IF( #TEXT(Input_GRADE)='' )
      '' 
    #ELSE
        IF( le.Input_GRADE = (TYPEOF(le.Input_GRADE))'','',':GRADE')
    #END
+    #IF( #TEXT(Input_SUBSETGRADEOUTCOMETYPEFIELD)='' )
      '' 
    #ELSE
        IF( le.Input_SUBSETGRADEOUTCOMETYPEFIELD = (TYPEOF(le.Input_SUBSETGRADEOUTCOMETYPEFIELD))'','',':SUBSETGRADEOUTCOMETYPEFIELD')
    #END
+    #IF( #TEXT(Input_QUESTIONID)='' )
      '' 
    #ELSE
        IF( le.Input_QUESTIONID = (TYPEOF(le.Input_QUESTIONID))'','',':QUESTIONID')
    #END
+    #IF( #TEXT(Input_QUESTIONTYPEFIELD)='' )
      '' 
    #ELSE
        IF( le.Input_QUESTIONTYPEFIELD = (TYPEOF(le.Input_QUESTIONTYPEFIELD))'','',':QUESTIONTYPEFIELD')
    #END
+    #IF( #TEXT(Input_PRESENTATIONPOSITION)='' )
      '' 
    #ELSE
        IF( le.Input_PRESENTATIONPOSITION = (TYPEOF(le.Input_PRESENTATIONPOSITION))'','',':PRESENTATIONPOSITION')
    #END
+    #IF( #TEXT(Input_SHUFFLEWEIGHT)='' )
      '' 
    #ELSE
        IF( le.Input_SHUFFLEWEIGHT = (TYPEOF(le.Input_SHUFFLEWEIGHT))'','',':SHUFFLEWEIGHT')
    #END
+    #IF( #TEXT(Input_GRADEMULTICHOICERULETYPEFIELD)='' )
      '' 
    #ELSE
        IF( le.Input_GRADEMULTICHOICERULETYPEFIELD = (TYPEOF(le.Input_GRADEMULTICHOICERULETYPEFIELD))'','',':GRADEMULTICHOICERULETYPEFIELD')
    #END
+    #IF( #TEXT(Input_STARTDATE)='' )
      '' 
    #ELSE
        IF( le.Input_STARTDATE = (TYPEOF(le.Input_STARTDATE))'','',':STARTDATE')
    #END
+    #IF( #TEXT(Input_ENDDATE)='' )
      '' 
    #ELSE
        IF( le.Input_ENDDATE = (TYPEOF(le.Input_ENDDATE))'','',':ENDDATE')
    #END
+    #IF( #TEXT(Input_QUESTIONGRADEOUTCOMETYPEFIELD)='' )
      '' 
    #ELSE
        IF( le.Input_QUESTIONGRADEOUTCOMETYPEFIELD = (TYPEOF(le.Input_QUESTIONGRADEOUTCOMETYPEFIELD))'','',':QUESTIONGRADEOUTCOMETYPEFIELD')
    #END
+    #IF( #TEXT(Input_SELECTEDCOUNT)='' )
      '' 
    #ELSE
        IF( le.Input_SELECTEDCOUNT = (TYPEOF(le.Input_SELECTEDCOUNT))'','',':SELECTEDCOUNT')
    #END
+    #IF( #TEXT(Input_CORRECTCOUNT)='' )
      '' 
    #ELSE
        IF( le.Input_CORRECTCOUNT = (TYPEOF(le.Input_CORRECTCOUNT))'','',':CORRECTCOUNT')
    #END
+    #IF( #TEXT(Input_WASNONEOFTHEABOVESELECTED)='' )
      '' 
    #ELSE
        IF( le.Input_WASNONEOFTHEABOVESELECTED = (TYPEOF(le.Input_WASNONEOFTHEABOVESELECTED))'','',':WASNONEOFTHEABOVESELECTED')
    #END
+    #IF( #TEXT(Input_VERITEID)='' )
      '' 
    #ELSE
        IF( le.Input_VERITEID = (TYPEOF(le.Input_VERITEID))'','',':VERITEID')
    #END
+    #IF( #TEXT(Input_LANGUAGETYPEFIELD)='' )
      '' 
    #ELSE
        IF( le.Input_LANGUAGETYPEFIELD = (TYPEOF(le.Input_LANGUAGETYPEFIELD))'','',':LANGUAGETYPEFIELD')
    #END
+    #IF( #TEXT(Input_QUESTIONTIERTYPEFIELD)='' )
      '' 
    #ELSE
        IF( le.Input_QUESTIONTIERTYPEFIELD = (TYPEOF(le.Input_QUESTIONTIERTYPEFIELD))'','',':QUESTIONTIERTYPEFIELD')
    #END
+    #IF( #TEXT(Input_QUESTIONSTATEMENT)='' )
      '' 
    #ELSE
        IF( le.Input_QUESTIONSTATEMENT = (TYPEOF(le.Input_QUESTIONSTATEMENT))'','',':QUESTIONSTATEMENT')
    #END
+    #IF( #TEXT(Input_CORRECTANSWER)='' )
      '' 
    #ELSE
        IF( le.Input_CORRECTANSWER = (TYPEOF(le.Input_CORRECTANSWER))'','',':CORRECTANSWER')
    #END
+    #IF( #TEXT(Input_SELECTEDANSWER)='' )
      '' 
    #ELSE
        IF( le.Input_SELECTEDANSWER = (TYPEOF(le.Input_SELECTEDANSWER))'','',':SELECTEDANSWER')
    #END
+    #IF( #TEXT(Input_DATASOURCETYPEFIELD)='' )
      '' 
    #ELSE
        IF( le.Input_DATASOURCETYPEFIELD = (TYPEOF(le.Input_DATASOURCETYPEFIELD))'','',':DATASOURCETYPEFIELD')
    #END
;
  END;
  #uniquename(op)
  %op% := PROJECT(infile,%ot%(LEFT));
  #uniquename(ort)
  %ort% := RECORD
    %op%.fields;
    UNSIGNED cnt := COUNT(GROUP);
  END;
  outfile := TOPN( TABLE( %op%, %ort%, fields, FEW ), 1000, -cnt );
ENDMACRO;
