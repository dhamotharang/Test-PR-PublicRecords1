 
EXPORT MAC_PopulationStatistics(infile,Ref='',Input_dractivitytypecode = '',Input_docketentryid = '',Input_courtid = '',Input_casekey = '',Input_casetype = '',Input_bkcasenumber = '',Input_bkcasenumberurl = '',Input_proceedingscasenumber = '',Input_proceedingscasenumberurl = '',Input_caseid = '',Input_pacercaseid = '',Input_attachmenturl = '',Input_entrynumber = '',Input_entereddate = '',Input_pacer_entereddate = '',Input_fileddate = '',Input_score = '',Input_drcategoryeventid = '',Input_court_code = '',Input_district = '',Input_boca_court = '',Input_catevent_description = '',Input_catevent_category = '',OutFile) := MACRO
  IMPORT SALT311,Scrubs_BK_Events;
  #uniquename(of)
  %of% := RECORD
    SALT311.Str512Type fields;
  END;
  #uniquename(ot)
  %of% %ot%(infile le) := TRANSFORM
    SELF.fields :=
    #IF( #TEXT(Input_dractivitytypecode)='' )
      '' 
    #ELSE
        IF( le.Input_dractivitytypecode = (TYPEOF(le.Input_dractivitytypecode))'','',':dractivitytypecode')
    #END
 
+    #IF( #TEXT(Input_docketentryid)='' )
      '' 
    #ELSE
        IF( le.Input_docketentryid = (TYPEOF(le.Input_docketentryid))'','',':docketentryid')
    #END
 
+    #IF( #TEXT(Input_courtid)='' )
      '' 
    #ELSE
        IF( le.Input_courtid = (TYPEOF(le.Input_courtid))'','',':courtid')
    #END
 
+    #IF( #TEXT(Input_casekey)='' )
      '' 
    #ELSE
        IF( le.Input_casekey = (TYPEOF(le.Input_casekey))'','',':casekey')
    #END
 
+    #IF( #TEXT(Input_casetype)='' )
      '' 
    #ELSE
        IF( le.Input_casetype = (TYPEOF(le.Input_casetype))'','',':casetype')
    #END
 
+    #IF( #TEXT(Input_bkcasenumber)='' )
      '' 
    #ELSE
        IF( le.Input_bkcasenumber = (TYPEOF(le.Input_bkcasenumber))'','',':bkcasenumber')
    #END
 
+    #IF( #TEXT(Input_bkcasenumberurl)='' )
      '' 
    #ELSE
        IF( le.Input_bkcasenumberurl = (TYPEOF(le.Input_bkcasenumberurl))'','',':bkcasenumberurl')
    #END
 
+    #IF( #TEXT(Input_proceedingscasenumber)='' )
      '' 
    #ELSE
        IF( le.Input_proceedingscasenumber = (TYPEOF(le.Input_proceedingscasenumber))'','',':proceedingscasenumber')
    #END
 
+    #IF( #TEXT(Input_proceedingscasenumberurl)='' )
      '' 
    #ELSE
        IF( le.Input_proceedingscasenumberurl = (TYPEOF(le.Input_proceedingscasenumberurl))'','',':proceedingscasenumberurl')
    #END
 
+    #IF( #TEXT(Input_caseid)='' )
      '' 
    #ELSE
        IF( le.Input_caseid = (TYPEOF(le.Input_caseid))'','',':caseid')
    #END
 
+    #IF( #TEXT(Input_pacercaseid)='' )
      '' 
    #ELSE
        IF( le.Input_pacercaseid = (TYPEOF(le.Input_pacercaseid))'','',':pacercaseid')
    #END
 
+    #IF( #TEXT(Input_attachmenturl)='' )
      '' 
    #ELSE
        IF( le.Input_attachmenturl = (TYPEOF(le.Input_attachmenturl))'','',':attachmenturl')
    #END
 
+    #IF( #TEXT(Input_entrynumber)='' )
      '' 
    #ELSE
        IF( le.Input_entrynumber = (TYPEOF(le.Input_entrynumber))'','',':entrynumber')
    #END
 
+    #IF( #TEXT(Input_entereddate)='' )
      '' 
    #ELSE
        IF( le.Input_entereddate = (TYPEOF(le.Input_entereddate))'','',':entereddate')
    #END
 
+    #IF( #TEXT(Input_pacer_entereddate)='' )
      '' 
    #ELSE
        IF( le.Input_pacer_entereddate = (TYPEOF(le.Input_pacer_entereddate))'','',':pacer_entereddate')
    #END
 
+    #IF( #TEXT(Input_fileddate)='' )
      '' 
    #ELSE
        IF( le.Input_fileddate = (TYPEOF(le.Input_fileddate))'','',':fileddate')
    #END
 
+    #IF( #TEXT(Input_score)='' )
      '' 
    #ELSE
        IF( le.Input_score = (TYPEOF(le.Input_score))'','',':score')
    #END
 
+    #IF( #TEXT(Input_drcategoryeventid)='' )
      '' 
    #ELSE
        IF( le.Input_drcategoryeventid = (TYPEOF(le.Input_drcategoryeventid))'','',':drcategoryeventid')
    #END
 
+    #IF( #TEXT(Input_court_code)='' )
      '' 
    #ELSE
        IF( le.Input_court_code = (TYPEOF(le.Input_court_code))'','',':court_code')
    #END
 
+    #IF( #TEXT(Input_district)='' )
      '' 
    #ELSE
        IF( le.Input_district = (TYPEOF(le.Input_district))'','',':district')
    #END
 
+    #IF( #TEXT(Input_boca_court)='' )
      '' 
    #ELSE
        IF( le.Input_boca_court = (TYPEOF(le.Input_boca_court))'','',':boca_court')
    #END
 
+    #IF( #TEXT(Input_catevent_description)='' )
      '' 
    #ELSE
        IF( le.Input_catevent_description = (TYPEOF(le.Input_catevent_description))'','',':catevent_description')
    #END
 
+    #IF( #TEXT(Input_catevent_category)='' )
      '' 
    #ELSE
        IF( le.Input_catevent_category = (TYPEOF(le.Input_catevent_category))'','',':catevent_category')
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
