IMPORT SALT311,STD;
EXPORT Input_hygiene(dataset(Input_layout_Diversity_Certification) h) := MODULE
 
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
    populated_profilelastupdated_cnt := COUNT(GROUP,h.profilelastupdated <> (TYPEOF(h.profilelastupdated))'');
    populated_profilelastupdated_pcnt := AVE(GROUP,IF(h.profilelastupdated = (TYPEOF(h.profilelastupdated))'',0,100));
    maxlength_profilelastupdated := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.profilelastupdated)));
    avelength_profilelastupdated := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.profilelastupdated)),h.profilelastupdated<>(typeof(h.profilelastupdated))'');
    populated_county_cnt := COUNT(GROUP,h.county <> (TYPEOF(h.county))'');
    populated_county_pcnt := AVE(GROUP,IF(h.county = (TYPEOF(h.county))'',0,100));
    maxlength_county := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.county)));
    avelength_county := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.county)),h.county<>(typeof(h.county))'');
    populated_servicearea_cnt := COUNT(GROUP,h.servicearea <> (TYPEOF(h.servicearea))'');
    populated_servicearea_pcnt := AVE(GROUP,IF(h.servicearea = (TYPEOF(h.servicearea))'',0,100));
    maxlength_servicearea := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.servicearea)));
    avelength_servicearea := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.servicearea)),h.servicearea<>(typeof(h.servicearea))'');
    populated_region1_cnt := COUNT(GROUP,h.region1 <> (TYPEOF(h.region1))'');
    populated_region1_pcnt := AVE(GROUP,IF(h.region1 = (TYPEOF(h.region1))'',0,100));
    maxlength_region1 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.region1)));
    avelength_region1 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.region1)),h.region1<>(typeof(h.region1))'');
    populated_region2_cnt := COUNT(GROUP,h.region2 <> (TYPEOF(h.region2))'');
    populated_region2_pcnt := AVE(GROUP,IF(h.region2 = (TYPEOF(h.region2))'',0,100));
    maxlength_region2 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.region2)));
    avelength_region2 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.region2)),h.region2<>(typeof(h.region2))'');
    populated_region3_cnt := COUNT(GROUP,h.region3 <> (TYPEOF(h.region3))'');
    populated_region3_pcnt := AVE(GROUP,IF(h.region3 = (TYPEOF(h.region3))'',0,100));
    maxlength_region3 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.region3)));
    avelength_region3 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.region3)),h.region3<>(typeof(h.region3))'');
    populated_region4_cnt := COUNT(GROUP,h.region4 <> (TYPEOF(h.region4))'');
    populated_region4_pcnt := AVE(GROUP,IF(h.region4 = (TYPEOF(h.region4))'',0,100));
    maxlength_region4 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.region4)));
    avelength_region4 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.region4)),h.region4<>(typeof(h.region4))'');
    populated_region5_cnt := COUNT(GROUP,h.region5 <> (TYPEOF(h.region5))'');
    populated_region5_pcnt := AVE(GROUP,IF(h.region5 = (TYPEOF(h.region5))'',0,100));
    maxlength_region5 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.region5)));
    avelength_region5 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.region5)),h.region5<>(typeof(h.region5))'');
    populated_fname_cnt := COUNT(GROUP,h.fname <> (TYPEOF(h.fname))'');
    populated_fname_pcnt := AVE(GROUP,IF(h.fname = (TYPEOF(h.fname))'',0,100));
    maxlength_fname := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.fname)));
    avelength_fname := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.fname)),h.fname<>(typeof(h.fname))'');
    populated_lname_cnt := COUNT(GROUP,h.lname <> (TYPEOF(h.lname))'');
    populated_lname_pcnt := AVE(GROUP,IF(h.lname = (TYPEOF(h.lname))'',0,100));
    maxlength_lname := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.lname)));
    avelength_lname := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.lname)),h.lname<>(typeof(h.lname))'');
    populated_mname_cnt := COUNT(GROUP,h.mname <> (TYPEOF(h.mname))'');
    populated_mname_pcnt := AVE(GROUP,IF(h.mname = (TYPEOF(h.mname))'',0,100));
    maxlength_mname := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.mname)));
    avelength_mname := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.mname)),h.mname<>(typeof(h.mname))'');
    populated_suffix_cnt := COUNT(GROUP,h.suffix <> (TYPEOF(h.suffix))'');
    populated_suffix_pcnt := AVE(GROUP,IF(h.suffix = (TYPEOF(h.suffix))'',0,100));
    maxlength_suffix := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.suffix)));
    avelength_suffix := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.suffix)),h.suffix<>(typeof(h.suffix))'');
    populated_title_cnt := COUNT(GROUP,h.title <> (TYPEOF(h.title))'');
    populated_title_pcnt := AVE(GROUP,IF(h.title = (TYPEOF(h.title))'',0,100));
    maxlength_title := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.title)));
    avelength_title := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.title)),h.title<>(typeof(h.title))'');
    populated_ethnicity_cnt := COUNT(GROUP,h.ethnicity <> (TYPEOF(h.ethnicity))'');
    populated_ethnicity_pcnt := AVE(GROUP,IF(h.ethnicity = (TYPEOF(h.ethnicity))'',0,100));
    maxlength_ethnicity := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.ethnicity)));
    avelength_ethnicity := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.ethnicity)),h.ethnicity<>(typeof(h.ethnicity))'');
    populated_gender_cnt := COUNT(GROUP,h.gender <> (TYPEOF(h.gender))'');
    populated_gender_pcnt := AVE(GROUP,IF(h.gender = (TYPEOF(h.gender))'',0,100));
    maxlength_gender := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.gender)));
    avelength_gender := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.gender)),h.gender<>(typeof(h.gender))'');
    populated_address1_cnt := COUNT(GROUP,h.address1 <> (TYPEOF(h.address1))'');
    populated_address1_pcnt := AVE(GROUP,IF(h.address1 = (TYPEOF(h.address1))'',0,100));
    maxlength_address1 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.address1)));
    avelength_address1 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.address1)),h.address1<>(typeof(h.address1))'');
    populated_address2_cnt := COUNT(GROUP,h.address2 <> (TYPEOF(h.address2))'');
    populated_address2_pcnt := AVE(GROUP,IF(h.address2 = (TYPEOF(h.address2))'',0,100));
    maxlength_address2 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.address2)));
    avelength_address2 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.address2)),h.address2<>(typeof(h.address2))'');
    populated_addresscity_cnt := COUNT(GROUP,h.addresscity <> (TYPEOF(h.addresscity))'');
    populated_addresscity_pcnt := AVE(GROUP,IF(h.addresscity = (TYPEOF(h.addresscity))'',0,100));
    maxlength_addresscity := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.addresscity)));
    avelength_addresscity := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.addresscity)),h.addresscity<>(typeof(h.addresscity))'');
    populated_addressstate_cnt := COUNT(GROUP,h.addressstate <> (TYPEOF(h.addressstate))'');
    populated_addressstate_pcnt := AVE(GROUP,IF(h.addressstate = (TYPEOF(h.addressstate))'',0,100));
    maxlength_addressstate := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.addressstate)));
    avelength_addressstate := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.addressstate)),h.addressstate<>(typeof(h.addressstate))'');
    populated_addresszipcode_cnt := COUNT(GROUP,h.addresszipcode <> (TYPEOF(h.addresszipcode))'');
    populated_addresszipcode_pcnt := AVE(GROUP,IF(h.addresszipcode = (TYPEOF(h.addresszipcode))'',0,100));
    maxlength_addresszipcode := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.addresszipcode)));
    avelength_addresszipcode := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.addresszipcode)),h.addresszipcode<>(typeof(h.addresszipcode))'');
    populated_addresszip4_cnt := COUNT(GROUP,h.addresszip4 <> (TYPEOF(h.addresszip4))'');
    populated_addresszip4_pcnt := AVE(GROUP,IF(h.addresszip4 = (TYPEOF(h.addresszip4))'',0,100));
    maxlength_addresszip4 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.addresszip4)));
    avelength_addresszip4 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.addresszip4)),h.addresszip4<>(typeof(h.addresszip4))'');
    populated_building_cnt := COUNT(GROUP,h.building <> (TYPEOF(h.building))'');
    populated_building_pcnt := AVE(GROUP,IF(h.building = (TYPEOF(h.building))'',0,100));
    maxlength_building := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.building)));
    avelength_building := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.building)),h.building<>(typeof(h.building))'');
    populated_contact_cnt := COUNT(GROUP,h.contact <> (TYPEOF(h.contact))'');
    populated_contact_pcnt := AVE(GROUP,IF(h.contact = (TYPEOF(h.contact))'',0,100));
    maxlength_contact := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.contact)));
    avelength_contact := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.contact)),h.contact<>(typeof(h.contact))'');
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
    populated_cell_cnt := COUNT(GROUP,h.cell <> (TYPEOF(h.cell))'');
    populated_cell_pcnt := AVE(GROUP,IF(h.cell = (TYPEOF(h.cell))'',0,100));
    maxlength_cell := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.cell)));
    avelength_cell := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.cell)),h.cell<>(typeof(h.cell))'');
    populated_fax_cnt := COUNT(GROUP,h.fax <> (TYPEOF(h.fax))'');
    populated_fax_pcnt := AVE(GROUP,IF(h.fax = (TYPEOF(h.fax))'',0,100));
    maxlength_fax := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.fax)));
    avelength_fax := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.fax)),h.fax<>(typeof(h.fax))'');
    populated_email1_cnt := COUNT(GROUP,h.email1 <> (TYPEOF(h.email1))'');
    populated_email1_pcnt := AVE(GROUP,IF(h.email1 = (TYPEOF(h.email1))'',0,100));
    maxlength_email1 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.email1)));
    avelength_email1 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.email1)),h.email1<>(typeof(h.email1))'');
    populated_email2_cnt := COUNT(GROUP,h.email2 <> (TYPEOF(h.email2))'');
    populated_email2_pcnt := AVE(GROUP,IF(h.email2 = (TYPEOF(h.email2))'',0,100));
    maxlength_email2 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.email2)));
    avelength_email2 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.email2)),h.email2<>(typeof(h.email2))'');
    populated_email3_cnt := COUNT(GROUP,h.email3 <> (TYPEOF(h.email3))'');
    populated_email3_pcnt := AVE(GROUP,IF(h.email3 = (TYPEOF(h.email3))'',0,100));
    maxlength_email3 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.email3)));
    avelength_email3 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.email3)),h.email3<>(typeof(h.email3))'');
    populated_webpage1_cnt := COUNT(GROUP,h.webpage1 <> (TYPEOF(h.webpage1))'');
    populated_webpage1_pcnt := AVE(GROUP,IF(h.webpage1 = (TYPEOF(h.webpage1))'',0,100));
    maxlength_webpage1 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.webpage1)));
    avelength_webpage1 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.webpage1)),h.webpage1<>(typeof(h.webpage1))'');
    populated_webpage2_cnt := COUNT(GROUP,h.webpage2 <> (TYPEOF(h.webpage2))'');
    populated_webpage2_pcnt := AVE(GROUP,IF(h.webpage2 = (TYPEOF(h.webpage2))'',0,100));
    maxlength_webpage2 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.webpage2)));
    avelength_webpage2 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.webpage2)),h.webpage2<>(typeof(h.webpage2))'');
    populated_webpage3_cnt := COUNT(GROUP,h.webpage3 <> (TYPEOF(h.webpage3))'');
    populated_webpage3_pcnt := AVE(GROUP,IF(h.webpage3 = (TYPEOF(h.webpage3))'',0,100));
    maxlength_webpage3 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.webpage3)));
    avelength_webpage3 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.webpage3)),h.webpage3<>(typeof(h.webpage3))'');
    populated_businessname_cnt := COUNT(GROUP,h.businessname <> (TYPEOF(h.businessname))'');
    populated_businessname_pcnt := AVE(GROUP,IF(h.businessname = (TYPEOF(h.businessname))'',0,100));
    maxlength_businessname := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.businessname)));
    avelength_businessname := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.businessname)),h.businessname<>(typeof(h.businessname))'');
    populated_dba_cnt := COUNT(GROUP,h.dba <> (TYPEOF(h.dba))'');
    populated_dba_pcnt := AVE(GROUP,IF(h.dba = (TYPEOF(h.dba))'',0,100));
    maxlength_dba := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.dba)));
    avelength_dba := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.dba)),h.dba<>(typeof(h.dba))'');
    populated_businessid_cnt := COUNT(GROUP,h.businessid <> (TYPEOF(h.businessid))'');
    populated_businessid_pcnt := AVE(GROUP,IF(h.businessid = (TYPEOF(h.businessid))'',0,100));
    maxlength_businessid := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.businessid)));
    avelength_businessid := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.businessid)),h.businessid<>(typeof(h.businessid))'');
    populated_businesstype1_cnt := COUNT(GROUP,h.businesstype1 <> (TYPEOF(h.businesstype1))'');
    populated_businesstype1_pcnt := AVE(GROUP,IF(h.businesstype1 = (TYPEOF(h.businesstype1))'',0,100));
    maxlength_businesstype1 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.businesstype1)));
    avelength_businesstype1 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.businesstype1)),h.businesstype1<>(typeof(h.businesstype1))'');
    populated_businesslocation1_cnt := COUNT(GROUP,h.businesslocation1 <> (TYPEOF(h.businesslocation1))'');
    populated_businesslocation1_pcnt := AVE(GROUP,IF(h.businesslocation1 = (TYPEOF(h.businesslocation1))'',0,100));
    maxlength_businesslocation1 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.businesslocation1)));
    avelength_businesslocation1 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.businesslocation1)),h.businesslocation1<>(typeof(h.businesslocation1))'');
    populated_businesstype2_cnt := COUNT(GROUP,h.businesstype2 <> (TYPEOF(h.businesstype2))'');
    populated_businesstype2_pcnt := AVE(GROUP,IF(h.businesstype2 = (TYPEOF(h.businesstype2))'',0,100));
    maxlength_businesstype2 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.businesstype2)));
    avelength_businesstype2 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.businesstype2)),h.businesstype2<>(typeof(h.businesstype2))'');
    populated_businesslocation2_cnt := COUNT(GROUP,h.businesslocation2 <> (TYPEOF(h.businesslocation2))'');
    populated_businesslocation2_pcnt := AVE(GROUP,IF(h.businesslocation2 = (TYPEOF(h.businesslocation2))'',0,100));
    maxlength_businesslocation2 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.businesslocation2)));
    avelength_businesslocation2 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.businesslocation2)),h.businesslocation2<>(typeof(h.businesslocation2))'');
    populated_businesstype3_cnt := COUNT(GROUP,h.businesstype3 <> (TYPEOF(h.businesstype3))'');
    populated_businesstype3_pcnt := AVE(GROUP,IF(h.businesstype3 = (TYPEOF(h.businesstype3))'',0,100));
    maxlength_businesstype3 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.businesstype3)));
    avelength_businesstype3 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.businesstype3)),h.businesstype3<>(typeof(h.businesstype3))'');
    populated_businesslocation3_cnt := COUNT(GROUP,h.businesslocation3 <> (TYPEOF(h.businesslocation3))'');
    populated_businesslocation3_pcnt := AVE(GROUP,IF(h.businesslocation3 = (TYPEOF(h.businesslocation3))'',0,100));
    maxlength_businesslocation3 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.businesslocation3)));
    avelength_businesslocation3 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.businesslocation3)),h.businesslocation3<>(typeof(h.businesslocation3))'');
    populated_businesstype4_cnt := COUNT(GROUP,h.businesstype4 <> (TYPEOF(h.businesstype4))'');
    populated_businesstype4_pcnt := AVE(GROUP,IF(h.businesstype4 = (TYPEOF(h.businesstype4))'',0,100));
    maxlength_businesstype4 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.businesstype4)));
    avelength_businesstype4 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.businesstype4)),h.businesstype4<>(typeof(h.businesstype4))'');
    populated_businesslocation4_cnt := COUNT(GROUP,h.businesslocation4 <> (TYPEOF(h.businesslocation4))'');
    populated_businesslocation4_pcnt := AVE(GROUP,IF(h.businesslocation4 = (TYPEOF(h.businesslocation4))'',0,100));
    maxlength_businesslocation4 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.businesslocation4)));
    avelength_businesslocation4 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.businesslocation4)),h.businesslocation4<>(typeof(h.businesslocation4))'');
    populated_businesstype5_cnt := COUNT(GROUP,h.businesstype5 <> (TYPEOF(h.businesstype5))'');
    populated_businesstype5_pcnt := AVE(GROUP,IF(h.businesstype5 = (TYPEOF(h.businesstype5))'',0,100));
    maxlength_businesstype5 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.businesstype5)));
    avelength_businesstype5 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.businesstype5)),h.businesstype5<>(typeof(h.businesstype5))'');
    populated_businesslocation5_cnt := COUNT(GROUP,h.businesslocation5 <> (TYPEOF(h.businesslocation5))'');
    populated_businesslocation5_pcnt := AVE(GROUP,IF(h.businesslocation5 = (TYPEOF(h.businesslocation5))'',0,100));
    maxlength_businesslocation5 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.businesslocation5)));
    avelength_businesslocation5 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.businesslocation5)),h.businesslocation5<>(typeof(h.businesslocation5))'');
    populated_industry_cnt := COUNT(GROUP,h.industry <> (TYPEOF(h.industry))'');
    populated_industry_pcnt := AVE(GROUP,IF(h.industry = (TYPEOF(h.industry))'',0,100));
    maxlength_industry := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.industry)));
    avelength_industry := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.industry)),h.industry<>(typeof(h.industry))'');
    populated_trade_cnt := COUNT(GROUP,h.trade <> (TYPEOF(h.trade))'');
    populated_trade_pcnt := AVE(GROUP,IF(h.trade = (TYPEOF(h.trade))'',0,100));
    maxlength_trade := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.trade)));
    avelength_trade := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.trade)),h.trade<>(typeof(h.trade))'');
    populated_resourcedescription_cnt := COUNT(GROUP,h.resourcedescription <> (TYPEOF(h.resourcedescription))'');
    populated_resourcedescription_pcnt := AVE(GROUP,IF(h.resourcedescription = (TYPEOF(h.resourcedescription))'',0,100));
    maxlength_resourcedescription := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.resourcedescription)));
    avelength_resourcedescription := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.resourcedescription)),h.resourcedescription<>(typeof(h.resourcedescription))'');
    populated_natureofbusiness_cnt := COUNT(GROUP,h.natureofbusiness <> (TYPEOF(h.natureofbusiness))'');
    populated_natureofbusiness_pcnt := AVE(GROUP,IF(h.natureofbusiness = (TYPEOF(h.natureofbusiness))'',0,100));
    maxlength_natureofbusiness := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.natureofbusiness)));
    avelength_natureofbusiness := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.natureofbusiness)),h.natureofbusiness<>(typeof(h.natureofbusiness))'');
    populated_businessstructure_cnt := COUNT(GROUP,h.businessstructure <> (TYPEOF(h.businessstructure))'');
    populated_businessstructure_pcnt := AVE(GROUP,IF(h.businessstructure = (TYPEOF(h.businessstructure))'',0,100));
    maxlength_businessstructure := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.businessstructure)));
    avelength_businessstructure := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.businessstructure)),h.businessstructure<>(typeof(h.businessstructure))'');
    populated_totalemployees_cnt := COUNT(GROUP,h.totalemployees <> (TYPEOF(h.totalemployees))'');
    populated_totalemployees_pcnt := AVE(GROUP,IF(h.totalemployees = (TYPEOF(h.totalemployees))'',0,100));
    maxlength_totalemployees := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.totalemployees)));
    avelength_totalemployees := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.totalemployees)),h.totalemployees<>(typeof(h.totalemployees))'');
    populated_avgcontractsize_cnt := COUNT(GROUP,h.avgcontractsize <> (TYPEOF(h.avgcontractsize))'');
    populated_avgcontractsize_pcnt := AVE(GROUP,IF(h.avgcontractsize = (TYPEOF(h.avgcontractsize))'',0,100));
    maxlength_avgcontractsize := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.avgcontractsize)));
    avelength_avgcontractsize := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.avgcontractsize)),h.avgcontractsize<>(typeof(h.avgcontractsize))'');
    populated_firmid_cnt := COUNT(GROUP,h.firmid <> (TYPEOF(h.firmid))'');
    populated_firmid_pcnt := AVE(GROUP,IF(h.firmid = (TYPEOF(h.firmid))'',0,100));
    maxlength_firmid := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.firmid)));
    avelength_firmid := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.firmid)),h.firmid<>(typeof(h.firmid))'');
    populated_firmlocationaddress_cnt := COUNT(GROUP,h.firmlocationaddress <> (TYPEOF(h.firmlocationaddress))'');
    populated_firmlocationaddress_pcnt := AVE(GROUP,IF(h.firmlocationaddress = (TYPEOF(h.firmlocationaddress))'',0,100));
    maxlength_firmlocationaddress := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.firmlocationaddress)));
    avelength_firmlocationaddress := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.firmlocationaddress)),h.firmlocationaddress<>(typeof(h.firmlocationaddress))'');
    populated_firmlocationaddresscity_cnt := COUNT(GROUP,h.firmlocationaddresscity <> (TYPEOF(h.firmlocationaddresscity))'');
    populated_firmlocationaddresscity_pcnt := AVE(GROUP,IF(h.firmlocationaddresscity = (TYPEOF(h.firmlocationaddresscity))'',0,100));
    maxlength_firmlocationaddresscity := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.firmlocationaddresscity)));
    avelength_firmlocationaddresscity := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.firmlocationaddresscity)),h.firmlocationaddresscity<>(typeof(h.firmlocationaddresscity))'');
    populated_firmlocationaddresszip4_cnt := COUNT(GROUP,h.firmlocationaddresszip4 <> (TYPEOF(h.firmlocationaddresszip4))'');
    populated_firmlocationaddresszip4_pcnt := AVE(GROUP,IF(h.firmlocationaddresszip4 = (TYPEOF(h.firmlocationaddresszip4))'',0,100));
    maxlength_firmlocationaddresszip4 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.firmlocationaddresszip4)));
    avelength_firmlocationaddresszip4 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.firmlocationaddresszip4)),h.firmlocationaddresszip4<>(typeof(h.firmlocationaddresszip4))'');
    populated_firmlocationaddresszipcode_cnt := COUNT(GROUP,h.firmlocationaddresszipcode <> (TYPEOF(h.firmlocationaddresszipcode))'');
    populated_firmlocationaddresszipcode_pcnt := AVE(GROUP,IF(h.firmlocationaddresszipcode = (TYPEOF(h.firmlocationaddresszipcode))'',0,100));
    maxlength_firmlocationaddresszipcode := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.firmlocationaddresszipcode)));
    avelength_firmlocationaddresszipcode := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.firmlocationaddresszipcode)),h.firmlocationaddresszipcode<>(typeof(h.firmlocationaddresszipcode))'');
    populated_firmlocationcounty_cnt := COUNT(GROUP,h.firmlocationcounty <> (TYPEOF(h.firmlocationcounty))'');
    populated_firmlocationcounty_pcnt := AVE(GROUP,IF(h.firmlocationcounty = (TYPEOF(h.firmlocationcounty))'',0,100));
    maxlength_firmlocationcounty := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.firmlocationcounty)));
    avelength_firmlocationcounty := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.firmlocationcounty)),h.firmlocationcounty<>(typeof(h.firmlocationcounty))'');
    populated_firmlocationstate_cnt := COUNT(GROUP,h.firmlocationstate <> (TYPEOF(h.firmlocationstate))'');
    populated_firmlocationstate_pcnt := AVE(GROUP,IF(h.firmlocationstate = (TYPEOF(h.firmlocationstate))'',0,100));
    maxlength_firmlocationstate := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.firmlocationstate)));
    avelength_firmlocationstate := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.firmlocationstate)),h.firmlocationstate<>(typeof(h.firmlocationstate))'');
    populated_certfed_cnt := COUNT(GROUP,h.certfed <> (TYPEOF(h.certfed))'');
    populated_certfed_pcnt := AVE(GROUP,IF(h.certfed = (TYPEOF(h.certfed))'',0,100));
    maxlength_certfed := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.certfed)));
    avelength_certfed := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.certfed)),h.certfed<>(typeof(h.certfed))'');
    populated_certstate_cnt := COUNT(GROUP,h.certstate <> (TYPEOF(h.certstate))'');
    populated_certstate_pcnt := AVE(GROUP,IF(h.certstate = (TYPEOF(h.certstate))'',0,100));
    maxlength_certstate := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.certstate)));
    avelength_certstate := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.certstate)),h.certstate<>(typeof(h.certstate))'');
    populated_contractsfederal_cnt := COUNT(GROUP,h.contractsfederal <> (TYPEOF(h.contractsfederal))'');
    populated_contractsfederal_pcnt := AVE(GROUP,IF(h.contractsfederal = (TYPEOF(h.contractsfederal))'',0,100));
    maxlength_contractsfederal := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.contractsfederal)));
    avelength_contractsfederal := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.contractsfederal)),h.contractsfederal<>(typeof(h.contractsfederal))'');
    populated_contractsva_cnt := COUNT(GROUP,h.contractsva <> (TYPEOF(h.contractsva))'');
    populated_contractsva_pcnt := AVE(GROUP,IF(h.contractsva = (TYPEOF(h.contractsva))'',0,100));
    maxlength_contractsva := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.contractsva)));
    avelength_contractsva := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.contractsva)),h.contractsva<>(typeof(h.contractsva))'');
    populated_contractscommercial_cnt := COUNT(GROUP,h.contractscommercial <> (TYPEOF(h.contractscommercial))'');
    populated_contractscommercial_pcnt := AVE(GROUP,IF(h.contractscommercial = (TYPEOF(h.contractscommercial))'',0,100));
    maxlength_contractscommercial := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.contractscommercial)));
    avelength_contractscommercial := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.contractscommercial)),h.contractscommercial<>(typeof(h.contractscommercial))'');
    populated_contractorgovernmentprime_cnt := COUNT(GROUP,h.contractorgovernmentprime <> (TYPEOF(h.contractorgovernmentprime))'');
    populated_contractorgovernmentprime_pcnt := AVE(GROUP,IF(h.contractorgovernmentprime = (TYPEOF(h.contractorgovernmentprime))'',0,100));
    maxlength_contractorgovernmentprime := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.contractorgovernmentprime)));
    avelength_contractorgovernmentprime := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.contractorgovernmentprime)),h.contractorgovernmentprime<>(typeof(h.contractorgovernmentprime))'');
    populated_contractorgovernmentsub_cnt := COUNT(GROUP,h.contractorgovernmentsub <> (TYPEOF(h.contractorgovernmentsub))'');
    populated_contractorgovernmentsub_pcnt := AVE(GROUP,IF(h.contractorgovernmentsub = (TYPEOF(h.contractorgovernmentsub))'',0,100));
    maxlength_contractorgovernmentsub := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.contractorgovernmentsub)));
    avelength_contractorgovernmentsub := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.contractorgovernmentsub)),h.contractorgovernmentsub<>(typeof(h.contractorgovernmentsub))'');
    populated_contractornongovernment_cnt := COUNT(GROUP,h.contractornongovernment <> (TYPEOF(h.contractornongovernment))'');
    populated_contractornongovernment_pcnt := AVE(GROUP,IF(h.contractornongovernment = (TYPEOF(h.contractornongovernment))'',0,100));
    maxlength_contractornongovernment := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.contractornongovernment)));
    avelength_contractornongovernment := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.contractornongovernment)),h.contractornongovernment<>(typeof(h.contractornongovernment))'');
    populated_registeredgovernmentbus_cnt := COUNT(GROUP,h.registeredgovernmentbus <> (TYPEOF(h.registeredgovernmentbus))'');
    populated_registeredgovernmentbus_pcnt := AVE(GROUP,IF(h.registeredgovernmentbus = (TYPEOF(h.registeredgovernmentbus))'',0,100));
    maxlength_registeredgovernmentbus := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.registeredgovernmentbus)));
    avelength_registeredgovernmentbus := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.registeredgovernmentbus)),h.registeredgovernmentbus<>(typeof(h.registeredgovernmentbus))'');
    populated_registerednongovernmentbus_cnt := COUNT(GROUP,h.registerednongovernmentbus <> (TYPEOF(h.registerednongovernmentbus))'');
    populated_registerednongovernmentbus_pcnt := AVE(GROUP,IF(h.registerednongovernmentbus = (TYPEOF(h.registerednongovernmentbus))'',0,100));
    maxlength_registerednongovernmentbus := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.registerednongovernmentbus)));
    avelength_registerednongovernmentbus := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.registerednongovernmentbus)),h.registerednongovernmentbus<>(typeof(h.registerednongovernmentbus))'');
    populated_clearancelevelpersonnel_cnt := COUNT(GROUP,h.clearancelevelpersonnel <> (TYPEOF(h.clearancelevelpersonnel))'');
    populated_clearancelevelpersonnel_pcnt := AVE(GROUP,IF(h.clearancelevelpersonnel = (TYPEOF(h.clearancelevelpersonnel))'',0,100));
    maxlength_clearancelevelpersonnel := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.clearancelevelpersonnel)));
    avelength_clearancelevelpersonnel := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.clearancelevelpersonnel)),h.clearancelevelpersonnel<>(typeof(h.clearancelevelpersonnel))'');
    populated_clearancelevelfacility_cnt := COUNT(GROUP,h.clearancelevelfacility <> (TYPEOF(h.clearancelevelfacility))'');
    populated_clearancelevelfacility_pcnt := AVE(GROUP,IF(h.clearancelevelfacility = (TYPEOF(h.clearancelevelfacility))'',0,100));
    maxlength_clearancelevelfacility := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.clearancelevelfacility)));
    avelength_clearancelevelfacility := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.clearancelevelfacility)),h.clearancelevelfacility<>(typeof(h.clearancelevelfacility))'');
    populated_certificatedatefrom1_cnt := COUNT(GROUP,h.certificatedatefrom1 <> (TYPEOF(h.certificatedatefrom1))'');
    populated_certificatedatefrom1_pcnt := AVE(GROUP,IF(h.certificatedatefrom1 = (TYPEOF(h.certificatedatefrom1))'',0,100));
    maxlength_certificatedatefrom1 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.certificatedatefrom1)));
    avelength_certificatedatefrom1 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.certificatedatefrom1)),h.certificatedatefrom1<>(typeof(h.certificatedatefrom1))'');
    populated_certificatedateto1_cnt := COUNT(GROUP,h.certificatedateto1 <> (TYPEOF(h.certificatedateto1))'');
    populated_certificatedateto1_pcnt := AVE(GROUP,IF(h.certificatedateto1 = (TYPEOF(h.certificatedateto1))'',0,100));
    maxlength_certificatedateto1 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.certificatedateto1)));
    avelength_certificatedateto1 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.certificatedateto1)),h.certificatedateto1<>(typeof(h.certificatedateto1))'');
    populated_certificatestatus1_cnt := COUNT(GROUP,h.certificatestatus1 <> (TYPEOF(h.certificatestatus1))'');
    populated_certificatestatus1_pcnt := AVE(GROUP,IF(h.certificatestatus1 = (TYPEOF(h.certificatestatus1))'',0,100));
    maxlength_certificatestatus1 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.certificatestatus1)));
    avelength_certificatestatus1 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.certificatestatus1)),h.certificatestatus1<>(typeof(h.certificatestatus1))'');
    populated_certificationnumber1_cnt := COUNT(GROUP,h.certificationnumber1 <> (TYPEOF(h.certificationnumber1))'');
    populated_certificationnumber1_pcnt := AVE(GROUP,IF(h.certificationnumber1 = (TYPEOF(h.certificationnumber1))'',0,100));
    maxlength_certificationnumber1 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.certificationnumber1)));
    avelength_certificationnumber1 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.certificationnumber1)),h.certificationnumber1<>(typeof(h.certificationnumber1))'');
    populated_certificationtype1_cnt := COUNT(GROUP,h.certificationtype1 <> (TYPEOF(h.certificationtype1))'');
    populated_certificationtype1_pcnt := AVE(GROUP,IF(h.certificationtype1 = (TYPEOF(h.certificationtype1))'',0,100));
    maxlength_certificationtype1 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.certificationtype1)));
    avelength_certificationtype1 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.certificationtype1)),h.certificationtype1<>(typeof(h.certificationtype1))'');
    populated_certificatedatefrom2_cnt := COUNT(GROUP,h.certificatedatefrom2 <> (TYPEOF(h.certificatedatefrom2))'');
    populated_certificatedatefrom2_pcnt := AVE(GROUP,IF(h.certificatedatefrom2 = (TYPEOF(h.certificatedatefrom2))'',0,100));
    maxlength_certificatedatefrom2 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.certificatedatefrom2)));
    avelength_certificatedatefrom2 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.certificatedatefrom2)),h.certificatedatefrom2<>(typeof(h.certificatedatefrom2))'');
    populated_certificatedateto2_cnt := COUNT(GROUP,h.certificatedateto2 <> (TYPEOF(h.certificatedateto2))'');
    populated_certificatedateto2_pcnt := AVE(GROUP,IF(h.certificatedateto2 = (TYPEOF(h.certificatedateto2))'',0,100));
    maxlength_certificatedateto2 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.certificatedateto2)));
    avelength_certificatedateto2 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.certificatedateto2)),h.certificatedateto2<>(typeof(h.certificatedateto2))'');
    populated_certificatestatus2_cnt := COUNT(GROUP,h.certificatestatus2 <> (TYPEOF(h.certificatestatus2))'');
    populated_certificatestatus2_pcnt := AVE(GROUP,IF(h.certificatestatus2 = (TYPEOF(h.certificatestatus2))'',0,100));
    maxlength_certificatestatus2 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.certificatestatus2)));
    avelength_certificatestatus2 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.certificatestatus2)),h.certificatestatus2<>(typeof(h.certificatestatus2))'');
    populated_certificationnumber2_cnt := COUNT(GROUP,h.certificationnumber2 <> (TYPEOF(h.certificationnumber2))'');
    populated_certificationnumber2_pcnt := AVE(GROUP,IF(h.certificationnumber2 = (TYPEOF(h.certificationnumber2))'',0,100));
    maxlength_certificationnumber2 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.certificationnumber2)));
    avelength_certificationnumber2 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.certificationnumber2)),h.certificationnumber2<>(typeof(h.certificationnumber2))'');
    populated_certificationtype2_cnt := COUNT(GROUP,h.certificationtype2 <> (TYPEOF(h.certificationtype2))'');
    populated_certificationtype2_pcnt := AVE(GROUP,IF(h.certificationtype2 = (TYPEOF(h.certificationtype2))'',0,100));
    maxlength_certificationtype2 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.certificationtype2)));
    avelength_certificationtype2 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.certificationtype2)),h.certificationtype2<>(typeof(h.certificationtype2))'');
    populated_certificatedatefrom3_cnt := COUNT(GROUP,h.certificatedatefrom3 <> (TYPEOF(h.certificatedatefrom3))'');
    populated_certificatedatefrom3_pcnt := AVE(GROUP,IF(h.certificatedatefrom3 = (TYPEOF(h.certificatedatefrom3))'',0,100));
    maxlength_certificatedatefrom3 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.certificatedatefrom3)));
    avelength_certificatedatefrom3 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.certificatedatefrom3)),h.certificatedatefrom3<>(typeof(h.certificatedatefrom3))'');
    populated_certificatedateto3_cnt := COUNT(GROUP,h.certificatedateto3 <> (TYPEOF(h.certificatedateto3))'');
    populated_certificatedateto3_pcnt := AVE(GROUP,IF(h.certificatedateto3 = (TYPEOF(h.certificatedateto3))'',0,100));
    maxlength_certificatedateto3 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.certificatedateto3)));
    avelength_certificatedateto3 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.certificatedateto3)),h.certificatedateto3<>(typeof(h.certificatedateto3))'');
    populated_certificatestatus3_cnt := COUNT(GROUP,h.certificatestatus3 <> (TYPEOF(h.certificatestatus3))'');
    populated_certificatestatus3_pcnt := AVE(GROUP,IF(h.certificatestatus3 = (TYPEOF(h.certificatestatus3))'',0,100));
    maxlength_certificatestatus3 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.certificatestatus3)));
    avelength_certificatestatus3 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.certificatestatus3)),h.certificatestatus3<>(typeof(h.certificatestatus3))'');
    populated_certificationnumber3_cnt := COUNT(GROUP,h.certificationnumber3 <> (TYPEOF(h.certificationnumber3))'');
    populated_certificationnumber3_pcnt := AVE(GROUP,IF(h.certificationnumber3 = (TYPEOF(h.certificationnumber3))'',0,100));
    maxlength_certificationnumber3 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.certificationnumber3)));
    avelength_certificationnumber3 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.certificationnumber3)),h.certificationnumber3<>(typeof(h.certificationnumber3))'');
    populated_certificationtype3_cnt := COUNT(GROUP,h.certificationtype3 <> (TYPEOF(h.certificationtype3))'');
    populated_certificationtype3_pcnt := AVE(GROUP,IF(h.certificationtype3 = (TYPEOF(h.certificationtype3))'',0,100));
    maxlength_certificationtype3 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.certificationtype3)));
    avelength_certificationtype3 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.certificationtype3)),h.certificationtype3<>(typeof(h.certificationtype3))'');
    populated_certificatedatefrom4_cnt := COUNT(GROUP,h.certificatedatefrom4 <> (TYPEOF(h.certificatedatefrom4))'');
    populated_certificatedatefrom4_pcnt := AVE(GROUP,IF(h.certificatedatefrom4 = (TYPEOF(h.certificatedatefrom4))'',0,100));
    maxlength_certificatedatefrom4 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.certificatedatefrom4)));
    avelength_certificatedatefrom4 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.certificatedatefrom4)),h.certificatedatefrom4<>(typeof(h.certificatedatefrom4))'');
    populated_certificatedateto4_cnt := COUNT(GROUP,h.certificatedateto4 <> (TYPEOF(h.certificatedateto4))'');
    populated_certificatedateto4_pcnt := AVE(GROUP,IF(h.certificatedateto4 = (TYPEOF(h.certificatedateto4))'',0,100));
    maxlength_certificatedateto4 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.certificatedateto4)));
    avelength_certificatedateto4 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.certificatedateto4)),h.certificatedateto4<>(typeof(h.certificatedateto4))'');
    populated_certificatestatus4_cnt := COUNT(GROUP,h.certificatestatus4 <> (TYPEOF(h.certificatestatus4))'');
    populated_certificatestatus4_pcnt := AVE(GROUP,IF(h.certificatestatus4 = (TYPEOF(h.certificatestatus4))'',0,100));
    maxlength_certificatestatus4 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.certificatestatus4)));
    avelength_certificatestatus4 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.certificatestatus4)),h.certificatestatus4<>(typeof(h.certificatestatus4))'');
    populated_certificationnumber4_cnt := COUNT(GROUP,h.certificationnumber4 <> (TYPEOF(h.certificationnumber4))'');
    populated_certificationnumber4_pcnt := AVE(GROUP,IF(h.certificationnumber4 = (TYPEOF(h.certificationnumber4))'',0,100));
    maxlength_certificationnumber4 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.certificationnumber4)));
    avelength_certificationnumber4 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.certificationnumber4)),h.certificationnumber4<>(typeof(h.certificationnumber4))'');
    populated_certificationtype4_cnt := COUNT(GROUP,h.certificationtype4 <> (TYPEOF(h.certificationtype4))'');
    populated_certificationtype4_pcnt := AVE(GROUP,IF(h.certificationtype4 = (TYPEOF(h.certificationtype4))'',0,100));
    maxlength_certificationtype4 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.certificationtype4)));
    avelength_certificationtype4 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.certificationtype4)),h.certificationtype4<>(typeof(h.certificationtype4))'');
    populated_certificatedatefrom5_cnt := COUNT(GROUP,h.certificatedatefrom5 <> (TYPEOF(h.certificatedatefrom5))'');
    populated_certificatedatefrom5_pcnt := AVE(GROUP,IF(h.certificatedatefrom5 = (TYPEOF(h.certificatedatefrom5))'',0,100));
    maxlength_certificatedatefrom5 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.certificatedatefrom5)));
    avelength_certificatedatefrom5 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.certificatedatefrom5)),h.certificatedatefrom5<>(typeof(h.certificatedatefrom5))'');
    populated_certificatedateto5_cnt := COUNT(GROUP,h.certificatedateto5 <> (TYPEOF(h.certificatedateto5))'');
    populated_certificatedateto5_pcnt := AVE(GROUP,IF(h.certificatedateto5 = (TYPEOF(h.certificatedateto5))'',0,100));
    maxlength_certificatedateto5 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.certificatedateto5)));
    avelength_certificatedateto5 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.certificatedateto5)),h.certificatedateto5<>(typeof(h.certificatedateto5))'');
    populated_certificatestatus5_cnt := COUNT(GROUP,h.certificatestatus5 <> (TYPEOF(h.certificatestatus5))'');
    populated_certificatestatus5_pcnt := AVE(GROUP,IF(h.certificatestatus5 = (TYPEOF(h.certificatestatus5))'',0,100));
    maxlength_certificatestatus5 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.certificatestatus5)));
    avelength_certificatestatus5 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.certificatestatus5)),h.certificatestatus5<>(typeof(h.certificatestatus5))'');
    populated_certificationnumber5_cnt := COUNT(GROUP,h.certificationnumber5 <> (TYPEOF(h.certificationnumber5))'');
    populated_certificationnumber5_pcnt := AVE(GROUP,IF(h.certificationnumber5 = (TYPEOF(h.certificationnumber5))'',0,100));
    maxlength_certificationnumber5 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.certificationnumber5)));
    avelength_certificationnumber5 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.certificationnumber5)),h.certificationnumber5<>(typeof(h.certificationnumber5))'');
    populated_certificationtype5_cnt := COUNT(GROUP,h.certificationtype5 <> (TYPEOF(h.certificationtype5))'');
    populated_certificationtype5_pcnt := AVE(GROUP,IF(h.certificationtype5 = (TYPEOF(h.certificationtype5))'',0,100));
    maxlength_certificationtype5 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.certificationtype5)));
    avelength_certificationtype5 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.certificationtype5)),h.certificationtype5<>(typeof(h.certificationtype5))'');
    populated_certificatedatefrom6_cnt := COUNT(GROUP,h.certificatedatefrom6 <> (TYPEOF(h.certificatedatefrom6))'');
    populated_certificatedatefrom6_pcnt := AVE(GROUP,IF(h.certificatedatefrom6 = (TYPEOF(h.certificatedatefrom6))'',0,100));
    maxlength_certificatedatefrom6 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.certificatedatefrom6)));
    avelength_certificatedatefrom6 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.certificatedatefrom6)),h.certificatedatefrom6<>(typeof(h.certificatedatefrom6))'');
    populated_certificatedateto6_cnt := COUNT(GROUP,h.certificatedateto6 <> (TYPEOF(h.certificatedateto6))'');
    populated_certificatedateto6_pcnt := AVE(GROUP,IF(h.certificatedateto6 = (TYPEOF(h.certificatedateto6))'',0,100));
    maxlength_certificatedateto6 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.certificatedateto6)));
    avelength_certificatedateto6 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.certificatedateto6)),h.certificatedateto6<>(typeof(h.certificatedateto6))'');
    populated_certificatestatus6_cnt := COUNT(GROUP,h.certificatestatus6 <> (TYPEOF(h.certificatestatus6))'');
    populated_certificatestatus6_pcnt := AVE(GROUP,IF(h.certificatestatus6 = (TYPEOF(h.certificatestatus6))'',0,100));
    maxlength_certificatestatus6 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.certificatestatus6)));
    avelength_certificatestatus6 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.certificatestatus6)),h.certificatestatus6<>(typeof(h.certificatestatus6))'');
    populated_certificationnumber6_cnt := COUNT(GROUP,h.certificationnumber6 <> (TYPEOF(h.certificationnumber6))'');
    populated_certificationnumber6_pcnt := AVE(GROUP,IF(h.certificationnumber6 = (TYPEOF(h.certificationnumber6))'',0,100));
    maxlength_certificationnumber6 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.certificationnumber6)));
    avelength_certificationnumber6 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.certificationnumber6)),h.certificationnumber6<>(typeof(h.certificationnumber6))'');
    populated_certificationtype6_cnt := COUNT(GROUP,h.certificationtype6 <> (TYPEOF(h.certificationtype6))'');
    populated_certificationtype6_pcnt := AVE(GROUP,IF(h.certificationtype6 = (TYPEOF(h.certificationtype6))'',0,100));
    maxlength_certificationtype6 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.certificationtype6)));
    avelength_certificationtype6 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.certificationtype6)),h.certificationtype6<>(typeof(h.certificationtype6))'');
    populated_starrating_cnt := COUNT(GROUP,h.starrating <> (TYPEOF(h.starrating))'');
    populated_starrating_pcnt := AVE(GROUP,IF(h.starrating = (TYPEOF(h.starrating))'',0,100));
    maxlength_starrating := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.starrating)));
    avelength_starrating := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.starrating)),h.starrating<>(typeof(h.starrating))'');
    populated_assets_cnt := COUNT(GROUP,h.assets <> (TYPEOF(h.assets))'');
    populated_assets_pcnt := AVE(GROUP,IF(h.assets = (TYPEOF(h.assets))'',0,100));
    maxlength_assets := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.assets)));
    avelength_assets := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.assets)),h.assets<>(typeof(h.assets))'');
    populated_biddescription_cnt := COUNT(GROUP,h.biddescription <> (TYPEOF(h.biddescription))'');
    populated_biddescription_pcnt := AVE(GROUP,IF(h.biddescription = (TYPEOF(h.biddescription))'',0,100));
    maxlength_biddescription := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.biddescription)));
    avelength_biddescription := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.biddescription)),h.biddescription<>(typeof(h.biddescription))'');
    populated_competitiveadvantage_cnt := COUNT(GROUP,h.competitiveadvantage <> (TYPEOF(h.competitiveadvantage))'');
    populated_competitiveadvantage_pcnt := AVE(GROUP,IF(h.competitiveadvantage = (TYPEOF(h.competitiveadvantage))'',0,100));
    maxlength_competitiveadvantage := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.competitiveadvantage)));
    avelength_competitiveadvantage := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.competitiveadvantage)),h.competitiveadvantage<>(typeof(h.competitiveadvantage))'');
    populated_cagecode_cnt := COUNT(GROUP,h.cagecode <> (TYPEOF(h.cagecode))'');
    populated_cagecode_pcnt := AVE(GROUP,IF(h.cagecode = (TYPEOF(h.cagecode))'',0,100));
    maxlength_cagecode := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.cagecode)));
    avelength_cagecode := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.cagecode)),h.cagecode<>(typeof(h.cagecode))'');
    populated_capabilitiesnarrative_cnt := COUNT(GROUP,h.capabilitiesnarrative <> (TYPEOF(h.capabilitiesnarrative))'');
    populated_capabilitiesnarrative_pcnt := AVE(GROUP,IF(h.capabilitiesnarrative = (TYPEOF(h.capabilitiesnarrative))'',0,100));
    maxlength_capabilitiesnarrative := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.capabilitiesnarrative)));
    avelength_capabilitiesnarrative := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.capabilitiesnarrative)),h.capabilitiesnarrative<>(typeof(h.capabilitiesnarrative))'');
    populated_category_cnt := COUNT(GROUP,h.category <> (TYPEOF(h.category))'');
    populated_category_pcnt := AVE(GROUP,IF(h.category = (TYPEOF(h.category))'',0,100));
    maxlength_category := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.category)));
    avelength_category := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.category)),h.category<>(typeof(h.category))'');
    populated_chtrclass_cnt := COUNT(GROUP,h.chtrclass <> (TYPEOF(h.chtrclass))'');
    populated_chtrclass_pcnt := AVE(GROUP,IF(h.chtrclass = (TYPEOF(h.chtrclass))'',0,100));
    maxlength_chtrclass := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.chtrclass)));
    avelength_chtrclass := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.chtrclass)),h.chtrclass<>(typeof(h.chtrclass))'');
    populated_productdescription1_cnt := COUNT(GROUP,h.productdescription1 <> (TYPEOF(h.productdescription1))'');
    populated_productdescription1_pcnt := AVE(GROUP,IF(h.productdescription1 = (TYPEOF(h.productdescription1))'',0,100));
    maxlength_productdescription1 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.productdescription1)));
    avelength_productdescription1 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.productdescription1)),h.productdescription1<>(typeof(h.productdescription1))'');
    populated_productdescription2_cnt := COUNT(GROUP,h.productdescription2 <> (TYPEOF(h.productdescription2))'');
    populated_productdescription2_pcnt := AVE(GROUP,IF(h.productdescription2 = (TYPEOF(h.productdescription2))'',0,100));
    maxlength_productdescription2 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.productdescription2)));
    avelength_productdescription2 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.productdescription2)),h.productdescription2<>(typeof(h.productdescription2))'');
    populated_productdescription3_cnt := COUNT(GROUP,h.productdescription3 <> (TYPEOF(h.productdescription3))'');
    populated_productdescription3_pcnt := AVE(GROUP,IF(h.productdescription3 = (TYPEOF(h.productdescription3))'',0,100));
    maxlength_productdescription3 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.productdescription3)));
    avelength_productdescription3 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.productdescription3)),h.productdescription3<>(typeof(h.productdescription3))'');
    populated_productdescription4_cnt := COUNT(GROUP,h.productdescription4 <> (TYPEOF(h.productdescription4))'');
    populated_productdescription4_pcnt := AVE(GROUP,IF(h.productdescription4 = (TYPEOF(h.productdescription4))'',0,100));
    maxlength_productdescription4 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.productdescription4)));
    avelength_productdescription4 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.productdescription4)),h.productdescription4<>(typeof(h.productdescription4))'');
    populated_productdescription5_cnt := COUNT(GROUP,h.productdescription5 <> (TYPEOF(h.productdescription5))'');
    populated_productdescription5_pcnt := AVE(GROUP,IF(h.productdescription5 = (TYPEOF(h.productdescription5))'',0,100));
    maxlength_productdescription5 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.productdescription5)));
    avelength_productdescription5 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.productdescription5)),h.productdescription5<>(typeof(h.productdescription5))'');
    populated_classdescription1_cnt := COUNT(GROUP,h.classdescription1 <> (TYPEOF(h.classdescription1))'');
    populated_classdescription1_pcnt := AVE(GROUP,IF(h.classdescription1 = (TYPEOF(h.classdescription1))'',0,100));
    maxlength_classdescription1 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.classdescription1)));
    avelength_classdescription1 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.classdescription1)),h.classdescription1<>(typeof(h.classdescription1))'');
    populated_subclassdescription1_cnt := COUNT(GROUP,h.subclassdescription1 <> (TYPEOF(h.subclassdescription1))'');
    populated_subclassdescription1_pcnt := AVE(GROUP,IF(h.subclassdescription1 = (TYPEOF(h.subclassdescription1))'',0,100));
    maxlength_subclassdescription1 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.subclassdescription1)));
    avelength_subclassdescription1 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.subclassdescription1)),h.subclassdescription1<>(typeof(h.subclassdescription1))'');
    populated_classdescription2_cnt := COUNT(GROUP,h.classdescription2 <> (TYPEOF(h.classdescription2))'');
    populated_classdescription2_pcnt := AVE(GROUP,IF(h.classdescription2 = (TYPEOF(h.classdescription2))'',0,100));
    maxlength_classdescription2 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.classdescription2)));
    avelength_classdescription2 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.classdescription2)),h.classdescription2<>(typeof(h.classdescription2))'');
    populated_subclassdescription2_cnt := COUNT(GROUP,h.subclassdescription2 <> (TYPEOF(h.subclassdescription2))'');
    populated_subclassdescription2_pcnt := AVE(GROUP,IF(h.subclassdescription2 = (TYPEOF(h.subclassdescription2))'',0,100));
    maxlength_subclassdescription2 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.subclassdescription2)));
    avelength_subclassdescription2 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.subclassdescription2)),h.subclassdescription2<>(typeof(h.subclassdescription2))'');
    populated_classdescription3_cnt := COUNT(GROUP,h.classdescription3 <> (TYPEOF(h.classdescription3))'');
    populated_classdescription3_pcnt := AVE(GROUP,IF(h.classdescription3 = (TYPEOF(h.classdescription3))'',0,100));
    maxlength_classdescription3 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.classdescription3)));
    avelength_classdescription3 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.classdescription3)),h.classdescription3<>(typeof(h.classdescription3))'');
    populated_subclassdescription3_cnt := COUNT(GROUP,h.subclassdescription3 <> (TYPEOF(h.subclassdescription3))'');
    populated_subclassdescription3_pcnt := AVE(GROUP,IF(h.subclassdescription3 = (TYPEOF(h.subclassdescription3))'',0,100));
    maxlength_subclassdescription3 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.subclassdescription3)));
    avelength_subclassdescription3 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.subclassdescription3)),h.subclassdescription3<>(typeof(h.subclassdescription3))'');
    populated_classdescription4_cnt := COUNT(GROUP,h.classdescription4 <> (TYPEOF(h.classdescription4))'');
    populated_classdescription4_pcnt := AVE(GROUP,IF(h.classdescription4 = (TYPEOF(h.classdescription4))'',0,100));
    maxlength_classdescription4 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.classdescription4)));
    avelength_classdescription4 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.classdescription4)),h.classdescription4<>(typeof(h.classdescription4))'');
    populated_subclassdescription4_cnt := COUNT(GROUP,h.subclassdescription4 <> (TYPEOF(h.subclassdescription4))'');
    populated_subclassdescription4_pcnt := AVE(GROUP,IF(h.subclassdescription4 = (TYPEOF(h.subclassdescription4))'',0,100));
    maxlength_subclassdescription4 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.subclassdescription4)));
    avelength_subclassdescription4 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.subclassdescription4)),h.subclassdescription4<>(typeof(h.subclassdescription4))'');
    populated_classdescription5_cnt := COUNT(GROUP,h.classdescription5 <> (TYPEOF(h.classdescription5))'');
    populated_classdescription5_pcnt := AVE(GROUP,IF(h.classdescription5 = (TYPEOF(h.classdescription5))'',0,100));
    maxlength_classdescription5 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.classdescription5)));
    avelength_classdescription5 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.classdescription5)),h.classdescription5<>(typeof(h.classdescription5))'');
    populated_subclassdescription5_cnt := COUNT(GROUP,h.subclassdescription5 <> (TYPEOF(h.subclassdescription5))'');
    populated_subclassdescription5_pcnt := AVE(GROUP,IF(h.subclassdescription5 = (TYPEOF(h.subclassdescription5))'',0,100));
    maxlength_subclassdescription5 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.subclassdescription5)));
    avelength_subclassdescription5 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.subclassdescription5)),h.subclassdescription5<>(typeof(h.subclassdescription5))'');
    populated_classifications_cnt := COUNT(GROUP,h.classifications <> (TYPEOF(h.classifications))'');
    populated_classifications_pcnt := AVE(GROUP,IF(h.classifications = (TYPEOF(h.classifications))'',0,100));
    maxlength_classifications := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.classifications)));
    avelength_classifications := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.classifications)),h.classifications<>(typeof(h.classifications))'');
    populated_commodity1_cnt := COUNT(GROUP,h.commodity1 <> (TYPEOF(h.commodity1))'');
    populated_commodity1_pcnt := AVE(GROUP,IF(h.commodity1 = (TYPEOF(h.commodity1))'',0,100));
    maxlength_commodity1 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.commodity1)));
    avelength_commodity1 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.commodity1)),h.commodity1<>(typeof(h.commodity1))'');
    populated_commodity2_cnt := COUNT(GROUP,h.commodity2 <> (TYPEOF(h.commodity2))'');
    populated_commodity2_pcnt := AVE(GROUP,IF(h.commodity2 = (TYPEOF(h.commodity2))'',0,100));
    maxlength_commodity2 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.commodity2)));
    avelength_commodity2 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.commodity2)),h.commodity2<>(typeof(h.commodity2))'');
    populated_commodity3_cnt := COUNT(GROUP,h.commodity3 <> (TYPEOF(h.commodity3))'');
    populated_commodity3_pcnt := AVE(GROUP,IF(h.commodity3 = (TYPEOF(h.commodity3))'',0,100));
    maxlength_commodity3 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.commodity3)));
    avelength_commodity3 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.commodity3)),h.commodity3<>(typeof(h.commodity3))'');
    populated_commodity4_cnt := COUNT(GROUP,h.commodity4 <> (TYPEOF(h.commodity4))'');
    populated_commodity4_pcnt := AVE(GROUP,IF(h.commodity4 = (TYPEOF(h.commodity4))'',0,100));
    maxlength_commodity4 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.commodity4)));
    avelength_commodity4 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.commodity4)),h.commodity4<>(typeof(h.commodity4))'');
    populated_commodity5_cnt := COUNT(GROUP,h.commodity5 <> (TYPEOF(h.commodity5))'');
    populated_commodity5_pcnt := AVE(GROUP,IF(h.commodity5 = (TYPEOF(h.commodity5))'',0,100));
    maxlength_commodity5 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.commodity5)));
    avelength_commodity5 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.commodity5)),h.commodity5<>(typeof(h.commodity5))'');
    populated_commodity6_cnt := COUNT(GROUP,h.commodity6 <> (TYPEOF(h.commodity6))'');
    populated_commodity6_pcnt := AVE(GROUP,IF(h.commodity6 = (TYPEOF(h.commodity6))'',0,100));
    maxlength_commodity6 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.commodity6)));
    avelength_commodity6 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.commodity6)),h.commodity6<>(typeof(h.commodity6))'');
    populated_commodity7_cnt := COUNT(GROUP,h.commodity7 <> (TYPEOF(h.commodity7))'');
    populated_commodity7_pcnt := AVE(GROUP,IF(h.commodity7 = (TYPEOF(h.commodity7))'',0,100));
    maxlength_commodity7 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.commodity7)));
    avelength_commodity7 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.commodity7)),h.commodity7<>(typeof(h.commodity7))'');
    populated_commodity8_cnt := COUNT(GROUP,h.commodity8 <> (TYPEOF(h.commodity8))'');
    populated_commodity8_pcnt := AVE(GROUP,IF(h.commodity8 = (TYPEOF(h.commodity8))'',0,100));
    maxlength_commodity8 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.commodity8)));
    avelength_commodity8 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.commodity8)),h.commodity8<>(typeof(h.commodity8))'');
    populated_completedate_cnt := COUNT(GROUP,h.completedate <> (TYPEOF(h.completedate))'');
    populated_completedate_pcnt := AVE(GROUP,IF(h.completedate = (TYPEOF(h.completedate))'',0,100));
    maxlength_completedate := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.completedate)));
    avelength_completedate := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.completedate)),h.completedate<>(typeof(h.completedate))'');
    populated_crossreference_cnt := COUNT(GROUP,h.crossreference <> (TYPEOF(h.crossreference))'');
    populated_crossreference_pcnt := AVE(GROUP,IF(h.crossreference = (TYPEOF(h.crossreference))'',0,100));
    maxlength_crossreference := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.crossreference)));
    avelength_crossreference := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.crossreference)),h.crossreference<>(typeof(h.crossreference))'');
    populated_dateestablished_cnt := COUNT(GROUP,h.dateestablished <> (TYPEOF(h.dateestablished))'');
    populated_dateestablished_pcnt := AVE(GROUP,IF(h.dateestablished = (TYPEOF(h.dateestablished))'',0,100));
    maxlength_dateestablished := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.dateestablished)));
    avelength_dateestablished := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.dateestablished)),h.dateestablished<>(typeof(h.dateestablished))'');
    populated_businessage_cnt := COUNT(GROUP,h.businessage <> (TYPEOF(h.businessage))'');
    populated_businessage_pcnt := AVE(GROUP,IF(h.businessage = (TYPEOF(h.businessage))'',0,100));
    maxlength_businessage := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.businessage)));
    avelength_businessage := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.businessage)),h.businessage<>(typeof(h.businessage))'');
    populated_deposits_cnt := COUNT(GROUP,h.deposits <> (TYPEOF(h.deposits))'');
    populated_deposits_pcnt := AVE(GROUP,IF(h.deposits = (TYPEOF(h.deposits))'',0,100));
    maxlength_deposits := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.deposits)));
    avelength_deposits := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.deposits)),h.deposits<>(typeof(h.deposits))'');
    populated_dunsnumber_cnt := COUNT(GROUP,h.dunsnumber <> (TYPEOF(h.dunsnumber))'');
    populated_dunsnumber_pcnt := AVE(GROUP,IF(h.dunsnumber = (TYPEOF(h.dunsnumber))'',0,100));
    maxlength_dunsnumber := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.dunsnumber)));
    avelength_dunsnumber := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.dunsnumber)),h.dunsnumber<>(typeof(h.dunsnumber))'');
    populated_enttype_cnt := COUNT(GROUP,h.enttype <> (TYPEOF(h.enttype))'');
    populated_enttype_pcnt := AVE(GROUP,IF(h.enttype = (TYPEOF(h.enttype))'',0,100));
    maxlength_enttype := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.enttype)));
    avelength_enttype := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.enttype)),h.enttype<>(typeof(h.enttype))'');
    populated_expirationdate_cnt := COUNT(GROUP,h.expirationdate <> (TYPEOF(h.expirationdate))'');
    populated_expirationdate_pcnt := AVE(GROUP,IF(h.expirationdate = (TYPEOF(h.expirationdate))'',0,100));
    maxlength_expirationdate := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.expirationdate)));
    avelength_expirationdate := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.expirationdate)),h.expirationdate<>(typeof(h.expirationdate))'');
    populated_extendeddate_cnt := COUNT(GROUP,h.extendeddate <> (TYPEOF(h.extendeddate))'');
    populated_extendeddate_pcnt := AVE(GROUP,IF(h.extendeddate = (TYPEOF(h.extendeddate))'',0,100));
    maxlength_extendeddate := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.extendeddate)));
    avelength_extendeddate := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.extendeddate)),h.extendeddate<>(typeof(h.extendeddate))'');
    populated_issuingauthority_cnt := COUNT(GROUP,h.issuingauthority <> (TYPEOF(h.issuingauthority))'');
    populated_issuingauthority_pcnt := AVE(GROUP,IF(h.issuingauthority = (TYPEOF(h.issuingauthority))'',0,100));
    maxlength_issuingauthority := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.issuingauthority)));
    avelength_issuingauthority := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.issuingauthority)),h.issuingauthority<>(typeof(h.issuingauthority))'');
    populated_keywords_cnt := COUNT(GROUP,h.keywords <> (TYPEOF(h.keywords))'');
    populated_keywords_pcnt := AVE(GROUP,IF(h.keywords = (TYPEOF(h.keywords))'',0,100));
    maxlength_keywords := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.keywords)));
    avelength_keywords := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.keywords)),h.keywords<>(typeof(h.keywords))'');
    populated_licensenumber_cnt := COUNT(GROUP,h.licensenumber <> (TYPEOF(h.licensenumber))'');
    populated_licensenumber_pcnt := AVE(GROUP,IF(h.licensenumber = (TYPEOF(h.licensenumber))'',0,100));
    maxlength_licensenumber := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.licensenumber)));
    avelength_licensenumber := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.licensenumber)),h.licensenumber<>(typeof(h.licensenumber))'');
    populated_licensetype_cnt := COUNT(GROUP,h.licensetype <> (TYPEOF(h.licensetype))'');
    populated_licensetype_pcnt := AVE(GROUP,IF(h.licensetype = (TYPEOF(h.licensetype))'',0,100));
    maxlength_licensetype := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.licensetype)));
    avelength_licensetype := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.licensetype)),h.licensetype<>(typeof(h.licensetype))'');
    populated_mincd_cnt := COUNT(GROUP,h.mincd <> (TYPEOF(h.mincd))'');
    populated_mincd_pcnt := AVE(GROUP,IF(h.mincd = (TYPEOF(h.mincd))'',0,100));
    maxlength_mincd := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.mincd)));
    avelength_mincd := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.mincd)),h.mincd<>(typeof(h.mincd))'');
    populated_minorityaffiliation_cnt := COUNT(GROUP,h.minorityaffiliation <> (TYPEOF(h.minorityaffiliation))'');
    populated_minorityaffiliation_pcnt := AVE(GROUP,IF(h.minorityaffiliation = (TYPEOF(h.minorityaffiliation))'',0,100));
    maxlength_minorityaffiliation := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.minorityaffiliation)));
    avelength_minorityaffiliation := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.minorityaffiliation)),h.minorityaffiliation<>(typeof(h.minorityaffiliation))'');
    populated_minorityownershipdate_cnt := COUNT(GROUP,h.minorityownershipdate <> (TYPEOF(h.minorityownershipdate))'');
    populated_minorityownershipdate_pcnt := AVE(GROUP,IF(h.minorityownershipdate = (TYPEOF(h.minorityownershipdate))'',0,100));
    maxlength_minorityownershipdate := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.minorityownershipdate)));
    avelength_minorityownershipdate := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.minorityownershipdate)),h.minorityownershipdate<>(typeof(h.minorityownershipdate))'');
    populated_siccode1_cnt := COUNT(GROUP,h.siccode1 <> (TYPEOF(h.siccode1))'');
    populated_siccode1_pcnt := AVE(GROUP,IF(h.siccode1 = (TYPEOF(h.siccode1))'',0,100));
    maxlength_siccode1 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.siccode1)));
    avelength_siccode1 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.siccode1)),h.siccode1<>(typeof(h.siccode1))'');
    populated_siccode2_cnt := COUNT(GROUP,h.siccode2 <> (TYPEOF(h.siccode2))'');
    populated_siccode2_pcnt := AVE(GROUP,IF(h.siccode2 = (TYPEOF(h.siccode2))'',0,100));
    maxlength_siccode2 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.siccode2)));
    avelength_siccode2 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.siccode2)),h.siccode2<>(typeof(h.siccode2))'');
    populated_siccode3_cnt := COUNT(GROUP,h.siccode3 <> (TYPEOF(h.siccode3))'');
    populated_siccode3_pcnt := AVE(GROUP,IF(h.siccode3 = (TYPEOF(h.siccode3))'',0,100));
    maxlength_siccode3 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.siccode3)));
    avelength_siccode3 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.siccode3)),h.siccode3<>(typeof(h.siccode3))'');
    populated_siccode4_cnt := COUNT(GROUP,h.siccode4 <> (TYPEOF(h.siccode4))'');
    populated_siccode4_pcnt := AVE(GROUP,IF(h.siccode4 = (TYPEOF(h.siccode4))'',0,100));
    maxlength_siccode4 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.siccode4)));
    avelength_siccode4 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.siccode4)),h.siccode4<>(typeof(h.siccode4))'');
    populated_siccode5_cnt := COUNT(GROUP,h.siccode5 <> (TYPEOF(h.siccode5))'');
    populated_siccode5_pcnt := AVE(GROUP,IF(h.siccode5 = (TYPEOF(h.siccode5))'',0,100));
    maxlength_siccode5 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.siccode5)));
    avelength_siccode5 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.siccode5)),h.siccode5<>(typeof(h.siccode5))'');
    populated_siccode6_cnt := COUNT(GROUP,h.siccode6 <> (TYPEOF(h.siccode6))'');
    populated_siccode6_pcnt := AVE(GROUP,IF(h.siccode6 = (TYPEOF(h.siccode6))'',0,100));
    maxlength_siccode6 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.siccode6)));
    avelength_siccode6 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.siccode6)),h.siccode6<>(typeof(h.siccode6))'');
    populated_siccode7_cnt := COUNT(GROUP,h.siccode7 <> (TYPEOF(h.siccode7))'');
    populated_siccode7_pcnt := AVE(GROUP,IF(h.siccode7 = (TYPEOF(h.siccode7))'',0,100));
    maxlength_siccode7 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.siccode7)));
    avelength_siccode7 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.siccode7)),h.siccode7<>(typeof(h.siccode7))'');
    populated_siccode8_cnt := COUNT(GROUP,h.siccode8 <> (TYPEOF(h.siccode8))'');
    populated_siccode8_pcnt := AVE(GROUP,IF(h.siccode8 = (TYPEOF(h.siccode8))'',0,100));
    maxlength_siccode8 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.siccode8)));
    avelength_siccode8 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.siccode8)),h.siccode8<>(typeof(h.siccode8))'');
    populated_naicscode1_cnt := COUNT(GROUP,h.naicscode1 <> (TYPEOF(h.naicscode1))'');
    populated_naicscode1_pcnt := AVE(GROUP,IF(h.naicscode1 = (TYPEOF(h.naicscode1))'',0,100));
    maxlength_naicscode1 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.naicscode1)));
    avelength_naicscode1 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.naicscode1)),h.naicscode1<>(typeof(h.naicscode1))'');
    populated_naicscode2_cnt := COUNT(GROUP,h.naicscode2 <> (TYPEOF(h.naicscode2))'');
    populated_naicscode2_pcnt := AVE(GROUP,IF(h.naicscode2 = (TYPEOF(h.naicscode2))'',0,100));
    maxlength_naicscode2 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.naicscode2)));
    avelength_naicscode2 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.naicscode2)),h.naicscode2<>(typeof(h.naicscode2))'');
    populated_naicscode3_cnt := COUNT(GROUP,h.naicscode3 <> (TYPEOF(h.naicscode3))'');
    populated_naicscode3_pcnt := AVE(GROUP,IF(h.naicscode3 = (TYPEOF(h.naicscode3))'',0,100));
    maxlength_naicscode3 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.naicscode3)));
    avelength_naicscode3 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.naicscode3)),h.naicscode3<>(typeof(h.naicscode3))'');
    populated_naicscode4_cnt := COUNT(GROUP,h.naicscode4 <> (TYPEOF(h.naicscode4))'');
    populated_naicscode4_pcnt := AVE(GROUP,IF(h.naicscode4 = (TYPEOF(h.naicscode4))'',0,100));
    maxlength_naicscode4 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.naicscode4)));
    avelength_naicscode4 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.naicscode4)),h.naicscode4<>(typeof(h.naicscode4))'');
    populated_naicscode5_cnt := COUNT(GROUP,h.naicscode5 <> (TYPEOF(h.naicscode5))'');
    populated_naicscode5_pcnt := AVE(GROUP,IF(h.naicscode5 = (TYPEOF(h.naicscode5))'',0,100));
    maxlength_naicscode5 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.naicscode5)));
    avelength_naicscode5 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.naicscode5)),h.naicscode5<>(typeof(h.naicscode5))'');
    populated_naicscode6_cnt := COUNT(GROUP,h.naicscode6 <> (TYPEOF(h.naicscode6))'');
    populated_naicscode6_pcnt := AVE(GROUP,IF(h.naicscode6 = (TYPEOF(h.naicscode6))'',0,100));
    maxlength_naicscode6 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.naicscode6)));
    avelength_naicscode6 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.naicscode6)),h.naicscode6<>(typeof(h.naicscode6))'');
    populated_naicscode7_cnt := COUNT(GROUP,h.naicscode7 <> (TYPEOF(h.naicscode7))'');
    populated_naicscode7_pcnt := AVE(GROUP,IF(h.naicscode7 = (TYPEOF(h.naicscode7))'',0,100));
    maxlength_naicscode7 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.naicscode7)));
    avelength_naicscode7 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.naicscode7)),h.naicscode7<>(typeof(h.naicscode7))'');
    populated_naicscode8_cnt := COUNT(GROUP,h.naicscode8 <> (TYPEOF(h.naicscode8))'');
    populated_naicscode8_pcnt := AVE(GROUP,IF(h.naicscode8 = (TYPEOF(h.naicscode8))'',0,100));
    maxlength_naicscode8 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.naicscode8)));
    avelength_naicscode8 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.naicscode8)),h.naicscode8<>(typeof(h.naicscode8))'');
    populated_prequalify_cnt := COUNT(GROUP,h.prequalify <> (TYPEOF(h.prequalify))'');
    populated_prequalify_pcnt := AVE(GROUP,IF(h.prequalify = (TYPEOF(h.prequalify))'',0,100));
    maxlength_prequalify := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.prequalify)));
    avelength_prequalify := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.prequalify)),h.prequalify<>(typeof(h.prequalify))'');
    populated_procurementcategory1_cnt := COUNT(GROUP,h.procurementcategory1 <> (TYPEOF(h.procurementcategory1))'');
    populated_procurementcategory1_pcnt := AVE(GROUP,IF(h.procurementcategory1 = (TYPEOF(h.procurementcategory1))'',0,100));
    maxlength_procurementcategory1 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.procurementcategory1)));
    avelength_procurementcategory1 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.procurementcategory1)),h.procurementcategory1<>(typeof(h.procurementcategory1))'');
    populated_subprocurementcategory1_cnt := COUNT(GROUP,h.subprocurementcategory1 <> (TYPEOF(h.subprocurementcategory1))'');
    populated_subprocurementcategory1_pcnt := AVE(GROUP,IF(h.subprocurementcategory1 = (TYPEOF(h.subprocurementcategory1))'',0,100));
    maxlength_subprocurementcategory1 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.subprocurementcategory1)));
    avelength_subprocurementcategory1 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.subprocurementcategory1)),h.subprocurementcategory1<>(typeof(h.subprocurementcategory1))'');
    populated_procurementcategory2_cnt := COUNT(GROUP,h.procurementcategory2 <> (TYPEOF(h.procurementcategory2))'');
    populated_procurementcategory2_pcnt := AVE(GROUP,IF(h.procurementcategory2 = (TYPEOF(h.procurementcategory2))'',0,100));
    maxlength_procurementcategory2 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.procurementcategory2)));
    avelength_procurementcategory2 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.procurementcategory2)),h.procurementcategory2<>(typeof(h.procurementcategory2))'');
    populated_subprocurementcategory2_cnt := COUNT(GROUP,h.subprocurementcategory2 <> (TYPEOF(h.subprocurementcategory2))'');
    populated_subprocurementcategory2_pcnt := AVE(GROUP,IF(h.subprocurementcategory2 = (TYPEOF(h.subprocurementcategory2))'',0,100));
    maxlength_subprocurementcategory2 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.subprocurementcategory2)));
    avelength_subprocurementcategory2 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.subprocurementcategory2)),h.subprocurementcategory2<>(typeof(h.subprocurementcategory2))'');
    populated_procurementcategory3_cnt := COUNT(GROUP,h.procurementcategory3 <> (TYPEOF(h.procurementcategory3))'');
    populated_procurementcategory3_pcnt := AVE(GROUP,IF(h.procurementcategory3 = (TYPEOF(h.procurementcategory3))'',0,100));
    maxlength_procurementcategory3 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.procurementcategory3)));
    avelength_procurementcategory3 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.procurementcategory3)),h.procurementcategory3<>(typeof(h.procurementcategory3))'');
    populated_subprocurementcategory3_cnt := COUNT(GROUP,h.subprocurementcategory3 <> (TYPEOF(h.subprocurementcategory3))'');
    populated_subprocurementcategory3_pcnt := AVE(GROUP,IF(h.subprocurementcategory3 = (TYPEOF(h.subprocurementcategory3))'',0,100));
    maxlength_subprocurementcategory3 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.subprocurementcategory3)));
    avelength_subprocurementcategory3 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.subprocurementcategory3)),h.subprocurementcategory3<>(typeof(h.subprocurementcategory3))'');
    populated_procurementcategory4_cnt := COUNT(GROUP,h.procurementcategory4 <> (TYPEOF(h.procurementcategory4))'');
    populated_procurementcategory4_pcnt := AVE(GROUP,IF(h.procurementcategory4 = (TYPEOF(h.procurementcategory4))'',0,100));
    maxlength_procurementcategory4 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.procurementcategory4)));
    avelength_procurementcategory4 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.procurementcategory4)),h.procurementcategory4<>(typeof(h.procurementcategory4))'');
    populated_subprocurementcategory4_cnt := COUNT(GROUP,h.subprocurementcategory4 <> (TYPEOF(h.subprocurementcategory4))'');
    populated_subprocurementcategory4_pcnt := AVE(GROUP,IF(h.subprocurementcategory4 = (TYPEOF(h.subprocurementcategory4))'',0,100));
    maxlength_subprocurementcategory4 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.subprocurementcategory4)));
    avelength_subprocurementcategory4 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.subprocurementcategory4)),h.subprocurementcategory4<>(typeof(h.subprocurementcategory4))'');
    populated_procurementcategory5_cnt := COUNT(GROUP,h.procurementcategory5 <> (TYPEOF(h.procurementcategory5))'');
    populated_procurementcategory5_pcnt := AVE(GROUP,IF(h.procurementcategory5 = (TYPEOF(h.procurementcategory5))'',0,100));
    maxlength_procurementcategory5 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.procurementcategory5)));
    avelength_procurementcategory5 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.procurementcategory5)),h.procurementcategory5<>(typeof(h.procurementcategory5))'');
    populated_subprocurementcategory5_cnt := COUNT(GROUP,h.subprocurementcategory5 <> (TYPEOF(h.subprocurementcategory5))'');
    populated_subprocurementcategory5_pcnt := AVE(GROUP,IF(h.subprocurementcategory5 = (TYPEOF(h.subprocurementcategory5))'',0,100));
    maxlength_subprocurementcategory5 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.subprocurementcategory5)));
    avelength_subprocurementcategory5 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.subprocurementcategory5)),h.subprocurementcategory5<>(typeof(h.subprocurementcategory5))'');
    populated_renewal_cnt := COUNT(GROUP,h.renewal <> (TYPEOF(h.renewal))'');
    populated_renewal_pcnt := AVE(GROUP,IF(h.renewal = (TYPEOF(h.renewal))'',0,100));
    maxlength_renewal := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.renewal)));
    avelength_renewal := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.renewal)),h.renewal<>(typeof(h.renewal))'');
    populated_renewaldate_cnt := COUNT(GROUP,h.renewaldate <> (TYPEOF(h.renewaldate))'');
    populated_renewaldate_pcnt := AVE(GROUP,IF(h.renewaldate = (TYPEOF(h.renewaldate))'',0,100));
    maxlength_renewaldate := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.renewaldate)));
    avelength_renewaldate := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.renewaldate)),h.renewaldate<>(typeof(h.renewaldate))'');
    populated_unitedcertprogrampartner_cnt := COUNT(GROUP,h.unitedcertprogrampartner <> (TYPEOF(h.unitedcertprogrampartner))'');
    populated_unitedcertprogrampartner_pcnt := AVE(GROUP,IF(h.unitedcertprogrampartner = (TYPEOF(h.unitedcertprogrampartner))'',0,100));
    maxlength_unitedcertprogrampartner := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.unitedcertprogrampartner)));
    avelength_unitedcertprogrampartner := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.unitedcertprogrampartner)),h.unitedcertprogrampartner<>(typeof(h.unitedcertprogrampartner))'');
    populated_vendorkey_cnt := COUNT(GROUP,h.vendorkey <> (TYPEOF(h.vendorkey))'');
    populated_vendorkey_pcnt := AVE(GROUP,IF(h.vendorkey = (TYPEOF(h.vendorkey))'',0,100));
    maxlength_vendorkey := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.vendorkey)));
    avelength_vendorkey := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.vendorkey)),h.vendorkey<>(typeof(h.vendorkey))'');
    populated_vendornumber_cnt := COUNT(GROUP,h.vendornumber <> (TYPEOF(h.vendornumber))'');
    populated_vendornumber_pcnt := AVE(GROUP,IF(h.vendornumber = (TYPEOF(h.vendornumber))'',0,100));
    maxlength_vendornumber := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.vendornumber)));
    avelength_vendornumber := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.vendornumber)),h.vendornumber<>(typeof(h.vendornumber))'');
    populated_workcode1_cnt := COUNT(GROUP,h.workcode1 <> (TYPEOF(h.workcode1))'');
    populated_workcode1_pcnt := AVE(GROUP,IF(h.workcode1 = (TYPEOF(h.workcode1))'',0,100));
    maxlength_workcode1 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.workcode1)));
    avelength_workcode1 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.workcode1)),h.workcode1<>(typeof(h.workcode1))'');
    populated_workcode2_cnt := COUNT(GROUP,h.workcode2 <> (TYPEOF(h.workcode2))'');
    populated_workcode2_pcnt := AVE(GROUP,IF(h.workcode2 = (TYPEOF(h.workcode2))'',0,100));
    maxlength_workcode2 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.workcode2)));
    avelength_workcode2 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.workcode2)),h.workcode2<>(typeof(h.workcode2))'');
    populated_workcode3_cnt := COUNT(GROUP,h.workcode3 <> (TYPEOF(h.workcode3))'');
    populated_workcode3_pcnt := AVE(GROUP,IF(h.workcode3 = (TYPEOF(h.workcode3))'',0,100));
    maxlength_workcode3 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.workcode3)));
    avelength_workcode3 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.workcode3)),h.workcode3<>(typeof(h.workcode3))'');
    populated_workcode4_cnt := COUNT(GROUP,h.workcode4 <> (TYPEOF(h.workcode4))'');
    populated_workcode4_pcnt := AVE(GROUP,IF(h.workcode4 = (TYPEOF(h.workcode4))'',0,100));
    maxlength_workcode4 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.workcode4)));
    avelength_workcode4 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.workcode4)),h.workcode4<>(typeof(h.workcode4))'');
    populated_workcode5_cnt := COUNT(GROUP,h.workcode5 <> (TYPEOF(h.workcode5))'');
    populated_workcode5_pcnt := AVE(GROUP,IF(h.workcode5 = (TYPEOF(h.workcode5))'',0,100));
    maxlength_workcode5 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.workcode5)));
    avelength_workcode5 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.workcode5)),h.workcode5<>(typeof(h.workcode5))'');
    populated_workcode6_cnt := COUNT(GROUP,h.workcode6 <> (TYPEOF(h.workcode6))'');
    populated_workcode6_pcnt := AVE(GROUP,IF(h.workcode6 = (TYPEOF(h.workcode6))'',0,100));
    maxlength_workcode6 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.workcode6)));
    avelength_workcode6 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.workcode6)),h.workcode6<>(typeof(h.workcode6))'');
    populated_workcode7_cnt := COUNT(GROUP,h.workcode7 <> (TYPEOF(h.workcode7))'');
    populated_workcode7_pcnt := AVE(GROUP,IF(h.workcode7 = (TYPEOF(h.workcode7))'',0,100));
    maxlength_workcode7 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.workcode7)));
    avelength_workcode7 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.workcode7)),h.workcode7<>(typeof(h.workcode7))'');
    populated_workcode8_cnt := COUNT(GROUP,h.workcode8 <> (TYPEOF(h.workcode8))'');
    populated_workcode8_pcnt := AVE(GROUP,IF(h.workcode8 = (TYPEOF(h.workcode8))'',0,100));
    maxlength_workcode8 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.workcode8)));
    avelength_workcode8 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.workcode8)),h.workcode8<>(typeof(h.workcode8))'');
    populated_exporter_cnt := COUNT(GROUP,h.exporter <> (TYPEOF(h.exporter))'');
    populated_exporter_pcnt := AVE(GROUP,IF(h.exporter = (TYPEOF(h.exporter))'',0,100));
    maxlength_exporter := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.exporter)));
    avelength_exporter := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.exporter)),h.exporter<>(typeof(h.exporter))'');
    populated_exportbusinessactivities_cnt := COUNT(GROUP,h.exportbusinessactivities <> (TYPEOF(h.exportbusinessactivities))'');
    populated_exportbusinessactivities_pcnt := AVE(GROUP,IF(h.exportbusinessactivities = (TYPEOF(h.exportbusinessactivities))'',0,100));
    maxlength_exportbusinessactivities := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.exportbusinessactivities)));
    avelength_exportbusinessactivities := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.exportbusinessactivities)),h.exportbusinessactivities<>(typeof(h.exportbusinessactivities))'');
    populated_exportto_cnt := COUNT(GROUP,h.exportto <> (TYPEOF(h.exportto))'');
    populated_exportto_pcnt := AVE(GROUP,IF(h.exportto = (TYPEOF(h.exportto))'',0,100));
    maxlength_exportto := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.exportto)));
    avelength_exportto := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.exportto)),h.exportto<>(typeof(h.exportto))'');
    populated_exportbusinessrelationships_cnt := COUNT(GROUP,h.exportbusinessrelationships <> (TYPEOF(h.exportbusinessrelationships))'');
    populated_exportbusinessrelationships_pcnt := AVE(GROUP,IF(h.exportbusinessrelationships = (TYPEOF(h.exportbusinessrelationships))'',0,100));
    maxlength_exportbusinessrelationships := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.exportbusinessrelationships)));
    avelength_exportbusinessrelationships := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.exportbusinessrelationships)),h.exportbusinessrelationships<>(typeof(h.exportbusinessrelationships))'');
    populated_exportobjectives_cnt := COUNT(GROUP,h.exportobjectives <> (TYPEOF(h.exportobjectives))'');
    populated_exportobjectives_pcnt := AVE(GROUP,IF(h.exportobjectives = (TYPEOF(h.exportobjectives))'',0,100));
    maxlength_exportobjectives := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.exportobjectives)));
    avelength_exportobjectives := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.exportobjectives)),h.exportobjectives<>(typeof(h.exportobjectives))'');
    populated_reference1_cnt := COUNT(GROUP,h.reference1 <> (TYPEOF(h.reference1))'');
    populated_reference1_pcnt := AVE(GROUP,IF(h.reference1 = (TYPEOF(h.reference1))'',0,100));
    maxlength_reference1 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.reference1)));
    avelength_reference1 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.reference1)),h.reference1<>(typeof(h.reference1))'');
    populated_reference2_cnt := COUNT(GROUP,h.reference2 <> (TYPEOF(h.reference2))'');
    populated_reference2_pcnt := AVE(GROUP,IF(h.reference2 = (TYPEOF(h.reference2))'',0,100));
    maxlength_reference2 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.reference2)));
    avelength_reference2 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.reference2)),h.reference2<>(typeof(h.reference2))'');
    populated_reference3_cnt := COUNT(GROUP,h.reference3 <> (TYPEOF(h.reference3))'');
    populated_reference3_pcnt := AVE(GROUP,IF(h.reference3 = (TYPEOF(h.reference3))'',0,100));
    maxlength_reference3 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.reference3)));
    avelength_reference3 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.reference3)),h.reference3<>(typeof(h.reference3))'');
  END;
    T := TABLE(h,SummaryLayout);
  R1 := RECORD
    UNSIGNED LinkingPotential :=  + T.Populated_dartid_pcnt *   0.00 / 100 + T.Populated_dateadded_pcnt *   0.00 / 100 + T.Populated_dateupdated_pcnt *   0.00 / 100 + T.Populated_website_pcnt *   0.00 / 100 + T.Populated_state_pcnt *   0.00 / 100 + T.Populated_profilelastupdated_pcnt *   0.00 / 100 + T.Populated_county_pcnt *   0.00 / 100 + T.Populated_servicearea_pcnt *   0.00 / 100 + T.Populated_region1_pcnt *   0.00 / 100 + T.Populated_region2_pcnt *   0.00 / 100 + T.Populated_region3_pcnt *   0.00 / 100 + T.Populated_region4_pcnt *   0.00 / 100 + T.Populated_region5_pcnt *   0.00 / 100 + T.Populated_fname_pcnt *   0.00 / 100 + T.Populated_lname_pcnt *   0.00 / 100 + T.Populated_mname_pcnt *   0.00 / 100 + T.Populated_suffix_pcnt *   0.00 / 100 + T.Populated_title_pcnt *   0.00 / 100 + T.Populated_ethnicity_pcnt *   0.00 / 100 + T.Populated_gender_pcnt *   0.00 / 100 + T.Populated_address1_pcnt *   0.00 / 100 + T.Populated_address2_pcnt *   0.00 / 100 + T.Populated_addresscity_pcnt *   0.00 / 100 + T.Populated_addressstate_pcnt *   0.00 / 100 + T.Populated_addresszipcode_pcnt *   0.00 / 100 + T.Populated_addresszip4_pcnt *   0.00 / 100 + T.Populated_building_pcnt *   0.00 / 100 + T.Populated_contact_pcnt *   0.00 / 100 + T.Populated_phone1_pcnt *   0.00 / 100 + T.Populated_phone2_pcnt *   0.00 / 100 + T.Populated_phone3_pcnt *   0.00 / 100 + T.Populated_cell_pcnt *   0.00 / 100 + T.Populated_fax_pcnt *   0.00 / 100 + T.Populated_email1_pcnt *   0.00 / 100 + T.Populated_email2_pcnt *   0.00 / 100 + T.Populated_email3_pcnt *   0.00 / 100 + T.Populated_webpage1_pcnt *   0.00 / 100 + T.Populated_webpage2_pcnt *   0.00 / 100 + T.Populated_webpage3_pcnt *   0.00 / 100 + T.Populated_businessname_pcnt *   0.00 / 100 + T.Populated_dba_pcnt *   0.00 / 100 + T.Populated_businessid_pcnt *   0.00 / 100 + T.Populated_businesstype1_pcnt *   0.00 / 100 + T.Populated_businesslocation1_pcnt *   0.00 / 100 + T.Populated_businesstype2_pcnt *   0.00 / 100 + T.Populated_businesslocation2_pcnt *   0.00 / 100 + T.Populated_businesstype3_pcnt *   0.00 / 100 + T.Populated_businesslocation3_pcnt *   0.00 / 100 + T.Populated_businesstype4_pcnt *   0.00 / 100 + T.Populated_businesslocation4_pcnt *   0.00 / 100 + T.Populated_businesstype5_pcnt *   0.00 / 100 + T.Populated_businesslocation5_pcnt *   0.00 / 100 + T.Populated_industry_pcnt *   0.00 / 100 + T.Populated_trade_pcnt *   0.00 / 100 + T.Populated_resourcedescription_pcnt *   0.00 / 100 + T.Populated_natureofbusiness_pcnt *   0.00 / 100 + T.Populated_businessstructure_pcnt *   0.00 / 100 + T.Populated_totalemployees_pcnt *   0.00 / 100 + T.Populated_avgcontractsize_pcnt *   0.00 / 100 + T.Populated_firmid_pcnt *   0.00 / 100 + T.Populated_firmlocationaddress_pcnt *   0.00 / 100 + T.Populated_firmlocationaddresscity_pcnt *   0.00 / 100 + T.Populated_firmlocationaddresszip4_pcnt *   0.00 / 100 + T.Populated_firmlocationaddresszipcode_pcnt *   0.00 / 100 + T.Populated_firmlocationcounty_pcnt *   0.00 / 100 + T.Populated_firmlocationstate_pcnt *   0.00 / 100 + T.Populated_certfed_pcnt *   0.00 / 100 + T.Populated_certstate_pcnt *   0.00 / 100 + T.Populated_contractsfederal_pcnt *   0.00 / 100 + T.Populated_contractsva_pcnt *   0.00 / 100 + T.Populated_contractscommercial_pcnt *   0.00 / 100 + T.Populated_contractorgovernmentprime_pcnt *   0.00 / 100 + T.Populated_contractorgovernmentsub_pcnt *   0.00 / 100 + T.Populated_contractornongovernment_pcnt *   0.00 / 100 + T.Populated_registeredgovernmentbus_pcnt *   0.00 / 100 + T.Populated_registerednongovernmentbus_pcnt *   0.00 / 100 + T.Populated_clearancelevelpersonnel_pcnt *   0.00 / 100 + T.Populated_clearancelevelfacility_pcnt *   0.00 / 100 + T.Populated_certificatedatefrom1_pcnt *   0.00 / 100 + T.Populated_certificatedateto1_pcnt *   0.00 / 100 + T.Populated_certificatestatus1_pcnt *   0.00 / 100 + T.Populated_certificationnumber1_pcnt *   0.00 / 100 + T.Populated_certificationtype1_pcnt *   0.00 / 100 + T.Populated_certificatedatefrom2_pcnt *   0.00 / 100 + T.Populated_certificatedateto2_pcnt *   0.00 / 100 + T.Populated_certificatestatus2_pcnt *   0.00 / 100 + T.Populated_certificationnumber2_pcnt *   0.00 / 100 + T.Populated_certificationtype2_pcnt *   0.00 / 100 + T.Populated_certificatedatefrom3_pcnt *   0.00 / 100 + T.Populated_certificatedateto3_pcnt *   0.00 / 100 + T.Populated_certificatestatus3_pcnt *   0.00 / 100 + T.Populated_certificationnumber3_pcnt *   0.00 / 100 + T.Populated_certificationtype3_pcnt *   0.00 / 100 + T.Populated_certificatedatefrom4_pcnt *   0.00 / 100 + T.Populated_certificatedateto4_pcnt *   0.00 / 100 + T.Populated_certificatestatus4_pcnt *   0.00 / 100 + T.Populated_certificationnumber4_pcnt *   0.00 / 100 + T.Populated_certificationtype4_pcnt *   0.00 / 100 + T.Populated_certificatedatefrom5_pcnt *   0.00 / 100 + T.Populated_certificatedateto5_pcnt *   0.00 / 100 + T.Populated_certificatestatus5_pcnt *   0.00 / 100 + T.Populated_certificationnumber5_pcnt *   0.00 / 100 + T.Populated_certificationtype5_pcnt *   0.00 / 100 + T.Populated_certificatedatefrom6_pcnt *   0.00 / 100 + T.Populated_certificatedateto6_pcnt *   0.00 / 100 + T.Populated_certificatestatus6_pcnt *   0.00 / 100 + T.Populated_certificationnumber6_pcnt *   0.00 / 100 + T.Populated_certificationtype6_pcnt *   0.00 / 100 + T.Populated_starrating_pcnt *   0.00 / 100 + T.Populated_assets_pcnt *   0.00 / 100 + T.Populated_biddescription_pcnt *   0.00 / 100 + T.Populated_competitiveadvantage_pcnt *   0.00 / 100 + T.Populated_cagecode_pcnt *   0.00 / 100 + T.Populated_capabilitiesnarrative_pcnt *   0.00 / 100 + T.Populated_category_pcnt *   0.00 / 100 + T.Populated_chtrclass_pcnt *   0.00 / 100 + T.Populated_productdescription1_pcnt *   0.00 / 100 + T.Populated_productdescription2_pcnt *   0.00 / 100 + T.Populated_productdescription3_pcnt *   0.00 / 100 + T.Populated_productdescription4_pcnt *   0.00 / 100 + T.Populated_productdescription5_pcnt *   0.00 / 100 + T.Populated_classdescription1_pcnt *   0.00 / 100 + T.Populated_subclassdescription1_pcnt *   0.00 / 100 + T.Populated_classdescription2_pcnt *   0.00 / 100 + T.Populated_subclassdescription2_pcnt *   0.00 / 100 + T.Populated_classdescription3_pcnt *   0.00 / 100 + T.Populated_subclassdescription3_pcnt *   0.00 / 100 + T.Populated_classdescription4_pcnt *   0.00 / 100 + T.Populated_subclassdescription4_pcnt *   0.00 / 100 + T.Populated_classdescription5_pcnt *   0.00 / 100 + T.Populated_subclassdescription5_pcnt *   0.00 / 100 + T.Populated_classifications_pcnt *   0.00 / 100 + T.Populated_commodity1_pcnt *   0.00 / 100 + T.Populated_commodity2_pcnt *   0.00 / 100 + T.Populated_commodity3_pcnt *   0.00 / 100 + T.Populated_commodity4_pcnt *   0.00 / 100 + T.Populated_commodity5_pcnt *   0.00 / 100 + T.Populated_commodity6_pcnt *   0.00 / 100 + T.Populated_commodity7_pcnt *   0.00 / 100 + T.Populated_commodity8_pcnt *   0.00 / 100 + T.Populated_completedate_pcnt *   0.00 / 100 + T.Populated_crossreference_pcnt *   0.00 / 100 + T.Populated_dateestablished_pcnt *   0.00 / 100 + T.Populated_businessage_pcnt *   0.00 / 100 + T.Populated_deposits_pcnt *   0.00 / 100 + T.Populated_dunsnumber_pcnt *   0.00 / 100 + T.Populated_enttype_pcnt *   0.00 / 100 + T.Populated_expirationdate_pcnt *   0.00 / 100 + T.Populated_extendeddate_pcnt *   0.00 / 100 + T.Populated_issuingauthority_pcnt *   0.00 / 100 + T.Populated_keywords_pcnt *   0.00 / 100 + T.Populated_licensenumber_pcnt *   0.00 / 100 + T.Populated_licensetype_pcnt *   0.00 / 100 + T.Populated_mincd_pcnt *   0.00 / 100 + T.Populated_minorityaffiliation_pcnt *   0.00 / 100 + T.Populated_minorityownershipdate_pcnt *   0.00 / 100 + T.Populated_siccode1_pcnt *   0.00 / 100 + T.Populated_siccode2_pcnt *   0.00 / 100 + T.Populated_siccode3_pcnt *   0.00 / 100 + T.Populated_siccode4_pcnt *   0.00 / 100 + T.Populated_siccode5_pcnt *   0.00 / 100 + T.Populated_siccode6_pcnt *   0.00 / 100 + T.Populated_siccode7_pcnt *   0.00 / 100 + T.Populated_siccode8_pcnt *   0.00 / 100 + T.Populated_naicscode1_pcnt *   0.00 / 100 + T.Populated_naicscode2_pcnt *   0.00 / 100 + T.Populated_naicscode3_pcnt *   0.00 / 100 + T.Populated_naicscode4_pcnt *   0.00 / 100 + T.Populated_naicscode5_pcnt *   0.00 / 100 + T.Populated_naicscode6_pcnt *   0.00 / 100 + T.Populated_naicscode7_pcnt *   0.00 / 100 + T.Populated_naicscode8_pcnt *   0.00 / 100 + T.Populated_prequalify_pcnt *   0.00 / 100 + T.Populated_procurementcategory1_pcnt *   0.00 / 100 + T.Populated_subprocurementcategory1_pcnt *   0.00 / 100 + T.Populated_procurementcategory2_pcnt *   0.00 / 100 + T.Populated_subprocurementcategory2_pcnt *   0.00 / 100 + T.Populated_procurementcategory3_pcnt *   0.00 / 100 + T.Populated_subprocurementcategory3_pcnt *   0.00 / 100 + T.Populated_procurementcategory4_pcnt *   0.00 / 100 + T.Populated_subprocurementcategory4_pcnt *   0.00 / 100 + T.Populated_procurementcategory5_pcnt *   0.00 / 100 + T.Populated_subprocurementcategory5_pcnt *   0.00 / 100 + T.Populated_renewal_pcnt *   0.00 / 100 + T.Populated_renewaldate_pcnt *   0.00 / 100 + T.Populated_unitedcertprogrampartner_pcnt *   0.00 / 100 + T.Populated_vendorkey_pcnt *   0.00 / 100 + T.Populated_vendornumber_pcnt *   0.00 / 100 + T.Populated_workcode1_pcnt *   0.00 / 100 + T.Populated_workcode2_pcnt *   0.00 / 100 + T.Populated_workcode3_pcnt *   0.00 / 100 + T.Populated_workcode4_pcnt *   0.00 / 100 + T.Populated_workcode5_pcnt *   0.00 / 100 + T.Populated_workcode6_pcnt *   0.00 / 100 + T.Populated_workcode7_pcnt *   0.00 / 100 + T.Populated_workcode8_pcnt *   0.00 / 100 + T.Populated_exporter_pcnt *   0.00 / 100 + T.Populated_exportbusinessactivities_pcnt *   0.00 / 100 + T.Populated_exportto_pcnt *   0.00 / 100 + T.Populated_exportbusinessrelationships_pcnt *   0.00 / 100 + T.Populated_exportobjectives_pcnt *   0.00 / 100 + T.Populated_reference1_pcnt *   0.00 / 100 + T.Populated_reference2_pcnt *   0.00 / 100 + T.Populated_reference3_pcnt *   0.00 / 100;
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
  SELF.FieldName := CHOOSE(C,'dartid','dateadded','dateupdated','website','state','profilelastupdated','county','servicearea','region1','region2','region3','region4','region5','fname','lname','mname','suffix','title','ethnicity','gender','address1','address2','addresscity','addressstate','addresszipcode','addresszip4','building','contact','phone1','phone2','phone3','cell','fax','email1','email2','email3','webpage1','webpage2','webpage3','businessname','dba','businessid','businesstype1','businesslocation1','businesstype2','businesslocation2','businesstype3','businesslocation3','businesstype4','businesslocation4','businesstype5','businesslocation5','industry','trade','resourcedescription','natureofbusiness','businessstructure','totalemployees','avgcontractsize','firmid','firmlocationaddress','firmlocationaddresscity','firmlocationaddresszip4','firmlocationaddresszipcode','firmlocationcounty','firmlocationstate','certfed','certstate','contractsfederal','contractsva','contractscommercial','contractorgovernmentprime','contractorgovernmentsub','contractornongovernment','registeredgovernmentbus','registerednongovernmentbus','clearancelevelpersonnel','clearancelevelfacility','certificatedatefrom1','certificatedateto1','certificatestatus1','certificationnumber1','certificationtype1','certificatedatefrom2','certificatedateto2','certificatestatus2','certificationnumber2','certificationtype2','certificatedatefrom3','certificatedateto3','certificatestatus3','certificationnumber3','certificationtype3','certificatedatefrom4','certificatedateto4','certificatestatus4','certificationnumber4','certificationtype4','certificatedatefrom5','certificatedateto5','certificatestatus5','certificationnumber5','certificationtype5','certificatedatefrom6','certificatedateto6','certificatestatus6','certificationnumber6','certificationtype6','starrating','assets','biddescription','competitiveadvantage','cagecode','capabilitiesnarrative','category','chtrclass','productdescription1','productdescription2','productdescription3','productdescription4','productdescription5','classdescription1','subclassdescription1','classdescription2','subclassdescription2','classdescription3','subclassdescription3','classdescription4','subclassdescription4','classdescription5','subclassdescription5','classifications','commodity1','commodity2','commodity3','commodity4','commodity5','commodity6','commodity7','commodity8','completedate','crossreference','dateestablished','businessage','deposits','dunsnumber','enttype','expirationdate','extendeddate','issuingauthority','keywords','licensenumber','licensetype','mincd','minorityaffiliation','minorityownershipdate','siccode1','siccode2','siccode3','siccode4','siccode5','siccode6','siccode7','siccode8','naicscode1','naicscode2','naicscode3','naicscode4','naicscode5','naicscode6','naicscode7','naicscode8','prequalify','procurementcategory1','subprocurementcategory1','procurementcategory2','subprocurementcategory2','procurementcategory3','subprocurementcategory3','procurementcategory4','subprocurementcategory4','procurementcategory5','subprocurementcategory5','renewal','renewaldate','unitedcertprogrampartner','vendorkey','vendornumber','workcode1','workcode2','workcode3','workcode4','workcode5','workcode6','workcode7','workcode8','exporter','exportbusinessactivities','exportto','exportbusinessrelationships','exportobjectives','reference1','reference2','reference3');
  SELF.populated_pcnt := CHOOSE(C,le.populated_dartid_pcnt,le.populated_dateadded_pcnt,le.populated_dateupdated_pcnt,le.populated_website_pcnt,le.populated_state_pcnt,le.populated_profilelastupdated_pcnt,le.populated_county_pcnt,le.populated_servicearea_pcnt,le.populated_region1_pcnt,le.populated_region2_pcnt,le.populated_region3_pcnt,le.populated_region4_pcnt,le.populated_region5_pcnt,le.populated_fname_pcnt,le.populated_lname_pcnt,le.populated_mname_pcnt,le.populated_suffix_pcnt,le.populated_title_pcnt,le.populated_ethnicity_pcnt,le.populated_gender_pcnt,le.populated_address1_pcnt,le.populated_address2_pcnt,le.populated_addresscity_pcnt,le.populated_addressstate_pcnt,le.populated_addresszipcode_pcnt,le.populated_addresszip4_pcnt,le.populated_building_pcnt,le.populated_contact_pcnt,le.populated_phone1_pcnt,le.populated_phone2_pcnt,le.populated_phone3_pcnt,le.populated_cell_pcnt,le.populated_fax_pcnt,le.populated_email1_pcnt,le.populated_email2_pcnt,le.populated_email3_pcnt,le.populated_webpage1_pcnt,le.populated_webpage2_pcnt,le.populated_webpage3_pcnt,le.populated_businessname_pcnt,le.populated_dba_pcnt,le.populated_businessid_pcnt,le.populated_businesstype1_pcnt,le.populated_businesslocation1_pcnt,le.populated_businesstype2_pcnt,le.populated_businesslocation2_pcnt,le.populated_businesstype3_pcnt,le.populated_businesslocation3_pcnt,le.populated_businesstype4_pcnt,le.populated_businesslocation4_pcnt,le.populated_businesstype5_pcnt,le.populated_businesslocation5_pcnt,le.populated_industry_pcnt,le.populated_trade_pcnt,le.populated_resourcedescription_pcnt,le.populated_natureofbusiness_pcnt,le.populated_businessstructure_pcnt,le.populated_totalemployees_pcnt,le.populated_avgcontractsize_pcnt,le.populated_firmid_pcnt,le.populated_firmlocationaddress_pcnt,le.populated_firmlocationaddresscity_pcnt,le.populated_firmlocationaddresszip4_pcnt,le.populated_firmlocationaddresszipcode_pcnt,le.populated_firmlocationcounty_pcnt,le.populated_firmlocationstate_pcnt,le.populated_certfed_pcnt,le.populated_certstate_pcnt,le.populated_contractsfederal_pcnt,le.populated_contractsva_pcnt,le.populated_contractscommercial_pcnt,le.populated_contractorgovernmentprime_pcnt,le.populated_contractorgovernmentsub_pcnt,le.populated_contractornongovernment_pcnt,le.populated_registeredgovernmentbus_pcnt,le.populated_registerednongovernmentbus_pcnt,le.populated_clearancelevelpersonnel_pcnt,le.populated_clearancelevelfacility_pcnt,le.populated_certificatedatefrom1_pcnt,le.populated_certificatedateto1_pcnt,le.populated_certificatestatus1_pcnt,le.populated_certificationnumber1_pcnt,le.populated_certificationtype1_pcnt,le.populated_certificatedatefrom2_pcnt,le.populated_certificatedateto2_pcnt,le.populated_certificatestatus2_pcnt,le.populated_certificationnumber2_pcnt,le.populated_certificationtype2_pcnt,le.populated_certificatedatefrom3_pcnt,le.populated_certificatedateto3_pcnt,le.populated_certificatestatus3_pcnt,le.populated_certificationnumber3_pcnt,le.populated_certificationtype3_pcnt,le.populated_certificatedatefrom4_pcnt,le.populated_certificatedateto4_pcnt,le.populated_certificatestatus4_pcnt,le.populated_certificationnumber4_pcnt,le.populated_certificationtype4_pcnt,le.populated_certificatedatefrom5_pcnt,le.populated_certificatedateto5_pcnt,le.populated_certificatestatus5_pcnt,le.populated_certificationnumber5_pcnt,le.populated_certificationtype5_pcnt,le.populated_certificatedatefrom6_pcnt,le.populated_certificatedateto6_pcnt,le.populated_certificatestatus6_pcnt,le.populated_certificationnumber6_pcnt,le.populated_certificationtype6_pcnt,le.populated_starrating_pcnt,le.populated_assets_pcnt,le.populated_biddescription_pcnt,le.populated_competitiveadvantage_pcnt,le.populated_cagecode_pcnt,le.populated_capabilitiesnarrative_pcnt,le.populated_category_pcnt,le.populated_chtrclass_pcnt,le.populated_productdescription1_pcnt,le.populated_productdescription2_pcnt,le.populated_productdescription3_pcnt,le.populated_productdescription4_pcnt,le.populated_productdescription5_pcnt,le.populated_classdescription1_pcnt,le.populated_subclassdescription1_pcnt,le.populated_classdescription2_pcnt,le.populated_subclassdescription2_pcnt,le.populated_classdescription3_pcnt,le.populated_subclassdescription3_pcnt,le.populated_classdescription4_pcnt,le.populated_subclassdescription4_pcnt,le.populated_classdescription5_pcnt,le.populated_subclassdescription5_pcnt,le.populated_classifications_pcnt,le.populated_commodity1_pcnt,le.populated_commodity2_pcnt,le.populated_commodity3_pcnt,le.populated_commodity4_pcnt,le.populated_commodity5_pcnt,le.populated_commodity6_pcnt,le.populated_commodity7_pcnt,le.populated_commodity8_pcnt,le.populated_completedate_pcnt,le.populated_crossreference_pcnt,le.populated_dateestablished_pcnt,le.populated_businessage_pcnt,le.populated_deposits_pcnt,le.populated_dunsnumber_pcnt,le.populated_enttype_pcnt,le.populated_expirationdate_pcnt,le.populated_extendeddate_pcnt,le.populated_issuingauthority_pcnt,le.populated_keywords_pcnt,le.populated_licensenumber_pcnt,le.populated_licensetype_pcnt,le.populated_mincd_pcnt,le.populated_minorityaffiliation_pcnt,le.populated_minorityownershipdate_pcnt,le.populated_siccode1_pcnt,le.populated_siccode2_pcnt,le.populated_siccode3_pcnt,le.populated_siccode4_pcnt,le.populated_siccode5_pcnt,le.populated_siccode6_pcnt,le.populated_siccode7_pcnt,le.populated_siccode8_pcnt,le.populated_naicscode1_pcnt,le.populated_naicscode2_pcnt,le.populated_naicscode3_pcnt,le.populated_naicscode4_pcnt,le.populated_naicscode5_pcnt,le.populated_naicscode6_pcnt,le.populated_naicscode7_pcnt,le.populated_naicscode8_pcnt,le.populated_prequalify_pcnt,le.populated_procurementcategory1_pcnt,le.populated_subprocurementcategory1_pcnt,le.populated_procurementcategory2_pcnt,le.populated_subprocurementcategory2_pcnt,le.populated_procurementcategory3_pcnt,le.populated_subprocurementcategory3_pcnt,le.populated_procurementcategory4_pcnt,le.populated_subprocurementcategory4_pcnt,le.populated_procurementcategory5_pcnt,le.populated_subprocurementcategory5_pcnt,le.populated_renewal_pcnt,le.populated_renewaldate_pcnt,le.populated_unitedcertprogrampartner_pcnt,le.populated_vendorkey_pcnt,le.populated_vendornumber_pcnt,le.populated_workcode1_pcnt,le.populated_workcode2_pcnt,le.populated_workcode3_pcnt,le.populated_workcode4_pcnt,le.populated_workcode5_pcnt,le.populated_workcode6_pcnt,le.populated_workcode7_pcnt,le.populated_workcode8_pcnt,le.populated_exporter_pcnt,le.populated_exportbusinessactivities_pcnt,le.populated_exportto_pcnt,le.populated_exportbusinessrelationships_pcnt,le.populated_exportobjectives_pcnt,le.populated_reference1_pcnt,le.populated_reference2_pcnt,le.populated_reference3_pcnt);
  SELF.maxlength := CHOOSE(C,le.maxlength_dartid,le.maxlength_dateadded,le.maxlength_dateupdated,le.maxlength_website,le.maxlength_state,le.maxlength_profilelastupdated,le.maxlength_county,le.maxlength_servicearea,le.maxlength_region1,le.maxlength_region2,le.maxlength_region3,le.maxlength_region4,le.maxlength_region5,le.maxlength_fname,le.maxlength_lname,le.maxlength_mname,le.maxlength_suffix,le.maxlength_title,le.maxlength_ethnicity,le.maxlength_gender,le.maxlength_address1,le.maxlength_address2,le.maxlength_addresscity,le.maxlength_addressstate,le.maxlength_addresszipcode,le.maxlength_addresszip4,le.maxlength_building,le.maxlength_contact,le.maxlength_phone1,le.maxlength_phone2,le.maxlength_phone3,le.maxlength_cell,le.maxlength_fax,le.maxlength_email1,le.maxlength_email2,le.maxlength_email3,le.maxlength_webpage1,le.maxlength_webpage2,le.maxlength_webpage3,le.maxlength_businessname,le.maxlength_dba,le.maxlength_businessid,le.maxlength_businesstype1,le.maxlength_businesslocation1,le.maxlength_businesstype2,le.maxlength_businesslocation2,le.maxlength_businesstype3,le.maxlength_businesslocation3,le.maxlength_businesstype4,le.maxlength_businesslocation4,le.maxlength_businesstype5,le.maxlength_businesslocation5,le.maxlength_industry,le.maxlength_trade,le.maxlength_resourcedescription,le.maxlength_natureofbusiness,le.maxlength_businessstructure,le.maxlength_totalemployees,le.maxlength_avgcontractsize,le.maxlength_firmid,le.maxlength_firmlocationaddress,le.maxlength_firmlocationaddresscity,le.maxlength_firmlocationaddresszip4,le.maxlength_firmlocationaddresszipcode,le.maxlength_firmlocationcounty,le.maxlength_firmlocationstate,le.maxlength_certfed,le.maxlength_certstate,le.maxlength_contractsfederal,le.maxlength_contractsva,le.maxlength_contractscommercial,le.maxlength_contractorgovernmentprime,le.maxlength_contractorgovernmentsub,le.maxlength_contractornongovernment,le.maxlength_registeredgovernmentbus,le.maxlength_registerednongovernmentbus,le.maxlength_clearancelevelpersonnel,le.maxlength_clearancelevelfacility,le.maxlength_certificatedatefrom1,le.maxlength_certificatedateto1,le.maxlength_certificatestatus1,le.maxlength_certificationnumber1,le.maxlength_certificationtype1,le.maxlength_certificatedatefrom2,le.maxlength_certificatedateto2,le.maxlength_certificatestatus2,le.maxlength_certificationnumber2,le.maxlength_certificationtype2,le.maxlength_certificatedatefrom3,le.maxlength_certificatedateto3,le.maxlength_certificatestatus3,le.maxlength_certificationnumber3,le.maxlength_certificationtype3,le.maxlength_certificatedatefrom4,le.maxlength_certificatedateto4,le.maxlength_certificatestatus4,le.maxlength_certificationnumber4,le.maxlength_certificationtype4,le.maxlength_certificatedatefrom5,le.maxlength_certificatedateto5,le.maxlength_certificatestatus5,le.maxlength_certificationnumber5,le.maxlength_certificationtype5,le.maxlength_certificatedatefrom6,le.maxlength_certificatedateto6,le.maxlength_certificatestatus6,le.maxlength_certificationnumber6,le.maxlength_certificationtype6,le.maxlength_starrating,le.maxlength_assets,le.maxlength_biddescription,le.maxlength_competitiveadvantage,le.maxlength_cagecode,le.maxlength_capabilitiesnarrative,le.maxlength_category,le.maxlength_chtrclass,le.maxlength_productdescription1,le.maxlength_productdescription2,le.maxlength_productdescription3,le.maxlength_productdescription4,le.maxlength_productdescription5,le.maxlength_classdescription1,le.maxlength_subclassdescription1,le.maxlength_classdescription2,le.maxlength_subclassdescription2,le.maxlength_classdescription3,le.maxlength_subclassdescription3,le.maxlength_classdescription4,le.maxlength_subclassdescription4,le.maxlength_classdescription5,le.maxlength_subclassdescription5,le.maxlength_classifications,le.maxlength_commodity1,le.maxlength_commodity2,le.maxlength_commodity3,le.maxlength_commodity4,le.maxlength_commodity5,le.maxlength_commodity6,le.maxlength_commodity7,le.maxlength_commodity8,le.maxlength_completedate,le.maxlength_crossreference,le.maxlength_dateestablished,le.maxlength_businessage,le.maxlength_deposits,le.maxlength_dunsnumber,le.maxlength_enttype,le.maxlength_expirationdate,le.maxlength_extendeddate,le.maxlength_issuingauthority,le.maxlength_keywords,le.maxlength_licensenumber,le.maxlength_licensetype,le.maxlength_mincd,le.maxlength_minorityaffiliation,le.maxlength_minorityownershipdate,le.maxlength_siccode1,le.maxlength_siccode2,le.maxlength_siccode3,le.maxlength_siccode4,le.maxlength_siccode5,le.maxlength_siccode6,le.maxlength_siccode7,le.maxlength_siccode8,le.maxlength_naicscode1,le.maxlength_naicscode2,le.maxlength_naicscode3,le.maxlength_naicscode4,le.maxlength_naicscode5,le.maxlength_naicscode6,le.maxlength_naicscode7,le.maxlength_naicscode8,le.maxlength_prequalify,le.maxlength_procurementcategory1,le.maxlength_subprocurementcategory1,le.maxlength_procurementcategory2,le.maxlength_subprocurementcategory2,le.maxlength_procurementcategory3,le.maxlength_subprocurementcategory3,le.maxlength_procurementcategory4,le.maxlength_subprocurementcategory4,le.maxlength_procurementcategory5,le.maxlength_subprocurementcategory5,le.maxlength_renewal,le.maxlength_renewaldate,le.maxlength_unitedcertprogrampartner,le.maxlength_vendorkey,le.maxlength_vendornumber,le.maxlength_workcode1,le.maxlength_workcode2,le.maxlength_workcode3,le.maxlength_workcode4,le.maxlength_workcode5,le.maxlength_workcode6,le.maxlength_workcode7,le.maxlength_workcode8,le.maxlength_exporter,le.maxlength_exportbusinessactivities,le.maxlength_exportto,le.maxlength_exportbusinessrelationships,le.maxlength_exportobjectives,le.maxlength_reference1,le.maxlength_reference2,le.maxlength_reference3);
  SELF.avelength := CHOOSE(C,le.avelength_dartid,le.avelength_dateadded,le.avelength_dateupdated,le.avelength_website,le.avelength_state,le.avelength_profilelastupdated,le.avelength_county,le.avelength_servicearea,le.avelength_region1,le.avelength_region2,le.avelength_region3,le.avelength_region4,le.avelength_region5,le.avelength_fname,le.avelength_lname,le.avelength_mname,le.avelength_suffix,le.avelength_title,le.avelength_ethnicity,le.avelength_gender,le.avelength_address1,le.avelength_address2,le.avelength_addresscity,le.avelength_addressstate,le.avelength_addresszipcode,le.avelength_addresszip4,le.avelength_building,le.avelength_contact,le.avelength_phone1,le.avelength_phone2,le.avelength_phone3,le.avelength_cell,le.avelength_fax,le.avelength_email1,le.avelength_email2,le.avelength_email3,le.avelength_webpage1,le.avelength_webpage2,le.avelength_webpage3,le.avelength_businessname,le.avelength_dba,le.avelength_businessid,le.avelength_businesstype1,le.avelength_businesslocation1,le.avelength_businesstype2,le.avelength_businesslocation2,le.avelength_businesstype3,le.avelength_businesslocation3,le.avelength_businesstype4,le.avelength_businesslocation4,le.avelength_businesstype5,le.avelength_businesslocation5,le.avelength_industry,le.avelength_trade,le.avelength_resourcedescription,le.avelength_natureofbusiness,le.avelength_businessstructure,le.avelength_totalemployees,le.avelength_avgcontractsize,le.avelength_firmid,le.avelength_firmlocationaddress,le.avelength_firmlocationaddresscity,le.avelength_firmlocationaddresszip4,le.avelength_firmlocationaddresszipcode,le.avelength_firmlocationcounty,le.avelength_firmlocationstate,le.avelength_certfed,le.avelength_certstate,le.avelength_contractsfederal,le.avelength_contractsva,le.avelength_contractscommercial,le.avelength_contractorgovernmentprime,le.avelength_contractorgovernmentsub,le.avelength_contractornongovernment,le.avelength_registeredgovernmentbus,le.avelength_registerednongovernmentbus,le.avelength_clearancelevelpersonnel,le.avelength_clearancelevelfacility,le.avelength_certificatedatefrom1,le.avelength_certificatedateto1,le.avelength_certificatestatus1,le.avelength_certificationnumber1,le.avelength_certificationtype1,le.avelength_certificatedatefrom2,le.avelength_certificatedateto2,le.avelength_certificatestatus2,le.avelength_certificationnumber2,le.avelength_certificationtype2,le.avelength_certificatedatefrom3,le.avelength_certificatedateto3,le.avelength_certificatestatus3,le.avelength_certificationnumber3,le.avelength_certificationtype3,le.avelength_certificatedatefrom4,le.avelength_certificatedateto4,le.avelength_certificatestatus4,le.avelength_certificationnumber4,le.avelength_certificationtype4,le.avelength_certificatedatefrom5,le.avelength_certificatedateto5,le.avelength_certificatestatus5,le.avelength_certificationnumber5,le.avelength_certificationtype5,le.avelength_certificatedatefrom6,le.avelength_certificatedateto6,le.avelength_certificatestatus6,le.avelength_certificationnumber6,le.avelength_certificationtype6,le.avelength_starrating,le.avelength_assets,le.avelength_biddescription,le.avelength_competitiveadvantage,le.avelength_cagecode,le.avelength_capabilitiesnarrative,le.avelength_category,le.avelength_chtrclass,le.avelength_productdescription1,le.avelength_productdescription2,le.avelength_productdescription3,le.avelength_productdescription4,le.avelength_productdescription5,le.avelength_classdescription1,le.avelength_subclassdescription1,le.avelength_classdescription2,le.avelength_subclassdescription2,le.avelength_classdescription3,le.avelength_subclassdescription3,le.avelength_classdescription4,le.avelength_subclassdescription4,le.avelength_classdescription5,le.avelength_subclassdescription5,le.avelength_classifications,le.avelength_commodity1,le.avelength_commodity2,le.avelength_commodity3,le.avelength_commodity4,le.avelength_commodity5,le.avelength_commodity6,le.avelength_commodity7,le.avelength_commodity8,le.avelength_completedate,le.avelength_crossreference,le.avelength_dateestablished,le.avelength_businessage,le.avelength_deposits,le.avelength_dunsnumber,le.avelength_enttype,le.avelength_expirationdate,le.avelength_extendeddate,le.avelength_issuingauthority,le.avelength_keywords,le.avelength_licensenumber,le.avelength_licensetype,le.avelength_mincd,le.avelength_minorityaffiliation,le.avelength_minorityownershipdate,le.avelength_siccode1,le.avelength_siccode2,le.avelength_siccode3,le.avelength_siccode4,le.avelength_siccode5,le.avelength_siccode6,le.avelength_siccode7,le.avelength_siccode8,le.avelength_naicscode1,le.avelength_naicscode2,le.avelength_naicscode3,le.avelength_naicscode4,le.avelength_naicscode5,le.avelength_naicscode6,le.avelength_naicscode7,le.avelength_naicscode8,le.avelength_prequalify,le.avelength_procurementcategory1,le.avelength_subprocurementcategory1,le.avelength_procurementcategory2,le.avelength_subprocurementcategory2,le.avelength_procurementcategory3,le.avelength_subprocurementcategory3,le.avelength_procurementcategory4,le.avelength_subprocurementcategory4,le.avelength_procurementcategory5,le.avelength_subprocurementcategory5,le.avelength_renewal,le.avelength_renewaldate,le.avelength_unitedcertprogrampartner,le.avelength_vendorkey,le.avelength_vendornumber,le.avelength_workcode1,le.avelength_workcode2,le.avelength_workcode3,le.avelength_workcode4,le.avelength_workcode5,le.avelength_workcode6,le.avelength_workcode7,le.avelength_workcode8,le.avelength_exporter,le.avelength_exportbusinessactivities,le.avelength_exportto,le.avelength_exportbusinessrelationships,le.avelength_exportobjectives,le.avelength_reference1,le.avelength_reference2,le.avelength_reference3);
