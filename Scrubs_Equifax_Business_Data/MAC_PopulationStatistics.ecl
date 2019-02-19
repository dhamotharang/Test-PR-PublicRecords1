 
EXPORT MAC_PopulationStatistics(infile,Ref='',Input_dotid = '',Input_dotscore = '',Input_dotweight = '',Input_empid = '',Input_empscore = '',Input_empweight = '',Input_powid = '',Input_powscore = '',Input_powweight = '',Input_proxid = '',Input_proxscore = '',Input_proxweight = '',Input_seleid = '',Input_selescore = '',Input_seleweight = '',Input_orgid = '',Input_orgscore = '',Input_orgweight = '',Input_ultid = '',Input_ultscore = '',Input_ultweight = '',Input_dt_first_seen = '',Input_dt_last_seen = '',Input_dt_vendor_first_reported = '',Input_dt_vendor_last_reported = '',Input_process_date = '',Input_record_type = '',Input_normcompany_type = '',Input_normaddress_type = '',Input_norm_state = '',Input_norm_zip = '',Input_norm_zip4 = '',Input_EFX_NAME = '',Input_EFX_LEGAL_NAME = '',Input_EFX_ADDRESS = '',Input_clean_company_name = '',Input_clean_phone = '',Input_prim_range = '',Input_predir = '',Input_addr_suffix = '',Input_postdir = '',Input_unit_desig = '',Input_sec_range = '',Input_st = '',Input_zip = '',Input_zip4 = '',Input_cr_sort_sz = '',Input_lot_order = '',Input_rec_type = '',Input_fips_state = '',Input_geo_lat = '',Input_geo_long = '',Input_geo_match = '',Input_err_stat = '',Input_raw_aid = '',Input_ace_aid = '',Input_EFX_BUSSTATCD = '',Input_EFX_CMSA = '',Input_EFX_CORPAMOUNTCD = '',Input_EFX_CORPAMOUNTPREC = '',Input_EFX_CORPAMOUNTTP = '',Input_EFX_CORPEMPCD = '',Input_EFX_WEB = '',Input_EFX_CTRYISOCD = '',Input_EFX_CTRYNUM = '',Input_EFX_CTRYTELCD = '',Input_EFX_GEOPREC = '',Input_EFX_MERCTYPE = '',Input_EFX_MRKT_TELESCORE = '',Input_EFX_MRKT_TOTALIND = '',Input_EFX_MRKT_TOTALSCORE = '',Input_EFX_PUBLIC = '',Input_EFX_STKEXC = '',Input_EFX_PRIMSIC = '',Input_EFX_SECSIC1 = '',Input_EFX_SECSIC2 = '',Input_EFX_SECSIC3 = '',Input_EFX_SECSIC4 = '',Input_EFX_ID = '',Input_EFX_CITY = '',Input_EFX_REGION = '',Input_EFX_CTRYNAME = '',Input_EFX_COUNTYNM = '',Input_EFX_CMSADESC = '',Input_EFX_SOHO = '',Input_EFX_BIZ = '',Input_EFX_RES = '',Input_EFX_CMRA = '',Input_EFX_SECADR = '',Input_EFX_SECCTY = '',Input_EFX_SECGEOPREC = '',Input_EFX_SECREGION = '',Input_EFX_SECCTRYISOCD = '',Input_EFX_SECCTRYNUM = '',Input_EFX_SECCTRYNAME = '',Input_EFX_PHONE = '',Input_EFX_FAXPHONE = '',Input_EFX_BUSSTAT = '',Input_EFX_YREST = '',Input_EFX_CORPEMPCNT = '',Input_EFX_LOCEMPCNT = '',Input_EFX_LOCEMPCD = '',Input_EFX_CORPAMOUNT = '',Input_EFX_LOCAMOUNT = '',Input_EFX_LOCAMOUNTCD = '',Input_EFX_LOCAMOUNTTP = '',Input_EFX_LOCAMOUNTPREC = '',Input_EFX_TCKSYM = '',Input_EFX_PRIMSICDESC = '',Input_EFX_SECSICDESC1 = '',Input_EFX_SECSICDESC2 = '',Input_EFX_SECSICDESC3 = '',Input_EFX_SECSICDESC4 = '',Input_EFX_PRIMNAICSCODE = '',Input_EFX_SECNAICS1 = '',Input_EFX_SECNAICS2 = '',Input_EFX_SECNAICS3 = '',Input_EFX_SECNAICS4 = '',Input_EFX_PRIMNAICSDESC = '',Input_EFX_SECNAICSDESC1 = '',Input_EFX_SECNAICSDESC2 = '',Input_EFX_SECNAICSDESC3 = '',Input_EFX_SECNAICSDESC4 = '',Input_EFX_DEAD = '',Input_EFX_DEADDT = '',Input_EFX_MRKT_TELEVER = '',Input_EFX_MRKT_VACANT = '',Input_EFX_MRKT_SEASONAL = '',Input_EFX_MBE = '',Input_EFX_WBE = '',Input_EFX_MWBE = '',Input_EFX_SDB = '',Input_EFX_HUBZONE = '',Input_EFX_DBE = '',Input_EFX_VET = '',Input_EFX_DVET = '',Input_EFX_8a = '',Input_EFX_8aEXPDT = '',Input_EFX_DIS = '',Input_EFX_SBE = '',Input_EFX_BUSSIZE = '',Input_EFX_LBE = '',Input_EFX_GOV = '',Input_EFX_FGOV = '',Input_EFX_NONPROFIT = '',Input_EFX_HBCU = '',Input_EFX_GAYLESBIAN = '',Input_EFX_WSBE = '',Input_EFX_VSBE = '',Input_EFX_DVSBE = '',Input_EFX_MWBESTATUS = '',Input_EFX_NMSDC = '',Input_EFX_WBENC = '',Input_EFX_CA_PUC = '',Input_EFX_TX_HUB = '',Input_EFX_GSAX = '',Input_EFX_CALTRANS = '',Input_EFX_EDU = '',Input_EFX_MI = '',Input_EFX_ANC = '',Input_AT_CERT1 = '',Input_AT_CERT2 = '',Input_AT_CERT3 = '',Input_AT_CERT4 = '',Input_AT_CERT5 = '',Input_AT_CERT6 = '',Input_AT_CERT7 = '',Input_AT_CERT8 = '',Input_AT_CERT9 = '',Input_AT_CERT10 = '',Input_AT_CERTDESC1 = '',Input_AT_CERTDESC2 = '',Input_AT_CERTDESC3 = '',Input_AT_CERTDESC4 = '',Input_AT_CERTDESC5 = '',Input_AT_CERTDESC6 = '',Input_AT_CERTDESC7 = '',Input_AT_CERTDESC8 = '',Input_AT_CERTDESC9 = '',Input_AT_CERTDESC10 = '',Input_AT_CERTSRC1 = '',Input_AT_CERTSRC2 = '',Input_AT_CERTSRC3 = '',Input_AT_CERTSRC4 = '',Input_AT_CERTSRC5 = '',Input_AT_CERTSRC6 = '',Input_AT_CERTSRC7 = '',Input_AT_CERTSRC8 = '',Input_AT_CERTSRC9 = '',Input_AT_CERTSRC10 = '',Input_AT_CERTNUM1 = '',Input_AT_CERTNUM2 = '',Input_AT_CERTNUM3 = '',Input_AT_CERTNUM4 = '',Input_AT_CERTNUM5 = '',Input_AT_CERTNUM6 = '',Input_AT_CERTNUM7 = '',Input_AT_CERTNUM8 = '',Input_AT_CERTNUM9 = '',Input_AT_CERTNUM10 = '',Input_AT_CERTLEV1 = '',Input_AT_CERTLEV2 = '',Input_AT_CERTLEV3 = '',Input_AT_CERTLEV4 = '',Input_AT_CERTLEV5 = '',Input_AT_CERTLEV6 = '',Input_AT_CERTLEV7 = '',Input_AT_CERTLEV8 = '',Input_AT_CERTLEV9 = '',Input_AT_CERTLEV10 = '',Input_AT_CERTEXP1 = '',Input_AT_CERTEXP2 = '',Input_AT_CERTEXP3 = '',Input_AT_CERTEXP4 = '',Input_AT_CERTEXP5 = '',Input_AT_CERTEXP6 = '',Input_AT_CERTEXP7 = '',Input_AT_CERTEXP8 = '',Input_AT_CERTEXP9 = '',Input_AT_CERTEXP10 = '',Input_EFX_EXTRACT_DATE = '',Input_EFX_MERCHANT_ID = '',Input_EFX_PROJECT_ID = '',Input_EFX_FOREIGN = '',Input_Record_Update_Refresh_Date = '',Input_EFX_DATE_CREATED = '',OutFile) := MACRO
  IMPORT SALT37,Scrubs_Equifax_Business_Data;
  #uniquename(of)
  %of% := RECORD
    SALT37.Str512Type fields;
  END;
  #uniquename(ot)
  %of% %ot%(infile le) := TRANSFORM
    SELF.fields :=
    #IF( #TEXT(Input_dotid)='' )
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
 
