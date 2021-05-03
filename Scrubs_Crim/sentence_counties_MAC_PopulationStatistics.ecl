 
EXPORT sentence_counties_MAC_PopulationStatistics(infile,Ref='',vendor='',Input_recordid = '',Input_statecode = '',Input_caseid = '',Input_sentencedate = '',Input_sentencebegindate = '',Input_sentenceenddate = '',Input_sentencetype = '',Input_sentencemaxyears = '',Input_sentencemaxmonths = '',Input_sentencemaxdays = '',Input_sentenceminyears = '',Input_sentenceminmonths = '',Input_sentencemindays = '',Input_scheduledreleasedate = '',Input_actualreleasedate = '',Input_sentencestatus = '',Input_timeservedyears = '',Input_timeservedmonths = '',Input_timeserveddays = '',Input_publicservicehours = '',Input_sentenceadditionalinfo = '',Input_communitysupervisioncounty = '',Input_communitysupervisionyears = '',Input_communitysupervisionmonths = '',Input_communitysupervisiondays = '',Input_parolebegindate = '',Input_paroleenddate = '',Input_paroleeligibilitydate = '',Input_parolehearingdate = '',Input_parolemaxyears = '',Input_parolemaxmonths = '',Input_parolemaxdays = '',Input_paroleminyears = '',Input_paroleminmonths = '',Input_parolemindays = '',Input_parolestatus = '',Input_paroleofficer = '',Input_paroleoffcerphone = '',Input_probationbegindate = '',Input_probationenddate = '',Input_probationmaxyears = '',Input_probationmaxmonths = '',Input_probationmaxdays = '',Input_probationminyears = '',Input_probationminmonths = '',Input_probationmindays = '',Input_probationstatus = '',Input_sourcename = '',Input_vendor = '',OutFile) := MACRO
  IMPORT SALT311,Scrubs_Crim;
  #uniquename(of)
  %of% := RECORD
    #IF (#TEXT(vendor)<>'')
    SALT311.StrType source;
    #END
    SALT311.Str512Type fields;
  END;
  #uniquename(ot)
  %of% %ot%(infile le) := TRANSFORM
    SELF.fields :=
    #IF( #TEXT(Input_recordid)='' )
      '' 
    #ELSE
        IF( le.Input_recordid = (TYPEOF(le.Input_recordid))'','',':recordid')
    #END
 
+    #IF( #TEXT(Input_statecode)='' )
      '' 
    #ELSE
        IF( le.Input_statecode = (TYPEOF(le.Input_statecode))'','',':statecode')
    #END
 
+    #IF( #TEXT(Input_caseid)='' )
      '' 
    #ELSE
        IF( le.Input_caseid = (TYPEOF(le.Input_caseid))'','',':caseid')
    #END
 
+    #IF( #TEXT(Input_sentencedate)='' )
      '' 
    #ELSE
        IF( le.Input_sentencedate = (TYPEOF(le.Input_sentencedate))'','',':sentencedate')
    #END
 
+    #IF( #TEXT(Input_sentencebegindate)='' )
      '' 
    #ELSE
        IF( le.Input_sentencebegindate = (TYPEOF(le.Input_sentencebegindate))'','',':sentencebegindate')
    #END
 
+    #IF( #TEXT(Input_sentenceenddate)='' )
      '' 
    #ELSE
        IF( le.Input_sentenceenddate = (TYPEOF(le.Input_sentenceenddate))'','',':sentenceenddate')
    #END
 
+    #IF( #TEXT(Input_sentencetype)='' )
      '' 
    #ELSE
        IF( le.Input_sentencetype = (TYPEOF(le.Input_sentencetype))'','',':sentencetype')
    #END
 
+    #IF( #TEXT(Input_sentencemaxyears)='' )
      '' 
    #ELSE
        IF( le.Input_sentencemaxyears = (TYPEOF(le.Input_sentencemaxyears))'','',':sentencemaxyears')
    #END
 
+    #IF( #TEXT(Input_sentencemaxmonths)='' )
      '' 
    #ELSE
        IF( le.Input_sentencemaxmonths = (TYPEOF(le.Input_sentencemaxmonths))'','',':sentencemaxmonths')
    #END
 
+    #IF( #TEXT(Input_sentencemaxdays)='' )
      '' 
    #ELSE
        IF( le.Input_sentencemaxdays = (TYPEOF(le.Input_sentencemaxdays))'','',':sentencemaxdays')
    #END
 
+    #IF( #TEXT(Input_sentenceminyears)='' )
      '' 
    #ELSE
        IF( le.Input_sentenceminyears = (TYPEOF(le.Input_sentenceminyears))'','',':sentenceminyears')
    #END
 
+    #IF( #TEXT(Input_sentenceminmonths)='' )
      '' 
    #ELSE
        IF( le.Input_sentenceminmonths = (TYPEOF(le.Input_sentenceminmonths))'','',':sentenceminmonths')
    #END
 
