//HPCC Systems KEL Compiler Version 1.6.0
IMPORT KEL16 AS KEL;
IMPORT CFG_Compile,E_S_S_N_Summary,FN_Compile FROM PublicRecords_KEL.KEL_Queries_MAS_NonFCRA;
IMPORT * FROM KEL16.Null;
EXPORT B_S_S_N_Summary_5(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE
  SHARED VIRTUAL TYPEOF(E_S_S_N_Summary(__in,__cfg).__Result) __E_S_S_N_Summary := E_S_S_N_Summary(__in,__cfg).__Result;
  SHARED __EE289362 := __E_S_S_N_Summary;
  EXPORT __ST175073_Layout := RECORD
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
  EXPORT __ST175082_Layout := RECORD
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
  EXPORT __ST175090_Layout := RECORD
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
  EXPORT __ST175098_Layout := RECORD
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
  EXPORT __ST175069_Layout := RECORD
    KEL.typ.nuid UID;
    KEL.typ.nstr S_S_N_;
    KEL.typ.ndataset(__ST175073_Layout) Address_Summary_;
    KEL.typ.ndataset(__ST175082_Layout) Date_Of_Birth_Summary_;
    KEL.typ.ndataset(__ST175090_Layout) Name_Summary_;
    KEL.typ.ndataset(__ST175098_Layout) Phone_Summary_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  SHARED __ST175069_Layout __ND289667__Project(E_S_S_N_Summary(__in,__cfg).Layout __PP289152) := TRANSFORM
    __EE289175 := __PP289152.Address_Summary_;
    __ST175073_Layout __ND289510__Project(E_S_S_N_Summary(__in,__cfg).Address_Summary_Layout __PP289506) := TRANSFORM
      SELF.Translated_Source_Code_ := FN_Compile(__cfg).FN_Consumer_Source_Group(__ECAST(KEL.typ.nstr,__PP289506.Address_Source_));
      SELF := __PP289506;
    END;
    SELF.Address_Summary_ := __PROJECT(__EE289175,__ND289510__Project(LEFT));
    __EE289225 := __PP289152.Date_Of_Birth_Summary_;
    __ST175082_Layout __ND289559__Project(E_S_S_N_Summary(__in,__cfg).Date_Of_Birth_Summary_Layout __PP289555) := TRANSFORM
      SELF.Translated_Source_Code_ := FN_Compile(__cfg).FN_Consumer_Source_Group(__ECAST(KEL.typ.nstr,__PP289555.Dob_Source_));
      SELF := __PP289555;
    END;
    SELF.Date_Of_Birth_Summary_ := __PROJECT(__EE289225,__ND289559__Project(LEFT));
    __EE289270 := __PP289152.Name_Summary_;
    __ST175090_Layout __ND289604__Project(E_S_S_N_Summary(__in,__cfg).Name_Summary_Layout __PP289600) := TRANSFORM
      SELF.Translated_Source_Code_ := FN_Compile(__cfg).FN_Consumer_Source_Group(__ECAST(KEL.typ.nstr,__PP289600.Name_Source_));
      SELF := __PP289600;
    END;
    SELF.Name_Summary_ := __PROJECT(__EE289270,__ND289604__Project(LEFT));
    __EE289315 := __PP289152.Phone_Summary_;
    __ST175098_Layout __ND289649__Project(E_S_S_N_Summary(__in,__cfg).Phone_Summary_Layout __PP289645) := TRANSFORM
      SELF.Phone_Translated_Source_Code_ := FN_Compile(__cfg).FN_Consumer_Source_Group(__ECAST(KEL.typ.nstr,__PP289645.Phone_Source_));
      SELF := __PP289645;
    END;
    SELF.Phone_Summary_ := __PROJECT(__EE289315,__ND289649__Project(LEFT));
    SELF := __PP289152;
  END;
  EXPORT __ENH_S_S_N_Summary_5 := PROJECT(__EE289362,__ND289667__Project(LEFT));
END;
