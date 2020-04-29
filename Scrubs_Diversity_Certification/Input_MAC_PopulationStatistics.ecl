 
EXPORT Input_MAC_PopulationStatistics(infile,Ref='',Input_dartid = '',Input_dateadded = '',Input_dateupdated = '',Input_website = '',Input_state = '',Input_profilelastupdated = '',Input_county = '',Input_servicearea = '',Input_region1 = '',Input_region2 = '',Input_region3 = '',Input_region4 = '',Input_region5 = '',Input_fname = '',Input_lname = '',Input_mname = '',Input_suffix = '',Input_title = '',Input_ethnicity = '',Input_gender = '',Input_address1 = '',Input_address2 = '',Input_addresscity = '',Input_addressstate = '',Input_addresszipcode = '',Input_addresszip4 = '',Input_building = '',Input_contact = '',Input_phone1 = '',Input_phone2 = '',Input_phone3 = '',Input_cell = '',Input_fax = '',Input_email1 = '',Input_email2 = '',Input_email3 = '',Input_webpage1 = '',Input_webpage2 = '',Input_webpage3 = '',Input_businessname = '',Input_dba = '',Input_businessid = '',Input_businesstype1 = '',Input_businesslocation1 = '',Input_businesstype2 = '',Input_businesslocation2 = '',Input_businesstype3 = '',Input_businesslocation3 = '',Input_businesstype4 = '',Input_businesslocation4 = '',Input_businesstype5 = '',Input_businesslocation5 = '',Input_industry = '',Input_trade = '',Input_resourcedescription = '',Input_natureofbusiness = '',Input_businessstructure = '',Input_totalemployees = '',Input_avgcontractsize = '',Input_firmid = '',Input_firmlocationaddress = '',Input_firmlocationaddresscity = '',Input_firmlocationaddresszip4 = '',Input_firmlocationaddresszipcode = '',Input_firmlocationcounty = '',Input_firmlocationstate = '',Input_certfed = '',Input_certstate = '',Input_contractsfederal = '',Input_contractsva = '',Input_contractscommercial = '',Input_contractorgovernmentprime = '',Input_contractorgovernmentsub = '',Input_contractornongovernment = '',Input_registeredgovernmentbus = '',Input_registerednongovernmentbus = '',Input_clearancelevelpersonnel = '',Input_clearancelevelfacility = '',Input_certificatedatefrom1 = '',Input_certificatedateto1 = '',Input_certificatestatus1 = '',Input_certificationnumber1 = '',Input_certificationtype1 = '',Input_certificatedatefrom2 = '',Input_certificatedateto2 = '',Input_certificatestatus2 = '',Input_certificationnumber2 = '',Input_certificationtype2 = '',Input_certificatedatefrom3 = '',Input_certificatedateto3 = '',Input_certificatestatus3 = '',Input_certificationnumber3 = '',Input_certificationtype3 = '',Input_certificatedatefrom4 = '',Input_certificatedateto4 = '',Input_certificatestatus4 = '',Input_certificationnumber4 = '',Input_certificationtype4 = '',Input_certificatedatefrom5 = '',Input_certificatedateto5 = '',Input_certificatestatus5 = '',Input_certificationnumber5 = '',Input_certificationtype5 = '',Input_certificatedatefrom6 = '',Input_certificatedateto6 = '',Input_certificatestatus6 = '',Input_certificationnumber6 = '',Input_certificationtype6 = '',Input_starrating = '',Input_assets = '',Input_biddescription = '',Input_competitiveadvantage = '',Input_cagecode = '',Input_capabilitiesnarrative = '',Input_category = '',Input_chtrclass = '',Input_productdescription1 = '',Input_productdescription2 = '',Input_productdescription3 = '',Input_productdescription4 = '',Input_productdescription5 = '',Input_classdescription1 = '',Input_subclassdescription1 = '',Input_classdescription2 = '',Input_subclassdescription2 = '',Input_classdescription3 = '',Input_subclassdescription3 = '',Input_classdescription4 = '',Input_subclassdescription4 = '',Input_classdescription5 = '',Input_subclassdescription5 = '',Input_classifications = '',Input_commodity1 = '',Input_commodity2 = '',Input_commodity3 = '',Input_commodity4 = '',Input_commodity5 = '',Input_commodity6 = '',Input_commodity7 = '',Input_commodity8 = '',Input_completedate = '',Input_crossreference = '',Input_dateestablished = '',Input_businessage = '',Input_deposits = '',Input_dunsnumber = '',Input_enttype = '',Input_expirationdate = '',Input_extendeddate = '',Input_issuingauthority = '',Input_keywords = '',Input_licensenumber = '',Input_licensetype = '',Input_mincd = '',Input_minorityaffiliation = '',Input_minorityownershipdate = '',Input_siccode1 = '',Input_siccode2 = '',Input_siccode3 = '',Input_siccode4 = '',Input_siccode5 = '',Input_siccode6 = '',Input_siccode7 = '',Input_siccode8 = '',Input_naicscode1 = '',Input_naicscode2 = '',Input_naicscode3 = '',Input_naicscode4 = '',Input_naicscode5 = '',Input_naicscode6 = '',Input_naicscode7 = '',Input_naicscode8 = '',Input_prequalify = '',Input_procurementcategory1 = '',Input_subprocurementcategory1 = '',Input_procurementcategory2 = '',Input_subprocurementcategory2 = '',Input_procurementcategory3 = '',Input_subprocurementcategory3 = '',Input_procurementcategory4 = '',Input_subprocurementcategory4 = '',Input_procurementcategory5 = '',Input_subprocurementcategory5 = '',Input_renewal = '',Input_renewaldate = '',Input_unitedcertprogrampartner = '',Input_vendorkey = '',Input_vendornumber = '',Input_workcode1 = '',Input_workcode2 = '',Input_workcode3 = '',Input_workcode4 = '',Input_workcode5 = '',Input_workcode6 = '',Input_workcode7 = '',Input_workcode8 = '',Input_exporter = '',Input_exportbusinessactivities = '',Input_exportto = '',Input_exportbusinessrelationships = '',Input_exportobjectives = '',Input_reference1 = '',Input_reference2 = '',Input_reference3 = '',OutFile) := MACRO
  IMPORT SALT311,Scrubs_Diversity_Certification;
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
 
