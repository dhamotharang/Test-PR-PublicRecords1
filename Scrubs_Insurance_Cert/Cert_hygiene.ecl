﻿IMPORT SALT311,STD;
EXPORT Cert_hygiene(dataset(Cert_layout_Insurance_Cert) h) := MODULE
 
//A simple summary record
EXPORT Summary(SALT311.Str30Type  txt) := FUNCTION
  SummaryLayout := RECORD
    txt;
    NumberOfRecords := COUNT(GROUP);
    populated_dartid_cnt := COUNT(GROUP,h.dartid <> (TYPEOF(h.dartid))'');
    populated_dartid_pcnt := AVE(GROUP,IF(h.dartid = (TYPEOF(h.dartid))'',0,100));
    maxlength_dartid := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.dartid)));
    avelength_dartid := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.dartid)),h.dartid<>(typeof(h.dartid))'');
    populated_dateadded_cnt := COUNT(GROUP,h.dateadded <> (TYPEOF(h.dateadded))'');
    populated_dateadded_pcnt := AVE(GROUP,IF(h.dateadded = (TYPEOF(h.dateadded))'',0,100));
    maxlength_dateadded := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.dateadded)));
    avelength_dateadded := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.dateadded)),h.dateadded<>(typeof(h.dateadded))'');
    populated_dateupdated_cnt := COUNT(GROUP,h.dateupdated <> (TYPEOF(h.dateupdated))'');
    populated_dateupdated_pcnt := AVE(GROUP,IF(h.dateupdated = (TYPEOF(h.dateupdated))'',0,100));
    maxlength_dateupdated := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.dateupdated)));
    avelength_dateupdated := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.dateupdated)),h.dateupdated<>(typeof(h.dateupdated))'');
    populated_website_cnt := COUNT(GROUP,h.website <> (TYPEOF(h.website))'');
    populated_website_pcnt := AVE(GROUP,IF(h.website = (TYPEOF(h.website))'',0,100));
    maxlength_website := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.website)));
    avelength_website := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.website)),h.website<>(typeof(h.website))'');
    populated_state_cnt := COUNT(GROUP,h.state <> (TYPEOF(h.state))'');
    populated_state_pcnt := AVE(GROUP,IF(h.state = (TYPEOF(h.state))'',0,100));
    maxlength_state := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.state)));
    avelength_state := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.state)),h.state<>(typeof(h.state))'');
    populated_lninscertrecordid_cnt := COUNT(GROUP,h.lninscertrecordid <> (TYPEOF(h.lninscertrecordid))'');
    populated_lninscertrecordid_pcnt := AVE(GROUP,IF(h.lninscertrecordid = (TYPEOF(h.lninscertrecordid))'',0,100));
    maxlength_lninscertrecordid := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.lninscertrecordid)));
    avelength_lninscertrecordid := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.lninscertrecordid)),h.lninscertrecordid<>(typeof(h.lninscertrecordid))'');
    populated_profilelastupdated_cnt := COUNT(GROUP,h.profilelastupdated <> (TYPEOF(h.profilelastupdated))'');
    populated_profilelastupdated_pcnt := AVE(GROUP,IF(h.profilelastupdated = (TYPEOF(h.profilelastupdated))'',0,100));
    maxlength_profilelastupdated := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.profilelastupdated)));
    avelength_profilelastupdated := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.profilelastupdated)),h.profilelastupdated<>(typeof(h.profilelastupdated))'');
    populated_siid_cnt := COUNT(GROUP,h.siid <> (TYPEOF(h.siid))'');
    populated_siid_pcnt := AVE(GROUP,IF(h.siid = (TYPEOF(h.siid))'',0,100));
    maxlength_siid := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.siid)));
    avelength_siid := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.siid)),h.siid<>(typeof(h.siid))'');
    populated_sipstatuscode_cnt := COUNT(GROUP,h.sipstatuscode <> (TYPEOF(h.sipstatuscode))'');
    populated_sipstatuscode_pcnt := AVE(GROUP,IF(h.sipstatuscode = (TYPEOF(h.sipstatuscode))'',0,100));
    maxlength_sipstatuscode := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.sipstatuscode)));
    avelength_sipstatuscode := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.sipstatuscode)),h.sipstatuscode<>(typeof(h.sipstatuscode))'');
    populated_wcbempnumber_cnt := COUNT(GROUP,h.wcbempnumber <> (TYPEOF(h.wcbempnumber))'');
    populated_wcbempnumber_pcnt := AVE(GROUP,IF(h.wcbempnumber = (TYPEOF(h.wcbempnumber))'',0,100));
    maxlength_wcbempnumber := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.wcbempnumber)));
    avelength_wcbempnumber := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.wcbempnumber)),h.wcbempnumber<>(typeof(h.wcbempnumber))'');
    populated_ubinumber_cnt := COUNT(GROUP,h.ubinumber <> (TYPEOF(h.ubinumber))'');
    populated_ubinumber_pcnt := AVE(GROUP,IF(h.ubinumber = (TYPEOF(h.ubinumber))'',0,100));
    maxlength_ubinumber := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.ubinumber)));
    avelength_ubinumber := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.ubinumber)),h.ubinumber<>(typeof(h.ubinumber))'');
    populated_cofanumber_cnt := COUNT(GROUP,h.cofanumber <> (TYPEOF(h.cofanumber))'');
    populated_cofanumber_pcnt := AVE(GROUP,IF(h.cofanumber = (TYPEOF(h.cofanumber))'',0,100));
    maxlength_cofanumber := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.cofanumber)));
    avelength_cofanumber := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.cofanumber)),h.cofanumber<>(typeof(h.cofanumber))'');
    populated_usdotnumber_cnt := COUNT(GROUP,h.usdotnumber <> (TYPEOF(h.usdotnumber))'');
    populated_usdotnumber_pcnt := AVE(GROUP,IF(h.usdotnumber = (TYPEOF(h.usdotnumber))'',0,100));
    maxlength_usdotnumber := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.usdotnumber)));
    avelength_usdotnumber := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.usdotnumber)),h.usdotnumber<>(typeof(h.usdotnumber))'');
    populated_businessname_cnt := COUNT(GROUP,h.businessname <> (TYPEOF(h.businessname))'');
    populated_businessname_pcnt := AVE(GROUP,IF(h.businessname = (TYPEOF(h.businessname))'',0,100));
    maxlength_businessname := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.businessname)));
    avelength_businessname := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.businessname)),h.businessname<>(typeof(h.businessname))'');
    populated_dba_cnt := COUNT(GROUP,h.dba <> (TYPEOF(h.dba))'');
    populated_dba_pcnt := AVE(GROUP,IF(h.dba = (TYPEOF(h.dba))'',0,100));
    maxlength_dba := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.dba)));
    avelength_dba := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.dba)),h.dba<>(typeof(h.dba))'');
    populated_addressline1_cnt := COUNT(GROUP,h.addressline1 <> (TYPEOF(h.addressline1))'');
    populated_addressline1_pcnt := AVE(GROUP,IF(h.addressline1 = (TYPEOF(h.addressline1))'',0,100));
    maxlength_addressline1 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.addressline1)));
    avelength_addressline1 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.addressline1)),h.addressline1<>(typeof(h.addressline1))'');
    populated_addressline2_cnt := COUNT(GROUP,h.addressline2 <> (TYPEOF(h.addressline2))'');
    populated_addressline2_pcnt := AVE(GROUP,IF(h.addressline2 = (TYPEOF(h.addressline2))'',0,100));
    maxlength_addressline2 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.addressline2)));
    avelength_addressline2 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.addressline2)),h.addressline2<>(typeof(h.addressline2))'');
    populated_addresscity_cnt := COUNT(GROUP,h.addresscity <> (TYPEOF(h.addresscity))'');
    populated_addresscity_pcnt := AVE(GROUP,IF(h.addresscity = (TYPEOF(h.addresscity))'',0,100));
    maxlength_addresscity := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.addresscity)));
    avelength_addresscity := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.addresscity)),h.addresscity<>(typeof(h.addresscity))'');
    populated_addressstate_cnt := COUNT(GROUP,h.addressstate <> (TYPEOF(h.addressstate))'');
    populated_addressstate_pcnt := AVE(GROUP,IF(h.addressstate = (TYPEOF(h.addressstate))'',0,100));
    maxlength_addressstate := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.addressstate)));
    avelength_addressstate := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.addressstate)),h.addressstate<>(typeof(h.addressstate))'');
    populated_addresszip_cnt := COUNT(GROUP,h.addresszip <> (TYPEOF(h.addresszip))'');
    populated_addresszip_pcnt := AVE(GROUP,IF(h.addresszip = (TYPEOF(h.addresszip))'',0,100));
    maxlength_addresszip := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.addresszip)));
    avelength_addresszip := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.addresszip)),h.addresszip<>(typeof(h.addresszip))'');
    populated_zip4_cnt := COUNT(GROUP,h.zip4 <> (TYPEOF(h.zip4))'');
    populated_zip4_pcnt := AVE(GROUP,IF(h.zip4 = (TYPEOF(h.zip4))'',0,100));
    maxlength_zip4 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.zip4)));
    avelength_zip4 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.zip4)),h.zip4<>(typeof(h.zip4))'');
    populated_phone1_cnt := COUNT(GROUP,h.phone1 <> (TYPEOF(h.phone1))'');
    populated_phone1_pcnt := AVE(GROUP,IF(h.phone1 = (TYPEOF(h.phone1))'',0,100));
    maxlength_phone1 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.phone1)));
    avelength_phone1 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.phone1)),h.phone1<>(typeof(h.phone1))'');
    populated_phone2_cnt := COUNT(GROUP,h.phone2 <> (TYPEOF(h.phone2))'');
    populated_phone2_pcnt := AVE(GROUP,IF(h.phone2 = (TYPEOF(h.phone2))'',0,100));
    maxlength_phone2 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.phone2)));
    avelength_phone2 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.phone2)),h.phone2<>(typeof(h.phone2))'');
    populated_phone3_cnt := COUNT(GROUP,h.phone3 <> (TYPEOF(h.phone3))'');
    populated_phone3_pcnt := AVE(GROUP,IF(h.phone3 = (TYPEOF(h.phone3))'',0,100));
    maxlength_phone3 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.phone3)));
    avelength_phone3 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.phone3)),h.phone3<>(typeof(h.phone3))'');
    populated_fax1_cnt := COUNT(GROUP,h.fax1 <> (TYPEOF(h.fax1))'');
    populated_fax1_pcnt := AVE(GROUP,IF(h.fax1 = (TYPEOF(h.fax1))'',0,100));
    maxlength_fax1 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.fax1)));
    avelength_fax1 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.fax1)),h.fax1<>(typeof(h.fax1))'');
    populated_fax2_cnt := COUNT(GROUP,h.fax2 <> (TYPEOF(h.fax2))'');
    populated_fax2_pcnt := AVE(GROUP,IF(h.fax2 = (TYPEOF(h.fax2))'',0,100));
    maxlength_fax2 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.fax2)));
    avelength_fax2 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.fax2)),h.fax2<>(typeof(h.fax2))'');
    populated_email1_cnt := COUNT(GROUP,h.email1 <> (TYPEOF(h.email1))'');
    populated_email1_pcnt := AVE(GROUP,IF(h.email1 = (TYPEOF(h.email1))'',0,100));
    maxlength_email1 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.email1)));
    avelength_email1 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.email1)),h.email1<>(typeof(h.email1))'');
    populated_email2_cnt := COUNT(GROUP,h.email2 <> (TYPEOF(h.email2))'');
    populated_email2_pcnt := AVE(GROUP,IF(h.email2 = (TYPEOF(h.email2))'',0,100));
    maxlength_email2 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.email2)));
    avelength_email2 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.email2)),h.email2<>(typeof(h.email2))'');
    populated_businesstype_cnt := COUNT(GROUP,h.businesstype <> (TYPEOF(h.businesstype))'');
    populated_businesstype_pcnt := AVE(GROUP,IF(h.businesstype = (TYPEOF(h.businesstype))'',0,100));
    maxlength_businesstype := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.businesstype)));
    avelength_businesstype := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.businesstype)),h.businesstype<>(typeof(h.businesstype))'');
    populated_namefirst_cnt := COUNT(GROUP,h.namefirst <> (TYPEOF(h.namefirst))'');
    populated_namefirst_pcnt := AVE(GROUP,IF(h.namefirst = (TYPEOF(h.namefirst))'',0,100));
    maxlength_namefirst := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.namefirst)));
    avelength_namefirst := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.namefirst)),h.namefirst<>(typeof(h.namefirst))'');
    populated_namemiddle_cnt := COUNT(GROUP,h.namemiddle <> (TYPEOF(h.namemiddle))'');
    populated_namemiddle_pcnt := AVE(GROUP,IF(h.namemiddle = (TYPEOF(h.namemiddle))'',0,100));
    maxlength_namemiddle := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.namemiddle)));
    avelength_namemiddle := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.namemiddle)),h.namemiddle<>(typeof(h.namemiddle))'');
    populated_namelast_cnt := COUNT(GROUP,h.namelast <> (TYPEOF(h.namelast))'');
    populated_namelast_pcnt := AVE(GROUP,IF(h.namelast = (TYPEOF(h.namelast))'',0,100));
    maxlength_namelast := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.namelast)));
    avelength_namelast := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.namelast)),h.namelast<>(typeof(h.namelast))'');
    populated_namesuffix_cnt := COUNT(GROUP,h.namesuffix <> (TYPEOF(h.namesuffix))'');
    populated_namesuffix_pcnt := AVE(GROUP,IF(h.namesuffix = (TYPEOF(h.namesuffix))'',0,100));
    maxlength_namesuffix := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.namesuffix)));
    avelength_namesuffix := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.namesuffix)),h.namesuffix<>(typeof(h.namesuffix))'');
    populated_nametitle_cnt := COUNT(GROUP,h.nametitle <> (TYPEOF(h.nametitle))'');
    populated_nametitle_pcnt := AVE(GROUP,IF(h.nametitle = (TYPEOF(h.nametitle))'',0,100));
    maxlength_nametitle := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.nametitle)));
    avelength_nametitle := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.nametitle)),h.nametitle<>(typeof(h.nametitle))'');
    populated_mailingaddress1_cnt := COUNT(GROUP,h.mailingaddress1 <> (TYPEOF(h.mailingaddress1))'');
    populated_mailingaddress1_pcnt := AVE(GROUP,IF(h.mailingaddress1 = (TYPEOF(h.mailingaddress1))'',0,100));
    maxlength_mailingaddress1 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.mailingaddress1)));
    avelength_mailingaddress1 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.mailingaddress1)),h.mailingaddress1<>(typeof(h.mailingaddress1))'');
    populated_mailingaddress2_cnt := COUNT(GROUP,h.mailingaddress2 <> (TYPEOF(h.mailingaddress2))'');
    populated_mailingaddress2_pcnt := AVE(GROUP,IF(h.mailingaddress2 = (TYPEOF(h.mailingaddress2))'',0,100));
    maxlength_mailingaddress2 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.mailingaddress2)));
    avelength_mailingaddress2 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.mailingaddress2)),h.mailingaddress2<>(typeof(h.mailingaddress2))'');
    populated_mailingaddresscity_cnt := COUNT(GROUP,h.mailingaddresscity <> (TYPEOF(h.mailingaddresscity))'');
    populated_mailingaddresscity_pcnt := AVE(GROUP,IF(h.mailingaddresscity = (TYPEOF(h.mailingaddresscity))'',0,100));
    maxlength_mailingaddresscity := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.mailingaddresscity)));
    avelength_mailingaddresscity := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.mailingaddresscity)),h.mailingaddresscity<>(typeof(h.mailingaddresscity))'');
    populated_mailingaddressstate_cnt := COUNT(GROUP,h.mailingaddressstate <> (TYPEOF(h.mailingaddressstate))'');
    populated_mailingaddressstate_pcnt := AVE(GROUP,IF(h.mailingaddressstate = (TYPEOF(h.mailingaddressstate))'',0,100));
    maxlength_mailingaddressstate := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.mailingaddressstate)));
    avelength_mailingaddressstate := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.mailingaddressstate)),h.mailingaddressstate<>(typeof(h.mailingaddressstate))'');
    populated_mailingaddresszip_cnt := COUNT(GROUP,h.mailingaddresszip <> (TYPEOF(h.mailingaddresszip))'');
    populated_mailingaddresszip_pcnt := AVE(GROUP,IF(h.mailingaddresszip = (TYPEOF(h.mailingaddresszip))'',0,100));
    maxlength_mailingaddresszip := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.mailingaddresszip)));
    avelength_mailingaddresszip := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.mailingaddresszip)),h.mailingaddresszip<>(typeof(h.mailingaddresszip))'');
    populated_mailingaddresszip4_cnt := COUNT(GROUP,h.mailingaddresszip4 <> (TYPEOF(h.mailingaddresszip4))'');
    populated_mailingaddresszip4_pcnt := AVE(GROUP,IF(h.mailingaddresszip4 = (TYPEOF(h.mailingaddresszip4))'',0,100));
    maxlength_mailingaddresszip4 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.mailingaddresszip4)));
    avelength_mailingaddresszip4 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.mailingaddresszip4)),h.mailingaddresszip4<>(typeof(h.mailingaddresszip4))'');
    populated_contactnamefirst_cnt := COUNT(GROUP,h.contactnamefirst <> (TYPEOF(h.contactnamefirst))'');
    populated_contactnamefirst_pcnt := AVE(GROUP,IF(h.contactnamefirst = (TYPEOF(h.contactnamefirst))'',0,100));
    maxlength_contactnamefirst := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.contactnamefirst)));
    avelength_contactnamefirst := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.contactnamefirst)),h.contactnamefirst<>(typeof(h.contactnamefirst))'');
    populated_contactnamemiddle_cnt := COUNT(GROUP,h.contactnamemiddle <> (TYPEOF(h.contactnamemiddle))'');
    populated_contactnamemiddle_pcnt := AVE(GROUP,IF(h.contactnamemiddle = (TYPEOF(h.contactnamemiddle))'',0,100));
    maxlength_contactnamemiddle := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.contactnamemiddle)));
    avelength_contactnamemiddle := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.contactnamemiddle)),h.contactnamemiddle<>(typeof(h.contactnamemiddle))'');
    populated_contactnamelast_cnt := COUNT(GROUP,h.contactnamelast <> (TYPEOF(h.contactnamelast))'');
    populated_contactnamelast_pcnt := AVE(GROUP,IF(h.contactnamelast = (TYPEOF(h.contactnamelast))'',0,100));
    maxlength_contactnamelast := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.contactnamelast)));
    avelength_contactnamelast := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.contactnamelast)),h.contactnamelast<>(typeof(h.contactnamelast))'');
    populated_contactnamesuffix_cnt := COUNT(GROUP,h.contactnamesuffix <> (TYPEOF(h.contactnamesuffix))'');
    populated_contactnamesuffix_pcnt := AVE(GROUP,IF(h.contactnamesuffix = (TYPEOF(h.contactnamesuffix))'',0,100));
    maxlength_contactnamesuffix := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.contactnamesuffix)));
    avelength_contactnamesuffix := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.contactnamesuffix)),h.contactnamesuffix<>(typeof(h.contactnamesuffix))'');
    populated_contactbusinessname_cnt := COUNT(GROUP,h.contactbusinessname <> (TYPEOF(h.contactbusinessname))'');
    populated_contactbusinessname_pcnt := AVE(GROUP,IF(h.contactbusinessname = (TYPEOF(h.contactbusinessname))'',0,100));
    maxlength_contactbusinessname := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.contactbusinessname)));
    avelength_contactbusinessname := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.contactbusinessname)),h.contactbusinessname<>(typeof(h.contactbusinessname))'');
    populated_contactaddressline1_cnt := COUNT(GROUP,h.contactaddressline1 <> (TYPEOF(h.contactaddressline1))'');
    populated_contactaddressline1_pcnt := AVE(GROUP,IF(h.contactaddressline1 = (TYPEOF(h.contactaddressline1))'',0,100));
    maxlength_contactaddressline1 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.contactaddressline1)));
    avelength_contactaddressline1 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.contactaddressline1)),h.contactaddressline1<>(typeof(h.contactaddressline1))'');
    populated_contactaddressline2_cnt := COUNT(GROUP,h.contactaddressline2 <> (TYPEOF(h.contactaddressline2))'');
    populated_contactaddressline2_pcnt := AVE(GROUP,IF(h.contactaddressline2 = (TYPEOF(h.contactaddressline2))'',0,100));
    maxlength_contactaddressline2 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.contactaddressline2)));
    avelength_contactaddressline2 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.contactaddressline2)),h.contactaddressline2<>(typeof(h.contactaddressline2))'');
    populated_contactcity_cnt := COUNT(GROUP,h.contactcity <> (TYPEOF(h.contactcity))'');
    populated_contactcity_pcnt := AVE(GROUP,IF(h.contactcity = (TYPEOF(h.contactcity))'',0,100));
    maxlength_contactcity := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.contactcity)));
    avelength_contactcity := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.contactcity)),h.contactcity<>(typeof(h.contactcity))'');
    populated_contactstate_cnt := COUNT(GROUP,h.contactstate <> (TYPEOF(h.contactstate))'');
    populated_contactstate_pcnt := AVE(GROUP,IF(h.contactstate = (TYPEOF(h.contactstate))'',0,100));
    maxlength_contactstate := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.contactstate)));
    avelength_contactstate := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.contactstate)),h.contactstate<>(typeof(h.contactstate))'');
    populated_contactzip_cnt := COUNT(GROUP,h.contactzip <> (TYPEOF(h.contactzip))'');
    populated_contactzip_pcnt := AVE(GROUP,IF(h.contactzip = (TYPEOF(h.contactzip))'',0,100));
    maxlength_contactzip := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.contactzip)));
    avelength_contactzip := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.contactzip)),h.contactzip<>(typeof(h.contactzip))'');
    populated_contactzip4_cnt := COUNT(GROUP,h.contactzip4 <> (TYPEOF(h.contactzip4))'');
    populated_contactzip4_pcnt := AVE(GROUP,IF(h.contactzip4 = (TYPEOF(h.contactzip4))'',0,100));
    maxlength_contactzip4 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.contactzip4)));
    avelength_contactzip4 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.contactzip4)),h.contactzip4<>(typeof(h.contactzip4))'');
    populated_contactphone_cnt := COUNT(GROUP,h.contactphone <> (TYPEOF(h.contactphone))'');
    populated_contactphone_pcnt := AVE(GROUP,IF(h.contactphone = (TYPEOF(h.contactphone))'',0,100));
    maxlength_contactphone := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.contactphone)));
    avelength_contactphone := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.contactphone)),h.contactphone<>(typeof(h.contactphone))'');
    populated_contactfax_cnt := COUNT(GROUP,h.contactfax <> (TYPEOF(h.contactfax))'');
    populated_contactfax_pcnt := AVE(GROUP,IF(h.contactfax = (TYPEOF(h.contactfax))'',0,100));
    maxlength_contactfax := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.contactfax)));
    avelength_contactfax := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.contactfax)),h.contactfax<>(typeof(h.contactfax))'');
    populated_contactemail_cnt := COUNT(GROUP,h.contactemail <> (TYPEOF(h.contactemail))'');
    populated_contactemail_pcnt := AVE(GROUP,IF(h.contactemail = (TYPEOF(h.contactemail))'',0,100));
    maxlength_contactemail := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.contactemail)));
    avelength_contactemail := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.contactemail)),h.contactemail<>(typeof(h.contactemail))'');
    populated_policyholdernamefirst_cnt := COUNT(GROUP,h.policyholdernamefirst <> (TYPEOF(h.policyholdernamefirst))'');
    populated_policyholdernamefirst_pcnt := AVE(GROUP,IF(h.policyholdernamefirst = (TYPEOF(h.policyholdernamefirst))'',0,100));
    maxlength_policyholdernamefirst := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.policyholdernamefirst)));
    avelength_policyholdernamefirst := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.policyholdernamefirst)),h.policyholdernamefirst<>(typeof(h.policyholdernamefirst))'');
    populated_policyholdernamemiddle_cnt := COUNT(GROUP,h.policyholdernamemiddle <> (TYPEOF(h.policyholdernamemiddle))'');
    populated_policyholdernamemiddle_pcnt := AVE(GROUP,IF(h.policyholdernamemiddle = (TYPEOF(h.policyholdernamemiddle))'',0,100));
    maxlength_policyholdernamemiddle := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.policyholdernamemiddle)));
    avelength_policyholdernamemiddle := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.policyholdernamemiddle)),h.policyholdernamemiddle<>(typeof(h.policyholdernamemiddle))'');
    populated_policyholdernamelast_cnt := COUNT(GROUP,h.policyholdernamelast <> (TYPEOF(h.policyholdernamelast))'');
    populated_policyholdernamelast_pcnt := AVE(GROUP,IF(h.policyholdernamelast = (TYPEOF(h.policyholdernamelast))'',0,100));
    maxlength_policyholdernamelast := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.policyholdernamelast)));
    avelength_policyholdernamelast := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.policyholdernamelast)),h.policyholdernamelast<>(typeof(h.policyholdernamelast))'');
    populated_policyholdernamesuffix_cnt := COUNT(GROUP,h.policyholdernamesuffix <> (TYPEOF(h.policyholdernamesuffix))'');
    populated_policyholdernamesuffix_pcnt := AVE(GROUP,IF(h.policyholdernamesuffix = (TYPEOF(h.policyholdernamesuffix))'',0,100));
    maxlength_policyholdernamesuffix := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.policyholdernamesuffix)));
    avelength_policyholdernamesuffix := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.policyholdernamesuffix)),h.policyholdernamesuffix<>(typeof(h.policyholdernamesuffix))'');
    populated_statepolicyfilenumber_cnt := COUNT(GROUP,h.statepolicyfilenumber <> (TYPEOF(h.statepolicyfilenumber))'');
    populated_statepolicyfilenumber_pcnt := AVE(GROUP,IF(h.statepolicyfilenumber = (TYPEOF(h.statepolicyfilenumber))'',0,100));
    maxlength_statepolicyfilenumber := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.statepolicyfilenumber)));
    avelength_statepolicyfilenumber := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.statepolicyfilenumber)),h.statepolicyfilenumber<>(typeof(h.statepolicyfilenumber))'');
    populated_coverageinjuryillnessdate_cnt := COUNT(GROUP,h.coverageinjuryillnessdate <> (TYPEOF(h.coverageinjuryillnessdate))'');
    populated_coverageinjuryillnessdate_pcnt := AVE(GROUP,IF(h.coverageinjuryillnessdate = (TYPEOF(h.coverageinjuryillnessdate))'',0,100));
    maxlength_coverageinjuryillnessdate := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.coverageinjuryillnessdate)));
    avelength_coverageinjuryillnessdate := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.coverageinjuryillnessdate)),h.coverageinjuryillnessdate<>(typeof(h.coverageinjuryillnessdate))'');
    populated_selfinsurancegroup_cnt := COUNT(GROUP,h.selfinsurancegroup <> (TYPEOF(h.selfinsurancegroup))'');
    populated_selfinsurancegroup_pcnt := AVE(GROUP,IF(h.selfinsurancegroup = (TYPEOF(h.selfinsurancegroup))'',0,100));
    maxlength_selfinsurancegroup := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.selfinsurancegroup)));
    avelength_selfinsurancegroup := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.selfinsurancegroup)),h.selfinsurancegroup<>(typeof(h.selfinsurancegroup))'');
    populated_selfinsurancegroupphone_cnt := COUNT(GROUP,h.selfinsurancegroupphone <> (TYPEOF(h.selfinsurancegroupphone))'');
    populated_selfinsurancegroupphone_pcnt := AVE(GROUP,IF(h.selfinsurancegroupphone = (TYPEOF(h.selfinsurancegroupphone))'',0,100));
    maxlength_selfinsurancegroupphone := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.selfinsurancegroupphone)));
    avelength_selfinsurancegroupphone := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.selfinsurancegroupphone)),h.selfinsurancegroupphone<>(typeof(h.selfinsurancegroupphone))'');
    populated_selfinsurancegroupid_cnt := COUNT(GROUP,h.selfinsurancegroupid <> (TYPEOF(h.selfinsurancegroupid))'');
    populated_selfinsurancegroupid_pcnt := AVE(GROUP,IF(h.selfinsurancegroupid = (TYPEOF(h.selfinsurancegroupid))'',0,100));
    maxlength_selfinsurancegroupid := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.selfinsurancegroupid)));
    avelength_selfinsurancegroupid := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.selfinsurancegroupid)),h.selfinsurancegroupid<>(typeof(h.selfinsurancegroupid))'');
    populated_numberofemployees_cnt := COUNT(GROUP,h.numberofemployees <> (TYPEOF(h.numberofemployees))'');
    populated_numberofemployees_pcnt := AVE(GROUP,IF(h.numberofemployees = (TYPEOF(h.numberofemployees))'',0,100));
    maxlength_numberofemployees := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.numberofemployees)));
    avelength_numberofemployees := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.numberofemployees)),h.numberofemployees<>(typeof(h.numberofemployees))'');
    populated_licensedcontractor_cnt := COUNT(GROUP,h.licensedcontractor <> (TYPEOF(h.licensedcontractor))'');
    populated_licensedcontractor_pcnt := AVE(GROUP,IF(h.licensedcontractor = (TYPEOF(h.licensedcontractor))'',0,100));
    maxlength_licensedcontractor := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.licensedcontractor)));
    avelength_licensedcontractor := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.licensedcontractor)),h.licensedcontractor<>(typeof(h.licensedcontractor))'');
    populated_mconame_cnt := COUNT(GROUP,h.mconame <> (TYPEOF(h.mconame))'');
    populated_mconame_pcnt := AVE(GROUP,IF(h.mconame = (TYPEOF(h.mconame))'',0,100));
    maxlength_mconame := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.mconame)));
    avelength_mconame := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.mconame)),h.mconame<>(typeof(h.mconame))'');
    populated_mconumber_cnt := COUNT(GROUP,h.mconumber <> (TYPEOF(h.mconumber))'');
    populated_mconumber_pcnt := AVE(GROUP,IF(h.mconumber = (TYPEOF(h.mconumber))'',0,100));
    maxlength_mconumber := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.mconumber)));
    avelength_mconumber := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.mconumber)),h.mconumber<>(typeof(h.mconumber))'');
    populated_mcoaddressline1_cnt := COUNT(GROUP,h.mcoaddressline1 <> (TYPEOF(h.mcoaddressline1))'');
    populated_mcoaddressline1_pcnt := AVE(GROUP,IF(h.mcoaddressline1 = (TYPEOF(h.mcoaddressline1))'',0,100));
    maxlength_mcoaddressline1 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.mcoaddressline1)));
    avelength_mcoaddressline1 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.mcoaddressline1)),h.mcoaddressline1<>(typeof(h.mcoaddressline1))'');
    populated_mcoaddressline2_cnt := COUNT(GROUP,h.mcoaddressline2 <> (TYPEOF(h.mcoaddressline2))'');
    populated_mcoaddressline2_pcnt := AVE(GROUP,IF(h.mcoaddressline2 = (TYPEOF(h.mcoaddressline2))'',0,100));
    maxlength_mcoaddressline2 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.mcoaddressline2)));
    avelength_mcoaddressline2 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.mcoaddressline2)),h.mcoaddressline2<>(typeof(h.mcoaddressline2))'');
    populated_mcocity_cnt := COUNT(GROUP,h.mcocity <> (TYPEOF(h.mcocity))'');
    populated_mcocity_pcnt := AVE(GROUP,IF(h.mcocity = (TYPEOF(h.mcocity))'',0,100));
    maxlength_mcocity := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.mcocity)));
    avelength_mcocity := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.mcocity)),h.mcocity<>(typeof(h.mcocity))'');
    populated_mcostate_cnt := COUNT(GROUP,h.mcostate <> (TYPEOF(h.mcostate))'');
    populated_mcostate_pcnt := AVE(GROUP,IF(h.mcostate = (TYPEOF(h.mcostate))'',0,100));
    maxlength_mcostate := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.mcostate)));
    avelength_mcostate := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.mcostate)),h.mcostate<>(typeof(h.mcostate))'');
    populated_mcozip_cnt := COUNT(GROUP,h.mcozip <> (TYPEOF(h.mcozip))'');
    populated_mcozip_pcnt := AVE(GROUP,IF(h.mcozip = (TYPEOF(h.mcozip))'',0,100));
    maxlength_mcozip := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.mcozip)));
    avelength_mcozip := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.mcozip)),h.mcozip<>(typeof(h.mcozip))'');
    populated_mcozip4_cnt := COUNT(GROUP,h.mcozip4 <> (TYPEOF(h.mcozip4))'');
    populated_mcozip4_pcnt := AVE(GROUP,IF(h.mcozip4 = (TYPEOF(h.mcozip4))'',0,100));
    maxlength_mcozip4 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.mcozip4)));
    avelength_mcozip4 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.mcozip4)),h.mcozip4<>(typeof(h.mcozip4))'');
    populated_mcophone_cnt := COUNT(GROUP,h.mcophone <> (TYPEOF(h.mcophone))'');
    populated_mcophone_pcnt := AVE(GROUP,IF(h.mcophone = (TYPEOF(h.mcophone))'',0,100));
    maxlength_mcophone := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.mcophone)));
    avelength_mcophone := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.mcophone)),h.mcophone<>(typeof(h.mcophone))'');
    populated_governingclasscode_cnt := COUNT(GROUP,h.governingclasscode <> (TYPEOF(h.governingclasscode))'');
    populated_governingclasscode_pcnt := AVE(GROUP,IF(h.governingclasscode = (TYPEOF(h.governingclasscode))'',0,100));
    maxlength_governingclasscode := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.governingclasscode)));
    avelength_governingclasscode := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.governingclasscode)),h.governingclasscode<>(typeof(h.governingclasscode))'');
    populated_licensenumber_cnt := COUNT(GROUP,h.licensenumber <> (TYPEOF(h.licensenumber))'');
    populated_licensenumber_pcnt := AVE(GROUP,IF(h.licensenumber = (TYPEOF(h.licensenumber))'',0,100));
    maxlength_licensenumber := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.licensenumber)));
    avelength_licensenumber := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.licensenumber)),h.licensenumber<>(typeof(h.licensenumber))'');
    populated_class_cnt := COUNT(GROUP,h.class <> (TYPEOF(h.class))'');
    populated_class_pcnt := AVE(GROUP,IF(h.class = (TYPEOF(h.class))'',0,100));
    maxlength_class := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.class)));
    avelength_class := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.class)),h.class<>(typeof(h.class))'');
    populated_classificationdescription_cnt := COUNT(GROUP,h.classificationdescription <> (TYPEOF(h.classificationdescription))'');
    populated_classificationdescription_pcnt := AVE(GROUP,IF(h.classificationdescription = (TYPEOF(h.classificationdescription))'',0,100));
    maxlength_classificationdescription := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.classificationdescription)));
    avelength_classificationdescription := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.classificationdescription)),h.classificationdescription<>(typeof(h.classificationdescription))'');
    populated_licensestatus_cnt := COUNT(GROUP,h.licensestatus <> (TYPEOF(h.licensestatus))'');
    populated_licensestatus_pcnt := AVE(GROUP,IF(h.licensestatus = (TYPEOF(h.licensestatus))'',0,100));
    maxlength_licensestatus := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.licensestatus)));
    avelength_licensestatus := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.licensestatus)),h.licensestatus<>(typeof(h.licensestatus))'');
    populated_licenseadditionalinfo_cnt := COUNT(GROUP,h.licenseadditionalinfo <> (TYPEOF(h.licenseadditionalinfo))'');
    populated_licenseadditionalinfo_pcnt := AVE(GROUP,IF(h.licenseadditionalinfo = (TYPEOF(h.licenseadditionalinfo))'',0,100));
    maxlength_licenseadditionalinfo := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.licenseadditionalinfo)));
    avelength_licenseadditionalinfo := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.licenseadditionalinfo)),h.licenseadditionalinfo<>(typeof(h.licenseadditionalinfo))'');
    populated_licenseissuedate_cnt := COUNT(GROUP,h.licenseissuedate <> (TYPEOF(h.licenseissuedate))'');
    populated_licenseissuedate_pcnt := AVE(GROUP,IF(h.licenseissuedate = (TYPEOF(h.licenseissuedate))'',0,100));
    maxlength_licenseissuedate := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.licenseissuedate)));
    avelength_licenseissuedate := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.licenseissuedate)),h.licenseissuedate<>(typeof(h.licenseissuedate))'');
    populated_licenseexpirationdate_cnt := COUNT(GROUP,h.licenseexpirationdate <> (TYPEOF(h.licenseexpirationdate))'');
    populated_licenseexpirationdate_pcnt := AVE(GROUP,IF(h.licenseexpirationdate = (TYPEOF(h.licenseexpirationdate))'',0,100));
    maxlength_licenseexpirationdate := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.licenseexpirationdate)));
    avelength_licenseexpirationdate := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.licenseexpirationdate)),h.licenseexpirationdate<>(typeof(h.licenseexpirationdate))'');
    populated_naicscode_cnt := COUNT(GROUP,h.naicscode <> (TYPEOF(h.naicscode))'');
    populated_naicscode_pcnt := AVE(GROUP,IF(h.naicscode = (TYPEOF(h.naicscode))'',0,100));
    maxlength_naicscode := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.naicscode)));
    avelength_naicscode := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.naicscode)),h.naicscode<>(typeof(h.naicscode))'');
    populated_officerexemptfirstname1_cnt := COUNT(GROUP,h.officerexemptfirstname1 <> (TYPEOF(h.officerexemptfirstname1))'');
    populated_officerexemptfirstname1_pcnt := AVE(GROUP,IF(h.officerexemptfirstname1 = (TYPEOF(h.officerexemptfirstname1))'',0,100));
    maxlength_officerexemptfirstname1 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.officerexemptfirstname1)));
    avelength_officerexemptfirstname1 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.officerexemptfirstname1)),h.officerexemptfirstname1<>(typeof(h.officerexemptfirstname1))'');
    populated_officerexemptlastname1_cnt := COUNT(GROUP,h.officerexemptlastname1 <> (TYPEOF(h.officerexemptlastname1))'');
    populated_officerexemptlastname1_pcnt := AVE(GROUP,IF(h.officerexemptlastname1 = (TYPEOF(h.officerexemptlastname1))'',0,100));
    maxlength_officerexemptlastname1 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.officerexemptlastname1)));
    avelength_officerexemptlastname1 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.officerexemptlastname1)),h.officerexemptlastname1<>(typeof(h.officerexemptlastname1))'');
    populated_officerexemptmiddlename1_cnt := COUNT(GROUP,h.officerexemptmiddlename1 <> (TYPEOF(h.officerexemptmiddlename1))'');
    populated_officerexemptmiddlename1_pcnt := AVE(GROUP,IF(h.officerexemptmiddlename1 = (TYPEOF(h.officerexemptmiddlename1))'',0,100));
    maxlength_officerexemptmiddlename1 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.officerexemptmiddlename1)));
    avelength_officerexemptmiddlename1 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.officerexemptmiddlename1)),h.officerexemptmiddlename1<>(typeof(h.officerexemptmiddlename1))'');
    populated_officerexempttitle1_cnt := COUNT(GROUP,h.officerexempttitle1 <> (TYPEOF(h.officerexempttitle1))'');
    populated_officerexempttitle1_pcnt := AVE(GROUP,IF(h.officerexempttitle1 = (TYPEOF(h.officerexempttitle1))'',0,100));
    maxlength_officerexempttitle1 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.officerexempttitle1)));
    avelength_officerexempttitle1 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.officerexempttitle1)),h.officerexempttitle1<>(typeof(h.officerexempttitle1))'');
    populated_officerexempteffectivedate1_cnt := COUNT(GROUP,h.officerexempteffectivedate1 <> (TYPEOF(h.officerexempteffectivedate1))'');
    populated_officerexempteffectivedate1_pcnt := AVE(GROUP,IF(h.officerexempteffectivedate1 = (TYPEOF(h.officerexempteffectivedate1))'',0,100));
    maxlength_officerexempteffectivedate1 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.officerexempteffectivedate1)));
    avelength_officerexempteffectivedate1 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.officerexempteffectivedate1)),h.officerexempteffectivedate1<>(typeof(h.officerexempteffectivedate1))'');
    populated_officerexemptterminationdate1_cnt := COUNT(GROUP,h.officerexemptterminationdate1 <> (TYPEOF(h.officerexemptterminationdate1))'');
    populated_officerexemptterminationdate1_pcnt := AVE(GROUP,IF(h.officerexemptterminationdate1 = (TYPEOF(h.officerexemptterminationdate1))'',0,100));
    maxlength_officerexemptterminationdate1 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.officerexemptterminationdate1)));
    avelength_officerexemptterminationdate1 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.officerexemptterminationdate1)),h.officerexemptterminationdate1<>(typeof(h.officerexemptterminationdate1))'');
    populated_officerexempttype1_cnt := COUNT(GROUP,h.officerexempttype1 <> (TYPEOF(h.officerexempttype1))'');
    populated_officerexempttype1_pcnt := AVE(GROUP,IF(h.officerexempttype1 = (TYPEOF(h.officerexempttype1))'',0,100));
    maxlength_officerexempttype1 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.officerexempttype1)));
    avelength_officerexempttype1 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.officerexempttype1)),h.officerexempttype1<>(typeof(h.officerexempttype1))'');
    populated_officerexemptbusinessactivities1_cnt := COUNT(GROUP,h.officerexemptbusinessactivities1 <> (TYPEOF(h.officerexemptbusinessactivities1))'');
    populated_officerexemptbusinessactivities1_pcnt := AVE(GROUP,IF(h.officerexemptbusinessactivities1 = (TYPEOF(h.officerexemptbusinessactivities1))'',0,100));
    maxlength_officerexemptbusinessactivities1 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.officerexemptbusinessactivities1)));
    avelength_officerexemptbusinessactivities1 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.officerexemptbusinessactivities1)),h.officerexemptbusinessactivities1<>(typeof(h.officerexemptbusinessactivities1))'');
    populated_officerexemptfirstname2_cnt := COUNT(GROUP,h.officerexemptfirstname2 <> (TYPEOF(h.officerexemptfirstname2))'');
    populated_officerexemptfirstname2_pcnt := AVE(GROUP,IF(h.officerexemptfirstname2 = (TYPEOF(h.officerexemptfirstname2))'',0,100));
    maxlength_officerexemptfirstname2 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.officerexemptfirstname2)));
    avelength_officerexemptfirstname2 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.officerexemptfirstname2)),h.officerexemptfirstname2<>(typeof(h.officerexemptfirstname2))'');
    populated_officerexemptlastname2_cnt := COUNT(GROUP,h.officerexemptlastname2 <> (TYPEOF(h.officerexemptlastname2))'');
    populated_officerexemptlastname2_pcnt := AVE(GROUP,IF(h.officerexemptlastname2 = (TYPEOF(h.officerexemptlastname2))'',0,100));
    maxlength_officerexemptlastname2 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.officerexemptlastname2)));
    avelength_officerexemptlastname2 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.officerexemptlastname2)),h.officerexemptlastname2<>(typeof(h.officerexemptlastname2))'');
    populated_officerexemptmiddlename2_cnt := COUNT(GROUP,h.officerexemptmiddlename2 <> (TYPEOF(h.officerexemptmiddlename2))'');
    populated_officerexemptmiddlename2_pcnt := AVE(GROUP,IF(h.officerexemptmiddlename2 = (TYPEOF(h.officerexemptmiddlename2))'',0,100));
    maxlength_officerexemptmiddlename2 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.officerexemptmiddlename2)));
    avelength_officerexemptmiddlename2 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.officerexemptmiddlename2)),h.officerexemptmiddlename2<>(typeof(h.officerexemptmiddlename2))'');
    populated_officerexempttitle2_cnt := COUNT(GROUP,h.officerexempttitle2 <> (TYPEOF(h.officerexempttitle2))'');
    populated_officerexempttitle2_pcnt := AVE(GROUP,IF(h.officerexempttitle2 = (TYPEOF(h.officerexempttitle2))'',0,100));
    maxlength_officerexempttitle2 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.officerexempttitle2)));
    avelength_officerexempttitle2 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.officerexempttitle2)),h.officerexempttitle2<>(typeof(h.officerexempttitle2))'');
    populated_officerexempteffectivedate2_cnt := COUNT(GROUP,h.officerexempteffectivedate2 <> (TYPEOF(h.officerexempteffectivedate2))'');
    populated_officerexempteffectivedate2_pcnt := AVE(GROUP,IF(h.officerexempteffectivedate2 = (TYPEOF(h.officerexempteffectivedate2))'',0,100));
    maxlength_officerexempteffectivedate2 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.officerexempteffectivedate2)));
    avelength_officerexempteffectivedate2 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.officerexempteffectivedate2)),h.officerexempteffectivedate2<>(typeof(h.officerexempteffectivedate2))'');
    populated_officerexemptterminationdate2_cnt := COUNT(GROUP,h.officerexemptterminationdate2 <> (TYPEOF(h.officerexemptterminationdate2))'');
    populated_officerexemptterminationdate2_pcnt := AVE(GROUP,IF(h.officerexemptterminationdate2 = (TYPEOF(h.officerexemptterminationdate2))'',0,100));
    maxlength_officerexemptterminationdate2 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.officerexemptterminationdate2)));
    avelength_officerexemptterminationdate2 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.officerexemptterminationdate2)),h.officerexemptterminationdate2<>(typeof(h.officerexemptterminationdate2))'');
    populated_officerexempttype2_cnt := COUNT(GROUP,h.officerexempttype2 <> (TYPEOF(h.officerexempttype2))'');
    populated_officerexempttype2_pcnt := AVE(GROUP,IF(h.officerexempttype2 = (TYPEOF(h.officerexempttype2))'',0,100));
    maxlength_officerexempttype2 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.officerexempttype2)));
    avelength_officerexempttype2 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.officerexempttype2)),h.officerexempttype2<>(typeof(h.officerexempttype2))'');
    populated_officerexemptbusinessactivities2_cnt := COUNT(GROUP,h.officerexemptbusinessactivities2 <> (TYPEOF(h.officerexemptbusinessactivities2))'');
    populated_officerexemptbusinessactivities2_pcnt := AVE(GROUP,IF(h.officerexemptbusinessactivities2 = (TYPEOF(h.officerexemptbusinessactivities2))'',0,100));
    maxlength_officerexemptbusinessactivities2 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.officerexemptbusinessactivities2)));
    avelength_officerexemptbusinessactivities2 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.officerexemptbusinessactivities2)),h.officerexemptbusinessactivities2<>(typeof(h.officerexemptbusinessactivities2))'');
    populated_officerexemptfirstname3_cnt := COUNT(GROUP,h.officerexemptfirstname3 <> (TYPEOF(h.officerexemptfirstname3))'');
    populated_officerexemptfirstname3_pcnt := AVE(GROUP,IF(h.officerexemptfirstname3 = (TYPEOF(h.officerexemptfirstname3))'',0,100));
    maxlength_officerexemptfirstname3 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.officerexemptfirstname3)));
    avelength_officerexemptfirstname3 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.officerexemptfirstname3)),h.officerexemptfirstname3<>(typeof(h.officerexemptfirstname3))'');
    populated_officerexemptlastname3_cnt := COUNT(GROUP,h.officerexemptlastname3 <> (TYPEOF(h.officerexemptlastname3))'');
    populated_officerexemptlastname3_pcnt := AVE(GROUP,IF(h.officerexemptlastname3 = (TYPEOF(h.officerexemptlastname3))'',0,100));
    maxlength_officerexemptlastname3 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.officerexemptlastname3)));
    avelength_officerexemptlastname3 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.officerexemptlastname3)),h.officerexemptlastname3<>(typeof(h.officerexemptlastname3))'');
    populated_officerexemptmiddlename3_cnt := COUNT(GROUP,h.officerexemptmiddlename3 <> (TYPEOF(h.officerexemptmiddlename3))'');
    populated_officerexemptmiddlename3_pcnt := AVE(GROUP,IF(h.officerexemptmiddlename3 = (TYPEOF(h.officerexemptmiddlename3))'',0,100));
    maxlength_officerexemptmiddlename3 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.officerexemptmiddlename3)));
    avelength_officerexemptmiddlename3 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.officerexemptmiddlename3)),h.officerexemptmiddlename3<>(typeof(h.officerexemptmiddlename3))'');
    populated_officerexempttitle3_cnt := COUNT(GROUP,h.officerexempttitle3 <> (TYPEOF(h.officerexempttitle3))'');
    populated_officerexempttitle3_pcnt := AVE(GROUP,IF(h.officerexempttitle3 = (TYPEOF(h.officerexempttitle3))'',0,100));
    maxlength_officerexempttitle3 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.officerexempttitle3)));
    avelength_officerexempttitle3 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.officerexempttitle3)),h.officerexempttitle3<>(typeof(h.officerexempttitle3))'');
    populated_officerexempteffectivedate3_cnt := COUNT(GROUP,h.officerexempteffectivedate3 <> (TYPEOF(h.officerexempteffectivedate3))'');
    populated_officerexempteffectivedate3_pcnt := AVE(GROUP,IF(h.officerexempteffectivedate3 = (TYPEOF(h.officerexempteffectivedate3))'',0,100));
    maxlength_officerexempteffectivedate3 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.officerexempteffectivedate3)));
    avelength_officerexempteffectivedate3 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.officerexempteffectivedate3)),h.officerexempteffectivedate3<>(typeof(h.officerexempteffectivedate3))'');
    populated_officerexemptterminationdate3_cnt := COUNT(GROUP,h.officerexemptterminationdate3 <> (TYPEOF(h.officerexemptterminationdate3))'');
    populated_officerexemptterminationdate3_pcnt := AVE(GROUP,IF(h.officerexemptterminationdate3 = (TYPEOF(h.officerexemptterminationdate3))'',0,100));
    maxlength_officerexemptterminationdate3 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.officerexemptterminationdate3)));
    avelength_officerexemptterminationdate3 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.officerexemptterminationdate3)),h.officerexemptterminationdate3<>(typeof(h.officerexemptterminationdate3))'');
    populated_officerexempttype3_cnt := COUNT(GROUP,h.officerexempttype3 <> (TYPEOF(h.officerexempttype3))'');
    populated_officerexempttype3_pcnt := AVE(GROUP,IF(h.officerexempttype3 = (TYPEOF(h.officerexempttype3))'',0,100));
    maxlength_officerexempttype3 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.officerexempttype3)));
    avelength_officerexempttype3 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.officerexempttype3)),h.officerexempttype3<>(typeof(h.officerexempttype3))'');
    populated_officerexemptbusinessactivities3_cnt := COUNT(GROUP,h.officerexemptbusinessactivities3 <> (TYPEOF(h.officerexemptbusinessactivities3))'');
    populated_officerexemptbusinessactivities3_pcnt := AVE(GROUP,IF(h.officerexemptbusinessactivities3 = (TYPEOF(h.officerexemptbusinessactivities3))'',0,100));
    maxlength_officerexemptbusinessactivities3 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.officerexemptbusinessactivities3)));
    avelength_officerexemptbusinessactivities3 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.officerexemptbusinessactivities3)),h.officerexemptbusinessactivities3<>(typeof(h.officerexemptbusinessactivities3))'');
    populated_officerexemptfirstname4_cnt := COUNT(GROUP,h.officerexemptfirstname4 <> (TYPEOF(h.officerexemptfirstname4))'');
    populated_officerexemptfirstname4_pcnt := AVE(GROUP,IF(h.officerexemptfirstname4 = (TYPEOF(h.officerexemptfirstname4))'',0,100));
    maxlength_officerexemptfirstname4 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.officerexemptfirstname4)));
    avelength_officerexemptfirstname4 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.officerexemptfirstname4)),h.officerexemptfirstname4<>(typeof(h.officerexemptfirstname4))'');
    populated_officerexemptlastname4_cnt := COUNT(GROUP,h.officerexemptlastname4 <> (TYPEOF(h.officerexemptlastname4))'');
    populated_officerexemptlastname4_pcnt := AVE(GROUP,IF(h.officerexemptlastname4 = (TYPEOF(h.officerexemptlastname4))'',0,100));
    maxlength_officerexemptlastname4 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.officerexemptlastname4)));
    avelength_officerexemptlastname4 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.officerexemptlastname4)),h.officerexemptlastname4<>(typeof(h.officerexemptlastname4))'');
    populated_officerexemptmiddlename4_cnt := COUNT(GROUP,h.officerexemptmiddlename4 <> (TYPEOF(h.officerexemptmiddlename4))'');
    populated_officerexemptmiddlename4_pcnt := AVE(GROUP,IF(h.officerexemptmiddlename4 = (TYPEOF(h.officerexemptmiddlename4))'',0,100));
    maxlength_officerexemptmiddlename4 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.officerexemptmiddlename4)));
    avelength_officerexemptmiddlename4 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.officerexemptmiddlename4)),h.officerexemptmiddlename4<>(typeof(h.officerexemptmiddlename4))'');
    populated_officerexempttitle4_cnt := COUNT(GROUP,h.officerexempttitle4 <> (TYPEOF(h.officerexempttitle4))'');
    populated_officerexempttitle4_pcnt := AVE(GROUP,IF(h.officerexempttitle4 = (TYPEOF(h.officerexempttitle4))'',0,100));
    maxlength_officerexempttitle4 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.officerexempttitle4)));
    avelength_officerexempttitle4 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.officerexempttitle4)),h.officerexempttitle4<>(typeof(h.officerexempttitle4))'');
    populated_officerexempteffectivedate4_cnt := COUNT(GROUP,h.officerexempteffectivedate4 <> (TYPEOF(h.officerexempteffectivedate4))'');
    populated_officerexempteffectivedate4_pcnt := AVE(GROUP,IF(h.officerexempteffectivedate4 = (TYPEOF(h.officerexempteffectivedate4))'',0,100));
    maxlength_officerexempteffectivedate4 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.officerexempteffectivedate4)));
    avelength_officerexempteffectivedate4 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.officerexempteffectivedate4)),h.officerexempteffectivedate4<>(typeof(h.officerexempteffectivedate4))'');
    populated_officerexemptterminationdate4_cnt := COUNT(GROUP,h.officerexemptterminationdate4 <> (TYPEOF(h.officerexemptterminationdate4))'');
    populated_officerexemptterminationdate4_pcnt := AVE(GROUP,IF(h.officerexemptterminationdate4 = (TYPEOF(h.officerexemptterminationdate4))'',0,100));
    maxlength_officerexemptterminationdate4 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.officerexemptterminationdate4)));
    avelength_officerexemptterminationdate4 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.officerexemptterminationdate4)),h.officerexemptterminationdate4<>(typeof(h.officerexemptterminationdate4))'');
    populated_officerexempttype4_cnt := COUNT(GROUP,h.officerexempttype4 <> (TYPEOF(h.officerexempttype4))'');
    populated_officerexempttype4_pcnt := AVE(GROUP,IF(h.officerexempttype4 = (TYPEOF(h.officerexempttype4))'',0,100));
    maxlength_officerexempttype4 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.officerexempttype4)));
    avelength_officerexempttype4 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.officerexempttype4)),h.officerexempttype4<>(typeof(h.officerexempttype4))'');
    populated_officerexemptbusinessactivities4_cnt := COUNT(GROUP,h.officerexemptbusinessactivities4 <> (TYPEOF(h.officerexemptbusinessactivities4))'');
    populated_officerexemptbusinessactivities4_pcnt := AVE(GROUP,IF(h.officerexemptbusinessactivities4 = (TYPEOF(h.officerexemptbusinessactivities4))'',0,100));
    maxlength_officerexemptbusinessactivities4 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.officerexemptbusinessactivities4)));
    avelength_officerexemptbusinessactivities4 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.officerexemptbusinessactivities4)),h.officerexemptbusinessactivities4<>(typeof(h.officerexemptbusinessactivities4))'');
    populated_officerexemptfirstname5_cnt := COUNT(GROUP,h.officerexemptfirstname5 <> (TYPEOF(h.officerexemptfirstname5))'');
    populated_officerexemptfirstname5_pcnt := AVE(GROUP,IF(h.officerexemptfirstname5 = (TYPEOF(h.officerexemptfirstname5))'',0,100));
    maxlength_officerexemptfirstname5 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.officerexemptfirstname5)));
    avelength_officerexemptfirstname5 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.officerexemptfirstname5)),h.officerexemptfirstname5<>(typeof(h.officerexemptfirstname5))'');
    populated_officerexemptlastname5_cnt := COUNT(GROUP,h.officerexemptlastname5 <> (TYPEOF(h.officerexemptlastname5))'');
    populated_officerexemptlastname5_pcnt := AVE(GROUP,IF(h.officerexemptlastname5 = (TYPEOF(h.officerexemptlastname5))'',0,100));
    maxlength_officerexemptlastname5 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.officerexemptlastname5)));
    avelength_officerexemptlastname5 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.officerexemptlastname5)),h.officerexemptlastname5<>(typeof(h.officerexemptlastname5))'');
    populated_officerexemptmiddlename5_cnt := COUNT(GROUP,h.officerexemptmiddlename5 <> (TYPEOF(h.officerexemptmiddlename5))'');
    populated_officerexemptmiddlename5_pcnt := AVE(GROUP,IF(h.officerexemptmiddlename5 = (TYPEOF(h.officerexemptmiddlename5))'',0,100));
    maxlength_officerexemptmiddlename5 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.officerexemptmiddlename5)));
    avelength_officerexemptmiddlename5 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.officerexemptmiddlename5)),h.officerexemptmiddlename5<>(typeof(h.officerexemptmiddlename5))'');
    populated_officerexempttitle5_cnt := COUNT(GROUP,h.officerexempttitle5 <> (TYPEOF(h.officerexempttitle5))'');
    populated_officerexempttitle5_pcnt := AVE(GROUP,IF(h.officerexempttitle5 = (TYPEOF(h.officerexempttitle5))'',0,100));
    maxlength_officerexempttitle5 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.officerexempttitle5)));
    avelength_officerexempttitle5 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.officerexempttitle5)),h.officerexempttitle5<>(typeof(h.officerexempttitle5))'');
    populated_officerexempteffectivedate5_cnt := COUNT(GROUP,h.officerexempteffectivedate5 <> (TYPEOF(h.officerexempteffectivedate5))'');
    populated_officerexempteffectivedate5_pcnt := AVE(GROUP,IF(h.officerexempteffectivedate5 = (TYPEOF(h.officerexempteffectivedate5))'',0,100));
    maxlength_officerexempteffectivedate5 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.officerexempteffectivedate5)));
    avelength_officerexempteffectivedate5 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.officerexempteffectivedate5)),h.officerexempteffectivedate5<>(typeof(h.officerexempteffectivedate5))'');
    populated_officerexemptterminationdate5_cnt := COUNT(GROUP,h.officerexemptterminationdate5 <> (TYPEOF(h.officerexemptterminationdate5))'');
    populated_officerexemptterminationdate5_pcnt := AVE(GROUP,IF(h.officerexemptterminationdate5 = (TYPEOF(h.officerexemptterminationdate5))'',0,100));
    maxlength_officerexemptterminationdate5 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.officerexemptterminationdate5)));
    avelength_officerexemptterminationdate5 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.officerexemptterminationdate5)),h.officerexemptterminationdate5<>(typeof(h.officerexemptterminationdate5))'');
    populated_officerexempttype5_cnt := COUNT(GROUP,h.officerexempttype5 <> (TYPEOF(h.officerexempttype5))'');
    populated_officerexempttype5_pcnt := AVE(GROUP,IF(h.officerexempttype5 = (TYPEOF(h.officerexempttype5))'',0,100));
    maxlength_officerexempttype5 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.officerexempttype5)));
    avelength_officerexempttype5 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.officerexempttype5)),h.officerexempttype5<>(typeof(h.officerexempttype5))'');
    populated_officerexemptbusinessactivities5_cnt := COUNT(GROUP,h.officerexemptbusinessactivities5 <> (TYPEOF(h.officerexemptbusinessactivities5))'');
    populated_officerexemptbusinessactivities5_pcnt := AVE(GROUP,IF(h.officerexemptbusinessactivities5 = (TYPEOF(h.officerexemptbusinessactivities5))'',0,100));
    maxlength_officerexemptbusinessactivities5 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.officerexemptbusinessactivities5)));
    avelength_officerexemptbusinessactivities5 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.officerexemptbusinessactivities5)),h.officerexemptbusinessactivities5<>(typeof(h.officerexemptbusinessactivities5))'');
    populated_dba1_cnt := COUNT(GROUP,h.dba1 <> (TYPEOF(h.dba1))'');
    populated_dba1_pcnt := AVE(GROUP,IF(h.dba1 = (TYPEOF(h.dba1))'',0,100));
    maxlength_dba1 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.dba1)));
    avelength_dba1 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.dba1)),h.dba1<>(typeof(h.dba1))'');
    populated_dbadatefrom1_cnt := COUNT(GROUP,h.dbadatefrom1 <> (TYPEOF(h.dbadatefrom1))'');
    populated_dbadatefrom1_pcnt := AVE(GROUP,IF(h.dbadatefrom1 = (TYPEOF(h.dbadatefrom1))'',0,100));
    maxlength_dbadatefrom1 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.dbadatefrom1)));
    avelength_dbadatefrom1 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.dbadatefrom1)),h.dbadatefrom1<>(typeof(h.dbadatefrom1))'');
    populated_dbadateto1_cnt := COUNT(GROUP,h.dbadateto1 <> (TYPEOF(h.dbadateto1))'');
    populated_dbadateto1_pcnt := AVE(GROUP,IF(h.dbadateto1 = (TYPEOF(h.dbadateto1))'',0,100));
    maxlength_dbadateto1 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.dbadateto1)));
    avelength_dbadateto1 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.dbadateto1)),h.dbadateto1<>(typeof(h.dbadateto1))'');
    populated_dbatype1_cnt := COUNT(GROUP,h.dbatype1 <> (TYPEOF(h.dbatype1))'');
    populated_dbatype1_pcnt := AVE(GROUP,IF(h.dbatype1 = (TYPEOF(h.dbatype1))'',0,100));
    maxlength_dbatype1 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.dbatype1)));
    avelength_dbatype1 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.dbatype1)),h.dbatype1<>(typeof(h.dbatype1))'');
    populated_dba2_cnt := COUNT(GROUP,h.dba2 <> (TYPEOF(h.dba2))'');
    populated_dba2_pcnt := AVE(GROUP,IF(h.dba2 = (TYPEOF(h.dba2))'',0,100));
    maxlength_dba2 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.dba2)));
    avelength_dba2 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.dba2)),h.dba2<>(typeof(h.dba2))'');
    populated_dbadatefrom2_cnt := COUNT(GROUP,h.dbadatefrom2 <> (TYPEOF(h.dbadatefrom2))'');
    populated_dbadatefrom2_pcnt := AVE(GROUP,IF(h.dbadatefrom2 = (TYPEOF(h.dbadatefrom2))'',0,100));
    maxlength_dbadatefrom2 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.dbadatefrom2)));
    avelength_dbadatefrom2 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.dbadatefrom2)),h.dbadatefrom2<>(typeof(h.dbadatefrom2))'');
    populated_dbadateto2_cnt := COUNT(GROUP,h.dbadateto2 <> (TYPEOF(h.dbadateto2))'');
    populated_dbadateto2_pcnt := AVE(GROUP,IF(h.dbadateto2 = (TYPEOF(h.dbadateto2))'',0,100));
    maxlength_dbadateto2 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.dbadateto2)));
    avelength_dbadateto2 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.dbadateto2)),h.dbadateto2<>(typeof(h.dbadateto2))'');
    populated_dbatype2_cnt := COUNT(GROUP,h.dbatype2 <> (TYPEOF(h.dbatype2))'');
    populated_dbatype2_pcnt := AVE(GROUP,IF(h.dbatype2 = (TYPEOF(h.dbatype2))'',0,100));
    maxlength_dbatype2 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.dbatype2)));
    avelength_dbatype2 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.dbatype2)),h.dbatype2<>(typeof(h.dbatype2))'');
    populated_dba3_cnt := COUNT(GROUP,h.dba3 <> (TYPEOF(h.dba3))'');
    populated_dba3_pcnt := AVE(GROUP,IF(h.dba3 = (TYPEOF(h.dba3))'',0,100));
    maxlength_dba3 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.dba3)));
    avelength_dba3 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.dba3)),h.dba3<>(typeof(h.dba3))'');
    populated_dbadatefrom3_cnt := COUNT(GROUP,h.dbadatefrom3 <> (TYPEOF(h.dbadatefrom3))'');
    populated_dbadatefrom3_pcnt := AVE(GROUP,IF(h.dbadatefrom3 = (TYPEOF(h.dbadatefrom3))'',0,100));
    maxlength_dbadatefrom3 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.dbadatefrom3)));
    avelength_dbadatefrom3 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.dbadatefrom3)),h.dbadatefrom3<>(typeof(h.dbadatefrom3))'');
    populated_dbadateto3_cnt := COUNT(GROUP,h.dbadateto3 <> (TYPEOF(h.dbadateto3))'');
    populated_dbadateto3_pcnt := AVE(GROUP,IF(h.dbadateto3 = (TYPEOF(h.dbadateto3))'',0,100));
    maxlength_dbadateto3 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.dbadateto3)));
    avelength_dbadateto3 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.dbadateto3)),h.dbadateto3<>(typeof(h.dbadateto3))'');
    populated_dbatype3_cnt := COUNT(GROUP,h.dbatype3 <> (TYPEOF(h.dbatype3))'');
    populated_dbatype3_pcnt := AVE(GROUP,IF(h.dbatype3 = (TYPEOF(h.dbatype3))'',0,100));
    maxlength_dbatype3 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.dbatype3)));
    avelength_dbatype3 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.dbatype3)),h.dbatype3<>(typeof(h.dbatype3))'');
    populated_dba4_cnt := COUNT(GROUP,h.dba4 <> (TYPEOF(h.dba4))'');
    populated_dba4_pcnt := AVE(GROUP,IF(h.dba4 = (TYPEOF(h.dba4))'',0,100));
    maxlength_dba4 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.dba4)));
    avelength_dba4 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.dba4)),h.dba4<>(typeof(h.dba4))'');
    populated_dbadatefrom4_cnt := COUNT(GROUP,h.dbadatefrom4 <> (TYPEOF(h.dbadatefrom4))'');
    populated_dbadatefrom4_pcnt := AVE(GROUP,IF(h.dbadatefrom4 = (TYPEOF(h.dbadatefrom4))'',0,100));
    maxlength_dbadatefrom4 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.dbadatefrom4)));
    avelength_dbadatefrom4 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.dbadatefrom4)),h.dbadatefrom4<>(typeof(h.dbadatefrom4))'');
    populated_dbadateto4_cnt := COUNT(GROUP,h.dbadateto4 <> (TYPEOF(h.dbadateto4))'');
    populated_dbadateto4_pcnt := AVE(GROUP,IF(h.dbadateto4 = (TYPEOF(h.dbadateto4))'',0,100));
    maxlength_dbadateto4 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.dbadateto4)));
    avelength_dbadateto4 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.dbadateto4)),h.dbadateto4<>(typeof(h.dbadateto4))'');
    populated_dbatype4_cnt := COUNT(GROUP,h.dbatype4 <> (TYPEOF(h.dbatype4))'');
    populated_dbatype4_pcnt := AVE(GROUP,IF(h.dbatype4 = (TYPEOF(h.dbatype4))'',0,100));
    maxlength_dbatype4 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.dbatype4)));
    avelength_dbatype4 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.dbatype4)),h.dbatype4<>(typeof(h.dbatype4))'');
    populated_dba5_cnt := COUNT(GROUP,h.dba5 <> (TYPEOF(h.dba5))'');
    populated_dba5_pcnt := AVE(GROUP,IF(h.dba5 = (TYPEOF(h.dba5))'',0,100));
    maxlength_dba5 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.dba5)));
    avelength_dba5 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.dba5)),h.dba5<>(typeof(h.dba5))'');
    populated_dbadatefrom5_cnt := COUNT(GROUP,h.dbadatefrom5 <> (TYPEOF(h.dbadatefrom5))'');
    populated_dbadatefrom5_pcnt := AVE(GROUP,IF(h.dbadatefrom5 = (TYPEOF(h.dbadatefrom5))'',0,100));
    maxlength_dbadatefrom5 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.dbadatefrom5)));
    avelength_dbadatefrom5 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.dbadatefrom5)),h.dbadatefrom5<>(typeof(h.dbadatefrom5))'');
    populated_dbadateto5_cnt := COUNT(GROUP,h.dbadateto5 <> (TYPEOF(h.dbadateto5))'');
    populated_dbadateto5_pcnt := AVE(GROUP,IF(h.dbadateto5 = (TYPEOF(h.dbadateto5))'',0,100));
    maxlength_dbadateto5 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.dbadateto5)));
    avelength_dbadateto5 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.dbadateto5)),h.dbadateto5<>(typeof(h.dbadateto5))'');
    populated_dbatype5_cnt := COUNT(GROUP,h.dbatype5 <> (TYPEOF(h.dbatype5))'');
    populated_dbatype5_pcnt := AVE(GROUP,IF(h.dbatype5 = (TYPEOF(h.dbatype5))'',0,100));
    maxlength_dbatype5 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.dbatype5)));
    avelength_dbatype5 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.dbatype5)),h.dbatype5<>(typeof(h.dbatype5))'');
    populated_subsidiaryname1_cnt := COUNT(GROUP,h.subsidiaryname1 <> (TYPEOF(h.subsidiaryname1))'');
    populated_subsidiaryname1_pcnt := AVE(GROUP,IF(h.subsidiaryname1 = (TYPEOF(h.subsidiaryname1))'',0,100));
    maxlength_subsidiaryname1 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.subsidiaryname1)));
    avelength_subsidiaryname1 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.subsidiaryname1)),h.subsidiaryname1<>(typeof(h.subsidiaryname1))'');
    populated_subsidiarystartdate1_cnt := COUNT(GROUP,h.subsidiarystartdate1 <> (TYPEOF(h.subsidiarystartdate1))'');
    populated_subsidiarystartdate1_pcnt := AVE(GROUP,IF(h.subsidiarystartdate1 = (TYPEOF(h.subsidiarystartdate1))'',0,100));
    maxlength_subsidiarystartdate1 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.subsidiarystartdate1)));
    avelength_subsidiarystartdate1 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.subsidiarystartdate1)),h.subsidiarystartdate1<>(typeof(h.subsidiarystartdate1))'');
    populated_subsidiaryname2_cnt := COUNT(GROUP,h.subsidiaryname2 <> (TYPEOF(h.subsidiaryname2))'');
    populated_subsidiaryname2_pcnt := AVE(GROUP,IF(h.subsidiaryname2 = (TYPEOF(h.subsidiaryname2))'',0,100));
    maxlength_subsidiaryname2 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.subsidiaryname2)));
    avelength_subsidiaryname2 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.subsidiaryname2)),h.subsidiaryname2<>(typeof(h.subsidiaryname2))'');
    populated_subsidiarystartdate2_cnt := COUNT(GROUP,h.subsidiarystartdate2 <> (TYPEOF(h.subsidiarystartdate2))'');
    populated_subsidiarystartdate2_pcnt := AVE(GROUP,IF(h.subsidiarystartdate2 = (TYPEOF(h.subsidiarystartdate2))'',0,100));
    maxlength_subsidiarystartdate2 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.subsidiarystartdate2)));
    avelength_subsidiarystartdate2 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.subsidiarystartdate2)),h.subsidiarystartdate2<>(typeof(h.subsidiarystartdate2))'');
    populated_subsidiaryname3_cnt := COUNT(GROUP,h.subsidiaryname3 <> (TYPEOF(h.subsidiaryname3))'');
    populated_subsidiaryname3_pcnt := AVE(GROUP,IF(h.subsidiaryname3 = (TYPEOF(h.subsidiaryname3))'',0,100));
    maxlength_subsidiaryname3 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.subsidiaryname3)));
    avelength_subsidiaryname3 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.subsidiaryname3)),h.subsidiaryname3<>(typeof(h.subsidiaryname3))'');
    populated_subsidiarystartdate3_cnt := COUNT(GROUP,h.subsidiarystartdate3 <> (TYPEOF(h.subsidiarystartdate3))'');
    populated_subsidiarystartdate3_pcnt := AVE(GROUP,IF(h.subsidiarystartdate3 = (TYPEOF(h.subsidiarystartdate3))'',0,100));
    maxlength_subsidiarystartdate3 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.subsidiarystartdate3)));
    avelength_subsidiarystartdate3 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.subsidiarystartdate3)),h.subsidiarystartdate3<>(typeof(h.subsidiarystartdate3))'');
    populated_subsidiaryname4_cnt := COUNT(GROUP,h.subsidiaryname4 <> (TYPEOF(h.subsidiaryname4))'');
    populated_subsidiaryname4_pcnt := AVE(GROUP,IF(h.subsidiaryname4 = (TYPEOF(h.subsidiaryname4))'',0,100));
    maxlength_subsidiaryname4 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.subsidiaryname4)));
    avelength_subsidiaryname4 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.subsidiaryname4)),h.subsidiaryname4<>(typeof(h.subsidiaryname4))'');
    populated_subsidiarystartdate4_cnt := COUNT(GROUP,h.subsidiarystartdate4 <> (TYPEOF(h.subsidiarystartdate4))'');
    populated_subsidiarystartdate4_pcnt := AVE(GROUP,IF(h.subsidiarystartdate4 = (TYPEOF(h.subsidiarystartdate4))'',0,100));
    maxlength_subsidiarystartdate4 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.subsidiarystartdate4)));
    avelength_subsidiarystartdate4 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.subsidiarystartdate4)),h.subsidiarystartdate4<>(typeof(h.subsidiarystartdate4))'');
    populated_subsidiaryname5_cnt := COUNT(GROUP,h.subsidiaryname5 <> (TYPEOF(h.subsidiaryname5))'');
    populated_subsidiaryname5_pcnt := AVE(GROUP,IF(h.subsidiaryname5 = (TYPEOF(h.subsidiaryname5))'',0,100));
    maxlength_subsidiaryname5 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.subsidiaryname5)));
    avelength_subsidiaryname5 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.subsidiaryname5)),h.subsidiaryname5<>(typeof(h.subsidiaryname5))'');
    populated_subsidiarystartdate5_cnt := COUNT(GROUP,h.subsidiarystartdate5 <> (TYPEOF(h.subsidiarystartdate5))'');
    populated_subsidiarystartdate5_pcnt := AVE(GROUP,IF(h.subsidiarystartdate5 = (TYPEOF(h.subsidiarystartdate5))'',0,100));
    maxlength_subsidiarystartdate5 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.subsidiarystartdate5)));
    avelength_subsidiarystartdate5 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.subsidiarystartdate5)),h.subsidiarystartdate5<>(typeof(h.subsidiarystartdate5))'');
    populated_subsidiaryname6_cnt := COUNT(GROUP,h.subsidiaryname6 <> (TYPEOF(h.subsidiaryname6))'');
    populated_subsidiaryname6_pcnt := AVE(GROUP,IF(h.subsidiaryname6 = (TYPEOF(h.subsidiaryname6))'',0,100));
    maxlength_subsidiaryname6 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.subsidiaryname6)));
    avelength_subsidiaryname6 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.subsidiaryname6)),h.subsidiaryname6<>(typeof(h.subsidiaryname6))'');
    populated_subsidiarystartdate6_cnt := COUNT(GROUP,h.subsidiarystartdate6 <> (TYPEOF(h.subsidiarystartdate6))'');
    populated_subsidiarystartdate6_pcnt := AVE(GROUP,IF(h.subsidiarystartdate6 = (TYPEOF(h.subsidiarystartdate6))'',0,100));
    maxlength_subsidiarystartdate6 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.subsidiarystartdate6)));
    avelength_subsidiarystartdate6 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.subsidiarystartdate6)),h.subsidiarystartdate6<>(typeof(h.subsidiarystartdate6))'');
    populated_subsidiaryname7_cnt := COUNT(GROUP,h.subsidiaryname7 <> (TYPEOF(h.subsidiaryname7))'');
    populated_subsidiaryname7_pcnt := AVE(GROUP,IF(h.subsidiaryname7 = (TYPEOF(h.subsidiaryname7))'',0,100));
    maxlength_subsidiaryname7 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.subsidiaryname7)));
    avelength_subsidiaryname7 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.subsidiaryname7)),h.subsidiaryname7<>(typeof(h.subsidiaryname7))'');
    populated_subsidiarystartdate7_cnt := COUNT(GROUP,h.subsidiarystartdate7 <> (TYPEOF(h.subsidiarystartdate7))'');
    populated_subsidiarystartdate7_pcnt := AVE(GROUP,IF(h.subsidiarystartdate7 = (TYPEOF(h.subsidiarystartdate7))'',0,100));
    maxlength_subsidiarystartdate7 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.subsidiarystartdate7)));
    avelength_subsidiarystartdate7 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.subsidiarystartdate7)),h.subsidiarystartdate7<>(typeof(h.subsidiarystartdate7))'');
    populated_subsidiaryname8_cnt := COUNT(GROUP,h.subsidiaryname8 <> (TYPEOF(h.subsidiaryname8))'');
    populated_subsidiaryname8_pcnt := AVE(GROUP,IF(h.subsidiaryname8 = (TYPEOF(h.subsidiaryname8))'',0,100));
    maxlength_subsidiaryname8 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.subsidiaryname8)));
    avelength_subsidiaryname8 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.subsidiaryname8)),h.subsidiaryname8<>(typeof(h.subsidiaryname8))'');
    populated_subsidiarystartdate8_cnt := COUNT(GROUP,h.subsidiarystartdate8 <> (TYPEOF(h.subsidiarystartdate8))'');
    populated_subsidiarystartdate8_pcnt := AVE(GROUP,IF(h.subsidiarystartdate8 = (TYPEOF(h.subsidiarystartdate8))'',0,100));
    maxlength_subsidiarystartdate8 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.subsidiarystartdate8)));
    avelength_subsidiarystartdate8 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.subsidiarystartdate8)),h.subsidiarystartdate8<>(typeof(h.subsidiarystartdate8))'');
    populated_subsidiaryname9_cnt := COUNT(GROUP,h.subsidiaryname9 <> (TYPEOF(h.subsidiaryname9))'');
    populated_subsidiaryname9_pcnt := AVE(GROUP,IF(h.subsidiaryname9 = (TYPEOF(h.subsidiaryname9))'',0,100));
    maxlength_subsidiaryname9 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.subsidiaryname9)));
    avelength_subsidiaryname9 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.subsidiaryname9)),h.subsidiaryname9<>(typeof(h.subsidiaryname9))'');
    populated_subsidiarystartdate9_cnt := COUNT(GROUP,h.subsidiarystartdate9 <> (TYPEOF(h.subsidiarystartdate9))'');
    populated_subsidiarystartdate9_pcnt := AVE(GROUP,IF(h.subsidiarystartdate9 = (TYPEOF(h.subsidiarystartdate9))'',0,100));
    maxlength_subsidiarystartdate9 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.subsidiarystartdate9)));
    avelength_subsidiarystartdate9 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.subsidiarystartdate9)),h.subsidiarystartdate9<>(typeof(h.subsidiarystartdate9))'');
    populated_subsidiaryname10_cnt := COUNT(GROUP,h.subsidiaryname10 <> (TYPEOF(h.subsidiaryname10))'');
    populated_subsidiaryname10_pcnt := AVE(GROUP,IF(h.subsidiaryname10 = (TYPEOF(h.subsidiaryname10))'',0,100));
    maxlength_subsidiaryname10 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.subsidiaryname10)));
    avelength_subsidiaryname10 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.subsidiaryname10)),h.subsidiaryname10<>(typeof(h.subsidiaryname10))'');
    populated_subsidiarystartdate10_cnt := COUNT(GROUP,h.subsidiarystartdate10 <> (TYPEOF(h.subsidiarystartdate10))'');
    populated_subsidiarystartdate10_pcnt := AVE(GROUP,IF(h.subsidiarystartdate10 = (TYPEOF(h.subsidiarystartdate10))'',0,100));
    maxlength_subsidiarystartdate10 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.subsidiarystartdate10)));
    avelength_subsidiarystartdate10 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.subsidiarystartdate10)),h.subsidiarystartdate10<>(typeof(h.subsidiarystartdate10))'');
  END;
    T := TABLE(h,SummaryLayout);
  R1 := RECORD
    UNSIGNED LinkingPotential :=  + T.Populated_dartid_pcnt *   0.00 / 100 + T.Populated_dateadded_pcnt *   0.00 / 100 + T.Populated_dateupdated_pcnt *   0.00 / 100 + T.Populated_website_pcnt *   0.00 / 100 + T.Populated_state_pcnt *   0.00 / 100 + T.Populated_lninscertrecordid_pcnt *   0.00 / 100 + T.Populated_profilelastupdated_pcnt *   0.00 / 100 + T.Populated_siid_pcnt *   0.00 / 100 + T.Populated_sipstatuscode_pcnt *   0.00 / 100 + T.Populated_wcbempnumber_pcnt *   0.00 / 100 + T.Populated_ubinumber_pcnt *   0.00 / 100 + T.Populated_cofanumber_pcnt *   0.00 / 100 + T.Populated_usdotnumber_pcnt *   0.00 / 100 + T.Populated_businessname_pcnt *   0.00 / 100 + T.Populated_dba_pcnt *   0.00 / 100 + T.Populated_addressline1_pcnt *   0.00 / 100 + T.Populated_addressline2_pcnt *   0.00 / 100 + T.Populated_addresscity_pcnt *   0.00 / 100 + T.Populated_addressstate_pcnt *   0.00 / 100 + T.Populated_addresszip_pcnt *   0.00 / 100 + T.Populated_zip4_pcnt *   0.00 / 100 + T.Populated_phone1_pcnt *   0.00 / 100 + T.Populated_phone2_pcnt *   0.00 / 100 + T.Populated_phone3_pcnt *   0.00 / 100 + T.Populated_fax1_pcnt *   0.00 / 100 + T.Populated_fax2_pcnt *   0.00 / 100 + T.Populated_email1_pcnt *   0.00 / 100 + T.Populated_email2_pcnt *   0.00 / 100 + T.Populated_businesstype_pcnt *   0.00 / 100 + T.Populated_namefirst_pcnt *   0.00 / 100 + T.Populated_namemiddle_pcnt *   0.00 / 100 + T.Populated_namelast_pcnt *   0.00 / 100 + T.Populated_namesuffix_pcnt *   0.00 / 100 + T.Populated_nametitle_pcnt *   0.00 / 100 + T.Populated_mailingaddress1_pcnt *   0.00 / 100 + T.Populated_mailingaddress2_pcnt *   0.00 / 100 + T.Populated_mailingaddresscity_pcnt *   0.00 / 100 + T.Populated_mailingaddressstate_pcnt *   0.00 / 100 + T.Populated_mailingaddresszip_pcnt *   0.00 / 100 + T.Populated_mailingaddresszip4_pcnt *   0.00 / 100 + T.Populated_contactnamefirst_pcnt *   0.00 / 100 + T.Populated_contactnamemiddle_pcnt *   0.00 / 100 + T.Populated_contactnamelast_pcnt *   0.00 / 100 + T.Populated_contactnamesuffix_pcnt *   0.00 / 100 + T.Populated_contactbusinessname_pcnt *   0.00 / 100 + T.Populated_contactaddressline1_pcnt *   0.00 / 100 + T.Populated_contactaddressline2_pcnt *   0.00 / 100 + T.Populated_contactcity_pcnt *   0.00 / 100 + T.Populated_contactstate_pcnt *   0.00 / 100 + T.Populated_contactzip_pcnt *   0.00 / 100 + T.Populated_contactzip4_pcnt *   0.00 / 100 + T.Populated_contactphone_pcnt *   0.00 / 100 + T.Populated_contactfax_pcnt *   0.00 / 100 + T.Populated_contactemail_pcnt *   0.00 / 100 + T.Populated_policyholdernamefirst_pcnt *   0.00 / 100 + T.Populated_policyholdernamemiddle_pcnt *   0.00 / 100 + T.Populated_policyholdernamelast_pcnt *   0.00 / 100 + T.Populated_policyholdernamesuffix_pcnt *   0.00 / 100 + T.Populated_statepolicyfilenumber_pcnt *   0.00 / 100 + T.Populated_coverageinjuryillnessdate_pcnt *   0.00 / 100 + T.Populated_selfinsurancegroup_pcnt *   0.00 / 100 + T.Populated_selfinsurancegroupphone_pcnt *   0.00 / 100 + T.Populated_selfinsurancegroupid_pcnt *   0.00 / 100 + T.Populated_numberofemployees_pcnt *   0.00 / 100 + T.Populated_licensedcontractor_pcnt *   0.00 / 100 + T.Populated_mconame_pcnt *   0.00 / 100 + T.Populated_mconumber_pcnt *   0.00 / 100 + T.Populated_mcoaddressline1_pcnt *   0.00 / 100 + T.Populated_mcoaddressline2_pcnt *   0.00 / 100 + T.Populated_mcocity_pcnt *   0.00 / 100 + T.Populated_mcostate_pcnt *   0.00 / 100 + T.Populated_mcozip_pcnt *   0.00 / 100 + T.Populated_mcozip4_pcnt *   0.00 / 100 + T.Populated_mcophone_pcnt *   0.00 / 100 + T.Populated_governingclasscode_pcnt *   0.00 / 100 + T.Populated_licensenumber_pcnt *   0.00 / 100 + T.Populated_class_pcnt *   0.00 / 100 + T.Populated_classificationdescription_pcnt *   0.00 / 100 + T.Populated_licensestatus_pcnt *   0.00 / 100 + T.Populated_licenseadditionalinfo_pcnt *   0.00 / 100 + T.Populated_licenseissuedate_pcnt *   0.00 / 100 + T.Populated_licenseexpirationdate_pcnt *   0.00 / 100 + T.Populated_naicscode_pcnt *   0.00 / 100 + T.Populated_officerexemptfirstname1_pcnt *   0.00 / 100 + T.Populated_officerexemptlastname1_pcnt *   0.00 / 100 + T.Populated_officerexemptmiddlename1_pcnt *   0.00 / 100 + T.Populated_officerexempttitle1_pcnt *   0.00 / 100 + T.Populated_officerexempteffectivedate1_pcnt *   0.00 / 100 + T.Populated_officerexemptterminationdate1_pcnt *   0.00 / 100 + T.Populated_officerexempttype1_pcnt *   0.00 / 100 + T.Populated_officerexemptbusinessactivities1_pcnt *   0.00 / 100 + T.Populated_officerexemptfirstname2_pcnt *   0.00 / 100 + T.Populated_officerexemptlastname2_pcnt *   0.00 / 100 + T.Populated_officerexemptmiddlename2_pcnt *   0.00 / 100 + T.Populated_officerexempttitle2_pcnt *   0.00 / 100 + T.Populated_officerexempteffectivedate2_pcnt *   0.00 / 100 + T.Populated_officerexemptterminationdate2_pcnt *   0.00 / 100 + T.Populated_officerexempttype2_pcnt *   0.00 / 100 + T.Populated_officerexemptbusinessactivities2_pcnt *   0.00 / 100 + T.Populated_officerexemptfirstname3_pcnt *   0.00 / 100 + T.Populated_officerexemptlastname3_pcnt *   0.00 / 100 + T.Populated_officerexemptmiddlename3_pcnt *   0.00 / 100 + T.Populated_officerexempttitle3_pcnt *   0.00 / 100 + T.Populated_officerexempteffectivedate3_pcnt *   0.00 / 100 + T.Populated_officerexemptterminationdate3_pcnt *   0.00 / 100 + T.Populated_officerexempttype3_pcnt *   0.00 / 100 + T.Populated_officerexemptbusinessactivities3_pcnt *   0.00 / 100 + T.Populated_officerexemptfirstname4_pcnt *   0.00 / 100 + T.Populated_officerexemptlastname4_pcnt *   0.00 / 100 + T.Populated_officerexemptmiddlename4_pcnt *   0.00 / 100 + T.Populated_officerexempttitle4_pcnt *   0.00 / 100 + T.Populated_officerexempteffectivedate4_pcnt *   0.00 / 100 + T.Populated_officerexemptterminationdate4_pcnt *   0.00 / 100 + T.Populated_officerexempttype4_pcnt *   0.00 / 100 + T.Populated_officerexemptbusinessactivities4_pcnt *   0.00 / 100 + T.Populated_officerexemptfirstname5_pcnt *   0.00 / 100 + T.Populated_officerexemptlastname5_pcnt *   0.00 / 100 + T.Populated_officerexemptmiddlename5_pcnt *   0.00 / 100 + T.Populated_officerexempttitle5_pcnt *   0.00 / 100 + T.Populated_officerexempteffectivedate5_pcnt *   0.00 / 100 + T.Populated_officerexemptterminationdate5_pcnt *   0.00 / 100 + T.Populated_officerexempttype5_pcnt *   0.00 / 100 + T.Populated_officerexemptbusinessactivities5_pcnt *   0.00 / 100 + T.Populated_dba1_pcnt *   0.00 / 100 + T.Populated_dbadatefrom1_pcnt *   0.00 / 100 + T.Populated_dbadateto1_pcnt *   0.00 / 100 + T.Populated_dbatype1_pcnt *   0.00 / 100 + T.Populated_dba2_pcnt *   0.00 / 100 + T.Populated_dbadatefrom2_pcnt *   0.00 / 100 + T.Populated_dbadateto2_pcnt *   0.00 / 100 + T.Populated_dbatype2_pcnt *   0.00 / 100 + T.Populated_dba3_pcnt *   0.00 / 100 + T.Populated_dbadatefrom3_pcnt *   0.00 / 100 + T.Populated_dbadateto3_pcnt *   0.00 / 100 + T.Populated_dbatype3_pcnt *   0.00 / 100 + T.Populated_dba4_pcnt *   0.00 / 100 + T.Populated_dbadatefrom4_pcnt *   0.00 / 100 + T.Populated_dbadateto4_pcnt *   0.00 / 100 + T.Populated_dbatype4_pcnt *   0.00 / 100 + T.Populated_dba5_pcnt *   0.00 / 100 + T.Populated_dbadatefrom5_pcnt *   0.00 / 100 + T.Populated_dbadateto5_pcnt *   0.00 / 100 + T.Populated_dbatype5_pcnt *   0.00 / 100 + T.Populated_subsidiaryname1_pcnt *   0.00 / 100 + T.Populated_subsidiarystartdate1_pcnt *   0.00 / 100 + T.Populated_subsidiaryname2_pcnt *   0.00 / 100 + T.Populated_subsidiarystartdate2_pcnt *   0.00 / 100 + T.Populated_subsidiaryname3_pcnt *   0.00 / 100 + T.Populated_subsidiarystartdate3_pcnt *   0.00 / 100 + T.Populated_subsidiaryname4_pcnt *   0.00 / 100 + T.Populated_subsidiarystartdate4_pcnt *   0.00 / 100 + T.Populated_subsidiaryname5_pcnt *   0.00 / 100 + T.Populated_subsidiarystartdate5_pcnt *   0.00 / 100 + T.Populated_subsidiaryname6_pcnt *   0.00 / 100 + T.Populated_subsidiarystartdate6_pcnt *   0.00 / 100 + T.Populated_subsidiaryname7_pcnt *   0.00 / 100 + T.Populated_subsidiarystartdate7_pcnt *   0.00 / 100 + T.Populated_subsidiaryname8_pcnt *   0.00 / 100 + T.Populated_subsidiarystartdate8_pcnt *   0.00 / 100 + T.Populated_subsidiaryname9_pcnt *   0.00 / 100 + T.Populated_subsidiarystartdate9_pcnt *   0.00 / 100 + T.Populated_subsidiaryname10_pcnt *   0.00 / 100 + T.Populated_subsidiarystartdate10_pcnt *   0.00 / 100;
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
  SELF.FieldName := CHOOSE(C,'dartid','dateadded','dateupdated','website','state','lninscertrecordid','profilelastupdated','siid','sipstatuscode','wcbempnumber','ubinumber','cofanumber','usdotnumber','businessname','dba','addressline1','addressline2','addresscity','addressstate','addresszip','zip4','phone1','phone2','phone3','fax1','fax2','email1','email2','businesstype','namefirst','namemiddle','namelast','namesuffix','nametitle','mailingaddress1','mailingaddress2','mailingaddresscity','mailingaddressstate','mailingaddresszip','mailingaddresszip4','contactnamefirst','contactnamemiddle','contactnamelast','contactnamesuffix','contactbusinessname','contactaddressline1','contactaddressline2','contactcity','contactstate','contactzip','contactzip4','contactphone','contactfax','contactemail','policyholdernamefirst','policyholdernamemiddle','policyholdernamelast','policyholdernamesuffix','statepolicyfilenumber','coverageinjuryillnessdate','selfinsurancegroup','selfinsurancegroupphone','selfinsurancegroupid','numberofemployees','licensedcontractor','mconame','mconumber','mcoaddressline1','mcoaddressline2','mcocity','mcostate','mcozip','mcozip4','mcophone','governingclasscode','licensenumber','class','classificationdescription','licensestatus','licenseadditionalinfo','licenseissuedate','licenseexpirationdate','naicscode','officerexemptfirstname1','officerexemptlastname1','officerexemptmiddlename1','officerexempttitle1','officerexempteffectivedate1','officerexemptterminationdate1','officerexempttype1','officerexemptbusinessactivities1','officerexemptfirstname2','officerexemptlastname2','officerexemptmiddlename2','officerexempttitle2','officerexempteffectivedate2','officerexemptterminationdate2','officerexempttype2','officerexemptbusinessactivities2','officerexemptfirstname3','officerexemptlastname3','officerexemptmiddlename3','officerexempttitle3','officerexempteffectivedate3','officerexemptterminationdate3','officerexempttype3','officerexemptbusinessactivities3','officerexemptfirstname4','officerexemptlastname4','officerexemptmiddlename4','officerexempttitle4','officerexempteffectivedate4','officerexemptterminationdate4','officerexempttype4','officerexemptbusinessactivities4','officerexemptfirstname5','officerexemptlastname5','officerexemptmiddlename5','officerexempttitle5','officerexempteffectivedate5','officerexemptterminationdate5','officerexempttype5','officerexemptbusinessactivities5','dba1','dbadatefrom1','dbadateto1','dbatype1','dba2','dbadatefrom2','dbadateto2','dbatype2','dba3','dbadatefrom3','dbadateto3','dbatype3','dba4','dbadatefrom4','dbadateto4','dbatype4','dba5','dbadatefrom5','dbadateto5','dbatype5','subsidiaryname1','subsidiarystartdate1','subsidiaryname2','subsidiarystartdate2','subsidiaryname3','subsidiarystartdate3','subsidiaryname4','subsidiarystartdate4','subsidiaryname5','subsidiarystartdate5','subsidiaryname6','subsidiarystartdate6','subsidiaryname7','subsidiarystartdate7','subsidiaryname8','subsidiarystartdate8','subsidiaryname9','subsidiarystartdate9','subsidiaryname10','subsidiarystartdate10');
  SELF.populated_pcnt := CHOOSE(C,le.populated_dartid_pcnt,le.populated_dateadded_pcnt,le.populated_dateupdated_pcnt,le.populated_website_pcnt,le.populated_state_pcnt,le.populated_lninscertrecordid_pcnt,le.populated_profilelastupdated_pcnt,le.populated_siid_pcnt,le.populated_sipstatuscode_pcnt,le.populated_wcbempnumber_pcnt,le.populated_ubinumber_pcnt,le.populated_cofanumber_pcnt,le.populated_usdotnumber_pcnt,le.populated_businessname_pcnt,le.populated_dba_pcnt,le.populated_addressline1_pcnt,le.populated_addressline2_pcnt,le.populated_addresscity_pcnt,le.populated_addressstate_pcnt,le.populated_addresszip_pcnt,le.populated_zip4_pcnt,le.populated_phone1_pcnt,le.populated_phone2_pcnt,le.populated_phone3_pcnt,le.populated_fax1_pcnt,le.populated_fax2_pcnt,le.populated_email1_pcnt,le.populated_email2_pcnt,le.populated_businesstype_pcnt,le.populated_namefirst_pcnt,le.populated_namemiddle_pcnt,le.populated_namelast_pcnt,le.populated_namesuffix_pcnt,le.populated_nametitle_pcnt,le.populated_mailingaddress1_pcnt,le.populated_mailingaddress2_pcnt,le.populated_mailingaddresscity_pcnt,le.populated_mailingaddressstate_pcnt,le.populated_mailingaddresszip_pcnt,le.populated_mailingaddresszip4_pcnt,le.populated_contactnamefirst_pcnt,le.populated_contactnamemiddle_pcnt,le.populated_contactnamelast_pcnt,le.populated_contactnamesuffix_pcnt,le.populated_contactbusinessname_pcnt,le.populated_contactaddressline1_pcnt,le.populated_contactaddressline2_pcnt,le.populated_contactcity_pcnt,le.populated_contactstate_pcnt,le.populated_contactzip_pcnt,le.populated_contactzip4_pcnt,le.populated_contactphone_pcnt,le.populated_contactfax_pcnt,le.populated_contactemail_pcnt,le.populated_policyholdernamefirst_pcnt,le.populated_policyholdernamemiddle_pcnt,le.populated_policyholdernamelast_pcnt,le.populated_policyholdernamesuffix_pcnt,le.populated_statepolicyfilenumber_pcnt,le.populated_coverageinjuryillnessdate_pcnt,le.populated_selfinsurancegroup_pcnt,le.populated_selfinsurancegroupphone_pcnt,le.populated_selfinsurancegroupid_pcnt,le.populated_numberofemployees_pcnt,le.populated_licensedcontractor_pcnt,le.populated_mconame_pcnt,le.populated_mconumber_pcnt,le.populated_mcoaddressline1_pcnt,le.populated_mcoaddressline2_pcnt,le.populated_mcocity_pcnt,le.populated_mcostate_pcnt,le.populated_mcozip_pcnt,le.populated_mcozip4_pcnt,le.populated_mcophone_pcnt,le.populated_governingclasscode_pcnt,le.populated_licensenumber_pcnt,le.populated_class_pcnt,le.populated_classificationdescription_pcnt,le.populated_licensestatus_pcnt,le.populated_licenseadditionalinfo_pcnt,le.populated_licenseissuedate_pcnt,le.populated_licenseexpirationdate_pcnt,le.populated_naicscode_pcnt,le.populated_officerexemptfirstname1_pcnt,le.populated_officerexemptlastname1_pcnt,le.populated_officerexemptmiddlename1_pcnt,le.populated_officerexempttitle1_pcnt,le.populated_officerexempteffectivedate1_pcnt,le.populated_officerexemptterminationdate1_pcnt,le.populated_officerexempttype1_pcnt,le.populated_officerexemptbusinessactivities1_pcnt,le.populated_officerexemptfirstname2_pcnt,le.populated_officerexemptlastname2_pcnt,le.populated_officerexemptmiddlename2_pcnt,le.populated_officerexempttitle2_pcnt,le.populated_officerexempteffectivedate2_pcnt,le.populated_officerexemptterminationdate2_pcnt,le.populated_officerexempttype2_pcnt,le.populated_officerexemptbusinessactivities2_pcnt,le.populated_officerexemptfirstname3_pcnt,le.populated_officerexemptlastname3_pcnt,le.populated_officerexemptmiddlename3_pcnt,le.populated_officerexempttitle3_pcnt,le.populated_officerexempteffectivedate3_pcnt,le.populated_officerexemptterminationdate3_pcnt,le.populated_officerexempttype3_pcnt,le.populated_officerexemptbusinessactivities3_pcnt,le.populated_officerexemptfirstname4_pcnt,le.populated_officerexemptlastname4_pcnt,le.populated_officerexemptmiddlename4_pcnt,le.populated_officerexempttitle4_pcnt,le.populated_officerexempteffectivedate4_pcnt,le.populated_officerexemptterminationdate4_pcnt,le.populated_officerexempttype4_pcnt,le.populated_officerexemptbusinessactivities4_pcnt,le.populated_officerexemptfirstname5_pcnt,le.populated_officerexemptlastname5_pcnt,le.populated_officerexemptmiddlename5_pcnt,le.populated_officerexempttitle5_pcnt,le.populated_officerexempteffectivedate5_pcnt,le.populated_officerexemptterminationdate5_pcnt,le.populated_officerexempttype5_pcnt,le.populated_officerexemptbusinessactivities5_pcnt,le.populated_dba1_pcnt,le.populated_dbadatefrom1_pcnt,le.populated_dbadateto1_pcnt,le.populated_dbatype1_pcnt,le.populated_dba2_pcnt,le.populated_dbadatefrom2_pcnt,le.populated_dbadateto2_pcnt,le.populated_dbatype2_pcnt,le.populated_dba3_pcnt,le.populated_dbadatefrom3_pcnt,le.populated_dbadateto3_pcnt,le.populated_dbatype3_pcnt,le.populated_dba4_pcnt,le.populated_dbadatefrom4_pcnt,le.populated_dbadateto4_pcnt,le.populated_dbatype4_pcnt,le.populated_dba5_pcnt,le.populated_dbadatefrom5_pcnt,le.populated_dbadateto5_pcnt,le.populated_dbatype5_pcnt,le.populated_subsidiaryname1_pcnt,le.populated_subsidiarystartdate1_pcnt,le.populated_subsidiaryname2_pcnt,le.populated_subsidiarystartdate2_pcnt,le.populated_subsidiaryname3_pcnt,le.populated_subsidiarystartdate3_pcnt,le.populated_subsidiaryname4_pcnt,le.populated_subsidiarystartdate4_pcnt,le.populated_subsidiaryname5_pcnt,le.populated_subsidiarystartdate5_pcnt,le.populated_subsidiaryname6_pcnt,le.populated_subsidiarystartdate6_pcnt,le.populated_subsidiaryname7_pcnt,le.populated_subsidiarystartdate7_pcnt,le.populated_subsidiaryname8_pcnt,le.populated_subsidiarystartdate8_pcnt,le.populated_subsidiaryname9_pcnt,le.populated_subsidiarystartdate9_pcnt,le.populated_subsidiaryname10_pcnt,le.populated_subsidiarystartdate10_pcnt);
  SELF.maxlength := CHOOSE(C,le.maxlength_dartid,le.maxlength_dateadded,le.maxlength_dateupdated,le.maxlength_website,le.maxlength_state,le.maxlength_lninscertrecordid,le.maxlength_profilelastupdated,le.maxlength_siid,le.maxlength_sipstatuscode,le.maxlength_wcbempnumber,le.maxlength_ubinumber,le.maxlength_cofanumber,le.maxlength_usdotnumber,le.maxlength_businessname,le.maxlength_dba,le.maxlength_addressline1,le.maxlength_addressline2,le.maxlength_addresscity,le.maxlength_addressstate,le.maxlength_addresszip,le.maxlength_zip4,le.maxlength_phone1,le.maxlength_phone2,le.maxlength_phone3,le.maxlength_fax1,le.maxlength_fax2,le.maxlength_email1,le.maxlength_email2,le.maxlength_businesstype,le.maxlength_namefirst,le.maxlength_namemiddle,le.maxlength_namelast,le.maxlength_namesuffix,le.maxlength_nametitle,le.maxlength_mailingaddress1,le.maxlength_mailingaddress2,le.maxlength_mailingaddresscity,le.maxlength_mailingaddressstate,le.maxlength_mailingaddresszip,le.maxlength_mailingaddresszip4,le.maxlength_contactnamefirst,le.maxlength_contactnamemiddle,le.maxlength_contactnamelast,le.maxlength_contactnamesuffix,le.maxlength_contactbusinessname,le.maxlength_contactaddressline1,le.maxlength_contactaddressline2,le.maxlength_contactcity,le.maxlength_contactstate,le.maxlength_contactzip,le.maxlength_contactzip4,le.maxlength_contactphone,le.maxlength_contactfax,le.maxlength_contactemail,le.maxlength_policyholdernamefirst,le.maxlength_policyholdernamemiddle,le.maxlength_policyholdernamelast,le.maxlength_policyholdernamesuffix,le.maxlength_statepolicyfilenumber,le.maxlength_coverageinjuryillnessdate,le.maxlength_selfinsurancegroup,le.maxlength_selfinsurancegroupphone,le.maxlength_selfinsurancegroupid,le.maxlength_numberofemployees,le.maxlength_licensedcontractor,le.maxlength_mconame,le.maxlength_mconumber,le.maxlength_mcoaddressline1,le.maxlength_mcoaddressline2,le.maxlength_mcocity,le.maxlength_mcostate,le.maxlength_mcozip,le.maxlength_mcozip4,le.maxlength_mcophone,le.maxlength_governingclasscode,le.maxlength_licensenumber,le.maxlength_class,le.maxlength_classificationdescription,le.maxlength_licensestatus,le.maxlength_licenseadditionalinfo,le.maxlength_licenseissuedate,le.maxlength_licenseexpirationdate,le.maxlength_naicscode,le.maxlength_officerexemptfirstname1,le.maxlength_officerexemptlastname1,le.maxlength_officerexemptmiddlename1,le.maxlength_officerexempttitle1,le.maxlength_officerexempteffectivedate1,le.maxlength_officerexemptterminationdate1,le.maxlength_officerexempttype1,le.maxlength_officerexemptbusinessactivities1,le.maxlength_officerexemptfirstname2,le.maxlength_officerexemptlastname2,le.maxlength_officerexemptmiddlename2,le.maxlength_officerexempttitle2,le.maxlength_officerexempteffectivedate2,le.maxlength_officerexemptterminationdate2,le.maxlength_officerexempttype2,le.maxlength_officerexemptbusinessactivities2,le.maxlength_officerexemptfirstname3,le.maxlength_officerexemptlastname3,le.maxlength_officerexemptmiddlename3,le.maxlength_officerexempttitle3,le.maxlength_officerexempteffectivedate3,le.maxlength_officerexemptterminationdate3,le.maxlength_officerexempttype3,le.maxlength_officerexemptbusinessactivities3,le.maxlength_officerexemptfirstname4,le.maxlength_officerexemptlastname4,le.maxlength_officerexemptmiddlename4,le.maxlength_officerexempttitle4,le.maxlength_officerexempteffectivedate4,le.maxlength_officerexemptterminationdate4,le.maxlength_officerexempttype4,le.maxlength_officerexemptbusinessactivities4,le.maxlength_officerexemptfirstname5,le.maxlength_officerexemptlastname5,le.maxlength_officerexemptmiddlename5,le.maxlength_officerexempttitle5,le.maxlength_officerexempteffectivedate5,le.maxlength_officerexemptterminationdate5,le.maxlength_officerexempttype5,le.maxlength_officerexemptbusinessactivities5,le.maxlength_dba1,le.maxlength_dbadatefrom1,le.maxlength_dbadateto1,le.maxlength_dbatype1,le.maxlength_dba2,le.maxlength_dbadatefrom2,le.maxlength_dbadateto2,le.maxlength_dbatype2,le.maxlength_dba3,le.maxlength_dbadatefrom3,le.maxlength_dbadateto3,le.maxlength_dbatype3,le.maxlength_dba4,le.maxlength_dbadatefrom4,le.maxlength_dbadateto4,le.maxlength_dbatype4,le.maxlength_dba5,le.maxlength_dbadatefrom5,le.maxlength_dbadateto5,le.maxlength_dbatype5,le.maxlength_subsidiaryname1,le.maxlength_subsidiarystartdate1,le.maxlength_subsidiaryname2,le.maxlength_subsidiarystartdate2,le.maxlength_subsidiaryname3,le.maxlength_subsidiarystartdate3,le.maxlength_subsidiaryname4,le.maxlength_subsidiarystartdate4,le.maxlength_subsidiaryname5,le.maxlength_subsidiarystartdate5,le.maxlength_subsidiaryname6,le.maxlength_subsidiarystartdate6,le.maxlength_subsidiaryname7,le.maxlength_subsidiarystartdate7,le.maxlength_subsidiaryname8,le.maxlength_subsidiarystartdate8,le.maxlength_subsidiaryname9,le.maxlength_subsidiarystartdate9,le.maxlength_subsidiaryname10,le.maxlength_subsidiarystartdate10);
  SELF.avelength := CHOOSE(C,le.avelength_dartid,le.avelength_dateadded,le.avelength_dateupdated,le.avelength_website,le.avelength_state,le.avelength_lninscertrecordid,le.avelength_profilelastupdated,le.avelength_siid,le.avelength_sipstatuscode,le.avelength_wcbempnumber,le.avelength_ubinumber,le.avelength_cofanumber,le.avelength_usdotnumber,le.avelength_businessname,le.avelength_dba,le.avelength_addressline1,le.avelength_addressline2,le.avelength_addresscity,le.avelength_addressstate,le.avelength_addresszip,le.avelength_zip4,le.avelength_phone1,le.avelength_phone2,le.avelength_phone3,le.avelength_fax1,le.avelength_fax2,le.avelength_email1,le.avelength_email2,le.avelength_businesstype,le.avelength_namefirst,le.avelength_namemiddle,le.avelength_namelast,le.avelength_namesuffix,le.avelength_nametitle,le.avelength_mailingaddress1,le.avelength_mailingaddress2,le.avelength_mailingaddresscity,le.avelength_mailingaddressstate,le.avelength_mailingaddresszip,le.avelength_mailingaddresszip4,le.avelength_contactnamefirst,le.avelength_contactnamemiddle,le.avelength_contactnamelast,le.avelength_contactnamesuffix,le.avelength_contactbusinessname,le.avelength_contactaddressline1,le.avelength_contactaddressline2,le.avelength_contactcity,le.avelength_contactstate,le.avelength_contactzip,le.avelength_contactzip4,le.avelength_contactphone,le.avelength_contactfax,le.avelength_contactemail,le.avelength_policyholdernamefirst,le.avelength_policyholdernamemiddle,le.avelength_policyholdernamelast,le.avelength_policyholdernamesuffix,le.avelength_statepolicyfilenumber,le.avelength_coverageinjuryillnessdate,le.avelength_selfinsurancegroup,le.avelength_selfinsurancegroupphone,le.avelength_selfinsurancegroupid,le.avelength_numberofemployees,le.avelength_licensedcontractor,le.avelength_mconame,le.avelength_mconumber,le.avelength_mcoaddressline1,le.avelength_mcoaddressline2,le.avelength_mcocity,le.avelength_mcostate,le.avelength_mcozip,le.avelength_mcozip4,le.avelength_mcophone,le.avelength_governingclasscode,le.avelength_licensenumber,le.avelength_class,le.avelength_classificationdescription,le.avelength_licensestatus,le.avelength_licenseadditionalinfo,le.avelength_licenseissuedate,le.avelength_licenseexpirationdate,le.avelength_naicscode,le.avelength_officerexemptfirstname1,le.avelength_officerexemptlastname1,le.avelength_officerexemptmiddlename1,le.avelength_officerexempttitle1,le.avelength_officerexempteffectivedate1,le.avelength_officerexemptterminationdate1,le.avelength_officerexempttype1,le.avelength_officerexemptbusinessactivities1,le.avelength_officerexemptfirstname2,le.avelength_officerexemptlastname2,le.avelength_officerexemptmiddlename2,le.avelength_officerexempttitle2,le.avelength_officerexempteffectivedate2,le.avelength_officerexemptterminationdate2,le.avelength_officerexempttype2,le.avelength_officerexemptbusinessactivities2,le.avelength_officerexemptfirstname3,le.avelength_officerexemptlastname3,le.avelength_officerexemptmiddlename3,le.avelength_officerexempttitle3,le.avelength_officerexempteffectivedate3,le.avelength_officerexemptterminationdate3,le.avelength_officerexempttype3,le.avelength_officerexemptbusinessactivities3,le.avelength_officerexemptfirstname4,le.avelength_officerexemptlastname4,le.avelength_officerexemptmiddlename4,le.avelength_officerexempttitle4,le.avelength_officerexempteffectivedate4,le.avelength_officerexemptterminationdate4,le.avelength_officerexempttype4,le.avelength_officerexemptbusinessactivities4,le.avelength_officerexemptfirstname5,le.avelength_officerexemptlastname5,le.avelength_officerexemptmiddlename5,le.avelength_officerexempttitle5,le.avelength_officerexempteffectivedate5,le.avelength_officerexemptterminationdate5,le.avelength_officerexempttype5,le.avelength_officerexemptbusinessactivities5,le.avelength_dba1,le.avelength_dbadatefrom1,le.avelength_dbadateto1,le.avelength_dbatype1,le.avelength_dba2,le.avelength_dbadatefrom2,le.avelength_dbadateto2,le.avelength_dbatype2,le.avelength_dba3,le.avelength_dbadatefrom3,le.avelength_dbadateto3,le.avelength_dbatype3,le.avelength_dba4,le.avelength_dbadatefrom4,le.avelength_dbadateto4,le.avelength_dbatype4,le.avelength_dba5,le.avelength_dbadatefrom5,le.avelength_dbadateto5,le.avelength_dbatype5,le.avelength_subsidiaryname1,le.avelength_subsidiarystartdate1,le.avelength_subsidiaryname2,le.avelength_subsidiarystartdate2,le.avelength_subsidiaryname3,le.avelength_subsidiarystartdate3,le.avelength_subsidiaryname4,le.avelength_subsidiarystartdate4,le.avelength_subsidiaryname5,le.avelength_subsidiarystartdate5,le.avelength_subsidiaryname6,le.avelength_subsidiarystartdate6,le.avelength_subsidiaryname7,le.avelength_subsidiarystartdate7,le.avelength_subsidiaryname8,le.avelength_subsidiarystartdate8,le.avelength_subsidiaryname9,le.avelength_subsidiarystartdate9,le.avelength_subsidiaryname10,le.avelength_subsidiarystartdate10);
