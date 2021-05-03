//HPCC Systems KEL Compiler Version 1.5.0rc1
IMPORT KEL15 AS KEL;
IMPORT CFG_Compile,E_Bankruptcy FROM PublicRecords_KEL.KEL_Queries_MAS_NonFCRA;
IMPORT * FROM KEL15.Null;
EXPORT B_Bankruptcy_9(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE
  SHARED VIRTUAL TYPEOF(E_Bankruptcy(__in,__cfg).__Result) __E_Bankruptcy := E_Bankruptcy(__in,__cfg).__Result;
  SHARED __EE296740 := __E_Bankruptcy;
  EXPORT __ST211660_Layout := RECORD
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
  EXPORT __ST211653_Layout := RECORD
    KEL.typ.nuid UID;
    KEL.typ.nstr T_M_S_I_D_;
    KEL.typ.nstr Court_Code_;
    KEL.typ.nstr Case_Number_;
    KEL.typ.nstr Original_Case_Number_;
    KEL.typ.ndataset(__ST211660_Layout) Records_;
    KEL.typ.ndataset(E_Bankruptcy(__in,__cfg).Case_Details_Layout) Case_Details_;
    KEL.typ.ndataset(E_Bankruptcy(__in,__cfg).Data_Sources_Layout) Data_Sources_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  SHARED __ST211653_Layout __ND4687697__Project(E_Bankruptcy(__in,__cfg).Layout __PP296534) := TRANSFORM
    __EE296577 := __PP296534.Records_;
    __ST211660_Layout __ND4687676__Project(E_Bankruptcy(__in,__cfg).Records_Layout __PP296890) := TRANSFORM
      SELF.Child_Sort_List_ := MAP(__T(__NT(__PP296890.Disposition_))=>1,__T(__OP2(__PP296890.Disposition_,=,__CN('Dismissed')))=>2,__T(__OP2(__PP296890.Disposition_,=,__CN('Discharged')))=>3,__T(__OP2(__PP296890.Disposition_,=,__CN('Discharge NA')))=>4,__T(__OP2(__PP296890.Disposition_,=,__CN('Discharge Granted')))=>5,__T(__OP2(__PP296890.Disposition_,=,__CN('Closed')))=>6,7);
      SELF := __PP296890;
    END;
    SELF.Records_ := __PROJECT(__EE296577,__ND4687676__Project(LEFT));
    SELF := __PP296534;
  END;
  EXPORT __ENH_Bankruptcy_9 := PROJECT(__EE296740,__ND4687697__Project(LEFT));
END;