+    #IF( #TEXT(Input_profilelastupdated)='' )
      '' 
    #ELSE
        IF( le.Input_profilelastupdated = (TYPEOF(le.Input_profilelastupdated))'','',':profilelastupdated')
    #END
 
+    #IF( #TEXT(Input_county)='' )
      '' 
    #ELSE
        IF( le.Input_county = (TYPEOF(le.Input_county))'','',':county')
    #END
 
+    #IF( #TEXT(Input_servicearea)='' )
      '' 
    #ELSE
        IF( le.Input_servicearea = (TYPEOF(le.Input_servicearea))'','',':servicearea')
    #END
 
+    #IF( #TEXT(Input_region1)='' )
      '' 
    #ELSE
        IF( le.Input_region1 = (TYPEOF(le.Input_region1))'','',':region1')
    #END
 
+    #IF( #TEXT(Input_region2)='' )
      '' 
    #ELSE
        IF( le.Input_region2 = (TYPEOF(le.Input_region2))'','',':region2')
    #END
 
+    #IF( #TEXT(Input_region3)='' )
      '' 
    #ELSE
        IF( le.Input_region3 = (TYPEOF(le.Input_region3))'','',':region3')
    #END
 
+    #IF( #TEXT(Input_region4)='' )
      '' 
    #ELSE
        IF( le.Input_region4 = (TYPEOF(le.Input_region4))'','',':region4')
    #END
 
+    #IF( #TEXT(Input_region5)='' )
      '' 
    #ELSE
        IF( le.Input_region5 = (TYPEOF(le.Input_region5))'','',':region5')
    #END
 
+    #IF( #TEXT(Input_fname)='' )
      '' 
    #ELSE
        IF( le.Input_fname = (TYPEOF(le.Input_fname))'','',':fname')
    #END
 
+    #IF( #TEXT(Input_lname)='' )
      '' 
    #ELSE
        IF( le.Input_lname = (TYPEOF(le.Input_lname))'','',':lname')
    #END
 
+    #IF( #TEXT(Input_mname)='' )
      '' 
    #ELSE
        IF( le.Input_mname = (TYPEOF(le.Input_mname))'','',':mname')
    #END
 
+    #IF( #TEXT(Input_suffix)='' )
      '' 
    #ELSE
        IF( le.Input_suffix = (TYPEOF(le.Input_suffix))'','',':suffix')
    #END
 
+    #IF( #TEXT(Input_title)='' )
      '' 
    #ELSE
        IF( le.Input_title = (TYPEOF(le.Input_title))'','',':title')
    #END
 
+    #IF( #TEXT(Input_ethnicity)='' )
      '' 
    #ELSE
        IF( le.Input_ethnicity = (TYPEOF(le.Input_ethnicity))'','',':ethnicity')
    #END
 
+    #IF( #TEXT(Input_gender)='' )
      '' 
    #ELSE
        IF( le.Input_gender = (TYPEOF(le.Input_gender))'','',':gender')
    #END
 
+    #IF( #TEXT(Input_address1)='' )
      '' 
    #ELSE
        IF( le.Input_address1 = (TYPEOF(le.Input_address1))'','',':address1')
    #END
 
+    #IF( #TEXT(Input_address2)='' )
      '' 
    #ELSE
        IF( le.Input_address2 = (TYPEOF(le.Input_address2))'','',':address2')
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
 
+    #IF( #TEXT(Input_addresszipcode)='' )
      '' 
    #ELSE
        IF( le.Input_addresszipcode = (TYPEOF(le.Input_addresszipcode))'','',':addresszipcode')
    #END
 
+    #IF( #TEXT(Input_addresszip4)='' )
      '' 
    #ELSE
        IF( le.Input_addresszip4 = (TYPEOF(le.Input_addresszip4))'','',':addresszip4')
    #END
 
+    #IF( #TEXT(Input_building)='' )
      '' 
    #ELSE
        IF( le.Input_building = (TYPEOF(le.Input_building))'','',':building')
    #END
 
+    #IF( #TEXT(Input_contact)='' )
      '' 
    #ELSE
        IF( le.Input_contact = (TYPEOF(le.Input_contact))'','',':contact')
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
 
+    #IF( #TEXT(Input_cell)='' )
      '' 
    #ELSE
        IF( le.Input_cell = (TYPEOF(le.Input_cell))'','',':cell')
    #END
 
+    #IF( #TEXT(Input_fax)='' )
      '' 
    #ELSE
        IF( le.Input_fax = (TYPEOF(le.Input_fax))'','',':fax')
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
 
+    #IF( #TEXT(Input_email3)='' )
      '' 
    #ELSE
        IF( le.Input_email3 = (TYPEOF(le.Input_email3))'','',':email3')
    #END
 
+    #IF( #TEXT(Input_webpage1)='' )
      '' 
    #ELSE
        IF( le.Input_webpage1 = (TYPEOF(le.Input_webpage1))'','',':webpage1')
    #END
 
+    #IF( #TEXT(Input_webpage2)='' )
      '' 
    #ELSE
        IF( le.Input_webpage2 = (TYPEOF(le.Input_webpage2))'','',':webpage2')
    #END
 
+    #IF( #TEXT(Input_webpage3)='' )
      '' 
    #ELSE
        IF( le.Input_webpage3 = (TYPEOF(le.Input_webpage3))'','',':webpage3')
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
 
+    #IF( #TEXT(Input_businessid)='' )
      '' 
    #ELSE
        IF( le.Input_businessid = (TYPEOF(le.Input_businessid))'','',':businessid')
    #END
 
+    #IF( #TEXT(Input_businesstype1)='' )
      '' 
    #ELSE
        IF( le.Input_businesstype1 = (TYPEOF(le.Input_businesstype1))'','',':businesstype1')
    #END
 
+    #IF( #TEXT(Input_businesslocation1)='' )
      '' 
    #ELSE
        IF( le.Input_businesslocation1 = (TYPEOF(le.Input_businesslocation1))'','',':businesslocation1')
    #END
 
