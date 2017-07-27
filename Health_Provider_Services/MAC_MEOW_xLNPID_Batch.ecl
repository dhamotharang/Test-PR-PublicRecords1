EXPORT MAC_MEOW_xLNPID_Batch(infile,Ref='',Input_FNAME = '',Input_MNAME = '',Input_LNAME = '',Input_SNAME = '',Input_GENDER = '',Input_PRIM_RANGE = '',Input_PRIM_NAME = '',Input_SEC_RANGE = '',Input_V_CITY_NAME = '',Input_ST = '',Input_ZIP = '',Input_SSN = '',Input_CNSMR_SSN = '',Input_DOB = '',Input_CNSMR_DOB = '',Input_PHONE = '',Input_LIC_STATE = '',Input_C_LIC_NBR = '',Input_TAX_ID = '',Input_BILLING_TAX_ID = '',Input_DEA_NUMBER = '',Input_VENDOR_ID = '',Input_NPI_NUMBER = '',Input_BILLING_NPI_NUMBER = '',Input_UPIN = '',Input_DID = '',Input_BDID = '',Input_SRC = '',Input_SOURCE_RID = '',Input_RID = '',Input_MAINNAME = '',Input_FULLNAME = '',Input_ADDR1 = '',Input_LOCALE = '',Input_ADDRESS = '',OutFile,AsIndex='true',Stats='') := MACRO
  #uniquename(ToProcess)
  IMPORT SALT29,Health_Provider_Services;
  #uniquename(TPRec)
  %TPRec% := RECORD(Health_Provider_Services.Process_xLNPID_Layouts.InputLayout)
  END;
  #uniquename(CleanT) // Transform to clean input data identically to online transform
  %TPRec% %CleanT%(InFile le) := TRANSFORM
    SELF.UniqueId := le.ref;
    SELF.FNAME :=   #IF (#TEXT(Input_FNAME)<>'')
(TYPEOF(SELF.FNAME))Health_Provider_Services.Fields.Make_FNAME((SALT29.StrType)le.Input_FNAME);
  #ELSE
(TYPEOF(SELF.FNAME))'';
  #END
    SELF.MNAME :=   #IF (#TEXT(Input_MNAME)<>'')
(TYPEOF(SELF.MNAME))Health_Provider_Services.Fields.Make_MNAME((SALT29.StrType)le.Input_MNAME);
  #ELSE
(TYPEOF(SELF.MNAME))'';
  #END
    SELF.LNAME :=   #IF (#TEXT(Input_LNAME)<>'')
(TYPEOF(SELF.LNAME))Health_Provider_Services.Fields.Make_LNAME((SALT29.StrType)le.Input_LNAME);
  #ELSE
(TYPEOF(SELF.LNAME))'';
  #END
    SELF.SNAME :=   #IF (#TEXT(Input_SNAME)<>'')
(TYPEOF(SELF.SNAME))Health_Provider_Services.Fields.Make_SNAME((SALT29.StrType)Health_Provider_Services.fn_clean_suffix(le.Input_SNAME));
  #ELSE
(TYPEOF(SELF.SNAME))'';
  #END
    SELF.GENDER :=   #IF (#TEXT(Input_GENDER)<>'')
(TYPEOF(SELF.GENDER))Health_Provider_Services.Fields.Make_GENDER((SALT29.StrType)le.Input_GENDER);
  #ELSE
(TYPEOF(SELF.GENDER))'';
  #END
    SELF.PRIM_RANGE :=   #IF (#TEXT(Input_PRIM_RANGE)<>'')
(TYPEOF(SELF.PRIM_RANGE))Health_Provider_Services.Fields.Make_PRIM_RANGE((SALT29.StrType)le.Input_PRIM_RANGE);
  #ELSE
(TYPEOF(SELF.PRIM_RANGE))'';
  #END
    SELF.PRIM_NAME :=   #IF (#TEXT(Input_PRIM_NAME)<>'')
(TYPEOF(SELF.PRIM_NAME))Health_Provider_Services.Fields.Make_PRIM_NAME((SALT29.StrType)le.Input_PRIM_NAME);
  #ELSE
(TYPEOF(SELF.PRIM_NAME))'';
  #END
    SELF.SEC_RANGE :=   #IF (#TEXT(Input_SEC_RANGE)<>'')
(TYPEOF(SELF.SEC_RANGE))Health_Provider_Services.Fields.Make_SEC_RANGE((SALT29.StrType)le.Input_SEC_RANGE);
  #ELSE
