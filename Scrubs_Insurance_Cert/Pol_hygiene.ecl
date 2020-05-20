IMPORT SALT311,STD;
EXPORT Pol_hygiene(dataset(Pol_layout_Insurance_Cert) h) := MODULE
 
//A simple summary record
EXPORT Summary(SALT311.Str30Type  txt) := FUNCTION
  SummaryLayout := RECORD
    txt;
    NumberOfRecords := COUNT(GROUP);
    populated_lnpolicyid_cnt := COUNT(GROUP,h.lnpolicyid <> (TYPEOF(h.lnpolicyid))'');
    populated_lnpolicyid_pcnt := AVE(GROUP,IF(h.lnpolicyid = (TYPEOF(h.lnpolicyid))'',0,100));
    maxlength_lnpolicyid := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.lnpolicyid)));
    avelength_lnpolicyid := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.lnpolicyid)),h.lnpolicyid<>(typeof(h.lnpolicyid))'');
    populated_lninscertrecordid_cnt := COUNT(GROUP,h.lninscertrecordid <> (TYPEOF(h.lninscertrecordid))'');
    populated_lninscertrecordid_pcnt := AVE(GROUP,IF(h.lninscertrecordid = (TYPEOF(h.lninscertrecordid))'',0,100));
    maxlength_lninscertrecordid := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.lninscertrecordid)));
    avelength_lninscertrecordid := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.lninscertrecordid)),h.lninscertrecordid<>(typeof(h.lninscertrecordid))'');
    populated_dartid_cnt := COUNT(GROUP,h.dartid <> (TYPEOF(h.dartid))'');
    populated_dartid_pcnt := AVE(GROUP,IF(h.dartid = (TYPEOF(h.dartid))'',0,100));
    maxlength_dartid := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.dartid)));
    avelength_dartid := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.dartid)),h.dartid<>(typeof(h.dartid))'');
    populated_insuranceprovider_cnt := COUNT(GROUP,h.insuranceprovider <> (TYPEOF(h.insuranceprovider))'');
    populated_insuranceprovider_pcnt := AVE(GROUP,IF(h.insuranceprovider = (TYPEOF(h.insuranceprovider))'',0,100));
    maxlength_insuranceprovider := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.insuranceprovider)));
    avelength_insuranceprovider := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.insuranceprovider)),h.insuranceprovider<>(typeof(h.insuranceprovider))'');
    populated_policynumber_cnt := COUNT(GROUP,h.policynumber <> (TYPEOF(h.policynumber))'');
    populated_policynumber_pcnt := AVE(GROUP,IF(h.policynumber = (TYPEOF(h.policynumber))'',0,100));
    maxlength_policynumber := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.policynumber)));
    avelength_policynumber := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.policynumber)),h.policynumber<>(typeof(h.policynumber))'');
    populated_coveragestartdate_cnt := COUNT(GROUP,h.coveragestartdate <> (TYPEOF(h.coveragestartdate))'');
    populated_coveragestartdate_pcnt := AVE(GROUP,IF(h.coveragestartdate = (TYPEOF(h.coveragestartdate))'',0,100));
    maxlength_coveragestartdate := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.coveragestartdate)));
    avelength_coveragestartdate := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.coveragestartdate)),h.coveragestartdate<>(typeof(h.coveragestartdate))'');
    populated_coverageexpirationdate_cnt := COUNT(GROUP,h.coverageexpirationdate <> (TYPEOF(h.coverageexpirationdate))'');
    populated_coverageexpirationdate_pcnt := AVE(GROUP,IF(h.coverageexpirationdate = (TYPEOF(h.coverageexpirationdate))'',0,100));
    maxlength_coverageexpirationdate := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.coverageexpirationdate)));
    avelength_coverageexpirationdate := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.coverageexpirationdate)),h.coverageexpirationdate<>(typeof(h.coverageexpirationdate))'');
    populated_coveragewrapup_cnt := COUNT(GROUP,h.coveragewrapup <> (TYPEOF(h.coveragewrapup))'');
    populated_coveragewrapup_pcnt := AVE(GROUP,IF(h.coveragewrapup = (TYPEOF(h.coveragewrapup))'',0,100));
    maxlength_coveragewrapup := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.coveragewrapup)));
    avelength_coveragewrapup := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.coveragewrapup)),h.coveragewrapup<>(typeof(h.coveragewrapup))'');
    populated_policystatus_cnt := COUNT(GROUP,h.policystatus <> (TYPEOF(h.policystatus))'');
    populated_policystatus_pcnt := AVE(GROUP,IF(h.policystatus = (TYPEOF(h.policystatus))'',0,100));
    maxlength_policystatus := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.policystatus)));
    avelength_policystatus := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.policystatus)),h.policystatus<>(typeof(h.policystatus))'');
    populated_insuranceprovideraddressline_cnt := COUNT(GROUP,h.insuranceprovideraddressline <> (TYPEOF(h.insuranceprovideraddressline))'');
    populated_insuranceprovideraddressline_pcnt := AVE(GROUP,IF(h.insuranceprovideraddressline = (TYPEOF(h.insuranceprovideraddressline))'',0,100));
    maxlength_insuranceprovideraddressline := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.insuranceprovideraddressline)));
    avelength_insuranceprovideraddressline := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.insuranceprovideraddressline)),h.insuranceprovideraddressline<>(typeof(h.insuranceprovideraddressline))'');
    populated_insuranceprovideraddressline2_cnt := COUNT(GROUP,h.insuranceprovideraddressline2 <> (TYPEOF(h.insuranceprovideraddressline2))'');
    populated_insuranceprovideraddressline2_pcnt := AVE(GROUP,IF(h.insuranceprovideraddressline2 = (TYPEOF(h.insuranceprovideraddressline2))'',0,100));
    maxlength_insuranceprovideraddressline2 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.insuranceprovideraddressline2)));
    avelength_insuranceprovideraddressline2 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.insuranceprovideraddressline2)),h.insuranceprovideraddressline2<>(typeof(h.insuranceprovideraddressline2))'');
    populated_insuranceprovidercity_cnt := COUNT(GROUP,h.insuranceprovidercity <> (TYPEOF(h.insuranceprovidercity))'');
    populated_insuranceprovidercity_pcnt := AVE(GROUP,IF(h.insuranceprovidercity = (TYPEOF(h.insuranceprovidercity))'',0,100));
    maxlength_insuranceprovidercity := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.insuranceprovidercity)));
    avelength_insuranceprovidercity := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.insuranceprovidercity)),h.insuranceprovidercity<>(typeof(h.insuranceprovidercity))'');
    populated_insuranceproviderstate_cnt := COUNT(GROUP,h.insuranceproviderstate <> (TYPEOF(h.insuranceproviderstate))'');
    populated_insuranceproviderstate_pcnt := AVE(GROUP,IF(h.insuranceproviderstate = (TYPEOF(h.insuranceproviderstate))'',0,100));
    maxlength_insuranceproviderstate := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.insuranceproviderstate)));
    avelength_insuranceproviderstate := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.insuranceproviderstate)),h.insuranceproviderstate<>(typeof(h.insuranceproviderstate))'');
    populated_insuranceproviderzip_cnt := COUNT(GROUP,h.insuranceproviderzip <> (TYPEOF(h.insuranceproviderzip))'');
    populated_insuranceproviderzip_pcnt := AVE(GROUP,IF(h.insuranceproviderzip = (TYPEOF(h.insuranceproviderzip))'',0,100));
    maxlength_insuranceproviderzip := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.insuranceproviderzip)));
    avelength_insuranceproviderzip := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.insuranceproviderzip)),h.insuranceproviderzip<>(typeof(h.insuranceproviderzip))'');
    populated_insuranceproviderzip4_cnt := COUNT(GROUP,h.insuranceproviderzip4 <> (TYPEOF(h.insuranceproviderzip4))'');
    populated_insuranceproviderzip4_pcnt := AVE(GROUP,IF(h.insuranceproviderzip4 = (TYPEOF(h.insuranceproviderzip4))'',0,100));
    maxlength_insuranceproviderzip4 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.insuranceproviderzip4)));
    avelength_insuranceproviderzip4 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.insuranceproviderzip4)),h.insuranceproviderzip4<>(typeof(h.insuranceproviderzip4))'');
    populated_insuranceproviderphone_cnt := COUNT(GROUP,h.insuranceproviderphone <> (TYPEOF(h.insuranceproviderphone))'');
    populated_insuranceproviderphone_pcnt := AVE(GROUP,IF(h.insuranceproviderphone = (TYPEOF(h.insuranceproviderphone))'',0,100));
    maxlength_insuranceproviderphone := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.insuranceproviderphone)));
    avelength_insuranceproviderphone := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.insuranceproviderphone)),h.insuranceproviderphone<>(typeof(h.insuranceproviderphone))'');
    populated_insuranceproviderfax_cnt := COUNT(GROUP,h.insuranceproviderfax <> (TYPEOF(h.insuranceproviderfax))'');
    populated_insuranceproviderfax_pcnt := AVE(GROUP,IF(h.insuranceproviderfax = (TYPEOF(h.insuranceproviderfax))'',0,100));
    maxlength_insuranceproviderfax := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.insuranceproviderfax)));
    avelength_insuranceproviderfax := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.insuranceproviderfax)),h.insuranceproviderfax<>(typeof(h.insuranceproviderfax))'');
    populated_coveragereinstatedate_cnt := COUNT(GROUP,h.coveragereinstatedate <> (TYPEOF(h.coveragereinstatedate))'');
    populated_coveragereinstatedate_pcnt := AVE(GROUP,IF(h.coveragereinstatedate = (TYPEOF(h.coveragereinstatedate))'',0,100));
    maxlength_coveragereinstatedate := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.coveragereinstatedate)));
    avelength_coveragereinstatedate := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.coveragereinstatedate)),h.coveragereinstatedate<>(typeof(h.coveragereinstatedate))'');
    populated_coveragecancellationdate_cnt := COUNT(GROUP,h.coveragecancellationdate <> (TYPEOF(h.coveragecancellationdate))'');
    populated_coveragecancellationdate_pcnt := AVE(GROUP,IF(h.coveragecancellationdate = (TYPEOF(h.coveragecancellationdate))'',0,100));
    maxlength_coveragecancellationdate := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.coveragecancellationdate)));
    avelength_coveragecancellationdate := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.coveragecancellationdate)),h.coveragecancellationdate<>(typeof(h.coveragecancellationdate))'');
    populated_coveragewrapupdate_cnt := COUNT(GROUP,h.coveragewrapupdate <> (TYPEOF(h.coveragewrapupdate))'');
    populated_coveragewrapupdate_pcnt := AVE(GROUP,IF(h.coveragewrapupdate = (TYPEOF(h.coveragewrapupdate))'',0,100));
    maxlength_coveragewrapupdate := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.coveragewrapupdate)));
    avelength_coveragewrapupdate := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.coveragewrapupdate)),h.coveragewrapupdate<>(typeof(h.coveragewrapupdate))'');
    populated_businessnameduringcoverage_cnt := COUNT(GROUP,h.businessnameduringcoverage <> (TYPEOF(h.businessnameduringcoverage))'');
    populated_businessnameduringcoverage_pcnt := AVE(GROUP,IF(h.businessnameduringcoverage = (TYPEOF(h.businessnameduringcoverage))'',0,100));
    maxlength_businessnameduringcoverage := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.businessnameduringcoverage)));
    avelength_businessnameduringcoverage := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.businessnameduringcoverage)),h.businessnameduringcoverage<>(typeof(h.businessnameduringcoverage))'');
    populated_addresslineduringcoverage_cnt := COUNT(GROUP,h.addresslineduringcoverage <> (TYPEOF(h.addresslineduringcoverage))'');
    populated_addresslineduringcoverage_pcnt := AVE(GROUP,IF(h.addresslineduringcoverage = (TYPEOF(h.addresslineduringcoverage))'',0,100));
    maxlength_addresslineduringcoverage := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.addresslineduringcoverage)));
    avelength_addresslineduringcoverage := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.addresslineduringcoverage)),h.addresslineduringcoverage<>(typeof(h.addresslineduringcoverage))'');
    populated_addressline2duringcoverage_cnt := COUNT(GROUP,h.addressline2duringcoverage <> (TYPEOF(h.addressline2duringcoverage))'');
    populated_addressline2duringcoverage_pcnt := AVE(GROUP,IF(h.addressline2duringcoverage = (TYPEOF(h.addressline2duringcoverage))'',0,100));
    maxlength_addressline2duringcoverage := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.addressline2duringcoverage)));
    avelength_addressline2duringcoverage := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.addressline2duringcoverage)),h.addressline2duringcoverage<>(typeof(h.addressline2duringcoverage))'');
    populated_cityduringcoverage_cnt := COUNT(GROUP,h.cityduringcoverage <> (TYPEOF(h.cityduringcoverage))'');
    populated_cityduringcoverage_pcnt := AVE(GROUP,IF(h.cityduringcoverage = (TYPEOF(h.cityduringcoverage))'',0,100));
    maxlength_cityduringcoverage := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.cityduringcoverage)));
    avelength_cityduringcoverage := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.cityduringcoverage)),h.cityduringcoverage<>(typeof(h.cityduringcoverage))'');
    populated_stateduringcoverage_cnt := COUNT(GROUP,h.stateduringcoverage <> (TYPEOF(h.stateduringcoverage))'');
    populated_stateduringcoverage_pcnt := AVE(GROUP,IF(h.stateduringcoverage = (TYPEOF(h.stateduringcoverage))'',0,100));
    maxlength_stateduringcoverage := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.stateduringcoverage)));
    avelength_stateduringcoverage := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.stateduringcoverage)),h.stateduringcoverage<>(typeof(h.stateduringcoverage))'');
    populated_zipduringcoverage_cnt := COUNT(GROUP,h.zipduringcoverage <> (TYPEOF(h.zipduringcoverage))'');
    populated_zipduringcoverage_pcnt := AVE(GROUP,IF(h.zipduringcoverage = (TYPEOF(h.zipduringcoverage))'',0,100));
    maxlength_zipduringcoverage := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.zipduringcoverage)));
    avelength_zipduringcoverage := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.zipduringcoverage)),h.zipduringcoverage<>(typeof(h.zipduringcoverage))'');
    populated_zip4duringcoverage_cnt := COUNT(GROUP,h.zip4duringcoverage <> (TYPEOF(h.zip4duringcoverage))'');
    populated_zip4duringcoverage_pcnt := AVE(GROUP,IF(h.zip4duringcoverage = (TYPEOF(h.zip4duringcoverage))'',0,100));
    maxlength_zip4duringcoverage := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.zip4duringcoverage)));
    avelength_zip4duringcoverage := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.zip4duringcoverage)),h.zip4duringcoverage<>(typeof(h.zip4duringcoverage))'');
    populated_numberofemployeesduringcoverage_cnt := COUNT(GROUP,h.numberofemployeesduringcoverage <> (TYPEOF(h.numberofemployeesduringcoverage))'');
    populated_numberofemployeesduringcoverage_pcnt := AVE(GROUP,IF(h.numberofemployeesduringcoverage = (TYPEOF(h.numberofemployeesduringcoverage))'',0,100));
    maxlength_numberofemployeesduringcoverage := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.numberofemployeesduringcoverage)));
    avelength_numberofemployeesduringcoverage := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.numberofemployeesduringcoverage)),h.numberofemployeesduringcoverage<>(typeof(h.numberofemployeesduringcoverage))'');
    populated_insuranceprovidercontactdept_cnt := COUNT(GROUP,h.insuranceprovidercontactdept <> (TYPEOF(h.insuranceprovidercontactdept))'');
    populated_insuranceprovidercontactdept_pcnt := AVE(GROUP,IF(h.insuranceprovidercontactdept = (TYPEOF(h.insuranceprovidercontactdept))'',0,100));
    maxlength_insuranceprovidercontactdept := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.insuranceprovidercontactdept)));
    avelength_insuranceprovidercontactdept := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.insuranceprovidercontactdept)),h.insuranceprovidercontactdept<>(typeof(h.insuranceprovidercontactdept))'');
    populated_insurancetype_cnt := COUNT(GROUP,h.insurancetype <> (TYPEOF(h.insurancetype))'');
    populated_insurancetype_pcnt := AVE(GROUP,IF(h.insurancetype = (TYPEOF(h.insurancetype))'',0,100));
    maxlength_insurancetype := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.insurancetype)));
    avelength_insurancetype := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.insurancetype)),h.insurancetype<>(typeof(h.insurancetype))'');
    populated_coverageposteddate_cnt := COUNT(GROUP,h.coverageposteddate <> (TYPEOF(h.coverageposteddate))'');
    populated_coverageposteddate_pcnt := AVE(GROUP,IF(h.coverageposteddate = (TYPEOF(h.coverageposteddate))'',0,100));
    maxlength_coverageposteddate := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.coverageposteddate)));
    avelength_coverageposteddate := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.coverageposteddate)),h.coverageposteddate<>(typeof(h.coverageposteddate))'');
    populated_coverageamountfrom_cnt := COUNT(GROUP,h.coverageamountfrom <> (TYPEOF(h.coverageamountfrom))'');
    populated_coverageamountfrom_pcnt := AVE(GROUP,IF(h.coverageamountfrom = (TYPEOF(h.coverageamountfrom))'',0,100));
    maxlength_coverageamountfrom := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.coverageamountfrom)));
    avelength_coverageamountfrom := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.coverageamountfrom)),h.coverageamountfrom<>(typeof(h.coverageamountfrom))'');
    populated_coverageamountto_cnt := COUNT(GROUP,h.coverageamountto <> (TYPEOF(h.coverageamountto))'');
    populated_coverageamountto_pcnt := AVE(GROUP,IF(h.coverageamountto = (TYPEOF(h.coverageamountto))'',0,100));
    maxlength_coverageamountto := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.coverageamountto)));
    avelength_coverageamountto := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.coverageamountto)),h.coverageamountto<>(typeof(h.coverageamountto))'');
  END;
    T := TABLE(h,SummaryLayout);
  R1 := RECORD
    UNSIGNED LinkingPotential :=  + T.Populated_lnpolicyid_pcnt *   0.00 / 100 + T.Populated_lninscertrecordid_pcnt *   0.00 / 100 + T.Populated_dartid_pcnt *   0.00 / 100 + T.Populated_insuranceprovider_pcnt *   0.00 / 100 + T.Populated_policynumber_pcnt *   0.00 / 100 + T.Populated_coveragestartdate_pcnt *   0.00 / 100 + T.Populated_coverageexpirationdate_pcnt *   0.00 / 100 + T.Populated_coveragewrapup_pcnt *   0.00 / 100 + T.Populated_policystatus_pcnt *   0.00 / 100 + T.Populated_insuranceprovideraddressline_pcnt *   0.00 / 100 + T.Populated_insuranceprovideraddressline2_pcnt *   0.00 / 100 + T.Populated_insuranceprovidercity_pcnt *   0.00 / 100 + T.Populated_insuranceproviderstate_pcnt *   0.00 / 100 + T.Populated_insuranceproviderzip_pcnt *   0.00 / 100 + T.Populated_insuranceproviderzip4_pcnt *   0.00 / 100 + T.Populated_insuranceproviderphone_pcnt *   0.00 / 100 + T.Populated_insuranceproviderfax_pcnt *   0.00 / 100 + T.Populated_coveragereinstatedate_pcnt *   0.00 / 100 + T.Populated_coveragecancellationdate_pcnt *   0.00 / 100 + T.Populated_coveragewrapupdate_pcnt *   0.00 / 100 + T.Populated_businessnameduringcoverage_pcnt *   0.00 / 100 + T.Populated_addresslineduringcoverage_pcnt *   0.00 / 100 + T.Populated_addressline2duringcoverage_pcnt *   0.00 / 100 + T.Populated_cityduringcoverage_pcnt *   0.00 / 100 + T.Populated_stateduringcoverage_pcnt *   0.00 / 100 + T.Populated_zipduringcoverage_pcnt *   0.00 / 100 + T.Populated_zip4duringcoverage_pcnt *   0.00 / 100 + T.Populated_numberofemployeesduringcoverage_pcnt *   0.00 / 100 + T.Populated_insuranceprovidercontactdept_pcnt *   0.00 / 100 + T.Populated_insurancetype_pcnt *   0.00 / 100 + T.Populated_coverageposteddate_pcnt *   0.00 / 100 + T.Populated_coverageamountfrom_pcnt *   0.00 / 100 + T.Populated_coverageamountto_pcnt *   0.00 / 100;
    T;
  END;
  RETURN TABLE(T,R1);