+    #IF( #TEXT(Input_businesstype2)='' )
      '' 
    #ELSE
        IF( le.Input_businesstype2 = (TYPEOF(le.Input_businesstype2))'','',':businesstype2')
    #END
 
+    #IF( #TEXT(Input_businesslocation2)='' )
      '' 
    #ELSE
        IF( le.Input_businesslocation2 = (TYPEOF(le.Input_businesslocation2))'','',':businesslocation2')
    #END
 
+    #IF( #TEXT(Input_businesstype3)='' )
      '' 
    #ELSE
        IF( le.Input_businesstype3 = (TYPEOF(le.Input_businesstype3))'','',':businesstype3')
    #END
 
+    #IF( #TEXT(Input_businesslocation3)='' )
      '' 
    #ELSE
        IF( le.Input_businesslocation3 = (TYPEOF(le.Input_businesslocation3))'','',':businesslocation3')
    #END
 
+    #IF( #TEXT(Input_businesstype4)='' )
      '' 
    #ELSE
        IF( le.Input_businesstype4 = (TYPEOF(le.Input_businesstype4))'','',':businesstype4')
    #END
 
+    #IF( #TEXT(Input_businesslocation4)='' )
      '' 
    #ELSE
        IF( le.Input_businesslocation4 = (TYPEOF(le.Input_businesslocation4))'','',':businesslocation4')
    #END
 
+    #IF( #TEXT(Input_businesstype5)='' )
      '' 
    #ELSE
        IF( le.Input_businesstype5 = (TYPEOF(le.Input_businesstype5))'','',':businesstype5')
    #END
 
+    #IF( #TEXT(Input_businesslocation5)='' )
      '' 
    #ELSE
        IF( le.Input_businesslocation5 = (TYPEOF(le.Input_businesslocation5))'','',':businesslocation5')
    #END
 
+    #IF( #TEXT(Input_industry)='' )
      '' 
    #ELSE
        IF( le.Input_industry = (TYPEOF(le.Input_industry))'','',':industry')
    #END
 
+    #IF( #TEXT(Input_trade)='' )
      '' 
    #ELSE
        IF( le.Input_trade = (TYPEOF(le.Input_trade))'','',':trade')
    #END
 
+    #IF( #TEXT(Input_resourcedescription)='' )
      '' 
    #ELSE
        IF( le.Input_resourcedescription = (TYPEOF(le.Input_resourcedescription))'','',':resourcedescription')
    #END
 
+    #IF( #TEXT(Input_natureofbusiness)='' )
      '' 
    #ELSE
        IF( le.Input_natureofbusiness = (TYPEOF(le.Input_natureofbusiness))'','',':natureofbusiness')
    #END
 
+    #IF( #TEXT(Input_businessstructure)='' )
      '' 
    #ELSE
        IF( le.Input_businessstructure = (TYPEOF(le.Input_businessstructure))'','',':businessstructure')
    #END
 
+    #IF( #TEXT(Input_totalemployees)='' )
      '' 
    #ELSE
        IF( le.Input_totalemployees = (TYPEOF(le.Input_totalemployees))'','',':totalemployees')
    #END
 
+    #IF( #TEXT(Input_avgcontractsize)='' )
      '' 
    #ELSE
        IF( le.Input_avgcontractsize = (TYPEOF(le.Input_avgcontractsize))'','',':avgcontractsize')
    #END
 
+    #IF( #TEXT(Input_firmid)='' )
      '' 
    #ELSE
        IF( le.Input_firmid = (TYPEOF(le.Input_firmid))'','',':firmid')
    #END
 
+    #IF( #TEXT(Input_firmlocationaddress)='' )
      '' 
    #ELSE
        IF( le.Input_firmlocationaddress = (TYPEOF(le.Input_firmlocationaddress))'','',':firmlocationaddress')
    #END
 
+    #IF( #TEXT(Input_firmlocationaddresscity)='' )
      '' 
    #ELSE
        IF( le.Input_firmlocationaddresscity = (TYPEOF(le.Input_firmlocationaddresscity))'','',':firmlocationaddresscity')
    #END
 
+    #IF( #TEXT(Input_firmlocationaddresszip4)='' )
      '' 
    #ELSE
        IF( le.Input_firmlocationaddresszip4 = (TYPEOF(le.Input_firmlocationaddresszip4))'','',':firmlocationaddresszip4')
    #END
 
+    #IF( #TEXT(Input_firmlocationaddresszipcode)='' )
      '' 
    #ELSE
        IF( le.Input_firmlocationaddresszipcode = (TYPEOF(le.Input_firmlocationaddresszipcode))'','',':firmlocationaddresszipcode')
    #END
 
+    #IF( #TEXT(Input_firmlocationcounty)='' )
      '' 
    #ELSE
        IF( le.Input_firmlocationcounty = (TYPEOF(le.Input_firmlocationcounty))'','',':firmlocationcounty')
    #END
 
+    #IF( #TEXT(Input_firmlocationstate)='' )
      '' 
    #ELSE
        IF( le.Input_firmlocationstate = (TYPEOF(le.Input_firmlocationstate))'','',':firmlocationstate')
    #END
 
+    #IF( #TEXT(Input_certfed)='' )
      '' 
    #ELSE
        IF( le.Input_certfed = (TYPEOF(le.Input_certfed))'','',':certfed')
    #END
 
+    #IF( #TEXT(Input_certstate)='' )
      '' 
    #ELSE
        IF( le.Input_certstate = (TYPEOF(le.Input_certstate))'','',':certstate')
    #END
 
+    #IF( #TEXT(Input_contractsfederal)='' )
      '' 
    #ELSE
        IF( le.Input_contractsfederal = (TYPEOF(le.Input_contractsfederal))'','',':contractsfederal')
    #END
 
+    #IF( #TEXT(Input_contractsva)='' )
      '' 
    #ELSE
        IF( le.Input_contractsva = (TYPEOF(le.Input_contractsva))'','',':contractsva')
    #END
 