END;
EXPORT invSummary := NORMALIZE(summary0, 204, invert(LEFT,COUNTER));
// The character counts
// Move everything into 'inverted list' form so processing can be done 'in library'
SALT311.MAC_Character_Counts.X_Data_Layout Into(h le,unsigned C) := TRANSFORM
  SELF.Fld := TRIM(CHOOSE(C,TRIM((SALT311.StrType)le.dartid),TRIM((SALT311.StrType)le.dateadded),TRIM((SALT311.StrType)le.dateupdated),TRIM((SALT311.StrType)le.website),TRIM((SALT311.StrType)le.state),TRIM((SALT311.StrType)le.profilelastupdated),TRIM((SALT311.StrType)le.county),TRIM((SALT311.StrType)le.servicearea),TRIM((SALT311.StrType)le.region1),TRIM((SALT311.StrType)le.region2),TRIM((SALT311.StrType)le.region3),TRIM((SALT311.StrType)le.region4),TRIM((SALT311.StrType)le.region5),TRIM((SALT311.StrType)le.fname),TRIM((SALT311.StrType)le.lname),TRIM((SALT311.StrType)le.mname),TRIM((SALT311.StrType)le.suffix),TRIM((SALT311.StrType)le.title),TRIM((SALT311.StrType)le.ethnicity),TRIM((SALT311.StrType)le.gender),TRIM((SALT311.StrType)le.address1),TRIM((SALT311.StrType)le.address2),TRIM((SALT311.StrType)le.addresscity),TRIM((SALT311.StrType)le.addressstate),TRIM((SALT311.StrType)le.addresszipcode),TRIM((SALT311.StrType)le.addresszip4),TRIM((SALT311.StrType)le.building),TRIM((SALT311.StrType)le.contact),TRIM((SALT311.StrType)le.phone1),TRIM((SALT311.StrType)le.phone2),TRIM((SALT311.StrType)le.phone3),TRIM((SALT311.StrType)le.cell),TRIM((SALT311.StrType)le.fax),TRIM((SALT311.StrType)le.email1),TRIM((SALT311.StrType)le.email2),TRIM((SALT311.StrType)le.email3),TRIM((SALT311.StrType)le.webpage1),TRIM((SALT311.StrType)le.webpage2),TRIM((SALT311.StrType)le.webpage3),TRIM((SALT311.StrType)le.businessname),TRIM((SALT311.StrType)le.dba),TRIM((SALT311.StrType)le.businessid),TRIM((SALT311.StrType)le.businesstype1),TRIM((SALT311.StrType)le.businesslocation1),TRIM((SALT311.StrType)le.businesstype2),TRIM((SALT311.StrType)le.businesslocation2),TRIM((SALT311.StrType)le.businesstype3),TRIM((SALT311.StrType)le.businesslocation3),TRIM((SALT311.StrType)le.businesstype4),TRIM((SALT311.StrType)le.businesslocation4),TRIM((SALT311.StrType)le.businesstype5),TRIM((SALT311.StrType)le.businesslocation5),TRIM((SALT311.StrType)le.industry),TRIM((SALT311.StrType)le.trade),TRIM((SALT311.StrType)le.resourcedescription),TRIM((SALT311.StrType)le.natureofbusiness),TRIM((SALT311.StrType)le.businessstructure),TRIM((SALT311.StrType)le.totalemployees),TRIM((SALT311.StrType)le.avgcontractsize),TRIM((SALT311.StrType)le.firmid),TRIM((SALT311.StrType)le.firmlocationaddress),TRIM((SALT311.StrType)le.firmlocationaddresscity),TRIM((SALT311.StrType)le.firmlocationaddresszip4),TRIM((SALT311.StrType)le.firmlocationaddresszipcode),TRIM((SALT311.StrType)le.firmlocationcounty),TRIM((SALT311.StrType)le.firmlocationstate),TRIM((SALT311.StrType)le.certfed),TRIM((SALT311.StrType)le.certstate),TRIM((SALT311.StrType)le.contractsfederal),TRIM((SALT311.StrType)le.contractsva),TRIM((SALT311.StrType)le.contractscommercial),TRIM((SALT311.StrType)le.contractorgovernmentprime),TRIM((SALT311.StrType)le.contractorgovernmentsub),TRIM((SALT311.StrType)le.contractornongovernment),TRIM((SALT311.StrType)le.registeredgovernmentbus),TRIM((SALT311.StrType)le.registerednongovernmentbus),TRIM((SALT311.StrType)le.clearancelevelpersonnel),TRIM((SALT311.StrType)le.clearancelevelfacility),TRIM((SALT311.StrType)le.certificatedatefrom1),TRIM((SALT311.StrType)le.certificatedateto1),TRIM((SALT311.StrType)le.certificatestatus1),TRIM((SALT311.StrType)le.certificationnumber1),TRIM((SALT311.StrType)le.certificationtype1),TRIM((SALT311.StrType)le.certificatedatefrom2),TRIM((SALT311.StrType)le.certificatedateto2),TRIM((SALT311.StrType)le.certificatestatus2),TRIM((SALT311.StrType)le.certificationnumber2),TRIM((SALT311.StrType)le.certificationtype2),TRIM((SALT311.StrType)le.certificatedatefrom3),TRIM((SALT311.StrType)le.certificatedateto3),TRIM((SALT311.StrType)le.certificatestatus3),TRIM((SALT311.StrType)le.certificationnumber3),TRIM((SALT311.StrType)le.certificationtype3),TRIM((SALT311.StrType)le.certificatedatefrom4),TRIM((SALT311.StrType)le.certificatedateto4),TRIM((SALT311.StrType)le.certificatestatus4),TRIM((SALT311.StrType)le.certificationnumber4),TRIM((SALT311.StrType)le.certificationtype4),TRIM((SALT311.StrType)le.certificatedatefrom5),TRIM((SALT311.StrType)le.certificatedateto5),TRIM((SALT311.StrType)le.certificatestatus5),TRIM((SALT311.StrType)le.certificationnumber5),TRIM((SALT311.StrType)le.certificationtype5),TRIM((SALT311.StrType)le.certificatedatefrom6),TRIM((SALT311.StrType)le.certificatedateto6),TRIM((SALT311.StrType)le.certificatestatus6),TRIM((SALT311.StrType)le.certificationnumber6),TRIM((SALT311.StrType)le.certificationtype6),TRIM((SALT311.StrType)le.starrating),TRIM((SALT311.StrType)le.assets),TRIM((SALT311.StrType)le.biddescription),TRIM((SALT311.StrType)le.competitiveadvantage),TRIM((SALT311.StrType)le.cagecode),TRIM((SALT311.StrType)le.capabilitiesnarrative),TRIM((SALT311.StrType)le.category),TRIM((SALT311.StrType)le.chtrclass),TRIM((SALT311.StrType)le.productdescription1),TRIM((SALT311.StrType)le.productdescription2),TRIM((SALT311.StrType)le.productdescription3),TRIM((SALT311.StrType)le.productdescription4),TRIM((SALT311.StrType)le.productdescription5),TRIM((SALT311.StrType)le.classdescription1),TRIM((SALT311.StrType)le.subclassdescription1),TRIM((SALT311.StrType)le.classdescription2),TRIM((SALT311.StrType)le.subclassdescription2),TRIM((SALT311.StrType)le.classdescription3),TRIM((SALT311.StrType)le.subclassdescription3),TRIM((SALT311.StrType)le.classdescription4),TRIM((SALT311.StrType)le.subclassdescription4),TRIM((SALT311.StrType)le.classdescription5),TRIM((SALT311.StrType)le.subclassdescription5),TRIM((SALT311.StrType)le.classifications),TRIM((SALT311.StrType)le.commodity1),TRIM((SALT311.StrType)le.commodity2),TRIM((SALT311.StrType)le.commodity3),TRIM((SALT311.StrType)le.commodity4),TRIM((SALT311.StrType)le.commodity5),TRIM((SALT311.StrType)le.commodity6),TRIM((SALT311.StrType)le.commodity7),TRIM((SALT311.StrType)le.commodity8),TRIM((SALT311.StrType)le.completedate),TRIM((SALT311.StrType)le.crossreference),TRIM((SALT311.StrType)le.dateestablished),TRIM((SALT311.StrType)le.businessage),TRIM((SALT311.StrType)le.deposits),TRIM((SALT311.StrType)le.dunsnumber),TRIM((SALT311.StrType)le.enttype),TRIM((SALT311.StrType)le.expirationdate),TRIM((SALT311.StrType)le.extendeddate),TRIM((SALT311.StrType)le.issuingauthority),TRIM((SALT311.StrType)le.keywords),TRIM((SALT311.StrType)le.licensenumber),TRIM((SALT311.StrType)le.licensetype),TRIM((SALT311.StrType)le.mincd),TRIM((SALT311.StrType)le.minorityaffiliation),TRIM((SALT311.StrType)le.minorityownershipdate),TRIM((SALT311.StrType)le.siccode1),TRIM((SALT311.StrType)le.siccode2),TRIM((SALT311.StrType)le.siccode3),TRIM((SALT311.StrType)le.siccode4),TRIM((SALT311.StrType)le.siccode5),TRIM((SALT311.StrType)le.siccode6),TRIM((SALT311.StrType)le.siccode7),TRIM((SALT311.StrType)le.siccode8),TRIM((SALT311.StrType)le.naicscode1),TRIM((SALT311.StrType)le.naicscode2),TRIM((SALT311.StrType)le.naicscode3),TRIM((SALT311.StrType)le.naicscode4),TRIM((SALT311.StrType)le.naicscode5),TRIM((SALT311.StrType)le.naicscode6),TRIM((SALT311.StrType)le.naicscode7),TRIM((SALT311.StrType)le.naicscode8),TRIM((SALT311.StrType)le.prequalify),TRIM((SALT311.StrType)le.procurementcategory1),TRIM((SALT311.StrType)le.subprocurementcategory1),TRIM((SALT311.StrType)le.procurementcategory2),TRIM((SALT311.StrType)le.subprocurementcategory2),TRIM((SALT311.StrType)le.procurementcategory3),TRIM((SALT311.StrType)le.subprocurementcategory3),TRIM((SALT311.StrType)le.procurementcategory4),TRIM((SALT311.StrType)le.subprocurementcategory4),TRIM((SALT311.StrType)le.procurementcategory5),TRIM((SALT311.StrType)le.subprocurementcategory5),TRIM((SALT311.StrType)le.renewal),TRIM((SALT311.StrType)le.renewaldate),TRIM((SALT311.StrType)le.unitedcertprogrampartner),TRIM((SALT311.StrType)le.vendorkey),TRIM((SALT311.StrType)le.vendornumber),TRIM((SALT311.StrType)le.workcode1),TRIM((SALT311.StrType)le.workcode2),TRIM((SALT311.StrType)le.workcode3),TRIM((SALT311.StrType)le.workcode4),TRIM((SALT311.StrType)le.workcode5),TRIM((SALT311.StrType)le.workcode6),TRIM((SALT311.StrType)le.workcode7),TRIM((SALT311.StrType)le.workcode8),TRIM((SALT311.StrType)le.exporter),TRIM((SALT311.StrType)le.exportbusinessactivities),TRIM((SALT311.StrType)le.exportto),TRIM((SALT311.StrType)le.exportbusinessrelationships),TRIM((SALT311.StrType)le.exportobjectives),TRIM((SALT311.StrType)le.reference1),TRIM((SALT311.StrType)le.reference2),TRIM((SALT311.StrType)le.reference3)));
  SELF.FldNo := C;
