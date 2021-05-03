//HPCC Systems KEL Compiler Version 1.5.0rc1
IMPORT KEL15 AS KEL;
IMPORT B_Bankruptcy_3,B_Bankruptcy_9,CFG_Compile,E_Bankruptcy FROM PublicRecords_KEL.KEL_Queries_MAS_NonFCRA;
IMPORT * FROM KEL15.Null;
EXPORT B_Bankruptcy_2(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE
  SHARED VIRTUAL TYPEOF(B_Bankruptcy_3(__in,__cfg).__ENH_Bankruptcy_3) __ENH_Bankruptcy_3 := B_Bankruptcy_3(__in,__cfg).__ENH_Bankruptcy_3;
  SHARED __EE5501648 := __ENH_Bankruptcy_3;
  EXPORT __ST798294_Layout := RECORD
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
    KEL.typ.nbool Chapter13_;
    KEL.typ.nbool Chapter7_;
    KEL.typ.nbool Chapter_Type_;
    KEL.typ.nstr Court_Code_;
    KEL.typ.nint Filing_Age_In_Days_;
    KEL.typ.nbool Is_Bankruptcy_;
    KEL.typ.nbool Is_Disposed_;
    KEL.typ.str Modified_Disposition_ := '';
    KEL.typ.nint Status_Update_Age_In_Days_;
    KEL.typ.nstr T_M_S_I_D_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  EXPORT __ST180300_Layout := RECORD
    KEL.typ.nuid UID;
    KEL.typ.nstr T_M_S_I_D_;
    KEL.typ.nstr Court_Code_;
    KEL.typ.nstr Case_Number_;
    KEL.typ.nstr Original_Case_Number_;
    KEL.typ.ndataset(B_Bankruptcy_9(__in,__cfg).__ST211660_Layout) Records_;
    KEL.typ.ndataset(E_Bankruptcy(__in,__cfg).Case_Details_Layout) Case_Details_;
    KEL.typ.ndataset(E_Bankruptcy(__in,__cfg).Data_Sources_Layout) Data_Sources_;
    KEL.typ.ndataset(__ST798294_Layout) Best_Child_Record_;
    KEL.typ.nbool Has_Case_Number_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  SHARED __ST180300_Layout __ND5501605__Project(B_Bankruptcy_3(__in,__cfg).__ST189931_Layout __PP5501199) := TRANSFORM
    __EE5501603 := __PP5501199.Best_Child_Record_;
    __ST798294_Layout __ND5501518__Project(B_Bankruptcy_3(__in,__cfg).__ST520465_Layout __PP5501257) := TRANSFORM
      SELF.Chapter13_ := __OP2(__PP5501257.Original_Chapter_,=,__CN('13'));
      SELF.Chapter7_ := __OP2(__PP5501257.Original_Chapter_,=,__CN('7'));
      SELF.Chapter_Type_ := __OP2(__PP5501257.Original_Chapter_,IN,__CN(['7','11','12','13','15']));
      SELF.Is_Disposed_ := __NOT(__NT(__PP5501257.Disposition_));
      SELF := __PP5501257;
    END;
    SELF.Best_Child_Record_ := __PROJECT(__EE5501603,__ND5501518__Project(LEFT));
    SELF := __PP5501199;
  END;
  EXPORT __ENH_Bankruptcy_2 := PROJECT(__EE5501648,__ND5501605__Project(LEFT));
END;
