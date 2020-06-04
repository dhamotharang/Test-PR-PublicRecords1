IMPORT SALT311,STD;
EXPORT hygiene(dataset(layout_In_CT) h) := MODULE
 
//A simple summary record
EXPORT Summary(SALT311.Str30Type  txt) := FUNCTION
  SummaryLayout := RECORD
    txt;
    NumberOfRecords := COUNT(GROUP);
    populated_append_process_date_cnt := COUNT(GROUP,h.append_process_date <> (TYPEOF(h.append_process_date))'');
    populated_append_process_date_pcnt := AVE(GROUP,IF(h.append_process_date = (TYPEOF(h.append_process_date))'',0,100));
    maxlength_append_process_date := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.append_process_date)));
    avelength_append_process_date := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.append_process_date)),h.append_process_date<>(typeof(h.append_process_date))'');
    populated_credentialstate_cnt := COUNT(GROUP,h.credentialstate <> (TYPEOF(h.credentialstate))'');
    populated_credentialstate_pcnt := AVE(GROUP,IF(h.credentialstate = (TYPEOF(h.credentialstate))'',0,100));
    maxlength_credentialstate := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.credentialstate)));
    avelength_credentialstate := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.credentialstate)),h.credentialstate<>(typeof(h.credentialstate))'');
    populated_credentialnumber_cnt := COUNT(GROUP,h.credentialnumber <> (TYPEOF(h.credentialnumber))'');
    populated_credentialnumber_pcnt := AVE(GROUP,IF(h.credentialnumber = (TYPEOF(h.credentialnumber))'',0,100));
    maxlength_credentialnumber := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.credentialnumber)));
    avelength_credentialnumber := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.credentialnumber)),h.credentialnumber<>(typeof(h.credentialnumber))'');
    populated_lastname_cnt := COUNT(GROUP,h.lastname <> (TYPEOF(h.lastname))'');
    populated_lastname_pcnt := AVE(GROUP,IF(h.lastname = (TYPEOF(h.lastname))'',0,100));
    maxlength_lastname := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.lastname)));
    avelength_lastname := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.lastname)),h.lastname<>(typeof(h.lastname))'');
    populated_firstname_cnt := COUNT(GROUP,h.firstname <> (TYPEOF(h.firstname))'');
    populated_firstname_pcnt := AVE(GROUP,IF(h.firstname = (TYPEOF(h.firstname))'',0,100));
    maxlength_firstname := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.firstname)));
    avelength_firstname := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.firstname)),h.firstname<>(typeof(h.firstname))'');
    populated_middleinitial_cnt := COUNT(GROUP,h.middleinitial <> (TYPEOF(h.middleinitial))'');
    populated_middleinitial_pcnt := AVE(GROUP,IF(h.middleinitial = (TYPEOF(h.middleinitial))'',0,100));
    maxlength_middleinitial := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.middleinitial)));
    avelength_middleinitial := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.middleinitial)),h.middleinitial<>(typeof(h.middleinitial))'');
    populated_gender_cnt := COUNT(GROUP,h.gender <> (TYPEOF(h.gender))'');
    populated_gender_pcnt := AVE(GROUP,IF(h.gender = (TYPEOF(h.gender))'',0,100));
    maxlength_gender := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.gender)));
    avelength_gender := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.gender)),h.gender<>(typeof(h.gender))'');
    populated_height_cnt := COUNT(GROUP,h.height <> (TYPEOF(h.height))'');
    populated_height_pcnt := AVE(GROUP,IF(h.height = (TYPEOF(h.height))'',0,100));
    maxlength_height := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.height)));
    avelength_height := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.height)),h.height<>(typeof(h.height))'');
    populated_eyecolor_cnt := COUNT(GROUP,h.eyecolor <> (TYPEOF(h.eyecolor))'');
    populated_eyecolor_pcnt := AVE(GROUP,IF(h.eyecolor = (TYPEOF(h.eyecolor))'',0,100));
    maxlength_eyecolor := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.eyecolor)));
    avelength_eyecolor := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.eyecolor)),h.eyecolor<>(typeof(h.eyecolor))'');
    populated_date_birth_cnt := COUNT(GROUP,h.date_birth <> (TYPEOF(h.date_birth))'');
    populated_date_birth_pcnt := AVE(GROUP,IF(h.date_birth = (TYPEOF(h.date_birth))'',0,100));
    maxlength_date_birth := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.date_birth)));
    avelength_date_birth := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.date_birth)),h.date_birth<>(typeof(h.date_birth))'');
    populated_resiaddrstreet_cnt := COUNT(GROUP,h.resiaddrstreet <> (TYPEOF(h.resiaddrstreet))'');
    populated_resiaddrstreet_pcnt := AVE(GROUP,IF(h.resiaddrstreet = (TYPEOF(h.resiaddrstreet))'',0,100));
    maxlength_resiaddrstreet := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.resiaddrstreet)));
    avelength_resiaddrstreet := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.resiaddrstreet)),h.resiaddrstreet<>(typeof(h.resiaddrstreet))'');
    populated_residencycity_cnt := COUNT(GROUP,h.residencycity <> (TYPEOF(h.residencycity))'');
    populated_residencycity_pcnt := AVE(GROUP,IF(h.residencycity = (TYPEOF(h.residencycity))'',0,100));
    maxlength_residencycity := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.residencycity)));
    avelength_residencycity := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.residencycity)),h.residencycity<>(typeof(h.residencycity))'');
    populated_residencystate_cnt := COUNT(GROUP,h.residencystate <> (TYPEOF(h.residencystate))'');
    populated_residencystate_pcnt := AVE(GROUP,IF(h.residencystate = (TYPEOF(h.residencystate))'',0,100));
    maxlength_residencystate := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.residencystate)));
    avelength_residencystate := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.residencystate)),h.residencystate<>(typeof(h.residencystate))'');
    populated_residencyzip_cnt := COUNT(GROUP,h.residencyzip <> (TYPEOF(h.residencyzip))'');
    populated_residencyzip_pcnt := AVE(GROUP,IF(h.residencyzip = (TYPEOF(h.residencyzip))'',0,100));
    maxlength_residencyzip := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.residencyzip)));
    avelength_residencyzip := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.residencyzip)),h.residencyzip<>(typeof(h.residencyzip))'');
    populated_mailaddrstreet_cnt := COUNT(GROUP,h.mailaddrstreet <> (TYPEOF(h.mailaddrstreet))'');
    populated_mailaddrstreet_pcnt := AVE(GROUP,IF(h.mailaddrstreet = (TYPEOF(h.mailaddrstreet))'',0,100));
    maxlength_mailaddrstreet := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.mailaddrstreet)));
    avelength_mailaddrstreet := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.mailaddrstreet)),h.mailaddrstreet<>(typeof(h.mailaddrstreet))'');
    populated_mailingcity_cnt := COUNT(GROUP,h.mailingcity <> (TYPEOF(h.mailingcity))'');
    populated_mailingcity_pcnt := AVE(GROUP,IF(h.mailingcity = (TYPEOF(h.mailingcity))'',0,100));
    maxlength_mailingcity := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.mailingcity)));
    avelength_mailingcity := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.mailingcity)),h.mailingcity<>(typeof(h.mailingcity))'');
    populated_mailingstate_cnt := COUNT(GROUP,h.mailingstate <> (TYPEOF(h.mailingstate))'');
    populated_mailingstate_pcnt := AVE(GROUP,IF(h.mailingstate = (TYPEOF(h.mailingstate))'',0,100));
    maxlength_mailingstate := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.mailingstate)));
    avelength_mailingstate := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.mailingstate)),h.mailingstate<>(typeof(h.mailingstate))'');
    populated_mailingzip_cnt := COUNT(GROUP,h.mailingzip <> (TYPEOF(h.mailingzip))'');
    populated_mailingzip_pcnt := AVE(GROUP,IF(h.mailingzip = (TYPEOF(h.mailingzip))'',0,100));
    maxlength_mailingzip := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.mailingzip)));
    avelength_mailingzip := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.mailingzip)),h.mailingzip<>(typeof(h.mailingzip))'');
    populated_credentialtype_cnt := COUNT(GROUP,h.credentialtype <> (TYPEOF(h.credentialtype))'');
    populated_credentialtype_pcnt := AVE(GROUP,IF(h.credentialtype = (TYPEOF(h.credentialtype))'',0,100));
    maxlength_credentialtype := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.credentialtype)));
    avelength_credentialtype := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.credentialtype)),h.credentialtype<>(typeof(h.credentialtype))'');
    populated_credential_class_cnt := COUNT(GROUP,h.credential_class <> (TYPEOF(h.credential_class))'');
    populated_credential_class_pcnt := AVE(GROUP,IF(h.credential_class = (TYPEOF(h.credential_class))'',0,100));
    maxlength_credential_class := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.credential_class)));
    avelength_credential_class := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.credential_class)),h.credential_class<>(typeof(h.credential_class))'');
    populated_endorsements_cnt := COUNT(GROUP,h.endorsements <> (TYPEOF(h.endorsements))'');
    populated_endorsements_pcnt := AVE(GROUP,IF(h.endorsements = (TYPEOF(h.endorsements))'',0,100));
    maxlength_endorsements := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.endorsements)));
    avelength_endorsements := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.endorsements)),h.endorsements<>(typeof(h.endorsements))'');
    populated_restrictions_cnt := COUNT(GROUP,h.restrictions <> (TYPEOF(h.restrictions))'');
    populated_restrictions_pcnt := AVE(GROUP,IF(h.restrictions = (TYPEOF(h.restrictions))'',0,100));
    maxlength_restrictions := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.restrictions)));
    avelength_restrictions := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.restrictions)),h.restrictions<>(typeof(h.restrictions))'');
    populated_expdate_cnt := COUNT(GROUP,h.expdate <> (TYPEOF(h.expdate))'');
    populated_expdate_pcnt := AVE(GROUP,IF(h.expdate = (TYPEOF(h.expdate))'',0,100));
    maxlength_expdate := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.expdate)));
    avelength_expdate := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.expdate)),h.expdate<>(typeof(h.expdate))'');
    populated_lastissuerenewaldate_cnt := COUNT(GROUP,h.lastissuerenewaldate <> (TYPEOF(h.lastissuerenewaldate))'');
    populated_lastissuerenewaldate_pcnt := AVE(GROUP,IF(h.lastissuerenewaldate = (TYPEOF(h.lastissuerenewaldate))'',0,100));
    maxlength_lastissuerenewaldate := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.lastissuerenewaldate)));
    avelength_lastissuerenewaldate := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.lastissuerenewaldate)),h.lastissuerenewaldate<>(typeof(h.lastissuerenewaldate))'');
    populated_date_noncdl_cnt := COUNT(GROUP,h.date_noncdl <> (TYPEOF(h.date_noncdl))'');
    populated_date_noncdl_pcnt := AVE(GROUP,IF(h.date_noncdl = (TYPEOF(h.date_noncdl))'',0,100));
    maxlength_date_noncdl := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.date_noncdl)));
    avelength_date_noncdl := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.date_noncdl)),h.date_noncdl<>(typeof(h.date_noncdl))'');
    populated_originaldate_cdl_cnt := COUNT(GROUP,h.originaldate_cdl <> (TYPEOF(h.originaldate_cdl))'');
    populated_originaldate_cdl_pcnt := AVE(GROUP,IF(h.originaldate_cdl = (TYPEOF(h.originaldate_cdl))'',0,100));
    maxlength_originaldate_cdl := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.originaldate_cdl)));
    avelength_originaldate_cdl := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.originaldate_cdl)),h.originaldate_cdl<>(typeof(h.originaldate_cdl))'');
    populated_statusnoncdl_cnt := COUNT(GROUP,h.statusnoncdl <> (TYPEOF(h.statusnoncdl))'');
    populated_statusnoncdl_pcnt := AVE(GROUP,IF(h.statusnoncdl = (TYPEOF(h.statusnoncdl))'',0,100));
    maxlength_statusnoncdl := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.statusnoncdl)));
    avelength_statusnoncdl := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.statusnoncdl)),h.statusnoncdl<>(typeof(h.statusnoncdl))'');
    populated_licensestatuscdl_cnt := COUNT(GROUP,h.licensestatuscdl <> (TYPEOF(h.licensestatuscdl))'');
    populated_licensestatuscdl_pcnt := AVE(GROUP,IF(h.licensestatuscdl = (TYPEOF(h.licensestatuscdl))'',0,100));
    maxlength_licensestatuscdl := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.licensestatuscdl)));
    avelength_licensestatuscdl := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.licensestatuscdl)),h.licensestatuscdl<>(typeof(h.licensestatuscdl))'');
    populated_originaldate_lp_cnt := COUNT(GROUP,h.originaldate_lp <> (TYPEOF(h.originaldate_lp))'');
    populated_originaldate_lp_pcnt := AVE(GROUP,IF(h.originaldate_lp = (TYPEOF(h.originaldate_lp))'',0,100));
    maxlength_originaldate_lp := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.originaldate_lp)));
    avelength_originaldate_lp := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.originaldate_lp)),h.originaldate_lp<>(typeof(h.originaldate_lp))'');
    populated_originaldate_id_cnt := COUNT(GROUP,h.originaldate_id <> (TYPEOF(h.originaldate_id))'');
    populated_originaldate_id_pcnt := AVE(GROUP,IF(h.originaldate_id = (TYPEOF(h.originaldate_id))'',0,100));
    maxlength_originaldate_id := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.originaldate_id)));
    avelength_originaldate_id := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.originaldate_id)),h.originaldate_id<>(typeof(h.originaldate_id))'');
    populated_cancelstate_cnt := COUNT(GROUP,h.cancelstate <> (TYPEOF(h.cancelstate))'');
    populated_cancelstate_pcnt := AVE(GROUP,IF(h.cancelstate = (TYPEOF(h.cancelstate))'',0,100));
    maxlength_cancelstate := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.cancelstate)));
    avelength_cancelstate := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.cancelstate)),h.cancelstate<>(typeof(h.cancelstate))'');
    populated_canceldate_cnt := COUNT(GROUP,h.canceldate <> (TYPEOF(h.canceldate))'');
    populated_canceldate_pcnt := AVE(GROUP,IF(h.canceldate = (TYPEOF(h.canceldate))'',0,100));
    maxlength_canceldate := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.canceldate)));
    avelength_canceldate := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.canceldate)),h.canceldate<>(typeof(h.canceldate))'');
    populated_cdlmedicertissuedate_cnt := COUNT(GROUP,h.cdlmedicertissuedate <> (TYPEOF(h.cdlmedicertissuedate))'');
    populated_cdlmedicertissuedate_pcnt := AVE(GROUP,IF(h.cdlmedicertissuedate = (TYPEOF(h.cdlmedicertissuedate))'',0,100));
    maxlength_cdlmedicertissuedate := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.cdlmedicertissuedate)));
    avelength_cdlmedicertissuedate := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.cdlmedicertissuedate)),h.cdlmedicertissuedate<>(typeof(h.cdlmedicertissuedate))'');
    populated_cdlmedicertexpdate_cnt := COUNT(GROUP,h.cdlmedicertexpdate <> (TYPEOF(h.cdlmedicertexpdate))'');
    populated_cdlmedicertexpdate_pcnt := AVE(GROUP,IF(h.cdlmedicertexpdate = (TYPEOF(h.cdlmedicertexpdate))'',0,100));
    maxlength_cdlmedicertexpdate := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.cdlmedicertexpdate)));
    avelength_cdlmedicertexpdate := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.cdlmedicertexpdate)),h.cdlmedicertexpdate<>(typeof(h.cdlmedicertexpdate))'');
    populated_clean_name_prefix_cnt := COUNT(GROUP,h.clean_name_prefix <> (TYPEOF(h.clean_name_prefix))'');
    populated_clean_name_prefix_pcnt := AVE(GROUP,IF(h.clean_name_prefix = (TYPEOF(h.clean_name_prefix))'',0,100));
    maxlength_clean_name_prefix := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.clean_name_prefix)));
    avelength_clean_name_prefix := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.clean_name_prefix)),h.clean_name_prefix<>(typeof(h.clean_name_prefix))'');
    populated_clean_name_first_cnt := COUNT(GROUP,h.clean_name_first <> (TYPEOF(h.clean_name_first))'');
    populated_clean_name_first_pcnt := AVE(GROUP,IF(h.clean_name_first = (TYPEOF(h.clean_name_first))'',0,100));
    maxlength_clean_name_first := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.clean_name_first)));
    avelength_clean_name_first := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.clean_name_first)),h.clean_name_first<>(typeof(h.clean_name_first))'');
    populated_clean_name_middle_cnt := COUNT(GROUP,h.clean_name_middle <> (TYPEOF(h.clean_name_middle))'');
    populated_clean_name_middle_pcnt := AVE(GROUP,IF(h.clean_name_middle = (TYPEOF(h.clean_name_middle))'',0,100));
    maxlength_clean_name_middle := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.clean_name_middle)));
    avelength_clean_name_middle := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.clean_name_middle)),h.clean_name_middle<>(typeof(h.clean_name_middle))'');
    populated_clean_name_last_cnt := COUNT(GROUP,h.clean_name_last <> (TYPEOF(h.clean_name_last))'');
    populated_clean_name_last_pcnt := AVE(GROUP,IF(h.clean_name_last = (TYPEOF(h.clean_name_last))'',0,100));
    maxlength_clean_name_last := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.clean_name_last)));
    avelength_clean_name_last := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.clean_name_last)),h.clean_name_last<>(typeof(h.clean_name_last))'');
    populated_clean_name_suffix_cnt := COUNT(GROUP,h.clean_name_suffix <> (TYPEOF(h.clean_name_suffix))'');
    populated_clean_name_suffix_pcnt := AVE(GROUP,IF(h.clean_name_suffix = (TYPEOF(h.clean_name_suffix))'',0,100));
    maxlength_clean_name_suffix := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.clean_name_suffix)));
    avelength_clean_name_suffix := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.clean_name_suffix)),h.clean_name_suffix<>(typeof(h.clean_name_suffix))'');
    populated_clean_name_score_cnt := COUNT(GROUP,h.clean_name_score <> (TYPEOF(h.clean_name_score))'');
    populated_clean_name_score_pcnt := AVE(GROUP,IF(h.clean_name_score = (TYPEOF(h.clean_name_score))'',0,100));
    maxlength_clean_name_score := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.clean_name_score)));
    avelength_clean_name_score := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.clean_name_score)),h.clean_name_score<>(typeof(h.clean_name_score))'');
  END;
    T := TABLE(h,SummaryLayout);
  R1 := RECORD
    UNSIGNED LinkingPotential :=  + T.Populated_append_process_date_pcnt *   0.00 / 100 + T.Populated_credentialstate_pcnt *   0.00 / 100 + T.Populated_credentialnumber_pcnt *   0.00 / 100 + T.Populated_lastname_pcnt *   0.00 / 100 + T.Populated_firstname_pcnt *   0.00 / 100 + T.Populated_middleinitial_pcnt *   0.00 / 100 + T.Populated_gender_pcnt *   0.00 / 100 + T.Populated_height_pcnt *   0.00 / 100 + T.Populated_eyecolor_pcnt *   0.00 / 100 + T.Populated_date_birth_pcnt *   0.00 / 100 + T.Populated_resiaddrstreet_pcnt *   0.00 / 100 + T.Populated_residencycity_pcnt *   0.00 / 100 + T.Populated_residencystate_pcnt *   0.00 / 100 + T.Populated_residencyzip_pcnt *   0.00 / 100 + T.Populated_mailaddrstreet_pcnt *   0.00 / 100 + T.Populated_mailingcity_pcnt *   0.00 / 100 + T.Populated_mailingstate_pcnt *   0.00 / 100 + T.Populated_mailingzip_pcnt *   0.00 / 100 + T.Populated_credentialtype_pcnt *   0.00 / 100 + T.Populated_credential_class_pcnt *   0.00 / 100 + T.Populated_endorsements_pcnt *   0.00 / 100 + T.Populated_restrictions_pcnt *   0.00 / 100 + T.Populated_expdate_pcnt *   0.00 / 100 + T.Populated_lastissuerenewaldate_pcnt *   0.00 / 100 + T.Populated_date_noncdl_pcnt *   0.00 / 100 + T.Populated_originaldate_cdl_pcnt *   0.00 / 100 + T.Populated_statusnoncdl_pcnt *   0.00 / 100 + T.Populated_licensestatuscdl_pcnt *   0.00 / 100 + T.Populated_originaldate_lp_pcnt *   0.00 / 100 + T.Populated_originaldate_id_pcnt *   0.00 / 100 + T.Populated_cancelstate_pcnt *   0.00 / 100 + T.Populated_canceldate_pcnt *   0.00 / 100 + T.Populated_cdlmedicertissuedate_pcnt *   0.00 / 100 + T.Populated_cdlmedicertexpdate_pcnt *   0.00 / 100 + T.Populated_clean_name_prefix_pcnt *   0.00 / 100 + T.Populated_clean_name_first_pcnt *   0.00 / 100 + T.Populated_clean_name_middle_pcnt *   0.00 / 100 + T.Populated_clean_name_last_pcnt *   0.00 / 100 + T.Populated_clean_name_suffix_pcnt *   0.00 / 100 + T.Populated_clean_name_score_pcnt *   0.00 / 100;
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
  SELF.FieldName := CHOOSE(C,'append_process_date','credentialstate','credentialnumber','lastname','firstname','middleinitial','gender','height','eyecolor','date_birth','resiaddrstreet','residencycity','residencystate','residencyzip','mailaddrstreet','mailingcity','mailingstate','mailingzip','credentialtype','credential_class','endorsements','restrictions','expdate','lastissuerenewaldate','date_noncdl','originaldate_cdl','statusnoncdl','licensestatuscdl','originaldate_lp','originaldate_id','cancelstate','canceldate','cdlmedicertissuedate','cdlmedicertexpdate','clean_name_prefix','clean_name_first','clean_name_middle','clean_name_last','clean_name_suffix','clean_name_score');
  SELF.populated_pcnt := CHOOSE(C,le.populated_append_process_date_pcnt,le.populated_credentialstate_pcnt,le.populated_credentialnumber_pcnt,le.populated_lastname_pcnt,le.populated_firstname_pcnt,le.populated_middleinitial_pcnt,le.populated_gender_pcnt,le.populated_height_pcnt,le.populated_eyecolor_pcnt,le.populated_date_birth_pcnt,le.populated_resiaddrstreet_pcnt,le.populated_residencycity_pcnt,le.populated_residencystate_pcnt,le.populated_residencyzip_pcnt,le.populated_mailaddrstreet_pcnt,le.populated_mailingcity_pcnt,le.populated_mailingstate_pcnt,le.populated_mailingzip_pcnt,le.populated_credentialtype_pcnt,le.populated_credential_class_pcnt,le.populated_endorsements_pcnt,le.populated_restrictions_pcnt,le.populated_expdate_pcnt,le.populated_lastissuerenewaldate_pcnt,le.populated_date_noncdl_pcnt,le.populated_originaldate_cdl_pcnt,le.populated_statusnoncdl_pcnt,le.populated_licensestatuscdl_pcnt,le.populated_originaldate_lp_pcnt,le.populated_originaldate_id_pcnt,le.populated_cancelstate_pcnt,le.populated_canceldate_pcnt,le.populated_cdlmedicertissuedate_pcnt,le.populated_cdlmedicertexpdate_pcnt,le.populated_clean_name_prefix_pcnt,le.populated_clean_name_first_pcnt,le.populated_clean_name_middle_pcnt,le.populated_clean_name_last_pcnt,le.populated_clean_name_suffix_pcnt,le.populated_clean_name_score_pcnt);
  SELF.maxlength := CHOOSE(C,le.maxlength_append_process_date,le.maxlength_credentialstate,le.maxlength_credentialnumber,le.maxlength_lastname,le.maxlength_firstname,le.maxlength_middleinitial,le.maxlength_gender,le.maxlength_height,le.maxlength_eyecolor,le.maxlength_date_birth,le.maxlength_resiaddrstreet,le.maxlength_residencycity,le.maxlength_residencystate,le.maxlength_residencyzip,le.maxlength_mailaddrstreet,le.maxlength_mailingcity,le.maxlength_mailingstate,le.maxlength_mailingzip,le.maxlength_credentialtype,le.maxlength_credential_class,le.maxlength_endorsements,le.maxlength_restrictions,le.maxlength_expdate,le.maxlength_lastissuerenewaldate,le.maxlength_date_noncdl,le.maxlength_originaldate_cdl,le.maxlength_statusnoncdl,le.maxlength_licensestatuscdl,le.maxlength_originaldate_lp,le.maxlength_originaldate_id,le.maxlength_cancelstate,le.maxlength_canceldate,le.maxlength_cdlmedicertissuedate,le.maxlength_cdlmedicertexpdate,le.maxlength_clean_name_prefix,le.maxlength_clean_name_first,le.maxlength_clean_name_middle,le.maxlength_clean_name_last,le.maxlength_clean_name_suffix,le.maxlength_clean_name_score);
  SELF.avelength := CHOOSE(C,le.avelength_append_process_date,le.avelength_credentialstate,le.avelength_credentialnumber,le.avelength_lastname,le.avelength_firstname,le.avelength_middleinitial,le.avelength_gender,le.avelength_height,le.avelength_eyecolor,le.avelength_date_birth,le.avelength_resiaddrstreet,le.avelength_residencycity,le.avelength_residencystate,le.avelength_residencyzip,le.avelength_mailaddrstreet,le.avelength_mailingcity,le.avelength_mailingstate,le.avelength_mailingzip,le.avelength_credentialtype,le.avelength_credential_class,le.avelength_endorsements,le.avelength_restrictions,le.avelength_expdate,le.avelength_lastissuerenewaldate,le.avelength_date_noncdl,le.avelength_originaldate_cdl,le.avelength_statusnoncdl,le.avelength_licensestatuscdl,le.avelength_originaldate_lp,le.avelength_originaldate_id,le.avelength_cancelstate,le.avelength_canceldate,le.avelength_cdlmedicertissuedate,le.avelength_cdlmedicertexpdate,le.avelength_clean_name_prefix,le.avelength_clean_name_first,le.avelength_clean_name_middle,le.avelength_clean_name_last,le.avelength_clean_name_suffix,le.avelength_clean_name_score);
