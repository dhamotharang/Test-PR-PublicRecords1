//HPCC Systems KEL Compiler Version 0.11.0
IMPORT KEL011 AS KEL;
IMPORT E_Address,E_Customer,E_Customer_Address,E_Customer_Address_Person,E_Person FROM KELOtto;
IMPORT * FROM KEL011.Null;
EXPORT B_Customer_Address_3 := MODULE
  SHARED VIRTUAL TYPEOF(E_Customer_Address.__Result) __E_Customer_Address := E_Customer_Address.__Result;
  SHARED VIRTUAL TYPEOF(E_Customer_Address_Person.__Result) __E_Customer_Address_Person := E_Customer_Address_Person.__Result;
  SHARED __EE21686 := __E_Customer_Address;
  SHARED __ST21882_Layout := RECORD
    KEL.typ.ntyp(E_Customer.Typ) Source_Customer_;
    KEL.typ.ntyp(E_Address.Typ) Location_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  SHARED __EE22526 := PROJECT(__EE21686,__ST21882_Layout);
  SHARED __EE21715 := __E_Customer_Address_Person;
  SHARED __EE22708 := __EE21715(__T(__AND(__OP2(__EE21715.Source_Customer_,=,__EE21715.Associated_Customer_),__CN(__NN(__EE21715.Location_) AND __NN(__EE21715.Source_Customer_) AND __NN(__EE21715.Location_)))));
  SHARED __EE22411 := __EE21686(__NN(__EE21686.Source_Customer_) AND __NN(__EE21686.Location_));
  SHARED __ST22589_Layout := RECORD
    KEL.typ.ntyp(E_Customer.Typ) Source_Customer__1_;
    KEL.typ.ntyp(E_Address.Typ) Location__1_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
  END;
  SHARED __ST22589_Layout __ND22584__Project(E_Customer_Address.Layout __PP22583) := TRANSFORM
    SELF.Source_Customer__1_ := __PP22583.Source_Customer_;
    SELF.Location__1_ := __PP22583.Location_;
    SELF := __PP22583;
  END;
  SHARED __EE22593 := PROJECT(__EE22411,__ND22584__Project(LEFT));
  SHARED __ST22609_Layout := RECORD
    KEL.typ.ntyp(E_Customer.Typ) Source_Customer_;
    KEL.typ.ntyp(E_Customer.Typ) Associated_Customer_;
    KEL.typ.ntyp(E_Person.Typ) Subject_;
    KEL.typ.ntyp(E_Address.Typ) Location_;
    KEL.typ.nint Event_Count_;
    KEL.typ.ntyp(E_Customer.Typ) Source_Customer__1_;
    KEL.typ.ntyp(E_Address.Typ) Location__1_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  __JC22722(E_Customer_Address_Person.Layout __EE22708, __ST22589_Layout __EE22593) := __NNEQ(__EE22708.Location_,__EE22593.Location__1_) AND __NNEQ(__EE22708.Source_Customer_,__EE22593.Source_Customer__1_) AND __EEQP(__EE22593.Location__1_,__EE22708.Location_) AND __T(__AND(__OP2(__EE22708.Location_,=,__EE22593.Location__1_),__AND(__OP2(__EE22708.Source_Customer_,=,__EE22593.Source_Customer__1_),__EEQ(__EE22593.Location__1_,__EE22708.Location_))));
  __ST22609_Layout __JT22722(E_Customer_Address_Person.Layout __l, __ST22589_Layout __r) := TRANSFORM
    SELF := __l;
    SELF := __r;
  END;
  SHARED __EE22731 := JOIN(__EE22593,__EE22708,__JC22722(RIGHT,LEFT),__JT22722(RIGHT,LEFT),INNER,HASH);
  SHARED __ST21841_Layout := RECORD
    KEL.typ.ntyp(E_Customer.Typ) Source_Customer_;
    KEL.typ.ntyp(E_Address.Typ) Location_;
    KEL.typ.ntyp(E_Person.Typ) Subject_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
  END;
  SHARED __ST21841_Layout __ND22736__Project(__ST22609_Layout __PP22732) := TRANSFORM
    SELF.Source_Customer_ := __PP22732.Source_Customer__1_;
    SELF.Location_ := __PP22732.Location__1_;
    SELF := __PP22732;
  END;
  SHARED __EE22749 := DEDUP(PROJECT(__EE22731,__ND22736__Project(LEFT)),ALL);
  SHARED __ST21865_Layout := RECORD
    KEL.typ.int Person_Count_ := 0;
    KEL.typ.ntyp(E_Customer.Typ) Source_Customer_;
    KEL.typ.ntyp(E_Address.Typ) Location_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
  END;
  SHARED __EE22766 := PROJECT(__CLEANANDDO(__EE22749,TABLE(__EE22749,{KEL.typ.int Person_Count_ := COUNT(GROUP),Source_Customer_,Location_},Source_Customer_,Location_,MERGE)),__ST21865_Layout);
  SHARED __ST21900_Layout := RECORD
    KEL.typ.ntyp(E_Customer.Typ) Source_Customer_;
    KEL.typ.ntyp(E_Address.Typ) Location_;
    KEL.typ.int Person_Count_ := 0;
    KEL.typ.ntyp(E_Customer.Typ) Source_Customer__1_;
    KEL.typ.ntyp(E_Address.Typ) Location__1_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  __JC22776(__ST21882_Layout __EE22526, __ST21865_Layout __EE22766) := __EEQP(__EE22526.Source_Customer_,__EE22766.Source_Customer_) AND __EEQP(__EE22526.Location_,__EE22766.Location_);
  __ST21900_Layout __JT22776(__ST21882_Layout __l, __ST21865_Layout __r) := TRANSFORM
    SELF.Source_Customer__1_ := __r.Source_Customer_;
    SELF.Location__1_ := __r.Location_;
    SELF := __l;
    SELF := __r;
  END;
  SHARED __EE22787 := JOIN(__EE22526,__EE22766,__JC22776(LEFT,RIGHT),__JT22776(LEFT,RIGHT),LEFT OUTER,hash);
  EXPORT __ST3923_Layout := RECORD
    KEL.typ.ntyp(E_Customer.Typ) Source_Customer_;
    KEL.typ.ntyp(E_Address.Typ) Location_;
    KEL.typ.int Person_Count_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  EXPORT __ENH_Customer_Address_3 := PROJECT(__EE22787,__ST3923_Layout);
END;
