//HPCC Systems KEL Compiler Version 1.6.0
IMPORT KEL16 AS KEL;
IMPORT B_Business_Sele_Overflow_6,CFG_Compile,E_Business_Sele_Overflow FROM PublicRecords_KEL.KEL_Queries_MAS_Business;
IMPORT * FROM KEL16.Null;
EXPORT B_Business_Sele_Overflow_5(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE
  SHARED VIRTUAL TYPEOF(B_Business_Sele_Overflow_6(__in,__cfg).__ENH_Business_Sele_Overflow_6) __ENH_Business_Sele_Overflow_6 := B_Business_Sele_Overflow_6(__in,__cfg).__ENH_Business_Sele_Overflow_6;
  SHARED __EE1982792 := __ENH_Business_Sele_Overflow_6;
  EXPORT __ST203746_Layout := RECORD
    KEL.typ.nuid UID;
    KEL.typ.nint Ult_I_D_;
    KEL.typ.nint Org_I_D_;
    KEL.typ.nint Sele_I_D_;
    KEL.typ.ndataset(E_Business_Sele_Overflow(__in,__cfg).Vendor_Identification_Layout) Vendor_Identification_;
    KEL.typ.ndataset(E_Business_Sele_Overflow(__in,__cfg).S_O_S_Company_Types_Layout) S_O_S_Company_Types_;
    KEL.typ.ndataset(E_Business_Sele_Overflow(__in,__cfg).S_O_S_Registered_Agents_Layout) S_O_S_Registered_Agents_;
    KEL.typ.ndataset(E_Business_Sele_Overflow(__in,__cfg).S_O_S_Statuses_Layout) S_O_S_Statuses_;
    KEL.typ.ndataset(E_Business_Sele_Overflow(__in,__cfg).S_O_S_Incorporation_Details_Layout) S_O_S_Incorporation_Details_;
    KEL.typ.ndataset(E_Business_Sele_Overflow(__in,__cfg).S_O_S_Charter_Numbers_Layout) S_O_S_Charter_Numbers_;
    KEL.typ.ndataset(E_Business_Sele_Overflow(__in,__cfg).S_O_S_Term_Exist_Codes_Layout) S_O_S_Term_Exist_Codes_;
    KEL.typ.ndataset(E_Business_Sele_Overflow(__in,__cfg).Government_Debarred_Layout) Government_Debarred_;
    KEL.typ.ndataset(E_Business_Sele_Overflow(__in,__cfg).Retirement_Plan_Information_Layout) Retirement_Plan_Information_;
    KEL.typ.ndataset(E_Business_Sele_Overflow(__in,__cfg).Processing_Dates_Layout) Processing_Dates_;
    KEL.typ.ndataset(E_Business_Sele_Overflow(__in,__cfg).Business_Registration_Layout) Business_Registration_;
    KEL.typ.ndataset(E_Business_Sele_Overflow(__in,__cfg).Data_Sources_Layout) Data_Sources_;
    KEL.typ.nkdate S_O_S_Dom_Date_First_Seen_;
    KEL.typ.nkdate S_O_S_Dom_Date_Last_Seen_;
    KEL.typ.ndataset(E_Business_Sele_Overflow(__in,__cfg).S_O_S_Incorporation_Details_Layout) S_O_S_Domestic_Filing_;
    KEL.typ.int S_O_S_Domestic_Filing_Count_ := 0;
    KEL.typ.ndataset(E_Business_Sele_Overflow(__in,__cfg).S_O_S_Incorporation_Details_Layout) S_O_S_Foreign_Filing_;
    KEL.typ.int S_O_S_Foreign_Filing_Count_ := 0;
    KEL.typ.nkdate S_O_S_Frgn_Date_First_Seen_;
    KEL.typ.nkdate S_O_S_Frgn_Date_Last_Seen_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  SHARED __ST203746_Layout __ND1982598__Project(B_Business_Sele_Overflow_6(__in,__cfg).__ST207536_Layout __PP1982054) := TRANSFORM
    __EE1982593 := __PP1982054.S_O_S_Domestic_Filing_;
    SELF.S_O_S_Dom_Date_First_Seen_ := KEL.Aggregates.MinNN(__EE1982593,__T(__EE1982593).S_O_S_Incorporation_Date_);
    __EE1982608 := __PP1982054.S_O_S_Domestic_Filing_;
    SELF.S_O_S_Dom_Date_Last_Seen_ := KEL.Aggregates.MaxNN(__EE1982608,__T(__EE1982608).S_O_S_Incorporation_Date_);
    __EE1982633 := __PP1982054.S_O_S_Domestic_Filing_;
    __ST96303_Layout := RECORD
      KEL.typ.nstr S_O_S_Key_;
      KEL.typ.nstr S_O_S_Incorporation_State_;
      KEL.typ.epoch Archive___Date_ := 0;
      KEL.typ.epoch Date_First_Seen_ := 0;
      KEL.typ.epoch Date_Last_Seen_ := 0;
      KEL.typ.epoch Hybrid_Archive_Date_ := 0;
      KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
      KEL.typ.int __RecordCount := 0;
    END;
    SELF.S_O_S_Domestic_Filing_Count_ := COUNT(PROJECT(TABLE(PROJECT(__T(__EE1982633),__ST96303_Layout),{KEL.typ.int __RecordCount := SUM(GROUP,__RecordCount),KEL.typ.epoch Archive___Date_ := KEL.era.SimpleRoll(GROUP,Archive___Date_,MIN,FALSE),KEL.typ.epoch Date_First_Seen_ := KEL.era.SimpleRoll(GROUP,Date_First_Seen_,MIN,FALSE),KEL.typ.epoch Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Date_Last_Seen_,MAX,FALSE),KEL.typ.epoch Hybrid_Archive_Date_ := KEL.era.SimpleRoll(GROUP,Hybrid_Archive_Date_,MIN,FALSE),KEL.typ.epoch Vault_Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Vault_Date_Last_Seen_,MAX,NMAX),S_O_S_Key_,S_O_S_Incorporation_State_},S_O_S_Key_,S_O_S_Incorporation_State_,MERGE),__ST96303_Layout));
    __EE1982656 := __PP1982054.S_O_S_Foreign_Filing_;
    __ST96335_Layout := RECORD
      KEL.typ.nstr S_O_S_Key_;
      KEL.typ.nstr S_O_S_Foreign_State_Code_;
      KEL.typ.epoch Archive___Date_ := 0;
      KEL.typ.epoch Date_First_Seen_ := 0;
      KEL.typ.epoch Date_Last_Seen_ := 0;
      KEL.typ.epoch Hybrid_Archive_Date_ := 0;
      KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
      KEL.typ.int __RecordCount := 0;
    END;
    SELF.S_O_S_Foreign_Filing_Count_ := COUNT(PROJECT(TABLE(PROJECT(__T(__EE1982656),__ST96335_Layout),{KEL.typ.int __RecordCount := SUM(GROUP,__RecordCount),KEL.typ.epoch Archive___Date_ := KEL.era.SimpleRoll(GROUP,Archive___Date_,MIN,FALSE),KEL.typ.epoch Date_First_Seen_ := KEL.era.SimpleRoll(GROUP,Date_First_Seen_,MIN,FALSE),KEL.typ.epoch Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Date_Last_Seen_,MAX,FALSE),KEL.typ.epoch Hybrid_Archive_Date_ := KEL.era.SimpleRoll(GROUP,Hybrid_Archive_Date_,MIN,FALSE),KEL.typ.epoch Vault_Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Vault_Date_Last_Seen_,MAX,NMAX),S_O_S_Key_,S_O_S_Foreign_State_Code_},S_O_S_Key_,S_O_S_Foreign_State_Code_,MERGE),__ST96335_Layout));
    __EE1982668 := __PP1982054.S_O_S_Foreign_Filing_;
    SELF.S_O_S_Frgn_Date_First_Seen_ := KEL.Aggregates.MinNN(__EE1982668,__T(__EE1982668).S_O_S_Foreign_State_Date_);
    __EE1982682 := __PP1982054.S_O_S_Foreign_Filing_;
    SELF.S_O_S_Frgn_Date_Last_Seen_ := KEL.Aggregates.MaxNN(__EE1982682,__T(__EE1982682).S_O_S_Foreign_State_Date_);
    SELF := __PP1982054;
  END;
  EXPORT __ENH_Business_Sele_Overflow_5 := PROJECT(__EE1982792,__ND1982598__Project(LEFT));
END;
