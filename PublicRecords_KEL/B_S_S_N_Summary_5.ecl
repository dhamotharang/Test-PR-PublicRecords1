//HPCC Systems KEL Compiler Version 1.5.0rc1
IMPORT KEL15 AS KEL;
IMPORT CFG_Compile,E_S_S_N_Summary,FN_Compile FROM PublicRecords_KEL;
IMPORT * FROM KEL15.Null;
EXPORT B_S_S_N_Summary_5(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE
  SHARED VIRTUAL TYPEOF(E_S_S_N_Summary(__in,__cfg).__Result) __E_S_S_N_Summary := E_S_S_N_Summary(__in,__cfg).__Result;
  SHARED __EE509459 := __E_S_S_N_Summary;
  EXPORT __ST241748_Layout := RECORD
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
  EXPORT __ST241757_Layout := RECORD
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
  EXPORT __ST241764_Layout := RECORD
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
  EXPORT __ST241772_Layout := RECORD
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
  EXPORT __ST241744_Layout := RECORD
    KEL.typ.nuid UID;
    KEL.typ.nstr S_S_N_;
    KEL.typ.ndataset(__ST241748_Layout) Address_Summary_;
    KEL.typ.ndataset(__ST241757_Layout) Date_Of_Birth_Summary_;
    KEL.typ.ndataset(__ST241764_Layout) Name_Summary_;
    KEL.typ.ndataset(__ST241772_Layout) Phone_Summary_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  SHARED __ST241744_Layout __ND509756__Project(E_S_S_N_Summary(__in,__cfg).Layout __PP509254) := TRANSFORM
    __EE509277 := __PP509254.Address_Summary_;
    __ST241748_Layout __ND509603__Project(E_S_S_N_Summary(__in,__cfg).Address_Summary_Layout __PP509599) := TRANSFORM
      SELF.Translated_Source_Code_ := FN_Compile(__cfg).FN_Consumer_Source_Group(__ECAST(KEL.typ.nstr,__PP509599.Address_Source_));
      SELF := __PP509599;
    END;
    SELF.Address_Summary_ := __PROJECT(__EE509277,__ND509603__Project(LEFT));
    __EE509327 := __PP509254.Date_Of_Birth_Summary_;
    __ST241757_Layout __ND509652__Project(E_S_S_N_Summary(__in,__cfg).Date_Of_Birth_Summary_Layout __PP509648) := TRANSFORM
      SELF.Translated_Source_Code_ := FN_Compile(__cfg).FN_Consumer_Source_Group(__ECAST(KEL.typ.nstr,__PP509648.Dob_Source_));
      SELF := __PP509648;
    END;
    SELF.Date_Of_Birth_Summary_ := __PROJECT(__EE509327,__ND509652__Project(LEFT));
    __EE509367 := __PP509254.Name_Summary_;
    __ST241764_Layout __ND509693__Project(E_S_S_N_Summary(__in,__cfg).Name_Summary_Layout __PP509689) := TRANSFORM
      SELF.Translated_Source_Code_ := FN_Compile(__cfg).FN_Consumer_Source_Group(__ECAST(KEL.typ.nstr,__PP509689.Name_Source_));
      SELF := __PP509689;
    END;
    SELF.Name_Summary_ := __PROJECT(__EE509367,__ND509693__Project(LEFT));
    __EE509412 := __PP509254.Phone_Summary_;
    __ST241772_Layout __ND509738__Project(E_S_S_N_Summary(__in,__cfg).Phone_Summary_Layout __PP509734) := TRANSFORM
      SELF.Phone_Translated_Source_Code_ := FN_Compile(__cfg).FN_Consumer_Source_Group(__ECAST(KEL.typ.nstr,__PP509734.Phone_Source_));
      SELF := __PP509734;
    END;
    SELF.Phone_Summary_ := __PROJECT(__EE509412,__ND509738__Project(LEFT));
    SELF := __PP509254;
  END;
  EXPORT __ENH_S_S_N_Summary_5 := PROJECT(__EE509459,__ND509756__Project(LEFT));
END;
