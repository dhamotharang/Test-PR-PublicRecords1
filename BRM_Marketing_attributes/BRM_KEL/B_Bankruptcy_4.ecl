//HPCC Systems KEL Compiler Version 1.6.0
IMPORT KEL16 AS KEL;
IMPORT B_Bankruptcy_5,B_Bankruptcy_7,CFG_Compile,E_Bankruptcy FROM BRM_Marketing_attributes.BRM_KEL;
IMPORT * FROM KEL16.Null;
EXPORT B_Bankruptcy_4(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE
  SHARED VIRTUAL TYPEOF(B_Bankruptcy_5(__in,__cfg).__ENH_Bankruptcy_5) __ENH_Bankruptcy_5 := B_Bankruptcy_5(__in,__cfg).__ENH_Bankruptcy_5;
  SHARED __EE885143 := __ENH_Bankruptcy_5;
  EXPORT __ST315882_Layout := RECORD
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
    KEL.typ.nbool Banko7_Year_;
    KEL.typ.nint Filing_Age_In_Days_;
    KEL.typ.nbool Is_Bankruptcy_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  EXPORT __ST158139_Layout := RECORD
    KEL.typ.nuid UID;
    KEL.typ.nstr T_M_S_I_D_;
    KEL.typ.nstr Court_Code_;
    KEL.typ.nstr Case_Number_;
    KEL.typ.nstr Original_Case_Number_;
    KEL.typ.ndataset(B_Bankruptcy_7(__in,__cfg).__ST166538_Layout) Records_;
    KEL.typ.ndataset(E_Bankruptcy(__in,__cfg).Case_Details_Layout) Case_Details_;
    KEL.typ.ndataset(E_Bankruptcy(__in,__cfg).Data_Sources_Layout) Data_Sources_;
    KEL.typ.ndataset(__ST315882_Layout) Best_Child_Record_;
    KEL.typ.nbool Has_Case_Number_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  SHARED __ST158139_Layout __ND885100__Project(B_Bankruptcy_5(__in,__cfg).__ST161831_Layout __PP884779) := TRANSFORM
    __EE885098 := __PP884779.Best_Child_Record_;
    __ST315882_Layout __ND885032__Project(B_Bankruptcy_5(__in,__cfg).__ST269702_Layout __PP884837) := TRANSFORM
      __CC30865 := 2556;
      SELF.Banko7_Year_ := __AND(__AND(__PP884837.Is_Bankruptcy_,__OP2(__PP884837.Filing_Age_In_Days_,<=,__CN(__CC30865))),__NOT(__NT(__PP884837.Filing_Age_In_Days_)));
      SELF := __PP884837;
    END;
    SELF.Best_Child_Record_ := __PROJECT(__EE885098,__ND885032__Project(LEFT));
    SELF := __PP884779;
  END;
  EXPORT __ENH_Bankruptcy_4 := PROJECT(__EE885143,__ND885100__Project(LEFT));
END;