+    #IF( #TEXT(Input_contractscommercial)='' )
      '' 
    #ELSE
        IF( le.Input_contractscommercial = (TYPEOF(le.Input_contractscommercial))'','',':contractscommercial')
    #END
 
+    #IF( #TEXT(Input_contractorgovernmentprime)='' )
      '' 
    #ELSE
        IF( le.Input_contractorgovernmentprime = (TYPEOF(le.Input_contractorgovernmentprime))'','',':contractorgovernmentprime')
    #END
 
+    #IF( #TEXT(Input_contractorgovernmentsub)='' )
      '' 
    #ELSE
        IF( le.Input_contractorgovernmentsub = (TYPEOF(le.Input_contractorgovernmentsub))'','',':contractorgovernmentsub')
    #END
 
+    #IF( #TEXT(Input_contractornongovernment)='' )
      '' 
    #ELSE
        IF( le.Input_contractornongovernment = (TYPEOF(le.Input_contractornongovernment))'','',':contractornongovernment')
    #END
 
+    #IF( #TEXT(Input_registeredgovernmentbus)='' )
      '' 
    #ELSE
        IF( le.Input_registeredgovernmentbus = (TYPEOF(le.Input_registeredgovernmentbus))'','',':registeredgovernmentbus')
    #END
 
+    #IF( #TEXT(Input_registerednongovernmentbus)='' )
      '' 
    #ELSE
        IF( le.Input_registerednongovernmentbus = (TYPEOF(le.Input_registerednongovernmentbus))'','',':registerednongovernmentbus')
    #END
 
+    #IF( #TEXT(Input_clearancelevelpersonnel)='' )
      '' 
    #ELSE
        IF( le.Input_clearancelevelpersonnel = (TYPEOF(le.Input_clearancelevelpersonnel))'','',':clearancelevelpersonnel')
    #END
 
+    #IF( #TEXT(Input_clearancelevelfacility)='' )
      '' 
    #ELSE
        IF( le.Input_clearancelevelfacility = (TYPEOF(le.Input_clearancelevelfacility))'','',':clearancelevelfacility')
    #END
 
+    #IF( #TEXT(Input_certificatedatefrom1)='' )
      '' 
    #ELSE
        IF( le.Input_certificatedatefrom1 = (TYPEOF(le.Input_certificatedatefrom1))'','',':certificatedatefrom1')
    #END
 
+    #IF( #TEXT(Input_certificatedateto1)='' )
      '' 
    #ELSE
        IF( le.Input_certificatedateto1 = (TYPEOF(le.Input_certificatedateto1))'','',':certificatedateto1')
    #END
 
+    #IF( #TEXT(Input_certificatestatus1)='' )
      '' 
    #ELSE
        IF( le.Input_certificatestatus1 = (TYPEOF(le.Input_certificatestatus1))'','',':certificatestatus1')
    #END
 
+    #IF( #TEXT(Input_certificationnumber1)='' )
      '' 
    #ELSE
        IF( le.Input_certificationnumber1 = (TYPEOF(le.Input_certificationnumber1))'','',':certificationnumber1')
    #END
 
+    #IF( #TEXT(Input_certificationtype1)='' )
      '' 
    #ELSE
        IF( le.Input_certificationtype1 = (TYPEOF(le.Input_certificationtype1))'','',':certificationtype1')
    #END
 
+    #IF( #TEXT(Input_certificatedatefrom2)='' )
      '' 
    #ELSE
        IF( le.Input_certificatedatefrom2 = (TYPEOF(le.Input_certificatedatefrom2))'','',':certificatedatefrom2')
    #END
 
+    #IF( #TEXT(Input_certificatedateto2)='' )
      '' 
    #ELSE
        IF( le.Input_certificatedateto2 = (TYPEOF(le.Input_certificatedateto2))'','',':certificatedateto2')
    #END
 
+    #IF( #TEXT(Input_certificatestatus2)='' )
      '' 
    #ELSE
        IF( le.Input_certificatestatus2 = (TYPEOF(le.Input_certificatestatus2))'','',':certificatestatus2')
    #END
 
+    #IF( #TEXT(Input_certificationnumber2)='' )
      '' 
    #ELSE
        IF( le.Input_certificationnumber2 = (TYPEOF(le.Input_certificationnumber2))'','',':certificationnumber2')
    #END
 
+    #IF( #TEXT(Input_certificationtype2)='' )
      '' 
    #ELSE
        IF( le.Input_certificationtype2 = (TYPEOF(le.Input_certificationtype2))'','',':certificationtype2')
    #END
 
+    #IF( #TEXT(Input_certificatedatefrom3)='' )
      '' 
    #ELSE
        IF( le.Input_certificatedatefrom3 = (TYPEOF(le.Input_certificatedatefrom3))'','',':certificatedatefrom3')
    #END
 
+    #IF( #TEXT(Input_certificatedateto3)='' )
      '' 
    #ELSE
        IF( le.Input_certificatedateto3 = (TYPEOF(le.Input_certificatedateto3))'','',':certificatedateto3')
    #END
 
+    #IF( #TEXT(Input_certificatestatus3)='' )
      '' 
    #ELSE
        IF( le.Input_certificatestatus3 = (TYPEOF(le.Input_certificatestatus3))'','',':certificatestatus3')
    #END
 
+    #IF( #TEXT(Input_certificationnumber3)='' )
      '' 
    #ELSE
        IF( le.Input_certificationnumber3 = (TYPEOF(le.Input_certificationnumber3))'','',':certificationnumber3')
    #END
 
+    #IF( #TEXT(Input_certificationtype3)='' )
      '' 
    #ELSE
        IF( le.Input_certificationtype3 = (TYPEOF(le.Input_certificationtype3))'','',':certificationtype3')
    #END
 
+    #IF( #TEXT(Input_certificatedatefrom4)='' )
      '' 
    #ELSE
        IF( le.Input_certificatedatefrom4 = (TYPEOF(le.Input_certificatedatefrom4))'','',':certificatedatefrom4')
    #END
 
+    #IF( #TEXT(Input_certificatedateto4)='' )
      '' 
    #ELSE
        IF( le.Input_certificatedateto4 = (TYPEOF(le.Input_certificatedateto4))'','',':certificatedateto4')
    #END
 
