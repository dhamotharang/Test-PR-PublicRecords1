IMPORT ut,SALT34;
EXPORT hygiene(dataset(layout_File) h) := MODULE
 
//A simple summary record
EXPORT Summary(SALT34.Str30Type txt) := FUNCTION
  SummaryLayout := RECORD
    txt;
    NumberOfRecords := COUNT(GROUP);
    populated_dt_first_seen_pcnt := AVE(GROUP,IF(h.dt_first_seen = (TYPEOF(h.dt_first_seen))'',0,100));
    maxlength_dt_first_seen := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.dt_first_seen)));
    avelength_dt_first_seen := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.dt_first_seen)),h.dt_first_seen<>(typeof(h.dt_first_seen))'');
    populated_dt_last_seen_pcnt := AVE(GROUP,IF(h.dt_last_seen = (TYPEOF(h.dt_last_seen))'',0,100));
    maxlength_dt_last_seen := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.dt_last_seen)));
    avelength_dt_last_seen := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.dt_last_seen)),h.dt_last_seen<>(typeof(h.dt_last_seen))'');
    populated_dt_vendor_first_reported_pcnt := AVE(GROUP,IF(h.dt_vendor_first_reported = (TYPEOF(h.dt_vendor_first_reported))'',0,100));
    maxlength_dt_vendor_first_reported := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.dt_vendor_first_reported)));
    avelength_dt_vendor_first_reported := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.dt_vendor_first_reported)),h.dt_vendor_first_reported<>(typeof(h.dt_vendor_first_reported))'');
    populated_dt_vendor_last_reported_pcnt := AVE(GROUP,IF(h.dt_vendor_last_reported = (TYPEOF(h.dt_vendor_last_reported))'',0,100));
    maxlength_dt_vendor_last_reported := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.dt_vendor_last_reported)));
    avelength_dt_vendor_last_reported := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.dt_vendor_last_reported)),h.dt_vendor_last_reported<>(typeof(h.dt_vendor_last_reported))'');
    populated_filetype_pcnt := AVE(GROUP,IF(h.filetype = (TYPEOF(h.filetype))'',0,100));
    maxlength_filetype := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.filetype)));
    avelength_filetype := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.filetype)),h.filetype<>(typeof(h.filetype))'');
    populated_filedate_pcnt := AVE(GROUP,IF(h.filedate = (TYPEOF(h.filedate))'',0,100));
    maxlength_filedate := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.filedate)));
    avelength_filedate := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.filedate)),h.filedate<>(typeof(h.filedate))'');
    populated_vendordocumentidentifier_pcnt := AVE(GROUP,IF(h.vendordocumentidentifier = (TYPEOF(h.vendordocumentidentifier))'',0,100));
    maxlength_vendordocumentidentifier := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.vendordocumentidentifier)));
    avelength_vendordocumentidentifier := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.vendordocumentidentifier)),h.vendordocumentidentifier<>(typeof(h.vendordocumentidentifier))'');
    populated_transferdate_pcnt := AVE(GROUP,IF(h.transferdate = (TYPEOF(h.transferdate))'',0,100));
    maxlength_transferdate := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.transferdate)));
    avelength_transferdate := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.transferdate)),h.transferdate<>(typeof(h.transferdate))'');
    populated_currentname_firstname_pcnt := AVE(GROUP,IF(h.currentname_firstname = (TYPEOF(h.currentname_firstname))'',0,100));
    maxlength_currentname_firstname := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.currentname_firstname)));
    avelength_currentname_firstname := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.currentname_firstname)),h.currentname_firstname<>(typeof(h.currentname_firstname))'');
    populated_currentname_middlename_pcnt := AVE(GROUP,IF(h.currentname_middlename = (TYPEOF(h.currentname_middlename))'',0,100));
    maxlength_currentname_middlename := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.currentname_middlename)));
    avelength_currentname_middlename := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.currentname_middlename)),h.currentname_middlename<>(typeof(h.currentname_middlename))'');
    populated_currentname_middleinitial_pcnt := AVE(GROUP,IF(h.currentname_middleinitial = (TYPEOF(h.currentname_middleinitial))'',0,100));
    maxlength_currentname_middleinitial := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.currentname_middleinitial)));
    avelength_currentname_middleinitial := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.currentname_middleinitial)),h.currentname_middleinitial<>(typeof(h.currentname_middleinitial))'');
    populated_currentname_lastname_pcnt := AVE(GROUP,IF(h.currentname_lastname = (TYPEOF(h.currentname_lastname))'',0,100));
    maxlength_currentname_lastname := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.currentname_lastname)));
    avelength_currentname_lastname := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.currentname_lastname)),h.currentname_lastname<>(typeof(h.currentname_lastname))'');
    populated_currentname_suffix_pcnt := AVE(GROUP,IF(h.currentname_suffix = (TYPEOF(h.currentname_suffix))'',0,100));
    maxlength_currentname_suffix := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.currentname_suffix)));
    avelength_currentname_suffix := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.currentname_suffix)),h.currentname_suffix<>(typeof(h.currentname_suffix))'');
    populated_currentname_gender_pcnt := AVE(GROUP,IF(h.currentname_gender = (TYPEOF(h.currentname_gender))'',0,100));
    maxlength_currentname_gender := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.currentname_gender)));
    avelength_currentname_gender := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.currentname_gender)),h.currentname_gender<>(typeof(h.currentname_gender))'');
    populated_currentname_dob_mm_pcnt := AVE(GROUP,IF(h.currentname_dob_mm = (TYPEOF(h.currentname_dob_mm))'',0,100));
    maxlength_currentname_dob_mm := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.currentname_dob_mm)));
    avelength_currentname_dob_mm := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.currentname_dob_mm)),h.currentname_dob_mm<>(typeof(h.currentname_dob_mm))'');
    populated_currentname_dob_dd_pcnt := AVE(GROUP,IF(h.currentname_dob_dd = (TYPEOF(h.currentname_dob_dd))'',0,100));
    maxlength_currentname_dob_dd := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.currentname_dob_dd)));
    avelength_currentname_dob_dd := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.currentname_dob_dd)),h.currentname_dob_dd<>(typeof(h.currentname_dob_dd))'');
    populated_currentname_dob_yyyy_pcnt := AVE(GROUP,IF(h.currentname_dob_yyyy = (TYPEOF(h.currentname_dob_yyyy))'',0,100));
    maxlength_currentname_dob_yyyy := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.currentname_dob_yyyy)));
    avelength_currentname_dob_yyyy := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.currentname_dob_yyyy)),h.currentname_dob_yyyy<>(typeof(h.currentname_dob_yyyy))'');
    populated_currentname_deathindicator_pcnt := AVE(GROUP,IF(h.currentname_deathindicator = (TYPEOF(h.currentname_deathindicator))'',0,100));
    maxlength_currentname_deathindicator := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.currentname_deathindicator)));
    avelength_currentname_deathindicator := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.currentname_deathindicator)),h.currentname_deathindicator<>(typeof(h.currentname_deathindicator))'');
    populated_ssnfull_pcnt := AVE(GROUP,IF(h.ssnfull = (TYPEOF(h.ssnfull))'',0,100));
    maxlength_ssnfull := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.ssnfull)));
    avelength_ssnfull := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.ssnfull)),h.ssnfull<>(typeof(h.ssnfull))'');
    populated_ssnfirst5digit_pcnt := AVE(GROUP,IF(h.ssnfirst5digit = (TYPEOF(h.ssnfirst5digit))'',0,100));
    maxlength_ssnfirst5digit := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.ssnfirst5digit)));
    avelength_ssnfirst5digit := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.ssnfirst5digit)),h.ssnfirst5digit<>(typeof(h.ssnfirst5digit))'');
    populated_ssnlast4digit_pcnt := AVE(GROUP,IF(h.ssnlast4digit = (TYPEOF(h.ssnlast4digit))'',0,100));
    maxlength_ssnlast4digit := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.ssnlast4digit)));
    avelength_ssnlast4digit := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.ssnlast4digit)),h.ssnlast4digit<>(typeof(h.ssnlast4digit))'');
    populated_consumerupdatedate_pcnt := AVE(GROUP,IF(h.consumerupdatedate = (TYPEOF(h.consumerupdatedate))'',0,100));
    maxlength_consumerupdatedate := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.consumerupdatedate)));
    avelength_consumerupdatedate := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.consumerupdatedate)),h.consumerupdatedate<>(typeof(h.consumerupdatedate))'');
    populated_telephonenumber_pcnt := AVE(GROUP,IF(h.telephonenumber = (TYPEOF(h.telephonenumber))'',0,100));
    maxlength_telephonenumber := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.telephonenumber)));
    avelength_telephonenumber := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.telephonenumber)),h.telephonenumber<>(typeof(h.telephonenumber))'');
    populated_citedid_pcnt := AVE(GROUP,IF(h.citedid = (TYPEOF(h.citedid))'',0,100));
    maxlength_citedid := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.citedid)));
    avelength_citedid := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.citedid)),h.citedid<>(typeof(h.citedid))'');
    populated_fileid_pcnt := AVE(GROUP,IF(h.fileid = (TYPEOF(h.fileid))'',0,100));
    maxlength_fileid := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.fileid)));
    avelength_fileid := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.fileid)),h.fileid<>(typeof(h.fileid))'');
    populated_publication_pcnt := AVE(GROUP,IF(h.publication = (TYPEOF(h.publication))'',0,100));
    maxlength_publication := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.publication)));
    avelength_publication := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.publication)),h.publication<>(typeof(h.publication))'');
    populated_currentaddress_address1_pcnt := AVE(GROUP,IF(h.currentaddress_address1 = (TYPEOF(h.currentaddress_address1))'',0,100));
    maxlength_currentaddress_address1 := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.currentaddress_address1)));
    avelength_currentaddress_address1 := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.currentaddress_address1)),h.currentaddress_address1<>(typeof(h.currentaddress_address1))'');
    populated_currentaddress_address2_pcnt := AVE(GROUP,IF(h.currentaddress_address2 = (TYPEOF(h.currentaddress_address2))'',0,100));
    maxlength_currentaddress_address2 := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.currentaddress_address2)));
    avelength_currentaddress_address2 := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.currentaddress_address2)),h.currentaddress_address2<>(typeof(h.currentaddress_address2))'');
    populated_currentaddress_city_pcnt := AVE(GROUP,IF(h.currentaddress_city = (TYPEOF(h.currentaddress_city))'',0,100));
    maxlength_currentaddress_city := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.currentaddress_city)));
    avelength_currentaddress_city := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.currentaddress_city)),h.currentaddress_city<>(typeof(h.currentaddress_city))'');
    populated_currentaddress_state_pcnt := AVE(GROUP,IF(h.currentaddress_state = (TYPEOF(h.currentaddress_state))'',0,100));
    maxlength_currentaddress_state := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.currentaddress_state)));
    avelength_currentaddress_state := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.currentaddress_state)),h.currentaddress_state<>(typeof(h.currentaddress_state))'');
    populated_currentaddress_zipcode_pcnt := AVE(GROUP,IF(h.currentaddress_zipcode = (TYPEOF(h.currentaddress_zipcode))'',0,100));
    maxlength_currentaddress_zipcode := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.currentaddress_zipcode)));
    avelength_currentaddress_zipcode := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.currentaddress_zipcode)),h.currentaddress_zipcode<>(typeof(h.currentaddress_zipcode))'');
    populated_currentaddress_updateddate_pcnt := AVE(GROUP,IF(h.currentaddress_updateddate = (TYPEOF(h.currentaddress_updateddate))'',0,100));
    maxlength_currentaddress_updateddate := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.currentaddress_updateddate)));
    avelength_currentaddress_updateddate := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.currentaddress_updateddate)),h.currentaddress_updateddate<>(typeof(h.currentaddress_updateddate))'');
    populated_housenumber_pcnt := AVE(GROUP,IF(h.housenumber = (TYPEOF(h.housenumber))'',0,100));
    maxlength_housenumber := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.housenumber)));
    avelength_housenumber := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.housenumber)),h.housenumber<>(typeof(h.housenumber))'');
    populated_streettype_pcnt := AVE(GROUP,IF(h.streettype = (TYPEOF(h.streettype))'',0,100));
    maxlength_streettype := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.streettype)));
    avelength_streettype := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.streettype)),h.streettype<>(typeof(h.streettype))'');
    populated_streetdirection_pcnt := AVE(GROUP,IF(h.streetdirection = (TYPEOF(h.streetdirection))'',0,100));
    maxlength_streetdirection := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.streetdirection)));
    avelength_streetdirection := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.streetdirection)),h.streetdirection<>(typeof(h.streetdirection))'');
    populated_streetname_pcnt := AVE(GROUP,IF(h.streetname = (TYPEOF(h.streetname))'',0,100));
    maxlength_streetname := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.streetname)));
    avelength_streetname := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.streetname)),h.streetname<>(typeof(h.streetname))'');
    populated_apartmentnumber_pcnt := AVE(GROUP,IF(h.apartmentnumber = (TYPEOF(h.apartmentnumber))'',0,100));
    maxlength_apartmentnumber := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.apartmentnumber)));
    avelength_apartmentnumber := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.apartmentnumber)),h.apartmentnumber<>(typeof(h.apartmentnumber))'');
    populated_city_pcnt := AVE(GROUP,IF(h.city = (TYPEOF(h.city))'',0,100));
    maxlength_city := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.city)));
    avelength_city := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.city)),h.city<>(typeof(h.city))'');
    populated_state_pcnt := AVE(GROUP,IF(h.state = (TYPEOF(h.state))'',0,100));
    maxlength_state := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.state)));
    avelength_state := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.state)),h.state<>(typeof(h.state))'');
    populated_zipcode_pcnt := AVE(GROUP,IF(h.zipcode = (TYPEOF(h.zipcode))'',0,100));
    maxlength_zipcode := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.zipcode)));
    avelength_zipcode := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.zipcode)),h.zipcode<>(typeof(h.zipcode))'');
    populated_zip4u_pcnt := AVE(GROUP,IF(h.zip4u = (TYPEOF(h.zip4u))'',0,100));
    maxlength_zip4u := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.zip4u)));
    avelength_zip4u := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.zip4u)),h.zip4u<>(typeof(h.zip4u))'');
    populated_previousaddress_address1_pcnt := AVE(GROUP,IF(h.previousaddress_address1 = (TYPEOF(h.previousaddress_address1))'',0,100));
    maxlength_previousaddress_address1 := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.previousaddress_address1)));
    avelength_previousaddress_address1 := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.previousaddress_address1)),h.previousaddress_address1<>(typeof(h.previousaddress_address1))'');
    populated_previousaddress_address2_pcnt := AVE(GROUP,IF(h.previousaddress_address2 = (TYPEOF(h.previousaddress_address2))'',0,100));
    maxlength_previousaddress_address2 := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.previousaddress_address2)));
    avelength_previousaddress_address2 := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.previousaddress_address2)),h.previousaddress_address2<>(typeof(h.previousaddress_address2))'');
    populated_previousaddress_city_pcnt := AVE(GROUP,IF(h.previousaddress_city = (TYPEOF(h.previousaddress_city))'',0,100));
    maxlength_previousaddress_city := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.previousaddress_city)));
    avelength_previousaddress_city := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.previousaddress_city)),h.previousaddress_city<>(typeof(h.previousaddress_city))'');
    populated_previousaddress_state_pcnt := AVE(GROUP,IF(h.previousaddress_state = (TYPEOF(h.previousaddress_state))'',0,100));
    maxlength_previousaddress_state := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.previousaddress_state)));
    avelength_previousaddress_state := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.previousaddress_state)),h.previousaddress_state<>(typeof(h.previousaddress_state))'');
    populated_previousaddress_zipcode_pcnt := AVE(GROUP,IF(h.previousaddress_zipcode = (TYPEOF(h.previousaddress_zipcode))'',0,100));
    maxlength_previousaddress_zipcode := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.previousaddress_zipcode)));
    avelength_previousaddress_zipcode := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.previousaddress_zipcode)),h.previousaddress_zipcode<>(typeof(h.previousaddress_zipcode))'');
    populated_previousaddress_updateddate_pcnt := AVE(GROUP,IF(h.previousaddress_updateddate = (TYPEOF(h.previousaddress_updateddate))'',0,100));
    maxlength_previousaddress_updateddate := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.previousaddress_updateddate)));
    avelength_previousaddress_updateddate := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.previousaddress_updateddate)),h.previousaddress_updateddate<>(typeof(h.previousaddress_updateddate))'');
    populated_formername_firstname_pcnt := AVE(GROUP,IF(h.formername_firstname = (TYPEOF(h.formername_firstname))'',0,100));
    maxlength_formername_firstname := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.formername_firstname)));
    avelength_formername_firstname := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.formername_firstname)),h.formername_firstname<>(typeof(h.formername_firstname))'');
    populated_formername_middlename_pcnt := AVE(GROUP,IF(h.formername_middlename = (TYPEOF(h.formername_middlename))'',0,100));
    maxlength_formername_middlename := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.formername_middlename)));
    avelength_formername_middlename := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.formername_middlename)),h.formername_middlename<>(typeof(h.formername_middlename))'');
    populated_formername_middleinitial_pcnt := AVE(GROUP,IF(h.formername_middleinitial = (TYPEOF(h.formername_middleinitial))'',0,100));
    maxlength_formername_middleinitial := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.formername_middleinitial)));
    avelength_formername_middleinitial := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.formername_middleinitial)),h.formername_middleinitial<>(typeof(h.formername_middleinitial))'');
    populated_formername_lastname_pcnt := AVE(GROUP,IF(h.formername_lastname = (TYPEOF(h.formername_lastname))'',0,100));
    maxlength_formername_lastname := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.formername_lastname)));
    avelength_formername_lastname := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.formername_lastname)),h.formername_lastname<>(typeof(h.formername_lastname))'');
    populated_formername_suffix_pcnt := AVE(GROUP,IF(h.formername_suffix = (TYPEOF(h.formername_suffix))'',0,100));
    maxlength_formername_suffix := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.formername_suffix)));
    avelength_formername_suffix := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.formername_suffix)),h.formername_suffix<>(typeof(h.formername_suffix))'');
    populated_aliasname_firstname_pcnt := AVE(GROUP,IF(h.aliasname_firstname = (TYPEOF(h.aliasname_firstname))'',0,100));
    maxlength_aliasname_firstname := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.aliasname_firstname)));
    avelength_aliasname_firstname := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.aliasname_firstname)),h.aliasname_firstname<>(typeof(h.aliasname_firstname))'');
    populated_aliasname_middlename_pcnt := AVE(GROUP,IF(h.aliasname_middlename = (TYPEOF(h.aliasname_middlename))'',0,100));
    maxlength_aliasname_middlename := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.aliasname_middlename)));
    avelength_aliasname_middlename := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.aliasname_middlename)),h.aliasname_middlename<>(typeof(h.aliasname_middlename))'');
    populated_aliasname_middleinitial_pcnt := AVE(GROUP,IF(h.aliasname_middleinitial = (TYPEOF(h.aliasname_middleinitial))'',0,100));
    maxlength_aliasname_middleinitial := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.aliasname_middleinitial)));
    avelength_aliasname_middleinitial := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.aliasname_middleinitial)),h.aliasname_middleinitial<>(typeof(h.aliasname_middleinitial))'');
    populated_aliasname_lastname_pcnt := AVE(GROUP,IF(h.aliasname_lastname = (TYPEOF(h.aliasname_lastname))'',0,100));
    maxlength_aliasname_lastname := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.aliasname_lastname)));
    avelength_aliasname_lastname := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.aliasname_lastname)),h.aliasname_lastname<>(typeof(h.aliasname_lastname))'');
    populated_aliasname_suffix_pcnt := AVE(GROUP,IF(h.aliasname_suffix = (TYPEOF(h.aliasname_suffix))'',0,100));
    maxlength_aliasname_suffix := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.aliasname_suffix)));
    avelength_aliasname_suffix := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.aliasname_suffix)),h.aliasname_suffix<>(typeof(h.aliasname_suffix))'');
    populated_additionalname_firstname_pcnt := AVE(GROUP,IF(h.additionalname_firstname = (TYPEOF(h.additionalname_firstname))'',0,100));
    maxlength_additionalname_firstname := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.additionalname_firstname)));
    avelength_additionalname_firstname := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.additionalname_firstname)),h.additionalname_firstname<>(typeof(h.additionalname_firstname))'');
    populated_additionalname_middlename_pcnt := AVE(GROUP,IF(h.additionalname_middlename = (TYPEOF(h.additionalname_middlename))'',0,100));
    maxlength_additionalname_middlename := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.additionalname_middlename)));
    avelength_additionalname_middlename := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.additionalname_middlename)),h.additionalname_middlename<>(typeof(h.additionalname_middlename))'');
    populated_additionalname_middleinitial_pcnt := AVE(GROUP,IF(h.additionalname_middleinitial = (TYPEOF(h.additionalname_middleinitial))'',0,100));
    maxlength_additionalname_middleinitial := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.additionalname_middleinitial)));
    avelength_additionalname_middleinitial := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.additionalname_middleinitial)),h.additionalname_middleinitial<>(typeof(h.additionalname_middleinitial))'');
    populated_additionalname_lastname_pcnt := AVE(GROUP,IF(h.additionalname_lastname = (TYPEOF(h.additionalname_lastname))'',0,100));
    maxlength_additionalname_lastname := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.additionalname_lastname)));
    avelength_additionalname_lastname := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.additionalname_lastname)),h.additionalname_lastname<>(typeof(h.additionalname_lastname))'');
    populated_additionalname_suffix_pcnt := AVE(GROUP,IF(h.additionalname_suffix = (TYPEOF(h.additionalname_suffix))'',0,100));
    maxlength_additionalname_suffix := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.additionalname_suffix)));
    avelength_additionalname_suffix := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.additionalname_suffix)),h.additionalname_suffix<>(typeof(h.additionalname_suffix))'');
    populated_aka1_pcnt := AVE(GROUP,IF(h.aka1 = (TYPEOF(h.aka1))'',0,100));
    maxlength_aka1 := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.aka1)));
    avelength_aka1 := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.aka1)),h.aka1<>(typeof(h.aka1))'');
    populated_aka2_pcnt := AVE(GROUP,IF(h.aka2 = (TYPEOF(h.aka2))'',0,100));
    maxlength_aka2 := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.aka2)));
    avelength_aka2 := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.aka2)),h.aka2<>(typeof(h.aka2))'');
    populated_aka3_pcnt := AVE(GROUP,IF(h.aka3 = (TYPEOF(h.aka3))'',0,100));
    maxlength_aka3 := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.aka3)));
    avelength_aka3 := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.aka3)),h.aka3<>(typeof(h.aka3))'');
    populated_recordtype_pcnt := AVE(GROUP,IF(h.recordtype = (TYPEOF(h.recordtype))'',0,100));
    maxlength_recordtype := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.recordtype)));
    avelength_recordtype := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.recordtype)),h.recordtype<>(typeof(h.recordtype))'');
    populated_addressstandardization_pcnt := AVE(GROUP,IF(h.addressstandardization = (TYPEOF(h.addressstandardization))'',0,100));
    maxlength_addressstandardization := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.addressstandardization)));
    avelength_addressstandardization := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.addressstandardization)),h.addressstandardization<>(typeof(h.addressstandardization))'');
    populated_filesincedate_pcnt := AVE(GROUP,IF(h.filesincedate = (TYPEOF(h.filesincedate))'',0,100));
    maxlength_filesincedate := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.filesincedate)));
    avelength_filesincedate := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.filesincedate)),h.filesincedate<>(typeof(h.filesincedate))'');
    populated_compilationdate_pcnt := AVE(GROUP,IF(h.compilationdate = (TYPEOF(h.compilationdate))'',0,100));
    maxlength_compilationdate := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.compilationdate)));
    avelength_compilationdate := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.compilationdate)),h.compilationdate<>(typeof(h.compilationdate))'');
    populated_birthdateind_pcnt := AVE(GROUP,IF(h.birthdateind = (TYPEOF(h.birthdateind))'',0,100));
    maxlength_birthdateind := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.birthdateind)));
    avelength_birthdateind := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.birthdateind)),h.birthdateind<>(typeof(h.birthdateind))'');
    populated_orig_deceasedindicator_pcnt := AVE(GROUP,IF(h.orig_deceasedindicator = (TYPEOF(h.orig_deceasedindicator))'',0,100));
    maxlength_orig_deceasedindicator := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.orig_deceasedindicator)));
    avelength_orig_deceasedindicator := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.orig_deceasedindicator)),h.orig_deceasedindicator<>(typeof(h.orig_deceasedindicator))'');
    populated_deceaseddate_pcnt := AVE(GROUP,IF(h.deceaseddate = (TYPEOF(h.deceaseddate))'',0,100));
    maxlength_deceaseddate := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.deceaseddate)));
    avelength_deceaseddate := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.deceaseddate)),h.deceaseddate<>(typeof(h.deceaseddate))'');
    populated_addressseq_pcnt := AVE(GROUP,IF(h.addressseq = (TYPEOF(h.addressseq))'',0,100));
    maxlength_addressseq := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.addressseq)));
    avelength_addressseq := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.addressseq)),h.addressseq<>(typeof(h.addressseq))'');
    populated_normaddress_address1_pcnt := AVE(GROUP,IF(h.normaddress_address1 = (TYPEOF(h.normaddress_address1))'',0,100));
    maxlength_normaddress_address1 := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.normaddress_address1)));
    avelength_normaddress_address1 := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.normaddress_address1)),h.normaddress_address1<>(typeof(h.normaddress_address1))'');
    populated_normaddress_address2_pcnt := AVE(GROUP,IF(h.normaddress_address2 = (TYPEOF(h.normaddress_address2))'',0,100));
    maxlength_normaddress_address2 := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.normaddress_address2)));
    avelength_normaddress_address2 := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.normaddress_address2)),h.normaddress_address2<>(typeof(h.normaddress_address2))'');
    populated_normaddress_city_pcnt := AVE(GROUP,IF(h.normaddress_city = (TYPEOF(h.normaddress_city))'',0,100));
    maxlength_normaddress_city := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.normaddress_city)));
    avelength_normaddress_city := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.normaddress_city)),h.normaddress_city<>(typeof(h.normaddress_city))'');
    populated_normaddress_state_pcnt := AVE(GROUP,IF(h.normaddress_state = (TYPEOF(h.normaddress_state))'',0,100));
    maxlength_normaddress_state := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.normaddress_state)));
    avelength_normaddress_state := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.normaddress_state)),h.normaddress_state<>(typeof(h.normaddress_state))'');
    populated_normaddress_zipcode_pcnt := AVE(GROUP,IF(h.normaddress_zipcode = (TYPEOF(h.normaddress_zipcode))'',0,100));
    maxlength_normaddress_zipcode := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.normaddress_zipcode)));
    avelength_normaddress_zipcode := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.normaddress_zipcode)),h.normaddress_zipcode<>(typeof(h.normaddress_zipcode))'');
    populated_normaddress_updateddate_pcnt := AVE(GROUP,IF(h.normaddress_updateddate = (TYPEOF(h.normaddress_updateddate))'',0,100));
    maxlength_normaddress_updateddate := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.normaddress_updateddate)));
    avelength_normaddress_updateddate := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.normaddress_updateddate)),h.normaddress_updateddate<>(typeof(h.normaddress_updateddate))'');
    populated_name_pcnt := AVE(GROUP,IF(h.name = (TYPEOF(h.name))'',0,100));
    maxlength_name := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.name)));
    avelength_name := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.name)),h.name<>(typeof(h.name))'');
    populated_nametype_pcnt := AVE(GROUP,IF(h.nametype = (TYPEOF(h.nametype))'',0,100));
    maxlength_nametype := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.nametype)));
    avelength_nametype := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.nametype)),h.nametype<>(typeof(h.nametype))'');
    populated_title_pcnt := AVE(GROUP,IF(h.title = (TYPEOF(h.title))'',0,100));
    maxlength_title := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.title)));
    avelength_title := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.title)),h.title<>(typeof(h.title))'');
    populated_fname_pcnt := AVE(GROUP,IF(h.fname = (TYPEOF(h.fname))'',0,100));
    maxlength_fname := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.fname)));
    avelength_fname := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.fname)),h.fname<>(typeof(h.fname))'');
    populated_mname_pcnt := AVE(GROUP,IF(h.mname = (TYPEOF(h.mname))'',0,100));
    maxlength_mname := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.mname)));
    avelength_mname := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.mname)),h.mname<>(typeof(h.mname))'');
    populated_lname_pcnt := AVE(GROUP,IF(h.lname = (TYPEOF(h.lname))'',0,100));
    maxlength_lname := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.lname)));
    avelength_lname := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.lname)),h.lname<>(typeof(h.lname))'');
    populated_name_suffix_pcnt := AVE(GROUP,IF(h.name_suffix = (TYPEOF(h.name_suffix))'',0,100));
    maxlength_name_suffix := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.name_suffix)));
    avelength_name_suffix := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.name_suffix)),h.name_suffix<>(typeof(h.name_suffix))'');
    populated_name_score_pcnt := AVE(GROUP,IF(h.name_score = (TYPEOF(h.name_score))'',0,100));
    maxlength_name_score := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.name_score)));
    avelength_name_score := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.name_score)),h.name_score<>(typeof(h.name_score))'');
    populated_prim_range_pcnt := AVE(GROUP,IF(h.prim_range = (TYPEOF(h.prim_range))'',0,100));
    maxlength_prim_range := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.prim_range)));
    avelength_prim_range := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.prim_range)),h.prim_range<>(typeof(h.prim_range))'');
    populated_predir_pcnt := AVE(GROUP,IF(h.predir = (TYPEOF(h.predir))'',0,100));
    maxlength_predir := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.predir)));
    avelength_predir := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.predir)),h.predir<>(typeof(h.predir))'');
    populated_prim_name_pcnt := AVE(GROUP,IF(h.prim_name = (TYPEOF(h.prim_name))'',0,100));
    maxlength_prim_name := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.prim_name)));
    avelength_prim_name := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.prim_name)),h.prim_name<>(typeof(h.prim_name))'');
    populated_addr_suffix_pcnt := AVE(GROUP,IF(h.addr_suffix = (TYPEOF(h.addr_suffix))'',0,100));
    maxlength_addr_suffix := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.addr_suffix)));
    avelength_addr_suffix := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.addr_suffix)),h.addr_suffix<>(typeof(h.addr_suffix))'');
    populated_postdir_pcnt := AVE(GROUP,IF(h.postdir = (TYPEOF(h.postdir))'',0,100));
    maxlength_postdir := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.postdir)));
    avelength_postdir := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.postdir)),h.postdir<>(typeof(h.postdir))'');
    populated_unit_desig_pcnt := AVE(GROUP,IF(h.unit_desig = (TYPEOF(h.unit_desig))'',0,100));
    maxlength_unit_desig := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.unit_desig)));
    avelength_unit_desig := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.unit_desig)),h.unit_desig<>(typeof(h.unit_desig))'');
    populated_sec_range_pcnt := AVE(GROUP,IF(h.sec_range = (TYPEOF(h.sec_range))'',0,100));
    maxlength_sec_range := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.sec_range)));
    avelength_sec_range := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.sec_range)),h.sec_range<>(typeof(h.sec_range))'');
    populated_p_city_name_pcnt := AVE(GROUP,IF(h.p_city_name = (TYPEOF(h.p_city_name))'',0,100));
    maxlength_p_city_name := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.p_city_name)));
    avelength_p_city_name := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.p_city_name)),h.p_city_name<>(typeof(h.p_city_name))'');
    populated_v_city_name_pcnt := AVE(GROUP,IF(h.v_city_name = (TYPEOF(h.v_city_name))'',0,100));
    maxlength_v_city_name := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.v_city_name)));
    avelength_v_city_name := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.v_city_name)),h.v_city_name<>(typeof(h.v_city_name))'');
    populated_st_pcnt := AVE(GROUP,IF(h.st = (TYPEOF(h.st))'',0,100));
    maxlength_st := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.st)));
    avelength_st := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.st)),h.st<>(typeof(h.st))'');
    populated_zip_pcnt := AVE(GROUP,IF(h.zip = (TYPEOF(h.zip))'',0,100));
    maxlength_zip := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.zip)));
    avelength_zip := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.zip)),h.zip<>(typeof(h.zip))'');
    populated_zip4_pcnt := AVE(GROUP,IF(h.zip4 = (TYPEOF(h.zip4))'',0,100));
    maxlength_zip4 := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.zip4)));
    avelength_zip4 := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.zip4)),h.zip4<>(typeof(h.zip4))'');
    populated_cart_pcnt := AVE(GROUP,IF(h.cart = (TYPEOF(h.cart))'',0,100));
    maxlength_cart := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.cart)));
    avelength_cart := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.cart)),h.cart<>(typeof(h.cart))'');
    populated_cr_sort_sz_pcnt := AVE(GROUP,IF(h.cr_sort_sz = (TYPEOF(h.cr_sort_sz))'',0,100));
    maxlength_cr_sort_sz := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.cr_sort_sz)));
    avelength_cr_sort_sz := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.cr_sort_sz)),h.cr_sort_sz<>(typeof(h.cr_sort_sz))'');
    populated_lot_pcnt := AVE(GROUP,IF(h.lot = (TYPEOF(h.lot))'',0,100));
    maxlength_lot := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.lot)));
    avelength_lot := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.lot)),h.lot<>(typeof(h.lot))'');
    populated_lot_order_pcnt := AVE(GROUP,IF(h.lot_order = (TYPEOF(h.lot_order))'',0,100));
    maxlength_lot_order := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.lot_order)));
    avelength_lot_order := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.lot_order)),h.lot_order<>(typeof(h.lot_order))'');
    populated_dbpc_pcnt := AVE(GROUP,IF(h.dbpc = (TYPEOF(h.dbpc))'',0,100));
    maxlength_dbpc := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.dbpc)));
    avelength_dbpc := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.dbpc)),h.dbpc<>(typeof(h.dbpc))'');
    populated_chk_digit_pcnt := AVE(GROUP,IF(h.chk_digit = (TYPEOF(h.chk_digit))'',0,100));
    maxlength_chk_digit := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.chk_digit)));
    avelength_chk_digit := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.chk_digit)),h.chk_digit<>(typeof(h.chk_digit))'');
    populated_rec_type_pcnt := AVE(GROUP,IF(h.rec_type = (TYPEOF(h.rec_type))'',0,100));
    maxlength_rec_type := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.rec_type)));
    avelength_rec_type := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.rec_type)),h.rec_type<>(typeof(h.rec_type))'');
    populated_county_pcnt := AVE(GROUP,IF(h.county = (TYPEOF(h.county))'',0,100));
    maxlength_county := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.county)));
    avelength_county := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.county)),h.county<>(typeof(h.county))'');
    populated_geo_lat_pcnt := AVE(GROUP,IF(h.geo_lat = (TYPEOF(h.geo_lat))'',0,100));
    maxlength_geo_lat := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.geo_lat)));
    avelength_geo_lat := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.geo_lat)),h.geo_lat<>(typeof(h.geo_lat))'');
    populated_geo_long_pcnt := AVE(GROUP,IF(h.geo_long = (TYPEOF(h.geo_long))'',0,100));
    maxlength_geo_long := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.geo_long)));
    avelength_geo_long := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.geo_long)),h.geo_long<>(typeof(h.geo_long))'');
    populated_msa_pcnt := AVE(GROUP,IF(h.msa = (TYPEOF(h.msa))'',0,100));
    maxlength_msa := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.msa)));
    avelength_msa := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.msa)),h.msa<>(typeof(h.msa))'');
    populated_geo_blk_pcnt := AVE(GROUP,IF(h.geo_blk = (TYPEOF(h.geo_blk))'',0,100));
    maxlength_geo_blk := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.geo_blk)));
    avelength_geo_blk := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.geo_blk)),h.geo_blk<>(typeof(h.geo_blk))'');
    populated_geo_match_pcnt := AVE(GROUP,IF(h.geo_match = (TYPEOF(h.geo_match))'',0,100));
    maxlength_geo_match := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.geo_match)));
    avelength_geo_match := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.geo_match)),h.geo_match<>(typeof(h.geo_match))'');
    populated_err_stat_pcnt := AVE(GROUP,IF(h.err_stat = (TYPEOF(h.err_stat))'',0,100));
    maxlength_err_stat := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.err_stat)));
    avelength_err_stat := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.err_stat)),h.err_stat<>(typeof(h.err_stat))'');
    populated_transferdate_unformatted_pcnt := AVE(GROUP,IF(h.transferdate_unformatted = (TYPEOF(h.transferdate_unformatted))'',0,100));
    maxlength_transferdate_unformatted := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.transferdate_unformatted)));
    avelength_transferdate_unformatted := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.transferdate_unformatted)),h.transferdate_unformatted<>(typeof(h.transferdate_unformatted))'');
    populated_birthdate_unformatted_pcnt := AVE(GROUP,IF(h.birthdate_unformatted = (TYPEOF(h.birthdate_unformatted))'',0,100));
    maxlength_birthdate_unformatted := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.birthdate_unformatted)));
    avelength_birthdate_unformatted := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.birthdate_unformatted)),h.birthdate_unformatted<>(typeof(h.birthdate_unformatted))'');
    populated_dob_no_conflict_pcnt := AVE(GROUP,IF(h.dob_no_conflict = (TYPEOF(h.dob_no_conflict))'',0,100));
    maxlength_dob_no_conflict := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.dob_no_conflict)));
    avelength_dob_no_conflict := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.dob_no_conflict)),h.dob_no_conflict<>(typeof(h.dob_no_conflict))'');
    populated_updatedate_unformatted_pcnt := AVE(GROUP,IF(h.updatedate_unformatted = (TYPEOF(h.updatedate_unformatted))'',0,100));
    maxlength_updatedate_unformatted := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.updatedate_unformatted)));
    avelength_updatedate_unformatted := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.updatedate_unformatted)),h.updatedate_unformatted<>(typeof(h.updatedate_unformatted))'');
    populated_consumerupdatedate_unformatted_pcnt := AVE(GROUP,IF(h.consumerupdatedate_unformatted = (TYPEOF(h.consumerupdatedate_unformatted))'',0,100));
    maxlength_consumerupdatedate_unformatted := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.consumerupdatedate_unformatted)));
    avelength_consumerupdatedate_unformatted := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.consumerupdatedate_unformatted)),h.consumerupdatedate_unformatted<>(typeof(h.consumerupdatedate_unformatted))'');
    populated_filesincedate_unformatted_pcnt := AVE(GROUP,IF(h.filesincedate_unformatted = (TYPEOF(h.filesincedate_unformatted))'',0,100));
    maxlength_filesincedate_unformatted := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.filesincedate_unformatted)));
    avelength_filesincedate_unformatted := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.filesincedate_unformatted)),h.filesincedate_unformatted<>(typeof(h.filesincedate_unformatted))'');
    populated_compilationdate_unformatted_pcnt := AVE(GROUP,IF(h.compilationdate_unformatted = (TYPEOF(h.compilationdate_unformatted))'',0,100));
    maxlength_compilationdate_unformatted := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.compilationdate_unformatted)));
    avelength_compilationdate_unformatted := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.compilationdate_unformatted)),h.compilationdate_unformatted<>(typeof(h.compilationdate_unformatted))'');
    populated_ssn_unformatted_pcnt := AVE(GROUP,IF(h.ssn_unformatted = (TYPEOF(h.ssn_unformatted))'',0,100));
    maxlength_ssn_unformatted := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.ssn_unformatted)));
    avelength_ssn_unformatted := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.ssn_unformatted)),h.ssn_unformatted<>(typeof(h.ssn_unformatted))'');
    populated_ssn_no_conflict_pcnt := AVE(GROUP,IF(h.ssn_no_conflict = (TYPEOF(h.ssn_no_conflict))'',0,100));
    maxlength_ssn_no_conflict := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.ssn_no_conflict)));
    avelength_ssn_no_conflict := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.ssn_no_conflict)),h.ssn_no_conflict<>(typeof(h.ssn_no_conflict))'');
    populated_telephone_unformatted_pcnt := AVE(GROUP,IF(h.telephone_unformatted = (TYPEOF(h.telephone_unformatted))'',0,100));
    maxlength_telephone_unformatted := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.telephone_unformatted)));
    avelength_telephone_unformatted := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.telephone_unformatted)),h.telephone_unformatted<>(typeof(h.telephone_unformatted))'');
    populated_deceasedindicator_pcnt := AVE(GROUP,IF(h.deceasedindicator = (TYPEOF(h.deceasedindicator))'',0,100));
    maxlength_deceasedindicator := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.deceasedindicator)));
    avelength_deceasedindicator := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.deceasedindicator)),h.deceasedindicator<>(typeof(h.deceasedindicator))'');
    populated_did_pcnt := AVE(GROUP,IF(h.did = (TYPEOF(h.did))'',0,100));
    maxlength_did := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.did)));
    avelength_did := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.did)),h.did<>(typeof(h.did))'');
    populated_did_score_field_pcnt := AVE(GROUP,IF(h.did_score_field = (TYPEOF(h.did_score_field))'',0,100));
    maxlength_did_score_field := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.did_score_field)));
    avelength_did_score_field := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.did_score_field)),h.did_score_field<>(typeof(h.did_score_field))'');
    populated_is_current_pcnt := AVE(GROUP,IF(h.is_current = (TYPEOF(h.is_current))'',0,100));
    maxlength_is_current := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.is_current)));
    avelength_is_current := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.is_current)),h.is_current<>(typeof(h.is_current))'');
  END;
    T := TABLE(h,SummaryLayout);
  R1 := RECORD
    UNSIGNED LinkingPotential :=  + T.Populated_dt_first_seen_pcnt *   0.00 / 100 + T.Populated_dt_last_seen_pcnt *   0.00 / 100 + T.Populated_dt_vendor_first_reported_pcnt *   0.00 / 100 + T.Populated_dt_vendor_last_reported_pcnt *   0.00 / 100 + T.Populated_filetype_pcnt *   0.00 / 100 + T.Populated_filedate_pcnt *   0.00 / 100 + T.Populated_vendordocumentidentifier_pcnt *   0.00 / 100 + T.Populated_transferdate_pcnt *   0.00 / 100 + T.Populated_currentname_firstname_pcnt *   0.00 / 100 + T.Populated_currentname_middlename_pcnt *   0.00 / 100 + T.Populated_currentname_middleinitial_pcnt *   0.00 / 100 + T.Populated_currentname_lastname_pcnt *   0.00 / 100 + T.Populated_currentname_suffix_pcnt *   0.00 / 100 + T.Populated_currentname_gender_pcnt *   0.00 / 100 + T.Populated_currentname_dob_mm_pcnt *   0.00 / 100 + T.Populated_currentname_dob_dd_pcnt *   0.00 / 100 + T.Populated_currentname_dob_yyyy_pcnt *   0.00 / 100 + T.Populated_currentname_deathindicator_pcnt *   0.00 / 100 + T.Populated_ssnfull_pcnt *   0.00 / 100 + T.Populated_ssnfirst5digit_pcnt *   0.00 / 100 + T.Populated_ssnlast4digit_pcnt *   0.00 / 100 + T.Populated_consumerupdatedate_pcnt *   0.00 / 100 + T.Populated_telephonenumber_pcnt *   0.00 / 100 + T.Populated_citedid_pcnt *   0.00 / 100 + T.Populated_fileid_pcnt *   0.00 / 100 + T.Populated_publication_pcnt *   0.00 / 100 + T.Populated_currentaddress_address1_pcnt *   0.00 / 100 + T.Populated_currentaddress_address2_pcnt *   0.00 / 100 + T.Populated_currentaddress_city_pcnt *   0.00 / 100 + T.Populated_currentaddress_state_pcnt *   0.00 / 100 + T.Populated_currentaddress_zipcode_pcnt *   0.00 / 100 + T.Populated_currentaddress_updateddate_pcnt *   0.00 / 100 + T.Populated_housenumber_pcnt *   0.00 / 100 + T.Populated_streettype_pcnt *   0.00 / 100 + T.Populated_streetdirection_pcnt *   0.00 / 100 + T.Populated_streetname_pcnt *   0.00 / 100 + T.Populated_apartmentnumber_pcnt *   0.00 / 100 + T.Populated_city_pcnt *   0.00 / 100 + T.Populated_state_pcnt *   0.00 / 100 + T.Populated_zipcode_pcnt *   0.00 / 100 + T.Populated_zip4u_pcnt *   0.00 / 100 + T.Populated_previousaddress_address1_pcnt *   0.00 / 100 + T.Populated_previousaddress_address2_pcnt *   0.00 / 100 + T.Populated_previousaddress_city_pcnt *   0.00 / 100 + T.Populated_previousaddress_state_pcnt *   0.00 / 100 + T.Populated_previousaddress_zipcode_pcnt *   0.00 / 100 + T.Populated_previousaddress_updateddate_pcnt *   0.00 / 100 + T.Populated_formername_firstname_pcnt *   0.00 / 100 + T.Populated_formername_middlename_pcnt *   0.00 / 100 + T.Populated_formername_middleinitial_pcnt *   0.00 / 100 + T.Populated_formername_lastname_pcnt *   0.00 / 100 + T.Populated_formername_suffix_pcnt *   0.00 / 100 + T.Populated_aliasname_firstname_pcnt *   0.00 / 100 + T.Populated_aliasname_middlename_pcnt *   0.00 / 100 + T.Populated_aliasname_middleinitial_pcnt *   0.00 / 100 + T.Populated_aliasname_lastname_pcnt *   0.00 / 100 + T.Populated_aliasname_suffix_pcnt *   0.00 / 100 + T.Populated_additionalname_firstname_pcnt *   0.00 / 100 + T.Populated_additionalname_middlename_pcnt *   0.00 / 100 + T.Populated_additionalname_middleinitial_pcnt *   0.00 / 100 + T.Populated_additionalname_lastname_pcnt *   0.00 / 100 + T.Populated_additionalname_suffix_pcnt *   0.00 / 100 + T.Populated_aka1_pcnt *   0.00 / 100 + T.Populated_aka2_pcnt *   0.00 / 100 + T.Populated_aka3_pcnt *   0.00 / 100 + T.Populated_recordtype_pcnt *   0.00 / 100 + T.Populated_addressstandardization_pcnt *   0.00 / 100 + T.Populated_filesincedate_pcnt *   0.00 / 100 + T.Populated_compilationdate_pcnt *   0.00 / 100 + T.Populated_birthdateind_pcnt *   0.00 / 100 + T.Populated_orig_deceasedindicator_pcnt *   0.00 / 100 + T.Populated_deceaseddate_pcnt *   0.00 / 100 + T.Populated_addressseq_pcnt *   0.00 / 100 + T.Populated_normaddress_address1_pcnt *   0.00 / 100 + T.Populated_normaddress_address2_pcnt *   0.00 / 100 + T.Populated_normaddress_city_pcnt *   0.00 / 100 + T.Populated_normaddress_state_pcnt *   0.00 / 100 + T.Populated_normaddress_zipcode_pcnt *   0.00 / 100 + T.Populated_normaddress_updateddate_pcnt *   0.00 / 100 + T.Populated_name_pcnt *   0.00 / 100 + T.Populated_nametype_pcnt *   0.00 / 100 + T.Populated_title_pcnt *   0.00 / 100 + T.Populated_fname_pcnt *   0.00 / 100 + T.Populated_mname_pcnt *   0.00 / 100 + T.Populated_lname_pcnt *   0.00 / 100 + T.Populated_name_suffix_pcnt *   0.00 / 100 + T.Populated_name_score_pcnt *   0.00 / 100 + T.Populated_prim_range_pcnt *   0.00 / 100 + T.Populated_predir_pcnt *   0.00 / 100 + T.Populated_prim_name_pcnt *   0.00 / 100 + T.Populated_addr_suffix_pcnt *   0.00 / 100 + T.Populated_postdir_pcnt *   0.00 / 100 + T.Populated_unit_desig_pcnt *   0.00 / 100 + T.Populated_sec_range_pcnt *   0.00 / 100 + T.Populated_p_city_name_pcnt *   0.00 / 100 + T.Populated_v_city_name_pcnt *   0.00 / 100 + T.Populated_st_pcnt *   0.00 / 100 + T.Populated_zip_pcnt *   0.00 / 100 + T.Populated_zip4_pcnt *   0.00 / 100 + T.Populated_cart_pcnt *   0.00 / 100 + T.Populated_cr_sort_sz_pcnt *   0.00 / 100 + T.Populated_lot_pcnt *   0.00 / 100 + T.Populated_lot_order_pcnt *   0.00 / 100 + T.Populated_dbpc_pcnt *   0.00 / 100 + T.Populated_chk_digit_pcnt *   0.00 / 100 + T.Populated_rec_type_pcnt *   0.00 / 100 + T.Populated_county_pcnt *   0.00 / 100 + T.Populated_geo_lat_pcnt *   0.00 / 100 + T.Populated_geo_long_pcnt *   0.00 / 100 + T.Populated_msa_pcnt *   0.00 / 100 + T.Populated_geo_blk_pcnt *   0.00 / 100 + T.Populated_geo_match_pcnt *   0.00 / 100 + T.Populated_err_stat_pcnt *   0.00 / 100 + T.Populated_transferdate_unformatted_pcnt *   0.00 / 100 + T.Populated_birthdate_unformatted_pcnt *   0.00 / 100 + T.Populated_dob_no_conflict_pcnt *   0.00 / 100 + T.Populated_updatedate_unformatted_pcnt *   0.00 / 100 + T.Populated_consumerupdatedate_unformatted_pcnt *   0.00 / 100 + T.Populated_filesincedate_unformatted_pcnt *   0.00 / 100 + T.Populated_compilationdate_unformatted_pcnt *   0.00 / 100 + T.Populated_ssn_unformatted_pcnt *   0.00 / 100 + T.Populated_ssn_no_conflict_pcnt *   0.00 / 100 + T.Populated_telephone_unformatted_pcnt *   0.00 / 100 + T.Populated_deceasedindicator_pcnt *   0.00 / 100 + T.Populated_did_pcnt *   0.00 / 100 + T.Populated_did_score_field_pcnt *   0.00 / 100 + T.Populated_is_current_pcnt *   0.00 / 100;
    T;
  END;
  RETURN TABLE(T,R1);
