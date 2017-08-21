EXPORT MAC_MEOW_xLNPID_Batch(infile,Ref='',Input_CNAME = '',Input_CNP_NAME = '',Input_CNP_NUMBER = '',Input_CNP_STORE_NUMBER = '',Input_CNP_BTYPE = '',Input_CNP_LOWV = '',Input_PRIM_RANGE = '',Input_PRIM_NAME = '',Input_SEC_RANGE = '',Input_V_CITY_NAME = '',Input_ST = '',Input_ZIP = '',Input_TAX_ID = '',Input_FEIN = '',Input_PHONE = '',Input_FAX = '',Input_LIC_STATE = '',Input_C_LIC_NBR = '',Input_DEA_NUMBER = '',Input_VENDOR_ID = '',Input_NPI_NUMBER = '',Input_CLIA_NUMBER = '',Input_MEDICARE_FACILITY_NUMBER = '',Input_MEDICAID_NUMBER = '',Input_NCPDP_NUMBER = '',Input_TAXONOMY = '',Input_TAXONOMY_CODE = '',Input_BDID = '',Input_SRC = '',Input_SOURCE_RID = '',Input_FAC_NAME = '',Input_ADDR1 = '',Input_LOCALE = '',Input_ADDRES = '',OutFile,AsIndex='true',Stats='') := MACRO
  #uniquename(ToProcess)
  IMPORT SALT29,PRTE_Health_Facility_Services;
  #uniquename(TPRec)
  %TPRec% := RECORD(PRTE_Health_Facility_Services.Process_xLNPID_Layouts.InputLayout)
  STRING240 CNP_NAME_wb := ''; // Expanded wordbag field
  END;
  #uniquename(CleanT) // Transform to clean input data identically to online transform
  %TPRec% %CleanT%(InFile le) := TRANSFORM
    SELF.UniqueId := le.ref;
    SELF.CNAME :=   #IF (#TEXT(Input_CNAME)<>'')
(TYPEOF(SELF.CNAME))PRTE_Health_Facility_Services.Fields.Make_CNAME((SALT29.StrType)le.Input_CNAME);
  #ELSE
(TYPEOF(SELF.CNAME))'';
  #END
    SELF.CNP_NAME :=   #IF (#TEXT(Input_CNP_NAME)<>'')
(TYPEOF(SELF.CNP_NAME))PRTE_Health_Facility_Services.Fields.Make_CNP_NAME((SALT29.StrType)le.Input_CNP_NAME);
  #ELSE
(TYPEOF(SELF.CNP_NAME))'';
  #END
    SELF.CNP_NUMBER :=   #IF (#TEXT(Input_CNP_NUMBER)<>'')
(TYPEOF(SELF.CNP_NUMBER))PRTE_Health_Facility_Services.Fields.Make_CNP_NUMBER((SALT29.StrType)le.Input_CNP_NUMBER);
  #ELSE
(TYPEOF(SELF.CNP_NUMBER))'';
  #END
    SELF.CNP_STORE_NUMBER :=   #IF (#TEXT(Input_CNP_STORE_NUMBER)<>'')
(TYPEOF(SELF.CNP_STORE_NUMBER))PRTE_Health_Facility_Services.Fields.Make_CNP_STORE_NUMBER((SALT29.StrType)le.Input_CNP_STORE_NUMBER);
  #ELSE
(TYPEOF(SELF.CNP_STORE_NUMBER))'';
  #END
    SELF.CNP_BTYPE :=   #IF (#TEXT(Input_CNP_BTYPE)<>'')
(TYPEOF(SELF.CNP_BTYPE))PRTE_Health_Facility_Services.Fields.Make_CNP_BTYPE((SALT29.StrType)le.Input_CNP_BTYPE);
  #ELSE
(TYPEOF(SELF.CNP_BTYPE))'';
  #END
    SELF.CNP_LOWV :=   #IF (#TEXT(Input_CNP_LOWV)<>'')
(TYPEOF(SELF.CNP_LOWV))PRTE_Health_Facility_Services.Fields.Make_CNP_LOWV((SALT29.StrType)le.Input_CNP_LOWV);
  #ELSE
(TYPEOF(SELF.CNP_LOWV))'';
  #END
    SELF.PRIM_RANGE :=   #IF (#TEXT(Input_PRIM_RANGE)<>'')