+    #IF( #TEXT(Input_certificatestatus4)='' )
      '' 
    #ELSE
        IF( le.Input_certificatestatus4 = (TYPEOF(le.Input_certificatestatus4))'','',':certificatestatus4')
    #END
 
+    #IF( #TEXT(Input_certificationnumber4)='' )
      '' 
    #ELSE
        IF( le.Input_certificationnumber4 = (TYPEOF(le.Input_certificationnumber4))'','',':certificationnumber4')
    #END
 
+    #IF( #TEXT(Input_certificationtype4)='' )
      '' 
    #ELSE
        IF( le.Input_certificationtype4 = (TYPEOF(le.Input_certificationtype4))'','',':certificationtype4')
    #END
 
+    #IF( #TEXT(Input_certificatedatefrom5)='' )
      '' 
    #ELSE
        IF( le.Input_certificatedatefrom5 = (TYPEOF(le.Input_certificatedatefrom5))'','',':certificatedatefrom5')
    #END
 
+    #IF( #TEXT(Input_certificatedateto5)='' )
      '' 
    #ELSE
        IF( le.Input_certificatedateto5 = (TYPEOF(le.Input_certificatedateto5))'','',':certificatedateto5')
    #END
 
+    #IF( #TEXT(Input_certificatestatus5)='' )
      '' 
    #ELSE
        IF( le.Input_certificatestatus5 = (TYPEOF(le.Input_certificatestatus5))'','',':certificatestatus5')
    #END
 
+    #IF( #TEXT(Input_certificationnumber5)='' )
      '' 
    #ELSE
        IF( le.Input_certificationnumber5 = (TYPEOF(le.Input_certificationnumber5))'','',':certificationnumber5')
    #END
 
+    #IF( #TEXT(Input_certificationtype5)='' )
      '' 
    #ELSE
        IF( le.Input_certificationtype5 = (TYPEOF(le.Input_certificationtype5))'','',':certificationtype5')
    #END
 
+    #IF( #TEXT(Input_certificatedatefrom6)='' )
      '' 
    #ELSE
        IF( le.Input_certificatedatefrom6 = (TYPEOF(le.Input_certificatedatefrom6))'','',':certificatedatefrom6')
    #END
 
+    #IF( #TEXT(Input_certificatedateto6)='' )
      '' 
    #ELSE
        IF( le.Input_certificatedateto6 = (TYPEOF(le.Input_certificatedateto6))'','',':certificatedateto6')
    #END
 
+    #IF( #TEXT(Input_certificatestatus6)='' )
      '' 
    #ELSE
        IF( le.Input_certificatestatus6 = (TYPEOF(le.Input_certificatestatus6))'','',':certificatestatus6')
    #END
 
+    #IF( #TEXT(Input_certificationnumber6)='' )
      '' 
    #ELSE
        IF( le.Input_certificationnumber6 = (TYPEOF(le.Input_certificationnumber6))'','',':certificationnumber6')
    #END
 
+    #IF( #TEXT(Input_certificationtype6)='' )
      '' 
    #ELSE
        IF( le.Input_certificationtype6 = (TYPEOF(le.Input_certificationtype6))'','',':certificationtype6')
    #END
 
+    #IF( #TEXT(Input_starrating)='' )
      '' 
    #ELSE
        IF( le.Input_starrating = (TYPEOF(le.Input_starrating))'','',':starrating')
    #END
 
+    #IF( #TEXT(Input_assets)='' )
      '' 
    #ELSE
        IF( le.Input_assets = (TYPEOF(le.Input_assets))'','',':assets')
    #END
 
+    #IF( #TEXT(Input_biddescription)='' )
      '' 
    #ELSE
        IF( le.Input_biddescription = (TYPEOF(le.Input_biddescription))'','',':biddescription')
    #END
 
+    #IF( #TEXT(Input_competitiveadvantage)='' )
      '' 
    #ELSE
        IF( le.Input_competitiveadvantage = (TYPEOF(le.Input_competitiveadvantage))'','',':competitiveadvantage')
    #END
 
+    #IF( #TEXT(Input_cagecode)='' )
      '' 
    #ELSE
        IF( le.Input_cagecode = (TYPEOF(le.Input_cagecode))'','',':cagecode')
    #END
 
+    #IF( #TEXT(Input_capabilitiesnarrative)='' )
      '' 
    #ELSE
        IF( le.Input_capabilitiesnarrative = (TYPEOF(le.Input_capabilitiesnarrative))'','',':capabilitiesnarrative')
    #END
 
+    #IF( #TEXT(Input_category)='' )
      '' 
    #ELSE
        IF( le.Input_category = (TYPEOF(le.Input_category))'','',':category')
    #END
 
+    #IF( #TEXT(Input_chtrclass)='' )
      '' 
    #ELSE
        IF( le.Input_chtrclass = (TYPEOF(le.Input_chtrclass))'','',':chtrclass')
    #END
 
+    #IF( #TEXT(Input_productdescription1)='' )
      '' 
    #ELSE
        IF( le.Input_productdescription1 = (TYPEOF(le.Input_productdescription1))'','',':productdescription1')
    #END
 
+    #IF( #TEXT(Input_productdescription2)='' )
      '' 
    #ELSE
        IF( le.Input_productdescription2 = (TYPEOF(le.Input_productdescription2))'','',':productdescription2')
    #END
 
+    #IF( #TEXT(Input_productdescription3)='' )
      '' 
    #ELSE
        IF( le.Input_productdescription3 = (TYPEOF(le.Input_productdescription3))'','',':productdescription3')
    #END
 
+    #IF( #TEXT(Input_productdescription4)='' )
      '' 
    #ELSE
        IF( le.Input_productdescription4 = (TYPEOF(le.Input_productdescription4))'','',':productdescription4')
    #END
 
+    #IF( #TEXT(Input_productdescription5)='' )
      '' 
    #ELSE
        IF( le.Input_productdescription5 = (TYPEOF(le.Input_productdescription5))'','',':productdescription5')
    #END
 
