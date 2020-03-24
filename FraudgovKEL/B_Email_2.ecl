//HPCC Systems KEL Compiler Version 0.11.6-2
IMPORT KEL011 AS KEL;
IMPORT B_Email_3,B_Email_4,E_Address,E_Customer,E_Email,E_Person,E_Person_Email FROM FraudgovKEL;
IMPORT * FROM KEL011.Null;
EXPORT B_Email_2 := MODULE
  SHARED VIRTUAL TYPEOF(B_Email_3.__ENH_Email_3) __ENH_Email_3 := B_Email_3.__ENH_Email_3;
  SHARED VIRTUAL TYPEOF(E_Person_Email.__Result) __E_Person_Email := E_Person_Email.__Result;
  SHARED __EE186407 := __ENH_Email_3;
  SHARED __EE186455 := __E_Person_Email;
  SHARED __EE186569 := __EE186455(__NN(__EE186455.Emailof_));
  SHARED __ST186480_Layout := RECORD
    KEL.typ.ntyp(E_Email.Typ) UID;
    KEL.typ.ntyp(E_Person.Typ) Subject_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
  END;
  SHARED __EE186655 := PROJECT(TABLE(PROJECT(__EE186569,TRANSFORM(__ST186480_Layout,SELF.UID := LEFT.Emailof_,SELF := LEFT)),{KEL.typ.epoch Date_First_Seen_ := KEL.era.SimpleRoll(GROUP,Date_First_Seen_,MIN,TRUE),KEL.typ.epoch Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Date_Last_Seen_,MAX,FALSE),UID,Subject_},UID,Subject_,MERGE),__ST186480_Layout);
  SHARED __ST186498_Layout := RECORD
    KEL.typ.int C_O_U_N_T___Person_Email_ := 0;
    KEL.typ.ntyp(E_Email.Typ) UID;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
  END;
  SHARED __EE186652 := PROJECT(__CLEANANDDO(__EE186655,TABLE(__EE186655,{KEL.typ.int C_O_U_N_T___Person_Email_ := COUNT(GROUP),UID},UID,MERGE)),__ST186498_Layout);
  SHARED __ST186662_Layout := RECORD
    KEL.typ.nuid UID;
    KEL.typ.ntyp(E_Customer.Typ) _r_Customer_;
    KEL.typ.ndataset(E_Email.Source_Customers_Layout) Source_Customers_;
    KEL.typ.nstr Email_Address_;
    KEL.typ.nstr Otto_Email_Id_;
    KEL.typ.ndataset(E_Email.Details_Layout) Details_;
    KEL.typ.nstr Email_Last_Domain_;
    KEL.typ.nint _isdisposableemail_;
    KEL.typ.nkdate Kr_Last_Event_Date_;
    KEL.typ.int C_O_U_N_T___Person_Email_ := 0;
    KEL.typ.ntyp(E_Email.Typ) U_I_D__1_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  __JC186659(B_Email_4.__ST40468_Layout __EE186407, __ST186498_Layout __EE186652) := __EEQP(__EE186407.UID,__EE186652.UID);
  __ST186662_Layout __JT186659(B_Email_4.__ST40468_Layout __l, __ST186498_Layout __r) := TRANSFORM
    SELF.U_I_D__1_ := __r.UID;
    SELF := __l;
    SELF := __r;
  END;
  SHARED __EE186660 := JOIN(__EE186407,__EE186652,__JC186659(LEFT,RIGHT),__JT186659(LEFT,RIGHT),LEFT OUTER,HASH);
  EXPORT __ST37020_Layout := RECORD
    KEL.typ.nuid UID;
    KEL.typ.ntyp(E_Customer.Typ) _r_Customer_;
    KEL.typ.ndataset(E_Email.Source_Customers_Layout) Source_Customers_;
    KEL.typ.nstr Email_Address_;
    KEL.typ.nstr Otto_Email_Id_;
    KEL.typ.ndataset(E_Email.Details_Layout) Details_;
    KEL.typ.nstr Email_Last_Domain_;
    KEL.typ.nint _isdisposableemail_;
    KEL.typ.int Identity_Count_ := 0;
    KEL.typ.nkdate Kr_Last_Event_Date_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  EXPORT __ENH_Email_2 := PROJECT(__EE186660,TRANSFORM(__ST37020_Layout,SELF.Identity_Count_ := LEFT.C_O_U_N_T___Person_Email_,SELF := LEFT)) : PERSIST('~temp::KEL::FraudgovKEL::Email::Annotated_2',EXPIRE(7));
END;
