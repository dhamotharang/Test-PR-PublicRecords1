 
EXPORT raw_MAC_PopulationStatistics(infile,Ref='',Input_recordid = '',Input_sourcename = '',Input_sourcetype = '',Input_statecode = '',Input_recordtype = '',Input_recorduploaddate = '',Input_docnumber = '',Input_fbinumber = '',Input_stateidnumber = '',Input_inmatenumber = '',Input_aliennumber = '',Input_orig_ssn = '',Input_nametype = '',Input_name = '',Input_lastname = '',Input_firstname = '',Input_middlename = '',Input_suffix = '',Input_defendantstatus = '',Input_defendantadditionalinfo = '',Input_dob = '',Input_birthcity = '',Input_birthplace = '',Input_age = '',Input_gender = '',Input_height = '',Input_weight = '',Input_haircolor = '',Input_eyecolor = '',Input_race = '',Input_ethnicity = '',Input_skincolor = '',Input_bodymarks = '',Input_physicalbuild = '',Input_photoname = '',Input_dlnumber = '',Input_dlstate = '',Input_phone = '',Input_phonetype = '',Input_uscitizenflag = '',Input_addresstype = '',Input_street = '',Input_unit = '',Input_city = '',Input_orig_state = '',Input_orig_zip = '',Input_county = '',Input_institutionname = '',Input_institutiondetails = '',Input_institutionreceiptdate = '',Input_releasetolocation = '',Input_releasetodetails = '',Input_deceasedflag = '',Input_deceaseddate = '',Input_healthflag = '',Input_healthdesc = '',Input_bloodtype = '',Input_sexoffenderregistrydate = '',Input_sexoffenderregexpirationdate = '',Input_sexoffenderregistrynumber = '',Input_sourceid = '',Input_caseid = '',Input_casenumber = '',Input_casetitle = '',Input_casetype = '',Input_casestatus = '',Input_casestatusdate = '',Input_casecomments = '',Input_fileddate = '',Input_caseinfo = '',Input_docketnumber = '',Input_offensecode = '',Input_offensedesc = '',Input_offensedate = '',Input_offensetype = '',Input_offensedegree = '',Input_offenseclass = '',Input_dispositionstatus = '',Input_dispositionstatusdate = '',Input_disposition = '',Input_dispositiondate = '',Input_offenselocation = '',Input_finaloffense = '',Input_finaloffensedate = '',Input_offensecount = '',Input_victimunder18 = '',Input_prioroffenseflag = '',Input_initialplea = '',Input_initialpleadate = '',Input_finalruling = '',Input_finalrulingdate = '',Input_appealstatus = '',Input_appealdate = '',Input_courtname = '',Input_fineamount = '',Input_courtfee = '',Input_restitution = '',Input_trialtype = '',Input_courtdate = '',Input_classification_code = '',Input_sub_classification_code = '',Input_state = '',Input_zip = '',Input_sourceid2 = '',Input_sentencedate = '',Input_sentencebegindate = '',Input_sentenceenddate = '',Input_sentencetype = '',Input_sentencemaxyears = '',Input_sentencemaxmonths = '',Input_sentencemaxdays = '',Input_sentenceminyears = '',Input_sentenceminmonths = '',Input_sentencemindays = '',Input_scheduledreleasedate = '',Input_actualreleasedate = '',Input_sentencestatus = '',Input_timeservedyears = '',Input_timeservedmonths = '',Input_timeserveddays = '',Input_publicservicehours = '',Input_sentenceadditionalinfo = '',Input_communitysupervisioncounty = '',Input_communitysupervisionyears = '',Input_communitysupervisionmonths = '',Input_communitysupervisiondays = '',Input_parolebegindate = '',Input_paroleenddate = '',Input_paroleeligibilitydate = '',Input_parolehearingdate = '',Input_parolemaxyears = '',Input_parolemaxmonths = '',Input_parolemaxdays = '',Input_paroleminyears = '',Input_paroleminmonths = '',Input_parolemindays = '',Input_parolestatus = '',Input_paroleofficer = '',Input_paroleoffcerphone = '',Input_probationbegindate = '',Input_probationenddate = '',Input_probationmaxyears = '',Input_probationmaxmonths = '',Input_probationmaxdays = '',Input_probationminyears = '',Input_probationminmonths = '',Input_probationmindays = '',Input_probationstatus = '',OutFile) := MACRO
  IMPORT SALT311,scrubs_Fed_Bureau_Prisons;
  #uniquename(of)
  %of% := RECORD
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
 
+    #IF( #TEXT(Input_caseid)='' )
      '' 
    #ELSE
        IF( le.Input_caseid = (TYPEOF(le.Input_caseid))'','',':caseid')
    #END
 
