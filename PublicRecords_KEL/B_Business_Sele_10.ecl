//HPCC Systems KEL Compiler Version 1.5.0rc1
IMPORT KEL15 AS KEL;
IMPORT B_Sele_Lien_Judgment_11,CFG_Compile,E_Business_Org,E_Business_Sele,E_Business_Sele_Overflow,E_Business_Ult,E_Input_B_I_I,E_Lien_Judgment,E_Sele_Lien_Judgment,FN_Compile FROM PublicRecords_KEL;
IMPORT * FROM KEL15.Null;
EXPORT B_Business_Sele_10(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE
  SHARED VIRTUAL TYPEOF(E_Business_Sele(__in,__cfg).__Result) __E_Business_Sele := E_Business_Sele(__in,__cfg).__Result;
  SHARED VIRTUAL TYPEOF(E_Input_B_I_I(__in,__cfg).__Result) __E_Input_B_I_I := E_Input_B_I_I(__in,__cfg).__Result;
  SHARED VIRTUAL TYPEOF(B_Sele_Lien_Judgment_11(__in,__cfg).__ENH_Sele_Lien_Judgment_11) __ENH_Sele_Lien_Judgment_11 := B_Sele_Lien_Judgment_11(__in,__cfg).__ENH_Sele_Lien_Judgment_11;
  SHARED __EE313133 := __E_Business_Sele;
  SHARED __EE316049 := __E_Input_B_I_I;
  SHARED __EE316685 := __EE316049(__NN(__EE316049.Legal_));
  SHARED __ST316340_Layout := RECORD
    KEL.typ.ntyp(E_Business_Sele().Typ) UID;
    KEL.typ.nuid U_I_D__1_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
  END;
  SHARED __ST316340_Layout __ND316968__Project(E_Input_B_I_I(__in,__cfg).Layout __PP316964) := TRANSFORM
    SELF.UID := __PP316964.Legal_;
    SELF.U_I_D__1_ := __PP316964.UID;
    SELF := __PP316964;
  END;
  SHARED __EE316977 := PROJECT(__EE316685,__ND316968__Project(LEFT));
  SHARED __ST316368_Layout := RECORD
    KEL.typ.ntyp(E_Business_Sele().Typ) UID;
    KEL.typ.ntyp(E_Input_B_I_I().Typ) O_N_L_Y___U_I_D_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
  END;
  SHARED __EE5047082 := PROJECT(__EE316977,TRANSFORM(__ST316368_Layout,SELF.O_N_L_Y___U_I_D_ := LEFT.U_I_D__1_,SELF := LEFT));
  SHARED __ST318617_Layout := RECORD
    KEL.typ.nuid UID;
    KEL.typ.nint Ult_I_D_;
    KEL.typ.nint Org_I_D_;
    KEL.typ.nint Sele_I_D_;
    KEL.typ.ntyp(E_Business_Org().Typ) Sele_Org_;
    KEL.typ.ntyp(E_Business_Sele_Overflow().Typ) Sele_Overflow_;
    KEL.typ.nbool Sele_Gold_;
    KEL.typ.nbool Is_Sele_Level_;
    KEL.typ.nbool Is_Org_Level_;
    KEL.typ.nbool Is_Ult_Level_;
    KEL.typ.nstr Sele_Segment_;
    KEL.typ.nbool Is_Corporation_;
    KEL.typ.ndataset(E_Business_Sele(__in,__cfg).Business_Structure_Layout) Business_Structure_;
    KEL.typ.ndataset(E_Business_Sele(__in,__cfg).Ownership_Layout) Ownership_;
    KEL.typ.ndataset(E_Business_Sele(__in,__cfg).Industry_Layout) Industry_;
    KEL.typ.ndataset(E_Business_Sele(__in,__cfg).Company_Statuses_Layout) Company_Statuses_;
    KEL.typ.ndataset(E_Business_Sele(__in,__cfg).Age_Layout) Age_;
    KEL.typ.ndataset(E_Business_Sele(__in,__cfg).Reported_Names_Layout) Reported_Names_;
    KEL.typ.ndataset(E_Business_Sele(__in,__cfg).Stock_Tickers_Layout) Stock_Tickers_;
    KEL.typ.ndataset(E_Business_Sele(__in,__cfg).U_R_Ls_Layout) U_R_Ls_;
    KEL.typ.ndataset(E_Business_Sele(__in,__cfg).S_I_C_Codes_Layout) S_I_C_Codes_;
    KEL.typ.ndataset(E_Business_Sele(__in,__cfg).N_A_I_C_S_Codes_Layout) N_A_I_C_S_Codes_;
    KEL.typ.ndataset(E_Business_Sele(__in,__cfg).Employee_Counts_Layout) Employee_Counts_;
    KEL.typ.ndataset(E_Business_Sele(__in,__cfg).Sale_Amounts_Layout) Sale_Amounts_;
    KEL.typ.ndataset(E_Business_Sele(__in,__cfg).Earning_Amounts_Layout) Earning_Amounts_;
    KEL.typ.ndataset(E_Business_Sele(__in,__cfg).Asset_Amounts_Layout) Asset_Amounts_;
    KEL.typ.nkdate B_B_B_Member_Since_;
    KEL.typ.ndataset(E_Business_Sele(__in,__cfg).B_B_B_Categories_Layout) B_B_B_Categories_;
    KEL.typ.nstr For_Profit_Indicator_;
    KEL.typ.nstr Public_Or_Private_Indicator_;
    KEL.typ.ndataset(E_Business_Sele(__in,__cfg).Non_Profit_Layout) Non_Profit_;
    KEL.typ.ndataset(E_Business_Sele(__in,__cfg).Best_Company_Names_Layout) Best_Company_Names_;
    KEL.typ.ndataset(E_Business_Sele(__in,__cfg).Best_S_I_C_Codes_Layout) Best_S_I_C_Codes_;
    KEL.typ.ndataset(E_Business_Sele(__in,__cfg).Best_N_A_I_C_S_Codes_Layout) Best_N_A_I_C_S_Codes_;
    KEL.typ.ndataset(E_Business_Sele(__in,__cfg).Business_Characteristics_Layout) Business_Characteristics_;
    KEL.typ.ndataset(E_Business_Sele(__in,__cfg).Experian_C_R_D_B_Tradelines_Layout) Experian_C_R_D_B_Tradelines_;
    KEL.typ.ndataset(E_Business_Sele(__in,__cfg).Data_Sources_Layout) Data_Sources_;
    KEL.typ.ntyp(E_Business_Sele().Typ) U_I_D__1_;
    KEL.typ.ntyp(E_Input_B_I_I().Typ) O_N_L_Y___U_I_D_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  __JC5048286(E_Business_Sele(__in,__cfg).Layout __EE313133, __ST316368_Layout __EE5047082) := __EEQP(__EE313133.UID,__EE5047082.UID);
  __ST318617_Layout __JT5048286(E_Business_Sele(__in,__cfg).Layout __l, __ST316368_Layout __r) := TRANSFORM
    SELF.U_I_D__1_ := __r.UID;
    SELF := __l;
    SELF := __r;
  END;
  SHARED __EE5048287 := JOIN(__EE313133,__EE5047082,__JC5048286(LEFT,RIGHT),__JT5048286(LEFT,RIGHT),LEFT OUTER,SMART,KEEP(1));
  SHARED __EE5045731 := __ENH_Sele_Lien_Judgment_11;
  SHARED __EE5045738 := __EE5045731(__NN(__EE5045731.Sele_));
  SHARED __EE5045749 := __EE5045738.Details_;
  __JC5045752(B_Sele_Lien_Judgment_11(__in,__cfg).__ST266601_Layout __EE5045749) := __T(__EE5045749.Is_Debtor_);
  SHARED __EE5045753 := __EE5045738(EXISTS(__CHILDJOINFILTER(__EE5045749,__JC5045752)));
  SHARED __ST317608_Layout := RECORD
    KEL.typ.ntyp(E_Business_Sele().Typ) Sele_;
    KEL.typ.ntyp(E_Lien_Judgment().Typ) Lien_;
    KEL.typ.nint Ult_I_D_;
    KEL.typ.nint Org_I_D_;
    KEL.typ.nint Sele_I_D_;
    KEL.typ.nstr T_M_S_I_D_;
    KEL.typ.nstr R_M_S_I_D_;
    KEL.typ.ndataset(B_Sele_Lien_Judgment_11(__in,__cfg).__ST266601_Layout) Details_;
    KEL.typ.ndataset(E_Sele_Lien_Judgment(__in,__cfg).Data_Sources_Layout) Data_Sources_;
    KEL.typ.ndataset(B_Sele_Lien_Judgment_11(__in,__cfg).__ST117108_Layout) Gather_Liens_;
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
  __ST317608_Layout __JT5045787(B_Sele_Lien_Judgment_11(__in,__cfg).__ST266592_Layout __l, B_Sele_Lien_Judgment_11(__in,__cfg).__ST117108_Layout __r) := TRANSFORM
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
  SHARED __EE5045788 := NORMALIZE(__EE5045753,__T(LEFT.Gather_Liens_),__JT5045787(LEFT,RIGHT));
  SHARED __ST313546_Layout := RECORD
    KEL.typ.ntyp(E_Business_Sele().Typ) Sele_;
    KEL.typ.ntyp(E_Lien_Judgment().Typ) Lien_;
    KEL.typ.nint Ult_I_D_;
    KEL.typ.nint Org_I_D_;
    KEL.typ.nint Sele_I_D_;
    KEL.typ.nstr T_M_S_I_D_;
    KEL.typ.nstr R_M_S_I_D_;
    KEL.typ.ndataset(B_Sele_Lien_Judgment_11(__in,__cfg).__ST266601_Layout) Details_;
    KEL.typ.ndataset(E_Sele_Lien_Judgment(__in,__cfg).Data_Sources_Layout) Data_Sources_;
    KEL.typ.ndataset(B_Sele_Lien_Judgment_11(__in,__cfg).__ST117108_Layout) Gather_Liens_;
    KEL.typ.nstr T_M_S_I_D__1_;
    KEL.typ.nstr Filing_Type_Description_;
    KEL.typ.nint Amount_;
    KEL.typ.nstr Landlord_Tenant_Dispute_Flag_;
    KEL.typ.nkdate My_Date_First_Seen_;
    KEL.typ.ntyp(E_Business_Sele().Typ) UID;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  SHARED __EE5045912 := PROJECT(__EE5045788,TRANSFORM(__ST313546_Layout,SELF.UID := LEFT.Sele_,SELF := LEFT));
  SHARED __EE5048239 := __EE5045912;
  SHARED __EE5048246 := __EE5048239(__T(__FN1(KEL.Routines.IsValidDate,__EE5048239.My_Date_First_Seen_)));
  SHARED __ST315546_Layout := RECORD
    KEL.typ.nstr ____grp___T_M_S_I_D_;
    KEL.typ.ntyp(E_Business_Sele().Typ) ____grp___U_I_D_;
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
  SHARED __ST315546_Layout __ND5048251__Project(__ST313546_Layout __PP5048247) := TRANSFORM
    SELF.____grp___T_M_S_I_D_ := __PP5048247.T_M_S_I_D_;
    SELF.____grp___U_I_D_ := __PP5048247.UID;
    SELF := __PP5048247;
  END;
  SHARED __EE5048280 := PROJECT(TABLE(PROJECT(__EE5048246,__ND5048251__Project(LEFT)),{KEL.typ.epoch Archive___Date_ := KEL.era.SimpleRoll(GROUP,Archive___Date_,MIN,FALSE),KEL.typ.epoch Date_First_Seen_ := KEL.era.SimpleRoll(GROUP,Date_First_Seen_,MIN,FALSE),KEL.typ.epoch Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Date_Last_Seen_,MAX,FALSE),KEL.typ.epoch Hybrid_Archive_Date_ := KEL.era.SimpleRoll(GROUP,Hybrid_Archive_Date_,MIN,FALSE),KEL.typ.epoch Vault_Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Vault_Date_Last_Seen_,MAX,NMAX),____grp___T_M_S_I_D_,____grp___U_I_D_,T_M_S_I_D_,Filing_Type_Description_,Amount_,Landlord_Tenant_Dispute_Flag_,My_Date_First_Seen_},____grp___T_M_S_I_D_,____grp___U_I_D_,T_M_S_I_D_,Filing_Type_Description_,Amount_,Landlord_Tenant_Dispute_Flag_,My_Date_First_Seen_,MERGE),__ST315546_Layout);
  SHARED __EE5048237 := GROUP(__EE5048280,____grp___T_M_S_I_D_,____grp___U_I_D_,ALL);
  SHARED __EE5048284 := UNGROUP(TOPN(__EE5048237(__NN(__EE5048237.My_Date_First_Seen_)),1,__T(__EE5048237.My_Date_First_Seen_),__T(____grp___T_M_S_I_D_),__T(Filing_Type_Description_),__T(Amount_),__T(Landlord_Tenant_Dispute_Flag_),__T(____grp___U_I_D_),__T(T_M_S_I_D_)));
  SHARED __ST315381_Layout := RECORD
    KEL.typ.nstr T_M_S_I_D_;
    KEL.typ.ntyp(E_Business_Sele().Typ) UID;
    KEL.typ.nkdate My_Date_First_Seen_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
  END;
  SHARED __ST315381_Layout __ND5045982__Project(__ST315546_Layout __PP5045978) := TRANSFORM
    SELF.T_M_S_I_D_ := __PP5045978.____grp___T_M_S_I_D_;
    SELF.UID := __PP5045978.____grp___U_I_D_;
    SELF := __PP5045978;
  END;
  SHARED __EE5045995 := PROJECT(__EE5048284,__ND5045982__Project(LEFT));
  SHARED __ST315418_Layout := RECORD
    KEL.typ.nstr T_M_S_I_D_;
    KEL.typ.ntyp(E_Business_Sele().Typ) UID;
    KEL.typ.nkdate O_N_L_Y___My_Date_First_Seen_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
  END;
  SHARED __EE5047239 := PROJECT(__EE5045995,TRANSFORM(__ST315418_Layout,SELF.O_N_L_Y___My_Date_First_Seen_ := LEFT.My_Date_First_Seen_,SELF := LEFT));
  SHARED __ST318056_Layout := RECORD
    KEL.typ.ntyp(E_Business_Sele().Typ) Sele_;
    KEL.typ.ntyp(E_Lien_Judgment().Typ) Lien_;
    KEL.typ.nint Ult_I_D_;
    KEL.typ.nint Org_I_D_;
    KEL.typ.nint Sele_I_D_;
    KEL.typ.nstr T_M_S_I_D_;
    KEL.typ.nstr R_M_S_I_D_;
    KEL.typ.ndataset(B_Sele_Lien_Judgment_11(__in,__cfg).__ST266601_Layout) Details_;
    KEL.typ.ndataset(E_Sele_Lien_Judgment(__in,__cfg).Data_Sources_Layout) Data_Sources_;
    KEL.typ.ndataset(B_Sele_Lien_Judgment_11(__in,__cfg).__ST117108_Layout) Gather_Liens_;
    KEL.typ.nstr T_M_S_I_D__1_;
    KEL.typ.nstr Filing_Type_Description_;
    KEL.typ.nint Amount_;
    KEL.typ.nstr Landlord_Tenant_Dispute_Flag_;
    KEL.typ.nkdate My_Date_First_Seen_;
    KEL.typ.ntyp(E_Business_Sele().Typ) UID;
    KEL.typ.nstr T_M_S_I_D__2_;
    KEL.typ.ntyp(E_Business_Sele().Typ) U_I_D__1_;
    KEL.typ.nkdate O_N_L_Y___My_Date_First_Seen_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  __JC5047250(__ST313546_Layout __EE5045912, __ST315418_Layout __EE5047239) := __EEQP(__EE5045912.UID,__EE5047239.UID) AND __EEQP(__EE5045912.T_M_S_I_D_,__EE5047239.T_M_S_I_D_);
  __ST318056_Layout __JT5047250(__ST313546_Layout __l, __ST315418_Layout __r) := TRANSFORM
    SELF.T_M_S_I_D__2_ := __r.T_M_S_I_D_;
    SELF.U_I_D__1_ := __r.UID;
    SELF := __l;
    SELF := __r;
  END;
  SHARED __EE5047251 := JOIN(__EE5045912,__EE5047239,__JC5047250(LEFT,RIGHT),__JT5047250(LEFT,RIGHT),LEFT OUTER,HASH,KEEP(1));
  SHARED __EE5048171 := __EE5045912;
  SHARED __EE5050657 := __EE5048171(__T(__OR(__NOT(__NT(__EE5048171.Amount_)),__OP2(__EE5048171.Amount_,<>,__CN(0)))));
  SHARED __ST314939_Layout := RECORD
    KEL.typ.ntyp(E_Business_Sele().Typ) ____grp___U_I_D_;
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
  SHARED __ST314939_Layout __ND5050662__Project(__ST313546_Layout __PP5050658) := TRANSFORM
    SELF.____grp___U_I_D_ := __PP5050658.UID;
    SELF.____grp___T_M_S_I_D_ := __PP5050658.T_M_S_I_D_;
    SELF := __PP5050658;
  END;
  SHARED __EE5050691 := PROJECT(TABLE(PROJECT(__EE5050657,__ND5050662__Project(LEFT)),{KEL.typ.epoch Archive___Date_ := KEL.era.SimpleRoll(GROUP,Archive___Date_,MIN,FALSE),KEL.typ.epoch Date_First_Seen_ := KEL.era.SimpleRoll(GROUP,Date_First_Seen_,MIN,FALSE),KEL.typ.epoch Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Date_Last_Seen_,MAX,FALSE),KEL.typ.epoch Hybrid_Archive_Date_ := KEL.era.SimpleRoll(GROUP,Hybrid_Archive_Date_,MIN,FALSE),KEL.typ.epoch Vault_Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Vault_Date_Last_Seen_,MAX,NMAX),____grp___U_I_D_,____grp___T_M_S_I_D_,T_M_S_I_D_,Filing_Type_Description_,Amount_,Landlord_Tenant_Dispute_Flag_,My_Date_First_Seen_},____grp___U_I_D_,____grp___T_M_S_I_D_,T_M_S_I_D_,Filing_Type_Description_,Amount_,Landlord_Tenant_Dispute_Flag_,My_Date_First_Seen_,MERGE),__ST314939_Layout);
  SHARED __EE5050702 := GROUP(__EE5050691,____grp___U_I_D_,____grp___T_M_S_I_D_,ALL);
  SHARED __EE5050715 := UNGROUP(TOPN(__EE5050702(__NN(__EE5050702.My_Date_First_Seen_) AND __NN(__EE5050702.Amount_)),1, -__T(__EE5050702.My_Date_First_Seen_), -__T(__EE5050702.Amount_),__T(____grp___T_M_S_I_D_),__T(Filing_Type_Description_),__T(Landlord_Tenant_Dispute_Flag_),__T(____grp___U_I_D_),__T(T_M_S_I_D_)));
  SHARED __ST314776_Layout := RECORD
    KEL.typ.nstr T_M_S_I_D_;
    KEL.typ.ntyp(E_Business_Sele().Typ) UID;
    KEL.typ.nint Amount_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
  END;
  SHARED __ST314776_Layout __ND5050720__Project(__ST314939_Layout __PP5050716) := TRANSFORM
    SELF.T_M_S_I_D_ := __PP5050716.____grp___T_M_S_I_D_;
    SELF.UID := __PP5050716.____grp___U_I_D_;
    SELF := __PP5050716;
  END;
  SHARED __EE5050733 := PROJECT(__EE5050715,__ND5050720__Project(LEFT));
  SHARED __ST314813_Layout := RECORD
    KEL.typ.nstr T_M_S_I_D_;
    KEL.typ.ntyp(E_Business_Sele().Typ) UID;
    KEL.typ.nint O_N_L_Y___Amount_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
  END;
  SHARED __EE5050751 := PROJECT(__EE5050733,TRANSFORM(__ST314813_Layout,SELF.O_N_L_Y___Amount_ := LEFT.Amount_,SELF := LEFT));
  SHARED __ST318153_Layout := RECORD
    KEL.typ.ntyp(E_Business_Sele().Typ) Sele_;
    KEL.typ.ntyp(E_Lien_Judgment().Typ) Lien_;
    KEL.typ.nint Ult_I_D_;
    KEL.typ.nint Org_I_D_;
    KEL.typ.nint Sele_I_D_;
    KEL.typ.nstr T_M_S_I_D_;
    KEL.typ.nstr R_M_S_I_D_;
    KEL.typ.ndataset(B_Sele_Lien_Judgment_11(__in,__cfg).__ST266601_Layout) Details_;
    KEL.typ.ndataset(E_Sele_Lien_Judgment(__in,__cfg).Data_Sources_Layout) Data_Sources_;
    KEL.typ.ndataset(B_Sele_Lien_Judgment_11(__in,__cfg).__ST117108_Layout) Gather_Liens_;
    KEL.typ.nstr T_M_S_I_D__1_;
    KEL.typ.nstr Filing_Type_Description_;
    KEL.typ.nint Amount_;
    KEL.typ.nstr Landlord_Tenant_Dispute_Flag_;
    KEL.typ.nkdate My_Date_First_Seen_;
    KEL.typ.ntyp(E_Business_Sele().Typ) UID;
    KEL.typ.nstr T_M_S_I_D__2_;
    KEL.typ.ntyp(E_Business_Sele().Typ) U_I_D__1_;
    KEL.typ.nkdate O_N_L_Y___My_Date_First_Seen_;
    KEL.typ.nstr T_M_S_I_D__3_;
    KEL.typ.ntyp(E_Business_Sele().Typ) U_I_D__2_;
    KEL.typ.nint O_N_L_Y___Amount_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  __JC5050761(__ST318056_Layout __EE5047251, __ST314813_Layout __EE5050751) := __EEQP(__EE5047251.T_M_S_I_D_,__EE5050751.T_M_S_I_D_) AND __EEQP(__EE5047251.UID,__EE5050751.UID);
  __ST318153_Layout __JT5050761(__ST318056_Layout __l, __ST314813_Layout __r) := TRANSFORM
    SELF.T_M_S_I_D__3_ := __r.T_M_S_I_D_;
    SELF.U_I_D__2_ := __r.UID;
    SELF := __l;
    SELF := __r;
  END;
  SHARED __EE5050801 := JOIN(__EE5047251,__EE5050751,__JC5050761(LEFT,RIGHT),__JT5050761(LEFT,RIGHT),LEFT OUTER,HASH,KEEP(1));
  SHARED __EE5048108 := __EE5045912;
  SHARED __EE5048116 := __EE5048108(__T(__NOT(__NT(__EE5048108.Filing_Type_Description_))));
  SHARED __ST314323_Layout := RECORD
    KEL.typ.nstr ____grp___T_M_S_I_D_;
    KEL.typ.ntyp(E_Business_Sele().Typ) ____grp___U_I_D_;
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
  SHARED __ST314323_Layout __ND5048121__Project(__ST313546_Layout __PP5048117) := TRANSFORM
    SELF.____grp___T_M_S_I_D_ := __PP5048117.T_M_S_I_D_;
    SELF.____grp___U_I_D_ := __PP5048117.UID;
    SELF := __PP5048117;
  END;
  SHARED __EE5048150 := PROJECT(TABLE(PROJECT(__EE5048116,__ND5048121__Project(LEFT)),{KEL.typ.epoch Archive___Date_ := KEL.era.SimpleRoll(GROUP,Archive___Date_,MIN,FALSE),KEL.typ.epoch Date_First_Seen_ := KEL.era.SimpleRoll(GROUP,Date_First_Seen_,MIN,FALSE),KEL.typ.epoch Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Date_Last_Seen_,MAX,FALSE),KEL.typ.epoch Hybrid_Archive_Date_ := KEL.era.SimpleRoll(GROUP,Hybrid_Archive_Date_,MIN,FALSE),KEL.typ.epoch Vault_Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Vault_Date_Last_Seen_,MAX,NMAX),____grp___T_M_S_I_D_,____grp___U_I_D_,T_M_S_I_D_,Filing_Type_Description_,Amount_,Landlord_Tenant_Dispute_Flag_,My_Date_First_Seen_},____grp___T_M_S_I_D_,____grp___U_I_D_,T_M_S_I_D_,Filing_Type_Description_,Amount_,Landlord_Tenant_Dispute_Flag_,My_Date_First_Seen_,MERGE),__ST314323_Layout);
  SHARED __EE5048106 := GROUP(__EE5048150,____grp___T_M_S_I_D_,____grp___U_I_D_,ALL);
  SHARED __EE5048154 := UNGROUP(TOPN(__EE5048106(__NN(__EE5048106.My_Date_First_Seen_)),1, -__T(__EE5048106.My_Date_First_Seen_),__T(____grp___T_M_S_I_D_),__T(Filing_Type_Description_),__T(Amount_),__T(Landlord_Tenant_Dispute_Flag_),__T(____grp___U_I_D_),__T(T_M_S_I_D_)));
  SHARED __ST314155_Layout := RECORD
    KEL.typ.nstr T_M_S_I_D_;
    KEL.typ.ntyp(E_Business_Sele().Typ) UID;
    KEL.typ.nstr Filing_Type_Description_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
  END;
  SHARED __ST314155_Layout __ND5046302__Project(__ST314323_Layout __PP5046298) := TRANSFORM
    SELF.T_M_S_I_D_ := __PP5046298.____grp___T_M_S_I_D_;
    SELF.UID := __PP5046298.____grp___U_I_D_;
    SELF := __PP5046298;
  END;
  SHARED __EE5046315 := PROJECT(__EE5048154,__ND5046302__Project(LEFT));
  SHARED __ST314192_Layout := RECORD
    KEL.typ.nstr T_M_S_I_D_;
    KEL.typ.ntyp(E_Business_Sele().Typ) UID;
    KEL.typ.nstr O_N_L_Y___Filing_Type_Description_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
  END;
  SHARED __EE5047346 := PROJECT(__EE5046315,TRANSFORM(__ST314192_Layout,SELF.O_N_L_Y___Filing_Type_Description_ := LEFT.Filing_Type_Description_,SELF := LEFT));
  SHARED __ST318246_Layout := RECORD
    KEL.typ.ntyp(E_Business_Sele().Typ) Sele_;
    KEL.typ.ntyp(E_Lien_Judgment().Typ) Lien_;
    KEL.typ.nint Ult_I_D_;
    KEL.typ.nint Org_I_D_;
    KEL.typ.nint Sele_I_D_;
    KEL.typ.nstr T_M_S_I_D_;
    KEL.typ.nstr R_M_S_I_D_;
    KEL.typ.ndataset(B_Sele_Lien_Judgment_11(__in,__cfg).__ST266601_Layout) Details_;
    KEL.typ.ndataset(E_Sele_Lien_Judgment(__in,__cfg).Data_Sources_Layout) Data_Sources_;
    KEL.typ.ndataset(B_Sele_Lien_Judgment_11(__in,__cfg).__ST117108_Layout) Gather_Liens_;
    KEL.typ.nstr T_M_S_I_D__1_;
    KEL.typ.nstr Filing_Type_Description_;
    KEL.typ.nint Amount_;
    KEL.typ.nstr Landlord_Tenant_Dispute_Flag_;
    KEL.typ.nkdate My_Date_First_Seen_;
    KEL.typ.ntyp(E_Business_Sele().Typ) UID;
    KEL.typ.nstr T_M_S_I_D__2_;
    KEL.typ.ntyp(E_Business_Sele().Typ) U_I_D__1_;
    KEL.typ.nkdate O_N_L_Y___My_Date_First_Seen_;
    KEL.typ.nstr T_M_S_I_D__3_;
    KEL.typ.ntyp(E_Business_Sele().Typ) U_I_D__2_;
    KEL.typ.nint O_N_L_Y___Amount_;
    KEL.typ.nstr T_M_S_I_D__4_;
    KEL.typ.ntyp(E_Business_Sele().Typ) U_I_D__3_;
    KEL.typ.nstr O_N_L_Y___Filing_Type_Description_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  __JC5050811(__ST318153_Layout __EE5050801, __ST314192_Layout __EE5047346) := __EEQP(__EE5050801.T_M_S_I_D_,__EE5047346.T_M_S_I_D_) AND __EEQP(__EE5050801.UID,__EE5047346.UID);
  __ST318246_Layout __JT5050811(__ST318153_Layout __l, __ST314192_Layout __r) := TRANSFORM
    SELF.T_M_S_I_D__4_ := __r.T_M_S_I_D_;
    SELF.U_I_D__3_ := __r.UID;
    SELF := __l;
    SELF := __r;
  END;
  SHARED __EE5050854 := JOIN(__EE5050801,__EE5047346,__JC5050811(LEFT,RIGHT),__JT5050811(LEFT,RIGHT),LEFT OUTER,HASH,KEEP(1));
  SHARED __ST318343_Layout := RECORD
    KEL.typ.ntyp(E_Business_Sele().Typ) Sele_;
    KEL.typ.ntyp(E_Lien_Judgment().Typ) Lien_;
    KEL.typ.nint Ult_I_D_;
    KEL.typ.nint Org_I_D_;
    KEL.typ.nint Sele_I_D_;
    KEL.typ.nstr T_M_S_I_D_;
    KEL.typ.nstr R_M_S_I_D_;
    KEL.typ.ndataset(B_Sele_Lien_Judgment_11(__in,__cfg).__ST266601_Layout) Details_;
    KEL.typ.ndataset(E_Sele_Lien_Judgment(__in,__cfg).Data_Sources_Layout) Data_Sources_;
    KEL.typ.ndataset(B_Sele_Lien_Judgment_11(__in,__cfg).__ST117108_Layout) Gather_Liens_;
    KEL.typ.nstr T_M_S_I_D__1_;
    KEL.typ.nstr Filing_Type_Description_;
    KEL.typ.nint Amount_;
    KEL.typ.nstr Landlord_Tenant_Dispute_Flag_;
    KEL.typ.nkdate My_Date_First_Seen_;
    KEL.typ.ntyp(E_Business_Sele().Typ) UID;
    KEL.typ.nstr T_M_S_I_D__2_;
    KEL.typ.ntyp(E_Business_Sele().Typ) U_I_D__1_;
    KEL.typ.nkdate O_N_L_Y___My_Date_First_Seen_;
    KEL.typ.nstr T_M_S_I_D__3_;
    KEL.typ.ntyp(E_Business_Sele().Typ) U_I_D__2_;
    KEL.typ.nint O_N_L_Y___Amount_;
    KEL.typ.nstr T_M_S_I_D__4_;
    KEL.typ.ntyp(E_Business_Sele().Typ) U_I_D__3_;
    KEL.typ.nstr O_N_L_Y___Filing_Type_Description_;
    KEL.typ.bool Exp1_ := FALSE;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  SHARED __EE5046394 := __EE5045912;
  SHARED __EE5050859 := __EE5046394(__T(__OP2(__EE5046394.Landlord_Tenant_Dispute_Flag_,=,__CN('Y'))));
  __JC5050873(__ST318246_Layout __EE5050854, __ST313546_Layout __EE5050859) := __EEQP(__EE5050854.T_M_S_I_D_,__EE5050859.T_M_S_I_D_) AND __EEQP(__EE5050854.UID,__EE5050859.UID);
  __JF5050873(__ST313546_Layout __EE5050859) := __NN(__EE5050859.T_M_S_I_D_) OR __NN(__EE5050859.UID);
  SHARED __EE5050913 := JOIN(__EE5050854,__EE5050859,__JC5050873(LEFT,RIGHT),TRANSFORM(__ST318343_Layout,SELF:=LEFT,SELF.Exp1_:=__JF5050873(RIGHT)),HASH,LEFT OUTER,KEEP(1));
  SHARED __ST5050004_Layout := RECORD
    KEL.typ.nstr T_M_S_I_D_;
    KEL.typ.ntyp(E_Business_Sele().Typ) UID;
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
  SHARED __EE5050943 := PROJECT(TABLE(PROJECT(__EE5050913,__ST5050004_Layout),{KEL.typ.int __RecordCount := SUM(GROUP,__RecordCount),KEL.typ.epoch Archive___Date_ := KEL.era.SimpleRoll(GROUP,Archive___Date_,MIN,FALSE),KEL.typ.epoch Date_First_Seen_ := KEL.era.SimpleRoll(GROUP,Date_First_Seen_,MIN,FALSE),KEL.typ.epoch Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Date_Last_Seen_,MAX,FALSE),KEL.typ.epoch Hybrid_Archive_Date_ := KEL.era.SimpleRoll(GROUP,Hybrid_Archive_Date_,MIN,FALSE),KEL.typ.epoch Vault_Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Vault_Date_Last_Seen_,MAX,NMAX),T_M_S_I_D_,UID,O_N_L_Y___My_Date_First_Seen_,O_N_L_Y___Amount_,O_N_L_Y___Filing_Type_Description_,Exp1_},T_M_S_I_D_,UID,O_N_L_Y___My_Date_First_Seen_,O_N_L_Y___Amount_,O_N_L_Y___Filing_Type_Description_,Exp1_,MERGE),__ST5050004_Layout);
  SHARED __ST5050034_Layout := RECORD
    KEL.typ.nuid UID;
    KEL.typ.nint Ult_I_D_;
    KEL.typ.nint Org_I_D_;
    KEL.typ.nint Sele_I_D_;
    KEL.typ.ntyp(E_Business_Org().Typ) Sele_Org_;
    KEL.typ.ntyp(E_Business_Sele_Overflow().Typ) Sele_Overflow_;
    KEL.typ.nbool Sele_Gold_;
    KEL.typ.nbool Is_Sele_Level_;
    KEL.typ.nbool Is_Org_Level_;
    KEL.typ.nbool Is_Ult_Level_;
    KEL.typ.nstr Sele_Segment_;
    KEL.typ.nbool Is_Corporation_;
    KEL.typ.ndataset(E_Business_Sele(__in,__cfg).Business_Structure_Layout) Business_Structure_;
    KEL.typ.ndataset(E_Business_Sele(__in,__cfg).Ownership_Layout) Ownership_;
    KEL.typ.ndataset(E_Business_Sele(__in,__cfg).Industry_Layout) Industry_;
    KEL.typ.ndataset(E_Business_Sele(__in,__cfg).Company_Statuses_Layout) Company_Statuses_;
    KEL.typ.ndataset(E_Business_Sele(__in,__cfg).Age_Layout) Age_;
    KEL.typ.ndataset(E_Business_Sele(__in,__cfg).Reported_Names_Layout) Reported_Names_;
    KEL.typ.ndataset(E_Business_Sele(__in,__cfg).Stock_Tickers_Layout) Stock_Tickers_;
    KEL.typ.ndataset(E_Business_Sele(__in,__cfg).U_R_Ls_Layout) U_R_Ls_;
    KEL.typ.ndataset(E_Business_Sele(__in,__cfg).S_I_C_Codes_Layout) S_I_C_Codes_;
    KEL.typ.ndataset(E_Business_Sele(__in,__cfg).N_A_I_C_S_Codes_Layout) N_A_I_C_S_Codes_;
    KEL.typ.ndataset(E_Business_Sele(__in,__cfg).Employee_Counts_Layout) Employee_Counts_;
    KEL.typ.ndataset(E_Business_Sele(__in,__cfg).Sale_Amounts_Layout) Sale_Amounts_;
    KEL.typ.ndataset(E_Business_Sele(__in,__cfg).Earning_Amounts_Layout) Earning_Amounts_;
    KEL.typ.ndataset(E_Business_Sele(__in,__cfg).Asset_Amounts_Layout) Asset_Amounts_;
    KEL.typ.nkdate B_B_B_Member_Since_;
    KEL.typ.ndataset(E_Business_Sele(__in,__cfg).B_B_B_Categories_Layout) B_B_B_Categories_;
    KEL.typ.nstr For_Profit_Indicator_;
    KEL.typ.nstr Public_Or_Private_Indicator_;
    KEL.typ.ndataset(E_Business_Sele(__in,__cfg).Non_Profit_Layout) Non_Profit_;
    KEL.typ.ndataset(E_Business_Sele(__in,__cfg).Best_Company_Names_Layout) Best_Company_Names_;
    KEL.typ.ndataset(E_Business_Sele(__in,__cfg).Best_S_I_C_Codes_Layout) Best_S_I_C_Codes_;
    KEL.typ.ndataset(E_Business_Sele(__in,__cfg).Best_N_A_I_C_S_Codes_Layout) Best_N_A_I_C_S_Codes_;
    KEL.typ.ndataset(E_Business_Sele(__in,__cfg).Business_Characteristics_Layout) Business_Characteristics_;
    KEL.typ.ndataset(E_Business_Sele(__in,__cfg).Experian_C_R_D_B_Tradelines_Layout) Experian_C_R_D_B_Tradelines_;
    KEL.typ.ndataset(E_Business_Sele(__in,__cfg).Data_Sources_Layout) Data_Sources_;
    KEL.typ.ntyp(E_Business_Sele().Typ) U_I_D__1_;
    KEL.typ.ntyp(E_Input_B_I_I().Typ) O_N_L_Y___U_I_D_;
    KEL.typ.ndataset(__ST5050004_Layout) Exp1_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  __JC5050949(__ST318617_Layout __EE5048287, __ST5050004_Layout __EE5050943) := __EEQP(__EE5048287.UID,__EE5050943.UID);
  __ST5050034_Layout __Join__ST5050034_Layout(__ST318617_Layout __r, DATASET(__ST5050004_Layout) __recs) := TRANSFORM
    SELF := __r;
    SELF.Exp1_ := __CN(__recs);
  END;
  SHARED __EE5051103 := DENORMALIZE(DISTRIBUTE(__EE5048287,HASH(UID)),DISTRIBUTE(__EE5050943,HASH(UID)),__JC5050949(LEFT,RIGHT),GROUP,__Join__ST5050034_Layout(LEFT,ROWS(RIGHT)),LOCAL);
  EXPORT __ST264876_Layout := RECORD
    KEL.typ.nint S_I_C_Code_;
    KEL.typ.nint S_I_C_Code_Order_;
    KEL.typ.nstr Source_;
    KEL.typ.nbool Header_Hit_Flag_;
    KEL.typ.nint Days_Since_Code_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  EXPORT __ST264884_Layout := RECORD
    KEL.typ.nint N_A_I_C_S_Code_;
    KEL.typ.nint N_A_I_C_S_Code_Order_;
    KEL.typ.nstr Source_;
    KEL.typ.nbool Header_Hit_Flag_;
    KEL.typ.nint Days_Since_Code_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  EXPORT __ST117187_Layout := RECORD
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
  EXPORT __ST264819_Layout := RECORD
    KEL.typ.nuid UID;
    KEL.typ.nint Ult_I_D_;
    KEL.typ.nint Org_I_D_;
    KEL.typ.nint Sele_I_D_;
    KEL.typ.ntyp(E_Business_Org().Typ) Sele_Org_;
    KEL.typ.ntyp(E_Business_Sele_Overflow().Typ) Sele_Overflow_;
    KEL.typ.nbool Sele_Gold_;
    KEL.typ.nbool Is_Sele_Level_;
    KEL.typ.nbool Is_Org_Level_;
    KEL.typ.nbool Is_Ult_Level_;
    KEL.typ.nstr Sele_Segment_;
    KEL.typ.nbool Is_Corporation_;
    KEL.typ.ndataset(E_Business_Sele(__in,__cfg).Business_Structure_Layout) Business_Structure_;
    KEL.typ.ndataset(E_Business_Sele(__in,__cfg).Ownership_Layout) Ownership_;
    KEL.typ.ndataset(E_Business_Sele(__in,__cfg).Industry_Layout) Industry_;
    KEL.typ.ndataset(E_Business_Sele(__in,__cfg).Company_Statuses_Layout) Company_Statuses_;
    KEL.typ.ndataset(E_Business_Sele(__in,__cfg).Age_Layout) Age_;
    KEL.typ.ndataset(E_Business_Sele(__in,__cfg).Reported_Names_Layout) Reported_Names_;
    KEL.typ.ndataset(E_Business_Sele(__in,__cfg).Stock_Tickers_Layout) Stock_Tickers_;
    KEL.typ.ndataset(E_Business_Sele(__in,__cfg).U_R_Ls_Layout) U_R_Ls_;
    KEL.typ.ndataset(__ST264876_Layout) S_I_C_Codes_;
    KEL.typ.ndataset(__ST264884_Layout) N_A_I_C_S_Codes_;
    KEL.typ.ndataset(E_Business_Sele(__in,__cfg).Employee_Counts_Layout) Employee_Counts_;
    KEL.typ.ndataset(E_Business_Sele(__in,__cfg).Sale_Amounts_Layout) Sale_Amounts_;
    KEL.typ.ndataset(E_Business_Sele(__in,__cfg).Earning_Amounts_Layout) Earning_Amounts_;
    KEL.typ.ndataset(E_Business_Sele(__in,__cfg).Asset_Amounts_Layout) Asset_Amounts_;
    KEL.typ.nkdate B_B_B_Member_Since_;
    KEL.typ.ndataset(E_Business_Sele(__in,__cfg).B_B_B_Categories_Layout) B_B_B_Categories_;
    KEL.typ.nstr For_Profit_Indicator_;
    KEL.typ.nstr Public_Or_Private_Indicator_;
    KEL.typ.ndataset(E_Business_Sele(__in,__cfg).Non_Profit_Layout) Non_Profit_;
    KEL.typ.ndataset(E_Business_Sele(__in,__cfg).Best_Company_Names_Layout) Best_Company_Names_;
    KEL.typ.ndataset(E_Business_Sele(__in,__cfg).Best_S_I_C_Codes_Layout) Best_S_I_C_Codes_;
    KEL.typ.ndataset(E_Business_Sele(__in,__cfg).Best_N_A_I_C_S_Codes_Layout) Best_N_A_I_C_S_Codes_;
    KEL.typ.ndataset(E_Business_Sele(__in,__cfg).Business_Characteristics_Layout) Business_Characteristics_;
    KEL.typ.ndataset(E_Business_Sele(__in,__cfg).Experian_C_R_D_B_Tradelines_Layout) Experian_C_R_D_B_Tradelines_;
    KEL.typ.ndataset(E_Business_Sele(__in,__cfg).Data_Sources_Layout) Data_Sources_;
    KEL.typ.ndataset(__ST117187_Layout) All_Lien_Data_;
    KEL.typ.ntyp(E_Input_B_I_I().Typ) B_I_I_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  SHARED __ST264819_Layout __ND5051120__Project(__ST5050034_Layout __PP5051116) := TRANSFORM
    __EE5051106 := __PP5051116.S_I_C_Codes_;
    __ST264876_Layout __ND5051300__Project(E_Business_Sele(__in,__cfg).S_I_C_Codes_Layout __PP5051296) := TRANSFORM
      __CC13247 := KEL.Routines.MinN(FN_Compile(__cfg).FN_G_E_T_B_U_I_L_D_D_A_T_E(__ECAST(KEL.typ.nstr,__CN('Corp_build_version'))),__CN(__cfg.CurrentDate));
      SELF.Days_Since_Code_ := __FN2(KEL.Routines.DaysBetween,KEL.era.ToDate(__PP5051296.Date_First_Seen_),__CC13247);
      SELF := __PP5051296;
    END;
    SELF.S_I_C_Codes_ := __PROJECT(__EE5051106,__ND5051300__Project(LEFT));
    __EE5051110 := __PP5051116.N_A_I_C_S_Codes_;
    __ST264884_Layout __ND5051329__Project(E_Business_Sele(__in,__cfg).N_A_I_C_S_Codes_Layout __PP5051325) := TRANSFORM
      __CC13247 := KEL.Routines.MinN(FN_Compile(__cfg).FN_G_E_T_B_U_I_L_D_D_A_T_E(__ECAST(KEL.typ.nstr,__CN('Corp_build_version'))),__CN(__cfg.CurrentDate));
      SELF.Days_Since_Code_ := __FN2(KEL.Routines.DaysBetween,KEL.era.ToDate(__PP5051325.Date_First_Seen_),__CC13247);
      SELF := __PP5051325;
    END;
    SELF.N_A_I_C_S_Codes_ := __PROJECT(__EE5051110,__ND5051329__Project(LEFT));
    __EE5051114 := __PP5051116.Exp1_;
    __ST117187_Layout __ND5051388__Project(__ST5050004_Layout __PP5051384) := TRANSFORM
      SELF.Filing_Type_Description_ := __PP5051384.O_N_L_Y___Filing_Type_Description_;
      SELF.Amount_ := __PP5051384.O_N_L_Y___Amount_;
      SELF.Landlord_Tenant_Dispute_Flag_ := __PP5051384.Exp1_;
      SELF.Original_Filing_Date_ := __PP5051384.O_N_L_Y___My_Date_First_Seen_;
      SELF := __PP5051384;
    END;
    SELF.All_Lien_Data_ := __PROJECT(__EE5051114,__ND5051388__Project(LEFT));
    SELF.B_I_I_ := __PP5051116.O_N_L_Y___U_I_D_;
    SELF := __PP5051116;
  END;
  EXPORT __ENH_Business_Sele_10 := PROJECT(__EE5051103,__ND5051120__Project(LEFT));
END;
