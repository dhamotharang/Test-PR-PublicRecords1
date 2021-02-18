//HPCC Systems KEL Compiler Version 1.5.0rc1
IMPORT KEL15 AS KEL;
IMPORT CFG_Compile,E_S_S_N_Summary,FN_Compile FROM PublicRecords_KEL;
IMPORT * FROM KEL15.Null;
EXPORT B_S_S_N_Summary_5(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE
  SHARED VIRTUAL TYPEOF(E_S_S_N_Summary(__in,__cfg).__Result) __E_S_S_N_Summary := E_S_S_N_Summary(__in,__cfg).__Result;
  SHARED __EE531339 := __E_S_S_N_Summary;
  EXPORT __ST249245_Layout := RECORD
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
  EXPORT __ST249254_Layout := RECORD
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
  EXPORT __ST249261_Layout := RECORD
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
  EXPORT __ST249269_Layout := RECORD
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
  EXPORT __ST249241_Layout := RECORD
    KEL.typ.nuid UID;
    KEL.typ.nstr S_S_N_;
    KEL.typ.ndataset(__ST249245_Layout) Address_Summary_;
    KEL.typ.ndataset(__ST249254_Layout) Date_Of_Birth_Summary_;
    KEL.typ.ndataset(__ST249261_Layout) Name_Summary_;
    KEL.typ.ndataset(__ST249269_Layout) Phone_Summary_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  SHARED __ST249241_Layout __ND531636__Project(E_S_S_N_Summary(__in,__cfg).Layout __PP531134) := TRANSFORM
    __EE531157 := __PP531134.Address_Summary_;
    __ST249245_Layout __ND531483__Project(E_S_S_N_Summary(__in,__cfg).Address_Summary_Layout __PP531479) := TRANSFORM
      SELF.Translated_Source_Code_ := FN_Compile(__cfg).FN_Consumer_Source_Group(__ECAST(KEL.typ.nstr,__PP531479.Address_Source_));
      SELF := __PP531479;
    END;
    SELF.Address_Summary_ := __PROJECT(__EE531157,__ND531483__Project(LEFT));
    __EE531207 := __PP531134.Date_Of_Birth_Summary_;
    __ST249254_Layout __ND531532__Project(E_S_S_N_Summary(__in,__cfg).Date_Of_Birth_Summary_Layout __PP531528) := TRANSFORM
      SELF.Translated_Source_Code_ := FN_Compile(__cfg).FN_Consumer_Source_Group(__ECAST(KEL.typ.nstr,__PP531528.Dob_Source_));
      SELF := __PP531528;
    END;
    SELF.Date_Of_Birth_Summary_ := __PROJECT(__EE531207,__ND531532__Project(LEFT));
    __EE531247 := __PP531134.Name_Summary_;
    __ST249261_Layout __ND531573__Project(E_S_S_N_Summary(__in,__cfg).Name_Summary_Layout __PP531569) := TRANSFORM
      SELF.Translated_Source_Code_ := FN_Compile(__cfg).FN_Consumer_Source_Group(__ECAST(KEL.typ.nstr,__PP531569.Name_Source_));
      SELF := __PP531569;
    END;
    SELF.Name_Summary_ := __PROJECT(__EE531247,__ND531573__Project(LEFT));
    __EE531292 := __PP531134.Phone_Summary_;
    __ST249269_Layout __ND531618__Project(E_S_S_N_Summary(__in,__cfg).Phone_Summary_Layout __PP531614) := TRANSFORM
      SELF.Phone_Translated_Source_Code_ := FN_Compile(__cfg).FN_Consumer_Source_Group(__ECAST(KEL.typ.nstr,__PP531614.Phone_Source_));
      SELF := __PP531614;
    END;
    SELF.Phone_Summary_ := __PROJECT(__EE531292,__ND531618__Project(LEFT));
    SELF := __PP531134;
  END;
  EXPORT __ENH_S_S_N_Summary_5 := PROJECT(__EE531339,__ND531636__Project(LEFT));
END;
