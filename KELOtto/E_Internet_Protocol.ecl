//HPCC Systems KEL Compiler Version 0.11.0
IMPORT KEL011 AS KEL;
IMPORT KELOtto;
IMPORT E_Customer FROM KELOtto;
IMPORT * FROM KEL011.Null;
EXPORT E_Internet_Protocol := MODULE
  EXPORT Typ := KEL.typ.uid;
  EXPORT InLayout := RECORD
    KEL.typ.nuid UID;
    KEL.typ.ntyp(E_Customer.Typ) _r_Customer_;
    KEL.typ.ntyp(E_Customer.Typ) _r_Source_Customer_;
    KEL.typ.nstr Ip_Address_;
    KEL.typ.nint Otto_Ip_Address_Id_;
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
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
  END;
  SHARED VIRTUAL __SourceFilter(DATASET(InLayout) __ds) := __ds;
  SHARED VIRTUAL __GroupedFilter(GROUPED DATASET(InLayout) __ds) := __ds;
  SHARED __Mapping := 'UID(UID),associatedcustomerfileinfo(_r_Customer_:0),sourcecustomerfileinfo(_r_Source_Customer_:0),ip_address(Ip_Address_:\'\'|_ip__address_:\'\'),ottoipaddressid(Otto_Ip_Address_Id_:0),host(_host_:\'\'),alias(_alias_:\'\'),location(_location_:\'\'),ip_address_date(_ip__address__date_:\'\'),version(_version_:\'\'),class(_class_:\'\'),subnet_mask(_subnet__mask_:\'\'),reserved(_reserved_:\'\'),isp(_isp_:\'\'),v2_validationipproblems(_v2__validationipproblems_:0),v2_ipstate(_v2__ipstate_:\'\'),v2_ipcountry(_v2__ipcountry_:\'\'),v2_ipcontinent(_v2__ipcontinent_:\'\'),datefirstseen(Date_First_Seen_:EPOCH),datelastseen(Date_Last_Seen_:EPOCH)';
  SHARED __Trimmed := RECORD, MAXLENGTH(5000)
    STRING KeyVal;
  END;
  SHARED __d0_KELfiltered := KELOtto.fraudgovshared((UNSIGNED)did <> 0 AND AssociatedCustomerFileInfo > 0 AND TRIM(ip_address) != '' AND ip_address NOT IN ['0.0.0.0','10.121.146.247','10.121.146.90','10.121.146.15','10.121.146.159','10.121.146.249','10.121.146.34','10.121.146.231','10.121.146.235','10.121.146.232']);
  SHARED __d0_Trim := PROJECT(__d0_KELfiltered,TRANSFORM(__Trimmed,SELF.KeyVal:=TRIM((STRING)LEFT.AssociatedCustomerFileInfo) + '|' + TRIM((STRING)LEFT.ip_address)));
  EXPORT __All_Trim := __d0_Trim;
  SHARED __TabRec := RECORD, MAXLENGTH(5000)
    __All_Trim.KeyVal;
    UNSIGNED4 Cnt := COUNT(GROUP);
    KEL.typ.uid UID := 0;
  END;
  EXPORT NullKeyVal := TRIM((STRING)'') + '|' + TRIM((STRING)'');
  SHARED __Table := TABLE(__All_Trim(KeyVal <> NullKeyVal),__TabRec,KeyVal,MERGE);
  SHARED NullLookupRec := DATASET([{NullKeyVal,1,0}],__TabRec);
  EXPORT Lookup := NullLookupRec + PROJECT(__Table,TRANSFORM(__TabRec,SELF.UID:=COUNTER,SELF:=LEFT)) : PERSIST('~temp::KEL::KELOtto::Internet_Protocol::UidLookup',EXPIRE(30));
  EXPORT UID_IdToText := INDEX(Lookup,{UID},{Lookup},'~temp::KEL::IDtoT::KELOtto::Internet_Protocol');
  EXPORT UID_TextToId := INDEX(Lookup,{ht:=HASH32(KeyVal)},{Lookup},'~temp::KEL::TtoID::KELOtto::Internet_Protocol');
  EXPORT BuildAll := PARALLEL(BUILDINDEX(UID_IdToText,OVERWRITE),BUILDINDEX(UID_TextToId,OVERWRITE));
  EXPORT GetText(KEL.typ.uid i) := UID_IdToText(UID=i)[1];
  EXPORT GetId(STRING s) := UID_TextToId(ht=HASH32(s),KeyVal=s)[1];
  SHARED __Mapping0 := 'UID(UID),associatedcustomerfileinfo(_r_Customer_:0),sourcecustomerfileinfo(_r_Source_Customer_:0),ip_address(Ip_Address_:\'\'|_ip__address_:\'\'),ottoipaddressid(Otto_Ip_Address_Id_:0),host(_host_:\'\'),alias(_alias_:\'\'),location(_location_:\'\'),ip_address_date(_ip__address__date_:\'\'),version(_version_:\'\'),class(_class_:\'\'),subnet_mask(_subnet__mask_:\'\'),reserved(_reserved_:\'\'),isp(_isp_:\'\'),v2_validationipproblems(_v2__validationipproblems_:0),v2_ipstate(_v2__ipstate_:\'\'),v2_ipcountry(_v2__ipcountry_:\'\'),v2_ipcontinent(_v2__ipcontinent_:\'\'),datefirstseen(Date_First_Seen_:EPOCH),datelastseen(Date_Last_Seen_:EPOCH)';
  SHARED __d0_Out := RECORD
    RECORDOF(KELOtto.fraudgovshared);
    KEL.typ.uid UID := 0;
  END;
  SHARED __d0_UID_Mapped := JOIN(__d0_KELfiltered,Lookup,TRIM((STRING)LEFT.AssociatedCustomerFileInfo) + '|' + TRIM((STRING)LEFT.ip_address) = RIGHT.KeyVal,TRANSFORM(__d0_Out,SELF.UID:=RIGHT.UID,SELF:=LEFT),HASH);
  EXPORT KELOtto_fraudgovshared_Invalid := __d0_UID_Mapped(UID = 0);
  SHARED __d0_Prefiltered := __d0_UID_Mapped(UID <> 0);
  SHARED __d0 := __SourceFilter(KEL.FromFlat.Convert(__d0_Prefiltered,InLayout,__Mapping0));
  EXPORT InData := __d0;
  EXPORT Source_Customers_Layout := RECORD
    KEL.typ.ntyp(E_Customer.Typ) _r_Source_Customer_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  EXPORT Layout := RECORD
    KEL.typ.nuid UID;
    KEL.typ.ntyp(E_Customer.Typ) _r_Customer_;
    KEL.typ.ndataset(Source_Customers_Layout) Source_Customers_;
    KEL.typ.nstr Ip_Address_;
    KEL.typ.nint Otto_Ip_Address_Id_;
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
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  EXPORT __PostFilter := __GroupedFilter(GROUP(DISTRIBUTE(InData,HASH(UID)),UID,LOCAL,ALL));
  Internet_Protocol_Group := __PostFilter;
  Layout Internet_Protocol__Rollup(InLayout __r, DATASET(InLayout) __recs) := TRANSFORM
    SELF._r_Customer_ := KEL.Intake.SingleValue(__recs,_r_Customer_);
    SELF.Source_Customers_ := __CN(PROJECT(TABLE(__recs,{KEL.typ.int __RecordCount := COUNT(GROUP),KEL.typ.epoch Date_First_Seen_ := KEL.era.SimpleRoll(GROUP,Date_First_Seen_,MIN,TRUE),KEL.typ.epoch Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Date_Last_Seen_,MAX,FALSE),_r_Source_Customer_},_r_Source_Customer_),Source_Customers_Layout)(__NN(_r_Source_Customer_)));
    SELF.Ip_Address_ := KEL.Intake.SingleValue(__recs,Ip_Address_);
    SELF.Otto_Ip_Address_Id_ := KEL.Intake.SingleValue(__recs,Otto_Ip_Address_Id_);
    SELF._host_ := KEL.Intake.SingleValue(__recs,_host_);
    SELF._alias_ := KEL.Intake.SingleValue(__recs,_alias_);
    SELF._location_ := KEL.Intake.SingleValue(__recs,_location_);
    SELF._ip__address_ := KEL.Intake.SingleValue(__recs,_ip__address_);
    SELF._ip__address__date_ := KEL.Intake.SingleValue(__recs,_ip__address__date_);
    SELF._version_ := KEL.Intake.SingleValue(__recs,_version_);
    SELF._class_ := KEL.Intake.SingleValue(__recs,_class_);
    SELF._subnet__mask_ := KEL.Intake.SingleValue(__recs,_subnet__mask_);
    SELF._reserved_ := KEL.Intake.SingleValue(__recs,_reserved_);
    SELF._isp_ := KEL.Intake.SingleValue(__recs,_isp_);
    SELF._v2__validationipproblems_ := KEL.Intake.SingleValue(__recs,_v2__validationipproblems_);
    SELF._v2__ipstate_ := KEL.Intake.SingleValue(__recs,_v2__ipstate_);
    SELF._v2__ipcountry_ := KEL.Intake.SingleValue(__recs,_v2__ipcountry_);
    SELF._v2__ipcontinent_ := KEL.Intake.SingleValue(__recs,_v2__ipcontinent_);
    SELF.__RecordCount := COUNT(__recs);
    SELF.Date_First_Seen_ := KEL.era.SimpleRoll(__recs,Date_First_Seen_,MIN,TRUE);
    SELF.Date_Last_Seen_ := KEL.era.SimpleRoll(__recs,Date_Last_Seen_,MAX,FALSE);
    SELF := __r;
  END;
  Layout Internet_Protocol__Single_Rollup(InLayout __r) := TRANSFORM
    SELF.Source_Customers_ := __CN(PROJECT(DATASET(__r),TRANSFORM(Source_Customers_Layout,SELF.__RecordCount:=1;,SELF:=LEFT))(__NN(_r_Source_Customer_)));
    SELF.__RecordCount := 1;
    SELF := __r;
  END;
  EXPORT __PreResult := ROLLUP(HAVING(Internet_Protocol_Group,COUNT(ROWS(LEFT))=1),GROUP,Internet_Protocol__Single_Rollup(LEFT)) + ROLLUP(HAVING(Internet_Protocol_Group,COUNT(ROWS(LEFT))>1),GROUP,Internet_Protocol__Rollup(LEFT, ROWS(LEFT)));
  EXPORT __Result := __CLEARFLAGS(__PreResult) : PERSIST('~temp::KEL::KELOtto::Internet_Protocol::Result',EXPIRE(30));
  EXPORT Result := __UNWRAP(__Result);
  EXPORT _r_Customer__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,_r_Customer_);
  EXPORT Ip_Address__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Ip_Address_);
  EXPORT Otto_Ip_Address_Id__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Otto_Ip_Address_Id_);
  EXPORT _host__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,_host_);
  EXPORT _alias__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,_alias_);
  EXPORT _location__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,_location_);
  EXPORT _ip__address__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,_ip__address_);
  EXPORT _ip__address__date__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,_ip__address__date_);
  EXPORT _version__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,_version_);
  EXPORT _class__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,_class_);
  EXPORT _subnet__mask__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,_subnet__mask_);
  EXPORT _reserved__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,_reserved_);
  EXPORT _isp__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,_isp_);
  EXPORT _v2__validationipproblems__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,_v2__validationipproblems_);
  EXPORT _v2__ipstate__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,_v2__ipstate_);
  EXPORT _v2__ipcountry__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,_v2__ipcountry_);
  EXPORT _v2__ipcontinent__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,_v2__ipcontinent_);
  EXPORT _r_Customer__Orphan := JOIN(InData(__NN(_r_Customer_)),E_Customer.__Result,__EEQP(LEFT._r_Customer_, RIGHT.UID),TRANSFORM(InLayout,SELF := LEFT,SELF:=[]),LEFT ONLY, HASH);
  EXPORT _r_Source_Customer__Orphan := JOIN(InData(__NN(_r_Source_Customer_)),E_Customer.__Result,__EEQP(LEFT._r_Source_Customer_, RIGHT.UID),TRANSFORM(InLayout,SELF := LEFT,SELF:=[]),LEFT ONLY, HASH);
  EXPORT SanityCheck := DATASET([{COUNT(_r_Customer__Orphan),COUNT(_r_Source_Customer__Orphan),COUNT(KELOtto_fraudgovshared_Invalid),COUNT(_r_Customer__SingleValue_Invalid),COUNT(Ip_Address__SingleValue_Invalid),COUNT(Otto_Ip_Address_Id__SingleValue_Invalid),COUNT(_host__SingleValue_Invalid),COUNT(_alias__SingleValue_Invalid),COUNT(_location__SingleValue_Invalid),COUNT(_ip__address__SingleValue_Invalid),COUNT(_ip__address__date__SingleValue_Invalid),COUNT(_version__SingleValue_Invalid),COUNT(_class__SingleValue_Invalid),COUNT(_subnet__mask__SingleValue_Invalid),COUNT(_reserved__SingleValue_Invalid),COUNT(_isp__SingleValue_Invalid),COUNT(_v2__validationipproblems__SingleValue_Invalid),COUNT(_v2__ipstate__SingleValue_Invalid),COUNT(_v2__ipcountry__SingleValue_Invalid),COUNT(_v2__ipcontinent__SingleValue_Invalid)}],{KEL.typ.int _r_Customer__Orphan,KEL.typ.int _r_Source_Customer__Orphan,KEL.typ.int KELOtto_fraudgovshared_Invalid,KEL.typ.int _r_Customer__SingleValue_Invalid,KEL.typ.int Ip_Address__SingleValue_Invalid,KEL.typ.int Otto_Ip_Address_Id__SingleValue_Invalid,KEL.typ.int _host__SingleValue_Invalid,KEL.typ.int _alias__SingleValue_Invalid,KEL.typ.int _location__SingleValue_Invalid,KEL.typ.int _ip__address__SingleValue_Invalid,KEL.typ.int _ip__address__date__SingleValue_Invalid,KEL.typ.int _version__SingleValue_Invalid,KEL.typ.int _class__SingleValue_Invalid,KEL.typ.int _subnet__mask__SingleValue_Invalid,KEL.typ.int _reserved__SingleValue_Invalid,KEL.typ.int _isp__SingleValue_Invalid,KEL.typ.int _v2__validationipproblems__SingleValue_Invalid,KEL.typ.int _v2__ipstate__SingleValue_Invalid,KEL.typ.int _v2__ipcountry__SingleValue_Invalid,KEL.typ.int _v2__ipcontinent__SingleValue_Invalid});
  EXPORT NullCounts := DATASET([
    {'InternetProtocol','KELOtto.fraudgovshared','UID',COUNT(KELOtto_fraudgovshared_Invalid),COUNT(__d0)},
    {'InternetProtocol','KELOtto.fraudgovshared','AssociatedCustomerFileInfo',COUNT(__d0(__NL(_r_Customer_))),COUNT(__d0(__NN(_r_Customer_)))},
    {'InternetProtocol','KELOtto.fraudgovshared','SourceCustomerFileInfo',COUNT(__d0(__NL(_r_Source_Customer_))),COUNT(__d0(__NN(_r_Source_Customer_)))},
    {'InternetProtocol','KELOtto.fraudgovshared','ip_address',COUNT(__d0(__NL(Ip_Address_))),COUNT(__d0(__NN(Ip_Address_)))},
    {'InternetProtocol','KELOtto.fraudgovshared','OttoIpAddressId',COUNT(__d0(__NL(Otto_Ip_Address_Id_))),COUNT(__d0(__NN(Otto_Ip_Address_Id_)))},
    {'InternetProtocol','KELOtto.fraudgovshared','host',COUNT(__d0(__NL(_host_))),COUNT(__d0(__NN(_host_)))},
    {'InternetProtocol','KELOtto.fraudgovshared','alias',COUNT(__d0(__NL(_alias_))),COUNT(__d0(__NN(_alias_)))},
    {'InternetProtocol','KELOtto.fraudgovshared','location',COUNT(__d0(__NL(_location_))),COUNT(__d0(__NN(_location_)))},
    {'InternetProtocol','KELOtto.fraudgovshared','ip_address',COUNT(__d0(__NL(_ip__address_))),COUNT(__d0(__NN(_ip__address_)))},
    {'InternetProtocol','KELOtto.fraudgovshared','ip_address_date',COUNT(__d0(__NL(_ip__address__date_))),COUNT(__d0(__NN(_ip__address__date_)))},
    {'InternetProtocol','KELOtto.fraudgovshared','version',COUNT(__d0(__NL(_version_))),COUNT(__d0(__NN(_version_)))},
    {'InternetProtocol','KELOtto.fraudgovshared','class',COUNT(__d0(__NL(_class_))),COUNT(__d0(__NN(_class_)))},
    {'InternetProtocol','KELOtto.fraudgovshared','subnet_mask',COUNT(__d0(__NL(_subnet__mask_))),COUNT(__d0(__NN(_subnet__mask_)))},
    {'InternetProtocol','KELOtto.fraudgovshared','reserved',COUNT(__d0(__NL(_reserved_))),COUNT(__d0(__NN(_reserved_)))},
    {'InternetProtocol','KELOtto.fraudgovshared','isp',COUNT(__d0(__NL(_isp_))),COUNT(__d0(__NN(_isp_)))},
    {'InternetProtocol','KELOtto.fraudgovshared','v2_validationipproblems',COUNT(__d0(__NL(_v2__validationipproblems_))),COUNT(__d0(__NN(_v2__validationipproblems_)))},
    {'InternetProtocol','KELOtto.fraudgovshared','v2_ipstate',COUNT(__d0(__NL(_v2__ipstate_))),COUNT(__d0(__NN(_v2__ipstate_)))},
    {'InternetProtocol','KELOtto.fraudgovshared','v2_ipcountry',COUNT(__d0(__NL(_v2__ipcountry_))),COUNT(__d0(__NN(_v2__ipcountry_)))},
    {'InternetProtocol','KELOtto.fraudgovshared','v2_ipcontinent',COUNT(__d0(__NL(_v2__ipcontinent_))),COUNT(__d0(__NN(_v2__ipcontinent_)))},
    {'InternetProtocol','KELOtto.fraudgovshared','DateFirstSeen',COUNT(__d0(Date_First_Seen_=0)),COUNT(__d0(Date_First_Seen_!=0))},
    {'InternetProtocol','KELOtto.fraudgovshared','DateLastSeen',COUNT(__d0(Date_Last_Seen_=0)),COUNT(__d0(Date_Last_Seen_!=0))}]
  ,{KEL.typ.str entity,KEL.typ.str fileName,KEL.typ.str fieldName,KEL.typ.int nullCount,KEL.typ.int notNullCount});
END;
