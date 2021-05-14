//HPCC Systems KEL Compiler Version 1.6.0
IMPORT KEL16 AS KEL;
IMPORT B_Property_5,CFG_Compile,E_Property,E_Zip_Code,FN_Compile FROM PublicRecords_KEL.KEL_Queries_MAS_Consumer;
IMPORT * FROM KEL16.Null;
EXPORT B_Property_4(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE
  SHARED VIRTUAL TYPEOF(B_Property_5(__in,__cfg).__ENH_Property_5) __ENH_Property_5 := B_Property_5(__in,__cfg).__ENH_Property_5;
  SHARED __EE306990 := __ENH_Property_5;
  EXPORT __ST156005_Layout := RECORD
    KEL.typ.nstr A_V_M_Unformatted_A_P_N_;
    KEL.typ.nint A_V_M_Land_Use_Code_;
    KEL.typ.nkdate A_V_M_Recording_Date_;
    KEL.typ.nkdate A_V_M_Assessed_Value_Year_;
    KEL.typ.nint A_V_M_Sales_Price_;
    KEL.typ.nint A_V_M_Assessed_Total_Value_;
    KEL.typ.nint A_V_M_Market_Total_Value_;
    KEL.typ.nint A_V_M_Tax_Assessment_Valuation_;
    KEL.typ.nint A_V_M_Price_Index_Valuation_;
    KEL.typ.nint A_V_M_Hedonic_Valuation_;
    KEL.typ.nint A_V_M_Automated_Valuation_;
    KEL.typ.nint A_V_M_Confidence_Score_;
    KEL.typ.nbool A_V_M_Current_Flag_;
    KEL.typ.nkdate A_V_M_Value_Date_;
    KEL.typ.nint A_V_M_Years_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  EXPORT __ST155987_Layout := RECORD
    KEL.typ.nuid UID;
    KEL.typ.nstr Primary_Range_;
    KEL.typ.nstr Predirectional_;
    KEL.typ.nstr Primary_Name_;
    KEL.typ.nstr Suffix_;
    KEL.typ.nstr Postdirectional_;
    KEL.typ.nstr Secondary_Range_;
    KEL.typ.ntyp(E_Zip_Code().Typ) Z_I_P5_;
    KEL.typ.ndataset(E_Property(__in,__cfg).Address_Components_Layout) Address_Components_;
    KEL.typ.ndataset(__ST156005_Layout) Automated_Valuation_Model_;
    KEL.typ.ndataset(E_Property(__in,__cfg).Data_Sources_Layout) Data_Sources_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  SHARED __ST155987_Layout __ND306995__Project(B_Property_5(__in,__cfg).__ST156683_Layout __PP306991) := TRANSFORM
    __EE307034 := __PP306991.Automated_Valuation_Model_;
    __ST156005_Layout __ND307039__Project(B_Property_5(__in,__cfg).__ST156701_Layout __PP307035) := TRANSFORM
      __CC13280 := KEL.Routines.MinN(FN_Compile(__cfg).FN_G_E_T_B_U_I_L_D_D_A_T_E(__ECAST(KEL.typ.nstr,__CN('property_build_version'))),__CN(__cfg.CurrentDate));
      SELF.A_V_M_Years_ := FN_Compile(__cfg).FN_A_B_S_Y_E_A_R_S_B_E_T_W_E_E_N(__ECAST(KEL.typ.nkdate,__PP307035.A_V_M_Value_Date_),__ECAST(KEL.typ.nkdate,__CC13280));
      SELF := __PP307035;
    END;
    SELF.Automated_Valuation_Model_ := __PROJECT(__EE307034,__ND307039__Project(LEFT));
    SELF := __PP306991;
  END;
  EXPORT __ENH_Property_4 := PROJECT(__EE306990,__ND306995__Project(LEFT));
END;
