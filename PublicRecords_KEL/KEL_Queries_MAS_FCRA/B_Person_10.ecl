//HPCC Systems KEL Compiler Version 1.6.0
IMPORT KEL16 AS KEL;
IMPORT B_Person_11,CFG_Compile,E_Person FROM PublicRecords_KEL.KEL_Queries_MAS_FCRA;
IMPORT * FROM KEL16.Null;
EXPORT B_Person_10(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE
  SHARED VIRTUAL TYPEOF(B_Person_11(__in,__cfg).__ENH_Person_11) __ENH_Person_11 := B_Person_11(__in,__cfg).__ENH_Person_11;
  SHARED __EE1066499 := __ENH_Person_11;
  EXPORT __ST205868_Layout := RECORD
    KEL.typ.nstr T_M_S_I_D_;
    KEL.typ.nstr Filing_Type_Description_;
    KEL.typ.nint Amount_;
    KEL.typ.bool Landlord_Tenant_Dispute_Flag_ := FALSE;
    KEL.typ.nkdate Original_Filing_Date_;
    KEL.typ.nbool Is_Federal_Tax_Lien_;
    KEL.typ.nbool Is_Other_Tax_Lien_;
    KEL.typ.nbool Is_State_Tax_Lien_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  EXPORT __ST174202_Layout := RECORD
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
    KEL.typ.ndataset(__ST205868_Layout) All_Lien_Data_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  SHARED __ST174202_Layout __ND1066425__Project(B_Person_11(__in,__cfg).__ST174429_Layout __PP1066039) := TRANSFORM
    __EE1066423 := __PP1066039.All_Lien_Data_;
    __ST205868_Layout __ND1066329__Project(B_Person_11(__in,__cfg).__ST91971_Layout __PP1066136) := TRANSFORM
      __CC33979 := ['CORRECTED FEDERAL TAX LIEN','FEDERAL TAX LIEN','FEDERAL TAX LIEN RELEASE','FEDERAL TAX RELEASE'];
      SELF.Is_Federal_Tax_Lien_ := __AND(__CN(__PP1066136.Landlord_Tenant_Dispute_Flag_ = FALSE),__OP2(__PP1066136.Filing_Type_Description_,IN,__CN(__CC33979)));
      __CC34000 := ['CITY TAX LIEN','COUNTY TAX LIEN','COUNTY TAX LIEN RELEASE','CITY TAX LIEN RELEASE','ILLINOIS TAX LIEN','ILLINOIS TAX RELEASE','PROPERTY TAX LIEN','PROPERTY TAX RELEASE'];
      SELF.Is_Other_Tax_Lien_ := __AND(__CN(__PP1066136.Landlord_Tenant_Dispute_Flag_ = FALSE),__OP2(__PP1066136.Filing_Type_Description_,IN,__CN(__CC34000)));
      __CC33990 := ['JUDGMENT or STATE TAX LIEN','STATE TAX LIEN','STATE TAX LIEN RELEASE','STATE TAX LIEN RENEWAL','STATE TAX LIEN RENEWED','STATE TAX RELEASE','STATE TAX WARRANT','STATE TAX WARRANT RELEASE','STATE TAX WARRANT RENEWED'];
      SELF.Is_State_Tax_Lien_ := __AND(__CN(__PP1066136.Landlord_Tenant_Dispute_Flag_ = FALSE),__OP2(__PP1066136.Filing_Type_Description_,IN,__CN(__CC33990)));
      SELF := __PP1066136;
    END;
    SELF.All_Lien_Data_ := __PROJECT(__EE1066423,__ND1066329__Project(LEFT));
    SELF := __PP1066039;
  END;
  EXPORT __ENH_Person_10 := PROJECT(__EE1066499,__ND1066425__Project(LEFT));
END;
