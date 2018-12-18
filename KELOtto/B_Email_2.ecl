//HPCC Systems KEL Compiler Version 0.11.0
IMPORT KEL011 AS KEL;
IMPORT B_Person_3,E_Address,E_Bank,E_Bank_Account,E_Customer,E_Drivers_License,E_Email,E_Event,E_Internet_Protocol,E_Person,E_Person_Email,E_Person_Event,E_Person_Person,E_Phone,E_Social_Security_Number FROM KELOtto;
IMPORT * FROM KEL011.Null;
EXPORT B_Email_2 := MODULE
  SHARED VIRTUAL TYPEOF(E_Email.__Result) __E_Email := E_Email.__Result;
  SHARED VIRTUAL TYPEOF(B_Person_3.__ENH_Person_3) __ENH_Person_3 := B_Person_3.__ENH_Person_3;
  SHARED VIRTUAL TYPEOF(E_Person_Email.__Result) __E_Person_Email := E_Person_Email.__Result;
  SHARED VIRTUAL TYPEOF(E_Person_Event.__Result) __E_Person_Event := E_Person_Event.__Result;
  SHARED VIRTUAL TYPEOF(E_Person_Person.__Result) __E_Person_Person := E_Person_Person.__Result;
  SHARED __EE71793 := __E_Email;
  SHARED __EE71874 := __E_Person_Person;
  SHARED __EE75915 := __EE71874;
  SHARED __EE75936 := __EE75915(__NN(__EE75915.From_Person_));
  SHARED __ST76400_Layout := RECORD
    KEL.typ.ntyp(E_Person.Typ) From_Person_;
    KEL.typ.ntyp(E_Person.Typ) To_Person_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  SHARED __EE76404 := PROJECT(TABLE(PROJECT(__EE75936,__ST76400_Layout),{KEL.typ.int __RecordCount := SUM(GROUP,__RecordCount),KEL.typ.epoch Date_First_Seen_ := KEL.era.SimpleRoll(GROUP,Date_First_Seen_,MIN,TRUE),KEL.typ.epoch Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Date_Last_Seen_,MAX,FALSE),From_Person_,To_Person_},From_Person_,To_Person_,MERGE),__ST76400_Layout);
  SHARED __EE71855 := __E_Person_Email;
  SHARED __EE75738 := __EE71855(__NN(__EE71855.Emailof_) AND __NN(__EE71855.Subject_));
  SHARED __ST76412_Layout := RECORD
    KEL.typ.ntyp(E_Person.Typ) Subject_;
    KEL.typ.ntyp(E_Email.Typ) Emailof_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
  END;
  SHARED __EE76416 := DEDUP(PROJECT(__EE75738,__ST76412_Layout),ALL);
  SHARED __ST76438_Layout := RECORD
    KEL.typ.ntyp(E_Person.Typ) From_Person_;
    KEL.typ.ntyp(E_Person.Typ) To_Person_;
    KEL.typ.ntyp(E_Person.Typ) Subject_;
    KEL.typ.ntyp(E_Email.Typ) Emailof_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  __JC76429(__ST76400_Layout __EE76404, __ST76412_Layout __EE76416) := __EEQP(__EE76416.Subject_,__EE76404.From_Person_);
  __ST76438_Layout __JT76429(__ST76400_Layout __l, __ST76412_Layout __r) := TRANSFORM
    SELF := __l;
    SELF := __r;
  END;
  SHARED __EE76436 := JOIN(__EE76404,__EE76416,__JC76429(LEFT,RIGHT),__JT76429(LEFT,RIGHT),INNER,HASH);
  SHARED __ST73042_Layout := RECORD
    KEL.typ.ntyp(E_Email.Typ) UID;
    KEL.typ.ntyp(E_Person.Typ) To_Person_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
  END;
  SHARED __EE76456 := DEDUP(PROJECT(__EE76436,TRANSFORM(__ST73042_Layout,SELF.UID := LEFT.Emailof_,SELF := LEFT)),ALL);
  SHARED __ST73060_Layout := RECORD
    KEL.typ.int C_O_U_N_T___Person_Person_ := 0;
    KEL.typ.ntyp(E_Email.Typ) UID;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
  END;
  SHARED __EE76469 := PROJECT(__CLEANANDDO(__EE76456,TABLE(__EE76456,{KEL.typ.int C_O_U_N_T___Person_Person_ := COUNT(GROUP),UID},UID,MERGE)),__ST73060_Layout);
  SHARED __ST73625_Layout := RECORD
    KEL.typ.nuid UID;
    KEL.typ.ntyp(E_Customer.Typ) _r_Customer_;
    KEL.typ.ndataset(E_Email.Source_Customers_Layout) Source_Customers_;
    KEL.typ.nstr Email_Address_;
    KEL.typ.nint Otto_Email_Id_;
    KEL.typ.ndataset(E_Email.Details_Layout) Details_;
    KEL.typ.int C_O_U_N_T___Person_Person_ := 0;
    KEL.typ.ntyp(E_Email.Typ) U_I_D__1_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  __JC76475(E_Email.Layout __EE71793, __ST73060_Layout __EE76469) := __EEQP(__EE71793.UID,__EE76469.UID);
  __ST73625_Layout __JT76475(E_Email.Layout __l, __ST73060_Layout __r) := TRANSFORM
    SELF.U_I_D__1_ := __r.UID;
    SELF := __l;
    SELF := __r;
  END;
  SHARED __EE76493 := JOIN(__EE71793,__EE76469,__JC76475(LEFT,RIGHT),__JT76475(LEFT,RIGHT),LEFT OUTER,HASH);
  SHARED __EE72133 := __E_Person_Event;
  SHARED __EE74938 := __EE72133(__NN(__EE72133.Subject_));
  SHARED __ST76594_Layout := RECORD
    KEL.typ.ntyp(E_Person.Typ) Subject_;
    KEL.typ.ntyp(E_Event.Typ) Transaction_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  SHARED __EE76598 := PROJECT(TABLE(PROJECT(__EE74938,__ST76594_Layout),{KEL.typ.int __RecordCount := SUM(GROUP,__RecordCount),KEL.typ.epoch Date_First_Seen_ := KEL.era.SimpleRoll(GROUP,Date_First_Seen_,MIN,TRUE),KEL.typ.epoch Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Date_Last_Seen_,MAX,FALSE),Subject_,Transaction_},Subject_,Transaction_,MERGE),__ST76594_Layout);
  SHARED __EE72095 := __E_Person_Event;
  SHARED __EE75261 := __EE72095(__NN(__EE72095.Emailof_) AND __NN(__EE72095.Subject_));
  SHARED __ST76518_Layout := RECORD
    KEL.typ.ntyp(E_Person.Typ) Subject_;
    KEL.typ.ntyp(E_Email.Typ) Emailof_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  SHARED __EE76522 := PROJECT(TABLE(PROJECT(__EE75261,__ST76518_Layout),{KEL.typ.int __RecordCount := SUM(GROUP,__RecordCount),KEL.typ.epoch Date_First_Seen_ := KEL.era.SimpleRoll(GROUP,Date_First_Seen_,MIN,TRUE),KEL.typ.epoch Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Date_Last_Seen_,MAX,FALSE),Subject_,Emailof_},Subject_,Emailof_,MERGE),__ST76518_Layout);
  SHARED __EE75686 := __EE71874(__NN(__EE71874.To_Person_) AND __NN(__EE71874.From_Person_));
  SHARED __ST76530_Layout := RECORD
    KEL.typ.ntyp(E_Person.Typ) From_Person_;
    KEL.typ.ntyp(E_Person.Typ) To_Person_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  SHARED __EE76534 := PROJECT(TABLE(PROJECT(__EE75686,__ST76530_Layout),{KEL.typ.int __RecordCount := SUM(GROUP,__RecordCount),KEL.typ.epoch Date_First_Seen_ := KEL.era.SimpleRoll(GROUP,Date_First_Seen_,MIN,TRUE),KEL.typ.epoch Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Date_Last_Seen_,MAX,FALSE),From_Person_,To_Person_},From_Person_,To_Person_,MERGE),__ST76530_Layout);
  SHARED __ST76556_Layout := RECORD
    KEL.typ.ntyp(E_Person.Typ) Subject_;
    KEL.typ.ntyp(E_Email.Typ) Emailof_;
    KEL.typ.ntyp(E_Person.Typ) From_Person_;
    KEL.typ.ntyp(E_Person.Typ) To_Person_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  __JC76547(__ST76518_Layout __EE76522, __ST76530_Layout __EE76534) := __EEQP(__EE76522.Subject_,__EE76534.From_Person_);
  __ST76556_Layout __JT76547(__ST76518_Layout __l, __ST76530_Layout __r) := TRANSFORM
    SELF := __l;
    SELF := __r;
  END;
  SHARED __EE76554 := JOIN(__EE76522,__EE76534,__JC76547(LEFT,RIGHT),__JT76547(LEFT,RIGHT),INNER,HASH);
  SHARED __ST76606_Layout := RECORD
    KEL.typ.ntyp(E_Email.Typ) Emailof_;
    KEL.typ.ntyp(E_Person.Typ) To_Person_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
  END;
  SHARED __EE76610 := DEDUP(PROJECT(__EE76554,__ST76606_Layout),ALL);
  SHARED __ST76618_Layout := RECORD
    KEL.typ.ntyp(E_Email.Typ) Emailof__1_;
    KEL.typ.ntyp(E_Person.Typ) To_Person_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
  END;
  SHARED __EE76622 := PROJECT(__EE76610,TRANSFORM(__ST76618_Layout,SELF.Emailof__1_ := LEFT.Emailof_,SELF := LEFT));
  SHARED __ST76638_Layout := RECORD
    KEL.typ.ntyp(E_Person.Typ) Subject_;
    KEL.typ.ntyp(E_Event.Typ) Transaction_;
    KEL.typ.ntyp(E_Email.Typ) Emailof__1_;
    KEL.typ.ntyp(E_Person.Typ) To_Person_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  __JC76629(__ST76594_Layout __EE76598, __ST76618_Layout __EE76622) := __EEQP(__EE76622.To_Person_,__EE76598.Subject_);
  __ST76638_Layout __JT76629(__ST76594_Layout __l, __ST76618_Layout __r) := TRANSFORM
    SELF := __l;
    SELF := __r;
  END;
  SHARED __EE76636 := JOIN(__EE76622,__EE76598,__JC76629(RIGHT,LEFT),__JT76629(RIGHT,LEFT),INNER,HASH);
  SHARED __ST72803_Layout := RECORD
    KEL.typ.ntyp(E_Email.Typ) UID;
    KEL.typ.ntyp(E_Event.Typ) Transaction_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
  END;
  SHARED __EE76656 := DEDUP(PROJECT(__EE76636,TRANSFORM(__ST72803_Layout,SELF.UID := LEFT.Emailof__1_,SELF := LEFT)),ALL);
  SHARED __ST72821_Layout := RECORD
    KEL.typ.int C_O_U_N_T___Person_Event_ := 0;
    KEL.typ.ntyp(E_Email.Typ) UID;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
  END;
  SHARED __EE76669 := PROJECT(__CLEANANDDO(__EE76656,TABLE(__EE76656,{KEL.typ.int C_O_U_N_T___Person_Event_ := COUNT(GROUP),UID},UID,MERGE)),__ST72821_Layout);
  SHARED __ST73734_Layout := RECORD
    KEL.typ.nuid UID;
    KEL.typ.ntyp(E_Customer.Typ) _r_Customer_;
    KEL.typ.ndataset(E_Email.Source_Customers_Layout) Source_Customers_;
    KEL.typ.nstr Email_Address_;
    KEL.typ.nint Otto_Email_Id_;
    KEL.typ.ndataset(E_Email.Details_Layout) Details_;
    KEL.typ.int C_O_U_N_T___Person_Person_ := 0;
    KEL.typ.ntyp(E_Email.Typ) U_I_D__1_;
    KEL.typ.int C_O_U_N_T___Person_Event_ := 0;
    KEL.typ.ntyp(E_Email.Typ) U_I_D__2_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  __JC76677(__ST73625_Layout __EE76493, __ST72821_Layout __EE76669) := __EEQP(__EE76493.UID,__EE76669.UID);
  __ST73734_Layout __JT76677(__ST73625_Layout __l, __ST72821_Layout __r) := TRANSFORM
    SELF.U_I_D__2_ := __r.UID;
    SELF := __l;
    SELF := __r;
  END;
  SHARED __EE76697 := JOIN(__EE76493,__EE76669,__JC76677(LEFT,RIGHT),__JT76677(LEFT,RIGHT),LEFT OUTER,HASH);
  SHARED __EE75924 := __EE75686;
  SHARED __EE71892 := __ENH_Person_3;
  SHARED __EE75906 := __EE71892;
  SHARED __EE76190 := __EE75906(__EE75906.Vl_Event7_Active_Flag_ = 1);
  __JC76198(E_Person_Person.Layout __EE75924, B_Person_3.__ST13340_Layout __EE76190) := __EEQP(__EE75924.To_Person_,__EE76190.UID);
  SHARED __EE76199 := JOIN(__EE75924,__EE76190,__JC76198(LEFT,RIGHT),TRANSFORM(E_Person_Person.Layout,SELF:=LEFT),HASH,KEEP(1));
  SHARED __ST76724_Layout := RECORD
    KEL.typ.ntyp(E_Person.Typ) From_Person_;
    KEL.typ.ntyp(E_Person.Typ) To_Person_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  SHARED __EE76728 := PROJECT(TABLE(PROJECT(__EE76199,__ST76724_Layout),{KEL.typ.int __RecordCount := SUM(GROUP,__RecordCount),KEL.typ.epoch Date_First_Seen_ := KEL.era.SimpleRoll(GROUP,Date_First_Seen_,MIN,TRUE),KEL.typ.epoch Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Date_Last_Seen_,MAX,FALSE),From_Person_,To_Person_},From_Person_,To_Person_,MERGE),__ST76724_Layout);
  SHARED __ST76752_Layout := RECORD
    KEL.typ.ntyp(E_Person.Typ) From_Person_;
    KEL.typ.ntyp(E_Person.Typ) To_Person_;
    KEL.typ.ntyp(E_Person.Typ) Subject_;
    KEL.typ.ntyp(E_Email.Typ) Emailof_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  __JC76743(__ST76724_Layout __EE76728, __ST76412_Layout __EE76416) := __EEQP(__EE76416.Subject_,__EE76728.From_Person_);
  __ST76752_Layout __JT76743(__ST76724_Layout __l, __ST76412_Layout __r) := TRANSFORM
    SELF := __l;
    SELF := __r;
  END;
  SHARED __EE76750 := JOIN(__EE76416,__EE76728,__JC76743(RIGHT,LEFT),__JT76743(RIGHT,LEFT),INNER,HASH);
  SHARED __ST72582_Layout := RECORD
    KEL.typ.ntyp(E_Email.Typ) UID;
    KEL.typ.ntyp(E_Person.Typ) To_Person_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
  END;
  SHARED __EE76770 := DEDUP(PROJECT(__EE76750,TRANSFORM(__ST72582_Layout,SELF.UID := LEFT.Emailof_,SELF := LEFT)),ALL);
  SHARED __ST72600_Layout := RECORD
    KEL.typ.int C_O_U_N_T___Person_Person_ := 0;
    KEL.typ.ntyp(E_Email.Typ) UID;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
  END;
  SHARED __EE76783 := PROJECT(__CLEANANDDO(__EE76770,TABLE(__EE76770,{KEL.typ.int C_O_U_N_T___Person_Person_ := COUNT(GROUP),UID},UID,MERGE)),__ST72600_Layout);
  SHARED __ST73842_Layout := RECORD
    KEL.typ.nuid UID;
    KEL.typ.ntyp(E_Customer.Typ) _r_Customer_;
    KEL.typ.ndataset(E_Email.Source_Customers_Layout) Source_Customers_;
    KEL.typ.nstr Email_Address_;
    KEL.typ.nint Otto_Email_Id_;
    KEL.typ.ndataset(E_Email.Details_Layout) Details_;
    KEL.typ.int C_O_U_N_T___Person_Person_ := 0;
    KEL.typ.ntyp(E_Email.Typ) U_I_D__1_;
    KEL.typ.int C_O_U_N_T___Person_Event_ := 0;
    KEL.typ.ntyp(E_Email.Typ) U_I_D__2_;
    KEL.typ.int C_O_U_N_T___Person_Person__1_ := 0;
    KEL.typ.ntyp(E_Email.Typ) U_I_D__3_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  __JC76791(__ST73734_Layout __EE76697, __ST72600_Layout __EE76783) := __EEQP(__EE76697.UID,__EE76783.UID);
  __ST73842_Layout __JT76791(__ST73734_Layout __l, __ST72600_Layout __r) := TRANSFORM
    SELF.C_O_U_N_T___Person_Person__1_ := __r.C_O_U_N_T___Person_Person_;
    SELF.U_I_D__3_ := __r.UID;
    SELF := __l;
    SELF := __r;
  END;
  SHARED __EE76815 := JOIN(__EE76697,__EE76783,__JC76791(LEFT,RIGHT),__JT76791(LEFT,RIGHT),LEFT OUTER,HASH);
  SHARED __EE72416 := __EE71892(__EE71892.Vl_Event30_Active_Flag_ = 1);
  __JC75698(E_Person_Person.Layout __EE75686, B_Person_3.__ST13340_Layout __EE72416) := __EEQP(__EE75686.To_Person_,__EE72416.UID);
  SHARED __EE75699 := JOIN(__EE75686,__EE72416,__JC75698(LEFT,RIGHT),TRANSFORM(E_Person_Person.Layout,SELF:=LEFT),HASH,KEEP(1));
  SHARED __ST76846_Layout := RECORD
    KEL.typ.ntyp(E_Person.Typ) From_Person_;
    KEL.typ.ntyp(E_Person.Typ) To_Person_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  SHARED __EE76850 := PROJECT(TABLE(PROJECT(__EE75699,__ST76846_Layout),{KEL.typ.int __RecordCount := SUM(GROUP,__RecordCount),KEL.typ.epoch Date_First_Seen_ := KEL.era.SimpleRoll(GROUP,Date_First_Seen_,MIN,TRUE),KEL.typ.epoch Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Date_Last_Seen_,MAX,FALSE),From_Person_,To_Person_},From_Person_,To_Person_,MERGE),__ST76846_Layout);
  SHARED __ST76874_Layout := RECORD
    KEL.typ.ntyp(E_Person.Typ) From_Person_;
    KEL.typ.ntyp(E_Person.Typ) To_Person_;
    KEL.typ.ntyp(E_Person.Typ) Subject_;
    KEL.typ.ntyp(E_Email.Typ) Emailof_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  __JC76865(__ST76846_Layout __EE76850, __ST76412_Layout __EE76416) := __EEQP(__EE76416.Subject_,__EE76850.From_Person_);
  __ST76874_Layout __JT76865(__ST76846_Layout __l, __ST76412_Layout __r) := TRANSFORM
    SELF := __l;
    SELF := __r;
  END;
  SHARED __EE76872 := JOIN(__EE76416,__EE76850,__JC76865(RIGHT,LEFT),__JT76865(RIGHT,LEFT),INNER,HASH);
  SHARED __ST72344_Layout := RECORD
    KEL.typ.ntyp(E_Email.Typ) UID;
    KEL.typ.ntyp(E_Person.Typ) To_Person_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
  END;
  SHARED __EE76892 := DEDUP(PROJECT(__EE76872,TRANSFORM(__ST72344_Layout,SELF.UID := LEFT.Emailof_,SELF := LEFT)),ALL);
  SHARED __ST72362_Layout := RECORD
    KEL.typ.int C_O_U_N_T___Person_Person_ := 0;
    KEL.typ.ntyp(E_Email.Typ) UID;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
  END;
  SHARED __EE76905 := PROJECT(__CLEANANDDO(__EE76892,TABLE(__EE76892,{KEL.typ.int C_O_U_N_T___Person_Person_ := COUNT(GROUP),UID},UID,MERGE)),__ST72362_Layout);
  SHARED __ST73951_Layout := RECORD
    KEL.typ.nuid UID;
    KEL.typ.ntyp(E_Customer.Typ) _r_Customer_;
    KEL.typ.ndataset(E_Email.Source_Customers_Layout) Source_Customers_;
    KEL.typ.nstr Email_Address_;
    KEL.typ.nint Otto_Email_Id_;
    KEL.typ.ndataset(E_Email.Details_Layout) Details_;
    KEL.typ.int C_O_U_N_T___Person_Person_ := 0;
    KEL.typ.ntyp(E_Email.Typ) U_I_D__1_;
    KEL.typ.int C_O_U_N_T___Person_Event_ := 0;
    KEL.typ.ntyp(E_Email.Typ) U_I_D__2_;
    KEL.typ.int C_O_U_N_T___Person_Person__1_ := 0;
    KEL.typ.ntyp(E_Email.Typ) U_I_D__3_;
    KEL.typ.int C_O_U_N_T___Person_Person__2_ := 0;
    KEL.typ.ntyp(E_Email.Typ) U_I_D__4_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  __JC76913(__ST73842_Layout __EE76815, __ST72362_Layout __EE76905) := __EEQP(__EE76815.UID,__EE76905.UID);
  __ST73951_Layout __JT76913(__ST73842_Layout __l, __ST72362_Layout __r) := TRANSFORM
    SELF.C_O_U_N_T___Person_Person__2_ := __r.C_O_U_N_T___Person_Person_;
    SELF.U_I_D__4_ := __r.UID;
    SELF := __l;
    SELF := __r;
  END;
  SHARED __EE76939 := JOIN(__EE76815,__EE76905,__JC76913(LEFT,RIGHT),__JT76913(LEFT,RIGHT),LEFT OUTER,HASH);
  EXPORT __ST12551_Layout := RECORD
    KEL.typ.nuid UID;
    KEL.typ.ntyp(E_Customer.Typ) _r_Customer_;
    KEL.typ.ndataset(E_Email.Source_Customers_Layout) Source_Customers_;
    KEL.typ.nstr Email_Address_;
    KEL.typ.nint Otto_Email_Id_;
    KEL.typ.ndataset(E_Email.Details_Layout) Details_;
    KEL.typ.int Cl_Active30_Identity_Count_ := 0;
    KEL.typ.int Cl_Active7_Identity_Count_ := 0;
    KEL.typ.int Cl_Event_Count_ := 0;
    KEL.typ.int Cl_Identity_Count_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  SHARED __ST12551_Layout __ND76969__Project(__ST73951_Layout __PP76940) := TRANSFORM
    SELF.Cl_Active30_Identity_Count_ := __PP76940.C_O_U_N_T___Person_Person__2_;
    SELF.Cl_Active7_Identity_Count_ := __PP76940.C_O_U_N_T___Person_Person__1_;
    SELF.Cl_Event_Count_ := __PP76940.C_O_U_N_T___Person_Event_;
    SELF.Cl_Identity_Count_ := __PP76940.C_O_U_N_T___Person_Person_;
    SELF := __PP76940;
  END;
  EXPORT __ENH_Email_2 := PROJECT(__EE76939,__ND76969__Project(LEFT));
END;
