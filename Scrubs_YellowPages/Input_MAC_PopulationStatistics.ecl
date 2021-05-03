 
EXPORT Input_MAC_PopulationStatistics(infile,Ref='',Input_primary_key = '',Input_chainid = '',Input_filler1 = '',Input_pub_date = '',Input_busshortname = '',Input_business_name = '',Input_busdeptname = '',Input_house = '',Input_predir = '',Input_street = '',Input_streettype = '',Input_postdir = '',Input_apttype = '',Input_aptnbr = '',Input_boxnbr = '',Input_exppubcity = '',Input_orig_city = '',Input_orig_state = '',Input_orig_zip = '',Input_dpc = '',Input_carrierroute = '',Input_fips = '',Input_countycode = '',Input_z4type = '',Input_ctract = '',Input_cblockgroup = '',Input_cblockid = '',Input_msa = '',Input_cbsa = '',Input_mcdcode = '',Input_filler2 = '',Input_addrsensitivity = '',Input_maildeliverabilitycode = '',Input_sic1_4 = '',Input_sic_code = '',Input_sic2 = '',Input_sic3 = '',Input_sic4 = '',Input_indstryclass = '',Input_naics_code = '',Input_mlsc = '',Input_filler3 = '',Input_orig_phone10 = '',Input_nosolicitcode = '',Input_dso = '',Input_timezone = '',Input_validationflag = '',Input_validationdate = '',Input_secvalidationcode = '',Input_singleaddrflag = '',Input_filler4 = '',Input_gender = '',Input_execname = '',Input_exectitlecode = '',Input_exectitle = '',Input_condtitlecode = '',Input_condtitle = '',Input_contfunctioncode = '',Input_contfunction = '',Input_profession = '',Input_emplsizecode = '',Input_annualsalescode = '',Input_yrsinbus = '',Input_ethniccode = '',Input_filler5 = '',Input_latlongmatchlevel = '',Input_orig_latitude = '',Input_orig_longitude = '',Input_filler6 = '',Input_heading_string = '',Input_ypheading2 = '',Input_ypheading3 = '',Input_ypheading4 = '',Input_ypheading5 = '',Input_ypheading6 = '',Input_maxypadsize = '',Input_filler7 = '',Input_faxac = '',Input_faxexchge = '',Input_faxphone = '',Input_altac = '',Input_altexchge = '',Input_altphone = '',Input_mobileac = '',Input_mobileexchge = '',Input_mobilephone = '',Input_tollfreeac = '',Input_tollfreeexchge = '',Input_tollfreephone = '',Input_creditcards = '',Input_brands = '',Input_stdhrs = '',Input_hrsopen = '',Input_web_address = '',Input_filler8 = '',Input_email_address = '',Input_services = '',Input_condheading = '',Input_tagline = '',Input_filler9 = '',Input_totaladspend = '',Input_filler10 = '',Input_crlf = '',OutFile) := MACRO
  IMPORT SALT311,Scrubs_YellowPages;
  #uniquename(of)
  %of% := RECORD
    SALT311.Str512Type fields;
  END;
  #uniquename(ot)
  %of% %ot%(infile le) := TRANSFORM
    SELF.fields :=
    #IF( #TEXT(Input_primary_key)='' )
      '' 
    #ELSE
        IF( le.Input_primary_key = (TYPEOF(le.Input_primary_key))'','',':primary_key')
    #END
 
+    #IF( #TEXT(Input_chainid)='' )
      '' 
    #ELSE
        IF( le.Input_chainid = (TYPEOF(le.Input_chainid))'','',':chainid')
    #END
 
+    #IF( #TEXT(Input_filler1)='' )
      '' 
    #ELSE
        IF( le.Input_filler1 = (TYPEOF(le.Input_filler1))'','',':filler1')
    #END
 
+    #IF( #TEXT(Input_pub_date)='' )
      '' 
    #ELSE
        IF( le.Input_pub_date = (TYPEOF(le.Input_pub_date))'','',':pub_date')
    #END
 
+    #IF( #TEXT(Input_busshortname)='' )
      '' 
    #ELSE
        IF( le.Input_busshortname = (TYPEOF(le.Input_busshortname))'','',':busshortname')
    #END
 
