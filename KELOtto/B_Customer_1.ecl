﻿//HPCC Systems KEL Compiler Version 0.11.0
IMPORT KEL011 AS KEL;
IMPORT B_Address_2,B_Customer_2,B_Customer_6,B_Person_2,E_Address,E_Customer,E_Person,E_Person_Address FROM KELOtto;
IMPORT * FROM KEL011.Null;
EXPORT B_Customer_1 := MODULE
  SHARED VIRTUAL TYPEOF(B_Address_2.__ENH_Address_2) __ENH_Address_2 := B_Address_2.__ENH_Address_2;
  SHARED VIRTUAL TYPEOF(B_Customer_2.__ENH_Customer_2) __ENH_Customer_2 := B_Customer_2.__ENH_Customer_2;
  SHARED VIRTUAL TYPEOF(B_Person_2.__ENH_Person_2) __ENH_Person_2 := B_Person_2.__ENH_Person_2;
  SHARED VIRTUAL TYPEOF(E_Person_Address.__Result) __E_Person_Address := E_Person_Address.__Result;
  SHARED __EE194926 := __ENH_Customer_2;
  SHARED __EE201956 := __E_Person_Address;
  SHARED __EE204286 := __EE201956;
  SHARED __EE204320 := __EE204286(__NN(__EE204286._r_Customer_) AND __NN(__EE204286.Subject_));
  SHARED __EE202000 := __ENH_Person_2;
  SHARED __EE204289 := __EE202000;
  SHARED __EE204328 := __EE204289(__EE204289.In_Customer_Population_ = 1);
  __JC204336(E_Person_Address.Layout __EE204320, B_Person_2.__ST17004_Layout __EE204328) := __EEQP(__EE204320.Subject_,__EE204328.UID);
  SHARED __EE204337 := JOIN(__EE204320,__EE204328,__JC204336(LEFT,RIGHT),TRANSFORM(E_Person_Address.Layout,SELF:=LEFT),HASH,KEEP(1));
  SHARED __ST198590_Layout := RECORD
    KEL.typ.ntyp(E_Customer.Typ) UID;
    KEL.typ.ntyp(E_Person.Typ) Subject_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
  END;
  SHARED __EE204355 := DEDUP(PROJECT(__EE204337,TRANSFORM(__ST198590_Layout,SELF.UID := LEFT._r_Customer_,SELF := LEFT)),ALL);
  SHARED __ST198608_Layout := RECORD
    KEL.typ.int C_O_U_N_T___Person_Address_ := 0;
    KEL.typ.ntyp(E_Customer.Typ) UID;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
  END;
  SHARED __EE204368 := PROJECT(__CLEANANDDO(__EE204355,TABLE(__EE204355,{KEL.typ.int C_O_U_N_T___Person_Address_ := COUNT(GROUP),UID},UID,MERGE)),__ST198608_Layout);
  SHARED __ST199648_Layout := RECORD
    KEL.typ.nuid UID;
    KEL.typ.nint Customer_Id_;
    KEL.typ.nint Industry_Type_;
    KEL.typ.nkdate Event_Date_Max_;
    KEL.typ.int C_O_U_N_T___Person_Address_ := 0;
    KEL.typ.ntyp(E_Customer.Typ) U_I_D__1_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  __JC204374(B_Customer_6.__ST18698_Layout __EE194926, __ST198608_Layout __EE204368) := __EEQP(__EE194926.UID,__EE204368.UID);
  __ST199648_Layout __JT204374(B_Customer_6.__ST18698_Layout __l, __ST198608_Layout __r) := TRANSFORM
    SELF.U_I_D__1_ := __r.UID;
    SELF := __l;
    SELF := __r;
  END;
  SHARED __EE204375 := JOIN(__EE194926,__EE204368,__JC204374(LEFT,RIGHT),__JT204374(LEFT,RIGHT),LEFT OUTER,HASH);
  SHARED __EE201958 := __ENH_Address_2;
  SHARED __EE204274 := __EE201958;
  SHARED __EE204098 := __EE201956(__NN(__EE201956._r_Customer_) AND __NN(__EE201956.Location_));
  SHARED __EE201966 := __EE201958(__EE201958.In_Customer_Population_ = 1);
  __JC204116(E_Person_Address.Layout __EE204098, B_Address_2.__ST16315_Layout __EE201966) := __EEQP(__EE204098.Location_,__EE201966.UID);
  SHARED __EE204117 := JOIN(__EE204098,__EE201966,__JC204116(LEFT,RIGHT),TRANSFORM(E_Person_Address.Layout,SELF:=LEFT),HASH,KEEP(1));
  SHARED __ST205456_Layout := RECORD
    KEL.typ.ntyp(E_Customer.Typ) _r_Customer_;
    KEL.typ.ntyp(E_Address.Typ) Location_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
  END;
  SHARED __EE205460 := DEDUP(PROJECT(__EE204117,__ST205456_Layout),ALL);
  SHARED __ST205468_Layout := RECORD
    KEL.typ.ntyp(E_Customer.Typ) _r_Customer__1_;
    KEL.typ.ntyp(E_Address.Typ) Location_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
  END;
  SHARED __EE205472 := PROJECT(__EE205460,TRANSFORM(__ST205468_Layout,SELF._r_Customer__1_ := LEFT._r_Customer_,SELF := LEFT));
  SHARED __ST205529_Layout := RECORD
    KEL.typ.nuid UID;
    KEL.typ.ntyp(E_Customer.Typ) _r_Customer_;
    KEL.typ.ndataset(E_Address.Source_Customers_Layout) Source_Customers_;
    KEL.typ.nbool _addresspobox_;
    KEL.typ.nbool _addresscmra_;
    KEL.typ.nint Otto_Address_Id_;
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
    KEL.typ.int Cl_Active30_Identity_Count_ := 0;
    KEL.typ.int Cl_Active7_Identity_Count_ := 0;
    KEL.typ.int Cl_Event_Count_ := 0;
    KEL.typ.int Cl_Identity_Count_ := 0;
    KEL.typ.int High_Frequency_Flag_ := 0;
    KEL.typ.int High_Risk_Death_Prior_To_All_Events_Person_Count_ := 0;
    KEL.typ.int Identity_Count_ := 0;
    KEL.typ.int In_Customer_Population_ := 0;
    KEL.typ.ntyp(E_Customer.Typ) _r_Customer__1_;
    KEL.typ.ntyp(E_Address.Typ) Location_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  __JC205477(B_Address_2.__ST16315_Layout __EE204274, __ST205468_Layout __EE205472) := __EEQP(__EE205472.Location_,__EE204274.UID);
  __ST205529_Layout __JT205477(B_Address_2.__ST16315_Layout __l, __ST205468_Layout __r) := TRANSFORM
    SELF := __l;
    SELF := __r;
  END;
  SHARED __EE205527 := JOIN(__EE204274,__EE205472,__JC205477(LEFT,RIGHT),__JT205477(LEFT,RIGHT),INNER,HASH);
  SHARED __ST198187_Layout := RECORD
    KEL.typ.ntyp(E_Customer.Typ) UID;
    KEL.typ.nuid U_I_D__1_;
    KEL.typ.ntyp(E_Customer.Typ) _r_Customer_;
    KEL.typ.ndataset(E_Address.Source_Customers_Layout) Source_Customers_;
    KEL.typ.nbool _addresspobox_;
    KEL.typ.nbool _addresscmra_;
    KEL.typ.nint Otto_Address_Id_;
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
    KEL.typ.int Cl_Active30_Identity_Count_ := 0;
    KEL.typ.int Cl_Active7_Identity_Count_ := 0;
    KEL.typ.int Cl_Event_Count_ := 0;
    KEL.typ.int Cl_Identity_Count_ := 0;
    KEL.typ.int High_Frequency_Flag_ := 0;
    KEL.typ.int High_Risk_Death_Prior_To_All_Events_Person_Count_ := 0;
    KEL.typ.int Identity_Count_ := 0;
    KEL.typ.int In_Customer_Population_ := 0;
    KEL.typ.ntyp(E_Address.Typ) Location_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
  END;
  SHARED __ST198187_Layout __ND205581__Project(__ST205529_Layout __PP205528) := TRANSFORM
    SELF.UID := __PP205528._r_Customer__1_;
    SELF.U_I_D__1_ := __PP205528.UID;
    SELF := __PP205528;
  END;
  SHARED __EE205762 := PROJECT(__EE205527,__ND205581__Project(LEFT));
  SHARED __ST198293_Layout := RECORD
    KEL.typ.ntyp(E_Customer.Typ) UID;
    KEL.typ.int High_Frequency_Flag_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
  END;
  SHARED __EE205776 := PROJECT(__EE205762,__ST198293_Layout);
  SHARED __ST198308_Layout := RECORD
    KEL.typ.int S_U_M___High_Frequency_Flag_ := 0;
    KEL.typ.ntyp(E_Customer.Typ) UID;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
  END;
  SHARED __EE205792 := PROJECT(__CLEANANDDO(__EE205776,TABLE(__EE205776,{KEL.typ.int S_U_M___High_Frequency_Flag_ := SUM(GROUP,__EE205776.High_Frequency_Flag_),UID},UID,MERGE)),__ST198308_Layout);
  SHARED __ST199744_Layout := RECORD
    KEL.typ.nuid UID;
    KEL.typ.nint Customer_Id_;
    KEL.typ.nint Industry_Type_;
    KEL.typ.nkdate Event_Date_Max_;
    KEL.typ.int C_O_U_N_T___Person_Address_ := 0;
    KEL.typ.ntyp(E_Customer.Typ) U_I_D__1_;
    KEL.typ.int S_U_M___High_Frequency_Flag_ := 0;
    KEL.typ.ntyp(E_Customer.Typ) U_I_D__2_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  __JC205798(__ST199648_Layout __EE204375, __ST198308_Layout __EE205792) := __EEQP(__EE204375.UID,__EE205792.UID);
  __ST199744_Layout __JT205798(__ST199648_Layout __l, __ST198308_Layout __r) := TRANSFORM
    SELF.U_I_D__2_ := __r.UID;
    SELF := __l;
    SELF := __r;
  END;
  SHARED __EE205810 := JOIN(__EE204375,__EE205792,__JC205798(LEFT,RIGHT),__JT205798(LEFT,RIGHT),LEFT OUTER,HASH);
  SHARED __EE204685 := __EE204320;
  SHARED __EE204271 := __EE202000;
  SHARED __EE204697 := __EE204271(__EE204271.In_Customer_Population_ = 1 AND __EE204271.Deceased_ = 1);
  __JC204705(E_Person_Address.Layout __EE204685, B_Person_2.__ST17004_Layout __EE204697) := __EEQP(__EE204685.Subject_,__EE204697.UID);
  SHARED __EE204706 := JOIN(__EE204685,__EE204697,__JC204705(LEFT,RIGHT),TRANSFORM(E_Person_Address.Layout,SELF:=LEFT),HASH,KEEP(1));
  SHARED __ST197830_Layout := RECORD
    KEL.typ.ntyp(E_Customer.Typ) UID;
    KEL.typ.ntyp(E_Person.Typ) Subject_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
  END;
  SHARED __EE204724 := DEDUP(PROJECT(__EE204706,TRANSFORM(__ST197830_Layout,SELF.UID := LEFT._r_Customer_,SELF := LEFT)),ALL);
  SHARED __ST197848_Layout := RECORD
    KEL.typ.int C_O_U_N_T___Person_Address_ := 0;
    KEL.typ.ntyp(E_Customer.Typ) UID;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
  END;
  SHARED __EE204737 := PROJECT(__CLEANANDDO(__EE204724,TABLE(__EE204724,{KEL.typ.int C_O_U_N_T___Person_Address_ := COUNT(GROUP),UID},UID,MERGE)),__ST197848_Layout);
  SHARED __ST199839_Layout := RECORD
    KEL.typ.nuid UID;
    KEL.typ.nint Customer_Id_;
    KEL.typ.nint Industry_Type_;
    KEL.typ.nkdate Event_Date_Max_;
    KEL.typ.int C_O_U_N_T___Person_Address_ := 0;
    KEL.typ.ntyp(E_Customer.Typ) U_I_D__1_;
    KEL.typ.int S_U_M___High_Frequency_Flag_ := 0;
    KEL.typ.ntyp(E_Customer.Typ) U_I_D__2_;
    KEL.typ.int C_O_U_N_T___Person_Address__1_ := 0;
    KEL.typ.ntyp(E_Customer.Typ) U_I_D__3_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  __JC205827(__ST199744_Layout __EE205810, __ST197848_Layout __EE204737) := __EEQP(__EE205810.UID,__EE204737.UID);
  __ST199839_Layout __JT205827(__ST199744_Layout __l, __ST197848_Layout __r) := TRANSFORM
    SELF.C_O_U_N_T___Person_Address__1_ := __r.C_O_U_N_T___Person_Address_;
    SELF.U_I_D__3_ := __r.UID;
    SELF := __l;
    SELF := __r;
  END;
  SHARED __EE205843 := JOIN(__EE205810,__EE204737,__JC205827(LEFT,RIGHT),__JT205827(LEFT,RIGHT),LEFT OUTER,HASH);
  SHARED __EE204244 := __EE201956;
  SHARED __EE204770 := __EE204244(__NN(__EE204244._r_Customer_));
  SHARED __EE204773 := __EE204770;
  SHARED __ST197635_Layout := RECORD
    KEL.typ.ntyp(E_Customer.Typ) UID;
    KEL.typ.ntyp(E_Person.Typ) Subject_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
  END;
  SHARED __EE204787 := DEDUP(PROJECT(__EE204773,TRANSFORM(__ST197635_Layout,SELF.UID := LEFT._r_Customer_,SELF := LEFT)),ALL);
  SHARED __ST197653_Layout := RECORD
    KEL.typ.int C_O_U_N_T___Person_Address_ := 0;
    KEL.typ.ntyp(E_Customer.Typ) UID;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
  END;
  SHARED __EE204800 := PROJECT(__CLEANANDDO(__EE204787,TABLE(__EE204787,{KEL.typ.int C_O_U_N_T___Person_Address_ := COUNT(GROUP),UID},UID,MERGE)),__ST197653_Layout);
  SHARED __ST199935_Layout := RECORD
    KEL.typ.nuid UID;
    KEL.typ.nint Customer_Id_;
    KEL.typ.nint Industry_Type_;
    KEL.typ.nkdate Event_Date_Max_;
    KEL.typ.int C_O_U_N_T___Person_Address_ := 0;
    KEL.typ.ntyp(E_Customer.Typ) U_I_D__1_;
    KEL.typ.int S_U_M___High_Frequency_Flag_ := 0;
    KEL.typ.ntyp(E_Customer.Typ) U_I_D__2_;
    KEL.typ.int C_O_U_N_T___Person_Address__1_ := 0;
    KEL.typ.ntyp(E_Customer.Typ) U_I_D__3_;
    KEL.typ.int C_O_U_N_T___Person_Address__2_ := 0;
    KEL.typ.ntyp(E_Customer.Typ) U_I_D__4_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  __JC205864(__ST199839_Layout __EE205843, __ST197653_Layout __EE204800) := __EEQP(__EE205843.UID,__EE204800.UID);
  __ST199935_Layout __JT205864(__ST199839_Layout __l, __ST197653_Layout __r) := TRANSFORM
    SELF.C_O_U_N_T___Person_Address__2_ := __r.C_O_U_N_T___Person_Address_;
    SELF.U_I_D__4_ := __r.UID;
    SELF := __l;
    SELF := __r;
  END;
  SHARED __EE205882 := JOIN(__EE205843,__EE204800,__JC205864(LEFT,RIGHT),__JT205864(LEFT,RIGHT),LEFT OUTER,HASH);
  SHARED __EE204256 := __EE201958;
  SHARED __ST205907_Layout := RECORD
    KEL.typ.ntyp(E_Customer.Typ) _r_Customer_;
    KEL.typ.ntyp(E_Address.Typ) Location_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  SHARED __EE205911 := PROJECT(TABLE(PROJECT(__EE204098,__ST205907_Layout),{KEL.typ.int __RecordCount := SUM(GROUP,__RecordCount),KEL.typ.epoch Date_First_Seen_ := KEL.era.SimpleRoll(GROUP,Date_First_Seen_,MIN,TRUE),KEL.typ.epoch Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Date_Last_Seen_,MAX,FALSE),_r_Customer_,Location_},_r_Customer_,Location_,MERGE),__ST205907_Layout);
  SHARED __ST205919_Layout := RECORD
    KEL.typ.ntyp(E_Customer.Typ) _r_Customer__1_;
    KEL.typ.ntyp(E_Address.Typ) Location_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
  END;
  SHARED __EE205923 := PROJECT(__EE205911,TRANSFORM(__ST205919_Layout,SELF._r_Customer__1_ := LEFT._r_Customer_,SELF := LEFT));
  SHARED __ST205980_Layout := RECORD
    KEL.typ.nuid UID;
    KEL.typ.ntyp(E_Customer.Typ) _r_Customer_;
    KEL.typ.ndataset(E_Address.Source_Customers_Layout) Source_Customers_;
    KEL.typ.nbool _addresspobox_;
    KEL.typ.nbool _addresscmra_;
    KEL.typ.nint Otto_Address_Id_;
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
    KEL.typ.int Cl_Active30_Identity_Count_ := 0;
    KEL.typ.int Cl_Active7_Identity_Count_ := 0;
    KEL.typ.int Cl_Event_Count_ := 0;
    KEL.typ.int Cl_Identity_Count_ := 0;
    KEL.typ.int High_Frequency_Flag_ := 0;
    KEL.typ.int High_Risk_Death_Prior_To_All_Events_Person_Count_ := 0;
    KEL.typ.int Identity_Count_ := 0;
    KEL.typ.int In_Customer_Population_ := 0;
    KEL.typ.ntyp(E_Customer.Typ) _r_Customer__1_;
    KEL.typ.ntyp(E_Address.Typ) Location_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  __JC205928(B_Address_2.__ST16315_Layout __EE204256, __ST205919_Layout __EE205923) := __EEQP(__EE205923.Location_,__EE204256.UID);
  __ST205980_Layout __JT205928(B_Address_2.__ST16315_Layout __l, __ST205919_Layout __r) := TRANSFORM
    SELF := __l;
    SELF := __r;
  END;
  SHARED __EE205978 := JOIN(__EE205923,__EE204256,__JC205928(RIGHT,LEFT),__JT205928(RIGHT,LEFT),INNER,HASH);
  SHARED __ST197262_Layout := RECORD
    KEL.typ.ntyp(E_Customer.Typ) UID;
    KEL.typ.nuid U_I_D__1_;
    KEL.typ.ntyp(E_Customer.Typ) _r_Customer_;
    KEL.typ.ndataset(E_Address.Source_Customers_Layout) Source_Customers_;
    KEL.typ.nbool _addresspobox_;
    KEL.typ.nbool _addresscmra_;
    KEL.typ.nint Otto_Address_Id_;
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
    KEL.typ.int Cl_Active30_Identity_Count_ := 0;
    KEL.typ.int Cl_Active7_Identity_Count_ := 0;
    KEL.typ.int Cl_Event_Count_ := 0;
    KEL.typ.int Cl_Identity_Count_ := 0;
    KEL.typ.int High_Frequency_Flag_ := 0;
    KEL.typ.int High_Risk_Death_Prior_To_All_Events_Person_Count_ := 0;
    KEL.typ.int Identity_Count_ := 0;
    KEL.typ.int In_Customer_Population_ := 0;
    KEL.typ.ntyp(E_Address.Typ) Location_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
  END;
  SHARED __ST197262_Layout __ND206032__Project(__ST205980_Layout __PP205979) := TRANSFORM
    SELF.UID := __PP205979._r_Customer__1_;
    SELF.U_I_D__1_ := __PP205979.UID;
    SELF := __PP205979;
  END;
  SHARED __EE206213 := PROJECT(__EE205978,__ND206032__Project(LEFT));
  SHARED __ST197368_Layout := RECORD
    KEL.typ.ntyp(E_Customer.Typ) UID;
    KEL.typ.int High_Frequency_Flag_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
  END;
  SHARED __EE206227 := PROJECT(__EE206213,__ST197368_Layout);
  SHARED __ST197383_Layout := RECORD
    KEL.typ.int S_U_M___High_Frequency_Flag_ := 0;
    KEL.typ.ntyp(E_Customer.Typ) UID;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
  END;
  SHARED __EE206243 := PROJECT(__CLEANANDDO(__EE206227,TABLE(__EE206227,{KEL.typ.int S_U_M___High_Frequency_Flag_ := SUM(GROUP,__EE206227.High_Frequency_Flag_),UID},UID,MERGE)),__ST197383_Layout);
  SHARED __ST200030_Layout := RECORD
    KEL.typ.nuid UID;
    KEL.typ.nint Customer_Id_;
    KEL.typ.nint Industry_Type_;
    KEL.typ.nkdate Event_Date_Max_;
    KEL.typ.int C_O_U_N_T___Person_Address_ := 0;
    KEL.typ.ntyp(E_Customer.Typ) U_I_D__1_;
    KEL.typ.int S_U_M___High_Frequency_Flag_ := 0;
    KEL.typ.ntyp(E_Customer.Typ) U_I_D__2_;
    KEL.typ.int C_O_U_N_T___Person_Address__1_ := 0;
    KEL.typ.ntyp(E_Customer.Typ) U_I_D__3_;
    KEL.typ.int C_O_U_N_T___Person_Address__2_ := 0;
    KEL.typ.ntyp(E_Customer.Typ) U_I_D__4_;
    KEL.typ.int S_U_M___High_Frequency_Flag__1_ := 0;
    KEL.typ.ntyp(E_Customer.Typ) U_I_D__5_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  __JC206251(__ST199935_Layout __EE205882, __ST197383_Layout __EE206243) := __EEQP(__EE205882.UID,__EE206243.UID);
  __ST200030_Layout __JT206251(__ST199935_Layout __l, __ST197383_Layout __r) := TRANSFORM
    SELF.S_U_M___High_Frequency_Flag__1_ := __r.S_U_M___High_Frequency_Flag_;
    SELF.U_I_D__5_ := __r.UID;
    SELF := __l;
    SELF := __r;
  END;
  SHARED __EE206271 := JOIN(__EE205882,__EE206243,__JC206251(LEFT,RIGHT),__JT206251(LEFT,RIGHT),LEFT OUTER,HASH);
  SHARED __EE205135 := __EE204320;
  SHARED __EE204253 := __EE202000;
  SHARED __EE205143 := __EE204253(__EE204253.Deceased_ = 1);
  __JC205151(E_Person_Address.Layout __EE205135, B_Person_2.__ST17004_Layout __EE205143) := __EEQP(__EE205135.Subject_,__EE205143.UID);
  SHARED __EE205152 := JOIN(__EE205135,__EE205143,__JC205151(LEFT,RIGHT),TRANSFORM(E_Person_Address.Layout,SELF:=LEFT),HASH,KEEP(1));
  SHARED __ST196933_Layout := RECORD
    KEL.typ.ntyp(E_Customer.Typ) UID;
    KEL.typ.ntyp(E_Person.Typ) Subject_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
  END;
  SHARED __EE205170 := DEDUP(PROJECT(__EE205152,TRANSFORM(__ST196933_Layout,SELF.UID := LEFT._r_Customer_,SELF := LEFT)),ALL);
  SHARED __ST196951_Layout := RECORD
    KEL.typ.int C_O_U_N_T___Person_Address_ := 0;
    KEL.typ.ntyp(E_Customer.Typ) UID;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
  END;
  SHARED __EE205183 := PROJECT(__CLEANANDDO(__EE205170,TABLE(__EE205170,{KEL.typ.int C_O_U_N_T___Person_Address_ := COUNT(GROUP),UID},UID,MERGE)),__ST196951_Layout);
  SHARED __ST200124_Layout := RECORD
    KEL.typ.nuid UID;
    KEL.typ.nint Customer_Id_;
    KEL.typ.nint Industry_Type_;
    KEL.typ.nkdate Event_Date_Max_;
    KEL.typ.int C_O_U_N_T___Person_Address_ := 0;
    KEL.typ.ntyp(E_Customer.Typ) U_I_D__1_;
    KEL.typ.int S_U_M___High_Frequency_Flag_ := 0;
    KEL.typ.ntyp(E_Customer.Typ) U_I_D__2_;
    KEL.typ.int C_O_U_N_T___Person_Address__1_ := 0;
    KEL.typ.ntyp(E_Customer.Typ) U_I_D__3_;
    KEL.typ.int C_O_U_N_T___Person_Address__2_ := 0;
    KEL.typ.ntyp(E_Customer.Typ) U_I_D__4_;
    KEL.typ.int S_U_M___High_Frequency_Flag__1_ := 0;
    KEL.typ.ntyp(E_Customer.Typ) U_I_D__5_;
    KEL.typ.int C_O_U_N_T___Person_Address__3_ := 0;
    KEL.typ.ntyp(E_Customer.Typ) U_I_D__6_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  __JC206296(__ST200030_Layout __EE206271, __ST196951_Layout __EE205183) := __EEQP(__EE206271.UID,__EE205183.UID);
  __ST200124_Layout __JT206296(__ST200030_Layout __l, __ST196951_Layout __r) := TRANSFORM
    SELF.C_O_U_N_T___Person_Address__3_ := __r.C_O_U_N_T___Person_Address_;
    SELF.U_I_D__6_ := __r.UID;
    SELF := __l;
    SELF := __r;
  END;
  SHARED __EE206318 := JOIN(__EE206271,__EE205183,__JC206296(LEFT,RIGHT),__JT206296(LEFT,RIGHT),LEFT OUTER,HASH);
  SHARED __EE205217 := __EE204320;
  SHARED __EE202008 := __EE202000(__EE202000.Deceased_Match_ = 1);
  __JC205223(E_Person_Address.Layout __EE205217, B_Person_2.__ST17004_Layout __EE202008) := __EEQP(__EE205217.Subject_,__EE202008.UID);
  SHARED __EE205224 := JOIN(__EE205217,__EE202008,__JC205223(LEFT,RIGHT),TRANSFORM(E_Person_Address.Layout,SELF:=LEFT),HASH,KEEP(1));
  SHARED __ST196719_Layout := RECORD
    KEL.typ.ntyp(E_Customer.Typ) UID;
    KEL.typ.ntyp(E_Customer.Typ) _r_Customer_;
    KEL.typ.ntyp(E_Person.Typ) Subject_;
    KEL.typ.ntyp(E_Address.Typ) Location_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
  END;
  SHARED __EE205250 := PROJECT(__EE205224,TRANSFORM(__ST196719_Layout,SELF.UID := LEFT._r_Customer_,SELF := LEFT));
  SHARED __ST196741_Layout := RECORD
    KEL.typ.int C_O_U_N_T___Person_Address_ := 0;
    KEL.typ.ntyp(E_Customer.Typ) UID;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
  END;
  SHARED __EE205263 := PROJECT(__CLEANANDDO(__EE205250,TABLE(__EE205250,{KEL.typ.int C_O_U_N_T___Person_Address_ := COUNT(GROUP),UID},UID,MERGE)),__ST196741_Layout);
  SHARED __ST200217_Layout := RECORD
    KEL.typ.nuid UID;
    KEL.typ.nint Customer_Id_;
    KEL.typ.nint Industry_Type_;
    KEL.typ.nkdate Event_Date_Max_;
    KEL.typ.int C_O_U_N_T___Person_Address_ := 0;
    KEL.typ.ntyp(E_Customer.Typ) U_I_D__1_;
    KEL.typ.int S_U_M___High_Frequency_Flag_ := 0;
    KEL.typ.ntyp(E_Customer.Typ) U_I_D__2_;
    KEL.typ.int C_O_U_N_T___Person_Address__1_ := 0;
    KEL.typ.ntyp(E_Customer.Typ) U_I_D__3_;
    KEL.typ.int C_O_U_N_T___Person_Address__2_ := 0;
    KEL.typ.ntyp(E_Customer.Typ) U_I_D__4_;
    KEL.typ.int S_U_M___High_Frequency_Flag__1_ := 0;
    KEL.typ.ntyp(E_Customer.Typ) U_I_D__5_;
    KEL.typ.int C_O_U_N_T___Person_Address__3_ := 0;
    KEL.typ.ntyp(E_Customer.Typ) U_I_D__6_;
    KEL.typ.int C_O_U_N_T___Person_Address__4_ := 0;
    KEL.typ.ntyp(E_Customer.Typ) U_I_D__7_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  __JC206345(__ST200124_Layout __EE206318, __ST196741_Layout __EE205263) := __EEQP(__EE206318.UID,__EE205263.UID);
  __ST200217_Layout __JT206345(__ST200124_Layout __l, __ST196741_Layout __r) := TRANSFORM
    SELF.C_O_U_N_T___Person_Address__4_ := __r.C_O_U_N_T___Person_Address_;
    SELF.U_I_D__7_ := __r.UID;
    SELF := __l;
    SELF := __r;
  END;
  SHARED __EE206369 := JOIN(__EE206318,__EE205263,__JC206345(LEFT,RIGHT),__JT206345(LEFT,RIGHT),LEFT OUTER,HASH);
  SHARED __ST196538_Layout := RECORD
    KEL.typ.ntyp(E_Customer.Typ) UID;
    KEL.typ.ntyp(E_Address.Typ) Location_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
  END;
  SHARED __EE205310 := DEDUP(PROJECT(__EE204770,TRANSFORM(__ST196538_Layout,SELF.UID := LEFT._r_Customer_,SELF := LEFT)),ALL);
  SHARED __ST196556_Layout := RECORD
    KEL.typ.int C_O_U_N_T___Person_Address_ := 0;
    KEL.typ.ntyp(E_Customer.Typ) UID;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
  END;
  SHARED __EE205323 := PROJECT(__CLEANANDDO(__EE205310,TABLE(__EE205310,{KEL.typ.int C_O_U_N_T___Person_Address_ := COUNT(GROUP),UID},UID,MERGE)),__ST196556_Layout);
  SHARED __ST200309_Layout := RECORD
    KEL.typ.nuid UID;
    KEL.typ.nint Customer_Id_;
    KEL.typ.nint Industry_Type_;
    KEL.typ.nkdate Event_Date_Max_;
    KEL.typ.int C_O_U_N_T___Person_Address_ := 0;
    KEL.typ.ntyp(E_Customer.Typ) U_I_D__1_;
    KEL.typ.int S_U_M___High_Frequency_Flag_ := 0;
    KEL.typ.ntyp(E_Customer.Typ) U_I_D__2_;
    KEL.typ.int C_O_U_N_T___Person_Address__1_ := 0;
    KEL.typ.ntyp(E_Customer.Typ) U_I_D__3_;
    KEL.typ.int C_O_U_N_T___Person_Address__2_ := 0;
    KEL.typ.ntyp(E_Customer.Typ) U_I_D__4_;
    KEL.typ.int S_U_M___High_Frequency_Flag__1_ := 0;
    KEL.typ.ntyp(E_Customer.Typ) U_I_D__5_;
    KEL.typ.int C_O_U_N_T___Person_Address__3_ := 0;
    KEL.typ.ntyp(E_Customer.Typ) U_I_D__6_;
    KEL.typ.int C_O_U_N_T___Person_Address__4_ := 0;
    KEL.typ.ntyp(E_Customer.Typ) U_I_D__7_;
    KEL.typ.int C_O_U_N_T___Person_Address__5_ := 0;
    KEL.typ.ntyp(E_Customer.Typ) U_I_D__8_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  __JC206398(__ST200217_Layout __EE206369, __ST196556_Layout __EE205323) := __EEQP(__EE206369.UID,__EE205323.UID);
  __ST200309_Layout __JT206398(__ST200217_Layout __l, __ST196556_Layout __r) := TRANSFORM
    SELF.C_O_U_N_T___Person_Address__5_ := __r.C_O_U_N_T___Person_Address_;
    SELF.U_I_D__8_ := __r.UID;
    SELF := __l;
    SELF := __r;
  END;
  SHARED __EE206424 := JOIN(__EE206369,__EE205323,__JC206398(LEFT,RIGHT),__JT206398(LEFT,RIGHT),LEFT OUTER,HASH);
  SHARED __ST196337_Layout := RECORD
    KEL.typ.ntyp(E_Customer.Typ) UID;
    KEL.typ.ntyp(E_Address.Typ) Location_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
  END;
  SHARED __EE204135 := DEDUP(PROJECT(__EE204117,TRANSFORM(__ST196337_Layout,SELF.UID := LEFT._r_Customer_,SELF := LEFT)),ALL);
  SHARED __ST196355_Layout := RECORD
    KEL.typ.int C_O_U_N_T___Person_Address_ := 0;
    KEL.typ.ntyp(E_Customer.Typ) UID;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
  END;
  SHARED __EE204148 := PROJECT(__CLEANANDDO(__EE204135,TABLE(__EE204135,{KEL.typ.int C_O_U_N_T___Person_Address_ := COUNT(GROUP),UID},UID,MERGE)),__ST196355_Layout);
  SHARED __ST200400_Layout := RECORD
    KEL.typ.nuid UID;
    KEL.typ.nint Customer_Id_;
    KEL.typ.nint Industry_Type_;
    KEL.typ.nkdate Event_Date_Max_;
    KEL.typ.int C_O_U_N_T___Person_Address_ := 0;
    KEL.typ.ntyp(E_Customer.Typ) U_I_D__1_;
    KEL.typ.int S_U_M___High_Frequency_Flag_ := 0;
    KEL.typ.ntyp(E_Customer.Typ) U_I_D__2_;
    KEL.typ.int C_O_U_N_T___Person_Address__1_ := 0;
    KEL.typ.ntyp(E_Customer.Typ) U_I_D__3_;
    KEL.typ.int C_O_U_N_T___Person_Address__2_ := 0;
    KEL.typ.ntyp(E_Customer.Typ) U_I_D__4_;
    KEL.typ.int S_U_M___High_Frequency_Flag__1_ := 0;
    KEL.typ.ntyp(E_Customer.Typ) U_I_D__5_;
    KEL.typ.int C_O_U_N_T___Person_Address__3_ := 0;
    KEL.typ.ntyp(E_Customer.Typ) U_I_D__6_;
    KEL.typ.int C_O_U_N_T___Person_Address__4_ := 0;
    KEL.typ.ntyp(E_Customer.Typ) U_I_D__7_;
    KEL.typ.int C_O_U_N_T___Person_Address__5_ := 0;
    KEL.typ.ntyp(E_Customer.Typ) U_I_D__8_;
    KEL.typ.int C_O_U_N_T___Person_Address__6_ := 0;
    KEL.typ.ntyp(E_Customer.Typ) U_I_D__9_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  __JC206455(__ST200309_Layout __EE206424, __ST196355_Layout __EE204148) := __EEQP(__EE206424.UID,__EE204148.UID);
  __ST200400_Layout __JT206455(__ST200309_Layout __l, __ST196355_Layout __r) := TRANSFORM
    SELF.C_O_U_N_T___Person_Address__6_ := __r.C_O_U_N_T___Person_Address_;
    SELF.U_I_D__9_ := __r.UID;
    SELF := __l;
    SELF := __r;
  END;
  SHARED __EE206483 := JOIN(__EE206424,__EE204148,__JC206455(LEFT,RIGHT),__JT206455(LEFT,RIGHT),LEFT OUTER,HASH);
  EXPORT __ST15368_Layout := RECORD
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
    KEL.typ.nkdate Event_Date_Max_;
    KEL.typ.int High_Frequency_Address_Count_ := 0;
    KEL.typ.int Person_Count_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  SHARED __ST15368_Layout __ND206515__Project(__ST200400_Layout __PP206484) := TRANSFORM
    SELF.Address_Count_ := __PP206484.C_O_U_N_T___Person_Address__6_;
    SELF.All_Address_Count_ := __PP206484.C_O_U_N_T___Person_Address__5_;
    SELF.All_Deceased_Matched_Person_Count_ := __PP206484.C_O_U_N_T___Person_Address__4_;
    SELF.All_Deceased_Person_Count_ := __PP206484.C_O_U_N_T___Person_Address__3_;
    SELF.All_High_Frequency_Address_Count_ := __PP206484.S_U_M___High_Frequency_Flag__1_;
    SELF.All_Person_Count_ := __PP206484.C_O_U_N_T___Person_Address__2_;
    SELF.Deceased_Person_Count_ := __PP206484.C_O_U_N_T___Person_Address__1_;
    SELF.High_Frequency_Address_Count_ := __PP206484.S_U_M___High_Frequency_Flag_;
    SELF.Person_Count_ := __PP206484.C_O_U_N_T___Person_Address_;
    SELF := __PP206484;
  END;
  EXPORT __ENH_Customer_1 := PROJECT(__EE206483,__ND206515__Project(LEFT));
END;
