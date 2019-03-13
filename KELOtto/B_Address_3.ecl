﻿//HPCC Systems KEL Compiler Version 0.11.0
IMPORT KEL011 AS KEL;
IMPORT B_Person_4,E_Address,E_Customer,E_Person,E_Person_Address FROM KELOtto;
IMPORT * FROM KEL011.Null;
EXPORT B_Address_3 := MODULE
  SHARED VIRTUAL TYPEOF(E_Address.__Result) __E_Address := E_Address.__Result;
  SHARED VIRTUAL TYPEOF(B_Person_4.__ENH_Person_4) __ENH_Person_4 := B_Person_4.__ENH_Person_4;
  SHARED VIRTUAL TYPEOF(E_Person_Address.__Result) __E_Person_Address := E_Person_Address.__Result;
  SHARED __EE54943 := __E_Address;
  SHARED __EE55094 := __E_Person_Address;
  SHARED __EE56190 := __EE55094(__NN(__EE55094.Location_) AND __NN(__EE55094.Subject_));
  SHARED __EE55110 := __ENH_Person_4;
  SHARED __EE55358 := __EE55110(__EE55110.In_Customer_Population_ = 1);
  __JC56208(E_Person_Address.Layout __EE56190, B_Person_4.__ST18143_Layout __EE55358) := __EEQP(__EE56190.Subject_,__EE55358.UID);
  SHARED __EE56209 := JOIN(__EE56190,__EE55358,__JC56208(LEFT,RIGHT),TRANSFORM(E_Person_Address.Layout,SELF:=LEFT),HASH,KEEP(1));
  SHARED __ST55262_Layout := RECORD
    KEL.typ.ntyp(E_Address.Typ) UID;
    KEL.typ.ntyp(E_Customer.Typ) _r_Customer_;
    KEL.typ.ntyp(E_Person.Typ) Subject_;
    KEL.typ.ntyp(E_Address.Typ) Location_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
  END;
  SHARED __EE56235 := PROJECT(__EE56209,TRANSFORM(__ST55262_Layout,SELF.UID := LEFT.Location_,SELF := LEFT));
  SHARED __ST55284_Layout := RECORD
    KEL.typ.int C_O_U_N_T___Person_Address_ := 0;
    KEL.typ.ntyp(E_Address.Typ) UID;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
  END;
  SHARED __EE56248 := PROJECT(__CLEANANDDO(__EE56235,TABLE(__EE56235,{KEL.typ.int C_O_U_N_T___Person_Address_ := COUNT(GROUP),UID},UID,MERGE)),__ST55284_Layout);
  SHARED __ST55570_Layout := RECORD
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
    KEL.typ.int C_O_U_N_T___Person_Address_ := 0;
    KEL.typ.ntyp(E_Address.Typ) U_I_D__1_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  __JC56254(E_Address.Layout __EE54943, __ST55284_Layout __EE56248) := __EEQP(__EE54943.UID,__EE56248.UID);
  __ST55570_Layout __JT56254(E_Address.Layout __l, __ST55284_Layout __r) := TRANSFORM
    SELF.U_I_D__1_ := __r.UID;
    SELF := __l;
    SELF := __r;
  END;
  SHARED __EE56255 := JOIN(__EE54943,__EE56248,__JC56254(LEFT,RIGHT),__JT56254(LEFT,RIGHT),LEFT OUTER,HASH);
  EXPORT __ST17223_Layout := RECORD
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
    KEL.typ.int Identity_Count_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  EXPORT __ENH_Address_3 := PROJECT(__EE56255,TRANSFORM(__ST17223_Layout,SELF.Identity_Count_ := LEFT.C_O_U_N_T___Person_Address_,SELF := LEFT));
END;
