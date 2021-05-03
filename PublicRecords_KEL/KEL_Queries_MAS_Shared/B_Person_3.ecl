//HPCC Systems KEL Compiler Version 1.5.0rc1
IMPORT KEL15 AS KEL;
IMPORT B_Person_4,B_Person_6,CFG_Compile,E_Person FROM PublicRecords_KEL.KEL_Queries_MAS_Shared;
IMPORT * FROM KEL15.Null;
EXPORT B_Person_3(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE
  SHARED VIRTUAL TYPEOF(B_Person_4(__in,__cfg).__ENH_Person_4) __ENH_Person_4 := B_Person_4(__in,__cfg).__ENH_Person_4;
  SHARED __EE179983 := __ENH_Person_4;
  EXPORT __ST144343_Layout := RECORD
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
    KEL.typ.ndataset(B_Person_6(__in,__cfg).__ST80489_Layout) Address_Hierarchy_Set_;
    KEL.typ.ndataset(B_Person_6(__in,__cfg).__ST80489_Layout) Curr_Addr_Full_Set_;
    KEL.typ.nstr Prep_Current_Addr_Full_;
    KEL.typ.ndataset(B_Person_6(__in,__cfg).__ST80489_Layout) Recent_Addr_Full_Set_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  SHARED __ST144343_Layout __ND179829__Project(B_Person_4(__in,__cfg).__ST144003_Layout __PP179175) := TRANSFORM
    __EE179824 := __PP179175.Curr_Addr_Full_Set_;
    SELF.Prep_Current_Addr_Full_ := (__T(__EE179824))[1].Addr_Full_;
    SELF := __PP179175;
  END;
  EXPORT __ENH_Person_3 := PROJECT(__EE179983,__ND179829__Project(LEFT));
END;