END;
SHARED FldInv0 := NORMALIZE(h,204,Into(LEFT,COUNTER));
// Move everything into 'pairs' form so processing can be done 'in library'
SALT311.MAC_Correlate.Data_Layout IntoP(h le,UNSIGNED C) := TRANSFORM
  SELF.FldNo1 := 1 + (C / 204);
  SELF.FldNo2 := 1 + (C % 204);
  SELF.Fld1 := TRIM(CHOOSE(SELF.FldNo1,TRIM((SALT311.StrType)le.dartid),TRIM((SALT311.StrType)le.dateadded),TRIM((SALT311.StrType)le.dateupdated),TRIM((SALT311.StrType)le.website),TRIM((SALT311.StrType)le.state),TRIM((SALT311.StrType)le.profilelastupdated),TRIM((SALT311.StrType)le.county),TRIM((SALT311.StrType)le.servicearea),TRIM((SALT311.StrType)le.region1),TRIM((SALT311.StrType)le.region2),TRIM((SALT311.StrType)le.region3),TRIM((SALT311.StrType)le.region4),TRIM((SALT311.StrType)le.region5),TRIM((SALT311.StrType)le.fname),TRIM((SALT311.StrType)le.lname),TRIM((SALT311.StrType)le.mname),TRIM((SALT311.StrType)le.suffix),TRIM((SALT311.StrType)le.title),TRIM((SALT311.StrType)le.ethnicity),TRIM((SALT311.StrType)le.gender),TRIM((SALT311.StrType)le.address1),TRIM((SALT311.StrType)le.address2),TRIM((SALT311.StrType)le.addresscity),TRIM((SALT311.StrType)le.addressstate),TRIM((SALT311.StrType)le.addresszipcode),TRIM((SALT311.StrType)le.addresszip4),TRIM((SALT311.StrType)le.building),TRIM((SALT311.StrType)le.contact),TRIM((SALT311.StrType)le.phone1),TRIM((SALT311.StrType)le.phone2),TRIM((SALT311.StrType)le.phone3),TRIM((SALT311.StrType)le.cell),TRIM((SALT311.StrType)le.fax),TRIM((SALT311.StrType)le.email1),TRIM((SALT311.StrType)le.email2),TRIM((SALT311.StrType)le.email3),TRIM((SALT311.StrType)le.webpage1),TRIM((SALT311.StrType)le.webpage2),TRIM((SALT311.StrType)le.webpage3),TRIM((SALT311.StrType)le.businessname),TRIM((SALT311.StrType)le.dba),TRIM((SALT311.StrType)le.businessid),TRIM((SALT311.StrType)le.businesstype1),TRIM((SALT311.StrType)le.businesslocation1),TRIM((SALT311.StrType)le.businesstype2),TRIM((SALT311.StrType)le.businesslocation2),TRIM((SALT311.StrType)le.businesstype3),TRIM((SALT311.StrType)le.businesslocation3),TRIM((SALT311.StrType)le.businesstype4),TRIM((SALT311.StrType)le.businesslocation4),TRIM((SALT311.StrType)le.businesstype5),TRIM((SALT311.StrType)le.businesslocation5),TRIM((SALT311.StrType)le.industry),TRIM((SALT311.StrType)le.trade),TRIM((SALT311.StrType)le.resourcedescription),TRIM((SALT311.StrType)le.natureofbusiness),TRIM((SALT311.StrType)le.businessstructure),TRIM((SALT311.StrType)le.totalemployees),TRIM((SALT311.StrType)le.avgcontractsize),TRIM((SALT311.StrType)le.firmid),TRIM((SALT311.StrType)le.firmlocationaddress),TRIM((SALT311.StrType)le.firmlocationaddresscity),TRIM((SALT311.StrType)le.firmlocationaddresszip4),TRIM((SALT311.StrType)le.firmlocationaddresszipcode),TRIM((SALT311.StrType)le.firmlocationcounty),TRIM((SALT311.StrType)le.firmlocationstate),TRIM((SALT311.StrType)le.certfed),TRIM((SALT311.StrType)le.certstate),TRIM((SALT311.StrType)le.contractsfederal),TRIM((SALT311.StrType)le.contractsva),TRIM((SALT311.StrType)le.contractscommercial),TRIM((SALT311.StrType)le.contractorgovernmentprime),TRIM((SALT311.StrType)le.contractorgovernmentsub),TRIM((SALT311.StrType)le.contractornongovernment),TRIM((SALT311.StrType)le.registeredgovernmentbus),TRIM((SALT311.StrType)le.registerednongovernmentbus),TRIM((SALT311.StrType)le.clearancelevelpersonnel),TRIM((SALT311.StrType)le.clearancelevelfacility),TRIM((SALT311.StrType)le.certificatedatefrom1),TRIM((SALT311.StrType)le.certificatedateto1),TRIM((SALT311.StrType)le.certificatestatus1),TRIM((SALT311.StrType)le.certificationnumber1),TRIM((SALT311.StrType)le.certificationtype1),TRIM((SALT311.StrType)le.certificatedatefrom2),TRIM((SALT311.StrType)le.certificatedateto2),TRIM((SALT311.StrType)le.certificatestatus2),TRIM((SALT311.StrType)le.certificationnumber2),TRIM((SALT311.StrType)le.certificationtype2),TRIM((SALT311.StrType)le.certificatedatefrom3),TRIM((SALT311.StrType)le.certificatedateto3),TRIM((SALT311.StrType)le.certificatestatus3),TRIM((SALT311.StrType)le.certificationnumber3),TRIM((SALT311.StrType)le.certificationtype3),TRIM((SALT311.StrType)le.certificatedatefrom4),TRIM((SALT311.StrType)le.certificatedateto4),TRIM((SALT311.StrType)le.certificatestatus4),TRIM((SALT311.StrType)le.certificationnumber4),TRIM((SALT311.StrType)le.certificationtype4),TRIM((SALT311.StrType)le.certificatedatefrom5),TRIM((SALT311.StrType)le.certificatedateto5),TRIM((SALT311.StrType)le.certificatestatus5),TRIM((SALT311.StrType)le.certificationnumber5),TRIM((SALT311.StrType)le.certificationtype5),TRIM((SALT311.StrType)le.certificatedatefrom6),TRIM((SALT311.StrType)le.certificatedateto6),TRIM((SALT311.StrType)le.certificatestatus6),TRIM((SALT311.StrType)le.certificationnumber6),TRIM((SALT311.StrType)le.certificationtype6),TRIM((SALT311.StrType)le.starrating),TRIM((SALT311.StrType)le.assets),TRIM((SALT311.StrType)le.biddescription),TRIM((SALT311.StrType)le.competitiveadvantage),TRIM((SALT311.StrType)le.cagecode),TRIM((SALT311.StrType)le.capabilitiesnarrative),TRIM((SALT311.StrType)le.category),TRIM((SALT311.StrType)le.chtrclass),TRIM((SALT311.StrType)le.productdescription1),TRIM((SALT311.StrType)le.productdescription2),TRIM((SALT311.StrType)le.productdescription3),TRIM((SALT311.StrType)le.productdescription4),TRIM((SALT311.StrType)le.productdescription5),TRIM((SALT311.StrType)le.classdescription1),TRIM((SALT311.StrType)le.subclassdescription1),TRIM((SALT311.StrType)le.classdescription2),TRIM((SALT311.StrType)le.subclassdescription2),TRIM((SALT311.StrType)le.classdescription3),TRIM((SALT311.StrType)le.subclassdescription3),TRIM((SALT311.StrType)le.classdescription4),TRIM((SALT311.StrType)le.subclassdescription4),TRIM((SALT311.StrType)le.classdescription5),TRIM((SALT311.StrType)le.subclassdescription5),TRIM((SALT311.StrType)le.classifications),TRIM((SALT311.StrType)le.commodity1),TRIM((SALT311.StrType)le.commodity2),TRIM((SALT311.StrType)le.commodity3),TRIM((SALT311.StrType)le.commodity4),TRIM((SALT311.StrType)le.commodity5),TRIM((SALT311.StrType)le.commodity6),TRIM((SALT311.StrType)le.commodity7),TRIM((SALT311.StrType)le.commodity8),TRIM((SALT311.StrType)le.completedate),TRIM((SALT311.StrType)le.crossreference),TRIM((SALT311.StrType)le.dateestablished),TRIM((SALT311.StrType)le.businessage),TRIM((SALT311.StrType)le.deposits),TRIM((SALT311.StrType)le.dunsnumber),TRIM((SALT311.StrType)le.enttype),TRIM((SALT311.StrType)le.expirationdate),TRIM((SALT311.StrType)le.extendeddate),TRIM((SALT311.StrType)le.issuingauthority),TRIM((SALT311.StrType)le.keywords),TRIM((SALT311.StrType)le.licensenumber),TRIM((SALT311.StrType)le.licensetype),TRIM((SALT311.StrType)le.mincd),TRIM((SALT311.StrType)le.minorityaffiliation),TRIM((SALT311.StrType)le.minorityownershipdate),TRIM((SALT311.StrType)le.siccode1),TRIM((SALT311.StrType)le.siccode2),TRIM((SALT311.StrType)le.siccode3),TRIM((SALT311.StrType)le.siccode4),TRIM((SALT311.StrType)le.siccode5),TRIM((SALT311.StrType)le.siccode6),TRIM((SALT311.StrType)le.siccode7),TRIM((SALT311.StrType)le.siccode8),TRIM((SALT311.StrType)le.naicscode1),TRIM((SALT311.StrType)le.naicscode2),TRIM((SALT311.StrType)le.naicscode3),TRIM((SALT311.StrType)le.naicscode4),TRIM((SALT311.StrType)le.naicscode5),TRIM((SALT311.StrType)le.naicscode6),TRIM((SALT311.StrType)le.naicscode7),TRIM((SALT311.StrType)le.naicscode8),TRIM((SALT311.StrType)le.prequalify),TRIM((SALT311.StrType)le.procurementcategory1),TRIM((SALT311.StrType)le.subprocurementcategory1),TRIM((SALT311.StrType)le.procurementcategory2),TRIM((SALT311.StrType)le.subprocurementcategory2),TRIM((SALT311.StrType)le.procurementcategory3),TRIM((SALT311.StrType)le.subprocurementcategory3),TRIM((SALT311.StrType)le.procurementcategory4),TRIM((SALT311.StrType)le.subprocurementcategory4),TRIM((SALT311.StrType)le.procurementcategory5),TRIM((SALT311.StrType)le.subprocurementcategory5),TRIM((SALT311.StrType)le.renewal),TRIM((SALT311.StrType)le.renewaldate),TRIM((SALT311.StrType)le.unitedcertprogrampartner),TRIM((SALT311.StrType)le.vendorkey),TRIM((SALT311.StrType)le.vendornumber),TRIM((SALT311.StrType)le.workcode1),TRIM((SALT311.StrType)le.workcode2),TRIM((SALT311.StrType)le.workcode3),TRIM((SALT311.StrType)le.workcode4),TRIM((SALT311.StrType)le.workcode5),TRIM((SALT311.StrType)le.workcode6),TRIM((SALT311.StrType)le.workcode7),TRIM((SALT311.StrType)le.workcode8),TRIM((SALT311.StrType)le.exporter),TRIM((SALT311.StrType)le.exportbusinessactivities),TRIM((SALT311.StrType)le.exportto),TRIM((SALT311.StrType)le.exportbusinessrelationships),TRIM((SALT311.StrType)le.exportobjectives),TRIM((SALT311.StrType)le.reference1),TRIM((SALT311.StrType)le.reference2),TRIM((SALT311.StrType)le.reference3)));
  SELF.Fld2 := TRIM(CHOOSE(SELF.FldNo2,TRIM((SALT311.StrType)le.dartid),TRIM((SALT311.StrType)le.dateadded),TRIM((SALT311.StrType)le.dateupdated),TRIM((SALT311.StrType)le.website),TRIM((SALT311.StrType)le.state),TRIM((SALT311.StrType)le.profilelastupdated),TRIM((SALT311.StrType)le.county),TRIM((SALT311.StrType)le.servicearea),TRIM((SALT311.StrType)le.region1),TRIM((SALT311.StrType)le.region2),TRIM((SALT311.StrType)le.region3),TRIM((SALT311.StrType)le.region4),TRIM((SALT311.StrType)le.region5),TRIM((SALT311.StrType)le.fname),TRIM((SALT311.StrType)le.lname),TRIM((SALT311.StrType)le.mname),TRIM((SALT311.StrType)le.suffix),TRIM((SALT311.StrType)le.title),TRIM((SALT311.StrType)le.ethnicity),TRIM((SALT311.StrType)le.gender),TRIM((SALT311.StrType)le.address1),TRIM((SALT311.StrType)le.address2),TRIM((SALT311.StrType)le.addresscity),TRIM((SALT311.StrType)le.addressstate),TRIM((SALT311.StrType)le.addresszipcode),TRIM((SALT311.StrType)le.addresszip4),TRIM((SALT311.StrType)le.building),TRIM((SALT311.StrType)le.contact),TRIM((SALT311.StrType)le.phone1),TRIM((SALT311.StrType)le.phone2),TRIM((SALT311.StrType)le.phone3),TRIM((SALT311.StrType)le.cell),TRIM((SALT311.StrType)le.fax),TRIM((SALT311.StrType)le.email1),TRIM((SALT311.StrType)le.email2),TRIM((SALT311.StrType)le.email3),TRIM((SALT311.StrType)le.webpage1),TRIM((SALT311.StrType)le.webpage2),TRIM((SALT311.StrType)le.webpage3),TRIM((SALT311.StrType)le.businessname),TRIM((SALT311.StrType)le.dba),TRIM((SALT311.StrType)le.businessid),TRIM((SALT311.StrType)le.businesstype1),TRIM((SALT311.StrType)le.businesslocation1),TRIM((SALT311.StrType)le.businesstype2),TRIM((SALT311.StrType)le.businesslocation2),TRIM((SALT311.StrType)le.businesstype3),TRIM((SALT311.StrType)le.businesslocation3),TRIM((SALT311.StrType)le.businesstype4),TRIM((SALT311.StrType)le.businesslocation4),TRIM((SALT311.StrType)le.businesstype5),TRIM((SALT311.StrType)le.businesslocation5),TRIM((SALT311.StrType)le.industry),TRIM((SALT311.StrType)le.trade),TRIM((SALT311.StrType)le.resourcedescription),TRIM((SALT311.StrType)le.natureofbusiness),TRIM((SALT311.StrType)le.businessstructure),TRIM((SALT311.StrType)le.totalemployees),TRIM((SALT311.StrType)le.avgcontractsize),TRIM((SALT311.StrType)le.firmid),TRIM((SALT311.StrType)le.firmlocationaddress),TRIM((SALT311.StrType)le.firmlocationaddresscity),TRIM((SALT311.StrType)le.firmlocationaddresszip4),TRIM((SALT311.StrType)le.firmlocationaddresszipcode),TRIM((SALT311.StrType)le.firmlocationcounty),TRIM((SALT311.StrType)le.firmlocationstate),TRIM((SALT311.StrType)le.certfed),TRIM((SALT311.StrType)le.certstate),TRIM((SALT311.StrType)le.contractsfederal),TRIM((SALT311.StrType)le.contractsva),TRIM((SALT311.StrType)le.contractscommercial),TRIM((SALT311.StrType)le.contractorgovernmentprime),TRIM((SALT311.StrType)le.contractorgovernmentsub),TRIM((SALT311.StrType)le.contractornongovernment),TRIM((SALT311.StrType)le.registeredgovernmentbus),TRIM((SALT311.StrType)le.registerednongovernmentbus),TRIM((SALT311.StrType)le.clearancelevelpersonnel),TRIM((SALT311.StrType)le.clearancelevelfacility),TRIM((SALT311.StrType)le.certificatedatefrom1),TRIM((SALT311.StrType)le.certificatedateto1),TRIM((SALT311.StrType)le.certificatestatus1),TRIM((SALT311.StrType)le.certificationnumber1),TRIM((SALT311.StrType)le.certificationtype1),TRIM((SALT311.StrType)le.certificatedatefrom2),TRIM((SALT311.StrType)le.certificatedateto2),TRIM((SALT311.StrType)le.certificatestatus2),TRIM((SALT311.StrType)le.certificationnumber2),TRIM((SALT311.StrType)le.certificationtype2),TRIM((SALT311.StrType)le.certificatedatefrom3),TRIM((SALT311.StrType)le.certificatedateto3),TRIM((SALT311.StrType)le.certificatestatus3),TRIM((SALT311.StrType)le.certificationnumber3),TRIM((SALT311.StrType)le.certificationtype3),TRIM((SALT311.StrType)le.certificatedatefrom4),TRIM((SALT311.StrType)le.certificatedateto4),TRIM((SALT311.StrType)le.certificatestatus4),TRIM((SALT311.StrType)le.certificationnumber4),TRIM((SALT311.StrType)le.certificationtype4),TRIM((SALT311.StrType)le.certificatedatefrom5),TRIM((SALT311.StrType)le.certificatedateto5),TRIM((SALT311.StrType)le.certificatestatus5),TRIM((SALT311.StrType)le.certificationnumber5),TRIM((SALT311.StrType)le.certificationtype5),TRIM((SALT311.StrType)le.certificatedatefrom6),TRIM((SALT311.StrType)le.certificatedateto6),TRIM((SALT311.StrType)le.certificatestatus6),TRIM((SALT311.StrType)le.certificationnumber6),TRIM((SALT311.StrType)le.certificationtype6),TRIM((SALT311.StrType)le.starrating),TRIM((SALT311.StrType)le.assets),TRIM((SALT311.StrType)le.biddescription),TRIM((SALT311.StrType)le.competitiveadvantage),TRIM((SALT311.StrType)le.cagecode),TRIM((SALT311.StrType)le.capabilitiesnarrative),TRIM((SALT311.StrType)le.category),TRIM((SALT311.StrType)le.chtrclass),TRIM((SALT311.StrType)le.productdescription1),TRIM((SALT311.StrType)le.productdescription2),TRIM((SALT311.StrType)le.productdescription3),TRIM((SALT311.StrType)le.productdescription4),TRIM((SALT311.StrType)le.productdescription5),TRIM((SALT311.StrType)le.classdescription1),TRIM((SALT311.StrType)le.subclassdescription1),TRIM((SALT311.StrType)le.classdescription2),TRIM((SALT311.StrType)le.subclassdescription2),TRIM((SALT311.StrType)le.classdescription3),TRIM((SALT311.StrType)le.subclassdescription3),TRIM((SALT311.StrType)le.classdescription4),TRIM((SALT311.StrType)le.subclassdescription4),TRIM((SALT311.StrType)le.classdescription5),TRIM((SALT311.StrType)le.subclassdescription5),TRIM((SALT311.StrType)le.classifications),TRIM((SALT311.StrType)le.commodity1),TRIM((SALT311.StrType)le.commodity2),TRIM((SALT311.StrType)le.commodity3),TRIM((SALT311.StrType)le.commodity4),TRIM((SALT311.StrType)le.commodity5),TRIM((SALT311.StrType)le.commodity6),TRIM((SALT311.StrType)le.commodity7),TRIM((SALT311.StrType)le.commodity8),TRIM((SALT311.StrType)le.completedate),TRIM((SALT311.StrType)le.crossreference),TRIM((SALT311.StrType)le.dateestablished),TRIM((SALT311.StrType)le.businessage),TRIM((SALT311.StrType)le.deposits),TRIM((SALT311.StrType)le.dunsnumber),TRIM((SALT311.StrType)le.enttype),TRIM((SALT311.StrType)le.expirationdate),TRIM((SALT311.StrType)le.extendeddate),TRIM((SALT311.StrType)le.issuingauthority),TRIM((SALT311.StrType)le.keywords),TRIM((SALT311.StrType)le.licensenumber),TRIM((SALT311.StrType)le.licensetype),TRIM((SALT311.StrType)le.mincd),TRIM((SALT311.StrType)le.minorityaffiliation),TRIM((SALT311.StrType)le.minorityownershipdate),TRIM((SALT311.StrType)le.siccode1),TRIM((SALT311.StrType)le.siccode2),TRIM((SALT311.StrType)le.siccode3),TRIM((SALT311.StrType)le.siccode4),TRIM((SALT311.StrType)le.siccode5),TRIM((SALT311.StrType)le.siccode6),TRIM((SALT311.StrType)le.siccode7),TRIM((SALT311.StrType)le.siccode8),TRIM((SALT311.StrType)le.naicscode1),TRIM((SALT311.StrType)le.naicscode2),TRIM((SALT311.StrType)le.naicscode3),TRIM((SALT311.StrType)le.naicscode4),TRIM((SALT311.StrType)le.naicscode5),TRIM((SALT311.StrType)le.naicscode6),TRIM((SALT311.StrType)le.naicscode7),TRIM((SALT311.StrType)le.naicscode8),TRIM((SALT311.StrType)le.prequalify),TRIM((SALT311.StrType)le.procurementcategory1),TRIM((SALT311.StrType)le.subprocurementcategory1),TRIM((SALT311.StrType)le.procurementcategory2),TRIM((SALT311.StrType)le.subprocurementcategory2),TRIM((SALT311.StrType)le.procurementcategory3),TRIM((SALT311.StrType)le.subprocurementcategory3),TRIM((SALT311.StrType)le.procurementcategory4),TRIM((SALT311.StrType)le.subprocurementcategory4),TRIM((SALT311.StrType)le.procurementcategory5),TRIM((SALT311.StrType)le.subprocurementcategory5),TRIM((SALT311.StrType)le.renewal),TRIM((SALT311.StrType)le.renewaldate),TRIM((SALT311.StrType)le.unitedcertprogrampartner),TRIM((SALT311.StrType)le.vendorkey),TRIM((SALT311.StrType)le.vendornumber),TRIM((SALT311.StrType)le.workcode1),TRIM((SALT311.StrType)le.workcode2),TRIM((SALT311.StrType)le.workcode3),TRIM((SALT311.StrType)le.workcode4),TRIM((SALT311.StrType)le.workcode5),TRIM((SALT311.StrType)le.workcode6),TRIM((SALT311.StrType)le.workcode7),TRIM((SALT311.StrType)le.workcode8),TRIM((SALT311.StrType)le.exporter),TRIM((SALT311.StrType)le.exportbusinessactivities),TRIM((SALT311.StrType)le.exportto),TRIM((SALT311.StrType)le.exportbusinessrelationships),TRIM((SALT311.StrType)le.exportobjectives),TRIM((SALT311.StrType)le.reference1),TRIM((SALT311.StrType)le.reference2),TRIM((SALT311.StrType)le.reference3)));
  END;
