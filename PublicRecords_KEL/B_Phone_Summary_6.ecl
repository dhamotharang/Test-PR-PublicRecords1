//HPCC Systems KEL Compiler Version 1.5.0rc1
IMPORT KEL15 AS KEL;
IMPORT CFG_Compile,E_Phone_Summary,FN_Compile FROM PublicRecords_KEL;
IMPORT * FROM KEL15.Null;
EXPORT B_Phone_Summary_6(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE
  SHARED VIRTUAL TYPEOF(E_Phone_Summary(__in,__cfg).__Result) __E_Phone_Summary := E_Phone_Summary(__in,__cfg).__Result;
  SHARED __EE504209 := __E_Phone_Summary;
  EXPORT __ST259603_Layout := RECORD
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
  EXPORT __ST259613_Layout := RECORD
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
  EXPORT __ST259629_Layout := RECORD
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
  EXPORT __ST259590_Layout := RECORD
    KEL.typ.nuid UID;
    KEL.typ.nstr Phone10_;
    KEL.typ.ndataset(E_Phone_Summary(__in,__cfg).Address_Header_Summary_Layout) Address_Header_Summary_;
    KEL.typ.ndataset(__ST259603_Layout) Address_Summary_;
    KEL.typ.ndataset(__ST259613_Layout) Date_Of_Birth_Summary_;
    KEL.typ.ndataset(E_Phone_Summary(__in,__cfg).Last_Name_Header_Summary_Layout) Last_Name_Header_Summary_;
    KEL.typ.ndataset(__ST259629_Layout) Last_Name_Summary_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  SHARED __ST259590_Layout __ND504599__Project(E_Phone_Summary(__in,__cfg).Layout __PP503972) := TRANSFORM
    __EE504030 := __PP503972.Address_Summary_;
    __ST259603_Layout __ND504401__Project(E_Phone_Summary(__in,__cfg).Address_Summary_Layout __PP504397) := TRANSFORM
      SELF.Translated_Source_ := FN_Compile(__cfg).FN_Consumer_Source_Group(__ECAST(KEL.typ.nstr,__PP504397.Source_));
      SELF := __PP504397;
    END;
    SELF.Address_Summary_ := __PROJECT(__EE504030,__ND504401__Project(LEFT));
    __EE504085 := __PP503972.Date_Of_Birth_Summary_;
    __ST259613_Layout __ND504480__Project(E_Phone_Summary(__in,__cfg).Date_Of_Birth_Summary_Layout __PP504476) := TRANSFORM
      SELF.Translated_Source_ := FN_Compile(__cfg).FN_Consumer_Source_Group(__ECAST(KEL.typ.nstr,__PP504476.Source_));
      SELF := __PP504476;
    END;
    SELF.Date_Of_Birth_Summary_ := __PROJECT(__EE504085,__ND504480__Project(LEFT));
    __EE504144 := __PP503972.Last_Name_Summary_;
    __ST259629_Layout __ND504577__Project(E_Phone_Summary(__in,__cfg).Last_Name_Summary_Layout __PP504573) := TRANSFORM
      SELF.Translated_Source_ := FN_Compile(__cfg).FN_Consumer_Source_Group(__ECAST(KEL.typ.nstr,__PP504573.Source_));
      SELF := __PP504573;
    END;
    SELF.Last_Name_Summary_ := __PROJECT(__EE504144,__ND504577__Project(LEFT));
    SELF := __PP503972;
  END;
  EXPORT __ENH_Phone_Summary_6 := PROJECT(__EE504209,__ND504599__Project(LEFT));
END;
