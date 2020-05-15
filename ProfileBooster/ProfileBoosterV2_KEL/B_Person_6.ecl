﻿//HPCC Systems KEL Compiler Version 1.2.0beta4
IMPORT KEL12 AS KEL;
IMPORT B_Person_7,B_Person_Vehicle_7,B_Vehicle_7,CFG_Compile,E_Person,E_Person_Vehicle,E_Vehicle FROM ProfileBooster.ProfileBoosterV2_KEL;
IMPORT * FROM KEL12.Null;
EXPORT B_Person_6(CFG_Compile __cfg = CFG_Compile) := MODULE
  SHARED VIRTUAL TYPEOF(B_Person_7(__cfg).__ENH_Person_7) __ENH_Person_7 := B_Person_7(__cfg).__ENH_Person_7;
  SHARED VIRTUAL TYPEOF(B_Person_Vehicle_7(__cfg).__ENH_Person_Vehicle_7) __ENH_Person_Vehicle_7 := B_Person_Vehicle_7(__cfg).__ENH_Person_Vehicle_7;
  SHARED VIRTUAL TYPEOF(B_Vehicle_7(__cfg).__ENH_Vehicle_7) __ENH_Vehicle_7 := B_Vehicle_7(__cfg).__ENH_Vehicle_7;
  SHARED __EE21050 := __ENH_Person_7;
  SHARED __EE21389 := __ENH_Person_Vehicle_7;
  SHARED __EE23315 := __EE21389(__NN(__EE21389.Subject_) AND __NN(__EE21389.Automobile_));
  SHARED __EE21391 := __ENH_Vehicle_7;
  SHARED __EE21850 := __EE21391(__T(__EE21391.Flag_Auto_));
  __JC23333(B_Person_Vehicle_7(__cfg).__ST11062_Layout __EE23315, B_Vehicle_7(__cfg).__ST11248_Layout __EE21850) := __EEQP(__EE23315.Automobile_,__EE21850.UID) AND __EE23315.__Part = __EE21850.__Part;
  SHARED __EE23334 := JOIN(__EE23315,__EE21850,__JC23333(LEFT,RIGHT),TRANSFORM(B_Person_Vehicle_7(__cfg).__ST11062_Layout,SELF:=LEFT),HASH,KEEP(1));
  SHARED __ST21633_Layout := RECORD
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
  SHARED __EE23505 := PROJECT(__EE23334,TRANSFORM(__ST21633_Layout,SELF.UID := LEFT.Subject_,SELF := LEFT));
  SHARED __ST21745_Layout := RECORD
    KEL.typ.ntyp(E_Person().Typ) UID;
    KEL.typ.nbool Exp1_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    UNSIGNED4 __Part := 0;
  END;
  SHARED __ST21745_Layout __ND23707__Project(__ST21633_Layout __PP23506) := TRANSFORM
    __CC1081 := '-99997';
    SELF.Exp1_ := __NOT(__OP2(__PP23506.Vehicle_Min_Date_,=,__CN(__CC1081)));
    SELF := __PP23506;
  END;
  SHARED __EE23711 := PROJECT(__EE23505,__ND23707__Project(LEFT));
  SHARED __ST21761_Layout := RECORD
    KEL.typ.int C_O_U_N_T___Person_Vehicle_ := 0;
    KEL.typ.int C_O_U_N_T___Person_Vehicle__1_ := 0;
    KEL.typ.ntyp(E_Person().Typ) UID;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    UNSIGNED4 __Part := 0;
  END;
  SHARED __EE23730 := PROJECT(__CLEANANDDO(__EE23711,TABLE(__EE23711,{KEL.typ.epoch Date_First_Seen_ := KEL.era.SimpleRoll(GROUP,Date_First_Seen_,MIN,FALSE),KEL.typ.epoch Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Date_Last_Seen_,MAX,FALSE),KEL.typ.int C_O_U_N_T___Person_Vehicle_ := COUNT(GROUP,__T(__EE23711.Exp1_)),KEL.typ.int C_O_U_N_T___Person_Vehicle__1_ := COUNT(GROUP),UID,__Part},UID,__Part,MERGE)),__ST21761_Layout);
  SHARED __ST22409_Layout := RECORD
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
  __JC23736(B_Person_7(__cfg).__ST10969_Layout __EE21050, __ST21761_Layout __EE23730) := __EEQP(__EE21050.UID,__EE23730.UID) AND __EE21050.__Part = __EE23730.__Part;
  __ST22409_Layout __JT23736(B_Person_7(__cfg).__ST10969_Layout __l, __ST21761_Layout __r) := TRANSFORM
    SELF.U_I_D__1_ := __r.UID;
    SELF := __l;
    SELF := __r;
  END;
  SHARED __EE23779 := JOIN(__EE21050,__EE23730,__JC23736(LEFT,RIGHT),__JT23736(LEFT,RIGHT),LEFT OUTER,HASH);
  EXPORT __ST10512_Layout := RECORD
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
  SHARED __ST10512_Layout __ND23784__Project(__ST22409_Layout __PP23780) := TRANSFORM
    SELF.Invalid_Vehicle_Auto_Min_Date_ := NOT (__PP23780.C_O_U_N_T___Person_Vehicle_ <> 0);
    __CC1054 := -99999;
    SELF.P_L___Ast_Veh_Auto_Cnt_Ev_ := IF(__PP23780.P___Lex_I_D_Seen_Flag_ = '0',__CC1054,KEL.Routines.BoundsFold(__PP23780.C_O_U_N_T___Person_Vehicle__1_,0,999));
    SELF := __PP23780;
  END;
  EXPORT __ENH_Person_6 := PROJECT(__EE23779,__ND23784__Project(LEFT));
END;
