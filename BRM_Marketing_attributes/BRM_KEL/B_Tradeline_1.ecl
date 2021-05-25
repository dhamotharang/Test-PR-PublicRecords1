//HPCC Systems KEL Compiler Version 1.6.0
IMPORT KEL16 AS KEL;
IMPORT B_Tradeline_2,CFG_Compile,E_Tradeline FROM BRM_Marketing_attributes.BRM_KEL;
IMPORT * FROM KEL16.Null;
EXPORT B_Tradeline_1(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE
  SHARED VIRTUAL TYPEOF(B_Tradeline_2(__in,__cfg).__ENH_Tradeline_2) __ENH_Tradeline_2 := B_Tradeline_2(__in,__cfg).__ENH_Tradeline_2;
  SHARED __EE1390065 := __ENH_Tradeline_2;
  EXPORT __ST154297_Layout := RECORD
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
    KEL.typ.nint Aging1_To30_L_N_;
    KEL.typ.nint Aging31_To60_L_N_;
    KEL.typ.nint Aging61_To90_L_N_;
    KEL.typ.nint Aging91_Plus_L_N_;
    KEL.typ.nbool Is_Most_Recent_Active_Record_;
    KEL.typ.int Perf_Level_ := 0;
    KEL.typ.nint Record_Age_In_Days_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  EXPORT __ST154290_Layout := RECORD
    KEL.typ.nuid UID;
    KEL.typ.nint Ult_I_D_;
    KEL.typ.nint Org_I_D_;
    KEL.typ.nint Sele_I_D_;
    KEL.typ.nstr Account_Key_;
    KEL.typ.ndataset(__ST154297_Layout) Records_;
    KEL.typ.ndataset(E_Tradeline(__in,__cfg).Vendor_Dates_Layout) Vendor_Dates_;
    KEL.typ.ndataset(E_Tradeline(__in,__cfg).Data_Sources_Layout) Data_Sources_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  SHARED __ST154290_Layout __ND1390042__Project(B_Tradeline_2(__in,__cfg).__ST181660_Layout __PP1389696) := TRANSFORM
    __EE1390068 := __PP1389696.Records_;
    __ST154297_Layout __ND1389992__Project(B_Tradeline_2(__in,__cfg).__ST181667_Layout __PP1389726) := TRANSFORM
      __EE1389985 := __PP1389696.Records_;
      SELF.Is_Most_Recent_Active_Record_ := __AND(__PP1389696.Is_Active_,__OP2(__PP1389726.A_R_Date_,=,KEL.Aggregates.MaxNN(__EE1389985,__T(__EE1389985).A_R_Date_)));
      SELF.Perf_Level_ := MAP(__T(__OP2(__PP1389726.Aging91_Plus_L_N_,>,__CN(0)))=>4,__T(__OP2(__PP1389726.Aging61_To90_L_N_,>,__CN(0)))=>3,__T(__OP2(__PP1389726.Aging31_To60_L_N_,>,__CN(0)))=>2,__T(__OP2(__PP1389726.Aging1_To30_L_N_,>,__CN(0)))=>1,0);
      SELF := __PP1389726;
    END;
    SELF.Records_ := __PROJECT(__EE1390068,__ND1389992__Project(LEFT));
    SELF := __PP1389696;
  END;
  EXPORT __ENH_Tradeline_1 := PROJECT(__EE1390065,__ND1390042__Project(LEFT));
END;
