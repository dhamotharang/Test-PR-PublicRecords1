//HPCC Systems KEL Compiler Version 0.11.6
IMPORT KEL011 AS KEL;
IMPORT B_Bankruptcy_4,CFG_Compile,E_Bankruptcy,E_Person,E_Person_Bankruptcy FROM PublicRecords_KEL;
IMPORT * FROM KEL011.Null;
EXPORT B_Person_3(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE
  SHARED VIRTUAL TYPEOF(B_Bankruptcy_4(__in,__cfg).__ENH_Bankruptcy_4) __ENH_Bankruptcy_4 := B_Bankruptcy_4(__in,__cfg).__ENH_Bankruptcy_4;
  SHARED VIRTUAL TYPEOF(E_Person(__in,__cfg).__Result) __E_Person := E_Person(__in,__cfg).__Result;
  SHARED VIRTUAL TYPEOF(E_Person_Bankruptcy(__in,__cfg).__Result) __E_Person_Bankruptcy := E_Person_Bankruptcy(__in,__cfg).__Result;
  SHARED __EE61678 := __E_Person;
  SHARED __EE61680 := __E_Person_Bankruptcy;
  SHARED __EE61730 := __EE61680(__NN(__EE61680.Bankrupt_) AND __NN(__EE61680.Subject_));
  SHARED __EE61682 := __ENH_Bankruptcy_4;
  SHARED __EE61693 := __EE61682.Records_;
  __JC61696(B_Bankruptcy_4(__in,__cfg).__ST33643_Layout __EE61693) := __T(__EE61693.Banko10_Year_);
  SHARED __EE61697 := __EE61682(EXISTS(__CHILDJOINFILTER(__EE61693,__JC61696)));
  SHARED __ST49636_Layout := RECORD
    KEL.typ.ntyp(E_Person().Typ) Subject_;
    KEL.typ.ntyp(E_Bankruptcy().Typ) Bankrupt_;
    KEL.typ.ndataset(E_Person_Bankruptcy(__in,__cfg).Data_Sources_Layout) Data_Sources_;
    KEL.typ.nuid UID;
    KEL.typ.nstr T_M_S_I_D_;
    KEL.typ.nstr Court_Code_;
    KEL.typ.nstr Case_Number_;
    KEL.typ.nstr Original_Case_Number_;
    KEL.typ.ndataset(B_Bankruptcy_4(__in,__cfg).__ST33643_Layout) Records_;
    KEL.typ.ndataset(E_Bankruptcy(__in,__cfg).Deadlines_Layout) Deadlines_;
    KEL.typ.ndataset(E_Bankruptcy(__in,__cfg).Case_Details_Layout) Case_Details_;
    KEL.typ.ndataset(E_Bankruptcy(__in,__cfg).Data_Sources_Layout) Data_Sources__1_;
    KEL.typ.nkdate Current_Date_;
    KEL.typ.nbool Has_Case_Number_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  __JC61739(E_Person_Bankruptcy(__in,__cfg).Layout __EE61730, B_Bankruptcy_4(__in,__cfg).__ST33636_Layout __EE61697) := __EEQP(__EE61730.Bankrupt_,__EE61697.UID);
  __ST49636_Layout __JT61739(E_Person_Bankruptcy(__in,__cfg).Layout __l, B_Bankruptcy_4(__in,__cfg).__ST33636_Layout __r) := TRANSFORM
    SELF.Data_Sources__1_ := __r.Data_Sources_;
    SELF := __l;
    SELF := __r;
  END;
  SHARED __EE61740 := JOIN(__EE61730,__EE61697,__JC61739(LEFT,RIGHT),__JT61739(LEFT,RIGHT),INNER,HASH);
  SHARED __ST49745_Layout := RECORD
    KEL.typ.ntyp(E_Person().Typ) Subject_;
    KEL.typ.ntyp(E_Bankruptcy().Typ) Bankrupt_;
    KEL.typ.ndataset(E_Person_Bankruptcy(__in,__cfg).Data_Sources_Layout) Data_Sources_;
    KEL.typ.nuid UID;
    KEL.typ.nstr T_M_S_I_D_;
    KEL.typ.nstr Court_Code_;
    KEL.typ.nstr Case_Number_;
    KEL.typ.nstr Original_Case_Number_;
    KEL.typ.ndataset(B_Bankruptcy_4(__in,__cfg).__ST33643_Layout) Records_;
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
  __ST49745_Layout __JT61751(__ST49636_Layout __l, KEL.typ.int __c) := TRANSFORM
    __r := (__T(__l.Records_))[__c];
    SELF.Case_Number__1_ := __r.Case_Number_;
    SELF.Court_Code__1_ := __r.Court_Code_;
    SELF.T_M_S_I_D__1_ := __r.T_M_S_I_D_;
    SELF.__RecordCount := __r.__RecordCount;
    SELF := __l;
    SELF := __r;
  END;
  SHARED __EE61752 := NORMALIZE(__EE61740,MAX(1,COUNT(__T(LEFT.Records_))),__JT61751(LEFT,COUNTER));
  SHARED __ST51154_Layout := RECORD
    KEL.typ.nuid UID;
    KEL.typ.nstr Gender_;
    KEL.typ.nstr Lex_I_D_Segment_;
    KEL.typ.ndataset(E_Person(__in,__cfg).Full_Name_Layout) Full_Name_;
    KEL.typ.ndataset(E_Person(__in,__cfg).Reported_Dates_Of_Birth_Layout) Reported_Dates_Of_Birth_;
    KEL.typ.ndataset(E_Person(__in,__cfg).Reported_Dates_Of_Death_Layout) Reported_Dates_Of_Death_;
    KEL.typ.nstr Race_;
    KEL.typ.nstr Race_Description_;
    KEL.typ.ndataset(E_Person(__in,__cfg).Data_Sources_Layout) Data_Sources_;
    KEL.typ.ndataset(__ST49745_Layout) Person_Bankruptcy_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  __JC61761(E_Person(__in,__cfg).Layout __EE61678, __ST49745_Layout __EE61752) := __EEQP(__EE61678.UID,__EE61752.Subject_);
  __ST51154_Layout __Join__ST51154_Layout(E_Person(__in,__cfg).Layout __r, DATASET(__ST49745_Layout) __recs) := TRANSFORM
    SELF := __r;
    SELF.Person_Bankruptcy_ := __CN(__recs);
  END;
  SHARED __EE61762 := DENORMALIZE(DISTRIBUTE(__EE61678,HASH(UID)),DISTRIBUTE(__EE61752,HASH(Subject_)),__JC61761(LEFT,RIGHT),GROUP,__Join__ST51154_Layout(LEFT,ROWS(RIGHT)),LOCAL);
  SHARED __EE61764 := __EE61730;
  SHARED __EE61699 := __EE61682;
  SHARED __EE61715 := __EE61699.Records_;
  __JC61718(B_Bankruptcy_4(__in,__cfg).__ST33643_Layout __EE61715) := __T(__AND(__EE61715.Banko10_Year_,__NOT(__NT(__EE61715.Original_Chapter_))));
  SHARED __EE61719 := __EE61699(EXISTS(__CHILDJOINFILTER(__EE61715,__JC61718)));
  SHARED __ST49987_Layout := RECORD
    KEL.typ.ntyp(E_Person().Typ) Subject_;
    KEL.typ.ntyp(E_Bankruptcy().Typ) Bankrupt_;
    KEL.typ.ndataset(E_Person_Bankruptcy(__in,__cfg).Data_Sources_Layout) Data_Sources_;
    KEL.typ.nuid UID;
    KEL.typ.nstr T_M_S_I_D_;
    KEL.typ.nstr Court_Code_;
    KEL.typ.nstr Case_Number_;
    KEL.typ.nstr Original_Case_Number_;
    KEL.typ.ndataset(B_Bankruptcy_4(__in,__cfg).__ST33643_Layout) Records_;
    KEL.typ.ndataset(E_Bankruptcy(__in,__cfg).Deadlines_Layout) Deadlines_;
    KEL.typ.ndataset(E_Bankruptcy(__in,__cfg).Case_Details_Layout) Case_Details_;
    KEL.typ.ndataset(E_Bankruptcy(__in,__cfg).Data_Sources_Layout) Data_Sources__1_;
    KEL.typ.nkdate Current_Date_;
    KEL.typ.nbool Has_Case_Number_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  __JC61773(E_Person_Bankruptcy(__in,__cfg).Layout __EE61764, B_Bankruptcy_4(__in,__cfg).__ST33636_Layout __EE61719) := __EEQP(__EE61764.Bankrupt_,__EE61719.UID);
  __ST49987_Layout __JT61773(E_Person_Bankruptcy(__in,__cfg).Layout __l, B_Bankruptcy_4(__in,__cfg).__ST33636_Layout __r) := TRANSFORM
    SELF.Data_Sources__1_ := __r.Data_Sources_;
    SELF := __l;
    SELF := __r;
  END;
  SHARED __EE61774 := JOIN(__EE61764,__EE61719,__JC61773(LEFT,RIGHT),__JT61773(LEFT,RIGHT),INNER,HASH);
  SHARED __ST50096_Layout := RECORD
    KEL.typ.ntyp(E_Person().Typ) Subject_;
    KEL.typ.ntyp(E_Bankruptcy().Typ) Bankrupt_;
    KEL.typ.ndataset(E_Person_Bankruptcy(__in,__cfg).Data_Sources_Layout) Data_Sources_;
    KEL.typ.nuid UID;
    KEL.typ.nstr T_M_S_I_D_;
    KEL.typ.nstr Court_Code_;
    KEL.typ.nstr Case_Number_;
    KEL.typ.nstr Original_Case_Number_;
    KEL.typ.ndataset(B_Bankruptcy_4(__in,__cfg).__ST33643_Layout) Records_;
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
  __ST50096_Layout __JT61785(__ST49987_Layout __l, KEL.typ.int __c) := TRANSFORM
    __r := (__T(__l.Records_))[__c];
    SELF.Case_Number__1_ := __r.Case_Number_;
    SELF.Court_Code__1_ := __r.Court_Code_;
    SELF.T_M_S_I_D__1_ := __r.T_M_S_I_D_;
    SELF.__RecordCount := __r.__RecordCount;
    SELF := __l;
    SELF := __r;
  END;
  SHARED __EE61786 := NORMALIZE(__EE61774,MAX(1,COUNT(__T(LEFT.Records_))),__JT61785(LEFT,COUNTER));
  SHARED __ST51703_Layout := RECORD
    KEL.typ.nuid UID;
    KEL.typ.nstr Gender_;
    KEL.typ.nstr Lex_I_D_Segment_;
    KEL.typ.ndataset(E_Person(__in,__cfg).Full_Name_Layout) Full_Name_;
    KEL.typ.ndataset(E_Person(__in,__cfg).Reported_Dates_Of_Birth_Layout) Reported_Dates_Of_Birth_;
    KEL.typ.ndataset(E_Person(__in,__cfg).Reported_Dates_Of_Death_Layout) Reported_Dates_Of_Death_;
    KEL.typ.nstr Race_;
    KEL.typ.nstr Race_Description_;
    KEL.typ.ndataset(E_Person(__in,__cfg).Data_Sources_Layout) Data_Sources_;
    KEL.typ.ndataset(__ST49745_Layout) Person_Bankruptcy_;
    KEL.typ.ndataset(__ST50096_Layout) Person_Bankruptcy__1_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  __JC61795(__ST51154_Layout __EE61762, __ST50096_Layout __EE61786) := __EEQP(__EE61762.UID,__EE61786.Subject_);
  __ST51703_Layout __Join__ST51703_Layout(__ST51154_Layout __r, DATASET(__ST50096_Layout) __recs) := TRANSFORM
    SELF := __r;
    SELF.Person_Bankruptcy__1_ := __CN(__recs);
  END;
  SHARED __EE61796 := DENORMALIZE(DISTRIBUTE(__EE61762,HASH(UID)),DISTRIBUTE(__EE61786,HASH(Subject_)),__JC61795(LEFT,RIGHT),GROUP,__Join__ST51703_Layout(LEFT,ROWS(RIGHT)),LOCAL);
  SHARED __EE61814 := __EE61680;
  SHARED __EE61832 := __EE61814(__NN(__EE61814.Bankrupt_));
  SHARED __EE61816 := __EE61682;
  SHARED __ST50258_Layout := RECORD
    KEL.typ.ntyp(E_Person().Typ) Subject_;
    KEL.typ.ntyp(E_Bankruptcy().Typ) Bankrupt_;
    KEL.typ.ndataset(E_Person_Bankruptcy(__in,__cfg).Data_Sources_Layout) Data_Sources_;
    KEL.typ.nuid UID;
    KEL.typ.nstr T_M_S_I_D_;
    KEL.typ.nstr Court_Code_;
    KEL.typ.nstr Case_Number_;
    KEL.typ.nstr Original_Case_Number_;
    KEL.typ.ndataset(B_Bankruptcy_4(__in,__cfg).__ST33643_Layout) Records_;
    KEL.typ.ndataset(E_Bankruptcy(__in,__cfg).Deadlines_Layout) Deadlines_;
    KEL.typ.ndataset(E_Bankruptcy(__in,__cfg).Case_Details_Layout) Case_Details_;
    KEL.typ.ndataset(E_Bankruptcy(__in,__cfg).Data_Sources_Layout) Data_Sources__1_;
    KEL.typ.nkdate Current_Date_;
    KEL.typ.nbool Has_Case_Number_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  __JC61841(E_Person_Bankruptcy(__in,__cfg).Layout __EE61832, B_Bankruptcy_4(__in,__cfg).__ST33636_Layout __EE61816) := __EEQP(__EE61832.Bankrupt_,__EE61816.UID);
  __ST50258_Layout __JT61841(E_Person_Bankruptcy(__in,__cfg).Layout __l, B_Bankruptcy_4(__in,__cfg).__ST33636_Layout __r) := TRANSFORM
    SELF.Data_Sources__1_ := __r.Data_Sources_;
    SELF := __l;
    SELF := __r;
  END;
  SHARED __EE61842 := JOIN(__EE61832,__EE61816,__JC61841(LEFT,RIGHT),__JT61841(LEFT,RIGHT),INNER,HASH);
  SHARED __ST50379_Layout := RECORD
    KEL.typ.ntyp(E_Person().Typ) Subject_;
    KEL.typ.ntyp(E_Bankruptcy().Typ) Bankrupt_;
    KEL.typ.ndataset(E_Person_Bankruptcy(__in,__cfg).Data_Sources_Layout) Data_Sources_;
    KEL.typ.nuid UID;
    KEL.typ.nstr T_M_S_I_D_;
    KEL.typ.nstr Court_Code_;
    KEL.typ.nstr Case_Number_;
    KEL.typ.nstr Original_Case_Number_;
    KEL.typ.ndataset(B_Bankruptcy_4(__in,__cfg).__ST33643_Layout) Records_;
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
  __ST50379_Layout __JT61853(__ST50258_Layout __l, B_Bankruptcy_4(__in,__cfg).__ST33643_Layout __r) := TRANSFORM
    SELF.Case_Number__1_ := __r.Case_Number_;
    SELF.Court_Code__1_ := __r.Court_Code_;
    SELF.T_M_S_I_D__1_ := __r.T_M_S_I_D_;
    SELF.__RecordCount := __r.__RecordCount;
    SELF := __l;
    SELF := __r;
  END;
  SHARED __EE61854 := NORMALIZE(__EE61842,__T(LEFT.Records_),__JT61853(LEFT,RIGHT));
  SHARED __EE61865 := __EE61854(__T(__AND(__EE61854.Banko10_Year_,__CN(__NN(__EE61854.Subject_)))));
  SHARED __ST50565_Layout := RECORD
    KEL.typ.ntyp(E_Person().Typ) Subject_;
    KEL.typ.ntyp(E_Bankruptcy().Typ) Bankrupt_;
    KEL.typ.ndataset(E_Person_Bankruptcy(__in,__cfg).Data_Sources_Layout) Data_Sources_;
    KEL.typ.nuid UID;
    KEL.typ.nstr T_M_S_I_D_;
    KEL.typ.nstr Court_Code_;
    KEL.typ.nstr Case_Number_;
    KEL.typ.nstr Original_Case_Number_;
    KEL.typ.ndataset(B_Bankruptcy_4(__in,__cfg).__ST33643_Layout) Records_;
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
  __ST50565_Layout __JT61876(__ST50379_Layout __l, KEL.typ.int __c) := TRANSFORM
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
  SHARED __EE61877 := NORMALIZE(__EE61865,MAX(1,COUNT(__T(LEFT.Records_))),__JT61876(LEFT,COUNTER));
  SHARED __ST49400_Layout := RECORD
    KEL.typ.ntyp(E_Person().Typ) ____grp___U_I_D_;
    KEL.typ.nstr Original_Chapter_;
    KEL.typ.nstr T_M_S_I_D_;
    KEL.typ.nstr Case_Number_;
    KEL.typ.nstr Court_Code_;
    KEL.typ.nkdate Bankruptcy_Date_;
    KEL.typ.nkdate Last_Status_Update_;
    KEL.typ.nkdate Date_Filed_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
  END;
  SHARED __ST49400_Layout __ND61882__Project(__ST50565_Layout __PP61878) := TRANSFORM
    SELF.____grp___U_I_D_ := __PP61878.Subject_;
    SELF.Original_Chapter_ := __PP61878.Original_Chapter__1_;
    SELF.T_M_S_I_D_ := __PP61878.T_M_S_I_D__2_;
    SELF.Case_Number_ := __PP61878.Case_Number__2_;
    SELF.Court_Code_ := __PP61878.Court_Code__2_;
    SELF.Bankruptcy_Date_ := __PP61878.Bankruptcy_Date__1_;
    SELF.Last_Status_Update_ := __PP61878.Last_Status_Update__1_;
    SELF.Date_Filed_ := __PP61878.Date_Filed__1_;
    SELF := __PP61878;
  END;
  SHARED __EE61915 := PROJECT(TABLE(PROJECT(__EE61877,__ND61882__Project(LEFT)),{KEL.typ.epoch Date_First_Seen_ := KEL.era.SimpleRoll(GROUP,Date_First_Seen_,MIN,TRUE),KEL.typ.epoch Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Date_Last_Seen_,MAX,FALSE),____grp___U_I_D_,Original_Chapter_,T_M_S_I_D_,Case_Number_,Court_Code_,Bankruptcy_Date_,Last_Status_Update_,Date_Filed_},____grp___U_I_D_,Original_Chapter_,T_M_S_I_D_,Case_Number_,Court_Code_,Bankruptcy_Date_,Last_Status_Update_,Date_Filed_,MERGE),__ST49400_Layout);
  SHARED __EE61918 := GROUP(__EE61915,____grp___U_I_D_,ALL);
  SHARED __EE61922 := TOPN(__EE61918(__NN(__EE61918.Bankruptcy_Date_) AND __NN(__EE61918.Last_Status_Update_) AND __NN(__EE61918.Date_Filed_)),1, -__T(__EE61918.Bankruptcy_Date_), -__T(__EE61918.Last_Status_Update_), -__T(__EE61918.Date_Filed_),__T(____grp___U_I_D_),__T(Original_Chapter_),__T(T_M_S_I_D_),__T(Case_Number_),__T(Court_Code_));
  SHARED __ST52358_Layout := RECORD
    KEL.typ.nuid UID;
    KEL.typ.nstr Gender_;
    KEL.typ.nstr Lex_I_D_Segment_;
    KEL.typ.ndataset(E_Person(__in,__cfg).Full_Name_Layout) Full_Name_;
    KEL.typ.ndataset(E_Person(__in,__cfg).Reported_Dates_Of_Birth_Layout) Reported_Dates_Of_Birth_;
    KEL.typ.ndataset(E_Person(__in,__cfg).Reported_Dates_Of_Death_Layout) Reported_Dates_Of_Death_;
    KEL.typ.nstr Race_;
    KEL.typ.nstr Race_Description_;
    KEL.typ.ndataset(E_Person(__in,__cfg).Data_Sources_Layout) Data_Sources_;
    KEL.typ.ndataset(__ST49745_Layout) Person_Bankruptcy_;
    KEL.typ.ndataset(__ST50096_Layout) Person_Bankruptcy__1_;
    KEL.typ.ndataset(__ST49400_Layout) Exp1_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  __JC61931(__ST51703_Layout __EE61796, __ST49400_Layout __EE61922) := __EEQP(__EE61796.UID,__EE61922.____grp___U_I_D_);
  __ST52358_Layout __Join__ST52358_Layout(__ST51703_Layout __r, DATASET(__ST49400_Layout) __recs) := TRANSFORM
    SELF := __r;
    SELF.Exp1_ := __CN(__recs);
  END;
  SHARED __EE61932 := DENORMALIZE(DISTRIBUTE(__EE61796,HASH(UID)),DISTRIBUTE(__EE61922,HASH(____grp___U_I_D_)),__JC61931(LEFT,RIGHT),GROUP,__Join__ST52358_Layout(LEFT,ROWS(RIGHT)),LOCAL,MANY LOOKUP);
  SHARED __ST17483_Layout := RECORD
    KEL.typ.str Mod_Disposition_ := '';
    KEL.typ.nkdate Bankruptcy_Date_;
    KEL.typ.nkdate Last_Status_Update_;
    KEL.typ.nkdate Date_Filed_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  SHARED __ST16808_Layout := RECORD
    KEL.typ.nstr Original_Chapter_;
    KEL.typ.nkdate Bankruptcy_Date_;
    KEL.typ.nkdate Last_Status_Update_;
    KEL.typ.nkdate Date_Filed_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  SHARED __ST33500_Layout := RECORD
    KEL.typ.nuid UID;
    KEL.typ.nstr Gender_;
    KEL.typ.nstr Lex_I_D_Segment_;
    KEL.typ.ndataset(E_Person(__in,__cfg).Full_Name_Layout) Full_Name_;
    KEL.typ.ndataset(E_Person(__in,__cfg).Reported_Dates_Of_Birth_Layout) Reported_Dates_Of_Birth_;
    KEL.typ.ndataset(E_Person(__in,__cfg).Reported_Dates_Of_Death_Layout) Reported_Dates_Of_Death_;
    KEL.typ.nstr Race_;
    KEL.typ.nstr Race_Description_;
    KEL.typ.ndataset(E_Person(__in,__cfg).Data_Sources_Layout) Data_Sources_;
    KEL.typ.ndataset(__ST17483_Layout) Most_Recent_Dispo_List10_Y_;
    KEL.typ.ndataset(__ST16808_Layout) Top1_Chapter10_Y_List_;
    KEL.typ.ndataset(__ST49400_Layout) Top1_Chapter10_Y_List_With_Null_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  SHARED __ST33500_Layout __ND61940__Project(__ST52358_Layout __PP61936) := TRANSFORM
    __EE62023 := __PP61936.Person_Bankruptcy_;
    __ST17483_Layout __ND62033__Project(__ST49745_Layout __PP62024) := TRANSFORM
      __CC3326 := '-99997';
      SELF.Mod_Disposition_ := IF(__T(__NT(__PP62024.Disposition_)),__CC3326,__PP62024.Modified_Disposition_);
      SELF := __PP62024;
    END;
    __EE62050 := PROJECT(TABLE(PROJECT(__T(__EE62023),__ND62033__Project(LEFT)),{KEL.typ.int __RecordCount := SUM(GROUP,__RecordCount),KEL.typ.epoch Date_First_Seen_ := KEL.era.SimpleRoll(GROUP,Date_First_Seen_,MIN,TRUE),KEL.typ.epoch Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Date_Last_Seen_,MAX,FALSE),Mod_Disposition_,Bankruptcy_Date_,Last_Status_Update_,Date_Filed_},Mod_Disposition_,Bankruptcy_Date_,Last_Status_Update_,Date_Filed_,MERGE),__ST17483_Layout);
    __EE62054 := TOPN(__EE62050(__NN(__EE62050.Bankruptcy_Date_) AND __NN(__EE62050.Last_Status_Update_) AND __NN(__EE62050.Date_Filed_)),1, -__T(__EE62050.Bankruptcy_Date_), -__T(__EE62050.Last_Status_Update_), -__T(__EE62050.Date_Filed_),Mod_Disposition_);
    SELF.Most_Recent_Dispo_List10_Y_ := __CN(__EE62054);
    __EE62078 := __PP61936.Person_Bankruptcy__1_;
    __ST16808_Layout __ND62089__Project(__ST50096_Layout __PP62079) := TRANSFORM
      __CC3324 := -99997;
      SELF.Original_Chapter_ := IF(__T(__NT(__PP62079.Original_Chapter_)),__ECAST(KEL.typ.nstr,__CAST(KEL.typ.str,__CN(__CC3324))),__ECAST(KEL.typ.nstr,__PP62079.Original_Chapter_));
      SELF := __PP62079;
    END;
    __EE62106 := PROJECT(TABLE(PROJECT(__T(__EE62078),__ND62089__Project(LEFT)),{KEL.typ.int __RecordCount := SUM(GROUP,__RecordCount),KEL.typ.epoch Date_First_Seen_ := KEL.era.SimpleRoll(GROUP,Date_First_Seen_,MIN,TRUE),KEL.typ.epoch Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Date_Last_Seen_,MAX,FALSE),Original_Chapter_,Bankruptcy_Date_,Last_Status_Update_,Date_Filed_},Original_Chapter_,Bankruptcy_Date_,Last_Status_Update_,Date_Filed_,MERGE),__ST16808_Layout);
    __EE62110 := TOPN(__EE62106(__NN(__EE62106.Bankruptcy_Date_) AND __NN(__EE62106.Last_Status_Update_) AND __NN(__EE62106.Date_Filed_)),1, -__T(__EE62106.Bankruptcy_Date_), -__T(__EE62106.Last_Status_Update_), -__T(__EE62106.Date_Filed_),__T(Original_Chapter_));
    SELF.Top1_Chapter10_Y_List_ := __CN(__EE62110(__NN(Original_Chapter_) OR __NN(Bankruptcy_Date_) OR __NN(Last_Status_Update_) OR __NN(Date_Filed_)));
    __EE61935 := __PP61936.Exp1_;
    SELF.Top1_Chapter10_Y_List_With_Null_ := __EE61935;
    SELF := __PP61936;
  END;
  SHARED __EE62157 := PROJECT(__EE61932,__ND61940__Project(LEFT));
  EXPORT __ST16747_Layout := RECORD
    KEL.typ.nstr Original_Chapter_;
    KEL.typ.nstr T_M_S_I_D_;
    KEL.typ.nstr Case_Number_;
    KEL.typ.nstr Court_Code_;
    KEL.typ.nkdate Bankruptcy_Date_;
    KEL.typ.nkdate Last_Status_Update_;
    KEL.typ.nkdate Date_Filed_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  EXPORT __ST49319_Layout := RECORD
    KEL.typ.nuid UID;
    KEL.typ.nstr Gender_;
    KEL.typ.nstr Lex_I_D_Segment_;
    KEL.typ.ndataset(E_Person(__in,__cfg).Full_Name_Layout) Full_Name_;
    KEL.typ.ndataset(E_Person(__in,__cfg).Reported_Dates_Of_Birth_Layout) Reported_Dates_Of_Birth_;
    KEL.typ.ndataset(E_Person(__in,__cfg).Reported_Dates_Of_Death_Layout) Reported_Dates_Of_Death_;
    KEL.typ.nstr Race_;
    KEL.typ.nstr Race_Description_;
    KEL.typ.ndataset(E_Person(__in,__cfg).Data_Sources_Layout) Data_Sources_;
    KEL.typ.ndataset(__ST17483_Layout) Most_Recent_Dispo_List10_Y_;
    KEL.typ.ndataset(__ST16808_Layout) Top1_Chapter10_Y_List_;
    KEL.typ.ndataset(__ST16747_Layout) Top1_Chapter10_Y_List_With_Null_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  SHARED __ST49319_Layout __ND61550__Project(__ST33500_Layout __PP61546) := TRANSFORM
    __EE62160 := __PP61546.Top1_Chapter10_Y_List_With_Null_;
    SELF.Top1_Chapter10_Y_List_With_Null_ := __PROJECT(__EE62160,__ST16747_Layout);
    SELF := __PP61546;
  END;
  EXPORT __ENH_Person_3 := PROJECT(__EE62157,__ND61550__Project(LEFT));
END;
