//HPCC Systems KEL Compiler Version 1.6.0
IMPORT KEL16 AS KEL;
IMPORT B_Education_3,B_Education_7,CFG_Compile,E_Education FROM PublicRecords_KEL.KEL_Queries_MAS_FCRA;
IMPORT * FROM KEL16.Null;
EXPORT B_Education_2(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE
  SHARED VIRTUAL TYPEOF(B_Education_3(__in,__cfg).__ENH_Education_3) __ENH_Education_3 := B_Education_3(__in,__cfg).__ENH_Education_3;
  SHARED __EE1264719 := __ENH_Education_3;
  EXPORT __ST184533_Layout := RECORD
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
  SHARED __ST184533_Layout __ND1264851__Project(B_Education_7(__in,__cfg).__ST168064_Layout __PP1264720) := TRANSFORM
    __BS1264762 := __T(__PP1264720.College_Characteristics_);
    SELF.Coll_Rec_Flag_ := EXISTS(__BS1264762(__T(__OP2(__T(__PP1264720.College_Characteristics_).File_Type_,IN,__CN(['C','H','O'])))));
    SELF := __PP1264720;
  END;
  EXPORT __ENH_Education_2 := PROJECT(__EE1264719,__ND1264851__Project(LEFT));
END;
