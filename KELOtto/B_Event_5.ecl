﻿//HPCC Systems KEL Compiler Version 0.11.0
IMPORT KEL011 AS KEL;
IMPORT B_Event_6,B_Person_6,B_Person_7,E_Address,E_Customer,E_Event,E_Person FROM KELOtto;
IMPORT * FROM KEL011.Null;
EXPORT B_Event_5 := MODULE
  SHARED VIRTUAL TYPEOF(B_Event_6.__ENH_Event_6) __ENH_Event_6 := B_Event_6.__ENH_Event_6;
  SHARED VIRTUAL TYPEOF(B_Person_6.__ENH_Person_6) __ENH_Person_6 := B_Person_6.__ENH_Person_6;
  SHARED __EE7094 := __ENH_Event_6;
  SHARED __EE7149 := __ENH_Person_6;
  SHARED __ST7204_Layout := RECORD
    KEL.typ.nuid UID;
    KEL.typ.ntyp(E_Customer.Typ) _r_Customer_;
    KEL.typ.ndataset(E_Event.Source_Customers_Layout) Source_Customers_;
    KEL.typ.ntyp(E_Person.Typ) Subject_;
    KEL.typ.ntyp(E_Address.Typ) Location_;
    KEL.typ.nkdate Event_Date_;
    KEL.typ.int Deceased_Prior_To_Event_ := 0;
    KEL.typ.int In_Customer_Population_ := 0;
    KEL.typ.nuid U_I_D__1_;
    KEL.typ.ntyp(E_Customer.Typ) _r_Customer__1_;
    KEL.typ.nint Lex_Id_;
    KEL.typ.ndataset(E_Person.Source_Customers_Layout) Source_Customers__1_;
    KEL.typ.ndataset(E_Person.Reported_Date_Of_Birth_Layout) Reported_Date_Of_Birth_;
    KEL.typ.ndataset(E_Person.Full_Name_Layout) Full_Name_;
    KEL.typ.nkdate Deceased_Date_;
    KEL.typ.nkdate Deceased_Date_Of_Birth_;
    KEL.typ.nstr Deceased_First_;
    KEL.typ.nstr Deceased_Middle_;
    KEL.typ.nstr Deceased_Last_;
    KEL.typ.nstr Deceased_Match_Code_;
    KEL.typ.nbool _isdeepdive_;
    KEL.typ.nstr _county__death_;
    KEL.typ.nstr Deceased_Ssn_;
    KEL.typ.nstr _state__death__flag_;
    KEL.typ.nstr _death__rec__src_;
    KEL.typ.nstr _state__death__id_;
    KEL.typ.nstr _verfirst_;
    KEL.typ.nstr _verlast_;
    KEL.typ.nstr _veraddr_;
    KEL.typ.nstr _vercity_;
    KEL.typ.nstr _verstate_;
    KEL.typ.nstr _verzip_;
    KEL.typ.nstr _verzip4_;
    KEL.typ.nstr _verssn_;
    KEL.typ.nstr _verdob_;
    KEL.typ.nstr _verhphone_;
    KEL.typ.nstr _verify__addr_;
    KEL.typ.nstr _verify__dob_;
    KEL.typ.nstr _valid__ssn_;
    KEL.typ.nint _nas__summary_;
    KEL.typ.nint _nap__summary_;
    KEL.typ.nstr _cvi_;
    KEL.typ.nstr _hri__1_;
    KEL.typ.nstr _hri__desc__1_;
    KEL.typ.nstr _hri__2_;
    KEL.typ.nstr _hri__desc__2_;
    KEL.typ.nstr _hri__3_;
    KEL.typ.nstr _hri__desc__3_;
    KEL.typ.nstr _hri__4_;
    KEL.typ.nstr _hri__desc__4_;
    KEL.typ.nstr _hri__5_;
    KEL.typ.nstr _hri__desc__5_;
    KEL.typ.nstr _hri__6_;
    KEL.typ.nstr _hri__desc__6_;
    KEL.typ.nstr _additional__fname__1_;
    KEL.typ.nstr _additional__lname__1_;
    KEL.typ.nstr _additional__lname__date__last__1_;
    KEL.typ.nstr _additional__fname__2_;
    KEL.typ.nstr _additional__lname__2_;
    KEL.typ.nstr _additional__lname__date__last__2_;
    KEL.typ.nstr _additional__fname__3_;
    KEL.typ.nstr _additional__lname__3_;
    KEL.typ.nstr _additional__lname__date__last__3_;
    KEL.typ.nint _subjectssncount_;
    KEL.typ.nstr _dobmatchlevel_;
    KEL.typ.nstr _hri__7_;
    KEL.typ.nstr _hri__desc__7_;
    KEL.typ.nstr _hri__8_;
    KEL.typ.nstr _hri__desc__8_;
    KEL.typ.nstr _hri__9_;
    KEL.typ.nstr _hri__desc__9_;
    KEL.typ.nstr _hri__10_;
    KEL.typ.nstr _hri__desc__10_;
    KEL.typ.nstr _hri__11_;
    KEL.typ.nstr _hri__desc__11_;
    KEL.typ.nstr _hri__12_;
    KEL.typ.nstr _hri__desc__12_;
    KEL.typ.nstr _hri__13_;
    KEL.typ.nstr _hri__desc__13_;
    KEL.typ.nstr _hri__14_;
    KEL.typ.nstr _hri__desc__14_;
    KEL.typ.nstr _hri__15_;
    KEL.typ.nstr _hri__desc__15_;
    KEL.typ.nstr _hri__16_;
    KEL.typ.nstr _hri__desc__16_;
    KEL.typ.nstr _hri__17_;
    KEL.typ.nstr _hri__desc__17_;
    KEL.typ.nstr _hri__18_;
    KEL.typ.nstr _hri__desc__18_;
    KEL.typ.nstr _hri__19_;
    KEL.typ.nstr _hri__desc__19_;
    KEL.typ.nstr _hri__20_;
    KEL.typ.nstr _hri__desc__20_;
    KEL.typ.nbool _ssnfoundforlexid_;
    KEL.typ.nbool _addresspobox_;
    KEL.typ.nbool _addresscmra_;
    KEL.typ.nstr _cvicustomscore_;
    KEL.typ.nint Subject_Ssn_Count_;
    KEL.typ.nint Date_Of_Birth_Match_Level_;
    KEL.typ.nint Stolen_Identity_Index_;
    KEL.typ.nint Synthetic_Identity_Index_;
    KEL.typ.nint Manipulated_Identity_Index_;
    KEL.typ.nint Vulnerable_Victim_Index_;
    KEL.typ.nint Friendlyfraud_Index_;
    KEL.typ.nint Suspicious_Activity_Index_;
    KEL.typ.nint _v2__sourcerisklevel_;
    KEL.typ.nint _v2__assocsuspicousidentitiescount_;
    KEL.typ.nint _v2__assoccreditbureauonlycount_;
    KEL.typ.nint _v2__validationaddrproblems_;
    KEL.typ.nint _v2__validationipproblems_;
    KEL.typ.nstr _v2__ipstate_;
    KEL.typ.nstr _v2__ipcountry_;
    KEL.typ.nstr _v2__ipcontinent_;
    KEL.typ.nint _v2__inputaddrageoldest_;
    KEL.typ.nstr _v2__inputaddrdwelltype_;
    KEL.typ.nint _v2__divssnidentitycountnew_;
    KEL.typ.int Deceased_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  __JC7201(B_Event_6.__ST4406_Layout __EE7094, B_Person_7.__ST4763_Layout __EE7149) := __EEQP(__EE7094.Subject_,__EE7149.UID);
  __ST7204_Layout __JT7201(B_Event_6.__ST4406_Layout __l, B_Person_7.__ST4763_Layout __r) := TRANSFORM
    SELF.U_I_D__1_ := __r.UID;
    SELF._r_Customer__1_ := __r._r_Customer_;
    SELF.Source_Customers__1_ := __r.Source_Customers_;
    SELF := __l;
    SELF := __r;
  END;
  SHARED __EE7202 := JOIN(__EE7094,__EE7149,__JC7201(LEFT,RIGHT),__JT7201(LEFT,RIGHT),LEFT OUTER,HASH);
  EXPORT __ST4149_Layout := RECORD
    KEL.typ.nuid UID;
    KEL.typ.ntyp(E_Customer.Typ) _r_Customer_;
    KEL.typ.ndataset(E_Event.Source_Customers_Layout) Source_Customers_;
    KEL.typ.ntyp(E_Person.Typ) Subject_;
    KEL.typ.ntyp(E_Address.Typ) Location_;
    KEL.typ.nkdate Event_Date_;
    KEL.typ.int Deceased_Prior_To_Event_ := 0;
    KEL.typ.nint Deceased_To_Event_Year_Diff_;
    KEL.typ.int In_Customer_Population_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  SHARED __ST4149_Layout __ND7418__Project(__ST7204_Layout __PP7403) := TRANSFORM
    SELF.Deceased_To_Event_Year_Diff_ := __FN2(KEL.Routines.YearsBetween,__PP7403.Event_Date_,__PP7403.Deceased_Date_);
    SELF := __PP7403;
  END;
  EXPORT __ENH_Event_5 := PROJECT(__EE7202,__ND7418__Project(LEFT));
END;
