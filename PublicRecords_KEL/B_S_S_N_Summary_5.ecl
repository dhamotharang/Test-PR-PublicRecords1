﻿//HPCC Systems KEL Compiler Version 1.5.0rc1
IMPORT KEL15 AS KEL;
IMPORT CFG_Compile,E_S_S_N_Summary,FN_Compile FROM PublicRecords_KEL;
IMPORT * FROM KEL15.Null;
EXPORT B_S_S_N_Summary_5(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE
  SHARED VIRTUAL TYPEOF(E_S_S_N_Summary(__in,__cfg).__Result) __E_S_S_N_Summary := E_S_S_N_Summary(__in,__cfg).__Result;
  SHARED __EE517258 := __E_S_S_N_Summary;
  EXPORT __ST246052_Layout := RECORD
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
  EXPORT __ST246061_Layout := RECORD
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
  EXPORT __ST246068_Layout := RECORD
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
  EXPORT __ST246076_Layout := RECORD
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
  EXPORT __ST246048_Layout := RECORD
    KEL.typ.nuid UID;
    KEL.typ.nstr S_S_N_;
    KEL.typ.ndataset(__ST246052_Layout) Address_Summary_;
    KEL.typ.ndataset(__ST246061_Layout) Date_Of_Birth_Summary_;
    KEL.typ.ndataset(__ST246068_Layout) Name_Summary_;
    KEL.typ.ndataset(__ST246076_Layout) Phone_Summary_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  SHARED __ST246048_Layout __ND517555__Project(E_S_S_N_Summary(__in,__cfg).Layout __PP517053) := TRANSFORM
    __EE517076 := __PP517053.Address_Summary_;
    __ST246052_Layout __ND517402__Project(E_S_S_N_Summary(__in,__cfg).Address_Summary_Layout __PP517398) := TRANSFORM
      SELF.Translated_Source_Code_ := FN_Compile(__cfg).FN_Consumer_Source_Group(__ECAST(KEL.typ.nstr,__PP517398.Address_Source_));
      SELF := __PP517398;
    END;
    SELF.Address_Summary_ := __PROJECT(__EE517076,__ND517402__Project(LEFT));
    __EE517126 := __PP517053.Date_Of_Birth_Summary_;
    __ST246061_Layout __ND517451__Project(E_S_S_N_Summary(__in,__cfg).Date_Of_Birth_Summary_Layout __PP517447) := TRANSFORM
      SELF.Translated_Source_Code_ := FN_Compile(__cfg).FN_Consumer_Source_Group(__ECAST(KEL.typ.nstr,__PP517447.Dob_Source_));
      SELF := __PP517447;
    END;
    SELF.Date_Of_Birth_Summary_ := __PROJECT(__EE517126,__ND517451__Project(LEFT));
    __EE517166 := __PP517053.Name_Summary_;
    __ST246068_Layout __ND517492__Project(E_S_S_N_Summary(__in,__cfg).Name_Summary_Layout __PP517488) := TRANSFORM
      SELF.Translated_Source_Code_ := FN_Compile(__cfg).FN_Consumer_Source_Group(__ECAST(KEL.typ.nstr,__PP517488.Name_Source_));
      SELF := __PP517488;
    END;
    SELF.Name_Summary_ := __PROJECT(__EE517166,__ND517492__Project(LEFT));
    __EE517211 := __PP517053.Phone_Summary_;
    __ST246076_Layout __ND517537__Project(E_S_S_N_Summary(__in,__cfg).Phone_Summary_Layout __PP517533) := TRANSFORM
      SELF.Phone_Translated_Source_Code_ := FN_Compile(__cfg).FN_Consumer_Source_Group(__ECAST(KEL.typ.nstr,__PP517533.Phone_Source_));
      SELF := __PP517533;
    END;
    SELF.Phone_Summary_ := __PROJECT(__EE517211,__ND517537__Project(LEFT));
    SELF := __PP517053;
  END;
  EXPORT __ENH_S_S_N_Summary_5 := PROJECT(__EE517258,__ND517555__Project(LEFT));
END;
