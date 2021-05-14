 
EXPORT Input_MAC_PopulationStatistics(infile,Ref='',Input_AT_CERTEXP1 = '',Input_AT_CERTEXP2 = '',Input_AT_CERTEXP3 = '',Input_AT_CERTEXP4 = '',Input_AT_CERTEXP5 = '',Input_AT_CERTEXP6 = '',Input_AT_CERTEXP7 = '',Input_AT_CERTEXP8 = '',Input_AT_CERTEXP9 = '',Input_AT_CERTEXP10 = '',Input_AT_CERTLEV1 = '',Input_AT_CERTLEV2 = '',Input_AT_CERTLEV3 = '',Input_AT_CERTLEV4 = '',Input_AT_CERTLEV5 = '',Input_AT_CERTLEV6 = '',Input_AT_CERTLEV7 = '',Input_AT_CERTLEV8 = '',Input_AT_CERTLEV9 = '',Input_AT_CERTLEV10 = '',Input_EFX_8a = '',Input_EFX_8aEXPDT = '',Input_EFX_ADDRESS = '',Input_EFX_ANC = '',Input_EFX_BIZ = '',Input_EFX_BUSSIZE = '',Input_EFX_BUSSTATCD = '',Input_EFX_CALTRANS = '',Input_EFX_CA_PUC = '',Input_EFX_CITY = '',Input_EFX_CMRA = '',Input_EFX_CMSA = '',Input_EFX_CORPAMOUNT = '',Input_EFX_CORPAMOUNTCD = '',Input_EFX_CORPAMOUNTPREC = '',Input_EFX_CORPAMOUNTTP = '',Input_EFX_CORPEMPCD = '',Input_EFX_CORPEMPCNT = '',Input_EFX_COUNTYNM = '',Input_EFX_COUNTY = '',Input_EFX_CTRYISOCD = '',Input_EFX_CTRYNAME = '',Input_EFX_CTRYNUM = '',Input_EFX_CTRYTELCD = '',Input_EFX_DATE_CREATED = '',Input_EFX_DBE = '',Input_EFX_DEAD = '',Input_EFX_DEADDT = '',Input_EFX_DIS = '',Input_EFX_DVET = '',Input_EFX_DVSBE = '',Input_EFX_EDU = '',Input_EFX_EXTRACT_DATE = '',Input_EFX_FAXPHONE = '',Input_EFX_FGOV = '',Input_EFX_FOREIGN = '',Input_EFX_GAYLESBIAN = '',Input_EFX_GEOPREC = '',Input_EFX_GOV = '',Input_EFX_GSAX = '',Input_EFX_HBCU = '',Input_EFX_HUBZONE = '',Input_EFX_ID = '',Input_EFX_LBE = '',Input_EFX_LEGAL_NAME = '',Input_EFX_LOCAMOUNT = '',Input_EFX_LOCAMOUNTCD = '',Input_EFX_LOCAMOUNTTP = '',Input_EFX_LOCAMOUNTPREC = '',Input_EFX_LOCEMPCNT = '',Input_EFX_LOCEMPCD = '',Input_EFX_MBE = '',Input_EFX_MERCHANT_ID = '',Input_EFX_MERCTYPE = '',Input_EFX_MI = '',Input_EFX_MRKT_SEASONAL = '',Input_EFX_MRKT_TELESCORE = '',Input_EFX_MRKT_TELEVER = '',Input_EFX_MRKT_TOTALIND = '',Input_EFX_MRKT_TOTALSCORE = '',Input_EFX_MRKT_VACANT = '',Input_EFX_MWBE = '',Input_EFX_MWBESTATUS = '',Input_EFX_NAME = '',Input_EFX_NMSDC = '',Input_EFX_NONPROFIT = '',Input_EFX_PHONE = '',Input_EFX_PRIMNAICSCODE = '',Input_EFX_PRIMSIC = '',Input_EFX_PROJECT_ID = '',Input_EFX_PUBLIC = '',Input_EFX_RES = '',Input_EFX_SBE = '',Input_EFX_SDB = '',Input_EFX_SECCTRYISOCD = '',Input_EFX_SECCTRYNUM = '',Input_EFX_SECGEOPREC = '',Input_EFX_SECNAICS1 = '',Input_EFX_SECNAICS2 = '',Input_EFX_SECNAICS3 = '',Input_EFX_SECNAICS4 = '',Input_EFX_SECSIC1 = '',Input_EFX_SECSIC2 = '',Input_EFX_SECSIC3 = '',Input_EFX_SECSIC4 = '',Input_EFX_STATEC = '',Input_EFX_STKEXC = '',Input_EFX_SOHO = '',Input_EFX_TX_HUB = '',Input_EFX_VET = '',Input_EFX_VSBE = '',Input_EFX_WBE = '',Input_EFX_WBENC = '',Input_EFX_WSBE = '',Input_EFX_YREST = '',Input_Record_Update_Refresh_Date = '',OutFile) := MACRO
  IMPORT SALT311,Scrubs_Equifax_Business_Data;
  #uniquename(of)
  %of% := RECORD
    SALT311.Str512Type fields;
  END;
  #uniquename(ot)
  %of% %ot%(infile le) := TRANSFORM
    SELF.fields :=
    #IF( #TEXT(Input_AT_CERTEXP1)='' )
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
 
