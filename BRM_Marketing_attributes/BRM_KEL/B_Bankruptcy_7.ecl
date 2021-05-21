//HPCC Systems KEL Compiler Version 1.6.0
IMPORT KEL16 AS KEL;
IMPORT CFG_Compile,E_Bankruptcy FROM BRM_Marketing_attributes.BRM_KEL;
IMPORT * FROM KEL16.Null;
EXPORT B_Bankruptcy_7(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE
  SHARED VIRTUAL TYPEOF(E_Bankruptcy(__in,__cfg).__Result) __E_Bankruptcy := E_Bankruptcy(__in,__cfg).__Result;
  SHARED __EE221200 := __E_Bankruptcy;
  EXPORT __ST166538_Layout := RECORD
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
    KEL.typ.int Child_Sort_List_ := 0;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  EXPORT __ST166531_Layout := RECORD
    KEL.typ.nuid UID;
    KEL.typ.nstr T_M_S_I_D_;
    KEL.typ.nstr Court_Code_;
    KEL.typ.nstr Case_Number_;
    KEL.typ.nstr Original_Case_Number_;
    KEL.typ.ndataset(__ST166538_Layout) Records_;
    KEL.typ.ndataset(E_Bankruptcy(__in,__cfg).Case_Details_Layout) Case_Details_;
    KEL.typ.ndataset(E_Bankruptcy(__in,__cfg).Data_Sources_Layout) Data_Sources_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  SHARED __ST166531_Layout __ND823378__Project(E_Bankruptcy(__in,__cfg).Layout __PP220994) := TRANSFORM
    __EE221037 := __PP220994.Records_;
    __ST166538_Layout __ND823357__Project(E_Bankruptcy(__in,__cfg).Records_Layout __PP221350) := TRANSFORM
      SELF.Child_Sort_List_ := MAP(__T(__NT(__PP221350.Disposition_))=>1,__T(__OP2(__PP221350.Disposition_,=,__CN('Dismissed')))=>2,__T(__OP2(__PP221350.Disposition_,=,__CN('Discharged')))=>3,__T(__OP2(__PP221350.Disposition_,=,__CN('Discharge NA')))=>4,__T(__OP2(__PP221350.Disposition_,=,__CN('Discharge Granted')))=>5,__T(__OP2(__PP221350.Disposition_,=,__CN('Closed')))=>6,7);
      SELF := __PP221350;
    END;
    SELF.Records_ := __PROJECT(__EE221037,__ND823357__Project(LEFT));
    SELF := __PP220994;
  END;
  EXPORT __ENH_Bankruptcy_7 := PROJECT(__EE221200,__ND823378__Project(LEFT));
END;
