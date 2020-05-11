﻿//HPCC Systems KEL Compiler Version 1.2.2-dev
IMPORT KEL12 AS KEL;
IMPORT B_Sele_Lien_Judgment_11,CFG_Compile,E_Business_Org,E_Business_Sele,E_Business_Ult,E_Input_B_I_I,E_Lien_Judgment,E_Sele_Lien_Judgment,FN_Compile FROM PublicRecords_KEL;
IMPORT * FROM KEL12.Null;
EXPORT B_Business_Sele_10(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE
  SHARED VIRTUAL TYPEOF(E_Business_Sele().__Result) __E_Business_Sele := E_Business_Sele(__in,__cfg).__Result;
  SHARED VIRTUAL TYPEOF(E_Input_B_I_I().__Result) __E_Input_B_I_I := E_Input_B_I_I(__in,__cfg).__Result;
  SHARED VIRTUAL TYPEOF(B_Sele_Lien_Judgment_11().__ENH_Sele_Lien_Judgment_11) __ENH_Sele_Lien_Judgment_11 := B_Sele_Lien_Judgment_11(__in,__cfg).__ENH_Sele_Lien_Judgment_11;
  SHARED __EE227822 := __E_Business_Sele;
  SHARED __EE227825 := __E_Input_B_I_I;
  SHARED __EE227826 := __EE227825(__NN(__EE227825.Legal_));
  SHARED __ST215730_Layout := RECORD
    KEL.typ.ntyp(E_Business_Sele().Typ) UID;
    KEL.typ.nuid U_I_D__1_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Date_Vendor_First_Reported_ := 0;
    KEL.typ.epoch Date_Vendor_Last_Reported_ := 0;
  END;
  SHARED __ST215730_Layout __ND216423__Project(E_Input_B_I_I(__in,__cfg).Layout __PP216419) := TRANSFORM
    SELF.UID := __PP216419.Legal_;
    SELF.U_I_D__1_ := __PP216419.UID;
    SELF := __PP216419;
  END;
  SHARED __EE227823 := PROJECT(__EE227826,__ND216423__Project(LEFT));
  SHARED __ST215758_Layout := RECORD
    KEL.typ.ntyp(E_Business_Sele().Typ) UID;
    KEL.typ.ntyp(E_Input_B_I_I().Typ) O_N_L_Y___U_I_D_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Date_Vendor_First_Reported_ := 0;
    KEL.typ.epoch Date_Vendor_Last_Reported_ := 0;
  END;
  SHARED __EE227855 := PROJECT(__EE227823,TRANSFORM(__ST215758_Layout,SELF.O_N_L_Y___U_I_D_ := LEFT.U_I_D__1_,SELF := LEFT));
  SHARED __ST218380_Layout := RECORD
    KEL.typ.nuid UID;
    KEL.typ.nint Ult_I_D_;
    KEL.typ.nint Org_I_D_;
    KEL.typ.nint Sele_I_D_;
    KEL.typ.ntyp(E_Business_Org().Typ) Sele_Org_;
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
    KEL.typ.ndataset(E_Business_Sele(__in,__cfg).Vendor_Identification_Layout) Vendor_Identification_;
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
    KEL.typ.ndataset(E_Business_Sele(__in,__cfg).S_O_S_Company_Types_Layout) S_O_S_Company_Types_;
    KEL.typ.ndataset(E_Business_Sele(__in,__cfg).S_O_S_Registered_Agents_Layout) S_O_S_Registered_Agents_;
    KEL.typ.ndataset(E_Business_Sele(__in,__cfg).S_O_S_Statuses_Layout) S_O_S_Statuses_;
    KEL.typ.ndataset(E_Business_Sele(__in,__cfg).S_O_S_Incorporation_Details_Layout) S_O_S_Incorporation_Details_;
    KEL.typ.ndataset(E_Business_Sele(__in,__cfg).S_O_S_Charter_Numbers_Layout) S_O_S_Charter_Numbers_;
    KEL.typ.ndataset(E_Business_Sele(__in,__cfg).S_O_S_Term_Exist_Codes_Layout) S_O_S_Term_Exist_Codes_;
    KEL.typ.ndataset(E_Business_Sele(__in,__cfg).Government_Debarred_Layout) Government_Debarred_;
    KEL.typ.ndataset(E_Business_Sele(__in,__cfg).Non_Profit_Layout) Non_Profit_;
    KEL.typ.ndataset(E_Business_Sele(__in,__cfg).Retirement_Plan_Information_Layout) Retirement_Plan_Information_;
    KEL.typ.ndataset(E_Business_Sele(__in,__cfg).Processing_Dates_Layout) Processing_Dates_;
    KEL.typ.ndataset(E_Business_Sele(__in,__cfg).Business_Registration_Layout) Business_Registration_;
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
    KEL.typ.epoch Date_Vendor_First_Reported_ := 0;
    KEL.typ.epoch Date_Vendor_Last_Reported_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  __JC229355(E_Business_Sele(__in,__cfg).Layout __EE227822, __ST215758_Layout __EE227855) := __EEQP(__EE227822.UID,__EE227855.UID);
  __ST218380_Layout __JT229355(E_Business_Sele(__in,__cfg).Layout __l, __ST215758_Layout __r) := TRANSFORM
    SELF.U_I_D__1_ := __r.UID;
    SELF := __l;
    SELF := __r;
  END;
  SHARED __EE229356 := JOIN(__EE227822,__EE227855,__JC229355(LEFT,RIGHT),__JT229355(LEFT,RIGHT),LEFT OUTER,SMART,KEEP(1));
  SHARED __EE227842 := __ENH_Sele_Lien_Judgment_11;
  SHARED __EE227845 := __EE227842(__NN(__EE227842.Sele_));
  SHARED __EE217215 := __EE227845.Details_;
  __JC217227(B_Sele_Lien_Judgment_11(__in,__cfg).__ST171107_Layout __EE217215) := __T(__EE217215.Is_Debtor_);
  SHARED __EE227846 := __EE227845(EXISTS(__CHILDJOINFILTER(__EE217215,__JC217227)));
  SHARED __ST217333_Layout := RECORD
    KEL.typ.ntyp(E_Business_Sele().Typ) Sele_;
    KEL.typ.ntyp(E_Lien_Judgment().Typ) Lien_;
    KEL.typ.nint Ult_I_D_;
    KEL.typ.nint Org_I_D_;
    KEL.typ.nint Sele_I_D_;
    KEL.typ.nstr T_M_S_I_D_;
    KEL.typ.nstr R_M_S_I_D_;
    KEL.typ.ndataset(B_Sele_Lien_Judgment_11(__in,__cfg).__ST171107_Layout) Details_;
    KEL.typ.ndataset(E_Sele_Lien_Judgment(__in,__cfg).Data_Sources_Layout) Data_Sources_;
    KEL.typ.ndataset(B_Sele_Lien_Judgment_11(__in,__cfg).__ST76934_Layout) Gather_Liens_;
    KEL.typ.nstr T_M_S_I_D__1_;
    KEL.typ.nstr Filing_Type_Description_;
    KEL.typ.nint Amount_;
    KEL.typ.nstr Landlord_Tenant_Dispute_Flag_;
    KEL.typ.nkdate My_Date_First_Seen_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Date_Vendor_First_Reported_ := 0;
    KEL.typ.epoch Date_Vendor_Last_Reported_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  __ST217333_Layout __JT217330(B_Sele_Lien_Judgment_11(__in,__cfg).__ST171098_Layout __l, B_Sele_Lien_Judgment_11(__in,__cfg).__ST76934_Layout __r) := TRANSFORM
    SELF.T_M_S_I_D__1_ := __r.T_M_S_I_D_;
    SELF.__RecordCount := __r.__RecordCount;
    SELF := __l;
    SELF := __r;
  END;
  SHARED __EE227847 := NORMALIZE(__EE227846,__T(LEFT.Gather_Liens_),__JT217330(LEFT,RIGHT));
  SHARED __ST212928_Layout := RECORD
    KEL.typ.ntyp(E_Business_Sele().Typ) Sele_;
    KEL.typ.ntyp(E_Lien_Judgment().Typ) Lien_;
    KEL.typ.nint Ult_I_D_;
    KEL.typ.nint Org_I_D_;
    KEL.typ.nint Sele_I_D_;
    KEL.typ.nstr T_M_S_I_D_;
    KEL.typ.nstr R_M_S_I_D_;
    KEL.typ.ndataset(B_Sele_Lien_Judgment_11(__in,__cfg).__ST171107_Layout) Details_;
    KEL.typ.ndataset(E_Sele_Lien_Judgment(__in,__cfg).Data_Sources_Layout) Data_Sources_;
    KEL.typ.ndataset(B_Sele_Lien_Judgment_11(__in,__cfg).__ST76934_Layout) Gather_Liens_;
    KEL.typ.nstr T_M_S_I_D__1_;
    KEL.typ.nstr Filing_Type_Description_;
    KEL.typ.nint Amount_;
    KEL.typ.nstr Landlord_Tenant_Dispute_Flag_;
    KEL.typ.nkdate My_Date_First_Seen_;
    KEL.typ.ntyp(E_Business_Sele().Typ) UID;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Date_Vendor_First_Reported_ := 0;
    KEL.typ.epoch Date_Vendor_Last_Reported_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  SHARED __EE227848 := PROJECT(__EE227847,TRANSFORM(__ST212928_Layout,SELF.UID := LEFT.Sele_,SELF := LEFT));
  SHARED __EE229308 := __EE227848;
  SHARED __EE229315 := __EE229308(__T(__FN1(KEL.Routines.IsValidDate,__EE229308.My_Date_First_Seen_)));
  SHARED __ST214867_Layout := RECORD
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
    KEL.typ.epoch Date_Vendor_First_Reported_ := 0;
    KEL.typ.epoch Date_Vendor_Last_Reported_ := 0;
  END;
  SHARED __ST214867_Layout __ND229320__Project(__ST212928_Layout __PP229316) := TRANSFORM
    SELF.____grp___T_M_S_I_D_ := __PP229316.T_M_S_I_D_;
    SELF.____grp___U_I_D_ := __PP229316.UID;
    SELF := __PP229316;
  END;
  SHARED __EE229349 := PROJECT(TABLE(PROJECT(__EE229315,__ND229320__Project(LEFT)),{KEL.typ.epoch Archive___Date_ := KEL.era.SimpleRoll(GROUP,Archive___Date_,MIN,FALSE),KEL.typ.epoch Date_First_Seen_ := KEL.era.SimpleRoll(GROUP,Date_First_Seen_,MIN,FALSE),KEL.typ.epoch Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Date_Last_Seen_,MAX,FALSE),KEL.typ.epoch Date_Vendor_First_Reported_ := KEL.era.SimpleRoll(GROUP,Date_Vendor_First_Reported_,MIN,FALSE),KEL.typ.epoch Date_Vendor_Last_Reported_ := KEL.era.SimpleRoll(GROUP,Date_Vendor_Last_Reported_,MAX,FALSE),____grp___T_M_S_I_D_,____grp___U_I_D_,T_M_S_I_D_,Filing_Type_Description_,Amount_,Landlord_Tenant_Dispute_Flag_,My_Date_First_Seen_},____grp___T_M_S_I_D_,____grp___U_I_D_,T_M_S_I_D_,Filing_Type_Description_,Amount_,Landlord_Tenant_Dispute_Flag_,My_Date_First_Seen_,MERGE),__ST214867_Layout);
  SHARED __EE229306 := GROUP(__EE229349,____grp___T_M_S_I_D_,____grp___U_I_D_,ALL);
  SHARED __EE229353 := TOPN(__EE229306(__NN(__EE229306.My_Date_First_Seen_)),1,__T(__EE229306.My_Date_First_Seen_),__T(____grp___T_M_S_I_D_),__T(Filing_Type_Description_),__T(Amount_),__T(Landlord_Tenant_Dispute_Flag_),__T(____grp___U_I_D_),__T(T_M_S_I_D_));
  SHARED __ST214707_Layout := RECORD
    KEL.typ.nstr T_M_S_I_D_;
    KEL.typ.ntyp(E_Business_Sele().Typ) UID;
    KEL.typ.nkdate My_Date_First_Seen_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Date_Vendor_First_Reported_ := 0;
    KEL.typ.epoch Date_Vendor_Last_Reported_ := 0;
  END;
  SHARED __ST214707_Layout __ND215051__Project(__ST214867_Layout __PP215047) := TRANSFORM
    SELF.T_M_S_I_D_ := __PP215047.____grp___T_M_S_I_D_;
    SELF.UID := __PP215047.____grp___U_I_D_;
    SELF := __PP215047;
  END;
  SHARED __EE227839 := PROJECT(__EE229353,__ND215051__Project(LEFT));
  SHARED __ST214744_Layout := RECORD
    KEL.typ.nstr T_M_S_I_D_;
    KEL.typ.ntyp(E_Business_Sele().Typ) UID;
    KEL.typ.nkdate O_N_L_Y___My_Date_First_Seen_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Date_Vendor_First_Reported_ := 0;
    KEL.typ.epoch Date_Vendor_Last_Reported_ := 0;
  END;
  SHARED __EE228081 := PROJECT(__EE227839,TRANSFORM(__ST214744_Layout,SELF.O_N_L_Y___My_Date_First_Seen_ := LEFT.My_Date_First_Seen_,SELF := LEFT));
  SHARED __ST217750_Layout := RECORD
    KEL.typ.ntyp(E_Business_Sele().Typ) Sele_;
    KEL.typ.ntyp(E_Lien_Judgment().Typ) Lien_;
    KEL.typ.nint Ult_I_D_;
    KEL.typ.nint Org_I_D_;
    KEL.typ.nint Sele_I_D_;
    KEL.typ.nstr T_M_S_I_D_;
    KEL.typ.nstr R_M_S_I_D_;
    KEL.typ.ndataset(B_Sele_Lien_Judgment_11(__in,__cfg).__ST171107_Layout) Details_;
    KEL.typ.ndataset(E_Sele_Lien_Judgment(__in,__cfg).Data_Sources_Layout) Data_Sources_;
    KEL.typ.ndataset(B_Sele_Lien_Judgment_11(__in,__cfg).__ST76934_Layout) Gather_Liens_;
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
    KEL.typ.epoch Date_Vendor_First_Reported_ := 0;
    KEL.typ.epoch Date_Vendor_Last_Reported_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  __JC229357(__ST212928_Layout __EE227848, __ST214744_Layout __EE228081) := __EEQP(__EE227848.UID,__EE228081.UID) AND __EEQP(__EE227848.T_M_S_I_D_,__EE228081.T_M_S_I_D_);
  __ST217750_Layout __JT229357(__ST212928_Layout __l, __ST214744_Layout __r) := TRANSFORM
    SELF.T_M_S_I_D__2_ := __r.T_M_S_I_D_;
    SELF.U_I_D__1_ := __r.UID;
    SELF := __l;
    SELF := __r;
  END;
  SHARED __EE229358 := JOIN(__EE227848,__EE228081,__JC229357(LEFT,RIGHT),__JT229357(LEFT,RIGHT),LEFT OUTER,SMART,KEEP(1));
  SHARED __EE229240 := __EE227848;
  SHARED __EE229701 := __EE229240(__T(__OR(__NOT(__NT(__EE229240.Amount_)),__OP2(__EE229240.Amount_,<>,__CN(0)))));
  SHARED __ST214265_Layout := RECORD
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
    KEL.typ.epoch Date_Vendor_First_Reported_ := 0;
    KEL.typ.epoch Date_Vendor_Last_Reported_ := 0;
  END;
  SHARED __ST214265_Layout __ND229706__Project(__ST212928_Layout __PP229702) := TRANSFORM
    SELF.____grp___U_I_D_ := __PP229702.UID;
    SELF.____grp___T_M_S_I_D_ := __PP229702.T_M_S_I_D_;
    SELF := __PP229702;
  END;
  SHARED __EE229735 := PROJECT(TABLE(PROJECT(__EE229701,__ND229706__Project(LEFT)),{KEL.typ.epoch Archive___Date_ := KEL.era.SimpleRoll(GROUP,Archive___Date_,MIN,FALSE),KEL.typ.epoch Date_First_Seen_ := KEL.era.SimpleRoll(GROUP,Date_First_Seen_,MIN,FALSE),KEL.typ.epoch Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Date_Last_Seen_,MAX,FALSE),KEL.typ.epoch Date_Vendor_First_Reported_ := KEL.era.SimpleRoll(GROUP,Date_Vendor_First_Reported_,MIN,FALSE),KEL.typ.epoch Date_Vendor_Last_Reported_ := KEL.era.SimpleRoll(GROUP,Date_Vendor_Last_Reported_,MAX,FALSE),____grp___U_I_D_,____grp___T_M_S_I_D_,T_M_S_I_D_,Filing_Type_Description_,Amount_,Landlord_Tenant_Dispute_Flag_,My_Date_First_Seen_},____grp___U_I_D_,____grp___T_M_S_I_D_,T_M_S_I_D_,Filing_Type_Description_,Amount_,Landlord_Tenant_Dispute_Flag_,My_Date_First_Seen_,MERGE),__ST214265_Layout);
  SHARED __EE229746 := GROUP(__EE229735,____grp___U_I_D_,____grp___T_M_S_I_D_,ALL);
  SHARED __EE229759 := TOPN(__EE229746(__NN(__EE229746.My_Date_First_Seen_) AND __NN(__EE229746.Amount_)),1, -__T(__EE229746.My_Date_First_Seen_), -__T(__EE229746.Amount_),__T(____grp___T_M_S_I_D_),__T(Filing_Type_Description_),__T(Landlord_Tenant_Dispute_Flag_),__T(____grp___U_I_D_),__T(T_M_S_I_D_));
  SHARED __ST214107_Layout := RECORD
    KEL.typ.nstr T_M_S_I_D_;
    KEL.typ.ntyp(E_Business_Sele().Typ) UID;
    KEL.typ.nint Amount_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Date_Vendor_First_Reported_ := 0;
    KEL.typ.epoch Date_Vendor_Last_Reported_ := 0;
  END;
  SHARED __ST214107_Layout __ND229764__Project(__ST214265_Layout __PP229760) := TRANSFORM
    SELF.T_M_S_I_D_ := __PP229760.____grp___T_M_S_I_D_;
    SELF.UID := __PP229760.____grp___U_I_D_;
    SELF := __PP229760;
  END;
  SHARED __EE229777 := PROJECT(__EE229759,__ND229764__Project(LEFT));
  SHARED __ST214144_Layout := RECORD
    KEL.typ.nstr T_M_S_I_D_;
    KEL.typ.ntyp(E_Business_Sele().Typ) UID;
    KEL.typ.nint O_N_L_Y___Amount_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Date_Vendor_First_Reported_ := 0;
    KEL.typ.epoch Date_Vendor_Last_Reported_ := 0;
  END;
  SHARED __EE229795 := PROJECT(__EE229777,TRANSFORM(__ST214144_Layout,SELF.O_N_L_Y___Amount_ := LEFT.Amount_,SELF := LEFT));
  SHARED __ST217847_Layout := RECORD
    KEL.typ.ntyp(E_Business_Sele().Typ) Sele_;
    KEL.typ.ntyp(E_Lien_Judgment().Typ) Lien_;
    KEL.typ.nint Ult_I_D_;
    KEL.typ.nint Org_I_D_;
    KEL.typ.nint Sele_I_D_;
    KEL.typ.nstr T_M_S_I_D_;
    KEL.typ.nstr R_M_S_I_D_;
    KEL.typ.ndataset(B_Sele_Lien_Judgment_11(__in,__cfg).__ST171107_Layout) Details_;
    KEL.typ.ndataset(E_Sele_Lien_Judgment(__in,__cfg).Data_Sources_Layout) Data_Sources_;
    KEL.typ.ndataset(B_Sele_Lien_Judgment_11(__in,__cfg).__ST76934_Layout) Gather_Liens_;
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
    KEL.typ.epoch Date_Vendor_First_Reported_ := 0;
    KEL.typ.epoch Date_Vendor_Last_Reported_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  __JC229805(__ST217750_Layout __EE229358, __ST214144_Layout __EE229795) := __EEQP(__EE229358.T_M_S_I_D_,__EE229795.T_M_S_I_D_) AND __EEQP(__EE229358.UID,__EE229795.UID);
  __ST217847_Layout __JT229805(__ST217750_Layout __l, __ST214144_Layout __r) := TRANSFORM
    SELF.T_M_S_I_D__3_ := __r.T_M_S_I_D_;
    SELF.U_I_D__2_ := __r.UID;
    SELF := __l;
    SELF := __r;
  END;
  SHARED __EE229845 := JOIN(__EE229358,__EE229795,__JC229805(LEFT,RIGHT),__JT229805(LEFT,RIGHT),LEFT OUTER,SMART,KEEP(1));
  SHARED __EE229177 := __EE227848;
  SHARED __EE229185 := __EE229177(__T(__NOT(__NT(__EE229177.Filing_Type_Description_))));
  SHARED __ST213654_Layout := RECORD
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
    KEL.typ.epoch Date_Vendor_First_Reported_ := 0;
    KEL.typ.epoch Date_Vendor_Last_Reported_ := 0;
  END;
  SHARED __ST213654_Layout __ND229190__Project(__ST212928_Layout __PP229186) := TRANSFORM
    SELF.____grp___U_I_D_ := __PP229186.UID;
    SELF.____grp___T_M_S_I_D_ := __PP229186.T_M_S_I_D_;
    SELF := __PP229186;
  END;
  SHARED __EE229219 := PROJECT(TABLE(PROJECT(__EE229185,__ND229190__Project(LEFT)),{KEL.typ.epoch Archive___Date_ := KEL.era.SimpleRoll(GROUP,Archive___Date_,MIN,FALSE),KEL.typ.epoch Date_First_Seen_ := KEL.era.SimpleRoll(GROUP,Date_First_Seen_,MIN,FALSE),KEL.typ.epoch Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Date_Last_Seen_,MAX,FALSE),KEL.typ.epoch Date_Vendor_First_Reported_ := KEL.era.SimpleRoll(GROUP,Date_Vendor_First_Reported_,MIN,FALSE),KEL.typ.epoch Date_Vendor_Last_Reported_ := KEL.era.SimpleRoll(GROUP,Date_Vendor_Last_Reported_,MAX,FALSE),____grp___U_I_D_,____grp___T_M_S_I_D_,T_M_S_I_D_,Filing_Type_Description_,Amount_,Landlord_Tenant_Dispute_Flag_,My_Date_First_Seen_},____grp___U_I_D_,____grp___T_M_S_I_D_,T_M_S_I_D_,Filing_Type_Description_,Amount_,Landlord_Tenant_Dispute_Flag_,My_Date_First_Seen_,MERGE),__ST213654_Layout);
  SHARED __EE229175 := GROUP(__EE229219,____grp___U_I_D_,____grp___T_M_S_I_D_,ALL);
  SHARED __EE229223 := TOPN(__EE229175(__NN(__EE229175.My_Date_First_Seen_)),1, -__T(__EE229175.My_Date_First_Seen_),__T(____grp___T_M_S_I_D_),__T(Filing_Type_Description_),__T(Amount_),__T(Landlord_Tenant_Dispute_Flag_),__T(____grp___U_I_D_),__T(T_M_S_I_D_));
  SHARED __ST213491_Layout := RECORD
    KEL.typ.nstr T_M_S_I_D_;
    KEL.typ.ntyp(E_Business_Sele().Typ) UID;
    KEL.typ.nstr Filing_Type_Description_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Date_Vendor_First_Reported_ := 0;
    KEL.typ.epoch Date_Vendor_Last_Reported_ := 0;
  END;
  SHARED __ST213491_Layout __ND213839__Project(__ST213654_Layout __PP213835) := TRANSFORM
    SELF.T_M_S_I_D_ := __PP213835.____grp___T_M_S_I_D_;
    SELF.UID := __PP213835.____grp___U_I_D_;
    SELF := __PP213835;
  END;
  SHARED __EE227833 := PROJECT(__EE229223,__ND213839__Project(LEFT));
  SHARED __ST213528_Layout := RECORD
    KEL.typ.nstr T_M_S_I_D_;
    KEL.typ.ntyp(E_Business_Sele().Typ) UID;
    KEL.typ.nstr O_N_L_Y___Filing_Type_Description_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Date_Vendor_First_Reported_ := 0;
    KEL.typ.epoch Date_Vendor_Last_Reported_ := 0;
  END;
  SHARED __EE228188 := PROJECT(__EE227833,TRANSFORM(__ST213528_Layout,SELF.O_N_L_Y___Filing_Type_Description_ := LEFT.Filing_Type_Description_,SELF := LEFT));
  SHARED __ST217940_Layout := RECORD
    KEL.typ.ntyp(E_Business_Sele().Typ) Sele_;
    KEL.typ.ntyp(E_Lien_Judgment().Typ) Lien_;
    KEL.typ.nint Ult_I_D_;
    KEL.typ.nint Org_I_D_;
    KEL.typ.nint Sele_I_D_;
    KEL.typ.nstr T_M_S_I_D_;
    KEL.typ.nstr R_M_S_I_D_;
    KEL.typ.ndataset(B_Sele_Lien_Judgment_11(__in,__cfg).__ST171107_Layout) Details_;
    KEL.typ.ndataset(E_Sele_Lien_Judgment(__in,__cfg).Data_Sources_Layout) Data_Sources_;
    KEL.typ.ndataset(B_Sele_Lien_Judgment_11(__in,__cfg).__ST76934_Layout) Gather_Liens_;
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
    KEL.typ.epoch Date_Vendor_First_Reported_ := 0;
    KEL.typ.epoch Date_Vendor_Last_Reported_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  __JC229855(__ST217847_Layout __EE229845, __ST213528_Layout __EE228188) := __EEQP(__EE229845.T_M_S_I_D_,__EE228188.T_M_S_I_D_) AND __EEQP(__EE229845.UID,__EE228188.UID);
  __ST217940_Layout __JT229855(__ST217847_Layout __l, __ST213528_Layout __r) := TRANSFORM
    SELF.T_M_S_I_D__4_ := __r.T_M_S_I_D_;
    SELF.U_I_D__3_ := __r.UID;
    SELF := __l;
    SELF := __r;
  END;
  SHARED __EE229898 := JOIN(__EE229845,__EE228188,__JC229855(LEFT,RIGHT),__JT229855(LEFT,RIGHT),LEFT OUTER,SMART,KEEP(1));
  SHARED __ST218037_Layout := RECORD
    KEL.typ.ntyp(E_Business_Sele().Typ) Sele_;
    KEL.typ.ntyp(E_Lien_Judgment().Typ) Lien_;
    KEL.typ.nint Ult_I_D_;
    KEL.typ.nint Org_I_D_;
    KEL.typ.nint Sele_I_D_;
    KEL.typ.nstr T_M_S_I_D_;
    KEL.typ.nstr R_M_S_I_D_;
    KEL.typ.ndataset(B_Sele_Lien_Judgment_11(__in,__cfg).__ST171107_Layout) Details_;
    KEL.typ.ndataset(E_Sele_Lien_Judgment(__in,__cfg).Data_Sources_Layout) Data_Sources_;
    KEL.typ.ndataset(B_Sele_Lien_Judgment_11(__in,__cfg).__ST76934_Layout) Gather_Liens_;
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
    KEL.typ.epoch Date_Vendor_First_Reported_ := 0;
    KEL.typ.epoch Date_Vendor_Last_Reported_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  SHARED __EE227852 := __EE227848;
  SHARED __EE229903 := __EE227852(__T(__OP2(__EE227852.Landlord_Tenant_Dispute_Flag_,=,__CN('Y'))));
  __JC229917(__ST217940_Layout __EE229898, __ST212928_Layout __EE229903) := __EEQP(__EE229898.T_M_S_I_D_,__EE229903.T_M_S_I_D_) AND __EEQP(__EE229898.UID,__EE229903.UID);
  __JF229917(__ST212928_Layout __EE229903) := __NN(__EE229903.T_M_S_I_D_) OR __NN(__EE229903.UID);
  SHARED __EE229957 := JOIN(__EE229898,__EE229903,__JC229917(LEFT,RIGHT),TRANSFORM(__ST218037_Layout,SELF:=LEFT,SELF.Exp1_:=__JF229917(RIGHT)),HASH,LEFT OUTER,KEEP(1));
  SHARED __ST226795_Layout := RECORD
    KEL.typ.nuid UID;
    KEL.typ.nint Ult_I_D_;
    KEL.typ.nint Org_I_D_;
    KEL.typ.nint Sele_I_D_;
    KEL.typ.ntyp(E_Business_Org().Typ) Sele_Org_;
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
    KEL.typ.ndataset(E_Business_Sele(__in,__cfg).Vendor_Identification_Layout) Vendor_Identification_;
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
    KEL.typ.ndataset(E_Business_Sele(__in,__cfg).S_O_S_Company_Types_Layout) S_O_S_Company_Types_;
    KEL.typ.ndataset(E_Business_Sele(__in,__cfg).S_O_S_Registered_Agents_Layout) S_O_S_Registered_Agents_;
    KEL.typ.ndataset(E_Business_Sele(__in,__cfg).S_O_S_Statuses_Layout) S_O_S_Statuses_;
    KEL.typ.ndataset(E_Business_Sele(__in,__cfg).S_O_S_Incorporation_Details_Layout) S_O_S_Incorporation_Details_;
    KEL.typ.ndataset(E_Business_Sele(__in,__cfg).S_O_S_Charter_Numbers_Layout) S_O_S_Charter_Numbers_;
    KEL.typ.ndataset(E_Business_Sele(__in,__cfg).S_O_S_Term_Exist_Codes_Layout) S_O_S_Term_Exist_Codes_;
    KEL.typ.ndataset(E_Business_Sele(__in,__cfg).Government_Debarred_Layout) Government_Debarred_;
    KEL.typ.ndataset(E_Business_Sele(__in,__cfg).Non_Profit_Layout) Non_Profit_;
    KEL.typ.ndataset(E_Business_Sele(__in,__cfg).Retirement_Plan_Information_Layout) Retirement_Plan_Information_;
    KEL.typ.ndataset(E_Business_Sele(__in,__cfg).Processing_Dates_Layout) Processing_Dates_;
    KEL.typ.ndataset(E_Business_Sele(__in,__cfg).Business_Registration_Layout) Business_Registration_;
    KEL.typ.ndataset(E_Business_Sele(__in,__cfg).Best_Company_Names_Layout) Best_Company_Names_;
    KEL.typ.ndataset(E_Business_Sele(__in,__cfg).Best_S_I_C_Codes_Layout) Best_S_I_C_Codes_;
    KEL.typ.ndataset(E_Business_Sele(__in,__cfg).Best_N_A_I_C_S_Codes_Layout) Best_N_A_I_C_S_Codes_;
    KEL.typ.ndataset(E_Business_Sele(__in,__cfg).Business_Characteristics_Layout) Business_Characteristics_;
    KEL.typ.ndataset(E_Business_Sele(__in,__cfg).Experian_C_R_D_B_Tradelines_Layout) Experian_C_R_D_B_Tradelines_;
    KEL.typ.ndataset(E_Business_Sele(__in,__cfg).Data_Sources_Layout) Data_Sources_;
    KEL.typ.ntyp(E_Business_Sele().Typ) U_I_D__1_;
    KEL.typ.ntyp(E_Input_B_I_I().Typ) O_N_L_Y___U_I_D_;
    KEL.typ.ndataset(__ST218037_Layout) Sele_Lien_Judgment_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Date_Vendor_First_Reported_ := 0;
    KEL.typ.epoch Date_Vendor_Last_Reported_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  __JC229963(__ST218380_Layout __EE229356, __ST218037_Layout __EE229957) := __EEQP(__EE229356.UID,__EE229957.UID);
  __ST226795_Layout __Join__ST226795_Layout(__ST218380_Layout __r, DATASET(__ST218037_Layout) __recs) := TRANSFORM
    SELF := __r;
    SELF.Sele_Lien_Judgment_ := __CN(__recs);
  END;
  SHARED __EE230218 := DENORMALIZE(DISTRIBUTE(__EE229356,HASH(UID)),DISTRIBUTE(__EE229957,HASH(UID)),__JC229963(LEFT,RIGHT),GROUP,__Join__ST226795_Layout(LEFT,ROWS(RIGHT)),LOCAL);
  EXPORT __ST170360_Layout := RECORD
    KEL.typ.nint S_I_C_Code_;
    KEL.typ.nint S_I_C_Code_Order_;
    KEL.typ.nstr Source_;
    KEL.typ.nbool Header_Hit_Flag_;
    KEL.typ.nint Days_Since_Code_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Date_Vendor_First_Reported_ := 0;
    KEL.typ.epoch Date_Vendor_Last_Reported_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  EXPORT __ST170368_Layout := RECORD
    KEL.typ.nint N_A_I_C_S_Code_;
    KEL.typ.nint N_A_I_C_S_Code_Order_;
    KEL.typ.nstr Source_;
    KEL.typ.nbool Header_Hit_Flag_;
    KEL.typ.nint Days_Since_Code_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Date_Vendor_First_Reported_ := 0;
    KEL.typ.epoch Date_Vendor_Last_Reported_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  EXPORT __ST77013_Layout := RECORD
    KEL.typ.nstr T_M_S_I_D_;
    KEL.typ.nstr Filing_Type_Description_;
    KEL.typ.nint Amount_;
    KEL.typ.bool Landlord_Tenant_Dispute_Flag_ := FALSE;
    KEL.typ.nkdate Original_Filing_Date_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Date_Vendor_First_Reported_ := 0;
    KEL.typ.epoch Date_Vendor_Last_Reported_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  EXPORT __ST170297_Layout := RECORD
    KEL.typ.nuid UID;
    KEL.typ.nint Ult_I_D_;
    KEL.typ.nint Org_I_D_;
    KEL.typ.nint Sele_I_D_;
    KEL.typ.ntyp(E_Business_Org().Typ) Sele_Org_;
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
    KEL.typ.ndataset(E_Business_Sele(__in,__cfg).Vendor_Identification_Layout) Vendor_Identification_;
    KEL.typ.ndataset(__ST170360_Layout) S_I_C_Codes_;
    KEL.typ.ndataset(__ST170368_Layout) N_A_I_C_S_Codes_;
    KEL.typ.ndataset(E_Business_Sele(__in,__cfg).Employee_Counts_Layout) Employee_Counts_;
    KEL.typ.ndataset(E_Business_Sele(__in,__cfg).Sale_Amounts_Layout) Sale_Amounts_;
    KEL.typ.ndataset(E_Business_Sele(__in,__cfg).Earning_Amounts_Layout) Earning_Amounts_;
    KEL.typ.ndataset(E_Business_Sele(__in,__cfg).Asset_Amounts_Layout) Asset_Amounts_;
    KEL.typ.nkdate B_B_B_Member_Since_;
    KEL.typ.ndataset(E_Business_Sele(__in,__cfg).B_B_B_Categories_Layout) B_B_B_Categories_;
    KEL.typ.nstr For_Profit_Indicator_;
    KEL.typ.nstr Public_Or_Private_Indicator_;
    KEL.typ.ndataset(E_Business_Sele(__in,__cfg).S_O_S_Company_Types_Layout) S_O_S_Company_Types_;
    KEL.typ.ndataset(E_Business_Sele(__in,__cfg).S_O_S_Registered_Agents_Layout) S_O_S_Registered_Agents_;
    KEL.typ.ndataset(E_Business_Sele(__in,__cfg).S_O_S_Statuses_Layout) S_O_S_Statuses_;
    KEL.typ.ndataset(E_Business_Sele(__in,__cfg).S_O_S_Incorporation_Details_Layout) S_O_S_Incorporation_Details_;
    KEL.typ.ndataset(E_Business_Sele(__in,__cfg).S_O_S_Charter_Numbers_Layout) S_O_S_Charter_Numbers_;
    KEL.typ.ndataset(E_Business_Sele(__in,__cfg).S_O_S_Term_Exist_Codes_Layout) S_O_S_Term_Exist_Codes_;
    KEL.typ.ndataset(E_Business_Sele(__in,__cfg).Government_Debarred_Layout) Government_Debarred_;
    KEL.typ.ndataset(E_Business_Sele(__in,__cfg).Non_Profit_Layout) Non_Profit_;
    KEL.typ.ndataset(E_Business_Sele(__in,__cfg).Retirement_Plan_Information_Layout) Retirement_Plan_Information_;
    KEL.typ.ndataset(E_Business_Sele(__in,__cfg).Processing_Dates_Layout) Processing_Dates_;
    KEL.typ.ndataset(E_Business_Sele(__in,__cfg).Business_Registration_Layout) Business_Registration_;
    KEL.typ.ndataset(E_Business_Sele(__in,__cfg).Best_Company_Names_Layout) Best_Company_Names_;
    KEL.typ.ndataset(E_Business_Sele(__in,__cfg).Best_S_I_C_Codes_Layout) Best_S_I_C_Codes_;
    KEL.typ.ndataset(E_Business_Sele(__in,__cfg).Best_N_A_I_C_S_Codes_Layout) Best_N_A_I_C_S_Codes_;
    KEL.typ.ndataset(E_Business_Sele(__in,__cfg).Business_Characteristics_Layout) Business_Characteristics_;
    KEL.typ.ndataset(E_Business_Sele(__in,__cfg).Experian_C_R_D_B_Tradelines_Layout) Experian_C_R_D_B_Tradelines_;
    KEL.typ.ndataset(E_Business_Sele(__in,__cfg).Data_Sources_Layout) Data_Sources_;
    KEL.typ.ndataset(__ST77013_Layout) All_Lien_Data_;
    KEL.typ.ntyp(E_Input_B_I_I().Typ) B_I_I_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Date_Vendor_First_Reported_ := 0;
    KEL.typ.epoch Date_Vendor_Last_Reported_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  SHARED __ST170297_Layout __ND230235__Project(__ST226795_Layout __PP230231) := TRANSFORM
    __EE230221 := __PP230231.S_I_C_Codes_;
    __ST170360_Layout __ND230484__Project(E_Business_Sele(__in,__cfg).S_I_C_Codes_Layout __PP230480) := TRANSFORM
      __CC9279 := KEL.Routines.MinN(FN_Compile(__cfg).FN_G_E_T_B_U_I_L_D_D_A_T_E(__ECAST(KEL.typ.nstr,__CN('Corp_build_version'))),__CN(__cfg.CurrentDate));
      SELF.Days_Since_Code_ := __FN2(KEL.Routines.DaysBetween,KEL.era.ToDate(__PP230480.Date_First_Seen_),__CC9279);
      SELF := __PP230480;
    END;
    SELF.S_I_C_Codes_ := __PROJECT(__EE230221,__ND230484__Project(LEFT));
    __EE230225 := __PP230231.N_A_I_C_S_Codes_;
    __ST170368_Layout __ND230513__Project(E_Business_Sele(__in,__cfg).N_A_I_C_S_Codes_Layout __PP230509) := TRANSFORM
      __CC9279 := KEL.Routines.MinN(FN_Compile(__cfg).FN_G_E_T_B_U_I_L_D_D_A_T_E(__ECAST(KEL.typ.nstr,__CN('Corp_build_version'))),__CN(__cfg.CurrentDate));
      SELF.Days_Since_Code_ := __FN2(KEL.Routines.DaysBetween,KEL.era.ToDate(__PP230509.Date_First_Seen_),__CC9279);
      SELF := __PP230509;
    END;
    SELF.N_A_I_C_S_Codes_ := __PROJECT(__EE230225,__ND230513__Project(LEFT));
    __EE230229 := __PP230231.Sele_Lien_Judgment_;
    __ST77013_Layout __ND230592__Project(__ST218037_Layout __PP230588) := TRANSFORM
      SELF.Filing_Type_Description_ := __PP230588.O_N_L_Y___Filing_Type_Description_;
      SELF.Amount_ := __PP230588.O_N_L_Y___Amount_;
      SELF.Landlord_Tenant_Dispute_Flag_ := __PP230588.Exp1_;
      SELF.Original_Filing_Date_ := __PP230588.O_N_L_Y___My_Date_First_Seen_;
      SELF := __PP230588;
    END;
    SELF.All_Lien_Data_ := __BN(PROJECT(TABLE(PROJECT(__T(__EE230229),__ND230592__Project(LEFT)),{KEL.typ.int __RecordCount := SUM(GROUP,__RecordCount),KEL.typ.epoch Archive___Date_ := KEL.era.SimpleRoll(GROUP,Archive___Date_,MIN,FALSE),KEL.typ.epoch Date_First_Seen_ := KEL.era.SimpleRoll(GROUP,Date_First_Seen_,MIN,FALSE),KEL.typ.epoch Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Date_Last_Seen_,MAX,FALSE),KEL.typ.epoch Date_Vendor_First_Reported_ := KEL.era.SimpleRoll(GROUP,Date_Vendor_First_Reported_,MIN,FALSE),KEL.typ.epoch Date_Vendor_Last_Reported_ := KEL.era.SimpleRoll(GROUP,Date_Vendor_Last_Reported_,MAX,FALSE),T_M_S_I_D_,Filing_Type_Description_,Amount_,Landlord_Tenant_Dispute_Flag_,Original_Filing_Date_},T_M_S_I_D_,Filing_Type_Description_,Amount_,Landlord_Tenant_Dispute_Flag_,Original_Filing_Date_,MERGE),__ST77013_Layout),__NL(__EE230229));
    SELF.B_I_I_ := __PP230231.O_N_L_Y___U_I_D_;
    SELF := __PP230231;
  END;
  EXPORT __ENH_Business_Sele_10 := PROJECT(PROJECT(__EE230218,__ND230235__Project(LEFT)),__ST170297_Layout);
END;
