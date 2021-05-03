//HPCC Systems KEL Compiler Version 1.5.0rc1
IMPORT KEL15 AS KEL;
IMPORT B_Input_P_I_I_13,B_Person_Lien_Judgment_13,CFG_Compile,E_Address,E_Address_Slim,E_Address_Summary,E_Email,E_Geo_Link,E_Input_P_I_I,E_Lien_Judgment,E_Name_Summary,E_Person,E_Person_Lien_Judgment,E_Phone,E_Phone_Summary,E_Property,E_S_S_N_Summary,E_Social_Security_Number,E_Surname,E_Zip_Code FROM PublicRecords_KEL.KEL_Queries_MAS_NonFCRA;
IMPORT * FROM KEL15.Null;
EXPORT B_Person_12(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE
  SHARED VIRTUAL TYPEOF(B_Input_P_I_I_13(__in,__cfg).__ENH_Input_P_I_I_13) __ENH_Input_P_I_I_13 := B_Input_P_I_I_13(__in,__cfg).__ENH_Input_P_I_I_13;
  SHARED VIRTUAL TYPEOF(E_Person(__in,__cfg).__Result) __E_Person := E_Person(__in,__cfg).__Result;
  SHARED VIRTUAL TYPEOF(B_Person_Lien_Judgment_13(__in,__cfg).__ENH_Person_Lien_Judgment_13) __ENH_Person_Lien_Judgment_13 := B_Person_Lien_Judgment_13(__in,__cfg).__ENH_Person_Lien_Judgment_13;
  SHARED __EE281975 := __E_Person;
  SHARED __EE4678039 := __ENH_Input_P_I_I_13;
  SHARED __EE4678046 := __EE4678039(__NN(__EE4678039.Subject_));
  SHARED __ST285108_Layout := RECORD
    KEL.typ.ntyp(E_Person().Typ) UID;
    KEL.typ.nuid U_I_D__1_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
  END;
  SHARED __ST285108_Layout __ND4678051__Project(B_Input_P_I_I_13(__in,__cfg).__ST214888_Layout __PP4678047) := TRANSFORM
    SELF.UID := __PP4678047.Subject_;
    SELF.U_I_D__1_ := __PP4678047.UID;
    SELF := __PP4678047;
  END;
  SHARED __EE4678060 := PROJECT(__EE4678046,__ND4678051__Project(LEFT));
  SHARED __ST285136_Layout := RECORD
    KEL.typ.ntyp(E_Person().Typ) UID;
    KEL.typ.ntyp(E_Input_P_I_I().Typ) O_N_L_Y___U_I_D_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
  END;
  SHARED __EE4679165 := PROJECT(__EE4678060,TRANSFORM(__ST285136_Layout,SELF.O_N_L_Y___U_I_D_ := LEFT.U_I_D__1_,SELF := LEFT));
  SHARED __ST287414_Layout := RECORD
    KEL.typ.nuid UID;
    KEL.typ.nstr Lex_I_D_Segment_;
    KEL.typ.nstr Lex_I_D_Segment2_;
    KEL.typ.ndataset(E_Person(__in,__cfg).Full_Name_Layout) Full_Name_;
    KEL.typ.ndataset(E_Person(__in,__cfg).Reported_Dates_Of_Birth_Layout) Reported_Dates_Of_Birth_;
    KEL.typ.ndataset(E_Person(__in,__cfg).Reported_Dates_Of_Death_Layout) Reported_Dates_Of_Death_;
    KEL.typ.ndataset(E_Person(__in,__cfg).Data_Sources_Layout) Data_Sources_;
    KEL.typ.ndataset(E_Person(__in,__cfg).Conceal_Carry_Layout) Conceal_Carry_;
    KEL.typ.ndataset(E_Person(__in,__cfg).Hunt_Fish_Layout) Hunt_Fish_;
    KEL.typ.ndataset(E_Person(__in,__cfg).Consumer_Statement_Flags_Layout) Consumer_Statement_Flags_;
    KEL.typ.ndataset(E_Person(__in,__cfg).Thrive_Layout) Thrive_;
    KEL.typ.ntyp(E_Person().Typ) U_I_D__1_;
    KEL.typ.ntyp(E_Input_P_I_I().Typ) O_N_L_Y___U_I_D_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  __JC4679960(E_Person(__in,__cfg).Layout __EE281975, __ST285136_Layout __EE4679165) := __EEQP(__EE281975.UID,__EE4679165.UID);
  __ST287414_Layout __JT4679960(E_Person(__in,__cfg).Layout __l, __ST285136_Layout __r) := TRANSFORM
    SELF.U_I_D__1_ := __r.UID;
    SELF := __l;
    SELF := __r;
  END;
  SHARED __EE4679961 := JOIN(__EE281975,__EE4679165,__JC4679960(LEFT,RIGHT),__JT4679960(LEFT,RIGHT),LEFT OUTER,SMART,KEEP(1));
  SHARED __EE4678158 := __ENH_Person_Lien_Judgment_13;
  SHARED __EE4678165 := __EE4678158(__NN(__EE4678158.Subject_));
  SHARED __EE4678176 := __EE4678165.Details_;
  __JC4678179(B_Person_Lien_Judgment_13(__in,__cfg).__ST215131_Layout __EE4678176) := __T(__EE4678176.Is_Debtor_);
  SHARED __EE4678180 := __EE4678165(EXISTS(__CHILDJOINFILTER(__EE4678176,__JC4678179)));
  SHARED __ST286503_Layout := RECORD
    KEL.typ.ntyp(E_Person().Typ) Subject_;
    KEL.typ.ntyp(E_Lien_Judgment().Typ) Lien_;
    KEL.typ.nstr T_M_S_I_D_;
    KEL.typ.nstr R_M_S_I_D_;
    KEL.typ.ndataset(B_Person_Lien_Judgment_13(__in,__cfg).__ST215131_Layout) Details_;
    KEL.typ.ndataset(E_Person_Lien_Judgment(__in,__cfg).Data_Sources_Layout) Data_Sources_;
    KEL.typ.ndataset(B_Person_Lien_Judgment_13(__in,__cfg).__ST89963_Layout) Gather_Liens_;
    KEL.typ.nstr T_M_S_I_D__1_;
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
  __ST286503_Layout __JT4678211(B_Person_Lien_Judgment_13(__in,__cfg).__ST215125_Layout __l, B_Person_Lien_Judgment_13(__in,__cfg).__ST89963_Layout __r) := TRANSFORM
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
  SHARED __EE4678212 := NORMALIZE(__EE4678180,__T(LEFT.Gather_Liens_),__JT4678211(LEFT,RIGHT));
  SHARED __ST282197_Layout := RECORD
    KEL.typ.ntyp(E_Person().Typ) Subject_;
    KEL.typ.ntyp(E_Lien_Judgment().Typ) Lien_;
    KEL.typ.nstr T_M_S_I_D_;
    KEL.typ.nstr R_M_S_I_D_;
    KEL.typ.ndataset(B_Person_Lien_Judgment_13(__in,__cfg).__ST215131_Layout) Details_;
    KEL.typ.ndataset(E_Person_Lien_Judgment(__in,__cfg).Data_Sources_Layout) Data_Sources_;
    KEL.typ.ndataset(B_Person_Lien_Judgment_13(__in,__cfg).__ST89963_Layout) Gather_Liens_;
    KEL.typ.nstr T_M_S_I_D__1_;
    KEL.typ.nstr Filing_Type_Description_;
    KEL.typ.nint Amount_;
    KEL.typ.nstr Landlord_Tenant_Dispute_Flag_;
    KEL.typ.nkdate My_Date_First_Seen_;
    KEL.typ.ntyp(E_Person().Typ) UID;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  SHARED __EE4678321 := PROJECT(__EE4678212,TRANSFORM(__ST282197_Layout,SELF.UID := LEFT.Subject_,SELF := LEFT));
  SHARED __EE4679913 := __EE4678321;
  SHARED __EE4679920 := __EE4679913(__T(__FN1(KEL.Routines.IsValidDate,__EE4679913.My_Date_First_Seen_)));
  SHARED __ST284111_Layout := RECORD
    KEL.typ.ntyp(E_Person().Typ) ____grp___U_I_D_;
    KEL.typ.nstr ____grp___T_M_S_I_D_;
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
  END;
  SHARED __ST284111_Layout __ND4679925__Project(__ST282197_Layout __PP4679921) := TRANSFORM
    SELF.____grp___U_I_D_ := __PP4679921.UID;
    SELF.____grp___T_M_S_I_D_ := __PP4679921.T_M_S_I_D_;
    SELF := __PP4679921;
  END;
  SHARED __EE4679954 := PROJECT(TABLE(PROJECT(__EE4679920,__ND4679925__Project(LEFT)),{KEL.typ.epoch Archive___Date_ := KEL.era.SimpleRoll(GROUP,Archive___Date_,MIN,FALSE),KEL.typ.epoch Date_First_Seen_ := KEL.era.SimpleRoll(GROUP,Date_First_Seen_,MIN,FALSE),KEL.typ.epoch Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Date_Last_Seen_,MAX,FALSE),KEL.typ.epoch Hybrid_Archive_Date_ := KEL.era.SimpleRoll(GROUP,Hybrid_Archive_Date_,MIN,FALSE),KEL.typ.epoch Vault_Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Vault_Date_Last_Seen_,MAX,NMAX),____grp___U_I_D_,____grp___T_M_S_I_D_,T_M_S_I_D_,Filing_Type_Description_,Amount_,Landlord_Tenant_Dispute_Flag_,My_Date_First_Seen_},____grp___U_I_D_,____grp___T_M_S_I_D_,T_M_S_I_D_,Filing_Type_Description_,Amount_,Landlord_Tenant_Dispute_Flag_,My_Date_First_Seen_,MERGE),__ST284111_Layout);
  SHARED __EE4679911 := GROUP(__EE4679954,____grp___U_I_D_,____grp___T_M_S_I_D_,ALL);
  SHARED __EE4679958 := UNGROUP(TOPN(__EE4679911(__NN(__EE4679911.My_Date_First_Seen_)),1,__T(__EE4679911.My_Date_First_Seen_),__T(____grp___T_M_S_I_D_),__T(Filing_Type_Description_),__T(Amount_),__T(Landlord_Tenant_Dispute_Flag_),__T(____grp___U_I_D_),__T(T_M_S_I_D_)));
  SHARED __ST283946_Layout := RECORD
    KEL.typ.nstr T_M_S_I_D_;
    KEL.typ.ntyp(E_Person().Typ) UID;
    KEL.typ.nkdate My_Date_First_Seen_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
  END;
  SHARED __ST283946_Layout __ND4678391__Project(__ST284111_Layout __PP4678387) := TRANSFORM
    SELF.T_M_S_I_D_ := __PP4678387.____grp___T_M_S_I_D_;
    SELF.UID := __PP4678387.____grp___U_I_D_;
    SELF := __PP4678387;
  END;
  SHARED __EE4678404 := PROJECT(__EE4679958,__ND4678391__Project(LEFT));
  SHARED __ST283983_Layout := RECORD
    KEL.typ.nstr T_M_S_I_D_;
    KEL.typ.ntyp(E_Person().Typ) UID;
    KEL.typ.nkdate O_N_L_Y___My_Date_First_Seen_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
  END;
  SHARED __EE4679247 := PROJECT(__EE4678404,TRANSFORM(__ST283983_Layout,SELF.O_N_L_Y___My_Date_First_Seen_ := LEFT.My_Date_First_Seen_,SELF := LEFT));
  SHARED __ST286933_Layout := RECORD
    KEL.typ.ntyp(E_Person().Typ) Subject_;
    KEL.typ.ntyp(E_Lien_Judgment().Typ) Lien_;
    KEL.typ.nstr T_M_S_I_D_;
    KEL.typ.nstr R_M_S_I_D_;
    KEL.typ.ndataset(B_Person_Lien_Judgment_13(__in,__cfg).__ST215131_Layout) Details_;
    KEL.typ.ndataset(E_Person_Lien_Judgment(__in,__cfg).Data_Sources_Layout) Data_Sources_;
    KEL.typ.ndataset(B_Person_Lien_Judgment_13(__in,__cfg).__ST89963_Layout) Gather_Liens_;
    KEL.typ.nstr T_M_S_I_D__1_;
    KEL.typ.nstr Filing_Type_Description_;
    KEL.typ.nint Amount_;
    KEL.typ.nstr Landlord_Tenant_Dispute_Flag_;
    KEL.typ.nkdate My_Date_First_Seen_;
    KEL.typ.ntyp(E_Person().Typ) UID;
    KEL.typ.nstr T_M_S_I_D__2_;
    KEL.typ.ntyp(E_Person().Typ) U_I_D__1_;
    KEL.typ.nkdate O_N_L_Y___My_Date_First_Seen_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  __JC4679258(__ST282197_Layout __EE4678321, __ST283983_Layout __EE4679247) := __EEQP(__EE4678321.UID,__EE4679247.UID) AND __EEQP(__EE4678321.T_M_S_I_D_,__EE4679247.T_M_S_I_D_);
  __ST286933_Layout __JT4679258(__ST282197_Layout __l, __ST283983_Layout __r) := TRANSFORM
    SELF.T_M_S_I_D__2_ := __r.T_M_S_I_D_;
    SELF.U_I_D__1_ := __r.UID;
    SELF := __l;
    SELF := __r;
  END;
  SHARED __EE4679259 := JOIN(__EE4678321,__EE4679247,__JC4679258(LEFT,RIGHT),__JT4679258(LEFT,RIGHT),LEFT OUTER,HASH,KEEP(1));
  SHARED __EE4679845 := __EE4678321;
  SHARED __EE4681545 := __EE4679845(__T(__OR(__NOT(__NT(__EE4679845.Amount_)),__OP2(__EE4679845.Amount_,<>,__CN(0)))));
  SHARED __ST283504_Layout := RECORD
    KEL.typ.ntyp(E_Person().Typ) ____grp___U_I_D_;
    KEL.typ.nstr ____grp___T_M_S_I_D_;
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
  END;
  SHARED __ST283504_Layout __ND4681550__Project(__ST282197_Layout __PP4681546) := TRANSFORM
    SELF.____grp___U_I_D_ := __PP4681546.UID;
    SELF.____grp___T_M_S_I_D_ := __PP4681546.T_M_S_I_D_;
    SELF := __PP4681546;
  END;
  SHARED __EE4681579 := PROJECT(TABLE(PROJECT(__EE4681545,__ND4681550__Project(LEFT)),{KEL.typ.epoch Archive___Date_ := KEL.era.SimpleRoll(GROUP,Archive___Date_,MIN,FALSE),KEL.typ.epoch Date_First_Seen_ := KEL.era.SimpleRoll(GROUP,Date_First_Seen_,MIN,FALSE),KEL.typ.epoch Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Date_Last_Seen_,MAX,FALSE),KEL.typ.epoch Hybrid_Archive_Date_ := KEL.era.SimpleRoll(GROUP,Hybrid_Archive_Date_,MIN,FALSE),KEL.typ.epoch Vault_Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Vault_Date_Last_Seen_,MAX,NMAX),____grp___U_I_D_,____grp___T_M_S_I_D_,T_M_S_I_D_,Filing_Type_Description_,Amount_,Landlord_Tenant_Dispute_Flag_,My_Date_First_Seen_},____grp___U_I_D_,____grp___T_M_S_I_D_,T_M_S_I_D_,Filing_Type_Description_,Amount_,Landlord_Tenant_Dispute_Flag_,My_Date_First_Seen_,MERGE),__ST283504_Layout);
  SHARED __EE4681590 := GROUP(__EE4681579,____grp___U_I_D_,____grp___T_M_S_I_D_,ALL);
  SHARED __EE4681603 := UNGROUP(TOPN(__EE4681590(__NN(__EE4681590.My_Date_First_Seen_) AND __NN(__EE4681590.Amount_)),1, -__T(__EE4681590.My_Date_First_Seen_), -__T(__EE4681590.Amount_),__T(____grp___T_M_S_I_D_),__T(Filing_Type_Description_),__T(Landlord_Tenant_Dispute_Flag_),__T(____grp___U_I_D_),__T(T_M_S_I_D_)));
  SHARED __ST283341_Layout := RECORD
    KEL.typ.nstr T_M_S_I_D_;
    KEL.typ.ntyp(E_Person().Typ) UID;
    KEL.typ.nint Amount_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
  END;
  SHARED __ST283341_Layout __ND4681608__Project(__ST283504_Layout __PP4681604) := TRANSFORM
    SELF.T_M_S_I_D_ := __PP4681604.____grp___T_M_S_I_D_;
    SELF.UID := __PP4681604.____grp___U_I_D_;
    SELF := __PP4681604;
  END;
  SHARED __EE4681621 := PROJECT(__EE4681603,__ND4681608__Project(LEFT));
  SHARED __ST283378_Layout := RECORD
    KEL.typ.nstr T_M_S_I_D_;
    KEL.typ.ntyp(E_Person().Typ) UID;
    KEL.typ.nint O_N_L_Y___Amount_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
  END;
  SHARED __EE4681639 := PROJECT(__EE4681621,TRANSFORM(__ST283378_Layout,SELF.O_N_L_Y___Amount_ := LEFT.Amount_,SELF := LEFT));
  SHARED __ST287027_Layout := RECORD
    KEL.typ.ntyp(E_Person().Typ) Subject_;
    KEL.typ.ntyp(E_Lien_Judgment().Typ) Lien_;
    KEL.typ.nstr T_M_S_I_D_;
    KEL.typ.nstr R_M_S_I_D_;
    KEL.typ.ndataset(B_Person_Lien_Judgment_13(__in,__cfg).__ST215131_Layout) Details_;
    KEL.typ.ndataset(E_Person_Lien_Judgment(__in,__cfg).Data_Sources_Layout) Data_Sources_;
    KEL.typ.ndataset(B_Person_Lien_Judgment_13(__in,__cfg).__ST89963_Layout) Gather_Liens_;
    KEL.typ.nstr T_M_S_I_D__1_;
    KEL.typ.nstr Filing_Type_Description_;
    KEL.typ.nint Amount_;
    KEL.typ.nstr Landlord_Tenant_Dispute_Flag_;
    KEL.typ.nkdate My_Date_First_Seen_;
    KEL.typ.ntyp(E_Person().Typ) UID;
    KEL.typ.nstr T_M_S_I_D__2_;
    KEL.typ.ntyp(E_Person().Typ) U_I_D__1_;
    KEL.typ.nkdate O_N_L_Y___My_Date_First_Seen_;
    KEL.typ.nstr T_M_S_I_D__3_;
    KEL.typ.ntyp(E_Person().Typ) U_I_D__2_;
    KEL.typ.nint O_N_L_Y___Amount_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  __JC4681649(__ST286933_Layout __EE4679259, __ST283378_Layout __EE4681639) := __EEQP(__EE4679259.T_M_S_I_D_,__EE4681639.T_M_S_I_D_) AND __EEQP(__EE4679259.UID,__EE4681639.UID);
  __ST287027_Layout __JT4681649(__ST286933_Layout __l, __ST283378_Layout __r) := TRANSFORM
    SELF.T_M_S_I_D__3_ := __r.T_M_S_I_D_;
    SELF.U_I_D__2_ := __r.UID;
    SELF := __l;
    SELF := __r;
  END;
  SHARED __EE4681686 := JOIN(__EE4679259,__EE4681639,__JC4681649(LEFT,RIGHT),__JT4681649(LEFT,RIGHT),LEFT OUTER,HASH,KEEP(1));
  SHARED __EE4679782 := __EE4678321;
  SHARED __EE4679790 := __EE4679782(__T(__NOT(__NT(__EE4679782.Filing_Type_Description_))));
  SHARED __ST282888_Layout := RECORD
    KEL.typ.nstr ____grp___T_M_S_I_D_;
    KEL.typ.ntyp(E_Person().Typ) ____grp___U_I_D_;
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
  END;
  SHARED __ST282888_Layout __ND4679795__Project(__ST282197_Layout __PP4679791) := TRANSFORM
    SELF.____grp___T_M_S_I_D_ := __PP4679791.T_M_S_I_D_;
    SELF.____grp___U_I_D_ := __PP4679791.UID;
    SELF := __PP4679791;
  END;
  SHARED __EE4679824 := PROJECT(TABLE(PROJECT(__EE4679790,__ND4679795__Project(LEFT)),{KEL.typ.epoch Archive___Date_ := KEL.era.SimpleRoll(GROUP,Archive___Date_,MIN,FALSE),KEL.typ.epoch Date_First_Seen_ := KEL.era.SimpleRoll(GROUP,Date_First_Seen_,MIN,FALSE),KEL.typ.epoch Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Date_Last_Seen_,MAX,FALSE),KEL.typ.epoch Hybrid_Archive_Date_ := KEL.era.SimpleRoll(GROUP,Hybrid_Archive_Date_,MIN,FALSE),KEL.typ.epoch Vault_Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Vault_Date_Last_Seen_,MAX,NMAX),____grp___T_M_S_I_D_,____grp___U_I_D_,T_M_S_I_D_,Filing_Type_Description_,Amount_,Landlord_Tenant_Dispute_Flag_,My_Date_First_Seen_},____grp___T_M_S_I_D_,____grp___U_I_D_,T_M_S_I_D_,Filing_Type_Description_,Amount_,Landlord_Tenant_Dispute_Flag_,My_Date_First_Seen_,MERGE),__ST282888_Layout);
  SHARED __EE4679780 := GROUP(__EE4679824,____grp___T_M_S_I_D_,____grp___U_I_D_,ALL);
  SHARED __EE4679828 := UNGROUP(TOPN(__EE4679780(__NN(__EE4679780.My_Date_First_Seen_)),1, -__T(__EE4679780.My_Date_First_Seen_),__T(____grp___T_M_S_I_D_),__T(Filing_Type_Description_),__T(Amount_),__T(Landlord_Tenant_Dispute_Flag_),__T(____grp___U_I_D_),__T(T_M_S_I_D_)));
  SHARED __ST282720_Layout := RECORD
    KEL.typ.nstr T_M_S_I_D_;
    KEL.typ.ntyp(E_Person().Typ) UID;
    KEL.typ.nstr Filing_Type_Description_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
  END;
  SHARED __ST282720_Layout __ND4678705__Project(__ST282888_Layout __PP4678701) := TRANSFORM
    SELF.T_M_S_I_D_ := __PP4678701.____grp___T_M_S_I_D_;
    SELF.UID := __PP4678701.____grp___U_I_D_;
    SELF := __PP4678701;
  END;
  SHARED __EE4678718 := PROJECT(__EE4679828,__ND4678705__Project(LEFT));
  SHARED __ST282757_Layout := RECORD
    KEL.typ.nstr T_M_S_I_D_;
    KEL.typ.ntyp(E_Person().Typ) UID;
    KEL.typ.nstr O_N_L_Y___Filing_Type_Description_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
  END;
  SHARED __EE4679348 := PROJECT(__EE4678718,TRANSFORM(__ST282757_Layout,SELF.O_N_L_Y___Filing_Type_Description_ := LEFT.Filing_Type_Description_,SELF := LEFT));
  SHARED __ST287117_Layout := RECORD
    KEL.typ.ntyp(E_Person().Typ) Subject_;
    KEL.typ.ntyp(E_Lien_Judgment().Typ) Lien_;
    KEL.typ.nstr T_M_S_I_D_;
    KEL.typ.nstr R_M_S_I_D_;
    KEL.typ.ndataset(B_Person_Lien_Judgment_13(__in,__cfg).__ST215131_Layout) Details_;
    KEL.typ.ndataset(E_Person_Lien_Judgment(__in,__cfg).Data_Sources_Layout) Data_Sources_;
    KEL.typ.ndataset(B_Person_Lien_Judgment_13(__in,__cfg).__ST89963_Layout) Gather_Liens_;
    KEL.typ.nstr T_M_S_I_D__1_;
    KEL.typ.nstr Filing_Type_Description_;
    KEL.typ.nint Amount_;
    KEL.typ.nstr Landlord_Tenant_Dispute_Flag_;
    KEL.typ.nkdate My_Date_First_Seen_;
    KEL.typ.ntyp(E_Person().Typ) UID;
    KEL.typ.nstr T_M_S_I_D__2_;
    KEL.typ.ntyp(E_Person().Typ) U_I_D__1_;
    KEL.typ.nkdate O_N_L_Y___My_Date_First_Seen_;
    KEL.typ.nstr T_M_S_I_D__3_;
    KEL.typ.ntyp(E_Person().Typ) U_I_D__2_;
    KEL.typ.nint O_N_L_Y___Amount_;
    KEL.typ.nstr T_M_S_I_D__4_;
    KEL.typ.ntyp(E_Person().Typ) U_I_D__3_;
    KEL.typ.nstr O_N_L_Y___Filing_Type_Description_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  __JC4681696(__ST287027_Layout __EE4681686, __ST282757_Layout __EE4679348) := __EEQP(__EE4681686.T_M_S_I_D_,__EE4679348.T_M_S_I_D_) AND __EEQP(__EE4681686.UID,__EE4679348.UID);
  __ST287117_Layout __JT4681696(__ST287027_Layout __l, __ST282757_Layout __r) := TRANSFORM
    SELF.T_M_S_I_D__4_ := __r.T_M_S_I_D_;
    SELF.U_I_D__3_ := __r.UID;
    SELF := __l;
    SELF := __r;
  END;
  SHARED __EE4681736 := JOIN(__EE4681686,__EE4679348,__JC4681696(LEFT,RIGHT),__JT4681696(LEFT,RIGHT),LEFT OUTER,HASH,KEEP(1));
  SHARED __ST287211_Layout := RECORD
    KEL.typ.ntyp(E_Person().Typ) Subject_;
    KEL.typ.ntyp(E_Lien_Judgment().Typ) Lien_;
    KEL.typ.nstr T_M_S_I_D_;
    KEL.typ.nstr R_M_S_I_D_;
    KEL.typ.ndataset(B_Person_Lien_Judgment_13(__in,__cfg).__ST215131_Layout) Details_;
    KEL.typ.ndataset(E_Person_Lien_Judgment(__in,__cfg).Data_Sources_Layout) Data_Sources_;
    KEL.typ.ndataset(B_Person_Lien_Judgment_13(__in,__cfg).__ST89963_Layout) Gather_Liens_;
    KEL.typ.nstr T_M_S_I_D__1_;
    KEL.typ.nstr Filing_Type_Description_;
    KEL.typ.nint Amount_;
    KEL.typ.nstr Landlord_Tenant_Dispute_Flag_;
    KEL.typ.nkdate My_Date_First_Seen_;
    KEL.typ.ntyp(E_Person().Typ) UID;
    KEL.typ.nstr T_M_S_I_D__2_;
    KEL.typ.ntyp(E_Person().Typ) U_I_D__1_;
    KEL.typ.nkdate O_N_L_Y___My_Date_First_Seen_;
    KEL.typ.nstr T_M_S_I_D__3_;
    KEL.typ.ntyp(E_Person().Typ) U_I_D__2_;
    KEL.typ.nint O_N_L_Y___Amount_;
    KEL.typ.nstr T_M_S_I_D__4_;
    KEL.typ.ntyp(E_Person().Typ) U_I_D__3_;
    KEL.typ.nstr O_N_L_Y___Filing_Type_Description_;
    KEL.typ.bool Exp1_ := FALSE;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  SHARED __EE4678794 := __EE4678321;
  SHARED __EE4681741 := __EE4678794(__T(__OP2(__EE4678794.Landlord_Tenant_Dispute_Flag_,=,__CN('Y'))));
  __JC4681755(__ST287117_Layout __EE4681736, __ST282197_Layout __EE4681741) := __EEQP(__EE4681736.T_M_S_I_D_,__EE4681741.T_M_S_I_D_) AND __EEQP(__EE4681736.UID,__EE4681741.UID);
  __JF4681755(__ST282197_Layout __EE4681741) := __NN(__EE4681741.T_M_S_I_D_) OR __NN(__EE4681741.UID);
  SHARED __EE4681792 := JOIN(__EE4681736,__EE4681741,__JC4681755(LEFT,RIGHT),TRANSFORM(__ST287211_Layout,SELF:=LEFT,SELF.Exp1_:=__JF4681755(RIGHT)),HASH,LEFT OUTER,KEEP(1));
  SHARED __ST4681225_Layout := RECORD
    KEL.typ.nstr T_M_S_I_D_;
    KEL.typ.ntyp(E_Person().Typ) UID;
    KEL.typ.nkdate O_N_L_Y___My_Date_First_Seen_;
    KEL.typ.nint O_N_L_Y___Amount_;
    KEL.typ.nstr O_N_L_Y___Filing_Type_Description_;
    KEL.typ.bool Exp1_ := FALSE;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  SHARED __EE4681822 := PROJECT(TABLE(PROJECT(__EE4681792,__ST4681225_Layout),{KEL.typ.int __RecordCount := SUM(GROUP,__RecordCount),KEL.typ.epoch Archive___Date_ := KEL.era.SimpleRoll(GROUP,Archive___Date_,MIN,FALSE),KEL.typ.epoch Date_First_Seen_ := KEL.era.SimpleRoll(GROUP,Date_First_Seen_,MIN,FALSE),KEL.typ.epoch Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Date_Last_Seen_,MAX,FALSE),KEL.typ.epoch Hybrid_Archive_Date_ := KEL.era.SimpleRoll(GROUP,Hybrid_Archive_Date_,MIN,FALSE),KEL.typ.epoch Vault_Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Vault_Date_Last_Seen_,MAX,NMAX),T_M_S_I_D_,UID,O_N_L_Y___My_Date_First_Seen_,O_N_L_Y___Amount_,O_N_L_Y___Filing_Type_Description_,Exp1_},T_M_S_I_D_,UID,O_N_L_Y___My_Date_First_Seen_,O_N_L_Y___Amount_,O_N_L_Y___Filing_Type_Description_,Exp1_,MERGE),__ST4681225_Layout);
  SHARED __ST4681255_Layout := RECORD
    KEL.typ.nuid UID;
    KEL.typ.nstr Lex_I_D_Segment_;
    KEL.typ.nstr Lex_I_D_Segment2_;
    KEL.typ.ndataset(E_Person(__in,__cfg).Full_Name_Layout) Full_Name_;
    KEL.typ.ndataset(E_Person(__in,__cfg).Reported_Dates_Of_Birth_Layout) Reported_Dates_Of_Birth_;
    KEL.typ.ndataset(E_Person(__in,__cfg).Reported_Dates_Of_Death_Layout) Reported_Dates_Of_Death_;
    KEL.typ.ndataset(E_Person(__in,__cfg).Data_Sources_Layout) Data_Sources_;
    KEL.typ.ndataset(E_Person(__in,__cfg).Conceal_Carry_Layout) Conceal_Carry_;
    KEL.typ.ndataset(E_Person(__in,__cfg).Hunt_Fish_Layout) Hunt_Fish_;
    KEL.typ.ndataset(E_Person(__in,__cfg).Consumer_Statement_Flags_Layout) Consumer_Statement_Flags_;
    KEL.typ.ndataset(E_Person(__in,__cfg).Thrive_Layout) Thrive_;
    KEL.typ.ntyp(E_Person().Typ) U_I_D__1_;
    KEL.typ.ntyp(E_Input_P_I_I().Typ) O_N_L_Y___U_I_D_;
    KEL.typ.ndataset(__ST4681225_Layout) Exp1_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  __JC4681828(__ST287414_Layout __EE4679961, __ST4681225_Layout __EE4681822) := __EEQP(__EE4679961.UID,__EE4681822.UID);
  __ST4681255_Layout __Join__ST4681255_Layout(__ST287414_Layout __r, DATASET(__ST4681225_Layout) __recs) := TRANSFORM
    SELF := __r;
    SELF.Exp1_ := __CN(__recs);
  END;
  SHARED __EE4681907 := DENORMALIZE(DISTRIBUTE(__EE4679961,HASH(UID)),DISTRIBUTE(__EE4681822,HASH(UID)),__JC4681828(LEFT,RIGHT),GROUP,__Join__ST4681255_Layout(LEFT,ROWS(RIGHT)),LOCAL);
  EXPORT __ST90042_Layout := RECORD
    KEL.typ.nstr T_M_S_I_D_;
    KEL.typ.nstr Filing_Type_Description_;
    KEL.typ.nint Amount_;
    KEL.typ.bool Landlord_Tenant_Dispute_Flag_ := FALSE;
    KEL.typ.nkdate Original_Filing_Date_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  EXPORT __ST214651_Layout := RECORD
    KEL.typ.nuid UID;
    KEL.typ.nstr Lex_I_D_Segment_;
    KEL.typ.nstr Lex_I_D_Segment2_;
    KEL.typ.ndataset(E_Person(__in,__cfg).Full_Name_Layout) Full_Name_;
    KEL.typ.ndataset(E_Person(__in,__cfg).Reported_Dates_Of_Birth_Layout) Reported_Dates_Of_Birth_;
    KEL.typ.ndataset(E_Person(__in,__cfg).Reported_Dates_Of_Death_Layout) Reported_Dates_Of_Death_;
    KEL.typ.ndataset(E_Person(__in,__cfg).Data_Sources_Layout) Data_Sources_;
    KEL.typ.ndataset(E_Person(__in,__cfg).Conceal_Carry_Layout) Conceal_Carry_;
    KEL.typ.ndataset(E_Person(__in,__cfg).Hunt_Fish_Layout) Hunt_Fish_;
    KEL.typ.ndataset(E_Person(__in,__cfg).Consumer_Statement_Flags_Layout) Consumer_Statement_Flags_;
    KEL.typ.ndataset(E_Person(__in,__cfg).Thrive_Layout) Thrive_;
    KEL.typ.ndataset(__ST90042_Layout) All_Lien_Data_;
    KEL.typ.ntyp(E_Input_P_I_I().Typ) P_I_I_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  SHARED __ST214651_Layout __ND4681916__Project(__ST4681255_Layout __PP4681912) := TRANSFORM
    __EE4681910 := __PP4681912.Exp1_;
    __ST90042_Layout __ND4682013__Project(__ST4681225_Layout __PP4682009) := TRANSFORM
      SELF.Filing_Type_Description_ := __PP4682009.O_N_L_Y___Filing_Type_Description_;
      SELF.Amount_ := __PP4682009.O_N_L_Y___Amount_;
      SELF.Landlord_Tenant_Dispute_Flag_ := __PP4682009.Exp1_;
      SELF.Original_Filing_Date_ := __PP4682009.O_N_L_Y___My_Date_First_Seen_;
      SELF := __PP4682009;
    END;
    SELF.All_Lien_Data_ := __PROJECT(__EE4681910,__ND4682013__Project(LEFT));
    SELF.P_I_I_ := __PP4681912.O_N_L_Y___U_I_D_;
    SELF := __PP4681912;
  END;
  EXPORT __ENH_Person_12 := PROJECT(__EE4681907,__ND4681916__Project(LEFT));
END;