+    #IF( #TEXT(Input_sentencemindays)='' )
      '' 
    #ELSE
        IF( le.Input_sentencemindays = (TYPEOF(le.Input_sentencemindays))'','',':sentencemindays')
    #END
 
+    #IF( #TEXT(Input_scheduledreleasedate)='' )
      '' 
    #ELSE
        IF( le.Input_scheduledreleasedate = (TYPEOF(le.Input_scheduledreleasedate))'','',':scheduledreleasedate')
    #END
 
+    #IF( #TEXT(Input_actualreleasedate)='' )
      '' 
    #ELSE
        IF( le.Input_actualreleasedate = (TYPEOF(le.Input_actualreleasedate))'','',':actualreleasedate')
    #END
 
+    #IF( #TEXT(Input_sentencestatus)='' )
      '' 
    #ELSE
        IF( le.Input_sentencestatus = (TYPEOF(le.Input_sentencestatus))'','',':sentencestatus')
    #END
 
+    #IF( #TEXT(Input_timeservedyears)='' )
      '' 
    #ELSE
        IF( le.Input_timeservedyears = (TYPEOF(le.Input_timeservedyears))'','',':timeservedyears')
    #END
 
+    #IF( #TEXT(Input_timeservedmonths)='' )
      '' 
    #ELSE
        IF( le.Input_timeservedmonths = (TYPEOF(le.Input_timeservedmonths))'','',':timeservedmonths')
    #END
 
+    #IF( #TEXT(Input_timeserveddays)='' )
      '' 
    #ELSE
        IF( le.Input_timeserveddays = (TYPEOF(le.Input_timeserveddays))'','',':timeserveddays')
    #END
 
+    #IF( #TEXT(Input_publicservicehours)='' )
      '' 
    #ELSE
        IF( le.Input_publicservicehours = (TYPEOF(le.Input_publicservicehours))'','',':publicservicehours')
    #END
 
+    #IF( #TEXT(Input_sentenceadditionalinfo)='' )
      '' 
    #ELSE
        IF( le.Input_sentenceadditionalinfo = (TYPEOF(le.Input_sentenceadditionalinfo))'','',':sentenceadditionalinfo')
    #END
 
+    #IF( #TEXT(Input_communitysupervisioncounty)='' )
      '' 
    #ELSE
        IF( le.Input_communitysupervisioncounty = (TYPEOF(le.Input_communitysupervisioncounty))'','',':communitysupervisioncounty')
    #END
 
+    #IF( #TEXT(Input_communitysupervisionyears)='' )
      '' 
    #ELSE
        IF( le.Input_communitysupervisionyears = (TYPEOF(le.Input_communitysupervisionyears))'','',':communitysupervisionyears')
    #END
 
+    #IF( #TEXT(Input_communitysupervisionmonths)='' )
      '' 
    #ELSE
        IF( le.Input_communitysupervisionmonths = (TYPEOF(le.Input_communitysupervisionmonths))'','',':communitysupervisionmonths')
    #END
 
+    #IF( #TEXT(Input_communitysupervisiondays)='' )
      '' 
    #ELSE
        IF( le.Input_communitysupervisiondays = (TYPEOF(le.Input_communitysupervisiondays))'','',':communitysupervisiondays')
    #END
 
+    #IF( #TEXT(Input_parolebegindate)='' )
      '' 
    #ELSE
        IF( le.Input_parolebegindate = (TYPEOF(le.Input_parolebegindate))'','',':parolebegindate')
    #END
 
+    #IF( #TEXT(Input_paroleenddate)='' )
      '' 
    #ELSE
        IF( le.Input_paroleenddate = (TYPEOF(le.Input_paroleenddate))'','',':paroleenddate')
    #END
 
+    #IF( #TEXT(Input_paroleeligibilitydate)='' )
      '' 
    #ELSE
        IF( le.Input_paroleeligibilitydate = (TYPEOF(le.Input_paroleeligibilitydate))'','',':paroleeligibilitydate')
    #END
 
+    #IF( #TEXT(Input_parolehearingdate)='' )
      '' 
    #ELSE
        IF( le.Input_parolehearingdate = (TYPEOF(le.Input_parolehearingdate))'','',':parolehearingdate')
    #END
 
+    #IF( #TEXT(Input_parolemaxyears)='' )
      '' 
    #ELSE
        IF( le.Input_parolemaxyears = (TYPEOF(le.Input_parolemaxyears))'','',':parolemaxyears')
    #END
 
+    #IF( #TEXT(Input_parolemaxmonths)='' )
      '' 
    #ELSE
        IF( le.Input_parolemaxmonths = (TYPEOF(le.Input_parolemaxmonths))'','',':parolemaxmonths')
    #END
 
