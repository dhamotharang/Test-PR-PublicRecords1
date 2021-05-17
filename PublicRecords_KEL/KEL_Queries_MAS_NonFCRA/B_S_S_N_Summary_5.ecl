//HPCC Systems KEL Compiler Version 1.6.0
IMPORT KEL16 AS KEL;
IMPORT CFG_Compile,E_S_S_N_Summary,FN_Compile FROM PublicRecords_KEL.KEL_Queries_MAS_NonFCRA;
IMPORT * FROM KEL16.Null;
EXPORT B_S_S_N_Summary_5(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE
  SHARED VIRTUAL TYPEOF(E_S_S_N_Summary(__in,__cfg).__Result) __E_S_S_N_Summary := E_S_S_N_Summary(__in,__cfg).__Result;
  SHARED __EE292413 := __E_S_S_N_Summary;
  EXPORT __ST177872_Layout := RECORD
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
  EXPORT __ST177881_Layout := RECORD
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
  EXPORT __ST177889_Layout := RECORD
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
  EXPORT __ST177897_Layout := RECORD
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
  EXPORT __ST177868_Layout := RECORD
    KEL.typ.nuid UID;
    KEL.typ.nstr S_S_N_;
    KEL.typ.ndataset(__ST177872_Layout) Address_Summary_;
    KEL.typ.ndataset(__ST177881_Layout) Date_Of_Birth_Summary_;
    KEL.typ.ndataset(__ST177889_Layout) Name_Summary_;
    KEL.typ.ndataset(__ST177897_Layout) Phone_Summary_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  SHARED __ST177868_Layout __ND292718__Project(E_S_S_N_Summary(__in,__cfg).Layout __PP292203) := TRANSFORM
    __EE292226 := __PP292203.Address_Summary_;
    __ST177872_Layout __ND292561__Project(E_S_S_N_Summary(__in,__cfg).Address_Summary_Layout __PP292557) := TRANSFORM
      SELF.Translated_Source_Code_ := FN_Compile(__cfg).FN_Consumer_Source_Group(__ECAST(KEL.typ.nstr,__PP292557.Address_Source_));
      SELF := __PP292557;
    END;
    SELF.Address_Summary_ := __PROJECT(__EE292226,__ND292561__Project(LEFT));
    __EE292276 := __PP292203.Date_Of_Birth_Summary_;
    __ST177881_Layout __ND292610__Project(E_S_S_N_Summary(__in,__cfg).Date_Of_Birth_Summary_Layout __PP292606) := TRANSFORM
      SELF.Translated_Source_Code_ := FN_Compile(__cfg).FN_Consumer_Source_Group(__ECAST(KEL.typ.nstr,__PP292606.Dob_Source_));
      SELF := __PP292606;
    END;
    SELF.Date_Of_Birth_Summary_ := __PROJECT(__EE292276,__ND292610__Project(LEFT));
    __EE292321 := __PP292203.Name_Summary_;
    __ST177889_Layout __ND292655__Project(E_S_S_N_Summary(__in,__cfg).Name_Summary_Layout __PP292651) := TRANSFORM
      SELF.Translated_Source_Code_ := FN_Compile(__cfg).FN_Consumer_Source_Group(__ECAST(KEL.typ.nstr,__PP292651.Name_Source_));
      SELF := __PP292651;
    END;
    SELF.Name_Summary_ := __PROJECT(__EE292321,__ND292655__Project(LEFT));
    __EE292366 := __PP292203.Phone_Summary_;
    __ST177897_Layout __ND292700__Project(E_S_S_N_Summary(__in,__cfg).Phone_Summary_Layout __PP292696) := TRANSFORM
      SELF.Phone_Translated_Source_Code_ := FN_Compile(__cfg).FN_Consumer_Source_Group(__ECAST(KEL.typ.nstr,__PP292696.Phone_Source_));
      SELF := __PP292696;
    END;
    SELF.Phone_Summary_ := __PROJECT(__EE292366,__ND292700__Project(LEFT));
    SELF := __PP292203;
  END;
  EXPORT __ENH_S_S_N_Summary_5 := PROJECT(__EE292413,__ND292718__Project(LEFT));
END;