+    #IF( #TEXT(Input_EFX_ADDRESS)='' )
      '' 
    #ELSE
        IF( le.Input_EFX_ADDRESS = (TYPEOF(le.Input_EFX_ADDRESS))'','',':EFX_ADDRESS')
    #END
 
+    #IF( #TEXT(Input_EFX_ANC)='' )
      '' 
    #ELSE
        IF( le.Input_EFX_ANC = (TYPEOF(le.Input_EFX_ANC))'','',':EFX_ANC')
    #END
 
+    #IF( #TEXT(Input_EFX_BIZ)='' )
      '' 
    #ELSE
        IF( le.Input_EFX_BIZ = (TYPEOF(le.Input_EFX_BIZ))'','',':EFX_BIZ')
    #END
 
+    #IF( #TEXT(Input_EFX_BUSSIZE)='' )
      '' 
    #ELSE
        IF( le.Input_EFX_BUSSIZE = (TYPEOF(le.Input_EFX_BUSSIZE))'','',':EFX_BUSSIZE')
    #END
 
+    #IF( #TEXT(Input_EFX_BUSSTATCD)='' )
      '' 
    #ELSE
        IF( le.Input_EFX_BUSSTATCD = (TYPEOF(le.Input_EFX_BUSSTATCD))'','',':EFX_BUSSTATCD')
    #END
 
+    #IF( #TEXT(Input_EFX_CALTRANS)='' )
      '' 
    #ELSE
        IF( le.Input_EFX_CALTRANS = (TYPEOF(le.Input_EFX_CALTRANS))'','',':EFX_CALTRANS')
    #END
 
+    #IF( #TEXT(Input_EFX_CA_PUC)='' )
      '' 
    #ELSE
        IF( le.Input_EFX_CA_PUC = (TYPEOF(le.Input_EFX_CA_PUC))'','',':EFX_CA_PUC')
    #END
 
+    #IF( #TEXT(Input_EFX_CITY)='' )
      '' 
    #ELSE
        IF( le.Input_EFX_CITY = (TYPEOF(le.Input_EFX_CITY))'','',':EFX_CITY')
    #END
 
+    #IF( #TEXT(Input_EFX_CMRA)='' )
      '' 
    #ELSE
        IF( le.Input_EFX_CMRA = (TYPEOF(le.Input_EFX_CMRA))'','',':EFX_CMRA')
    #END
 
+    #IF( #TEXT(Input_EFX_CMSA)='' )
      '' 
    #ELSE
        IF( le.Input_EFX_CMSA = (TYPEOF(le.Input_EFX_CMSA))'','',':EFX_CMSA')
    #END
 