(TYPEOF(SELF.SEC_RANGE))'';
  #END
    SELF.V_CITY_NAME :=   #IF (#TEXT(Input_V_CITY_NAME)<>'')
(TYPEOF(SELF.V_CITY_NAME))Health_Provider_Services.Fields.Make_V_CITY_NAME((SALT29.StrType)le.Input_V_CITY_NAME);
  #ELSE
(TYPEOF(SELF.V_CITY_NAME))'';
  #END
    SELF.ST :=   #IF (#TEXT(Input_ST)<>'')
(TYPEOF(SELF.ST))Health_Provider_Services.Fields.Make_ST((SALT29.StrType)le.Input_ST);
  #ELSE
(TYPEOF(SELF.ST))'';
  #END
    SELF.ZIP :=   #IF (#TEXT(Input_ZIP)<>'')
(TYPEOF(SELF.ZIP))Health_Provider_Services.Fields.Make_ZIP((SALT29.StrType)le.Input_ZIP);
  #ELSE
(TYPEOF(SELF.ZIP))'';
  #END
    SELF.SSN :=   #IF (#TEXT(Input_SSN)<>'')
(TYPEOF(SELF.SSN))Health_Provider_Services.Fields.Make_SSN((SALT29.StrType)le.Input_SSN);
  #ELSE
(TYPEOF(SELF.SSN))'';
  #END
    SELF.CNSMR_SSN :=   #IF (#TEXT(Input_CNSMR_SSN)<>'')
(TYPEOF(SELF.CNSMR_SSN))Health_Provider_Services.Fields.Make_CNSMR_SSN((SALT29.StrType)le.Input_CNSMR_SSN);
  #ELSE
(TYPEOF(SELF.CNSMR_SSN))'';
  #END
    SELF.DOB :=   #IF (#TEXT(Input_DOB)<>'')
(TYPEOF(SELF.DOB))Health_Provider_Services.Fields.Make_DOB((SALT29.StrType)le.Input_DOB);
  #ELSE
(TYPEOF(SELF.DOB))'';
  #END
    SELF.CNSMR_DOB :=   #IF (#TEXT(Input_CNSMR_DOB)<>'')
(TYPEOF(SELF.CNSMR_DOB))Health_Provider_Services.Fields.Make_CNSMR_DOB((SALT29.StrType)le.Input_CNSMR_DOB);
  #ELSE
(TYPEOF(SELF.CNSMR_DOB))'';
  #END
    SELF.PHONE :=   #IF (#TEXT(Input_PHONE)<>'')
(TYPEOF(SELF.PHONE))Health_Provider_Services.Fields.Make_PHONE((SALT29.StrType)le.Input_PHONE);
  #ELSE
(TYPEOF(SELF.PHONE))'';
  #END
    SELF.LIC_STATE :=   #IF (#TEXT(Input_LIC_STATE)<>'')
(TYPEOF(SELF.LIC_STATE))Health_Provider_Services.Fields.Make_LIC_STATE((SALT29.StrType)le.Input_LIC_STATE);
  #ELSE
(TYPEOF(SELF.LIC_STATE))'';
  #END
    SELF.C_LIC_NBR :=   #IF (#TEXT(Input_C_LIC_NBR)<>'')
(TYPEOF(SELF.C_LIC_NBR))Health_Provider_Services.Fields.Make_C_LIC_NBR((SALT29.StrType)le.Input_C_LIC_NBR);
  #ELSE
(TYPEOF(SELF.C_LIC_NBR))'';
  #END
    SELF.TAX_ID :=   #IF (#TEXT(Input_TAX_ID)<>'')
(TYPEOF(SELF.TAX_ID))Health_Provider_Services.Fields.Make_TAX_ID((SALT29.StrType)le.Input_TAX_ID);
  #ELSE
(TYPEOF(SELF.TAX_ID))'';
  #END
    SELF.BILLING_TAX_ID :=   #IF (#TEXT(Input_BILLING_TAX_ID)<>'')
(TYPEOF(SELF.BILLING_TAX_ID))Health_Provider_Services.Fields.Make_BILLING_TAX_ID((SALT29.StrType)le.Input_BILLING_TAX_ID);
  #ELSE
(TYPEOF(SELF.BILLING_TAX_ID))'';
  #END
    SELF.DEA_NUMBER :=   #IF (#TEXT(Input_DEA_NUMBER)<>'')
(TYPEOF(SELF.DEA_NUMBER))Health_Provider_Services.Fields.Make_DEA_NUMBER((SALT29.StrType)le.Input_DEA_NUMBER);
  #ELSE
