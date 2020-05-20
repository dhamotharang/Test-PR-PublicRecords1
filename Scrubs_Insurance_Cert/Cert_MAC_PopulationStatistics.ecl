 
EXPORT Cert_MAC_PopulationStatistics(infile,Ref='',Input_dartid = '',Input_dateadded = '',Input_dateupdated = '',Input_website = '',Input_state = '',Input_lninscertrecordid = '',Input_profilelastupdated = '',Input_siid = '',Input_sipstatuscode = '',Input_wcbempnumber = '',Input_ubinumber = '',Input_cofanumber = '',Input_usdotnumber = '',Input_businessname = '',Input_dba = '',Input_addressline1 = '',Input_addressline2 = '',Input_addresscity = '',Input_addressstate = '',Input_addresszip = '',Input_zip4 = '',Input_phone1 = '',Input_phone2 = '',Input_phone3 = '',Input_fax1 = '',Input_fax2 = '',Input_email1 = '',Input_email2 = '',Input_businesstype = '',Input_namefirst = '',Input_namemiddle = '',Input_namelast = '',Input_namesuffix = '',Input_nametitle = '',Input_mailingaddress1 = '',Input_mailingaddress2 = '',Input_mailingaddresscity = '',Input_mailingaddressstate = '',Input_mailingaddresszip = '',Input_mailingaddresszip4 = '',Input_contactnamefirst = '',Input_contactnamemiddle = '',Input_contactnamelast = '',Input_contactnamesuffix = '',Input_contactbusinessname = '',Input_contactaddressline1 = '',Input_contactaddressline2 = '',Input_contactcity = '',Input_contactstate = '',Input_contactzip = '',Input_contactzip4 = '',Input_contactphone = '',Input_contactfax = '',Input_contactemail = '',Input_policyholdernamefirst = '',Input_policyholdernamemiddle = '',Input_policyholdernamelast = '',Input_policyholdernamesuffix = '',Input_statepolicyfilenumber = '',Input_coverageinjuryillnessdate = '',Input_selfinsurancegroup = '',Input_selfinsurancegroupphone = '',Input_selfinsurancegroupid = '',Input_numberofemployees = '',Input_licensedcontractor = '',Input_mconame = '',Input_mconumber = '',Input_mcoaddressline1 = '',Input_mcoaddressline2 = '',Input_mcocity = '',Input_mcostate = '',Input_mcozip = '',Input_mcozip4 = '',Input_mcophone = '',Input_governingclasscode = '',Input_licensenumber = '',Input_class = '',Input_classificationdescription = '',Input_licensestatus = '',Input_licenseadditionalinfo = '',Input_licenseissuedate = '',Input_licenseexpirationdate = '',Input_naicscode = '',Input_officerexemptfirstname1 = '',Input_officerexemptlastname1 = '',Input_officerexemptmiddlename1 = '',Input_officerexempttitle1 = '',Input_officerexempteffectivedate1 = '',Input_officerexemptterminationdate1 = '',Input_officerexempttype1 = '',Input_officerexemptbusinessactivities1 = '',Input_officerexemptfirstname2 = '',Input_officerexemptlastname2 = '',Input_officerexemptmiddlename2 = '',Input_officerexempttitle2 = '',Input_officerexempteffectivedate2 = '',Input_officerexemptterminationdate2 = '',Input_officerexempttype2 = '',Input_officerexemptbusinessactivities2 = '',Input_officerexemptfirstname3 = '',Input_officerexemptlastname3 = '',Input_officerexemptmiddlename3 = '',Input_officerexempttitle3 = '',Input_officerexempteffectivedate3 = '',Input_officerexemptterminationdate3 = '',Input_officerexempttype3 = '',Input_officerexemptbusinessactivities3 = '',Input_officerexemptfirstname4 = '',Input_officerexemptlastname4 = '',Input_officerexemptmiddlename4 = '',Input_officerexempttitle4 = '',Input_officerexempteffectivedate4 = '',Input_officerexemptterminationdate4 = '',Input_officerexempttype4 = '',Input_officerexemptbusinessactivities4 = '',Input_officerexemptfirstname5 = '',Input_officerexemptlastname5 = '',Input_officerexemptmiddlename5 = '',Input_officerexempttitle5 = '',Input_officerexempteffectivedate5 = '',Input_officerexemptterminationdate5 = '',Input_officerexempttype5 = '',Input_officerexemptbusinessactivities5 = '',Input_dba1 = '',Input_dbadatefrom1 = '',Input_dbadateto1 = '',Input_dbatype1 = '',Input_dba2 = '',Input_dbadatefrom2 = '',Input_dbadateto2 = '',Input_dbatype2 = '',Input_dba3 = '',Input_dbadatefrom3 = '',Input_dbadateto3 = '',Input_dbatype3 = '',Input_dba4 = '',Input_dbadatefrom4 = '',Input_dbadateto4 = '',Input_dbatype4 = '',Input_dba5 = '',Input_dbadatefrom5 = '',Input_dbadateto5 = '',Input_dbatype5 = '',Input_subsidiaryname1 = '',Input_subsidiarystartdate1 = '',Input_subsidiaryname2 = '',Input_subsidiarystartdate2 = '',Input_subsidiaryname3 = '',Input_subsidiarystartdate3 = '',Input_subsidiaryname4 = '',Input_subsidiarystartdate4 = '',Input_subsidiaryname5 = '',Input_subsidiarystartdate5 = '',Input_subsidiaryname6 = '',Input_subsidiarystartdate6 = '',Input_subsidiaryname7 = '',Input_subsidiarystartdate7 = '',Input_subsidiaryname8 = '',Input_subsidiarystartdate8 = '',Input_subsidiaryname9 = '',Input_subsidiarystartdate9 = '',Input_subsidiaryname10 = '',Input_subsidiarystartdate10 = '',OutFile) := MACRO
  IMPORT SALT311,Scrubs_Insurance_Cert;
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
 
