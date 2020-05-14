 
EXPORT MAC_PopulationStatistics(infile,Ref='',Input_dartid = '',Input_dateadded = '',Input_dateupdated = '',Input_website = '',Input_state = '',Input_euid = '',Input_policyarea = '',Input_casenumber = '',Input_memberstate = '',Input_lastdecisiondate = '',Input_title = '',Input_businessname = '',Input_region = '',Input_primaryobjective = '',Input_aidinstrument = '',Input_casetype = '',Input_durationdatefrom = '',Input_durationdateto = '',Input_notificationregistrationdate = '',Input_dgresponsible = '',Input_relatedcasenumber1 = '',Input_relatedcaseinformation1 = '',Input_relatedcasenumber2 = '',Input_relatedcaseinformation2 = '',Input_relatedcasenumber3 = '',Input_relatedcaseinformation3 = '',Input_relatedcasenumber4 = '',Input_relatedcaseinformation4 = '',Input_relatedcasenumber5 = '',Input_relatedcaseinformation5 = '',Input_provisionaldeadlinedate = '',Input_provisionaldeadlinearticle = '',Input_provisionaldeadlinestatus = '',Input_regulation = '',Input_relatedlink = '',Input_decpubid = '',Input_decisiondate = '',Input_decisionarticle = '',Input_decisiondetails = '',Input_pressrelease = '',Input_pressreleasedate = '',Input_publicationjournaldate = '',Input_publicationjournal = '',Input_publicationjournaledition = '',Input_publicationjournalyear = '',Input_publicationpriorjournal = '',Input_publicationpriorjournaldate = '',Input_econactid = '',Input_economicactivity = '',Input_compeventid = '',Input_eventdate = '',Input_eventdoctype = '',Input_eventdocument = '',Input_did = '',Input_bdid = '',Input_dt_vendor_first_reported = '',Input_dt_vendor_last_reported = '',Input_dt_first_seen = '',Input_dt_last_seen = '',Input_eu_country_code = '',OutFile) := MACRO
  IMPORT SALT311,Scrubs_ECRulings;
  #uniquename(of)
  %of% := RECORD
    SALT311.Str512Type fields;
  END;
  #uniquename(ot)
  %of% %ot%(infile le) := TRANSFORM
    SELF.fields :=
    #IF( #TEXT(Input_dartid)='' )
      '' 
    #ELSE
        IF( le.Input_dartid = (TYPEOF(le.Input_dartid))'','',':dartid')
    #END
 
+    #IF( #TEXT(Input_dateadded)='' )
      '' 
    #ELSE
        IF( le.Input_dateadded = (TYPEOF(le.Input_dateadded))'','',':dateadded')
    #END
 
+    #IF( #TEXT(Input_dateupdated)='' )
      '' 
    #ELSE
        IF( le.Input_dateupdated = (TYPEOF(le.Input_dateupdated))'','',':dateupdated')
    #END
 
+    #IF( #TEXT(Input_website)='' )
      '' 
    #ELSE
        IF( le.Input_website = (TYPEOF(le.Input_website))'','',':website')
    #END
 
+    #IF( #TEXT(Input_state)='' )
      '' 
    #ELSE
        IF( le.Input_state = (TYPEOF(le.Input_state))'','',':state')
    #END
 
+    #IF( #TEXT(Input_euid)='' )
      '' 
    #ELSE
        IF( le.Input_euid = (TYPEOF(le.Input_euid))'','',':euid')
    #END
 
+    #IF( #TEXT(Input_policyarea)='' )
      '' 
    #ELSE
        IF( le.Input_policyarea = (TYPEOF(le.Input_policyarea))'','',':policyarea')
    #END
 
+    #IF( #TEXT(Input_casenumber)='' )
      '' 
    #ELSE
        IF( le.Input_casenumber = (TYPEOF(le.Input_casenumber))'','',':casenumber')
    #END
 
+    #IF( #TEXT(Input_memberstate)='' )
      '' 
    #ELSE
        IF( le.Input_memberstate = (TYPEOF(le.Input_memberstate))'','',':memberstate')
    #END
 
