//HPCC Systems KEL Compiler Version 1.6.0
IMPORT KEL16 AS KEL;
IMPORT CFG_Compile,E_Address_Summary,FN_Compile FROM PublicRecords_KEL.KEL_Queries_MAS_NonFCRA;
IMPORT * FROM KEL16.Null;
EXPORT B_Address_Summary_5(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE
  SHARED VIRTUAL TYPEOF(E_Address_Summary(__in,__cfg).__Result) __E_Address_Summary := E_Address_Summary(__in,__cfg).__Result;
  SHARED __EE261613 := __E_Address_Summary;
  EXPORT __ST175669_Layout := RECORD
    KEL.typ.nstr Name_First_Name_;
    KEL.typ.nstr Name_Last_Name_;
    KEL.typ.nstr Name_Source_;
    KEL.typ.nint Name_Record_Count_;
    KEL.typ.nstr Translated_Source_Code_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  EXPORT __ST175677_Layout := RECORD
    KEL.typ.nkdate Dob_Date_Of_Birth_;
    KEL.typ.nstr Dob_Date_Of_Birth_Padded_;
    KEL.typ.nstr Dob_Source_;
    KEL.typ.nint Dob_Record_Count_;
    KEL.typ.nstr D_O_B_Translated_Source_Code_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  EXPORT __ST175663_Layout := RECORD
    KEL.typ.nuid UID;
    KEL.typ.nstr Primary_Name_;
    KEL.typ.nstr Primary_Range_;
    KEL.typ.nstr Zip_;
    KEL.typ.ndataset(__ST175669_Layout) Name_Summary_;
    KEL.typ.ndataset(__ST175677_Layout) Date_Of_Birth_Summary_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  SHARED __ST175663_Layout __ND261770__Project(E_Address_Summary(__in,__cfg).Layout __PP261489) := TRANSFORM
    __EE261516 := __PP261489.Name_Summary_;
    __ST175669_Layout __ND261703__Project(E_Address_Summary(__in,__cfg).Name_Summary_Layout __PP261699) := TRANSFORM
      SELF.Translated_Source_Code_ := FN_Compile(__cfg).FN_Consumer_Source_Group(__ECAST(KEL.typ.nstr,__PP261699.Name_Source_));
      SELF := __PP261699;
    END;
    SELF.Name_Summary_ := __PROJECT(__EE261516,__ND261703__Project(LEFT));
    __EE261561 := __PP261489.Date_Of_Birth_Summary_;
    __ST175677_Layout __ND261748__Project(E_Address_Summary(__in,__cfg).Date_Of_Birth_Summary_Layout __PP261744) := TRANSFORM
      SELF.D_O_B_Translated_Source_Code_ := FN_Compile(__cfg).FN_Consumer_Source_Group(__ECAST(KEL.typ.nstr,__PP261744.Dob_Source_));
      SELF := __PP261744;
    END;
    SELF.Date_Of_Birth_Summary_ := __PROJECT(__EE261561,__ND261748__Project(LEFT));
    SELF := __PP261489;
  END;
  EXPORT __ENH_Address_Summary_5 := PROJECT(__EE261613,__ND261770__Project(LEFT));
END;
