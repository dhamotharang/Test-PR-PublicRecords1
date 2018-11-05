//HPCC Systems KEL Compiler Version 0.11.0
IMPORT KEL011 AS KEL;
IMPORT E_Customer,E_Person,E_Person_Person FROM KELOtto;
IMPORT * FROM KEL011.Null;
EXPORT B_Person_Person := MODULE
  SHARED __EE489726 := E_Person_Person.__Result;
  SHARED __IDX_Person_Person_From_Person__Filtered := __EE489726(__NN(__EE489726.From_Person_));
  SHARED IDX_Person_Person_From_Person__Layout := RECORD
    E_Person.Typ From_Person_;
    __IDX_Person_Person_From_Person__Filtered._r_Customer_;
    __IDX_Person_Person_From_Person__Filtered.To_Person_;
    __IDX_Person_Person_From_Person__Filtered.Self_Match_;
    __IDX_Person_Person_From_Person__Filtered.Public_Records_;
    __IDX_Person_Person_From_Person__Filtered.Contributory_Records_;
    __IDX_Person_Person_From_Person__Filtered.Same_Address_Email_Match_;
    __IDX_Person_Person_From_Person__Filtered.Same_Address_Ssn_Match_;
    __IDX_Person_Person_From_Person__Filtered.Same_Address_Phone_Number_Match_;
    __IDX_Person_Person_From_Person__Filtered.Same_Address_Same_Day_Count_;
    __IDX_Person_Person_From_Person__Filtered.High_Frequency_Same_Address_Same_Day_Count_;
    __IDX_Person_Person_From_Person__Filtered.Non_High_Frequency_Address_Count_;
    __IDX_Person_Person_From_Person__Filtered.Non_High_Frequency_Same_Address_Same_Day_Count_;
    __IDX_Person_Person_From_Person__Filtered.Shared_Address_Count_;
    __IDX_Person_Person_From_Person__Filtered.Date_First_Seen_;
    __IDX_Person_Person_From_Person__Filtered.Date_Last_Seen_;
    __IDX_Person_Person_From_Person__Filtered.__RecordCount;
  END;
  SHARED IDX_Person_Person_From_Person__Projected := PROJECT(__IDX_Person_Person_From_Person__Filtered,TRANSFORM(IDX_Person_Person_From_Person__Layout,SELF.From_Person_:=__T(LEFT.From_Person_),SELF:=LEFT));
  EXPORT IDX_Person_Person_From_Person_ := INDEX(IDX_Person_Person_From_Person__Projected,{From_Person_},{IDX_Person_Person_From_Person__Projected},'~key::KEL::KELOtto::Person_Person::From_Person_');
  EXPORT IDX_Person_Person_From_Person__Build := BUILD(IDX_Person_Person_From_Person_,OVERWRITE);
  EXPORT __ST489728_Layout := RECORDOF(IDX_Person_Person_From_Person_);
  EXPORT IDX_Person_Person_From_Person__Wrapped := PROJECT(IDX_Person_Person_From_Person_,TRANSFORM(E_Person_Person.Layout,SELF.From_Person_ := __CN(LEFT.From_Person_),SELF:=LEFT));
  EXPORT BuildAll := PARALLEL(IDX_Person_Person_From_Person__Build);
END;