+    #IF( #TEXT(Input_lastdecisiondate)='' )
      '' 
    #ELSE
        IF( le.Input_lastdecisiondate = (TYPEOF(le.Input_lastdecisiondate))'','',':lastdecisiondate')
    #END
 
+    #IF( #TEXT(Input_title)='' )
      '' 
    #ELSE
        IF( le.Input_title = (TYPEOF(le.Input_title))'','',':title')
    #END
 
+    #IF( #TEXT(Input_businessname)='' )
      '' 
    #ELSE
        IF( le.Input_businessname = (TYPEOF(le.Input_businessname))'','',':businessname')
    #END
 
+    #IF( #TEXT(Input_region)='' )
      '' 
    #ELSE
        IF( le.Input_region = (TYPEOF(le.Input_region))'','',':region')
    #END
 
+    #IF( #TEXT(Input_primaryobjective)='' )
      '' 
    #ELSE
        IF( le.Input_primaryobjective = (TYPEOF(le.Input_primaryobjective))'','',':primaryobjective')
    #END
 
+    #IF( #TEXT(Input_aidinstrument)='' )
      '' 
    #ELSE
        IF( le.Input_aidinstrument = (TYPEOF(le.Input_aidinstrument))'','',':aidinstrument')
    #END
 
+    #IF( #TEXT(Input_casetype)='' )
      '' 
    #ELSE
        IF( le.Input_casetype = (TYPEOF(le.Input_casetype))'','',':casetype')
    #END
 
+    #IF( #TEXT(Input_durationdatefrom)='' )
      '' 
    #ELSE
        IF( le.Input_durationdatefrom = (TYPEOF(le.Input_durationdatefrom))'','',':durationdatefrom')
    #END
 
+    #IF( #TEXT(Input_durationdateto)='' )
      '' 
    #ELSE
        IF( le.Input_durationdateto = (TYPEOF(le.Input_durationdateto))'','',':durationdateto')
    #END
 
+    #IF( #TEXT(Input_notificationregistrationdate)='' )
      '' 
    #ELSE
        IF( le.Input_notificationregistrationdate = (TYPEOF(le.Input_notificationregistrationdate))'','',':notificationregistrationdate')
    #END
 
+    #IF( #TEXT(Input_dgresponsible)='' )
      '' 
    #ELSE
        IF( le.Input_dgresponsible = (TYPEOF(le.Input_dgresponsible))'','',':dgresponsible')
    #END
 
+    #IF( #TEXT(Input_relatedcasenumber1)='' )
      '' 
    #ELSE
        IF( le.Input_relatedcasenumber1 = (TYPEOF(le.Input_relatedcasenumber1))'','',':relatedcasenumber1')
    #END
 
+    #IF( #TEXT(Input_relatedcaseinformation1)='' )
      '' 
    #ELSE
        IF( le.Input_relatedcaseinformation1 = (TYPEOF(le.Input_relatedcaseinformation1))'','',':relatedcaseinformation1')
    #END
 
+    #IF( #TEXT(Input_relatedcasenumber2)='' )
      '' 
    #ELSE
        IF( le.Input_relatedcasenumber2 = (TYPEOF(le.Input_relatedcasenumber2))'','',':relatedcasenumber2')
    #END
 
+    #IF( #TEXT(Input_relatedcaseinformation2)='' )
      '' 
    #ELSE
        IF( le.Input_relatedcaseinformation2 = (TYPEOF(le.Input_relatedcaseinformation2))'','',':relatedcaseinformation2')
    #END
 
+    #IF( #TEXT(Input_relatedcasenumber3)='' )
      '' 
    #ELSE
        IF( le.Input_relatedcasenumber3 = (TYPEOF(le.Input_relatedcasenumber3))'','',':relatedcasenumber3')
    #END
 
+    #IF( #TEXT(Input_relatedcaseinformation3)='' )
      '' 
    #ELSE
        IF( le.Input_relatedcaseinformation3 = (TYPEOF(le.Input_relatedcaseinformation3))'','',':relatedcaseinformation3')
    #END
 
