//HPCC Systems KEL Compiler Version 1.6.0
IMPORT KEL16 AS KEL;
IMPORT B_Lien_Judgment_13,CFG_Compile,E_Lien_Judgment,E_Person,E_Person_Lien_Judgment FROM PublicRecords_KEL.KEL_Queries_MAS_NonFCRA;
IMPORT * FROM KEL16.Null;
EXPORT B_Person_Lien_Judgment_12(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE
  SHARED VIRTUAL TYPEOF(B_Lien_Judgment_13(__in,__cfg).__ENH_Lien_Judgment_13) __ENH_Lien_Judgment_13 := B_Lien_Judgment_13(__in,__cfg).__ENH_Lien_Judgment_13;
  SHARED VIRTUAL TYPEOF(E_Person_Lien_Judgment(__in,__cfg).__Result) __E_Person_Lien_Judgment := E_Person_Lien_Judgment(__in,__cfg).__Result;
  SHARED __EE213605 := __E_Person_Lien_Judgment;
  SHARED __EE1595213 := __ENH_Lien_Judgment_13;
  SHARED __ST213690_Layout := RECORD
    KEL.typ.nuid UID;
    KEL.typ.nstr T_M_S_I_D_;
    KEL.typ.nstr R_M_S_I_D_;
    KEL.typ.ndataset(B_Lien_Judgment_13(__in,__cfg).__ST186372_Layout) Filing_;
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
  __ST213690_Layout __JT1595224(B_Lien_Judgment_13(__in,__cfg).__ST186367_Layout __l, B_Lien_Judgment_13(__in,__cfg).__ST186372_Layout __r) := TRANSFORM
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
  SHARED __EE1595225 := NORMALIZE(__EE1595213,__T(LEFT.Filing_),__JT1595224(LEFT,RIGHT));
  SHARED __ST1595654_Layout := RECORD
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
  SHARED __EE1595661 := PROJECT(TABLE(PROJECT(__EE1595225,__ST1595654_Layout),{KEL.typ.int __RecordCount := SUM(GROUP,__RecordCount),KEL.typ.epoch Archive___Date_ := KEL.era.SimpleRoll(GROUP,Archive___Date_,MIN,FALSE),KEL.typ.epoch Date_First_Seen_ := KEL.era.SimpleRoll(GROUP,Date_First_Seen_,MIN,FALSE),KEL.typ.epoch Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Date_Last_Seen_,MAX,FALSE),KEL.typ.epoch Hybrid_Archive_Date_ := KEL.era.SimpleRoll(GROUP,Hybrid_Archive_Date_,MIN,FALSE),KEL.typ.epoch Vault_Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Vault_Date_Last_Seen_,MAX,NMAX),UID,Filing_Type_Description_,Amount_,Landlord_Tenant_Dispute_Flag_,T_M_S_I_D__1_},UID,Filing_Type_Description_,Amount_,Landlord_Tenant_Dispute_Flag_,T_M_S_I_D__1_,MERGE),__ST1595654_Layout);
  SHARED __ST1595681_Layout := RECORD
    KEL.typ.ntyp(E_Person().Typ) Subject_;
    KEL.typ.ntyp(E_Lien_Judgment().Typ) Lien_;
    KEL.typ.nstr T_M_S_I_D_;
    KEL.typ.nstr R_M_S_I_D_;
    KEL.typ.ndataset(E_Person_Lien_Judgment(__in,__cfg).Details_Layout) Details_;
    KEL.typ.ndataset(E_Person_Lien_Judgment(__in,__cfg).Data_Sources_Layout) Data_Sources_;
    KEL.typ.ndataset(__ST1595654_Layout) Lien_Judgment_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  __JC1595678(E_Person_Lien_Judgment(__in,__cfg).Layout __EE213605, __ST1595654_Layout __EE1595661) := __EEQP(__EE213605.Lien_,__EE1595661.UID);
  __ST1595681_Layout __Join__ST1595681_Layout(E_Person_Lien_Judgment(__in,__cfg).Layout __r, DATASET(__ST1595654_Layout) __recs) := TRANSFORM
    SELF := __r;
    SELF.Lien_Judgment_ := __CN(__recs);
  END;
  SHARED __EE1595679 := DENORMALIZE(DISTRIBUTE(__EE213605,HASH(Lien_)),DISTRIBUTE(__EE1595661,HASH(UID)),__JC1595678(LEFT,RIGHT),GROUP,__Join__ST1595681_Layout(LEFT,ROWS(RIGHT)),LOCAL);
  EXPORT __ST186316_Layout := RECORD
    KEL.typ.nstr Debtor_Plaintiff_;
    KEL.typ.nstr Subjects_Full_Name_;
    KEL.typ.nbool Is_Debtor_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  EXPORT __ST93712_Layout := RECORD
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
  EXPORT __ST186310_Layout := RECORD
    KEL.typ.ntyp(E_Person().Typ) Subject_;
    KEL.typ.ntyp(E_Lien_Judgment().Typ) Lien_;
    KEL.typ.nstr T_M_S_I_D_;
    KEL.typ.nstr R_M_S_I_D_;
    KEL.typ.ndataset(__ST186316_Layout) Details_;
    KEL.typ.ndataset(E_Person_Lien_Judgment(__in,__cfg).Data_Sources_Layout) Data_Sources_;
    KEL.typ.ndataset(__ST93712_Layout) Gather_Liens_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  SHARED __ST186310_Layout __ND1595802__Project(__ST1595681_Layout __PP1595711) := TRANSFORM
    __EE1595705 := __PP1595711.Details_;
    __ST186316_Layout __ND1595797__Project(E_Person_Lien_Judgment(__in,__cfg).Details_Layout __PP1595734) := TRANSFORM
      SELF.Is_Debtor_ := __OP2(__FN1(KEL.Routines.ToUpperCase,__FN1(TRIM,__PP1595734.Debtor_Plaintiff_)),=,__CN('D'));
      SELF := __PP1595734;
    END;
    SELF.Details_ := __PROJECT(__EE1595705,__ND1595797__Project(LEFT));
    __EE1595709 := __PP1595711.Lien_Judgment_;
    __ST93712_Layout __ND1595762__Project(__ST1595654_Layout __PP1595758) := TRANSFORM
      SELF.T_M_S_I_D_ := __PP1595758.T_M_S_I_D__1_;
      SELF.My_Date_First_Seen_ := KEL.era.ToDate(__PP1595711.Date_First_Seen_);
      SELF := __PP1595758;
    END;
    SELF.Gather_Liens_ := __PROJECT(__EE1595709,__ND1595762__Project(LEFT));
    SELF := __PP1595711;
  END;
  EXPORT __ENH_Person_Lien_Judgment_12 := PROJECT(__EE1595679,__ND1595802__Project(LEFT));
END;
