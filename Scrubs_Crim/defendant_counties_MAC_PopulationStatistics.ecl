 
EXPORT defendant_counties_MAC_PopulationStatistics(infile,Ref='',vendor='',Input_recordid = '',Input_sourcename = '',Input_sourcetype = '',Input_statecode = '',Input_recordtype = '',Input_recorduploaddate = '',Input_docnumber = '',Input_fbinumber = '',Input_stateidnumber = '',Input_inmatenumber = '',Input_aliennumber = '',Input_orig_ssn = '',Input_nametype = '',Input_name = '',Input_lastname = '',Input_firstname = '',Input_middlename = '',Input_suffix = '',Input_defendantstatus = '',Input_defendantadditionalinfo = '',Input_dob = '',Input_birthcity = '',Input_birthplace = '',Input_age = '',Input_gender = '',Input_height = '',Input_weight = '',Input_haircolor = '',Input_eyecolor = '',Input_race = '',Input_ethnicity = '',Input_skincolor = '',Input_bodymarks = '',Input_physicalbuild = '',Input_photoname = '',Input_dlnumber = '',Input_dlstate = '',Input_phone = '',Input_phonetype = '',Input_uscitizenflag = '',Input_addresstype = '',Input_street = '',Input_unit = '',Input_city = '',Input_orig_state = '',Input_orig_zip = '',Input_county = '',Input_institutionname = '',Input_institutiondetails = '',Input_institutionreceiptdate = '',Input_releasetolocation = '',Input_releasetodetails = '',Input_deceasedflag = '',Input_deceaseddate = '',Input_healthflag = '',Input_healthdesc = '',Input_bloodtype = '',Input_sexoffenderregistrydate = '',Input_sexoffenderregexpirationdate = '',Input_sexoffenderregistrynumber = '',Input_sourceid = '',Input_vendor = '',OutFile) := MACRO
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
 
+    #IF( #TEXT(Input_sourcename)='' )
      '' 
    #ELSE
        IF( le.Input_sourcename = (TYPEOF(le.Input_sourcename))'','',':sourcename')
    #END
 
+    #IF( #TEXT(Input_sourcetype)='' )
      '' 
    #ELSE
        IF( le.Input_sourcetype = (TYPEOF(le.Input_sourcetype))'','',':sourcetype')
    #END
 
+    #IF( #TEXT(Input_statecode)='' )
      '' 
    #ELSE
        IF( le.Input_statecode = (TYPEOF(le.Input_statecode))'','',':statecode')
    #END
 
+    #IF( #TEXT(Input_recordtype)='' )
      '' 
    #ELSE
        IF( le.Input_recordtype = (TYPEOF(le.Input_recordtype))'','',':recordtype')
    #END
 
+    #IF( #TEXT(Input_recorduploaddate)='' )
      '' 
    #ELSE
        IF( le.Input_recorduploaddate = (TYPEOF(le.Input_recorduploaddate))'','',':recorduploaddate')
    #END
 
+    #IF( #TEXT(Input_docnumber)='' )
      '' 
    #ELSE
        IF( le.Input_docnumber = (TYPEOF(le.Input_docnumber))'','',':docnumber')
    #END
 
+    #IF( #TEXT(Input_fbinumber)='' )
      '' 
    #ELSE
        IF( le.Input_fbinumber = (TYPEOF(le.Input_fbinumber))'','',':fbinumber')
    #END
 
+    #IF( #TEXT(Input_stateidnumber)='' )
      '' 
    #ELSE
        IF( le.Input_stateidnumber = (TYPEOF(le.Input_stateidnumber))'','',':stateidnumber')
    #END
 
+    #IF( #TEXT(Input_inmatenumber)='' )
      '' 
    #ELSE
        IF( le.Input_inmatenumber = (TYPEOF(le.Input_inmatenumber))'','',':inmatenumber')
    #END
 
+    #IF( #TEXT(Input_aliennumber)='' )
      '' 
    #ELSE
        IF( le.Input_aliennumber = (TYPEOF(le.Input_aliennumber))'','',':aliennumber')
    #END
 
+    #IF( #TEXT(Input_orig_ssn)='' )
      '' 
    #ELSE
        IF( le.Input_orig_ssn = (TYPEOF(le.Input_orig_ssn))'','',':orig_ssn')
    #END
 
+    #IF( #TEXT(Input_nametype)='' )
      '' 
    #ELSE
        IF( le.Input_nametype = (TYPEOF(le.Input_nametype))'','',':nametype')
    #END
 
+    #IF( #TEXT(Input_name)='' )
      '' 
    #ELSE
        IF( le.Input_name = (TYPEOF(le.Input_name))'','',':name')
    #END
 
+    #IF( #TEXT(Input_lastname)='' )
      '' 
    #ELSE
        IF( le.Input_lastname = (TYPEOF(le.Input_lastname))'','',':lastname')
    #END
 