END;
EXPORT invSummary := NORMALIZE(summary0, 163, invert(LEFT,COUNTER));
// The character counts
// Move everything into 'inverted list' form so processing can be done 'in library'
SALT311.MAC_Character_Counts.X_Data_Layout Into(h le,unsigned C) := TRANSFORM
  SELF.Fld := TRIM(CHOOSE(C,TRIM((SALT311.StrType)le.dartid),IF (le.dateadded <> 0,TRIM((SALT311.StrType)le.dateadded), ''),IF (le.dateupdated <> 0,TRIM((SALT311.StrType)le.dateupdated), ''),TRIM((SALT311.StrType)le.website),TRIM((SALT311.StrType)le.state),IF (le.lninscertrecordid <> 0,TRIM((SALT311.StrType)le.lninscertrecordid), ''),TRIM((SALT311.StrType)le.profilelastupdated),TRIM((SALT311.StrType)le.siid),TRIM((SALT311.StrType)le.sipstatuscode),TRIM((SALT311.StrType)le.wcbempnumber),TRIM((SALT311.StrType)le.ubinumber),TRIM((SALT311.StrType)le.cofanumber),TRIM((SALT311.StrType)le.usdotnumber),TRIM((SALT311.StrType)le.businessname),TRIM((SALT311.StrType)le.dba),TRIM((SALT311.StrType)le.addressline1),TRIM((SALT311.StrType)le.addressline2),TRIM((SALT311.StrType)le.addresscity),TRIM((SALT311.StrType)le.addressstate),TRIM((SALT311.StrType)le.addresszip),TRIM((SALT311.StrType)le.zip4),TRIM((SALT311.StrType)le.phone1),TRIM((SALT311.StrType)le.phone2),TRIM((SALT311.StrType)le.phone3),TRIM((SALT311.StrType)le.fax1),TRIM((SALT311.StrType)le.fax2),TRIM((SALT311.StrType)le.email1),TRIM((SALT311.StrType)le.email2),TRIM((SALT311.StrType)le.businesstype),TRIM((SALT311.StrType)le.namefirst),TRIM((SALT311.StrType)le.namemiddle),TRIM((SALT311.StrType)le.namelast),TRIM((SALT311.StrType)le.namesuffix),TRIM((SALT311.StrType)le.nametitle),TRIM((SALT311.StrType)le.mailingaddress1),TRIM((SALT311.StrType)le.mailingaddress2),TRIM((SALT311.StrType)le.mailingaddresscity),TRIM((SALT311.StrType)le.mailingaddressstate),TRIM((SALT311.StrType)le.mailingaddresszip),TRIM((SALT311.StrType)le.mailingaddresszip4),TRIM((SALT311.StrType)le.contactnamefirst),TRIM((SALT311.StrType)le.contactnamemiddle),TRIM((SALT311.StrType)le.contactnamelast),TRIM((SALT311.StrType)le.contactnamesuffix),TRIM((SALT311.StrType)le.contactbusinessname),TRIM((SALT311.StrType)le.contactaddressline1),TRIM((SALT311.StrType)le.contactaddressline2),TRIM((SALT311.StrType)le.contactcity),TRIM((SALT311.StrType)le.contactstate),TRIM((SALT311.StrType)le.contactzip),TRIM((SALT311.StrType)le.contactzip4),TRIM((SALT311.StrType)le.contactphone),TRIM((SALT311.StrType)le.contactfax),TRIM((SALT311.StrType)le.contactemail),TRIM((SALT311.StrType)le.policyholdernamefirst),TRIM((SALT311.StrType)le.policyholdernamemiddle),TRIM((SALT311.StrType)le.policyholdernamelast),TRIM((SALT311.StrType)le.policyholdernamesuffix),TRIM((SALT311.StrType)le.statepolicyfilenumber),TRIM((SALT311.StrType)le.coverageinjuryillnessdate),TRIM((SALT311.StrType)le.selfinsurancegroup),TRIM((SALT311.StrType)le.selfinsurancegroupphone),TRIM((SALT311.StrType)le.selfinsurancegroupid),TRIM((SALT311.StrType)le.numberofemployees),TRIM((SALT311.StrType)le.licensedcontractor),TRIM((SALT311.StrType)le.mconame),TRIM((SALT311.StrType)le.mconumber),TRIM((SALT311.StrType)le.mcoaddressline1),TRIM((SALT311.StrType)le.mcoaddressline2),TRIM((SALT311.StrType)le.mcocity),TRIM((SALT311.StrType)le.mcostate),TRIM((SALT311.StrType)le.mcozip),TRIM((SALT311.StrType)le.mcozip4),TRIM((SALT311.StrType)le.mcophone),TRIM((SALT311.StrType)le.governingclasscode),TRIM((SALT311.StrType)le.licensenumber),TRIM((SALT311.StrType)le.class),TRIM((SALT311.StrType)le.classificationdescription),TRIM((SALT311.StrType)le.licensestatus),TRIM((SALT311.StrType)le.licenseadditionalinfo),TRIM((SALT311.StrType)le.licenseissuedate),TRIM((SALT311.StrType)le.licenseexpirationdate),TRIM((SALT311.StrType)le.naicscode),TRIM((SALT311.StrType)le.officerexemptfirstname1),TRIM((SALT311.StrType)le.officerexemptlastname1),TRIM((SALT311.StrType)le.officerexemptmiddlename1),TRIM((SALT311.StrType)le.officerexempttitle1),TRIM((SALT311.StrType)le.officerexempteffectivedate1),TRIM((SALT311.StrType)le.officerexemptterminationdate1),TRIM((SALT311.StrType)le.officerexempttype1),TRIM((SALT311.StrType)le.officerexemptbusinessactivities1),TRIM((SALT311.StrType)le.officerexemptfirstname2),TRIM((SALT311.StrType)le.officerexemptlastname2),TRIM((SALT311.StrType)le.officerexemptmiddlename2),TRIM((SALT311.StrType)le.officerexempttitle2),TRIM((SALT311.StrType)le.officerexempteffectivedate2),TRIM((SALT311.StrType)le.officerexemptterminationdate2),TRIM((SALT311.StrType)le.officerexempttype2),TRIM((SALT311.StrType)le.officerexemptbusinessactivities2),TRIM((SALT311.StrType)le.officerexemptfirstname3),TRIM((SALT311.StrType)le.officerexemptlastname3),TRIM((SALT311.StrType)le.officerexemptmiddlename3),TRIM((SALT311.StrType)le.officerexempttitle3),TRIM((SALT311.StrType)le.officerexempteffectivedate3),TRIM((SALT311.StrType)le.officerexemptterminationdate3),TRIM((SALT311.StrType)le.officerexempttype3),TRIM((SALT311.StrType)le.officerexemptbusinessactivities3),TRIM((SALT311.StrType)le.officerexemptfirstname4),TRIM((SALT311.StrType)le.officerexemptlastname4),TRIM((SALT311.StrType)le.officerexemptmiddlename4),TRIM((SALT311.StrType)le.officerexempttitle4),TRIM((SALT311.StrType)le.officerexempteffectivedate4),TRIM((SALT311.StrType)le.officerexemptterminationdate4),TRIM((SALT311.StrType)le.officerexempttype4),TRIM((SALT311.StrType)le.officerexemptbusinessactivities4),TRIM((SALT311.StrType)le.officerexemptfirstname5),TRIM((SALT311.StrType)le.officerexemptlastname5),TRIM((SALT311.StrType)le.officerexemptmiddlename5),TRIM((SALT311.StrType)le.officerexempttitle5),TRIM((SALT311.StrType)le.officerexempteffectivedate5),TRIM((SALT311.StrType)le.officerexemptterminationdate5),TRIM((SALT311.StrType)le.officerexempttype5),TRIM((SALT311.StrType)le.officerexemptbusinessactivities5),TRIM((SALT311.StrType)le.dba1),TRIM((SALT311.StrType)le.dbadatefrom1),TRIM((SALT311.StrType)le.dbadateto1),TRIM((SALT311.StrType)le.dbatype1),TRIM((SALT311.StrType)le.dba2),TRIM((SALT311.StrType)le.dbadatefrom2),TRIM((SALT311.StrType)le.dbadateto2),TRIM((SALT311.StrType)le.dbatype2),TRIM((SALT311.StrType)le.dba3),TRIM((SALT311.StrType)le.dbadatefrom3),TRIM((SALT311.StrType)le.dbadateto3),TRIM((SALT311.StrType)le.dbatype3),TRIM((SALT311.StrType)le.dba4),TRIM((SALT311.StrType)le.dbadatefrom4),TRIM((SALT311.StrType)le.dbadateto4),TRIM((SALT311.StrType)le.dbatype4),TRIM((SALT311.StrType)le.dba5),TRIM((SALT311.StrType)le.dbadatefrom5),TRIM((SALT311.StrType)le.dbadateto5),TRIM((SALT311.StrType)le.dbatype5),TRIM((SALT311.StrType)le.subsidiaryname1),TRIM((SALT311.StrType)le.subsidiarystartdate1),TRIM((SALT311.StrType)le.subsidiaryname2),TRIM((SALT311.StrType)le.subsidiarystartdate2),TRIM((SALT311.StrType)le.subsidiaryname3),TRIM((SALT311.StrType)le.subsidiarystartdate3),TRIM((SALT311.StrType)le.subsidiaryname4),TRIM((SALT311.StrType)le.subsidiarystartdate4),TRIM((SALT311.StrType)le.subsidiaryname5),TRIM((SALT311.StrType)le.subsidiarystartdate5),TRIM((SALT311.StrType)le.subsidiaryname6),TRIM((SALT311.StrType)le.subsidiarystartdate6),TRIM((SALT311.StrType)le.subsidiaryname7),TRIM((SALT311.StrType)le.subsidiarystartdate7),TRIM((SALT311.StrType)le.subsidiaryname8),TRIM((SALT311.StrType)le.subsidiarystartdate8),TRIM((SALT311.StrType)le.subsidiaryname9),TRIM((SALT311.StrType)le.subsidiarystartdate9),TRIM((SALT311.StrType)le.subsidiaryname10),TRIM((SALT311.StrType)le.subsidiarystartdate10)));
  SELF.FldNo := C;