END;
 
summary0 := Summary('Summary');
invRec := RECORD
  UNSIGNED  FldNo;
  SALT34.StrType FieldName;
  UNSIGNED NumberOfRecords;
  REAL8  populated_pcnt;
  UNSIGNED  maxlength;
  REAL8  avelength;
END;
invRec invert(summary0 le, INTEGER C) := TRANSFORM
  SELF.FldNo := C;
  SELF.NumberOfRecords := le.NumberOfRecords;
  SELF.FieldName := CHOOSE(C,'dt_first_seen','dt_last_seen','dt_vendor_first_reported','dt_vendor_last_reported','filetype','filedate','vendordocumentidentifier','transferdate','currentname_firstname','currentname_middlename','currentname_middleinitial','currentname_lastname','currentname_suffix','currentname_gender','currentname_dob_mm','currentname_dob_dd','currentname_dob_yyyy','currentname_deathindicator','ssnfull','ssnfirst5digit','ssnlast4digit','consumerupdatedate','telephonenumber','citedid','fileid','publication','currentaddress_address1','currentaddress_address2','currentaddress_city','currentaddress_state','currentaddress_zipcode','currentaddress_updateddate','housenumber','streettype','streetdirection','streetname','apartmentnumber','city','state','zipcode','zip4u','previousaddress_address1','previousaddress_address2','previousaddress_city','previousaddress_state','previousaddress_zipcode','previousaddress_updateddate','formername_firstname','formername_middlename','formername_middleinitial','formername_lastname','formername_suffix','aliasname_firstname','aliasname_middlename','aliasname_middleinitial','aliasname_lastname','aliasname_suffix','additionalname_firstname','additionalname_middlename','additionalname_middleinitial','additionalname_lastname','additionalname_suffix','aka1','aka2','aka3','recordtype','addressstandardization','filesincedate','compilationdate','birthdateind','orig_deceasedindicator','deceaseddate','addressseq','normaddress_address1','normaddress_address2','normaddress_city','normaddress_state','normaddress_zipcode','normaddress_updateddate','name','nametype','title','fname','mname','lname','name_suffix','name_score','prim_range','predir','prim_name','addr_suffix','postdir','unit_desig','sec_range','p_city_name','v_city_name','st','zip','zip4','cart','cr_sort_sz','lot','lot_order','dbpc','chk_digit','rec_type','county','geo_lat','geo_long','msa','geo_blk','geo_match','err_stat','transferdate_unformatted','birthdate_unformatted','dob_no_conflict','updatedate_unformatted','consumerupdatedate_unformatted','filesincedate_unformatted','compilationdate_unformatted','ssn_unformatted','ssn_no_conflict','telephone_unformatted','deceasedindicator','did','did_score_field','is_current');
  SELF.populated_pcnt := CHOOSE(C,le.populated_dt_first_seen_pcnt,le.populated_dt_last_seen_pcnt,le.populated_dt_vendor_first_reported_pcnt,le.populated_dt_vendor_last_reported_pcnt,le.populated_filetype_pcnt,le.populated_filedate_pcnt,le.populated_vendordocumentidentifier_pcnt,le.populated_transferdate_pcnt,le.populated_currentname_firstname_pcnt,le.populated_currentname_middlename_pcnt,le.populated_currentname_middleinitial_pcnt,le.populated_currentname_lastname_pcnt,le.populated_currentname_suffix_pcnt,le.populated_currentname_gender_pcnt,le.populated_currentname_dob_mm_pcnt,le.populated_currentname_dob_dd_pcnt,le.populated_currentname_dob_yyyy_pcnt,le.populated_currentname_deathindicator_pcnt,le.populated_ssnfull_pcnt,le.populated_ssnfirst5digit_pcnt,le.populated_ssnlast4digit_pcnt,le.populated_consumerupdatedate_pcnt,le.populated_telephonenumber_pcnt,le.populated_citedid_pcnt,le.populated_fileid_pcnt,le.populated_publication_pcnt,le.populated_currentaddress_address1_pcnt,le.populated_currentaddress_address2_pcnt,le.populated_currentaddress_city_pcnt,le.populated_currentaddress_state_pcnt,le.populated_currentaddress_zipcode_pcnt,le.populated_currentaddress_updateddate_pcnt,le.populated_housenumber_pcnt,le.populated_streettype_pcnt,le.populated_streetdirection_pcnt,le.populated_streetname_pcnt,le.populated_apartmentnumber_pcnt,le.populated_city_pcnt,le.populated_state_pcnt,le.populated_zipcode_pcnt,le.populated_zip4u_pcnt,le.populated_previousaddress_address1_pcnt,le.populated_previousaddress_address2_pcnt,le.populated_previousaddress_city_pcnt,le.populated_previousaddress_state_pcnt,le.populated_previousaddress_zipcode_pcnt,le.populated_previousaddress_updateddate_pcnt,le.populated_formername_firstname_pcnt,le.populated_formername_middlename_pcnt,le.populated_formername_middleinitial_pcnt,le.populated_formername_lastname_pcnt,le.populated_formername_suffix_pcnt,le.populated_aliasname_firstname_pcnt,le.populated_aliasname_middlename_pcnt,le.populated_aliasname_middleinitial_pcnt,le.populated_aliasname_lastname_pcnt,le.populated_aliasname_suffix_pcnt,le.populated_additionalname_firstname_pcnt,le.populated_additionalname_middlename_pcnt,le.populated_additionalname_middleinitial_pcnt,le.populated_additionalname_lastname_pcnt,le.populated_additionalname_suffix_pcnt,le.populated_aka1_pcnt,le.populated_aka2_pcnt,le.populated_aka3_pcnt,le.populated_recordtype_pcnt,le.populated_addressstandardization_pcnt,le.populated_filesincedate_pcnt,le.populated_compilationdate_pcnt,le.populated_birthdateind_pcnt,le.populated_orig_deceasedindicator_pcnt,le.populated_deceaseddate_pcnt,le.populated_addressseq_pcnt,le.populated_normaddress_address1_pcnt,le.populated_normaddress_address2_pcnt,le.populated_normaddress_city_pcnt,le.populated_normaddress_state_pcnt,le.populated_normaddress_zipcode_pcnt,le.populated_normaddress_updateddate_pcnt,le.populated_name_pcnt,le.populated_nametype_pcnt,le.populated_title_pcnt,le.populated_fname_pcnt,le.populated_mname_pcnt,le.populated_lname_pcnt,le.populated_name_suffix_pcnt,le.populated_name_score_pcnt,le.populated_prim_range_pcnt,le.populated_predir_pcnt,le.populated_prim_name_pcnt,le.populated_addr_suffix_pcnt,le.populated_postdir_pcnt,le.populated_unit_desig_pcnt,le.populated_sec_range_pcnt,le.populated_p_city_name_pcnt,le.populated_v_city_name_pcnt,le.populated_st_pcnt,le.populated_zip_pcnt,le.populated_zip4_pcnt,le.populated_cart_pcnt,le.populated_cr_sort_sz_pcnt,le.populated_lot_pcnt,le.populated_lot_order_pcnt,le.populated_dbpc_pcnt,le.populated_chk_digit_pcnt,le.populated_rec_type_pcnt,le.populated_county_pcnt,le.populated_geo_lat_pcnt,le.populated_geo_long_pcnt,le.populated_msa_pcnt,le.populated_geo_blk_pcnt,le.populated_geo_match_pcnt,le.populated_err_stat_pcnt,le.populated_transferdate_unformatted_pcnt,le.populated_birthdate_unformatted_pcnt,le.populated_dob_no_conflict_pcnt,le.populated_updatedate_unformatted_pcnt,le.populated_consumerupdatedate_unformatted_pcnt,le.populated_filesincedate_unformatted_pcnt,le.populated_compilationdate_unformatted_pcnt,le.populated_ssn_unformatted_pcnt,le.populated_ssn_no_conflict_pcnt,le.populated_telephone_unformatted_pcnt,le.populated_deceasedindicator_pcnt,le.populated_did_pcnt,le.populated_did_score_field_pcnt,le.populated_is_current_pcnt);
  SELF.maxlength := CHOOSE(C,le.maxlength_dt_first_seen,le.maxlength_dt_last_seen,le.maxlength_dt_vendor_first_reported,le.maxlength_dt_vendor_last_reported,le.maxlength_filetype,le.maxlength_filedate,le.maxlength_vendordocumentidentifier,le.maxlength_transferdate,le.maxlength_currentname_firstname,le.maxlength_currentname_middlename,le.maxlength_currentname_middleinitial,le.maxlength_currentname_lastname,le.maxlength_currentname_suffix,le.maxlength_currentname_gender,le.maxlength_currentname_dob_mm,le.maxlength_currentname_dob_dd,le.maxlength_currentname_dob_yyyy,le.maxlength_currentname_deathindicator,le.maxlength_ssnfull,le.maxlength_ssnfirst5digit,le.maxlength_ssnlast4digit,le.maxlength_consumerupdatedate,le.maxlength_telephonenumber,le.maxlength_citedid,le.maxlength_fileid,le.maxlength_publication,le.maxlength_currentaddress_address1,le.maxlength_currentaddress_address2,le.maxlength_currentaddress_city,le.maxlength_currentaddress_state,le.maxlength_currentaddress_zipcode,le.maxlength_currentaddress_updateddate,le.maxlength_housenumber,le.maxlength_streettype,le.maxlength_streetdirection,le.maxlength_streetname,le.maxlength_apartmentnumber,le.maxlength_city,le.maxlength_state,le.maxlength_zipcode,le.maxlength_zip4u,le.maxlength_previousaddress_address1,le.maxlength_previousaddress_address2,le.maxlength_previousaddress_city,le.maxlength_previousaddress_state,le.maxlength_previousaddress_zipcode,le.maxlength_previousaddress_updateddate,le.maxlength_formername_firstname,le.maxlength_formername_middlename,le.maxlength_formername_middleinitial,le.maxlength_formername_lastname,le.maxlength_formername_suffix,le.maxlength_aliasname_firstname,le.maxlength_aliasname_middlename,le.maxlength_aliasname_middleinitial,le.maxlength_aliasname_lastname,le.maxlength_aliasname_suffix,le.maxlength_additionalname_firstname,le.maxlength_additionalname_middlename,le.maxlength_additionalname_middleinitial,le.maxlength_additionalname_lastname,le.maxlength_additionalname_suffix,le.maxlength_aka1,le.maxlength_aka2,le.maxlength_aka3,le.maxlength_recordtype,le.maxlength_addressstandardization,le.maxlength_filesincedate,le.maxlength_compilationdate,le.maxlength_birthdateind,le.maxlength_orig_deceasedindicator,le.maxlength_deceaseddate,le.maxlength_addressseq,le.maxlength_normaddress_address1,le.maxlength_normaddress_address2,le.maxlength_normaddress_city,le.maxlength_normaddress_state,le.maxlength_normaddress_zipcode,le.maxlength_normaddress_updateddate,le.maxlength_name,le.maxlength_nametype,le.maxlength_title,le.maxlength_fname,le.maxlength_mname,le.maxlength_lname,le.maxlength_name_suffix,le.maxlength_name_score,le.maxlength_prim_range,le.maxlength_predir,le.maxlength_prim_name,le.maxlength_addr_suffix,le.maxlength_postdir,le.maxlength_unit_desig,le.maxlength_sec_range,le.maxlength_p_city_name,le.maxlength_v_city_name,le.maxlength_st,le.maxlength_zip,le.maxlength_zip4,le.maxlength_cart,le.maxlength_cr_sort_sz,le.maxlength_lot,le.maxlength_lot_order,le.maxlength_dbpc,le.maxlength_chk_digit,le.maxlength_rec_type,le.maxlength_county,le.maxlength_geo_lat,le.maxlength_geo_long,le.maxlength_msa,le.maxlength_geo_blk,le.maxlength_geo_match,le.maxlength_err_stat,le.maxlength_transferdate_unformatted,le.maxlength_birthdate_unformatted,le.maxlength_dob_no_conflict,le.maxlength_updatedate_unformatted,le.maxlength_consumerupdatedate_unformatted,le.maxlength_filesincedate_unformatted,le.maxlength_compilationdate_unformatted,le.maxlength_ssn_unformatted,le.maxlength_ssn_no_conflict,le.maxlength_telephone_unformatted,le.maxlength_deceasedindicator,le.maxlength_did,le.maxlength_did_score_field,le.maxlength_is_current);
  SELF.avelength := CHOOSE(C,le.avelength_dt_first_seen,le.avelength_dt_last_seen,le.avelength_dt_vendor_first_reported,le.avelength_dt_vendor_last_reported,le.avelength_filetype,le.avelength_filedate,le.avelength_vendordocumentidentifier,le.avelength_transferdate,le.avelength_currentname_firstname,le.avelength_currentname_middlename,le.avelength_currentname_middleinitial,le.avelength_currentname_lastname,le.avelength_currentname_suffix,le.avelength_currentname_gender,le.avelength_currentname_dob_mm,le.avelength_currentname_dob_dd,le.avelength_currentname_dob_yyyy,le.avelength_currentname_deathindicator,le.avelength_ssnfull,le.avelength_ssnfirst5digit,le.avelength_ssnlast4digit,le.avelength_consumerupdatedate,le.avelength_telephonenumber,le.avelength_citedid,le.avelength_fileid,le.avelength_publication,le.avelength_currentaddress_address1,le.avelength_currentaddress_address2,le.avelength_currentaddress_city,le.avelength_currentaddress_state,le.avelength_currentaddress_zipcode,le.avelength_currentaddress_updateddate,le.avelength_housenumber,le.avelength_streettype,le.avelength_streetdirection,le.avelength_streetname,le.avelength_apartmentnumber,le.avelength_city,le.avelength_state,le.avelength_zipcode,le.avelength_zip4u,le.avelength_previousaddress_address1,le.avelength_previousaddress_address2,le.avelength_previousaddress_city,le.avelength_previousaddress_state,le.avelength_previousaddress_zipcode,le.avelength_previousaddress_updateddate,le.avelength_formername_firstname,le.avelength_formername_middlename,le.avelength_formername_middleinitial,le.avelength_formername_lastname,le.avelength_formername_suffix,le.avelength_aliasname_firstname,le.avelength_aliasname_middlename,le.avelength_aliasname_middleinitial,le.avelength_aliasname_lastname,le.avelength_aliasname_suffix,le.avelength_additionalname_firstname,le.avelength_additionalname_middlename,le.avelength_additionalname_middleinitial,le.avelength_additionalname_lastname,le.avelength_additionalname_suffix,le.avelength_aka1,le.avelength_aka2,le.avelength_aka3,le.avelength_recordtype,le.avelength_addressstandardization,le.avelength_filesincedate,le.avelength_compilationdate,le.avelength_birthdateind,le.avelength_orig_deceasedindicator,le.avelength_deceaseddate,le.avelength_addressseq,le.avelength_normaddress_address1,le.avelength_normaddress_address2,le.avelength_normaddress_city,le.avelength_normaddress_state,le.avelength_normaddress_zipcode,le.avelength_normaddress_updateddate,le.avelength_name,le.avelength_nametype,le.avelength_title,le.avelength_fname,le.avelength_mname,le.avelength_lname,le.avelength_name_suffix,le.avelength_name_score,le.avelength_prim_range,le.avelength_predir,le.avelength_prim_name,le.avelength_addr_suffix,le.avelength_postdir,le.avelength_unit_desig,le.avelength_sec_range,le.avelength_p_city_name,le.avelength_v_city_name,le.avelength_st,le.avelength_zip,le.avelength_zip4,le.avelength_cart,le.avelength_cr_sort_sz,le.avelength_lot,le.avelength_lot_order,le.avelength_dbpc,le.avelength_chk_digit,le.avelength_rec_type,le.avelength_county,le.avelength_geo_lat,le.avelength_geo_long,le.avelength_msa,le.avelength_geo_blk,le.avelength_geo_match,le.avelength_err_stat,le.avelength_transferdate_unformatted,le.avelength_birthdate_unformatted,le.avelength_dob_no_conflict,le.avelength_updatedate_unformatted,le.avelength_consumerupdatedate_unformatted,le.avelength_filesincedate_unformatted,le.avelength_compilationdate_unformatted,le.avelength_ssn_unformatted,le.avelength_ssn_no_conflict,le.avelength_telephone_unformatted,le.avelength_deceasedindicator,le.avelength_did,le.avelength_did_score_field,le.avelength_is_current);