+    #IF( #TEXT(Input_process_date)='' )
      '' 
    #ELSE
        IF( le.Input_process_date = (TYPEOF(le.Input_process_date))'','',':process_date')
    #END
 
+    #IF( #TEXT(Input_record_type)='' )
      '' 
    #ELSE
        IF( le.Input_record_type = (TYPEOF(le.Input_record_type))'','',':record_type')
    #END
 
+    #IF( #TEXT(Input_normcompany_type)='' )
      '' 
    #ELSE
        IF( le.Input_normcompany_type = (TYPEOF(le.Input_normcompany_type))'','',':normcompany_type')
    #END
 
+    #IF( #TEXT(Input_normaddress_type)='' )
      '' 
    #ELSE
        IF( le.Input_normaddress_type = (TYPEOF(le.Input_normaddress_type))'','',':normaddress_type')
    #END
 
+    #IF( #TEXT(Input_norm_state)='' )
      '' 
    #ELSE
        IF( le.Input_norm_state = (TYPEOF(le.Input_norm_state))'','',':norm_state')
    #END
 
+    #IF( #TEXT(Input_norm_zip)='' )
      '' 
    #ELSE
        IF( le.Input_norm_zip = (TYPEOF(le.Input_norm_zip))'','',':norm_zip')
    #END
 
+    #IF( #TEXT(Input_norm_zip4)='' )
      '' 
    #ELSE
        IF( le.Input_norm_zip4 = (TYPEOF(le.Input_norm_zip4))'','',':norm_zip4')
    #END
 
+    #IF( #TEXT(Input_EFX_NAME)='' )
      '' 
    #ELSE
        IF( le.Input_EFX_NAME = (TYPEOF(le.Input_EFX_NAME))'','',':EFX_NAME')
    #END
 
+    #IF( #TEXT(Input_EFX_LEGAL_NAME)='' )
      '' 
    #ELSE
        IF( le.Input_EFX_LEGAL_NAME = (TYPEOF(le.Input_EFX_LEGAL_NAME))'','',':EFX_LEGAL_NAME')
    #END
 
+    #IF( #TEXT(Input_EFX_ADDRESS)='' )
      '' 
    #ELSE
        IF( le.Input_EFX_ADDRESS = (TYPEOF(le.Input_EFX_ADDRESS))'','',':EFX_ADDRESS')
    #END
 
+    #IF( #TEXT(Input_clean_company_name)='' )
      '' 
    #ELSE
        IF( le.Input_clean_company_name = (TYPEOF(le.Input_clean_company_name))'','',':clean_company_name')
    #END
 
+    #IF( #TEXT(Input_clean_phone)='' )
      '' 
    #ELSE
        IF( le.Input_clean_phone = (TYPEOF(le.Input_clean_phone))'','',':clean_phone')
    #END
 
+    #IF( #TEXT(Input_prim_range)='' )
      '' 
    #ELSE
        IF( le.Input_prim_range = (TYPEOF(le.Input_prim_range))'','',':prim_range')
    #END
 
+    #IF( #TEXT(Input_predir)='' )
      '' 
    #ELSE
        IF( le.Input_predir = (TYPEOF(le.Input_predir))'','',':predir')
    #END
 
+    #IF( #TEXT(Input_addr_suffix)='' )
      '' 
    #ELSE
        IF( le.Input_addr_suffix = (TYPEOF(le.Input_addr_suffix))'','',':addr_suffix')
    #END
 
+    #IF( #TEXT(Input_postdir)='' )
      '' 
    #ELSE
        IF( le.Input_postdir = (TYPEOF(le.Input_postdir))'','',':postdir')
    #END
 
+    #IF( #TEXT(Input_unit_desig)='' )
      '' 
    #ELSE
        IF( le.Input_unit_desig = (TYPEOF(le.Input_unit_desig))'','',':unit_desig')
    #END
 
+    #IF( #TEXT(Input_sec_range)='' )
      '' 
    #ELSE
        IF( le.Input_sec_range = (TYPEOF(le.Input_sec_range))'','',':sec_range')
    #END
 
+    #IF( #TEXT(Input_st)='' )
      '' 
    #ELSE
        IF( le.Input_st = (TYPEOF(le.Input_st))'','',':st')
    #END
 
+    #IF( #TEXT(Input_zip)='' )
      '' 
    #ELSE
        IF( le.Input_zip = (TYPEOF(le.Input_zip))'','',':zip')
    #END
 
+    #IF( #TEXT(Input_zip4)='' )
      '' 
    #ELSE
        IF( le.Input_zip4 = (TYPEOF(le.Input_zip4))'','',':zip4')
    #END
 
+    #IF( #TEXT(Input_cr_sort_sz)='' )
      '' 
    #ELSE
        IF( le.Input_cr_sort_sz = (TYPEOF(le.Input_cr_sort_sz))'','',':cr_sort_sz')
    #END
 
+    #IF( #TEXT(Input_lot_order)='' )
      '' 
    #ELSE
        IF( le.Input_lot_order = (TYPEOF(le.Input_lot_order))'','',':lot_order')
    #END
 
+    #IF( #TEXT(Input_rec_type)='' )
      '' 
    #ELSE
        IF( le.Input_rec_type = (TYPEOF(le.Input_rec_type))'','',':rec_type')
    #END
 
+    #IF( #TEXT(Input_fips_state)='' )
      '' 
    #ELSE
        IF( le.Input_fips_state = (TYPEOF(le.Input_fips_state))'','',':fips_state')
    #END
 
+    #IF( #TEXT(Input_geo_lat)='' )
      '' 
    #ELSE
        IF( le.Input_geo_lat = (TYPEOF(le.Input_geo_lat))'','',':geo_lat')
    #END
 
+    #IF( #TEXT(Input_geo_long)='' )
      '' 
    #ELSE
        IF( le.Input_geo_long = (TYPEOF(le.Input_geo_long))'','',':geo_long')
    #END
 
+    #IF( #TEXT(Input_geo_match)='' )
      '' 
    #ELSE
        IF( le.Input_geo_match = (TYPEOF(le.Input_geo_match))'','',':geo_match')
    #END
 
+    #IF( #TEXT(Input_err_stat)='' )
      '' 
    #ELSE
        IF( le.Input_err_stat = (TYPEOF(le.Input_err_stat))'','',':err_stat')
    #END
 
