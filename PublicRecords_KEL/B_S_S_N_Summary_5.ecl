﻿//HPCC Systems KEL Compiler Version 1.5.0rc1
IMPORT KEL15 AS KEL;
IMPORT CFG_Compile,E_S_S_N_Summary,FN_Compile FROM PublicRecords_KEL;
IMPORT * FROM KEL15.Null;
EXPORT B_S_S_N_Summary_5(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE
  SHARED VIRTUAL TYPEOF(E_S_S_N_Summary(__in,__cfg).__Result) __E_S_S_N_Summary := E_S_S_N_Summary(__in,__cfg).__Result;
  SHARED __EE510179 := __E_S_S_N_Summary;
  EXPORT __ST242762_Layout := RECORD
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
  EXPORT __ST242771_Layout := RECORD
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
  EXPORT __ST242778_Layout := RECORD
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
  EXPORT __ST242786_Layout := RECORD
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
  EXPORT __ST242758_Layout := RECORD
    KEL.typ.nuid UID;
    KEL.typ.nstr S_S_N_;
    KEL.typ.ndataset(__ST242762_Layout) Address_Summary_;
    KEL.typ.ndataset(__ST242771_Layout) Date_Of_Birth_Summary_;
    KEL.typ.ndataset(__ST242778_Layout) Name_Summary_;
    KEL.typ.ndataset(__ST242786_Layout) Phone_Summary_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  SHARED __ST242758_Layout __ND510476__Project(E_S_S_N_Summary(__in,__cfg).Layout __PP509974) := TRANSFORM
    __EE509997 := __PP509974.Address_Summary_;
    __ST242762_Layout __ND510323__Project(E_S_S_N_Summary(__in,__cfg).Address_Summary_Layout __PP510319) := TRANSFORM
      SELF.Translated_Source_Code_ := FN_Compile(__cfg).FN_Consumer_Source_Group(__ECAST(KEL.typ.nstr,__PP510319.Address_Source_));
      SELF := __PP510319;
    END;
    SELF.Address_Summary_ := __PROJECT(__EE509997,__ND510323__Project(LEFT));
    __EE510047 := __PP509974.Date_Of_Birth_Summary_;
    __ST242771_Layout __ND510372__Project(E_S_S_N_Summary(__in,__cfg).Date_Of_Birth_Summary_Layout __PP510368) := TRANSFORM
      SELF.Translated_Source_Code_ := FN_Compile(__cfg).FN_Consumer_Source_Group(__ECAST(KEL.typ.nstr,__PP510368.Dob_Source_));
      SELF := __PP510368;
    END;
    SELF.Date_Of_Birth_Summary_ := __PROJECT(__EE510047,__ND510372__Project(LEFT));
    __EE510087 := __PP509974.Name_Summary_;
    __ST242778_Layout __ND510413__Project(E_S_S_N_Summary(__in,__cfg).Name_Summary_Layout __PP510409) := TRANSFORM
      SELF.Translated_Source_Code_ := FN_Compile(__cfg).FN_Consumer_Source_Group(__ECAST(KEL.typ.nstr,__PP510409.Name_Source_));
      SELF := __PP510409;
    END;
    SELF.Name_Summary_ := __PROJECT(__EE510087,__ND510413__Project(LEFT));
    __EE510132 := __PP509974.Phone_Summary_;
    __ST242786_Layout __ND510458__Project(E_S_S_N_Summary(__in,__cfg).Phone_Summary_Layout __PP510454) := TRANSFORM
      SELF.Phone_Translated_Source_Code_ := FN_Compile(__cfg).FN_Consumer_Source_Group(__ECAST(KEL.typ.nstr,__PP510454.Phone_Source_));
      SELF := __PP510454;
    END;
    SELF.Phone_Summary_ := __PROJECT(__EE510132,__ND510458__Project(LEFT));
    SELF := __PP509974;
  END;
  EXPORT __ENH_S_S_N_Summary_5 := PROJECT(__EE510179,__ND510476__Project(LEFT));
END;
