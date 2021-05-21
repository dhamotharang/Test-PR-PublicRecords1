//HPCC Systems KEL Compiler Version 1.6.0
IMPORT KEL16 AS KEL;
IMPORT CFG_Compile,E_Education FROM PublicRecords_KEL.KEL_Queries_MAS_Business;
IMPORT * FROM KEL16.Null;
EXPORT B_Education_7(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE
  SHARED VIRTUAL TYPEOF(E_Education(__in,__cfg).__Result) __E_Education := E_Education(__in,__cfg).__Result;
  SHARED __EE317384 := __E_Education;
  EXPORT __ST218801_Layout := RECORD
    KEL.typ.nuid UID;
    KEL.typ.nstr College_Name_;
    KEL.typ.nstr L_N_College_Name_;
    KEL.typ.nstr Sequence_;
    KEL.typ.nstr Key_;
    KEL.typ.nstr Raw_A_I_D_;
    KEL.typ.ndataset(E_Education(__in,__cfg).College_Characteristics_Layout) College_Characteristics_;
    KEL.typ.ndataset(E_Education(__in,__cfg).Data_Sources_Layout) Data_Sources_;
    KEL.typ.bool Edu_Rec_Flag_ := FALSE;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  SHARED __ST218801_Layout __ND1906422__Project(E_Education(__in,__cfg).Layout __PP317258) := TRANSFORM
    __BS317334 := __T(__PP317258.College_Characteristics_);
    SELF.Edu_Rec_Flag_ := EXISTS(__BS317334(__T(__OP2(__T(__PP317258.College_Characteristics_).File_Type_,IN,__CN(['M','C','H','O'])))));
    SELF := __PP317258;
  END;
  EXPORT __ENH_Education_7 := PROJECT(__EE317384,__ND1906422__Project(LEFT));
END;
