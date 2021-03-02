//HPCC Systems KEL Compiler Version 1.5.0rc1
IMPORT KEL15 AS KEL;
IMPORT CFG_Compile,E_S_S_N_Summary,FN_Compile FROM PublicRecords_KEL;
IMPORT * FROM KEL15.Null;
EXPORT B_S_S_N_Summary_5(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE
  SHARED VIRTUAL TYPEOF(E_S_S_N_Summary(__in,__cfg).__Result) __E_S_S_N_Summary := E_S_S_N_Summary(__in,__cfg).__Result;
  SHARED __EE604798 := __E_S_S_N_Summary;
  EXPORT __ST262996_Layout := RECORD
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
  EXPORT __ST263005_Layout := RECORD
    KEL.typ.nkdate Dob_Date_Of_Birth_;
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
  EXPORT __ST263012_Layout := RECORD
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
  EXPORT __ST263020_Layout := RECORD
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
  EXPORT __ST262992_Layout := RECORD
    KEL.typ.nuid UID;
    KEL.typ.nstr S_S_N_;
    KEL.typ.ndataset(__ST262996_Layout) Address_Summary_;
    KEL.typ.ndataset(__ST263005_Layout) Date_Of_Birth_Summary_;
    KEL.typ.ndataset(__ST263012_Layout) Name_Summary_;
    KEL.typ.ndataset(__ST263020_Layout) Phone_Summary_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  SHARED __ST262992_Layout __ND605095__Project(E_S_S_N_Summary(__in,__cfg).Layout __PP604593) := TRANSFORM
    __EE604616 := __PP604593.Address_Summary_;
    __ST262996_Layout __ND604942__Project(E_S_S_N_Summary(__in,__cfg).Address_Summary_Layout __PP604938) := TRANSFORM
      SELF.Translated_Source_Code_ := FN_Compile(__cfg).FN_Consumer_Source_Group(__ECAST(KEL.typ.nstr,__PP604938.Address_Source_));
      SELF := __PP604938;
    END;
    SELF.Address_Summary_ := __PROJECT(__EE604616,__ND604942__Project(LEFT));
    __EE604666 := __PP604593.Date_Of_Birth_Summary_;
    __ST263005_Layout __ND604991__Project(E_S_S_N_Summary(__in,__cfg).Date_Of_Birth_Summary_Layout __PP604987) := TRANSFORM
      SELF.Translated_Source_Code_ := FN_Compile(__cfg).FN_Consumer_Source_Group(__ECAST(KEL.typ.nstr,__PP604987.Dob_Source_));
      SELF := __PP604987;
    END;
    SELF.Date_Of_Birth_Summary_ := __PROJECT(__EE604666,__ND604991__Project(LEFT));
    __EE604706 := __PP604593.Name_Summary_;
    __ST263012_Layout __ND605032__Project(E_S_S_N_Summary(__in,__cfg).Name_Summary_Layout __PP605028) := TRANSFORM
      SELF.Translated_Source_Code_ := FN_Compile(__cfg).FN_Consumer_Source_Group(__ECAST(KEL.typ.nstr,__PP605028.Name_Source_));
      SELF := __PP605028;
    END;
    SELF.Name_Summary_ := __PROJECT(__EE604706,__ND605032__Project(LEFT));
    __EE604751 := __PP604593.Phone_Summary_;
    __ST263020_Layout __ND605077__Project(E_S_S_N_Summary(__in,__cfg).Phone_Summary_Layout __PP605073) := TRANSFORM
      SELF.Phone_Translated_Source_Code_ := FN_Compile(__cfg).FN_Consumer_Source_Group(__ECAST(KEL.typ.nstr,__PP605073.Phone_Source_));
      SELF := __PP605073;
    END;
    SELF.Phone_Summary_ := __PROJECT(__EE604751,__ND605077__Project(LEFT));
    SELF := __PP604593;
  END;
  EXPORT __ENH_S_S_N_Summary_5 := PROJECT(__EE604798,__ND605095__Project(LEFT));
END;
