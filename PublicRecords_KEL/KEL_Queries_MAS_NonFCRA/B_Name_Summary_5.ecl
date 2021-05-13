//HPCC Systems KEL Compiler Version 1.6.0
IMPORT KEL16 AS KEL;
IMPORT CFG_Compile,E_Name_Summary,FN_Compile FROM PublicRecords_KEL.KEL_Queries_MAS_NonFCRA;
IMPORT * FROM KEL16.Null;
EXPORT B_Name_Summary_5(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE
  SHARED VIRTUAL TYPEOF(E_Name_Summary(__in,__cfg).__Result) __E_Name_Summary := E_Name_Summary(__in,__cfg).__Result;
  SHARED __EE273434 := __E_Name_Summary;
  EXPORT __ST179501_Layout := RECORD
    KEL.typ.nstr Source_;
    KEL.typ.nstr Translated_Source_Code_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  EXPORT __ST179493_Layout := RECORD
    KEL.typ.nuid UID;
    KEL.typ.nstr First_Name_;
    KEL.typ.nstr Last_Name_;
    KEL.typ.nkdate Date_Of_Birth_;
    KEL.typ.nstr Date_Of_Birth_Padded_;
    KEL.typ.nint Record_Count_;
    KEL.typ.ndataset(__ST179501_Layout) Data_Sources_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  SHARED __ST179493_Layout __ND273496__Project(E_Name_Summary(__in,__cfg).Layout __PP273363) := TRANSFORM
    __EE273396 := __PP273363.Data_Sources_;
    __ST179501_Layout __ND273486__Project(E_Name_Summary(__in,__cfg).Data_Sources_Layout __PP273482) := TRANSFORM
      SELF.Translated_Source_Code_ := FN_Compile(__cfg).FN_Consumer_Source_Group(__ECAST(KEL.typ.nstr,__PP273482.Source_));
      SELF := __PP273482;
    END;
    SELF.Data_Sources_ := __PROJECT(__EE273396,__ND273486__Project(LEFT));
    SELF := __PP273363;
  END;
  EXPORT __ENH_Name_Summary_5 := PROJECT(__EE273434,__ND273496__Project(LEFT));
END;
