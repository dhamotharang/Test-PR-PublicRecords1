﻿//HPCC Systems KEL Compiler Version 0.11.0
IMPORT KEL011 AS KEL;
IMPORT B_Address_1,B_Customer_1,B_Person_1,B_Person_2,E_Address,E_Customer,E_Person,E_Person_Address FROM KELOtto;
IMPORT * FROM KEL011.Null;
EXPORT B_Address := MODULE
  SHARED VIRTUAL TYPEOF(B_Address_1.__ENH_Address_1) __ENH_Address_1 := B_Address_1.__ENH_Address_1;
  SHARED VIRTUAL TYPEOF(B_Customer_1.__ENH_Customer_1) __ENH_Customer_1 := B_Customer_1.__ENH_Customer_1;
  SHARED VIRTUAL TYPEOF(B_Person_1.__ENH_Person_1) __ENH_Person_1 := B_Person_1.__ENH_Person_1;
  SHARED VIRTUAL TYPEOF(E_Person_Address.__Result) __E_Person_Address := E_Person_Address.__Result;
  SHARED __EE92512 := __ENH_Address_1;
  SHARED __EE92745 := __ENH_Person_1;
  SHARED __EE92735 := __E_Person_Address;
  SHARED __EE104831 := __EE92735(__NN(__EE92735.Location_) AND __NN(__EE92735.Subject_));
  SHARED __ST98038_Layout := RECORD
    KEL.typ.nuid UID;
    KEL.typ.ntyp(E_Customer.Typ) _r_Customer_;
    KEL.typ.nint Lex_Id_;
    KEL.typ.ndataset(E_Person.Source_Customers_Layout) Source_Customers_;
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
    KEL.typ.int All_Death_Prior_To_All_Events_ := 0;
    KEL.typ.nfloat All_Deceased_Event_Percent_;
    KEL.typ.nint All_Max_Deceased_To_Event_Diff_;
    B_Person_2.__NS39787_Layout Best_Full_Name_;
    KEL.typ.int Cl_Death_Prior_To_All_Events_Identity_Count_ := 0;
    KEL.typ.int Cl_Event_Count_ := 0;
    KEL.typ.int Cl_High_Risk_Death_Prior_To_All_Events_Identity_Count_ := 0;
    KEL.typ.int Cl_Identity_Count_ := 0;
    KEL.typ.int Cl_Nap3_Identity_Count_ := 0;
    KEL.typ.int Cl_Nas9_Identity_Count_ := 0;
    KEL.typ.int Death_Prior_To_All_Events_ := 0;
    KEL.typ.int Deceased_ := 0;
    KEL.typ.int Deceased_Dob_Match_ := 0;
    KEL.typ.nfloat Deceased_Event_Percent_;
    KEL.typ.int Deceased_Match_ := 0;
    KEL.typ.int Deceased_Name_Match_ := 0;
    KEL.typ.nunk Entity_Context_Uid_;
    KEL.typ.int High_Risk_Death_Prior_To_All_Events_ := 0;
    KEL.typ.int In_Customer_Population_ := 0;
    KEL.typ.nstr Label_;
    KEL.typ.nint Max_Deceased_To_Event_Diff_;
    KEL.typ.int Nap3_Flag_ := 0;
    KEL.typ.int Nas9_Flag_ := 0;
    KEL.typ.nint Score_;
    KEL.typ.ntyp(E_Customer.Typ) _r_Customer__1_;
    KEL.typ.ntyp(E_Person.Typ) Subject_;
    KEL.typ.ntyp(E_Address.Typ) Location_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  __JC104849(B_Person_1.__ST3059_Layout __EE92745, E_Person_Address.Layout __EE104831) := __EEQP(__EE104831.Subject_,__EE92745.UID);
  __ST98038_Layout __JT104849(B_Person_1.__ST3059_Layout __l, E_Person_Address.Layout __r) := TRANSFORM
    SELF._r_Customer__1_ := __r._r_Customer_;
    SELF := __l;
    SELF := __r;
  END;
  SHARED __EE104850 := JOIN(__EE104831,__EE92745,__JC104849(RIGHT,LEFT),__JT104849(RIGHT,LEFT),INNER,HASH);
  SHARED __ST95865_Layout := RECORD
    KEL.typ.ntyp(E_Address.Typ) UID;
    KEL.typ.ntyp(E_Customer.Typ) _r_Customer_;
    KEL.typ.ntyp(E_Person.Typ) Subject_;
    KEL.typ.ntyp(E_Address.Typ) Location_;
    KEL.typ.nuid U_I_D__1_;
    KEL.typ.ntyp(E_Customer.Typ) _r_Customer__1_;
    KEL.typ.nint Lex_Id_;
    KEL.typ.ndataset(E_Person.Source_Customers_Layout) Source_Customers_;
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
    KEL.typ.int All_Death_Prior_To_All_Events_ := 0;
    KEL.typ.nfloat All_Deceased_Event_Percent_;
    KEL.typ.nint All_Max_Deceased_To_Event_Diff_;
    B_Person_2.__NS39787_Layout Best_Full_Name_;
    KEL.typ.int Cl_Death_Prior_To_All_Events_Identity_Count_ := 0;
    KEL.typ.int Cl_Event_Count_ := 0;
    KEL.typ.int Cl_High_Risk_Death_Prior_To_All_Events_Identity_Count_ := 0;
    KEL.typ.int Cl_Identity_Count_ := 0;
    KEL.typ.int Cl_Nap3_Identity_Count_ := 0;
    KEL.typ.int Cl_Nas9_Identity_Count_ := 0;
    KEL.typ.int Death_Prior_To_All_Events_ := 0;
    KEL.typ.int Deceased_ := 0;
    KEL.typ.int Deceased_Dob_Match_ := 0;
    KEL.typ.nfloat Deceased_Event_Percent_;
    KEL.typ.int Deceased_Match_ := 0;
    KEL.typ.int Deceased_Name_Match_ := 0;
    KEL.typ.nunk Entity_Context_Uid_;
    KEL.typ.int High_Risk_Death_Prior_To_All_Events_ := 0;
    KEL.typ.int In_Customer_Population_ := 0;
    KEL.typ.nstr Label_;
    KEL.typ.nint Max_Deceased_To_Event_Diff_;
    KEL.typ.int Nap3_Flag_ := 0;
    KEL.typ.int Nas9_Flag_ := 0;
    KEL.typ.nint Score_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
  END;
  SHARED __ST95865_Layout __ND105009__Project(__ST98038_Layout __PP104851) := TRANSFORM
    SELF.UID := __PP104851.Location_;
    SELF._r_Customer_ := __PP104851._r_Customer__1_;
    SELF.U_I_D__1_ := __PP104851.UID;
    SELF._r_Customer__1_ := __PP104851._r_Customer_;
    SELF := __PP104851;
  END;
  SHARED __EE105586 := PROJECT(__EE104850,__ND105009__Project(LEFT));
  SHARED __ST96186_Layout := RECORD
    KEL.typ.ntyp(E_Address.Typ) UID;
    KEL.typ.nint Score_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
  END;
  SHARED __EE105600 := PROJECT(__EE105586,__ST96186_Layout);
  SHARED __EE106151 := __EE105600;
  SHARED __ST97483_Layout := RECORD
    KEL.typ.nint M_A_X___Score_;
    KEL.typ.ntyp(E_Address.Typ) UID;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
  END;
  SHARED __EE106169 := PROJECT(__CLEANANDDO(__EE106151,TABLE(__EE106151,{KEL.Aggregates.MaxNG(__EE106151.Score_) M_A_X___Score_,UID},UID,MERGE)),__ST97483_Layout);
  SHARED __ST99539_Layout := RECORD
    KEL.typ.nuid UID;
    KEL.typ.ntyp(E_Customer.Typ) _r_Customer_;
    KEL.typ.ndataset(E_Address.Source_Customers_Layout) Source_Customers_;
    KEL.typ.nint Otto_Address_Id_;
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
    KEL.typ.int All_Deceased_Match_Person_Count_ := 0;
    KEL.typ.int All_Deceased_Person_Count_ := 0;
    KEL.typ.int All_High_Risk_Death_Prior_To_All_Events_Person_Count_ := 0;
    KEL.typ.float All_High_Risk_Death_Prior_To_All_Events_Person_Percent_ := 0.0;
    KEL.typ.int All_Person_Count_ := 0;
    KEL.typ.int Deceased_Match_Person_Count_ := 0;
    KEL.typ.int Deceased_Person_Count_ := 0;
    KEL.typ.nunk Entity_Context_Uid_;
    KEL.typ.nstr Full_Address_;
    KEL.typ.int High_Frequency_Flag_ := 0;
    KEL.typ.int High_Risk_Death_Prior_To_All_Events_Person_Count_ := 0;
    KEL.typ.float High_Risk_Death_Prior_To_All_Events_Person_Percent_ := 0.0;
    KEL.typ.int In_Customer_Population_ := 0;
    KEL.typ.int Person_Count_ := 0;
    KEL.typ.nint M_A_X___Score_;
    KEL.typ.ntyp(E_Address.Typ) U_I_D__1_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  __JC106175(B_Address_1.__ST2854_Layout __EE92512, __ST97483_Layout __EE106169) := __EEQP(__EE92512.UID,__EE106169.UID);
  __ST99539_Layout __JT106175(B_Address_1.__ST2854_Layout __l, __ST97483_Layout __r) := TRANSFORM
    SELF.U_I_D__1_ := __r.UID;
    SELF := __l;
    SELF := __r;
  END;
  SHARED __EE106176 := JOIN(__EE92512,__EE106169,__JC106175(LEFT,RIGHT),__JT106175(LEFT,RIGHT),LEFT OUTER,HASH);
  SHARED __ST96201_Layout := RECORD
    KEL.typ.nint M_E_D_I_A_N___Score_;
    KEL.typ.ntyp(E_Address.Typ) UID;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
  END;
  __ST96201_WeightLayout := {KEL.typ.int M_E_D_I_A_N___Score_};
  __ST96201_WeightLayout __ST96201_WeightCalc(KEL.Aggregates.RankedFieldN __r) := TRANSFORM
    SELF.M_E_D_I_A_N___Score_ := IF(__r.number = 1,KEL.Aggregates.NTileWeight(2,1,__r.size,__r.pos),0);
  END;
  __ST96201_Layout __ST96201_Normalize(__ST96201_Layout __r) := TRANSFORM
    SELF.M_E_D_I_A_N___Score_ := __OP2(__r.M_E_D_I_A_N___Score_,/,__CN(2));
    SELF := __r;
  END;
  __RK105606 := KEL.Aggregates.RankingGroupedSmall2(__EE105600,'Score_','UID',__ST96201_WeightLayout,__ST96201_Layout,__ST96201_WeightCalc,__ST96201_Normalize,TRUE,FALSE,FALSE);
  SHARED __EE105616 := __RK105606;
  SHARED __ST99874_Layout := RECORD
    KEL.typ.nuid UID;
    KEL.typ.ntyp(E_Customer.Typ) _r_Customer_;
    KEL.typ.ndataset(E_Address.Source_Customers_Layout) Source_Customers_;
    KEL.typ.nint Otto_Address_Id_;
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
    KEL.typ.int All_Deceased_Match_Person_Count_ := 0;
    KEL.typ.int All_Deceased_Person_Count_ := 0;
    KEL.typ.int All_High_Risk_Death_Prior_To_All_Events_Person_Count_ := 0;
    KEL.typ.float All_High_Risk_Death_Prior_To_All_Events_Person_Percent_ := 0.0;
    KEL.typ.int All_Person_Count_ := 0;
    KEL.typ.int Deceased_Match_Person_Count_ := 0;
    KEL.typ.int Deceased_Person_Count_ := 0;
    KEL.typ.nunk Entity_Context_Uid_;
    KEL.typ.nstr Full_Address_;
    KEL.typ.int High_Frequency_Flag_ := 0;
    KEL.typ.int High_Risk_Death_Prior_To_All_Events_Person_Count_ := 0;
    KEL.typ.float High_Risk_Death_Prior_To_All_Events_Person_Percent_ := 0.0;
    KEL.typ.int In_Customer_Population_ := 0;
    KEL.typ.int Person_Count_ := 0;
    KEL.typ.nint M_A_X___Score_;
    KEL.typ.ntyp(E_Address.Typ) U_I_D__1_;
    KEL.typ.nint M_E_D_I_A_N___Score_;
    KEL.typ.ntyp(E_Address.Typ) U_I_D__2_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  __JC106234(__ST99539_Layout __EE106176, __ST96201_Layout __EE105616) := __EEQP(__EE106176.UID,__EE105616.UID);
  __ST99874_Layout __JT106234(__ST99539_Layout __l, __ST96201_Layout __r) := TRANSFORM
    SELF.U_I_D__2_ := __r.UID;
    SELF := __l;
    SELF := __r;
  END;
  SHARED __EE106235 := JOIN(__EE106176,__EE105616,__JC106234(LEFT,RIGHT),__JT106234(LEFT,RIGHT),LEFT OUTER,HASH);
  SHARED __EE93913 := __ENH_Customer_1;
  SHARED __EE106133 := __EE93913;
  SHARED __ST100208_Layout := RECORD
    KEL.typ.nuid UID;
    KEL.typ.ntyp(E_Customer.Typ) _r_Customer_;
    KEL.typ.ndataset(E_Address.Source_Customers_Layout) Source_Customers_;
    KEL.typ.nint Otto_Address_Id_;
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
    KEL.typ.int All_Deceased_Match_Person_Count_ := 0;
    KEL.typ.int All_Deceased_Person_Count_ := 0;
    KEL.typ.int All_High_Risk_Death_Prior_To_All_Events_Person_Count_ := 0;
    KEL.typ.float All_High_Risk_Death_Prior_To_All_Events_Person_Percent_ := 0.0;
    KEL.typ.int All_Person_Count_ := 0;
    KEL.typ.int Deceased_Match_Person_Count_ := 0;
    KEL.typ.int Deceased_Person_Count_ := 0;
    KEL.typ.nunk Entity_Context_Uid_;
    KEL.typ.nstr Full_Address_;
    KEL.typ.int High_Frequency_Flag_ := 0;
    KEL.typ.int High_Risk_Death_Prior_To_All_Events_Person_Count_ := 0;
    KEL.typ.float High_Risk_Death_Prior_To_All_Events_Person_Percent_ := 0.0;
    KEL.typ.int In_Customer_Population_ := 0;
    KEL.typ.int Person_Count_ := 0;
    KEL.typ.nint M_A_X___Score_;
    KEL.typ.ntyp(E_Address.Typ) U_I_D__1_;
    KEL.typ.nint M_E_D_I_A_N___Score_;
    KEL.typ.ntyp(E_Address.Typ) U_I_D__2_;
    KEL.typ.nuid U_I_D__3_;
    KEL.typ.nint Customer_Id_;
    KEL.typ.nint Industry_Type_;
    KEL.typ.nint Fdn_File_Info_Id_;
    KEL.typ.int Address_Count_ := 0;
    KEL.typ.int All_Address_Count_ := 0;
    KEL.typ.int All_Deceased_Matched_Person_Count_ := 0;
    KEL.typ.int All_Deceased_Person_Count__1_ := 0;
    KEL.typ.int All_High_Frequency_Address_Count_ := 0;
    KEL.typ.int All_Person_Count__1_ := 0;
    KEL.typ.int Deceased_Person_Count__1_ := 0;
    KEL.typ.int High_Frequency_Address_Count_ := 0;
    KEL.typ.int Person_Count__1_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  __JC106298(__ST99874_Layout __EE106235, B_Customer_1.__ST2910_Layout __EE106133) := __EEQP(__EE106235._r_Customer_,__EE106133.UID);
  __ST100208_Layout __JT106298(__ST99874_Layout __l, B_Customer_1.__ST2910_Layout __r) := TRANSFORM
    SELF.U_I_D__3_ := __r.UID;
    SELF.All_Deceased_Person_Count__1_ := __r.All_Deceased_Person_Count_;
    SELF.All_Person_Count__1_ := __r.All_Person_Count_;
    SELF.Deceased_Person_Count__1_ := __r.Deceased_Person_Count_;
    SELF.Person_Count__1_ := __r.Person_Count_;
    SELF := __l;
    SELF := __r;
  END;
  SHARED __EE106299 := JOIN(__EE106235,__EE106133,__JC106298(LEFT,RIGHT),__JT106298(LEFT,RIGHT),LEFT OUTER,HASH);
  SHARED __ST100560_Layout := RECORD
    KEL.typ.nuid UID;
    KEL.typ.ntyp(E_Customer.Typ) _r_Customer_;
    KEL.typ.ndataset(E_Address.Source_Customers_Layout) Source_Customers_;
    KEL.typ.nint Otto_Address_Id_;
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
    KEL.typ.int All_Deceased_Match_Person_Count_ := 0;
    KEL.typ.int All_Deceased_Person_Count_ := 0;
    KEL.typ.int All_High_Risk_Death_Prior_To_All_Events_Person_Count_ := 0;
    KEL.typ.float All_High_Risk_Death_Prior_To_All_Events_Person_Percent_ := 0.0;
    KEL.typ.int All_Person_Count_ := 0;
    KEL.typ.int Deceased_Match_Person_Count_ := 0;
    KEL.typ.int Deceased_Person_Count_ := 0;
    KEL.typ.nunk Entity_Context_Uid_;
    KEL.typ.nstr Full_Address_;
    KEL.typ.int High_Frequency_Flag_ := 0;
    KEL.typ.int High_Risk_Death_Prior_To_All_Events_Person_Count_ := 0;
    KEL.typ.float High_Risk_Death_Prior_To_All_Events_Person_Percent_ := 0.0;
    KEL.typ.int In_Customer_Population_ := 0;
    KEL.typ.int Person_Count_ := 0;
    KEL.typ.nint M_A_X___Score_;
    KEL.typ.ntyp(E_Address.Typ) U_I_D__1_;
    KEL.typ.nint M_E_D_I_A_N___Score_;
    KEL.typ.ntyp(E_Address.Typ) U_I_D__2_;
    KEL.typ.nuid U_I_D__3_;
    KEL.typ.nint Customer_Id_;
    KEL.typ.nint Industry_Type_;
    KEL.typ.nint Fdn_File_Info_Id_;
    KEL.typ.int Address_Count_ := 0;
    KEL.typ.int All_Address_Count_ := 0;
    KEL.typ.int All_Deceased_Matched_Person_Count_ := 0;
    KEL.typ.int All_Deceased_Person_Count__1_ := 0;
    KEL.typ.int All_High_Frequency_Address_Count_ := 0;
    KEL.typ.int All_Person_Count__1_ := 0;
    KEL.typ.int Deceased_Person_Count__1_ := 0;
    KEL.typ.int High_Frequency_Address_Count_ := 0;
    KEL.typ.int Person_Count__1_ := 0;
    KEL.typ.nuid U_I_D__4_;
    KEL.typ.nint Customer_Id__1_;
    KEL.typ.nint Industry_Type__1_;
    KEL.typ.nint Fdn_File_Info_Id__1_;
    KEL.typ.int Address_Count__1_ := 0;
    KEL.typ.int All_Address_Count__1_ := 0;
    KEL.typ.int All_Deceased_Matched_Person_Count__1_ := 0;
    KEL.typ.int All_Deceased_Person_Count__2_ := 0;
    KEL.typ.int All_High_Frequency_Address_Count__1_ := 0;
    KEL.typ.int All_Person_Count__2_ := 0;
    KEL.typ.int Deceased_Person_Count__2_ := 0;
    KEL.typ.int High_Frequency_Address_Count__1_ := 0;
    KEL.typ.int Person_Count__2_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  __JC106380(__ST100208_Layout __EE106299, B_Customer_1.__ST2910_Layout __EE93913) := __EEQP(__EE106299._r_Customer_,__EE93913.UID);
  __ST100560_Layout __JT106380(__ST100208_Layout __l, B_Customer_1.__ST2910_Layout __r) := TRANSFORM
    SELF.U_I_D__4_ := __r.UID;
    SELF.Customer_Id__1_ := __r.Customer_Id_;
    SELF.Industry_Type__1_ := __r.Industry_Type_;
    SELF.Fdn_File_Info_Id__1_ := __r.Fdn_File_Info_Id_;
    SELF.Address_Count__1_ := __r.Address_Count_;
    SELF.All_Address_Count__1_ := __r.All_Address_Count_;
    SELF.All_Deceased_Matched_Person_Count__1_ := __r.All_Deceased_Matched_Person_Count_;
    SELF.All_Deceased_Person_Count__2_ := __r.All_Deceased_Person_Count_;
    SELF.All_High_Frequency_Address_Count__1_ := __r.All_High_Frequency_Address_Count_;
    SELF.All_Person_Count__2_ := __r.All_Person_Count_;
    SELF.Deceased_Person_Count__2_ := __r.Deceased_Person_Count_;
    SELF.High_Frequency_Address_Count__1_ := __r.High_Frequency_Address_Count_;
    SELF.Person_Count__2_ := __r.Person_Count_;
    SELF := __l;
    SELF := __r;
  END;
  SHARED __EE106381 := JOIN(__EE106299,__EE93913,__JC106380(LEFT,RIGHT),__JT106380(LEFT,RIGHT),LEFT OUTER,HASH);
  EXPORT __ST2423_Layout := RECORD
    KEL.typ.nuid UID;
    KEL.typ.ntyp(E_Customer.Typ) _r_Customer_;
    KEL.typ.ndataset(E_Address.Source_Customers_Layout) Source_Customers_;
    KEL.typ.nint Otto_Address_Id_;
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
    KEL.typ.int All_Deceased_Match_Person_Count_ := 0;
    KEL.typ.float All_Deceased_Match_Person_Percent_ := 0.0;
    KEL.typ.int All_Deceased_Person_Count_ := 0;
    KEL.typ.float All_Deceased_Person_Percent_ := 0.0;
    KEL.typ.int All_High_Frequency_Flag_ := 0;
    KEL.typ.int All_High_Risk_Death_Prior_To_All_Events_Person_Count_ := 0;
    KEL.typ.float All_High_Risk_Death_Prior_To_All_Events_Person_Percent_ := 0.0;
    KEL.typ.int All_High_Risk_Death_Prior_To_All_Events_Person_Percent_Flag_ := 0;
    KEL.typ.int All_Person_Count_ := 0;
    KEL.typ.nint Cluster_Score_;
    KEL.typ.nint Customer_Id_;
    KEL.typ.int Deceased_Match_Person_Count_ := 0;
    KEL.typ.float Deceased_Match_Person_Percent_ := 0.0;
    KEL.typ.int Deceased_Person_Count_ := 0;
    KEL.typ.float Deceased_Person_Percent_ := 0.0;
    KEL.typ.nunk Entity_Context_Uid_;
    KEL.typ.int Entity_Type_ := 0;
    KEL.typ.nstr Full_Address_;
    KEL.typ.int High_Frequency_Flag_ := 0;
    KEL.typ.int High_Risk_Death_Prior_To_All_Events_Percent_Flag_ := 0;
    KEL.typ.int High_Risk_Death_Prior_To_All_Events_Person_Count_ := 0;
    KEL.typ.float High_Risk_Death_Prior_To_All_Events_Person_Percent_ := 0.0;
    KEL.typ.int In_Customer_Population_ := 0;
    KEL.typ.nint Industry_Type_;
    KEL.typ.int Person_Count_ := 0;
    KEL.typ.nint Score_;
    KEL.typ.nint Source_Customer_Count_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  SHARED __ST2423_Layout __ND106490__Project(__ST100560_Layout __PP106382) := TRANSFORM
    SELF.All_Deceased_Match_Person_Percent_ := __PP106382.All_Deceased_Match_Person_Count_ / __PP106382.All_Person_Count_;
    SELF.All_Deceased_Person_Percent_ := __PP106382.All_Deceased_Person_Count_ / __PP106382.All_Person_Count_;
    SELF.All_High_Frequency_Flag_ := MAP(__PP106382.All_Person_Count_ >= 20=>1,0);
    SELF.All_High_Risk_Death_Prior_To_All_Events_Person_Percent_Flag_ := MAP(__PP106382.All_High_Risk_Death_Prior_To_All_Events_Person_Percent_ > 0.1=>1,0);
    SELF.Cluster_Score_ := __PP106382.M_E_D_I_A_N___Score_;
    SELF.Customer_Id_ := __PP106382.Customer_Id__1_;
    SELF.Deceased_Match_Person_Percent_ := __PP106382.Deceased_Match_Person_Count_ / __PP106382.Person_Count_;
    SELF.Deceased_Person_Percent_ := __PP106382.Deceased_Person_Count_ / __PP106382.Person_Count_;
    SELF.Entity_Type_ := 9;
    SELF.High_Risk_Death_Prior_To_All_Events_Percent_Flag_ := MAP(__PP106382.High_Risk_Death_Prior_To_All_Events_Person_Percent_ > 0.1=>1,0);
    SELF.Score_ := __PP106382.M_A_X___Score_;
    SELF.Source_Customer_Count_ := KEL.Aggregates.CountN(__PP106382.Source_Customers_);
    SELF := __PP106382;
  END;
  EXPORT __ENH_Address := PROJECT(__EE106381,__ND106490__Project(LEFT)) : PERSIST('~temp::KEL::KELOtto::Address::Annotated',EXPIRE(30));
  SHARED __EE183938 := __ENH_Address;
  SHARED IDX_Address_UID_Layout := RECORD
    KEL.typ.uid UID;
    __EE183938._r_Customer_;
    __EE183938.Source_Customers_;
    __EE183938.Otto_Address_Id_;
    __EE183938.Primary_Range_;
    __EE183938.Predirectional_;
    __EE183938.Primary_Name_;
    __EE183938.Suffix_;
    __EE183938.Postdirectional_;
    __EE183938.Unit_Designation_;
    __EE183938.Secondary_Range_;
    __EE183938.Postal_City_;
    __EE183938.Vanity_City_;
    __EE183938.State_;
    __EE183938.Z_I_P_;
    __EE183938.Z_I_P4_;
    __EE183938.Carrier_Route_Number_;
    __EE183938.Carrier_Route_Sortation_At_Z_I_P_;
    __EE183938.Line_Of_Travel_;
    __EE183938.Line_Of_Travel_Order_;
    __EE183938.Delivery_Point_Barcode_;
    __EE183938.Delivery_Point_Barcode_Check_Digit_;
    __EE183938.Type_Code_;
    __EE183938.County_;
    __EE183938.Latitude_;
    __EE183938.Longitude_;
    __EE183938.Metropolitan_Statistical_Area_;
    __EE183938.Geo_Block_;
    __EE183938.Geo_Match_;
    __EE183938.A_C_E_Cleaner_Error_Code_;
    __EE183938._is_Additional_;
    __EE183938.Customer_Id_;
    __EE183938.Industry_Type_;
    __EE183938.In_Customer_Population_;
    __EE183938.Source_Customer_Count_;
    __EE183938.Full_Address_;
    __EE183938.Entity_Context_Uid_;
    __EE183938.Entity_Type_;
    __EE183938.Person_Count_;
    __EE183938.High_Frequency_Flag_;
    __EE183938.All_Person_Count_;
    __EE183938.All_High_Frequency_Flag_;
    __EE183938.Deceased_Person_Count_;
    __EE183938.Deceased_Person_Percent_;
    __EE183938.All_Deceased_Person_Count_;
    __EE183938.All_Deceased_Person_Percent_;
    __EE183938.Deceased_Match_Person_Count_;
    __EE183938.Deceased_Match_Person_Percent_;
    __EE183938.All_Deceased_Match_Person_Count_;
    __EE183938.All_Deceased_Match_Person_Percent_;
    __EE183938.High_Risk_Death_Prior_To_All_Events_Person_Count_;
    __EE183938.High_Risk_Death_Prior_To_All_Events_Person_Percent_;
    __EE183938.High_Risk_Death_Prior_To_All_Events_Percent_Flag_;
    __EE183938.All_High_Risk_Death_Prior_To_All_Events_Person_Count_;
    __EE183938.All_High_Risk_Death_Prior_To_All_Events_Person_Percent_;
    __EE183938.All_High_Risk_Death_Prior_To_All_Events_Person_Percent_Flag_;
    __EE183938.Score_;
    __EE183938.Cluster_Score_;
    __EE183938.Date_First_Seen_;
    __EE183938.Date_Last_Seen_;
    __EE183938.__RecordCount;
  END;
  SHARED IDX_Address_UID_Projected := PROJECT(__EE183938,TRANSFORM(IDX_Address_UID_Layout,SELF.UID:=__T(LEFT.UID),SELF:=LEFT));
  EXPORT IDX_Address_UID := INDEX(IDX_Address_UID_Projected,{UID},{IDX_Address_UID_Projected},'~key::KEL::KELOtto::Address::UID');
  EXPORT IDX_Address_UID_Build := BUILD(IDX_Address_UID,OVERWRITE);
  EXPORT __ST183940_Layout := RECORDOF(IDX_Address_UID);
  EXPORT IDX_Address_UID_Wrapped := PROJECT(IDX_Address_UID,TRANSFORM(__ST2423_Layout,SELF.UID := __CN(LEFT.UID),SELF:=LEFT));
  EXPORT BuildAll := PARALLEL(IDX_Address_UID_Build);
END;