+    #IF( #TEXT(Input_raw_aid)='' )
      '' 
    #ELSE
        IF( le.Input_raw_aid = (TYPEOF(le.Input_raw_aid))'','',':raw_aid')
    #END
 
+    #IF( #TEXT(Input_ace_aid)='' )
      '' 
    #ELSE
        IF( le.Input_ace_aid = (TYPEOF(le.Input_ace_aid))'','',':ace_aid')
    #END
 
+    #IF( #TEXT(Input_EFX_BUSSTATCD)='' )
      '' 
    #ELSE
        IF( le.Input_EFX_BUSSTATCD = (TYPEOF(le.Input_EFX_BUSSTATCD))'','',':EFX_BUSSTATCD')
    #END
 
+    #IF( #TEXT(Input_EFX_CMSA)='' )
      '' 
    #ELSE
        IF( le.Input_EFX_CMSA = (TYPEOF(le.Input_EFX_CMSA))'','',':EFX_CMSA')
    #END
 
+    #IF( #TEXT(Input_EFX_CORPAMOUNTCD)='' )
      '' 
    #ELSE
        IF( le.Input_EFX_CORPAMOUNTCD = (TYPEOF(le.Input_EFX_CORPAMOUNTCD))'','',':EFX_CORPAMOUNTCD')
    #END
 
+    #IF( #TEXT(Input_EFX_CORPAMOUNTPREC)='' )
      '' 
    #ELSE
        IF( le.Input_EFX_CORPAMOUNTPREC = (TYPEOF(le.Input_EFX_CORPAMOUNTPREC))'','',':EFX_CORPAMOUNTPREC')
    #END
 
+    #IF( #TEXT(Input_EFX_CORPAMOUNTTP)='' )
      '' 
    #ELSE
        IF( le.Input_EFX_CORPAMOUNTTP = (TYPEOF(le.Input_EFX_CORPAMOUNTTP))'','',':EFX_CORPAMOUNTTP')
    #END
 
+    #IF( #TEXT(Input_EFX_CORPEMPCD)='' )
      '' 
    #ELSE
        IF( le.Input_EFX_CORPEMPCD = (TYPEOF(le.Input_EFX_CORPEMPCD))'','',':EFX_CORPEMPCD')
    #END
 
+    #IF( #TEXT(Input_EFX_WEB)='' )
      '' 
    #ELSE
        IF( le.Input_EFX_WEB = (TYPEOF(le.Input_EFX_WEB))'','',':EFX_WEB')
    #END
 
+    #IF( #TEXT(Input_EFX_CTRYISOCD)='' )
      '' 
    #ELSE
        IF( le.Input_EFX_CTRYISOCD = (TYPEOF(le.Input_EFX_CTRYISOCD))'','',':EFX_CTRYISOCD')
    #END
 
+    #IF( #TEXT(Input_EFX_CTRYNUM)='' )
      '' 
    #ELSE
        IF( le.Input_EFX_CTRYNUM = (TYPEOF(le.Input_EFX_CTRYNUM))'','',':EFX_CTRYNUM')
    #END
 
+    #IF( #TEXT(Input_EFX_CTRYTELCD)='' )
      '' 
    #ELSE
        IF( le.Input_EFX_CTRYTELCD = (TYPEOF(le.Input_EFX_CTRYTELCD))'','',':EFX_CTRYTELCD')
    #END
 
+    #IF( #TEXT(Input_EFX_GEOPREC)='' )
      '' 
    #ELSE
        IF( le.Input_EFX_GEOPREC = (TYPEOF(le.Input_EFX_GEOPREC))'','',':EFX_GEOPREC')
    #END
 
+    #IF( #TEXT(Input_EFX_MERCTYPE)='' )
      '' 
    #ELSE
        IF( le.Input_EFX_MERCTYPE = (TYPEOF(le.Input_EFX_MERCTYPE))'','',':EFX_MERCTYPE')
    #END
 
+    #IF( #TEXT(Input_EFX_MRKT_TELESCORE)='' )
      '' 
    #ELSE
        IF( le.Input_EFX_MRKT_TELESCORE = (TYPEOF(le.Input_EFX_MRKT_TELESCORE))'','',':EFX_MRKT_TELESCORE')
    #END
 
+    #IF( #TEXT(Input_EFX_MRKT_TOTALIND)='' )
      '' 
    #ELSE
        IF( le.Input_EFX_MRKT_TOTALIND = (TYPEOF(le.Input_EFX_MRKT_TOTALIND))'','',':EFX_MRKT_TOTALIND')
    #END
 
+    #IF( #TEXT(Input_EFX_MRKT_TOTALSCORE)='' )
      '' 
    #ELSE
        IF( le.Input_EFX_MRKT_TOTALSCORE = (TYPEOF(le.Input_EFX_MRKT_TOTALSCORE))'','',':EFX_MRKT_TOTALSCORE')
    #END
 
+    #IF( #TEXT(Input_EFX_PUBLIC)='' )
      '' 
    #ELSE
        IF( le.Input_EFX_PUBLIC = (TYPEOF(le.Input_EFX_PUBLIC))'','',':EFX_PUBLIC')
    #END
 
+    #IF( #TEXT(Input_EFX_STKEXC)='' )
      '' 
    #ELSE
        IF( le.Input_EFX_STKEXC = (TYPEOF(le.Input_EFX_STKEXC))'','',':EFX_STKEXC')
    #END
 
+    #IF( #TEXT(Input_EFX_PRIMSIC)='' )
      '' 
    #ELSE
        IF( le.Input_EFX_PRIMSIC = (TYPEOF(le.Input_EFX_PRIMSIC))'','',':EFX_PRIMSIC')
    #END
 
+    #IF( #TEXT(Input_EFX_SECSIC1)='' )
      '' 
    #ELSE
        IF( le.Input_EFX_SECSIC1 = (TYPEOF(le.Input_EFX_SECSIC1))'','',':EFX_SECSIC1')
    #END
 
+    #IF( #TEXT(Input_EFX_SECSIC2)='' )
      '' 
    #ELSE
        IF( le.Input_EFX_SECSIC2 = (TYPEOF(le.Input_EFX_SECSIC2))'','',':EFX_SECSIC2')
    #END
 
+    #IF( #TEXT(Input_EFX_SECSIC3)='' )
      '' 
    #ELSE
        IF( le.Input_EFX_SECSIC3 = (TYPEOF(le.Input_EFX_SECSIC3))'','',':EFX_SECSIC3')
    #END
 
+    #IF( #TEXT(Input_EFX_SECSIC4)='' )
      '' 
    #ELSE
        IF( le.Input_EFX_SECSIC4 = (TYPEOF(le.Input_EFX_SECSIC4))'','',':EFX_SECSIC4')
    #END
 
+    #IF( #TEXT(Input_EFX_ID)='' )
      '' 
    #ELSE
        IF( le.Input_EFX_ID = (TYPEOF(le.Input_EFX_ID))'','',':EFX_ID')
    #END
 
+    #IF( #TEXT(Input_EFX_CITY)='' )
      '' 
    #ELSE
        IF( le.Input_EFX_CITY = (TYPEOF(le.Input_EFX_CITY))'','',':EFX_CITY')
    #END
 
+    #IF( #TEXT(Input_EFX_REGION)='' )
      '' 
    #ELSE
        IF( le.Input_EFX_REGION = (TYPEOF(le.Input_EFX_REGION))'','',':EFX_REGION')
    #END
 
+    #IF( #TEXT(Input_EFX_CTRYNAME)='' )
      '' 
    #ELSE
        IF( le.Input_EFX_CTRYNAME = (TYPEOF(le.Input_EFX_CTRYNAME))'','',':EFX_CTRYNAME')
    #END
 
