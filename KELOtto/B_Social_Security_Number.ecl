﻿//HPCC Systems KEL Compiler Version 0.11.0
IMPORT KEL011 AS KEL;
IMPORT B_Customer_1,B_Event_1,B_Social_Security_Number_1,E_Address,E_Customer,E_Event,E_Person,E_Social_Security_Number,E_Ssn_Event FROM KELOtto;
IMPORT * FROM KEL011.Null;
EXPORT B_Social_Security_Number := MODULE
  SHARED VIRTUAL TYPEOF(B_Customer_1.__ENH_Customer_1) __ENH_Customer_1 := B_Customer_1.__ENH_Customer_1;
  SHARED VIRTUAL TYPEOF(B_Event_1.__ENH_Event_1) __ENH_Event_1 := B_Event_1.__ENH_Event_1;
  SHARED VIRTUAL TYPEOF(B_Social_Security_Number_1.__ENH_Social_Security_Number_1) __ENH_Social_Security_Number_1 := B_Social_Security_Number_1.__ENH_Social_Security_Number_1;
  SHARED VIRTUAL TYPEOF(E_Ssn_Event.__Result) __E_Ssn_Event := E_Ssn_Event.__Result;
  SHARED __EE677077 := __ENH_Social_Security_Number_1;
  SHARED __EE684827 := __E_Ssn_Event;
  SHARED __EE684834 := __EE684827(__NN(__EE684827.Social_));
  SHARED __ST680809_Layout := RECORD
    KEL.typ.int C_O_U_N_T___Ssn_Event_ := 0;
    KEL.typ.ntyp(E_Social_Security_Number.Typ) UID;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
  END;
  SHARED __EE684825 := PROJECT(__CLEANANDDO(__EE684834,TABLE(__EE684834,{KEL.typ.int C_O_U_N_T___Ssn_Event_ := COUNT(GROUP),KEL.typ.ntyp(E_Social_Security_Number.Typ) UID := __EE684834.Social_},Social_,MERGE)),__ST680809_Layout);
  SHARED __ST681608_Layout := RECORD
    KEL.typ.nuid UID;
    KEL.typ.ntyp(E_Customer.Typ) _r_Customer_;
    KEL.typ.ndataset(E_Social_Security_Number.Source_Customers_Layout) Source_Customers_;
    KEL.typ.nunk Ssn_;
    KEL.typ.nint Otto_S_S_N_Id_;
    KEL.typ.nstr Ssn_Formatted_;
    KEL.typ.nunk _v2__divssnidentitycountnew_;
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
    KEL.typ.int Cl_Active30_Identity_Count_ := 0;
    KEL.typ.nint Cl_Active30_Identity_Count_Percentile_;
    KEL.typ.int Cl_Active7_Identity_Count_ := 0;
    KEL.typ.nint Cl_Active7_Identity_Count_Percentile_;
    KEL.typ.int Cl_Event_Count_ := 0;
    KEL.typ.nint Cl_Event_Count_Percentile_;
    KEL.typ.int Cl_Identity_Count_ := 0;
    KEL.typ.nint Cl_Identity_Count_Percentile_;
    KEL.typ.int Identity_Count_ := 0;
    KEL.typ.int Vl_Event30_All_Day_Count_ := 0;
    KEL.typ.int Vl_Event30_Count_ := 0;
    KEL.typ.int Vl_Event7_All_Count_ := 0;
    KEL.typ.int Vl_Event7_Count_ := 0;
    KEL.typ.int C_O_U_N_T___Ssn_Event_ := 0;
    KEL.typ.ntyp(E_Social_Security_Number.Typ) U_I_D__1_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  __JC684854(B_Social_Security_Number_1.__ST20308_Layout __EE677077, __ST680809_Layout __EE684825) := __EEQP(__EE677077.UID,__EE684825.UID);
  __ST681608_Layout __JT684854(B_Social_Security_Number_1.__ST20308_Layout __l, __ST680809_Layout __r) := TRANSFORM
    SELF.U_I_D__1_ := __r.UID;
    SELF := __l;
    SELF := __r;
  END;
  SHARED __EE684855 := JOIN(__EE677077,__EE684825,__JC684854(LEFT,RIGHT),__JT684854(LEFT,RIGHT),LEFT OUTER,HASH);
  SHARED __EE684838 := __ENH_Event_1;
  SHARED __EE686452 := __EE684827;
  SHARED __EE686465 := __EE686452(__NN(__EE686452.Social_) AND __NN(__EE686452.Transaction_));
  SHARED __ST681198_Layout := RECORD
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
    KEL.typ.ntyp(E_Social_Security_Number.Typ) Social_;
    KEL.typ.nkdate Event_Date__1_;
    KEL.typ.ntyp(E_Event.Typ) Transaction_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  __JC686471(B_Event_1.__ST19580_Layout __EE684838, E_Ssn_Event.Layout __EE686465) := __EEQP(__EE686465.Transaction_,__EE684838.UID);
  __ST681198_Layout __JT686471(B_Event_1.__ST19580_Layout __l, E_Ssn_Event.Layout __r) := TRANSFORM
    SELF._r_Customer__1_ := __r._r_Customer_;
    SELF.Event_Date__1_ := __r.Event_Date_;
    SELF := __l;
    SELF := __r;
  END;
  SHARED __EE686472 := JOIN(__EE686465,__EE684838,__JC686471(RIGHT,LEFT),__JT686471(RIGHT,LEFT),INNER,HASH);
  SHARED __ST680079_Layout := RECORD
    KEL.typ.ntyp(E_Social_Security_Number.Typ) UID;
    KEL.typ.ntyp(E_Customer.Typ) _r_Customer_;
    KEL.typ.ntyp(E_Social_Security_Number.Typ) Social_;
    KEL.typ.nkdate Event_Date_;
    KEL.typ.ntyp(E_Event.Typ) Transaction_;
    KEL.typ.nuid U_I_D__1_;
    KEL.typ.int Contributor_Safe_Flag_ := 0;
    KEL.typ.int Hri06_Flag_ := 0;
    KEL.typ.int Hri26_Flag_ := 0;
    KEL.typ.int Hri29_Flag_ := 0;
    KEL.typ.int Hri38_Flag_ := 0;
    KEL.typ.int Hri71_Flag_ := 0;
    KEL.typ.int Hri_It_Flag_ := 0;
    KEL.typ.int Hri_Mi_Flag_ := 0;
    KEL.typ.int Kr_High_Risk_Ssn_Flag_ := 0;
    KEL.typ.int Kr_Ssn100_Flag_ := 0;
    KEL.typ.int Kr_Ssn101_Flag_ := 0;
    KEL.typ.int Safe_Flag_ := 0;
    KEL.typ.nint Age_;
    KEL.typ.int In_Customer_Population_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
  END;
  SHARED __ST680079_Layout __ND686787__Project(__ST681198_Layout __PP686473) := TRANSFORM
    SELF.UID := __PP686473.Social_;
    SELF._r_Customer_ := __PP686473._r_Customer__1_;
    SELF.Event_Date_ := __PP686473.Event_Date__1_;
    SELF.U_I_D__1_ := __PP686473.UID;
    SELF := __PP686473;
  END;
  SHARED __EE686868 := PROJECT(__EE686472,__ND686787__Project(LEFT));
  SHARED __ST680184_Layout := RECORD
    KEL.typ.ntyp(E_Social_Security_Number.Typ) UID;
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
    KEL.typ.bool Exp11_ := FALSE;
    KEL.typ.bool Exp12_ := FALSE;
    KEL.typ.nbool Exp13_;
    KEL.typ.nbool Exp14_;
    KEL.typ.nbool Exp15_;
    KEL.typ.nbool Exp16_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
  END;
  SHARED __ST680184_Layout __ND687636__Project(__ST680079_Layout __PP686869) := TRANSFORM
    SELF.Exp1_ := __PP686869.Contributor_Safe_Flag_ = 1;
    SELF.Exp2_ := __PP686869.Hri06_Flag_ = 1;
    SELF.Exp3_ := __PP686869.Hri26_Flag_ = 1;
    SELF.Exp4_ := __PP686869.Hri29_Flag_ = 1;
    SELF.Exp5_ := __PP686869.Hri38_Flag_ = 1;
    SELF.Exp6_ := __PP686869.Hri71_Flag_ = 1;
    SELF.Exp7_ := __PP686869.Hri_It_Flag_ = 1;
    SELF.Exp8_ := __PP686869.Hri_Mi_Flag_ = 1;
    SELF.Exp9_ := __PP686869.Kr_High_Risk_Ssn_Flag_ = 1;
    SELF.Exp10_ := __PP686869.Kr_Ssn100_Flag_ = 1;
    SELF.Exp11_ := __PP686869.Kr_Ssn101_Flag_ = 1;
    SELF.Exp12_ := __PP686869.Safe_Flag_ = 1;
    SELF.Exp13_ := __OP2(__PP686869.Age_,<,__CN(2));
    SELF.Exp14_ := __AND(__OP2(__PP686869.Age_,<,__CN(2)),__CN(__PP686869.In_Customer_Population_ = 1));
    SELF.Exp15_ := __OP2(__PP686869.Age_,<,__CN(366));
    SELF.Exp16_ := __AND(__OP2(__PP686869.Age_,<,__CN(366)),__CN(__PP686869.In_Customer_Population_ = 1));
    SELF := __PP686869;
  END;
  SHARED __EE687665 := PROJECT(__EE686868,__ND687636__Project(LEFT));
  SHARED __ST680274_Layout := RECORD
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
    KEL.typ.int C_O_U_N_T___Exp1__14_ := 0;
    KEL.typ.int C_O_U_N_T___Exp1__15_ := 0;
    KEL.typ.ntyp(E_Social_Security_Number.Typ) UID;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
  END;
  SHARED __EE687760 := PROJECT(__CLEANANDDO(__EE687665,TABLE(__EE687665,{KEL.typ.int C_O_U_N_T___Exp1_ := COUNT(GROUP,__EE687665.Exp1_),KEL.typ.int C_O_U_N_T___Exp1__1_ := COUNT(GROUP,__EE687665.Exp2_),KEL.typ.int C_O_U_N_T___Exp1__2_ := COUNT(GROUP,__EE687665.Exp3_),KEL.typ.int C_O_U_N_T___Exp1__3_ := COUNT(GROUP,__EE687665.Exp4_),KEL.typ.int C_O_U_N_T___Exp1__4_ := COUNT(GROUP,__EE687665.Exp5_),KEL.typ.int C_O_U_N_T___Exp1__5_ := COUNT(GROUP,__EE687665.Exp6_),KEL.typ.int C_O_U_N_T___Exp1__6_ := COUNT(GROUP,__EE687665.Exp7_),KEL.typ.int C_O_U_N_T___Exp1__7_ := COUNT(GROUP,__EE687665.Exp8_),KEL.typ.int C_O_U_N_T___Exp1__8_ := COUNT(GROUP,__EE687665.Exp9_),KEL.typ.int C_O_U_N_T___Exp1__9_ := COUNT(GROUP,__EE687665.Exp10_),KEL.typ.int C_O_U_N_T___Exp1__10_ := COUNT(GROUP,__EE687665.Exp11_),KEL.typ.int C_O_U_N_T___Exp1__11_ := COUNT(GROUP,__EE687665.Exp12_),KEL.typ.int C_O_U_N_T___Exp1__12_ := COUNT(GROUP,__T(__EE687665.Exp13_)),KEL.typ.int C_O_U_N_T___Exp1__13_ := COUNT(GROUP,__T(__EE687665.Exp14_)),KEL.typ.int C_O_U_N_T___Exp1__14_ := COUNT(GROUP,__T(__EE687665.Exp15_)),KEL.typ.int C_O_U_N_T___Exp1__15_ := COUNT(GROUP,__T(__EE687665.Exp16_)),UID},UID,MERGE)),__ST680274_Layout);
  SHARED __ST681945_Layout := RECORD
    KEL.typ.nuid UID;
    KEL.typ.ntyp(E_Customer.Typ) _r_Customer_;
    KEL.typ.ndataset(E_Social_Security_Number.Source_Customers_Layout) Source_Customers_;
    KEL.typ.nunk Ssn_;
    KEL.typ.nint Otto_S_S_N_Id_;
    KEL.typ.nstr Ssn_Formatted_;
    KEL.typ.nunk _v2__divssnidentitycountnew_;
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
    KEL.typ.int Cl_Active30_Identity_Count_ := 0;
    KEL.typ.nint Cl_Active30_Identity_Count_Percentile_;
    KEL.typ.int Cl_Active7_Identity_Count_ := 0;
    KEL.typ.nint Cl_Active7_Identity_Count_Percentile_;
    KEL.typ.int Cl_Event_Count_ := 0;
    KEL.typ.nint Cl_Event_Count_Percentile_;
    KEL.typ.int Cl_Identity_Count_ := 0;
    KEL.typ.nint Cl_Identity_Count_Percentile_;
    KEL.typ.int Identity_Count_ := 0;
    KEL.typ.int Vl_Event30_All_Day_Count_ := 0;
    KEL.typ.int Vl_Event30_Count_ := 0;
    KEL.typ.int Vl_Event7_All_Count_ := 0;
    KEL.typ.int Vl_Event7_Count_ := 0;
    KEL.typ.int C_O_U_N_T___Ssn_Event_ := 0;
    KEL.typ.ntyp(E_Social_Security_Number.Typ) U_I_D__1_;
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
    KEL.typ.int C_O_U_N_T___Exp1__14_ := 0;
    KEL.typ.int C_O_U_N_T___Exp1__15_ := 0;
    KEL.typ.ntyp(E_Social_Security_Number.Typ) U_I_D__2_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  __JC687766(__ST681608_Layout __EE684855, __ST680274_Layout __EE687760) := __EEQP(__EE684855.UID,__EE687760.UID);
  __ST681945_Layout __JT687766(__ST681608_Layout __l, __ST680274_Layout __r) := TRANSFORM
    SELF.U_I_D__2_ := __r.UID;
    SELF := __l;
    SELF := __r;
  END;
  SHARED __EE687823 := JOIN(__EE684855,__EE687760,__JC687766(LEFT,RIGHT),__JT687766(LEFT,RIGHT),LEFT OUTER,HASH);
  SHARED __EE677386 := __ENH_Customer_1;
  SHARED __EE686449 := __EE677386;
  SHARED __ST682350_Layout := RECORD
    KEL.typ.nuid UID;
    KEL.typ.ntyp(E_Customer.Typ) _r_Customer_;
    KEL.typ.ndataset(E_Social_Security_Number.Source_Customers_Layout) Source_Customers_;
    KEL.typ.nunk Ssn_;
    KEL.typ.nint Otto_S_S_N_Id_;
    KEL.typ.nstr Ssn_Formatted_;
    KEL.typ.nunk _v2__divssnidentitycountnew_;
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
    KEL.typ.int Cl_Active30_Identity_Count_ := 0;
    KEL.typ.nint Cl_Active30_Identity_Count_Percentile_;
    KEL.typ.int Cl_Active7_Identity_Count_ := 0;
    KEL.typ.nint Cl_Active7_Identity_Count_Percentile_;
    KEL.typ.int Cl_Event_Count_ := 0;
    KEL.typ.nint Cl_Event_Count_Percentile_;
    KEL.typ.int Cl_Identity_Count_ := 0;
    KEL.typ.nint Cl_Identity_Count_Percentile_;
    KEL.typ.int Identity_Count_ := 0;
    KEL.typ.int Vl_Event30_All_Day_Count_ := 0;
    KEL.typ.int Vl_Event30_Count_ := 0;
    KEL.typ.int Vl_Event7_All_Count_ := 0;
    KEL.typ.int Vl_Event7_Count_ := 0;
    KEL.typ.int C_O_U_N_T___Ssn_Event_ := 0;
    KEL.typ.ntyp(E_Social_Security_Number.Typ) U_I_D__1_;
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
    KEL.typ.int C_O_U_N_T___Exp1__14_ := 0;
    KEL.typ.int C_O_U_N_T___Exp1__15_ := 0;
    KEL.typ.ntyp(E_Social_Security_Number.Typ) U_I_D__2_;
    KEL.typ.nuid U_I_D__3_;
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
  __JC687829(__ST681945_Layout __EE687823, B_Customer_1.__ST19356_Layout __EE686449) := __EEQP(__EE687823._r_Customer_,__EE686449.UID);
  __ST682350_Layout __JT687829(__ST681945_Layout __l, B_Customer_1.__ST19356_Layout __r) := TRANSFORM
    SELF.U_I_D__3_ := __r.UID;
    SELF := __l;
    SELF := __r;
  END;
  SHARED __EE687899 := JOIN(__EE687823,__EE686449,__JC687829(LEFT,RIGHT),__JT687829(LEFT,RIGHT),LEFT OUTER,HASH);
  SHARED __ST682765_Layout := RECORD
    KEL.typ.nuid UID;
    KEL.typ.ntyp(E_Customer.Typ) _r_Customer_;
    KEL.typ.ndataset(E_Social_Security_Number.Source_Customers_Layout) Source_Customers_;
    KEL.typ.nunk Ssn_;
    KEL.typ.nint Otto_S_S_N_Id_;
    KEL.typ.nstr Ssn_Formatted_;
    KEL.typ.nunk _v2__divssnidentitycountnew_;
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
    KEL.typ.int Cl_Active30_Identity_Count_ := 0;
    KEL.typ.nint Cl_Active30_Identity_Count_Percentile_;
    KEL.typ.int Cl_Active7_Identity_Count_ := 0;
    KEL.typ.nint Cl_Active7_Identity_Count_Percentile_;
    KEL.typ.int Cl_Event_Count_ := 0;
    KEL.typ.nint Cl_Event_Count_Percentile_;
    KEL.typ.int Cl_Identity_Count_ := 0;
    KEL.typ.nint Cl_Identity_Count_Percentile_;
    KEL.typ.int Identity_Count_ := 0;
    KEL.typ.int Vl_Event30_All_Day_Count_ := 0;
    KEL.typ.int Vl_Event30_Count_ := 0;
    KEL.typ.int Vl_Event7_All_Count_ := 0;
    KEL.typ.int Vl_Event7_Count_ := 0;
    KEL.typ.int C_O_U_N_T___Ssn_Event_ := 0;
    KEL.typ.ntyp(E_Social_Security_Number.Typ) U_I_D__1_;
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
    KEL.typ.int C_O_U_N_T___Exp1__14_ := 0;
    KEL.typ.int C_O_U_N_T___Exp1__15_ := 0;
    KEL.typ.ntyp(E_Social_Security_Number.Typ) U_I_D__2_;
    KEL.typ.nuid U_I_D__3_;
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
    KEL.typ.nuid U_I_D__4_;
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
  __JC687905(__ST682350_Layout __EE687899, B_Customer_1.__ST19356_Layout __EE677386) := __EEQP(__EE687899._r_Customer_,__EE677386.UID);
  __ST682765_Layout __JT687905(__ST682350_Layout __l, B_Customer_1.__ST19356_Layout __r) := TRANSFORM
    SELF.U_I_D__4_ := __r.UID;
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
  SHARED __EE688012 := JOIN(__EE687899,__EE677386,__JC687905(LEFT,RIGHT),__JT687905(LEFT,RIGHT),LEFT OUTER,HASH);
  EXPORT __ST19122_Layout := RECORD
    KEL.typ.nuid UID;
    KEL.typ.ntyp(E_Customer.Typ) _r_Customer_;
    KEL.typ.ndataset(E_Social_Security_Number.Source_Customers_Layout) Source_Customers_;
    KEL.typ.nunk Ssn_;
    KEL.typ.nint Otto_S_S_N_Id_;
    KEL.typ.nstr Ssn_Formatted_;
    KEL.typ.nunk _v2__divssnidentitycountnew_;
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
    KEL.typ.int Hri06_Flag_ := 0;
    KEL.typ.int Hri26_Flag_ := 0;
    KEL.typ.int Hri29_Flag_ := 0;
    KEL.typ.int Hri38_Flag_ := 0;
    KEL.typ.int Hri71_Flag_ := 0;
    KEL.typ.int Hri_It_Flag_ := 0;
    KEL.typ.int Hri_Mi_Flag_ := 0;
    KEL.typ.int Identity_Count_ := 0;
    KEL.typ.int In_Customer_Population_ := 0;
    KEL.typ.nint Industry_Type_;
    KEL.typ.int Kr_High_Risk_Flag_ := 0;
    KEL.typ.int Kr_Medium_Risk_Flag_ := 0;
    KEL.typ.int Kr_Ssn100_Flag_ := 0;
    KEL.typ.int Kr_Ssn101_Flag_ := 0;
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
  SHARED __ST19122_Layout __ND688017__Project(__ST682765_Layout __PP688013) := TRANSFORM
    SELF.Cl_Element_Count_ := 0;
    SELF.Cl_Impact_Weight_ := __OP2(__OP2(__OP2(__OP2(__PP688013.Cl_Identity_Count_Percentile_,*,__CN(0.3)),+,__OP2(__PP688013.Cl_Event_Count_Percentile_,*,__CN(0.3))),+,__OP2(__PP688013.Cl_Active30_Identity_Count_Percentile_,*,__CN(0.2))),+,__OP2(__PP688013.Cl_Active7_Identity_Count_Percentile_,*,__CN(0.2)));
    SELF.Cluster_Score_ := 0;
    SELF.Contributor_Safe_Flag_ := MAP(__PP688013.C_O_U_N_T___Exp1_ <> 0=>1,0);
    SELF.Customer_Id_ := __PP688013.Customer_Id__1_;
    SELF.Entity_Context_Uid_ := __OP2(__CN('_15'),+,__PP688013.Otto_S_S_N_Id_);
    SELF.Entity_Type_ := 15;
    SELF.Event_Count_ := __PP688013.C_O_U_N_T___Ssn_Event_;
    SELF.Hri06_Flag_ := MAP(__PP688013.C_O_U_N_T___Exp1__1_ <> 0=>1,0);
    SELF.Hri26_Flag_ := MAP(__PP688013.C_O_U_N_T___Exp1__2_ <> 0=>1,0);
    SELF.Hri29_Flag_ := MAP(__PP688013.C_O_U_N_T___Exp1__3_ <> 0=>1,0);
    SELF.Hri38_Flag_ := MAP(__PP688013.C_O_U_N_T___Exp1__4_ <> 0=>1,0);
    SELF.Hri71_Flag_ := MAP(__PP688013.C_O_U_N_T___Exp1__5_ <> 0=>1,0);
    SELF.Hri_It_Flag_ := MAP(__PP688013.C_O_U_N_T___Exp1__6_ <> 0=>1,0);
    SELF.Hri_Mi_Flag_ := MAP(__PP688013.C_O_U_N_T___Exp1__7_ <> 0=>1,0);
    __BS688200 := __T(__PP688013.Source_Customers_);
    SELF.In_Customer_Population_ := MAP(EXISTS(__BS688200(__T(__OP2(__T(__PP688013.Source_Customers_)._r_Source_Customer_,=,__PP688013._r_Customer_))))=>1,0);
    SELF.Kr_High_Risk_Flag_ := MAP(__PP688013.C_O_U_N_T___Exp1__8_ <> 0=>1,0);
    SELF.Kr_Medium_Risk_Flag_ := 0;
    SELF.Kr_Ssn100_Flag_ := MAP(__PP688013.C_O_U_N_T___Exp1__9_ <> 0=>1,0);
    SELF.Kr_Ssn101_Flag_ := MAP(__PP688013.C_O_U_N_T___Exp1__10_ <> 0=>1,0);
    SELF.Label_ := __PP688013.Ssn_Formatted_;
    SELF.Safe_Flag_ := MAP(__PP688013.C_O_U_N_T___Exp1__11_ <> 0=>1,0);
    SELF.Score_ := __OP2(__PP688013.UID,%,__CN(100));
    SELF.Source_Customer_Count_ := KEL.Aggregates.CountN(__PP688013.Source_Customers_);
    SELF.Vl_Event1_All_Count_ := __PP688013.C_O_U_N_T___Exp1__12_;
    SELF.Vl_Event1_Count_ := __PP688013.C_O_U_N_T___Exp1__13_;
    SELF.Vl_Event30_Active_Flag_ := MAP(__PP688013.Vl_Event30_Count_ > 0=>1,0);
    SELF.Vl_Event30_All_Active_Flag_ := MAP(__PP688013.Vl_Event30_All_Day_Count_ > 0=>1,0);
    SELF.Vl_Event365_All_Day_Count_ := __PP688013.C_O_U_N_T___Exp1__14_;
    SELF.Vl_Event365_Count_ := __PP688013.C_O_U_N_T___Exp1__15_;
    SELF.Vl_Event7_Active_Flag_ := MAP(__PP688013.Vl_Event7_Count_ > 0=>1,0);
    SELF.Vl_Event7_All_Active_Flag_ := MAP(__PP688013.Vl_Event7_All_Count_ > 0=>1,0);
    SELF := __PP688013;
  END;
  EXPORT __ENH_Social_Security_Number := PROJECT(__EE688012,__ND688017__Project(LEFT)) : PERSIST('~temp::KEL::KELOtto::Social_Security_Number::Annotated',EXPIRE(7));
  SHARED __EE831458 := __ENH_Social_Security_Number;
  SHARED IDX_Social_Security_Number_UID_Layout := RECORD
    KEL.typ.uid UID;
    __EE831458._r_Customer_;
    __EE831458.Source_Customers_;
    __EE831458.Ssn_;
    __EE831458.Otto_S_S_N_Id_;
    __EE831458.Ssn_Formatted_;
    __EE831458._v2__divssnidentitycountnew_;
    __EE831458.Deceased_Date_;
    __EE831458.Deceased_Date_Of_Birth_;
    __EE831458.Deceased_First_;
    __EE831458.Deceased_Middle_;
    __EE831458.Deceased_Last_;
    __EE831458.Deceased_Match_Code_;
    __EE831458._isdeepdive_;
    __EE831458._county__death_;
    __EE831458.Deceased_Ssn_;
    __EE831458._state__death__flag_;
    __EE831458._death__rec__src_;
    __EE831458._state__death__id_;
    __EE831458.Customer_Id_;
    __EE831458.Industry_Type_;
    __EE831458.Source_Customer_Count_;
    __EE831458.Entity_Context_Uid_;
    __EE831458.Entity_Type_;
    __EE831458.Label_;
    __EE831458.In_Customer_Population_;
    __EE831458.Identity_Count_;
    __EE831458.Event_Count_;
    __EE831458.Hri06_Flag_;
    __EE831458.Hri26_Flag_;
    __EE831458.Hri29_Flag_;
    __EE831458.Hri38_Flag_;
    __EE831458.Hri71_Flag_;
    __EE831458.Hri_It_Flag_;
    __EE831458.Hri_Mi_Flag_;
    __EE831458.Kr_High_Risk_Flag_;
    __EE831458.Kr_Medium_Risk_Flag_;
    __EE831458.Safe_Flag_;
    __EE831458.Contributor_Safe_Flag_;
    __EE831458.Kr_Ssn100_Flag_;
    __EE831458.Kr_Ssn101_Flag_;
    __EE831458.Vl_Event1_All_Count_;
    __EE831458.Vl_Event7_All_Count_;
    __EE831458.Vl_Event30_All_Day_Count_;
    __EE831458.Vl_Event365_All_Day_Count_;
    __EE831458.Vl_Event7_All_Active_Flag_;
    __EE831458.Vl_Event30_All_Active_Flag_;
    __EE831458.Vl_Event1_Count_;
    __EE831458.Vl_Event7_Count_;
    __EE831458.Vl_Event30_Count_;
    __EE831458.Vl_Event365_Count_;
    __EE831458.Vl_Event7_Active_Flag_;
    __EE831458.Vl_Event30_Active_Flag_;
    __EE831458.Cl_Identity_Count_;
    __EE831458.Cl_Active7_Identity_Count_;
    __EE831458.Cl_Active30_Identity_Count_;
    __EE831458.Cl_Element_Count_;
    __EE831458.Cl_Event_Count_;
    __EE831458.Cl_Identity_Count_Percentile_;
    __EE831458.Cl_Event_Count_Percentile_;
    __EE831458.Cl_Active30_Identity_Count_Percentile_;
    __EE831458.Cl_Active7_Identity_Count_Percentile_;
    __EE831458.Cl_Impact_Weight_;
    __EE831458.Score_;
    __EE831458.Cluster_Score_;
    __EE831458.Date_First_Seen_;
    __EE831458.Date_Last_Seen_;
    __EE831458.__RecordCount;
  END;
  SHARED IDX_Social_Security_Number_UID_Projected := PROJECT(__EE831458,TRANSFORM(IDX_Social_Security_Number_UID_Layout,SELF.UID:=__T(LEFT.UID),SELF:=LEFT));
  EXPORT IDX_Social_Security_Number_UID := INDEX(IDX_Social_Security_Number_UID_Projected,{UID},{IDX_Social_Security_Number_UID_Projected},'~key::KEL::KELOtto::Social_Security_Number::UID');
  EXPORT IDX_Social_Security_Number_UID_Build := BUILD(IDX_Social_Security_Number_UID,OVERWRITE);
  EXPORT __ST831460_Layout := RECORDOF(IDX_Social_Security_Number_UID);
  EXPORT IDX_Social_Security_Number_UID_Wrapped := PROJECT(IDX_Social_Security_Number_UID,TRANSFORM(__ST19122_Layout,SELF.UID := __CN(LEFT.UID),SELF:=LEFT));
  EXPORT BuildAll := PARALLEL(IDX_Social_Security_Number_UID_Build);
END;
