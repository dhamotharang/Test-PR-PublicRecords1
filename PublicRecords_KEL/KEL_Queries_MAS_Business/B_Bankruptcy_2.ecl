//HPCC Systems KEL Compiler Version 1.5.0rc1
IMPORT KEL15 AS KEL;
IMPORT B_Bankruptcy_3,B_Bankruptcy_8,CFG_Compile,E_Bankruptcy FROM PublicRecords_KEL.KEL_Queries_MAS_Business;
IMPORT * FROM KEL15.Null;
EXPORT B_Bankruptcy_2(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE
  SHARED VIRTUAL TYPEOF(B_Bankruptcy_3(__in,__cfg).__ENH_Bankruptcy_3) __ENH_Bankruptcy_3 := B_Bankruptcy_3(__in,__cfg).__ENH_Bankruptcy_3;
  SHARED __EE2510609 := __ENH_Bankruptcy_3;
  EXPORT __ST805124_Layout := RECORD
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
    KEL.typ.nbool Bus_Chapter11_;
    KEL.typ.nbool Bus_Chapter13_;
    KEL.typ.nbool Bus_Chapter7_;
    KEL.typ.nbool Bus_Chapter_Type_;
    KEL.typ.nint Filing_Age_In_Days_;
    KEL.typ.nbool Is_Bankruptcy_;
    KEL.typ.nbool Is_Disposed_;
    KEL.typ.str Modified_Disposition_ := '';
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  EXPORT __ST229940_Layout := RECORD
    KEL.typ.nuid UID;
    KEL.typ.nstr T_M_S_I_D_;
    KEL.typ.nstr Court_Code_;
    KEL.typ.nstr Case_Number_;
    KEL.typ.nstr Original_Case_Number_;
    KEL.typ.ndataset(B_Bankruptcy_8(__in,__cfg).__ST211700_Layout) Records_;
    KEL.typ.ndataset(E_Bankruptcy(__in,__cfg).Case_Details_Layout) Case_Details_;
    KEL.typ.ndataset(E_Bankruptcy(__in,__cfg).Data_Sources_Layout) Data_Sources_;
    KEL.typ.ndataset(__ST805124_Layout) Best_Child_Record_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  SHARED __ST229940_Layout __ND2510569__Project(B_Bankruptcy_3(__in,__cfg).__ST185078_Layout __PP2510197) := TRANSFORM
    __EE2510567 := __PP2510197.Best_Child_Record_;
    __ST805124_Layout __ND2510487__Project(B_Bankruptcy_3(__in,__cfg).__ST557655_Layout __PP2510254) := TRANSFORM
      SELF.Bus_Chapter11_ := __OP2(__PP2510254.Bus_Change_Chapter_,=,__CN('11'));
      SELF.Bus_Chapter13_ := __OP2(__PP2510254.Bus_Change_Chapter_,=,__CN('13'));
      SELF.Bus_Chapter7_ := __OP2(__PP2510254.Bus_Change_Chapter_,=,__CN('7'));
      SELF.Bus_Chapter_Type_ := __OP2(__PP2510254.Bus_Change_Chapter_,IN,__CN(['7','9','11','12','13','15']));
      SELF.Is_Disposed_ := __NOT(__NT(__PP2510254.Disposition_));
      SELF := __PP2510254;
    END;
    SELF.Best_Child_Record_ := __PROJECT(__EE2510567,__ND2510487__Project(LEFT));
    SELF := __PP2510197;
  END;
  EXPORT __ENH_Bankruptcy_2 := PROJECT(__EE2510609,__ND2510569__Project(LEFT));
END;
