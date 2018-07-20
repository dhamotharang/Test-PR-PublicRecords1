﻿//HPCC Systems KEL Compiler Version 0.11.0
IMPORT KEL011 AS KEL;
IMPORT B_Address_2,B_Person_2,E_Address,E_Customer,E_Person,E_Person_Address FROM KELOtto;
IMPORT * FROM KEL011.Null;
EXPORT B_Customer_1 := MODULE
  SHARED VIRTUAL TYPEOF(B_Address_2.__ENH_Address_2) __ENH_Address_2 := B_Address_2.__ENH_Address_2;
  SHARED VIRTUAL TYPEOF(E_Customer.__Result) __E_Customer := E_Customer.__Result;
  SHARED VIRTUAL TYPEOF(B_Person_2.__ENH_Person_2) __ENH_Person_2 := B_Person_2.__ENH_Person_2;
  SHARED VIRTUAL TYPEOF(E_Person_Address.__Result) __E_Person_Address := E_Person_Address.__Result;
  SHARED __EE97199 := __E_Customer;
  SHARED __EE104245 := __E_Person_Address;
  SHARED __EE106600 := __EE104245;
  SHARED __EE106634 := __EE106600(__NN(__EE106600._r_Customer_) AND __NN(__EE106600.Subject_));
  SHARED __EE104289 := __ENH_Person_2;
  SHARED __EE106603 := __EE104289;
  SHARED __EE106642 := __EE106603(__EE106603.In_Customer_Population_ = 1);
  __JC106650(E_Person_Address.Layout __EE106634, B_Person_2.__ST8597_Layout __EE106642) := __EEQP(__EE106634.Subject_,__EE106642.UID);
  SHARED __EE106651 := JOIN(__EE106634,__EE106642,__JC106650(LEFT,RIGHT),TRANSFORM(E_Person_Address.Layout,SELF:=LEFT),HASH,KEEP(1));
  SHARED __ST100898_Layout := RECORD
    KEL.typ.ntyp(E_Customer.Typ) UID;
    KEL.typ.ntyp(E_Person.Typ) Subject_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
  END;
  SHARED __EE106669 := DEDUP(PROJECT(__EE106651,TRANSFORM(__ST100898_Layout,SELF.UID := LEFT._r_Customer_,SELF := LEFT)),ALL);
  SHARED __ST100916_Layout := RECORD
    KEL.typ.int C_O_U_N_T___Person_Address_ := 0;
    KEL.typ.ntyp(E_Customer.Typ) UID;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
  END;
  SHARED __EE106682 := PROJECT(__CLEANANDDO(__EE106669,TABLE(__EE106669,{KEL.typ.int C_O_U_N_T___Person_Address_ := COUNT(GROUP),UID},UID,MERGE)),__ST100916_Layout);
  SHARED __ST101981_Layout := RECORD
    KEL.typ.nuid UID;
    KEL.typ.nint Customer_Id_;
    KEL.typ.nint Industry_Type_;
    KEL.typ.int C_O_U_N_T___Person_Address_ := 0;
    KEL.typ.ntyp(E_Customer.Typ) U_I_D__1_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  __JC106688(E_Customer.Layout __EE97199, __ST100916_Layout __EE106682) := __EEQP(__EE97199.UID,__EE106682.UID);
  __ST101981_Layout __JT106688(E_Customer.Layout __l, __ST100916_Layout __r) := TRANSFORM
    SELF.U_I_D__1_ := __r.UID;
    SELF := __l;
    SELF := __r;
  END;
  SHARED __EE106689 := JOIN(__EE97199,__EE106682,__JC106688(LEFT,RIGHT),__JT106688(LEFT,RIGHT),LEFT OUTER,HASH);
  SHARED __EE104247 := __ENH_Address_2;
  SHARED __EE106588 := __EE104247;
  SHARED __EE106417 := __EE104245(__NN(__EE104245._r_Customer_) AND __NN(__EE104245.Location_));
  SHARED __EE104255 := __EE104247(__EE104247.In_Customer_Population_ = 1);
  __JC106435(E_Person_Address.Layout __EE106417, B_Address_2.__ST8371_Layout __EE104255) := __EEQP(__EE106417.Location_,__EE104255.UID);
  SHARED __EE106436 := JOIN(__EE106417,__EE104255,__JC106435(LEFT,RIGHT),TRANSFORM(E_Person_Address.Layout,SELF:=LEFT),HASH,KEEP(1));
  SHARED __ST107779_Layout := RECORD
    KEL.typ.ntyp(E_Customer.Typ) _r_Customer_;
    KEL.typ.ntyp(E_Address.Typ) Location_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
  END;
  SHARED __EE107783 := DEDUP(PROJECT(__EE106436,__ST107779_Layout),ALL);
  SHARED __ST107791_Layout := RECORD
    KEL.typ.ntyp(E_Customer.Typ) _r_Customer__1_;
    KEL.typ.ntyp(E_Address.Typ) Location_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
  END;
  SHARED __EE107795 := PROJECT(__EE107783,TRANSFORM(__ST107791_Layout,SELF._r_Customer__1_ := LEFT._r_Customer_,SELF := LEFT));
  SHARED __ST107856_Layout := RECORD
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
    KEL.typ.ndataset(E_Address.Hri_List_Layout) Hri_List_;
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
  __JC107800(B_Address_2.__ST8371_Layout __EE106588, __ST107791_Layout __EE107795) := __EEQP(__EE107795.Location_,__EE106588.UID);
  __ST107856_Layout __JT107800(B_Address_2.__ST8371_Layout __l, __ST107791_Layout __r) := TRANSFORM
    SELF := __l;
    SELF := __r;
  END;
  SHARED __EE107854 := JOIN(__EE106588,__EE107795,__JC107800(LEFT,RIGHT),__JT107800(LEFT,RIGHT),INNER,HASH);
  SHARED __ST100484_Layout := RECORD
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
    KEL.typ.ndataset(E_Address.Hri_List_Layout) Hri_List_;
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
  SHARED __ST100484_Layout __ND107912__Project(__ST107856_Layout __PP107855) := TRANSFORM
    SELF.UID := __PP107855._r_Customer__1_;
    SELF.U_I_D__1_ := __PP107855.UID;
    SELF := __PP107855;
  END;
  SHARED __EE108101 := PROJECT(__EE107854,__ND107912__Project(LEFT));
  SHARED __ST100597_Layout := RECORD
    KEL.typ.ntyp(E_Customer.Typ) UID;
    KEL.typ.int High_Frequency_Flag_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
  END;
  SHARED __EE108115 := PROJECT(__EE108101,__ST100597_Layout);
  SHARED __ST100612_Layout := RECORD
    KEL.typ.int S_U_M___High_Frequency_Flag_ := 0;
    KEL.typ.ntyp(E_Customer.Typ) UID;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
  END;
  SHARED __EE108131 := PROJECT(__CLEANANDDO(__EE108115,TABLE(__EE108115,{KEL.typ.int S_U_M___High_Frequency_Flag_ := SUM(GROUP,__EE108115.High_Frequency_Flag_),UID},UID,MERGE)),__ST100612_Layout);
  SHARED __ST102072_Layout := RECORD
    KEL.typ.nuid UID;
    KEL.typ.nint Customer_Id_;
    KEL.typ.nint Industry_Type_;
    KEL.typ.int C_O_U_N_T___Person_Address_ := 0;
    KEL.typ.ntyp(E_Customer.Typ) U_I_D__1_;
    KEL.typ.int S_U_M___High_Frequency_Flag_ := 0;
    KEL.typ.ntyp(E_Customer.Typ) U_I_D__2_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  __JC108137(__ST101981_Layout __EE106689, __ST100612_Layout __EE108131) := __EEQP(__EE106689.UID,__EE108131.UID);
  __ST102072_Layout __JT108137(__ST101981_Layout __l, __ST100612_Layout __r) := TRANSFORM
    SELF.U_I_D__2_ := __r.UID;
    SELF := __l;
    SELF := __r;
  END;
  SHARED __EE108148 := JOIN(__EE106689,__EE108131,__JC108137(LEFT,RIGHT),__JT108137(LEFT,RIGHT),LEFT OUTER,HASH);
  SHARED __EE107008 := __EE106634;
  SHARED __EE106585 := __EE104289;
  SHARED __EE107020 := __EE106585(__EE106585.In_Customer_Population_ = 1 AND __EE106585.Deceased_ = 1);
  __JC107028(E_Person_Address.Layout __EE107008, B_Person_2.__ST8597_Layout __EE107020) := __EEQP(__EE107008.Subject_,__EE107020.UID);
  SHARED __EE107029 := JOIN(__EE107008,__EE107020,__JC107028(LEFT,RIGHT),TRANSFORM(E_Person_Address.Layout,SELF:=LEFT),HASH,KEEP(1));
  SHARED __ST100126_Layout := RECORD
    KEL.typ.ntyp(E_Customer.Typ) UID;
    KEL.typ.ntyp(E_Person.Typ) Subject_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
  END;
  SHARED __EE107047 := DEDUP(PROJECT(__EE107029,TRANSFORM(__ST100126_Layout,SELF.UID := LEFT._r_Customer_,SELF := LEFT)),ALL);
  SHARED __ST100144_Layout := RECORD
    KEL.typ.int C_O_U_N_T___Person_Address_ := 0;
    KEL.typ.ntyp(E_Customer.Typ) UID;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
  END;
  SHARED __EE107060 := PROJECT(__CLEANANDDO(__EE107047,TABLE(__EE107047,{KEL.typ.int C_O_U_N_T___Person_Address_ := COUNT(GROUP),UID},UID,MERGE)),__ST100144_Layout);
  SHARED __ST102162_Layout := RECORD
    KEL.typ.nuid UID;
    KEL.typ.nint Customer_Id_;
    KEL.typ.nint Industry_Type_;
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
  __JC108164(__ST102072_Layout __EE108148, __ST100144_Layout __EE107060) := __EEQP(__EE108148.UID,__EE107060.UID);
  __ST102162_Layout __JT108164(__ST102072_Layout __l, __ST100144_Layout __r) := TRANSFORM
    SELF.C_O_U_N_T___Person_Address__1_ := __r.C_O_U_N_T___Person_Address_;
    SELF.U_I_D__3_ := __r.UID;
    SELF := __l;
    SELF := __r;
  END;
  SHARED __EE108179 := JOIN(__EE108148,__EE107060,__JC108164(LEFT,RIGHT),__JT108164(LEFT,RIGHT),LEFT OUTER,HASH);
  SHARED __EE106558 := __EE104245;
  SHARED __EE107092 := __EE106558(__NN(__EE106558._r_Customer_));
  SHARED __EE107095 := __EE107092;
  SHARED __ST99933_Layout := RECORD
    KEL.typ.ntyp(E_Customer.Typ) UID;
    KEL.typ.ntyp(E_Person.Typ) Subject_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
  END;
  SHARED __EE107109 := DEDUP(PROJECT(__EE107095,TRANSFORM(__ST99933_Layout,SELF.UID := LEFT._r_Customer_,SELF := LEFT)),ALL);
  SHARED __ST99951_Layout := RECORD
    KEL.typ.int C_O_U_N_T___Person_Address_ := 0;
    KEL.typ.ntyp(E_Customer.Typ) UID;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
  END;
  SHARED __EE107122 := PROJECT(__CLEANANDDO(__EE107109,TABLE(__EE107109,{KEL.typ.int C_O_U_N_T___Person_Address_ := COUNT(GROUP),UID},UID,MERGE)),__ST99951_Layout);
  SHARED __ST102253_Layout := RECORD
    KEL.typ.nuid UID;
    KEL.typ.nint Customer_Id_;
    KEL.typ.nint Industry_Type_;
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
  __JC108199(__ST102162_Layout __EE108179, __ST99951_Layout __EE107122) := __EEQP(__EE108179.UID,__EE107122.UID);
  __ST102253_Layout __JT108199(__ST102162_Layout __l, __ST99951_Layout __r) := TRANSFORM
    SELF.C_O_U_N_T___Person_Address__2_ := __r.C_O_U_N_T___Person_Address_;
    SELF.U_I_D__4_ := __r.UID;
    SELF := __l;
    SELF := __r;
  END;
  SHARED __EE108216 := JOIN(__EE108179,__EE107122,__JC108199(LEFT,RIGHT),__JT108199(LEFT,RIGHT),LEFT OUTER,HASH);
  SHARED __EE106570 := __EE104247;
  SHARED __ST108240_Layout := RECORD
    KEL.typ.ntyp(E_Customer.Typ) _r_Customer_;
    KEL.typ.ntyp(E_Address.Typ) Location_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  SHARED __EE108244 := PROJECT(TABLE(PROJECT(__EE106417,__ST108240_Layout),{KEL.typ.int __RecordCount := SUM(GROUP,__RecordCount),KEL.typ.epoch Date_First_Seen_ := KEL.era.SimpleRoll(GROUP,Date_First_Seen_,MIN,TRUE),KEL.typ.epoch Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Date_Last_Seen_,MAX,FALSE),_r_Customer_,Location_},_r_Customer_,Location_,MERGE),__ST108240_Layout);
  SHARED __ST108252_Layout := RECORD
    KEL.typ.ntyp(E_Customer.Typ) _r_Customer__1_;
    KEL.typ.ntyp(E_Address.Typ) Location_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
  END;
  SHARED __EE108256 := PROJECT(__EE108244,TRANSFORM(__ST108252_Layout,SELF._r_Customer__1_ := LEFT._r_Customer_,SELF := LEFT));
  SHARED __ST108317_Layout := RECORD
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
    KEL.typ.ndataset(E_Address.Hri_List_Layout) Hri_List_;
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
  __JC108261(B_Address_2.__ST8371_Layout __EE106570, __ST108252_Layout __EE108256) := __EEQP(__EE108256.Location_,__EE106570.UID);
  __ST108317_Layout __JT108261(B_Address_2.__ST8371_Layout __l, __ST108252_Layout __r) := TRANSFORM
    SELF := __l;
    SELF := __r;
  END;
  SHARED __EE108315 := JOIN(__EE108256,__EE106570,__JC108261(RIGHT,LEFT),__JT108261(RIGHT,LEFT),INNER,HASH);
  SHARED __ST99549_Layout := RECORD
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
    KEL.typ.ndataset(E_Address.Hri_List_Layout) Hri_List_;
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
  SHARED __ST99549_Layout __ND108373__Project(__ST108317_Layout __PP108316) := TRANSFORM
    SELF.UID := __PP108316._r_Customer__1_;
    SELF.U_I_D__1_ := __PP108316.UID;
    SELF := __PP108316;
  END;
  SHARED __EE108562 := PROJECT(__EE108315,__ND108373__Project(LEFT));
  SHARED __ST99662_Layout := RECORD
    KEL.typ.ntyp(E_Customer.Typ) UID;
    KEL.typ.int High_Frequency_Flag_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
  END;
  SHARED __EE108576 := PROJECT(__EE108562,__ST99662_Layout);
  SHARED __ST99677_Layout := RECORD
    KEL.typ.int S_U_M___High_Frequency_Flag_ := 0;
    KEL.typ.ntyp(E_Customer.Typ) UID;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
  END;
  SHARED __EE108592 := PROJECT(__CLEANANDDO(__EE108576,TABLE(__EE108576,{KEL.typ.int S_U_M___High_Frequency_Flag_ := SUM(GROUP,__EE108576.High_Frequency_Flag_),UID},UID,MERGE)),__ST99677_Layout);
  SHARED __ST102343_Layout := RECORD
    KEL.typ.nuid UID;
    KEL.typ.nint Customer_Id_;
    KEL.typ.nint Industry_Type_;
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
  __JC108600(__ST102253_Layout __EE108216, __ST99677_Layout __EE108592) := __EEQP(__EE108216.UID,__EE108592.UID);
  __ST102343_Layout __JT108600(__ST102253_Layout __l, __ST99677_Layout __r) := TRANSFORM
    SELF.S_U_M___High_Frequency_Flag__1_ := __r.S_U_M___High_Frequency_Flag_;
    SELF.U_I_D__5_ := __r.UID;
    SELF := __l;
    SELF := __r;
  END;
  SHARED __EE108619 := JOIN(__EE108216,__EE108592,__JC108600(LEFT,RIGHT),__JT108600(LEFT,RIGHT),LEFT OUTER,HASH);
  SHARED __EE107466 := __EE106634;
  SHARED __EE106567 := __EE104289;
  SHARED __EE107474 := __EE106567(__EE106567.Deceased_ = 1);
  __JC107482(E_Person_Address.Layout __EE107466, B_Person_2.__ST8597_Layout __EE107474) := __EEQP(__EE107466.Subject_,__EE107474.UID);
  SHARED __EE107483 := JOIN(__EE107466,__EE107474,__JC107482(LEFT,RIGHT),TRANSFORM(E_Person_Address.Layout,SELF:=LEFT),HASH,KEEP(1));
  SHARED __ST99219_Layout := RECORD
    KEL.typ.ntyp(E_Customer.Typ) UID;
    KEL.typ.ntyp(E_Person.Typ) Subject_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
  END;
  SHARED __EE107501 := DEDUP(PROJECT(__EE107483,TRANSFORM(__ST99219_Layout,SELF.UID := LEFT._r_Customer_,SELF := LEFT)),ALL);
  SHARED __ST99237_Layout := RECORD
    KEL.typ.int C_O_U_N_T___Person_Address_ := 0;
    KEL.typ.ntyp(E_Customer.Typ) UID;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
  END;
  SHARED __EE107514 := PROJECT(__CLEANANDDO(__EE107501,TABLE(__EE107501,{KEL.typ.int C_O_U_N_T___Person_Address_ := COUNT(GROUP),UID},UID,MERGE)),__ST99237_Layout);
  SHARED __ST102432_Layout := RECORD
    KEL.typ.nuid UID;
    KEL.typ.nint Customer_Id_;
    KEL.typ.nint Industry_Type_;
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
  __JC108643(__ST102343_Layout __EE108619, __ST99237_Layout __EE107514) := __EEQP(__EE108619.UID,__EE107514.UID);
  __ST102432_Layout __JT108643(__ST102343_Layout __l, __ST99237_Layout __r) := TRANSFORM
    SELF.C_O_U_N_T___Person_Address__3_ := __r.C_O_U_N_T___Person_Address_;
    SELF.U_I_D__6_ := __r.UID;
    SELF := __l;
    SELF := __r;
  END;
  SHARED __EE108664 := JOIN(__EE108619,__EE107514,__JC108643(LEFT,RIGHT),__JT108643(LEFT,RIGHT),LEFT OUTER,HASH);
  SHARED __EE107547 := __EE106634;
  SHARED __EE104297 := __EE104289(__EE104289.Deceased_Match_ = 1);
  __JC107553(E_Person_Address.Layout __EE107547, B_Person_2.__ST8597_Layout __EE104297) := __EEQP(__EE107547.Subject_,__EE104297.UID);
  SHARED __EE107554 := JOIN(__EE107547,__EE104297,__JC107553(LEFT,RIGHT),TRANSFORM(E_Person_Address.Layout,SELF:=LEFT),HASH,KEEP(1));
  SHARED __ST99007_Layout := RECORD
    KEL.typ.ntyp(E_Customer.Typ) UID;
    KEL.typ.ntyp(E_Customer.Typ) _r_Customer_;
    KEL.typ.ntyp(E_Person.Typ) Subject_;
    KEL.typ.ntyp(E_Address.Typ) Location_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
  END;
  SHARED __EE107580 := PROJECT(__EE107554,TRANSFORM(__ST99007_Layout,SELF.UID := LEFT._r_Customer_,SELF := LEFT));
  SHARED __ST99029_Layout := RECORD
    KEL.typ.int C_O_U_N_T___Person_Address_ := 0;
    KEL.typ.ntyp(E_Customer.Typ) UID;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
  END;
  SHARED __EE107593 := PROJECT(__CLEANANDDO(__EE107580,TABLE(__EE107580,{KEL.typ.int C_O_U_N_T___Person_Address_ := COUNT(GROUP),UID},UID,MERGE)),__ST99029_Layout);
  SHARED __ST102520_Layout := RECORD
    KEL.typ.nuid UID;
    KEL.typ.nint Customer_Id_;
    KEL.typ.nint Industry_Type_;
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
  __JC108690(__ST102432_Layout __EE108664, __ST99029_Layout __EE107593) := __EEQP(__EE108664.UID,__EE107593.UID);
  __ST102520_Layout __JT108690(__ST102432_Layout __l, __ST99029_Layout __r) := TRANSFORM
    SELF.C_O_U_N_T___Person_Address__4_ := __r.C_O_U_N_T___Person_Address_;
    SELF.U_I_D__7_ := __r.UID;
    SELF := __l;
    SELF := __r;
  END;
  SHARED __EE108713 := JOIN(__EE108664,__EE107593,__JC108690(LEFT,RIGHT),__JT108690(LEFT,RIGHT),LEFT OUTER,HASH);
  SHARED __ST98828_Layout := RECORD
    KEL.typ.ntyp(E_Customer.Typ) UID;
    KEL.typ.ntyp(E_Address.Typ) Location_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
  END;
  SHARED __EE107639 := DEDUP(PROJECT(__EE107092,TRANSFORM(__ST98828_Layout,SELF.UID := LEFT._r_Customer_,SELF := LEFT)),ALL);
  SHARED __ST98846_Layout := RECORD
    KEL.typ.int C_O_U_N_T___Person_Address_ := 0;
    KEL.typ.ntyp(E_Customer.Typ) UID;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
  END;
  SHARED __EE107652 := PROJECT(__CLEANANDDO(__EE107639,TABLE(__EE107639,{KEL.typ.int C_O_U_N_T___Person_Address_ := COUNT(GROUP),UID},UID,MERGE)),__ST98846_Layout);
  SHARED __ST102607_Layout := RECORD
    KEL.typ.nuid UID;
    KEL.typ.nint Customer_Id_;
    KEL.typ.nint Industry_Type_;
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
  __JC108741(__ST102520_Layout __EE108713, __ST98846_Layout __EE107652) := __EEQP(__EE108713.UID,__EE107652.UID);
  __ST102607_Layout __JT108741(__ST102520_Layout __l, __ST98846_Layout __r) := TRANSFORM
    SELF.C_O_U_N_T___Person_Address__5_ := __r.C_O_U_N_T___Person_Address_;
    SELF.U_I_D__8_ := __r.UID;
    SELF := __l;
    SELF := __r;
  END;
  SHARED __EE108766 := JOIN(__EE108713,__EE107652,__JC108741(LEFT,RIGHT),__JT108741(LEFT,RIGHT),LEFT OUTER,HASH);
  SHARED __ST98630_Layout := RECORD
    KEL.typ.ntyp(E_Customer.Typ) UID;
    KEL.typ.ntyp(E_Address.Typ) Location_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
  END;
  SHARED __EE106454 := DEDUP(PROJECT(__EE106436,TRANSFORM(__ST98630_Layout,SELF.UID := LEFT._r_Customer_,SELF := LEFT)),ALL);
  SHARED __ST98648_Layout := RECORD
    KEL.typ.int C_O_U_N_T___Person_Address_ := 0;
    KEL.typ.ntyp(E_Customer.Typ) UID;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
  END;
  SHARED __EE106467 := PROJECT(__CLEANANDDO(__EE106454,TABLE(__EE106454,{KEL.typ.int C_O_U_N_T___Person_Address_ := COUNT(GROUP),UID},UID,MERGE)),__ST98648_Layout);
  SHARED __ST102693_Layout := RECORD
    KEL.typ.nuid UID;
    KEL.typ.nint Customer_Id_;
    KEL.typ.nint Industry_Type_;
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
  __JC108796(__ST102607_Layout __EE108766, __ST98648_Layout __EE106467) := __EEQP(__EE108766.UID,__EE106467.UID);
  __ST102693_Layout __JT108796(__ST102607_Layout __l, __ST98648_Layout __r) := TRANSFORM
    SELF.C_O_U_N_T___Person_Address__6_ := __r.C_O_U_N_T___Person_Address_;
    SELF.U_I_D__9_ := __r.UID;
    SELF := __l;
    SELF := __r;
  END;
  SHARED __EE108823 := JOIN(__EE108766,__EE106467,__JC108796(LEFT,RIGHT),__JT108796(LEFT,RIGHT),LEFT OUTER,HASH);
  EXPORT __ST7915_Layout := RECORD
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
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  SHARED __ST7915_Layout __ND108854__Project(__ST102693_Layout __PP108824) := TRANSFORM
    SELF.Address_Count_ := __PP108824.C_O_U_N_T___Person_Address__6_;
    SELF.All_Address_Count_ := __PP108824.C_O_U_N_T___Person_Address__5_;
    SELF.All_Deceased_Matched_Person_Count_ := __PP108824.C_O_U_N_T___Person_Address__4_;
    SELF.All_Deceased_Person_Count_ := __PP108824.C_O_U_N_T___Person_Address__3_;
    SELF.All_High_Frequency_Address_Count_ := __PP108824.S_U_M___High_Frequency_Flag__1_;
    SELF.All_Person_Count_ := __PP108824.C_O_U_N_T___Person_Address__2_;
    SELF.Deceased_Person_Count_ := __PP108824.C_O_U_N_T___Person_Address__1_;
    SELF.High_Frequency_Address_Count_ := __PP108824.S_U_M___High_Frequency_Flag_;
    SELF.Person_Count_ := __PP108824.C_O_U_N_T___Person_Address_;
    SELF := __PP108824;
  END;
  EXPORT __ENH_Customer_1 := PROJECT(__EE108823,__ND108854__Project(LEFT));
END;
