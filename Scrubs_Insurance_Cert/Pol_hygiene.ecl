IMPORT SALT311,STD;
EXPORT Pol_hygiene(dataset(Pol_layout_Insurance_Cert) h) := MODULE
 
//A simple summary record
EXPORT Summary(SALT311.Str30Type  txt) := FUNCTION
  SummaryLayout := RECORD
    txt;
    NumberOfRecords := COUNT(GROUP);
    populated_date_firstseen_cnt := COUNT(GROUP,h.date_firstseen <> (TYPEOF(h.date_firstseen))'');
    populated_date_firstseen_pcnt := AVE(GROUP,IF(h.date_firstseen = (TYPEOF(h.date_firstseen))'',0,100));
    maxlength_date_firstseen := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.date_firstseen)));
    avelength_date_firstseen := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.date_firstseen)),h.date_firstseen<>(typeof(h.date_firstseen))'');
    populated_date_lastseen_cnt := COUNT(GROUP,h.date_lastseen <> (TYPEOF(h.date_lastseen))'');
    populated_date_lastseen_pcnt := AVE(GROUP,IF(h.date_lastseen = (TYPEOF(h.date_lastseen))'',0,100));
    maxlength_date_lastseen := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.date_lastseen)));
    avelength_date_lastseen := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.date_lastseen)),h.date_lastseen<>(typeof(h.date_lastseen))'');
    populated_bdid_cnt := COUNT(GROUP,h.bdid <> (TYPEOF(h.bdid))'');
    populated_bdid_pcnt := AVE(GROUP,IF(h.bdid = (TYPEOF(h.bdid))'',0,100));
    maxlength_bdid := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.bdid)));
    avelength_bdid := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.bdid)),h.bdid<>(typeof(h.bdid))'');
    populated_dotid_cnt := COUNT(GROUP,h.dotid <> (TYPEOF(h.dotid))'');
    populated_dotid_pcnt := AVE(GROUP,IF(h.dotid = (TYPEOF(h.dotid))'',0,100));
    maxlength_dotid := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.dotid)));
    avelength_dotid := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.dotid)),h.dotid<>(typeof(h.dotid))'');
    populated_dotscore_cnt := COUNT(GROUP,h.dotscore <> (TYPEOF(h.dotscore))'');
    populated_dotscore_pcnt := AVE(GROUP,IF(h.dotscore = (TYPEOF(h.dotscore))'',0,100));
    maxlength_dotscore := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.dotscore)));
    avelength_dotscore := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.dotscore)),h.dotscore<>(typeof(h.dotscore))'');
    populated_dotweight_cnt := COUNT(GROUP,h.dotweight <> (TYPEOF(h.dotweight))'');
    populated_dotweight_pcnt := AVE(GROUP,IF(h.dotweight = (TYPEOF(h.dotweight))'',0,100));
    maxlength_dotweight := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.dotweight)));
    avelength_dotweight := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.dotweight)),h.dotweight<>(typeof(h.dotweight))'');
    populated_empid_cnt := COUNT(GROUP,h.empid <> (TYPEOF(h.empid))'');
    populated_empid_pcnt := AVE(GROUP,IF(h.empid = (TYPEOF(h.empid))'',0,100));
    maxlength_empid := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.empid)));
    avelength_empid := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.empid)),h.empid<>(typeof(h.empid))'');
    populated_empscore_cnt := COUNT(GROUP,h.empscore <> (TYPEOF(h.empscore))'');
    populated_empscore_pcnt := AVE(GROUP,IF(h.empscore = (TYPEOF(h.empscore))'',0,100));
    maxlength_empscore := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.empscore)));
    avelength_empscore := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.empscore)),h.empscore<>(typeof(h.empscore))'');
    populated_empweight_cnt := COUNT(GROUP,h.empweight <> (TYPEOF(h.empweight))'');
    populated_empweight_pcnt := AVE(GROUP,IF(h.empweight = (TYPEOF(h.empweight))'',0,100));
    maxlength_empweight := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.empweight)));
    avelength_empweight := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.empweight)),h.empweight<>(typeof(h.empweight))'');
    populated_powid_cnt := COUNT(GROUP,h.powid <> (TYPEOF(h.powid))'');
    populated_powid_pcnt := AVE(GROUP,IF(h.powid = (TYPEOF(h.powid))'',0,100));
    maxlength_powid := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.powid)));
    avelength_powid := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.powid)),h.powid<>(typeof(h.powid))'');
    populated_powscore_cnt := COUNT(GROUP,h.powscore <> (TYPEOF(h.powscore))'');
    populated_powscore_pcnt := AVE(GROUP,IF(h.powscore = (TYPEOF(h.powscore))'',0,100));
    maxlength_powscore := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.powscore)));
    avelength_powscore := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.powscore)),h.powscore<>(typeof(h.powscore))'');
    populated_powweight_cnt := COUNT(GROUP,h.powweight <> (TYPEOF(h.powweight))'');
    populated_powweight_pcnt := AVE(GROUP,IF(h.powweight = (TYPEOF(h.powweight))'',0,100));
    maxlength_powweight := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.powweight)));
    avelength_powweight := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.powweight)),h.powweight<>(typeof(h.powweight))'');
    populated_proxid_cnt := COUNT(GROUP,h.proxid <> (TYPEOF(h.proxid))'');
    populated_proxid_pcnt := AVE(GROUP,IF(h.proxid = (TYPEOF(h.proxid))'',0,100));
    maxlength_proxid := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.proxid)));
    avelength_proxid := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.proxid)),h.proxid<>(typeof(h.proxid))'');
    populated_proxscore_cnt := COUNT(GROUP,h.proxscore <> (TYPEOF(h.proxscore))'');
    populated_proxscore_pcnt := AVE(GROUP,IF(h.proxscore = (TYPEOF(h.proxscore))'',0,100));
    maxlength_proxscore := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.proxscore)));
    avelength_proxscore := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.proxscore)),h.proxscore<>(typeof(h.proxscore))'');
    populated_proxweight_cnt := COUNT(GROUP,h.proxweight <> (TYPEOF(h.proxweight))'');
    populated_proxweight_pcnt := AVE(GROUP,IF(h.proxweight = (TYPEOF(h.proxweight))'',0,100));
    maxlength_proxweight := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.proxweight)));
    avelength_proxweight := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.proxweight)),h.proxweight<>(typeof(h.proxweight))'');
    populated_seleid_cnt := COUNT(GROUP,h.seleid <> (TYPEOF(h.seleid))'');
    populated_seleid_pcnt := AVE(GROUP,IF(h.seleid = (TYPEOF(h.seleid))'',0,100));
    maxlength_seleid := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.seleid)));
    avelength_seleid := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.seleid)),h.seleid<>(typeof(h.seleid))'');
    populated_selescore_cnt := COUNT(GROUP,h.selescore <> (TYPEOF(h.selescore))'');
    populated_selescore_pcnt := AVE(GROUP,IF(h.selescore = (TYPEOF(h.selescore))'',0,100));
    maxlength_selescore := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.selescore)));
    avelength_selescore := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.selescore)),h.selescore<>(typeof(h.selescore))'');
    populated_seleweight_cnt := COUNT(GROUP,h.seleweight <> (TYPEOF(h.seleweight))'');
    populated_seleweight_pcnt := AVE(GROUP,IF(h.seleweight = (TYPEOF(h.seleweight))'',0,100));
    maxlength_seleweight := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.seleweight)));
    avelength_seleweight := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.seleweight)),h.seleweight<>(typeof(h.seleweight))'');
    populated_orgid_cnt := COUNT(GROUP,h.orgid <> (TYPEOF(h.orgid))'');
    populated_orgid_pcnt := AVE(GROUP,IF(h.orgid = (TYPEOF(h.orgid))'',0,100));
    maxlength_orgid := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.orgid)));
    avelength_orgid := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.orgid)),h.orgid<>(typeof(h.orgid))'');
    populated_orgscore_cnt := COUNT(GROUP,h.orgscore <> (TYPEOF(h.orgscore))'');
    populated_orgscore_pcnt := AVE(GROUP,IF(h.orgscore = (TYPEOF(h.orgscore))'',0,100));
    maxlength_orgscore := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.orgscore)));
    avelength_orgscore := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.orgscore)),h.orgscore<>(typeof(h.orgscore))'');
    populated_orgweight_cnt := COUNT(GROUP,h.orgweight <> (TYPEOF(h.orgweight))'');
    populated_orgweight_pcnt := AVE(GROUP,IF(h.orgweight = (TYPEOF(h.orgweight))'',0,100));
    maxlength_orgweight := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.orgweight)));
    avelength_orgweight := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.orgweight)),h.orgweight<>(typeof(h.orgweight))'');
    populated_ultid_cnt := COUNT(GROUP,h.ultid <> (TYPEOF(h.ultid))'');
    populated_ultid_pcnt := AVE(GROUP,IF(h.ultid = (TYPEOF(h.ultid))'',0,100));
    maxlength_ultid := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.ultid)));
    avelength_ultid := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.ultid)),h.ultid<>(typeof(h.ultid))'');
    populated_ultscore_cnt := COUNT(GROUP,h.ultscore <> (TYPEOF(h.ultscore))'');
    populated_ultscore_pcnt := AVE(GROUP,IF(h.ultscore = (TYPEOF(h.ultscore))'',0,100));
    maxlength_ultscore := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.ultscore)));
    avelength_ultscore := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.ultscore)),h.ultscore<>(typeof(h.ultscore))'');
    populated_ultweight_cnt := COUNT(GROUP,h.ultweight <> (TYPEOF(h.ultweight))'');
    populated_ultweight_pcnt := AVE(GROUP,IF(h.ultweight = (TYPEOF(h.ultweight))'',0,100));
    maxlength_ultweight := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.ultweight)));
    avelength_ultweight := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.ultweight)),h.ultweight<>(typeof(h.ultweight))'');
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
    populated_unique_id_cnt := COUNT(GROUP,h.unique_id <> (TYPEOF(h.unique_id))'');
    populated_unique_id_pcnt := AVE(GROUP,IF(h.unique_id = (TYPEOF(h.unique_id))'',0,100));
    maxlength_unique_id := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.unique_id)));
    avelength_unique_id := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.unique_id)),h.unique_id<>(typeof(h.unique_id))'');
    populated_append_mailaddress1_cnt := COUNT(GROUP,h.append_mailaddress1 <> (TYPEOF(h.append_mailaddress1))'');
    populated_append_mailaddress1_pcnt := AVE(GROUP,IF(h.append_mailaddress1 = (TYPEOF(h.append_mailaddress1))'',0,100));
    maxlength_append_mailaddress1 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.append_mailaddress1)));
    avelength_append_mailaddress1 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.append_mailaddress1)),h.append_mailaddress1<>(typeof(h.append_mailaddress1))'');
    populated_append_mailaddresslast_cnt := COUNT(GROUP,h.append_mailaddresslast <> (TYPEOF(h.append_mailaddresslast))'');
    populated_append_mailaddresslast_pcnt := AVE(GROUP,IF(h.append_mailaddresslast = (TYPEOF(h.append_mailaddresslast))'',0,100));
    maxlength_append_mailaddresslast := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.append_mailaddresslast)));
    avelength_append_mailaddresslast := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.append_mailaddresslast)),h.append_mailaddresslast<>(typeof(h.append_mailaddresslast))'');
    populated_append_mailrawaid_cnt := COUNT(GROUP,h.append_mailrawaid <> (TYPEOF(h.append_mailrawaid))'');
    populated_append_mailrawaid_pcnt := AVE(GROUP,IF(h.append_mailrawaid = (TYPEOF(h.append_mailrawaid))'',0,100));
    maxlength_append_mailrawaid := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.append_mailrawaid)));
    avelength_append_mailrawaid := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.append_mailrawaid)),h.append_mailrawaid<>(typeof(h.append_mailrawaid))'');
    populated_append_mailaceaid_cnt := COUNT(GROUP,h.append_mailaceaid <> (TYPEOF(h.append_mailaceaid))'');
    populated_append_mailaceaid_pcnt := AVE(GROUP,IF(h.append_mailaceaid = (TYPEOF(h.append_mailaceaid))'',0,100));
    maxlength_append_mailaceaid := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.append_mailaceaid)));
    avelength_append_mailaceaid := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.append_mailaceaid)),h.append_mailaceaid<>(typeof(h.append_mailaceaid))'');
  END;
    T := TABLE(h,SummaryLayout);
  R1 := RECORD
    UNSIGNED LinkingPotential :=  + T.Populated_date_firstseen_pcnt *   0.00 / 100 + T.Populated_date_lastseen_pcnt *   0.00 / 100 + T.Populated_bdid_pcnt *   0.00 / 100 + T.Populated_dotid_pcnt *   0.00 / 100 + T.Populated_dotscore_pcnt *   0.00 / 100 + T.Populated_dotweight_pcnt *   0.00 / 100 + T.Populated_empid_pcnt *   0.00 / 100 + T.Populated_empscore_pcnt *   0.00 / 100 + T.Populated_empweight_pcnt *   0.00 / 100 + T.Populated_powid_pcnt *   0.00 / 100 + T.Populated_powscore_pcnt *   0.00 / 100 + T.Populated_powweight_pcnt *   0.00 / 100 + T.Populated_proxid_pcnt *   0.00 / 100 + T.Populated_proxscore_pcnt *   0.00 / 100 + T.Populated_proxweight_pcnt *   0.00 / 100 + T.Populated_seleid_pcnt *   0.00 / 100 + T.Populated_selescore_pcnt *   0.00 / 100 + T.Populated_seleweight_pcnt *   0.00 / 100 + T.Populated_orgid_pcnt *   0.00 / 100 + T.Populated_orgscore_pcnt *   0.00 / 100 + T.Populated_orgweight_pcnt *   0.00 / 100 + T.Populated_ultid_pcnt *   0.00 / 100 + T.Populated_ultscore_pcnt *   0.00 / 100 + T.Populated_ultweight_pcnt *   0.00 / 100 + T.Populated_lninscertrecordid_pcnt *   0.00 / 100 + T.Populated_dartid_pcnt *   0.00 / 100 + T.Populated_insuranceprovider_pcnt *   0.00 / 100 + T.Populated_policynumber_pcnt *   0.00 / 100 + T.Populated_coveragestartdate_pcnt *   0.00 / 100 + T.Populated_coverageexpirationdate_pcnt *   0.00 / 100 + T.Populated_coveragewrapup_pcnt *   0.00 / 100 + T.Populated_policystatus_pcnt *   0.00 / 100 + T.Populated_insuranceprovideraddressline_pcnt *   0.00 / 100 + T.Populated_insuranceprovideraddressline2_pcnt *   0.00 / 100 + T.Populated_insuranceprovidercity_pcnt *   0.00 / 100 + T.Populated_insuranceproviderstate_pcnt *   0.00 / 100 + T.Populated_insuranceproviderzip_pcnt *   0.00 / 100 + T.Populated_insuranceproviderzip4_pcnt *   0.00 / 100 + T.Populated_insuranceproviderphone_pcnt *   0.00 / 100 + T.Populated_insuranceproviderfax_pcnt *   0.00 / 100 + T.Populated_coveragereinstatedate_pcnt *   0.00 / 100 + T.Populated_coveragecancellationdate_pcnt *   0.00 / 100 + T.Populated_coveragewrapupdate_pcnt *   0.00 / 100 + T.Populated_businessnameduringcoverage_pcnt *   0.00 / 100 + T.Populated_addresslineduringcoverage_pcnt *   0.00 / 100 + T.Populated_addressline2duringcoverage_pcnt *   0.00 / 100 + T.Populated_cityduringcoverage_pcnt *   0.00 / 100 + T.Populated_stateduringcoverage_pcnt *   0.00 / 100 + T.Populated_zipduringcoverage_pcnt *   0.00 / 100 + T.Populated_zip4duringcoverage_pcnt *   0.00 / 100 + T.Populated_numberofemployeesduringcoverage_pcnt *   0.00 / 100 + T.Populated_insuranceprovidercontactdept_pcnt *   0.00 / 100 + T.Populated_insurancetype_pcnt *   0.00 / 100 + T.Populated_coverageposteddate_pcnt *   0.00 / 100 + T.Populated_coverageamountfrom_pcnt *   0.00 / 100 + T.Populated_coverageamountto_pcnt *   0.00 / 100 + T.Populated_unique_id_pcnt *   0.00 / 100 + T.Populated_append_mailaddress1_pcnt *   0.00 / 100 + T.Populated_append_mailaddresslast_pcnt *   0.00 / 100 + T.Populated_append_mailrawaid_pcnt *   0.00 / 100 + T.Populated_append_mailaceaid_pcnt *   0.00 / 100;
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
  SELF.FieldName := CHOOSE(C,'date_firstseen','date_lastseen','bdid','dotid','dotscore','dotweight','empid','empscore','empweight','powid','powscore','powweight','proxid','proxscore','proxweight','seleid','selescore','seleweight','orgid','orgscore','orgweight','ultid','ultscore','ultweight','lninscertrecordid','dartid','insuranceprovider','policynumber','coveragestartdate','coverageexpirationdate','coveragewrapup','policystatus','insuranceprovideraddressline','insuranceprovideraddressline2','insuranceprovidercity','insuranceproviderstate','insuranceproviderzip','insuranceproviderzip4','insuranceproviderphone','insuranceproviderfax','coveragereinstatedate','coveragecancellationdate','coveragewrapupdate','businessnameduringcoverage','addresslineduringcoverage','addressline2duringcoverage','cityduringcoverage','stateduringcoverage','zipduringcoverage','zip4duringcoverage','numberofemployeesduringcoverage','insuranceprovidercontactdept','insurancetype','coverageposteddate','coverageamountfrom','coverageamountto','unique_id','append_mailaddress1','append_mailaddresslast','append_mailrawaid','append_mailaceaid');
  SELF.populated_pcnt := CHOOSE(C,le.populated_date_firstseen_pcnt,le.populated_date_lastseen_pcnt,le.populated_bdid_pcnt,le.populated_dotid_pcnt,le.populated_dotscore_pcnt,le.populated_dotweight_pcnt,le.populated_empid_pcnt,le.populated_empscore_pcnt,le.populated_empweight_pcnt,le.populated_powid_pcnt,le.populated_powscore_pcnt,le.populated_powweight_pcnt,le.populated_proxid_pcnt,le.populated_proxscore_pcnt,le.populated_proxweight_pcnt,le.populated_seleid_pcnt,le.populated_selescore_pcnt,le.populated_seleweight_pcnt,le.populated_orgid_pcnt,le.populated_orgscore_pcnt,le.populated_orgweight_pcnt,le.populated_ultid_pcnt,le.populated_ultscore_pcnt,le.populated_ultweight_pcnt,le.populated_lninscertrecordid_pcnt,le.populated_dartid_pcnt,le.populated_insuranceprovider_pcnt,le.populated_policynumber_pcnt,le.populated_coveragestartdate_pcnt,le.populated_coverageexpirationdate_pcnt,le.populated_coveragewrapup_pcnt,le.populated_policystatus_pcnt,le.populated_insuranceprovideraddressline_pcnt,le.populated_insuranceprovideraddressline2_pcnt,le.populated_insuranceprovidercity_pcnt,le.populated_insuranceproviderstate_pcnt,le.populated_insuranceproviderzip_pcnt,le.populated_insuranceproviderzip4_pcnt,le.populated_insuranceproviderphone_pcnt,le.populated_insuranceproviderfax_pcnt,le.populated_coveragereinstatedate_pcnt,le.populated_coveragecancellationdate_pcnt,le.populated_coveragewrapupdate_pcnt,le.populated_businessnameduringcoverage_pcnt,le.populated_addresslineduringcoverage_pcnt,le.populated_addressline2duringcoverage_pcnt,le.populated_cityduringcoverage_pcnt,le.populated_stateduringcoverage_pcnt,le.populated_zipduringcoverage_pcnt,le.populated_zip4duringcoverage_pcnt,le.populated_numberofemployeesduringcoverage_pcnt,le.populated_insuranceprovidercontactdept_pcnt,le.populated_insurancetype_pcnt,le.populated_coverageposteddate_pcnt,le.populated_coverageamountfrom_pcnt,le.populated_coverageamountto_pcnt,le.populated_unique_id_pcnt,le.populated_append_mailaddress1_pcnt,le.populated_append_mailaddresslast_pcnt,le.populated_append_mailrawaid_pcnt,le.populated_append_mailaceaid_pcnt);
  SELF.maxlength := CHOOSE(C,le.maxlength_date_firstseen,le.maxlength_date_lastseen,le.maxlength_bdid,le.maxlength_dotid,le.maxlength_dotscore,le.maxlength_dotweight,le.maxlength_empid,le.maxlength_empscore,le.maxlength_empweight,le.maxlength_powid,le.maxlength_powscore,le.maxlength_powweight,le.maxlength_proxid,le.maxlength_proxscore,le.maxlength_proxweight,le.maxlength_seleid,le.maxlength_selescore,le.maxlength_seleweight,le.maxlength_orgid,le.maxlength_orgscore,le.maxlength_orgweight,le.maxlength_ultid,le.maxlength_ultscore,le.maxlength_ultweight,le.maxlength_lninscertrecordid,le.maxlength_dartid,le.maxlength_insuranceprovider,le.maxlength_policynumber,le.maxlength_coveragestartdate,le.maxlength_coverageexpirationdate,le.maxlength_coveragewrapup,le.maxlength_policystatus,le.maxlength_insuranceprovideraddressline,le.maxlength_insuranceprovideraddressline2,le.maxlength_insuranceprovidercity,le.maxlength_insuranceproviderstate,le.maxlength_insuranceproviderzip,le.maxlength_insuranceproviderzip4,le.maxlength_insuranceproviderphone,le.maxlength_insuranceproviderfax,le.maxlength_coveragereinstatedate,le.maxlength_coveragecancellationdate,le.maxlength_coveragewrapupdate,le.maxlength_businessnameduringcoverage,le.maxlength_addresslineduringcoverage,le.maxlength_addressline2duringcoverage,le.maxlength_cityduringcoverage,le.maxlength_stateduringcoverage,le.maxlength_zipduringcoverage,le.maxlength_zip4duringcoverage,le.maxlength_numberofemployeesduringcoverage,le.maxlength_insuranceprovidercontactdept,le.maxlength_insurancetype,le.maxlength_coverageposteddate,le.maxlength_coverageamountfrom,le.maxlength_coverageamountto,le.maxlength_unique_id,le.maxlength_append_mailaddress1,le.maxlength_append_mailaddresslast,le.maxlength_append_mailrawaid,le.maxlength_append_mailaceaid);
  SELF.avelength := CHOOSE(C,le.avelength_date_firstseen,le.avelength_date_lastseen,le.avelength_bdid,le.avelength_dotid,le.avelength_dotscore,le.avelength_dotweight,le.avelength_empid,le.avelength_empscore,le.avelength_empweight,le.avelength_powid,le.avelength_powscore,le.avelength_powweight,le.avelength_proxid,le.avelength_proxscore,le.avelength_proxweight,le.avelength_seleid,le.avelength_selescore,le.avelength_seleweight,le.avelength_orgid,le.avelength_orgscore,le.avelength_orgweight,le.avelength_ultid,le.avelength_ultscore,le.avelength_ultweight,le.avelength_lninscertrecordid,le.avelength_dartid,le.avelength_insuranceprovider,le.avelength_policynumber,le.avelength_coveragestartdate,le.avelength_coverageexpirationdate,le.avelength_coveragewrapup,le.avelength_policystatus,le.avelength_insuranceprovideraddressline,le.avelength_insuranceprovideraddressline2,le.avelength_insuranceprovidercity,le.avelength_insuranceproviderstate,le.avelength_insuranceproviderzip,le.avelength_insuranceproviderzip4,le.avelength_insuranceproviderphone,le.avelength_insuranceproviderfax,le.avelength_coveragereinstatedate,le.avelength_coveragecancellationdate,le.avelength_coveragewrapupdate,le.avelength_businessnameduringcoverage,le.avelength_addresslineduringcoverage,le.avelength_addressline2duringcoverage,le.avelength_cityduringcoverage,le.avelength_stateduringcoverage,le.avelength_zipduringcoverage,le.avelength_zip4duringcoverage,le.avelength_numberofemployeesduringcoverage,le.avelength_insuranceprovidercontactdept,le.avelength_insurancetype,le.avelength_coverageposteddate,le.avelength_coverageamountfrom,le.avelength_coverageamountto,le.avelength_unique_id,le.avelength_append_mailaddress1,le.avelength_append_mailaddresslast,le.avelength_append_mailrawaid,le.avelength_append_mailaceaid);
