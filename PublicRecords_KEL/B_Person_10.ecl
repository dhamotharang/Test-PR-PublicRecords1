﻿//HPCC Systems KEL Compiler Version 1.5.0rc1
IMPORT KEL15 AS KEL;
IMPORT B_Person_11,CFG_Compile,E_Address,E_Geo_Link,E_Person,E_Person_Address,E_Zip_Code,FN_Compile FROM PublicRecords_KEL;
IMPORT * FROM KEL15.Null;
EXPORT B_Person_10(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE
  SHARED VIRTUAL TYPEOF(B_Person_11(__in,__cfg).__ENH_Person_11) __ENH_Person_11 := B_Person_11(__in,__cfg).__ENH_Person_11;
  SHARED VIRTUAL TYPEOF(E_Person_Address(__in,__cfg).__Result) __E_Person_Address := E_Person_Address(__in,__cfg).__Result;
  SHARED __EE6125602 := __ENH_Person_11;
  SHARED __EE6125616 := __E_Person_Address;
  SHARED __EE6125626 := __EE6125616(__NN(__EE6125616.Subject_));
  SHARED __ST400511_Layout := RECORD
    KEL.typ.ntyp(E_Person().Typ) Subject_;
    KEL.typ.ntyp(E_Address().Typ) Location_;
    KEL.typ.nstr Primary_Range_;
    KEL.typ.nstr Predirectional_;
    KEL.typ.nstr Primary_Name_;
    KEL.typ.nstr Suffix_;
    KEL.typ.nstr Postdirectional_;
    KEL.typ.ntyp(E_Zip_Code().Typ) Z_I_P5_;
    KEL.typ.nstr Secondary_Range_;
    KEL.typ.nstr Cart_;
    KEL.typ.nstr C_R_Sort_Sz_;
    KEL.typ.nstr Lot_;
    KEL.typ.nstr Lot_Order_;
    KEL.typ.nstr D_P_B_C_;
    KEL.typ.nstr C_H_K_Digit_;
    KEL.typ.nstr Ace_Fips_St_;
    KEL.typ.nstr Ace_Fips_County_;
    KEL.typ.nstr M_S_A_;
    KEL.typ.nstr Verified_City_;
    KEL.typ.ndataset(E_Person_Address(__in,__cfg).Address_Rank_Details_Layout) Address_Rank_Details_;
    KEL.typ.ndataset(E_Person_Address(__in,__cfg).Address_Hierarchy_Layout) Address_Hierarchy_;
    KEL.typ.ndataset(E_Person_Address(__in,__cfg).Data_Sources_Layout) Data_Sources_;
    KEL.typ.nint Address_Rank_;
    KEL.typ.nstr Address_Type_;
    KEL.typ.nstr Address_Status_;
    KEL.typ.nstr Primary_Range__1_;
    KEL.typ.nstr Predirectional__1_;
    KEL.typ.nstr Primary_Name__1_;
    KEL.typ.nstr Suffix__1_;
    KEL.typ.nstr Postdirectional__1_;
    KEL.typ.nstr Unit_Designation_;
    KEL.typ.nstr Secondary_Range__1_;
    KEL.typ.nstr Postal_City_;
    KEL.typ.nstr State_;
    KEL.typ.ntyp(E_Zip_Code().Typ) Z_I_P5__1_;
    KEL.typ.nint Z_I_P4_;
    KEL.typ.nstr State_Code_;
    KEL.typ.nstr County_Code_;
    KEL.typ.nstr Latitude_;
    KEL.typ.nstr Longitude_;
    KEL.typ.nstr Geo_Blk_;
    KEL.typ.nstr Geo_Mmatch_;
    KEL.typ.ntyp(E_Geo_Link().Typ) Geo_Link_I_D_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  __ST400511_Layout __JT6125634(E_Person_Address(__in,__cfg).Layout __l, E_Person_Address(__in,__cfg).Address_Hierarchy_Layout __r) := TRANSFORM
    SELF.Primary_Range__1_ := __r.Primary_Range_;
    SELF.Predirectional__1_ := __r.Predirectional_;
    SELF.Primary_Name__1_ := __r.Primary_Name_;
    SELF.Suffix__1_ := __r.Suffix_;
    SELF.Postdirectional__1_ := __r.Postdirectional_;
    SELF.Secondary_Range__1_ := __r.Secondary_Range_;
    SELF.Z_I_P5__1_ := __r.Z_I_P5_;
    SELF.Archive___Date_ := __r.Archive___Date_;
    SELF.Date_First_Seen_ := __r.Date_First_Seen_;
    SELF.Date_Last_Seen_ := __r.Date_Last_Seen_;
    SELF.Hybrid_Archive_Date_ := __r.Hybrid_Archive_Date_;
    SELF.Vault_Date_Last_Seen_ := __r.Vault_Date_Last_Seen_;
    SELF.__RecordCount := __r.__RecordCount;
    SELF := __l;
    SELF := __r;
  END;
  SHARED __EE6125728 := NORMALIZE(__EE6125626,__T(LEFT.Address_Hierarchy_),__JT6125634(LEFT,RIGHT));
  SHARED __ST399743_Layout := RECORD
    KEL.typ.ntyp(E_Person().Typ) ____grp___U_I_D_;
    KEL.typ.nint Address_Rank_;
    KEL.typ.nstr Address_Type_;
    KEL.typ.nstr State_Code_;
    KEL.typ.nstr County_Code_;
    KEL.typ.nstr Address_Status_;
    KEL.typ.nstr Latitude_;
    KEL.typ.nstr Longitude_;
    KEL.typ.nstr Geo_Blk_;
    KEL.typ.nstr Addr_Full_;
    KEL.typ.nstr Primary_Range_;
    KEL.typ.nstr Predirectional_;
    KEL.typ.nstr Primary_Name_;
    KEL.typ.nstr Suffix_;
    KEL.typ.nstr Postdirectional_;
    KEL.typ.nstr Unit_Designation_;
    KEL.typ.nstr Secondary_Range_;
    KEL.typ.nstr Postal_City_;
    KEL.typ.nstr State_;
    KEL.typ.nstr Z_I_P5_;
    KEL.typ.nstr Z_I_P4_;
    KEL.typ.nstr Addr1_From_Components_;
    KEL.typ.nkdate Sort_Field_;
    KEL.typ.nkdate Hierarchy_Date_First_Seen_;
    KEL.typ.nkdate Hierarchy_Date_Last_Seen_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  SHARED __ST399743_Layout __ND6125733__Project(__ST400511_Layout __PP6125729) := TRANSFORM
    SELF.____grp___U_I_D_ := __PP6125729.Subject_;
    SELF.Addr_Full_ := __OP2(__OP2(__OP2(__OP2(__OP2(__OP2(__OP2(__OP2(__OP2(__OP2(IF(__T(__OR(__OR(__CN(FN_Compile(__cfg).FN_Is_Not_Enough_To_Clean(__ECAST(KEL.typ.nstr,__PP6125729.Primary_Range__1_))),__OP2(__PP6125729.Primary_Range__1_,=,__CN(''))),__NT(__PP6125729.Primary_Range__1_))),__ECAST(KEL.typ.nstr,__CN('')),__ECAST(KEL.typ.nstr,__OP2(__FN1(TRIM,__PP6125729.Primary_Range__1_),+,__CN(' ')))),+,IF(__T(__OR(__OR(__CN(FN_Compile(__cfg).FN_Is_Not_Enough_To_Clean(__ECAST(KEL.typ.nstr,__PP6125729.Predirectional__1_))),__OP2(__PP6125729.Predirectional__1_,=,__CN(''))),__NT(__PP6125729.Predirectional__1_))),__ECAST(KEL.typ.nstr,__CN('')),__ECAST(KEL.typ.nstr,__OP2(__FN1(TRIM,__PP6125729.Predirectional__1_),+,__CN(' '))))),+,IF(__T(__OR(__OR(__CN(FN_Compile(__cfg).FN_Is_Not_Enough_To_Clean(__ECAST(KEL.typ.nstr,__PP6125729.Primary_Name__1_))),__OP2(__PP6125729.Primary_Name__1_,=,__CN(''))),__NT(__PP6125729.Primary_Name__1_))),__ECAST(KEL.typ.nstr,__CN('')),__ECAST(KEL.typ.nstr,__OP2(__FN1(TRIM,__PP6125729.Primary_Name__1_),+,__CN(' '))))),+,IF(__T(__OR(__OR(__CN(FN_Compile(__cfg).FN_Is_Not_Enough_To_Clean(__ECAST(KEL.typ.nstr,__PP6125729.Suffix__1_))),__OP2(__PP6125729.Suffix__1_,=,__CN(''))),__NT(__PP6125729.Suffix__1_))),__ECAST(KEL.typ.nstr,__CN('')),__ECAST(KEL.typ.nstr,__OP2(__FN1(TRIM,__PP6125729.Suffix__1_),+,__CN(' '))))),+,IF(__T(__OR(__OR(__CN(FN_Compile(__cfg).FN_Is_Not_Enough_To_Clean(__ECAST(KEL.typ.nstr,__PP6125729.Postdirectional__1_))),__OP2(__PP6125729.Postdirectional__1_,=,__CN(''))),__NT(__PP6125729.Postdirectional__1_))),__ECAST(KEL.typ.nstr,__CN('')),__ECAST(KEL.typ.nstr,__OP2(__FN1(TRIM,__PP6125729.Postdirectional__1_),+,__CN(' '))))),+,IF(__T(__OR(__OR(__CN(FN_Compile(__cfg).FN_Is_Not_Enough_To_Clean(__ECAST(KEL.typ.nstr,__PP6125729.Unit_Designation_))),__OP2(__PP6125729.Unit_Designation_,=,__CN(''))),__NT(__PP6125729.Unit_Designation_))),__ECAST(KEL.typ.nstr,__CN('')),__ECAST(KEL.typ.nstr,__OP2(__FN1(TRIM,__PP6125729.Unit_Designation_),+,__CN(' '))))),+,IF(__T(__OR(__OR(__CN(FN_Compile(__cfg).FN_Is_Not_Enough_To_Clean(__ECAST(KEL.typ.nstr,__PP6125729.Secondary_Range__1_))),__OP2(__PP6125729.Secondary_Range__1_,=,__CN(''))),__NT(__PP6125729.Secondary_Range__1_))),__ECAST(KEL.typ.nstr,__CN('')),__ECAST(KEL.typ.nstr,__OP2(__FN1(TRIM,__PP6125729.Secondary_Range__1_),+,__CN(' '))))),+,IF(__T(__OR(__OR(__CN(FN_Compile(__cfg).FN_Is_Not_Enough_To_Clean(__ECAST(KEL.typ.nstr,__PP6125729.Postal_City_))),__OP2(__PP6125729.Postal_City_,=,__CN(''))),__NT(__PP6125729.Postal_City_))),__ECAST(KEL.typ.nstr,__CN('')),__ECAST(KEL.typ.nstr,__OP2(__FN1(TRIM,__PP6125729.Postal_City_),+,__CN(' '))))),+,IF(__T(__OR(__OR(__CN(FN_Compile(__cfg).FN_Is_Not_Enough_To_Clean(__ECAST(KEL.typ.nstr,__PP6125729.State_))),__OP2(__PP6125729.State_,=,__CN(''))),__NT(__PP6125729.State_))),__ECAST(KEL.typ.nstr,__CN('')),__ECAST(KEL.typ.nstr,__OP2(__FN1(TRIM,__PP6125729.State_),+,__CN(' '))))),+,IF(__T(__OR(__OR(__CN(FN_Compile(__cfg).FN_Is_Not_Enough_To_Clean(__ECAST(KEL.typ.nstr,__ECAST(KEL.typ.nstr,__PP6125729.Z_I_P5__1_)))),__OP2(__PP6125729.Z_I_P5__1_,=,__CN(0))),__NT(__PP6125729.Z_I_P5__1_))),__ECAST(KEL.typ.nstr,__CN('')),__ECAST(KEL.typ.nstr,__OP2(__FN1(TRIM,__ECAST(KEL.typ.nstr,__PP6125729.Z_I_P5__1_)),+,__CN(' '))))),+,IF(__T(__OR(__OR(__CN(FN_Compile(__cfg).FN_Is_Not_Enough_To_Clean(__ECAST(KEL.typ.nstr,__ECAST(KEL.typ.nstr,__PP6125729.Z_I_P4_)))),__OP2(__PP6125729.Z_I_P4_,=,__CN(0))),__NT(__PP6125729.Z_I_P4_))),__ECAST(KEL.typ.nstr,__CN('')),__ECAST(KEL.typ.nstr,__FN1(TRIM,__ECAST(KEL.typ.nstr,__PP6125729.Z_I_P4_)))));
    SELF.Primary_Range_ := IF(__T(__OR(__OR(__CN(FN_Compile(__cfg).FN_Is_Not_Enough_To_Clean(__ECAST(KEL.typ.nstr,__PP6125729.Primary_Range__1_))),__OP2(__PP6125729.Primary_Range__1_,=,__CN(''))),__NT(__PP6125729.Primary_Range__1_))),__ECAST(KEL.typ.nstr,__CN('')),__ECAST(KEL.typ.nstr,__FN1(TRIM,__PP6125729.Primary_Range__1_)));
    SELF.Predirectional_ := IF(__T(__OR(__OR(__CN(FN_Compile(__cfg).FN_Is_Not_Enough_To_Clean(__ECAST(KEL.typ.nstr,__PP6125729.Predirectional__1_))),__OP2(__PP6125729.Predirectional__1_,=,__CN(''))),__NT(__PP6125729.Predirectional__1_))),__ECAST(KEL.typ.nstr,__CN('')),__ECAST(KEL.typ.nstr,__FN1(TRIM,__PP6125729.Predirectional__1_)));
    SELF.Primary_Name_ := IF(__T(__OR(__OR(__CN(FN_Compile(__cfg).FN_Is_Not_Enough_To_Clean(__ECAST(KEL.typ.nstr,__PP6125729.Primary_Name__1_))),__OP2(__PP6125729.Primary_Name__1_,=,__CN(''))),__NT(__PP6125729.Primary_Name__1_))),__ECAST(KEL.typ.nstr,__CN('')),__ECAST(KEL.typ.nstr,__FN1(TRIM,__PP6125729.Primary_Name__1_)));
    SELF.Suffix_ := IF(__T(__OR(__OR(__CN(FN_Compile(__cfg).FN_Is_Not_Enough_To_Clean(__ECAST(KEL.typ.nstr,__PP6125729.Suffix__1_))),__OP2(__PP6125729.Suffix__1_,=,__CN(''))),__NT(__PP6125729.Suffix__1_))),__ECAST(KEL.typ.nstr,__CN('')),__ECAST(KEL.typ.nstr,__FN1(TRIM,__PP6125729.Suffix__1_)));
    SELF.Postdirectional_ := IF(__T(__OR(__OR(__CN(FN_Compile(__cfg).FN_Is_Not_Enough_To_Clean(__ECAST(KEL.typ.nstr,__PP6125729.Postdirectional__1_))),__OP2(__PP6125729.Postdirectional__1_,=,__CN(''))),__NT(__PP6125729.Postdirectional__1_))),__ECAST(KEL.typ.nstr,__CN('')),__ECAST(KEL.typ.nstr,__FN1(TRIM,__PP6125729.Postdirectional__1_)));
    SELF.Unit_Designation_ := IF(__T(__OR(__OR(__CN(FN_Compile(__cfg).FN_Is_Not_Enough_To_Clean(__ECAST(KEL.typ.nstr,__PP6125729.Unit_Designation_))),__OP2(__PP6125729.Unit_Designation_,=,__CN(''))),__NT(__PP6125729.Unit_Designation_))),__ECAST(KEL.typ.nstr,__CN('')),__ECAST(KEL.typ.nstr,__FN1(TRIM,__PP6125729.Unit_Designation_)));
    SELF.Secondary_Range_ := IF(__T(__OR(__OR(__CN(FN_Compile(__cfg).FN_Is_Not_Enough_To_Clean(__ECAST(KEL.typ.nstr,__PP6125729.Secondary_Range__1_))),__OP2(__PP6125729.Secondary_Range__1_,=,__CN(''))),__NT(__PP6125729.Secondary_Range__1_))),__ECAST(KEL.typ.nstr,__CN('')),__ECAST(KEL.typ.nstr,__FN1(TRIM,__PP6125729.Secondary_Range__1_)));
    SELF.Postal_City_ := IF(__T(__OR(__OR(__CN(FN_Compile(__cfg).FN_Is_Not_Enough_To_Clean(__ECAST(KEL.typ.nstr,__PP6125729.Postal_City_))),__OP2(__PP6125729.Postal_City_,=,__CN(''))),__NT(__PP6125729.Postal_City_))),__ECAST(KEL.typ.nstr,__CN('')),__ECAST(KEL.typ.nstr,__FN1(TRIM,__PP6125729.Postal_City_)));
    SELF.State_ := IF(__T(__OR(__OR(__CN(FN_Compile(__cfg).FN_Is_Not_Enough_To_Clean(__ECAST(KEL.typ.nstr,__PP6125729.State_))),__OP2(__PP6125729.State_,=,__CN(''))),__NT(__PP6125729.State_))),__ECAST(KEL.typ.nstr,__CN('')),__ECAST(KEL.typ.nstr,__FN1(TRIM,__PP6125729.State_)));
    SELF.Z_I_P5_ := IF(__T(__OR(__OR(__CN(FN_Compile(__cfg).FN_Is_Not_Enough_To_Clean(__ECAST(KEL.typ.nstr,__ECAST(KEL.typ.nstr,__PP6125729.Z_I_P5__1_)))),__OP2(__PP6125729.Z_I_P5__1_,=,__CN(0))),__NT(__PP6125729.Z_I_P5__1_))),__ECAST(KEL.typ.nstr,__CN('')),__ECAST(KEL.typ.nstr,__FN1(TRIM,__ECAST(KEL.typ.nstr,__PP6125729.Z_I_P5__1_))));
    SELF.Z_I_P4_ := IF(__T(__OR(__OR(__CN(FN_Compile(__cfg).FN_Is_Not_Enough_To_Clean(__ECAST(KEL.typ.nstr,__ECAST(KEL.typ.nstr,__PP6125729.Z_I_P4_)))),__OP2(__PP6125729.Z_I_P4_,=,__CN(0))),__NT(__PP6125729.Z_I_P4_))),__ECAST(KEL.typ.nstr,__CN('')),__ECAST(KEL.typ.nstr,__FN1(TRIM,__ECAST(KEL.typ.nstr,__PP6125729.Z_I_P4_))));
    SELF.Addr1_From_Components_ := FN_Compile(__cfg).FN__fn_Addr1_From_Components(__ECAST(KEL.typ.nstr,__PP6125729.Primary_Range__1_),__ECAST(KEL.typ.nstr,__PP6125729.Predirectional__1_),__ECAST(KEL.typ.nstr,__PP6125729.Primary_Name__1_),__ECAST(KEL.typ.nstr,__PP6125729.Suffix__1_),__ECAST(KEL.typ.nstr,__PP6125729.Postdirectional__1_),__ECAST(KEL.typ.nstr,__PP6125729.Unit_Designation_),__ECAST(KEL.typ.nstr,__PP6125729.Secondary_Range__1_));
    SELF.Sort_Field_ := KEL.era.ToDate(__PP6125729.Date_Last_Seen_);
    SELF.Hierarchy_Date_First_Seen_ := KEL.era.ToDate(__PP6125729.Date_First_Seen_);
    SELF.Hierarchy_Date_Last_Seen_ := KEL.era.ToDate(__PP6125729.Date_Last_Seen_);
    SELF := __PP6125729;
  END;
  SHARED __EE6126317 := PROJECT(TABLE(PROJECT(__EE6125728,__ND6125733__Project(LEFT)),{KEL.typ.int __RecordCount := SUM(GROUP,__RecordCount),KEL.typ.epoch Archive___Date_ := KEL.era.SimpleRoll(GROUP,Archive___Date_,MIN,FALSE),KEL.typ.epoch Date_First_Seen_ := KEL.era.SimpleRoll(GROUP,Date_First_Seen_,MIN,FALSE),KEL.typ.epoch Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Date_Last_Seen_,MAX,FALSE),KEL.typ.epoch Hybrid_Archive_Date_ := KEL.era.SimpleRoll(GROUP,Hybrid_Archive_Date_,MIN,FALSE),KEL.typ.epoch Vault_Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Vault_Date_Last_Seen_,MAX,NMAX),____grp___U_I_D_,Address_Rank_,Address_Type_,State_Code_,County_Code_,Address_Status_,Latitude_,Longitude_,Geo_Blk_,Addr_Full_,Primary_Range_,Predirectional_,Primary_Name_,Suffix_,Postdirectional_,Unit_Designation_,Secondary_Range_,Postal_City_,State_,Z_I_P5_,Z_I_P4_,Addr1_From_Components_,Sort_Field_,Hierarchy_Date_First_Seen_,Hierarchy_Date_Last_Seen_},____grp___U_I_D_,Address_Rank_,Address_Type_,State_Code_,County_Code_,Address_Status_,Latitude_,Longitude_,Geo_Blk_,Addr_Full_,Primary_Range_,Predirectional_,Primary_Name_,Suffix_,Postdirectional_,Unit_Designation_,Secondary_Range_,Postal_City_,State_,Z_I_P5_,Z_I_P4_,Addr1_From_Components_,Sort_Field_,Hierarchy_Date_First_Seen_,Hierarchy_Date_Last_Seen_,MERGE),__ST399743_Layout);
  SHARED __EE6126328 := GROUP(__EE6126317,____grp___U_I_D_,ALL);
  SHARED __EE6126332 := UNGROUP(TOPN(__EE6126328(__NN(__EE6126328.Address_Rank_) AND __NN(__EE6126328.Sort_Field_)),9999,__T(__EE6126328.Address_Rank_), -__T(__EE6126328.Sort_Field_),__T(____grp___U_I_D_),__T(Address_Type_),__T(Address_Status_),__T(State_Code_),__T(County_Code_),__T(Latitude_),__T(Longitude_),__T(Geo_Blk_),__T(Addr_Full_),__T(Primary_Range_),__T(Predirectional_),__T(Primary_Name_),__T(Suffix_),__T(Postdirectional_),__T(Unit_Designation_),__T(Secondary_Range_),__T(Postal_City_),__T(State_),__T(Z_I_P5_),__T(Z_I_P4_),__T(Addr1_From_Components_),__T(Hierarchy_Date_First_Seen_),__T(Hierarchy_Date_Last_Seen_)));
  SHARED __ST402355_Layout := RECORD
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
    KEL.typ.ndataset(B_Person_11(__in,__cfg).__ST380241_Layout) All_Lien_Data_;
    KEL.typ.ndataset(__ST399743_Layout) Exp1_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  __JC6126341(B_Person_11(__in,__cfg).__ST289362_Layout __EE6125602, __ST399743_Layout __EE6126332) := __EEQP(__EE6125602.UID,__EE6126332.____grp___U_I_D_);
  __ST402355_Layout __Join__ST402355_Layout(B_Person_11(__in,__cfg).__ST289362_Layout __r, DATASET(__ST399743_Layout) __recs) := TRANSFORM
    SELF := __r;
    SELF.Exp1_ := __CN(__recs);
  END;
  SHARED __EE6126460 := DENORMALIZE(DISTRIBUTE(__EE6125602,HASH(UID)),DISTRIBUTE(__EE6126332,HASH(____grp___U_I_D_)),__JC6126341(LEFT,RIGHT),GROUP,__Join__ST402355_Layout(LEFT,ROWS(RIGHT)),LOCAL);
  EXPORT __ST397428_Layout := RECORD
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
  SHARED __ST288824_Layout := RECORD
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
    KEL.typ.ndataset(__ST399743_Layout) Address_Hierarchy_Set_;
    KEL.typ.ndataset(__ST397428_Layout) All_Lien_Data_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  SHARED __ST288824_Layout __ND6126468__Project(__ST402355_Layout __PP6126464) := TRANSFORM
    __EE6126463 := __PP6126464.Exp1_;
    SELF.Address_Hierarchy_Set_ := __EE6126463;
    __EE6126711 := __PP6126464.All_Lien_Data_;
    __ST397428_Layout __ND6126611__Project(B_Person_11(__in,__cfg).__ST380241_Layout __PP6126607) := TRANSFORM
      __CC33135 := ['CIVIL JUDGMENT','CIVIL JUDGMENT RELEASE','CIVIL SPECIAL JUDGMENT','CIVIL SPECIAL JUDGMENT RELEASE','FEDERAL COURT JUDGMENT','JUDGMENT','JUDGMENTS','JUDGMENTS DOCKET','RENEW/REOPEN CIVIL JUDGMENT','SATISFACTION OF JUDGMENT','SATISFIED JUDGMENT','SUBSEQUENT JUDGMENT','DOMESTIC JUDGMENT IN DIVORCE','DOMESTIC RELEASE IN DIVORCE'];
      SELF.Is_Civil_Court_Judgment_ := __AND(__CN(__PP6126607.Landlord_Tenant_Dispute_Flag_ = FALSE),__OP2(__PP6126607.Filing_Type_Description_,IN,__CN(__CC33135)));
      __CC33139 := ['FORECLOSURE (JUDGMENT)','FORECLOSURE SATISFIED'];
      SELF.Is_Foreclosure_Judgment_ := __AND(__CN(__PP6126607.Landlord_Tenant_Dispute_Flag_ = FALSE),__OP2(__PP6126607.Filing_Type_Description_,IN,__CN(__CC33139)));
      __CC33119 := ['BUILDING LIEN','BUILDING LIEN RELEASE','BUILDING RELEASE','CHILD SUPPORT LIEN','CHILD SUPPORT PAYMENT','CHILD SUPPORT PAYMENT RELEASE','JUDGEMENT LIEN','JUDGMENT LIEN RELEASE','SIDEWALK LIEN','SIDEWALK LIEN RELEASE','SIDEWALK RELEASE','WELFARE LIEN'];
      SELF.Is_Other_Lien_ := __AND(__CN(__PP6126607.Landlord_Tenant_Dispute_Flag_ = FALSE),__OP2(__PP6126607.Filing_Type_Description_,IN,__CN(__CC33119)));
      __CC33144 := ['RENEW/REOPEN SMALL CLAIM JUDGM','SMALL CLAIMS JUDGMENT','SMALL CLAIMS JUDGMENT RELEASE'];
      SELF.Is_Small_Cliams_Judgment_ := __AND(__CN(__PP6126607.Landlord_Tenant_Dispute_Flag_ = FALSE),__OP2(__PP6126607.Filing_Type_Description_,IN,__CN(__CC33144)));
      SELF.Is_Total_Tax_Lien_ := __OR(__OR(__PP6126607.Is_Federal_Tax_Lien_,__PP6126607.Is_State_Tax_Lien_),__PP6126607.Is_Other_Tax_Lien_);
      SELF := __PP6126607;
    END;
    SELF.All_Lien_Data_ := __PROJECT(__EE6126711,__ND6126611__Project(LEFT));
    SELF := __PP6126464;
  END;
  SHARED __EE6126822 := PROJECT(__EE6126460,__ND6126468__Project(LEFT));
  EXPORT __ST96561_Layout := RECORD
    KEL.typ.nint Address_Rank_;
    KEL.typ.nstr Address_Type_;
    KEL.typ.nstr State_Code_;
    KEL.typ.nstr County_Code_;
    KEL.typ.nstr Address_Status_;
    KEL.typ.nstr Latitude_;
    KEL.typ.nstr Longitude_;
    KEL.typ.nstr Geo_Blk_;
    KEL.typ.nstr Addr_Full_;
    KEL.typ.nstr Primary_Range_;
    KEL.typ.nstr Predirectional_;
    KEL.typ.nstr Primary_Name_;
    KEL.typ.nstr Suffix_;
    KEL.typ.nstr Postdirectional_;
    KEL.typ.nstr Unit_Designation_;
    KEL.typ.nstr Secondary_Range_;
    KEL.typ.nstr Postal_City_;
    KEL.typ.nstr State_;
    KEL.typ.nstr Z_I_P5_;
    KEL.typ.nstr Z_I_P4_;
    KEL.typ.nstr Addr1_From_Components_;
    KEL.typ.nkdate Sort_Field_;
    KEL.typ.nkdate Hierarchy_Date_First_Seen_;
    KEL.typ.nkdate Hierarchy_Date_Last_Seen_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  EXPORT __ST399578_Layout := RECORD
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
    KEL.typ.ndataset(__ST96561_Layout) Address_Hierarchy_Set_;
    KEL.typ.ndataset(__ST397428_Layout) All_Lien_Data_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  SHARED __ST399578_Layout __ND6125272__Project(__ST288824_Layout __PP6125268) := TRANSFORM
    __EE6126825 := __PP6125268.Address_Hierarchy_Set_;
    SELF.Address_Hierarchy_Set_ := __PROJECT(__EE6126825,__ST96561_Layout);
    SELF := __PP6125268;
  END;
  EXPORT __ENH_Person_10 := PROJECT(__EE6126822,__ND6125272__Project(LEFT));
END;