+    #IF( #TEXT(Input_lninscertrecordid)='' )
      '' 
    #ELSE
        IF( le.Input_lninscertrecordid = (TYPEOF(le.Input_lninscertrecordid))'','',':lninscertrecordid')
    #END
 
+    #IF( #TEXT(Input_profilelastupdated)='' )
      '' 
    #ELSE
        IF( le.Input_profilelastupdated = (TYPEOF(le.Input_profilelastupdated))'','',':profilelastupdated')
    #END
 
+    #IF( #TEXT(Input_siid)='' )
      '' 
    #ELSE
        IF( le.Input_siid = (TYPEOF(le.Input_siid))'','',':siid')
    #END
 
+    #IF( #TEXT(Input_sipstatuscode)='' )
      '' 
    #ELSE
        IF( le.Input_sipstatuscode = (TYPEOF(le.Input_sipstatuscode))'','',':sipstatuscode')
    #END
 
+    #IF( #TEXT(Input_wcbempnumber)='' )
      '' 
    #ELSE
        IF( le.Input_wcbempnumber = (TYPEOF(le.Input_wcbempnumber))'','',':wcbempnumber')
    #END
 
+    #IF( #TEXT(Input_ubinumber)='' )
      '' 
    #ELSE
        IF( le.Input_ubinumber = (TYPEOF(le.Input_ubinumber))'','',':ubinumber')
    #END
 
+    #IF( #TEXT(Input_cofanumber)='' )
      '' 
    #ELSE
        IF( le.Input_cofanumber = (TYPEOF(le.Input_cofanumber))'','',':cofanumber')
    #END
 
+    #IF( #TEXT(Input_usdotnumber)='' )
      '' 
    #ELSE
        IF( le.Input_usdotnumber = (TYPEOF(le.Input_usdotnumber))'','',':usdotnumber')
    #END
 
+    #IF( #TEXT(Input_businessname)='' )
      '' 
    #ELSE
        IF( le.Input_businessname = (TYPEOF(le.Input_businessname))'','',':businessname')
    #END
 
+    #IF( #TEXT(Input_dba)='' )
      '' 
    #ELSE
        IF( le.Input_dba = (TYPEOF(le.Input_dba))'','',':dba')
    #END
 
+    #IF( #TEXT(Input_addressline1)='' )
      '' 
    #ELSE
        IF( le.Input_addressline1 = (TYPEOF(le.Input_addressline1))'','',':addressline1')
    #END
 
+    #IF( #TEXT(Input_addressline2)='' )
      '' 
    #ELSE
        IF( le.Input_addressline2 = (TYPEOF(le.Input_addressline2))'','',':addressline2')
    #END
 
+    #IF( #TEXT(Input_addresscity)='' )
      '' 
    #ELSE
        IF( le.Input_addresscity = (TYPEOF(le.Input_addresscity))'','',':addresscity')
    #END
 
+    #IF( #TEXT(Input_addressstate)='' )
      '' 
    #ELSE
        IF( le.Input_addressstate = (TYPEOF(le.Input_addressstate))'','',':addressstate')
    #END
 
+    #IF( #TEXT(Input_addresszip)='' )
      '' 
    #ELSE
        IF( le.Input_addresszip = (TYPEOF(le.Input_addresszip))'','',':addresszip')
    #END
 
+    #IF( #TEXT(Input_zip4)='' )
      '' 
    #ELSE
        IF( le.Input_zip4 = (TYPEOF(le.Input_zip4))'','',':zip4')
    #END
 
+    #IF( #TEXT(Input_phone1)='' )
      '' 
    #ELSE
        IF( le.Input_phone1 = (TYPEOF(le.Input_phone1))'','',':phone1')
    #END
 
+    #IF( #TEXT(Input_phone2)='' )
      '' 
    #ELSE
        IF( le.Input_phone2 = (TYPEOF(le.Input_phone2))'','',':phone2')
    #END
 
+    #IF( #TEXT(Input_phone3)='' )
      '' 
    #ELSE
        IF( le.Input_phone3 = (TYPEOF(le.Input_phone3))'','',':phone3')
    #END
 
+    #IF( #TEXT(Input_fax1)='' )
      '' 
    #ELSE
        IF( le.Input_fax1 = (TYPEOF(le.Input_fax1))'','',':fax1')
    #END
 
+    #IF( #TEXT(Input_fax2)='' )
      '' 
    #ELSE
        IF( le.Input_fax2 = (TYPEOF(le.Input_fax2))'','',':fax2')
    #END
 
+    #IF( #TEXT(Input_email1)='' )
      '' 
    #ELSE
        IF( le.Input_email1 = (TYPEOF(le.Input_email1))'','',':email1')
    #END
 
+    #IF( #TEXT(Input_email2)='' )
      '' 
    #ELSE
        IF( le.Input_email2 = (TYPEOF(le.Input_email2))'','',':email2')
    #END
 
+    #IF( #TEXT(Input_businesstype)='' )
      '' 
    #ELSE
        IF( le.Input_businesstype = (TYPEOF(le.Input_businesstype))'','',':businesstype')
    #END
 
