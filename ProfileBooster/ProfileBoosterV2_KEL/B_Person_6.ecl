//HPCC Systems KEL Compiler Version 1.2.1-dev
IMPORT KEL12 AS KEL;
IMPORT B_Person_7,B_Person_Vehicle_7,B_Vehicle_7,CFG_Compile,E_Person,E_Person_Vehicle,E_Vehicle FROM ProfileBooster.ProfileBoosterV2_KEL;
IMPORT * FROM KEL12.Null;
EXPORT B_Person_6(CFG_Compile __cfg = CFG_Compile) := MODULE
  SHARED VIRTUAL TYPEOF(B_Person_7(__cfg).__ENH_Person_7) __ENH_Person_7 := B_Person_7(__cfg).__ENH_Person_7;
  SHARED VIRTUAL TYPEOF(B_Person_Vehicle_7(__cfg).__ENH_Person_Vehicle_7) __ENH_Person_Vehicle_7 := B_Person_Vehicle_7(__cfg).__ENH_Person_Vehicle_7;
  SHARED VIRTUAL TYPEOF(B_Vehicle_7(__cfg).__ENH_Vehicle_7) __ENH_Vehicle_7 := B_Vehicle_7(__cfg).__ENH_Vehicle_7;
  SHARED __EE21604 := __ENH_Person_7;
  SHARED __EE21955 := __ENH_Person_Vehicle_7;
  SHARED __EE23941 := __EE21955(__NN(__EE21955.Subject_) AND __NN(__EE21955.Automobile_));
  SHARED __EE21957 := __ENH_Vehicle_7;
  SHARED __EE22420 := __EE21957(__T(__EE21957.Flag_Auto_));
  __JC23959(B_Person_Vehicle_7(__cfg).__ST11532_Layout __EE23941, B_Vehicle_7(__cfg).__ST11718_Layout __EE22420) := __EEQP(__EE23941.Automobile_,__EE22420.UID) AND __EE23941.__Part = __EE22420.__Part;
  SHARED __EE23960 := JOIN(__EE23941,__EE22420,__JC23959(LEFT,RIGHT),TRANSFORM(B_Person_Vehicle_7(__cfg).__ST11532_Layout,SELF:=LEFT),HASH,KEEP(1));
  SHARED __ST22199_Layout := RECORD
    KEL.typ.ntyp(E_Person().Typ) UID;
    KEL.typ.nstr Vehicle_Min_Date_;
    KEL.typ.nint Age_At_First_Seen_;
    KEL.typ.nfloat Age_Year_At_First_Seen_;
    KEL.typ.ntyp(E_Vehicle().Typ) Automobile_;
    KEL.typ.ndataset(E_Person_Vehicle(__cfg).Counts_Model_Layout) Counts_Model_;
    KEL.typ.nkdate Current_Date_;
    KEL.typ.ndataset(E_Person_Vehicle(__cfg).Data_Sources_Layout) Data_Sources_;
    KEL.typ.nkdate Date_First_Seen_Capped_;
    KEL.typ.ndataset(E_Person_Vehicle(__cfg).Registration_Layout) Registration_;
    KEL.typ.ntyp(E_Person().Typ) Subject_;
    KEL.typ.ndataset(E_Person_Vehicle(__cfg).Title_Layout) Title_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    UNSIGNED4 __Part := 0;
  END;
  SHARED __EE24131 := PROJECT(__EE23960,TRANSFORM(__ST22199_Layout,SELF.UID := LEFT.Subject_,SELF := LEFT));
  SHARED __ST22311_Layout := RECORD
    KEL.typ.ntyp(E_Person().Typ) UID;
    KEL.typ.nbool Exp1_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    UNSIGNED4 __Part := 0;
  END;
  SHARED __ST22311_Layout __ND24345__Project(__ST22199_Layout __PP24132) := TRANSFORM
    __CC1090 := '-99997';
    SELF.Exp1_ := __NOT(__OP2(__PP24132.Vehicle_Min_Date_,=,__CN(__CC1090)));
    SELF := __PP24132;
  END;
  SHARED __EE24349 := PROJECT(__EE24131,__ND24345__Project(LEFT));
  SHARED __ST22327_Layout := RECORD
    KEL.typ.int C_O_U_N_T___Person_Vehicle_ := 0;
    KEL.typ.int C_O_U_N_T___Person_Vehicle__1_ := 0;
    KEL.typ.ntyp(E_Person().Typ) UID;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    UNSIGNED4 __Part := 0;
  END;
  SHARED __EE24368 := PROJECT(__CLEANANDDO(__EE24349,TABLE(__EE24349,{KEL.typ.epoch Date_First_Seen_ := KEL.era.SimpleRoll(GROUP,Date_First_Seen_,MIN,FALSE),KEL.typ.epoch Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Date_Last_Seen_,MAX,FALSE),KEL.typ.int C_O_U_N_T___Person_Vehicle_ := COUNT(GROUP,__T(__EE24349.Exp1_)),KEL.typ.int C_O_U_N_T___Person_Vehicle__1_ := COUNT(GROUP),UID,__Part},UID,__Part,MERGE)),__ST22327_Layout);
  SHARED __ST22987_Layout := RECORD
    KEL.typ.nuid UID;
    KEL.typ.nstr Gender_;
    KEL.typ.nstr Lex_I_D_Segment_;
    KEL.typ.ndataset(E_Person(__cfg).Full_Name_Layout) Full_Name_;
    KEL.typ.ndataset(E_Person(__cfg).Reported_Dates_Of_Birth_Layout) Reported_Dates_Of_Birth_;
    KEL.typ.ndataset(E_Person(__cfg).Reported_Dates_Of_Death_Layout) Reported_Dates_Of_Death_;
    KEL.typ.nstr Race_;
    KEL.typ.nstr Race_Description_;
    KEL.typ.ndataset(E_Person(__cfg).Data_Sources_Layout) Data_Sources_;
    KEL.typ.ndataset(E_Person(__cfg).Dunn_Data_Layout) Dunn_Data_;
    KEL.typ.str P___Lex_I_D_Seen_Flag_ := '';
    KEL.typ.int C_O_U_N_T___Person_Vehicle_ := 0;
    KEL.typ.int C_O_U_N_T___Person_Vehicle__1_ := 0;
    KEL.typ.ntyp(E_Person().Typ) U_I_D__1_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
    UNSIGNED4 __Part := 0;
  END;
  __JC24374(B_Person_7(__cfg).__ST11435_Layout __EE21604, __ST22327_Layout __EE24368) := __EEQP(__EE21604.UID,__EE24368.UID) AND __EE21604.__Part = __EE24368.__Part;
  __ST22987_Layout __JT24374(B_Person_7(__cfg).__ST11435_Layout __l, __ST22327_Layout __r) := TRANSFORM
    SELF.U_I_D__1_ := __r.UID;
    SELF := __l;
    SELF := __r;
  END;
  SHARED __EE24421 := JOIN(__EE21604,__EE24368,__JC24374(LEFT,RIGHT),__JT24374(LEFT,RIGHT),LEFT OUTER,HASH);
  EXPORT __ST10974_Layout := RECORD
    KEL.typ.nuid UID;
    KEL.typ.nstr Gender_;
    KEL.typ.nstr Lex_I_D_Segment_;
    KEL.typ.ndataset(E_Person(__cfg).Full_Name_Layout) Full_Name_;
    KEL.typ.ndataset(E_Person(__cfg).Reported_Dates_Of_Birth_Layout) Reported_Dates_Of_Birth_;
    KEL.typ.ndataset(E_Person(__cfg).Reported_Dates_Of_Death_Layout) Reported_Dates_Of_Death_;
    KEL.typ.nstr Race_;
    KEL.typ.nstr Race_Description_;
    KEL.typ.ndataset(E_Person(__cfg).Data_Sources_Layout) Data_Sources_;
    KEL.typ.ndataset(E_Person(__cfg).Dunn_Data_Layout) Dunn_Data_;
    KEL.typ.bool Invalid_Vehicle_Auto_Min_Date_ := FALSE;
    KEL.typ.int P_L___Ast_Veh_Auto_Cnt_Ev_ := 0;
    KEL.typ.str P___Lex_I_D_Seen_Flag_ := '';
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
    UNSIGNED4 __Part := 0;
  END;
  SHARED __ST10974_Layout __ND24426__Project(__ST22987_Layout __PP24422) := TRANSFORM
    SELF.Invalid_Vehicle_Auto_Min_Date_ := NOT (__PP24422.C_O_U_N_T___Person_Vehicle_ <> 0);
    __CC1063 := -99999;
    SELF.P_L___Ast_Veh_Auto_Cnt_Ev_ := IF(__PP24422.P___Lex_I_D_Seen_Flag_ = '0',__CC1063,KEL.Routines.BoundsFold(__PP24422.C_O_U_N_T___Person_Vehicle__1_,0,999));
    SELF := __PP24422;
  END;
  EXPORT __ENH_Person_6 := PROJECT(__EE24421,__ND24426__Project(LEFT));
END;
