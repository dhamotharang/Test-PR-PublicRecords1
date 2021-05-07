//HPCC Systems KEL Compiler Version 1.6.0
IMPORT KEL16 AS KEL;
IMPORT CFG_Compile,E_S_S_N_Summary,FN_Compile FROM PublicRecords_KEL.KEL_Queries_MAS_NonFCRA;
IMPORT * FROM KEL16.Null;
EXPORT B_S_S_N_Summary_5(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE
  SHARED VIRTUAL TYPEOF(E_S_S_N_Summary(__in,__cfg).__Result) __E_S_S_N_Summary := E_S_S_N_Summary(__in,__cfg).__Result;
  SHARED __EE289125 := __E_S_S_N_Summary;
  EXPORT __ST174836_Layout := RECORD
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
  EXPORT __ST174845_Layout := RECORD
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
  EXPORT __ST174853_Layout := RECORD
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
  EXPORT __ST174861_Layout := RECORD
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
  EXPORT __ST174832_Layout := RECORD
    KEL.typ.nuid UID;
    KEL.typ.nstr S_S_N_;
    KEL.typ.ndataset(__ST174836_Layout) Address_Summary_;
    KEL.typ.ndataset(__ST174845_Layout) Date_Of_Birth_Summary_;
    KEL.typ.ndataset(__ST174853_Layout) Name_Summary_;
    KEL.typ.ndataset(__ST174861_Layout) Phone_Summary_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  SHARED __ST174832_Layout __ND289430__Project(E_S_S_N_Summary(__in,__cfg).Layout __PP288915) := TRANSFORM
    __EE288938 := __PP288915.Address_Summary_;
    __ST174836_Layout __ND289273__Project(E_S_S_N_Summary(__in,__cfg).Address_Summary_Layout __PP289269) := TRANSFORM
      SELF.Translated_Source_Code_ := FN_Compile(__cfg).FN_Consumer_Source_Group(__ECAST(KEL.typ.nstr,__PP289269.Address_Source_));
      SELF := __PP289269;
    END;
    SELF.Address_Summary_ := __PROJECT(__EE288938,__ND289273__Project(LEFT));
    __EE288988 := __PP288915.Date_Of_Birth_Summary_;
    __ST174845_Layout __ND289322__Project(E_S_S_N_Summary(__in,__cfg).Date_Of_Birth_Summary_Layout __PP289318) := TRANSFORM
      SELF.Translated_Source_Code_ := FN_Compile(__cfg).FN_Consumer_Source_Group(__ECAST(KEL.typ.nstr,__PP289318.Dob_Source_));
      SELF := __PP289318;
    END;
    SELF.Date_Of_Birth_Summary_ := __PROJECT(__EE288988,__ND289322__Project(LEFT));
    __EE289033 := __PP288915.Name_Summary_;
    __ST174853_Layout __ND289367__Project(E_S_S_N_Summary(__in,__cfg).Name_Summary_Layout __PP289363) := TRANSFORM
      SELF.Translated_Source_Code_ := FN_Compile(__cfg).FN_Consumer_Source_Group(__ECAST(KEL.typ.nstr,__PP289363.Name_Source_));
      SELF := __PP289363;
    END;
    SELF.Name_Summary_ := __PROJECT(__EE289033,__ND289367__Project(LEFT));
    __EE289078 := __PP288915.Phone_Summary_;
    __ST174861_Layout __ND289412__Project(E_S_S_N_Summary(__in,__cfg).Phone_Summary_Layout __PP289408) := TRANSFORM
      SELF.Phone_Translated_Source_Code_ := FN_Compile(__cfg).FN_Consumer_Source_Group(__ECAST(KEL.typ.nstr,__PP289408.Phone_Source_));
      SELF := __PP289408;
    END;
    SELF.Phone_Summary_ := __PROJECT(__EE289078,__ND289412__Project(LEFT));
    SELF := __PP288915;
  END;
  EXPORT __ENH_S_S_N_Summary_5 := PROJECT(__EE289125,__ND289430__Project(LEFT));
END;
