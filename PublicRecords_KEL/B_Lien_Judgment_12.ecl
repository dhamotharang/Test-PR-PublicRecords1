﻿//HPCC Systems KEL Compiler Version 1.2.2-dev
IMPORT KEL12 AS KEL;
IMPORT CFG_Compile,E_Lien_Judgment FROM PublicRecords_KEL;
IMPORT * FROM KEL12.Null;
EXPORT B_Lien_Judgment_12(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE
  SHARED VIRTUAL TYPEOF(E_Lien_Judgment().__Result) __E_Lien_Judgment := E_Lien_Judgment(__in,__cfg).__Result;
  SHARED __EE206617 := __E_Lien_Judgment;
  EXPORT __ST170208_Layout := RECORD
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
    KEL.typ.epoch Date_Vendor_First_Reported_ := 0;
    KEL.typ.epoch Date_Vendor_Last_Reported_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  EXPORT __ST170203_Layout := RECORD
    KEL.typ.nuid UID;
    KEL.typ.nstr T_M_S_I_D_;
    KEL.typ.nstr R_M_S_I_D_;
    KEL.typ.ndataset(__ST170208_Layout) Filing_;
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
    KEL.typ.epoch Date_Vendor_First_Reported_ := 0;
    KEL.typ.epoch Date_Vendor_Last_Reported_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  SHARED __ST170203_Layout __ND206840__Project(E_Lien_Judgment(__in,__cfg).Layout __PP206773) := TRANSFORM
    __EE206465 := __PP206773.Filing_;
    __ST170208_Layout __ND206776__Project(E_Lien_Judgment(__in,__cfg).Filing_Layout __PP206775) := TRANSFORM
      SELF.T_M_S_I_D_ := __PP206773.T_M_S_I_D_;
      SELF := __PP206775;
    END;
    SELF.Filing_ := __PROJECT(__EE206465,__ND206776__Project(LEFT));
    SELF := __PP206773;
  END;
  EXPORT __ENH_Lien_Judgment_12 := PROJECT(__EE206617,__ND206840__Project(LEFT));
END;