SHARED Pairs0 := NORMALIZE(ENTH(h,Config.CorrelateSampleSize),204*204,IntoP(LEFT,COUNTER))(FldNo1<FldNo2);
SHARED FldIds := DATASET([{1,'dartid'}
      ,{2,'dateadded'}
      ,{3,'dateupdated'}
      ,{4,'website'}
      ,{5,'state'}
      ,{6,'profilelastupdated'}
      ,{7,'county'}
      ,{8,'servicearea'}
      ,{9,'region1'}
      ,{10,'region2'}
      ,{11,'region3'}
      ,{12,'region4'}
      ,{13,'region5'}
      ,{14,'fname'}
      ,{15,'lname'}
      ,{16,'mname'}
      ,{17,'suffix'}
      ,{18,'title'}
      ,{19,'ethnicity'}
      ,{20,'gender'}
      ,{21,'address1'}
      ,{22,'address2'}
      ,{23,'addresscity'}
      ,{24,'addressstate'}
      ,{25,'addresszipcode'}
      ,{26,'addresszip4'}
      ,{27,'building'}
      ,{28,'contact'}
      ,{29,'phone1'}
      ,{30,'phone2'}
      ,{31,'phone3'}
      ,{32,'cell'}
      ,{33,'fax'}
      ,{34,'email1'}
      ,{35,'email2'}
      ,{36,'email3'}
      ,{37,'webpage1'}
      ,{38,'webpage2'}
      ,{39,'webpage3'}
      ,{40,'businessname'}
      ,{41,'dba'}
      ,{42,'businessid'}
      ,{43,'businesstype1'}
      ,{44,'businesslocation1'}
      ,{45,'businesstype2'}
      ,{46,'businesslocation2'}
      ,{47,'businesstype3'}
      ,{48,'businesslocation3'}
      ,{49,'businesstype4'}
      ,{50,'businesslocation4'}
      ,{51,'businesstype5'}
      ,{52,'businesslocation5'}
      ,{53,'industry'}
      ,{54,'trade'}
      ,{55,'resourcedescription'}
      ,{56,'natureofbusiness'}
      ,{57,'businessstructure'}
      ,{58,'totalemployees'}
      ,{59,'avgcontractsize'}
      ,{60,'firmid'}
      ,{61,'firmlocationaddress'}
      ,{62,'firmlocationaddresscity'}
      ,{63,'firmlocationaddresszip4'}
      ,{64,'firmlocationaddresszipcode'}
      ,{65,'firmlocationcounty'}
      ,{66,'firmlocationstate'}
      ,{67,'certfed'}
      ,{68,'certstate'}
      ,{69,'contractsfederal'}
      ,{70,'contractsva'}
      ,{71,'contractscommercial'}
      ,{72,'contractorgovernmentprime'}
      ,{73,'contractorgovernmentsub'}
      ,{74,'contractornongovernment'}
      ,{75,'registeredgovernmentbus'}
      ,{76,'registerednongovernmentbus'}
      ,{77,'clearancelevelpersonnel'}
      ,{78,'clearancelevelfacility'}
      ,{79,'certificatedatefrom1'}
      ,{80,'certificatedateto1'}
      ,{81,'certificatestatus1'}
      ,{82,'certificationnumber1'}
      ,{83,'certificationtype1'}
      ,{84,'certificatedatefrom2'}
      ,{85,'certificatedateto2'}
      ,{86,'certificatestatus2'}
      ,{87,'certificationnumber2'}
      ,{88,'certificationtype2'}
      ,{89,'certificatedatefrom3'}
      ,{90,'certificatedateto3'}
      ,{91,'certificatestatus3'}
      ,{92,'certificationnumber3'}
      ,{93,'certificationtype3'}
      ,{94,'certificatedatefrom4'}
      ,{95,'certificatedateto4'}
      ,{96,'certificatestatus4'}
      ,{97,'certificationnumber4'}
      ,{98,'certificationtype4'}
      ,{99,'certificatedatefrom5'}
      ,{100,'certificatedateto5'}
      ,{101,'certificatestatus5'}
      ,{102,'certificationnumber5'}
      ,{103,'certificationtype5'}
      ,{104,'certificatedatefrom6'}
      ,{105,'certificatedateto6'}
      ,{106,'certificatestatus6'}
      ,{107,'certificationnumber6'}
      ,{108,'certificationtype6'}
      ,{109,'starrating'}
      ,{110,'assets'}
      ,{111,'biddescription'}
      ,{112,'competitiveadvantage'}
      ,{113,'cagecode'}
      ,{114,'capabilitiesnarrative'}
      ,{115,'category'}
      ,{116,'chtrclass'}
      ,{117,'productdescription1'}
      ,{118,'productdescription2'}
      ,{119,'productdescription3'}
      ,{120,'productdescription4'}
      ,{121,'productdescription5'}
      ,{122,'classdescription1'}
      ,{123,'subclassdescription1'}
      ,{124,'classdescription2'}
      ,{125,'subclassdescription2'}
      ,{126,'classdescription3'}
      ,{127,'subclassdescription3'}
      ,{128,'classdescription4'}
      ,{129,'subclassdescription4'}
      ,{130,'classdescription5'}
      ,{131,'subclassdescription5'}
      ,{132,'classifications'}
      ,{133,'commodity1'}
      ,{134,'commodity2'}
      ,{135,'commodity3'}
      ,{136,'commodity4'}
      ,{137,'commodity5'}
      ,{138,'commodity6'}
      ,{139,'commodity7'}
      ,{140,'commodity8'}
      ,{141,'completedate'}
      ,{142,'crossreference'}
      ,{143,'dateestablished'}
      ,{144,'businessage'}
      ,{145,'deposits'}
      ,{146,'dunsnumber'}
      ,{147,'enttype'}
      ,{148,'expirationdate'}
      ,{149,'extendeddate'}
      ,{150,'issuingauthority'}
      ,{151,'keywords'}
      ,{152,'licensenumber'}
      ,{153,'licensetype'}
      ,{154,'mincd'}
      ,{155,'minorityaffiliation'}
      ,{156,'minorityownershipdate'}
      ,{157,'siccode1'}
      ,{158,'siccode2'}
      ,{159,'siccode3'}
      ,{160,'siccode4'}
      ,{161,'siccode5'}
      ,{162,'siccode6'}
      ,{163,'siccode7'}
      ,{164,'siccode8'}
      ,{165,'naicscode1'}
      ,{166,'naicscode2'}
      ,{167,'naicscode3'}
      ,{168,'naicscode4'}
      ,{169,'naicscode5'}
      ,{170,'naicscode6'}
      ,{171,'naicscode7'}
      ,{172,'naicscode8'}
      ,{173,'prequalify'}
      ,{174,'procurementcategory1'}
      ,{175,'subprocurementcategory1'}
      ,{176,'procurementcategory2'}
      ,{177,'subprocurementcategory2'}
      ,{178,'procurementcategory3'}
      ,{179,'subprocurementcategory3'}
      ,{180,'procurementcategory4'}
      ,{181,'subprocurementcategory4'}
      ,{182,'procurementcategory5'}
      ,{183,'subprocurementcategory5'}
      ,{184,'renewal'}
      ,{185,'renewaldate'}
      ,{186,'unitedcertprogrampartner'}
      ,{187,'vendorkey'}
      ,{188,'vendornumber'}
      ,{189,'workcode1'}
      ,{190,'workcode2'}
      ,{191,'workcode3'}
      ,{192,'workcode4'}
      ,{193,'workcode5'}
      ,{194,'workcode6'}
      ,{195,'workcode7'}
      ,{196,'workcode8'}
      ,{197,'exporter'}
      ,{198,'exportbusinessactivities'}
      ,{199,'exportto'}
      ,{200,'exportbusinessrelationships'}
      ,{201,'exportobjectives'}
      ,{202,'reference1'}
      ,{203,'reference2'}
      ,{204,'reference3'}],SALT311.MAC_Character_Counts.Field_Identification);