END;
SHARED FldInv0 := NORMALIZE(h,163,Into(LEFT,COUNTER));
// Move everything into 'pairs' form so processing can be done 'in library'
SALT311.MAC_Correlate.Data_Layout IntoP(h le,UNSIGNED C) := TRANSFORM
  SELF.FldNo1 := 1 + (C / 163);
  SELF.FldNo2 := 1 + (C % 163);
  SELF.Fld1 := TRIM(CHOOSE(SELF.FldNo1,TRIM((SALT311.StrType)le.dartid),IF (le.dateadded <> 0,TRIM((SALT311.StrType)le.dateadded), ''),IF (le.dateupdated <> 0,TRIM((SALT311.StrType)le.dateupdated), ''),TRIM((SALT311.StrType)le.website),TRIM((SALT311.StrType)le.state),IF (le.lninscertrecordid <> 0,TRIM((SALT311.StrType)le.lninscertrecordid), ''),TRIM((SALT311.StrType)le.profilelastupdated),TRIM((SALT311.StrType)le.siid),TRIM((SALT311.StrType)le.sipstatuscode),TRIM((SALT311.StrType)le.wcbempnumber),TRIM((SALT311.StrType)le.ubinumber),TRIM((SALT311.StrType)le.cofanumber),TRIM((SALT311.StrType)le.usdotnumber),TRIM((SALT311.StrType)le.businessname),TRIM((SALT311.StrType)le.dba),TRIM((SALT311.StrType)le.addressline1),TRIM((SALT311.StrType)le.addressline2),TRIM((SALT311.StrType)le.addresscity),TRIM((SALT311.StrType)le.addressstate),TRIM((SALT311.StrType)le.addresszip),TRIM((SALT311.StrType)le.zip4),TRIM((SALT311.StrType)le.phone1),TRIM((SALT311.StrType)le.phone2),TRIM((SALT311.StrType)le.phone3),TRIM((SALT311.StrType)le.fax1),TRIM((SALT311.StrType)le.fax2),TRIM((SALT311.StrType)le.email1),TRIM((SALT311.StrType)le.email2),TRIM((SALT311.StrType)le.businesstype),TRIM((SALT311.StrType)le.namefirst),TRIM((SALT311.StrType)le.namemiddle),TRIM((SALT311.StrType)le.namelast),TRIM((SALT311.StrType)le.namesuffix),TRIM((SALT311.StrType)le.nametitle),TRIM((SALT311.StrType)le.mailingaddress1),TRIM((SALT311.StrType)le.mailingaddress2),TRIM((SALT311.StrType)le.mailingaddresscity),TRIM((SALT311.StrType)le.mailingaddressstate),TRIM((SALT311.StrType)le.mailingaddresszip),TRIM((SALT311.StrType)le.mailingaddresszip4),TRIM((SALT311.StrType)le.contactnamefirst),TRIM((SALT311.StrType)le.contactnamemiddle),TRIM((SALT311.StrType)le.contactnamelast),TRIM((SALT311.StrType)le.contactnamesuffix),TRIM((SALT311.StrType)le.contactbusinessname),TRIM((SALT311.StrType)le.contactaddressline1),TRIM((SALT311.StrType)le.contactaddressline2),TRIM((SALT311.StrType)le.contactcity),TRIM((SALT311.StrType)le.contactstate),TRIM((SALT311.StrType)le.contactzip),TRIM((SALT311.StrType)le.contactzip4),TRIM((SALT311.StrType)le.contactphone),TRIM((SALT311.StrType)le.contactfax),TRIM((SALT311.StrType)le.contactemail),TRIM((SALT311.StrType)le.policyholdernamefirst),TRIM((SALT311.StrType)le.policyholdernamemiddle),TRIM((SALT311.StrType)le.policyholdernamelast),TRIM((SALT311.StrType)le.policyholdernamesuffix),TRIM((SALT311.StrType)le.statepolicyfilenumber),TRIM((SALT311.StrType)le.coverageinjuryillnessdate),TRIM((SALT311.StrType)le.selfinsurancegroup),TRIM((SALT311.StrType)le.selfinsurancegroupphone),TRIM((SALT311.StrType)le.selfinsurancegroupid),TRIM((SALT311.StrType)le.numberofemployees),TRIM((SALT311.StrType)le.licensedcontractor),TRIM((SALT311.StrType)le.mconame),TRIM((SALT311.StrType)le.mconumber),TRIM((SALT311.StrType)le.mcoaddressline1),TRIM((SALT311.StrType)le.mcoaddressline2),TRIM((SALT311.StrType)le.mcocity),TRIM((SALT311.StrType)le.mcostate),TRIM((SALT311.StrType)le.mcozip),TRIM((SALT311.StrType)le.mcozip4),TRIM((SALT311.StrType)le.mcophone),TRIM((SALT311.StrType)le.governingclasscode),TRIM((SALT311.StrType)le.licensenumber),TRIM((SALT311.StrType)le.class),TRIM((SALT311.StrType)le.classificationdescription),TRIM((SALT311.StrType)le.licensestatus),TRIM((SALT311.StrType)le.licenseadditionalinfo),TRIM((SALT311.StrType)le.licenseissuedate),TRIM((SALT311.StrType)le.licenseexpirationdate),TRIM((SALT311.StrType)le.naicscode),TRIM((SALT311.StrType)le.officerexemptfirstname1),TRIM((SALT311.StrType)le.officerexemptlastname1),TRIM((SALT311.StrType)le.officerexemptmiddlename1),TRIM((SALT311.StrType)le.officerexempttitle1),TRIM((SALT311.StrType)le.officerexempteffectivedate1),TRIM((SALT311.StrType)le.officerexemptterminationdate1),TRIM((SALT311.StrType)le.officerexempttype1),TRIM((SALT311.StrType)le.officerexemptbusinessactivities1),TRIM((SALT311.StrType)le.officerexemptfirstname2),TRIM((SALT311.StrType)le.officerexemptlastname2),TRIM((SALT311.StrType)le.officerexemptmiddlename2),TRIM((SALT311.StrType)le.officerexempttitle2),TRIM((SALT311.StrType)le.officerexempteffectivedate2),TRIM((SALT311.StrType)le.officerexemptterminationdate2),TRIM((SALT311.StrType)le.officerexempttype2),TRIM((SALT311.StrType)le.officerexemptbusinessactivities2),TRIM((SALT311.StrType)le.officerexemptfirstname3),TRIM((SALT311.StrType)le.officerexemptlastname3),TRIM((SALT311.StrType)le.officerexemptmiddlename3),TRIM((SALT311.StrType)le.officerexempttitle3),TRIM((SALT311.StrType)le.officerexempteffectivedate3),TRIM((SALT311.StrType)le.officerexemptterminationdate3),TRIM((SALT311.StrType)le.officerexempttype3),TRIM((SALT311.StrType)le.officerexemptbusinessactivities3),TRIM((SALT311.StrType)le.officerexemptfirstname4),TRIM((SALT311.StrType)le.officerexemptlastname4),TRIM((SALT311.StrType)le.officerexemptmiddlename4),TRIM((SALT311.StrType)le.officerexempttitle4),TRIM((SALT311.StrType)le.officerexempteffectivedate4),TRIM((SALT311.StrType)le.officerexemptterminationdate4),TRIM((SALT311.StrType)le.officerexempttype4),TRIM((SALT311.StrType)le.officerexemptbusinessactivities4),TRIM((SALT311.StrType)le.officerexemptfirstname5),TRIM((SALT311.StrType)le.officerexemptlastname5),TRIM((SALT311.StrType)le.officerexemptmiddlename5),TRIM((SALT311.StrType)le.officerexempttitle5),TRIM((SALT311.StrType)le.officerexempteffectivedate5),TRIM((SALT311.StrType)le.officerexemptterminationdate5),TRIM((SALT311.StrType)le.officerexempttype5),TRIM((SALT311.StrType)le.officerexemptbusinessactivities5),TRIM((SALT311.StrType)le.dba1),TRIM((SALT311.StrType)le.dbadatefrom1),TRIM((SALT311.StrType)le.dbadateto1),TRIM((SALT311.StrType)le.dbatype1),TRIM((SALT311.StrType)le.dba2),TRIM((SALT311.StrType)le.dbadatefrom2),TRIM((SALT311.StrType)le.dbadateto2),TRIM((SALT311.StrType)le.dbatype2),TRIM((SALT311.StrType)le.dba3),TRIM((SALT311.StrType)le.dbadatefrom3),TRIM((SALT311.StrType)le.dbadateto3),TRIM((SALT311.StrType)le.dbatype3),TRIM((SALT311.StrType)le.dba4),TRIM((SALT311.StrType)le.dbadatefrom4),TRIM((SALT311.StrType)le.dbadateto4),TRIM((SALT311.StrType)le.dbatype4),TRIM((SALT311.StrType)le.dba5),TRIM((SALT311.StrType)le.dbadatefrom5),TRIM((SALT311.StrType)le.dbadateto5),TRIM((SALT311.StrType)le.dbatype5),TRIM((SALT311.StrType)le.subsidiaryname1),TRIM((SALT311.StrType)le.subsidiarystartdate1),TRIM((SALT311.StrType)le.subsidiaryname2),TRIM((SALT311.StrType)le.subsidiarystartdate2),TRIM((SALT311.StrType)le.subsidiaryname3),TRIM((SALT311.StrType)le.subsidiarystartdate3),TRIM((SALT311.StrType)le.subsidiaryname4),TRIM((SALT311.StrType)le.subsidiarystartdate4),TRIM((SALT311.StrType)le.subsidiaryname5),TRIM((SALT311.StrType)le.subsidiarystartdate5),TRIM((SALT311.StrType)le.subsidiaryname6),TRIM((SALT311.StrType)le.subsidiarystartdate6),TRIM((SALT311.StrType)le.subsidiaryname7),TRIM((SALT311.StrType)le.subsidiarystartdate7),TRIM((SALT311.StrType)le.subsidiaryname8),TRIM((SALT311.StrType)le.subsidiarystartdate8),TRIM((SALT311.StrType)le.subsidiaryname9),TRIM((SALT311.StrType)le.subsidiarystartdate9),TRIM((SALT311.StrType)le.subsidiaryname10),TRIM((SALT311.StrType)le.subsidiarystartdate10)));
  SELF.Fld2 := TRIM(CHOOSE(SELF.FldNo2,TRIM((SALT311.StrType)le.dartid),IF (le.dateadded <> 0,TRIM((SALT311.StrType)le.dateadded), ''),IF (le.dateupdated <> 0,TRIM((SALT311.StrType)le.dateupdated), ''),TRIM((SALT311.StrType)le.website),TRIM((SALT311.StrType)le.state),IF (le.lninscertrecordid <> 0,TRIM((SALT311.StrType)le.lninscertrecordid), ''),TRIM((SALT311.StrType)le.profilelastupdated),TRIM((SALT311.StrType)le.siid),TRIM((SALT311.StrType)le.sipstatuscode),TRIM((SALT311.StrType)le.wcbempnumber),TRIM((SALT311.StrType)le.ubinumber),TRIM((SALT311.StrType)le.cofanumber),TRIM((SALT311.StrType)le.usdotnumber),TRIM((SALT311.StrType)le.businessname),TRIM((SALT311.StrType)le.dba),TRIM((SALT311.StrType)le.addressline1),TRIM((SALT311.StrType)le.addressline2),TRIM((SALT311.StrType)le.addresscity),TRIM((SALT311.StrType)le.addressstate),TRIM((SALT311.StrType)le.addresszip),TRIM((SALT311.StrType)le.zip4),TRIM((SALT311.StrType)le.phone1),TRIM((SALT311.StrType)le.phone2),TRIM((SALT311.StrType)le.phone3),TRIM((SALT311.StrType)le.fax1),TRIM((SALT311.StrType)le.fax2),TRIM((SALT311.StrType)le.email1),TRIM((SALT311.StrType)le.email2),TRIM((SALT311.StrType)le.businesstype),TRIM((SALT311.StrType)le.namefirst),TRIM((SALT311.StrType)le.namemiddle),TRIM((SALT311.StrType)le.namelast),TRIM((SALT311.StrType)le.namesuffix),TRIM((SALT311.StrType)le.nametitle),TRIM((SALT311.StrType)le.mailingaddress1),TRIM((SALT311.StrType)le.mailingaddress2),TRIM((SALT311.StrType)le.mailingaddresscity),TRIM((SALT311.StrType)le.mailingaddressstate),TRIM((SALT311.StrType)le.mailingaddresszip),TRIM((SALT311.StrType)le.mailingaddresszip4),TRIM((SALT311.StrType)le.contactnamefirst),TRIM((SALT311.StrType)le.contactnamemiddle),TRIM((SALT311.StrType)le.contactnamelast),TRIM((SALT311.StrType)le.contactnamesuffix),TRIM((SALT311.StrType)le.contactbusinessname),TRIM((SALT311.StrType)le.contactaddressline1),TRIM((SALT311.StrType)le.contactaddressline2),TRIM((SALT311.StrType)le.contactcity),TRIM((SALT311.StrType)le.contactstate),TRIM((SALT311.StrType)le.contactzip),TRIM((SALT311.StrType)le.contactzip4),TRIM((SALT311.StrType)le.contactphone),TRIM((SALT311.StrType)le.contactfax),TRIM((SALT311.StrType)le.contactemail),TRIM((SALT311.StrType)le.policyholdernamefirst),TRIM((SALT311.StrType)le.policyholdernamemiddle),TRIM((SALT311.StrType)le.policyholdernamelast),TRIM((SALT311.StrType)le.policyholdernamesuffix),TRIM((SALT311.StrType)le.statepolicyfilenumber),TRIM((SALT311.StrType)le.coverageinjuryillnessdate),TRIM((SALT311.StrType)le.selfinsurancegroup),TRIM((SALT311.StrType)le.selfinsurancegroupphone),TRIM((SALT311.StrType)le.selfinsurancegroupid),TRIM((SALT311.StrType)le.numberofemployees),TRIM((SALT311.StrType)le.licensedcontractor),TRIM((SALT311.StrType)le.mconame),TRIM((SALT311.StrType)le.mconumber),TRIM((SALT311.StrType)le.mcoaddressline1),TRIM((SALT311.StrType)le.mcoaddressline2),TRIM((SALT311.StrType)le.mcocity),TRIM((SALT311.StrType)le.mcostate),TRIM((SALT311.StrType)le.mcozip),TRIM((SALT311.StrType)le.mcozip4),TRIM((SALT311.StrType)le.mcophone),TRIM((SALT311.StrType)le.governingclasscode),TRIM((SALT311.StrType)le.licensenumber),TRIM((SALT311.StrType)le.class),TRIM((SALT311.StrType)le.classificationdescription),TRIM((SALT311.StrType)le.licensestatus),TRIM((SALT311.StrType)le.licenseadditionalinfo),TRIM((SALT311.StrType)le.licenseissuedate),TRIM((SALT311.StrType)le.licenseexpirationdate),TRIM((SALT311.StrType)le.naicscode),TRIM((SALT311.StrType)le.officerexemptfirstname1),TRIM((SALT311.StrType)le.officerexemptlastname1),TRIM((SALT311.StrType)le.officerexemptmiddlename1),TRIM((SALT311.StrType)le.officerexempttitle1),TRIM((SALT311.StrType)le.officerexempteffectivedate1),TRIM((SALT311.StrType)le.officerexemptterminationdate1),TRIM((SALT311.StrType)le.officerexempttype1),TRIM((SALT311.StrType)le.officerexemptbusinessactivities1),TRIM((SALT311.StrType)le.officerexemptfirstname2),TRIM((SALT311.StrType)le.officerexemptlastname2),TRIM((SALT311.StrType)le.officerexemptmiddlename2),TRIM((SALT311.StrType)le.officerexempttitle2),TRIM((SALT311.StrType)le.officerexempteffectivedate2),TRIM((SALT311.StrType)le.officerexemptterminationdate2),TRIM((SALT311.StrType)le.officerexempttype2),TRIM((SALT311.StrType)le.officerexemptbusinessactivities2),TRIM((SALT311.StrType)le.officerexemptfirstname3),TRIM((SALT311.StrType)le.officerexemptlastname3),TRIM((SALT311.StrType)le.officerexemptmiddlename3),TRIM((SALT311.StrType)le.officerexempttitle3),TRIM((SALT311.StrType)le.officerexempteffectivedate3),TRIM((SALT311.StrType)le.officerexemptterminationdate3),TRIM((SALT311.StrType)le.officerexempttype3),TRIM((SALT311.StrType)le.officerexemptbusinessactivities3),TRIM((SALT311.StrType)le.officerexemptfirstname4),TRIM((SALT311.StrType)le.officerexemptlastname4),TRIM((SALT311.StrType)le.officerexemptmiddlename4),TRIM((SALT311.StrType)le.officerexempttitle4),TRIM((SALT311.StrType)le.officerexempteffectivedate4),TRIM((SALT311.StrType)le.officerexemptterminationdate4),TRIM((SALT311.StrType)le.officerexempttype4),TRIM((SALT311.StrType)le.officerexemptbusinessactivities4),TRIM((SALT311.StrType)le.officerexemptfirstname5),TRIM((SALT311.StrType)le.officerexemptlastname5),TRIM((SALT311.StrType)le.officerexemptmiddlename5),TRIM((SALT311.StrType)le.officerexempttitle5),TRIM((SALT311.StrType)le.officerexempteffectivedate5),TRIM((SALT311.StrType)le.officerexemptterminationdate5),TRIM((SALT311.StrType)le.officerexempttype5),TRIM((SALT311.StrType)le.officerexemptbusinessactivities5),TRIM((SALT311.StrType)le.dba1),TRIM((SALT311.StrType)le.dbadatefrom1),TRIM((SALT311.StrType)le.dbadateto1),TRIM((SALT311.StrType)le.dbatype1),TRIM((SALT311.StrType)le.dba2),TRIM((SALT311.StrType)le.dbadatefrom2),TRIM((SALT311.StrType)le.dbadateto2),TRIM((SALT311.StrType)le.dbatype2),TRIM((SALT311.StrType)le.dba3),TRIM((SALT311.StrType)le.dbadatefrom3),TRIM((SALT311.StrType)le.dbadateto3),TRIM((SALT311.StrType)le.dbatype3),TRIM((SALT311.StrType)le.dba4),TRIM((SALT311.StrType)le.dbadatefrom4),TRIM((SALT311.StrType)le.dbadateto4),TRIM((SALT311.StrType)le.dbatype4),TRIM((SALT311.StrType)le.dba5),TRIM((SALT311.StrType)le.dbadatefrom5),TRIM((SALT311.StrType)le.dbadateto5),TRIM((SALT311.StrType)le.dbatype5),TRIM((SALT311.StrType)le.subsidiaryname1),TRIM((SALT311.StrType)le.subsidiarystartdate1),TRIM((SALT311.StrType)le.subsidiaryname2),TRIM((SALT311.StrType)le.subsidiarystartdate2),TRIM((SALT311.StrType)le.subsidiaryname3),TRIM((SALT311.StrType)le.subsidiarystartdate3),TRIM((SALT311.StrType)le.subsidiaryname4),TRIM((SALT311.StrType)le.subsidiarystartdate4),TRIM((SALT311.StrType)le.subsidiaryname5),TRIM((SALT311.StrType)le.subsidiarystartdate5),TRIM((SALT311.StrType)le.subsidiaryname6),TRIM((SALT311.StrType)le.subsidiarystartdate6),TRIM((SALT311.StrType)le.subsidiaryname7),TRIM((SALT311.StrType)le.subsidiarystartdate7),TRIM((SALT311.StrType)le.subsidiaryname8),TRIM((SALT311.StrType)le.subsidiarystartdate8),TRIM((SALT311.StrType)le.subsidiaryname9),TRIM((SALT311.StrType)le.subsidiarystartdate9),TRIM((SALT311.StrType)le.subsidiaryname10),TRIM((SALT311.StrType)le.subsidiarystartdate10)));
  END;
