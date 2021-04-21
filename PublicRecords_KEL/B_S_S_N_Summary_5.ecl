//HPCC Systems KEL Compiler Version 1.5.0rc1
IMPORT KEL15 AS KEL;
IMPORT CFG_Compile,E_S_S_N_Summary,FN_Compile FROM PublicRecords_KEL;
IMPORT * FROM KEL15.Null;
EXPORT B_S_S_N_Summary_5(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE
  SHARED VIRTUAL TYPEOF(E_S_S_N_Summary(__in,__cfg).__Result) __E_S_S_N_Summary := E_S_S_N_Summary(__in,__cfg).__Result;
  SHARED __EE645499 := __E_S_S_N_Summary;
  EXPORT __ST280128_Layout := RECORD
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
  EXPORT __ST280137_Layout := RECORD
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
  EXPORT __ST280145_Layout := RECORD
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
  EXPORT __ST280153_Layout := RECORD
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
  EXPORT __ST280124_Layout := RECORD
    KEL.typ.nuid UID;
    KEL.typ.nstr S_S_N_;
    KEL.typ.ndataset(__ST280128_Layout) Address_Summary_;
    KEL.typ.ndataset(__ST280137_Layout) Date_Of_Birth_Summary_;
    KEL.typ.ndataset(__ST280145_Layout) Name_Summary_;
    KEL.typ.ndataset(__ST280153_Layout) Phone_Summary_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  SHARED __ST280124_Layout __ND645804__Project(E_S_S_N_Summary(__in,__cfg).Layout __PP645289) := TRANSFORM
    __EE645312 := __PP645289.Address_Summary_;
    __ST280128_Layout __ND645647__Project(E_S_S_N_Summary(__in,__cfg).Address_Summary_Layout __PP645643) := TRANSFORM
      SELF.Translated_Source_Code_ := FN_Compile(__cfg).FN_Consumer_Source_Group(__ECAST(KEL.typ.nstr,__PP645643.Address_Source_));
      SELF := __PP645643;
    END;
    SELF.Address_Summary_ := __PROJECT(__EE645312,__ND645647__Project(LEFT));
    __EE645362 := __PP645289.Date_Of_Birth_Summary_;
    __ST280137_Layout __ND645696__Project(E_S_S_N_Summary(__in,__cfg).Date_Of_Birth_Summary_Layout __PP645692) := TRANSFORM
      SELF.Translated_Source_Code_ := FN_Compile(__cfg).FN_Consumer_Source_Group(__ECAST(KEL.typ.nstr,__PP645692.Dob_Source_));
      SELF := __PP645692;
    END;
    SELF.Date_Of_Birth_Summary_ := __PROJECT(__EE645362,__ND645696__Project(LEFT));
    __EE645407 := __PP645289.Name_Summary_;
    __ST280145_Layout __ND645741__Project(E_S_S_N_Summary(__in,__cfg).Name_Summary_Layout __PP645737) := TRANSFORM
      SELF.Translated_Source_Code_ := FN_Compile(__cfg).FN_Consumer_Source_Group(__ECAST(KEL.typ.nstr,__PP645737.Name_Source_));
      SELF := __PP645737;
    END;
    SELF.Name_Summary_ := __PROJECT(__EE645407,__ND645741__Project(LEFT));
    __EE645452 := __PP645289.Phone_Summary_;
    __ST280153_Layout __ND645786__Project(E_S_S_N_Summary(__in,__cfg).Phone_Summary_Layout __PP645782) := TRANSFORM
      SELF.Phone_Translated_Source_Code_ := FN_Compile(__cfg).FN_Consumer_Source_Group(__ECAST(KEL.typ.nstr,__PP645782.Phone_Source_));
      SELF := __PP645782;
    END;
    SELF.Phone_Summary_ := __PROJECT(__EE645452,__ND645786__Project(LEFT));
    SELF := __PP645289;
  END;
  EXPORT __ENH_S_S_N_Summary_5 := PROJECT(__EE645499,__ND645804__Project(LEFT));
END;