+    #IF( #TEXT(Input_relatedcasenumber4)='' )
      '' 
    #ELSE
        IF( le.Input_relatedcasenumber4 = (TYPEOF(le.Input_relatedcasenumber4))'','',':relatedcasenumber4')
    #END
 
+    #IF( #TEXT(Input_relatedcaseinformation4)='' )
      '' 
    #ELSE
        IF( le.Input_relatedcaseinformation4 = (TYPEOF(le.Input_relatedcaseinformation4))'','',':relatedcaseinformation4')
    #END
 
+    #IF( #TEXT(Input_relatedcasenumber5)='' )
      '' 
    #ELSE
        IF( le.Input_relatedcasenumber5 = (TYPEOF(le.Input_relatedcasenumber5))'','',':relatedcasenumber5')
    #END
 
+    #IF( #TEXT(Input_relatedcaseinformation5)='' )
      '' 
    #ELSE
        IF( le.Input_relatedcaseinformation5 = (TYPEOF(le.Input_relatedcaseinformation5))'','',':relatedcaseinformation5')
    #END
 
+    #IF( #TEXT(Input_provisionaldeadlinedate)='' )
      '' 
    #ELSE
        IF( le.Input_provisionaldeadlinedate = (TYPEOF(le.Input_provisionaldeadlinedate))'','',':provisionaldeadlinedate')
    #END
 
+    #IF( #TEXT(Input_provisionaldeadlinearticle)='' )
      '' 
    #ELSE
        IF( le.Input_provisionaldeadlinearticle = (TYPEOF(le.Input_provisionaldeadlinearticle))'','',':provisionaldeadlinearticle')
    #END
 
+    #IF( #TEXT(Input_provisionaldeadlinestatus)='' )
      '' 
    #ELSE
        IF( le.Input_provisionaldeadlinestatus = (TYPEOF(le.Input_provisionaldeadlinestatus))'','',':provisionaldeadlinestatus')
    #END
 
+    #IF( #TEXT(Input_regulation)='' )
      '' 
    #ELSE
        IF( le.Input_regulation = (TYPEOF(le.Input_regulation))'','',':regulation')
    #END
 
+    #IF( #TEXT(Input_relatedlink)='' )
      '' 
    #ELSE
        IF( le.Input_relatedlink = (TYPEOF(le.Input_relatedlink))'','',':relatedlink')
    #END
 
+    #IF( #TEXT(Input_decpubid)='' )
      '' 
    #ELSE
        IF( le.Input_decpubid = (TYPEOF(le.Input_decpubid))'','',':decpubid')
    #END
 
+    #IF( #TEXT(Input_decisiondate)='' )
      '' 
    #ELSE
        IF( le.Input_decisiondate = (TYPEOF(le.Input_decisiondate))'','',':decisiondate')
    #END
 
+    #IF( #TEXT(Input_decisionarticle)='' )
      '' 
    #ELSE
        IF( le.Input_decisionarticle = (TYPEOF(le.Input_decisionarticle))'','',':decisionarticle')
    #END
 
+    #IF( #TEXT(Input_decisiondetails)='' )
      '' 
    #ELSE
        IF( le.Input_decisiondetails = (TYPEOF(le.Input_decisiondetails))'','',':decisiondetails')
    #END
 
+    #IF( #TEXT(Input_pressrelease)='' )
      '' 
    #ELSE
        IF( le.Input_pressrelease = (TYPEOF(le.Input_pressrelease))'','',':pressrelease')
    #END
 
+    #IF( #TEXT(Input_pressreleasedate)='' )
      '' 
    #ELSE
        IF( le.Input_pressreleasedate = (TYPEOF(le.Input_pressreleasedate))'','',':pressreleasedate')
    #END
 
+    #IF( #TEXT(Input_publicationjournaldate)='' )
      '' 
    #ELSE
        IF( le.Input_publicationjournaldate = (TYPEOF(le.Input_publicationjournaldate))'','',':publicationjournaldate')
    #END
 
+    #IF( #TEXT(Input_publicationjournal)='' )
      '' 
    #ELSE
        IF( le.Input_publicationjournal = (TYPEOF(le.Input_publicationjournal))'','',':publicationjournal')
    #END
 