+    #IF( #TEXT(Input_EFX_COUNTYNM)='' )
      '' 
    #ELSE
        IF( le.Input_EFX_COUNTYNM = (TYPEOF(le.Input_EFX_COUNTYNM))'','',':EFX_COUNTYNM')
    #END
 
+    #IF( #TEXT(Input_EFX_CMSADESC)='' )
      '' 
    #ELSE
        IF( le.Input_EFX_CMSADESC = (TYPEOF(le.Input_EFX_CMSADESC))'','',':EFX_CMSADESC')
    #END
 
+    #IF( #TEXT(Input_EFX_SOHO)='' )
      '' 
    #ELSE
        IF( le.Input_EFX_SOHO = (TYPEOF(le.Input_EFX_SOHO))'','',':EFX_SOHO')
    #END
 
+    #IF( #TEXT(Input_EFX_BIZ)='' )
      '' 
    #ELSE
        IF( le.Input_EFX_BIZ = (TYPEOF(le.Input_EFX_BIZ))'','',':EFX_BIZ')
    #END
 
+    #IF( #TEXT(Input_EFX_RES)='' )
      '' 
    #ELSE
        IF( le.Input_EFX_RES = (TYPEOF(le.Input_EFX_RES))'','',':EFX_RES')
    #END
 
+    #IF( #TEXT(Input_EFX_CMRA)='' )
      '' 
    #ELSE
        IF( le.Input_EFX_CMRA = (TYPEOF(le.Input_EFX_CMRA))'','',':EFX_CMRA')
    #END
 
+    #IF( #TEXT(Input_EFX_SECADR)='' )
      '' 
    #ELSE
        IF( le.Input_EFX_SECADR = (TYPEOF(le.Input_EFX_SECADR))'','',':EFX_SECADR')
    #END
 
+    #IF( #TEXT(Input_EFX_SECCTY)='' )
      '' 
    #ELSE
        IF( le.Input_EFX_SECCTY = (TYPEOF(le.Input_EFX_SECCTY))'','',':EFX_SECCTY')
    #END
 
+    #IF( #TEXT(Input_EFX_SECGEOPREC)='' )
      '' 
    #ELSE
        IF( le.Input_EFX_SECGEOPREC = (TYPEOF(le.Input_EFX_SECGEOPREC))'','',':EFX_SECGEOPREC')
    #END
 
+    #IF( #TEXT(Input_EFX_SECREGION)='' )
      '' 
    #ELSE
        IF( le.Input_EFX_SECREGION = (TYPEOF(le.Input_EFX_SECREGION))'','',':EFX_SECREGION')
    #END
 
+    #IF( #TEXT(Input_EFX_SECCTRYISOCD)='' )
      '' 
    #ELSE
        IF( le.Input_EFX_SECCTRYISOCD = (TYPEOF(le.Input_EFX_SECCTRYISOCD))'','',':EFX_SECCTRYISOCD')
    #END
 
+    #IF( #TEXT(Input_EFX_SECCTRYNUM)='' )
      '' 
    #ELSE
        IF( le.Input_EFX_SECCTRYNUM = (TYPEOF(le.Input_EFX_SECCTRYNUM))'','',':EFX_SECCTRYNUM')
    #END
 
+    #IF( #TEXT(Input_EFX_SECCTRYNAME)='' )
      '' 
    #ELSE
        IF( le.Input_EFX_SECCTRYNAME = (TYPEOF(le.Input_EFX_SECCTRYNAME))'','',':EFX_SECCTRYNAME')
    #END
 
+    #IF( #TEXT(Input_EFX_PHONE)='' )
      '' 
    #ELSE
        IF( le.Input_EFX_PHONE = (TYPEOF(le.Input_EFX_PHONE))'','',':EFX_PHONE')
    #END
 
+    #IF( #TEXT(Input_EFX_FAXPHONE)='' )
      '' 
    #ELSE
        IF( le.Input_EFX_FAXPHONE = (TYPEOF(le.Input_EFX_FAXPHONE))'','',':EFX_FAXPHONE')
    #END
 
+    #IF( #TEXT(Input_EFX_BUSSTAT)='' )
      '' 
    #ELSE
        IF( le.Input_EFX_BUSSTAT = (TYPEOF(le.Input_EFX_BUSSTAT))'','',':EFX_BUSSTAT')
    #END
 
+    #IF( #TEXT(Input_EFX_YREST)='' )
      '' 
    #ELSE
        IF( le.Input_EFX_YREST = (TYPEOF(le.Input_EFX_YREST))'','',':EFX_YREST')
    #END
 
+    #IF( #TEXT(Input_EFX_CORPEMPCNT)='' )
      '' 
    #ELSE
        IF( le.Input_EFX_CORPEMPCNT = (TYPEOF(le.Input_EFX_CORPEMPCNT))'','',':EFX_CORPEMPCNT')
    #END
 
+    #IF( #TEXT(Input_EFX_LOCEMPCNT)='' )
      '' 
    #ELSE
        IF( le.Input_EFX_LOCEMPCNT = (TYPEOF(le.Input_EFX_LOCEMPCNT))'','',':EFX_LOCEMPCNT')
    #END
 
+    #IF( #TEXT(Input_EFX_LOCEMPCD)='' )
      '' 
    #ELSE
        IF( le.Input_EFX_LOCEMPCD = (TYPEOF(le.Input_EFX_LOCEMPCD))'','',':EFX_LOCEMPCD')
    #END
 
+    #IF( #TEXT(Input_EFX_CORPAMOUNT)='' )
      '' 
    #ELSE
        IF( le.Input_EFX_CORPAMOUNT = (TYPEOF(le.Input_EFX_CORPAMOUNT))'','',':EFX_CORPAMOUNT')
    #END
 
+    #IF( #TEXT(Input_EFX_LOCAMOUNT)='' )
      '' 
    #ELSE
        IF( le.Input_EFX_LOCAMOUNT = (TYPEOF(le.Input_EFX_LOCAMOUNT))'','',':EFX_LOCAMOUNT')
    #END
 
+    #IF( #TEXT(Input_EFX_LOCAMOUNTCD)='' )
      '' 
    #ELSE
        IF( le.Input_EFX_LOCAMOUNTCD = (TYPEOF(le.Input_EFX_LOCAMOUNTCD))'','',':EFX_LOCAMOUNTCD')
    #END
 
+    #IF( #TEXT(Input_EFX_LOCAMOUNTTP)='' )
      '' 
    #ELSE
        IF( le.Input_EFX_LOCAMOUNTTP = (TYPEOF(le.Input_EFX_LOCAMOUNTTP))'','',':EFX_LOCAMOUNTTP')
    #END
 
+    #IF( #TEXT(Input_EFX_LOCAMOUNTPREC)='' )
      '' 
    #ELSE
        IF( le.Input_EFX_LOCAMOUNTPREC = (TYPEOF(le.Input_EFX_LOCAMOUNTPREC))'','',':EFX_LOCAMOUNTPREC')
    #END
 
+    #IF( #TEXT(Input_EFX_TCKSYM)='' )
      '' 
    #ELSE
        IF( le.Input_EFX_TCKSYM = (TYPEOF(le.Input_EFX_TCKSYM))'','',':EFX_TCKSYM')
    #END
 
+    #IF( #TEXT(Input_EFX_PRIMSICDESC)='' )
      '' 
    #ELSE
        IF( le.Input_EFX_PRIMSICDESC = (TYPEOF(le.Input_EFX_PRIMSICDESC))'','',':EFX_PRIMSICDESC')
    #END
 
+    #IF( #TEXT(Input_EFX_SECSICDESC1)='' )
      '' 
    #ELSE
        IF( le.Input_EFX_SECSICDESC1 = (TYPEOF(le.Input_EFX_SECSICDESC1))'','',':EFX_SECSICDESC1')
    #END
 