END;
 
summary0 := Summary('Summary');
  invRec := RECORD
  UNSIGNED  FldNo;
  SALT311.StrType FieldName;
  UNSIGNED NumberOfRecords;
  REAL8  populated_pcnt;
  UNSIGNED  maxlength;
  REAL8  avelength;
END;
invRec invert(summary0 le, INTEGER C) := TRANSFORM
  SELF.FldNo := C;
  SELF.NumberOfRecords := le.NumberOfRecords;
  SELF.FieldName := CHOOSE(C,'lnpolicyid','lninscertrecordid','dartid','insuranceprovider','policynumber','coveragestartdate','coverageexpirationdate','coveragewrapup','policystatus','insuranceprovideraddressline','insuranceprovideraddressline2','insuranceprovidercity','insuranceproviderstate','insuranceproviderzip','insuranceproviderzip4','insuranceproviderphone','insuranceproviderfax','coveragereinstatedate','coveragecancellationdate','coveragewrapupdate','businessnameduringcoverage','addresslineduringcoverage','addressline2duringcoverage','cityduringcoverage','stateduringcoverage','zipduringcoverage','zip4duringcoverage','numberofemployeesduringcoverage','insuranceprovidercontactdept','insurancetype','coverageposteddate','coverageamountfrom','coverageamountto');
  SELF.populated_pcnt := CHOOSE(C,le.populated_lnpolicyid_pcnt,le.populated_lninscertrecordid_pcnt,le.populated_dartid_pcnt,le.populated_insuranceprovider_pcnt,le.populated_policynumber_pcnt,le.populated_coveragestartdate_pcnt,le.populated_coverageexpirationdate_pcnt,le.populated_coveragewrapup_pcnt,le.populated_policystatus_pcnt,le.populated_insuranceprovideraddressline_pcnt,le.populated_insuranceprovideraddressline2_pcnt,le.populated_insuranceprovidercity_pcnt,le.populated_insuranceproviderstate_pcnt,le.populated_insuranceproviderzip_pcnt,le.populated_insuranceproviderzip4_pcnt,le.populated_insuranceproviderphone_pcnt,le.populated_insuranceproviderfax_pcnt,le.populated_coveragereinstatedate_pcnt,le.populated_coveragecancellationdate_pcnt,le.populated_coveragewrapupdate_pcnt,le.populated_businessnameduringcoverage_pcnt,le.populated_addresslineduringcoverage_pcnt,le.populated_addressline2duringcoverage_pcnt,le.populated_cityduringcoverage_pcnt,le.populated_stateduringcoverage_pcnt,le.populated_zipduringcoverage_pcnt,le.populated_zip4duringcoverage_pcnt,le.populated_numberofemployeesduringcoverage_pcnt,le.populated_insuranceprovidercontactdept_pcnt,le.populated_insurancetype_pcnt,le.populated_coverageposteddate_pcnt,le.populated_coverageamountfrom_pcnt,le.populated_coverageamountto_pcnt);
  SELF.maxlength := CHOOSE(C,le.maxlength_lnpolicyid,le.maxlength_lninscertrecordid,le.maxlength_dartid,le.maxlength_insuranceprovider,le.maxlength_policynumber,le.maxlength_coveragestartdate,le.maxlength_coverageexpirationdate,le.maxlength_coveragewrapup,le.maxlength_policystatus,le.maxlength_insuranceprovideraddressline,le.maxlength_insuranceprovideraddressline2,le.maxlength_insuranceprovidercity,le.maxlength_insuranceproviderstate,le.maxlength_insuranceproviderzip,le.maxlength_insuranceproviderzip4,le.maxlength_insuranceproviderphone,le.maxlength_insuranceproviderfax,le.maxlength_coveragereinstatedate,le.maxlength_coveragecancellationdate,le.maxlength_coveragewrapupdate,le.maxlength_businessnameduringcoverage,le.maxlength_addresslineduringcoverage,le.maxlength_addressline2duringcoverage,le.maxlength_cityduringcoverage,le.maxlength_stateduringcoverage,le.maxlength_zipduringcoverage,le.maxlength_zip4duringcoverage,le.maxlength_numberofemployeesduringcoverage,le.maxlength_insuranceprovidercontactdept,le.maxlength_insurancetype,le.maxlength_coverageposteddate,le.maxlength_coverageamountfrom,le.maxlength_coverageamountto);
  SELF.avelength := CHOOSE(C,le.avelength_lnpolicyid,le.avelength_lninscertrecordid,le.avelength_dartid,le.avelength_insuranceprovider,le.avelength_policynumber,le.avelength_coveragestartdate,le.avelength_coverageexpirationdate,le.avelength_coveragewrapup,le.avelength_policystatus,le.avelength_insuranceprovideraddressline,le.avelength_insuranceprovideraddressline2,le.avelength_insuranceprovidercity,le.avelength_insuranceproviderstate,le.avelength_insuranceproviderzip,le.avelength_insuranceproviderzip4,le.avelength_insuranceproviderphone,le.avelength_insuranceproviderfax,le.avelength_coveragereinstatedate,le.avelength_coveragecancellationdate,le.avelength_coveragewrapupdate,le.avelength_businessnameduringcoverage,le.avelength_addresslineduringcoverage,le.avelength_addressline2duringcoverage,le.avelength_cityduringcoverage,le.avelength_stateduringcoverage,le.avelength_zipduringcoverage,le.avelength_zip4duringcoverage,le.avelength_numberofemployeesduringcoverage,le.avelength_insuranceprovidercontactdept,le.avelength_insurancetype,le.avelength_coverageposteddate,le.avelength_coverageamountfrom,le.avelength_coverageamountto);
