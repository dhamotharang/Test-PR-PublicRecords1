//HPCC Systems KEL Compiler Version 1.5.0rc1
IMPORT KEL15 AS KEL;
IMPORT B_Person_Inquiry_2,B_Person_Inquiry_3,CFG_Compile,E_Inquiry,E_Person,E_Person_Inquiry FROM PublicRecords_KEL;
IMPORT * FROM KEL15.Null;
EXPORT B_Person_Inquiry_1(CFG_Compile __cfg = CFG_Compile) := MODULE
  SHARED VIRTUAL TYPEOF(B_Person_Inquiry_2(__cfg).__ENH_Person_Inquiry_2) __ENH_Person_Inquiry_2 := B_Person_Inquiry_2(__cfg).__ENH_Person_Inquiry_2;
  SHARED __EE8514939 := __ENH_Person_Inquiry_2;
  EXPORT __ST197574_Layout := RECORD
    KEL.typ.ntyp(E_Person().Typ) Subject_;
    KEL.typ.ntyp(E_Inquiry().Typ) Transaction_;
    KEL.typ.nstr Transaction_I_D_;
    KEL.typ.nstr Sequence_Number_;
    KEL.typ.ndataset(E_Person_Inquiry(__cfg).Data_Sources_Layout) Data_Sources_;
    KEL.typ.ndataset(B_Person_Inquiry_3(__cfg).__ST1215488_Layout) Gather_Inquiries_;
    KEL.typ.timestamp Archive___Date_ := 0;
    KEL.typ.timestamp Date_First_Seen_ := 0;
    KEL.typ.timestamp Date_Last_Seen_ := 0;
    KEL.typ.timestamp Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  EXPORT __ENH_Person_Inquiry_1 := PROJECT(__EE8514939,__ST197574_Layout);
END;