END;
EXPORT invSummary := NORMALIZE(summary0, 61, invert(LEFT,COUNTER));
// The character counts
// Move everything into 'inverted list' form so processing can be done 'in library'
SALT311.MAC_Character_Counts.X_Data_Layout Into(h le,unsigned C) := TRANSFORM
  SELF.Fld := TRIM(CHOOSE(C,IF (le.date_firstseen <> 0,TRIM((SALT311.StrType)le.date_firstseen), ''),IF (le.date_lastseen <> 0,TRIM((SALT311.StrType)le.date_lastseen), ''),IF (le.bdid <> 0,TRIM((SALT311.StrType)le.bdid), ''),IF (le.dotid <> 0,TRIM((SALT311.StrType)le.dotid), ''),IF (le.dotscore <> 0,TRIM((SALT311.StrType)le.dotscore), ''),IF (le.dotweight <> 0,TRIM((SALT311.StrType)le.dotweight), ''),IF (le.empid <> 0,TRIM((SALT311.StrType)le.empid), ''),IF (le.empscore <> 0,TRIM((SALT311.StrType)le.empscore), ''),IF (le.empweight <> 0,TRIM((SALT311.StrType)le.empweight), ''),IF (le.powid <> 0,TRIM((SALT311.StrType)le.powid), ''),IF (le.powscore <> 0,TRIM((SALT311.StrType)le.powscore), ''),IF (le.powweight <> 0,TRIM((SALT311.StrType)le.powweight), ''),IF (le.proxid <> 0,TRIM((SALT311.StrType)le.proxid), ''),IF (le.proxscore <> 0,TRIM((SALT311.StrType)le.proxscore), ''),IF (le.proxweight <> 0,TRIM((SALT311.StrType)le.proxweight), ''),IF (le.seleid <> 0,TRIM((SALT311.StrType)le.seleid), ''),IF (le.selescore <> 0,TRIM((SALT311.StrType)le.selescore), ''),IF (le.seleweight <> 0,TRIM((SALT311.StrType)le.seleweight), ''),IF (le.orgid <> 0,TRIM((SALT311.StrType)le.orgid), ''),IF (le.orgscore <> 0,TRIM((SALT311.StrType)le.orgscore), ''),IF (le.orgweight <> 0,TRIM((SALT311.StrType)le.orgweight), ''),IF (le.ultid <> 0,TRIM((SALT311.StrType)le.ultid), ''),IF (le.ultscore <> 0,TRIM((SALT311.StrType)le.ultscore), ''),IF (le.ultweight <> 0,TRIM((SALT311.StrType)le.ultweight), ''),IF (le.lninscertrecordid <> 0,TRIM((SALT311.StrType)le.lninscertrecordid), ''),TRIM((SALT311.StrType)le.dartid),TRIM((SALT311.StrType)le.insuranceprovider),TRIM((SALT311.StrType)le.policynumber),TRIM((SALT311.StrType)le.coveragestartdate),TRIM((SALT311.StrType)le.coverageexpirationdate),TRIM((SALT311.StrType)le.coveragewrapup),TRIM((SALT311.StrType)le.policystatus),TRIM((SALT311.StrType)le.insuranceprovideraddressline),TRIM((SALT311.StrType)le.insuranceprovideraddressline2),TRIM((SALT311.StrType)le.insuranceprovidercity),TRIM((SALT311.StrType)le.insuranceproviderstate),TRIM((SALT311.StrType)le.insuranceproviderzip),TRIM((SALT311.StrType)le.insuranceproviderzip4),TRIM((SALT311.StrType)le.insuranceproviderphone),TRIM((SALT311.StrType)le.insuranceproviderfax),TRIM((SALT311.StrType)le.coveragereinstatedate),TRIM((SALT311.StrType)le.coveragecancellationdate),TRIM((SALT311.StrType)le.coveragewrapupdate),TRIM((SALT311.StrType)le.businessnameduringcoverage),TRIM((SALT311.StrType)le.addresslineduringcoverage),TRIM((SALT311.StrType)le.addressline2duringcoverage),TRIM((SALT311.StrType)le.cityduringcoverage),TRIM((SALT311.StrType)le.stateduringcoverage),TRIM((SALT311.StrType)le.zipduringcoverage),TRIM((SALT311.StrType)le.zip4duringcoverage),TRIM((SALT311.StrType)le.numberofemployeesduringcoverage),TRIM((SALT311.StrType)le.insuranceprovidercontactdept),TRIM((SALT311.StrType)le.insurancetype),TRIM((SALT311.StrType)le.coverageposteddate),TRIM((SALT311.StrType)le.coverageamountfrom),TRIM((SALT311.StrType)le.coverageamountto),IF (le.unique_id <> 0,TRIM((SALT311.StrType)le.unique_id), ''),TRIM((SALT311.StrType)le.append_mailaddress1),TRIM((SALT311.StrType)le.append_mailaddresslast),IF (le.append_mailrawaid <> 0,TRIM((SALT311.StrType)le.append_mailrawaid), ''),IF (le.append_mailaceaid <> 0,TRIM((SALT311.StrType)le.append_mailaceaid), '')));
  SELF.FldNo := C;
