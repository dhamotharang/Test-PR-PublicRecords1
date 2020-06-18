﻿//HPCC Systems KEL Compiler Version 0.11.6-2
IMPORT KEL011 AS KEL;
IMPORT B_Event_6,E_Address,E_Address_Event,E_Bank,E_Bank_Account,E_Customer,E_Drivers_License,E_Email,E_Event,E_Internet_Protocol,E_Person,E_Phone,E_Social_Security_Number FROM FraudgovKEL;
IMPORT * FROM KEL011.Null;
EXPORT B_Address_5 := MODULE
  SHARED VIRTUAL TYPEOF(E_Address.__Result) __E_Address := E_Address.__Result;
  SHARED VIRTUAL TYPEOF(E_Address_Event.__Result) __E_Address_Event := E_Address_Event.__Result;
  SHARED VIRTUAL TYPEOF(B_Event_6.__ENH_Event_6) __ENH_Event_6 := B_Event_6.__ENH_Event_6;
  SHARED __EE131815 := __E_Address;
  SHARED __EE131956 := __E_Address_Event;
  SHARED __EE133008 := __EE131956(__NN(__EE131956.Location_) AND __NN(__EE131956.Transaction_));
  SHARED __EE131958 := __ENH_Event_6;
  SHARED __EE132130 := __EE131958(__EE131958.T___In_Agency_Flag_ = 1 AND __EE131958.T9___Addr_Is_Kr_Flag_ = 1);
  __JC133026(E_Address_Event.Layout __EE133008, B_Event_6.__ST95508_Layout __EE132130) := __EEQP(__EE133008.Transaction_,__EE132130.UID);
  SHARED __EE133027 := JOIN(__EE133008,__EE132130,__JC133026(LEFT,RIGHT),TRANSFORM(E_Address_Event.Layout,SELF:=LEFT),SMART,KEEP(1));
  SHARED __ST132029_Layout := RECORD
    KEL.typ.ntyp(E_Address.Typ) UID;
    KEL.typ.ntyp(E_Customer.Typ) _r_Customer_;
    KEL.typ.ntyp(E_Address.Typ) Location_;
    KEL.typ.nkdate Event_Date_;
    KEL.typ.ntyp(E_Event.Typ) Transaction_;
    KEL.typ.ntyp(E_Event.Typ) U_I_D__1_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
  END;
  SHARED __ST132029_Layout __ND133037__Project(E_Address_Event.Layout __PP133028) := TRANSFORM
    SELF.UID := __PP133028.Location_;
    SELF.U_I_D__1_ := __PP133028.Transaction_;
    SELF := __PP133028;
  END;
  SHARED __EE133062 := PROJECT(__EE133027,__ND133037__Project(LEFT));
  SHARED __ST132055_Layout := RECORD
    KEL.typ.int C_O_U_N_T___Exp1_ := 0;
    KEL.typ.ntyp(E_Address.Typ) UID;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
  END;
  SHARED __EE133075 := PROJECT(__CLEANANDDO(__EE133062,TABLE(__EE133062,{KEL.typ.int C_O_U_N_T___Exp1_ := COUNT(GROUP),UID},UID,MERGE)),__ST132055_Layout);
  SHARED __ST132374_Layout := RECORD
    KEL.typ.nuid UID;
    KEL.typ.ntyp(E_Customer.Typ) _r_Customer_;
    KEL.typ.ndataset(E_Address.Source_Customers_Layout) Source_Customers_;
    KEL.typ.nbool _addresspobox_;
    KEL.typ.nbool _addresscmra_;
    KEL.typ.nstr Otto_Address_Id_;
    KEL.typ.nstr Primary_Range_;
    KEL.typ.nstr Predirectional_;
    KEL.typ.nstr Primary_Name_;
    KEL.typ.nstr Suffix_;
    KEL.typ.nstr Postdirectional_;
    KEL.typ.nstr Unit_Designation_;
    KEL.typ.nstr Secondary_Range_;
    KEL.typ.nstr Postal_City_;
    KEL.typ.nstr Vanity_City_;
    KEL.typ.nstr State_;
    KEL.typ.nstr Zip_;
    KEL.typ.nstr Zip4_;
    KEL.typ.nstr Carrier_Route_Number_;
    KEL.typ.nstr Carrier_Route_Sortation_At_Z_I_P_;
    KEL.typ.nint Line_Of_Travel_;
    KEL.typ.nstr Line_Of_Travel_Order_;
    KEL.typ.nint Delivery_Point_Barcode_;
    KEL.typ.nint Delivery_Point_Barcode_Check_Digit_;
    KEL.typ.nstr Type_Code_;
    KEL.typ.nint County_;
    KEL.typ.nfloat Latitude_;
    KEL.typ.nfloat Longitude_;
    KEL.typ.nint Metropolitan_Statistical_Area_;
    KEL.typ.nint Geo_Block_;
    KEL.typ.nstr Geo_Match_;
    KEL.typ.nstr A_C_E_Cleaner_Error_Code_;
    KEL.typ.nbool _is_Additional_;
    KEL.typ.int C_O_U_N_T___Exp1_ := 0;
    KEL.typ.ntyp(E_Address.Typ) U_I_D__1_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  __JC133081(E_Address.Layout __EE131815, __ST132055_Layout __EE133075) := __EEQP(__EE131815.UID,__EE133075.UID);
  __ST132374_Layout __JT133081(E_Address.Layout __l, __ST132055_Layout __r) := TRANSFORM
    SELF.U_I_D__1_ := __r.UID;
    SELF := __l;
    SELF := __r;
  END;
  SHARED __EE133082 := JOIN(__EE131815,__EE133075,__JC133081(LEFT,RIGHT),__JT133081(LEFT,RIGHT),LEFT OUTER,SMART);
  EXPORT __ST91093_Layout := RECORD
    KEL.typ.nuid UID;
    KEL.typ.ntyp(E_Customer.Typ) _r_Customer_;
    KEL.typ.ndataset(E_Address.Source_Customers_Layout) Source_Customers_;
    KEL.typ.nbool _addresspobox_;
    KEL.typ.nbool _addresscmra_;
    KEL.typ.nstr Otto_Address_Id_;
    KEL.typ.nstr Primary_Range_;
    KEL.typ.nstr Predirectional_;
    KEL.typ.nstr Primary_Name_;
    KEL.typ.nstr Suffix_;
    KEL.typ.nstr Postdirectional_;
    KEL.typ.nstr Unit_Designation_;
    KEL.typ.nstr Secondary_Range_;
    KEL.typ.nstr Postal_City_;
    KEL.typ.nstr Vanity_City_;
    KEL.typ.nstr State_;
    KEL.typ.nstr Zip_;
    KEL.typ.nstr Zip4_;
    KEL.typ.nstr Carrier_Route_Number_;
    KEL.typ.nstr Carrier_Route_Sortation_At_Z_I_P_;
    KEL.typ.nint Line_Of_Travel_;
    KEL.typ.nstr Line_Of_Travel_Order_;
    KEL.typ.nint Delivery_Point_Barcode_;
    KEL.typ.nint Delivery_Point_Barcode_Check_Digit_;
    KEL.typ.nstr Type_Code_;
    KEL.typ.nint County_;
    KEL.typ.nfloat Latitude_;
    KEL.typ.nfloat Longitude_;
    KEL.typ.nint Metropolitan_Statistical_Area_;
    KEL.typ.nint Geo_Block_;
    KEL.typ.nstr Geo_Match_;
    KEL.typ.nstr A_C_E_Cleaner_Error_Code_;
    KEL.typ.nbool _is_Additional_;
    KEL.typ.int Aot_Addr_Kr_Act_Cnt_Ev_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  SHARED __ST91093_Layout __ND133127__Project(__ST132374_Layout __PP133083) := TRANSFORM
    SELF.Aot_Addr_Kr_Act_Cnt_Ev_ := MIN(__PP133083.C_O_U_N_T___Exp1_,9999);
    SELF := __PP133083;
  END;
  EXPORT __ENH_Address_5 := PROJECT(__EE133082,__ND133127__Project(LEFT)) : PERSIST('~temp::KEL::FraudgovKEL::Address::Annotated_5',EXPIRE(7));
END;
