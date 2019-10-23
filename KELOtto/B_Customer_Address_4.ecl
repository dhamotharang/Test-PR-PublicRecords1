//HPCC Systems KEL Compiler Version 0.11.0
IMPORT KEL011 AS KEL;
IMPORT E_Address,E_Customer,E_Customer_Address,E_Customer_Address_Person,E_Person FROM KELOtto;
IMPORT * FROM KEL011.Null;
EXPORT B_Customer_Address_4 := MODULE
  SHARED VIRTUAL TYPEOF(E_Customer_Address.__Result) __E_Customer_Address := E_Customer_Address.__Result;
  SHARED VIRTUAL TYPEOF(E_Customer_Address_Person.__Result) __E_Customer_Address_Person := E_Customer_Address_Person.__Result;
  SHARED __EE5276 := __E_Customer_Address;
  SHARED __EE5597 := __EE5276(__NN(__EE5276.Source_Customer_));
  SHARED __EE5496 := __E_Customer_Address_Person;
  SHARED __EE5726 := __EE5496(__T(__AND(__OP2(__EE5496.Source_Customer_,=,__EE5496.Associated_Customer_),__CN(__NN(__EE5496.Source_Customer_)))));
  SHARED __ST5443_Layout := RECORD
    KEL.typ.ntyp(E_Customer.Typ) Source_Customer_;
    KEL.typ.ntyp(E_Address.Typ) Location_;
    KEL.typ.ndataset(E_Customer_Address_Person.Layout) Customer_Address_Person_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  __JC5738(E_Customer_Address.Layout __EE5597, E_Customer_Address_Person.Layout __EE5726) := __EEQP(__EE5597.Location_,__EE5726.Location_) AND __NNEQ(__EE5726.Source_Customer_,__EE5597.Source_Customer_) AND __T(__AND(__EEQ(__EE5597.Location_,__EE5726.Location_),__AND(__OP2(__EE5726.Source_Customer_,=,__EE5597.Source_Customer_),__CN(__NN(__EE5597.Location_)))));
  __ST5443_Layout __Join__ST5443_Layout(E_Customer_Address.Layout __r, DATASET(E_Customer_Address_Person.Layout) __recs) := TRANSFORM
    SELF := __r;
    SELF.Customer_Address_Person_ := __CN(__recs);
  END;
  SHARED __EE5749 := DENORMALIZE(DISTRIBUTE(__EE5597,HASH(Location_)),DISTRIBUTE(__EE5726,HASH(Location_)),__JC5738(LEFT,RIGHT),GROUP,__Join__ST5443_Layout(LEFT,ROWS(RIGHT)),LOCAL);
  EXPORT __ST3619_Layout := RECORD
    KEL.typ.ntyp(E_Customer.Typ) Source_Customer_;
    KEL.typ.ntyp(E_Address.Typ) Location_;
    KEL.typ.ndataset(E_Customer_Address_Person.Layout) Customer_Persons_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  SHARED __ST3619_Layout __ND5758__Project(__ST5443_Layout __PP5754) := TRANSFORM
    __EE5752 := __PP5754.Customer_Address_Person_;
    SELF.Customer_Persons_ := __EE5752;
    SELF := __PP5754;
  END;
  EXPORT __ENH_Customer_Address_4 := PROJECT(__EE5749,__ND5758__Project(LEFT));
END;