+    #IF( #TEXT(Input_namefirst)='' )
      '' 
    #ELSE
        IF( le.Input_namefirst = (TYPEOF(le.Input_namefirst))'','',':namefirst')
    #END
 
+    #IF( #TEXT(Input_namemiddle)='' )
      '' 
    #ELSE
        IF( le.Input_namemiddle = (TYPEOF(le.Input_namemiddle))'','',':namemiddle')
    #END
 
+    #IF( #TEXT(Input_namelast)='' )
      '' 
    #ELSE
        IF( le.Input_namelast = (TYPEOF(le.Input_namelast))'','',':namelast')
    #END
 
+    #IF( #TEXT(Input_namesuffix)='' )
      '' 
    #ELSE
        IF( le.Input_namesuffix = (TYPEOF(le.Input_namesuffix))'','',':namesuffix')
    #END
 
+    #IF( #TEXT(Input_nametitle)='' )
      '' 
    #ELSE
        IF( le.Input_nametitle = (TYPEOF(le.Input_nametitle))'','',':nametitle')
    #END
 
+    #IF( #TEXT(Input_mailingaddress1)='' )
      '' 
    #ELSE
        IF( le.Input_mailingaddress1 = (TYPEOF(le.Input_mailingaddress1))'','',':mailingaddress1')
    #END
 
+    #IF( #TEXT(Input_mailingaddress2)='' )
      '' 
    #ELSE
        IF( le.Input_mailingaddress2 = (TYPEOF(le.Input_mailingaddress2))'','',':mailingaddress2')
    #END
 
+    #IF( #TEXT(Input_mailingaddresscity)='' )
      '' 
    #ELSE
        IF( le.Input_mailingaddresscity = (TYPEOF(le.Input_mailingaddresscity))'','',':mailingaddresscity')
    #END
 
+    #IF( #TEXT(Input_mailingaddressstate)='' )
      '' 
    #ELSE
        IF( le.Input_mailingaddressstate = (TYPEOF(le.Input_mailingaddressstate))'','',':mailingaddressstate')
    #END
 
+    #IF( #TEXT(Input_mailingaddresszip)='' )
      '' 
    #ELSE
        IF( le.Input_mailingaddresszip = (TYPEOF(le.Input_mailingaddresszip))'','',':mailingaddresszip')
    #END
 
+    #IF( #TEXT(Input_mailingaddresszip4)='' )
      '' 
    #ELSE
        IF( le.Input_mailingaddresszip4 = (TYPEOF(le.Input_mailingaddresszip4))'','',':mailingaddresszip4')
    #END
 
+    #IF( #TEXT(Input_contactnamefirst)='' )
      '' 
    #ELSE
        IF( le.Input_contactnamefirst = (TYPEOF(le.Input_contactnamefirst))'','',':contactnamefirst')
    #END
 
+    #IF( #TEXT(Input_contactnamemiddle)='' )
      '' 
    #ELSE
        IF( le.Input_contactnamemiddle = (TYPEOF(le.Input_contactnamemiddle))'','',':contactnamemiddle')
    #END
 
+    #IF( #TEXT(Input_contactnamelast)='' )
      '' 
    #ELSE
        IF( le.Input_contactnamelast = (TYPEOF(le.Input_contactnamelast))'','',':contactnamelast')
    #END
 
+    #IF( #TEXT(Input_contactnamesuffix)='' )
      '' 
    #ELSE
        IF( le.Input_contactnamesuffix = (TYPEOF(le.Input_contactnamesuffix))'','',':contactnamesuffix')
    #END
 
+    #IF( #TEXT(Input_contactbusinessname)='' )
      '' 
    #ELSE
        IF( le.Input_contactbusinessname = (TYPEOF(le.Input_contactbusinessname))'','',':contactbusinessname')
    #END
 
+    #IF( #TEXT(Input_contactaddressline1)='' )
      '' 
    #ELSE
        IF( le.Input_contactaddressline1 = (TYPEOF(le.Input_contactaddressline1))'','',':contactaddressline1')
    #END
 
+    #IF( #TEXT(Input_contactaddressline2)='' )
      '' 
    #ELSE
        IF( le.Input_contactaddressline2 = (TYPEOF(le.Input_contactaddressline2))'','',':contactaddressline2')
    #END
 
+    #IF( #TEXT(Input_contactcity)='' )
      '' 
    #ELSE
        IF( le.Input_contactcity = (TYPEOF(le.Input_contactcity))'','',':contactcity')
    #END
 
+    #IF( #TEXT(Input_contactstate)='' )
      '' 
    #ELSE
        IF( le.Input_contactstate = (TYPEOF(le.Input_contactstate))'','',':contactstate')
    #END
 
+    #IF( #TEXT(Input_contactzip)='' )
      '' 
    #ELSE
        IF( le.Input_contactzip = (TYPEOF(le.Input_contactzip))'','',':contactzip')
    #END
 
+    #IF( #TEXT(Input_contactzip4)='' )
      '' 
    #ELSE
        IF( le.Input_contactzip4 = (TYPEOF(le.Input_contactzip4))'','',':contactzip4')
    #END
 
+    #IF( #TEXT(Input_contactphone)='' )
      '' 
    #ELSE
        IF( le.Input_contactphone = (TYPEOF(le.Input_contactphone))'','',':contactphone')
    #END
 
+    #IF( #TEXT(Input_contactfax)='' )
      '' 
    #ELSE
        IF( le.Input_contactfax = (TYPEOF(le.Input_contactfax))'','',':contactfax')
    #END
 
