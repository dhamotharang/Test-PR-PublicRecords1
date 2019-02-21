﻿//HPCC Systems KEL Compiler Version 0.11.6
IMPORT KEL011 AS KEL;
IMPORT B_Bankruptcy_4,CFG_Compile,E_Bankruptcy,E_Person,E_Person_Bankruptcy FROM PublicRecords_KEL;
IMPORT * FROM KEL011.Null;
EXPORT B_Person_3(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE
  SHARED VIRTUAL TYPEOF(B_Bankruptcy_4(__in,__cfg).__ENH_Bankruptcy_4) __ENH_Bankruptcy_4 := B_Bankruptcy_4(__in,__cfg).__ENH_Bankruptcy_4;
  SHARED VIRTUAL TYPEOF(E_Person(__in,__cfg).__Result) __E_Person := E_Person(__in,__cfg).__Result;
  SHARED VIRTUAL TYPEOF(E_Person_Bankruptcy(__in,__cfg).__Result) __E_Person_Bankruptcy := E_Person_Bankruptcy(__in,__cfg).__Result;
  SHARED __EE60199 := __E_Person;
  SHARED __EE60201 := __E_Person_Bankruptcy;
  SHARED __EE60251 := __EE60201(__NN(__EE60201.Bankrupt_) AND __NN(__EE60201.Subject_));
  SHARED __EE60203 := __ENH_Bankruptcy_4;
  SHARED __EE60214 := __EE60203.Records_;
  __JC60217(B_Bankruptcy_4(__in,__cfg).__ST33038_Layout __EE60214) := __T(__EE60214.Banko10_Year_);
  SHARED __EE60218 := __EE60203(EXISTS(__CHILDJOINFILTER(__EE60214,__JC60217)));
  SHARED __ST48801_Layout := RECORD
    KEL.typ.ntyp(E_Person().Typ) Subject_;
    KEL.typ.ntyp(E_Bankruptcy().Typ) Bankrupt_;
    KEL.typ.ndataset(E_Person_Bankruptcy(__in,__cfg).Data_Sources_Layout) Data_Sources_;
    KEL.typ.nuid UID;
    KEL.typ.nstr T_M_S_I_D_;
    KEL.typ.nstr Court_Code_;
    KEL.typ.nstr Case_Number_;
    KEL.typ.nstr Original_Case_Number_;
    KEL.typ.ndataset(B_Bankruptcy_4(__in,__cfg).__ST33038_Layout) Records_;
    KEL.typ.ndataset(E_Bankruptcy(__in,__cfg).Deadlines_Layout) Deadlines_;
    KEL.typ.ndataset(E_Bankruptcy(__in,__cfg).Case_Details_Layout) Case_Details_;
    KEL.typ.ndataset(E_Bankruptcy(__in,__cfg).Data_Sources_Layout) Data_Sources__1_;
    KEL.typ.nkdate Current_Date_;
    KEL.typ.nbool Has_Case_Number_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  __JC60260(E_Person_Bankruptcy(__in,__cfg).Layout __EE60251, B_Bankruptcy_4(__in,__cfg).__ST33031_Layout __EE60218) := __EEQP(__EE60251.Bankrupt_,__EE60218.UID);
  __ST48801_Layout __JT60260(E_Person_Bankruptcy(__in,__cfg).Layout __l, B_Bankruptcy_4(__in,__cfg).__ST33031_Layout __r) := TRANSFORM
    SELF.Data_Sources__1_ := __r.Data_Sources_;
    SELF := __l;
    SELF := __r;
  END;
  SHARED __EE60261 := JOIN(__EE60251,__EE60218,__JC60260(LEFT,RIGHT),__JT60260(LEFT,RIGHT),INNER,HASH);
  SHARED __ST48902_Layout := RECORD
    KEL.typ.ntyp(E_Person().Typ) Subject_;
    KEL.typ.ntyp(E_Bankruptcy().Typ) Bankrupt_;
    KEL.typ.ndataset(E_Person_Bankruptcy(__in,__cfg).Data_Sources_Layout) Data_Sources_;
    KEL.typ.nuid UID;
    KEL.typ.nstr T_M_S_I_D_;
    KEL.typ.nstr Court_Code_;
    KEL.typ.nstr Case_Number_;
    KEL.typ.nstr Original_Case_Number_;
    KEL.typ.ndataset(B_Bankruptcy_4(__in,__cfg).__ST33038_Layout) Records_;
    KEL.typ.ndataset(E_Bankruptcy(__in,__cfg).Deadlines_Layout) Deadlines_;
    KEL.typ.ndataset(E_Bankruptcy(__in,__cfg).Case_Details_Layout) Case_Details_;
    KEL.typ.ndataset(E_Bankruptcy(__in,__cfg).Data_Sources_Layout) Data_Sources__1_;
    KEL.typ.nkdate Current_Date_;
    KEL.typ.nbool Has_Case_Number_;
    KEL.typ.nstr Source_Description_;
    KEL.typ.nstr Original_Chapter_;
    KEL.typ.nstr Filing_Type_;
    KEL.typ.nstr Business_Flag_;
    KEL.typ.nstr Corporate_Flag_;
    KEL.typ.nkdate Discharged_Date_;
    KEL.typ.nstr Disposition_;
    KEL.typ.nstr Debtor_Type_;
    KEL.typ.nint Debtor_Sequence_;
    KEL.typ.nint Disposition_Type_;
    KEL.typ.nint Disposition_Reason_;
    KEL.typ.nstr Disposition_Type_Description_;
    KEL.typ.nstr Name_Type_;
    KEL.typ.nstr Screen_Description_;
    KEL.typ.nstr Decoded_Description_;
    KEL.typ.nkdate Date_Filed_;
    KEL.typ.nkdate Date_Vendor_First_Reported_;
    KEL.typ.nkdate Date_Vendor_Last_Reported_;
    KEL.typ.nstr Record_Type_;
    KEL.typ.nkdate Last_Status_Update_;
    KEL.typ.nbool Banko10_Year_;
    KEL.typ.nkdate Bankruptcy_Date_;
    KEL.typ.nstr Case_Number__1_;
    KEL.typ.nstr Court_Code__1_;
    KEL.typ.nint Filing_Age_In_Days_;
    KEL.typ.nbool Is_Bankruptcy_;
    KEL.typ.nbool Is_Debtor_;
    KEL.typ.str Modified_Disposition_ := '';
    KEL.typ.nstr T_M_S_I_D__1_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  __ST48902_Layout __JT60272(__ST48801_Layout __l, KEL.typ.int __c) := TRANSFORM
    __r := (__T(__l.Records_))[__c];
    SELF.Case_Number__1_ := __r.Case_Number_;
    SELF.Court_Code__1_ := __r.Court_Code_;
    SELF.T_M_S_I_D__1_ := __r.T_M_S_I_D_;
    SELF.__RecordCount := __r.__RecordCount;
    SELF := __l;
    SELF := __r;
  END;
  SHARED __EE60273 := NORMALIZE(__EE60261,MAX(1,COUNT(__T(LEFT.Records_))),__JT60272(LEFT,COUNTER));
  SHARED __ST50221_Layout := RECORD
    KEL.typ.nuid UID;
    KEL.typ.nstr Gender_;
    KEL.typ.nstr Lex_I_D_Segment_;
    KEL.typ.ndataset(E_Person(__in,__cfg).Full_Name_Layout) Full_Name_;
    KEL.typ.ndataset(E_Person(__in,__cfg).Reported_Dates_Of_Birth_Layout) Reported_Dates_Of_Birth_;
    KEL.typ.ndataset(E_Person(__in,__cfg).Reported_Dates_Of_Death_Layout) Reported_Dates_Of_Death_;
    KEL.typ.nstr Race_;
    KEL.typ.nstr Race_Description_;
    KEL.typ.ndataset(E_Person(__in,__cfg).Data_Sources_Layout) Data_Sources_;
    KEL.typ.ndataset(__ST48902_Layout) Person_Bankruptcy_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  __JC60282(E_Person(__in,__cfg).Layout __EE60199, __ST48902_Layout __EE60273) := __EEQP(__EE60199.UID,__EE60273.Subject_);
  __ST50221_Layout __Join__ST50221_Layout(E_Person(__in,__cfg).Layout __r, DATASET(__ST48902_Layout) __recs) := TRANSFORM
    SELF := __r;
    SELF.Person_Bankruptcy_ := __CN(__recs);
  END;
  SHARED __EE60283 := DENORMALIZE(DISTRIBUTE(__EE60199,HASH(UID)),DISTRIBUTE(__EE60273,HASH(Subject_)),__JC60282(LEFT,RIGHT),GROUP,__Join__ST50221_Layout(LEFT,ROWS(RIGHT)),LOCAL);
  SHARED __EE60285 := __EE60251;
  SHARED __EE60220 := __EE60203;
  SHARED __EE60236 := __EE60220.Records_;
  __JC60239(B_Bankruptcy_4(__in,__cfg).__ST33038_Layout __EE60236) := __T(__AND(__EE60236.Banko10_Year_,__NOT(__NT(__EE60236.Original_Chapter_))));
  SHARED __EE60240 := __EE60220(EXISTS(__CHILDJOINFILTER(__EE60236,__JC60239)));
  SHARED __ST49128_Layout := RECORD
    KEL.typ.ntyp(E_Person().Typ) Subject_;
    KEL.typ.ntyp(E_Bankruptcy().Typ) Bankrupt_;
    KEL.typ.ndataset(E_Person_Bankruptcy(__in,__cfg).Data_Sources_Layout) Data_Sources_;
    KEL.typ.nuid UID;
    KEL.typ.nstr T_M_S_I_D_;
    KEL.typ.nstr Court_Code_;
    KEL.typ.nstr Case_Number_;
    KEL.typ.nstr Original_Case_Number_;
    KEL.typ.ndataset(B_Bankruptcy_4(__in,__cfg).__ST33038_Layout) Records_;
    KEL.typ.ndataset(E_Bankruptcy(__in,__cfg).Deadlines_Layout) Deadlines_;
    KEL.typ.ndataset(E_Bankruptcy(__in,__cfg).Case_Details_Layout) Case_Details_;
    KEL.typ.ndataset(E_Bankruptcy(__in,__cfg).Data_Sources_Layout) Data_Sources__1_;
    KEL.typ.nkdate Current_Date_;
    KEL.typ.nbool Has_Case_Number_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  __JC60294(E_Person_Bankruptcy(__in,__cfg).Layout __EE60285, B_Bankruptcy_4(__in,__cfg).__ST33031_Layout __EE60240) := __EEQP(__EE60285.Bankrupt_,__EE60240.UID);
  __ST49128_Layout __JT60294(E_Person_Bankruptcy(__in,__cfg).Layout __l, B_Bankruptcy_4(__in,__cfg).__ST33031_Layout __r) := TRANSFORM
    SELF.Data_Sources__1_ := __r.Data_Sources_;
    SELF := __l;
    SELF := __r;
  END;
  SHARED __EE60295 := JOIN(__EE60285,__EE60240,__JC60294(LEFT,RIGHT),__JT60294(LEFT,RIGHT),INNER,HASH);
  SHARED __ST49229_Layout := RECORD
    KEL.typ.ntyp(E_Person().Typ) Subject_;
    KEL.typ.ntyp(E_Bankruptcy().Typ) Bankrupt_;
    KEL.typ.ndataset(E_Person_Bankruptcy(__in,__cfg).Data_Sources_Layout) Data_Sources_;
    KEL.typ.nuid UID;
    KEL.typ.nstr T_M_S_I_D_;
    KEL.typ.nstr Court_Code_;
    KEL.typ.nstr Case_Number_;
    KEL.typ.nstr Original_Case_Number_;
    KEL.typ.ndataset(B_Bankruptcy_4(__in,__cfg).__ST33038_Layout) Records_;
    KEL.typ.ndataset(E_Bankruptcy(__in,__cfg).Deadlines_Layout) Deadlines_;
    KEL.typ.ndataset(E_Bankruptcy(__in,__cfg).Case_Details_Layout) Case_Details_;
    KEL.typ.ndataset(E_Bankruptcy(__in,__cfg).Data_Sources_Layout) Data_Sources__1_;
    KEL.typ.nkdate Current_Date_;
    KEL.typ.nbool Has_Case_Number_;
    KEL.typ.nstr Source_Description_;
    KEL.typ.nstr Original_Chapter_;
    KEL.typ.nstr Filing_Type_;
    KEL.typ.nstr Business_Flag_;
    KEL.typ.nstr Corporate_Flag_;
    KEL.typ.nkdate Discharged_Date_;
    KEL.typ.nstr Disposition_;
    KEL.typ.nstr Debtor_Type_;
    KEL.typ.nint Debtor_Sequence_;
    KEL.typ.nint Disposition_Type_;
    KEL.typ.nint Disposition_Reason_;
    KEL.typ.nstr Disposition_Type_Description_;
    KEL.typ.nstr Name_Type_;
    KEL.typ.nstr Screen_Description_;
    KEL.typ.nstr Decoded_Description_;
    KEL.typ.nkdate Date_Filed_;
    KEL.typ.nkdate Date_Vendor_First_Reported_;
    KEL.typ.nkdate Date_Vendor_Last_Reported_;
    KEL.typ.nstr Record_Type_;
    KEL.typ.nkdate Last_Status_Update_;
    KEL.typ.nbool Banko10_Year_;
    KEL.typ.nkdate Bankruptcy_Date_;
    KEL.typ.nstr Case_Number__1_;
    KEL.typ.nstr Court_Code__1_;
    KEL.typ.nint Filing_Age_In_Days_;
    KEL.typ.nbool Is_Bankruptcy_;
    KEL.typ.nbool Is_Debtor_;
    KEL.typ.str Modified_Disposition_ := '';
    KEL.typ.nstr T_M_S_I_D__1_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  __ST49229_Layout __JT60306(__ST49128_Layout __l, KEL.typ.int __c) := TRANSFORM
    __r := (__T(__l.Records_))[__c];
    SELF.Case_Number__1_ := __r.Case_Number_;
    SELF.Court_Code__1_ := __r.Court_Code_;
    SELF.T_M_S_I_D__1_ := __r.T_M_S_I_D_;
    SELF.__RecordCount := __r.__RecordCount;
    SELF := __l;
    SELF := __r;
  END;
  SHARED __EE60307 := NORMALIZE(__EE60295,MAX(1,COUNT(__T(LEFT.Records_))),__JT60306(LEFT,COUNTER));
  SHARED __ST50744_Layout := RECORD
    KEL.typ.nuid UID;
    KEL.typ.nstr Gender_;
    KEL.typ.nstr Lex_I_D_Segment_;
    KEL.typ.ndataset(E_Person(__in,__cfg).Full_Name_Layout) Full_Name_;
    KEL.typ.ndataset(E_Person(__in,__cfg).Reported_Dates_Of_Birth_Layout) Reported_Dates_Of_Birth_;
    KEL.typ.ndataset(E_Person(__in,__cfg).Reported_Dates_Of_Death_Layout) Reported_Dates_Of_Death_;
    KEL.typ.nstr Race_;
    KEL.typ.nstr Race_Description_;
    KEL.typ.ndataset(E_Person(__in,__cfg).Data_Sources_Layout) Data_Sources_;
    KEL.typ.ndataset(__ST48902_Layout) Person_Bankruptcy_;
    KEL.typ.ndataset(__ST49229_Layout) Person_Bankruptcy__1_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  __JC60316(__ST50221_Layout __EE60283, __ST49229_Layout __EE60307) := __EEQP(__EE60283.UID,__EE60307.Subject_);
  __ST50744_Layout __Join__ST50744_Layout(__ST50221_Layout __r, DATASET(__ST49229_Layout) __recs) := TRANSFORM
    SELF := __r;
    SELF.Person_Bankruptcy__1_ := __CN(__recs);
  END;
  SHARED __EE60317 := DENORMALIZE(DISTRIBUTE(__EE60283,HASH(UID)),DISTRIBUTE(__EE60307,HASH(Subject_)),__JC60316(LEFT,RIGHT),GROUP,__Join__ST50744_Layout(LEFT,ROWS(RIGHT)),LOCAL);
  SHARED __EE60329 := __EE60201;
  SHARED __EE60347 := __EE60329(__NN(__EE60329.Bankrupt_));
  SHARED __EE60331 := __EE60203;
  SHARED __ST49381_Layout := RECORD
    KEL.typ.ntyp(E_Person().Typ) Subject_;
    KEL.typ.ntyp(E_Bankruptcy().Typ) Bankrupt_;
    KEL.typ.ndataset(E_Person_Bankruptcy(__in,__cfg).Data_Sources_Layout) Data_Sources_;
    KEL.typ.nuid UID;
    KEL.typ.nstr T_M_S_I_D_;
    KEL.typ.nstr Court_Code_;
    KEL.typ.nstr Case_Number_;
    KEL.typ.nstr Original_Case_Number_;
    KEL.typ.ndataset(B_Bankruptcy_4(__in,__cfg).__ST33038_Layout) Records_;
    KEL.typ.ndataset(E_Bankruptcy(__in,__cfg).Deadlines_Layout) Deadlines_;
    KEL.typ.ndataset(E_Bankruptcy(__in,__cfg).Case_Details_Layout) Case_Details_;
    KEL.typ.ndataset(E_Bankruptcy(__in,__cfg).Data_Sources_Layout) Data_Sources__1_;
    KEL.typ.nkdate Current_Date_;
    KEL.typ.nbool Has_Case_Number_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  __JC60356(E_Person_Bankruptcy(__in,__cfg).Layout __EE60347, B_Bankruptcy_4(__in,__cfg).__ST33031_Layout __EE60331) := __EEQP(__EE60347.Bankrupt_,__EE60331.UID);
  __ST49381_Layout __JT60356(E_Person_Bankruptcy(__in,__cfg).Layout __l, B_Bankruptcy_4(__in,__cfg).__ST33031_Layout __r) := TRANSFORM
    SELF.Data_Sources__1_ := __r.Data_Sources_;
    SELF := __l;
    SELF := __r;
  END;
  SHARED __EE60357 := JOIN(__EE60347,__EE60331,__JC60356(LEFT,RIGHT),__JT60356(LEFT,RIGHT),INNER,HASH);
  SHARED __ST49496_Layout := RECORD
    KEL.typ.ntyp(E_Person().Typ) Subject_;
    KEL.typ.ntyp(E_Bankruptcy().Typ) Bankrupt_;
    KEL.typ.ndataset(E_Person_Bankruptcy(__in,__cfg).Data_Sources_Layout) Data_Sources_;
    KEL.typ.nuid UID;
    KEL.typ.nstr T_M_S_I_D_;
    KEL.typ.nstr Court_Code_;
    KEL.typ.nstr Case_Number_;
    KEL.typ.nstr Original_Case_Number_;
    KEL.typ.ndataset(B_Bankruptcy_4(__in,__cfg).__ST33038_Layout) Records_;
    KEL.typ.ndataset(E_Bankruptcy(__in,__cfg).Deadlines_Layout) Deadlines_;
    KEL.typ.ndataset(E_Bankruptcy(__in,__cfg).Case_Details_Layout) Case_Details_;
    KEL.typ.ndataset(E_Bankruptcy(__in,__cfg).Data_Sources_Layout) Data_Sources__1_;
    KEL.typ.nkdate Current_Date_;
    KEL.typ.nbool Has_Case_Number_;
    KEL.typ.nstr Source_Description_;
    KEL.typ.nstr Original_Chapter_;
    KEL.typ.nstr Filing_Type_;
    KEL.typ.nstr Business_Flag_;
    KEL.typ.nstr Corporate_Flag_;
    KEL.typ.nkdate Discharged_Date_;
    KEL.typ.nstr Disposition_;
    KEL.typ.nstr Debtor_Type_;
    KEL.typ.nint Debtor_Sequence_;
    KEL.typ.nint Disposition_Type_;
    KEL.typ.nint Disposition_Reason_;
    KEL.typ.nstr Disposition_Type_Description_;
    KEL.typ.nstr Name_Type_;
    KEL.typ.nstr Screen_Description_;
    KEL.typ.nstr Decoded_Description_;
    KEL.typ.nkdate Date_Filed_;
    KEL.typ.nkdate Date_Vendor_First_Reported_;
    KEL.typ.nkdate Date_Vendor_Last_Reported_;
    KEL.typ.nstr Record_Type_;
    KEL.typ.nkdate Last_Status_Update_;
    KEL.typ.nbool Banko10_Year_;
    KEL.typ.nkdate Bankruptcy_Date_;
    KEL.typ.nstr Case_Number__1_;
    KEL.typ.nstr Court_Code__1_;
    KEL.typ.nint Filing_Age_In_Days_;
    KEL.typ.nbool Is_Bankruptcy_;
    KEL.typ.nbool Is_Debtor_;
    KEL.typ.str Modified_Disposition_ := '';
    KEL.typ.nstr T_M_S_I_D__1_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  __ST49496_Layout __JT60368(__ST49381_Layout __l, B_Bankruptcy_4(__in,__cfg).__ST33038_Layout __r) := TRANSFORM
    SELF.Case_Number__1_ := __r.Case_Number_;
    SELF.Court_Code__1_ := __r.Court_Code_;
    SELF.T_M_S_I_D__1_ := __r.T_M_S_I_D_;
    SELF.__RecordCount := __r.__RecordCount;
    SELF := __l;
    SELF := __r;
  END;
  SHARED __EE60369 := NORMALIZE(__EE60357,__T(LEFT.Records_),__JT60368(LEFT,RIGHT));
  SHARED __EE60380 := __EE60369(__T(__AND(__EE60369.Banko10_Year_,__CN(__NN(__EE60369.Subject_)))));
  SHARED __ST49670_Layout := RECORD
    KEL.typ.ntyp(E_Person().Typ) Subject_;
    KEL.typ.ntyp(E_Bankruptcy().Typ) Bankrupt_;
    KEL.typ.ndataset(E_Person_Bankruptcy(__in,__cfg).Data_Sources_Layout) Data_Sources_;
    KEL.typ.nuid UID;
    KEL.typ.nstr T_M_S_I_D_;
    KEL.typ.nstr Court_Code_;
    KEL.typ.nstr Case_Number_;
    KEL.typ.nstr Original_Case_Number_;
    KEL.typ.ndataset(B_Bankruptcy_4(__in,__cfg).__ST33038_Layout) Records_;
    KEL.typ.ndataset(E_Bankruptcy(__in,__cfg).Deadlines_Layout) Deadlines_;
    KEL.typ.ndataset(E_Bankruptcy(__in,__cfg).Case_Details_Layout) Case_Details_;
    KEL.typ.ndataset(E_Bankruptcy(__in,__cfg).Data_Sources_Layout) Data_Sources__1_;
    KEL.typ.nkdate Current_Date_;
    KEL.typ.nbool Has_Case_Number_;
    KEL.typ.nstr Source_Description_;
    KEL.typ.nstr Original_Chapter_;
    KEL.typ.nstr Filing_Type_;
    KEL.typ.nstr Business_Flag_;
    KEL.typ.nstr Corporate_Flag_;
    KEL.typ.nkdate Discharged_Date_;
    KEL.typ.nstr Disposition_;
    KEL.typ.nstr Debtor_Type_;
    KEL.typ.nint Debtor_Sequence_;
    KEL.typ.nint Disposition_Type_;
    KEL.typ.nint Disposition_Reason_;
    KEL.typ.nstr Disposition_Type_Description_;
    KEL.typ.nstr Name_Type_;
    KEL.typ.nstr Screen_Description_;
    KEL.typ.nstr Decoded_Description_;
    KEL.typ.nkdate Date_Filed_;
    KEL.typ.nkdate Date_Vendor_First_Reported_;
    KEL.typ.nkdate Date_Vendor_Last_Reported_;
    KEL.typ.nstr Record_Type_;
    KEL.typ.nkdate Last_Status_Update_;
    KEL.typ.nbool Banko10_Year_;
    KEL.typ.nkdate Bankruptcy_Date_;
    KEL.typ.nstr Case_Number__1_;
    KEL.typ.nstr Court_Code__1_;
    KEL.typ.nint Filing_Age_In_Days_;
    KEL.typ.nbool Is_Bankruptcy_;
    KEL.typ.nbool Is_Debtor_;
    KEL.typ.str Modified_Disposition_ := '';
    KEL.typ.nstr T_M_S_I_D__1_;
    KEL.typ.nstr Source_Description__1_;
    KEL.typ.nstr Original_Chapter__1_;
    KEL.typ.nstr Filing_Type__1_;
    KEL.typ.nstr Business_Flag__1_;
    KEL.typ.nstr Corporate_Flag__1_;
    KEL.typ.nkdate Discharged_Date__1_;
    KEL.typ.nstr Disposition__1_;
    KEL.typ.nstr Debtor_Type__1_;
    KEL.typ.nint Debtor_Sequence__1_;
    KEL.typ.nint Disposition_Type__1_;
    KEL.typ.nint Disposition_Reason__1_;
    KEL.typ.nstr Disposition_Type_Description__1_;
    KEL.typ.nstr Name_Type__1_;
    KEL.typ.nstr Screen_Description__1_;
    KEL.typ.nstr Decoded_Description__1_;
    KEL.typ.nkdate Date_Filed__1_;
    KEL.typ.nkdate Date_Vendor_First_Reported__1_;
    KEL.typ.nkdate Date_Vendor_Last_Reported__1_;
    KEL.typ.nstr Record_Type__1_;
    KEL.typ.nkdate Last_Status_Update__1_;
    KEL.typ.nbool Banko10_Year__1_;
    KEL.typ.nkdate Bankruptcy_Date__1_;
    KEL.typ.nstr Case_Number__2_;
    KEL.typ.nstr Court_Code__2_;
    KEL.typ.nint Filing_Age_In_Days__1_;
    KEL.typ.nbool Is_Bankruptcy__1_;
    KEL.typ.nbool Is_Debtor__1_;
    KEL.typ.str Modified_Disposition__1_ := '';
    KEL.typ.nstr T_M_S_I_D__2_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  __ST49670_Layout __JT60391(__ST49496_Layout __l, KEL.typ.int __c) := TRANSFORM
    __r := (__T(__l.Records_))[__c];
    SELF.Source_Description__1_ := __r.Source_Description_;
    SELF.Original_Chapter__1_ := __r.Original_Chapter_;
    SELF.Filing_Type__1_ := __r.Filing_Type_;
    SELF.Business_Flag__1_ := __r.Business_Flag_;
    SELF.Corporate_Flag__1_ := __r.Corporate_Flag_;
    SELF.Discharged_Date__1_ := __r.Discharged_Date_;
    SELF.Disposition__1_ := __r.Disposition_;
    SELF.Debtor_Type__1_ := __r.Debtor_Type_;
    SELF.Debtor_Sequence__1_ := __r.Debtor_Sequence_;
    SELF.Disposition_Type__1_ := __r.Disposition_Type_;
    SELF.Disposition_Reason__1_ := __r.Disposition_Reason_;
    SELF.Disposition_Type_Description__1_ := __r.Disposition_Type_Description_;
    SELF.Name_Type__1_ := __r.Name_Type_;
    SELF.Screen_Description__1_ := __r.Screen_Description_;
    SELF.Decoded_Description__1_ := __r.Decoded_Description_;
    SELF.Date_Filed__1_ := __r.Date_Filed_;
    SELF.Date_Vendor_First_Reported__1_ := __r.Date_Vendor_First_Reported_;
    SELF.Date_Vendor_Last_Reported__1_ := __r.Date_Vendor_Last_Reported_;
    SELF.Record_Type__1_ := __r.Record_Type_;
    SELF.Last_Status_Update__1_ := __r.Last_Status_Update_;
    SELF.Banko10_Year__1_ := __r.Banko10_Year_;
    SELF.Bankruptcy_Date__1_ := __r.Bankruptcy_Date_;
    SELF.Case_Number__2_ := __r.Case_Number_;
    SELF.Court_Code__2_ := __r.Court_Code_;
    SELF.Filing_Age_In_Days__1_ := __r.Filing_Age_In_Days_;
    SELF.Is_Bankruptcy__1_ := __r.Is_Bankruptcy_;
    SELF.Is_Debtor__1_ := __r.Is_Debtor_;
    SELF.Modified_Disposition__1_ := __r.Modified_Disposition_;
    SELF.T_M_S_I_D__2_ := __r.T_M_S_I_D_;
    SELF.__RecordCount := __r.__RecordCount;
    SELF := __l;
    SELF := __r;
  END;
  SHARED __EE60392 := NORMALIZE(__EE60380,MAX(1,COUNT(__T(LEFT.Records_))),__JT60391(LEFT,COUNTER));
  SHARED __ST48593_Layout := RECORD
    KEL.typ.ntyp(E_Person().Typ) ____grp___U_I_D_;
    KEL.typ.nstr Original_Chapter_;
    KEL.typ.nstr T_M_S_I_D_;
    KEL.typ.nstr Case_Number_;
    KEL.typ.nstr Court_Code_;
    KEL.typ.nkdate Bankruptcy_Date_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
  END;
  SHARED __ST48593_Layout __ND60397__Project(__ST49670_Layout __PP60393) := TRANSFORM
    SELF.____grp___U_I_D_ := __PP60393.Subject_;
    SELF.Original_Chapter_ := __PP60393.Original_Chapter__1_;
    SELF.T_M_S_I_D_ := __PP60393.T_M_S_I_D__2_;
    SELF.Case_Number_ := __PP60393.Case_Number__2_;
    SELF.Court_Code_ := __PP60393.Court_Code__2_;
    SELF.Bankruptcy_Date_ := __PP60393.Bankruptcy_Date__1_;
    SELF := __PP60393;
  END;
  SHARED __EE60422 := PROJECT(TABLE(PROJECT(__EE60392,__ND60397__Project(LEFT)),{KEL.typ.epoch Date_First_Seen_ := KEL.era.SimpleRoll(GROUP,Date_First_Seen_,MIN,TRUE),KEL.typ.epoch Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Date_Last_Seen_,MAX,FALSE),____grp___U_I_D_,Original_Chapter_,T_M_S_I_D_,Case_Number_,Court_Code_,Bankruptcy_Date_},____grp___U_I_D_,Original_Chapter_,T_M_S_I_D_,Case_Number_,Court_Code_,Bankruptcy_Date_,MERGE),__ST48593_Layout);
  SHARED __EE60425 := GROUP(__EE60422,____grp___U_I_D_,ALL);
  SHARED __EE60429 := TOPN(__EE60425(__NN(__EE60425.Bankruptcy_Date_)),1, -__T(__EE60425.Bankruptcy_Date_),__T(____grp___U_I_D_),__T(Original_Chapter_),__T(T_M_S_I_D_),__T(Case_Number_),__T(Court_Code_));
  SHARED __ST51371_Layout := RECORD
    KEL.typ.nuid UID;
    KEL.typ.nstr Gender_;
    KEL.typ.nstr Lex_I_D_Segment_;
    KEL.typ.ndataset(E_Person(__in,__cfg).Full_Name_Layout) Full_Name_;
    KEL.typ.ndataset(E_Person(__in,__cfg).Reported_Dates_Of_Birth_Layout) Reported_Dates_Of_Birth_;
    KEL.typ.ndataset(E_Person(__in,__cfg).Reported_Dates_Of_Death_Layout) Reported_Dates_Of_Death_;
    KEL.typ.nstr Race_;
    KEL.typ.nstr Race_Description_;
    KEL.typ.ndataset(E_Person(__in,__cfg).Data_Sources_Layout) Data_Sources_;
    KEL.typ.ndataset(__ST48902_Layout) Person_Bankruptcy_;
    KEL.typ.ndataset(__ST49229_Layout) Person_Bankruptcy__1_;
    KEL.typ.ndataset(__ST48593_Layout) Exp1_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  __JC60438(__ST50744_Layout __EE60317, __ST48593_Layout __EE60429) := __EEQP(__EE60317.UID,__EE60429.____grp___U_I_D_);
  __ST51371_Layout __Join__ST51371_Layout(__ST50744_Layout __r, DATASET(__ST48593_Layout) __recs) := TRANSFORM
    SELF := __r;
    SELF.Exp1_ := __CN(__recs);
  END;
  SHARED __EE60439 := DENORMALIZE(DISTRIBUTE(__EE60317,HASH(UID)),DISTRIBUTE(__EE60429,HASH(____grp___U_I_D_)),__JC60438(LEFT,RIGHT),GROUP,__Join__ST51371_Layout(LEFT,ROWS(RIGHT)),LOCAL,MANY LOOKUP);
  SHARED __ST17175_Layout := RECORD
    KEL.typ.str Mod_Disposition_ := '';
    KEL.typ.nkdate Bankruptcy_Date_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  SHARED __ST16574_Layout := RECORD
    KEL.typ.nstr Original_Chapter_;
    KEL.typ.nkdate Bankruptcy_Date_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  SHARED __ST32903_Layout := RECORD
    KEL.typ.nuid UID;
    KEL.typ.nstr Gender_;
    KEL.typ.nstr Lex_I_D_Segment_;
    KEL.typ.ndataset(E_Person(__in,__cfg).Full_Name_Layout) Full_Name_;
    KEL.typ.ndataset(E_Person(__in,__cfg).Reported_Dates_Of_Birth_Layout) Reported_Dates_Of_Birth_;
    KEL.typ.ndataset(E_Person(__in,__cfg).Reported_Dates_Of_Death_Layout) Reported_Dates_Of_Death_;
    KEL.typ.nstr Race_;
    KEL.typ.nstr Race_Description_;
    KEL.typ.ndataset(E_Person(__in,__cfg).Data_Sources_Layout) Data_Sources_;
    KEL.typ.ndataset(__ST17175_Layout) Most_Recent_Dispo_List10_Y_;
    KEL.typ.ndataset(__ST16574_Layout) Top1_Chapter10_Y_List_;
    KEL.typ.ndataset(__ST48593_Layout) Top1_Chapter10_Y_List_With_Null_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  SHARED __ST32903_Layout __ND60447__Project(__ST51371_Layout __PP60443) := TRANSFORM
    __EE60518 := __PP60443.Person_Bankruptcy_;
    __ST17175_Layout __ND60528__Project(__ST48902_Layout __PP60519) := TRANSFORM
      __CC3319 := '-99997';
      SELF.Mod_Disposition_ := IF(__T(__NT(__PP60519.Disposition_)),__CC3319,__PP60519.Modified_Disposition_);
      SELF := __PP60519;
    END;
    __EE60537 := PROJECT(TABLE(PROJECT(__T(__EE60518),__ND60528__Project(LEFT)),{KEL.typ.int __RecordCount := SUM(GROUP,__RecordCount),KEL.typ.epoch Date_First_Seen_ := KEL.era.SimpleRoll(GROUP,Date_First_Seen_,MIN,TRUE),KEL.typ.epoch Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Date_Last_Seen_,MAX,FALSE),Mod_Disposition_,Bankruptcy_Date_},Mod_Disposition_,Bankruptcy_Date_,MERGE),__ST17175_Layout);
    __EE60541 := TOPN(__EE60537(__NN(__EE60537.Bankruptcy_Date_)),1, -__T(__EE60537.Bankruptcy_Date_),Mod_Disposition_);
    SELF.Most_Recent_Dispo_List10_Y_ := __CN(__EE60541);
    __EE60559 := __PP60443.Person_Bankruptcy__1_;
    __ST16574_Layout __ND60570__Project(__ST49229_Layout __PP60560) := TRANSFORM
      __CC3317 := -99997;
      SELF.Original_Chapter_ := IF(__T(__NT(__PP60560.Original_Chapter_)),__ECAST(KEL.typ.nstr,__CAST(KEL.typ.str,__CN(__CC3317))),__ECAST(KEL.typ.nstr,__PP60560.Original_Chapter_));
      SELF := __PP60560;
    END;
    __EE60579 := PROJECT(TABLE(PROJECT(__T(__EE60559),__ND60570__Project(LEFT)),{KEL.typ.int __RecordCount := SUM(GROUP,__RecordCount),KEL.typ.epoch Date_First_Seen_ := KEL.era.SimpleRoll(GROUP,Date_First_Seen_,MIN,TRUE),KEL.typ.epoch Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Date_Last_Seen_,MAX,FALSE),Original_Chapter_,Bankruptcy_Date_},Original_Chapter_,Bankruptcy_Date_,MERGE),__ST16574_Layout);
    __EE60583 := TOPN(__EE60579(__NN(__EE60579.Bankruptcy_Date_)),1, -__T(__EE60579.Bankruptcy_Date_),__T(Original_Chapter_));
    SELF.Top1_Chapter10_Y_List_ := __CN(__EE60583(__NN(Original_Chapter_) OR __NN(Bankruptcy_Date_)));
    __EE60442 := __PP60443.Exp1_;
    SELF.Top1_Chapter10_Y_List_With_Null_ := __EE60442;
    SELF := __PP60443;
  END;
  SHARED __EE60624 := PROJECT(__EE60439,__ND60447__Project(LEFT));
  EXPORT __ST16523_Layout := RECORD
    KEL.typ.nstr Original_Chapter_;
    KEL.typ.nstr T_M_S_I_D_;
    KEL.typ.nstr Case_Number_;
    KEL.typ.nstr Court_Code_;
    KEL.typ.nkdate Bankruptcy_Date_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  EXPORT __ST48522_Layout := RECORD
    KEL.typ.nuid UID;
    KEL.typ.nstr Gender_;
    KEL.typ.nstr Lex_I_D_Segment_;
    KEL.typ.ndataset(E_Person(__in,__cfg).Full_Name_Layout) Full_Name_;
    KEL.typ.ndataset(E_Person(__in,__cfg).Reported_Dates_Of_Birth_Layout) Reported_Dates_Of_Birth_;
    KEL.typ.ndataset(E_Person(__in,__cfg).Reported_Dates_Of_Death_Layout) Reported_Dates_Of_Death_;
    KEL.typ.nstr Race_;
    KEL.typ.nstr Race_Description_;
    KEL.typ.ndataset(E_Person(__in,__cfg).Data_Sources_Layout) Data_Sources_;
    KEL.typ.ndataset(__ST17175_Layout) Most_Recent_Dispo_List10_Y_;
    KEL.typ.ndataset(__ST16574_Layout) Top1_Chapter10_Y_List_;
    KEL.typ.ndataset(__ST16523_Layout) Top1_Chapter10_Y_List_With_Null_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  SHARED __ST48522_Layout __ND60087__Project(__ST32903_Layout __PP60083) := TRANSFORM
    __EE60627 := __PP60083.Top1_Chapter10_Y_List_With_Null_;
    SELF.Top1_Chapter10_Y_List_With_Null_ := __PROJECT(__EE60627,__ST16523_Layout);
    SELF := __PP60083;
  END;
  EXPORT __ENH_Person_3 := PROJECT(__EE60624,__ND60087__Project(LEFT));
END;