+    #IF( #TEXT(Input_EFX_CORPAMOUNT)='' )
      '' 
    #ELSE
        IF( le.Input_EFX_CORPAMOUNT = (TYPEOF(le.Input_EFX_CORPAMOUNT))'','',':EFX_CORPAMOUNT')
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
 
+    #IF( #TEXT(Input_EFX_CORPEMPCNT)='' )
      '' 
    #ELSE
        IF( le.Input_EFX_CORPEMPCNT = (TYPEOF(le.Input_EFX_CORPEMPCNT))'','',':EFX_CORPEMPCNT')
    #END
 
+    #IF( #TEXT(Input_EFX_COUNTYNM)='' )
      '' 
    #ELSE
        IF( le.Input_EFX_COUNTYNM = (TYPEOF(le.Input_EFX_COUNTYNM))'','',':EFX_COUNTYNM')
    #END
 
+    #IF( #TEXT(Input_EFX_COUNTY)='' )
      '' 
    #ELSE
        IF( le.Input_EFX_COUNTY = (TYPEOF(le.Input_EFX_COUNTY))'','',':EFX_COUNTY')
    #END
 
+    #IF( #TEXT(Input_EFX_CTRYISOCD)='' )
      '' 
    #ELSE
        IF( le.Input_EFX_CTRYISOCD = (TYPEOF(le.Input_EFX_CTRYISOCD))'','',':EFX_CTRYISOCD')
    #END
 
+    #IF( #TEXT(Input_EFX_CTRYNAME)='' )
      '' 
    #ELSE
        IF( le.Input_EFX_CTRYNAME = (TYPEOF(le.Input_EFX_CTRYNAME))'','',':EFX_CTRYNAME')
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
 
+    #IF( #TEXT(Input_EFX_DATE_CREATED)='' )
      '' 
    #ELSE
        IF( le.Input_EFX_DATE_CREATED = (TYPEOF(le.Input_EFX_DATE_CREATED))'','',':EFX_DATE_CREATED')
    #END
 
+    #IF( #TEXT(Input_EFX_DBE)='' )
      '' 
    #ELSE
        IF( le.Input_EFX_DBE = (TYPEOF(le.Input_EFX_DBE))'','',':EFX_DBE')
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
 
+    #IF( #TEXT(Input_EFX_DIS)='' )
      '' 
    #ELSE
        IF( le.Input_EFX_DIS = (TYPEOF(le.Input_EFX_DIS))'','',':EFX_DIS')
    #END
 
+    #IF( #TEXT(Input_EFX_DVET)='' )
      '' 
    #ELSE
        IF( le.Input_EFX_DVET = (TYPEOF(le.Input_EFX_DVET))'','',':EFX_DVET')
    #END
 
+    #IF( #TEXT(Input_EFX_DVSBE)='' )
      '' 
    #ELSE
        IF( le.Input_EFX_DVSBE = (TYPEOF(le.Input_EFX_DVSBE))'','',':EFX_DVSBE')
    #END
 
+    #IF( #TEXT(Input_EFX_EDU)='' )
      '' 
    #ELSE
        IF( le.Input_EFX_EDU = (TYPEOF(le.Input_EFX_EDU))'','',':EFX_EDU')
    #END
 
+    #IF( #TEXT(Input_EFX_EXTRACT_DATE)='' )
      '' 
    #ELSE
        IF( le.Input_EFX_EXTRACT_DATE = (TYPEOF(le.Input_EFX_EXTRACT_DATE))'','',':EFX_EXTRACT_DATE')
    #END
 
+    #IF( #TEXT(Input_EFX_FAXPHONE)='' )
      '' 
    #ELSE
        IF( le.Input_EFX_FAXPHONE = (TYPEOF(le.Input_EFX_FAXPHONE))'','',':EFX_FAXPHONE')
    #END
 