+    #IF( #TEXT(Input_contactemail)='' )
      '' 
    #ELSE
        IF( le.Input_contactemail = (TYPEOF(le.Input_contactemail))'','',':contactemail')
    #END
 
+    #IF( #TEXT(Input_policyholdernamefirst)='' )
      '' 
    #ELSE
        IF( le.Input_policyholdernamefirst = (TYPEOF(le.Input_policyholdernamefirst))'','',':policyholdernamefirst')
    #END
 
+    #IF( #TEXT(Input_policyholdernamemiddle)='' )
      '' 
    #ELSE
        IF( le.Input_policyholdernamemiddle = (TYPEOF(le.Input_policyholdernamemiddle))'','',':policyholdernamemiddle')
    #END
 
+    #IF( #TEXT(Input_policyholdernamelast)='' )
      '' 
    #ELSE
        IF( le.Input_policyholdernamelast = (TYPEOF(le.Input_policyholdernamelast))'','',':policyholdernamelast')
    #END
 
+    #IF( #TEXT(Input_policyholdernamesuffix)='' )
      '' 
    #ELSE
        IF( le.Input_policyholdernamesuffix = (TYPEOF(le.Input_policyholdernamesuffix))'','',':policyholdernamesuffix')
    #END
 
+    #IF( #TEXT(Input_statepolicyfilenumber)='' )
      '' 
    #ELSE
        IF( le.Input_statepolicyfilenumber = (TYPEOF(le.Input_statepolicyfilenumber))'','',':statepolicyfilenumber')
    #END
 
+    #IF( #TEXT(Input_coverageinjuryillnessdate)='' )
      '' 
    #ELSE
        IF( le.Input_coverageinjuryillnessdate = (TYPEOF(le.Input_coverageinjuryillnessdate))'','',':coverageinjuryillnessdate')
    #END
 
+    #IF( #TEXT(Input_selfinsurancegroup)='' )
      '' 
    #ELSE
        IF( le.Input_selfinsurancegroup = (TYPEOF(le.Input_selfinsurancegroup))'','',':selfinsurancegroup')
    #END
 
+    #IF( #TEXT(Input_selfinsurancegroupphone)='' )
      '' 
    #ELSE
        IF( le.Input_selfinsurancegroupphone = (TYPEOF(le.Input_selfinsurancegroupphone))'','',':selfinsurancegroupphone')
    #END
 
+    #IF( #TEXT(Input_selfinsurancegroupid)='' )
      '' 
    #ELSE
        IF( le.Input_selfinsurancegroupid = (TYPEOF(le.Input_selfinsurancegroupid))'','',':selfinsurancegroupid')
    #END
 
+    #IF( #TEXT(Input_numberofemployees)='' )
      '' 
    #ELSE
        IF( le.Input_numberofemployees = (TYPEOF(le.Input_numberofemployees))'','',':numberofemployees')
    #END
 
+    #IF( #TEXT(Input_licensedcontractor)='' )
      '' 
    #ELSE
        IF( le.Input_licensedcontractor = (TYPEOF(le.Input_licensedcontractor))'','',':licensedcontractor')
    #END
 
+    #IF( #TEXT(Input_mconame)='' )
      '' 
    #ELSE
        IF( le.Input_mconame = (TYPEOF(le.Input_mconame))'','',':mconame')
    #END
 
+    #IF( #TEXT(Input_mconumber)='' )
      '' 
    #ELSE
        IF( le.Input_mconumber = (TYPEOF(le.Input_mconumber))'','',':mconumber')
    #END
 
+    #IF( #TEXT(Input_mcoaddressline1)='' )
      '' 
    #ELSE
        IF( le.Input_mcoaddressline1 = (TYPEOF(le.Input_mcoaddressline1))'','',':mcoaddressline1')
    #END
 
+    #IF( #TEXT(Input_mcoaddressline2)='' )
      '' 
    #ELSE
        IF( le.Input_mcoaddressline2 = (TYPEOF(le.Input_mcoaddressline2))'','',':mcoaddressline2')
    #END
 
+    #IF( #TEXT(Input_mcocity)='' )
      '' 
    #ELSE
        IF( le.Input_mcocity = (TYPEOF(le.Input_mcocity))'','',':mcocity')
    #END
 
+    #IF( #TEXT(Input_mcostate)='' )
      '' 
    #ELSE
        IF( le.Input_mcostate = (TYPEOF(le.Input_mcostate))'','',':mcostate')
    #END
 
+    #IF( #TEXT(Input_mcozip)='' )
      '' 
    #ELSE
        IF( le.Input_mcozip = (TYPEOF(le.Input_mcozip))'','',':mcozip')
    #END
 
+    #IF( #TEXT(Input_mcozip4)='' )
      '' 
    #ELSE
        IF( le.Input_mcozip4 = (TYPEOF(le.Input_mcozip4))'','',':mcozip4')
    #END
 
+    #IF( #TEXT(Input_mcophone)='' )
      '' 
    #ELSE
        IF( le.Input_mcophone = (TYPEOF(le.Input_mcophone))'','',':mcophone')
    #END
 
+    #IF( #TEXT(Input_governingclasscode)='' )
      '' 
    #ELSE
        IF( le.Input_governingclasscode = (TYPEOF(le.Input_governingclasscode))'','',':governingclasscode')
    #END
 
+    #IF( #TEXT(Input_licensenumber)='' )
      '' 
    #ELSE
        IF( le.Input_licensenumber = (TYPEOF(le.Input_licensenumber))'','',':licensenumber')
    #END
 
+    #IF( #TEXT(Input_class)='' )
      '' 
    #ELSE
        IF( le.Input_class = (TYPEOF(le.Input_class))'','',':class')
    #END
 
