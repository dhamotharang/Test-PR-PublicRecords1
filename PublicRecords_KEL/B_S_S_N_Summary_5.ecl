//HPCC Systems KEL Compiler Version 1.5.0rc1
IMPORT KEL15 AS KEL;
IMPORT CFG_Compile,E_S_S_N_Summary,FN_Compile FROM PublicRecords_KEL;
IMPORT * FROM KEL15.Null;
EXPORT B_S_S_N_Summary_5(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE
  SHARED VIRTUAL TYPEOF(E_S_S_N_Summary(__in,__cfg).__Result) __E_S_S_N_Summary := E_S_S_N_Summary(__in,__cfg).__Result;
  SHARED __EE646228 := __E_S_S_N_Summary;
  EXPORT __ST273451_Layout := RECORD
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
  EXPORT __ST273460_Layout := RECORD
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
  EXPORT __ST273468_Layout := RECORD
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
  EXPORT __ST273476_Layout := RECORD
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
  EXPORT __ST273447_Layout := RECORD
    KEL.typ.nuid UID;
    KEL.typ.nstr S_S_N_;
    KEL.typ.ndataset(__ST273451_Layout) Address_Summary_;
    KEL.typ.ndataset(__ST273460_Layout) Date_Of_Birth_Summary_;
    KEL.typ.ndataset(__ST273468_Layout) Name_Summary_;
    KEL.typ.ndataset(__ST273476_Layout) Phone_Summary_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  SHARED __ST273447_Layout __ND646533__Project(E_S_S_N_Summary(__in,__cfg).Layout __PP646018) := TRANSFORM
    __EE646041 := __PP646018.Address_Summary_;
    __ST273451_Layout __ND646376__Project(E_S_S_N_Summary(__in,__cfg).Address_Summary_Layout __PP646372) := TRANSFORM
      SELF.Translated_Source_Code_ := FN_Compile(__cfg).FN_Consumer_Source_Group(__ECAST(KEL.typ.nstr,__PP646372.Address_Source_));
      SELF := __PP646372;
    END;
    SELF.Address_Summary_ := __PROJECT(__EE646041,__ND646376__Project(LEFT));
    __EE646091 := __PP646018.Date_Of_Birth_Summary_;
    __ST273460_Layout __ND646425__Project(E_S_S_N_Summary(__in,__cfg).Date_Of_Birth_Summary_Layout __PP646421) := TRANSFORM
      SELF.Translated_Source_Code_ := FN_Compile(__cfg).FN_Consumer_Source_Group(__ECAST(KEL.typ.nstr,__PP646421.Dob_Source_));
      SELF := __PP646421;
    END;
    SELF.Date_Of_Birth_Summary_ := __PROJECT(__EE646091,__ND646425__Project(LEFT));
    __EE646136 := __PP646018.Name_Summary_;
    __ST273468_Layout __ND646470__Project(E_S_S_N_Summary(__in,__cfg).Name_Summary_Layout __PP646466) := TRANSFORM
      SELF.Translated_Source_Code_ := FN_Compile(__cfg).FN_Consumer_Source_Group(__ECAST(KEL.typ.nstr,__PP646466.Name_Source_));
      SELF := __PP646466;
    END;
    SELF.Name_Summary_ := __PROJECT(__EE646136,__ND646470__Project(LEFT));
    __EE646181 := __PP646018.Phone_Summary_;
    __ST273476_Layout __ND646515__Project(E_S_S_N_Summary(__in,__cfg).Phone_Summary_Layout __PP646511) := TRANSFORM
      SELF.Phone_Translated_Source_Code_ := FN_Compile(__cfg).FN_Consumer_Source_Group(__ECAST(KEL.typ.nstr,__PP646511.Phone_Source_));
      SELF := __PP646511;
    END;
    SELF.Phone_Summary_ := __PROJECT(__EE646181,__ND646515__Project(LEFT));
    SELF := __PP646018;
  END;
  EXPORT __ENH_S_S_N_Summary_5 := PROJECT(__EE646228,__ND646533__Project(LEFT));
END;