END;
SHARED FldInv0 := NORMALIZE(h,61,Into(LEFT,COUNTER));
// Move everything into 'pairs' form so processing can be done 'in library'
SALT311.MAC_Correlate.Data_Layout IntoP(h le,UNSIGNED C) := TRANSFORM
  SELF.FldNo1 := 1 + (C / 61);
  SELF.FldNo2 := 1 + (C % 61);
  SELF.Fld1 := TRIM(CHOOSE(SELF.FldNo1,IF (le.date_firstseen <> 0,TRIM((SALT311.StrType)le.date_firstseen), ''),IF (le.date_lastseen <> 0,TRIM((SALT311.StrType)le.date_lastseen), ''),IF (le.bdid <> 0,TRIM((SALT311.StrType)le.bdid), ''),IF (le.dotid <> 0,TRIM((SALT311.StrType)le.dotid), ''),IF (le.dotscore <> 0,TRIM((SALT311.StrType)le.dotscore), ''),IF (le.dotweight <> 0,TRIM((SALT311.StrType)le.dotweight), ''),IF (le.empid <> 0,TRIM((SALT311.StrType)le.empid), ''),IF (le.empscore <> 0,TRIM((SALT311.StrType)le.empscore), ''),IF (le.empweight <> 0,TRIM((SALT311.StrType)le.empweight), ''),IF (le.powid <> 0,TRIM((SALT311.StrType)le.powid), ''),IF (le.powscore <> 0,TRIM((SALT311.StrType)le.powscore), ''),IF (le.powweight <> 0,TRIM((SALT311.StrType)le.powweight), ''),IF (le.proxid <> 0,TRIM((SALT311.StrType)le.proxid), ''),IF (le.proxscore <> 0,TRIM((SALT311.StrType)le.proxscore), ''),IF (le.proxweight <> 0,TRIM((SALT311.StrType)le.proxweight), ''),IF (le.seleid <> 0,TRIM((SALT311.StrType)le.seleid), ''),IF (le.selescore <> 0,TRIM((SALT311.StrType)le.selescore), ''),IF (le.seleweight <> 0,TRIM((SALT311.StrType)le.seleweight), ''),IF (le.orgid <> 0,TRIM((SALT311.StrType)le.orgid), ''),IF (le.orgscore <> 0,TRIM((SALT311.StrType)le.orgscore), ''),IF (le.orgweight <> 0,TRIM((SALT311.StrType)le.orgweight), ''),IF (le.ultid <> 0,TRIM((SALT311.StrType)le.ultid), ''),IF (le.ultscore <> 0,TRIM((SALT311.StrType)le.ultscore), ''),IF (le.ultweight <> 0,TRIM((SALT311.StrType)le.ultweight), ''),IF (le.lninscertrecordid <> 0,TRIM((SALT311.StrType)le.lninscertrecordid), ''),TRIM((SALT311.StrType)le.dartid),TRIM((SALT311.StrType)le.insuranceprovider),TRIM((SALT311.StrType)le.policynumber),TRIM((SALT311.StrType)le.coveragestartdate),TRIM((SALT311.StrType)le.coverageexpirationdate),TRIM((SALT311.StrType)le.coveragewrapup),TRIM((SALT311.StrType)le.policystatus),TRIM((SALT311.StrType)le.insuranceprovideraddressline),TRIM((SALT311.StrType)le.insuranceprovideraddressline2),TRIM((SALT311.StrType)le.insuranceprovidercity),TRIM((SALT311.StrType)le.insuranceproviderstate),TRIM((SALT311.StrType)le.insuranceproviderzip),TRIM((SALT311.StrType)le.insuranceproviderzip4),TRIM((SALT311.StrType)le.insuranceproviderphone),TRIM((SALT311.StrType)le.insuranceproviderfax),TRIM((SALT311.StrType)le.coveragereinstatedate),TRIM((SALT311.StrType)le.coveragecancellationdate),TRIM((SALT311.StrType)le.coveragewrapupdate),TRIM((SALT311.StrType)le.businessnameduringcoverage),TRIM((SALT311.StrType)le.addresslineduringcoverage),TRIM((SALT311.StrType)le.addressline2duringcoverage),TRIM((SALT311.StrType)le.cityduringcoverage),TRIM((SALT311.StrType)le.stateduringcoverage),TRIM((SALT311.StrType)le.zipduringcoverage),TRIM((SALT311.StrType)le.zip4duringcoverage),TRIM((SALT311.StrType)le.numberofemployeesduringcoverage),TRIM((SALT311.StrType)le.insuranceprovidercontactdept),TRIM((SALT311.StrType)le.insurancetype),TRIM((SALT311.StrType)le.coverageposteddate),TRIM((SALT311.StrType)le.coverageamountfrom),TRIM((SALT311.StrType)le.coverageamountto),IF (le.unique_id <> 0,TRIM((SALT311.StrType)le.unique_id), ''),TRIM((SALT311.StrType)le.append_mailaddress1),TRIM((SALT311.StrType)le.append_mailaddresslast),IF (le.append_mailrawaid <> 0,TRIM((SALT311.StrType)le.append_mailrawaid), ''),IF (le.append_mailaceaid <> 0,TRIM((SALT311.StrType)le.append_mailaceaid), '')));
  SELF.Fld2 := TRIM(CHOOSE(SELF.FldNo2,IF (le.date_firstseen <> 0,TRIM((SALT311.StrType)le.date_firstseen), ''),IF (le.date_lastseen <> 0,TRIM((SALT311.StrType)le.date_lastseen), ''),IF (le.bdid <> 0,TRIM((SALT311.StrType)le.bdid), ''),IF (le.dotid <> 0,TRIM((SALT311.StrType)le.dotid), ''),IF (le.dotscore <> 0,TRIM((SALT311.StrType)le.dotscore), ''),IF (le.dotweight <> 0,TRIM((SALT311.StrType)le.dotweight), ''),IF (le.empid <> 0,TRIM((SALT311.StrType)le.empid), ''),IF (le.empscore <> 0,TRIM((SALT311.StrType)le.empscore), ''),IF (le.empweight <> 0,TRIM((SALT311.StrType)le.empweight), ''),IF (le.powid <> 0,TRIM((SALT311.StrType)le.powid), ''),IF (le.powscore <> 0,TRIM((SALT311.StrType)le.powscore), ''),IF (le.powweight <> 0,TRIM((SALT311.StrType)le.powweight), ''),IF (le.proxid <> 0,TRIM((SALT311.StrType)le.proxid), ''),IF (le.proxscore <> 0,TRIM((SALT311.StrType)le.proxscore), ''),IF (le.proxweight <> 0,TRIM((SALT311.StrType)le.proxweight), ''),IF (le.seleid <> 0,TRIM((SALT311.StrType)le.seleid), ''),IF (le.selescore <> 0,TRIM((SALT311.StrType)le.selescore), ''),IF (le.seleweight <> 0,TRIM((SALT311.StrType)le.seleweight), ''),IF (le.orgid <> 0,TRIM((SALT311.StrType)le.orgid), ''),IF (le.orgscore <> 0,TRIM((SALT311.StrType)le.orgscore), ''),IF (le.orgweight <> 0,TRIM((SALT311.StrType)le.orgweight), ''),IF (le.ultid <> 0,TRIM((SALT311.StrType)le.ultid), ''),IF (le.ultscore <> 0,TRIM((SALT311.StrType)le.ultscore), ''),IF (le.ultweight <> 0,TRIM((SALT311.StrType)le.ultweight), ''),IF (le.lninscertrecordid <> 0,TRIM((SALT311.StrType)le.lninscertrecordid), ''),TRIM((SALT311.StrType)le.dartid),TRIM((SALT311.StrType)le.insuranceprovider),TRIM((SALT311.StrType)le.policynumber),TRIM((SALT311.StrType)le.coveragestartdate),TRIM((SALT311.StrType)le.coverageexpirationdate),TRIM((SALT311.StrType)le.coveragewrapup),TRIM((SALT311.StrType)le.policystatus),TRIM((SALT311.StrType)le.insuranceprovideraddressline),TRIM((SALT311.StrType)le.insuranceprovideraddressline2),TRIM((SALT311.StrType)le.insuranceprovidercity),TRIM((SALT311.StrType)le.insuranceproviderstate),TRIM((SALT311.StrType)le.insuranceproviderzip),TRIM((SALT311.StrType)le.insuranceproviderzip4),TRIM((SALT311.StrType)le.insuranceproviderphone),TRIM((SALT311.StrType)le.insuranceproviderfax),TRIM((SALT311.StrType)le.coveragereinstatedate),TRIM((SALT311.StrType)le.coveragecancellationdate),TRIM((SALT311.StrType)le.coveragewrapupdate),TRIM((SALT311.StrType)le.businessnameduringcoverage),TRIM((SALT311.StrType)le.addresslineduringcoverage),TRIM((SALT311.StrType)le.addressline2duringcoverage),TRIM((SALT311.StrType)le.cityduringcoverage),TRIM((SALT311.StrType)le.stateduringcoverage),TRIM((SALT311.StrType)le.zipduringcoverage),TRIM((SALT311.StrType)le.zip4duringcoverage),TRIM((SALT311.StrType)le.numberofemployeesduringcoverage),TRIM((SALT311.StrType)le.insuranceprovidercontactdept),TRIM((SALT311.StrType)le.insurancetype),TRIM((SALT311.StrType)le.coverageposteddate),TRIM((SALT311.StrType)le.coverageamountfrom),TRIM((SALT311.StrType)le.coverageamountto),IF (le.unique_id <> 0,TRIM((SALT311.StrType)le.unique_id), ''),TRIM((SALT311.StrType)le.append_mailaddress1),TRIM((SALT311.StrType)le.append_mailaddresslast),IF (le.append_mailrawaid <> 0,TRIM((SALT311.StrType)le.append_mailrawaid), ''),IF (le.append_mailaceaid <> 0,TRIM((SALT311.StrType)le.append_mailaceaid), '')));
  END;
