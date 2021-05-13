//HPCC Systems KEL Compiler Version 1.6.0
IMPORT KEL16 AS KEL;
IMPORT CFG_Compile,E_S_S_N_Summary,FN_Compile FROM PublicRecords_KEL.KEL_Queries_MAS_NonFCRA;
IMPORT * FROM KEL16.Null;
EXPORT B_S_S_N_Summary_5(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE
  SHARED VIRTUAL TYPEOF(E_S_S_N_Summary(__in,__cfg).__Result) __E_S_S_N_Summary := E_S_S_N_Summary(__in,__cfg).__Result;
  SHARED __EE297569 := __E_S_S_N_Summary;
  EXPORT __ST181002_Layout := RECORD
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
  EXPORT __ST181011_Layout := RECORD
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
  EXPORT __ST181019_Layout := RECORD
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
  EXPORT __ST181027_Layout := RECORD
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
  EXPORT __ST180998_Layout := RECORD
    KEL.typ.nuid UID;
    KEL.typ.nstr S_S_N_;
    KEL.typ.ndataset(__ST181002_Layout) Address_Summary_;
    KEL.typ.ndataset(__ST181011_Layout) Date_Of_Birth_Summary_;
    KEL.typ.ndataset(__ST181019_Layout) Name_Summary_;
    KEL.typ.ndataset(__ST181027_Layout) Phone_Summary_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  SHARED __ST180998_Layout __ND297874__Project(E_S_S_N_Summary(__in,__cfg).Layout __PP297359) := TRANSFORM
    __EE297382 := __PP297359.Address_Summary_;
    __ST181002_Layout __ND297717__Project(E_S_S_N_Summary(__in,__cfg).Address_Summary_Layout __PP297713) := TRANSFORM
      SELF.Translated_Source_Code_ := FN_Compile(__cfg).FN_Consumer_Source_Group(__ECAST(KEL.typ.nstr,__PP297713.Address_Source_));
      SELF := __PP297713;
    END;
    SELF.Address_Summary_ := __PROJECT(__EE297382,__ND297717__Project(LEFT));
    __EE297432 := __PP297359.Date_Of_Birth_Summary_;
    __ST181011_Layout __ND297766__Project(E_S_S_N_Summary(__in,__cfg).Date_Of_Birth_Summary_Layout __PP297762) := TRANSFORM
      SELF.Translated_Source_Code_ := FN_Compile(__cfg).FN_Consumer_Source_Group(__ECAST(KEL.typ.nstr,__PP297762.Dob_Source_));
      SELF := __PP297762;
    END;
    SELF.Date_Of_Birth_Summary_ := __PROJECT(__EE297432,__ND297766__Project(LEFT));
    __EE297477 := __PP297359.Name_Summary_;
    __ST181019_Layout __ND297811__Project(E_S_S_N_Summary(__in,__cfg).Name_Summary_Layout __PP297807) := TRANSFORM
      SELF.Translated_Source_Code_ := FN_Compile(__cfg).FN_Consumer_Source_Group(__ECAST(KEL.typ.nstr,__PP297807.Name_Source_));
      SELF := __PP297807;
    END;
    SELF.Name_Summary_ := __PROJECT(__EE297477,__ND297811__Project(LEFT));
    __EE297522 := __PP297359.Phone_Summary_;
    __ST181027_Layout __ND297856__Project(E_S_S_N_Summary(__in,__cfg).Phone_Summary_Layout __PP297852) := TRANSFORM
      SELF.Phone_Translated_Source_Code_ := FN_Compile(__cfg).FN_Consumer_Source_Group(__ECAST(KEL.typ.nstr,__PP297852.Phone_Source_));
      SELF := __PP297852;
    END;
    SELF.Phone_Summary_ := __PROJECT(__EE297522,__ND297856__Project(LEFT));
    SELF := __PP297359;
  END;
  EXPORT __ENH_S_S_N_Summary_5 := PROJECT(__EE297569,__ND297874__Project(LEFT));
END;