SHARED Pairs0 := NORMALIZE(ENTH(h,Config.CorrelateSampleSize),163*163,IntoP(LEFT,COUNTER))(FldNo1<FldNo2);
SHARED FldIds := DATASET([{1,'dartid'}
      ,{2,'dateadded'}
      ,{3,'dateupdated'}
      ,{4,'website'}
      ,{5,'state'}
      ,{6,'lninscertrecordid'}
      ,{7,'profilelastupdated'}
      ,{8,'siid'}
      ,{9,'sipstatuscode'}
      ,{10,'wcbempnumber'}
      ,{11,'ubinumber'}
      ,{12,'cofanumber'}
      ,{13,'usdotnumber'}
      ,{14,'businessname'}
      ,{15,'dba'}
      ,{16,'addressline1'}
      ,{17,'addressline2'}
      ,{18,'addresscity'}
      ,{19,'addressstate'}
      ,{20,'addresszip'}
      ,{21,'zip4'}
      ,{22,'phone1'}
      ,{23,'phone2'}
      ,{24,'phone3'}
      ,{25,'fax1'}
      ,{26,'fax2'}
      ,{27,'email1'}
      ,{28,'email2'}
      ,{29,'businesstype'}
      ,{30,'namefirst'}
      ,{31,'namemiddle'}
      ,{32,'namelast'}
      ,{33,'namesuffix'}
      ,{34,'nametitle'}
      ,{35,'mailingaddress1'}
      ,{36,'mailingaddress2'}
      ,{37,'mailingaddresscity'}
      ,{38,'mailingaddressstate'}
      ,{39,'mailingaddresszip'}
      ,{40,'mailingaddresszip4'}
      ,{41,'contactnamefirst'}
      ,{42,'contactnamemiddle'}
      ,{43,'contactnamelast'}
      ,{44,'contactnamesuffix'}
      ,{45,'contactbusinessname'}
      ,{46,'contactaddressline1'}
      ,{47,'contactaddressline2'}
      ,{48,'contactcity'}
      ,{49,'contactstate'}
      ,{50,'contactzip'}
      ,{51,'contactzip4'}
      ,{52,'contactphone'}
      ,{53,'contactfax'}
      ,{54,'contactemail'}
      ,{55,'policyholdernamefirst'}
      ,{56,'policyholdernamemiddle'}
      ,{57,'policyholdernamelast'}
      ,{58,'policyholdernamesuffix'}
      ,{59,'statepolicyfilenumber'}
      ,{60,'coverageinjuryillnessdate'}
      ,{61,'selfinsurancegroup'}
      ,{62,'selfinsurancegroupphone'}
      ,{63,'selfinsurancegroupid'}
      ,{64,'numberofemployees'}
      ,{65,'licensedcontractor'}
      ,{66,'mconame'}
      ,{67,'mconumber'}
      ,{68,'mcoaddressline1'}
      ,{69,'mcoaddressline2'}
      ,{70,'mcocity'}
      ,{71,'mcostate'}
      ,{72,'mcozip'}
      ,{73,'mcozip4'}
      ,{74,'mcophone'}
      ,{75,'governingclasscode'}
      ,{76,'licensenumber'}
      ,{77,'class'}
      ,{78,'classificationdescription'}
      ,{79,'licensestatus'}
      ,{80,'licenseadditionalinfo'}
      ,{81,'licenseissuedate'}
      ,{82,'licenseexpirationdate'}
      ,{83,'naicscode'}
      ,{84,'officerexemptfirstname1'}
      ,{85,'officerexemptlastname1'}
      ,{86,'officerexemptmiddlename1'}
      ,{87,'officerexempttitle1'}
      ,{88,'officerexempteffectivedate1'}
      ,{89,'officerexemptterminationdate1'}
      ,{90,'officerexempttype1'}
      ,{91,'officerexemptbusinessactivities1'}
      ,{92,'officerexemptfirstname2'}
      ,{93,'officerexemptlastname2'}
      ,{94,'officerexemptmiddlename2'}
      ,{95,'officerexempttitle2'}
      ,{96,'officerexempteffectivedate2'}
      ,{97,'officerexemptterminationdate2'}
      ,{98,'officerexempttype2'}
      ,{99,'officerexemptbusinessactivities2'}
      ,{100,'officerexemptfirstname3'}
      ,{101,'officerexemptlastname3'}
      ,{102,'officerexemptmiddlename3'}
      ,{103,'officerexempttitle3'}
      ,{104,'officerexempteffectivedate3'}
      ,{105,'officerexemptterminationdate3'}
      ,{106,'officerexempttype3'}
      ,{107,'officerexemptbusinessactivities3'}
      ,{108,'officerexemptfirstname4'}
      ,{109,'officerexemptlastname4'}
      ,{110,'officerexemptmiddlename4'}
      ,{111,'officerexempttitle4'}
      ,{112,'officerexempteffectivedate4'}
      ,{113,'officerexemptterminationdate4'}
      ,{114,'officerexempttype4'}
      ,{115,'officerexemptbusinessactivities4'}
      ,{116,'officerexemptfirstname5'}
      ,{117,'officerexemptlastname5'}
      ,{118,'officerexemptmiddlename5'}
      ,{119,'officerexempttitle5'}
      ,{120,'officerexempteffectivedate5'}
      ,{121,'officerexemptterminationdate5'}
      ,{122,'officerexempttype5'}
      ,{123,'officerexemptbusinessactivities5'}
      ,{124,'dba1'}
      ,{125,'dbadatefrom1'}
      ,{126,'dbadateto1'}
      ,{127,'dbatype1'}
      ,{128,'dba2'}
      ,{129,'dbadatefrom2'}
      ,{130,'dbadateto2'}
      ,{131,'dbatype2'}
      ,{132,'dba3'}
      ,{133,'dbadatefrom3'}
      ,{134,'dbadateto3'}
      ,{135,'dbatype3'}
      ,{136,'dba4'}
      ,{137,'dbadatefrom4'}
      ,{138,'dbadateto4'}
      ,{139,'dbatype4'}
      ,{140,'dba5'}
      ,{141,'dbadatefrom5'}
      ,{142,'dbadateto5'}
      ,{143,'dbatype5'}
      ,{144,'subsidiaryname1'}
      ,{145,'subsidiarystartdate1'}
      ,{146,'subsidiaryname2'}
      ,{147,'subsidiarystartdate2'}
      ,{148,'subsidiaryname3'}
      ,{149,'subsidiarystartdate3'}
      ,{150,'subsidiaryname4'}
      ,{151,'subsidiarystartdate4'}
      ,{152,'subsidiaryname5'}
      ,{153,'subsidiarystartdate5'}
      ,{154,'subsidiaryname6'}
      ,{155,'subsidiarystartdate6'}
      ,{156,'subsidiaryname7'}
      ,{157,'subsidiarystartdate7'}
      ,{158,'subsidiaryname8'}
      ,{159,'subsidiarystartdate8'}
      ,{160,'subsidiaryname9'}
      ,{161,'subsidiarystartdate9'}
      ,{162,'subsidiaryname10'}
      ,{163,'subsidiarystartdate10'}],SALT311.MAC_Character_Counts.Field_Identification);