(TYPEOF(SELF.PRIM_RANGE))le.Input_PRIM_RANGE;
  #ELSE
(TYPEOF(SELF.PRIM_RANGE))'';
  #END
    SELF.PRIM_NAME :=   #IF (#TEXT(Input_PRIM_NAME)<>'')
(TYPEOF(SELF.PRIM_NAME))le.Input_PRIM_NAME;
  #ELSE
(TYPEOF(SELF.PRIM_NAME))'';
  #END
    SELF.SEC_RANGE :=   #IF (#TEXT(Input_SEC_RANGE)<>'')
(TYPEOF(SELF.SEC_RANGE))le.Input_SEC_RANGE;
  #ELSE
(TYPEOF(SELF.SEC_RANGE))'';
  #END
    SELF.V_CITY_NAME :=   #IF (#TEXT(Input_V_CITY_NAME)<>'')
(TYPEOF(SELF.V_CITY_NAME))le.Input_V_CITY_NAME;
  #ELSE
(TYPEOF(SELF.V_CITY_NAME))'';
  #END
    SELF.ST :=   #IF (#TEXT(Input_ST)<>'')
(TYPEOF(SELF.ST))le.Input_ST;
  #ELSE
(TYPEOF(SELF.ST))'';
  #END
    SELF.ZIP :=   #IF (#TEXT(Input_ZIP)<>'')
(TYPEOF(SELF.ZIP))le.Input_ZIP;
  #ELSE
(TYPEOF(SELF.ZIP))'';
  #END
    SELF.TAX_ID :=   #IF (#TEXT(Input_TAX_ID)<>'')
(TYPEOF(SELF.TAX_ID))le.Input_TAX_ID;
  #ELSE
(TYPEOF(SELF.TAX_ID))'';
  #END
    SELF.FEIN :=   #IF (#TEXT(Input_FEIN)<>'')
(TYPEOF(SELF.FEIN))le.Input_FEIN;
  #ELSE
(TYPEOF(SELF.FEIN))'';
  #END
    SELF.PHONE :=   #IF (#TEXT(Input_PHONE)<>'')
(TYPEOF(SELF.PHONE))PRTE_Health_Facility_Services.Fields.Make_PHONE((SALT29.StrType)le.Input_PHONE);
  #ELSE
(TYPEOF(SELF.PHONE))'';
  #END
    SELF.FAX :=   #IF (#TEXT(Input_FAX)<>'')
(TYPEOF(SELF.FAX))PRTE_Health_Facility_Services.Fields.Make_FAX((SALT29.StrType)le.Input_FAX);
  #ELSE
(TYPEOF(SELF.FAX))'';
  #END
    SELF.LIC_STATE :=   #IF (#TEXT(Input_LIC_STATE)<>'')
(TYPEOF(SELF.LIC_STATE))PRTE_Health_Facility_Services.Fields.Make_LIC_STATE((SALT29.StrType)le.Input_LIC_STATE);
  #ELSE
(TYPEOF(SELF.LIC_STATE))'';
  #END
    SELF.C_LIC_NBR :=   #IF (#TEXT(Input_C_LIC_NBR)<>'')
(TYPEOF(SELF.C_LIC_NBR))PRTE_Health_Facility_Services.Fields.Make_C_LIC_NBR((SALT29.StrType)le.Input_C_LIC_NBR);
  #ELSE
(TYPEOF(SELF.C_LIC_NBR))'';
  #END
    SELF.DEA_NUMBER :=   #IF (#TEXT(Input_DEA_NUMBER)<>'')
(TYPEOF(SELF.DEA_NUMBER))PRTE_Health_Facility_Services.Fields.Make_DEA_NUMBER((SALT29.StrType)le.Input_DEA_NUMBER);
  #ELSE
(TYPEOF(SELF.DEA_NUMBER))'';
  #END
    SELF.VENDOR_ID :=   #IF (#TEXT(Input_VENDOR_ID)<>'')
(TYPEOF(SELF.VENDOR_ID))PRTE_Health_Facility_Services.Fields.Make_VENDOR_ID((SALT29.StrType)le.Input_VENDOR_ID);
  #ELSE
(TYPEOF(SELF.VENDOR_ID))'';
  #END
    SELF.NPI_NUMBER :=   #IF (#TEXT(Input_NPI_NUMBER)<>'')