+    #IF( #TEXT(Input_EFX_FGOV)='' )
      '' 
    #ELSE
        IF( le.Input_EFX_FGOV = (TYPEOF(le.Input_EFX_FGOV))'','',':EFX_FGOV')
    #END
 
+    #IF( #TEXT(Input_EFX_FOREIGN)='' )
      '' 
    #ELSE
        IF( le.Input_EFX_FOREIGN = (TYPEOF(le.Input_EFX_FOREIGN))'','',':EFX_FOREIGN')
    #END
 
+    #IF( #TEXT(Input_EFX_GAYLESBIAN)='' )
      '' 
    #ELSE
        IF( le.Input_EFX_GAYLESBIAN = (TYPEOF(le.Input_EFX_GAYLESBIAN))'','',':EFX_GAYLESBIAN')
    #END
 
+    #IF( #TEXT(Input_EFX_GEOPREC)='' )
      '' 
    #ELSE
        IF( le.Input_EFX_GEOPREC = (TYPEOF(le.Input_EFX_GEOPREC))'','',':EFX_GEOPREC')
    #END
 
+    #IF( #TEXT(Input_EFX_GOV)='' )
      '' 
    #ELSE
        IF( le.Input_EFX_GOV = (TYPEOF(le.Input_EFX_GOV))'','',':EFX_GOV')
    #END
 
+    #IF( #TEXT(Input_EFX_GSAX)='' )
      '' 
    #ELSE
        IF( le.Input_EFX_GSAX = (TYPEOF(le.Input_EFX_GSAX))'','',':EFX_GSAX')
    #END
 
+    #IF( #TEXT(Input_EFX_HBCU)='' )
      '' 
    #ELSE
        IF( le.Input_EFX_HBCU = (TYPEOF(le.Input_EFX_HBCU))'','',':EFX_HBCU')
    #END
 
+    #IF( #TEXT(Input_EFX_HUBZONE)='' )
      '' 
    #ELSE
        IF( le.Input_EFX_HUBZONE = (TYPEOF(le.Input_EFX_HUBZONE))'','',':EFX_HUBZONE')
    #END
 
+    #IF( #TEXT(Input_EFX_ID)='' )
      '' 
    #ELSE
        IF( le.Input_EFX_ID = (TYPEOF(le.Input_EFX_ID))'','',':EFX_ID')
    #END
 
+    #IF( #TEXT(Input_EFX_LBE)='' )
      '' 
    #ELSE
        IF( le.Input_EFX_LBE = (TYPEOF(le.Input_EFX_LBE))'','',':EFX_LBE')
    #END
 
+    #IF( #TEXT(Input_EFX_LEGAL_NAME)='' )
      '' 
    #ELSE
        IF( le.Input_EFX_LEGAL_NAME = (TYPEOF(le.Input_EFX_LEGAL_NAME))'','',':EFX_LEGAL_NAME')
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
 
+    #IF( #TEXT(Input_EFX_MBE)='' )
      '' 
    #ELSE
        IF( le.Input_EFX_MBE = (TYPEOF(le.Input_EFX_MBE))'','',':EFX_MBE')
    #END
 
+    #IF( #TEXT(Input_EFX_MERCHANT_ID)='' )
      '' 
    #ELSE
        IF( le.Input_EFX_MERCHANT_ID = (TYPEOF(le.Input_EFX_MERCHANT_ID))'','',':EFX_MERCHANT_ID')
    #END
 
+    #IF( #TEXT(Input_EFX_MERCTYPE)='' )
      '' 
    #ELSE
        IF( le.Input_EFX_MERCTYPE = (TYPEOF(le.Input_EFX_MERCTYPE))'','',':EFX_MERCTYPE')
    #END
 
+    #IF( #TEXT(Input_EFX_MI)='' )
      '' 
    #ELSE
        IF( le.Input_EFX_MI = (TYPEOF(le.Input_EFX_MI))'','',':EFX_MI')
    #END
 