+    #IF( #TEXT(Input_business_name)='' )
      '' 
    #ELSE
        IF( le.Input_business_name = (TYPEOF(le.Input_business_name))'','',':business_name')
    #END
 
+    #IF( #TEXT(Input_busdeptname)='' )
      '' 
    #ELSE
        IF( le.Input_busdeptname = (TYPEOF(le.Input_busdeptname))'','',':busdeptname')
    #END
 
+    #IF( #TEXT(Input_house)='' )
      '' 
    #ELSE
        IF( le.Input_house = (TYPEOF(le.Input_house))'','',':house')
    #END
 
+    #IF( #TEXT(Input_predir)='' )
      '' 
    #ELSE
        IF( le.Input_predir = (TYPEOF(le.Input_predir))'','',':predir')
    #END
 
+    #IF( #TEXT(Input_street)='' )
      '' 
    #ELSE
        IF( le.Input_street = (TYPEOF(le.Input_street))'','',':street')
    #END
 
+    #IF( #TEXT(Input_streettype)='' )
      '' 
    #ELSE
        IF( le.Input_streettype = (TYPEOF(le.Input_streettype))'','',':streettype')
    #END
 
+    #IF( #TEXT(Input_postdir)='' )
      '' 
    #ELSE
        IF( le.Input_postdir = (TYPEOF(le.Input_postdir))'','',':postdir')
    #END
 
+    #IF( #TEXT(Input_apttype)='' )
      '' 
    #ELSE
        IF( le.Input_apttype = (TYPEOF(le.Input_apttype))'','',':apttype')
    #END
 
+    #IF( #TEXT(Input_aptnbr)='' )
      '' 
    #ELSE
        IF( le.Input_aptnbr = (TYPEOF(le.Input_aptnbr))'','',':aptnbr')
    #END
 
+    #IF( #TEXT(Input_boxnbr)='' )
      '' 
    #ELSE
        IF( le.Input_boxnbr = (TYPEOF(le.Input_boxnbr))'','',':boxnbr')
    #END
 
+    #IF( #TEXT(Input_exppubcity)='' )
      '' 
    #ELSE
        IF( le.Input_exppubcity = (TYPEOF(le.Input_exppubcity))'','',':exppubcity')
    #END
 
+    #IF( #TEXT(Input_orig_city)='' )
      '' 
    #ELSE
        IF( le.Input_orig_city = (TYPEOF(le.Input_orig_city))'','',':orig_city')
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
 
+    #IF( #TEXT(Input_dpc)='' )
      '' 
    #ELSE
        IF( le.Input_dpc = (TYPEOF(le.Input_dpc))'','',':dpc')
    #END
 
+    #IF( #TEXT(Input_carrierroute)='' )
      '' 
    #ELSE
        IF( le.Input_carrierroute = (TYPEOF(le.Input_carrierroute))'','',':carrierroute')
    #END
 
+    #IF( #TEXT(Input_fips)='' )
      '' 
    #ELSE
        IF( le.Input_fips = (TYPEOF(le.Input_fips))'','',':fips')
    #END
 
+    #IF( #TEXT(Input_countycode)='' )
      '' 
    #ELSE
        IF( le.Input_countycode = (TYPEOF(le.Input_countycode))'','',':countycode')
    #END
 
+    #IF( #TEXT(Input_z4type)='' )
      '' 
    #ELSE
        IF( le.Input_z4type = (TYPEOF(le.Input_z4type))'','',':z4type')
    #END
 
+    #IF( #TEXT(Input_ctract)='' )
      '' 
    #ELSE
        IF( le.Input_ctract = (TYPEOF(le.Input_ctract))'','',':ctract')
    #END
 
+    #IF( #TEXT(Input_cblockgroup)='' )
      '' 
    #ELSE
        IF( le.Input_cblockgroup = (TYPEOF(le.Input_cblockgroup))'','',':cblockgroup')
    #END
 
+    #IF( #TEXT(Input_cblockid)='' )
      '' 
    #ELSE
        IF( le.Input_cblockid = (TYPEOF(le.Input_cblockid))'','',':cblockid')
    #END
 