END;
EXPORT invSummary := NORMALIZE(summary0, 40, invert(LEFT,COUNTER));
// The character counts
// Move everything into 'inverted list' form so processing can be done 'in library'
SALT311.MAC_Character_Counts.X_Data_Layout Into(h le,unsigned C) := TRANSFORM
  SELF.Fld := TRIM(CHOOSE(C,TRIM((SALT311.StrType)le.append_process_date),TRIM((SALT311.StrType)le.credentialstate),TRIM((SALT311.StrType)le.credentialnumber),TRIM((SALT311.StrType)le.lastname),TRIM((SALT311.StrType)le.firstname),TRIM((SALT311.StrType)le.middleinitial),TRIM((SALT311.StrType)le.gender),TRIM((SALT311.StrType)le.height),TRIM((SALT311.StrType)le.eyecolor),TRIM((SALT311.StrType)le.date_birth),TRIM((SALT311.StrType)le.resiaddrstreet),TRIM((SALT311.StrType)le.residencycity),TRIM((SALT311.StrType)le.residencystate),TRIM((SALT311.StrType)le.residencyzip),TRIM((SALT311.StrType)le.mailaddrstreet),TRIM((SALT311.StrType)le.mailingcity),TRIM((SALT311.StrType)le.mailingstate),TRIM((SALT311.StrType)le.mailingzip),TRIM((SALT311.StrType)le.credentialtype),TRIM((SALT311.StrType)le.credential_class),TRIM((SALT311.StrType)le.endorsements),TRIM((SALT311.StrType)le.restrictions),TRIM((SALT311.StrType)le.expdate),TRIM((SALT311.StrType)le.lastissuerenewaldate),TRIM((SALT311.StrType)le.date_noncdl),TRIM((SALT311.StrType)le.originaldate_cdl),TRIM((SALT311.StrType)le.statusnoncdl),TRIM((SALT311.StrType)le.licensestatuscdl),TRIM((SALT311.StrType)le.originaldate_lp),TRIM((SALT311.StrType)le.originaldate_id),TRIM((SALT311.StrType)le.cancelstate),TRIM((SALT311.StrType)le.canceldate),TRIM((SALT311.StrType)le.cdlmedicertissuedate),TRIM((SALT311.StrType)le.cdlmedicertexpdate),TRIM((SALT311.StrType)le.clean_name_prefix),TRIM((SALT311.StrType)le.clean_name_first),TRIM((SALT311.StrType)le.clean_name_middle),TRIM((SALT311.StrType)le.clean_name_last),TRIM((SALT311.StrType)le.clean_name_suffix),TRIM((SALT311.StrType)le.clean_name_score)));
  SELF.FldNo := C;
