//HPCC Systems KEL Compiler Version 0.11.0
IMPORT KEL011 AS KEL;
IMPORT B_Customer_Address_3,B_Customer_Address_Person_3,E_Address,E_Customer,E_Person FROM KELOtto;
IMPORT * FROM KEL011.Null;
EXPORT B_Customer_Address_2 := MODULE
  SHARED VIRTUAL TYPEOF(B_Customer_Address_3.__ENH_Customer_Address_3) __ENH_Customer_Address_3 := B_Customer_Address_3.__ENH_Customer_Address_3;
  SHARED VIRTUAL TYPEOF(B_Customer_Address_Person_3.__ENH_Customer_Address_Person_3) __ENH_Customer_Address_Person_3 := B_Customer_Address_Person_3.__ENH_Customer_Address_Person_3;
  SHARED __EE29379 := __ENH_Customer_Address_3;
  SHARED __EE29415 := __ENH_Customer_Address_Person_3;
  SHARED __EE31490 := __EE29415;
  SHARED __EE32215 := __EE31490(__T(__AND(__OP2(__EE31490.Source_Customer_,=,__EE31490.Associated_Customer_),__CN(__NN(__EE31490.Location_) AND __NN(__EE31490.Source_Customer_) AND __NN(__EE31490.Location_)))));
  SHARED __EE29953 := __EE29379;
  SHARED __EE31177 := __EE29953(__NN(__EE29953.Location_) AND __NN(__EE29953.Source_Customer_));
  SHARED __ST31849_Layout := RECORD
    KEL.typ.ntyp(E_Customer.Typ) Source_Customer__1_;
    KEL.typ.ntyp(E_Address.Typ) Location__1_;
    KEL.typ.int Person_Count_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
  END;
  SHARED __ST31849_Layout __ND31842__Project(B_Customer_Address_3.__ST3923_Layout __PP31841) := TRANSFORM
    SELF.Source_Customer__1_ := __PP31841.Source_Customer_;
    SELF.Location__1_ := __PP31841.Location_;
    SELF := __PP31841;
  END;
  SHARED __EE31854 := PROJECT(__EE31177,__ND31842__Project(LEFT));
  SHARED __ST31870_Layout := RECORD
    KEL.typ.ntyp(E_Customer.Typ) Source_Customer_;
    KEL.typ.ntyp(E_Customer.Typ) Associated_Customer_;
    KEL.typ.ntyp(E_Person.Typ) Subject_;
    KEL.typ.ntyp(E_Address.Typ) Location_;
    KEL.typ.nint Event_Count_;
    KEL.typ.nint High_Risk_Death_Prior_To_All_Events_;
    KEL.typ.ntyp(E_Customer.Typ) Source_Customer__1_;
    KEL.typ.ntyp(E_Address.Typ) Location__1_;
    KEL.typ.int Person_Count_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  __JC32229(B_Customer_Address_Person_3.__ST3935_Layout __EE32215, __ST31849_Layout __EE31854) := __NNEQ(__EE32215.Location_,__EE31854.Location__1_) AND __NNEQ(__EE32215.Source_Customer_,__EE31854.Source_Customer__1_) AND __EEQP(__EE31854.Location__1_,__EE32215.Location_) AND __T(__AND(__OP2(__EE32215.Location_,=,__EE31854.Location__1_),__AND(__OP2(__EE32215.Source_Customer_,=,__EE31854.Source_Customer__1_),__EEQ(__EE31854.Location__1_,__EE32215.Location_))));
  __ST31870_Layout __JT32229(B_Customer_Address_Person_3.__ST3935_Layout __l, __ST31849_Layout __r) := TRANSFORM
    SELF := __l;
    SELF := __r;
  END;
  SHARED __EE32240 := JOIN(__EE31854,__EE32215,__JC32229(RIGHT,LEFT),__JT32229(RIGHT,LEFT),INNER,HASH);
  SHARED __ST30008_Layout := RECORD
    KEL.typ.ntyp(E_Address.Typ) Location_;
    KEL.typ.ntyp(E_Customer.Typ) Source_Customer_;
    KEL.typ.ntyp(E_Person.Typ) Subject_;
    KEL.typ.nint High_Risk_Death_Prior_To_All_Events_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
  END;
  SHARED __ST30008_Layout __ND32245__Project(__ST31870_Layout __PP32241) := TRANSFORM
    SELF.Location_ := __PP32241.Location__1_;
    SELF.Source_Customer_ := __PP32241.Source_Customer__1_;
    SELF := __PP32241;
  END;
  SHARED __EE32262 := DEDUP(PROJECT(__EE32240,__ND32245__Project(LEFT)),ALL);
  SHARED __ST30031_Layout := RECORD
    KEL.typ.ntyp(E_Address.Typ) Location_;
    KEL.typ.ntyp(E_Customer.Typ) Source_Customer_;
    KEL.typ.nint High_Risk_Death_Prior_To_All_Events_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
  END;
  SHARED __EE32280 := PROJECT(__EE32262,__ST30031_Layout);
  SHARED __ST30050_Layout := RECORD
    KEL.typ.int S_U_M___High_Risk_Death_Prior_To_All_Events_ := 0;
    KEL.typ.ntyp(E_Address.Typ) Location_;
    KEL.typ.ntyp(E_Customer.Typ) Source_Customer_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
  END;
  SHARED __EE32300 := PROJECT(__CLEANANDDO(__EE32280,TABLE(__EE32280,{KEL.typ.int S_U_M___High_Risk_Death_Prior_To_All_Events_ := KEL.Aggregates.SumNG(__EE32280.High_Risk_Death_Prior_To_All_Events_),Location_,Source_Customer_},Location_,Source_Customer_,MERGE)),__ST30050_Layout);
  SHARED __ST30355_Layout := RECORD
    KEL.typ.ntyp(E_Customer.Typ) Source_Customer_;
    KEL.typ.ntyp(E_Address.Typ) Location_;
    KEL.typ.int Person_Count_ := 0;
    KEL.typ.int S_U_M___High_Risk_Death_Prior_To_All_Events_ := 0;
    KEL.typ.ntyp(E_Address.Typ) Location__1_;
    KEL.typ.ntyp(E_Customer.Typ) Source_Customer__1_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  __JC32310(B_Customer_Address_3.__ST3923_Layout __EE29379, __ST30050_Layout __EE32300) := __EEQP(__EE29379.Source_Customer_,__EE32300.Source_Customer_) AND __EEQP(__EE29379.Location_,__EE32300.Location_);
  __ST30355_Layout __JT32310(B_Customer_Address_3.__ST3923_Layout __l, __ST30050_Layout __r) := TRANSFORM
    SELF.Location__1_ := __r.Location_;
    SELF.Source_Customer__1_ := __r.Source_Customer_;
    SELF := __l;
    SELF := __r;
  END;
  SHARED __EE32322 := JOIN(__EE29379,__EE32300,__JC32310(LEFT,RIGHT),__JT32310(LEFT,RIGHT),LEFT OUTER,hash);
  SHARED __EE30991 := __EE29415(__NN(__EE29415.Location_) AND __NN(__EE29415.Associated_Customer_) AND __NN(__EE29415.Location_));
  SHARED __EE31493 := __EE31177;
  SHARED __ST32042_Layout := RECORD
    KEL.typ.ntyp(E_Customer.Typ) Source_Customer__1_;
    KEL.typ.ntyp(E_Address.Typ) Location__1_;
    KEL.typ.int Person_Count_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
  END;
  SHARED __ST32042_Layout __ND32035__Project(B_Customer_Address_3.__ST3923_Layout __PP32034) := TRANSFORM
    SELF.Source_Customer__1_ := __PP32034.Source_Customer_;
    SELF.Location__1_ := __PP32034.Location_;
    SELF := __PP32034;
  END;
  SHARED __EE32047 := PROJECT(__EE31493,__ND32035__Project(LEFT));
  SHARED __ST32063_Layout := RECORD
    KEL.typ.ntyp(E_Customer.Typ) Source_Customer_;
    KEL.typ.ntyp(E_Customer.Typ) Associated_Customer_;
    KEL.typ.ntyp(E_Person.Typ) Subject_;
    KEL.typ.ntyp(E_Address.Typ) Location_;
    KEL.typ.nint Event_Count_;
    KEL.typ.nint High_Risk_Death_Prior_To_All_Events_;
    KEL.typ.ntyp(E_Customer.Typ) Source_Customer__1_;
    KEL.typ.ntyp(E_Address.Typ) Location__1_;
    KEL.typ.int Person_Count_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  __JC32060(B_Customer_Address_Person_3.__ST3935_Layout __EE30991, __ST32042_Layout __EE32047) := __NNEQ(__EE30991.Location_,__EE32047.Location__1_) AND __NNEQ(__EE30991.Associated_Customer_,__EE32047.Source_Customer__1_) AND __EEQP(__EE32047.Location__1_,__EE30991.Location_) AND __T(__AND(__OP2(__EE30991.Location_,=,__EE32047.Location__1_),__AND(__OP2(__EE30991.Associated_Customer_,=,__EE32047.Source_Customer__1_),__EEQ(__EE32047.Location__1_,__EE30991.Location_))));
  __ST32063_Layout __JT32060(B_Customer_Address_Person_3.__ST3935_Layout __l, __ST32042_Layout __r) := TRANSFORM
    SELF := __l;
    SELF := __r;
  END;
  SHARED __EE32061 := JOIN(__EE30991,__EE32047,__JC32060(LEFT,RIGHT),__JT32060(LEFT,RIGHT),INNER,HASH);
  SHARED __ST29775_Layout := RECORD
    KEL.typ.ntyp(E_Address.Typ) Location_;
    KEL.typ.ntyp(E_Customer.Typ) Source_Customer_;
    KEL.typ.ntyp(E_Person.Typ) Subject_;
    KEL.typ.nint High_Risk_Death_Prior_To_All_Events_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
  END;
  SHARED __ST29775_Layout __ND32077__Project(__ST32063_Layout __PP32062) := TRANSFORM
    SELF.Location_ := __PP32062.Location__1_;
    SELF.Source_Customer_ := __PP32062.Source_Customer__1_;
    SELF := __PP32062;
  END;
  SHARED __EE32094 := DEDUP(PROJECT(__EE32061,__ND32077__Project(LEFT)),ALL);
  SHARED __ST29798_Layout := RECORD
    KEL.typ.ntyp(E_Address.Typ) Location_;
    KEL.typ.ntyp(E_Customer.Typ) Source_Customer_;
    KEL.typ.nint High_Risk_Death_Prior_To_All_Events_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
  END;
  SHARED __EE32112 := PROJECT(__EE32094,__ST29798_Layout);
  SHARED __ST29817_Layout := RECORD
    KEL.typ.int S_U_M___High_Risk_Death_Prior_To_All_Events_ := 0;
    KEL.typ.ntyp(E_Address.Typ) Location_;
    KEL.typ.ntyp(E_Customer.Typ) Source_Customer_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
  END;
  SHARED __EE32132 := PROJECT(__CLEANANDDO(__EE32112,TABLE(__EE32112,{KEL.typ.int S_U_M___High_Risk_Death_Prior_To_All_Events_ := KEL.Aggregates.SumNG(__EE32112.High_Risk_Death_Prior_To_All_Events_),Location_,Source_Customer_},Location_,Source_Customer_,MERGE)),__ST29817_Layout);
  SHARED __ST30410_Layout := RECORD
    KEL.typ.ntyp(E_Customer.Typ) Source_Customer_;
    KEL.typ.ntyp(E_Address.Typ) Location_;
    KEL.typ.int Person_Count_ := 0;
    KEL.typ.int S_U_M___High_Risk_Death_Prior_To_All_Events_ := 0;
    KEL.typ.ntyp(E_Address.Typ) Location__1_;
    KEL.typ.ntyp(E_Customer.Typ) Source_Customer__1_;
    KEL.typ.int S_U_M___High_Risk_Death_Prior_To_All_Events__1_ := 0;
    KEL.typ.ntyp(E_Address.Typ) Location__2_;
    KEL.typ.ntyp(E_Customer.Typ) Source_Customer__2_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  __JC32332(__ST30355_Layout __EE32322, __ST29817_Layout __EE32132) := __EEQP(__EE32322.Location_,__EE32132.Location_) AND __EEQP(__EE32322.Source_Customer_,__EE32132.Source_Customer_);
  __ST30410_Layout __JT32332(__ST30355_Layout __l, __ST29817_Layout __r) := TRANSFORM
    SELF.S_U_M___High_Risk_Death_Prior_To_All_Events__1_ := __r.S_U_M___High_Risk_Death_Prior_To_All_Events_;
    SELF.Location__2_ := __r.Location_;
    SELF.Source_Customer__2_ := __r.Source_Customer_;
    SELF := __l;
    SELF := __r;
  END;
  SHARED __EE32349 := JOIN(__EE32322,__EE32132,__JC32332(LEFT,RIGHT),__JT32332(LEFT,RIGHT),LEFT OUTER,hash);
  EXPORT __ST3634_Layout := RECORD
    KEL.typ.ntyp(E_Customer.Typ) Source_Customer_;
    KEL.typ.ntyp(E_Address.Typ) Location_;
    KEL.typ.int All_High_Risk_Death_Prior_To_All_Events_Person_Count_ := 0;
    KEL.typ.int High_Frequency_Flag_ := 0;
    KEL.typ.int High_Risk_Death_Prior_To_All_Events_Person_Count_ := 0;
    KEL.typ.int Person_Count_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  SHARED __ST3634_Layout __ND32354__Project(__ST30410_Layout __PP32350) := TRANSFORM
    SELF.All_High_Risk_Death_Prior_To_All_Events_Person_Count_ := __PP32350.S_U_M___High_Risk_Death_Prior_To_All_Events__1_;
    SELF.High_Frequency_Flag_ := MAP(__PP32350.Person_Count_ >= 20=>1,0);
    SELF.High_Risk_Death_Prior_To_All_Events_Person_Count_ := __PP32350.S_U_M___High_Risk_Death_Prior_To_All_Events_;
    SELF := __PP32350;
  END;
  EXPORT __ENH_Customer_Address_2 := PROJECT(__EE32349,__ND32354__Project(LEFT));
END;
