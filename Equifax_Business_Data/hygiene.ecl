IMPORT SALT37;
EXPORT hygiene(dataset(layout_Base) h) := MODULE
 
//A simple summary record
EXPORT Summary(SALT37.Str30Type txt,BOOLEAN Glob=TRUE) := FUNCTION
  SummaryLayout := RECORD
    txt;
    Source := MAX(GROUP,h.source);    NumberOfRecords := COUNT(GROUP);
    populated_dt_first_seen_pcnt := AVE(GROUP,IF(h.dt_first_seen = (TYPEOF(h.dt_first_seen))'',0,100));
    maxlength_dt_first_seen := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.dt_first_seen)));
    avelength_dt_first_seen := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.dt_first_seen)),h.dt_first_seen<>(typeof(h.dt_first_seen))'');
    populated_dt_last_seen_pcnt := AVE(GROUP,IF(h.dt_last_seen = (TYPEOF(h.dt_last_seen))'',0,100));
    maxlength_dt_last_seen := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.dt_last_seen)));
    avelength_dt_last_seen := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.dt_last_seen)),h.dt_last_seen<>(typeof(h.dt_last_seen))'');
    populated_dt_vendor_first_reported_pcnt := AVE(GROUP,IF(h.dt_vendor_first_reported = (TYPEOF(h.dt_vendor_first_reported))'',0,100));
    maxlength_dt_vendor_first_reported := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.dt_vendor_first_reported)));
    avelength_dt_vendor_first_reported := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.dt_vendor_first_reported)),h.dt_vendor_first_reported<>(typeof(h.dt_vendor_first_reported))'');
    populated_dt_vendor_last_reported_pcnt := AVE(GROUP,IF(h.dt_vendor_last_reported = (TYPEOF(h.dt_vendor_last_reported))'',0,100));
    maxlength_dt_vendor_last_reported := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.dt_vendor_last_reported)));
    avelength_dt_vendor_last_reported := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.dt_vendor_last_reported)),h.dt_vendor_last_reported<>(typeof(h.dt_vendor_last_reported))'');
    populated_dt_effective_first_pcnt := AVE(GROUP,IF(h.dt_effective_first = (TYPEOF(h.dt_effective_first))'',0,100));
    maxlength_dt_effective_first := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.dt_effective_first)));
    avelength_dt_effective_first := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.dt_effective_first)),h.dt_effective_first<>(typeof(h.dt_effective_first))'');
    populated_dt_effective_last_pcnt := AVE(GROUP,IF(h.dt_effective_last = (TYPEOF(h.dt_effective_last))'',0,100));
    maxlength_dt_effective_last := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.dt_effective_last)));
    avelength_dt_effective_last := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.dt_effective_last)),h.dt_effective_last<>(typeof(h.dt_effective_last))'');
    populated_process_date_pcnt := AVE(GROUP,IF(h.process_date = (TYPEOF(h.process_date))'',0,100));
    maxlength_process_date := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.process_date)));
    avelength_process_date := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.process_date)),h.process_date<>(typeof(h.process_date))'');
    populated_dotid_pcnt := AVE(GROUP,IF(h.dotid = (TYPEOF(h.dotid))'',0,100));
    maxlength_dotid := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.dotid)));
    avelength_dotid := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.dotid)),h.dotid<>(typeof(h.dotid))'');
    populated_dotscore_pcnt := AVE(GROUP,IF(h.dotscore = (TYPEOF(h.dotscore))'',0,100));
    maxlength_dotscore := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.dotscore)));
    avelength_dotscore := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.dotscore)),h.dotscore<>(typeof(h.dotscore))'');
    populated_dotweight_pcnt := AVE(GROUP,IF(h.dotweight = (TYPEOF(h.dotweight))'',0,100));
    maxlength_dotweight := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.dotweight)));
    avelength_dotweight := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.dotweight)),h.dotweight<>(typeof(h.dotweight))'');
    populated_empid_pcnt := AVE(GROUP,IF(h.empid = (TYPEOF(h.empid))'',0,100));
    maxlength_empid := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.empid)));
    avelength_empid := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.empid)),h.empid<>(typeof(h.empid))'');
    populated_empscore_pcnt := AVE(GROUP,IF(h.empscore = (TYPEOF(h.empscore))'',0,100));
    maxlength_empscore := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.empscore)));
    avelength_empscore := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.empscore)),h.empscore<>(typeof(h.empscore))'');
    populated_empweight_pcnt := AVE(GROUP,IF(h.empweight = (TYPEOF(h.empweight))'',0,100));
    maxlength_empweight := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.empweight)));
    avelength_empweight := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.empweight)),h.empweight<>(typeof(h.empweight))'');
    populated_powid_pcnt := AVE(GROUP,IF(h.powid = (TYPEOF(h.powid))'',0,100));
    maxlength_powid := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.powid)));
    avelength_powid := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.powid)),h.powid<>(typeof(h.powid))'');
    populated_powscore_pcnt := AVE(GROUP,IF(h.powscore = (TYPEOF(h.powscore))'',0,100));
    maxlength_powscore := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.powscore)));
    avelength_powscore := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.powscore)),h.powscore<>(typeof(h.powscore))'');
    populated_powweight_pcnt := AVE(GROUP,IF(h.powweight = (TYPEOF(h.powweight))'',0,100));
    maxlength_powweight := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.powweight)));
    avelength_powweight := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.powweight)),h.powweight<>(typeof(h.powweight))'');
    populated_proxid_pcnt := AVE(GROUP,IF(h.proxid = (TYPEOF(h.proxid))'',0,100));
    maxlength_proxid := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.proxid)));
    avelength_proxid := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.proxid)),h.proxid<>(typeof(h.proxid))'');
    populated_proxscore_pcnt := AVE(GROUP,IF(h.proxscore = (TYPEOF(h.proxscore))'',0,100));
    maxlength_proxscore := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.proxscore)));
    avelength_proxscore := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.proxscore)),h.proxscore<>(typeof(h.proxscore))'');
    populated_proxweight_pcnt := AVE(GROUP,IF(h.proxweight = (TYPEOF(h.proxweight))'',0,100));
    maxlength_proxweight := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.proxweight)));
    avelength_proxweight := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.proxweight)),h.proxweight<>(typeof(h.proxweight))'');
    populated_selescore_pcnt := AVE(GROUP,IF(h.selescore = (TYPEOF(h.selescore))'',0,100));
    maxlength_selescore := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.selescore)));
    avelength_selescore := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.selescore)),h.selescore<>(typeof(h.selescore))'');
    populated_seleweight_pcnt := AVE(GROUP,IF(h.seleweight = (TYPEOF(h.seleweight))'',0,100));
    maxlength_seleweight := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.seleweight)));
    avelength_seleweight := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.seleweight)),h.seleweight<>(typeof(h.seleweight))'');
    populated_orgid_pcnt := AVE(GROUP,IF(h.orgid = (TYPEOF(h.orgid))'',0,100));
    maxlength_orgid := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.orgid)));
    avelength_orgid := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.orgid)),h.orgid<>(typeof(h.orgid))'');
    populated_orgscore_pcnt := AVE(GROUP,IF(h.orgscore = (TYPEOF(h.orgscore))'',0,100));
    maxlength_orgscore := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.orgscore)));
    avelength_orgscore := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.orgscore)),h.orgscore<>(typeof(h.orgscore))'');
    populated_orgweight_pcnt := AVE(GROUP,IF(h.orgweight = (TYPEOF(h.orgweight))'',0,100));
    maxlength_orgweight := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.orgweight)));
    avelength_orgweight := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.orgweight)),h.orgweight<>(typeof(h.orgweight))'');
    populated_ultid_pcnt := AVE(GROUP,IF(h.ultid = (TYPEOF(h.ultid))'',0,100));
    maxlength_ultid := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.ultid)));
    avelength_ultid := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.ultid)),h.ultid<>(typeof(h.ultid))'');
    populated_ultscore_pcnt := AVE(GROUP,IF(h.ultscore = (TYPEOF(h.ultscore))'',0,100));
    maxlength_ultscore := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.ultscore)));
    avelength_ultscore := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.ultscore)),h.ultscore<>(typeof(h.ultscore))'');
    populated_ultweight_pcnt := AVE(GROUP,IF(h.ultweight = (TYPEOF(h.ultweight))'',0,100));
    maxlength_ultweight := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.ultweight)));
    avelength_ultweight := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.ultweight)),h.ultweight<>(typeof(h.ultweight))'');
    populated_record_type_pcnt := AVE(GROUP,IF(h.record_type = (TYPEOF(h.record_type))'',0,100));
    maxlength_record_type := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.record_type)));
    avelength_record_type := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.record_type)),h.record_type<>(typeof(h.record_type))'');
    populated_EFX_ID_pcnt := AVE(GROUP,IF(h.EFX_ID = (TYPEOF(h.EFX_ID))'',0,100));
    maxlength_EFX_ID := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.EFX_ID)));
    avelength_EFX_ID := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.EFX_ID)),h.EFX_ID<>(typeof(h.EFX_ID))'');
    populated_EFX_NAME_pcnt := AVE(GROUP,IF(h.EFX_NAME = (TYPEOF(h.EFX_NAME))'',0,100));
    maxlength_EFX_NAME := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.EFX_NAME)));
    avelength_EFX_NAME := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.EFX_NAME)),h.EFX_NAME<>(typeof(h.EFX_NAME))'');
    populated_EFX_LEGAL_NAME_pcnt := AVE(GROUP,IF(h.EFX_LEGAL_NAME = (TYPEOF(h.EFX_LEGAL_NAME))'',0,100));
    maxlength_EFX_LEGAL_NAME := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.EFX_LEGAL_NAME)));
    avelength_EFX_LEGAL_NAME := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.EFX_LEGAL_NAME)),h.EFX_LEGAL_NAME<>(typeof(h.EFX_LEGAL_NAME))'');
    populated_EFX_ADDRESS_pcnt := AVE(GROUP,IF(h.EFX_ADDRESS = (TYPEOF(h.EFX_ADDRESS))'',0,100));
    maxlength_EFX_ADDRESS := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.EFX_ADDRESS)));
    avelength_EFX_ADDRESS := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.EFX_ADDRESS)),h.EFX_ADDRESS<>(typeof(h.EFX_ADDRESS))'');
    populated_EFX_CITY_pcnt := AVE(GROUP,IF(h.EFX_CITY = (TYPEOF(h.EFX_CITY))'',0,100));
    maxlength_EFX_CITY := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.EFX_CITY)));
    avelength_EFX_CITY := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.EFX_CITY)),h.EFX_CITY<>(typeof(h.EFX_CITY))'');
    populated_EFX_STATE_pcnt := AVE(GROUP,IF(h.EFX_STATE = (TYPEOF(h.EFX_STATE))'',0,100));
    maxlength_EFX_STATE := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.EFX_STATE)));
    avelength_EFX_STATE := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.EFX_STATE)),h.EFX_STATE<>(typeof(h.EFX_STATE))'');
    populated_EFX_STATEC_pcnt := AVE(GROUP,IF(h.EFX_STATEC = (TYPEOF(h.EFX_STATEC))'',0,100));
    maxlength_EFX_STATEC := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.EFX_STATEC)));
    avelength_EFX_STATEC := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.EFX_STATEC)),h.EFX_STATEC<>(typeof(h.EFX_STATEC))'');
    populated_EFX_ZIPCODE_pcnt := AVE(GROUP,IF(h.EFX_ZIPCODE = (TYPEOF(h.EFX_ZIPCODE))'',0,100));
    maxlength_EFX_ZIPCODE := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.EFX_ZIPCODE)));
    avelength_EFX_ZIPCODE := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.EFX_ZIPCODE)),h.EFX_ZIPCODE<>(typeof(h.EFX_ZIPCODE))'');
    populated_EFX_ZIP4_pcnt := AVE(GROUP,IF(h.EFX_ZIP4 = (TYPEOF(h.EFX_ZIP4))'',0,100));
    maxlength_EFX_ZIP4 := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.EFX_ZIP4)));
    avelength_EFX_ZIP4 := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.EFX_ZIP4)),h.EFX_ZIP4<>(typeof(h.EFX_ZIP4))'');
    populated_EFX_LAT_pcnt := AVE(GROUP,IF(h.EFX_LAT = (TYPEOF(h.EFX_LAT))'',0,100));
    maxlength_EFX_LAT := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.EFX_LAT)));
    avelength_EFX_LAT := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.EFX_LAT)),h.EFX_LAT<>(typeof(h.EFX_LAT))'');
    populated_EFX_LON_pcnt := AVE(GROUP,IF(h.EFX_LON = (TYPEOF(h.EFX_LON))'',0,100));
    maxlength_EFX_LON := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.EFX_LON)));
    avelength_EFX_LON := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.EFX_LON)),h.EFX_LON<>(typeof(h.EFX_LON))'');
    populated_EFX_GEOPREC_pcnt := AVE(GROUP,IF(h.EFX_GEOPREC = (TYPEOF(h.EFX_GEOPREC))'',0,100));
    maxlength_EFX_GEOPREC := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.EFX_GEOPREC)));
    avelength_EFX_GEOPREC := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.EFX_GEOPREC)),h.EFX_GEOPREC<>(typeof(h.EFX_GEOPREC))'');
    populated_EFX_REGION_pcnt := AVE(GROUP,IF(h.EFX_REGION = (TYPEOF(h.EFX_REGION))'',0,100));
    maxlength_EFX_REGION := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.EFX_REGION)));
    avelength_EFX_REGION := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.EFX_REGION)),h.EFX_REGION<>(typeof(h.EFX_REGION))'');
    populated_EFX_CTRYISOCD_pcnt := AVE(GROUP,IF(h.EFX_CTRYISOCD = (TYPEOF(h.EFX_CTRYISOCD))'',0,100));
    maxlength_EFX_CTRYISOCD := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.EFX_CTRYISOCD)));
    avelength_EFX_CTRYISOCD := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.EFX_CTRYISOCD)),h.EFX_CTRYISOCD<>(typeof(h.EFX_CTRYISOCD))'');
    populated_EFX_CTRYNUM_pcnt := AVE(GROUP,IF(h.EFX_CTRYNUM = (TYPEOF(h.EFX_CTRYNUM))'',0,100));
    maxlength_EFX_CTRYNUM := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.EFX_CTRYNUM)));
    avelength_EFX_CTRYNUM := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.EFX_CTRYNUM)),h.EFX_CTRYNUM<>(typeof(h.EFX_CTRYNUM))'');
    populated_EFX_CTRYNAME_pcnt := AVE(GROUP,IF(h.EFX_CTRYNAME = (TYPEOF(h.EFX_CTRYNAME))'',0,100));
    maxlength_EFX_CTRYNAME := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.EFX_CTRYNAME)));
    avelength_EFX_CTRYNAME := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.EFX_CTRYNAME)),h.EFX_CTRYNAME<>(typeof(h.EFX_CTRYNAME))'');
    populated_EFX_COUNTYNM_pcnt := AVE(GROUP,IF(h.EFX_COUNTYNM = (TYPEOF(h.EFX_COUNTYNM))'',0,100));
    maxlength_EFX_COUNTYNM := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.EFX_COUNTYNM)));
    avelength_EFX_COUNTYNM := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.EFX_COUNTYNM)),h.EFX_COUNTYNM<>(typeof(h.EFX_COUNTYNM))'');
    populated_EFX_COUNTY_pcnt := AVE(GROUP,IF(h.EFX_COUNTY = (TYPEOF(h.EFX_COUNTY))'',0,100));
    maxlength_EFX_COUNTY := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.EFX_COUNTY)));
    avelength_EFX_COUNTY := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.EFX_COUNTY)),h.EFX_COUNTY<>(typeof(h.EFX_COUNTY))'');
    populated_EFX_CMSA_pcnt := AVE(GROUP,IF(h.EFX_CMSA = (TYPEOF(h.EFX_CMSA))'',0,100));
    maxlength_EFX_CMSA := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.EFX_CMSA)));
    avelength_EFX_CMSA := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.EFX_CMSA)),h.EFX_CMSA<>(typeof(h.EFX_CMSA))'');
    populated_EFX_CMSADESC_pcnt := AVE(GROUP,IF(h.EFX_CMSADESC = (TYPEOF(h.EFX_CMSADESC))'',0,100));
    maxlength_EFX_CMSADESC := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.EFX_CMSADESC)));
    avelength_EFX_CMSADESC := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.EFX_CMSADESC)),h.EFX_CMSADESC<>(typeof(h.EFX_CMSADESC))'');
    populated_EFX_SOHO_pcnt := AVE(GROUP,IF(h.EFX_SOHO = (TYPEOF(h.EFX_SOHO))'',0,100));
    maxlength_EFX_SOHO := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.EFX_SOHO)));
    avelength_EFX_SOHO := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.EFX_SOHO)),h.EFX_SOHO<>(typeof(h.EFX_SOHO))'');
    populated_EFX_BIZ_pcnt := AVE(GROUP,IF(h.EFX_BIZ = (TYPEOF(h.EFX_BIZ))'',0,100));
    maxlength_EFX_BIZ := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.EFX_BIZ)));
    avelength_EFX_BIZ := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.EFX_BIZ)),h.EFX_BIZ<>(typeof(h.EFX_BIZ))'');
    populated_EFX_RES_pcnt := AVE(GROUP,IF(h.EFX_RES = (TYPEOF(h.EFX_RES))'',0,100));
    maxlength_EFX_RES := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.EFX_RES)));
    avelength_EFX_RES := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.EFX_RES)),h.EFX_RES<>(typeof(h.EFX_RES))'');
    populated_EFX_CMRA_pcnt := AVE(GROUP,IF(h.EFX_CMRA = (TYPEOF(h.EFX_CMRA))'',0,100));
    maxlength_EFX_CMRA := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.EFX_CMRA)));
    avelength_EFX_CMRA := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.EFX_CMRA)),h.EFX_CMRA<>(typeof(h.EFX_CMRA))'');
    populated_EFX_CONGRESS_pcnt := AVE(GROUP,IF(h.EFX_CONGRESS = (TYPEOF(h.EFX_CONGRESS))'',0,100));
    maxlength_EFX_CONGRESS := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.EFX_CONGRESS)));
    avelength_EFX_CONGRESS := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.EFX_CONGRESS)),h.EFX_CONGRESS<>(typeof(h.EFX_CONGRESS))'');
    populated_EFX_SECADR_pcnt := AVE(GROUP,IF(h.EFX_SECADR = (TYPEOF(h.EFX_SECADR))'',0,100));
    maxlength_EFX_SECADR := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.EFX_SECADR)));
    avelength_EFX_SECADR := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.EFX_SECADR)),h.EFX_SECADR<>(typeof(h.EFX_SECADR))'');
    populated_EFX_SECCTY_pcnt := AVE(GROUP,IF(h.EFX_SECCTY = (TYPEOF(h.EFX_SECCTY))'',0,100));
    maxlength_EFX_SECCTY := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.EFX_SECCTY)));
    avelength_EFX_SECCTY := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.EFX_SECCTY)),h.EFX_SECCTY<>(typeof(h.EFX_SECCTY))'');
    populated_EFX_SECSTAT_pcnt := AVE(GROUP,IF(h.EFX_SECSTAT = (TYPEOF(h.EFX_SECSTAT))'',0,100));
    maxlength_EFX_SECSTAT := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.EFX_SECSTAT)));
    avelength_EFX_SECSTAT := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.EFX_SECSTAT)),h.EFX_SECSTAT<>(typeof(h.EFX_SECSTAT))'');
    populated_EFX_STATEC2_pcnt := AVE(GROUP,IF(h.EFX_STATEC2 = (TYPEOF(h.EFX_STATEC2))'',0,100));
    maxlength_EFX_STATEC2 := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.EFX_STATEC2)));
    avelength_EFX_STATEC2 := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.EFX_STATEC2)),h.EFX_STATEC2<>(typeof(h.EFX_STATEC2))'');
    populated_EFX_SECZIP_pcnt := AVE(GROUP,IF(h.EFX_SECZIP = (TYPEOF(h.EFX_SECZIP))'',0,100));
    maxlength_EFX_SECZIP := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.EFX_SECZIP)));
    avelength_EFX_SECZIP := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.EFX_SECZIP)),h.EFX_SECZIP<>(typeof(h.EFX_SECZIP))'');
    populated_EFX_SECZIP4_pcnt := AVE(GROUP,IF(h.EFX_SECZIP4 = (TYPEOF(h.EFX_SECZIP4))'',0,100));
    maxlength_EFX_SECZIP4 := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.EFX_SECZIP4)));
    avelength_EFX_SECZIP4 := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.EFX_SECZIP4)),h.EFX_SECZIP4<>(typeof(h.EFX_SECZIP4))'');
    populated_EFX_SECLAT_pcnt := AVE(GROUP,IF(h.EFX_SECLAT = (TYPEOF(h.EFX_SECLAT))'',0,100));
    maxlength_EFX_SECLAT := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.EFX_SECLAT)));
    avelength_EFX_SECLAT := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.EFX_SECLAT)),h.EFX_SECLAT<>(typeof(h.EFX_SECLAT))'');
    populated_EFX_SECLON_pcnt := AVE(GROUP,IF(h.EFX_SECLON = (TYPEOF(h.EFX_SECLON))'',0,100));
    maxlength_EFX_SECLON := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.EFX_SECLON)));
    avelength_EFX_SECLON := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.EFX_SECLON)),h.EFX_SECLON<>(typeof(h.EFX_SECLON))'');
    populated_EFX_SECGEOPREC_pcnt := AVE(GROUP,IF(h.EFX_SECGEOPREC = (TYPEOF(h.EFX_SECGEOPREC))'',0,100));
    maxlength_EFX_SECGEOPREC := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.EFX_SECGEOPREC)));
    avelength_EFX_SECGEOPREC := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.EFX_SECGEOPREC)),h.EFX_SECGEOPREC<>(typeof(h.EFX_SECGEOPREC))'');
    populated_EFX_SECREGION_pcnt := AVE(GROUP,IF(h.EFX_SECREGION = (TYPEOF(h.EFX_SECREGION))'',0,100));
    maxlength_EFX_SECREGION := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.EFX_SECREGION)));
    avelength_EFX_SECREGION := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.EFX_SECREGION)),h.EFX_SECREGION<>(typeof(h.EFX_SECREGION))'');
    populated_EFX_SECCTRYISOCD_pcnt := AVE(GROUP,IF(h.EFX_SECCTRYISOCD = (TYPEOF(h.EFX_SECCTRYISOCD))'',0,100));
    maxlength_EFX_SECCTRYISOCD := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.EFX_SECCTRYISOCD)));
    avelength_EFX_SECCTRYISOCD := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.EFX_SECCTRYISOCD)),h.EFX_SECCTRYISOCD<>(typeof(h.EFX_SECCTRYISOCD))'');
    populated_EFX_SECCTRYNUM_pcnt := AVE(GROUP,IF(h.EFX_SECCTRYNUM = (TYPEOF(h.EFX_SECCTRYNUM))'',0,100));
    maxlength_EFX_SECCTRYNUM := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.EFX_SECCTRYNUM)));
    avelength_EFX_SECCTRYNUM := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.EFX_SECCTRYNUM)),h.EFX_SECCTRYNUM<>(typeof(h.EFX_SECCTRYNUM))'');
    populated_EFX_SECCTRYNAME_pcnt := AVE(GROUP,IF(h.EFX_SECCTRYNAME = (TYPEOF(h.EFX_SECCTRYNAME))'',0,100));
    maxlength_EFX_SECCTRYNAME := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.EFX_SECCTRYNAME)));
    avelength_EFX_SECCTRYNAME := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.EFX_SECCTRYNAME)),h.EFX_SECCTRYNAME<>(typeof(h.EFX_SECCTRYNAME))'');
    populated_EFX_CTRYTELCD_pcnt := AVE(GROUP,IF(h.EFX_CTRYTELCD = (TYPEOF(h.EFX_CTRYTELCD))'',0,100));
    maxlength_EFX_CTRYTELCD := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.EFX_CTRYTELCD)));
    avelength_EFX_CTRYTELCD := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.EFX_CTRYTELCD)),h.EFX_CTRYTELCD<>(typeof(h.EFX_CTRYTELCD))'');
    populated_EFX_PHONE_pcnt := AVE(GROUP,IF(h.EFX_PHONE = (TYPEOF(h.EFX_PHONE))'',0,100));
    maxlength_EFX_PHONE := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.EFX_PHONE)));
    avelength_EFX_PHONE := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.EFX_PHONE)),h.EFX_PHONE<>(typeof(h.EFX_PHONE))'');
    populated_EFX_FAXPHONE_pcnt := AVE(GROUP,IF(h.EFX_FAXPHONE = (TYPEOF(h.EFX_FAXPHONE))'',0,100));
    maxlength_EFX_FAXPHONE := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.EFX_FAXPHONE)));
    avelength_EFX_FAXPHONE := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.EFX_FAXPHONE)),h.EFX_FAXPHONE<>(typeof(h.EFX_FAXPHONE))'');
    populated_EFX_BUSSTAT_pcnt := AVE(GROUP,IF(h.EFX_BUSSTAT = (TYPEOF(h.EFX_BUSSTAT))'',0,100));
    maxlength_EFX_BUSSTAT := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.EFX_BUSSTAT)));
    avelength_EFX_BUSSTAT := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.EFX_BUSSTAT)),h.EFX_BUSSTAT<>(typeof(h.EFX_BUSSTAT))'');
    populated_EFX_BUSSTATCD_pcnt := AVE(GROUP,IF(h.EFX_BUSSTATCD = (TYPEOF(h.EFX_BUSSTATCD))'',0,100));
    maxlength_EFX_BUSSTATCD := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.EFX_BUSSTATCD)));
    avelength_EFX_BUSSTATCD := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.EFX_BUSSTATCD)),h.EFX_BUSSTATCD<>(typeof(h.EFX_BUSSTATCD))'');
    populated_EFX_WEB_pcnt := AVE(GROUP,IF(h.EFX_WEB = (TYPEOF(h.EFX_WEB))'',0,100));
    maxlength_EFX_WEB := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.EFX_WEB)));
    avelength_EFX_WEB := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.EFX_WEB)),h.EFX_WEB<>(typeof(h.EFX_WEB))'');
    populated_EFX_YREST_pcnt := AVE(GROUP,IF(h.EFX_YREST = (TYPEOF(h.EFX_YREST))'',0,100));
    maxlength_EFX_YREST := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.EFX_YREST)));
    avelength_EFX_YREST := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.EFX_YREST)),h.EFX_YREST<>(typeof(h.EFX_YREST))'');
    populated_EFX_CORPEMPCNT_pcnt := AVE(GROUP,IF(h.EFX_CORPEMPCNT = (TYPEOF(h.EFX_CORPEMPCNT))'',0,100));
    maxlength_EFX_CORPEMPCNT := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.EFX_CORPEMPCNT)));
    avelength_EFX_CORPEMPCNT := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.EFX_CORPEMPCNT)),h.EFX_CORPEMPCNT<>(typeof(h.EFX_CORPEMPCNT))'');
    populated_EFX_LOCEMPCNT_pcnt := AVE(GROUP,IF(h.EFX_LOCEMPCNT = (TYPEOF(h.EFX_LOCEMPCNT))'',0,100));
    maxlength_EFX_LOCEMPCNT := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.EFX_LOCEMPCNT)));
    avelength_EFX_LOCEMPCNT := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.EFX_LOCEMPCNT)),h.EFX_LOCEMPCNT<>(typeof(h.EFX_LOCEMPCNT))'');
    populated_EFX_CORPEMPCD_pcnt := AVE(GROUP,IF(h.EFX_CORPEMPCD = (TYPEOF(h.EFX_CORPEMPCD))'',0,100));
    maxlength_EFX_CORPEMPCD := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.EFX_CORPEMPCD)));
    avelength_EFX_CORPEMPCD := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.EFX_CORPEMPCD)),h.EFX_CORPEMPCD<>(typeof(h.EFX_CORPEMPCD))'');
    populated_EFX_LOCEMPCD_pcnt := AVE(GROUP,IF(h.EFX_LOCEMPCD = (TYPEOF(h.EFX_LOCEMPCD))'',0,100));
    maxlength_EFX_LOCEMPCD := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.EFX_LOCEMPCD)));
    avelength_EFX_LOCEMPCD := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.EFX_LOCEMPCD)),h.EFX_LOCEMPCD<>(typeof(h.EFX_LOCEMPCD))'');
    populated_EFX_CORPAMOUNT_pcnt := AVE(GROUP,IF(h.EFX_CORPAMOUNT = (TYPEOF(h.EFX_CORPAMOUNT))'',0,100));
    maxlength_EFX_CORPAMOUNT := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.EFX_CORPAMOUNT)));
    avelength_EFX_CORPAMOUNT := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.EFX_CORPAMOUNT)),h.EFX_CORPAMOUNT<>(typeof(h.EFX_CORPAMOUNT))'');
    populated_EFX_CORPAMOUNTCD_pcnt := AVE(GROUP,IF(h.EFX_CORPAMOUNTCD = (TYPEOF(h.EFX_CORPAMOUNTCD))'',0,100));
    maxlength_EFX_CORPAMOUNTCD := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.EFX_CORPAMOUNTCD)));
    avelength_EFX_CORPAMOUNTCD := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.EFX_CORPAMOUNTCD)),h.EFX_CORPAMOUNTCD<>(typeof(h.EFX_CORPAMOUNTCD))'');
    populated_EFX_CORPAMOUNTTP_pcnt := AVE(GROUP,IF(h.EFX_CORPAMOUNTTP = (TYPEOF(h.EFX_CORPAMOUNTTP))'',0,100));
    maxlength_EFX_CORPAMOUNTTP := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.EFX_CORPAMOUNTTP)));
    avelength_EFX_CORPAMOUNTTP := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.EFX_CORPAMOUNTTP)),h.EFX_CORPAMOUNTTP<>(typeof(h.EFX_CORPAMOUNTTP))'');
    populated_EFX_CORPAMOUNTPREC_pcnt := AVE(GROUP,IF(h.EFX_CORPAMOUNTPREC = (TYPEOF(h.EFX_CORPAMOUNTPREC))'',0,100));
    maxlength_EFX_CORPAMOUNTPREC := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.EFX_CORPAMOUNTPREC)));
    avelength_EFX_CORPAMOUNTPREC := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.EFX_CORPAMOUNTPREC)),h.EFX_CORPAMOUNTPREC<>(typeof(h.EFX_CORPAMOUNTPREC))'');
    populated_EFX_LOCAMOUNT_pcnt := AVE(GROUP,IF(h.EFX_LOCAMOUNT = (TYPEOF(h.EFX_LOCAMOUNT))'',0,100));
    maxlength_EFX_LOCAMOUNT := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.EFX_LOCAMOUNT)));
    avelength_EFX_LOCAMOUNT := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.EFX_LOCAMOUNT)),h.EFX_LOCAMOUNT<>(typeof(h.EFX_LOCAMOUNT))'');
    populated_EFX_LOCAMOUNTCD_pcnt := AVE(GROUP,IF(h.EFX_LOCAMOUNTCD = (TYPEOF(h.EFX_LOCAMOUNTCD))'',0,100));
    maxlength_EFX_LOCAMOUNTCD := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.EFX_LOCAMOUNTCD)));
    avelength_EFX_LOCAMOUNTCD := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.EFX_LOCAMOUNTCD)),h.EFX_LOCAMOUNTCD<>(typeof(h.EFX_LOCAMOUNTCD))'');
    populated_EFX_LOCAMOUNTTP_pcnt := AVE(GROUP,IF(h.EFX_LOCAMOUNTTP = (TYPEOF(h.EFX_LOCAMOUNTTP))'',0,100));
    maxlength_EFX_LOCAMOUNTTP := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.EFX_LOCAMOUNTTP)));
    avelength_EFX_LOCAMOUNTTP := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.EFX_LOCAMOUNTTP)),h.EFX_LOCAMOUNTTP<>(typeof(h.EFX_LOCAMOUNTTP))'');
    populated_EFX_LOCAMOUNTPREC_pcnt := AVE(GROUP,IF(h.EFX_LOCAMOUNTPREC = (TYPEOF(h.EFX_LOCAMOUNTPREC))'',0,100));
    maxlength_EFX_LOCAMOUNTPREC := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.EFX_LOCAMOUNTPREC)));
    avelength_EFX_LOCAMOUNTPREC := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.EFX_LOCAMOUNTPREC)),h.EFX_LOCAMOUNTPREC<>(typeof(h.EFX_LOCAMOUNTPREC))'');
    populated_EFX_PUBLIC_pcnt := AVE(GROUP,IF(h.EFX_PUBLIC = (TYPEOF(h.EFX_PUBLIC))'',0,100));
    maxlength_EFX_PUBLIC := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.EFX_PUBLIC)));
    avelength_EFX_PUBLIC := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.EFX_PUBLIC)),h.EFX_PUBLIC<>(typeof(h.EFX_PUBLIC))'');
    populated_EFX_STKEXC_pcnt := AVE(GROUP,IF(h.EFX_STKEXC = (TYPEOF(h.EFX_STKEXC))'',0,100));
    maxlength_EFX_STKEXC := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.EFX_STKEXC)));
    avelength_EFX_STKEXC := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.EFX_STKEXC)),h.EFX_STKEXC<>(typeof(h.EFX_STKEXC))'');
    populated_EFX_TCKSYM_pcnt := AVE(GROUP,IF(h.EFX_TCKSYM = (TYPEOF(h.EFX_TCKSYM))'',0,100));
    maxlength_EFX_TCKSYM := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.EFX_TCKSYM)));
    avelength_EFX_TCKSYM := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.EFX_TCKSYM)),h.EFX_TCKSYM<>(typeof(h.EFX_TCKSYM))'');
    populated_EFX_PRIMSIC_pcnt := AVE(GROUP,IF(h.EFX_PRIMSIC = (TYPEOF(h.EFX_PRIMSIC))'',0,100));
    maxlength_EFX_PRIMSIC := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.EFX_PRIMSIC)));
    avelength_EFX_PRIMSIC := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.EFX_PRIMSIC)),h.EFX_PRIMSIC<>(typeof(h.EFX_PRIMSIC))'');
    populated_EFX_SECSIC1_pcnt := AVE(GROUP,IF(h.EFX_SECSIC1 = (TYPEOF(h.EFX_SECSIC1))'',0,100));
    maxlength_EFX_SECSIC1 := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.EFX_SECSIC1)));
    avelength_EFX_SECSIC1 := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.EFX_SECSIC1)),h.EFX_SECSIC1<>(typeof(h.EFX_SECSIC1))'');
    populated_EFX_SECSIC2_pcnt := AVE(GROUP,IF(h.EFX_SECSIC2 = (TYPEOF(h.EFX_SECSIC2))'',0,100));
    maxlength_EFX_SECSIC2 := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.EFX_SECSIC2)));
    avelength_EFX_SECSIC2 := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.EFX_SECSIC2)),h.EFX_SECSIC2<>(typeof(h.EFX_SECSIC2))'');
    populated_EFX_SECSIC3_pcnt := AVE(GROUP,IF(h.EFX_SECSIC3 = (TYPEOF(h.EFX_SECSIC3))'',0,100));
    maxlength_EFX_SECSIC3 := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.EFX_SECSIC3)));
    avelength_EFX_SECSIC3 := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.EFX_SECSIC3)),h.EFX_SECSIC3<>(typeof(h.EFX_SECSIC3))'');
    populated_EFX_SECSIC4_pcnt := AVE(GROUP,IF(h.EFX_SECSIC4 = (TYPEOF(h.EFX_SECSIC4))'',0,100));
    maxlength_EFX_SECSIC4 := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.EFX_SECSIC4)));
    avelength_EFX_SECSIC4 := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.EFX_SECSIC4)),h.EFX_SECSIC4<>(typeof(h.EFX_SECSIC4))'');
    populated_EFX_PRIMSICDESC_pcnt := AVE(GROUP,IF(h.EFX_PRIMSICDESC = (TYPEOF(h.EFX_PRIMSICDESC))'',0,100));
    maxlength_EFX_PRIMSICDESC := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.EFX_PRIMSICDESC)));
    avelength_EFX_PRIMSICDESC := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.EFX_PRIMSICDESC)),h.EFX_PRIMSICDESC<>(typeof(h.EFX_PRIMSICDESC))'');
    populated_EFX_SECSICDESC1_pcnt := AVE(GROUP,IF(h.EFX_SECSICDESC1 = (TYPEOF(h.EFX_SECSICDESC1))'',0,100));
    maxlength_EFX_SECSICDESC1 := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.EFX_SECSICDESC1)));
    avelength_EFX_SECSICDESC1 := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.EFX_SECSICDESC1)),h.EFX_SECSICDESC1<>(typeof(h.EFX_SECSICDESC1))'');
    populated_EFX_SECSICDESC2_pcnt := AVE(GROUP,IF(h.EFX_SECSICDESC2 = (TYPEOF(h.EFX_SECSICDESC2))'',0,100));
    maxlength_EFX_SECSICDESC2 := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.EFX_SECSICDESC2)));
    avelength_EFX_SECSICDESC2 := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.EFX_SECSICDESC2)),h.EFX_SECSICDESC2<>(typeof(h.EFX_SECSICDESC2))'');
    populated_EFX_SECSICDESC3_pcnt := AVE(GROUP,IF(h.EFX_SECSICDESC3 = (TYPEOF(h.EFX_SECSICDESC3))'',0,100));
    maxlength_EFX_SECSICDESC3 := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.EFX_SECSICDESC3)));
    avelength_EFX_SECSICDESC3 := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.EFX_SECSICDESC3)),h.EFX_SECSICDESC3<>(typeof(h.EFX_SECSICDESC3))'');
    populated_EFX_SECSICDESC4_pcnt := AVE(GROUP,IF(h.EFX_SECSICDESC4 = (TYPEOF(h.EFX_SECSICDESC4))'',0,100));
    maxlength_EFX_SECSICDESC4 := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.EFX_SECSICDESC4)));
    avelength_EFX_SECSICDESC4 := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.EFX_SECSICDESC4)),h.EFX_SECSICDESC4<>(typeof(h.EFX_SECSICDESC4))'');
    populated_EFX_PRIMNAICSCODE_pcnt := AVE(GROUP,IF(h.EFX_PRIMNAICSCODE = (TYPEOF(h.EFX_PRIMNAICSCODE))'',0,100));
    maxlength_EFX_PRIMNAICSCODE := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.EFX_PRIMNAICSCODE)));
    avelength_EFX_PRIMNAICSCODE := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.EFX_PRIMNAICSCODE)),h.EFX_PRIMNAICSCODE<>(typeof(h.EFX_PRIMNAICSCODE))'');
    populated_EFX_SECNAICS1_pcnt := AVE(GROUP,IF(h.EFX_SECNAICS1 = (TYPEOF(h.EFX_SECNAICS1))'',0,100));
    maxlength_EFX_SECNAICS1 := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.EFX_SECNAICS1)));
    avelength_EFX_SECNAICS1 := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.EFX_SECNAICS1)),h.EFX_SECNAICS1<>(typeof(h.EFX_SECNAICS1))'');
    populated_EFX_SECNAICS2_pcnt := AVE(GROUP,IF(h.EFX_SECNAICS2 = (TYPEOF(h.EFX_SECNAICS2))'',0,100));
    maxlength_EFX_SECNAICS2 := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.EFX_SECNAICS2)));
    avelength_EFX_SECNAICS2 := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.EFX_SECNAICS2)),h.EFX_SECNAICS2<>(typeof(h.EFX_SECNAICS2))'');
    populated_EFX_SECNAICS3_pcnt := AVE(GROUP,IF(h.EFX_SECNAICS3 = (TYPEOF(h.EFX_SECNAICS3))'',0,100));
    maxlength_EFX_SECNAICS3 := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.EFX_SECNAICS3)));
    avelength_EFX_SECNAICS3 := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.EFX_SECNAICS3)),h.EFX_SECNAICS3<>(typeof(h.EFX_SECNAICS3))'');
    populated_EFX_SECNAICS4_pcnt := AVE(GROUP,IF(h.EFX_SECNAICS4 = (TYPEOF(h.EFX_SECNAICS4))'',0,100));
    maxlength_EFX_SECNAICS4 := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.EFX_SECNAICS4)));
    avelength_EFX_SECNAICS4 := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.EFX_SECNAICS4)),h.EFX_SECNAICS4<>(typeof(h.EFX_SECNAICS4))'');
    populated_EFX_PRIMNAICSDESC_pcnt := AVE(GROUP,IF(h.EFX_PRIMNAICSDESC = (TYPEOF(h.EFX_PRIMNAICSDESC))'',0,100));
    maxlength_EFX_PRIMNAICSDESC := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.EFX_PRIMNAICSDESC)));
    avelength_EFX_PRIMNAICSDESC := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.EFX_PRIMNAICSDESC)),h.EFX_PRIMNAICSDESC<>(typeof(h.EFX_PRIMNAICSDESC))'');
    populated_EFX_SECNAICSDESC1_pcnt := AVE(GROUP,IF(h.EFX_SECNAICSDESC1 = (TYPEOF(h.EFX_SECNAICSDESC1))'',0,100));
    maxlength_EFX_SECNAICSDESC1 := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.EFX_SECNAICSDESC1)));
    avelength_EFX_SECNAICSDESC1 := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.EFX_SECNAICSDESC1)),h.EFX_SECNAICSDESC1<>(typeof(h.EFX_SECNAICSDESC1))'');
    populated_EFX_SECNAICSDESC2_pcnt := AVE(GROUP,IF(h.EFX_SECNAICSDESC2 = (TYPEOF(h.EFX_SECNAICSDESC2))'',0,100));
    maxlength_EFX_SECNAICSDESC2 := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.EFX_SECNAICSDESC2)));
    avelength_EFX_SECNAICSDESC2 := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.EFX_SECNAICSDESC2)),h.EFX_SECNAICSDESC2<>(typeof(h.EFX_SECNAICSDESC2))'');
    populated_EFX_SECNAICSDESC3_pcnt := AVE(GROUP,IF(h.EFX_SECNAICSDESC3 = (TYPEOF(h.EFX_SECNAICSDESC3))'',0,100));
    maxlength_EFX_SECNAICSDESC3 := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.EFX_SECNAICSDESC3)));
    avelength_EFX_SECNAICSDESC3 := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.EFX_SECNAICSDESC3)),h.EFX_SECNAICSDESC3<>(typeof(h.EFX_SECNAICSDESC3))'');
    populated_EFX_SECNAICSDESC4_pcnt := AVE(GROUP,IF(h.EFX_SECNAICSDESC4 = (TYPEOF(h.EFX_SECNAICSDESC4))'',0,100));
    maxlength_EFX_SECNAICSDESC4 := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.EFX_SECNAICSDESC4)));
    avelength_EFX_SECNAICSDESC4 := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.EFX_SECNAICSDESC4)),h.EFX_SECNAICSDESC4<>(typeof(h.EFX_SECNAICSDESC4))'');
    populated_EFX_DEAD_pcnt := AVE(GROUP,IF(h.EFX_DEAD = (TYPEOF(h.EFX_DEAD))'',0,100));
    maxlength_EFX_DEAD := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.EFX_DEAD)));
    avelength_EFX_DEAD := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.EFX_DEAD)),h.EFX_DEAD<>(typeof(h.EFX_DEAD))'');
    populated_EFX_DEADDT_pcnt := AVE(GROUP,IF(h.EFX_DEADDT = (TYPEOF(h.EFX_DEADDT))'',0,100));
    maxlength_EFX_DEADDT := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.EFX_DEADDT)));
    avelength_EFX_DEADDT := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.EFX_DEADDT)),h.EFX_DEADDT<>(typeof(h.EFX_DEADDT))'');
    populated_EFX_MRKT_TELEVER_pcnt := AVE(GROUP,IF(h.EFX_MRKT_TELEVER = (TYPEOF(h.EFX_MRKT_TELEVER))'',0,100));
    maxlength_EFX_MRKT_TELEVER := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.EFX_MRKT_TELEVER)));
    avelength_EFX_MRKT_TELEVER := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.EFX_MRKT_TELEVER)),h.EFX_MRKT_TELEVER<>(typeof(h.EFX_MRKT_TELEVER))'');
    populated_EFX_MRKT_TELESCORE_pcnt := AVE(GROUP,IF(h.EFX_MRKT_TELESCORE = (TYPEOF(h.EFX_MRKT_TELESCORE))'',0,100));
    maxlength_EFX_MRKT_TELESCORE := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.EFX_MRKT_TELESCORE)));
    avelength_EFX_MRKT_TELESCORE := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.EFX_MRKT_TELESCORE)),h.EFX_MRKT_TELESCORE<>(typeof(h.EFX_MRKT_TELESCORE))'');
    populated_EFX_MRKT_TOTALSCORE_pcnt := AVE(GROUP,IF(h.EFX_MRKT_TOTALSCORE = (TYPEOF(h.EFX_MRKT_TOTALSCORE))'',0,100));
    maxlength_EFX_MRKT_TOTALSCORE := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.EFX_MRKT_TOTALSCORE)));
    avelength_EFX_MRKT_TOTALSCORE := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.EFX_MRKT_TOTALSCORE)),h.EFX_MRKT_TOTALSCORE<>(typeof(h.EFX_MRKT_TOTALSCORE))'');
    populated_EFX_MRKT_TOTALIND_pcnt := AVE(GROUP,IF(h.EFX_MRKT_TOTALIND = (TYPEOF(h.EFX_MRKT_TOTALIND))'',0,100));
    maxlength_EFX_MRKT_TOTALIND := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.EFX_MRKT_TOTALIND)));
    avelength_EFX_MRKT_TOTALIND := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.EFX_MRKT_TOTALIND)),h.EFX_MRKT_TOTALIND<>(typeof(h.EFX_MRKT_TOTALIND))'');
    populated_EFX_MRKT_VACANT_pcnt := AVE(GROUP,IF(h.EFX_MRKT_VACANT = (TYPEOF(h.EFX_MRKT_VACANT))'',0,100));
    maxlength_EFX_MRKT_VACANT := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.EFX_MRKT_VACANT)));
    avelength_EFX_MRKT_VACANT := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.EFX_MRKT_VACANT)),h.EFX_MRKT_VACANT<>(typeof(h.EFX_MRKT_VACANT))'');
    populated_EFX_MRKT_SEASONAL_pcnt := AVE(GROUP,IF(h.EFX_MRKT_SEASONAL = (TYPEOF(h.EFX_MRKT_SEASONAL))'',0,100));
    maxlength_EFX_MRKT_SEASONAL := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.EFX_MRKT_SEASONAL)));
    avelength_EFX_MRKT_SEASONAL := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.EFX_MRKT_SEASONAL)),h.EFX_MRKT_SEASONAL<>(typeof(h.EFX_MRKT_SEASONAL))'');
    populated_EFX_MBE_pcnt := AVE(GROUP,IF(h.EFX_MBE = (TYPEOF(h.EFX_MBE))'',0,100));
    maxlength_EFX_MBE := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.EFX_MBE)));
    avelength_EFX_MBE := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.EFX_MBE)),h.EFX_MBE<>(typeof(h.EFX_MBE))'');
    populated_EFX_WBE_pcnt := AVE(GROUP,IF(h.EFX_WBE = (TYPEOF(h.EFX_WBE))'',0,100));
    maxlength_EFX_WBE := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.EFX_WBE)));
    avelength_EFX_WBE := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.EFX_WBE)),h.EFX_WBE<>(typeof(h.EFX_WBE))'');
    populated_EFX_MWBE_pcnt := AVE(GROUP,IF(h.EFX_MWBE = (TYPEOF(h.EFX_MWBE))'',0,100));
    maxlength_EFX_MWBE := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.EFX_MWBE)));
    avelength_EFX_MWBE := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.EFX_MWBE)),h.EFX_MWBE<>(typeof(h.EFX_MWBE))'');
    populated_EFX_SDB_pcnt := AVE(GROUP,IF(h.EFX_SDB = (TYPEOF(h.EFX_SDB))'',0,100));
    maxlength_EFX_SDB := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.EFX_SDB)));
    avelength_EFX_SDB := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.EFX_SDB)),h.EFX_SDB<>(typeof(h.EFX_SDB))'');
    populated_EFX_HUBZONE_pcnt := AVE(GROUP,IF(h.EFX_HUBZONE = (TYPEOF(h.EFX_HUBZONE))'',0,100));
    maxlength_EFX_HUBZONE := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.EFX_HUBZONE)));
    avelength_EFX_HUBZONE := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.EFX_HUBZONE)),h.EFX_HUBZONE<>(typeof(h.EFX_HUBZONE))'');
    populated_EFX_DBE_pcnt := AVE(GROUP,IF(h.EFX_DBE = (TYPEOF(h.EFX_DBE))'',0,100));
    maxlength_EFX_DBE := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.EFX_DBE)));
    avelength_EFX_DBE := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.EFX_DBE)),h.EFX_DBE<>(typeof(h.EFX_DBE))'');
    populated_EFX_VET_pcnt := AVE(GROUP,IF(h.EFX_VET = (TYPEOF(h.EFX_VET))'',0,100));
    maxlength_EFX_VET := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.EFX_VET)));
    avelength_EFX_VET := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.EFX_VET)),h.EFX_VET<>(typeof(h.EFX_VET))'');
    populated_EFX_DVET_pcnt := AVE(GROUP,IF(h.EFX_DVET = (TYPEOF(h.EFX_DVET))'',0,100));
    maxlength_EFX_DVET := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.EFX_DVET)));
    avelength_EFX_DVET := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.EFX_DVET)),h.EFX_DVET<>(typeof(h.EFX_DVET))'');
    populated_EFX_8a_pcnt := AVE(GROUP,IF(h.EFX_8a = (TYPEOF(h.EFX_8a))'',0,100));
    maxlength_EFX_8a := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.EFX_8a)));
    avelength_EFX_8a := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.EFX_8a)),h.EFX_8a<>(typeof(h.EFX_8a))'');
    populated_EFX_8aEXPDT_pcnt := AVE(GROUP,IF(h.EFX_8aEXPDT = (TYPEOF(h.EFX_8aEXPDT))'',0,100));
    maxlength_EFX_8aEXPDT := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.EFX_8aEXPDT)));
    avelength_EFX_8aEXPDT := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.EFX_8aEXPDT)),h.EFX_8aEXPDT<>(typeof(h.EFX_8aEXPDT))'');
    populated_EFX_DIS_pcnt := AVE(GROUP,IF(h.EFX_DIS = (TYPEOF(h.EFX_DIS))'',0,100));
    maxlength_EFX_DIS := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.EFX_DIS)));
    avelength_EFX_DIS := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.EFX_DIS)),h.EFX_DIS<>(typeof(h.EFX_DIS))'');
    populated_EFX_SBE_pcnt := AVE(GROUP,IF(h.EFX_SBE = (TYPEOF(h.EFX_SBE))'',0,100));
    maxlength_EFX_SBE := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.EFX_SBE)));
    avelength_EFX_SBE := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.EFX_SBE)),h.EFX_SBE<>(typeof(h.EFX_SBE))'');
    populated_EFX_BUSSIZE_pcnt := AVE(GROUP,IF(h.EFX_BUSSIZE = (TYPEOF(h.EFX_BUSSIZE))'',0,100));
    maxlength_EFX_BUSSIZE := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.EFX_BUSSIZE)));
    avelength_EFX_BUSSIZE := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.EFX_BUSSIZE)),h.EFX_BUSSIZE<>(typeof(h.EFX_BUSSIZE))'');
    populated_EFX_LBE_pcnt := AVE(GROUP,IF(h.EFX_LBE = (TYPEOF(h.EFX_LBE))'',0,100));
    maxlength_EFX_LBE := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.EFX_LBE)));
    avelength_EFX_LBE := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.EFX_LBE)),h.EFX_LBE<>(typeof(h.EFX_LBE))'');
    populated_EFX_GOV_pcnt := AVE(GROUP,IF(h.EFX_GOV = (TYPEOF(h.EFX_GOV))'',0,100));
    maxlength_EFX_GOV := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.EFX_GOV)));
    avelength_EFX_GOV := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.EFX_GOV)),h.EFX_GOV<>(typeof(h.EFX_GOV))'');
    populated_EFX_FGOV_pcnt := AVE(GROUP,IF(h.EFX_FGOV = (TYPEOF(h.EFX_FGOV))'',0,100));
    maxlength_EFX_FGOV := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.EFX_FGOV)));
    avelength_EFX_FGOV := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.EFX_FGOV)),h.EFX_FGOV<>(typeof(h.EFX_FGOV))'');
    populated_EFX_GOV1057_pcnt := AVE(GROUP,IF(h.EFX_GOV1057 = (TYPEOF(h.EFX_GOV1057))'',0,100));
    maxlength_EFX_GOV1057 := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.EFX_GOV1057)));
    avelength_EFX_GOV1057 := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.EFX_GOV1057)),h.EFX_GOV1057<>(typeof(h.EFX_GOV1057))'');
    populated_EFX_NONPROFIT_pcnt := AVE(GROUP,IF(h.EFX_NONPROFIT = (TYPEOF(h.EFX_NONPROFIT))'',0,100));
    maxlength_EFX_NONPROFIT := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.EFX_NONPROFIT)));
    avelength_EFX_NONPROFIT := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.EFX_NONPROFIT)),h.EFX_NONPROFIT<>(typeof(h.EFX_NONPROFIT))'');
    populated_EFX_MERCTYPE_pcnt := AVE(GROUP,IF(h.EFX_MERCTYPE = (TYPEOF(h.EFX_MERCTYPE))'',0,100));
    maxlength_EFX_MERCTYPE := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.EFX_MERCTYPE)));
    avelength_EFX_MERCTYPE := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.EFX_MERCTYPE)),h.EFX_MERCTYPE<>(typeof(h.EFX_MERCTYPE))'');
    populated_EFX_HBCU_pcnt := AVE(GROUP,IF(h.EFX_HBCU = (TYPEOF(h.EFX_HBCU))'',0,100));
    maxlength_EFX_HBCU := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.EFX_HBCU)));
    avelength_EFX_HBCU := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.EFX_HBCU)),h.EFX_HBCU<>(typeof(h.EFX_HBCU))'');
    populated_EFX_GAYLESBIAN_pcnt := AVE(GROUP,IF(h.EFX_GAYLESBIAN = (TYPEOF(h.EFX_GAYLESBIAN))'',0,100));
    maxlength_EFX_GAYLESBIAN := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.EFX_GAYLESBIAN)));
    avelength_EFX_GAYLESBIAN := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.EFX_GAYLESBIAN)),h.EFX_GAYLESBIAN<>(typeof(h.EFX_GAYLESBIAN))'');
    populated_EFX_WSBE_pcnt := AVE(GROUP,IF(h.EFX_WSBE = (TYPEOF(h.EFX_WSBE))'',0,100));
    maxlength_EFX_WSBE := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.EFX_WSBE)));
    avelength_EFX_WSBE := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.EFX_WSBE)),h.EFX_WSBE<>(typeof(h.EFX_WSBE))'');
    populated_EFX_VSBE_pcnt := AVE(GROUP,IF(h.EFX_VSBE = (TYPEOF(h.EFX_VSBE))'',0,100));
    maxlength_EFX_VSBE := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.EFX_VSBE)));
    avelength_EFX_VSBE := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.EFX_VSBE)),h.EFX_VSBE<>(typeof(h.EFX_VSBE))'');
    populated_EFX_DVSBE_pcnt := AVE(GROUP,IF(h.EFX_DVSBE = (TYPEOF(h.EFX_DVSBE))'',0,100));
    maxlength_EFX_DVSBE := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.EFX_DVSBE)));
    avelength_EFX_DVSBE := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.EFX_DVSBE)),h.EFX_DVSBE<>(typeof(h.EFX_DVSBE))'');
    populated_EFX_MWBESTATUS_pcnt := AVE(GROUP,IF(h.EFX_MWBESTATUS = (TYPEOF(h.EFX_MWBESTATUS))'',0,100));
    maxlength_EFX_MWBESTATUS := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.EFX_MWBESTATUS)));
    avelength_EFX_MWBESTATUS := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.EFX_MWBESTATUS)),h.EFX_MWBESTATUS<>(typeof(h.EFX_MWBESTATUS))'');
    populated_EFX_NMSDC_pcnt := AVE(GROUP,IF(h.EFX_NMSDC = (TYPEOF(h.EFX_NMSDC))'',0,100));
    maxlength_EFX_NMSDC := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.EFX_NMSDC)));
    avelength_EFX_NMSDC := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.EFX_NMSDC)),h.EFX_NMSDC<>(typeof(h.EFX_NMSDC))'');
    populated_EFX_WBENC_pcnt := AVE(GROUP,IF(h.EFX_WBENC = (TYPEOF(h.EFX_WBENC))'',0,100));
    maxlength_EFX_WBENC := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.EFX_WBENC)));
    avelength_EFX_WBENC := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.EFX_WBENC)),h.EFX_WBENC<>(typeof(h.EFX_WBENC))'');
    populated_EFX_CA_PUC_pcnt := AVE(GROUP,IF(h.EFX_CA_PUC = (TYPEOF(h.EFX_CA_PUC))'',0,100));
    maxlength_EFX_CA_PUC := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.EFX_CA_PUC)));
    avelength_EFX_CA_PUC := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.EFX_CA_PUC)),h.EFX_CA_PUC<>(typeof(h.EFX_CA_PUC))'');
    populated_EFX_TX_HUB_pcnt := AVE(GROUP,IF(h.EFX_TX_HUB = (TYPEOF(h.EFX_TX_HUB))'',0,100));
    maxlength_EFX_TX_HUB := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.EFX_TX_HUB)));
    avelength_EFX_TX_HUB := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.EFX_TX_HUB)),h.EFX_TX_HUB<>(typeof(h.EFX_TX_HUB))'');
    populated_EFX_TX_HUBCERTNUM_pcnt := AVE(GROUP,IF(h.EFX_TX_HUBCERTNUM = (TYPEOF(h.EFX_TX_HUBCERTNUM))'',0,100));
    maxlength_EFX_TX_HUBCERTNUM := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.EFX_TX_HUBCERTNUM)));
    avelength_EFX_TX_HUBCERTNUM := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.EFX_TX_HUBCERTNUM)),h.EFX_TX_HUBCERTNUM<>(typeof(h.EFX_TX_HUBCERTNUM))'');
    populated_EFX_GSAX_pcnt := AVE(GROUP,IF(h.EFX_GSAX = (TYPEOF(h.EFX_GSAX))'',0,100));
    maxlength_EFX_GSAX := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.EFX_GSAX)));
    avelength_EFX_GSAX := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.EFX_GSAX)),h.EFX_GSAX<>(typeof(h.EFX_GSAX))'');
    populated_EFX_CALTRANS_pcnt := AVE(GROUP,IF(h.EFX_CALTRANS = (TYPEOF(h.EFX_CALTRANS))'',0,100));
    maxlength_EFX_CALTRANS := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.EFX_CALTRANS)));
    avelength_EFX_CALTRANS := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.EFX_CALTRANS)),h.EFX_CALTRANS<>(typeof(h.EFX_CALTRANS))'');
    populated_EFX_EDU_pcnt := AVE(GROUP,IF(h.EFX_EDU = (TYPEOF(h.EFX_EDU))'',0,100));
    maxlength_EFX_EDU := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.EFX_EDU)));
    avelength_EFX_EDU := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.EFX_EDU)),h.EFX_EDU<>(typeof(h.EFX_EDU))'');
    populated_EFX_MI_pcnt := AVE(GROUP,IF(h.EFX_MI = (TYPEOF(h.EFX_MI))'',0,100));
    maxlength_EFX_MI := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.EFX_MI)));
    avelength_EFX_MI := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.EFX_MI)),h.EFX_MI<>(typeof(h.EFX_MI))'');
    populated_EFX_ANC_pcnt := AVE(GROUP,IF(h.EFX_ANC = (TYPEOF(h.EFX_ANC))'',0,100));
    maxlength_EFX_ANC := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.EFX_ANC)));
    avelength_EFX_ANC := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.EFX_ANC)),h.EFX_ANC<>(typeof(h.EFX_ANC))'');
    populated_AT_CERT1_pcnt := AVE(GROUP,IF(h.AT_CERT1 = (TYPEOF(h.AT_CERT1))'',0,100));
    maxlength_AT_CERT1 := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.AT_CERT1)));
    avelength_AT_CERT1 := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.AT_CERT1)),h.AT_CERT1<>(typeof(h.AT_CERT1))'');
    populated_AT_CERT2_pcnt := AVE(GROUP,IF(h.AT_CERT2 = (TYPEOF(h.AT_CERT2))'',0,100));
    maxlength_AT_CERT2 := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.AT_CERT2)));
    avelength_AT_CERT2 := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.AT_CERT2)),h.AT_CERT2<>(typeof(h.AT_CERT2))'');
    populated_AT_CERT3_pcnt := AVE(GROUP,IF(h.AT_CERT3 = (TYPEOF(h.AT_CERT3))'',0,100));
    maxlength_AT_CERT3 := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.AT_CERT3)));
    avelength_AT_CERT3 := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.AT_CERT3)),h.AT_CERT3<>(typeof(h.AT_CERT3))'');
    populated_AT_CERT4_pcnt := AVE(GROUP,IF(h.AT_CERT4 = (TYPEOF(h.AT_CERT4))'',0,100));
    maxlength_AT_CERT4 := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.AT_CERT4)));
    avelength_AT_CERT4 := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.AT_CERT4)),h.AT_CERT4<>(typeof(h.AT_CERT4))'');
    populated_AT_CERT5_pcnt := AVE(GROUP,IF(h.AT_CERT5 = (TYPEOF(h.AT_CERT5))'',0,100));
    maxlength_AT_CERT5 := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.AT_CERT5)));
    avelength_AT_CERT5 := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.AT_CERT5)),h.AT_CERT5<>(typeof(h.AT_CERT5))'');
    populated_AT_CERT6_pcnt := AVE(GROUP,IF(h.AT_CERT6 = (TYPEOF(h.AT_CERT6))'',0,100));
    maxlength_AT_CERT6 := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.AT_CERT6)));
    avelength_AT_CERT6 := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.AT_CERT6)),h.AT_CERT6<>(typeof(h.AT_CERT6))'');
    populated_AT_CERT7_pcnt := AVE(GROUP,IF(h.AT_CERT7 = (TYPEOF(h.AT_CERT7))'',0,100));
    maxlength_AT_CERT7 := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.AT_CERT7)));
    avelength_AT_CERT7 := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.AT_CERT7)),h.AT_CERT7<>(typeof(h.AT_CERT7))'');
    populated_AT_CERT8_pcnt := AVE(GROUP,IF(h.AT_CERT8 = (TYPEOF(h.AT_CERT8))'',0,100));
    maxlength_AT_CERT8 := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.AT_CERT8)));
    avelength_AT_CERT8 := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.AT_CERT8)),h.AT_CERT8<>(typeof(h.AT_CERT8))'');
    populated_AT_CERT9_pcnt := AVE(GROUP,IF(h.AT_CERT9 = (TYPEOF(h.AT_CERT9))'',0,100));
    maxlength_AT_CERT9 := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.AT_CERT9)));
    avelength_AT_CERT9 := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.AT_CERT9)),h.AT_CERT9<>(typeof(h.AT_CERT9))'');
    populated_AT_CERT10_pcnt := AVE(GROUP,IF(h.AT_CERT10 = (TYPEOF(h.AT_CERT10))'',0,100));
    maxlength_AT_CERT10 := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.AT_CERT10)));
    avelength_AT_CERT10 := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.AT_CERT10)),h.AT_CERT10<>(typeof(h.AT_CERT10))'');
    populated_AT_CERTDESC1_pcnt := AVE(GROUP,IF(h.AT_CERTDESC1 = (TYPEOF(h.AT_CERTDESC1))'',0,100));
    maxlength_AT_CERTDESC1 := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.AT_CERTDESC1)));
    avelength_AT_CERTDESC1 := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.AT_CERTDESC1)),h.AT_CERTDESC1<>(typeof(h.AT_CERTDESC1))'');
    populated_AT_CERTDESC2_pcnt := AVE(GROUP,IF(h.AT_CERTDESC2 = (TYPEOF(h.AT_CERTDESC2))'',0,100));
    maxlength_AT_CERTDESC2 := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.AT_CERTDESC2)));
    avelength_AT_CERTDESC2 := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.AT_CERTDESC2)),h.AT_CERTDESC2<>(typeof(h.AT_CERTDESC2))'');
    populated_AT_CERTDESC3_pcnt := AVE(GROUP,IF(h.AT_CERTDESC3 = (TYPEOF(h.AT_CERTDESC3))'',0,100));
    maxlength_AT_CERTDESC3 := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.AT_CERTDESC3)));
    avelength_AT_CERTDESC3 := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.AT_CERTDESC3)),h.AT_CERTDESC3<>(typeof(h.AT_CERTDESC3))'');
    populated_AT_CERTDESC4_pcnt := AVE(GROUP,IF(h.AT_CERTDESC4 = (TYPEOF(h.AT_CERTDESC4))'',0,100));
    maxlength_AT_CERTDESC4 := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.AT_CERTDESC4)));
    avelength_AT_CERTDESC4 := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.AT_CERTDESC4)),h.AT_CERTDESC4<>(typeof(h.AT_CERTDESC4))'');
    populated_AT_CERTDESC5_pcnt := AVE(GROUP,IF(h.AT_CERTDESC5 = (TYPEOF(h.AT_CERTDESC5))'',0,100));
    maxlength_AT_CERTDESC5 := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.AT_CERTDESC5)));
    avelength_AT_CERTDESC5 := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.AT_CERTDESC5)),h.AT_CERTDESC5<>(typeof(h.AT_CERTDESC5))'');
    populated_AT_CERTDESC6_pcnt := AVE(GROUP,IF(h.AT_CERTDESC6 = (TYPEOF(h.AT_CERTDESC6))'',0,100));
    maxlength_AT_CERTDESC6 := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.AT_CERTDESC6)));
    avelength_AT_CERTDESC6 := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.AT_CERTDESC6)),h.AT_CERTDESC6<>(typeof(h.AT_CERTDESC6))'');
    populated_AT_CERTDESC7_pcnt := AVE(GROUP,IF(h.AT_CERTDESC7 = (TYPEOF(h.AT_CERTDESC7))'',0,100));
    maxlength_AT_CERTDESC7 := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.AT_CERTDESC7)));
    avelength_AT_CERTDESC7 := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.AT_CERTDESC7)),h.AT_CERTDESC7<>(typeof(h.AT_CERTDESC7))'');
    populated_AT_CERTDESC8_pcnt := AVE(GROUP,IF(h.AT_CERTDESC8 = (TYPEOF(h.AT_CERTDESC8))'',0,100));
    maxlength_AT_CERTDESC8 := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.AT_CERTDESC8)));
    avelength_AT_CERTDESC8 := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.AT_CERTDESC8)),h.AT_CERTDESC8<>(typeof(h.AT_CERTDESC8))'');
    populated_AT_CERTDESC9_pcnt := AVE(GROUP,IF(h.AT_CERTDESC9 = (TYPEOF(h.AT_CERTDESC9))'',0,100));
    maxlength_AT_CERTDESC9 := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.AT_CERTDESC9)));
    avelength_AT_CERTDESC9 := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.AT_CERTDESC9)),h.AT_CERTDESC9<>(typeof(h.AT_CERTDESC9))'');
    populated_AT_CERTDESC10_pcnt := AVE(GROUP,IF(h.AT_CERTDESC10 = (TYPEOF(h.AT_CERTDESC10))'',0,100));
    maxlength_AT_CERTDESC10 := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.AT_CERTDESC10)));
    avelength_AT_CERTDESC10 := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.AT_CERTDESC10)),h.AT_CERTDESC10<>(typeof(h.AT_CERTDESC10))'');
    populated_AT_CERTSRC1_pcnt := AVE(GROUP,IF(h.AT_CERTSRC1 = (TYPEOF(h.AT_CERTSRC1))'',0,100));
    maxlength_AT_CERTSRC1 := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.AT_CERTSRC1)));
    avelength_AT_CERTSRC1 := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.AT_CERTSRC1)),h.AT_CERTSRC1<>(typeof(h.AT_CERTSRC1))'');
    populated_AT_CERTSRC2_pcnt := AVE(GROUP,IF(h.AT_CERTSRC2 = (TYPEOF(h.AT_CERTSRC2))'',0,100));
    maxlength_AT_CERTSRC2 := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.AT_CERTSRC2)));
    avelength_AT_CERTSRC2 := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.AT_CERTSRC2)),h.AT_CERTSRC2<>(typeof(h.AT_CERTSRC2))'');
    populated_AT_CERTSRC3_pcnt := AVE(GROUP,IF(h.AT_CERTSRC3 = (TYPEOF(h.AT_CERTSRC3))'',0,100));
    maxlength_AT_CERTSRC3 := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.AT_CERTSRC3)));
    avelength_AT_CERTSRC3 := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.AT_CERTSRC3)),h.AT_CERTSRC3<>(typeof(h.AT_CERTSRC3))'');
    populated_AT_CERTSRC4_pcnt := AVE(GROUP,IF(h.AT_CERTSRC4 = (TYPEOF(h.AT_CERTSRC4))'',0,100));
    maxlength_AT_CERTSRC4 := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.AT_CERTSRC4)));
    avelength_AT_CERTSRC4 := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.AT_CERTSRC4)),h.AT_CERTSRC4<>(typeof(h.AT_CERTSRC4))'');
    populated_AT_CERTSRC5_pcnt := AVE(GROUP,IF(h.AT_CERTSRC5 = (TYPEOF(h.AT_CERTSRC5))'',0,100));
    maxlength_AT_CERTSRC5 := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.AT_CERTSRC5)));
    avelength_AT_CERTSRC5 := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.AT_CERTSRC5)),h.AT_CERTSRC5<>(typeof(h.AT_CERTSRC5))'');
    populated_AT_CERTSRC6_pcnt := AVE(GROUP,IF(h.AT_CERTSRC6 = (TYPEOF(h.AT_CERTSRC6))'',0,100));
    maxlength_AT_CERTSRC6 := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.AT_CERTSRC6)));
    avelength_AT_CERTSRC6 := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.AT_CERTSRC6)),h.AT_CERTSRC6<>(typeof(h.AT_CERTSRC6))'');
    populated_AT_CERTSRC7_pcnt := AVE(GROUP,IF(h.AT_CERTSRC7 = (TYPEOF(h.AT_CERTSRC7))'',0,100));
    maxlength_AT_CERTSRC7 := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.AT_CERTSRC7)));
    avelength_AT_CERTSRC7 := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.AT_CERTSRC7)),h.AT_CERTSRC7<>(typeof(h.AT_CERTSRC7))'');
    populated_AT_CERTSRC8_pcnt := AVE(GROUP,IF(h.AT_CERTSRC8 = (TYPEOF(h.AT_CERTSRC8))'',0,100));
    maxlength_AT_CERTSRC8 := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.AT_CERTSRC8)));
    avelength_AT_CERTSRC8 := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.AT_CERTSRC8)),h.AT_CERTSRC8<>(typeof(h.AT_CERTSRC8))'');
    populated_AT_CERTSRC9_pcnt := AVE(GROUP,IF(h.AT_CERTSRC9 = (TYPEOF(h.AT_CERTSRC9))'',0,100));
    maxlength_AT_CERTSRC9 := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.AT_CERTSRC9)));
    avelength_AT_CERTSRC9 := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.AT_CERTSRC9)),h.AT_CERTSRC9<>(typeof(h.AT_CERTSRC9))'');
    populated_AT_CERTSRC10_pcnt := AVE(GROUP,IF(h.AT_CERTSRC10 = (TYPEOF(h.AT_CERTSRC10))'',0,100));
    maxlength_AT_CERTSRC10 := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.AT_CERTSRC10)));
    avelength_AT_CERTSRC10 := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.AT_CERTSRC10)),h.AT_CERTSRC10<>(typeof(h.AT_CERTSRC10))'');
    populated_AT_CERTLEV1_pcnt := AVE(GROUP,IF(h.AT_CERTLEV1 = (TYPEOF(h.AT_CERTLEV1))'',0,100));
    maxlength_AT_CERTLEV1 := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.AT_CERTLEV1)));
    avelength_AT_CERTLEV1 := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.AT_CERTLEV1)),h.AT_CERTLEV1<>(typeof(h.AT_CERTLEV1))'');
    populated_AT_CERTLEV2_pcnt := AVE(GROUP,IF(h.AT_CERTLEV2 = (TYPEOF(h.AT_CERTLEV2))'',0,100));
    maxlength_AT_CERTLEV2 := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.AT_CERTLEV2)));
    avelength_AT_CERTLEV2 := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.AT_CERTLEV2)),h.AT_CERTLEV2<>(typeof(h.AT_CERTLEV2))'');
    populated_AT_CERTLEV3_pcnt := AVE(GROUP,IF(h.AT_CERTLEV3 = (TYPEOF(h.AT_CERTLEV3))'',0,100));
    maxlength_AT_CERTLEV3 := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.AT_CERTLEV3)));
    avelength_AT_CERTLEV3 := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.AT_CERTLEV3)),h.AT_CERTLEV3<>(typeof(h.AT_CERTLEV3))'');
    populated_AT_CERTLEV4_pcnt := AVE(GROUP,IF(h.AT_CERTLEV4 = (TYPEOF(h.AT_CERTLEV4))'',0,100));
    maxlength_AT_CERTLEV4 := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.AT_CERTLEV4)));
    avelength_AT_CERTLEV4 := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.AT_CERTLEV4)),h.AT_CERTLEV4<>(typeof(h.AT_CERTLEV4))'');
    populated_AT_CERTLEV5_pcnt := AVE(GROUP,IF(h.AT_CERTLEV5 = (TYPEOF(h.AT_CERTLEV5))'',0,100));
    maxlength_AT_CERTLEV5 := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.AT_CERTLEV5)));
    avelength_AT_CERTLEV5 := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.AT_CERTLEV5)),h.AT_CERTLEV5<>(typeof(h.AT_CERTLEV5))'');
    populated_AT_CERTLEV6_pcnt := AVE(GROUP,IF(h.AT_CERTLEV6 = (TYPEOF(h.AT_CERTLEV6))'',0,100));
    maxlength_AT_CERTLEV6 := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.AT_CERTLEV6)));
    avelength_AT_CERTLEV6 := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.AT_CERTLEV6)),h.AT_CERTLEV6<>(typeof(h.AT_CERTLEV6))'');
    populated_AT_CERTLEV7_pcnt := AVE(GROUP,IF(h.AT_CERTLEV7 = (TYPEOF(h.AT_CERTLEV7))'',0,100));
    maxlength_AT_CERTLEV7 := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.AT_CERTLEV7)));
    avelength_AT_CERTLEV7 := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.AT_CERTLEV7)),h.AT_CERTLEV7<>(typeof(h.AT_CERTLEV7))'');
    populated_AT_CERTLEV8_pcnt := AVE(GROUP,IF(h.AT_CERTLEV8 = (TYPEOF(h.AT_CERTLEV8))'',0,100));
    maxlength_AT_CERTLEV8 := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.AT_CERTLEV8)));
    avelength_AT_CERTLEV8 := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.AT_CERTLEV8)),h.AT_CERTLEV8<>(typeof(h.AT_CERTLEV8))'');
    populated_AT_CERTLEV9_pcnt := AVE(GROUP,IF(h.AT_CERTLEV9 = (TYPEOF(h.AT_CERTLEV9))'',0,100));
    maxlength_AT_CERTLEV9 := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.AT_CERTLEV9)));
    avelength_AT_CERTLEV9 := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.AT_CERTLEV9)),h.AT_CERTLEV9<>(typeof(h.AT_CERTLEV9))'');
    populated_AT_CERTLEV10_pcnt := AVE(GROUP,IF(h.AT_CERTLEV10 = (TYPEOF(h.AT_CERTLEV10))'',0,100));
    maxlength_AT_CERTLEV10 := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.AT_CERTLEV10)));
    avelength_AT_CERTLEV10 := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.AT_CERTLEV10)),h.AT_CERTLEV10<>(typeof(h.AT_CERTLEV10))'');
    populated_AT_CERTNUM1_pcnt := AVE(GROUP,IF(h.AT_CERTNUM1 = (TYPEOF(h.AT_CERTNUM1))'',0,100));
    maxlength_AT_CERTNUM1 := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.AT_CERTNUM1)));
    avelength_AT_CERTNUM1 := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.AT_CERTNUM1)),h.AT_CERTNUM1<>(typeof(h.AT_CERTNUM1))'');
    populated_AT_CERTNUM2_pcnt := AVE(GROUP,IF(h.AT_CERTNUM2 = (TYPEOF(h.AT_CERTNUM2))'',0,100));
    maxlength_AT_CERTNUM2 := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.AT_CERTNUM2)));
    avelength_AT_CERTNUM2 := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.AT_CERTNUM2)),h.AT_CERTNUM2<>(typeof(h.AT_CERTNUM2))'');
    populated_AT_CERTNUM3_pcnt := AVE(GROUP,IF(h.AT_CERTNUM3 = (TYPEOF(h.AT_CERTNUM3))'',0,100));
    maxlength_AT_CERTNUM3 := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.AT_CERTNUM3)));
    avelength_AT_CERTNUM3 := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.AT_CERTNUM3)),h.AT_CERTNUM3<>(typeof(h.AT_CERTNUM3))'');
    populated_AT_CERTNUM4_pcnt := AVE(GROUP,IF(h.AT_CERTNUM4 = (TYPEOF(h.AT_CERTNUM4))'',0,100));
    maxlength_AT_CERTNUM4 := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.AT_CERTNUM4)));
    avelength_AT_CERTNUM4 := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.AT_CERTNUM4)),h.AT_CERTNUM4<>(typeof(h.AT_CERTNUM4))'');
    populated_AT_CERTNUM5_pcnt := AVE(GROUP,IF(h.AT_CERTNUM5 = (TYPEOF(h.AT_CERTNUM5))'',0,100));
    maxlength_AT_CERTNUM5 := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.AT_CERTNUM5)));
    avelength_AT_CERTNUM5 := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.AT_CERTNUM5)),h.AT_CERTNUM5<>(typeof(h.AT_CERTNUM5))'');
    populated_AT_CERTNUM6_pcnt := AVE(GROUP,IF(h.AT_CERTNUM6 = (TYPEOF(h.AT_CERTNUM6))'',0,100));
    maxlength_AT_CERTNUM6 := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.AT_CERTNUM6)));
    avelength_AT_CERTNUM6 := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.AT_CERTNUM6)),h.AT_CERTNUM6<>(typeof(h.AT_CERTNUM6))'');
    populated_AT_CERTNUM7_pcnt := AVE(GROUP,IF(h.AT_CERTNUM7 = (TYPEOF(h.AT_CERTNUM7))'',0,100));
    maxlength_AT_CERTNUM7 := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.AT_CERTNUM7)));
    avelength_AT_CERTNUM7 := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.AT_CERTNUM7)),h.AT_CERTNUM7<>(typeof(h.AT_CERTNUM7))'');
    populated_AT_CERTNUM8_pcnt := AVE(GROUP,IF(h.AT_CERTNUM8 = (TYPEOF(h.AT_CERTNUM8))'',0,100));
    maxlength_AT_CERTNUM8 := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.AT_CERTNUM8)));
    avelength_AT_CERTNUM8 := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.AT_CERTNUM8)),h.AT_CERTNUM8<>(typeof(h.AT_CERTNUM8))'');
    populated_AT_CERTNUM9_pcnt := AVE(GROUP,IF(h.AT_CERTNUM9 = (TYPEOF(h.AT_CERTNUM9))'',0,100));
    maxlength_AT_CERTNUM9 := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.AT_CERTNUM9)));
    avelength_AT_CERTNUM9 := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.AT_CERTNUM9)),h.AT_CERTNUM9<>(typeof(h.AT_CERTNUM9))'');
    populated_AT_CERTNUM10_pcnt := AVE(GROUP,IF(h.AT_CERTNUM10 = (TYPEOF(h.AT_CERTNUM10))'',0,100));
    maxlength_AT_CERTNUM10 := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.AT_CERTNUM10)));
    avelength_AT_CERTNUM10 := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.AT_CERTNUM10)),h.AT_CERTNUM10<>(typeof(h.AT_CERTNUM10))'');
    populated_AT_CERTEXP1_pcnt := AVE(GROUP,IF(h.AT_CERTEXP1 = (TYPEOF(h.AT_CERTEXP1))'',0,100));
    maxlength_AT_CERTEXP1 := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.AT_CERTEXP1)));
    avelength_AT_CERTEXP1 := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.AT_CERTEXP1)),h.AT_CERTEXP1<>(typeof(h.AT_CERTEXP1))'');
    populated_AT_CERTEXP2_pcnt := AVE(GROUP,IF(h.AT_CERTEXP2 = (TYPEOF(h.AT_CERTEXP2))'',0,100));
    maxlength_AT_CERTEXP2 := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.AT_CERTEXP2)));
    avelength_AT_CERTEXP2 := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.AT_CERTEXP2)),h.AT_CERTEXP2<>(typeof(h.AT_CERTEXP2))'');
    populated_AT_CERTEXP3_pcnt := AVE(GROUP,IF(h.AT_CERTEXP3 = (TYPEOF(h.AT_CERTEXP3))'',0,100));
    maxlength_AT_CERTEXP3 := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.AT_CERTEXP3)));
    avelength_AT_CERTEXP3 := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.AT_CERTEXP3)),h.AT_CERTEXP3<>(typeof(h.AT_CERTEXP3))'');
    populated_AT_CERTEXP4_pcnt := AVE(GROUP,IF(h.AT_CERTEXP4 = (TYPEOF(h.AT_CERTEXP4))'',0,100));
    maxlength_AT_CERTEXP4 := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.AT_CERTEXP4)));
    avelength_AT_CERTEXP4 := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.AT_CERTEXP4)),h.AT_CERTEXP4<>(typeof(h.AT_CERTEXP4))'');
    populated_AT_CERTEXP5_pcnt := AVE(GROUP,IF(h.AT_CERTEXP5 = (TYPEOF(h.AT_CERTEXP5))'',0,100));
    maxlength_AT_CERTEXP5 := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.AT_CERTEXP5)));
    avelength_AT_CERTEXP5 := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.AT_CERTEXP5)),h.AT_CERTEXP5<>(typeof(h.AT_CERTEXP5))'');
    populated_AT_CERTEXP6_pcnt := AVE(GROUP,IF(h.AT_CERTEXP6 = (TYPEOF(h.AT_CERTEXP6))'',0,100));
    maxlength_AT_CERTEXP6 := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.AT_CERTEXP6)));
    avelength_AT_CERTEXP6 := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.AT_CERTEXP6)),h.AT_CERTEXP6<>(typeof(h.AT_CERTEXP6))'');
    populated_AT_CERTEXP7_pcnt := AVE(GROUP,IF(h.AT_CERTEXP7 = (TYPEOF(h.AT_CERTEXP7))'',0,100));
    maxlength_AT_CERTEXP7 := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.AT_CERTEXP7)));
    avelength_AT_CERTEXP7 := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.AT_CERTEXP7)),h.AT_CERTEXP7<>(typeof(h.AT_CERTEXP7))'');
    populated_AT_CERTEXP8_pcnt := AVE(GROUP,IF(h.AT_CERTEXP8 = (TYPEOF(h.AT_CERTEXP8))'',0,100));
    maxlength_AT_CERTEXP8 := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.AT_CERTEXP8)));
    avelength_AT_CERTEXP8 := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.AT_CERTEXP8)),h.AT_CERTEXP8<>(typeof(h.AT_CERTEXP8))'');
    populated_AT_CERTEXP9_pcnt := AVE(GROUP,IF(h.AT_CERTEXP9 = (TYPEOF(h.AT_CERTEXP9))'',0,100));
    maxlength_AT_CERTEXP9 := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.AT_CERTEXP9)));
    avelength_AT_CERTEXP9 := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.AT_CERTEXP9)),h.AT_CERTEXP9<>(typeof(h.AT_CERTEXP9))'');
    populated_AT_CERTEXP10_pcnt := AVE(GROUP,IF(h.AT_CERTEXP10 = (TYPEOF(h.AT_CERTEXP10))'',0,100));
    maxlength_AT_CERTEXP10 := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.AT_CERTEXP10)));
    avelength_AT_CERTEXP10 := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.AT_CERTEXP10)),h.AT_CERTEXP10<>(typeof(h.AT_CERTEXP10))'');
    populated_EFX_EXTRACT_DATE_pcnt := AVE(GROUP,IF(h.EFX_EXTRACT_DATE = (TYPEOF(h.EFX_EXTRACT_DATE))'',0,100));
    maxlength_EFX_EXTRACT_DATE := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.EFX_EXTRACT_DATE)));
    avelength_EFX_EXTRACT_DATE := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.EFX_EXTRACT_DATE)),h.EFX_EXTRACT_DATE<>(typeof(h.EFX_EXTRACT_DATE))'');
    populated_EFX_MERCHANT_ID_pcnt := AVE(GROUP,IF(h.EFX_MERCHANT_ID = (TYPEOF(h.EFX_MERCHANT_ID))'',0,100));
    maxlength_EFX_MERCHANT_ID := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.EFX_MERCHANT_ID)));
    avelength_EFX_MERCHANT_ID := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.EFX_MERCHANT_ID)),h.EFX_MERCHANT_ID<>(typeof(h.EFX_MERCHANT_ID))'');
    populated_EFX_PROJECT_ID_pcnt := AVE(GROUP,IF(h.EFX_PROJECT_ID = (TYPEOF(h.EFX_PROJECT_ID))'',0,100));
    maxlength_EFX_PROJECT_ID := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.EFX_PROJECT_ID)));
    avelength_EFX_PROJECT_ID := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.EFX_PROJECT_ID)),h.EFX_PROJECT_ID<>(typeof(h.EFX_PROJECT_ID))'');
    populated_EFX_FOREIGN_pcnt := AVE(GROUP,IF(h.EFX_FOREIGN = (TYPEOF(h.EFX_FOREIGN))'',0,100));
    maxlength_EFX_FOREIGN := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.EFX_FOREIGN)));
    avelength_EFX_FOREIGN := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.EFX_FOREIGN)),h.EFX_FOREIGN<>(typeof(h.EFX_FOREIGN))'');
    populated_Record_Update_Refresh_Date_pcnt := AVE(GROUP,IF(h.Record_Update_Refresh_Date = (TYPEOF(h.Record_Update_Refresh_Date))'',0,100));
    maxlength_Record_Update_Refresh_Date := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.Record_Update_Refresh_Date)));
    avelength_Record_Update_Refresh_Date := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.Record_Update_Refresh_Date)),h.Record_Update_Refresh_Date<>(typeof(h.Record_Update_Refresh_Date))'');
    populated_EFX_DATE_CREATED_pcnt := AVE(GROUP,IF(h.EFX_DATE_CREATED = (TYPEOF(h.EFX_DATE_CREATED))'',0,100));
    maxlength_EFX_DATE_CREATED := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.EFX_DATE_CREATED)));
    avelength_EFX_DATE_CREATED := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.EFX_DATE_CREATED)),h.EFX_DATE_CREATED<>(typeof(h.EFX_DATE_CREATED))'');
    populated_normCompany_Name_pcnt := AVE(GROUP,IF(h.normCompany_Name = (TYPEOF(h.normCompany_Name))'',0,100));
    maxlength_normCompany_Name := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.normCompany_Name)));
    avelength_normCompany_Name := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.normCompany_Name)),h.normCompany_Name<>(typeof(h.normCompany_Name))'');
    populated_normCompany_Type_pcnt := AVE(GROUP,IF(h.normCompany_Type = (TYPEOF(h.normCompany_Type))'',0,100));
    maxlength_normCompany_Type := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.normCompany_Type)));
    avelength_normCompany_Type := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.normCompany_Type)),h.normCompany_Type<>(typeof(h.normCompany_Type))'');
    populated_Norm_Geo_Precision_pcnt := AVE(GROUP,IF(h.Norm_Geo_Precision = (TYPEOF(h.Norm_Geo_Precision))'',0,100));
    maxlength_Norm_Geo_Precision := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.Norm_Geo_Precision)));
    avelength_Norm_Geo_Precision := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.Norm_Geo_Precision)),h.Norm_Geo_Precision<>(typeof(h.Norm_Geo_Precision))'');
    populated_Exploded_Desc_Corporate_Amount_Precision_pcnt := AVE(GROUP,IF(h.Exploded_Desc_Corporate_Amount_Precision = (TYPEOF(h.Exploded_Desc_Corporate_Amount_Precision))'',0,100));
    maxlength_Exploded_Desc_Corporate_Amount_Precision := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.Exploded_Desc_Corporate_Amount_Precision)));
    avelength_Exploded_Desc_Corporate_Amount_Precision := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.Exploded_Desc_Corporate_Amount_Precision)),h.Exploded_Desc_Corporate_Amount_Precision<>(typeof(h.Exploded_Desc_Corporate_Amount_Precision))'');
    populated_Exploded_Desc_Location_Amount_Precision_pcnt := AVE(GROUP,IF(h.Exploded_Desc_Location_Amount_Precision = (TYPEOF(h.Exploded_Desc_Location_Amount_Precision))'',0,100));
    maxlength_Exploded_Desc_Location_Amount_Precision := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.Exploded_Desc_Location_Amount_Precision)));
    avelength_Exploded_Desc_Location_Amount_Precision := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.Exploded_Desc_Location_Amount_Precision)),h.Exploded_Desc_Location_Amount_Precision<>(typeof(h.Exploded_Desc_Location_Amount_Precision))'');
    populated_Exploded_Desc_Public_Co_Indicator_pcnt := AVE(GROUP,IF(h.Exploded_Desc_Public_Co_Indicator = (TYPEOF(h.Exploded_Desc_Public_Co_Indicator))'',0,100));
    maxlength_Exploded_Desc_Public_Co_Indicator := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.Exploded_Desc_Public_Co_Indicator)));
    avelength_Exploded_Desc_Public_Co_Indicator := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.Exploded_Desc_Public_Co_Indicator)),h.Exploded_Desc_Public_Co_Indicator<>(typeof(h.Exploded_Desc_Public_Co_Indicator))'');
    populated_Exploded_Desc_Stock_Exchange_pcnt := AVE(GROUP,IF(h.Exploded_Desc_Stock_Exchange = (TYPEOF(h.Exploded_Desc_Stock_Exchange))'',0,100));
    maxlength_Exploded_Desc_Stock_Exchange := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.Exploded_Desc_Stock_Exchange)));
    avelength_Exploded_Desc_Stock_Exchange := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.Exploded_Desc_Stock_Exchange)),h.Exploded_Desc_Stock_Exchange<>(typeof(h.Exploded_Desc_Stock_Exchange))'');
    populated_Exploded_Desc_Telemarketablity_Score_pcnt := AVE(GROUP,IF(h.Exploded_Desc_Telemarketablity_Score = (TYPEOF(h.Exploded_Desc_Telemarketablity_Score))'',0,100));
    maxlength_Exploded_Desc_Telemarketablity_Score := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.Exploded_Desc_Telemarketablity_Score)));
    avelength_Exploded_Desc_Telemarketablity_Score := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.Exploded_Desc_Telemarketablity_Score)),h.Exploded_Desc_Telemarketablity_Score<>(typeof(h.Exploded_Desc_Telemarketablity_Score))'');
    populated_Exploded_Desc_Telemarketablity_Total_Indicator_pcnt := AVE(GROUP,IF(h.Exploded_Desc_Telemarketablity_Total_Indicator = (TYPEOF(h.Exploded_Desc_Telemarketablity_Total_Indicator))'',0,100));
    maxlength_Exploded_Desc_Telemarketablity_Total_Indicator := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.Exploded_Desc_Telemarketablity_Total_Indicator)));
    avelength_Exploded_Desc_Telemarketablity_Total_Indicator := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.Exploded_Desc_Telemarketablity_Total_Indicator)),h.Exploded_Desc_Telemarketablity_Total_Indicator<>(typeof(h.Exploded_Desc_Telemarketablity_Total_Indicator))'');
    populated_Exploded_Desc_Telemarketablity_Total_Score_pcnt := AVE(GROUP,IF(h.Exploded_Desc_Telemarketablity_Total_Score = (TYPEOF(h.Exploded_Desc_Telemarketablity_Total_Score))'',0,100));
    maxlength_Exploded_Desc_Telemarketablity_Total_Score := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.Exploded_Desc_Telemarketablity_Total_Score)));
    avelength_Exploded_Desc_Telemarketablity_Total_Score := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.Exploded_Desc_Telemarketablity_Total_Score)),h.Exploded_Desc_Telemarketablity_Total_Score<>(typeof(h.Exploded_Desc_Telemarketablity_Total_Score))'');
    populated_Exploded_Desc_Government1057_Entity_pcnt := AVE(GROUP,IF(h.Exploded_Desc_Government1057_Entity = (TYPEOF(h.Exploded_Desc_Government1057_Entity))'',0,100));
    maxlength_Exploded_Desc_Government1057_Entity := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.Exploded_Desc_Government1057_Entity)));
    avelength_Exploded_Desc_Government1057_Entity := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.Exploded_Desc_Government1057_Entity)),h.Exploded_Desc_Government1057_Entity<>(typeof(h.Exploded_Desc_Government1057_Entity))'');
    populated_Exploded_Desc_Merchant_Type_pcnt := AVE(GROUP,IF(h.Exploded_Desc_Merchant_Type = (TYPEOF(h.Exploded_Desc_Merchant_Type))'',0,100));
    maxlength_Exploded_Desc_Merchant_Type := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.Exploded_Desc_Merchant_Type)));
    avelength_Exploded_Desc_Merchant_Type := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.Exploded_Desc_Merchant_Type)),h.Exploded_Desc_Merchant_Type<>(typeof(h.Exploded_Desc_Merchant_Type))'');
    populated_Exploded_Desc_Busstatcd_pcnt := AVE(GROUP,IF(h.Exploded_Desc_Busstatcd = (TYPEOF(h.Exploded_Desc_Busstatcd))'',0,100));
    maxlength_Exploded_Desc_Busstatcd := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.Exploded_Desc_Busstatcd)));
    avelength_Exploded_Desc_Busstatcd := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.Exploded_Desc_Busstatcd)),h.Exploded_Desc_Busstatcd<>(typeof(h.Exploded_Desc_Busstatcd))'');
    populated_Exploded_Desc_CMSA_pcnt := AVE(GROUP,IF(h.Exploded_Desc_CMSA = (TYPEOF(h.Exploded_Desc_CMSA))'',0,100));
    maxlength_Exploded_Desc_CMSA := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.Exploded_Desc_CMSA)));
    avelength_Exploded_Desc_CMSA := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.Exploded_Desc_CMSA)),h.Exploded_Desc_CMSA<>(typeof(h.Exploded_Desc_CMSA))'');
    populated_Exploded_Desc_Corpamountcd_pcnt := AVE(GROUP,IF(h.Exploded_Desc_Corpamountcd = (TYPEOF(h.Exploded_Desc_Corpamountcd))'',0,100));
    maxlength_Exploded_Desc_Corpamountcd := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.Exploded_Desc_Corpamountcd)));
    avelength_Exploded_Desc_Corpamountcd := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.Exploded_Desc_Corpamountcd)),h.Exploded_Desc_Corpamountcd<>(typeof(h.Exploded_Desc_Corpamountcd))'');
    populated_Exploded_Desc_Corpamountprec_pcnt := AVE(GROUP,IF(h.Exploded_Desc_Corpamountprec = (TYPEOF(h.Exploded_Desc_Corpamountprec))'',0,100));
    maxlength_Exploded_Desc_Corpamountprec := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.Exploded_Desc_Corpamountprec)));
    avelength_Exploded_Desc_Corpamountprec := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.Exploded_Desc_Corpamountprec)),h.Exploded_Desc_Corpamountprec<>(typeof(h.Exploded_Desc_Corpamountprec))'');
    populated_Exploded_Desc_Corpamounttp_pcnt := AVE(GROUP,IF(h.Exploded_Desc_Corpamounttp = (TYPEOF(h.Exploded_Desc_Corpamounttp))'',0,100));
    maxlength_Exploded_Desc_Corpamounttp := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.Exploded_Desc_Corpamounttp)));
    avelength_Exploded_Desc_Corpamounttp := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.Exploded_Desc_Corpamounttp)),h.Exploded_Desc_Corpamounttp<>(typeof(h.Exploded_Desc_Corpamounttp))'');
    populated_Exploded_Desc_Corpempcd_pcnt := AVE(GROUP,IF(h.Exploded_Desc_Corpempcd = (TYPEOF(h.Exploded_Desc_Corpempcd))'',0,100));
    maxlength_Exploded_Desc_Corpempcd := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.Exploded_Desc_Corpempcd)));
    avelength_Exploded_Desc_Corpempcd := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.Exploded_Desc_Corpempcd)),h.Exploded_Desc_Corpempcd<>(typeof(h.Exploded_Desc_Corpempcd))'');
    populated_Exploded_Desc_Ctrytelcd_pcnt := AVE(GROUP,IF(h.Exploded_Desc_Ctrytelcd = (TYPEOF(h.Exploded_Desc_Ctrytelcd))'',0,100));
    maxlength_Exploded_Desc_Ctrytelcd := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.Exploded_Desc_Ctrytelcd)));
    avelength_Exploded_Desc_Ctrytelcd := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.Exploded_Desc_Ctrytelcd)),h.Exploded_Desc_Ctrytelcd<>(typeof(h.Exploded_Desc_Ctrytelcd))'');
    populated_NormAddress_Type_pcnt := AVE(GROUP,IF(h.NormAddress_Type = (TYPEOF(h.NormAddress_Type))'',0,100));
    maxlength_NormAddress_Type := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.NormAddress_Type)));
    avelength_NormAddress_Type := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.NormAddress_Type)),h.NormAddress_Type<>(typeof(h.NormAddress_Type))'');
    populated_Norm_Address_pcnt := AVE(GROUP,IF(h.Norm_Address = (TYPEOF(h.Norm_Address))'',0,100));
    maxlength_Norm_Address := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.Norm_Address)));
    avelength_Norm_Address := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.Norm_Address)),h.Norm_Address<>(typeof(h.Norm_Address))'');
    populated_Norm_City_pcnt := AVE(GROUP,IF(h.Norm_City = (TYPEOF(h.Norm_City))'',0,100));
    maxlength_Norm_City := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.Norm_City)));
    avelength_Norm_City := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.Norm_City)),h.Norm_City<>(typeof(h.Norm_City))'');
    populated_Norm_State_pcnt := AVE(GROUP,IF(h.Norm_State = (TYPEOF(h.Norm_State))'',0,100));
    maxlength_Norm_State := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.Norm_State)));
    avelength_Norm_State := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.Norm_State)),h.Norm_State<>(typeof(h.Norm_State))'');
    populated_Norm_StateC2_pcnt := AVE(GROUP,IF(h.Norm_StateC2 = (TYPEOF(h.Norm_StateC2))'',0,100));
    maxlength_Norm_StateC2 := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.Norm_StateC2)));
    avelength_Norm_StateC2 := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.Norm_StateC2)),h.Norm_StateC2<>(typeof(h.Norm_StateC2))'');
    populated_Norm_Zip_pcnt := AVE(GROUP,IF(h.Norm_Zip = (TYPEOF(h.Norm_Zip))'',0,100));
    maxlength_Norm_Zip := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.Norm_Zip)));
    avelength_Norm_Zip := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.Norm_Zip)),h.Norm_Zip<>(typeof(h.Norm_Zip))'');
    populated_Norm_Zip4_pcnt := AVE(GROUP,IF(h.Norm_Zip4 = (TYPEOF(h.Norm_Zip4))'',0,100));
    maxlength_Norm_Zip4 := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.Norm_Zip4)));
    avelength_Norm_Zip4 := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.Norm_Zip4)),h.Norm_Zip4<>(typeof(h.Norm_Zip4))'');
    populated_Norm_Lat_pcnt := AVE(GROUP,IF(h.Norm_Lat = (TYPEOF(h.Norm_Lat))'',0,100));
    maxlength_Norm_Lat := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.Norm_Lat)));
    avelength_Norm_Lat := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.Norm_Lat)),h.Norm_Lat<>(typeof(h.Norm_Lat))'');
    populated_Norm_Lon_pcnt := AVE(GROUP,IF(h.Norm_Lon = (TYPEOF(h.Norm_Lon))'',0,100));
    maxlength_Norm_Lon := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.Norm_Lon)));
    avelength_Norm_Lon := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.Norm_Lon)),h.Norm_Lon<>(typeof(h.Norm_Lon))'');
    populated_Norm_Geoprec_pcnt := AVE(GROUP,IF(h.Norm_Geoprec = (TYPEOF(h.Norm_Geoprec))'',0,100));
    maxlength_Norm_Geoprec := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.Norm_Geoprec)));
    avelength_Norm_Geoprec := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.Norm_Geoprec)),h.Norm_Geoprec<>(typeof(h.Norm_Geoprec))'');
    populated_Norm_Region_pcnt := AVE(GROUP,IF(h.Norm_Region = (TYPEOF(h.Norm_Region))'',0,100));
    maxlength_Norm_Region := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.Norm_Region)));
    avelength_Norm_Region := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.Norm_Region)),h.Norm_Region<>(typeof(h.Norm_Region))'');
    populated_Norm_Ctryisocd_pcnt := AVE(GROUP,IF(h.Norm_Ctryisocd = (TYPEOF(h.Norm_Ctryisocd))'',0,100));
    maxlength_Norm_Ctryisocd := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.Norm_Ctryisocd)));
    avelength_Norm_Ctryisocd := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.Norm_Ctryisocd)),h.Norm_Ctryisocd<>(typeof(h.Norm_Ctryisocd))'');
    populated_Norm_Ctrynum_pcnt := AVE(GROUP,IF(h.Norm_Ctrynum = (TYPEOF(h.Norm_Ctrynum))'',0,100));
    maxlength_Norm_Ctrynum := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.Norm_Ctrynum)));
    avelength_Norm_Ctrynum := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.Norm_Ctrynum)),h.Norm_Ctrynum<>(typeof(h.Norm_Ctrynum))'');
    populated_Norm_Ctryname_pcnt := AVE(GROUP,IF(h.Norm_Ctryname = (TYPEOF(h.Norm_Ctryname))'',0,100));
    maxlength_Norm_Ctryname := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.Norm_Ctryname)));
    avelength_Norm_Ctryname := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.Norm_Ctryname)),h.Norm_Ctryname<>(typeof(h.Norm_Ctryname))'');
    populated_clean_company_name_pcnt := AVE(GROUP,IF(h.clean_company_name = (TYPEOF(h.clean_company_name))'',0,100));
    maxlength_clean_company_name := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.clean_company_name)));
    avelength_clean_company_name := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.clean_company_name)),h.clean_company_name<>(typeof(h.clean_company_name))'');
    populated_clean_phone_pcnt := AVE(GROUP,IF(h.clean_phone = (TYPEOF(h.clean_phone))'',0,100));
    maxlength_clean_phone := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.clean_phone)));
    avelength_clean_phone := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.clean_phone)),h.clean_phone<>(typeof(h.clean_phone))'');
    populated_clean_secondary_phone_pcnt := AVE(GROUP,IF(h.clean_secondary_phone = (TYPEOF(h.clean_secondary_phone))'',0,100));
    maxlength_clean_secondary_phone := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.clean_secondary_phone)));
    avelength_clean_secondary_phone := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.clean_secondary_phone)),h.clean_secondary_phone<>(typeof(h.clean_secondary_phone))'');
    populated_prim_range_pcnt := AVE(GROUP,IF(h.prim_range = (TYPEOF(h.prim_range))'',0,100));
    maxlength_prim_range := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.prim_range)));
    avelength_prim_range := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.prim_range)),h.prim_range<>(typeof(h.prim_range))'');
    populated_predir_pcnt := AVE(GROUP,IF(h.predir = (TYPEOF(h.predir))'',0,100));
    maxlength_predir := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.predir)));
    avelength_predir := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.predir)),h.predir<>(typeof(h.predir))'');
    populated_prim_name_pcnt := AVE(GROUP,IF(h.prim_name = (TYPEOF(h.prim_name))'',0,100));
    maxlength_prim_name := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.prim_name)));
    avelength_prim_name := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.prim_name)),h.prim_name<>(typeof(h.prim_name))'');
    populated_addr_suffix_pcnt := AVE(GROUP,IF(h.addr_suffix = (TYPEOF(h.addr_suffix))'',0,100));
    maxlength_addr_suffix := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.addr_suffix)));
    avelength_addr_suffix := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.addr_suffix)),h.addr_suffix<>(typeof(h.addr_suffix))'');
    populated_postdir_pcnt := AVE(GROUP,IF(h.postdir = (TYPEOF(h.postdir))'',0,100));
    maxlength_postdir := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.postdir)));
    avelength_postdir := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.postdir)),h.postdir<>(typeof(h.postdir))'');
    populated_unit_desig_pcnt := AVE(GROUP,IF(h.unit_desig = (TYPEOF(h.unit_desig))'',0,100));
    maxlength_unit_desig := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.unit_desig)));
    avelength_unit_desig := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.unit_desig)),h.unit_desig<>(typeof(h.unit_desig))'');
    populated_sec_range_pcnt := AVE(GROUP,IF(h.sec_range = (TYPEOF(h.sec_range))'',0,100));
    maxlength_sec_range := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.sec_range)));
    avelength_sec_range := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.sec_range)),h.sec_range<>(typeof(h.sec_range))'');
    populated_p_city_name_pcnt := AVE(GROUP,IF(h.p_city_name = (TYPEOF(h.p_city_name))'',0,100));
    maxlength_p_city_name := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.p_city_name)));
    avelength_p_city_name := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.p_city_name)),h.p_city_name<>(typeof(h.p_city_name))'');
    populated_v_city_name_pcnt := AVE(GROUP,IF(h.v_city_name = (TYPEOF(h.v_city_name))'',0,100));
    maxlength_v_city_name := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.v_city_name)));
    avelength_v_city_name := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.v_city_name)),h.v_city_name<>(typeof(h.v_city_name))'');
    populated_st_pcnt := AVE(GROUP,IF(h.st = (TYPEOF(h.st))'',0,100));
    maxlength_st := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.st)));
    avelength_st := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.st)),h.st<>(typeof(h.st))'');
    populated_cart_pcnt := AVE(GROUP,IF(h.cart = (TYPEOF(h.cart))'',0,100));
    maxlength_cart := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.cart)));
    avelength_cart := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.cart)),h.cart<>(typeof(h.cart))'');
    populated_cr_sort_sz_pcnt := AVE(GROUP,IF(h.cr_sort_sz = (TYPEOF(h.cr_sort_sz))'',0,100));
    maxlength_cr_sort_sz := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.cr_sort_sz)));
    avelength_cr_sort_sz := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.cr_sort_sz)),h.cr_sort_sz<>(typeof(h.cr_sort_sz))'');
  END;
    T := IF(Glob,TABLE(h,SummaryLayout),TABLE(h,SummaryLayout,source,FEW));
  R1 := RECORD
    UNSIGNED LinkingPotential :=  + T.Populated_dt_first_seen_pcnt *   0.00 / 100 + T.Populated_dt_last_seen_pcnt *   0.00 / 100 + T.Populated_dt_vendor_first_reported_pcnt *   0.00 / 100 + T.Populated_dt_vendor_last_reported_pcnt *   0.00 / 100 + T.Populated_dt_effective_first_pcnt *   0.00 / 100 + T.Populated_dt_effective_last_pcnt *   0.00 / 100 + T.Populated_process_date_pcnt *   0.00 / 100 + T.Populated_dotid_pcnt *   0.00 / 100 + T.Populated_dotscore_pcnt *   0.00 / 100 + T.Populated_dotweight_pcnt *   0.00 / 100 + T.Populated_empid_pcnt *   0.00 / 100 + T.Populated_empscore_pcnt *   0.00 / 100 + T.Populated_empweight_pcnt *   0.00 / 100 + T.Populated_powid_pcnt *   0.00 / 100 + T.Populated_powscore_pcnt *   0.00 / 100 + T.Populated_powweight_pcnt *   0.00 / 100 + T.Populated_proxid_pcnt *   0.00 / 100 + T.Populated_proxscore_pcnt *   0.00 / 100 + T.Populated_proxweight_pcnt *   0.00 / 100 + T.Populated_selescore_pcnt *   0.00 / 100 + T.Populated_seleweight_pcnt *   0.00 / 100 + T.Populated_orgid_pcnt *   0.00 / 100 + T.Populated_orgscore_pcnt *   0.00 / 100 + T.Populated_orgweight_pcnt *   0.00 / 100 + T.Populated_ultid_pcnt *   0.00 / 100 + T.Populated_ultscore_pcnt *   0.00 / 100 + T.Populated_ultweight_pcnt *   0.00 / 100 + T.Populated_record_type_pcnt *   0.00 / 100 + T.Populated_EFX_ID_pcnt *   0.00 / 100 + T.Populated_EFX_NAME_pcnt *   0.00 / 100 + T.Populated_EFX_LEGAL_NAME_pcnt *   0.00 / 100 + T.Populated_EFX_ADDRESS_pcnt *   0.00 / 100 + T.Populated_EFX_CITY_pcnt *   0.00 / 100 + T.Populated_EFX_STATE_pcnt *   0.00 / 100 + T.Populated_EFX_STATEC_pcnt *   0.00 / 100 + T.Populated_EFX_ZIPCODE_pcnt *   0.00 / 100 + T.Populated_EFX_ZIP4_pcnt *   0.00 / 100 + T.Populated_EFX_LAT_pcnt *   0.00 / 100 + T.Populated_EFX_LON_pcnt *   0.00 / 100 + T.Populated_EFX_GEOPREC_pcnt *   0.00 / 100 + T.Populated_EFX_REGION_pcnt *   0.00 / 100 + T.Populated_EFX_CTRYISOCD_pcnt *   0.00 / 100 + T.Populated_EFX_CTRYNUM_pcnt *   0.00 / 100 + T.Populated_EFX_CTRYNAME_pcnt *   0.00 / 100 + T.Populated_EFX_COUNTYNM_pcnt *   0.00 / 100 + T.Populated_EFX_COUNTY_pcnt *   0.00 / 100 + T.Populated_EFX_CMSA_pcnt *   0.00 / 100 + T.Populated_EFX_CMSADESC_pcnt *   0.00 / 100 + T.Populated_EFX_SOHO_pcnt *   0.00 / 100 + T.Populated_EFX_BIZ_pcnt *   0.00 / 100 + T.Populated_EFX_RES_pcnt *   0.00 / 100 + T.Populated_EFX_CMRA_pcnt *   0.00 / 100 + T.Populated_EFX_CONGRESS_pcnt *   0.00 / 100 + T.Populated_EFX_SECADR_pcnt *   0.00 / 100 + T.Populated_EFX_SECCTY_pcnt *   0.00 / 100 + T.Populated_EFX_SECSTAT_pcnt *   0.00 / 100 + T.Populated_EFX_STATEC2_pcnt *   0.00 / 100 + T.Populated_EFX_SECZIP_pcnt *   0.00 / 100 + T.Populated_EFX_SECZIP4_pcnt *   0.00 / 100 + T.Populated_EFX_SECLAT_pcnt *   0.00 / 100 + T.Populated_EFX_SECLON_pcnt *   0.00 / 100 + T.Populated_EFX_SECGEOPREC_pcnt *   0.00 / 100 + T.Populated_EFX_SECREGION_pcnt *   0.00 / 100 + T.Populated_EFX_SECCTRYISOCD_pcnt *   0.00 / 100 + T.Populated_EFX_SECCTRYNUM_pcnt *   0.00 / 100 + T.Populated_EFX_SECCTRYNAME_pcnt *   0.00 / 100 + T.Populated_EFX_CTRYTELCD_pcnt *   0.00 / 100 + T.Populated_EFX_PHONE_pcnt *   0.00 / 100 + T.Populated_EFX_FAXPHONE_pcnt *   0.00 / 100 + T.Populated_EFX_BUSSTAT_pcnt *   0.00 / 100 + T.Populated_EFX_BUSSTATCD_pcnt *   0.00 / 100 + T.Populated_EFX_WEB_pcnt *   0.00 / 100 + T.Populated_EFX_YREST_pcnt *   0.00 / 100 + T.Populated_EFX_CORPEMPCNT_pcnt *   0.00 / 100 + T.Populated_EFX_LOCEMPCNT_pcnt *   0.00 / 100 + T.Populated_EFX_CORPEMPCD_pcnt *   0.00 / 100 + T.Populated_EFX_LOCEMPCD_pcnt *   0.00 / 100 + T.Populated_EFX_CORPAMOUNT_pcnt *   0.00 / 100 + T.Populated_EFX_CORPAMOUNTCD_pcnt *   0.00 / 100 + T.Populated_EFX_CORPAMOUNTTP_pcnt *   0.00 / 100 + T.Populated_EFX_CORPAMOUNTPREC_pcnt *   0.00 / 100 + T.Populated_EFX_LOCAMOUNT_pcnt *   0.00 / 100 + T.Populated_EFX_LOCAMOUNTCD_pcnt *   0.00 / 100 + T.Populated_EFX_LOCAMOUNTTP_pcnt *   0.00 / 100 + T.Populated_EFX_LOCAMOUNTPREC_pcnt *   0.00 / 100 + T.Populated_EFX_PUBLIC_pcnt *   0.00 / 100 + T.Populated_EFX_STKEXC_pcnt *   0.00 / 100 + T.Populated_EFX_TCKSYM_pcnt *   0.00 / 100 + T.Populated_EFX_PRIMSIC_pcnt *   0.00 / 100 + T.Populated_EFX_SECSIC1_pcnt *   0.00 / 100 + T.Populated_EFX_SECSIC2_pcnt *   0.00 / 100 + T.Populated_EFX_SECSIC3_pcnt *   0.00 / 100 + T.Populated_EFX_SECSIC4_pcnt *   0.00 / 100 + T.Populated_EFX_PRIMSICDESC_pcnt *   0.00 / 100 + T.Populated_EFX_SECSICDESC1_pcnt *   0.00 / 100 + T.Populated_EFX_SECSICDESC2_pcnt *   0.00 / 100 + T.Populated_EFX_SECSICDESC3_pcnt *   0.00 / 100 + T.Populated_EFX_SECSICDESC4_pcnt *   0.00 / 100 + T.Populated_EFX_PRIMNAICSCODE_pcnt *   0.00 / 100 + T.Populated_EFX_SECNAICS1_pcnt *   0.00 / 100 + T.Populated_EFX_SECNAICS2_pcnt *   0.00 / 100 + T.Populated_EFX_SECNAICS3_pcnt *   0.00 / 100 + T.Populated_EFX_SECNAICS4_pcnt *   0.00 / 100 + T.Populated_EFX_PRIMNAICSDESC_pcnt *   0.00 / 100 + T.Populated_EFX_SECNAICSDESC1_pcnt *   0.00 / 100 + T.Populated_EFX_SECNAICSDESC2_pcnt *   0.00 / 100 + T.Populated_EFX_SECNAICSDESC3_pcnt *   0.00 / 100 + T.Populated_EFX_SECNAICSDESC4_pcnt *   0.00 / 100 + T.Populated_EFX_DEAD_pcnt *   0.00 / 100 + T.Populated_EFX_DEADDT_pcnt *   0.00 / 100 + T.Populated_EFX_MRKT_TELEVER_pcnt *   0.00 / 100 + T.Populated_EFX_MRKT_TELESCORE_pcnt *   0.00 / 100 + T.Populated_EFX_MRKT_TOTALSCORE_pcnt *   0.00 / 100 + T.Populated_EFX_MRKT_TOTALIND_pcnt *   0.00 / 100 + T.Populated_EFX_MRKT_VACANT_pcnt *   0.00 / 100 + T.Populated_EFX_MRKT_SEASONAL_pcnt *   0.00 / 100 + T.Populated_EFX_MBE_pcnt *   0.00 / 100 + T.Populated_EFX_WBE_pcnt *   0.00 / 100 + T.Populated_EFX_MWBE_pcnt *   0.00 / 100 + T.Populated_EFX_SDB_pcnt *   0.00 / 100 + T.Populated_EFX_HUBZONE_pcnt *   0.00 / 100 + T.Populated_EFX_DBE_pcnt *   0.00 / 100 + T.Populated_EFX_VET_pcnt *   0.00 / 100 + T.Populated_EFX_DVET_pcnt *   0.00 / 100 + T.Populated_EFX_8a_pcnt *   0.00 / 100 + T.Populated_EFX_8aEXPDT_pcnt *   0.00 / 100 + T.Populated_EFX_DIS_pcnt *   0.00 / 100 + T.Populated_EFX_SBE_pcnt *   0.00 / 100 + T.Populated_EFX_BUSSIZE_pcnt *   0.00 / 100 + T.Populated_EFX_LBE_pcnt *   0.00 / 100 + T.Populated_EFX_GOV_pcnt *   0.00 / 100 + T.Populated_EFX_FGOV_pcnt *   0.00 / 100 + T.Populated_EFX_GOV1057_pcnt *   0.00 / 100 + T.Populated_EFX_NONPROFIT_pcnt *   0.00 / 100 + T.Populated_EFX_MERCTYPE_pcnt *   0.00 / 100 + T.Populated_EFX_HBCU_pcnt *   0.00 / 100 + T.Populated_EFX_GAYLESBIAN_pcnt *   0.00 / 100 + T.Populated_EFX_WSBE_pcnt *   0.00 / 100 + T.Populated_EFX_VSBE_pcnt *   0.00 / 100 + T.Populated_EFX_DVSBE_pcnt *   0.00 / 100 + T.Populated_EFX_MWBESTATUS_pcnt *   0.00 / 100 + T.Populated_EFX_NMSDC_pcnt *   0.00 / 100 + T.Populated_EFX_WBENC_pcnt *   0.00 / 100 + T.Populated_EFX_CA_PUC_pcnt *   0.00 / 100 + T.Populated_EFX_TX_HUB_pcnt *   0.00 / 100 + T.Populated_EFX_TX_HUBCERTNUM_pcnt *   0.00 / 100 + T.Populated_EFX_GSAX_pcnt *   0.00 / 100 + T.Populated_EFX_CALTRANS_pcnt *   0.00 / 100 + T.Populated_EFX_EDU_pcnt *   0.00 / 100 + T.Populated_EFX_MI_pcnt *   0.00 / 100 + T.Populated_EFX_ANC_pcnt *   0.00 / 100 + T.Populated_AT_CERT1_pcnt *   0.00 / 100 + T.Populated_AT_CERT2_pcnt *   0.00 / 100 + T.Populated_AT_CERT3_pcnt *   0.00 / 100 + T.Populated_AT_CERT4_pcnt *   0.00 / 100 + T.Populated_AT_CERT5_pcnt *   0.00 / 100 + T.Populated_AT_CERT6_pcnt *   0.00 / 100 + T.Populated_AT_CERT7_pcnt *   0.00 / 100 + T.Populated_AT_CERT8_pcnt *   0.00 / 100 + T.Populated_AT_CERT9_pcnt *   0.00 / 100 + T.Populated_AT_CERT10_pcnt *   0.00 / 100 + T.Populated_AT_CERTDESC1_pcnt *   0.00 / 100 + T.Populated_AT_CERTDESC2_pcnt *   0.00 / 100 + T.Populated_AT_CERTDESC3_pcnt *   0.00 / 100 + T.Populated_AT_CERTDESC4_pcnt *   0.00 / 100 + T.Populated_AT_CERTDESC5_pcnt *   0.00 / 100 + T.Populated_AT_CERTDESC6_pcnt *   0.00 / 100 + T.Populated_AT_CERTDESC7_pcnt *   0.00 / 100 + T.Populated_AT_CERTDESC8_pcnt *   0.00 / 100 + T.Populated_AT_CERTDESC9_pcnt *   0.00 / 100 + T.Populated_AT_CERTDESC10_pcnt *   0.00 / 100 + T.Populated_AT_CERTSRC1_pcnt *   0.00 / 100 + T.Populated_AT_CERTSRC2_pcnt *   0.00 / 100 + T.Populated_AT_CERTSRC3_pcnt *   0.00 / 100 + T.Populated_AT_CERTSRC4_pcnt *   0.00 / 100 + T.Populated_AT_CERTSRC5_pcnt *   0.00 / 100 + T.Populated_AT_CERTSRC6_pcnt *   0.00 / 100 + T.Populated_AT_CERTSRC7_pcnt *   0.00 / 100 + T.Populated_AT_CERTSRC8_pcnt *   0.00 / 100 + T.Populated_AT_CERTSRC9_pcnt *   0.00 / 100 + T.Populated_AT_CERTSRC10_pcnt *   0.00 / 100 + T.Populated_AT_CERTLEV1_pcnt *   0.00 / 100 + T.Populated_AT_CERTLEV2_pcnt *   0.00 / 100 + T.Populated_AT_CERTLEV3_pcnt *   0.00 / 100 + T.Populated_AT_CERTLEV4_pcnt *   0.00 / 100 + T.Populated_AT_CERTLEV5_pcnt *   0.00 / 100 + T.Populated_AT_CERTLEV6_pcnt *   0.00 / 100 + T.Populated_AT_CERTLEV7_pcnt *   0.00 / 100 + T.Populated_AT_CERTLEV8_pcnt *   0.00 / 100 + T.Populated_AT_CERTLEV9_pcnt *   0.00 / 100 + T.Populated_AT_CERTLEV10_pcnt *   0.00 / 100 + T.Populated_AT_CERTNUM1_pcnt *   0.00 / 100 + T.Populated_AT_CERTNUM2_pcnt *   0.00 / 100 + T.Populated_AT_CERTNUM3_pcnt *   0.00 / 100 + T.Populated_AT_CERTNUM4_pcnt *   0.00 / 100 + T.Populated_AT_CERTNUM5_pcnt *   0.00 / 100 + T.Populated_AT_CERTNUM6_pcnt *   0.00 / 100 + T.Populated_AT_CERTNUM7_pcnt *   0.00 / 100 + T.Populated_AT_CERTNUM8_pcnt *   0.00 / 100 + T.Populated_AT_CERTNUM9_pcnt *   0.00 / 100 + T.Populated_AT_CERTNUM10_pcnt *   0.00 / 100 + T.Populated_AT_CERTEXP1_pcnt *   0.00 / 100 + T.Populated_AT_CERTEXP2_pcnt *   0.00 / 100 + T.Populated_AT_CERTEXP3_pcnt *   0.00 / 100 + T.Populated_AT_CERTEXP4_pcnt *   0.00 / 100 + T.Populated_AT_CERTEXP5_pcnt *   0.00 / 100 + T.Populated_AT_CERTEXP6_pcnt *   0.00 / 100 + T.Populated_AT_CERTEXP7_pcnt *   0.00 / 100 + T.Populated_AT_CERTEXP8_pcnt *   0.00 / 100 + T.Populated_AT_CERTEXP9_pcnt *   0.00 / 100 + T.Populated_AT_CERTEXP10_pcnt *   0.00 / 100 + T.Populated_EFX_EXTRACT_DATE_pcnt *   0.00 / 100 + T.Populated_EFX_MERCHANT_ID_pcnt *   0.00 / 100 + T.Populated_EFX_PROJECT_ID_pcnt *   0.00 / 100 + T.Populated_EFX_FOREIGN_pcnt *   0.00 / 100 + T.Populated_Record_Update_Refresh_Date_pcnt *   0.00 / 100 + T.Populated_EFX_DATE_CREATED_pcnt *   0.00 / 100 + T.Populated_normCompany_Name_pcnt *   0.00 / 100 + T.Populated_normCompany_Type_pcnt *   0.00 / 100 + T.Populated_Norm_Geo_Precision_pcnt *   0.00 / 100 + T.Populated_Exploded_Desc_Corporate_Amount_Precision_pcnt *   0.00 / 100 + T.Populated_Exploded_Desc_Location_Amount_Precision_pcnt *   0.00 / 100 + T.Populated_Exploded_Desc_Public_Co_Indicator_pcnt *   0.00 / 100 + T.Populated_Exploded_Desc_Stock_Exchange_pcnt *   0.00 / 100 + T.Populated_Exploded_Desc_Telemarketablity_Score_pcnt *   0.00 / 100 + T.Populated_Exploded_Desc_Telemarketablity_Total_Indicator_pcnt *   0.00 / 100 + T.Populated_Exploded_Desc_Telemarketablity_Total_Score_pcnt *   0.00 / 100 + T.Populated_Exploded_Desc_Government1057_Entity_pcnt *   0.00 / 100 + T.Populated_Exploded_Desc_Merchant_Type_pcnt *   0.00 / 100 + T.Populated_Exploded_Desc_Busstatcd_pcnt *   0.00 / 100 + T.Populated_Exploded_Desc_CMSA_pcnt *   0.00 / 100 + T.Populated_Exploded_Desc_Corpamountcd_pcnt *   0.00 / 100 + T.Populated_Exploded_Desc_Corpamountprec_pcnt *   0.00 / 100 + T.Populated_Exploded_Desc_Corpamounttp_pcnt *   0.00 / 100 + T.Populated_Exploded_Desc_Corpempcd_pcnt *   0.00 / 100 + T.Populated_Exploded_Desc_Ctrytelcd_pcnt *   0.00 / 100 + T.Populated_NormAddress_Type_pcnt *   0.00 / 100 + T.Populated_Norm_Address_pcnt *   0.00 / 100 + T.Populated_Norm_City_pcnt *   0.00 / 100 + T.Populated_Norm_State_pcnt *   0.00 / 100 + T.Populated_Norm_StateC2_pcnt *   0.00 / 100 + T.Populated_Norm_Zip_pcnt *   0.00 / 100 + T.Populated_Norm_Zip4_pcnt *   0.00 / 100 + T.Populated_Norm_Lat_pcnt *   0.00 / 100 + T.Populated_Norm_Lon_pcnt *   0.00 / 100 + T.Populated_Norm_Geoprec_pcnt *   0.00 / 100 + T.Populated_Norm_Region_pcnt *   0.00 / 100 + T.Populated_Norm_Ctryisocd_pcnt *   0.00 / 100 + T.Populated_Norm_Ctrynum_pcnt *   0.00 / 100 + T.Populated_Norm_Ctryname_pcnt *   0.00 / 100 + T.Populated_clean_company_name_pcnt *   0.00 / 100 + T.Populated_clean_phone_pcnt *   0.00 / 100 + T.Populated_clean_secondary_phone_pcnt *   0.00 / 100 + T.Populated_prim_range_pcnt *   0.00 / 100 + T.Populated_predir_pcnt *   0.00 / 100 + T.Populated_prim_name_pcnt *   0.00 / 100 + T.Populated_addr_suffix_pcnt *   0.00 / 100 + T.Populated_postdir_pcnt *   0.00 / 100 + T.Populated_unit_desig_pcnt *   0.00 / 100 + T.Populated_sec_range_pcnt *   0.00 / 100 + T.Populated_p_city_name_pcnt *   0.00 / 100 + T.Populated_v_city_name_pcnt *   0.00 / 100 + T.Populated_st_pcnt *   0.00 / 100 + T.Populated_cart_pcnt *   0.00 / 100 + T.Populated_cr_sort_sz_pcnt *   0.00 / 100;
    T;
  END;
  RETURN TABLE(T,R1);
END;
 
EXPORT SourceCounts := Summary('SummaryBySource',FALSE);  R := RECORD
    STRING source1;
    STRING source2;
    UNSIGNED LinkingPotential;
  END;
  R T(SourceCounts le, SourceCounts ri) := TRANSFORM
    SELF.source1 := le.Source;
    SELF.source2 := ri.Source;
    SELF.LinkingPotential := 0 + le.Populated_dt_first_seen_pcnt*ri.Populated_dt_first_seen_pcnt *   0.00 / 10000 + le.Populated_dt_last_seen_pcnt*ri.Populated_dt_last_seen_pcnt *   0.00 / 10000 + le.Populated_dt_vendor_first_reported_pcnt*ri.Populated_dt_vendor_first_reported_pcnt *   0.00 / 10000 + le.Populated_dt_vendor_last_reported_pcnt*ri.Populated_dt_vendor_last_reported_pcnt *   0.00 / 10000 + le.Populated_dt_effective_first_pcnt*ri.Populated_dt_effective_first_pcnt *   0.00 / 10000 + le.Populated_dt_effective_last_pcnt*ri.Populated_dt_effective_last_pcnt *   0.00 / 10000 + le.Populated_process_date_pcnt*ri.Populated_process_date_pcnt *   0.00 / 10000 + le.Populated_dotid_pcnt*ri.Populated_dotid_pcnt *   0.00 / 10000 + le.Populated_dotscore_pcnt*ri.Populated_dotscore_pcnt *   0.00 / 10000 + le.Populated_dotweight_pcnt*ri.Populated_dotweight_pcnt *   0.00 / 10000 + le.Populated_empid_pcnt*ri.Populated_empid_pcnt *   0.00 / 10000 + le.Populated_empscore_pcnt*ri.Populated_empscore_pcnt *   0.00 / 10000 + le.Populated_empweight_pcnt*ri.Populated_empweight_pcnt *   0.00 / 10000 + le.Populated_powid_pcnt*ri.Populated_powid_pcnt *   0.00 / 10000 + le.Populated_powscore_pcnt*ri.Populated_powscore_pcnt *   0.00 / 10000 + le.Populated_powweight_pcnt*ri.Populated_powweight_pcnt *   0.00 / 10000 + le.Populated_proxid_pcnt*ri.Populated_proxid_pcnt *   0.00 / 10000 + le.Populated_proxscore_pcnt*ri.Populated_proxscore_pcnt *   0.00 / 10000 + le.Populated_proxweight_pcnt*ri.Populated_proxweight_pcnt *   0.00 / 10000 + le.Populated_selescore_pcnt*ri.Populated_selescore_pcnt *   0.00 / 10000 + le.Populated_seleweight_pcnt*ri.Populated_seleweight_pcnt *   0.00 / 10000 + le.Populated_orgid_pcnt*ri.Populated_orgid_pcnt *   0.00 / 10000 + le.Populated_orgscore_pcnt*ri.Populated_orgscore_pcnt *   0.00 / 10000 + le.Populated_orgweight_pcnt*ri.Populated_orgweight_pcnt *   0.00 / 10000 + le.Populated_ultid_pcnt*ri.Populated_ultid_pcnt *   0.00 / 10000 + le.Populated_ultscore_pcnt*ri.Populated_ultscore_pcnt *   0.00 / 10000 + le.Populated_ultweight_pcnt*ri.Populated_ultweight_pcnt *   0.00 / 10000 + le.Populated_record_type_pcnt*ri.Populated_record_type_pcnt *   0.00 / 10000 + le.Populated_EFX_ID_pcnt*ri.Populated_EFX_ID_pcnt *   0.00 / 10000 + le.Populated_EFX_NAME_pcnt*ri.Populated_EFX_NAME_pcnt *   0.00 / 10000 + le.Populated_EFX_LEGAL_NAME_pcnt*ri.Populated_EFX_LEGAL_NAME_pcnt *   0.00 / 10000 + le.Populated_EFX_ADDRESS_pcnt*ri.Populated_EFX_ADDRESS_pcnt *   0.00 / 10000 + le.Populated_EFX_CITY_pcnt*ri.Populated_EFX_CITY_pcnt *   0.00 / 10000 + le.Populated_EFX_STATE_pcnt*ri.Populated_EFX_STATE_pcnt *   0.00 / 10000 + le.Populated_EFX_STATEC_pcnt*ri.Populated_EFX_STATEC_pcnt *   0.00 / 10000 + le.Populated_EFX_ZIPCODE_pcnt*ri.Populated_EFX_ZIPCODE_pcnt *   0.00 / 10000 + le.Populated_EFX_ZIP4_pcnt*ri.Populated_EFX_ZIP4_pcnt *   0.00 / 10000 + le.Populated_EFX_LAT_pcnt*ri.Populated_EFX_LAT_pcnt *   0.00 / 10000 + le.Populated_EFX_LON_pcnt*ri.Populated_EFX_LON_pcnt *   0.00 / 10000 + le.Populated_EFX_GEOPREC_pcnt*ri.Populated_EFX_GEOPREC_pcnt *   0.00 / 10000 + le.Populated_EFX_REGION_pcnt*ri.Populated_EFX_REGION_pcnt *   0.00 / 10000 + le.Populated_EFX_CTRYISOCD_pcnt*ri.Populated_EFX_CTRYISOCD_pcnt *   0.00 / 10000 + le.Populated_EFX_CTRYNUM_pcnt*ri.Populated_EFX_CTRYNUM_pcnt *   0.00 / 10000 + le.Populated_EFX_CTRYNAME_pcnt*ri.Populated_EFX_CTRYNAME_pcnt *   0.00 / 10000 + le.Populated_EFX_COUNTYNM_pcnt*ri.Populated_EFX_COUNTYNM_pcnt *   0.00 / 10000 + le.Populated_EFX_COUNTY_pcnt*ri.Populated_EFX_COUNTY_pcnt *   0.00 / 10000 + le.Populated_EFX_CMSA_pcnt*ri.Populated_EFX_CMSA_pcnt *   0.00 / 10000 + le.Populated_EFX_CMSADESC_pcnt*ri.Populated_EFX_CMSADESC_pcnt *   0.00 / 10000 + le.Populated_EFX_SOHO_pcnt*ri.Populated_EFX_SOHO_pcnt *   0.00 / 10000 + le.Populated_EFX_BIZ_pcnt*ri.Populated_EFX_BIZ_pcnt *   0.00 / 10000 + le.Populated_EFX_RES_pcnt*ri.Populated_EFX_RES_pcnt *   0.00 / 10000 + le.Populated_EFX_CMRA_pcnt*ri.Populated_EFX_CMRA_pcnt *   0.00 / 10000 + le.Populated_EFX_CONGRESS_pcnt*ri.Populated_EFX_CONGRESS_pcnt *   0.00 / 10000 + le.Populated_EFX_SECADR_pcnt*ri.Populated_EFX_SECADR_pcnt *   0.00 / 10000 + le.Populated_EFX_SECCTY_pcnt*ri.Populated_EFX_SECCTY_pcnt *   0.00 / 10000 + le.Populated_EFX_SECSTAT_pcnt*ri.Populated_EFX_SECSTAT_pcnt *   0.00 / 10000 + le.Populated_EFX_STATEC2_pcnt*ri.Populated_EFX_STATEC2_pcnt *   0.00 / 10000 + le.Populated_EFX_SECZIP_pcnt*ri.Populated_EFX_SECZIP_pcnt *   0.00 / 10000 + le.Populated_EFX_SECZIP4_pcnt*ri.Populated_EFX_SECZIP4_pcnt *   0.00 / 10000 + le.Populated_EFX_SECLAT_pcnt*ri.Populated_EFX_SECLAT_pcnt *   0.00 / 10000 + le.Populated_EFX_SECLON_pcnt*ri.Populated_EFX_SECLON_pcnt *   0.00 / 10000 + le.Populated_EFX_SECGEOPREC_pcnt*ri.Populated_EFX_SECGEOPREC_pcnt *   0.00 / 10000 + le.Populated_EFX_SECREGION_pcnt*ri.Populated_EFX_SECREGION_pcnt *   0.00 / 10000 + le.Populated_EFX_SECCTRYISOCD_pcnt*ri.Populated_EFX_SECCTRYISOCD_pcnt *   0.00 / 10000 + le.Populated_EFX_SECCTRYNUM_pcnt*ri.Populated_EFX_SECCTRYNUM_pcnt *   0.00 / 10000 + le.Populated_EFX_SECCTRYNAME_pcnt*ri.Populated_EFX_SECCTRYNAME_pcnt *   0.00 / 10000 + le.Populated_EFX_CTRYTELCD_pcnt*ri.Populated_EFX_CTRYTELCD_pcnt *   0.00 / 10000 + le.Populated_EFX_PHONE_pcnt*ri.Populated_EFX_PHONE_pcnt *   0.00 / 10000 + le.Populated_EFX_FAXPHONE_pcnt*ri.Populated_EFX_FAXPHONE_pcnt *   0.00 / 10000 + le.Populated_EFX_BUSSTAT_pcnt*ri.Populated_EFX_BUSSTAT_pcnt *   0.00 / 10000 + le.Populated_EFX_BUSSTATCD_pcnt*ri.Populated_EFX_BUSSTATCD_pcnt *   0.00 / 10000 + le.Populated_EFX_WEB_pcnt*ri.Populated_EFX_WEB_pcnt *   0.00 / 10000 + le.Populated_EFX_YREST_pcnt*ri.Populated_EFX_YREST_pcnt *   0.00 / 10000 + le.Populated_EFX_CORPEMPCNT_pcnt*ri.Populated_EFX_CORPEMPCNT_pcnt *   0.00 / 10000 + le.Populated_EFX_LOCEMPCNT_pcnt*ri.Populated_EFX_LOCEMPCNT_pcnt *   0.00 / 10000 + le.Populated_EFX_CORPEMPCD_pcnt*ri.Populated_EFX_CORPEMPCD_pcnt *   0.00 / 10000 + le.Populated_EFX_LOCEMPCD_pcnt*ri.Populated_EFX_LOCEMPCD_pcnt *   0.00 / 10000 + le.Populated_EFX_CORPAMOUNT_pcnt*ri.Populated_EFX_CORPAMOUNT_pcnt *   0.00 / 10000 + le.Populated_EFX_CORPAMOUNTCD_pcnt*ri.Populated_EFX_CORPAMOUNTCD_pcnt *   0.00 / 10000 + le.Populated_EFX_CORPAMOUNTTP_pcnt*ri.Populated_EFX_CORPAMOUNTTP_pcnt *   0.00 / 10000 + le.Populated_EFX_CORPAMOUNTPREC_pcnt*ri.Populated_EFX_CORPAMOUNTPREC_pcnt *   0.00 / 10000 + le.Populated_EFX_LOCAMOUNT_pcnt*ri.Populated_EFX_LOCAMOUNT_pcnt *   0.00 / 10000 + le.Populated_EFX_LOCAMOUNTCD_pcnt*ri.Populated_EFX_LOCAMOUNTCD_pcnt *   0.00 / 10000 + le.Populated_EFX_LOCAMOUNTTP_pcnt*ri.Populated_EFX_LOCAMOUNTTP_pcnt *   0.00 / 10000 + le.Populated_EFX_LOCAMOUNTPREC_pcnt*ri.Populated_EFX_LOCAMOUNTPREC_pcnt *   0.00 / 10000 + le.Populated_EFX_PUBLIC_pcnt*ri.Populated_EFX_PUBLIC_pcnt *   0.00 / 10000 + le.Populated_EFX_STKEXC_pcnt*ri.Populated_EFX_STKEXC_pcnt *   0.00 / 10000 + le.Populated_EFX_TCKSYM_pcnt*ri.Populated_EFX_TCKSYM_pcnt *   0.00 / 10000 + le.Populated_EFX_PRIMSIC_pcnt*ri.Populated_EFX_PRIMSIC_pcnt *   0.00 / 10000 + le.Populated_EFX_SECSIC1_pcnt*ri.Populated_EFX_SECSIC1_pcnt *   0.00 / 10000 + le.Populated_EFX_SECSIC2_pcnt*ri.Populated_EFX_SECSIC2_pcnt *   0.00 / 10000 + le.Populated_EFX_SECSIC3_pcnt*ri.Populated_EFX_SECSIC3_pcnt *   0.00 / 10000 + le.Populated_EFX_SECSIC4_pcnt*ri.Populated_EFX_SECSIC4_pcnt *   0.00 / 10000 + le.Populated_EFX_PRIMSICDESC_pcnt*ri.Populated_EFX_PRIMSICDESC_pcnt *   0.00 / 10000 + le.Populated_EFX_SECSICDESC1_pcnt*ri.Populated_EFX_SECSICDESC1_pcnt *   0.00 / 10000 + le.Populated_EFX_SECSICDESC2_pcnt*ri.Populated_EFX_SECSICDESC2_pcnt *   0.00 / 10000 + le.Populated_EFX_SECSICDESC3_pcnt*ri.Populated_EFX_SECSICDESC3_pcnt *   0.00 / 10000 + le.Populated_EFX_SECSICDESC4_pcnt*ri.Populated_EFX_SECSICDESC4_pcnt *   0.00 / 10000 + le.Populated_EFX_PRIMNAICSCODE_pcnt*ri.Populated_EFX_PRIMNAICSCODE_pcnt *   0.00 / 10000 + le.Populated_EFX_SECNAICS1_pcnt*ri.Populated_EFX_SECNAICS1_pcnt *   0.00 / 10000 + le.Populated_EFX_SECNAICS2_pcnt*ri.Populated_EFX_SECNAICS2_pcnt *   0.00 / 10000 + le.Populated_EFX_SECNAICS3_pcnt*ri.Populated_EFX_SECNAICS3_pcnt *   0.00 / 10000 + le.Populated_EFX_SECNAICS4_pcnt*ri.Populated_EFX_SECNAICS4_pcnt *   0.00 / 10000 + le.Populated_EFX_PRIMNAICSDESC_pcnt*ri.Populated_EFX_PRIMNAICSDESC_pcnt *   0.00 / 10000 + le.Populated_EFX_SECNAICSDESC1_pcnt*ri.Populated_EFX_SECNAICSDESC1_pcnt *   0.00 / 10000 + le.Populated_EFX_SECNAICSDESC2_pcnt*ri.Populated_EFX_SECNAICSDESC2_pcnt *   0.00 / 10000 + le.Populated_EFX_SECNAICSDESC3_pcnt*ri.Populated_EFX_SECNAICSDESC3_pcnt *   0.00 / 10000 + le.Populated_EFX_SECNAICSDESC4_pcnt*ri.Populated_EFX_SECNAICSDESC4_pcnt *   0.00 / 10000 + le.Populated_EFX_DEAD_pcnt*ri.Populated_EFX_DEAD_pcnt *   0.00 / 10000 + le.Populated_EFX_DEADDT_pcnt*ri.Populated_EFX_DEADDT_pcnt *   0.00 / 10000 + le.Populated_EFX_MRKT_TELEVER_pcnt*ri.Populated_EFX_MRKT_TELEVER_pcnt *   0.00 / 10000 + le.Populated_EFX_MRKT_TELESCORE_pcnt*ri.Populated_EFX_MRKT_TELESCORE_pcnt *   0.00 / 10000 + le.Populated_EFX_MRKT_TOTALSCORE_pcnt*ri.Populated_EFX_MRKT_TOTALSCORE_pcnt *   0.00 / 10000 + le.Populated_EFX_MRKT_TOTALIND_pcnt*ri.Populated_EFX_MRKT_TOTALIND_pcnt *   0.00 / 10000 + le.Populated_EFX_MRKT_VACANT_pcnt*ri.Populated_EFX_MRKT_VACANT_pcnt *   0.00 / 10000 + le.Populated_EFX_MRKT_SEASONAL_pcnt*ri.Populated_EFX_MRKT_SEASONAL_pcnt *   0.00 / 10000 + le.Populated_EFX_MBE_pcnt*ri.Populated_EFX_MBE_pcnt *   0.00 / 10000 + le.Populated_EFX_WBE_pcnt*ri.Populated_EFX_WBE_pcnt *   0.00 / 10000 + le.Populated_EFX_MWBE_pcnt*ri.Populated_EFX_MWBE_pcnt *   0.00 / 10000 + le.Populated_EFX_SDB_pcnt*ri.Populated_EFX_SDB_pcnt *   0.00 / 10000 + le.Populated_EFX_HUBZONE_pcnt*ri.Populated_EFX_HUBZONE_pcnt *   0.00 / 10000 + le.Populated_EFX_DBE_pcnt*ri.Populated_EFX_DBE_pcnt *   0.00 / 10000 + le.Populated_EFX_VET_pcnt*ri.Populated_EFX_VET_pcnt *   0.00 / 10000 + le.Populated_EFX_DVET_pcnt*ri.Populated_EFX_DVET_pcnt *   0.00 / 10000 + le.Populated_EFX_8a_pcnt*ri.Populated_EFX_8a_pcnt *   0.00 / 10000 + le.Populated_EFX_8aEXPDT_pcnt*ri.Populated_EFX_8aEXPDT_pcnt *   0.00 / 10000 + le.Populated_EFX_DIS_pcnt*ri.Populated_EFX_DIS_pcnt *   0.00 / 10000 + le.Populated_EFX_SBE_pcnt*ri.Populated_EFX_SBE_pcnt *   0.00 / 10000 + le.Populated_EFX_BUSSIZE_pcnt*ri.Populated_EFX_BUSSIZE_pcnt *   0.00 / 10000 + le.Populated_EFX_LBE_pcnt*ri.Populated_EFX_LBE_pcnt *   0.00 / 10000 + le.Populated_EFX_GOV_pcnt*ri.Populated_EFX_GOV_pcnt *   0.00 / 10000 + le.Populated_EFX_FGOV_pcnt*ri.Populated_EFX_FGOV_pcnt *   0.00 / 10000 + le.Populated_EFX_GOV1057_pcnt*ri.Populated_EFX_GOV1057_pcnt *   0.00 / 10000 + le.Populated_EFX_NONPROFIT_pcnt*ri.Populated_EFX_NONPROFIT_pcnt *   0.00 / 10000 + le.Populated_EFX_MERCTYPE_pcnt*ri.Populated_EFX_MERCTYPE_pcnt *   0.00 / 10000 + le.Populated_EFX_HBCU_pcnt*ri.Populated_EFX_HBCU_pcnt *   0.00 / 10000 + le.Populated_EFX_GAYLESBIAN_pcnt*ri.Populated_EFX_GAYLESBIAN_pcnt *   0.00 / 10000 + le.Populated_EFX_WSBE_pcnt*ri.Populated_EFX_WSBE_pcnt *   0.00 / 10000 + le.Populated_EFX_VSBE_pcnt*ri.Populated_EFX_VSBE_pcnt *   0.00 / 10000 + le.Populated_EFX_DVSBE_pcnt*ri.Populated_EFX_DVSBE_pcnt *   0.00 / 10000 + le.Populated_EFX_MWBESTATUS_pcnt*ri.Populated_EFX_MWBESTATUS_pcnt *   0.00 / 10000 + le.Populated_EFX_NMSDC_pcnt*ri.Populated_EFX_NMSDC_pcnt *   0.00 / 10000 + le.Populated_EFX_WBENC_pcnt*ri.Populated_EFX_WBENC_pcnt *   0.00 / 10000 + le.Populated_EFX_CA_PUC_pcnt*ri.Populated_EFX_CA_PUC_pcnt *   0.00 / 10000 + le.Populated_EFX_TX_HUB_pcnt*ri.Populated_EFX_TX_HUB_pcnt *   0.00 / 10000 + le.Populated_EFX_TX_HUBCERTNUM_pcnt*ri.Populated_EFX_TX_HUBCERTNUM_pcnt *   0.00 / 10000 + le.Populated_EFX_GSAX_pcnt*ri.Populated_EFX_GSAX_pcnt *   0.00 / 10000 + le.Populated_EFX_CALTRANS_pcnt*ri.Populated_EFX_CALTRANS_pcnt *   0.00 / 10000 + le.Populated_EFX_EDU_pcnt*ri.Populated_EFX_EDU_pcnt *   0.00 / 10000 + le.Populated_EFX_MI_pcnt*ri.Populated_EFX_MI_pcnt *   0.00 / 10000 + le.Populated_EFX_ANC_pcnt*ri.Populated_EFX_ANC_pcnt *   0.00 / 10000 + le.Populated_AT_CERT1_pcnt*ri.Populated_AT_CERT1_pcnt *   0.00 / 10000 + le.Populated_AT_CERT2_pcnt*ri.Populated_AT_CERT2_pcnt *   0.00 / 10000 + le.Populated_AT_CERT3_pcnt*ri.Populated_AT_CERT3_pcnt *   0.00 / 10000 + le.Populated_AT_CERT4_pcnt*ri.Populated_AT_CERT4_pcnt *   0.00 / 10000 + le.Populated_AT_CERT5_pcnt*ri.Populated_AT_CERT5_pcnt *   0.00 / 10000 + le.Populated_AT_CERT6_pcnt*ri.Populated_AT_CERT6_pcnt *   0.00 / 10000 + le.Populated_AT_CERT7_pcnt*ri.Populated_AT_CERT7_pcnt *   0.00 / 10000 + le.Populated_AT_CERT8_pcnt*ri.Populated_AT_CERT8_pcnt *   0.00 / 10000 + le.Populated_AT_CERT9_pcnt*ri.Populated_AT_CERT9_pcnt *   0.00 / 10000 + le.Populated_AT_CERT10_pcnt*ri.Populated_AT_CERT10_pcnt *   0.00 / 10000 + le.Populated_AT_CERTDESC1_pcnt*ri.Populated_AT_CERTDESC1_pcnt *   0.00 / 10000 + le.Populated_AT_CERTDESC2_pcnt*ri.Populated_AT_CERTDESC2_pcnt *   0.00 / 10000 + le.Populated_AT_CERTDESC3_pcnt*ri.Populated_AT_CERTDESC3_pcnt *   0.00 / 10000 + le.Populated_AT_CERTDESC4_pcnt*ri.Populated_AT_CERTDESC4_pcnt *   0.00 / 10000 + le.Populated_AT_CERTDESC5_pcnt*ri.Populated_AT_CERTDESC5_pcnt *   0.00 / 10000 + le.Populated_AT_CERTDESC6_pcnt*ri.Populated_AT_CERTDESC6_pcnt *   0.00 / 10000 + le.Populated_AT_CERTDESC7_pcnt*ri.Populated_AT_CERTDESC7_pcnt *   0.00 / 10000 + le.Populated_AT_CERTDESC8_pcnt*ri.Populated_AT_CERTDESC8_pcnt *   0.00 / 10000 + le.Populated_AT_CERTDESC9_pcnt*ri.Populated_AT_CERTDESC9_pcnt *   0.00 / 10000 + le.Populated_AT_CERTDESC10_pcnt*ri.Populated_AT_CERTDESC10_pcnt *   0.00 / 10000 + le.Populated_AT_CERTSRC1_pcnt*ri.Populated_AT_CERTSRC1_pcnt *   0.00 / 10000 + le.Populated_AT_CERTSRC2_pcnt*ri.Populated_AT_CERTSRC2_pcnt *   0.00 / 10000 + le.Populated_AT_CERTSRC3_pcnt*ri.Populated_AT_CERTSRC3_pcnt *   0.00 / 10000 + le.Populated_AT_CERTSRC4_pcnt*ri.Populated_AT_CERTSRC4_pcnt *   0.00 / 10000 + le.Populated_AT_CERTSRC5_pcnt*ri.Populated_AT_CERTSRC5_pcnt *   0.00 / 10000 + le.Populated_AT_CERTSRC6_pcnt*ri.Populated_AT_CERTSRC6_pcnt *   0.00 / 10000 + le.Populated_AT_CERTSRC7_pcnt*ri.Populated_AT_CERTSRC7_pcnt *   0.00 / 10000 + le.Populated_AT_CERTSRC8_pcnt*ri.Populated_AT_CERTSRC8_pcnt *   0.00 / 10000 + le.Populated_AT_CERTSRC9_pcnt*ri.Populated_AT_CERTSRC9_pcnt *   0.00 / 10000 + le.Populated_AT_CERTSRC10_pcnt*ri.Populated_AT_CERTSRC10_pcnt *   0.00 / 10000 + le.Populated_AT_CERTLEV1_pcnt*ri.Populated_AT_CERTLEV1_pcnt *   0.00 / 10000 + le.Populated_AT_CERTLEV2_pcnt*ri.Populated_AT_CERTLEV2_pcnt *   0.00 / 10000 + le.Populated_AT_CERTLEV3_pcnt*ri.Populated_AT_CERTLEV3_pcnt *   0.00 / 10000 + le.Populated_AT_CERTLEV4_pcnt*ri.Populated_AT_CERTLEV4_pcnt *   0.00 / 10000 + le.Populated_AT_CERTLEV5_pcnt*ri.Populated_AT_CERTLEV5_pcnt *   0.00 / 10000 + le.Populated_AT_CERTLEV6_pcnt*ri.Populated_AT_CERTLEV6_pcnt *   0.00 / 10000 + le.Populated_AT_CERTLEV7_pcnt*ri.Populated_AT_CERTLEV7_pcnt *   0.00 / 10000 + le.Populated_AT_CERTLEV8_pcnt*ri.Populated_AT_CERTLEV8_pcnt *   0.00 / 10000 + le.Populated_AT_CERTLEV9_pcnt*ri.Populated_AT_CERTLEV9_pcnt *   0.00 / 10000 + le.Populated_AT_CERTLEV10_pcnt*ri.Populated_AT_CERTLEV10_pcnt *   0.00 / 10000 + le.Populated_AT_CERTNUM1_pcnt*ri.Populated_AT_CERTNUM1_pcnt *   0.00 / 10000 + le.Populated_AT_CERTNUM2_pcnt*ri.Populated_AT_CERTNUM2_pcnt *   0.00 / 10000 + le.Populated_AT_CERTNUM3_pcnt*ri.Populated_AT_CERTNUM3_pcnt *   0.00 / 10000 + le.Populated_AT_CERTNUM4_pcnt*ri.Populated_AT_CERTNUM4_pcnt *   0.00 / 10000 + le.Populated_AT_CERTNUM5_pcnt*ri.Populated_AT_CERTNUM5_pcnt *   0.00 / 10000 + le.Populated_AT_CERTNUM6_pcnt*ri.Populated_AT_CERTNUM6_pcnt *   0.00 / 10000 + le.Populated_AT_CERTNUM7_pcnt*ri.Populated_AT_CERTNUM7_pcnt *   0.00 / 10000 + le.Populated_AT_CERTNUM8_pcnt*ri.Populated_AT_CERTNUM8_pcnt *   0.00 / 10000 + le.Populated_AT_CERTNUM9_pcnt*ri.Populated_AT_CERTNUM9_pcnt *   0.00 / 10000 + le.Populated_AT_CERTNUM10_pcnt*ri.Populated_AT_CERTNUM10_pcnt *   0.00 / 10000 + le.Populated_AT_CERTEXP1_pcnt*ri.Populated_AT_CERTEXP1_pcnt *   0.00 / 10000 + le.Populated_AT_CERTEXP2_pcnt*ri.Populated_AT_CERTEXP2_pcnt *   0.00 / 10000 + le.Populated_AT_CERTEXP3_pcnt*ri.Populated_AT_CERTEXP3_pcnt *   0.00 / 10000 + le.Populated_AT_CERTEXP4_pcnt*ri.Populated_AT_CERTEXP4_pcnt *   0.00 / 10000 + le.Populated_AT_CERTEXP5_pcnt*ri.Populated_AT_CERTEXP5_pcnt *   0.00 / 10000 + le.Populated_AT_CERTEXP6_pcnt*ri.Populated_AT_CERTEXP6_pcnt *   0.00 / 10000 + le.Populated_AT_CERTEXP7_pcnt*ri.Populated_AT_CERTEXP7_pcnt *   0.00 / 10000 + le.Populated_AT_CERTEXP8_pcnt*ri.Populated_AT_CERTEXP8_pcnt *   0.00 / 10000 + le.Populated_AT_CERTEXP9_pcnt*ri.Populated_AT_CERTEXP9_pcnt *   0.00 / 10000 + le.Populated_AT_CERTEXP10_pcnt*ri.Populated_AT_CERTEXP10_pcnt *   0.00 / 10000 + le.Populated_EFX_EXTRACT_DATE_pcnt*ri.Populated_EFX_EXTRACT_DATE_pcnt *   0.00 / 10000 + le.Populated_EFX_MERCHANT_ID_pcnt*ri.Populated_EFX_MERCHANT_ID_pcnt *   0.00 / 10000 + le.Populated_EFX_PROJECT_ID_pcnt*ri.Populated_EFX_PROJECT_ID_pcnt *   0.00 / 10000 + le.Populated_EFX_FOREIGN_pcnt*ri.Populated_EFX_FOREIGN_pcnt *   0.00 / 10000 + le.Populated_Record_Update_Refresh_Date_pcnt*ri.Populated_Record_Update_Refresh_Date_pcnt *   0.00 / 10000 + le.Populated_EFX_DATE_CREATED_pcnt*ri.Populated_EFX_DATE_CREATED_pcnt *   0.00 / 10000 + le.Populated_normCompany_Name_pcnt*ri.Populated_normCompany_Name_pcnt *   0.00 / 10000 + le.Populated_normCompany_Type_pcnt*ri.Populated_normCompany_Type_pcnt *   0.00 / 10000 + le.Populated_Norm_Geo_Precision_pcnt*ri.Populated_Norm_Geo_Precision_pcnt *   0.00 / 10000 + le.Populated_Exploded_Desc_Corporate_Amount_Precision_pcnt*ri.Populated_Exploded_Desc_Corporate_Amount_Precision_pcnt *   0.00 / 10000 + le.Populated_Exploded_Desc_Location_Amount_Precision_pcnt*ri.Populated_Exploded_Desc_Location_Amount_Precision_pcnt *   0.00 / 10000 + le.Populated_Exploded_Desc_Public_Co_Indicator_pcnt*ri.Populated_Exploded_Desc_Public_Co_Indicator_pcnt *   0.00 / 10000 + le.Populated_Exploded_Desc_Stock_Exchange_pcnt*ri.Populated_Exploded_Desc_Stock_Exchange_pcnt *   0.00 / 10000 + le.Populated_Exploded_Desc_Telemarketablity_Score_pcnt*ri.Populated_Exploded_Desc_Telemarketablity_Score_pcnt *   0.00 / 10000 + le.Populated_Exploded_Desc_Telemarketablity_Total_Indicator_pcnt*ri.Populated_Exploded_Desc_Telemarketablity_Total_Indicator_pcnt *   0.00 / 10000 + le.Populated_Exploded_Desc_Telemarketablity_Total_Score_pcnt*ri.Populated_Exploded_Desc_Telemarketablity_Total_Score_pcnt *   0.00 / 10000 + le.Populated_Exploded_Desc_Government1057_Entity_pcnt*ri.Populated_Exploded_Desc_Government1057_Entity_pcnt *   0.00 / 10000 + le.Populated_Exploded_Desc_Merchant_Type_pcnt*ri.Populated_Exploded_Desc_Merchant_Type_pcnt *   0.00 / 10000 + le.Populated_Exploded_Desc_Busstatcd_pcnt*ri.Populated_Exploded_Desc_Busstatcd_pcnt *   0.00 / 10000 + le.Populated_Exploded_Desc_CMSA_pcnt*ri.Populated_Exploded_Desc_CMSA_pcnt *   0.00 / 10000 + le.Populated_Exploded_Desc_Corpamountcd_pcnt*ri.Populated_Exploded_Desc_Corpamountcd_pcnt *   0.00 / 10000 + le.Populated_Exploded_Desc_Corpamountprec_pcnt*ri.Populated_Exploded_Desc_Corpamountprec_pcnt *   0.00 / 10000 + le.Populated_Exploded_Desc_Corpamounttp_pcnt*ri.Populated_Exploded_Desc_Corpamounttp_pcnt *   0.00 / 10000 + le.Populated_Exploded_Desc_Corpempcd_pcnt*ri.Populated_Exploded_Desc_Corpempcd_pcnt *   0.00 / 10000 + le.Populated_Exploded_Desc_Ctrytelcd_pcnt*ri.Populated_Exploded_Desc_Ctrytelcd_pcnt *   0.00 / 10000 + le.Populated_NormAddress_Type_pcnt*ri.Populated_NormAddress_Type_pcnt *   0.00 / 10000 + le.Populated_Norm_Address_pcnt*ri.Populated_Norm_Address_pcnt *   0.00 / 10000 + le.Populated_Norm_City_pcnt*ri.Populated_Norm_City_pcnt *   0.00 / 10000 + le.Populated_Norm_State_pcnt*ri.Populated_Norm_State_pcnt *   0.00 / 10000 + le.Populated_Norm_StateC2_pcnt*ri.Populated_Norm_StateC2_pcnt *   0.00 / 10000 + le.Populated_Norm_Zip_pcnt*ri.Populated_Norm_Zip_pcnt *   0.00 / 10000 + le.Populated_Norm_Zip4_pcnt*ri.Populated_Norm_Zip4_pcnt *   0.00 / 10000 + le.Populated_Norm_Lat_pcnt*ri.Populated_Norm_Lat_pcnt *   0.00 / 10000 + le.Populated_Norm_Lon_pcnt*ri.Populated_Norm_Lon_pcnt *   0.00 / 10000 + le.Populated_Norm_Geoprec_pcnt*ri.Populated_Norm_Geoprec_pcnt *   0.00 / 10000 + le.Populated_Norm_Region_pcnt*ri.Populated_Norm_Region_pcnt *   0.00 / 10000 + le.Populated_Norm_Ctryisocd_pcnt*ri.Populated_Norm_Ctryisocd_pcnt *   0.00 / 10000 + le.Populated_Norm_Ctrynum_pcnt*ri.Populated_Norm_Ctrynum_pcnt *   0.00 / 10000 + le.Populated_Norm_Ctryname_pcnt*ri.Populated_Norm_Ctryname_pcnt *   0.00 / 10000 + le.Populated_clean_company_name_pcnt*ri.Populated_clean_company_name_pcnt *   0.00 / 10000 + le.Populated_clean_phone_pcnt*ri.Populated_clean_phone_pcnt *   0.00 / 10000 + le.Populated_clean_secondary_phone_pcnt*ri.Populated_clean_secondary_phone_pcnt *   0.00 / 10000 + le.Populated_prim_range_pcnt*ri.Populated_prim_range_pcnt *   0.00 / 10000 + le.Populated_predir_pcnt*ri.Populated_predir_pcnt *   0.00 / 10000 + le.Populated_prim_name_pcnt*ri.Populated_prim_name_pcnt *   0.00 / 10000 + le.Populated_addr_suffix_pcnt*ri.Populated_addr_suffix_pcnt *   0.00 / 10000 + le.Populated_postdir_pcnt*ri.Populated_postdir_pcnt *   0.00 / 10000 + le.Populated_unit_desig_pcnt*ri.Populated_unit_desig_pcnt *   0.00 / 10000 + le.Populated_sec_range_pcnt*ri.Populated_sec_range_pcnt *   0.00 / 10000 + le.Populated_p_city_name_pcnt*ri.Populated_p_city_name_pcnt *   0.00 / 10000 + le.Populated_v_city_name_pcnt*ri.Populated_v_city_name_pcnt *   0.00 / 10000 + le.Populated_st_pcnt*ri.Populated_st_pcnt *   0.00 / 10000 + le.Populated_cart_pcnt*ri.Populated_cart_pcnt *   0.00 / 10000 + le.Populated_cr_sort_sz_pcnt*ri.Populated_cr_sort_sz_pcnt *   0.00 / 10000;
  END;
EXPORT CrossLinkingPotential := JOIN(SourceCounts,SourceCounts,LEFT.Source<>RIGHT.Source,T(LEFT,RIGHT),ALL);
summary0 := Summary('Summary');
invRec := RECORD
  UNSIGNED  FldNo;
  SALT37.StrType FieldName;
  UNSIGNED NumberOfRecords;
  REAL8  populated_pcnt;
  UNSIGNED  maxlength;
  REAL8  avelength;
END;
invRec invert(summary0 le, INTEGER C) := TRANSFORM
  SELF.FldNo := C;
  SELF.NumberOfRecords := le.NumberOfRecords;
  SELF.FieldName := CHOOSE(C,'dt_first_seen','dt_last_seen','dt_vendor_first_reported','dt_vendor_last_reported','dt_effective_first','dt_effective_last','process_date','dotid','dotscore','dotweight','empid','empscore','empweight','powid','powscore','powweight','proxid','proxscore','proxweight','selescore','seleweight','orgid','orgscore','orgweight','ultid','ultscore','ultweight','record_type','EFX_ID','EFX_NAME','EFX_LEGAL_NAME','EFX_ADDRESS','EFX_CITY','EFX_STATE','EFX_STATEC','EFX_ZIPCODE','EFX_ZIP4','EFX_LAT','EFX_LON','EFX_GEOPREC','EFX_REGION','EFX_CTRYISOCD','EFX_CTRYNUM','EFX_CTRYNAME','EFX_COUNTYNM','EFX_COUNTY','EFX_CMSA','EFX_CMSADESC','EFX_SOHO','EFX_BIZ','EFX_RES','EFX_CMRA','EFX_CONGRESS','EFX_SECADR','EFX_SECCTY','EFX_SECSTAT','EFX_STATEC2','EFX_SECZIP','EFX_SECZIP4','EFX_SECLAT','EFX_SECLON','EFX_SECGEOPREC','EFX_SECREGION','EFX_SECCTRYISOCD','EFX_SECCTRYNUM','EFX_SECCTRYNAME','EFX_CTRYTELCD','EFX_PHONE','EFX_FAXPHONE','EFX_BUSSTAT','EFX_BUSSTATCD','EFX_WEB','EFX_YREST','EFX_CORPEMPCNT','EFX_LOCEMPCNT','EFX_CORPEMPCD','EFX_LOCEMPCD','EFX_CORPAMOUNT','EFX_CORPAMOUNTCD','EFX_CORPAMOUNTTP','EFX_CORPAMOUNTPREC','EFX_LOCAMOUNT','EFX_LOCAMOUNTCD','EFX_LOCAMOUNTTP','EFX_LOCAMOUNTPREC','EFX_PUBLIC','EFX_STKEXC','EFX_TCKSYM','EFX_PRIMSIC','EFX_SECSIC1','EFX_SECSIC2','EFX_SECSIC3','EFX_SECSIC4','EFX_PRIMSICDESC','EFX_SECSICDESC1','EFX_SECSICDESC2','EFX_SECSICDESC3','EFX_SECSICDESC4','EFX_PRIMNAICSCODE','EFX_SECNAICS1','EFX_SECNAICS2','EFX_SECNAICS3','EFX_SECNAICS4','EFX_PRIMNAICSDESC','EFX_SECNAICSDESC1','EFX_SECNAICSDESC2','EFX_SECNAICSDESC3','EFX_SECNAICSDESC4','EFX_DEAD','EFX_DEADDT','EFX_MRKT_TELEVER','EFX_MRKT_TELESCORE','EFX_MRKT_TOTALSCORE','EFX_MRKT_TOTALIND','EFX_MRKT_VACANT','EFX_MRKT_SEASONAL','EFX_MBE','EFX_WBE','EFX_MWBE','EFX_SDB','EFX_HUBZONE','EFX_DBE','EFX_VET','EFX_DVET','EFX_8a','EFX_8aEXPDT','EFX_DIS','EFX_SBE','EFX_BUSSIZE','EFX_LBE','EFX_GOV','EFX_FGOV','EFX_GOV1057','EFX_NONPROFIT','EFX_MERCTYPE','EFX_HBCU','EFX_GAYLESBIAN','EFX_WSBE','EFX_VSBE','EFX_DVSBE','EFX_MWBESTATUS','EFX_NMSDC','EFX_WBENC','EFX_CA_PUC','EFX_TX_HUB','EFX_TX_HUBCERTNUM','EFX_GSAX','EFX_CALTRANS','EFX_EDU','EFX_MI','EFX_ANC','AT_CERT1','AT_CERT2','AT_CERT3','AT_CERT4','AT_CERT5','AT_CERT6','AT_CERT7','AT_CERT8','AT_CERT9','AT_CERT10','AT_CERTDESC1','AT_CERTDESC2','AT_CERTDESC3','AT_CERTDESC4','AT_CERTDESC5','AT_CERTDESC6','AT_CERTDESC7','AT_CERTDESC8','AT_CERTDESC9','AT_CERTDESC10','AT_CERTSRC1','AT_CERTSRC2','AT_CERTSRC3','AT_CERTSRC4','AT_CERTSRC5','AT_CERTSRC6','AT_CERTSRC7','AT_CERTSRC8','AT_CERTSRC9','AT_CERTSRC10','AT_CERTLEV1','AT_CERTLEV2','AT_CERTLEV3','AT_CERTLEV4','AT_CERTLEV5','AT_CERTLEV6','AT_CERTLEV7','AT_CERTLEV8','AT_CERTLEV9','AT_CERTLEV10','AT_CERTNUM1','AT_CERTNUM2','AT_CERTNUM3','AT_CERTNUM4','AT_CERTNUM5','AT_CERTNUM6','AT_CERTNUM7','AT_CERTNUM8','AT_CERTNUM9','AT_CERTNUM10','AT_CERTEXP1','AT_CERTEXP2','AT_CERTEXP3','AT_CERTEXP4','AT_CERTEXP5','AT_CERTEXP6','AT_CERTEXP7','AT_CERTEXP8','AT_CERTEXP9','AT_CERTEXP10','EFX_EXTRACT_DATE','EFX_MERCHANT_ID','EFX_PROJECT_ID','EFX_FOREIGN','Record_Update_Refresh_Date','EFX_DATE_CREATED','normCompany_Name','normCompany_Type','Norm_Geo_Precision','Exploded_Desc_Corporate_Amount_Precision','Exploded_Desc_Location_Amount_Precision','Exploded_Desc_Public_Co_Indicator','Exploded_Desc_Stock_Exchange','Exploded_Desc_Telemarketablity_Score','Exploded_Desc_Telemarketablity_Total_Indicator','Exploded_Desc_Telemarketablity_Total_Score','Exploded_Desc_Government1057_Entity','Exploded_Desc_Merchant_Type','Exploded_Desc_Busstatcd','Exploded_Desc_CMSA','Exploded_Desc_Corpamountcd','Exploded_Desc_Corpamountprec','Exploded_Desc_Corpamounttp','Exploded_Desc_Corpempcd','Exploded_Desc_Ctrytelcd','NormAddress_Type','Norm_Address','Norm_City','Norm_State','Norm_StateC2','Norm_Zip','Norm_Zip4','Norm_Lat','Norm_Lon','Norm_Geoprec','Norm_Region','Norm_Ctryisocd','Norm_Ctrynum','Norm_Ctryname','clean_company_name','clean_phone','clean_secondary_phone','prim_range','predir','prim_name','addr_suffix','postdir','unit_desig','sec_range','p_city_name','v_city_name','st','cart','cr_sort_sz');
  SELF.populated_pcnt := CHOOSE(C,le.populated_dt_first_seen_pcnt,le.populated_dt_last_seen_pcnt,le.populated_dt_vendor_first_reported_pcnt,le.populated_dt_vendor_last_reported_pcnt,le.populated_dt_effective_first_pcnt,le.populated_dt_effective_last_pcnt,le.populated_process_date_pcnt,le.populated_dotid_pcnt,le.populated_dotscore_pcnt,le.populated_dotweight_pcnt,le.populated_empid_pcnt,le.populated_empscore_pcnt,le.populated_empweight_pcnt,le.populated_powid_pcnt,le.populated_powscore_pcnt,le.populated_powweight_pcnt,le.populated_proxid_pcnt,le.populated_proxscore_pcnt,le.populated_proxweight_pcnt,le.populated_selescore_pcnt,le.populated_seleweight_pcnt,le.populated_orgid_pcnt,le.populated_orgscore_pcnt,le.populated_orgweight_pcnt,le.populated_ultid_pcnt,le.populated_ultscore_pcnt,le.populated_ultweight_pcnt,le.populated_record_type_pcnt,le.populated_EFX_ID_pcnt,le.populated_EFX_NAME_pcnt,le.populated_EFX_LEGAL_NAME_pcnt,le.populated_EFX_ADDRESS_pcnt,le.populated_EFX_CITY_pcnt,le.populated_EFX_STATE_pcnt,le.populated_EFX_STATEC_pcnt,le.populated_EFX_ZIPCODE_pcnt,le.populated_EFX_ZIP4_pcnt,le.populated_EFX_LAT_pcnt,le.populated_EFX_LON_pcnt,le.populated_EFX_GEOPREC_pcnt,le.populated_EFX_REGION_pcnt,le.populated_EFX_CTRYISOCD_pcnt,le.populated_EFX_CTRYNUM_pcnt,le.populated_EFX_CTRYNAME_pcnt,le.populated_EFX_COUNTYNM_pcnt,le.populated_EFX_COUNTY_pcnt,le.populated_EFX_CMSA_pcnt,le.populated_EFX_CMSADESC_pcnt,le.populated_EFX_SOHO_pcnt,le.populated_EFX_BIZ_pcnt,le.populated_EFX_RES_pcnt,le.populated_EFX_CMRA_pcnt,le.populated_EFX_CONGRESS_pcnt,le.populated_EFX_SECADR_pcnt,le.populated_EFX_SECCTY_pcnt,le.populated_EFX_SECSTAT_pcnt,le.populated_EFX_STATEC2_pcnt,le.populated_EFX_SECZIP_pcnt,le.populated_EFX_SECZIP4_pcnt,le.populated_EFX_SECLAT_pcnt,le.populated_EFX_SECLON_pcnt,le.populated_EFX_SECGEOPREC_pcnt,le.populated_EFX_SECREGION_pcnt,le.populated_EFX_SECCTRYISOCD_pcnt,le.populated_EFX_SECCTRYNUM_pcnt,le.populated_EFX_SECCTRYNAME_pcnt,le.populated_EFX_CTRYTELCD_pcnt,le.populated_EFX_PHONE_pcnt,le.populated_EFX_FAXPHONE_pcnt,le.populated_EFX_BUSSTAT_pcnt,le.populated_EFX_BUSSTATCD_pcnt,le.populated_EFX_WEB_pcnt,le.populated_EFX_YREST_pcnt,le.populated_EFX_CORPEMPCNT_pcnt,le.populated_EFX_LOCEMPCNT_pcnt,le.populated_EFX_CORPEMPCD_pcnt,le.populated_EFX_LOCEMPCD_pcnt,le.populated_EFX_CORPAMOUNT_pcnt,le.populated_EFX_CORPAMOUNTCD_pcnt,le.populated_EFX_CORPAMOUNTTP_pcnt,le.populated_EFX_CORPAMOUNTPREC_pcnt,le.populated_EFX_LOCAMOUNT_pcnt,le.populated_EFX_LOCAMOUNTCD_pcnt,le.populated_EFX_LOCAMOUNTTP_pcnt,le.populated_EFX_LOCAMOUNTPREC_pcnt,le.populated_EFX_PUBLIC_pcnt,le.populated_EFX_STKEXC_pcnt,le.populated_EFX_TCKSYM_pcnt,le.populated_EFX_PRIMSIC_pcnt,le.populated_EFX_SECSIC1_pcnt,le.populated_EFX_SECSIC2_pcnt,le.populated_EFX_SECSIC3_pcnt,le.populated_EFX_SECSIC4_pcnt,le.populated_EFX_PRIMSICDESC_pcnt,le.populated_EFX_SECSICDESC1_pcnt,le.populated_EFX_SECSICDESC2_pcnt,le.populated_EFX_SECSICDESC3_pcnt,le.populated_EFX_SECSICDESC4_pcnt,le.populated_EFX_PRIMNAICSCODE_pcnt,le.populated_EFX_SECNAICS1_pcnt,le.populated_EFX_SECNAICS2_pcnt,le.populated_EFX_SECNAICS3_pcnt,le.populated_EFX_SECNAICS4_pcnt,le.populated_EFX_PRIMNAICSDESC_pcnt,le.populated_EFX_SECNAICSDESC1_pcnt,le.populated_EFX_SECNAICSDESC2_pcnt,le.populated_EFX_SECNAICSDESC3_pcnt,le.populated_EFX_SECNAICSDESC4_pcnt,le.populated_EFX_DEAD_pcnt,le.populated_EFX_DEADDT_pcnt,le.populated_EFX_MRKT_TELEVER_pcnt,le.populated_EFX_MRKT_TELESCORE_pcnt,le.populated_EFX_MRKT_TOTALSCORE_pcnt,le.populated_EFX_MRKT_TOTALIND_pcnt,le.populated_EFX_MRKT_VACANT_pcnt,le.populated_EFX_MRKT_SEASONAL_pcnt,le.populated_EFX_MBE_pcnt,le.populated_EFX_WBE_pcnt,le.populated_EFX_MWBE_pcnt,le.populated_EFX_SDB_pcnt,le.populated_EFX_HUBZONE_pcnt,le.populated_EFX_DBE_pcnt,le.populated_EFX_VET_pcnt,le.populated_EFX_DVET_pcnt,le.populated_EFX_8a_pcnt,le.populated_EFX_8aEXPDT_pcnt,le.populated_EFX_DIS_pcnt,le.populated_EFX_SBE_pcnt,le.populated_EFX_BUSSIZE_pcnt,le.populated_EFX_LBE_pcnt,le.populated_EFX_GOV_pcnt,le.populated_EFX_FGOV_pcnt,le.populated_EFX_GOV1057_pcnt,le.populated_EFX_NONPROFIT_pcnt,le.populated_EFX_MERCTYPE_pcnt,le.populated_EFX_HBCU_pcnt,le.populated_EFX_GAYLESBIAN_pcnt,le.populated_EFX_WSBE_pcnt,le.populated_EFX_VSBE_pcnt,le.populated_EFX_DVSBE_pcnt,le.populated_EFX_MWBESTATUS_pcnt,le.populated_EFX_NMSDC_pcnt,le.populated_EFX_WBENC_pcnt,le.populated_EFX_CA_PUC_pcnt,le.populated_EFX_TX_HUB_pcnt,le.populated_EFX_TX_HUBCERTNUM_pcnt,le.populated_EFX_GSAX_pcnt,le.populated_EFX_CALTRANS_pcnt,le.populated_EFX_EDU_pcnt,le.populated_EFX_MI_pcnt,le.populated_EFX_ANC_pcnt,le.populated_AT_CERT1_pcnt,le.populated_AT_CERT2_pcnt,le.populated_AT_CERT3_pcnt,le.populated_AT_CERT4_pcnt,le.populated_AT_CERT5_pcnt,le.populated_AT_CERT6_pcnt,le.populated_AT_CERT7_pcnt,le.populated_AT_CERT8_pcnt,le.populated_AT_CERT9_pcnt,le.populated_AT_CERT10_pcnt,le.populated_AT_CERTDESC1_pcnt,le.populated_AT_CERTDESC2_pcnt,le.populated_AT_CERTDESC3_pcnt,le.populated_AT_CERTDESC4_pcnt,le.populated_AT_CERTDESC5_pcnt,le.populated_AT_CERTDESC6_pcnt,le.populated_AT_CERTDESC7_pcnt,le.populated_AT_CERTDESC8_pcnt,le.populated_AT_CERTDESC9_pcnt,le.populated_AT_CERTDESC10_pcnt,le.populated_AT_CERTSRC1_pcnt,le.populated_AT_CERTSRC2_pcnt,le.populated_AT_CERTSRC3_pcnt,le.populated_AT_CERTSRC4_pcnt,le.populated_AT_CERTSRC5_pcnt,le.populated_AT_CERTSRC6_pcnt,le.populated_AT_CERTSRC7_pcnt,le.populated_AT_CERTSRC8_pcnt,le.populated_AT_CERTSRC9_pcnt,le.populated_AT_CERTSRC10_pcnt,le.populated_AT_CERTLEV1_pcnt,le.populated_AT_CERTLEV2_pcnt,le.populated_AT_CERTLEV3_pcnt,le.populated_AT_CERTLEV4_pcnt,le.populated_AT_CERTLEV5_pcnt,le.populated_AT_CERTLEV6_pcnt,le.populated_AT_CERTLEV7_pcnt,le.populated_AT_CERTLEV8_pcnt,le.populated_AT_CERTLEV9_pcnt,le.populated_AT_CERTLEV10_pcnt,le.populated_AT_CERTNUM1_pcnt,le.populated_AT_CERTNUM2_pcnt,le.populated_AT_CERTNUM3_pcnt,le.populated_AT_CERTNUM4_pcnt,le.populated_AT_CERTNUM5_pcnt,le.populated_AT_CERTNUM6_pcnt,le.populated_AT_CERTNUM7_pcnt,le.populated_AT_CERTNUM8_pcnt,le.populated_AT_CERTNUM9_pcnt,le.populated_AT_CERTNUM10_pcnt,le.populated_AT_CERTEXP1_pcnt,le.populated_AT_CERTEXP2_pcnt,le.populated_AT_CERTEXP3_pcnt,le.populated_AT_CERTEXP4_pcnt,le.populated_AT_CERTEXP5_pcnt,le.populated_AT_CERTEXP6_pcnt,le.populated_AT_CERTEXP7_pcnt,le.populated_AT_CERTEXP8_pcnt,le.populated_AT_CERTEXP9_pcnt,le.populated_AT_CERTEXP10_pcnt,le.populated_EFX_EXTRACT_DATE_pcnt,le.populated_EFX_MERCHANT_ID_pcnt,le.populated_EFX_PROJECT_ID_pcnt,le.populated_EFX_FOREIGN_pcnt,le.populated_Record_Update_Refresh_Date_pcnt,le.populated_EFX_DATE_CREATED_pcnt,le.populated_normCompany_Name_pcnt,le.populated_normCompany_Type_pcnt,le.populated_Norm_Geo_Precision_pcnt,le.populated_Exploded_Desc_Corporate_Amount_Precision_pcnt,le.populated_Exploded_Desc_Location_Amount_Precision_pcnt,le.populated_Exploded_Desc_Public_Co_Indicator_pcnt,le.populated_Exploded_Desc_Stock_Exchange_pcnt,le.populated_Exploded_Desc_Telemarketablity_Score_pcnt,le.populated_Exploded_Desc_Telemarketablity_Total_Indicator_pcnt,le.populated_Exploded_Desc_Telemarketablity_Total_Score_pcnt,le.populated_Exploded_Desc_Government1057_Entity_pcnt,le.populated_Exploded_Desc_Merchant_Type_pcnt,le.populated_Exploded_Desc_Busstatcd_pcnt,le.populated_Exploded_Desc_CMSA_pcnt,le.populated_Exploded_Desc_Corpamountcd_pcnt,le.populated_Exploded_Desc_Corpamountprec_pcnt,le.populated_Exploded_Desc_Corpamounttp_pcnt,le.populated_Exploded_Desc_Corpempcd_pcnt,le.populated_Exploded_Desc_Ctrytelcd_pcnt,le.populated_NormAddress_Type_pcnt,le.populated_Norm_Address_pcnt,le.populated_Norm_City_pcnt,le.populated_Norm_State_pcnt,le.populated_Norm_StateC2_pcnt,le.populated_Norm_Zip_pcnt,le.populated_Norm_Zip4_pcnt,le.populated_Norm_Lat_pcnt,le.populated_Norm_Lon_pcnt,le.populated_Norm_Geoprec_pcnt,le.populated_Norm_Region_pcnt,le.populated_Norm_Ctryisocd_pcnt,le.populated_Norm_Ctrynum_pcnt,le.populated_Norm_Ctryname_pcnt,le.populated_clean_company_name_pcnt,le.populated_clean_phone_pcnt,le.populated_clean_secondary_phone_pcnt,le.populated_prim_range_pcnt,le.populated_predir_pcnt,le.populated_prim_name_pcnt,le.populated_addr_suffix_pcnt,le.populated_postdir_pcnt,le.populated_unit_desig_pcnt,le.populated_sec_range_pcnt,le.populated_p_city_name_pcnt,le.populated_v_city_name_pcnt,le.populated_st_pcnt,le.populated_cart_pcnt,le.populated_cr_sort_sz_pcnt);
  SELF.maxlength := CHOOSE(C,le.maxlength_dt_first_seen,le.maxlength_dt_last_seen,le.maxlength_dt_vendor_first_reported,le.maxlength_dt_vendor_last_reported,le.maxlength_dt_effective_first,le.maxlength_dt_effective_last,le.maxlength_process_date,le.maxlength_dotid,le.maxlength_dotscore,le.maxlength_dotweight,le.maxlength_empid,le.maxlength_empscore,le.maxlength_empweight,le.maxlength_powid,le.maxlength_powscore,le.maxlength_powweight,le.maxlength_proxid,le.maxlength_proxscore,le.maxlength_proxweight,le.maxlength_selescore,le.maxlength_seleweight,le.maxlength_orgid,le.maxlength_orgscore,le.maxlength_orgweight,le.maxlength_ultid,le.maxlength_ultscore,le.maxlength_ultweight,le.maxlength_record_type,le.maxlength_EFX_ID,le.maxlength_EFX_NAME,le.maxlength_EFX_LEGAL_NAME,le.maxlength_EFX_ADDRESS,le.maxlength_EFX_CITY,le.maxlength_EFX_STATE,le.maxlength_EFX_STATEC,le.maxlength_EFX_ZIPCODE,le.maxlength_EFX_ZIP4,le.maxlength_EFX_LAT,le.maxlength_EFX_LON,le.maxlength_EFX_GEOPREC,le.maxlength_EFX_REGION,le.maxlength_EFX_CTRYISOCD,le.maxlength_EFX_CTRYNUM,le.maxlength_EFX_CTRYNAME,le.maxlength_EFX_COUNTYNM,le.maxlength_EFX_COUNTY,le.maxlength_EFX_CMSA,le.maxlength_EFX_CMSADESC,le.maxlength_EFX_SOHO,le.maxlength_EFX_BIZ,le.maxlength_EFX_RES,le.maxlength_EFX_CMRA,le.maxlength_EFX_CONGRESS,le.maxlength_EFX_SECADR,le.maxlength_EFX_SECCTY,le.maxlength_EFX_SECSTAT,le.maxlength_EFX_STATEC2,le.maxlength_EFX_SECZIP,le.maxlength_EFX_SECZIP4,le.maxlength_EFX_SECLAT,le.maxlength_EFX_SECLON,le.maxlength_EFX_SECGEOPREC,le.maxlength_EFX_SECREGION,le.maxlength_EFX_SECCTRYISOCD,le.maxlength_EFX_SECCTRYNUM,le.maxlength_EFX_SECCTRYNAME,le.maxlength_EFX_CTRYTELCD,le.maxlength_EFX_PHONE,le.maxlength_EFX_FAXPHONE,le.maxlength_EFX_BUSSTAT,le.maxlength_EFX_BUSSTATCD,le.maxlength_EFX_WEB,le.maxlength_EFX_YREST,le.maxlength_EFX_CORPEMPCNT,le.maxlength_EFX_LOCEMPCNT,le.maxlength_EFX_CORPEMPCD,le.maxlength_EFX_LOCEMPCD,le.maxlength_EFX_CORPAMOUNT,le.maxlength_EFX_CORPAMOUNTCD,le.maxlength_EFX_CORPAMOUNTTP,le.maxlength_EFX_CORPAMOUNTPREC,le.maxlength_EFX_LOCAMOUNT,le.maxlength_EFX_LOCAMOUNTCD,le.maxlength_EFX_LOCAMOUNTTP,le.maxlength_EFX_LOCAMOUNTPREC,le.maxlength_EFX_PUBLIC,le.maxlength_EFX_STKEXC,le.maxlength_EFX_TCKSYM,le.maxlength_EFX_PRIMSIC,le.maxlength_EFX_SECSIC1,le.maxlength_EFX_SECSIC2,le.maxlength_EFX_SECSIC3,le.maxlength_EFX_SECSIC4,le.maxlength_EFX_PRIMSICDESC,le.maxlength_EFX_SECSICDESC1,le.maxlength_EFX_SECSICDESC2,le.maxlength_EFX_SECSICDESC3,le.maxlength_EFX_SECSICDESC4,le.maxlength_EFX_PRIMNAICSCODE,le.maxlength_EFX_SECNAICS1,le.maxlength_EFX_SECNAICS2,le.maxlength_EFX_SECNAICS3,le.maxlength_EFX_SECNAICS4,le.maxlength_EFX_PRIMNAICSDESC,le.maxlength_EFX_SECNAICSDESC1,le.maxlength_EFX_SECNAICSDESC2,le.maxlength_EFX_SECNAICSDESC3,le.maxlength_EFX_SECNAICSDESC4,le.maxlength_EFX_DEAD,le.maxlength_EFX_DEADDT,le.maxlength_EFX_MRKT_TELEVER,le.maxlength_EFX_MRKT_TELESCORE,le.maxlength_EFX_MRKT_TOTALSCORE,le.maxlength_EFX_MRKT_TOTALIND,le.maxlength_EFX_MRKT_VACANT,le.maxlength_EFX_MRKT_SEASONAL,le.maxlength_EFX_MBE,le.maxlength_EFX_WBE,le.maxlength_EFX_MWBE,le.maxlength_EFX_SDB,le.maxlength_EFX_HUBZONE,le.maxlength_EFX_DBE,le.maxlength_EFX_VET,le.maxlength_EFX_DVET,le.maxlength_EFX_8a,le.maxlength_EFX_8aEXPDT,le.maxlength_EFX_DIS,le.maxlength_EFX_SBE,le.maxlength_EFX_BUSSIZE,le.maxlength_EFX_LBE,le.maxlength_EFX_GOV,le.maxlength_EFX_FGOV,le.maxlength_EFX_GOV1057,le.maxlength_EFX_NONPROFIT,le.maxlength_EFX_MERCTYPE,le.maxlength_EFX_HBCU,le.maxlength_EFX_GAYLESBIAN,le.maxlength_EFX_WSBE,le.maxlength_EFX_VSBE,le.maxlength_EFX_DVSBE,le.maxlength_EFX_MWBESTATUS,le.maxlength_EFX_NMSDC,le.maxlength_EFX_WBENC,le.maxlength_EFX_CA_PUC,le.maxlength_EFX_TX_HUB,le.maxlength_EFX_TX_HUBCERTNUM,le.maxlength_EFX_GSAX,le.maxlength_EFX_CALTRANS,le.maxlength_EFX_EDU,le.maxlength_EFX_MI,le.maxlength_EFX_ANC,le.maxlength_AT_CERT1,le.maxlength_AT_CERT2,le.maxlength_AT_CERT3,le.maxlength_AT_CERT4,le.maxlength_AT_CERT5,le.maxlength_AT_CERT6,le.maxlength_AT_CERT7,le.maxlength_AT_CERT8,le.maxlength_AT_CERT9,le.maxlength_AT_CERT10,le.maxlength_AT_CERTDESC1,le.maxlength_AT_CERTDESC2,le.maxlength_AT_CERTDESC3,le.maxlength_AT_CERTDESC4,le.maxlength_AT_CERTDESC5,le.maxlength_AT_CERTDESC6,le.maxlength_AT_CERTDESC7,le.maxlength_AT_CERTDESC8,le.maxlength_AT_CERTDESC9,le.maxlength_AT_CERTDESC10,le.maxlength_AT_CERTSRC1,le.maxlength_AT_CERTSRC2,le.maxlength_AT_CERTSRC3,le.maxlength_AT_CERTSRC4,le.maxlength_AT_CERTSRC5,le.maxlength_AT_CERTSRC6,le.maxlength_AT_CERTSRC7,le.maxlength_AT_CERTSRC8,le.maxlength_AT_CERTSRC9,le.maxlength_AT_CERTSRC10,le.maxlength_AT_CERTLEV1,le.maxlength_AT_CERTLEV2,le.maxlength_AT_CERTLEV3,le.maxlength_AT_CERTLEV4,le.maxlength_AT_CERTLEV5,le.maxlength_AT_CERTLEV6,le.maxlength_AT_CERTLEV7,le.maxlength_AT_CERTLEV8,le.maxlength_AT_CERTLEV9,le.maxlength_AT_CERTLEV10,le.maxlength_AT_CERTNUM1,le.maxlength_AT_CERTNUM2,le.maxlength_AT_CERTNUM3,le.maxlength_AT_CERTNUM4,le.maxlength_AT_CERTNUM5,le.maxlength_AT_CERTNUM6,le.maxlength_AT_CERTNUM7,le.maxlength_AT_CERTNUM8,le.maxlength_AT_CERTNUM9,le.maxlength_AT_CERTNUM10,le.maxlength_AT_CERTEXP1,le.maxlength_AT_CERTEXP2,le.maxlength_AT_CERTEXP3,le.maxlength_AT_CERTEXP4,le.maxlength_AT_CERTEXP5,le.maxlength_AT_CERTEXP6,le.maxlength_AT_CERTEXP7,le.maxlength_AT_CERTEXP8,le.maxlength_AT_CERTEXP9,le.maxlength_AT_CERTEXP10,le.maxlength_EFX_EXTRACT_DATE,le.maxlength_EFX_MERCHANT_ID,le.maxlength_EFX_PROJECT_ID,le.maxlength_EFX_FOREIGN,le.maxlength_Record_Update_Refresh_Date,le.maxlength_EFX_DATE_CREATED,le.maxlength_normCompany_Name,le.maxlength_normCompany_Type,le.maxlength_Norm_Geo_Precision,le.maxlength_Exploded_Desc_Corporate_Amount_Precision,le.maxlength_Exploded_Desc_Location_Amount_Precision,le.maxlength_Exploded_Desc_Public_Co_Indicator,le.maxlength_Exploded_Desc_Stock_Exchange,le.maxlength_Exploded_Desc_Telemarketablity_Score,le.maxlength_Exploded_Desc_Telemarketablity_Total_Indicator,le.maxlength_Exploded_Desc_Telemarketablity_Total_Score,le.maxlength_Exploded_Desc_Government1057_Entity,le.maxlength_Exploded_Desc_Merchant_Type,le.maxlength_Exploded_Desc_Busstatcd,le.maxlength_Exploded_Desc_CMSA,le.maxlength_Exploded_Desc_Corpamountcd,le.maxlength_Exploded_Desc_Corpamountprec,le.maxlength_Exploded_Desc_Corpamounttp,le.maxlength_Exploded_Desc_Corpempcd,le.maxlength_Exploded_Desc_Ctrytelcd,le.maxlength_NormAddress_Type,le.maxlength_Norm_Address,le.maxlength_Norm_City,le.maxlength_Norm_State,le.maxlength_Norm_StateC2,le.maxlength_Norm_Zip,le.maxlength_Norm_Zip4,le.maxlength_Norm_Lat,le.maxlength_Norm_Lon,le.maxlength_Norm_Geoprec,le.maxlength_Norm_Region,le.maxlength_Norm_Ctryisocd,le.maxlength_Norm_Ctrynum,le.maxlength_Norm_Ctryname,le.maxlength_clean_company_name,le.maxlength_clean_phone,le.maxlength_clean_secondary_phone,le.maxlength_prim_range,le.maxlength_predir,le.maxlength_prim_name,le.maxlength_addr_suffix,le.maxlength_postdir,le.maxlength_unit_desig,le.maxlength_sec_range,le.maxlength_p_city_name,le.maxlength_v_city_name,le.maxlength_st,le.maxlength_cart,le.maxlength_cr_sort_sz);
  SELF.avelength := CHOOSE(C,le.avelength_dt_first_seen,le.avelength_dt_last_seen,le.avelength_dt_vendor_first_reported,le.avelength_dt_vendor_last_reported,le.avelength_dt_effective_first,le.avelength_dt_effective_last,le.avelength_process_date,le.avelength_dotid,le.avelength_dotscore,le.avelength_dotweight,le.avelength_empid,le.avelength_empscore,le.avelength_empweight,le.avelength_powid,le.avelength_powscore,le.avelength_powweight,le.avelength_proxid,le.avelength_proxscore,le.avelength_proxweight,le.avelength_selescore,le.avelength_seleweight,le.avelength_orgid,le.avelength_orgscore,le.avelength_orgweight,le.avelength_ultid,le.avelength_ultscore,le.avelength_ultweight,le.avelength_record_type,le.avelength_EFX_ID,le.avelength_EFX_NAME,le.avelength_EFX_LEGAL_NAME,le.avelength_EFX_ADDRESS,le.avelength_EFX_CITY,le.avelength_EFX_STATE,le.avelength_EFX_STATEC,le.avelength_EFX_ZIPCODE,le.avelength_EFX_ZIP4,le.avelength_EFX_LAT,le.avelength_EFX_LON,le.avelength_EFX_GEOPREC,le.avelength_EFX_REGION,le.avelength_EFX_CTRYISOCD,le.avelength_EFX_CTRYNUM,le.avelength_EFX_CTRYNAME,le.avelength_EFX_COUNTYNM,le.avelength_EFX_COUNTY,le.avelength_EFX_CMSA,le.avelength_EFX_CMSADESC,le.avelength_EFX_SOHO,le.avelength_EFX_BIZ,le.avelength_EFX_RES,le.avelength_EFX_CMRA,le.avelength_EFX_CONGRESS,le.avelength_EFX_SECADR,le.avelength_EFX_SECCTY,le.avelength_EFX_SECSTAT,le.avelength_EFX_STATEC2,le.avelength_EFX_SECZIP,le.avelength_EFX_SECZIP4,le.avelength_EFX_SECLAT,le.avelength_EFX_SECLON,le.avelength_EFX_SECGEOPREC,le.avelength_EFX_SECREGION,le.avelength_EFX_SECCTRYISOCD,le.avelength_EFX_SECCTRYNUM,le.avelength_EFX_SECCTRYNAME,le.avelength_EFX_CTRYTELCD,le.avelength_EFX_PHONE,le.avelength_EFX_FAXPHONE,le.avelength_EFX_BUSSTAT,le.avelength_EFX_BUSSTATCD,le.avelength_EFX_WEB,le.avelength_EFX_YREST,le.avelength_EFX_CORPEMPCNT,le.avelength_EFX_LOCEMPCNT,le.avelength_EFX_CORPEMPCD,le.avelength_EFX_LOCEMPCD,le.avelength_EFX_CORPAMOUNT,le.avelength_EFX_CORPAMOUNTCD,le.avelength_EFX_CORPAMOUNTTP,le.avelength_EFX_CORPAMOUNTPREC,le.avelength_EFX_LOCAMOUNT,le.avelength_EFX_LOCAMOUNTCD,le.avelength_EFX_LOCAMOUNTTP,le.avelength_EFX_LOCAMOUNTPREC,le.avelength_EFX_PUBLIC,le.avelength_EFX_STKEXC,le.avelength_EFX_TCKSYM,le.avelength_EFX_PRIMSIC,le.avelength_EFX_SECSIC1,le.avelength_EFX_SECSIC2,le.avelength_EFX_SECSIC3,le.avelength_EFX_SECSIC4,le.avelength_EFX_PRIMSICDESC,le.avelength_EFX_SECSICDESC1,le.avelength_EFX_SECSICDESC2,le.avelength_EFX_SECSICDESC3,le.avelength_EFX_SECSICDESC4,le.avelength_EFX_PRIMNAICSCODE,le.avelength_EFX_SECNAICS1,le.avelength_EFX_SECNAICS2,le.avelength_EFX_SECNAICS3,le.avelength_EFX_SECNAICS4,le.avelength_EFX_PRIMNAICSDESC,le.avelength_EFX_SECNAICSDESC1,le.avelength_EFX_SECNAICSDESC2,le.avelength_EFX_SECNAICSDESC3,le.avelength_EFX_SECNAICSDESC4,le.avelength_EFX_DEAD,le.avelength_EFX_DEADDT,le.avelength_EFX_MRKT_TELEVER,le.avelength_EFX_MRKT_TELESCORE,le.avelength_EFX_MRKT_TOTALSCORE,le.avelength_EFX_MRKT_TOTALIND,le.avelength_EFX_MRKT_VACANT,le.avelength_EFX_MRKT_SEASONAL,le.avelength_EFX_MBE,le.avelength_EFX_WBE,le.avelength_EFX_MWBE,le.avelength_EFX_SDB,le.avelength_EFX_HUBZONE,le.avelength_EFX_DBE,le.avelength_EFX_VET,le.avelength_EFX_DVET,le.avelength_EFX_8a,le.avelength_EFX_8aEXPDT,le.avelength_EFX_DIS,le.avelength_EFX_SBE,le.avelength_EFX_BUSSIZE,le.avelength_EFX_LBE,le.avelength_EFX_GOV,le.avelength_EFX_FGOV,le.avelength_EFX_GOV1057,le.avelength_EFX_NONPROFIT,le.avelength_EFX_MERCTYPE,le.avelength_EFX_HBCU,le.avelength_EFX_GAYLESBIAN,le.avelength_EFX_WSBE,le.avelength_EFX_VSBE,le.avelength_EFX_DVSBE,le.avelength_EFX_MWBESTATUS,le.avelength_EFX_NMSDC,le.avelength_EFX_WBENC,le.avelength_EFX_CA_PUC,le.avelength_EFX_TX_HUB,le.avelength_EFX_TX_HUBCERTNUM,le.avelength_EFX_GSAX,le.avelength_EFX_CALTRANS,le.avelength_EFX_EDU,le.avelength_EFX_MI,le.avelength_EFX_ANC,le.avelength_AT_CERT1,le.avelength_AT_CERT2,le.avelength_AT_CERT3,le.avelength_AT_CERT4,le.avelength_AT_CERT5,le.avelength_AT_CERT6,le.avelength_AT_CERT7,le.avelength_AT_CERT8,le.avelength_AT_CERT9,le.avelength_AT_CERT10,le.avelength_AT_CERTDESC1,le.avelength_AT_CERTDESC2,le.avelength_AT_CERTDESC3,le.avelength_AT_CERTDESC4,le.avelength_AT_CERTDESC5,le.avelength_AT_CERTDESC6,le.avelength_AT_CERTDESC7,le.avelength_AT_CERTDESC8,le.avelength_AT_CERTDESC9,le.avelength_AT_CERTDESC10,le.avelength_AT_CERTSRC1,le.avelength_AT_CERTSRC2,le.avelength_AT_CERTSRC3,le.avelength_AT_CERTSRC4,le.avelength_AT_CERTSRC5,le.avelength_AT_CERTSRC6,le.avelength_AT_CERTSRC7,le.avelength_AT_CERTSRC8,le.avelength_AT_CERTSRC9,le.avelength_AT_CERTSRC10,le.avelength_AT_CERTLEV1,le.avelength_AT_CERTLEV2,le.avelength_AT_CERTLEV3,le.avelength_AT_CERTLEV4,le.avelength_AT_CERTLEV5,le.avelength_AT_CERTLEV6,le.avelength_AT_CERTLEV7,le.avelength_AT_CERTLEV8,le.avelength_AT_CERTLEV9,le.avelength_AT_CERTLEV10,le.avelength_AT_CERTNUM1,le.avelength_AT_CERTNUM2,le.avelength_AT_CERTNUM3,le.avelength_AT_CERTNUM4,le.avelength_AT_CERTNUM5,le.avelength_AT_CERTNUM6,le.avelength_AT_CERTNUM7,le.avelength_AT_CERTNUM8,le.avelength_AT_CERTNUM9,le.avelength_AT_CERTNUM10,le.avelength_AT_CERTEXP1,le.avelength_AT_CERTEXP2,le.avelength_AT_CERTEXP3,le.avelength_AT_CERTEXP4,le.avelength_AT_CERTEXP5,le.avelength_AT_CERTEXP6,le.avelength_AT_CERTEXP7,le.avelength_AT_CERTEXP8,le.avelength_AT_CERTEXP9,le.avelength_AT_CERTEXP10,le.avelength_EFX_EXTRACT_DATE,le.avelength_EFX_MERCHANT_ID,le.avelength_EFX_PROJECT_ID,le.avelength_EFX_FOREIGN,le.avelength_Record_Update_Refresh_Date,le.avelength_EFX_DATE_CREATED,le.avelength_normCompany_Name,le.avelength_normCompany_Type,le.avelength_Norm_Geo_Precision,le.avelength_Exploded_Desc_Corporate_Amount_Precision,le.avelength_Exploded_Desc_Location_Amount_Precision,le.avelength_Exploded_Desc_Public_Co_Indicator,le.avelength_Exploded_Desc_Stock_Exchange,le.avelength_Exploded_Desc_Telemarketablity_Score,le.avelength_Exploded_Desc_Telemarketablity_Total_Indicator,le.avelength_Exploded_Desc_Telemarketablity_Total_Score,le.avelength_Exploded_Desc_Government1057_Entity,le.avelength_Exploded_Desc_Merchant_Type,le.avelength_Exploded_Desc_Busstatcd,le.avelength_Exploded_Desc_CMSA,le.avelength_Exploded_Desc_Corpamountcd,le.avelength_Exploded_Desc_Corpamountprec,le.avelength_Exploded_Desc_Corpamounttp,le.avelength_Exploded_Desc_Corpempcd,le.avelength_Exploded_Desc_Ctrytelcd,le.avelength_NormAddress_Type,le.avelength_Norm_Address,le.avelength_Norm_City,le.avelength_Norm_State,le.avelength_Norm_StateC2,le.avelength_Norm_Zip,le.avelength_Norm_Zip4,le.avelength_Norm_Lat,le.avelength_Norm_Lon,le.avelength_Norm_Geoprec,le.avelength_Norm_Region,le.avelength_Norm_Ctryisocd,le.avelength_Norm_Ctrynum,le.avelength_Norm_Ctryname,le.avelength_clean_company_name,le.avelength_clean_phone,le.avelength_clean_secondary_phone,le.avelength_prim_range,le.avelength_predir,le.avelength_prim_name,le.avelength_addr_suffix,le.avelength_postdir,le.avelength_unit_desig,le.avelength_sec_range,le.avelength_p_city_name,le.avelength_v_city_name,le.avelength_st,le.avelength_cart,le.avelength_cr_sort_sz);
END;
EXPORT invSummary := NORMALIZE(summary0, 265, invert(LEFT,COUNTER));
// The character counts
// Move everything into 'inverted list' form so processing can be done 'in library'
SALT37.MAC_Character_Counts.X_Data_Layout Into(h le,unsigned C) := TRANSFORM
  SELF.id := le.seleid;
  SELF.Src := le.source;
  SELF.Fld := TRIM(CHOOSE(C,IF (le.dt_first_seen <> 0,TRIM((SALT37.StrType)le.dt_first_seen), ''),IF (le.dt_last_seen <> 0,TRIM((SALT37.StrType)le.dt_last_seen), ''),IF (le.dt_vendor_first_reported <> 0,TRIM((SALT37.StrType)le.dt_vendor_first_reported), ''),IF (le.dt_vendor_last_reported <> 0,TRIM((SALT37.StrType)le.dt_vendor_last_reported), ''),TRIM((SALT37.StrType)le.dt_effective_first),TRIM((SALT37.StrType)le.dt_effective_last),TRIM((SALT37.StrType)le.process_date),TRIM((SALT37.StrType)le.dotid),TRIM((SALT37.StrType)le.dotscore),TRIM((SALT37.StrType)le.dotweight),TRIM((SALT37.StrType)le.empid),TRIM((SALT37.StrType)le.empscore),TRIM((SALT37.StrType)le.empweight),TRIM((SALT37.StrType)le.powid),TRIM((SALT37.StrType)le.powscore),TRIM((SALT37.StrType)le.powweight),TRIM((SALT37.StrType)le.proxid),TRIM((SALT37.StrType)le.proxscore),TRIM((SALT37.StrType)le.proxweight),TRIM((SALT37.StrType)le.selescore),TRIM((SALT37.StrType)le.seleweight),TRIM((SALT37.StrType)le.orgid),TRIM((SALT37.StrType)le.orgscore),TRIM((SALT37.StrType)le.orgweight),TRIM((SALT37.StrType)le.ultid),TRIM((SALT37.StrType)le.ultscore),TRIM((SALT37.StrType)le.ultweight),TRIM((SALT37.StrType)le.record_type),TRIM((SALT37.StrType)le.EFX_ID),TRIM((SALT37.StrType)le.EFX_NAME),TRIM((SALT37.StrType)le.EFX_LEGAL_NAME),TRIM((SALT37.StrType)le.EFX_ADDRESS),TRIM((SALT37.StrType)le.EFX_CITY),TRIM((SALT37.StrType)le.EFX_STATE),TRIM((SALT37.StrType)le.EFX_STATEC),TRIM((SALT37.StrType)le.EFX_ZIPCODE),TRIM((SALT37.StrType)le.EFX_ZIP4),TRIM((SALT37.StrType)le.EFX_LAT),TRIM((SALT37.StrType)le.EFX_LON),TRIM((SALT37.StrType)le.EFX_GEOPREC),TRIM((SALT37.StrType)le.EFX_REGION),TRIM((SALT37.StrType)le.EFX_CTRYISOCD),TRIM((SALT37.StrType)le.EFX_CTRYNUM),TRIM((SALT37.StrType)le.EFX_CTRYNAME),TRIM((SALT37.StrType)le.EFX_COUNTYNM),TRIM((SALT37.StrType)le.EFX_COUNTY),TRIM((SALT37.StrType)le.EFX_CMSA),TRIM((SALT37.StrType)le.EFX_CMSADESC),TRIM((SALT37.StrType)le.EFX_SOHO),TRIM((SALT37.StrType)le.EFX_BIZ),TRIM((SALT37.StrType)le.EFX_RES),TRIM((SALT37.StrType)le.EFX_CMRA),TRIM((SALT37.StrType)le.EFX_CONGRESS),TRIM((SALT37.StrType)le.EFX_SECADR),TRIM((SALT37.StrType)le.EFX_SECCTY),TRIM((SALT37.StrType)le.EFX_SECSTAT),TRIM((SALT37.StrType)le.EFX_STATEC2),TRIM((SALT37.StrType)le.EFX_SECZIP),TRIM((SALT37.StrType)le.EFX_SECZIP4),TRIM((SALT37.StrType)le.EFX_SECLAT),TRIM((SALT37.StrType)le.EFX_SECLON),TRIM((SALT37.StrType)le.EFX_SECGEOPREC),TRIM((SALT37.StrType)le.EFX_SECREGION),TRIM((SALT37.StrType)le.EFX_SECCTRYISOCD),TRIM((SALT37.StrType)le.EFX_SECCTRYNUM),TRIM((SALT37.StrType)le.EFX_SECCTRYNAME),TRIM((SALT37.StrType)le.EFX_CTRYTELCD),TRIM((SALT37.StrType)le.EFX_PHONE),TRIM((SALT37.StrType)le.EFX_FAXPHONE),TRIM((SALT37.StrType)le.EFX_BUSSTAT),TRIM((SALT37.StrType)le.EFX_BUSSTATCD),TRIM((SALT37.StrType)le.EFX_WEB),TRIM((SALT37.StrType)le.EFX_YREST),TRIM((SALT37.StrType)le.EFX_CORPEMPCNT),TRIM((SALT37.StrType)le.EFX_LOCEMPCNT),TRIM((SALT37.StrType)le.EFX_CORPEMPCD),TRIM((SALT37.StrType)le.EFX_LOCEMPCD),TRIM((SALT37.StrType)le.EFX_CORPAMOUNT),TRIM((SALT37.StrType)le.EFX_CORPAMOUNTCD),TRIM((SALT37.StrType)le.EFX_CORPAMOUNTTP),TRIM((SALT37.StrType)le.EFX_CORPAMOUNTPREC),TRIM((SALT37.StrType)le.EFX_LOCAMOUNT),TRIM((SALT37.StrType)le.EFX_LOCAMOUNTCD),TRIM((SALT37.StrType)le.EFX_LOCAMOUNTTP),TRIM((SALT37.StrType)le.EFX_LOCAMOUNTPREC),TRIM((SALT37.StrType)le.EFX_PUBLIC),TRIM((SALT37.StrType)le.EFX_STKEXC),TRIM((SALT37.StrType)le.EFX_TCKSYM),TRIM((SALT37.StrType)le.EFX_PRIMSIC),TRIM((SALT37.StrType)le.EFX_SECSIC1),TRIM((SALT37.StrType)le.EFX_SECSIC2),TRIM((SALT37.StrType)le.EFX_SECSIC3),TRIM((SALT37.StrType)le.EFX_SECSIC4),TRIM((SALT37.StrType)le.EFX_PRIMSICDESC),TRIM((SALT37.StrType)le.EFX_SECSICDESC1),TRIM((SALT37.StrType)le.EFX_SECSICDESC2),TRIM((SALT37.StrType)le.EFX_SECSICDESC3),TRIM((SALT37.StrType)le.EFX_SECSICDESC4),TRIM((SALT37.StrType)le.EFX_PRIMNAICSCODE),TRIM((SALT37.StrType)le.EFX_SECNAICS1),TRIM((SALT37.StrType)le.EFX_SECNAICS2),TRIM((SALT37.StrType)le.EFX_SECNAICS3),TRIM((SALT37.StrType)le.EFX_SECNAICS4),TRIM((SALT37.StrType)le.EFX_PRIMNAICSDESC),TRIM((SALT37.StrType)le.EFX_SECNAICSDESC1),TRIM((SALT37.StrType)le.EFX_SECNAICSDESC2),TRIM((SALT37.StrType)le.EFX_SECNAICSDESC3),TRIM((SALT37.StrType)le.EFX_SECNAICSDESC4),TRIM((SALT37.StrType)le.EFX_DEAD),TRIM((SALT37.StrType)le.EFX_DEADDT),TRIM((SALT37.StrType)le.EFX_MRKT_TELEVER),TRIM((SALT37.StrType)le.EFX_MRKT_TELESCORE),TRIM((SALT37.StrType)le.EFX_MRKT_TOTALSCORE),TRIM((SALT37.StrType)le.EFX_MRKT_TOTALIND),TRIM((SALT37.StrType)le.EFX_MRKT_VACANT),TRIM((SALT37.StrType)le.EFX_MRKT_SEASONAL),TRIM((SALT37.StrType)le.EFX_MBE),TRIM((SALT37.StrType)le.EFX_WBE),TRIM((SALT37.StrType)le.EFX_MWBE),TRIM((SALT37.StrType)le.EFX_SDB),TRIM((SALT37.StrType)le.EFX_HUBZONE),TRIM((SALT37.StrType)le.EFX_DBE),TRIM((SALT37.StrType)le.EFX_VET),TRIM((SALT37.StrType)le.EFX_DVET),TRIM((SALT37.StrType)le.EFX_8a),TRIM((SALT37.StrType)le.EFX_8aEXPDT),TRIM((SALT37.StrType)le.EFX_DIS),TRIM((SALT37.StrType)le.EFX_SBE),TRIM((SALT37.StrType)le.EFX_BUSSIZE),TRIM((SALT37.StrType)le.EFX_LBE),TRIM((SALT37.StrType)le.EFX_GOV),TRIM((SALT37.StrType)le.EFX_FGOV),TRIM((SALT37.StrType)le.EFX_GOV1057),TRIM((SALT37.StrType)le.EFX_NONPROFIT),TRIM((SALT37.StrType)le.EFX_MERCTYPE),TRIM((SALT37.StrType)le.EFX_HBCU),TRIM((SALT37.StrType)le.EFX_GAYLESBIAN),TRIM((SALT37.StrType)le.EFX_WSBE),TRIM((SALT37.StrType)le.EFX_VSBE),TRIM((SALT37.StrType)le.EFX_DVSBE),TRIM((SALT37.StrType)le.EFX_MWBESTATUS),TRIM((SALT37.StrType)le.EFX_NMSDC),TRIM((SALT37.StrType)le.EFX_WBENC),TRIM((SALT37.StrType)le.EFX_CA_PUC),TRIM((SALT37.StrType)le.EFX_TX_HUB),TRIM((SALT37.StrType)le.EFX_TX_HUBCERTNUM),TRIM((SALT37.StrType)le.EFX_GSAX),TRIM((SALT37.StrType)le.EFX_CALTRANS),TRIM((SALT37.StrType)le.EFX_EDU),TRIM((SALT37.StrType)le.EFX_MI),TRIM((SALT37.StrType)le.EFX_ANC),TRIM((SALT37.StrType)le.AT_CERT1),TRIM((SALT37.StrType)le.AT_CERT2),TRIM((SALT37.StrType)le.AT_CERT3),TRIM((SALT37.StrType)le.AT_CERT4),TRIM((SALT37.StrType)le.AT_CERT5),TRIM((SALT37.StrType)le.AT_CERT6),TRIM((SALT37.StrType)le.AT_CERT7),TRIM((SALT37.StrType)le.AT_CERT8),TRIM((SALT37.StrType)le.AT_CERT9),TRIM((SALT37.StrType)le.AT_CERT10),TRIM((SALT37.StrType)le.AT_CERTDESC1),TRIM((SALT37.StrType)le.AT_CERTDESC2),TRIM((SALT37.StrType)le.AT_CERTDESC3),TRIM((SALT37.StrType)le.AT_CERTDESC4),TRIM((SALT37.StrType)le.AT_CERTDESC5),TRIM((SALT37.StrType)le.AT_CERTDESC6),TRIM((SALT37.StrType)le.AT_CERTDESC7),TRIM((SALT37.StrType)le.AT_CERTDESC8),TRIM((SALT37.StrType)le.AT_CERTDESC9),TRIM((SALT37.StrType)le.AT_CERTDESC10),TRIM((SALT37.StrType)le.AT_CERTSRC1),TRIM((SALT37.StrType)le.AT_CERTSRC2),TRIM((SALT37.StrType)le.AT_CERTSRC3),TRIM((SALT37.StrType)le.AT_CERTSRC4),TRIM((SALT37.StrType)le.AT_CERTSRC5),TRIM((SALT37.StrType)le.AT_CERTSRC6),TRIM((SALT37.StrType)le.AT_CERTSRC7),TRIM((SALT37.StrType)le.AT_CERTSRC8),TRIM((SALT37.StrType)le.AT_CERTSRC9),TRIM((SALT37.StrType)le.AT_CERTSRC10),TRIM((SALT37.StrType)le.AT_CERTLEV1),TRIM((SALT37.StrType)le.AT_CERTLEV2),TRIM((SALT37.StrType)le.AT_CERTLEV3),TRIM((SALT37.StrType)le.AT_CERTLEV4),TRIM((SALT37.StrType)le.AT_CERTLEV5),TRIM((SALT37.StrType)le.AT_CERTLEV6),TRIM((SALT37.StrType)le.AT_CERTLEV7),TRIM((SALT37.StrType)le.AT_CERTLEV8),TRIM((SALT37.StrType)le.AT_CERTLEV9),TRIM((SALT37.StrType)le.AT_CERTLEV10),TRIM((SALT37.StrType)le.AT_CERTNUM1),TRIM((SALT37.StrType)le.AT_CERTNUM2),TRIM((SALT37.StrType)le.AT_CERTNUM3),TRIM((SALT37.StrType)le.AT_CERTNUM4),TRIM((SALT37.StrType)le.AT_CERTNUM5),TRIM((SALT37.StrType)le.AT_CERTNUM6),TRIM((SALT37.StrType)le.AT_CERTNUM7),TRIM((SALT37.StrType)le.AT_CERTNUM8),TRIM((SALT37.StrType)le.AT_CERTNUM9),TRIM((SALT37.StrType)le.AT_CERTNUM10),TRIM((SALT37.StrType)le.AT_CERTEXP1),TRIM((SALT37.StrType)le.AT_CERTEXP2),TRIM((SALT37.StrType)le.AT_CERTEXP3),TRIM((SALT37.StrType)le.AT_CERTEXP4),TRIM((SALT37.StrType)le.AT_CERTEXP5),TRIM((SALT37.StrType)le.AT_CERTEXP6),TRIM((SALT37.StrType)le.AT_CERTEXP7),TRIM((SALT37.StrType)le.AT_CERTEXP8),TRIM((SALT37.StrType)le.AT_CERTEXP9),TRIM((SALT37.StrType)le.AT_CERTEXP10),TRIM((SALT37.StrType)le.EFX_EXTRACT_DATE),TRIM((SALT37.StrType)le.EFX_MERCHANT_ID),TRIM((SALT37.StrType)le.EFX_PROJECT_ID),TRIM((SALT37.StrType)le.EFX_FOREIGN),TRIM((SALT37.StrType)le.Record_Update_Refresh_Date),TRIM((SALT37.StrType)le.EFX_DATE_CREATED),TRIM((SALT37.StrType)le.normCompany_Name),TRIM((SALT37.StrType)le.normCompany_Type),TRIM((SALT37.StrType)le.Norm_Geo_Precision),TRIM((SALT37.StrType)le.Exploded_Desc_Corporate_Amount_Precision),TRIM((SALT37.StrType)le.Exploded_Desc_Location_Amount_Precision),TRIM((SALT37.StrType)le.Exploded_Desc_Public_Co_Indicator),TRIM((SALT37.StrType)le.Exploded_Desc_Stock_Exchange),TRIM((SALT37.StrType)le.Exploded_Desc_Telemarketablity_Score),TRIM((SALT37.StrType)le.Exploded_Desc_Telemarketablity_Total_Indicator),TRIM((SALT37.StrType)le.Exploded_Desc_Telemarketablity_Total_Score),TRIM((SALT37.StrType)le.Exploded_Desc_Government1057_Entity),TRIM((SALT37.StrType)le.Exploded_Desc_Merchant_Type),TRIM((SALT37.StrType)le.Exploded_Desc_Busstatcd),TRIM((SALT37.StrType)le.Exploded_Desc_CMSA),TRIM((SALT37.StrType)le.Exploded_Desc_Corpamountcd),TRIM((SALT37.StrType)le.Exploded_Desc_Corpamountprec),TRIM((SALT37.StrType)le.Exploded_Desc_Corpamounttp),TRIM((SALT37.StrType)le.Exploded_Desc_Corpempcd),TRIM((SALT37.StrType)le.Exploded_Desc_Ctrytelcd),TRIM((SALT37.StrType)le.NormAddress_Type),TRIM((SALT37.StrType)le.Norm_Address),TRIM((SALT37.StrType)le.Norm_City),TRIM((SALT37.StrType)le.Norm_State),TRIM((SALT37.StrType)le.Norm_StateC2),TRIM((SALT37.StrType)le.Norm_Zip),TRIM((SALT37.StrType)le.Norm_Zip4),TRIM((SALT37.StrType)le.Norm_Lat),TRIM((SALT37.StrType)le.Norm_Lon),TRIM((SALT37.StrType)le.Norm_Geoprec),TRIM((SALT37.StrType)le.Norm_Region),TRIM((SALT37.StrType)le.Norm_Ctryisocd),TRIM((SALT37.StrType)le.Norm_Ctrynum),TRIM((SALT37.StrType)le.Norm_Ctryname),TRIM((SALT37.StrType)le.clean_company_name),TRIM((SALT37.StrType)le.clean_phone),TRIM((SALT37.StrType)le.clean_secondary_phone),TRIM((SALT37.StrType)le.prim_range),TRIM((SALT37.StrType)le.predir),TRIM((SALT37.StrType)le.prim_name),TRIM((SALT37.StrType)le.addr_suffix),TRIM((SALT37.StrType)le.postdir),TRIM((SALT37.StrType)le.unit_desig),TRIM((SALT37.StrType)le.sec_range),TRIM((SALT37.StrType)le.p_city_name),TRIM((SALT37.StrType)le.v_city_name),TRIM((SALT37.StrType)le.st),TRIM((SALT37.StrType)le.cart),TRIM((SALT37.StrType)le.cr_sort_sz)));
  SELF.FldNo := C;
END;
SHARED FldInv0 := NORMALIZE(h,265,Into(LEFT,COUNTER));
// Move everything into 'pairs' form so processing can be done 'in library'
SALT37.MAC_Correlate.Data_Layout IntoP(h le,UNSIGNED C) := TRANSFORM
  SELF.FldNo1 := 1 + (C / 265);
  SELF.FldNo2 := 1 + (C % 265);
  SELF.Fld1 := TRIM(CHOOSE(SELF.FldNo1,IF (le.dt_first_seen <> 0,TRIM((SALT37.StrType)le.dt_first_seen), ''),IF (le.dt_last_seen <> 0,TRIM((SALT37.StrType)le.dt_last_seen), ''),IF (le.dt_vendor_first_reported <> 0,TRIM((SALT37.StrType)le.dt_vendor_first_reported), ''),IF (le.dt_vendor_last_reported <> 0,TRIM((SALT37.StrType)le.dt_vendor_last_reported), ''),TRIM((SALT37.StrType)le.dt_effective_first),TRIM((SALT37.StrType)le.dt_effective_last),TRIM((SALT37.StrType)le.process_date),TRIM((SALT37.StrType)le.dotid),TRIM((SALT37.StrType)le.dotscore),TRIM((SALT37.StrType)le.dotweight),TRIM((SALT37.StrType)le.empid),TRIM((SALT37.StrType)le.empscore),TRIM((SALT37.StrType)le.empweight),TRIM((SALT37.StrType)le.powid),TRIM((SALT37.StrType)le.powscore),TRIM((SALT37.StrType)le.powweight),TRIM((SALT37.StrType)le.proxid),TRIM((SALT37.StrType)le.proxscore),TRIM((SALT37.StrType)le.proxweight),TRIM((SALT37.StrType)le.selescore),TRIM((SALT37.StrType)le.seleweight),TRIM((SALT37.StrType)le.orgid),TRIM((SALT37.StrType)le.orgscore),TRIM((SALT37.StrType)le.orgweight),TRIM((SALT37.StrType)le.ultid),TRIM((SALT37.StrType)le.ultscore),TRIM((SALT37.StrType)le.ultweight),TRIM((SALT37.StrType)le.record_type),TRIM((SALT37.StrType)le.EFX_ID),TRIM((SALT37.StrType)le.EFX_NAME),TRIM((SALT37.StrType)le.EFX_LEGAL_NAME),TRIM((SALT37.StrType)le.EFX_ADDRESS),TRIM((SALT37.StrType)le.EFX_CITY),TRIM((SALT37.StrType)le.EFX_STATE),TRIM((SALT37.StrType)le.EFX_STATEC),TRIM((SALT37.StrType)le.EFX_ZIPCODE),TRIM((SALT37.StrType)le.EFX_ZIP4),TRIM((SALT37.StrType)le.EFX_LAT),TRIM((SALT37.StrType)le.EFX_LON),TRIM((SALT37.StrType)le.EFX_GEOPREC),TRIM((SALT37.StrType)le.EFX_REGION),TRIM((SALT37.StrType)le.EFX_CTRYISOCD),TRIM((SALT37.StrType)le.EFX_CTRYNUM),TRIM((SALT37.StrType)le.EFX_CTRYNAME),TRIM((SALT37.StrType)le.EFX_COUNTYNM),TRIM((SALT37.StrType)le.EFX_COUNTY),TRIM((SALT37.StrType)le.EFX_CMSA),TRIM((SALT37.StrType)le.EFX_CMSADESC),TRIM((SALT37.StrType)le.EFX_SOHO),TRIM((SALT37.StrType)le.EFX_BIZ),TRIM((SALT37.StrType)le.EFX_RES),TRIM((SALT37.StrType)le.EFX_CMRA),TRIM((SALT37.StrType)le.EFX_CONGRESS),TRIM((SALT37.StrType)le.EFX_SECADR),TRIM((SALT37.StrType)le.EFX_SECCTY),TRIM((SALT37.StrType)le.EFX_SECSTAT),TRIM((SALT37.StrType)le.EFX_STATEC2),TRIM((SALT37.StrType)le.EFX_SECZIP),TRIM((SALT37.StrType)le.EFX_SECZIP4),TRIM((SALT37.StrType)le.EFX_SECLAT),TRIM((SALT37.StrType)le.EFX_SECLON),TRIM((SALT37.StrType)le.EFX_SECGEOPREC),TRIM((SALT37.StrType)le.EFX_SECREGION),TRIM((SALT37.StrType)le.EFX_SECCTRYISOCD),TRIM((SALT37.StrType)le.EFX_SECCTRYNUM),TRIM((SALT37.StrType)le.EFX_SECCTRYNAME),TRIM((SALT37.StrType)le.EFX_CTRYTELCD),TRIM((SALT37.StrType)le.EFX_PHONE),TRIM((SALT37.StrType)le.EFX_FAXPHONE),TRIM((SALT37.StrType)le.EFX_BUSSTAT),TRIM((SALT37.StrType)le.EFX_BUSSTATCD),TRIM((SALT37.StrType)le.EFX_WEB),TRIM((SALT37.StrType)le.EFX_YREST),TRIM((SALT37.StrType)le.EFX_CORPEMPCNT),TRIM((SALT37.StrType)le.EFX_LOCEMPCNT),TRIM((SALT37.StrType)le.EFX_CORPEMPCD),TRIM((SALT37.StrType)le.EFX_LOCEMPCD),TRIM((SALT37.StrType)le.EFX_CORPAMOUNT),TRIM((SALT37.StrType)le.EFX_CORPAMOUNTCD),TRIM((SALT37.StrType)le.EFX_CORPAMOUNTTP),TRIM((SALT37.StrType)le.EFX_CORPAMOUNTPREC),TRIM((SALT37.StrType)le.EFX_LOCAMOUNT),TRIM((SALT37.StrType)le.EFX_LOCAMOUNTCD),TRIM((SALT37.StrType)le.EFX_LOCAMOUNTTP),TRIM((SALT37.StrType)le.EFX_LOCAMOUNTPREC),TRIM((SALT37.StrType)le.EFX_PUBLIC),TRIM((SALT37.StrType)le.EFX_STKEXC),TRIM((SALT37.StrType)le.EFX_TCKSYM),TRIM((SALT37.StrType)le.EFX_PRIMSIC),TRIM((SALT37.StrType)le.EFX_SECSIC1),TRIM((SALT37.StrType)le.EFX_SECSIC2),TRIM((SALT37.StrType)le.EFX_SECSIC3),TRIM((SALT37.StrType)le.EFX_SECSIC4),TRIM((SALT37.StrType)le.EFX_PRIMSICDESC),TRIM((SALT37.StrType)le.EFX_SECSICDESC1),TRIM((SALT37.StrType)le.EFX_SECSICDESC2),TRIM((SALT37.StrType)le.EFX_SECSICDESC3),TRIM((SALT37.StrType)le.EFX_SECSICDESC4),TRIM((SALT37.StrType)le.EFX_PRIMNAICSCODE),TRIM((SALT37.StrType)le.EFX_SECNAICS1),TRIM((SALT37.StrType)le.EFX_SECNAICS2),TRIM((SALT37.StrType)le.EFX_SECNAICS3),TRIM((SALT37.StrType)le.EFX_SECNAICS4),TRIM((SALT37.StrType)le.EFX_PRIMNAICSDESC),TRIM((SALT37.StrType)le.EFX_SECNAICSDESC1),TRIM((SALT37.StrType)le.EFX_SECNAICSDESC2),TRIM((SALT37.StrType)le.EFX_SECNAICSDESC3),TRIM((SALT37.StrType)le.EFX_SECNAICSDESC4),TRIM((SALT37.StrType)le.EFX_DEAD),TRIM((SALT37.StrType)le.EFX_DEADDT),TRIM((SALT37.StrType)le.EFX_MRKT_TELEVER),TRIM((SALT37.StrType)le.EFX_MRKT_TELESCORE),TRIM((SALT37.StrType)le.EFX_MRKT_TOTALSCORE),TRIM((SALT37.StrType)le.EFX_MRKT_TOTALIND),TRIM((SALT37.StrType)le.EFX_MRKT_VACANT),TRIM((SALT37.StrType)le.EFX_MRKT_SEASONAL),TRIM((SALT37.StrType)le.EFX_MBE),TRIM((SALT37.StrType)le.EFX_WBE),TRIM((SALT37.StrType)le.EFX_MWBE),TRIM((SALT37.StrType)le.EFX_SDB),TRIM((SALT37.StrType)le.EFX_HUBZONE),TRIM((SALT37.StrType)le.EFX_DBE),TRIM((SALT37.StrType)le.EFX_VET),TRIM((SALT37.StrType)le.EFX_DVET),TRIM((SALT37.StrType)le.EFX_8a),TRIM((SALT37.StrType)le.EFX_8aEXPDT),TRIM((SALT37.StrType)le.EFX_DIS),TRIM((SALT37.StrType)le.EFX_SBE),TRIM((SALT37.StrType)le.EFX_BUSSIZE),TRIM((SALT37.StrType)le.EFX_LBE),TRIM((SALT37.StrType)le.EFX_GOV),TRIM((SALT37.StrType)le.EFX_FGOV),TRIM((SALT37.StrType)le.EFX_GOV1057),TRIM((SALT37.StrType)le.EFX_NONPROFIT),TRIM((SALT37.StrType)le.EFX_MERCTYPE),TRIM((SALT37.StrType)le.EFX_HBCU),TRIM((SALT37.StrType)le.EFX_GAYLESBIAN),TRIM((SALT37.StrType)le.EFX_WSBE),TRIM((SALT37.StrType)le.EFX_VSBE),TRIM((SALT37.StrType)le.EFX_DVSBE),TRIM((SALT37.StrType)le.EFX_MWBESTATUS),TRIM((SALT37.StrType)le.EFX_NMSDC),TRIM((SALT37.StrType)le.EFX_WBENC),TRIM((SALT37.StrType)le.EFX_CA_PUC),TRIM((SALT37.StrType)le.EFX_TX_HUB),TRIM((SALT37.StrType)le.EFX_TX_HUBCERTNUM),TRIM((SALT37.StrType)le.EFX_GSAX),TRIM((SALT37.StrType)le.EFX_CALTRANS),TRIM((SALT37.StrType)le.EFX_EDU),TRIM((SALT37.StrType)le.EFX_MI),TRIM((SALT37.StrType)le.EFX_ANC),TRIM((SALT37.StrType)le.AT_CERT1),TRIM((SALT37.StrType)le.AT_CERT2),TRIM((SALT37.StrType)le.AT_CERT3),TRIM((SALT37.StrType)le.AT_CERT4),TRIM((SALT37.StrType)le.AT_CERT5),TRIM((SALT37.StrType)le.AT_CERT6),TRIM((SALT37.StrType)le.AT_CERT7),TRIM((SALT37.StrType)le.AT_CERT8),TRIM((SALT37.StrType)le.AT_CERT9),TRIM((SALT37.StrType)le.AT_CERT10),TRIM((SALT37.StrType)le.AT_CERTDESC1),TRIM((SALT37.StrType)le.AT_CERTDESC2),TRIM((SALT37.StrType)le.AT_CERTDESC3),TRIM((SALT37.StrType)le.AT_CERTDESC4),TRIM((SALT37.StrType)le.AT_CERTDESC5),TRIM((SALT37.StrType)le.AT_CERTDESC6),TRIM((SALT37.StrType)le.AT_CERTDESC7),TRIM((SALT37.StrType)le.AT_CERTDESC8),TRIM((SALT37.StrType)le.AT_CERTDESC9),TRIM((SALT37.StrType)le.AT_CERTDESC10),TRIM((SALT37.StrType)le.AT_CERTSRC1),TRIM((SALT37.StrType)le.AT_CERTSRC2),TRIM((SALT37.StrType)le.AT_CERTSRC3),TRIM((SALT37.StrType)le.AT_CERTSRC4),TRIM((SALT37.StrType)le.AT_CERTSRC5),TRIM((SALT37.StrType)le.AT_CERTSRC6),TRIM((SALT37.StrType)le.AT_CERTSRC7),TRIM((SALT37.StrType)le.AT_CERTSRC8),TRIM((SALT37.StrType)le.AT_CERTSRC9),TRIM((SALT37.StrType)le.AT_CERTSRC10),TRIM((SALT37.StrType)le.AT_CERTLEV1),TRIM((SALT37.StrType)le.AT_CERTLEV2),TRIM((SALT37.StrType)le.AT_CERTLEV3),TRIM((SALT37.StrType)le.AT_CERTLEV4),TRIM((SALT37.StrType)le.AT_CERTLEV5),TRIM((SALT37.StrType)le.AT_CERTLEV6),TRIM((SALT37.StrType)le.AT_CERTLEV7),TRIM((SALT37.StrType)le.AT_CERTLEV8),TRIM((SALT37.StrType)le.AT_CERTLEV9),TRIM((SALT37.StrType)le.AT_CERTLEV10),TRIM((SALT37.StrType)le.AT_CERTNUM1),TRIM((SALT37.StrType)le.AT_CERTNUM2),TRIM((SALT37.StrType)le.AT_CERTNUM3),TRIM((SALT37.StrType)le.AT_CERTNUM4),TRIM((SALT37.StrType)le.AT_CERTNUM5),TRIM((SALT37.StrType)le.AT_CERTNUM6),TRIM((SALT37.StrType)le.AT_CERTNUM7),TRIM((SALT37.StrType)le.AT_CERTNUM8),TRIM((SALT37.StrType)le.AT_CERTNUM9),TRIM((SALT37.StrType)le.AT_CERTNUM10),TRIM((SALT37.StrType)le.AT_CERTEXP1),TRIM((SALT37.StrType)le.AT_CERTEXP2),TRIM((SALT37.StrType)le.AT_CERTEXP3),TRIM((SALT37.StrType)le.AT_CERTEXP4),TRIM((SALT37.StrType)le.AT_CERTEXP5),TRIM((SALT37.StrType)le.AT_CERTEXP6),TRIM((SALT37.StrType)le.AT_CERTEXP7),TRIM((SALT37.StrType)le.AT_CERTEXP8),TRIM((SALT37.StrType)le.AT_CERTEXP9),TRIM((SALT37.StrType)le.AT_CERTEXP10),TRIM((SALT37.StrType)le.EFX_EXTRACT_DATE),TRIM((SALT37.StrType)le.EFX_MERCHANT_ID),TRIM((SALT37.StrType)le.EFX_PROJECT_ID),TRIM((SALT37.StrType)le.EFX_FOREIGN),TRIM((SALT37.StrType)le.Record_Update_Refresh_Date),TRIM((SALT37.StrType)le.EFX_DATE_CREATED),TRIM((SALT37.StrType)le.normCompany_Name),TRIM((SALT37.StrType)le.normCompany_Type),TRIM((SALT37.StrType)le.Norm_Geo_Precision),TRIM((SALT37.StrType)le.Exploded_Desc_Corporate_Amount_Precision),TRIM((SALT37.StrType)le.Exploded_Desc_Location_Amount_Precision),TRIM((SALT37.StrType)le.Exploded_Desc_Public_Co_Indicator),TRIM((SALT37.StrType)le.Exploded_Desc_Stock_Exchange),TRIM((SALT37.StrType)le.Exploded_Desc_Telemarketablity_Score),TRIM((SALT37.StrType)le.Exploded_Desc_Telemarketablity_Total_Indicator),TRIM((SALT37.StrType)le.Exploded_Desc_Telemarketablity_Total_Score),TRIM((SALT37.StrType)le.Exploded_Desc_Government1057_Entity),TRIM((SALT37.StrType)le.Exploded_Desc_Merchant_Type),TRIM((SALT37.StrType)le.Exploded_Desc_Busstatcd),TRIM((SALT37.StrType)le.Exploded_Desc_CMSA),TRIM((SALT37.StrType)le.Exploded_Desc_Corpamountcd),TRIM((SALT37.StrType)le.Exploded_Desc_Corpamountprec),TRIM((SALT37.StrType)le.Exploded_Desc_Corpamounttp),TRIM((SALT37.StrType)le.Exploded_Desc_Corpempcd),TRIM((SALT37.StrType)le.Exploded_Desc_Ctrytelcd),TRIM((SALT37.StrType)le.NormAddress_Type),TRIM((SALT37.StrType)le.Norm_Address),TRIM((SALT37.StrType)le.Norm_City),TRIM((SALT37.StrType)le.Norm_State),TRIM((SALT37.StrType)le.Norm_StateC2),TRIM((SALT37.StrType)le.Norm_Zip),TRIM((SALT37.StrType)le.Norm_Zip4),TRIM((SALT37.StrType)le.Norm_Lat),TRIM((SALT37.StrType)le.Norm_Lon),TRIM((SALT37.StrType)le.Norm_Geoprec),TRIM((SALT37.StrType)le.Norm_Region),TRIM((SALT37.StrType)le.Norm_Ctryisocd),TRIM((SALT37.StrType)le.Norm_Ctrynum),TRIM((SALT37.StrType)le.Norm_Ctryname),TRIM((SALT37.StrType)le.clean_company_name),TRIM((SALT37.StrType)le.clean_phone),TRIM((SALT37.StrType)le.clean_secondary_phone),TRIM((SALT37.StrType)le.prim_range),TRIM((SALT37.StrType)le.predir),TRIM((SALT37.StrType)le.prim_name),TRIM((SALT37.StrType)le.addr_suffix),TRIM((SALT37.StrType)le.postdir),TRIM((SALT37.StrType)le.unit_desig),TRIM((SALT37.StrType)le.sec_range),TRIM((SALT37.StrType)le.p_city_name),TRIM((SALT37.StrType)le.v_city_name),TRIM((SALT37.StrType)le.st),TRIM((SALT37.StrType)le.cart),TRIM((SALT37.StrType)le.cr_sort_sz)));
  SELF.Fld2 := TRIM(CHOOSE(SELF.FldNo2,IF (le.dt_first_seen <> 0,TRIM((SALT37.StrType)le.dt_first_seen), ''),IF (le.dt_last_seen <> 0,TRIM((SALT37.StrType)le.dt_last_seen), ''),IF (le.dt_vendor_first_reported <> 0,TRIM((SALT37.StrType)le.dt_vendor_first_reported), ''),IF (le.dt_vendor_last_reported <> 0,TRIM((SALT37.StrType)le.dt_vendor_last_reported), ''),TRIM((SALT37.StrType)le.dt_effective_first),TRIM((SALT37.StrType)le.dt_effective_last),TRIM((SALT37.StrType)le.process_date),TRIM((SALT37.StrType)le.dotid),TRIM((SALT37.StrType)le.dotscore),TRIM((SALT37.StrType)le.dotweight),TRIM((SALT37.StrType)le.empid),TRIM((SALT37.StrType)le.empscore),TRIM((SALT37.StrType)le.empweight),TRIM((SALT37.StrType)le.powid),TRIM((SALT37.StrType)le.powscore),TRIM((SALT37.StrType)le.powweight),TRIM((SALT37.StrType)le.proxid),TRIM((SALT37.StrType)le.proxscore),TRIM((SALT37.StrType)le.proxweight),TRIM((SALT37.StrType)le.selescore),TRIM((SALT37.StrType)le.seleweight),TRIM((SALT37.StrType)le.orgid),TRIM((SALT37.StrType)le.orgscore),TRIM((SALT37.StrType)le.orgweight),TRIM((SALT37.StrType)le.ultid),TRIM((SALT37.StrType)le.ultscore),TRIM((SALT37.StrType)le.ultweight),TRIM((SALT37.StrType)le.record_type),TRIM((SALT37.StrType)le.EFX_ID),TRIM((SALT37.StrType)le.EFX_NAME),TRIM((SALT37.StrType)le.EFX_LEGAL_NAME),TRIM((SALT37.StrType)le.EFX_ADDRESS),TRIM((SALT37.StrType)le.EFX_CITY),TRIM((SALT37.StrType)le.EFX_STATE),TRIM((SALT37.StrType)le.EFX_STATEC),TRIM((SALT37.StrType)le.EFX_ZIPCODE),TRIM((SALT37.StrType)le.EFX_ZIP4),TRIM((SALT37.StrType)le.EFX_LAT),TRIM((SALT37.StrType)le.EFX_LON),TRIM((SALT37.StrType)le.EFX_GEOPREC),TRIM((SALT37.StrType)le.EFX_REGION),TRIM((SALT37.StrType)le.EFX_CTRYISOCD),TRIM((SALT37.StrType)le.EFX_CTRYNUM),TRIM((SALT37.StrType)le.EFX_CTRYNAME),TRIM((SALT37.StrType)le.EFX_COUNTYNM),TRIM((SALT37.StrType)le.EFX_COUNTY),TRIM((SALT37.StrType)le.EFX_CMSA),TRIM((SALT37.StrType)le.EFX_CMSADESC),TRIM((SALT37.StrType)le.EFX_SOHO),TRIM((SALT37.StrType)le.EFX_BIZ),TRIM((SALT37.StrType)le.EFX_RES),TRIM((SALT37.StrType)le.EFX_CMRA),TRIM((SALT37.StrType)le.EFX_CONGRESS),TRIM((SALT37.StrType)le.EFX_SECADR),TRIM((SALT37.StrType)le.EFX_SECCTY),TRIM((SALT37.StrType)le.EFX_SECSTAT),TRIM((SALT37.StrType)le.EFX_STATEC2),TRIM((SALT37.StrType)le.EFX_SECZIP),TRIM((SALT37.StrType)le.EFX_SECZIP4),TRIM((SALT37.StrType)le.EFX_SECLAT),TRIM((SALT37.StrType)le.EFX_SECLON),TRIM((SALT37.StrType)le.EFX_SECGEOPREC),TRIM((SALT37.StrType)le.EFX_SECREGION),TRIM((SALT37.StrType)le.EFX_SECCTRYISOCD),TRIM((SALT37.StrType)le.EFX_SECCTRYNUM),TRIM((SALT37.StrType)le.EFX_SECCTRYNAME),TRIM((SALT37.StrType)le.EFX_CTRYTELCD),TRIM((SALT37.StrType)le.EFX_PHONE),TRIM((SALT37.StrType)le.EFX_FAXPHONE),TRIM((SALT37.StrType)le.EFX_BUSSTAT),TRIM((SALT37.StrType)le.EFX_BUSSTATCD),TRIM((SALT37.StrType)le.EFX_WEB),TRIM((SALT37.StrType)le.EFX_YREST),TRIM((SALT37.StrType)le.EFX_CORPEMPCNT),TRIM((SALT37.StrType)le.EFX_LOCEMPCNT),TRIM((SALT37.StrType)le.EFX_CORPEMPCD),TRIM((SALT37.StrType)le.EFX_LOCEMPCD),TRIM((SALT37.StrType)le.EFX_CORPAMOUNT),TRIM((SALT37.StrType)le.EFX_CORPAMOUNTCD),TRIM((SALT37.StrType)le.EFX_CORPAMOUNTTP),TRIM((SALT37.StrType)le.EFX_CORPAMOUNTPREC),TRIM((SALT37.StrType)le.EFX_LOCAMOUNT),TRIM((SALT37.StrType)le.EFX_LOCAMOUNTCD),TRIM((SALT37.StrType)le.EFX_LOCAMOUNTTP),TRIM((SALT37.StrType)le.EFX_LOCAMOUNTPREC),TRIM((SALT37.StrType)le.EFX_PUBLIC),TRIM((SALT37.StrType)le.EFX_STKEXC),TRIM((SALT37.StrType)le.EFX_TCKSYM),TRIM((SALT37.StrType)le.EFX_PRIMSIC),TRIM((SALT37.StrType)le.EFX_SECSIC1),TRIM((SALT37.StrType)le.EFX_SECSIC2),TRIM((SALT37.StrType)le.EFX_SECSIC3),TRIM((SALT37.StrType)le.EFX_SECSIC4),TRIM((SALT37.StrType)le.EFX_PRIMSICDESC),TRIM((SALT37.StrType)le.EFX_SECSICDESC1),TRIM((SALT37.StrType)le.EFX_SECSICDESC2),TRIM((SALT37.StrType)le.EFX_SECSICDESC3),TRIM((SALT37.StrType)le.EFX_SECSICDESC4),TRIM((SALT37.StrType)le.EFX_PRIMNAICSCODE),TRIM((SALT37.StrType)le.EFX_SECNAICS1),TRIM((SALT37.StrType)le.EFX_SECNAICS2),TRIM((SALT37.StrType)le.EFX_SECNAICS3),TRIM((SALT37.StrType)le.EFX_SECNAICS4),TRIM((SALT37.StrType)le.EFX_PRIMNAICSDESC),TRIM((SALT37.StrType)le.EFX_SECNAICSDESC1),TRIM((SALT37.StrType)le.EFX_SECNAICSDESC2),TRIM((SALT37.StrType)le.EFX_SECNAICSDESC3),TRIM((SALT37.StrType)le.EFX_SECNAICSDESC4),TRIM((SALT37.StrType)le.EFX_DEAD),TRIM((SALT37.StrType)le.EFX_DEADDT),TRIM((SALT37.StrType)le.EFX_MRKT_TELEVER),TRIM((SALT37.StrType)le.EFX_MRKT_TELESCORE),TRIM((SALT37.StrType)le.EFX_MRKT_TOTALSCORE),TRIM((SALT37.StrType)le.EFX_MRKT_TOTALIND),TRIM((SALT37.StrType)le.EFX_MRKT_VACANT),TRIM((SALT37.StrType)le.EFX_MRKT_SEASONAL),TRIM((SALT37.StrType)le.EFX_MBE),TRIM((SALT37.StrType)le.EFX_WBE),TRIM((SALT37.StrType)le.EFX_MWBE),TRIM((SALT37.StrType)le.EFX_SDB),TRIM((SALT37.StrType)le.EFX_HUBZONE),TRIM((SALT37.StrType)le.EFX_DBE),TRIM((SALT37.StrType)le.EFX_VET),TRIM((SALT37.StrType)le.EFX_DVET),TRIM((SALT37.StrType)le.EFX_8a),TRIM((SALT37.StrType)le.EFX_8aEXPDT),TRIM((SALT37.StrType)le.EFX_DIS),TRIM((SALT37.StrType)le.EFX_SBE),TRIM((SALT37.StrType)le.EFX_BUSSIZE),TRIM((SALT37.StrType)le.EFX_LBE),TRIM((SALT37.StrType)le.EFX_GOV),TRIM((SALT37.StrType)le.EFX_FGOV),TRIM((SALT37.StrType)le.EFX_GOV1057),TRIM((SALT37.StrType)le.EFX_NONPROFIT),TRIM((SALT37.StrType)le.EFX_MERCTYPE),TRIM((SALT37.StrType)le.EFX_HBCU),TRIM((SALT37.StrType)le.EFX_GAYLESBIAN),TRIM((SALT37.StrType)le.EFX_WSBE),TRIM((SALT37.StrType)le.EFX_VSBE),TRIM((SALT37.StrType)le.EFX_DVSBE),TRIM((SALT37.StrType)le.EFX_MWBESTATUS),TRIM((SALT37.StrType)le.EFX_NMSDC),TRIM((SALT37.StrType)le.EFX_WBENC),TRIM((SALT37.StrType)le.EFX_CA_PUC),TRIM((SALT37.StrType)le.EFX_TX_HUB),TRIM((SALT37.StrType)le.EFX_TX_HUBCERTNUM),TRIM((SALT37.StrType)le.EFX_GSAX),TRIM((SALT37.StrType)le.EFX_CALTRANS),TRIM((SALT37.StrType)le.EFX_EDU),TRIM((SALT37.StrType)le.EFX_MI),TRIM((SALT37.StrType)le.EFX_ANC),TRIM((SALT37.StrType)le.AT_CERT1),TRIM((SALT37.StrType)le.AT_CERT2),TRIM((SALT37.StrType)le.AT_CERT3),TRIM((SALT37.StrType)le.AT_CERT4),TRIM((SALT37.StrType)le.AT_CERT5),TRIM((SALT37.StrType)le.AT_CERT6),TRIM((SALT37.StrType)le.AT_CERT7),TRIM((SALT37.StrType)le.AT_CERT8),TRIM((SALT37.StrType)le.AT_CERT9),TRIM((SALT37.StrType)le.AT_CERT10),TRIM((SALT37.StrType)le.AT_CERTDESC1),TRIM((SALT37.StrType)le.AT_CERTDESC2),TRIM((SALT37.StrType)le.AT_CERTDESC3),TRIM((SALT37.StrType)le.AT_CERTDESC4),TRIM((SALT37.StrType)le.AT_CERTDESC5),TRIM((SALT37.StrType)le.AT_CERTDESC6),TRIM((SALT37.StrType)le.AT_CERTDESC7),TRIM((SALT37.StrType)le.AT_CERTDESC8),TRIM((SALT37.StrType)le.AT_CERTDESC9),TRIM((SALT37.StrType)le.AT_CERTDESC10),TRIM((SALT37.StrType)le.AT_CERTSRC1),TRIM((SALT37.StrType)le.AT_CERTSRC2),TRIM((SALT37.StrType)le.AT_CERTSRC3),TRIM((SALT37.StrType)le.AT_CERTSRC4),TRIM((SALT37.StrType)le.AT_CERTSRC5),TRIM((SALT37.StrType)le.AT_CERTSRC6),TRIM((SALT37.StrType)le.AT_CERTSRC7),TRIM((SALT37.StrType)le.AT_CERTSRC8),TRIM((SALT37.StrType)le.AT_CERTSRC9),TRIM((SALT37.StrType)le.AT_CERTSRC10),TRIM((SALT37.StrType)le.AT_CERTLEV1),TRIM((SALT37.StrType)le.AT_CERTLEV2),TRIM((SALT37.StrType)le.AT_CERTLEV3),TRIM((SALT37.StrType)le.AT_CERTLEV4),TRIM((SALT37.StrType)le.AT_CERTLEV5),TRIM((SALT37.StrType)le.AT_CERTLEV6),TRIM((SALT37.StrType)le.AT_CERTLEV7),TRIM((SALT37.StrType)le.AT_CERTLEV8),TRIM((SALT37.StrType)le.AT_CERTLEV9),TRIM((SALT37.StrType)le.AT_CERTLEV10),TRIM((SALT37.StrType)le.AT_CERTNUM1),TRIM((SALT37.StrType)le.AT_CERTNUM2),TRIM((SALT37.StrType)le.AT_CERTNUM3),TRIM((SALT37.StrType)le.AT_CERTNUM4),TRIM((SALT37.StrType)le.AT_CERTNUM5),TRIM((SALT37.StrType)le.AT_CERTNUM6),TRIM((SALT37.StrType)le.AT_CERTNUM7),TRIM((SALT37.StrType)le.AT_CERTNUM8),TRIM((SALT37.StrType)le.AT_CERTNUM9),TRIM((SALT37.StrType)le.AT_CERTNUM10),TRIM((SALT37.StrType)le.AT_CERTEXP1),TRIM((SALT37.StrType)le.AT_CERTEXP2),TRIM((SALT37.StrType)le.AT_CERTEXP3),TRIM((SALT37.StrType)le.AT_CERTEXP4),TRIM((SALT37.StrType)le.AT_CERTEXP5),TRIM((SALT37.StrType)le.AT_CERTEXP6),TRIM((SALT37.StrType)le.AT_CERTEXP7),TRIM((SALT37.StrType)le.AT_CERTEXP8),TRIM((SALT37.StrType)le.AT_CERTEXP9),TRIM((SALT37.StrType)le.AT_CERTEXP10),TRIM((SALT37.StrType)le.EFX_EXTRACT_DATE),TRIM((SALT37.StrType)le.EFX_MERCHANT_ID),TRIM((SALT37.StrType)le.EFX_PROJECT_ID),TRIM((SALT37.StrType)le.EFX_FOREIGN),TRIM((SALT37.StrType)le.Record_Update_Refresh_Date),TRIM((SALT37.StrType)le.EFX_DATE_CREATED),TRIM((SALT37.StrType)le.normCompany_Name),TRIM((SALT37.StrType)le.normCompany_Type),TRIM((SALT37.StrType)le.Norm_Geo_Precision),TRIM((SALT37.StrType)le.Exploded_Desc_Corporate_Amount_Precision),TRIM((SALT37.StrType)le.Exploded_Desc_Location_Amount_Precision),TRIM((SALT37.StrType)le.Exploded_Desc_Public_Co_Indicator),TRIM((SALT37.StrType)le.Exploded_Desc_Stock_Exchange),TRIM((SALT37.StrType)le.Exploded_Desc_Telemarketablity_Score),TRIM((SALT37.StrType)le.Exploded_Desc_Telemarketablity_Total_Indicator),TRIM((SALT37.StrType)le.Exploded_Desc_Telemarketablity_Total_Score),TRIM((SALT37.StrType)le.Exploded_Desc_Government1057_Entity),TRIM((SALT37.StrType)le.Exploded_Desc_Merchant_Type),TRIM((SALT37.StrType)le.Exploded_Desc_Busstatcd),TRIM((SALT37.StrType)le.Exploded_Desc_CMSA),TRIM((SALT37.StrType)le.Exploded_Desc_Corpamountcd),TRIM((SALT37.StrType)le.Exploded_Desc_Corpamountprec),TRIM((SALT37.StrType)le.Exploded_Desc_Corpamounttp),TRIM((SALT37.StrType)le.Exploded_Desc_Corpempcd),TRIM((SALT37.StrType)le.Exploded_Desc_Ctrytelcd),TRIM((SALT37.StrType)le.NormAddress_Type),TRIM((SALT37.StrType)le.Norm_Address),TRIM((SALT37.StrType)le.Norm_City),TRIM((SALT37.StrType)le.Norm_State),TRIM((SALT37.StrType)le.Norm_StateC2),TRIM((SALT37.StrType)le.Norm_Zip),TRIM((SALT37.StrType)le.Norm_Zip4),TRIM((SALT37.StrType)le.Norm_Lat),TRIM((SALT37.StrType)le.Norm_Lon),TRIM((SALT37.StrType)le.Norm_Geoprec),TRIM((SALT37.StrType)le.Norm_Region),TRIM((SALT37.StrType)le.Norm_Ctryisocd),TRIM((SALT37.StrType)le.Norm_Ctrynum),TRIM((SALT37.StrType)le.Norm_Ctryname),TRIM((SALT37.StrType)le.clean_company_name),TRIM((SALT37.StrType)le.clean_phone),TRIM((SALT37.StrType)le.clean_secondary_phone),TRIM((SALT37.StrType)le.prim_range),TRIM((SALT37.StrType)le.predir),TRIM((SALT37.StrType)le.prim_name),TRIM((SALT37.StrType)le.addr_suffix),TRIM((SALT37.StrType)le.postdir),TRIM((SALT37.StrType)le.unit_desig),TRIM((SALT37.StrType)le.sec_range),TRIM((SALT37.StrType)le.p_city_name),TRIM((SALT37.StrType)le.v_city_name),TRIM((SALT37.StrType)le.st),TRIM((SALT37.StrType)le.cart),TRIM((SALT37.StrType)le.cr_sort_sz)));
  END;
SHARED Pairs0 := NORMALIZE(ENTH(h,Config.CorrelateSampleSize),265*265,IntoP(LEFT,COUNTER))(FldNo1<FldNo2);
SHARED FldIds := DATASET([{1,'dt_first_seen'}
      ,{2,'dt_last_seen'}
      ,{3,'dt_vendor_first_reported'}
      ,{4,'dt_vendor_last_reported'}
      ,{5,'dt_effective_first'}
      ,{6,'dt_effective_last'}
      ,{7,'process_date'}
      ,{8,'dotid'}
      ,{9,'dotscore'}
      ,{10,'dotweight'}
      ,{11,'empid'}
      ,{12,'empscore'}
      ,{13,'empweight'}
      ,{14,'powid'}
      ,{15,'powscore'}
      ,{16,'powweight'}
      ,{17,'proxid'}
      ,{18,'proxscore'}
      ,{19,'proxweight'}
      ,{20,'selescore'}
      ,{21,'seleweight'}
      ,{22,'orgid'}
      ,{23,'orgscore'}
      ,{24,'orgweight'}
      ,{25,'ultid'}
      ,{26,'ultscore'}
      ,{27,'ultweight'}
      ,{28,'record_type'}
      ,{29,'EFX_ID'}
      ,{30,'EFX_NAME'}
      ,{31,'EFX_LEGAL_NAME'}
      ,{32,'EFX_ADDRESS'}
      ,{33,'EFX_CITY'}
      ,{34,'EFX_STATE'}
      ,{35,'EFX_STATEC'}
      ,{36,'EFX_ZIPCODE'}
      ,{37,'EFX_ZIP4'}
      ,{38,'EFX_LAT'}
      ,{39,'EFX_LON'}
      ,{40,'EFX_GEOPREC'}
      ,{41,'EFX_REGION'}
      ,{42,'EFX_CTRYISOCD'}
      ,{43,'EFX_CTRYNUM'}
      ,{44,'EFX_CTRYNAME'}
      ,{45,'EFX_COUNTYNM'}
      ,{46,'EFX_COUNTY'}
      ,{47,'EFX_CMSA'}
      ,{48,'EFX_CMSADESC'}
      ,{49,'EFX_SOHO'}
      ,{50,'EFX_BIZ'}
      ,{51,'EFX_RES'}
      ,{52,'EFX_CMRA'}
      ,{53,'EFX_CONGRESS'}
      ,{54,'EFX_SECADR'}
      ,{55,'EFX_SECCTY'}
      ,{56,'EFX_SECSTAT'}
      ,{57,'EFX_STATEC2'}
      ,{58,'EFX_SECZIP'}
      ,{59,'EFX_SECZIP4'}
      ,{60,'EFX_SECLAT'}
      ,{61,'EFX_SECLON'}
      ,{62,'EFX_SECGEOPREC'}
      ,{63,'EFX_SECREGION'}
      ,{64,'EFX_SECCTRYISOCD'}
      ,{65,'EFX_SECCTRYNUM'}
      ,{66,'EFX_SECCTRYNAME'}
      ,{67,'EFX_CTRYTELCD'}
      ,{68,'EFX_PHONE'}
      ,{69,'EFX_FAXPHONE'}
      ,{70,'EFX_BUSSTAT'}
      ,{71,'EFX_BUSSTATCD'}
      ,{72,'EFX_WEB'}
      ,{73,'EFX_YREST'}
      ,{74,'EFX_CORPEMPCNT'}
      ,{75,'EFX_LOCEMPCNT'}
      ,{76,'EFX_CORPEMPCD'}
      ,{77,'EFX_LOCEMPCD'}
      ,{78,'EFX_CORPAMOUNT'}
      ,{79,'EFX_CORPAMOUNTCD'}
      ,{80,'EFX_CORPAMOUNTTP'}
      ,{81,'EFX_CORPAMOUNTPREC'}
      ,{82,'EFX_LOCAMOUNT'}
      ,{83,'EFX_LOCAMOUNTCD'}
      ,{84,'EFX_LOCAMOUNTTP'}
      ,{85,'EFX_LOCAMOUNTPREC'}
      ,{86,'EFX_PUBLIC'}
      ,{87,'EFX_STKEXC'}
      ,{88,'EFX_TCKSYM'}
      ,{89,'EFX_PRIMSIC'}
      ,{90,'EFX_SECSIC1'}
      ,{91,'EFX_SECSIC2'}
      ,{92,'EFX_SECSIC3'}
      ,{93,'EFX_SECSIC4'}
      ,{94,'EFX_PRIMSICDESC'}
      ,{95,'EFX_SECSICDESC1'}
      ,{96,'EFX_SECSICDESC2'}
      ,{97,'EFX_SECSICDESC3'}
      ,{98,'EFX_SECSICDESC4'}
      ,{99,'EFX_PRIMNAICSCODE'}
      ,{100,'EFX_SECNAICS1'}
      ,{101,'EFX_SECNAICS2'}
      ,{102,'EFX_SECNAICS3'}
      ,{103,'EFX_SECNAICS4'}
      ,{104,'EFX_PRIMNAICSDESC'}
      ,{105,'EFX_SECNAICSDESC1'}
      ,{106,'EFX_SECNAICSDESC2'}
      ,{107,'EFX_SECNAICSDESC3'}
      ,{108,'EFX_SECNAICSDESC4'}
      ,{109,'EFX_DEAD'}
      ,{110,'EFX_DEADDT'}
      ,{111,'EFX_MRKT_TELEVER'}
      ,{112,'EFX_MRKT_TELESCORE'}
      ,{113,'EFX_MRKT_TOTALSCORE'}
      ,{114,'EFX_MRKT_TOTALIND'}
      ,{115,'EFX_MRKT_VACANT'}
      ,{116,'EFX_MRKT_SEASONAL'}
      ,{117,'EFX_MBE'}
      ,{118,'EFX_WBE'}
      ,{119,'EFX_MWBE'}
      ,{120,'EFX_SDB'}
      ,{121,'EFX_HUBZONE'}
      ,{122,'EFX_DBE'}
      ,{123,'EFX_VET'}
      ,{124,'EFX_DVET'}
      ,{125,'EFX_8a'}
      ,{126,'EFX_8aEXPDT'}
      ,{127,'EFX_DIS'}
      ,{128,'EFX_SBE'}
      ,{129,'EFX_BUSSIZE'}
      ,{130,'EFX_LBE'}
      ,{131,'EFX_GOV'}
      ,{132,'EFX_FGOV'}
      ,{133,'EFX_GOV1057'}
      ,{134,'EFX_NONPROFIT'}
      ,{135,'EFX_MERCTYPE'}
      ,{136,'EFX_HBCU'}
      ,{137,'EFX_GAYLESBIAN'}
      ,{138,'EFX_WSBE'}
      ,{139,'EFX_VSBE'}
      ,{140,'EFX_DVSBE'}
      ,{141,'EFX_MWBESTATUS'}
      ,{142,'EFX_NMSDC'}
      ,{143,'EFX_WBENC'}
      ,{144,'EFX_CA_PUC'}
      ,{145,'EFX_TX_HUB'}
      ,{146,'EFX_TX_HUBCERTNUM'}
      ,{147,'EFX_GSAX'}
      ,{148,'EFX_CALTRANS'}
      ,{149,'EFX_EDU'}
      ,{150,'EFX_MI'}
      ,{151,'EFX_ANC'}
      ,{152,'AT_CERT1'}
      ,{153,'AT_CERT2'}
      ,{154,'AT_CERT3'}
      ,{155,'AT_CERT4'}
      ,{156,'AT_CERT5'}
      ,{157,'AT_CERT6'}
      ,{158,'AT_CERT7'}
      ,{159,'AT_CERT8'}
      ,{160,'AT_CERT9'}
      ,{161,'AT_CERT10'}
      ,{162,'AT_CERTDESC1'}
      ,{163,'AT_CERTDESC2'}
      ,{164,'AT_CERTDESC3'}
      ,{165,'AT_CERTDESC4'}
      ,{166,'AT_CERTDESC5'}
      ,{167,'AT_CERTDESC6'}
      ,{168,'AT_CERTDESC7'}
      ,{169,'AT_CERTDESC8'}
      ,{170,'AT_CERTDESC9'}
      ,{171,'AT_CERTDESC10'}
      ,{172,'AT_CERTSRC1'}
      ,{173,'AT_CERTSRC2'}
      ,{174,'AT_CERTSRC3'}
      ,{175,'AT_CERTSRC4'}
      ,{176,'AT_CERTSRC5'}
      ,{177,'AT_CERTSRC6'}
      ,{178,'AT_CERTSRC7'}
      ,{179,'AT_CERTSRC8'}
      ,{180,'AT_CERTSRC9'}
      ,{181,'AT_CERTSRC10'}
      ,{182,'AT_CERTLEV1'}
      ,{183,'AT_CERTLEV2'}
      ,{184,'AT_CERTLEV3'}
      ,{185,'AT_CERTLEV4'}
      ,{186,'AT_CERTLEV5'}
      ,{187,'AT_CERTLEV6'}
      ,{188,'AT_CERTLEV7'}
      ,{189,'AT_CERTLEV8'}
      ,{190,'AT_CERTLEV9'}
      ,{191,'AT_CERTLEV10'}
      ,{192,'AT_CERTNUM1'}
      ,{193,'AT_CERTNUM2'}
      ,{194,'AT_CERTNUM3'}
      ,{195,'AT_CERTNUM4'}
      ,{196,'AT_CERTNUM5'}
      ,{197,'AT_CERTNUM6'}
      ,{198,'AT_CERTNUM7'}
      ,{199,'AT_CERTNUM8'}
      ,{200,'AT_CERTNUM9'}
      ,{201,'AT_CERTNUM10'}
      ,{202,'AT_CERTEXP1'}
      ,{203,'AT_CERTEXP2'}
      ,{204,'AT_CERTEXP3'}
      ,{205,'AT_CERTEXP4'}
      ,{206,'AT_CERTEXP5'}
      ,{207,'AT_CERTEXP6'}
      ,{208,'AT_CERTEXP7'}
      ,{209,'AT_CERTEXP8'}
      ,{210,'AT_CERTEXP9'}
      ,{211,'AT_CERTEXP10'}
      ,{212,'EFX_EXTRACT_DATE'}
      ,{213,'EFX_MERCHANT_ID'}
      ,{214,'EFX_PROJECT_ID'}
      ,{215,'EFX_FOREIGN'}
      ,{216,'Record_Update_Refresh_Date'}
      ,{217,'EFX_DATE_CREATED'}
      ,{218,'normCompany_Name'}
      ,{219,'normCompany_Type'}
      ,{220,'Norm_Geo_Precision'}
      ,{221,'Exploded_Desc_Corporate_Amount_Precision'}
      ,{222,'Exploded_Desc_Location_Amount_Precision'}
      ,{223,'Exploded_Desc_Public_Co_Indicator'}
      ,{224,'Exploded_Desc_Stock_Exchange'}
      ,{225,'Exploded_Desc_Telemarketablity_Score'}
      ,{226,'Exploded_Desc_Telemarketablity_Total_Indicator'}
      ,{227,'Exploded_Desc_Telemarketablity_Total_Score'}
      ,{228,'Exploded_Desc_Government1057_Entity'}
      ,{229,'Exploded_Desc_Merchant_Type'}
      ,{230,'Exploded_Desc_Busstatcd'}
      ,{231,'Exploded_Desc_CMSA'}
      ,{232,'Exploded_Desc_Corpamountcd'}
      ,{233,'Exploded_Desc_Corpamountprec'}
      ,{234,'Exploded_Desc_Corpamounttp'}
      ,{235,'Exploded_Desc_Corpempcd'}
      ,{236,'Exploded_Desc_Ctrytelcd'}
      ,{237,'NormAddress_Type'}
      ,{238,'Norm_Address'}
      ,{239,'Norm_City'}
      ,{240,'Norm_State'}
      ,{241,'Norm_StateC2'}
      ,{242,'Norm_Zip'}
      ,{243,'Norm_Zip4'}
      ,{244,'Norm_Lat'}
      ,{245,'Norm_Lon'}
      ,{246,'Norm_Geoprec'}
      ,{247,'Norm_Region'}
      ,{248,'Norm_Ctryisocd'}
      ,{249,'Norm_Ctrynum'}
      ,{250,'Norm_Ctryname'}
      ,{251,'clean_company_name'}
      ,{252,'clean_phone'}
      ,{253,'clean_secondary_phone'}
      ,{254,'prim_range'}
      ,{255,'predir'}
      ,{256,'prim_name'}
      ,{257,'addr_suffix'}
      ,{258,'postdir'}
      ,{259,'unit_desig'}
      ,{260,'sec_range'}
      ,{261,'p_city_name'}
      ,{262,'v_city_name'}
      ,{263,'st'}
      ,{264,'cart'}
      ,{265,'cr_sort_sz'}],SALT37.MAC_Character_Counts.Field_Identification);
EXPORT AllProfiles := SALT37.MAC_Character_Counts.FN_Profile(FldInv0,FldIds);
 
EXPORT SrcProfiles := SALT37.MAC_Character_Counts.Src_Profile(FldInv0,FldIds);
 
EXPORT Correlations := SALT37.MAC_Correlate.Fn_Profile(Pairs0,FldIds);
 
ErrorRecord := RECORD
  UNSIGNED2 FieldNum;
  UNSIGNED1 ErrorNum;
  TYPEOF(h.source) source; // Track errors by source
END;
ErrorRecord NoteErrors(h le,UNSIGNED2 c) := TRANSFORM
  SELF.ErrorNum := CHOOSE(c,
    Fields.InValid_dt_first_seen((SALT37.StrType)le.dt_first_seen),
    Fields.InValid_dt_last_seen((SALT37.StrType)le.dt_last_seen),
    Fields.InValid_dt_vendor_first_reported((SALT37.StrType)le.dt_vendor_first_reported),
    Fields.InValid_dt_vendor_last_reported((SALT37.StrType)le.dt_vendor_last_reported),
    Fields.InValid_dt_effective_first((SALT37.StrType)le.dt_effective_first),
    Fields.InValid_dt_effective_last((SALT37.StrType)le.dt_effective_last),
    Fields.InValid_process_date((SALT37.StrType)le.process_date),
    Fields.InValid_dotid((SALT37.StrType)le.dotid),
    Fields.InValid_dotscore((SALT37.StrType)le.dotscore),
    Fields.InValid_dotweight((SALT37.StrType)le.dotweight),
    Fields.InValid_empid((SALT37.StrType)le.empid),
    Fields.InValid_empscore((SALT37.StrType)le.empscore),
    Fields.InValid_empweight((SALT37.StrType)le.empweight),
    Fields.InValid_powid((SALT37.StrType)le.powid),
    Fields.InValid_powscore((SALT37.StrType)le.powscore),
    Fields.InValid_powweight((SALT37.StrType)le.powweight),
    Fields.InValid_proxid((SALT37.StrType)le.proxid),
    Fields.InValid_proxscore((SALT37.StrType)le.proxscore),
    Fields.InValid_proxweight((SALT37.StrType)le.proxweight),
    Fields.InValid_selescore((SALT37.StrType)le.selescore),
    Fields.InValid_seleweight((SALT37.StrType)le.seleweight),
    Fields.InValid_orgid((SALT37.StrType)le.orgid),
    Fields.InValid_orgscore((SALT37.StrType)le.orgscore),
    Fields.InValid_orgweight((SALT37.StrType)le.orgweight),
    Fields.InValid_ultid((SALT37.StrType)le.ultid),
    Fields.InValid_ultscore((SALT37.StrType)le.ultscore),
    Fields.InValid_ultweight((SALT37.StrType)le.ultweight),
    Fields.InValid_record_type((SALT37.StrType)le.record_type),
    Fields.InValid_EFX_ID((SALT37.StrType)le.EFX_ID),
    Fields.InValid_EFX_NAME((SALT37.StrType)le.EFX_NAME),
    Fields.InValid_EFX_LEGAL_NAME((SALT37.StrType)le.EFX_LEGAL_NAME),
    Fields.InValid_EFX_ADDRESS((SALT37.StrType)le.EFX_ADDRESS),
    Fields.InValid_EFX_CITY((SALT37.StrType)le.EFX_CITY),
    Fields.InValid_EFX_STATE((SALT37.StrType)le.EFX_STATE),
    Fields.InValid_EFX_STATEC((SALT37.StrType)le.EFX_STATEC),
    Fields.InValid_EFX_ZIPCODE((SALT37.StrType)le.EFX_ZIPCODE),
    Fields.InValid_EFX_ZIP4((SALT37.StrType)le.EFX_ZIP4),
    Fields.InValid_EFX_LAT((SALT37.StrType)le.EFX_LAT),
    Fields.InValid_EFX_LON((SALT37.StrType)le.EFX_LON),
    Fields.InValid_EFX_GEOPREC((SALT37.StrType)le.EFX_GEOPREC),
    Fields.InValid_EFX_REGION((SALT37.StrType)le.EFX_REGION),
    Fields.InValid_EFX_CTRYISOCD((SALT37.StrType)le.EFX_CTRYISOCD),
    Fields.InValid_EFX_CTRYNUM((SALT37.StrType)le.EFX_CTRYNUM),
    Fields.InValid_EFX_CTRYNAME((SALT37.StrType)le.EFX_CTRYNAME),
    Fields.InValid_EFX_COUNTYNM((SALT37.StrType)le.EFX_COUNTYNM),
    Fields.InValid_EFX_COUNTY((SALT37.StrType)le.EFX_COUNTY),
    Fields.InValid_EFX_CMSA((SALT37.StrType)le.EFX_CMSA),
    Fields.InValid_EFX_CMSADESC((SALT37.StrType)le.EFX_CMSADESC),
    Fields.InValid_EFX_SOHO((SALT37.StrType)le.EFX_SOHO),
    Fields.InValid_EFX_BIZ((SALT37.StrType)le.EFX_BIZ),
    Fields.InValid_EFX_RES((SALT37.StrType)le.EFX_RES),
    Fields.InValid_EFX_CMRA((SALT37.StrType)le.EFX_CMRA),
    Fields.InValid_EFX_CONGRESS((SALT37.StrType)le.EFX_CONGRESS),
    Fields.InValid_EFX_SECADR((SALT37.StrType)le.EFX_SECADR),
    Fields.InValid_EFX_SECCTY((SALT37.StrType)le.EFX_SECCTY),
    Fields.InValid_EFX_SECSTAT((SALT37.StrType)le.EFX_SECSTAT),
    Fields.InValid_EFX_STATEC2((SALT37.StrType)le.EFX_STATEC2),
    Fields.InValid_EFX_SECZIP((SALT37.StrType)le.EFX_SECZIP),
    Fields.InValid_EFX_SECZIP4((SALT37.StrType)le.EFX_SECZIP4),
    Fields.InValid_EFX_SECLAT((SALT37.StrType)le.EFX_SECLAT),
    Fields.InValid_EFX_SECLON((SALT37.StrType)le.EFX_SECLON),
    Fields.InValid_EFX_SECGEOPREC((SALT37.StrType)le.EFX_SECGEOPREC),
    Fields.InValid_EFX_SECREGION((SALT37.StrType)le.EFX_SECREGION),
    Fields.InValid_EFX_SECCTRYISOCD((SALT37.StrType)le.EFX_SECCTRYISOCD),
    Fields.InValid_EFX_SECCTRYNUM((SALT37.StrType)le.EFX_SECCTRYNUM),
    Fields.InValid_EFX_SECCTRYNAME((SALT37.StrType)le.EFX_SECCTRYNAME),
    Fields.InValid_EFX_CTRYTELCD((SALT37.StrType)le.EFX_CTRYTELCD),
    Fields.InValid_EFX_PHONE((SALT37.StrType)le.EFX_PHONE),
    Fields.InValid_EFX_FAXPHONE((SALT37.StrType)le.EFX_FAXPHONE),
    Fields.InValid_EFX_BUSSTAT((SALT37.StrType)le.EFX_BUSSTAT),
    Fields.InValid_EFX_BUSSTATCD((SALT37.StrType)le.EFX_BUSSTATCD),
    Fields.InValid_EFX_WEB((SALT37.StrType)le.EFX_WEB),
    Fields.InValid_EFX_YREST((SALT37.StrType)le.EFX_YREST),
    Fields.InValid_EFX_CORPEMPCNT((SALT37.StrType)le.EFX_CORPEMPCNT),
    Fields.InValid_EFX_LOCEMPCNT((SALT37.StrType)le.EFX_LOCEMPCNT),
    Fields.InValid_EFX_CORPEMPCD((SALT37.StrType)le.EFX_CORPEMPCD),
    Fields.InValid_EFX_LOCEMPCD((SALT37.StrType)le.EFX_LOCEMPCD),
    Fields.InValid_EFX_CORPAMOUNT((SALT37.StrType)le.EFX_CORPAMOUNT),
    Fields.InValid_EFX_CORPAMOUNTCD((SALT37.StrType)le.EFX_CORPAMOUNTCD),
    Fields.InValid_EFX_CORPAMOUNTTP((SALT37.StrType)le.EFX_CORPAMOUNTTP),
    Fields.InValid_EFX_CORPAMOUNTPREC((SALT37.StrType)le.EFX_CORPAMOUNTPREC),
    Fields.InValid_EFX_LOCAMOUNT((SALT37.StrType)le.EFX_LOCAMOUNT),
    Fields.InValid_EFX_LOCAMOUNTCD((SALT37.StrType)le.EFX_LOCAMOUNTCD),
    Fields.InValid_EFX_LOCAMOUNTTP((SALT37.StrType)le.EFX_LOCAMOUNTTP),
    Fields.InValid_EFX_LOCAMOUNTPREC((SALT37.StrType)le.EFX_LOCAMOUNTPREC),
    Fields.InValid_EFX_PUBLIC((SALT37.StrType)le.EFX_PUBLIC),
    Fields.InValid_EFX_STKEXC((SALT37.StrType)le.EFX_STKEXC),
    Fields.InValid_EFX_TCKSYM((SALT37.StrType)le.EFX_TCKSYM),
    Fields.InValid_EFX_PRIMSIC((SALT37.StrType)le.EFX_PRIMSIC),
    Fields.InValid_EFX_SECSIC1((SALT37.StrType)le.EFX_SECSIC1),
    Fields.InValid_EFX_SECSIC2((SALT37.StrType)le.EFX_SECSIC2),
    Fields.InValid_EFX_SECSIC3((SALT37.StrType)le.EFX_SECSIC3),
    Fields.InValid_EFX_SECSIC4((SALT37.StrType)le.EFX_SECSIC4),
    Fields.InValid_EFX_PRIMSICDESC((SALT37.StrType)le.EFX_PRIMSICDESC),
    Fields.InValid_EFX_SECSICDESC1((SALT37.StrType)le.EFX_SECSICDESC1),
    Fields.InValid_EFX_SECSICDESC2((SALT37.StrType)le.EFX_SECSICDESC2),
    Fields.InValid_EFX_SECSICDESC3((SALT37.StrType)le.EFX_SECSICDESC3),
    Fields.InValid_EFX_SECSICDESC4((SALT37.StrType)le.EFX_SECSICDESC4),
    Fields.InValid_EFX_PRIMNAICSCODE((SALT37.StrType)le.EFX_PRIMNAICSCODE),
    Fields.InValid_EFX_SECNAICS1((SALT37.StrType)le.EFX_SECNAICS1),
    Fields.InValid_EFX_SECNAICS2((SALT37.StrType)le.EFX_SECNAICS2),
    Fields.InValid_EFX_SECNAICS3((SALT37.StrType)le.EFX_SECNAICS3),
    Fields.InValid_EFX_SECNAICS4((SALT37.StrType)le.EFX_SECNAICS4),
    Fields.InValid_EFX_PRIMNAICSDESC((SALT37.StrType)le.EFX_PRIMNAICSDESC),
    Fields.InValid_EFX_SECNAICSDESC1((SALT37.StrType)le.EFX_SECNAICSDESC1),
    Fields.InValid_EFX_SECNAICSDESC2((SALT37.StrType)le.EFX_SECNAICSDESC2),
    Fields.InValid_EFX_SECNAICSDESC3((SALT37.StrType)le.EFX_SECNAICSDESC3),
    Fields.InValid_EFX_SECNAICSDESC4((SALT37.StrType)le.EFX_SECNAICSDESC4),
    Fields.InValid_EFX_DEAD((SALT37.StrType)le.EFX_DEAD),
    Fields.InValid_EFX_DEADDT((SALT37.StrType)le.EFX_DEADDT),
    Fields.InValid_EFX_MRKT_TELEVER((SALT37.StrType)le.EFX_MRKT_TELEVER),
    Fields.InValid_EFX_MRKT_TELESCORE((SALT37.StrType)le.EFX_MRKT_TELESCORE),
    Fields.InValid_EFX_MRKT_TOTALSCORE((SALT37.StrType)le.EFX_MRKT_TOTALSCORE),
    Fields.InValid_EFX_MRKT_TOTALIND((SALT37.StrType)le.EFX_MRKT_TOTALIND),
    Fields.InValid_EFX_MRKT_VACANT((SALT37.StrType)le.EFX_MRKT_VACANT),
    Fields.InValid_EFX_MRKT_SEASONAL((SALT37.StrType)le.EFX_MRKT_SEASONAL),
    Fields.InValid_EFX_MBE((SALT37.StrType)le.EFX_MBE),
    Fields.InValid_EFX_WBE((SALT37.StrType)le.EFX_WBE),
    Fields.InValid_EFX_MWBE((SALT37.StrType)le.EFX_MWBE),
    Fields.InValid_EFX_SDB((SALT37.StrType)le.EFX_SDB),
    Fields.InValid_EFX_HUBZONE((SALT37.StrType)le.EFX_HUBZONE),
    Fields.InValid_EFX_DBE((SALT37.StrType)le.EFX_DBE),
    Fields.InValid_EFX_VET((SALT37.StrType)le.EFX_VET),
    Fields.InValid_EFX_DVET((SALT37.StrType)le.EFX_DVET),
    Fields.InValid_EFX_8a((SALT37.StrType)le.EFX_8a),
    Fields.InValid_EFX_8aEXPDT((SALT37.StrType)le.EFX_8aEXPDT),
    Fields.InValid_EFX_DIS((SALT37.StrType)le.EFX_DIS),
    Fields.InValid_EFX_SBE((SALT37.StrType)le.EFX_SBE),
    Fields.InValid_EFX_BUSSIZE((SALT37.StrType)le.EFX_BUSSIZE),
    Fields.InValid_EFX_LBE((SALT37.StrType)le.EFX_LBE),
    Fields.InValid_EFX_GOV((SALT37.StrType)le.EFX_GOV),
    Fields.InValid_EFX_FGOV((SALT37.StrType)le.EFX_FGOV),
    Fields.InValid_EFX_GOV1057((SALT37.StrType)le.EFX_GOV1057),
    Fields.InValid_EFX_NONPROFIT((SALT37.StrType)le.EFX_NONPROFIT),
    Fields.InValid_EFX_MERCTYPE((SALT37.StrType)le.EFX_MERCTYPE),
    Fields.InValid_EFX_HBCU((SALT37.StrType)le.EFX_HBCU),
    Fields.InValid_EFX_GAYLESBIAN((SALT37.StrType)le.EFX_GAYLESBIAN),
    Fields.InValid_EFX_WSBE((SALT37.StrType)le.EFX_WSBE),
    Fields.InValid_EFX_VSBE((SALT37.StrType)le.EFX_VSBE),
    Fields.InValid_EFX_DVSBE((SALT37.StrType)le.EFX_DVSBE),
    Fields.InValid_EFX_MWBESTATUS((SALT37.StrType)le.EFX_MWBESTATUS),
    Fields.InValid_EFX_NMSDC((SALT37.StrType)le.EFX_NMSDC),
    Fields.InValid_EFX_WBENC((SALT37.StrType)le.EFX_WBENC),
    Fields.InValid_EFX_CA_PUC((SALT37.StrType)le.EFX_CA_PUC),
    Fields.InValid_EFX_TX_HUB((SALT37.StrType)le.EFX_TX_HUB),
    Fields.InValid_EFX_TX_HUBCERTNUM((SALT37.StrType)le.EFX_TX_HUBCERTNUM),
    Fields.InValid_EFX_GSAX((SALT37.StrType)le.EFX_GSAX),
    Fields.InValid_EFX_CALTRANS((SALT37.StrType)le.EFX_CALTRANS),
    Fields.InValid_EFX_EDU((SALT37.StrType)le.EFX_EDU),
    Fields.InValid_EFX_MI((SALT37.StrType)le.EFX_MI),
    Fields.InValid_EFX_ANC((SALT37.StrType)le.EFX_ANC),
    Fields.InValid_AT_CERT1((SALT37.StrType)le.AT_CERT1),
    Fields.InValid_AT_CERT2((SALT37.StrType)le.AT_CERT2),
    Fields.InValid_AT_CERT3((SALT37.StrType)le.AT_CERT3),
    Fields.InValid_AT_CERT4((SALT37.StrType)le.AT_CERT4),
    Fields.InValid_AT_CERT5((SALT37.StrType)le.AT_CERT5),
    Fields.InValid_AT_CERT6((SALT37.StrType)le.AT_CERT6),
    Fields.InValid_AT_CERT7((SALT37.StrType)le.AT_CERT7),
    Fields.InValid_AT_CERT8((SALT37.StrType)le.AT_CERT8),
    Fields.InValid_AT_CERT9((SALT37.StrType)le.AT_CERT9),
    Fields.InValid_AT_CERT10((SALT37.StrType)le.AT_CERT10),
    Fields.InValid_AT_CERTDESC1((SALT37.StrType)le.AT_CERTDESC1),
    Fields.InValid_AT_CERTDESC2((SALT37.StrType)le.AT_CERTDESC2),
    Fields.InValid_AT_CERTDESC3((SALT37.StrType)le.AT_CERTDESC3),
    Fields.InValid_AT_CERTDESC4((SALT37.StrType)le.AT_CERTDESC4),
    Fields.InValid_AT_CERTDESC5((SALT37.StrType)le.AT_CERTDESC5),
    Fields.InValid_AT_CERTDESC6((SALT37.StrType)le.AT_CERTDESC6),
    Fields.InValid_AT_CERTDESC7((SALT37.StrType)le.AT_CERTDESC7),
    Fields.InValid_AT_CERTDESC8((SALT37.StrType)le.AT_CERTDESC8),
    Fields.InValid_AT_CERTDESC9((SALT37.StrType)le.AT_CERTDESC9),
    Fields.InValid_AT_CERTDESC10((SALT37.StrType)le.AT_CERTDESC10),
    Fields.InValid_AT_CERTSRC1((SALT37.StrType)le.AT_CERTSRC1),
    Fields.InValid_AT_CERTSRC2((SALT37.StrType)le.AT_CERTSRC2),
    Fields.InValid_AT_CERTSRC3((SALT37.StrType)le.AT_CERTSRC3),
    Fields.InValid_AT_CERTSRC4((SALT37.StrType)le.AT_CERTSRC4),
    Fields.InValid_AT_CERTSRC5((SALT37.StrType)le.AT_CERTSRC5),
    Fields.InValid_AT_CERTSRC6((SALT37.StrType)le.AT_CERTSRC6),
    Fields.InValid_AT_CERTSRC7((SALT37.StrType)le.AT_CERTSRC7),
    Fields.InValid_AT_CERTSRC8((SALT37.StrType)le.AT_CERTSRC8),
    Fields.InValid_AT_CERTSRC9((SALT37.StrType)le.AT_CERTSRC9),
    Fields.InValid_AT_CERTSRC10((SALT37.StrType)le.AT_CERTSRC10),
    Fields.InValid_AT_CERTLEV1((SALT37.StrType)le.AT_CERTLEV1),
    Fields.InValid_AT_CERTLEV2((SALT37.StrType)le.AT_CERTLEV2),
    Fields.InValid_AT_CERTLEV3((SALT37.StrType)le.AT_CERTLEV3),
    Fields.InValid_AT_CERTLEV4((SALT37.StrType)le.AT_CERTLEV4),
    Fields.InValid_AT_CERTLEV5((SALT37.StrType)le.AT_CERTLEV5),
    Fields.InValid_AT_CERTLEV6((SALT37.StrType)le.AT_CERTLEV6),
    Fields.InValid_AT_CERTLEV7((SALT37.StrType)le.AT_CERTLEV7),
    Fields.InValid_AT_CERTLEV8((SALT37.StrType)le.AT_CERTLEV8),
    Fields.InValid_AT_CERTLEV9((SALT37.StrType)le.AT_CERTLEV9),
    Fields.InValid_AT_CERTLEV10((SALT37.StrType)le.AT_CERTLEV10),
    Fields.InValid_AT_CERTNUM1((SALT37.StrType)le.AT_CERTNUM1),
    Fields.InValid_AT_CERTNUM2((SALT37.StrType)le.AT_CERTNUM2),
    Fields.InValid_AT_CERTNUM3((SALT37.StrType)le.AT_CERTNUM3),
    Fields.InValid_AT_CERTNUM4((SALT37.StrType)le.AT_CERTNUM4),
    Fields.InValid_AT_CERTNUM5((SALT37.StrType)le.AT_CERTNUM5),
    Fields.InValid_AT_CERTNUM6((SALT37.StrType)le.AT_CERTNUM6),
    Fields.InValid_AT_CERTNUM7((SALT37.StrType)le.AT_CERTNUM7),
    Fields.InValid_AT_CERTNUM8((SALT37.StrType)le.AT_CERTNUM8),
    Fields.InValid_AT_CERTNUM9((SALT37.StrType)le.AT_CERTNUM9),
    Fields.InValid_AT_CERTNUM10((SALT37.StrType)le.AT_CERTNUM10),
    Fields.InValid_AT_CERTEXP1((SALT37.StrType)le.AT_CERTEXP1),
    Fields.InValid_AT_CERTEXP2((SALT37.StrType)le.AT_CERTEXP2),
    Fields.InValid_AT_CERTEXP3((SALT37.StrType)le.AT_CERTEXP3),
    Fields.InValid_AT_CERTEXP4((SALT37.StrType)le.AT_CERTEXP4),
    Fields.InValid_AT_CERTEXP5((SALT37.StrType)le.AT_CERTEXP5),
    Fields.InValid_AT_CERTEXP6((SALT37.StrType)le.AT_CERTEXP6),
    Fields.InValid_AT_CERTEXP7((SALT37.StrType)le.AT_CERTEXP7),
    Fields.InValid_AT_CERTEXP8((SALT37.StrType)le.AT_CERTEXP8),
    Fields.InValid_AT_CERTEXP9((SALT37.StrType)le.AT_CERTEXP9),
    Fields.InValid_AT_CERTEXP10((SALT37.StrType)le.AT_CERTEXP10),
    Fields.InValid_EFX_EXTRACT_DATE((SALT37.StrType)le.EFX_EXTRACT_DATE),
    Fields.InValid_EFX_MERCHANT_ID((SALT37.StrType)le.EFX_MERCHANT_ID),
    Fields.InValid_EFX_PROJECT_ID((SALT37.StrType)le.EFX_PROJECT_ID),
    Fields.InValid_EFX_FOREIGN((SALT37.StrType)le.EFX_FOREIGN),
    Fields.InValid_Record_Update_Refresh_Date((SALT37.StrType)le.Record_Update_Refresh_Date),
    Fields.InValid_EFX_DATE_CREATED((SALT37.StrType)le.EFX_DATE_CREATED),
    Fields.InValid_normCompany_Name((SALT37.StrType)le.normCompany_Name),
    Fields.InValid_normCompany_Type((SALT37.StrType)le.normCompany_Type),
    Fields.InValid_Norm_Geo_Precision((SALT37.StrType)le.Norm_Geo_Precision),
    Fields.InValid_Exploded_Desc_Corporate_Amount_Precision((SALT37.StrType)le.Exploded_Desc_Corporate_Amount_Precision),
    Fields.InValid_Exploded_Desc_Location_Amount_Precision((SALT37.StrType)le.Exploded_Desc_Location_Amount_Precision),
    Fields.InValid_Exploded_Desc_Public_Co_Indicator((SALT37.StrType)le.Exploded_Desc_Public_Co_Indicator),
    Fields.InValid_Exploded_Desc_Stock_Exchange((SALT37.StrType)le.Exploded_Desc_Stock_Exchange),
    Fields.InValid_Exploded_Desc_Telemarketablity_Score((SALT37.StrType)le.Exploded_Desc_Telemarketablity_Score),
    Fields.InValid_Exploded_Desc_Telemarketablity_Total_Indicator((SALT37.StrType)le.Exploded_Desc_Telemarketablity_Total_Indicator),
    Fields.InValid_Exploded_Desc_Telemarketablity_Total_Score((SALT37.StrType)le.Exploded_Desc_Telemarketablity_Total_Score),
    Fields.InValid_Exploded_Desc_Government1057_Entity((SALT37.StrType)le.Exploded_Desc_Government1057_Entity),
    Fields.InValid_Exploded_Desc_Merchant_Type((SALT37.StrType)le.Exploded_Desc_Merchant_Type),
    Fields.InValid_Exploded_Desc_Busstatcd((SALT37.StrType)le.Exploded_Desc_Busstatcd),
    Fields.InValid_Exploded_Desc_CMSA((SALT37.StrType)le.Exploded_Desc_CMSA),
    Fields.InValid_Exploded_Desc_Corpamountcd((SALT37.StrType)le.Exploded_Desc_Corpamountcd),
    Fields.InValid_Exploded_Desc_Corpamountprec((SALT37.StrType)le.Exploded_Desc_Corpamountprec),
    Fields.InValid_Exploded_Desc_Corpamounttp((SALT37.StrType)le.Exploded_Desc_Corpamounttp),
    Fields.InValid_Exploded_Desc_Corpempcd((SALT37.StrType)le.Exploded_Desc_Corpempcd),
    Fields.InValid_Exploded_Desc_Ctrytelcd((SALT37.StrType)le.Exploded_Desc_Ctrytelcd),
    Fields.InValid_NormAddress_Type((SALT37.StrType)le.NormAddress_Type),
    Fields.InValid_Norm_Address((SALT37.StrType)le.Norm_Address),
    Fields.InValid_Norm_City((SALT37.StrType)le.Norm_City),
    Fields.InValid_Norm_State((SALT37.StrType)le.Norm_State),
    Fields.InValid_Norm_StateC2((SALT37.StrType)le.Norm_StateC2),
    Fields.InValid_Norm_Zip((SALT37.StrType)le.Norm_Zip),
    Fields.InValid_Norm_Zip4((SALT37.StrType)le.Norm_Zip4),
    Fields.InValid_Norm_Lat((SALT37.StrType)le.Norm_Lat),
    Fields.InValid_Norm_Lon((SALT37.StrType)le.Norm_Lon),
    Fields.InValid_Norm_Geoprec((SALT37.StrType)le.Norm_Geoprec),
    Fields.InValid_Norm_Region((SALT37.StrType)le.Norm_Region),
    Fields.InValid_Norm_Ctryisocd((SALT37.StrType)le.Norm_Ctryisocd),
    Fields.InValid_Norm_Ctrynum((SALT37.StrType)le.Norm_Ctrynum),
    Fields.InValid_Norm_Ctryname((SALT37.StrType)le.Norm_Ctryname),
    Fields.InValid_clean_company_name((SALT37.StrType)le.clean_company_name),
    Fields.InValid_clean_phone((SALT37.StrType)le.clean_phone),
    Fields.InValid_clean_secondary_phone((SALT37.StrType)le.clean_secondary_phone),
    Fields.InValid_prim_range((SALT37.StrType)le.prim_range),
    Fields.InValid_predir((SALT37.StrType)le.predir),
    Fields.InValid_prim_name((SALT37.StrType)le.prim_name),
    Fields.InValid_addr_suffix((SALT37.StrType)le.addr_suffix),
    Fields.InValid_postdir((SALT37.StrType)le.postdir),
    Fields.InValid_unit_desig((SALT37.StrType)le.unit_desig),
    Fields.InValid_sec_range((SALT37.StrType)le.sec_range),
    Fields.InValid_p_city_name((SALT37.StrType)le.p_city_name),
    Fields.InValid_v_city_name((SALT37.StrType)le.v_city_name),
    Fields.InValid_st((SALT37.StrType)le.st),
    Fields.InValid_cart((SALT37.StrType)le.cart),
    Fields.InValid_cr_sort_sz((SALT37.StrType)le.cr_sort_sz),
    0);
  SELF.FieldNum := IF(SELF.ErrorNum=0,SKIP,c); // Bail early to avoid creating record
  SELF.source := le.source;
END;
Errors := NORMALIZE(h,265,NoteErrors(LEFT,COUNTER));
ErrorRecordsTotals := RECORD
  Errors.FieldNum;
  Errors.ErrorNum;
  UNSIGNED Cnt := COUNT(GROUP);
  Errors.source;
END;
TotalErrors := TABLE(Errors,ErrorRecordsTotals,FieldNum,ErrorNum,source,FEW);
PrettyErrorTotals := RECORD
  TotalErrors.source;
  FieldNme := Fields.FieldName(TotalErrors.FieldNum);
  FieldType := CHOOSE(TotalErrors.FieldNum,'Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown');
  ErrorMessage := CHOOSE(TotalErrors.FieldNum,Fields.InValidMessage_dt_first_seen(TotalErrors.ErrorNum),Fields.InValidMessage_dt_last_seen(TotalErrors.ErrorNum),Fields.InValidMessage_dt_vendor_first_reported(TotalErrors.ErrorNum),Fields.InValidMessage_dt_vendor_last_reported(TotalErrors.ErrorNum),Fields.InValidMessage_dt_effective_first(TotalErrors.ErrorNum),Fields.InValidMessage_dt_effective_last(TotalErrors.ErrorNum),Fields.InValidMessage_process_date(TotalErrors.ErrorNum),Fields.InValidMessage_dotid(TotalErrors.ErrorNum),Fields.InValidMessage_dotscore(TotalErrors.ErrorNum),Fields.InValidMessage_dotweight(TotalErrors.ErrorNum),Fields.InValidMessage_empid(TotalErrors.ErrorNum),Fields.InValidMessage_empscore(TotalErrors.ErrorNum),Fields.InValidMessage_empweight(TotalErrors.ErrorNum),Fields.InValidMessage_powid(TotalErrors.ErrorNum),Fields.InValidMessage_powscore(TotalErrors.ErrorNum),Fields.InValidMessage_powweight(TotalErrors.ErrorNum),Fields.InValidMessage_proxid(TotalErrors.ErrorNum),Fields.InValidMessage_proxscore(TotalErrors.ErrorNum),Fields.InValidMessage_proxweight(TotalErrors.ErrorNum),Fields.InValidMessage_selescore(TotalErrors.ErrorNum),Fields.InValidMessage_seleweight(TotalErrors.ErrorNum),Fields.InValidMessage_orgid(TotalErrors.ErrorNum),Fields.InValidMessage_orgscore(TotalErrors.ErrorNum),Fields.InValidMessage_orgweight(TotalErrors.ErrorNum),Fields.InValidMessage_ultid(TotalErrors.ErrorNum),Fields.InValidMessage_ultscore(TotalErrors.ErrorNum),Fields.InValidMessage_ultweight(TotalErrors.ErrorNum),Fields.InValidMessage_record_type(TotalErrors.ErrorNum),Fields.InValidMessage_EFX_ID(TotalErrors.ErrorNum),Fields.InValidMessage_EFX_NAME(TotalErrors.ErrorNum),Fields.InValidMessage_EFX_LEGAL_NAME(TotalErrors.ErrorNum),Fields.InValidMessage_EFX_ADDRESS(TotalErrors.ErrorNum),Fields.InValidMessage_EFX_CITY(TotalErrors.ErrorNum),Fields.InValidMessage_EFX_STATE(TotalErrors.ErrorNum),Fields.InValidMessage_EFX_STATEC(TotalErrors.ErrorNum),Fields.InValidMessage_EFX_ZIPCODE(TotalErrors.ErrorNum),Fields.InValidMessage_EFX_ZIP4(TotalErrors.ErrorNum),Fields.InValidMessage_EFX_LAT(TotalErrors.ErrorNum),Fields.InValidMessage_EFX_LON(TotalErrors.ErrorNum),Fields.InValidMessage_EFX_GEOPREC(TotalErrors.ErrorNum),Fields.InValidMessage_EFX_REGION(TotalErrors.ErrorNum),Fields.InValidMessage_EFX_CTRYISOCD(TotalErrors.ErrorNum),Fields.InValidMessage_EFX_CTRYNUM(TotalErrors.ErrorNum),Fields.InValidMessage_EFX_CTRYNAME(TotalErrors.ErrorNum),Fields.InValidMessage_EFX_COUNTYNM(TotalErrors.ErrorNum),Fields.InValidMessage_EFX_COUNTY(TotalErrors.ErrorNum),Fields.InValidMessage_EFX_CMSA(TotalErrors.ErrorNum),Fields.InValidMessage_EFX_CMSADESC(TotalErrors.ErrorNum),Fields.InValidMessage_EFX_SOHO(TotalErrors.ErrorNum),Fields.InValidMessage_EFX_BIZ(TotalErrors.ErrorNum),Fields.InValidMessage_EFX_RES(TotalErrors.ErrorNum),Fields.InValidMessage_EFX_CMRA(TotalErrors.ErrorNum),Fields.InValidMessage_EFX_CONGRESS(TotalErrors.ErrorNum),Fields.InValidMessage_EFX_SECADR(TotalErrors.ErrorNum),Fields.InValidMessage_EFX_SECCTY(TotalErrors.ErrorNum),Fields.InValidMessage_EFX_SECSTAT(TotalErrors.ErrorNum),Fields.InValidMessage_EFX_STATEC2(TotalErrors.ErrorNum),Fields.InValidMessage_EFX_SECZIP(TotalErrors.ErrorNum),Fields.InValidMessage_EFX_SECZIP4(TotalErrors.ErrorNum),Fields.InValidMessage_EFX_SECLAT(TotalErrors.ErrorNum),Fields.InValidMessage_EFX_SECLON(TotalErrors.ErrorNum),Fields.InValidMessage_EFX_SECGEOPREC(TotalErrors.ErrorNum),Fields.InValidMessage_EFX_SECREGION(TotalErrors.ErrorNum),Fields.InValidMessage_EFX_SECCTRYISOCD(TotalErrors.ErrorNum),Fields.InValidMessage_EFX_SECCTRYNUM(TotalErrors.ErrorNum),Fields.InValidMessage_EFX_SECCTRYNAME(TotalErrors.ErrorNum),Fields.InValidMessage_EFX_CTRYTELCD(TotalErrors.ErrorNum),Fields.InValidMessage_EFX_PHONE(TotalErrors.ErrorNum),Fields.InValidMessage_EFX_FAXPHONE(TotalErrors.ErrorNum),Fields.InValidMessage_EFX_BUSSTAT(TotalErrors.ErrorNum),Fields.InValidMessage_EFX_BUSSTATCD(TotalErrors.ErrorNum),Fields.InValidMessage_EFX_WEB(TotalErrors.ErrorNum),Fields.InValidMessage_EFX_YREST(TotalErrors.ErrorNum),Fields.InValidMessage_EFX_CORPEMPCNT(TotalErrors.ErrorNum),Fields.InValidMessage_EFX_LOCEMPCNT(TotalErrors.ErrorNum),Fields.InValidMessage_EFX_CORPEMPCD(TotalErrors.ErrorNum),Fields.InValidMessage_EFX_LOCEMPCD(TotalErrors.ErrorNum),Fields.InValidMessage_EFX_CORPAMOUNT(TotalErrors.ErrorNum),Fields.InValidMessage_EFX_CORPAMOUNTCD(TotalErrors.ErrorNum),Fields.InValidMessage_EFX_CORPAMOUNTTP(TotalErrors.ErrorNum),Fields.InValidMessage_EFX_CORPAMOUNTPREC(TotalErrors.ErrorNum),Fields.InValidMessage_EFX_LOCAMOUNT(TotalErrors.ErrorNum),Fields.InValidMessage_EFX_LOCAMOUNTCD(TotalErrors.ErrorNum),Fields.InValidMessage_EFX_LOCAMOUNTTP(TotalErrors.ErrorNum),Fields.InValidMessage_EFX_LOCAMOUNTPREC(TotalErrors.ErrorNum),Fields.InValidMessage_EFX_PUBLIC(TotalErrors.ErrorNum),Fields.InValidMessage_EFX_STKEXC(TotalErrors.ErrorNum),Fields.InValidMessage_EFX_TCKSYM(TotalErrors.ErrorNum),Fields.InValidMessage_EFX_PRIMSIC(TotalErrors.ErrorNum),Fields.InValidMessage_EFX_SECSIC1(TotalErrors.ErrorNum),Fields.InValidMessage_EFX_SECSIC2(TotalErrors.ErrorNum),Fields.InValidMessage_EFX_SECSIC3(TotalErrors.ErrorNum),Fields.InValidMessage_EFX_SECSIC4(TotalErrors.ErrorNum),Fields.InValidMessage_EFX_PRIMSICDESC(TotalErrors.ErrorNum),Fields.InValidMessage_EFX_SECSICDESC1(TotalErrors.ErrorNum),Fields.InValidMessage_EFX_SECSICDESC2(TotalErrors.ErrorNum),Fields.InValidMessage_EFX_SECSICDESC3(TotalErrors.ErrorNum),Fields.InValidMessage_EFX_SECSICDESC4(TotalErrors.ErrorNum),Fields.InValidMessage_EFX_PRIMNAICSCODE(TotalErrors.ErrorNum),Fields.InValidMessage_EFX_SECNAICS1(TotalErrors.ErrorNum),Fields.InValidMessage_EFX_SECNAICS2(TotalErrors.ErrorNum),Fields.InValidMessage_EFX_SECNAICS3(TotalErrors.ErrorNum),Fields.InValidMessage_EFX_SECNAICS4(TotalErrors.ErrorNum),Fields.InValidMessage_EFX_PRIMNAICSDESC(TotalErrors.ErrorNum),Fields.InValidMessage_EFX_SECNAICSDESC1(TotalErrors.ErrorNum),Fields.InValidMessage_EFX_SECNAICSDESC2(TotalErrors.ErrorNum),Fields.InValidMessage_EFX_SECNAICSDESC3(TotalErrors.ErrorNum),Fields.InValidMessage_EFX_SECNAICSDESC4(TotalErrors.ErrorNum),Fields.InValidMessage_EFX_DEAD(TotalErrors.ErrorNum),Fields.InValidMessage_EFX_DEADDT(TotalErrors.ErrorNum),Fields.InValidMessage_EFX_MRKT_TELEVER(TotalErrors.ErrorNum),Fields.InValidMessage_EFX_MRKT_TELESCORE(TotalErrors.ErrorNum),Fields.InValidMessage_EFX_MRKT_TOTALSCORE(TotalErrors.ErrorNum),Fields.InValidMessage_EFX_MRKT_TOTALIND(TotalErrors.ErrorNum),Fields.InValidMessage_EFX_MRKT_VACANT(TotalErrors.ErrorNum),Fields.InValidMessage_EFX_MRKT_SEASONAL(TotalErrors.ErrorNum),Fields.InValidMessage_EFX_MBE(TotalErrors.ErrorNum),Fields.InValidMessage_EFX_WBE(TotalErrors.ErrorNum),Fields.InValidMessage_EFX_MWBE(TotalErrors.ErrorNum),Fields.InValidMessage_EFX_SDB(TotalErrors.ErrorNum),Fields.InValidMessage_EFX_HUBZONE(TotalErrors.ErrorNum),Fields.InValidMessage_EFX_DBE(TotalErrors.ErrorNum),Fields.InValidMessage_EFX_VET(TotalErrors.ErrorNum),Fields.InValidMessage_EFX_DVET(TotalErrors.ErrorNum),Fields.InValidMessage_EFX_8a(TotalErrors.ErrorNum),Fields.InValidMessage_EFX_8aEXPDT(TotalErrors.ErrorNum),Fields.InValidMessage_EFX_DIS(TotalErrors.ErrorNum),Fields.InValidMessage_EFX_SBE(TotalErrors.ErrorNum),Fields.InValidMessage_EFX_BUSSIZE(TotalErrors.ErrorNum),Fields.InValidMessage_EFX_LBE(TotalErrors.ErrorNum),Fields.InValidMessage_EFX_GOV(TotalErrors.ErrorNum),Fields.InValidMessage_EFX_FGOV(TotalErrors.ErrorNum),Fields.InValidMessage_EFX_GOV1057(TotalErrors.ErrorNum),Fields.InValidMessage_EFX_NONPROFIT(TotalErrors.ErrorNum),Fields.InValidMessage_EFX_MERCTYPE(TotalErrors.ErrorNum),Fields.InValidMessage_EFX_HBCU(TotalErrors.ErrorNum),Fields.InValidMessage_EFX_GAYLESBIAN(TotalErrors.ErrorNum),Fields.InValidMessage_EFX_WSBE(TotalErrors.ErrorNum),Fields.InValidMessage_EFX_VSBE(TotalErrors.ErrorNum),Fields.InValidMessage_EFX_DVSBE(TotalErrors.ErrorNum),Fields.InValidMessage_EFX_MWBESTATUS(TotalErrors.ErrorNum),Fields.InValidMessage_EFX_NMSDC(TotalErrors.ErrorNum),Fields.InValidMessage_EFX_WBENC(TotalErrors.ErrorNum),Fields.InValidMessage_EFX_CA_PUC(TotalErrors.ErrorNum),Fields.InValidMessage_EFX_TX_HUB(TotalErrors.ErrorNum),Fields.InValidMessage_EFX_TX_HUBCERTNUM(TotalErrors.ErrorNum),Fields.InValidMessage_EFX_GSAX(TotalErrors.ErrorNum),Fields.InValidMessage_EFX_CALTRANS(TotalErrors.ErrorNum),Fields.InValidMessage_EFX_EDU(TotalErrors.ErrorNum),Fields.InValidMessage_EFX_MI(TotalErrors.ErrorNum),Fields.InValidMessage_EFX_ANC(TotalErrors.ErrorNum),Fields.InValidMessage_AT_CERT1(TotalErrors.ErrorNum),Fields.InValidMessage_AT_CERT2(TotalErrors.ErrorNum),Fields.InValidMessage_AT_CERT3(TotalErrors.ErrorNum),Fields.InValidMessage_AT_CERT4(TotalErrors.ErrorNum),Fields.InValidMessage_AT_CERT5(TotalErrors.ErrorNum),Fields.InValidMessage_AT_CERT6(TotalErrors.ErrorNum),Fields.InValidMessage_AT_CERT7(TotalErrors.ErrorNum),Fields.InValidMessage_AT_CERT8(TotalErrors.ErrorNum),Fields.InValidMessage_AT_CERT9(TotalErrors.ErrorNum),Fields.InValidMessage_AT_CERT10(TotalErrors.ErrorNum),Fields.InValidMessage_AT_CERTDESC1(TotalErrors.ErrorNum),Fields.InValidMessage_AT_CERTDESC2(TotalErrors.ErrorNum),Fields.InValidMessage_AT_CERTDESC3(TotalErrors.ErrorNum),Fields.InValidMessage_AT_CERTDESC4(TotalErrors.ErrorNum),Fields.InValidMessage_AT_CERTDESC5(TotalErrors.ErrorNum),Fields.InValidMessage_AT_CERTDESC6(TotalErrors.ErrorNum),Fields.InValidMessage_AT_CERTDESC7(TotalErrors.ErrorNum),Fields.InValidMessage_AT_CERTDESC8(TotalErrors.ErrorNum),Fields.InValidMessage_AT_CERTDESC9(TotalErrors.ErrorNum),Fields.InValidMessage_AT_CERTDESC10(TotalErrors.ErrorNum),Fields.InValidMessage_AT_CERTSRC1(TotalErrors.ErrorNum),Fields.InValidMessage_AT_CERTSRC2(TotalErrors.ErrorNum),Fields.InValidMessage_AT_CERTSRC3(TotalErrors.ErrorNum),Fields.InValidMessage_AT_CERTSRC4(TotalErrors.ErrorNum),Fields.InValidMessage_AT_CERTSRC5(TotalErrors.ErrorNum),Fields.InValidMessage_AT_CERTSRC6(TotalErrors.ErrorNum),Fields.InValidMessage_AT_CERTSRC7(TotalErrors.ErrorNum),Fields.InValidMessage_AT_CERTSRC8(TotalErrors.ErrorNum),Fields.InValidMessage_AT_CERTSRC9(TotalErrors.ErrorNum),Fields.InValidMessage_AT_CERTSRC10(TotalErrors.ErrorNum),Fields.InValidMessage_AT_CERTLEV1(TotalErrors.ErrorNum),Fields.InValidMessage_AT_CERTLEV2(TotalErrors.ErrorNum),Fields.InValidMessage_AT_CERTLEV3(TotalErrors.ErrorNum),Fields.InValidMessage_AT_CERTLEV4(TotalErrors.ErrorNum),Fields.InValidMessage_AT_CERTLEV5(TotalErrors.ErrorNum),Fields.InValidMessage_AT_CERTLEV6(TotalErrors.ErrorNum),Fields.InValidMessage_AT_CERTLEV7(TotalErrors.ErrorNum),Fields.InValidMessage_AT_CERTLEV8(TotalErrors.ErrorNum),Fields.InValidMessage_AT_CERTLEV9(TotalErrors.ErrorNum),Fields.InValidMessage_AT_CERTLEV10(TotalErrors.ErrorNum),Fields.InValidMessage_AT_CERTNUM1(TotalErrors.ErrorNum),Fields.InValidMessage_AT_CERTNUM2(TotalErrors.ErrorNum),Fields.InValidMessage_AT_CERTNUM3(TotalErrors.ErrorNum),Fields.InValidMessage_AT_CERTNUM4(TotalErrors.ErrorNum),Fields.InValidMessage_AT_CERTNUM5(TotalErrors.ErrorNum),Fields.InValidMessage_AT_CERTNUM6(TotalErrors.ErrorNum),Fields.InValidMessage_AT_CERTNUM7(TotalErrors.ErrorNum),Fields.InValidMessage_AT_CERTNUM8(TotalErrors.ErrorNum),Fields.InValidMessage_AT_CERTNUM9(TotalErrors.ErrorNum),Fields.InValidMessage_AT_CERTNUM10(TotalErrors.ErrorNum),Fields.InValidMessage_AT_CERTEXP1(TotalErrors.ErrorNum),Fields.InValidMessage_AT_CERTEXP2(TotalErrors.ErrorNum),Fields.InValidMessage_AT_CERTEXP3(TotalErrors.ErrorNum),Fields.InValidMessage_AT_CERTEXP4(TotalErrors.ErrorNum),Fields.InValidMessage_AT_CERTEXP5(TotalErrors.ErrorNum),Fields.InValidMessage_AT_CERTEXP6(TotalErrors.ErrorNum),Fields.InValidMessage_AT_CERTEXP7(TotalErrors.ErrorNum),Fields.InValidMessage_AT_CERTEXP8(TotalErrors.ErrorNum),Fields.InValidMessage_AT_CERTEXP9(TotalErrors.ErrorNum),Fields.InValidMessage_AT_CERTEXP10(TotalErrors.ErrorNum),Fields.InValidMessage_EFX_EXTRACT_DATE(TotalErrors.ErrorNum),Fields.InValidMessage_EFX_MERCHANT_ID(TotalErrors.ErrorNum),Fields.InValidMessage_EFX_PROJECT_ID(TotalErrors.ErrorNum),Fields.InValidMessage_EFX_FOREIGN(TotalErrors.ErrorNum),Fields.InValidMessage_Record_Update_Refresh_Date(TotalErrors.ErrorNum),Fields.InValidMessage_EFX_DATE_CREATED(TotalErrors.ErrorNum),Fields.InValidMessage_normCompany_Name(TotalErrors.ErrorNum),Fields.InValidMessage_normCompany_Type(TotalErrors.ErrorNum),Fields.InValidMessage_Norm_Geo_Precision(TotalErrors.ErrorNum),Fields.InValidMessage_Exploded_Desc_Corporate_Amount_Precision(TotalErrors.ErrorNum),Fields.InValidMessage_Exploded_Desc_Location_Amount_Precision(TotalErrors.ErrorNum),Fields.InValidMessage_Exploded_Desc_Public_Co_Indicator(TotalErrors.ErrorNum),Fields.InValidMessage_Exploded_Desc_Stock_Exchange(TotalErrors.ErrorNum),Fields.InValidMessage_Exploded_Desc_Telemarketablity_Score(TotalErrors.ErrorNum),Fields.InValidMessage_Exploded_Desc_Telemarketablity_Total_Indicator(TotalErrors.ErrorNum),Fields.InValidMessage_Exploded_Desc_Telemarketablity_Total_Score(TotalErrors.ErrorNum),Fields.InValidMessage_Exploded_Desc_Government1057_Entity(TotalErrors.ErrorNum),Fields.InValidMessage_Exploded_Desc_Merchant_Type(TotalErrors.ErrorNum),Fields.InValidMessage_Exploded_Desc_Busstatcd(TotalErrors.ErrorNum),Fields.InValidMessage_Exploded_Desc_CMSA(TotalErrors.ErrorNum),Fields.InValidMessage_Exploded_Desc_Corpamountcd(TotalErrors.ErrorNum),Fields.InValidMessage_Exploded_Desc_Corpamountprec(TotalErrors.ErrorNum),Fields.InValidMessage_Exploded_Desc_Corpamounttp(TotalErrors.ErrorNum),Fields.InValidMessage_Exploded_Desc_Corpempcd(TotalErrors.ErrorNum),Fields.InValidMessage_Exploded_Desc_Ctrytelcd(TotalErrors.ErrorNum),Fields.InValidMessage_NormAddress_Type(TotalErrors.ErrorNum),Fields.InValidMessage_Norm_Address(TotalErrors.ErrorNum),Fields.InValidMessage_Norm_City(TotalErrors.ErrorNum),Fields.InValidMessage_Norm_State(TotalErrors.ErrorNum),Fields.InValidMessage_Norm_StateC2(TotalErrors.ErrorNum),Fields.InValidMessage_Norm_Zip(TotalErrors.ErrorNum),Fields.InValidMessage_Norm_Zip4(TotalErrors.ErrorNum),Fields.InValidMessage_Norm_Lat(TotalErrors.ErrorNum),Fields.InValidMessage_Norm_Lon(TotalErrors.ErrorNum),Fields.InValidMessage_Norm_Geoprec(TotalErrors.ErrorNum),Fields.InValidMessage_Norm_Region(TotalErrors.ErrorNum),Fields.InValidMessage_Norm_Ctryisocd(TotalErrors.ErrorNum),Fields.InValidMessage_Norm_Ctrynum(TotalErrors.ErrorNum),Fields.InValidMessage_Norm_Ctryname(TotalErrors.ErrorNum),Fields.InValidMessage_clean_company_name(TotalErrors.ErrorNum),Fields.InValidMessage_clean_phone(TotalErrors.ErrorNum),Fields.InValidMessage_clean_secondary_phone(TotalErrors.ErrorNum),Fields.InValidMessage_prim_range(TotalErrors.ErrorNum),Fields.InValidMessage_predir(TotalErrors.ErrorNum),Fields.InValidMessage_prim_name(TotalErrors.ErrorNum),Fields.InValidMessage_addr_suffix(TotalErrors.ErrorNum),Fields.InValidMessage_postdir(TotalErrors.ErrorNum),Fields.InValidMessage_unit_desig(TotalErrors.ErrorNum),Fields.InValidMessage_sec_range(TotalErrors.ErrorNum),Fields.InValidMessage_p_city_name(TotalErrors.ErrorNum),Fields.InValidMessage_v_city_name(TotalErrors.ErrorNum),Fields.InValidMessage_st(TotalErrors.ErrorNum),Fields.InValidMessage_cart(TotalErrors.ErrorNum),Fields.InValidMessage_cr_sort_sz(TotalErrors.ErrorNum));
  TotalErrors.Cnt;
END;
ValErr := TABLE(TotalErrors,PrettyErrorTotals);
EXPORT ValidityErrors := JOIN(ValErr,TABLE(SourceCounts,{Source,NumberOfRecords}),LEFT.source=RIGHT.Source,LOOKUP); // Add source group counts for STRATA compliance
//We have seleid specified - so we can compute statistics on the cluster counts
EXPORT ClusterCounts := SALT37.MOD_ClusterStats.Counts(h,seleid);
EXPORT ClusterSrc := SALT37.MOD_ClusterStats.Sources(h,seleid,source);
END;
