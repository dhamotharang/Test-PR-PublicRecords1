//HPCC Systems KEL Compiler Version 1.5.0rc1
IMPORT KEL15 AS KEL;
IMPORT CFG_Compile,E_S_S_N_Summary,FN_Compile FROM PublicRecords_KEL;
IMPORT * FROM KEL15.Null;
EXPORT B_S_S_N_Summary_5(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE
  SHARED VIRTUAL TYPEOF(E_S_S_N_Summary(__in,__cfg).__Result) __E_S_S_N_Summary := E_S_S_N_Summary(__in,__cfg).__Result;
  SHARED __EE597755 := __E_S_S_N_Summary;
  EXPORT __ST254730_Layout := RECORD
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
  EXPORT __ST254739_Layout := RECORD
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
  EXPORT __ST254747_Layout := RECORD
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
  EXPORT __ST254755_Layout := RECORD
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
  EXPORT __ST254726_Layout := RECORD
    KEL.typ.nuid UID;
    KEL.typ.nstr S_S_N_;
    KEL.typ.ndataset(__ST254730_Layout) Address_Summary_;
    KEL.typ.ndataset(__ST254739_Layout) Date_Of_Birth_Summary_;
    KEL.typ.ndataset(__ST254747_Layout) Name_Summary_;
    KEL.typ.ndataset(__ST254755_Layout) Phone_Summary_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  SHARED __ST254726_Layout __ND598060__Project(E_S_S_N_Summary(__in,__cfg).Layout __PP597545) := TRANSFORM
    __EE597568 := __PP597545.Address_Summary_;
    __ST254730_Layout __ND597903__Project(E_S_S_N_Summary(__in,__cfg).Address_Summary_Layout __PP597899) := TRANSFORM
      SELF.Translated_Source_Code_ := FN_Compile(__cfg).FN_Consumer_Source_Group(__ECAST(KEL.typ.nstr,__PP597899.Address_Source_));
      SELF := __PP597899;
    END;
    SELF.Address_Summary_ := __PROJECT(__EE597568,__ND597903__Project(LEFT));
    __EE597618 := __PP597545.Date_Of_Birth_Summary_;
    __ST254739_Layout __ND597952__Project(E_S_S_N_Summary(__in,__cfg).Date_Of_Birth_Summary_Layout __PP597948) := TRANSFORM
      SELF.Translated_Source_Code_ := FN_Compile(__cfg).FN_Consumer_Source_Group(__ECAST(KEL.typ.nstr,__PP597948.Dob_Source_));
      SELF := __PP597948;
    END;
    SELF.Date_Of_Birth_Summary_ := __PROJECT(__EE597618,__ND597952__Project(LEFT));
    __EE597663 := __PP597545.Name_Summary_;
    __ST254747_Layout __ND597997__Project(E_S_S_N_Summary(__in,__cfg).Name_Summary_Layout __PP597993) := TRANSFORM
      SELF.Translated_Source_Code_ := FN_Compile(__cfg).FN_Consumer_Source_Group(__ECAST(KEL.typ.nstr,__PP597993.Name_Source_));
      SELF := __PP597993;
    END;
    SELF.Name_Summary_ := __PROJECT(__EE597663,__ND597997__Project(LEFT));
    __EE597708 := __PP597545.Phone_Summary_;
    __ST254755_Layout __ND598042__Project(E_S_S_N_Summary(__in,__cfg).Phone_Summary_Layout __PP598038) := TRANSFORM
      SELF.Phone_Translated_Source_Code_ := FN_Compile(__cfg).FN_Consumer_Source_Group(__ECAST(KEL.typ.nstr,__PP598038.Phone_Source_));
      SELF := __PP598038;
    END;
    SELF.Phone_Summary_ := __PROJECT(__EE597708,__ND598042__Project(LEFT));
    SELF := __PP597545;
  END;
  EXPORT __ENH_S_S_N_Summary_5 := PROJECT(__EE597755,__ND598060__Project(LEFT));
END;
