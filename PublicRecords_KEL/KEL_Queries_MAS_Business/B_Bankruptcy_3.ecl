//HPCC Systems KEL Compiler Version 1.6.0
IMPORT KEL16 AS KEL;
IMPORT B_Bankruptcy_4,B_Bankruptcy_8,CFG_Compile,E_Bankruptcy,FN_Compile FROM PublicRecords_KEL.KEL_Queries_MAS_Business;
IMPORT * FROM KEL16.Null;
EXPORT B_Bankruptcy_3(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE
  SHARED VIRTUAL TYPEOF(B_Bankruptcy_4(__in,__cfg).__ENH_Bankruptcy_4) __ENH_Bankruptcy_4 := B_Bankruptcy_4(__in,__cfg).__ENH_Bankruptcy_4;
  SHARED __EE2124573 := __ENH_Bankruptcy_4;
  EXPORT __ST561627_Layout := RECORD
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
    KEL.typ.nbool Banko7_Year_;
    KEL.typ.nkdate Bankruptcy_Date_;
    KEL.typ.nstr Bus_Change_Chapter_;
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
  EXPORT __ST191205_Layout := RECORD
    KEL.typ.nuid UID;
    KEL.typ.nstr T_M_S_I_D_;
    KEL.typ.nstr Court_Code_;
    KEL.typ.nstr Case_Number_;
    KEL.typ.nstr Original_Case_Number_;
    KEL.typ.ndataset(B_Bankruptcy_8(__in,__cfg).__ST217591_Layout) Records_;
    KEL.typ.ndataset(E_Bankruptcy(__in,__cfg).Case_Details_Layout) Case_Details_;
    KEL.typ.ndataset(E_Bankruptcy(__in,__cfg).Data_Sources_Layout) Data_Sources_;
    KEL.typ.ndataset(__ST561627_Layout) Best_Child_Record_;
    KEL.typ.nbool Has_Case_Number_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  SHARED __ST191205_Layout __ND2124530__Project(B_Bankruptcy_4(__in,__cfg).__ST200390_Layout __PP2124091) := TRANSFORM
    __EE2124528 := __PP2124091.Best_Child_Record_;
    __ST561627_Layout __ND2124428__Project(B_Bankruptcy_4(__in,__cfg).__ST428927_Layout __PP2124149) := TRANSFORM
      __CC30762 := 3652;
      __CC13109 := KEL.Routines.MinN(FN_Compile(__cfg).FN_G_E_T_B_U_I_L_D_D_A_T_E(__ECAST(KEL.typ.nstr,__CN('bankruptcy_daily'))),__CN(__cfg.CurrentDate));
      SELF.Banko10_Year_Update_Filter_ := __AND(__AND(__AND(__AND(__PP2124149.Is_Bankruptcy_,__PP2124149.Banko10_Year_),__OP2(__PP2124149.Status_Update_Age_In_Days_,<=,__CN(__CC30762))),__NOT(__NT(__PP2124149.Last_Status_Update_))),__OP2(__PP2124149.Last_Status_Update_,<=,__CC13109));
      __CC30748 := 365;
      SELF.Banko1_Year_ := __AND(__AND(__PP2124149.Is_Bankruptcy_,__OP2(__PP2124149.Filing_Age_In_Days_,<=,__CN(__CC30748))),__NOT(__NT(__PP2124149.Filing_Age_In_Days_)));
      SELF.Bus_Change_Chapter_ := IF(__T(__OP2(__PP2124149.Original_Chapter_,=,__CN('304'))),__ECAST(KEL.typ.nstr,__CN('15')),__ECAST(KEL.typ.nstr,__PP2124149.Original_Chapter_));
      SELF.Case_Number_ := __PP2124091.Case_Number_;
      SELF.Court_Code_ := __PP2124091.Court_Code_;
      __CC13946 := '-99997';
      SELF.Modified_Disposition_ := MAP(__T(__OP2(FN_Compile(__cfg).FN_Edit_Distance(__ECAST(KEL.typ.nstr,__CN('DISCHARGED')),__ECAST(KEL.typ.nstr,__FN1(KEL.Routines.ToUpperCase,__FN1(KEL.Routines.TrimAll,__PP2124149.Disposition_)))),<=,__CN(3)))=>'DISCHARGED',__T(__OP2(FN_Compile(__cfg).FN_Edit_Distance(__ECAST(KEL.typ.nstr,__CN('DISMISSED')),__ECAST(KEL.typ.nstr,__FN1(KEL.Routines.ToUpperCase,__FN1(KEL.Routines.TrimAll,__PP2124149.Disposition_)))),<=,__CN(3)))=>'DISMISSED',__T(__OP2(FN_Compile(__cfg).FN_Edit_Distance(__ECAST(KEL.typ.nstr,__CN('WITHDRAWN')),__ECAST(KEL.typ.nstr,__FN1(KEL.Routines.ToUpperCase,__FN1(KEL.Routines.TrimAll,__PP2124149.Disposition_)))),<=,__CN(3)))=>'WITHDRAWN',__T(__OP2(FN_Compile(__cfg).FN_Edit_Distance(__ECAST(KEL.typ.nstr,__CN('SPLIT_OUT')),__ECAST(KEL.typ.nstr,__FN1(KEL.Routines.ToUpperCase,__FN1(KEL.Routines.TrimAll,__PP2124149.Disposition_)))),<=,__CN(3)))=>'SPLIT_OUT',__CC13946);
      SELF.T_M_S_I_D_ := __PP2124091.T_M_S_I_D_;
      SELF := __PP2124149;
    END;
    SELF.Best_Child_Record_ := __PROJECT(__EE2124528,__ND2124428__Project(LEFT));
    SELF := __PP2124091;
  END;
  EXPORT __ENH_Bankruptcy_3 := PROJECT(__EE2124573,__ND2124530__Project(LEFT));
END;
