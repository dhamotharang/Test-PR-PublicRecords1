//HPCC Systems KEL Compiler Version 1.5.0rc1
IMPORT KEL15 AS KEL;
IMPORT B_Business_Sele_Overflow_5,CFG_Compile,E_Business_Sele_Overflow,FN_Compile FROM PublicRecords_KEL;
IMPORT * FROM KEL15.Null;
EXPORT B_Business_Sele_Overflow_4(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE
  SHARED VIRTUAL TYPEOF(B_Business_Sele_Overflow_5(__in,__cfg).__ENH_Business_Sele_Overflow_5) __ENH_Business_Sele_Overflow_5 := B_Business_Sele_Overflow_5(__in,__cfg).__ENH_Business_Sele_Overflow_5;
  SHARED __EE5352149 := __ENH_Business_Sele_Overflow_5;
  EXPORT __ST240273_Layout := RECORD
    KEL.typ.nuid UID;
    KEL.typ.nint Ult_I_D_;
    KEL.typ.nint Org_I_D_;
    KEL.typ.nint Sele_I_D_;
    KEL.typ.ndataset(E_Business_Sele_Overflow(__in,__cfg).Vendor_Identification_Layout) Vendor_Identification_;
    KEL.typ.ndataset(E_Business_Sele_Overflow(__in,__cfg).S_O_S_Company_Types_Layout) S_O_S_Company_Types_;
    KEL.typ.ndataset(E_Business_Sele_Overflow(__in,__cfg).S_O_S_Registered_Agents_Layout) S_O_S_Registered_Agents_;
    KEL.typ.ndataset(E_Business_Sele_Overflow(__in,__cfg).S_O_S_Statuses_Layout) S_O_S_Statuses_;
    KEL.typ.ndataset(E_Business_Sele_Overflow(__in,__cfg).S_O_S_Incorporation_Details_Layout) S_O_S_Incorporation_Details_;
    KEL.typ.ndataset(E_Business_Sele_Overflow(__in,__cfg).S_O_S_Charter_Numbers_Layout) S_O_S_Charter_Numbers_;
    KEL.typ.ndataset(E_Business_Sele_Overflow(__in,__cfg).S_O_S_Term_Exist_Codes_Layout) S_O_S_Term_Exist_Codes_;
    KEL.typ.ndataset(E_Business_Sele_Overflow(__in,__cfg).Government_Debarred_Layout) Government_Debarred_;
    KEL.typ.ndataset(E_Business_Sele_Overflow(__in,__cfg).Retirement_Plan_Information_Layout) Retirement_Plan_Information_;
    KEL.typ.ndataset(E_Business_Sele_Overflow(__in,__cfg).Processing_Dates_Layout) Processing_Dates_;
    KEL.typ.ndataset(E_Business_Sele_Overflow(__in,__cfg).Business_Registration_Layout) Business_Registration_;
    KEL.typ.ndataset(E_Business_Sele_Overflow(__in,__cfg).Data_Sources_Layout) Data_Sources_;
    KEL.typ.nkdate S_O_S_Dom_Date_First_Seen_;
    KEL.typ.nkdate S_O_S_Dom_Date_First_Seen_Capped_;
    KEL.typ.nkdate S_O_S_Dom_Date_Last_Seen_;
    KEL.typ.nkdate S_O_S_Dom_Date_Last_Seen_Capped_;
    KEL.typ.ndataset(E_Business_Sele_Overflow(__in,__cfg).S_O_S_Incorporation_Details_Layout) S_O_S_Domestic_Filing_;
    KEL.typ.int S_O_S_Domestic_Filing_Count_ := 0;
    KEL.typ.int S_O_S_Filing_Total_Count_ := 0;
    KEL.typ.ndataset(E_Business_Sele_Overflow(__in,__cfg).S_O_S_Incorporation_Details_Layout) S_O_S_Foreign_Filing_;
    KEL.typ.int S_O_S_Foreign_Filing_Count_ := 0;
    KEL.typ.nkdate S_O_S_Frgn_Date_First_Seen_;
    KEL.typ.nkdate S_O_S_Frgn_Date_First_Seen_Capped_;
    KEL.typ.nkdate S_O_S_Frgn_Date_Last_Seen_;
    KEL.typ.nkdate S_O_S_Frgn_Date_Last_Seen_Capped_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  SHARED __ST240273_Layout __ND5352520__Project(B_Business_Sele_Overflow_5(__in,__cfg).__ST247791_Layout __PP5352150) := TRANSFORM
    __CC13263 := KEL.Routines.MinN(FN_Compile(__cfg).FN_G_E_T_B_U_I_L_D_D_A_T_E(__ECAST(KEL.typ.nstr,__CN('Corp_build_version'))),__CN(__cfg.CurrentDate));
    SELF.S_O_S_Dom_Date_First_Seen_Capped_ := __FN3(KEL.Routines.BoundsFold,__PP5352150.S_O_S_Dom_Date_First_Seen_,KEL.Routines.CastStringToDate(__CN('19000101')),__CC13263);
    SELF.S_O_S_Dom_Date_Last_Seen_Capped_ := __FN3(KEL.Routines.BoundsFold,__PP5352150.S_O_S_Dom_Date_Last_Seen_,KEL.Routines.CastStringToDate(__CN('19000101')),__CC13263);
    SELF.S_O_S_Filing_Total_Count_ := __PP5352150.S_O_S_Domestic_Filing_Count_ + __PP5352150.S_O_S_Foreign_Filing_Count_;
    SELF.S_O_S_Frgn_Date_First_Seen_Capped_ := __FN3(KEL.Routines.BoundsFold,__PP5352150.S_O_S_Frgn_Date_First_Seen_,KEL.Routines.CastStringToDate(__CN('19000101')),__CC13263);
    SELF.S_O_S_Frgn_Date_Last_Seen_Capped_ := __FN3(KEL.Routines.BoundsFold,__PP5352150.S_O_S_Frgn_Date_Last_Seen_,KEL.Routines.CastStringToDate(__CN('19000101')),__CC13263);
    SELF := __PP5352150;
  END;
  EXPORT __ENH_Business_Sele_Overflow_4 := PROJECT(__EE5352149,__ND5352520__Project(LEFT));
END;
