//HPCC Systems KEL Compiler Version 1.5.0rc1
IMPORT KEL15 AS KEL;
IMPORT CFG_Compile,E_Phone_Summary,FN_Compile FROM PublicRecords_KEL;
IMPORT * FROM KEL15.Null;
EXPORT B_Phone_Summary_6(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE
  SHARED VIRTUAL TYPEOF(E_Phone_Summary(__in,__cfg).__Result) __E_Phone_Summary := E_Phone_Summary(__in,__cfg).__Result;
  SHARED __EE513642 := __E_Phone_Summary;
  EXPORT __ST269436_Layout := RECORD
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
  EXPORT __ST269446_Layout := RECORD
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
  EXPORT __ST269462_Layout := RECORD
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
  EXPORT __ST269423_Layout := RECORD
    KEL.typ.nuid UID;
    KEL.typ.nstr Phone10_;
    KEL.typ.ndataset(E_Phone_Summary(__in,__cfg).Address_Header_Summary_Layout) Address_Header_Summary_;
    KEL.typ.ndataset(__ST269436_Layout) Address_Summary_;
    KEL.typ.ndataset(__ST269446_Layout) Date_Of_Birth_Summary_;
    KEL.typ.ndataset(E_Phone_Summary(__in,__cfg).Last_Name_Header_Summary_Layout) Last_Name_Header_Summary_;
    KEL.typ.ndataset(__ST269462_Layout) Last_Name_Summary_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  SHARED __ST269423_Layout __ND514032__Project(E_Phone_Summary(__in,__cfg).Layout __PP513405) := TRANSFORM
    __EE513463 := __PP513405.Address_Summary_;
    __ST269436_Layout __ND513834__Project(E_Phone_Summary(__in,__cfg).Address_Summary_Layout __PP513830) := TRANSFORM
      SELF.Translated_Source_ := FN_Compile(__cfg).FN_Consumer_Source_Group(__ECAST(KEL.typ.nstr,__PP513830.Source_));
      SELF := __PP513830;
    END;
    SELF.Address_Summary_ := __PROJECT(__EE513463,__ND513834__Project(LEFT));
    __EE513518 := __PP513405.Date_Of_Birth_Summary_;
    __ST269446_Layout __ND513913__Project(E_Phone_Summary(__in,__cfg).Date_Of_Birth_Summary_Layout __PP513909) := TRANSFORM
      SELF.Translated_Source_ := FN_Compile(__cfg).FN_Consumer_Source_Group(__ECAST(KEL.typ.nstr,__PP513909.Source_));
      SELF := __PP513909;
    END;
    SELF.Date_Of_Birth_Summary_ := __PROJECT(__EE513518,__ND513913__Project(LEFT));
    __EE513577 := __PP513405.Last_Name_Summary_;
    __ST269462_Layout __ND514010__Project(E_Phone_Summary(__in,__cfg).Last_Name_Summary_Layout __PP514006) := TRANSFORM
      SELF.Translated_Source_ := FN_Compile(__cfg).FN_Consumer_Source_Group(__ECAST(KEL.typ.nstr,__PP514006.Source_));
      SELF := __PP514006;
    END;
    SELF.Last_Name_Summary_ := __PROJECT(__EE513577,__ND514010__Project(LEFT));
    SELF := __PP513405;
  END;
  EXPORT __ENH_Phone_Summary_6 := PROJECT(__EE513642,__ND514032__Project(LEFT));
END;
