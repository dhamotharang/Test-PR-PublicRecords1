﻿//HPCC Systems KEL Compiler Version 0.11.6
IMPORT KEL011 AS KEL;
IMPORT B_Criminal_Offense_1,B_Person_1,CFG_Compile,E_Criminal_Offense,E_Person,E_Person_Offenses,FN_Compile FROM PublicRecords_KEL;
IMPORT * FROM KEL011.Null;
EXPORT B_Person(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE
  SHARED VIRTUAL TYPEOF(B_Criminal_Offense_1(__in,__cfg).__ENH_Criminal_Offense_1) __ENH_Criminal_Offense_1 := B_Criminal_Offense_1(__in,__cfg).__ENH_Criminal_Offense_1;
  SHARED VIRTUAL TYPEOF(B_Person_1(__in,__cfg).__ENH_Person_1) __ENH_Person_1 := B_Person_1(__in,__cfg).__ENH_Person_1;
  SHARED VIRTUAL TYPEOF(E_Person_Offenses(__in,__cfg).__Result) __E_Person_Offenses := E_Person_Offenses(__in,__cfg).__Result;
  SHARED __EE91250 := __ENH_Person_1;
  SHARED __EE91489 := __ENH_Criminal_Offense_1;
  SHARED __EE91520 := __EE91489.Offense_Charges_;
  __JC94397(B_Criminal_Offense_1(__in,__cfg).__ST11704_Layout __EE91520) := __T(__NOT(__NT(__EE91520.Age_In_Days_)));
  SHARED __EE94398 := __EE91489(EXISTS(__CHILDJOINFILTER(__EE91520,__JC94397)));
  SHARED __EE91487 := __E_Person_Offenses;
  SHARED __EE95449 := __EE91487(__NN(__EE91487.Subject_) AND __NN(__EE91487.Offense_));
  SHARED __ST93001_Layout := RECORD
    KEL.typ.nuid UID;
    KEL.typ.nstr Offender_Key_;
    KEL.typ.nstr Offense_Type_;
    KEL.typ.nkdate Date_Of_Offence_;
    KEL.typ.nint Offense_Category_;
    KEL.typ.nstr County_Of_Source_;
    KEL.typ.nstr State_Of_Source_;
    KEL.typ.nstr Department_Of_Law_Enforcement_Number_;
    KEL.typ.nstr Federal_Bureau_Of_Investigations_Number_;
    KEL.typ.nstr Inmate_Number_;
    KEL.typ.nstr State_Identification_Number_Assigned_;
    KEL.typ.nkdate Date_Of_Arrest_;
    KEL.typ.nstr Agency_Name_;
    KEL.typ.nstr Agency_Case_Number_;
    KEL.typ.nstr Traffic_Ticket_Number_;
    KEL.typ.nstr Arrest_Offense_Code_;
    KEL.typ.nstr Arrest_Initial_Charge_Description_;
    KEL.typ.nstr Arrest_Amended_Charge_Description_;
    KEL.typ.nstr Arrest_Offense_Level_;
    KEL.typ.nkdate Date_Of_Disposition_For_Initial_Charge_;
    KEL.typ.nstr Arrest_Offence_Type_Description_;
    KEL.typ.nstr Initial_Charge_Disposition_Description_;
    KEL.typ.nstr Additional_Disposition_Description_;
    KEL.typ.nstr Court_Code_;
    KEL.typ.nstr Court_Description_;
    KEL.typ.nstr Court_Final_Plea_;
    KEL.typ.nstr Court_Offense_Code_;
    KEL.typ.nstr Court_Offense_Description_;
    KEL.typ.nstr Court_Offense_Additional_Description_;
    KEL.typ.nstr Court_Statute_;
    KEL.typ.nkdate Court_Disposition_Date_;
    KEL.typ.nint Court_Fine_;
    KEL.typ.nstr Suspended_Court_Fine_;
    KEL.typ.nint Court_Cost_;
    KEL.typ.nstr Court_Disposition_Code_;
    KEL.typ.nstr Court_Disposition_Description_;
    KEL.typ.nstr Court_Additional_Disposition_Description_;
    KEL.typ.nkdate Date_Of_Appeal_;
    KEL.typ.nkdate Dateof_Verdict_;
    KEL.typ.nstr Offense_Town_;
    KEL.typ.nstr Persistent_Offense_Key_;
    KEL.typ.nkdate Court_Date_;
    KEL.typ.nstr Court_County_;
    KEL.typ.nstr Arrest_Offense_Level_Mapped_;
    KEL.typ.nstr Court_Offense_Level_Mapped_;
    KEL.typ.ndataset(B_Criminal_Offense_1(__in,__cfg).__ST11704_Layout) Offense_Charges_;
    KEL.typ.ndataset(E_Criminal_Offense(__in,__cfg).Criminal_Data_Sources_Layout) Criminal_Data_Sources_;
    KEL.typ.ndataset(E_Criminal_Offense(__in,__cfg).Court_Offense_Level_Layout) Court_Offense_Level_;
    KEL.typ.ndataset(E_Criminal_Offense(__in,__cfg).Offender_Level_Layout) Offender_Level_;
    KEL.typ.ndataset(E_Criminal_Offense(__in,__cfg).Fcra_Data_Layout) Fcra_Data_;
    KEL.typ.ndataset(E_Criminal_Offense(__in,__cfg).Conviction_Overrides_Layout) Conviction_Overrides_;
    KEL.typ.ndataset(E_Criminal_Offense(__in,__cfg).Data_Sources_Layout) Data_Sources_;
    KEL.typ.ntyp(E_Person().Typ) Subject_;
    KEL.typ.ntyp(E_Criminal_Offense().Typ) Offense_;
    KEL.typ.ndataset(E_Person_Offenses(__in,__cfg).Data_Sources_Layout) Data_Sources__1_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  __JC95467(B_Criminal_Offense_1(__in,__cfg).__ST11657_Layout __EE94398, E_Person_Offenses(__in,__cfg).Layout __EE95449) := __EEQP(__EE95449.Offense_,__EE94398.UID);
  __ST93001_Layout __JT95467(B_Criminal_Offense_1(__in,__cfg).__ST11657_Layout __l, E_Person_Offenses(__in,__cfg).Layout __r) := TRANSFORM
    SELF.Data_Sources__1_ := __r.Data_Sources_;
    SELF := __l;
    SELF := __r;
  END;
  SHARED __EE95468 := JOIN(__EE95449,__EE94398,__JC95467(RIGHT,LEFT),__JT95467(RIGHT,LEFT),INNER,HASH);
  SHARED __ST92155_Layout := RECORD
    KEL.typ.ntyp(E_Person().Typ) UID;
    KEL.typ.ntyp(E_Person().Typ) Subject_;
    KEL.typ.ntyp(E_Criminal_Offense().Typ) Offense_;
    KEL.typ.ndataset(E_Person_Offenses(__in,__cfg).Data_Sources_Layout) Data_Sources_;
    KEL.typ.nuid U_I_D__1_;
    KEL.typ.ndataset(B_Criminal_Offense_1(__in,__cfg).__ST11704_Layout) Offense_Charges_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
  END;
  SHARED __ST92155_Layout __ND95563__Project(__ST93001_Layout __PP95469) := TRANSFORM
    SELF.UID := __PP95469.Subject_;
    SELF.Data_Sources_ := __PP95469.Data_Sources__1_;
    SELF.U_I_D__1_ := __PP95469.UID;
    SELF := __PP95469;
  END;
  SHARED __EE95622 := PROJECT(__EE95468,__ND95563__Project(LEFT));
  SHARED __ST92284_Layout := RECORD
    KEL.typ.ntyp(E_Person().Typ) UID;
    KEL.typ.bool Exp1_ := FALSE;
    KEL.typ.bool Exp2_ := FALSE;
    KEL.typ.bool Exp3_ := FALSE;
    KEL.typ.bool Exp4_ := FALSE;
    KEL.typ.bool Exp5_ := FALSE;
    KEL.typ.bool Exp6_ := FALSE;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
  END;
  SHARED __ST92284_Layout __ND96283__Project(__ST92155_Layout __PP95623) := TRANSFORM
    __CC3784 := 365;
    __BS95637 := __T(__PP95623.Offense_Charges_);
    SELF.Exp1_ := EXISTS(__BS95637(__T(__AND(__AND(__OP2(__T(__PP95623.Offense_Charges_).Is_Arrest_,=,__CN(TRUE)),__OP2(__T(__PP95623.Offense_Charges_).Age_In_Days_,<=,__CN(__CC3784))),__NOT(__NT(__T(__PP95623.Offense_Charges_).Age_In_Days_))))));
    __CC3796 := 2556;
    __BS95658 := __T(__PP95623.Offense_Charges_);
    SELF.Exp2_ := EXISTS(__BS95658(__T(__AND(__AND(__OP2(__T(__PP95623.Offense_Charges_).Is_Arrest_,=,__CN(TRUE)),__OP2(__T(__PP95623.Offense_Charges_).Age_In_Days_,<=,__CN(__CC3796))),__NOT(__NT(__T(__PP95623.Offense_Charges_).Age_In_Days_))))));
    __BS95679 := __T(__PP95623.Offense_Charges_);
    SELF.Exp3_ := EXISTS(__BS95679(__T(__AND(__AND(__OP2(__T(__PP95623.Offense_Charges_).Is_Criminal_Count_,=,__CN(TRUE)),__OP2(__T(__PP95623.Offense_Charges_).Age_In_Days_,<=,__CN(__CC3784))),__NOT(__NT(__T(__PP95623.Offense_Charges_).Age_In_Days_))))));
    __BS95700 := __T(__PP95623.Offense_Charges_);
    SELF.Exp4_ := EXISTS(__BS95700(__T(__AND(__AND(__OP2(__T(__PP95623.Offense_Charges_).Is_Felony_,=,__CN(TRUE)),__OP2(__T(__PP95623.Offense_Charges_).Age_In_Days_,<=,__CN(__CC3784))),__NOT(__NT(__T(__PP95623.Offense_Charges_).Age_In_Days_))))));
    __BS95721 := __T(__PP95623.Offense_Charges_);
    SELF.Exp5_ := EXISTS(__BS95721(__T(__AND(__AND(__OP2(__T(__PP95623.Offense_Charges_).Is_Non_Felony_Records_,=,__CN(TRUE)),__OP2(__T(__PP95623.Offense_Charges_).Age_In_Days_,<=,__CN(__CC3784))),__NOT(__NT(__T(__PP95623.Offense_Charges_).Age_In_Days_))))));
    __BS95742 := __T(__PP95623.Offense_Charges_);
    SELF.Exp6_ := EXISTS(__BS95742(__T(__AND(__AND(__OP2(__T(__PP95623.Offense_Charges_).Is_Non_Felony_Records_,=,__CN(TRUE)),__OP2(__T(__PP95623.Offense_Charges_).Age_In_Days_,<=,__CN(__CC3796))),__NOT(__NT(__T(__PP95623.Offense_Charges_).Age_In_Days_))))));
    SELF := __PP95623;
  END;
  SHARED __EE96337 := PROJECT(__EE95622,__ND96283__Project(LEFT));
  SHARED __ST92324_Layout := RECORD
    KEL.typ.int C_O_U_N_T___Exp1_ := 0;
    KEL.typ.int C_O_U_N_T___Exp1__1_ := 0;
    KEL.typ.int C_O_U_N_T___Exp1__2_ := 0;
    KEL.typ.int C_O_U_N_T___Exp1__3_ := 0;
    KEL.typ.int C_O_U_N_T___Exp1__4_ := 0;
    KEL.typ.int C_O_U_N_T___Exp1__5_ := 0;
    KEL.typ.ntyp(E_Person().Typ) UID;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
  END;
  SHARED __EE96378 := PROJECT(__CLEANANDDO(__EE96337,TABLE(__EE96337,{KEL.typ.int C_O_U_N_T___Exp1_ := COUNT(GROUP,__EE96337.Exp1_),KEL.typ.int C_O_U_N_T___Exp1__1_ := COUNT(GROUP,__EE96337.Exp2_),KEL.typ.int C_O_U_N_T___Exp1__2_ := COUNT(GROUP,__EE96337.Exp3_),KEL.typ.int C_O_U_N_T___Exp1__3_ := COUNT(GROUP,__EE96337.Exp4_),KEL.typ.int C_O_U_N_T___Exp1__4_ := COUNT(GROUP,__EE96337.Exp5_),KEL.typ.int C_O_U_N_T___Exp1__5_ := COUNT(GROUP,__EE96337.Exp6_),UID},UID,MERGE)),__ST92324_Layout);
  SHARED __ST93174_Layout := RECORD
    KEL.typ.nuid UID;
    KEL.typ.nstr Gender_;
    KEL.typ.nstr Lex_I_D_Segment_;
    KEL.typ.ndataset(E_Person(__in,__cfg).Full_Name_Layout) Full_Name_;
    KEL.typ.ndataset(E_Person(__in,__cfg).Reported_Dates_Of_Birth_Layout) Reported_Dates_Of_Birth_;
    KEL.typ.ndataset(E_Person(__in,__cfg).Reported_Dates_Of_Death_Layout) Reported_Dates_Of_Death_;
    KEL.typ.nstr Race_;
    KEL.typ.nstr Race_Description_;
    KEL.typ.ndataset(E_Person(__in,__cfg).Data_Sources_Layout) Data_Sources_;
    KEL.typ.nstr Arrest_New1_Y_;
    KEL.typ.nstr Arrest_New7_Y_;
    KEL.typ.nstr Arrest_Old1_Y_;
    KEL.typ.nstr Arrest_Old7_Y_;
    KEL.typ.int Crim_Cnt7_Y_ := 0;
    KEL.typ.nstr Crim_New1_Y_;
    KEL.typ.nstr Crim_New7_Y_;
    KEL.typ.nstr Crim_Old1_Y_;
    KEL.typ.nstr Crim_Old7_Y_;
    KEL.typ.nkdate Current_Date_;
    KEL.typ.int Felony_Cnt7_Y_ := 0;
    KEL.typ.nstr Felony_New1_Y_;
    KEL.typ.nstr Felony_New7_Y_;
    KEL.typ.nstr Felony_Old1_Y_;
    KEL.typ.nstr Felony_Old7_Y_;
    KEL.typ.nstr Mon_Since_Newest_Crim_Cnt7_Y_;
    KEL.typ.nstr Mon_Since_Newest_Felony_Cnt7_Y_;
    KEL.typ.nstr Nonfelony_New1_Y_;
    KEL.typ.nstr Nonfelony_New7_Y_;
    KEL.typ.nstr Nonfelony_Old1_Y_;
    KEL.typ.nstr Nonfelony_Old7_Y_;
    KEL.typ.int C_O_U_N_T___Exp1_ := 0;
    KEL.typ.int C_O_U_N_T___Exp1__1_ := 0;
    KEL.typ.int C_O_U_N_T___Exp1__2_ := 0;
    KEL.typ.int C_O_U_N_T___Exp1__3_ := 0;
    KEL.typ.int C_O_U_N_T___Exp1__4_ := 0;
    KEL.typ.int C_O_U_N_T___Exp1__5_ := 0;
    KEL.typ.ntyp(E_Person().Typ) U_I_D__1_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  __JC96384(B_Person_1(__in,__cfg).__ST12685_Layout __EE91250, __ST92324_Layout __EE96378) := __EEQP(__EE91250.UID,__EE96378.UID);
  __ST93174_Layout __JT96384(B_Person_1(__in,__cfg).__ST12685_Layout __l, __ST92324_Layout __r) := TRANSFORM
    SELF.U_I_D__1_ := __r.UID;
    SELF := __l;
    SELF := __r;
  END;
  SHARED __EE96437 := JOIN(__EE91250,__EE96378,__JC96384(LEFT,RIGHT),__JT96384(LEFT,RIGHT),LEFT OUTER,HASH);
  EXPORT __ST11494_Layout := RECORD
    KEL.typ.nuid UID;
    KEL.typ.nstr Gender_;
    KEL.typ.nstr Lex_I_D_Segment_;
    KEL.typ.ndataset(E_Person(__in,__cfg).Full_Name_Layout) Full_Name_;
    KEL.typ.ndataset(E_Person(__in,__cfg).Reported_Dates_Of_Birth_Layout) Reported_Dates_Of_Birth_;
    KEL.typ.ndataset(E_Person(__in,__cfg).Reported_Dates_Of_Death_Layout) Reported_Dates_Of_Death_;
    KEL.typ.nstr Race_;
    KEL.typ.nstr Race_Description_;
    KEL.typ.ndataset(E_Person(__in,__cfg).Data_Sources_Layout) Data_Sources_;
    KEL.typ.int Arrest_Cnt1_Y_ := 0;
    KEL.typ.int Arrest_Cnt7_Y_ := 0;
    KEL.typ.nstr Arrest_New1_Y_;
    KEL.typ.nstr Arrest_New7_Y_;
    KEL.typ.nstr Arrest_Old1_Y_;
    KEL.typ.nstr Arrest_Old7_Y_;
    KEL.typ.nstr Crim_Behavior_Index7_Y_;
    KEL.typ.int Crim_Cnt1_Y_ := 0;
    KEL.typ.int Crim_Cnt7_Y_ := 0;
    KEL.typ.nstr Crim_New1_Y_;
    KEL.typ.nstr Crim_New7_Y_;
    KEL.typ.nstr Crim_Old1_Y_;
    KEL.typ.nstr Crim_Old7_Y_;
    KEL.typ.nstr Crim_Severity_Index7_Y_;
    KEL.typ.int Felony_Cnt1_Y_ := 0;
    KEL.typ.int Felony_Cnt7_Y_ := 0;
    KEL.typ.nstr Felony_New1_Y_;
    KEL.typ.nstr Felony_New7_Y_;
    KEL.typ.nstr Felony_Old1_Y_;
    KEL.typ.nstr Felony_Old7_Y_;
    KEL.typ.nstr Mon_Since_Newest_Arrest_Cnt1_Y_;
    KEL.typ.nstr Mon_Since_Newest_Arrest_Cnt7_Y_;
    KEL.typ.nstr Mon_Since_Newest_Crim_Cnt1_Y_;
    KEL.typ.nstr Mon_Since_Newest_Crim_Cnt7_Y_;
    KEL.typ.nstr Mon_Since_Newest_Felony_Cnt1_Y_;
    KEL.typ.nstr Mon_Since_Newest_Felony_Cnt7_Y_;
    KEL.typ.nstr Mon_Since_Newest_Nonfelony_Cnt1_Y_;
    KEL.typ.nstr Mon_Since_Newest_Nonfelony_Cnt7_Y_;
    KEL.typ.nstr Mon_Since_Oldest_Arrest_Cnt1_Y_;
    KEL.typ.nstr Mon_Since_Oldest_Arrest_Cnt7_Y_;
    KEL.typ.nstr Mon_Since_Oldest_Crim_Cnt1_Y_;
    KEL.typ.nstr Mon_Since_Oldest_Crim_Cnt7_Y_;
    KEL.typ.nstr Mon_Since_Oldest_Felony_Cnt1_Y_;
    KEL.typ.nstr Mon_Since_Oldest_Felony_Cnt7_Y_;
    KEL.typ.nstr Mon_Since_Oldest_Nonfelony_Cnt1_Y_;
    KEL.typ.nstr Mon_Since_Oldest_Nonfelony_Cnt7_Y_;
    KEL.typ.int Non_Felony_Cnt1_Y_ := 0;
    KEL.typ.int Nonfelony_Cnt7_Y_ := 0;
    KEL.typ.nstr Nonfelony_New1_Y_;
    KEL.typ.nstr Nonfelony_New7_Y_;
    KEL.typ.nstr Nonfelony_Old1_Y_;
    KEL.typ.nstr Nonfelony_Old7_Y_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  SHARED __ST11494_Layout __ND96442__Project(__ST93174_Layout __PP96438) := TRANSFORM
    SELF.Arrest_Cnt1_Y_ := KEL.Routines.BoundsFold(__PP96438.C_O_U_N_T___Exp1_,0,99);
    SELF.Arrest_Cnt7_Y_ := KEL.Routines.BoundsFold(__PP96438.C_O_U_N_T___Exp1__1_,0,999);
    SELF.Crim_Behavior_Index7_Y_ := MAP(__T(__AND(__CN(__PP96438.Felony_Cnt7_Y_ > 0),__OP2(__PP96438.Mon_Since_Newest_Felony_Cnt7_Y_,<=,__CAST(KEL.typ.str,__CN(12)))))=>__ECAST(KEL.typ.nstr,__CN('6')),__T(__AND(__CN(__PP96438.Crim_Cnt7_Y_ > 0),__OP2(__PP96438.Mon_Since_Newest_Crim_Cnt7_Y_,<=,__CAST(KEL.typ.str,__CN(12)))))=>__ECAST(KEL.typ.nstr,__CN('5')),__PP96438.Felony_Cnt7_Y_ > 0=>__ECAST(KEL.typ.nstr,__CN('4')),__PP96438.Crim_Cnt7_Y_ >= 3=>__ECAST(KEL.typ.nstr,__CN('3')),__PP96438.Crim_Cnt7_Y_ = 2=>__ECAST(KEL.typ.nstr,__CN('2')),__PP96438.Crim_Cnt7_Y_ = 1=>__ECAST(KEL.typ.nstr,__CN('1')),__PP96438.Crim_Cnt7_Y_ = 0=>__ECAST(KEL.typ.nstr,__CN('0')),__N(KEL.typ.str));
    SELF.Crim_Cnt1_Y_ := KEL.Routines.BoundsFold(__PP96438.C_O_U_N_T___Exp1__2_,0,99);
    SELF.Crim_Severity_Index7_Y_ := MAP(__PP96438.Crim_Cnt7_Y_ = 0=>__ECAST(KEL.typ.nstr,__CN('0 - 0: No criminal records on file')),__PP96438.Crim_Cnt7_Y_ = 1 AND __PP96438.Felony_Cnt7_Y_ = 0=>__ECAST(KEL.typ.nstr,__CN('1 - 0: There is 1 criminal record on file and it is not felony')),__PP96438.Crim_Cnt7_Y_ = 2 AND __PP96438.Felony_Cnt7_Y_ = 0=>__ECAST(KEL.typ.nstr,__CN('2 - 0: There are 2 criminal records on file and neither is felony')),__PP96438.Crim_Cnt7_Y_ >= 3 AND __PP96438.Felony_Cnt7_Y_ = 0=>__ECAST(KEL.typ.nstr,__CN('3 - 0: There are 3+ criminal records on file and none is felony')),__PP96438.Crim_Cnt7_Y_ = 1 AND __PP96438.Felony_Cnt7_Y_ = 1=>__ECAST(KEL.typ.nstr,__CN('1 - 1: There is 1 criminal record on file and it is felony')),__PP96438.Crim_Cnt7_Y_ = 2 AND __PP96438.Felony_Cnt7_Y_ = 1=>__ECAST(KEL.typ.nstr,__CN('2 - 1: There are 2 criminal records on file and 1 of them is felony')),__PP96438.Crim_Cnt7_Y_ = 2 AND __PP96438.Felony_Cnt7_Y_ = 2=>__ECAST(KEL.typ.nstr,__CN('2 - 2: There are 2 criminal records on file and both are felony')),__PP96438.Crim_Cnt7_Y_ >= 3 AND __PP96438.Felony_Cnt7_Y_ = 1=>__ECAST(KEL.typ.nstr,__CN('3 - 1: There are 3+ criminal records on file and 1 of them is felony')),__PP96438.Crim_Cnt7_Y_ >= 3 AND __PP96438.Felony_Cnt7_Y_ = 2=>__ECAST(KEL.typ.nstr,__CN('3 - 2: There are 3+ criminal records on file and 2 of them are felony')),__PP96438.Crim_Cnt7_Y_ >= 3 AND __PP96438.Felony_Cnt7_Y_ >= 3=>__ECAST(KEL.typ.nstr,__CN('3 - 3: There are 3+ criminal records on file and 3+ of them are felony')),__N(KEL.typ.str));
    SELF.Felony_Cnt1_Y_ := KEL.Routines.BoundsFold(__PP96438.C_O_U_N_T___Exp1__3_,0,99);
    __CC2918 := '-98';
    SELF.Mon_Since_Newest_Arrest_Cnt1_Y_ := FN_Compile.FN_Is_Blank(__ECAST(KEL.typ.nstr,__FN2(KEL.Routines.MonthsBetween,KEL.Routines.CastStringToDate(__PP96438.Arrest_New1_Y_),__PP96438.Current_Date_)),__ECAST(KEL.typ.nstr,__CN(__CC2918)));
    SELF.Mon_Since_Newest_Arrest_Cnt7_Y_ := FN_Compile.FN_Is_Blank(__ECAST(KEL.typ.nstr,__FN2(KEL.Routines.MonthsBetween,KEL.Routines.CastStringToDate(__PP96438.Arrest_New7_Y_),__PP96438.Current_Date_)),__ECAST(KEL.typ.nstr,__CN(__CC2918)));
    SELF.Mon_Since_Newest_Crim_Cnt1_Y_ := FN_Compile.FN_Is_Blank(__ECAST(KEL.typ.nstr,__FN2(KEL.Routines.MonthsBetween,KEL.Routines.CastStringToDate(__PP96438.Crim_New1_Y_),__PP96438.Current_Date_)),__ECAST(KEL.typ.nstr,__CN(__CC2918)));
    SELF.Mon_Since_Newest_Felony_Cnt1_Y_ := FN_Compile.FN_Is_Blank(__ECAST(KEL.typ.nstr,__FN2(KEL.Routines.MonthsBetween,KEL.Routines.CastStringToDate(__PP96438.Felony_New1_Y_),__PP96438.Current_Date_)),__ECAST(KEL.typ.nstr,__CN(__CC2918)));
    SELF.Mon_Since_Newest_Nonfelony_Cnt1_Y_ := FN_Compile.FN_Is_Blank(__ECAST(KEL.typ.nstr,__FN2(KEL.Routines.MonthsBetween,KEL.Routines.CastStringToDate(__PP96438.Nonfelony_New1_Y_),__PP96438.Current_Date_)),__ECAST(KEL.typ.nstr,__CN(__CC2918)));
    SELF.Mon_Since_Newest_Nonfelony_Cnt7_Y_ := FN_Compile.FN_Is_Blank(__ECAST(KEL.typ.nstr,__FN2(KEL.Routines.MonthsBetween,KEL.Routines.CastStringToDate(__PP96438.Nonfelony_New7_Y_),__PP96438.Current_Date_)),__ECAST(KEL.typ.nstr,__CN(__CC2918)));
    SELF.Mon_Since_Oldest_Arrest_Cnt1_Y_ := FN_Compile.FN_Is_Blank(__ECAST(KEL.typ.nstr,__FN2(KEL.Routines.MonthsBetween,KEL.Routines.CastStringToDate(__PP96438.Arrest_Old1_Y_),__PP96438.Current_Date_)),__ECAST(KEL.typ.nstr,__CN(__CC2918)));
    SELF.Mon_Since_Oldest_Arrest_Cnt7_Y_ := FN_Compile.FN_Is_Blank(__ECAST(KEL.typ.nstr,__FN2(KEL.Routines.MonthsBetween,KEL.Routines.CastStringToDate(__PP96438.Arrest_Old7_Y_),__PP96438.Current_Date_)),__ECAST(KEL.typ.nstr,__CN(__CC2918)));
    SELF.Mon_Since_Oldest_Crim_Cnt1_Y_ := FN_Compile.FN_Is_Blank(__ECAST(KEL.typ.nstr,__FN2(KEL.Routines.MonthsBetween,KEL.Routines.CastStringToDate(__PP96438.Crim_Old1_Y_),__PP96438.Current_Date_)),__ECAST(KEL.typ.nstr,__CN(__CC2918)));
    SELF.Mon_Since_Oldest_Crim_Cnt7_Y_ := FN_Compile.FN_Is_Blank(__ECAST(KEL.typ.nstr,__FN2(KEL.Routines.MonthsBetween,KEL.Routines.CastStringToDate(__PP96438.Crim_Old7_Y_),__PP96438.Current_Date_)),__ECAST(KEL.typ.nstr,__CN(__CC2918)));
    SELF.Mon_Since_Oldest_Felony_Cnt1_Y_ := FN_Compile.FN_Is_Blank(__ECAST(KEL.typ.nstr,__FN2(KEL.Routines.MonthsBetween,KEL.Routines.CastStringToDate(__PP96438.Felony_Old1_Y_),__PP96438.Current_Date_)),__ECAST(KEL.typ.nstr,__CN(__CC2918)));
    SELF.Mon_Since_Oldest_Felony_Cnt7_Y_ := FN_Compile.FN_Is_Blank(__ECAST(KEL.typ.nstr,__FN2(KEL.Routines.MonthsBetween,KEL.Routines.CastStringToDate(__PP96438.Felony_Old7_Y_),__PP96438.Current_Date_)),__ECAST(KEL.typ.nstr,__CN(__CC2918)));
    SELF.Mon_Since_Oldest_Nonfelony_Cnt1_Y_ := FN_Compile.FN_Is_Blank(__ECAST(KEL.typ.nstr,__FN2(KEL.Routines.MonthsBetween,KEL.Routines.CastStringToDate(__PP96438.Nonfelony_Old1_Y_),__PP96438.Current_Date_)),__ECAST(KEL.typ.nstr,__CN(__CC2918)));
    SELF.Mon_Since_Oldest_Nonfelony_Cnt7_Y_ := FN_Compile.FN_Is_Blank(__ECAST(KEL.typ.nstr,__FN2(KEL.Routines.MonthsBetween,KEL.Routines.CastStringToDate(__PP96438.Nonfelony_Old7_Y_),__PP96438.Current_Date_)),__ECAST(KEL.typ.nstr,__CN(__CC2918)));
    SELF.Non_Felony_Cnt1_Y_ := KEL.Routines.BoundsFold(__PP96438.C_O_U_N_T___Exp1__4_,0,99);
    SELF.Nonfelony_Cnt7_Y_ := KEL.Routines.BoundsFold(__PP96438.C_O_U_N_T___Exp1__5_,0,999);
    SELF := __PP96438;
  END;
  EXPORT __ENH_Person := PROJECT(__EE96437,__ND96442__Project(LEFT));
END;
