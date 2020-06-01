 
EXPORT Pol_MAC_PopulationStatistics(infile,Ref='',Input_date_firstseen = '',Input_date_lastseen = '',Input_bdid = '',Input_dotid = '',Input_dotscore = '',Input_dotweight = '',Input_empid = '',Input_empscore = '',Input_empweight = '',Input_powid = '',Input_powscore = '',Input_powweight = '',Input_proxid = '',Input_proxscore = '',Input_proxweight = '',Input_seleid = '',Input_selescore = '',Input_seleweight = '',Input_orgid = '',Input_orgscore = '',Input_orgweight = '',Input_ultid = '',Input_ultscore = '',Input_ultweight = '',Input_lninscertrecordid = '',Input_dartid = '',Input_insuranceprovider = '',Input_policynumber = '',Input_coveragestartdate = '',Input_coverageexpirationdate = '',Input_coveragewrapup = '',Input_policystatus = '',Input_insuranceprovideraddressline = '',Input_insuranceprovideraddressline2 = '',Input_insuranceprovidercity = '',Input_insuranceproviderstate = '',Input_insuranceproviderzip = '',Input_insuranceproviderzip4 = '',Input_insuranceproviderphone = '',Input_insuranceproviderfax = '',Input_coveragereinstatedate = '',Input_coveragecancellationdate = '',Input_coveragewrapupdate = '',Input_businessnameduringcoverage = '',Input_addresslineduringcoverage = '',Input_addressline2duringcoverage = '',Input_cityduringcoverage = '',Input_stateduringcoverage = '',Input_zipduringcoverage = '',Input_zip4duringcoverage = '',Input_numberofemployeesduringcoverage = '',Input_insuranceprovidercontactdept = '',Input_insurancetype = '',Input_coverageposteddate = '',Input_coverageamountfrom = '',Input_coverageamountto = '',Input_unique_id = '',Input_append_mailaddress1 = '',Input_append_mailaddresslast = '',Input_append_mailrawaid = '',Input_append_mailaceaid = '',OutFile) := MACRO
  IMPORT SALT311,Scrubs_Insurance_Cert;
  #uniquename(of)
  %of% := RECORD
    SALT311.Str512Type fields;
  END;
  #uniquename(ot)
  %of% %ot%(infile le) := TRANSFORM
    SELF.fields :=
    #IF( #TEXT(Input_date_firstseen)='' )
      '' 
    #ELSE
        IF( le.Input_date_firstseen = (TYPEOF(le.Input_date_firstseen))'','',':date_firstseen')
    #END
 
+    #IF( #TEXT(Input_date_lastseen)='' )
      '' 
    #ELSE
        IF( le.Input_date_lastseen = (TYPEOF(le.Input_date_lastseen))'','',':date_lastseen')
    #END
 
+    #IF( #TEXT(Input_bdid)='' )
      '' 
    #ELSE
        IF( le.Input_bdid = (TYPEOF(le.Input_bdid))'','',':bdid')
    #END
 
+    #IF( #TEXT(Input_dotid)='' )
      '' 
    #ELSE
        IF( le.Input_dotid = (TYPEOF(le.Input_dotid))'','',':dotid')
    #END
 
+    #IF( #TEXT(Input_dotscore)='' )
      '' 
    #ELSE
        IF( le.Input_dotscore = (TYPEOF(le.Input_dotscore))'','',':dotscore')
    #END
 
+    #IF( #TEXT(Input_dotweight)='' )
      '' 
    #ELSE
        IF( le.Input_dotweight = (TYPEOF(le.Input_dotweight))'','',':dotweight')
    #END
 
+    #IF( #TEXT(Input_empid)='' )
      '' 
    #ELSE
        IF( le.Input_empid = (TYPEOF(le.Input_empid))'','',':empid')
    #END
 
+    #IF( #TEXT(Input_empscore)='' )
      '' 
    #ELSE
        IF( le.Input_empscore = (TYPEOF(le.Input_empscore))'','',':empscore')
    #END
 
+    #IF( #TEXT(Input_empweight)='' )
      '' 
    #ELSE
        IF( le.Input_empweight = (TYPEOF(le.Input_empweight))'','',':empweight')
    #END
 
