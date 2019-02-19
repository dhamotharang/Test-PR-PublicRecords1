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
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
  END;
  SHARED VIRTUAL __SourceFilter(DATASET(InLayout) __ds) := __ds;
  SHARED VIRTUAL __GroupedFilter(GROUPED DATASET(InLayout) __ds) := __ds;
  SHARED __Mapping := 'UID(UID),associatedcustomerfileinfo(_r_Customer_:0),sourcecustomerfileinfo(_r_Source_Customer_:0),ip_address(Ip_Address_:\'\'|_ip__address_:\'\'),ottoipaddressid(Otto_Ip_Address_Id_:0),host(_host_:\'\'),alias(_alias_:\'\'),location(_location_:\'\'),ip_address_date(_ip__address__date_:\'\'),version(_version_:\'\'),class(_class_:\'\'),subnet_mask(_subnet__mask_:\'\'),reserved(_reserved_:\'\'),isp(_isp_:\'\'),v2_validationipproblems(_v2__validationipproblems_:0),v2_ipstate(_v2__ipstate_:\'\'),v2_ipcountry(_v2__ipcountry_:\'\'),v2_ipcontinent(_v2__ipcontinent_:\'\'),iprngbeg(_iprngbeg_:\'\'),iprngend(_iprngend_:\'\'),edgecountry(_edgecountry_:\'\'),edgeregion(_edgeregion_:\'\'),edgecity(_edgecity_:\'\'),edgeconnspeed(_edgeconnspeed_:\'\'),edgemetrocode(_edgemetrocode_:\'\'),edgelatitude(_edgelatitude_:\'\'),edgelongitude(_edgelongitude_:\'\'),edgepostalcode(_edgepostalcode_:\'\'),edgecountrycode(_edgecountrycode_:\'\'),edgeregioncode(_edgeregioncode_:\'\'),edgecitycode(_edgecitycode_:\'\'),edgecontinentcode(_edgecontinentcode_:\'\'),edgetwolettercountry(_edgetwolettercountry_:\'\'),edgeinternalcode(_edgeinternalcode_:\'\'),edgeareacodes(_edgeareacodes_:\'\'),edgecountryconf(_edgecountryconf_:\'\'),edgeregionconf(_edgeregionconf_:\'\'),edgecitycong(_edgecitycong_:\'\'),edgepostalconf(_edgepostalconf_:\'\'),edgegmtoffset(_edgegmtoffset_:\'\'),edgeindst(_edgeindst_:\'\'),siccode(_siccode_:\'\'),domainname(_domainname_:\'\'),ispname(_ispname_:\'\'),homebiztype(_homebiztype_:\'\'),asn(_asn_:\'\'),asnname(_asnname_:\'\'),primarylang(_primarylang_:\'\'),secondarylang(_secondarylang_:\'\'),proxytype(_proxytype_:\'\'),proxydescription(_proxydescription_:\'\'),isanisp(_isanisp_:\'\'),companyname(_companyname_:\'\'),ranks(_ranks_:\'\'),households(_households_:\'\'),women(_women_:\'\'),women18to34(_women18to34_:\'\'),women35to49(_women35to49_:\'\'),men(_men_:\'\'),men18to34(_men18to34_:\'\'),men35to49(_men35to49_:\'\'),teens(_teens_:\'\'),kids(_kids_:\'\'),naicscode(_naicscode_:\'\'),cbsacode(_cbsacode_:\'\'),cbsatitle(_cbsatitle_:\'\'),cbsatype(_cbsatype_:\'\'),csacode(_csacode_:\'\'),csatitle(_csatitle_:\'\'),mdcode(_mdcode_:\'\'),mdtitle(_mdtitle_:\'\'),organizationname(_organizationname_:\'\'),datefirstseen(Date_First_Seen_:EPOCH),datelastseen(Date_Last_Seen_:EPOCH)';
  SHARED __Trimmed := RECORD, MAXLENGTH(5000)
    STRING KeyVal;
  END;
  SHARED __d0_KELfiltered := KELOtto.fraudgovshared((UNSIGNED)did <> 0 AND AssociatedCustomerFileInfo > 0 AND TRIM(ip_address) != '' AND ip_address NOT IN ['0.0.0.0','10.121.146.247','10.121.146.90','10.121.146.15','10.121.146.159','10.121.146.249','10.121.146.34','10.121.146.231','10.121.146.235','10.121.146.232']);
  SHARED __d0_Trim := PROJECT(__d0_KELfiltered,TRANSFORM(__Trimmed,SELF.KeyVal:=TRIM((STRING)LEFT.AssociatedCustomerFileInfo) + '|' + TRIM((STRING)LEFT.ip_address)));
  SHARED __d1_KELfiltered := KELOtto.PersonIPMetadata((UNSIGNED)did <> 0 AND AssociatedCustomerFileInfo > 0 AND ip_address NOT IN ['0.0.0.0','10.121.146.247','10.121.146.90','10.121.146.15','10.121.146.159','10.121.146.249','10.121.146.34','10.121.146.231','10.121.146.235','10.121.146.232']);
  SHARED __d1_Trim := PROJECT(__d1_KELfiltered,TRANSFORM(__Trimmed,SELF.KeyVal:=TRIM((STRING)LEFT.AssociatedCustomerFileInfo) + '|' + TRIM((STRING)LEFT.ip_address)));
  EXPORT __All_Trim := __d0_Trim + __d1_Trim;
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
  SHARED __Mapping0 := 'UID(UID),associatedcustomerfileinfo(_r_Customer_:0),sourcecustomerfileinfo(_r_Source_Customer_:0),ip_address(Ip_Address_:\'\'|_ip__address_:\'\'),ottoipaddressid(Otto_Ip_Address_Id_:0),host(_host_:\'\'),alias(_alias_:\'\'),location(_location_:\'\'),ip_address_date(_ip__address__date_:\'\'),version(_version_:\'\'),class(_class_:\'\'),subnet_mask(_subnet__mask_:\'\'),reserved(_reserved_:\'\'),isp(_isp_:\'\'),v2_validationipproblems(_v2__validationipproblems_:0),v2_ipstate(_v2__ipstate_:\'\'),v2_ipcountry(_v2__ipcountry_:\'\'),v2_ipcontinent(_v2__ipcontinent_:\'\'),iprngbeg(_iprngbeg_:\'\'),iprngend(_iprngend_:\'\'),edgecountry(_edgecountry_:\'\'),edgeregion(_edgeregion_:\'\'),edgecity(_edgecity_:\'\'),edgeconnspeed(_edgeconnspeed_:\'\'),edgemetrocode(_edgemetrocode_:\'\'),edgelatitude(_edgelatitude_:\'\'),edgelongitude(_edgelongitude_:\'\'),edgepostalcode(_edgepostalcode_:\'\'),edgecountrycode(_edgecountrycode_:\'\'),edgeregioncode(_edgeregioncode_:\'\'),edgecitycode(_edgecitycode_:\'\'),edgecontinentcode(_edgecontinentcode_:\'\'),edgetwolettercountry(_edgetwolettercountry_:\'\'),edgeinternalcode(_edgeinternalcode_:\'\'),edgeareacodes(_edgeareacodes_:\'\'),edgecountryconf(_edgecountryconf_:\'\'),edgeregionconf(_edgeregionconf_:\'\'),edgecitycong(_edgecitycong_:\'\'),edgepostalconf(_edgepostalconf_:\'\'),edgegmtoffset(_edgegmtoffset_:\'\'),edgeindst(_edgeindst_:\'\'),siccode(_siccode_:\'\'),domainname(_domainname_:\'\'),ispname(_ispname_:\'\'),homebiztype(_homebiztype_:\'\'),asn(_asn_:\'\'),asnname(_asnname_:\'\'),primarylang(_primarylang_:\'\'),secondarylang(_secondarylang_:\'\'),proxytype(_proxytype_:\'\'),proxydescription(_proxydescription_:\'\'),isanisp(_isanisp_:\'\'),companyname(_companyname_:\'\'),ranks(_ranks_:\'\'),households(_households_:\'\'),women(_women_:\'\'),women18to34(_women18to34_:\'\'),women35to49(_women35to49_:\'\'),men(_men_:\'\'),men18to34(_men18to34_:\'\'),men35to49(_men35to49_:\'\'),teens(_teens_:\'\'),kids(_kids_:\'\'),naicscode(_naicscode_:\'\'),cbsacode(_cbsacode_:\'\'),cbsatitle(_cbsatitle_:\'\'),cbsatype(_cbsatype_:\'\'),csacode(_csacode_:\'\'),csatitle(_csatitle_:\'\'),mdcode(_mdcode_:\'\'),mdtitle(_mdtitle_:\'\'),organizationname(_organizationname_:\'\'),datefirstseen(Date_First_Seen_:EPOCH),datelastseen(Date_Last_Seen_:EPOCH)';
  SHARED __d0_Out := RECORD
    RECORDOF(KELOtto.fraudgovshared);
    KEL.typ.uid UID := 0;
  END;
  SHARED __d0_UID_Mapped := JOIN(__d0_KELfiltered,Lookup,TRIM((STRING)LEFT.AssociatedCustomerFileInfo) + '|' + TRIM((STRING)LEFT.ip_address) = RIGHT.KeyVal,TRANSFORM(__d0_Out,SELF.UID:=RIGHT.UID,SELF:=LEFT),HASH);
  EXPORT KELOtto_fraudgovshared_Invalid := __d0_UID_Mapped(UID = 0);
  SHARED __d0_Prefiltered := __d0_UID_Mapped(UID <> 0);
  SHARED __d0 := __SourceFilter(KEL.FromFlat.Convert(__d0_Prefiltered,InLayout,__Mapping0));
  SHARED __Mapping1 := 'UID(UID),associatedcustomerfileinfo(_r_Customer_:0),sourcecustomerfileinfo(_r_Source_Customer_:0),ip_address(Ip_Address_:\'\'|_ip__address_:\'\'),ottoipaddressid(Otto_Ip_Address_Id_:0),host(_host_:\'\'),alias(_alias_:\'\'),location(_location_:\'\'),ip_address_date(_ip__address__date_:\'\'),version(_version_:\'\'),class(_class_:\'\'),subnet_mask(_subnet__mask_:\'\'),reserved(_reserved_:\'\'),isp(_isp_:\'\'),v2_validationipproblems(_v2__validationipproblems_:0),v2_ipstate(_v2__ipstate_:\'\'),v2_ipcountry(_v2__ipcountry_:\'\'),v2_ipcontinent(_v2__ipcontinent_:\'\'),iprngbeg(_iprngbeg_:\'\'),iprngend(_iprngend_:\'\'),edgecountry(_edgecountry_:\'\'),edgeregion(_edgeregion_:\'\'),edgecity(_edgecity_:\'\'),edgeconnspeed(_edgeconnspeed_:\'\'),edgemetrocode(_edgemetrocode_:\'\'),edgelatitude(_edgelatitude_:\'\'),edgelongitude(_edgelongitude_:\'\'),edgepostalcode(_edgepostalcode_:\'\'),edgecountrycode(_edgecountrycode_:\'\'),edgeregioncode(_edgeregioncode_:\'\'),edgecitycode(_edgecitycode_:\'\'),edgecontinentcode(_edgecontinentcode_:\'\'),edgetwolettercountry(_edgetwolettercountry_:\'\'),edgeinternalcode(_edgeinternalcode_:\'\'),edgeareacodes(_edgeareacodes_:\'\'),edgecountryconf(_edgecountryconf_:\'\'),edgeregionconf(_edgeregionconf_:\'\'),edgecitycong(_edgecitycong_:\'\'),edgepostalconf(_edgepostalconf_:\'\'),edgegmtoffset(_edgegmtoffset_:\'\'),edgeindst(_edgeindst_:\'\'),siccode(_siccode_:\'\'),domainname(_domainname_:\'\'),ispname(_ispname_:\'\'),homebiztype(_homebiztype_:\'\'),asn(_asn_:\'\'),asnname(_asnname_:\'\'),primarylang(_primarylang_:\'\'),secondarylang(_secondarylang_:\'\'),proxytype(_proxytype_:\'\'),proxydescription(_proxydescription_:\'\'),isanisp(_isanisp_:\'\'),companyname(_companyname_:\'\'),ranks(_ranks_:\'\'),households(_households_:\'\'),women(_women_:\'\'),women18to34(_women18to34_:\'\'),women35to49(_women35to49_:\'\'),men(_men_:\'\'),men18to34(_men18to34_:\'\'),men35to49(_men35to49_:\'\'),teens(_teens_:\'\'),kids(_kids_:\'\'),naicscode(_naicscode_:\'\'),cbsacode(_cbsacode_:\'\'),cbsatitle(_cbsatitle_:\'\'),cbsatype(_cbsatype_:\'\'),csacode(_csacode_:\'\'),csatitle(_csatitle_:\'\'),mdcode(_mdcode_:\'\'),mdtitle(_mdtitle_:\'\'),organizationname(_organizationname_:\'\'),datefirstseen(Date_First_Seen_:EPOCH),datelastseen(Date_Last_Seen_:EPOCH)';
  SHARED __d1_Out := RECORD
    RECORDOF(KELOtto.PersonIPMetadata);
    KEL.typ.uid UID := 0;
  END;
  SHARED __d1_UID_Mapped := JOIN(__d1_KELfiltered,Lookup,TRIM((STRING)LEFT.AssociatedCustomerFileInfo) + '|' + TRIM((STRING)LEFT.ip_address) = RIGHT.KeyVal,TRANSFORM(__d1_Out,SELF.UID:=RIGHT.UID,SELF:=LEFT),HASH);
  EXPORT KELOtto_PersonIPMetadata_Invalid := __d1_UID_Mapped(UID = 0);
  SHARED __d1_Prefiltered := __d1_UID_Mapped(UID <> 0);
  SHARED __d1 := __SourceFilter(KEL.FromFlat.Convert(__d1_Prefiltered,InLayout,__Mapping1));
  EXPORT InData := __d0 + __d1;
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
    SELF._iprngbeg_ := KEL.Intake.SingleValue(__recs,_iprngbeg_);
    SELF._iprngend_ := KEL.Intake.SingleValue(__recs,_iprngend_);
    SELF._edgecountry_ := KEL.Intake.SingleValue(__recs,_edgecountry_);
    SELF._edgeregion_ := KEL.Intake.SingleValue(__recs,_edgeregion_);
    SELF._edgecity_ := KEL.Intake.SingleValue(__recs,_edgecity_);
    SELF._edgeconnspeed_ := KEL.Intake.SingleValue(__recs,_edgeconnspeed_);
    SELF._edgemetrocode_ := KEL.Intake.SingleValue(__recs,_edgemetrocode_);
    SELF._edgelatitude_ := KEL.Intake.SingleValue(__recs,_edgelatitude_);
    SELF._edgelongitude_ := KEL.Intake.SingleValue(__recs,_edgelongitude_);
    SELF._edgepostalcode_ := KEL.Intake.SingleValue(__recs,_edgepostalcode_);
    SELF._edgecountrycode_ := KEL.Intake.SingleValue(__recs,_edgecountrycode_);
    SELF._edgeregioncode_ := KEL.Intake.SingleValue(__recs,_edgeregioncode_);
    SELF._edgecitycode_ := KEL.Intake.SingleValue(__recs,_edgecitycode_);
    SELF._edgecontinentcode_ := KEL.Intake.SingleValue(__recs,_edgecontinentcode_);
    SELF._edgetwolettercountry_ := KEL.Intake.SingleValue(__recs,_edgetwolettercountry_);
    SELF._edgeinternalcode_ := KEL.Intake.SingleValue(__recs,_edgeinternalcode_);
    SELF._edgeareacodes_ := KEL.Intake.SingleValue(__recs,_edgeareacodes_);
    SELF._edgecountryconf_ := KEL.Intake.SingleValue(__recs,_edgecountryconf_);
    SELF._edgeregionconf_ := KEL.Intake.SingleValue(__recs,_edgeregionconf_);
    SELF._edgecitycong_ := KEL.Intake.SingleValue(__recs,_edgecitycong_);
    SELF._edgepostalconf_ := KEL.Intake.SingleValue(__recs,_edgepostalconf_);
    SELF._edgegmtoffset_ := KEL.Intake.SingleValue(__recs,_edgegmtoffset_);
    SELF._edgeindst_ := KEL.Intake.SingleValue(__recs,_edgeindst_);
    SELF._siccode_ := KEL.Intake.SingleValue(__recs,_siccode_);
    SELF._domainname_ := KEL.Intake.SingleValue(__recs,_domainname_);
    SELF._ispname_ := KEL.Intake.SingleValue(__recs,_ispname_);
    SELF._homebiztype_ := KEL.Intake.SingleValue(__recs,_homebiztype_);
    SELF._asn_ := KEL.Intake.SingleValue(__recs,_asn_);
    SELF._asnname_ := KEL.Intake.SingleValue(__recs,_asnname_);
    SELF._primarylang_ := KEL.Intake.SingleValue(__recs,_primarylang_);
    SELF._secondarylang_ := KEL.Intake.SingleValue(__recs,_secondarylang_);
    SELF._proxytype_ := KEL.Intake.SingleValue(__recs,_proxytype_);
    SELF._proxydescription_ := KEL.Intake.SingleValue(__recs,_proxydescription_);
    SELF._isanisp_ := KEL.Intake.SingleValue(__recs,_isanisp_);
    SELF._companyname_ := KEL.Intake.SingleValue(__recs,_companyname_);
    SELF._ranks_ := KEL.Intake.SingleValue(__recs,_ranks_);
    SELF._households_ := KEL.Intake.SingleValue(__recs,_households_);
    SELF._women_ := KEL.Intake.SingleValue(__recs,_women_);
    SELF._women18to34_ := KEL.Intake.SingleValue(__recs,_women18to34_);
    SELF._women35to49_ := KEL.Intake.SingleValue(__recs,_women35to49_);
    SELF._men_ := KEL.Intake.SingleValue(__recs,_men_);
    SELF._men18to34_ := KEL.Intake.SingleValue(__recs,_men18to34_);
    SELF._men35to49_ := KEL.Intake.SingleValue(__recs,_men35to49_);
    SELF._teens_ := KEL.Intake.SingleValue(__recs,_teens_);
    SELF._kids_ := KEL.Intake.SingleValue(__recs,_kids_);
    SELF._naicscode_ := KEL.Intake.SingleValue(__recs,_naicscode_);
    SELF._cbsacode_ := KEL.Intake.SingleValue(__recs,_cbsacode_);
    SELF._cbsatitle_ := KEL.Intake.SingleValue(__recs,_cbsatitle_);
    SELF._cbsatype_ := KEL.Intake.SingleValue(__recs,_cbsatype_);
    SELF._csacode_ := KEL.Intake.SingleValue(__recs,_csacode_);
    SELF._csatitle_ := KEL.Intake.SingleValue(__recs,_csatitle_);
    SELF._mdcode_ := KEL.Intake.SingleValue(__recs,_mdcode_);
    SELF._mdtitle_ := KEL.Intake.SingleValue(__recs,_mdtitle_);
    SELF._organizationname_ := KEL.Intake.SingleValue(__recs,_organizationname_);
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
  EXPORT _iprngbeg__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,_iprngbeg_);
  EXPORT _iprngend__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,_iprngend_);
  EXPORT _edgecountry__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,_edgecountry_);
  EXPORT _edgeregion__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,_edgeregion_);
  EXPORT _edgecity__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,_edgecity_);
  EXPORT _edgeconnspeed__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,_edgeconnspeed_);
  EXPORT _edgemetrocode__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,_edgemetrocode_);
  EXPORT _edgelatitude__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,_edgelatitude_);
  EXPORT _edgelongitude__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,_edgelongitude_);
  EXPORT _edgepostalcode__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,_edgepostalcode_);
  EXPORT _edgecountrycode__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,_edgecountrycode_);
  EXPORT _edgeregioncode__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,_edgeregioncode_);
  EXPORT _edgecitycode__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,_edgecitycode_);
  EXPORT _edgecontinentcode__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,_edgecontinentcode_);
  EXPORT _edgetwolettercountry__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,_edgetwolettercountry_);
  EXPORT _edgeinternalcode__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,_edgeinternalcode_);
  EXPORT _edgeareacodes__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,_edgeareacodes_);
  EXPORT _edgecountryconf__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,_edgecountryconf_);
  EXPORT _edgeregionconf__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,_edgeregionconf_);
  EXPORT _edgecitycong__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,_edgecitycong_);
  EXPORT _edgepostalconf__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,_edgepostalconf_);
  EXPORT _edgegmtoffset__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,_edgegmtoffset_);
  EXPORT _edgeindst__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,_edgeindst_);
  EXPORT _siccode__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,_siccode_);
  EXPORT _domainname__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,_domainname_);
  EXPORT _ispname__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,_ispname_);
  EXPORT _homebiztype__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,_homebiztype_);
  EXPORT _asn__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,_asn_);
  EXPORT _asnname__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,_asnname_);
  EXPORT _primarylang__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,_primarylang_);
  EXPORT _secondarylang__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,_secondarylang_);
  EXPORT _proxytype__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,_proxytype_);
  EXPORT _proxydescription__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,_proxydescription_);
  EXPORT _isanisp__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,_isanisp_);
  EXPORT _companyname__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,_companyname_);
  EXPORT _ranks__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,_ranks_);
  EXPORT _households__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,_households_);
  EXPORT _women__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,_women_);
  EXPORT _women18to34__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,_women18to34_);
  EXPORT _women35to49__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,_women35to49_);
  EXPORT _men__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,_men_);
  EXPORT _men18to34__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,_men18to34_);
  EXPORT _men35to49__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,_men35to49_);
  EXPORT _teens__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,_teens_);
  EXPORT _kids__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,_kids_);
  EXPORT _naicscode__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,_naicscode_);
  EXPORT _cbsacode__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,_cbsacode_);
  EXPORT _cbsatitle__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,_cbsatitle_);
  EXPORT _cbsatype__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,_cbsatype_);
  EXPORT _csacode__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,_csacode_);
  EXPORT _csatitle__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,_csatitle_);
  EXPORT _mdcode__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,_mdcode_);
  EXPORT _mdtitle__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,_mdtitle_);
  EXPORT _organizationname__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,_organizationname_);
  EXPORT _r_Customer__Orphan := JOIN(InData(__NN(_r_Customer_)),E_Customer.__Result,__EEQP(LEFT._r_Customer_, RIGHT.UID),TRANSFORM(InLayout,SELF := LEFT,SELF:=[]),LEFT ONLY, HASH);
  EXPORT _r_Source_Customer__Orphan := JOIN(InData(__NN(_r_Source_Customer_)),E_Customer.__Result,__EEQP(LEFT._r_Source_Customer_, RIGHT.UID),TRANSFORM(InLayout,SELF := LEFT,SELF:=[]),LEFT ONLY, HASH);
  EXPORT SanityCheck := DATASET([{COUNT(_r_Customer__Orphan),COUNT(_r_Source_Customer__Orphan),COUNT(KELOtto_fraudgovshared_Invalid),COUNT(KELOtto_PersonIPMetadata_Invalid),COUNT(_r_Customer__SingleValue_Invalid),COUNT(Ip_Address__SingleValue_Invalid),COUNT(Otto_Ip_Address_Id__SingleValue_Invalid),COUNT(_host__SingleValue_Invalid),COUNT(_alias__SingleValue_Invalid),COUNT(_location__SingleValue_Invalid),COUNT(_ip__address__SingleValue_Invalid),COUNT(_ip__address__date__SingleValue_Invalid),COUNT(_version__SingleValue_Invalid),COUNT(_class__SingleValue_Invalid),COUNT(_subnet__mask__SingleValue_Invalid),COUNT(_reserved__SingleValue_Invalid),COUNT(_isp__SingleValue_Invalid),COUNT(_v2__validationipproblems__SingleValue_Invalid),COUNT(_v2__ipstate__SingleValue_Invalid),COUNT(_v2__ipcountry__SingleValue_Invalid),COUNT(_v2__ipcontinent__SingleValue_Invalid),COUNT(_iprngbeg__SingleValue_Invalid),COUNT(_iprngend__SingleValue_Invalid),COUNT(_edgecountry__SingleValue_Invalid),COUNT(_edgeregion__SingleValue_Invalid),COUNT(_edgecity__SingleValue_Invalid),COUNT(_edgeconnspeed__SingleValue_Invalid),COUNT(_edgemetrocode__SingleValue_Invalid),COUNT(_edgelatitude__SingleValue_Invalid),COUNT(_edgelongitude__SingleValue_Invalid),COUNT(_edgepostalcode__SingleValue_Invalid),COUNT(_edgecountrycode__SingleValue_Invalid),COUNT(_edgeregioncode__SingleValue_Invalid),COUNT(_edgecitycode__SingleValue_Invalid),COUNT(_edgecontinentcode__SingleValue_Invalid),COUNT(_edgetwolettercountry__SingleValue_Invalid),COUNT(_edgeinternalcode__SingleValue_Invalid),COUNT(_edgeareacodes__SingleValue_Invalid),COUNT(_edgecountryconf__SingleValue_Invalid),COUNT(_edgeregionconf__SingleValue_Invalid),COUNT(_edgecitycong__SingleValue_Invalid),COUNT(_edgepostalconf__SingleValue_Invalid),COUNT(_edgegmtoffset__SingleValue_Invalid),COUNT(_edgeindst__SingleValue_Invalid),COUNT(_siccode__SingleValue_Invalid),COUNT(_domainname__SingleValue_Invalid),COUNT(_ispname__SingleValue_Invalid),COUNT(_homebiztype__SingleValue_Invalid),COUNT(_asn__SingleValue_Invalid),COUNT(_asnname__SingleValue_Invalid),COUNT(_primarylang__SingleValue_Invalid),COUNT(_secondarylang__SingleValue_Invalid),COUNT(_proxytype__SingleValue_Invalid),COUNT(_proxydescription__SingleValue_Invalid),COUNT(_isanisp__SingleValue_Invalid),COUNT(_companyname__SingleValue_Invalid),COUNT(_ranks__SingleValue_Invalid),COUNT(_households__SingleValue_Invalid),COUNT(_women__SingleValue_Invalid),COUNT(_women18to34__SingleValue_Invalid),COUNT(_women35to49__SingleValue_Invalid),COUNT(_men__SingleValue_Invalid),COUNT(_men18to34__SingleValue_Invalid),COUNT(_men35to49__SingleValue_Invalid),COUNT(_teens__SingleValue_Invalid),COUNT(_kids__SingleValue_Invalid),COUNT(_naicscode__SingleValue_Invalid),COUNT(_cbsacode__SingleValue_Invalid),COUNT(_cbsatitle__SingleValue_Invalid),COUNT(_cbsatype__SingleValue_Invalid),COUNT(_csacode__SingleValue_Invalid),COUNT(_csatitle__SingleValue_Invalid),COUNT(_mdcode__SingleValue_Invalid),COUNT(_mdtitle__SingleValue_Invalid),COUNT(_organizationname__SingleValue_Invalid)}],{KEL.typ.int _r_Customer__Orphan,KEL.typ.int _r_Source_Customer__Orphan,KEL.typ.int KELOtto_fraudgovshared_Invalid,KEL.typ.int KELOtto_PersonIPMetadata_Invalid,KEL.typ.int _r_Customer__SingleValue_Invalid,KEL.typ.int Ip_Address__SingleValue_Invalid,KEL.typ.int Otto_Ip_Address_Id__SingleValue_Invalid,KEL.typ.int _host__SingleValue_Invalid,KEL.typ.int _alias__SingleValue_Invalid,KEL.typ.int _location__SingleValue_Invalid,KEL.typ.int _ip__address__SingleValue_Invalid,KEL.typ.int _ip__address__date__SingleValue_Invalid,KEL.typ.int _version__SingleValue_Invalid,KEL.typ.int _class__SingleValue_Invalid,KEL.typ.int _subnet__mask__SingleValue_Invalid,KEL.typ.int _reserved__SingleValue_Invalid,KEL.typ.int _isp__SingleValue_Invalid,KEL.typ.int _v2__validationipproblems__SingleValue_Invalid,KEL.typ.int _v2__ipstate__SingleValue_Invalid,KEL.typ.int _v2__ipcountry__SingleValue_Invalid,KEL.typ.int _v2__ipcontinent__SingleValue_Invalid,KEL.typ.int _iprngbeg__SingleValue_Invalid,KEL.typ.int _iprngend__SingleValue_Invalid,KEL.typ.int _edgecountry__SingleValue_Invalid,KEL.typ.int _edgeregion__SingleValue_Invalid,KEL.typ.int _edgecity__SingleValue_Invalid,KEL.typ.int _edgeconnspeed__SingleValue_Invalid,KEL.typ.int _edgemetrocode__SingleValue_Invalid,KEL.typ.int _edgelatitude__SingleValue_Invalid,KEL.typ.int _edgelongitude__SingleValue_Invalid,KEL.typ.int _edgepostalcode__SingleValue_Invalid,KEL.typ.int _edgecountrycode__SingleValue_Invalid,KEL.typ.int _edgeregioncode__SingleValue_Invalid,KEL.typ.int _edgecitycode__SingleValue_Invalid,KEL.typ.int _edgecontinentcode__SingleValue_Invalid,KEL.typ.int _edgetwolettercountry__SingleValue_Invalid,KEL.typ.int _edgeinternalcode__SingleValue_Invalid,KEL.typ.int _edgeareacodes__SingleValue_Invalid,KEL.typ.int _edgecountryconf__SingleValue_Invalid,KEL.typ.int _edgeregionconf__SingleValue_Invalid,KEL.typ.int _edgecitycong__SingleValue_Invalid,KEL.typ.int _edgepostalconf__SingleValue_Invalid,KEL.typ.int _edgegmtoffset__SingleValue_Invalid,KEL.typ.int _edgeindst__SingleValue_Invalid,KEL.typ.int _siccode__SingleValue_Invalid,KEL.typ.int _domainname__SingleValue_Invalid,KEL.typ.int _ispname__SingleValue_Invalid,KEL.typ.int _homebiztype__SingleValue_Invalid,KEL.typ.int _asn__SingleValue_Invalid,KEL.typ.int _asnname__SingleValue_Invalid,KEL.typ.int _primarylang__SingleValue_Invalid,KEL.typ.int _secondarylang__SingleValue_Invalid,KEL.typ.int _proxytype__SingleValue_Invalid,KEL.typ.int _proxydescription__SingleValue_Invalid,KEL.typ.int _isanisp__SingleValue_Invalid,KEL.typ.int _companyname__SingleValue_Invalid,KEL.typ.int _ranks__SingleValue_Invalid,KEL.typ.int _households__SingleValue_Invalid,KEL.typ.int _women__SingleValue_Invalid,KEL.typ.int _women18to34__SingleValue_Invalid,KEL.typ.int _women35to49__SingleValue_Invalid,KEL.typ.int _men__SingleValue_Invalid,KEL.typ.int _men18to34__SingleValue_Invalid,KEL.typ.int _men35to49__SingleValue_Invalid,KEL.typ.int _teens__SingleValue_Invalid,KEL.typ.int _kids__SingleValue_Invalid,KEL.typ.int _naicscode__SingleValue_Invalid,KEL.typ.int _cbsacode__SingleValue_Invalid,KEL.typ.int _cbsatitle__SingleValue_Invalid,KEL.typ.int _cbsatype__SingleValue_Invalid,KEL.typ.int _csacode__SingleValue_Invalid,KEL.typ.int _csatitle__SingleValue_Invalid,KEL.typ.int _mdcode__SingleValue_Invalid,KEL.typ.int _mdtitle__SingleValue_Invalid,KEL.typ.int _organizationname__SingleValue_Invalid});
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
    {'InternetProtocol','KELOtto.fraudgovshared','iprngbeg',COUNT(__d0(__NL(_iprngbeg_))),COUNT(__d0(__NN(_iprngbeg_)))},
    {'InternetProtocol','KELOtto.fraudgovshared','iprngend',COUNT(__d0(__NL(_iprngend_))),COUNT(__d0(__NN(_iprngend_)))},
    {'InternetProtocol','KELOtto.fraudgovshared','edgecountry',COUNT(__d0(__NL(_edgecountry_))),COUNT(__d0(__NN(_edgecountry_)))},
    {'InternetProtocol','KELOtto.fraudgovshared','edgeregion',COUNT(__d0(__NL(_edgeregion_))),COUNT(__d0(__NN(_edgeregion_)))},
    {'InternetProtocol','KELOtto.fraudgovshared','edgecity',COUNT(__d0(__NL(_edgecity_))),COUNT(__d0(__NN(_edgecity_)))},
    {'InternetProtocol','KELOtto.fraudgovshared','edgeconnspeed',COUNT(__d0(__NL(_edgeconnspeed_))),COUNT(__d0(__NN(_edgeconnspeed_)))},
    {'InternetProtocol','KELOtto.fraudgovshared','edgemetrocode',COUNT(__d0(__NL(_edgemetrocode_))),COUNT(__d0(__NN(_edgemetrocode_)))},
    {'InternetProtocol','KELOtto.fraudgovshared','edgelatitude',COUNT(__d0(__NL(_edgelatitude_))),COUNT(__d0(__NN(_edgelatitude_)))},
    {'InternetProtocol','KELOtto.fraudgovshared','edgelongitude',COUNT(__d0(__NL(_edgelongitude_))),COUNT(__d0(__NN(_edgelongitude_)))},
    {'InternetProtocol','KELOtto.fraudgovshared','edgepostalcode',COUNT(__d0(__NL(_edgepostalcode_))),COUNT(__d0(__NN(_edgepostalcode_)))},
    {'InternetProtocol','KELOtto.fraudgovshared','edgecountrycode',COUNT(__d0(__NL(_edgecountrycode_))),COUNT(__d0(__NN(_edgecountrycode_)))},
    {'InternetProtocol','KELOtto.fraudgovshared','edgeregioncode',COUNT(__d0(__NL(_edgeregioncode_))),COUNT(__d0(__NN(_edgeregioncode_)))},
    {'InternetProtocol','KELOtto.fraudgovshared','edgecitycode',COUNT(__d0(__NL(_edgecitycode_))),COUNT(__d0(__NN(_edgecitycode_)))},
    {'InternetProtocol','KELOtto.fraudgovshared','edgecontinentcode',COUNT(__d0(__NL(_edgecontinentcode_))),COUNT(__d0(__NN(_edgecontinentcode_)))},
    {'InternetProtocol','KELOtto.fraudgovshared','edgetwolettercountry',COUNT(__d0(__NL(_edgetwolettercountry_))),COUNT(__d0(__NN(_edgetwolettercountry_)))},
    {'InternetProtocol','KELOtto.fraudgovshared','edgeinternalcode',COUNT(__d0(__NL(_edgeinternalcode_))),COUNT(__d0(__NN(_edgeinternalcode_)))},
    {'InternetProtocol','KELOtto.fraudgovshared','edgeareacodes',COUNT(__d0(__NL(_edgeareacodes_))),COUNT(__d0(__NN(_edgeareacodes_)))},
    {'InternetProtocol','KELOtto.fraudgovshared','edgecountryconf',COUNT(__d0(__NL(_edgecountryconf_))),COUNT(__d0(__NN(_edgecountryconf_)))},
    {'InternetProtocol','KELOtto.fraudgovshared','edgeregionconf',COUNT(__d0(__NL(_edgeregionconf_))),COUNT(__d0(__NN(_edgeregionconf_)))},
    {'InternetProtocol','KELOtto.fraudgovshared','edgecitycong',COUNT(__d0(__NL(_edgecitycong_))),COUNT(__d0(__NN(_edgecitycong_)))},
    {'InternetProtocol','KELOtto.fraudgovshared','edgepostalconf',COUNT(__d0(__NL(_edgepostalconf_))),COUNT(__d0(__NN(_edgepostalconf_)))},
    {'InternetProtocol','KELOtto.fraudgovshared','edgegmtoffset',COUNT(__d0(__NL(_edgegmtoffset_))),COUNT(__d0(__NN(_edgegmtoffset_)))},
    {'InternetProtocol','KELOtto.fraudgovshared','edgeindst',COUNT(__d0(__NL(_edgeindst_))),COUNT(__d0(__NN(_edgeindst_)))},
    {'InternetProtocol','KELOtto.fraudgovshared','siccode',COUNT(__d0(__NL(_siccode_))),COUNT(__d0(__NN(_siccode_)))},
    {'InternetProtocol','KELOtto.fraudgovshared','domainname',COUNT(__d0(__NL(_domainname_))),COUNT(__d0(__NN(_domainname_)))},
    {'InternetProtocol','KELOtto.fraudgovshared','ispname',COUNT(__d0(__NL(_ispname_))),COUNT(__d0(__NN(_ispname_)))},
    {'InternetProtocol','KELOtto.fraudgovshared','homebiztype',COUNT(__d0(__NL(_homebiztype_))),COUNT(__d0(__NN(_homebiztype_)))},
    {'InternetProtocol','KELOtto.fraudgovshared','asn',COUNT(__d0(__NL(_asn_))),COUNT(__d0(__NN(_asn_)))},
    {'InternetProtocol','KELOtto.fraudgovshared','asnname',COUNT(__d0(__NL(_asnname_))),COUNT(__d0(__NN(_asnname_)))},
    {'InternetProtocol','KELOtto.fraudgovshared','primarylang',COUNT(__d0(__NL(_primarylang_))),COUNT(__d0(__NN(_primarylang_)))},
    {'InternetProtocol','KELOtto.fraudgovshared','secondarylang',COUNT(__d0(__NL(_secondarylang_))),COUNT(__d0(__NN(_secondarylang_)))},
    {'InternetProtocol','KELOtto.fraudgovshared','proxytype',COUNT(__d0(__NL(_proxytype_))),COUNT(__d0(__NN(_proxytype_)))},
    {'InternetProtocol','KELOtto.fraudgovshared','proxydescription',COUNT(__d0(__NL(_proxydescription_))),COUNT(__d0(__NN(_proxydescription_)))},
    {'InternetProtocol','KELOtto.fraudgovshared','isanisp',COUNT(__d0(__NL(_isanisp_))),COUNT(__d0(__NN(_isanisp_)))},
    {'InternetProtocol','KELOtto.fraudgovshared','companyname',COUNT(__d0(__NL(_companyname_))),COUNT(__d0(__NN(_companyname_)))},
    {'InternetProtocol','KELOtto.fraudgovshared','ranks',COUNT(__d0(__NL(_ranks_))),COUNT(__d0(__NN(_ranks_)))},
    {'InternetProtocol','KELOtto.fraudgovshared','households',COUNT(__d0(__NL(_households_))),COUNT(__d0(__NN(_households_)))},
    {'InternetProtocol','KELOtto.fraudgovshared','women',COUNT(__d0(__NL(_women_))),COUNT(__d0(__NN(_women_)))},
    {'InternetProtocol','KELOtto.fraudgovshared','women18to34',COUNT(__d0(__NL(_women18to34_))),COUNT(__d0(__NN(_women18to34_)))},
    {'InternetProtocol','KELOtto.fraudgovshared','women35to49',COUNT(__d0(__NL(_women35to49_))),COUNT(__d0(__NN(_women35to49_)))},
    {'InternetProtocol','KELOtto.fraudgovshared','men',COUNT(__d0(__NL(_men_))),COUNT(__d0(__NN(_men_)))},
    {'InternetProtocol','KELOtto.fraudgovshared','men18to34',COUNT(__d0(__NL(_men18to34_))),COUNT(__d0(__NN(_men18to34_)))},
    {'InternetProtocol','KELOtto.fraudgovshared','men35to49',COUNT(__d0(__NL(_men35to49_))),COUNT(__d0(__NN(_men35to49_)))},
    {'InternetProtocol','KELOtto.fraudgovshared','teens',COUNT(__d0(__NL(_teens_))),COUNT(__d0(__NN(_teens_)))},
    {'InternetProtocol','KELOtto.fraudgovshared','kids',COUNT(__d0(__NL(_kids_))),COUNT(__d0(__NN(_kids_)))},
    {'InternetProtocol','KELOtto.fraudgovshared','naicscode',COUNT(__d0(__NL(_naicscode_))),COUNT(__d0(__NN(_naicscode_)))},
    {'InternetProtocol','KELOtto.fraudgovshared','cbsacode',COUNT(__d0(__NL(_cbsacode_))),COUNT(__d0(__NN(_cbsacode_)))},
    {'InternetProtocol','KELOtto.fraudgovshared','cbsatitle',COUNT(__d0(__NL(_cbsatitle_))),COUNT(__d0(__NN(_cbsatitle_)))},
    {'InternetProtocol','KELOtto.fraudgovshared','cbsatype',COUNT(__d0(__NL(_cbsatype_))),COUNT(__d0(__NN(_cbsatype_)))},
    {'InternetProtocol','KELOtto.fraudgovshared','csacode',COUNT(__d0(__NL(_csacode_))),COUNT(__d0(__NN(_csacode_)))},
    {'InternetProtocol','KELOtto.fraudgovshared','csatitle',COUNT(__d0(__NL(_csatitle_))),COUNT(__d0(__NN(_csatitle_)))},
    {'InternetProtocol','KELOtto.fraudgovshared','mdcode',COUNT(__d0(__NL(_mdcode_))),COUNT(__d0(__NN(_mdcode_)))},
    {'InternetProtocol','KELOtto.fraudgovshared','mdtitle',COUNT(__d0(__NL(_mdtitle_))),COUNT(__d0(__NN(_mdtitle_)))},
    {'InternetProtocol','KELOtto.fraudgovshared','organizationname',COUNT(__d0(__NL(_organizationname_))),COUNT(__d0(__NN(_organizationname_)))},
    {'InternetProtocol','KELOtto.fraudgovshared','DateFirstSeen',COUNT(__d0(Date_First_Seen_=0)),COUNT(__d0(Date_First_Seen_!=0))},
    {'InternetProtocol','KELOtto.fraudgovshared','DateLastSeen',COUNT(__d0(Date_Last_Seen_=0)),COUNT(__d0(Date_Last_Seen_!=0))},
    {'InternetProtocol','KELOtto.PersonIPMetadata','UID',COUNT(KELOtto_PersonIPMetadata_Invalid),COUNT(__d1)},
    {'InternetProtocol','KELOtto.PersonIPMetadata','AssociatedCustomerFileInfo',COUNT(__d1(__NL(_r_Customer_))),COUNT(__d1(__NN(_r_Customer_)))},
    {'InternetProtocol','KELOtto.PersonIPMetadata','SourceCustomerFileInfo',COUNT(__d1(__NL(_r_Source_Customer_))),COUNT(__d1(__NN(_r_Source_Customer_)))},
    {'InternetProtocol','KELOtto.PersonIPMetadata','ip_address',COUNT(__d1(__NL(Ip_Address_))),COUNT(__d1(__NN(Ip_Address_)))},
    {'InternetProtocol','KELOtto.PersonIPMetadata','OttoIpAddressId',COUNT(__d1(__NL(Otto_Ip_Address_Id_))),COUNT(__d1(__NN(Otto_Ip_Address_Id_)))},
    {'InternetProtocol','KELOtto.PersonIPMetadata','host',COUNT(__d1(__NL(_host_))),COUNT(__d1(__NN(_host_)))},
    {'InternetProtocol','KELOtto.PersonIPMetadata','alias',COUNT(__d1(__NL(_alias_))),COUNT(__d1(__NN(_alias_)))},
    {'InternetProtocol','KELOtto.PersonIPMetadata','location',COUNT(__d1(__NL(_location_))),COUNT(__d1(__NN(_location_)))},
    {'InternetProtocol','KELOtto.PersonIPMetadata','ip_address',COUNT(__d1(__NL(_ip__address_))),COUNT(__d1(__NN(_ip__address_)))},
    {'InternetProtocol','KELOtto.PersonIPMetadata','ip_address_date',COUNT(__d1(__NL(_ip__address__date_))),COUNT(__d1(__NN(_ip__address__date_)))},
    {'InternetProtocol','KELOtto.PersonIPMetadata','version',COUNT(__d1(__NL(_version_))),COUNT(__d1(__NN(_version_)))},
    {'InternetProtocol','KELOtto.PersonIPMetadata','class',COUNT(__d1(__NL(_class_))),COUNT(__d1(__NN(_class_)))},
    {'InternetProtocol','KELOtto.PersonIPMetadata','subnet_mask',COUNT(__d1(__NL(_subnet__mask_))),COUNT(__d1(__NN(_subnet__mask_)))},
    {'InternetProtocol','KELOtto.PersonIPMetadata','reserved',COUNT(__d1(__NL(_reserved_))),COUNT(__d1(__NN(_reserved_)))},
    {'InternetProtocol','KELOtto.PersonIPMetadata','isp',COUNT(__d1(__NL(_isp_))),COUNT(__d1(__NN(_isp_)))},
    {'InternetProtocol','KELOtto.PersonIPMetadata','v2_validationipproblems',COUNT(__d1(__NL(_v2__validationipproblems_))),COUNT(__d1(__NN(_v2__validationipproblems_)))},
    {'InternetProtocol','KELOtto.PersonIPMetadata','v2_ipstate',COUNT(__d1(__NL(_v2__ipstate_))),COUNT(__d1(__NN(_v2__ipstate_)))},
    {'InternetProtocol','KELOtto.PersonIPMetadata','v2_ipcountry',COUNT(__d1(__NL(_v2__ipcountry_))),COUNT(__d1(__NN(_v2__ipcountry_)))},
    {'InternetProtocol','KELOtto.PersonIPMetadata','v2_ipcontinent',COUNT(__d1(__NL(_v2__ipcontinent_))),COUNT(__d1(__NN(_v2__ipcontinent_)))},
    {'InternetProtocol','KELOtto.PersonIPMetadata','iprngbeg',COUNT(__d1(__NL(_iprngbeg_))),COUNT(__d1(__NN(_iprngbeg_)))},
    {'InternetProtocol','KELOtto.PersonIPMetadata','iprngend',COUNT(__d1(__NL(_iprngend_))),COUNT(__d1(__NN(_iprngend_)))},
    {'InternetProtocol','KELOtto.PersonIPMetadata','edgecountry',COUNT(__d1(__NL(_edgecountry_))),COUNT(__d1(__NN(_edgecountry_)))},
    {'InternetProtocol','KELOtto.PersonIPMetadata','edgeregion',COUNT(__d1(__NL(_edgeregion_))),COUNT(__d1(__NN(_edgeregion_)))},
    {'InternetProtocol','KELOtto.PersonIPMetadata','edgecity',COUNT(__d1(__NL(_edgecity_))),COUNT(__d1(__NN(_edgecity_)))},
    {'InternetProtocol','KELOtto.PersonIPMetadata','edgeconnspeed',COUNT(__d1(__NL(_edgeconnspeed_))),COUNT(__d1(__NN(_edgeconnspeed_)))},
    {'InternetProtocol','KELOtto.PersonIPMetadata','edgemetrocode',COUNT(__d1(__NL(_edgemetrocode_))),COUNT(__d1(__NN(_edgemetrocode_)))},
    {'InternetProtocol','KELOtto.PersonIPMetadata','edgelatitude',COUNT(__d1(__NL(_edgelatitude_))),COUNT(__d1(__NN(_edgelatitude_)))},
    {'InternetProtocol','KELOtto.PersonIPMetadata','edgelongitude',COUNT(__d1(__NL(_edgelongitude_))),COUNT(__d1(__NN(_edgelongitude_)))},
    {'InternetProtocol','KELOtto.PersonIPMetadata','edgepostalcode',COUNT(__d1(__NL(_edgepostalcode_))),COUNT(__d1(__NN(_edgepostalcode_)))},
    {'InternetProtocol','KELOtto.PersonIPMetadata','edgecountrycode',COUNT(__d1(__NL(_edgecountrycode_))),COUNT(__d1(__NN(_edgecountrycode_)))},
    {'InternetProtocol','KELOtto.PersonIPMetadata','edgeregioncode',COUNT(__d1(__NL(_edgeregioncode_))),COUNT(__d1(__NN(_edgeregioncode_)))},
    {'InternetProtocol','KELOtto.PersonIPMetadata','edgecitycode',COUNT(__d1(__NL(_edgecitycode_))),COUNT(__d1(__NN(_edgecitycode_)))},
    {'InternetProtocol','KELOtto.PersonIPMetadata','edgecontinentcode',COUNT(__d1(__NL(_edgecontinentcode_))),COUNT(__d1(__NN(_edgecontinentcode_)))},
    {'InternetProtocol','KELOtto.PersonIPMetadata','edgetwolettercountry',COUNT(__d1(__NL(_edgetwolettercountry_))),COUNT(__d1(__NN(_edgetwolettercountry_)))},
    {'InternetProtocol','KELOtto.PersonIPMetadata','edgeinternalcode',COUNT(__d1(__NL(_edgeinternalcode_))),COUNT(__d1(__NN(_edgeinternalcode_)))},
    {'InternetProtocol','KELOtto.PersonIPMetadata','edgeareacodes',COUNT(__d1(__NL(_edgeareacodes_))),COUNT(__d1(__NN(_edgeareacodes_)))},
    {'InternetProtocol','KELOtto.PersonIPMetadata','edgecountryconf',COUNT(__d1(__NL(_edgecountryconf_))),COUNT(__d1(__NN(_edgecountryconf_)))},
    {'InternetProtocol','KELOtto.PersonIPMetadata','edgeregionconf',COUNT(__d1(__NL(_edgeregionconf_))),COUNT(__d1(__NN(_edgeregionconf_)))},
    {'InternetProtocol','KELOtto.PersonIPMetadata','edgecitycong',COUNT(__d1(__NL(_edgecitycong_))),COUNT(__d1(__NN(_edgecitycong_)))},
    {'InternetProtocol','KELOtto.PersonIPMetadata','edgepostalconf',COUNT(__d1(__NL(_edgepostalconf_))),COUNT(__d1(__NN(_edgepostalconf_)))},
    {'InternetProtocol','KELOtto.PersonIPMetadata','edgegmtoffset',COUNT(__d1(__NL(_edgegmtoffset_))),COUNT(__d1(__NN(_edgegmtoffset_)))},
    {'InternetProtocol','KELOtto.PersonIPMetadata','edgeindst',COUNT(__d1(__NL(_edgeindst_))),COUNT(__d1(__NN(_edgeindst_)))},
    {'InternetProtocol','KELOtto.PersonIPMetadata','siccode',COUNT(__d1(__NL(_siccode_))),COUNT(__d1(__NN(_siccode_)))},
    {'InternetProtocol','KELOtto.PersonIPMetadata','domainname',COUNT(__d1(__NL(_domainname_))),COUNT(__d1(__NN(_domainname_)))},
    {'InternetProtocol','KELOtto.PersonIPMetadata','ispname',COUNT(__d1(__NL(_ispname_))),COUNT(__d1(__NN(_ispname_)))},
    {'InternetProtocol','KELOtto.PersonIPMetadata','homebiztype',COUNT(__d1(__NL(_homebiztype_))),COUNT(__d1(__NN(_homebiztype_)))},
    {'InternetProtocol','KELOtto.PersonIPMetadata','asn',COUNT(__d1(__NL(_asn_))),COUNT(__d1(__NN(_asn_)))},
    {'InternetProtocol','KELOtto.PersonIPMetadata','asnname',COUNT(__d1(__NL(_asnname_))),COUNT(__d1(__NN(_asnname_)))},
    {'InternetProtocol','KELOtto.PersonIPMetadata','primarylang',COUNT(__d1(__NL(_primarylang_))),COUNT(__d1(__NN(_primarylang_)))},
    {'InternetProtocol','KELOtto.PersonIPMetadata','secondarylang',COUNT(__d1(__NL(_secondarylang_))),COUNT(__d1(__NN(_secondarylang_)))},
    {'InternetProtocol','KELOtto.PersonIPMetadata','proxytype',COUNT(__d1(__NL(_proxytype_))),COUNT(__d1(__NN(_proxytype_)))},
    {'InternetProtocol','KELOtto.PersonIPMetadata','proxydescription',COUNT(__d1(__NL(_proxydescription_))),COUNT(__d1(__NN(_proxydescription_)))},
    {'InternetProtocol','KELOtto.PersonIPMetadata','isanisp',COUNT(__d1(__NL(_isanisp_))),COUNT(__d1(__NN(_isanisp_)))},
    {'InternetProtocol','KELOtto.PersonIPMetadata','companyname',COUNT(__d1(__NL(_companyname_))),COUNT(__d1(__NN(_companyname_)))},
    {'InternetProtocol','KELOtto.PersonIPMetadata','ranks',COUNT(__d1(__NL(_ranks_))),COUNT(__d1(__NN(_ranks_)))},
    {'InternetProtocol','KELOtto.PersonIPMetadata','households',COUNT(__d1(__NL(_households_))),COUNT(__d1(__NN(_households_)))},
    {'InternetProtocol','KELOtto.PersonIPMetadata','women',COUNT(__d1(__NL(_women_))),COUNT(__d1(__NN(_women_)))},
    {'InternetProtocol','KELOtto.PersonIPMetadata','women18to34',COUNT(__d1(__NL(_women18to34_))),COUNT(__d1(__NN(_women18to34_)))},
    {'InternetProtocol','KELOtto.PersonIPMetadata','women35to49',COUNT(__d1(__NL(_women35to49_))),COUNT(__d1(__NN(_women35to49_)))},
    {'InternetProtocol','KELOtto.PersonIPMetadata','men',COUNT(__d1(__NL(_men_))),COUNT(__d1(__NN(_men_)))},
    {'InternetProtocol','KELOtto.PersonIPMetadata','men18to34',COUNT(__d1(__NL(_men18to34_))),COUNT(__d1(__NN(_men18to34_)))},
    {'InternetProtocol','KELOtto.PersonIPMetadata','men35to49',COUNT(__d1(__NL(_men35to49_))),COUNT(__d1(__NN(_men35to49_)))},
    {'InternetProtocol','KELOtto.PersonIPMetadata','teens',COUNT(__d1(__NL(_teens_))),COUNT(__d1(__NN(_teens_)))},
    {'InternetProtocol','KELOtto.PersonIPMetadata','kids',COUNT(__d1(__NL(_kids_))),COUNT(__d1(__NN(_kids_)))},
    {'InternetProtocol','KELOtto.PersonIPMetadata','naicscode',COUNT(__d1(__NL(_naicscode_))),COUNT(__d1(__NN(_naicscode_)))},
    {'InternetProtocol','KELOtto.PersonIPMetadata','cbsacode',COUNT(__d1(__NL(_cbsacode_))),COUNT(__d1(__NN(_cbsacode_)))},
    {'InternetProtocol','KELOtto.PersonIPMetadata','cbsatitle',COUNT(__d1(__NL(_cbsatitle_))),COUNT(__d1(__NN(_cbsatitle_)))},
    {'InternetProtocol','KELOtto.PersonIPMetadata','cbsatype',COUNT(__d1(__NL(_cbsatype_))),COUNT(__d1(__NN(_cbsatype_)))},
    {'InternetProtocol','KELOtto.PersonIPMetadata','csacode',COUNT(__d1(__NL(_csacode_))),COUNT(__d1(__NN(_csacode_)))},
    {'InternetProtocol','KELOtto.PersonIPMetadata','csatitle',COUNT(__d1(__NL(_csatitle_))),COUNT(__d1(__NN(_csatitle_)))},
    {'InternetProtocol','KELOtto.PersonIPMetadata','mdcode',COUNT(__d1(__NL(_mdcode_))),COUNT(__d1(__NN(_mdcode_)))},
    {'InternetProtocol','KELOtto.PersonIPMetadata','mdtitle',COUNT(__d1(__NL(_mdtitle_))),COUNT(__d1(__NN(_mdtitle_)))},
    {'InternetProtocol','KELOtto.PersonIPMetadata','organizationname',COUNT(__d1(__NL(_organizationname_))),COUNT(__d1(__NN(_organizationname_)))},
    {'InternetProtocol','KELOtto.PersonIPMetadata','DateFirstSeen',COUNT(__d1(Date_First_Seen_=0)),COUNT(__d1(Date_First_Seen_!=0))},
    {'InternetProtocol','KELOtto.PersonIPMetadata','DateLastSeen',COUNT(__d1(Date_Last_Seen_=0)),COUNT(__d1(Date_Last_Seen_!=0))}]
  ,{KEL.typ.str entity,KEL.typ.str fileName,KEL.typ.str fieldName,KEL.typ.int nullCount,KEL.typ.int notNullCount});
END;
