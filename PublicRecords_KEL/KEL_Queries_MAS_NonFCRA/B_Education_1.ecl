//HPCC Systems KEL Compiler Version 1.6.0
IMPORT KEL16 AS KEL;
IMPORT B_Education_2,B_Education_8,CFG_Compile,E_Education FROM PublicRecords_KEL.KEL_Queries_MAS_NonFCRA;
IMPORT * FROM KEL16.Null;
EXPORT B_Education_1(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE
  SHARED VIRTUAL TYPEOF(B_Education_2(__in,__cfg).__ENH_Education_2) __ENH_Education_2 := B_Education_2(__in,__cfg).__ENH_Education_2;
  SHARED __EE2579541 := __ENH_Education_2;
  EXPORT __ST162399_Layout := RECORD
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
  SHARED __ST162399_Layout __ND2579673__Project(B_Education_8(__in,__cfg).__ST186956_Layout __PP2579542) := TRANSFORM
    __BS2579584 := __T(__PP2579542.College_Characteristics_);
    SELF.Coll_Rec_Flag_ := EXISTS(__BS2579584(__T(__OP2(__T(__PP2579542.College_Characteristics_).File_Type_,IN,__CN(['C','H','O'])))));
    SELF := __PP2579542;
  END;
  EXPORT __ENH_Education_1 := PROJECT(__EE2579541,__ND2579673__Project(LEFT));
END;