EXPORT AllProfiles := SALT311.MAC_Character_Counts.FN_Profile(FldInv0,FldIds);
 
EXPORT SrcProfiles := SALT311.MAC_Character_Counts.Src_Profile(FldInv0,FldIds);
 
EXPORT Correlations := SALT311.MAC_Correlate.Fn_Profile(Pairs0,FldIds);
 
ErrorRecord := RECORD
  UNSIGNED1 FieldNum;
  UNSIGNED1 ErrorNum;
END;
ErrorRecord NoteErrors(h le,UNSIGNED1 c) := TRANSFORM
  SELF.ErrorNum := CHOOSE(c,
    Cert_Fields.InValid_dartid((SALT311.StrType)le.dartid),
    Cert_Fields.InValid_dateadded((SALT311.StrType)le.dateadded),
    Cert_Fields.InValid_dateupdated((SALT311.StrType)le.dateupdated),
    Cert_Fields.InValid_website((SALT311.StrType)le.website),
    Cert_Fields.InValid_state((SALT311.StrType)le.state),
    Cert_Fields.InValid_lninscertrecordid((SALT311.StrType)le.lninscertrecordid),
    Cert_Fields.InValid_profilelastupdated((SALT311.StrType)le.profilelastupdated),
    Cert_Fields.InValid_siid((SALT311.StrType)le.siid),
    Cert_Fields.InValid_sipstatuscode((SALT311.StrType)le.sipstatuscode),
    Cert_Fields.InValid_wcbempnumber((SALT311.StrType)le.wcbempnumber),
    Cert_Fields.InValid_ubinumber((SALT311.StrType)le.ubinumber),
    Cert_Fields.InValid_cofanumber((SALT311.StrType)le.cofanumber),
    Cert_Fields.InValid_usdotnumber((SALT311.StrType)le.usdotnumber),
    Cert_Fields.InValid_businessname((SALT311.StrType)le.businessname),
    Cert_Fields.InValid_dba((SALT311.StrType)le.dba),
    Cert_Fields.InValid_addressline1((SALT311.StrType)le.addressline1),
    Cert_Fields.InValid_addressline2((SALT311.StrType)le.addressline2),
    Cert_Fields.InValid_addresscity((SALT311.StrType)le.addresscity),
    Cert_Fields.InValid_addressstate((SALT311.StrType)le.addressstate),
    Cert_Fields.InValid_addresszip((SALT311.StrType)le.addresszip),
    Cert_Fields.InValid_zip4((SALT311.StrType)le.zip4),
    Cert_Fields.InValid_phone1((SALT311.StrType)le.phone1),
    Cert_Fields.InValid_phone2((SALT311.StrType)le.phone2),
    Cert_Fields.InValid_phone3((SALT311.StrType)le.phone3),
    Cert_Fields.InValid_fax1((SALT311.StrType)le.fax1),
    Cert_Fields.InValid_fax2((SALT311.StrType)le.fax2),
    Cert_Fields.InValid_email1((SALT311.StrType)le.email1),
    Cert_Fields.InValid_email2((SALT311.StrType)le.email2),
    Cert_Fields.InValid_businesstype((SALT311.StrType)le.businesstype),
    Cert_Fields.InValid_namefirst((SALT311.StrType)le.namefirst),
    Cert_Fields.InValid_namemiddle((SALT311.StrType)le.namemiddle),
    Cert_Fields.InValid_namelast((SALT311.StrType)le.namelast),
    Cert_Fields.InValid_namesuffix((SALT311.StrType)le.namesuffix),
    Cert_Fields.InValid_nametitle((SALT311.StrType)le.nametitle),
    Cert_Fields.InValid_mailingaddress1((SALT311.StrType)le.mailingaddress1),
    Cert_Fields.InValid_mailingaddress2((SALT311.StrType)le.mailingaddress2),
    Cert_Fields.InValid_mailingaddresscity((SALT311.StrType)le.mailingaddresscity),
    Cert_Fields.InValid_mailingaddressstate((SALT311.StrType)le.mailingaddressstate),
    Cert_Fields.InValid_mailingaddresszip((SALT311.StrType)le.mailingaddresszip),
    Cert_Fields.InValid_mailingaddresszip4((SALT311.StrType)le.mailingaddresszip4),
    Cert_Fields.InValid_contactnamefirst((SALT311.StrType)le.contactnamefirst),
    Cert_Fields.InValid_contactnamemiddle((SALT311.StrType)le.contactnamemiddle),
    Cert_Fields.InValid_contactnamelast((SALT311.StrType)le.contactnamelast),
    Cert_Fields.InValid_contactnamesuffix((SALT311.StrType)le.contactnamesuffix),
    Cert_Fields.InValid_contactbusinessname((SALT311.StrType)le.contactbusinessname),
    Cert_Fields.InValid_contactaddressline1((SALT311.StrType)le.contactaddressline1),
    Cert_Fields.InValid_contactaddressline2((SALT311.StrType)le.contactaddressline2),
    Cert_Fields.InValid_contactcity((SALT311.StrType)le.contactcity),
    Cert_Fields.InValid_contactstate((SALT311.StrType)le.contactstate),
    Cert_Fields.InValid_contactzip((SALT311.StrType)le.contactzip),
    Cert_Fields.InValid_contactzip4((SALT311.StrType)le.contactzip4),
    Cert_Fields.InValid_contactphone((SALT311.StrType)le.contactphone),
    Cert_Fields.InValid_contactfax((SALT311.StrType)le.contactfax),
    Cert_Fields.InValid_contactemail((SALT311.StrType)le.contactemail),
    Cert_Fields.InValid_policyholdernamefirst((SALT311.StrType)le.policyholdernamefirst),
    Cert_Fields.InValid_policyholdernamemiddle((SALT311.StrType)le.policyholdernamemiddle),
    Cert_Fields.InValid_policyholdernamelast((SALT311.StrType)le.policyholdernamelast),
    Cert_Fields.InValid_policyholdernamesuffix((SALT311.StrType)le.policyholdernamesuffix),
    Cert_Fields.InValid_statepolicyfilenumber((SALT311.StrType)le.statepolicyfilenumber),
    Cert_Fields.InValid_coverageinjuryillnessdate((SALT311.StrType)le.coverageinjuryillnessdate),
    Cert_Fields.InValid_selfinsurancegroup((SALT311.StrType)le.selfinsurancegroup),
    Cert_Fields.InValid_selfinsurancegroupphone((SALT311.StrType)le.selfinsurancegroupphone),
    Cert_Fields.InValid_selfinsurancegroupid((SALT311.StrType)le.selfinsurancegroupid),
    Cert_Fields.InValid_numberofemployees((SALT311.StrType)le.numberofemployees),
    Cert_Fields.InValid_licensedcontractor((SALT311.StrType)le.licensedcontractor),
    Cert_Fields.InValid_mconame((SALT311.StrType)le.mconame),
    Cert_Fields.InValid_mconumber((SALT311.StrType)le.mconumber),
    Cert_Fields.InValid_mcoaddressline1((SALT311.StrType)le.mcoaddressline1),
    Cert_Fields.InValid_mcoaddressline2((SALT311.StrType)le.mcoaddressline2),
    Cert_Fields.InValid_mcocity((SALT311.StrType)le.mcocity),
    Cert_Fields.InValid_mcostate((SALT311.StrType)le.mcostate),
    Cert_Fields.InValid_mcozip((SALT311.StrType)le.mcozip),
    Cert_Fields.InValid_mcozip4((SALT311.StrType)le.mcozip4),
    Cert_Fields.InValid_mcophone((SALT311.StrType)le.mcophone),
    Cert_Fields.InValid_governingclasscode((SALT311.StrType)le.governingclasscode),
    Cert_Fields.InValid_licensenumber((SALT311.StrType)le.licensenumber),
    Cert_Fields.InValid_class((SALT311.StrType)le.class),
    Cert_Fields.InValid_classificationdescription((SALT311.StrType)le.classificationdescription),
    Cert_Fields.InValid_licensestatus((SALT311.StrType)le.licensestatus),
    Cert_Fields.InValid_licenseadditionalinfo((SALT311.StrType)le.licenseadditionalinfo),
    Cert_Fields.InValid_licenseissuedate((SALT311.StrType)le.licenseissuedate),
    Cert_Fields.InValid_licenseexpirationdate((SALT311.StrType)le.licenseexpirationdate),
    Cert_Fields.InValid_naicscode((SALT311.StrType)le.naicscode),
    Cert_Fields.InValid_officerexemptfirstname1((SALT311.StrType)le.officerexemptfirstname1),
    Cert_Fields.InValid_officerexemptlastname1((SALT311.StrType)le.officerexemptlastname1),
    Cert_Fields.InValid_officerexemptmiddlename1((SALT311.StrType)le.officerexemptmiddlename1),
    Cert_Fields.InValid_officerexempttitle1((SALT311.StrType)le.officerexempttitle1),
    Cert_Fields.InValid_officerexempteffectivedate1((SALT311.StrType)le.officerexempteffectivedate1),
    Cert_Fields.InValid_officerexemptterminationdate1((SALT311.StrType)le.officerexemptterminationdate1),
    Cert_Fields.InValid_officerexempttype1((SALT311.StrType)le.officerexempttype1),
    Cert_Fields.InValid_officerexemptbusinessactivities1((SALT311.StrType)le.officerexemptbusinessactivities1),
    Cert_Fields.InValid_officerexemptfirstname2((SALT311.StrType)le.officerexemptfirstname2),
    Cert_Fields.InValid_officerexemptlastname2((SALT311.StrType)le.officerexemptlastname2),
    Cert_Fields.InValid_officerexemptmiddlename2((SALT311.StrType)le.officerexemptmiddlename2),
    Cert_Fields.InValid_officerexempttitle2((SALT311.StrType)le.officerexempttitle2),
    Cert_Fields.InValid_officerexempteffectivedate2((SALT311.StrType)le.officerexempteffectivedate2),
    Cert_Fields.InValid_officerexemptterminationdate2((SALT311.StrType)le.officerexemptterminationdate2),
    Cert_Fields.InValid_officerexempttype2((SALT311.StrType)le.officerexempttype2),
    Cert_Fields.InValid_officerexemptbusinessactivities2((SALT311.StrType)le.officerexemptbusinessactivities2),
    Cert_Fields.InValid_officerexemptfirstname3((SALT311.StrType)le.officerexemptfirstname3),
    Cert_Fields.InValid_officerexemptlastname3((SALT311.StrType)le.officerexemptlastname3),
    Cert_Fields.InValid_officerexemptmiddlename3((SALT311.StrType)le.officerexemptmiddlename3),
    Cert_Fields.InValid_officerexempttitle3((SALT311.StrType)le.officerexempttitle3),
    Cert_Fields.InValid_officerexempteffectivedate3((SALT311.StrType)le.officerexempteffectivedate3),
    Cert_Fields.InValid_officerexemptterminationdate3((SALT311.StrType)le.officerexemptterminationdate3),
    Cert_Fields.InValid_officerexempttype3((SALT311.StrType)le.officerexempttype3),
    Cert_Fields.InValid_officerexemptbusinessactivities3((SALT311.StrType)le.officerexemptbusinessactivities3),
    Cert_Fields.InValid_officerexemptfirstname4((SALT311.StrType)le.officerexemptfirstname4),
    Cert_Fields.InValid_officerexemptlastname4((SALT311.StrType)le.officerexemptlastname4),
    Cert_Fields.InValid_officerexemptmiddlename4((SALT311.StrType)le.officerexemptmiddlename4),
    Cert_Fields.InValid_officerexempttitle4((SALT311.StrType)le.officerexempttitle4),
    Cert_Fields.InValid_officerexempteffectivedate4((SALT311.StrType)le.officerexempteffectivedate4),
    Cert_Fields.InValid_officerexemptterminationdate4((SALT311.StrType)le.officerexemptterminationdate4),
    Cert_Fields.InValid_officerexempttype4((SALT311.StrType)le.officerexempttype4),
    Cert_Fields.InValid_officerexemptbusinessactivities4((SALT311.StrType)le.officerexemptbusinessactivities4),
    Cert_Fields.InValid_officerexemptfirstname5((SALT311.StrType)le.officerexemptfirstname5),
    Cert_Fields.InValid_officerexemptlastname5((SALT311.StrType)le.officerexemptlastname5),
    Cert_Fields.InValid_officerexemptmiddlename5((SALT311.StrType)le.officerexemptmiddlename5),
    Cert_Fields.InValid_officerexempttitle5((SALT311.StrType)le.officerexempttitle5),
    Cert_Fields.InValid_officerexempteffectivedate5((SALT311.StrType)le.officerexempteffectivedate5),
    Cert_Fields.InValid_officerexemptterminationdate5((SALT311.StrType)le.officerexemptterminationdate5),
    Cert_Fields.InValid_officerexempttype5((SALT311.StrType)le.officerexempttype5),
    Cert_Fields.InValid_officerexemptbusinessactivities5((SALT311.StrType)le.officerexemptbusinessactivities5),
    Cert_Fields.InValid_dba1((SALT311.StrType)le.dba1),
    Cert_Fields.InValid_dbadatefrom1((SALT311.StrType)le.dbadatefrom1),
    Cert_Fields.InValid_dbadateto1((SALT311.StrType)le.dbadateto1),
    Cert_Fields.InValid_dbatype1((SALT311.StrType)le.dbatype1),
    Cert_Fields.InValid_dba2((SALT311.StrType)le.dba2),
    Cert_Fields.InValid_dbadatefrom2((SALT311.StrType)le.dbadatefrom2),
    Cert_Fields.InValid_dbadateto2((SALT311.StrType)le.dbadateto2),
    Cert_Fields.InValid_dbatype2((SALT311.StrType)le.dbatype2),
    Cert_Fields.InValid_dba3((SALT311.StrType)le.dba3),
    Cert_Fields.InValid_dbadatefrom3((SALT311.StrType)le.dbadatefrom3),
    Cert_Fields.InValid_dbadateto3((SALT311.StrType)le.dbadateto3),
    Cert_Fields.InValid_dbatype3((SALT311.StrType)le.dbatype3),
    Cert_Fields.InValid_dba4((SALT311.StrType)le.dba4),
    Cert_Fields.InValid_dbadatefrom4((SALT311.StrType)le.dbadatefrom4),
    Cert_Fields.InValid_dbadateto4((SALT311.StrType)le.dbadateto4),
    Cert_Fields.InValid_dbatype4((SALT311.StrType)le.dbatype4),
    Cert_Fields.InValid_dba5((SALT311.StrType)le.dba5),
    Cert_Fields.InValid_dbadatefrom5((SALT311.StrType)le.dbadatefrom5),
    Cert_Fields.InValid_dbadateto5((SALT311.StrType)le.dbadateto5),
    Cert_Fields.InValid_dbatype5((SALT311.StrType)le.dbatype5),
    Cert_Fields.InValid_subsidiaryname1((SALT311.StrType)le.subsidiaryname1),
    Cert_Fields.InValid_subsidiarystartdate1((SALT311.StrType)le.subsidiarystartdate1),
    Cert_Fields.InValid_subsidiaryname2((SALT311.StrType)le.subsidiaryname2),
    Cert_Fields.InValid_subsidiarystartdate2((SALT311.StrType)le.subsidiarystartdate2),
    Cert_Fields.InValid_subsidiaryname3((SALT311.StrType)le.subsidiaryname3),
    Cert_Fields.InValid_subsidiarystartdate3((SALT311.StrType)le.subsidiarystartdate3),
    Cert_Fields.InValid_subsidiaryname4((SALT311.StrType)le.subsidiaryname4),
    Cert_Fields.InValid_subsidiarystartdate4((SALT311.StrType)le.subsidiarystartdate4),
    Cert_Fields.InValid_subsidiaryname5((SALT311.StrType)le.subsidiaryname5),
    Cert_Fields.InValid_subsidiarystartdate5((SALT311.StrType)le.subsidiarystartdate5),
    Cert_Fields.InValid_subsidiaryname6((SALT311.StrType)le.subsidiaryname6),
    Cert_Fields.InValid_subsidiarystartdate6((SALT311.StrType)le.subsidiarystartdate6),
    Cert_Fields.InValid_subsidiaryname7((SALT311.StrType)le.subsidiaryname7),
    Cert_Fields.InValid_subsidiarystartdate7((SALT311.StrType)le.subsidiarystartdate7),
    Cert_Fields.InValid_subsidiaryname8((SALT311.StrType)le.subsidiaryname8),
    Cert_Fields.InValid_subsidiarystartdate8((SALT311.StrType)le.subsidiarystartdate8),
    Cert_Fields.InValid_subsidiaryname9((SALT311.StrType)le.subsidiaryname9),
    Cert_Fields.InValid_subsidiarystartdate9((SALT311.StrType)le.subsidiarystartdate9),
    Cert_Fields.InValid_subsidiaryname10((SALT311.StrType)le.subsidiaryname10),
    Cert_Fields.InValid_subsidiarystartdate10((SALT311.StrType)le.subsidiarystartdate10),
    0);
  SELF.FieldNum := IF(SELF.ErrorNum=0,SKIP,c); // Bail early to avoid creating record