(TYPEOF(SELF.NPI_NUMBER))PRTE_Health_Facility_Services.Fields.Make_NPI_NUMBER((SALT29.StrType)le.Input_NPI_NUMBER);
  #ELSE
(TYPEOF(SELF.NPI_NUMBER))'';
  #END
    SELF.CLIA_NUMBER :=   #IF (#TEXT(Input_CLIA_NUMBER)<>'')
(TYPEOF(SELF.CLIA_NUMBER))PRTE_Health_Facility_Services.Fields.Make_CLIA_NUMBER((SALT29.StrType)le.Input_CLIA_NUMBER);
  #ELSE
(TYPEOF(SELF.CLIA_NUMBER))'';
  #END
    SELF.MEDICARE_FACILITY_NUMBER :=   #IF (#TEXT(Input_MEDICARE_FACILITY_NUMBER)<>'')
(TYPEOF(SELF.MEDICARE_FACILITY_NUMBER))PRTE_Health_Facility_Services.Fields.Make_MEDICARE_FACILITY_NUMBER((SALT29.StrType)le.Input_MEDICARE_FACILITY_NUMBER);
  #ELSE
(TYPEOF(SELF.MEDICARE_FACILITY_NUMBER))'';
  #END
    SELF.MEDICAID_NUMBER :=   #IF (#TEXT(Input_MEDICAID_NUMBER)<>'')
(TYPEOF(SELF.MEDICAID_NUMBER))PRTE_Health_Facility_Services.Fields.Make_MEDICAID_NUMBER((SALT29.StrType)le.Input_MEDICAID_NUMBER);
  #ELSE
(TYPEOF(SELF.MEDICAID_NUMBER))'';
  #END
    SELF.NCPDP_NUMBER :=   #IF (#TEXT(Input_NCPDP_NUMBER)<>'')
(TYPEOF(SELF.NCPDP_NUMBER))PRTE_Health_Facility_Services.Fields.Make_NCPDP_NUMBER((SALT29.StrType)le.Input_NCPDP_NUMBER);
  #ELSE
(TYPEOF(SELF.NCPDP_NUMBER))'';
  #END
    SELF.TAXONOMY :=   #IF (#TEXT(Input_TAXONOMY)<>'')
(TYPEOF(SELF.TAXONOMY))PRTE_Health_Facility_Services.Fields.Make_TAXONOMY((SALT29.StrType)le.Input_TAXONOMY);
  #ELSE
(TYPEOF(SELF.TAXONOMY))'';
  #END
    SELF.TAXONOMY_CODE :=   #IF (#TEXT(Input_TAXONOMY_CODE)<>'')
(TYPEOF(SELF.TAXONOMY_CODE))PRTE_Health_Facility_Services.Fields.Make_TAXONOMY_CODE((SALT29.StrType)le.Input_TAXONOMY_CODE);
  #ELSE
(TYPEOF(SELF.TAXONOMY_CODE))'';
  #END
    SELF.BDID :=   #IF (#TEXT(Input_BDID)<>'')
(TYPEOF(SELF.BDID))PRTE_Health_Facility_Services.Fields.Make_BDID((SALT29.StrType)le.Input_BDID);
  #ELSE
(TYPEOF(SELF.BDID))'';
  #END
    SELF.SRC :=   #IF (#TEXT(Input_SRC)<>'')
(TYPEOF(SELF.SRC))PRTE_Health_Facility_Services.Fields.Make_SRC((SALT29.StrType)le.Input_SRC);
  #ELSE
(TYPEOF(SELF.SRC))'';
  #END
    SELF.SOURCE_RID :=   #IF (#TEXT(Input_SOURCE_RID)<>'')
(TYPEOF(SELF.SOURCE_RID))PRTE_Health_Facility_Services.Fields.Make_SOURCE_RID((SALT29.StrType)le.Input_SOURCE_RID);
  #ELSE
(TYPEOF(SELF.SOURCE_RID))'';
  #END
    SELF.FAC_NAME :=   #IF (#TEXT(Input_FAC_NAME)<>'')
(TYPEOF(SELF.FAC_NAME))PRTE_Health_Facility_Services.Fields.Make_FAC_NAME((SALT29.StrType)le.Input_FAC_NAME);
  #ELSE
