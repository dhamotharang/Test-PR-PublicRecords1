 
EXPORT MAC_MEOW_xLNPID_Batch_InLayout(infile,OutFile,AsIndex = 'true',Stats = '',DoClean = 'true') := MACRO
  IMPORT SALT311,Health_Provider_Services;
  #UNIQUENAME(ToProcess)
  #UNIQUENAME(TPRec)
  %TPRec% := RECORD(Health_Provider_Services.Process_xLNPID_Layouts.InputLayout)
  END;
  #UNIQUENAME(infile_updateids)
  %infile_updateids% := PROJECT(infile, TRANSFORM(%TPRec%, SELF.Entered_LNPID := (TYPEOF(SELF.Entered_LNPID))'', SELF := LEFT));
  #UNIQUENAME(infile_clean)
  %infile_clean% := IF(DoClean, PROJECT(Health_Provider_Services.Process_xLNPID_Layouts.CleanInput(%infile_updateids%), %TPRec%), %infile_updateids%);
  #UNIQUENAME(fats)
  #UNIQUENAME(dups)
  // In case multiple copies of the same indicative are in there - remove them
  SALT311.MAC_Dups_Note(%infile_clean%,%TPRec%,%fats%,%dups%,,Health_Provider_Services.Config.meow_dedup);
  %ToProcess% := %fats%(Entered_LNPID = 0);
  #UNIQUENAME(OutputNAMEL)
  #IF(#TEXT(Input_LNAME)<>'' AND #TEXT(Input_ST)<>'' AND #TEXT(Input_C_LIC_NBR)<>'')
    #UNIQUENAME(HoldNAMEL)
    %HoldNAMEL% := %ToProcess%;
    Health_Provider_Services.Key_HealthProvider_NAMEL.MAC_ScoredFetch_Batch(%HoldNAMEL%,UniqueId,LNAME,ST,C_LIC_NBR,FNAME,GENDER,SNAME,MNAME,PRIM_RANGE,PRIM_NAME,SEC_RANGE,V_CITY_NAME,ZIP,DOB,LIC_STATE,NPI_NUMBER,BILLING_TAX_ID,%OutputNAMEL%,AsIndex)
  #ELSE
    %OutputNAMEL% := DATASET([],Health_Provider_Services.Process_xLNPID_Layouts.LayoutScoredFetch);
  #END
  #UNIQUENAME(OutputFNAME)
  #IF(#TEXT(Input_LNAME)<>'' AND #TEXT(Input_ST)<>'')
    #UNIQUENAME(HoldFNAME)
    %HoldFNAME% := %ToProcess%(~Health_Provider_Services.Key_HealthProvider_NAMEL.CanSearch(ROW(%ToProcess%)));
    Health_Provider_Services.Key_HealthProvider_FNAME.MAC_ScoredFetch_Batch(%HoldFNAME%,UniqueId,LNAME,ST,FNAME,GENDER,SNAME,MNAME,PRIM_RANGE,PRIM_NAME,SEC_RANGE,V_CITY_NAME,ZIP,DOB,C_LIC_NBR,LIC_STATE,NPI_NUMBER,BILLING_TAX_ID,%OutputFNAME%,AsIndex)
  #ELSE
    %OutputFNAME% := DATASET([],Health_Provider_Services.Process_xLNPID_Layouts.LayoutScoredFetch);
  #END
  #UNIQUENAME(OutputNAMEC)
  #IF(#TEXT(Input_LNAME)<>'' AND #TEXT(Input_ZIP)<>'' AND #TEXT(Input_C_LIC_NBR)<>'')
    #UNIQUENAME(HoldNAMEC)
    %HoldNAMEC% := %ToProcess%;
    Health_Provider_Services.Key_HealthProvider_NAMED.MAC_ScoredFetch_Batch(%HoldNAMEC%,UniqueId,LNAME,ZIP,C_LIC_NBR,FNAME,GENDER,SNAME,MNAME,PRIM_RANGE,PRIM_NAME,SEC_RANGE,V_CITY_NAME,ST,DOB,LIC_STATE,NPI_NUMBER,BILLING_TAX_ID,%OutputNAMEC%,AsIndex)
  #ELSE
    %OutputNAMEC% := DATASET([],Health_Provider_Services.Process_xLNPID_Layouts.LayoutScoredFetch);
  #END
  #UNIQUENAME(FOutputFNAME)
  #IF(#TEXT(Input_LNAME)<>'' AND #TEXT(Input_ST)<>'')
    #UNIQUENAME(FHoldFNAME)
    %FHoldFNAME% := %ToProcess%(~Health_Provider_Services.Key_HealthProvider_NAMEL.CanSearch(ROW(%ToProcess%)));
    Health_Provider_Services.Key_HealthProvider_FNAME.MAC_ScoredFetch_Batch(%FHoldFNAME%,UniqueId,FNAME,ST,LNAME,GENDER,SNAME,MNAME,PRIM_RANGE,PRIM_NAME,SEC_RANGE,V_CITY_NAME,ZIP,DOB,C_LIC_NBR,LIC_STATE,NPI_NUMBER,BILLING_TAX_ID,%FOutputFNAME%,AsIndex)
  #ELSE
    %FOutputFNAME% := DATASET([],Health_Provider_Services.Process_xLNPID_Layouts.LayoutScoredFetch);
  #END	
  #UNIQUENAME(OutputLNAME)
  #IF(#TEXT(Input_LNAME)<>'' AND #TEXT(Input_ZIP)<>'')
    #UNIQUENAME(HoldLNAME)
    %HoldLNAME% := %ToProcess%(~Health_Provider_Services.Key_HealthProvider_NAMED.CanSearch(ROW(%ToProcess%)));
    Health_Provider_Services.Key_HealthProvider_LNAME.MAC_ScoredFetch_Batch(%HoldLNAME%,UniqueId,LNAME,ZIP,FNAME,GENDER,SNAME,MNAME,PRIM_RANGE,PRIM_NAME,SEC_RANGE,V_CITY_NAME,ST,DOB,C_LIC_NBR,LIC_STATE,NPI_NUMBER,BILLING_TAX_ID,%OutputLNAME%,AsIndex)
  #ELSE
    %OutputLNAME% := DATASET([],Health_Provider_Services.Process_xLNPID_Layouts.LayoutScoredFetch);
  #END
  #UNIQUENAME(OutputMNAME)
  #IF(#TEXT(Input_LNAME)<>'' AND #TEXT(Input_MNAME)<>'' AND #TEXT(Input_ST)<>'')
    #UNIQUENAME(HoldMNAME)
    %HoldMNAME% := %ToProcess%;
    Health_Provider_Services.Key_HealthProvider_MNAME.MAC_ScoredFetch_Batch(%HoldMNAME%,UniqueId,LNAME,MNAME,ST,GENDER,SNAME,FNAME,PRIM_RANGE,PRIM_NAME,SEC_RANGE,V_CITY_NAME,ZIP,DOB,C_LIC_NBR,LIC_STATE,NPI_NUMBER,BILLING_TAX_ID,%OutputMNAME%,AsIndex)
  #ELSE
    %OutputMNAME% := DATASET([],Health_Provider_Services.Process_xLNPID_Layouts.LayoutScoredFetch);
  #END
 #UNIQUENAME(FOutputMNAME)
  #IF(#TEXT(Input_LNAME)<>'' AND #TEXT(Input_MNAME)<>'' AND #TEXT(Input_ST)<>'')
    #UNIQUENAME(FHoldMNAME)
    %FHoldMNAME% := %ToProcess%;
    Health_Provider_Services.Key_HealthProvider_MNAME.MAC_ScoredFetch_Batch(%FHoldMNAME%,UniqueId,LNAME,FNAME,ST,GENDER,SNAME,MNAME,PRIM_RANGE,PRIM_NAME,SEC_RANGE,V_CITY_NAME,ZIP,DOB,C_LIC_NBR,LIC_STATE,NPI_NUMBER,BILLING_TAX_ID,%FOutputMNAME%,AsIndex)
  #ELSE
    %FOutputMNAME% := DATASET([],Health_Provider_Services.Process_xLNPID_Layouts.LayoutScoredFetch);
  #END	
	#UNIQUENAME(OutputADDRESS)
  #IF(#TEXT(Input_PRIM_RANGE)<>'' AND #TEXT(Input_PRIM_NAME)<>'' AND #TEXT(Input_ZIP)<>'')
    #UNIQUENAME(HoldADDRESS)
    %HoldADDRESS% := %ToProcess%;
    Health_Provider_Services.Key_HealthProvider_ADDRESS.MAC_ScoredFetch_Batch(%HoldADDRESS%,UniqueId,PRIM_RANGE,PRIM_NAME,ZIP,SEC_RANGE,FNAME,V_CITY_NAME,ST,GENDER,LNAME,MNAME,SNAME,DOB,C_LIC_NBR,LIC_STATE,BILLING_TAX_ID,%OutputADDRESS%,AsIndex)
  #ELSE
    %OutputADDRESS% := DATASET([],Health_Provider_Services.Process_xLNPID_Layouts.LayoutScoredFetch);
  #END
  #UNIQUENAME(OutputZIP_PR)
  #IF(#TEXT(Input_PRIM_NAME)<>'' AND #TEXT(Input_ZIP)<>'')
    #UNIQUENAME(HoldZIP_PR)
    %HoldZIP_PR% := %ToProcess%;
    Health_Provider_Services.Key_HealthProvider_ZIP_PR.MAC_ScoredFetch_Batch(%HoldZIP_PR%,UniqueId,PRIM_NAME,ZIP,FNAME,PRIM_RANGE,SEC_RANGE,V_CITY_NAME,ST,GENDER,LNAME,MNAME,SNAME,DOB,C_LIC_NBR,LIC_STATE,BILLING_TAX_ID,%OutputZIP_PR%,AsIndex)
  #ELSE
    %OutputZIP_PR% := DATASET([],Health_Provider_Services.Process_xLNPID_Layouts.LayoutScoredFetch);
  #END
  #UNIQUENAME(OutputSSN_LP)
  #IF(#TEXT(Input_SSN)<>'')
    #UNIQUENAME(HoldSSN_LP)
    %HoldSSN_LP% := %ToProcess%;
    Health_Provider_Services.Key_HealthProvider_SSN_LP.MAC_ScoredFetch_Batch(%HoldSSN_LP%,UniqueId,SSN,FNAME,MNAME,LNAME,V_CITY_NAME,ST,GENDER,SNAME,DOB,C_LIC_NBR,LIC_STATE,%OutputSSN_LP%,AsIndex)
  #ELSE
    %OutputSSN_LP% := DATASET([],Health_Provider_Services.Process_xLNPID_Layouts.LayoutScoredFetch);
  #END
  #UNIQUENAME(OutputCNSMR_SSN_LP)
  #IF(#TEXT(Input_CNSMR_SSN)<>'')
    #UNIQUENAME(HoldCNSMR_SSN_LP)
    %HoldCNSMR_SSN_LP% := %ToProcess%;
    Health_Provider_Services.Key_HealthProvider_CNSMR_SSN_LP.MAC_ScoredFetch_Batch(%HoldCNSMR_SSN_LP%,UniqueId,CNSMR_SSN,FNAME,MNAME,LNAME,V_CITY_NAME,ST,GENDER,SNAME,CNSMR_DOB,C_LIC_NBR,LIC_STATE,%OutputCNSMR_SSN_LP%,AsIndex)
  #ELSE
    %OutputCNSMR_SSN_LP% := DATASET([],Health_Provider_Services.Process_xLNPID_Layouts.LayoutScoredFetch);
  #END
  #UNIQUENAME(OutputDOB_LP)
  #IF(#TEXT(Input_DOB)<>'' AND #TEXT(Input_FNAME)<>'' AND #TEXT(Input_LNAME)<>'')
    #UNIQUENAME(HoldDOB_LP)
    %HoldDOB_LP% := %ToProcess%;
    Health_Provider_Services.Key_HealthProvider_DOB_LP.MAC_ScoredFetch_Batch(%HoldDOB_LP%,UniqueId,DOB,FNAME,LNAME,MNAME,ST,V_CITY_NAME,SSN,GENDER,SNAME,%OutputDOB_LP%,AsIndex)
  #ELSE
    %OutputDOB_LP% := DATASET([],Health_Provider_Services.Process_xLNPID_Layouts.LayoutScoredFetch);
  #END
  #UNIQUENAME(OutputCNSMR_DOB_LP)
  #IF(#TEXT(Input_CNSMR_DOB)<>'' AND #TEXT(Input_FNAME)<>'' AND #TEXT(Input_LNAME)<>'')
    #UNIQUENAME(HoldCNSMR_DOB_LP)
    %HoldCNSMR_DOB_LP% := %ToProcess%;
    Health_Provider_Services.Key_HealthProvider_CNSMR_DOB_LP.MAC_ScoredFetch_Batch(%HoldCNSMR_DOB_LP%,UniqueId,CNSMR_DOB,FNAME,LNAME,MNAME,ST,V_CITY_NAME,CNSMR_SSN,GENDER,SNAME,%OutputCNSMR_DOB_LP%,AsIndex)
  #ELSE
    %OutputCNSMR_DOB_LP% := DATASET([],Health_Provider_Services.Process_xLNPID_Layouts.LayoutScoredFetch);
  #END
  #UNIQUENAME(OutputPHONE_LP)
  #IF(#TEXT(Input_PHONE)<>'')
    #UNIQUENAME(HoldPHONE_LP)
    %HoldPHONE_LP% := %ToProcess%;
    Health_Provider_Services.Key_HealthProvider_PHONE_LP.MAC_ScoredFetch_Batch(%HoldPHONE_LP%,UniqueId,PHONE,FNAME,LNAME,DOB,MNAME,SNAME,V_CITY_NAME,ST,SSN,%OutputPHONE_LP%,AsIndex)
  #ELSE
    %OutputPHONE_LP% := DATASET([],Health_Provider_Services.Process_xLNPID_Layouts.LayoutScoredFetch);
  #END
  #UNIQUENAME(OutputLIC)
  #IF(#TEXT(Input_C_LIC_NBR)<>'' AND #TEXT(Input_LIC_STATE)<>'')
    #UNIQUENAME(HoldLIC)
    %HoldLIC% := %ToProcess%;
    Health_Provider_Services.Key_HealthProvider_LIC.MAC_ScoredFetch_Batch(%HoldLIC%,UniqueId,C_LIC_NBR,LIC_STATE,FNAME,MNAME,LNAME,SSN,GENDER,SNAME,DOB,%OutputLIC%,AsIndex)
  #ELSE
    %OutputLIC% := DATASET([],Health_Provider_Services.Process_xLNPID_Layouts.LayoutScoredFetch);
  #END
  #UNIQUENAME(OutputVEN)
  #IF(#TEXT(Input_VENDOR_ID)<>'' AND #TEXT(Input_SRC)<>'')
    #UNIQUENAME(HoldVEN)
    %HoldVEN% := %ToProcess%;
    Health_Provider_Services.Key_HealthProvider_VEN.MAC_ScoredFetch_Batch(%HoldVEN%,UniqueId,VENDOR_ID,SRC,FNAME,MNAME,LNAME,SNAME,GENDER,DOB,%OutputVEN%,AsIndex)
  #ELSE
    %OutputVEN% := DATASET([],Health_Provider_Services.Process_xLNPID_Layouts.LayoutScoredFetch);
  #END
  #UNIQUENAME(OutputTAX)
  #IF(#TEXT(Input_TAX_ID)<>'')
    #UNIQUENAME(HoldTAX)
    %HoldTAX% := %ToProcess%;
    Health_Provider_Services.Key_HealthProvider_TAX.MAC_ScoredFetch_Batch(%HoldTAX%,UniqueId,TAX_ID,FNAME,MNAME,LNAME,SNAME,GENDER,DOB,C_LIC_NBR,LIC_STATE,%OutputTAX%,AsIndex)
  #ELSE
    %OutputTAX% := DATASET([],Health_Provider_Services.Process_xLNPID_Layouts.LayoutScoredFetch);
  #END
  #UNIQUENAME(OutputBILLING_TAX)
  #IF(#TEXT(Input_BILLING_TAX_ID)<>'')
    #UNIQUENAME(HoldBILLING_TAX)
    %HoldBILLING_TAX% := %ToProcess%;
    Health_Provider_Services.Key_HealthProvider_BILLING_TAX.MAC_ScoredFetch_Batch(%HoldBILLING_TAX%,UniqueId,BILLING_TAX_ID,FNAME,MNAME,LNAME,SNAME,GENDER,DOB,C_LIC_NBR,LIC_STATE,%OutputBILLING_TAX%,AsIndex)
  #ELSE
    %OutputBILLING_TAX% := DATASET([],Health_Provider_Services.Process_xLNPID_Layouts.LayoutScoredFetch);
  #END
  #UNIQUENAME(OutputDEA)
  #IF(#TEXT(Input_DEA_NUMBER)<>'')
    #UNIQUENAME(HoldDEA)
    %HoldDEA% := %ToProcess%;
    Health_Provider_Services.Key_HealthProvider_DEA.MAC_ScoredFetch_Batch(%HoldDEA%,UniqueId,DEA_NUMBER,FNAME,MNAME,LNAME,SNAME,GENDER,DOB,C_LIC_NBR,LIC_STATE,%OutputDEA%,AsIndex)
  #ELSE
    %OutputDEA% := DATASET([],Health_Provider_Services.Process_xLNPID_Layouts.LayoutScoredFetch);
  #END
  #UNIQUENAME(OutputNPI)
  #IF(#TEXT(Input_NPI_NUMBER)<>'')
    #UNIQUENAME(HoldNPI)
    %HoldNPI% := %ToProcess%;
    Health_Provider_Services.Key_HealthProvider_NPI.MAC_ScoredFetch_Batch(%HoldNPI%,UniqueId,NPI_NUMBER,FNAME,MNAME,LNAME,SNAME,GENDER,DOB,C_LIC_NBR,LIC_STATE,%OutputNPI%,AsIndex)
  #ELSE
    %OutputNPI% := DATASET([],Health_Provider_Services.Process_xLNPID_Layouts.LayoutScoredFetch);
  #END
  #UNIQUENAME(OutputBILLING_NPI)
  #IF(#TEXT(Input_BILLING_NPI_NUMBER)<>'')
    #UNIQUENAME(HoldBILLING_NPI)
    %HoldBILLING_NPI% := %ToProcess%;
    Health_Provider_Services.Key_HealthProvider_BILLING_NPI.MAC_ScoredFetch_Batch(%HoldBILLING_NPI%,UniqueId,BILLING_NPI_NUMBER,FNAME,MNAME,LNAME,SNAME,GENDER,DOB,C_LIC_NBR,LIC_STATE,%OutputBILLING_NPI%,AsIndex)
  #ELSE
    %OutputBILLING_NPI% := DATASET([],Health_Provider_Services.Process_xLNPID_Layouts.LayoutScoredFetch);
  #END
  #UNIQUENAME(OutputUPN)
  #IF(#TEXT(Input_UPIN)<>'')
    #UNIQUENAME(HoldUPN)
    %HoldUPN% := %ToProcess%;
    Health_Provider_Services.Key_HealthProvider_UPN.MAC_ScoredFetch_Batch(%HoldUPN%,UniqueId,UPIN,FNAME,MNAME,LNAME,SNAME,GENDER,DOB,C_LIC_NBR,LIC_STATE,%OutputUPN%,AsIndex)
  #ELSE
    %OutputUPN% := DATASET([],Health_Provider_Services.Process_xLNPID_Layouts.LayoutScoredFetch);
  #END
  #UNIQUENAME(OutputLEXID)
  #IF(#TEXT(Input_DID)<>'')
    #UNIQUENAME(HoldLEXID)
    %HoldLEXID% := %ToProcess%;
    Health_Provider_Services.Key_HealthProvider_LEXID.MAC_ScoredFetch_Batch(%HoldLEXID%,UniqueId,DID,FNAME,MNAME,LNAME,SNAME,GENDER,DOB,C_LIC_NBR,LIC_STATE,%OutputLEXID%,AsIndex)
  #ELSE
    %OutputLEXID% := DATASET([],Health_Provider_Services.Process_xLNPID_Layouts.LayoutScoredFetch);
  #END
  #UNIQUENAME(OutputBID)
  #IF(#TEXT(Input_BDID)<>'')
    #UNIQUENAME(HoldBID)
    %HoldBID% := %ToProcess%;
    Health_Provider_Services.Key_HealthProvider_BID.MAC_ScoredFetch_Batch(%HoldBID%,UniqueId,BDID,FNAME,MNAME,LNAME,SNAME,GENDER,DOB,C_LIC_NBR,LIC_STATE,%OutputBID%,AsIndex)
  #ELSE
    %OutputBID% := DATASET([],Health_Provider_Services.Process_xLNPID_Layouts.LayoutScoredFetch);
  #END
  #UNIQUENAME(OutputSRC_RID)
  #IF(#TEXT(Input_SOURCE_RID)<>'')
    #UNIQUENAME(HoldSRC_RID)
    %HoldSRC_RID% := %ToProcess%;
    Health_Provider_Services.Key_HealthProvider_SRC_RID.MAC_ScoredFetch_Batch(%HoldSRC_RID%,UniqueId,SOURCE_RID,SRC,FNAME,LNAME,DOB,V_CITY_NAME,ST,GENDER,MNAME,SNAME,%OutputSRC_RID%,AsIndex)
  #ELSE
    %OutputSRC_RID% := DATASET([],Health_Provider_Services.Process_xLNPID_Layouts.LayoutScoredFetch);
  #END
  #UNIQUENAME(OutputRID)
  #IF(#TEXT(Input_RID)<>'')
    #UNIQUENAME(HoldRID)
    %HoldRID% := %ToProcess%;
    Health_Provider_Services.Key_HealthProvider_RID.MAC_ScoredFetch_Batch(%HoldRID%,UniqueId,RID,%OutputRID%,AsIndex)
  #ELSE
    %OutputRID% := DATASET([],Health_Provider_Services.Process_xLNPID_Layouts.LayoutScoredFetch);
  #END
  #UNIQUENAME(AllRes)
	%AllRes% := %OutputNAMEL%+%OutputFNAME%+%FOutputFNAME%+%OutputNAMEC%+%OutputLNAME%+%OutputMNAME%+%FOutputMNAME%+%OutputADDRESS%+%OutputZIP_PR%+%OutputSSN_LP%+%OutputCNSMR_SSN_LP%+%OutputDOB_LP%+%OutputCNSMR_DOB_LP%+%OutputPHONE_LP%+%OutputLIC%+%OutputVEN%+%OutputTAX%+%OutputBILLING_TAX%+%OutputDEA%+%OutputNPI%+%OutputBILLING_NPI%+%OutputUPN%+%OutputLEXID%+%OutputBID%+%OutputSRC_RID%+%OutputRID%;
  #UNIQUENAME(All)
  %All% := Health_Provider_Services.Process_xLNPID_Layouts.CombineAllScores(%AllRes%);
  #UNIQUENAME(OutFile0)
  SALT311.MAC_Dups_Restore(%All%,%dups%,%OutFile0%);
  #UNIQUENAME(RestoreChildReference)
  TYPEOF(%OutFile0%) %RestoreChildReference%(%OutFile0% le) := TRANSFORM
    SELF.Results := PROJECT(le.Results, TRANSFORM(Health_Provider_Services.Process_xLNPID_Layouts.LayoutScoredFetch,SELF.Reference := le.Reference, SELF := LEFT));
    SELF := le;
  END;
  OutFile := PROJECT(%OutFile0%,%RestoreChildReference%(LEFT));
  #IF (#TEXT(Stats)<>'')
    Stats := Health_Provider_Services.Process_xLNPID_Layouts.ScoreSummary(OutFile);
  #END
ENDMACRO;
