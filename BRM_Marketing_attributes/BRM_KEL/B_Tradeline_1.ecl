//HPCC Systems KEL Compiler Version 1.5.0rc1
IMPORT KEL15 AS KEL;
IMPORT B_Tradeline_2,CFG_Compile,E_Tradeline FROM BRM_Marketing_attributes.BRM_KEL;
IMPORT * FROM KEL15.Null;
EXPORT B_Tradeline_1(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE
  SHARED VIRTUAL TYPEOF(B_Tradeline_2(__in,__cfg).__ENH_Tradeline_2) __ENH_Tradeline_2 := B_Tradeline_2(__in,__cfg).__ENH_Tradeline_2;
  SHARED __EE1386132 := __ENH_Tradeline_2;
  EXPORT __ST143310_Layout := RECORD
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
  EXPORT __ST143303_Layout := RECORD
    KEL.typ.nuid UID;
    KEL.typ.nint Ult_I_D_;
    KEL.typ.nint Org_I_D_;
    KEL.typ.nint Sele_I_D_;
    KEL.typ.nstr Account_Key_;
    KEL.typ.ndataset(__ST143310_Layout) Records_;
    KEL.typ.ndataset(E_Tradeline(__in,__cfg).Vendor_Dates_Layout) Vendor_Dates_;
    KEL.typ.ndataset(E_Tradeline(__in,__cfg).Data_Sources_Layout) Data_Sources_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  SHARED __ST143303_Layout __ND1386109__Project(B_Tradeline_2(__in,__cfg).__ST173162_Layout __PP1385763) := TRANSFORM
    __EE1386135 := __PP1385763.Records_;
    __ST143310_Layout __ND1386059__Project(B_Tradeline_2(__in,__cfg).__ST173169_Layout __PP1385793) := TRANSFORM
      __EE1386052 := __PP1385763.Records_;
      SELF.Is_Most_Recent_Active_Record_ := __AND(__PP1385763.Is_Active_,__OP2(__PP1385793.A_R_Date_,=,KEL.Aggregates.MaxNN(__EE1386052,__T(__EE1386052).A_R_Date_)));
      SELF.Perf_Level_ := MAP(__T(__OP2(__PP1385793.Aging91_Plus_L_N_,>,__CN(0)))=>4,__T(__OP2(__PP1385793.Aging61_To90_L_N_,>,__CN(0)))=>3,__T(__OP2(__PP1385793.Aging31_To60_L_N_,>,__CN(0)))=>2,__T(__OP2(__PP1385793.Aging1_To30_L_N_,>,__CN(0)))=>1,0);
      SELF := __PP1385793;
    END;
    SELF.Records_ := __PROJECT(__EE1386135,__ND1386059__Project(LEFT));
    SELF := __PP1385763;
  END;
  EXPORT __ENH_Tradeline_1 := PROJECT(__EE1386132,__ND1386109__Project(LEFT));
END;
