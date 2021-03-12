//HPCC Systems KEL Compiler Version 1.5.0rc1
IMPORT KEL15 AS KEL;
IMPORT CFG_Compile,E_S_S_N_Summary,FN_Compile FROM PublicRecords_KEL;
IMPORT * FROM KEL15.Null;
EXPORT B_S_S_N_Summary_5(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE
  SHARED VIRTUAL TYPEOF(E_S_S_N_Summary(__in,__cfg).__Result) __E_S_S_N_Summary := E_S_S_N_Summary(__in,__cfg).__Result;
  SHARED __EE607035 := __E_S_S_N_Summary;
  EXPORT __ST264605_Layout := RECORD
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
  EXPORT __ST264614_Layout := RECORD
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
  EXPORT __ST264622_Layout := RECORD
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
  EXPORT __ST264630_Layout := RECORD
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
  EXPORT __ST264601_Layout := RECORD
    KEL.typ.nuid UID;
    KEL.typ.nstr S_S_N_;
    KEL.typ.ndataset(__ST264605_Layout) Address_Summary_;
    KEL.typ.ndataset(__ST264614_Layout) Date_Of_Birth_Summary_;
    KEL.typ.ndataset(__ST264622_Layout) Name_Summary_;
    KEL.typ.ndataset(__ST264630_Layout) Phone_Summary_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  SHARED __ST264601_Layout __ND607340__Project(E_S_S_N_Summary(__in,__cfg).Layout __PP606825) := TRANSFORM
    __EE606848 := __PP606825.Address_Summary_;
    __ST264605_Layout __ND607183__Project(E_S_S_N_Summary(__in,__cfg).Address_Summary_Layout __PP607179) := TRANSFORM
      SELF.Translated_Source_Code_ := FN_Compile(__cfg).FN_Consumer_Source_Group(__ECAST(KEL.typ.nstr,__PP607179.Address_Source_));
      SELF := __PP607179;
    END;
    SELF.Address_Summary_ := __PROJECT(__EE606848,__ND607183__Project(LEFT));
    __EE606898 := __PP606825.Date_Of_Birth_Summary_;
    __ST264614_Layout __ND607232__Project(E_S_S_N_Summary(__in,__cfg).Date_Of_Birth_Summary_Layout __PP607228) := TRANSFORM
      SELF.Translated_Source_Code_ := FN_Compile(__cfg).FN_Consumer_Source_Group(__ECAST(KEL.typ.nstr,__PP607228.Dob_Source_));
      SELF := __PP607228;
    END;
    SELF.Date_Of_Birth_Summary_ := __PROJECT(__EE606898,__ND607232__Project(LEFT));
    __EE606943 := __PP606825.Name_Summary_;
    __ST264622_Layout __ND607277__Project(E_S_S_N_Summary(__in,__cfg).Name_Summary_Layout __PP607273) := TRANSFORM
      SELF.Translated_Source_Code_ := FN_Compile(__cfg).FN_Consumer_Source_Group(__ECAST(KEL.typ.nstr,__PP607273.Name_Source_));
      SELF := __PP607273;
    END;
    SELF.Name_Summary_ := __PROJECT(__EE606943,__ND607277__Project(LEFT));
    __EE606988 := __PP606825.Phone_Summary_;
    __ST264630_Layout __ND607322__Project(E_S_S_N_Summary(__in,__cfg).Phone_Summary_Layout __PP607318) := TRANSFORM
      SELF.Phone_Translated_Source_Code_ := FN_Compile(__cfg).FN_Consumer_Source_Group(__ECAST(KEL.typ.nstr,__PP607318.Phone_Source_));
      SELF := __PP607318;
    END;
    SELF.Phone_Summary_ := __PROJECT(__EE606988,__ND607322__Project(LEFT));
    SELF := __PP606825;
  END;
  EXPORT __ENH_S_S_N_Summary_5 := PROJECT(__EE607035,__ND607340__Project(LEFT));
END;