END;
EXPORT invSummary := NORMALIZE(summary0, 127, invert(LEFT,COUNTER));
// The character counts
// Move everything into 'inverted list' form so processing can be done 'in library'
SALT34.MAC_Character_Counts.X_Data_Layout Into(h le,unsigned C) := TRANSFORM
  SELF.Fld := TRIM(CHOOSE(C,IF (le.dt_first_seen <> 0,TRIM((SALT34.StrType)le.dt_first_seen), ''),IF (le.dt_last_seen <> 0,TRIM((SALT34.StrType)le.dt_last_seen), ''),IF (le.dt_vendor_first_reported <> 0,TRIM((SALT34.StrType)le.dt_vendor_first_reported), ''),IF (le.dt_vendor_last_reported <> 0,TRIM((SALT34.StrType)le.dt_vendor_last_reported), ''),TRIM((SALT34.StrType)le.filetype),TRIM((SALT34.StrType)le.filedate),TRIM((SALT34.StrType)le.vendordocumentidentifier),TRIM((SALT34.StrType)le.transferdate),TRIM((SALT34.StrType)le.currentname_firstname),TRIM((SALT34.StrType)le.currentname_middlename),TRIM((SALT34.StrType)le.currentname_middleinitial),TRIM((SALT34.StrType)le.currentname_lastname),TRIM((SALT34.StrType)le.currentname_suffix),TRIM((SALT34.StrType)le.currentname_gender),TRIM((SALT34.StrType)le.currentname_dob_mm),TRIM((SALT34.StrType)le.currentname_dob_dd),TRIM((SALT34.StrType)le.currentname_dob_yyyy),TRIM((SALT34.StrType)le.currentname_deathindicator),TRIM((SALT34.StrType)le.ssnfull),TRIM((SALT34.StrType)le.ssnfirst5digit),TRIM((SALT34.StrType)le.ssnlast4digit),TRIM((SALT34.StrType)le.consumerupdatedate),TRIM((SALT34.StrType)le.telephonenumber),TRIM((SALT34.StrType)le.citedid),TRIM((SALT34.StrType)le.fileid),TRIM((SALT34.StrType)le.publication),TRIM((SALT34.StrType)le.currentaddress_address1),TRIM((SALT34.StrType)le.currentaddress_address2),TRIM((SALT34.StrType)le.currentaddress_city),TRIM((SALT34.StrType)le.currentaddress_state),TRIM((SALT34.StrType)le.currentaddress_zipcode),TRIM((SALT34.StrType)le.currentaddress_updateddate),TRIM((SALT34.StrType)le.housenumber),TRIM((SALT34.StrType)le.streettype),TRIM((SALT34.StrType)le.streetdirection),TRIM((SALT34.StrType)le.streetname),TRIM((SALT34.StrType)le.apartmentnumber),TRIM((SALT34.StrType)le.city),TRIM((SALT34.StrType)le.state),TRIM((SALT34.StrType)le.zipcode),TRIM((SALT34.StrType)le.zip4u),TRIM((SALT34.StrType)le.previousaddress_address1),TRIM((SALT34.StrType)le.previousaddress_address2),TRIM((SALT34.StrType)le.previousaddress_city),TRIM((SALT34.StrType)le.previousaddress_state),TRIM((SALT34.StrType)le.previousaddress_zipcode),TRIM((SALT34.StrType)le.previousaddress_updateddate),TRIM((SALT34.StrType)le.formername_firstname),TRIM((SALT34.StrType)le.formername_middlename),TRIM((SALT34.StrType)le.formername_middleinitial),TRIM((SALT34.StrType)le.formername_lastname),TRIM((SALT34.StrType)le.formername_suffix),TRIM((SALT34.StrType)le.aliasname_firstname),TRIM((SALT34.StrType)le.aliasname_middlename),TRIM((SALT34.StrType)le.aliasname_middleinitial),TRIM((SALT34.StrType)le.aliasname_lastname),TRIM((SALT34.StrType)le.aliasname_suffix),TRIM((SALT34.StrType)le.additionalname_firstname),TRIM((SALT34.StrType)le.additionalname_middlename),TRIM((SALT34.StrType)le.additionalname_middleinitial),TRIM((SALT34.StrType)le.additionalname_lastname),TRIM((SALT34.StrType)le.additionalname_suffix),TRIM((SALT34.StrType)le.aka1),TRIM((SALT34.StrType)le.aka2),TRIM((SALT34.StrType)le.aka3),TRIM((SALT34.StrType)le.recordtype),TRIM((SALT34.StrType)le.addressstandardization),TRIM((SALT34.StrType)le.filesincedate),TRIM((SALT34.StrType)le.compilationdate),TRIM((SALT34.StrType)le.birthdateind),TRIM((SALT34.StrType)le.orig_deceasedindicator),TRIM((SALT34.StrType)le.deceaseddate),IF (le.addressseq <> 0,TRIM((SALT34.StrType)le.addressseq), ''),TRIM((SALT34.StrType)le.normaddress_address1),TRIM((SALT34.StrType)le.normaddress_address2),TRIM((SALT34.StrType)le.normaddress_city),TRIM((SALT34.StrType)le.normaddress_state),TRIM((SALT34.StrType)le.normaddress_zipcode),TRIM((SALT34.StrType)le.normaddress_updateddate),TRIM((SALT34.StrType)le.name),TRIM((SALT34.StrType)le.nametype),TRIM((SALT34.StrType)le.title),TRIM((SALT34.StrType)le.fname),TRIM((SALT34.StrType)le.mname),TRIM((SALT34.StrType)le.lname),TRIM((SALT34.StrType)le.name_suffix),TRIM((SALT34.StrType)le.name_score),TRIM((SALT34.StrType)le.prim_range),TRIM((SALT34.StrType)le.predir),TRIM((SALT34.StrType)le.prim_name),TRIM((SALT34.StrType)le.addr_suffix),TRIM((SALT34.StrType)le.postdir),TRIM((SALT34.StrType)le.unit_desig),TRIM((SALT34.StrType)le.sec_range),TRIM((SALT34.StrType)le.p_city_name),TRIM((SALT34.StrType)le.v_city_name),TRIM((SALT34.StrType)le.st),TRIM((SALT34.StrType)le.zip),TRIM((SALT34.StrType)le.zip4),TRIM((SALT34.StrType)le.cart),TRIM((SALT34.StrType)le.cr_sort_sz),TRIM((SALT34.StrType)le.lot),TRIM((SALT34.StrType)le.lot_order),TRIM((SALT34.StrType)le.dbpc),TRIM((SALT34.StrType)le.chk_digit),TRIM((SALT34.StrType)le.rec_type),TRIM((SALT34.StrType)le.county),TRIM((SALT34.StrType)le.geo_lat),TRIM((SALT34.StrType)le.geo_long),TRIM((SALT34.StrType)le.msa),TRIM((SALT34.StrType)le.geo_blk),TRIM((SALT34.StrType)le.geo_match),TRIM((SALT34.StrType)le.err_stat),TRIM((SALT34.StrType)le.transferdate_unformatted),TRIM((SALT34.StrType)le.birthdate_unformatted),TRIM((SALT34.StrType)le.dob_no_conflict),TRIM((SALT34.StrType)le.updatedate_unformatted),TRIM((SALT34.StrType)le.consumerupdatedate_unformatted),TRIM((SALT34.StrType)le.filesincedate_unformatted),TRIM((SALT34.StrType)le.compilationdate_unformatted),TRIM((SALT34.StrType)le.ssn_unformatted),TRIM((SALT34.StrType)le.ssn_no_conflict),TRIM((SALT34.StrType)le.telephone_unformatted),TRIM((SALT34.StrType)le.deceasedindicator),IF (le.did <> 0,TRIM((SALT34.StrType)le.did), ''),IF (le.did_score_field <> 0,TRIM((SALT34.StrType)le.did_score_field), ''),TRIM((SALT34.StrType)le.is_current)));
  SELF.FldNo := C;