+    #IF( #TEXT(Input_casenumber)='' )
      '' 
    #ELSE
        IF( le.Input_casenumber = (TYPEOF(le.Input_casenumber))'','',':casenumber')
    #END
 
+    #IF( #TEXT(Input_casetitle)='' )
      '' 
    #ELSE
        IF( le.Input_casetitle = (TYPEOF(le.Input_casetitle))'','',':casetitle')
    #END
 
+    #IF( #TEXT(Input_casetype)='' )
      '' 
    #ELSE
        IF( le.Input_casetype = (TYPEOF(le.Input_casetype))'','',':casetype')
    #END
 
+    #IF( #TEXT(Input_casestatus)='' )
      '' 
    #ELSE
        IF( le.Input_casestatus = (TYPEOF(le.Input_casestatus))'','',':casestatus')
    #END
 
+    #IF( #TEXT(Input_casestatusdate)='' )
      '' 
    #ELSE
        IF( le.Input_casestatusdate = (TYPEOF(le.Input_casestatusdate))'','',':casestatusdate')
    #END
 
+    #IF( #TEXT(Input_casecomments)='' )
      '' 
    #ELSE
        IF( le.Input_casecomments = (TYPEOF(le.Input_casecomments))'','',':casecomments')
    #END
 
+    #IF( #TEXT(Input_fileddate)='' )
      '' 
    #ELSE
        IF( le.Input_fileddate = (TYPEOF(le.Input_fileddate))'','',':fileddate')
    #END
 
+    #IF( #TEXT(Input_caseinfo)='' )
      '' 
    #ELSE
        IF( le.Input_caseinfo = (TYPEOF(le.Input_caseinfo))'','',':caseinfo')
    #END
 
+    #IF( #TEXT(Input_docketnumber)='' )
      '' 
    #ELSE
        IF( le.Input_docketnumber = (TYPEOF(le.Input_docketnumber))'','',':docketnumber')
    #END
 
+    #IF( #TEXT(Input_offensecode)='' )
      '' 
    #ELSE
        IF( le.Input_offensecode = (TYPEOF(le.Input_offensecode))'','',':offensecode')
    #END
 
+    #IF( #TEXT(Input_offensedesc)='' )
      '' 
    #ELSE
        IF( le.Input_offensedesc = (TYPEOF(le.Input_offensedesc))'','',':offensedesc')
    #END
 
+    #IF( #TEXT(Input_offensedate)='' )
      '' 
    #ELSE
        IF( le.Input_offensedate = (TYPEOF(le.Input_offensedate))'','',':offensedate')
    #END
 
+    #IF( #TEXT(Input_offensetype)='' )
      '' 
    #ELSE
        IF( le.Input_offensetype = (TYPEOF(le.Input_offensetype))'','',':offensetype')
    #END
 
+    #IF( #TEXT(Input_offensedegree)='' )
      '' 
    #ELSE
        IF( le.Input_offensedegree = (TYPEOF(le.Input_offensedegree))'','',':offensedegree')
    #END
 
+    #IF( #TEXT(Input_offenseclass)='' )
      '' 
    #ELSE
        IF( le.Input_offenseclass = (TYPEOF(le.Input_offenseclass))'','',':offenseclass')
    #END
 
+    #IF( #TEXT(Input_dispositionstatus)='' )
      '' 
    #ELSE
        IF( le.Input_dispositionstatus = (TYPEOF(le.Input_dispositionstatus))'','',':dispositionstatus')
    #END
 
+    #IF( #TEXT(Input_dispositionstatusdate)='' )
      '' 
    #ELSE
        IF( le.Input_dispositionstatusdate = (TYPEOF(le.Input_dispositionstatusdate))'','',':dispositionstatusdate')
    #END
 
+    #IF( #TEXT(Input_disposition)='' )
      '' 
    #ELSE
        IF( le.Input_disposition = (TYPEOF(le.Input_disposition))'','',':disposition')
    #END
 
+    #IF( #TEXT(Input_dispositiondate)='' )
      '' 
    #ELSE
        IF( le.Input_dispositiondate = (TYPEOF(le.Input_dispositiondate))'','',':dispositiondate')
    #END
 
+    #IF( #TEXT(Input_offenselocation)='' )
      '' 
    #ELSE
        IF( le.Input_offenselocation = (TYPEOF(le.Input_offenselocation))'','',':offenselocation')
    #END
 
+    #IF( #TEXT(Input_finaloffense)='' )
      '' 
    #ELSE
        IF( le.Input_finaloffense = (TYPEOF(le.Input_finaloffense))'','',':finaloffense')
    #END
 
