﻿//HPCC Systems KEL Compiler Version 1.5.0rc1
IMPORT KEL15 AS KEL;
IMPORT CFG_Compile,E_Address_Summary,FN_Compile FROM PublicRecords_KEL;
IMPORT * FROM KEL15.Null;
EXPORT B_Address_Summary_5(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE
  SHARED VIRTUAL TYPEOF(E_Address_Summary(__in,__cfg).__Result) __E_Address_Summary := E_Address_Summary(__in,__cfg).__Result;
  SHARED __EE443876 := __E_Address_Summary;
  EXPORT __ST237816_Layout := RECORD
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
  EXPORT __ST237824_Layout := RECORD
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
  EXPORT __ST237810_Layout := RECORD
    KEL.typ.nuid UID;
    KEL.typ.nstr Primary_Name_;
    KEL.typ.nstr Primary_Range_;
    KEL.typ.nstr Zip_;
    KEL.typ.ndataset(__ST237816_Layout) Name_Summary_;
    KEL.typ.ndataset(__ST237824_Layout) Date_Of_Birth_Summary_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  SHARED __ST237810_Layout __ND444025__Project(E_Address_Summary(__in,__cfg).Layout __PP443757) := TRANSFORM
    __EE443784 := __PP443757.Name_Summary_;
    __ST237816_Layout __ND443962__Project(E_Address_Summary(__in,__cfg).Name_Summary_Layout __PP443958) := TRANSFORM
      SELF.Translated_Source_Code_ := FN_Compile(__cfg).FN_Consumer_Source_Group(__ECAST(KEL.typ.nstr,__PP443958.Name_Source_));
      SELF := __PP443958;
    END;
    SELF.Name_Summary_ := __PROJECT(__EE443784,__ND443962__Project(LEFT));
    __EE443829 := __PP443757.Date_Of_Birth_Summary_;
    __ST237824_Layout __ND444007__Project(E_Address_Summary(__in,__cfg).Date_Of_Birth_Summary_Layout __PP444003) := TRANSFORM
      SELF.D_O_B_Translated_Source_Code_ := FN_Compile(__cfg).FN_Consumer_Source_Group(__ECAST(KEL.typ.nstr,__PP444003.Dob_Source_));
      SELF := __PP444003;
    END;
    SELF.Date_Of_Birth_Summary_ := __PROJECT(__EE443829,__ND444007__Project(LEFT));
    SELF := __PP443757;
  END;
  EXPORT __ENH_Address_Summary_5 := PROJECT(__EE443876,__ND444025__Project(LEFT));
END;
