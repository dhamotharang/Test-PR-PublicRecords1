//HPCC Systems KEL Compiler Version 0.11.6-2
IMPORT KEL011 AS KEL;
IMPORT B_Email_5,E_Customer,E_Email,E_Person,E_Person_Email FROM KELOtto;
IMPORT * FROM KEL011.Null;
EXPORT B_Email_4 := MODULE
  SHARED VIRTUAL TYPEOF(B_Email_5.__ENH_Email_5) __ENH_Email_5 := B_Email_5.__ENH_Email_5;
  SHARED VIRTUAL TYPEOF(E_Person_Email.__Result) __E_Person_Email := E_Person_Email.__Result;
  SHARED __EE140677 := __ENH_Email_5;
  SHARED __EE140725 := __E_Person_Email;
  SHARED __EE140839 := __EE140725(__NN(__EE140725.Emailof_));
  SHARED __ST140750_Layout := RECORD
    KEL.typ.ntyp(E_Email.Typ) UID;
    KEL.typ.ntyp(E_Person.Typ) Subject_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
  END;
  SHARED __EE140925 := PROJECT(TABLE(PROJECT(__EE140839,TRANSFORM(__ST140750_Layout,SELF.UID := LEFT.Emailof_,SELF := LEFT)),{KEL.typ.epoch Date_First_Seen_ := KEL.era.SimpleRoll(GROUP,Date_First_Seen_,MIN,TRUE),KEL.typ.epoch Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Date_Last_Seen_,MAX,FALSE),UID,Subject_},UID,Subject_,MERGE),__ST140750_Layout);
  SHARED __ST140768_Layout := RECORD
    KEL.typ.int C_O_U_N_T___Person_Email_ := 0;
    KEL.typ.ntyp(E_Email.Typ) UID;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
  END;
  SHARED __EE140922 := PROJECT(__CLEANANDDO(__EE140925,TABLE(__EE140925,{KEL.typ.int C_O_U_N_T___Person_Email_ := COUNT(GROUP),UID},UID,MERGE)),__ST140768_Layout);
  SHARED __ST140932_Layout := RECORD
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
  __JC140929(B_Email_5.__ST54005_Layout __EE140677, __ST140768_Layout __EE140922) := __EEQP(__EE140677.UID,__EE140922.UID);
  __ST140932_Layout __JT140929(B_Email_5.__ST54005_Layout __l, __ST140768_Layout __r) := TRANSFORM
    SELF.U_I_D__1_ := __r.UID;
    SELF := __l;
    SELF := __r;
  END;
  SHARED __EE140930 := JOIN(__EE140677,__EE140922,__JC140929(LEFT,RIGHT),__JT140929(LEFT,RIGHT),LEFT OUTER,HASH);
  EXPORT __ST52670_Layout := RECORD
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
  EXPORT __ENH_Email_4 := PROJECT(__EE140930,TRANSFORM(__ST52670_Layout,SELF.Identity_Count_ := LEFT.C_O_U_N_T___Person_Email_,SELF := LEFT));
END;
