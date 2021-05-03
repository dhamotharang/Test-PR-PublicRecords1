 
EXPORT MAC_PopulationStatistics(infile,Ref='',Input_ln_filedate = '',Input_bk_infile_type = '',Input_rectype = '',Input_documenttype = '',Input_fipscode = '',Input_mersindicator = '',Input_mainaddendum = '',Input_assigrecdate = '',Input_assigeffecdate = '',Input_assigdoc = '',Input_assigbk = '',Input_assigpg = '',Input_multiplepageimage = '',Input_bkfsimageid = '',Input_origdotrecdate = '',Input_origdotcontractdate = '',Input_origdotdoc = '',Input_origdotbk = '',Input_origdotpg = '',Input_origlenderben = '',Input_origloanamnt = '',Input_assignorname = '',Input_loannumber = '',Input_assignee = '',Input_mers = '',Input_mersvalidation = '',Input_assigneepool = '',Input_mspsvcrloan = '',Input_borrowername = '',Input_apn = '',Input_multiapncode = '',Input_taxacctid = '',Input_propertyfulladd = '',Input_propertyunit = '',Input_propertycity = '',Input_propertystate = '',Input_propertyzip = '',Input_propertyzip4 = '',Input_dataentrydate = '',Input_dataentryopercode = '',Input_vendorsourcecode = '',Input_hids_recordingflag = '',Input_hids_docnumber = '',Input_transfercertificateoftitle = '',Input_hi_condo_cpr_hpr = '',Input_hi_situs_unit_number = '',Input_hids_previous_docnumber = '',Input_prevtransfercertificateoftitle = '',Input_pid = '',Input_matchedororphan = '',Input_deed_pid = '',Input_sam_pid = '',Input_assessorparcelnumber_matched = '',Input_assessorpropertyfulladd = '',Input_assessorpropertyunittype = '',Input_assessorpropertyunit = '',Input_assessorpropertycity = '',Input_assessorpropertystate = '',Input_assessorpropertyzip = '',Input_assessorpropertyzip4 = '',Input_assessorpropertyaddrsource = '',Input_raw_file_name = '',OutFile) := MACRO
  IMPORT SALT311,Scrubs_BKMortgage_Assignments;
  #uniquename(of)
  %of% := RECORD
    SALT311.Str512Type fields;
  END;
  #uniquename(ot)
  %of% %ot%(infile le) := TRANSFORM
    SELF.fields :=
    #IF( #TEXT(Input_ln_filedate)='' )
      '' 
    #ELSE
        IF( le.Input_ln_filedate = (TYPEOF(le.Input_ln_filedate))'','',':ln_filedate')
    #END
 
+    #IF( #TEXT(Input_bk_infile_type)='' )
      '' 
    #ELSE
        IF( le.Input_bk_infile_type = (TYPEOF(le.Input_bk_infile_type))'','',':bk_infile_type')
    #END
 
+    #IF( #TEXT(Input_rectype)='' )
      '' 
    #ELSE
        IF( le.Input_rectype = (TYPEOF(le.Input_rectype))'','',':rectype')
    #END
 
+    #IF( #TEXT(Input_documenttype)='' )
      '' 
    #ELSE
        IF( le.Input_documenttype = (TYPEOF(le.Input_documenttype))'','',':documenttype')
    #END
 
+    #IF( #TEXT(Input_fipscode)='' )
      '' 
    #ELSE
        IF( le.Input_fipscode = (TYPEOF(le.Input_fipscode))'','',':fipscode')
    #END
 
+    #IF( #TEXT(Input_mersindicator)='' )
      '' 
    #ELSE
        IF( le.Input_mersindicator = (TYPEOF(le.Input_mersindicator))'','',':mersindicator')
    #END
 
+    #IF( #TEXT(Input_mainaddendum)='' )
      '' 
    #ELSE
        IF( le.Input_mainaddendum = (TYPEOF(le.Input_mainaddendum))'','',':mainaddendum')
    #END
 
+    #IF( #TEXT(Input_assigrecdate)='' )
      '' 
    #ELSE
        IF( le.Input_assigrecdate = (TYPEOF(le.Input_assigrecdate))'','',':assigrecdate')
    #END
 
