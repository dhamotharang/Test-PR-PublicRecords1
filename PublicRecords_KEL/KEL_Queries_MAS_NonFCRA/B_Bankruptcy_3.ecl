//HPCC Systems KEL Compiler Version 1.6.0
IMPORT KEL16 AS KEL;
IMPORT B_Bankruptcy_4,B_Bankruptcy_8,CFG_Compile,E_Bankruptcy,FN_Compile FROM PublicRecords_KEL.KEL_Queries_MAS_NonFCRA;
IMPORT * FROM KEL16.Null;
EXPORT B_Bankruptcy_3(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE
  SHARED VIRTUAL TYPEOF(B_Bankruptcy_4(__in,__cfg).__ENH_Bankruptcy_4) __ENH_Bankruptcy_4 := B_Bankruptcy_4(__in,__cfg).__ENH_Bankruptcy_4;
  SHARED __EE1713059 := __ENH_Bankruptcy_4;
  EXPORT __ST353938_Layout := RECORD
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
    KEL.typ.nbool Banko10_Year_Update_Filter_;
    KEL.typ.nbool Banko1_Year_;
    KEL.typ.nbool Banko1_Year_Update_Filter_;
    KEL.typ.nbool Banko7_Year_;
    KEL.typ.nbool Banko7_Year_Update_Filter_;
    KEL.typ.nkdate Bankruptcy_Date_;
    KEL.typ.nstr Case_Number_;
    KEL.typ.nstr Court_Code_;
    KEL.typ.nint Filing_Age_In_Days_;
    KEL.typ.nbool Is_Bankruptcy_;
    KEL.typ.str Modified_Disposition_ := '';
    KEL.typ.nstr T_M_S_I_D_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  EXPORT __ST168590_Layout := RECORD
    KEL.typ.nuid UID;
    KEL.typ.nstr T_M_S_I_D_;
    KEL.typ.nstr Court_Code_;
    KEL.typ.nstr Case_Number_;
    KEL.typ.nstr Original_Case_Number_;
    KEL.typ.ndataset(B_Bankruptcy_8(__in,__cfg).__ST181032_Layout) Records_;
    KEL.typ.ndataset(E_Bankruptcy(__in,__cfg).Case_Details_Layout) Case_Details_;
    KEL.typ.ndataset(E_Bankruptcy(__in,__cfg).Data_Sources_Layout) Data_Sources_;
    KEL.typ.ndataset(__ST353938_Layout) Best_Child_Record_;
    KEL.typ.nbool Has_Case_Number_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  SHARED __ST168590_Layout __ND1713016__Project(B_Bankruptcy_4(__in,__cfg).__ST187319_Layout __PP1712550) := TRANSFORM
    __EE1713014 := __PP1712550.Best_Child_Record_;
    __ST353938_Layout __ND1712911__Project(B_Bankruptcy_4(__in,__cfg).__ST296283_Layout __PP1712608) := TRANSFORM
      __CC30851 := 3652;
      __CC13082 := KEL.Routines.MinN(FN_Compile(__cfg).FN_G_E_T_B_U_I_L_D_D_A_T_E(__ECAST(KEL.typ.nstr,__CN('bankruptcy_daily'))),__CN(__cfg.CurrentDate));
      SELF.Banko10_Year_Update_Filter_ := __AND(__AND(__AND(__AND(__PP1712608.Is_Bankruptcy_,__PP1712608.Banko10_Year_),__OP2(__PP1712608.Status_Update_Age_In_Days_,<=,__CN(__CC30851))),__NOT(__NT(__PP1712608.Last_Status_Update_))),__OP2(__PP1712608.Last_Status_Update_,<=,__CC13082));
      __CC30837 := 365;
      SELF.Banko1_Year_Update_Filter_ := __AND(__AND(__AND(__AND(__PP1712608.Is_Bankruptcy_,__PP1712608.Banko1_Year_),__OP2(__PP1712608.Status_Update_Age_In_Days_,<=,__CN(__CC30837))),__NOT(__NT(__PP1712608.Last_Status_Update_))),__OP2(__PP1712608.Last_Status_Update_,<=,__CC13082));
      __CC30849 := 2556;
      SELF.Banko7_Year_Update_Filter_ := __AND(__AND(__AND(__AND(__PP1712608.Is_Bankruptcy_,__PP1712608.Banko7_Year_),__OP2(__PP1712608.Status_Update_Age_In_Days_,<=,__CN(__CC30849))),__NOT(__NT(__PP1712608.Last_Status_Update_))),__OP2(__PP1712608.Last_Status_Update_,<=,__CC13082));
      SELF.Case_Number_ := __PP1712550.Case_Number_;
      SELF.Court_Code_ := __PP1712550.Court_Code_;
      __CC13919 := '-99997';
      SELF.Modified_Disposition_ := MAP(__T(__OP2(FN_Compile(__cfg).FN_Edit_Distance(__ECAST(KEL.typ.nstr,__CN('DISCHARGED')),__ECAST(KEL.typ.nstr,__FN1(KEL.Routines.ToUpperCase,__FN1(KEL.Routines.TrimAll,__PP1712608.Disposition_)))),<=,__CN(3)))=>'DISCHARGED',__T(__OP2(FN_Compile(__cfg).FN_Edit_Distance(__ECAST(KEL.typ.nstr,__CN('DISMISSED')),__ECAST(KEL.typ.nstr,__FN1(KEL.Routines.ToUpperCase,__FN1(KEL.Routines.TrimAll,__PP1712608.Disposition_)))),<=,__CN(3)))=>'DISMISSED',__T(__OP2(FN_Compile(__cfg).FN_Edit_Distance(__ECAST(KEL.typ.nstr,__CN('WITHDRAWN')),__ECAST(KEL.typ.nstr,__FN1(KEL.Routines.ToUpperCase,__FN1(KEL.Routines.TrimAll,__PP1712608.Disposition_)))),<=,__CN(3)))=>'WITHDRAWN',__T(__OP2(FN_Compile(__cfg).FN_Edit_Distance(__ECAST(KEL.typ.nstr,__CN('SPLIT_OUT')),__ECAST(KEL.typ.nstr,__FN1(KEL.Routines.ToUpperCase,__FN1(KEL.Routines.TrimAll,__PP1712608.Disposition_)))),<=,__CN(3)))=>'SPLIT_OUT',__CC13919);
      SELF.T_M_S_I_D_ := __PP1712550.T_M_S_I_D_;
      SELF := __PP1712608;
    END;
    SELF.Best_Child_Record_ := __PROJECT(__EE1713014,__ND1712911__Project(LEFT));
    SELF := __PP1712550;
  END;
  EXPORT __ENH_Bankruptcy_3 := PROJECT(__EE1713059,__ND1713016__Project(LEFT));
END;
