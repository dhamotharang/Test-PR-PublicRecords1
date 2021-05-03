//HPCC Systems KEL Compiler Version 1.6.0
IMPORT KEL16 AS KEL;
IMPORT CFG_Compile,E_S_S_N_Summary,FN_Compile FROM PublicRecords_KEL.KEL_Queries_MAS_NonFCRA;
IMPORT * FROM KEL16.Null;
EXPORT B_S_S_N_Summary_5(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE
  SHARED VIRTUAL TYPEOF(E_S_S_N_Summary(__in,__cfg).__Result) __E_S_S_N_Summary := E_S_S_N_Summary(__in,__cfg).__Result;
  SHARED __EE287854 := __E_S_S_N_Summary;
  EXPORT __ST173811_Layout := RECORD
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
  EXPORT __ST173820_Layout := RECORD
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
  EXPORT __ST173828_Layout := RECORD
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
  EXPORT __ST173836_Layout := RECORD
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
  EXPORT __ST173807_Layout := RECORD
    KEL.typ.nuid UID;
    KEL.typ.nstr S_S_N_;
    KEL.typ.ndataset(__ST173811_Layout) Address_Summary_;
    KEL.typ.ndataset(__ST173820_Layout) Date_Of_Birth_Summary_;
    KEL.typ.ndataset(__ST173828_Layout) Name_Summary_;
    KEL.typ.ndataset(__ST173836_Layout) Phone_Summary_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  SHARED __ST173807_Layout __ND288159__Project(E_S_S_N_Summary(__in,__cfg).Layout __PP287644) := TRANSFORM
    __EE287667 := __PP287644.Address_Summary_;
    __ST173811_Layout __ND288002__Project(E_S_S_N_Summary(__in,__cfg).Address_Summary_Layout __PP287998) := TRANSFORM
      SELF.Translated_Source_Code_ := FN_Compile(__cfg).FN_Consumer_Source_Group(__ECAST(KEL.typ.nstr,__PP287998.Address_Source_));
      SELF := __PP287998;
    END;
    SELF.Address_Summary_ := __PROJECT(__EE287667,__ND288002__Project(LEFT));
    __EE287717 := __PP287644.Date_Of_Birth_Summary_;
    __ST173820_Layout __ND288051__Project(E_S_S_N_Summary(__in,__cfg).Date_Of_Birth_Summary_Layout __PP288047) := TRANSFORM
      SELF.Translated_Source_Code_ := FN_Compile(__cfg).FN_Consumer_Source_Group(__ECAST(KEL.typ.nstr,__PP288047.Dob_Source_));
      SELF := __PP288047;
    END;
    SELF.Date_Of_Birth_Summary_ := __PROJECT(__EE287717,__ND288051__Project(LEFT));
    __EE287762 := __PP287644.Name_Summary_;
    __ST173828_Layout __ND288096__Project(E_S_S_N_Summary(__in,__cfg).Name_Summary_Layout __PP288092) := TRANSFORM
      SELF.Translated_Source_Code_ := FN_Compile(__cfg).FN_Consumer_Source_Group(__ECAST(KEL.typ.nstr,__PP288092.Name_Source_));
      SELF := __PP288092;
    END;
    SELF.Name_Summary_ := __PROJECT(__EE287762,__ND288096__Project(LEFT));
    __EE287807 := __PP287644.Phone_Summary_;
    __ST173836_Layout __ND288141__Project(E_S_S_N_Summary(__in,__cfg).Phone_Summary_Layout __PP288137) := TRANSFORM
      SELF.Phone_Translated_Source_Code_ := FN_Compile(__cfg).FN_Consumer_Source_Group(__ECAST(KEL.typ.nstr,__PP288137.Phone_Source_));
      SELF := __PP288137;
    END;
    SELF.Phone_Summary_ := __PROJECT(__EE287807,__ND288141__Project(LEFT));
    SELF := __PP287644;
  END;
  EXPORT __ENH_S_S_N_Summary_5 := PROJECT(__EE287854,__ND288159__Project(LEFT));
END;
