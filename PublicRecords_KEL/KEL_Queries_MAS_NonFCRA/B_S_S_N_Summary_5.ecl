//HPCC Systems KEL Compiler Version 1.6.0
IMPORT KEL16 AS KEL;
IMPORT CFG_Compile,E_S_S_N_Summary,FN_Compile FROM PublicRecords_KEL.KEL_Queries_MAS_NonFCRA;
IMPORT * FROM KEL16.Null;
EXPORT B_S_S_N_Summary_5(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE
  SHARED VIRTUAL TYPEOF(E_S_S_N_Summary(__in,__cfg).__Result) __E_S_S_N_Summary := E_S_S_N_Summary(__in,__cfg).__Result;
  SHARED __EE293192 := __E_S_S_N_Summary;
  EXPORT __ST178645_Layout := RECORD
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
  EXPORT __ST178654_Layout := RECORD
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
  EXPORT __ST178662_Layout := RECORD
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
  EXPORT __ST178670_Layout := RECORD
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
  EXPORT __ST178641_Layout := RECORD
    KEL.typ.nuid UID;
    KEL.typ.nstr S_S_N_;
    KEL.typ.ndataset(__ST178645_Layout) Address_Summary_;
    KEL.typ.ndataset(__ST178654_Layout) Date_Of_Birth_Summary_;
    KEL.typ.ndataset(__ST178662_Layout) Name_Summary_;
    KEL.typ.ndataset(__ST178670_Layout) Phone_Summary_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  SHARED __ST178641_Layout __ND293497__Project(E_S_S_N_Summary(__in,__cfg).Layout __PP292982) := TRANSFORM
    __EE293005 := __PP292982.Address_Summary_;
    __ST178645_Layout __ND293340__Project(E_S_S_N_Summary(__in,__cfg).Address_Summary_Layout __PP293336) := TRANSFORM
      SELF.Translated_Source_Code_ := FN_Compile(__cfg).FN_Consumer_Source_Group(__ECAST(KEL.typ.nstr,__PP293336.Address_Source_));
      SELF := __PP293336;
    END;
    SELF.Address_Summary_ := __PROJECT(__EE293005,__ND293340__Project(LEFT));
    __EE293055 := __PP292982.Date_Of_Birth_Summary_;
    __ST178654_Layout __ND293389__Project(E_S_S_N_Summary(__in,__cfg).Date_Of_Birth_Summary_Layout __PP293385) := TRANSFORM
      SELF.Translated_Source_Code_ := FN_Compile(__cfg).FN_Consumer_Source_Group(__ECAST(KEL.typ.nstr,__PP293385.Dob_Source_));
      SELF := __PP293385;
    END;
    SELF.Date_Of_Birth_Summary_ := __PROJECT(__EE293055,__ND293389__Project(LEFT));
    __EE293100 := __PP292982.Name_Summary_;
    __ST178662_Layout __ND293434__Project(E_S_S_N_Summary(__in,__cfg).Name_Summary_Layout __PP293430) := TRANSFORM
      SELF.Translated_Source_Code_ := FN_Compile(__cfg).FN_Consumer_Source_Group(__ECAST(KEL.typ.nstr,__PP293430.Name_Source_));
      SELF := __PP293430;
    END;
    SELF.Name_Summary_ := __PROJECT(__EE293100,__ND293434__Project(LEFT));
    __EE293145 := __PP292982.Phone_Summary_;
    __ST178670_Layout __ND293479__Project(E_S_S_N_Summary(__in,__cfg).Phone_Summary_Layout __PP293475) := TRANSFORM
      SELF.Phone_Translated_Source_Code_ := FN_Compile(__cfg).FN_Consumer_Source_Group(__ECAST(KEL.typ.nstr,__PP293475.Phone_Source_));
      SELF := __PP293475;
    END;
    SELF.Phone_Summary_ := __PROJECT(__EE293145,__ND293479__Project(LEFT));
    SELF := __PP292982;
  END;
  EXPORT __ENH_S_S_N_Summary_5 := PROJECT(__EE293192,__ND293497__Project(LEFT));
END;