END;
SHARED FldInv0 := NORMALIZE(h,40,Into(LEFT,COUNTER));
// Move everything into 'pairs' form so processing can be done 'in library'
SALT311.MAC_Correlate.Data_Layout IntoP(h le,UNSIGNED C) := TRANSFORM
  SELF.FldNo1 := 1 + (C / 40);
  SELF.FldNo2 := 1 + (C % 40);
  SELF.Fld1 := TRIM(CHOOSE(SELF.FldNo1,TRIM((SALT311.StrType)le.append_process_date),TRIM((SALT311.StrType)le.credentialstate),TRIM((SALT311.StrType)le.credentialnumber),TRIM((SALT311.StrType)le.lastname),TRIM((SALT311.StrType)le.firstname),TRIM((SALT311.StrType)le.middleinitial),TRIM((SALT311.StrType)le.gender),TRIM((SALT311.StrType)le.height),TRIM((SALT311.StrType)le.eyecolor),TRIM((SALT311.StrType)le.date_birth),TRIM((SALT311.StrType)le.resiaddrstreet),TRIM((SALT311.StrType)le.residencycity),TRIM((SALT311.StrType)le.residencystate),TRIM((SALT311.StrType)le.residencyzip),TRIM((SALT311.StrType)le.mailaddrstreet),TRIM((SALT311.StrType)le.mailingcity),TRIM((SALT311.StrType)le.mailingstate),TRIM((SALT311.StrType)le.mailingzip),TRIM((SALT311.StrType)le.credentialtype),TRIM((SALT311.StrType)le.credential_class),TRIM((SALT311.StrType)le.endorsements),TRIM((SALT311.StrType)le.restrictions),TRIM((SALT311.StrType)le.expdate),TRIM((SALT311.StrType)le.lastissuerenewaldate),TRIM((SALT311.StrType)le.date_noncdl),TRIM((SALT311.StrType)le.originaldate_cdl),TRIM((SALT311.StrType)le.statusnoncdl),TRIM((SALT311.StrType)le.licensestatuscdl),TRIM((SALT311.StrType)le.originaldate_lp),TRIM((SALT311.StrType)le.originaldate_id),TRIM((SALT311.StrType)le.cancelstate),TRIM((SALT311.StrType)le.canceldate),TRIM((SALT311.StrType)le.cdlmedicertissuedate),TRIM((SALT311.StrType)le.cdlmedicertexpdate),TRIM((SALT311.StrType)le.clean_name_prefix),TRIM((SALT311.StrType)le.clean_name_first),TRIM((SALT311.StrType)le.clean_name_middle),TRIM((SALT311.StrType)le.clean_name_last),TRIM((SALT311.StrType)le.clean_name_suffix),TRIM((SALT311.StrType)le.clean_name_score)));
  SELF.Fld2 := TRIM(CHOOSE(SELF.FldNo2,TRIM((SALT311.StrType)le.append_process_date),TRIM((SALT311.StrType)le.credentialstate),TRIM((SALT311.StrType)le.credentialnumber),TRIM((SALT311.StrType)le.lastname),TRIM((SALT311.StrType)le.firstname),TRIM((SALT311.StrType)le.middleinitial),TRIM((SALT311.StrType)le.gender),TRIM((SALT311.StrType)le.height),TRIM((SALT311.StrType)le.eyecolor),TRIM((SALT311.StrType)le.date_birth),TRIM((SALT311.StrType)le.resiaddrstreet),TRIM((SALT311.StrType)le.residencycity),TRIM((SALT311.StrType)le.residencystate),TRIM((SALT311.StrType)le.residencyzip),TRIM((SALT311.StrType)le.mailaddrstreet),TRIM((SALT311.StrType)le.mailingcity),TRIM((SALT311.StrType)le.mailingstate),TRIM((SALT311.StrType)le.mailingzip),TRIM((SALT311.StrType)le.credentialtype),TRIM((SALT311.StrType)le.credential_class),TRIM((SALT311.StrType)le.endorsements),TRIM((SALT311.StrType)le.restrictions),TRIM((SALT311.StrType)le.expdate),TRIM((SALT311.StrType)le.lastissuerenewaldate),TRIM((SALT311.StrType)le.date_noncdl),TRIM((SALT311.StrType)le.originaldate_cdl),TRIM((SALT311.StrType)le.statusnoncdl),TRIM((SALT311.StrType)le.licensestatuscdl),TRIM((SALT311.StrType)le.originaldate_lp),TRIM((SALT311.StrType)le.originaldate_id),TRIM((SALT311.StrType)le.cancelstate),TRIM((SALT311.StrType)le.canceldate),TRIM((SALT311.StrType)le.cdlmedicertissuedate),TRIM((SALT311.StrType)le.cdlmedicertexpdate),TRIM((SALT311.StrType)le.clean_name_prefix),TRIM((SALT311.StrType)le.clean_name_first),TRIM((SALT311.StrType)le.clean_name_middle),TRIM((SALT311.StrType)le.clean_name_last),TRIM((SALT311.StrType)le.clean_name_suffix),TRIM((SALT311.StrType)le.clean_name_score)));
  END;
