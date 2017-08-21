EXPORT MAC_MEOW_xLNPID_Online(infile,Ref='',Input_CNAME = '',Input_CNP_NAME = '',Input_CNP_NUMBER = '',Input_CNP_STORE_NUMBER = '',Input_CNP_BTYPE = '',Input_CNP_LOWV = '',Input_PRIM_RANGE = '',Input_PRIM_NAME = '',Input_SEC_RANGE = '',Input_V_CITY_NAME = '',Input_ST = '',Input_ZIP = '',Input_TAX_ID = '',Input_FEIN = '',Input_PHONE = '',Input_FAX = '',Input_LIC_STATE = '',Input_C_LIC_NBR = '',Input_DEA_NUMBER = '',Input_VENDOR_ID = '',Input_NPI_NUMBER = '',Input_CLIA_NUMBER = '',Input_MEDICARE_FACILITY_NUMBER = '',Input_MEDICAID_NUMBER = '',Input_NCPDP_NUMBER = '',Input_TAXONOMY = '',Input_TAXONOMY_CODE = '',Input_BDID = '',Input_SRC = '',Input_SOURCE_RID = '',Input_FAC_NAME = '',Input_ADDR1 = '',Input_LOCALE = '',Input_ADDRES = '',OutFile,Stats='',In_MaxIds=50,In_LeadThreshold=0) := MACRO
  IMPORT SALT29,PRTE_Health_Facility_Services;
  ServiceModule := 'PRTE_Health_Facility_Services.';
