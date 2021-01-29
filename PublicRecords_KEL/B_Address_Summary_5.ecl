//HPCC Systems KEL Compiler Version 1.5.0rc1
IMPORT KEL15 AS KEL;
IMPORT CFG_Compile,E_Address_Summary,FN_Compile FROM PublicRecords_KEL;
IMPORT * FROM KEL15.Null;
EXPORT B_Address_Summary_5(CFG_Compile __cfg = CFG_Compile) := MODULE
  SHARED VIRTUAL TYPEOF(E_Address_Summary(__cfg).__Result) __E_Address_Summary := E_Address_Summary(__cfg).__Result;
  SHARED __EE502693 := __E_Address_Summary;
  EXPORT __ST244764_Layout := RECORD
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
  EXPORT __ST244772_Layout := RECORD
    KEL.typ.nkdate Dob_Date_Of_Birth_;
    KEL.typ.nstr Dob_Source_;
    KEL.typ.nint Dob_Record_Count_;
    KEL.typ.nstr D_O_B_Translated_Source_Code_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  EXPORT __ST244758_Layout := RECORD
    KEL.typ.nuid UID;
    KEL.typ.nstr Primary_Name_;
    KEL.typ.nstr Primary_Range_;
    KEL.typ.nstr Zip_;
    KEL.typ.ndataset(__ST244764_Layout) Name_Summary_;
    KEL.typ.ndataset(__ST244772_Layout) Date_Of_Birth_Summary_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  SHARED __ST244758_Layout __ND502842__Project(E_Address_Summary(__cfg).Layout __PP502574) := TRANSFORM
    __EE502601 := __PP502574.Name_Summary_;
    __ST244764_Layout __ND502779__Project(E_Address_Summary(__cfg).Name_Summary_Layout __PP502775) := TRANSFORM
      SELF.Translated_Source_Code_ := FN_Compile(__cfg).FN_Consumer_Source_Group(__ECAST(KEL.typ.nstr,__PP502775.Name_Source_));
      SELF := __PP502775;
    END;
    SELF.Name_Summary_ := __PROJECT(__EE502601,__ND502779__Project(LEFT));
    __EE502646 := __PP502574.Date_Of_Birth_Summary_;
    __ST244772_Layout __ND502824__Project(E_Address_Summary(__cfg).Date_Of_Birth_Summary_Layout __PP502820) := TRANSFORM
      SELF.D_O_B_Translated_Source_Code_ := FN_Compile(__cfg).FN_Consumer_Source_Group(__ECAST(KEL.typ.nstr,__PP502820.Dob_Source_));
      SELF := __PP502820;
    END;
    SELF.Date_Of_Birth_Summary_ := __PROJECT(__EE502646,__ND502824__Project(LEFT));
    SELF := __PP502574;
  END;
  EXPORT __ENH_Address_Summary_5 := PROJECT(__EE502693,__ND502842__Project(LEFT));
END;
