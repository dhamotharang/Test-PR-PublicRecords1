//HPCC Systems KEL Compiler Version 1.5.0rc1
IMPORT KEL15 AS KEL;
IMPORT CFG_Compile,E_S_S_N_Summary,FN_Compile FROM PublicRecords_KEL;
IMPORT * FROM KEL15.Null;
EXPORT B_S_S_N_Summary_5(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE
  SHARED VIRTUAL TYPEOF(E_S_S_N_Summary(__in,__cfg).__Result) __E_S_S_N_Summary := E_S_S_N_Summary(__in,__cfg).__Result;
  SHARED __EE537997 := __E_S_S_N_Summary;
  EXPORT __ST251303_Layout := RECORD
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
  EXPORT __ST251312_Layout := RECORD
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
  EXPORT __ST251319_Layout := RECORD
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
  EXPORT __ST251327_Layout := RECORD
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
  EXPORT __ST251299_Layout := RECORD
    KEL.typ.nuid UID;
    KEL.typ.nstr S_S_N_;
    KEL.typ.ndataset(__ST251303_Layout) Address_Summary_;
    KEL.typ.ndataset(__ST251312_Layout) Date_Of_Birth_Summary_;
    KEL.typ.ndataset(__ST251319_Layout) Name_Summary_;
    KEL.typ.ndataset(__ST251327_Layout) Phone_Summary_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  SHARED __ST251299_Layout __ND538294__Project(E_S_S_N_Summary(__in,__cfg).Layout __PP537792) := TRANSFORM
    __EE537815 := __PP537792.Address_Summary_;
    __ST251303_Layout __ND538141__Project(E_S_S_N_Summary(__in,__cfg).Address_Summary_Layout __PP538137) := TRANSFORM
      SELF.Translated_Source_Code_ := FN_Compile(__cfg).FN_Consumer_Source_Group(__ECAST(KEL.typ.nstr,__PP538137.Address_Source_));
      SELF := __PP538137;
    END;
    SELF.Address_Summary_ := __PROJECT(__EE537815,__ND538141__Project(LEFT));
    __EE537865 := __PP537792.Date_Of_Birth_Summary_;
    __ST251312_Layout __ND538190__Project(E_S_S_N_Summary(__in,__cfg).Date_Of_Birth_Summary_Layout __PP538186) := TRANSFORM
      SELF.Translated_Source_Code_ := FN_Compile(__cfg).FN_Consumer_Source_Group(__ECAST(KEL.typ.nstr,__PP538186.Dob_Source_));
      SELF := __PP538186;
    END;
    SELF.Date_Of_Birth_Summary_ := __PROJECT(__EE537865,__ND538190__Project(LEFT));
    __EE537905 := __PP537792.Name_Summary_;
    __ST251319_Layout __ND538231__Project(E_S_S_N_Summary(__in,__cfg).Name_Summary_Layout __PP538227) := TRANSFORM
      SELF.Translated_Source_Code_ := FN_Compile(__cfg).FN_Consumer_Source_Group(__ECAST(KEL.typ.nstr,__PP538227.Name_Source_));
      SELF := __PP538227;
    END;
    SELF.Name_Summary_ := __PROJECT(__EE537905,__ND538231__Project(LEFT));
    __EE537950 := __PP537792.Phone_Summary_;
    __ST251327_Layout __ND538276__Project(E_S_S_N_Summary(__in,__cfg).Phone_Summary_Layout __PP538272) := TRANSFORM
      SELF.Phone_Translated_Source_Code_ := FN_Compile(__cfg).FN_Consumer_Source_Group(__ECAST(KEL.typ.nstr,__PP538272.Phone_Source_));
      SELF := __PP538272;
    END;
    SELF.Phone_Summary_ := __PROJECT(__EE537950,__ND538276__Project(LEFT));
    SELF := __PP537792;
  END;
  EXPORT __ENH_S_S_N_Summary_5 := PROJECT(__EE537997,__ND538294__Project(LEFT));
END;