+    #IF( #TEXT(Input_finaloffensedate)='' )
      '' 
    #ELSE
        IF( le.Input_finaloffensedate = (TYPEOF(le.Input_finaloffensedate))'','',':finaloffensedate')
    #END
 
+    #IF( #TEXT(Input_offensecount)='' )
      '' 
    #ELSE
        IF( le.Input_offensecount = (TYPEOF(le.Input_offensecount))'','',':offensecount')
    #END
 
+    #IF( #TEXT(Input_victimunder18)='' )
      '' 
    #ELSE
        IF( le.Input_victimunder18 = (TYPEOF(le.Input_victimunder18))'','',':victimunder18')
    #END
 
+    #IF( #TEXT(Input_prioroffenseflag)='' )
      '' 
    #ELSE
        IF( le.Input_prioroffenseflag = (TYPEOF(le.Input_prioroffenseflag))'','',':prioroffenseflag')
    #END
 
+    #IF( #TEXT(Input_initialplea)='' )
      '' 
    #ELSE
        IF( le.Input_initialplea = (TYPEOF(le.Input_initialplea))'','',':initialplea')
    #END
 
+    #IF( #TEXT(Input_initialpleadate)='' )
      '' 
    #ELSE
        IF( le.Input_initialpleadate = (TYPEOF(le.Input_initialpleadate))'','',':initialpleadate')
    #END
 
+    #IF( #TEXT(Input_finalruling)='' )
      '' 
    #ELSE
        IF( le.Input_finalruling = (TYPEOF(le.Input_finalruling))'','',':finalruling')
    #END
 
+    #IF( #TEXT(Input_finalrulingdate)='' )
      '' 
    #ELSE
        IF( le.Input_finalrulingdate = (TYPEOF(le.Input_finalrulingdate))'','',':finalrulingdate')
    #END
 
+    #IF( #TEXT(Input_appealstatus)='' )
      '' 
    #ELSE
        IF( le.Input_appealstatus = (TYPEOF(le.Input_appealstatus))'','',':appealstatus')
    #END
 
+    #IF( #TEXT(Input_appealdate)='' )
      '' 
    #ELSE
        IF( le.Input_appealdate = (TYPEOF(le.Input_appealdate))'','',':appealdate')
    #END
 
+    #IF( #TEXT(Input_courtname)='' )
      '' 
    #ELSE
        IF( le.Input_courtname = (TYPEOF(le.Input_courtname))'','',':courtname')
    #END
 
+    #IF( #TEXT(Input_fineamount)='' )
      '' 
    #ELSE
        IF( le.Input_fineamount = (TYPEOF(le.Input_fineamount))'','',':fineamount')
    #END
 
+    #IF( #TEXT(Input_courtfee)='' )
      '' 
    #ELSE
        IF( le.Input_courtfee = (TYPEOF(le.Input_courtfee))'','',':courtfee')
    #END
 
+    #IF( #TEXT(Input_restitution)='' )
      '' 
    #ELSE
        IF( le.Input_restitution = (TYPEOF(le.Input_restitution))'','',':restitution')
    #END
 
+    #IF( #TEXT(Input_trialtype)='' )
      '' 
    #ELSE
        IF( le.Input_trialtype = (TYPEOF(le.Input_trialtype))'','',':trialtype')
    #END
 
+    #IF( #TEXT(Input_courtdate)='' )
      '' 
    #ELSE
        IF( le.Input_courtdate = (TYPEOF(le.Input_courtdate))'','',':courtdate')
    #END
 
+    #IF( #TEXT(Input_classification_code)='' )
      '' 
    #ELSE
        IF( le.Input_classification_code = (TYPEOF(le.Input_classification_code))'','',':classification_code')
    #END
 
+    #IF( #TEXT(Input_sub_classification_code)='' )
      '' 
    #ELSE
        IF( le.Input_sub_classification_code = (TYPEOF(le.Input_sub_classification_code))'','',':sub_classification_code')
    #END
 
+    #IF( #TEXT(Input_state)='' )
      '' 
    #ELSE
        IF( le.Input_state = (TYPEOF(le.Input_state))'','',':state')
    #END
 
+    #IF( #TEXT(Input_zip)='' )
      '' 
    #ELSE
        IF( le.Input_zip = (TYPEOF(le.Input_zip))'','',':zip')
    #END
 
+    #IF( #TEXT(Input_sourceid2)='' )
      '' 
    #ELSE
        IF( le.Input_sourceid2 = (TYPEOF(le.Input_sourceid2))'','',':sourceid2')
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