(TYPEOF(SELF.FAC_NAME))'';
  #END
    SELF.ADDR1 :=   #IF (#TEXT(Input_ADDR1)<>'')
(TYPEOF(SELF.ADDR1))PRTE_Health_Facility_Services.Fields.Make_ADDR1((SALT29.StrType)le.Input_ADDR1);
  #ELSE
(TYPEOF(SELF.ADDR1))'';
  #END
    SELF.LOCALE :=   #IF (#TEXT(Input_LOCALE)<>'')
(TYPEOF(SELF.LOCALE))PRTE_Health_Facility_Services.Fields.Make_LOCALE((SALT29.StrType)le.Input_LOCALE);
  #ELSE
(TYPEOF(SELF.LOCALE))'';
  #END
    SELF.ADDRES :=   #IF (#TEXT(Input_ADDRES)<>'')
(TYPEOF(SELF.ADDRES))PRTE_Health_Facility_Services.Fields.Make_ADDRES((SALT29.StrType)le.Input_ADDRES);
  #ELSE
(TYPEOF(SELF.ADDRES))'';
  #END
  END;
  #uniquename(fats0)
  %fats0% := PROJECT(InFile,%CleanT%(LEFT));
  #uniquename(fats)
  #uniquename(dups)
 // In case multiple copies of the same indicative are in there - remove them
  SALT29.MAC_Dups_Note(%fats0%,%TPRec%,%fats%,%dups%);
  #uniquename(key_CNP_NAME)
  %key_CNP_NAME% := PRTE_Health_Facility_Services.specificities(PRTE_Health_Facility_Services.file_HealthFacility).CNP_NAME_values_key;
  #uniquename(A_CNP_NAME)
  %A_CNP_NAME% := SALT29.mac_wordbag_appendspecs_th(%fats%,CNP_NAME,CNP_NAME_wb,%key_CNP_NAME%,CNP_NAME,AsIndex);
  %ToProcess% := %A_CNP_NAME%;
  #uniquename(OutputZBNAME)
#IF(#TEXT(Input_CNP_NAME)<>'' AND #TEXT(Input_ZIP)<>'')
  #uniquename(HoldZBNAME)
  %HoldZBNAME% := %ToProcess%;
  PRTE_Health_Facility_Services.Key_HealthFacility_ZBNAME.MAC_ScoredFetch_Batch(%HoldZBNAME%,UniqueId,CNP_NAME_wb,ZIP,PRIM_NAME,ST,V_CITY_NAME,CNP_NUMBER,CNP_STORE_NUMBER,CNP_BTYPE,CNP_LOWV,PRIM_RANGE,SEC_RANGE,TAXONOMY,TAXONOMY_CODE,%OutputZBNAME%,AsIndex)
#ELSE
  %OutputZBNAME% := DATASET([],PRTE_Health_Facility_Services.Process_xLNPID_Layouts.LayoutScoredFetch);
#END
  #uniquename(OutputBNAME)
#IF(#TEXT(Input_CNP_NAME)<>'')
  #uniquename(HoldBNAME)
  %HoldBNAME% := %ToProcess%(~PRTE_Health_Facility_Services.Key_HealthFacility_ZBNAME.CanSearch(ROW(%ToProcess%)));
  PRTE_Health_Facility_Services.Key_HealthFacility_BNAME.MAC_ScoredFetch_Batch(%HoldBNAME%,UniqueId,CNP_NAME_wb,PRIM_NAME,ST,V_CITY_NAME,CNP_NUMBER,CNP_STORE_NUMBER,CNP_BTYPE,CNP_LOWV,PRIM_RANGE,SEC_RANGE,ZIP,TAXONOMY,TAXONOMY_CODE,%OutputBNAME%,AsIndex)
#ELSE
  %OutputBNAME% := DATASET([],PRTE_Health_Facility_Services.Process_xLNPID_Layouts.LayoutScoredFetch);
#END
  #uniquename(OutputSBNAME)
