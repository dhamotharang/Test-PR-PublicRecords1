//HPCC Systems KEL Compiler Version 1.6.0
IMPORT KEL16 AS KEL;
IMPORT CFG_Compile,E_S_S_N_Summary,FN_Compile FROM PublicRecords_KEL.KEL_Queries_MAS_NonFCRA;
IMPORT * FROM KEL16.Null;
EXPORT B_S_S_N_Summary_5(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE
  SHARED VIRTUAL TYPEOF(E_S_S_N_Summary(__in,__cfg).__Result) __E_S_S_N_Summary := E_S_S_N_Summary(__in,__cfg).__Result;
  SHARED __EE293428 := __E_S_S_N_Summary;
  EXPORT __ST178071_Layout := RECORD
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
  EXPORT __ST178080_Layout := RECORD
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
  EXPORT __ST178088_Layout := RECORD
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
  EXPORT __ST178096_Layout := RECORD
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
  EXPORT __ST178067_Layout := RECORD
    KEL.typ.nuid UID;
    KEL.typ.nstr S_S_N_;
    KEL.typ.ndataset(__ST178071_Layout) Address_Summary_;
    KEL.typ.ndataset(__ST178080_Layout) Date_Of_Birth_Summary_;
    KEL.typ.ndataset(__ST178088_Layout) Name_Summary_;
    KEL.typ.ndataset(__ST178096_Layout) Phone_Summary_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  SHARED __ST178067_Layout __ND293733__Project(E_S_S_N_Summary(__in,__cfg).Layout __PP293218) := TRANSFORM
    __EE293241 := __PP293218.Address_Summary_;
    __ST178071_Layout __ND293576__Project(E_S_S_N_Summary(__in,__cfg).Address_Summary_Layout __PP293572) := TRANSFORM
      SELF.Translated_Source_Code_ := FN_Compile(__cfg).FN_Consumer_Source_Group(__ECAST(KEL.typ.nstr,__PP293572.Address_Source_));
      SELF := __PP293572;
    END;
    SELF.Address_Summary_ := __PROJECT(__EE293241,__ND293576__Project(LEFT));
    __EE293291 := __PP293218.Date_Of_Birth_Summary_;
    __ST178080_Layout __ND293625__Project(E_S_S_N_Summary(__in,__cfg).Date_Of_Birth_Summary_Layout __PP293621) := TRANSFORM
      SELF.Translated_Source_Code_ := FN_Compile(__cfg).FN_Consumer_Source_Group(__ECAST(KEL.typ.nstr,__PP293621.Dob_Source_));
      SELF := __PP293621;
    END;
    SELF.Date_Of_Birth_Summary_ := __PROJECT(__EE293291,__ND293625__Project(LEFT));
    __EE293336 := __PP293218.Name_Summary_;
    __ST178088_Layout __ND293670__Project(E_S_S_N_Summary(__in,__cfg).Name_Summary_Layout __PP293666) := TRANSFORM
      SELF.Translated_Source_Code_ := FN_Compile(__cfg).FN_Consumer_Source_Group(__ECAST(KEL.typ.nstr,__PP293666.Name_Source_));
      SELF := __PP293666;
    END;
    SELF.Name_Summary_ := __PROJECT(__EE293336,__ND293670__Project(LEFT));
    __EE293381 := __PP293218.Phone_Summary_;
    __ST178096_Layout __ND293715__Project(E_S_S_N_Summary(__in,__cfg).Phone_Summary_Layout __PP293711) := TRANSFORM
      SELF.Phone_Translated_Source_Code_ := FN_Compile(__cfg).FN_Consumer_Source_Group(__ECAST(KEL.typ.nstr,__PP293711.Phone_Source_));
      SELF := __PP293711;
    END;
    SELF.Phone_Summary_ := __PROJECT(__EE293381,__ND293715__Project(LEFT));
    SELF := __PP293218;
  END;
  EXPORT __ENH_S_S_N_Summary_5 := PROJECT(__EE293428,__ND293733__Project(LEFT));
END;
