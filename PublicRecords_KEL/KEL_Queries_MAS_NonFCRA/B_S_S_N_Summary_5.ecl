//HPCC Systems KEL Compiler Version 1.5.0rc1
IMPORT KEL15 AS KEL;
IMPORT CFG_Compile,E_S_S_N_Summary,FN_Compile FROM PublicRecords_KEL.KEL_Queries_MAS_NonFCRA;
IMPORT * FROM KEL15.Null;
EXPORT B_S_S_N_Summary_5(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE
  SHARED VIRTUAL TYPEOF(E_S_S_N_Summary(__in,__cfg).__Result) __E_S_S_N_Summary := E_S_S_N_Summary(__in,__cfg).__Result;
  SHARED __EE409779 := __E_S_S_N_Summary;
  EXPORT __ST205448_Layout := RECORD
    KEL.typ.nstr Address_Primary_Name_;
    KEL.typ.nstr Address_Primary_Range_;
    KEL.typ.nstr Address_Zip_;
    KEL.typ.nstr Address_Source_;
    KEL.typ.nint Address_Record_Count_;
    KEL.typ.nstr Translated_Source_Code_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  EXPORT __ST205457_Layout := RECORD
    KEL.typ.nkdate Dob_Date_Of_Birth_;
    KEL.typ.nstr Dob_Date_Of_Birth_Padded_;
    KEL.typ.nstr Dob_Source_;
    KEL.typ.nint Dob_Record_Count_;
    KEL.typ.nstr Translated_Source_Code_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  EXPORT __ST205465_Layout := RECORD
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
  EXPORT __ST205473_Layout := RECORD
    KEL.typ.nint Phone_Number_;
    KEL.typ.nstr Phone_Source_;
    KEL.typ.nint Phone_Record_Count_;
    KEL.typ.nstr Phone_Translated_Source_Code_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  EXPORT __ST205444_Layout := RECORD
    KEL.typ.nuid UID;
    KEL.typ.nstr S_S_N_;
    KEL.typ.ndataset(__ST205448_Layout) Address_Summary_;
    KEL.typ.ndataset(__ST205457_Layout) Date_Of_Birth_Summary_;
    KEL.typ.ndataset(__ST205465_Layout) Name_Summary_;
    KEL.typ.ndataset(__ST205473_Layout) Phone_Summary_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  SHARED __ST205444_Layout __ND410084__Project(E_S_S_N_Summary(__in,__cfg).Layout __PP409569) := TRANSFORM
    __EE409592 := __PP409569.Address_Summary_;
    __ST205448_Layout __ND409927__Project(E_S_S_N_Summary(__in,__cfg).Address_Summary_Layout __PP409923) := TRANSFORM
      SELF.Translated_Source_Code_ := FN_Compile(__cfg).FN_Consumer_Source_Group(__ECAST(KEL.typ.nstr,__PP409923.Address_Source_));
      SELF := __PP409923;
    END;
    SELF.Address_Summary_ := __PROJECT(__EE409592,__ND409927__Project(LEFT));
    __EE409642 := __PP409569.Date_Of_Birth_Summary_;
    __ST205457_Layout __ND409976__Project(E_S_S_N_Summary(__in,__cfg).Date_Of_Birth_Summary_Layout __PP409972) := TRANSFORM
      SELF.Translated_Source_Code_ := FN_Compile(__cfg).FN_Consumer_Source_Group(__ECAST(KEL.typ.nstr,__PP409972.Dob_Source_));
      SELF := __PP409972;
    END;
    SELF.Date_Of_Birth_Summary_ := __PROJECT(__EE409642,__ND409976__Project(LEFT));
    __EE409687 := __PP409569.Name_Summary_;
    __ST205465_Layout __ND410021__Project(E_S_S_N_Summary(__in,__cfg).Name_Summary_Layout __PP410017) := TRANSFORM
      SELF.Translated_Source_Code_ := FN_Compile(__cfg).FN_Consumer_Source_Group(__ECAST(KEL.typ.nstr,__PP410017.Name_Source_));
      SELF := __PP410017;
    END;
    SELF.Name_Summary_ := __PROJECT(__EE409687,__ND410021__Project(LEFT));
    __EE409732 := __PP409569.Phone_Summary_;
    __ST205473_Layout __ND410066__Project(E_S_S_N_Summary(__in,__cfg).Phone_Summary_Layout __PP410062) := TRANSFORM
      SELF.Phone_Translated_Source_Code_ := FN_Compile(__cfg).FN_Consumer_Source_Group(__ECAST(KEL.typ.nstr,__PP410062.Phone_Source_));
      SELF := __PP410062;
    END;
    SELF.Phone_Summary_ := __PROJECT(__EE409732,__ND410066__Project(LEFT));
    SELF := __PP409569;
  END;
  EXPORT __ENH_S_S_N_Summary_5 := PROJECT(__EE409779,__ND410084__Project(LEFT));
END;