+    #IF( #TEXT(Input_classificationdescription)='' )
      '' 
    #ELSE
        IF( le.Input_classificationdescription = (TYPEOF(le.Input_classificationdescription))'','',':classificationdescription')
    #END
 
+    #IF( #TEXT(Input_licensestatus)='' )
      '' 
    #ELSE
        IF( le.Input_licensestatus = (TYPEOF(le.Input_licensestatus))'','',':licensestatus')
    #END
 
+    #IF( #TEXT(Input_licenseadditionalinfo)='' )
      '' 
    #ELSE
        IF( le.Input_licenseadditionalinfo = (TYPEOF(le.Input_licenseadditionalinfo))'','',':licenseadditionalinfo')
    #END
 
+    #IF( #TEXT(Input_licenseissuedate)='' )
      '' 
    #ELSE
        IF( le.Input_licenseissuedate = (TYPEOF(le.Input_licenseissuedate))'','',':licenseissuedate')
    #END
 
+    #IF( #TEXT(Input_licenseexpirationdate)='' )
      '' 
    #ELSE
        IF( le.Input_licenseexpirationdate = (TYPEOF(le.Input_licenseexpirationdate))'','',':licenseexpirationdate')
    #END
 
+    #IF( #TEXT(Input_naicscode)='' )
      '' 
    #ELSE
        IF( le.Input_naicscode = (TYPEOF(le.Input_naicscode))'','',':naicscode')
    #END
 
+    #IF( #TEXT(Input_officerexemptfirstname1)='' )
      '' 
    #ELSE
        IF( le.Input_officerexemptfirstname1 = (TYPEOF(le.Input_officerexemptfirstname1))'','',':officerexemptfirstname1')
    #END
 
+    #IF( #TEXT(Input_officerexemptlastname1)='' )
      '' 
    #ELSE
        IF( le.Input_officerexemptlastname1 = (TYPEOF(le.Input_officerexemptlastname1))'','',':officerexemptlastname1')
    #END
 
+    #IF( #TEXT(Input_officerexemptmiddlename1)='' )
      '' 
    #ELSE
        IF( le.Input_officerexemptmiddlename1 = (TYPEOF(le.Input_officerexemptmiddlename1))'','',':officerexemptmiddlename1')
    #END
 
+    #IF( #TEXT(Input_officerexempttitle1)='' )
      '' 
    #ELSE
        IF( le.Input_officerexempttitle1 = (TYPEOF(le.Input_officerexempttitle1))'','',':officerexempttitle1')
    #END
 
+    #IF( #TEXT(Input_officerexempteffectivedate1)='' )
      '' 
    #ELSE
        IF( le.Input_officerexempteffectivedate1 = (TYPEOF(le.Input_officerexempteffectivedate1))'','',':officerexempteffectivedate1')
    #END
 
+    #IF( #TEXT(Input_officerexemptterminationdate1)='' )
      '' 
    #ELSE
        IF( le.Input_officerexemptterminationdate1 = (TYPEOF(le.Input_officerexemptterminationdate1))'','',':officerexemptterminationdate1')
    #END
 
+    #IF( #TEXT(Input_officerexempttype1)='' )
      '' 
    #ELSE
        IF( le.Input_officerexempttype1 = (TYPEOF(le.Input_officerexempttype1))'','',':officerexempttype1')
    #END
 
+    #IF( #TEXT(Input_officerexemptbusinessactivities1)='' )
      '' 
    #ELSE
        IF( le.Input_officerexemptbusinessactivities1 = (TYPEOF(le.Input_officerexemptbusinessactivities1))'','',':officerexemptbusinessactivities1')
    #END
 
+    #IF( #TEXT(Input_officerexemptfirstname2)='' )
      '' 
    #ELSE
        IF( le.Input_officerexemptfirstname2 = (TYPEOF(le.Input_officerexemptfirstname2))'','',':officerexemptfirstname2')
    #END
 
+    #IF( #TEXT(Input_officerexemptlastname2)='' )
      '' 
    #ELSE
        IF( le.Input_officerexemptlastname2 = (TYPEOF(le.Input_officerexemptlastname2))'','',':officerexemptlastname2')
    #END
 
+    #IF( #TEXT(Input_officerexemptmiddlename2)='' )
      '' 
    #ELSE
        IF( le.Input_officerexemptmiddlename2 = (TYPEOF(le.Input_officerexemptmiddlename2))'','',':officerexemptmiddlename2')
    #END
 
+    #IF( #TEXT(Input_officerexempttitle2)='' )
      '' 
    #ELSE
        IF( le.Input_officerexempttitle2 = (TYPEOF(le.Input_officerexempttitle2))'','',':officerexempttitle2')
    #END
 
+    #IF( #TEXT(Input_officerexempteffectivedate2)='' )
      '' 
    #ELSE
        IF( le.Input_officerexempteffectivedate2 = (TYPEOF(le.Input_officerexempteffectivedate2))'','',':officerexempteffectivedate2')
    #END
 
+    #IF( #TEXT(Input_officerexemptterminationdate2)='' )
      '' 
    #ELSE
        IF( le.Input_officerexemptterminationdate2 = (TYPEOF(le.Input_officerexemptterminationdate2))'','',':officerexemptterminationdate2')
    #END
 
+    #IF( #TEXT(Input_officerexempttype2)='' )
      '' 
    #ELSE
        IF( le.Input_officerexempttype2 = (TYPEOF(le.Input_officerexempttype2))'','',':officerexempttype2')
    #END
 