END;
EXPORT invSummary := NORMALIZE(summary0, 33, invert(LEFT,COUNTER));
// The character counts
// Move everything into 'inverted list' form so processing can be done 'in library'
SALT311.MAC_Character_Counts.X_Data_Layout Into(h le,unsigned C) := TRANSFORM
  SELF.Fld := TRIM(CHOOSE(C,TRIM((SALT311.StrType)le.lnpolicyid),IF (le.lninscertrecordid <> 0,TRIM((SALT311.StrType)le.lninscertrecordid), ''),TRIM((SALT311.StrType)le.dartid),TRIM((SALT311.StrType)le.insuranceprovider),TRIM((SALT311.StrType)le.policynumber),TRIM((SALT311.StrType)le.coveragestartdate),TRIM((SALT311.StrType)le.coverageexpirationdate),TRIM((SALT311.StrType)le.coveragewrapup),TRIM((SALT311.StrType)le.policystatus),TRIM((SALT311.StrType)le.insuranceprovideraddressline),TRIM((SALT311.StrType)le.insuranceprovideraddressline2),TRIM((SALT311.StrType)le.insuranceprovidercity),TRIM((SALT311.StrType)le.insuranceproviderstate),TRIM((SALT311.StrType)le.insuranceproviderzip),TRIM((SALT311.StrType)le.insuranceproviderzip4),TRIM((SALT311.StrType)le.insuranceproviderphone),TRIM((SALT311.StrType)le.insuranceproviderfax),TRIM((SALT311.StrType)le.coveragereinstatedate),TRIM((SALT311.StrType)le.coveragecancellationdate),TRIM((SALT311.StrType)le.coveragewrapupdate),TRIM((SALT311.StrType)le.businessnameduringcoverage),TRIM((SALT311.StrType)le.addresslineduringcoverage),TRIM((SALT311.StrType)le.addressline2duringcoverage),TRIM((SALT311.StrType)le.cityduringcoverage),TRIM((SALT311.StrType)le.stateduringcoverage),TRIM((SALT311.StrType)le.zipduringcoverage),TRIM((SALT311.StrType)le.zip4duringcoverage),TRIM((SALT311.StrType)le.numberofemployeesduringcoverage),TRIM((SALT311.StrType)le.insuranceprovidercontactdept),TRIM((SALT311.StrType)le.insurancetype),TRIM((SALT311.StrType)le.coverageposteddate),TRIM((SALT311.StrType)le.coverageamountfrom),TRIM((SALT311.StrType)le.coverageamountto)));
  SELF.FldNo := C;