+    #IF( #TEXT(Input_msa)='' )
      '' 
    #ELSE
        IF( le.Input_msa = (TYPEOF(le.Input_msa))'','',':msa')
    #END
 
+    #IF( #TEXT(Input_cbsa)='' )
      '' 
    #ELSE
        IF( le.Input_cbsa = (TYPEOF(le.Input_cbsa))'','',':cbsa')
    #END
 
+    #IF( #TEXT(Input_mcdcode)='' )
      '' 
    #ELSE
        IF( le.Input_mcdcode = (TYPEOF(le.Input_mcdcode))'','',':mcdcode')
    #END
 
+    #IF( #TEXT(Input_filler2)='' )
      '' 
    #ELSE
        IF( le.Input_filler2 = (TYPEOF(le.Input_filler2))'','',':filler2')
    #END
 
+    #IF( #TEXT(Input_addrsensitivity)='' )
      '' 
    #ELSE
        IF( le.Input_addrsensitivity = (TYPEOF(le.Input_addrsensitivity))'','',':addrsensitivity')
    #END
 
+    #IF( #TEXT(Input_maildeliverabilitycode)='' )
      '' 
    #ELSE
        IF( le.Input_maildeliverabilitycode = (TYPEOF(le.Input_maildeliverabilitycode))'','',':maildeliverabilitycode')
    #END
 
+    #IF( #TEXT(Input_sic1_4)='' )
      '' 
    #ELSE
        IF( le.Input_sic1_4 = (TYPEOF(le.Input_sic1_4))'','',':sic1_4')
    #END
 
+    #IF( #TEXT(Input_sic_code)='' )
      '' 
    #ELSE
        IF( le.Input_sic_code = (TYPEOF(le.Input_sic_code))'','',':sic_code')
    #END
 
+    #IF( #TEXT(Input_sic2)='' )
      '' 
    #ELSE
        IF( le.Input_sic2 = (TYPEOF(le.Input_sic2))'','',':sic2')
    #END
 
+    #IF( #TEXT(Input_sic3)='' )
      '' 
    #ELSE
        IF( le.Input_sic3 = (TYPEOF(le.Input_sic3))'','',':sic3')
    #END
 
+    #IF( #TEXT(Input_sic4)='' )
      '' 
    #ELSE
        IF( le.Input_sic4 = (TYPEOF(le.Input_sic4))'','',':sic4')
    #END
 
+    #IF( #TEXT(Input_indstryclass)='' )
      '' 
    #ELSE
        IF( le.Input_indstryclass = (TYPEOF(le.Input_indstryclass))'','',':indstryclass')
    #END
 
+    #IF( #TEXT(Input_naics_code)='' )
      '' 
    #ELSE
        IF( le.Input_naics_code = (TYPEOF(le.Input_naics_code))'','',':naics_code')
    #END
 
+    #IF( #TEXT(Input_mlsc)='' )
      '' 
    #ELSE
        IF( le.Input_mlsc = (TYPEOF(le.Input_mlsc))'','',':mlsc')
    #END
 
+    #IF( #TEXT(Input_filler3)='' )
      '' 
    #ELSE
        IF( le.Input_filler3 = (TYPEOF(le.Input_filler3))'','',':filler3')
    #END
 
+    #IF( #TEXT(Input_orig_phone10)='' )
      '' 
    #ELSE
        IF( le.Input_orig_phone10 = (TYPEOF(le.Input_orig_phone10))'','',':orig_phone10')
    #END
 
+    #IF( #TEXT(Input_nosolicitcode)='' )
      '' 
    #ELSE
        IF( le.Input_nosolicitcode = (TYPEOF(le.Input_nosolicitcode))'','',':nosolicitcode')
    #END
 
+    #IF( #TEXT(Input_dso)='' )
      '' 
    #ELSE
        IF( le.Input_dso = (TYPEOF(le.Input_dso))'','',':dso')
    #END
 
+    #IF( #TEXT(Input_timezone)='' )
      '' 
    #ELSE
        IF( le.Input_timezone = (TYPEOF(le.Input_timezone))'','',':timezone')
    #END
 
