//HPCC Systems KEL Compiler Version 0.11.6-2
IMPORT KEL011 AS KEL;
IMPORT B_Email_5,E_Address,E_Customer,E_Email,E_Person,E_Person_Email FROM KELOtto;
IMPORT * FROM KEL011.Null;
EXPORT B_Email_4 := MODULE
  SHARED VIRTUAL TYPEOF(B_Email_5.__ENH_Email_5) __ENH_Email_5 := B_Email_5.__ENH_Email_5;
  SHARED VIRTUAL TYPEOF(E_Person_Email.__Result) __E_Person_Email := E_Person_Email.__Result;
  SHARED __EE147649 := __ENH_Email_5;
  SHARED __EE147697 := __E_Person_Email;
  SHARED __EE147811 := __EE147697(__NN(__EE147697.Emailof_));
  SHARED __ST147722_Layout := RECORD
    KEL.typ.ntyp(E_Email.Typ) UID;
    KEL.typ.ntyp(E_Person.Typ) Subject_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
  END;
  SHARED __EE147897 := PROJECT(TABLE(PROJECT(__EE147811,TRANSFORM(__ST147722_Layout,SELF.UID := LEFT.Emailof_,SELF := LEFT)),{KEL.typ.epoch Date_First_Seen_ := KEL.era.SimpleRoll(GROUP,Date_First_Seen_,MIN,TRUE),KEL.typ.epoch Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Date_Last_Seen_,MAX,FALSE),UID,Subject_},UID,Subject_,MERGE),__ST147722_Layout);
  SHARED __ST147740_Layout := RECORD
    KEL.typ.int C_O_U_N_T___Person_Email_ := 0;
    KEL.typ.ntyp(E_Email.Typ) UID;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
  END;
  SHARED __EE147894 := PROJECT(__CLEANANDDO(__EE147897,TABLE(__EE147897,{KEL.typ.int C_O_U_N_T___Person_Email_ := COUNT(GROUP),UID},UID,MERGE)),__ST147740_Layout);
  SHARED __ST147904_Layout := RECORD
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
  __JC147901(B_Email_5.__ST57860_Layout __EE147649, __ST147740_Layout __EE147894) := __EEQP(__EE147649.UID,__EE147894.UID);
  __ST147904_Layout __JT147901(B_Email_5.__ST57860_Layout __l, __ST147740_Layout __r) := TRANSFORM
    SELF.U_I_D__1_ := __r.UID;
    SELF := __l;
    SELF := __r;
  END;
  SHARED __EE147902 := JOIN(__EE147649,__EE147894,__JC147901(LEFT,RIGHT),__JT147901(LEFT,RIGHT),LEFT OUTER,HASH);
  EXPORT __ST56494_Layout := RECORD
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
  EXPORT __ENH_Email_4 := PROJECT(__EE147902,TRANSFORM(__ST56494_Layout,SELF.Identity_Count_ := LEFT.C_O_U_N_T___Person_Email_,SELF := LEFT)) : PERSIST('~temp::KEL::KELOtto::Email::Annotated_4',EXPIRE(7));
END;