+    #IF( #TEXT(Input_powid)='' )
      '' 
    #ELSE
        IF( le.Input_powid = (TYPEOF(le.Input_powid))'','',':powid')
    #END
 
+    #IF( #TEXT(Input_powscore)='' )
      '' 
    #ELSE
        IF( le.Input_powscore = (TYPEOF(le.Input_powscore))'','',':powscore')
    #END
 
+    #IF( #TEXT(Input_powweight)='' )
      '' 
    #ELSE
        IF( le.Input_powweight = (TYPEOF(le.Input_powweight))'','',':powweight')
    #END
 
+    #IF( #TEXT(Input_proxid)='' )
      '' 
    #ELSE
        IF( le.Input_proxid = (TYPEOF(le.Input_proxid))'','',':proxid')
    #END
 
+    #IF( #TEXT(Input_proxscore)='' )
      '' 
    #ELSE
        IF( le.Input_proxscore = (TYPEOF(le.Input_proxscore))'','',':proxscore')
    #END
 
+    #IF( #TEXT(Input_proxweight)='' )
      '' 
    #ELSE
        IF( le.Input_proxweight = (TYPEOF(le.Input_proxweight))'','',':proxweight')
    #END
 
+    #IF( #TEXT(Input_seleid)='' )
      '' 
    #ELSE
        IF( le.Input_seleid = (TYPEOF(le.Input_seleid))'','',':seleid')
    #END
 
+    #IF( #TEXT(Input_selescore)='' )
      '' 
    #ELSE
        IF( le.Input_selescore = (TYPEOF(le.Input_selescore))'','',':selescore')
    #END
 
+    #IF( #TEXT(Input_seleweight)='' )
      '' 
    #ELSE
        IF( le.Input_seleweight = (TYPEOF(le.Input_seleweight))'','',':seleweight')
    #END
 
+    #IF( #TEXT(Input_orgid)='' )
      '' 
    #ELSE
        IF( le.Input_orgid = (TYPEOF(le.Input_orgid))'','',':orgid')
    #END
 
+    #IF( #TEXT(Input_orgscore)='' )
      '' 
    #ELSE
        IF( le.Input_orgscore = (TYPEOF(le.Input_orgscore))'','',':orgscore')
    #END
 
+    #IF( #TEXT(Input_orgweight)='' )
      '' 
    #ELSE
        IF( le.Input_orgweight = (TYPEOF(le.Input_orgweight))'','',':orgweight')
    #END
 
+    #IF( #TEXT(Input_ultid)='' )
      '' 
    #ELSE
        IF( le.Input_ultid = (TYPEOF(le.Input_ultid))'','',':ultid')
    #END
 
+    #IF( #TEXT(Input_ultscore)='' )
      '' 
    #ELSE
        IF( le.Input_ultscore = (TYPEOF(le.Input_ultscore))'','',':ultscore')
    #END
 
+    #IF( #TEXT(Input_ultweight)='' )
      '' 
    #ELSE
        IF( le.Input_ultweight = (TYPEOF(le.Input_ultweight))'','',':ultweight')
    #END
 
+    #IF( #TEXT(Input_lninscertrecordid)='' )
      '' 
    #ELSE
        IF( le.Input_lninscertrecordid = (TYPEOF(le.Input_lninscertrecordid))'','',':lninscertrecordid')
    #END
 
+    #IF( #TEXT(Input_dartid)='' )
      '' 
    #ELSE
        IF( le.Input_dartid = (TYPEOF(le.Input_dartid))'','',':dartid')
    #END
 
+    #IF( #TEXT(Input_insuranceprovider)='' )
      '' 
    #ELSE
        IF( le.Input_insuranceprovider = (TYPEOF(le.Input_insuranceprovider))'','',':insuranceprovider')
    #END
 
+    #IF( #TEXT(Input_policynumber)='' )
      '' 
    #ELSE
        IF( le.Input_policynumber = (TYPEOF(le.Input_policynumber))'','',':policynumber')
    #END
 
+    #IF( #TEXT(Input_coveragestartdate)='' )
      '' 
    #ELSE
        IF( le.Input_coveragestartdate = (TYPEOF(le.Input_coveragestartdate))'','',':coveragestartdate')
    #END
 
