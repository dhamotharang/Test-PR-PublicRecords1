 
EXPORT MAC_PopulationStatistics(infile,Ref='',Input_logid = '',Input_logdate = '',Input_caseid = '',Input_defendantid = '',Input_currentchapter = '',Input_previouschapter = '',Input_conversionid = '',Input_convertdate = '',Input_currentdisposition = '',Input_dcode = '',Input_currentdispositiondate = '',Input_intseed = '',Input_pid = '',Input_tmsid = '',Input_vacateid = '',Input_vacatedate = '',Input_vacateddisposition = '',Input_vacateddispositiondate = '',Input_withdrawnid = '',Input_originalwithdrawndate = '',Input_withdrawndate = '',Input_withdrawndisposition = '',Input_withdrawndispositiondate = '',Input_originalwithdrawndispositiondate = '',Input_filedinerror = '',Input_reopendate = '',Input_lastupdateddate = '',Input_iscurrent = '',Input___filename = '',OutFile) := MACRO
  IMPORT SALT37,scrubs_bk_withdrawnstatus;
  #uniquename(of)
  %of% := RECORD
    SALT37.Str512Type fields;
  END;
  #uniquename(ot)
  %of% %ot%(infile le) := TRANSFORM
    SELF.fields :=
    #IF( #TEXT(Input_logid)='' )
      '' 
    #ELSE
        IF( le.Input_logid = (TYPEOF(le.Input_logid))'','',':logid')
    #END
 
+    #IF( #TEXT(Input_logdate)='' )
      '' 
    #ELSE
        IF( le.Input_logdate = (TYPEOF(le.Input_logdate))'','',':logdate')
    #END
 
+    #IF( #TEXT(Input_caseid)='' )
      '' 
    #ELSE
        IF( le.Input_caseid = (TYPEOF(le.Input_caseid))'','',':caseid')
    #END
 
+    #IF( #TEXT(Input_defendantid)='' )
      '' 
    #ELSE
        IF( le.Input_defendantid = (TYPEOF(le.Input_defendantid))'','',':defendantid')
    #END
 
+    #IF( #TEXT(Input_currentchapter)='' )
      '' 
    #ELSE
        IF( le.Input_currentchapter = (TYPEOF(le.Input_currentchapter))'','',':currentchapter')
    #END
 
+    #IF( #TEXT(Input_previouschapter)='' )
      '' 
    #ELSE
        IF( le.Input_previouschapter = (TYPEOF(le.Input_previouschapter))'','',':previouschapter')
    #END
 
+    #IF( #TEXT(Input_conversionid)='' )
      '' 
    #ELSE
        IF( le.Input_conversionid = (TYPEOF(le.Input_conversionid))'','',':conversionid')
    #END
 
+    #IF( #TEXT(Input_convertdate)='' )
      '' 
    #ELSE
        IF( le.Input_convertdate = (TYPEOF(le.Input_convertdate))'','',':convertdate')
    #END
 
+    #IF( #TEXT(Input_currentdisposition)='' )
      '' 
    #ELSE
        IF( le.Input_currentdisposition = (TYPEOF(le.Input_currentdisposition))'','',':currentdisposition')
    #END
 
+    #IF( #TEXT(Input_dcode)='' )
      '' 
    #ELSE
        IF( le.Input_dcode = (TYPEOF(le.Input_dcode))'','',':dcode')
    #END
 
+    #IF( #TEXT(Input_currentdispositiondate)='' )
      '' 
    #ELSE
        IF( le.Input_currentdispositiondate = (TYPEOF(le.Input_currentdispositiondate))'','',':currentdispositiondate')
    #END
 
+    #IF( #TEXT(Input_intseed)='' )
      '' 
    #ELSE
        IF( le.Input_intseed = (TYPEOF(le.Input_intseed))'','',':intseed')
    #END
 