(TYPEOF(SELF.DEA_NUMBER))'';
  #END
    SELF.VENDOR_ID :=   #IF (#TEXT(Input_VENDOR_ID)<>'')
(TYPEOF(SELF.VENDOR_ID))Health_Provider_Services.Fields.Make_VENDOR_ID((SALT29.StrType)le.Input_VENDOR_ID);
  #ELSE
(TYPEOF(SELF.VENDOR_ID))'';
  #END
    SELF.NPI_NUMBER :=   #IF (#TEXT(Input_NPI_NUMBER)<>'')
(TYPEOF(SELF.NPI_NUMBER))Health_Provider_Services.Fields.Make_NPI_NUMBER((SALT29.StrType)le.Input_NPI_NUMBER);
  #ELSE
(TYPEOF(SELF.NPI_NUMBER))'';
  #END
    SELF.BILLING_NPI_NUMBER :=   #IF (#TEXT(Input_BILLING_NPI_NUMBER)<>'')
(TYPEOF(SELF.BILLING_NPI_NUMBER))Health_Provider_Services.Fields.Make_BILLING_NPI_NUMBER((SALT29.StrType)le.Input_BILLING_NPI_NUMBER);
  #ELSE
(TYPEOF(SELF.BILLING_NPI_NUMBER))'';
  #END
    SELF.UPIN :=   #IF (#TEXT(Input_UPIN)<>'')
(TYPEOF(SELF.UPIN))Health_Provider_Services.Fields.Make_UPIN((SALT29.StrType)le.Input_UPIN);
  #ELSE
(TYPEOF(SELF.UPIN))'';
  #END
    SELF.DID :=   #IF (#TEXT(Input_DID)<>'')
(TYPEOF(SELF.DID))Health_Provider_Services.Fields.Make_DID((SALT29.StrType)le.Input_DID);
  #ELSE
(TYPEOF(SELF.DID))'';
  #END
    SELF.BDID :=   #IF (#TEXT(Input_BDID)<>'')
(TYPEOF(SELF.BDID))Health_Provider_Services.Fields.Make_BDID((SALT29.StrType)le.Input_BDID);
  #ELSE
(TYPEOF(SELF.BDID))'';
  #END
    SELF.SRC :=   #IF (#TEXT(Input_SRC)<>'')
(TYPEOF(SELF.SRC))Health_Provider_Services.Fields.Make_SRC((SALT29.StrType)le.Input_SRC);
  #ELSE
(TYPEOF(SELF.SRC))'';
  #END
    SELF.SOURCE_RID :=   #IF (#TEXT(Input_SOURCE_RID)<>'')
(TYPEOF(SELF.SOURCE_RID))Health_Provider_Services.Fields.Make_SOURCE_RID((SALT29.StrType)le.Input_SOURCE_RID);
  #ELSE
(TYPEOF(SELF.SOURCE_RID))'';
  #END
    SELF.RID :=   #IF (#TEXT(Input_RID)<>'')
(TYPEOF(SELF.RID))Health_Provider_Services.Fields.Make_RID((SALT29.StrType)le.Input_RID);
  #ELSE
(TYPEOF(SELF.RID))'';
  #END
    SELF.MAINNAME :=   #IF (#TEXT(Input_MAINNAME)<>'')
(TYPEOF(SELF.MAINNAME))Health_Provider_Services.Fields.Make_MAINNAME((SALT29.StrType)le.Input_MAINNAME);
  #ELSE
(TYPEOF(SELF.MAINNAME))'';
  #END
    SELF.FULLNAME :=   #IF (#TEXT(Input_FULLNAME)<>'')
(TYPEOF(SELF.FULLNAME))Health_Provider_Services.Fields.Make_FULLNAME((SALT29.StrType)le.Input_FULLNAME);
  #ELSE
(TYPEOF(SELF.FULLNAME))'';
  #END
    SELF.ADDR1 :=   #IF (#TEXT(Input_ADDR1)<>'')
(TYPEOF(SELF.ADDR1))Health_Provider_Services.Fields.Make_ADDR1((SALT29.StrType)le.Input_ADDR1);
  #ELSE
(TYPEOF(SELF.ADDR1))'';
  #END
    SELF.LOCALE :=   #IF (#TEXT(Input_LOCALE)<>'')
(TYPEOF(SELF.LOCALE))Health_Provider_Services.Fields.Make_LOCALE((SALT29.StrType)le.Input_LOCALE);
  #ELSE
