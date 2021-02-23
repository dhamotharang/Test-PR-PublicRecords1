//HPCC Systems KEL Compiler Version 1.5.0rc1
IMPORT KEL15 AS KEL;
IMPORT B_Person_10,CFG_Compile,E_Person,FN_Compile FROM PublicRecords_KEL;
IMPORT * FROM KEL15.Null;
EXPORT B_Person_9(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE
  SHARED VIRTUAL TYPEOF(B_Person_10(__in,__cfg).__ENH_Person_10) __ENH_Person_10 := B_Person_10(__in,__cfg).__ENH_Person_10;
  SHARED __EE5066789 := __ENH_Person_10;
  EXPORT __ST342969_Layout := RECORD
    KEL.typ.nstr T_M_S_I_D_;
    KEL.typ.nstr Filing_Type_Description_;
    KEL.typ.nint Amount_;
    KEL.typ.bool Landlord_Tenant_Dispute_Flag_ := FALSE;
    KEL.typ.nkdate Original_Filing_Date_;
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
  EXPORT __ST264343_Layout := RECORD
    KEL.typ.nuid UID;
    KEL.typ.nstr Gender_;
    KEL.typ.nstr Lex_I_D_Segment_;
    KEL.typ.nstr Lex_I_D_Segment2_;
    KEL.typ.ndataset(E_Person(__in,__cfg).Full_Name_Layout) Full_Name_;
    KEL.typ.ndataset(E_Person(__in,__cfg).Reported_Dates_Of_Birth_Layout) Reported_Dates_Of_Birth_;
    KEL.typ.ndataset(E_Person(__in,__cfg).Reported_Dates_Of_Death_Layout) Reported_Dates_Of_Death_;
    KEL.typ.nstr Race_;
    KEL.typ.nstr Race_Description_;
    KEL.typ.ndataset(E_Person(__in,__cfg).Data_Sources_Layout) Data_Sources_;
    KEL.typ.ndataset(E_Person(__in,__cfg).Dunn_Data_Layout) Dunn_Data_;
    KEL.typ.ndataset(E_Person(__in,__cfg).Conceal_Carry_Layout) Conceal_Carry_;
    KEL.typ.ndataset(E_Person(__in,__cfg).Hunt_Fish_Layout) Hunt_Fish_;
    KEL.typ.ndataset(E_Person(__in,__cfg).Consumer_Statement_Flags_Layout) Consumer_Statement_Flags_;
    KEL.typ.ndataset(E_Person(__in,__cfg).Thrive_Layout) Thrive_;
    KEL.typ.ndataset(B_Person_10(__in,__cfg).__ST79328_Layout) Address_Hierarchy_Set_;
    KEL.typ.ndataset(__ST342969_Layout) All_Lien_Data_;
    KEL.typ.ndataset(B_Person_10(__in,__cfg).__ST79328_Layout) Recent_Addr_Full_Set_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  SHARED __ST264343_Layout __ND5066591__Project(B_Person_10(__in,__cfg).__ST328609_Layout __PP5065753) := TRANSFORM
    __EE5066589 := __PP5065753.All_Lien_Data_;
    __ST342969_Layout __ND5066394__Project(B_Person_10(__in,__cfg).__ST326527_Layout __PP5065924) := TRANSFORM
      __CC31851 := ['CIVIL JUDGMENT','CIVIL JUDGMENT RELEASE','CIVIL SPECIAL JUDGMENT','CIVIL SPECIAL JUDGMENT RELEASE','FEDERAL COURT JUDGMENT','JUDGMENT','JUDGMENTS','JUDGMENTS DOCKET','RENEW/REOPEN CIVIL JUDGMENT','SATISFACTION OF JUDGMENT','SATISFIED JUDGMENT','SUBSEQUENT JUDGMENT','DOMESTIC JUDGMENT IN DIVORCE','DOMESTIC RELEASE IN DIVORCE'];
      SELF.Is_Civil_Court_Judgment_ := __AND(__CN(__PP5065924.Landlord_Tenant_Dispute_Flag_ = FALSE),__OP2(__PP5065924.Filing_Type_Description_,IN,__CN(__CC31851)));
      __CC31855 := ['FORECLOSURE (JUDGMENT)','FORECLOSURE SATISFIED'];
      SELF.Is_Foreclosure_Judgment_ := __AND(__CN(__PP5065924.Landlord_Tenant_Dispute_Flag_ = FALSE),__OP2(__PP5065924.Filing_Type_Description_,IN,__CN(__CC31855)));
      __CC31835 := ['BUILDING LIEN','BUILDING LIEN RELEASE','BUILDING RELEASE','CHILD SUPPORT LIEN','CHILD SUPPORT PAYMENT','CHILD SUPPORT PAYMENT RELEASE','JUDGEMENT LIEN','JUDGMENT LIEN RELEASE','SIDEWALK LIEN','SIDEWALK LIEN RELEASE','SIDEWALK RELEASE','WELFARE LIEN'];
      SELF.Is_Other_Lien_ := __AND(__CN(__PP5065924.Landlord_Tenant_Dispute_Flag_ = FALSE),__OP2(__PP5065924.Filing_Type_Description_,IN,__CN(__CC31835)));
      __CC31860 := ['RENEW/REOPEN SMALL CLAIM JUDGM','SMALL CLAIMS JUDGMENT','SMALL CLAIMS JUDGMENT RELEASE'];
      SELF.Is_Small_Cliams_Judgment_ := __AND(__CN(__PP5065924.Landlord_Tenant_Dispute_Flag_ = FALSE),__OP2(__PP5065924.Filing_Type_Description_,IN,__CN(__CC31860)));
      SELF.Is_Total_Tax_Lien_ := __OR(__OR(__PP5065924.Is_Federal_Tax_Lien_,__PP5065924.Is_State_Tax_Lien_),__PP5065924.Is_Other_Tax_Lien_);
      SELF := __PP5065924;
    END;
    SELF.All_Lien_Data_ := __PROJECT(__EE5066589,__ND5066394__Project(LEFT));
    __EE5066609 := __PP5065753.Address_Hierarchy_Set_;
    __CC22687 := [0,91,92,93,94,95,96,97,98,99];
    __BS5066610 := __T(__EE5066609);
    __EE5066646 := __BS5066610(__T(__AND(__CN(FN_Compile(__cfg).FN_Is_Not_Enough_To_Clean(__ECAST(KEL.typ.nstr,__T(__EE5066609).Address_Rank_)) = FALSE),__AND(__NOT(__OP2(__T(__EE5066609).Address_Rank_,IN,__CN(__CC22687))),__AND(__OR(__OP2(__T(__EE5066609).Address_Type_,<>,__CN('BUS')),__NT(__T(__EE5066609).Address_Type_)),__OR(__OP2(__T(__EE5066609).Addr1_From_Components_,<>,__CN('P')),__NT(__T(__EE5066609).Addr1_From_Components_)))))));
    __EE5066650 := TOPN(__EE5066646(__NN(__EE5066646.Address_Rank_) AND __NN(__EE5066646.Sort_Field_)),2,__T(__EE5066646.Address_Rank_), -__T(__EE5066646.Sort_Field_),__T(Address_Type_),__T(Address_Status_),__T(State_Code_),__T(County_Code_),__T(Latitude_),__T(Longitude_),__T(Geo_Blk_),__T(Addr_Full_),__T(Primary_Range_),__T(Predirectional_),__T(Primary_Name_),__T(Suffix_),__T(Postdirectional_),__T(Unit_Designation_),__T(Secondary_Range_),__T(Postal_City_),__T(State_),__T(Z_I_P5_),__T(Z_I_P4_),__T(Addr1_From_Components_),__T(Hierarchy_Date_First_Seen_),__T(Hierarchy_Date_Last_Seen_));
    SELF.Recent_Addr_Full_Set_ := __CN(__EE5066650);
    SELF := __PP5065753;
  END;
  EXPORT __ENH_Person_9 := PROJECT(__EE5066789,__ND5066591__Project(LEFT));
END;