SHARED Pairs0 := NORMALIZE(ENTH(h,Config.CorrelateSampleSize),40*40,IntoP(LEFT,COUNTER))(FldNo1<FldNo2);
SHARED FldIds := DATASET([{1,'append_process_date'}
      ,{2,'credentialstate'}
      ,{3,'credentialnumber'}
      ,{4,'lastname'}
      ,{5,'firstname'}
      ,{6,'middleinitial'}
      ,{7,'gender'}
      ,{8,'height'}
      ,{9,'eyecolor'}
      ,{10,'date_birth'}
      ,{11,'resiaddrstreet'}
      ,{12,'residencycity'}
      ,{13,'residencystate'}
      ,{14,'residencyzip'}
      ,{15,'mailaddrstreet'}
      ,{16,'mailingcity'}
      ,{17,'mailingstate'}
      ,{18,'mailingzip'}
      ,{19,'credentialtype'}
      ,{20,'credential_class'}
      ,{21,'endorsements'}
      ,{22,'restrictions'}
      ,{23,'expdate'}
      ,{24,'lastissuerenewaldate'}
      ,{25,'date_noncdl'}
      ,{26,'originaldate_cdl'}
      ,{27,'statusnoncdl'}
      ,{28,'licensestatuscdl'}
      ,{29,'originaldate_lp'}
      ,{30,'originaldate_id'}
      ,{31,'cancelstate'}
      ,{32,'canceldate'}
      ,{33,'cdlmedicertissuedate'}
      ,{34,'cdlmedicertexpdate'}
      ,{35,'clean_name_prefix'}
      ,{36,'clean_name_first'}
      ,{37,'clean_name_middle'}
      ,{38,'clean_name_last'}
      ,{39,'clean_name_suffix'}
      ,{40,'clean_name_score'}],SALT311.MAC_Character_Counts.Field_Identification);
