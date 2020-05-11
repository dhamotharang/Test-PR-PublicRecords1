//HPCC Systems KEL Compiler Version 1.2.2-dev
IMPORT KEL12 AS KEL;
IMPORT B_Bankruptcy_7,B_Bankruptcy_8,CFG_Compile,E_Bankruptcy,FN_Compile FROM PublicRecords_KEL;
IMPORT * FROM KEL12.Null;
EXPORT B_Bankruptcy_6(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE
  SHARED VIRTUAL TYPEOF(B_Bankruptcy_7().__ENH_Bankruptcy_7) __ENH_Bankruptcy_7 := B_Bankruptcy_7(__in,__cfg).__ENH_Bankruptcy_7;
  SHARED __EE330108 := __ENH_Bankruptcy_7;
  EXPORT __ST329126_Layout := RECORD
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
    KEL.typ.epoch Date_Vendor_First_Reported_ := 0;
    KEL.typ.epoch Date_Vendor_Last_Reported_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  EXPORT __ST161942_Layout := RECORD
    KEL.typ.nuid UID;
    KEL.typ.nstr T_M_S_I_D_;
    KEL.typ.nstr Court_Code_;
    KEL.typ.nstr Case_Number_;
    KEL.typ.nstr Original_Case_Number_;
    KEL.typ.ndataset(B_Bankruptcy_8(__in,__cfg).__ST167734_Layout) Records_;
    KEL.typ.ndataset(E_Bankruptcy(__in,__cfg).Case_Details_Layout) Case_Details_;
    KEL.typ.ndataset(E_Bankruptcy(__in,__cfg).Data_Sources_Layout) Data_Sources_;
    KEL.typ.ndataset(__ST329126_Layout) Best_Child_Record_;
    KEL.typ.nbool Has_Case_Number_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Date_Vendor_First_Reported_ := 0;
    KEL.typ.epoch Date_Vendor_Last_Reported_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  SHARED __ST161942_Layout __ND330065__Project(B_Bankruptcy_7(__in,__cfg).__ST165158_Layout __PP329154) := TRANSFORM
    __EE330063 := __PP329154.Best_Child_Record_;
    __ST329126_Layout __ND329998__Project(B_Bankruptcy_8(__in,__cfg).__ST167734_Layout __PP329929) := TRANSFORM
      __CC9111 := KEL.Routines.MinN(FN_Compile(__cfg).FN_G_E_T_B_U_I_L_D_D_A_T_E(__ECAST(KEL.typ.nstr,__CN('bankruptcy_daily'))),__CN(__cfg.CurrentDate));
      SELF.Filing_Age_In_Days_ := FN_Compile(__cfg).FN_A_B_S_D_A_Y_S_B_E_T_W_E_E_N(__ECAST(KEL.typ.nkdate,__PP329929.Date_Filed_),__ECAST(KEL.typ.nkdate,__CC9111));
      __BS329361 := __T(__PP329154.Case_Details_);
      SELF.Is_Bankruptcy_ := __AND(__PP329154.Has_Case_Number_,__CN(EXISTS(__BS329361(__T(__OP2(__CAST(KEL.typ.str,__T(__PP329154.Case_Details_).Case_I_D_),<>,__CN('')))))));
      SELF := __PP329929;
    END;
    SELF.Best_Child_Record_ := __FILTER(__PROJECT(__EE330063,__ND329998__Project(LEFT)),__NN(Source_Description_) OR __NN(Original_Chapter_) OR __NN(Filing_Type_) OR __NN(Business_Flag_) OR __NN(Corporate_Flag_) OR __NN(Discharged_Date_) OR __NN(Disposition_) OR __NN(Debtor_Type_) OR __NN(Debtor_Sequence_) OR __NN(Disposition_Type_) OR __NN(Disposition_Reason_) OR __NN(Disposition_Type_Description_) OR __NN(Name_Type_) OR __NN(Screen_Description_) OR __NN(Decoded_Description_) OR __NN(Date_Filed_) OR __NN(Record_Type_) OR __NN(Last_Status_Update_) OR __NN(Filing_Age_In_Days_) OR __NN(Is_Bankruptcy_));
    SELF := __PP329154;
  END;
  EXPORT __ENH_Bankruptcy_6 := PROJECT(__EE330108,__ND330065__Project(LEFT));
END;