+    #IF( #TEXT(Input_EFX_MRKT_SEASONAL)='' )
      '' 
    #ELSE
        IF( le.Input_EFX_MRKT_SEASONAL = (TYPEOF(le.Input_EFX_MRKT_SEASONAL))'','',':EFX_MRKT_SEASONAL')
    #END
 
+    #IF( #TEXT(Input_EFX_MRKT_TELESCORE)='' )
      '' 
    #ELSE
        IF( le.Input_EFX_MRKT_TELESCORE = (TYPEOF(le.Input_EFX_MRKT_TELESCORE))'','',':EFX_MRKT_TELESCORE')
    #END
 
+    #IF( #TEXT(Input_EFX_MRKT_TELEVER)='' )
      '' 
    #ELSE
        IF( le.Input_EFX_MRKT_TELEVER = (TYPEOF(le.Input_EFX_MRKT_TELEVER))'','',':EFX_MRKT_TELEVER')
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
 
+    #IF( #TEXT(Input_EFX_MRKT_VACANT)='' )
      '' 
    #ELSE
        IF( le.Input_EFX_MRKT_VACANT = (TYPEOF(le.Input_EFX_MRKT_VACANT))'','',':EFX_MRKT_VACANT')
    #END
 
+    #IF( #TEXT(Input_EFX_MWBE)='' )
      '' 
    #ELSE
        IF( le.Input_EFX_MWBE = (TYPEOF(le.Input_EFX_MWBE))'','',':EFX_MWBE')
    #END
 
+    #IF( #TEXT(Input_EFX_MWBESTATUS)='' )
      '' 
    #ELSE
        IF( le.Input_EFX_MWBESTATUS = (TYPEOF(le.Input_EFX_MWBESTATUS))'','',':EFX_MWBESTATUS')
    #END
 
+    #IF( #TEXT(Input_EFX_NAME)='' )
      '' 
    #ELSE
        IF( le.Input_EFX_NAME = (TYPEOF(le.Input_EFX_NAME))'','',':EFX_NAME')
    #END
 
+    #IF( #TEXT(Input_EFX_NMSDC)='' )
      '' 
    #ELSE
        IF( le.Input_EFX_NMSDC = (TYPEOF(le.Input_EFX_NMSDC))'','',':EFX_NMSDC')
    #END
 
+    #IF( #TEXT(Input_EFX_NONPROFIT)='' )
      '' 
    #ELSE
        IF( le.Input_EFX_NONPROFIT = (TYPEOF(le.Input_EFX_NONPROFIT))'','',':EFX_NONPROFIT')
    #END
 
+    #IF( #TEXT(Input_EFX_PHONE)='' )
      '' 
    #ELSE
        IF( le.Input_EFX_PHONE = (TYPEOF(le.Input_EFX_PHONE))'','',':EFX_PHONE')
    #END
 
+    #IF( #TEXT(Input_EFX_PRIMNAICSCODE)='' )
      '' 
    #ELSE
        IF( le.Input_EFX_PRIMNAICSCODE = (TYPEOF(le.Input_EFX_PRIMNAICSCODE))'','',':EFX_PRIMNAICSCODE')
    #END
 
+    #IF( #TEXT(Input_EFX_PRIMSIC)='' )
      '' 
    #ELSE
        IF( le.Input_EFX_PRIMSIC = (TYPEOF(le.Input_EFX_PRIMSIC))'','',':EFX_PRIMSIC')
    #END
 
+    #IF( #TEXT(Input_EFX_PROJECT_ID)='' )
      '' 
    #ELSE
        IF( le.Input_EFX_PROJECT_ID = (TYPEOF(le.Input_EFX_PROJECT_ID))'','',':EFX_PROJECT_ID')
    #END
 
+    #IF( #TEXT(Input_EFX_PUBLIC)='' )
      '' 
    #ELSE
        IF( le.Input_EFX_PUBLIC = (TYPEOF(le.Input_EFX_PUBLIC))'','',':EFX_PUBLIC')
    #END
 