+    #IF( #TEXT(Input_validationflag)='' )
      '' 
    #ELSE
        IF( le.Input_validationflag = (TYPEOF(le.Input_validationflag))'','',':validationflag')
    #END
 
+    #IF( #TEXT(Input_validationdate)='' )
      '' 
    #ELSE
        IF( le.Input_validationdate = (TYPEOF(le.Input_validationdate))'','',':validationdate')
    #END
 
+    #IF( #TEXT(Input_secvalidationcode)='' )
      '' 
    #ELSE
        IF( le.Input_secvalidationcode = (TYPEOF(le.Input_secvalidationcode))'','',':secvalidationcode')
    #END
 
+    #IF( #TEXT(Input_singleaddrflag)='' )
      '' 
    #ELSE
        IF( le.Input_singleaddrflag = (TYPEOF(le.Input_singleaddrflag))'','',':singleaddrflag')
    #END
 
+    #IF( #TEXT(Input_filler4)='' )
      '' 
    #ELSE
        IF( le.Input_filler4 = (TYPEOF(le.Input_filler4))'','',':filler4')
    #END
 
+    #IF( #TEXT(Input_gender)='' )
      '' 
    #ELSE
        IF( le.Input_gender = (TYPEOF(le.Input_gender))'','',':gender')
    #END
 
+    #IF( #TEXT(Input_execname)='' )
      '' 
    #ELSE
        IF( le.Input_execname = (TYPEOF(le.Input_execname))'','',':execname')
    #END
 
+    #IF( #TEXT(Input_exectitlecode)='' )
      '' 
    #ELSE
        IF( le.Input_exectitlecode = (TYPEOF(le.Input_exectitlecode))'','',':exectitlecode')
    #END
 
+    #IF( #TEXT(Input_exectitle)='' )
      '' 
    #ELSE
        IF( le.Input_exectitle = (TYPEOF(le.Input_exectitle))'','',':exectitle')
    #END
 
+    #IF( #TEXT(Input_condtitlecode)='' )
      '' 
    #ELSE
        IF( le.Input_condtitlecode = (TYPEOF(le.Input_condtitlecode))'','',':condtitlecode')
    #END
 
+    #IF( #TEXT(Input_condtitle)='' )
      '' 
    #ELSE
        IF( le.Input_condtitle = (TYPEOF(le.Input_condtitle))'','',':condtitle')
    #END
 
+    #IF( #TEXT(Input_contfunctioncode)='' )
      '' 
    #ELSE
        IF( le.Input_contfunctioncode = (TYPEOF(le.Input_contfunctioncode))'','',':contfunctioncode')
    #END
 
+    #IF( #TEXT(Input_contfunction)='' )
      '' 
    #ELSE
        IF( le.Input_contfunction = (TYPEOF(le.Input_contfunction))'','',':contfunction')
    #END
 
+    #IF( #TEXT(Input_profession)='' )
      '' 
    #ELSE
        IF( le.Input_profession = (TYPEOF(le.Input_profession))'','',':profession')
    #END
 
+    #IF( #TEXT(Input_emplsizecode)='' )
      '' 
    #ELSE
        IF( le.Input_emplsizecode = (TYPEOF(le.Input_emplsizecode))'','',':emplsizecode')
    #END
 
+    #IF( #TEXT(Input_annualsalescode)='' )
      '' 
    #ELSE
        IF( le.Input_annualsalescode = (TYPEOF(le.Input_annualsalescode))'','',':annualsalescode')
    #END
 
+    #IF( #TEXT(Input_yrsinbus)='' )
      '' 
    #ELSE
        IF( le.Input_yrsinbus = (TYPEOF(le.Input_yrsinbus))'','',':yrsinbus')
    #END
 
+    #IF( #TEXT(Input_ethniccode)='' )
      '' 
    #ELSE
        IF( le.Input_ethniccode = (TYPEOF(le.Input_ethniccode))'','',':ethniccode')
    #END
 
+    #IF( #TEXT(Input_filler5)='' )
      '' 
    #ELSE
        IF( le.Input_filler5 = (TYPEOF(le.Input_filler5))'','',':filler5')
    #END
 
