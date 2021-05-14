//HPCC Systems KEL Compiler Version 1.6.0
IMPORT KEL16 AS KEL;
IMPORT B_Person_5,CFG_Compile,E_Person FROM PublicRecords_KEL.KEL_Queries_MAS_Business;
IMPORT * FROM KEL16.Null;
EXPORT B_Person_4(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE
  SHARED VIRTUAL TYPEOF(B_Person_5(__in,__cfg).__ENH_Person_5) __ENH_Person_5 := B_Person_5(__in,__cfg).__ENH_Person_5;
  SHARED __EE2117653 := __ENH_Person_5;
  EXPORT __ST207314_Layout := RECORD
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
  EXPORT __ST551562_Layout := RECORD
    KEL.typ.nstr T_M_S_I_D_;
    KEL.typ.nstr Filing_Type_Description_;
    KEL.typ.nint Amount_;
    KEL.typ.bool Landlord_Tenant_Dispute_Flag_ := FALSE;
    KEL.typ.nkdate Original_Filing_Date_;
    KEL.typ.nint Age_In_Days_;
    KEL.typ.nbool Is_Civil_Court_Judgment_;
    KEL.typ.nbool Is_Foreclosure_Judgment_;
    KEL.typ.nbool Is_Landlord_Tenant_Dispute_;
    KEL.typ.nbool Is_Other_Lien_;
    KEL.typ.nbool Is_Over_All_Judgment_;
    KEL.typ.nbool Is_Over_All_Lien_;
    KEL.typ.nbool Is_Small_Cliams_Judgment_;
    KEL.typ.nbool Is_Total_Tax_Lien_;
    KEL.typ.nbool Seen___In___Seven___Years_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  EXPORT __ST207297_Layout := RECORD
    KEL.typ.nuid UID;
    KEL.typ.nstr Lex_I_D_Segment_;
    KEL.typ.nstr Lex_I_D_Segment2_;
    KEL.typ.ndataset(E_Person(__in,__cfg).Full_Name_Layout) Full_Name_;
    KEL.typ.ndataset(__ST207314_Layout) Reported_Dates_Of_Birth_;
    KEL.typ.ndataset(E_Person(__in,__cfg).Reported_Dates_Of_Death_Layout) Reported_Dates_Of_Death_;
    KEL.typ.ndataset(E_Person(__in,__cfg).Data_Sources_Layout) Data_Sources_;
    KEL.typ.ndataset(E_Person(__in,__cfg).Conceal_Carry_Layout) Conceal_Carry_;
    KEL.typ.ndataset(E_Person(__in,__cfg).Hunt_Fish_Layout) Hunt_Fish_;
    KEL.typ.ndataset(E_Person(__in,__cfg).Consumer_Statement_Flags_Layout) Consumer_Statement_Flags_;
    KEL.typ.ndataset(E_Person(__in,__cfg).Thrive_Layout) Thrive_;
    KEL.typ.ndataset(__ST551562_Layout) All_Lien_Data_;
    KEL.typ.ndataset(B_Person_5(__in,__cfg).__ST108632_Layout) Edu_Rec_Ver_Source_List_Sorted_;
    KEL.typ.str P___Lex_I_D_Seen_Flag_ := '';
    KEL.typ.nkdate Select_Age_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  SHARED __ST207297_Layout __ND2117516__Project(B_Person_5(__in,__cfg).__ST211720_Layout __PP2116934) := TRANSFORM
    __EE2117656 := __PP2116934.Reported_Dates_Of_Birth_;
    SELF.Reported_Dates_Of_Birth_ := __BN(PROJECT(__T(__EE2117656),__ST207314_Layout),__NL(__EE2117656));
    __EE2117514 := __PP2116934.All_Lien_Data_;
    __ST551562_Layout __ND2117404__Project(B_Person_5(__in,__cfg).__ST421961_Layout __PP2117065) := TRANSFORM
      __CC33922 := ['FORCIBLE ENTRY/DETAINER','LANDLORD TENANT JUDGMENT','FORCIBLE ENTRY/DETAINER RELEAS','FORCIBLE ENTRY/DETAINER RELEASE'];
      __CC33935 := ['CIVIL NEW FILING','CIVIL SUIT','CIVIL SUMMONS','COURT ORDER','FEDERAL COURT NEW FILING','FORECLOSURE NEW FILING','JUDGMENT - Chapter 7','LANDLORD TENANT SUIT','LIS PENDENS','LIS PENDENS NOTICE','LIS PENDENS RELEASE'];
      SELF.Is_Landlord_Tenant_Dispute_ := __AND(__OR(__CN(__PP2117065.Landlord_Tenant_Dispute_Flag_ = TRUE),__OP2(__PP2117065.Filing_Type_Description_,IN,__CN(__CC33922))),__NOT(__OP2(__PP2117065.Filing_Type_Description_,IN,__CN(__CC33935))));
      SELF.Is_Over_All_Judgment_ := __OR(__OR(__PP2117065.Is_Civil_Court_Judgment_,__PP2117065.Is_Foreclosure_Judgment_),__PP2117065.Is_Small_Cliams_Judgment_);
      SELF.Is_Over_All_Lien_ := __OR(__PP2117065.Is_Total_Tax_Lien_,__PP2117065.Is_Other_Lien_);
      __CC33916 := 2556;
      SELF.Seen___In___Seven___Years_ := __OP2(__PP2117065.Age_In_Days_,<=,__CN(__CC33916));
      SELF := __PP2117065;
    END;
    SELF.All_Lien_Data_ := __PROJECT(__EE2117514,__ND2117404__Project(LEFT));
    __EE2117538 := __PP2116934.Edu_Rec_Ver_Source_List_;
    __CC14058 := '-99997';
    __BS2117521 := __T(__EE2117538);
    __EE2117542 := __BN(TOPN(__BS2117521(__NN(__OP2(__T(__EE2117538).Source_Date_Last_Seen_,=,__CN(__CC14058))) AND __NN(__T(__EE2117538).Source_Date_Last_Seen_) AND __NN(__T(__EE2117538).Source_Date_First_Seen_)),1000,__T(__OP2(__T(__EE2117538).Source_Date_Last_Seen_,=,__CN(__CC14058))),__T(__T(__EE2117538).Source_Date_Last_Seen_),__T(__T(__EE2117538).Source_Date_First_Seen_),__T(College_Code_),__T(College_Type_),__T(File_Type_)),__NL(__EE2117538));
    SELF.Edu_Rec_Ver_Source_List_Sorted_ := __EE2117542;
    __BS2117545 := __T(__PP2116934.Data_Sources_);
    SELF.P___Lex_I_D_Seen_Flag_ := IF(EXISTS(__BS2117545(__T(__T(__PP2116934.Data_Sources_).Header_Hit_Flag_))),'1','0');
    __EE2117565 := __PP2116934.Reported_Dates_Of_Birth_;
    __BS2117566 := __T(__EE2117565);
    __EE2117571 := __BS2117566(__T(__T(__EE2117565).D_O_B_Best_Not_Null_));
    SELF.Select_Age_ := (__EE2117571)[1].Date_Of_Birth_;
    SELF := __PP2116934;
  END;
  EXPORT __ENH_Person_4 := PROJECT(__EE2117653,__ND2117516__Project(LEFT));
END;
