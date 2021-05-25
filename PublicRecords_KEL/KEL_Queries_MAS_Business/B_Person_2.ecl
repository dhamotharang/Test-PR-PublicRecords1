﻿//HPCC Systems KEL Compiler Version 1.6.0
IMPORT KEL16 AS KEL;
IMPORT B_Education_3,B_Education_7,B_Person_3,B_Person_4,B_Person_5,B_Sele_Person_3,CFG_Compile,E_Business_Org,E_Business_Sele,E_Business_Sele_Overflow,E_Business_Ult,E_Education,E_Person,E_Person_Education,E_Sele_Person,E_Surname FROM PublicRecords_KEL.KEL_Queries_MAS_Business;
IMPORT * FROM KEL16.Null;
EXPORT B_Person_2(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE
  SHARED VIRTUAL TYPEOF(B_Education_3(__in,__cfg).__ENH_Education_3) __ENH_Education_3 := B_Education_3(__in,__cfg).__ENH_Education_3;
  SHARED VIRTUAL TYPEOF(B_Person_3(__in,__cfg).__ENH_Person_3) __ENH_Person_3 := B_Person_3(__in,__cfg).__ENH_Person_3;
  SHARED VIRTUAL TYPEOF(E_Person_Education(__in,__cfg).__Result) __E_Person_Education := E_Person_Education(__in,__cfg).__Result;
  SHARED VIRTUAL TYPEOF(B_Sele_Person_3(__in,__cfg).__ENH_Sele_Person_3) __ENH_Sele_Person_3 := B_Sele_Person_3(__in,__cfg).__ENH_Sele_Person_3;
  SHARED __EE2868591 := __ENH_Person_3;
  SHARED __EE2868594 := __ENH_Sele_Person_3;
  SHARED __EE2870669 := __EE2868594(__T(__AND(__EE2868594.Two_Years_,__CN(__NN(__EE2868594.Contact_)))));
  SHARED __ST1097351_Layout := RECORD
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
  SHARED __EE2870695 := PROJECT(__EE2870669,TRANSFORM(__ST1097351_Layout,SELF.UID := LEFT.Contact_,SELF := LEFT));
  SHARED __ST1097376_Layout := RECORD
    KEL.typ.int C_O_U_N_T___Sele_Person_ := 0;
    KEL.typ.ntyp(E_Person().Typ) UID;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
  END;
  SHARED __EE2870708 := PROJECT(__CLEANANDDO(__EE2870695,TABLE(__EE2870695,{KEL.typ.epoch Archive___Date_ := KEL.era.SimpleRoll(GROUP,Archive___Date_,MIN,FALSE),KEL.typ.epoch Date_First_Seen_ := KEL.era.SimpleRoll(GROUP,Date_First_Seen_,MIN,FALSE),KEL.typ.epoch Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Date_Last_Seen_,MAX,FALSE),KEL.typ.epoch Hybrid_Archive_Date_ := KEL.era.SimpleRoll(GROUP,Hybrid_Archive_Date_,MIN,FALSE),KEL.typ.epoch Vault_Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Vault_Date_Last_Seen_,MAX,NMAX),KEL.typ.int C_O_U_N_T___Sele_Person_ := COUNT(GROUP),UID},UID,MERGE)),__ST1097376_Layout);
  SHARED __ST1097912_Layout := RECORD
    KEL.typ.nuid UID;
    KEL.typ.nstr Lex_I_D_Segment_;
    KEL.typ.nstr Lex_I_D_Segment2_;
    KEL.typ.ndataset(E_Person(__in,__cfg).Full_Name_Layout) Full_Name_;
    KEL.typ.ndataset(B_Person_4(__in,__cfg).__ST212577_Layout) Reported_Dates_Of_Birth_;
    KEL.typ.ndataset(E_Person(__in,__cfg).Reported_Dates_Of_Death_Layout) Reported_Dates_Of_Death_;
    KEL.typ.ndataset(E_Person(__in,__cfg).Data_Sources_Layout) Data_Sources_;
    KEL.typ.ndataset(E_Person(__in,__cfg).Conceal_Carry_Layout) Conceal_Carry_;
    KEL.typ.ndataset(E_Person(__in,__cfg).Hunt_Fish_Layout) Hunt_Fish_;
    KEL.typ.ndataset(E_Person(__in,__cfg).Consumer_Statement_Flags_Layout) Consumer_Statement_Flags_;
    KEL.typ.ndataset(E_Person(__in,__cfg).Thrive_Layout) Thrive_;
    KEL.typ.nint Age_;
    KEL.typ.ndataset(B_Person_4(__in,__cfg).__ST557106_Layout) All_Lien_Data_;
    KEL.typ.int Drg_Bk_Cnt10_Y_ := 0;
    KEL.typ.int Drg_Crim_Fel_Cnt7_Y_ := 0;
    KEL.typ.int Drg_Crim_Nfel_Cnt7_Y_ := 0;
    KEL.typ.ndataset(B_Person_5(__in,__cfg).__ST111386_Layout) Edu_Coll_Rec_Ver_Source_List_;
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
  __JC2870714(B_Person_3(__in,__cfg).__ST204755_Layout __EE2868591, __ST1097376_Layout __EE2870708) := __EEQP(__EE2868591.UID,__EE2870708.UID);
  __ST1097912_Layout __JT2870714(B_Person_3(__in,__cfg).__ST204755_Layout __l, __ST1097376_Layout __r) := TRANSFORM
    SELF.U_I_D__1_ := __r.UID;
    SELF := __l;
    SELF := __r;
  END;
  SHARED __EE2870824 := JOIN(__EE2868591,__EE2870708,__JC2870714(LEFT,RIGHT),__JT2870714(LEFT,RIGHT),LEFT OUTER,HASH);
  SHARED __ST1099096_Layout := RECORD
    KEL.typ.nuid UID;
    KEL.typ.nstr Lex_I_D_Segment_;
    KEL.typ.nstr Lex_I_D_Segment2_;
    KEL.typ.ndataset(E_Person(__in,__cfg).Full_Name_Layout) Full_Name_;
    KEL.typ.ndataset(B_Person_4(__in,__cfg).__ST212577_Layout) Reported_Dates_Of_Birth_;
    KEL.typ.ndataset(E_Person(__in,__cfg).Reported_Dates_Of_Death_Layout) Reported_Dates_Of_Death_;
    KEL.typ.ndataset(E_Person(__in,__cfg).Data_Sources_Layout) Data_Sources_;
    KEL.typ.ndataset(E_Person(__in,__cfg).Conceal_Carry_Layout) Conceal_Carry_;
    KEL.typ.ndataset(E_Person(__in,__cfg).Hunt_Fish_Layout) Hunt_Fish_;
    KEL.typ.ndataset(E_Person(__in,__cfg).Consumer_Statement_Flags_Layout) Consumer_Statement_Flags_;
    KEL.typ.ndataset(E_Person(__in,__cfg).Thrive_Layout) Thrive_;
    KEL.typ.nint Age_;
    KEL.typ.ndataset(B_Person_4(__in,__cfg).__ST557106_Layout) All_Lien_Data_;
    KEL.typ.int Drg_Bk_Cnt10_Y_ := 0;
    KEL.typ.int Drg_Crim_Fel_Cnt7_Y_ := 0;
    KEL.typ.int Drg_Crim_Nfel_Cnt7_Y_ := 0;
    KEL.typ.ndataset(B_Person_5(__in,__cfg).__ST111386_Layout) Edu_Coll_Rec_Ver_Source_List_;
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
  SHARED __EE1096743 := __E_Person_Education;
  SHARED __EE2870250 := __EE1096743(__NN(__EE1096743.Edu_) AND __NN(__EE1096743.Subject_));
  SHARED __EE2868767 := __ENH_Education_3;
  SHARED __EE2868773 := __EE2868767(__EE2868767.Edu_Rec_Flag_);
  __JC2870280(E_Person_Education(__in,__cfg).Layout __EE2870250, B_Education_7(__in,__cfg).__ST222402_Layout __EE2868773) := __EEQP(__EE2870250.Edu_,__EE2868773.UID);
  SHARED __EE2870281 := JOIN(__EE2870250,__EE2868773,__JC2870280(LEFT,RIGHT),TRANSFORM(E_Person_Education(__in,__cfg).Layout,SELF:=LEFT),HASH,KEEP(1));
  __JC2870830(__ST1097912_Layout __EE2870824, E_Person_Education(__in,__cfg).Layout __EE2870281) := __EEQP(__EE2870824.UID,__EE2870281.Subject_);
  __JF2870830(E_Person_Education(__in,__cfg).Layout __EE2870281) := __NN(__EE2870281.Subject_);
  SHARED __EE2870939 := JOIN(__EE2870824,__EE2870281,__JC2870830(LEFT,RIGHT),TRANSFORM(__ST1099096_Layout,SELF:=LEFT,SELF.Person_Education_:=__JF2870830(RIGHT)),HASH,LEFT OUTER,KEEP(1));
  EXPORT __ST195369_Layout := RECORD
    KEL.typ.nuid UID;
    KEL.typ.nstr Lex_I_D_Segment_;
    KEL.typ.nstr Lex_I_D_Segment2_;
    KEL.typ.ndataset(E_Person(__in,__cfg).Full_Name_Layout) Full_Name_;
    KEL.typ.ndataset(B_Person_4(__in,__cfg).__ST212577_Layout) Reported_Dates_Of_Birth_;
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
  SHARED __ST195369_Layout __ND2870944__Project(__ST1099096_Layout __PP2870940) := TRANSFORM
    SELF.Age_More_Than18_ := __OP2(__PP2870940.Age_,>=,__CN(18));
    SELF.Contact_Bus_Cnt_ := __PP2870940.C_O_U_N_T___Sele_Person_;
    SELF.Drg_Cnt_Contact_ := KEL.Routines.BoundsFold(__PP2870940.Drg_Crim_Fel_Cnt7_Y_ + __PP2870940.Drg_Crim_Nfel_Cnt7_Y_ + __PP2870940.Drg_Bk_Cnt10_Y_ + __PP2870940.P_L___Drg_Judg_Cnt7_Y_ + __PP2870940.P_L___Drg_L_T_D_Cnt7_Y_ + __PP2870940.P_L___Drg_Lien_Cnt7_Y_,0,999999);
    __CC14119 := -99999;
    SELF.P_L___Drg_Crim_Fel_Cnt7_Y_ := IF(__PP2870940.P___Lex_I_D_Seen_Flag_ = '0',__CC14119,KEL.Routines.BoundsFold(__PP2870940.Drg_Crim_Fel_Cnt7_Y_,0,999));
    SELF.P_L___Drg_Crim_Nfel_Cnt7_Y_ := IF(__PP2870940.P___Lex_I_D_Seen_Flag_ = '0',__CC14119,KEL.Routines.BoundsFold(__PP2870940.Drg_Crim_Nfel_Cnt7_Y_,0,999));
    __CC14239 := '-99999';
    __CC14241 := '-99998';
    SELF.P_L___Edu_Coll_Rec_Flag_Ev_ := MAP(__PP2870940.P___Lex_I_D_Seen_Flag_ = '0'=>__CC14239, NOT (__PP2870940.Person_Education_)=>__CC14241,EXISTS(__T(__PP2870940.Edu_Coll_Rec_Ver_Source_List_))=>'1','0');
    SELF := __PP2870940;
  END;
  EXPORT __ENH_Person_2 := PROJECT(__EE2870939,__ND2870944__Project(LEFT));
END;
