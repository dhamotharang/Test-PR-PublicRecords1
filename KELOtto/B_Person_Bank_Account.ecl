//HPCC Systems KEL Compiler Version 0.11.0
IMPORT KEL011 AS KEL;
IMPORT E_Bank,E_Bank_Account,E_Customer,E_Person,E_Person_Bank_Account FROM KELOtto;
IMPORT * FROM KEL011.Null;
EXPORT B_Person_Bank_Account := MODULE
  SHARED __EE526537 := E_Person_Bank_Account.__Result;
  SHARED __IDX_Person_Bank_Account_Account__Filtered := __EE526537(__NN(__EE526537.Account_));
  SHARED IDX_Person_Bank_Account_Account__Layout := RECORD
    E_Bank_Account.Typ Account_;
    __IDX_Person_Bank_Account_Account__Filtered._r_Customer_;
    __IDX_Person_Bank_Account_Account__Filtered.Subject_;
    __IDX_Person_Bank_Account_Account__Filtered.Date_First_Seen_;
    __IDX_Person_Bank_Account_Account__Filtered.Date_Last_Seen_;
    __IDX_Person_Bank_Account_Account__Filtered.__RecordCount;
  END;
  SHARED IDX_Person_Bank_Account_Account__Projected := PROJECT(__IDX_Person_Bank_Account_Account__Filtered,TRANSFORM(IDX_Person_Bank_Account_Account__Layout,SELF.Account_:=__T(LEFT.Account_),SELF:=LEFT));
  EXPORT IDX_Person_Bank_Account_Account_ := INDEX(IDX_Person_Bank_Account_Account__Projected,{Account_},{IDX_Person_Bank_Account_Account__Projected},'~key::KEL::KELOtto::Person_Bank_Account::Account_');
  EXPORT IDX_Person_Bank_Account_Account__Build := BUILD(IDX_Person_Bank_Account_Account_,OVERWRITE);
  EXPORT __ST526539_Layout := RECORDOF(IDX_Person_Bank_Account_Account_);
  EXPORT IDX_Person_Bank_Account_Account__Wrapped := PROJECT(IDX_Person_Bank_Account_Account_,TRANSFORM(E_Person_Bank_Account.Layout,SELF.Account_ := __CN(LEFT.Account_),SELF:=LEFT));
  EXPORT BuildAll := PARALLEL(IDX_Person_Bank_Account_Account__Build);
END;
