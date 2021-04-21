//HPCC Systems KEL Compiler Version 1.5.0rc1
IMPORT KEL15 AS KEL;
IMPORT B_Sele_Lien_Judgment_11,CFG_Compile,E_Business_Org,E_Business_Sele,E_Business_Sele_Overflow,E_Business_Ult,E_Input_B_I_I,E_Lien_Judgment,E_Sele_Lien_Judgment,FN_Compile FROM PublicRecords_KEL;
IMPORT * FROM KEL15.Null;
EXPORT B_Business_Sele_10(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE
  SHARED VIRTUAL TYPEOF(E_Business_Sele(__in,__cfg).__Result) __E_Business_Sele := E_Business_Sele(__in,__cfg).__Result;
  SHARED VIRTUAL TYPEOF(E_Input_B_I_I(__in,__cfg).__Result) __E_Input_B_I_I := E_Input_B_I_I(__in,__cfg).__Result;
  SHARED VIRTUAL TYPEOF(B_Sele_Lien_Judgment_11(__in,__cfg).__ENH_Sele_Lien_Judgment_11) __ENH_Sele_Lien_Judgment_11 := B_Sele_Lien_Judgment_11(__in,__cfg).__ENH_Sele_Lien_Judgment_11;
  SHARED __EE386583 := __E_Business_Sele;
  SHARED __EE389499 := __E_Input_B_I_I;
  SHARED __EE390135 := __EE389499(__NN(__EE389499.Legal_));
  SHARED __ST389790_Layout := RECORD
    KEL.typ.ntyp(E_Business_Sele().Typ) UID;
    KEL.typ.nuid U_I_D__1_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
  END;
  SHARED __ST389790_Layout __ND390418__Project(E_Input_B_I_I(__in,__cfg).Layout __PP390414) := TRANSFORM
    SELF.UID := __PP390414.Legal_;
    SELF.U_I_D__1_ := __PP390414.UID;
    SELF := __PP390414;
  END;
  SHARED __EE390427 := PROJECT(__EE390135,__ND390418__Project(LEFT));
  SHARED __ST389818_Layout := RECORD
    KEL.typ.ntyp(E_Business_Sele().Typ) UID;
    KEL.typ.ntyp(E_Input_B_I_I().Typ) O_N_L_Y___U_I_D_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
  END;
  SHARED __EE6476245 := PROJECT(__EE390427,TRANSFORM(__ST389818_Layout,SELF.O_N_L_Y___U_I_D_ := LEFT.U_I_D__1_,SELF := LEFT));
  SHARED __ST392067_Layout := RECORD
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
  __JC6477449(E_Business_Sele(__in,__cfg).Layout __EE386583, __ST389818_Layout __EE6476245) := __EEQP(__EE386583.UID,__EE6476245.UID);
  __ST392067_Layout __JT6477449(E_Business_Sele(__in,__cfg).Layout __l, __ST389818_Layout __r) := TRANSFORM
    SELF.U_I_D__1_ := __r.UID;
    SELF := __l;
    SELF := __r;
  END;
  SHARED __EE6477450 := JOIN(__EE386583,__EE6476245,__JC6477449(LEFT,RIGHT),__JT6477449(LEFT,RIGHT),LEFT OUTER,SMART,KEEP(1));
  SHARED __EE6474894 := __ENH_Sele_Lien_Judgment_11;
  SHARED __EE6474901 := __EE6474894(__NN(__EE6474894.Sele_));
  SHARED __EE6474912 := __EE6474901.Details_;
  __JC6474915(B_Sele_Lien_Judgment_11(__in,__cfg).__ST295032_Layout __EE6474912) := __T(__EE6474912.Is_Debtor_);
  SHARED __EE6474916 := __EE6474901(EXISTS(__CHILDJOINFILTER(__EE6474912,__JC6474915)));
  SHARED __ST391058_Layout := RECORD
    KEL.typ.ntyp(E_Business_Sele().Typ) Sele_;
    KEL.typ.ntyp(E_Lien_Judgment().Typ) Lien_;
    KEL.typ.nint Ult_I_D_;
    KEL.typ.nint Org_I_D_;
    KEL.typ.nint Sele_I_D_;
    KEL.typ.nstr T_M_S_I_D_;
    KEL.typ.nstr R_M_S_I_D_;
    KEL.typ.ndataset(B_Sele_Lien_Judgment_11(__in,__cfg).__ST295032_Layout) Details_;
    KEL.typ.ndataset(E_Sele_Lien_Judgment(__in,__cfg).Data_Sources_Layout) Data_Sources_;
    KEL.typ.ndataset(B_Sele_Lien_Judgment_11(__in,__cfg).__ST127737_Layout) Gather_Liens_;
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
  __ST391058_Layout __JT6474950(B_Sele_Lien_Judgment_11(__in,__cfg).__ST295023_Layout __l, B_Sele_Lien_Judgment_11(__in,__cfg).__ST127737_Layout __r) := TRANSFORM
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
  SHARED __EE6474951 := NORMALIZE(__EE6474916,__T(LEFT.Gather_Liens_),__JT6474950(LEFT,RIGHT));
  SHARED __ST386996_Layout := RECORD
    KEL.typ.ntyp(E_Business_Sele().Typ) Sele_;
    KEL.typ.ntyp(E_Lien_Judgment().Typ) Lien_;
    KEL.typ.nint Ult_I_D_;
    KEL.typ.nint Org_I_D_;
    KEL.typ.nint Sele_I_D_;
    KEL.typ.nstr T_M_S_I_D_;
    KEL.typ.nstr R_M_S_I_D_;
    KEL.typ.ndataset(B_Sele_Lien_Judgment_11(__in,__cfg).__ST295032_Layout) Details_;
    KEL.typ.ndataset(E_Sele_Lien_Judgment(__in,__cfg).Data_Sources_Layout) Data_Sources_;
    KEL.typ.ndataset(B_Sele_Lien_Judgment_11(__in,__cfg).__ST127737_Layout) Gather_Liens_;
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
  SHARED __EE6475075 := PROJECT(__EE6474951,TRANSFORM(__ST386996_Layout,SELF.UID := LEFT.Sele_,SELF := LEFT));
  SHARED __EE6477402 := __EE6475075;
  SHARED __EE6477409 := __EE6477402(__T(__FN1(KEL.Routines.IsValidDate,__EE6477402.My_Date_First_Seen_)));
  SHARED __ST388996_Layout := RECORD
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
  SHARED __ST388996_Layout __ND6477414__Project(__ST386996_Layout __PP6477410) := TRANSFORM
    SELF.____grp___U_I_D_ := __PP6477410.UID;
    SELF.____grp___T_M_S_I_D_ := __PP6477410.T_M_S_I_D_;
    SELF := __PP6477410;
  END;
  SHARED __EE6477443 := PROJECT(TABLE(PROJECT(__EE6477409,__ND6477414__Project(LEFT)),{KEL.typ.epoch Archive___Date_ := KEL.era.SimpleRoll(GROUP,Archive___Date_,MIN,FALSE),KEL.typ.epoch Date_First_Seen_ := KEL.era.SimpleRoll(GROUP,Date_First_Seen_,MIN,FALSE),KEL.typ.epoch Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Date_Last_Seen_,MAX,FALSE),KEL.typ.epoch Hybrid_Archive_Date_ := KEL.era.SimpleRoll(GROUP,Hybrid_Archive_Date_,MIN,FALSE),KEL.typ.epoch Vault_Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Vault_Date_Last_Seen_,MAX,NMAX),____grp___U_I_D_,____grp___T_M_S_I_D_,T_M_S_I_D_,Filing_Type_Description_,Amount_,Landlord_Tenant_Dispute_Flag_,My_Date_First_Seen_},____grp___U_I_D_,____grp___T_M_S_I_D_,T_M_S_I_D_,Filing_Type_Description_,Amount_,Landlord_Tenant_Dispute_Flag_,My_Date_First_Seen_,MERGE),__ST388996_Layout);
  SHARED __EE6477400 := GROUP(__EE6477443,____grp___U_I_D_,____grp___T_M_S_I_D_,ALL);
  SHARED __EE6477447 := UNGROUP(TOPN(__EE6477400(__NN(__EE6477400.My_Date_First_Seen_)),1,__T(__EE6477400.My_Date_First_Seen_),__T(____grp___T_M_S_I_D_),__T(Filing_Type_Description_),__T(Amount_),__T(Landlord_Tenant_Dispute_Flag_),__T(____grp___U_I_D_),__T(T_M_S_I_D_)));
  SHARED __ST388831_Layout := RECORD
    KEL.typ.nstr T_M_S_I_D_;
    KEL.typ.ntyp(E_Business_Sele().Typ) UID;
    KEL.typ.nkdate My_Date_First_Seen_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
  END;
  SHARED __ST388831_Layout __ND6475145__Project(__ST388996_Layout __PP6475141) := TRANSFORM
    SELF.T_M_S_I_D_ := __PP6475141.____grp___T_M_S_I_D_;
    SELF.UID := __PP6475141.____grp___U_I_D_;
    SELF := __PP6475141;
  END;
  SHARED __EE6475158 := PROJECT(__EE6477447,__ND6475145__Project(LEFT));
  SHARED __ST388868_Layout := RECORD
    KEL.typ.nstr T_M_S_I_D_;
    KEL.typ.ntyp(E_Business_Sele().Typ) UID;
    KEL.typ.nkdate O_N_L_Y___My_Date_First_Seen_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
  END;
  SHARED __EE6476402 := PROJECT(__EE6475158,TRANSFORM(__ST388868_Layout,SELF.O_N_L_Y___My_Date_First_Seen_ := LEFT.My_Date_First_Seen_,SELF := LEFT));
  SHARED __ST391506_Layout := RECORD
    KEL.typ.ntyp(E_Business_Sele().Typ) Sele_;
    KEL.typ.ntyp(E_Lien_Judgment().Typ) Lien_;
    KEL.typ.nint Ult_I_D_;
    KEL.typ.nint Org_I_D_;
    KEL.typ.nint Sele_I_D_;
    KEL.typ.nstr T_M_S_I_D_;
    KEL.typ.nstr R_M_S_I_D_;
    KEL.typ.ndataset(B_Sele_Lien_Judgment_11(__in,__cfg).__ST295032_Layout) Details_;
    KEL.typ.ndataset(E_Sele_Lien_Judgment(__in,__cfg).Data_Sources_Layout) Data_Sources_;
    KEL.typ.ndataset(B_Sele_Lien_Judgment_11(__in,__cfg).__ST127737_Layout) Gather_Liens_;
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
  __JC6476413(__ST386996_Layout __EE6475075, __ST388868_Layout __EE6476402) := __EEQP(__EE6475075.UID,__EE6476402.UID) AND __EEQP(__EE6475075.T_M_S_I_D_,__EE6476402.T_M_S_I_D_);
  __ST391506_Layout __JT6476413(__ST386996_Layout __l, __ST388868_Layout __r) := TRANSFORM
    SELF.T_M_S_I_D__2_ := __r.T_M_S_I_D_;
    SELF.U_I_D__1_ := __r.UID;
    SELF := __l;
    SELF := __r;
  END;
  SHARED __EE6476414 := JOIN(__EE6475075,__EE6476402,__JC6476413(LEFT,RIGHT),__JT6476413(LEFT,RIGHT),LEFT OUTER,HASH,KEEP(1));
  SHARED __EE6477334 := __EE6475075;
  SHARED __EE6479820 := __EE6477334(__T(__OR(__NOT(__NT(__EE6477334.Amount_)),__OP2(__EE6477334.Amount_,<>,__CN(0)))));
  SHARED __ST388389_Layout := RECORD
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
  SHARED __ST388389_Layout __ND6479825__Project(__ST386996_Layout __PP6479821) := TRANSFORM
    SELF.____grp___U_I_D_ := __PP6479821.UID;
    SELF.____grp___T_M_S_I_D_ := __PP6479821.T_M_S_I_D_;
    SELF := __PP6479821;
  END;
  SHARED __EE6479854 := PROJECT(TABLE(PROJECT(__EE6479820,__ND6479825__Project(LEFT)),{KEL.typ.epoch Archive___Date_ := KEL.era.SimpleRoll(GROUP,Archive___Date_,MIN,FALSE),KEL.typ.epoch Date_First_Seen_ := KEL.era.SimpleRoll(GROUP,Date_First_Seen_,MIN,FALSE),KEL.typ.epoch Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Date_Last_Seen_,MAX,FALSE),KEL.typ.epoch Hybrid_Archive_Date_ := KEL.era.SimpleRoll(GROUP,Hybrid_Archive_Date_,MIN,FALSE),KEL.typ.epoch Vault_Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Vault_Date_Last_Seen_,MAX,NMAX),____grp___U_I_D_,____grp___T_M_S_I_D_,T_M_S_I_D_,Filing_Type_Description_,Amount_,Landlord_Tenant_Dispute_Flag_,My_Date_First_Seen_},____grp___U_I_D_,____grp___T_M_S_I_D_,T_M_S_I_D_,Filing_Type_Description_,Amount_,Landlord_Tenant_Dispute_Flag_,My_Date_First_Seen_,MERGE),__ST388389_Layout);
  SHARED __EE6479865 := GROUP(__EE6479854,____grp___U_I_D_,____grp___T_M_S_I_D_,ALL);
  SHARED __EE6479878 := UNGROUP(TOPN(__EE6479865(__NN(__EE6479865.My_Date_First_Seen_) AND __NN(__EE6479865.Amount_)),1, -__T(__EE6479865.My_Date_First_Seen_), -__T(__EE6479865.Amount_),__T(____grp___T_M_S_I_D_),__T(Filing_Type_Description_),__T(Landlord_Tenant_Dispute_Flag_),__T(____grp___U_I_D_),__T(T_M_S_I_D_)));
  SHARED __ST388226_Layout := RECORD
    KEL.typ.nstr T_M_S_I_D_;
    KEL.typ.ntyp(E_Business_Sele().Typ) UID;
    KEL.typ.nint Amount_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
  END;
  SHARED __ST388226_Layout __ND6479883__Project(__ST388389_Layout __PP6479879) := TRANSFORM
    SELF.T_M_S_I_D_ := __PP6479879.____grp___T_M_S_I_D_;
    SELF.UID := __PP6479879.____grp___U_I_D_;
    SELF := __PP6479879;
  END;
  SHARED __EE6479896 := PROJECT(__EE6479878,__ND6479883__Project(LEFT));
  SHARED __ST388263_Layout := RECORD
    KEL.typ.nstr T_M_S_I_D_;
    KEL.typ.ntyp(E_Business_Sele().Typ) UID;
    KEL.typ.nint O_N_L_Y___Amount_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
  END;
  SHARED __EE6479914 := PROJECT(__EE6479896,TRANSFORM(__ST388263_Layout,SELF.O_N_L_Y___Amount_ := LEFT.Amount_,SELF := LEFT));
  SHARED __ST391603_Layout := RECORD
    KEL.typ.ntyp(E_Business_Sele().Typ) Sele_;
    KEL.typ.ntyp(E_Lien_Judgment().Typ) Lien_;
    KEL.typ.nint Ult_I_D_;
    KEL.typ.nint Org_I_D_;
    KEL.typ.nint Sele_I_D_;
    KEL.typ.nstr T_M_S_I_D_;
    KEL.typ.nstr R_M_S_I_D_;
    KEL.typ.ndataset(B_Sele_Lien_Judgment_11(__in,__cfg).__ST295032_Layout) Details_;
    KEL.typ.ndataset(E_Sele_Lien_Judgment(__in,__cfg).Data_Sources_Layout) Data_Sources_;
    KEL.typ.ndataset(B_Sele_Lien_Judgment_11(__in,__cfg).__ST127737_Layout) Gather_Liens_;
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
  __JC6479924(__ST391506_Layout __EE6476414, __ST388263_Layout __EE6479914) := __EEQP(__EE6476414.T_M_S_I_D_,__EE6479914.T_M_S_I_D_) AND __EEQP(__EE6476414.UID,__EE6479914.UID);
  __ST391603_Layout __JT6479924(__ST391506_Layout __l, __ST388263_Layout __r) := TRANSFORM
    SELF.T_M_S_I_D__3_ := __r.T_M_S_I_D_;
    SELF.U_I_D__2_ := __r.UID;
    SELF := __l;
    SELF := __r;
  END;
  SHARED __EE6479964 := JOIN(__EE6476414,__EE6479914,__JC6479924(LEFT,RIGHT),__JT6479924(LEFT,RIGHT),LEFT OUTER,HASH,KEEP(1));
  SHARED __EE6477271 := __EE6475075;
  SHARED __EE6477279 := __EE6477271(__T(__NOT(__NT(__EE6477271.Filing_Type_Description_))));
  SHARED __ST387773_Layout := RECORD
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
  SHARED __ST387773_Layout __ND6477284__Project(__ST386996_Layout __PP6477280) := TRANSFORM
    SELF.____grp___U_I_D_ := __PP6477280.UID;
    SELF.____grp___T_M_S_I_D_ := __PP6477280.T_M_S_I_D_;
    SELF := __PP6477280;
  END;
  SHARED __EE6477313 := PROJECT(TABLE(PROJECT(__EE6477279,__ND6477284__Project(LEFT)),{KEL.typ.epoch Archive___Date_ := KEL.era.SimpleRoll(GROUP,Archive___Date_,MIN,FALSE),KEL.typ.epoch Date_First_Seen_ := KEL.era.SimpleRoll(GROUP,Date_First_Seen_,MIN,FALSE),KEL.typ.epoch Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Date_Last_Seen_,MAX,FALSE),KEL.typ.epoch Hybrid_Archive_Date_ := KEL.era.SimpleRoll(GROUP,Hybrid_Archive_Date_,MIN,FALSE),KEL.typ.epoch Vault_Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Vault_Date_Last_Seen_,MAX,NMAX),____grp___U_I_D_,____grp___T_M_S_I_D_,T_M_S_I_D_,Filing_Type_Description_,Amount_,Landlord_Tenant_Dispute_Flag_,My_Date_First_Seen_},____grp___U_I_D_,____grp___T_M_S_I_D_,T_M_S_I_D_,Filing_Type_Description_,Amount_,Landlord_Tenant_Dispute_Flag_,My_Date_First_Seen_,MERGE),__ST387773_Layout);
  SHARED __EE6477269 := GROUP(__EE6477313,____grp___U_I_D_,____grp___T_M_S_I_D_,ALL);
  SHARED __EE6477317 := UNGROUP(TOPN(__EE6477269(__NN(__EE6477269.My_Date_First_Seen_)),1, -__T(__EE6477269.My_Date_First_Seen_),__T(____grp___T_M_S_I_D_),__T(Filing_Type_Description_),__T(Amount_),__T(Landlord_Tenant_Dispute_Flag_),__T(____grp___U_I_D_),__T(T_M_S_I_D_)));
  SHARED __ST387605_Layout := RECORD
    KEL.typ.nstr T_M_S_I_D_;
    KEL.typ.ntyp(E_Business_Sele().Typ) UID;
    KEL.typ.nstr Filing_Type_Description_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
  END;
  SHARED __ST387605_Layout __ND6475465__Project(__ST387773_Layout __PP6475461) := TRANSFORM
    SELF.T_M_S_I_D_ := __PP6475461.____grp___T_M_S_I_D_;
    SELF.UID := __PP6475461.____grp___U_I_D_;
    SELF := __PP6475461;
  END;
  SHARED __EE6475478 := PROJECT(__EE6477317,__ND6475465__Project(LEFT));
  SHARED __ST387642_Layout := RECORD
    KEL.typ.nstr T_M_S_I_D_;
    KEL.typ.ntyp(E_Business_Sele().Typ) UID;
    KEL.typ.nstr O_N_L_Y___Filing_Type_Description_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
  END;
  SHARED __EE6476509 := PROJECT(__EE6475478,TRANSFORM(__ST387642_Layout,SELF.O_N_L_Y___Filing_Type_Description_ := LEFT.Filing_Type_Description_,SELF := LEFT));
  SHARED __ST391696_Layout := RECORD
    KEL.typ.ntyp(E_Business_Sele().Typ) Sele_;
    KEL.typ.ntyp(E_Lien_Judgment().Typ) Lien_;
    KEL.typ.nint Ult_I_D_;
    KEL.typ.nint Org_I_D_;
    KEL.typ.nint Sele_I_D_;
    KEL.typ.nstr T_M_S_I_D_;
    KEL.typ.nstr R_M_S_I_D_;
    KEL.typ.ndataset(B_Sele_Lien_Judgment_11(__in,__cfg).__ST295032_Layout) Details_;
    KEL.typ.ndataset(E_Sele_Lien_Judgment(__in,__cfg).Data_Sources_Layout) Data_Sources_;
    KEL.typ.ndataset(B_Sele_Lien_Judgment_11(__in,__cfg).__ST127737_Layout) Gather_Liens_;
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
  __JC6479974(__ST391603_Layout __EE6479964, __ST387642_Layout __EE6476509) := __EEQP(__EE6479964.T_M_S_I_D_,__EE6476509.T_M_S_I_D_) AND __EEQP(__EE6479964.UID,__EE6476509.UID);
  __ST391696_Layout __JT6479974(__ST391603_Layout __l, __ST387642_Layout __r) := TRANSFORM
    SELF.T_M_S_I_D__4_ := __r.T_M_S_I_D_;
    SELF.U_I_D__3_ := __r.UID;
    SELF := __l;
    SELF := __r;
  END;
  SHARED __EE6480017 := JOIN(__EE6479964,__EE6476509,__JC6479974(LEFT,RIGHT),__JT6479974(LEFT,RIGHT),LEFT OUTER,HASH,KEEP(1));
  SHARED __ST391793_Layout := RECORD
    KEL.typ.ntyp(E_Business_Sele().Typ) Sele_;
    KEL.typ.ntyp(E_Lien_Judgment().Typ) Lien_;
    KEL.typ.nint Ult_I_D_;
    KEL.typ.nint Org_I_D_;
    KEL.typ.nint Sele_I_D_;
    KEL.typ.nstr T_M_S_I_D_;
    KEL.typ.nstr R_M_S_I_D_;
    KEL.typ.ndataset(B_Sele_Lien_Judgment_11(__in,__cfg).__ST295032_Layout) Details_;
    KEL.typ.ndataset(E_Sele_Lien_Judgment(__in,__cfg).Data_Sources_Layout) Data_Sources_;
    KEL.typ.ndataset(B_Sele_Lien_Judgment_11(__in,__cfg).__ST127737_Layout) Gather_Liens_;
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
  SHARED __EE6475557 := __EE6475075;
  SHARED __EE6480022 := __EE6475557(__T(__OP2(__EE6475557.Landlord_Tenant_Dispute_Flag_,=,__CN('Y'))));
  __JC6480036(__ST391696_Layout __EE6480017, __ST386996_Layout __EE6480022) := __EEQP(__EE6480017.T_M_S_I_D_,__EE6480022.T_M_S_I_D_) AND __EEQP(__EE6480017.UID,__EE6480022.UID);
  __JF6480036(__ST386996_Layout __EE6480022) := __NN(__EE6480022.T_M_S_I_D_) OR __NN(__EE6480022.UID);
  SHARED __EE6480076 := JOIN(__EE6480017,__EE6480022,__JC6480036(LEFT,RIGHT),TRANSFORM(__ST391793_Layout,SELF:=LEFT,SELF.Exp1_:=__JF6480036(RIGHT)),HASH,LEFT OUTER,KEEP(1));
  SHARED __ST6479167_Layout := RECORD
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
  SHARED __EE6480106 := PROJECT(TABLE(PROJECT(__EE6480076,__ST6479167_Layout),{KEL.typ.int __RecordCount := SUM(GROUP,__RecordCount),KEL.typ.epoch Archive___Date_ := KEL.era.SimpleRoll(GROUP,Archive___Date_,MIN,FALSE),KEL.typ.epoch Date_First_Seen_ := KEL.era.SimpleRoll(GROUP,Date_First_Seen_,MIN,FALSE),KEL.typ.epoch Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Date_Last_Seen_,MAX,FALSE),KEL.typ.epoch Hybrid_Archive_Date_ := KEL.era.SimpleRoll(GROUP,Hybrid_Archive_Date_,MIN,FALSE),KEL.typ.epoch Vault_Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Vault_Date_Last_Seen_,MAX,NMAX),T_M_S_I_D_,UID,O_N_L_Y___My_Date_First_Seen_,O_N_L_Y___Amount_,O_N_L_Y___Filing_Type_Description_,Exp1_},T_M_S_I_D_,UID,O_N_L_Y___My_Date_First_Seen_,O_N_L_Y___Amount_,O_N_L_Y___Filing_Type_Description_,Exp1_,MERGE),__ST6479167_Layout);
  SHARED __ST6479197_Layout := RECORD
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
    KEL.typ.ndataset(__ST6479167_Layout) Exp1_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  __JC6480112(__ST392067_Layout __EE6477450, __ST6479167_Layout __EE6480106) := __EEQP(__EE6477450.UID,__EE6480106.UID);
  __ST6479197_Layout __Join__ST6479197_Layout(__ST392067_Layout __r, DATASET(__ST6479167_Layout) __recs) := TRANSFORM
    SELF := __r;
    SELF.Exp1_ := __CN(__recs);
  END;
  SHARED __EE6480266 := DENORMALIZE(DISTRIBUTE(__EE6477450,HASH(UID)),DISTRIBUTE(__EE6480106,HASH(UID)),__JC6480112(LEFT,RIGHT),GROUP,__Join__ST6479197_Layout(LEFT,ROWS(RIGHT)),LOCAL);
  EXPORT __ST293821_Layout := RECORD
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
  EXPORT __ST293829_Layout := RECORD
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
  EXPORT __ST127816_Layout := RECORD
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
  EXPORT __ST293764_Layout := RECORD
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
    KEL.typ.ndataset(__ST293821_Layout) S_I_C_Codes_;
    KEL.typ.ndataset(__ST293829_Layout) N_A_I_C_S_Codes_;
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
    KEL.typ.ndataset(__ST127816_Layout) All_Lien_Data_;
    KEL.typ.ntyp(E_Input_B_I_I().Typ) B_I_I_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  SHARED __ST293764_Layout __ND6480283__Project(__ST6479197_Layout __PP6480279) := TRANSFORM
    __EE6480269 := __PP6480279.S_I_C_Codes_;
    __ST293821_Layout __ND6480463__Project(E_Business_Sele(__in,__cfg).S_I_C_Codes_Layout __PP6480459) := TRANSFORM
      __CC13403 := KEL.Routines.MinN(FN_Compile(__cfg).FN_G_E_T_B_U_I_L_D_D_A_T_E(__ECAST(KEL.typ.nstr,__CN('Corp_build_version'))),__CN(__cfg.CurrentDate));
      SELF.Days_Since_Code_ := __FN2(KEL.Routines.DaysBetween,KEL.era.ToDate(__PP6480459.Date_First_Seen_),__CC13403);
      SELF := __PP6480459;
    END;
    SELF.S_I_C_Codes_ := __PROJECT(__EE6480269,__ND6480463__Project(LEFT));
    __EE6480273 := __PP6480279.N_A_I_C_S_Codes_;
    __ST293829_Layout __ND6480492__Project(E_Business_Sele(__in,__cfg).N_A_I_C_S_Codes_Layout __PP6480488) := TRANSFORM
      __CC13403 := KEL.Routines.MinN(FN_Compile(__cfg).FN_G_E_T_B_U_I_L_D_D_A_T_E(__ECAST(KEL.typ.nstr,__CN('Corp_build_version'))),__CN(__cfg.CurrentDate));
      SELF.Days_Since_Code_ := __FN2(KEL.Routines.DaysBetween,KEL.era.ToDate(__PP6480488.Date_First_Seen_),__CC13403);
      SELF := __PP6480488;
    END;
    SELF.N_A_I_C_S_Codes_ := __PROJECT(__EE6480273,__ND6480492__Project(LEFT));
    __EE6480277 := __PP6480279.Exp1_;
    __ST127816_Layout __ND6480551__Project(__ST6479167_Layout __PP6480547) := TRANSFORM
      SELF.Filing_Type_Description_ := __PP6480547.O_N_L_Y___Filing_Type_Description_;
      SELF.Amount_ := __PP6480547.O_N_L_Y___Amount_;
      SELF.Landlord_Tenant_Dispute_Flag_ := __PP6480547.Exp1_;
      SELF.Original_Filing_Date_ := __PP6480547.O_N_L_Y___My_Date_First_Seen_;
      SELF := __PP6480547;
    END;
    SELF.All_Lien_Data_ := __PROJECT(__EE6480277,__ND6480551__Project(LEFT));
    SELF.B_I_I_ := __PP6480279.O_N_L_Y___U_I_D_;
    SELF := __PP6480279;
  END;
  EXPORT __ENH_Business_Sele_10 := PROJECT(__EE6480266,__ND6480283__Project(LEFT));
END;
