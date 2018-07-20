﻿//HPCC Systems KEL Compiler Version 0.11.0
IMPORT KEL011 AS KEL;
IMPORT B_Address,B_Customer_Address,E_Address,E_Customer,E_Customer_Address FROM KELOtto;
IMPORT * FROM KEL011.Null;
EXPORT RQ__show_Customer_Address_Graph_Entities := MODULE
  SHARED __EE100367 := B_Customer_Address.IDX_Customer_Address_Location__Wrapped;
  SHARED __ST100445_Layout := RECORD
    KEL.typ.ntyp(E_Address.Typ) Location_;
    KEL.typ.nstr Full_Address_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  SHARED __EE100449 := PROJECT(TABLE(PROJECT(__EE100367,__ST100445_Layout),{KEL.typ.int __RecordCount := SUM(GROUP,__RecordCount),KEL.typ.epoch Date_First_Seen_ := KEL.era.SimpleRoll(GROUP,Date_First_Seen_,MIN,TRUE),KEL.typ.epoch Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Date_Last_Seen_,MAX,FALSE),Location_,Full_Address_},Location_,Full_Address_,MERGE),__ST100445_Layout);
  SHARED __EE100370 := B_Address.IDX_Address_UID_Wrapped;
  SHARED __ST100513_Layout := RECORD
    KEL.typ.nuid UID;
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
    KEL.typ.nint Z_I_P_;
    KEL.typ.nint Z_I_P4_;
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
    KEL.typ.nunk Entity_Context_Uid_;
    KEL.typ.nstr Full_Address__1_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
  END;
  SHARED __EE100545 := PROJECT(__EE100370,TRANSFORM(__ST100513_Layout,SELF.Full_Address__1_ := LEFT.Full_Address_,SELF := LEFT));
  SHARED __ST100589_Layout := RECORD
    KEL.typ.ntyp(E_Address.Typ) Location_;
    KEL.typ.nstr Full_Address_;
    KEL.typ.nuid UID;
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
    KEL.typ.nint Z_I_P_;
    KEL.typ.nint Z_I_P4_;
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
    KEL.typ.nunk Entity_Context_Uid_;
    KEL.typ.nstr Full_Address__1_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  __JC100552(__ST100445_Layout __EE100449, __ST100513_Layout __EE100545) := __EEQP(__EE100449.Location_,__EE100545.UID);
  __ST100589_Layout __JT100552(__ST100445_Layout __l, __ST100513_Layout __r) := TRANSFORM
    SELF := __l;
    SELF := __r;
  END;
  SHARED __EE100587 := JOIN(__EE100449,__EE100545,__JC100552(LEFT,RIGHT),__JT100552(LEFT,RIGHT),LEFT OUTER,HASH);
  SHARED __ST97889_Layout := RECORD
    KEL.typ.nunk Entity_Context_Uid_;
    KEL.typ.nstr Label_;
    KEL.typ.int Entity_Type_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  SHARED __ST97889_Layout __ND100626__Project(__ST100589_Layout __PP100588) := TRANSFORM
    SELF.Label_ := __PP100588.Full_Address_;
    SELF.Entity_Type_ := 15;
    SELF := __PP100588;
  END;
  EXPORT Res0 := __UNWRAP(PROJECT(TABLE(PROJECT(__EE100587,__ND100626__Project(LEFT)),{KEL.typ.int __RecordCount := SUM(GROUP,__RecordCount),KEL.typ.epoch Date_First_Seen_ := KEL.era.SimpleRoll(GROUP,Date_First_Seen_,MIN,TRUE),KEL.typ.epoch Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Date_Last_Seen_,MAX,FALSE),Entity_Context_Uid_,Label_,Entity_Type_},Entity_Context_Uid_,Label_,Entity_Type_,MERGE),__ST97889_Layout));
END;
