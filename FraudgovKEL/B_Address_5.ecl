﻿//HPCC Systems KEL Compiler Version 0.11.6-2
IMPORT KEL011 AS KEL;
IMPORT B_Event_6,E_Address,E_Address_Event,E_Bank,E_Bank_Account,E_Customer,E_Drivers_License,E_Email,E_Event,E_Internet_Protocol,E_Person,E_Phone,E_Social_Security_Number FROM FraudgovKEL;
IMPORT * FROM KEL011.Null;
EXPORT B_Address_5 := MODULE
  SHARED VIRTUAL TYPEOF(E_Address.__Result) __E_Address := E_Address.__Result;
  SHARED VIRTUAL TYPEOF(E_Address_Event.__Result) __E_Address_Event := E_Address_Event.__Result;
  SHARED VIRTUAL TYPEOF(B_Event_6.__ENH_Event_6) __ENH_Event_6 := B_Event_6.__ENH_Event_6;
  SHARED __EE135803 := __E_Address;
  SHARED __EE135944 := __E_Address_Event;
  SHARED __EE136996 := __EE135944(__NN(__EE135944.Location_) AND __NN(__EE135944.Transaction_));
  SHARED __EE135946 := __ENH_Event_6;
  SHARED __EE136118 := __EE135946(__EE135946.T___In_Agency_Flag_ = 1 AND __EE135946.T9___Addr_Is_Kr_Flag_ = 1);
  __JC137014(E_Address_Event.Layout __EE136996, B_Event_6.__ST98838_Layout __EE136118) := __EEQP(__EE136996.Transaction_,__EE136118.UID);
  SHARED __EE137015 := JOIN(__EE136996,__EE136118,__JC137014(LEFT,RIGHT),TRANSFORM(E_Address_Event.Layout,SELF:=LEFT),SMART,KEEP(1));
  SHARED __ST136017_Layout := RECORD
    KEL.typ.ntyp(E_Address.Typ) UID;
    KEL.typ.ntyp(E_Customer.Typ) _r_Customer_;
    KEL.typ.ntyp(E_Address.Typ) Location_;
    KEL.typ.nkdate Event_Date_;
    KEL.typ.ntyp(E_Event.Typ) Transaction_;
    KEL.typ.ntyp(E_Event.Typ) U_I_D__1_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
  END;
  SHARED __ST136017_Layout __ND137025__Project(E_Address_Event.Layout __PP137016) := TRANSFORM
    SELF.UID := __PP137016.Location_;
    SELF.U_I_D__1_ := __PP137016.Transaction_;
    SELF := __PP137016;
  END;
  SHARED __EE137050 := PROJECT(__EE137015,__ND137025__Project(LEFT));
  SHARED __ST136043_Layout := RECORD
    KEL.typ.int C_O_U_N_T___Exp1_ := 0;
    KEL.typ.ntyp(E_Address.Typ) UID;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
  END;
  SHARED __EE137063 := PROJECT(__CLEANANDDO(__EE137050,TABLE(__EE137050,{KEL.typ.int C_O_U_N_T___Exp1_ := COUNT(GROUP),UID},UID,MERGE)),__ST136043_Layout);
  SHARED __ST136362_Layout := RECORD
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
  __JC137069(E_Address.Layout __EE135803, __ST136043_Layout __EE137063) := __EEQP(__EE135803.UID,__EE137063.UID);
  __ST136362_Layout __JT137069(E_Address.Layout __l, __ST136043_Layout __r) := TRANSFORM
    SELF.U_I_D__1_ := __r.UID;
    SELF := __l;
    SELF := __r;
  END;
  SHARED __EE137070 := JOIN(__EE135803,__EE137063,__JC137069(LEFT,RIGHT),__JT137069(LEFT,RIGHT),LEFT OUTER,SMART);
  EXPORT __ST94402_Layout := RECORD
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
  SHARED __ST94402_Layout __ND137115__Project(__ST136362_Layout __PP137071) := TRANSFORM
    SELF.Aot_Addr_Kr_Act_Cnt_Ev_ := MIN(__PP137071.C_O_U_N_T___Exp1_,9999);
    SELF := __PP137071;
  END;
  EXPORT __ENH_Address_5 := PROJECT(__EE137070,__ND137115__Project(LEFT)) : PERSIST('~temp::KEL::FraudgovKEL::Address::Annotated_5',EXPIRE(7));
END;