+    #IF( #TEXT(Input_officerexemptbusinessactivities2)='' )
      '' 
    #ELSE
        IF( le.Input_officerexemptbusinessactivities2 = (TYPEOF(le.Input_officerexemptbusinessactivities2))'','',':officerexemptbusinessactivities2')
    #END
 
+    #IF( #TEXT(Input_officerexemptfirstname3)='' )
      '' 
    #ELSE
        IF( le.Input_officerexemptfirstname3 = (TYPEOF(le.Input_officerexemptfirstname3))'','',':officerexemptfirstname3')
    #END
 
+    #IF( #TEXT(Input_officerexemptlastname3)='' )
      '' 
    #ELSE
        IF( le.Input_officerexemptlastname3 = (TYPEOF(le.Input_officerexemptlastname3))'','',':officerexemptlastname3')
    #END
 
+    #IF( #TEXT(Input_officerexemptmiddlename3)='' )
      '' 
    #ELSE
        IF( le.Input_officerexemptmiddlename3 = (TYPEOF(le.Input_officerexemptmiddlename3))'','',':officerexemptmiddlename3')
    #END
 
+    #IF( #TEXT(Input_officerexempttitle3)='' )
      '' 
    #ELSE
        IF( le.Input_officerexempttitle3 = (TYPEOF(le.Input_officerexempttitle3))'','',':officerexempttitle3')
    #END
 
+    #IF( #TEXT(Input_officerexempteffectivedate3)='' )
      '' 
    #ELSE
        IF( le.Input_officerexempteffectivedate3 = (TYPEOF(le.Input_officerexempteffectivedate3))'','',':officerexempteffectivedate3')
    #END
 
+    #IF( #TEXT(Input_officerexemptterminationdate3)='' )
      '' 
    #ELSE
        IF( le.Input_officerexemptterminationdate3 = (TYPEOF(le.Input_officerexemptterminationdate3))'','',':officerexemptterminationdate3')
    #END
 
+    #IF( #TEXT(Input_officerexempttype3)='' )
      '' 
    #ELSE
        IF( le.Input_officerexempttype3 = (TYPEOF(le.Input_officerexempttype3))'','',':officerexempttype3')
    #END
 
+    #IF( #TEXT(Input_officerexemptbusinessactivities3)='' )
      '' 
    #ELSE
        IF( le.Input_officerexemptbusinessactivities3 = (TYPEOF(le.Input_officerexemptbusinessactivities3))'','',':officerexemptbusinessactivities3')
    #END
 
+    #IF( #TEXT(Input_officerexemptfirstname4)='' )
      '' 
    #ELSE
        IF( le.Input_officerexemptfirstname4 = (TYPEOF(le.Input_officerexemptfirstname4))'','',':officerexemptfirstname4')
    #END
 
+    #IF( #TEXT(Input_officerexemptlastname4)='' )
      '' 
    #ELSE
        IF( le.Input_officerexemptlastname4 = (TYPEOF(le.Input_officerexemptlastname4))'','',':officerexemptlastname4')
    #END
 
+    #IF( #TEXT(Input_officerexemptmiddlename4)='' )
      '' 
    #ELSE
        IF( le.Input_officerexemptmiddlename4 = (TYPEOF(le.Input_officerexemptmiddlename4))'','',':officerexemptmiddlename4')
    #END
 
+    #IF( #TEXT(Input_officerexempttitle4)='' )
      '' 
    #ELSE
        IF( le.Input_officerexempttitle4 = (TYPEOF(le.Input_officerexempttitle4))'','',':officerexempttitle4')
    #END
 
+    #IF( #TEXT(Input_officerexempteffectivedate4)='' )
      '' 
    #ELSE
        IF( le.Input_officerexempteffectivedate4 = (TYPEOF(le.Input_officerexempteffectivedate4))'','',':officerexempteffectivedate4')
    #END
 
+    #IF( #TEXT(Input_officerexemptterminationdate4)='' )
      '' 
    #ELSE
        IF( le.Input_officerexemptterminationdate4 = (TYPEOF(le.Input_officerexemptterminationdate4))'','',':officerexemptterminationdate4')
    #END
 
+    #IF( #TEXT(Input_officerexempttype4)='' )
      '' 
    #ELSE
        IF( le.Input_officerexempttype4 = (TYPEOF(le.Input_officerexempttype4))'','',':officerexempttype4')
    #END
 
+    #IF( #TEXT(Input_officerexemptbusinessactivities4)='' )
      '' 
    #ELSE
        IF( le.Input_officerexemptbusinessactivities4 = (TYPEOF(le.Input_officerexemptbusinessactivities4))'','',':officerexemptbusinessactivities4')
    #END
 
+    #IF( #TEXT(Input_officerexemptfirstname5)='' )
      '' 
    #ELSE
        IF( le.Input_officerexemptfirstname5 = (TYPEOF(le.Input_officerexemptfirstname5))'','',':officerexemptfirstname5')
    #END
 
+    #IF( #TEXT(Input_officerexemptlastname5)='' )
      '' 
    #ELSE
        IF( le.Input_officerexemptlastname5 = (TYPEOF(le.Input_officerexemptlastname5))'','',':officerexemptlastname5')
    #END
 
+    #IF( #TEXT(Input_officerexemptmiddlename5)='' )
      '' 
    #ELSE
        IF( le.Input_officerexemptmiddlename5 = (TYPEOF(le.Input_officerexemptmiddlename5))'','',':officerexemptmiddlename5')
    #END
 