+    #IF( #TEXT(Input_coverageexpirationdate)='' )
      '' 
    #ELSE
        IF( le.Input_coverageexpirationdate = (TYPEOF(le.Input_coverageexpirationdate))'','',':coverageexpirationdate')
    #END
 
+    #IF( #TEXT(Input_coveragewrapup)='' )
      '' 
    #ELSE
        IF( le.Input_coveragewrapup = (TYPEOF(le.Input_coveragewrapup))'','',':coveragewrapup')
    #END
 
+    #IF( #TEXT(Input_policystatus)='' )
      '' 
    #ELSE
        IF( le.Input_policystatus = (TYPEOF(le.Input_policystatus))'','',':policystatus')
    #END
 
+    #IF( #TEXT(Input_insuranceprovideraddressline)='' )
      '' 
    #ELSE
        IF( le.Input_insuranceprovideraddressline = (TYPEOF(le.Input_insuranceprovideraddressline))'','',':insuranceprovideraddressline')
    #END
 
+    #IF( #TEXT(Input_insuranceprovideraddressline2)='' )
      '' 
    #ELSE
        IF( le.Input_insuranceprovideraddressline2 = (TYPEOF(le.Input_insuranceprovideraddressline2))'','',':insuranceprovideraddressline2')
    #END
 
+    #IF( #TEXT(Input_insuranceprovidercity)='' )
      '' 
    #ELSE
        IF( le.Input_insuranceprovidercity = (TYPEOF(le.Input_insuranceprovidercity))'','',':insuranceprovidercity')
    #END
 
+    #IF( #TEXT(Input_insuranceproviderstate)='' )
      '' 
    #ELSE
        IF( le.Input_insuranceproviderstate = (TYPEOF(le.Input_insuranceproviderstate))'','',':insuranceproviderstate')
    #END
 
+    #IF( #TEXT(Input_insuranceproviderzip)='' )
      '' 
    #ELSE
        IF( le.Input_insuranceproviderzip = (TYPEOF(le.Input_insuranceproviderzip))'','',':insuranceproviderzip')
    #END
 
+    #IF( #TEXT(Input_insuranceproviderzip4)='' )
      '' 
    #ELSE
        IF( le.Input_insuranceproviderzip4 = (TYPEOF(le.Input_insuranceproviderzip4))'','',':insuranceproviderzip4')
    #END
 
+    #IF( #TEXT(Input_insuranceproviderphone)='' )
      '' 
    #ELSE
        IF( le.Input_insuranceproviderphone = (TYPEOF(le.Input_insuranceproviderphone))'','',':insuranceproviderphone')
    #END
 
+    #IF( #TEXT(Input_insuranceproviderfax)='' )
      '' 
    #ELSE
        IF( le.Input_insuranceproviderfax = (TYPEOF(le.Input_insuranceproviderfax))'','',':insuranceproviderfax')
    #END
 
+    #IF( #TEXT(Input_coveragereinstatedate)='' )
      '' 
    #ELSE
        IF( le.Input_coveragereinstatedate = (TYPEOF(le.Input_coveragereinstatedate))'','',':coveragereinstatedate')
    #END
 
+    #IF( #TEXT(Input_coveragecancellationdate)='' )
      '' 
    #ELSE
        IF( le.Input_coveragecancellationdate = (TYPEOF(le.Input_coveragecancellationdate))'','',':coveragecancellationdate')
    #END
 
+    #IF( #TEXT(Input_coveragewrapupdate)='' )
      '' 
    #ELSE
        IF( le.Input_coveragewrapupdate = (TYPEOF(le.Input_coveragewrapupdate))'','',':coveragewrapupdate')
    #END
 
+    #IF( #TEXT(Input_businessnameduringcoverage)='' )
      '' 
    #ELSE
        IF( le.Input_businessnameduringcoverage = (TYPEOF(le.Input_businessnameduringcoverage))'','',':businessnameduringcoverage')
    #END
 
+    #IF( #TEXT(Input_addresslineduringcoverage)='' )
      '' 
    #ELSE
        IF( le.Input_addresslineduringcoverage = (TYPEOF(le.Input_addresslineduringcoverage))'','',':addresslineduringcoverage')
    #END
 