SHARED Pairs0 := NORMALIZE(ENTH(h,Config.CorrelateSampleSize),61*61,IntoP(LEFT,COUNTER))(FldNo1<FldNo2);
SHARED FldIds := DATASET([{1,'date_firstseen'}
      ,{2,'date_lastseen'}
      ,{3,'bdid'}
      ,{4,'dotid'}
      ,{5,'dotscore'}
      ,{6,'dotweight'}
      ,{7,'empid'}
      ,{8,'empscore'}
      ,{9,'empweight'}
      ,{10,'powid'}
      ,{11,'powscore'}
      ,{12,'powweight'}
      ,{13,'proxid'}
      ,{14,'proxscore'}
      ,{15,'proxweight'}
      ,{16,'seleid'}
      ,{17,'selescore'}
      ,{18,'seleweight'}
      ,{19,'orgid'}
      ,{20,'orgscore'}
      ,{21,'orgweight'}
      ,{22,'ultid'}
      ,{23,'ultscore'}
      ,{24,'ultweight'}
      ,{25,'lninscertrecordid'}
      ,{26,'dartid'}
      ,{27,'insuranceprovider'}
      ,{28,'policynumber'}
      ,{29,'coveragestartdate'}
      ,{30,'coverageexpirationdate'}
      ,{31,'coveragewrapup'}
      ,{32,'policystatus'}
      ,{33,'insuranceprovideraddressline'}
      ,{34,'insuranceprovideraddressline2'}
      ,{35,'insuranceprovidercity'}
      ,{36,'insuranceproviderstate'}
      ,{37,'insuranceproviderzip'}
      ,{38,'insuranceproviderzip4'}
      ,{39,'insuranceproviderphone'}
      ,{40,'insuranceproviderfax'}
      ,{41,'coveragereinstatedate'}
      ,{42,'coveragecancellationdate'}
      ,{43,'coveragewrapupdate'}
      ,{44,'businessnameduringcoverage'}
      ,{45,'addresslineduringcoverage'}
      ,{46,'addressline2duringcoverage'}
      ,{47,'cityduringcoverage'}
      ,{48,'stateduringcoverage'}
      ,{49,'zipduringcoverage'}
      ,{50,'zip4duringcoverage'}
      ,{51,'numberofemployeesduringcoverage'}
      ,{52,'insuranceprovidercontactdept'}
      ,{53,'insurancetype'}
      ,{54,'coverageposteddate'}
      ,{55,'coverageamountfrom'}
      ,{56,'coverageamountto'}
      ,{57,'unique_id'}
      ,{58,'append_mailaddress1'}
      ,{59,'append_mailaddresslast'}
      ,{60,'append_mailrawaid'}
      ,{61,'append_mailaceaid'}],SALT311.MAC_Character_Counts.Field_Identification);
