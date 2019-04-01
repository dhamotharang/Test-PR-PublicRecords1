//HPCC Systems KEL Compiler Version 0.11.0
IMPORT KEL011 AS KEL;
IMPORT B_Bank_1,B_Bank_3,E_Bank,E_Customer FROM KELOtto;
IMPORT * FROM KEL011.Null;
EXPORT B_Bank := MODULE
  SHARED VIRTUAL TYPEOF(B_Bank_1.__ENH_Bank_1) __ENH_Bank_1 := B_Bank_1.__ENH_Bank_1;
  SHARED __EE373356 := __ENH_Bank_1;
  EXPORT __ENH_Bank := __EE373356 : PERSIST('~temp::KEL::KELOtto::Bank::Annotated',EXPIRE(30));
  SHARED __EE825271 := __ENH_Bank;
  SHARED IDX_Bank_UID_Layout := RECORD
    KEL.typ.uid UID;
    __EE825271._r_Customer_;
    __EE825271.Source_Customers_;
    __EE825271.Routing_Number_;
    __EE825271.Full_Bankname_;
    __EE825271.Abbreviated_Bankname_;
    __EE825271.Fractional_Routingnumber_;
    __EE825271.Headoffice_Routingnumber_;
    __EE825271.Headoffice_Branchcodes_;
    __EE825271._hit_;
    __EE825271.High_Risk_Routing_;
    __EE825271.Date_First_Seen_;
    __EE825271.Date_Last_Seen_;
    __EE825271.__RecordCount;
  END;
  SHARED IDX_Bank_UID_Projected := PROJECT(__EE825271,TRANSFORM(IDX_Bank_UID_Layout,SELF.UID:=__T(LEFT.UID),SELF:=LEFT));
  EXPORT IDX_Bank_UID := INDEX(IDX_Bank_UID_Projected,{UID},{IDX_Bank_UID_Projected},'~key::KEL::KELOtto::Bank::UID');
  EXPORT IDX_Bank_UID_Build := BUILD(IDX_Bank_UID,OVERWRITE);
  EXPORT __ST825273_Layout := RECORDOF(IDX_Bank_UID);
  EXPORT IDX_Bank_UID_Wrapped := PROJECT(IDX_Bank_UID,TRANSFORM(B_Bank_3.__ST21223_Layout,SELF.UID := __CN(LEFT.UID),SELF:=LEFT));
  EXPORT BuildAll := PARALLEL(IDX_Bank_UID_Build);
END;