+    #IF( #TEXT(Input_assigeffecdate)='' )
      '' 
    #ELSE
        IF( le.Input_assigeffecdate = (TYPEOF(le.Input_assigeffecdate))'','',':assigeffecdate')
    #END
 
+    #IF( #TEXT(Input_assigdoc)='' )
      '' 
    #ELSE
        IF( le.Input_assigdoc = (TYPEOF(le.Input_assigdoc))'','',':assigdoc')
    #END
 
+    #IF( #TEXT(Input_assigbk)='' )
      '' 
    #ELSE
        IF( le.Input_assigbk = (TYPEOF(le.Input_assigbk))'','',':assigbk')
    #END
 
+    #IF( #TEXT(Input_assigpg)='' )
      '' 
    #ELSE
        IF( le.Input_assigpg = (TYPEOF(le.Input_assigpg))'','',':assigpg')
    #END
 
+    #IF( #TEXT(Input_multiplepageimage)='' )
      '' 
    #ELSE
        IF( le.Input_multiplepageimage = (TYPEOF(le.Input_multiplepageimage))'','',':multiplepageimage')
    #END
 
+    #IF( #TEXT(Input_bkfsimageid)='' )
      '' 
    #ELSE
        IF( le.Input_bkfsimageid = (TYPEOF(le.Input_bkfsimageid))'','',':bkfsimageid')
    #END
 
+    #IF( #TEXT(Input_origdotrecdate)='' )
      '' 
    #ELSE
        IF( le.Input_origdotrecdate = (TYPEOF(le.Input_origdotrecdate))'','',':origdotrecdate')
    #END
 
+    #IF( #TEXT(Input_origdotcontractdate)='' )
      '' 
    #ELSE
        IF( le.Input_origdotcontractdate = (TYPEOF(le.Input_origdotcontractdate))'','',':origdotcontractdate')
    #END
 
+    #IF( #TEXT(Input_origdotdoc)='' )
      '' 
    #ELSE
        IF( le.Input_origdotdoc = (TYPEOF(le.Input_origdotdoc))'','',':origdotdoc')
    #END
 
+    #IF( #TEXT(Input_origdotbk)='' )
      '' 
    #ELSE
        IF( le.Input_origdotbk = (TYPEOF(le.Input_origdotbk))'','',':origdotbk')
    #END
 
+    #IF( #TEXT(Input_origdotpg)='' )
      '' 
    #ELSE
        IF( le.Input_origdotpg = (TYPEOF(le.Input_origdotpg))'','',':origdotpg')
    #END
 
+    #IF( #TEXT(Input_origlenderben)='' )
      '' 
    #ELSE
        IF( le.Input_origlenderben = (TYPEOF(le.Input_origlenderben))'','',':origlenderben')
    #END
 
+    #IF( #TEXT(Input_origloanamnt)='' )
      '' 
    #ELSE
        IF( le.Input_origloanamnt = (TYPEOF(le.Input_origloanamnt))'','',':origloanamnt')
    #END
 
+    #IF( #TEXT(Input_assignorname)='' )
      '' 
    #ELSE
        IF( le.Input_assignorname = (TYPEOF(le.Input_assignorname))'','',':assignorname')
    #END
 
+    #IF( #TEXT(Input_loannumber)='' )
      '' 
    #ELSE
        IF( le.Input_loannumber = (TYPEOF(le.Input_loannumber))'','',':loannumber')
    #END
 
+    #IF( #TEXT(Input_assignee)='' )
      '' 
    #ELSE
        IF( le.Input_assignee = (TYPEOF(le.Input_assignee))'','',':assignee')
    #END
 
+    #IF( #TEXT(Input_mers)='' )
      '' 
    #ELSE
        IF( le.Input_mers = (TYPEOF(le.Input_mers))'','',':mers')
    #END
 
+    #IF( #TEXT(Input_mersvalidation)='' )
      '' 
    #ELSE
        IF( le.Input_mersvalidation = (TYPEOF(le.Input_mersvalidation))'','',':mersvalidation')
    #END
 
+    #IF( #TEXT(Input_assigneepool)='' )
      '' 
    #ELSE
        IF( le.Input_assigneepool = (TYPEOF(le.Input_assigneepool))'','',':assigneepool')
    #END
 