END;
Errors := NORMALIZE(h,163,NoteErrors(LEFT,COUNTER));
ErrorRecordsTotals := RECORD
  Errors.FieldNum;
  Errors.ErrorNum;
  UNSIGNED Cnt := COUNT(GROUP);
END;
TotalErrors := TABLE(Errors,ErrorRecordsTotals,FieldNum,ErrorNum,FEW);
PrettyErrorTotals := RECORD
  FieldNme := Cert_Fields.FieldName(TotalErrors.FieldNum);
  FieldType := CHOOSE(TotalErrors.FieldNum,'Invalid_No','Invalid_Date','Invalid_Date','Invalid_Alpha','Invalid_State','Invalid_No','Invalid_Date','Invalid_No','Test','Invalid_No','Invalid_No','Invalid_No','Invalid_No','Invalid_AlphaChar','Invalid_AlphaChar','Invalid_AlphaChar','Invalid_AlphaNum','Invalid_AlphaCaps','Invalid_State','Invalid_Zip','Invalid_No','Test','Test','Test','Test','Test','Test','Test','Test','Test','Test','Test','Test','Test','Test','Test','Test','Test','Test','Test','Test','Test','Test','Test','Test','Test','Test','Test','Test','Test','Test','Test','Test','Test','Test','Test','Test','Test','Test','Test','Invalid_AlphaCaps','Test','Test','Test','Test','Test','Test','Test','Test','Test','Test','Test','Test','Test','Test','Test','Test','Test','Test','Test','Test','Test','Test','Test','Test','Test','Test','Test','Test','Test','Test','Test','Test','Test','Test','Test','Test','Test','Test','Test','Test','Test','Test','Test','Test','Test','Test','Test','Test','Test','Test','Test','Test','Test','Test','Test','Test','Test','Test','Test','Test','Test','Test','Test','Test','Test','Test','Test','Test','Test','Test','Test','Test','Test','Test','Test','Test','Test','Test','Test','Test','Test','Test','Test','Test','Test','Test','Test','Test','Test','Test','Test','Test','Test','Test','Test','Test','Test','Test','Test','Test','Test','Test');
  ErrorMessage := CHOOSE(TotalErrors.FieldNum,Cert_Fields.InValidMessage_dartid(TotalErrors.ErrorNum),Cert_Fields.InValidMessage_dateadded(TotalErrors.ErrorNum),Cert_Fields.InValidMessage_dateupdated(TotalErrors.ErrorNum),Cert_Fields.InValidMessage_website(TotalErrors.ErrorNum),Cert_Fields.InValidMessage_state(TotalErrors.ErrorNum),Cert_Fields.InValidMessage_lninscertrecordid(TotalErrors.ErrorNum),Cert_Fields.InValidMessage_profilelastupdated(TotalErrors.ErrorNum),Cert_Fields.InValidMessage_siid(TotalErrors.ErrorNum),Cert_Fields.InValidMessage_sipstatuscode(TotalErrors.ErrorNum),Cert_Fields.InValidMessage_wcbempnumber(TotalErrors.ErrorNum),Cert_Fields.InValidMessage_ubinumber(TotalErrors.ErrorNum),Cert_Fields.InValidMessage_cofanumber(TotalErrors.ErrorNum),Cert_Fields.InValidMessage_usdotnumber(TotalErrors.ErrorNum),Cert_Fields.InValidMessage_businessname(TotalErrors.ErrorNum),Cert_Fields.InValidMessage_dba(TotalErrors.ErrorNum),Cert_Fields.InValidMessage_addressline1(TotalErrors.ErrorNum),Cert_Fields.InValidMessage_addressline2(TotalErrors.ErrorNum),Cert_Fields.InValidMessage_addresscity(TotalErrors.ErrorNum),Cert_Fields.InValidMessage_addressstate(TotalErrors.ErrorNum),Cert_Fields.InValidMessage_addresszip(TotalErrors.ErrorNum),Cert_Fields.InValidMessage_zip4(TotalErrors.ErrorNum),Cert_Fields.InValidMessage_phone1(TotalErrors.ErrorNum),Cert_Fields.InValidMessage_phone2(TotalErrors.ErrorNum),Cert_Fields.InValidMessage_phone3(TotalErrors.ErrorNum),Cert_Fields.InValidMessage_fax1(TotalErrors.ErrorNum),Cert_Fields.InValidMessage_fax2(TotalErrors.ErrorNum),Cert_Fields.InValidMessage_email1(TotalErrors.ErrorNum),Cert_Fields.InValidMessage_email2(TotalErrors.ErrorNum),Cert_Fields.InValidMessage_businesstype(TotalErrors.ErrorNum),Cert_Fields.InValidMessage_namefirst(TotalErrors.ErrorNum),Cert_Fields.InValidMessage_namemiddle(TotalErrors.ErrorNum),Cert_Fields.InValidMessage_namelast(TotalErrors.ErrorNum),Cert_Fields.InValidMessage_namesuffix(TotalErrors.ErrorNum),Cert_Fields.InValidMessage_nametitle(TotalErrors.ErrorNum),Cert_Fields.InValidMessage_mailingaddress1(TotalErrors.ErrorNum),Cert_Fields.InValidMessage_mailingaddress2(TotalErrors.ErrorNum),Cert_Fields.InValidMessage_mailingaddresscity(TotalErrors.ErrorNum),Cert_Fields.InValidMessage_mailingaddressstate(TotalErrors.ErrorNum),Cert_Fields.InValidMessage_mailingaddresszip(TotalErrors.ErrorNum),Cert_Fields.InValidMessage_mailingaddresszip4(TotalErrors.ErrorNum),Cert_Fields.InValidMessage_contactnamefirst(TotalErrors.ErrorNum),Cert_Fields.InValidMessage_contactnamemiddle(TotalErrors.ErrorNum),Cert_Fields.InValidMessage_contactnamelast(TotalErrors.ErrorNum),Cert_Fields.InValidMessage_contactnamesuffix(TotalErrors.ErrorNum),Cert_Fields.InValidMessage_contactbusinessname(TotalErrors.ErrorNum),Cert_Fields.InValidMessage_contactaddressline1(TotalErrors.ErrorNum),Cert_Fields.InValidMessage_contactaddressline2(TotalErrors.ErrorNum),Cert_Fields.InValidMessage_contactcity(TotalErrors.ErrorNum),Cert_Fields.InValidMessage_contactstate(TotalErrors.ErrorNum),Cert_Fields.InValidMessage_contactzip(TotalErrors.ErrorNum),Cert_Fields.InValidMessage_contactzip4(TotalErrors.ErrorNum),Cert_Fields.InValidMessage_contactphone(TotalErrors.ErrorNum),Cert_Fields.InValidMessage_contactfax(TotalErrors.ErrorNum),Cert_Fields.InValidMessage_contactemail(TotalErrors.ErrorNum),Cert_Fields.InValidMessage_policyholdernamefirst(TotalErrors.ErrorNum),Cert_Fields.InValidMessage_policyholdernamemiddle(TotalErrors.ErrorNum),Cert_Fields.InValidMessage_policyholdernamelast(TotalErrors.ErrorNum),Cert_Fields.InValidMessage_policyholdernamesuffix(TotalErrors.ErrorNum),Cert_Fields.InValidMessage_statepolicyfilenumber(TotalErrors.ErrorNum),Cert_Fields.InValidMessage_coverageinjuryillnessdate(TotalErrors.ErrorNum),Cert_Fields.InValidMessage_selfinsurancegroup(TotalErrors.ErrorNum),Cert_Fields.InValidMessage_selfinsurancegroupphone(TotalErrors.ErrorNum),Cert_Fields.InValidMessage_selfinsurancegroupid(TotalErrors.ErrorNum),Cert_Fields.InValidMessage_numberofemployees(TotalErrors.ErrorNum),Cert_Fields.InValidMessage_licensedcontractor(TotalErrors.ErrorNum),Cert_Fields.InValidMessage_mconame(TotalErrors.ErrorNum),Cert_Fields.InValidMessage_mconumber(TotalErrors.ErrorNum),Cert_Fields.InValidMessage_mcoaddressline1(TotalErrors.ErrorNum),Cert_Fields.InValidMessage_mcoaddressline2(TotalErrors.ErrorNum),Cert_Fields.InValidMessage_mcocity(TotalErrors.ErrorNum),Cert_Fields.InValidMessage_mcostate(TotalErrors.ErrorNum),Cert_Fields.InValidMessage_mcozip(TotalErrors.ErrorNum),Cert_Fields.InValidMessage_mcozip4(TotalErrors.ErrorNum),Cert_Fields.InValidMessage_mcophone(TotalErrors.ErrorNum),Cert_Fields.InValidMessage_governingclasscode(TotalErrors.ErrorNum),Cert_Fields.InValidMessage_licensenumber(TotalErrors.ErrorNum),Cert_Fields.InValidMessage_class(TotalErrors.ErrorNum),Cert_Fields.InValidMessage_classificationdescription(TotalErrors.ErrorNum),Cert_Fields.InValidMessage_licensestatus(TotalErrors.ErrorNum),Cert_Fields.InValidMessage_licenseadditionalinfo(TotalErrors.ErrorNum),Cert_Fields.InValidMessage_licenseissuedate(TotalErrors.ErrorNum),Cert_Fields.InValidMessage_licenseexpirationdate(TotalErrors.ErrorNum),Cert_Fields.InValidMessage_naicscode(TotalErrors.ErrorNum),Cert_Fields.InValidMessage_officerexemptfirstname1(TotalErrors.ErrorNum),Cert_Fields.InValidMessage_officerexemptlastname1(TotalErrors.ErrorNum),Cert_Fields.InValidMessage_officerexemptmiddlename1(TotalErrors.ErrorNum),Cert_Fields.InValidMessage_officerexempttitle1(TotalErrors.ErrorNum),Cert_Fields.InValidMessage_officerexempteffectivedate1(TotalErrors.ErrorNum),Cert_Fields.InValidMessage_officerexemptterminationdate1(TotalErrors.ErrorNum),Cert_Fields.InValidMessage_officerexempttype1(TotalErrors.ErrorNum),Cert_Fields.InValidMessage_officerexemptbusinessactivities1(TotalErrors.ErrorNum),Cert_Fields.InValidMessage_officerexemptfirstname2(TotalErrors.ErrorNum),Cert_Fields.InValidMessage_officerexemptlastname2(TotalErrors.ErrorNum),Cert_Fields.InValidMessage_officerexemptmiddlename2(TotalErrors.ErrorNum),Cert_Fields.InValidMessage_officerexempttitle2(TotalErrors.ErrorNum),Cert_Fields.InValidMessage_officerexempteffectivedate2(TotalErrors.ErrorNum),Cert_Fields.InValidMessage_officerexemptterminationdate2(TotalErrors.ErrorNum),Cert_Fields.InValidMessage_officerexempttype2(TotalErrors.ErrorNum),Cert_Fields.InValidMessage_officerexemptbusinessactivities2(TotalErrors.ErrorNum),Cert_Fields.InValidMessage_officerexemptfirstname3(TotalErrors.ErrorNum),Cert_Fields.InValidMessage_officerexemptlastname3(TotalErrors.ErrorNum),Cert_Fields.InValidMessage_officerexemptmiddlename3(TotalErrors.ErrorNum),Cert_Fields.InValidMessage_officerexempttitle3(TotalErrors.ErrorNum),Cert_Fields.InValidMessage_officerexempteffectivedate3(TotalErrors.ErrorNum),Cert_Fields.InValidMessage_officerexemptterminationdate3(TotalErrors.ErrorNum),Cert_Fields.InValidMessage_officerexempttype3(TotalErrors.ErrorNum),Cert_Fields.InValidMessage_officerexemptbusinessactivities3(TotalErrors.ErrorNum),Cert_Fields.InValidMessage_officerexemptfirstname4(TotalErrors.ErrorNum),Cert_Fields.InValidMessage_officerexemptlastname4(TotalErrors.ErrorNum),Cert_Fields.InValidMessage_officerexemptmiddlename4(TotalErrors.ErrorNum),Cert_Fields.InValidMessage_officerexempttitle4(TotalErrors.ErrorNum),Cert_Fields.InValidMessage_officerexempteffectivedate4(TotalErrors.ErrorNum),Cert_Fields.InValidMessage_officerexemptterminationdate4(TotalErrors.ErrorNum),Cert_Fields.InValidMessage_officerexempttype4(TotalErrors.ErrorNum),Cert_Fields.InValidMessage_officerexemptbusinessactivities4(TotalErrors.ErrorNum),Cert_Fields.InValidMessage_officerexemptfirstname5(TotalErrors.ErrorNum),Cert_Fields.InValidMessage_officerexemptlastname5(TotalErrors.ErrorNum),Cert_Fields.InValidMessage_officerexemptmiddlename5(TotalErrors.ErrorNum),Cert_Fields.InValidMessage_officerexempttitle5(TotalErrors.ErrorNum),Cert_Fields.InValidMessage_officerexempteffectivedate5(TotalErrors.ErrorNum),Cert_Fields.InValidMessage_officerexemptterminationdate5(TotalErrors.ErrorNum),Cert_Fields.InValidMessage_officerexempttype5(TotalErrors.ErrorNum),Cert_Fields.InValidMessage_officerexemptbusinessactivities5(TotalErrors.ErrorNum),Cert_Fields.InValidMessage_dba1(TotalErrors.ErrorNum),Cert_Fields.InValidMessage_dbadatefrom1(TotalErrors.ErrorNum),Cert_Fields.InValidMessage_dbadateto1(TotalErrors.ErrorNum),Cert_Fields.InValidMessage_dbatype1(TotalErrors.ErrorNum),Cert_Fields.InValidMessage_dba2(TotalErrors.ErrorNum),Cert_Fields.InValidMessage_dbadatefrom2(TotalErrors.ErrorNum),Cert_Fields.InValidMessage_dbadateto2(TotalErrors.ErrorNum),Cert_Fields.InValidMessage_dbatype2(TotalErrors.ErrorNum),Cert_Fields.InValidMessage_dba3(TotalErrors.ErrorNum),Cert_Fields.InValidMessage_dbadatefrom3(TotalErrors.ErrorNum),Cert_Fields.InValidMessage_dbadateto3(TotalErrors.ErrorNum),Cert_Fields.InValidMessage_dbatype3(TotalErrors.ErrorNum),Cert_Fields.InValidMessage_dba4(TotalErrors.ErrorNum),Cert_Fields.InValidMessage_dbadatefrom4(TotalErrors.ErrorNum),Cert_Fields.InValidMessage_dbadateto4(TotalErrors.ErrorNum),Cert_Fields.InValidMessage_dbatype4(TotalErrors.ErrorNum),Cert_Fields.InValidMessage_dba5(TotalErrors.ErrorNum),Cert_Fields.InValidMessage_dbadatefrom5(TotalErrors.ErrorNum),Cert_Fields.InValidMessage_dbadateto5(TotalErrors.ErrorNum),Cert_Fields.InValidMessage_dbatype5(TotalErrors.ErrorNum),Cert_Fields.InValidMessage_subsidiaryname1(TotalErrors.ErrorNum),Cert_Fields.InValidMessage_subsidiarystartdate1(TotalErrors.ErrorNum),Cert_Fields.InValidMessage_subsidiaryname2(TotalErrors.ErrorNum),Cert_Fields.InValidMessage_subsidiarystartdate2(TotalErrors.ErrorNum),Cert_Fields.InValidMessage_subsidiaryname3(TotalErrors.ErrorNum),Cert_Fields.InValidMessage_subsidiarystartdate3(TotalErrors.ErrorNum),Cert_Fields.InValidMessage_subsidiaryname4(TotalErrors.ErrorNum),Cert_Fields.InValidMessage_subsidiarystartdate4(TotalErrors.ErrorNum),Cert_Fields.InValidMessage_subsidiaryname5(TotalErrors.ErrorNum),Cert_Fields.InValidMessage_subsidiarystartdate5(TotalErrors.ErrorNum),Cert_Fields.InValidMessage_subsidiaryname6(TotalErrors.ErrorNum),Cert_Fields.InValidMessage_subsidiarystartdate6(TotalErrors.ErrorNum),Cert_Fields.InValidMessage_subsidiaryname7(TotalErrors.ErrorNum),Cert_Fields.InValidMessage_subsidiarystartdate7(TotalErrors.ErrorNum),Cert_Fields.InValidMessage_subsidiaryname8(TotalErrors.ErrorNum),Cert_Fields.InValidMessage_subsidiarystartdate8(TotalErrors.ErrorNum),Cert_Fields.InValidMessage_subsidiaryname9(TotalErrors.ErrorNum),Cert_Fields.InValidMessage_subsidiarystartdate9(TotalErrors.ErrorNum),Cert_Fields.InValidMessage_subsidiaryname10(TotalErrors.ErrorNum),Cert_Fields.InValidMessage_subsidiarystartdate10(TotalErrors.ErrorNum));
  TotalErrors.Cnt;
