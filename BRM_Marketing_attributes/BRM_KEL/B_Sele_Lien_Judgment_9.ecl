﻿//HPCC Systems KEL Compiler Version 1.6.0
IMPORT KEL16 AS KEL;
IMPORT B_Lien_Judgment_10,CFG_Compile,E_Business_Org,E_Business_Sele,E_Business_Sele_Overflow,E_Business_Ult,E_Lien_Judgment,E_Sele_Lien_Judgment FROM BRM_Marketing_attributes.BRM_KEL;
IMPORT * FROM KEL16.Null;
EXPORT B_Sele_Lien_Judgment_9(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE
  SHARED VIRTUAL TYPEOF(B_Lien_Judgment_10(__in,__cfg).__ENH_Lien_Judgment_10) __ENH_Lien_Judgment_10 := B_Lien_Judgment_10(__in,__cfg).__ENH_Lien_Judgment_10;
  SHARED VIRTUAL TYPEOF(E_Sele_Lien_Judgment(__in,__cfg).__Result) __E_Sele_Lien_Judgment := E_Sele_Lien_Judgment(__in,__cfg).__Result;
  SHARED __EE197228 := __E_Sele_Lien_Judgment;
  SHARED __EE806967 := __ENH_Lien_Judgment_10;
  SHARED __ST197319_Layout := RECORD
    KEL.typ.nuid UID;
    KEL.typ.nstr T_M_S_I_D_;
    KEL.typ.nstr R_M_S_I_D_;
    KEL.typ.ndataset(B_Lien_Judgment_10(__in,__cfg).__ST169886_Layout) Filing_;
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
    KEL.typ.nstr T_M_S_I_D__1_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  __ST197319_Layout __JT806978(B_Lien_Judgment_10(__in,__cfg).__ST169881_Layout __l, B_Lien_Judgment_10(__in,__cfg).__ST169886_Layout __r) := TRANSFORM
    SELF.T_M_S_I_D__1_ := __r.T_M_S_I_D_;
    SELF.Archive___Date_ := __r.Archive___Date_;
    SELF.Date_First_Seen_ := __r.Date_First_Seen_;
    SELF.Date_Last_Seen_ := __r.Date_Last_Seen_;
    SELF.Hybrid_Archive_Date_ := __r.Hybrid_Archive_Date_;
    SELF.Vault_Date_Last_Seen_ := __r.Vault_Date_Last_Seen_;
    SELF.__RecordCount := __r.__RecordCount;
    SELF := __l;
    SELF := __r;
  END;
  SHARED __EE806979 := NORMALIZE(__EE806967,__T(LEFT.Filing_),__JT806978(LEFT,RIGHT));
  SHARED __ST807432_Layout := RECORD
    KEL.typ.nuid UID;
    KEL.typ.nstr Filing_Type_Description_;
    KEL.typ.nint Amount_;
    KEL.typ.nstr Landlord_Tenant_Dispute_Flag_;
    KEL.typ.nstr T_M_S_I_D__1_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  SHARED __EE807439 := PROJECT(TABLE(PROJECT(__EE806979,__ST807432_Layout),{KEL.typ.int __RecordCount := SUM(GROUP,__RecordCount),KEL.typ.epoch Archive___Date_ := KEL.era.SimpleRoll(GROUP,Archive___Date_,MIN,FALSE),KEL.typ.epoch Date_First_Seen_ := KEL.era.SimpleRoll(GROUP,Date_First_Seen_,MIN,FALSE),KEL.typ.epoch Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Date_Last_Seen_,MAX,FALSE),KEL.typ.epoch Hybrid_Archive_Date_ := KEL.era.SimpleRoll(GROUP,Hybrid_Archive_Date_,MIN,FALSE),KEL.typ.epoch Vault_Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Vault_Date_Last_Seen_,MAX,NMAX),UID,Filing_Type_Description_,Amount_,Landlord_Tenant_Dispute_Flag_,T_M_S_I_D__1_},UID,Filing_Type_Description_,Amount_,Landlord_Tenant_Dispute_Flag_,T_M_S_I_D__1_,MERGE),__ST807432_Layout);
  SHARED __ST807459_Layout := RECORD
    KEL.typ.ntyp(E_Business_Sele().Typ) Sele_;
    KEL.typ.ntyp(E_Lien_Judgment().Typ) Lien_;
    KEL.typ.nint Ult_I_D_;
    KEL.typ.nint Org_I_D_;
    KEL.typ.nint Sele_I_D_;
    KEL.typ.nstr T_M_S_I_D_;
    KEL.typ.nstr R_M_S_I_D_;
    KEL.typ.ndataset(E_Sele_Lien_Judgment(__in,__cfg).Details_Layout) Details_;
    KEL.typ.ndataset(E_Sele_Lien_Judgment(__in,__cfg).Data_Sources_Layout) Data_Sources_;
    KEL.typ.ndataset(__ST807432_Layout) Lien_Judgment_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  __JC807456(E_Sele_Lien_Judgment(__in,__cfg).Layout __EE197228, __ST807432_Layout __EE807439) := __EEQP(__EE197228.Lien_,__EE807439.UID);
  __ST807459_Layout __Join__ST807459_Layout(E_Sele_Lien_Judgment(__in,__cfg).Layout __r, DATASET(__ST807432_Layout) __recs) := TRANSFORM
    SELF := __r;
    SELF.Lien_Judgment_ := __CN(__recs);
  END;
  SHARED __EE807457 := DENORMALIZE(DISTRIBUTE(__EE197228,HASH(Lien_)),DISTRIBUTE(__EE807439,HASH(UID)),__JC807456(LEFT,RIGHT),GROUP,__Join__ST807459_Layout(LEFT,ROWS(RIGHT)),LOCAL);
  EXPORT __ST169392_Layout := RECORD
    KEL.typ.nstr Debtor_Plaintiff_;
    KEL.typ.nstr Debtors_Full_Name_;
    KEL.typ.nbool Is_Debtor_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  EXPORT __ST86470_Layout := RECORD
    KEL.typ.nstr T_M_S_I_D_;
    KEL.typ.nstr Filing_Type_Description_;
    KEL.typ.nint Amount_;
    KEL.typ.nstr Landlord_Tenant_Dispute_Flag_;
    KEL.typ.nkdate My_Date_First_Seen_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  EXPORT __ST169383_Layout := RECORD
    KEL.typ.ntyp(E_Business_Sele().Typ) Sele_;
    KEL.typ.ntyp(E_Lien_Judgment().Typ) Lien_;
    KEL.typ.nint Ult_I_D_;
    KEL.typ.nint Org_I_D_;
    KEL.typ.nint Sele_I_D_;
    KEL.typ.nstr T_M_S_I_D_;
    KEL.typ.nstr R_M_S_I_D_;
    KEL.typ.ndataset(__ST169392_Layout) Details_;
    KEL.typ.ndataset(E_Sele_Lien_Judgment(__in,__cfg).Data_Sources_Layout) Data_Sources_;
    KEL.typ.ndataset(__ST86470_Layout) Gather_Liens_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  SHARED __ST169383_Layout __ND807595__Project(__ST807459_Layout __PP807492) := TRANSFORM
    __EE807486 := __PP807492.Details_;
    __ST169392_Layout __ND807590__Project(E_Sele_Lien_Judgment(__in,__cfg).Details_Layout __PP807524) := TRANSFORM
      SELF.Is_Debtor_ := __OP2(__FN1(KEL.Routines.ToUpperCase,__FN1(TRIM,__PP807524.Debtor_Plaintiff_)),=,__CN('D'));
      SELF := __PP807524;
    END;
    SELF.Details_ := __PROJECT(__EE807486,__ND807590__Project(LEFT));
    __EE807490 := __PP807492.Lien_Judgment_;
    __ST86470_Layout __ND807552__Project(__ST807432_Layout __PP807548) := TRANSFORM
      SELF.T_M_S_I_D_ := __PP807548.T_M_S_I_D__1_;
      SELF.My_Date_First_Seen_ := KEL.era.ToDate(__PP807492.Date_First_Seen_);
      SELF := __PP807548;
    END;
    SELF.Gather_Liens_ := __PROJECT(__EE807490,__ND807552__Project(LEFT));
    SELF := __PP807492;
  END;
  EXPORT __ENH_Sele_Lien_Judgment_9 := PROJECT(__EE807457,__ND807595__Project(LEFT));
END;