+    #IF( #TEXT(Input_publicationjournaledition)='' )
      '' 
    #ELSE
        IF( le.Input_publicationjournaledition = (TYPEOF(le.Input_publicationjournaledition))'','',':publicationjournaledition')
    #END
 
+    #IF( #TEXT(Input_publicationjournalyear)='' )
      '' 
    #ELSE
        IF( le.Input_publicationjournalyear = (TYPEOF(le.Input_publicationjournalyear))'','',':publicationjournalyear')
    #END
 
+    #IF( #TEXT(Input_publicationpriorjournal)='' )
      '' 
    #ELSE
        IF( le.Input_publicationpriorjournal = (TYPEOF(le.Input_publicationpriorjournal))'','',':publicationpriorjournal')
    #END
 
+    #IF( #TEXT(Input_publicationpriorjournaldate)='' )
      '' 
    #ELSE
        IF( le.Input_publicationpriorjournaldate = (TYPEOF(le.Input_publicationpriorjournaldate))'','',':publicationpriorjournaldate')
    #END
 
+    #IF( #TEXT(Input_econactid)='' )
      '' 
    #ELSE
        IF( le.Input_econactid = (TYPEOF(le.Input_econactid))'','',':econactid')
    #END
 
+    #IF( #TEXT(Input_economicactivity)='' )
      '' 
    #ELSE
        IF( le.Input_economicactivity = (TYPEOF(le.Input_economicactivity))'','',':economicactivity')
    #END
 
+    #IF( #TEXT(Input_compeventid)='' )
      '' 
    #ELSE
        IF( le.Input_compeventid = (TYPEOF(le.Input_compeventid))'','',':compeventid')
    #END
 
+    #IF( #TEXT(Input_eventdate)='' )
      '' 
    #ELSE
        IF( le.Input_eventdate = (TYPEOF(le.Input_eventdate))'','',':eventdate')
    #END
 
+    #IF( #TEXT(Input_eventdoctype)='' )
      '' 
    #ELSE
        IF( le.Input_eventdoctype = (TYPEOF(le.Input_eventdoctype))'','',':eventdoctype')
    #END
 
+    #IF( #TEXT(Input_eventdocument)='' )
      '' 
    #ELSE
        IF( le.Input_eventdocument = (TYPEOF(le.Input_eventdocument))'','',':eventdocument')
    #END
 
+    #IF( #TEXT(Input_did)='' )
      '' 
    #ELSE
        IF( le.Input_did = (TYPEOF(le.Input_did))'','',':did')
    #END
 
+    #IF( #TEXT(Input_bdid)='' )
      '' 
    #ELSE
        IF( le.Input_bdid = (TYPEOF(le.Input_bdid))'','',':bdid')
    #END
 
+    #IF( #TEXT(Input_dt_vendor_first_reported)='' )
      '' 
    #ELSE
        IF( le.Input_dt_vendor_first_reported = (TYPEOF(le.Input_dt_vendor_first_reported))'','',':dt_vendor_first_reported')
    #END
 
+    #IF( #TEXT(Input_dt_vendor_last_reported)='' )
      '' 
    #ELSE
        IF( le.Input_dt_vendor_last_reported = (TYPEOF(le.Input_dt_vendor_last_reported))'','',':dt_vendor_last_reported')
    #END
 
+    #IF( #TEXT(Input_dt_first_seen)='' )
      '' 
    #ELSE
        IF( le.Input_dt_first_seen = (TYPEOF(le.Input_dt_first_seen))'','',':dt_first_seen')
    #END
 
+    #IF( #TEXT(Input_dt_last_seen)='' )
      '' 
    #ELSE
        IF( le.Input_dt_last_seen = (TYPEOF(le.Input_dt_last_seen))'','',':dt_last_seen')
    #END
 
+    #IF( #TEXT(Input_eu_country_code)='' )
      '' 
    #ELSE
        IF( le.Input_eu_country_code = (TYPEOF(le.Input_eu_country_code))'','',':eu_country_code')
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
