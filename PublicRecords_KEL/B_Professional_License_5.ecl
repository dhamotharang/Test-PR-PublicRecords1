//HPCC Systems KEL Compiler Version 1.5.0rc1
IMPORT KEL15 AS KEL;
IMPORT CFG_Compile,E_Professional_License FROM PublicRecords_KEL;
IMPORT * FROM KEL15.Null;
EXPORT B_Professional_License_5(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE
  SHARED VIRTUAL TYPEOF(E_Professional_License(__in,__cfg).__Result) __E_Professional_License := E_Professional_License(__in,__cfg).__Result;
  SHARED __EE4938697 := __E_Professional_License;
  EXPORT __ST241908_Layout := RECORD
    KEL.typ.nuid UID;
    KEL.typ.nstr License_Number_;
    KEL.typ.nstr License_State_;
    KEL.typ.nint Lex_I_D_;
    KEL.typ.nkdate Date_Created_;
    KEL.typ.nstr Legacy_Result_Code_;
    KEL.typ.ndataset(E_Professional_License(__in,__cfg).Source_Details_Layout) Source_Details_;
    KEL.typ.ndataset(E_Professional_License(__in,__cfg).License_Dates_Layout) License_Dates_;
    KEL.typ.ndataset(E_Professional_License(__in,__cfg).Status_Layout) Status_;
    KEL.typ.ndataset(E_Professional_License(__in,__cfg).License_Description_Layout) License_Description_;
    KEL.typ.ndataset(E_Professional_License(__in,__cfg).Data_Sources_Layout) Data_Sources_;
    KEL.typ.nkdate Max_Expire_Date_;
    KEL.typ.nkdate Max_Issue_Date_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  SHARED __ST241908_Layout __ND4938626__Project(E_Professional_License(__in,__cfg).Layout __PP507842) := TRANSFORM
    __EE4938621 := __PP507842.License_Dates_;
    SELF.Max_Expire_Date_ := KEL.Aggregates.MaxNN(__EE4938621,__T(__EE4938621).Date_Of_Expiration_);
    __EE4938646 := __PP507842.License_Dates_;
    SELF.Max_Issue_Date_ := KEL.Aggregates.MaxNN(__EE4938646,IF(__T(__OP2(__T(__EE4938646).Original_Date_Of_Issuance_,<,KEL.Routines.CastStringToDate(__CN('19000101')))),__ECAST(KEL.typ.nkdate,KEL.Routines.CastStringToDate(__CN(''))),__ECAST(KEL.typ.nkdate,__T(__EE4938646).Original_Date_Of_Issuance_)));
    SELF := __PP507842;
  END;
  EXPORT __ENH_Professional_License_5 := PROJECT(__EE4938697,__ND4938626__Project(LEFT));
END;
