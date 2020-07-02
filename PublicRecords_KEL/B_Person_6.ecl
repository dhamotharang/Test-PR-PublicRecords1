﻿//HPCC Systems KEL Compiler Version 1.2.2-dev
IMPORT KEL12 AS KEL;
IMPORT B_Education_7,B_Person_7,B_Person_Lien_Judgment_8,CFG_Compile,E_Address,E_Education,E_Geo_Link,E_Lien_Judgment,E_Person,E_Person_Address,E_Person_Education,E_Person_Lien_Judgment,E_Zip_Code,FN_Compile FROM PublicRecords_KEL;
IMPORT * FROM KEL12.Null;
EXPORT B_Person_6(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE
  SHARED VIRTUAL TYPEOF(B_Education_7().__ENH_Education_7) __ENH_Education_7 := B_Education_7(__in,__cfg).__ENH_Education_7;
  SHARED VIRTUAL TYPEOF(B_Person_7().__ENH_Person_7) __ENH_Person_7 := B_Person_7(__in,__cfg).__ENH_Person_7;
  SHARED VIRTUAL TYPEOF(E_Person_Education().__Result) __E_Person_Education := E_Person_Education(__in,__cfg).__Result;
  SHARED __EE391233 := __ENH_Person_7;
  SHARED __EE391237 := __ENH_Education_7;
  SHARED __EE391243 := __EE391237(__EE391237.Edu_Rec_Flag_);
  SHARED __EE391235 := __E_Person_Education;
  SHARED __EE391831 := __EE391235(__NN(__EE391235.Subject_) AND __NN(__EE391235.Edu_));
  SHARED __ST387766_Layout := RECORD
    KEL.typ.nuid UID;
    KEL.typ.nstr College_Name_;
    KEL.typ.nstr L_N_College_Name_;
    KEL.typ.nstr Sequence_;
    KEL.typ.nstr Key_;
    KEL.typ.nstr Raw_A_I_D_;
    KEL.typ.ndataset(E_Education(__in,__cfg).College_Characteristics_Layout) College_Characteristics_;
    KEL.typ.ndataset(E_Education(__in,__cfg).Data_Sources_Layout) Data_Sources_;
    KEL.typ.bool Edu_Rec_Flag_ := FALSE;
    KEL.typ.ntyp(E_Education().Typ) Edu_;
    KEL.typ.ntyp(E_Person().Typ) Subject_;
    KEL.typ.nstr D_I_D_;
    KEL.typ.nkdate Process_Date_;
    KEL.typ.nstr Historical_Flag_;
    KEL.typ.nstr Class_;
    KEL.typ.nstr College_Class_;
    KEL.typ.nstr College_Major_;
    KEL.typ.nstr New_College_Major_;
    KEL.typ.nstr Head_Of_Household_First_Name_;
    KEL.typ.nstr Head_Of_Household_Gender_Code_;
    KEL.typ.nstr Head_Of_Household_Gender_;
    KEL.typ.nstr Raw_A_I_D__1_;
    KEL.typ.ndataset(E_Person_Education(__in,__cfg).Data_Sources_Layout) Data_Sources__1_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Date_Vendor_First_Reported_ := 0;
    KEL.typ.epoch Date_Vendor_Last_Reported_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  __JC391849(B_Education_7(__in,__cfg).__ST166070_Layout __EE391243, E_Person_Education(__in,__cfg).Layout __EE391831) := __EEQP(__EE391831.Edu_,__EE391243.UID);
  __ST387766_Layout __JT391849(B_Education_7(__in,__cfg).__ST166070_Layout __l, E_Person_Education(__in,__cfg).Layout __r) := TRANSFORM
    SELF.Raw_A_I_D__1_ := __r.Raw_A_I_D_;
    SELF.Data_Sources__1_ := __r.Data_Sources_;
    SELF := __l;
    SELF := __r;
  END;
  SHARED __EE391850 := JOIN(__EE391831,__EE391243,__JC391849(RIGHT,LEFT),__JT391849(RIGHT,LEFT),INNER,HASH);
  SHARED __ST387901_Layout := RECORD
    KEL.typ.nuid UID;
    KEL.typ.nstr College_Name_;
    KEL.typ.nstr L_N_College_Name_;
    KEL.typ.nstr Sequence_;
    KEL.typ.nstr Key_;
    KEL.typ.nstr Raw_A_I_D_;
    KEL.typ.ndataset(E_Education(__in,__cfg).College_Characteristics_Layout) College_Characteristics_;
    KEL.typ.ndataset(E_Education(__in,__cfg).Data_Sources_Layout) Data_Sources_;
    KEL.typ.bool Edu_Rec_Flag_ := FALSE;
    KEL.typ.ntyp(E_Education().Typ) Edu_;
    KEL.typ.ntyp(E_Person().Typ) Subject_;
    KEL.typ.nstr D_I_D_;
    KEL.typ.nkdate Process_Date_;
    KEL.typ.nstr Historical_Flag_;
    KEL.typ.nstr Class_;
    KEL.typ.nstr College_Class_;
    KEL.typ.nstr College_Major_;
    KEL.typ.nstr New_College_Major_;
    KEL.typ.nstr Head_Of_Household_First_Name_;
    KEL.typ.nstr Head_Of_Household_Gender_Code_;
    KEL.typ.nstr Head_Of_Household_Gender_;
    KEL.typ.nstr Raw_A_I_D__1_;
    KEL.typ.ndataset(E_Person_Education(__in,__cfg).Data_Sources_Layout) Data_Sources__1_;
    KEL.typ.nstr College_Code_;
    KEL.typ.nstr College_Type_;
    KEL.typ.nstr File_Type_;
    KEL.typ.nstr School_Size_Code_;
    KEL.typ.nstr Competitive_Code_;
    KEL.typ.nstr Tuition_Code_;
    KEL.typ.nstr Tier_;
    KEL.typ.nstr Tier2_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Date_Vendor_First_Reported_ := 0;
    KEL.typ.epoch Date_Vendor_Last_Reported_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  __ST387901_Layout __JT391905(__ST387766_Layout __l, E_Education(__in,__cfg).College_Characteristics_Layout __r) := TRANSFORM
    SELF.__RecordCount := __r.__RecordCount;
    SELF := __l;
    SELF := __r;
  END;
  SHARED __EE391906 := NORMALIZE(__EE391850,__T(LEFT.College_Characteristics_),__JT391905(LEFT,RIGHT));
  SHARED __ST386721_Layout := RECORD
    KEL.typ.ntyp(E_Education().Typ) Edu_;
    KEL.typ.ntyp(E_Person().Typ) Subject_;
    KEL.typ.nstr D_I_D_;
    KEL.typ.nkdate Process_Date_;
    KEL.typ.nstr Historical_Flag_;
    KEL.typ.nstr Class_;
    KEL.typ.nstr College_Class_;
    KEL.typ.nstr College_Major_;
    KEL.typ.nstr New_College_Major_;
    KEL.typ.nstr Head_Of_Household_First_Name_;
    KEL.typ.nstr Head_Of_Household_Gender_Code_;
    KEL.typ.nstr Head_Of_Household_Gender_;
    KEL.typ.nstr Raw_A_I_D_;
    KEL.typ.ndataset(E_Person_Education(__in,__cfg).Data_Sources_Layout) Data_Sources_;
    KEL.typ.ntyp(E_Education().Typ) UID;
    KEL.typ.nstr College_Code_;
    KEL.typ.nstr College_Type_;
    KEL.typ.nstr File_Type_;
    KEL.typ.nstr School_Size_Code_;
    KEL.typ.nstr Competitive_Code_;
    KEL.typ.nstr Tuition_Code_;
    KEL.typ.nstr Tier_;
    KEL.typ.nstr Tier2_;
    KEL.typ.ntyp(E_Person().Typ) U_I_D__1_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Date_Vendor_First_Reported_ := 0;
    KEL.typ.epoch Date_Vendor_Last_Reported_ := 0;
  END;
  SHARED __ST386721_Layout __ND393373__Project(__ST387901_Layout __PP391907) := TRANSFORM
    SELF.Raw_A_I_D_ := __PP391907.Raw_A_I_D__1_;
    SELF.Data_Sources_ := __PP391907.Data_Sources__1_;
    SELF.UID := __PP391907.Edu_;
    SELF.U_I_D__1_ := __PP391907.Subject_;
    SELF := __PP391907;
  END;
  SHARED __EE393374 := PROJECT(__EE391906,__ND393373__Project(LEFT));
  SHARED __ST387407_Layout := RECORD
    KEL.typ.nstr File_Type_;
    KEL.typ.ntyp(E_Person().Typ) U_I_D__1_;
    KEL.typ.nkdate Exp1_;
    KEL.typ.nkdate Exp2_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Date_Vendor_First_Reported_ := 0;
    KEL.typ.epoch Date_Vendor_Last_Reported_ := 0;
  END;
  SHARED __ST387407_Layout __ND393406__Project(__ST386721_Layout __PP393375) := TRANSFORM
    SELF.Exp1_ := KEL.era.ToDate(__PP393375.Date_First_Seen_);
    SELF.Exp2_ := KEL.era.ToDate(__PP393375.Date_Last_Seen_);
    SELF := __PP393375;
  END;
  SHARED __EE393425 := PROJECT(__EE393374,__ND393406__Project(LEFT));
  SHARED __ST387431_Layout := RECORD
    KEL.typ.nkdate M_I_N___Exp1_;
    KEL.typ.nkdate M_A_X___Exp1_;
    KEL.typ.nstr File_Type_;
    KEL.typ.ntyp(E_Person().Typ) U_I_D__1_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Date_Vendor_First_Reported_ := 0;
    KEL.typ.epoch Date_Vendor_Last_Reported_ := 0;
  END;
  SHARED __EE393450 := PROJECT(__CLEANANDDO(__EE393425,TABLE(__EE393425,{KEL.typ.epoch Archive___Date_ := KEL.era.SimpleRoll(GROUP,Archive___Date_,MIN,FALSE),KEL.typ.epoch Date_First_Seen_ := KEL.era.SimpleRoll(GROUP,Date_First_Seen_,MIN,FALSE),KEL.typ.epoch Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Date_Last_Seen_,MAX,FALSE),KEL.typ.epoch Date_Vendor_First_Reported_ := KEL.era.SimpleRoll(GROUP,Date_Vendor_First_Reported_,MIN,FALSE),KEL.typ.epoch Date_Vendor_Last_Reported_ := KEL.era.SimpleRoll(GROUP,Date_Vendor_Last_Reported_,MAX,FALSE),KEL.Aggregates.MinNG(__EE393425.Exp1_) M_I_N___Exp1_,KEL.Aggregates.MaxNG(__EE393425.Exp2_) M_A_X___Exp1_,File_Type_,U_I_D__1_},File_Type_,U_I_D__1_,MERGE)),__ST387431_Layout);
  SHARED __ST389103_Layout := RECORD
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
    KEL.typ.ndataset(B_Person_7(__in,__cfg).__ST59987_Layout) Address_Hierarchy_Set_;
    KEL.typ.ndataset(B_Person_7(__in,__cfg).__ST60480_Layout) All_Lien_Data_;
    KEL.typ.ndataset(__ST387431_Layout) Exp1_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Date_Vendor_First_Reported_ := 0;
    KEL.typ.epoch Date_Vendor_Last_Reported_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  __JC393456(B_Person_7(__in,__cfg).__ST166977_Layout __EE391233, __ST387431_Layout __EE393450) := __EEQP(__EE391233.UID,__EE393450.U_I_D__1_);
  __ST389103_Layout __Join__ST389103_Layout(B_Person_7(__in,__cfg).__ST166977_Layout __r, DATASET(__ST387431_Layout) __recs) := TRANSFORM
    SELF := __r;
    SELF.Exp1_ := __CN(__recs);
  END;
  SHARED __EE393548 := DENORMALIZE(DISTRIBUTE(__EE391233,HASH(UID)),DISTRIBUTE(__EE393450,HASH(U_I_D__1_)),__JC393456(LEFT,RIGHT),GROUP,__Join__ST389103_Layout(LEFT,ROWS(RIGHT)),LOCAL);
  SHARED __ST389595_Layout := RECORD
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
    KEL.typ.ndataset(B_Person_7(__in,__cfg).__ST59987_Layout) Address_Hierarchy_Set_;
    KEL.typ.ndataset(B_Person_7(__in,__cfg).__ST60480_Layout) All_Lien_Data_;
    KEL.typ.ndataset(__ST387431_Layout) Exp1_;
    KEL.typ.bool Person_Education_ := FALSE;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Date_Vendor_First_Reported_ := 0;
    KEL.typ.epoch Date_Vendor_Last_Reported_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  SHARED __EE392845 := __EE391831;
  SHARED __EE392842 := __EE391237;
  SHARED __EE392860 := __EE392842.Data_Sources_;
  __JC394202(E_Education(__in,__cfg).Data_Sources_Layout __EE392860) := __T(__OP2(__EE392860.Source_,=,__CN('AY')));
  SHARED __EE394203 := __EE392842(EXISTS(__CHILDJOINFILTER(__EE392860,__JC394202)));
  __JC394230(E_Person_Education(__in,__cfg).Layout __EE392845, B_Education_7(__in,__cfg).__ST166070_Layout __EE394203) := __EEQP(__EE392845.Edu_,__EE394203.UID);
  SHARED __EE394248 := JOIN(__EE392845,__EE394203,__JC394230(LEFT,RIGHT),TRANSFORM(E_Person_Education(__in,__cfg).Layout,SELF:=LEFT),HASH,KEEP(1));
  __JC394254(__ST389103_Layout __EE393548, E_Person_Education(__in,__cfg).Layout __EE394248) := __EEQP(__EE393548.UID,__EE394248.Subject_);
  __JF394254(E_Person_Education(__in,__cfg).Layout __EE394248) := __NN(__EE394248.Subject_);
  SHARED __EE394347 := JOIN(__EE393548,__EE394248,__JC394254(LEFT,RIGHT),TRANSFORM(__ST389595_Layout,SELF:=LEFT,SELF.Person_Education_:=__JF394254(RIGHT)),HASH,LEFT OUTER,KEEP(1));
  EXPORT __ST385293_Layout := RECORD
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
    KEL.typ.epoch Date_Vendor_First_Reported_ := 0;
    KEL.typ.epoch Date_Vendor_Last_Reported_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  EXPORT __ST60795_Layout := RECORD
    KEL.typ.nstr File_Type_;
    KEL.typ.nkdate Date_First_Seen_Min_;
    KEL.typ.nkdate Date_Last_Seen_Max_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Date_Vendor_First_Reported_ := 0;
    KEL.typ.epoch Date_Vendor_Last_Reported_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  EXPORT __ST164233_Layout := RECORD
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
    KEL.typ.ndataset(B_Person_7(__in,__cfg).__ST59987_Layout) Address_Hierarchy_Set_;
    KEL.typ.ndataset(__ST385293_Layout) All_Lien_Data_;
    KEL.typ.nkdate B_U_I_L_D___D_A_T_E_;
    KEL.typ.ndataset(__ST60795_Layout) Edu_Rec_Ver_Source_List_Pre_;
    KEL.typ.ndataset(B_Person_7(__in,__cfg).__ST59987_Layout) Recent_Addr_Full_Set_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Date_Vendor_First_Reported_ := 0;
    KEL.typ.epoch Date_Vendor_Last_Reported_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  SHARED __ST164233_Layout __ND394356__Project(__ST389595_Layout __PP394352) := TRANSFORM
    __EE394485 := __PP394352.All_Lien_Data_;
    __ST385293_Layout __ND394493__Project(B_Person_7(__in,__cfg).__ST60480_Layout __PP394489) := TRANSFORM
      __CC37684 := ['CORRECTED FEDERAL TAX LIEN','FEDERAL TAX LIEN','FEDERAL TAX LIEN RELEASE','FEDERAL TAX RELEASE'];
      SELF.Is_Federal_Tax_Lien_ := __AND(__CN(__PP394489.Landlord_Tenant_Dispute_Flag_ = FALSE),__OP2(__PP394489.Filing_Type_Description_,IN,__CN(__CC37684)));
      __CC37705 := ['CITY TAX LIEN','COUNTY TAX LIEN','COUNTY TAX LIEN RELEASE','CITY TAX LIEN RELEASE','ILLINOIS TAX LIEN','ILLINOIS TAX RELEASE','PROPERTY TAX LIEN','PROPERTY TAX RELEASE'];
      SELF.Is_Other_Tax_Lien_ := __AND(__CN(__PP394489.Landlord_Tenant_Dispute_Flag_ = FALSE),__OP2(__PP394489.Filing_Type_Description_,IN,__CN(__CC37705)));
      __CC37695 := ['JUDGMENT or STATE TAX LIEN','STATE TAX LIEN','STATE TAX LIEN RELEASE','STATE TAX LIEN RENEWAL','STATE TAX LIEN RENEWED','STATE TAX RELEASE','STATE TAX WARRANT','STATE TAX WARRANT RELEASE','STATE TAX WARRANT RENEWED'];
      SELF.Is_State_Tax_Lien_ := __AND(__CN(__PP394489.Landlord_Tenant_Dispute_Flag_ = FALSE),__OP2(__PP394489.Filing_Type_Description_,IN,__CN(__CC37695)));
      SELF := __PP394489;
    END;
    SELF.All_Lien_Data_ := __PROJECT(__EE394485,__ND394493__Project(LEFT));
    __CC9331 := KEL.Routines.DateFromInteger(__CN(20160129));
    __CC9335 := FN_Compile(__cfg).FN_G_E_T_B_U_I_L_D_D_A_T_E(__ECAST(KEL.typ.nstr,__CN('asl_build_version')));
    SELF.B_U_I_L_D___D_A_T_E_ := KEL.Routines.MinN(IF(__PP394352.Person_Education_,__ECAST(KEL.typ.nkdate,__CC9331),__ECAST(KEL.typ.nkdate,__CC9335)),__CN(__cfg.CurrentDate));
    __EE394350 := __PP394352.Exp1_;
    __ST60795_Layout __ND394559__Project(__ST387431_Layout __PP394555) := TRANSFORM
      SELF.Date_First_Seen_Min_ := __PP394555.M_I_N___Exp1_;
      SELF.Date_Last_Seen_Max_ := __PP394555.M_A_X___Exp1_;
      SELF := __PP394555;
    END;
    SELF.Edu_Rec_Ver_Source_List_Pre_ := __PROJECT(__EE394350,__ND394559__Project(LEFT));
    __EE394574 := __PP394352.Address_Hierarchy_Set_;
    __CC15618 := [0,91,92,93,94,95,96,97,98,99];
    __BS394578 := __T(__EE394574);
    __EE394610 := __BS394578(__T(__AND(__AND(__AND(__CN(FN_Compile(__cfg).FN_Is_Not_Enough_To_Clean(__ECAST(KEL.typ.nstr,__T(__EE394574).Address_Rank_)) = FALSE),__NOT(__OP2(__T(__EE394574).Address_Rank_,IN,__CN(__CC15618)))),__OR(__OP2(__T(__EE394574).Address_Type_,<>,__CN('BUS')),__NT(__T(__EE394574).Address_Type_))),__OR(__OP2(__T(__EE394574).Addr1_From_Components_,<>,__CN('P')),__NT(__T(__EE394574).Addr1_From_Components_)))));
    __EE394621 := TOPN(__EE394610(__NN(__EE394610.Address_Rank_) AND __NN(__EE394610.Sort_Field_)),2,__T(__EE394610.Address_Rank_), -__T(__EE394610.Sort_Field_),__T(Address_Type_),__T(State_Code_),__T(County_Code_),__T(Geo_Blk_),__T(Addr_Full_),__T(Primary_Range_),__T(Predirectional_),__T(Primary_Name_),__T(Suffix_),__T(Postdirectional_),__T(Unit_Designation_),__T(Secondary_Range_),__T(Postal_City_),__T(State_),__T(Z_I_P5_),__T(Z_I_P4_),__T(Addr1_From_Components_));
    SELF.Recent_Addr_Full_Set_ := __CN(__EE394621);
    SELF := __PP394352;
  END;
  EXPORT __ENH_Person_6 := PROJECT(__EE394347,__ND394356__Project(LEFT));
END;