EXPORT AllProfiles := SALT311.MAC_Character_Counts.FN_Profile(FldInv0,FldIds);
 
EXPORT SrcProfiles := SALT311.MAC_Character_Counts.Src_Profile(FldInv0,FldIds);
 
EXPORT Correlations := SALT311.MAC_Correlate.Fn_Profile(Pairs0,FldIds);
 
ErrorRecord := RECORD
  UNSIGNED1 FieldNum;
  UNSIGNED1 ErrorNum;
END;
ErrorRecord NoteErrors(h le,UNSIGNED1 c) := TRANSFORM
  SELF.ErrorNum := CHOOSE(c,
    Fields.InValid_append_process_date((SALT311.StrType)le.append_process_date),
    Fields.InValid_credentialstate((SALT311.StrType)le.credentialstate),
    Fields.InValid_credentialnumber((SALT311.StrType)le.credentialnumber),
    Fields.InValid_lastname((SALT311.StrType)le.lastname,(SALT311.StrType)le.firstname,(SALT311.StrType)le.middleinitial),
    Fields.InValid_firstname((SALT311.StrType)le.firstname),
    Fields.InValid_middleinitial((SALT311.StrType)le.middleinitial),
    Fields.InValid_gender((SALT311.StrType)le.gender),
    Fields.InValid_height((SALT311.StrType)le.height),
    Fields.InValid_eyecolor((SALT311.StrType)le.eyecolor),
    Fields.InValid_date_birth((SALT311.StrType)le.date_birth),
    Fields.InValid_resiaddrstreet((SALT311.StrType)le.resiaddrstreet),
    Fields.InValid_residencycity((SALT311.StrType)le.residencycity),
    Fields.InValid_residencystate((SALT311.StrType)le.residencystate),
    Fields.InValid_residencyzip((SALT311.StrType)le.residencyzip),
    Fields.InValid_mailaddrstreet((SALT311.StrType)le.mailaddrstreet),
    Fields.InValid_mailingcity((SALT311.StrType)le.mailingcity),
    Fields.InValid_mailingstate((SALT311.StrType)le.mailingstate),
    Fields.InValid_mailingzip((SALT311.StrType)le.mailingzip),
    Fields.InValid_credentialtype((SALT311.StrType)le.credentialtype),
    Fields.InValid_credential_class((SALT311.StrType)le.credential_class),
    Fields.InValid_endorsements((SALT311.StrType)le.endorsements),
    Fields.InValid_restrictions((SALT311.StrType)le.restrictions),
    Fields.InValid_expdate((SALT311.StrType)le.expdate),
    Fields.InValid_lastissuerenewaldate((SALT311.StrType)le.lastissuerenewaldate),
    Fields.InValid_date_noncdl((SALT311.StrType)le.date_noncdl),
    Fields.InValid_originaldate_cdl((SALT311.StrType)le.originaldate_cdl),
    Fields.InValid_statusnoncdl((SALT311.StrType)le.statusnoncdl),
    Fields.InValid_licensestatuscdl((SALT311.StrType)le.licensestatuscdl),
    Fields.InValid_originaldate_lp((SALT311.StrType)le.originaldate_lp),
    Fields.InValid_originaldate_id((SALT311.StrType)le.originaldate_id),
    Fields.InValid_cancelstate((SALT311.StrType)le.cancelstate),
    Fields.InValid_canceldate((SALT311.StrType)le.canceldate),
    Fields.InValid_cdlmedicertissuedate((SALT311.StrType)le.cdlmedicertissuedate),
    Fields.InValid_cdlmedicertexpdate((SALT311.StrType)le.cdlmedicertexpdate),
    Fields.InValid_clean_name_prefix((SALT311.StrType)le.clean_name_prefix),
    Fields.InValid_clean_name_first((SALT311.StrType)le.clean_name_first),
    Fields.InValid_clean_name_middle((SALT311.StrType)le.clean_name_middle),
    Fields.InValid_clean_name_last((SALT311.StrType)le.clean_name_last,(SALT311.StrType)le.clean_name_first,(SALT311.StrType)le.clean_name_middle),
    Fields.InValid_clean_name_suffix((SALT311.StrType)le.clean_name_suffix),
    Fields.InValid_clean_name_score((SALT311.StrType)le.clean_name_score),
    0);
  SELF.FieldNum := IF(SELF.ErrorNum=0,SKIP,c); // Bail early to avoid creating record
