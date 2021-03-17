﻿//HPCC Systems KEL Compiler Version 1.5.0rc1
IMPORT KEL15 AS KEL;
IMPORT B_Sele_Lien_Judgment_11,CFG_Compile,E_Business_Org,E_Business_Sele,E_Business_Sele_Overflow,E_Business_Ult,E_Input_B_I_I,E_Lien_Judgment,E_Sele_Lien_Judgment,FN_Compile FROM PublicRecords_KEL;
IMPORT * FROM KEL15.Null;
EXPORT B_Business_Sele_10(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE
  SHARED VIRTUAL TYPEOF(E_Business_Sele(__in,__cfg).__Result) __E_Business_Sele := E_Business_Sele(__in,__cfg).__Result;
  SHARED VIRTUAL TYPEOF(E_Input_B_I_I(__in,__cfg).__Result) __E_Input_B_I_I := E_Input_B_I_I(__in,__cfg).__Result;
  SHARED VIRTUAL TYPEOF(B_Sele_Lien_Judgment_11(__in,__cfg).__ENH_Sele_Lien_Judgment_11) __ENH_Sele_Lien_Judgment_11 := B_Sele_Lien_Judgment_11(__in,__cfg).__ENH_Sele_Lien_Judgment_11;
  SHARED __EE305805 := __E_Business_Sele;
  SHARED __EE308721 := __E_Input_B_I_I;
  SHARED __EE309357 := __EE308721(__NN(__EE308721.Legal_));
  SHARED __ST309012_Layout := RECORD
    KEL.typ.ntyp(E_Business_Sele().Typ) UID;
    KEL.typ.nuid U_I_D__1_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
  END;
  SHARED __ST309012_Layout __ND309640__Project(E_Input_B_I_I(__in,__cfg).Layout __PP309636) := TRANSFORM
    SELF.UID := __PP309636.Legal_;
    SELF.U_I_D__1_ := __PP309636.UID;
    SELF := __PP309636;
  END;
  SHARED __EE309649 := PROJECT(__EE309357,__ND309640__Project(LEFT));
  SHARED __ST309040_Layout := RECORD
    KEL.typ.ntyp(E_Business_Sele().Typ) UID;
    KEL.typ.ntyp(E_Input_B_I_I().Typ) O_N_L_Y___U_I_D_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
  END;
  SHARED __EE4622247 := PROJECT(__EE309649,TRANSFORM(__ST309040_Layout,SELF.O_N_L_Y___U_I_D_ := LEFT.U_I_D__1_,SELF := LEFT));
  SHARED __ST311289_Layout := RECORD
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
  __JC4623451(E_Business_Sele(__in,__cfg).Layout __EE305805, __ST309040_Layout __EE4622247) := __EEQP(__EE305805.UID,__EE4622247.UID);
  __ST311289_Layout __JT4623451(E_Business_Sele(__in,__cfg).Layout __l, __ST309040_Layout __r) := TRANSFORM
    SELF.U_I_D__1_ := __r.UID;
    SELF := __l;
    SELF := __r;
  END;
  SHARED __EE4623452 := JOIN(__EE305805,__EE4622247,__JC4623451(LEFT,RIGHT),__JT4623451(LEFT,RIGHT),LEFT OUTER,SMART,KEEP(1));
  SHARED __EE4620896 := __ENH_Sele_Lien_Judgment_11;
  SHARED __EE4620903 := __EE4620896(__NN(__EE4620896.Sele_));
  SHARED __EE4620914 := __EE4620903.Details_;
  __JC4620917(B_Sele_Lien_Judgment_11(__in,__cfg).__ST260444_Layout __EE4620914) := __T(__EE4620914.Is_Debtor_);
  SHARED __EE4620918 := __EE4620903(EXISTS(__CHILDJOINFILTER(__EE4620914,__JC4620917)));
  SHARED __ST310280_Layout := RECORD
    KEL.typ.ntyp(E_Business_Sele().Typ) Sele_;
    KEL.typ.ntyp(E_Lien_Judgment().Typ) Lien_;
    KEL.typ.nint Ult_I_D_;
    KEL.typ.nint Org_I_D_;
    KEL.typ.nint Sele_I_D_;
    KEL.typ.nstr T_M_S_I_D_;
    KEL.typ.nstr R_M_S_I_D_;
    KEL.typ.ndataset(B_Sele_Lien_Judgment_11(__in,__cfg).__ST260444_Layout) Details_;
    KEL.typ.ndataset(E_Sele_Lien_Judgment(__in,__cfg).Data_Sources_Layout) Data_Sources_;
    KEL.typ.ndataset(B_Sele_Lien_Judgment_11(__in,__cfg).__ST115112_Layout) Gather_Liens_;
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
  __ST310280_Layout __JT4620952(B_Sele_Lien_Judgment_11(__in,__cfg).__ST260435_Layout __l, B_Sele_Lien_Judgment_11(__in,__cfg).__ST115112_Layout __r) := TRANSFORM
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
  SHARED __EE4620953 := NORMALIZE(__EE4620918,__T(LEFT.Gather_Liens_),__JT4620952(LEFT,RIGHT));
  SHARED __ST306218_Layout := RECORD
    KEL.typ.ntyp(E_Business_Sele().Typ) Sele_;
    KEL.typ.ntyp(E_Lien_Judgment().Typ) Lien_;
    KEL.typ.nint Ult_I_D_;
    KEL.typ.nint Org_I_D_;
    KEL.typ.nint Sele_I_D_;
    KEL.typ.nstr T_M_S_I_D_;
    KEL.typ.nstr R_M_S_I_D_;
    KEL.typ.ndataset(B_Sele_Lien_Judgment_11(__in,__cfg).__ST260444_Layout) Details_;
    KEL.typ.ndataset(E_Sele_Lien_Judgment(__in,__cfg).Data_Sources_Layout) Data_Sources_;
    KEL.typ.ndataset(B_Sele_Lien_Judgment_11(__in,__cfg).__ST115112_Layout) Gather_Liens_;
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
  SHARED __EE4621077 := PROJECT(__EE4620953,TRANSFORM(__ST306218_Layout,SELF.UID := LEFT.Sele_,SELF := LEFT));
  SHARED __EE4623404 := __EE4621077;
  SHARED __EE4623411 := __EE4623404(__T(__FN1(KEL.Routines.IsValidDate,__EE4623404.My_Date_First_Seen_)));
  SHARED __ST308218_Layout := RECORD
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
  SHARED __ST308218_Layout __ND4623416__Project(__ST306218_Layout __PP4623412) := TRANSFORM
    SELF.____grp___T_M_S_I_D_ := __PP4623412.T_M_S_I_D_;
    SELF.____grp___U_I_D_ := __PP4623412.UID;
    SELF := __PP4623412;
  END;
  SHARED __EE4623445 := PROJECT(TABLE(PROJECT(__EE4623411,__ND4623416__Project(LEFT)),{KEL.typ.epoch Archive___Date_ := KEL.era.SimpleRoll(GROUP,Archive___Date_,MIN,FALSE),KEL.typ.epoch Date_First_Seen_ := KEL.era.SimpleRoll(GROUP,Date_First_Seen_,MIN,FALSE),KEL.typ.epoch Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Date_Last_Seen_,MAX,FALSE),KEL.typ.epoch Hybrid_Archive_Date_ := KEL.era.SimpleRoll(GROUP,Hybrid_Archive_Date_,MIN,FALSE),KEL.typ.epoch Vault_Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Vault_Date_Last_Seen_,MAX,NMAX),____grp___T_M_S_I_D_,____grp___U_I_D_,T_M_S_I_D_,Filing_Type_Description_,Amount_,Landlord_Tenant_Dispute_Flag_,My_Date_First_Seen_},____grp___T_M_S_I_D_,____grp___U_I_D_,T_M_S_I_D_,Filing_Type_Description_,Amount_,Landlord_Tenant_Dispute_Flag_,My_Date_First_Seen_,MERGE),__ST308218_Layout);
  SHARED __EE4623402 := GROUP(__EE4623445,____grp___T_M_S_I_D_,____grp___U_I_D_,ALL);
  SHARED __EE4623449 := UNGROUP(TOPN(__EE4623402(__NN(__EE4623402.My_Date_First_Seen_)),1,__T(__EE4623402.My_Date_First_Seen_),__T(____grp___T_M_S_I_D_),__T(Filing_Type_Description_),__T(Amount_),__T(Landlord_Tenant_Dispute_Flag_),__T(____grp___U_I_D_),__T(T_M_S_I_D_)));
  SHARED __ST308053_Layout := RECORD
    KEL.typ.nstr T_M_S_I_D_;
    KEL.typ.ntyp(E_Business_Sele().Typ) UID;
    KEL.typ.nkdate My_Date_First_Seen_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
  END;
  SHARED __ST308053_Layout __ND4621147__Project(__ST308218_Layout __PP4621143) := TRANSFORM
    SELF.T_M_S_I_D_ := __PP4621143.____grp___T_M_S_I_D_;
    SELF.UID := __PP4621143.____grp___U_I_D_;
    SELF := __PP4621143;
  END;
  SHARED __EE4621160 := PROJECT(__EE4623449,__ND4621147__Project(LEFT));
  SHARED __ST308090_Layout := RECORD
    KEL.typ.nstr T_M_S_I_D_;
    KEL.typ.ntyp(E_Business_Sele().Typ) UID;
    KEL.typ.nkdate O_N_L_Y___My_Date_First_Seen_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
  END;
  SHARED __EE4622404 := PROJECT(__EE4621160,TRANSFORM(__ST308090_Layout,SELF.O_N_L_Y___My_Date_First_Seen_ := LEFT.My_Date_First_Seen_,SELF := LEFT));
  SHARED __ST310728_Layout := RECORD
    KEL.typ.ntyp(E_Business_Sele().Typ) Sele_;
    KEL.typ.ntyp(E_Lien_Judgment().Typ) Lien_;
    KEL.typ.nint Ult_I_D_;
    KEL.typ.nint Org_I_D_;
    KEL.typ.nint Sele_I_D_;
    KEL.typ.nstr T_M_S_I_D_;
    KEL.typ.nstr R_M_S_I_D_;
    KEL.typ.ndataset(B_Sele_Lien_Judgment_11(__in,__cfg).__ST260444_Layout) Details_;
    KEL.typ.ndataset(E_Sele_Lien_Judgment(__in,__cfg).Data_Sources_Layout) Data_Sources_;
    KEL.typ.ndataset(B_Sele_Lien_Judgment_11(__in,__cfg).__ST115112_Layout) Gather_Liens_;
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
  __JC4622415(__ST306218_Layout __EE4621077, __ST308090_Layout __EE4622404) := __EEQP(__EE4621077.UID,__EE4622404.UID) AND __EEQP(__EE4621077.T_M_S_I_D_,__EE4622404.T_M_S_I_D_);
  __ST310728_Layout __JT4622415(__ST306218_Layout __l, __ST308090_Layout __r) := TRANSFORM
    SELF.T_M_S_I_D__2_ := __r.T_M_S_I_D_;
    SELF.U_I_D__1_ := __r.UID;
    SELF := __l;
    SELF := __r;
  END;
  SHARED __EE4622416 := JOIN(__EE4621077,__EE4622404,__JC4622415(LEFT,RIGHT),__JT4622415(LEFT,RIGHT),LEFT OUTER,HASH,KEEP(1));
  SHARED __EE4623336 := __EE4621077;
  SHARED __EE4625822 := __EE4623336(__T(__OR(__NOT(__NT(__EE4623336.Amount_)),__OP2(__EE4623336.Amount_,<>,__CN(0)))));
  SHARED __ST307611_Layout := RECORD
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
  SHARED __ST307611_Layout __ND4625827__Project(__ST306218_Layout __PP4625823) := TRANSFORM
    SELF.____grp___U_I_D_ := __PP4625823.UID;
    SELF.____grp___T_M_S_I_D_ := __PP4625823.T_M_S_I_D_;
    SELF := __PP4625823;
  END;
  SHARED __EE4625856 := PROJECT(TABLE(PROJECT(__EE4625822,__ND4625827__Project(LEFT)),{KEL.typ.epoch Archive___Date_ := KEL.era.SimpleRoll(GROUP,Archive___Date_,MIN,FALSE),KEL.typ.epoch Date_First_Seen_ := KEL.era.SimpleRoll(GROUP,Date_First_Seen_,MIN,FALSE),KEL.typ.epoch Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Date_Last_Seen_,MAX,FALSE),KEL.typ.epoch Hybrid_Archive_Date_ := KEL.era.SimpleRoll(GROUP,Hybrid_Archive_Date_,MIN,FALSE),KEL.typ.epoch Vault_Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Vault_Date_Last_Seen_,MAX,NMAX),____grp___U_I_D_,____grp___T_M_S_I_D_,T_M_S_I_D_,Filing_Type_Description_,Amount_,Landlord_Tenant_Dispute_Flag_,My_Date_First_Seen_},____grp___U_I_D_,____grp___T_M_S_I_D_,T_M_S_I_D_,Filing_Type_Description_,Amount_,Landlord_Tenant_Dispute_Flag_,My_Date_First_Seen_,MERGE),__ST307611_Layout);
  SHARED __EE4625867 := GROUP(__EE4625856,____grp___U_I_D_,____grp___T_M_S_I_D_,ALL);
  SHARED __EE4625880 := UNGROUP(TOPN(__EE4625867(__NN(__EE4625867.My_Date_First_Seen_) AND __NN(__EE4625867.Amount_)),1, -__T(__EE4625867.My_Date_First_Seen_), -__T(__EE4625867.Amount_),__T(____grp___T_M_S_I_D_),__T(Filing_Type_Description_),__T(Landlord_Tenant_Dispute_Flag_),__T(____grp___U_I_D_),__T(T_M_S_I_D_)));
  SHARED __ST307448_Layout := RECORD
    KEL.typ.nstr T_M_S_I_D_;
    KEL.typ.ntyp(E_Business_Sele().Typ) UID;
    KEL.typ.nint Amount_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
  END;
  SHARED __ST307448_Layout __ND4625885__Project(__ST307611_Layout __PP4625881) := TRANSFORM
    SELF.T_M_S_I_D_ := __PP4625881.____grp___T_M_S_I_D_;
    SELF.UID := __PP4625881.____grp___U_I_D_;
    SELF := __PP4625881;
  END;
  SHARED __EE4625898 := PROJECT(__EE4625880,__ND4625885__Project(LEFT));
  SHARED __ST307485_Layout := RECORD
    KEL.typ.nstr T_M_S_I_D_;
    KEL.typ.ntyp(E_Business_Sele().Typ) UID;
    KEL.typ.nint O_N_L_Y___Amount_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
  END;
  SHARED __EE4625916 := PROJECT(__EE4625898,TRANSFORM(__ST307485_Layout,SELF.O_N_L_Y___Amount_ := LEFT.Amount_,SELF := LEFT));
  SHARED __ST310825_Layout := RECORD
    KEL.typ.ntyp(E_Business_Sele().Typ) Sele_;
    KEL.typ.ntyp(E_Lien_Judgment().Typ) Lien_;
    KEL.typ.nint Ult_I_D_;
    KEL.typ.nint Org_I_D_;
    KEL.typ.nint Sele_I_D_;
    KEL.typ.nstr T_M_S_I_D_;
    KEL.typ.nstr R_M_S_I_D_;
    KEL.typ.ndataset(B_Sele_Lien_Judgment_11(__in,__cfg).__ST260444_Layout) Details_;
    KEL.typ.ndataset(E_Sele_Lien_Judgment(__in,__cfg).Data_Sources_Layout) Data_Sources_;
    KEL.typ.ndataset(B_Sele_Lien_Judgment_11(__in,__cfg).__ST115112_Layout) Gather_Liens_;
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
  __JC4625926(__ST310728_Layout __EE4622416, __ST307485_Layout __EE4625916) := __EEQP(__EE4622416.T_M_S_I_D_,__EE4625916.T_M_S_I_D_) AND __EEQP(__EE4622416.UID,__EE4625916.UID);
  __ST310825_Layout __JT4625926(__ST310728_Layout __l, __ST307485_Layout __r) := TRANSFORM
    SELF.T_M_S_I_D__3_ := __r.T_M_S_I_D_;
    SELF.U_I_D__2_ := __r.UID;
    SELF := __l;
    SELF := __r;
  END;
  SHARED __EE4625966 := JOIN(__EE4622416,__EE4625916,__JC4625926(LEFT,RIGHT),__JT4625926(LEFT,RIGHT),LEFT OUTER,HASH,KEEP(1));
  SHARED __EE4623273 := __EE4621077;
  SHARED __EE4623281 := __EE4623273(__T(__NOT(__NT(__EE4623273.Filing_Type_Description_))));
  SHARED __ST306995_Layout := RECORD
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
  SHARED __ST306995_Layout __ND4623286__Project(__ST306218_Layout __PP4623282) := TRANSFORM
    SELF.____grp___T_M_S_I_D_ := __PP4623282.T_M_S_I_D_;
    SELF.____grp___U_I_D_ := __PP4623282.UID;
    SELF := __PP4623282;
  END;
  SHARED __EE4623315 := PROJECT(TABLE(PROJECT(__EE4623281,__ND4623286__Project(LEFT)),{KEL.typ.epoch Archive___Date_ := KEL.era.SimpleRoll(GROUP,Archive___Date_,MIN,FALSE),KEL.typ.epoch Date_First_Seen_ := KEL.era.SimpleRoll(GROUP,Date_First_Seen_,MIN,FALSE),KEL.typ.epoch Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Date_Last_Seen_,MAX,FALSE),KEL.typ.epoch Hybrid_Archive_Date_ := KEL.era.SimpleRoll(GROUP,Hybrid_Archive_Date_,MIN,FALSE),KEL.typ.epoch Vault_Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Vault_Date_Last_Seen_,MAX,NMAX),____grp___T_M_S_I_D_,____grp___U_I_D_,T_M_S_I_D_,Filing_Type_Description_,Amount_,Landlord_Tenant_Dispute_Flag_,My_Date_First_Seen_},____grp___T_M_S_I_D_,____grp___U_I_D_,T_M_S_I_D_,Filing_Type_Description_,Amount_,Landlord_Tenant_Dispute_Flag_,My_Date_First_Seen_,MERGE),__ST306995_Layout);
  SHARED __EE4623271 := GROUP(__EE4623315,____grp___T_M_S_I_D_,____grp___U_I_D_,ALL);
  SHARED __EE4623319 := UNGROUP(TOPN(__EE4623271(__NN(__EE4623271.My_Date_First_Seen_)),1, -__T(__EE4623271.My_Date_First_Seen_),__T(____grp___T_M_S_I_D_),__T(Filing_Type_Description_),__T(Amount_),__T(Landlord_Tenant_Dispute_Flag_),__T(____grp___U_I_D_),__T(T_M_S_I_D_)));
  SHARED __ST306827_Layout := RECORD
    KEL.typ.nstr T_M_S_I_D_;
    KEL.typ.ntyp(E_Business_Sele().Typ) UID;
    KEL.typ.nstr Filing_Type_Description_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
  END;
  SHARED __ST306827_Layout __ND4621467__Project(__ST306995_Layout __PP4621463) := TRANSFORM
    SELF.T_M_S_I_D_ := __PP4621463.____grp___T_M_S_I_D_;
    SELF.UID := __PP4621463.____grp___U_I_D_;
    SELF := __PP4621463;
  END;
  SHARED __EE4621480 := PROJECT(__EE4623319,__ND4621467__Project(LEFT));
  SHARED __ST306864_Layout := RECORD
    KEL.typ.nstr T_M_S_I_D_;
    KEL.typ.ntyp(E_Business_Sele().Typ) UID;
    KEL.typ.nstr O_N_L_Y___Filing_Type_Description_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
  END;
  SHARED __EE4622511 := PROJECT(__EE4621480,TRANSFORM(__ST306864_Layout,SELF.O_N_L_Y___Filing_Type_Description_ := LEFT.Filing_Type_Description_,SELF := LEFT));
  SHARED __ST310918_Layout := RECORD
    KEL.typ.ntyp(E_Business_Sele().Typ) Sele_;
    KEL.typ.ntyp(E_Lien_Judgment().Typ) Lien_;
    KEL.typ.nint Ult_I_D_;
    KEL.typ.nint Org_I_D_;
    KEL.typ.nint Sele_I_D_;
    KEL.typ.nstr T_M_S_I_D_;
    KEL.typ.nstr R_M_S_I_D_;
    KEL.typ.ndataset(B_Sele_Lien_Judgment_11(__in,__cfg).__ST260444_Layout) Details_;
    KEL.typ.ndataset(E_Sele_Lien_Judgment(__in,__cfg).Data_Sources_Layout) Data_Sources_;
    KEL.typ.ndataset(B_Sele_Lien_Judgment_11(__in,__cfg).__ST115112_Layout) Gather_Liens_;
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
  __JC4625976(__ST310825_Layout __EE4625966, __ST306864_Layout __EE4622511) := __EEQP(__EE4625966.T_M_S_I_D_,__EE4622511.T_M_S_I_D_) AND __EEQP(__EE4625966.UID,__EE4622511.UID);
  __ST310918_Layout __JT4625976(__ST310825_Layout __l, __ST306864_Layout __r) := TRANSFORM
    SELF.T_M_S_I_D__4_ := __r.T_M_S_I_D_;
    SELF.U_I_D__3_ := __r.UID;
    SELF := __l;
    SELF := __r;
  END;
  SHARED __EE4626019 := JOIN(__EE4625966,__EE4622511,__JC4625976(LEFT,RIGHT),__JT4625976(LEFT,RIGHT),LEFT OUTER,HASH,KEEP(1));
  SHARED __ST311015_Layout := RECORD
    KEL.typ.ntyp(E_Business_Sele().Typ) Sele_;
    KEL.typ.ntyp(E_Lien_Judgment().Typ) Lien_;
    KEL.typ.nint Ult_I_D_;
    KEL.typ.nint Org_I_D_;
    KEL.typ.nint Sele_I_D_;
    KEL.typ.nstr T_M_S_I_D_;
    KEL.typ.nstr R_M_S_I_D_;
    KEL.typ.ndataset(B_Sele_Lien_Judgment_11(__in,__cfg).__ST260444_Layout) Details_;
    KEL.typ.ndataset(E_Sele_Lien_Judgment(__in,__cfg).Data_Sources_Layout) Data_Sources_;
    KEL.typ.ndataset(B_Sele_Lien_Judgment_11(__in,__cfg).__ST115112_Layout) Gather_Liens_;
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
  SHARED __EE4621559 := __EE4621077;
  SHARED __EE4626024 := __EE4621559(__T(__OP2(__EE4621559.Landlord_Tenant_Dispute_Flag_,=,__CN('Y'))));
  __JC4626038(__ST310918_Layout __EE4626019, __ST306218_Layout __EE4626024) := __EEQP(__EE4626019.T_M_S_I_D_,__EE4626024.T_M_S_I_D_) AND __EEQP(__EE4626019.UID,__EE4626024.UID);
  __JF4626038(__ST306218_Layout __EE4626024) := __NN(__EE4626024.T_M_S_I_D_) OR __NN(__EE4626024.UID);
  SHARED __EE4626078 := JOIN(__EE4626019,__EE4626024,__JC4626038(LEFT,RIGHT),TRANSFORM(__ST311015_Layout,SELF:=LEFT,SELF.Exp1_:=__JF4626038(RIGHT)),HASH,LEFT OUTER,KEEP(1));
  SHARED __ST4625169_Layout := RECORD
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
  SHARED __EE4626108 := PROJECT(TABLE(PROJECT(__EE4626078,__ST4625169_Layout),{KEL.typ.int __RecordCount := SUM(GROUP,__RecordCount),KEL.typ.epoch Archive___Date_ := KEL.era.SimpleRoll(GROUP,Archive___Date_,MIN,FALSE),KEL.typ.epoch Date_First_Seen_ := KEL.era.SimpleRoll(GROUP,Date_First_Seen_,MIN,FALSE),KEL.typ.epoch Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Date_Last_Seen_,MAX,FALSE),KEL.typ.epoch Hybrid_Archive_Date_ := KEL.era.SimpleRoll(GROUP,Hybrid_Archive_Date_,MIN,FALSE),KEL.typ.epoch Vault_Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Vault_Date_Last_Seen_,MAX,NMAX),T_M_S_I_D_,UID,O_N_L_Y___My_Date_First_Seen_,O_N_L_Y___Amount_,O_N_L_Y___Filing_Type_Description_,Exp1_},T_M_S_I_D_,UID,O_N_L_Y___My_Date_First_Seen_,O_N_L_Y___Amount_,O_N_L_Y___Filing_Type_Description_,Exp1_,MERGE),__ST4625169_Layout);
  SHARED __ST4625199_Layout := RECORD
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
    KEL.typ.ndataset(__ST4625169_Layout) Exp1_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  __JC4626114(__ST311289_Layout __EE4623452, __ST4625169_Layout __EE4626108) := __EEQP(__EE4623452.UID,__EE4626108.UID);
  __ST4625199_Layout __Join__ST4625199_Layout(__ST311289_Layout __r, DATASET(__ST4625169_Layout) __recs) := TRANSFORM
    SELF := __r;
    SELF.Exp1_ := __CN(__recs);
  END;
  SHARED __EE4626268 := DENORMALIZE(DISTRIBUTE(__EE4623452,HASH(UID)),DISTRIBUTE(__EE4626108,HASH(UID)),__JC4626114(LEFT,RIGHT),GROUP,__Join__ST4625199_Layout(LEFT,ROWS(RIGHT)),LOCAL);
  EXPORT __ST258899_Layout := RECORD
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
  EXPORT __ST258907_Layout := RECORD
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
  EXPORT __ST115191_Layout := RECORD
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
  EXPORT __ST258842_Layout := RECORD
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
    KEL.typ.ndataset(__ST258899_Layout) S_I_C_Codes_;
    KEL.typ.ndataset(__ST258907_Layout) N_A_I_C_S_Codes_;
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
    KEL.typ.ndataset(__ST115191_Layout) All_Lien_Data_;
    KEL.typ.ntyp(E_Input_B_I_I().Typ) B_I_I_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  SHARED __ST258842_Layout __ND4626285__Project(__ST4625199_Layout __PP4626281) := TRANSFORM
    __EE4626271 := __PP4626281.S_I_C_Codes_;
    __ST258899_Layout __ND4626465__Project(E_Business_Sele(__in,__cfg).S_I_C_Codes_Layout __PP4626461) := TRANSFORM
      __CC13394 := KEL.Routines.MinN(FN_Compile(__cfg).FN_G_E_T_B_U_I_L_D_D_A_T_E(__ECAST(KEL.typ.nstr,__CN('Corp_build_version'))),__CN(__cfg.CurrentDate));
      SELF.Days_Since_Code_ := __FN2(KEL.Routines.DaysBetween,KEL.era.ToDate(__PP4626461.Date_First_Seen_),__CC13394);
      SELF := __PP4626461;
    END;
    SELF.S_I_C_Codes_ := __PROJECT(__EE4626271,__ND4626465__Project(LEFT));
    __EE4626275 := __PP4626281.N_A_I_C_S_Codes_;
    __ST258907_Layout __ND4626494__Project(E_Business_Sele(__in,__cfg).N_A_I_C_S_Codes_Layout __PP4626490) := TRANSFORM
      __CC13394 := KEL.Routines.MinN(FN_Compile(__cfg).FN_G_E_T_B_U_I_L_D_D_A_T_E(__ECAST(KEL.typ.nstr,__CN('Corp_build_version'))),__CN(__cfg.CurrentDate));
      SELF.Days_Since_Code_ := __FN2(KEL.Routines.DaysBetween,KEL.era.ToDate(__PP4626490.Date_First_Seen_),__CC13394);
      SELF := __PP4626490;
    END;
    SELF.N_A_I_C_S_Codes_ := __PROJECT(__EE4626275,__ND4626494__Project(LEFT));
    __EE4626279 := __PP4626281.Exp1_;
    __ST115191_Layout __ND4626553__Project(__ST4625169_Layout __PP4626549) := TRANSFORM
      SELF.Filing_Type_Description_ := __PP4626549.O_N_L_Y___Filing_Type_Description_;
      SELF.Amount_ := __PP4626549.O_N_L_Y___Amount_;
      SELF.Landlord_Tenant_Dispute_Flag_ := __PP4626549.Exp1_;
      SELF.Original_Filing_Date_ := __PP4626549.O_N_L_Y___My_Date_First_Seen_;
      SELF := __PP4626549;
    END;
    SELF.All_Lien_Data_ := __PROJECT(__EE4626279,__ND4626553__Project(LEFT));
    SELF.B_I_I_ := __PP4626281.O_N_L_Y___U_I_D_;
    SELF := __PP4626281;
  END;
  EXPORT __ENH_Business_Sele_10 := PROJECT(__EE4626268,__ND4626285__Project(LEFT));
END;