+    #IF( #TEXT(Input_firstname)='' )
      '' 
    #ELSE
        IF( le.Input_firstname = (TYPEOF(le.Input_firstname))'','',':firstname')
    #END
 
+    #IF( #TEXT(Input_middlename)='' )
      '' 
    #ELSE
        IF( le.Input_middlename = (TYPEOF(le.Input_middlename))'','',':middlename')
    #END
 
+    #IF( #TEXT(Input_suffix)='' )
      '' 
    #ELSE
        IF( le.Input_suffix = (TYPEOF(le.Input_suffix))'','',':suffix')
    #END
 
+    #IF( #TEXT(Input_defendantstatus)='' )
      '' 
    #ELSE
        IF( le.Input_defendantstatus = (TYPEOF(le.Input_defendantstatus))'','',':defendantstatus')
    #END
 
+    #IF( #TEXT(Input_defendantadditionalinfo)='' )
      '' 
    #ELSE
        IF( le.Input_defendantadditionalinfo = (TYPEOF(le.Input_defendantadditionalinfo))'','',':defendantadditionalinfo')
    #END
 
+    #IF( #TEXT(Input_dob)='' )
      '' 
    #ELSE
        IF( le.Input_dob = (TYPEOF(le.Input_dob))'','',':dob')
    #END
 
+    #IF( #TEXT(Input_birthcity)='' )
      '' 
    #ELSE
        IF( le.Input_birthcity = (TYPEOF(le.Input_birthcity))'','',':birthcity')
    #END
 
+    #IF( #TEXT(Input_birthplace)='' )
      '' 
    #ELSE
        IF( le.Input_birthplace = (TYPEOF(le.Input_birthplace))'','',':birthplace')
    #END
 
+    #IF( #TEXT(Input_age)='' )
      '' 
    #ELSE
        IF( le.Input_age = (TYPEOF(le.Input_age))'','',':age')
    #END
 
+    #IF( #TEXT(Input_gender)='' )
      '' 
    #ELSE
        IF( le.Input_gender = (TYPEOF(le.Input_gender))'','',':gender')
    #END
 
+    #IF( #TEXT(Input_height)='' )
      '' 
    #ELSE
        IF( le.Input_height = (TYPEOF(le.Input_height))'','',':height')
    #END
 
+    #IF( #TEXT(Input_weight)='' )
      '' 
    #ELSE
        IF( le.Input_weight = (TYPEOF(le.Input_weight))'','',':weight')
    #END
 
+    #IF( #TEXT(Input_haircolor)='' )
      '' 
    #ELSE
        IF( le.Input_haircolor = (TYPEOF(le.Input_haircolor))'','',':haircolor')
    #END
 
+    #IF( #TEXT(Input_eyecolor)='' )
      '' 
    #ELSE
        IF( le.Input_eyecolor = (TYPEOF(le.Input_eyecolor))'','',':eyecolor')
    #END
 
+    #IF( #TEXT(Input_race)='' )
      '' 
    #ELSE
        IF( le.Input_race = (TYPEOF(le.Input_race))'','',':race')
    #END
 
+    #IF( #TEXT(Input_ethnicity)='' )
      '' 
    #ELSE
        IF( le.Input_ethnicity = (TYPEOF(le.Input_ethnicity))'','',':ethnicity')
    #END
 
+    #IF( #TEXT(Input_skincolor)='' )
      '' 
    #ELSE
        IF( le.Input_skincolor = (TYPEOF(le.Input_skincolor))'','',':skincolor')
    #END
 
+    #IF( #TEXT(Input_bodymarks)='' )
      '' 
    #ELSE
        IF( le.Input_bodymarks = (TYPEOF(le.Input_bodymarks))'','',':bodymarks')
    #END
 
+    #IF( #TEXT(Input_physicalbuild)='' )
      '' 
    #ELSE
        IF( le.Input_physicalbuild = (TYPEOF(le.Input_physicalbuild))'','',':physicalbuild')
    #END
 
+    #IF( #TEXT(Input_photoname)='' )
      '' 
    #ELSE
        IF( le.Input_photoname = (TYPEOF(le.Input_photoname))'','',':photoname')
    #END
 
+    #IF( #TEXT(Input_dlnumber)='' )
      '' 
    #ELSE
        IF( le.Input_dlnumber = (TYPEOF(le.Input_dlnumber))'','',':dlnumber')
    #END
 
+    #IF( #TEXT(Input_dlstate)='' )
      '' 
    #ELSE
        IF( le.Input_dlstate = (TYPEOF(le.Input_dlstate))'','',':dlstate')
    #END
 
+    #IF( #TEXT(Input_phone)='' )
      '' 
    #ELSE
        IF( le.Input_phone = (TYPEOF(le.Input_phone))'','',':phone')
    #END
 
+    #IF( #TEXT(Input_phonetype)='' )
      '' 
    #ELSE
        IF( le.Input_phonetype = (TYPEOF(le.Input_phonetype))'','',':phonetype')
    #END
 
