//HPCC Systems KEL Compiler Version 1.6.0
IMPORT KEL16 AS KEL;
IMPORT CFG_Compile,E_S_S_N_Summary,FN_Compile FROM PublicRecords_KEL.KEL_Queries_MAS_NonFCRA;
IMPORT * FROM KEL16.Null;
EXPORT B_S_S_N_Summary_5(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE
  SHARED VIRTUAL TYPEOF(E_S_S_N_Summary(__in,__cfg).__Result) __E_S_S_N_Summary := E_S_S_N_Summary(__in,__cfg).__Result;
  SHARED __EE294873 := __E_S_S_N_Summary;
  EXPORT __ST179516_Layout := RECORD
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
  EXPORT __ST179525_Layout := RECORD
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
  EXPORT __ST179533_Layout := RECORD
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
  EXPORT __ST179541_Layout := RECORD
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
  EXPORT __ST179512_Layout := RECORD
    KEL.typ.nuid UID;
    KEL.typ.nstr S_S_N_;
    KEL.typ.ndataset(__ST179516_Layout) Address_Summary_;
    KEL.typ.ndataset(__ST179525_Layout) Date_Of_Birth_Summary_;
    KEL.typ.ndataset(__ST179533_Layout) Name_Summary_;
    KEL.typ.ndataset(__ST179541_Layout) Phone_Summary_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  SHARED __ST179512_Layout __ND295178__Project(E_S_S_N_Summary(__in,__cfg).Layout __PP294663) := TRANSFORM
    __EE294686 := __PP294663.Address_Summary_;
    __ST179516_Layout __ND295021__Project(E_S_S_N_Summary(__in,__cfg).Address_Summary_Layout __PP295017) := TRANSFORM
      SELF.Translated_Source_Code_ := FN_Compile(__cfg).FN_Consumer_Source_Group(__ECAST(KEL.typ.nstr,__PP295017.Address_Source_));
      SELF := __PP295017;
    END;
    SELF.Address_Summary_ := __PROJECT(__EE294686,__ND295021__Project(LEFT));
    __EE294736 := __PP294663.Date_Of_Birth_Summary_;
    __ST179525_Layout __ND295070__Project(E_S_S_N_Summary(__in,__cfg).Date_Of_Birth_Summary_Layout __PP295066) := TRANSFORM
      SELF.Translated_Source_Code_ := FN_Compile(__cfg).FN_Consumer_Source_Group(__ECAST(KEL.typ.nstr,__PP295066.Dob_Source_));
      SELF := __PP295066;
    END;
    SELF.Date_Of_Birth_Summary_ := __PROJECT(__EE294736,__ND295070__Project(LEFT));
    __EE294781 := __PP294663.Name_Summary_;
    __ST179533_Layout __ND295115__Project(E_S_S_N_Summary(__in,__cfg).Name_Summary_Layout __PP295111) := TRANSFORM
      SELF.Translated_Source_Code_ := FN_Compile(__cfg).FN_Consumer_Source_Group(__ECAST(KEL.typ.nstr,__PP295111.Name_Source_));
      SELF := __PP295111;
    END;
    SELF.Name_Summary_ := __PROJECT(__EE294781,__ND295115__Project(LEFT));
    __EE294826 := __PP294663.Phone_Summary_;
    __ST179541_Layout __ND295160__Project(E_S_S_N_Summary(__in,__cfg).Phone_Summary_Layout __PP295156) := TRANSFORM
      SELF.Phone_Translated_Source_Code_ := FN_Compile(__cfg).FN_Consumer_Source_Group(__ECAST(KEL.typ.nstr,__PP295156.Phone_Source_));
      SELF := __PP295156;
    END;
    SELF.Phone_Summary_ := __PROJECT(__EE294826,__ND295160__Project(LEFT));
    SELF := __PP294663;
  END;
  EXPORT __ENH_S_S_N_Summary_5 := PROJECT(__EE294873,__ND295178__Project(LEFT));
END;