+    #IF( #TEXT(Input_officerexempttitle5)='' )
      '' 
    #ELSE
        IF( le.Input_officerexempttitle5 = (TYPEOF(le.Input_officerexempttitle5))'','',':officerexempttitle5')
    #END
 
+    #IF( #TEXT(Input_officerexempteffectivedate5)='' )
      '' 
    #ELSE
        IF( le.Input_officerexempteffectivedate5 = (TYPEOF(le.Input_officerexempteffectivedate5))'','',':officerexempteffectivedate5')
    #END
 
+    #IF( #TEXT(Input_officerexemptterminationdate5)='' )
      '' 
    #ELSE
        IF( le.Input_officerexemptterminationdate5 = (TYPEOF(le.Input_officerexemptterminationdate5))'','',':officerexemptterminationdate5')
    #END
 
+    #IF( #TEXT(Input_officerexempttype5)='' )
      '' 
    #ELSE
        IF( le.Input_officerexempttype5 = (TYPEOF(le.Input_officerexempttype5))'','',':officerexempttype5')
    #END
 
+    #IF( #TEXT(Input_officerexemptbusinessactivities5)='' )
      '' 
    #ELSE
        IF( le.Input_officerexemptbusinessactivities5 = (TYPEOF(le.Input_officerexemptbusinessactivities5))'','',':officerexemptbusinessactivities5')
    #END
 
+    #IF( #TEXT(Input_dba1)='' )
      '' 
    #ELSE
        IF( le.Input_dba1 = (TYPEOF(le.Input_dba1))'','',':dba1')
    #END
 
+    #IF( #TEXT(Input_dbadatefrom1)='' )
      '' 
    #ELSE
        IF( le.Input_dbadatefrom1 = (TYPEOF(le.Input_dbadatefrom1))'','',':dbadatefrom1')
    #END
 
+    #IF( #TEXT(Input_dbadateto1)='' )
      '' 
    #ELSE
        IF( le.Input_dbadateto1 = (TYPEOF(le.Input_dbadateto1))'','',':dbadateto1')
    #END
 
+    #IF( #TEXT(Input_dbatype1)='' )
      '' 
    #ELSE
        IF( le.Input_dbatype1 = (TYPEOF(le.Input_dbatype1))'','',':dbatype1')
    #END
 
+    #IF( #TEXT(Input_dba2)='' )
      '' 
    #ELSE
        IF( le.Input_dba2 = (TYPEOF(le.Input_dba2))'','',':dba2')
    #END
 
+    #IF( #TEXT(Input_dbadatefrom2)='' )
      '' 
    #ELSE
        IF( le.Input_dbadatefrom2 = (TYPEOF(le.Input_dbadatefrom2))'','',':dbadatefrom2')
    #END
 
+    #IF( #TEXT(Input_dbadateto2)='' )
      '' 
    #ELSE
        IF( le.Input_dbadateto2 = (TYPEOF(le.Input_dbadateto2))'','',':dbadateto2')
    #END
 
+    #IF( #TEXT(Input_dbatype2)='' )
      '' 
    #ELSE
        IF( le.Input_dbatype2 = (TYPEOF(le.Input_dbatype2))'','',':dbatype2')
    #END
 
+    #IF( #TEXT(Input_dba3)='' )
      '' 
    #ELSE
        IF( le.Input_dba3 = (TYPEOF(le.Input_dba3))'','',':dba3')
    #END
 
+    #IF( #TEXT(Input_dbadatefrom3)='' )
      '' 
    #ELSE
        IF( le.Input_dbadatefrom3 = (TYPEOF(le.Input_dbadatefrom3))'','',':dbadatefrom3')
    #END
 
+    #IF( #TEXT(Input_dbadateto3)='' )
      '' 
    #ELSE
        IF( le.Input_dbadateto3 = (TYPEOF(le.Input_dbadateto3))'','',':dbadateto3')
    #END
 
+    #IF( #TEXT(Input_dbatype3)='' )
      '' 
    #ELSE
        IF( le.Input_dbatype3 = (TYPEOF(le.Input_dbatype3))'','',':dbatype3')
    #END
 
+    #IF( #TEXT(Input_dba4)='' )
      '' 
    #ELSE
        IF( le.Input_dba4 = (TYPEOF(le.Input_dba4))'','',':dba4')
    #END
 
+    #IF( #TEXT(Input_dbadatefrom4)='' )
      '' 
    #ELSE
        IF( le.Input_dbadatefrom4 = (TYPEOF(le.Input_dbadatefrom4))'','',':dbadatefrom4')
    #END
 
+    #IF( #TEXT(Input_dbadateto4)='' )
      '' 
    #ELSE
        IF( le.Input_dbadateto4 = (TYPEOF(le.Input_dbadateto4))'','',':dbadateto4')
    #END
 
+    #IF( #TEXT(Input_dbatype4)='' )
      '' 
    #ELSE
        IF( le.Input_dbatype4 = (TYPEOF(le.Input_dbatype4))'','',':dbatype4')
    #END
 
+    #IF( #TEXT(Input_dba5)='' )
      '' 
    #ELSE
        IF( le.Input_dba5 = (TYPEOF(le.Input_dba5))'','',':dba5')
    #END
 
+    #IF( #TEXT(Input_dbadatefrom5)='' )
      '' 
    #ELSE
        IF( le.Input_dbadatefrom5 = (TYPEOF(le.Input_dbadatefrom5))'','',':dbadatefrom5')
    #END
 
+    #IF( #TEXT(Input_dbadateto5)='' )
      '' 
    #ELSE
        IF( le.Input_dbadateto5 = (TYPEOF(le.Input_dbadateto5))'','',':dbadateto5')
    #END
 