#uniquename(into)
PRTE_Health_Facility_Services.Process_xLNPID_Layouts.InputLayout %into%(infile le) := TRANSFORM
  SELF.UniqueId := le.Ref;
  SELF.MaxIds := In_MaxIds;
  SELF.LeadThreshold := In_LeadThreshold;
  #IF ( #TEXT(Input_CNAME) <> '' )
    SELF.CNAME := (TYPEOF(SELF.CNAME))le.Input_CNAME;
  #ELSE
    SELF.CNAME := (TYPEOF(SELF.CNAME))'';
  #END
  #IF ( #TEXT(Input_CNP_NAME) <> '' )
    SELF.CNP_NAME := (TYPEOF(SELF.CNP_NAME))le.Input_CNP_NAME;
  #ELSE
    SELF.CNP_NAME := (TYPEOF(SELF.CNP_NAME))'';
  #END
  #IF ( #TEXT(Input_CNP_NUMBER) <> '' )
    SELF.CNP_NUMBER := (TYPEOF(SELF.CNP_NUMBER))le.Input_CNP_NUMBER;
  #ELSE
    SELF.CNP_NUMBER := (TYPEOF(SELF.CNP_NUMBER))'';
  #END
  #IF ( #TEXT(Input_CNP_STORE_NUMBER) <> '' )
    SELF.CNP_STORE_NUMBER := (TYPEOF(SELF.CNP_STORE_NUMBER))le.Input_CNP_STORE_NUMBER;
  #ELSE
    SELF.CNP_STORE_NUMBER := (TYPEOF(SELF.CNP_STORE_NUMBER))'';
  #END
  #IF ( #TEXT(Input_CNP_BTYPE) <> '' )
    SELF.CNP_BTYPE := (TYPEOF(SELF.CNP_BTYPE))le.Input_CNP_BTYPE;
  #ELSE
    SELF.CNP_BTYPE := (TYPEOF(SELF.CNP_BTYPE))'';
  #END
  #IF ( #TEXT(Input_CNP_LOWV) <> '' )
    SELF.CNP_LOWV := (TYPEOF(SELF.CNP_LOWV))le.Input_CNP_LOWV;
  #ELSE
    SELF.CNP_LOWV := (TYPEOF(SELF.CNP_LOWV))'';
  #END
  #IF ( #TEXT(Input_PRIM_RANGE) <> '' )
    SELF.PRIM_RANGE := (TYPEOF(SELF.PRIM_RANGE))le.Input_PRIM_RANGE;
  #ELSE
    SELF.PRIM_RANGE := (TYPEOF(SELF.PRIM_RANGE))'';
  #END
  #IF ( #TEXT(Input_PRIM_NAME) <> '' )
    SELF.PRIM_NAME := (TYPEOF(SELF.PRIM_NAME))le.Input_PRIM_NAME;
  #ELSE
    SELF.PRIM_NAME := (TYPEOF(SELF.PRIM_NAME))'';
  #END
  #IF ( #TEXT(Input_SEC_RANGE) <> '' )
    SELF.SEC_RANGE := (TYPEOF(SELF.SEC_RANGE))le.Input_SEC_RANGE;
  #ELSE
    SELF.SEC_RANGE := (TYPEOF(SELF.SEC_RANGE))'';
  #END
  #IF ( #TEXT(Input_V_CITY_NAME) <> '' )
    SELF.V_CITY_NAME := (TYPEOF(SELF.V_CITY_NAME))le.Input_V_CITY_NAME;
  #ELSE
    SELF.V_CITY_NAME := (TYPEOF(SELF.V_CITY_NAME))'';
  #END
  #IF ( #TEXT(Input_ST) <> '' )
    SELF.ST := (TYPEOF(SELF.ST))le.Input_ST;
  #ELSE
    SELF.ST := (TYPEOF(SELF.ST))'';
  #END
  #IF ( #TEXT(Input_ZIP) <> '' )
    SELF.ZIP := (TYPEOF(SELF.ZIP))le.Input_ZIP;
  #ELSE
    SELF.ZIP := (TYPEOF(SELF.ZIP))'';
  #END
  #IF ( #TEXT(Input_TAX_ID) <> '' )
    SELF.TAX_ID := (TYPEOF(SELF.TAX_ID))le.Input_TAX_ID;
  #ELSE
    SELF.TAX_ID := (TYPEOF(SELF.TAX_ID))'';
  #END
  #IF ( #TEXT(Input_FEIN) <> '' )
    SELF.FEIN := (TYPEOF(SELF.FEIN))le.Input_FEIN;
  #ELSE
    SELF.FEIN := (TYPEOF(SELF.FEIN))'';
  #END
  #IF ( #TEXT(Input_PHONE) <> '' )
    SELF.PHONE := (TYPEOF(SELF.PHONE))le.Input_PHONE;
  #ELSE
    SELF.PHONE := (TYPEOF(SELF.PHONE))'';
  #END
  #IF ( #TEXT(Input_FAX) <> '' )
    SELF.FAX := (TYPEOF(SELF.FAX))le.Input_FAX;
  #ELSE
    SELF.FAX := (TYPEOF(SELF.FAX))'';
  #END
  #IF ( #TEXT(Input_LIC_STATE) <> '' )
    SELF.LIC_STATE := (TYPEOF(SELF.LIC_STATE))le.Input_LIC_STATE;
  #ELSE
    SELF.LIC_STATE := (TYPEOF(SELF.LIC_STATE))'';
  #END
  #IF ( #TEXT(Input_C_LIC_NBR) <> '' )
    SELF.C_LIC_NBR := (TYPEOF(SELF.C_LIC_NBR))le.Input_C_LIC_NBR;
  #ELSE
    SELF.C_LIC_NBR := (TYPEOF(SELF.C_LIC_NBR))'';
  #END
  #IF ( #TEXT(Input_DEA_NUMBER) <> '' )
    SELF.DEA_NUMBER := (TYPEOF(SELF.DEA_NUMBER))le.Input_DEA_NUMBER;
  #ELSE
    SELF.DEA_NUMBER := (TYPEOF(SELF.DEA_NUMBER))'';
  #END
  #IF ( #TEXT(Input_VENDOR_ID) <> '' )
    SELF.VENDOR_ID := (TYPEOF(SELF.VENDOR_ID))le.Input_VENDOR_ID;
  #ELSE
    SELF.VENDOR_ID := (TYPEOF(SELF.VENDOR_ID))'';
  #END
  #IF ( #TEXT(Input_NPI_NUMBER) <> '' )
    SELF.NPI_NUMBER := (TYPEOF(SELF.NPI_NUMBER))le.Input_NPI_NUMBER;
  #ELSE
    SELF.NPI_NUMBER := (TYPEOF(SELF.NPI_NUMBER))'';
  #END
  #IF ( #TEXT(Input_CLIA_NUMBER) <> '' )
    SELF.CLIA_NUMBER := (TYPEOF(SELF.CLIA_NUMBER))le.Input_CLIA_NUMBER;
  #ELSE
    SELF.CLIA_NUMBER := (TYPEOF(SELF.CLIA_NUMBER))'';
  #END
  #IF ( #TEXT(Input_MEDICARE_FACILITY_NUMBER) <> '' )
    SELF.MEDICARE_FACILITY_NUMBER := (TYPEOF(SELF.MEDICARE_FACILITY_NUMBER))le.Input_MEDICARE_FACILITY_NUMBER;
  #ELSE
    SELF.MEDICARE_FACILITY_NUMBER := (TYPEOF(SELF.MEDICARE_FACILITY_NUMBER))'';
  #END
  #IF ( #TEXT(Input_MEDICAID_NUMBER) <> '' )
    SELF.MEDICAID_NUMBER := (TYPEOF(SELF.MEDICAID_NUMBER))le.Input_MEDICAID_NUMBER;
  #ELSE
    SELF.MEDICAID_NUMBER := (TYPEOF(SELF.MEDICAID_NUMBER))'';
  #END
  #IF ( #TEXT(Input_NCPDP_NUMBER) <> '' )
    SELF.NCPDP_NUMBER := (TYPEOF(SELF.NCPDP_NUMBER))le.Input_NCPDP_NUMBER;
  #ELSE
    SELF.NCPDP_NUMBER := (TYPEOF(SELF.NCPDP_NUMBER))'';
  #END
  #IF ( #TEXT(Input_TAXONOMY) <> '' )
    SELF.TAXONOMY := (TYPEOF(SELF.TAXONOMY))le.Input_TAXONOMY;
  #ELSE
    SELF.TAXONOMY := (TYPEOF(SELF.TAXONOMY))'';
  #END
  #IF ( #TEXT(Input_TAXONOMY_CODE) <> '' )
    SELF.TAXONOMY_CODE := (TYPEOF(SELF.TAXONOMY_CODE))le.Input_TAXONOMY_CODE;
  #ELSE
    SELF.TAXONOMY_CODE := (TYPEOF(SELF.TAXONOMY_CODE))'';
  #END
  #IF ( #TEXT(Input_BDID) <> '' )
    SELF.BDID := (TYPEOF(SELF.BDID))le.Input_BDID;
  #ELSE
    SELF.BDID := (TYPEOF(SELF.BDID))'';
  #END
  #IF ( #TEXT(Input_SRC) <> '' )
    SELF.SRC := (TYPEOF(SELF.SRC))le.Input_SRC;
  #ELSE
    SELF.SRC := (TYPEOF(SELF.SRC))'';
  #END
  #IF ( #TEXT(Input_SOURCE_RID) <> '' )
    SELF.SOURCE_RID := (TYPEOF(SELF.SOURCE_RID))le.Input_SOURCE_RID;
  #ELSE
    SELF.SOURCE_RID := (TYPEOF(SELF.SOURCE_RID))'';
  #END
  #IF ( #TEXT(Input_FAC_NAME) <> '' )
    SELF.FAC_NAME := (TYPEOF(SELF.FAC_NAME))le.Input_FAC_NAME;
  #ELSE
    SELF.FAC_NAME := (TYPEOF(SELF.FAC_NAME))'';
  #END
  #IF ( #TEXT(Input_ADDR1) <> '' )
    SELF.ADDR1 := (TYPEOF(SELF.ADDR1))le.Input_ADDR1;
  #ELSE
    SELF.ADDR1 := (TYPEOF(SELF.ADDR1))'';
  #END
  #IF ( #TEXT(Input_LOCALE) <> '' )
    SELF.LOCALE := (TYPEOF(SELF.LOCALE))le.Input_LOCALE;
  #ELSE
    SELF.LOCALE := (TYPEOF(SELF.LOCALE))'';
  #END
  #IF ( #TEXT(Input_ADDRES) <> '' )
    SELF.ADDRES := (TYPEOF(SELF.ADDRES))le.Input_ADDRES;
  #ELSE
    SELF.ADDRES := (TYPEOF(SELF.ADDRES))'';
  #END
END;
#uniquename(pr)
  %pr% := PROJECT(infile,%into%(LEFT)); // Into roxie input format
#uniquename(res_out)
SALT29.MAC_Soapcall(%pr%,PRTE_Health_Facility_Services.Process_xLNPID_Layouts.OutputLayout, PRTE_Health_Facility_Services.MEOW_roxieIP, ServiceModule+'MEOW_xLNPID_Service', %res_out%);
OutFile := %res_out%;
  #IF (#TEXT(Stats)<>'')
    Stats := PRTE_Health_Facility_Services.Process_xLNPID_Layouts.ScoreSummary(OutFile);
  #END
ENDMACRO;
