//HPCC Systems KEL Compiler Version 1.6.0
IMPORT KEL16 AS KEL;
IMPORT CFG_Compile,E_Phone_Summary,FN_Compile FROM PublicRecords_KEL.KEL_Queries_MAS_NonFCRA;
IMPORT * FROM KEL16.Null;
EXPORT B_Phone_Summary_5(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE
  SHARED VIRTUAL TYPEOF(E_Phone_Summary(__in,__cfg).__Result) __E_Phone_Summary := E_Phone_Summary(__in,__cfg).__Result;
  SHARED __EE297554 := __E_Phone_Summary;
  EXPORT __ST183485_Layout := RECORD
    KEL.typ.nstr Primary_Name_;
    KEL.typ.nstr Primary_Range_;
    KEL.typ.nstr Zip_;
    KEL.typ.nint Record_Count_;
    KEL.typ.nstr Source_;
    KEL.typ.nbool Header_Hit_Flag_;
    KEL.typ.nstr Translated_Source_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  EXPORT __ST183495_Layout := RECORD
    KEL.typ.nkdate Date_Of_Birth_;
    KEL.typ.nstr Date_Of_Birth_Padded_;
    KEL.typ.nint Record_Count_;
    KEL.typ.nstr Source_;
    KEL.typ.nbool Header_Hit_Flag_;
    KEL.typ.nstr Translated_Source_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  EXPORT __ST183511_Layout := RECORD
    KEL.typ.nstr Last_Name_;
    KEL.typ.nint Record_Count_;
    KEL.typ.nstr Source_;
    KEL.typ.nbool Header_Hit_Flag_;
    KEL.typ.nstr Translated_Source_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  EXPORT __ST183472_Layout := RECORD
    KEL.typ.nuid UID;
    KEL.typ.nstr Phone10_;
    KEL.typ.ndataset(E_Phone_Summary(__in,__cfg).Address_Header_Summary_Layout) Address_Header_Summary_;
    KEL.typ.ndataset(__ST183485_Layout) Address_Summary_;
    KEL.typ.ndataset(__ST183495_Layout) Date_Of_Birth_Summary_;
    KEL.typ.ndataset(E_Phone_Summary(__in,__cfg).Last_Name_Header_Summary_Layout) Last_Name_Header_Summary_;
    KEL.typ.ndataset(__ST183511_Layout) Last_Name_Summary_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  SHARED __ST183472_Layout __ND297944__Project(E_Phone_Summary(__in,__cfg).Layout __PP297317) := TRANSFORM
    __EE297375 := __PP297317.Address_Summary_;
    __ST183485_Layout __ND297746__Project(E_Phone_Summary(__in,__cfg).Address_Summary_Layout __PP297742) := TRANSFORM
      SELF.Translated_Source_ := FN_Compile(__cfg).FN_Consumer_Source_Group(__ECAST(KEL.typ.nstr,__PP297742.Source_));
      SELF := __PP297742;
    END;
    SELF.Address_Summary_ := __PROJECT(__EE297375,__ND297746__Project(LEFT));
    __EE297430 := __PP297317.Date_Of_Birth_Summary_;
    __ST183495_Layout __ND297825__Project(E_Phone_Summary(__in,__cfg).Date_Of_Birth_Summary_Layout __PP297821) := TRANSFORM
      SELF.Translated_Source_ := FN_Compile(__cfg).FN_Consumer_Source_Group(__ECAST(KEL.typ.nstr,__PP297821.Source_));
      SELF := __PP297821;
    END;
    SELF.Date_Of_Birth_Summary_ := __PROJECT(__EE297430,__ND297825__Project(LEFT));
    __EE297489 := __PP297317.Last_Name_Summary_;
    __ST183511_Layout __ND297922__Project(E_Phone_Summary(__in,__cfg).Last_Name_Summary_Layout __PP297918) := TRANSFORM
      SELF.Translated_Source_ := FN_Compile(__cfg).FN_Consumer_Source_Group(__ECAST(KEL.typ.nstr,__PP297918.Source_));
      SELF := __PP297918;
    END;
    SELF.Last_Name_Summary_ := __PROJECT(__EE297489,__ND297922__Project(LEFT));
    SELF := __PP297317;
  END;
  EXPORT __ENH_Phone_Summary_5 := PROJECT(__EE297554,__ND297944__Project(LEFT));
END;
