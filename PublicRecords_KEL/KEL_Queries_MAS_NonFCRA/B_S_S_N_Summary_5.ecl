//HPCC Systems KEL Compiler Version 1.6.0
IMPORT KEL16 AS KEL;
IMPORT CFG_Compile,E_S_S_N_Summary,FN_Compile FROM PublicRecords_KEL.KEL_Queries_MAS_NonFCRA;
IMPORT * FROM KEL16.Null;
EXPORT B_S_S_N_Summary_5(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE
  SHARED VIRTUAL TYPEOF(E_S_S_N_Summary(__in,__cfg).__Result) __E_S_S_N_Summary := E_S_S_N_Summary(__in,__cfg).__Result;
  SHARED __EE299170 := __E_S_S_N_Summary;
  EXPORT __ST183795_Layout := RECORD
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
  EXPORT __ST183804_Layout := RECORD
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
  EXPORT __ST183812_Layout := RECORD
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
  EXPORT __ST183820_Layout := RECORD
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
  EXPORT __ST183791_Layout := RECORD
    KEL.typ.nuid UID;
    KEL.typ.nstr S_S_N_;
    KEL.typ.ndataset(__ST183795_Layout) Address_Summary_;
    KEL.typ.ndataset(__ST183804_Layout) Date_Of_Birth_Summary_;
    KEL.typ.ndataset(__ST183812_Layout) Name_Summary_;
    KEL.typ.ndataset(__ST183820_Layout) Phone_Summary_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  SHARED __ST183791_Layout __ND299475__Project(E_S_S_N_Summary(__in,__cfg).Layout __PP298960) := TRANSFORM
    __EE298983 := __PP298960.Address_Summary_;
    __ST183795_Layout __ND299318__Project(E_S_S_N_Summary(__in,__cfg).Address_Summary_Layout __PP299314) := TRANSFORM
      SELF.Translated_Source_Code_ := FN_Compile(__cfg).FN_Consumer_Source_Group(__ECAST(KEL.typ.nstr,__PP299314.Address_Source_));
      SELF := __PP299314;
    END;
    SELF.Address_Summary_ := __PROJECT(__EE298983,__ND299318__Project(LEFT));
    __EE299033 := __PP298960.Date_Of_Birth_Summary_;
    __ST183804_Layout __ND299367__Project(E_S_S_N_Summary(__in,__cfg).Date_Of_Birth_Summary_Layout __PP299363) := TRANSFORM
      SELF.Translated_Source_Code_ := FN_Compile(__cfg).FN_Consumer_Source_Group(__ECAST(KEL.typ.nstr,__PP299363.Dob_Source_));
      SELF := __PP299363;
    END;
    SELF.Date_Of_Birth_Summary_ := __PROJECT(__EE299033,__ND299367__Project(LEFT));
    __EE299078 := __PP298960.Name_Summary_;
    __ST183812_Layout __ND299412__Project(E_S_S_N_Summary(__in,__cfg).Name_Summary_Layout __PP299408) := TRANSFORM
      SELF.Translated_Source_Code_ := FN_Compile(__cfg).FN_Consumer_Source_Group(__ECAST(KEL.typ.nstr,__PP299408.Name_Source_));
      SELF := __PP299408;
    END;
    SELF.Name_Summary_ := __PROJECT(__EE299078,__ND299412__Project(LEFT));
    __EE299123 := __PP298960.Phone_Summary_;
    __ST183820_Layout __ND299457__Project(E_S_S_N_Summary(__in,__cfg).Phone_Summary_Layout __PP299453) := TRANSFORM
      SELF.Phone_Translated_Source_Code_ := FN_Compile(__cfg).FN_Consumer_Source_Group(__ECAST(KEL.typ.nstr,__PP299453.Phone_Source_));
      SELF := __PP299453;
    END;
    SELF.Phone_Summary_ := __PROJECT(__EE299123,__ND299457__Project(LEFT));
    SELF := __PP298960;
  END;
  EXPORT __ENH_S_S_N_Summary_5 := PROJECT(__EE299170,__ND299475__Project(LEFT));
END;
