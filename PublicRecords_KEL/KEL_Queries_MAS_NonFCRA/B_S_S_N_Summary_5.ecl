//HPCC Systems KEL Compiler Version 1.6.0
IMPORT KEL16 AS KEL;
IMPORT CFG_Compile,E_S_S_N_Summary,FN_Compile FROM PublicRecords_KEL.KEL_Queries_MAS_NonFCRA;
IMPORT * FROM KEL16.Null;
EXPORT B_S_S_N_Summary_5(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE
  SHARED VIRTUAL TYPEOF(E_S_S_N_Summary(__in,__cfg).__Result) __E_S_S_N_Summary := E_S_S_N_Summary(__in,__cfg).__Result;
  SHARED __EE295547 := __E_S_S_N_Summary;
  EXPORT __ST180190_Layout := RECORD
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
  EXPORT __ST180199_Layout := RECORD
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
  EXPORT __ST180207_Layout := RECORD
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
  EXPORT __ST180215_Layout := RECORD
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
  EXPORT __ST180186_Layout := RECORD
    KEL.typ.nuid UID;
    KEL.typ.nstr S_S_N_;
    KEL.typ.ndataset(__ST180190_Layout) Address_Summary_;
    KEL.typ.ndataset(__ST180199_Layout) Date_Of_Birth_Summary_;
    KEL.typ.ndataset(__ST180207_Layout) Name_Summary_;
    KEL.typ.ndataset(__ST180215_Layout) Phone_Summary_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  SHARED __ST180186_Layout __ND295852__Project(E_S_S_N_Summary(__in,__cfg).Layout __PP295337) := TRANSFORM
    __EE295360 := __PP295337.Address_Summary_;
    __ST180190_Layout __ND295695__Project(E_S_S_N_Summary(__in,__cfg).Address_Summary_Layout __PP295691) := TRANSFORM
      SELF.Translated_Source_Code_ := FN_Compile(__cfg).FN_Consumer_Source_Group(__ECAST(KEL.typ.nstr,__PP295691.Address_Source_));
      SELF := __PP295691;
    END;
    SELF.Address_Summary_ := __PROJECT(__EE295360,__ND295695__Project(LEFT));
    __EE295410 := __PP295337.Date_Of_Birth_Summary_;
    __ST180199_Layout __ND295744__Project(E_S_S_N_Summary(__in,__cfg).Date_Of_Birth_Summary_Layout __PP295740) := TRANSFORM
      SELF.Translated_Source_Code_ := FN_Compile(__cfg).FN_Consumer_Source_Group(__ECAST(KEL.typ.nstr,__PP295740.Dob_Source_));
      SELF := __PP295740;
    END;
    SELF.Date_Of_Birth_Summary_ := __PROJECT(__EE295410,__ND295744__Project(LEFT));
    __EE295455 := __PP295337.Name_Summary_;
    __ST180207_Layout __ND295789__Project(E_S_S_N_Summary(__in,__cfg).Name_Summary_Layout __PP295785) := TRANSFORM
      SELF.Translated_Source_Code_ := FN_Compile(__cfg).FN_Consumer_Source_Group(__ECAST(KEL.typ.nstr,__PP295785.Name_Source_));
      SELF := __PP295785;
    END;
    SELF.Name_Summary_ := __PROJECT(__EE295455,__ND295789__Project(LEFT));
    __EE295500 := __PP295337.Phone_Summary_;
    __ST180215_Layout __ND295834__Project(E_S_S_N_Summary(__in,__cfg).Phone_Summary_Layout __PP295830) := TRANSFORM
      SELF.Phone_Translated_Source_Code_ := FN_Compile(__cfg).FN_Consumer_Source_Group(__ECAST(KEL.typ.nstr,__PP295830.Phone_Source_));
      SELF := __PP295830;
    END;
    SELF.Phone_Summary_ := __PROJECT(__EE295500,__ND295834__Project(LEFT));
    SELF := __PP295337;
  END;
  EXPORT __ENH_S_S_N_Summary_5 := PROJECT(__EE295547,__ND295852__Project(LEFT));
END;