+    #IF( #TEXT(Input_uscitizenflag)='' )
      '' 
    #ELSE
        IF( le.Input_uscitizenflag = (TYPEOF(le.Input_uscitizenflag))'','',':uscitizenflag')
    #END
 
+    #IF( #TEXT(Input_addresstype)='' )
      '' 
    #ELSE
        IF( le.Input_addresstype = (TYPEOF(le.Input_addresstype))'','',':addresstype')
    #END
 
+    #IF( #TEXT(Input_street)='' )
      '' 
    #ELSE
        IF( le.Input_street = (TYPEOF(le.Input_street))'','',':street')
    #END
 
+    #IF( #TEXT(Input_unit)='' )
      '' 
    #ELSE
        IF( le.Input_unit = (TYPEOF(le.Input_unit))'','',':unit')
    #END
 
+    #IF( #TEXT(Input_city)='' )
      '' 
    #ELSE
        IF( le.Input_city = (TYPEOF(le.Input_city))'','',':city')
    #END
 
+    #IF( #TEXT(Input_orig_state)='' )
      '' 
    #ELSE
        IF( le.Input_orig_state = (TYPEOF(le.Input_orig_state))'','',':orig_state')
    #END
 
+    #IF( #TEXT(Input_orig_zip)='' )
      '' 
    #ELSE
        IF( le.Input_orig_zip = (TYPEOF(le.Input_orig_zip))'','',':orig_zip')
    #END
 
+    #IF( #TEXT(Input_county)='' )
      '' 
    #ELSE
        IF( le.Input_county = (TYPEOF(le.Input_county))'','',':county')
    #END
 
+    #IF( #TEXT(Input_institutionname)='' )
      '' 
    #ELSE
        IF( le.Input_institutionname = (TYPEOF(le.Input_institutionname))'','',':institutionname')
    #END
 
+    #IF( #TEXT(Input_institutiondetails)='' )
      '' 
    #ELSE
        IF( le.Input_institutiondetails = (TYPEOF(le.Input_institutiondetails))'','',':institutiondetails')
    #END
 
+    #IF( #TEXT(Input_institutionreceiptdate)='' )
      '' 
    #ELSE
        IF( le.Input_institutionreceiptdate = (TYPEOF(le.Input_institutionreceiptdate))'','',':institutionreceiptdate')
    #END
 
+    #IF( #TEXT(Input_releasetolocation)='' )
      '' 
    #ELSE
        IF( le.Input_releasetolocation = (TYPEOF(le.Input_releasetolocation))'','',':releasetolocation')
    #END
 
+    #IF( #TEXT(Input_releasetodetails)='' )
      '' 
    #ELSE
        IF( le.Input_releasetodetails = (TYPEOF(le.Input_releasetodetails))'','',':releasetodetails')
    #END
 
+    #IF( #TEXT(Input_deceasedflag)='' )
      '' 
    #ELSE
        IF( le.Input_deceasedflag = (TYPEOF(le.Input_deceasedflag))'','',':deceasedflag')
    #END
 
+    #IF( #TEXT(Input_deceaseddate)='' )
      '' 
    #ELSE
        IF( le.Input_deceaseddate = (TYPEOF(le.Input_deceaseddate))'','',':deceaseddate')
    #END
 
+    #IF( #TEXT(Input_healthflag)='' )
      '' 
    #ELSE
        IF( le.Input_healthflag = (TYPEOF(le.Input_healthflag))'','',':healthflag')
    #END
 
+    #IF( #TEXT(Input_healthdesc)='' )
      '' 
    #ELSE
        IF( le.Input_healthdesc = (TYPEOF(le.Input_healthdesc))'','',':healthdesc')
    #END
 
+    #IF( #TEXT(Input_bloodtype)='' )
      '' 
    #ELSE
        IF( le.Input_bloodtype = (TYPEOF(le.Input_bloodtype))'','',':bloodtype')
    #END
 
+    #IF( #TEXT(Input_sexoffenderregistrydate)='' )
      '' 
    #ELSE
        IF( le.Input_sexoffenderregistrydate = (TYPEOF(le.Input_sexoffenderregistrydate))'','',':sexoffenderregistrydate')
    #END
 
+    #IF( #TEXT(Input_sexoffenderregexpirationdate)='' )
      '' 
    #ELSE
        IF( le.Input_sexoffenderregexpirationdate = (TYPEOF(le.Input_sexoffenderregexpirationdate))'','',':sexoffenderregexpirationdate')
    #END
 
+    #IF( #TEXT(Input_sexoffenderregistrynumber)='' )
      '' 
    #ELSE
        IF( le.Input_sexoffenderregistrynumber = (TYPEOF(le.Input_sexoffenderregistrynumber))'','',':sexoffenderregistrynumber')
    #END
 
+    #IF( #TEXT(Input_sourceid)='' )
      '' 
    #ELSE
        IF( le.Input_sourceid = (TYPEOF(le.Input_sourceid))'','',':sourceid')
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
