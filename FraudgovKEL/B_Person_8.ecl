﻿//HPCC Systems KEL Compiler Version 0.11.6-2
IMPORT KEL011 AS KEL;
IMPORT E_Address,E_Customer,E_Person FROM FraudgovKEL;
IMPORT * FROM KEL011.Null;
EXPORT B_Person_8 := MODULE
  SHARED VIRTUAL TYPEOF(E_Person.__Result) __E_Person := E_Person.__Result;
  SHARED __EE118103 := __E_Person;
  EXPORT __ST98828_Layout := RECORD
    KEL.typ.nuid UID;
    KEL.typ.ntyp(E_Customer.Typ) _r_Customer_;
    KEL.typ.nint Lex_Id_;
    KEL.typ.ndataset(E_Person.Source_Customers_Layout) Source_Customers_;
    KEL.typ.ndataset(E_Person.Reported_Date_Of_Birth_Layout) Reported_Date_Of_Birth_;
    KEL.typ.ndataset(E_Person.Reported_Ssn_Layout) Reported_Ssn_;
    KEL.typ.ndataset(E_Person.Reported_Email_Address_Layout) Reported_Email_Address_;
    KEL.typ.ndataset(E_Person.Full_Name_Layout) Full_Name_;
    KEL.typ.nint _rin__source_;
    KEL.typ.nkdate Deceased_Date_;
    KEL.typ.nkdate Deceased_Date_Of_Birth_;
    KEL.typ.nstr Deceased_First_;
    KEL.typ.nstr Deceased_Middle_;
    KEL.typ.nstr Deceased_Last_;
    KEL.typ.nstr Deceased_Match_Code_;
    KEL.typ.nbool _isdeepdive_;
    KEL.typ.nstr _county__death_;
    KEL.typ.nstr Deceased_Ssn_;
    KEL.typ.nstr _state__death__flag_;
    KEL.typ.nstr _death__rec__src_;
    KEL.typ.nstr _state__death__id_;
    KEL.typ.nstr _curr__incar__flag_;
    KEL.typ.nint _name__ssn__dob__match_;
    KEL.typ.ndataset(E_Person.Offenses_Layout) Offenses_;
    KEL.typ.ndataset(E_Person.Address_Layout) Address_;
    KEL.typ.int Deceased_ := 0;
    KEL.typ.int Deceased_Dob_Match_ := 0;
    KEL.typ.int Deceased_Name_Match_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  SHARED __ST98828_Layout __ND118795__Project(E_Person.Layout __PP117713) := TRANSFORM
    SELF.Deceased_ := MAP(__T(__FN1(KEL.Routines.IsValidDate,__PP117713.Deceased_Date_))=>1,0);
    __BS117944 := __T(__PP117713.Reported_Date_Of_Birth_);
    SELF.Deceased_Dob_Match_ := MAP(EXISTS(__BS117944(__T(__OP2(__PP117713.Deceased_Date_Of_Birth_,=,__T(__PP117713.Reported_Date_Of_Birth_).Date_Of_Birth_))))=>1,0);
    __BS117986 := __T(__PP117713.Full_Name_);
    SELF.Deceased_Name_Match_ := MAP(EXISTS(__BS117986(__T(__AND(__OP2(__T(__PP117713.Full_Name_).First_Name_,=,__PP117713.Deceased_First_),__OP2(__T(__PP117713.Full_Name_).Last_Name_,=,__PP117713.Deceased_Last_)))))=>1,0);
    SELF := __PP117713;
  END;
  EXPORT __ENH_Person_8 := PROJECT(__EE118103,__ND118795__Project(LEFT)) : PERSIST('~temp::KEL::FraudgovKEL::Person::Annotated_8',EXPIRE(7));
END;