(TYPEOF(SELF.LOCALE))'';
  #END
    SELF.ADDRESS :=   #IF (#TEXT(Input_ADDRESS)<>'')
(TYPEOF(SELF.ADDRESS))Health_Provider_Services.Fields.Make_ADDRESS((SALT29.StrType)le.Input_ADDRESS);
  #ELSE
(TYPEOF(SELF.ADDRESS))'';
  #END
  END;
  #uniquename(fats0)
  %fats0% := PROJECT(InFile,%CleanT%(LEFT));
  #uniquename(fats)
  #uniquename(dups)
 // In case multiple copies of the same indicative are in there - remove them
  SALT29.MAC_Dups_Note(%fats0%,%TPRec%,%fats%,%dups%);
  %ToProcess% := %fats%;
  #uniquename(OutputNAMEL)
#IF(#TEXT(Input_LNAME)<>'' AND #TEXT(Input_ST)<>'' AND #TEXT(Input_C_LIC_NBR)<>'')
  #uniquename(HoldNAMEL)
  %HoldNAMEL% := %ToProcess%;
  Health_Provider_Services.Key_HealthProvider_NAMEL.MAC_ScoredFetch_Batch(%HoldNAMEL%,UniqueId,LNAME,ST,C_LIC_NBR,FNAME,GENDER,SNAME,MNAME,PRIM_RANGE,PRIM_NAME,SEC_RANGE,V_CITY_NAME,ZIP,DOB,LIC_STATE,NPI_NUMBER,BILLING_TAX_ID,%OutputNAMEL%,AsIndex)
#ELSE
  %OutputNAMEL% := DATASET([],Health_Provider_Services.Process_xLNPID_Layouts.LayoutScoredFetch);
#END
  #uniquename(OutputFNAME)
#IF(#TEXT(Input_LNAME)<>'' AND #TEXT(Input_ST)<>'')
  #uniquename(HoldFNAME)
  %HoldFNAME% := %ToProcess%(~Health_Provider_Services.Key_HealthProvider_NAMEL.CanSearch(ROW(%ToProcess%)));
  Health_Provider_Services.Key_HealthProvider_FNAME.MAC_ScoredFetch_Batch(%HoldFNAME%,UniqueId,LNAME,ST,FNAME,GENDER,SNAME,MNAME,PRIM_RANGE,PRIM_NAME,SEC_RANGE,V_CITY_NAME,ZIP,DOB,C_LIC_NBR,LIC_STATE,NPI_NUMBER,BILLING_TAX_ID,%OutputFNAME%,AsIndex)
#ELSE
  %OutputFNAME% := DATASET([],Health_Provider_Services.Process_xLNPID_Layouts.LayoutScoredFetch);
#END

  #uniquename(FOutputFNAME)
#IF(#TEXT(Input_LNAME)<>'' AND #TEXT(Input_ST)<>'')
  #uniquename(FHoldFNAME)
  %FHoldFNAME% := %ToProcess%(~Health_Provider_Services.Key_HealthProvider_NAMEL.CanSearch(ROW(%ToProcess%)));
  Health_Provider_Services.Key_HealthProvider_FNAME.MAC_ScoredFetch_Batch(%FHoldFNAME%,UniqueId,FNAME,ST,LNAME,GENDER,SNAME,MNAME,PRIM_RANGE,PRIM_NAME,SEC_RANGE,V_CITY_NAME,ZIP,DOB,C_LIC_NBR,LIC_STATE,NPI_NUMBER,BILLING_TAX_ID,%FOutputFNAME%,AsIndex)
#ELSE
  %FOutputFNAME% := DATASET([],Health_Provider_Services.Process_xLNPID_Layouts.LayoutScoredFetch);
#END

  #uniquename(OutputNAMED)
#IF(#TEXT(Input_LNAME)<>'' AND #TEXT(Input_ZIP)<>'' AND #TEXT(Input_C_LIC_NBR)<>'')
  #uniquename(HoldNAMED)
  %HoldNAMED% := %ToProcess%;
  Health_Provider_Services.Key_HealthProvider_NAMED.MAC_ScoredFetch_Batch(%HoldNAMED%,UniqueId,LNAME,ZIP,C_LIC_NBR,FNAME,GENDER,SNAME,MNAME,PRIM_RANGE,PRIM_NAME,SEC_RANGE,V_CITY_NAME,ST,DOB,LIC_STATE,NPI_NUMBER,BILLING_TAX_ID,%OutputNAMED%,AsIndex)
