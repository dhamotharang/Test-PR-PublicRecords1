//HPCC Systems KEL Compiler Version 1.5.0rc1
IMPORT KEL15 AS KEL;
IMPORT CFG_Compile,E_Property,E_Zip_Code FROM PublicRecords_KEL;
IMPORT * FROM KEL15.Null;
EXPORT B_Property_5(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE
  SHARED VIRTUAL TYPEOF(E_Property(__in,__cfg).__Result) __E_Property := E_Property(__in,__cfg).__Result;
  SHARED __EE600875 := __E_Property;
  EXPORT __ST257295_Layout := RECORD
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
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  EXPORT __ST257277_Layout := RECORD
    KEL.typ.nuid UID;
    KEL.typ.nstr Primary_Range_;
    KEL.typ.nstr Predirectional_;
    KEL.typ.nstr Primary_Name_;
    KEL.typ.nstr Suffix_;
    KEL.typ.nstr Postdirectional_;
    KEL.typ.nstr Secondary_Range_;
    KEL.typ.ntyp(E_Zip_Code().Typ) Z_I_P5_;
    KEL.typ.ndataset(E_Property(__in,__cfg).Address_Components_Layout) Address_Components_;
    KEL.typ.ndataset(__ST257295_Layout) Automated_Valuation_Model_;
    KEL.typ.ndataset(E_Property(__in,__cfg).Data_Sources_Layout) Data_Sources_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  SHARED __ST257277_Layout __ND601113__Project(E_Property(__in,__cfg).Layout __PP600686) := TRANSFORM
    __EE600756 := __PP600686.Automated_Valuation_Model_;
    __ST257295_Layout __ND601033__Project(E_Property(__in,__cfg).Automated_Valuation_Model_Layout __PP601029) := TRANSFORM
      SELF.A_V_M_Value_Date_ := KEL.era.ToDate(__PP601029.Date_First_Seen_);
      SELF := __PP601029;
    END;
    SELF.Automated_Valuation_Model_ := __PROJECT(__EE600756,__ND601033__Project(LEFT));
    SELF := __PP600686;
  END;
  EXPORT __ENH_Property_5 := PROJECT(__EE600875,__ND601113__Project(LEFT));
END;
