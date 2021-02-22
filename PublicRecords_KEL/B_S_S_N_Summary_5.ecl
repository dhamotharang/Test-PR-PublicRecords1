//HPCC Systems KEL Compiler Version 1.5.0rc1
IMPORT KEL15 AS KEL;
IMPORT CFG_Compile,E_S_S_N_Summary,FN_Compile FROM PublicRecords_KEL;
IMPORT * FROM KEL15.Null;
EXPORT B_S_S_N_Summary_5(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE
  SHARED VIRTUAL TYPEOF(E_S_S_N_Summary(__in,__cfg).__Result) __E_S_S_N_Summary := E_S_S_N_Summary(__in,__cfg).__Result;
  SHARED __EE533294 := __E_S_S_N_Summary;
  EXPORT __ST250915_Layout := RECORD
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
  EXPORT __ST250924_Layout := RECORD
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
  EXPORT __ST250931_Layout := RECORD
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
  EXPORT __ST250939_Layout := RECORD
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
  EXPORT __ST250911_Layout := RECORD
    KEL.typ.nuid UID;
    KEL.typ.nstr S_S_N_;
    KEL.typ.ndataset(__ST250915_Layout) Address_Summary_;
    KEL.typ.ndataset(__ST250924_Layout) Date_Of_Birth_Summary_;
    KEL.typ.ndataset(__ST250931_Layout) Name_Summary_;
    KEL.typ.ndataset(__ST250939_Layout) Phone_Summary_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  SHARED __ST250911_Layout __ND533591__Project(E_S_S_N_Summary(__in,__cfg).Layout __PP533089) := TRANSFORM
    __EE533112 := __PP533089.Address_Summary_;
    __ST250915_Layout __ND533438__Project(E_S_S_N_Summary(__in,__cfg).Address_Summary_Layout __PP533434) := TRANSFORM
      SELF.Translated_Source_Code_ := FN_Compile(__cfg).FN_Consumer_Source_Group(__ECAST(KEL.typ.nstr,__PP533434.Address_Source_));
      SELF := __PP533434;
    END;
    SELF.Address_Summary_ := __PROJECT(__EE533112,__ND533438__Project(LEFT));
    __EE533162 := __PP533089.Date_Of_Birth_Summary_;
    __ST250924_Layout __ND533487__Project(E_S_S_N_Summary(__in,__cfg).Date_Of_Birth_Summary_Layout __PP533483) := TRANSFORM
      SELF.Translated_Source_Code_ := FN_Compile(__cfg).FN_Consumer_Source_Group(__ECAST(KEL.typ.nstr,__PP533483.Dob_Source_));
      SELF := __PP533483;
    END;
    SELF.Date_Of_Birth_Summary_ := __PROJECT(__EE533162,__ND533487__Project(LEFT));
    __EE533202 := __PP533089.Name_Summary_;
    __ST250931_Layout __ND533528__Project(E_S_S_N_Summary(__in,__cfg).Name_Summary_Layout __PP533524) := TRANSFORM
      SELF.Translated_Source_Code_ := FN_Compile(__cfg).FN_Consumer_Source_Group(__ECAST(KEL.typ.nstr,__PP533524.Name_Source_));
      SELF := __PP533524;
    END;
    SELF.Name_Summary_ := __PROJECT(__EE533202,__ND533528__Project(LEFT));
    __EE533247 := __PP533089.Phone_Summary_;
    __ST250939_Layout __ND533573__Project(E_S_S_N_Summary(__in,__cfg).Phone_Summary_Layout __PP533569) := TRANSFORM
      SELF.Phone_Translated_Source_Code_ := FN_Compile(__cfg).FN_Consumer_Source_Group(__ECAST(KEL.typ.nstr,__PP533569.Phone_Source_));
      SELF := __PP533569;
    END;
    SELF.Phone_Summary_ := __PROJECT(__EE533247,__ND533573__Project(LEFT));
    SELF := __PP533089;
  END;
  EXPORT __ENH_S_S_N_Summary_5 := PROJECT(__EE533294,__ND533591__Project(LEFT));
END;