#IF(#TEXT(Input_CNP_NAME)<>'' AND #TEXT(Input_ST)<>'')
  #uniquename(HoldSBNAME)
  %HoldSBNAME% := %ToProcess%;
  PRTE_Health_Facility_Services.Key_HealthFacility_SBNAME.MAC_ScoredFetch_Batch(%HoldSBNAME%,UniqueId,CNP_NAME_wb,ST,PRIM_NAME,ZIP,V_CITY_NAME,CNP_NUMBER,CNP_STORE_NUMBER,CNP_BTYPE,CNP_LOWV,PRIM_RANGE,SEC_RANGE,TAXONOMY,TAXONOMY_CODE,%OutputSBNAME%,AsIndex)
#ELSE
  %OutputSBNAME% := DATASET([],PRTE_Health_Facility_Services.Process_xLNPID_Layouts.LayoutScoredFetch);
#END
  #uniquename(OutputADDRESS)
#IF(#TEXT(Input_PRIM_NAME)<>'' AND #TEXT(Input_PRIM_RANGE)<>'' AND #TEXT(Input_ZIP)<>'')
  #uniquename(HoldADDRESS)
  %HoldADDRESS% := %ToProcess%;
  PRTE_Health_Facility_Services.Key_HealthFacility_ADDRESS.MAC_ScoredFetch_Batch(%HoldADDRESS%,UniqueId,PRIM_NAME,PRIM_RANGE,ZIP,V_CITY_NAME,ST,SEC_RANGE,CNP_NAME_wb,CNP_NUMBER,CNP_STORE_NUMBER,CNP_BTYPE,CNP_LOWV,TAXONOMY,TAXONOMY_CODE,%OutputADDRESS%,AsIndex)
#ELSE
  %OutputADDRESS% := DATASET([],PRTE_Health_Facility_Services.Process_xLNPID_Layouts.LayoutScoredFetch);
#END
  #uniquename(OutputZIP_LP)
#IF(#TEXT(Input_PRIM_NAME)<>'' AND #TEXT(Input_ZIP)<>'')
  #uniquename(HoldZIP_LP)
  %HoldZIP_LP% := %ToProcess%;
  PRTE_Health_Facility_Services.Key_HealthFacility_ZIP_LP.MAC_ScoredFetch_Batch(%HoldZIP_LP%,UniqueId,PRIM_NAME,ZIP,PRIM_RANGE,ST,SEC_RANGE,V_CITY_NAME,CNP_NAME_wb,CNP_NUMBER,CNP_STORE_NUMBER,CNP_BTYPE,CNP_LOWV,TAXONOMY,TAXONOMY_CODE,%OutputZIP_LP%,AsIndex)
#ELSE
  %OutputZIP_LP% := DATASET([],PRTE_Health_Facility_Services.Process_xLNPID_Layouts.LayoutScoredFetch);
#END
  #uniquename(OutputCITY_LP)
#IF(#TEXT(Input_PRIM_NAME)<>'' AND #TEXT(Input_V_CITY_NAME)<>'' AND #TEXT(Input_ST)<>'')
  #uniquename(HoldCITY_LP)
  %HoldCITY_LP% := %ToProcess%;
  PRTE_Health_Facility_Services.Key_HealthFacility_CITY_LP.MAC_ScoredFetch_Batch(%HoldCITY_LP%,UniqueId,PRIM_NAME,V_CITY_NAME,ST,PRIM_RANGE,ZIP,SEC_RANGE,CNP_NAME_wb,CNP_NUMBER,CNP_STORE_NUMBER,CNP_BTYPE,CNP_LOWV,TAXONOMY,TAXONOMY_CODE,%OutputCITY_LP%,AsIndex)
#ELSE
  %OutputCITY_LP% := DATASET([],PRTE_Health_Facility_Services.Process_xLNPID_Layouts.LayoutScoredFetch);
#END
  #uniquename(OutputPHONE_LP)
#IF(#TEXT(Input_PHONE)<>'')
  #uniquename(HoldPHONE_LP)
  %HoldPHONE_LP% := %ToProcess%;
  PRTE_Health_Facility_Services.Key_HealthFacility_PHONE_LP.MAC_ScoredFetch_Batch(%HoldPHONE_LP%,UniqueId,PHONE,CNP_NAME_wb,CNP_NUMBER,CNP_STORE_NUMBER,CNP_BTYPE,CNP_LOWV,PRIM_RANGE,SEC_RANGE,PRIM_NAME,V_CITY_NAME,ST,ZIP,TAXONOMY,TAXONOMY_CODE,%OutputPHONE_LP%,AsIndex)