+    #IF( #TEXT(Input_classdescription1)='' )
      '' 
    #ELSE
        IF( le.Input_classdescription1 = (TYPEOF(le.Input_classdescription1))'','',':classdescription1')
    #END
 
+    #IF( #TEXT(Input_subclassdescription1)='' )
      '' 
    #ELSE
        IF( le.Input_subclassdescription1 = (TYPEOF(le.Input_subclassdescription1))'','',':subclassdescription1')
    #END
 
+    #IF( #TEXT(Input_classdescription2)='' )
      '' 
    #ELSE
        IF( le.Input_classdescription2 = (TYPEOF(le.Input_classdescription2))'','',':classdescription2')
    #END
 
+    #IF( #TEXT(Input_subclassdescription2)='' )
      '' 
    #ELSE
        IF( le.Input_subclassdescription2 = (TYPEOF(le.Input_subclassdescription2))'','',':subclassdescription2')
    #END
 
+    #IF( #TEXT(Input_classdescription3)='' )
      '' 
    #ELSE
        IF( le.Input_classdescription3 = (TYPEOF(le.Input_classdescription3))'','',':classdescription3')
    #END
 
+    #IF( #TEXT(Input_subclassdescription3)='' )
      '' 
    #ELSE
        IF( le.Input_subclassdescription3 = (TYPEOF(le.Input_subclassdescription3))'','',':subclassdescription3')
    #END
 
+    #IF( #TEXT(Input_classdescription4)='' )
      '' 
    #ELSE
        IF( le.Input_classdescription4 = (TYPEOF(le.Input_classdescription4))'','',':classdescription4')
    #END
 
+    #IF( #TEXT(Input_subclassdescription4)='' )
      '' 
    #ELSE
        IF( le.Input_subclassdescription4 = (TYPEOF(le.Input_subclassdescription4))'','',':subclassdescription4')
    #END
 
+    #IF( #TEXT(Input_classdescription5)='' )
      '' 
    #ELSE
        IF( le.Input_classdescription5 = (TYPEOF(le.Input_classdescription5))'','',':classdescription5')
    #END
 
+    #IF( #TEXT(Input_subclassdescription5)='' )
      '' 
    #ELSE
        IF( le.Input_subclassdescription5 = (TYPEOF(le.Input_subclassdescription5))'','',':subclassdescription5')
    #END
 
+    #IF( #TEXT(Input_classifications)='' )
      '' 
    #ELSE
        IF( le.Input_classifications = (TYPEOF(le.Input_classifications))'','',':classifications')
    #END
 
+    #IF( #TEXT(Input_commodity1)='' )
      '' 
    #ELSE
        IF( le.Input_commodity1 = (TYPEOF(le.Input_commodity1))'','',':commodity1')
    #END
 
+    #IF( #TEXT(Input_commodity2)='' )
      '' 
    #ELSE
        IF( le.Input_commodity2 = (TYPEOF(le.Input_commodity2))'','',':commodity2')
    #END
 
+    #IF( #TEXT(Input_commodity3)='' )
      '' 
    #ELSE
        IF( le.Input_commodity3 = (TYPEOF(le.Input_commodity3))'','',':commodity3')
    #END
 
+    #IF( #TEXT(Input_commodity4)='' )
      '' 
    #ELSE
        IF( le.Input_commodity4 = (TYPEOF(le.Input_commodity4))'','',':commodity4')
    #END
 
+    #IF( #TEXT(Input_commodity5)='' )
      '' 
    #ELSE
        IF( le.Input_commodity5 = (TYPEOF(le.Input_commodity5))'','',':commodity5')
    #END
 
+    #IF( #TEXT(Input_commodity6)='' )
      '' 
    #ELSE
        IF( le.Input_commodity6 = (TYPEOF(le.Input_commodity6))'','',':commodity6')
    #END
 
+    #IF( #TEXT(Input_commodity7)='' )
      '' 
    #ELSE
        IF( le.Input_commodity7 = (TYPEOF(le.Input_commodity7))'','',':commodity7')
    #END
 
+    #IF( #TEXT(Input_commodity8)='' )
      '' 
    #ELSE
        IF( le.Input_commodity8 = (TYPEOF(le.Input_commodity8))'','',':commodity8')
    #END
 
+    #IF( #TEXT(Input_completedate)='' )
      '' 
    #ELSE
        IF( le.Input_completedate = (TYPEOF(le.Input_completedate))'','',':completedate')
    #END
 
+    #IF( #TEXT(Input_crossreference)='' )
      '' 
    #ELSE
        IF( le.Input_crossreference = (TYPEOF(le.Input_crossreference))'','',':crossreference')
    #END
 
+    #IF( #TEXT(Input_dateestablished)='' )
      '' 
    #ELSE
        IF( le.Input_dateestablished = (TYPEOF(le.Input_dateestablished))'','',':dateestablished')
    #END
 
+    #IF( #TEXT(Input_businessage)='' )
      '' 
    #ELSE
        IF( le.Input_businessage = (TYPEOF(le.Input_businessage))'','',':businessage')
    #END
 
+    #IF( #TEXT(Input_deposits)='' )
      '' 
    #ELSE
        IF( le.Input_deposits = (TYPEOF(le.Input_deposits))'','',':deposits')
    #END
 
+    #IF( #TEXT(Input_dunsnumber)='' )
      '' 
    #ELSE
        IF( le.Input_dunsnumber = (TYPEOF(le.Input_dunsnumber))'','',':dunsnumber')
    #END
 
+    #IF( #TEXT(Input_enttype)='' )
      '' 
    #ELSE
        IF( le.Input_enttype = (TYPEOF(le.Input_enttype))'','',':enttype')
    #END
 
+    #IF( #TEXT(Input_expirationdate)='' )
      '' 
    #ELSE
        IF( le.Input_expirationdate = (TYPEOF(le.Input_expirationdate))'','',':expirationdate')
    #END
 
+    #IF( #TEXT(Input_extendeddate)='' )
      '' 
    #ELSE
        IF( le.Input_extendeddate = (TYPEOF(le.Input_extendeddate))'','',':extendeddate')
    #END
 
