﻿//HPCC Systems KEL Compiler Version 1.2.2-dev
IMPORT KEL12 AS KEL;
IMPORT B_Education_7,B_Person_7,B_Person_Lien_Judgment_8,CFG_Compile,E_Address,E_Education,E_Geo_Link,E_Lien_Judgment,E_Person,E_Person_Address,E_Person_Education,E_Person_Lien_Judgment,E_Zip_Code,FN_Compile FROM PublicRecords_KEL;
IMPORT * FROM KEL12.Null;
EXPORT B_Person_6(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE
  SHARED VIRTUAL TYPEOF(B_Education_7().__ENH_Education_7) __ENH_Education_7 := B_Education_7(__in,__cfg).__ENH_Education_7;
  SHARED VIRTUAL TYPEOF(B_Person_7().__ENH_Person_7) __ENH_Person_7 := B_Person_7(__in,__cfg).__ENH_Person_7;
  SHARED VIRTUAL TYPEOF(E_Person_Education().__Result) __E_Person_Education := E_Person_Education(__in,__cfg).__Result;
  SHARED __EE366886 := __ENH_Person_7;
  SHARED __EE366890 := __ENH_Education_7;
  SHARED __EE366896 := __EE366890(__EE366890.Edu_Rec_Flag_);
  SHARED __EE366888 := __E_Person_Education;
  SHARED __EE367450 := __EE366888(__NN(__EE366888.Subject_) AND __NN(__EE366888.Edu_));
  SHARED __ST364002_Layout := RECORD
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
  __JC367468(B_Education_7(__in,__cfg).__ST165484_Layout __EE366896, E_Person_Education(__in,__cfg).Layout __EE367450) := __EEQP(__EE367450.Edu_,__EE366896.UID);
  __ST364002_Layout __JT367468(B_Education_7(__in,__cfg).__ST165484_Layout __l, E_Person_Education(__in,__cfg).Layout __r) := TRANSFORM
    SELF.Raw_A_I_D__1_ := __r.Raw_A_I_D_;
    SELF.Data_Sources__1_ := __r.Data_Sources_;
    SELF := __l;
    SELF := __r;
  END;
  SHARED __EE367469 := JOIN(__EE367450,__EE366896,__JC367468(RIGHT,LEFT),__JT367468(RIGHT,LEFT),INNER,HASH);
  SHARED __ST364137_Layout := RECORD
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
  __ST364137_Layout __JT367524(__ST364002_Layout __l, E_Education(__in,__cfg).College_Characteristics_Layout __r) := TRANSFORM
    SELF.__RecordCount := __r.__RecordCount;
    SELF := __l;
    SELF := __r;
  END;
  SHARED __EE367525 := NORMALIZE(__EE367469,__T(LEFT.College_Characteristics_),__JT367524(LEFT,RIGHT));
  SHARED __ST363008_Layout := RECORD
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
  SHARED __ST363008_Layout __ND368848__Project(__ST364137_Layout __PP367526) := TRANSFORM
    SELF.Raw_A_I_D_ := __PP367526.Raw_A_I_D__1_;
    SELF.Data_Sources_ := __PP367526.Data_Sources__1_;
    SELF.UID := __PP367526.Edu_;
    SELF.U_I_D__1_ := __PP367526.Subject_;
    SELF := __PP367526;
  END;
  SHARED __EE368849 := PROJECT(__EE367525,__ND368848__Project(LEFT));
  SHARED __ST363660_Layout := RECORD
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
  SHARED __ST363660_Layout __ND368881__Project(__ST363008_Layout __PP368850) := TRANSFORM
    SELF.Exp1_ := KEL.era.ToDate(__PP368850.Date_First_Seen_);
    SELF.Exp2_ := KEL.era.ToDate(__PP368850.Date_Last_Seen_);
    SELF := __PP368850;
  END;
  SHARED __EE368900 := PROJECT(__EE368849,__ND368881__Project(LEFT));
  SHARED __ST363684_Layout := RECORD
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
  SHARED __EE368925 := PROJECT(__CLEANANDDO(__EE368900,TABLE(__EE368900,{KEL.typ.epoch Archive___Date_ := KEL.era.SimpleRoll(GROUP,Archive___Date_,MIN,FALSE),KEL.typ.epoch Date_First_Seen_ := KEL.era.SimpleRoll(GROUP,Date_First_Seen_,MIN,FALSE),KEL.typ.epoch Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Date_Last_Seen_,MAX,FALSE),KEL.typ.epoch Date_Vendor_First_Reported_ := KEL.era.SimpleRoll(GROUP,Date_Vendor_First_Reported_,MIN,FALSE),KEL.typ.epoch Date_Vendor_Last_Reported_ := KEL.era.SimpleRoll(GROUP,Date_Vendor_Last_Reported_,MAX,FALSE),KEL.Aggregates.MinNG(__EE368900.Exp1_) M_I_N___Exp1_,KEL.Aggregates.MaxNG(__EE368900.Exp2_) M_A_X___Exp1_,File_Type_,U_I_D__1_},File_Type_,U_I_D__1_,MERGE)),__ST363684_Layout);
  SHARED __ST364993_Layout := RECORD
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
    KEL.typ.ndataset(B_Person_7(__in,__cfg).__ST60015_Layout) Address_Hierarchy_Set_;
    KEL.typ.ndataset(B_Person_7(__in,__cfg).__ST60508_Layout) All_Lien_Data_;
    KEL.typ.ndataset(__ST363684_Layout) Exp1_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Date_Vendor_First_Reported_ := 0;
    KEL.typ.epoch Date_Vendor_Last_Reported_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  __JC368931(B_Person_7(__in,__cfg).__ST166389_Layout __EE366886, __ST363684_Layout __EE368925) := __EEQP(__EE366886.UID,__EE368925.U_I_D__1_);
  __ST364993_Layout __Join__ST364993_Layout(B_Person_7(__in,__cfg).__ST166389_Layout __r, DATASET(__ST363684_Layout) __recs) := TRANSFORM
    SELF := __r;
    SELF.Exp1_ := __CN(__recs);
  END;
  SHARED __EE369006 := DENORMALIZE(DISTRIBUTE(__EE366886,HASH(UID)),DISTRIBUTE(__EE368925,HASH(U_I_D__1_)),__JC368931(LEFT,RIGHT),GROUP,__Join__ST364993_Layout(LEFT,ROWS(RIGHT)),LOCAL);
  SHARED __ST365411_Layout := RECORD
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
    KEL.typ.ndataset(B_Person_7(__in,__cfg).__ST60015_Layout) Address_Hierarchy_Set_;
    KEL.typ.ndataset(B_Person_7(__in,__cfg).__ST60508_Layout) All_Lien_Data_;
    KEL.typ.ndataset(__ST363684_Layout) Exp1_;
    KEL.typ.bool Person_Education_ := FALSE;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Date_Vendor_First_Reported_ := 0;
    KEL.typ.epoch Date_Vendor_Last_Reported_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  SHARED __EE368375 := __EE367450;
  SHARED __EE368372 := __EE366890;
  SHARED __EE368390 := __EE368372.Data_Sources_;
  __JC369571(E_Education(__in,__cfg).Data_Sources_Layout __EE368390) := __T(__OP2(__EE368390.Source_,=,__CN('AY')));
  SHARED __EE369572 := __EE368372(EXISTS(__CHILDJOINFILTER(__EE368390,__JC369571)));
  __JC369599(E_Person_Education(__in,__cfg).Layout __EE368375, B_Education_7(__in,__cfg).__ST165484_Layout __EE369572) := __EEQP(__EE368375.Edu_,__EE369572.UID);
  SHARED __EE369617 := JOIN(__EE368375,__EE369572,__JC369599(LEFT,RIGHT),TRANSFORM(E_Person_Education(__in,__cfg).Layout,SELF:=LEFT),HASH,KEEP(1));
  __JC369623(__ST364993_Layout __EE369006, E_Person_Education(__in,__cfg).Layout __EE369617) := __EEQP(__EE369006.UID,__EE369617.Subject_);
  __JF369623(E_Person_Education(__in,__cfg).Layout __EE369617) := __NN(__EE369617.Subject_);
  SHARED __EE369699 := JOIN(__EE369006,__EE369617,__JC369623(LEFT,RIGHT),TRANSFORM(__ST365411_Layout,SELF:=LEFT,SELF.Person_Education_:=__JF369623(RIGHT)),HASH,LEFT OUTER,KEEP(1));
  EXPORT __ST361683_Layout := RECORD
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
  EXPORT __ST60823_Layout := RECORD
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
  EXPORT __ST163838_Layout := RECORD
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
    KEL.typ.ndataset(B_Person_7(__in,__cfg).__ST60015_Layout) Address_Hierarchy_Set_;
    KEL.typ.ndataset(__ST361683_Layout) All_Lien_Data_;
    KEL.typ.nkdate B_U_I_L_D___D_A_T_E_;
    KEL.typ.ndataset(__ST60823_Layout) Edu_Rec_Ver_Source_List_Pre_;
    KEL.typ.ndataset(B_Person_7(__in,__cfg).__ST60015_Layout) Recent_Addr_Full_Set_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Date_Vendor_First_Reported_ := 0;
    KEL.typ.epoch Date_Vendor_Last_Reported_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  SHARED __ST163838_Layout __ND369708__Project(__ST365411_Layout __PP369704) := TRANSFORM
    __EE369816 := __PP369704.All_Lien_Data_;
    __ST361683_Layout __ND369824__Project(B_Person_7(__in,__cfg).__ST60508_Layout __PP369820) := TRANSFORM
      __CC37947 := ['CORRECTED FEDERAL TAX LIEN','FEDERAL TAX LIEN','FEDERAL TAX LIEN RELEASE','FEDERAL TAX RELEASE'];
      SELF.Is_Federal_Tax_Lien_ := __AND(__CN(__PP369820.Landlord_Tenant_Dispute_Flag_ = FALSE),__OP2(__PP369820.Filing_Type_Description_,IN,__CN(__CC37947)));
      __CC37968 := ['CITY TAX LIEN','COUNTY TAX LIEN','COUNTY TAX LIEN RELEASE','CITY TAX LIEN RELEASE','ILLINOIS TAX LIEN','ILLINOIS TAX RELEASE','PROPERTY TAX LIEN','PROPERTY TAX RELEASE'];
      SELF.Is_Other_Tax_Lien_ := __AND(__CN(__PP369820.Landlord_Tenant_Dispute_Flag_ = FALSE),__OP2(__PP369820.Filing_Type_Description_,IN,__CN(__CC37968)));
      __CC37958 := ['JUDGMENT or STATE TAX LIEN','STATE TAX LIEN','STATE TAX LIEN RELEASE','STATE TAX LIEN RENEWAL','STATE TAX LIEN RENEWED','STATE TAX RELEASE','STATE TAX WARRANT','STATE TAX WARRANT RELEASE','STATE TAX WARRANT RENEWED'];
      SELF.Is_State_Tax_Lien_ := __AND(__CN(__PP369820.Landlord_Tenant_Dispute_Flag_ = FALSE),__OP2(__PP369820.Filing_Type_Description_,IN,__CN(__CC37958)));
      SELF := __PP369820;
    END;
    SELF.All_Lien_Data_ := __PROJECT(__EE369816,__ND369824__Project(LEFT));
    __CC9660 := KEL.Routines.DateFromInteger(__CN(20160129));
    __CC9664 := FN_Compile(__cfg).FN_G_E_T_B_U_I_L_D_D_A_T_E(__ECAST(KEL.typ.nstr,__CN('asl_build_version')));
    SELF.B_U_I_L_D___D_A_T_E_ := KEL.Routines.MinN(IF(__PP369704.Person_Education_,__ECAST(KEL.typ.nkdate,__CC9660),__ECAST(KEL.typ.nkdate,__CC9664)),__CN(__cfg.CurrentDate));
    __EE369702 := __PP369704.Exp1_;
    __ST60823_Layout __ND369890__Project(__ST363684_Layout __PP369886) := TRANSFORM
      SELF.Date_First_Seen_Min_ := __PP369886.M_I_N___Exp1_;
      SELF.Date_Last_Seen_Max_ := __PP369886.M_A_X___Exp1_;
      SELF := __PP369886;
    END;
    SELF.Edu_Rec_Ver_Source_List_Pre_ := __PROJECT(__EE369702,__ND369890__Project(LEFT));
    __EE369905 := __PP369704.Address_Hierarchy_Set_;
    __CC15881 := [0,91,92,93,94,95,96,97,98,99];
    __BS369909 := __T(__EE369905);
    __EE369941 := __BS369909(__T(__AND(__AND(__AND(__CN(FN_Compile(__cfg).FN_Is_Not_Enough_To_Clean(__ECAST(KEL.typ.nstr,__T(__EE369905).Address_Rank_)) = FALSE),__NOT(__OP2(__T(__EE369905).Address_Rank_,IN,__CN(__CC15881)))),__OR(__OP2(__T(__EE369905).Address_Type_,<>,__CN('BUS')),__NT(__T(__EE369905).Address_Type_))),__OR(__OP2(__T(__EE369905).Addr1_From_Components_,<>,__CN('P')),__NT(__T(__EE369905).Addr1_From_Components_)))));
    __EE369952 := TOPN(__EE369941(__NN(__EE369941.Address_Rank_) AND __NN(__EE369941.Sort_Field_)),2,__T(__EE369941.Address_Rank_), -__T(__EE369941.Sort_Field_),__T(Address_Type_),__T(State_Code_),__T(County_Code_),__T(Geo_Blk_),__T(Addr_Full_),__T(Primary_Range_),__T(Predirectional_),__T(Primary_Name_),__T(Suffix_),__T(Postdirectional_),__T(Unit_Designation_),__T(Secondary_Range_),__T(Postal_City_),__T(State_),__T(Z_I_P5_),__T(Z_I_P4_),__T(Addr1_From_Components_));
    SELF.Recent_Addr_Full_Set_ := __CN(__EE369952);
    SELF := __PP369704;
  END;
  EXPORT __ENH_Person_6 := PROJECT(__EE369699,__ND369708__Project(LEFT));
END;