END;
ValErr := TABLE(TotalErrors,PrettyErrorTotals);
EXPORT ValidityErrors := ValErr;
EXPORT StandardStats(BOOLEAN doSummaryGlobal = TRUE, BOOLEAN doAllProfiles = TRUE) := FUNCTION
  myTimeStamp := (UNSIGNED6)SALT311.Fn_Now('YYYYMMDDHHMMSS') : INDEPENDENT;
  fieldPopulationOverall := Summary('');
 
  SALT311.mod_StandardStatsTransforms.mac_hygieneSummaryTransform(Scrubs_Insurance_Cert, Cert_Fields, 'RECORDOF(fieldPopulationOverall)', FALSE);
 
  fieldPopulationOverall_Standard := IF(doSummaryGlobal, NORMALIZE(fieldPopulationOverall, COUNT(FldIds) * 6, xSummary(LEFT, COUNTER, myTimeStamp, 'all', 'all')));
  fieldPopulationOverall_TotalRecs_Standard := IF(doSummaryGlobal, SALT311.mod_StandardStatsTransforms.mac_hygieneTotalRecs(fieldPopulationOverall, myTimeStamp, 'all', FALSE, 'all'));
  allProfiles_Standard := IF(doAllProfiles, SALT311.mod_StandardStatsTransforms.hygieneAllProfiles(AllProfiles, myTimeStamp, 10, 'all'));
 
  RETURN fieldPopulationOverall_Standard & fieldPopulationOverall_TotalRecs_Standard & allProfiles_Standard;
END;
END;
