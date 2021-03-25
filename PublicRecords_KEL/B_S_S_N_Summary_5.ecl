//HPCC Systems KEL Compiler Version 1.5.0rc1
IMPORT KEL15 AS KEL;
IMPORT CFG_Compile,E_S_S_N_Summary,FN_Compile FROM PublicRecords_KEL;
IMPORT * FROM KEL15.Null;
EXPORT B_S_S_N_Summary_5(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE
  SHARED VIRTUAL TYPEOF(E_S_S_N_Summary(__in,__cfg).__Result) __E_S_S_N_Summary := E_S_S_N_Summary(__in,__cfg).__Result;
  SHARED __EE601810 := __E_S_S_N_Summary;
  EXPORT __ST257815_Layout := RECORD
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
  EXPORT __ST257824_Layout := RECORD
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
  EXPORT __ST257832_Layout := RECORD
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
  EXPORT __ST257840_Layout := RECORD
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
  EXPORT __ST257811_Layout := RECORD
    KEL.typ.nuid UID;
    KEL.typ.nstr S_S_N_;
    KEL.typ.ndataset(__ST257815_Layout) Address_Summary_;
    KEL.typ.ndataset(__ST257824_Layout) Date_Of_Birth_Summary_;
    KEL.typ.ndataset(__ST257832_Layout) Name_Summary_;
    KEL.typ.ndataset(__ST257840_Layout) Phone_Summary_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  SHARED __ST257811_Layout __ND602115__Project(E_S_S_N_Summary(__in,__cfg).Layout __PP601600) := TRANSFORM
    __EE601623 := __PP601600.Address_Summary_;
    __ST257815_Layout __ND601958__Project(E_S_S_N_Summary(__in,__cfg).Address_Summary_Layout __PP601954) := TRANSFORM
      SELF.Translated_Source_Code_ := FN_Compile(__cfg).FN_Consumer_Source_Group(__ECAST(KEL.typ.nstr,__PP601954.Address_Source_));
      SELF := __PP601954;
    END;
    SELF.Address_Summary_ := __PROJECT(__EE601623,__ND601958__Project(LEFT));
    __EE601673 := __PP601600.Date_Of_Birth_Summary_;
    __ST257824_Layout __ND602007__Project(E_S_S_N_Summary(__in,__cfg).Date_Of_Birth_Summary_Layout __PP602003) := TRANSFORM
      SELF.Translated_Source_Code_ := FN_Compile(__cfg).FN_Consumer_Source_Group(__ECAST(KEL.typ.nstr,__PP602003.Dob_Source_));
      SELF := __PP602003;
    END;
    SELF.Date_Of_Birth_Summary_ := __PROJECT(__EE601673,__ND602007__Project(LEFT));
    __EE601718 := __PP601600.Name_Summary_;
    __ST257832_Layout __ND602052__Project(E_S_S_N_Summary(__in,__cfg).Name_Summary_Layout __PP602048) := TRANSFORM
      SELF.Translated_Source_Code_ := FN_Compile(__cfg).FN_Consumer_Source_Group(__ECAST(KEL.typ.nstr,__PP602048.Name_Source_));
      SELF := __PP602048;
    END;
    SELF.Name_Summary_ := __PROJECT(__EE601718,__ND602052__Project(LEFT));
    __EE601763 := __PP601600.Phone_Summary_;
    __ST257840_Layout __ND602097__Project(E_S_S_N_Summary(__in,__cfg).Phone_Summary_Layout __PP602093) := TRANSFORM
      SELF.Phone_Translated_Source_Code_ := FN_Compile(__cfg).FN_Consumer_Source_Group(__ECAST(KEL.typ.nstr,__PP602093.Phone_Source_));
      SELF := __PP602093;
    END;
    SELF.Phone_Summary_ := __PROJECT(__EE601763,__ND602097__Project(LEFT));
    SELF := __PP601600;
  END;
  EXPORT __ENH_S_S_N_Summary_5 := PROJECT(__EE601810,__ND602115__Project(LEFT));
END;