#ELSE
  %OutputPHONE_LP% := DATASET([],PRTE_Health_Facility_Services.Process_xLNPID_Layouts.LayoutScoredFetch);
#END
  #uniquename(OutputFAX_LP)
#IF(#TEXT(Input_FAX)<>'')
  #uniquename(HoldFAX_LP)
  %HoldFAX_LP% := %ToProcess%;
  PRTE_Health_Facility_Services.Key_HealthFacility_FAX_LP.MAC_ScoredFetch_Batch(%HoldFAX_LP%,UniqueId,FAX,CNP_NAME_wb,CNP_NUMBER,CNP_STORE_NUMBER,CNP_BTYPE,CNP_LOWV,PRIM_RANGE,SEC_RANGE,PRIM_NAME,V_CITY_NAME,ST,ZIP,TAXONOMY,TAXONOMY_CODE,%OutputFAX_LP%,AsIndex)
#ELSE
  %OutputFAX_LP% := DATASET([],PRTE_Health_Facility_Services.Process_xLNPID_Layouts.LayoutScoredFetch);
#END
  #uniquename(OutputLIC)
#IF(#TEXT(Input_C_LIC_NBR)<>'')
  #uniquename(HoldLIC)
  %HoldLIC% := %ToProcess%;
  PRTE_Health_Facility_Services.Key_HealthFacility_LIC.MAC_ScoredFetch_Batch(%HoldLIC%,UniqueId,C_LIC_NBR,LIC_STATE,CNP_NAME_wb,CNP_NUMBER,CNP_STORE_NUMBER,CNP_BTYPE,CNP_LOWV,PRIM_RANGE,SEC_RANGE,PRIM_NAME,V_CITY_NAME,ST,ZIP,TAXONOMY,TAXONOMY_CODE,%OutputLIC%,AsIndex)
#ELSE
  %OutputLIC% := DATASET([],PRTE_Health_Facility_Services.Process_xLNPID_Layouts.LayoutScoredFetch);
#END
  #uniquename(OutputVEN)
#IF(#TEXT(Input_VENDOR_ID)<>'')
  #uniquename(HoldVEN)
  %HoldVEN% := %ToProcess%;
  PRTE_Health_Facility_Services.Key_HealthFacility_VEN.MAC_ScoredFetch_Batch(%HoldVEN%,UniqueId,VENDOR_ID,SRC,CNP_NAME_wb,CNP_NUMBER,CNP_STORE_NUMBER,CNP_BTYPE,CNP_LOWV,PRIM_RANGE,SEC_RANGE,PRIM_NAME,V_CITY_NAME,ST,ZIP,TAXONOMY,TAXONOMY_CODE,%OutputVEN%,AsIndex)
#ELSE
  %OutputVEN% := DATASET([],PRTE_Health_Facility_Services.Process_xLNPID_Layouts.LayoutScoredFetch);
#END
  #uniquename(OutputTAX)
#IF(#TEXT(Input_TAX_ID)<>'')
  #uniquename(HoldTAX)
  %HoldTAX% := %ToProcess%;
  PRTE_Health_Facility_Services.Key_HealthFacility_TAX.MAC_ScoredFetch_Batch(%HoldTAX%,UniqueId,TAX_ID,CNP_NAME_wb,CNP_NUMBER,CNP_STORE_NUMBER,CNP_BTYPE,CNP_LOWV,PRIM_RANGE,SEC_RANGE,PRIM_NAME,V_CITY_NAME,ST,ZIP,TAXONOMY,TAXONOMY_CODE,%OutputTAX%,AsIndex)
#ELSE
  %OutputTAX% := DATASET([],PRTE_Health_Facility_Services.Process_xLNPID_Layouts.LayoutScoredFetch);
#END
  #uniquename(OutputFEN)
#IF(#TEXT(Input_FEIN)<>'')
  #uniquename(HoldFEN)
  %HoldFEN% := %ToProcess%;
  PRTE_Health_Facility_Services.Key_HealthFacility_FEN.MAC_ScoredFetch_Batch(%HoldFEN%,UniqueId,FEIN,CNP_NAME_wb,CNP_NUMBER,CNP_STORE_NUMBER,CNP_BTYPE,CNP_LOWV,PRIM_RANGE,SEC_RANGE,PRIM_NAME,V_CITY_NAME,ST,ZIP,TAXONOMY,TAXONOMY_CODE,%OutputFEN%,AsIndex)