END;
SHARED FldInv0 := NORMALIZE(h,33,Into(LEFT,COUNTER));
// Move everything into 'pairs' form so processing can be done 'in library'
SALT311.MAC_Correlate.Data_Layout IntoP(h le,UNSIGNED C) := TRANSFORM
  SELF.FldNo1 := 1 + (C / 33);
  SELF.FldNo2 := 1 + (C % 33);
  SELF.Fld1 := TRIM(CHOOSE(SELF.FldNo1,TRIM((SALT311.StrType)le.lnpolicyid),IF (le.lninscertrecordid <> 0,TRIM((SALT311.StrType)le.lninscertrecordid), ''),TRIM((SALT311.StrType)le.dartid),TRIM((SALT311.StrType)le.insuranceprovider),TRIM((SALT311.StrType)le.policynumber),TRIM((SALT311.StrType)le.coveragestartdate),TRIM((SALT311.StrType)le.coverageexpirationdate),TRIM((SALT311.StrType)le.coveragewrapup),TRIM((SALT311.StrType)le.policystatus),TRIM((SALT311.StrType)le.insuranceprovideraddressline),TRIM((SALT311.StrType)le.insuranceprovideraddressline2),TRIM((SALT311.StrType)le.insuranceprovidercity),TRIM((SALT311.StrType)le.insuranceproviderstate),TRIM((SALT311.StrType)le.insuranceproviderzip),TRIM((SALT311.StrType)le.insuranceproviderzip4),TRIM((SALT311.StrType)le.insuranceproviderphone),TRIM((SALT311.StrType)le.insuranceproviderfax),TRIM((SALT311.StrType)le.coveragereinstatedate),TRIM((SALT311.StrType)le.coveragecancellationdate),TRIM((SALT311.StrType)le.coveragewrapupdate),TRIM((SALT311.StrType)le.businessnameduringcoverage),TRIM((SALT311.StrType)le.addresslineduringcoverage),TRIM((SALT311.StrType)le.addressline2duringcoverage),TRIM((SALT311.StrType)le.cityduringcoverage),TRIM((SALT311.StrType)le.stateduringcoverage),TRIM((SALT311.StrType)le.zipduringcoverage),TRIM((SALT311.StrType)le.zip4duringcoverage),TRIM((SALT311.StrType)le.numberofemployeesduringcoverage),TRIM((SALT311.StrType)le.insuranceprovidercontactdept),TRIM((SALT311.StrType)le.insurancetype),TRIM((SALT311.StrType)le.coverageposteddate),TRIM((SALT311.StrType)le.coverageamountfrom),TRIM((SALT311.StrType)le.coverageamountto)));
  SELF.Fld2 := TRIM(CHOOSE(SELF.FldNo2,TRIM((SALT311.StrType)le.lnpolicyid),IF (le.lninscertrecordid <> 0,TRIM((SALT311.StrType)le.lninscertrecordid), ''),TRIM((SALT311.StrType)le.dartid),TRIM((SALT311.StrType)le.insuranceprovider),TRIM((SALT311.StrType)le.policynumber),TRIM((SALT311.StrType)le.coveragestartdate),TRIM((SALT311.StrType)le.coverageexpirationdate),TRIM((SALT311.StrType)le.coveragewrapup),TRIM((SALT311.StrType)le.policystatus),TRIM((SALT311.StrType)le.insuranceprovideraddressline),TRIM((SALT311.StrType)le.insuranceprovideraddressline2),TRIM((SALT311.StrType)le.insuranceprovidercity),TRIM((SALT311.StrType)le.insuranceproviderstate),TRIM((SALT311.StrType)le.insuranceproviderzip),TRIM((SALT311.StrType)le.insuranceproviderzip4),TRIM((SALT311.StrType)le.insuranceproviderphone),TRIM((SALT311.StrType)le.insuranceproviderfax),TRIM((SALT311.StrType)le.coveragereinstatedate),TRIM((SALT311.StrType)le.coveragecancellationdate),TRIM((SALT311.StrType)le.coveragewrapupdate),TRIM((SALT311.StrType)le.businessnameduringcoverage),TRIM((SALT311.StrType)le.addresslineduringcoverage),TRIM((SALT311.StrType)le.addressline2duringcoverage),TRIM((SALT311.StrType)le.cityduringcoverage),TRIM((SALT311.StrType)le.stateduringcoverage),TRIM((SALT311.StrType)le.zipduringcoverage),TRIM((SALT311.StrType)le.zip4duringcoverage),TRIM((SALT311.StrType)le.numberofemployeesduringcoverage),TRIM((SALT311.StrType)le.insuranceprovidercontactdept),TRIM((SALT311.StrType)le.insurancetype),TRIM((SALT311.StrType)le.coverageposteddate),TRIM((SALT311.StrType)le.coverageamountfrom),TRIM((SALT311.StrType)le.coverageamountto)));
  END;
