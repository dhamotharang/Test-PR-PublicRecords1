//HPCC Systems KEL Compiler Version 0.11.6-2
IMPORT KEL011 AS KEL;
IMPORT B_Person_8,E_Address,E_Customer,E_Person FROM FraudgovKEL;
IMPORT * FROM KEL011.Null;
EXPORT B_Person_7 := MODULE
  SHARED VIRTUAL TYPEOF(B_Person_8.__ENH_Person_8) __ENH_Person_8 := B_Person_8.__ENH_Person_8;
  SHARED __EE130043 := __ENH_Person_8;
  EXPORT __ST103796_Layout := RECORD
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
    KEL.typ.int Deceased_Match_ := 0;
    KEL.typ.int Deceased_Name_Match_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  SHARED __ST103796_Layout __ND130498__Project(B_Person_8.__ST104993_Layout __PP129732) := TRANSFORM
    SELF.Deceased_Match_ := MAP(__PP129732.Deceased_ = 1 AND __PP129732.Deceased_Name_Match_ = 1 AND __PP129732.Deceased_Dob_Match_ = 1=>1,0);
    SELF := __PP129732;
  END;
  EXPORT __ENH_Person_7 := PROJECT(__EE130043,__ND130498__Project(LEFT)) : PERSIST('~fraudgov::temp::KEL::FraudgovKEL::Person::Annotated_7',EXPIRE(7));
END;
