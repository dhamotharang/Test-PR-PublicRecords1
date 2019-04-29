//HPCC Systems KEL Compiler Version 0.11.0
IMPORT KEL011 AS KEL;
IMPORT KELOtto;
IMPORT E_Address,E_Customer,E_Person FROM KELOtto;
IMPORT * FROM KEL011.Null;
EXPORT E_Event := MODULE
  EXPORT Typ := KEL.typ.uid;
  EXPORT InLayout := RECORD
    KEL.typ.nuid UID;
    KEL.typ.ntyp(E_Customer.Typ) _r_Customer_;
    KEL.typ.ntyp(E_Customer.Typ) _r_Source_Customer_;
    KEL.typ.ntyp(E_Person.Typ) Subject_;
    KEL.typ.ntyp(E_Address.Typ) Location_;
    KEL.typ.nint Record_Id_;
    KEL.typ.nkdate Event_Date_;
    KEL.typ.nstr Event_Type_;
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
    KEL.typ.nkdate Date_Of_Birth_;
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
    KEL.typ.nstr Hri_;
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
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
  END;
  SHARED VIRTUAL __SourceFilter(DATASET(InLayout) __ds) := __ds;
  SHARED VIRTUAL __GroupedFilter(GROUPED DATASET(InLayout) __ds) := __ds;
  SHARED __Mapping := 'UID(UID),associatedcustomerfileinfo(_r_Customer_:0),sourcecustomerfileinfo(_r_Source_Customer_:0),Subject_(Subject_:0),Location_(Location_:0),record_id(Record_Id_:0),eventdate(Event_Date_:DATE),eventtype(Event_Type_:\'\'),confidence_that_activity_was_deceitful_id(Confidence__that__activity__was__deceitful__id_:0),name_risk_code(_name__risk__code_:0),dob_risk_code(_dob__risk__code_:0),ssn_risk_code(_ssn__risk__code_:0),drivers_license_risk_code(_drivers__license__risk__code_:0),physical_address_risk_code(_physical__address__risk__code_:0),phone_risk_code(_phone__risk__code_:0),cell_phone_risk_code(_cell__phone__risk__code_:0),work_phone_risk_code(_work__phone__risk__code_:0),bank_account_1_risk_code(_bank__account__1__risk__code_:0),bank_account_2_risk_code(_bank__account__2__risk__code_:0),email_address_risk_code(_email__address__risk__code_:0),ip_address_fraud_code(_ip__address__fraud__code_:0),business_risk_code(_business__risk__code_:0),mailing_address_risk_code(_mailing__address__risk__code_:0),device_risk_code(_device__risk__code_:0),identity_risk_code(_identity__risk__code_:0),dateofbirth(Date_Of_Birth_:DATE),verfirst(_verfirst_:\'\'),verlast(_verlast_:\'\'),veraddr(_veraddr_:\'\'),vercity(_vercity_:\'\'),verstate(_verstate_:\'\'),verzip(_verzip_:\'\'),verzip4(_verzip4_:\'\'),verssn(_verssn_:\'\'),verdob(_verdob_:\'\'),verhphone(_verhphone_:\'\'),verify_addr(_verify__addr_:\'\'),verify_dob(_verify__dob_:\'\'),valid_ssn(_valid__ssn_:\'\'),nas_summary(_nas__summary_:0),nap_summary(_nap__summary_:0),relativeaddressmatch(_relativeaddressmatch_:0),cvi(_cvi_:\'\'),additional_fname_1(_additional__fname__1_:\'\'),additional_lname_1(_additional__lname__1_:\'\'),additional_lname_date_last_1(_additional__lname__date__last__1_:\'\'),additional_fname_2(_additional__fname__2_:\'\'),additional_lname_2(_additional__lname__2_:\'\'),additional_lname_date_last_2(_additional__lname__date__last__2_:\'\'),additional_fname_3(_additional__fname__3_:\'\'),additional_lname_3(_additional__lname__3_:\'\'),additional_lname_date_last_3(_additional__lname__date__last__3_:\'\'),subjectssncount(_subjectssncount_:0|Subject_Ssn_Count_:0),dobmatchlevel(_dobmatchlevel_:\'\'),ssnfoundforlexid(_ssnfoundforlexid_),cvicustomscore(_cvicustomscore_:\'\'),dateofbirthmatchlevel(Date_Of_Birth_Match_Level_:0),stolenidentityindex(Stolen_Identity_Index_:0),syntheticidentityindex(Synthetic_Identity_Index_:0),manipulatedidentityindex(Manipulated_Identity_Index_:0),vulnerablevictimindex(Vulnerable_Victim_Index_:0),friendlyfraudindex(Friendlyfraud_Index_:0),suspiciousactivityindex(Suspicious_Activity_Index_:0),v2_sourcerisklevel(_v2__sourcerisklevel_:0),v2_assocsuspicousidentitiescount(_v2__assocsuspicousidentitiescount_:0),v2_assoccreditbureauonlycount(_v2__assoccreditbureauonlycount_:0),v2_validationaddrproblems(_v2__validationaddrproblems_:0),v2_inputaddrageoldest(_v2__inputaddrageoldest_:0),v2_inputaddrdwelltype(_v2__inputaddrdwelltype_:\'\'),v2_divssnidentitycountnew(_v2__divssnidentitycountnew_:\'\'),deceaseddate(Deceased_Date_:DATE),deceaseddateofbirth(Deceased_Date_Of_Birth_:DATE),deceasedfirst(Deceased_First_:\'\'),deceasedmiddle(Deceased_Middle_:\'\'),deceasedlast(Deceased_Last_:\'\'),deceasedmatchcode(Deceased_Match_Code_:\'\'),isdeepdive(_isdeepdive_),county_death(_county__death_:\'\'),deceasedssn(Deceased_Ssn_:\'\'),state_death_flag(_state__death__flag_:\'\'),death_rec_src(_death__rec__src_:\'\'),state_death_id(_state__death__id_:\'\'),hri(Hri_:\'\'),ip_address(Ip_Address_:\'\'),iprngbeg(_iprngbeg_:\'\'),iprngend(_iprngend_:\'\'),edgecountry(_edgecountry_:\'\'),edgeregion(_edgeregion_:\'\'),edgecity(_edgecity_:\'\'),edgeconnspeed(_edgeconnspeed_:\'\'),edgemetrocode(_edgemetrocode_:\'\'),edgelatitude(_edgelatitude_:\'\'),edgelongitude(_edgelongitude_:\'\'),edgepostalcode(_edgepostalcode_:\'\'),edgecountrycode(_edgecountrycode_:\'\'),edgeregioncode(_edgeregioncode_:\'\'),edgecitycode(_edgecitycode_:\'\'),edgecontinentcode(_edgecontinentcode_:\'\'),edgetwolettercountry(_edgetwolettercountry_:\'\'),edgeinternalcode(_edgeinternalcode_:\'\'),edgeareacodes(_edgeareacodes_:\'\'),edgecountryconf(_edgecountryconf_:\'\'),edgeregionconf(_edgeregionconf_:\'\'),edgecitycong(_edgecitycong_:\'\'),edgepostalconf(_edgepostalconf_:\'\'),edgegmtoffset(_edgegmtoffset_:\'\'),edgeindst(_edgeindst_:\'\'),siccode(_siccode_:\'\'),domainname(_domainname_:\'\'),ispname(_ispname_:\'\'),homebiztype(_homebiztype_:\'\'),asn(_asn_:\'\'),asnname(_asnname_:\'\'),primarylang(_primarylang_:\'\'),secondarylang(_secondarylang_:\'\'),proxytype(_proxytype_:\'\'),proxydescription(_proxydescription_:\'\'),isanisp(_isanisp_:\'\'),companyname(_companyname_:\'\'),ranks(_ranks_:\'\'),households(_households_:\'\'),women(_women_:\'\'),women18to34(_women18to34_:\'\'),women35to49(_women35to49_:\'\'),men(_men_:\'\'),men18to34(_men18to34_:\'\'),men35to49(_men35to49_:\'\'),teens(_teens_:\'\'),kids(_kids_:\'\'),naicscode(_naicscode_:\'\'),cbsacode(_cbsacode_:\'\'),cbsatitle(_cbsatitle_:\'\'),cbsatype(_cbsatype_:\'\'),csacode(_csacode_:\'\'),csatitle(_csatitle_:\'\'),mdcode(_mdcode_:\'\'),mdtitle(_mdtitle_:\'\'),organizationname(_organizationname_:\'\'),datefirstseen(Date_First_Seen_:EPOCH),datelastseen(Date_Last_Seen_:EPOCH)';
  SHARED __Trimmed := RECORD, MAXLENGTH(5000)
    STRING KeyVal;
  END;
  SHARED __d0_KELfiltered := KELOtto.fraudgovshared((UNSIGNED)record_id > 0);
  SHARED __d0_Trim := PROJECT(__d0_KELfiltered,TRANSFORM(__Trimmed,SELF.KeyVal:=TRIM((STRING)LEFT.AssociatedCustomerFileInfo) + '|' + TRIM((STRING)LEFT.record_id)));
  SHARED __d1_KELfiltered := KELOtto.PersonEventTypes((UNSIGNED)record_id > 0);
  SHARED __d1_Trim := PROJECT(__d1_KELfiltered,TRANSFORM(__Trimmed,SELF.KeyVal:=TRIM((STRING)LEFT.AssociatedCustomerFileInfo) + '|' + TRIM((STRING)LEFT.record_id)));
  EXPORT __All_Trim := __d0_Trim + __d1_Trim;
  SHARED __TabRec := RECORD, MAXLENGTH(5000)
    __All_Trim.KeyVal;
    UNSIGNED4 Cnt := COUNT(GROUP);
    KEL.typ.uid UID := 0;
  END;
  EXPORT NullKeyVal := TRIM((STRING)'') + '|' + TRIM((STRING)'');
  SHARED __Table := TABLE(__All_Trim(KeyVal <> NullKeyVal),__TabRec,KeyVal,MERGE);
  SHARED NullLookupRec := DATASET([{NullKeyVal,1,0}],__TabRec);
  EXPORT Lookup := NullLookupRec + PROJECT(__Table,TRANSFORM(__TabRec,SELF.UID:=COUNTER,SELF:=LEFT)) : PERSIST('~temp::KEL::KELOtto::Event::UidLookup',EXPIRE(30));
  EXPORT UID_IdToText := INDEX(Lookup,{UID},{Lookup},'~temp::KEL::IDtoT::KELOtto::Event');
  EXPORT UID_TextToId := INDEX(Lookup,{ht:=HASH32(KeyVal)},{Lookup},'~temp::KEL::TtoID::KELOtto::Event');
  EXPORT BuildAll := PARALLEL(BUILDINDEX(UID_IdToText,OVERWRITE),BUILDINDEX(UID_TextToId,OVERWRITE));
  EXPORT GetText(KEL.typ.uid i) := UID_IdToText(UID=i)[1];
  EXPORT GetId(STRING s) := UID_TextToId(ht=HASH32(s),KeyVal=s)[1];
  SHARED __Mapping0 := 'UID(UID),associatedcustomerfileinfo(_r_Customer_:0),sourcecustomerfileinfo(_r_Source_Customer_:0),Subject_(Subject_:0),Location_(Location_:0),record_id(Record_Id_:0),event_date(Event_Date_:DATE),eventtype(Event_Type_:\'\'),confidence_that_activity_was_deceitful_id(Confidence__that__activity__was__deceitful__id_:0),name_risk_code(_name__risk__code_:0),dob_risk_code(_dob__risk__code_:0),ssn_risk_code(_ssn__risk__code_:0),drivers_license_risk_code(_drivers__license__risk__code_:0),physical_address_risk_code(_physical__address__risk__code_:0),phone_risk_code(_phone__risk__code_:0),cell_phone_risk_code(_cell__phone__risk__code_:0),work_phone_risk_code(_work__phone__risk__code_:0),bank_account_1_risk_code(_bank__account__1__risk__code_:0),bank_account_2_risk_code(_bank__account__2__risk__code_:0),email_address_risk_code(_email__address__risk__code_:0),ip_address_fraud_code(_ip__address__fraud__code_:0),business_risk_code(_business__risk__code_:0),mailing_address_risk_code(_mailing__address__risk__code_:0),device_risk_code(_device__risk__code_:0),identity_risk_code(_identity__risk__code_:0),dateofbirth(Date_Of_Birth_:DATE),verfirst(_verfirst_:\'\'),verlast(_verlast_:\'\'),veraddr(_veraddr_:\'\'),vercity(_vercity_:\'\'),verstate(_verstate_:\'\'),verzip(_verzip_:\'\'),verzip4(_verzip4_:\'\'),verssn(_verssn_:\'\'),verdob(_verdob_:\'\'),verhphone(_verhphone_:\'\'),verify_addr(_verify__addr_:\'\'),verify_dob(_verify__dob_:\'\'),valid_ssn(_valid__ssn_:\'\'),nas_summary(_nas__summary_:0),nap_summary(_nap__summary_:0),relativeaddressmatch(_relativeaddressmatch_:0),cvi(_cvi_:\'\'),additional_fname_1(_additional__fname__1_:\'\'),additional_lname_1(_additional__lname__1_:\'\'),additional_lname_date_last_1(_additional__lname__date__last__1_:\'\'),additional_fname_2(_additional__fname__2_:\'\'),additional_lname_2(_additional__lname__2_:\'\'),additional_lname_date_last_2(_additional__lname__date__last__2_:\'\'),additional_fname_3(_additional__fname__3_:\'\'),additional_lname_3(_additional__lname__3_:\'\'),additional_lname_date_last_3(_additional__lname__date__last__3_:\'\'),subjectssncount(_subjectssncount_:0|Subject_Ssn_Count_:0),dobmatchlevel(_dobmatchlevel_:\'\'),ssnfoundforlexid(_ssnfoundforlexid_),cvicustomscore(_cvicustomscore_:\'\'),dateofbirthmatchlevel(Date_Of_Birth_Match_Level_:0),stolenidentityindex(Stolen_Identity_Index_:0),syntheticidentityindex(Synthetic_Identity_Index_:0),manipulatedidentityindex(Manipulated_Identity_Index_:0),vulnerablevictimindex(Vulnerable_Victim_Index_:0),friendlyfraudindex(Friendlyfraud_Index_:0),suspiciousactivityindex(Suspicious_Activity_Index_:0),v2_sourcerisklevel(_v2__sourcerisklevel_:0),v2_assocsuspicousidentitiescount(_v2__assocsuspicousidentitiescount_:0),v2_assoccreditbureauonlycount(_v2__assoccreditbureauonlycount_:0),v2_validationaddrproblems(_v2__validationaddrproblems_:0),v2_inputaddrageoldest(_v2__inputaddrageoldest_:0),v2_inputaddrdwelltype(_v2__inputaddrdwelltype_:\'\'),v2_divssnidentitycountnew(_v2__divssnidentitycountnew_:\'\'),deceaseddate(Deceased_Date_:DATE),deceaseddateofbirth(Deceased_Date_Of_Birth_:DATE),deceasedfirst(Deceased_First_:\'\'),deceasedmiddle(Deceased_Middle_:\'\'),deceasedlast(Deceased_Last_:\'\'),deceasedmatchcode(Deceased_Match_Code_:\'\'),isdeepdive(_isdeepdive_),county_death(_county__death_:\'\'),deceasedssn(Deceased_Ssn_:\'\'),state_death_flag(_state__death__flag_:\'\'),death_rec_src(_death__rec__src_:\'\'),state_death_id(_state__death__id_:\'\'),hri(Hri_:\'\'),ip_address(Ip_Address_:\'\'),iprngbeg(_iprngbeg_:\'\'),iprngend(_iprngend_:\'\'),edgecountry(_edgecountry_:\'\'),edgeregion(_edgeregion_:\'\'),edgecity(_edgecity_:\'\'),edgeconnspeed(_edgeconnspeed_:\'\'),edgemetrocode(_edgemetrocode_:\'\'),edgelatitude(_edgelatitude_:\'\'),edgelongitude(_edgelongitude_:\'\'),edgepostalcode(_edgepostalcode_:\'\'),edgecountrycode(_edgecountrycode_:\'\'),edgeregioncode(_edgeregioncode_:\'\'),edgecitycode(_edgecitycode_:\'\'),edgecontinentcode(_edgecontinentcode_:\'\'),edgetwolettercountry(_edgetwolettercountry_:\'\'),edgeinternalcode(_edgeinternalcode_:\'\'),edgeareacodes(_edgeareacodes_:\'\'),edgecountryconf(_edgecountryconf_:\'\'),edgeregionconf(_edgeregionconf_:\'\'),edgecitycong(_edgecitycong_:\'\'),edgepostalconf(_edgepostalconf_:\'\'),edgegmtoffset(_edgegmtoffset_:\'\'),edgeindst(_edgeindst_:\'\'),siccode(_siccode_:\'\'),domainname(_domainname_:\'\'),ispname(_ispname_:\'\'),homebiztype(_homebiztype_:\'\'),asn(_asn_:\'\'),asnname(_asnname_:\'\'),primarylang(_primarylang_:\'\'),secondarylang(_secondarylang_:\'\'),proxytype(_proxytype_:\'\'),proxydescription(_proxydescription_:\'\'),isanisp(_isanisp_:\'\'),companyname(_companyname_:\'\'),ranks(_ranks_:\'\'),households(_households_:\'\'),women(_women_:\'\'),women18to34(_women18to34_:\'\'),women35to49(_women35to49_:\'\'),men(_men_:\'\'),men18to34(_men18to34_:\'\'),men35to49(_men35to49_:\'\'),teens(_teens_:\'\'),kids(_kids_:\'\'),naicscode(_naicscode_:\'\'),cbsacode(_cbsacode_:\'\'),cbsatitle(_cbsatitle_:\'\'),cbsatype(_cbsatype_:\'\'),csacode(_csacode_:\'\'),csatitle(_csatitle_:\'\'),mdcode(_mdcode_:\'\'),mdtitle(_mdtitle_:\'\'),organizationname(_organizationname_:\'\'),datefirstseen(Date_First_Seen_:EPOCH),datelastseen(Date_Last_Seen_:EPOCH)';
  SHARED __d0_Out := RECORD
    RECORDOF(KELOtto.fraudgovshared);
    KEL.typ.uid UID := 0;
  END;
  SHARED __d0_UID_Mapped := JOIN(__d0_KELfiltered,Lookup,TRIM((STRING)LEFT.AssociatedCustomerFileInfo) + '|' + TRIM((STRING)LEFT.record_id) = RIGHT.KeyVal,TRANSFORM(__d0_Out,SELF.UID:=RIGHT.UID,SELF:=LEFT),HASH);
  SHARED __d0_Subject__Layout := RECORD
    RECORDOF(__d0_UID_Mapped);
    KEL.typ.uid Subject_;
  END;
  SHARED __d0_Subject__Mapped := JOIN(__d0_UID_Mapped,E_Person.Lookup,TRIM((STRING)LEFT.AssociatedCustomerFileInfo) + '|' + TRIM((STRING)LEFT.did) = RIGHT.KeyVal,TRANSFORM(__d0_Subject__Layout,SELF.Subject_:=RIGHT.UID,SELF:=LEFT),LEFT OUTER,HASH);
  SHARED __d0_Location__Layout := RECORD
    RECORDOF(__d0_Subject__Mapped);
    KEL.typ.uid Location_;
  END;
  SHARED __d0_Location__Mapped := JOIN(__d0_Subject__Mapped,E_Address.Lookup,TRIM((STRING)LEFT.AssociatedCustomerFileInfo) + '|' + TRIM((STRING)LEFT.clean_address.prim_range) + '|' + TRIM((STRING)LEFT.clean_address.predir) + '|' + TRIM((STRING)LEFT.clean_address.prim_name) + '|' + TRIM((STRING)LEFT.clean_address.addr_suffix) + '|' + TRIM((STRING)LEFT.clean_address.postdir) + '|' + TRIM((STRING)LEFT.clean_address.zip) + '|' + TRIM((STRING)LEFT.clean_address.sec_range) = RIGHT.KeyVal,TRANSFORM(__d0_Location__Layout,SELF.Location_:=RIGHT.UID,SELF:=LEFT),LEFT OUTER,HASH);
  EXPORT KELOtto_fraudgovshared_Invalid := __d0_Location__Mapped(UID = 0);
  SHARED __d0_Prefiltered := __d0_Location__Mapped(UID <> 0);
  SHARED __d0 := __SourceFilter(KEL.FromFlat.Convert(__d0_Prefiltered,InLayout,__Mapping0));
  SHARED __Mapping1 := 'UID(UID),associatedcustomerfileinfo(_r_Customer_:0),sourcecustomerfileinfo(_r_Source_Customer_:0),Subject_(Subject_:0),Location_(Location_:0),record_id(Record_Id_:0),eventdate(Event_Date_:DATE),event_type(Event_Type_:\'\'),confidence_that_activity_was_deceitful_id(Confidence__that__activity__was__deceitful__id_:0),name_risk_code(_name__risk__code_:0),dob_risk_code(_dob__risk__code_:0),ssn_risk_code(_ssn__risk__code_:0),drivers_license_risk_code(_drivers__license__risk__code_:0),physical_address_risk_code(_physical__address__risk__code_:0),phone_risk_code(_phone__risk__code_:0),cell_phone_risk_code(_cell__phone__risk__code_:0),work_phone_risk_code(_work__phone__risk__code_:0),bank_account_1_risk_code(_bank__account__1__risk__code_:0),bank_account_2_risk_code(_bank__account__2__risk__code_:0),email_address_risk_code(_email__address__risk__code_:0),ip_address_fraud_code(_ip__address__fraud__code_:0),business_risk_code(_business__risk__code_:0),mailing_address_risk_code(_mailing__address__risk__code_:0),device_risk_code(_device__risk__code_:0),identity_risk_code(_identity__risk__code_:0),dateofbirth(Date_Of_Birth_:DATE),verfirst(_verfirst_:\'\'),verlast(_verlast_:\'\'),veraddr(_veraddr_:\'\'),vercity(_vercity_:\'\'),verstate(_verstate_:\'\'),verzip(_verzip_:\'\'),verzip4(_verzip4_:\'\'),verssn(_verssn_:\'\'),verdob(_verdob_:\'\'),verhphone(_verhphone_:\'\'),verify_addr(_verify__addr_:\'\'),verify_dob(_verify__dob_:\'\'),valid_ssn(_valid__ssn_:\'\'),nas_summary(_nas__summary_:0),nap_summary(_nap__summary_:0),relativeaddressmatch(_relativeaddressmatch_:0),cvi(_cvi_:\'\'),additional_fname_1(_additional__fname__1_:\'\'),additional_lname_1(_additional__lname__1_:\'\'),additional_lname_date_last_1(_additional__lname__date__last__1_:\'\'),additional_fname_2(_additional__fname__2_:\'\'),additional_lname_2(_additional__lname__2_:\'\'),additional_lname_date_last_2(_additional__lname__date__last__2_:\'\'),additional_fname_3(_additional__fname__3_:\'\'),additional_lname_3(_additional__lname__3_:\'\'),additional_lname_date_last_3(_additional__lname__date__last__3_:\'\'),subjectssncount(_subjectssncount_:0|Subject_Ssn_Count_:0),dobmatchlevel(_dobmatchlevel_:\'\'),ssnfoundforlexid(_ssnfoundforlexid_),cvicustomscore(_cvicustomscore_:\'\'),dateofbirthmatchlevel(Date_Of_Birth_Match_Level_:0),stolenidentityindex(Stolen_Identity_Index_:0),syntheticidentityindex(Synthetic_Identity_Index_:0),manipulatedidentityindex(Manipulated_Identity_Index_:0),vulnerablevictimindex(Vulnerable_Victim_Index_:0),friendlyfraudindex(Friendlyfraud_Index_:0),suspiciousactivityindex(Suspicious_Activity_Index_:0),v2_sourcerisklevel(_v2__sourcerisklevel_:0),v2_assocsuspicousidentitiescount(_v2__assocsuspicousidentitiescount_:0),v2_assoccreditbureauonlycount(_v2__assoccreditbureauonlycount_:0),v2_validationaddrproblems(_v2__validationaddrproblems_:0),v2_inputaddrageoldest(_v2__inputaddrageoldest_:0),v2_inputaddrdwelltype(_v2__inputaddrdwelltype_:\'\'),v2_divssnidentitycountnew(_v2__divssnidentitycountnew_:\'\'),deceaseddate(Deceased_Date_:DATE),deceaseddateofbirth(Deceased_Date_Of_Birth_:DATE),deceasedfirst(Deceased_First_:\'\'),deceasedmiddle(Deceased_Middle_:\'\'),deceasedlast(Deceased_Last_:\'\'),deceasedmatchcode(Deceased_Match_Code_:\'\'),isdeepdive(_isdeepdive_),county_death(_county__death_:\'\'),deceasedssn(Deceased_Ssn_:\'\'),state_death_flag(_state__death__flag_:\'\'),death_rec_src(_death__rec__src_:\'\'),state_death_id(_state__death__id_:\'\'),hri(Hri_:\'\'),ip_address(Ip_Address_:\'\'),iprngbeg(_iprngbeg_:\'\'),iprngend(_iprngend_:\'\'),edgecountry(_edgecountry_:\'\'),edgeregion(_edgeregion_:\'\'),edgecity(_edgecity_:\'\'),edgeconnspeed(_edgeconnspeed_:\'\'),edgemetrocode(_edgemetrocode_:\'\'),edgelatitude(_edgelatitude_:\'\'),edgelongitude(_edgelongitude_:\'\'),edgepostalcode(_edgepostalcode_:\'\'),edgecountrycode(_edgecountrycode_:\'\'),edgeregioncode(_edgeregioncode_:\'\'),edgecitycode(_edgecitycode_:\'\'),edgecontinentcode(_edgecontinentcode_:\'\'),edgetwolettercountry(_edgetwolettercountry_:\'\'),edgeinternalcode(_edgeinternalcode_:\'\'),edgeareacodes(_edgeareacodes_:\'\'),edgecountryconf(_edgecountryconf_:\'\'),edgeregionconf(_edgeregionconf_:\'\'),edgecitycong(_edgecitycong_:\'\'),edgepostalconf(_edgepostalconf_:\'\'),edgegmtoffset(_edgegmtoffset_:\'\'),edgeindst(_edgeindst_:\'\'),siccode(_siccode_:\'\'),domainname(_domainname_:\'\'),ispname(_ispname_:\'\'),homebiztype(_homebiztype_:\'\'),asn(_asn_:\'\'),asnname(_asnname_:\'\'),primarylang(_primarylang_:\'\'),secondarylang(_secondarylang_:\'\'),proxytype(_proxytype_:\'\'),proxydescription(_proxydescription_:\'\'),isanisp(_isanisp_:\'\'),companyname(_companyname_:\'\'),ranks(_ranks_:\'\'),households(_households_:\'\'),women(_women_:\'\'),women18to34(_women18to34_:\'\'),women35to49(_women35to49_:\'\'),men(_men_:\'\'),men18to34(_men18to34_:\'\'),men35to49(_men35to49_:\'\'),teens(_teens_:\'\'),kids(_kids_:\'\'),naicscode(_naicscode_:\'\'),cbsacode(_cbsacode_:\'\'),cbsatitle(_cbsatitle_:\'\'),cbsatype(_cbsatype_:\'\'),csacode(_csacode_:\'\'),csatitle(_csatitle_:\'\'),mdcode(_mdcode_:\'\'),mdtitle(_mdtitle_:\'\'),organizationname(_organizationname_:\'\'),datefirstseen(Date_First_Seen_:EPOCH),datelastseen(Date_Last_Seen_:EPOCH)';
  SHARED __d1_Out := RECORD
    RECORDOF(KELOtto.PersonEventTypes);
    KEL.typ.uid UID := 0;
  END;
  SHARED __d1_UID_Mapped := JOIN(__d1_KELfiltered,Lookup,TRIM((STRING)LEFT.AssociatedCustomerFileInfo) + '|' + TRIM((STRING)LEFT.record_id) = RIGHT.KeyVal,TRANSFORM(__d1_Out,SELF.UID:=RIGHT.UID,SELF:=LEFT),HASH);
  SHARED __d1_Subject__Layout := RECORD
    RECORDOF(__d1_UID_Mapped);
    KEL.typ.uid Subject_;
  END;
  SHARED __d1_Subject__Mapped := JOIN(__d1_UID_Mapped,E_Person.Lookup,TRIM((STRING)LEFT.AssociatedCustomerFileInfo) + '|' + TRIM((STRING)LEFT.LexId) = RIGHT.KeyVal,TRANSFORM(__d1_Subject__Layout,SELF.Subject_:=RIGHT.UID,SELF:=LEFT),LEFT OUTER,HASH);
  SHARED __d1_Location__Layout := RECORD
    RECORDOF(__d1_Subject__Mapped);
    KEL.typ.uid Location_;
  END;
  SHARED __d1_Location__Mapped := JOIN(__d1_Subject__Mapped,E_Address.Lookup,TRIM((STRING)LEFT.AssociatedCustomerFileInfo) + '|' + TRIM((STRING)LEFT.PrimaryRange) + '|' + TRIM((STRING)LEFT.Predirectional) + '|' + TRIM((STRING)LEFT.PrimaryName) + '|' + TRIM((STRING)LEFT.Suffix) + '|' + TRIM((STRING)LEFT.Postdirectional) + '|' + TRIM((STRING)LEFT.Zip) + '|' + TRIM((STRING)LEFT.SecondaryRange) = RIGHT.KeyVal,TRANSFORM(__d1_Location__Layout,SELF.Location_:=RIGHT.UID,SELF:=LEFT),LEFT OUTER,HASH);
  EXPORT KELOtto_PersonEventTypes_Invalid := __d1_Location__Mapped(UID = 0);
  SHARED __d1_Prefiltered := __d1_Location__Mapped(UID <> 0);
  SHARED __d1 := __SourceFilter(KEL.FromFlat.Convert(__d1_Prefiltered,InLayout,__Mapping1));
  EXPORT InData := __d0 + __d1;
  EXPORT Source_Customers_Layout := RECORD
    KEL.typ.ntyp(E_Customer.Typ) _r_Source_Customer_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  EXPORT Event_Types_Layout := RECORD
    KEL.typ.nstr Event_Type_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  EXPORT Hri_List_Layout := RECORD
    KEL.typ.nstr Hri_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  EXPORT Layout := RECORD
    KEL.typ.nuid UID;
    KEL.typ.ntyp(E_Customer.Typ) _r_Customer_;
    KEL.typ.ndataset(Source_Customers_Layout) Source_Customers_;
    KEL.typ.ntyp(E_Person.Typ) Subject_;
    KEL.typ.ntyp(E_Address.Typ) Location_;
    KEL.typ.nint Record_Id_;
    KEL.typ.nkdate Event_Date_;
    KEL.typ.ndataset(Event_Types_Layout) Event_Types_;
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
    KEL.typ.ndataset(Hri_List_Layout) Hri_List_;
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
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  EXPORT __PostFilter := __GroupedFilter(GROUP(DISTRIBUTE(InData,HASH(UID)),UID,LOCAL,ALL));
  Event_Group := __PostFilter;
  Layout Event__Rollup(InLayout __r, DATASET(InLayout) __recs) := TRANSFORM
    SELF._r_Customer_ := KEL.Intake.SingleValue(__recs,_r_Customer_);
    SELF.Source_Customers_ := __CN(PROJECT(TABLE(__recs,{KEL.typ.int __RecordCount := COUNT(GROUP),KEL.typ.epoch Date_First_Seen_ := KEL.era.SimpleRoll(GROUP,Date_First_Seen_,MIN,TRUE),KEL.typ.epoch Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Date_Last_Seen_,MAX,FALSE),_r_Source_Customer_},_r_Source_Customer_),Source_Customers_Layout)(__NN(_r_Source_Customer_)));
    SELF.Subject_ := KEL.Intake.SingleValue(__recs,Subject_);
    SELF.Location_ := KEL.Intake.SingleValue(__recs,Location_);
    SELF.Record_Id_ := KEL.Intake.SingleValue(__recs,Record_Id_);
    SELF.Event_Date_ := KEL.Intake.SingleValue(__recs,Event_Date_);
    SELF.Event_Types_ := __CN(PROJECT(TABLE(__recs,{KEL.typ.int __RecordCount := COUNT(GROUP),KEL.typ.epoch Date_First_Seen_ := KEL.era.SimpleRoll(GROUP,Date_First_Seen_,MIN,TRUE),KEL.typ.epoch Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Date_Last_Seen_,MAX,FALSE),Event_Type_},Event_Type_),Event_Types_Layout)(__NN(Event_Type_)));
    SELF.Date_Of_Birth_ := KEL.Intake.SingleValue(__recs,Date_Of_Birth_);
    SELF.Deceased_Date_ := KEL.Intake.SingleValue(__recs,Deceased_Date_);
    SELF.Deceased_Date_Of_Birth_ := KEL.Intake.SingleValue(__recs,Deceased_Date_Of_Birth_);
    SELF.Deceased_First_ := KEL.Intake.SingleValue(__recs,Deceased_First_);
    SELF.Deceased_Middle_ := KEL.Intake.SingleValue(__recs,Deceased_Middle_);
    SELF.Deceased_Last_ := KEL.Intake.SingleValue(__recs,Deceased_Last_);
    SELF.Deceased_Match_Code_ := KEL.Intake.SingleValue(__recs,Deceased_Match_Code_);
    SELF._isdeepdive_ := KEL.Intake.SingleValue(__recs,_isdeepdive_);
    SELF._county__death_ := KEL.Intake.SingleValue(__recs,_county__death_);
    SELF.Deceased_Ssn_ := KEL.Intake.SingleValue(__recs,Deceased_Ssn_);
    SELF._state__death__flag_ := KEL.Intake.SingleValue(__recs,_state__death__flag_);
    SELF._death__rec__src_ := KEL.Intake.SingleValue(__recs,_death__rec__src_);
    SELF._state__death__id_ := KEL.Intake.SingleValue(__recs,_state__death__id_);
    SELF._verfirst_ := KEL.Intake.SingleValue(__recs,_verfirst_);
    SELF._verlast_ := KEL.Intake.SingleValue(__recs,_verlast_);
    SELF._veraddr_ := KEL.Intake.SingleValue(__recs,_veraddr_);
    SELF._vercity_ := KEL.Intake.SingleValue(__recs,_vercity_);
    SELF._verstate_ := KEL.Intake.SingleValue(__recs,_verstate_);
    SELF._verzip_ := KEL.Intake.SingleValue(__recs,_verzip_);
    SELF._verzip4_ := KEL.Intake.SingleValue(__recs,_verzip4_);
    SELF._verssn_ := KEL.Intake.SingleValue(__recs,_verssn_);
    SELF._verdob_ := KEL.Intake.SingleValue(__recs,_verdob_);
    SELF._verhphone_ := KEL.Intake.SingleValue(__recs,_verhphone_);
    SELF._verify__addr_ := KEL.Intake.SingleValue(__recs,_verify__addr_);
    SELF._verify__dob_ := KEL.Intake.SingleValue(__recs,_verify__dob_);
    SELF._valid__ssn_ := KEL.Intake.SingleValue(__recs,_valid__ssn_);
    SELF._nas__summary_ := KEL.Intake.SingleValue(__recs,_nas__summary_);
    SELF._nap__summary_ := KEL.Intake.SingleValue(__recs,_nap__summary_);
    SELF._relativeaddressmatch_ := KEL.Intake.SingleValue(__recs,_relativeaddressmatch_);
    SELF._cvi_ := KEL.Intake.SingleValue(__recs,_cvi_);
    SELF._additional__fname__1_ := KEL.Intake.SingleValue(__recs,_additional__fname__1_);
    SELF._additional__lname__1_ := KEL.Intake.SingleValue(__recs,_additional__lname__1_);
    SELF._additional__lname__date__last__1_ := KEL.Intake.SingleValue(__recs,_additional__lname__date__last__1_);
    SELF._additional__fname__2_ := KEL.Intake.SingleValue(__recs,_additional__fname__2_);
    SELF._additional__lname__2_ := KEL.Intake.SingleValue(__recs,_additional__lname__2_);
    SELF._additional__lname__date__last__2_ := KEL.Intake.SingleValue(__recs,_additional__lname__date__last__2_);
    SELF._additional__fname__3_ := KEL.Intake.SingleValue(__recs,_additional__fname__3_);
    SELF._additional__lname__3_ := KEL.Intake.SingleValue(__recs,_additional__lname__3_);
    SELF._additional__lname__date__last__3_ := KEL.Intake.SingleValue(__recs,_additional__lname__date__last__3_);
    SELF._subjectssncount_ := KEL.Intake.SingleValue(__recs,_subjectssncount_);
    SELF._dobmatchlevel_ := KEL.Intake.SingleValue(__recs,_dobmatchlevel_);
    SELF._ssnfoundforlexid_ := KEL.Intake.SingleValue(__recs,_ssnfoundforlexid_);
    SELF._cvicustomscore_ := KEL.Intake.SingleValue(__recs,_cvicustomscore_);
    SELF.Subject_Ssn_Count_ := KEL.Intake.SingleValue(__recs,Subject_Ssn_Count_);
    SELF.Date_Of_Birth_Match_Level_ := KEL.Intake.SingleValue(__recs,Date_Of_Birth_Match_Level_);
    SELF.Stolen_Identity_Index_ := KEL.Intake.SingleValue(__recs,Stolen_Identity_Index_);
    SELF.Synthetic_Identity_Index_ := KEL.Intake.SingleValue(__recs,Synthetic_Identity_Index_);
    SELF.Manipulated_Identity_Index_ := KEL.Intake.SingleValue(__recs,Manipulated_Identity_Index_);
    SELF.Vulnerable_Victim_Index_ := KEL.Intake.SingleValue(__recs,Vulnerable_Victim_Index_);
    SELF.Friendlyfraud_Index_ := KEL.Intake.SingleValue(__recs,Friendlyfraud_Index_);
    SELF.Suspicious_Activity_Index_ := KEL.Intake.SingleValue(__recs,Suspicious_Activity_Index_);
    SELF._v2__sourcerisklevel_ := KEL.Intake.SingleValue(__recs,_v2__sourcerisklevel_);
    SELF._v2__assocsuspicousidentitiescount_ := KEL.Intake.SingleValue(__recs,_v2__assocsuspicousidentitiescount_);
    SELF._v2__assoccreditbureauonlycount_ := KEL.Intake.SingleValue(__recs,_v2__assoccreditbureauonlycount_);
    SELF._v2__validationaddrproblems_ := KEL.Intake.SingleValue(__recs,_v2__validationaddrproblems_);
    SELF._v2__inputaddrageoldest_ := KEL.Intake.SingleValue(__recs,_v2__inputaddrageoldest_);
    SELF._v2__inputaddrdwelltype_ := KEL.Intake.SingleValue(__recs,_v2__inputaddrdwelltype_);
    SELF._v2__divssnidentitycountnew_ := KEL.Intake.SingleValue(__recs,_v2__divssnidentitycountnew_);
    SELF.Hri_List_ := __CN(PROJECT(TABLE(__recs,{KEL.typ.int __RecordCount := COUNT(GROUP),KEL.typ.epoch Date_First_Seen_ := KEL.era.SimpleRoll(GROUP,Date_First_Seen_,MIN,TRUE),KEL.typ.epoch Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Date_Last_Seen_,MAX,FALSE),Hri_},Hri_),Hri_List_Layout)(__NN(Hri_)));
    SELF.Ip_Address_ := KEL.Intake.SingleValue(__recs,Ip_Address_);
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
    SELF.Confidence__that__activity__was__deceitful__id_ := KEL.Intake.SingleValue(__recs,Confidence__that__activity__was__deceitful__id_);
    SELF._name__risk__code_ := KEL.Intake.SingleValue(__recs,_name__risk__code_);
    SELF._dob__risk__code_ := KEL.Intake.SingleValue(__recs,_dob__risk__code_);
    SELF._ssn__risk__code_ := KEL.Intake.SingleValue(__recs,_ssn__risk__code_);
    SELF._drivers__license__risk__code_ := KEL.Intake.SingleValue(__recs,_drivers__license__risk__code_);
    SELF._physical__address__risk__code_ := KEL.Intake.SingleValue(__recs,_physical__address__risk__code_);
    SELF._phone__risk__code_ := KEL.Intake.SingleValue(__recs,_phone__risk__code_);
    SELF._cell__phone__risk__code_ := KEL.Intake.SingleValue(__recs,_cell__phone__risk__code_);
    SELF._work__phone__risk__code_ := KEL.Intake.SingleValue(__recs,_work__phone__risk__code_);
    SELF._bank__account__1__risk__code_ := KEL.Intake.SingleValue(__recs,_bank__account__1__risk__code_);
    SELF._bank__account__2__risk__code_ := KEL.Intake.SingleValue(__recs,_bank__account__2__risk__code_);
    SELF._email__address__risk__code_ := KEL.Intake.SingleValue(__recs,_email__address__risk__code_);
    SELF._ip__address__fraud__code_ := KEL.Intake.SingleValue(__recs,_ip__address__fraud__code_);
    SELF._business__risk__code_ := KEL.Intake.SingleValue(__recs,_business__risk__code_);
    SELF._mailing__address__risk__code_ := KEL.Intake.SingleValue(__recs,_mailing__address__risk__code_);
    SELF._device__risk__code_ := KEL.Intake.SingleValue(__recs,_device__risk__code_);
    SELF._identity__risk__code_ := KEL.Intake.SingleValue(__recs,_identity__risk__code_);
    SELF.__RecordCount := COUNT(__recs);
    SELF.Date_First_Seen_ := KEL.era.SimpleRoll(__recs,Date_First_Seen_,MIN,TRUE);
    SELF.Date_Last_Seen_ := KEL.era.SimpleRoll(__recs,Date_Last_Seen_,MAX,FALSE);
    SELF := __r;
  END;
  Layout Event__Single_Rollup(InLayout __r) := TRANSFORM
    SELF.Source_Customers_ := __CN(PROJECT(DATASET(__r),TRANSFORM(Source_Customers_Layout,SELF.__RecordCount:=1;,SELF:=LEFT))(__NN(_r_Source_Customer_)));
    SELF.Event_Types_ := __CN(PROJECT(DATASET(__r),TRANSFORM(Event_Types_Layout,SELF.__RecordCount:=1;,SELF:=LEFT))(__NN(Event_Type_)));
    SELF.Hri_List_ := __CN(PROJECT(DATASET(__r),TRANSFORM(Hri_List_Layout,SELF.__RecordCount:=1;,SELF:=LEFT))(__NN(Hri_)));
    SELF.__RecordCount := 1;
    SELF := __r;
  END;
  EXPORT __PreResult := ROLLUP(HAVING(Event_Group,COUNT(ROWS(LEFT))=1),GROUP,Event__Single_Rollup(LEFT)) + ROLLUP(HAVING(Event_Group,COUNT(ROWS(LEFT))>1),GROUP,Event__Rollup(LEFT, ROWS(LEFT)));
  EXPORT __Result := __CLEARFLAGS(__PreResult) : PERSIST('~temp::KEL::KELOtto::Event::Result',EXPIRE(30));
  EXPORT Result := __UNWRAP(__Result);
  EXPORT _r_Customer__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,_r_Customer_);
  EXPORT Subject__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Subject_);
  EXPORT Location__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Location_);
  EXPORT Record_Id__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Record_Id_);
  EXPORT Event_Date__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Event_Date_);
  EXPORT Date_Of_Birth__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Date_Of_Birth_);
  EXPORT Deceased_Date__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Deceased_Date_);
  EXPORT Deceased_Date_Of_Birth__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Deceased_Date_Of_Birth_);
  EXPORT Deceased_First__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Deceased_First_);
  EXPORT Deceased_Middle__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Deceased_Middle_);
  EXPORT Deceased_Last__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Deceased_Last_);
  EXPORT Deceased_Match_Code__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Deceased_Match_Code_);
  EXPORT _isdeepdive__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,_isdeepdive_);
  EXPORT _county__death__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,_county__death_);
  EXPORT Deceased_Ssn__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Deceased_Ssn_);
  EXPORT _state__death__flag__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,_state__death__flag_);
  EXPORT _death__rec__src__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,_death__rec__src_);
  EXPORT _state__death__id__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,_state__death__id_);
  EXPORT _verfirst__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,_verfirst_);
  EXPORT _verlast__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,_verlast_);
  EXPORT _veraddr__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,_veraddr_);
  EXPORT _vercity__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,_vercity_);
  EXPORT _verstate__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,_verstate_);
  EXPORT _verzip__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,_verzip_);
  EXPORT _verzip4__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,_verzip4_);
  EXPORT _verssn__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,_verssn_);
  EXPORT _verdob__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,_verdob_);
  EXPORT _verhphone__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,_verhphone_);
  EXPORT _verify__addr__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,_verify__addr_);
  EXPORT _verify__dob__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,_verify__dob_);
  EXPORT _valid__ssn__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,_valid__ssn_);
  EXPORT _nas__summary__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,_nas__summary_);
  EXPORT _nap__summary__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,_nap__summary_);
  EXPORT _relativeaddressmatch__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,_relativeaddressmatch_);
  EXPORT _cvi__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,_cvi_);
  EXPORT _additional__fname__1__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,_additional__fname__1_);
  EXPORT _additional__lname__1__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,_additional__lname__1_);
  EXPORT _additional__lname__date__last__1__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,_additional__lname__date__last__1_);
  EXPORT _additional__fname__2__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,_additional__fname__2_);
  EXPORT _additional__lname__2__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,_additional__lname__2_);
  EXPORT _additional__lname__date__last__2__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,_additional__lname__date__last__2_);
  EXPORT _additional__fname__3__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,_additional__fname__3_);
  EXPORT _additional__lname__3__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,_additional__lname__3_);
  EXPORT _additional__lname__date__last__3__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,_additional__lname__date__last__3_);
  EXPORT _subjectssncount__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,_subjectssncount_);
  EXPORT _dobmatchlevel__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,_dobmatchlevel_);
  EXPORT _ssnfoundforlexid__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,_ssnfoundforlexid_);
  EXPORT _cvicustomscore__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,_cvicustomscore_);
  EXPORT Subject_Ssn_Count__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Subject_Ssn_Count_);
  EXPORT Date_Of_Birth_Match_Level__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Date_Of_Birth_Match_Level_);
  EXPORT Stolen_Identity_Index__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Stolen_Identity_Index_);
  EXPORT Synthetic_Identity_Index__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Synthetic_Identity_Index_);
  EXPORT Manipulated_Identity_Index__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Manipulated_Identity_Index_);
  EXPORT Vulnerable_Victim_Index__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Vulnerable_Victim_Index_);
  EXPORT Friendlyfraud_Index__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Friendlyfraud_Index_);
  EXPORT Suspicious_Activity_Index__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Suspicious_Activity_Index_);
  EXPORT _v2__sourcerisklevel__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,_v2__sourcerisklevel_);
  EXPORT _v2__assocsuspicousidentitiescount__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,_v2__assocsuspicousidentitiescount_);
  EXPORT _v2__assoccreditbureauonlycount__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,_v2__assoccreditbureauonlycount_);
  EXPORT _v2__validationaddrproblems__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,_v2__validationaddrproblems_);
  EXPORT _v2__inputaddrageoldest__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,_v2__inputaddrageoldest_);
  EXPORT _v2__inputaddrdwelltype__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,_v2__inputaddrdwelltype_);
  EXPORT _v2__divssnidentitycountnew__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,_v2__divssnidentitycountnew_);
  EXPORT Ip_Address__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Ip_Address_);
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
  EXPORT Confidence__that__activity__was__deceitful__id__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Confidence__that__activity__was__deceitful__id_);
  EXPORT _name__risk__code__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,_name__risk__code_);
  EXPORT _dob__risk__code__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,_dob__risk__code_);
  EXPORT _ssn__risk__code__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,_ssn__risk__code_);
  EXPORT _drivers__license__risk__code__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,_drivers__license__risk__code_);
  EXPORT _physical__address__risk__code__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,_physical__address__risk__code_);
  EXPORT _phone__risk__code__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,_phone__risk__code_);
  EXPORT _cell__phone__risk__code__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,_cell__phone__risk__code_);
  EXPORT _work__phone__risk__code__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,_work__phone__risk__code_);
  EXPORT _bank__account__1__risk__code__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,_bank__account__1__risk__code_);
  EXPORT _bank__account__2__risk__code__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,_bank__account__2__risk__code_);
  EXPORT _email__address__risk__code__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,_email__address__risk__code_);
  EXPORT _ip__address__fraud__code__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,_ip__address__fraud__code_);
  EXPORT _business__risk__code__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,_business__risk__code_);
  EXPORT _mailing__address__risk__code__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,_mailing__address__risk__code_);
  EXPORT _device__risk__code__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,_device__risk__code_);
  EXPORT _identity__risk__code__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,_identity__risk__code_);
  EXPORT _r_Customer__Orphan := JOIN(InData(__NN(_r_Customer_)),E_Customer.__Result,__EEQP(LEFT._r_Customer_, RIGHT.UID),TRANSFORM(InLayout,SELF := LEFT,SELF:=[]),LEFT ONLY, HASH);
  EXPORT _r_Source_Customer__Orphan := JOIN(InData(__NN(_r_Source_Customer_)),E_Customer.__Result,__EEQP(LEFT._r_Source_Customer_, RIGHT.UID),TRANSFORM(InLayout,SELF := LEFT,SELF:=[]),LEFT ONLY, HASH);
  EXPORT Subject__Orphan := JOIN(InData(__NN(Subject_)),E_Person.__Result,__EEQP(LEFT.Subject_, RIGHT.UID),TRANSFORM(InLayout,SELF := LEFT,SELF:=[]),LEFT ONLY, HASH);
  EXPORT Location__Orphan := JOIN(InData(__NN(Location_)),E_Address.__Result,__EEQP(LEFT.Location_, RIGHT.UID),TRANSFORM(InLayout,SELF := LEFT,SELF:=[]),LEFT ONLY, HASH);
  EXPORT SanityCheck := DATASET([{COUNT(_r_Customer__Orphan),COUNT(_r_Source_Customer__Orphan),COUNT(Subject__Orphan),COUNT(Location__Orphan),COUNT(KELOtto_fraudgovshared_Invalid),COUNT(KELOtto_PersonEventTypes_Invalid),COUNT(_r_Customer__SingleValue_Invalid),COUNT(Subject__SingleValue_Invalid),COUNT(Location__SingleValue_Invalid),COUNT(Record_Id__SingleValue_Invalid),COUNT(Event_Date__SingleValue_Invalid),COUNT(Date_Of_Birth__SingleValue_Invalid),COUNT(Deceased_Date__SingleValue_Invalid),COUNT(Deceased_Date_Of_Birth__SingleValue_Invalid),COUNT(Deceased_First__SingleValue_Invalid),COUNT(Deceased_Middle__SingleValue_Invalid),COUNT(Deceased_Last__SingleValue_Invalid),COUNT(Deceased_Match_Code__SingleValue_Invalid),COUNT(_isdeepdive__SingleValue_Invalid),COUNT(_county__death__SingleValue_Invalid),COUNT(Deceased_Ssn__SingleValue_Invalid),COUNT(_state__death__flag__SingleValue_Invalid),COUNT(_death__rec__src__SingleValue_Invalid),COUNT(_state__death__id__SingleValue_Invalid),COUNT(_verfirst__SingleValue_Invalid),COUNT(_verlast__SingleValue_Invalid),COUNT(_veraddr__SingleValue_Invalid),COUNT(_vercity__SingleValue_Invalid),COUNT(_verstate__SingleValue_Invalid),COUNT(_verzip__SingleValue_Invalid),COUNT(_verzip4__SingleValue_Invalid),COUNT(_verssn__SingleValue_Invalid),COUNT(_verdob__SingleValue_Invalid),COUNT(_verhphone__SingleValue_Invalid),COUNT(_verify__addr__SingleValue_Invalid),COUNT(_verify__dob__SingleValue_Invalid),COUNT(_valid__ssn__SingleValue_Invalid),COUNT(_nas__summary__SingleValue_Invalid),COUNT(_nap__summary__SingleValue_Invalid),COUNT(_relativeaddressmatch__SingleValue_Invalid),COUNT(_cvi__SingleValue_Invalid),COUNT(_additional__fname__1__SingleValue_Invalid),COUNT(_additional__lname__1__SingleValue_Invalid),COUNT(_additional__lname__date__last__1__SingleValue_Invalid),COUNT(_additional__fname__2__SingleValue_Invalid),COUNT(_additional__lname__2__SingleValue_Invalid),COUNT(_additional__lname__date__last__2__SingleValue_Invalid),COUNT(_additional__fname__3__SingleValue_Invalid),COUNT(_additional__lname__3__SingleValue_Invalid),COUNT(_additional__lname__date__last__3__SingleValue_Invalid),COUNT(_subjectssncount__SingleValue_Invalid),COUNT(_dobmatchlevel__SingleValue_Invalid),COUNT(_ssnfoundforlexid__SingleValue_Invalid),COUNT(_cvicustomscore__SingleValue_Invalid),COUNT(Subject_Ssn_Count__SingleValue_Invalid),COUNT(Date_Of_Birth_Match_Level__SingleValue_Invalid),COUNT(Stolen_Identity_Index__SingleValue_Invalid),COUNT(Synthetic_Identity_Index__SingleValue_Invalid),COUNT(Manipulated_Identity_Index__SingleValue_Invalid),COUNT(Vulnerable_Victim_Index__SingleValue_Invalid),COUNT(Friendlyfraud_Index__SingleValue_Invalid),COUNT(Suspicious_Activity_Index__SingleValue_Invalid),COUNT(_v2__sourcerisklevel__SingleValue_Invalid),COUNT(_v2__assocsuspicousidentitiescount__SingleValue_Invalid),COUNT(_v2__assoccreditbureauonlycount__SingleValue_Invalid),COUNT(_v2__validationaddrproblems__SingleValue_Invalid),COUNT(_v2__inputaddrageoldest__SingleValue_Invalid),COUNT(_v2__inputaddrdwelltype__SingleValue_Invalid),COUNT(_v2__divssnidentitycountnew__SingleValue_Invalid),COUNT(Ip_Address__SingleValue_Invalid),COUNT(_iprngbeg__SingleValue_Invalid),COUNT(_iprngend__SingleValue_Invalid),COUNT(_edgecountry__SingleValue_Invalid),COUNT(_edgeregion__SingleValue_Invalid),COUNT(_edgecity__SingleValue_Invalid),COUNT(_edgeconnspeed__SingleValue_Invalid),COUNT(_edgemetrocode__SingleValue_Invalid),COUNT(_edgelatitude__SingleValue_Invalid),COUNT(_edgelongitude__SingleValue_Invalid),COUNT(_edgepostalcode__SingleValue_Invalid),COUNT(_edgecountrycode__SingleValue_Invalid),COUNT(_edgeregioncode__SingleValue_Invalid),COUNT(_edgecitycode__SingleValue_Invalid),COUNT(_edgecontinentcode__SingleValue_Invalid),COUNT(_edgetwolettercountry__SingleValue_Invalid),COUNT(_edgeinternalcode__SingleValue_Invalid),COUNT(_edgeareacodes__SingleValue_Invalid),COUNT(_edgecountryconf__SingleValue_Invalid),COUNT(_edgeregionconf__SingleValue_Invalid),COUNT(_edgecitycong__SingleValue_Invalid),COUNT(_edgepostalconf__SingleValue_Invalid),COUNT(_edgegmtoffset__SingleValue_Invalid),COUNT(_edgeindst__SingleValue_Invalid),COUNT(_siccode__SingleValue_Invalid),COUNT(_domainname__SingleValue_Invalid),COUNT(_ispname__SingleValue_Invalid),COUNT(_homebiztype__SingleValue_Invalid),COUNT(_asn__SingleValue_Invalid),COUNT(_asnname__SingleValue_Invalid),COUNT(_primarylang__SingleValue_Invalid),COUNT(_secondarylang__SingleValue_Invalid),COUNT(_proxytype__SingleValue_Invalid),COUNT(_proxydescription__SingleValue_Invalid),COUNT(_isanisp__SingleValue_Invalid),COUNT(_companyname__SingleValue_Invalid),COUNT(_ranks__SingleValue_Invalid),COUNT(_households__SingleValue_Invalid),COUNT(_women__SingleValue_Invalid),COUNT(_women18to34__SingleValue_Invalid),COUNT(_women35to49__SingleValue_Invalid),COUNT(_men__SingleValue_Invalid),COUNT(_men18to34__SingleValue_Invalid),COUNT(_men35to49__SingleValue_Invalid),COUNT(_teens__SingleValue_Invalid),COUNT(_kids__SingleValue_Invalid),COUNT(_naicscode__SingleValue_Invalid),COUNT(_cbsacode__SingleValue_Invalid),COUNT(_cbsatitle__SingleValue_Invalid),COUNT(_cbsatype__SingleValue_Invalid),COUNT(_csacode__SingleValue_Invalid),COUNT(_csatitle__SingleValue_Invalid),COUNT(_mdcode__SingleValue_Invalid),COUNT(_mdtitle__SingleValue_Invalid),COUNT(_organizationname__SingleValue_Invalid),COUNT(Confidence__that__activity__was__deceitful__id__SingleValue_Invalid),COUNT(_name__risk__code__SingleValue_Invalid),COUNT(_dob__risk__code__SingleValue_Invalid),COUNT(_ssn__risk__code__SingleValue_Invalid),COUNT(_drivers__license__risk__code__SingleValue_Invalid),COUNT(_physical__address__risk__code__SingleValue_Invalid),COUNT(_phone__risk__code__SingleValue_Invalid),COUNT(_cell__phone__risk__code__SingleValue_Invalid),COUNT(_work__phone__risk__code__SingleValue_Invalid),COUNT(_bank__account__1__risk__code__SingleValue_Invalid),COUNT(_bank__account__2__risk__code__SingleValue_Invalid),COUNT(_email__address__risk__code__SingleValue_Invalid),COUNT(_ip__address__fraud__code__SingleValue_Invalid),COUNT(_business__risk__code__SingleValue_Invalid),COUNT(_mailing__address__risk__code__SingleValue_Invalid),COUNT(_device__risk__code__SingleValue_Invalid),COUNT(_identity__risk__code__SingleValue_Invalid)}],{KEL.typ.int _r_Customer__Orphan,KEL.typ.int _r_Source_Customer__Orphan,KEL.typ.int Subject__Orphan,KEL.typ.int Location__Orphan,KEL.typ.int KELOtto_fraudgovshared_Invalid,KEL.typ.int KELOtto_PersonEventTypes_Invalid,KEL.typ.int _r_Customer__SingleValue_Invalid,KEL.typ.int Subject__SingleValue_Invalid,KEL.typ.int Location__SingleValue_Invalid,KEL.typ.int Record_Id__SingleValue_Invalid,KEL.typ.int Event_Date__SingleValue_Invalid,KEL.typ.int Date_Of_Birth__SingleValue_Invalid,KEL.typ.int Deceased_Date__SingleValue_Invalid,KEL.typ.int Deceased_Date_Of_Birth__SingleValue_Invalid,KEL.typ.int Deceased_First__SingleValue_Invalid,KEL.typ.int Deceased_Middle__SingleValue_Invalid,KEL.typ.int Deceased_Last__SingleValue_Invalid,KEL.typ.int Deceased_Match_Code__SingleValue_Invalid,KEL.typ.int _isdeepdive__SingleValue_Invalid,KEL.typ.int _county__death__SingleValue_Invalid,KEL.typ.int Deceased_Ssn__SingleValue_Invalid,KEL.typ.int _state__death__flag__SingleValue_Invalid,KEL.typ.int _death__rec__src__SingleValue_Invalid,KEL.typ.int _state__death__id__SingleValue_Invalid,KEL.typ.int _verfirst__SingleValue_Invalid,KEL.typ.int _verlast__SingleValue_Invalid,KEL.typ.int _veraddr__SingleValue_Invalid,KEL.typ.int _vercity__SingleValue_Invalid,KEL.typ.int _verstate__SingleValue_Invalid,KEL.typ.int _verzip__SingleValue_Invalid,KEL.typ.int _verzip4__SingleValue_Invalid,KEL.typ.int _verssn__SingleValue_Invalid,KEL.typ.int _verdob__SingleValue_Invalid,KEL.typ.int _verhphone__SingleValue_Invalid,KEL.typ.int _verify__addr__SingleValue_Invalid,KEL.typ.int _verify__dob__SingleValue_Invalid,KEL.typ.int _valid__ssn__SingleValue_Invalid,KEL.typ.int _nas__summary__SingleValue_Invalid,KEL.typ.int _nap__summary__SingleValue_Invalid,KEL.typ.int _relativeaddressmatch__SingleValue_Invalid,KEL.typ.int _cvi__SingleValue_Invalid,KEL.typ.int _additional__fname__1__SingleValue_Invalid,KEL.typ.int _additional__lname__1__SingleValue_Invalid,KEL.typ.int _additional__lname__date__last__1__SingleValue_Invalid,KEL.typ.int _additional__fname__2__SingleValue_Invalid,KEL.typ.int _additional__lname__2__SingleValue_Invalid,KEL.typ.int _additional__lname__date__last__2__SingleValue_Invalid,KEL.typ.int _additional__fname__3__SingleValue_Invalid,KEL.typ.int _additional__lname__3__SingleValue_Invalid,KEL.typ.int _additional__lname__date__last__3__SingleValue_Invalid,KEL.typ.int _subjectssncount__SingleValue_Invalid,KEL.typ.int _dobmatchlevel__SingleValue_Invalid,KEL.typ.int _ssnfoundforlexid__SingleValue_Invalid,KEL.typ.int _cvicustomscore__SingleValue_Invalid,KEL.typ.int Subject_Ssn_Count__SingleValue_Invalid,KEL.typ.int Date_Of_Birth_Match_Level__SingleValue_Invalid,KEL.typ.int Stolen_Identity_Index__SingleValue_Invalid,KEL.typ.int Synthetic_Identity_Index__SingleValue_Invalid,KEL.typ.int Manipulated_Identity_Index__SingleValue_Invalid,KEL.typ.int Vulnerable_Victim_Index__SingleValue_Invalid,KEL.typ.int Friendlyfraud_Index__SingleValue_Invalid,KEL.typ.int Suspicious_Activity_Index__SingleValue_Invalid,KEL.typ.int _v2__sourcerisklevel__SingleValue_Invalid,KEL.typ.int _v2__assocsuspicousidentitiescount__SingleValue_Invalid,KEL.typ.int _v2__assoccreditbureauonlycount__SingleValue_Invalid,KEL.typ.int _v2__validationaddrproblems__SingleValue_Invalid,KEL.typ.int _v2__inputaddrageoldest__SingleValue_Invalid,KEL.typ.int _v2__inputaddrdwelltype__SingleValue_Invalid,KEL.typ.int _v2__divssnidentitycountnew__SingleValue_Invalid,KEL.typ.int Ip_Address__SingleValue_Invalid,KEL.typ.int _iprngbeg__SingleValue_Invalid,KEL.typ.int _iprngend__SingleValue_Invalid,KEL.typ.int _edgecountry__SingleValue_Invalid,KEL.typ.int _edgeregion__SingleValue_Invalid,KEL.typ.int _edgecity__SingleValue_Invalid,KEL.typ.int _edgeconnspeed__SingleValue_Invalid,KEL.typ.int _edgemetrocode__SingleValue_Invalid,KEL.typ.int _edgelatitude__SingleValue_Invalid,KEL.typ.int _edgelongitude__SingleValue_Invalid,KEL.typ.int _edgepostalcode__SingleValue_Invalid,KEL.typ.int _edgecountrycode__SingleValue_Invalid,KEL.typ.int _edgeregioncode__SingleValue_Invalid,KEL.typ.int _edgecitycode__SingleValue_Invalid,KEL.typ.int _edgecontinentcode__SingleValue_Invalid,KEL.typ.int _edgetwolettercountry__SingleValue_Invalid,KEL.typ.int _edgeinternalcode__SingleValue_Invalid,KEL.typ.int _edgeareacodes__SingleValue_Invalid,KEL.typ.int _edgecountryconf__SingleValue_Invalid,KEL.typ.int _edgeregionconf__SingleValue_Invalid,KEL.typ.int _edgecitycong__SingleValue_Invalid,KEL.typ.int _edgepostalconf__SingleValue_Invalid,KEL.typ.int _edgegmtoffset__SingleValue_Invalid,KEL.typ.int _edgeindst__SingleValue_Invalid,KEL.typ.int _siccode__SingleValue_Invalid,KEL.typ.int _domainname__SingleValue_Invalid,KEL.typ.int _ispname__SingleValue_Invalid,KEL.typ.int _homebiztype__SingleValue_Invalid,KEL.typ.int _asn__SingleValue_Invalid,KEL.typ.int _asnname__SingleValue_Invalid,KEL.typ.int _primarylang__SingleValue_Invalid,KEL.typ.int _secondarylang__SingleValue_Invalid,KEL.typ.int _proxytype__SingleValue_Invalid,KEL.typ.int _proxydescription__SingleValue_Invalid,KEL.typ.int _isanisp__SingleValue_Invalid,KEL.typ.int _companyname__SingleValue_Invalid,KEL.typ.int _ranks__SingleValue_Invalid,KEL.typ.int _households__SingleValue_Invalid,KEL.typ.int _women__SingleValue_Invalid,KEL.typ.int _women18to34__SingleValue_Invalid,KEL.typ.int _women35to49__SingleValue_Invalid,KEL.typ.int _men__SingleValue_Invalid,KEL.typ.int _men18to34__SingleValue_Invalid,KEL.typ.int _men35to49__SingleValue_Invalid,KEL.typ.int _teens__SingleValue_Invalid,KEL.typ.int _kids__SingleValue_Invalid,KEL.typ.int _naicscode__SingleValue_Invalid,KEL.typ.int _cbsacode__SingleValue_Invalid,KEL.typ.int _cbsatitle__SingleValue_Invalid,KEL.typ.int _cbsatype__SingleValue_Invalid,KEL.typ.int _csacode__SingleValue_Invalid,KEL.typ.int _csatitle__SingleValue_Invalid,KEL.typ.int _mdcode__SingleValue_Invalid,KEL.typ.int _mdtitle__SingleValue_Invalid,KEL.typ.int _organizationname__SingleValue_Invalid,KEL.typ.int Confidence__that__activity__was__deceitful__id__SingleValue_Invalid,KEL.typ.int _name__risk__code__SingleValue_Invalid,KEL.typ.int _dob__risk__code__SingleValue_Invalid,KEL.typ.int _ssn__risk__code__SingleValue_Invalid,KEL.typ.int _drivers__license__risk__code__SingleValue_Invalid,KEL.typ.int _physical__address__risk__code__SingleValue_Invalid,KEL.typ.int _phone__risk__code__SingleValue_Invalid,KEL.typ.int _cell__phone__risk__code__SingleValue_Invalid,KEL.typ.int _work__phone__risk__code__SingleValue_Invalid,KEL.typ.int _bank__account__1__risk__code__SingleValue_Invalid,KEL.typ.int _bank__account__2__risk__code__SingleValue_Invalid,KEL.typ.int _email__address__risk__code__SingleValue_Invalid,KEL.typ.int _ip__address__fraud__code__SingleValue_Invalid,KEL.typ.int _business__risk__code__SingleValue_Invalid,KEL.typ.int _mailing__address__risk__code__SingleValue_Invalid,KEL.typ.int _device__risk__code__SingleValue_Invalid,KEL.typ.int _identity__risk__code__SingleValue_Invalid});
  EXPORT NullCounts := DATASET([
    {'Event','KELOtto.fraudgovshared','UID',COUNT(KELOtto_fraudgovshared_Invalid),COUNT(__d0)},
    {'Event','KELOtto.fraudgovshared','AssociatedCustomerFileInfo',COUNT(__d0(__NL(_r_Customer_))),COUNT(__d0(__NN(_r_Customer_)))},
    {'Event','KELOtto.fraudgovshared','SourceCustomerFileInfo',COUNT(__d0(__NL(_r_Source_Customer_))),COUNT(__d0(__NN(_r_Source_Customer_)))},
    {'Event','KELOtto.fraudgovshared','Subject',COUNT(__d0(__NL(Subject_))),COUNT(__d0(__NN(Subject_)))},
    {'Event','KELOtto.fraudgovshared','Location',COUNT(__d0(__NL(Location_))),COUNT(__d0(__NN(Location_)))},
    {'Event','KELOtto.fraudgovshared','record_id',COUNT(__d0(__NL(Record_Id_))),COUNT(__d0(__NN(Record_Id_)))},
    {'Event','KELOtto.fraudgovshared','event_date',COUNT(__d0(__NL(Event_Date_))),COUNT(__d0(__NN(Event_Date_)))},
    {'Event','KELOtto.fraudgovshared','EventType',COUNT(__d0(__NL(Event_Type_))),COUNT(__d0(__NN(Event_Type_)))},
    {'Event','KELOtto.fraudgovshared','Confidence_that_activity_was_deceitful_id',COUNT(__d0(__NL(Confidence__that__activity__was__deceitful__id_))),COUNT(__d0(__NN(Confidence__that__activity__was__deceitful__id_)))},
    {'Event','KELOtto.fraudgovshared','name_risk_code',COUNT(__d0(__NL(_name__risk__code_))),COUNT(__d0(__NN(_name__risk__code_)))},
    {'Event','KELOtto.fraudgovshared','dob_risk_code',COUNT(__d0(__NL(_dob__risk__code_))),COUNT(__d0(__NN(_dob__risk__code_)))},
    {'Event','KELOtto.fraudgovshared','ssn_risk_code',COUNT(__d0(__NL(_ssn__risk__code_))),COUNT(__d0(__NN(_ssn__risk__code_)))},
    {'Event','KELOtto.fraudgovshared','drivers_license_risk_code',COUNT(__d0(__NL(_drivers__license__risk__code_))),COUNT(__d0(__NN(_drivers__license__risk__code_)))},
    {'Event','KELOtto.fraudgovshared','physical_address_risk_code',COUNT(__d0(__NL(_physical__address__risk__code_))),COUNT(__d0(__NN(_physical__address__risk__code_)))},
    {'Event','KELOtto.fraudgovshared','phone_risk_code',COUNT(__d0(__NL(_phone__risk__code_))),COUNT(__d0(__NN(_phone__risk__code_)))},
    {'Event','KELOtto.fraudgovshared','cell_phone_risk_code',COUNT(__d0(__NL(_cell__phone__risk__code_))),COUNT(__d0(__NN(_cell__phone__risk__code_)))},
    {'Event','KELOtto.fraudgovshared','work_phone_risk_code',COUNT(__d0(__NL(_work__phone__risk__code_))),COUNT(__d0(__NN(_work__phone__risk__code_)))},
    {'Event','KELOtto.fraudgovshared','bank_account_1_risk_code',COUNT(__d0(__NL(_bank__account__1__risk__code_))),COUNT(__d0(__NN(_bank__account__1__risk__code_)))},
    {'Event','KELOtto.fraudgovshared','bank_account_2_risk_code',COUNT(__d0(__NL(_bank__account__2__risk__code_))),COUNT(__d0(__NN(_bank__account__2__risk__code_)))},
    {'Event','KELOtto.fraudgovshared','email_address_risk_code',COUNT(__d0(__NL(_email__address__risk__code_))),COUNT(__d0(__NN(_email__address__risk__code_)))},
    {'Event','KELOtto.fraudgovshared','ip_address_fraud_code',COUNT(__d0(__NL(_ip__address__fraud__code_))),COUNT(__d0(__NN(_ip__address__fraud__code_)))},
    {'Event','KELOtto.fraudgovshared','business_risk_code',COUNT(__d0(__NL(_business__risk__code_))),COUNT(__d0(__NN(_business__risk__code_)))},
    {'Event','KELOtto.fraudgovshared','mailing_address_risk_code',COUNT(__d0(__NL(_mailing__address__risk__code_))),COUNT(__d0(__NN(_mailing__address__risk__code_)))},
    {'Event','KELOtto.fraudgovshared','device_risk_code',COUNT(__d0(__NL(_device__risk__code_))),COUNT(__d0(__NN(_device__risk__code_)))},
    {'Event','KELOtto.fraudgovshared','identity_risk_code',COUNT(__d0(__NL(_identity__risk__code_))),COUNT(__d0(__NN(_identity__risk__code_)))},
    {'Event','KELOtto.fraudgovshared','DateOfBirth',COUNT(__d0(__NL(Date_Of_Birth_))),COUNT(__d0(__NN(Date_Of_Birth_)))},
    {'Event','KELOtto.fraudgovshared','verfirst',COUNT(__d0(__NL(_verfirst_))),COUNT(__d0(__NN(_verfirst_)))},
    {'Event','KELOtto.fraudgovshared','verlast',COUNT(__d0(__NL(_verlast_))),COUNT(__d0(__NN(_verlast_)))},
    {'Event','KELOtto.fraudgovshared','veraddr',COUNT(__d0(__NL(_veraddr_))),COUNT(__d0(__NN(_veraddr_)))},
    {'Event','KELOtto.fraudgovshared','vercity',COUNT(__d0(__NL(_vercity_))),COUNT(__d0(__NN(_vercity_)))},
    {'Event','KELOtto.fraudgovshared','verstate',COUNT(__d0(__NL(_verstate_))),COUNT(__d0(__NN(_verstate_)))},
    {'Event','KELOtto.fraudgovshared','verzip',COUNT(__d0(__NL(_verzip_))),COUNT(__d0(__NN(_verzip_)))},
    {'Event','KELOtto.fraudgovshared','verzip4',COUNT(__d0(__NL(_verzip4_))),COUNT(__d0(__NN(_verzip4_)))},
    {'Event','KELOtto.fraudgovshared','verssn',COUNT(__d0(__NL(_verssn_))),COUNT(__d0(__NN(_verssn_)))},
    {'Event','KELOtto.fraudgovshared','verdob',COUNT(__d0(__NL(_verdob_))),COUNT(__d0(__NN(_verdob_)))},
    {'Event','KELOtto.fraudgovshared','verhphone',COUNT(__d0(__NL(_verhphone_))),COUNT(__d0(__NN(_verhphone_)))},
    {'Event','KELOtto.fraudgovshared','verify_addr',COUNT(__d0(__NL(_verify__addr_))),COUNT(__d0(__NN(_verify__addr_)))},
    {'Event','KELOtto.fraudgovshared','verify_dob',COUNT(__d0(__NL(_verify__dob_))),COUNT(__d0(__NN(_verify__dob_)))},
    {'Event','KELOtto.fraudgovshared','valid_ssn',COUNT(__d0(__NL(_valid__ssn_))),COUNT(__d0(__NN(_valid__ssn_)))},
    {'Event','KELOtto.fraudgovshared','nas_summary',COUNT(__d0(__NL(_nas__summary_))),COUNT(__d0(__NN(_nas__summary_)))},
    {'Event','KELOtto.fraudgovshared','nap_summary',COUNT(__d0(__NL(_nap__summary_))),COUNT(__d0(__NN(_nap__summary_)))},
    {'Event','KELOtto.fraudgovshared','relativeaddressmatch',COUNT(__d0(__NL(_relativeaddressmatch_))),COUNT(__d0(__NN(_relativeaddressmatch_)))},
    {'Event','KELOtto.fraudgovshared','cvi',COUNT(__d0(__NL(_cvi_))),COUNT(__d0(__NN(_cvi_)))},
    {'Event','KELOtto.fraudgovshared','additional_fname_1',COUNT(__d0(__NL(_additional__fname__1_))),COUNT(__d0(__NN(_additional__fname__1_)))},
    {'Event','KELOtto.fraudgovshared','additional_lname_1',COUNT(__d0(__NL(_additional__lname__1_))),COUNT(__d0(__NN(_additional__lname__1_)))},
    {'Event','KELOtto.fraudgovshared','additional_lname_date_last_1',COUNT(__d0(__NL(_additional__lname__date__last__1_))),COUNT(__d0(__NN(_additional__lname__date__last__1_)))},
    {'Event','KELOtto.fraudgovshared','additional_fname_2',COUNT(__d0(__NL(_additional__fname__2_))),COUNT(__d0(__NN(_additional__fname__2_)))},
    {'Event','KELOtto.fraudgovshared','additional_lname_2',COUNT(__d0(__NL(_additional__lname__2_))),COUNT(__d0(__NN(_additional__lname__2_)))},
    {'Event','KELOtto.fraudgovshared','additional_lname_date_last_2',COUNT(__d0(__NL(_additional__lname__date__last__2_))),COUNT(__d0(__NN(_additional__lname__date__last__2_)))},
    {'Event','KELOtto.fraudgovshared','additional_fname_3',COUNT(__d0(__NL(_additional__fname__3_))),COUNT(__d0(__NN(_additional__fname__3_)))},
    {'Event','KELOtto.fraudgovshared','additional_lname_3',COUNT(__d0(__NL(_additional__lname__3_))),COUNT(__d0(__NN(_additional__lname__3_)))},
    {'Event','KELOtto.fraudgovshared','additional_lname_date_last_3',COUNT(__d0(__NL(_additional__lname__date__last__3_))),COUNT(__d0(__NN(_additional__lname__date__last__3_)))},
    {'Event','KELOtto.fraudgovshared','subjectssncount',COUNT(__d0(__NL(_subjectssncount_))),COUNT(__d0(__NN(_subjectssncount_)))},
    {'Event','KELOtto.fraudgovshared','dobmatchlevel',COUNT(__d0(__NL(_dobmatchlevel_))),COUNT(__d0(__NN(_dobmatchlevel_)))},
    {'Event','KELOtto.fraudgovshared','ssnfoundforlexid',COUNT(__d0(__NL(_ssnfoundforlexid_))),COUNT(__d0(__NN(_ssnfoundforlexid_)))},
    {'Event','KELOtto.fraudgovshared','cvicustomscore',COUNT(__d0(__NL(_cvicustomscore_))),COUNT(__d0(__NN(_cvicustomscore_)))},
    {'Event','KELOtto.fraudgovshared','SubjectSsnCount',COUNT(__d0(__NL(Subject_Ssn_Count_))),COUNT(__d0(__NN(Subject_Ssn_Count_)))},
    {'Event','KELOtto.fraudgovshared','DateOfBirthMatchLevel',COUNT(__d0(__NL(Date_Of_Birth_Match_Level_))),COUNT(__d0(__NN(Date_Of_Birth_Match_Level_)))},
    {'Event','KELOtto.fraudgovshared','StolenIdentityIndex',COUNT(__d0(__NL(Stolen_Identity_Index_))),COUNT(__d0(__NN(Stolen_Identity_Index_)))},
    {'Event','KELOtto.fraudgovshared','SyntheticIdentityIndex',COUNT(__d0(__NL(Synthetic_Identity_Index_))),COUNT(__d0(__NN(Synthetic_Identity_Index_)))},
    {'Event','KELOtto.fraudgovshared','ManipulatedIdentityIndex',COUNT(__d0(__NL(Manipulated_Identity_Index_))),COUNT(__d0(__NN(Manipulated_Identity_Index_)))},
    {'Event','KELOtto.fraudgovshared','VulnerableVictimIndex',COUNT(__d0(__NL(Vulnerable_Victim_Index_))),COUNT(__d0(__NN(Vulnerable_Victim_Index_)))},
    {'Event','KELOtto.fraudgovshared','FriendlyfraudIndex',COUNT(__d0(__NL(Friendlyfraud_Index_))),COUNT(__d0(__NN(Friendlyfraud_Index_)))},
    {'Event','KELOtto.fraudgovshared','SuspiciousActivityIndex',COUNT(__d0(__NL(Suspicious_Activity_Index_))),COUNT(__d0(__NN(Suspicious_Activity_Index_)))},
    {'Event','KELOtto.fraudgovshared','v2_sourcerisklevel',COUNT(__d0(__NL(_v2__sourcerisklevel_))),COUNT(__d0(__NN(_v2__sourcerisklevel_)))},
    {'Event','KELOtto.fraudgovshared','v2_assocsuspicousidentitiescount',COUNT(__d0(__NL(_v2__assocsuspicousidentitiescount_))),COUNT(__d0(__NN(_v2__assocsuspicousidentitiescount_)))},
    {'Event','KELOtto.fraudgovshared','v2_assoccreditbureauonlycount',COUNT(__d0(__NL(_v2__assoccreditbureauonlycount_))),COUNT(__d0(__NN(_v2__assoccreditbureauonlycount_)))},
    {'Event','KELOtto.fraudgovshared','v2_validationaddrproblems',COUNT(__d0(__NL(_v2__validationaddrproblems_))),COUNT(__d0(__NN(_v2__validationaddrproblems_)))},
    {'Event','KELOtto.fraudgovshared','v2_inputaddrageoldest',COUNT(__d0(__NL(_v2__inputaddrageoldest_))),COUNT(__d0(__NN(_v2__inputaddrageoldest_)))},
    {'Event','KELOtto.fraudgovshared','v2_inputaddrdwelltype',COUNT(__d0(__NL(_v2__inputaddrdwelltype_))),COUNT(__d0(__NN(_v2__inputaddrdwelltype_)))},
    {'Event','KELOtto.fraudgovshared','v2_divssnidentitycountnew',COUNT(__d0(__NL(_v2__divssnidentitycountnew_))),COUNT(__d0(__NN(_v2__divssnidentitycountnew_)))},
    {'Event','KELOtto.fraudgovshared','DeceasedDate',COUNT(__d0(__NL(Deceased_Date_))),COUNT(__d0(__NN(Deceased_Date_)))},
    {'Event','KELOtto.fraudgovshared','DeceasedDateOfBirth',COUNT(__d0(__NL(Deceased_Date_Of_Birth_))),COUNT(__d0(__NN(Deceased_Date_Of_Birth_)))},
    {'Event','KELOtto.fraudgovshared','DeceasedFirst',COUNT(__d0(__NL(Deceased_First_))),COUNT(__d0(__NN(Deceased_First_)))},
    {'Event','KELOtto.fraudgovshared','DeceasedMiddle',COUNT(__d0(__NL(Deceased_Middle_))),COUNT(__d0(__NN(Deceased_Middle_)))},
    {'Event','KELOtto.fraudgovshared','DeceasedLast',COUNT(__d0(__NL(Deceased_Last_))),COUNT(__d0(__NN(Deceased_Last_)))},
    {'Event','KELOtto.fraudgovshared','DeceasedMatchCode',COUNT(__d0(__NL(Deceased_Match_Code_))),COUNT(__d0(__NN(Deceased_Match_Code_)))},
    {'Event','KELOtto.fraudgovshared','isdeepdive',COUNT(__d0(__NL(_isdeepdive_))),COUNT(__d0(__NN(_isdeepdive_)))},
    {'Event','KELOtto.fraudgovshared','county_death',COUNT(__d0(__NL(_county__death_))),COUNT(__d0(__NN(_county__death_)))},
    {'Event','KELOtto.fraudgovshared','DeceasedSsn',COUNT(__d0(__NL(Deceased_Ssn_))),COUNT(__d0(__NN(Deceased_Ssn_)))},
    {'Event','KELOtto.fraudgovshared','state_death_flag',COUNT(__d0(__NL(_state__death__flag_))),COUNT(__d0(__NN(_state__death__flag_)))},
    {'Event','KELOtto.fraudgovshared','death_rec_src',COUNT(__d0(__NL(_death__rec__src_))),COUNT(__d0(__NN(_death__rec__src_)))},
    {'Event','KELOtto.fraudgovshared','state_death_id',COUNT(__d0(__NL(_state__death__id_))),COUNT(__d0(__NN(_state__death__id_)))},
    {'Event','KELOtto.fraudgovshared','Hri',COUNT(__d0(__NL(Hri_))),COUNT(__d0(__NN(Hri_)))},
    {'Event','KELOtto.fraudgovshared','ip_address',COUNT(__d0(__NL(Ip_Address_))),COUNT(__d0(__NN(Ip_Address_)))},
    {'Event','KELOtto.fraudgovshared','iprngbeg',COUNT(__d0(__NL(_iprngbeg_))),COUNT(__d0(__NN(_iprngbeg_)))},
    {'Event','KELOtto.fraudgovshared','iprngend',COUNT(__d0(__NL(_iprngend_))),COUNT(__d0(__NN(_iprngend_)))},
    {'Event','KELOtto.fraudgovshared','edgecountry',COUNT(__d0(__NL(_edgecountry_))),COUNT(__d0(__NN(_edgecountry_)))},
    {'Event','KELOtto.fraudgovshared','edgeregion',COUNT(__d0(__NL(_edgeregion_))),COUNT(__d0(__NN(_edgeregion_)))},
    {'Event','KELOtto.fraudgovshared','edgecity',COUNT(__d0(__NL(_edgecity_))),COUNT(__d0(__NN(_edgecity_)))},
    {'Event','KELOtto.fraudgovshared','edgeconnspeed',COUNT(__d0(__NL(_edgeconnspeed_))),COUNT(__d0(__NN(_edgeconnspeed_)))},
    {'Event','KELOtto.fraudgovshared','edgemetrocode',COUNT(__d0(__NL(_edgemetrocode_))),COUNT(__d0(__NN(_edgemetrocode_)))},
    {'Event','KELOtto.fraudgovshared','edgelatitude',COUNT(__d0(__NL(_edgelatitude_))),COUNT(__d0(__NN(_edgelatitude_)))},
    {'Event','KELOtto.fraudgovshared','edgelongitude',COUNT(__d0(__NL(_edgelongitude_))),COUNT(__d0(__NN(_edgelongitude_)))},
    {'Event','KELOtto.fraudgovshared','edgepostalcode',COUNT(__d0(__NL(_edgepostalcode_))),COUNT(__d0(__NN(_edgepostalcode_)))},
    {'Event','KELOtto.fraudgovshared','edgecountrycode',COUNT(__d0(__NL(_edgecountrycode_))),COUNT(__d0(__NN(_edgecountrycode_)))},
    {'Event','KELOtto.fraudgovshared','edgeregioncode',COUNT(__d0(__NL(_edgeregioncode_))),COUNT(__d0(__NN(_edgeregioncode_)))},
    {'Event','KELOtto.fraudgovshared','edgecitycode',COUNT(__d0(__NL(_edgecitycode_))),COUNT(__d0(__NN(_edgecitycode_)))},
    {'Event','KELOtto.fraudgovshared','edgecontinentcode',COUNT(__d0(__NL(_edgecontinentcode_))),COUNT(__d0(__NN(_edgecontinentcode_)))},
    {'Event','KELOtto.fraudgovshared','edgetwolettercountry',COUNT(__d0(__NL(_edgetwolettercountry_))),COUNT(__d0(__NN(_edgetwolettercountry_)))},
    {'Event','KELOtto.fraudgovshared','edgeinternalcode',COUNT(__d0(__NL(_edgeinternalcode_))),COUNT(__d0(__NN(_edgeinternalcode_)))},
    {'Event','KELOtto.fraudgovshared','edgeareacodes',COUNT(__d0(__NL(_edgeareacodes_))),COUNT(__d0(__NN(_edgeareacodes_)))},
    {'Event','KELOtto.fraudgovshared','edgecountryconf',COUNT(__d0(__NL(_edgecountryconf_))),COUNT(__d0(__NN(_edgecountryconf_)))},
    {'Event','KELOtto.fraudgovshared','edgeregionconf',COUNT(__d0(__NL(_edgeregionconf_))),COUNT(__d0(__NN(_edgeregionconf_)))},
    {'Event','KELOtto.fraudgovshared','edgecitycong',COUNT(__d0(__NL(_edgecitycong_))),COUNT(__d0(__NN(_edgecitycong_)))},
    {'Event','KELOtto.fraudgovshared','edgepostalconf',COUNT(__d0(__NL(_edgepostalconf_))),COUNT(__d0(__NN(_edgepostalconf_)))},
    {'Event','KELOtto.fraudgovshared','edgegmtoffset',COUNT(__d0(__NL(_edgegmtoffset_))),COUNT(__d0(__NN(_edgegmtoffset_)))},
    {'Event','KELOtto.fraudgovshared','edgeindst',COUNT(__d0(__NL(_edgeindst_))),COUNT(__d0(__NN(_edgeindst_)))},
    {'Event','KELOtto.fraudgovshared','siccode',COUNT(__d0(__NL(_siccode_))),COUNT(__d0(__NN(_siccode_)))},
    {'Event','KELOtto.fraudgovshared','domainname',COUNT(__d0(__NL(_domainname_))),COUNT(__d0(__NN(_domainname_)))},
    {'Event','KELOtto.fraudgovshared','ispname',COUNT(__d0(__NL(_ispname_))),COUNT(__d0(__NN(_ispname_)))},
    {'Event','KELOtto.fraudgovshared','homebiztype',COUNT(__d0(__NL(_homebiztype_))),COUNT(__d0(__NN(_homebiztype_)))},
    {'Event','KELOtto.fraudgovshared','asn',COUNT(__d0(__NL(_asn_))),COUNT(__d0(__NN(_asn_)))},
    {'Event','KELOtto.fraudgovshared','asnname',COUNT(__d0(__NL(_asnname_))),COUNT(__d0(__NN(_asnname_)))},
    {'Event','KELOtto.fraudgovshared','primarylang',COUNT(__d0(__NL(_primarylang_))),COUNT(__d0(__NN(_primarylang_)))},
    {'Event','KELOtto.fraudgovshared','secondarylang',COUNT(__d0(__NL(_secondarylang_))),COUNT(__d0(__NN(_secondarylang_)))},
    {'Event','KELOtto.fraudgovshared','proxytype',COUNT(__d0(__NL(_proxytype_))),COUNT(__d0(__NN(_proxytype_)))},
    {'Event','KELOtto.fraudgovshared','proxydescription',COUNT(__d0(__NL(_proxydescription_))),COUNT(__d0(__NN(_proxydescription_)))},
    {'Event','KELOtto.fraudgovshared','isanisp',COUNT(__d0(__NL(_isanisp_))),COUNT(__d0(__NN(_isanisp_)))},
    {'Event','KELOtto.fraudgovshared','companyname',COUNT(__d0(__NL(_companyname_))),COUNT(__d0(__NN(_companyname_)))},
    {'Event','KELOtto.fraudgovshared','ranks',COUNT(__d0(__NL(_ranks_))),COUNT(__d0(__NN(_ranks_)))},
    {'Event','KELOtto.fraudgovshared','households',COUNT(__d0(__NL(_households_))),COUNT(__d0(__NN(_households_)))},
    {'Event','KELOtto.fraudgovshared','women',COUNT(__d0(__NL(_women_))),COUNT(__d0(__NN(_women_)))},
    {'Event','KELOtto.fraudgovshared','women18to34',COUNT(__d0(__NL(_women18to34_))),COUNT(__d0(__NN(_women18to34_)))},
    {'Event','KELOtto.fraudgovshared','women35to49',COUNT(__d0(__NL(_women35to49_))),COUNT(__d0(__NN(_women35to49_)))},
    {'Event','KELOtto.fraudgovshared','men',COUNT(__d0(__NL(_men_))),COUNT(__d0(__NN(_men_)))},
    {'Event','KELOtto.fraudgovshared','men18to34',COUNT(__d0(__NL(_men18to34_))),COUNT(__d0(__NN(_men18to34_)))},
    {'Event','KELOtto.fraudgovshared','men35to49',COUNT(__d0(__NL(_men35to49_))),COUNT(__d0(__NN(_men35to49_)))},
    {'Event','KELOtto.fraudgovshared','teens',COUNT(__d0(__NL(_teens_))),COUNT(__d0(__NN(_teens_)))},
    {'Event','KELOtto.fraudgovshared','kids',COUNT(__d0(__NL(_kids_))),COUNT(__d0(__NN(_kids_)))},
    {'Event','KELOtto.fraudgovshared','naicscode',COUNT(__d0(__NL(_naicscode_))),COUNT(__d0(__NN(_naicscode_)))},
    {'Event','KELOtto.fraudgovshared','cbsacode',COUNT(__d0(__NL(_cbsacode_))),COUNT(__d0(__NN(_cbsacode_)))},
    {'Event','KELOtto.fraudgovshared','cbsatitle',COUNT(__d0(__NL(_cbsatitle_))),COUNT(__d0(__NN(_cbsatitle_)))},
    {'Event','KELOtto.fraudgovshared','cbsatype',COUNT(__d0(__NL(_cbsatype_))),COUNT(__d0(__NN(_cbsatype_)))},
    {'Event','KELOtto.fraudgovshared','csacode',COUNT(__d0(__NL(_csacode_))),COUNT(__d0(__NN(_csacode_)))},
    {'Event','KELOtto.fraudgovshared','csatitle',COUNT(__d0(__NL(_csatitle_))),COUNT(__d0(__NN(_csatitle_)))},
    {'Event','KELOtto.fraudgovshared','mdcode',COUNT(__d0(__NL(_mdcode_))),COUNT(__d0(__NN(_mdcode_)))},
    {'Event','KELOtto.fraudgovshared','mdtitle',COUNT(__d0(__NL(_mdtitle_))),COUNT(__d0(__NN(_mdtitle_)))},
    {'Event','KELOtto.fraudgovshared','organizationname',COUNT(__d0(__NL(_organizationname_))),COUNT(__d0(__NN(_organizationname_)))},
    {'Event','KELOtto.fraudgovshared','DateFirstSeen',COUNT(__d0(Date_First_Seen_=0)),COUNT(__d0(Date_First_Seen_!=0))},
    {'Event','KELOtto.fraudgovshared','DateLastSeen',COUNT(__d0(Date_Last_Seen_=0)),COUNT(__d0(Date_Last_Seen_!=0))},
    {'Event','KELOtto.PersonEventTypes','UID',COUNT(KELOtto_PersonEventTypes_Invalid),COUNT(__d1)},
    {'Event','KELOtto.PersonEventTypes','AssociatedCustomerFileInfo',COUNT(__d1(__NL(_r_Customer_))),COUNT(__d1(__NN(_r_Customer_)))},
    {'Event','KELOtto.PersonEventTypes','SourceCustomerFileInfo',COUNT(__d1(__NL(_r_Source_Customer_))),COUNT(__d1(__NN(_r_Source_Customer_)))},
    {'Event','KELOtto.PersonEventTypes','Subject',COUNT(__d1(__NL(Subject_))),COUNT(__d1(__NN(Subject_)))},
    {'Event','KELOtto.PersonEventTypes','Location',COUNT(__d1(__NL(Location_))),COUNT(__d1(__NN(Location_)))},
    {'Event','KELOtto.PersonEventTypes','record_id',COUNT(__d1(__NL(Record_Id_))),COUNT(__d1(__NN(Record_Id_)))},
    {'Event','KELOtto.PersonEventTypes','EventDate',COUNT(__d1(__NL(Event_Date_))),COUNT(__d1(__NN(Event_Date_)))},
    {'Event','KELOtto.PersonEventTypes','event_type',COUNT(__d1(__NL(Event_Type_))),COUNT(__d1(__NN(Event_Type_)))},
    {'Event','KELOtto.PersonEventTypes','Confidence_that_activity_was_deceitful_id',COUNT(__d1(__NL(Confidence__that__activity__was__deceitful__id_))),COUNT(__d1(__NN(Confidence__that__activity__was__deceitful__id_)))},
    {'Event','KELOtto.PersonEventTypes','name_risk_code',COUNT(__d1(__NL(_name__risk__code_))),COUNT(__d1(__NN(_name__risk__code_)))},
    {'Event','KELOtto.PersonEventTypes','dob_risk_code',COUNT(__d1(__NL(_dob__risk__code_))),COUNT(__d1(__NN(_dob__risk__code_)))},
    {'Event','KELOtto.PersonEventTypes','ssn_risk_code',COUNT(__d1(__NL(_ssn__risk__code_))),COUNT(__d1(__NN(_ssn__risk__code_)))},
    {'Event','KELOtto.PersonEventTypes','drivers_license_risk_code',COUNT(__d1(__NL(_drivers__license__risk__code_))),COUNT(__d1(__NN(_drivers__license__risk__code_)))},
    {'Event','KELOtto.PersonEventTypes','physical_address_risk_code',COUNT(__d1(__NL(_physical__address__risk__code_))),COUNT(__d1(__NN(_physical__address__risk__code_)))},
    {'Event','KELOtto.PersonEventTypes','phone_risk_code',COUNT(__d1(__NL(_phone__risk__code_))),COUNT(__d1(__NN(_phone__risk__code_)))},
    {'Event','KELOtto.PersonEventTypes','cell_phone_risk_code',COUNT(__d1(__NL(_cell__phone__risk__code_))),COUNT(__d1(__NN(_cell__phone__risk__code_)))},
    {'Event','KELOtto.PersonEventTypes','work_phone_risk_code',COUNT(__d1(__NL(_work__phone__risk__code_))),COUNT(__d1(__NN(_work__phone__risk__code_)))},
    {'Event','KELOtto.PersonEventTypes','bank_account_1_risk_code',COUNT(__d1(__NL(_bank__account__1__risk__code_))),COUNT(__d1(__NN(_bank__account__1__risk__code_)))},
    {'Event','KELOtto.PersonEventTypes','bank_account_2_risk_code',COUNT(__d1(__NL(_bank__account__2__risk__code_))),COUNT(__d1(__NN(_bank__account__2__risk__code_)))},
    {'Event','KELOtto.PersonEventTypes','email_address_risk_code',COUNT(__d1(__NL(_email__address__risk__code_))),COUNT(__d1(__NN(_email__address__risk__code_)))},
    {'Event','KELOtto.PersonEventTypes','ip_address_fraud_code',COUNT(__d1(__NL(_ip__address__fraud__code_))),COUNT(__d1(__NN(_ip__address__fraud__code_)))},
    {'Event','KELOtto.PersonEventTypes','business_risk_code',COUNT(__d1(__NL(_business__risk__code_))),COUNT(__d1(__NN(_business__risk__code_)))},
    {'Event','KELOtto.PersonEventTypes','mailing_address_risk_code',COUNT(__d1(__NL(_mailing__address__risk__code_))),COUNT(__d1(__NN(_mailing__address__risk__code_)))},
    {'Event','KELOtto.PersonEventTypes','device_risk_code',COUNT(__d1(__NL(_device__risk__code_))),COUNT(__d1(__NN(_device__risk__code_)))},
    {'Event','KELOtto.PersonEventTypes','identity_risk_code',COUNT(__d1(__NL(_identity__risk__code_))),COUNT(__d1(__NN(_identity__risk__code_)))},
    {'Event','KELOtto.PersonEventTypes','DateOfBirth',COUNT(__d1(__NL(Date_Of_Birth_))),COUNT(__d1(__NN(Date_Of_Birth_)))},
    {'Event','KELOtto.PersonEventTypes','verfirst',COUNT(__d1(__NL(_verfirst_))),COUNT(__d1(__NN(_verfirst_)))},
    {'Event','KELOtto.PersonEventTypes','verlast',COUNT(__d1(__NL(_verlast_))),COUNT(__d1(__NN(_verlast_)))},
    {'Event','KELOtto.PersonEventTypes','veraddr',COUNT(__d1(__NL(_veraddr_))),COUNT(__d1(__NN(_veraddr_)))},
    {'Event','KELOtto.PersonEventTypes','vercity',COUNT(__d1(__NL(_vercity_))),COUNT(__d1(__NN(_vercity_)))},
    {'Event','KELOtto.PersonEventTypes','verstate',COUNT(__d1(__NL(_verstate_))),COUNT(__d1(__NN(_verstate_)))},
    {'Event','KELOtto.PersonEventTypes','verzip',COUNT(__d1(__NL(_verzip_))),COUNT(__d1(__NN(_verzip_)))},
    {'Event','KELOtto.PersonEventTypes','verzip4',COUNT(__d1(__NL(_verzip4_))),COUNT(__d1(__NN(_verzip4_)))},
    {'Event','KELOtto.PersonEventTypes','verssn',COUNT(__d1(__NL(_verssn_))),COUNT(__d1(__NN(_verssn_)))},
    {'Event','KELOtto.PersonEventTypes','verdob',COUNT(__d1(__NL(_verdob_))),COUNT(__d1(__NN(_verdob_)))},
    {'Event','KELOtto.PersonEventTypes','verhphone',COUNT(__d1(__NL(_verhphone_))),COUNT(__d1(__NN(_verhphone_)))},
    {'Event','KELOtto.PersonEventTypes','verify_addr',COUNT(__d1(__NL(_verify__addr_))),COUNT(__d1(__NN(_verify__addr_)))},
    {'Event','KELOtto.PersonEventTypes','verify_dob',COUNT(__d1(__NL(_verify__dob_))),COUNT(__d1(__NN(_verify__dob_)))},
    {'Event','KELOtto.PersonEventTypes','valid_ssn',COUNT(__d1(__NL(_valid__ssn_))),COUNT(__d1(__NN(_valid__ssn_)))},
    {'Event','KELOtto.PersonEventTypes','nas_summary',COUNT(__d1(__NL(_nas__summary_))),COUNT(__d1(__NN(_nas__summary_)))},
    {'Event','KELOtto.PersonEventTypes','nap_summary',COUNT(__d1(__NL(_nap__summary_))),COUNT(__d1(__NN(_nap__summary_)))},
    {'Event','KELOtto.PersonEventTypes','relativeaddressmatch',COUNT(__d1(__NL(_relativeaddressmatch_))),COUNT(__d1(__NN(_relativeaddressmatch_)))},
    {'Event','KELOtto.PersonEventTypes','cvi',COUNT(__d1(__NL(_cvi_))),COUNT(__d1(__NN(_cvi_)))},
    {'Event','KELOtto.PersonEventTypes','additional_fname_1',COUNT(__d1(__NL(_additional__fname__1_))),COUNT(__d1(__NN(_additional__fname__1_)))},
    {'Event','KELOtto.PersonEventTypes','additional_lname_1',COUNT(__d1(__NL(_additional__lname__1_))),COUNT(__d1(__NN(_additional__lname__1_)))},
    {'Event','KELOtto.PersonEventTypes','additional_lname_date_last_1',COUNT(__d1(__NL(_additional__lname__date__last__1_))),COUNT(__d1(__NN(_additional__lname__date__last__1_)))},
    {'Event','KELOtto.PersonEventTypes','additional_fname_2',COUNT(__d1(__NL(_additional__fname__2_))),COUNT(__d1(__NN(_additional__fname__2_)))},
    {'Event','KELOtto.PersonEventTypes','additional_lname_2',COUNT(__d1(__NL(_additional__lname__2_))),COUNT(__d1(__NN(_additional__lname__2_)))},
    {'Event','KELOtto.PersonEventTypes','additional_lname_date_last_2',COUNT(__d1(__NL(_additional__lname__date__last__2_))),COUNT(__d1(__NN(_additional__lname__date__last__2_)))},
    {'Event','KELOtto.PersonEventTypes','additional_fname_3',COUNT(__d1(__NL(_additional__fname__3_))),COUNT(__d1(__NN(_additional__fname__3_)))},
    {'Event','KELOtto.PersonEventTypes','additional_lname_3',COUNT(__d1(__NL(_additional__lname__3_))),COUNT(__d1(__NN(_additional__lname__3_)))},
    {'Event','KELOtto.PersonEventTypes','additional_lname_date_last_3',COUNT(__d1(__NL(_additional__lname__date__last__3_))),COUNT(__d1(__NN(_additional__lname__date__last__3_)))},
    {'Event','KELOtto.PersonEventTypes','subjectssncount',COUNT(__d1(__NL(_subjectssncount_))),COUNT(__d1(__NN(_subjectssncount_)))},
    {'Event','KELOtto.PersonEventTypes','dobmatchlevel',COUNT(__d1(__NL(_dobmatchlevel_))),COUNT(__d1(__NN(_dobmatchlevel_)))},
    {'Event','KELOtto.PersonEventTypes','ssnfoundforlexid',COUNT(__d1(__NL(_ssnfoundforlexid_))),COUNT(__d1(__NN(_ssnfoundforlexid_)))},
    {'Event','KELOtto.PersonEventTypes','cvicustomscore',COUNT(__d1(__NL(_cvicustomscore_))),COUNT(__d1(__NN(_cvicustomscore_)))},
    {'Event','KELOtto.PersonEventTypes','SubjectSsnCount',COUNT(__d1(__NL(Subject_Ssn_Count_))),COUNT(__d1(__NN(Subject_Ssn_Count_)))},
    {'Event','KELOtto.PersonEventTypes','DateOfBirthMatchLevel',COUNT(__d1(__NL(Date_Of_Birth_Match_Level_))),COUNT(__d1(__NN(Date_Of_Birth_Match_Level_)))},
    {'Event','KELOtto.PersonEventTypes','StolenIdentityIndex',COUNT(__d1(__NL(Stolen_Identity_Index_))),COUNT(__d1(__NN(Stolen_Identity_Index_)))},
    {'Event','KELOtto.PersonEventTypes','SyntheticIdentityIndex',COUNT(__d1(__NL(Synthetic_Identity_Index_))),COUNT(__d1(__NN(Synthetic_Identity_Index_)))},
    {'Event','KELOtto.PersonEventTypes','ManipulatedIdentityIndex',COUNT(__d1(__NL(Manipulated_Identity_Index_))),COUNT(__d1(__NN(Manipulated_Identity_Index_)))},
    {'Event','KELOtto.PersonEventTypes','VulnerableVictimIndex',COUNT(__d1(__NL(Vulnerable_Victim_Index_))),COUNT(__d1(__NN(Vulnerable_Victim_Index_)))},
    {'Event','KELOtto.PersonEventTypes','FriendlyfraudIndex',COUNT(__d1(__NL(Friendlyfraud_Index_))),COUNT(__d1(__NN(Friendlyfraud_Index_)))},
    {'Event','KELOtto.PersonEventTypes','SuspiciousActivityIndex',COUNT(__d1(__NL(Suspicious_Activity_Index_))),COUNT(__d1(__NN(Suspicious_Activity_Index_)))},
    {'Event','KELOtto.PersonEventTypes','v2_sourcerisklevel',COUNT(__d1(__NL(_v2__sourcerisklevel_))),COUNT(__d1(__NN(_v2__sourcerisklevel_)))},
    {'Event','KELOtto.PersonEventTypes','v2_assocsuspicousidentitiescount',COUNT(__d1(__NL(_v2__assocsuspicousidentitiescount_))),COUNT(__d1(__NN(_v2__assocsuspicousidentitiescount_)))},
    {'Event','KELOtto.PersonEventTypes','v2_assoccreditbureauonlycount',COUNT(__d1(__NL(_v2__assoccreditbureauonlycount_))),COUNT(__d1(__NN(_v2__assoccreditbureauonlycount_)))},
    {'Event','KELOtto.PersonEventTypes','v2_validationaddrproblems',COUNT(__d1(__NL(_v2__validationaddrproblems_))),COUNT(__d1(__NN(_v2__validationaddrproblems_)))},
    {'Event','KELOtto.PersonEventTypes','v2_inputaddrageoldest',COUNT(__d1(__NL(_v2__inputaddrageoldest_))),COUNT(__d1(__NN(_v2__inputaddrageoldest_)))},
    {'Event','KELOtto.PersonEventTypes','v2_inputaddrdwelltype',COUNT(__d1(__NL(_v2__inputaddrdwelltype_))),COUNT(__d1(__NN(_v2__inputaddrdwelltype_)))},
    {'Event','KELOtto.PersonEventTypes','v2_divssnidentitycountnew',COUNT(__d1(__NL(_v2__divssnidentitycountnew_))),COUNT(__d1(__NN(_v2__divssnidentitycountnew_)))},
    {'Event','KELOtto.PersonEventTypes','DeceasedDate',COUNT(__d1(__NL(Deceased_Date_))),COUNT(__d1(__NN(Deceased_Date_)))},
    {'Event','KELOtto.PersonEventTypes','DeceasedDateOfBirth',COUNT(__d1(__NL(Deceased_Date_Of_Birth_))),COUNT(__d1(__NN(Deceased_Date_Of_Birth_)))},
    {'Event','KELOtto.PersonEventTypes','DeceasedFirst',COUNT(__d1(__NL(Deceased_First_))),COUNT(__d1(__NN(Deceased_First_)))},
    {'Event','KELOtto.PersonEventTypes','DeceasedMiddle',COUNT(__d1(__NL(Deceased_Middle_))),COUNT(__d1(__NN(Deceased_Middle_)))},
    {'Event','KELOtto.PersonEventTypes','DeceasedLast',COUNT(__d1(__NL(Deceased_Last_))),COUNT(__d1(__NN(Deceased_Last_)))},
    {'Event','KELOtto.PersonEventTypes','DeceasedMatchCode',COUNT(__d1(__NL(Deceased_Match_Code_))),COUNT(__d1(__NN(Deceased_Match_Code_)))},
    {'Event','KELOtto.PersonEventTypes','isdeepdive',COUNT(__d1(__NL(_isdeepdive_))),COUNT(__d1(__NN(_isdeepdive_)))},
    {'Event','KELOtto.PersonEventTypes','county_death',COUNT(__d1(__NL(_county__death_))),COUNT(__d1(__NN(_county__death_)))},
    {'Event','KELOtto.PersonEventTypes','DeceasedSsn',COUNT(__d1(__NL(Deceased_Ssn_))),COUNT(__d1(__NN(Deceased_Ssn_)))},
    {'Event','KELOtto.PersonEventTypes','state_death_flag',COUNT(__d1(__NL(_state__death__flag_))),COUNT(__d1(__NN(_state__death__flag_)))},
    {'Event','KELOtto.PersonEventTypes','death_rec_src',COUNT(__d1(__NL(_death__rec__src_))),COUNT(__d1(__NN(_death__rec__src_)))},
    {'Event','KELOtto.PersonEventTypes','state_death_id',COUNT(__d1(__NL(_state__death__id_))),COUNT(__d1(__NN(_state__death__id_)))},
    {'Event','KELOtto.PersonEventTypes','Hri',COUNT(__d1(__NL(Hri_))),COUNT(__d1(__NN(Hri_)))},
    {'Event','KELOtto.PersonEventTypes','ip_address',COUNT(__d1(__NL(Ip_Address_))),COUNT(__d1(__NN(Ip_Address_)))},
    {'Event','KELOtto.PersonEventTypes','iprngbeg',COUNT(__d1(__NL(_iprngbeg_))),COUNT(__d1(__NN(_iprngbeg_)))},
    {'Event','KELOtto.PersonEventTypes','iprngend',COUNT(__d1(__NL(_iprngend_))),COUNT(__d1(__NN(_iprngend_)))},
    {'Event','KELOtto.PersonEventTypes','edgecountry',COUNT(__d1(__NL(_edgecountry_))),COUNT(__d1(__NN(_edgecountry_)))},
    {'Event','KELOtto.PersonEventTypes','edgeregion',COUNT(__d1(__NL(_edgeregion_))),COUNT(__d1(__NN(_edgeregion_)))},
    {'Event','KELOtto.PersonEventTypes','edgecity',COUNT(__d1(__NL(_edgecity_))),COUNT(__d1(__NN(_edgecity_)))},
    {'Event','KELOtto.PersonEventTypes','edgeconnspeed',COUNT(__d1(__NL(_edgeconnspeed_))),COUNT(__d1(__NN(_edgeconnspeed_)))},
    {'Event','KELOtto.PersonEventTypes','edgemetrocode',COUNT(__d1(__NL(_edgemetrocode_))),COUNT(__d1(__NN(_edgemetrocode_)))},
    {'Event','KELOtto.PersonEventTypes','edgelatitude',COUNT(__d1(__NL(_edgelatitude_))),COUNT(__d1(__NN(_edgelatitude_)))},
    {'Event','KELOtto.PersonEventTypes','edgelongitude',COUNT(__d1(__NL(_edgelongitude_))),COUNT(__d1(__NN(_edgelongitude_)))},
    {'Event','KELOtto.PersonEventTypes','edgepostalcode',COUNT(__d1(__NL(_edgepostalcode_))),COUNT(__d1(__NN(_edgepostalcode_)))},
    {'Event','KELOtto.PersonEventTypes','edgecountrycode',COUNT(__d1(__NL(_edgecountrycode_))),COUNT(__d1(__NN(_edgecountrycode_)))},
    {'Event','KELOtto.PersonEventTypes','edgeregioncode',COUNT(__d1(__NL(_edgeregioncode_))),COUNT(__d1(__NN(_edgeregioncode_)))},
    {'Event','KELOtto.PersonEventTypes','edgecitycode',COUNT(__d1(__NL(_edgecitycode_))),COUNT(__d1(__NN(_edgecitycode_)))},
    {'Event','KELOtto.PersonEventTypes','edgecontinentcode',COUNT(__d1(__NL(_edgecontinentcode_))),COUNT(__d1(__NN(_edgecontinentcode_)))},
    {'Event','KELOtto.PersonEventTypes','edgetwolettercountry',COUNT(__d1(__NL(_edgetwolettercountry_))),COUNT(__d1(__NN(_edgetwolettercountry_)))},
    {'Event','KELOtto.PersonEventTypes','edgeinternalcode',COUNT(__d1(__NL(_edgeinternalcode_))),COUNT(__d1(__NN(_edgeinternalcode_)))},
    {'Event','KELOtto.PersonEventTypes','edgeareacodes',COUNT(__d1(__NL(_edgeareacodes_))),COUNT(__d1(__NN(_edgeareacodes_)))},
    {'Event','KELOtto.PersonEventTypes','edgecountryconf',COUNT(__d1(__NL(_edgecountryconf_))),COUNT(__d1(__NN(_edgecountryconf_)))},
    {'Event','KELOtto.PersonEventTypes','edgeregionconf',COUNT(__d1(__NL(_edgeregionconf_))),COUNT(__d1(__NN(_edgeregionconf_)))},
    {'Event','KELOtto.PersonEventTypes','edgecitycong',COUNT(__d1(__NL(_edgecitycong_))),COUNT(__d1(__NN(_edgecitycong_)))},
    {'Event','KELOtto.PersonEventTypes','edgepostalconf',COUNT(__d1(__NL(_edgepostalconf_))),COUNT(__d1(__NN(_edgepostalconf_)))},
    {'Event','KELOtto.PersonEventTypes','edgegmtoffset',COUNT(__d1(__NL(_edgegmtoffset_))),COUNT(__d1(__NN(_edgegmtoffset_)))},
    {'Event','KELOtto.PersonEventTypes','edgeindst',COUNT(__d1(__NL(_edgeindst_))),COUNT(__d1(__NN(_edgeindst_)))},
    {'Event','KELOtto.PersonEventTypes','siccode',COUNT(__d1(__NL(_siccode_))),COUNT(__d1(__NN(_siccode_)))},
    {'Event','KELOtto.PersonEventTypes','domainname',COUNT(__d1(__NL(_domainname_))),COUNT(__d1(__NN(_domainname_)))},
    {'Event','KELOtto.PersonEventTypes','ispname',COUNT(__d1(__NL(_ispname_))),COUNT(__d1(__NN(_ispname_)))},
    {'Event','KELOtto.PersonEventTypes','homebiztype',COUNT(__d1(__NL(_homebiztype_))),COUNT(__d1(__NN(_homebiztype_)))},
    {'Event','KELOtto.PersonEventTypes','asn',COUNT(__d1(__NL(_asn_))),COUNT(__d1(__NN(_asn_)))},
    {'Event','KELOtto.PersonEventTypes','asnname',COUNT(__d1(__NL(_asnname_))),COUNT(__d1(__NN(_asnname_)))},
    {'Event','KELOtto.PersonEventTypes','primarylang',COUNT(__d1(__NL(_primarylang_))),COUNT(__d1(__NN(_primarylang_)))},
    {'Event','KELOtto.PersonEventTypes','secondarylang',COUNT(__d1(__NL(_secondarylang_))),COUNT(__d1(__NN(_secondarylang_)))},
    {'Event','KELOtto.PersonEventTypes','proxytype',COUNT(__d1(__NL(_proxytype_))),COUNT(__d1(__NN(_proxytype_)))},
    {'Event','KELOtto.PersonEventTypes','proxydescription',COUNT(__d1(__NL(_proxydescription_))),COUNT(__d1(__NN(_proxydescription_)))},
    {'Event','KELOtto.PersonEventTypes','isanisp',COUNT(__d1(__NL(_isanisp_))),COUNT(__d1(__NN(_isanisp_)))},
    {'Event','KELOtto.PersonEventTypes','companyname',COUNT(__d1(__NL(_companyname_))),COUNT(__d1(__NN(_companyname_)))},
    {'Event','KELOtto.PersonEventTypes','ranks',COUNT(__d1(__NL(_ranks_))),COUNT(__d1(__NN(_ranks_)))},
    {'Event','KELOtto.PersonEventTypes','households',COUNT(__d1(__NL(_households_))),COUNT(__d1(__NN(_households_)))},
    {'Event','KELOtto.PersonEventTypes','women',COUNT(__d1(__NL(_women_))),COUNT(__d1(__NN(_women_)))},
    {'Event','KELOtto.PersonEventTypes','women18to34',COUNT(__d1(__NL(_women18to34_))),COUNT(__d1(__NN(_women18to34_)))},
    {'Event','KELOtto.PersonEventTypes','women35to49',COUNT(__d1(__NL(_women35to49_))),COUNT(__d1(__NN(_women35to49_)))},
    {'Event','KELOtto.PersonEventTypes','men',COUNT(__d1(__NL(_men_))),COUNT(__d1(__NN(_men_)))},
    {'Event','KELOtto.PersonEventTypes','men18to34',COUNT(__d1(__NL(_men18to34_))),COUNT(__d1(__NN(_men18to34_)))},
    {'Event','KELOtto.PersonEventTypes','men35to49',COUNT(__d1(__NL(_men35to49_))),COUNT(__d1(__NN(_men35to49_)))},
    {'Event','KELOtto.PersonEventTypes','teens',COUNT(__d1(__NL(_teens_))),COUNT(__d1(__NN(_teens_)))},
    {'Event','KELOtto.PersonEventTypes','kids',COUNT(__d1(__NL(_kids_))),COUNT(__d1(__NN(_kids_)))},
    {'Event','KELOtto.PersonEventTypes','naicscode',COUNT(__d1(__NL(_naicscode_))),COUNT(__d1(__NN(_naicscode_)))},
    {'Event','KELOtto.PersonEventTypes','cbsacode',COUNT(__d1(__NL(_cbsacode_))),COUNT(__d1(__NN(_cbsacode_)))},
    {'Event','KELOtto.PersonEventTypes','cbsatitle',COUNT(__d1(__NL(_cbsatitle_))),COUNT(__d1(__NN(_cbsatitle_)))},
    {'Event','KELOtto.PersonEventTypes','cbsatype',COUNT(__d1(__NL(_cbsatype_))),COUNT(__d1(__NN(_cbsatype_)))},
    {'Event','KELOtto.PersonEventTypes','csacode',COUNT(__d1(__NL(_csacode_))),COUNT(__d1(__NN(_csacode_)))},
    {'Event','KELOtto.PersonEventTypes','csatitle',COUNT(__d1(__NL(_csatitle_))),COUNT(__d1(__NN(_csatitle_)))},
    {'Event','KELOtto.PersonEventTypes','mdcode',COUNT(__d1(__NL(_mdcode_))),COUNT(__d1(__NN(_mdcode_)))},
    {'Event','KELOtto.PersonEventTypes','mdtitle',COUNT(__d1(__NL(_mdtitle_))),COUNT(__d1(__NN(_mdtitle_)))},
    {'Event','KELOtto.PersonEventTypes','organizationname',COUNT(__d1(__NL(_organizationname_))),COUNT(__d1(__NN(_organizationname_)))},
    {'Event','KELOtto.PersonEventTypes','DateFirstSeen',COUNT(__d1(Date_First_Seen_=0)),COUNT(__d1(Date_First_Seen_!=0))},
    {'Event','KELOtto.PersonEventTypes','DateLastSeen',COUNT(__d1(Date_Last_Seen_=0)),COUNT(__d1(Date_Last_Seen_!=0))}]
  ,{KEL.typ.str entity,KEL.typ.str fileName,KEL.typ.str fieldName,KEL.typ.int nullCount,KEL.typ.int notNullCount});
END;
