//HPCC Systems KEL Compiler Version 1.5.0rc1
IMPORT KEL15 AS KEL;
IMPORT CFG_Compile,E_S_S_N_Summary,FN_Compile FROM PublicRecords_KEL;
IMPORT * FROM KEL15.Null;
EXPORT B_S_S_N_Summary_5(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE
  SHARED VIRTUAL TYPEOF(E_S_S_N_Summary(__in,__cfg).__Result) __E_S_S_N_Summary := E_S_S_N_Summary(__in,__cfg).__Result;
  SHARED __EE509379 := __E_S_S_N_Summary;
  EXPORT __ST241714_Layout := RECORD
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
  EXPORT __ST241723_Layout := RECORD
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
  EXPORT __ST241730_Layout := RECORD
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
  EXPORT __ST241738_Layout := RECORD
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
  EXPORT __ST241710_Layout := RECORD
    KEL.typ.nuid UID;
    KEL.typ.nstr S_S_N_;
    KEL.typ.ndataset(__ST241714_Layout) Address_Summary_;
    KEL.typ.ndataset(__ST241723_Layout) Date_Of_Birth_Summary_;
    KEL.typ.ndataset(__ST241730_Layout) Name_Summary_;
    KEL.typ.ndataset(__ST241738_Layout) Phone_Summary_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  SHARED __ST241710_Layout __ND509676__Project(E_S_S_N_Summary(__in,__cfg).Layout __PP509174) := TRANSFORM
    __EE509197 := __PP509174.Address_Summary_;
    __ST241714_Layout __ND509523__Project(E_S_S_N_Summary(__in,__cfg).Address_Summary_Layout __PP509519) := TRANSFORM
      SELF.Translated_Source_Code_ := FN_Compile(__cfg).FN_Consumer_Source_Group(__ECAST(KEL.typ.nstr,__PP509519.Address_Source_));
      SELF := __PP509519;
    END;
    SELF.Address_Summary_ := __PROJECT(__EE509197,__ND509523__Project(LEFT));
    __EE509247 := __PP509174.Date_Of_Birth_Summary_;
    __ST241723_Layout __ND509572__Project(E_S_S_N_Summary(__in,__cfg).Date_Of_Birth_Summary_Layout __PP509568) := TRANSFORM
      SELF.Translated_Source_Code_ := FN_Compile(__cfg).FN_Consumer_Source_Group(__ECAST(KEL.typ.nstr,__PP509568.Dob_Source_));
      SELF := __PP509568;
    END;
    SELF.Date_Of_Birth_Summary_ := __PROJECT(__EE509247,__ND509572__Project(LEFT));
    __EE509287 := __PP509174.Name_Summary_;
    __ST241730_Layout __ND509613__Project(E_S_S_N_Summary(__in,__cfg).Name_Summary_Layout __PP509609) := TRANSFORM
      SELF.Translated_Source_Code_ := FN_Compile(__cfg).FN_Consumer_Source_Group(__ECAST(KEL.typ.nstr,__PP509609.Name_Source_));
      SELF := __PP509609;
    END;
    SELF.Name_Summary_ := __PROJECT(__EE509287,__ND509613__Project(LEFT));
    __EE509332 := __PP509174.Phone_Summary_;
    __ST241738_Layout __ND509658__Project(E_S_S_N_Summary(__in,__cfg).Phone_Summary_Layout __PP509654) := TRANSFORM
      SELF.Phone_Translated_Source_Code_ := FN_Compile(__cfg).FN_Consumer_Source_Group(__ECAST(KEL.typ.nstr,__PP509654.Phone_Source_));
      SELF := __PP509654;
    END;
    SELF.Phone_Summary_ := __PROJECT(__EE509332,__ND509658__Project(LEFT));
    SELF := __PP509174;
  END;
  EXPORT __ENH_S_S_N_Summary_5 := PROJECT(__EE509379,__ND509676__Project(LEFT));
END;
