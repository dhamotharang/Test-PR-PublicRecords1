//HPCC Systems KEL Compiler Version 1.5.0rc1
IMPORT KEL15 AS KEL;
IMPORT CFG_Compile,E_Education FROM BRM_Marketing_attributes.BRM_KEL;
IMPORT * FROM KEL15.Null;
EXPORT B_Education_7(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE
  SHARED VIRTUAL TYPEOF(E_Education(__in,__cfg).__Result) __E_Education := E_Education(__in,__cfg).__Result;
  SHARED __EE228788 := __E_Education;
  EXPORT __ST158878_Layout := RECORD
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
  SHARED __ST158878_Layout __ND912609__Project(E_Education(__in,__cfg).Layout __PP228662) := TRANSFORM
    __BS228738 := __T(__PP228662.College_Characteristics_);
    SELF.Edu_Rec_Flag_ := EXISTS(__BS228738(__T(__OP2(__T(__PP228662.College_Characteristics_).File_Type_,IN,__CN(['M','C','H','O'])))));
    SELF := __PP228662;
  END;
  EXPORT __ENH_Education_7 := PROJECT(__EE228788,__ND912609__Project(LEFT));
END;