+    #IF( #TEXT(Input_EFX_SECSICDESC2)='' )
      '' 
    #ELSE
        IF( le.Input_EFX_SECSICDESC2 = (TYPEOF(le.Input_EFX_SECSICDESC2))'','',':EFX_SECSICDESC2')
    #END
 
+    #IF( #TEXT(Input_EFX_SECSICDESC3)='' )
      '' 
    #ELSE
        IF( le.Input_EFX_SECSICDESC3 = (TYPEOF(le.Input_EFX_SECSICDESC3))'','',':EFX_SECSICDESC3')
    #END
 
+    #IF( #TEXT(Input_EFX_SECSICDESC4)='' )
      '' 
    #ELSE
        IF( le.Input_EFX_SECSICDESC4 = (TYPEOF(le.Input_EFX_SECSICDESC4))'','',':EFX_SECSICDESC4')
    #END
 
+    #IF( #TEXT(Input_EFX_PRIMNAICSCODE)='' )
      '' 
    #ELSE
        IF( le.Input_EFX_PRIMNAICSCODE = (TYPEOF(le.Input_EFX_PRIMNAICSCODE))'','',':EFX_PRIMNAICSCODE')
    #END
 
+    #IF( #TEXT(Input_EFX_SECNAICS1)='' )
      '' 
    #ELSE
        IF( le.Input_EFX_SECNAICS1 = (TYPEOF(le.Input_EFX_SECNAICS1))'','',':EFX_SECNAICS1')
    #END
 
+    #IF( #TEXT(Input_EFX_SECNAICS2)='' )
      '' 
    #ELSE
        IF( le.Input_EFX_SECNAICS2 = (TYPEOF(le.Input_EFX_SECNAICS2))'','',':EFX_SECNAICS2')
    #END
 
+    #IF( #TEXT(Input_EFX_SECNAICS3)='' )
      '' 
    #ELSE
        IF( le.Input_EFX_SECNAICS3 = (TYPEOF(le.Input_EFX_SECNAICS3))'','',':EFX_SECNAICS3')
    #END
 
+    #IF( #TEXT(Input_EFX_SECNAICS4)='' )
      '' 
    #ELSE
        IF( le.Input_EFX_SECNAICS4 = (TYPEOF(le.Input_EFX_SECNAICS4))'','',':EFX_SECNAICS4')
    #END
 
+    #IF( #TEXT(Input_EFX_PRIMNAICSDESC)='' )
      '' 
    #ELSE
        IF( le.Input_EFX_PRIMNAICSDESC = (TYPEOF(le.Input_EFX_PRIMNAICSDESC))'','',':EFX_PRIMNAICSDESC')
    #END
 
+    #IF( #TEXT(Input_EFX_SECNAICSDESC1)='' )
      '' 
    #ELSE
        IF( le.Input_EFX_SECNAICSDESC1 = (TYPEOF(le.Input_EFX_SECNAICSDESC1))'','',':EFX_SECNAICSDESC1')
    #END
 
+    #IF( #TEXT(Input_EFX_SECNAICSDESC2)='' )
      '' 
    #ELSE
        IF( le.Input_EFX_SECNAICSDESC2 = (TYPEOF(le.Input_EFX_SECNAICSDESC2))'','',':EFX_SECNAICSDESC2')
    #END
 
+    #IF( #TEXT(Input_EFX_SECNAICSDESC3)='' )
      '' 
    #ELSE
        IF( le.Input_EFX_SECNAICSDESC3 = (TYPEOF(le.Input_EFX_SECNAICSDESC3))'','',':EFX_SECNAICSDESC3')
    #END
 
+    #IF( #TEXT(Input_EFX_SECNAICSDESC4)='' )
      '' 
    #ELSE
        IF( le.Input_EFX_SECNAICSDESC4 = (TYPEOF(le.Input_EFX_SECNAICSDESC4))'','',':EFX_SECNAICSDESC4')
    #END
 
+    #IF( #TEXT(Input_EFX_DEAD)='' )
      '' 
    #ELSE
        IF( le.Input_EFX_DEAD = (TYPEOF(le.Input_EFX_DEAD))'','',':EFX_DEAD')
    #END
 
+    #IF( #TEXT(Input_EFX_DEADDT)='' )
      '' 
    #ELSE
        IF( le.Input_EFX_DEADDT = (TYPEOF(le.Input_EFX_DEADDT))'','',':EFX_DEADDT')
    #END
 
+    #IF( #TEXT(Input_EFX_MRKT_TELEVER)='' )
      '' 
    #ELSE
        IF( le.Input_EFX_MRKT_TELEVER = (TYPEOF(le.Input_EFX_MRKT_TELEVER))'','',':EFX_MRKT_TELEVER')
    #END
 
+    #IF( #TEXT(Input_EFX_MRKT_VACANT)='' )
      '' 
    #ELSE
        IF( le.Input_EFX_MRKT_VACANT = (TYPEOF(le.Input_EFX_MRKT_VACANT))'','',':EFX_MRKT_VACANT')
    #END
 
+    #IF( #TEXT(Input_EFX_MRKT_SEASONAL)='' )
      '' 
    #ELSE
        IF( le.Input_EFX_MRKT_SEASONAL = (TYPEOF(le.Input_EFX_MRKT_SEASONAL))'','',':EFX_MRKT_SEASONAL')
    #END
 
+    #IF( #TEXT(Input_EFX_MBE)='' )
      '' 
    #ELSE
        IF( le.Input_EFX_MBE = (TYPEOF(le.Input_EFX_MBE))'','',':EFX_MBE')
    #END
 
+    #IF( #TEXT(Input_EFX_WBE)='' )
      '' 
    #ELSE
        IF( le.Input_EFX_WBE = (TYPEOF(le.Input_EFX_WBE))'','',':EFX_WBE')
    #END
 
+    #IF( #TEXT(Input_EFX_MWBE)='' )
      '' 
    #ELSE
        IF( le.Input_EFX_MWBE = (TYPEOF(le.Input_EFX_MWBE))'','',':EFX_MWBE')
    #END
 
+    #IF( #TEXT(Input_EFX_SDB)='' )
      '' 
    #ELSE
        IF( le.Input_EFX_SDB = (TYPEOF(le.Input_EFX_SDB))'','',':EFX_SDB')
    #END
 
+    #IF( #TEXT(Input_EFX_HUBZONE)='' )
      '' 
    #ELSE
        IF( le.Input_EFX_HUBZONE = (TYPEOF(le.Input_EFX_HUBZONE))'','',':EFX_HUBZONE')
    #END
 
+    #IF( #TEXT(Input_EFX_DBE)='' )
      '' 
    #ELSE
        IF( le.Input_EFX_DBE = (TYPEOF(le.Input_EFX_DBE))'','',':EFX_DBE')
    #END
 
+    #IF( #TEXT(Input_EFX_VET)='' )
      '' 
    #ELSE
        IF( le.Input_EFX_VET = (TYPEOF(le.Input_EFX_VET))'','',':EFX_VET')
    #END
 
+    #IF( #TEXT(Input_EFX_DVET)='' )
      '' 
    #ELSE
        IF( le.Input_EFX_DVET = (TYPEOF(le.Input_EFX_DVET))'','',':EFX_DVET')
    #END
 
+    #IF( #TEXT(Input_EFX_8a)='' )
      '' 
    #ELSE
        IF( le.Input_EFX_8a = (TYPEOF(le.Input_EFX_8a))'','',':EFX_8a')
    #END
 
+    #IF( #TEXT(Input_EFX_8aEXPDT)='' )
      '' 
    #ELSE
        IF( le.Input_EFX_8aEXPDT = (TYPEOF(le.Input_EFX_8aEXPDT))'','',':EFX_8aEXPDT')
    #END
 
