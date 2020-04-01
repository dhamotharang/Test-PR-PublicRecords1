﻿//HPCC Systems KEL Compiler Version 0.11.6-2
IMPORT KEL011 AS KEL;
IMPORT B_Address_2,B_Customer_2,B_Customer_3,B_Customer_4,B_Person_2,E_Address,E_Customer,E_Person,E_Person_Address FROM FraudgovKEL;
IMPORT * FROM KEL011.Null;
EXPORT B_Customer_1 := MODULE
  SHARED VIRTUAL TYPEOF(B_Address_2.__ENH_Address_2) __ENH_Address_2 := B_Address_2.__ENH_Address_2;
  SHARED VIRTUAL TYPEOF(B_Customer_2.__ENH_Customer_2) __ENH_Customer_2 := B_Customer_2.__ENH_Customer_2;
  SHARED VIRTUAL TYPEOF(B_Person_2.__ENH_Person_2) __ENH_Person_2 := B_Person_2.__ENH_Person_2;
  SHARED VIRTUAL TYPEOF(E_Person_Address.__Result) __E_Person_Address := E_Person_Address.__Result;
  SHARED __EE302805 := __ENH_Customer_2;
  SHARED __EE309378 := __E_Person_Address;
  SHARED __EE311215 := __EE309378;
  SHARED __EE311243 := __EE311215(__NN(__EE311215._r_Customer_) AND __NN(__EE311215.Subject_));
  SHARED __EE309422 := __ENH_Person_2;
  SHARED __EE311218 := __EE309422;
  SHARED __EE311251 := __EE311218(__EE311218.In_Customer_Population_ = 1);
  __JC311259(E_Person_Address.Layout __EE311243, B_Person_2.__ST39212_Layout __EE311251) := __EEQP(__EE311243.Subject_,__EE311251.UID);
  SHARED __EE311260 := JOIN(__EE311243,__EE311251,__JC311259(LEFT,RIGHT),TRANSFORM(E_Person_Address.Layout,SELF:=LEFT),SMART,KEEP(1));
  SHARED __ST306175_Layout := RECORD
    KEL.typ.ntyp(E_Customer.Typ) UID;
    KEL.typ.ntyp(E_Person.Typ) Subject_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
  END;
  SHARED __EE311281 := PROJECT(TABLE(PROJECT(__EE311260,TRANSFORM(__ST306175_Layout,SELF.UID := LEFT._r_Customer_,SELF := LEFT)),{KEL.typ.epoch Date_First_Seen_ := KEL.era.SimpleRoll(GROUP,Date_First_Seen_,MIN,TRUE),KEL.typ.epoch Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Date_Last_Seen_,MAX,FALSE),UID,Subject_},UID,Subject_,MERGE),__ST306175_Layout);
  SHARED __ST306193_Layout := RECORD
    KEL.typ.int C_O_U_N_T___Person_Address_ := 0;
    KEL.typ.ntyp(E_Customer.Typ) UID;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
  END;
  SHARED __EE311294 := PROJECT(__CLEANANDDO(__EE311281,TABLE(__EE311281,{KEL.typ.int C_O_U_N_T___Person_Address_ := COUNT(GROUP),UID},UID,MERGE)),__ST306193_Layout);
  SHARED __ST306947_Layout := RECORD
    KEL.typ.nuid UID;
    KEL.typ.nint Customer_Id_;
    KEL.typ.nint Industry_Type_;
    KEL.typ.ndataset(E_Customer.States_Layout) States_;
    KEL.typ.nkdate Event_Date_Max_;
    KEL.typ.nstr Jurisdiction_State_;
    B_Customer_4.__NS96611_Layout Jurisdiction_State_Top_;
    KEL.typ.int C_O_U_N_T___Person_Address_ := 0;
    KEL.typ.ntyp(E_Customer.Typ) U_I_D__1_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  __JC311300(B_Customer_3.__ST39603_Layout __EE302805, __ST306193_Layout __EE311294) := __EEQP(__EE302805.UID,__EE311294.UID);
  __ST306947_Layout __JT311300(B_Customer_3.__ST39603_Layout __l, __ST306193_Layout __r) := TRANSFORM
    SELF.U_I_D__1_ := __r.UID;
    SELF := __l;
    SELF := __r;
  END;
  SHARED __EE311301 := JOIN(__EE302805,__EE311294,__JC311300(LEFT,RIGHT),__JT311300(LEFT,RIGHT),LEFT OUTER,SMART);
  SHARED __EE311323 := __EE311243;
  SHARED __EE311212 := __EE309422;
  SHARED __EE311335 := __EE311212(__EE311212.In_Customer_Population_ = 1 AND __EE311212.Deceased_ = 1);
  __JC311343(E_Person_Address.Layout __EE311323, B_Person_2.__ST39212_Layout __EE311335) := __EEQP(__EE311323.Subject_,__EE311335.UID);
  SHARED __EE311344 := JOIN(__EE311323,__EE311335,__JC311343(LEFT,RIGHT),TRANSFORM(E_Person_Address.Layout,SELF:=LEFT),SMART,KEEP(1));
  SHARED __ST305881_Layout := RECORD
    KEL.typ.ntyp(E_Customer.Typ) UID;
    KEL.typ.ntyp(E_Person.Typ) Subject_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
  END;
  SHARED __EE311365 := PROJECT(TABLE(PROJECT(__EE311344,TRANSFORM(__ST305881_Layout,SELF.UID := LEFT._r_Customer_,SELF := LEFT)),{KEL.typ.epoch Date_First_Seen_ := KEL.era.SimpleRoll(GROUP,Date_First_Seen_,MIN,TRUE),KEL.typ.epoch Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Date_Last_Seen_,MAX,FALSE),UID,Subject_},UID,Subject_,MERGE),__ST305881_Layout);
  SHARED __ST305899_Layout := RECORD
    KEL.typ.int C_O_U_N_T___Person_Address_ := 0;
    KEL.typ.ntyp(E_Customer.Typ) UID;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
  END;
  SHARED __EE311378 := PROJECT(__CLEANANDDO(__EE311365,TABLE(__EE311365,{KEL.typ.int C_O_U_N_T___Person_Address_ := COUNT(GROUP),UID},UID,MERGE)),__ST305899_Layout);
  SHARED __ST307082_Layout := RECORD
    KEL.typ.nuid UID;
    KEL.typ.nint Customer_Id_;
    KEL.typ.nint Industry_Type_;
    KEL.typ.ndataset(E_Customer.States_Layout) States_;
    KEL.typ.nkdate Event_Date_Max_;
    KEL.typ.nstr Jurisdiction_State_;
    B_Customer_4.__NS96611_Layout Jurisdiction_State_Top_;
    KEL.typ.int C_O_U_N_T___Person_Address_ := 0;
    KEL.typ.ntyp(E_Customer.Typ) U_I_D__1_;
    KEL.typ.int C_O_U_N_T___Person_Address__1_ := 0;
    KEL.typ.ntyp(E_Customer.Typ) U_I_D__2_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  __JC311386(__ST306947_Layout __EE311301, __ST305899_Layout __EE311378) := __EEQP(__EE311301.UID,__EE311378.UID);
  __ST307082_Layout __JT311386(__ST306947_Layout __l, __ST305899_Layout __r) := TRANSFORM
    SELF.C_O_U_N_T___Person_Address__1_ := __r.C_O_U_N_T___Person_Address_;
    SELF.U_I_D__2_ := __r.UID;
    SELF := __l;
    SELF := __r;
  END;
  SHARED __EE311387 := JOIN(__EE311301,__EE311378,__JC311386(LEFT,RIGHT),__JT311386(LEFT,RIGHT),LEFT OUTER,SMART);
  SHARED __EE311185 := __EE309378;
  SHARED __EE311418 := __EE311185(__NN(__EE311185._r_Customer_));
  SHARED __EE311421 := __EE311418;
  SHARED __ST305575_Layout := RECORD
    KEL.typ.ntyp(E_Customer.Typ) UID;
    KEL.typ.ntyp(E_Person.Typ) Subject_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
  END;
  SHARED __EE311435 := PROJECT(TABLE(PROJECT(__EE311421,TRANSFORM(__ST305575_Layout,SELF.UID := LEFT._r_Customer_,SELF := LEFT)),{KEL.typ.epoch Date_First_Seen_ := KEL.era.SimpleRoll(GROUP,Date_First_Seen_,MIN,TRUE),KEL.typ.epoch Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Date_Last_Seen_,MAX,FALSE),UID,Subject_},UID,Subject_,MERGE),__ST305575_Layout);
  SHARED __ST305593_Layout := RECORD
    KEL.typ.int C_O_U_N_T___Person_Address_ := 0;
    KEL.typ.ntyp(E_Customer.Typ) UID;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
  END;
  SHARED __EE311448 := PROJECT(__CLEANANDDO(__EE311435,TABLE(__EE311435,{KEL.typ.int C_O_U_N_T___Person_Address_ := COUNT(GROUP),UID},UID,MERGE)),__ST305593_Layout);
  SHARED __ST307218_Layout := RECORD
    KEL.typ.nuid UID;
    KEL.typ.nint Customer_Id_;
    KEL.typ.nint Industry_Type_;
    KEL.typ.ndataset(E_Customer.States_Layout) States_;
    KEL.typ.nkdate Event_Date_Max_;
    KEL.typ.nstr Jurisdiction_State_;
    B_Customer_4.__NS96611_Layout Jurisdiction_State_Top_;
    KEL.typ.int C_O_U_N_T___Person_Address_ := 0;
    KEL.typ.ntyp(E_Customer.Typ) U_I_D__1_;
    KEL.typ.int C_O_U_N_T___Person_Address__1_ := 0;
    KEL.typ.ntyp(E_Customer.Typ) U_I_D__2_;
    KEL.typ.int C_O_U_N_T___Person_Address__2_ := 0;
    KEL.typ.ntyp(E_Customer.Typ) U_I_D__3_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  __JC311456(__ST307082_Layout __EE311387, __ST305593_Layout __EE311448) := __EEQP(__EE311387.UID,__EE311448.UID);
  __ST307218_Layout __JT311456(__ST307082_Layout __l, __ST305593_Layout __r) := TRANSFORM
    SELF.C_O_U_N_T___Person_Address__2_ := __r.C_O_U_N_T___Person_Address_;
    SELF.U_I_D__3_ := __r.UID;
    SELF := __l;
    SELF := __r;
  END;
  SHARED __EE311457 := JOIN(__EE311387,__EE311448,__JC311456(LEFT,RIGHT),__JT311456(LEFT,RIGHT),LEFT OUTER,HASH);
  SHARED __EE309380 := __ENH_Address_2;
  SHARED __EE311197 := __EE309380;
  SHARED __EE311004 := __EE309378(__NN(__EE309378._r_Customer_) AND __NN(__EE309378.Location_));
  SHARED __ST312193_Layout := RECORD
    KEL.typ.ntyp(E_Customer.Typ) _r_Customer_;
    KEL.typ.ntyp(E_Address.Typ) Location_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  SHARED __EE312197 := PROJECT(TABLE(PROJECT(__EE311004,__ST312193_Layout),{KEL.typ.int __RecordCount := SUM(GROUP,__RecordCount),KEL.typ.epoch Date_First_Seen_ := KEL.era.SimpleRoll(GROUP,Date_First_Seen_,MIN,TRUE),KEL.typ.epoch Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Date_Last_Seen_,MAX,FALSE),_r_Customer_,Location_},_r_Customer_,Location_,MERGE),__ST312193_Layout);
  SHARED __ST312205_Layout := RECORD
    KEL.typ.ntyp(E_Customer.Typ) _r_Customer__1_;
    KEL.typ.ntyp(E_Address.Typ) Location_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
  END;
  SHARED __EE312209 := PROJECT(__EE312197,TRANSFORM(__ST312205_Layout,SELF._r_Customer__1_ := LEFT._r_Customer_,SELF := LEFT));
  SHARED __ST312264_Layout := RECORD
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
    KEL.typ.int All_High_Risk_Death_Prior_To_All_Events_Person_Count_ := 0;
    KEL.typ.int High_Frequency_Flag_ := 0;
    KEL.typ.int High_Risk_Death_Prior_To_All_Events_Person_Count_ := 0;
    KEL.typ.int Identity_Count_ := 0;
    KEL.typ.int In_Customer_Population_ := 0;
    KEL.typ.int Kr_Event_After_Last_Known_Risk_Count_ := 0;
    KEL.typ.nkdate Kr_Last_Event_Date_;
    KEL.typ.ntyp(E_Customer.Typ) _r_Customer__1_;
    KEL.typ.ntyp(E_Address.Typ) Location_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  __JC312214(B_Address_2.__ST37495_Layout __EE311197, __ST312205_Layout __EE312209) := __EEQP(__EE312209.Location_,__EE311197.UID);
  __ST312264_Layout __JT312214(B_Address_2.__ST37495_Layout __l, __ST312205_Layout __r) := TRANSFORM
    SELF := __l;
    SELF := __r;
  END;
  SHARED __EE312262 := JOIN(__EE312209,__EE311197,__JC312214(RIGHT,LEFT),__JT312214(RIGHT,LEFT),INNER,HASH);
  SHARED __ST305108_Layout := RECORD
    KEL.typ.ntyp(E_Customer.Typ) UID;
    KEL.typ.nuid U_I_D__1_;
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
    KEL.typ.int All_High_Risk_Death_Prior_To_All_Events_Person_Count_ := 0;
    KEL.typ.int High_Frequency_Flag_ := 0;
    KEL.typ.int High_Risk_Death_Prior_To_All_Events_Person_Count_ := 0;
    KEL.typ.int Identity_Count_ := 0;
    KEL.typ.int In_Customer_Population_ := 0;
    KEL.typ.int Kr_Event_After_Last_Known_Risk_Count_ := 0;
    KEL.typ.nkdate Kr_Last_Event_Date_;
    KEL.typ.ntyp(E_Address.Typ) Location_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
  END;
  SHARED __ST305108_Layout __ND312314__Project(__ST312264_Layout __PP312263) := TRANSFORM
    SELF.UID := __PP312263._r_Customer__1_;
    SELF.U_I_D__1_ := __PP312263.UID;
    SELF := __PP312263;
  END;
  SHARED __EE312487 := PROJECT(__EE312262,__ND312314__Project(LEFT));
  SHARED __ST305216_Layout := RECORD
    KEL.typ.ntyp(E_Customer.Typ) UID;
    KEL.typ.int High_Frequency_Flag_ := 0;
    KEL.typ.nint Exp1_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
  END;
  SHARED __ST305216_Layout __ND312956__Project(__ST305108_Layout __PP312488) := TRANSFORM
    SELF.Exp1_ := IF(__PP312488.In_Customer_Population_ = 1,__ECAST(KEL.typ.nint,__CN(__PP312488.High_Frequency_Flag_)),__ECAST(KEL.typ.nint,__N(KEL.typ.int)));
    SELF := __PP312488;
  END;
  SHARED __EE312961 := PROJECT(__EE312487,__ND312956__Project(LEFT));
  SHARED __ST305236_Layout := RECORD
    KEL.typ.int S_U_M___High_Frequency_Flag_ := 0;
    KEL.typ.int S_U_M___High_Frequency_Flag__1_ := 0;
    KEL.typ.ntyp(E_Customer.Typ) UID;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
  END;
  SHARED __EE312982 := PROJECT(__CLEANANDDO(__EE312961,TABLE(__EE312961,{KEL.typ.int S_U_M___High_Frequency_Flag_ := SUM(GROUP,__EE312961.High_Frequency_Flag_),KEL.typ.int S_U_M___High_Frequency_Flag__1_ := KEL.Aggregates.SumNG(__EE312961.Exp1_),UID},UID,MERGE)),__ST305236_Layout);
  SHARED __ST307353_Layout := RECORD
    KEL.typ.nuid UID;
    KEL.typ.nint Customer_Id_;
    KEL.typ.nint Industry_Type_;
    KEL.typ.ndataset(E_Customer.States_Layout) States_;
    KEL.typ.nkdate Event_Date_Max_;
    KEL.typ.nstr Jurisdiction_State_;
    B_Customer_4.__NS96611_Layout Jurisdiction_State_Top_;
    KEL.typ.int C_O_U_N_T___Person_Address_ := 0;
    KEL.typ.ntyp(E_Customer.Typ) U_I_D__1_;
    KEL.typ.int C_O_U_N_T___Person_Address__1_ := 0;
    KEL.typ.ntyp(E_Customer.Typ) U_I_D__2_;
    KEL.typ.int C_O_U_N_T___Person_Address__2_ := 0;
    KEL.typ.ntyp(E_Customer.Typ) U_I_D__3_;
    KEL.typ.int S_U_M___High_Frequency_Flag_ := 0;
    KEL.typ.int S_U_M___High_Frequency_Flag__1_ := 0;
    KEL.typ.ntyp(E_Customer.Typ) U_I_D__4_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  __JC312988(__ST307218_Layout __EE311457, __ST305236_Layout __EE312982) := __EEQP(__EE311457.UID,__EE312982.UID);
  __ST307353_Layout __JT312988(__ST307218_Layout __l, __ST305236_Layout __r) := TRANSFORM
    SELF.U_I_D__4_ := __r.UID;
    SELF := __l;
    SELF := __r;
  END;
  SHARED __EE313014 := JOIN(__EE311457,__EE312982,__JC312988(LEFT,RIGHT),__JT312988(LEFT,RIGHT),LEFT OUTER,HASH);
  SHARED __EE311802 := __EE311243;
  SHARED __EE311194 := __EE309422;
  SHARED __EE311810 := __EE311194(__EE311194.Deceased_ = 1);
  __JC311818(E_Person_Address.Layout __EE311802, B_Person_2.__ST39212_Layout __EE311810) := __EEQP(__EE311802.Subject_,__EE311810.UID);
  SHARED __EE311819 := JOIN(__EE311802,__EE311810,__JC311818(LEFT,RIGHT),TRANSFORM(E_Person_Address.Layout,SELF:=LEFT),HASH,KEEP(1));
  SHARED __ST304220_Layout := RECORD
    KEL.typ.ntyp(E_Customer.Typ) UID;
    KEL.typ.ntyp(E_Person.Typ) Subject_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
  END;
  SHARED __EE311840 := PROJECT(TABLE(PROJECT(__EE311819,TRANSFORM(__ST304220_Layout,SELF.UID := LEFT._r_Customer_,SELF := LEFT)),{KEL.typ.epoch Date_First_Seen_ := KEL.era.SimpleRoll(GROUP,Date_First_Seen_,MIN,TRUE),KEL.typ.epoch Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Date_Last_Seen_,MAX,FALSE),UID,Subject_},UID,Subject_,MERGE),__ST304220_Layout);
  SHARED __ST304238_Layout := RECORD
    KEL.typ.int C_O_U_N_T___Person_Address_ := 0;
    KEL.typ.ntyp(E_Customer.Typ) UID;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
  END;
  SHARED __EE311853 := PROJECT(__CLEANANDDO(__EE311840,TABLE(__EE311840,{KEL.typ.int C_O_U_N_T___Person_Address_ := COUNT(GROUP),UID},UID,MERGE)),__ST304238_Layout);
  SHARED __ST307488_Layout := RECORD
    KEL.typ.nuid UID;
    KEL.typ.nint Customer_Id_;
    KEL.typ.nint Industry_Type_;
    KEL.typ.ndataset(E_Customer.States_Layout) States_;
    KEL.typ.nkdate Event_Date_Max_;
    KEL.typ.nstr Jurisdiction_State_;
    B_Customer_4.__NS96611_Layout Jurisdiction_State_Top_;
    KEL.typ.int C_O_U_N_T___Person_Address_ := 0;
    KEL.typ.ntyp(E_Customer.Typ) U_I_D__1_;
    KEL.typ.int C_O_U_N_T___Person_Address__1_ := 0;
    KEL.typ.ntyp(E_Customer.Typ) U_I_D__2_;
    KEL.typ.int C_O_U_N_T___Person_Address__2_ := 0;
    KEL.typ.ntyp(E_Customer.Typ) U_I_D__3_;
    KEL.typ.int S_U_M___High_Frequency_Flag_ := 0;
    KEL.typ.int S_U_M___High_Frequency_Flag__1_ := 0;
    KEL.typ.ntyp(E_Customer.Typ) U_I_D__4_;
    KEL.typ.int C_O_U_N_T___Person_Address__3_ := 0;
    KEL.typ.ntyp(E_Customer.Typ) U_I_D__5_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  __JC313020(__ST307353_Layout __EE313014, __ST304238_Layout __EE311853) := __EEQP(__EE313014.UID,__EE311853.UID);
  __ST307488_Layout __JT313020(__ST307353_Layout __l, __ST304238_Layout __r) := TRANSFORM
    SELF.C_O_U_N_T___Person_Address__3_ := __r.C_O_U_N_T___Person_Address_;
    SELF.U_I_D__5_ := __r.UID;
    SELF := __l;
    SELF := __r;
  END;
  SHARED __EE313050 := JOIN(__EE313014,__EE311853,__JC313020(LEFT,RIGHT),__JT313020(LEFT,RIGHT),LEFT OUTER,HASH);
  SHARED __EE311895 := __EE311243;
  SHARED __EE309430 := __EE309422(__EE309422.Deceased_Match_ = 1);
  __JC311901(E_Person_Address.Layout __EE311895, B_Person_2.__ST39212_Layout __EE309430) := __EEQP(__EE311895.Subject_,__EE309430.UID);
  SHARED __EE311902 := JOIN(__EE311895,__EE309430,__JC311901(LEFT,RIGHT),TRANSFORM(E_Person_Address.Layout,SELF:=LEFT),SMART,KEEP(1));
  SHARED __ST303844_Layout := RECORD
    KEL.typ.ntyp(E_Customer.Typ) UID;
    KEL.typ.ntyp(E_Customer.Typ) _r_Customer_;
    KEL.typ.ntyp(E_Person.Typ) Subject_;
    KEL.typ.ntyp(E_Address.Typ) Location_;
    KEL.typ.ndataset(E_Person_Address.Event_Dates_Layout) Event_Dates_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
  END;
  SHARED __EE311939 := PROJECT(__EE311902,TRANSFORM(__ST303844_Layout,SELF.UID := LEFT._r_Customer_,SELF := LEFT));
  SHARED __ST303873_Layout := RECORD
    KEL.typ.int C_O_U_N_T___Person_Address_ := 0;
    KEL.typ.ntyp(E_Customer.Typ) UID;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
  END;
  SHARED __EE311952 := PROJECT(__CLEANANDDO(__EE311939,TABLE(__EE311939,{KEL.typ.int C_O_U_N_T___Person_Address_ := COUNT(GROUP),UID},UID,MERGE)),__ST303873_Layout);
  SHARED __ST307624_Layout := RECORD
    KEL.typ.nuid UID;
    KEL.typ.nint Customer_Id_;
    KEL.typ.nint Industry_Type_;
    KEL.typ.ndataset(E_Customer.States_Layout) States_;
    KEL.typ.nkdate Event_Date_Max_;
    KEL.typ.nstr Jurisdiction_State_;
    B_Customer_4.__NS96611_Layout Jurisdiction_State_Top_;
    KEL.typ.int C_O_U_N_T___Person_Address_ := 0;
    KEL.typ.ntyp(E_Customer.Typ) U_I_D__1_;
    KEL.typ.int C_O_U_N_T___Person_Address__1_ := 0;
    KEL.typ.ntyp(E_Customer.Typ) U_I_D__2_;
    KEL.typ.int C_O_U_N_T___Person_Address__2_ := 0;
    KEL.typ.ntyp(E_Customer.Typ) U_I_D__3_;
    KEL.typ.int S_U_M___High_Frequency_Flag_ := 0;
    KEL.typ.int S_U_M___High_Frequency_Flag__1_ := 0;
    KEL.typ.ntyp(E_Customer.Typ) U_I_D__4_;
    KEL.typ.int C_O_U_N_T___Person_Address__3_ := 0;
    KEL.typ.ntyp(E_Customer.Typ) U_I_D__5_;
    KEL.typ.int C_O_U_N_T___Person_Address__4_ := 0;
    KEL.typ.ntyp(E_Customer.Typ) U_I_D__6_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  __JC313056(__ST307488_Layout __EE313050, __ST303873_Layout __EE311952) := __EEQP(__EE313050.UID,__EE311952.UID);
  __ST307624_Layout __JT313056(__ST307488_Layout __l, __ST303873_Layout __r) := TRANSFORM
    SELF.C_O_U_N_T___Person_Address__4_ := __r.C_O_U_N_T___Person_Address_;
    SELF.U_I_D__6_ := __r.UID;
    SELF := __l;
    SELF := __r;
  END;
  SHARED __EE313088 := JOIN(__EE313050,__EE311952,__JC313056(LEFT,RIGHT),__JT313056(LEFT,RIGHT),LEFT OUTER,SMART);
  SHARED __ST303520_Layout := RECORD
    KEL.typ.ntyp(E_Customer.Typ) UID;
    KEL.typ.ntyp(E_Address.Typ) Location_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
  END;
  SHARED __EE312007 := PROJECT(TABLE(PROJECT(__EE311418,TRANSFORM(__ST303520_Layout,SELF.UID := LEFT._r_Customer_,SELF := LEFT)),{KEL.typ.epoch Date_First_Seen_ := KEL.era.SimpleRoll(GROUP,Date_First_Seen_,MIN,TRUE),KEL.typ.epoch Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Date_Last_Seen_,MAX,FALSE),UID,Location_},UID,Location_,MERGE),__ST303520_Layout);
  SHARED __ST303538_Layout := RECORD
    KEL.typ.int C_O_U_N_T___Person_Address_ := 0;
    KEL.typ.ntyp(E_Customer.Typ) UID;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
  END;
  SHARED __EE312020 := PROJECT(__CLEANANDDO(__EE312007,TABLE(__EE312007,{KEL.typ.int C_O_U_N_T___Person_Address_ := COUNT(GROUP),UID},UID,MERGE)),__ST303538_Layout);
  SHARED __ST307759_Layout := RECORD
    KEL.typ.nuid UID;
    KEL.typ.nint Customer_Id_;
    KEL.typ.nint Industry_Type_;
    KEL.typ.ndataset(E_Customer.States_Layout) States_;
    KEL.typ.nkdate Event_Date_Max_;
    KEL.typ.nstr Jurisdiction_State_;
    B_Customer_4.__NS96611_Layout Jurisdiction_State_Top_;
    KEL.typ.int C_O_U_N_T___Person_Address_ := 0;
    KEL.typ.ntyp(E_Customer.Typ) U_I_D__1_;
    KEL.typ.int C_O_U_N_T___Person_Address__1_ := 0;
    KEL.typ.ntyp(E_Customer.Typ) U_I_D__2_;
    KEL.typ.int C_O_U_N_T___Person_Address__2_ := 0;
    KEL.typ.ntyp(E_Customer.Typ) U_I_D__3_;
    KEL.typ.int S_U_M___High_Frequency_Flag_ := 0;
    KEL.typ.int S_U_M___High_Frequency_Flag__1_ := 0;
    KEL.typ.ntyp(E_Customer.Typ) U_I_D__4_;
    KEL.typ.int C_O_U_N_T___Person_Address__3_ := 0;
    KEL.typ.ntyp(E_Customer.Typ) U_I_D__5_;
    KEL.typ.int C_O_U_N_T___Person_Address__4_ := 0;
    KEL.typ.ntyp(E_Customer.Typ) U_I_D__6_;
    KEL.typ.int C_O_U_N_T___Person_Address__5_ := 0;
    KEL.typ.ntyp(E_Customer.Typ) U_I_D__7_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  __JC313094(__ST307624_Layout __EE313088, __ST303538_Layout __EE312020) := __EEQP(__EE313088.UID,__EE312020.UID);
  __ST307759_Layout __JT313094(__ST307624_Layout __l, __ST303538_Layout __r) := TRANSFORM
    SELF.C_O_U_N_T___Person_Address__5_ := __r.C_O_U_N_T___Person_Address_;
    SELF.U_I_D__7_ := __r.UID;
    SELF := __l;
    SELF := __r;
  END;
  SHARED __EE313128 := JOIN(__EE313088,__EE312020,__JC313094(LEFT,RIGHT),__JT313094(LEFT,RIGHT),LEFT OUTER,HASH);
  SHARED __EE309388 := __EE309380(__EE309380.In_Customer_Population_ = 1);
  __JC311022(E_Person_Address.Layout __EE311004, B_Address_2.__ST37495_Layout __EE309388) := __EEQP(__EE311004.Location_,__EE309388.UID);
  SHARED __EE311023 := JOIN(__EE311004,__EE309388,__JC311022(LEFT,RIGHT),TRANSFORM(E_Person_Address.Layout,SELF:=LEFT),SMART,KEEP(1));
  SHARED __ST303180_Layout := RECORD
    KEL.typ.ntyp(E_Customer.Typ) UID;
    KEL.typ.ntyp(E_Address.Typ) Location_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
  END;
  SHARED __EE311044 := PROJECT(TABLE(PROJECT(__EE311023,TRANSFORM(__ST303180_Layout,SELF.UID := LEFT._r_Customer_,SELF := LEFT)),{KEL.typ.epoch Date_First_Seen_ := KEL.era.SimpleRoll(GROUP,Date_First_Seen_,MIN,TRUE),KEL.typ.epoch Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Date_Last_Seen_,MAX,FALSE),UID,Location_},UID,Location_,MERGE),__ST303180_Layout);
  SHARED __ST303198_Layout := RECORD
    KEL.typ.int C_O_U_N_T___Person_Address_ := 0;
    KEL.typ.ntyp(E_Customer.Typ) UID;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
  END;
  SHARED __EE311057 := PROJECT(__CLEANANDDO(__EE311044,TABLE(__EE311044,{KEL.typ.int C_O_U_N_T___Person_Address_ := COUNT(GROUP),UID},UID,MERGE)),__ST303198_Layout);
  SHARED __ST307893_Layout := RECORD
    KEL.typ.nuid UID;
    KEL.typ.nint Customer_Id_;
    KEL.typ.nint Industry_Type_;
    KEL.typ.ndataset(E_Customer.States_Layout) States_;
    KEL.typ.nkdate Event_Date_Max_;
    KEL.typ.nstr Jurisdiction_State_;
    B_Customer_4.__NS96611_Layout Jurisdiction_State_Top_;
    KEL.typ.int C_O_U_N_T___Person_Address_ := 0;
    KEL.typ.ntyp(E_Customer.Typ) U_I_D__1_;
    KEL.typ.int C_O_U_N_T___Person_Address__1_ := 0;
    KEL.typ.ntyp(E_Customer.Typ) U_I_D__2_;
    KEL.typ.int C_O_U_N_T___Person_Address__2_ := 0;
    KEL.typ.ntyp(E_Customer.Typ) U_I_D__3_;
    KEL.typ.int S_U_M___High_Frequency_Flag_ := 0;
    KEL.typ.int S_U_M___High_Frequency_Flag__1_ := 0;
    KEL.typ.ntyp(E_Customer.Typ) U_I_D__4_;
    KEL.typ.int C_O_U_N_T___Person_Address__3_ := 0;
    KEL.typ.ntyp(E_Customer.Typ) U_I_D__5_;
    KEL.typ.int C_O_U_N_T___Person_Address__4_ := 0;
    KEL.typ.ntyp(E_Customer.Typ) U_I_D__6_;
    KEL.typ.int C_O_U_N_T___Person_Address__5_ := 0;
    KEL.typ.ntyp(E_Customer.Typ) U_I_D__7_;
    KEL.typ.int C_O_U_N_T___Person_Address__6_ := 0;
    KEL.typ.ntyp(E_Customer.Typ) U_I_D__8_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  __JC313134(__ST307759_Layout __EE313128, __ST303198_Layout __EE311057) := __EEQP(__EE313128.UID,__EE311057.UID);
  __ST307893_Layout __JT313134(__ST307759_Layout __l, __ST303198_Layout __r) := TRANSFORM
    SELF.C_O_U_N_T___Person_Address__6_ := __r.C_O_U_N_T___Person_Address_;
    SELF.U_I_D__8_ := __r.UID;
    SELF := __l;
    SELF := __r;
  END;
  SHARED __EE313170 := JOIN(__EE313128,__EE311057,__JC313134(LEFT,RIGHT),__JT313134(LEFT,RIGHT),LEFT OUTER,SMART);
  EXPORT __ST32808_Layout := RECORD
    KEL.typ.nuid UID;
    KEL.typ.nint Customer_Id_;
    KEL.typ.nint Industry_Type_;
    KEL.typ.ndataset(E_Customer.States_Layout) States_;
    KEL.typ.int Address_Count_ := 0;
    KEL.typ.int All_Address_Count_ := 0;
    KEL.typ.int All_Deceased_Matched_Person_Count_ := 0;
    KEL.typ.int All_Deceased_Person_Count_ := 0;
    KEL.typ.int All_High_Frequency_Address_Count_ := 0;
    KEL.typ.int All_Person_Count_ := 0;
    KEL.typ.int Deceased_Person_Count_ := 0;
    KEL.typ.nkdate Event_Date_Max_;
    KEL.typ.int High_Frequency_Address_Count_ := 0;
    KEL.typ.nstr Jurisdiction_State_;
    B_Customer_4.__NS96611_Layout Jurisdiction_State_Top_;
    KEL.typ.int Person_Count_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  SHARED __ST32808_Layout __ND313175__Project(__ST307893_Layout __PP313171) := TRANSFORM
    SELF.Address_Count_ := __PP313171.C_O_U_N_T___Person_Address__6_;
    SELF.All_Address_Count_ := __PP313171.C_O_U_N_T___Person_Address__5_;
    SELF.All_Deceased_Matched_Person_Count_ := __PP313171.C_O_U_N_T___Person_Address__4_;
    SELF.All_Deceased_Person_Count_ := __PP313171.C_O_U_N_T___Person_Address__3_;
    SELF.All_High_Frequency_Address_Count_ := __PP313171.S_U_M___High_Frequency_Flag_;
    SELF.All_Person_Count_ := __PP313171.C_O_U_N_T___Person_Address__2_;
    SELF.Deceased_Person_Count_ := __PP313171.C_O_U_N_T___Person_Address__1_;
    SELF.High_Frequency_Address_Count_ := __PP313171.S_U_M___High_Frequency_Flag__1_;
    SELF.Person_Count_ := __PP313171.C_O_U_N_T___Person_Address_;
    SELF := __PP313171;
  END;
  EXPORT __ENH_Customer_1 := PROJECT(__EE313170,__ND313175__Project(LEFT)) : PERSIST('~temp::KEL::FraudgovKEL::Customer::Annotated_1',EXPIRE(7));
END;
