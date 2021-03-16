//HPCC Systems KEL Compiler Version 1.5.0rc1
IMPORT KEL15 AS KEL;
IMPORT CFG_Compile,E_S_S_N_Summary,FN_Compile FROM PublicRecords_KEL;
IMPORT * FROM KEL15.Null;
EXPORT B_S_S_N_Summary_5(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE
  SHARED VIRTUAL TYPEOF(E_S_S_N_Summary(__in,__cfg).__Result) __E_S_S_N_Summary := E_S_S_N_Summary(__in,__cfg).__Result;
  SHARED __EE610143 := __E_S_S_N_Summary;
  EXPORT __ST264718_Layout := RECORD
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
  EXPORT __ST264727_Layout := RECORD
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
  EXPORT __ST264735_Layout := RECORD
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
  EXPORT __ST264743_Layout := RECORD
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
  EXPORT __ST264714_Layout := RECORD
    KEL.typ.nuid UID;
    KEL.typ.nstr S_S_N_;
    KEL.typ.ndataset(__ST264718_Layout) Address_Summary_;
    KEL.typ.ndataset(__ST264727_Layout) Date_Of_Birth_Summary_;
    KEL.typ.ndataset(__ST264735_Layout) Name_Summary_;
    KEL.typ.ndataset(__ST264743_Layout) Phone_Summary_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  SHARED __ST264714_Layout __ND610448__Project(E_S_S_N_Summary(__in,__cfg).Layout __PP609933) := TRANSFORM
    __EE609956 := __PP609933.Address_Summary_;
    __ST264718_Layout __ND610291__Project(E_S_S_N_Summary(__in,__cfg).Address_Summary_Layout __PP610287) := TRANSFORM
      SELF.Translated_Source_Code_ := FN_Compile(__cfg).FN_Consumer_Source_Group(__ECAST(KEL.typ.nstr,__PP610287.Address_Source_));
      SELF := __PP610287;
    END;
    SELF.Address_Summary_ := __PROJECT(__EE609956,__ND610291__Project(LEFT));
    __EE610006 := __PP609933.Date_Of_Birth_Summary_;
    __ST264727_Layout __ND610340__Project(E_S_S_N_Summary(__in,__cfg).Date_Of_Birth_Summary_Layout __PP610336) := TRANSFORM
      SELF.Translated_Source_Code_ := FN_Compile(__cfg).FN_Consumer_Source_Group(__ECAST(KEL.typ.nstr,__PP610336.Dob_Source_));
      SELF := __PP610336;
    END;
    SELF.Date_Of_Birth_Summary_ := __PROJECT(__EE610006,__ND610340__Project(LEFT));
    __EE610051 := __PP609933.Name_Summary_;
    __ST264735_Layout __ND610385__Project(E_S_S_N_Summary(__in,__cfg).Name_Summary_Layout __PP610381) := TRANSFORM
      SELF.Translated_Source_Code_ := FN_Compile(__cfg).FN_Consumer_Source_Group(__ECAST(KEL.typ.nstr,__PP610381.Name_Source_));
      SELF := __PP610381;
    END;
    SELF.Name_Summary_ := __PROJECT(__EE610051,__ND610385__Project(LEFT));
    __EE610096 := __PP609933.Phone_Summary_;
    __ST264743_Layout __ND610430__Project(E_S_S_N_Summary(__in,__cfg).Phone_Summary_Layout __PP610426) := TRANSFORM
      SELF.Phone_Translated_Source_Code_ := FN_Compile(__cfg).FN_Consumer_Source_Group(__ECAST(KEL.typ.nstr,__PP610426.Phone_Source_));
      SELF := __PP610426;
    END;
    SELF.Phone_Summary_ := __PROJECT(__EE610096,__ND610430__Project(LEFT));
    SELF := __PP609933;
  END;
  EXPORT __ENH_S_S_N_Summary_5 := PROJECT(__EE610143,__ND610448__Project(LEFT));
END;
