﻿//HPCC Systems KEL Compiler Version 1.6.0
IMPORT KEL16 AS KEL;
IMPORT B_Person_5,B_Person_6,CFG_Compile,E_Person FROM PublicRecords_KEL.KEL_Queries_MAS_Shared;
IMPORT * FROM KEL16.Null;
EXPORT B_Person_4(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE
  SHARED VIRTUAL TYPEOF(B_Person_5(__in,__cfg).__ENH_Person_5) __ENH_Person_5 := B_Person_5(__in,__cfg).__ENH_Person_5;
  SHARED __EE212960 := __ENH_Person_5;
  EXPORT __ST160051_Layout := RECORD
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
    KEL.typ.ndataset(B_Person_6(__in,__cfg).__ST88421_Layout) Address_Hierarchy_Set_;
    KEL.typ.ndataset(B_Person_6(__in,__cfg).__ST88421_Layout) Curr_Addr_Full_Set_;
    KEL.typ.ndataset(B_Person_6(__in,__cfg).__ST88421_Layout) Recent_Addr_Full_Set_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  SHARED __ST160051_Layout __ND212965__Project(B_Person_5(__in,__cfg).__ST159712_Layout __PP212961) := TRANSFORM
    __EE213139 := __PP212961.Recent_Addr_Full_Set_;
    __BS213140 := __T(__EE213139);
    __EE213153 := __BN(TOPN(__BS213140(__NN(__T(__EE213139).Address_Rank_) AND __NN(__T(__EE213139).Address_Rank_Best_) AND __NN(__T(__EE213139).Sort_Field_)),1,__T(__T(__EE213139).Address_Rank_),__T(__T(__EE213139).Address_Rank_Best_), -__T(__T(__EE213139).Sort_Field_),__T(Address_Type_),__T(Address_Status_),__T(State_Code_),__T(County_Code_),__T(Latitude_),__T(Longitude_),__T(Geo_Blk_),__T(Addr_Full_),__T(Primary_Range_),__T(Predirectional_),__T(Primary_Name_),__T(Suffix_),__T(Postdirectional_),__T(Unit_Designation_),__T(Secondary_Range_),__T(Postal_City_),__T(State_),__T(Z_I_P5_),__T(Z_I_P4_),__T(Addr1_From_Components_),__T(Hierarchy_Date_First_Seen_),__T(Hierarchy_Date_Last_Seen_)),__NL(__EE213139));
    SELF.Curr_Addr_Full_Set_ := __EE213153;
    SELF := __PP212961;
  END;
  EXPORT __ENH_Person_4 := PROJECT(__EE212960,__ND212965__Project(LEFT));
END;
