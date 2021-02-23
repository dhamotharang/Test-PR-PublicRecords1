//HPCC Systems KEL Compiler Version 1.5.0rc1
IMPORT KEL15 AS KEL;
IMPORT CFG_Compile,E_S_S_N_Summary,FN_Compile FROM PublicRecords_KEL;
IMPORT * FROM KEL15.Null;
EXPORT B_S_S_N_Summary_5(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE
  SHARED VIRTUAL TYPEOF(E_S_S_N_Summary(__in,__cfg).__Result) __E_S_S_N_Summary := E_S_S_N_Summary(__in,__cfg).__Result;
  SHARED __EE538027 := __E_S_S_N_Summary;
  EXPORT __ST251333_Layout := RECORD
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
  EXPORT __ST251342_Layout := RECORD
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
  EXPORT __ST251349_Layout := RECORD
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
  EXPORT __ST251357_Layout := RECORD
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
  EXPORT __ST251329_Layout := RECORD
    KEL.typ.nuid UID;
    KEL.typ.nstr S_S_N_;
    KEL.typ.ndataset(__ST251333_Layout) Address_Summary_;
    KEL.typ.ndataset(__ST251342_Layout) Date_Of_Birth_Summary_;
    KEL.typ.ndataset(__ST251349_Layout) Name_Summary_;
    KEL.typ.ndataset(__ST251357_Layout) Phone_Summary_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  SHARED __ST251329_Layout __ND538324__Project(E_S_S_N_Summary(__in,__cfg).Layout __PP537822) := TRANSFORM
    __EE537845 := __PP537822.Address_Summary_;
    __ST251333_Layout __ND538171__Project(E_S_S_N_Summary(__in,__cfg).Address_Summary_Layout __PP538167) := TRANSFORM
      SELF.Translated_Source_Code_ := FN_Compile(__cfg).FN_Consumer_Source_Group(__ECAST(KEL.typ.nstr,__PP538167.Address_Source_));
      SELF := __PP538167;
    END;
    SELF.Address_Summary_ := __PROJECT(__EE537845,__ND538171__Project(LEFT));
    __EE537895 := __PP537822.Date_Of_Birth_Summary_;
    __ST251342_Layout __ND538220__Project(E_S_S_N_Summary(__in,__cfg).Date_Of_Birth_Summary_Layout __PP538216) := TRANSFORM
      SELF.Translated_Source_Code_ := FN_Compile(__cfg).FN_Consumer_Source_Group(__ECAST(KEL.typ.nstr,__PP538216.Dob_Source_));
      SELF := __PP538216;
    END;
    SELF.Date_Of_Birth_Summary_ := __PROJECT(__EE537895,__ND538220__Project(LEFT));
    __EE537935 := __PP537822.Name_Summary_;
    __ST251349_Layout __ND538261__Project(E_S_S_N_Summary(__in,__cfg).Name_Summary_Layout __PP538257) := TRANSFORM
      SELF.Translated_Source_Code_ := FN_Compile(__cfg).FN_Consumer_Source_Group(__ECAST(KEL.typ.nstr,__PP538257.Name_Source_));
      SELF := __PP538257;
    END;
    SELF.Name_Summary_ := __PROJECT(__EE537935,__ND538261__Project(LEFT));
    __EE537980 := __PP537822.Phone_Summary_;
    __ST251357_Layout __ND538306__Project(E_S_S_N_Summary(__in,__cfg).Phone_Summary_Layout __PP538302) := TRANSFORM
      SELF.Phone_Translated_Source_Code_ := FN_Compile(__cfg).FN_Consumer_Source_Group(__ECAST(KEL.typ.nstr,__PP538302.Phone_Source_));
      SELF := __PP538302;
    END;
    SELF.Phone_Summary_ := __PROJECT(__EE537980,__ND538306__Project(LEFT));
    SELF := __PP537822;
  END;
  EXPORT __ENH_S_S_N_Summary_5 := PROJECT(__EE538027,__ND538324__Project(LEFT));
END;