+    #IF( #TEXT(Input_latlongmatchlevel)='' )
      '' 
    #ELSE
        IF( le.Input_latlongmatchlevel = (TYPEOF(le.Input_latlongmatchlevel))'','',':latlongmatchlevel')
    #END
 
+    #IF( #TEXT(Input_orig_latitude)='' )
      '' 
    #ELSE
        IF( le.Input_orig_latitude = (TYPEOF(le.Input_orig_latitude))'','',':orig_latitude')
    #END
 
+    #IF( #TEXT(Input_orig_longitude)='' )
      '' 
    #ELSE
        IF( le.Input_orig_longitude = (TYPEOF(le.Input_orig_longitude))'','',':orig_longitude')
    #END
 
+    #IF( #TEXT(Input_filler6)='' )
      '' 
    #ELSE
        IF( le.Input_filler6 = (TYPEOF(le.Input_filler6))'','',':filler6')
    #END
 
+    #IF( #TEXT(Input_heading_string)='' )
      '' 
    #ELSE
        IF( le.Input_heading_string = (TYPEOF(le.Input_heading_string))'','',':heading_string')
    #END
 
+    #IF( #TEXT(Input_ypheading2)='' )
      '' 
    #ELSE
        IF( le.Input_ypheading2 = (TYPEOF(le.Input_ypheading2))'','',':ypheading2')
    #END
 
+    #IF( #TEXT(Input_ypheading3)='' )
      '' 
    #ELSE
        IF( le.Input_ypheading3 = (TYPEOF(le.Input_ypheading3))'','',':ypheading3')
    #END
 
+    #IF( #TEXT(Input_ypheading4)='' )
      '' 
    #ELSE
        IF( le.Input_ypheading4 = (TYPEOF(le.Input_ypheading4))'','',':ypheading4')
    #END
 
+    #IF( #TEXT(Input_ypheading5)='' )
      '' 
    #ELSE
        IF( le.Input_ypheading5 = (TYPEOF(le.Input_ypheading5))'','',':ypheading5')
    #END
 
+    #IF( #TEXT(Input_ypheading6)='' )
      '' 
    #ELSE
        IF( le.Input_ypheading6 = (TYPEOF(le.Input_ypheading6))'','',':ypheading6')
    #END
 
+    #IF( #TEXT(Input_maxypadsize)='' )
      '' 
    #ELSE
        IF( le.Input_maxypadsize = (TYPEOF(le.Input_maxypadsize))'','',':maxypadsize')
    #END
 
+    #IF( #TEXT(Input_filler7)='' )
      '' 
    #ELSE
        IF( le.Input_filler7 = (TYPEOF(le.Input_filler7))'','',':filler7')
    #END
 
+    #IF( #TEXT(Input_faxac)='' )
      '' 
    #ELSE
        IF( le.Input_faxac = (TYPEOF(le.Input_faxac))'','',':faxac')
    #END
 
+    #IF( #TEXT(Input_faxexchge)='' )
      '' 
    #ELSE
        IF( le.Input_faxexchge = (TYPEOF(le.Input_faxexchge))'','',':faxexchge')
    #END
 
+    #IF( #TEXT(Input_faxphone)='' )
      '' 
    #ELSE
        IF( le.Input_faxphone = (TYPEOF(le.Input_faxphone))'','',':faxphone')
    #END
 
+    #IF( #TEXT(Input_altac)='' )
      '' 
    #ELSE
        IF( le.Input_altac = (TYPEOF(le.Input_altac))'','',':altac')
    #END
 
+    #IF( #TEXT(Input_altexchge)='' )
      '' 
    #ELSE
        IF( le.Input_altexchge = (TYPEOF(le.Input_altexchge))'','',':altexchge')
    #END
 
+    #IF( #TEXT(Input_altphone)='' )
      '' 
    #ELSE
        IF( le.Input_altphone = (TYPEOF(le.Input_altphone))'','',':altphone')
    #END
 
+    #IF( #TEXT(Input_mobileac)='' )
      '' 
    #ELSE
        IF( le.Input_mobileac = (TYPEOF(le.Input_mobileac))'','',':mobileac')
    #END
 
