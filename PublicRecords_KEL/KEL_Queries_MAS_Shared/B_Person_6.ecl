//HPCC Systems KEL Compiler Version 1.6.0
IMPORT KEL16 AS KEL;
IMPORT CFG_Compile,E_Address,E_Geo_Link,E_Person,E_Person_Address,E_Zip_Code,FN_Compile FROM PublicRecords_KEL.KEL_Queries_MAS_Shared;
IMPORT * FROM KEL16.Null;
EXPORT B_Person_6(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE
  SHARED VIRTUAL TYPEOF(E_Person(__in,__cfg).__Result) __E_Person := E_Person(__in,__cfg).__Result;
  SHARED VIRTUAL TYPEOF(E_Person_Address(__in,__cfg).__Result) __E_Person_Address := E_Person_Address(__in,__cfg).__Result;
  SHARED __EE182231 := __E_Person;
  SHARED __EE182245 := __E_Person_Address;
  SHARED __EE182255 := __EE182245(__NN(__EE182245.Subject_));
  SHARED __ST153649_Layout := RECORD
    KEL.typ.ntyp(E_Person().Typ) Subject_;
    KEL.typ.ntyp(E_Address().Typ) Location_;
    KEL.typ.nstr Primary_Range_;
    KEL.typ.nstr Predirectional_;
    KEL.typ.nstr Primary_Name_;
    KEL.typ.nstr Suffix_;
    KEL.typ.nstr Postdirectional_;
    KEL.typ.ntyp(E_Zip_Code().Typ) Z_I_P5_;
    KEL.typ.nstr Secondary_Range_;
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
  __ST153649_Layout __JT182263(E_Person_Address(__in,__cfg).Layout __l, E_Person_Address(__in,__cfg).Address_Hierarchy_Layout __r) := TRANSFORM
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
  SHARED __EE182347 := NORMALIZE(__EE182255,__T(LEFT.Address_Hierarchy_),__JT182263(LEFT,RIGHT));
  SHARED __ST153075_Layout := RECORD
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
  SHARED __ST153075_Layout __ND182352__Project(__ST153649_Layout __PP182348) := TRANSFORM
    SELF.____grp___U_I_D_ := __PP182348.Subject_;
    SELF.Addr_Full_ := __OP2(__OP2(__OP2(__OP2(__OP2(__OP2(__OP2(__OP2(__OP2(__OP2(IF(FN_Compile(__cfg).FN_Is_Not_Enough_To_Clean(__ECAST(KEL.typ.nstr,__PP182348.Primary_Range__1_)),__ECAST(KEL.typ.nstr,__CN('')),__ECAST(KEL.typ.nstr,__OP2(__FN1(TRIM,__PP182348.Primary_Range__1_),+,__CN(' ')))),+,IF(FN_Compile(__cfg).FN_Is_Not_Enough_To_Clean(__ECAST(KEL.typ.nstr,__PP182348.Predirectional__1_)),__ECAST(KEL.typ.nstr,__CN('')),__ECAST(KEL.typ.nstr,__OP2(__FN1(TRIM,__PP182348.Predirectional__1_),+,__CN(' '))))),+,IF(FN_Compile(__cfg).FN_Is_Not_Enough_To_Clean(__ECAST(KEL.typ.nstr,__PP182348.Primary_Name__1_)),__ECAST(KEL.typ.nstr,__CN('')),__ECAST(KEL.typ.nstr,__OP2(__FN1(TRIM,__PP182348.Primary_Name__1_),+,__CN(' '))))),+,IF(FN_Compile(__cfg).FN_Is_Not_Enough_To_Clean(__ECAST(KEL.typ.nstr,__PP182348.Suffix__1_)),__ECAST(KEL.typ.nstr,__CN('')),__ECAST(KEL.typ.nstr,__OP2(__FN1(TRIM,__PP182348.Suffix__1_),+,__CN(' '))))),+,IF(FN_Compile(__cfg).FN_Is_Not_Enough_To_Clean(__ECAST(KEL.typ.nstr,__PP182348.Postdirectional__1_)),__ECAST(KEL.typ.nstr,__CN('')),__ECAST(KEL.typ.nstr,__OP2(__FN1(TRIM,__PP182348.Postdirectional__1_),+,__CN(' '))))),+,IF(FN_Compile(__cfg).FN_Is_Not_Enough_To_Clean(__ECAST(KEL.typ.nstr,__PP182348.Unit_Designation_)),__ECAST(KEL.typ.nstr,__CN('')),__ECAST(KEL.typ.nstr,__OP2(__FN1(TRIM,__PP182348.Unit_Designation_),+,__CN(' '))))),+,IF(FN_Compile(__cfg).FN_Is_Not_Enough_To_Clean(__ECAST(KEL.typ.nstr,__PP182348.Secondary_Range__1_)),__ECAST(KEL.typ.nstr,__CN('')),__ECAST(KEL.typ.nstr,__OP2(__FN1(TRIM,__PP182348.Secondary_Range__1_),+,__CN(' '))))),+,IF(FN_Compile(__cfg).FN_Is_Not_Enough_To_Clean(__ECAST(KEL.typ.nstr,__PP182348.Postal_City_)),__ECAST(KEL.typ.nstr,__CN('')),__ECAST(KEL.typ.nstr,__OP2(__FN1(TRIM,__PP182348.Postal_City_),+,__CN(' '))))),+,IF(FN_Compile(__cfg).FN_Is_Not_Enough_To_Clean(__ECAST(KEL.typ.nstr,__PP182348.State_)),__ECAST(KEL.typ.nstr,__CN('')),__ECAST(KEL.typ.nstr,__OP2(__FN1(TRIM,__PP182348.State_),+,__CN(' '))))),+,IF(FN_Compile(__cfg).FN_Is_Not_Enough_To_Clean_Int(__ECAST(KEL.typ.nstr,__PP182348.Z_I_P5__1_)),__ECAST(KEL.typ.nstr,__CN('')),__ECAST(KEL.typ.nstr,__OP2(__FN1(TRIM,__FN3(INTFORMAT,__PP182348.Z_I_P5__1_,__CN(5),__CN(1))),+,__CN(' '))))),+,IF(FN_Compile(__cfg).FN_Is_Not_Enough_To_Clean_Int(__ECAST(KEL.typ.nstr,__PP182348.Z_I_P4_)),__ECAST(KEL.typ.nstr,__CN('')),__ECAST(KEL.typ.nstr,__FN1(TRIM,__FN3(INTFORMAT,__PP182348.Z_I_P4_,__CN(4),__CN(1))))));
    SELF.Primary_Range_ := IF(FN_Compile(__cfg).FN_Is_Not_Enough_To_Clean(__ECAST(KEL.typ.nstr,__PP182348.Primary_Range__1_)),__ECAST(KEL.typ.nstr,__CN('')),__ECAST(KEL.typ.nstr,__FN1(TRIM,__PP182348.Primary_Range__1_)));
    SELF.Predirectional_ := IF(FN_Compile(__cfg).FN_Is_Not_Enough_To_Clean(__ECAST(KEL.typ.nstr,__PP182348.Predirectional__1_)),__ECAST(KEL.typ.nstr,__CN('')),__ECAST(KEL.typ.nstr,__FN1(TRIM,__PP182348.Predirectional__1_)));
    SELF.Primary_Name_ := IF(FN_Compile(__cfg).FN_Is_Not_Enough_To_Clean(__ECAST(KEL.typ.nstr,__PP182348.Primary_Name__1_)),__ECAST(KEL.typ.nstr,__CN('')),__ECAST(KEL.typ.nstr,__FN1(TRIM,__PP182348.Primary_Name__1_)));
    SELF.Suffix_ := IF(FN_Compile(__cfg).FN_Is_Not_Enough_To_Clean(__ECAST(KEL.typ.nstr,__PP182348.Suffix__1_)),__ECAST(KEL.typ.nstr,__CN('')),__ECAST(KEL.typ.nstr,__FN1(TRIM,__PP182348.Suffix__1_)));
    SELF.Postdirectional_ := IF(FN_Compile(__cfg).FN_Is_Not_Enough_To_Clean(__ECAST(KEL.typ.nstr,__PP182348.Postdirectional__1_)),__ECAST(KEL.typ.nstr,__CN('')),__ECAST(KEL.typ.nstr,__FN1(TRIM,__PP182348.Postdirectional__1_)));
    SELF.Unit_Designation_ := IF(FN_Compile(__cfg).FN_Is_Not_Enough_To_Clean(__ECAST(KEL.typ.nstr,__PP182348.Unit_Designation_)),__ECAST(KEL.typ.nstr,__CN('')),__ECAST(KEL.typ.nstr,__FN1(TRIM,__PP182348.Unit_Designation_)));
    SELF.Secondary_Range_ := IF(FN_Compile(__cfg).FN_Is_Not_Enough_To_Clean(__ECAST(KEL.typ.nstr,__PP182348.Secondary_Range__1_)),__ECAST(KEL.typ.nstr,__CN('')),__ECAST(KEL.typ.nstr,__FN1(TRIM,__PP182348.Secondary_Range__1_)));
    SELF.Postal_City_ := IF(FN_Compile(__cfg).FN_Is_Not_Enough_To_Clean(__ECAST(KEL.typ.nstr,__PP182348.Postal_City_)),__ECAST(KEL.typ.nstr,__CN('')),__ECAST(KEL.typ.nstr,__FN1(TRIM,__PP182348.Postal_City_)));
    SELF.State_ := IF(FN_Compile(__cfg).FN_Is_Not_Enough_To_Clean(__ECAST(KEL.typ.nstr,__PP182348.State_)),__ECAST(KEL.typ.nstr,__CN('')),__ECAST(KEL.typ.nstr,__FN1(TRIM,__PP182348.State_)));
    SELF.Z_I_P5_ := IF(FN_Compile(__cfg).FN_Is_Not_Enough_To_Clean_Int(__ECAST(KEL.typ.nstr,__PP182348.Z_I_P5__1_)),__ECAST(KEL.typ.nstr,__CN('')),__ECAST(KEL.typ.nstr,__FN1(TRIM,__FN3(INTFORMAT,__PP182348.Z_I_P5__1_,__CN(5),__CN(1)))));
    SELF.Z_I_P4_ := IF(FN_Compile(__cfg).FN_Is_Not_Enough_To_Clean_Int(__ECAST(KEL.typ.nstr,__PP182348.Z_I_P4_)),__ECAST(KEL.typ.nstr,__CN('')),__ECAST(KEL.typ.nstr,__FN1(TRIM,__FN3(INTFORMAT,__PP182348.Z_I_P4_,__CN(4),__CN(1)))));
    SELF.Addr1_From_Components_ := FN_Compile(__cfg).FN__fn_Addr1_From_Components(__ECAST(KEL.typ.nstr,__PP182348.Primary_Range__1_),__ECAST(KEL.typ.nstr,__PP182348.Predirectional__1_),__ECAST(KEL.typ.nstr,__PP182348.Primary_Name__1_),__ECAST(KEL.typ.nstr,__PP182348.Suffix__1_),__ECAST(KEL.typ.nstr,__PP182348.Postdirectional__1_),__ECAST(KEL.typ.nstr,__PP182348.Unit_Designation_),__ECAST(KEL.typ.nstr,__PP182348.Secondary_Range__1_));
    SELF.Sort_Field_ := KEL.era.ToDate(__PP182348.Date_Last_Seen_);
    SELF.Hierarchy_Date_First_Seen_ := KEL.era.ToDate(__PP182348.Date_First_Seen_);
    SELF.Hierarchy_Date_Last_Seen_ := KEL.era.ToDate(__PP182348.Date_Last_Seen_);
    SELF := __PP182348;
  END;
  SHARED __EE182706 := PROJECT(TABLE(PROJECT(__EE182347,__ND182352__Project(LEFT)),{KEL.typ.int __RecordCount := SUM(GROUP,__RecordCount),KEL.typ.epoch Archive___Date_ := KEL.era.SimpleRoll(GROUP,Archive___Date_,MIN,FALSE),KEL.typ.epoch Date_First_Seen_ := KEL.era.SimpleRoll(GROUP,Date_First_Seen_,MIN,FALSE),KEL.typ.epoch Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Date_Last_Seen_,MAX,FALSE),KEL.typ.epoch Hybrid_Archive_Date_ := KEL.era.SimpleRoll(GROUP,Hybrid_Archive_Date_,MIN,FALSE),KEL.typ.epoch Vault_Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Vault_Date_Last_Seen_,MAX,NMAX),____grp___U_I_D_,Address_Rank_,Address_Type_,State_Code_,County_Code_,Address_Status_,Latitude_,Longitude_,Geo_Blk_,Addr_Full_,Primary_Range_,Predirectional_,Primary_Name_,Suffix_,Postdirectional_,Unit_Designation_,Secondary_Range_,Postal_City_,State_,Z_I_P5_,Z_I_P4_,Addr1_From_Components_,Sort_Field_,Hierarchy_Date_First_Seen_,Hierarchy_Date_Last_Seen_},____grp___U_I_D_,Address_Rank_,Address_Type_,State_Code_,County_Code_,Address_Status_,Latitude_,Longitude_,Geo_Blk_,Addr_Full_,Primary_Range_,Predirectional_,Primary_Name_,Suffix_,Postdirectional_,Unit_Designation_,Secondary_Range_,Postal_City_,State_,Z_I_P5_,Z_I_P4_,Addr1_From_Components_,Sort_Field_,Hierarchy_Date_First_Seen_,Hierarchy_Date_Last_Seen_,MERGE),__ST153075_Layout);
  SHARED __EE182717 := GROUP(__EE182706,____grp___U_I_D_,ALL);
  SHARED __EE182721 := UNGROUP(TOPN(__EE182717(__NN(__EE182717.Address_Rank_) AND __NN(__EE182717.Sort_Field_)),9999,__T(__EE182717.Address_Rank_), -__T(__EE182717.Sort_Field_),__T(____grp___U_I_D_),__T(Address_Type_),__T(Address_Status_),__T(State_Code_),__T(County_Code_),__T(Latitude_),__T(Longitude_),__T(Geo_Blk_),__T(Addr_Full_),__T(Primary_Range_),__T(Predirectional_),__T(Primary_Name_),__T(Suffix_),__T(Postdirectional_),__T(Unit_Designation_),__T(Secondary_Range_),__T(Postal_City_),__T(State_),__T(Z_I_P5_),__T(Z_I_P4_),__T(Addr1_From_Components_),__T(Hierarchy_Date_First_Seen_),__T(Hierarchy_Date_Last_Seen_)));
  SHARED __ST155041_Layout := RECORD
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
    KEL.typ.ndataset(__ST153075_Layout) Exp1_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  __JC182730(E_Person(__in,__cfg).Layout __EE182231, __ST153075_Layout __EE182721) := __EEQP(__EE182231.UID,__EE182721.____grp___U_I_D_);
  __ST155041_Layout __Join__ST155041_Layout(E_Person(__in,__cfg).Layout __r, DATASET(__ST153075_Layout) __recs) := TRANSFORM
    SELF := __r;
    SELF.Exp1_ := __CN(__recs);
  END;
  SHARED __EE182826 := DENORMALIZE(DISTRIBUTE(__EE182231,HASH(UID)),DISTRIBUTE(__EE182721,HASH(____grp___U_I_D_)),__JC182730(LEFT,RIGHT),GROUP,__Join__ST155041_Layout(LEFT,ROWS(RIGHT)),LOCAL);
  SHARED __ST149548_Layout := RECORD
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
    KEL.typ.ndataset(__ST153075_Layout) Address_Hierarchy_Set_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  SHARED __ST149548_Layout __ND182834__Project(__ST155041_Layout __PP182830) := TRANSFORM
    __EE182829 := __PP182830.Exp1_;
    SELF.Address_Hierarchy_Set_ := __EE182829;
    SELF := __PP182830;
  END;
  SHARED __EE183046 := PROJECT(__EE182826,__ND182834__Project(LEFT));
  EXPORT __ST83777_Layout := RECORD
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
  EXPORT __ST152940_Layout := RECORD
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
    KEL.typ.ndataset(__ST83777_Layout) Address_Hierarchy_Set_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  SHARED __ST152940_Layout __ND181967__Project(__ST149548_Layout __PP181963) := TRANSFORM
    __EE183049 := __PP181963.Address_Hierarchy_Set_;
    SELF.Address_Hierarchy_Set_ := __PROJECT(__EE183049,__ST83777_Layout);
    SELF := __PP181963;
  END;
  EXPORT __ENH_Person_6 := PROJECT(__EE183046,__ND181967__Project(LEFT));
END;
