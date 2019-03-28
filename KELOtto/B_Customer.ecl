﻿//HPCC Systems KEL Compiler Version 0.11.0
IMPORT KEL011 AS KEL;
IMPORT B_Customer_1,E_Customer FROM KELOtto;
IMPORT * FROM KEL011.Null;
EXPORT B_Customer := MODULE
  SHARED VIRTUAL TYPEOF(B_Customer_1.__ENH_Customer_1) __ENH_Customer_1 := B_Customer_1.__ENH_Customer_1;
  SHARED __EE386387 := __ENH_Customer_1;
  EXPORT __ST17728_Layout := RECORD
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
  SHARED __ST17728_Layout __ND386501__Project(B_Customer_1.__ST19240_Layout __PP386390) := TRANSFORM
    SELF.All_Deceased_Matched_Percent_ := __PP386390.All_Deceased_Matched_Person_Count_ / __PP386390.All_Person_Count_;
    SELF.All_Deceased_Person_Percent_ := __PP386390.All_Deceased_Person_Count_ / __PP386390.All_Person_Count_;
    SELF.All_High_Frequency_Address_Percent_ := __PP386390.All_High_Frequency_Address_Count_ / __PP386390.All_Address_Count_;
    SELF.Deceased_Person_Percent_ := __PP386390.Deceased_Person_Count_ / __PP386390.Person_Count_;
    SELF.High_Frequency_Address_Percent_ := __PP386390.High_Frequency_Address_Count_ / __PP386390.Address_Count_;
    SELF := __PP386390;
  END;
  EXPORT __ENH_Customer := PROJECT(__EE386387,__ND386501__Project(LEFT)) : PERSIST('~temp::KEL::KELOtto::Customer::Annotated',EXPIRE(30));
  SHARED __EE824446 := __ENH_Customer;
  SHARED IDX_Customer_UID_Layout := RECORD
    KEL.typ.uid UID;
    __EE824446.Customer_Id_;
    __EE824446.Industry_Type_;
    __EE824446.Person_Count_;
    __EE824446.All_Person_Count_;
    __EE824446.Deceased_Person_Count_;
    __EE824446.Deceased_Person_Percent_;
    __EE824446.All_Deceased_Person_Count_;
    __EE824446.All_Deceased_Person_Percent_;
    __EE824446.All_Deceased_Matched_Person_Count_;
    __EE824446.All_Deceased_Matched_Percent_;
    __EE824446.Address_Count_;
    __EE824446.All_Address_Count_;
    __EE824446.High_Frequency_Address_Count_;
    __EE824446.All_High_Frequency_Address_Count_;
    __EE824446.High_Frequency_Address_Percent_;
    __EE824446.All_High_Frequency_Address_Percent_;
    __EE824446.Event_Date_Max_;
    __EE824446.Date_First_Seen_;
    __EE824446.Date_Last_Seen_;
    __EE824446.__RecordCount;
  END;
  SHARED IDX_Customer_UID_Projected := PROJECT(__EE824446,TRANSFORM(IDX_Customer_UID_Layout,SELF.UID:=__T(LEFT.UID),SELF:=LEFT));
  EXPORT IDX_Customer_UID := INDEX(IDX_Customer_UID_Projected,{UID},{IDX_Customer_UID_Projected},'~key::KEL::KELOtto::Customer::UID');
  EXPORT IDX_Customer_UID_Build := BUILD(IDX_Customer_UID,OVERWRITE);
  EXPORT __ST824448_Layout := RECORDOF(IDX_Customer_UID);
  EXPORT IDX_Customer_UID_Wrapped := PROJECT(IDX_Customer_UID,TRANSFORM(__ST17728_Layout,SELF.UID := __CN(LEFT.UID),SELF:=LEFT));
  EXPORT BuildAll := PARALLEL(IDX_Customer_UID_Build);
END;
