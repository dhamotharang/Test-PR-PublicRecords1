//HPCC Systems KEL Compiler Version 0.11.0
IMPORT KEL011 AS KEL;
IMPORT B_Person_3,E_Address,E_Bank,E_Bank_Account,E_Customer,E_Drivers_License,E_Email,E_Event,E_Internet_Protocol,E_Person,E_Person_Email,E_Person_Event,E_Person_Person,E_Phone,E_Social_Security_Number FROM KELOtto;
IMPORT * FROM KEL011.Null;
EXPORT B_Email_2 := MODULE
  SHARED VIRTUAL TYPEOF(E_Email.__Result) __E_Email := E_Email.__Result;
  SHARED VIRTUAL TYPEOF(B_Person_3.__ENH_Person_3) __ENH_Person_3 := B_Person_3.__ENH_Person_3;
  SHARED VIRTUAL TYPEOF(E_Person_Email.__Result) __E_Person_Email := E_Person_Email.__Result;
  SHARED VIRTUAL TYPEOF(E_Person_Event.__Result) __E_Person_Event := E_Person_Event.__Result;
  SHARED VIRTUAL TYPEOF(E_Person_Person.__Result) __E_Person_Person := E_Person_Person.__Result;
  SHARED __EE73628 := __E_Email;
  SHARED __EE73709 := __E_Person_Person;
  SHARED __EE77750 := __EE73709;
  SHARED __EE77771 := __EE77750(__NN(__EE77750.From_Person_));
  SHARED __ST78235_Layout := RECORD
    KEL.typ.ntyp(E_Person.Typ) From_Person_;
    KEL.typ.ntyp(E_Person.Typ) To_Person_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  SHARED __EE78239 := PROJECT(TABLE(PROJECT(__EE77771,__ST78235_Layout),{KEL.typ.int __RecordCount := SUM(GROUP,__RecordCount),KEL.typ.epoch Date_First_Seen_ := KEL.era.SimpleRoll(GROUP,Date_First_Seen_,MIN,TRUE),KEL.typ.epoch Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Date_Last_Seen_,MAX,FALSE),From_Person_,To_Person_},From_Person_,To_Person_,MERGE),__ST78235_Layout);
  SHARED __EE73690 := __E_Person_Email;
  SHARED __EE77573 := __EE73690(__NN(__EE73690.Emailof_) AND __NN(__EE73690.Subject_));
  SHARED __ST78247_Layout := RECORD
    KEL.typ.ntyp(E_Person.Typ) Subject_;
    KEL.typ.ntyp(E_Email.Typ) Emailof_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
  END;
  SHARED __EE78251 := DEDUP(PROJECT(__EE77573,__ST78247_Layout),ALL);
  SHARED __ST78273_Layout := RECORD
    KEL.typ.ntyp(E_Person.Typ) From_Person_;
    KEL.typ.ntyp(E_Person.Typ) To_Person_;
    KEL.typ.ntyp(E_Person.Typ) Subject_;
    KEL.typ.ntyp(E_Email.Typ) Emailof_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  __JC78264(__ST78235_Layout __EE78239, __ST78247_Layout __EE78251) := __EEQP(__EE78251.Subject_,__EE78239.From_Person_);
  __ST78273_Layout __JT78264(__ST78235_Layout __l, __ST78247_Layout __r) := TRANSFORM
    SELF := __l;
    SELF := __r;
  END;
  SHARED __EE78271 := JOIN(__EE78239,__EE78251,__JC78264(LEFT,RIGHT),__JT78264(LEFT,RIGHT),INNER,HASH);
  SHARED __ST74877_Layout := RECORD
    KEL.typ.ntyp(E_Email.Typ) UID;
    KEL.typ.ntyp(E_Person.Typ) To_Person_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
  END;
  SHARED __EE78291 := DEDUP(PROJECT(__EE78271,TRANSFORM(__ST74877_Layout,SELF.UID := LEFT.Emailof_,SELF := LEFT)),ALL);
  SHARED __ST74895_Layout := RECORD
    KEL.typ.int C_O_U_N_T___Person_Person_ := 0;
    KEL.typ.ntyp(E_Email.Typ) UID;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
  END;
  SHARED __EE78304 := PROJECT(__CLEANANDDO(__EE78291,TABLE(__EE78291,{KEL.typ.int C_O_U_N_T___Person_Person_ := COUNT(GROUP),UID},UID,MERGE)),__ST74895_Layout);
  SHARED __ST75460_Layout := RECORD
    KEL.typ.nuid UID;
    KEL.typ.ntyp(E_Customer.Typ) _r_Customer_;
    KEL.typ.ndataset(E_Email.Source_Customers_Layout) Source_Customers_;
    KEL.typ.nstr Email_Address_;
    KEL.typ.nint Otto_Email_Id_;
    KEL.typ.ndataset(E_Email.Details_Layout) Details_;
    KEL.typ.int C_O_U_N_T___Person_Person_ := 0;
    KEL.typ.ntyp(E_Email.Typ) U_I_D__1_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  __JC78310(E_Email.Layout __EE73628, __ST74895_Layout __EE78304) := __EEQP(__EE73628.UID,__EE78304.UID);
  __ST75460_Layout __JT78310(E_Email.Layout __l, __ST74895_Layout __r) := TRANSFORM
    SELF.U_I_D__1_ := __r.UID;
    SELF := __l;
    SELF := __r;
  END;
  SHARED __EE78328 := JOIN(__EE73628,__EE78304,__JC78310(LEFT,RIGHT),__JT78310(LEFT,RIGHT),LEFT OUTER,HASH);
  SHARED __EE73968 := __E_Person_Event;
  SHARED __EE76773 := __EE73968(__NN(__EE73968.Subject_));
  SHARED __ST78429_Layout := RECORD
    KEL.typ.ntyp(E_Person.Typ) Subject_;
    KEL.typ.ntyp(E_Event.Typ) Transaction_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  SHARED __EE78433 := PROJECT(TABLE(PROJECT(__EE76773,__ST78429_Layout),{KEL.typ.int __RecordCount := SUM(GROUP,__RecordCount),KEL.typ.epoch Date_First_Seen_ := KEL.era.SimpleRoll(GROUP,Date_First_Seen_,MIN,TRUE),KEL.typ.epoch Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Date_Last_Seen_,MAX,FALSE),Subject_,Transaction_},Subject_,Transaction_,MERGE),__ST78429_Layout);
  SHARED __EE73930 := __E_Person_Event;
  SHARED __EE77096 := __EE73930(__NN(__EE73930.Emailof_) AND __NN(__EE73930.Subject_));
  SHARED __ST78353_Layout := RECORD
    KEL.typ.ntyp(E_Person.Typ) Subject_;
    KEL.typ.ntyp(E_Email.Typ) Emailof_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  SHARED __EE78357 := PROJECT(TABLE(PROJECT(__EE77096,__ST78353_Layout),{KEL.typ.int __RecordCount := SUM(GROUP,__RecordCount),KEL.typ.epoch Date_First_Seen_ := KEL.era.SimpleRoll(GROUP,Date_First_Seen_,MIN,TRUE),KEL.typ.epoch Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Date_Last_Seen_,MAX,FALSE),Subject_,Emailof_},Subject_,Emailof_,MERGE),__ST78353_Layout);
  SHARED __EE77521 := __EE73709(__NN(__EE73709.To_Person_) AND __NN(__EE73709.From_Person_));
  SHARED __ST78365_Layout := RECORD
    KEL.typ.ntyp(E_Person.Typ) From_Person_;
    KEL.typ.ntyp(E_Person.Typ) To_Person_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  SHARED __EE78369 := PROJECT(TABLE(PROJECT(__EE77521,__ST78365_Layout),{KEL.typ.int __RecordCount := SUM(GROUP,__RecordCount),KEL.typ.epoch Date_First_Seen_ := KEL.era.SimpleRoll(GROUP,Date_First_Seen_,MIN,TRUE),KEL.typ.epoch Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Date_Last_Seen_,MAX,FALSE),From_Person_,To_Person_},From_Person_,To_Person_,MERGE),__ST78365_Layout);
  SHARED __ST78391_Layout := RECORD
    KEL.typ.ntyp(E_Person.Typ) Subject_;
    KEL.typ.ntyp(E_Email.Typ) Emailof_;
    KEL.typ.ntyp(E_Person.Typ) From_Person_;
    KEL.typ.ntyp(E_Person.Typ) To_Person_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  __JC78382(__ST78353_Layout __EE78357, __ST78365_Layout __EE78369) := __EEQP(__EE78357.Subject_,__EE78369.From_Person_);
  __ST78391_Layout __JT78382(__ST78353_Layout __l, __ST78365_Layout __r) := TRANSFORM
    SELF := __l;
    SELF := __r;
  END;
  SHARED __EE78389 := JOIN(__EE78357,__EE78369,__JC78382(LEFT,RIGHT),__JT78382(LEFT,RIGHT),INNER,HASH);
  SHARED __ST78441_Layout := RECORD
    KEL.typ.ntyp(E_Email.Typ) Emailof_;
    KEL.typ.ntyp(E_Person.Typ) To_Person_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
  END;
  SHARED __EE78445 := DEDUP(PROJECT(__EE78389,__ST78441_Layout),ALL);
  SHARED __ST78453_Layout := RECORD
    KEL.typ.ntyp(E_Email.Typ) Emailof__1_;
    KEL.typ.ntyp(E_Person.Typ) To_Person_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
  END;
  SHARED __EE78457 := PROJECT(__EE78445,TRANSFORM(__ST78453_Layout,SELF.Emailof__1_ := LEFT.Emailof_,SELF := LEFT));
  SHARED __ST78473_Layout := RECORD
    KEL.typ.ntyp(E_Person.Typ) Subject_;
    KEL.typ.ntyp(E_Event.Typ) Transaction_;
    KEL.typ.ntyp(E_Email.Typ) Emailof__1_;
    KEL.typ.ntyp(E_Person.Typ) To_Person_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  __JC78464(__ST78429_Layout __EE78433, __ST78453_Layout __EE78457) := __EEQP(__EE78457.To_Person_,__EE78433.Subject_);
  __ST78473_Layout __JT78464(__ST78429_Layout __l, __ST78453_Layout __r) := TRANSFORM
    SELF := __l;
    SELF := __r;
  END;
  SHARED __EE78471 := JOIN(__EE78457,__EE78433,__JC78464(RIGHT,LEFT),__JT78464(RIGHT,LEFT),INNER,HASH);
  SHARED __ST74638_Layout := RECORD
    KEL.typ.ntyp(E_Email.Typ) UID;
    KEL.typ.ntyp(E_Event.Typ) Transaction_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
  END;
  SHARED __EE78491 := DEDUP(PROJECT(__EE78471,TRANSFORM(__ST74638_Layout,SELF.UID := LEFT.Emailof__1_,SELF := LEFT)),ALL);
  SHARED __ST74656_Layout := RECORD
    KEL.typ.int C_O_U_N_T___Person_Event_ := 0;
    KEL.typ.ntyp(E_Email.Typ) UID;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
  END;
  SHARED __EE78504 := PROJECT(__CLEANANDDO(__EE78491,TABLE(__EE78491,{KEL.typ.int C_O_U_N_T___Person_Event_ := COUNT(GROUP),UID},UID,MERGE)),__ST74656_Layout);
  SHARED __ST75569_Layout := RECORD
    KEL.typ.nuid UID;
    KEL.typ.ntyp(E_Customer.Typ) _r_Customer_;
    KEL.typ.ndataset(E_Email.Source_Customers_Layout) Source_Customers_;
    KEL.typ.nstr Email_Address_;
    KEL.typ.nint Otto_Email_Id_;
    KEL.typ.ndataset(E_Email.Details_Layout) Details_;
    KEL.typ.int C_O_U_N_T___Person_Person_ := 0;
    KEL.typ.ntyp(E_Email.Typ) U_I_D__1_;
    KEL.typ.int C_O_U_N_T___Person_Event_ := 0;
    KEL.typ.ntyp(E_Email.Typ) U_I_D__2_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  __JC78512(__ST75460_Layout __EE78328, __ST74656_Layout __EE78504) := __EEQP(__EE78328.UID,__EE78504.UID);
  __ST75569_Layout __JT78512(__ST75460_Layout __l, __ST74656_Layout __r) := TRANSFORM
    SELF.U_I_D__2_ := __r.UID;
    SELF := __l;
    SELF := __r;
  END;
  SHARED __EE78532 := JOIN(__EE78328,__EE78504,__JC78512(LEFT,RIGHT),__JT78512(LEFT,RIGHT),LEFT OUTER,HASH);
  SHARED __EE77759 := __EE77521;
  SHARED __EE73727 := __ENH_Person_3;
  SHARED __EE77741 := __EE73727;
  SHARED __EE78025 := __EE77741(__EE77741.Vl_Event7_Active_Flag_ = 1);
  __JC78033(E_Person_Person.Layout __EE77759, B_Person_3.__ST14617_Layout __EE78025) := __EEQP(__EE77759.To_Person_,__EE78025.UID);
  SHARED __EE78034 := JOIN(__EE77759,__EE78025,__JC78033(LEFT,RIGHT),TRANSFORM(E_Person_Person.Layout,SELF:=LEFT),HASH,KEEP(1));
  SHARED __ST78559_Layout := RECORD
    KEL.typ.ntyp(E_Person.Typ) From_Person_;
    KEL.typ.ntyp(E_Person.Typ) To_Person_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  SHARED __EE78563 := PROJECT(TABLE(PROJECT(__EE78034,__ST78559_Layout),{KEL.typ.int __RecordCount := SUM(GROUP,__RecordCount),KEL.typ.epoch Date_First_Seen_ := KEL.era.SimpleRoll(GROUP,Date_First_Seen_,MIN,TRUE),KEL.typ.epoch Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Date_Last_Seen_,MAX,FALSE),From_Person_,To_Person_},From_Person_,To_Person_,MERGE),__ST78559_Layout);
  SHARED __ST78587_Layout := RECORD
    KEL.typ.ntyp(E_Person.Typ) From_Person_;
    KEL.typ.ntyp(E_Person.Typ) To_Person_;
    KEL.typ.ntyp(E_Person.Typ) Subject_;
    KEL.typ.ntyp(E_Email.Typ) Emailof_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  __JC78578(__ST78559_Layout __EE78563, __ST78247_Layout __EE78251) := __EEQP(__EE78251.Subject_,__EE78563.From_Person_);
  __ST78587_Layout __JT78578(__ST78559_Layout __l, __ST78247_Layout __r) := TRANSFORM
    SELF := __l;
    SELF := __r;
  END;
  SHARED __EE78585 := JOIN(__EE78251,__EE78563,__JC78578(RIGHT,LEFT),__JT78578(RIGHT,LEFT),INNER,HASH);
  SHARED __ST74417_Layout := RECORD
    KEL.typ.ntyp(E_Email.Typ) UID;
    KEL.typ.ntyp(E_Person.Typ) To_Person_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
  END;
  SHARED __EE78605 := DEDUP(PROJECT(__EE78585,TRANSFORM(__ST74417_Layout,SELF.UID := LEFT.Emailof_,SELF := LEFT)),ALL);
  SHARED __ST74435_Layout := RECORD
    KEL.typ.int C_O_U_N_T___Person_Person_ := 0;
    KEL.typ.ntyp(E_Email.Typ) UID;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
  END;
  SHARED __EE78618 := PROJECT(__CLEANANDDO(__EE78605,TABLE(__EE78605,{KEL.typ.int C_O_U_N_T___Person_Person_ := COUNT(GROUP),UID},UID,MERGE)),__ST74435_Layout);
  SHARED __ST75677_Layout := RECORD
    KEL.typ.nuid UID;
    KEL.typ.ntyp(E_Customer.Typ) _r_Customer_;
    KEL.typ.ndataset(E_Email.Source_Customers_Layout) Source_Customers_;
    KEL.typ.nstr Email_Address_;
    KEL.typ.nint Otto_Email_Id_;
    KEL.typ.ndataset(E_Email.Details_Layout) Details_;
    KEL.typ.int C_O_U_N_T___Person_Person_ := 0;
    KEL.typ.ntyp(E_Email.Typ) U_I_D__1_;
    KEL.typ.int C_O_U_N_T___Person_Event_ := 0;
    KEL.typ.ntyp(E_Email.Typ) U_I_D__2_;
    KEL.typ.int C_O_U_N_T___Person_Person__1_ := 0;
    KEL.typ.ntyp(E_Email.Typ) U_I_D__3_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  __JC78626(__ST75569_Layout __EE78532, __ST74435_Layout __EE78618) := __EEQP(__EE78532.UID,__EE78618.UID);
  __ST75677_Layout __JT78626(__ST75569_Layout __l, __ST74435_Layout __r) := TRANSFORM
    SELF.C_O_U_N_T___Person_Person__1_ := __r.C_O_U_N_T___Person_Person_;
    SELF.U_I_D__3_ := __r.UID;
    SELF := __l;
    SELF := __r;
  END;
  SHARED __EE78650 := JOIN(__EE78532,__EE78618,__JC78626(LEFT,RIGHT),__JT78626(LEFT,RIGHT),LEFT OUTER,HASH);
  SHARED __EE74251 := __EE73727(__EE73727.Vl_Event30_Active_Flag_ = 1);
  __JC77533(E_Person_Person.Layout __EE77521, B_Person_3.__ST14617_Layout __EE74251) := __EEQP(__EE77521.To_Person_,__EE74251.UID);
  SHARED __EE77534 := JOIN(__EE77521,__EE74251,__JC77533(LEFT,RIGHT),TRANSFORM(E_Person_Person.Layout,SELF:=LEFT),HASH,KEEP(1));
  SHARED __ST78681_Layout := RECORD
    KEL.typ.ntyp(E_Person.Typ) From_Person_;
    KEL.typ.ntyp(E_Person.Typ) To_Person_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  SHARED __EE78685 := PROJECT(TABLE(PROJECT(__EE77534,__ST78681_Layout),{KEL.typ.int __RecordCount := SUM(GROUP,__RecordCount),KEL.typ.epoch Date_First_Seen_ := KEL.era.SimpleRoll(GROUP,Date_First_Seen_,MIN,TRUE),KEL.typ.epoch Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Date_Last_Seen_,MAX,FALSE),From_Person_,To_Person_},From_Person_,To_Person_,MERGE),__ST78681_Layout);
  SHARED __ST78709_Layout := RECORD
    KEL.typ.ntyp(E_Person.Typ) From_Person_;
    KEL.typ.ntyp(E_Person.Typ) To_Person_;
    KEL.typ.ntyp(E_Person.Typ) Subject_;
    KEL.typ.ntyp(E_Email.Typ) Emailof_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  __JC78700(__ST78681_Layout __EE78685, __ST78247_Layout __EE78251) := __EEQP(__EE78251.Subject_,__EE78685.From_Person_);
  __ST78709_Layout __JT78700(__ST78681_Layout __l, __ST78247_Layout __r) := TRANSFORM
    SELF := __l;
    SELF := __r;
  END;
  SHARED __EE78707 := JOIN(__EE78251,__EE78685,__JC78700(RIGHT,LEFT),__JT78700(RIGHT,LEFT),INNER,HASH);
  SHARED __ST74179_Layout := RECORD
    KEL.typ.ntyp(E_Email.Typ) UID;
    KEL.typ.ntyp(E_Person.Typ) To_Person_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
  END;
  SHARED __EE78727 := DEDUP(PROJECT(__EE78707,TRANSFORM(__ST74179_Layout,SELF.UID := LEFT.Emailof_,SELF := LEFT)),ALL);
  SHARED __ST74197_Layout := RECORD
    KEL.typ.int C_O_U_N_T___Person_Person_ := 0;
    KEL.typ.ntyp(E_Email.Typ) UID;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
  END;
  SHARED __EE78740 := PROJECT(__CLEANANDDO(__EE78727,TABLE(__EE78727,{KEL.typ.int C_O_U_N_T___Person_Person_ := COUNT(GROUP),UID},UID,MERGE)),__ST74197_Layout);
  SHARED __ST75786_Layout := RECORD
    KEL.typ.nuid UID;
    KEL.typ.ntyp(E_Customer.Typ) _r_Customer_;
    KEL.typ.ndataset(E_Email.Source_Customers_Layout) Source_Customers_;
    KEL.typ.nstr Email_Address_;
    KEL.typ.nint Otto_Email_Id_;
    KEL.typ.ndataset(E_Email.Details_Layout) Details_;
    KEL.typ.int C_O_U_N_T___Person_Person_ := 0;
    KEL.typ.ntyp(E_Email.Typ) U_I_D__1_;
    KEL.typ.int C_O_U_N_T___Person_Event_ := 0;
    KEL.typ.ntyp(E_Email.Typ) U_I_D__2_;
    KEL.typ.int C_O_U_N_T___Person_Person__1_ := 0;
    KEL.typ.ntyp(E_Email.Typ) U_I_D__3_;
    KEL.typ.int C_O_U_N_T___Person_Person__2_ := 0;
    KEL.typ.ntyp(E_Email.Typ) U_I_D__4_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  __JC78748(__ST75677_Layout __EE78650, __ST74197_Layout __EE78740) := __EEQP(__EE78650.UID,__EE78740.UID);
  __ST75786_Layout __JT78748(__ST75677_Layout __l, __ST74197_Layout __r) := TRANSFORM
    SELF.C_O_U_N_T___Person_Person__2_ := __r.C_O_U_N_T___Person_Person_;
    SELF.U_I_D__4_ := __r.UID;
    SELF := __l;
    SELF := __r;
  END;
  SHARED __EE78774 := JOIN(__EE78650,__EE78740,__JC78748(LEFT,RIGHT),__JT78748(LEFT,RIGHT),LEFT OUTER,HASH);
  EXPORT __ST13828_Layout := RECORD
    KEL.typ.nuid UID;
    KEL.typ.ntyp(E_Customer.Typ) _r_Customer_;
    KEL.typ.ndataset(E_Email.Source_Customers_Layout) Source_Customers_;
    KEL.typ.nstr Email_Address_;
    KEL.typ.nint Otto_Email_Id_;
    KEL.typ.ndataset(E_Email.Details_Layout) Details_;
    KEL.typ.int Cl_Active30_Identity_Count_ := 0;
    KEL.typ.int Cl_Active7_Identity_Count_ := 0;
    KEL.typ.int Cl_Event_Count_ := 0;
    KEL.typ.int Cl_Identity_Count_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  SHARED __ST13828_Layout __ND78804__Project(__ST75786_Layout __PP78775) := TRANSFORM
    SELF.Cl_Active30_Identity_Count_ := __PP78775.C_O_U_N_T___Person_Person__2_;
    SELF.Cl_Active7_Identity_Count_ := __PP78775.C_O_U_N_T___Person_Person__1_;
    SELF.Cl_Event_Count_ := __PP78775.C_O_U_N_T___Person_Event_;
    SELF.Cl_Identity_Count_ := __PP78775.C_O_U_N_T___Person_Person_;
    SELF := __PP78775;
  END;
  EXPORT __ENH_Email_2 := PROJECT(__EE78774,__ND78804__Project(LEFT));
END;