+    #IF( #TEXT(Input_mspsvcrloan)='' )
      '' 
    #ELSE
        IF( le.Input_mspsvcrloan = (TYPEOF(le.Input_mspsvcrloan))'','',':mspsvcrloan')
    #END
 
+    #IF( #TEXT(Input_borrowername)='' )
      '' 
    #ELSE
        IF( le.Input_borrowername = (TYPEOF(le.Input_borrowername))'','',':borrowername')
    #END
 
+    #IF( #TEXT(Input_apn)='' )
      '' 
    #ELSE
        IF( le.Input_apn = (TYPEOF(le.Input_apn))'','',':apn')
    #END
 
+    #IF( #TEXT(Input_multiapncode)='' )
      '' 
    #ELSE
        IF( le.Input_multiapncode = (TYPEOF(le.Input_multiapncode))'','',':multiapncode')
    #END
 
+    #IF( #TEXT(Input_taxacctid)='' )
      '' 
    #ELSE
        IF( le.Input_taxacctid = (TYPEOF(le.Input_taxacctid))'','',':taxacctid')
    #END
 
+    #IF( #TEXT(Input_propertyfulladd)='' )
      '' 
    #ELSE
        IF( le.Input_propertyfulladd = (TYPEOF(le.Input_propertyfulladd))'','',':propertyfulladd')
    #END
 
+    #IF( #TEXT(Input_propertyunit)='' )
      '' 
    #ELSE
        IF( le.Input_propertyunit = (TYPEOF(le.Input_propertyunit))'','',':propertyunit')
    #END
 
+    #IF( #TEXT(Input_propertycity)='' )
      '' 
    #ELSE
        IF( le.Input_propertycity = (TYPEOF(le.Input_propertycity))'','',':propertycity')
    #END
 
+    #IF( #TEXT(Input_propertystate)='' )
      '' 
    #ELSE
        IF( le.Input_propertystate = (TYPEOF(le.Input_propertystate))'','',':propertystate')
    #END
 
+    #IF( #TEXT(Input_propertyzip)='' )
      '' 
    #ELSE
        IF( le.Input_propertyzip = (TYPEOF(le.Input_propertyzip))'','',':propertyzip')
    #END
 
+    #IF( #TEXT(Input_propertyzip4)='' )
      '' 
    #ELSE
        IF( le.Input_propertyzip4 = (TYPEOF(le.Input_propertyzip4))'','',':propertyzip4')
    #END
 
+    #IF( #TEXT(Input_dataentrydate)='' )
      '' 
    #ELSE
        IF( le.Input_dataentrydate = (TYPEOF(le.Input_dataentrydate))'','',':dataentrydate')
    #END
 
+    #IF( #TEXT(Input_dataentryopercode)='' )
      '' 
    #ELSE
        IF( le.Input_dataentryopercode = (TYPEOF(le.Input_dataentryopercode))'','',':dataentryopercode')
    #END
 
+    #IF( #TEXT(Input_vendorsourcecode)='' )
      '' 
    #ELSE
        IF( le.Input_vendorsourcecode = (TYPEOF(le.Input_vendorsourcecode))'','',':vendorsourcecode')
    #END
 
+    #IF( #TEXT(Input_hids_recordingflag)='' )
      '' 
    #ELSE
        IF( le.Input_hids_recordingflag = (TYPEOF(le.Input_hids_recordingflag))'','',':hids_recordingflag')
    #END
 
+    #IF( #TEXT(Input_hids_docnumber)='' )
      '' 
    #ELSE
        IF( le.Input_hids_docnumber = (TYPEOF(le.Input_hids_docnumber))'','',':hids_docnumber')
    #END
 
+    #IF( #TEXT(Input_transfercertificateoftitle)='' )
      '' 
    #ELSE
        IF( le.Input_transfercertificateoftitle = (TYPEOF(le.Input_transfercertificateoftitle))'','',':transfercertificateoftitle')
    #END
 
+    #IF( #TEXT(Input_hi_condo_cpr_hpr)='' )
      '' 
    #ELSE
        IF( le.Input_hi_condo_cpr_hpr = (TYPEOF(le.Input_hi_condo_cpr_hpr))'','',':hi_condo_cpr_hpr')
    #END
 
