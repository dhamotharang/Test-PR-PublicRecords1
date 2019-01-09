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
  SHARED __EE69889 := __E_Email;
  SHARED __EE69970 := __E_Person_Person;
  SHARED __EE74011 := __EE69970;
  SHARED __EE74032 := __EE74011(__NN(__EE74011.From_Person_));
  SHARED __ST74496_Layout := RECORD
    KEL.typ.ntyp(E_Person.Typ) From_Person_;
    KEL.typ.ntyp(E_Person.Typ) To_Person_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  SHARED __EE74500 := PROJECT(TABLE(PROJECT(__EE74032,__ST74496_Layout),{KEL.typ.int __RecordCount := SUM(GROUP,__RecordCount),KEL.typ.epoch Date_First_Seen_ := KEL.era.SimpleRoll(GROUP,Date_First_Seen_,MIN,TRUE),KEL.typ.epoch Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Date_Last_Seen_,MAX,FALSE),From_Person_,To_Person_},From_Person_,To_Person_,MERGE),__ST74496_Layout);
  SHARED __EE69951 := __E_Person_Email;
  SHARED __EE73834 := __EE69951(__NN(__EE69951.Emailof_) AND __NN(__EE69951.Subject_));
  SHARED __ST74508_Layout := RECORD
    KEL.typ.ntyp(E_Person.Typ) Subject_;
    KEL.typ.ntyp(E_Email.Typ) Emailof_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
  END;
  SHARED __EE74512 := DEDUP(PROJECT(__EE73834,__ST74508_Layout),ALL);
  SHARED __ST74534_Layout := RECORD
    KEL.typ.ntyp(E_Person.Typ) From_Person_;
    KEL.typ.ntyp(E_Person.Typ) To_Person_;
    KEL.typ.ntyp(E_Person.Typ) Subject_;
    KEL.typ.ntyp(E_Email.Typ) Emailof_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  __JC74525(__ST74496_Layout __EE74500, __ST74508_Layout __EE74512) := __EEQP(__EE74512.Subject_,__EE74500.From_Person_);
  __ST74534_Layout __JT74525(__ST74496_Layout __l, __ST74508_Layout __r) := TRANSFORM
    SELF := __l;
    SELF := __r;
  END;
  SHARED __EE74532 := JOIN(__EE74500,__EE74512,__JC74525(LEFT,RIGHT),__JT74525(LEFT,RIGHT),INNER,HASH);
  SHARED __ST71138_Layout := RECORD
    KEL.typ.ntyp(E_Email.Typ) UID;
    KEL.typ.ntyp(E_Person.Typ) To_Person_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
  END;
  SHARED __EE74552 := DEDUP(PROJECT(__EE74532,TRANSFORM(__ST71138_Layout,SELF.UID := LEFT.Emailof_,SELF := LEFT)),ALL);
  SHARED __ST71156_Layout := RECORD
    KEL.typ.int C_O_U_N_T___Person_Person_ := 0;
    KEL.typ.ntyp(E_Email.Typ) UID;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
  END;
  SHARED __EE74565 := PROJECT(__CLEANANDDO(__EE74552,TABLE(__EE74552,{KEL.typ.int C_O_U_N_T___Person_Person_ := COUNT(GROUP),UID},UID,MERGE)),__ST71156_Layout);
  SHARED __ST71721_Layout := RECORD
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
  __JC74571(E_Email.Layout __EE69889, __ST71156_Layout __EE74565) := __EEQP(__EE69889.UID,__EE74565.UID);
  __ST71721_Layout __JT74571(E_Email.Layout __l, __ST71156_Layout __r) := TRANSFORM
    SELF.U_I_D__1_ := __r.UID;
    SELF := __l;
    SELF := __r;
  END;
  SHARED __EE74589 := JOIN(__EE69889,__EE74565,__JC74571(LEFT,RIGHT),__JT74571(LEFT,RIGHT),LEFT OUTER,HASH);
  SHARED __EE70229 := __E_Person_Event;
  SHARED __EE73034 := __EE70229(__NN(__EE70229.Subject_));
  SHARED __ST74690_Layout := RECORD
    KEL.typ.ntyp(E_Person.Typ) Subject_;
    KEL.typ.ntyp(E_Event.Typ) Transaction_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  SHARED __EE74694 := PROJECT(TABLE(PROJECT(__EE73034,__ST74690_Layout),{KEL.typ.int __RecordCount := SUM(GROUP,__RecordCount),KEL.typ.epoch Date_First_Seen_ := KEL.era.SimpleRoll(GROUP,Date_First_Seen_,MIN,TRUE),KEL.typ.epoch Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Date_Last_Seen_,MAX,FALSE),Subject_,Transaction_},Subject_,Transaction_,MERGE),__ST74690_Layout);
  SHARED __EE70191 := __E_Person_Event;
  SHARED __EE73357 := __EE70191(__NN(__EE70191.Emailof_) AND __NN(__EE70191.Subject_));
  SHARED __ST74614_Layout := RECORD
    KEL.typ.ntyp(E_Person.Typ) Subject_;
    KEL.typ.ntyp(E_Email.Typ) Emailof_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  SHARED __EE74618 := PROJECT(TABLE(PROJECT(__EE73357,__ST74614_Layout),{KEL.typ.int __RecordCount := SUM(GROUP,__RecordCount),KEL.typ.epoch Date_First_Seen_ := KEL.era.SimpleRoll(GROUP,Date_First_Seen_,MIN,TRUE),KEL.typ.epoch Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Date_Last_Seen_,MAX,FALSE),Subject_,Emailof_},Subject_,Emailof_,MERGE),__ST74614_Layout);
  SHARED __EE73782 := __EE69970(__NN(__EE69970.To_Person_) AND __NN(__EE69970.From_Person_));
  SHARED __ST74626_Layout := RECORD
    KEL.typ.ntyp(E_Person.Typ) From_Person_;
    KEL.typ.ntyp(E_Person.Typ) To_Person_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  SHARED __EE74630 := PROJECT(TABLE(PROJECT(__EE73782,__ST74626_Layout),{KEL.typ.int __RecordCount := SUM(GROUP,__RecordCount),KEL.typ.epoch Date_First_Seen_ := KEL.era.SimpleRoll(GROUP,Date_First_Seen_,MIN,TRUE),KEL.typ.epoch Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Date_Last_Seen_,MAX,FALSE),From_Person_,To_Person_},From_Person_,To_Person_,MERGE),__ST74626_Layout);
  SHARED __ST74652_Layout := RECORD
    KEL.typ.ntyp(E_Person.Typ) Subject_;
    KEL.typ.ntyp(E_Email.Typ) Emailof_;
    KEL.typ.ntyp(E_Person.Typ) From_Person_;
    KEL.typ.ntyp(E_Person.Typ) To_Person_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  __JC74643(__ST74614_Layout __EE74618, __ST74626_Layout __EE74630) := __EEQP(__EE74618.Subject_,__EE74630.From_Person_);
  __ST74652_Layout __JT74643(__ST74614_Layout __l, __ST74626_Layout __r) := TRANSFORM
    SELF := __l;
    SELF := __r;
  END;
  SHARED __EE74650 := JOIN(__EE74618,__EE74630,__JC74643(LEFT,RIGHT),__JT74643(LEFT,RIGHT),INNER,HASH);
  SHARED __ST74702_Layout := RECORD
    KEL.typ.ntyp(E_Email.Typ) Emailof_;
    KEL.typ.ntyp(E_Person.Typ) To_Person_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
  END;
  SHARED __EE74706 := DEDUP(PROJECT(__EE74650,__ST74702_Layout),ALL);
  SHARED __ST74714_Layout := RECORD
    KEL.typ.ntyp(E_Email.Typ) Emailof__1_;
    KEL.typ.ntyp(E_Person.Typ) To_Person_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
  END;
  SHARED __EE74718 := PROJECT(__EE74706,TRANSFORM(__ST74714_Layout,SELF.Emailof__1_ := LEFT.Emailof_,SELF := LEFT));
  SHARED __ST74734_Layout := RECORD
    KEL.typ.ntyp(E_Person.Typ) Subject_;
    KEL.typ.ntyp(E_Event.Typ) Transaction_;
    KEL.typ.ntyp(E_Email.Typ) Emailof__1_;
    KEL.typ.ntyp(E_Person.Typ) To_Person_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  __JC74725(__ST74690_Layout __EE74694, __ST74714_Layout __EE74718) := __EEQP(__EE74718.To_Person_,__EE74694.Subject_);
  __ST74734_Layout __JT74725(__ST74690_Layout __l, __ST74714_Layout __r) := TRANSFORM
    SELF := __l;
    SELF := __r;
  END;
  SHARED __EE74732 := JOIN(__EE74718,__EE74694,__JC74725(RIGHT,LEFT),__JT74725(RIGHT,LEFT),INNER,HASH);
  SHARED __ST70899_Layout := RECORD
    KEL.typ.ntyp(E_Email.Typ) UID;
    KEL.typ.ntyp(E_Event.Typ) Transaction_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
  END;
  SHARED __EE74752 := DEDUP(PROJECT(__EE74732,TRANSFORM(__ST70899_Layout,SELF.UID := LEFT.Emailof__1_,SELF := LEFT)),ALL);
  SHARED __ST70917_Layout := RECORD
    KEL.typ.int C_O_U_N_T___Person_Event_ := 0;
    KEL.typ.ntyp(E_Email.Typ) UID;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
  END;
  SHARED __EE74765 := PROJECT(__CLEANANDDO(__EE74752,TABLE(__EE74752,{KEL.typ.int C_O_U_N_T___Person_Event_ := COUNT(GROUP),UID},UID,MERGE)),__ST70917_Layout);
  SHARED __ST71830_Layout := RECORD
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
  __JC74773(__ST71721_Layout __EE74589, __ST70917_Layout __EE74765) := __EEQP(__EE74589.UID,__EE74765.UID);
  __ST71830_Layout __JT74773(__ST71721_Layout __l, __ST70917_Layout __r) := TRANSFORM
    SELF.U_I_D__2_ := __r.UID;
    SELF := __l;
    SELF := __r;
  END;
  SHARED __EE74793 := JOIN(__EE74589,__EE74765,__JC74773(LEFT,RIGHT),__JT74773(LEFT,RIGHT),LEFT OUTER,HASH);
  SHARED __EE74020 := __EE73782;
  SHARED __EE69988 := __ENH_Person_3;
  SHARED __EE74002 := __EE69988;
  SHARED __EE74286 := __EE74002(__EE74002.Vl_Event7_Active_Flag_ = 1);
  __JC74294(E_Person_Person.Layout __EE74020, B_Person_3.__ST13337_Layout __EE74286) := __EEQP(__EE74020.To_Person_,__EE74286.UID);
  SHARED __EE74295 := JOIN(__EE74020,__EE74286,__JC74294(LEFT,RIGHT),TRANSFORM(E_Person_Person.Layout,SELF:=LEFT),HASH,KEEP(1));
  SHARED __ST74820_Layout := RECORD
    KEL.typ.ntyp(E_Person.Typ) From_Person_;
    KEL.typ.ntyp(E_Person.Typ) To_Person_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  SHARED __EE74824 := PROJECT(TABLE(PROJECT(__EE74295,__ST74820_Layout),{KEL.typ.int __RecordCount := SUM(GROUP,__RecordCount),KEL.typ.epoch Date_First_Seen_ := KEL.era.SimpleRoll(GROUP,Date_First_Seen_,MIN,TRUE),KEL.typ.epoch Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Date_Last_Seen_,MAX,FALSE),From_Person_,To_Person_},From_Person_,To_Person_,MERGE),__ST74820_Layout);
  SHARED __ST74848_Layout := RECORD
    KEL.typ.ntyp(E_Person.Typ) From_Person_;
    KEL.typ.ntyp(E_Person.Typ) To_Person_;
    KEL.typ.ntyp(E_Person.Typ) Subject_;
    KEL.typ.ntyp(E_Email.Typ) Emailof_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  __JC74839(__ST74820_Layout __EE74824, __ST74508_Layout __EE74512) := __EEQP(__EE74512.Subject_,__EE74824.From_Person_);
  __ST74848_Layout __JT74839(__ST74820_Layout __l, __ST74508_Layout __r) := TRANSFORM
    SELF := __l;
    SELF := __r;
  END;
  SHARED __EE74846 := JOIN(__EE74512,__EE74824,__JC74839(RIGHT,LEFT),__JT74839(RIGHT,LEFT),INNER,HASH);
  SHARED __ST70678_Layout := RECORD
    KEL.typ.ntyp(E_Email.Typ) UID;
    KEL.typ.ntyp(E_Person.Typ) To_Person_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
  END;
  SHARED __EE74866 := DEDUP(PROJECT(__EE74846,TRANSFORM(__ST70678_Layout,SELF.UID := LEFT.Emailof_,SELF := LEFT)),ALL);
  SHARED __ST70696_Layout := RECORD
    KEL.typ.int C_O_U_N_T___Person_Person_ := 0;
    KEL.typ.ntyp(E_Email.Typ) UID;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
  END;
  SHARED __EE74879 := PROJECT(__CLEANANDDO(__EE74866,TABLE(__EE74866,{KEL.typ.int C_O_U_N_T___Person_Person_ := COUNT(GROUP),UID},UID,MERGE)),__ST70696_Layout);
  SHARED __ST71938_Layout := RECORD
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
  __JC74887(__ST71830_Layout __EE74793, __ST70696_Layout __EE74879) := __EEQP(__EE74793.UID,__EE74879.UID);
  __ST71938_Layout __JT74887(__ST71830_Layout __l, __ST70696_Layout __r) := TRANSFORM
    SELF.C_O_U_N_T___Person_Person__1_ := __r.C_O_U_N_T___Person_Person_;
    SELF.U_I_D__3_ := __r.UID;
    SELF := __l;
    SELF := __r;
  END;
  SHARED __EE74911 := JOIN(__EE74793,__EE74879,__JC74887(LEFT,RIGHT),__JT74887(LEFT,RIGHT),LEFT OUTER,HASH);
  SHARED __EE70512 := __EE69988(__EE69988.Vl_Event30_Active_Flag_ = 1);
  __JC73794(E_Person_Person.Layout __EE73782, B_Person_3.__ST13337_Layout __EE70512) := __EEQP(__EE73782.To_Person_,__EE70512.UID);
  SHARED __EE73795 := JOIN(__EE73782,__EE70512,__JC73794(LEFT,RIGHT),TRANSFORM(E_Person_Person.Layout,SELF:=LEFT),HASH,KEEP(1));
  SHARED __ST74942_Layout := RECORD
    KEL.typ.ntyp(E_Person.Typ) From_Person_;
    KEL.typ.ntyp(E_Person.Typ) To_Person_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  SHARED __EE74946 := PROJECT(TABLE(PROJECT(__EE73795,__ST74942_Layout),{KEL.typ.int __RecordCount := SUM(GROUP,__RecordCount),KEL.typ.epoch Date_First_Seen_ := KEL.era.SimpleRoll(GROUP,Date_First_Seen_,MIN,TRUE),KEL.typ.epoch Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Date_Last_Seen_,MAX,FALSE),From_Person_,To_Person_},From_Person_,To_Person_,MERGE),__ST74942_Layout);
  SHARED __ST74970_Layout := RECORD
    KEL.typ.ntyp(E_Person.Typ) From_Person_;
    KEL.typ.ntyp(E_Person.Typ) To_Person_;
    KEL.typ.ntyp(E_Person.Typ) Subject_;
    KEL.typ.ntyp(E_Email.Typ) Emailof_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  __JC74961(__ST74942_Layout __EE74946, __ST74508_Layout __EE74512) := __EEQP(__EE74512.Subject_,__EE74946.From_Person_);
  __ST74970_Layout __JT74961(__ST74942_Layout __l, __ST74508_Layout __r) := TRANSFORM
    SELF := __l;
    SELF := __r;
  END;
  SHARED __EE74968 := JOIN(__EE74512,__EE74946,__JC74961(RIGHT,LEFT),__JT74961(RIGHT,LEFT),INNER,HASH);
  SHARED __ST70440_Layout := RECORD
    KEL.typ.ntyp(E_Email.Typ) UID;
    KEL.typ.ntyp(E_Person.Typ) To_Person_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
  END;
  SHARED __EE74988 := DEDUP(PROJECT(__EE74968,TRANSFORM(__ST70440_Layout,SELF.UID := LEFT.Emailof_,SELF := LEFT)),ALL);
  SHARED __ST70458_Layout := RECORD
    KEL.typ.int C_O_U_N_T___Person_Person_ := 0;
    KEL.typ.ntyp(E_Email.Typ) UID;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
  END;
  SHARED __EE75001 := PROJECT(__CLEANANDDO(__EE74988,TABLE(__EE74988,{KEL.typ.int C_O_U_N_T___Person_Person_ := COUNT(GROUP),UID},UID,MERGE)),__ST70458_Layout);
  SHARED __ST72047_Layout := RECORD
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
  __JC75009(__ST71938_Layout __EE74911, __ST70458_Layout __EE75001) := __EEQP(__EE74911.UID,__EE75001.UID);
  __ST72047_Layout __JT75009(__ST71938_Layout __l, __ST70458_Layout __r) := TRANSFORM
    SELF.C_O_U_N_T___Person_Person__2_ := __r.C_O_U_N_T___Person_Person_;
    SELF.U_I_D__4_ := __r.UID;
    SELF := __l;
    SELF := __r;
  END;
  SHARED __EE75035 := JOIN(__EE74911,__EE75001,__JC75009(LEFT,RIGHT),__JT75009(LEFT,RIGHT),LEFT OUTER,HASH);
  EXPORT __ST12550_Layout := RECORD
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
  SHARED __ST12550_Layout __ND75065__Project(__ST72047_Layout __PP75036) := TRANSFORM
    SELF.Cl_Active30_Identity_Count_ := __PP75036.C_O_U_N_T___Person_Person__2_;
    SELF.Cl_Active7_Identity_Count_ := __PP75036.C_O_U_N_T___Person_Person__1_;
    SELF.Cl_Event_Count_ := __PP75036.C_O_U_N_T___Person_Event_;
    SELF.Cl_Identity_Count_ := __PP75036.C_O_U_N_T___Person_Person_;
    SELF := __PP75036;
  END;
  EXPORT __ENH_Email_2 := PROJECT(__EE75035,__ND75065__Project(LEFT));
END;
