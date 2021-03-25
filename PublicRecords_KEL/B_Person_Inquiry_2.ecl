//HPCC Systems KEL Compiler Version 1.5.0rc1
IMPORT KEL15 AS KEL;
IMPORT B_Person_Inquiry_3,CFG_Compile,E_Inquiry,E_Person,E_Person_Inquiry FROM PublicRecords_KEL;
IMPORT * FROM KEL15.Null;
EXPORT B_Person_Inquiry_2(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE
  SHARED VIRTUAL TYPEOF(B_Person_Inquiry_3(__in,__cfg).__ENH_Person_Inquiry_3) __ENH_Person_Inquiry_3 := B_Person_Inquiry_3(__in,__cfg).__ENH_Person_Inquiry_3;
  SHARED __EE8068183 := __ENH_Person_Inquiry_3;
  EXPORT __ST223327_Layout := RECORD
    KEL.typ.ntyp(E_Person().Typ) Subject_;
    KEL.typ.ntyp(E_Inquiry().Typ) Transaction_;
    KEL.typ.nstr Transaction_I_D_;
    KEL.typ.nstr Sequence_Number_;
    KEL.typ.ndataset(E_Person_Inquiry(__in,__cfg).Data_Sources_Layout) Data_Sources_;
    KEL.typ.ndataset(B_Person_Inquiry_3(__in,__cfg).__ST1258040_Layout) Gather_Inquiries_;
    KEL.typ.timestamp Archive___Date_ := 0;
    KEL.typ.timestamp Date_First_Seen_ := 0;
    KEL.typ.timestamp Date_Last_Seen_ := 0;
    KEL.typ.timestamp Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  EXPORT __ENH_Person_Inquiry_2 := PROJECT(__EE8068183,__ST223327_Layout);
END;