EXPORT AllProfiles := SALT311.MAC_Character_Counts.FN_Profile(FldInv0,FldIds);
 
EXPORT SrcProfiles := SALT311.MAC_Character_Counts.Src_Profile(FldInv0,FldIds);
 
EXPORT Correlations := SALT311.MAC_Correlate.Fn_Profile(Pairs0,FldIds);
 
ErrorRecord := RECORD
  UNSIGNED1 FieldNum;
  UNSIGNED1 ErrorNum;
END;
ErrorRecord NoteErrors(h le,UNSIGNED1 c) := TRANSFORM
  SELF.ErrorNum := CHOOSE(c,
    Input_Fields.InValid_dartid((SALT311.StrType)le.dartid),
    Input_Fields.InValid_dateadded((SALT311.StrType)le.dateadded),
    Input_Fields.InValid_dateupdated((SALT311.StrType)le.dateupdated),
    Input_Fields.InValid_website((SALT311.StrType)le.website),
    Input_Fields.InValid_state((SALT311.StrType)le.state),
    Input_Fields.InValid_profilelastupdated((SALT311.StrType)le.profilelastupdated),
    Input_Fields.InValid_county((SALT311.StrType)le.county),
    Input_Fields.InValid_servicearea((SALT311.StrType)le.servicearea),
    Input_Fields.InValid_region1((SALT311.StrType)le.region1),
    Input_Fields.InValid_region2((SALT311.StrType)le.region2),
    Input_Fields.InValid_region3((SALT311.StrType)le.region3),
    Input_Fields.InValid_region4((SALT311.StrType)le.region4),
    Input_Fields.InValid_region5((SALT311.StrType)le.region5),
    Input_Fields.InValid_fname((SALT311.StrType)le.fname),
    Input_Fields.InValid_lname((SALT311.StrType)le.lname),
    Input_Fields.InValid_mname((SALT311.StrType)le.mname),
    Input_Fields.InValid_suffix((SALT311.StrType)le.suffix),
    Input_Fields.InValid_title((SALT311.StrType)le.title),
    Input_Fields.InValid_ethnicity((SALT311.StrType)le.ethnicity),
    Input_Fields.InValid_gender((SALT311.StrType)le.gender),
    Input_Fields.InValid_address1((SALT311.StrType)le.address1),
    Input_Fields.InValid_address2((SALT311.StrType)le.address2),
    Input_Fields.InValid_addresscity((SALT311.StrType)le.addresscity),
    Input_Fields.InValid_addressstate((SALT311.StrType)le.addressstate),
    Input_Fields.InValid_addresszipcode((SALT311.StrType)le.addresszipcode),
    Input_Fields.InValid_addresszip4((SALT311.StrType)le.addresszip4),
    Input_Fields.InValid_building((SALT311.StrType)le.building),
    Input_Fields.InValid_contact((SALT311.StrType)le.contact),
    Input_Fields.InValid_phone1((SALT311.StrType)le.phone1),
    Input_Fields.InValid_phone2((SALT311.StrType)le.phone2),
    Input_Fields.InValid_phone3((SALT311.StrType)le.phone3),
    Input_Fields.InValid_cell((SALT311.StrType)le.cell),
    Input_Fields.InValid_fax((SALT311.StrType)le.fax),
    Input_Fields.InValid_email1((SALT311.StrType)le.email1),
    Input_Fields.InValid_email2((SALT311.StrType)le.email2),
    Input_Fields.InValid_email3((SALT311.StrType)le.email3),
    Input_Fields.InValid_webpage1((SALT311.StrType)le.webpage1),
    Input_Fields.InValid_webpage2((SALT311.StrType)le.webpage2),
    Input_Fields.InValid_webpage3((SALT311.StrType)le.webpage3),
    Input_Fields.InValid_businessname((SALT311.StrType)le.businessname),
    Input_Fields.InValid_dba((SALT311.StrType)le.dba),
    Input_Fields.InValid_businessid((SALT311.StrType)le.businessid),
    Input_Fields.InValid_businesstype1((SALT311.StrType)le.businesstype1),
    Input_Fields.InValid_businesslocation1((SALT311.StrType)le.businesslocation1),
    Input_Fields.InValid_businesstype2((SALT311.StrType)le.businesstype2),
    Input_Fields.InValid_businesslocation2((SALT311.StrType)le.businesslocation2),
    Input_Fields.InValid_businesstype3((SALT311.StrType)le.businesstype3),
    Input_Fields.InValid_businesslocation3((SALT311.StrType)le.businesslocation3),
    Input_Fields.InValid_businesstype4((SALT311.StrType)le.businesstype4),
    Input_Fields.InValid_businesslocation4((SALT311.StrType)le.businesslocation4),
    Input_Fields.InValid_businesstype5((SALT311.StrType)le.businesstype5),
    Input_Fields.InValid_businesslocation5((SALT311.StrType)le.businesslocation5),
    Input_Fields.InValid_industry((SALT311.StrType)le.industry),
    Input_Fields.InValid_trade((SALT311.StrType)le.trade),
    Input_Fields.InValid_resourcedescription((SALT311.StrType)le.resourcedescription),
    Input_Fields.InValid_natureofbusiness((SALT311.StrType)le.natureofbusiness),
    Input_Fields.InValid_businessstructure((SALT311.StrType)le.businessstructure),
    Input_Fields.InValid_totalemployees((SALT311.StrType)le.totalemployees),
    Input_Fields.InValid_avgcontractsize((SALT311.StrType)le.avgcontractsize),
    Input_Fields.InValid_firmid((SALT311.StrType)le.firmid),
    Input_Fields.InValid_firmlocationaddress((SALT311.StrType)le.firmlocationaddress),
    Input_Fields.InValid_firmlocationaddresscity((SALT311.StrType)le.firmlocationaddresscity),
    Input_Fields.InValid_firmlocationaddresszip4((SALT311.StrType)le.firmlocationaddresszip4),
    Input_Fields.InValid_firmlocationaddresszipcode((SALT311.StrType)le.firmlocationaddresszipcode),
    Input_Fields.InValid_firmlocationcounty((SALT311.StrType)le.firmlocationcounty),
    Input_Fields.InValid_firmlocationstate((SALT311.StrType)le.firmlocationstate),
    Input_Fields.InValid_certfed((SALT311.StrType)le.certfed),
    Input_Fields.InValid_certstate((SALT311.StrType)le.certstate),
    Input_Fields.InValid_contractsfederal((SALT311.StrType)le.contractsfederal),
    Input_Fields.InValid_contractsva((SALT311.StrType)le.contractsva),
    Input_Fields.InValid_contractscommercial((SALT311.StrType)le.contractscommercial),
    Input_Fields.InValid_contractorgovernmentprime((SALT311.StrType)le.contractorgovernmentprime),
    Input_Fields.InValid_contractorgovernmentsub((SALT311.StrType)le.contractorgovernmentsub),
    Input_Fields.InValid_contractornongovernment((SALT311.StrType)le.contractornongovernment),
    Input_Fields.InValid_registeredgovernmentbus((SALT311.StrType)le.registeredgovernmentbus),
    Input_Fields.InValid_registerednongovernmentbus((SALT311.StrType)le.registerednongovernmentbus),
    Input_Fields.InValid_clearancelevelpersonnel((SALT311.StrType)le.clearancelevelpersonnel),
    Input_Fields.InValid_clearancelevelfacility((SALT311.StrType)le.clearancelevelfacility),
    Input_Fields.InValid_certificatedatefrom1((SALT311.StrType)le.certificatedatefrom1),
    Input_Fields.InValid_certificatedateto1((SALT311.StrType)le.certificatedateto1),
    Input_Fields.InValid_certificatestatus1((SALT311.StrType)le.certificatestatus1),
    Input_Fields.InValid_certificationnumber1((SALT311.StrType)le.certificationnumber1),
    Input_Fields.InValid_certificationtype1((SALT311.StrType)le.certificationtype1),
    Input_Fields.InValid_certificatedatefrom2((SALT311.StrType)le.certificatedatefrom2),
    Input_Fields.InValid_certificatedateto2((SALT311.StrType)le.certificatedateto2),
    Input_Fields.InValid_certificatestatus2((SALT311.StrType)le.certificatestatus2),
    Input_Fields.InValid_certificationnumber2((SALT311.StrType)le.certificationnumber2),
    Input_Fields.InValid_certificationtype2((SALT311.StrType)le.certificationtype2),
    Input_Fields.InValid_certificatedatefrom3((SALT311.StrType)le.certificatedatefrom3),
    Input_Fields.InValid_certificatedateto3((SALT311.StrType)le.certificatedateto3),
    Input_Fields.InValid_certificatestatus3((SALT311.StrType)le.certificatestatus3),
    Input_Fields.InValid_certificationnumber3((SALT311.StrType)le.certificationnumber3),
    Input_Fields.InValid_certificationtype3((SALT311.StrType)le.certificationtype3),
    Input_Fields.InValid_certificatedatefrom4((SALT311.StrType)le.certificatedatefrom4),
    Input_Fields.InValid_certificatedateto4((SALT311.StrType)le.certificatedateto4),
    Input_Fields.InValid_certificatestatus4((SALT311.StrType)le.certificatestatus4),
    Input_Fields.InValid_certificationnumber4((SALT311.StrType)le.certificationnumber4),
    Input_Fields.InValid_certificationtype4((SALT311.StrType)le.certificationtype4),
    Input_Fields.InValid_certificatedatefrom5((SALT311.StrType)le.certificatedatefrom5),
    Input_Fields.InValid_certificatedateto5((SALT311.StrType)le.certificatedateto5),
    Input_Fields.InValid_certificatestatus5((SALT311.StrType)le.certificatestatus5),
    Input_Fields.InValid_certificationnumber5((SALT311.StrType)le.certificationnumber5),
    Input_Fields.InValid_certificationtype5((SALT311.StrType)le.certificationtype5),
    Input_Fields.InValid_certificatedatefrom6((SALT311.StrType)le.certificatedatefrom6),
    Input_Fields.InValid_certificatedateto6((SALT311.StrType)le.certificatedateto6),
    Input_Fields.InValid_certificatestatus6((SALT311.StrType)le.certificatestatus6),
    Input_Fields.InValid_certificationnumber6((SALT311.StrType)le.certificationnumber6),
    Input_Fields.InValid_certificationtype6((SALT311.StrType)le.certificationtype6),
    Input_Fields.InValid_starrating((SALT311.StrType)le.starrating),
    Input_Fields.InValid_assets((SALT311.StrType)le.assets),
    Input_Fields.InValid_biddescription((SALT311.StrType)le.biddescription),
    Input_Fields.InValid_competitiveadvantage((SALT311.StrType)le.competitiveadvantage),
    Input_Fields.InValid_cagecode((SALT311.StrType)le.cagecode),
    Input_Fields.InValid_capabilitiesnarrative((SALT311.StrType)le.capabilitiesnarrative),
    Input_Fields.InValid_category((SALT311.StrType)le.category),
    Input_Fields.InValid_chtrclass((SALT311.StrType)le.chtrclass),
    Input_Fields.InValid_productdescription1((SALT311.StrType)le.productdescription1),
    Input_Fields.InValid_productdescription2((SALT311.StrType)le.productdescription2),
    Input_Fields.InValid_productdescription3((SALT311.StrType)le.productdescription3),
    Input_Fields.InValid_productdescription4((SALT311.StrType)le.productdescription4),
    Input_Fields.InValid_productdescription5((SALT311.StrType)le.productdescription5),
    Input_Fields.InValid_classdescription1((SALT311.StrType)le.classdescription1),
    Input_Fields.InValid_subclassdescription1((SALT311.StrType)le.subclassdescription1),
    Input_Fields.InValid_classdescription2((SALT311.StrType)le.classdescription2),
    Input_Fields.InValid_subclassdescription2((SALT311.StrType)le.subclassdescription2),
    Input_Fields.InValid_classdescription3((SALT311.StrType)le.classdescription3),
    Input_Fields.InValid_subclassdescription3((SALT311.StrType)le.subclassdescription3),
    Input_Fields.InValid_classdescription4((SALT311.StrType)le.classdescription4),
    Input_Fields.InValid_subclassdescription4((SALT311.StrType)le.subclassdescription4),
    Input_Fields.InValid_classdescription5((SALT311.StrType)le.classdescription5),
    Input_Fields.InValid_subclassdescription5((SALT311.StrType)le.subclassdescription5),
    Input_Fields.InValid_classifications((SALT311.StrType)le.classifications),
    Input_Fields.InValid_commodity1((SALT311.StrType)le.commodity1),
    Input_Fields.InValid_commodity2((SALT311.StrType)le.commodity2),
    Input_Fields.InValid_commodity3((SALT311.StrType)le.commodity3),
    Input_Fields.InValid_commodity4((SALT311.StrType)le.commodity4),
    Input_Fields.InValid_commodity5((SALT311.StrType)le.commodity5),
    Input_Fields.InValid_commodity6((SALT311.StrType)le.commodity6),
    Input_Fields.InValid_commodity7((SALT311.StrType)le.commodity7),
    Input_Fields.InValid_commodity8((SALT311.StrType)le.commodity8),
    Input_Fields.InValid_completedate((SALT311.StrType)le.completedate),
    Input_Fields.InValid_crossreference((SALT311.StrType)le.crossreference),
    Input_Fields.InValid_dateestablished((SALT311.StrType)le.dateestablished),
    Input_Fields.InValid_businessage((SALT311.StrType)le.businessage),
    Input_Fields.InValid_deposits((SALT311.StrType)le.deposits),
    Input_Fields.InValid_dunsnumber((SALT311.StrType)le.dunsnumber),
    Input_Fields.InValid_enttype((SALT311.StrType)le.enttype),
    Input_Fields.InValid_expirationdate((SALT311.StrType)le.expirationdate),
    Input_Fields.InValid_extendeddate((SALT311.StrType)le.extendeddate),
    Input_Fields.InValid_issuingauthority((SALT311.StrType)le.issuingauthority),
    Input_Fields.InValid_keywords((SALT311.StrType)le.keywords),
    Input_Fields.InValid_licensenumber((SALT311.StrType)le.licensenumber),
    Input_Fields.InValid_licensetype((SALT311.StrType)le.licensetype),
    Input_Fields.InValid_mincd((SALT311.StrType)le.mincd),
    Input_Fields.InValid_minorityaffiliation((SALT311.StrType)le.minorityaffiliation),
    Input_Fields.InValid_minorityownershipdate((SALT311.StrType)le.minorityownershipdate),
    Input_Fields.InValid_siccode1((SALT311.StrType)le.siccode1),
    Input_Fields.InValid_siccode2((SALT311.StrType)le.siccode2),
    Input_Fields.InValid_siccode3((SALT311.StrType)le.siccode3),
    Input_Fields.InValid_siccode4((SALT311.StrType)le.siccode4),
    Input_Fields.InValid_siccode5((SALT311.StrType)le.siccode5),
    Input_Fields.InValid_siccode6((SALT311.StrType)le.siccode6),
    Input_Fields.InValid_siccode7((SALT311.StrType)le.siccode7),
    Input_Fields.InValid_siccode8((SALT311.StrType)le.siccode8),
    Input_Fields.InValid_naicscode1((SALT311.StrType)le.naicscode1),
    Input_Fields.InValid_naicscode2((SALT311.StrType)le.naicscode2),
    Input_Fields.InValid_naicscode3((SALT311.StrType)le.naicscode3),
    Input_Fields.InValid_naicscode4((SALT311.StrType)le.naicscode4),
    Input_Fields.InValid_naicscode5((SALT311.StrType)le.naicscode5),
    Input_Fields.InValid_naicscode6((SALT311.StrType)le.naicscode6),
    Input_Fields.InValid_naicscode7((SALT311.StrType)le.naicscode7),
    Input_Fields.InValid_naicscode8((SALT311.StrType)le.naicscode8),
    Input_Fields.InValid_prequalify((SALT311.StrType)le.prequalify),
    Input_Fields.InValid_procurementcategory1((SALT311.StrType)le.procurementcategory1),
    Input_Fields.InValid_subprocurementcategory1((SALT311.StrType)le.subprocurementcategory1),
    Input_Fields.InValid_procurementcategory2((SALT311.StrType)le.procurementcategory2),
    Input_Fields.InValid_subprocurementcategory2((SALT311.StrType)le.subprocurementcategory2),
    Input_Fields.InValid_procurementcategory3((SALT311.StrType)le.procurementcategory3),
    Input_Fields.InValid_subprocurementcategory3((SALT311.StrType)le.subprocurementcategory3),
    Input_Fields.InValid_procurementcategory4((SALT311.StrType)le.procurementcategory4),
    Input_Fields.InValid_subprocurementcategory4((SALT311.StrType)le.subprocurementcategory4),
    Input_Fields.InValid_procurementcategory5((SALT311.StrType)le.procurementcategory5),
    Input_Fields.InValid_subprocurementcategory5((SALT311.StrType)le.subprocurementcategory5),
    Input_Fields.InValid_renewal((SALT311.StrType)le.renewal),
    Input_Fields.InValid_renewaldate((SALT311.StrType)le.renewaldate),
    Input_Fields.InValid_unitedcertprogrampartner((SALT311.StrType)le.unitedcertprogrampartner),
    Input_Fields.InValid_vendorkey((SALT311.StrType)le.vendorkey),
    Input_Fields.InValid_vendornumber((SALT311.StrType)le.vendornumber),
    Input_Fields.InValid_workcode1((SALT311.StrType)le.workcode1),
    Input_Fields.InValid_workcode2((SALT311.StrType)le.workcode2),
    Input_Fields.InValid_workcode3((SALT311.StrType)le.workcode3),
    Input_Fields.InValid_workcode4((SALT311.StrType)le.workcode4),
    Input_Fields.InValid_workcode5((SALT311.StrType)le.workcode5),
    Input_Fields.InValid_workcode6((SALT311.StrType)le.workcode6),
    Input_Fields.InValid_workcode7((SALT311.StrType)le.workcode7),
    Input_Fields.InValid_workcode8((SALT311.StrType)le.workcode8),
    Input_Fields.InValid_exporter((SALT311.StrType)le.exporter),
    Input_Fields.InValid_exportbusinessactivities((SALT311.StrType)le.exportbusinessactivities),
    Input_Fields.InValid_exportto((SALT311.StrType)le.exportto),
    Input_Fields.InValid_exportbusinessrelationships((SALT311.StrType)le.exportbusinessrelationships),
    Input_Fields.InValid_exportobjectives((SALT311.StrType)le.exportobjectives),
    Input_Fields.InValid_reference1((SALT311.StrType)le.reference1),
    Input_Fields.InValid_reference2((SALT311.StrType)le.reference2),
    Input_Fields.InValid_reference3((SALT311.StrType)le.reference3),
    0);
  SELF.FieldNum := IF(SELF.ErrorNum=0,SKIP,c); // Bail early to avoid creating record