+    #IF( #TEXT(Input_addressline2duringcoverage)='' )
      '' 
    #ELSE
        IF( le.Input_addressline2duringcoverage = (TYPEOF(le.Input_addressline2duringcoverage))'','',':addressline2duringcoverage')
    #END
 
+    #IF( #TEXT(Input_cityduringcoverage)='' )
      '' 
    #ELSE
        IF( le.Input_cityduringcoverage = (TYPEOF(le.Input_cityduringcoverage))'','',':cityduringcoverage')
    #END
 
+    #IF( #TEXT(Input_stateduringcoverage)='' )
      '' 
    #ELSE
        IF( le.Input_stateduringcoverage = (TYPEOF(le.Input_stateduringcoverage))'','',':stateduringcoverage')
    #END
 
+    #IF( #TEXT(Input_zipduringcoverage)='' )
      '' 
    #ELSE
        IF( le.Input_zipduringcoverage = (TYPEOF(le.Input_zipduringcoverage))'','',':zipduringcoverage')
    #END
 
+    #IF( #TEXT(Input_zip4duringcoverage)='' )
      '' 
    #ELSE
        IF( le.Input_zip4duringcoverage = (TYPEOF(le.Input_zip4duringcoverage))'','',':zip4duringcoverage')
    #END
 
+    #IF( #TEXT(Input_numberofemployeesduringcoverage)='' )
      '' 
    #ELSE
        IF( le.Input_numberofemployeesduringcoverage = (TYPEOF(le.Input_numberofemployeesduringcoverage))'','',':numberofemployeesduringcoverage')
    #END
 
+    #IF( #TEXT(Input_insuranceprovidercontactdept)='' )
      '' 
    #ELSE
        IF( le.Input_insuranceprovidercontactdept = (TYPEOF(le.Input_insuranceprovidercontactdept))'','',':insuranceprovidercontactdept')
    #END
 
+    #IF( #TEXT(Input_insurancetype)='' )
      '' 
    #ELSE
        IF( le.Input_insurancetype = (TYPEOF(le.Input_insurancetype))'','',':insurancetype')
    #END
 
+    #IF( #TEXT(Input_coverageposteddate)='' )
      '' 
    #ELSE
        IF( le.Input_coverageposteddate = (TYPEOF(le.Input_coverageposteddate))'','',':coverageposteddate')
    #END
 
+    #IF( #TEXT(Input_coverageamountfrom)='' )
      '' 
    #ELSE
        IF( le.Input_coverageamountfrom = (TYPEOF(le.Input_coverageamountfrom))'','',':coverageamountfrom')
    #END
 
+    #IF( #TEXT(Input_coverageamountto)='' )
      '' 
    #ELSE
        IF( le.Input_coverageamountto = (TYPEOF(le.Input_coverageamountto))'','',':coverageamountto')
    #END
 
+    #IF( #TEXT(Input_unique_id)='' )
      '' 
    #ELSE
        IF( le.Input_unique_id = (TYPEOF(le.Input_unique_id))'','',':unique_id')
    #END
 
+    #IF( #TEXT(Input_append_mailaddress1)='' )
      '' 
    #ELSE
        IF( le.Input_append_mailaddress1 = (TYPEOF(le.Input_append_mailaddress1))'','',':append_mailaddress1')
    #END
 
+    #IF( #TEXT(Input_append_mailaddresslast)='' )
      '' 
    #ELSE
        IF( le.Input_append_mailaddresslast = (TYPEOF(le.Input_append_mailaddresslast))'','',':append_mailaddresslast')
    #END
 
+    #IF( #TEXT(Input_append_mailrawaid)='' )
      '' 
    #ELSE
        IF( le.Input_append_mailrawaid = (TYPEOF(le.Input_append_mailrawaid))'','',':append_mailrawaid')
    #END
 
+    #IF( #TEXT(Input_append_mailaceaid)='' )
      '' 
    #ELSE
        IF( le.Input_append_mailaceaid = (TYPEOF(le.Input_append_mailaceaid))'','',':append_mailaceaid')
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
