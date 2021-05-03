//HPCC Systems KEL Compiler Version 1.5.0rc1
IMPORT KEL15 AS KEL;
IMPORT B_Bankruptcy_7,B_Bankruptcy_8,CFG_Compile,E_Bankruptcy,FN_Compile FROM PublicRecords_KEL.KEL_Queries_MAS_Business;
IMPORT * FROM KEL15.Null;
EXPORT B_Bankruptcy_6(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE
  SHARED VIRTUAL TYPEOF(B_Bankruptcy_7(__in,__cfg).__ENH_Bankruptcy_7) __ENH_Bankruptcy_7 := B_Bankruptcy_7(__in,__cfg).__ENH_Bankruptcy_7;
  SHARED __EE1909190 := __ENH_Bankruptcy_7;
  EXPORT __ST324038_Layout := RECORD
    KEL.typ.nstr Source_Description_;
    KEL.typ.nstr Original_Chapter_;
    KEL.typ.nstr Filing_Type_;
    KEL.typ.nstr Business_Flag_;
    KEL.typ.nstr Corporate_Flag_;
    KEL.typ.nkdate Discharged_Date_;
    KEL.typ.nstr Disposition_;
    KEL.typ.nstr Debtor_Type_;
    KEL.typ.nint Debtor_Sequence_;
    KEL.typ.nint Disposition_Type_;
    KEL.typ.nint Disposition_Reason_;
    KEL.typ.nstr Disposition_Type_Description_;
    KEL.typ.nstr Name_Type_;
    KEL.typ.nstr Screen_Description_;
    KEL.typ.nstr Decoded_Description_;
    KEL.typ.nkdate Date_Filed_;
    KEL.typ.nstr Record_Type_;
    KEL.typ.nkdate Last_Status_Update_;
    KEL.typ.nint Filing_Age_In_Days_;
    KEL.typ.nbool Is_Bankruptcy_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  EXPORT __ST206422_Layout := RECORD
    KEL.typ.nuid UID;
    KEL.typ.nstr T_M_S_I_D_;
    KEL.typ.nstr Court_Code_;
    KEL.typ.nstr Case_Number_;
    KEL.typ.nstr Original_Case_Number_;
    KEL.typ.ndataset(B_Bankruptcy_8(__in,__cfg).__ST211700_Layout) Records_;
    KEL.typ.ndataset(E_Bankruptcy(__in,__cfg).Case_Details_Layout) Case_Details_;
    KEL.typ.ndataset(E_Bankruptcy(__in,__cfg).Data_Sources_Layout) Data_Sources_;
    KEL.typ.ndataset(__ST324038_Layout) Best_Child_Record_;
    KEL.typ.nbool Has_Case_Number_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  SHARED __ST206422_Layout __ND1909147__Project(B_Bankruptcy_7(__in,__cfg).__ST209471_Layout __PP1908812) := TRANSFORM
    __EE1909145 := __PP1908812.Best_Child_Record_;
    __ST324038_Layout __ND1909080__Project(B_Bankruptcy_8(__in,__cfg).__ST211700_Layout __PP1908870) := TRANSFORM
      __CC13283 := KEL.Routines.MinN(FN_Compile(__cfg).FN_G_E_T_B_U_I_L_D_D_A_T_E(__ECAST(KEL.typ.nstr,__CN('bankruptcy_daily'))),__CN(__cfg.CurrentDate));
      SELF.Filing_Age_In_Days_ := FN_Compile(__cfg).FN_A_B_S_D_A_Y_S_B_E_T_W_E_E_N(__ECAST(KEL.typ.nkdate,__PP1908870.Date_Filed_),__ECAST(KEL.typ.nkdate,__CC13283));
      __BS1908937 := __T(__PP1908812.Case_Details_);
      SELF.Is_Bankruptcy_ := __AND(__PP1908812.Has_Case_Number_,__CN(EXISTS(__BS1908937(__T(__OP2(__CAST(KEL.typ.str,__T(__PP1908812.Case_Details_).Case_I_D_),<>,__CN('')))))));
      SELF := __PP1908870;
    END;
    SELF.Best_Child_Record_ := __FILTER(__PROJECT(__EE1909145,__ND1909080__Project(LEFT)),__NN(Source_Description_) OR __NN(Original_Chapter_) OR __NN(Filing_Type_) OR __NN(Business_Flag_) OR __NN(Corporate_Flag_) OR __NN(Discharged_Date_) OR __NN(Disposition_) OR __NN(Debtor_Type_) OR __NN(Debtor_Sequence_) OR __NN(Disposition_Type_) OR __NN(Disposition_Reason_) OR __NN(Disposition_Type_Description_) OR __NN(Name_Type_) OR __NN(Screen_Description_) OR __NN(Decoded_Description_) OR __NN(Date_Filed_) OR __NN(Record_Type_) OR __NN(Last_Status_Update_) OR __NN(Filing_Age_In_Days_) OR __NN(Is_Bankruptcy_));
    SELF := __PP1908812;
  END;
  EXPORT __ENH_Bankruptcy_6 := PROJECT(__EE1909190,__ND1909147__Project(LEFT));
END;