END;
Errors := NORMALIZE(h,204,NoteErrors(LEFT,COUNTER));
ErrorRecordsTotals := RECORD
  Errors.FieldNum;
  Errors.ErrorNum;
  UNSIGNED Cnt := COUNT(GROUP);
END;
TotalErrors := TABLE(Errors,ErrorRecordsTotals,FieldNum,ErrorNum,FEW);
PrettyErrorTotals := RECORD
  FieldNme := Input_Fields.FieldName(TotalErrors.FieldNum);
  FieldType := CHOOSE(TotalErrors.FieldNum,'Invalid_No','Invalid_Date','Invalid_Date','Invalid_AlphaNumChar','Invalid_State','Invalid_Date','Invalid_AlphaNumChar','Invalid_Alpha','Invalid_AlphaNumChar','Invalid_AlphaNumChar','Invalid_AlphaNumChar','Invalid_AlphaNumChar','Invalid_AlphaNumChar','Invalid_AlphaChar','Invalid_AlphaChar','Invalid_AlphaChar','Invalid_Alpha','Invalid_AlphaChar','Invalid_AlphaChar','Invalid_Alpha','Invalid_AlphaNumChar','Invalid_AlphaNum','Invalid_Alpha','Invalid_State','Invalid_Zip','Invalid_No','Invalid_Alpha','Invalid_Alpha','Invalid_Phone','Invalid_Phone','Invalid_Phone','Invalid_Phone','Invalid_Phone','Invalid_AlphaNumChar','Invalid_AlphaNumChar','Invalid_AlphaNumChar','Invalid_AlphaNumChar','Invalid_AlphaNumChar','Invalid_AlphaNumChar','Invalid_AlphaNumChar','Invalid_AlphaNumChar','Invalid_Float','Invalid_Alpha','Invalid_Alpha','Invalid_Alpha','Invalid_Alpha','Invalid_Alpha','Invalid_Alpha','Invalid_Alpha','Invalid_Alpha','Invalid_Alpha','Invalid_Alpha','Invalid_AlphaChar','Invalid_Alpha','Invalid_Alpha','Invalid_AlphaChar','Invalid_Alpha','Invalid_Alpha','Invalid_AlphaNum','Invalid_No','Invalid_AlphaNumChar','Invalid_Alpha','Invalid_No','Invalid_Zip','Invalid_Alpha','Invalid_State','Invalid_Alpha','Invalid_State','Invalid_Alpha','Invalid_Alpha','Invalid_Alpha','Invalid_Alpha','Invalid_Alpha','Invalid_Alpha','Invalid_Alpha','Invalid_Alpha','Invalid_Alpha','Invalid_Alpha','Invalid_Date','Invalid_Future','Invalid_Alpha','Invalid_Float','Invalid_AlphaChar','Invalid_Date','Invalid_Future','Invalid_Alpha','Invalid_Float','Invalid_AlphaChar','Invalid_Date','Invalid_Future','Invalid_Alpha','Invalid_Float','Invalid_AlphaChar','Invalid_Date','Invalid_Future','Invalid_Alpha','Invalid_Float','Invalid_AlphaChar','Invalid_Date','Invalid_Future','Invalid_Alpha','Invalid_Float','Invalid_AlphaChar','Invalid_Date','Invalid_Future','Invalid_Alpha','Invalid_Float','Invalid_AlphaChar','Invalid_No','Invalid_Float','Invalid_AlphaChar','Invalid_Alpha','Invalid_No','Invalid_Alpha','Invalid_Alpha','Invalid_Alpha','Invalid_Alpha','Invalid_Alpha','Invalid_Alpha','Invalid_Alpha','Invalid_Alpha','Invalid_Alpha','Invalid_Alpha','Invalid_Alpha','Invalid_Alpha','Invalid_Alpha','Invalid_Alpha','Invalid_Alpha','Invalid_Alpha','Invalid_Alpha','Invalid_Alpha','Invalid_Alpha','Invalid_Commodity','Invalid_Commodity','Invalid_Commodity','Invalid_Commodity','Invalid_Commodity','Invalid_Commodity','Invalid_Commodity','Invalid_Commodity','Invalid_Date','Invalid_Alpha','Invalid_Date','Invalid_No','Invalid_No','Invalid_No','Invalid_Alpha','Invalid_Future','Invalid_Future','Invalid_AlphaChar','Invalid_Alpha','Invalid_AlphaNum','Invalid_Alpha','Invalid_No','Invalid_Alpha','Invalid_Date','Invalid_Sic','Invalid_Sic','Invalid_Sic','Invalid_Sic','Invalid_Sic','Invalid_Sic','Invalid_Sic','Invalid_Sic','Invalid_NAICS','Invalid_NAICS','Invalid_NAICS','Invalid_NAICS','Invalid_NAICS','Invalid_NAICS','Invalid_NAICS','Invalid_NAICS','Invalid_Alpha','Invalid_Alpha','Invalid_Alpha','Invalid_Alpha','Invalid_Alpha','Invalid_Alpha','Invalid_Alpha','Invalid_Alpha','Invalid_Alpha','Invalid_Alpha','Invalid_Alpha','Invalid_Alpha','Invalid_Future','Invalid_Alpha','Invalid_No','Invalid_No','Invalid_AlphaNum','Invalid_AlphaNum','Invalid_AlphaNum','Invalid_AlphaNum','Invalid_AlphaNum','Invalid_AlphaNum','Invalid_AlphaNum','Invalid_AlphaNum','Invalid_Alpha','Invalid_Alpha','Invalid_Alpha','Invalid_Alpha','Invalid_Alpha','Invalid_AlphaNum','Invalid_AlphaNum','Unknown');
  ErrorMessage := CHOOSE(TotalErrors.FieldNum,Input_Fields.InValidMessage_dartid(TotalErrors.ErrorNum),Input_Fields.InValidMessage_dateadded(TotalErrors.ErrorNum),Input_Fields.InValidMessage_dateupdated(TotalErrors.ErrorNum),Input_Fields.InValidMessage_website(TotalErrors.ErrorNum),Input_Fields.InValidMessage_state(TotalErrors.ErrorNum),Input_Fields.InValidMessage_profilelastupdated(TotalErrors.ErrorNum),Input_Fields.InValidMessage_county(TotalErrors.ErrorNum),Input_Fields.InValidMessage_servicearea(TotalErrors.ErrorNum),Input_Fields.InValidMessage_region1(TotalErrors.ErrorNum),Input_Fields.InValidMessage_region2(TotalErrors.ErrorNum),Input_Fields.InValidMessage_region3(TotalErrors.ErrorNum),Input_Fields.InValidMessage_region4(TotalErrors.ErrorNum),Input_Fields.InValidMessage_region5(TotalErrors.ErrorNum),Input_Fields.InValidMessage_fname(TotalErrors.ErrorNum),Input_Fields.InValidMessage_lname(TotalErrors.ErrorNum),Input_Fields.InValidMessage_mname(TotalErrors.ErrorNum),Input_Fields.InValidMessage_suffix(TotalErrors.ErrorNum),Input_Fields.InValidMessage_title(TotalErrors.ErrorNum),Input_Fields.InValidMessage_ethnicity(TotalErrors.ErrorNum),Input_Fields.InValidMessage_gender(TotalErrors.ErrorNum),Input_Fields.InValidMessage_address1(TotalErrors.ErrorNum),Input_Fields.InValidMessage_address2(TotalErrors.ErrorNum),Input_Fields.InValidMessage_addresscity(TotalErrors.ErrorNum),Input_Fields.InValidMessage_addressstate(TotalErrors.ErrorNum),Input_Fields.InValidMessage_addresszipcode(TotalErrors.ErrorNum),Input_Fields.InValidMessage_addresszip4(TotalErrors.ErrorNum),Input_Fields.InValidMessage_building(TotalErrors.ErrorNum),Input_Fields.InValidMessage_contact(TotalErrors.ErrorNum),Input_Fields.InValidMessage_phone1(TotalErrors.ErrorNum),Input_Fields.InValidMessage_phone2(TotalErrors.ErrorNum),Input_Fields.InValidMessage_phone3(TotalErrors.ErrorNum),Input_Fields.InValidMessage_cell(TotalErrors.ErrorNum),Input_Fields.InValidMessage_fax(TotalErrors.ErrorNum),Input_Fields.InValidMessage_email1(TotalErrors.ErrorNum),Input_Fields.InValidMessage_email2(TotalErrors.ErrorNum),Input_Fields.InValidMessage_email3(TotalErrors.ErrorNum),Input_Fields.InValidMessage_webpage1(TotalErrors.ErrorNum),Input_Fields.InValidMessage_webpage2(TotalErrors.ErrorNum),Input_Fields.InValidMessage_webpage3(TotalErrors.ErrorNum),Input_Fields.InValidMessage_businessname(TotalErrors.ErrorNum),Input_Fields.InValidMessage_dba(TotalErrors.ErrorNum),Input_Fields.InValidMessage_businessid(TotalErrors.ErrorNum),Input_Fields.InValidMessage_businesstype1(TotalErrors.ErrorNum),Input_Fields.InValidMessage_businesslocation1(TotalErrors.ErrorNum),Input_Fields.InValidMessage_businesstype2(TotalErrors.ErrorNum),Input_Fields.InValidMessage_businesslocation2(TotalErrors.ErrorNum),Input_Fields.InValidMessage_businesstype3(TotalErrors.ErrorNum),Input_Fields.InValidMessage_businesslocation3(TotalErrors.ErrorNum),Input_Fields.InValidMessage_businesstype4(TotalErrors.ErrorNum),Input_Fields.InValidMessage_businesslocation4(TotalErrors.ErrorNum),Input_Fields.InValidMessage_businesstype5(TotalErrors.ErrorNum),Input_Fields.InValidMessage_businesslocation5(TotalErrors.ErrorNum),Input_Fields.InValidMessage_industry(TotalErrors.ErrorNum),Input_Fields.InValidMessage_trade(TotalErrors.ErrorNum),Input_Fields.InValidMessage_resourcedescription(TotalErrors.ErrorNum),Input_Fields.InValidMessage_natureofbusiness(TotalErrors.ErrorNum),Input_Fields.InValidMessage_businessstructure(TotalErrors.ErrorNum),Input_Fields.InValidMessage_totalemployees(TotalErrors.ErrorNum),Input_Fields.InValidMessage_avgcontractsize(TotalErrors.ErrorNum),Input_Fields.InValidMessage_firmid(TotalErrors.ErrorNum),Input_Fields.InValidMessage_firmlocationaddress(TotalErrors.ErrorNum),Input_Fields.InValidMessage_firmlocationaddresscity(TotalErrors.ErrorNum),Input_Fields.InValidMessage_firmlocationaddresszip4(TotalErrors.ErrorNum),Input_Fields.InValidMessage_firmlocationaddresszipcode(TotalErrors.ErrorNum),Input_Fields.InValidMessage_firmlocationcounty(TotalErrors.ErrorNum),Input_Fields.InValidMessage_firmlocationstate(TotalErrors.ErrorNum),Input_Fields.InValidMessage_certfed(TotalErrors.ErrorNum),Input_Fields.InValidMessage_certstate(TotalErrors.ErrorNum),Input_Fields.InValidMessage_contractsfederal(TotalErrors.ErrorNum),Input_Fields.InValidMessage_contractsva(TotalErrors.ErrorNum),Input_Fields.InValidMessage_contractscommercial(TotalErrors.ErrorNum),Input_Fields.InValidMessage_contractorgovernmentprime(TotalErrors.ErrorNum),Input_Fields.InValidMessage_contractorgovernmentsub(TotalErrors.ErrorNum),Input_Fields.InValidMessage_contractornongovernment(TotalErrors.ErrorNum),Input_Fields.InValidMessage_registeredgovernmentbus(TotalErrors.ErrorNum),Input_Fields.InValidMessage_registerednongovernmentbus(TotalErrors.ErrorNum),Input_Fields.InValidMessage_clearancelevelpersonnel(TotalErrors.ErrorNum),Input_Fields.InValidMessage_clearancelevelfacility(TotalErrors.ErrorNum),Input_Fields.InValidMessage_certificatedatefrom1(TotalErrors.ErrorNum),Input_Fields.InValidMessage_certificatedateto1(TotalErrors.ErrorNum),Input_Fields.InValidMessage_certificatestatus1(TotalErrors.ErrorNum),Input_Fields.InValidMessage_certificationnumber1(TotalErrors.ErrorNum),Input_Fields.InValidMessage_certificationtype1(TotalErrors.ErrorNum),Input_Fields.InValidMessage_certificatedatefrom2(TotalErrors.ErrorNum),Input_Fields.InValidMessage_certificatedateto2(TotalErrors.ErrorNum),Input_Fields.InValidMessage_certificatestatus2(TotalErrors.ErrorNum),Input_Fields.InValidMessage_certificationnumber2(TotalErrors.ErrorNum),Input_Fields.InValidMessage_certificationtype2(TotalErrors.ErrorNum),Input_Fields.InValidMessage_certificatedatefrom3(TotalErrors.ErrorNum),Input_Fields.InValidMessage_certificatedateto3(TotalErrors.ErrorNum),Input_Fields.InValidMessage_certificatestatus3(TotalErrors.ErrorNum),Input_Fields.InValidMessage_certificationnumber3(TotalErrors.ErrorNum),Input_Fields.InValidMessage_certificationtype3(TotalErrors.ErrorNum),Input_Fields.InValidMessage_certificatedatefrom4(TotalErrors.ErrorNum),Input_Fields.InValidMessage_certificatedateto4(TotalErrors.ErrorNum),Input_Fields.InValidMessage_certificatestatus4(TotalErrors.ErrorNum),Input_Fields.InValidMessage_certificationnumber4(TotalErrors.ErrorNum),Input_Fields.InValidMessage_certificationtype4(TotalErrors.ErrorNum),Input_Fields.InValidMessage_certificatedatefrom5(TotalErrors.ErrorNum),Input_Fields.InValidMessage_certificatedateto5(TotalErrors.ErrorNum),Input_Fields.InValidMessage_certificatestatus5(TotalErrors.ErrorNum),Input_Fields.InValidMessage_certificationnumber5(TotalErrors.ErrorNum),Input_Fields.InValidMessage_certificationtype5(TotalErrors.ErrorNum),Input_Fields.InValidMessage_certificatedatefrom6(TotalErrors.ErrorNum),Input_Fields.InValidMessage_certificatedateto6(TotalErrors.ErrorNum),Input_Fields.InValidMessage_certificatestatus6(TotalErrors.ErrorNum),Input_Fields.InValidMessage_certificationnumber6(TotalErrors.ErrorNum),Input_Fields.InValidMessage_certificationtype6(TotalErrors.ErrorNum),Input_Fields.InValidMessage_starrating(TotalErrors.ErrorNum),Input_Fields.InValidMessage_assets(TotalErrors.ErrorNum),Input_Fields.InValidMessage_biddescription(TotalErrors.ErrorNum),Input_Fields.InValidMessage_competitiveadvantage(TotalErrors.ErrorNum),Input_Fields.InValidMessage_cagecode(TotalErrors.ErrorNum),Input_Fields.InValidMessage_capabilitiesnarrative(TotalErrors.ErrorNum),Input_Fields.InValidMessage_category(TotalErrors.ErrorNum),Input_Fields.InValidMessage_chtrclass(TotalErrors.ErrorNum),Input_Fields.InValidMessage_productdescription1(TotalErrors.ErrorNum),Input_Fields.InValidMessage_productdescription2(TotalErrors.ErrorNum),Input_Fields.InValidMessage_productdescription3(TotalErrors.ErrorNum),Input_Fields.InValidMessage_productdescription4(TotalErrors.ErrorNum),Input_Fields.InValidMessage_productdescription5(TotalErrors.ErrorNum),Input_Fields.InValidMessage_classdescription1(TotalErrors.ErrorNum),Input_Fields.InValidMessage_subclassdescription1(TotalErrors.ErrorNum),Input_Fields.InValidMessage_classdescription2(TotalErrors.ErrorNum),Input_Fields.InValidMessage_subclassdescription2(TotalErrors.ErrorNum),Input_Fields.InValidMessage_classdescription3(TotalErrors.ErrorNum),Input_Fields.InValidMessage_subclassdescription3(TotalErrors.ErrorNum),Input_Fields.InValidMessage_classdescription4(TotalErrors.ErrorNum),Input_Fields.InValidMessage_subclassdescription4(TotalErrors.ErrorNum),Input_Fields.InValidMessage_classdescription5(TotalErrors.ErrorNum),Input_Fields.InValidMessage_subclassdescription5(TotalErrors.ErrorNum),Input_Fields.InValidMessage_classifications(TotalErrors.ErrorNum),Input_Fields.InValidMessage_commodity1(TotalErrors.ErrorNum),Input_Fields.InValidMessage_commodity2(TotalErrors.ErrorNum),Input_Fields.InValidMessage_commodity3(TotalErrors.ErrorNum),Input_Fields.InValidMessage_commodity4(TotalErrors.ErrorNum),Input_Fields.InValidMessage_commodity5(TotalErrors.ErrorNum),Input_Fields.InValidMessage_commodity6(TotalErrors.ErrorNum),Input_Fields.InValidMessage_commodity7(TotalErrors.ErrorNum),Input_Fields.InValidMessage_commodity8(TotalErrors.ErrorNum),Input_Fields.InValidMessage_completedate(TotalErrors.ErrorNum),Input_Fields.InValidMessage_crossreference(TotalErrors.ErrorNum),Input_Fields.InValidMessage_dateestablished(TotalErrors.ErrorNum),Input_Fields.InValidMessage_businessage(TotalErrors.ErrorNum),Input_Fields.InValidMessage_deposits(TotalErrors.ErrorNum),Input_Fields.InValidMessage_dunsnumber(TotalErrors.ErrorNum),Input_Fields.InValidMessage_enttype(TotalErrors.ErrorNum),Input_Fields.InValidMessage_expirationdate(TotalErrors.ErrorNum),Input_Fields.InValidMessage_extendeddate(TotalErrors.ErrorNum),Input_Fields.InValidMessage_issuingauthority(TotalErrors.ErrorNum),Input_Fields.InValidMessage_keywords(TotalErrors.ErrorNum),Input_Fields.InValidMessage_licensenumber(TotalErrors.ErrorNum),Input_Fields.InValidMessage_licensetype(TotalErrors.ErrorNum),Input_Fields.InValidMessage_mincd(TotalErrors.ErrorNum),Input_Fields.InValidMessage_minorityaffiliation(TotalErrors.ErrorNum),Input_Fields.InValidMessage_minorityownershipdate(TotalErrors.ErrorNum),Input_Fields.InValidMessage_siccode1(TotalErrors.ErrorNum),Input_Fields.InValidMessage_siccode2(TotalErrors.ErrorNum),Input_Fields.InValidMessage_siccode3(TotalErrors.ErrorNum),Input_Fields.InValidMessage_siccode4(TotalErrors.ErrorNum),Input_Fields.InValidMessage_siccode5(TotalErrors.ErrorNum),Input_Fields.InValidMessage_siccode6(TotalErrors.ErrorNum),Input_Fields.InValidMessage_siccode7(TotalErrors.ErrorNum),Input_Fields.InValidMessage_siccode8(TotalErrors.ErrorNum),Input_Fields.InValidMessage_naicscode1(TotalErrors.ErrorNum),Input_Fields.InValidMessage_naicscode2(TotalErrors.ErrorNum),Input_Fields.InValidMessage_naicscode3(TotalErrors.ErrorNum),Input_Fields.InValidMessage_naicscode4(TotalErrors.ErrorNum),Input_Fields.InValidMessage_naicscode5(TotalErrors.ErrorNum),Input_Fields.InValidMessage_naicscode6(TotalErrors.ErrorNum),Input_Fields.InValidMessage_naicscode7(TotalErrors.ErrorNum),Input_Fields.InValidMessage_naicscode8(TotalErrors.ErrorNum),Input_Fields.InValidMessage_prequalify(TotalErrors.ErrorNum),Input_Fields.InValidMessage_procurementcategory1(TotalErrors.ErrorNum),Input_Fields.InValidMessage_subprocurementcategory1(TotalErrors.ErrorNum),Input_Fields.InValidMessage_procurementcategory2(TotalErrors.ErrorNum),Input_Fields.InValidMessage_subprocurementcategory2(TotalErrors.ErrorNum),Input_Fields.InValidMessage_procurementcategory3(TotalErrors.ErrorNum),Input_Fields.InValidMessage_subprocurementcategory3(TotalErrors.ErrorNum),Input_Fields.InValidMessage_procurementcategory4(TotalErrors.ErrorNum),Input_Fields.InValidMessage_subprocurementcategory4(TotalErrors.ErrorNum),Input_Fields.InValidMessage_procurementcategory5(TotalErrors.ErrorNum),Input_Fields.InValidMessage_subprocurementcategory5(TotalErrors.ErrorNum),Input_Fields.InValidMessage_renewal(TotalErrors.ErrorNum),Input_Fields.InValidMessage_renewaldate(TotalErrors.ErrorNum),Input_Fields.InValidMessage_unitedcertprogrampartner(TotalErrors.ErrorNum),Input_Fields.InValidMessage_vendorkey(TotalErrors.ErrorNum),Input_Fields.InValidMessage_vendornumber(TotalErrors.ErrorNum),Input_Fields.InValidMessage_workcode1(TotalErrors.ErrorNum),Input_Fields.InValidMessage_workcode2(TotalErrors.ErrorNum),Input_Fields.InValidMessage_workcode3(TotalErrors.ErrorNum),Input_Fields.InValidMessage_workcode4(TotalErrors.ErrorNum),Input_Fields.InValidMessage_workcode5(TotalErrors.ErrorNum),Input_Fields.InValidMessage_workcode6(TotalErrors.ErrorNum),Input_Fields.InValidMessage_workcode7(TotalErrors.ErrorNum),Input_Fields.InValidMessage_workcode8(TotalErrors.ErrorNum),Input_Fields.InValidMessage_exporter(TotalErrors.ErrorNum),Input_Fields.InValidMessage_exportbusinessactivities(TotalErrors.ErrorNum),Input_Fields.InValidMessage_exportto(TotalErrors.ErrorNum),Input_Fields.InValidMessage_exportbusinessrelationships(TotalErrors.ErrorNum),Input_Fields.InValidMessage_exportobjectives(TotalErrors.ErrorNum),Input_Fields.InValidMessage_reference1(TotalErrors.ErrorNum),Input_Fields.InValidMessage_reference2(TotalErrors.ErrorNum),Input_Fields.InValidMessage_reference3(TotalErrors.ErrorNum));
  TotalErrors.Cnt;
