//HPCC Systems KEL Compiler Version 1.5.0rc1
IMPORT KEL15 AS KEL;
IMPORT CFG_Compile,E_Education FROM PublicRecords_KEL;
IMPORT * FROM KEL15.Null;
EXPORT B_Education_7(CFG_Compile __cfg = CFG_Compile) := MODULE
  SHARED VIRTUAL TYPEOF(E_Education(__cfg).__Result) __E_Education := E_Education(__cfg).__Result;
  SHARED __EE418045 := __E_Education;
  EXPORT __ST256522_Layout := RECORD
    KEL.typ.nuid UID;
    KEL.typ.nstr College_Name_;
    KEL.typ.nstr L_N_College_Name_;
    KEL.typ.nstr Sequence_;
    KEL.typ.nstr Key_;
    KEL.typ.nstr Raw_A_I_D_;
    KEL.typ.ndataset(E_Education(__cfg).College_Characteristics_Layout) College_Characteristics_;
    KEL.typ.ndataset(E_Education(__cfg).Data_Sources_Layout) Data_Sources_;
    KEL.typ.bool Edu_Rec_Flag_ := FALSE;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  SHARED __ST256522_Layout __ND5255418__Project(E_Education(__cfg).Layout __PP417919) := TRANSFORM
    __BS417995 := __T(__PP417919.College_Characteristics_);
    SELF.Edu_Rec_Flag_ := EXISTS(__BS417995(__T(__OP2(__T(__PP417919.College_Characteristics_).File_Type_,IN,__CN(['M','C','H','O'])))));
    SELF := __PP417919;
  END;
  EXPORT __ENH_Education_7 := PROJECT(__EE418045,__ND5255418__Project(LEFT));
END;
