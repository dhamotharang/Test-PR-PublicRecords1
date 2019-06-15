﻿//HPCC Systems KEL Compiler Version 0.11.0
IMPORT KEL011 AS KEL;
IMPORT B_Customer_1,B_Email_1,B_Event_1,E_Address,E_Customer,E_Email,E_Email_Event,E_Event,E_Person,E_Person_Email FROM KELOtto;
IMPORT * FROM KEL011.Null;
EXPORT B_Email := MODULE
  SHARED VIRTUAL TYPEOF(B_Customer_1.__ENH_Customer_1) __ENH_Customer_1 := B_Customer_1.__ENH_Customer_1;
  SHARED VIRTUAL TYPEOF(B_Email_1.__ENH_Email_1) __ENH_Email_1 := B_Email_1.__ENH_Email_1;
  SHARED VIRTUAL TYPEOF(E_Email_Event.__Result) __E_Email_Event := E_Email_Event.__Result;
  SHARED VIRTUAL TYPEOF(B_Event_1.__ENH_Event_1) __ENH_Event_1 := B_Event_1.__ENH_Event_1;
  SHARED VIRTUAL TYPEOF(E_Person_Email.__Result) __E_Person_Email := E_Person_Email.__Result;
  SHARED __EE398792 := __ENH_Email_1;
  SHARED __EE406469 := __E_Person_Email;
  SHARED __EE406476 := __EE406469(__NN(__EE406469.Emailof_));
  SHARED __ST402399_Layout := RECORD
    KEL.typ.ntyp(E_Email.Typ) UID;
    KEL.typ.ntyp(E_Person.Typ) Subject_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
  END;
  SHARED __EE406490 := DEDUP(PROJECT(__EE406476,TRANSFORM(__ST402399_Layout,SELF.UID := LEFT.Emailof_,SELF := LEFT)),ALL);
  SHARED __ST402417_Layout := RECORD
    KEL.typ.int C_O_U_N_T___Person_Email_ := 0;
    KEL.typ.ntyp(E_Email.Typ) UID;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
  END;
  SHARED __EE406456 := PROJECT(__CLEANANDDO(__EE406490,TABLE(__EE406490,{KEL.typ.int C_O_U_N_T___Person_Email_ := COUNT(GROUP),UID},UID,MERGE)),__ST402417_Layout);
  SHARED __ST403151_Layout := RECORD
    KEL.typ.nuid UID;
    KEL.typ.ntyp(E_Customer.Typ) _r_Customer_;
    KEL.typ.ndataset(E_Email.Source_Customers_Layout) Source_Customers_;
    KEL.typ.nstr Email_Address_;
    KEL.typ.nint Otto_Email_Id_;
    KEL.typ.ndataset(E_Email.Details_Layout) Details_;
    KEL.typ.int Cl_Active30_Identity_Count_ := 0;
    KEL.typ.nint Cl_Active30_Identity_Count_Percentile_;
    KEL.typ.int Cl_Active7_Identity_Count_ := 0;
    KEL.typ.nint Cl_Active7_Identity_Count_Percentile_;
    KEL.typ.int Cl_Event_Count_ := 0;
    KEL.typ.nint Cl_Event_Count_Percentile_;
    KEL.typ.int Cl_Identity_Count_ := 0;
    KEL.typ.nint Cl_Identity_Count_Percentile_;
    KEL.typ.int Vl_Event30_All_Day_Count_ := 0;
    KEL.typ.int Vl_Event30_Count_ := 0;
    KEL.typ.int Vl_Event7_All_Count_ := 0;
    KEL.typ.int Vl_Event7_Count_ := 0;
    KEL.typ.int C_O_U_N_T___Person_Email_ := 0;
    KEL.typ.ntyp(E_Email.Typ) U_I_D__1_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  __JC406499(B_Email_1.__ST19415_Layout __EE398792, __ST402417_Layout __EE406456) := __EEQP(__EE398792.UID,__EE406456.UID);
  __ST403151_Layout __JT406499(B_Email_1.__ST19415_Layout __l, __ST402417_Layout __r) := TRANSFORM
    SELF.U_I_D__1_ := __r.UID;
    SELF := __l;
    SELF := __r;
  END;
  SHARED __EE406500 := JOIN(__EE398792,__EE406456,__JC406499(LEFT,RIGHT),__JT406499(LEFT,RIGHT),LEFT OUTER,HASH);
  SHARED __EE406434 := __E_Email_Event;
  SHARED __EE406441 := __EE406434(__NN(__EE406434.Emailof_));
  SHARED __ST402112_Layout := RECORD
    KEL.typ.int C_O_U_N_T___Email_Event_ := 0;
    KEL.typ.ntyp(E_Email.Typ) UID;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
  END;
  SHARED __EE406432 := PROJECT(__CLEANANDDO(__EE406441,TABLE(__EE406441,{KEL.typ.int C_O_U_N_T___Email_Event_ := COUNT(GROUP),KEL.typ.ntyp(E_Email.Typ) UID := __EE406441.Emailof_},Emailof_,MERGE)),__ST402112_Layout);
  SHARED __ST403443_Layout := RECORD
    KEL.typ.nuid UID;
    KEL.typ.ntyp(E_Customer.Typ) _r_Customer_;
    KEL.typ.ndataset(E_Email.Source_Customers_Layout) Source_Customers_;
    KEL.typ.nstr Email_Address_;
    KEL.typ.nint Otto_Email_Id_;
    KEL.typ.ndataset(E_Email.Details_Layout) Details_;
    KEL.typ.int Cl_Active30_Identity_Count_ := 0;
    KEL.typ.nint Cl_Active30_Identity_Count_Percentile_;
    KEL.typ.int Cl_Active7_Identity_Count_ := 0;
    KEL.typ.nint Cl_Active7_Identity_Count_Percentile_;
    KEL.typ.int Cl_Event_Count_ := 0;
    KEL.typ.nint Cl_Event_Count_Percentile_;
    KEL.typ.int Cl_Identity_Count_ := 0;
    KEL.typ.nint Cl_Identity_Count_Percentile_;
    KEL.typ.int Vl_Event30_All_Day_Count_ := 0;
    KEL.typ.int Vl_Event30_Count_ := 0;
    KEL.typ.int Vl_Event7_All_Count_ := 0;
    KEL.typ.int Vl_Event7_Count_ := 0;
    KEL.typ.int C_O_U_N_T___Person_Email_ := 0;
    KEL.typ.ntyp(E_Email.Typ) U_I_D__1_;
    KEL.typ.int C_O_U_N_T___Email_Event_ := 0;
    KEL.typ.ntyp(E_Email.Typ) U_I_D__2_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  __JC406509(__ST403151_Layout __EE406500, __ST402112_Layout __EE406432) := __EEQP(__EE406500.UID,__EE406432.UID);
  __ST403443_Layout __JT406509(__ST403151_Layout __l, __ST402112_Layout __r) := TRANSFORM
    SELF.U_I_D__2_ := __r.UID;
    SELF := __l;
    SELF := __r;
  END;
  SHARED __EE406510 := JOIN(__EE406500,__EE406432,__JC406509(LEFT,RIGHT),__JT406509(LEFT,RIGHT),LEFT OUTER,HASH);
  SHARED __EE406460 := __ENH_Event_1;
  SHARED __EE407982 := __EE406434;
  SHARED __EE407995 := __EE407982(__NN(__EE407982.Emailof_) AND __NN(__EE407982.Transaction_));
  SHARED __ST402747_Layout := RECORD
    KEL.typ.nuid UID;
    KEL.typ.ntyp(E_Customer.Typ) _r_Customer_;
    KEL.typ.ndataset(E_Event.Source_Customers_Layout) Source_Customers_;
    KEL.typ.ntyp(E_Person.Typ) Subject_;
    KEL.typ.ntyp(E_Address.Typ) Location_;
    KEL.typ.nint Record_Id_;
    KEL.typ.nkdate Event_Date_;
    KEL.typ.ndataset(E_Event.Event_Types_Layout) Event_Types_;
    KEL.typ.nint Otto_Address_Id_;
    KEL.typ.nkdate Date_Of_Birth_;
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
    KEL.typ.nint _relativeaddressmatch_;
    KEL.typ.nstr _cvi_;
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
    KEL.typ.nbool _ssnfoundforlexid_;
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
    KEL.typ.nint _v2__inputaddrageoldest_;
    KEL.typ.nstr _v2__inputaddrdwelltype_;
    KEL.typ.nstr _v2__divssnidentitycountnew_;
    KEL.typ.ndataset(E_Event.Hri_List_Layout) Hri_List_;
    KEL.typ.nstr Ip_Address_;
    KEL.typ.nstr _iprngbeg_;
    KEL.typ.nstr _iprngend_;
    KEL.typ.nstr _edgecountry_;
    KEL.typ.nstr _edgeregion_;
    KEL.typ.nstr _edgecity_;
    KEL.typ.nstr _edgeconnspeed_;
    KEL.typ.nstr _edgemetrocode_;
    KEL.typ.nstr _edgelatitude_;
    KEL.typ.nstr _edgelongitude_;
    KEL.typ.nstr _edgepostalcode_;
    KEL.typ.nstr _edgecountrycode_;
    KEL.typ.nstr _edgeregioncode_;
    KEL.typ.nstr _edgecitycode_;
    KEL.typ.nstr _edgecontinentcode_;
    KEL.typ.nstr _edgetwolettercountry_;
    KEL.typ.nstr _edgeinternalcode_;
    KEL.typ.nstr _edgeareacodes_;
    KEL.typ.nstr _edgecountryconf_;
    KEL.typ.nstr _edgeregionconf_;
    KEL.typ.nstr _edgecitycong_;
    KEL.typ.nstr _edgepostalconf_;
    KEL.typ.nstr _edgegmtoffset_;
    KEL.typ.nstr _edgeindst_;
    KEL.typ.nstr _siccode_;
    KEL.typ.nstr _domainname_;
    KEL.typ.nstr _ispname_;
    KEL.typ.nstr _homebiztype_;
    KEL.typ.nstr _asn_;
    KEL.typ.nstr _asnname_;
    KEL.typ.nstr _primarylang_;
    KEL.typ.nstr _secondarylang_;
    KEL.typ.nstr _proxytype_;
    KEL.typ.nstr _proxydescription_;
    KEL.typ.nstr _isanisp_;
    KEL.typ.nstr _companyname_;
    KEL.typ.nstr _ranks_;
    KEL.typ.nstr _households_;
    KEL.typ.nstr _women_;
    KEL.typ.nstr _women18to34_;
    KEL.typ.nstr _women35to49_;
    KEL.typ.nstr _men_;
    KEL.typ.nstr _men18to34_;
    KEL.typ.nstr _men35to49_;
    KEL.typ.nstr _teens_;
    KEL.typ.nstr _kids_;
    KEL.typ.nstr _naicscode_;
    KEL.typ.nstr _cbsacode_;
    KEL.typ.nstr _cbsatitle_;
    KEL.typ.nstr _cbsatype_;
    KEL.typ.nstr _csacode_;
    KEL.typ.nstr _csatitle_;
    KEL.typ.nstr _mdcode_;
    KEL.typ.nstr _mdtitle_;
    KEL.typ.nstr _organizationname_;
    KEL.typ.nint Confidence__that__activity__was__deceitful__id_;
    KEL.typ.nint _name__risk__code_;
    KEL.typ.nint _dob__risk__code_;
    KEL.typ.nint _ssn__risk__code_;
    KEL.typ.nint _drivers__license__risk__code_;
    KEL.typ.nint _physical__address__risk__code_;
    KEL.typ.nint _phone__risk__code_;
    KEL.typ.nint _cell__phone__risk__code_;
    KEL.typ.nint _work__phone__risk__code_;
    KEL.typ.nint _bank__account__1__risk__code_;
    KEL.typ.nint _bank__account__2__risk__code_;
    KEL.typ.nint _email__address__risk__code_;
    KEL.typ.nint _ip__address__fraud__code_;
    KEL.typ.nint _business__risk__code_;
    KEL.typ.nint _mailing__address__risk__code_;
    KEL.typ.nint _device__risk__code_;
    KEL.typ.nint _identity__risk__code_;
    KEL.typ.nint Age_;
    KEL.typ.int Contributor_Safe_Flag_ := 0;
    KEL.typ.int Deceased_Prior_To_Event_ := 0;
    KEL.typ.nint Deceased_To_Event_Year_Diff_;
    KEL.typ.nbool Demo_Customer_;
    KEL.typ.int Hri03_Flag_ := 0;
    KEL.typ.int Hri06_Flag_ := 0;
    KEL.typ.int Hri07_Flag_ := 0;
    KEL.typ.int Hri08_Flag_ := 0;
    KEL.typ.int Hri11_Flag_ := 0;
    KEL.typ.int Hri12_Flag_ := 0;
    KEL.typ.int Hri14_Flag_ := 0;
    KEL.typ.int Hri15_Flag_ := 0;
    KEL.typ.int Hri19_Flag_ := 0;
    KEL.typ.int Hri25_Flag_ := 0;
    KEL.typ.int Hri26_Flag_ := 0;
    KEL.typ.int Hri27_Flag_ := 0;
    KEL.typ.int Hri28_Flag_ := 0;
    KEL.typ.int Hri29_Flag_ := 0;
    KEL.typ.int Hri30_Flag_ := 0;
    KEL.typ.int Hri31_Flag_ := 0;
    KEL.typ.int Hri37_Flag_ := 0;
    KEL.typ.int Hri38_Flag_ := 0;
    KEL.typ.int Hri41_Flag_ := 0;
    KEL.typ.int Hri48_Flag_ := 0;
    KEL.typ.int Hri50_Flag_ := 0;
    KEL.typ.int Hri51_Flag_ := 0;
    KEL.typ.int Hri52_Flag_ := 0;
    KEL.typ.int Hri71_Flag_ := 0;
    KEL.typ.int Hri83_Flag_ := 0;
    KEL.typ.int Hri90_Flag_ := 0;
    KEL.typ.int Hri_Cl_Flag_ := 0;
    KEL.typ.int Hri_Co_Flag_ := 0;
    KEL.typ.int Hri_Dd_Flag_ := 0;
    KEL.typ.int Hri_Df_Flag_ := 0;
    KEL.typ.int Hri_It_Flag_ := 0;
    KEL.typ.int Hri_Iv_Flag_ := 0;
    KEL.typ.int Hri_Mi_Flag_ := 0;
    KEL.typ.int Hri_Mo_Flag_ := 0;
    KEL.typ.int Hri_Ms_Flag_ := 0;
    KEL.typ.int Hri_Nf_Flag_ := 0;
    KEL.typ.int Hri_Pa_Flag_ := 0;
    KEL.typ.int Hri_Po_Flag_ := 0;
    KEL.typ.int Hri_Va_Flag_ := 0;
    KEL.typ.int Id_Nas9_Flag_ := 0;
    KEL.typ.int In_Customer_Population_ := 0;
    KEL.typ.int Ip_High_Risk_City_ := 0;
    KEL.typ.int Ip_Hosted_ := 0;
    KEL.typ.int Ip_Not_Us_ := 0;
    KEL.typ.int Ip_Tor_ := 0;
    KEL.typ.int Ip_Vpn_ := 0;
    KEL.typ.int Kr_Addr300_Flag_ := 0;
    KEL.typ.int Kr_Addr301_Flag_ := 0;
    KEL.typ.int Kr_Addr302_Flag_ := 0;
    KEL.typ.int Kr_Addr303_Flag_ := 0;
    KEL.typ.int Kr_Bnk800_Flag_ := 0;
    KEL.typ.int Kr_Bnk801_Flag_ := 0;
    KEL.typ.int Kr_Bnk802_Flag_ := 0;
    KEL.typ.int Kr_Bnk890_Flag_ := 0;
    KEL.typ.int Kr_Bnk891_Flag_ := 0;
    KEL.typ.int Kr_Bnk892_Flag_ := 0;
    KEL.typ.int Kr_Bnk893_Flag_ := 0;
    KEL.typ.int Kr_Dl200_Flag_ := 0;
    KEL.typ.int Kr_Dl201_Flag_ := 0;
    KEL.typ.int Kr_Dl202_Flag_ := 0;
    KEL.typ.int Kr_Dl203_Flag_ := 0;
    KEL.typ.int Kr_Dl204_Flag_ := 0;
    KEL.typ.int Kr_Dl290_Flag_ := 0;
    KEL.typ.int Kr_Dl291_Flag_ := 0;
    KEL.typ.int Kr_Dl292_Flag_ := 0;
    KEL.typ.int Kr_Dl293_Flag_ := 0;
    KEL.typ.int Kr_Eml500_Flag_ := 0;
    KEL.typ.int Kr_Eml501_Flag_ := 0;
    KEL.typ.int Kr_Eml502_Flag_ := 0;
    KEL.typ.int Kr_Eml590_Flag_ := 0;
    KEL.typ.int Kr_Eml591_Flag_ := 0;
    KEL.typ.int Kr_Eml592_Flag_ := 0;
    KEL.typ.int Kr_Eml593_Flag_ := 0;
    KEL.typ.int Kr_High_Risk_Address_Flag_ := 0;
    KEL.typ.int Kr_High_Risk_Bank_Flag_ := 0;
    KEL.typ.int Kr_High_Risk_Dl_Flag_ := 0;
    KEL.typ.int Kr_High_Risk_Email_Flag_ := 0;
    KEL.typ.int Kr_High_Risk_Identity_Flag_ := 0;
    KEL.typ.int Kr_High_Risk_Ip_Address_Flag_ := 0;
    KEL.typ.int Kr_High_Risk_Phone_Flag_ := 0;
    KEL.typ.int Kr_High_Risk_Ssn_Flag_ := 0;
    KEL.typ.int Kr_Id10000_Flag_ := 0;
    KEL.typ.int Kr_Id10001_Flag_ := 0;
    KEL.typ.int Kr_Id10002_Flag_ := 0;
    KEL.typ.int Kr_Id10003_Flag_ := 0;
    KEL.typ.int Kr_Id10004_Flag_ := 0;
    KEL.typ.int Kr_Id10005_Flag_ := 0;
    KEL.typ.int Kr_Id10006_Flag_ := 0;
    KEL.typ.int Kr_Id10007_Flag_ := 0;
    KEL.typ.int Kr_Id1010_Flag_ := 0;
    KEL.typ.int Kr_Id11000_Flag_ := 0;
    KEL.typ.int Kr_Id11001_Flag_ := 0;
    KEL.typ.int Kr_Id11002_Flag_ := 0;
    KEL.typ.int Kr_Id11003_Flag_ := 0;
    KEL.typ.int Kr_Id11004_Flag_ := 0;
    KEL.typ.int Kr_Id11005_Flag_ := 0;
    KEL.typ.int Kr_Id11006_Flag_ := 0;
    KEL.typ.int Kr_Id11007_Flag_ := 0;
    KEL.typ.int Kr_Id11008_Flag_ := 0;
    KEL.typ.int Kr_Id11009_Flag_ := 0;
    KEL.typ.int Kr_Id11010_Flag_ := 0;
    KEL.typ.int Kr_Id11011_Flag_ := 0;
    KEL.typ.int Kr_Id11012_Flag_ := 0;
    KEL.typ.int Kr_Id11013_Flag_ := 0;
    KEL.typ.int Kr_Id11014_Flag_ := 0;
    KEL.typ.int Kr_Id11015_Flag_ := 0;
    KEL.typ.int Kr_Id11016_Flag_ := 0;
    KEL.typ.int Kr_Id11017_Flag_ := 0;
    KEL.typ.int Kr_Id11018_Flag_ := 0;
    KEL.typ.int Kr_Id11019_Flag_ := 0;
    KEL.typ.int Kr_Id12000_Flag_ := 0;
    KEL.typ.int Kr_Id12001_Flag_ := 0;
    KEL.typ.int Kr_Id12002_Flag_ := 0;
    KEL.typ.int Kr_Id12003_Flag_ := 0;
    KEL.typ.int Kr_Id12004_Flag_ := 0;
    KEL.typ.int Kr_Id12006_Flag_ := 0;
    KEL.typ.int Kr_Id12007_Flag_ := 0;
    KEL.typ.int Kr_Id13000_Flag_ := 0;
    KEL.typ.int Kr_Id13001_Flag_ := 0;
    KEL.typ.int Kr_Id13002_Flag_ := 0;
    KEL.typ.int Kr_Id13003_Flag_ := 0;
    KEL.typ.int Kr_Id13005_Flag_ := 0;
    KEL.typ.int Kr_Id13006_Flag_ := 0;
    KEL.typ.int Kr_Id13007_Flag_ := 0;
    KEL.typ.int Kr_Id14000_Flag_ := 0;
    KEL.typ.int Kr_Id14001_Flag_ := 0;
    KEL.typ.int Kr_Id2025_Flag_ := 0;
    KEL.typ.int Kr_Identity_Risk_ := 0;
    KEL.typ.int Kr_Ip1000_Flag_ := 0;
    KEL.typ.int Kr_Ip1001_Flag_ := 0;
    KEL.typ.int Kr_Ip600_Flag_ := 0;
    KEL.typ.int Kr_Ip601_Flag_ := 0;
    KEL.typ.int Kr_Ip602_Flag_ := 0;
    KEL.typ.int Kr_Ip603_Flag_ := 0;
    KEL.typ.int Kr_Ip604_Flag_ := 0;
    KEL.typ.int Kr_Ip605_Flag_ := 0;
    KEL.typ.int Kr_Low_Risk_Bank_Flag_ := 0;
    KEL.typ.int Kr_Low_Risk_Dl_Flag_ := 0;
    KEL.typ.int Kr_Medium_Risk_Address_Flag_ := 0;
    KEL.typ.int Kr_Medium_Risk_Bank_Flag_ := 0;
    KEL.typ.int Kr_Medium_Risk_Dl_Flag_ := 0;
    KEL.typ.int Kr_Medium_Risk_Identity_Flag_ := 0;
    KEL.typ.int Kr_Phn400_Flag_ := 0;
    KEL.typ.int Kr_Phn401_Flag_ := 0;
    KEL.typ.int Kr_Phn402_Flag_ := 0;
    KEL.typ.int Kr_Ssn100_Flag_ := 0;
    KEL.typ.int Kr_Ssn101_Flag_ := 0;
    KEL.typ.nfloat Latitude_;
    KEL.typ.nfloat Longitude_;
    KEL.typ.int Safe_Flag_ := 0;
    KEL.typ.ntyp(E_Customer.Typ) _r_Customer__1_;
    KEL.typ.ntyp(E_Email.Typ) Emailof_;
    KEL.typ.nkdate Event_Date__1_;
    KEL.typ.ntyp(E_Event.Typ) Transaction_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  __JC408001(B_Event_1.__ST19585_Layout __EE406460, E_Email_Event.Layout __EE407995) := __EEQP(__EE407995.Transaction_,__EE406460.UID);
  __ST402747_Layout __JT408001(B_Event_1.__ST19585_Layout __l, E_Email_Event.Layout __r) := TRANSFORM
    SELF._r_Customer__1_ := __r._r_Customer_;
    SELF.Event_Date__1_ := __r.Event_Date_;
    SELF := __l;
    SELF := __r;
  END;
  SHARED __EE408002 := JOIN(__EE407995,__EE406460,__JC408001(RIGHT,LEFT),__JT408001(RIGHT,LEFT),INNER,HASH);
  SHARED __ST401458_Layout := RECORD
    KEL.typ.ntyp(E_Email.Typ) UID;
    KEL.typ.ntyp(E_Customer.Typ) _r_Customer_;
    KEL.typ.ntyp(E_Email.Typ) Emailof_;
    KEL.typ.nkdate Event_Date_;
    KEL.typ.ntyp(E_Event.Typ) Transaction_;
    KEL.typ.nuid U_I_D__1_;
    KEL.typ.int Contributor_Safe_Flag_ := 0;
    KEL.typ.int Kr_Eml500_Flag_ := 0;
    KEL.typ.int Kr_Eml501_Flag_ := 0;
    KEL.typ.int Kr_Eml502_Flag_ := 0;
    KEL.typ.int Kr_Eml590_Flag_ := 0;
    KEL.typ.int Kr_Eml591_Flag_ := 0;
    KEL.typ.int Kr_Eml592_Flag_ := 0;
    KEL.typ.int Kr_Eml593_Flag_ := 0;
    KEL.typ.int Kr_High_Risk_Email_Flag_ := 0;
    KEL.typ.int Safe_Flag_ := 0;
    KEL.typ.nint Age_;
    KEL.typ.int In_Customer_Population_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
  END;
  SHARED __ST401458_Layout __ND408317__Project(__ST402747_Layout __PP408003) := TRANSFORM
    SELF.UID := __PP408003.Emailof_;
    SELF._r_Customer_ := __PP408003._r_Customer__1_;
    SELF.Event_Date_ := __PP408003.Event_Date__1_;
    SELF.U_I_D__1_ := __PP408003.UID;
    SELF := __PP408003;
  END;
  SHARED __EE408390 := PROJECT(__EE408002,__ND408317__Project(LEFT));
  SHARED __ST401553_Layout := RECORD
    KEL.typ.ntyp(E_Email.Typ) UID;
    KEL.typ.bool Exp1_ := FALSE;
    KEL.typ.bool Exp2_ := FALSE;
    KEL.typ.bool Exp3_ := FALSE;
    KEL.typ.bool Exp4_ := FALSE;
    KEL.typ.bool Exp5_ := FALSE;
    KEL.typ.bool Exp6_ := FALSE;
    KEL.typ.bool Exp7_ := FALSE;
    KEL.typ.bool Exp8_ := FALSE;
    KEL.typ.bool Exp9_ := FALSE;
    KEL.typ.bool Exp10_ := FALSE;
    KEL.typ.nbool Exp11_;
    KEL.typ.nbool Exp12_;
    KEL.typ.nbool Exp13_;
    KEL.typ.nbool Exp14_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
  END;
  SHARED __ST401553_Layout __ND409052__Project(__ST401458_Layout __PP408391) := TRANSFORM
    SELF.Exp1_ := __PP408391.Contributor_Safe_Flag_ = 1;
    SELF.Exp2_ := __PP408391.Kr_Eml500_Flag_ = 1;
    SELF.Exp3_ := __PP408391.Kr_Eml501_Flag_ = 1;
    SELF.Exp4_ := __PP408391.Kr_Eml502_Flag_ = 1;
    SELF.Exp5_ := __PP408391.Kr_Eml590_Flag_ = 1;
    SELF.Exp6_ := __PP408391.Kr_Eml591_Flag_ = 1;
    SELF.Exp7_ := __PP408391.Kr_Eml592_Flag_ = 1;
    SELF.Exp8_ := __PP408391.Kr_Eml593_Flag_ = 1;
    SELF.Exp9_ := __PP408391.Kr_High_Risk_Email_Flag_ = 1;
    SELF.Exp10_ := __PP408391.Safe_Flag_ = 1;
    SELF.Exp11_ := __OP2(__PP408391.Age_,<,__CN(2));
    SELF.Exp12_ := __AND(__OP2(__PP408391.Age_,<,__CN(2)),__CN(__PP408391.In_Customer_Population_ = 1));
    SELF.Exp13_ := __OP2(__PP408391.Age_,<,__CN(366));
    SELF.Exp14_ := __AND(__OP2(__PP408391.Age_,<,__CN(366)),__CN(__PP408391.In_Customer_Population_ = 1));
    SELF := __PP408391;
  END;
  SHARED __EE409079 := PROJECT(__EE408390,__ND409052__Project(LEFT));
  SHARED __ST401633_Layout := RECORD
    KEL.typ.int C_O_U_N_T___Exp1_ := 0;
    KEL.typ.int C_O_U_N_T___Exp1__1_ := 0;
    KEL.typ.int C_O_U_N_T___Exp1__2_ := 0;
    KEL.typ.int C_O_U_N_T___Exp1__3_ := 0;
    KEL.typ.int C_O_U_N_T___Exp1__4_ := 0;
    KEL.typ.int C_O_U_N_T___Exp1__5_ := 0;
    KEL.typ.int C_O_U_N_T___Exp1__6_ := 0;
    KEL.typ.int C_O_U_N_T___Exp1__7_ := 0;
    KEL.typ.int C_O_U_N_T___Exp1__8_ := 0;
    KEL.typ.int C_O_U_N_T___Exp1__9_ := 0;
    KEL.typ.int C_O_U_N_T___Exp1__10_ := 0;
    KEL.typ.int C_O_U_N_T___Exp1__11_ := 0;
    KEL.typ.int C_O_U_N_T___Exp1__12_ := 0;
    KEL.typ.int C_O_U_N_T___Exp1__13_ := 0;
    KEL.typ.ntyp(E_Email.Typ) UID;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
  END;
  SHARED __EE409164 := PROJECT(__CLEANANDDO(__EE409079,TABLE(__EE409079,{KEL.typ.int C_O_U_N_T___Exp1_ := COUNT(GROUP,__EE409079.Exp1_),KEL.typ.int C_O_U_N_T___Exp1__1_ := COUNT(GROUP,__EE409079.Exp2_),KEL.typ.int C_O_U_N_T___Exp1__2_ := COUNT(GROUP,__EE409079.Exp3_),KEL.typ.int C_O_U_N_T___Exp1__3_ := COUNT(GROUP,__EE409079.Exp4_),KEL.typ.int C_O_U_N_T___Exp1__4_ := COUNT(GROUP,__EE409079.Exp5_),KEL.typ.int C_O_U_N_T___Exp1__5_ := COUNT(GROUP,__EE409079.Exp6_),KEL.typ.int C_O_U_N_T___Exp1__6_ := COUNT(GROUP,__EE409079.Exp7_),KEL.typ.int C_O_U_N_T___Exp1__7_ := COUNT(GROUP,__EE409079.Exp8_),KEL.typ.int C_O_U_N_T___Exp1__8_ := COUNT(GROUP,__EE409079.Exp9_),KEL.typ.int C_O_U_N_T___Exp1__9_ := COUNT(GROUP,__EE409079.Exp10_),KEL.typ.int C_O_U_N_T___Exp1__10_ := COUNT(GROUP,__T(__EE409079.Exp11_)),KEL.typ.int C_O_U_N_T___Exp1__11_ := COUNT(GROUP,__T(__EE409079.Exp12_)),KEL.typ.int C_O_U_N_T___Exp1__12_ := COUNT(GROUP,__T(__EE409079.Exp13_)),KEL.typ.int C_O_U_N_T___Exp1__13_ := COUNT(GROUP,__T(__EE409079.Exp14_)),UID},UID,MERGE)),__ST401633_Layout);
  SHARED __ST403734_Layout := RECORD
    KEL.typ.nuid UID;
    KEL.typ.ntyp(E_Customer.Typ) _r_Customer_;
    KEL.typ.ndataset(E_Email.Source_Customers_Layout) Source_Customers_;
    KEL.typ.nstr Email_Address_;
    KEL.typ.nint Otto_Email_Id_;
    KEL.typ.ndataset(E_Email.Details_Layout) Details_;
    KEL.typ.int Cl_Active30_Identity_Count_ := 0;
    KEL.typ.nint Cl_Active30_Identity_Count_Percentile_;
    KEL.typ.int Cl_Active7_Identity_Count_ := 0;
    KEL.typ.nint Cl_Active7_Identity_Count_Percentile_;
    KEL.typ.int Cl_Event_Count_ := 0;
    KEL.typ.nint Cl_Event_Count_Percentile_;
    KEL.typ.int Cl_Identity_Count_ := 0;
    KEL.typ.nint Cl_Identity_Count_Percentile_;
    KEL.typ.int Vl_Event30_All_Day_Count_ := 0;
    KEL.typ.int Vl_Event30_Count_ := 0;
    KEL.typ.int Vl_Event7_All_Count_ := 0;
    KEL.typ.int Vl_Event7_Count_ := 0;
    KEL.typ.int C_O_U_N_T___Person_Email_ := 0;
    KEL.typ.ntyp(E_Email.Typ) U_I_D__1_;
    KEL.typ.int C_O_U_N_T___Email_Event_ := 0;
    KEL.typ.ntyp(E_Email.Typ) U_I_D__2_;
    KEL.typ.int C_O_U_N_T___Exp1_ := 0;
    KEL.typ.int C_O_U_N_T___Exp1__1_ := 0;
    KEL.typ.int C_O_U_N_T___Exp1__2_ := 0;
    KEL.typ.int C_O_U_N_T___Exp1__3_ := 0;
    KEL.typ.int C_O_U_N_T___Exp1__4_ := 0;
    KEL.typ.int C_O_U_N_T___Exp1__5_ := 0;
    KEL.typ.int C_O_U_N_T___Exp1__6_ := 0;
    KEL.typ.int C_O_U_N_T___Exp1__7_ := 0;
    KEL.typ.int C_O_U_N_T___Exp1__8_ := 0;
    KEL.typ.int C_O_U_N_T___Exp1__9_ := 0;
    KEL.typ.int C_O_U_N_T___Exp1__10_ := 0;
    KEL.typ.int C_O_U_N_T___Exp1__11_ := 0;
    KEL.typ.int C_O_U_N_T___Exp1__12_ := 0;
    KEL.typ.int C_O_U_N_T___Exp1__13_ := 0;
    KEL.typ.ntyp(E_Email.Typ) U_I_D__3_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  __JC409170(__ST403443_Layout __EE406510, __ST401633_Layout __EE409164) := __EEQP(__EE406510.UID,__EE409164.UID);
  __ST403734_Layout __JT409170(__ST403443_Layout __l, __ST401633_Layout __r) := TRANSFORM
    SELF.U_I_D__3_ := __r.UID;
    SELF := __l;
    SELF := __r;
  END;
  SHARED __EE409217 := JOIN(__EE406510,__EE409164,__JC409170(LEFT,RIGHT),__JT409170(LEFT,RIGHT),LEFT OUTER,HASH);
  SHARED __EE399058 := __ENH_Customer_1;
  SHARED __EE407979 := __EE399058;
  SHARED __ST404083_Layout := RECORD
    KEL.typ.nuid UID;
    KEL.typ.ntyp(E_Customer.Typ) _r_Customer_;
    KEL.typ.ndataset(E_Email.Source_Customers_Layout) Source_Customers_;
    KEL.typ.nstr Email_Address_;
    KEL.typ.nint Otto_Email_Id_;
    KEL.typ.ndataset(E_Email.Details_Layout) Details_;
    KEL.typ.int Cl_Active30_Identity_Count_ := 0;
    KEL.typ.nint Cl_Active30_Identity_Count_Percentile_;
    KEL.typ.int Cl_Active7_Identity_Count_ := 0;
    KEL.typ.nint Cl_Active7_Identity_Count_Percentile_;
    KEL.typ.int Cl_Event_Count_ := 0;
    KEL.typ.nint Cl_Event_Count_Percentile_;
    KEL.typ.int Cl_Identity_Count_ := 0;
    KEL.typ.nint Cl_Identity_Count_Percentile_;
    KEL.typ.int Vl_Event30_All_Day_Count_ := 0;
    KEL.typ.int Vl_Event30_Count_ := 0;
    KEL.typ.int Vl_Event7_All_Count_ := 0;
    KEL.typ.int Vl_Event7_Count_ := 0;
    KEL.typ.int C_O_U_N_T___Person_Email_ := 0;
    KEL.typ.ntyp(E_Email.Typ) U_I_D__1_;
    KEL.typ.int C_O_U_N_T___Email_Event_ := 0;
    KEL.typ.ntyp(E_Email.Typ) U_I_D__2_;
    KEL.typ.int C_O_U_N_T___Exp1_ := 0;
    KEL.typ.int C_O_U_N_T___Exp1__1_ := 0;
    KEL.typ.int C_O_U_N_T___Exp1__2_ := 0;
    KEL.typ.int C_O_U_N_T___Exp1__3_ := 0;
    KEL.typ.int C_O_U_N_T___Exp1__4_ := 0;
    KEL.typ.int C_O_U_N_T___Exp1__5_ := 0;
    KEL.typ.int C_O_U_N_T___Exp1__6_ := 0;
    KEL.typ.int C_O_U_N_T___Exp1__7_ := 0;
    KEL.typ.int C_O_U_N_T___Exp1__8_ := 0;
    KEL.typ.int C_O_U_N_T___Exp1__9_ := 0;
    KEL.typ.int C_O_U_N_T___Exp1__10_ := 0;
    KEL.typ.int C_O_U_N_T___Exp1__11_ := 0;
    KEL.typ.int C_O_U_N_T___Exp1__12_ := 0;
    KEL.typ.int C_O_U_N_T___Exp1__13_ := 0;
    KEL.typ.ntyp(E_Email.Typ) U_I_D__3_;
    KEL.typ.nuid U_I_D__4_;
    KEL.typ.nint Customer_Id_;
    KEL.typ.nint Industry_Type_;
    KEL.typ.int Address_Count_ := 0;
    KEL.typ.int All_Address_Count_ := 0;
    KEL.typ.int All_Deceased_Matched_Person_Count_ := 0;
    KEL.typ.int All_Deceased_Person_Count_ := 0;
    KEL.typ.int All_High_Frequency_Address_Count_ := 0;
    KEL.typ.int All_Person_Count_ := 0;
    KEL.typ.int Deceased_Person_Count_ := 0;
    KEL.typ.nkdate Event_Date_Max_;
    KEL.typ.int High_Frequency_Address_Count_ := 0;
    KEL.typ.int Person_Count_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  __JC409223(__ST403734_Layout __EE409217, B_Customer_1.__ST19361_Layout __EE407979) := __EEQP(__EE409217._r_Customer_,__EE407979.UID);
  __ST404083_Layout __JT409223(__ST403734_Layout __l, B_Customer_1.__ST19361_Layout __r) := TRANSFORM
    SELF.U_I_D__4_ := __r.UID;
    SELF := __l;
    SELF := __r;
  END;
  SHARED __EE409283 := JOIN(__EE409217,__EE407979,__JC409223(LEFT,RIGHT),__JT409223(LEFT,RIGHT),LEFT OUTER,HASH);
  SHARED __ST404442_Layout := RECORD
    KEL.typ.nuid UID;
    KEL.typ.ntyp(E_Customer.Typ) _r_Customer_;
    KEL.typ.ndataset(E_Email.Source_Customers_Layout) Source_Customers_;
    KEL.typ.nstr Email_Address_;
    KEL.typ.nint Otto_Email_Id_;
    KEL.typ.ndataset(E_Email.Details_Layout) Details_;
    KEL.typ.int Cl_Active30_Identity_Count_ := 0;
    KEL.typ.nint Cl_Active30_Identity_Count_Percentile_;
    KEL.typ.int Cl_Active7_Identity_Count_ := 0;
    KEL.typ.nint Cl_Active7_Identity_Count_Percentile_;
    KEL.typ.int Cl_Event_Count_ := 0;
    KEL.typ.nint Cl_Event_Count_Percentile_;
    KEL.typ.int Cl_Identity_Count_ := 0;
    KEL.typ.nint Cl_Identity_Count_Percentile_;
    KEL.typ.int Vl_Event30_All_Day_Count_ := 0;
    KEL.typ.int Vl_Event30_Count_ := 0;
    KEL.typ.int Vl_Event7_All_Count_ := 0;
    KEL.typ.int Vl_Event7_Count_ := 0;
    KEL.typ.int C_O_U_N_T___Person_Email_ := 0;
    KEL.typ.ntyp(E_Email.Typ) U_I_D__1_;
    KEL.typ.int C_O_U_N_T___Email_Event_ := 0;
    KEL.typ.ntyp(E_Email.Typ) U_I_D__2_;
    KEL.typ.int C_O_U_N_T___Exp1_ := 0;
    KEL.typ.int C_O_U_N_T___Exp1__1_ := 0;
    KEL.typ.int C_O_U_N_T___Exp1__2_ := 0;
    KEL.typ.int C_O_U_N_T___Exp1__3_ := 0;
    KEL.typ.int C_O_U_N_T___Exp1__4_ := 0;
    KEL.typ.int C_O_U_N_T___Exp1__5_ := 0;
    KEL.typ.int C_O_U_N_T___Exp1__6_ := 0;
    KEL.typ.int C_O_U_N_T___Exp1__7_ := 0;
    KEL.typ.int C_O_U_N_T___Exp1__8_ := 0;
    KEL.typ.int C_O_U_N_T___Exp1__9_ := 0;
    KEL.typ.int C_O_U_N_T___Exp1__10_ := 0;
    KEL.typ.int C_O_U_N_T___Exp1__11_ := 0;
    KEL.typ.int C_O_U_N_T___Exp1__12_ := 0;
    KEL.typ.int C_O_U_N_T___Exp1__13_ := 0;
    KEL.typ.ntyp(E_Email.Typ) U_I_D__3_;
    KEL.typ.nuid U_I_D__4_;
    KEL.typ.nint Customer_Id_;
    KEL.typ.nint Industry_Type_;
    KEL.typ.int Address_Count_ := 0;
    KEL.typ.int All_Address_Count_ := 0;
    KEL.typ.int All_Deceased_Matched_Person_Count_ := 0;
    KEL.typ.int All_Deceased_Person_Count_ := 0;
    KEL.typ.int All_High_Frequency_Address_Count_ := 0;
    KEL.typ.int All_Person_Count_ := 0;
    KEL.typ.int Deceased_Person_Count_ := 0;
    KEL.typ.nkdate Event_Date_Max_;
    KEL.typ.int High_Frequency_Address_Count_ := 0;
    KEL.typ.int Person_Count_ := 0;
    KEL.typ.nuid U_I_D__5_;
    KEL.typ.nint Customer_Id__1_;
    KEL.typ.nint Industry_Type__1_;
    KEL.typ.int Address_Count__1_ := 0;
    KEL.typ.int All_Address_Count__1_ := 0;
    KEL.typ.int All_Deceased_Matched_Person_Count__1_ := 0;
    KEL.typ.int All_Deceased_Person_Count__1_ := 0;
    KEL.typ.int All_High_Frequency_Address_Count__1_ := 0;
    KEL.typ.int All_Person_Count__1_ := 0;
    KEL.typ.int Deceased_Person_Count__1_ := 0;
    KEL.typ.nkdate Event_Date_Max__1_;
    KEL.typ.int High_Frequency_Address_Count__1_ := 0;
    KEL.typ.int Person_Count__1_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  __JC409289(__ST404083_Layout __EE409283, B_Customer_1.__ST19361_Layout __EE399058) := __EEQP(__EE409283._r_Customer_,__EE399058.UID);
  __ST404442_Layout __JT409289(__ST404083_Layout __l, B_Customer_1.__ST19361_Layout __r) := TRANSFORM
    SELF.U_I_D__5_ := __r.UID;
    SELF.Customer_Id__1_ := __r.Customer_Id_;
    SELF.Industry_Type__1_ := __r.Industry_Type_;
    SELF.Address_Count__1_ := __r.Address_Count_;
    SELF.All_Address_Count__1_ := __r.All_Address_Count_;
    SELF.All_Deceased_Matched_Person_Count__1_ := __r.All_Deceased_Matched_Person_Count_;
    SELF.All_Deceased_Person_Count__1_ := __r.All_Deceased_Person_Count_;
    SELF.All_High_Frequency_Address_Count__1_ := __r.All_High_Frequency_Address_Count_;
    SELF.All_Person_Count__1_ := __r.All_Person_Count_;
    SELF.Deceased_Person_Count__1_ := __r.Deceased_Person_Count_;
    SELF.Event_Date_Max__1_ := __r.Event_Date_Max_;
    SELF.High_Frequency_Address_Count__1_ := __r.High_Frequency_Address_Count_;
    SELF.Person_Count__1_ := __r.Person_Count_;
    SELF := __l;
    SELF := __r;
  END;
  SHARED __EE409386 := JOIN(__EE409283,__EE399058,__JC409289(LEFT,RIGHT),__JT409289(LEFT,RIGHT),LEFT OUTER,HASH);
  EXPORT __ST17937_Layout := RECORD
    KEL.typ.nuid UID;
    KEL.typ.ntyp(E_Customer.Typ) _r_Customer_;
    KEL.typ.ndataset(E_Email.Source_Customers_Layout) Source_Customers_;
    KEL.typ.nstr Email_Address_;
    KEL.typ.nint Otto_Email_Id_;
    KEL.typ.ndataset(E_Email.Details_Layout) Details_;
    KEL.typ.int Cl_Active30_Identity_Count_ := 0;
    KEL.typ.nint Cl_Active30_Identity_Count_Percentile_;
    KEL.typ.int Cl_Active7_Identity_Count_ := 0;
    KEL.typ.nint Cl_Active7_Identity_Count_Percentile_;
    KEL.typ.int Cl_Element_Count_ := 0;
    KEL.typ.int Cl_Event_Count_ := 0;
    KEL.typ.nint Cl_Event_Count_Percentile_;
    KEL.typ.int Cl_Identity_Count_ := 0;
    KEL.typ.nint Cl_Identity_Count_Percentile_;
    KEL.typ.nfloat Cl_Impact_Weight_;
    KEL.typ.int Cluster_Score_ := 0;
    KEL.typ.int Contributor_Safe_Flag_ := 0;
    KEL.typ.nint Customer_Id_;
    KEL.typ.nunk Entity_Context_Uid_;
    KEL.typ.int Entity_Type_ := 0;
    KEL.typ.int Event_Count_ := 0;
    KEL.typ.int Identity_Count_ := 0;
    KEL.typ.int In_Customer_Population_ := 0;
    KEL.typ.nint Industry_Type_;
    KEL.typ.int Kr_Eml500_Flag_ := 0;
    KEL.typ.int Kr_Eml501_Flag_ := 0;
    KEL.typ.int Kr_Eml502_Flag_ := 0;
    KEL.typ.int Kr_Eml590_Flag_ := 0;
    KEL.typ.int Kr_Eml591_Flag_ := 0;
    KEL.typ.int Kr_Eml592_Flag_ := 0;
    KEL.typ.int Kr_Eml593_Flag_ := 0;
    KEL.typ.int Kr_High_Risk_Flag_ := 0;
    KEL.typ.int Kr_Medium_Risk_Flag_ := 0;
    KEL.typ.nstr Label_;
    KEL.typ.int Safe_Flag_ := 0;
    KEL.typ.nint Score_;
    KEL.typ.nint Source_Customer_Count_;
    KEL.typ.int Vl_Event1_All_Count_ := 0;
    KEL.typ.int Vl_Event1_Count_ := 0;
    KEL.typ.int Vl_Event30_Active_Flag_ := 0;
    KEL.typ.int Vl_Event30_All_Active_Flag_ := 0;
    KEL.typ.int Vl_Event30_All_Day_Count_ := 0;
    KEL.typ.int Vl_Event30_Count_ := 0;
    KEL.typ.int Vl_Event365_All_Day_Count_ := 0;
    KEL.typ.int Vl_Event365_Count_ := 0;
    KEL.typ.int Vl_Event7_Active_Flag_ := 0;
    KEL.typ.int Vl_Event7_All_Active_Flag_ := 0;
    KEL.typ.int Vl_Event7_All_Count_ := 0;
    KEL.typ.int Vl_Event7_Count_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  SHARED __ST17937_Layout __ND409391__Project(__ST404442_Layout __PP409387) := TRANSFORM
    SELF.Cl_Element_Count_ := 0;
    SELF.Cl_Impact_Weight_ := __OP2(__OP2(__OP2(__OP2(__PP409387.Cl_Identity_Count_Percentile_,*,__CN(0.3)),+,__OP2(__PP409387.Cl_Event_Count_Percentile_,*,__CN(0.3))),+,__OP2(__PP409387.Cl_Active30_Identity_Count_Percentile_,*,__CN(0.2))),+,__OP2(__PP409387.Cl_Active7_Identity_Count_Percentile_,*,__CN(0.2)));
    SELF.Cluster_Score_ := 0;
    SELF.Contributor_Safe_Flag_ := MAP(__PP409387.C_O_U_N_T___Exp1_ <> 0=>1,0);
    SELF.Customer_Id_ := __PP409387.Customer_Id__1_;
    SELF.Entity_Context_Uid_ := __OP2(__CN('_17'),+,__PP409387.Otto_Email_Id_);
    SELF.Entity_Type_ := 17;
    SELF.Event_Count_ := __PP409387.C_O_U_N_T___Email_Event_;
    SELF.Identity_Count_ := __PP409387.C_O_U_N_T___Person_Email_;
    __BS409509 := __T(__PP409387.Source_Customers_);
    SELF.In_Customer_Population_ := MAP(EXISTS(__BS409509(__T(__OP2(__T(__PP409387.Source_Customers_)._r_Source_Customer_,=,__PP409387._r_Customer_))))=>1,0);
    SELF.Kr_Eml500_Flag_ := MAP(__PP409387.C_O_U_N_T___Exp1__1_ <> 0=>1,0);
    SELF.Kr_Eml501_Flag_ := MAP(__PP409387.C_O_U_N_T___Exp1__2_ <> 0=>1,0);
    SELF.Kr_Eml502_Flag_ := MAP(__PP409387.C_O_U_N_T___Exp1__3_ <> 0=>1,0);
    SELF.Kr_Eml590_Flag_ := MAP(__PP409387.C_O_U_N_T___Exp1__4_ <> 0=>1,0);
    SELF.Kr_Eml591_Flag_ := MAP(__PP409387.C_O_U_N_T___Exp1__5_ <> 0=>1,0);
    SELF.Kr_Eml592_Flag_ := MAP(__PP409387.C_O_U_N_T___Exp1__6_ <> 0=>1,0);
    SELF.Kr_Eml593_Flag_ := MAP(__PP409387.C_O_U_N_T___Exp1__7_ <> 0=>1,0);
    SELF.Kr_High_Risk_Flag_ := MAP(__PP409387.C_O_U_N_T___Exp1__8_ <> 0=>1,0);
    SELF.Kr_Medium_Risk_Flag_ := 0;
    SELF.Label_ := __PP409387.Email_Address_;
    SELF.Safe_Flag_ := MAP(__PP409387.C_O_U_N_T___Exp1__9_ <> 0=>1,0);
    SELF.Score_ := __OP2(__PP409387.UID,%,__CN(100));
    SELF.Source_Customer_Count_ := KEL.Aggregates.CountN(__PP409387.Source_Customers_);
    SELF.Vl_Event1_All_Count_ := __PP409387.C_O_U_N_T___Exp1__10_;
    SELF.Vl_Event1_Count_ := __PP409387.C_O_U_N_T___Exp1__11_;
    SELF.Vl_Event30_Active_Flag_ := MAP(__PP409387.Vl_Event30_Count_ > 0=>1,0);
    SELF.Vl_Event30_All_Active_Flag_ := MAP(__PP409387.Vl_Event30_All_Day_Count_ > 0=>1,0);
    SELF.Vl_Event365_All_Day_Count_ := __PP409387.C_O_U_N_T___Exp1__12_;
    SELF.Vl_Event365_Count_ := __PP409387.C_O_U_N_T___Exp1__13_;
    SELF.Vl_Event7_Active_Flag_ := MAP(__PP409387.Vl_Event7_Count_ > 0=>1,0);
    SELF.Vl_Event7_All_Active_Flag_ := MAP(__PP409387.Vl_Event7_All_Count_ > 0=>1,0);
    SELF := __PP409387;
  END;
  EXPORT __ENH_Email := PROJECT(__EE409386,__ND409391__Project(LEFT)) : PERSIST('~temp::KEL::KELOtto::Email::Annotated',EXPIRE(7));
  SHARED __EE831280 := __ENH_Email;
  SHARED IDX_Email_UID_Layout := RECORD
    KEL.typ.uid UID;
    __EE831280._r_Customer_;
    __EE831280.Source_Customers_;
    __EE831280.Email_Address_;
    __EE831280.Otto_Email_Id_;
    __EE831280.Details_;
    __EE831280.Customer_Id_;
    __EE831280.Industry_Type_;
    __EE831280.Source_Customer_Count_;
    __EE831280.Entity_Context_Uid_;
    __EE831280.Entity_Type_;
    __EE831280.Label_;
    __EE831280.In_Customer_Population_;
    __EE831280.Identity_Count_;
    __EE831280.Event_Count_;
    __EE831280.Kr_High_Risk_Flag_;
    __EE831280.Kr_Medium_Risk_Flag_;
    __EE831280.Safe_Flag_;
    __EE831280.Contributor_Safe_Flag_;
    __EE831280.Kr_Eml500_Flag_;
    __EE831280.Kr_Eml501_Flag_;
    __EE831280.Kr_Eml502_Flag_;
    __EE831280.Kr_Eml590_Flag_;
    __EE831280.Kr_Eml591_Flag_;
    __EE831280.Kr_Eml592_Flag_;
    __EE831280.Kr_Eml593_Flag_;
    __EE831280.Vl_Event1_All_Count_;
    __EE831280.Vl_Event7_All_Count_;
    __EE831280.Vl_Event30_All_Day_Count_;
    __EE831280.Vl_Event365_All_Day_Count_;
    __EE831280.Vl_Event7_All_Active_Flag_;
    __EE831280.Vl_Event30_All_Active_Flag_;
    __EE831280.Vl_Event1_Count_;
    __EE831280.Vl_Event7_Count_;
    __EE831280.Vl_Event30_Count_;
    __EE831280.Vl_Event365_Count_;
    __EE831280.Vl_Event7_Active_Flag_;
    __EE831280.Vl_Event30_Active_Flag_;
    __EE831280.Cl_Identity_Count_;
    __EE831280.Cl_Active7_Identity_Count_;
    __EE831280.Cl_Active30_Identity_Count_;
    __EE831280.Cl_Event_Count_;
    __EE831280.Cl_Element_Count_;
    __EE831280.Cl_Identity_Count_Percentile_;
    __EE831280.Cl_Event_Count_Percentile_;
    __EE831280.Cl_Active30_Identity_Count_Percentile_;
    __EE831280.Cl_Active7_Identity_Count_Percentile_;
    __EE831280.Cl_Impact_Weight_;
    __EE831280.Score_;
    __EE831280.Cluster_Score_;
    __EE831280.Date_First_Seen_;
    __EE831280.Date_Last_Seen_;
    __EE831280.__RecordCount;
  END;
  SHARED IDX_Email_UID_Projected := PROJECT(__EE831280,TRANSFORM(IDX_Email_UID_Layout,SELF.UID:=__T(LEFT.UID),SELF:=LEFT));
  EXPORT IDX_Email_UID := INDEX(IDX_Email_UID_Projected,{UID},{IDX_Email_UID_Projected},'~key::KEL::KELOtto::Email::UID');
  EXPORT IDX_Email_UID_Build := BUILD(IDX_Email_UID,OVERWRITE);
  EXPORT __ST831282_Layout := RECORDOF(IDX_Email_UID);
  EXPORT IDX_Email_UID_Wrapped := PROJECT(IDX_Email_UID,TRANSFORM(__ST17937_Layout,SELF.UID := __CN(LEFT.UID),SELF:=LEFT));
  EXPORT BuildAll := PARALLEL(IDX_Email_UID_Build);
END;