#ELSE
  %OutputNAMED% := DATASET([],Health_Provider_Services.Process_xLNPID_Layouts.LayoutScoredFetch);
#END
  #uniquename(OutputLNAME)
#IF(#TEXT(Input_LNAME)<>'' AND #TEXT(Input_ZIP)<>'')
  #uniquename(HoldLNAME)
  %HoldLNAME% := %ToProcess%(~Health_Provider_Services.Key_HealthProvider_NAMED.CanSearch(ROW(%ToProcess%)));
  Health_Provider_Services.Key_HealthProvider_LNAME.MAC_ScoredFetch_Batch(%HoldLNAME%,UniqueId,LNAME,ZIP,FNAME,GENDER,SNAME,MNAME,PRIM_RANGE,PRIM_NAME,SEC_RANGE,V_CITY_NAME,ST,DOB,C_LIC_NBR,LIC_STATE,NPI_NUMBER,BILLING_TAX_ID,%OutputLNAME%,AsIndex)
#ELSE
  %OutputLNAME% := DATASET([],Health_Provider_Services.Process_xLNPID_Layouts.LayoutScoredFetch);
#END
  #uniquename(OutputMNAME)
#IF(#TEXT(Input_LNAME)<>'' AND #TEXT(Input_MNAME)<>'' AND #TEXT(Input_ST)<>'')
  #uniquename(HoldMNAME)
  %HoldMNAME% := %ToProcess%;
  Health_Provider_Services.Key_HealthProvider_MNAME.MAC_ScoredFetch_Batch(%HoldMNAME%,UniqueId,LNAME,MNAME,ST,GENDER,SNAME,FNAME,PRIM_RANGE,PRIM_NAME,SEC_RANGE,V_CITY_NAME,ZIP,DOB,C_LIC_NBR,LIC_STATE,NPI_NUMBER,BILLING_TAX_ID,%OutputMNAME%,AsIndex)
#ELSE
  %OutputMNAME% := DATASET([],Health_Provider_Services.Process_xLNPID_Layouts.LayoutScoredFetch);
#END

  #uniquename(FOutputMNAME)
#IF(#TEXT(Input_LNAME)<>'' AND #TEXT(Input_MNAME)<>'' AND #TEXT(Input_ST)<>'')
  #uniquename(FHoldMNAME)
  %FHoldMNAME% := %ToProcess%;
  Health_Provider_Services.Key_HealthProvider_MNAME.MAC_ScoredFetch_Batch(%FHoldMNAME%,UniqueId,LNAME,FNAME,ST,GENDER,SNAME,MNAME,PRIM_RANGE,PRIM_NAME,SEC_RANGE,V_CITY_NAME,ZIP,DOB,C_LIC_NBR,LIC_STATE,NPI_NUMBER,BILLING_TAX_ID,%FOutputMNAME%,AsIndex)
#ELSE
  %FOutputMNAME% := DATASET([],Health_Provider_Services.Process_xLNPID_Layouts.LayoutScoredFetch);
#END

  #uniquename(OutputADDRESS)
#IF(#TEXT(Input_PRIM_RANGE)<>'' AND #TEXT(Input_PRIM_NAME)<>'' AND #TEXT(Input_ZIP)<>'')
  #uniquename(HoldADDRESS)
  %HoldADDRESS% := %ToProcess%;
  Health_Provider_Services.Key_HealthProvider_ADDRESS.MAC_ScoredFetch_Batch(%HoldADDRESS%,UniqueId,PRIM_RANGE,PRIM_NAME,ZIP,SEC_RANGE,FNAME,V_CITY_NAME,ST,GENDER,LNAME,MNAME,SNAME,DOB,C_LIC_NBR,LIC_STATE,BILLING_TAX_ID,%OutputADDRESS%,AsIndex)
#ELSE
  %OutputADDRESS% := DATASET([],Health_Provider_Services.Process_xLNPID_Layouts.LayoutScoredFetch);
#END
  #uniquename(OutputZIP_PR)
#IF(#TEXT(Input_PRIM_NAME)<>'' AND #TEXT(Input_ZIP)<>'')
  #uniquename(HoldZIP_PR)
  %HoldZIP_PR% := %ToProcess%;
  Health_Provider_Services.Key_HealthProvider_ZIP_PR.MAC_ScoredFetch_Batch(%HoldZIP_PR%,UniqueId,PRIM_NAME,ZIP,FNAME,PRIM_RANGE,SEC_RANGE,V_CITY_NAME,ST,GENDER,LNAME,MNAME,SNAME,DOB,C_LIC_NBR,LIC_STATE,BILLING_TAX_ID,%OutputZIP_PR%,AsIndex)