+    #IF( #TEXT(Input_mobileexchge)='' )
      '' 
    #ELSE
        IF( le.Input_mobileexchge = (TYPEOF(le.Input_mobileexchge))'','',':mobileexchge')
    #END
 
+    #IF( #TEXT(Input_mobilephone)='' )
      '' 
    #ELSE
        IF( le.Input_mobilephone = (TYPEOF(le.Input_mobilephone))'','',':mobilephone')
    #END
 
+    #IF( #TEXT(Input_tollfreeac)='' )
      '' 
    #ELSE
        IF( le.Input_tollfreeac = (TYPEOF(le.Input_tollfreeac))'','',':tollfreeac')
    #END
 
+    #IF( #TEXT(Input_tollfreeexchge)='' )
      '' 
    #ELSE
        IF( le.Input_tollfreeexchge = (TYPEOF(le.Input_tollfreeexchge))'','',':tollfreeexchge')
    #END
 
+    #IF( #TEXT(Input_tollfreephone)='' )
      '' 
    #ELSE
        IF( le.Input_tollfreephone = (TYPEOF(le.Input_tollfreephone))'','',':tollfreephone')
    #END
 
+    #IF( #TEXT(Input_creditcards)='' )
      '' 
    #ELSE
        IF( le.Input_creditcards = (TYPEOF(le.Input_creditcards))'','',':creditcards')
    #END
 
+    #IF( #TEXT(Input_brands)='' )
      '' 
    #ELSE
        IF( le.Input_brands = (TYPEOF(le.Input_brands))'','',':brands')
    #END
 
+    #IF( #TEXT(Input_stdhrs)='' )
      '' 
    #ELSE
        IF( le.Input_stdhrs = (TYPEOF(le.Input_stdhrs))'','',':stdhrs')
    #END
 
+    #IF( #TEXT(Input_hrsopen)='' )
      '' 
    #ELSE
        IF( le.Input_hrsopen = (TYPEOF(le.Input_hrsopen))'','',':hrsopen')
    #END
 
+    #IF( #TEXT(Input_web_address)='' )
      '' 
    #ELSE
        IF( le.Input_web_address = (TYPEOF(le.Input_web_address))'','',':web_address')
    #END
 
+    #IF( #TEXT(Input_filler8)='' )
      '' 
    #ELSE
        IF( le.Input_filler8 = (TYPEOF(le.Input_filler8))'','',':filler8')
    #END
 
+    #IF( #TEXT(Input_email_address)='' )
      '' 
    #ELSE
        IF( le.Input_email_address = (TYPEOF(le.Input_email_address))'','',':email_address')
    #END
 
+    #IF( #TEXT(Input_services)='' )
      '' 
    #ELSE
        IF( le.Input_services = (TYPEOF(le.Input_services))'','',':services')
    #END
 
+    #IF( #TEXT(Input_condheading)='' )
      '' 
    #ELSE
        IF( le.Input_condheading = (TYPEOF(le.Input_condheading))'','',':condheading')
    #END
 
+    #IF( #TEXT(Input_tagline)='' )
      '' 
    #ELSE
        IF( le.Input_tagline = (TYPEOF(le.Input_tagline))'','',':tagline')
    #END
 
+    #IF( #TEXT(Input_filler9)='' )
      '' 
    #ELSE
        IF( le.Input_filler9 = (TYPEOF(le.Input_filler9))'','',':filler9')
    #END
 
+    #IF( #TEXT(Input_totaladspend)='' )
      '' 
    #ELSE
        IF( le.Input_totaladspend = (TYPEOF(le.Input_totaladspend))'','',':totaladspend')
    #END
 
+    #IF( #TEXT(Input_filler10)='' )
      '' 
    #ELSE
        IF( le.Input_filler10 = (TYPEOF(le.Input_filler10))'','',':filler10')
    #END
 
+    #IF( #TEXT(Input_crlf)='' )
      '' 
    #ELSE
        IF( le.Input_crlf = (TYPEOF(le.Input_crlf))'','',':crlf')
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