END;
Errors := NORMALIZE(h,40,NoteErrors(LEFT,COUNTER));
ErrorRecordsTotals := RECORD
  Errors.FieldNum;
  Errors.ErrorNum;
  UNSIGNED Cnt := COUNT(GROUP);
END;
TotalErrors := TABLE(Errors,ErrorRecordsTotals,FieldNum,ErrorNum,FEW);
PrettyErrorTotals := RECORD
  FieldNme := Fields.FieldName(TotalErrors.FieldNum);
  FieldType := CHOOSE(TotalErrors.FieldNum,'invalid_past_date','invalid_credentialstate','invalid_credentialnumber','invalid_name','Unknown','Unknown','invalid_sex','invalid_height','invalid_eye_color','invalid_past_date','invalid_street','invalid_city','invalid_state','invalid_zip','invalid_street','invalid_city','invalid_state','invalid_zip','invalid_credentialtype','invalid_class','invalid_endorsements','invalid_restrictions','invalid_general_date','invalid_past_date','invalid_past_date','invalid_past_date','invalid_status','invalid_status_cdl','invalid_past_date','invalid_past_date','invalid_state','invalid_past_date','invalid_past_date','invalid_general_date','Unknown','Unknown','Unknown','invalid_clean_name','Unknown','Unknown');
  ErrorMessage := CHOOSE(TotalErrors.FieldNum,Fields.InValidMessage_append_process_date(TotalErrors.ErrorNum),Fields.InValidMessage_credentialstate(TotalErrors.ErrorNum),Fields.InValidMessage_credentialnumber(TotalErrors.ErrorNum),Fields.InValidMessage_lastname(TotalErrors.ErrorNum),Fields.InValidMessage_firstname(TotalErrors.ErrorNum),Fields.InValidMessage_middleinitial(TotalErrors.ErrorNum),Fields.InValidMessage_gender(TotalErrors.ErrorNum),Fields.InValidMessage_height(TotalErrors.ErrorNum),Fields.InValidMessage_eyecolor(TotalErrors.ErrorNum),Fields.InValidMessage_date_birth(TotalErrors.ErrorNum),Fields.InValidMessage_resiaddrstreet(TotalErrors.ErrorNum),Fields.InValidMessage_residencycity(TotalErrors.ErrorNum),Fields.InValidMessage_residencystate(TotalErrors.ErrorNum),Fields.InValidMessage_residencyzip(TotalErrors.ErrorNum),Fields.InValidMessage_mailaddrstreet(TotalErrors.ErrorNum),Fields.InValidMessage_mailingcity(TotalErrors.ErrorNum),Fields.InValidMessage_mailingstate(TotalErrors.ErrorNum),Fields.InValidMessage_mailingzip(TotalErrors.ErrorNum),Fields.InValidMessage_credentialtype(TotalErrors.ErrorNum),Fields.InValidMessage_credential_class(TotalErrors.ErrorNum),Fields.InValidMessage_endorsements(TotalErrors.ErrorNum),Fields.InValidMessage_restrictions(TotalErrors.ErrorNum),Fields.InValidMessage_expdate(TotalErrors.ErrorNum),Fields.InValidMessage_lastissuerenewaldate(TotalErrors.ErrorNum),Fields.InValidMessage_date_noncdl(TotalErrors.ErrorNum),Fields.InValidMessage_originaldate_cdl(TotalErrors.ErrorNum),Fields.InValidMessage_statusnoncdl(TotalErrors.ErrorNum),Fields.InValidMessage_licensestatuscdl(TotalErrors.ErrorNum),Fields.InValidMessage_originaldate_lp(TotalErrors.ErrorNum),Fields.InValidMessage_originaldate_id(TotalErrors.ErrorNum),Fields.InValidMessage_cancelstate(TotalErrors.ErrorNum),Fields.InValidMessage_canceldate(TotalErrors.ErrorNum),Fields.InValidMessage_cdlmedicertissuedate(TotalErrors.ErrorNum),Fields.InValidMessage_cdlmedicertexpdate(TotalErrors.ErrorNum),Fields.InValidMessage_clean_name_prefix(TotalErrors.ErrorNum),Fields.InValidMessage_clean_name_first(TotalErrors.ErrorNum),Fields.InValidMessage_clean_name_middle(TotalErrors.ErrorNum),Fields.InValidMessage_clean_name_last(TotalErrors.ErrorNum),Fields.InValidMessage_clean_name_suffix(TotalErrors.ErrorNum),Fields.InValidMessage_clean_name_score(TotalErrors.ErrorNum));
  TotalErrors.Cnt;