END;
SHARED FldInv0 := NORMALIZE(h,127,Into(LEFT,COUNTER));
// Move everything into 'pairs' form so processing can be done 'in library'
SALT34.MAC_Correlate.Data_Layout IntoP(h le,UNSIGNED C) := TRANSFORM
  SELF.FldNo1 := 1 + (C / 127);
  SELF.FldNo2 := 1 + (C % 127);
  SELF.Fld1 := TRIM(CHOOSE(SELF.FldNo1,IF (le.dt_first_seen <> 0,TRIM((SALT34.StrType)le.dt_first_seen), ''),IF (le.dt_last_seen <> 0,TRIM((SALT34.StrType)le.dt_last_seen), ''),IF (le.dt_vendor_first_reported <> 0,TRIM((SALT34.StrType)le.dt_vendor_first_reported), ''),IF (le.dt_vendor_last_reported <> 0,TRIM((SALT34.StrType)le.dt_vendor_last_reported), ''),TRIM((SALT34.StrType)le.filetype),TRIM((SALT34.StrType)le.filedate),TRIM((SALT34.StrType)le.vendordocumentidentifier),TRIM((SALT34.StrType)le.transferdate),TRIM((SALT34.StrType)le.currentname_firstname),TRIM((SALT34.StrType)le.currentname_middlename),TRIM((SALT34.StrType)le.currentname_middleinitial),TRIM((SALT34.StrType)le.currentname_lastname),TRIM((SALT34.StrType)le.currentname_suffix),TRIM((SALT34.StrType)le.currentname_gender),TRIM((SALT34.StrType)le.currentname_dob_mm),TRIM((SALT34.StrType)le.currentname_dob_dd),TRIM((SALT34.StrType)le.currentname_dob_yyyy),TRIM((SALT34.StrType)le.currentname_deathindicator),TRIM((SALT34.StrType)le.ssnfull),TRIM((SALT34.StrType)le.ssnfirst5digit),TRIM((SALT34.StrType)le.ssnlast4digit),TRIM((SALT34.StrType)le.consumerupdatedate),TRIM((SALT34.StrType)le.telephonenumber),TRIM((SALT34.StrType)le.citedid),TRIM((SALT34.StrType)le.fileid),TRIM((SALT34.StrType)le.publication),TRIM((SALT34.StrType)le.currentaddress_address1),TRIM((SALT34.StrType)le.currentaddress_address2),TRIM((SALT34.StrType)le.currentaddress_city),TRIM((SALT34.StrType)le.currentaddress_state),TRIM((SALT34.StrType)le.currentaddress_zipcode),TRIM((SALT34.StrType)le.currentaddress_updateddate),TRIM((SALT34.StrType)le.housenumber),TRIM((SALT34.StrType)le.streettype),TRIM((SALT34.StrType)le.streetdirection),TRIM((SALT34.StrType)le.streetname),TRIM((SALT34.StrType)le.apartmentnumber),TRIM((SALT34.StrType)le.city),TRIM((SALT34.StrType)le.state),TRIM((SALT34.StrType)le.zipcode),TRIM((SALT34.StrType)le.zip4u),TRIM((SALT34.StrType)le.previousaddress_address1),TRIM((SALT34.StrType)le.previousaddress_address2),TRIM((SALT34.StrType)le.previousaddress_city),TRIM((SALT34.StrType)le.previousaddress_state),TRIM((SALT34.StrType)le.previousaddress_zipcode),TRIM((SALT34.StrType)le.previousaddress_updateddate),TRIM((SALT34.StrType)le.formername_firstname),TRIM((SALT34.StrType)le.formername_middlename),TRIM((SALT34.StrType)le.formername_middleinitial),TRIM((SALT34.StrType)le.formername_lastname),TRIM((SALT34.StrType)le.formername_suffix),TRIM((SALT34.StrType)le.aliasname_firstname),TRIM((SALT34.StrType)le.aliasname_middlename),TRIM((SALT34.StrType)le.aliasname_middleinitial),TRIM((SALT34.StrType)le.aliasname_lastname),TRIM((SALT34.StrType)le.aliasname_suffix),TRIM((SALT34.StrType)le.additionalname_firstname),TRIM((SALT34.StrType)le.additionalname_middlename),TRIM((SALT34.StrType)le.additionalname_middleinitial),TRIM((SALT34.StrType)le.additionalname_lastname),TRIM((SALT34.StrType)le.additionalname_suffix),TRIM((SALT34.StrType)le.aka1),TRIM((SALT34.StrType)le.aka2),TRIM((SALT34.StrType)le.aka3),TRIM((SALT34.StrType)le.recordtype),TRIM((SALT34.StrType)le.addressstandardization),TRIM((SALT34.StrType)le.filesincedate),TRIM((SALT34.StrType)le.compilationdate),TRIM((SALT34.StrType)le.birthdateind),TRIM((SALT34.StrType)le.orig_deceasedindicator),TRIM((SALT34.StrType)le.deceaseddate),IF (le.addressseq <> 0,TRIM((SALT34.StrType)le.addressseq), ''),TRIM((SALT34.StrType)le.normaddress_address1),TRIM((SALT34.StrType)le.normaddress_address2),TRIM((SALT34.StrType)le.normaddress_city),TRIM((SALT34.StrType)le.normaddress_state),TRIM((SALT34.StrType)le.normaddress_zipcode),TRIM((SALT34.StrType)le.normaddress_updateddate),TRIM((SALT34.StrType)le.name),TRIM((SALT34.StrType)le.nametype),TRIM((SALT34.StrType)le.title),TRIM((SALT34.StrType)le.fname),TRIM((SALT34.StrType)le.mname),TRIM((SALT34.StrType)le.lname),TRIM((SALT34.StrType)le.name_suffix),TRIM((SALT34.StrType)le.name_score),TRIM((SALT34.StrType)le.prim_range),TRIM((SALT34.StrType)le.predir),TRIM((SALT34.StrType)le.prim_name),TRIM((SALT34.StrType)le.addr_suffix),TRIM((SALT34.StrType)le.postdir),TRIM((SALT34.StrType)le.unit_desig),TRIM((SALT34.StrType)le.sec_range),TRIM((SALT34.StrType)le.p_city_name),TRIM((SALT34.StrType)le.v_city_name),TRIM((SALT34.StrType)le.st),TRIM((SALT34.StrType)le.zip),TRIM((SALT34.StrType)le.zip4),TRIM((SALT34.StrType)le.cart),TRIM((SALT34.StrType)le.cr_sort_sz),TRIM((SALT34.StrType)le.lot),TRIM((SALT34.StrType)le.lot_order),TRIM((SALT34.StrType)le.dbpc),TRIM((SALT34.StrType)le.chk_digit),TRIM((SALT34.StrType)le.rec_type),TRIM((SALT34.StrType)le.county),TRIM((SALT34.StrType)le.geo_lat),TRIM((SALT34.StrType)le.geo_long),TRIM((SALT34.StrType)le.msa),TRIM((SALT34.StrType)le.geo_blk),TRIM((SALT34.StrType)le.geo_match),TRIM((SALT34.StrType)le.err_stat),TRIM((SALT34.StrType)le.transferdate_unformatted),TRIM((SALT34.StrType)le.birthdate_unformatted),TRIM((SALT34.StrType)le.dob_no_conflict),TRIM((SALT34.StrType)le.updatedate_unformatted),TRIM((SALT34.StrType)le.consumerupdatedate_unformatted),TRIM((SALT34.StrType)le.filesincedate_unformatted),TRIM((SALT34.StrType)le.compilationdate_unformatted),TRIM((SALT34.StrType)le.ssn_unformatted),TRIM((SALT34.StrType)le.ssn_no_conflict),TRIM((SALT34.StrType)le.telephone_unformatted),TRIM((SALT34.StrType)le.deceasedindicator),IF (le.did <> 0,TRIM((SALT34.StrType)le.did), ''),IF (le.did_score_field <> 0,TRIM((SALT34.StrType)le.did_score_field), ''),TRIM((SALT34.StrType)le.is_current)));
  SELF.Fld2 := TRIM(CHOOSE(SELF.FldNo2,IF (le.dt_first_seen <> 0,TRIM((SALT34.StrType)le.dt_first_seen), ''),IF (le.dt_last_seen <> 0,TRIM((SALT34.StrType)le.dt_last_seen), ''),IF (le.dt_vendor_first_reported <> 0,TRIM((SALT34.StrType)le.dt_vendor_first_reported), ''),IF (le.dt_vendor_last_reported <> 0,TRIM((SALT34.StrType)le.dt_vendor_last_reported), ''),TRIM((SALT34.StrType)le.filetype),TRIM((SALT34.StrType)le.filedate),TRIM((SALT34.StrType)le.vendordocumentidentifier),TRIM((SALT34.StrType)le.transferdate),TRIM((SALT34.StrType)le.currentname_firstname),TRIM((SALT34.StrType)le.currentname_middlename),TRIM((SALT34.StrType)le.currentname_middleinitial),TRIM((SALT34.StrType)le.currentname_lastname),TRIM((SALT34.StrType)le.currentname_suffix),TRIM((SALT34.StrType)le.currentname_gender),TRIM((SALT34.StrType)le.currentname_dob_mm),TRIM((SALT34.StrType)le.currentname_dob_dd),TRIM((SALT34.StrType)le.currentname_dob_yyyy),TRIM((SALT34.StrType)le.currentname_deathindicator),TRIM((SALT34.StrType)le.ssnfull),TRIM((SALT34.StrType)le.ssnfirst5digit),TRIM((SALT34.StrType)le.ssnlast4digit),TRIM((SALT34.StrType)le.consumerupdatedate),TRIM((SALT34.StrType)le.telephonenumber),TRIM((SALT34.StrType)le.citedid),TRIM((SALT34.StrType)le.fileid),TRIM((SALT34.StrType)le.publication),TRIM((SALT34.StrType)le.currentaddress_address1),TRIM((SALT34.StrType)le.currentaddress_address2),TRIM((SALT34.StrType)le.currentaddress_city),TRIM((SALT34.StrType)le.currentaddress_state),TRIM((SALT34.StrType)le.currentaddress_zipcode),TRIM((SALT34.StrType)le.currentaddress_updateddate),TRIM((SALT34.StrType)le.housenumber),TRIM((SALT34.StrType)le.streettype),TRIM((SALT34.StrType)le.streetdirection),TRIM((SALT34.StrType)le.streetname),TRIM((SALT34.StrType)le.apartmentnumber),TRIM((SALT34.StrType)le.city),TRIM((SALT34.StrType)le.state),TRIM((SALT34.StrType)le.zipcode),TRIM((SALT34.StrType)le.zip4u),TRIM((SALT34.StrType)le.previousaddress_address1),TRIM((SALT34.StrType)le.previousaddress_address2),TRIM((SALT34.StrType)le.previousaddress_city),TRIM((SALT34.StrType)le.previousaddress_state),TRIM((SALT34.StrType)le.previousaddress_zipcode),TRIM((SALT34.StrType)le.previousaddress_updateddate),TRIM((SALT34.StrType)le.formername_firstname),TRIM((SALT34.StrType)le.formername_middlename),TRIM((SALT34.StrType)le.formername_middleinitial),TRIM((SALT34.StrType)le.formername_lastname),TRIM((SALT34.StrType)le.formername_suffix),TRIM((SALT34.StrType)le.aliasname_firstname),TRIM((SALT34.StrType)le.aliasname_middlename),TRIM((SALT34.StrType)le.aliasname_middleinitial),TRIM((SALT34.StrType)le.aliasname_lastname),TRIM((SALT34.StrType)le.aliasname_suffix),TRIM((SALT34.StrType)le.additionalname_firstname),TRIM((SALT34.StrType)le.additionalname_middlename),TRIM((SALT34.StrType)le.additionalname_middleinitial),TRIM((SALT34.StrType)le.additionalname_lastname),TRIM((SALT34.StrType)le.additionalname_suffix),TRIM((SALT34.StrType)le.aka1),TRIM((SALT34.StrType)le.aka2),TRIM((SALT34.StrType)le.aka3),TRIM((SALT34.StrType)le.recordtype),TRIM((SALT34.StrType)le.addressstandardization),TRIM((SALT34.StrType)le.filesincedate),TRIM((SALT34.StrType)le.compilationdate),TRIM((SALT34.StrType)le.birthdateind),TRIM((SALT34.StrType)le.orig_deceasedindicator),TRIM((SALT34.StrType)le.deceaseddate),IF (le.addressseq <> 0,TRIM((SALT34.StrType)le.addressseq), ''),TRIM((SALT34.StrType)le.normaddress_address1),TRIM((SALT34.StrType)le.normaddress_address2),TRIM((SALT34.StrType)le.normaddress_city),TRIM((SALT34.StrType)le.normaddress_state),TRIM((SALT34.StrType)le.normaddress_zipcode),TRIM((SALT34.StrType)le.normaddress_updateddate),TRIM((SALT34.StrType)le.name),TRIM((SALT34.StrType)le.nametype),TRIM((SALT34.StrType)le.title),TRIM((SALT34.StrType)le.fname),TRIM((SALT34.StrType)le.mname),TRIM((SALT34.StrType)le.lname),TRIM((SALT34.StrType)le.name_suffix),TRIM((SALT34.StrType)le.name_score),TRIM((SALT34.StrType)le.prim_range),TRIM((SALT34.StrType)le.predir),TRIM((SALT34.StrType)le.prim_name),TRIM((SALT34.StrType)le.addr_suffix),TRIM((SALT34.StrType)le.postdir),TRIM((SALT34.StrType)le.unit_desig),TRIM((SALT34.StrType)le.sec_range),TRIM((SALT34.StrType)le.p_city_name),TRIM((SALT34.StrType)le.v_city_name),TRIM((SALT34.StrType)le.st),TRIM((SALT34.StrType)le.zip),TRIM((SALT34.StrType)le.zip4),TRIM((SALT34.StrType)le.cart),TRIM((SALT34.StrType)le.cr_sort_sz),TRIM((SALT34.StrType)le.lot),TRIM((SALT34.StrType)le.lot_order),TRIM((SALT34.StrType)le.dbpc),TRIM((SALT34.StrType)le.chk_digit),TRIM((SALT34.StrType)le.rec_type),TRIM((SALT34.StrType)le.county),TRIM((SALT34.StrType)le.geo_lat),TRIM((SALT34.StrType)le.geo_long),TRIM((SALT34.StrType)le.msa),TRIM((SALT34.StrType)le.geo_blk),TRIM((SALT34.StrType)le.geo_match),TRIM((SALT34.StrType)le.err_stat),TRIM((SALT34.StrType)le.transferdate_unformatted),TRIM((SALT34.StrType)le.birthdate_unformatted),TRIM((SALT34.StrType)le.dob_no_conflict),TRIM((SALT34.StrType)le.updatedate_unformatted),TRIM((SALT34.StrType)le.consumerupdatedate_unformatted),TRIM((SALT34.StrType)le.filesincedate_unformatted),TRIM((SALT34.StrType)le.compilationdate_unformatted),TRIM((SALT34.StrType)le.ssn_unformatted),TRIM((SALT34.StrType)le.ssn_no_conflict),TRIM((SALT34.StrType)le.telephone_unformatted),TRIM((SALT34.StrType)le.deceasedindicator),IF (le.did <> 0,TRIM((SALT34.StrType)le.did), ''),IF (le.did_score_field <> 0,TRIM((SALT34.StrType)le.did_score_field), ''),TRIM((SALT34.StrType)le.is_current)));
  END;
