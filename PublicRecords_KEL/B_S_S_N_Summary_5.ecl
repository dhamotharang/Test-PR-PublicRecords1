//HPCC Systems KEL Compiler Version 1.5.0rc1
IMPORT KEL15 AS KEL;
IMPORT CFG_Compile,E_S_S_N_Summary,FN_Compile FROM PublicRecords_KEL;
IMPORT * FROM KEL15.Null;
EXPORT B_S_S_N_Summary_5(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE
  SHARED VIRTUAL TYPEOF(E_S_S_N_Summary(__in,__cfg).__Result) __E_S_S_N_Summary := E_S_S_N_Summary(__in,__cfg).__Result;
  SHARED __EE605174 := __E_S_S_N_Summary;
  EXPORT __ST260701_Layout := RECORD
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
  EXPORT __ST260710_Layout := RECORD
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
  EXPORT __ST260718_Layout := RECORD
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
  EXPORT __ST260726_Layout := RECORD
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
  EXPORT __ST260697_Layout := RECORD
    KEL.typ.nuid UID;
    KEL.typ.nstr S_S_N_;
    KEL.typ.ndataset(__ST260701_Layout) Address_Summary_;
    KEL.typ.ndataset(__ST260710_Layout) Date_Of_Birth_Summary_;
    KEL.typ.ndataset(__ST260718_Layout) Name_Summary_;
    KEL.typ.ndataset(__ST260726_Layout) Phone_Summary_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  SHARED __ST260697_Layout __ND605479__Project(E_S_S_N_Summary(__in,__cfg).Layout __PP604964) := TRANSFORM
    __EE604987 := __PP604964.Address_Summary_;
    __ST260701_Layout __ND605322__Project(E_S_S_N_Summary(__in,__cfg).Address_Summary_Layout __PP605318) := TRANSFORM
      SELF.Translated_Source_Code_ := FN_Compile(__cfg).FN_Consumer_Source_Group(__ECAST(KEL.typ.nstr,__PP605318.Address_Source_));
      SELF := __PP605318;
    END;
    SELF.Address_Summary_ := __PROJECT(__EE604987,__ND605322__Project(LEFT));
    __EE605037 := __PP604964.Date_Of_Birth_Summary_;
    __ST260710_Layout __ND605371__Project(E_S_S_N_Summary(__in,__cfg).Date_Of_Birth_Summary_Layout __PP605367) := TRANSFORM
      SELF.Translated_Source_Code_ := FN_Compile(__cfg).FN_Consumer_Source_Group(__ECAST(KEL.typ.nstr,__PP605367.Dob_Source_));
      SELF := __PP605367;
    END;
    SELF.Date_Of_Birth_Summary_ := __PROJECT(__EE605037,__ND605371__Project(LEFT));
    __EE605082 := __PP604964.Name_Summary_;
    __ST260718_Layout __ND605416__Project(E_S_S_N_Summary(__in,__cfg).Name_Summary_Layout __PP605412) := TRANSFORM
      SELF.Translated_Source_Code_ := FN_Compile(__cfg).FN_Consumer_Source_Group(__ECAST(KEL.typ.nstr,__PP605412.Name_Source_));
      SELF := __PP605412;
    END;
    SELF.Name_Summary_ := __PROJECT(__EE605082,__ND605416__Project(LEFT));
    __EE605127 := __PP604964.Phone_Summary_;
    __ST260726_Layout __ND605461__Project(E_S_S_N_Summary(__in,__cfg).Phone_Summary_Layout __PP605457) := TRANSFORM
      SELF.Phone_Translated_Source_Code_ := FN_Compile(__cfg).FN_Consumer_Source_Group(__ECAST(KEL.typ.nstr,__PP605457.Phone_Source_));
      SELF := __PP605457;
    END;
    SELF.Phone_Summary_ := __PROJECT(__EE605127,__ND605461__Project(LEFT));
    SELF := __PP604964;
  END;
  EXPORT __ENH_S_S_N_Summary_5 := PROJECT(__EE605174,__ND605479__Project(LEFT));
END;
