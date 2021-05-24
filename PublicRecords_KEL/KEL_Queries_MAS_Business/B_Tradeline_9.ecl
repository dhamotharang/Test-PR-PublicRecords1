//HPCC Systems KEL Compiler Version 1.6.0
IMPORT KEL16 AS KEL;
IMPORT B_Tradeline_10,CFG_Compile,E_Tradeline,FN_Compile FROM PublicRecords_KEL.KEL_Queries_MAS_Business;
IMPORT * FROM KEL16.Null;
EXPORT B_Tradeline_9(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE
  SHARED VIRTUAL TYPEOF(B_Tradeline_10(__in,__cfg).__ENH_Tradeline_10) __ENH_Tradeline_10 := B_Tradeline_10(__in,__cfg).__ENH_Tradeline_10;
  SHARED __EE1883231 := __ENH_Tradeline_10;
  EXPORT __ST215050_Layout := RECORD
    KEL.typ.nkdate A_R_Date_;
    KEL.typ.nint Total_A_R_;
    KEL.typ.nint Current_A_R_;
    KEL.typ.nint Aging1_To30_;
    KEL.typ.nint Aging31_To60_;
    KEL.typ.nint Aging61_To90_;
    KEL.typ.nint Aging91_Plus_;
    KEL.typ.nint Credit_Limit_;
    KEL.typ.nint Segment_I_D_;
    KEL.typ.nkdate File_Date_;
    KEL.typ.nstr Status_;
    KEL.typ.nkdate First_Sale_Date_;
    KEL.typ.nkdate Last_Sale_Date_;
    KEL.typ.nint Record_Age_In_Days_;
    KEL.typ.nkdate Record_Date_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  EXPORT __ST215043_Layout := RECORD
    KEL.typ.nuid UID;
    KEL.typ.nint Ult_I_D_;
    KEL.typ.nint Org_I_D_;
    KEL.typ.nint Sele_I_D_;
    KEL.typ.nstr Account_Key_;
    KEL.typ.ndataset(__ST215050_Layout) Records_;
    KEL.typ.ndataset(E_Tradeline(__in,__cfg).Vendor_Dates_Layout) Vendor_Dates_;
    KEL.typ.ndataset(E_Tradeline(__in,__cfg).Data_Sources_Layout) Data_Sources_;
    KEL.typ.nkdate Current_Date_First_Of_Month_;
    KEL.typ.nint Current_Month_;
    KEL.typ.nint Current_Year_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  SHARED __ST215043_Layout __ND1883391__Project(B_Tradeline_10(__in,__cfg).__ST215778_Layout __PP1883232) := TRANSFORM
    __EE1883264 := __PP1883232.Records_;
    __ST215050_Layout __ND1883269__Project(B_Tradeline_10(__in,__cfg).__ST215785_Layout __PP1883265) := TRANSFORM
      __CC13415 := KEL.Routines.MinN(FN_Compile(__cfg).FN_G_E_T_B_U_I_L_D_D_A_T_E(__ECAST(KEL.typ.nstr,__CN('cortera_build_version'))),__CN(__cfg.CurrentDate));
      SELF.Record_Age_In_Days_ := FN_Compile(__cfg).FN_A_B_S_D_A_Y_S_B_E_T_W_E_E_N(__ECAST(KEL.typ.nkdate,__PP1883265.Record_Date_),__ECAST(KEL.typ.nkdate,__CC13415));
      SELF := __PP1883265;
    END;
    SELF.Records_ := __PROJECT(__EE1883264,__ND1883269__Project(LEFT));
    SELF.Current_Date_First_Of_Month_ := __FN3(KEL.Routines.DateFromParts,__PP1883232.Current_Year_,__PP1883232.Current_Month_,__CN(1));
    SELF := __PP1883232;
  END;
  EXPORT __ENH_Tradeline_9 := PROJECT(__EE1883231,__ND1883391__Project(LEFT));
END;
