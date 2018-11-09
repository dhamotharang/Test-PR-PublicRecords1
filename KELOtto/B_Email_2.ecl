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
  SHARED __EE65836 := __E_Email;
  SHARED __EE65917 := __E_Person_Person;
  SHARED __EE69958 := __EE65917;
  SHARED __EE69979 := __EE69958(__NN(__EE69958.From_Person_));
  SHARED __ST70443_Layout := RECORD
    KEL.typ.ntyp(E_Person.Typ) From_Person_;
    KEL.typ.ntyp(E_Person.Typ) To_Person_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  SHARED __EE70447 := PROJECT(TABLE(PROJECT(__EE69979,__ST70443_Layout),{KEL.typ.int __RecordCount := SUM(GROUP,__RecordCount),KEL.typ.epoch Date_First_Seen_ := KEL.era.SimpleRoll(GROUP,Date_First_Seen_,MIN,TRUE),KEL.typ.epoch Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Date_Last_Seen_,MAX,FALSE),From_Person_,To_Person_},From_Person_,To_Person_,MERGE),__ST70443_Layout);
  SHARED __EE65898 := __E_Person_Email;
  SHARED __EE69781 := __EE65898(__NN(__EE65898.Emailof_) AND __NN(__EE65898.Subject_));
  SHARED __ST70455_Layout := RECORD
    KEL.typ.ntyp(E_Person.Typ) Subject_;
    KEL.typ.ntyp(E_Email.Typ) Emailof_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
  END;
  SHARED __EE70459 := DEDUP(PROJECT(__EE69781,__ST70455_Layout),ALL);
  SHARED __ST70481_Layout := RECORD
    KEL.typ.ntyp(E_Person.Typ) From_Person_;
    KEL.typ.ntyp(E_Person.Typ) To_Person_;
    KEL.typ.ntyp(E_Person.Typ) Subject_;
    KEL.typ.ntyp(E_Email.Typ) Emailof_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  __JC70472(__ST70443_Layout __EE70447, __ST70455_Layout __EE70459) := __EEQP(__EE70459.Subject_,__EE70447.From_Person_);
  __ST70481_Layout __JT70472(__ST70443_Layout __l, __ST70455_Layout __r) := TRANSFORM
    SELF := __l;
    SELF := __r;
  END;
  SHARED __EE70479 := JOIN(__EE70447,__EE70459,__JC70472(LEFT,RIGHT),__JT70472(LEFT,RIGHT),INNER,HASH);
  SHARED __ST67085_Layout := RECORD
    KEL.typ.ntyp(E_Email.Typ) UID;
    KEL.typ.ntyp(E_Person.Typ) To_Person_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
  END;
  SHARED __EE70499 := DEDUP(PROJECT(__EE70479,TRANSFORM(__ST67085_Layout,SELF.UID := LEFT.Emailof_,SELF := LEFT)),ALL);
  SHARED __ST67103_Layout := RECORD
    KEL.typ.int C_O_U_N_T___Person_Person_ := 0;
    KEL.typ.ntyp(E_Email.Typ) UID;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
  END;
  SHARED __EE70512 := PROJECT(__CLEANANDDO(__EE70499,TABLE(__EE70499,{KEL.typ.int C_O_U_N_T___Person_Person_ := COUNT(GROUP),UID},UID,MERGE)),__ST67103_Layout);
  SHARED __ST67668_Layout := RECORD
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
  __JC70518(E_Email.Layout __EE65836, __ST67103_Layout __EE70512) := __EEQP(__EE65836.UID,__EE70512.UID);
  __ST67668_Layout __JT70518(E_Email.Layout __l, __ST67103_Layout __r) := TRANSFORM
    SELF.U_I_D__1_ := __r.UID;
    SELF := __l;
    SELF := __r;
  END;
  SHARED __EE70536 := JOIN(__EE65836,__EE70512,__JC70518(LEFT,RIGHT),__JT70518(LEFT,RIGHT),LEFT OUTER,HASH);
  SHARED __EE66176 := __E_Person_Event;
  SHARED __EE68981 := __EE66176(__NN(__EE66176.Subject_));
  SHARED __ST70637_Layout := RECORD
    KEL.typ.ntyp(E_Person.Typ) Subject_;
    KEL.typ.ntyp(E_Event.Typ) Transaction_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  SHARED __EE70641 := PROJECT(TABLE(PROJECT(__EE68981,__ST70637_Layout),{KEL.typ.int __RecordCount := SUM(GROUP,__RecordCount),KEL.typ.epoch Date_First_Seen_ := KEL.era.SimpleRoll(GROUP,Date_First_Seen_,MIN,TRUE),KEL.typ.epoch Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Date_Last_Seen_,MAX,FALSE),Subject_,Transaction_},Subject_,Transaction_,MERGE),__ST70637_Layout);
  SHARED __EE66138 := __E_Person_Event;
  SHARED __EE69304 := __EE66138(__NN(__EE66138.Emailof_) AND __NN(__EE66138.Subject_));
  SHARED __ST70561_Layout := RECORD
    KEL.typ.ntyp(E_Person.Typ) Subject_;
    KEL.typ.ntyp(E_Email.Typ) Emailof_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  SHARED __EE70565 := PROJECT(TABLE(PROJECT(__EE69304,__ST70561_Layout),{KEL.typ.int __RecordCount := SUM(GROUP,__RecordCount),KEL.typ.epoch Date_First_Seen_ := KEL.era.SimpleRoll(GROUP,Date_First_Seen_,MIN,TRUE),KEL.typ.epoch Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Date_Last_Seen_,MAX,FALSE),Subject_,Emailof_},Subject_,Emailof_,MERGE),__ST70561_Layout);
  SHARED __EE69729 := __EE65917(__NN(__EE65917.To_Person_) AND __NN(__EE65917.From_Person_));
  SHARED __ST70573_Layout := RECORD
    KEL.typ.ntyp(E_Person.Typ) From_Person_;
    KEL.typ.ntyp(E_Person.Typ) To_Person_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  SHARED __EE70577 := PROJECT(TABLE(PROJECT(__EE69729,__ST70573_Layout),{KEL.typ.int __RecordCount := SUM(GROUP,__RecordCount),KEL.typ.epoch Date_First_Seen_ := KEL.era.SimpleRoll(GROUP,Date_First_Seen_,MIN,TRUE),KEL.typ.epoch Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Date_Last_Seen_,MAX,FALSE),From_Person_,To_Person_},From_Person_,To_Person_,MERGE),__ST70573_Layout);
  SHARED __ST70599_Layout := RECORD
    KEL.typ.ntyp(E_Person.Typ) Subject_;
    KEL.typ.ntyp(E_Email.Typ) Emailof_;
    KEL.typ.ntyp(E_Person.Typ) From_Person_;
    KEL.typ.ntyp(E_Person.Typ) To_Person_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  __JC70590(__ST70561_Layout __EE70565, __ST70573_Layout __EE70577) := __EEQP(__EE70565.Subject_,__EE70577.From_Person_);
  __ST70599_Layout __JT70590(__ST70561_Layout __l, __ST70573_Layout __r) := TRANSFORM
    SELF := __l;
    SELF := __r;
  END;
  SHARED __EE70597 := JOIN(__EE70565,__EE70577,__JC70590(LEFT,RIGHT),__JT70590(LEFT,RIGHT),INNER,HASH);
  SHARED __ST70649_Layout := RECORD
    KEL.typ.ntyp(E_Email.Typ) Emailof_;
    KEL.typ.ntyp(E_Person.Typ) To_Person_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
  END;
  SHARED __EE70653 := DEDUP(PROJECT(__EE70597,__ST70649_Layout),ALL);
  SHARED __ST70661_Layout := RECORD
    KEL.typ.ntyp(E_Email.Typ) Emailof__1_;
    KEL.typ.ntyp(E_Person.Typ) To_Person_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
  END;
  SHARED __EE70665 := PROJECT(__EE70653,TRANSFORM(__ST70661_Layout,SELF.Emailof__1_ := LEFT.Emailof_,SELF := LEFT));
  SHARED __ST70681_Layout := RECORD
    KEL.typ.ntyp(E_Person.Typ) Subject_;
    KEL.typ.ntyp(E_Event.Typ) Transaction_;
    KEL.typ.ntyp(E_Email.Typ) Emailof__1_;
    KEL.typ.ntyp(E_Person.Typ) To_Person_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  __JC70672(__ST70637_Layout __EE70641, __ST70661_Layout __EE70665) := __EEQP(__EE70665.To_Person_,__EE70641.Subject_);
  __ST70681_Layout __JT70672(__ST70637_Layout __l, __ST70661_Layout __r) := TRANSFORM
    SELF := __l;
    SELF := __r;
  END;
  SHARED __EE70679 := JOIN(__EE70665,__EE70641,__JC70672(RIGHT,LEFT),__JT70672(RIGHT,LEFT),INNER,HASH);
  SHARED __ST66846_Layout := RECORD
    KEL.typ.ntyp(E_Email.Typ) UID;
    KEL.typ.ntyp(E_Event.Typ) Transaction_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
  END;
  SHARED __EE70699 := DEDUP(PROJECT(__EE70679,TRANSFORM(__ST66846_Layout,SELF.UID := LEFT.Emailof__1_,SELF := LEFT)),ALL);
  SHARED __ST66864_Layout := RECORD
    KEL.typ.int C_O_U_N_T___Person_Event_ := 0;
    KEL.typ.ntyp(E_Email.Typ) UID;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
  END;
  SHARED __EE70712 := PROJECT(__CLEANANDDO(__EE70699,TABLE(__EE70699,{KEL.typ.int C_O_U_N_T___Person_Event_ := COUNT(GROUP),UID},UID,MERGE)),__ST66864_Layout);
  SHARED __ST67777_Layout := RECORD
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
  __JC70720(__ST67668_Layout __EE70536, __ST66864_Layout __EE70712) := __EEQP(__EE70536.UID,__EE70712.UID);
  __ST67777_Layout __JT70720(__ST67668_Layout __l, __ST66864_Layout __r) := TRANSFORM
    SELF.U_I_D__2_ := __r.UID;
    SELF := __l;
    SELF := __r;
  END;
  SHARED __EE70740 := JOIN(__EE70536,__EE70712,__JC70720(LEFT,RIGHT),__JT70720(LEFT,RIGHT),LEFT OUTER,HASH);
  SHARED __EE69967 := __EE69729;
  SHARED __EE65935 := __ENH_Person_3;
  SHARED __EE69949 := __EE65935;
  SHARED __EE70233 := __EE69949(__EE69949.Vl_Event7_Active_Flag_ = 1);
  __JC70241(E_Person_Person.Layout __EE69967, B_Person_3.__ST13133_Layout __EE70233) := __EEQP(__EE69967.To_Person_,__EE70233.UID);
  SHARED __EE70242 := JOIN(__EE69967,__EE70233,__JC70241(LEFT,RIGHT),TRANSFORM(E_Person_Person.Layout,SELF:=LEFT),HASH,KEEP(1));
  SHARED __ST70767_Layout := RECORD
    KEL.typ.ntyp(E_Person.Typ) From_Person_;
    KEL.typ.ntyp(E_Person.Typ) To_Person_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  SHARED __EE70771 := PROJECT(TABLE(PROJECT(__EE70242,__ST70767_Layout),{KEL.typ.int __RecordCount := SUM(GROUP,__RecordCount),KEL.typ.epoch Date_First_Seen_ := KEL.era.SimpleRoll(GROUP,Date_First_Seen_,MIN,TRUE),KEL.typ.epoch Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Date_Last_Seen_,MAX,FALSE),From_Person_,To_Person_},From_Person_,To_Person_,MERGE),__ST70767_Layout);
  SHARED __ST70795_Layout := RECORD
    KEL.typ.ntyp(E_Person.Typ) From_Person_;
    KEL.typ.ntyp(E_Person.Typ) To_Person_;
    KEL.typ.ntyp(E_Person.Typ) Subject_;
    KEL.typ.ntyp(E_Email.Typ) Emailof_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  __JC70786(__ST70767_Layout __EE70771, __ST70455_Layout __EE70459) := __EEQP(__EE70459.Subject_,__EE70771.From_Person_);
  __ST70795_Layout __JT70786(__ST70767_Layout __l, __ST70455_Layout __r) := TRANSFORM
    SELF := __l;
    SELF := __r;
  END;
  SHARED __EE70793 := JOIN(__EE70459,__EE70771,__JC70786(RIGHT,LEFT),__JT70786(RIGHT,LEFT),INNER,HASH);
  SHARED __ST66625_Layout := RECORD
    KEL.typ.ntyp(E_Email.Typ) UID;
    KEL.typ.ntyp(E_Person.Typ) To_Person_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
  END;
  SHARED __EE70813 := DEDUP(PROJECT(__EE70793,TRANSFORM(__ST66625_Layout,SELF.UID := LEFT.Emailof_,SELF := LEFT)),ALL);
  SHARED __ST66643_Layout := RECORD
    KEL.typ.int C_O_U_N_T___Person_Person_ := 0;
    KEL.typ.ntyp(E_Email.Typ) UID;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
  END;
  SHARED __EE70826 := PROJECT(__CLEANANDDO(__EE70813,TABLE(__EE70813,{KEL.typ.int C_O_U_N_T___Person_Person_ := COUNT(GROUP),UID},UID,MERGE)),__ST66643_Layout);
  SHARED __ST67885_Layout := RECORD
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
  __JC70834(__ST67777_Layout __EE70740, __ST66643_Layout __EE70826) := __EEQP(__EE70740.UID,__EE70826.UID);
  __ST67885_Layout __JT70834(__ST67777_Layout __l, __ST66643_Layout __r) := TRANSFORM
    SELF.C_O_U_N_T___Person_Person__1_ := __r.C_O_U_N_T___Person_Person_;
    SELF.U_I_D__3_ := __r.UID;
    SELF := __l;
    SELF := __r;
  END;
  SHARED __EE70858 := JOIN(__EE70740,__EE70826,__JC70834(LEFT,RIGHT),__JT70834(LEFT,RIGHT),LEFT OUTER,HASH);
  SHARED __EE66459 := __EE65935(__EE65935.Vl_Event30_Active_Flag_ = 1);
  __JC69741(E_Person_Person.Layout __EE69729, B_Person_3.__ST13133_Layout __EE66459) := __EEQP(__EE69729.To_Person_,__EE66459.UID);
  SHARED __EE69742 := JOIN(__EE69729,__EE66459,__JC69741(LEFT,RIGHT),TRANSFORM(E_Person_Person.Layout,SELF:=LEFT),HASH,KEEP(1));
  SHARED __ST70889_Layout := RECORD
    KEL.typ.ntyp(E_Person.Typ) From_Person_;
    KEL.typ.ntyp(E_Person.Typ) To_Person_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  SHARED __EE70893 := PROJECT(TABLE(PROJECT(__EE69742,__ST70889_Layout),{KEL.typ.int __RecordCount := SUM(GROUP,__RecordCount),KEL.typ.epoch Date_First_Seen_ := KEL.era.SimpleRoll(GROUP,Date_First_Seen_,MIN,TRUE),KEL.typ.epoch Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Date_Last_Seen_,MAX,FALSE),From_Person_,To_Person_},From_Person_,To_Person_,MERGE),__ST70889_Layout);
  SHARED __ST70917_Layout := RECORD
    KEL.typ.ntyp(E_Person.Typ) From_Person_;
    KEL.typ.ntyp(E_Person.Typ) To_Person_;
    KEL.typ.ntyp(E_Person.Typ) Subject_;
    KEL.typ.ntyp(E_Email.Typ) Emailof_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  __JC70908(__ST70889_Layout __EE70893, __ST70455_Layout __EE70459) := __EEQP(__EE70459.Subject_,__EE70893.From_Person_);
  __ST70917_Layout __JT70908(__ST70889_Layout __l, __ST70455_Layout __r) := TRANSFORM
    SELF := __l;
    SELF := __r;
  END;
  SHARED __EE70915 := JOIN(__EE70459,__EE70893,__JC70908(RIGHT,LEFT),__JT70908(RIGHT,LEFT),INNER,HASH);
  SHARED __ST66387_Layout := RECORD
    KEL.typ.ntyp(E_Email.Typ) UID;
    KEL.typ.ntyp(E_Person.Typ) To_Person_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
  END;
  SHARED __EE70935 := DEDUP(PROJECT(__EE70915,TRANSFORM(__ST66387_Layout,SELF.UID := LEFT.Emailof_,SELF := LEFT)),ALL);
  SHARED __ST66405_Layout := RECORD
    KEL.typ.int C_O_U_N_T___Person_Person_ := 0;
    KEL.typ.ntyp(E_Email.Typ) UID;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
  END;
  SHARED __EE70948 := PROJECT(__CLEANANDDO(__EE70935,TABLE(__EE70935,{KEL.typ.int C_O_U_N_T___Person_Person_ := COUNT(GROUP),UID},UID,MERGE)),__ST66405_Layout);
  SHARED __ST67994_Layout := RECORD
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
  __JC70956(__ST67885_Layout __EE70858, __ST66405_Layout __EE70948) := __EEQP(__EE70858.UID,__EE70948.UID);
  __ST67994_Layout __JT70956(__ST67885_Layout __l, __ST66405_Layout __r) := TRANSFORM
    SELF.C_O_U_N_T___Person_Person__2_ := __r.C_O_U_N_T___Person_Person_;
    SELF.U_I_D__4_ := __r.UID;
    SELF := __l;
    SELF := __r;
  END;
  SHARED __EE70982 := JOIN(__EE70858,__EE70948,__JC70956(LEFT,RIGHT),__JT70956(LEFT,RIGHT),LEFT OUTER,HASH);
  EXPORT __ST12371_Layout := RECORD
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
  SHARED __ST12371_Layout __ND71012__Project(__ST67994_Layout __PP70983) := TRANSFORM
    SELF.Cl_Active30_Identity_Count_ := __PP70983.C_O_U_N_T___Person_Person__2_;
    SELF.Cl_Active7_Identity_Count_ := __PP70983.C_O_U_N_T___Person_Person__1_;
    SELF.Cl_Event_Count_ := __PP70983.C_O_U_N_T___Person_Event_;
    SELF.Cl_Identity_Count_ := __PP70983.C_O_U_N_T___Person_Person_;
    SELF := __PP70983;
  END;
  EXPORT __ENH_Email_2 := PROJECT(__EE70982,__ND71012__Project(LEFT));
END;
