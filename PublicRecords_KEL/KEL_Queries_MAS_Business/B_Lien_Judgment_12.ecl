//HPCC Systems KEL Compiler Version 1.6.0
IMPORT KEL16 AS KEL;
IMPORT CFG_Compile,E_Lien_Judgment FROM PublicRecords_KEL.KEL_Queries_MAS_Business;
IMPORT * FROM KEL16.Null;
EXPORT B_Lien_Judgment_12(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE
  SHARED VIRTUAL TYPEOF(E_Lien_Judgment(__in,__cfg).__Result) __E_Lien_Judgment := E_Lien_Judgment(__in,__cfg).__Result;
  SHARED __EE254839 := __E_Lien_Judgment;
  EXPORT __ST221611_Layout := RECORD
    KEL.typ.nstr Filing_Number_;
    KEL.typ.nstr Original_Filing_Number_;
    KEL.typ.nstr Filing_Type_Description_;
    KEL.typ.nstr Filing_Status_Description_;
    KEL.typ.nstr Satisfaction_Type_;
    KEL.typ.nint Amount_;
    KEL.typ.nstr Filing_State_;
    KEL.typ.nstr Landlord_Tenant_Dispute_Flag_;
    KEL.typ.nkdate Original_Filing_Date_;
    KEL.typ.nkdate Effective_Date_;
    KEL.typ.nkdate Collection_Date_;
    KEL.typ.nkdate Expiration_Date_;
    KEL.typ.nint Lapse_Date_;
    KEL.typ.nkdate Process_Date_;
    KEL.typ.nstr T_M_S_I_D_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  EXPORT __ST221606_Layout := RECORD
    KEL.typ.nuid UID;
    KEL.typ.nstr T_M_S_I_D_;
    KEL.typ.nstr R_M_S_I_D_;
    KEL.typ.ndataset(__ST221611_Layout) Filing_;
    KEL.typ.ndataset(E_Lien_Judgment(__in,__cfg).Book_Filing_Details_Layout) Book_Filing_Details_;
    KEL.typ.nstr Agency_I_D_;
    KEL.typ.nstr Agency_;
    KEL.typ.nstr Agency_County_;
    KEL.typ.nstr Agency_State_;
    KEL.typ.nbool Sent_To_Credit_Bureau_Flag_;
    KEL.typ.nstr I_R_S_Serial_Number_;
    KEL.typ.nstr Case_Number_;
    KEL.typ.nstr Case_Link_I_D_;
    KEL.typ.nstr Certificate_Number_;
    KEL.typ.ndataset(E_Lien_Judgment(__in,__cfg).Data_Sources_Layout) Data_Sources_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  SHARED __ST221606_Layout __ND255148__Project(E_Lien_Judgment(__in,__cfg).Layout __PP255081) := TRANSFORM
    __EE254687 := __PP255081.Filing_;
    __ST221611_Layout __ND255084__Project(E_Lien_Judgment(__in,__cfg).Filing_Layout __PP255083) := TRANSFORM
      SELF.T_M_S_I_D_ := __PP255081.T_M_S_I_D_;
      SELF := __PP255083;
    END;
    SELF.Filing_ := __PROJECT(__EE254687,__ND255084__Project(LEFT));
    SELF := __PP255081;
  END;
  EXPORT __ENH_Lien_Judgment_12 := PROJECT(__EE254839,__ND255148__Project(LEFT));
END;
