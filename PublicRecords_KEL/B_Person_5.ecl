//HPCC Systems KEL Compiler Version 1.2.1-dev
IMPORT KEL12 AS KEL;
IMPORT B_Person_6,B_Person_7,CFG_Compile,E_Person FROM PublicRecords_KEL;
IMPORT * FROM KEL12.Null;
EXPORT B_Person_5(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE
  SHARED VIRTUAL TYPEOF(B_Person_6(__in,__cfg).__ENH_Person_6) __ENH_Person_6 := B_Person_6(__in,__cfg).__ENH_Person_6;
  SHARED __EE256169 := __ENH_Person_6;
  EXPORT __ST143310_Layout := RECORD
    KEL.typ.nkdate Date_Of_Birth_;
    KEL.typ.nbool Header_Hit_Flag_;
    KEL.typ.nbool Best_;
    KEL.typ.nbool D_O_B_Best_Not_Null_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Date_Vendor_First_Reported_ := 0;
    KEL.typ.epoch Date_Vendor_Last_Reported_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  EXPORT __ST143295_Layout := RECORD
    KEL.typ.nuid UID;
    KEL.typ.nstr Gender_;
    KEL.typ.nstr Lex_I_D_Segment_;
    KEL.typ.ndataset(E_Person(__in,__cfg).Full_Name_Layout) Full_Name_;
    KEL.typ.ndataset(__ST143310_Layout) Reported_Dates_Of_Birth_;
    KEL.typ.ndataset(E_Person(__in,__cfg).Reported_Dates_Of_Death_Layout) Reported_Dates_Of_Death_;
    KEL.typ.nstr Race_;
    KEL.typ.nstr Race_Description_;
    KEL.typ.ndataset(E_Person(__in,__cfg).Data_Sources_Layout) Data_Sources_;
    KEL.typ.ndataset(E_Person(__in,__cfg).Dunn_Data_Layout) Dunn_Data_;
    KEL.typ.ndataset(B_Person_7(__in,__cfg).__ST53977_Layout) Address_Hierarchy_Set_;
    KEL.typ.ndataset(B_Person_7(__in,__cfg).__ST53977_Layout) Curr_Addr_Full_Set_;
    KEL.typ.ndataset(B_Person_7(__in,__cfg).__ST53977_Layout) Recent_Addr_Full_Set_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Date_Vendor_First_Reported_ := 0;
    KEL.typ.epoch Date_Vendor_Last_Reported_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  SHARED __ST143295_Layout __ND256063__Project(B_Person_6(__in,__cfg).__ST145518_Layout __PP254403) := TRANSFORM
    __EE256172 := __PP254403.Reported_Dates_Of_Birth_;
    __ST143310_Layout __ND255935__Project(E_Person(__in,__cfg).Reported_Dates_Of_Birth_Layout __PP254863) := TRANSFORM
      SELF.D_O_B_Best_Not_Null_ := __AND(__OP2(__PP254863.Best_,=,__CN(TRUE)),__NOT(__NT(__PP254863.Date_Of_Birth_)));
      SELF := __PP254863;
    END;
    SELF.Reported_Dates_Of_Birth_ := __PROJECT(__EE256172,__ND255935__Project(LEFT));
    __EE256057 := __PP254403.Recent_Addr_Full_Set_;
    __BS256044 := __T(__EE256057);
    __EE256061 := __BN(TOPN(__BS256044(__NN(__T(__EE256057).Address_Rank_) AND __NN(__T(__EE256057).Sort_Field_)),1,__T(__T(__EE256057).Address_Rank_), -__T(__T(__EE256057).Sort_Field_),__T(Address_Type_),__T(State_Code_),__T(County_Code_),__T(Geo_Blk_),__T(Addr_Full_),__T(Primary_Range_),__T(Predirectional_),__T(Primary_Name_),__T(Suffix_),__T(Postdirectional_),__T(Unit_Designation_),__T(Secondary_Range_),__T(Postal_City_),__T(State_),__T(Z_I_P5_),__T(Z_I_P4_),__T(Addr1_From_Components_)),__NL(__EE256057));
    SELF.Curr_Addr_Full_Set_ := __EE256061;
    SELF := __PP254403;
  END;
  EXPORT __ENH_Person_5 := PROJECT(__EE256169,__ND256063__Project(LEFT));
END;