EXPORT AllProfiles := SALT311.MAC_Character_Counts.FN_Profile(FldInv0,FldIds);
 
EXPORT SrcProfiles := SALT311.MAC_Character_Counts.Src_Profile(FldInv0,FldIds);
 
EXPORT Correlations := SALT311.MAC_Correlate.Fn_Profile(Pairs0,FldIds);
 
ErrorRecord := RECORD
  UNSIGNED1 FieldNum;
  UNSIGNED1 ErrorNum;
END;
ErrorRecord NoteErrors(h le,UNSIGNED1 c) := TRANSFORM
  SELF.ErrorNum := CHOOSE(c,
    Pol_Fields.InValid_date_firstseen((SALT311.StrType)le.date_firstseen),
    Pol_Fields.InValid_date_lastseen((SALT311.StrType)le.date_lastseen),
    Pol_Fields.InValid_bdid((SALT311.StrType)le.bdid),
    Pol_Fields.InValid_dotid((SALT311.StrType)le.dotid),
    Pol_Fields.InValid_dotscore((SALT311.StrType)le.dotscore),
    Pol_Fields.InValid_dotweight((SALT311.StrType)le.dotweight),
    Pol_Fields.InValid_empid((SALT311.StrType)le.empid),
    Pol_Fields.InValid_empscore((SALT311.StrType)le.empscore),
    Pol_Fields.InValid_empweight((SALT311.StrType)le.empweight),
    Pol_Fields.InValid_powid((SALT311.StrType)le.powid),
    Pol_Fields.InValid_powscore((SALT311.StrType)le.powscore),
    Pol_Fields.InValid_powweight((SALT311.StrType)le.powweight),
    Pol_Fields.InValid_proxid((SALT311.StrType)le.proxid),
    Pol_Fields.InValid_proxscore((SALT311.StrType)le.proxscore),
    Pol_Fields.InValid_proxweight((SALT311.StrType)le.proxweight),
    Pol_Fields.InValid_seleid((SALT311.StrType)le.seleid),
    Pol_Fields.InValid_selescore((SALT311.StrType)le.selescore),
    Pol_Fields.InValid_seleweight((SALT311.StrType)le.seleweight),
    Pol_Fields.InValid_orgid((SALT311.StrType)le.orgid),
    Pol_Fields.InValid_orgscore((SALT311.StrType)le.orgscore),
    Pol_Fields.InValid_orgweight((SALT311.StrType)le.orgweight),
    Pol_Fields.InValid_ultid((SALT311.StrType)le.ultid),
    Pol_Fields.InValid_ultscore((SALT311.StrType)le.ultscore),
    Pol_Fields.InValid_ultweight((SALT311.StrType)le.ultweight),
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
    Pol_Fields.InValid_unique_id((SALT311.StrType)le.unique_id),
    Pol_Fields.InValid_append_mailaddress1((SALT311.StrType)le.append_mailaddress1),
    Pol_Fields.InValid_append_mailaddresslast((SALT311.StrType)le.append_mailaddresslast),
    Pol_Fields.InValid_append_mailrawaid((SALT311.StrType)le.append_mailrawaid),
    Pol_Fields.InValid_append_mailaceaid((SALT311.StrType)le.append_mailaceaid),
    0);
  SELF.FieldNum := IF(SELF.ErrorNum=0,SKIP,c); // Bail early to avoid creating record