+    #IF( #TEXT(Input_hi_situs_unit_number)='' )
      '' 
    #ELSE
        IF( le.Input_hi_situs_unit_number = (TYPEOF(le.Input_hi_situs_unit_number))'','',':hi_situs_unit_number')
    #END
 
+    #IF( #TEXT(Input_hids_previous_docnumber)='' )
      '' 
    #ELSE
        IF( le.Input_hids_previous_docnumber = (TYPEOF(le.Input_hids_previous_docnumber))'','',':hids_previous_docnumber')
    #END
 
+    #IF( #TEXT(Input_prevtransfercertificateoftitle)='' )
      '' 
    #ELSE
        IF( le.Input_prevtransfercertificateoftitle = (TYPEOF(le.Input_prevtransfercertificateoftitle))'','',':prevtransfercertificateoftitle')
    #END
 
+    #IF( #TEXT(Input_pid)='' )
      '' 
    #ELSE
        IF( le.Input_pid = (TYPEOF(le.Input_pid))'','',':pid')
    #END
 
+    #IF( #TEXT(Input_matchedororphan)='' )
      '' 
    #ELSE
        IF( le.Input_matchedororphan = (TYPEOF(le.Input_matchedororphan))'','',':matchedororphan')
    #END
 
+    #IF( #TEXT(Input_deed_pid)='' )
      '' 
    #ELSE
        IF( le.Input_deed_pid = (TYPEOF(le.Input_deed_pid))'','',':deed_pid')
    #END
 
+    #IF( #TEXT(Input_sam_pid)='' )
      '' 
    #ELSE
        IF( le.Input_sam_pid = (TYPEOF(le.Input_sam_pid))'','',':sam_pid')
    #END
 
+    #IF( #TEXT(Input_assessorparcelnumber_matched)='' )
      '' 
    #ELSE
        IF( le.Input_assessorparcelnumber_matched = (TYPEOF(le.Input_assessorparcelnumber_matched))'','',':assessorparcelnumber_matched')
    #END
 
+    #IF( #TEXT(Input_assessorpropertyfulladd)='' )
      '' 
    #ELSE
        IF( le.Input_assessorpropertyfulladd = (TYPEOF(le.Input_assessorpropertyfulladd))'','',':assessorpropertyfulladd')
    #END
 
+    #IF( #TEXT(Input_assessorpropertyunittype)='' )
      '' 
    #ELSE
        IF( le.Input_assessorpropertyunittype = (TYPEOF(le.Input_assessorpropertyunittype))'','',':assessorpropertyunittype')
    #END
 
+    #IF( #TEXT(Input_assessorpropertyunit)='' )
      '' 
    #ELSE
        IF( le.Input_assessorpropertyunit = (TYPEOF(le.Input_assessorpropertyunit))'','',':assessorpropertyunit')
    #END
 
+    #IF( #TEXT(Input_assessorpropertycity)='' )
      '' 
    #ELSE
        IF( le.Input_assessorpropertycity = (TYPEOF(le.Input_assessorpropertycity))'','',':assessorpropertycity')
    #END
 
+    #IF( #TEXT(Input_assessorpropertystate)='' )
      '' 
    #ELSE
        IF( le.Input_assessorpropertystate = (TYPEOF(le.Input_assessorpropertystate))'','',':assessorpropertystate')
    #END
 
+    #IF( #TEXT(Input_assessorpropertyzip)='' )
      '' 
    #ELSE
        IF( le.Input_assessorpropertyzip = (TYPEOF(le.Input_assessorpropertyzip))'','',':assessorpropertyzip')
    #END
 
+    #IF( #TEXT(Input_assessorpropertyzip4)='' )
      '' 
    #ELSE
        IF( le.Input_assessorpropertyzip4 = (TYPEOF(le.Input_assessorpropertyzip4))'','',':assessorpropertyzip4')
    #END
 
+    #IF( #TEXT(Input_assessorpropertyaddrsource)='' )
      '' 
    #ELSE
        IF( le.Input_assessorpropertyaddrsource = (TYPEOF(le.Input_assessorpropertyaddrsource))'','',':assessorpropertyaddrsource')
    #END
 
+    #IF( #TEXT(Input_raw_file_name)='' )
      '' 
    #ELSE
        IF( le.Input_raw_file_name = (TYPEOF(le.Input_raw_file_name))'','',':raw_file_name')
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