+    #IF( #TEXT(Input_EFX_RES)='' )
      '' 
    #ELSE
        IF( le.Input_EFX_RES = (TYPEOF(le.Input_EFX_RES))'','',':EFX_RES')
    #END
 
+    #IF( #TEXT(Input_EFX_SBE)='' )
      '' 
    #ELSE
        IF( le.Input_EFX_SBE = (TYPEOF(le.Input_EFX_SBE))'','',':EFX_SBE')
    #END
 
+    #IF( #TEXT(Input_EFX_SDB)='' )
      '' 
    #ELSE
        IF( le.Input_EFX_SDB = (TYPEOF(le.Input_EFX_SDB))'','',':EFX_SDB')
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
 
+    #IF( #TEXT(Input_EFX_SECGEOPREC)='' )
      '' 
    #ELSE
        IF( le.Input_EFX_SECGEOPREC = (TYPEOF(le.Input_EFX_SECGEOPREC))'','',':EFX_SECGEOPREC')
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
 
+    #IF( #TEXT(Input_EFX_STATEC)='' )
      '' 
    #ELSE
        IF( le.Input_EFX_STATEC = (TYPEOF(le.Input_EFX_STATEC))'','',':EFX_STATEC')
    #END
 
+    #IF( #TEXT(Input_EFX_STKEXC)='' )
      '' 
    #ELSE
        IF( le.Input_EFX_STKEXC = (TYPEOF(le.Input_EFX_STKEXC))'','',':EFX_STKEXC')
    #END
 
+    #IF( #TEXT(Input_EFX_SOHO)='' )
      '' 
    #ELSE
        IF( le.Input_EFX_SOHO = (TYPEOF(le.Input_EFX_SOHO))'','',':EFX_SOHO')
    #END
 
+    #IF( #TEXT(Input_EFX_TX_HUB)='' )
      '' 
    #ELSE
        IF( le.Input_EFX_TX_HUB = (TYPEOF(le.Input_EFX_TX_HUB))'','',':EFX_TX_HUB')
    #END
 
+    #IF( #TEXT(Input_EFX_VET)='' )
      '' 
    #ELSE
        IF( le.Input_EFX_VET = (TYPEOF(le.Input_EFX_VET))'','',':EFX_VET')
    #END
 
+    #IF( #TEXT(Input_EFX_VSBE)='' )
      '' 
    #ELSE
        IF( le.Input_EFX_VSBE = (TYPEOF(le.Input_EFX_VSBE))'','',':EFX_VSBE')
    #END
 
+    #IF( #TEXT(Input_EFX_WBE)='' )
      '' 
    #ELSE
        IF( le.Input_EFX_WBE = (TYPEOF(le.Input_EFX_WBE))'','',':EFX_WBE')
    #END
 
+    #IF( #TEXT(Input_EFX_WBENC)='' )
      '' 
    #ELSE
        IF( le.Input_EFX_WBENC = (TYPEOF(le.Input_EFX_WBENC))'','',':EFX_WBENC')
    #END
 
+    #IF( #TEXT(Input_EFX_WSBE)='' )
      '' 
    #ELSE
        IF( le.Input_EFX_WSBE = (TYPEOF(le.Input_EFX_WSBE))'','',':EFX_WSBE')
    #END
 
+    #IF( #TEXT(Input_EFX_YREST)='' )
      '' 
    #ELSE
        IF( le.Input_EFX_YREST = (TYPEOF(le.Input_EFX_YREST))'','',':EFX_YREST')
    #END
 
+    #IF( #TEXT(Input_Record_Update_Refresh_Date)='' )
      '' 
    #ELSE
        IF( le.Input_Record_Update_Refresh_Date = (TYPEOF(le.Input_Record_Update_Refresh_Date))'','',':Record_Update_Refresh_Date')
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