#ELSE
  %OutputZIP_PR% := DATASET([],Health_Provider_Services.Process_xLNPID_Layouts.LayoutScoredFetch);
#END
  #uniquename(OutputSSN_LP)
#IF(#TEXT(Input_SSN)<>'')
  #uniquename(HoldSSN_LP)
  %HoldSSN_LP% := %ToProcess%;
  Health_Provider_Services.Key_HealthProvider_SSN_LP.MAC_ScoredFetch_Batch(%HoldSSN_LP%,UniqueId,SSN,FNAME,MNAME,LNAME,V_CITY_NAME,ST,GENDER,SNAME,DOB,C_LIC_NBR,LIC_STATE,%OutputSSN_LP%,AsIndex)
#ELSE
  %OutputSSN_LP% := DATASET([],Health_Provider_Services.Process_xLNPID_Layouts.LayoutScoredFetch);
#END
  #uniquename(OutputCNSMR_SSN_LP)
#IF(#TEXT(Input_CNSMR_SSN)<>'')
  #uniquename(HoldCNSMR_SSN_LP)
  %HoldCNSMR_SSN_LP% := %ToProcess%;
  Health_Provider_Services.Key_HealthProvider_CNSMR_SSN_LP.MAC_ScoredFetch_Batch(%HoldCNSMR_SSN_LP%,UniqueId,CNSMR_SSN,FNAME,MNAME,LNAME,V_CITY_NAME,ST,GENDER,SNAME,CNSMR_DOB,%OutputCNSMR_SSN_LP%,AsIndex)
#ELSE
  %OutputCNSMR_SSN_LP% := DATASET([],Health_Provider_Services.Process_xLNPID_Layouts.LayoutScoredFetch);
#END
  #uniquename(OutputDOB_LP)
#IF(#TEXT(Input_DOB)<>'' AND #TEXT(Input_FNAME)<>'' AND #TEXT(Input_LNAME)<>'')
  #uniquename(HoldDOB_LP)
  %HoldDOB_LP% := %ToProcess%;
  Health_Provider_Services.Key_HealthProvider_DOB_LP.MAC_ScoredFetch_Batch(%HoldDOB_LP%,UniqueId,DOB,FNAME,LNAME,MNAME,ST,V_CITY_NAME,SSN,GENDER,SNAME,%OutputDOB_LP%,AsIndex)
#ELSE
  %OutputDOB_LP% := DATASET([],Health_Provider_Services.Process_xLNPID_Layouts.LayoutScoredFetch);
#END
  #uniquename(OutputCNSMR_DOB_LP)
#IF(#TEXT(Input_CNSMR_DOB)<>'' AND #TEXT(Input_FNAME)<>'' AND #TEXT(Input_LNAME)<>'')
  #uniquename(HoldCNSMR_DOB_LP)
  %HoldCNSMR_DOB_LP% := %ToProcess%;
  Health_Provider_Services.Key_HealthProvider_CNSMR_DOB_LP.MAC_ScoredFetch_Batch(%HoldCNSMR_DOB_LP%,UniqueId,CNSMR_DOB,FNAME,LNAME,MNAME,ST,V_CITY_NAME,CNSMR_SSN,GENDER,SNAME,%OutputCNSMR_DOB_LP%,AsIndex)
#ELSE
  %OutputCNSMR_DOB_LP% := DATASET([],Health_Provider_Services.Process_xLNPID_Layouts.LayoutScoredFetch);
#END
  #uniquename(OutputPHONE_LP)
#IF(#TEXT(Input_PHONE)<>'')
  #uniquename(HoldPHONE_LP)
  %HoldPHONE_LP% := %ToProcess%;
  Health_Provider_Services.Key_HealthProvider_PHONE_LP.MAC_ScoredFetch_Batch(%HoldPHONE_LP%,UniqueId,PHONE,FNAME,LNAME,DOB,MNAME,SNAME,V_CITY_NAME,ST,SSN,%OutputPHONE_LP%,AsIndex)
#ELSE
  %OutputPHONE_LP% := DATASET([],Health_Provider_Services.Process_xLNPID_Layouts.LayoutScoredFetch);
#END
  #uniquename(OutputLIC)
