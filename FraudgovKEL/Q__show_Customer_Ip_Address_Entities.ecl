﻿//HPCC Systems KEL Compiler Version 0.11.6-2
IMPORT KEL011 AS KEL;
IMPORT B_Internet_Protocol,E_Customer,E_Internet_Protocol FROM FraudgovKEL;
IMPORT * FROM KEL011.Null;
EXPORT Q__show_Customer_Ip_Address_Entities := MODULE
  SHARED TYPEOF(E_Customer.__Result) __E_Customer := E_Customer.__Result;
  SHARED TYPEOF(B_Internet_Protocol.__ENH_Internet_Protocol) __ENH_Internet_Protocol := B_Internet_Protocol.__ENH_Internet_Protocol;
  SHARED __EE4010575 := __ENH_Internet_Protocol;
  SHARED __EE4010523 := __E_Customer;
  SHARED __ST4010600_Layout := RECORD
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
    KEL.typ.int Aot_Add_Act_Cnt30_D_ := 0;
    KEL.typ.int Aot_Add_Act_Cnt_Ev_ := 0;
    KEL.typ.int Aot_Id_Act_Cnt30_D_ := 0;
    KEL.typ.int Aot_Id_Act_Cnt_Ev_ := 0;
    KEL.typ.int Aot_Id_Curr_Prof_Usng_Ip_Cnt_Ev_ := 0;
    KEL.typ.int Aot_Id_Hist_Prof_Usng_Ip_Cnt_Ev_ := 0;
    KEL.typ.int Aot_Id_Usng_Ip_Addr_Cnt_Ev_ := 0;
    KEL.typ.int Aot_Ip_Addr_Kr_Act_Cnt_Ev_ := 0;
    KEL.typ.nkdate Aot_Ip_Addr_Kr_Act_New_Dt_Ev_;
    KEL.typ.nkdate Aot_Ip_Addr_Kr_Act_Old_Dt_Ev_;
    KEL.typ.int Aot_Ip_Addr_Kr_Act_Shrd_Cnt_Ev_ := 0;
    KEL.typ.nkdate Aot_Ip_Addr_Kr_Act_Shrd_New_Dt_Ev_;
    KEL.typ.nkdate Aot_Ip_Addr_Kr_Act_Shrd_Old_Dt_Ev_;
    KEL.typ.int Aot_Ip_Addr_Safe_Act_Cnt_Ev_ := 0;
    KEL.typ.nkdate Aot_Ip_Addr_Safe_Act_New_Dt_Ev_;
    KEL.typ.nkdate Aot_Ip_Addr_Safe_Act_Old_Dt_Ev_;
    KEL.typ.int Aot_Ip_New_Kr_Aft_Add_Act_Cnt_Ev_ := 0;
    KEL.typ.int Aot_Ip_New_Kr_Aft_Id_Act_Cnt_Ev_ := 0;
    KEL.typ.int Aot_Ip_New_Kr_Aft_Non_St_Act_Cnt_Ev_ := 0;
    KEL.typ.int Aot_Non_St_Act_Cnt30_D_ := 0;
    KEL.typ.int Aot_Non_St_Act_Cnt_Ev_ := 0;
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
  __JC4010853(B_Internet_Protocol.__ST63642_Layout __EE4010575, E_Customer.Layout __EE4010523) := __EEQP(__EE4010575._r_Customer_,__EE4010523.UID);
  __ST4010600_Layout __JT4010853(B_Internet_Protocol.__ST63642_Layout __l, E_Customer.Layout __r) := TRANSFORM
    SELF.U_I_D__1_ := __r.UID;
    SELF.Customer_Id__1_ := __r.Customer_Id_;
    SELF.Industry_Type__1_ := __r.Industry_Type_;
    SELF := __l;
    SELF := __r;
  END;
  SHARED __EE4010854 := JOIN(__EE4010575,__EE4010523,__JC4010853(LEFT,RIGHT),__JT4010853(LEFT,RIGHT),LEFT OUTER,HASH);
  SHARED __ST44040_Layout := RECORD
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
  SHARED __ST44040_Layout __ND4010835__Project(__ST4010600_Layout __PP4010834) := TRANSFORM
    SELF.Source_Customer_ := __PP4010834._r_Customer_;
    SELF.Customer_Id_ := __PP4010834.Customer_Id__1_;
    SELF.Industry_Type_ := __PP4010834.Industry_Type__1_;
    SELF.Person_Count_ := __PP4010834.Identity_Count_;
    SELF := __PP4010834;
  END;
  EXPORT Res0 := __UNWRAP(PROJECT(TABLE(PROJECT(__EE4010854,__ND4010835__Project(LEFT)),{KEL.typ.int __RecordCount := SUM(GROUP,__RecordCount),KEL.typ.epoch Date_First_Seen_ := KEL.era.SimpleRoll(GROUP,Date_First_Seen_,MIN,TRUE),KEL.typ.epoch Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Date_Last_Seen_,MAX,FALSE),Source_Customer_,Customer_Id_,Industry_Type_,Entity_Context_Uid_,Label_,Entity_Type_,Person_Count_,In_Customer_Population_,Contributor_Safe_Flag_,Safe_Flag_,Dt_First_Seen_,Dt_Last_Seen_,Kr_High_Risk_Flag_,Kr_Medium_Risk_Flag_,Kr_Low_Risk_Flag_},Source_Customer_,Customer_Id_,Industry_Type_,Entity_Context_Uid_,Label_,Entity_Type_,Person_Count_,In_Customer_Population_,Contributor_Safe_Flag_,Safe_Flag_,Dt_First_Seen_,Dt_Last_Seen_,Kr_High_Risk_Flag_,Kr_Medium_Risk_Flag_,Kr_Low_Risk_Flag_,MERGE),__ST44040_Layout));
END;