+    #IF( #TEXT(Input_dbatype5)='' )
      '' 
    #ELSE
        IF( le.Input_dbatype5 = (TYPEOF(le.Input_dbatype5))'','',':dbatype5')
    #END
 
+    #IF( #TEXT(Input_subsidiaryname1)='' )
      '' 
    #ELSE
        IF( le.Input_subsidiaryname1 = (TYPEOF(le.Input_subsidiaryname1))'','',':subsidiaryname1')
    #END
 
+    #IF( #TEXT(Input_subsidiarystartdate1)='' )
      '' 
    #ELSE
        IF( le.Input_subsidiarystartdate1 = (TYPEOF(le.Input_subsidiarystartdate1))'','',':subsidiarystartdate1')
    #END
 
+    #IF( #TEXT(Input_subsidiaryname2)='' )
      '' 
    #ELSE
        IF( le.Input_subsidiaryname2 = (TYPEOF(le.Input_subsidiaryname2))'','',':subsidiaryname2')
    #END
 
+    #IF( #TEXT(Input_subsidiarystartdate2)='' )
      '' 
    #ELSE
        IF( le.Input_subsidiarystartdate2 = (TYPEOF(le.Input_subsidiarystartdate2))'','',':subsidiarystartdate2')
    #END
 
+    #IF( #TEXT(Input_subsidiaryname3)='' )
      '' 
    #ELSE
        IF( le.Input_subsidiaryname3 = (TYPEOF(le.Input_subsidiaryname3))'','',':subsidiaryname3')
    #END
 
+    #IF( #TEXT(Input_subsidiarystartdate3)='' )
      '' 
    #ELSE
        IF( le.Input_subsidiarystartdate3 = (TYPEOF(le.Input_subsidiarystartdate3))'','',':subsidiarystartdate3')
    #END
 
+    #IF( #TEXT(Input_subsidiaryname4)='' )
      '' 
    #ELSE
        IF( le.Input_subsidiaryname4 = (TYPEOF(le.Input_subsidiaryname4))'','',':subsidiaryname4')
    #END
 
+    #IF( #TEXT(Input_subsidiarystartdate4)='' )
      '' 
    #ELSE
        IF( le.Input_subsidiarystartdate4 = (TYPEOF(le.Input_subsidiarystartdate4))'','',':subsidiarystartdate4')
    #END
 
+    #IF( #TEXT(Input_subsidiaryname5)='' )
      '' 
    #ELSE
        IF( le.Input_subsidiaryname5 = (TYPEOF(le.Input_subsidiaryname5))'','',':subsidiaryname5')
    #END
 
+    #IF( #TEXT(Input_subsidiarystartdate5)='' )
      '' 
    #ELSE
        IF( le.Input_subsidiarystartdate5 = (TYPEOF(le.Input_subsidiarystartdate5))'','',':subsidiarystartdate5')
    #END
 
+    #IF( #TEXT(Input_subsidiaryname6)='' )
      '' 
    #ELSE
        IF( le.Input_subsidiaryname6 = (TYPEOF(le.Input_subsidiaryname6))'','',':subsidiaryname6')
    #END
 
+    #IF( #TEXT(Input_subsidiarystartdate6)='' )
      '' 
    #ELSE
        IF( le.Input_subsidiarystartdate6 = (TYPEOF(le.Input_subsidiarystartdate6))'','',':subsidiarystartdate6')
    #END
 
+    #IF( #TEXT(Input_subsidiaryname7)='' )
      '' 
    #ELSE
        IF( le.Input_subsidiaryname7 = (TYPEOF(le.Input_subsidiaryname7))'','',':subsidiaryname7')
    #END
 
+    #IF( #TEXT(Input_subsidiarystartdate7)='' )
      '' 
    #ELSE
        IF( le.Input_subsidiarystartdate7 = (TYPEOF(le.Input_subsidiarystartdate7))'','',':subsidiarystartdate7')
    #END
 
+    #IF( #TEXT(Input_subsidiaryname8)='' )
      '' 
    #ELSE
        IF( le.Input_subsidiaryname8 = (TYPEOF(le.Input_subsidiaryname8))'','',':subsidiaryname8')
    #END
 
+    #IF( #TEXT(Input_subsidiarystartdate8)='' )
      '' 
    #ELSE
        IF( le.Input_subsidiarystartdate8 = (TYPEOF(le.Input_subsidiarystartdate8))'','',':subsidiarystartdate8')
    #END
 
+    #IF( #TEXT(Input_subsidiaryname9)='' )
      '' 
    #ELSE
        IF( le.Input_subsidiaryname9 = (TYPEOF(le.Input_subsidiaryname9))'','',':subsidiaryname9')
    #END
 
+    #IF( #TEXT(Input_subsidiarystartdate9)='' )
      '' 
    #ELSE
        IF( le.Input_subsidiarystartdate9 = (TYPEOF(le.Input_subsidiarystartdate9))'','',':subsidiarystartdate9')
    #END
 
+    #IF( #TEXT(Input_subsidiaryname10)='' )
      '' 
    #ELSE
        IF( le.Input_subsidiaryname10 = (TYPEOF(le.Input_subsidiaryname10))'','',':subsidiaryname10')
    #END
 
+    #IF( #TEXT(Input_subsidiarystartdate10)='' )
      '' 
    #ELSE
        IF( le.Input_subsidiarystartdate10 = (TYPEOF(le.Input_subsidiarystartdate10))'','',':subsidiarystartdate10')
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