#ELSE
  %OutputFEN% := DATASET([],PRTE_Health_Facility_Services.Process_xLNPID_Layouts.LayoutScoredFetch);
#END
  #uniquename(OutputDEA)
#IF(#TEXT(Input_DEA_NUMBER)<>'')
  #uniquename(HoldDEA)
  %HoldDEA% := %ToProcess%;
  PRTE_Health_Facility_Services.Key_HealthFacility_DEA.MAC_ScoredFetch_Batch(%HoldDEA%,UniqueId,DEA_NUMBER,CNP_NAME_wb,CNP_NUMBER,CNP_STORE_NUMBER,CNP_BTYPE,CNP_LOWV,PRIM_RANGE,SEC_RANGE,PRIM_NAME,V_CITY_NAME,ST,ZIP,TAXONOMY,TAXONOMY_CODE,%OutputDEA%,AsIndex)
#ELSE
  %OutputDEA% := DATASET([],PRTE_Health_Facility_Services.Process_xLNPID_Layouts.LayoutScoredFetch);
#END
  #uniquename(OutputNPI)
#IF(#TEXT(Input_NPI_NUMBER)<>'')
  #uniquename(HoldNPI)
  %HoldNPI% := %ToProcess%;
  PRTE_Health_Facility_Services.Key_HealthFacility_NPI.MAC_ScoredFetch_Batch(%HoldNPI%,UniqueId,NPI_NUMBER,CNP_NAME_wb,CNP_NUMBER,CNP_STORE_NUMBER,CNP_BTYPE,CNP_LOWV,PRIM_RANGE,SEC_RANGE,PRIM_NAME,V_CITY_NAME,ST,ZIP,TAXONOMY,TAXONOMY_CODE,%OutputNPI%,AsIndex)
#ELSE
  %OutputNPI% := DATASET([],PRTE_Health_Facility_Services.Process_xLNPID_Layouts.LayoutScoredFetch);
#END
  #uniquename(OutputADDR_NPI)
#IF(#TEXT(Input_NPI_NUMBER)<>'')
  #uniquename(HoldADDR_NPI)
  %HoldADDR_NPI% := %ToProcess%;
  PRTE_Health_Facility_Services.Key_HealthFacility_ADDR_NPI.MAC_ScoredFetch_Batch(%HoldADDR_NPI%,UniqueId,NPI_NUMBER,ST,PRIM_RANGE,SEC_RANGE,PRIM_NAME,ZIP,V_CITY_NAME,CNP_NAME_wb,CNP_NUMBER,CNP_STORE_NUMBER,CNP_BTYPE,CNP_LOWV,TAXONOMY,TAXONOMY_CODE,%OutputADDR_NPI%,AsIndex)
#ELSE
  %OutputADDR_NPI% := DATASET([],PRTE_Health_Facility_Services.Process_xLNPID_Layouts.LayoutScoredFetch);
#END
  #uniquename(OutputCLIA)
#IF(#TEXT(Input_CLIA_NUMBER)<>'')
  #uniquename(HoldCLIA)
  %HoldCLIA% := %ToProcess%;
  PRTE_Health_Facility_Services.Key_HealthFacility_CLIA.MAC_ScoredFetch_Batch(%HoldCLIA%,UniqueId,CLIA_NUMBER,CNP_NAME_wb,CNP_NUMBER,CNP_STORE_NUMBER,CNP_BTYPE,CNP_LOWV,PRIM_RANGE,SEC_RANGE,PRIM_NAME,V_CITY_NAME,ST,ZIP,TAXONOMY,TAXONOMY_CODE,%OutputCLIA%,AsIndex)
#ELSE
  %OutputCLIA% := DATASET([],PRTE_Health_Facility_Services.Process_xLNPID_Layouts.LayoutScoredFetch);
#END
  #uniquename(OutputMEDICARE)
