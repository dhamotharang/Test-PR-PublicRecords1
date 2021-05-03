//HPCC Systems KEL Compiler Version 1.6.0
IMPORT KEL16 AS KEL;
IMPORT CFG_Compile,E_Address_Summary,FN_Compile FROM PublicRecords_KEL.KEL_Queries_MAS_NonFCRA;
IMPORT * FROM KEL16.Null;
EXPORT B_Address_Summary_5(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE
  SHARED VIRTUAL TYPEOF(E_Address_Summary(__in,__cfg).__Result) __E_Address_Summary := E_Address_Summary(__in,__cfg).__Result;
  SHARED __EE261682 := __E_Address_Summary;
  EXPORT __ST171374_Layout := RECORD
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
  EXPORT __ST171382_Layout := RECORD
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
  EXPORT __ST171368_Layout := RECORD
    KEL.typ.nuid UID;
    KEL.typ.nstr Primary_Name_;
    KEL.typ.nstr Primary_Range_;
    KEL.typ.nstr Zip_;
    KEL.typ.ndataset(__ST171374_Layout) Name_Summary_;
    KEL.typ.ndataset(__ST171382_Layout) Date_Of_Birth_Summary_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  SHARED __ST171368_Layout __ND261839__Project(E_Address_Summary(__in,__cfg).Layout __PP261558) := TRANSFORM
    __EE261585 := __PP261558.Name_Summary_;
    __ST171374_Layout __ND261772__Project(E_Address_Summary(__in,__cfg).Name_Summary_Layout __PP261768) := TRANSFORM
      SELF.Translated_Source_Code_ := FN_Compile(__cfg).FN_Consumer_Source_Group(__ECAST(KEL.typ.nstr,__PP261768.Name_Source_));
      SELF := __PP261768;
    END;
    SELF.Name_Summary_ := __PROJECT(__EE261585,__ND261772__Project(LEFT));
    __EE261630 := __PP261558.Date_Of_Birth_Summary_;
    __ST171382_Layout __ND261817__Project(E_Address_Summary(__in,__cfg).Date_Of_Birth_Summary_Layout __PP261813) := TRANSFORM
      SELF.D_O_B_Translated_Source_Code_ := FN_Compile(__cfg).FN_Consumer_Source_Group(__ECAST(KEL.typ.nstr,__PP261813.Dob_Source_));
      SELF := __PP261813;
    END;
    SELF.Date_Of_Birth_Summary_ := __PROJECT(__EE261630,__ND261817__Project(LEFT));
    SELF := __PP261558;
  END;
  EXPORT __ENH_Address_Summary_5 := PROJECT(__EE261682,__ND261839__Project(LEFT));
END;
