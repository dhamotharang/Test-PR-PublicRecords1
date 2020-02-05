//HPCC Systems KEL Compiler Version 0.11.6-2
IMPORT KEL011 AS KEL;
IMPORT B_Bank_1,B_Bank_3,E_Bank,E_Customer FROM KELOtto;
IMPORT * FROM KEL011.Null;
EXPORT B_Bank := MODULE
  SHARED VIRTUAL TYPEOF(B_Bank_1.__ENH_Bank_1) __ENH_Bank_1 := B_Bank_1.__ENH_Bank_1;
  SHARED __EE1193221 := __ENH_Bank_1;
  EXPORT __ENH_Bank := __EE1193221 : PERSIST('~temp::KEL::KELOtto::Bank::Annotated',EXPIRE(7));
  SHARED __EE3316092 := __ENH_Bank;
  SHARED IDX_Bank_UID_Layout := RECORD
    KEL.typ.uid UID;
    __EE3316092._r_Customer_;
    __EE3316092.Source_Customers_;
    __EE3316092.Routing_Number_;
    __EE3316092.Full_Bankname_;
    __EE3316092.Abbreviated_Bankname_;
    __EE3316092.Fractional_Routingnumber_;
    __EE3316092.Headoffice_Routingnumber_;
    __EE3316092.Headoffice_Branchcodes_;
    __EE3316092._hit_;
    __EE3316092.High_Risk_Routing_;
    __EE3316092.Date_First_Seen_;
    __EE3316092.Date_Last_Seen_;
    __EE3316092.__RecordCount;
  END;
  SHARED IDX_Bank_UID_Projected := PROJECT(__EE3316092,TRANSFORM(IDX_Bank_UID_Layout,SELF.UID:=__T(LEFT.UID),SELF:=LEFT));
  EXPORT IDX_Bank_UID_Name := '~key::KEL::KELOtto::Bank::UID';
  EXPORT IDX_Bank_UID := INDEX(IDX_Bank_UID_Projected,{UID},{IDX_Bank_UID_Projected},IDX_Bank_UID_Name);
  EXPORT IDX_Bank_UID_Build := BUILD(IDX_Bank_UID,OVERWRITE);
  EXPORT __ST3316094_Layout := RECORDOF(IDX_Bank_UID);
  EXPORT IDX_Bank_UID_Wrapped := PROJECT(IDX_Bank_UID,TRANSFORM(B_Bank_3.__ST58516_Layout,SELF.UID := __CN(LEFT.UID),SELF:=LEFT));
  EXPORT BuildAll := PARALLEL(IDX_Bank_UID_Build);
END;
