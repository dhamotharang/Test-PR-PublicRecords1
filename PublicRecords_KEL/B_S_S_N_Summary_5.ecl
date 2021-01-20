//HPCC Systems KEL Compiler Version 1.5.0
IMPORT KEL15 AS KEL;
IMPORT CFG_Compile,E_S_S_N_Summary,FN_Compile FROM PublicRecords_KEL;
IMPORT * FROM KEL15.Null;
EXPORT B_S_S_N_Summary_5(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE
  SHARED VIRTUAL TYPEOF(E_S_S_N_Summary(__in,__cfg).__Result) __E_S_S_N_Summary := E_S_S_N_Summary(__in,__cfg).__Result;
  SHARED __EE509855 := __E_S_S_N_Summary;
  EXPORT __ST242231_Layout := RECORD
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
  EXPORT __ST242240_Layout := RECORD
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
  EXPORT __ST242247_Layout := RECORD
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
  EXPORT __ST242255_Layout := RECORD
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
  EXPORT __ST242227_Layout := RECORD
    KEL.typ.nuid UID;
    KEL.typ.nstr S_S_N_;
    KEL.typ.ndataset(__ST242231_Layout) Address_Summary_;
    KEL.typ.ndataset(__ST242240_Layout) Date_Of_Birth_Summary_;
    KEL.typ.ndataset(__ST242247_Layout) Name_Summary_;
    KEL.typ.ndataset(__ST242255_Layout) Phone_Summary_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  SHARED __ST242227_Layout __ND510152__Project(E_S_S_N_Summary(__in,__cfg).Layout __PP509650) := TRANSFORM
    __EE509673 := __PP509650.Address_Summary_;
    __ST242231_Layout __ND509999__Project(E_S_S_N_Summary(__in,__cfg).Address_Summary_Layout __PP509995) := TRANSFORM
      SELF.Translated_Source_Code_ := FN_Compile(__cfg).FN_Consumer_Source_Group(__ECAST(KEL.typ.nstr,__PP509995.Address_Source_));
      SELF := __PP509995;
    END;
    SELF.Address_Summary_ := __PROJECT(__EE509673,__ND509999__Project(LEFT));
    __EE509723 := __PP509650.Date_Of_Birth_Summary_;
    __ST242240_Layout __ND510048__Project(E_S_S_N_Summary(__in,__cfg).Date_Of_Birth_Summary_Layout __PP510044) := TRANSFORM
      SELF.Translated_Source_Code_ := FN_Compile(__cfg).FN_Consumer_Source_Group(__ECAST(KEL.typ.nstr,__PP510044.Dob_Source_));
      SELF := __PP510044;
    END;
    SELF.Date_Of_Birth_Summary_ := __PROJECT(__EE509723,__ND510048__Project(LEFT));
    __EE509763 := __PP509650.Name_Summary_;
    __ST242247_Layout __ND510089__Project(E_S_S_N_Summary(__in,__cfg).Name_Summary_Layout __PP510085) := TRANSFORM
      SELF.Translated_Source_Code_ := FN_Compile(__cfg).FN_Consumer_Source_Group(__ECAST(KEL.typ.nstr,__PP510085.Name_Source_));
      SELF := __PP510085;
    END;
    SELF.Name_Summary_ := __PROJECT(__EE509763,__ND510089__Project(LEFT));
    __EE509808 := __PP509650.Phone_Summary_;
    __ST242255_Layout __ND510134__Project(E_S_S_N_Summary(__in,__cfg).Phone_Summary_Layout __PP510130) := TRANSFORM
      SELF.Phone_Translated_Source_Code_ := FN_Compile(__cfg).FN_Consumer_Source_Group(__ECAST(KEL.typ.nstr,__PP510130.Phone_Source_));
      SELF := __PP510130;
    END;
    SELF.Phone_Summary_ := __PROJECT(__EE509808,__ND510134__Project(LEFT));
    SELF := __PP509650;
  END;
  EXPORT __ENH_S_S_N_Summary_5 := PROJECT(__EE509855,__ND510152__Project(LEFT));
END;
