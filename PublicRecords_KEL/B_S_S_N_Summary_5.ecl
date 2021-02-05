//HPCC Systems KEL Compiler Version 1.5.0rc1
IMPORT KEL15 AS KEL;
IMPORT CFG_Compile,E_S_S_N_Summary,FN_Compile FROM PublicRecords_KEL;
IMPORT * FROM KEL15.Null;
EXPORT B_S_S_N_Summary_5(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE
  SHARED VIRTUAL TYPEOF(E_S_S_N_Summary(__in,__cfg).__Result) __E_S_S_N_Summary := E_S_S_N_Summary(__in,__cfg).__Result;
  SHARED __EE579936 := __E_S_S_N_Summary;
  EXPORT __ST250014_Layout := RECORD
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
  EXPORT __ST250023_Layout := RECORD
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
  EXPORT __ST250030_Layout := RECORD
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
  EXPORT __ST250038_Layout := RECORD
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
  EXPORT __ST250010_Layout := RECORD
    KEL.typ.nuid UID;
    KEL.typ.nstr S_S_N_;
    KEL.typ.ndataset(__ST250014_Layout) Address_Summary_;
    KEL.typ.ndataset(__ST250023_Layout) Date_Of_Birth_Summary_;
    KEL.typ.ndataset(__ST250030_Layout) Name_Summary_;
    KEL.typ.ndataset(__ST250038_Layout) Phone_Summary_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  SHARED __ST250010_Layout __ND580233__Project(E_S_S_N_Summary(__in,__cfg).Layout __PP579731) := TRANSFORM
    __EE579754 := __PP579731.Address_Summary_;
    __ST250014_Layout __ND580080__Project(E_S_S_N_Summary(__in,__cfg).Address_Summary_Layout __PP580076) := TRANSFORM
      SELF.Translated_Source_Code_ := FN_Compile(__cfg).FN_Consumer_Source_Group(__ECAST(KEL.typ.nstr,__PP580076.Address_Source_));
      SELF := __PP580076;
    END;
    SELF.Address_Summary_ := __PROJECT(__EE579754,__ND580080__Project(LEFT));
    __EE579804 := __PP579731.Date_Of_Birth_Summary_;
    __ST250023_Layout __ND580129__Project(E_S_S_N_Summary(__in,__cfg).Date_Of_Birth_Summary_Layout __PP580125) := TRANSFORM
      SELF.Translated_Source_Code_ := FN_Compile(__cfg).FN_Consumer_Source_Group(__ECAST(KEL.typ.nstr,__PP580125.Dob_Source_));
      SELF := __PP580125;
    END;
    SELF.Date_Of_Birth_Summary_ := __PROJECT(__EE579804,__ND580129__Project(LEFT));
    __EE579844 := __PP579731.Name_Summary_;
    __ST250030_Layout __ND580170__Project(E_S_S_N_Summary(__in,__cfg).Name_Summary_Layout __PP580166) := TRANSFORM
      SELF.Translated_Source_Code_ := FN_Compile(__cfg).FN_Consumer_Source_Group(__ECAST(KEL.typ.nstr,__PP580166.Name_Source_));
      SELF := __PP580166;
    END;
    SELF.Name_Summary_ := __PROJECT(__EE579844,__ND580170__Project(LEFT));
    __EE579889 := __PP579731.Phone_Summary_;
    __ST250038_Layout __ND580215__Project(E_S_S_N_Summary(__in,__cfg).Phone_Summary_Layout __PP580211) := TRANSFORM
      SELF.Phone_Translated_Source_Code_ := FN_Compile(__cfg).FN_Consumer_Source_Group(__ECAST(KEL.typ.nstr,__PP580211.Phone_Source_));
      SELF := __PP580211;
    END;
    SELF.Phone_Summary_ := __PROJECT(__EE579889,__ND580215__Project(LEFT));
    SELF := __PP579731;
  END;
  EXPORT __ENH_S_S_N_Summary_5 := PROJECT(__EE579936,__ND580233__Project(LEFT));
END;