END;
ValErr := TABLE(TotalErrors,PrettyErrorTotals);
EXPORT ValidityErrors := ValErr;
EXPORT StandardStats(BOOLEAN doSummaryGlobal = TRUE, BOOLEAN doAllProfiles = TRUE) := FUNCTION
  myTimeStamp := (UNSIGNED6)SALT311.Fn_Now('YYYYMMDDHHMMSS') : INDEPENDENT;
  fieldPopulationOverall := Summary('');
 
  SALT311.mod_StandardStatsTransforms.mac_hygieneSummaryTransform(Scrubs_Diversity_Certification, Input_Fields, 'RECORDOF(fieldPopulationOverall)', FALSE);
 
  fieldPopulationOverall_Standard := IF(doSummaryGlobal, NORMALIZE(fieldPopulationOverall, COUNT(FldIds) * 6, xSummary(LEFT, COUNTER, myTimeStamp, 'all', 'all')));
  fieldPopulationOverall_TotalRecs_Standard := IF(doSummaryGlobal, SALT311.mod_StandardStatsTransforms.mac_hygieneTotalRecs(fieldPopulationOverall, myTimeStamp, 'all', FALSE, 'all'));
  allProfiles_Standard := IF(doAllProfiles, SALT311.mod_StandardStatsTransforms.hygieneAllProfiles(AllProfiles, myTimeStamp, 10, 'all'));
 
  RETURN fieldPopulationOverall_Standard & fieldPopulationOverall_TotalRecs_Standard & allProfiles_Standard;
END;
END;