SHARED Pairs0 := NORMALIZE(ENTH(h,Config.CorrelateSampleSize),33*33,IntoP(LEFT,COUNTER))(FldNo1<FldNo2);
SHARED FldIds := DATASET([{1,'lnpolicyid'}
      ,{2,'lninscertrecordid'}
      ,{3,'dartid'}
      ,{4,'insuranceprovider'}
      ,{5,'policynumber'}
      ,{6,'coveragestartdate'}
      ,{7,'coverageexpirationdate'}
      ,{8,'coveragewrapup'}
      ,{9,'policystatus'}
      ,{10,'insuranceprovideraddressline'}
      ,{11,'insuranceprovideraddressline2'}
      ,{12,'insuranceprovidercity'}
      ,{13,'insuranceproviderstate'}
      ,{14,'insuranceproviderzip'}
      ,{15,'insuranceproviderzip4'}
      ,{16,'insuranceproviderphone'}
      ,{17,'insuranceproviderfax'}
      ,{18,'coveragereinstatedate'}
      ,{19,'coveragecancellationdate'}
      ,{20,'coveragewrapupdate'}
      ,{21,'businessnameduringcoverage'}
      ,{22,'addresslineduringcoverage'}
      ,{23,'addressline2duringcoverage'}
      ,{24,'cityduringcoverage'}
      ,{25,'stateduringcoverage'}
      ,{26,'zipduringcoverage'}
      ,{27,'zip4duringcoverage'}
      ,{28,'numberofemployeesduringcoverage'}
      ,{29,'insuranceprovidercontactdept'}
      ,{30,'insurancetype'}
      ,{31,'coverageposteddate'}
      ,{32,'coverageamountfrom'}
      ,{33,'coverageamountto'}],SALT311.MAC_Character_Counts.Field_Identification);
