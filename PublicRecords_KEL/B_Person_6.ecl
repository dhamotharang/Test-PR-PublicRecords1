//HPCC Systems KEL Compiler Version 1.3.0
IMPORT KEL13 AS KEL;
IMPORT B_Education_7,B_Person_10,B_Person_7,CFG_Compile,E_Education,E_Person,E_Person_Education,FN_Compile FROM PublicRecords_KEL;
IMPORT * FROM KEL13.Null;
EXPORT B_Person_6(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE
  SHARED VIRTUAL TYPEOF(B_Education_7(__in,__cfg).__ENH_Education_7) __ENH_Education_7 := B_Education_7(__in,__cfg).__ENH_Education_7;
  SHARED VIRTUAL TYPEOF(B_Person_7(__in,__cfg).__ENH_Person_7) __ENH_Person_7 := B_Person_7(__in,__cfg).__ENH_Person_7;
  SHARED VIRTUAL TYPEOF(E_Person_Education(__in,__cfg).__Result) __E_Person_Education := E_Person_Education(__in,__cfg).__Result;
  SHARED __EE3565886 := __ENH_Person_7;
  SHARED __EE3565890 := __ENH_Education_7;
  SHARED __EE3565896 := __EE3565890(__EE3565890.Edu_Rec_Flag_);
  SHARED __EE3565888 := __E_Person_Education;
  SHARED __EE3566624 := __EE3565888(__NN(__EE3565888.Subject_) AND __NN(__EE3565888.Edu_));
  SHARED __ST390344_Layout := RECORD
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
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_First_Seen_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  __JC3566642(B_Education_7(__in,__cfg).__ST205043_Layout __EE3565896, E_Person_Education(__in,__cfg).Layout __EE3566624) := __EEQP(__EE3566624.Edu_,__EE3565896.UID);
  __ST390344_Layout __JT3566642(B_Education_7(__in,__cfg).__ST205043_Layout __l, E_Person_Education(__in,__cfg).Layout __r) := TRANSFORM
    SELF.Raw_A_I_D__1_ := __r.Raw_A_I_D_;
    SELF.Data_Sources__1_ := __r.Data_Sources_;
    SELF := __l;
    SELF := __r;
  END;
  SHARED __EE3566643 := JOIN(__EE3566624,__EE3565896,__JC3566642(RIGHT,LEFT),__JT3566642(RIGHT,LEFT),INNER,HASH);
  SHARED __ST390508_Layout := RECORD
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
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_First_Seen_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  __ST390508_Layout __JT3566698(__ST390344_Layout __l, E_Education(__in,__cfg).College_Characteristics_Layout __r) := TRANSFORM
    SELF.Archive___Date_ := __r.Archive___Date_;
    SELF.Date_First_Seen_ := __r.Date_First_Seen_;
    SELF.Date_Last_Seen_ := __r.Date_Last_Seen_;
    SELF.Date_Vendor_First_Reported_ := __r.Date_Vendor_First_Reported_;
    SELF.Date_Vendor_Last_Reported_ := __r.Date_Vendor_Last_Reported_;
    SELF.Hybrid_Archive_Date_ := __r.Hybrid_Archive_Date_;
    SELF.Vault_Date_First_Seen_ := __r.Vault_Date_First_Seen_;
    SELF.Vault_Date_Last_Seen_ := __r.Vault_Date_Last_Seen_;
    SELF.__RecordCount := __r.__RecordCount;
    SELF := __l;
    SELF := __r;
  END;
  SHARED __EE3566699 := NORMALIZE(__EE3566643,__T(LEFT.College_Characteristics_),__JT3566698(LEFT,RIGHT));
  SHARED __ST389057_Layout := RECORD
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
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_First_Seen_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  SHARED __ST389057_Layout __ND3566749__Project(__ST390508_Layout __PP3566700) := TRANSFORM
    SELF.Raw_A_I_D_ := __PP3566700.Raw_A_I_D__1_;
    SELF.Data_Sources_ := __PP3566700.Data_Sources__1_;
    SELF.UID := __PP3566700.Edu_;
    SELF.U_I_D__1_ := __PP3566700.Subject_;
    SELF := __PP3566700;
  END;
  SHARED __EE3566850 := PROJECT(__EE3566699,__ND3566749__Project(LEFT));
  SHARED __ST389912_Layout := RECORD
    KEL.typ.nstr File_Type_;
    KEL.typ.ntyp(E_Person().Typ) U_I_D__1_;
    KEL.typ.nkdate Exp1_;
    KEL.typ.nkdate Exp2_;
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
  SHARED __ST389912_Layout __ND3568717__Project(__ST389057_Layout __PP3566851) := TRANSFORM
    SELF.Exp1_ := KEL.era.ToDate(__PP3566851.Date_First_Seen_);
    SELF.Exp2_ := KEL.era.ToDate(__PP3566851.Date_Last_Seen_);
    SELF := __PP3566851;
  END;
  SHARED __EE3568718 := PROJECT(__EE3566850,__ND3568717__Project(LEFT));
  SHARED __ST389936_Layout := RECORD
    KEL.typ.nkdate M_I_N___Exp1_;
    KEL.typ.nkdate M_A_X___Exp1_;
    KEL.typ.nstr File_Type_;
    KEL.typ.ntyp(E_Person().Typ) U_I_D__1_;
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
  SHARED __EE3568750 := PROJECT(__CLEANANDDO(__EE3568718,TABLE(__EE3568718,{KEL.typ.int __RecordCount := SUM(GROUP,__RecordCount),KEL.typ.epoch Archive___Date_ := KEL.era.SimpleRoll(GROUP,Archive___Date_,MIN,FALSE),KEL.typ.epoch Date_First_Seen_ := KEL.era.SimpleRoll(GROUP,Date_First_Seen_,MIN,FALSE),KEL.typ.epoch Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Date_Last_Seen_,MAX,FALSE),KEL.typ.epoch Date_Vendor_First_Reported_ := KEL.era.SimpleRoll(GROUP,Date_Vendor_First_Reported_,MIN,FALSE),KEL.typ.epoch Date_Vendor_Last_Reported_ := KEL.era.SimpleRoll(GROUP,Date_Vendor_Last_Reported_,MAX,FALSE),KEL.typ.epoch Hybrid_Archive_Date_ := KEL.era.SimpleRoll(GROUP,Hybrid_Archive_Date_,MIN,FALSE),KEL.typ.epoch Vault_Date_First_Seen_ := KEL.era.SimpleRoll(GROUP,Vault_Date_First_Seen_,MIN,FALSE),KEL.typ.epoch Vault_Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Vault_Date_Last_Seen_,MAX,FALSE),KEL.Aggregates.MinNG(__EE3568718.Exp1_) M_I_N___Exp1_,KEL.Aggregates.MaxNG(__EE3568718.Exp2_) M_A_X___Exp1_,File_Type_,U_I_D__1_},File_Type_,U_I_D__1_,MERGE)),__ST389936_Layout);
  SHARED __ST393178_Layout := RECORD
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
    KEL.typ.ndataset(B_Person_7(__in,__cfg).__ST72578_Layout) All_Lien_Data_;
    KEL.typ.nstr Curr_Addr_Full_;
    KEL.typ.ndataset(B_Person_10(__in,__cfg).__ST71252_Layout) Curr_Addr_Full_Set_;
    KEL.typ.ndataset(B_Person_10(__in,__cfg).__ST71252_Layout) Recent_Addr_Full_Set_;
    KEL.typ.ndataset(__ST389936_Layout) Exp1_;
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
  __JC3568756(B_Person_7(__in,__cfg).__ST206076_Layout __EE3565886, __ST389936_Layout __EE3568750) := __EEQP(__EE3565886.UID,__EE3568750.U_I_D__1_);
  __ST393178_Layout __Join__ST393178_Layout(B_Person_7(__in,__cfg).__ST206076_Layout __r, DATASET(__ST389936_Layout) __recs) := TRANSFORM
    SELF := __r;
    SELF.Exp1_ := __CN(__recs);
  END;
  SHARED __EE3568939 := DENORMALIZE(DISTRIBUTE(__EE3565886,HASH(UID)),DISTRIBUTE(__EE3568750,HASH(U_I_D__1_)),__JC3568756(LEFT,RIGHT),GROUP,__Join__ST393178_Layout(LEFT,ROWS(RIGHT)),LOCAL);
  SHARED __ST394037_Layout := RECORD
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
    KEL.typ.ndataset(B_Person_7(__in,__cfg).__ST72578_Layout) All_Lien_Data_;
    KEL.typ.nstr Curr_Addr_Full_;
    KEL.typ.ndataset(B_Person_10(__in,__cfg).__ST71252_Layout) Curr_Addr_Full_Set_;
    KEL.typ.ndataset(B_Person_10(__in,__cfg).__ST71252_Layout) Recent_Addr_Full_Set_;
    KEL.typ.ndataset(__ST389936_Layout) Exp1_;
    KEL.typ.bool Person_Education_ := FALSE;
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
  SHARED __EE3567985 := __EE3566624;
  SHARED __EE3567982 := __EE3565890;
  SHARED __EE3568000 := __EE3567982.Data_Sources_;
  __JC3569937(E_Education(__in,__cfg).Data_Sources_Layout __EE3568000) := __T(__OP2(__EE3568000.Source_,=,__CN('AY')));
  SHARED __EE3569938 := __EE3567982(EXISTS(__CHILDJOINFILTER(__EE3568000,__JC3569937)));
  __JC3569965(E_Person_Education(__in,__cfg).Layout __EE3567985, B_Education_7(__in,__cfg).__ST205043_Layout __EE3569938) := __EEQP(__EE3567985.Edu_,__EE3569938.UID);
  SHARED __EE3569983 := JOIN(__EE3567985,__EE3569938,__JC3569965(LEFT,RIGHT),TRANSFORM(E_Person_Education(__in,__cfg).Layout,SELF:=LEFT),HASH,KEEP(1));
  __JC3569989(__ST393178_Layout __EE3568939, E_Person_Education(__in,__cfg).Layout __EE3569983) := __EEQP(__EE3568939.UID,__EE3569983.Subject_);
  __JF3569989(E_Person_Education(__in,__cfg).Layout __EE3569983) := __NN(__EE3569983.Subject_);
  SHARED __EE3570152 := JOIN(__EE3568939,__EE3569983,__JC3569989(LEFT,RIGHT),TRANSFORM(__ST394037_Layout,SELF:=LEFT,SELF.Person_Education_:=__JF3569989(RIGHT)),HASH,LEFT OUTER,KEEP(1));
  EXPORT __ST387197_Layout := RECORD
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
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_First_Seen_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  EXPORT __ST73533_Layout := RECORD
    KEL.typ.nstr File_Type_;
    KEL.typ.nkdate Date_First_Seen_Min_;
    KEL.typ.nkdate Date_Last_Seen_Max_;
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
  EXPORT __ST203122_Layout := RECORD
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
    KEL.typ.ndataset(__ST387197_Layout) All_Lien_Data_;
    KEL.typ.nkdate B_U_I_L_D___D_A_T_E_;
    KEL.typ.nstr Curr_Addr_Full_;
    KEL.typ.ndataset(B_Person_10(__in,__cfg).__ST71252_Layout) Curr_Addr_Full_Set_;
    KEL.typ.ndataset(__ST73533_Layout) Edu_Rec_Ver_Source_List_Pre_;
    KEL.typ.ndataset(B_Person_10(__in,__cfg).__ST71252_Layout) Prev_Addr_Full_Set_;
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
  SHARED __ST203122_Layout __ND3570161__Project(__ST394037_Layout __PP3570157) := TRANSFORM
    __EE3570367 := __PP3570157.All_Lien_Data_;
    __ST387197_Layout __ND3570375__Project(B_Person_7(__in,__cfg).__ST72578_Layout __PP3570371) := TRANSFORM
      __CC26459 := ['CORRECTED FEDERAL TAX LIEN','FEDERAL TAX LIEN','FEDERAL TAX LIEN RELEASE','FEDERAL TAX RELEASE'];
      SELF.Is_Federal_Tax_Lien_ := __AND(__CN(__PP3570371.Landlord_Tenant_Dispute_Flag_ = FALSE),__OP2(__PP3570371.Filing_Type_Description_,IN,__CN(__CC26459)));
      __CC26480 := ['CITY TAX LIEN','COUNTY TAX LIEN','COUNTY TAX LIEN RELEASE','CITY TAX LIEN RELEASE','ILLINOIS TAX LIEN','ILLINOIS TAX RELEASE','PROPERTY TAX LIEN','PROPERTY TAX RELEASE'];
      SELF.Is_Other_Tax_Lien_ := __AND(__CN(__PP3570371.Landlord_Tenant_Dispute_Flag_ = FALSE),__OP2(__PP3570371.Filing_Type_Description_,IN,__CN(__CC26480)));
      __CC26470 := ['JUDGMENT or STATE TAX LIEN','STATE TAX LIEN','STATE TAX LIEN RELEASE','STATE TAX LIEN RENEWAL','STATE TAX LIEN RENEWED','STATE TAX RELEASE','STATE TAX WARRANT','STATE TAX WARRANT RELEASE','STATE TAX WARRANT RENEWED'];
      SELF.Is_State_Tax_Lien_ := __AND(__CN(__PP3570371.Landlord_Tenant_Dispute_Flag_ = FALSE),__OP2(__PP3570371.Filing_Type_Description_,IN,__CN(__CC26470)));
      SELF := __PP3570371;
    END;
    SELF.All_Lien_Data_ := __PROJECT(__EE3570367,__ND3570375__Project(LEFT));
    __CC10511 := KEL.Routines.NDateFromNInteger(__CN(20160129));
    __CC10515 := FN_Compile(__cfg).FN_G_E_T_B_U_I_L_D_D_A_T_E(__ECAST(KEL.typ.nstr,__CN('asl_build_version')));
    SELF.B_U_I_L_D___D_A_T_E_ := KEL.Routines.MinN(IF(__PP3570157.Person_Education_,__ECAST(KEL.typ.nkdate,__CC10511),__ECAST(KEL.typ.nkdate,__CC10515)),__CN(__cfg.CurrentDate));
    __EE3570155 := __PP3570157.Exp1_;
    __ST73533_Layout __ND3570445__Project(__ST389936_Layout __PP3570441) := TRANSFORM
      SELF.Date_First_Seen_Min_ := __PP3570441.M_I_N___Exp1_;
      SELF.Date_Last_Seen_Max_ := __PP3570441.M_A_X___Exp1_;
      SELF := __PP3570441;
    END;
    SELF.Edu_Rec_Ver_Source_List_Pre_ := __PROJECT(__EE3570155,__ND3570445__Project(LEFT));
    __EE3570460 := __PP3570157.Recent_Addr_Full_Set_;
    __BS3570464 := __T(__EE3570460);
    __EE3570472 := __BS3570464(__T(__OP2(__T(__EE3570460).Addr_Full_,<>,__PP3570157.Curr_Addr_Full_)));
    __EE3570481 := TOPN(__EE3570472(__NN(__EE3570472.Sort_Field_)),1, -__T(__EE3570472.Sort_Field_),__T(Address_Rank_),__T(Address_Type_),__T(Address_Status_),__T(State_Code_),__T(County_Code_),__T(Latitude_),__T(Longitude_),__T(Geo_Blk_),__T(Addr_Full_),__T(Primary_Range_),__T(Predirectional_),__T(Primary_Name_),__T(Suffix_),__T(Postdirectional_),__T(Unit_Designation_),__T(Secondary_Range_),__T(Postal_City_),__T(State_),__T(Z_I_P5_),__T(Z_I_P4_),__T(Addr1_From_Components_));
    SELF.Prev_Addr_Full_Set_ := __CN(__EE3570481);
    SELF := __PP3570157;
  END;
  EXPORT __ENH_Person_6 := PROJECT(__EE3570152,__ND3570161__Project(LEFT));
END;