+    #IF( #TEXT(Input_issuingauthority)='' )
      '' 
    #ELSE
        IF( le.Input_issuingauthority = (TYPEOF(le.Input_issuingauthority))'','',':issuingauthority')
    #END
 
+    #IF( #TEXT(Input_keywords)='' )
      '' 
    #ELSE
        IF( le.Input_keywords = (TYPEOF(le.Input_keywords))'','',':keywords')
    #END
 
+    #IF( #TEXT(Input_licensenumber)='' )
      '' 
    #ELSE
        IF( le.Input_licensenumber = (TYPEOF(le.Input_licensenumber))'','',':licensenumber')
    #END
 
+    #IF( #TEXT(Input_licensetype)='' )
      '' 
    #ELSE
        IF( le.Input_licensetype = (TYPEOF(le.Input_licensetype))'','',':licensetype')
    #END
 
+    #IF( #TEXT(Input_mincd)='' )
      '' 
    #ELSE
        IF( le.Input_mincd = (TYPEOF(le.Input_mincd))'','',':mincd')
    #END
 
+    #IF( #TEXT(Input_minorityaffiliation)='' )
      '' 
    #ELSE
        IF( le.Input_minorityaffiliation = (TYPEOF(le.Input_minorityaffiliation))'','',':minorityaffiliation')
    #END
 
+    #IF( #TEXT(Input_minorityownershipdate)='' )
      '' 
    #ELSE
        IF( le.Input_minorityownershipdate = (TYPEOF(le.Input_minorityownershipdate))'','',':minorityownershipdate')
    #END
 
+    #IF( #TEXT(Input_siccode1)='' )
      '' 
    #ELSE
        IF( le.Input_siccode1 = (TYPEOF(le.Input_siccode1))'','',':siccode1')
    #END
 
+    #IF( #TEXT(Input_siccode2)='' )
      '' 
    #ELSE
        IF( le.Input_siccode2 = (TYPEOF(le.Input_siccode2))'','',':siccode2')
    #END
 
+    #IF( #TEXT(Input_siccode3)='' )
      '' 
    #ELSE
        IF( le.Input_siccode3 = (TYPEOF(le.Input_siccode3))'','',':siccode3')
    #END
 
+    #IF( #TEXT(Input_siccode4)='' )
      '' 
    #ELSE
        IF( le.Input_siccode4 = (TYPEOF(le.Input_siccode4))'','',':siccode4')
    #END
 
+    #IF( #TEXT(Input_siccode5)='' )
      '' 
    #ELSE
        IF( le.Input_siccode5 = (TYPEOF(le.Input_siccode5))'','',':siccode5')
    #END
 
+    #IF( #TEXT(Input_siccode6)='' )
      '' 
    #ELSE
        IF( le.Input_siccode6 = (TYPEOF(le.Input_siccode6))'','',':siccode6')
    #END
 
+    #IF( #TEXT(Input_siccode7)='' )
      '' 
    #ELSE
        IF( le.Input_siccode7 = (TYPEOF(le.Input_siccode7))'','',':siccode7')
    #END
 
+    #IF( #TEXT(Input_siccode8)='' )
      '' 
    #ELSE
        IF( le.Input_siccode8 = (TYPEOF(le.Input_siccode8))'','',':siccode8')
    #END
 
+    #IF( #TEXT(Input_naicscode1)='' )
      '' 
    #ELSE
        IF( le.Input_naicscode1 = (TYPEOF(le.Input_naicscode1))'','',':naicscode1')
    #END
 
+    #IF( #TEXT(Input_naicscode2)='' )
      '' 
    #ELSE
        IF( le.Input_naicscode2 = (TYPEOF(le.Input_naicscode2))'','',':naicscode2')
    #END
 
+    #IF( #TEXT(Input_naicscode3)='' )
      '' 
    #ELSE
        IF( le.Input_naicscode3 = (TYPEOF(le.Input_naicscode3))'','',':naicscode3')
    #END
 
+    #IF( #TEXT(Input_naicscode4)='' )
      '' 
    #ELSE
        IF( le.Input_naicscode4 = (TYPEOF(le.Input_naicscode4))'','',':naicscode4')
    #END
 
+    #IF( #TEXT(Input_naicscode5)='' )
      '' 
    #ELSE
        IF( le.Input_naicscode5 = (TYPEOF(le.Input_naicscode5))'','',':naicscode5')
    #END
 
+    #IF( #TEXT(Input_naicscode6)='' )
      '' 
    #ELSE
        IF( le.Input_naicscode6 = (TYPEOF(le.Input_naicscode6))'','',':naicscode6')
    #END
 
+    #IF( #TEXT(Input_naicscode7)='' )
      '' 
    #ELSE
        IF( le.Input_naicscode7 = (TYPEOF(le.Input_naicscode7))'','',':naicscode7')
    #END
 
+    #IF( #TEXT(Input_naicscode8)='' )
      '' 
    #ELSE
        IF( le.Input_naicscode8 = (TYPEOF(le.Input_naicscode8))'','',':naicscode8')
    #END
 
+    #IF( #TEXT(Input_prequalify)='' )
      '' 
    #ELSE
        IF( le.Input_prequalify = (TYPEOF(le.Input_prequalify))'','',':prequalify')
    #END
 
+    #IF( #TEXT(Input_procurementcategory1)='' )
      '' 
    #ELSE
        IF( le.Input_procurementcategory1 = (TYPEOF(le.Input_procurementcategory1))'','',':procurementcategory1')
    #END
 
+    #IF( #TEXT(Input_subprocurementcategory1)='' )
      '' 
    #ELSE
        IF( le.Input_subprocurementcategory1 = (TYPEOF(le.Input_subprocurementcategory1))'','',':subprocurementcategory1')
    #END
 
+    #IF( #TEXT(Input_procurementcategory2)='' )
      '' 
    #ELSE
        IF( le.Input_procurementcategory2 = (TYPEOF(le.Input_procurementcategory2))'','',':procurementcategory2')
    #END
 
+    #IF( #TEXT(Input_subprocurementcategory2)='' )
      '' 
    #ELSE
        IF( le.Input_subprocurementcategory2 = (TYPEOF(le.Input_subprocurementcategory2))'','',':subprocurementcategory2')
    #END
 
