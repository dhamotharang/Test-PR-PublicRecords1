﻿//HPCC Systems KEL Compiler Version 0.11.6-2
IMPORT KEL011 AS KEL;
IMPORT B_Bank_1,B_Bank_2,E_Bank,E_Customer FROM FraudgovKEL;
IMPORT * FROM KEL011.Null;
EXPORT B_Bank := MODULE
  SHARED VIRTUAL TYPEOF(B_Bank_1.__ENH_Bank_1) __ENH_Bank_1 := B_Bank_1.__ENH_Bank_1;
  SHARED __EE2485742 := __ENH_Bank_1;
  EXPORT __ENH_Bank := __EE2485742 : PERSIST('~temp::KEL::FraudgovKEL::Bank::Annotated',EXPIRE(7));
  SHARED __EE4415712 := __ENH_Bank;
  SHARED IDX_Bank_UID_Layout := RECORD
    KEL.typ.uid UID;
    __EE4415712._r_Customer_;
    __EE4415712.Source_Customers_;
    __EE4415712.Routing_Number_;
    __EE4415712.Full_Bankname_;
    __EE4415712.Abbreviated_Bankname_;
    __EE4415712.Fractional_Routingnumber_;
    __EE4415712.Headoffice_Routingnumber_;
    __EE4415712.Headoffice_Branchcodes_;
    __EE4415712._hit_;
    __EE4415712.High_Risk_Routing_;
    __EE4415712.Date_First_Seen_;
    __EE4415712.Date_Last_Seen_;
    __EE4415712.__RecordCount;
  END;
  SHARED IDX_Bank_UID_Projected := PROJECT(__EE4415712,TRANSFORM(IDX_Bank_UID_Layout,SELF.UID:=__T(LEFT.UID),SELF:=LEFT));
  EXPORT IDX_Bank_UID_Name := '~key::KEL::FraudgovKEL::Bank::UID';
  EXPORT IDX_Bank_UID := INDEX(IDX_Bank_UID_Projected,{UID},{IDX_Bank_UID_Projected},IDX_Bank_UID_Name);
  EXPORT IDX_Bank_UID_Build := BUILD(IDX_Bank_UID,OVERWRITE);
  EXPORT __ST4415714_Layout := RECORDOF(IDX_Bank_UID);
  EXPORT IDX_Bank_UID_Wrapped := PROJECT(IDX_Bank_UID,TRANSFORM(B_Bank_2.__ST84393_Layout,SELF.UID := __CN(LEFT.UID),SELF:=LEFT));
  EXPORT BuildAll := PARALLEL(IDX_Bank_UID_Build);
END;