#IF(#TEXT(Input_MEDICARE_FACILITY_NUMBER)<>'')
  #uniquename(HoldMEDICARE)
  %HoldMEDICARE% := %ToProcess%;
  PRTE_Health_Facility_Services.Key_HealthFacility_MEDICARE.MAC_ScoredFetch_Batch(%HoldMEDICARE%,UniqueId,MEDICARE_FACILITY_NUMBER,CNP_NAME_wb,CNP_NUMBER,CNP_STORE_NUMBER,CNP_BTYPE,CNP_LOWV,PRIM_RANGE,SEC_RANGE,PRIM_NAME,V_CITY_NAME,ST,ZIP,TAXONOMY,TAXONOMY_CODE,%OutputMEDICARE%,AsIndex)
#ELSE
  %OutputMEDICARE% := DATASET([],PRTE_Health_Facility_Services.Process_xLNPID_Layouts.LayoutScoredFetch);
#END
  #uniquename(OutputMEDICAID)
#IF(#TEXT(Input_MEDICAID_NUMBER)<>'')
  #uniquename(HoldMEDICAID)
  %HoldMEDICAID% := %ToProcess%;
  PRTE_Health_Facility_Services.Key_HealthFacility_MEDICAID.MAC_ScoredFetch_Batch(%HoldMEDICAID%,UniqueId,MEDICAID_NUMBER,CNP_NAME_wb,CNP_NUMBER,CNP_STORE_NUMBER,CNP_BTYPE,CNP_LOWV,PRIM_RANGE,SEC_RANGE,PRIM_NAME,V_CITY_NAME,ST,ZIP,TAXONOMY,TAXONOMY_CODE,%OutputMEDICAID%,AsIndex)
#ELSE
  %OutputMEDICAID% := DATASET([],PRTE_Health_Facility_Services.Process_xLNPID_Layouts.LayoutScoredFetch);
#END
  #uniquename(OutputNCPDP)
#IF(#TEXT(Input_NCPDP_NUMBER)<>'')
  #uniquename(HoldNCPDP)
  %HoldNCPDP% := %ToProcess%;
  PRTE_Health_Facility_Services.Key_HealthFacility_NCPDP.MAC_ScoredFetch_Batch(%HoldNCPDP%,UniqueId,NCPDP_NUMBER,CNP_NAME_wb,CNP_NUMBER,CNP_STORE_NUMBER,CNP_BTYPE,CNP_LOWV,PRIM_RANGE,SEC_RANGE,PRIM_NAME,V_CITY_NAME,ST,ZIP,TAXONOMY,TAXONOMY_CODE,%OutputNCPDP%,AsIndex)
#ELSE
  %OutputNCPDP% := DATASET([],PRTE_Health_Facility_Services.Process_xLNPID_Layouts.LayoutScoredFetch);
#END
  #uniquename(OutputBID)
#IF(#TEXT(Input_BDID)<>'')
  #uniquename(HoldBID)
  %HoldBID% := %ToProcess%;
  PRTE_Health_Facility_Services.Key_HealthFacility_BID.MAC_ScoredFetch_Batch(%HoldBID%,UniqueId,BDID,CNP_NAME_wb,CNP_NUMBER,CNP_STORE_NUMBER,CNP_BTYPE,CNP_LOWV,PRIM_RANGE,SEC_RANGE,PRIM_NAME,V_CITY_NAME,ST,ZIP,TAXONOMY,TAXONOMY_CODE,%OutputBID%,AsIndex)
#ELSE
  %OutputBID% := DATASET([],PRTE_Health_Facility_Services.Process_xLNPID_Layouts.LayoutScoredFetch);
#END
  #uniquename(AllRes)
  %AllRes% := %OutputZBNAME%+%OutputBNAME%+%OutputSBNAME%+%OutputADDRESS%+%OutputZIP_LP%+%OutputCITY_LP%+%OutputPHONE_LP%+%OutputFAX_LP%+%OutputLIC%+%OutputVEN%+%OutputTAX%+%OutputFEN%+%OutputDEA%+%OutputNPI%+%OutputADDR_NPI%+%OutputCLIA%+%OutputMEDICARE%+%OutputMEDICAID%+%OutputNCPDP%+%OutputBID%;
  #uniquename(All)
  %All% := PRTE_Health_Facility_Services.Process_xLNPID_Layouts.CombineAllScores(%AllRes%);
  SALT29.MAC_Dups_Restore(%All%,%dups%,OutFile);
  #IF (#TEXT(Stats)<>'')
    Stats := PRTE_Health_Facility_Services.Process_xLNPID_Layouts.ScoreSummary(OutFile);
  #END
ENDMACRO;
