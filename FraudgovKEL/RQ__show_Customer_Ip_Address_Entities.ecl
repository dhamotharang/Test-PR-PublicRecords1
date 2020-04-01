﻿//HPCC Systems KEL Compiler Version 0.11.6-2
IMPORT KEL011 AS KEL;
IMPORT B_Customer,B_Customer_4,B_Internet_Protocol,E_Customer,E_Internet_Protocol FROM FraudgovKEL;
IMPORT * FROM KEL011.Null;
EXPORT RQ__show_Customer_Ip_Address_Entities := MODULE
  SHARED __EE1428017 := B_Internet_Protocol.IDX_Internet_Protocol_UID_Wrapped;
  SHARED __EE1428260 := PROJECT(B_Customer.IDX_Customer_UID_Wrapped,E_Customer.Layout);
  SHARED __ST1345871_Layout := RECORD
    KEL.typ.nuid UID;
    KEL.typ.ntyp(E_Customer.Typ) _r_Customer_;
    KEL.typ.ndataset(E_Internet_Protocol.Source_Customers_Layout) Source_Customers_;
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
    KEL.typ.int Contributor_Safe_Flag_ := 0;
    KEL.typ.nint Customer_Id_;
    KEL.typ.nkdate Dt_First_Seen_;
    KEL.typ.nkdate Dt_Last_Seen_;
    KEL.typ.nstr Entity_Context_Uid_;
    KEL.typ.int Entity_Type_ := 0;
    KEL.typ.int Event_Count_ := 0;
    KEL.typ.int Identity_Count_ := 0;
    KEL.typ.int In_Customer_Population_ := 0;
    KEL.typ.nint Industry_Type_;
    KEL.typ.int Ip_High_Risk_City_ := 0;
    KEL.typ.int Ip_Hosted_ := 0;
    KEL.typ.int Ip_Not_Us_ := 0;
    KEL.typ.int Ip_Tor_ := 0;
    KEL.typ.int Ip_Vpn_ := 0;
    KEL.typ.int Kr_Event_After_Last_Known_Risk_Count_ := 0;
    KEL.typ.int Kr_Event_After_Last_Known_Risk_Flag_ := 0;
    KEL.typ.int Kr_Flag_ := 0;
    KEL.typ.int Kr_High_Risk_Flag_ := 0;
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
    KEL.typ.nkdate Kr_Last_Event_Date_;
    KEL.typ.int Kr_Low_Risk_Flag_ := 0;
    KEL.typ.int Kr_Medium_Risk_Flag_ := 0;
    KEL.typ.nstr Label_;
    KEL.typ.nkdate Last_Event_Date_;
    KEL.typ.nint Last_Record_Id_;
    KEL.typ.int Safe_Flag_ := 0;
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
    KEL.typ.nint Customer_Id__1_;
    KEL.typ.nint Industry_Type__1_;
    KEL.typ.ndataset(E_Customer.States_Layout) States_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  __JC1428274(B_Internet_Protocol.__ST28622_Layout __EE1428017, E_Customer.Layout __EE1428260) := __EEQP(__EE1428017._r_Customer_,__EE1428260.UID);
  __ST1345871_Layout __JT1428274(B_Internet_Protocol.__ST28622_Layout __l, E_Customer.Layout __r) := TRANSFORM
    SELF.U_I_D__1_ := __r.UID;
    SELF.Customer_Id__1_ := __r.Customer_Id_;
    SELF.Industry_Type__1_ := __r.Industry_Type_;
    SELF := __l;
    SELF := __r;
  END;
  SHARED __EE1428462 := JOIN(__EE1428017,__EE1428260,__JC1428274(LEFT,RIGHT),__JT1428274(LEFT,RIGHT),LEFT OUTER,HASH);
  SHARED __ST1345731_Layout := RECORD
    KEL.typ.ntyp(E_Customer.Typ) Source_Customer_;
    KEL.typ.nint Customer_Id_;
    KEL.typ.nint Industry_Type_;
    KEL.typ.nstr Entity_Context_Uid_;
    KEL.typ.nstr Label_;
    KEL.typ.int Entity_Type_ := 0;
    KEL.typ.int Person_Count_ := 0;
    KEL.typ.int In_Customer_Population_ := 0;
    KEL.typ.int Contributor_Safe_Flag_ := 0;
    KEL.typ.int Safe_Flag_ := 0;
    KEL.typ.nkdate Dt_First_Seen_;
    KEL.typ.nkdate Dt_Last_Seen_;
    KEL.typ.int Kr_High_Risk_Flag_ := 0;
    KEL.typ.int Kr_Medium_Risk_Flag_ := 0;
    KEL.typ.int Kr_Low_Risk_Flag_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  SHARED __ST1345731_Layout __ND1428611__Project(__ST1345871_Layout __PP1428463) := TRANSFORM
    SELF.Source_Customer_ := __PP1428463._r_Customer_;
    SELF.Customer_Id_ := __PP1428463.Customer_Id__1_;
    SELF.Industry_Type_ := __PP1428463.Industry_Type__1_;
    SELF.Person_Count_ := __PP1428463.Identity_Count_;
    SELF := __PP1428463;
  END;
  EXPORT Res0 := __UNWRAP(PROJECT(TABLE(PROJECT(__EE1428462,__ND1428611__Project(LEFT)),{KEL.typ.int __RecordCount := SUM(GROUP,__RecordCount),KEL.typ.epoch Date_First_Seen_ := KEL.era.SimpleRoll(GROUP,Date_First_Seen_,MIN,TRUE),KEL.typ.epoch Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Date_Last_Seen_,MAX,FALSE),Source_Customer_,Customer_Id_,Industry_Type_,Entity_Context_Uid_,Label_,Entity_Type_,Person_Count_,In_Customer_Population_,Contributor_Safe_Flag_,Safe_Flag_,Dt_First_Seen_,Dt_Last_Seen_,Kr_High_Risk_Flag_,Kr_Medium_Risk_Flag_,Kr_Low_Risk_Flag_},Source_Customer_,Customer_Id_,Industry_Type_,Entity_Context_Uid_,Label_,Entity_Type_,Person_Count_,In_Customer_Population_,Contributor_Safe_Flag_,Safe_Flag_,Dt_First_Seen_,Dt_Last_Seen_,Kr_High_Risk_Flag_,Kr_Medium_Risk_Flag_,Kr_Low_Risk_Flag_,MERGE),__ST1345731_Layout));
END;
