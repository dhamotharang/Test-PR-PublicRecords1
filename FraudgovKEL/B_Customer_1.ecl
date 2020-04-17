﻿//HPCC Systems KEL Compiler Version 0.11.6-2
IMPORT KEL011 AS KEL;
IMPORT B_Address_2,B_Customer_2,B_Customer_3,B_Customer_4,B_Person_2,E_Address,E_Customer,E_Person,E_Person_Address FROM FraudgovKEL;
IMPORT * FROM KEL011.Null;
EXPORT B_Customer_1 := MODULE
  SHARED VIRTUAL TYPEOF(B_Address_2.__ENH_Address_2) __ENH_Address_2 := B_Address_2.__ENH_Address_2;
  SHARED VIRTUAL TYPEOF(B_Customer_2.__ENH_Customer_2) __ENH_Customer_2 := B_Customer_2.__ENH_Customer_2;
  SHARED VIRTUAL TYPEOF(B_Person_2.__ENH_Person_2) __ENH_Person_2 := B_Person_2.__ENH_Person_2;
  SHARED VIRTUAL TYPEOF(E_Person_Address.__Result) __E_Person_Address := E_Person_Address.__Result;
  SHARED __EE331519 := __ENH_Customer_2;
  SHARED __EE338092 := __E_Person_Address;
  SHARED __EE339929 := __EE338092;
  SHARED __EE339957 := __EE339929(__NN(__EE339929._r_Customer_) AND __NN(__EE339929.Subject_));
  SHARED __EE338136 := __ENH_Person_2;
  SHARED __EE339932 := __EE338136;
  SHARED __EE339965 := __EE339932(__EE339932.In_Customer_Population_ = 1);
  __JC339973(E_Person_Address.Layout __EE339957, B_Person_2.__ST36613_Layout __EE339965) := __EEQP(__EE339957.Subject_,__EE339965.UID);
  SHARED __EE339974 := JOIN(__EE339957,__EE339965,__JC339973(LEFT,RIGHT),TRANSFORM(E_Person_Address.Layout,SELF:=LEFT),SMART,KEEP(1));
  SHARED __ST334889_Layout := RECORD
    KEL.typ.ntyp(E_Customer.Typ) UID;
    KEL.typ.ntyp(E_Person.Typ) Subject_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
  END;
  SHARED __EE339995 := PROJECT(TABLE(PROJECT(__EE339974,TRANSFORM(__ST334889_Layout,SELF.UID := LEFT._r_Customer_,SELF := LEFT)),{KEL.typ.epoch Date_First_Seen_ := KEL.era.SimpleRoll(GROUP,Date_First_Seen_,MIN,TRUE),KEL.typ.epoch Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Date_Last_Seen_,MAX,FALSE),UID,Subject_},UID,Subject_,MERGE),__ST334889_Layout);
  SHARED __ST334907_Layout := RECORD
    KEL.typ.int C_O_U_N_T___Person_Address_ := 0;
    KEL.typ.ntyp(E_Customer.Typ) UID;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
  END;
  SHARED __EE340008 := PROJECT(__CLEANANDDO(__EE339995,TABLE(__EE339995,{KEL.typ.int C_O_U_N_T___Person_Address_ := COUNT(GROUP),UID},UID,MERGE)),__ST334907_Layout);
  SHARED __ST335661_Layout := RECORD
    KEL.typ.nuid UID;
    KEL.typ.nint Customer_Id_;
    KEL.typ.nint Industry_Type_;
    KEL.typ.ndataset(E_Customer.States_Layout) States_;
    KEL.typ.nkdate Event_Date_Max_;
    KEL.typ.nstr Jurisdiction_State_;
    B_Customer_4.__NS97576_Layout Jurisdiction_State_Top_;
    KEL.typ.int C_O_U_N_T___Person_Address_ := 0;
    KEL.typ.ntyp(E_Customer.Typ) U_I_D__1_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  __JC340014(B_Customer_3.__ST36961_Layout __EE331519, __ST334907_Layout __EE340008) := __EEQP(__EE331519.UID,__EE340008.UID);
  __ST335661_Layout __JT340014(B_Customer_3.__ST36961_Layout __l, __ST334907_Layout __r) := TRANSFORM
    SELF.U_I_D__1_ := __r.UID;
    SELF := __l;
    SELF := __r;
  END;
  SHARED __EE340015 := JOIN(__EE331519,__EE340008,__JC340014(LEFT,RIGHT),__JT340014(LEFT,RIGHT),LEFT OUTER,SMART);
  SHARED __EE340037 := __EE339957;
  SHARED __EE339926 := __EE338136;
  SHARED __EE340049 := __EE339926(__EE339926.In_Customer_Population_ = 1 AND __EE339926.Deceased_ = 1);
  __JC340057(E_Person_Address.Layout __EE340037, B_Person_2.__ST36613_Layout __EE340049) := __EEQP(__EE340037.Subject_,__EE340049.UID);
  SHARED __EE340058 := JOIN(__EE340037,__EE340049,__JC340057(LEFT,RIGHT),TRANSFORM(E_Person_Address.Layout,SELF:=LEFT),SMART,KEEP(1));
  SHARED __ST334595_Layout := RECORD
    KEL.typ.ntyp(E_Customer.Typ) UID;
    KEL.typ.ntyp(E_Person.Typ) Subject_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
  END;
  SHARED __EE340079 := PROJECT(TABLE(PROJECT(__EE340058,TRANSFORM(__ST334595_Layout,SELF.UID := LEFT._r_Customer_,SELF := LEFT)),{KEL.typ.epoch Date_First_Seen_ := KEL.era.SimpleRoll(GROUP,Date_First_Seen_,MIN,TRUE),KEL.typ.epoch Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Date_Last_Seen_,MAX,FALSE),UID,Subject_},UID,Subject_,MERGE),__ST334595_Layout);
  SHARED __ST334613_Layout := RECORD
    KEL.typ.int C_O_U_N_T___Person_Address_ := 0;
    KEL.typ.ntyp(E_Customer.Typ) UID;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
  END;
  SHARED __EE340092 := PROJECT(__CLEANANDDO(__EE340079,TABLE(__EE340079,{KEL.typ.int C_O_U_N_T___Person_Address_ := COUNT(GROUP),UID},UID,MERGE)),__ST334613_Layout);
  SHARED __ST335796_Layout := RECORD
    KEL.typ.nuid UID;
    KEL.typ.nint Customer_Id_;
    KEL.typ.nint Industry_Type_;
    KEL.typ.ndataset(E_Customer.States_Layout) States_;
    KEL.typ.nkdate Event_Date_Max_;
    KEL.typ.nstr Jurisdiction_State_;
    B_Customer_4.__NS97576_Layout Jurisdiction_State_Top_;
    KEL.typ.int C_O_U_N_T___Person_Address_ := 0;
    KEL.typ.ntyp(E_Customer.Typ) U_I_D__1_;
    KEL.typ.int C_O_U_N_T___Person_Address__1_ := 0;
    KEL.typ.ntyp(E_Customer.Typ) U_I_D__2_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  __JC340100(__ST335661_Layout __EE340015, __ST334613_Layout __EE340092) := __EEQP(__EE340015.UID,__EE340092.UID);
  __ST335796_Layout __JT340100(__ST335661_Layout __l, __ST334613_Layout __r) := TRANSFORM
    SELF.C_O_U_N_T___Person_Address__1_ := __r.C_O_U_N_T___Person_Address_;
    SELF.U_I_D__2_ := __r.UID;
    SELF := __l;
    SELF := __r;
  END;
  SHARED __EE340101 := JOIN(__EE340015,__EE340092,__JC340100(LEFT,RIGHT),__JT340100(LEFT,RIGHT),LEFT OUTER,SMART);
  SHARED __EE339899 := __EE338092;
  SHARED __EE340132 := __EE339899(__NN(__EE339899._r_Customer_));
  SHARED __EE340135 := __EE340132;
  SHARED __ST334289_Layout := RECORD
    KEL.typ.ntyp(E_Customer.Typ) UID;
    KEL.typ.ntyp(E_Person.Typ) Subject_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
  END;
  SHARED __EE340149 := PROJECT(TABLE(PROJECT(__EE340135,TRANSFORM(__ST334289_Layout,SELF.UID := LEFT._r_Customer_,SELF := LEFT)),{KEL.typ.epoch Date_First_Seen_ := KEL.era.SimpleRoll(GROUP,Date_First_Seen_,MIN,TRUE),KEL.typ.epoch Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Date_Last_Seen_,MAX,FALSE),UID,Subject_},UID,Subject_,MERGE),__ST334289_Layout);
  SHARED __ST334307_Layout := RECORD
    KEL.typ.int C_O_U_N_T___Person_Address_ := 0;
    KEL.typ.ntyp(E_Customer.Typ) UID;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
  END;
  SHARED __EE340162 := PROJECT(__CLEANANDDO(__EE340149,TABLE(__EE340149,{KEL.typ.int C_O_U_N_T___Person_Address_ := COUNT(GROUP),UID},UID,MERGE)),__ST334307_Layout);
  SHARED __ST335932_Layout := RECORD
    KEL.typ.nuid UID;
    KEL.typ.nint Customer_Id_;
    KEL.typ.nint Industry_Type_;
    KEL.typ.ndataset(E_Customer.States_Layout) States_;
    KEL.typ.nkdate Event_Date_Max_;
    KEL.typ.nstr Jurisdiction_State_;
    B_Customer_4.__NS97576_Layout Jurisdiction_State_Top_;
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
  __JC340170(__ST335796_Layout __EE340101, __ST334307_Layout __EE340162) := __EEQP(__EE340101.UID,__EE340162.UID);
  __ST335932_Layout __JT340170(__ST335796_Layout __l, __ST334307_Layout __r) := TRANSFORM
    SELF.C_O_U_N_T___Person_Address__2_ := __r.C_O_U_N_T___Person_Address_;
    SELF.U_I_D__3_ := __r.UID;
    SELF := __l;
    SELF := __r;
  END;
  SHARED __EE340171 := JOIN(__EE340101,__EE340162,__JC340170(LEFT,RIGHT),__JT340170(LEFT,RIGHT),LEFT OUTER,HASH);
  SHARED __EE338094 := __ENH_Address_2;
  SHARED __EE339911 := __EE338094;
  SHARED __EE339718 := __EE338092(__NN(__EE338092._r_Customer_) AND __NN(__EE338092.Location_));
  SHARED __ST340907_Layout := RECORD
    KEL.typ.ntyp(E_Customer.Typ) _r_Customer_;
    KEL.typ.ntyp(E_Address.Typ) Location_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  SHARED __EE340911 := PROJECT(TABLE(PROJECT(__EE339718,__ST340907_Layout),{KEL.typ.int __RecordCount := SUM(GROUP,__RecordCount),KEL.typ.epoch Date_First_Seen_ := KEL.era.SimpleRoll(GROUP,Date_First_Seen_,MIN,TRUE),KEL.typ.epoch Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Date_Last_Seen_,MAX,FALSE),_r_Customer_,Location_},_r_Customer_,Location_,MERGE),__ST340907_Layout);
  SHARED __ST340919_Layout := RECORD
    KEL.typ.ntyp(E_Customer.Typ) _r_Customer__1_;
    KEL.typ.ntyp(E_Address.Typ) Location_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
  END;
  SHARED __EE340923 := PROJECT(__EE340911,TRANSFORM(__ST340919_Layout,SELF._r_Customer__1_ := LEFT._r_Customer_,SELF := LEFT));
  SHARED __ST340978_Layout := RECORD
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
  __JC340928(B_Address_2.__ST34749_Layout __EE339911, __ST340919_Layout __EE340923) := __EEQP(__EE340923.Location_,__EE339911.UID);
  __ST340978_Layout __JT340928(B_Address_2.__ST34749_Layout __l, __ST340919_Layout __r) := TRANSFORM
    SELF := __l;
    SELF := __r;
  END;
  SHARED __EE340976 := JOIN(__EE340923,__EE339911,__JC340928(RIGHT,LEFT),__JT340928(RIGHT,LEFT),INNER,HASH);
  SHARED __ST333822_Layout := RECORD
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
  SHARED __ST333822_Layout __ND341028__Project(__ST340978_Layout __PP340977) := TRANSFORM
    SELF.UID := __PP340977._r_Customer__1_;
    SELF.U_I_D__1_ := __PP340977.UID;
    SELF := __PP340977;
  END;
  SHARED __EE341201 := PROJECT(__EE340976,__ND341028__Project(LEFT));
  SHARED __ST333930_Layout := RECORD
    KEL.typ.ntyp(E_Customer.Typ) UID;
    KEL.typ.int High_Frequency_Flag_ := 0;
    KEL.typ.nint Exp1_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
  END;
  SHARED __ST333930_Layout __ND341670__Project(__ST333822_Layout __PP341202) := TRANSFORM
    SELF.Exp1_ := IF(__PP341202.In_Customer_Population_ = 1,__ECAST(KEL.typ.nint,__CN(__PP341202.High_Frequency_Flag_)),__ECAST(KEL.typ.nint,__N(KEL.typ.int)));
    SELF := __PP341202;
  END;
  SHARED __EE341675 := PROJECT(__EE341201,__ND341670__Project(LEFT));
  SHARED __ST333950_Layout := RECORD
    KEL.typ.int S_U_M___High_Frequency_Flag_ := 0;
    KEL.typ.int S_U_M___High_Frequency_Flag__1_ := 0;
    KEL.typ.ntyp(E_Customer.Typ) UID;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
  END;
  SHARED __EE341696 := PROJECT(__CLEANANDDO(__EE341675,TABLE(__EE341675,{KEL.typ.int S_U_M___High_Frequency_Flag_ := SUM(GROUP,__EE341675.High_Frequency_Flag_),KEL.typ.int S_U_M___High_Frequency_Flag__1_ := KEL.Aggregates.SumNG(__EE341675.Exp1_),UID},UID,MERGE)),__ST333950_Layout);
  SHARED __ST336067_Layout := RECORD
    KEL.typ.nuid UID;
    KEL.typ.nint Customer_Id_;
    KEL.typ.nint Industry_Type_;
    KEL.typ.ndataset(E_Customer.States_Layout) States_;
    KEL.typ.nkdate Event_Date_Max_;
    KEL.typ.nstr Jurisdiction_State_;
    B_Customer_4.__NS97576_Layout Jurisdiction_State_Top_;
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
  __JC341702(__ST335932_Layout __EE340171, __ST333950_Layout __EE341696) := __EEQP(__EE340171.UID,__EE341696.UID);
  __ST336067_Layout __JT341702(__ST335932_Layout __l, __ST333950_Layout __r) := TRANSFORM
    SELF.U_I_D__4_ := __r.UID;
    SELF := __l;
    SELF := __r;
  END;
  SHARED __EE341728 := JOIN(__EE340171,__EE341696,__JC341702(LEFT,RIGHT),__JT341702(LEFT,RIGHT),LEFT OUTER,HASH);
  SHARED __EE340516 := __EE339957;
  SHARED __EE339908 := __EE338136;
  SHARED __EE340524 := __EE339908(__EE339908.Deceased_ = 1);
  __JC340532(E_Person_Address.Layout __EE340516, B_Person_2.__ST36613_Layout __EE340524) := __EEQP(__EE340516.Subject_,__EE340524.UID);
  SHARED __EE340533 := JOIN(__EE340516,__EE340524,__JC340532(LEFT,RIGHT),TRANSFORM(E_Person_Address.Layout,SELF:=LEFT),HASH,KEEP(1));
  SHARED __ST332934_Layout := RECORD
    KEL.typ.ntyp(E_Customer.Typ) UID;
    KEL.typ.ntyp(E_Person.Typ) Subject_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
  END;
  SHARED __EE340554 := PROJECT(TABLE(PROJECT(__EE340533,TRANSFORM(__ST332934_Layout,SELF.UID := LEFT._r_Customer_,SELF := LEFT)),{KEL.typ.epoch Date_First_Seen_ := KEL.era.SimpleRoll(GROUP,Date_First_Seen_,MIN,TRUE),KEL.typ.epoch Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Date_Last_Seen_,MAX,FALSE),UID,Subject_},UID,Subject_,MERGE),__ST332934_Layout);
  SHARED __ST332952_Layout := RECORD
    KEL.typ.int C_O_U_N_T___Person_Address_ := 0;
    KEL.typ.ntyp(E_Customer.Typ) UID;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
  END;
  SHARED __EE340567 := PROJECT(__CLEANANDDO(__EE340554,TABLE(__EE340554,{KEL.typ.int C_O_U_N_T___Person_Address_ := COUNT(GROUP),UID},UID,MERGE)),__ST332952_Layout);
  SHARED __ST336202_Layout := RECORD
    KEL.typ.nuid UID;
    KEL.typ.nint Customer_Id_;
    KEL.typ.nint Industry_Type_;
    KEL.typ.ndataset(E_Customer.States_Layout) States_;
    KEL.typ.nkdate Event_Date_Max_;
    KEL.typ.nstr Jurisdiction_State_;
    B_Customer_4.__NS97576_Layout Jurisdiction_State_Top_;
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
  __JC341734(__ST336067_Layout __EE341728, __ST332952_Layout __EE340567) := __EEQP(__EE341728.UID,__EE340567.UID);
  __ST336202_Layout __JT341734(__ST336067_Layout __l, __ST332952_Layout __r) := TRANSFORM
    SELF.C_O_U_N_T___Person_Address__3_ := __r.C_O_U_N_T___Person_Address_;
    SELF.U_I_D__5_ := __r.UID;
    SELF := __l;
    SELF := __r;
  END;
  SHARED __EE341764 := JOIN(__EE341728,__EE340567,__JC341734(LEFT,RIGHT),__JT341734(LEFT,RIGHT),LEFT OUTER,HASH);
  SHARED __EE340609 := __EE339957;
  SHARED __EE338144 := __EE338136(__EE338136.Deceased_Match_ = 1);
  __JC340615(E_Person_Address.Layout __EE340609, B_Person_2.__ST36613_Layout __EE338144) := __EEQP(__EE340609.Subject_,__EE338144.UID);
  SHARED __EE340616 := JOIN(__EE340609,__EE338144,__JC340615(LEFT,RIGHT),TRANSFORM(E_Person_Address.Layout,SELF:=LEFT),SMART,KEEP(1));
  SHARED __ST332558_Layout := RECORD
    KEL.typ.ntyp(E_Customer.Typ) UID;
    KEL.typ.ntyp(E_Customer.Typ) _r_Customer_;
    KEL.typ.ntyp(E_Person.Typ) Subject_;
    KEL.typ.ntyp(E_Address.Typ) Location_;
    KEL.typ.ndataset(E_Person_Address.Event_Dates_Layout) Event_Dates_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
  END;
  SHARED __EE340653 := PROJECT(__EE340616,TRANSFORM(__ST332558_Layout,SELF.UID := LEFT._r_Customer_,SELF := LEFT));
  SHARED __ST332587_Layout := RECORD
    KEL.typ.int C_O_U_N_T___Person_Address_ := 0;
    KEL.typ.ntyp(E_Customer.Typ) UID;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
  END;
  SHARED __EE340666 := PROJECT(__CLEANANDDO(__EE340653,TABLE(__EE340653,{KEL.typ.int C_O_U_N_T___Person_Address_ := COUNT(GROUP),UID},UID,MERGE)),__ST332587_Layout);
  SHARED __ST336338_Layout := RECORD
    KEL.typ.nuid UID;
    KEL.typ.nint Customer_Id_;
    KEL.typ.nint Industry_Type_;
    KEL.typ.ndataset(E_Customer.States_Layout) States_;
    KEL.typ.nkdate Event_Date_Max_;
    KEL.typ.nstr Jurisdiction_State_;
    B_Customer_4.__NS97576_Layout Jurisdiction_State_Top_;
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
  __JC341770(__ST336202_Layout __EE341764, __ST332587_Layout __EE340666) := __EEQP(__EE341764.UID,__EE340666.UID);
  __ST336338_Layout __JT341770(__ST336202_Layout __l, __ST332587_Layout __r) := TRANSFORM
    SELF.C_O_U_N_T___Person_Address__4_ := __r.C_O_U_N_T___Person_Address_;
    SELF.U_I_D__6_ := __r.UID;
    SELF := __l;
    SELF := __r;
  END;
  SHARED __EE341802 := JOIN(__EE341764,__EE340666,__JC341770(LEFT,RIGHT),__JT341770(LEFT,RIGHT),LEFT OUTER,SMART);
  SHARED __ST332234_Layout := RECORD
    KEL.typ.ntyp(E_Customer.Typ) UID;
    KEL.typ.ntyp(E_Address.Typ) Location_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
  END;
  SHARED __EE340721 := PROJECT(TABLE(PROJECT(__EE340132,TRANSFORM(__ST332234_Layout,SELF.UID := LEFT._r_Customer_,SELF := LEFT)),{KEL.typ.epoch Date_First_Seen_ := KEL.era.SimpleRoll(GROUP,Date_First_Seen_,MIN,TRUE),KEL.typ.epoch Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Date_Last_Seen_,MAX,FALSE),UID,Location_},UID,Location_,MERGE),__ST332234_Layout);
  SHARED __ST332252_Layout := RECORD
    KEL.typ.int C_O_U_N_T___Person_Address_ := 0;
    KEL.typ.ntyp(E_Customer.Typ) UID;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
  END;
  SHARED __EE340734 := PROJECT(__CLEANANDDO(__EE340721,TABLE(__EE340721,{KEL.typ.int C_O_U_N_T___Person_Address_ := COUNT(GROUP),UID},UID,MERGE)),__ST332252_Layout);
  SHARED __ST336473_Layout := RECORD
    KEL.typ.nuid UID;
    KEL.typ.nint Customer_Id_;
    KEL.typ.nint Industry_Type_;
    KEL.typ.ndataset(E_Customer.States_Layout) States_;
    KEL.typ.nkdate Event_Date_Max_;
    KEL.typ.nstr Jurisdiction_State_;
    B_Customer_4.__NS97576_Layout Jurisdiction_State_Top_;
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
  __JC341808(__ST336338_Layout __EE341802, __ST332252_Layout __EE340734) := __EEQP(__EE341802.UID,__EE340734.UID);
  __ST336473_Layout __JT341808(__ST336338_Layout __l, __ST332252_Layout __r) := TRANSFORM
    SELF.C_O_U_N_T___Person_Address__5_ := __r.C_O_U_N_T___Person_Address_;
    SELF.U_I_D__7_ := __r.UID;
    SELF := __l;
    SELF := __r;
  END;
  SHARED __EE341842 := JOIN(__EE341802,__EE340734,__JC341808(LEFT,RIGHT),__JT341808(LEFT,RIGHT),LEFT OUTER,HASH);
  SHARED __EE338102 := __EE338094(__EE338094.In_Customer_Population_ = 1);
  __JC339736(E_Person_Address.Layout __EE339718, B_Address_2.__ST34749_Layout __EE338102) := __EEQP(__EE339718.Location_,__EE338102.UID);
  SHARED __EE339737 := JOIN(__EE339718,__EE338102,__JC339736(LEFT,RIGHT),TRANSFORM(E_Person_Address.Layout,SELF:=LEFT),SMART,KEEP(1));
  SHARED __ST331894_Layout := RECORD
    KEL.typ.ntyp(E_Customer.Typ) UID;
    KEL.typ.ntyp(E_Address.Typ) Location_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
  END;
  SHARED __EE339758 := PROJECT(TABLE(PROJECT(__EE339737,TRANSFORM(__ST331894_Layout,SELF.UID := LEFT._r_Customer_,SELF := LEFT)),{KEL.typ.epoch Date_First_Seen_ := KEL.era.SimpleRoll(GROUP,Date_First_Seen_,MIN,TRUE),KEL.typ.epoch Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Date_Last_Seen_,MAX,FALSE),UID,Location_},UID,Location_,MERGE),__ST331894_Layout);
  SHARED __ST331912_Layout := RECORD
    KEL.typ.int C_O_U_N_T___Person_Address_ := 0;
    KEL.typ.ntyp(E_Customer.Typ) UID;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
  END;
  SHARED __EE339771 := PROJECT(__CLEANANDDO(__EE339758,TABLE(__EE339758,{KEL.typ.int C_O_U_N_T___Person_Address_ := COUNT(GROUP),UID},UID,MERGE)),__ST331912_Layout);
  SHARED __ST336607_Layout := RECORD
    KEL.typ.nuid UID;
    KEL.typ.nint Customer_Id_;
    KEL.typ.nint Industry_Type_;
    KEL.typ.ndataset(E_Customer.States_Layout) States_;
    KEL.typ.nkdate Event_Date_Max_;
    KEL.typ.nstr Jurisdiction_State_;
    B_Customer_4.__NS97576_Layout Jurisdiction_State_Top_;
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
  __JC341848(__ST336473_Layout __EE341842, __ST331912_Layout __EE339771) := __EEQP(__EE341842.UID,__EE339771.UID);
  __ST336607_Layout __JT341848(__ST336473_Layout __l, __ST331912_Layout __r) := TRANSFORM
    SELF.C_O_U_N_T___Person_Address__6_ := __r.C_O_U_N_T___Person_Address_;
    SELF.U_I_D__8_ := __r.UID;
    SELF := __l;
    SELF := __r;
  END;
  SHARED __EE341884 := JOIN(__EE341842,__EE339771,__JC341848(LEFT,RIGHT),__JT341848(LEFT,RIGHT),LEFT OUTER,SMART);
  EXPORT __ST30331_Layout := RECORD
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
    B_Customer_4.__NS97576_Layout Jurisdiction_State_Top_;
    KEL.typ.int Person_Count_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  SHARED __ST30331_Layout __ND341889__Project(__ST336607_Layout __PP341885) := TRANSFORM
    SELF.Address_Count_ := __PP341885.C_O_U_N_T___Person_Address__6_;
    SELF.All_Address_Count_ := __PP341885.C_O_U_N_T___Person_Address__5_;
    SELF.All_Deceased_Matched_Person_Count_ := __PP341885.C_O_U_N_T___Person_Address__4_;
    SELF.All_Deceased_Person_Count_ := __PP341885.C_O_U_N_T___Person_Address__3_;
    SELF.All_High_Frequency_Address_Count_ := __PP341885.S_U_M___High_Frequency_Flag_;
    SELF.All_Person_Count_ := __PP341885.C_O_U_N_T___Person_Address__2_;
    SELF.Deceased_Person_Count_ := __PP341885.C_O_U_N_T___Person_Address__1_;
    SELF.High_Frequency_Address_Count_ := __PP341885.S_U_M___High_Frequency_Flag__1_;
    SELF.Person_Count_ := __PP341885.C_O_U_N_T___Person_Address_;
    SELF := __PP341885;
  END;
  EXPORT __ENH_Customer_1 := PROJECT(__EE341884,__ND341889__Project(LEFT)) : PERSIST('~temp::KEL::FraudgovKEL::Customer::Annotated_1',EXPIRE(7));
END;