EXPORT AllProfiles := SALT311.MAC_Character_Counts.FN_Profile(FldInv0,FldIds);
 
EXPORT SrcProfiles := SALT311.MAC_Character_Counts.Src_Profile(FldInv0,FldIds);
 
EXPORT Correlations := SALT311.MAC_Correlate.Fn_Profile(Pairs0,FldIds);
 
ErrorRecord := RECORD
  UNSIGNED1 FieldNum;
  UNSIGNED1 ErrorNum;
END;
ErrorRecord NoteErrors(h le,UNSIGNED1 c) := TRANSFORM
  SELF.ErrorNum := CHOOSE(c,
    Pol_Fields.InValid_lnpolicyid((SALT311.StrType)le.lnpolicyid),
    Pol_Fields.InValid_lninscertrecordid((SALT311.StrType)le.lninscertrecordid),
    Pol_Fields.InValid_dartid((SALT311.StrType)le.dartid),
    Pol_Fields.InValid_insuranceprovider((SALT311.StrType)le.insuranceprovider),
    Pol_Fields.InValid_policynumber((SALT311.StrType)le.policynumber),
    Pol_Fields.InValid_coveragestartdate((SALT311.StrType)le.coveragestartdate),
    Pol_Fields.InValid_coverageexpirationdate((SALT311.StrType)le.coverageexpirationdate),
    Pol_Fields.InValid_coveragewrapup((SALT311.StrType)le.coveragewrapup),
    Pol_Fields.InValid_policystatus((SALT311.StrType)le.policystatus),
    Pol_Fields.InValid_insuranceprovideraddressline((SALT311.StrType)le.insuranceprovideraddressline),
    Pol_Fields.InValid_insuranceprovideraddressline2((SALT311.StrType)le.insuranceprovideraddressline2),
    Pol_Fields.InValid_insuranceprovidercity((SALT311.StrType)le.insuranceprovidercity),
    Pol_Fields.InValid_insuranceproviderstate((SALT311.StrType)le.insuranceproviderstate),
    Pol_Fields.InValid_insuranceproviderzip((SALT311.StrType)le.insuranceproviderzip),
    Pol_Fields.InValid_insuranceproviderzip4((SALT311.StrType)le.insuranceproviderzip4),
    Pol_Fields.InValid_insuranceproviderphone((SALT311.StrType)le.insuranceproviderphone),
    Pol_Fields.InValid_insuranceproviderfax((SALT311.StrType)le.insuranceproviderfax),
    Pol_Fields.InValid_coveragereinstatedate((SALT311.StrType)le.coveragereinstatedate),
    Pol_Fields.InValid_coveragecancellationdate((SALT311.StrType)le.coveragecancellationdate),
    Pol_Fields.InValid_coveragewrapupdate((SALT311.StrType)le.coveragewrapupdate),
    Pol_Fields.InValid_businessnameduringcoverage((SALT311.StrType)le.businessnameduringcoverage),
    Pol_Fields.InValid_addresslineduringcoverage((SALT311.StrType)le.addresslineduringcoverage),
    Pol_Fields.InValid_addressline2duringcoverage((SALT311.StrType)le.addressline2duringcoverage),
    Pol_Fields.InValid_cityduringcoverage((SALT311.StrType)le.cityduringcoverage),
    Pol_Fields.InValid_stateduringcoverage((SALT311.StrType)le.stateduringcoverage),
    Pol_Fields.InValid_zipduringcoverage((SALT311.StrType)le.zipduringcoverage),
    Pol_Fields.InValid_zip4duringcoverage((SALT311.StrType)le.zip4duringcoverage),
    Pol_Fields.InValid_numberofemployeesduringcoverage((SALT311.StrType)le.numberofemployeesduringcoverage),
    Pol_Fields.InValid_insuranceprovidercontactdept((SALT311.StrType)le.insuranceprovidercontactdept),
    Pol_Fields.InValid_insurancetype((SALT311.StrType)le.insurancetype),
    Pol_Fields.InValid_coverageposteddate((SALT311.StrType)le.coverageposteddate),
    Pol_Fields.InValid_coverageamountfrom((SALT311.StrType)le.coverageamountfrom),
    Pol_Fields.InValid_coverageamountto((SALT311.StrType)le.coverageamountto),
    0);
  SELF.FieldNum := IF(SELF.ErrorNum=0,SKIP,c); // Bail early to avoid creating record
