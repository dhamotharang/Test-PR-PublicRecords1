//HPCC Systems KEL Compiler Version 1.3.0
IMPORT KEL13 AS KEL;
IMPORT B_Person_10,B_Person_9,CFG_Compile,E_Person FROM PublicRecords_KEL;
IMPORT * FROM KEL13.Null;
EXPORT B_Person_8(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE
  SHARED VIRTUAL TYPEOF(B_Person_9(__in,__cfg).__ENH_Person_9) __ENH_Person_9 := B_Person_9(__in,__cfg).__ENH_Person_9;
  SHARED __EE3527428 := __ENH_Person_9;
  EXPORT __ST208250_Layout := RECORD
    KEL.typ.nuid UID;
    KEL.typ.nstr Gender_;
    KEL.typ.nstr Lex_I_D_Segment_;
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
    KEL.typ.ndataset(B_Person_10(__in,__cfg).__ST71252_Layout) Address_Hierarchy_Set_;
    KEL.typ.ndataset(B_Person_10(__in,__cfg).__ST71252_Layout) Curr_Addr_Full_Set_;
    KEL.typ.ndataset(B_Person_10(__in,__cfg).__ST71252_Layout) Recent_Addr_Full_Set_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Date_Vendor_First_Reported_ := 0;
    KEL.typ.epoch Date_Vendor_Last_Reported_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_First_Seen_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  SHARED __ST208250_Layout __ND3527433__Project(B_Person_9(__in,__cfg).__ST210029_Layout __PP3527429) := TRANSFORM
    __EE3527611 := __PP3527429.Recent_Addr_Full_Set_;
    __BS3527612 := __T(__EE3527611);
    __EE3527623 := __BN(TOPN(__BS3527612(__NN(__T(__EE3527611).Address_Rank_) AND __NN(__T(__EE3527611).Sort_Field_)),1,__T(__T(__EE3527611).Address_Rank_), -__T(__T(__EE3527611).Sort_Field_),__T(Address_Type_),__T(Address_Status_),__T(State_Code_),__T(County_Code_),__T(Latitude_),__T(Longitude_),__T(Geo_Blk_),__T(Addr_Full_),__T(Primary_Range_),__T(Predirectional_),__T(Primary_Name_),__T(Suffix_),__T(Postdirectional_),__T(Unit_Designation_),__T(Secondary_Range_),__T(Postal_City_),__T(State_),__T(Z_I_P5_),__T(Z_I_P4_),__T(Addr1_From_Components_)),__NL(__EE3527611));
    SELF.Curr_Addr_Full_Set_ := __EE3527623;
    SELF := __PP3527429;
  END;
  EXPORT __ENH_Person_8 := PROJECT(__EE3527428,__ND3527433__Project(LEFT));
END;