SHARED Pairs0 := NORMALIZE(ENTH(h,Config.CorrelateSampleSize),127*127,IntoP(LEFT,COUNTER))(FldNo1<FldNo2);
SHARED FldIds := DATASET([{1,'dt_first_seen'}
      ,{2,'dt_last_seen'}
      ,{3,'dt_vendor_first_reported'}
      ,{4,'dt_vendor_last_reported'}
      ,{5,'filetype'}
      ,{6,'filedate'}
      ,{7,'vendordocumentidentifier'}
      ,{8,'transferdate'}
      ,{9,'currentname_firstname'}
      ,{10,'currentname_middlename'}
      ,{11,'currentname_middleinitial'}
      ,{12,'currentname_lastname'}
      ,{13,'currentname_suffix'}
      ,{14,'currentname_gender'}
      ,{15,'currentname_dob_mm'}
      ,{16,'currentname_dob_dd'}
      ,{17,'currentname_dob_yyyy'}
      ,{18,'currentname_deathindicator'}
      ,{19,'ssnfull'}
      ,{20,'ssnfirst5digit'}
      ,{21,'ssnlast4digit'}
      ,{22,'consumerupdatedate'}
      ,{23,'telephonenumber'}
      ,{24,'citedid'}
      ,{25,'fileid'}
      ,{26,'publication'}
      ,{27,'currentaddress_address1'}
      ,{28,'currentaddress_address2'}
      ,{29,'currentaddress_city'}
      ,{30,'currentaddress_state'}
      ,{31,'currentaddress_zipcode'}
      ,{32,'currentaddress_updateddate'}
      ,{33,'housenumber'}
      ,{34,'streettype'}
      ,{35,'streetdirection'}
      ,{36,'streetname'}
      ,{37,'apartmentnumber'}
      ,{38,'city'}
      ,{39,'state'}
      ,{40,'zipcode'}
      ,{41,'zip4u'}
      ,{42,'previousaddress_address1'}
      ,{43,'previousaddress_address2'}
      ,{44,'previousaddress_city'}
      ,{45,'previousaddress_state'}
      ,{46,'previousaddress_zipcode'}
      ,{47,'previousaddress_updateddate'}
      ,{48,'formername_firstname'}
      ,{49,'formername_middlename'}
      ,{50,'formername_middleinitial'}
      ,{51,'formername_lastname'}
      ,{52,'formername_suffix'}
      ,{53,'aliasname_firstname'}
      ,{54,'aliasname_middlename'}
      ,{55,'aliasname_middleinitial'}
      ,{56,'aliasname_lastname'}
      ,{57,'aliasname_suffix'}
      ,{58,'additionalname_firstname'}
      ,{59,'additionalname_middlename'}
      ,{60,'additionalname_middleinitial'}
      ,{61,'additionalname_lastname'}
      ,{62,'additionalname_suffix'}
      ,{63,'aka1'}
      ,{64,'aka2'}
      ,{65,'aka3'}
      ,{66,'recordtype'}
      ,{67,'addressstandardization'}
      ,{68,'filesincedate'}
      ,{69,'compilationdate'}
      ,{70,'birthdateind'}
      ,{71,'orig_deceasedindicator'}
      ,{72,'deceaseddate'}
      ,{73,'addressseq'}
      ,{74,'normaddress_address1'}
      ,{75,'normaddress_address2'}
      ,{76,'normaddress_city'}
      ,{77,'normaddress_state'}
      ,{78,'normaddress_zipcode'}
      ,{79,'normaddress_updateddate'}
      ,{80,'name'}
      ,{81,'nametype'}
      ,{82,'title'}
      ,{83,'fname'}
      ,{84,'mname'}
      ,{85,'lname'}
      ,{86,'name_suffix'}
      ,{87,'name_score'}
      ,{88,'prim_range'}
      ,{89,'predir'}
      ,{90,'prim_name'}
      ,{91,'addr_suffix'}
      ,{92,'postdir'}
      ,{93,'unit_desig'}
      ,{94,'sec_range'}
      ,{95,'p_city_name'}
      ,{96,'v_city_name'}
      ,{97,'st'}
      ,{98,'zip'}
      ,{99,'zip4'}
      ,{100,'cart'}
      ,{101,'cr_sort_sz'}
      ,{102,'lot'}
      ,{103,'lot_order'}
      ,{104,'dbpc'}
      ,{105,'chk_digit'}
      ,{106,'rec_type'}
      ,{107,'county'}
      ,{108,'geo_lat'}
      ,{109,'geo_long'}
      ,{110,'msa'}
      ,{111,'geo_blk'}
      ,{112,'geo_match'}
      ,{113,'err_stat'}
      ,{114,'transferdate_unformatted'}
      ,{115,'birthdate_unformatted'}
      ,{116,'dob_no_conflict'}
      ,{117,'updatedate_unformatted'}
      ,{118,'consumerupdatedate_unformatted'}
      ,{119,'filesincedate_unformatted'}
      ,{120,'compilationdate_unformatted'}
      ,{121,'ssn_unformatted'}
      ,{122,'ssn_no_conflict'}
      ,{123,'telephone_unformatted'}
      ,{124,'deceasedindicator'}
      ,{125,'did'}
      ,{126,'did_score_field'}
      ,{127,'is_current'}],SALT34.MAC_Character_Counts.Field_Identification);