END;
Errors := NORMALIZE(h,61,NoteErrors(LEFT,COUNTER));
ErrorRecordsTotals := RECORD
  Errors.FieldNum;
  Errors.ErrorNum;
  UNSIGNED Cnt := COUNT(GROUP);
END;
TotalErrors := TABLE(Errors,ErrorRecordsTotals,FieldNum,ErrorNum,FEW);
PrettyErrorTotals := RECORD
  FieldNme := Pol_Fields.FieldName(TotalErrors.FieldNum);
  FieldType := CHOOSE(TotalErrors.FieldNum,'Invalid_Date','Invalid_Date','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Invalid_No','Invalid_AlphaChar','Invalid_AlphaNumChar','Invalid_Date','Invalid_Date','Invalid_Alpha','Invalid_Alpha','Invalid_AlphaNum','Invalid_AlphaNum','Invalid_AlphaChar','Invalid_State','Invalid_Zip','Invalid_No','Invalid_Phone','Invalid_Phone','Invalid_Date','Invalid_Date','Invalid_Date','Invalid_Alpha','Invalid_AlphaNum','Invalid_AlphaNum','Invalid_AlphaChar','Invalid_State','Invalid_Zip','Invalid_No','Invalid_AlphaNum','Invalid_AlphaNumChar','Invalid_Alpha','Invalid_Date','Invalid_No','Invalid_No','Unknown','Invalid_AlphaNum','Invalid_AlphaNumChar','Unknown','Unknown');
  ErrorMessage := CHOOSE(TotalErrors.FieldNum,Pol_Fields.InValidMessage_date_firstseen(TotalErrors.ErrorNum),Pol_Fields.InValidMessage_date_lastseen(TotalErrors.ErrorNum),Pol_Fields.InValidMessage_bdid(TotalErrors.ErrorNum),Pol_Fields.InValidMessage_dotid(TotalErrors.ErrorNum),Pol_Fields.InValidMessage_dotscore(TotalErrors.ErrorNum),Pol_Fields.InValidMessage_dotweight(TotalErrors.ErrorNum),Pol_Fields.InValidMessage_empid(TotalErrors.ErrorNum),Pol_Fields.InValidMessage_empscore(TotalErrors.ErrorNum),Pol_Fields.InValidMessage_empweight(TotalErrors.ErrorNum),Pol_Fields.InValidMessage_powid(TotalErrors.ErrorNum),Pol_Fields.InValidMessage_powscore(TotalErrors.ErrorNum),Pol_Fields.InValidMessage_powweight(TotalErrors.ErrorNum),Pol_Fields.InValidMessage_proxid(TotalErrors.ErrorNum),Pol_Fields.InValidMessage_proxscore(TotalErrors.ErrorNum),Pol_Fields.InValidMessage_proxweight(TotalErrors.ErrorNum),Pol_Fields.InValidMessage_seleid(TotalErrors.ErrorNum),Pol_Fields.InValidMessage_selescore(TotalErrors.ErrorNum),Pol_Fields.InValidMessage_seleweight(TotalErrors.ErrorNum),Pol_Fields.InValidMessage_orgid(TotalErrors.ErrorNum),Pol_Fields.InValidMessage_orgscore(TotalErrors.ErrorNum),Pol_Fields.InValidMessage_orgweight(TotalErrors.ErrorNum),Pol_Fields.InValidMessage_ultid(TotalErrors.ErrorNum),Pol_Fields.InValidMessage_ultscore(TotalErrors.ErrorNum),Pol_Fields.InValidMessage_ultweight(TotalErrors.ErrorNum),Pol_Fields.InValidMessage_lninscertrecordid(TotalErrors.ErrorNum),Pol_Fields.InValidMessage_dartid(TotalErrors.ErrorNum),Pol_Fields.InValidMessage_insuranceprovider(TotalErrors.ErrorNum),Pol_Fields.InValidMessage_policynumber(TotalErrors.ErrorNum),Pol_Fields.InValidMessage_coveragestartdate(TotalErrors.ErrorNum),Pol_Fields.InValidMessage_coverageexpirationdate(TotalErrors.ErrorNum),Pol_Fields.InValidMessage_coveragewrapup(TotalErrors.ErrorNum),Pol_Fields.InValidMessage_policystatus(TotalErrors.ErrorNum),Pol_Fields.InValidMessage_insuranceprovideraddressline(TotalErrors.ErrorNum),Pol_Fields.InValidMessage_insuranceprovideraddressline2(TotalErrors.ErrorNum),Pol_Fields.InValidMessage_insuranceprovidercity(TotalErrors.ErrorNum),Pol_Fields.InValidMessage_insuranceproviderstate(TotalErrors.ErrorNum),Pol_Fields.InValidMessage_insuranceproviderzip(TotalErrors.ErrorNum),Pol_Fields.InValidMessage_insuranceproviderzip4(TotalErrors.ErrorNum),Pol_Fields.InValidMessage_insuranceproviderphone(TotalErrors.ErrorNum),Pol_Fields.InValidMessage_insuranceproviderfax(TotalErrors.ErrorNum),Pol_Fields.InValidMessage_coveragereinstatedate(TotalErrors.ErrorNum),Pol_Fields.InValidMessage_coveragecancellationdate(TotalErrors.ErrorNum),Pol_Fields.InValidMessage_coveragewrapupdate(TotalErrors.ErrorNum),Pol_Fields.InValidMessage_businessnameduringcoverage(TotalErrors.ErrorNum),Pol_Fields.InValidMessage_addresslineduringcoverage(TotalErrors.ErrorNum),Pol_Fields.InValidMessage_addressline2duringcoverage(TotalErrors.ErrorNum),Pol_Fields.InValidMessage_cityduringcoverage(TotalErrors.ErrorNum),Pol_Fields.InValidMessage_stateduringcoverage(TotalErrors.ErrorNum),Pol_Fields.InValidMessage_zipduringcoverage(TotalErrors.ErrorNum),Pol_Fields.InValidMessage_zip4duringcoverage(TotalErrors.ErrorNum),Pol_Fields.InValidMessage_numberofemployeesduringcoverage(TotalErrors.ErrorNum),Pol_Fields.InValidMessage_insuranceprovidercontactdept(TotalErrors.ErrorNum),Pol_Fields.InValidMessage_insurancetype(TotalErrors.ErrorNum),Pol_Fields.InValidMessage_coverageposteddate(TotalErrors.ErrorNum),Pol_Fields.InValidMessage_coverageamountfrom(TotalErrors.ErrorNum),Pol_Fields.InValidMessage_coverageamountto(TotalErrors.ErrorNum),Pol_Fields.InValidMessage_unique_id(TotalErrors.ErrorNum),Pol_Fields.InValidMessage_append_mailaddress1(TotalErrors.ErrorNum),Pol_Fields.InValidMessage_append_mailaddresslast(TotalErrors.ErrorNum),Pol_Fields.InValidMessage_append_mailrawaid(TotalErrors.ErrorNum),Pol_Fields.InValidMessage_append_mailaceaid(TotalErrors.ErrorNum));
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
