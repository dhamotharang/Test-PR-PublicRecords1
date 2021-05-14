//HPCC Systems KEL Compiler Version 1.6.0
IMPORT KEL16 AS KEL;
IMPORT B_Bankruptcy_5,B_Bankruptcy_8,CFG_Compile,E_Bankruptcy,FN_Compile FROM PublicRecords_KEL.KEL_Queries_MAS_FCRA;
IMPORT * FROM KEL16.Null;
EXPORT B_Bankruptcy_4(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE
  SHARED VIRTUAL TYPEOF(B_Bankruptcy_5(__in,__cfg).__ENH_Bankruptcy_5) __ENH_Bankruptcy_5 := B_Bankruptcy_5(__in,__cfg).__ENH_Bankruptcy_5;
  SHARED __EE1123996 := __ENH_Bankruptcy_5;
  EXPORT __ST267610_Layout := RECORD
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
    KEL.typ.nbool Banko10_Year_;
    KEL.typ.nbool Banko1_Year_;
    KEL.typ.nbool Banko7_Year_;
    KEL.typ.nkdate Bankruptcy_Date_;
    KEL.typ.nint Filing_Age_In_Days_;
    KEL.typ.nbool Is_Bankruptcy_;
    KEL.typ.nint Status_Update_Age_In_Days_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  EXPORT __ST179687_Layout := RECORD
    KEL.typ.nuid UID;
    KEL.typ.nstr T_M_S_I_D_;
    KEL.typ.nstr Court_Code_;
    KEL.typ.nstr Case_Number_;
    KEL.typ.nstr Original_Case_Number_;
    KEL.typ.ndataset(B_Bankruptcy_8(__in,__cfg).__ST173483_Layout) Records_;
    KEL.typ.ndataset(E_Bankruptcy(__in,__cfg).Case_Details_Layout) Case_Details_;
    KEL.typ.ndataset(E_Bankruptcy(__in,__cfg).Data_Sources_Layout) Data_Sources_;
    KEL.typ.ndataset(__ST267610_Layout) Best_Child_Record_;
    KEL.typ.nbool Has_Case_Number_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  SHARED __ST179687_Layout __ND1123953__Project(B_Bankruptcy_5(__in,__cfg).__ST169494_Layout __PP1123596) := TRANSFORM
    __EE1123951 := __PP1123596.Best_Child_Record_;
    __ST267610_Layout __ND1123877__Project(B_Bankruptcy_5(__in,__cfg).__ST244057_Layout __PP1123654) := TRANSFORM
      __CC30813 := 3652;
      SELF.Banko10_Year_ := __AND(__AND(__PP1123654.Is_Bankruptcy_,__OP2(__PP1123654.Filing_Age_In_Days_,<=,__CN(__CC30813))),__NOT(__NT(__PP1123654.Filing_Age_In_Days_)));
      __CC30799 := 365;
      SELF.Banko1_Year_ := __AND(__AND(__PP1123654.Is_Bankruptcy_,__OP2(__PP1123654.Filing_Age_In_Days_,<=,__CN(__CC30799))),__NOT(__NT(__PP1123654.Filing_Age_In_Days_)));
      __CC13160 := KEL.Routines.MinN(FN_Compile(__cfg).FN_G_E_T_B_U_I_L_D_D_A_T_E(__ECAST(KEL.typ.nstr,__CN('bankruptcy_daily'))),__CN(__cfg.CurrentDate));
      SELF.Status_Update_Age_In_Days_ := FN_Compile(__cfg).FN_A_B_S_D_A_Y_S_B_E_T_W_E_E_N(__ECAST(KEL.typ.nkdate,__PP1123654.Last_Status_Update_),__ECAST(KEL.typ.nkdate,__CC13160));
      SELF := __PP1123654;
    END;
    SELF.Best_Child_Record_ := __PROJECT(__EE1123951,__ND1123877__Project(LEFT));
    SELF := __PP1123596;
  END;
  EXPORT __ENH_Bankruptcy_4 := PROJECT(__EE1123996,__ND1123953__Project(LEFT));
END;