EXPORT AllProfiles := SALT34.MAC_Character_Counts.FN_Profile(FldInv0,FldIds);
 
EXPORT SrcProfiles := SALT34.MAC_Character_Counts.Src_Profile(FldInv0,FldIds);
 
EXPORT Correlations := SALT34.MAC_Correlate.Fn_Profile(Pairs0,FldIds);
 
ErrorRecord := RECORD
  UNSIGNED1 FieldNum;
  UNSIGNED1 ErrorNum;
END;
ErrorRecord NoteErrors(h le,UNSIGNED1 c) := TRANSFORM
  SELF.ErrorNum := CHOOSE(c,
    Fields.InValid_dt_first_seen((SALT34.StrType)le.dt_first_seen),
    Fields.InValid_dt_last_seen((SALT34.StrType)le.dt_last_seen),
    Fields.InValid_dt_vendor_first_reported((SALT34.StrType)le.dt_vendor_first_reported),
    Fields.InValid_dt_vendor_last_reported((SALT34.StrType)le.dt_vendor_last_reported),
    Fields.InValid_filetype((SALT34.StrType)le.filetype),
    Fields.InValid_filedate((SALT34.StrType)le.filedate),
    Fields.InValid_vendordocumentidentifier((SALT34.StrType)le.vendordocumentidentifier),
    Fields.InValid_transferdate((SALT34.StrType)le.transferdate),
    Fields.InValid_currentname_firstname((SALT34.StrType)le.currentname_firstname),
    Fields.InValid_currentname_middlename((SALT34.StrType)le.currentname_middlename),
    Fields.InValid_currentname_middleinitial((SALT34.StrType)le.currentname_middleinitial),
    Fields.InValid_currentname_lastname((SALT34.StrType)le.currentname_lastname),
    Fields.InValid_currentname_suffix((SALT34.StrType)le.currentname_suffix),
    Fields.InValid_currentname_gender((SALT34.StrType)le.currentname_gender),
    Fields.InValid_currentname_dob_mm((SALT34.StrType)le.currentname_dob_mm),
    Fields.InValid_currentname_dob_dd((SALT34.StrType)le.currentname_dob_dd),
    Fields.InValid_currentname_dob_yyyy((SALT34.StrType)le.currentname_dob_yyyy),
    Fields.InValid_currentname_deathindicator((SALT34.StrType)le.currentname_deathindicator),
    Fields.InValid_ssnfull((SALT34.StrType)le.ssnfull),
    Fields.InValid_ssnfirst5digit((SALT34.StrType)le.ssnfirst5digit),
    Fields.InValid_ssnlast4digit((SALT34.StrType)le.ssnlast4digit),
    Fields.InValid_consumerupdatedate((SALT34.StrType)le.consumerupdatedate),
    Fields.InValid_telephonenumber((SALT34.StrType)le.telephonenumber),
    Fields.InValid_citedid((SALT34.StrType)le.citedid),
    Fields.InValid_fileid((SALT34.StrType)le.fileid),
    Fields.InValid_publication((SALT34.StrType)le.publication),
    Fields.InValid_currentaddress_address1((SALT34.StrType)le.currentaddress_address1),
    Fields.InValid_currentaddress_address2((SALT34.StrType)le.currentaddress_address2),
    Fields.InValid_currentaddress_city((SALT34.StrType)le.currentaddress_city),
    Fields.InValid_currentaddress_state((SALT34.StrType)le.currentaddress_state),
    Fields.InValid_currentaddress_zipcode((SALT34.StrType)le.currentaddress_zipcode),
    Fields.InValid_currentaddress_updateddate((SALT34.StrType)le.currentaddress_updateddate),
    Fields.InValid_housenumber((SALT34.StrType)le.housenumber),
    Fields.InValid_streettype((SALT34.StrType)le.streettype),
    Fields.InValid_streetdirection((SALT34.StrType)le.streetdirection),
    Fields.InValid_streetname((SALT34.StrType)le.streetname),
    Fields.InValid_apartmentnumber((SALT34.StrType)le.apartmentnumber),
    Fields.InValid_city((SALT34.StrType)le.city),
    Fields.InValid_state((SALT34.StrType)le.state),
    Fields.InValid_zipcode((SALT34.StrType)le.zipcode),
    Fields.InValid_zip4u((SALT34.StrType)le.zip4u),
    Fields.InValid_previousaddress_address1((SALT34.StrType)le.previousaddress_address1),
    Fields.InValid_previousaddress_address2((SALT34.StrType)le.previousaddress_address2),
    Fields.InValid_previousaddress_city((SALT34.StrType)le.previousaddress_city),
    Fields.InValid_previousaddress_state((SALT34.StrType)le.previousaddress_state),
    Fields.InValid_previousaddress_zipcode((SALT34.StrType)le.previousaddress_zipcode),
    Fields.InValid_previousaddress_updateddate((SALT34.StrType)le.previousaddress_updateddate),
    Fields.InValid_formername_firstname((SALT34.StrType)le.formername_firstname),
    Fields.InValid_formername_middlename((SALT34.StrType)le.formername_middlename),
    Fields.InValid_formername_middleinitial((SALT34.StrType)le.formername_middleinitial),
    Fields.InValid_formername_lastname((SALT34.StrType)le.formername_lastname),
    Fields.InValid_formername_suffix((SALT34.StrType)le.formername_suffix),
    Fields.InValid_aliasname_firstname((SALT34.StrType)le.aliasname_firstname),
    Fields.InValid_aliasname_middlename((SALT34.StrType)le.aliasname_middlename),
    Fields.InValid_aliasname_middleinitial((SALT34.StrType)le.aliasname_middleinitial),
    Fields.InValid_aliasname_lastname((SALT34.StrType)le.aliasname_lastname),
    Fields.InValid_aliasname_suffix((SALT34.StrType)le.aliasname_suffix),
    Fields.InValid_additionalname_firstname((SALT34.StrType)le.additionalname_firstname),
    Fields.InValid_additionalname_middlename((SALT34.StrType)le.additionalname_middlename),
    Fields.InValid_additionalname_middleinitial((SALT34.StrType)le.additionalname_middleinitial),
    Fields.InValid_additionalname_lastname((SALT34.StrType)le.additionalname_lastname),
    Fields.InValid_additionalname_suffix((SALT34.StrType)le.additionalname_suffix),
    Fields.InValid_aka1((SALT34.StrType)le.aka1),
    Fields.InValid_aka2((SALT34.StrType)le.aka2),
    Fields.InValid_aka3((SALT34.StrType)le.aka3),
    Fields.InValid_recordtype((SALT34.StrType)le.recordtype),
    Fields.InValid_addressstandardization((SALT34.StrType)le.addressstandardization),
    Fields.InValid_filesincedate((SALT34.StrType)le.filesincedate),
    Fields.InValid_compilationdate((SALT34.StrType)le.compilationdate),
    Fields.InValid_birthdateind((SALT34.StrType)le.birthdateind),
    Fields.InValid_orig_deceasedindicator((SALT34.StrType)le.orig_deceasedindicator),
    Fields.InValid_deceaseddate((SALT34.StrType)le.deceaseddate),
    Fields.InValid_addressseq((SALT34.StrType)le.addressseq),
    Fields.InValid_normaddress_address1((SALT34.StrType)le.normaddress_address1),
    Fields.InValid_normaddress_address2((SALT34.StrType)le.normaddress_address2),
    Fields.InValid_normaddress_city((SALT34.StrType)le.normaddress_city),
    Fields.InValid_normaddress_state((SALT34.StrType)le.normaddress_state),
    Fields.InValid_normaddress_zipcode((SALT34.StrType)le.normaddress_zipcode),
    Fields.InValid_normaddress_updateddate((SALT34.StrType)le.normaddress_updateddate),
    Fields.InValid_name((SALT34.StrType)le.name),
    Fields.InValid_nametype((SALT34.StrType)le.nametype),
    Fields.InValid_title((SALT34.StrType)le.title),
    Fields.InValid_fname((SALT34.StrType)le.fname),
    Fields.InValid_mname((SALT34.StrType)le.mname),
    Fields.InValid_lname((SALT34.StrType)le.lname),
    Fields.InValid_name_suffix((SALT34.StrType)le.name_suffix),
    Fields.InValid_name_score((SALT34.StrType)le.name_score),
    Fields.InValid_prim_range((SALT34.StrType)le.prim_range),
    Fields.InValid_predir((SALT34.StrType)le.predir),
    Fields.InValid_prim_name((SALT34.StrType)le.prim_name),
    Fields.InValid_addr_suffix((SALT34.StrType)le.addr_suffix),
    Fields.InValid_postdir((SALT34.StrType)le.postdir),
    Fields.InValid_unit_desig((SALT34.StrType)le.unit_desig),
    Fields.InValid_sec_range((SALT34.StrType)le.sec_range),
    Fields.InValid_p_city_name((SALT34.StrType)le.p_city_name),
    Fields.InValid_v_city_name((SALT34.StrType)le.v_city_name),
    Fields.InValid_st((SALT34.StrType)le.st),
    Fields.InValid_zip((SALT34.StrType)le.zip),
    Fields.InValid_zip4((SALT34.StrType)le.zip4),
    Fields.InValid_cart((SALT34.StrType)le.cart),
    Fields.InValid_cr_sort_sz((SALT34.StrType)le.cr_sort_sz),
    Fields.InValid_lot((SALT34.StrType)le.lot),
    Fields.InValid_lot_order((SALT34.StrType)le.lot_order),
    Fields.InValid_dbpc((SALT34.StrType)le.dbpc),
    Fields.InValid_chk_digit((SALT34.StrType)le.chk_digit),
    Fields.InValid_rec_type((SALT34.StrType)le.rec_type),
    Fields.InValid_county((SALT34.StrType)le.county),
    Fields.InValid_geo_lat((SALT34.StrType)le.geo_lat),
    Fields.InValid_geo_long((SALT34.StrType)le.geo_long),
    Fields.InValid_msa((SALT34.StrType)le.msa),
    Fields.InValid_geo_blk((SALT34.StrType)le.geo_blk),
    Fields.InValid_geo_match((SALT34.StrType)le.geo_match),
    Fields.InValid_err_stat((SALT34.StrType)le.err_stat),
    Fields.InValid_transferdate_unformatted((SALT34.StrType)le.transferdate_unformatted),
    Fields.InValid_birthdate_unformatted((SALT34.StrType)le.birthdate_unformatted),
    Fields.InValid_dob_no_conflict((SALT34.StrType)le.dob_no_conflict),
    Fields.InValid_updatedate_unformatted((SALT34.StrType)le.updatedate_unformatted),
    Fields.InValid_consumerupdatedate_unformatted((SALT34.StrType)le.consumerupdatedate_unformatted),
    Fields.InValid_filesincedate_unformatted((SALT34.StrType)le.filesincedate_unformatted),
    Fields.InValid_compilationdate_unformatted((SALT34.StrType)le.compilationdate_unformatted),
    Fields.InValid_ssn_unformatted((SALT34.StrType)le.ssn_unformatted),
    Fields.InValid_ssn_no_conflict((SALT34.StrType)le.ssn_no_conflict),
    Fields.InValid_telephone_unformatted((SALT34.StrType)le.telephone_unformatted),
    Fields.InValid_deceasedindicator((SALT34.StrType)le.deceasedindicator),
    Fields.InValid_did((SALT34.StrType)le.did),
    Fields.InValid_did_score_field((SALT34.StrType)le.did_score_field),
    Fields.InValid_is_current((SALT34.StrType)le.is_current),
    0);
  SELF.FieldNum := IF(SELF.ErrorNum=0,SKIP,c); // Bail early to avoid creating record
