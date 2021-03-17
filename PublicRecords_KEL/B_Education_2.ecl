//HPCC Systems KEL Compiler Version 1.5.0rc1
IMPORT KEL15 AS KEL;
IMPORT B_Education_3,B_Education_7,CFG_Compile,E_Education FROM PublicRecords_KEL;
IMPORT * FROM KEL15.Null;
EXPORT B_Education_2(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE
  SHARED VIRTUAL TYPEOF(B_Education_3(__in,__cfg).__ENH_Education_3) __ENH_Education_3 := B_Education_3(__in,__cfg).__ENH_Education_3;
  SHARED __EE7126645 := __ENH_Education_3;
  EXPORT __ST213677_Layout := RECORD
    KEL.typ.nuid UID;
    KEL.typ.nstr College_Name_;
    KEL.typ.nstr L_N_College_Name_;
    KEL.typ.nstr Sequence_;
    KEL.typ.nstr Key_;
    KEL.typ.nstr Raw_A_I_D_;
    KEL.typ.ndataset(E_Education(__in,__cfg).College_Characteristics_Layout) College_Characteristics_;
    KEL.typ.ndataset(E_Education(__in,__cfg).Data_Sources_Layout) Data_Sources_;
    KEL.typ.bool Coll_Rec_Flag_ := FALSE;
    KEL.typ.bool Edu_Rec_Flag_ := FALSE;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  SHARED __ST213677_Layout __ND7126777__Project(B_Education_7(__in,__cfg).__ST261584_Layout __PP7126646) := TRANSFORM
    __BS7126688 := __T(__PP7126646.College_Characteristics_);
    SELF.Coll_Rec_Flag_ := EXISTS(__BS7126688(__T(__OP2(__T(__PP7126646.College_Characteristics_).File_Type_,IN,__CN(['C','H','O'])))));
    SELF := __PP7126646;
  END;
  EXPORT __ENH_Education_2 := PROJECT(__EE7126645,__ND7126777__Project(LEFT));
END;