END;
Errors := NORMALIZE(h,33,NoteErrors(LEFT,COUNTER));
ErrorRecordsTotals := RECORD
  Errors.FieldNum;
  Errors.ErrorNum;
  UNSIGNED Cnt := COUNT(GROUP);
END;
TotalErrors := TABLE(Errors,ErrorRecordsTotals,FieldNum,ErrorNum,FEW);
PrettyErrorTotals := RECORD
  FieldNme := Pol_Fields.FieldName(TotalErrors.FieldNum);
  FieldType := CHOOSE(TotalErrors.FieldNum,'Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown');
  ErrorMessage := CHOOSE(TotalErrors.FieldNum,Pol_Fields.InValidMessage_lnpolicyid(TotalErrors.ErrorNum),Pol_Fields.InValidMessage_lninscertrecordid(TotalErrors.ErrorNum),Pol_Fields.InValidMessage_dartid(TotalErrors.ErrorNum),Pol_Fields.InValidMessage_insuranceprovider(TotalErrors.ErrorNum),Pol_Fields.InValidMessage_policynumber(TotalErrors.ErrorNum),Pol_Fields.InValidMessage_coveragestartdate(TotalErrors.ErrorNum),Pol_Fields.InValidMessage_coverageexpirationdate(TotalErrors.ErrorNum),Pol_Fields.InValidMessage_coveragewrapup(TotalErrors.ErrorNum),Pol_Fields.InValidMessage_policystatus(TotalErrors.ErrorNum),Pol_Fields.InValidMessage_insuranceprovideraddressline(TotalErrors.ErrorNum),Pol_Fields.InValidMessage_insuranceprovideraddressline2(TotalErrors.ErrorNum),Pol_Fields.InValidMessage_insuranceprovidercity(TotalErrors.ErrorNum),Pol_Fields.InValidMessage_insuranceproviderstate(TotalErrors.ErrorNum),Pol_Fields.InValidMessage_insuranceproviderzip(TotalErrors.ErrorNum),Pol_Fields.InValidMessage_insuranceproviderzip4(TotalErrors.ErrorNum),Pol_Fields.InValidMessage_insuranceproviderphone(TotalErrors.ErrorNum),Pol_Fields.InValidMessage_insuranceproviderfax(TotalErrors.ErrorNum),Pol_Fields.InValidMessage_coveragereinstatedate(TotalErrors.ErrorNum),Pol_Fields.InValidMessage_coveragecancellationdate(TotalErrors.ErrorNum),Pol_Fields.InValidMessage_coveragewrapupdate(TotalErrors.ErrorNum),Pol_Fields.InValidMessage_businessnameduringcoverage(TotalErrors.ErrorNum),Pol_Fields.InValidMessage_addresslineduringcoverage(TotalErrors.ErrorNum),Pol_Fields.InValidMessage_addressline2duringcoverage(TotalErrors.ErrorNum),Pol_Fields.InValidMessage_cityduringcoverage(TotalErrors.ErrorNum),Pol_Fields.InValidMessage_stateduringcoverage(TotalErrors.ErrorNum),Pol_Fields.InValidMessage_zipduringcoverage(TotalErrors.ErrorNum),Pol_Fields.InValidMessage_zip4duringcoverage(TotalErrors.ErrorNum),Pol_Fields.InValidMessage_numberofemployeesduringcoverage(TotalErrors.ErrorNum),Pol_Fields.InValidMessage_insuranceprovidercontactdept(TotalErrors.ErrorNum),Pol_Fields.InValidMessage_insurancetype(TotalErrors.ErrorNum),Pol_Fields.InValidMessage_coverageposteddate(TotalErrors.ErrorNum),Pol_Fields.InValidMessage_coverageamountfrom(TotalErrors.ErrorNum),Pol_Fields.InValidMessage_coverageamountto(TotalErrors.ErrorNum));
  TotalErrors.Cnt;
