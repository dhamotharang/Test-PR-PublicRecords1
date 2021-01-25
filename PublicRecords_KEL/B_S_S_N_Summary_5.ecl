//HPCC Systems KEL Compiler Version 1.5.0rc1
IMPORT KEL15 AS KEL;
IMPORT CFG_Compile,E_S_S_N_Summary,FN_Compile FROM PublicRecords_KEL;
IMPORT * FROM KEL15.Null;
EXPORT B_S_S_N_Summary_5(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE
  SHARED VIRTUAL TYPEOF(E_S_S_N_Summary(__in,__cfg).__Result) __E_S_S_N_Summary := E_S_S_N_Summary(__in,__cfg).__Result;
  SHARED __EE509860 := __E_S_S_N_Summary;
  EXPORT __ST242236_Layout := RECORD
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
  EXPORT __ST242245_Layout := RECORD
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
  EXPORT __ST242252_Layout := RECORD
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
  EXPORT __ST242260_Layout := RECORD
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
  EXPORT __ST242232_Layout := RECORD
    KEL.typ.nuid UID;
    KEL.typ.nstr S_S_N_;
    KEL.typ.ndataset(__ST242236_Layout) Address_Summary_;
    KEL.typ.ndataset(__ST242245_Layout) Date_Of_Birth_Summary_;
    KEL.typ.ndataset(__ST242252_Layout) Name_Summary_;
    KEL.typ.ndataset(__ST242260_Layout) Phone_Summary_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  SHARED __ST242232_Layout __ND510157__Project(E_S_S_N_Summary(__in,__cfg).Layout __PP509655) := TRANSFORM
    __EE509678 := __PP509655.Address_Summary_;
    __ST242236_Layout __ND510004__Project(E_S_S_N_Summary(__in,__cfg).Address_Summary_Layout __PP510000) := TRANSFORM
      SELF.Translated_Source_Code_ := FN_Compile(__cfg).FN_Consumer_Source_Group(__ECAST(KEL.typ.nstr,__PP510000.Address_Source_));
      SELF := __PP510000;
    END;
    SELF.Address_Summary_ := __PROJECT(__EE509678,__ND510004__Project(LEFT));
    __EE509728 := __PP509655.Date_Of_Birth_Summary_;
    __ST242245_Layout __ND510053__Project(E_S_S_N_Summary(__in,__cfg).Date_Of_Birth_Summary_Layout __PP510049) := TRANSFORM
      SELF.Translated_Source_Code_ := FN_Compile(__cfg).FN_Consumer_Source_Group(__ECAST(KEL.typ.nstr,__PP510049.Dob_Source_));
      SELF := __PP510049;
    END;
    SELF.Date_Of_Birth_Summary_ := __PROJECT(__EE509728,__ND510053__Project(LEFT));
    __EE509768 := __PP509655.Name_Summary_;
    __ST242252_Layout __ND510094__Project(E_S_S_N_Summary(__in,__cfg).Name_Summary_Layout __PP510090) := TRANSFORM
      SELF.Translated_Source_Code_ := FN_Compile(__cfg).FN_Consumer_Source_Group(__ECAST(KEL.typ.nstr,__PP510090.Name_Source_));
      SELF := __PP510090;
    END;
    SELF.Name_Summary_ := __PROJECT(__EE509768,__ND510094__Project(LEFT));
    __EE509813 := __PP509655.Phone_Summary_;
    __ST242260_Layout __ND510139__Project(E_S_S_N_Summary(__in,__cfg).Phone_Summary_Layout __PP510135) := TRANSFORM
      SELF.Phone_Translated_Source_Code_ := FN_Compile(__cfg).FN_Consumer_Source_Group(__ECAST(KEL.typ.nstr,__PP510135.Phone_Source_));
      SELF := __PP510135;
    END;
    SELF.Phone_Summary_ := __PROJECT(__EE509813,__ND510139__Project(LEFT));
    SELF := __PP509655;
  END;
  EXPORT __ENH_S_S_N_Summary_5 := PROJECT(__EE509860,__ND510157__Project(LEFT));
END;
