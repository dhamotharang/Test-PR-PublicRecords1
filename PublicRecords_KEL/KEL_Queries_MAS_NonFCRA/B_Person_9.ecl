﻿//HPCC Systems KEL Compiler Version 1.6.0
IMPORT KEL16 AS KEL;
IMPORT B_Person_10,CFG_Compile,E_Person FROM PublicRecords_KEL.KEL_Queries_MAS_NonFCRA;
IMPORT * FROM KEL16.Null;
EXPORT B_Person_9(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE
  SHARED VIRTUAL TYPEOF(B_Person_10(__in,__cfg).__ENH_Person_10) __ENH_Person_10 := B_Person_10(__in,__cfg).__ENH_Person_10;
  SHARED __EE1577464 := __ENH_Person_10;
  EXPORT __ST225693_Layout := RECORD
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
  EXPORT __ST188142_Layout := RECORD
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
    KEL.typ.ndataset(__ST225693_Layout) All_Lien_Data_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  SHARED __ST188142_Layout __ND1577390__Project(B_Person_10(__in,__cfg).__ST188438_Layout __PP1576961) := TRANSFORM
    __EE1577388 := __PP1576961.All_Lien_Data_;
    __ST225693_Layout __ND1577285__Project(B_Person_10(__in,__cfg).__ST223196_Layout __PP1577058) := TRANSFORM
      __CC35217 := ['CIVIL JUDGMENT','CIVIL JUDGMENT RELEASE','CIVIL SPECIAL JUDGMENT','CIVIL SPECIAL JUDGMENT RELEASE','FEDERAL COURT JUDGMENT','JUDGMENT','JUDGMENTS','JUDGMENTS DOCKET','RENEW/REOPEN CIVIL JUDGMENT','SATISFACTION OF JUDGMENT','SATISFIED JUDGMENT','SUBSEQUENT JUDGMENT','DOMESTIC JUDGMENT IN DIVORCE','DOMESTIC RELEASE IN DIVORCE'];
      SELF.Is_Civil_Court_Judgment_ := __AND(__CN(__PP1577058.Landlord_Tenant_Dispute_Flag_ = FALSE),__OP2(__PP1577058.Filing_Type_Description_,IN,__CN(__CC35217)));
      __CC35221 := ['FORECLOSURE (JUDGMENT)','FORECLOSURE SATISFIED'];
      SELF.Is_Foreclosure_Judgment_ := __AND(__CN(__PP1577058.Landlord_Tenant_Dispute_Flag_ = FALSE),__OP2(__PP1577058.Filing_Type_Description_,IN,__CN(__CC35221)));
      __CC35201 := ['BUILDING LIEN','BUILDING LIEN RELEASE','BUILDING RELEASE','CHILD SUPPORT LIEN','CHILD SUPPORT PAYMENT','CHILD SUPPORT PAYMENT RELEASE','JUDGEMENT LIEN','JUDGMENT LIEN RELEASE','SIDEWALK LIEN','SIDEWALK LIEN RELEASE','SIDEWALK RELEASE','WELFARE LIEN'];
      SELF.Is_Other_Lien_ := __AND(__CN(__PP1577058.Landlord_Tenant_Dispute_Flag_ = FALSE),__OP2(__PP1577058.Filing_Type_Description_,IN,__CN(__CC35201)));
      __CC35226 := ['RENEW/REOPEN SMALL CLAIM JUDGM','SMALL CLAIMS JUDGMENT','SMALL CLAIMS JUDGMENT RELEASE'];
      SELF.Is_Small_Cliams_Judgment_ := __AND(__CN(__PP1577058.Landlord_Tenant_Dispute_Flag_ = FALSE),__OP2(__PP1577058.Filing_Type_Description_,IN,__CN(__CC35226)));
      SELF.Is_Total_Tax_Lien_ := __OR(__OR(__PP1577058.Is_Federal_Tax_Lien_,__PP1577058.Is_State_Tax_Lien_),__PP1577058.Is_Other_Tax_Lien_);
      SELF := __PP1577058;
    END;
    SELF.All_Lien_Data_ := __PROJECT(__EE1577388,__ND1577285__Project(LEFT));
    SELF := __PP1576961;
  END;
  EXPORT __ENH_Person_9 := PROJECT(__EE1577464,__ND1577390__Project(LEFT));
END;
