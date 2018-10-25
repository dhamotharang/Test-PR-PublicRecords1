//HPCC Systems KEL Compiler Version 0.11.0
IMPORT KEL011 AS KEL;
IMPORT B_Person_3,E_Address,E_Customer,E_Email,E_Event,E_Internet_Protocol,E_Person,E_Person_Email,E_Person_Event,E_Person_Person,E_Phone,E_Social_Security_Number FROM KELOtto;
IMPORT * FROM KEL011.Null;
EXPORT B_Email_2 := MODULE
  SHARED VIRTUAL TYPEOF(E_Email.__Result) __E_Email := E_Email.__Result;
  SHARED VIRTUAL TYPEOF(B_Person_3.__ENH_Person_3) __ENH_Person_3 := B_Person_3.__ENH_Person_3;
  SHARED VIRTUAL TYPEOF(E_Person_Email.__Result) __E_Person_Email := E_Person_Email.__Result;
  SHARED VIRTUAL TYPEOF(E_Person_Event.__Result) __E_Person_Event := E_Person_Event.__Result;
  SHARED VIRTUAL TYPEOF(E_Person_Person.__Result) __E_Person_Person := E_Person_Person.__Result;
  SHARED __EE42565 := __E_Email;
  SHARED __EE42646 := __E_Person_Person;
  SHARED __EE46642 := __EE42646;
  SHARED __EE46663 := __EE46642(__NN(__EE46642.From_Person_));
  SHARED __ST47112_Layout := RECORD
    KEL.typ.ntyp(E_Person.Typ) From_Person_;
    KEL.typ.ntyp(E_Person.Typ) To_Person_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  SHARED __EE47116 := PROJECT(TABLE(PROJECT(__EE46663,__ST47112_Layout),{KEL.typ.int __RecordCount := SUM(GROUP,__RecordCount),KEL.typ.epoch Date_First_Seen_ := KEL.era.SimpleRoll(GROUP,Date_First_Seen_,MIN,TRUE),KEL.typ.epoch Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Date_Last_Seen_,MAX,FALSE),From_Person_,To_Person_},From_Person_,To_Person_,MERGE),__ST47112_Layout);
  SHARED __EE42627 := __E_Person_Email;
  SHARED __EE46465 := __EE42627(__NN(__EE42627.Emailof_) AND __NN(__EE42627.Subject_));
  SHARED __ST47124_Layout := RECORD
    KEL.typ.ntyp(E_Person.Typ) Subject_;
    KEL.typ.ntyp(E_Email.Typ) Emailof_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
  END;
  SHARED __EE47128 := DEDUP(PROJECT(__EE46465,__ST47124_Layout),ALL);
  SHARED __ST47150_Layout := RECORD
    KEL.typ.ntyp(E_Person.Typ) From_Person_;
    KEL.typ.ntyp(E_Person.Typ) To_Person_;
    KEL.typ.ntyp(E_Person.Typ) Subject_;
    KEL.typ.ntyp(E_Email.Typ) Emailof_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  __JC47141(__ST47112_Layout __EE47116, __ST47124_Layout __EE47128) := __EEQP(__EE47128.Subject_,__EE47116.From_Person_);
  __ST47150_Layout __JT47141(__ST47112_Layout __l, __ST47124_Layout __r) := TRANSFORM
    SELF := __l;
    SELF := __r;
  END;
  SHARED __EE47148 := JOIN(__EE47116,__EE47128,__JC47141(LEFT,RIGHT),__JT47141(LEFT,RIGHT),INNER,HASH);
  SHARED __ST43814_Layout := RECORD
    KEL.typ.ntyp(E_Email.Typ) UID;
    KEL.typ.ntyp(E_Person.Typ) To_Person_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
  END;
  SHARED __EE47168 := DEDUP(PROJECT(__EE47148,TRANSFORM(__ST43814_Layout,SELF.UID := LEFT.Emailof_,SELF := LEFT)),ALL);
  SHARED __ST43832_Layout := RECORD
    KEL.typ.int C_O_U_N_T___Person_Person_ := 0;
    KEL.typ.ntyp(E_Email.Typ) UID;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
  END;
  SHARED __EE47181 := PROJECT(__CLEANANDDO(__EE47168,TABLE(__EE47168,{KEL.typ.int C_O_U_N_T___Person_Person_ := COUNT(GROUP),UID},UID,MERGE)),__ST43832_Layout);
  SHARED __ST44382_Layout := RECORD
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
  __JC47187(E_Email.Layout __EE42565, __ST43832_Layout __EE47181) := __EEQP(__EE42565.UID,__EE47181.UID);
  __ST44382_Layout __JT47187(E_Email.Layout __l, __ST43832_Layout __r) := TRANSFORM
    SELF.U_I_D__1_ := __r.UID;
    SELF := __l;
    SELF := __r;
  END;
  SHARED __EE47205 := JOIN(__EE42565,__EE47181,__JC47187(LEFT,RIGHT),__JT47187(LEFT,RIGHT),LEFT OUTER,HASH);
  SHARED __EE42905 := __E_Person_Event;
  SHARED __EE45680 := __EE42905(__NN(__EE42905.Subject_));
  SHARED __ST47303_Layout := RECORD
    KEL.typ.ntyp(E_Person.Typ) Subject_;
    KEL.typ.ntyp(E_Event.Typ) Transaction_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  SHARED __EE47307 := PROJECT(TABLE(PROJECT(__EE45680,__ST47303_Layout),{KEL.typ.int __RecordCount := SUM(GROUP,__RecordCount),KEL.typ.epoch Date_First_Seen_ := KEL.era.SimpleRoll(GROUP,Date_First_Seen_,MIN,TRUE),KEL.typ.epoch Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Date_Last_Seen_,MAX,FALSE),Subject_,Transaction_},Subject_,Transaction_,MERGE),__ST47303_Layout);
  SHARED __EE42867 := __E_Person_Event;
  SHARED __EE46003 := __EE42867(__NN(__EE42867.Emailof_) AND __NN(__EE42867.Subject_));
  SHARED __ST47230_Layout := RECORD
    KEL.typ.ntyp(E_Person.Typ) Subject_;
    KEL.typ.ntyp(E_Email.Typ) Emailof_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  SHARED __EE47234 := PROJECT(TABLE(PROJECT(__EE46003,__ST47230_Layout),{KEL.typ.int __RecordCount := SUM(GROUP,__RecordCount),KEL.typ.epoch Date_First_Seen_ := KEL.era.SimpleRoll(GROUP,Date_First_Seen_,MIN,TRUE),KEL.typ.epoch Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Date_Last_Seen_,MAX,FALSE),Subject_,Emailof_},Subject_,Emailof_,MERGE),__ST47230_Layout);
  SHARED __EE46413 := __EE42646(__NN(__EE42646.To_Person_) AND __NN(__EE42646.From_Person_));
  SHARED __ST47242_Layout := RECORD
    KEL.typ.ntyp(E_Person.Typ) From_Person_;
    KEL.typ.ntyp(E_Person.Typ) To_Person_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  SHARED __EE47246 := PROJECT(TABLE(PROJECT(__EE46413,__ST47242_Layout),{KEL.typ.int __RecordCount := SUM(GROUP,__RecordCount),KEL.typ.epoch Date_First_Seen_ := KEL.era.SimpleRoll(GROUP,Date_First_Seen_,MIN,TRUE),KEL.typ.epoch Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Date_Last_Seen_,MAX,FALSE),From_Person_,To_Person_},From_Person_,To_Person_,MERGE),__ST47242_Layout);
  SHARED __ST47268_Layout := RECORD
    KEL.typ.ntyp(E_Person.Typ) Subject_;
    KEL.typ.ntyp(E_Email.Typ) Emailof_;
    KEL.typ.ntyp(E_Person.Typ) From_Person_;
    KEL.typ.ntyp(E_Person.Typ) To_Person_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  __JC47259(__ST47230_Layout __EE47234, __ST47242_Layout __EE47246) := __EEQP(__EE47234.Subject_,__EE47246.From_Person_);
  __ST47268_Layout __JT47259(__ST47230_Layout __l, __ST47242_Layout __r) := TRANSFORM
    SELF := __l;
    SELF := __r;
  END;
  SHARED __EE47266 := JOIN(__EE47234,__EE47246,__JC47259(LEFT,RIGHT),__JT47259(LEFT,RIGHT),INNER,HASH);
  SHARED __ST47315_Layout := RECORD
    KEL.typ.ntyp(E_Email.Typ) Emailof_;
    KEL.typ.ntyp(E_Person.Typ) To_Person_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
  END;
  SHARED __EE47319 := DEDUP(PROJECT(__EE47266,__ST47315_Layout),ALL);
  SHARED __ST47327_Layout := RECORD
    KEL.typ.ntyp(E_Email.Typ) Emailof__1_;
    KEL.typ.ntyp(E_Person.Typ) To_Person_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
  END;
  SHARED __EE47331 := PROJECT(__EE47319,TRANSFORM(__ST47327_Layout,SELF.Emailof__1_ := LEFT.Emailof_,SELF := LEFT));
  SHARED __ST47347_Layout := RECORD
    KEL.typ.ntyp(E_Person.Typ) Subject_;
    KEL.typ.ntyp(E_Event.Typ) Transaction_;
    KEL.typ.ntyp(E_Email.Typ) Emailof__1_;
    KEL.typ.ntyp(E_Person.Typ) To_Person_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  __JC47338(__ST47303_Layout __EE47307, __ST47327_Layout __EE47331) := __EEQP(__EE47331.To_Person_,__EE47307.Subject_);
  __ST47347_Layout __JT47338(__ST47303_Layout __l, __ST47327_Layout __r) := TRANSFORM
    SELF := __l;
    SELF := __r;
  END;
  SHARED __EE47345 := JOIN(__EE47331,__EE47307,__JC47338(RIGHT,LEFT),__JT47338(RIGHT,LEFT),INNER,HASH);
  SHARED __ST43575_Layout := RECORD
    KEL.typ.ntyp(E_Email.Typ) UID;
    KEL.typ.ntyp(E_Event.Typ) Transaction_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
  END;
  SHARED __EE47365 := DEDUP(PROJECT(__EE47345,TRANSFORM(__ST43575_Layout,SELF.UID := LEFT.Emailof__1_,SELF := LEFT)),ALL);
  SHARED __ST43593_Layout := RECORD
    KEL.typ.int C_O_U_N_T___Person_Event_ := 0;
    KEL.typ.ntyp(E_Email.Typ) UID;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
  END;
  SHARED __EE47378 := PROJECT(__CLEANANDDO(__EE47365,TABLE(__EE47365,{KEL.typ.int C_O_U_N_T___Person_Event_ := COUNT(GROUP),UID},UID,MERGE)),__ST43593_Layout);
  SHARED __ST44491_Layout := RECORD
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
  __JC47386(__ST44382_Layout __EE47205, __ST43593_Layout __EE47378) := __EEQP(__EE47205.UID,__EE47378.UID);
  __ST44491_Layout __JT47386(__ST44382_Layout __l, __ST43593_Layout __r) := TRANSFORM
    SELF.U_I_D__2_ := __r.UID;
    SELF := __l;
    SELF := __r;
  END;
  SHARED __EE47406 := JOIN(__EE47205,__EE47378,__JC47386(LEFT,RIGHT),__JT47386(LEFT,RIGHT),LEFT OUTER,HASH);
  SHARED __EE46651 := __EE46413;
  SHARED __EE42664 := __ENH_Person_3;
  SHARED __EE46633 := __EE42664;
  SHARED __EE46902 := __EE46633(__EE46633.Vl_Event7_Active_Flag_ = 1);
  __JC46910(E_Person_Person.Layout __EE46651, B_Person_3.__ST8952_Layout __EE46902) := __EEQP(__EE46651.To_Person_,__EE46902.UID);
  SHARED __EE46911 := JOIN(__EE46651,__EE46902,__JC46910(LEFT,RIGHT),TRANSFORM(E_Person_Person.Layout,SELF:=LEFT),HASH,KEEP(1));
  SHARED __ST47433_Layout := RECORD
    KEL.typ.ntyp(E_Person.Typ) From_Person_;
    KEL.typ.ntyp(E_Person.Typ) To_Person_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  SHARED __EE47437 := PROJECT(TABLE(PROJECT(__EE46911,__ST47433_Layout),{KEL.typ.int __RecordCount := SUM(GROUP,__RecordCount),KEL.typ.epoch Date_First_Seen_ := KEL.era.SimpleRoll(GROUP,Date_First_Seen_,MIN,TRUE),KEL.typ.epoch Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Date_Last_Seen_,MAX,FALSE),From_Person_,To_Person_},From_Person_,To_Person_,MERGE),__ST47433_Layout);
  SHARED __ST47461_Layout := RECORD
    KEL.typ.ntyp(E_Person.Typ) From_Person_;
    KEL.typ.ntyp(E_Person.Typ) To_Person_;
    KEL.typ.ntyp(E_Person.Typ) Subject_;
    KEL.typ.ntyp(E_Email.Typ) Emailof_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  __JC47452(__ST47433_Layout __EE47437, __ST47124_Layout __EE47128) := __EEQP(__EE47128.Subject_,__EE47437.From_Person_);
  __ST47461_Layout __JT47452(__ST47433_Layout __l, __ST47124_Layout __r) := TRANSFORM
    SELF := __l;
    SELF := __r;
  END;
  SHARED __EE47459 := JOIN(__EE47128,__EE47437,__JC47452(RIGHT,LEFT),__JT47452(RIGHT,LEFT),INNER,HASH);
  SHARED __ST43354_Layout := RECORD
    KEL.typ.ntyp(E_Email.Typ) UID;
    KEL.typ.ntyp(E_Person.Typ) To_Person_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
  END;
  SHARED __EE47479 := DEDUP(PROJECT(__EE47459,TRANSFORM(__ST43354_Layout,SELF.UID := LEFT.Emailof_,SELF := LEFT)),ALL);
  SHARED __ST43372_Layout := RECORD
    KEL.typ.int C_O_U_N_T___Person_Person_ := 0;
    KEL.typ.ntyp(E_Email.Typ) UID;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
  END;
  SHARED __EE47492 := PROJECT(__CLEANANDDO(__EE47479,TABLE(__EE47479,{KEL.typ.int C_O_U_N_T___Person_Person_ := COUNT(GROUP),UID},UID,MERGE)),__ST43372_Layout);
  SHARED __ST44599_Layout := RECORD
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
  __JC47500(__ST44491_Layout __EE47406, __ST43372_Layout __EE47492) := __EEQP(__EE47406.UID,__EE47492.UID);
  __ST44599_Layout __JT47500(__ST44491_Layout __l, __ST43372_Layout __r) := TRANSFORM
    SELF.C_O_U_N_T___Person_Person__1_ := __r.C_O_U_N_T___Person_Person_;
    SELF.U_I_D__3_ := __r.UID;
    SELF := __l;
    SELF := __r;
  END;
  SHARED __EE47524 := JOIN(__EE47406,__EE47492,__JC47500(LEFT,RIGHT),__JT47500(LEFT,RIGHT),LEFT OUTER,HASH);
  SHARED __EE43188 := __EE42664(__EE42664.Vl_Event30_Active_Flag_ = 1);
  __JC46425(E_Person_Person.Layout __EE46413, B_Person_3.__ST8952_Layout __EE43188) := __EEQP(__EE46413.To_Person_,__EE43188.UID);
  SHARED __EE46426 := JOIN(__EE46413,__EE43188,__JC46425(LEFT,RIGHT),TRANSFORM(E_Person_Person.Layout,SELF:=LEFT),HASH,KEEP(1));
  SHARED __ST47555_Layout := RECORD
    KEL.typ.ntyp(E_Person.Typ) From_Person_;
    KEL.typ.ntyp(E_Person.Typ) To_Person_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  SHARED __EE47559 := PROJECT(TABLE(PROJECT(__EE46426,__ST47555_Layout),{KEL.typ.int __RecordCount := SUM(GROUP,__RecordCount),KEL.typ.epoch Date_First_Seen_ := KEL.era.SimpleRoll(GROUP,Date_First_Seen_,MIN,TRUE),KEL.typ.epoch Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Date_Last_Seen_,MAX,FALSE),From_Person_,To_Person_},From_Person_,To_Person_,MERGE),__ST47555_Layout);
  SHARED __ST47583_Layout := RECORD
    KEL.typ.ntyp(E_Person.Typ) From_Person_;
    KEL.typ.ntyp(E_Person.Typ) To_Person_;
    KEL.typ.ntyp(E_Person.Typ) Subject_;
    KEL.typ.ntyp(E_Email.Typ) Emailof_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  __JC47574(__ST47555_Layout __EE47559, __ST47124_Layout __EE47128) := __EEQP(__EE47128.Subject_,__EE47559.From_Person_);
  __ST47583_Layout __JT47574(__ST47555_Layout __l, __ST47124_Layout __r) := TRANSFORM
    SELF := __l;
    SELF := __r;
  END;
  SHARED __EE47581 := JOIN(__EE47128,__EE47559,__JC47574(RIGHT,LEFT),__JT47574(RIGHT,LEFT),INNER,HASH);
  SHARED __ST43116_Layout := RECORD
    KEL.typ.ntyp(E_Email.Typ) UID;
    KEL.typ.ntyp(E_Person.Typ) To_Person_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
  END;
  SHARED __EE47601 := DEDUP(PROJECT(__EE47581,TRANSFORM(__ST43116_Layout,SELF.UID := LEFT.Emailof_,SELF := LEFT)),ALL);
  SHARED __ST43134_Layout := RECORD
    KEL.typ.int C_O_U_N_T___Person_Person_ := 0;
    KEL.typ.ntyp(E_Email.Typ) UID;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
  END;
  SHARED __EE47614 := PROJECT(__CLEANANDDO(__EE47601,TABLE(__EE47601,{KEL.typ.int C_O_U_N_T___Person_Person_ := COUNT(GROUP),UID},UID,MERGE)),__ST43134_Layout);
  SHARED __ST44708_Layout := RECORD
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
  __JC47622(__ST44599_Layout __EE47524, __ST43134_Layout __EE47614) := __EEQP(__EE47524.UID,__EE47614.UID);
  __ST44708_Layout __JT47622(__ST44599_Layout __l, __ST43134_Layout __r) := TRANSFORM
    SELF.C_O_U_N_T___Person_Person__2_ := __r.C_O_U_N_T___Person_Person_;
    SELF.U_I_D__4_ := __r.UID;
    SELF := __l;
    SELF := __r;
  END;
  SHARED __EE47648 := JOIN(__EE47524,__EE47614,__JC47622(LEFT,RIGHT),__JT47622(LEFT,RIGHT),LEFT OUTER,HASH);
  EXPORT __ST8430_Layout := RECORD
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
  SHARED __ST8430_Layout __ND47678__Project(__ST44708_Layout __PP47649) := TRANSFORM
    SELF.Cl_Active30_Identity_Count_ := __PP47649.C_O_U_N_T___Person_Person__2_;
    SELF.Cl_Active7_Identity_Count_ := __PP47649.C_O_U_N_T___Person_Person__1_;
    SELF.Cl_Event_Count_ := __PP47649.C_O_U_N_T___Person_Event_;
    SELF.Cl_Identity_Count_ := __PP47649.C_O_U_N_T___Person_Person_;
    SELF := __PP47649;
  END;
  EXPORT __ENH_Email_2 := PROJECT(__EE47648,__ND47678__Project(LEFT));
END;
