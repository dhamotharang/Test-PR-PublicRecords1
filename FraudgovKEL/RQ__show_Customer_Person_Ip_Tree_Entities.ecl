﻿//HPCC Systems KEL Compiler Version 0.11.6-2
IMPORT KEL011 AS KEL;
IMPORT B_Customer,B_Customer_4,B_Internet_Protocol,B_Person,B_Person_1,B_Person_Ip_Address,E_Address,E_Customer,E_Internet_Protocol,E_Person,E_Person_Ip_Address FROM FraudgovKEL;
IMPORT * FROM KEL011.Null;
EXPORT RQ__show_Customer_Person_Ip_Tree_Entities := MODULE
  SHARED __EE1359292 := PROJECT(B_Person_Ip_Address.IDX_Person_Ip_Address_Ip__Wrapped,E_Person_Ip_Address.Layout);
  SHARED __EE1359295 := B_Person.IDX_Person_UID_Wrapped;
  SHARED __ST1278273_Layout := RECORD
    KEL.typ.ntyp(E_Customer.Typ) _r_Customer_;
    KEL.typ.ntyp(E_Person.Typ) Subject_;
    KEL.typ.ntyp(E_Internet_Protocol.Typ) Ip_;
    KEL.typ.ndataset(E_Person_Ip_Address.Event_Dates_Layout) Event_Dates_;
    KEL.typ.nuid UID;
    KEL.typ.ntyp(E_Customer.Typ) _r_Customer__1_;
    KEL.typ.nint Lex_Id_;
    KEL.typ.ndataset(E_Person.Source_Customers_Layout) Source_Customers_;
    KEL.typ.ndataset(E_Person.Reported_Date_Of_Birth_Layout) Reported_Date_Of_Birth_;
    KEL.typ.ndataset(E_Person.Reported_Ssn_Layout) Reported_Ssn_;
    KEL.typ.ndataset(E_Person.Reported_Email_Address_Layout) Reported_Email_Address_;
    KEL.typ.ndataset(E_Person.Full_Name_Layout) Full_Name_;
    KEL.typ.nint _rin__source_;
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
    KEL.typ.nstr _curr__incar__flag_;
    KEL.typ.nint _name__ssn__dob__match_;
    KEL.typ.ndataset(E_Person.Offenses_Layout) Offenses_;
    KEL.typ.ndataset(E_Person.Address_Layout) Address_;
    KEL.typ.int Address_Count_ := 0;
    KEL.typ.int Address_Is_Cmra30_Count_ := 0;
    KEL.typ.int Address_Is_Cmra30_Flag_ := 0;
    KEL.typ.int Address_Is_Of_State30_Flag_ := 0;
    KEL.typ.int Address_Is_Out_Of_State30_Count_ := 0;
    KEL.typ.nint Age_;
    KEL.typ.nint Age_At_Last_Event_;
    KEL.typ.int All_Death_Prior_To_All_Events_ := 0;
    KEL.typ.int All_Deceased_Event_Count_ := 0;
    KEL.typ.nfloat All_Deceased_Event_Percent_;
    KEL.typ.int All_High_Risk_Death_Prior_To_All_Events_ := 0;
    KEL.typ.nint All_Max_Deceased_To_Event_Diff_;
    KEL.typ.int Associated_With_Fraud_Offenses_Flag_ := 0;
    KEL.typ.int Associated_With_Incarcerated_Flag_ := 0;
    KEL.typ.nstr Best_City_;
    KEL.typ.nstr Best_Email_;
    KEL.typ.nstr Best_First_Name_;
    B_Person_1.__NS476519_Layout Best_Full_Name_;
    KEL.typ.nstr Best_Last_Name_;
    KEL.typ.nstr Best_Middle_Name_;
    KEL.typ.nstr Best_Name_Suffix_;
    B_Person_1.__NS476541_Layout Best_Reported_Address_;
    B_Person_1.__NS476561_Layout Best_Reported_Email_;
    B_Person_1.__NS476569_Layout Best_Reported_Ssn_;
    KEL.typ.nstr Best_Ssn_;
    KEL.typ.nstr Best_State_;
    KEL.typ.nstr Best_Street_Address_;
    KEL.typ.nstr Best_Zip_;
    KEL.typ.int Contributor_Safe_Flag_ := 0;
    KEL.typ.int Currently_Incarcerated_Flag_ := 0;
    KEL.typ.nint Customer_Id_;
    KEL.typ.nkdate Date_Of_Birth_;
    KEL.typ.int Death_Prior_To_All_Events_ := 0;
    KEL.typ.int Deceased_ := 0;
    KEL.typ.int Deceased_Dob_Match_ := 0;
    KEL.typ.int Deceased_Event_Count_ := 0;
    KEL.typ.nfloat Deceased_Event_Percent_;
    KEL.typ.int Deceased_Match_ := 0;
    KEL.typ.nstr Deceased_Match_Date_Of_Death_;
    KEL.typ.str Deceased_Match_Description_ := '';
    KEL.typ.int Deceased_Name_Match_ := 0;
    KEL.typ.nkdate Dt_First_Seen_;
    KEL.typ.nkdate Dt_Last_Seen_;
    KEL.typ.nunk Entity_Context_Uid_;
    KEL.typ.int Entity_Type_ := 0;
    KEL.typ.int Event_Count_ := 0;
    KEL.typ.int Fraud_Offense_Count_ := 0;
    KEL.typ.int Fraud_Offenses_Flag_ := 0;
    KEL.typ.int High_Risk_Death_Prior_To_All_Events_ := 0;
    KEL.typ.nint Id_Ssn_Identity_Count_Max_;
    KEL.typ.int In_Customer_Population_ := 0;
    KEL.typ.nint Industry_Type_;
    KEL.typ.int Ip_High_Risk_City_ := 0;
    KEL.typ.int Ip_Hosted_ := 0;
    KEL.typ.int Ip_Not_Us_ := 0;
    KEL.typ.int Ip_Tor_ := 0;
    KEL.typ.int Ip_Vpn_ := 0;
    KEL.typ.int Is_Minor_ := 0;
    KEL.typ.int Kr_Event_After_Known_Risk_Count_ := 0;
    KEL.typ.int Kr_Event_After_Known_Risk_Flag_ := 0;
    KEL.typ.int Kr_Event_After_Last_Known_Risk_Count_ := 0;
    KEL.typ.int Kr_Event_After_Last_Known_Risk_Flag_ := 0;
    KEL.typ.int Kr_Flag_ := 0;
    KEL.typ.int Kr_Has_Known_Risk_Element_Count_ := 0;
    KEL.typ.nint Kr_Has_Known_Risk_Element_Flag_;
    KEL.typ.int Kr_High_Risk_Flag_ := 0;
    KEL.typ.int Kr_High_Risk_Routing_ := 0;
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
    KEL.typ.int Kr_Id14900_Flag_ := 0;
    KEL.typ.int Kr_Id14901_Flag_ := 0;
    KEL.typ.int Kr_Id14902_Flag_ := 0;
    KEL.typ.int Kr_Id14903_Flag_ := 0;
    KEL.typ.int Kr_Id2025_Flag_ := 0;
    KEL.typ.nkdate Kr_Last_Element_Event_Date_;
    KEL.typ.nkdate Kr_Last_Event_Date_;
    KEL.typ.int Kr_Low_Risk_Flag_ := 0;
    KEL.typ.int Kr_Medium_Risk_Flag_ := 0;
    KEL.typ.int Kr_Not_Known_Risk_Has_Known_Risk_Element_Flag_ := 0;
    KEL.typ.nstr Label_;
    KEL.typ.nkdate Last_Event_Date_;
    KEL.typ.nint Last_Record_Id_;
    KEL.typ.nint Max_Deceased_To_Event_Diff_;
    KEL.typ.int No_Lex_Id_ := 0;
    KEL.typ.int No_Lex_Id_Gt22_ := 0;
    KEL.typ.int Other_Customer_Person_Customer_Count_ := 0;
    KEL.typ.int Safe_Flag_ := 0;
    KEL.typ.nkdate Safe_Flag_Last_Date_;
    KEL.typ.int Safe_Flag_Transaction_Count_ := 0;
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
  __JC1359303(E_Person_Ip_Address.Layout __EE1359292, B_Person.__ST28708_Layout __EE1359295) := __EEQP(__EE1359292.Subject_,__EE1359295.UID);
  __ST1278273_Layout __JT1359303(E_Person_Ip_Address.Layout __l, B_Person.__ST28708_Layout __r) := TRANSFORM
    SELF._r_Customer__1_ := __r._r_Customer_;
    SELF := __l;
    SELF := __r;
  END;
  SHARED __EE1359304 := JOIN(__EE1359292,__EE1359295,__JC1359303(LEFT,RIGHT),__JT1359303(LEFT,RIGHT),LEFT OUTER,HASH);
  SHARED __EE1359544 := B_Internet_Protocol.IDX_Internet_Protocol_UID_Wrapped;
  SHARED __ST1278557_Layout := RECORD
    KEL.typ.ntyp(E_Customer.Typ) _r_Customer_;
    KEL.typ.ntyp(E_Person.Typ) Subject_;
    KEL.typ.ntyp(E_Internet_Protocol.Typ) Ip_;
    KEL.typ.ndataset(E_Person_Ip_Address.Event_Dates_Layout) Event_Dates_;
    KEL.typ.nuid UID;
    KEL.typ.ntyp(E_Customer.Typ) _r_Customer__1_;
    KEL.typ.nint Lex_Id_;
    KEL.typ.ndataset(E_Person.Source_Customers_Layout) Source_Customers_;
    KEL.typ.ndataset(E_Person.Reported_Date_Of_Birth_Layout) Reported_Date_Of_Birth_;
    KEL.typ.ndataset(E_Person.Reported_Ssn_Layout) Reported_Ssn_;
    KEL.typ.ndataset(E_Person.Reported_Email_Address_Layout) Reported_Email_Address_;
    KEL.typ.ndataset(E_Person.Full_Name_Layout) Full_Name_;
    KEL.typ.nint _rin__source_;
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
    KEL.typ.nstr _curr__incar__flag_;
    KEL.typ.nint _name__ssn__dob__match_;
    KEL.typ.ndataset(E_Person.Offenses_Layout) Offenses_;
    KEL.typ.ndataset(E_Person.Address_Layout) Address_;
    KEL.typ.int Address_Count_ := 0;
    KEL.typ.int Address_Is_Cmra30_Count_ := 0;
    KEL.typ.int Address_Is_Cmra30_Flag_ := 0;
    KEL.typ.int Address_Is_Of_State30_Flag_ := 0;
    KEL.typ.int Address_Is_Out_Of_State30_Count_ := 0;
    KEL.typ.nint Age_;
    KEL.typ.nint Age_At_Last_Event_;
    KEL.typ.int All_Death_Prior_To_All_Events_ := 0;
    KEL.typ.int All_Deceased_Event_Count_ := 0;
    KEL.typ.nfloat All_Deceased_Event_Percent_;
    KEL.typ.int All_High_Risk_Death_Prior_To_All_Events_ := 0;
    KEL.typ.nint All_Max_Deceased_To_Event_Diff_;
    KEL.typ.int Associated_With_Fraud_Offenses_Flag_ := 0;
    KEL.typ.int Associated_With_Incarcerated_Flag_ := 0;
    KEL.typ.nstr Best_City_;
    KEL.typ.nstr Best_Email_;
    KEL.typ.nstr Best_First_Name_;
    B_Person_1.__NS476519_Layout Best_Full_Name_;
    KEL.typ.nstr Best_Last_Name_;
    KEL.typ.nstr Best_Middle_Name_;
    KEL.typ.nstr Best_Name_Suffix_;
    B_Person_1.__NS476541_Layout Best_Reported_Address_;
    B_Person_1.__NS476561_Layout Best_Reported_Email_;
    B_Person_1.__NS476569_Layout Best_Reported_Ssn_;
    KEL.typ.nstr Best_Ssn_;
    KEL.typ.nstr Best_State_;
    KEL.typ.nstr Best_Street_Address_;
    KEL.typ.nstr Best_Zip_;
    KEL.typ.int Contributor_Safe_Flag_ := 0;
    KEL.typ.int Currently_Incarcerated_Flag_ := 0;
    KEL.typ.nint Customer_Id_;
    KEL.typ.nkdate Date_Of_Birth_;
    KEL.typ.int Death_Prior_To_All_Events_ := 0;
    KEL.typ.int Deceased_ := 0;
    KEL.typ.int Deceased_Dob_Match_ := 0;
    KEL.typ.int Deceased_Event_Count_ := 0;
    KEL.typ.nfloat Deceased_Event_Percent_;
    KEL.typ.int Deceased_Match_ := 0;
    KEL.typ.nstr Deceased_Match_Date_Of_Death_;
    KEL.typ.str Deceased_Match_Description_ := '';
    KEL.typ.int Deceased_Name_Match_ := 0;
    KEL.typ.nkdate Dt_First_Seen_;
    KEL.typ.nkdate Dt_Last_Seen_;
    KEL.typ.nunk Entity_Context_Uid_;
    KEL.typ.int Entity_Type_ := 0;
    KEL.typ.int Event_Count_ := 0;
    KEL.typ.int Fraud_Offense_Count_ := 0;
    KEL.typ.int Fraud_Offenses_Flag_ := 0;
    KEL.typ.int High_Risk_Death_Prior_To_All_Events_ := 0;
    KEL.typ.nint Id_Ssn_Identity_Count_Max_;
    KEL.typ.int In_Customer_Population_ := 0;
    KEL.typ.nint Industry_Type_;
    KEL.typ.int Ip_High_Risk_City_ := 0;
    KEL.typ.int Ip_Hosted_ := 0;
    KEL.typ.int Ip_Not_Us_ := 0;
    KEL.typ.int Ip_Tor_ := 0;
    KEL.typ.int Ip_Vpn_ := 0;
    KEL.typ.int Is_Minor_ := 0;
    KEL.typ.int Kr_Event_After_Known_Risk_Count_ := 0;
    KEL.typ.int Kr_Event_After_Known_Risk_Flag_ := 0;
    KEL.typ.int Kr_Event_After_Last_Known_Risk_Count_ := 0;
    KEL.typ.int Kr_Event_After_Last_Known_Risk_Flag_ := 0;
    KEL.typ.int Kr_Flag_ := 0;
    KEL.typ.int Kr_Has_Known_Risk_Element_Count_ := 0;
    KEL.typ.nint Kr_Has_Known_Risk_Element_Flag_;
    KEL.typ.int Kr_High_Risk_Flag_ := 0;
    KEL.typ.int Kr_High_Risk_Routing_ := 0;
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
    KEL.typ.int Kr_Id14900_Flag_ := 0;
    KEL.typ.int Kr_Id14901_Flag_ := 0;
    KEL.typ.int Kr_Id14902_Flag_ := 0;
    KEL.typ.int Kr_Id14903_Flag_ := 0;
    KEL.typ.int Kr_Id2025_Flag_ := 0;
    KEL.typ.nkdate Kr_Last_Element_Event_Date_;
    KEL.typ.nkdate Kr_Last_Event_Date_;
    KEL.typ.int Kr_Low_Risk_Flag_ := 0;
    KEL.typ.int Kr_Medium_Risk_Flag_ := 0;
    KEL.typ.int Kr_Not_Known_Risk_Has_Known_Risk_Element_Flag_ := 0;
    KEL.typ.nstr Label_;
    KEL.typ.nkdate Last_Event_Date_;
    KEL.typ.nint Last_Record_Id_;
    KEL.typ.nint Max_Deceased_To_Event_Diff_;
    KEL.typ.int No_Lex_Id_ := 0;
    KEL.typ.int No_Lex_Id_Gt22_ := 0;
    KEL.typ.int Other_Customer_Person_Customer_Count_ := 0;
    KEL.typ.int Safe_Flag_ := 0;
    KEL.typ.nkdate Safe_Flag_Last_Date_;
    KEL.typ.int Safe_Flag_Transaction_Count_ := 0;
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
    KEL.typ.nuid U_I_D__1_;
    KEL.typ.ntyp(E_Customer.Typ) _r_Customer__2_;
    KEL.typ.ndataset(E_Internet_Protocol.Source_Customers_Layout) Source_Customers__1_;
    KEL.typ.nstr Ip_Address_;
    KEL.typ.nstr Otto_Ip_Address_Id_;
    KEL.typ.nstr _host_;
    KEL.typ.nstr _alias_;
    KEL.typ.nstr _location_;
    KEL.typ.nstr _ip__address_;
    KEL.typ.nstr _ip__address__date_;
    KEL.typ.nstr _version_;
    KEL.typ.nstr _class_;
    KEL.typ.nstr _subnet__mask_;
    KEL.typ.nstr _reserved_;
    KEL.typ.nstr _isp_;
    KEL.typ.nint _v2__validationipproblems_;
    KEL.typ.nstr _v2__ipstate_;
    KEL.typ.nstr _v2__ipcountry_;
    KEL.typ.nstr _v2__ipcontinent_;
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
    KEL.typ.int Contributor_Safe_Flag__1_ := 0;
    KEL.typ.nint Customer_Id__1_;
    KEL.typ.nkdate Dt_First_Seen__1_;
    KEL.typ.nkdate Dt_Last_Seen__1_;
    KEL.typ.nstr Entity_Context_Uid__1_;
    KEL.typ.int Entity_Type__1_ := 0;
    KEL.typ.int Event_Count__1_ := 0;
    KEL.typ.int Identity_Count_ := 0;
    KEL.typ.int In_Customer_Population__1_ := 0;
    KEL.typ.nint Industry_Type__1_;
    KEL.typ.int Ip_High_Risk_City__1_ := 0;
    KEL.typ.int Ip_Hosted__1_ := 0;
    KEL.typ.int Ip_Not_Us__1_ := 0;
    KEL.typ.int Ip_Tor__1_ := 0;
    KEL.typ.int Ip_Vpn__1_ := 0;
    KEL.typ.int Kr_Event_After_Last_Known_Risk_Count__1_ := 0;
    KEL.typ.int Kr_Event_After_Last_Known_Risk_Flag__1_ := 0;
    KEL.typ.int Kr_Flag__1_ := 0;
    KEL.typ.int Kr_High_Risk_Flag__1_ := 0;
    KEL.typ.int Kr_Ip1000_Flag_ := 0;
    KEL.typ.int Kr_Ip1001_Flag_ := 0;
    KEL.typ.int Kr_Ip1090_Flag_ := 0;
    KEL.typ.int Kr_Ip1091_Flag_ := 0;
    KEL.typ.int Kr_Ip1092_Flag_ := 0;
    KEL.typ.int Kr_Ip1093_Flag_ := 0;
    KEL.typ.int Kr_Ip600_Flag_ := 0;
    KEL.typ.int Kr_Ip601_Flag_ := 0;
    KEL.typ.int Kr_Ip602_Flag_ := 0;
    KEL.typ.int Kr_Ip603_Flag_ := 0;
    KEL.typ.int Kr_Ip604_Flag_ := 0;
    KEL.typ.int Kr_Ip605_Flag_ := 0;
    KEL.typ.int Kr_Ip690_Flag_ := 0;
    KEL.typ.int Kr_Ip691_Flag_ := 0;
    KEL.typ.int Kr_Ip692_Flag_ := 0;
    KEL.typ.int Kr_Ip693_Flag_ := 0;
    KEL.typ.nkdate Kr_Last_Event_Date__1_;
    KEL.typ.int Kr_Low_Risk_Flag__1_ := 0;
    KEL.typ.int Kr_Medium_Risk_Flag__1_ := 0;
    KEL.typ.nstr Label__1_;
    KEL.typ.nkdate Last_Event_Date__1_;
    KEL.typ.nint Last_Record_Id__1_;
    KEL.typ.int Safe_Flag__1_ := 0;
    KEL.typ.nint Source_Customer_Count__1_;
    KEL.typ.int Vl_Event1_All_Count__1_ := 0;
    KEL.typ.int Vl_Event1_Count__1_ := 0;
    KEL.typ.int Vl_Event30_Active_Flag__1_ := 0;
    KEL.typ.int Vl_Event30_All_Active_Flag__1_ := 0;
    KEL.typ.int Vl_Event30_All_Day_Count__1_ := 0;
    KEL.typ.int Vl_Event30_Count__1_ := 0;
    KEL.typ.int Vl_Event365_All_Day_Count__1_ := 0;
    KEL.typ.int Vl_Event365_Count__1_ := 0;
    KEL.typ.int Vl_Event7_Active_Flag__1_ := 0;
    KEL.typ.int Vl_Event7_All_Active_Flag__1_ := 0;
    KEL.typ.int Vl_Event7_All_Count__1_ := 0;
    KEL.typ.int Vl_Event7_Count__1_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  __JC1359552(__ST1278273_Layout __EE1359304, B_Internet_Protocol.__ST27182_Layout __EE1359544) := __EEQP(__EE1359304.Ip_,__EE1359544.UID);
  __ST1278557_Layout __JT1359552(__ST1278273_Layout __l, B_Internet_Protocol.__ST27182_Layout __r) := TRANSFORM
    SELF.U_I_D__1_ := __r.UID;
    SELF._r_Customer__2_ := __r._r_Customer_;
    SELF.Source_Customers__1_ := __r.Source_Customers_;
    SELF.Contributor_Safe_Flag__1_ := __r.Contributor_Safe_Flag_;
    SELF.Customer_Id__1_ := __r.Customer_Id_;
    SELF.Dt_First_Seen__1_ := __r.Dt_First_Seen_;
    SELF.Dt_Last_Seen__1_ := __r.Dt_Last_Seen_;
    SELF.Entity_Context_Uid__1_ := __r.Entity_Context_Uid_;
    SELF.Entity_Type__1_ := __r.Entity_Type_;
    SELF.Event_Count__1_ := __r.Event_Count_;
    SELF.In_Customer_Population__1_ := __r.In_Customer_Population_;
    SELF.Industry_Type__1_ := __r.Industry_Type_;
    SELF.Ip_High_Risk_City__1_ := __r.Ip_High_Risk_City_;
    SELF.Ip_Hosted__1_ := __r.Ip_Hosted_;
    SELF.Ip_Not_Us__1_ := __r.Ip_Not_Us_;
    SELF.Ip_Tor__1_ := __r.Ip_Tor_;
    SELF.Ip_Vpn__1_ := __r.Ip_Vpn_;
    SELF.Kr_Event_After_Last_Known_Risk_Count__1_ := __r.Kr_Event_After_Last_Known_Risk_Count_;
    SELF.Kr_Event_After_Last_Known_Risk_Flag__1_ := __r.Kr_Event_After_Last_Known_Risk_Flag_;
    SELF.Kr_Flag__1_ := __r.Kr_Flag_;
    SELF.Kr_High_Risk_Flag__1_ := __r.Kr_High_Risk_Flag_;
    SELF.Kr_Last_Event_Date__1_ := __r.Kr_Last_Event_Date_;
    SELF.Kr_Low_Risk_Flag__1_ := __r.Kr_Low_Risk_Flag_;
    SELF.Kr_Medium_Risk_Flag__1_ := __r.Kr_Medium_Risk_Flag_;
    SELF.Label__1_ := __r.Label_;
    SELF.Last_Event_Date__1_ := __r.Last_Event_Date_;
    SELF.Last_Record_Id__1_ := __r.Last_Record_Id_;
    SELF.Safe_Flag__1_ := __r.Safe_Flag_;
    SELF.Source_Customer_Count__1_ := __r.Source_Customer_Count_;
    SELF.Vl_Event1_All_Count__1_ := __r.Vl_Event1_All_Count_;
    SELF.Vl_Event1_Count__1_ := __r.Vl_Event1_Count_;
    SELF.Vl_Event30_Active_Flag__1_ := __r.Vl_Event30_Active_Flag_;
    SELF.Vl_Event30_All_Active_Flag__1_ := __r.Vl_Event30_All_Active_Flag_;
    SELF.Vl_Event30_All_Day_Count__1_ := __r.Vl_Event30_All_Day_Count_;
    SELF.Vl_Event30_Count__1_ := __r.Vl_Event30_Count_;
    SELF.Vl_Event365_All_Day_Count__1_ := __r.Vl_Event365_All_Day_Count_;
    SELF.Vl_Event365_Count__1_ := __r.Vl_Event365_Count_;
    SELF.Vl_Event7_Active_Flag__1_ := __r.Vl_Event7_Active_Flag_;
    SELF.Vl_Event7_All_Active_Flag__1_ := __r.Vl_Event7_All_Active_Flag_;
    SELF.Vl_Event7_All_Count__1_ := __r.Vl_Event7_All_Count_;
    SELF.Vl_Event7_Count__1_ := __r.Vl_Event7_Count_;
    SELF := __l;
    SELF := __r;
  END;
  SHARED __EE1359553 := JOIN(__EE1359304,__EE1359544,__JC1359552(LEFT,RIGHT),__JT1359552(LEFT,RIGHT),LEFT OUTER,HASH);
  SHARED __EE1360450 := PROJECT(B_Customer.IDX_Customer_UID_Wrapped,E_Customer.Layout);
  SHARED __ST1279049_Layout := RECORD
    KEL.typ.ntyp(E_Customer.Typ) _r_Customer_;
    KEL.typ.ntyp(E_Person.Typ) Subject_;
    KEL.typ.ntyp(E_Internet_Protocol.Typ) Ip_;
    KEL.typ.ndataset(E_Person_Ip_Address.Event_Dates_Layout) Event_Dates_;
    KEL.typ.nuid UID;
    KEL.typ.ntyp(E_Customer.Typ) _r_Customer__1_;
    KEL.typ.nint Lex_Id_;
    KEL.typ.ndataset(E_Person.Source_Customers_Layout) Source_Customers_;
    KEL.typ.ndataset(E_Person.Reported_Date_Of_Birth_Layout) Reported_Date_Of_Birth_;
    KEL.typ.ndataset(E_Person.Reported_Ssn_Layout) Reported_Ssn_;
    KEL.typ.ndataset(E_Person.Reported_Email_Address_Layout) Reported_Email_Address_;
    KEL.typ.ndataset(E_Person.Full_Name_Layout) Full_Name_;
    KEL.typ.nint _rin__source_;
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
    KEL.typ.nstr _curr__incar__flag_;
    KEL.typ.nint _name__ssn__dob__match_;
    KEL.typ.ndataset(E_Person.Offenses_Layout) Offenses_;
    KEL.typ.ndataset(E_Person.Address_Layout) Address_;
    KEL.typ.int Address_Count_ := 0;
    KEL.typ.int Address_Is_Cmra30_Count_ := 0;
    KEL.typ.int Address_Is_Cmra30_Flag_ := 0;
    KEL.typ.int Address_Is_Of_State30_Flag_ := 0;
    KEL.typ.int Address_Is_Out_Of_State30_Count_ := 0;
    KEL.typ.nint Age_;
    KEL.typ.nint Age_At_Last_Event_;
    KEL.typ.int All_Death_Prior_To_All_Events_ := 0;
    KEL.typ.int All_Deceased_Event_Count_ := 0;
    KEL.typ.nfloat All_Deceased_Event_Percent_;
    KEL.typ.int All_High_Risk_Death_Prior_To_All_Events_ := 0;
    KEL.typ.nint All_Max_Deceased_To_Event_Diff_;
    KEL.typ.int Associated_With_Fraud_Offenses_Flag_ := 0;
    KEL.typ.int Associated_With_Incarcerated_Flag_ := 0;
    KEL.typ.nstr Best_City_;
    KEL.typ.nstr Best_Email_;
    KEL.typ.nstr Best_First_Name_;
    B_Person_1.__NS476519_Layout Best_Full_Name_;
    KEL.typ.nstr Best_Last_Name_;
    KEL.typ.nstr Best_Middle_Name_;
    KEL.typ.nstr Best_Name_Suffix_;
    B_Person_1.__NS476541_Layout Best_Reported_Address_;
    B_Person_1.__NS476561_Layout Best_Reported_Email_;
    B_Person_1.__NS476569_Layout Best_Reported_Ssn_;
    KEL.typ.nstr Best_Ssn_;
    KEL.typ.nstr Best_State_;
    KEL.typ.nstr Best_Street_Address_;
    KEL.typ.nstr Best_Zip_;
    KEL.typ.int Contributor_Safe_Flag_ := 0;
    KEL.typ.int Currently_Incarcerated_Flag_ := 0;
    KEL.typ.nint Customer_Id_;
    KEL.typ.nkdate Date_Of_Birth_;
    KEL.typ.int Death_Prior_To_All_Events_ := 0;
    KEL.typ.int Deceased_ := 0;
    KEL.typ.int Deceased_Dob_Match_ := 0;
    KEL.typ.int Deceased_Event_Count_ := 0;
    KEL.typ.nfloat Deceased_Event_Percent_;
    KEL.typ.int Deceased_Match_ := 0;
    KEL.typ.nstr Deceased_Match_Date_Of_Death_;
    KEL.typ.str Deceased_Match_Description_ := '';
    KEL.typ.int Deceased_Name_Match_ := 0;
    KEL.typ.nkdate Dt_First_Seen_;
    KEL.typ.nkdate Dt_Last_Seen_;
    KEL.typ.nunk Entity_Context_Uid_;
    KEL.typ.int Entity_Type_ := 0;
    KEL.typ.int Event_Count_ := 0;
    KEL.typ.int Fraud_Offense_Count_ := 0;
    KEL.typ.int Fraud_Offenses_Flag_ := 0;
    KEL.typ.int High_Risk_Death_Prior_To_All_Events_ := 0;
    KEL.typ.nint Id_Ssn_Identity_Count_Max_;
    KEL.typ.int In_Customer_Population_ := 0;
    KEL.typ.nint Industry_Type_;
    KEL.typ.int Ip_High_Risk_City_ := 0;
    KEL.typ.int Ip_Hosted_ := 0;
    KEL.typ.int Ip_Not_Us_ := 0;
    KEL.typ.int Ip_Tor_ := 0;
    KEL.typ.int Ip_Vpn_ := 0;
    KEL.typ.int Is_Minor_ := 0;
    KEL.typ.int Kr_Event_After_Known_Risk_Count_ := 0;
    KEL.typ.int Kr_Event_After_Known_Risk_Flag_ := 0;
    KEL.typ.int Kr_Event_After_Last_Known_Risk_Count_ := 0;
    KEL.typ.int Kr_Event_After_Last_Known_Risk_Flag_ := 0;
    KEL.typ.int Kr_Flag_ := 0;
    KEL.typ.int Kr_Has_Known_Risk_Element_Count_ := 0;
    KEL.typ.nint Kr_Has_Known_Risk_Element_Flag_;
    KEL.typ.int Kr_High_Risk_Flag_ := 0;
    KEL.typ.int Kr_High_Risk_Routing_ := 0;
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
    KEL.typ.int Kr_Id14900_Flag_ := 0;
    KEL.typ.int Kr_Id14901_Flag_ := 0;
    KEL.typ.int Kr_Id14902_Flag_ := 0;
    KEL.typ.int Kr_Id14903_Flag_ := 0;
    KEL.typ.int Kr_Id2025_Flag_ := 0;
    KEL.typ.nkdate Kr_Last_Element_Event_Date_;
    KEL.typ.nkdate Kr_Last_Event_Date_;
    KEL.typ.int Kr_Low_Risk_Flag_ := 0;
    KEL.typ.int Kr_Medium_Risk_Flag_ := 0;
    KEL.typ.int Kr_Not_Known_Risk_Has_Known_Risk_Element_Flag_ := 0;
    KEL.typ.nstr Label_;
    KEL.typ.nkdate Last_Event_Date_;
    KEL.typ.nint Last_Record_Id_;
    KEL.typ.nint Max_Deceased_To_Event_Diff_;
    KEL.typ.int No_Lex_Id_ := 0;
    KEL.typ.int No_Lex_Id_Gt22_ := 0;
    KEL.typ.int Other_Customer_Person_Customer_Count_ := 0;
    KEL.typ.int Safe_Flag_ := 0;
    KEL.typ.nkdate Safe_Flag_Last_Date_;
    KEL.typ.int Safe_Flag_Transaction_Count_ := 0;
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
    KEL.typ.nuid U_I_D__1_;
    KEL.typ.ntyp(E_Customer.Typ) _r_Customer__2_;
    KEL.typ.ndataset(E_Internet_Protocol.Source_Customers_Layout) Source_Customers__1_;
    KEL.typ.nstr Ip_Address_;
    KEL.typ.nstr Otto_Ip_Address_Id_;
    KEL.typ.nstr _host_;
    KEL.typ.nstr _alias_;
    KEL.typ.nstr _location_;
    KEL.typ.nstr _ip__address_;
    KEL.typ.nstr _ip__address__date_;
    KEL.typ.nstr _version_;
    KEL.typ.nstr _class_;
    KEL.typ.nstr _subnet__mask_;
    KEL.typ.nstr _reserved_;
    KEL.typ.nstr _isp_;
    KEL.typ.nint _v2__validationipproblems_;
    KEL.typ.nstr _v2__ipstate_;
    KEL.typ.nstr _v2__ipcountry_;
    KEL.typ.nstr _v2__ipcontinent_;
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
    KEL.typ.int Contributor_Safe_Flag__1_ := 0;
    KEL.typ.nint Customer_Id__1_;
    KEL.typ.nkdate Dt_First_Seen__1_;
    KEL.typ.nkdate Dt_Last_Seen__1_;
    KEL.typ.nstr Entity_Context_Uid__1_;
    KEL.typ.int Entity_Type__1_ := 0;
    KEL.typ.int Event_Count__1_ := 0;
    KEL.typ.int Identity_Count_ := 0;
    KEL.typ.int In_Customer_Population__1_ := 0;
    KEL.typ.nint Industry_Type__1_;
    KEL.typ.int Ip_High_Risk_City__1_ := 0;
    KEL.typ.int Ip_Hosted__1_ := 0;
    KEL.typ.int Ip_Not_Us__1_ := 0;
    KEL.typ.int Ip_Tor__1_ := 0;
    KEL.typ.int Ip_Vpn__1_ := 0;
    KEL.typ.int Kr_Event_After_Last_Known_Risk_Count__1_ := 0;
    KEL.typ.int Kr_Event_After_Last_Known_Risk_Flag__1_ := 0;
    KEL.typ.int Kr_Flag__1_ := 0;
    KEL.typ.int Kr_High_Risk_Flag__1_ := 0;
    KEL.typ.int Kr_Ip1000_Flag_ := 0;
    KEL.typ.int Kr_Ip1001_Flag_ := 0;
    KEL.typ.int Kr_Ip1090_Flag_ := 0;
    KEL.typ.int Kr_Ip1091_Flag_ := 0;
    KEL.typ.int Kr_Ip1092_Flag_ := 0;
    KEL.typ.int Kr_Ip1093_Flag_ := 0;
    KEL.typ.int Kr_Ip600_Flag_ := 0;
    KEL.typ.int Kr_Ip601_Flag_ := 0;
    KEL.typ.int Kr_Ip602_Flag_ := 0;
    KEL.typ.int Kr_Ip603_Flag_ := 0;
    KEL.typ.int Kr_Ip604_Flag_ := 0;
    KEL.typ.int Kr_Ip605_Flag_ := 0;
    KEL.typ.int Kr_Ip690_Flag_ := 0;
    KEL.typ.int Kr_Ip691_Flag_ := 0;
    KEL.typ.int Kr_Ip692_Flag_ := 0;
    KEL.typ.int Kr_Ip693_Flag_ := 0;
    KEL.typ.nkdate Kr_Last_Event_Date__1_;
    KEL.typ.int Kr_Low_Risk_Flag__1_ := 0;
    KEL.typ.int Kr_Medium_Risk_Flag__1_ := 0;
    KEL.typ.nstr Label__1_;
    KEL.typ.nkdate Last_Event_Date__1_;
    KEL.typ.nint Last_Record_Id__1_;
    KEL.typ.int Safe_Flag__1_ := 0;
    KEL.typ.nint Source_Customer_Count__1_;
    KEL.typ.int Vl_Event1_All_Count__1_ := 0;
    KEL.typ.int Vl_Event1_Count__1_ := 0;
    KEL.typ.int Vl_Event30_Active_Flag__1_ := 0;
    KEL.typ.int Vl_Event30_All_Active_Flag__1_ := 0;
    KEL.typ.int Vl_Event30_All_Day_Count__1_ := 0;
    KEL.typ.int Vl_Event30_Count__1_ := 0;
    KEL.typ.int Vl_Event365_All_Day_Count__1_ := 0;
    KEL.typ.int Vl_Event365_Count__1_ := 0;
    KEL.typ.int Vl_Event7_Active_Flag__1_ := 0;
    KEL.typ.int Vl_Event7_All_Active_Flag__1_ := 0;
    KEL.typ.int Vl_Event7_All_Count__1_ := 0;
    KEL.typ.int Vl_Event7_Count__1_ := 0;
    KEL.typ.nuid U_I_D__2_;
    KEL.typ.nint Customer_Id__2_;
    KEL.typ.nint Industry_Type__2_;
    KEL.typ.ndataset(E_Customer.States_Layout) States_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  __JC1360464(__ST1278557_Layout __EE1359553, E_Customer.Layout __EE1360450) := __EEQP(__EE1359553._r_Customer_,__EE1360450.UID);
  __ST1279049_Layout __JT1360464(__ST1278557_Layout __l, E_Customer.Layout __r) := TRANSFORM
    SELF.U_I_D__2_ := __r.UID;
    SELF.Customer_Id__2_ := __r.Customer_Id_;
    SELF.Industry_Type__2_ := __r.Industry_Type_;
    SELF := __l;
    SELF := __r;
  END;
  SHARED __EE1360856 := JOIN(__EE1359553,__EE1360450,__JC1360464(LEFT,RIGHT),__JT1360464(LEFT,RIGHT),LEFT OUTER,HASH);
  SHARED __ST1278178_Layout := RECORD
    KEL.typ.ntyp(E_Customer.Typ) Source_Customer_;
    KEL.typ.nint Customer_Id_;
    KEL.typ.nint Industry_Type_;
    KEL.typ.nstr Tree_Uid_;
    KEL.typ.nunk Entity_Context_Uid_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  SHARED __ST1278178_Layout __ND1361239__Project(__ST1279049_Layout __PP1360857) := TRANSFORM
    SELF.Source_Customer_ := __PP1360857._r_Customer_;
    SELF.Customer_Id_ := __PP1360857.Customer_Id__2_;
    SELF.Industry_Type_ := __PP1360857.Industry_Type__2_;
    SELF.Tree_Uid_ := __PP1360857.Entity_Context_Uid__1_;
    SELF := __PP1360857;
  END;
  EXPORT Res0 := __UNWRAP(PROJECT(TABLE(PROJECT(__EE1360856,__ND1361239__Project(LEFT)),{KEL.typ.int __RecordCount := SUM(GROUP,__RecordCount),KEL.typ.epoch Date_First_Seen_ := KEL.era.SimpleRoll(GROUP,Date_First_Seen_,MIN,TRUE),KEL.typ.epoch Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Date_Last_Seen_,MAX,FALSE),Source_Customer_,Customer_Id_,Industry_Type_,Tree_Uid_,Entity_Context_Uid_},Source_Customer_,Customer_Id_,Industry_Type_,Tree_Uid_,Entity_Context_Uid_,MERGE),__ST1278178_Layout));
END;