+    #IF( #TEXT(Input_pid)='' )
      '' 
    #ELSE
        IF( le.Input_pid = (TYPEOF(le.Input_pid))'','',':pid')
    #END
 
+    #IF( #TEXT(Input_tmsid)='' )
      '' 
    #ELSE
        IF( le.Input_tmsid = (TYPEOF(le.Input_tmsid))'','',':tmsid')
    #END
 
+    #IF( #TEXT(Input_vacateid)='' )
      '' 
    #ELSE
        IF( le.Input_vacateid = (TYPEOF(le.Input_vacateid))'','',':vacateid')
    #END
 
+    #IF( #TEXT(Input_vacatedate)='' )
      '' 
    #ELSE
        IF( le.Input_vacatedate = (TYPEOF(le.Input_vacatedate))'','',':vacatedate')
    #END
 
+    #IF( #TEXT(Input_vacateddisposition)='' )
      '' 
    #ELSE
        IF( le.Input_vacateddisposition = (TYPEOF(le.Input_vacateddisposition))'','',':vacateddisposition')
    #END
 
+    #IF( #TEXT(Input_vacateddispositiondate)='' )
      '' 
    #ELSE
        IF( le.Input_vacateddispositiondate = (TYPEOF(le.Input_vacateddispositiondate))'','',':vacateddispositiondate')
    #END
 
+    #IF( #TEXT(Input_withdrawnid)='' )
      '' 
    #ELSE
        IF( le.Input_withdrawnid = (TYPEOF(le.Input_withdrawnid))'','',':withdrawnid')
    #END
 
+    #IF( #TEXT(Input_originalwithdrawndate)='' )
      '' 
    #ELSE
        IF( le.Input_originalwithdrawndate = (TYPEOF(le.Input_originalwithdrawndate))'','',':originalwithdrawndate')
    #END
 
+    #IF( #TEXT(Input_withdrawndate)='' )
      '' 
    #ELSE
        IF( le.Input_withdrawndate = (TYPEOF(le.Input_withdrawndate))'','',':withdrawndate')
    #END
 
+    #IF( #TEXT(Input_withdrawndisposition)='' )
      '' 
    #ELSE
        IF( le.Input_withdrawndisposition = (TYPEOF(le.Input_withdrawndisposition))'','',':withdrawndisposition')
    #END
 
+    #IF( #TEXT(Input_withdrawndispositiondate)='' )
      '' 
    #ELSE
        IF( le.Input_withdrawndispositiondate = (TYPEOF(le.Input_withdrawndispositiondate))'','',':withdrawndispositiondate')
    #END
 
+    #IF( #TEXT(Input_originalwithdrawndispositiondate)='' )
      '' 
    #ELSE
        IF( le.Input_originalwithdrawndispositiondate = (TYPEOF(le.Input_originalwithdrawndispositiondate))'','',':originalwithdrawndispositiondate')
    #END
 
+    #IF( #TEXT(Input_filedinerror)='' )
      '' 
    #ELSE
        IF( le.Input_filedinerror = (TYPEOF(le.Input_filedinerror))'','',':filedinerror')
    #END
 
+    #IF( #TEXT(Input_reopendate)='' )
      '' 
    #ELSE
        IF( le.Input_reopendate = (TYPEOF(le.Input_reopendate))'','',':reopendate')
    #END
 
+    #IF( #TEXT(Input_lastupdateddate)='' )
      '' 
    #ELSE
        IF( le.Input_lastupdateddate = (TYPEOF(le.Input_lastupdateddate))'','',':lastupdateddate')
    #END
 
+    #IF( #TEXT(Input_iscurrent)='' )
      '' 
    #ELSE
        IF( le.Input_iscurrent = (TYPEOF(le.Input_iscurrent))'','',':iscurrent')
    #END
 
+    #IF( #TEXT(Input___filename)='' )
      '' 
    #ELSE
        IF( le.Input___filename = (TYPEOF(le.Input___filename))'','',':__filename')
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
