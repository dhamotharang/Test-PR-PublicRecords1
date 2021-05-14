//HPCC Systems KEL Compiler Version 1.6.0
IMPORT KEL16 AS KEL;
IMPORT B_Education_3,B_Education_7,B_Person_3,B_Person_4,B_Person_5,B_Sele_Person_3,CFG_Compile,E_Business_Org,E_Business_Sele,E_Business_Sele_Overflow,E_Business_Ult,E_Education,E_Person,E_Person_Education,E_Sele_Person,E_Surname FROM PublicRecords_KEL.KEL_Queries_MAS_Business;
IMPORT * FROM KEL16.Null;
EXPORT B_Person_2(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE
  SHARED VIRTUAL TYPEOF(B_Education_3(__in,__cfg).__ENH_Education_3) __ENH_Education_3 := B_Education_3(__in,__cfg).__ENH_Education_3;
  SHARED VIRTUAL TYPEOF(B_Person_3(__in,__cfg).__ENH_Person_3) __ENH_Person_3 := B_Person_3(__in,__cfg).__ENH_Person_3;
  SHARED VIRTUAL TYPEOF(E_Person_Education(__in,__cfg).__Result) __E_Person_Education := E_Person_Education(__in,__cfg).__Result;
  SHARED VIRTUAL TYPEOF(B_Sele_Person_3(__in,__cfg).__ENH_Sele_Person_3) __ENH_Sele_Person_3 := B_Sele_Person_3(__in,__cfg).__ENH_Sele_Person_3;
  SHARED __EE2862667 := __ENH_Person_3;
  SHARED __EE2862670 := __ENH_Sele_Person_3;
  SHARED __EE2864729 := __EE2862670(__T(__AND(__EE2862670.Two_Years_,__CN(__NN(__EE2862670.Contact_)))));
  SHARED __ST1091669_Layout := RECORD
    KEL.typ.ntyp(E_Person().Typ) UID;
    KEL.typ.ntyp(E_Business_Sele().Typ) Legal_;
    KEL.typ.nint Ult_I_D_;
    KEL.typ.nint Org_I_D_;
    KEL.typ.nint Sele_I_D_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
  END;
  SHARED __EE2864755 := PROJECT(__EE2864729,TRANSFORM(__ST1091669_Layout,SELF.UID := LEFT.Contact_,SELF := LEFT));
  SHARED __ST1091694_Layout := RECORD
    KEL.typ.int C_O_U_N_T___Sele_Person_ := 0;
    KEL.typ.ntyp(E_Person().Typ) UID;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
  END;
  SHARED __EE2864768 := PROJECT(__CLEANANDDO(__EE2864755,TABLE(__EE2864755,{KEL.typ.epoch Archive___Date_ := KEL.era.SimpleRoll(GROUP,Archive___Date_,MIN,FALSE),KEL.typ.epoch Date_First_Seen_ := KEL.era.SimpleRoll(GROUP,Date_First_Seen_,MIN,FALSE),KEL.typ.epoch Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Date_Last_Seen_,MAX,FALSE),KEL.typ.epoch Hybrid_Archive_Date_ := KEL.era.SimpleRoll(GROUP,Hybrid_Archive_Date_,MIN,FALSE),KEL.typ.epoch Vault_Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Vault_Date_Last_Seen_,MAX,NMAX),KEL.typ.int C_O_U_N_T___Sele_Person_ := COUNT(GROUP),UID},UID,MERGE)),__ST1091694_Layout);
  SHARED __ST1092230_Layout := RECORD
    KEL.typ.nuid UID;
    KEL.typ.nstr Lex_I_D_Segment_;
    KEL.typ.nstr Lex_I_D_Segment2_;
    KEL.typ.ndataset(E_Person(__in,__cfg).Full_Name_Layout) Full_Name_;
    KEL.typ.ndataset(B_Person_4(__in,__cfg).__ST207314_Layout) Reported_Dates_Of_Birth_;
    KEL.typ.ndataset(E_Person(__in,__cfg).Reported_Dates_Of_Death_Layout) Reported_Dates_Of_Death_;
    KEL.typ.ndataset(E_Person(__in,__cfg).Data_Sources_Layout) Data_Sources_;
    KEL.typ.ndataset(E_Person(__in,__cfg).Conceal_Carry_Layout) Conceal_Carry_;
    KEL.typ.ndataset(E_Person(__in,__cfg).Hunt_Fish_Layout) Hunt_Fish_;
    KEL.typ.ndataset(E_Person(__in,__cfg).Consumer_Statement_Flags_Layout) Consumer_Statement_Flags_;
    KEL.typ.ndataset(E_Person(__in,__cfg).Thrive_Layout) Thrive_;
    KEL.typ.nint Age_;
    KEL.typ.ndataset(B_Person_4(__in,__cfg).__ST551562_Layout) All_Lien_Data_;
    KEL.typ.int Drg_Bk_Cnt10_Y_ := 0;
    KEL.typ.int Drg_Crim_Fel_Cnt7_Y_ := 0;
    KEL.typ.int Drg_Crim_Nfel_Cnt7_Y_ := 0;
    KEL.typ.ndataset(B_Person_5(__in,__cfg).__ST108632_Layout) Edu_Coll_Rec_Ver_Source_List_;
    KEL.typ.int P_L___Drg_Judg_Cnt7_Y_ := 0;
    KEL.typ.int P_L___Drg_L_T_D_Cnt7_Y_ := 0;
    KEL.typ.int P_L___Drg_Lien_Cnt7_Y_ := 0;
    KEL.typ.str P___Lex_I_D_Seen_Flag_ := '';
    KEL.typ.nkdate Select_Age_;
    KEL.typ.int C_O_U_N_T___Sele_Person_ := 0;
    KEL.typ.ntyp(E_Person().Typ) U_I_D__1_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  __JC2864774(B_Person_3(__in,__cfg).__ST199498_Layout __EE2862667, __ST1091694_Layout __EE2864768) := __EEQP(__EE2862667.UID,__EE2864768.UID);
  __ST1092230_Layout __JT2864774(B_Person_3(__in,__cfg).__ST199498_Layout __l, __ST1091694_Layout __r) := TRANSFORM
    SELF.U_I_D__1_ := __r.UID;
    SELF := __l;
    SELF := __r;
  END;
  SHARED __EE2864882 := JOIN(__EE2862667,__EE2864768,__JC2864774(LEFT,RIGHT),__JT2864774(LEFT,RIGHT),LEFT OUTER,HASH);
  SHARED __ST1093412_Layout := RECORD
    KEL.typ.nuid UID;
    KEL.typ.nstr Lex_I_D_Segment_;
    KEL.typ.nstr Lex_I_D_Segment2_;
    KEL.typ.ndataset(E_Person(__in,__cfg).Full_Name_Layout) Full_Name_;
    KEL.typ.ndataset(B_Person_4(__in,__cfg).__ST207314_Layout) Reported_Dates_Of_Birth_;
    KEL.typ.ndataset(E_Person(__in,__cfg).Reported_Dates_Of_Death_Layout) Reported_Dates_Of_Death_;
    KEL.typ.ndataset(E_Person(__in,__cfg).Data_Sources_Layout) Data_Sources_;
    KEL.typ.ndataset(E_Person(__in,__cfg).Conceal_Carry_Layout) Conceal_Carry_;
    KEL.typ.ndataset(E_Person(__in,__cfg).Hunt_Fish_Layout) Hunt_Fish_;
    KEL.typ.ndataset(E_Person(__in,__cfg).Consumer_Statement_Flags_Layout) Consumer_Statement_Flags_;
    KEL.typ.ndataset(E_Person(__in,__cfg).Thrive_Layout) Thrive_;
    KEL.typ.nint Age_;
    KEL.typ.ndataset(B_Person_4(__in,__cfg).__ST551562_Layout) All_Lien_Data_;
    KEL.typ.int Drg_Bk_Cnt10_Y_ := 0;
    KEL.typ.int Drg_Crim_Fel_Cnt7_Y_ := 0;
    KEL.typ.int Drg_Crim_Nfel_Cnt7_Y_ := 0;
    KEL.typ.ndataset(B_Person_5(__in,__cfg).__ST108632_Layout) Edu_Coll_Rec_Ver_Source_List_;
    KEL.typ.int P_L___Drg_Judg_Cnt7_Y_ := 0;
    KEL.typ.int P_L___Drg_L_T_D_Cnt7_Y_ := 0;
    KEL.typ.int P_L___Drg_Lien_Cnt7_Y_ := 0;
    KEL.typ.str P___Lex_I_D_Seen_Flag_ := '';
    KEL.typ.nkdate Select_Age_;
    KEL.typ.int C_O_U_N_T___Sele_Person_ := 0;
    KEL.typ.ntyp(E_Person().Typ) U_I_D__1_;
    KEL.typ.bool Person_Education_ := FALSE;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  SHARED __EE1091061 := __E_Person_Education;
  SHARED __EE2864312 := __EE1091061(__NN(__EE1091061.Edu_) AND __NN(__EE1091061.Subject_));
  SHARED __EE2862841 := __ENH_Education_3;
  SHARED __EE2862847 := __EE2862841(__EE2862841.Edu_Rec_Flag_);
  __JC2864342(E_Person_Education(__in,__cfg).Layout __EE2864312, B_Education_7(__in,__cfg).__ST217119_Layout __EE2862847) := __EEQP(__EE2864312.Edu_,__EE2862847.UID);
  SHARED __EE2864343 := JOIN(__EE2864312,__EE2862847,__JC2864342(LEFT,RIGHT),TRANSFORM(E_Person_Education(__in,__cfg).Layout,SELF:=LEFT),HASH,KEEP(1));
  __JC2864888(__ST1092230_Layout __EE2864882, E_Person_Education(__in,__cfg).Layout __EE2864343) := __EEQP(__EE2864882.UID,__EE2864343.Subject_);
  __JF2864888(E_Person_Education(__in,__cfg).Layout __EE2864343) := __NN(__EE2864343.Subject_);
  SHARED __EE2864995 := JOIN(__EE2864882,__EE2864343,__JC2864888(LEFT,RIGHT),TRANSFORM(__ST1093412_Layout,SELF:=LEFT,SELF.Person_Education_:=__JF2864888(RIGHT)),HASH,LEFT OUTER,KEEP(1));
  EXPORT __ST190116_Layout := RECORD
    KEL.typ.nuid UID;
    KEL.typ.nstr Lex_I_D_Segment_;
    KEL.typ.nstr Lex_I_D_Segment2_;
    KEL.typ.ndataset(E_Person(__in,__cfg).Full_Name_Layout) Full_Name_;
    KEL.typ.ndataset(B_Person_4(__in,__cfg).__ST207314_Layout) Reported_Dates_Of_Birth_;
    KEL.typ.ndataset(E_Person(__in,__cfg).Reported_Dates_Of_Death_Layout) Reported_Dates_Of_Death_;
    KEL.typ.ndataset(E_Person(__in,__cfg).Data_Sources_Layout) Data_Sources_;
    KEL.typ.ndataset(E_Person(__in,__cfg).Conceal_Carry_Layout) Conceal_Carry_;
    KEL.typ.ndataset(E_Person(__in,__cfg).Hunt_Fish_Layout) Hunt_Fish_;
    KEL.typ.ndataset(E_Person(__in,__cfg).Consumer_Statement_Flags_Layout) Consumer_Statement_Flags_;
    KEL.typ.ndataset(E_Person(__in,__cfg).Thrive_Layout) Thrive_;
    KEL.typ.nint Age_;
    KEL.typ.nbool Age_More_Than18_;
    KEL.typ.int Contact_Bus_Cnt_ := 0;
    KEL.typ.int Drg_Bk_Cnt10_Y_ := 0;
    KEL.typ.int Drg_Cnt_Contact_ := 0;
    KEL.typ.int P_L___Drg_Crim_Fel_Cnt7_Y_ := 0;
    KEL.typ.int P_L___Drg_Crim_Nfel_Cnt7_Y_ := 0;
    KEL.typ.int P_L___Drg_Judg_Cnt7_Y_ := 0;
    KEL.typ.int P_L___Drg_L_T_D_Cnt7_Y_ := 0;
    KEL.typ.int P_L___Drg_Lien_Cnt7_Y_ := 0;
    KEL.typ.str P_L___Edu_Coll_Rec_Flag_Ev_ := '';
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  SHARED __ST190116_Layout __ND2865000__Project(__ST1093412_Layout __PP2864996) := TRANSFORM
    SELF.Age_More_Than18_ := __OP2(__PP2864996.Age_,>=,__CN(18));
    SELF.Contact_Bus_Cnt_ := __PP2864996.C_O_U_N_T___Sele_Person_;
    SELF.Drg_Cnt_Contact_ := KEL.Routines.BoundsFold(__PP2864996.Drg_Crim_Fel_Cnt7_Y_ + __PP2864996.Drg_Crim_Nfel_Cnt7_Y_ + __PP2864996.Drg_Bk_Cnt10_Y_ + __PP2864996.P_L___Drg_Judg_Cnt7_Y_ + __PP2864996.P_L___Drg_L_T_D_Cnt7_Y_ + __PP2864996.P_L___Drg_Lien_Cnt7_Y_,0,999999);
    __CC13972 := -99999;
    SELF.P_L___Drg_Crim_Fel_Cnt7_Y_ := IF(__PP2864996.P___Lex_I_D_Seen_Flag_ = '0',__CC13972,KEL.Routines.BoundsFold(__PP2864996.Drg_Crim_Fel_Cnt7_Y_,0,999));
    SELF.P_L___Drg_Crim_Nfel_Cnt7_Y_ := IF(__PP2864996.P___Lex_I_D_Seen_Flag_ = '0',__CC13972,KEL.Routines.BoundsFold(__PP2864996.Drg_Crim_Nfel_Cnt7_Y_,0,999));
    __CC14092 := '-99999';
    __CC14094 := '-99998';
    SELF.P_L___Edu_Coll_Rec_Flag_Ev_ := MAP(__PP2864996.P___Lex_I_D_Seen_Flag_ = '0'=>__CC14092, NOT (__PP2864996.Person_Education_)=>__CC14094,EXISTS(__T(__PP2864996.Edu_Coll_Rec_Ver_Source_List_))=>'1','0');
    SELF := __PP2864996;
  END;
  EXPORT __ENH_Person_2 := PROJECT(__EE2864995,__ND2865000__Project(LEFT));
END;
