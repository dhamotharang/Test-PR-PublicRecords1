﻿//HPCC Systems KEL Compiler Version 0.11.0
IMPORT KEL011 AS KEL;
IMPORT B_Customer_1,E_Address,E_Customer,E_Email,E_Event,E_Internet_Protocol,E_Person,E_Person_Event,E_Phone,E_Social_Security_Number FROM KELOtto;
IMPORT * FROM KEL011.Null;
EXPORT B_Customer := MODULE
  SHARED VIRTUAL TYPEOF(B_Customer_1.__ENH_Customer_1) __ENH_Customer_1 := B_Customer_1.__ENH_Customer_1;
  SHARED VIRTUAL TYPEOF(E_Person_Event.__Result) __E_Person_Event := E_Person_Event.__Result;
  SHARED __EE184952 := __ENH_Customer_1;
  SHARED __EE185036 := __E_Person_Event;
  SHARED __EE185293 := __EE185036(__NN(__EE185036._r_Customer_));
  SHARED __ST185189_Layout := RECORD
    KEL.typ.ntyp(E_Customer.Typ) UID;
    KEL.typ.nkdate Event_Date_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
  END;
  SHARED __EE185361 := PROJECT(__EE185293,TRANSFORM(__ST185189_Layout,SELF.UID := LEFT._r_Customer_,SELF := LEFT));
  SHARED __ST185204_Layout := RECORD
    KEL.typ.nkdate M_A_X___Event_Date_;
    KEL.typ.ntyp(E_Customer.Typ) UID;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
  END;
  SHARED __EE185377 := PROJECT(__CLEANANDDO(__EE185361,TABLE(__EE185361,{KEL.Aggregates.MaxNG(__EE185361.Event_Date_) M_A_X___Event_Date_,UID},UID,MERGE)),__ST185204_Layout);
  SHARED __ST185448_Layout := RECORD
    KEL.typ.nuid UID;
    KEL.typ.nint Customer_Id_;
    KEL.typ.nint Industry_Type_;
    KEL.typ.int Address_Count_ := 0;
    KEL.typ.int All_Address_Count_ := 0;
    KEL.typ.int All_Deceased_Matched_Person_Count_ := 0;
    KEL.typ.int All_Deceased_Person_Count_ := 0;
    KEL.typ.int All_High_Frequency_Address_Count_ := 0;
    KEL.typ.int All_Person_Count_ := 0;
    KEL.typ.int Deceased_Person_Count_ := 0;
    KEL.typ.int High_Frequency_Address_Count_ := 0;
    KEL.typ.int Person_Count_ := 0;
    KEL.typ.nkdate M_A_X___Event_Date_;
    KEL.typ.ntyp(E_Customer.Typ) U_I_D__1_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  __JC185445(B_Customer_1.__ST7915_Layout __EE184952, __ST185204_Layout __EE185377) := __EEQP(__EE184952.UID,__EE185377.UID);
  __ST185448_Layout __JT185445(B_Customer_1.__ST7915_Layout __l, __ST185204_Layout __r) := TRANSFORM
    SELF.U_I_D__1_ := __r.UID;
    SELF := __l;
    SELF := __r;
  END;
  SHARED __EE185446 := JOIN(__EE184952,__EE185377,__JC185445(LEFT,RIGHT),__JT185445(LEFT,RIGHT),LEFT OUTER,HASH);
  EXPORT __ST7210_Layout := RECORD
    KEL.typ.nuid UID;
    KEL.typ.nint Customer_Id_;
    KEL.typ.nint Industry_Type_;
    KEL.typ.int Address_Count_ := 0;
    KEL.typ.int All_Address_Count_ := 0;
    KEL.typ.float All_Deceased_Matched_Percent_ := 0.0;
    KEL.typ.int All_Deceased_Matched_Person_Count_ := 0;
    KEL.typ.int All_Deceased_Person_Count_ := 0;
    KEL.typ.float All_Deceased_Person_Percent_ := 0.0;
    KEL.typ.int All_High_Frequency_Address_Count_ := 0;
    KEL.typ.float All_High_Frequency_Address_Percent_ := 0.0;
    KEL.typ.int All_Person_Count_ := 0;
    KEL.typ.int Deceased_Person_Count_ := 0;
    KEL.typ.float Deceased_Person_Percent_ := 0.0;
    KEL.typ.nkdate Event_Date_Max_;
    KEL.typ.int High_Frequency_Address_Count_ := 0;
    KEL.typ.float High_Frequency_Address_Percent_ := 0.0;
    KEL.typ.int Person_Count_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  SHARED __ST7210_Layout __ND185560__Project(__ST185448_Layout __PP185559) := TRANSFORM
    SELF.All_Deceased_Matched_Percent_ := __PP185559.All_Deceased_Matched_Person_Count_ / __PP185559.All_Person_Count_;
    SELF.All_Deceased_Person_Percent_ := __PP185559.All_Deceased_Person_Count_ / __PP185559.All_Person_Count_;
    SELF.All_High_Frequency_Address_Percent_ := __PP185559.All_High_Frequency_Address_Count_ / __PP185559.All_Address_Count_;
    SELF.Deceased_Person_Percent_ := __PP185559.Deceased_Person_Count_ / __PP185559.Person_Count_;
    SELF.Event_Date_Max_ := __PP185559.M_A_X___Event_Date_;
    SELF.High_Frequency_Address_Percent_ := __PP185559.High_Frequency_Address_Count_ / __PP185559.Address_Count_;
    SELF := __PP185559;
  END;
  EXPORT __ENH_Customer := PROJECT(__EE185446,__ND185560__Project(LEFT)) : PERSIST('~temp::KEL::KELOtto::Customer::Annotated',EXPIRE(30));
  SHARED __EE342798 := __ENH_Customer;
  SHARED IDX_Customer_UID_Layout := RECORD
    KEL.typ.uid UID;
    __EE342798.Customer_Id_;
    __EE342798.Industry_Type_;
    __EE342798.Person_Count_;
    __EE342798.All_Person_Count_;
    __EE342798.Deceased_Person_Count_;
    __EE342798.Deceased_Person_Percent_;
    __EE342798.All_Deceased_Person_Count_;
    __EE342798.All_Deceased_Person_Percent_;
    __EE342798.All_Deceased_Matched_Person_Count_;
    __EE342798.All_Deceased_Matched_Percent_;
    __EE342798.Address_Count_;
    __EE342798.All_Address_Count_;
    __EE342798.High_Frequency_Address_Count_;
    __EE342798.All_High_Frequency_Address_Count_;
    __EE342798.High_Frequency_Address_Percent_;
    __EE342798.All_High_Frequency_Address_Percent_;
    __EE342798.Event_Date_Max_;
    __EE342798.Date_First_Seen_;
    __EE342798.Date_Last_Seen_;
    __EE342798.__RecordCount;
  END;
  SHARED IDX_Customer_UID_Projected := PROJECT(__EE342798,TRANSFORM(IDX_Customer_UID_Layout,SELF.UID:=__T(LEFT.UID),SELF:=LEFT));
  EXPORT IDX_Customer_UID := INDEX(IDX_Customer_UID_Projected,{UID},{IDX_Customer_UID_Projected},'~key::KEL::KELOtto::Customer::UID');
  EXPORT IDX_Customer_UID_Build := BUILD(IDX_Customer_UID,OVERWRITE);
  EXPORT __ST342800_Layout := RECORDOF(IDX_Customer_UID);
  EXPORT IDX_Customer_UID_Wrapped := PROJECT(IDX_Customer_UID,TRANSFORM(__ST7210_Layout,SELF.UID := __CN(LEFT.UID),SELF:=LEFT));
  EXPORT BuildAll := PARALLEL(IDX_Customer_UID_Build);
END;
