﻿//HPCC Systems KEL Compiler Version 0.11.6-2
IMPORT KEL011 AS KEL;
IMPORT B_Event_6,E_Address,E_Bank,E_Bank_Account,E_Customer,E_Drivers_License,E_Email,E_Event,E_Internet_Protocol,E_Internet_Protocol_Event,E_Person,E_Phone,E_Social_Security_Number FROM FraudgovKEL;
IMPORT * FROM KEL011.Null;
EXPORT B_Internet_Protocol_5 := MODULE
  SHARED VIRTUAL TYPEOF(B_Event_6.__ENH_Event_6) __ENH_Event_6 := B_Event_6.__ENH_Event_6;
  SHARED VIRTUAL TYPEOF(E_Internet_Protocol.__Result) __E_Internet_Protocol := E_Internet_Protocol.__Result;
  SHARED VIRTUAL TYPEOF(E_Internet_Protocol_Event.__Result) __E_Internet_Protocol_Event := E_Internet_Protocol_Event.__Result;
  SHARED __EE166986 := __E_Internet_Protocol;
  SHARED __EE167207 := __E_Internet_Protocol_Event;
  SHARED __EE168899 := __EE167207(__NN(__EE167207.Ip_) AND __NN(__EE167207.Transaction_));
  SHARED __EE167209 := __ENH_Event_6;
  SHARED __EE167421 := __EE167209(__EE167209.T___In_Agency_Flag_ = 1 AND __EE167209.T18___Ip_Addr_Is_Kr_Flag_ = 1);
  __JC168917(E_Internet_Protocol_Event.Layout __EE168899, B_Event_6.__ST100342_Layout __EE167421) := __EEQP(__EE168899.Transaction_,__EE167421.UID);
  SHARED __EE168918 := JOIN(__EE168899,__EE167421,__JC168917(LEFT,RIGHT),TRANSFORM(E_Internet_Protocol_Event.Layout,SELF:=LEFT),SMART,KEEP(1));
  SHARED __ST167280_Layout := RECORD
    KEL.typ.ntyp(E_Internet_Protocol.Typ) UID;
    KEL.typ.ntyp(E_Customer.Typ) _r_Customer_;
    KEL.typ.ntyp(E_Internet_Protocol.Typ) Ip_;
    KEL.typ.nkdate Event_Date_;
    KEL.typ.ntyp(E_Event.Typ) Transaction_;
    KEL.typ.ntyp(E_Event.Typ) U_I_D__1_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
  END;
  SHARED __ST167280_Layout __ND168928__Project(E_Internet_Protocol_Event.Layout __PP168919) := TRANSFORM
    SELF.UID := __PP168919.Ip_;
    SELF.U_I_D__1_ := __PP168919.Transaction_;
    SELF := __PP168919;
  END;
  SHARED __EE168953 := PROJECT(__EE168918,__ND168928__Project(LEFT));
  SHARED __ST167306_Layout := RECORD
    KEL.typ.int C_O_U_N_T___Exp1_ := 0;
    KEL.typ.ntyp(E_Internet_Protocol.Typ) UID;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
  END;
  SHARED __EE168966 := PROJECT(__CLEANANDDO(__EE168953,TABLE(__EE168953,{KEL.typ.int C_O_U_N_T___Exp1_ := COUNT(GROUP),UID},UID,MERGE)),__ST167306_Layout);
  SHARED __ST167745_Layout := RECORD
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
    KEL.typ.int C_O_U_N_T___Exp1_ := 0;
    KEL.typ.ntyp(E_Internet_Protocol.Typ) U_I_D__1_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  __JC168972(E_Internet_Protocol.Layout __EE166986, __ST167306_Layout __EE168966) := __EEQP(__EE166986.UID,__EE168966.UID);
  __ST167745_Layout __JT168972(E_Internet_Protocol.Layout __l, __ST167306_Layout __r) := TRANSFORM
    SELF.U_I_D__1_ := __r.UID;
    SELF := __l;
    SELF := __r;
  END;
  SHARED __EE168973 := JOIN(__EE166986,__EE168966,__JC168972(LEFT,RIGHT),__JT168972(LEFT,RIGHT),LEFT OUTER,SMART);
  EXPORT __ST98360_Layout := RECORD
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
    KEL.typ.int Aot_Ip_Addr_Kr_Act_Cnt_Ev_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  SHARED __ST98360_Layout __ND169058__Project(__ST167745_Layout __PP168974) := TRANSFORM
    SELF.Aot_Ip_Addr_Kr_Act_Cnt_Ev_ := MIN(__PP168974.C_O_U_N_T___Exp1_,9999);
    SELF := __PP168974;
  END;
  EXPORT __ENH_Internet_Protocol_5 := PROJECT(__EE168973,__ND169058__Project(LEFT)) : PERSIST('~temp::KEL::FraudgovKEL::Internet_Protocol::Annotated_5',EXPIRE(7));
END;