+    #IF( #TEXT(Input_procurementcategory3)='' )
      '' 
    #ELSE
        IF( le.Input_procurementcategory3 = (TYPEOF(le.Input_procurementcategory3))'','',':procurementcategory3')
    #END
 
+    #IF( #TEXT(Input_subprocurementcategory3)='' )
      '' 
    #ELSE
        IF( le.Input_subprocurementcategory3 = (TYPEOF(le.Input_subprocurementcategory3))'','',':subprocurementcategory3')
    #END
 
+    #IF( #TEXT(Input_procurementcategory4)='' )
      '' 
    #ELSE
        IF( le.Input_procurementcategory4 = (TYPEOF(le.Input_procurementcategory4))'','',':procurementcategory4')
    #END
 
+    #IF( #TEXT(Input_subprocurementcategory4)='' )
      '' 
    #ELSE
        IF( le.Input_subprocurementcategory4 = (TYPEOF(le.Input_subprocurementcategory4))'','',':subprocurementcategory4')
    #END
 
+    #IF( #TEXT(Input_procurementcategory5)='' )
      '' 
    #ELSE
        IF( le.Input_procurementcategory5 = (TYPEOF(le.Input_procurementcategory5))'','',':procurementcategory5')
    #END
 
+    #IF( #TEXT(Input_subprocurementcategory5)='' )
      '' 
    #ELSE
        IF( le.Input_subprocurementcategory5 = (TYPEOF(le.Input_subprocurementcategory5))'','',':subprocurementcategory5')
    #END
 
+    #IF( #TEXT(Input_renewal)='' )
      '' 
    #ELSE
        IF( le.Input_renewal = (TYPEOF(le.Input_renewal))'','',':renewal')
    #END
 
+    #IF( #TEXT(Input_renewaldate)='' )
      '' 
    #ELSE
        IF( le.Input_renewaldate = (TYPEOF(le.Input_renewaldate))'','',':renewaldate')
    #END
 
+    #IF( #TEXT(Input_unitedcertprogrampartner)='' )
      '' 
    #ELSE
        IF( le.Input_unitedcertprogrampartner = (TYPEOF(le.Input_unitedcertprogrampartner))'','',':unitedcertprogrampartner')
    #END
 
+    #IF( #TEXT(Input_vendorkey)='' )
      '' 
    #ELSE
        IF( le.Input_vendorkey = (TYPEOF(le.Input_vendorkey))'','',':vendorkey')
    #END
 
+    #IF( #TEXT(Input_vendornumber)='' )
      '' 
    #ELSE
        IF( le.Input_vendornumber = (TYPEOF(le.Input_vendornumber))'','',':vendornumber')
    #END
 
+    #IF( #TEXT(Input_workcode1)='' )
      '' 
    #ELSE
        IF( le.Input_workcode1 = (TYPEOF(le.Input_workcode1))'','',':workcode1')
    #END
 
+    #IF( #TEXT(Input_workcode2)='' )
      '' 
    #ELSE
        IF( le.Input_workcode2 = (TYPEOF(le.Input_workcode2))'','',':workcode2')
    #END
 
+    #IF( #TEXT(Input_workcode3)='' )
      '' 
    #ELSE
        IF( le.Input_workcode3 = (TYPEOF(le.Input_workcode3))'','',':workcode3')
    #END
 
+    #IF( #TEXT(Input_workcode4)='' )
      '' 
    #ELSE
        IF( le.Input_workcode4 = (TYPEOF(le.Input_workcode4))'','',':workcode4')
    #END
 
+    #IF( #TEXT(Input_workcode5)='' )
      '' 
    #ELSE
        IF( le.Input_workcode5 = (TYPEOF(le.Input_workcode5))'','',':workcode5')
    #END
 
+    #IF( #TEXT(Input_workcode6)='' )
      '' 
    #ELSE
        IF( le.Input_workcode6 = (TYPEOF(le.Input_workcode6))'','',':workcode6')
    #END
 
+    #IF( #TEXT(Input_workcode7)='' )
      '' 
    #ELSE
        IF( le.Input_workcode7 = (TYPEOF(le.Input_workcode7))'','',':workcode7')
    #END
 
+    #IF( #TEXT(Input_workcode8)='' )
      '' 
    #ELSE
        IF( le.Input_workcode8 = (TYPEOF(le.Input_workcode8))'','',':workcode8')
    #END
 
+    #IF( #TEXT(Input_exporter)='' )
      '' 
    #ELSE
        IF( le.Input_exporter = (TYPEOF(le.Input_exporter))'','',':exporter')
    #END
 
+    #IF( #TEXT(Input_exportbusinessactivities)='' )
      '' 
    #ELSE
        IF( le.Input_exportbusinessactivities = (TYPEOF(le.Input_exportbusinessactivities))'','',':exportbusinessactivities')
    #END
 
+    #IF( #TEXT(Input_exportto)='' )
      '' 
    #ELSE
        IF( le.Input_exportto = (TYPEOF(le.Input_exportto))'','',':exportto')
    #END
 
+    #IF( #TEXT(Input_exportbusinessrelationships)='' )
      '' 
    #ELSE
        IF( le.Input_exportbusinessrelationships = (TYPEOF(le.Input_exportbusinessrelationships))'','',':exportbusinessrelationships')
    #END
 
+    #IF( #TEXT(Input_exportobjectives)='' )
      '' 
    #ELSE
        IF( le.Input_exportobjectives = (TYPEOF(le.Input_exportobjectives))'','',':exportobjectives')
    #END
 
+    #IF( #TEXT(Input_reference1)='' )
      '' 
    #ELSE
        IF( le.Input_reference1 = (TYPEOF(le.Input_reference1))'','',':reference1')
    #END
 
+    #IF( #TEXT(Input_reference2)='' )
      '' 
    #ELSE
        IF( le.Input_reference2 = (TYPEOF(le.Input_reference2))'','',':reference2')
    #END
 
+    #IF( #TEXT(Input_reference3)='' )
      '' 
    #ELSE
        IF( le.Input_reference3 = (TYPEOF(le.Input_reference3))'','',':reference3')
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