END;
ValErr := TABLE(TotalErrors,PrettyErrorTotals);
EXPORT ValidityErrors := ValErr;
EXPORT StandardStats(BOOLEAN doSummaryGlobal = TRUE, BOOLEAN doAllProfiles = TRUE) := FUNCTION
  myTimeStamp := (UNSIGNED6)SALT311.Fn_Now('YYYYMMDDHHMMSS') : INDEPENDENT;
  fieldPopulationOverall := Summary('');
 
  SALT311.mod_StandardStatsTransforms.mac_hygieneSummaryTransform(Scrubs_DL_CT, Fields, 'RECORDOF(fieldPopulationOverall)', FALSE);
 
  fieldPopulationOverall_Standard := IF(doSummaryGlobal, NORMALIZE(fieldPopulationOverall, COUNT(FldIds) * 6, xSummary(LEFT, COUNTER, myTimeStamp, 'all', 'all')));
  fieldPopulationOverall_TotalRecs_Standard := IF(doSummaryGlobal, SALT311.mod_StandardStatsTransforms.mac_hygieneTotalRecs(fieldPopulationOverall, myTimeStamp, 'all', FALSE, 'all'));
  allProfiles_Standard := IF(doAllProfiles, SALT311.mod_StandardStatsTransforms.hygieneAllProfiles(AllProfiles, myTimeStamp, 10, 'all'));
 
  RETURN fieldPopulationOverall_Standard & fieldPopulationOverall_TotalRecs_Standard & allProfiles_Standard;
END;
END;
