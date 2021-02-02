//HPCC Systems KEL Compiler Version 1.5.0rc1
IMPORT KEL15 AS KEL;
IMPORT B_Person_11,CFG_Compile,E_Address,E_Geo_Link,E_Person,E_Person_Address,E_Zip_Code,FN_Compile FROM PublicRecords_KEL;
IMPORT * FROM KEL15.Null;
EXPORT B_Person_10(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE
  SHARED VIRTUAL TYPEOF(B_Person_11(__in,__cfg).__ENH_Person_11) __ENH_Person_11 := B_Person_11(__in,__cfg).__ENH_Person_11;
  SHARED VIRTUAL TYPEOF(E_Person_Address(__in,__cfg).__Result) __E_Person_Address := E_Person_Address(__in,__cfg).__Result;
  SHARED __EE5218307 := __ENH_Person_11;
  SHARED __EE5218321 := __E_Person_Address;
  SHARED __EE5218331 := __EE5218321(__NN(__EE5218321.Subject_));
  SHARED __ST355015_Layout := RECORD
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
  __ST355015_Layout __JT5218339(E_Person_Address(__in,__cfg).Layout __l, E_Person_Address(__in,__cfg).Address_Hierarchy_Layout __r) := TRANSFORM
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
  SHARED __EE5218433 := NORMALIZE(__EE5218331,__T(LEFT.Address_Hierarchy_),__JT5218339(LEFT,RIGHT));
  SHARED __ST354270_Layout := RECORD
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
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  SHARED __ST354270_Layout __ND5218438__Project(__ST355015_Layout __PP5218434) := TRANSFORM
    SELF.____grp___U_I_D_ := __PP5218434.Subject_;
    SELF.Addr_Full_ := __OP2(__OP2(__OP2(__OP2(__OP2(__OP2(__OP2(__OP2(__OP2(__OP2(IF(__T(__OR(__OR(__CN(FN_Compile(__cfg).FN_Is_Not_Enough_To_Clean(__ECAST(KEL.typ.nstr,__PP5218434.Primary_Range__1_))),__OP2(__PP5218434.Primary_Range__1_,=,__CN(''))),__NT(__PP5218434.Primary_Range__1_))),__ECAST(KEL.typ.nstr,__CN('')),__ECAST(KEL.typ.nstr,__OP2(__FN1(TRIM,__PP5218434.Primary_Range__1_),+,__CN(' ')))),+,IF(__T(__OR(__OR(__CN(FN_Compile(__cfg).FN_Is_Not_Enough_To_Clean(__ECAST(KEL.typ.nstr,__PP5218434.Predirectional__1_))),__OP2(__PP5218434.Predirectional__1_,=,__CN(''))),__NT(__PP5218434.Predirectional__1_))),__ECAST(KEL.typ.nstr,__CN('')),__ECAST(KEL.typ.nstr,__OP2(__FN1(TRIM,__PP5218434.Predirectional__1_),+,__CN(' '))))),+,IF(__T(__OR(__OR(__CN(FN_Compile(__cfg).FN_Is_Not_Enough_To_Clean(__ECAST(KEL.typ.nstr,__PP5218434.Primary_Name__1_))),__OP2(__PP5218434.Primary_Name__1_,=,__CN(''))),__NT(__PP5218434.Primary_Name__1_))),__ECAST(KEL.typ.nstr,__CN('')),__ECAST(KEL.typ.nstr,__OP2(__FN1(TRIM,__PP5218434.Primary_Name__1_),+,__CN(' '))))),+,IF(__T(__OR(__OR(__CN(FN_Compile(__cfg).FN_Is_Not_Enough_To_Clean(__ECAST(KEL.typ.nstr,__PP5218434.Suffix__1_))),__OP2(__PP5218434.Suffix__1_,=,__CN(''))),__NT(__PP5218434.Suffix__1_))),__ECAST(KEL.typ.nstr,__CN('')),__ECAST(KEL.typ.nstr,__OP2(__FN1(TRIM,__PP5218434.Suffix__1_),+,__CN(' '))))),+,IF(__T(__OR(__OR(__CN(FN_Compile(__cfg).FN_Is_Not_Enough_To_Clean(__ECAST(KEL.typ.nstr,__PP5218434.Postdirectional__1_))),__OP2(__PP5218434.Postdirectional__1_,=,__CN(''))),__NT(__PP5218434.Postdirectional__1_))),__ECAST(KEL.typ.nstr,__CN('')),__ECAST(KEL.typ.nstr,__OP2(__FN1(TRIM,__PP5218434.Postdirectional__1_),+,__CN(' '))))),+,IF(__T(__OR(__OR(__CN(FN_Compile(__cfg).FN_Is_Not_Enough_To_Clean(__ECAST(KEL.typ.nstr,__PP5218434.Unit_Designation_))),__OP2(__PP5218434.Unit_Designation_,=,__CN(''))),__NT(__PP5218434.Unit_Designation_))),__ECAST(KEL.typ.nstr,__CN('')),__ECAST(KEL.typ.nstr,__OP2(__FN1(TRIM,__PP5218434.Unit_Designation_),+,__CN(' '))))),+,IF(__T(__OR(__OR(__CN(FN_Compile(__cfg).FN_Is_Not_Enough_To_Clean(__ECAST(KEL.typ.nstr,__PP5218434.Secondary_Range__1_))),__OP2(__PP5218434.Secondary_Range__1_,=,__CN(''))),__NT(__PP5218434.Secondary_Range__1_))),__ECAST(KEL.typ.nstr,__CN('')),__ECAST(KEL.typ.nstr,__OP2(__FN1(TRIM,__PP5218434.Secondary_Range__1_),+,__CN(' '))))),+,IF(__T(__OR(__OR(__CN(FN_Compile(__cfg).FN_Is_Not_Enough_To_Clean(__ECAST(KEL.typ.nstr,__PP5218434.Postal_City_))),__OP2(__PP5218434.Postal_City_,=,__CN(''))),__NT(__PP5218434.Postal_City_))),__ECAST(KEL.typ.nstr,__CN('')),__ECAST(KEL.typ.nstr,__OP2(__FN1(TRIM,__PP5218434.Postal_City_),+,__CN(' '))))),+,IF(__T(__OR(__OR(__CN(FN_Compile(__cfg).FN_Is_Not_Enough_To_Clean(__ECAST(KEL.typ.nstr,__PP5218434.State_))),__OP2(__PP5218434.State_,=,__CN(''))),__NT(__PP5218434.State_))),__ECAST(KEL.typ.nstr,__CN('')),__ECAST(KEL.typ.nstr,__OP2(__FN1(TRIM,__PP5218434.State_),+,__CN(' '))))),+,IF(__T(__OR(__OR(__CN(FN_Compile(__cfg).FN_Is_Not_Enough_To_Clean(__ECAST(KEL.typ.nstr,__ECAST(KEL.typ.nstr,__PP5218434.Z_I_P5__1_)))),__OP2(__PP5218434.Z_I_P5__1_,=,__CN(0))),__NT(__PP5218434.Z_I_P5__1_))),__ECAST(KEL.typ.nstr,__CN('')),__ECAST(KEL.typ.nstr,__OP2(__FN1(TRIM,__ECAST(KEL.typ.nstr,__PP5218434.Z_I_P5__1_)),+,__CN(' '))))),+,IF(__T(__OR(__OR(__CN(FN_Compile(__cfg).FN_Is_Not_Enough_To_Clean(__ECAST(KEL.typ.nstr,__ECAST(KEL.typ.nstr,__PP5218434.Z_I_P4_)))),__OP2(__PP5218434.Z_I_P4_,=,__CN(0))),__NT(__PP5218434.Z_I_P4_))),__ECAST(KEL.typ.nstr,__CN('')),__ECAST(KEL.typ.nstr,__FN1(TRIM,__ECAST(KEL.typ.nstr,__PP5218434.Z_I_P4_)))));
    SELF.Primary_Range_ := IF(__T(__OR(__OR(__CN(FN_Compile(__cfg).FN_Is_Not_Enough_To_Clean(__ECAST(KEL.typ.nstr,__PP5218434.Primary_Range__1_))),__OP2(__PP5218434.Primary_Range__1_,=,__CN(''))),__NT(__PP5218434.Primary_Range__1_))),__ECAST(KEL.typ.nstr,__CN('')),__ECAST(KEL.typ.nstr,__FN1(TRIM,__PP5218434.Primary_Range__1_)));
    SELF.Predirectional_ := IF(__T(__OR(__OR(__CN(FN_Compile(__cfg).FN_Is_Not_Enough_To_Clean(__ECAST(KEL.typ.nstr,__PP5218434.Predirectional__1_))),__OP2(__PP5218434.Predirectional__1_,=,__CN(''))),__NT(__PP5218434.Predirectional__1_))),__ECAST(KEL.typ.nstr,__CN('')),__ECAST(KEL.typ.nstr,__FN1(TRIM,__PP5218434.Predirectional__1_)));
    SELF.Primary_Name_ := IF(__T(__OR(__OR(__CN(FN_Compile(__cfg).FN_Is_Not_Enough_To_Clean(__ECAST(KEL.typ.nstr,__PP5218434.Primary_Name__1_))),__OP2(__PP5218434.Primary_Name__1_,=,__CN(''))),__NT(__PP5218434.Primary_Name__1_))),__ECAST(KEL.typ.nstr,__CN('')),__ECAST(KEL.typ.nstr,__FN1(TRIM,__PP5218434.Primary_Name__1_)));
    SELF.Suffix_ := IF(__T(__OR(__OR(__CN(FN_Compile(__cfg).FN_Is_Not_Enough_To_Clean(__ECAST(KEL.typ.nstr,__PP5218434.Suffix__1_))),__OP2(__PP5218434.Suffix__1_,=,__CN(''))),__NT(__PP5218434.Suffix__1_))),__ECAST(KEL.typ.nstr,__CN('')),__ECAST(KEL.typ.nstr,__FN1(TRIM,__PP5218434.Suffix__1_)));
    SELF.Postdirectional_ := IF(__T(__OR(__OR(__CN(FN_Compile(__cfg).FN_Is_Not_Enough_To_Clean(__ECAST(KEL.typ.nstr,__PP5218434.Postdirectional__1_))),__OP2(__PP5218434.Postdirectional__1_,=,__CN(''))),__NT(__PP5218434.Postdirectional__1_))),__ECAST(KEL.typ.nstr,__CN('')),__ECAST(KEL.typ.nstr,__FN1(TRIM,__PP5218434.Postdirectional__1_)));
    SELF.Unit_Designation_ := IF(__T(__OR(__OR(__CN(FN_Compile(__cfg).FN_Is_Not_Enough_To_Clean(__ECAST(KEL.typ.nstr,__PP5218434.Unit_Designation_))),__OP2(__PP5218434.Unit_Designation_,=,__CN(''))),__NT(__PP5218434.Unit_Designation_))),__ECAST(KEL.typ.nstr,__CN('')),__ECAST(KEL.typ.nstr,__FN1(TRIM,__PP5218434.Unit_Designation_)));
    SELF.Secondary_Range_ := IF(__T(__OR(__OR(__CN(FN_Compile(__cfg).FN_Is_Not_Enough_To_Clean(__ECAST(KEL.typ.nstr,__PP5218434.Secondary_Range__1_))),__OP2(__PP5218434.Secondary_Range__1_,=,__CN(''))),__NT(__PP5218434.Secondary_Range__1_))),__ECAST(KEL.typ.nstr,__CN('')),__ECAST(KEL.typ.nstr,__FN1(TRIM,__PP5218434.Secondary_Range__1_)));
    SELF.Postal_City_ := IF(__T(__OR(__OR(__CN(FN_Compile(__cfg).FN_Is_Not_Enough_To_Clean(__ECAST(KEL.typ.nstr,__PP5218434.Postal_City_))),__OP2(__PP5218434.Postal_City_,=,__CN(''))),__NT(__PP5218434.Postal_City_))),__ECAST(KEL.typ.nstr,__CN('')),__ECAST(KEL.typ.nstr,__FN1(TRIM,__PP5218434.Postal_City_)));
    SELF.State_ := IF(__T(__OR(__OR(__CN(FN_Compile(__cfg).FN_Is_Not_Enough_To_Clean(__ECAST(KEL.typ.nstr,__PP5218434.State_))),__OP2(__PP5218434.State_,=,__CN(''))),__NT(__PP5218434.State_))),__ECAST(KEL.typ.nstr,__CN('')),__ECAST(KEL.typ.nstr,__FN1(TRIM,__PP5218434.State_)));
    SELF.Z_I_P5_ := IF(__T(__OR(__OR(__CN(FN_Compile(__cfg).FN_Is_Not_Enough_To_Clean(__ECAST(KEL.typ.nstr,__ECAST(KEL.typ.nstr,__PP5218434.Z_I_P5__1_)))),__OP2(__PP5218434.Z_I_P5__1_,=,__CN(0))),__NT(__PP5218434.Z_I_P5__1_))),__ECAST(KEL.typ.nstr,__CN('')),__ECAST(KEL.typ.nstr,__FN1(TRIM,__ECAST(KEL.typ.nstr,__PP5218434.Z_I_P5__1_))));
    SELF.Z_I_P4_ := IF(__T(__OR(__OR(__CN(FN_Compile(__cfg).FN_Is_Not_Enough_To_Clean(__ECAST(KEL.typ.nstr,__ECAST(KEL.typ.nstr,__PP5218434.Z_I_P4_)))),__OP2(__PP5218434.Z_I_P4_,=,__CN(0))),__NT(__PP5218434.Z_I_P4_))),__ECAST(KEL.typ.nstr,__CN('')),__ECAST(KEL.typ.nstr,__FN1(TRIM,__ECAST(KEL.typ.nstr,__PP5218434.Z_I_P4_))));
    SELF.Addr1_From_Components_ := FN_Compile(__cfg).FN__fn_Addr1_From_Components(__ECAST(KEL.typ.nstr,__PP5218434.Primary_Range__1_),__ECAST(KEL.typ.nstr,__PP5218434.Predirectional__1_),__ECAST(KEL.typ.nstr,__PP5218434.Primary_Name__1_),__ECAST(KEL.typ.nstr,__PP5218434.Suffix__1_),__ECAST(KEL.typ.nstr,__PP5218434.Postdirectional__1_),__ECAST(KEL.typ.nstr,__PP5218434.Unit_Designation_),__ECAST(KEL.typ.nstr,__PP5218434.Secondary_Range__1_));
    SELF.Sort_Field_ := KEL.era.ToDate(__PP5218434.Date_Last_Seen_);
    SELF := __PP5218434;
  END;
  SHARED __EE5219010 := PROJECT(TABLE(PROJECT(__EE5218433,__ND5218438__Project(LEFT)),{KEL.typ.int __RecordCount := SUM(GROUP,__RecordCount),KEL.typ.epoch Archive___Date_ := KEL.era.SimpleRoll(GROUP,Archive___Date_,MIN,FALSE),KEL.typ.epoch Date_First_Seen_ := KEL.era.SimpleRoll(GROUP,Date_First_Seen_,MIN,FALSE),KEL.typ.epoch Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Date_Last_Seen_,MAX,FALSE),KEL.typ.epoch Hybrid_Archive_Date_ := KEL.era.SimpleRoll(GROUP,Hybrid_Archive_Date_,MIN,FALSE),KEL.typ.epoch Vault_Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Vault_Date_Last_Seen_,MAX,NMAX),____grp___U_I_D_,Address_Rank_,Address_Type_,State_Code_,County_Code_,Address_Status_,Latitude_,Longitude_,Geo_Blk_,Addr_Full_,Primary_Range_,Predirectional_,Primary_Name_,Suffix_,Postdirectional_,Unit_Designation_,Secondary_Range_,Postal_City_,State_,Z_I_P5_,Z_I_P4_,Addr1_From_Components_,Sort_Field_},____grp___U_I_D_,Address_Rank_,Address_Type_,State_Code_,County_Code_,Address_Status_,Latitude_,Longitude_,Geo_Blk_,Addr_Full_,Primary_Range_,Predirectional_,Primary_Name_,Suffix_,Postdirectional_,Unit_Designation_,Secondary_Range_,Postal_City_,State_,Z_I_P5_,Z_I_P4_,Addr1_From_Components_,Sort_Field_,MERGE),__ST354270_Layout);
  SHARED __EE5219021 := GROUP(__EE5219010,____grp___U_I_D_,ALL);
  SHARED __EE5219025 := UNGROUP(TOPN(__EE5219021(__NN(__EE5219021.Address_Rank_) AND __NN(__EE5219021.Sort_Field_)),999,__T(__EE5219021.Address_Rank_), -__T(__EE5219021.Sort_Field_),__T(____grp___U_I_D_),__T(Address_Type_),__T(Address_Status_),__T(State_Code_),__T(County_Code_),__T(Latitude_),__T(Longitude_),__T(Geo_Blk_),__T(Addr_Full_),__T(Primary_Range_),__T(Predirectional_),__T(Primary_Name_),__T(Suffix_),__T(Postdirectional_),__T(Unit_Designation_),__T(Secondary_Range_),__T(Postal_City_),__T(State_),__T(Z_I_P5_),__T(Z_I_P4_),__T(Addr1_From_Components_)));
  SHARED __ST356811_Layout := RECORD
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
    KEL.typ.ndataset(B_Person_11(__in,__cfg).__ST89827_Layout) All_Lien_Data_;
    KEL.typ.ndataset(__ST354270_Layout) Exp1_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  __JC5219034(B_Person_11(__in,__cfg).__ST263379_Layout __EE5218307, __ST354270_Layout __EE5219025) := __EEQP(__EE5218307.UID,__EE5219025.____grp___U_I_D_);
  __ST356811_Layout __Join__ST356811_Layout(B_Person_11(__in,__cfg).__ST263379_Layout __r, DATASET(__ST354270_Layout) __recs) := TRANSFORM
    SELF := __r;
    SELF.Exp1_ := __CN(__recs);
  END;
  SHARED __EE5219147 := DENORMALIZE(DISTRIBUTE(__EE5218307,HASH(UID)),DISTRIBUTE(__EE5219025,HASH(____grp___U_I_D_)),__JC5219034(LEFT,RIGHT),GROUP,__Join__ST356811_Layout(LEFT,ROWS(RIGHT)),LOCAL);
  EXPORT __ST352077_Layout := RECORD
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
  SHARED __ST262826_Layout := RECORD
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
    KEL.typ.ndataset(__ST354270_Layout) Address_Hierarchy_Set_;
    KEL.typ.ndataset(__ST352077_Layout) All_Lien_Data_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  SHARED __ST262826_Layout __ND5219155__Project(__ST356811_Layout __PP5219151) := TRANSFORM
    __EE5219150 := __PP5219151.Exp1_;
    SELF.Address_Hierarchy_Set_ := __EE5219150;
    __EE5219360 := __PP5219151.All_Lien_Data_;
    __ST352077_Layout __ND5219295__Project(B_Person_11(__in,__cfg).__ST89827_Layout __PP5219291) := TRANSFORM
      __CC29875 := ['CORRECTED FEDERAL TAX LIEN','FEDERAL TAX LIEN','FEDERAL TAX LIEN RELEASE','FEDERAL TAX RELEASE'];
      SELF.Is_Federal_Tax_Lien_ := __AND(__CN(__PP5219291.Landlord_Tenant_Dispute_Flag_ = FALSE),__OP2(__PP5219291.Filing_Type_Description_,IN,__CN(__CC29875)));
      __CC29896 := ['CITY TAX LIEN','COUNTY TAX LIEN','COUNTY TAX LIEN RELEASE','CITY TAX LIEN RELEASE','ILLINOIS TAX LIEN','ILLINOIS TAX RELEASE','PROPERTY TAX LIEN','PROPERTY TAX RELEASE'];
      SELF.Is_Other_Tax_Lien_ := __AND(__CN(__PP5219291.Landlord_Tenant_Dispute_Flag_ = FALSE),__OP2(__PP5219291.Filing_Type_Description_,IN,__CN(__CC29896)));
      __CC29886 := ['JUDGMENT or STATE TAX LIEN','STATE TAX LIEN','STATE TAX LIEN RELEASE','STATE TAX LIEN RENEWAL','STATE TAX LIEN RENEWED','STATE TAX RELEASE','STATE TAX WARRANT','STATE TAX WARRANT RELEASE','STATE TAX WARRANT RENEWED'];
      SELF.Is_State_Tax_Lien_ := __AND(__CN(__PP5219291.Landlord_Tenant_Dispute_Flag_ = FALSE),__OP2(__PP5219291.Filing_Type_Description_,IN,__CN(__CC29886)));
      SELF := __PP5219291;
    END;
    SELF.All_Lien_Data_ := __PROJECT(__EE5219360,__ND5219295__Project(LEFT));
    SELF := __PP5219151;
  END;
  SHARED __EE5219468 := PROJECT(__EE5219147,__ND5219155__Project(LEFT));
  EXPORT __ST88382_Layout := RECORD
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
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  EXPORT __ST354113_Layout := RECORD
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
    KEL.typ.ndataset(__ST88382_Layout) Address_Hierarchy_Set_;
    KEL.typ.ndataset(__ST352077_Layout) All_Lien_Data_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  SHARED __ST354113_Layout __ND5217997__Project(__ST262826_Layout __PP5217993) := TRANSFORM
    __EE5219471 := __PP5217993.Address_Hierarchy_Set_;
    SELF.Address_Hierarchy_Set_ := __PROJECT(__EE5219471,__ST88382_Layout);
    SELF := __PP5217993;
  END;
  EXPORT __ENH_Person_10 := PROJECT(__EE5219468,__ND5217997__Project(LEFT));
END;