#IF(#TEXT(Input_C_LIC_NBR)<>'' AND #TEXT(Input_LIC_STATE)<>'')
  #uniquename(HoldLIC)
  %HoldLIC% := %ToProcess%;
  Health_Provider_Services.Key_HealthProvider_LIC.MAC_ScoredFetch_Batch(%HoldLIC%,UniqueId,C_LIC_NBR,LIC_STATE,FNAME,MNAME,LNAME,SSN,GENDER,SNAME,DOB,%OutputLIC%,AsIndex)
#ELSE
  %OutputLIC% := DATASET([],Health_Provider_Services.Process_xLNPID_Layouts.LayoutScoredFetch);
#END
  #uniquename(OutputVEN)
#IF(#TEXT(Input_VENDOR_ID)<>'' AND #TEXT(Input_SRC)<>'')
  #uniquename(HoldVEN)
  %HoldVEN% := %ToProcess%;
  Health_Provider_Services.Key_HealthProvider_VEN.MAC_ScoredFetch_Batch(%HoldVEN%,UniqueId,VENDOR_ID,SRC,FNAME,MNAME,LNAME,SNAME,GENDER,DOB,%OutputVEN%,AsIndex)
#ELSE
  %OutputVEN% := DATASET([],Health_Provider_Services.Process_xLNPID_Layouts.LayoutScoredFetch);
#END
  #uniquename(OutputTAX)
#IF(#TEXT(Input_TAX_ID)<>'')
  #uniquename(HoldTAX)
  %HoldTAX% := %ToProcess%;
  Health_Provider_Services.Key_HealthProvider_TAX.MAC_ScoredFetch_Batch(%HoldTAX%,UniqueId,TAX_ID,FNAME,MNAME,LNAME,SNAME,GENDER,DOB,C_LIC_NBR,LIC_STATE,%OutputTAX%,AsIndex)
#ELSE
  %OutputTAX% := DATASET([],Health_Provider_Services.Process_xLNPID_Layouts.LayoutScoredFetch);
#END
  #uniquename(OutputBILLING_TAX)
#IF(#TEXT(Input_BILLING_TAX_ID)<>'')
  #uniquename(HoldBILLING_TAX)
  %HoldBILLING_TAX% := %ToProcess%;
  Health_Provider_Services.Key_HealthProvider_BILLING_TAX.MAC_ScoredFetch_Batch(%HoldBILLING_TAX%,UniqueId,BILLING_TAX_ID,FNAME,MNAME,LNAME,SNAME,GENDER,DOB,C_LIC_NBR,LIC_STATE,%OutputBILLING_TAX%,AsIndex)
#ELSE
  %OutputBILLING_TAX% := DATASET([],Health_Provider_Services.Process_xLNPID_Layouts.LayoutScoredFetch);
#END
  #uniquename(OutputDEA)
#IF(#TEXT(Input_DEA_NUMBER)<>'')
  #uniquename(HoldDEA)
  %HoldDEA% := %ToProcess%;
  Health_Provider_Services.Key_HealthProvider_DEA.MAC_ScoredFetch_Batch(%HoldDEA%,UniqueId,DEA_NUMBER,FNAME,MNAME,LNAME,SNAME,GENDER,DOB,C_LIC_NBR,LIC_STATE,%OutputDEA%,AsIndex)
#ELSE
  %OutputDEA% := DATASET([],Health_Provider_Services.Process_xLNPID_Layouts.LayoutScoredFetch);
#END
  #uniquename(OutputNPI)
#IF(#TEXT(Input_NPI_NUMBER)<>'')
  #uniquename(HoldNPI)
  %HoldNPI% := %ToProcess%;
  Health_Provider_Services.Key_HealthProvider_NPI.MAC_ScoredFetch_Batch(%HoldNPI%,UniqueId,NPI_NUMBER,FNAME,MNAME,LNAME,SNAME,GENDER,DOB,C_LIC_NBR,LIC_STATE,%OutputNPI%,AsIndex)
#ELSE
  %OutputNPI% := DATASET([],Health_Provider_Services.Process_xLNPID_Layouts.LayoutScoredFetch);
#END
  #uniquename(OutputBILLING_NPI)
#IF(#TEXT(Input_BILLING_NPI_NUMBER)<>'')
  #uniquename(HoldBILLING_NPI)
  %HoldBILLING_NPI% := %ToProcess%;
  Health_Provider_Services.Key_HealthProvider_BILLING_NPI.MAC_ScoredFetch_Batch(%HoldBILLING_NPI%,UniqueId,BILLING_NPI_NUMBER,FNAME,MNAME,LNAME,SNAME,GENDER,DOB,%OutputBILLING_NPI%,AsIndex)
