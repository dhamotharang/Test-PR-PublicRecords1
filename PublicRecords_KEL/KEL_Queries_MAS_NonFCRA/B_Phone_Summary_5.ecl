//HPCC Systems KEL Compiler Version 1.6.0
IMPORT KEL16 AS KEL;
IMPORT CFG_Compile,E_Phone_Summary,FN_Compile FROM PublicRecords_KEL.KEL_Queries_MAS_NonFCRA;
IMPORT * FROM KEL16.Null;
EXPORT B_Phone_Summary_5(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE
  SHARED VIRTUAL TYPEOF(E_Phone_Summary(__in,__cfg).__Result) __E_Phone_Summary := E_Phone_Summary(__in,__cfg).__Result;
  SHARED __EE291615 := __E_Phone_Summary;
  EXPORT __ST178380_Layout := RECORD
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
  EXPORT __ST178390_Layout := RECORD
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
  EXPORT __ST178406_Layout := RECORD
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
  EXPORT __ST178367_Layout := RECORD
    KEL.typ.nuid UID;
    KEL.typ.nstr Phone10_;
    KEL.typ.ndataset(E_Phone_Summary(__in,__cfg).Address_Header_Summary_Layout) Address_Header_Summary_;
    KEL.typ.ndataset(__ST178380_Layout) Address_Summary_;
    KEL.typ.ndataset(__ST178390_Layout) Date_Of_Birth_Summary_;
    KEL.typ.ndataset(E_Phone_Summary(__in,__cfg).Last_Name_Header_Summary_Layout) Last_Name_Header_Summary_;
    KEL.typ.ndataset(__ST178406_Layout) Last_Name_Summary_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  SHARED __ST178367_Layout __ND292005__Project(E_Phone_Summary(__in,__cfg).Layout __PP291378) := TRANSFORM
    __EE291436 := __PP291378.Address_Summary_;
    __ST178380_Layout __ND291807__Project(E_Phone_Summary(__in,__cfg).Address_Summary_Layout __PP291803) := TRANSFORM
      SELF.Translated_Source_ := FN_Compile(__cfg).FN_Consumer_Source_Group(__ECAST(KEL.typ.nstr,__PP291803.Source_));
      SELF := __PP291803;
    END;
    SELF.Address_Summary_ := __PROJECT(__EE291436,__ND291807__Project(LEFT));
    __EE291491 := __PP291378.Date_Of_Birth_Summary_;
    __ST178390_Layout __ND291886__Project(E_Phone_Summary(__in,__cfg).Date_Of_Birth_Summary_Layout __PP291882) := TRANSFORM
      SELF.Translated_Source_ := FN_Compile(__cfg).FN_Consumer_Source_Group(__ECAST(KEL.typ.nstr,__PP291882.Source_));
      SELF := __PP291882;
    END;
    SELF.Date_Of_Birth_Summary_ := __PROJECT(__EE291491,__ND291886__Project(LEFT));
    __EE291550 := __PP291378.Last_Name_Summary_;
    __ST178406_Layout __ND291983__Project(E_Phone_Summary(__in,__cfg).Last_Name_Summary_Layout __PP291979) := TRANSFORM
      SELF.Translated_Source_ := FN_Compile(__cfg).FN_Consumer_Source_Group(__ECAST(KEL.typ.nstr,__PP291979.Source_));
      SELF := __PP291979;
    END;
    SELF.Last_Name_Summary_ := __PROJECT(__EE291550,__ND291983__Project(LEFT));
    SELF := __PP291378;
  END;
  EXPORT __ENH_Phone_Summary_5 := PROJECT(__EE291615,__ND292005__Project(LEFT));
END;
