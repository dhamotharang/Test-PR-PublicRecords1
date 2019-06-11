//HPCC Systems KEL Compiler Version 0.11.0
IMPORT KEL011 AS KEL;
IMPORT B_Bank_1,B_Bank_3,E_Bank,E_Customer FROM KELOtto;
IMPORT * FROM KEL011.Null;
EXPORT B_Bank := MODULE
  SHARED VIRTUAL TYPEOF(B_Bank_1.__ENH_Bank_1) __ENH_Bank_1 := B_Bank_1.__ENH_Bank_1;
  SHARED __EE376037 := __ENH_Bank_1;
  EXPORT __ENH_Bank := __EE376037 : PERSIST('~temp::KEL::KELOtto::Bank::Annotated',EXPIRE(30));
  SHARED __EE830813 := __ENH_Bank;
  SHARED IDX_Bank_UID_Layout := RECORD
    KEL.typ.uid UID;
    __EE830813._r_Customer_;
    __EE830813.Source_Customers_;
    __EE830813.Routing_Number_;
    __EE830813.Full_Bankname_;
    __EE830813.Abbreviated_Bankname_;
    __EE830813.Fractional_Routingnumber_;
    __EE830813.Headoffice_Routingnumber_;
    __EE830813.Headoffice_Branchcodes_;
    __EE830813._hit_;
    __EE830813.High_Risk_Routing_;
    __EE830813.Date_First_Seen_;
    __EE830813.Date_Last_Seen_;
    __EE830813.__RecordCount;
  END;
  SHARED IDX_Bank_UID_Projected := PROJECT(__EE830813,TRANSFORM(IDX_Bank_UID_Layout,SELF.UID:=__T(LEFT.UID),SELF:=LEFT));
  EXPORT IDX_Bank_UID := INDEX(IDX_Bank_UID_Projected,{UID},{IDX_Bank_UID_Projected},'~key::KEL::KELOtto::Bank::UID');
  EXPORT IDX_Bank_UID_Build := BUILD(IDX_Bank_UID,OVERWRITE);
  EXPORT __ST830815_Layout := RECORDOF(IDX_Bank_UID);
  EXPORT IDX_Bank_UID_Wrapped := PROJECT(IDX_Bank_UID,TRANSFORM(B_Bank_3.__ST21367_Layout,SELF.UID := __CN(LEFT.UID),SELF:=LEFT));
  EXPORT BuildAll := PARALLEL(IDX_Bank_UID_Build);
END;
