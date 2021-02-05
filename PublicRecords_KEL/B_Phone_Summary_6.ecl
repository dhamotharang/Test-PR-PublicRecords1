//HPCC Systems KEL Compiler Version 1.5.0rc1
IMPORT KEL15 AS KEL;
IMPORT CFG_Compile,E_Phone_Summary,FN_Compile FROM PublicRecords_KEL;
IMPORT * FROM KEL15.Null;
EXPORT B_Phone_Summary_6(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE
  SHARED VIRTUAL TYPEOF(E_Phone_Summary(__in,__cfg).__Result) __E_Phone_Summary := E_Phone_Summary(__in,__cfg).__Result;
  SHARED __EE490344 := __E_Phone_Summary;
  EXPORT __ST254700_Layout := RECORD
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
  EXPORT __ST254710_Layout := RECORD
    KEL.typ.nkdate Date_Of_Birth_;
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
  EXPORT __ST254725_Layout := RECORD
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
  EXPORT __ST254687_Layout := RECORD
    KEL.typ.nuid UID;
    KEL.typ.nstr Phone10_;
    KEL.typ.ndataset(E_Phone_Summary(__in,__cfg).Address_Header_Summary_Layout) Address_Header_Summary_;
    KEL.typ.ndataset(__ST254700_Layout) Address_Summary_;
    KEL.typ.ndataset(__ST254710_Layout) Date_Of_Birth_Summary_;
    KEL.typ.ndataset(E_Phone_Summary(__in,__cfg).Last_Name_Header_Summary_Layout) Last_Name_Header_Summary_;
    KEL.typ.ndataset(__ST254725_Layout) Last_Name_Summary_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  SHARED __ST254687_Layout __ND490726__Project(E_Phone_Summary(__in,__cfg).Layout __PP490112) := TRANSFORM
    __EE490170 := __PP490112.Address_Summary_;
    __ST254700_Layout __ND490532__Project(E_Phone_Summary(__in,__cfg).Address_Summary_Layout __PP490528) := TRANSFORM
      SELF.Translated_Source_ := FN_Compile(__cfg).FN_Consumer_Source_Group(__ECAST(KEL.typ.nstr,__PP490528.Source_));
      SELF := __PP490528;
    END;
    SELF.Address_Summary_ := __PROJECT(__EE490170,__ND490532__Project(LEFT));
    __EE490225 := __PP490112.Date_Of_Birth_Summary_;
    __ST254710_Layout __ND490611__Project(E_Phone_Summary(__in,__cfg).Date_Of_Birth_Summary_Layout __PP490607) := TRANSFORM
      SELF.Translated_Source_ := FN_Compile(__cfg).FN_Consumer_Source_Group(__ECAST(KEL.typ.nstr,__PP490607.Source_));
      SELF := __PP490607;
    END;
    SELF.Date_Of_Birth_Summary_ := __PROJECT(__EE490225,__ND490611__Project(LEFT));
    __EE490279 := __PP490112.Last_Name_Summary_;
    __ST254725_Layout __ND490704__Project(E_Phone_Summary(__in,__cfg).Last_Name_Summary_Layout __PP490700) := TRANSFORM
      SELF.Translated_Source_ := FN_Compile(__cfg).FN_Consumer_Source_Group(__ECAST(KEL.typ.nstr,__PP490700.Source_));
      SELF := __PP490700;
    END;
    SELF.Last_Name_Summary_ := __PROJECT(__EE490279,__ND490704__Project(LEFT));
    SELF := __PP490112;
  END;
  EXPORT __ENH_Phone_Summary_6 := PROJECT(__EE490344,__ND490726__Project(LEFT));
END;