+    #IF( #TEXT(Input_EFX_DIS)='' )
      '' 
    #ELSE
        IF( le.Input_EFX_DIS = (TYPEOF(le.Input_EFX_DIS))'','',':EFX_DIS')
    #END
 
+    #IF( #TEXT(Input_EFX_SBE)='' )
      '' 
    #ELSE
        IF( le.Input_EFX_SBE = (TYPEOF(le.Input_EFX_SBE))'','',':EFX_SBE')
    #END
 
+    #IF( #TEXT(Input_EFX_BUSSIZE)='' )
      '' 
    #ELSE
        IF( le.Input_EFX_BUSSIZE = (TYPEOF(le.Input_EFX_BUSSIZE))'','',':EFX_BUSSIZE')
    #END
 
+    #IF( #TEXT(Input_EFX_LBE)='' )
      '' 
    #ELSE
        IF( le.Input_EFX_LBE = (TYPEOF(le.Input_EFX_LBE))'','',':EFX_LBE')
    #END
 
+    #IF( #TEXT(Input_EFX_GOV)='' )
      '' 
    #ELSE
        IF( le.Input_EFX_GOV = (TYPEOF(le.Input_EFX_GOV))'','',':EFX_GOV')
    #END
 
+    #IF( #TEXT(Input_EFX_FGOV)='' )
      '' 
    #ELSE
        IF( le.Input_EFX_FGOV = (TYPEOF(le.Input_EFX_FGOV))'','',':EFX_FGOV')
    #END
 
+    #IF( #TEXT(Input_EFX_NONPROFIT)='' )
      '' 
    #ELSE
        IF( le.Input_EFX_NONPROFIT = (TYPEOF(le.Input_EFX_NONPROFIT))'','',':EFX_NONPROFIT')
    #END
 
+    #IF( #TEXT(Input_EFX_HBCU)='' )
      '' 
    #ELSE
        IF( le.Input_EFX_HBCU = (TYPEOF(le.Input_EFX_HBCU))'','',':EFX_HBCU')
    #END
 
+    #IF( #TEXT(Input_EFX_GAYLESBIAN)='' )
      '' 
    #ELSE
        IF( le.Input_EFX_GAYLESBIAN = (TYPEOF(le.Input_EFX_GAYLESBIAN))'','',':EFX_GAYLESBIAN')
    #END
 
+    #IF( #TEXT(Input_EFX_WSBE)='' )
      '' 
    #ELSE
        IF( le.Input_EFX_WSBE = (TYPEOF(le.Input_EFX_WSBE))'','',':EFX_WSBE')
    #END
 
+    #IF( #TEXT(Input_EFX_VSBE)='' )
      '' 
    #ELSE
        IF( le.Input_EFX_VSBE = (TYPEOF(le.Input_EFX_VSBE))'','',':EFX_VSBE')
    #END
 
+    #IF( #TEXT(Input_EFX_DVSBE)='' )
      '' 
    #ELSE
        IF( le.Input_EFX_DVSBE = (TYPEOF(le.Input_EFX_DVSBE))'','',':EFX_DVSBE')
    #END
 
+    #IF( #TEXT(Input_EFX_MWBESTATUS)='' )
      '' 
    #ELSE
        IF( le.Input_EFX_MWBESTATUS = (TYPEOF(le.Input_EFX_MWBESTATUS))'','',':EFX_MWBESTATUS')
    #END
 
+    #IF( #TEXT(Input_EFX_NMSDC)='' )
      '' 
    #ELSE
        IF( le.Input_EFX_NMSDC = (TYPEOF(le.Input_EFX_NMSDC))'','',':EFX_NMSDC')
    #END
 
+    #IF( #TEXT(Input_EFX_WBENC)='' )
      '' 
    #ELSE
        IF( le.Input_EFX_WBENC = (TYPEOF(le.Input_EFX_WBENC))'','',':EFX_WBENC')
    #END
 
+    #IF( #TEXT(Input_EFX_CA_PUC)='' )
      '' 
    #ELSE
        IF( le.Input_EFX_CA_PUC = (TYPEOF(le.Input_EFX_CA_PUC))'','',':EFX_CA_PUC')
    #END
 
+    #IF( #TEXT(Input_EFX_TX_HUB)='' )
      '' 
    #ELSE
        IF( le.Input_EFX_TX_HUB = (TYPEOF(le.Input_EFX_TX_HUB))'','',':EFX_TX_HUB')
    #END
 
+    #IF( #TEXT(Input_EFX_GSAX)='' )
      '' 
    #ELSE
        IF( le.Input_EFX_GSAX = (TYPEOF(le.Input_EFX_GSAX))'','',':EFX_GSAX')
    #END
 
+    #IF( #TEXT(Input_EFX_CALTRANS)='' )
      '' 
    #ELSE
        IF( le.Input_EFX_CALTRANS = (TYPEOF(le.Input_EFX_CALTRANS))'','',':EFX_CALTRANS')
    #END
 
+    #IF( #TEXT(Input_EFX_EDU)='' )
      '' 
    #ELSE
        IF( le.Input_EFX_EDU = (TYPEOF(le.Input_EFX_EDU))'','',':EFX_EDU')
    #END
 
+    #IF( #TEXT(Input_EFX_MI)='' )
      '' 
    #ELSE
        IF( le.Input_EFX_MI = (TYPEOF(le.Input_EFX_MI))'','',':EFX_MI')
    #END
 
+    #IF( #TEXT(Input_EFX_ANC)='' )
      '' 
    #ELSE
        IF( le.Input_EFX_ANC = (TYPEOF(le.Input_EFX_ANC))'','',':EFX_ANC')
    #END
 
+    #IF( #TEXT(Input_AT_CERT1)='' )
      '' 
    #ELSE
        IF( le.Input_AT_CERT1 = (TYPEOF(le.Input_AT_CERT1))'','',':AT_CERT1')
    #END
 
+    #IF( #TEXT(Input_AT_CERT2)='' )
      '' 
    #ELSE
        IF( le.Input_AT_CERT2 = (TYPEOF(le.Input_AT_CERT2))'','',':AT_CERT2')
    #END
 
+    #IF( #TEXT(Input_AT_CERT3)='' )
      '' 
    #ELSE
        IF( le.Input_AT_CERT3 = (TYPEOF(le.Input_AT_CERT3))'','',':AT_CERT3')
    #END
 
+    #IF( #TEXT(Input_AT_CERT4)='' )
      '' 
    #ELSE
        IF( le.Input_AT_CERT4 = (TYPEOF(le.Input_AT_CERT4))'','',':AT_CERT4')
    #END
 
+    #IF( #TEXT(Input_AT_CERT5)='' )
      '' 
    #ELSE
        IF( le.Input_AT_CERT5 = (TYPEOF(le.Input_AT_CERT5))'','',':AT_CERT5')
    #END
 
+    #IF( #TEXT(Input_AT_CERT6)='' )
      '' 
    #ELSE
        IF( le.Input_AT_CERT6 = (TYPEOF(le.Input_AT_CERT6))'','',':AT_CERT6')
    #END
 
+    #IF( #TEXT(Input_AT_CERT7)='' )
      '' 
    #ELSE
        IF( le.Input_AT_CERT7 = (TYPEOF(le.Input_AT_CERT7))'','',':AT_CERT7')
    #END
 
+    #IF( #TEXT(Input_AT_CERT8)='' )
      '' 
    #ELSE
        IF( le.Input_AT_CERT8 = (TYPEOF(le.Input_AT_CERT8))'','',':AT_CERT8')
    #END
 
+    #IF( #TEXT(Input_AT_CERT9)='' )
      '' 
    #ELSE
        IF( le.Input_AT_CERT9 = (TYPEOF(le.Input_AT_CERT9))'','',':AT_CERT9')
    #END
 
