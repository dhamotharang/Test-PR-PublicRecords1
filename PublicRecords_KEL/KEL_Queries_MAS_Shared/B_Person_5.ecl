//HPCC Systems KEL Compiler Version 1.6.0
IMPORT KEL16 AS KEL;
IMPORT B_Person_6,CFG_Compile,E_Person,FN_Compile FROM PublicRecords_KEL.KEL_Queries_MAS_Shared;
IMPORT * FROM KEL16.Null;
EXPORT B_Person_5(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE
  SHARED VIRTUAL TYPEOF(B_Person_6(__in,__cfg).__ENH_Person_6) __ENH_Person_6 := B_Person_6(__in,__cfg).__ENH_Person_6;
  SHARED __EE179602 := __ENH_Person_6;
  EXPORT __ST144890_Layout := RECORD
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
    KEL.typ.ndataset(B_Person_6(__in,__cfg).__ST81123_Layout) Address_Hierarchy_Set_;
    KEL.typ.ndataset(B_Person_6(__in,__cfg).__ST81123_Layout) Recent_Addr_Full_Set_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  SHARED __ST144890_Layout __ND179477__Project(B_Person_6(__in,__cfg).__ST147954_Layout __PP178774) := TRANSFORM
    __EE179434 := __PP178774.Address_Hierarchy_Set_;
    __CC23943 := [0,91,92,93,94,95,96,97,98,99];
    __CC23945 := 'BUS';
    __BS179435 := __T(__EE179434);
    __EE179471 := __BS179435(__T(__AND(__CN(FN_Compile(__cfg).FN_Is_Not_Enough_To_Clean(__ECAST(KEL.typ.nstr,__T(__EE179434).Address_Rank_)) = FALSE),__AND(__NOT(__OP2(__T(__EE179434).Address_Rank_,IN,__CN(__CC23943))),__AND(__OR(__OP2(__T(__EE179434).Address_Type_,<>,__CN(__CC23945)),__NT(__T(__EE179434).Address_Type_)),__OR(__OP2(__T(__EE179434).Addr1_From_Components_,<>,__CN('P')),__NT(__T(__EE179434).Addr1_From_Components_)))))));
    __EE179475 := TOPN(__EE179471(__NN(__EE179471.Address_Rank_) AND __NN(__EE179471.Sort_Field_)),2,__T(__EE179471.Address_Rank_), -__T(__EE179471.Sort_Field_),__T(Address_Type_),__T(Address_Status_),__T(State_Code_),__T(County_Code_),__T(Latitude_),__T(Longitude_),__T(Geo_Blk_),__T(Addr_Full_),__T(Primary_Range_),__T(Predirectional_),__T(Primary_Name_),__T(Suffix_),__T(Postdirectional_),__T(Unit_Designation_),__T(Secondary_Range_),__T(Postal_City_),__T(State_),__T(Z_I_P5_),__T(Z_I_P4_),__T(Addr1_From_Components_),__T(Hierarchy_Date_First_Seen_),__T(Hierarchy_Date_Last_Seen_));
    SELF.Recent_Addr_Full_Set_ := __CN(__EE179475);
    SELF := __PP178774;
  END;
  EXPORT __ENH_Person_5 := PROJECT(__EE179602,__ND179477__Project(LEFT));
END;
