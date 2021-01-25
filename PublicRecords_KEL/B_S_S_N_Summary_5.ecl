﻿//HPCC Systems KEL Compiler Version 1.5.0rc1
IMPORT KEL15 AS KEL;
IMPORT CFG_Compile,E_S_S_N_Summary,FN_Compile FROM PublicRecords_KEL;
IMPORT * FROM KEL15.Null;
EXPORT B_S_S_N_Summary_5(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE
  SHARED VIRTUAL TYPEOF(E_S_S_N_Summary(__in,__cfg).__Result) __E_S_S_N_Summary := E_S_S_N_Summary(__in,__cfg).__Result;
  SHARED __EE509830 := __E_S_S_N_Summary;
  EXPORT __ST242211_Layout := RECORD
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
  EXPORT __ST242220_Layout := RECORD
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
  EXPORT __ST242227_Layout := RECORD
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
  EXPORT __ST242235_Layout := RECORD
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
  EXPORT __ST242207_Layout := RECORD
    KEL.typ.nuid UID;
    KEL.typ.nstr S_S_N_;
    KEL.typ.ndataset(__ST242211_Layout) Address_Summary_;
    KEL.typ.ndataset(__ST242220_Layout) Date_Of_Birth_Summary_;
    KEL.typ.ndataset(__ST242227_Layout) Name_Summary_;
    KEL.typ.ndataset(__ST242235_Layout) Phone_Summary_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  SHARED __ST242207_Layout __ND510127__Project(E_S_S_N_Summary(__in,__cfg).Layout __PP509625) := TRANSFORM
    __EE509648 := __PP509625.Address_Summary_;
    __ST242211_Layout __ND509974__Project(E_S_S_N_Summary(__in,__cfg).Address_Summary_Layout __PP509970) := TRANSFORM
      SELF.Translated_Source_Code_ := FN_Compile(__cfg).FN_Consumer_Source_Group(__ECAST(KEL.typ.nstr,__PP509970.Address_Source_));
      SELF := __PP509970;
    END;
    SELF.Address_Summary_ := __PROJECT(__EE509648,__ND509974__Project(LEFT));
    __EE509698 := __PP509625.Date_Of_Birth_Summary_;
    __ST242220_Layout __ND510023__Project(E_S_S_N_Summary(__in,__cfg).Date_Of_Birth_Summary_Layout __PP510019) := TRANSFORM
      SELF.Translated_Source_Code_ := FN_Compile(__cfg).FN_Consumer_Source_Group(__ECAST(KEL.typ.nstr,__PP510019.Dob_Source_));
      SELF := __PP510019;
    END;
    SELF.Date_Of_Birth_Summary_ := __PROJECT(__EE509698,__ND510023__Project(LEFT));
    __EE509738 := __PP509625.Name_Summary_;
    __ST242227_Layout __ND510064__Project(E_S_S_N_Summary(__in,__cfg).Name_Summary_Layout __PP510060) := TRANSFORM
      SELF.Translated_Source_Code_ := FN_Compile(__cfg).FN_Consumer_Source_Group(__ECAST(KEL.typ.nstr,__PP510060.Name_Source_));
      SELF := __PP510060;
    END;
    SELF.Name_Summary_ := __PROJECT(__EE509738,__ND510064__Project(LEFT));
    __EE509783 := __PP509625.Phone_Summary_;
    __ST242235_Layout __ND510109__Project(E_S_S_N_Summary(__in,__cfg).Phone_Summary_Layout __PP510105) := TRANSFORM
      SELF.Phone_Translated_Source_Code_ := FN_Compile(__cfg).FN_Consumer_Source_Group(__ECAST(KEL.typ.nstr,__PP510105.Phone_Source_));
      SELF := __PP510105;
    END;
    SELF.Phone_Summary_ := __PROJECT(__EE509783,__ND510109__Project(LEFT));
    SELF := __PP509625;
  END;
  EXPORT __ENH_S_S_N_Summary_5 := PROJECT(__EE509830,__ND510127__Project(LEFT));
END;