#ELSE
  %OutputBILLING_NPI% := DATASET([],Health_Provider_Services.Process_xLNPID_Layouts.LayoutScoredFetch);
#END
  #uniquename(OutputUPN)
#IF(#TEXT(Input_UPIN)<>'')
  #uniquename(HoldUPN)
  %HoldUPN% := %ToProcess%;
  Health_Provider_Services.Key_HealthProvider_UPN.MAC_ScoredFetch_Batch(%HoldUPN%,UniqueId,UPIN,FNAME,MNAME,LNAME,SNAME,GENDER,DOB,C_LIC_NBR,LIC_STATE,%OutputUPN%,AsIndex)
#ELSE
  %OutputUPN% := DATASET([],Health_Provider_Services.Process_xLNPID_Layouts.LayoutScoredFetch);
#END
  #uniquename(OutputLEXID)
#IF(#TEXT(Input_DID)<>'')
  #uniquename(HoldLEXID)
  %HoldLEXID% := %ToProcess%;
  Health_Provider_Services.Key_HealthProvider_LEXID.MAC_ScoredFetch_Batch(%HoldLEXID%,UniqueId,DID,FNAME,MNAME,LNAME,SNAME,GENDER,DOB,C_LIC_NBR,LIC_STATE,%OutputLEXID%,AsIndex)
#ELSE
  %OutputLEXID% := DATASET([],Health_Provider_Services.Process_xLNPID_Layouts.LayoutScoredFetch);
#END
  #uniquename(OutputBID)
#IF(#TEXT(Input_BDID)<>'')
  #uniquename(HoldBID)
  %HoldBID% := %ToProcess%;
  Health_Provider_Services.Key_HealthProvider_BID.MAC_ScoredFetch_Batch(%HoldBID%,UniqueId,BDID,FNAME,MNAME,LNAME,SNAME,GENDER,DOB,C_LIC_NBR,LIC_STATE,%OutputBID%,AsIndex)
#ELSE
  %OutputBID% := DATASET([],Health_Provider_Services.Process_xLNPID_Layouts.LayoutScoredFetch);
#END
  #uniquename(OutputSRC_RID)
#IF(#TEXT(Input_SOURCE_RID)<>'')
  #uniquename(HoldSRC_RID)
  %HoldSRC_RID% := %ToProcess%;
  Health_Provider_Services.Key_HealthProvider_SRC_RID.MAC_ScoredFetch_Batch(%HoldSRC_RID%,UniqueId,SOURCE_RID,SRC,FNAME,LNAME,DOB,V_CITY_NAME,ST,GENDER,MNAME,SNAME,%OutputSRC_RID%,AsIndex)
#ELSE
  %OutputSRC_RID% := DATASET([],Health_Provider_Services.Process_xLNPID_Layouts.LayoutScoredFetch);
#END
  #uniquename(OutputRID)
#IF(#TEXT(Input_RID)<>'')
  #uniquename(HoldRID)
  %HoldRID% := %ToProcess%;
  Health_Provider_Services.Key_HealthProvider_RID.MAC_ScoredFetch_Batch(%HoldRID%,UniqueId,RID,%OutputRID%,AsIndex)
#ELSE
  %OutputRID% := DATASET([],Health_Provider_Services.Process_xLNPID_Layouts.LayoutScoredFetch);
#END
  #uniquename(AllRes)
  %AllRes% := %OutputNAMEL%+%OutputFNAME%+%FOutputFNAME%+%OutputNAMED%+%OutputLNAME%+%OutputMNAME%+%FOutputMNAME%+%OutputADDRESS%+%OutputZIP_PR%+%OutputSSN_LP%+%OutputCNSMR_SSN_LP%+%OutputDOB_LP%+%OutputCNSMR_DOB_LP%+%OutputPHONE_LP%+%OutputLIC%+%OutputVEN%+%OutputTAX%+%OutputBILLING_TAX%+%OutputDEA%+%OutputNPI%+%OutputBILLING_NPI%+%OutputUPN%+%OutputLEXID%+%OutputBID%+%OutputSRC_RID%+%OutputRID%;
  #uniquename(All)
  %All% := Health_Provider_Services.Process_xLNPID_Layouts.CombineAllScores(%AllRes%);
  SALT29.MAC_Dups_Restore(%All%,%dups%,OutFile);
  #IF (#TEXT(Stats)<>'')
    Stats := Health_Provider_Services.Process_xLNPID_Layouts.ScoreSummary(OutFile);
  #END
ENDMACRO;
