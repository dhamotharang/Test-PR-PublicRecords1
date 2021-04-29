//HPCC Systems KEL Compiler Version 1.5.0rc1
IMPORT KEL15 AS KEL;
IMPORT CFG_Compile,E_S_S_N_Summary,FN_Compile FROM PublicRecords_KEL.KEL_Queries_MAS_NonFCRA;
IMPORT * FROM KEL15.Null;
EXPORT B_S_S_N_Summary_5(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE
  SHARED VIRTUAL TYPEOF(E_S_S_N_Summary(__in,__cfg).__Result) __E_S_S_N_Summary := E_S_S_N_Summary(__in,__cfg).__Result;
  SHARED __EE361274 := __E_S_S_N_Summary;
  EXPORT __ST194876_Layout := RECORD
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
  EXPORT __ST194885_Layout := RECORD
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
  EXPORT __ST194893_Layout := RECORD
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
  EXPORT __ST194901_Layout := RECORD
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
  EXPORT __ST194872_Layout := RECORD
    KEL.typ.nuid UID;
    KEL.typ.nstr S_S_N_;
    KEL.typ.ndataset(__ST194876_Layout) Address_Summary_;
    KEL.typ.ndataset(__ST194885_Layout) Date_Of_Birth_Summary_;
    KEL.typ.ndataset(__ST194893_Layout) Name_Summary_;
    KEL.typ.ndataset(__ST194901_Layout) Phone_Summary_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  SHARED __ST194872_Layout __ND361579__Project(E_S_S_N_Summary(__in,__cfg).Layout __PP361064) := TRANSFORM
    __EE361087 := __PP361064.Address_Summary_;
    __ST194876_Layout __ND361422__Project(E_S_S_N_Summary(__in,__cfg).Address_Summary_Layout __PP361418) := TRANSFORM
      SELF.Translated_Source_Code_ := FN_Compile(__cfg).FN_Consumer_Source_Group(__ECAST(KEL.typ.nstr,__PP361418.Address_Source_));
      SELF := __PP361418;
    END;
    SELF.Address_Summary_ := __PROJECT(__EE361087,__ND361422__Project(LEFT));
    __EE361137 := __PP361064.Date_Of_Birth_Summary_;
    __ST194885_Layout __ND361471__Project(E_S_S_N_Summary(__in,__cfg).Date_Of_Birth_Summary_Layout __PP361467) := TRANSFORM
      SELF.Translated_Source_Code_ := FN_Compile(__cfg).FN_Consumer_Source_Group(__ECAST(KEL.typ.nstr,__PP361467.Dob_Source_));
      SELF := __PP361467;
    END;
    SELF.Date_Of_Birth_Summary_ := __PROJECT(__EE361137,__ND361471__Project(LEFT));
    __EE361182 := __PP361064.Name_Summary_;
    __ST194893_Layout __ND361516__Project(E_S_S_N_Summary(__in,__cfg).Name_Summary_Layout __PP361512) := TRANSFORM
      SELF.Translated_Source_Code_ := FN_Compile(__cfg).FN_Consumer_Source_Group(__ECAST(KEL.typ.nstr,__PP361512.Name_Source_));
      SELF := __PP361512;
    END;
    SELF.Name_Summary_ := __PROJECT(__EE361182,__ND361516__Project(LEFT));
    __EE361227 := __PP361064.Phone_Summary_;
    __ST194901_Layout __ND361561__Project(E_S_S_N_Summary(__in,__cfg).Phone_Summary_Layout __PP361557) := TRANSFORM
      SELF.Phone_Translated_Source_Code_ := FN_Compile(__cfg).FN_Consumer_Source_Group(__ECAST(KEL.typ.nstr,__PP361557.Phone_Source_));
      SELF := __PP361557;
    END;
    SELF.Phone_Summary_ := __PROJECT(__EE361227,__ND361561__Project(LEFT));
    SELF := __PP361064;
  END;
  EXPORT __ENH_S_S_N_Summary_5 := PROJECT(__EE361274,__ND361579__Project(LEFT));
END;