+    #IF( #TEXT(Input_AT_CERT10)='' )
      '' 
    #ELSE
        IF( le.Input_AT_CERT10 = (TYPEOF(le.Input_AT_CERT10))'','',':AT_CERT10')
    #END
 
+    #IF( #TEXT(Input_AT_CERTDESC1)='' )
      '' 
    #ELSE
        IF( le.Input_AT_CERTDESC1 = (TYPEOF(le.Input_AT_CERTDESC1))'','',':AT_CERTDESC1')
    #END
 
+    #IF( #TEXT(Input_AT_CERTDESC2)='' )
      '' 
    #ELSE
        IF( le.Input_AT_CERTDESC2 = (TYPEOF(le.Input_AT_CERTDESC2))'','',':AT_CERTDESC2')
    #END
 
+    #IF( #TEXT(Input_AT_CERTDESC3)='' )
      '' 
    #ELSE
        IF( le.Input_AT_CERTDESC3 = (TYPEOF(le.Input_AT_CERTDESC3))'','',':AT_CERTDESC3')
    #END
 
+    #IF( #TEXT(Input_AT_CERTDESC4)='' )
      '' 
    #ELSE
        IF( le.Input_AT_CERTDESC4 = (TYPEOF(le.Input_AT_CERTDESC4))'','',':AT_CERTDESC4')
    #END
 
+    #IF( #TEXT(Input_AT_CERTDESC5)='' )
      '' 
    #ELSE
        IF( le.Input_AT_CERTDESC5 = (TYPEOF(le.Input_AT_CERTDESC5))'','',':AT_CERTDESC5')
    #END
 
+    #IF( #TEXT(Input_AT_CERTDESC6)='' )
      '' 
    #ELSE
        IF( le.Input_AT_CERTDESC6 = (TYPEOF(le.Input_AT_CERTDESC6))'','',':AT_CERTDESC6')
    #END
 
+    #IF( #TEXT(Input_AT_CERTDESC7)='' )
      '' 
    #ELSE
        IF( le.Input_AT_CERTDESC7 = (TYPEOF(le.Input_AT_CERTDESC7))'','',':AT_CERTDESC7')
    #END
 
+    #IF( #TEXT(Input_AT_CERTDESC8)='' )
      '' 
    #ELSE
        IF( le.Input_AT_CERTDESC8 = (TYPEOF(le.Input_AT_CERTDESC8))'','',':AT_CERTDESC8')
    #END
 
+    #IF( #TEXT(Input_AT_CERTDESC9)='' )
      '' 
    #ELSE
        IF( le.Input_AT_CERTDESC9 = (TYPEOF(le.Input_AT_CERTDESC9))'','',':AT_CERTDESC9')
    #END
 
+    #IF( #TEXT(Input_AT_CERTDESC10)='' )
      '' 
    #ELSE
        IF( le.Input_AT_CERTDESC10 = (TYPEOF(le.Input_AT_CERTDESC10))'','',':AT_CERTDESC10')
    #END
 
+    #IF( #TEXT(Input_AT_CERTSRC1)='' )
      '' 
    #ELSE
        IF( le.Input_AT_CERTSRC1 = (TYPEOF(le.Input_AT_CERTSRC1))'','',':AT_CERTSRC1')
    #END
 
+    #IF( #TEXT(Input_AT_CERTSRC2)='' )
      '' 
    #ELSE
        IF( le.Input_AT_CERTSRC2 = (TYPEOF(le.Input_AT_CERTSRC2))'','',':AT_CERTSRC2')
    #END
 
+    #IF( #TEXT(Input_AT_CERTSRC3)='' )
      '' 
    #ELSE
        IF( le.Input_AT_CERTSRC3 = (TYPEOF(le.Input_AT_CERTSRC3))'','',':AT_CERTSRC3')
    #END
 
+    #IF( #TEXT(Input_AT_CERTSRC4)='' )
      '' 
    #ELSE
        IF( le.Input_AT_CERTSRC4 = (TYPEOF(le.Input_AT_CERTSRC4))'','',':AT_CERTSRC4')
    #END
 
+    #IF( #TEXT(Input_AT_CERTSRC5)='' )
      '' 
    #ELSE
        IF( le.Input_AT_CERTSRC5 = (TYPEOF(le.Input_AT_CERTSRC5))'','',':AT_CERTSRC5')
    #END
 
+    #IF( #TEXT(Input_AT_CERTSRC6)='' )
      '' 
    #ELSE
        IF( le.Input_AT_CERTSRC6 = (TYPEOF(le.Input_AT_CERTSRC6))'','',':AT_CERTSRC6')
    #END
 
+    #IF( #TEXT(Input_AT_CERTSRC7)='' )
      '' 
    #ELSE
        IF( le.Input_AT_CERTSRC7 = (TYPEOF(le.Input_AT_CERTSRC7))'','',':AT_CERTSRC7')
    #END
 
+    #IF( #TEXT(Input_AT_CERTSRC8)='' )
      '' 
    #ELSE
        IF( le.Input_AT_CERTSRC8 = (TYPEOF(le.Input_AT_CERTSRC8))'','',':AT_CERTSRC8')
    #END
 
+    #IF( #TEXT(Input_AT_CERTSRC9)='' )
      '' 
    #ELSE
        IF( le.Input_AT_CERTSRC9 = (TYPEOF(le.Input_AT_CERTSRC9))'','',':AT_CERTSRC9')
    #END
 
+    #IF( #TEXT(Input_AT_CERTSRC10)='' )
      '' 
    #ELSE
        IF( le.Input_AT_CERTSRC10 = (TYPEOF(le.Input_AT_CERTSRC10))'','',':AT_CERTSRC10')
    #END
 
+    #IF( #TEXT(Input_AT_CERTNUM1)='' )
      '' 
    #ELSE
        IF( le.Input_AT_CERTNUM1 = (TYPEOF(le.Input_AT_CERTNUM1))'','',':AT_CERTNUM1')
    #END
 
+    #IF( #TEXT(Input_AT_CERTNUM2)='' )
      '' 
    #ELSE
        IF( le.Input_AT_CERTNUM2 = (TYPEOF(le.Input_AT_CERTNUM2))'','',':AT_CERTNUM2')
    #END
 
+    #IF( #TEXT(Input_AT_CERTNUM3)='' )
      '' 
    #ELSE
        IF( le.Input_AT_CERTNUM3 = (TYPEOF(le.Input_AT_CERTNUM3))'','',':AT_CERTNUM3')
    #END
 
+    #IF( #TEXT(Input_AT_CERTNUM4)='' )
      '' 
    #ELSE
        IF( le.Input_AT_CERTNUM4 = (TYPEOF(le.Input_AT_CERTNUM4))'','',':AT_CERTNUM4')
    #END
 
+    #IF( #TEXT(Input_AT_CERTNUM5)='' )
      '' 
    #ELSE
        IF( le.Input_AT_CERTNUM5 = (TYPEOF(le.Input_AT_CERTNUM5))'','',':AT_CERTNUM5')
    #END
 
+    #IF( #TEXT(Input_AT_CERTNUM6)='' )
      '' 
    #ELSE
        IF( le.Input_AT_CERTNUM6 = (TYPEOF(le.Input_AT_CERTNUM6))'','',':AT_CERTNUM6')
    #END
 
+    #IF( #TEXT(Input_AT_CERTNUM7)='' )
      '' 
    #ELSE
        IF( le.Input_AT_CERTNUM7 = (TYPEOF(le.Input_AT_CERTNUM7))'','',':AT_CERTNUM7')
    #END
 
+    #IF( #TEXT(Input_AT_CERTNUM8)='' )
      '' 
    #ELSE
        IF( le.Input_AT_CERTNUM8 = (TYPEOF(le.Input_AT_CERTNUM8))'','',':AT_CERTNUM8')
    #END
 
