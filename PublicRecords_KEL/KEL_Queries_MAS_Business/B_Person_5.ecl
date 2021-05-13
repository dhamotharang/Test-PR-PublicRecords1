//HPCC Systems KEL Compiler Version 1.6.0
IMPORT KEL16 AS KEL;
IMPORT B_Person_6,CFG_Compile,E_Person,FN_Compile FROM PublicRecords_KEL.KEL_Queries_MAS_Business;
IMPORT * FROM KEL16.Null;
EXPORT B_Person_5(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE
  SHARED VIRTUAL TYPEOF(B_Person_6(__in,__cfg).__ENH_Person_6) __ENH_Person_6 := B_Person_6(__in,__cfg).__ENH_Person_6;
  SHARED __EE1989373 := __ENH_Person_6;
  EXPORT __ST211993_Layout := RECORD
    KEL.typ.nkdate Date_Of_Birth_;
    KEL.typ.nstr Date_Of_Birth_Padded_;
    KEL.typ.nbool Header_Hit_Flag_;
    KEL.typ.nbool Best_;
    KEL.typ.nstr Valid_D_O_B_;
    KEL.typ.nbool D_O_B_Best_Not_Null_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  EXPORT __ST422254_Layout := RECORD
    KEL.typ.nstr T_M_S_I_D_;
    KEL.typ.nstr Filing_Type_Description_;
    KEL.typ.nint Amount_;
    KEL.typ.bool Landlord_Tenant_Dispute_Flag_ := FALSE;
    KEL.typ.nkdate Original_Filing_Date_;
    KEL.typ.nint Age_In_Days_;
    KEL.typ.nbool Is_Civil_Court_Judgment_;
    KEL.typ.nbool Is_Federal_Tax_Lien_;
    KEL.typ.nbool Is_Foreclosure_Judgment_;
    KEL.typ.nbool Is_Other_Lien_;
    KEL.typ.nbool Is_Other_Tax_Lien_;
    KEL.typ.nbool Is_Small_Cliams_Judgment_;
    KEL.typ.nbool Is_State_Tax_Lien_;
    KEL.typ.nbool Is_Total_Tax_Lien_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  EXPORT __ST108592_Layout := RECORD
    KEL.typ.nstr File_Type_;
    KEL.typ.nstr College_Code_;
    KEL.typ.nstr College_Type_;
    KEL.typ.nstr College_Code_Convert_;
    KEL.typ.nstr Source_Date_First_Seen_;
    KEL.typ.nstr Source_Date_Last_Seen_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  EXPORT __ST211976_Layout := RECORD
    KEL.typ.nuid UID;
    KEL.typ.nstr Lex_I_D_Segment_;
    KEL.typ.nstr Lex_I_D_Segment2_;
    KEL.typ.ndataset(E_Person(__in,__cfg).Full_Name_Layout) Full_Name_;
    KEL.typ.ndataset(__ST211993_Layout) Reported_Dates_Of_Birth_;
    KEL.typ.ndataset(E_Person(__in,__cfg).Reported_Dates_Of_Death_Layout) Reported_Dates_Of_Death_;
    KEL.typ.ndataset(E_Person(__in,__cfg).Data_Sources_Layout) Data_Sources_;
    KEL.typ.ndataset(E_Person(__in,__cfg).Conceal_Carry_Layout) Conceal_Carry_;
    KEL.typ.ndataset(E_Person(__in,__cfg).Hunt_Fish_Layout) Hunt_Fish_;
    KEL.typ.ndataset(E_Person(__in,__cfg).Consumer_Statement_Flags_Layout) Consumer_Statement_Flags_;
    KEL.typ.ndataset(E_Person(__in,__cfg).Thrive_Layout) Thrive_;
    KEL.typ.ndataset(__ST422254_Layout) All_Lien_Data_;
    KEL.typ.ndataset(__ST108592_Layout) Edu_Rec_Ver_Source_List_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  SHARED __ST211976_Layout __ND1989234__Project(B_Person_6(__in,__cfg).__ST215508_Layout __PP1988681) := TRANSFORM
    __EE1989376 := __PP1988681.Reported_Dates_Of_Birth_;
    __ST211993_Layout __ND1989095__Project(E_Person(__in,__cfg).Reported_Dates_Of_Birth_Layout __PP1988759) := TRANSFORM
      SELF.D_O_B_Best_Not_Null_ := __AND(__OP2(__PP1988759.Best_,=,__CN(TRUE)),__NOT(__NT(__PP1988759.Date_Of_Birth_)));
      SELF := __PP1988759;
    END;
    SELF.Reported_Dates_Of_Birth_ := __PROJECT(__EE1989376,__ND1989095__Project(LEFT));
    __EE1989232 := __PP1988681.All_Lien_Data_;
    __ST422254_Layout __ND1989108__Project(B_Person_6(__in,__cfg).__ST359190_Layout __PP1988809) := TRANSFORM
      __CC13400 := KEL.Routines.MinN(FN_Compile(__cfg).FN_G_E_T_B_U_I_L_D_D_A_T_E(__ECAST(KEL.typ.nstr,__CN('liens_build_version'))),__CN(__cfg.CurrentDate));
      SELF.Age_In_Days_ := FN_Compile(__cfg).FN_A_B_S_D_A_Y_S_B_E_T_W_E_E_N(__ECAST(KEL.typ.nkdate,__PP1988809.Original_Filing_Date_),__ECAST(KEL.typ.nkdate,__CC13400));
      __CC33960 := ['CIVIL JUDGMENT','CIVIL JUDGMENT RELEASE','CIVIL SPECIAL JUDGMENT','CIVIL SPECIAL JUDGMENT RELEASE','FEDERAL COURT JUDGMENT','JUDGMENT','JUDGMENTS','JUDGMENTS DOCKET','RENEW/REOPEN CIVIL JUDGMENT','SATISFACTION OF JUDGMENT','SATISFIED JUDGMENT','SUBSEQUENT JUDGMENT','DOMESTIC JUDGMENT IN DIVORCE','DOMESTIC RELEASE IN DIVORCE'];
      SELF.Is_Civil_Court_Judgment_ := __AND(__CN(__PP1988809.Landlord_Tenant_Dispute_Flag_ = FALSE),__OP2(__PP1988809.Filing_Type_Description_,IN,__CN(__CC33960)));
      __CC33964 := ['FORECLOSURE (JUDGMENT)','FORECLOSURE SATISFIED'];
      SELF.Is_Foreclosure_Judgment_ := __AND(__CN(__PP1988809.Landlord_Tenant_Dispute_Flag_ = FALSE),__OP2(__PP1988809.Filing_Type_Description_,IN,__CN(__CC33964)));
      __CC33944 := ['BUILDING LIEN','BUILDING LIEN RELEASE','BUILDING RELEASE','CHILD SUPPORT LIEN','CHILD SUPPORT PAYMENT','CHILD SUPPORT PAYMENT RELEASE','JUDGEMENT LIEN','JUDGMENT LIEN RELEASE','SIDEWALK LIEN','SIDEWALK LIEN RELEASE','SIDEWALK RELEASE','WELFARE LIEN'];
      SELF.Is_Other_Lien_ := __AND(__CN(__PP1988809.Landlord_Tenant_Dispute_Flag_ = FALSE),__OP2(__PP1988809.Filing_Type_Description_,IN,__CN(__CC33944)));
      __CC33969 := ['RENEW/REOPEN SMALL CLAIM JUDGM','SMALL CLAIMS JUDGMENT','SMALL CLAIMS JUDGMENT RELEASE'];
      SELF.Is_Small_Cliams_Judgment_ := __AND(__CN(__PP1988809.Landlord_Tenant_Dispute_Flag_ = FALSE),__OP2(__PP1988809.Filing_Type_Description_,IN,__CN(__CC33969)));
      SELF.Is_Total_Tax_Lien_ := __OR(__OR(__PP1988809.Is_Federal_Tax_Lien_,__PP1988809.Is_State_Tax_Lien_),__PP1988809.Is_Other_Tax_Lien_);
      SELF := __PP1988809;
    END;
    SELF.All_Lien_Data_ := __PROJECT(__EE1989232,__ND1989108__Project(LEFT));
    __EE1989379 := __PP1988681.Edu_Rec_Ver_Source_List_Pre_;
    __ST108592_Layout __ND1989239__Project(B_Person_6(__in,__cfg).__ST108530_Layout __PP1989235) := TRANSFORM
      SELF.College_Code_Convert_ := MAP(__T(__OP2(__PP1989235.College_Code_,=,__CN('1')))=>__ECAST(KEL.typ.nstr,__CN('3')),__T(__OP2(__PP1989235.College_Code_,=,__CN('2')))=>__ECAST(KEL.typ.nstr,__CN('1')),__T(__OP2(__PP1989235.College_Code_,=,__CN('4')))=>__ECAST(KEL.typ.nstr,__CN('2')),__N(KEL.typ.str));
      __CC14096 := '-99997';
      SELF.Source_Date_First_Seen_ := IF(__T(__FN1(KEL.Routines.IsValidDate,__PP1989235.Date_First_Seen_Min_)),__ECAST(KEL.typ.nstr,__FN2(KEL.Routines.DateToString,__PP1989235.Date_First_Seen_Min_,__CN('%Y%m%d'))),__ECAST(KEL.typ.nstr,__CN(__CC14096)));
      SELF.Source_Date_Last_Seen_ := IF(__T(__FN1(KEL.Routines.IsValidDate,__PP1989235.Date_Last_Seen_Max_)),__ECAST(KEL.typ.nstr,__FN2(KEL.Routines.DateToString,KEL.Routines.MinN(__PP1989235.Date_Last_Seen_Max_,__PP1988681.B_U_I_L_D___D_A_T_E_),__CN('%Y%m%d'))),__ECAST(KEL.typ.nstr,__CN(__CC14096)));
      SELF := __PP1989235;
    END;
    SELF.Edu_Rec_Ver_Source_List_ := __PROJECT(__EE1989379,__ND1989239__Project(LEFT));
    SELF := __PP1988681;
  END;
  EXPORT __ENH_Person_5 := PROJECT(__EE1989373,__ND1989234__Project(LEFT));
END;