+    #IF( #TEXT(Input_parolemaxdays)='' )
      '' 
    #ELSE
        IF( le.Input_parolemaxdays = (TYPEOF(le.Input_parolemaxdays))'','',':parolemaxdays')
    #END
 
+    #IF( #TEXT(Input_paroleminyears)='' )
      '' 
    #ELSE
        IF( le.Input_paroleminyears = (TYPEOF(le.Input_paroleminyears))'','',':paroleminyears')
    #END
 
+    #IF( #TEXT(Input_paroleminmonths)='' )
      '' 
    #ELSE
        IF( le.Input_paroleminmonths = (TYPEOF(le.Input_paroleminmonths))'','',':paroleminmonths')
    #END
 
+    #IF( #TEXT(Input_parolemindays)='' )
      '' 
    #ELSE
        IF( le.Input_parolemindays = (TYPEOF(le.Input_parolemindays))'','',':parolemindays')
    #END
 
+    #IF( #TEXT(Input_parolestatus)='' )
      '' 
    #ELSE
        IF( le.Input_parolestatus = (TYPEOF(le.Input_parolestatus))'','',':parolestatus')
    #END
 
+    #IF( #TEXT(Input_paroleofficer)='' )
      '' 
    #ELSE
        IF( le.Input_paroleofficer = (TYPEOF(le.Input_paroleofficer))'','',':paroleofficer')
    #END
 
+    #IF( #TEXT(Input_paroleoffcerphone)='' )
      '' 
    #ELSE
        IF( le.Input_paroleoffcerphone = (TYPEOF(le.Input_paroleoffcerphone))'','',':paroleoffcerphone')
    #END
 
+    #IF( #TEXT(Input_probationbegindate)='' )
      '' 
    #ELSE
        IF( le.Input_probationbegindate = (TYPEOF(le.Input_probationbegindate))'','',':probationbegindate')
    #END
 
+    #IF( #TEXT(Input_probationenddate)='' )
      '' 
    #ELSE
        IF( le.Input_probationenddate = (TYPEOF(le.Input_probationenddate))'','',':probationenddate')
    #END
 
+    #IF( #TEXT(Input_probationmaxyears)='' )
      '' 
    #ELSE
        IF( le.Input_probationmaxyears = (TYPEOF(le.Input_probationmaxyears))'','',':probationmaxyears')
    #END
 
+    #IF( #TEXT(Input_probationmaxmonths)='' )
      '' 
    #ELSE
        IF( le.Input_probationmaxmonths = (TYPEOF(le.Input_probationmaxmonths))'','',':probationmaxmonths')
    #END
 
+    #IF( #TEXT(Input_probationmaxdays)='' )
      '' 
    #ELSE
        IF( le.Input_probationmaxdays = (TYPEOF(le.Input_probationmaxdays))'','',':probationmaxdays')
    #END
 
+    #IF( #TEXT(Input_probationminyears)='' )
      '' 
    #ELSE
        IF( le.Input_probationminyears = (TYPEOF(le.Input_probationminyears))'','',':probationminyears')
    #END
 
+    #IF( #TEXT(Input_probationminmonths)='' )
      '' 
    #ELSE
        IF( le.Input_probationminmonths = (TYPEOF(le.Input_probationminmonths))'','',':probationminmonths')
    #END
 
+    #IF( #TEXT(Input_probationmindays)='' )
      '' 
    #ELSE
        IF( le.Input_probationmindays = (TYPEOF(le.Input_probationmindays))'','',':probationmindays')
    #END
 
+    #IF( #TEXT(Input_probationstatus)='' )
      '' 
    #ELSE
        IF( le.Input_probationstatus = (TYPEOF(le.Input_probationstatus))'','',':probationstatus')
    #END
 
+    #IF( #TEXT(Input_sourcename)='' )
      '' 
    #ELSE
        IF( le.Input_sourcename = (TYPEOF(le.Input_sourcename))'','',':sourcename')
    #END
 
+    #IF( #TEXT(Input_vendor)='' )
      '' 
    #ELSE
        IF( le.Input_vendor = (TYPEOF(le.Input_vendor))'','',':vendor')
    #END
;
    #IF (#TEXT(vendor)<>'')
    SELF.source := le.vendor;
    #END
  END;
  #uniquename(op)
  %op% := PROJECT(infile,%ot%(LEFT));
  #uniquename(ort)
  %ort% := RECORD
    #IF (#TEXT(vendor)<>'')
    %op%.source;
    #END
    %op%.fields;
    UNSIGNED cnt := COUNT(GROUP);
  END;
  outfile := TOPN( TABLE( %op%, %ort%,#IF( #TEXT(vendor)<>'' ) source, #END fields, FEW ), 1000,#IF( #TEXT(vendor)<>'' ) source, #END -cnt );
ENDMACRO;
