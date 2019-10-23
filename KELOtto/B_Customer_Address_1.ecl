//HPCC Systems KEL Compiler Version 0.11.0
IMPORT KEL011 AS KEL;
IMPORT B_Customer_Address_2,B_Customer_Address_Person_2,B_Customer_Address_Person_3,B_Person_2,E_Address,E_Customer,E_Person FROM KELOtto;
IMPORT * FROM KEL011.Null;
EXPORT B_Customer_Address_1 := MODULE
  SHARED VIRTUAL TYPEOF(B_Customer_Address_2.__ENH_Customer_Address_2) __ENH_Customer_Address_2 := B_Customer_Address_2.__ENH_Customer_Address_2;
  SHARED VIRTUAL TYPEOF(B_Customer_Address_Person_2.__ENH_Customer_Address_Person_2) __ENH_Customer_Address_Person_2 := B_Customer_Address_Person_2.__ENH_Customer_Address_Person_2;
  SHARED VIRTUAL TYPEOF(B_Person_2.__ENH_Person_2) __ENH_Person_2 := B_Person_2.__ENH_Person_2;
  SHARED __EE45092 := __ENH_Customer_Address_2;
  SHARED __EE45140 := __ENH_Customer_Address_Person_2;
  SHARED __EE49815 := __EE45140;
  SHARED __EE51670 := __EE49815(__T(__AND(__OP2(__EE49815.Source_Customer_,=,__EE49815.Associated_Customer_),__CN(__NN(__EE49815.Subject_) AND __NN(__EE49815.Location_) AND __NN(__EE49815.Source_Customer_) AND __NN(__EE49815.Location_)))));
  SHARED __EE45171 := __ENH_Person_2;
  SHARED __EE49818 := __EE45171;
  SHARED __EE49865 := __EE49818(__EE49818.Deceased_ = 1);
  __JC51679(B_Customer_Address_Person_3.__ST3935_Layout __EE51670, B_Person_2.__ST3796_Layout __EE49865) := __EEQP(__EE51670.Subject_,__EE49865.UID);
  SHARED __EE51680 := JOIN(__EE51670,__EE49865,__JC51679(LEFT,RIGHT),TRANSFORM(B_Customer_Address_Person_3.__ST3935_Layout,SELF:=LEFT),HASH,KEEP(1));
  SHARED __EE46571 := __EE45092;
  SHARED __EE49047 := __EE46571(__NN(__EE46571.Location_) AND __NN(__EE46571.Source_Customer_));
  SHARED __ST50480_Layout := RECORD
    KEL.typ.ntyp(E_Customer.Typ) Source_Customer__1_;
    KEL.typ.ntyp(E_Address.Typ) Location__1_;
    KEL.typ.int All_High_Risk_Death_Prior_To_All_Events_Person_Count_ := 0;
    KEL.typ.int High_Frequency_Flag_ := 0;
    KEL.typ.int High_Risk_Death_Prior_To_All_Events_Person_Count_ := 0;
    KEL.typ.int Person_Count_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
  END;
  SHARED __ST50480_Layout __ND50467__Project(B_Customer_Address_2.__ST3634_Layout __PP50466) := TRANSFORM
    SELF.Source_Customer__1_ := __PP50466.Source_Customer_;
    SELF.Location__1_ := __PP50466.Location_;
    SELF := __PP50466;
  END;
  SHARED __EE50488 := PROJECT(__EE49047,__ND50467__Project(LEFT));
  SHARED __ST50504_Layout := RECORD
    KEL.typ.ntyp(E_Customer.Typ) Source_Customer_;
    KEL.typ.ntyp(E_Customer.Typ) Associated_Customer_;
    KEL.typ.ntyp(E_Person.Typ) Subject_;
    KEL.typ.ntyp(E_Address.Typ) Location_;
    KEL.typ.nint Event_Count_;
    KEL.typ.nint High_Risk_Death_Prior_To_All_Events_;
    KEL.typ.ntyp(E_Customer.Typ) Source_Customer__1_;
    KEL.typ.ntyp(E_Address.Typ) Location__1_;
    KEL.typ.int All_High_Risk_Death_Prior_To_All_Events_Person_Count_ := 0;
    KEL.typ.int High_Frequency_Flag_ := 0;
    KEL.typ.int High_Risk_Death_Prior_To_All_Events_Person_Count_ := 0;
    KEL.typ.int Person_Count_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  __JC51701(B_Customer_Address_Person_3.__ST3935_Layout __EE51680, __ST50480_Layout __EE50488) := __NNEQ(__EE51680.Location_,__EE50488.Location__1_) AND __NNEQ(__EE51680.Source_Customer_,__EE50488.Source_Customer__1_) AND __EEQP(__EE50488.Location__1_,__EE51680.Location_) AND __T(__AND(__OP2(__EE51680.Location_,=,__EE50488.Location__1_),__AND(__OP2(__EE51680.Source_Customer_,=,__EE50488.Source_Customer__1_),__EEQ(__EE50488.Location__1_,__EE51680.Location_))));
  __ST50504_Layout __JT51701(B_Customer_Address_Person_3.__ST3935_Layout __l, __ST50480_Layout __r) := TRANSFORM
    SELF := __l;
    SELF := __r;
  END;
  SHARED __EE51702 := JOIN(__EE50488,__EE51680,__JC51701(RIGHT,LEFT),__JT51701(RIGHT,LEFT),INNER,HASH);
  SHARED __ST46623_Layout := RECORD
    KEL.typ.ntyp(E_Address.Typ) Location_;
    KEL.typ.ntyp(E_Customer.Typ) Source_Customer_;
    KEL.typ.ntyp(E_Person.Typ) Subject_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
  END;
  SHARED __ST46623_Layout __ND51707__Project(__ST50504_Layout __PP51703) := TRANSFORM
    SELF.Location_ := __PP51703.Location__1_;
    SELF.Source_Customer_ := __PP51703.Source_Customer__1_;
    SELF := __PP51703;
  END;
  SHARED __EE51720 := DEDUP(PROJECT(__EE51702,__ND51707__Project(LEFT)),ALL);
  SHARED __ST46647_Layout := RECORD
    KEL.typ.int C_O_U_N_T___Customer_Address_Person_ := 0;
    KEL.typ.ntyp(E_Address.Typ) Location_;
    KEL.typ.ntyp(E_Customer.Typ) Source_Customer_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
  END;
  SHARED __EE51739 := PROJECT(__CLEANANDDO(__EE51720,TABLE(__EE51720,{KEL.typ.int C_O_U_N_T___Customer_Address_Person_ := COUNT(GROUP),Location_,Source_Customer_},Location_,Source_Customer_,MERGE)),__ST46647_Layout);
  SHARED __ST47274_Layout := RECORD
    KEL.typ.ntyp(E_Customer.Typ) Source_Customer_;
    KEL.typ.ntyp(E_Address.Typ) Location_;
    KEL.typ.int All_High_Risk_Death_Prior_To_All_Events_Person_Count_ := 0;
    KEL.typ.int High_Frequency_Flag_ := 0;
    KEL.typ.int High_Risk_Death_Prior_To_All_Events_Person_Count_ := 0;
    KEL.typ.int Person_Count_ := 0;
    KEL.typ.int C_O_U_N_T___Customer_Address_Person_ := 0;
    KEL.typ.ntyp(E_Address.Typ) Location__1_;
    KEL.typ.ntyp(E_Customer.Typ) Source_Customer__1_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  __JC51754(B_Customer_Address_2.__ST3634_Layout __EE45092, __ST46647_Layout __EE51739) := __EEQP(__EE45092.Source_Customer_,__EE51739.Source_Customer_) AND __EEQP(__EE45092.Location_,__EE51739.Location_);
  __ST47274_Layout __JT51754(B_Customer_Address_2.__ST3634_Layout __l, __ST46647_Layout __r) := TRANSFORM
    SELF.Location__1_ := __r.Location_;
    SELF.Source_Customer__1_ := __r.Source_Customer_;
    SELF := __l;
    SELF := __r;
  END;
  SHARED __EE51755 := JOIN(__EE45092,__EE51739,__JC51754(LEFT,RIGHT),__JT51754(LEFT,RIGHT),LEFT OUTER,MANY LOOKUP);
  SHARED __EE51757 := __EE51670;
  SHARED __EE45939 := __EE45171(__EE45171.Deceased_Match_ = 1);
  SHARED __EE49812 := __EE45939;
  __JC51766(B_Customer_Address_Person_3.__ST3935_Layout __EE51757, B_Person_2.__ST3796_Layout __EE49812) := __EEQP(__EE51757.Subject_,__EE49812.UID);
  SHARED __EE51767 := JOIN(__EE51757,__EE49812,__JC51766(LEFT,RIGHT),TRANSFORM(B_Customer_Address_Person_3.__ST3935_Layout,SELF:=LEFT),MANY LOOKUP,KEEP(1));
  SHARED __EE49824 := __EE49047;
  SHARED __ST50674_Layout := RECORD
    KEL.typ.ntyp(E_Customer.Typ) Source_Customer__1_;
    KEL.typ.ntyp(E_Address.Typ) Location__1_;
    KEL.typ.int All_High_Risk_Death_Prior_To_All_Events_Person_Count_ := 0;
    KEL.typ.int High_Frequency_Flag_ := 0;
    KEL.typ.int High_Risk_Death_Prior_To_All_Events_Person_Count_ := 0;
    KEL.typ.int Person_Count_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
  END;
  SHARED __ST50674_Layout __ND50661__Project(B_Customer_Address_2.__ST3634_Layout __PP50660) := TRANSFORM
    SELF.Source_Customer__1_ := __PP50660.Source_Customer_;
    SELF.Location__1_ := __PP50660.Location_;
    SELF := __PP50660;
  END;
  SHARED __EE50682 := PROJECT(__EE49824,__ND50661__Project(LEFT));
  SHARED __ST50698_Layout := RECORD
    KEL.typ.ntyp(E_Customer.Typ) Source_Customer_;
    KEL.typ.ntyp(E_Customer.Typ) Associated_Customer_;
    KEL.typ.ntyp(E_Person.Typ) Subject_;
    KEL.typ.ntyp(E_Address.Typ) Location_;
    KEL.typ.nint Event_Count_;
    KEL.typ.nint High_Risk_Death_Prior_To_All_Events_;
    KEL.typ.ntyp(E_Customer.Typ) Source_Customer__1_;
    KEL.typ.ntyp(E_Address.Typ) Location__1_;
    KEL.typ.int All_High_Risk_Death_Prior_To_All_Events_Person_Count_ := 0;
    KEL.typ.int High_Frequency_Flag_ := 0;
    KEL.typ.int High_Risk_Death_Prior_To_All_Events_Person_Count_ := 0;
    KEL.typ.int Person_Count_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  __JC51788(B_Customer_Address_Person_3.__ST3935_Layout __EE51767, __ST50674_Layout __EE50682) := __NNEQ(__EE51767.Location_,__EE50682.Location__1_) AND __NNEQ(__EE51767.Source_Customer_,__EE50682.Source_Customer__1_) AND __EEQP(__EE50682.Location__1_,__EE51767.Location_) AND __T(__AND(__OP2(__EE51767.Location_,=,__EE50682.Location__1_),__AND(__OP2(__EE51767.Source_Customer_,=,__EE50682.Source_Customer__1_),__EEQ(__EE50682.Location__1_,__EE51767.Location_))));
  __ST50698_Layout __JT51788(B_Customer_Address_Person_3.__ST3935_Layout __l, __ST50674_Layout __r) := TRANSFORM
    SELF := __l;
    SELF := __r;
  END;
  SHARED __EE51789 := JOIN(__EE50682,__EE51767,__JC51788(RIGHT,LEFT),__JT51788(RIGHT,LEFT),INNER,MANY LOOKUP);
  SHARED __ST46344_Layout := RECORD
    KEL.typ.ntyp(E_Address.Typ) Location_;
    KEL.typ.ntyp(E_Customer.Typ) Source_Customer_;
    KEL.typ.ntyp(E_Person.Typ) Subject_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
  END;
  SHARED __ST46344_Layout __ND51794__Project(__ST50698_Layout __PP51790) := TRANSFORM
    SELF.Location_ := __PP51790.Location__1_;
    SELF.Source_Customer_ := __PP51790.Source_Customer__1_;
    SELF := __PP51790;
  END;
  SHARED __EE51807 := DEDUP(PROJECT(__EE51789,__ND51794__Project(LEFT)),ALL);
  SHARED __ST46368_Layout := RECORD
    KEL.typ.int C_O_U_N_T___Customer_Address_Person_ := 0;
    KEL.typ.ntyp(E_Address.Typ) Location_;
    KEL.typ.ntyp(E_Customer.Typ) Source_Customer_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
  END;
  SHARED __EE51826 := PROJECT(__CLEANANDDO(__EE51807,TABLE(__EE51807,{KEL.typ.int C_O_U_N_T___Customer_Address_Person_ := COUNT(GROUP),Location_,Source_Customer_},Location_,Source_Customer_,MERGE)),__ST46368_Layout);
  SHARED __ST47374_Layout := RECORD
    KEL.typ.ntyp(E_Customer.Typ) Source_Customer_;
    KEL.typ.ntyp(E_Address.Typ) Location_;
    KEL.typ.int All_High_Risk_Death_Prior_To_All_Events_Person_Count_ := 0;
    KEL.typ.int High_Frequency_Flag_ := 0;
    KEL.typ.int High_Risk_Death_Prior_To_All_Events_Person_Count_ := 0;
    KEL.typ.int Person_Count_ := 0;
    KEL.typ.int C_O_U_N_T___Customer_Address_Person_ := 0;
    KEL.typ.ntyp(E_Address.Typ) Location__1_;
    KEL.typ.ntyp(E_Customer.Typ) Source_Customer__1_;
    KEL.typ.int C_O_U_N_T___Customer_Address_Person__1_ := 0;
    KEL.typ.ntyp(E_Address.Typ) Location__2_;
    KEL.typ.ntyp(E_Customer.Typ) Source_Customer__2_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  __JC51841(__ST47274_Layout __EE51755, __ST46368_Layout __EE51826) := __EEQP(__EE51755.Location_,__EE51826.Location_) AND __EEQP(__EE51755.Source_Customer_,__EE51826.Source_Customer_);
  __ST47374_Layout __JT51841(__ST47274_Layout __l, __ST46368_Layout __r) := TRANSFORM
    SELF.C_O_U_N_T___Customer_Address_Person__1_ := __r.C_O_U_N_T___Customer_Address_Person_;
    SELF.Location__2_ := __r.Location_;
    SELF.Source_Customer__2_ := __r.Source_Customer_;
    SELF := __l;
    SELF := __r;
  END;
  SHARED __EE51842 := JOIN(__EE51755,__EE51826,__JC51841(LEFT,RIGHT),__JT51841(LEFT,RIGHT),LEFT OUTER,MANY LOOKUP);
  SHARED __EE49803 := __EE45140;
  SHARED __EE50118 := __EE49803(__NN(__EE49803.Location_) AND __NN(__EE49803.Associated_Customer_) AND __NN(__EE49803.Location_));
  SHARED __EE49827 := __EE49047;
  SHARED __ST50882_Layout := RECORD
    KEL.typ.ntyp(E_Customer.Typ) Source_Customer__1_;
    KEL.typ.ntyp(E_Address.Typ) Location__1_;
    KEL.typ.int All_High_Risk_Death_Prior_To_All_Events_Person_Count_ := 0;
    KEL.typ.int High_Frequency_Flag_ := 0;
    KEL.typ.int High_Risk_Death_Prior_To_All_Events_Person_Count_ := 0;
    KEL.typ.int Person_Count_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
  END;
  SHARED __ST50882_Layout __ND50869__Project(B_Customer_Address_2.__ST3634_Layout __PP50868) := TRANSFORM
    SELF.Source_Customer__1_ := __PP50868.Source_Customer_;
    SELF.Location__1_ := __PP50868.Location_;
    SELF := __PP50868;
  END;
  SHARED __EE50890 := PROJECT(__EE49827,__ND50869__Project(LEFT));
  SHARED __ST50906_Layout := RECORD
    KEL.typ.ntyp(E_Customer.Typ) Source_Customer_;
    KEL.typ.ntyp(E_Customer.Typ) Associated_Customer_;
    KEL.typ.ntyp(E_Person.Typ) Subject_;
    KEL.typ.ntyp(E_Address.Typ) Location_;
    KEL.typ.nint Event_Count_;
    KEL.typ.nint High_Risk_Death_Prior_To_All_Events_;
    KEL.typ.ntyp(E_Customer.Typ) Source_Customer__1_;
    KEL.typ.ntyp(E_Address.Typ) Location__1_;
    KEL.typ.int All_High_Risk_Death_Prior_To_All_Events_Person_Count_ := 0;
    KEL.typ.int High_Frequency_Flag_ := 0;
    KEL.typ.int High_Risk_Death_Prior_To_All_Events_Person_Count_ := 0;
    KEL.typ.int Person_Count_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  __JC50903(B_Customer_Address_Person_3.__ST3935_Layout __EE50118, __ST50882_Layout __EE50890) := __NNEQ(__EE50118.Location_,__EE50890.Location__1_) AND __NNEQ(__EE50118.Associated_Customer_,__EE50890.Source_Customer__1_) AND __EEQP(__EE50890.Location__1_,__EE50118.Location_) AND __T(__AND(__OP2(__EE50118.Location_,=,__EE50890.Location__1_),__AND(__OP2(__EE50118.Associated_Customer_,=,__EE50890.Source_Customer__1_),__EEQ(__EE50890.Location__1_,__EE50118.Location_))));
  __ST50906_Layout __JT50903(B_Customer_Address_Person_3.__ST3935_Layout __l, __ST50882_Layout __r) := TRANSFORM
    SELF := __l;
    SELF := __r;
  END;
  SHARED __EE50904 := JOIN(__EE50118,__EE50890,__JC50903(LEFT,RIGHT),__JT50903(LEFT,RIGHT),INNER,HASH);
  SHARED __ST46108_Layout := RECORD
    KEL.typ.ntyp(E_Address.Typ) Location_;
    KEL.typ.ntyp(E_Customer.Typ) Source_Customer_;
    KEL.typ.ntyp(E_Person.Typ) Subject_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
  END;
  SHARED __ST46108_Layout __ND50923__Project(__ST50906_Layout __PP50905) := TRANSFORM
    SELF.Location_ := __PP50905.Location__1_;
    SELF.Source_Customer_ := __PP50905.Source_Customer__1_;
    SELF := __PP50905;
  END;
  SHARED __EE50936 := DEDUP(PROJECT(__EE50904,__ND50923__Project(LEFT)),ALL);
  SHARED __ST46132_Layout := RECORD
    KEL.typ.int C_O_U_N_T___Customer_Address_Person_ := 0;
    KEL.typ.ntyp(E_Address.Typ) Location_;
    KEL.typ.ntyp(E_Customer.Typ) Source_Customer_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
  END;
  SHARED __EE50953 := PROJECT(__CLEANANDDO(__EE50936,TABLE(__EE50936,{KEL.typ.int C_O_U_N_T___Customer_Address_Person_ := COUNT(GROUP),Location_,Source_Customer_},Location_,Source_Customer_,MERGE)),__ST46132_Layout);
  SHARED __ST47472_Layout := RECORD
    KEL.typ.ntyp(E_Customer.Typ) Source_Customer_;
    KEL.typ.ntyp(E_Address.Typ) Location_;
    KEL.typ.int All_High_Risk_Death_Prior_To_All_Events_Person_Count_ := 0;
    KEL.typ.int High_Frequency_Flag_ := 0;
    KEL.typ.int High_Risk_Death_Prior_To_All_Events_Person_Count_ := 0;
    KEL.typ.int Person_Count_ := 0;
    KEL.typ.int C_O_U_N_T___Customer_Address_Person_ := 0;
    KEL.typ.ntyp(E_Address.Typ) Location__1_;
    KEL.typ.ntyp(E_Customer.Typ) Source_Customer__1_;
    KEL.typ.int C_O_U_N_T___Customer_Address_Person__1_ := 0;
    KEL.typ.ntyp(E_Address.Typ) Location__2_;
    KEL.typ.ntyp(E_Customer.Typ) Source_Customer__2_;
    KEL.typ.int C_O_U_N_T___Customer_Address_Person__2_ := 0;
    KEL.typ.ntyp(E_Address.Typ) Location__3_;
    KEL.typ.ntyp(E_Customer.Typ) Source_Customer__3_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  __JC51857(__ST47374_Layout __EE51842, __ST46132_Layout __EE50953) := __EEQP(__EE51842.Location_,__EE50953.Location_) AND __EEQP(__EE51842.Source_Customer_,__EE50953.Source_Customer_);
  __ST47472_Layout __JT51857(__ST47374_Layout __l, __ST46132_Layout __r) := TRANSFORM
    SELF.C_O_U_N_T___Customer_Address_Person__2_ := __r.C_O_U_N_T___Customer_Address_Person_;
    SELF.Location__3_ := __r.Location_;
    SELF.Source_Customer__3_ := __r.Source_Customer_;
    SELF := __l;
    SELF := __r;
  END;
  SHARED __EE51858 := JOIN(__EE51842,__EE50953,__JC51857(LEFT,RIGHT),__JT51857(LEFT,RIGHT),LEFT OUTER,MANY LOOKUP);
  SHARED __EE49564 := __EE45140(__NN(__EE45140.Subject_) AND __NN(__EE45140.Location_) AND __NN(__EE45140.Associated_Customer_) AND __NN(__EE45140.Location_));
  __JC49576(B_Customer_Address_Person_3.__ST3935_Layout __EE49564, B_Person_2.__ST3796_Layout __EE45939) := __EEQP(__EE49564.Subject_,__EE45939.UID);
  SHARED __EE49577 := JOIN(__EE49564,__EE45939,__JC49576(LEFT,RIGHT),TRANSFORM(B_Customer_Address_Person_3.__ST3935_Layout,SELF:=LEFT),MANY LOOKUP,KEEP(1));
  SHARED __EE49830 := __EE49047;
  SHARED __ST51096_Layout := RECORD
    KEL.typ.ntyp(E_Customer.Typ) Source_Customer__1_;
    KEL.typ.ntyp(E_Address.Typ) Location__1_;
    KEL.typ.int All_High_Risk_Death_Prior_To_All_Events_Person_Count_ := 0;
    KEL.typ.int High_Frequency_Flag_ := 0;
    KEL.typ.int High_Risk_Death_Prior_To_All_Events_Person_Count_ := 0;
    KEL.typ.int Person_Count_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
  END;
  SHARED __ST51096_Layout __ND51083__Project(B_Customer_Address_2.__ST3634_Layout __PP51082) := TRANSFORM
    SELF.Source_Customer__1_ := __PP51082.Source_Customer_;
    SELF.Location__1_ := __PP51082.Location_;
    SELF := __PP51082;
  END;
  SHARED __EE51104 := PROJECT(__EE49830,__ND51083__Project(LEFT));
  SHARED __ST51120_Layout := RECORD
    KEL.typ.ntyp(E_Customer.Typ) Source_Customer_;
    KEL.typ.ntyp(E_Customer.Typ) Associated_Customer_;
    KEL.typ.ntyp(E_Person.Typ) Subject_;
    KEL.typ.ntyp(E_Address.Typ) Location_;
    KEL.typ.nint Event_Count_;
    KEL.typ.nint High_Risk_Death_Prior_To_All_Events_;
    KEL.typ.ntyp(E_Customer.Typ) Source_Customer__1_;
    KEL.typ.ntyp(E_Address.Typ) Location__1_;
    KEL.typ.int All_High_Risk_Death_Prior_To_All_Events_Person_Count_ := 0;
    KEL.typ.int High_Frequency_Flag_ := 0;
    KEL.typ.int High_Risk_Death_Prior_To_All_Events_Person_Count_ := 0;
    KEL.typ.int Person_Count_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  __JC51117(B_Customer_Address_Person_3.__ST3935_Layout __EE49577, __ST51096_Layout __EE51104) := __NNEQ(__EE49577.Location_,__EE51104.Location__1_) AND __NNEQ(__EE49577.Associated_Customer_,__EE51104.Source_Customer__1_) AND __EEQP(__EE51104.Location__1_,__EE49577.Location_) AND __T(__AND(__OP2(__EE49577.Location_,=,__EE51104.Location__1_),__AND(__OP2(__EE49577.Associated_Customer_,=,__EE51104.Source_Customer__1_),__EEQ(__EE51104.Location__1_,__EE49577.Location_))));
  __ST51120_Layout __JT51117(B_Customer_Address_Person_3.__ST3935_Layout __l, __ST51096_Layout __r) := TRANSFORM
    SELF := __l;
    SELF := __r;
  END;
  SHARED __EE51118 := JOIN(__EE51104,__EE49577,__JC51117(RIGHT,LEFT),__JT51117(RIGHT,LEFT),INNER,MANY LOOKUP);
  SHARED __ST45853_Layout := RECORD
    KEL.typ.ntyp(E_Address.Typ) Location_;
    KEL.typ.ntyp(E_Customer.Typ) Source_Customer_;
    KEL.typ.ntyp(E_Person.Typ) Subject_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
  END;
  SHARED __ST45853_Layout __ND51137__Project(__ST51120_Layout __PP51119) := TRANSFORM
    SELF.Location_ := __PP51119.Location__1_;
    SELF.Source_Customer_ := __PP51119.Source_Customer__1_;
    SELF := __PP51119;
  END;
  SHARED __EE51150 := DEDUP(PROJECT(__EE51118,__ND51137__Project(LEFT)),ALL);
  SHARED __ST45877_Layout := RECORD
    KEL.typ.int C_O_U_N_T___Customer_Address_Person_ := 0;
    KEL.typ.ntyp(E_Address.Typ) Location_;
    KEL.typ.ntyp(E_Customer.Typ) Source_Customer_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
  END;
  SHARED __EE51167 := PROJECT(__CLEANANDDO(__EE51150,TABLE(__EE51150,{KEL.typ.int C_O_U_N_T___Customer_Address_Person_ := COUNT(GROUP),Location_,Source_Customer_},Location_,Source_Customer_,MERGE)),__ST45877_Layout);
  SHARED __ST47566_Layout := RECORD
    KEL.typ.ntyp(E_Customer.Typ) Source_Customer_;
    KEL.typ.ntyp(E_Address.Typ) Location_;
    KEL.typ.int All_High_Risk_Death_Prior_To_All_Events_Person_Count_ := 0;
    KEL.typ.int High_Frequency_Flag_ := 0;
    KEL.typ.int High_Risk_Death_Prior_To_All_Events_Person_Count_ := 0;
    KEL.typ.int Person_Count_ := 0;
    KEL.typ.int C_O_U_N_T___Customer_Address_Person_ := 0;
    KEL.typ.ntyp(E_Address.Typ) Location__1_;
    KEL.typ.ntyp(E_Customer.Typ) Source_Customer__1_;
    KEL.typ.int C_O_U_N_T___Customer_Address_Person__1_ := 0;
    KEL.typ.ntyp(E_Address.Typ) Location__2_;
    KEL.typ.ntyp(E_Customer.Typ) Source_Customer__2_;
    KEL.typ.int C_O_U_N_T___Customer_Address_Person__2_ := 0;
    KEL.typ.ntyp(E_Address.Typ) Location__3_;
    KEL.typ.ntyp(E_Customer.Typ) Source_Customer__3_;
    KEL.typ.int C_O_U_N_T___Customer_Address_Person__3_ := 0;
    KEL.typ.ntyp(E_Address.Typ) Location__4_;
    KEL.typ.ntyp(E_Customer.Typ) Source_Customer__4_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  __JC51873(__ST47472_Layout __EE51858, __ST45877_Layout __EE51167) := __EEQP(__EE51858.Location_,__EE51167.Location_) AND __EEQP(__EE51858.Source_Customer_,__EE51167.Source_Customer_);
  __ST47566_Layout __JT51873(__ST47472_Layout __l, __ST45877_Layout __r) := TRANSFORM
    SELF.C_O_U_N_T___Customer_Address_Person__3_ := __r.C_O_U_N_T___Customer_Address_Person_;
    SELF.Location__4_ := __r.Location_;
    SELF.Source_Customer__4_ := __r.Source_Customer_;
    SELF := __l;
    SELF := __r;
  END;
  SHARED __EE51874 := JOIN(__EE51858,__EE51167,__JC51873(LEFT,RIGHT),__JT51873(LEFT,RIGHT),LEFT OUTER,MANY LOOKUP);
  EXPORT __ST3328_Layout := RECORD
    KEL.typ.ntyp(E_Customer.Typ) Source_Customer_;
    KEL.typ.ntyp(E_Address.Typ) Location_;
    KEL.typ.int All_Deceased_Match_Person_Count_ := 0;
    KEL.typ.int All_High_Risk_Death_Prior_To_All_Events_Person_Count_ := 0;
    KEL.typ.float All_High_Risk_Death_Prior_To_All_Events_Person_Percent_ := 0.0;
    KEL.typ.int All_Person_Count_ := 0;
    KEL.typ.int Deceased_Match_Person_Count_ := 0;
    KEL.typ.int Deceased_Person_Count_ := 0;
    KEL.typ.int High_Frequency_Flag_ := 0;
    KEL.typ.int High_Risk_Death_Prior_To_All_Events_Person_Count_ := 0;
    KEL.typ.float High_Risk_Death_Prior_To_All_Events_Person_Percent_ := 0.0;
    KEL.typ.int Person_Count_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  SHARED __ST3328_Layout __ND51589__Project(__ST47566_Layout __PP51585) := TRANSFORM
    SELF.All_Deceased_Match_Person_Count_ := __PP51585.C_O_U_N_T___Customer_Address_Person__3_;
    SELF.All_High_Risk_Death_Prior_To_All_Events_Person_Percent_ := __PP51585.All_High_Risk_Death_Prior_To_All_Events_Person_Count_ / __PP51585.Person_Count_;
    SELF.All_Person_Count_ := __PP51585.C_O_U_N_T___Customer_Address_Person__2_;
    SELF.Deceased_Match_Person_Count_ := __PP51585.C_O_U_N_T___Customer_Address_Person__1_;
    SELF.Deceased_Person_Count_ := __PP51585.C_O_U_N_T___Customer_Address_Person_;
    SELF.High_Risk_Death_Prior_To_All_Events_Person_Percent_ := __PP51585.High_Risk_Death_Prior_To_All_Events_Person_Count_ / __PP51585.Person_Count_;
    SELF := __PP51585;
  END;
  EXPORT __ENH_Customer_Address_1 := PROJECT(__EE51874,__ND51589__Project(LEFT));
END;
