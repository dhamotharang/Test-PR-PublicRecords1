//HPCC Systems KEL Compiler Version 1.5.0rc1
IMPORT KEL15 AS KEL;
IMPORT CFG_Compile,E_S_S_N_Summary,FN_Compile FROM PublicRecords_KEL;
IMPORT * FROM KEL15.Null;
EXPORT B_S_S_N_Summary_5(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE
  SHARED VIRTUAL TYPEOF(E_S_S_N_Summary(__in,__cfg).__Result) __E_S_S_N_Summary := E_S_S_N_Summary(__in,__cfg).__Result;
  SHARED __EE597725 := __E_S_S_N_Summary;
  EXPORT __ST254700_Layout := RECORD
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
  EXPORT __ST254709_Layout := RECORD
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
  EXPORT __ST254717_Layout := RECORD
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
  EXPORT __ST254725_Layout := RECORD
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
  EXPORT __ST254696_Layout := RECORD
    KEL.typ.nuid UID;
    KEL.typ.nstr S_S_N_;
    KEL.typ.ndataset(__ST254700_Layout) Address_Summary_;
    KEL.typ.ndataset(__ST254709_Layout) Date_Of_Birth_Summary_;
    KEL.typ.ndataset(__ST254717_Layout) Name_Summary_;
    KEL.typ.ndataset(__ST254725_Layout) Phone_Summary_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  SHARED __ST254696_Layout __ND598030__Project(E_S_S_N_Summary(__in,__cfg).Layout __PP597515) := TRANSFORM
    __EE597538 := __PP597515.Address_Summary_;
    __ST254700_Layout __ND597873__Project(E_S_S_N_Summary(__in,__cfg).Address_Summary_Layout __PP597869) := TRANSFORM
      SELF.Translated_Source_Code_ := FN_Compile(__cfg).FN_Consumer_Source_Group(__ECAST(KEL.typ.nstr,__PP597869.Address_Source_));
      SELF := __PP597869;
    END;
    SELF.Address_Summary_ := __PROJECT(__EE597538,__ND597873__Project(LEFT));
    __EE597588 := __PP597515.Date_Of_Birth_Summary_;
    __ST254709_Layout __ND597922__Project(E_S_S_N_Summary(__in,__cfg).Date_Of_Birth_Summary_Layout __PP597918) := TRANSFORM
      SELF.Translated_Source_Code_ := FN_Compile(__cfg).FN_Consumer_Source_Group(__ECAST(KEL.typ.nstr,__PP597918.Dob_Source_));
      SELF := __PP597918;
    END;
    SELF.Date_Of_Birth_Summary_ := __PROJECT(__EE597588,__ND597922__Project(LEFT));
    __EE597633 := __PP597515.Name_Summary_;
    __ST254717_Layout __ND597967__Project(E_S_S_N_Summary(__in,__cfg).Name_Summary_Layout __PP597963) := TRANSFORM
      SELF.Translated_Source_Code_ := FN_Compile(__cfg).FN_Consumer_Source_Group(__ECAST(KEL.typ.nstr,__PP597963.Name_Source_));
      SELF := __PP597963;
    END;
    SELF.Name_Summary_ := __PROJECT(__EE597633,__ND597967__Project(LEFT));
    __EE597678 := __PP597515.Phone_Summary_;
    __ST254725_Layout __ND598012__Project(E_S_S_N_Summary(__in,__cfg).Phone_Summary_Layout __PP598008) := TRANSFORM
      SELF.Phone_Translated_Source_Code_ := FN_Compile(__cfg).FN_Consumer_Source_Group(__ECAST(KEL.typ.nstr,__PP598008.Phone_Source_));
      SELF := __PP598008;
    END;
    SELF.Phone_Summary_ := __PROJECT(__EE597678,__ND598012__Project(LEFT));
    SELF := __PP597515;
  END;
  EXPORT __ENH_S_S_N_Summary_5 := PROJECT(__EE597725,__ND598030__Project(LEFT));
END;