END;
ValErr := TABLE(TotalErrors,PrettyErrorTotals);
EXPORT ValidityErrors := ValErr;
EXPORT StandardStats(BOOLEAN doSummaryGlobal = TRUE, BOOLEAN doAllProfiles = TRUE) := FUNCTION
  myTimeStamp := (UNSIGNED6)SALT311.Fn_Now('YYYYMMDDHHMMSS') : INDEPENDENT;
  fieldPopulationOverall := Summary('');
 
  SALT311.mod_StandardStatsTransforms.mac_hygieneSummaryTransform(Scrubs_Insurance_Cert, Pol_Fields, 'RECORDOF(fieldPopulationOverall)', FALSE);
 
  fieldPopulationOverall_Standard := IF(doSummaryGlobal, NORMALIZE(fieldPopulationOverall, COUNT(FldIds) * 6, xSummary(LEFT, COUNTER, myTimeStamp, 'all', 'all')));
  fieldPopulationOverall_TotalRecs_Standard := IF(doSummaryGlobal, SALT311.mod_StandardStatsTransforms.mac_hygieneTotalRecs(fieldPopulationOverall, myTimeStamp, 'all', FALSE, 'all'));
  allProfiles_Standard := IF(doAllProfiles, SALT311.mod_StandardStatsTransforms.hygieneAllProfiles(AllProfiles, myTimeStamp, 10, 'all'));
 
  RETURN fieldPopulationOverall_Standard & fieldPopulationOverall_TotalRecs_Standard & allProfiles_Standard;
END;
END;