END;
Errors := NORMALIZE(h,127,NoteErrors(LEFT,COUNTER));
ErrorRecordsTotals := RECORD
  Errors.FieldNum;
  Errors.ErrorNum;
  UNSIGNED Cnt := COUNT(GROUP);
END;
TotalErrors := TABLE(Errors,ErrorRecordsTotals,FieldNum,ErrorNum,FEW);
PrettyErrorTotals := RECORD
  FieldNme := Fields.FieldName(TotalErrors.FieldNum);
  FieldType := CHOOSE(TotalErrors.FieldNum,'dt_first_seen','dt_last_seen','dt_vendor_first_reported','dt_vendor_last_reported','filetype','filedate','vendordocumentidentifier','transferdate','currentname_firstname','currentname_middlename','currentname_middleinitial','currentname_lastname','currentname_suffix','currentname_gender','currentname_dob_mm','currentname_dob_dd','currentname_dob_yyyy','currentname_deathindicator','ssnfull','ssnfirst5digit','ssnlast4digit','consumerupdatedate','telephonenumber','citedid','fileid','publication','currentaddress_address1','currentaddress_address2','currentaddress_city','currentaddress_state','currentaddress_zipcode','currentaddress_updateddate','housenumber','streettype','streetdirection','streetname','apartmentnumber','city','state','zipcode','zip4u','previousaddress_address1','previousaddress_address2','previousaddress_city','previousaddress_state','previousaddress_zipcode','previousaddress_updateddate','formername_firstname','formername_middlename','formername_middleinitial','formername_lastname','formername_suffix','aliasname_firstname','aliasname_middlename','aliasname_middleinitial','aliasname_lastname','aliasname_suffix','additionalname_firstname','additionalname_middlename','additionalname_middleinitial','additionalname_lastname','additionalname_suffix','aka1','aka2','aka3','recordtype','addressstandardization','filesincedate','compilationdate','birthdateind','orig_deceasedindicator','deceaseddate','addressseq','normaddress_address1','normaddress_address2','normaddress_city','normaddress_state','normaddress_zipcode','normaddress_updateddate','name','nametype','title','fname','mname','lname','name_suffix','name_score','prim_range','predir','prim_name','addr_suffix','postdir','unit_desig','sec_range','p_city_name','v_city_name','st','zip','zip4','cart','cr_sort_sz','lot','lot_order','dbpc','chk_digit','rec_type','county','geo_lat','geo_long','msa','geo_blk','geo_match','err_stat','transferdate_unformatted','birthdate_unformatted','dob_no_conflict','updatedate_unformatted','consumerupdatedate_unformatted','filesincedate_unformatted','compilationdate_unformatted','ssn_unformatted','ssn_no_conflict','telephone_unformatted','deceasedindicator','did','did_score_field','is_current');
  ErrorMessage := CHOOSE(TotalErrors.FieldNum,Fields.InValidMessage_dt_first_seen(TotalErrors.ErrorNum),Fields.InValidMessage_dt_last_seen(TotalErrors.ErrorNum),Fields.InValidMessage_dt_vendor_first_reported(TotalErrors.ErrorNum),Fields.InValidMessage_dt_vendor_last_reported(TotalErrors.ErrorNum),Fields.InValidMessage_filetype(TotalErrors.ErrorNum),Fields.InValidMessage_filedate(TotalErrors.ErrorNum),Fields.InValidMessage_vendordocumentidentifier(TotalErrors.ErrorNum),Fields.InValidMessage_transferdate(TotalErrors.ErrorNum),Fields.InValidMessage_currentname_firstname(TotalErrors.ErrorNum),Fields.InValidMessage_currentname_middlename(TotalErrors.ErrorNum),Fields.InValidMessage_currentname_middleinitial(TotalErrors.ErrorNum),Fields.InValidMessage_currentname_lastname(TotalErrors.ErrorNum),Fields.InValidMessage_currentname_suffix(TotalErrors.ErrorNum),Fields.InValidMessage_currentname_gender(TotalErrors.ErrorNum),Fields.InValidMessage_currentname_dob_mm(TotalErrors.ErrorNum),Fields.InValidMessage_currentname_dob_dd(TotalErrors.ErrorNum),Fields.InValidMessage_currentname_dob_yyyy(TotalErrors.ErrorNum),Fields.InValidMessage_currentname_deathindicator(TotalErrors.ErrorNum),Fields.InValidMessage_ssnfull(TotalErrors.ErrorNum),Fields.InValidMessage_ssnfirst5digit(TotalErrors.ErrorNum),Fields.InValidMessage_ssnlast4digit(TotalErrors.ErrorNum),Fields.InValidMessage_consumerupdatedate(TotalErrors.ErrorNum),Fields.InValidMessage_telephonenumber(TotalErrors.ErrorNum),Fields.InValidMessage_citedid(TotalErrors.ErrorNum),Fields.InValidMessage_fileid(TotalErrors.ErrorNum),Fields.InValidMessage_publication(TotalErrors.ErrorNum),Fields.InValidMessage_currentaddress_address1(TotalErrors.ErrorNum),Fields.InValidMessage_currentaddress_address2(TotalErrors.ErrorNum),Fields.InValidMessage_currentaddress_city(TotalErrors.ErrorNum),Fields.InValidMessage_currentaddress_state(TotalErrors.ErrorNum),Fields.InValidMessage_currentaddress_zipcode(TotalErrors.ErrorNum),Fields.InValidMessage_currentaddress_updateddate(TotalErrors.ErrorNum),Fields.InValidMessage_housenumber(TotalErrors.ErrorNum),Fields.InValidMessage_streettype(TotalErrors.ErrorNum),Fields.InValidMessage_streetdirection(TotalErrors.ErrorNum),Fields.InValidMessage_streetname(TotalErrors.ErrorNum),Fields.InValidMessage_apartmentnumber(TotalErrors.ErrorNum),Fields.InValidMessage_city(TotalErrors.ErrorNum),Fields.InValidMessage_state(TotalErrors.ErrorNum),Fields.InValidMessage_zipcode(TotalErrors.ErrorNum),Fields.InValidMessage_zip4u(TotalErrors.ErrorNum),Fields.InValidMessage_previousaddress_address1(TotalErrors.ErrorNum),Fields.InValidMessage_previousaddress_address2(TotalErrors.ErrorNum),Fields.InValidMessage_previousaddress_city(TotalErrors.ErrorNum),Fields.InValidMessage_previousaddress_state(TotalErrors.ErrorNum),Fields.InValidMessage_previousaddress_zipcode(TotalErrors.ErrorNum),Fields.InValidMessage_previousaddress_updateddate(TotalErrors.ErrorNum),Fields.InValidMessage_formername_firstname(TotalErrors.ErrorNum),Fields.InValidMessage_formername_middlename(TotalErrors.ErrorNum),Fields.InValidMessage_formername_middleinitial(TotalErrors.ErrorNum),Fields.InValidMessage_formername_lastname(TotalErrors.ErrorNum),Fields.InValidMessage_formername_suffix(TotalErrors.ErrorNum),Fields.InValidMessage_aliasname_firstname(TotalErrors.ErrorNum),Fields.InValidMessage_aliasname_middlename(TotalErrors.ErrorNum),Fields.InValidMessage_aliasname_middleinitial(TotalErrors.ErrorNum),Fields.InValidMessage_aliasname_lastname(TotalErrors.ErrorNum),Fields.InValidMessage_aliasname_suffix(TotalErrors.ErrorNum),Fields.InValidMessage_additionalname_firstname(TotalErrors.ErrorNum),Fields.InValidMessage_additionalname_middlename(TotalErrors.ErrorNum),Fields.InValidMessage_additionalname_middleinitial(TotalErrors.ErrorNum),Fields.InValidMessage_additionalname_lastname(TotalErrors.ErrorNum),Fields.InValidMessage_additionalname_suffix(TotalErrors.ErrorNum),Fields.InValidMessage_aka1(TotalErrors.ErrorNum),Fields.InValidMessage_aka2(TotalErrors.ErrorNum),Fields.InValidMessage_aka3(TotalErrors.ErrorNum),Fields.InValidMessage_recordtype(TotalErrors.ErrorNum),Fields.InValidMessage_addressstandardization(TotalErrors.ErrorNum),Fields.InValidMessage_filesincedate(TotalErrors.ErrorNum),Fields.InValidMessage_compilationdate(TotalErrors.ErrorNum),Fields.InValidMessage_birthdateind(TotalErrors.ErrorNum),Fields.InValidMessage_orig_deceasedindicator(TotalErrors.ErrorNum),Fields.InValidMessage_deceaseddate(TotalErrors.ErrorNum),Fields.InValidMessage_addressseq(TotalErrors.ErrorNum),Fields.InValidMessage_normaddress_address1(TotalErrors.ErrorNum),Fields.InValidMessage_normaddress_address2(TotalErrors.ErrorNum),Fields.InValidMessage_normaddress_city(TotalErrors.ErrorNum),Fields.InValidMessage_normaddress_state(TotalErrors.ErrorNum),Fields.InValidMessage_normaddress_zipcode(TotalErrors.ErrorNum),Fields.InValidMessage_normaddress_updateddate(TotalErrors.ErrorNum),Fields.InValidMessage_name(TotalErrors.ErrorNum),Fields.InValidMessage_nametype(TotalErrors.ErrorNum),Fields.InValidMessage_title(TotalErrors.ErrorNum),Fields.InValidMessage_fname(TotalErrors.ErrorNum),Fields.InValidMessage_mname(TotalErrors.ErrorNum),Fields.InValidMessage_lname(TotalErrors.ErrorNum),Fields.InValidMessage_name_suffix(TotalErrors.ErrorNum),Fields.InValidMessage_name_score(TotalErrors.ErrorNum),Fields.InValidMessage_prim_range(TotalErrors.ErrorNum),Fields.InValidMessage_predir(TotalErrors.ErrorNum),Fields.InValidMessage_prim_name(TotalErrors.ErrorNum),Fields.InValidMessage_addr_suffix(TotalErrors.ErrorNum),Fields.InValidMessage_postdir(TotalErrors.ErrorNum),Fields.InValidMessage_unit_desig(TotalErrors.ErrorNum),Fields.InValidMessage_sec_range(TotalErrors.ErrorNum),Fields.InValidMessage_p_city_name(TotalErrors.ErrorNum),Fields.InValidMessage_v_city_name(TotalErrors.ErrorNum),Fields.InValidMessage_st(TotalErrors.ErrorNum),Fields.InValidMessage_zip(TotalErrors.ErrorNum),Fields.InValidMessage_zip4(TotalErrors.ErrorNum),Fields.InValidMessage_cart(TotalErrors.ErrorNum),Fields.InValidMessage_cr_sort_sz(TotalErrors.ErrorNum),Fields.InValidMessage_lot(TotalErrors.ErrorNum),Fields.InValidMessage_lot_order(TotalErrors.ErrorNum),Fields.InValidMessage_dbpc(TotalErrors.ErrorNum),Fields.InValidMessage_chk_digit(TotalErrors.ErrorNum),Fields.InValidMessage_rec_type(TotalErrors.ErrorNum),Fields.InValidMessage_county(TotalErrors.ErrorNum),Fields.InValidMessage_geo_lat(TotalErrors.ErrorNum),Fields.InValidMessage_geo_long(TotalErrors.ErrorNum),Fields.InValidMessage_msa(TotalErrors.ErrorNum),Fields.InValidMessage_geo_blk(TotalErrors.ErrorNum),Fields.InValidMessage_geo_match(TotalErrors.ErrorNum),Fields.InValidMessage_err_stat(TotalErrors.ErrorNum),Fields.InValidMessage_transferdate_unformatted(TotalErrors.ErrorNum),Fields.InValidMessage_birthdate_unformatted(TotalErrors.ErrorNum),Fields.InValidMessage_dob_no_conflict(TotalErrors.ErrorNum),Fields.InValidMessage_updatedate_unformatted(TotalErrors.ErrorNum),Fields.InValidMessage_consumerupdatedate_unformatted(TotalErrors.ErrorNum),Fields.InValidMessage_filesincedate_unformatted(TotalErrors.ErrorNum),Fields.InValidMessage_compilationdate_unformatted(TotalErrors.ErrorNum),Fields.InValidMessage_ssn_unformatted(TotalErrors.ErrorNum),Fields.InValidMessage_ssn_no_conflict(TotalErrors.ErrorNum),Fields.InValidMessage_telephone_unformatted(TotalErrors.ErrorNum),Fields.InValidMessage_deceasedindicator(TotalErrors.ErrorNum),Fields.InValidMessage_did(TotalErrors.ErrorNum),Fields.InValidMessage_did_score_field(TotalErrors.ErrorNum),Fields.InValidMessage_is_current(TotalErrors.ErrorNum));
  TotalErrors.Cnt;
END;
ValErr := TABLE(TotalErrors,PrettyErrorTotals);
EXPORT ValidityErrors := ValErr;
END;