+    #IF( #TEXT(Input_AT_CERTNUM9)='' )
      '' 
    #ELSE
        IF( le.Input_AT_CERTNUM9 = (TYPEOF(le.Input_AT_CERTNUM9))'','',':AT_CERTNUM9')
    #END
 
+    #IF( #TEXT(Input_AT_CERTNUM10)='' )
      '' 
    #ELSE
        IF( le.Input_AT_CERTNUM10 = (TYPEOF(le.Input_AT_CERTNUM10))'','',':AT_CERTNUM10')
    #END
 
+    #IF( #TEXT(Input_AT_CERTLEV1)='' )
      '' 
    #ELSE
        IF( le.Input_AT_CERTLEV1 = (TYPEOF(le.Input_AT_CERTLEV1))'','',':AT_CERTLEV1')
    #END
 
+    #IF( #TEXT(Input_AT_CERTLEV2)='' )
      '' 
    #ELSE
        IF( le.Input_AT_CERTLEV2 = (TYPEOF(le.Input_AT_CERTLEV2))'','',':AT_CERTLEV2')
    #END
 
+    #IF( #TEXT(Input_AT_CERTLEV3)='' )
      '' 
    #ELSE
        IF( le.Input_AT_CERTLEV3 = (TYPEOF(le.Input_AT_CERTLEV3))'','',':AT_CERTLEV3')
    #END
 
+    #IF( #TEXT(Input_AT_CERTLEV4)='' )
      '' 
    #ELSE
        IF( le.Input_AT_CERTLEV4 = (TYPEOF(le.Input_AT_CERTLEV4))'','',':AT_CERTLEV4')
    #END
 
+    #IF( #TEXT(Input_AT_CERTLEV5)='' )
      '' 
    #ELSE
        IF( le.Input_AT_CERTLEV5 = (TYPEOF(le.Input_AT_CERTLEV5))'','',':AT_CERTLEV5')
    #END
 
+    #IF( #TEXT(Input_AT_CERTLEV6)='' )
      '' 
    #ELSE
        IF( le.Input_AT_CERTLEV6 = (TYPEOF(le.Input_AT_CERTLEV6))'','',':AT_CERTLEV6')
    #END
 
+    #IF( #TEXT(Input_AT_CERTLEV7)='' )
      '' 
    #ELSE
        IF( le.Input_AT_CERTLEV7 = (TYPEOF(le.Input_AT_CERTLEV7))'','',':AT_CERTLEV7')
    #END
 
+    #IF( #TEXT(Input_AT_CERTLEV8)='' )
      '' 
    #ELSE
        IF( le.Input_AT_CERTLEV8 = (TYPEOF(le.Input_AT_CERTLEV8))'','',':AT_CERTLEV8')
    #END
 
+    #IF( #TEXT(Input_AT_CERTLEV9)='' )
      '' 
    #ELSE
        IF( le.Input_AT_CERTLEV9 = (TYPEOF(le.Input_AT_CERTLEV9))'','',':AT_CERTLEV9')
    #END
 
+    #IF( #TEXT(Input_AT_CERTLEV10)='' )
      '' 
    #ELSE
        IF( le.Input_AT_CERTLEV10 = (TYPEOF(le.Input_AT_CERTLEV10))'','',':AT_CERTLEV10')
    #END
 
+    #IF( #TEXT(Input_AT_CERTEXP1)='' )
      '' 
    #ELSE
        IF( le.Input_AT_CERTEXP1 = (TYPEOF(le.Input_AT_CERTEXP1))'','',':AT_CERTEXP1')
    #END
 
+    #IF( #TEXT(Input_AT_CERTEXP2)='' )
      '' 
    #ELSE
        IF( le.Input_AT_CERTEXP2 = (TYPEOF(le.Input_AT_CERTEXP2))'','',':AT_CERTEXP2')
    #END
 
+    #IF( #TEXT(Input_AT_CERTEXP3)='' )
      '' 
    #ELSE
        IF( le.Input_AT_CERTEXP3 = (TYPEOF(le.Input_AT_CERTEXP3))'','',':AT_CERTEXP3')
    #END
 
+    #IF( #TEXT(Input_AT_CERTEXP4)='' )
      '' 
    #ELSE
        IF( le.Input_AT_CERTEXP4 = (TYPEOF(le.Input_AT_CERTEXP4))'','',':AT_CERTEXP4')
    #END
 
+    #IF( #TEXT(Input_AT_CERTEXP5)='' )
      '' 
    #ELSE
        IF( le.Input_AT_CERTEXP5 = (TYPEOF(le.Input_AT_CERTEXP5))'','',':AT_CERTEXP5')
    #END
 
+    #IF( #TEXT(Input_AT_CERTEXP6)='' )
      '' 
    #ELSE
        IF( le.Input_AT_CERTEXP6 = (TYPEOF(le.Input_AT_CERTEXP6))'','',':AT_CERTEXP6')
    #END
 
+    #IF( #TEXT(Input_AT_CERTEXP7)='' )
      '' 
    #ELSE
        IF( le.Input_AT_CERTEXP7 = (TYPEOF(le.Input_AT_CERTEXP7))'','',':AT_CERTEXP7')
    #END
 
+    #IF( #TEXT(Input_AT_CERTEXP8)='' )
      '' 
    #ELSE
        IF( le.Input_AT_CERTEXP8 = (TYPEOF(le.Input_AT_CERTEXP8))'','',':AT_CERTEXP8')
    #END
 
+    #IF( #TEXT(Input_AT_CERTEXP9)='' )
      '' 
    #ELSE
        IF( le.Input_AT_CERTEXP9 = (TYPEOF(le.Input_AT_CERTEXP9))'','',':AT_CERTEXP9')
    #END
 
+    #IF( #TEXT(Input_AT_CERTEXP10)='' )
      '' 
    #ELSE
        IF( le.Input_AT_CERTEXP10 = (TYPEOF(le.Input_AT_CERTEXP10))'','',':AT_CERTEXP10')
    #END
 
+    #IF( #TEXT(Input_EFX_EXTRACT_DATE)='' )
      '' 
    #ELSE
        IF( le.Input_EFX_EXTRACT_DATE = (TYPEOF(le.Input_EFX_EXTRACT_DATE))'','',':EFX_EXTRACT_DATE')
    #END
 
+    #IF( #TEXT(Input_EFX_MERCHANT_ID)='' )
      '' 
    #ELSE
        IF( le.Input_EFX_MERCHANT_ID = (TYPEOF(le.Input_EFX_MERCHANT_ID))'','',':EFX_MERCHANT_ID')
    #END
 
+    #IF( #TEXT(Input_EFX_PROJECT_ID)='' )
      '' 
    #ELSE
        IF( le.Input_EFX_PROJECT_ID = (TYPEOF(le.Input_EFX_PROJECT_ID))'','',':EFX_PROJECT_ID')
    #END
 
+    #IF( #TEXT(Input_EFX_FOREIGN)='' )
      '' 
    #ELSE
        IF( le.Input_EFX_FOREIGN = (TYPEOF(le.Input_EFX_FOREIGN))'','',':EFX_FOREIGN')
    #END
 
+    #IF( #TEXT(Input_Record_Update_Refresh_Date)='' )
      '' 
    #ELSE
        IF( le.Input_Record_Update_Refresh_Date = (TYPEOF(le.Input_Record_Update_Refresh_Date))'','',':Record_Update_Refresh_Date')
    #END
 
+    #IF( #TEXT(Input_EFX_DATE_CREATED)='' )
      '' 
    #ELSE
        IF( le.Input_EFX_DATE_CREATED = (TYPEOF(le.Input_EFX_DATE_CREATED))'','',':EFX_DATE_CREATED')
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
