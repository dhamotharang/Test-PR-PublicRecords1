IMPORT SALT38,STD;
EXPORT hygiene(dataset(layout_OKC_Probate_Profile) h) := MODULE

//A simple summary record
EXPORT Summary(SALT38.Str30Type  txt) := FUNCTION
  SummaryLayout := RECORD
    txt;
    NumberOfRecords := COUNT(GROUP);
    populated_name_score_cnt := COUNT(GROUP,h.name_score <> (TYPEOF(h.name_score))'');
    populated_name_score_pcnt := AVE(GROUP,IF(h.name_score = (TYPEOF(h.name_score))'',0,100));
    maxlength_name_score := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.name_score)));
    avelength_name_score := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.name_score)),h.name_score<>(typeof(h.name_score))'');
    populated_filedate_cnt := COUNT(GROUP,h.filedate <> (TYPEOF(h.filedate))'');
    populated_filedate_pcnt := AVE(GROUP,IF(h.filedate = (TYPEOF(h.filedate))'',0,100));
    maxlength_filedate := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.filedate)));
    avelength_filedate := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.filedate)),h.filedate<>(typeof(h.filedate))'');
    populated_dod_cnt := COUNT(GROUP,h.dod <> (TYPEOF(h.dod))'');
    populated_dod_pcnt := AVE(GROUP,IF(h.dod = (TYPEOF(h.dod))'',0,100));
    maxlength_dod := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.dod)));
    avelength_dod := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.dod)),h.dod<>(typeof(h.dod))'');
    populated_dob_cnt := COUNT(GROUP,h.dob <> (TYPEOF(h.dob))'');
    populated_dob_pcnt := AVE(GROUP,IF(h.dob = (TYPEOF(h.dob))'',0,100));
    maxlength_dob := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.dob)));
    avelength_dob := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.dob)),h.dob<>(typeof(h.dob))'');
    populated_masterid_cnt := COUNT(GROUP,h.masterid <> (TYPEOF(h.masterid))'');
    populated_masterid_pcnt := AVE(GROUP,IF(h.masterid = (TYPEOF(h.masterid))'',0,100));
    maxlength_masterid := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.masterid)));
    avelength_masterid := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.masterid)),h.masterid<>(typeof(h.masterid))'');
    populated_debtorfirstname_cnt := COUNT(GROUP,h.debtorfirstname <> (TYPEOF(h.debtorfirstname))'');
    populated_debtorfirstname_pcnt := AVE(GROUP,IF(h.debtorfirstname = (TYPEOF(h.debtorfirstname))'',0,100));
    maxlength_debtorfirstname := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.debtorfirstname)));
    avelength_debtorfirstname := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.debtorfirstname)),h.debtorfirstname<>(typeof(h.debtorfirstname))'');
    populated_debtorlastname_cnt := COUNT(GROUP,h.debtorlastname <> (TYPEOF(h.debtorlastname))'');
    populated_debtorlastname_pcnt := AVE(GROUP,IF(h.debtorlastname = (TYPEOF(h.debtorlastname))'',0,100));
    maxlength_debtorlastname := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.debtorlastname)));
    avelength_debtorlastname := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.debtorlastname)),h.debtorlastname<>(typeof(h.debtorlastname))'');
    populated_debtoraddress1_cnt := COUNT(GROUP,h.debtoraddress1 <> (TYPEOF(h.debtoraddress1))'');
    populated_debtoraddress1_pcnt := AVE(GROUP,IF(h.debtoraddress1 = (TYPEOF(h.debtoraddress1))'',0,100));
    maxlength_debtoraddress1 := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.debtoraddress1)));
    avelength_debtoraddress1 := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.debtoraddress1)),h.debtoraddress1<>(typeof(h.debtoraddress1))'');
    populated_debtoraddress2_cnt := COUNT(GROUP,h.debtoraddress2 <> (TYPEOF(h.debtoraddress2))'');
    populated_debtoraddress2_pcnt := AVE(GROUP,IF(h.debtoraddress2 = (TYPEOF(h.debtoraddress2))'',0,100));
    maxlength_debtoraddress2 := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.debtoraddress2)));
    avelength_debtoraddress2 := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.debtoraddress2)),h.debtoraddress2<>(typeof(h.debtoraddress2))'');
    populated_debtoraddresscity_cnt := COUNT(GROUP,h.debtoraddresscity <> (TYPEOF(h.debtoraddresscity))'');
    populated_debtoraddresscity_pcnt := AVE(GROUP,IF(h.debtoraddresscity = (TYPEOF(h.debtoraddresscity))'',0,100));
    maxlength_debtoraddresscity := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.debtoraddresscity)));
    avelength_debtoraddresscity := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.debtoraddresscity)),h.debtoraddresscity<>(typeof(h.debtoraddresscity))'');
    populated_debtoraddressstate_cnt := COUNT(GROUP,h.debtoraddressstate <> (TYPEOF(h.debtoraddressstate))'');
    populated_debtoraddressstate_pcnt := AVE(GROUP,IF(h.debtoraddressstate = (TYPEOF(h.debtoraddressstate))'',0,100));
    maxlength_debtoraddressstate := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.debtoraddressstate)));
    avelength_debtoraddressstate := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.debtoraddressstate)),h.debtoraddressstate<>(typeof(h.debtoraddressstate))'');
    populated_debtoraddresszipcode_cnt := COUNT(GROUP,h.debtoraddresszipcode <> (TYPEOF(h.debtoraddresszipcode))'');
    populated_debtoraddresszipcode_pcnt := AVE(GROUP,IF(h.debtoraddresszipcode = (TYPEOF(h.debtoraddresszipcode))'',0,100));
    maxlength_debtoraddresszipcode := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.debtoraddresszipcode)));
    avelength_debtoraddresszipcode := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.debtoraddresszipcode)),h.debtoraddresszipcode<>(typeof(h.debtoraddresszipcode))'');
    populated_dateofdeath_cnt := COUNT(GROUP,h.dateofdeath <> (TYPEOF(h.dateofdeath))'');
    populated_dateofdeath_pcnt := AVE(GROUP,IF(h.dateofdeath = (TYPEOF(h.dateofdeath))'',0,100));
    maxlength_dateofdeath := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.dateofdeath)));
    avelength_dateofdeath := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.dateofdeath)),h.dateofdeath<>(typeof(h.dateofdeath))'');
    populated_dateofbirth_cnt := COUNT(GROUP,h.dateofbirth <> (TYPEOF(h.dateofbirth))'');
    populated_dateofbirth_pcnt := AVE(GROUP,IF(h.dateofbirth = (TYPEOF(h.dateofbirth))'',0,100));
    maxlength_dateofbirth := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.dateofbirth)));
    avelength_dateofbirth := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.dateofbirth)),h.dateofbirth<>(typeof(h.dateofbirth))'');
    populated_isprobatelocated_cnt := COUNT(GROUP,h.isprobatelocated <> (TYPEOF(h.isprobatelocated))'');
    populated_isprobatelocated_pcnt := AVE(GROUP,IF(h.isprobatelocated = (TYPEOF(h.isprobatelocated))'',0,100));
    maxlength_isprobatelocated := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.isprobatelocated)));
    avelength_isprobatelocated := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.isprobatelocated)),h.isprobatelocated<>(typeof(h.isprobatelocated))'');
    populated_casenumber_cnt := COUNT(GROUP,h.casenumber <> (TYPEOF(h.casenumber))'');
    populated_casenumber_pcnt := AVE(GROUP,IF(h.casenumber = (TYPEOF(h.casenumber))'',0,100));
    maxlength_casenumber := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.casenumber)));
    avelength_casenumber := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.casenumber)),h.casenumber<>(typeof(h.casenumber))'');
    populated_filingdate_cnt := COUNT(GROUP,h.filingdate <> (TYPEOF(h.filingdate))'');
    populated_filingdate_pcnt := AVE(GROUP,IF(h.filingdate = (TYPEOF(h.filingdate))'',0,100));
    maxlength_filingdate := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.filingdate)));
    avelength_filingdate := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.filingdate)),h.filingdate<>(typeof(h.filingdate))'');
    populated_lastdatetofileclaim_cnt := COUNT(GROUP,h.lastdatetofileclaim <> (TYPEOF(h.lastdatetofileclaim))'');
    populated_lastdatetofileclaim_pcnt := AVE(GROUP,IF(h.lastdatetofileclaim = (TYPEOF(h.lastdatetofileclaim))'',0,100));
    maxlength_lastdatetofileclaim := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.lastdatetofileclaim)));
    avelength_lastdatetofileclaim := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.lastdatetofileclaim)),h.lastdatetofileclaim<>(typeof(h.lastdatetofileclaim))'');
    populated_issubjecttocreditorsclaim_cnt := COUNT(GROUP,h.issubjecttocreditorsclaim <> (TYPEOF(h.issubjecttocreditorsclaim))'');
    populated_issubjecttocreditorsclaim_pcnt := AVE(GROUP,IF(h.issubjecttocreditorsclaim = (TYPEOF(h.issubjecttocreditorsclaim))'',0,100));
    maxlength_issubjecttocreditorsclaim := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.issubjecttocreditorsclaim)));
    avelength_issubjecttocreditorsclaim := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.issubjecttocreditorsclaim)),h.issubjecttocreditorsclaim<>(typeof(h.issubjecttocreditorsclaim))'');
    populated_publicationstartdate_cnt := COUNT(GROUP,h.publicationstartdate <> (TYPEOF(h.publicationstartdate))'');
    populated_publicationstartdate_pcnt := AVE(GROUP,IF(h.publicationstartdate = (TYPEOF(h.publicationstartdate))'',0,100));
    maxlength_publicationstartdate := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.publicationstartdate)));
    avelength_publicationstartdate := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.publicationstartdate)),h.publicationstartdate<>(typeof(h.publicationstartdate))'');
    populated_isestateopen_cnt := COUNT(GROUP,h.isestateopen <> (TYPEOF(h.isestateopen))'');
    populated_isestateopen_pcnt := AVE(GROUP,IF(h.isestateopen = (TYPEOF(h.isestateopen))'',0,100));
    maxlength_isestateopen := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.isestateopen)));
    avelength_isestateopen := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.isestateopen)),h.isestateopen<>(typeof(h.isestateopen))'');
    populated_executorfirstname_cnt := COUNT(GROUP,h.executorfirstname <> (TYPEOF(h.executorfirstname))'');
    populated_executorfirstname_pcnt := AVE(GROUP,IF(h.executorfirstname = (TYPEOF(h.executorfirstname))'',0,100));
    maxlength_executorfirstname := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.executorfirstname)));
    avelength_executorfirstname := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.executorfirstname)),h.executorfirstname<>(typeof(h.executorfirstname))'');
    populated_executorlastname_cnt := COUNT(GROUP,h.executorlastname <> (TYPEOF(h.executorlastname))'');
    populated_executorlastname_pcnt := AVE(GROUP,IF(h.executorlastname = (TYPEOF(h.executorlastname))'',0,100));
    maxlength_executorlastname := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.executorlastname)));
    avelength_executorlastname := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.executorlastname)),h.executorlastname<>(typeof(h.executorlastname))'');
    populated_executoraddress1_cnt := COUNT(GROUP,h.executoraddress1 <> (TYPEOF(h.executoraddress1))'');
    populated_executoraddress1_pcnt := AVE(GROUP,IF(h.executoraddress1 = (TYPEOF(h.executoraddress1))'',0,100));
    maxlength_executoraddress1 := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.executoraddress1)));
    avelength_executoraddress1 := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.executoraddress1)),h.executoraddress1<>(typeof(h.executoraddress1))'');
    populated_executoraddress2_cnt := COUNT(GROUP,h.executoraddress2 <> (TYPEOF(h.executoraddress2))'');
    populated_executoraddress2_pcnt := AVE(GROUP,IF(h.executoraddress2 = (TYPEOF(h.executoraddress2))'',0,100));
    maxlength_executoraddress2 := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.executoraddress2)));
    avelength_executoraddress2 := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.executoraddress2)),h.executoraddress2<>(typeof(h.executoraddress2))'');
    populated_executoraddresscity_cnt := COUNT(GROUP,h.executoraddresscity <> (TYPEOF(h.executoraddresscity))'');
    populated_executoraddresscity_pcnt := AVE(GROUP,IF(h.executoraddresscity = (TYPEOF(h.executoraddresscity))'',0,100));
    maxlength_executoraddresscity := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.executoraddresscity)));
    avelength_executoraddresscity := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.executoraddresscity)),h.executoraddresscity<>(typeof(h.executoraddresscity))'');
    populated_executoraddressstate_cnt := COUNT(GROUP,h.executoraddressstate <> (TYPEOF(h.executoraddressstate))'');
    populated_executoraddressstate_pcnt := AVE(GROUP,IF(h.executoraddressstate = (TYPEOF(h.executoraddressstate))'',0,100));
    maxlength_executoraddressstate := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.executoraddressstate)));
    avelength_executoraddressstate := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.executoraddressstate)),h.executoraddressstate<>(typeof(h.executoraddressstate))'');
    populated_executoraddresszipcode_cnt := COUNT(GROUP,h.executoraddresszipcode <> (TYPEOF(h.executoraddresszipcode))'');
    populated_executoraddresszipcode_pcnt := AVE(GROUP,IF(h.executoraddresszipcode = (TYPEOF(h.executoraddresszipcode))'',0,100));
    maxlength_executoraddresszipcode := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.executoraddresszipcode)));
    avelength_executoraddresszipcode := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.executoraddresszipcode)),h.executoraddresszipcode<>(typeof(h.executoraddresszipcode))'');
    populated_executorphone_cnt := COUNT(GROUP,h.executorphone <> (TYPEOF(h.executorphone))'');
    populated_executorphone_pcnt := AVE(GROUP,IF(h.executorphone = (TYPEOF(h.executorphone))'',0,100));
    maxlength_executorphone := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.executorphone)));
    avelength_executorphone := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.executorphone)),h.executorphone<>(typeof(h.executorphone))'');
    populated_attorneyfirstname_cnt := COUNT(GROUP,h.attorneyfirstname <> (TYPEOF(h.attorneyfirstname))'');
    populated_attorneyfirstname_pcnt := AVE(GROUP,IF(h.attorneyfirstname = (TYPEOF(h.attorneyfirstname))'',0,100));
    maxlength_attorneyfirstname := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.attorneyfirstname)));
    avelength_attorneyfirstname := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.attorneyfirstname)),h.attorneyfirstname<>(typeof(h.attorneyfirstname))'');
    populated_attorneylastname_cnt := COUNT(GROUP,h.attorneylastname <> (TYPEOF(h.attorneylastname))'');
    populated_attorneylastname_pcnt := AVE(GROUP,IF(h.attorneylastname = (TYPEOF(h.attorneylastname))'',0,100));
    maxlength_attorneylastname := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.attorneylastname)));
    avelength_attorneylastname := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.attorneylastname)),h.attorneylastname<>(typeof(h.attorneylastname))'');
    populated_firm_cnt := COUNT(GROUP,h.firm <> (TYPEOF(h.firm))'');
    populated_firm_pcnt := AVE(GROUP,IF(h.firm = (TYPEOF(h.firm))'',0,100));
    maxlength_firm := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.firm)));
    avelength_firm := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.firm)),h.firm<>(typeof(h.firm))'');
    populated_attorneyaddress1_cnt := COUNT(GROUP,h.attorneyaddress1 <> (TYPEOF(h.attorneyaddress1))'');
    populated_attorneyaddress1_pcnt := AVE(GROUP,IF(h.attorneyaddress1 = (TYPEOF(h.attorneyaddress1))'',0,100));
    maxlength_attorneyaddress1 := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.attorneyaddress1)));
    avelength_attorneyaddress1 := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.attorneyaddress1)),h.attorneyaddress1<>(typeof(h.attorneyaddress1))'');
    populated_attorneyaddress2_cnt := COUNT(GROUP,h.attorneyaddress2 <> (TYPEOF(h.attorneyaddress2))'');
    populated_attorneyaddress2_pcnt := AVE(GROUP,IF(h.attorneyaddress2 = (TYPEOF(h.attorneyaddress2))'',0,100));
    maxlength_attorneyaddress2 := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.attorneyaddress2)));
    avelength_attorneyaddress2 := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.attorneyaddress2)),h.attorneyaddress2<>(typeof(h.attorneyaddress2))'');
    populated_attorneyaddresscity_cnt := COUNT(GROUP,h.attorneyaddresscity <> (TYPEOF(h.attorneyaddresscity))'');
    populated_attorneyaddresscity_pcnt := AVE(GROUP,IF(h.attorneyaddresscity = (TYPEOF(h.attorneyaddresscity))'',0,100));
    maxlength_attorneyaddresscity := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.attorneyaddresscity)));
    avelength_attorneyaddresscity := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.attorneyaddresscity)),h.attorneyaddresscity<>(typeof(h.attorneyaddresscity))'');
    populated_attorneyaddressstate_cnt := COUNT(GROUP,h.attorneyaddressstate <> (TYPEOF(h.attorneyaddressstate))'');
    populated_attorneyaddressstate_pcnt := AVE(GROUP,IF(h.attorneyaddressstate = (TYPEOF(h.attorneyaddressstate))'',0,100));
    maxlength_attorneyaddressstate := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.attorneyaddressstate)));
    avelength_attorneyaddressstate := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.attorneyaddressstate)),h.attorneyaddressstate<>(typeof(h.attorneyaddressstate))'');
    populated_attorneyaddresszipcode_cnt := COUNT(GROUP,h.attorneyaddresszipcode <> (TYPEOF(h.attorneyaddresszipcode))'');
    populated_attorneyaddresszipcode_pcnt := AVE(GROUP,IF(h.attorneyaddresszipcode = (TYPEOF(h.attorneyaddresszipcode))'',0,100));
    maxlength_attorneyaddresszipcode := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.attorneyaddresszipcode)));
    avelength_attorneyaddresszipcode := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.attorneyaddresszipcode)),h.attorneyaddresszipcode<>(typeof(h.attorneyaddresszipcode))'');
    populated_attorneyphone_cnt := COUNT(GROUP,h.attorneyphone <> (TYPEOF(h.attorneyphone))'');
    populated_attorneyphone_pcnt := AVE(GROUP,IF(h.attorneyphone = (TYPEOF(h.attorneyphone))'',0,100));
    maxlength_attorneyphone := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.attorneyphone)));
    avelength_attorneyphone := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.attorneyphone)),h.attorneyphone<>(typeof(h.attorneyphone))'');
    populated_attorneyemail_cnt := COUNT(GROUP,h.attorneyemail <> (TYPEOF(h.attorneyemail))'');
    populated_attorneyemail_pcnt := AVE(GROUP,IF(h.attorneyemail = (TYPEOF(h.attorneyemail))'',0,100));
    maxlength_attorneyemail := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.attorneyemail)));
    avelength_attorneyemail := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.attorneyemail)),h.attorneyemail<>(typeof(h.attorneyemail))'');
    populated_documenttypes_cnt := COUNT(GROUP,h.documenttypes <> (TYPEOF(h.documenttypes))'');
    populated_documenttypes_pcnt := AVE(GROUP,IF(h.documenttypes = (TYPEOF(h.documenttypes))'',0,100));
    maxlength_documenttypes := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.documenttypes)));
    avelength_documenttypes := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.documenttypes)),h.documenttypes<>(typeof(h.documenttypes))'');
    populated_corr_dateofdeath_cnt := COUNT(GROUP,h.corr_dateofdeath <> (TYPEOF(h.corr_dateofdeath))'');
    populated_corr_dateofdeath_pcnt := AVE(GROUP,IF(h.corr_dateofdeath = (TYPEOF(h.corr_dateofdeath))'',0,100));
    maxlength_corr_dateofdeath := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.corr_dateofdeath)));
    avelength_corr_dateofdeath := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.corr_dateofdeath)),h.corr_dateofdeath<>(typeof(h.corr_dateofdeath))'');
    populated_pdid_cnt := COUNT(GROUP,h.pdid <> (TYPEOF(h.pdid))'');
    populated_pdid_pcnt := AVE(GROUP,IF(h.pdid = (TYPEOF(h.pdid))'',0,100));
    maxlength_pdid := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.pdid)));
    avelength_pdid := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.pdid)),h.pdid<>(typeof(h.pdid))'');
    populated_pfrd_address_ind_cnt := COUNT(GROUP,h.pfrd_address_ind <> (TYPEOF(h.pfrd_address_ind))'');
    populated_pfrd_address_ind_pcnt := AVE(GROUP,IF(h.pfrd_address_ind = (TYPEOF(h.pfrd_address_ind))'',0,100));
    maxlength_pfrd_address_ind := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.pfrd_address_ind)));
    avelength_pfrd_address_ind := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.pfrd_address_ind)),h.pfrd_address_ind<>(typeof(h.pfrd_address_ind))'');
    populated_nid_cnt := COUNT(GROUP,h.nid <> (TYPEOF(h.nid))'');
    populated_nid_pcnt := AVE(GROUP,IF(h.nid = (TYPEOF(h.nid))'',0,100));
    maxlength_nid := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.nid)));
    avelength_nid := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.nid)),h.nid<>(typeof(h.nid))'');
    populated_cln_title_cnt := COUNT(GROUP,h.cln_title <> (TYPEOF(h.cln_title))'');
    populated_cln_title_pcnt := AVE(GROUP,IF(h.cln_title = (TYPEOF(h.cln_title))'',0,100));
    maxlength_cln_title := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.cln_title)));
    avelength_cln_title := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.cln_title)),h.cln_title<>(typeof(h.cln_title))'');
    populated_cln_fname_cnt := COUNT(GROUP,h.cln_fname <> (TYPEOF(h.cln_fname))'');
    populated_cln_fname_pcnt := AVE(GROUP,IF(h.cln_fname = (TYPEOF(h.cln_fname))'',0,100));
    maxlength_cln_fname := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.cln_fname)));
    avelength_cln_fname := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.cln_fname)),h.cln_fname<>(typeof(h.cln_fname))'');
    populated_cln_mname_cnt := COUNT(GROUP,h.cln_mname <> (TYPEOF(h.cln_mname))'');
    populated_cln_mname_pcnt := AVE(GROUP,IF(h.cln_mname = (TYPEOF(h.cln_mname))'',0,100));
    maxlength_cln_mname := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.cln_mname)));
    avelength_cln_mname := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.cln_mname)),h.cln_mname<>(typeof(h.cln_mname))'');
    populated_cln_lname_cnt := COUNT(GROUP,h.cln_lname <> (TYPEOF(h.cln_lname))'');
    populated_cln_lname_pcnt := AVE(GROUP,IF(h.cln_lname = (TYPEOF(h.cln_lname))'',0,100));
    maxlength_cln_lname := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.cln_lname)));
    avelength_cln_lname := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.cln_lname)),h.cln_lname<>(typeof(h.cln_lname))'');
    populated_cln_suffix_cnt := COUNT(GROUP,h.cln_suffix <> (TYPEOF(h.cln_suffix))'');
    populated_cln_suffix_pcnt := AVE(GROUP,IF(h.cln_suffix = (TYPEOF(h.cln_suffix))'',0,100));
    maxlength_cln_suffix := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.cln_suffix)));
    avelength_cln_suffix := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.cln_suffix)),h.cln_suffix<>(typeof(h.cln_suffix))'');
    populated_cln_title2_cnt := COUNT(GROUP,h.cln_title2 <> (TYPEOF(h.cln_title2))'');
    populated_cln_title2_pcnt := AVE(GROUP,IF(h.cln_title2 = (TYPEOF(h.cln_title2))'',0,100));
    maxlength_cln_title2 := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.cln_title2)));
    avelength_cln_title2 := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.cln_title2)),h.cln_title2<>(typeof(h.cln_title2))'');
    populated_cln_fname2_cnt := COUNT(GROUP,h.cln_fname2 <> (TYPEOF(h.cln_fname2))'');
    populated_cln_fname2_pcnt := AVE(GROUP,IF(h.cln_fname2 = (TYPEOF(h.cln_fname2))'',0,100));
    maxlength_cln_fname2 := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.cln_fname2)));
    avelength_cln_fname2 := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.cln_fname2)),h.cln_fname2<>(typeof(h.cln_fname2))'');
    populated_cln_mname2_cnt := COUNT(GROUP,h.cln_mname2 <> (TYPEOF(h.cln_mname2))'');
    populated_cln_mname2_pcnt := AVE(GROUP,IF(h.cln_mname2 = (TYPEOF(h.cln_mname2))'',0,100));
    maxlength_cln_mname2 := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.cln_mname2)));
    avelength_cln_mname2 := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.cln_mname2)),h.cln_mname2<>(typeof(h.cln_mname2))'');
    populated_cln_lname2_cnt := COUNT(GROUP,h.cln_lname2 <> (TYPEOF(h.cln_lname2))'');
    populated_cln_lname2_pcnt := AVE(GROUP,IF(h.cln_lname2 = (TYPEOF(h.cln_lname2))'',0,100));
    maxlength_cln_lname2 := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.cln_lname2)));
    avelength_cln_lname2 := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.cln_lname2)),h.cln_lname2<>(typeof(h.cln_lname2))'');
    populated_cln_suffix2_cnt := COUNT(GROUP,h.cln_suffix2 <> (TYPEOF(h.cln_suffix2))'');
    populated_cln_suffix2_pcnt := AVE(GROUP,IF(h.cln_suffix2 = (TYPEOF(h.cln_suffix2))'',0,100));
    maxlength_cln_suffix2 := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.cln_suffix2)));
    avelength_cln_suffix2 := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.cln_suffix2)),h.cln_suffix2<>(typeof(h.cln_suffix2))'');
    populated_persistent_record_id_cnt := COUNT(GROUP,h.persistent_record_id <> (TYPEOF(h.persistent_record_id))'');
    populated_persistent_record_id_pcnt := AVE(GROUP,IF(h.persistent_record_id = (TYPEOF(h.persistent_record_id))'',0,100));
    maxlength_persistent_record_id := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.persistent_record_id)));
    avelength_persistent_record_id := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.persistent_record_id)),h.persistent_record_id<>(typeof(h.persistent_record_id))'');
    populated_cname_cnt := COUNT(GROUP,h.cname <> (TYPEOF(h.cname))'');
    populated_cname_pcnt := AVE(GROUP,IF(h.cname = (TYPEOF(h.cname))'',0,100));
    maxlength_cname := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.cname)));
    avelength_cname := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.cname)),h.cname<>(typeof(h.cname))'');
    populated_cleanaid_cnt := COUNT(GROUP,h.cleanaid <> (TYPEOF(h.cleanaid))'');
    populated_cleanaid_pcnt := AVE(GROUP,IF(h.cleanaid = (TYPEOF(h.cleanaid))'',0,100));
    maxlength_cleanaid := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.cleanaid)));
    avelength_cleanaid := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.cleanaid)),h.cleanaid<>(typeof(h.cleanaid))'');
    populated_addresstype_cnt := COUNT(GROUP,h.addresstype <> (TYPEOF(h.addresstype))'');
    populated_addresstype_pcnt := AVE(GROUP,IF(h.addresstype = (TYPEOF(h.addresstype))'',0,100));
    maxlength_addresstype := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.addresstype)));
    avelength_addresstype := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.addresstype)),h.addresstype<>(typeof(h.addresstype))'');
    populated_prim_range_cnt := COUNT(GROUP,h.prim_range <> (TYPEOF(h.prim_range))'');
    populated_prim_range_pcnt := AVE(GROUP,IF(h.prim_range = (TYPEOF(h.prim_range))'',0,100));
    maxlength_prim_range := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.prim_range)));
    avelength_prim_range := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.prim_range)),h.prim_range<>(typeof(h.prim_range))'');
    populated_predir_cnt := COUNT(GROUP,h.predir <> (TYPEOF(h.predir))'');
    populated_predir_pcnt := AVE(GROUP,IF(h.predir = (TYPEOF(h.predir))'',0,100));
    maxlength_predir := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.predir)));
    avelength_predir := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.predir)),h.predir<>(typeof(h.predir))'');
    populated_prim_name_cnt := COUNT(GROUP,h.prim_name <> (TYPEOF(h.prim_name))'');
    populated_prim_name_pcnt := AVE(GROUP,IF(h.prim_name = (TYPEOF(h.prim_name))'',0,100));
    maxlength_prim_name := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.prim_name)));
    avelength_prim_name := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.prim_name)),h.prim_name<>(typeof(h.prim_name))'');
    populated_addr_suffix_cnt := COUNT(GROUP,h.addr_suffix <> (TYPEOF(h.addr_suffix))'');
    populated_addr_suffix_pcnt := AVE(GROUP,IF(h.addr_suffix = (TYPEOF(h.addr_suffix))'',0,100));
    maxlength_addr_suffix := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.addr_suffix)));
    avelength_addr_suffix := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.addr_suffix)),h.addr_suffix<>(typeof(h.addr_suffix))'');
    populated_postdir_cnt := COUNT(GROUP,h.postdir <> (TYPEOF(h.postdir))'');
    populated_postdir_pcnt := AVE(GROUP,IF(h.postdir = (TYPEOF(h.postdir))'',0,100));
    maxlength_postdir := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.postdir)));
    avelength_postdir := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.postdir)),h.postdir<>(typeof(h.postdir))'');
    populated_unit_desig_cnt := COUNT(GROUP,h.unit_desig <> (TYPEOF(h.unit_desig))'');
    populated_unit_desig_pcnt := AVE(GROUP,IF(h.unit_desig = (TYPEOF(h.unit_desig))'',0,100));
    maxlength_unit_desig := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.unit_desig)));
    avelength_unit_desig := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.unit_desig)),h.unit_desig<>(typeof(h.unit_desig))'');
    populated_sec_range_cnt := COUNT(GROUP,h.sec_range <> (TYPEOF(h.sec_range))'');
    populated_sec_range_pcnt := AVE(GROUP,IF(h.sec_range = (TYPEOF(h.sec_range))'',0,100));
    maxlength_sec_range := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.sec_range)));
    avelength_sec_range := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.sec_range)),h.sec_range<>(typeof(h.sec_range))'');
    populated_p_city_name_cnt := COUNT(GROUP,h.p_city_name <> (TYPEOF(h.p_city_name))'');
    populated_p_city_name_pcnt := AVE(GROUP,IF(h.p_city_name = (TYPEOF(h.p_city_name))'',0,100));
    maxlength_p_city_name := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.p_city_name)));
    avelength_p_city_name := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.p_city_name)),h.p_city_name<>(typeof(h.p_city_name))'');
    populated_v_city_name_cnt := COUNT(GROUP,h.v_city_name <> (TYPEOF(h.v_city_name))'');
    populated_v_city_name_pcnt := AVE(GROUP,IF(h.v_city_name = (TYPEOF(h.v_city_name))'',0,100));
    maxlength_v_city_name := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.v_city_name)));
    avelength_v_city_name := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.v_city_name)),h.v_city_name<>(typeof(h.v_city_name))'');
    populated_st_cnt := COUNT(GROUP,h.st <> (TYPEOF(h.st))'');
    populated_st_pcnt := AVE(GROUP,IF(h.st = (TYPEOF(h.st))'',0,100));
    maxlength_st := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.st)));
    avelength_st := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.st)),h.st<>(typeof(h.st))'');
    populated_zip_cnt := COUNT(GROUP,h.zip <> (TYPEOF(h.zip))'');
    populated_zip_pcnt := AVE(GROUP,IF(h.zip = (TYPEOF(h.zip))'',0,100));
    maxlength_zip := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.zip)));
    avelength_zip := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.zip)),h.zip<>(typeof(h.zip))'');
    populated_zip4_cnt := COUNT(GROUP,h.zip4 <> (TYPEOF(h.zip4))'');
    populated_zip4_pcnt := AVE(GROUP,IF(h.zip4 = (TYPEOF(h.zip4))'',0,100));
    maxlength_zip4 := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.zip4)));
    avelength_zip4 := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.zip4)),h.zip4<>(typeof(h.zip4))'');
    populated_cart_cnt := COUNT(GROUP,h.cart <> (TYPEOF(h.cart))'');
    populated_cart_pcnt := AVE(GROUP,IF(h.cart = (TYPEOF(h.cart))'',0,100));
    maxlength_cart := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.cart)));
    avelength_cart := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.cart)),h.cart<>(typeof(h.cart))'');
    populated_cr_sort_sz_cnt := COUNT(GROUP,h.cr_sort_sz <> (TYPEOF(h.cr_sort_sz))'');
    populated_cr_sort_sz_pcnt := AVE(GROUP,IF(h.cr_sort_sz = (TYPEOF(h.cr_sort_sz))'',0,100));
    maxlength_cr_sort_sz := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.cr_sort_sz)));
    avelength_cr_sort_sz := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.cr_sort_sz)),h.cr_sort_sz<>(typeof(h.cr_sort_sz))'');
    populated_lot_cnt := COUNT(GROUP,h.lot <> (TYPEOF(h.lot))'');
    populated_lot_pcnt := AVE(GROUP,IF(h.lot = (TYPEOF(h.lot))'',0,100));
    maxlength_lot := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.lot)));
    avelength_lot := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.lot)),h.lot<>(typeof(h.lot))'');
    populated_lot_order_cnt := COUNT(GROUP,h.lot_order <> (TYPEOF(h.lot_order))'');
    populated_lot_order_pcnt := AVE(GROUP,IF(h.lot_order = (TYPEOF(h.lot_order))'',0,100));
    maxlength_lot_order := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.lot_order)));
    avelength_lot_order := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.lot_order)),h.lot_order<>(typeof(h.lot_order))'');
    populated_dbpc_cnt := COUNT(GROUP,h.dbpc <> (TYPEOF(h.dbpc))'');
    populated_dbpc_pcnt := AVE(GROUP,IF(h.dbpc = (TYPEOF(h.dbpc))'',0,100));
    maxlength_dbpc := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.dbpc)));
    avelength_dbpc := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.dbpc)),h.dbpc<>(typeof(h.dbpc))'');
    populated_chk_digit_cnt := COUNT(GROUP,h.chk_digit <> (TYPEOF(h.chk_digit))'');
    populated_chk_digit_pcnt := AVE(GROUP,IF(h.chk_digit = (TYPEOF(h.chk_digit))'',0,100));
    maxlength_chk_digit := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.chk_digit)));
    avelength_chk_digit := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.chk_digit)),h.chk_digit<>(typeof(h.chk_digit))'');
    populated_rec_type_cnt := COUNT(GROUP,h.rec_type <> (TYPEOF(h.rec_type))'');
    populated_rec_type_pcnt := AVE(GROUP,IF(h.rec_type = (TYPEOF(h.rec_type))'',0,100));
    maxlength_rec_type := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.rec_type)));
    avelength_rec_type := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.rec_type)),h.rec_type<>(typeof(h.rec_type))'');
    populated_fips_county_cnt := COUNT(GROUP,h.fips_county <> (TYPEOF(h.fips_county))'');
    populated_fips_county_pcnt := AVE(GROUP,IF(h.fips_county = (TYPEOF(h.fips_county))'',0,100));
    maxlength_fips_county := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.fips_county)));
    avelength_fips_county := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.fips_county)),h.fips_county<>(typeof(h.fips_county))'');
    populated_geo_lat_cnt := COUNT(GROUP,h.geo_lat <> (TYPEOF(h.geo_lat))'');
    populated_geo_lat_pcnt := AVE(GROUP,IF(h.geo_lat = (TYPEOF(h.geo_lat))'',0,100));
    maxlength_geo_lat := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.geo_lat)));
    avelength_geo_lat := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.geo_lat)),h.geo_lat<>(typeof(h.geo_lat))'');
    populated_geo_long_cnt := COUNT(GROUP,h.geo_long <> (TYPEOF(h.geo_long))'');
    populated_geo_long_pcnt := AVE(GROUP,IF(h.geo_long = (TYPEOF(h.geo_long))'',0,100));
    maxlength_geo_long := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.geo_long)));
    avelength_geo_long := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.geo_long)),h.geo_long<>(typeof(h.geo_long))'');
    populated_msa_cnt := COUNT(GROUP,h.msa <> (TYPEOF(h.msa))'');
    populated_msa_pcnt := AVE(GROUP,IF(h.msa = (TYPEOF(h.msa))'',0,100));
    maxlength_msa := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.msa)));
    avelength_msa := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.msa)),h.msa<>(typeof(h.msa))'');
    populated_geo_blk_cnt := COUNT(GROUP,h.geo_blk <> (TYPEOF(h.geo_blk))'');
    populated_geo_blk_pcnt := AVE(GROUP,IF(h.geo_blk = (TYPEOF(h.geo_blk))'',0,100));
    maxlength_geo_blk := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.geo_blk)));
    avelength_geo_blk := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.geo_blk)),h.geo_blk<>(typeof(h.geo_blk))'');
    populated_geo_match_cnt := COUNT(GROUP,h.geo_match <> (TYPEOF(h.geo_match))'');
    populated_geo_match_pcnt := AVE(GROUP,IF(h.geo_match = (TYPEOF(h.geo_match))'',0,100));
    maxlength_geo_match := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.geo_match)));
    avelength_geo_match := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.geo_match)),h.geo_match<>(typeof(h.geo_match))'');
    populated_err_stat_cnt := COUNT(GROUP,h.err_stat <> (TYPEOF(h.err_stat))'');
    populated_err_stat_pcnt := AVE(GROUP,IF(h.err_stat = (TYPEOF(h.err_stat))'',0,100));
    maxlength_err_stat := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.err_stat)));
    avelength_err_stat := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.err_stat)),h.err_stat<>(typeof(h.err_stat))'');
    populated_rawaid_cnt := COUNT(GROUP,h.rawaid <> (TYPEOF(h.rawaid))'');
    populated_rawaid_pcnt := AVE(GROUP,IF(h.rawaid = (TYPEOF(h.rawaid))'',0,100));
    maxlength_rawaid := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.rawaid)));
    avelength_rawaid := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.rawaid)),h.rawaid<>(typeof(h.rawaid))'');
  END;
    T := TABLE(h,SummaryLayout);
  R1 := RECORD
    UNSIGNED LinkingPotential :=  + T.Populated_name_score_pcnt *   0.00 / 100 + T.Populated_filedate_pcnt *   0.00 / 100 + T.Populated_dod_pcnt *   0.00 / 100 + T.Populated_dob_pcnt *   0.00 / 100 + T.Populated_masterid_pcnt *   0.00 / 100 + T.Populated_debtorfirstname_pcnt *   0.00 / 100 + T.Populated_debtorlastname_pcnt *   0.00 / 100 + T.Populated_debtoraddress1_pcnt *   0.00 / 100 + T.Populated_debtoraddress2_pcnt *   0.00 / 100 + T.Populated_debtoraddresscity_pcnt *   0.00 / 100 + T.Populated_debtoraddressstate_pcnt *   0.00 / 100 + T.Populated_debtoraddresszipcode_pcnt *   0.00 / 100 + T.Populated_dateofdeath_pcnt *   0.00 / 100 + T.Populated_dateofbirth_pcnt *   0.00 / 100 + T.Populated_isprobatelocated_pcnt *   0.00 / 100 + T.Populated_casenumber_pcnt *   0.00 / 100 + T.Populated_filingdate_pcnt *   0.00 / 100 + T.Populated_lastdatetofileclaim_pcnt *   0.00 / 100 + T.Populated_issubjecttocreditorsclaim_pcnt *   0.00 / 100 + T.Populated_publicationstartdate_pcnt *   0.00 / 100 + T.Populated_isestateopen_pcnt *   0.00 / 100 + T.Populated_executorfirstname_pcnt *   0.00 / 100 + T.Populated_executorlastname_pcnt *   0.00 / 100 + T.Populated_executoraddress1_pcnt *   0.00 / 100 + T.Populated_executoraddress2_pcnt *   0.00 / 100 + T.Populated_executoraddresscity_pcnt *   0.00 / 100 + T.Populated_executoraddressstate_pcnt *   0.00 / 100 + T.Populated_executoraddresszipcode_pcnt *   0.00 / 100 + T.Populated_executorphone_pcnt *   0.00 / 100 + T.Populated_attorneyfirstname_pcnt *   0.00 / 100 + T.Populated_attorneylastname_pcnt *   0.00 / 100 + T.Populated_firm_pcnt *   0.00 / 100 + T.Populated_attorneyaddress1_pcnt *   0.00 / 100 + T.Populated_attorneyaddress2_pcnt *   0.00 / 100 + T.Populated_attorneyaddresscity_pcnt *   0.00 / 100 + T.Populated_attorneyaddressstate_pcnt *   0.00 / 100 + T.Populated_attorneyaddresszipcode_pcnt *   0.00 / 100 + T.Populated_attorneyphone_pcnt *   0.00 / 100 + T.Populated_attorneyemail_pcnt *   0.00 / 100 + T.Populated_documenttypes_pcnt *   0.00 / 100 + T.Populated_corr_dateofdeath_pcnt *   0.00 / 100 + T.Populated_pdid_pcnt *   0.00 / 100 + T.Populated_pfrd_address_ind_pcnt *   0.00 / 100 + T.Populated_nid_pcnt *   0.00 / 100 + T.Populated_cln_title_pcnt *   0.00 / 100 + T.Populated_cln_fname_pcnt *   0.00 / 100 + T.Populated_cln_mname_pcnt *   0.00 / 100 + T.Populated_cln_lname_pcnt *   0.00 / 100 + T.Populated_cln_suffix_pcnt *   0.00 / 100 + T.Populated_cln_title2_pcnt *   0.00 / 100 + T.Populated_cln_fname2_pcnt *   0.00 / 100 + T.Populated_cln_mname2_pcnt *   0.00 / 100 + T.Populated_cln_lname2_pcnt *   0.00 / 100 + T.Populated_cln_suffix2_pcnt *   0.00 / 100 + T.Populated_persistent_record_id_pcnt *   0.00 / 100 + T.Populated_cname_pcnt *   0.00 / 100 + T.Populated_cleanaid_pcnt *   0.00 / 100 + T.Populated_addresstype_pcnt *   0.00 / 100 + T.Populated_prim_range_pcnt *   0.00 / 100 + T.Populated_predir_pcnt *   0.00 / 100 + T.Populated_prim_name_pcnt *   0.00 / 100 + T.Populated_addr_suffix_pcnt *   0.00 / 100 + T.Populated_postdir_pcnt *   0.00 / 100 + T.Populated_unit_desig_pcnt *   0.00 / 100 + T.Populated_sec_range_pcnt *   0.00 / 100 + T.Populated_p_city_name_pcnt *   0.00 / 100 + T.Populated_v_city_name_pcnt *   0.00 / 100 + T.Populated_st_pcnt *   0.00 / 100 + T.Populated_zip_pcnt *   0.00 / 100 + T.Populated_zip4_pcnt *   0.00 / 100 + T.Populated_cart_pcnt *   0.00 / 100 + T.Populated_cr_sort_sz_pcnt *   0.00 / 100 + T.Populated_lot_pcnt *   0.00 / 100 + T.Populated_lot_order_pcnt *   0.00 / 100 + T.Populated_dbpc_pcnt *   0.00 / 100 + T.Populated_chk_digit_pcnt *   0.00 / 100 + T.Populated_rec_type_pcnt *   0.00 / 100 + T.Populated_fips_county_pcnt *   0.00 / 100 + T.Populated_geo_lat_pcnt *   0.00 / 100 + T.Populated_geo_long_pcnt *   0.00 / 100 + T.Populated_msa_pcnt *   0.00 / 100 + T.Populated_geo_blk_pcnt *   0.00 / 100 + T.Populated_geo_match_pcnt *   0.00 / 100 + T.Populated_err_stat_pcnt *   0.00 / 100 + T.Populated_rawaid_pcnt *   0.00 / 100;
    T;
  END;
  RETURN TABLE(T,R1);
END;

summary0 := Summary('Summary');
  invRec := RECORD
  UNSIGNED  FldNo;
  SALT38.StrType FieldName;
  UNSIGNED NumberOfRecords;
  REAL8  populated_pcnt;
  UNSIGNED  maxlength;
  REAL8  avelength;
END;
invRec invert(summary0 le, INTEGER C) := TRANSFORM
  SELF.FldNo := C;
  SELF.NumberOfRecords := le.NumberOfRecords;
  SELF.FieldName := CHOOSE(C,'name_score','filedate','dod','dob','masterid','debtorfirstname','debtorlastname','debtoraddress1','debtoraddress2','debtoraddresscity','debtoraddressstate','debtoraddresszipcode','dateofdeath','dateofbirth','isprobatelocated','casenumber','filingdate','lastdatetofileclaim','issubjecttocreditorsclaim','publicationstartdate','isestateopen','executorfirstname','executorlastname','executoraddress1','executoraddress2','executoraddresscity','executoraddressstate','executoraddresszipcode','executorphone','attorneyfirstname','attorneylastname','firm','attorneyaddress1','attorneyaddress2','attorneyaddresscity','attorneyaddressstate','attorneyaddresszipcode','attorneyphone','attorneyemail','documenttypes','corr_dateofdeath','pdid','pfrd_address_ind','nid','cln_title','cln_fname','cln_mname','cln_lname','cln_suffix','cln_title2','cln_fname2','cln_mname2','cln_lname2','cln_suffix2','persistent_record_id','cname','cleanaid','addresstype','prim_range','predir','prim_name','addr_suffix','postdir','unit_desig','sec_range','p_city_name','v_city_name','st','zip','zip4','cart','cr_sort_sz','lot','lot_order','dbpc','chk_digit','rec_type','fips_county','geo_lat','geo_long','msa','geo_blk','geo_match','err_stat','rawaid');
  SELF.populated_pcnt := CHOOSE(C,le.populated_name_score_pcnt,le.populated_filedate_pcnt,le.populated_dod_pcnt,le.populated_dob_pcnt,le.populated_masterid_pcnt,le.populated_debtorfirstname_pcnt,le.populated_debtorlastname_pcnt,le.populated_debtoraddress1_pcnt,le.populated_debtoraddress2_pcnt,le.populated_debtoraddresscity_pcnt,le.populated_debtoraddressstate_pcnt,le.populated_debtoraddresszipcode_pcnt,le.populated_dateofdeath_pcnt,le.populated_dateofbirth_pcnt,le.populated_isprobatelocated_pcnt,le.populated_casenumber_pcnt,le.populated_filingdate_pcnt,le.populated_lastdatetofileclaim_pcnt,le.populated_issubjecttocreditorsclaim_pcnt,le.populated_publicationstartdate_pcnt,le.populated_isestateopen_pcnt,le.populated_executorfirstname_pcnt,le.populated_executorlastname_pcnt,le.populated_executoraddress1_pcnt,le.populated_executoraddress2_pcnt,le.populated_executoraddresscity_pcnt,le.populated_executoraddressstate_pcnt,le.populated_executoraddresszipcode_pcnt,le.populated_executorphone_pcnt,le.populated_attorneyfirstname_pcnt,le.populated_attorneylastname_pcnt,le.populated_firm_pcnt,le.populated_attorneyaddress1_pcnt,le.populated_attorneyaddress2_pcnt,le.populated_attorneyaddresscity_pcnt,le.populated_attorneyaddressstate_pcnt,le.populated_attorneyaddresszipcode_pcnt,le.populated_attorneyphone_pcnt,le.populated_attorneyemail_pcnt,le.populated_documenttypes_pcnt,le.populated_corr_dateofdeath_pcnt,le.populated_pdid_pcnt,le.populated_pfrd_address_ind_pcnt,le.populated_nid_pcnt,le.populated_cln_title_pcnt,le.populated_cln_fname_pcnt,le.populated_cln_mname_pcnt,le.populated_cln_lname_pcnt,le.populated_cln_suffix_pcnt,le.populated_cln_title2_pcnt,le.populated_cln_fname2_pcnt,le.populated_cln_mname2_pcnt,le.populated_cln_lname2_pcnt,le.populated_cln_suffix2_pcnt,le.populated_persistent_record_id_pcnt,le.populated_cname_pcnt,le.populated_cleanaid_pcnt,le.populated_addresstype_pcnt,le.populated_prim_range_pcnt,le.populated_predir_pcnt,le.populated_prim_name_pcnt,le.populated_addr_suffix_pcnt,le.populated_postdir_pcnt,le.populated_unit_desig_pcnt,le.populated_sec_range_pcnt,le.populated_p_city_name_pcnt,le.populated_v_city_name_pcnt,le.populated_st_pcnt,le.populated_zip_pcnt,le.populated_zip4_pcnt,le.populated_cart_pcnt,le.populated_cr_sort_sz_pcnt,le.populated_lot_pcnt,le.populated_lot_order_pcnt,le.populated_dbpc_pcnt,le.populated_chk_digit_pcnt,le.populated_rec_type_pcnt,le.populated_fips_county_pcnt,le.populated_geo_lat_pcnt,le.populated_geo_long_pcnt,le.populated_msa_pcnt,le.populated_geo_blk_pcnt,le.populated_geo_match_pcnt,le.populated_err_stat_pcnt,le.populated_rawaid_pcnt);
  SELF.maxlength := CHOOSE(C,le.maxlength_name_score,le.maxlength_filedate,le.maxlength_dod,le.maxlength_dob,le.maxlength_masterid,le.maxlength_debtorfirstname,le.maxlength_debtorlastname,le.maxlength_debtoraddress1,le.maxlength_debtoraddress2,le.maxlength_debtoraddresscity,le.maxlength_debtoraddressstate,le.maxlength_debtoraddresszipcode,le.maxlength_dateofdeath,le.maxlength_dateofbirth,le.maxlength_isprobatelocated,le.maxlength_casenumber,le.maxlength_filingdate,le.maxlength_lastdatetofileclaim,le.maxlength_issubjecttocreditorsclaim,le.maxlength_publicationstartdate,le.maxlength_isestateopen,le.maxlength_executorfirstname,le.maxlength_executorlastname,le.maxlength_executoraddress1,le.maxlength_executoraddress2,le.maxlength_executoraddresscity,le.maxlength_executoraddressstate,le.maxlength_executoraddresszipcode,le.maxlength_executorphone,le.maxlength_attorneyfirstname,le.maxlength_attorneylastname,le.maxlength_firm,le.maxlength_attorneyaddress1,le.maxlength_attorneyaddress2,le.maxlength_attorneyaddresscity,le.maxlength_attorneyaddressstate,le.maxlength_attorneyaddresszipcode,le.maxlength_attorneyphone,le.maxlength_attorneyemail,le.maxlength_documenttypes,le.maxlength_corr_dateofdeath,le.maxlength_pdid,le.maxlength_pfrd_address_ind,le.maxlength_nid,le.maxlength_cln_title,le.maxlength_cln_fname,le.maxlength_cln_mname,le.maxlength_cln_lname,le.maxlength_cln_suffix,le.maxlength_cln_title2,le.maxlength_cln_fname2,le.maxlength_cln_mname2,le.maxlength_cln_lname2,le.maxlength_cln_suffix2,le.maxlength_persistent_record_id,le.maxlength_cname,le.maxlength_cleanaid,le.maxlength_addresstype,le.maxlength_prim_range,le.maxlength_predir,le.maxlength_prim_name,le.maxlength_addr_suffix,le.maxlength_postdir,le.maxlength_unit_desig,le.maxlength_sec_range,le.maxlength_p_city_name,le.maxlength_v_city_name,le.maxlength_st,le.maxlength_zip,le.maxlength_zip4,le.maxlength_cart,le.maxlength_cr_sort_sz,le.maxlength_lot,le.maxlength_lot_order,le.maxlength_dbpc,le.maxlength_chk_digit,le.maxlength_rec_type,le.maxlength_fips_county,le.maxlength_geo_lat,le.maxlength_geo_long,le.maxlength_msa,le.maxlength_geo_blk,le.maxlength_geo_match,le.maxlength_err_stat,le.maxlength_rawaid);
  SELF.avelength := CHOOSE(C,le.avelength_name_score,le.avelength_filedate,le.avelength_dod,le.avelength_dob,le.avelength_masterid,le.avelength_debtorfirstname,le.avelength_debtorlastname,le.avelength_debtoraddress1,le.avelength_debtoraddress2,le.avelength_debtoraddresscity,le.avelength_debtoraddressstate,le.avelength_debtoraddresszipcode,le.avelength_dateofdeath,le.avelength_dateofbirth,le.avelength_isprobatelocated,le.avelength_casenumber,le.avelength_filingdate,le.avelength_lastdatetofileclaim,le.avelength_issubjecttocreditorsclaim,le.avelength_publicationstartdate,le.avelength_isestateopen,le.avelength_executorfirstname,le.avelength_executorlastname,le.avelength_executoraddress1,le.avelength_executoraddress2,le.avelength_executoraddresscity,le.avelength_executoraddressstate,le.avelength_executoraddresszipcode,le.avelength_executorphone,le.avelength_attorneyfirstname,le.avelength_attorneylastname,le.avelength_firm,le.avelength_attorneyaddress1,le.avelength_attorneyaddress2,le.avelength_attorneyaddresscity,le.avelength_attorneyaddressstate,le.avelength_attorneyaddresszipcode,le.avelength_attorneyphone,le.avelength_attorneyemail,le.avelength_documenttypes,le.avelength_corr_dateofdeath,le.avelength_pdid,le.avelength_pfrd_address_ind,le.avelength_nid,le.avelength_cln_title,le.avelength_cln_fname,le.avelength_cln_mname,le.avelength_cln_lname,le.avelength_cln_suffix,le.avelength_cln_title2,le.avelength_cln_fname2,le.avelength_cln_mname2,le.avelength_cln_lname2,le.avelength_cln_suffix2,le.avelength_persistent_record_id,le.avelength_cname,le.avelength_cleanaid,le.avelength_addresstype,le.avelength_prim_range,le.avelength_predir,le.avelength_prim_name,le.avelength_addr_suffix,le.avelength_postdir,le.avelength_unit_desig,le.avelength_sec_range,le.avelength_p_city_name,le.avelength_v_city_name,le.avelength_st,le.avelength_zip,le.avelength_zip4,le.avelength_cart,le.avelength_cr_sort_sz,le.avelength_lot,le.avelength_lot_order,le.avelength_dbpc,le.avelength_chk_digit,le.avelength_rec_type,le.avelength_fips_county,le.avelength_geo_lat,le.avelength_geo_long,le.avelength_msa,le.avelength_geo_blk,le.avelength_geo_match,le.avelength_err_stat,le.avelength_rawaid);
END;
EXPORT invSummary := NORMALIZE(summary0, 85, invert(LEFT,COUNTER));
// The character counts
// Move everything into 'inverted list' form so processing can be done 'in library'
SALT38.MAC_Character_Counts.X_Data_Layout Into(h le,unsigned C) := TRANSFORM
  SELF.Fld := TRIM(CHOOSE(C,TRIM((SALT38.StrType)le.name_score),TRIM((SALT38.StrType)le.filedate),TRIM((SALT38.StrType)le.dod),TRIM((SALT38.StrType)le.dob),TRIM((SALT38.StrType)le.masterid),TRIM((SALT38.StrType)le.debtorfirstname),TRIM((SALT38.StrType)le.debtorlastname),TRIM((SALT38.StrType)le.debtoraddress1),TRIM((SALT38.StrType)le.debtoraddress2),TRIM((SALT38.StrType)le.debtoraddresscity),TRIM((SALT38.StrType)le.debtoraddressstate),TRIM((SALT38.StrType)le.debtoraddresszipcode),TRIM((SALT38.StrType)le.dateofdeath),TRIM((SALT38.StrType)le.dateofbirth),TRIM((SALT38.StrType)le.isprobatelocated),TRIM((SALT38.StrType)le.casenumber),TRIM((SALT38.StrType)le.filingdate),TRIM((SALT38.StrType)le.lastdatetofileclaim),TRIM((SALT38.StrType)le.issubjecttocreditorsclaim),TRIM((SALT38.StrType)le.publicationstartdate),TRIM((SALT38.StrType)le.isestateopen),TRIM((SALT38.StrType)le.executorfirstname),TRIM((SALT38.StrType)le.executorlastname),TRIM((SALT38.StrType)le.executoraddress1),TRIM((SALT38.StrType)le.executoraddress2),TRIM((SALT38.StrType)le.executoraddresscity),TRIM((SALT38.StrType)le.executoraddressstate),TRIM((SALT38.StrType)le.executoraddresszipcode),TRIM((SALT38.StrType)le.executorphone),TRIM((SALT38.StrType)le.attorneyfirstname),TRIM((SALT38.StrType)le.attorneylastname),TRIM((SALT38.StrType)le.firm),TRIM((SALT38.StrType)le.attorneyaddress1),TRIM((SALT38.StrType)le.attorneyaddress2),TRIM((SALT38.StrType)le.attorneyaddresscity),TRIM((SALT38.StrType)le.attorneyaddressstate),TRIM((SALT38.StrType)le.attorneyaddresszipcode),TRIM((SALT38.StrType)le.attorneyphone),TRIM((SALT38.StrType)le.attorneyemail),TRIM((SALT38.StrType)le.documenttypes),TRIM((SALT38.StrType)le.corr_dateofdeath),TRIM((SALT38.StrType)le.pdid),TRIM((SALT38.StrType)le.pfrd_address_ind),IF (le.nid <> 0,TRIM((SALT38.StrType)le.nid), ''),TRIM((SALT38.StrType)le.cln_title),TRIM((SALT38.StrType)le.cln_fname),TRIM((SALT38.StrType)le.cln_mname),TRIM((SALT38.StrType)le.cln_lname),TRIM((SALT38.StrType)le.cln_suffix),TRIM((SALT38.StrType)le.cln_title2),TRIM((SALT38.StrType)le.cln_fname2),TRIM((SALT38.StrType)le.cln_mname2),TRIM((SALT38.StrType)le.cln_lname2),TRIM((SALT38.StrType)le.cln_suffix2),IF (le.persistent_record_id <> 0,TRIM((SALT38.StrType)le.persistent_record_id), ''),TRIM((SALT38.StrType)le.cname),IF (le.cleanaid <> 0,TRIM((SALT38.StrType)le.cleanaid), ''),TRIM((SALT38.StrType)le.addresstype),TRIM((SALT38.StrType)le.prim_range),TRIM((SALT38.StrType)le.predir),TRIM((SALT38.StrType)le.prim_name),TRIM((SALT38.StrType)le.addr_suffix),TRIM((SALT38.StrType)le.postdir),TRIM((SALT38.StrType)le.unit_desig),TRIM((SALT38.StrType)le.sec_range),TRIM((SALT38.StrType)le.p_city_name),TRIM((SALT38.StrType)le.v_city_name),TRIM((SALT38.StrType)le.st),TRIM((SALT38.StrType)le.zip),TRIM((SALT38.StrType)le.zip4),TRIM((SALT38.StrType)le.cart),TRIM((SALT38.StrType)le.cr_sort_sz),TRIM((SALT38.StrType)le.lot),TRIM((SALT38.StrType)le.lot_order),TRIM((SALT38.StrType)le.dbpc),TRIM((SALT38.StrType)le.chk_digit),TRIM((SALT38.StrType)le.rec_type),TRIM((SALT38.StrType)le.fips_county),TRIM((SALT38.StrType)le.geo_lat),TRIM((SALT38.StrType)le.geo_long),TRIM((SALT38.StrType)le.msa),TRIM((SALT38.StrType)le.geo_blk),TRIM((SALT38.StrType)le.geo_match),TRIM((SALT38.StrType)le.err_stat),IF (le.rawaid <> 0,TRIM((SALT38.StrType)le.rawaid), '')));
  SELF.FldNo := C;
END;
SHARED FldInv0 := NORMALIZE(h,85,Into(LEFT,COUNTER));
// Move everything into 'pairs' form so processing can be done 'in library'
SALT38.MAC_Correlate.Data_Layout IntoP(h le,UNSIGNED C) := TRANSFORM
  SELF.FldNo1 := 1 + (C / 85);
  SELF.FldNo2 := 1 + (C % 85);
  SELF.Fld1 := TRIM(CHOOSE(SELF.FldNo1,TRIM((SALT38.StrType)le.name_score),TRIM((SALT38.StrType)le.filedate),TRIM((SALT38.StrType)le.dod),TRIM((SALT38.StrType)le.dob),TRIM((SALT38.StrType)le.masterid),TRIM((SALT38.StrType)le.debtorfirstname),TRIM((SALT38.StrType)le.debtorlastname),TRIM((SALT38.StrType)le.debtoraddress1),TRIM((SALT38.StrType)le.debtoraddress2),TRIM((SALT38.StrType)le.debtoraddresscity),TRIM((SALT38.StrType)le.debtoraddressstate),TRIM((SALT38.StrType)le.debtoraddresszipcode),TRIM((SALT38.StrType)le.dateofdeath),TRIM((SALT38.StrType)le.dateofbirth),TRIM((SALT38.StrType)le.isprobatelocated),TRIM((SALT38.StrType)le.casenumber),TRIM((SALT38.StrType)le.filingdate),TRIM((SALT38.StrType)le.lastdatetofileclaim),TRIM((SALT38.StrType)le.issubjecttocreditorsclaim),TRIM((SALT38.StrType)le.publicationstartdate),TRIM((SALT38.StrType)le.isestateopen),TRIM((SALT38.StrType)le.executorfirstname),TRIM((SALT38.StrType)le.executorlastname),TRIM((SALT38.StrType)le.executoraddress1),TRIM((SALT38.StrType)le.executoraddress2),TRIM((SALT38.StrType)le.executoraddresscity),TRIM((SALT38.StrType)le.executoraddressstate),TRIM((SALT38.StrType)le.executoraddresszipcode),TRIM((SALT38.StrType)le.executorphone),TRIM((SALT38.StrType)le.attorneyfirstname),TRIM((SALT38.StrType)le.attorneylastname),TRIM((SALT38.StrType)le.firm),TRIM((SALT38.StrType)le.attorneyaddress1),TRIM((SALT38.StrType)le.attorneyaddress2),TRIM((SALT38.StrType)le.attorneyaddresscity),TRIM((SALT38.StrType)le.attorneyaddressstate),TRIM((SALT38.StrType)le.attorneyaddresszipcode),TRIM((SALT38.StrType)le.attorneyphone),TRIM((SALT38.StrType)le.attorneyemail),TRIM((SALT38.StrType)le.documenttypes),TRIM((SALT38.StrType)le.corr_dateofdeath),TRIM((SALT38.StrType)le.pdid),TRIM((SALT38.StrType)le.pfrd_address_ind),IF (le.nid <> 0,TRIM((SALT38.StrType)le.nid), ''),TRIM((SALT38.StrType)le.cln_title),TRIM((SALT38.StrType)le.cln_fname),TRIM((SALT38.StrType)le.cln_mname),TRIM((SALT38.StrType)le.cln_lname),TRIM((SALT38.StrType)le.cln_suffix),TRIM((SALT38.StrType)le.cln_title2),TRIM((SALT38.StrType)le.cln_fname2),TRIM((SALT38.StrType)le.cln_mname2),TRIM((SALT38.StrType)le.cln_lname2),TRIM((SALT38.StrType)le.cln_suffix2),IF (le.persistent_record_id <> 0,TRIM((SALT38.StrType)le.persistent_record_id), ''),TRIM((SALT38.StrType)le.cname),IF (le.cleanaid <> 0,TRIM((SALT38.StrType)le.cleanaid), ''),TRIM((SALT38.StrType)le.addresstype),TRIM((SALT38.StrType)le.prim_range),TRIM((SALT38.StrType)le.predir),TRIM((SALT38.StrType)le.prim_name),TRIM((SALT38.StrType)le.addr_suffix),TRIM((SALT38.StrType)le.postdir),TRIM((SALT38.StrType)le.unit_desig),TRIM((SALT38.StrType)le.sec_range),TRIM((SALT38.StrType)le.p_city_name),TRIM((SALT38.StrType)le.v_city_name),TRIM((SALT38.StrType)le.st),TRIM((SALT38.StrType)le.zip),TRIM((SALT38.StrType)le.zip4),TRIM((SALT38.StrType)le.cart),TRIM((SALT38.StrType)le.cr_sort_sz),TRIM((SALT38.StrType)le.lot),TRIM((SALT38.StrType)le.lot_order),TRIM((SALT38.StrType)le.dbpc),TRIM((SALT38.StrType)le.chk_digit),TRIM((SALT38.StrType)le.rec_type),TRIM((SALT38.StrType)le.fips_county),TRIM((SALT38.StrType)le.geo_lat),TRIM((SALT38.StrType)le.geo_long),TRIM((SALT38.StrType)le.msa),TRIM((SALT38.StrType)le.geo_blk),TRIM((SALT38.StrType)le.geo_match),TRIM((SALT38.StrType)le.err_stat),IF (le.rawaid <> 0,TRIM((SALT38.StrType)le.rawaid), '')));
  SELF.Fld2 := TRIM(CHOOSE(SELF.FldNo2,TRIM((SALT38.StrType)le.name_score),TRIM((SALT38.StrType)le.filedate),TRIM((SALT38.StrType)le.dod),TRIM((SALT38.StrType)le.dob),TRIM((SALT38.StrType)le.masterid),TRIM((SALT38.StrType)le.debtorfirstname),TRIM((SALT38.StrType)le.debtorlastname),TRIM((SALT38.StrType)le.debtoraddress1),TRIM((SALT38.StrType)le.debtoraddress2),TRIM((SALT38.StrType)le.debtoraddresscity),TRIM((SALT38.StrType)le.debtoraddressstate),TRIM((SALT38.StrType)le.debtoraddresszipcode),TRIM((SALT38.StrType)le.dateofdeath),TRIM((SALT38.StrType)le.dateofbirth),TRIM((SALT38.StrType)le.isprobatelocated),TRIM((SALT38.StrType)le.casenumber),TRIM((SALT38.StrType)le.filingdate),TRIM((SALT38.StrType)le.lastdatetofileclaim),TRIM((SALT38.StrType)le.issubjecttocreditorsclaim),TRIM((SALT38.StrType)le.publicationstartdate),TRIM((SALT38.StrType)le.isestateopen),TRIM((SALT38.StrType)le.executorfirstname),TRIM((SALT38.StrType)le.executorlastname),TRIM((SALT38.StrType)le.executoraddress1),TRIM((SALT38.StrType)le.executoraddress2),TRIM((SALT38.StrType)le.executoraddresscity),TRIM((SALT38.StrType)le.executoraddressstate),TRIM((SALT38.StrType)le.executoraddresszipcode),TRIM((SALT38.StrType)le.executorphone),TRIM((SALT38.StrType)le.attorneyfirstname),TRIM((SALT38.StrType)le.attorneylastname),TRIM((SALT38.StrType)le.firm),TRIM((SALT38.StrType)le.attorneyaddress1),TRIM((SALT38.StrType)le.attorneyaddress2),TRIM((SALT38.StrType)le.attorneyaddresscity),TRIM((SALT38.StrType)le.attorneyaddressstate),TRIM((SALT38.StrType)le.attorneyaddresszipcode),TRIM((SALT38.StrType)le.attorneyphone),TRIM((SALT38.StrType)le.attorneyemail),TRIM((SALT38.StrType)le.documenttypes),TRIM((SALT38.StrType)le.corr_dateofdeath),TRIM((SALT38.StrType)le.pdid),TRIM((SALT38.StrType)le.pfrd_address_ind),IF (le.nid <> 0,TRIM((SALT38.StrType)le.nid), ''),TRIM((SALT38.StrType)le.cln_title),TRIM((SALT38.StrType)le.cln_fname),TRIM((SALT38.StrType)le.cln_mname),TRIM((SALT38.StrType)le.cln_lname),TRIM((SALT38.StrType)le.cln_suffix),TRIM((SALT38.StrType)le.cln_title2),TRIM((SALT38.StrType)le.cln_fname2),TRIM((SALT38.StrType)le.cln_mname2),TRIM((SALT38.StrType)le.cln_lname2),TRIM((SALT38.StrType)le.cln_suffix2),IF (le.persistent_record_id <> 0,TRIM((SALT38.StrType)le.persistent_record_id), ''),TRIM((SALT38.StrType)le.cname),IF (le.cleanaid <> 0,TRIM((SALT38.StrType)le.cleanaid), ''),TRIM((SALT38.StrType)le.addresstype),TRIM((SALT38.StrType)le.prim_range),TRIM((SALT38.StrType)le.predir),TRIM((SALT38.StrType)le.prim_name),TRIM((SALT38.StrType)le.addr_suffix),TRIM((SALT38.StrType)le.postdir),TRIM((SALT38.StrType)le.unit_desig),TRIM((SALT38.StrType)le.sec_range),TRIM((SALT38.StrType)le.p_city_name),TRIM((SALT38.StrType)le.v_city_name),TRIM((SALT38.StrType)le.st),TRIM((SALT38.StrType)le.zip),TRIM((SALT38.StrType)le.zip4),TRIM((SALT38.StrType)le.cart),TRIM((SALT38.StrType)le.cr_sort_sz),TRIM((SALT38.StrType)le.lot),TRIM((SALT38.StrType)le.lot_order),TRIM((SALT38.StrType)le.dbpc),TRIM((SALT38.StrType)le.chk_digit),TRIM((SALT38.StrType)le.rec_type),TRIM((SALT38.StrType)le.fips_county),TRIM((SALT38.StrType)le.geo_lat),TRIM((SALT38.StrType)le.geo_long),TRIM((SALT38.StrType)le.msa),TRIM((SALT38.StrType)le.geo_blk),TRIM((SALT38.StrType)le.geo_match),TRIM((SALT38.StrType)le.err_stat),IF (le.rawaid <> 0,TRIM((SALT38.StrType)le.rawaid), '')));
  END;
SHARED Pairs0 := NORMALIZE(ENTH(h,Config.CorrelateSampleSize),85*85,IntoP(LEFT,COUNTER))(FldNo1<FldNo2);
SHARED FldIds := DATASET([{1,'name_score'}
      ,{2,'filedate'}
      ,{3,'dod'}
      ,{4,'dob'}
      ,{5,'masterid'}
      ,{6,'debtorfirstname'}
      ,{7,'debtorlastname'}
      ,{8,'debtoraddress1'}
      ,{9,'debtoraddress2'}
      ,{10,'debtoraddresscity'}
      ,{11,'debtoraddressstate'}
      ,{12,'debtoraddresszipcode'}
      ,{13,'dateofdeath'}
      ,{14,'dateofbirth'}
      ,{15,'isprobatelocated'}
      ,{16,'casenumber'}
      ,{17,'filingdate'}
      ,{18,'lastdatetofileclaim'}
      ,{19,'issubjecttocreditorsclaim'}
      ,{20,'publicationstartdate'}
      ,{21,'isestateopen'}
      ,{22,'executorfirstname'}
      ,{23,'executorlastname'}
      ,{24,'executoraddress1'}
      ,{25,'executoraddress2'}
      ,{26,'executoraddresscity'}
      ,{27,'executoraddressstate'}
      ,{28,'executoraddresszipcode'}
      ,{29,'executorphone'}
      ,{30,'attorneyfirstname'}
      ,{31,'attorneylastname'}
      ,{32,'firm'}
      ,{33,'attorneyaddress1'}
      ,{34,'attorneyaddress2'}
      ,{35,'attorneyaddresscity'}
      ,{36,'attorneyaddressstate'}
      ,{37,'attorneyaddresszipcode'}
      ,{38,'attorneyphone'}
      ,{39,'attorneyemail'}
      ,{40,'documenttypes'}
      ,{41,'corr_dateofdeath'}
      ,{42,'pdid'}
      ,{43,'pfrd_address_ind'}
      ,{44,'nid'}
      ,{45,'cln_title'}
      ,{46,'cln_fname'}
      ,{47,'cln_mname'}
      ,{48,'cln_lname'}
      ,{49,'cln_suffix'}
      ,{50,'cln_title2'}
      ,{51,'cln_fname2'}
      ,{52,'cln_mname2'}
      ,{53,'cln_lname2'}
      ,{54,'cln_suffix2'}
      ,{55,'persistent_record_id'}
      ,{56,'cname'}
      ,{57,'cleanaid'}
      ,{58,'addresstype'}
      ,{59,'prim_range'}
      ,{60,'predir'}
      ,{61,'prim_name'}
      ,{62,'addr_suffix'}
      ,{63,'postdir'}
      ,{64,'unit_desig'}
      ,{65,'sec_range'}
      ,{66,'p_city_name'}
      ,{67,'v_city_name'}
      ,{68,'st'}
      ,{69,'zip'}
      ,{70,'zip4'}
      ,{71,'cart'}
      ,{72,'cr_sort_sz'}
      ,{73,'lot'}
      ,{74,'lot_order'}
      ,{75,'dbpc'}
      ,{76,'chk_digit'}
      ,{77,'rec_type'}
      ,{78,'fips_county'}
      ,{79,'geo_lat'}
      ,{80,'geo_long'}
      ,{81,'msa'}
      ,{82,'geo_blk'}
      ,{83,'geo_match'}
      ,{84,'err_stat'}
      ,{85,'rawaid'}],SALT38.MAC_Character_Counts.Field_Identification);
EXPORT AllProfiles := SALT38.MAC_Character_Counts.FN_Profile(FldInv0,FldIds);

EXPORT SrcProfiles := SALT38.MAC_Character_Counts.Src_Profile(FldInv0,FldIds);

EXPORT Correlations := SALT38.MAC_Correlate.Fn_Profile(Pairs0,FldIds);


ErrorRecord := RECORD
  UNSIGNED1 FieldNum;
  UNSIGNED1 ErrorNum;
END;
ErrorRecord NoteErrors(h le,UNSIGNED1 c) := TRANSFORM
  SELF.ErrorNum := CHOOSE(c,
    Fields.InValid_name_score((SALT38.StrType)le.name_score),
    Fields.InValid_filedate((SALT38.StrType)le.filedate),
    Fields.InValid_dod((SALT38.StrType)le.dod),
    Fields.InValid_dob((SALT38.StrType)le.dob),
    Fields.InValid_masterid((SALT38.StrType)le.masterid),
    Fields.InValid_debtorfirstname((SALT38.StrType)le.debtorfirstname),
    Fields.InValid_debtorlastname((SALT38.StrType)le.debtorlastname),
    Fields.InValid_debtoraddress1((SALT38.StrType)le.debtoraddress1),
    Fields.InValid_debtoraddress2((SALT38.StrType)le.debtoraddress2),
    Fields.InValid_debtoraddresscity((SALT38.StrType)le.debtoraddresscity),
    Fields.InValid_debtoraddressstate((SALT38.StrType)le.debtoraddressstate),
    Fields.InValid_debtoraddresszipcode((SALT38.StrType)le.debtoraddresszipcode),
    Fields.InValid_dateofdeath((SALT38.StrType)le.dateofdeath),
    Fields.InValid_dateofbirth((SALT38.StrType)le.dateofbirth),
    Fields.InValid_isprobatelocated((SALT38.StrType)le.isprobatelocated),
    Fields.InValid_casenumber((SALT38.StrType)le.casenumber),
    Fields.InValid_filingdate((SALT38.StrType)le.filingdate),
    Fields.InValid_lastdatetofileclaim((SALT38.StrType)le.lastdatetofileclaim),
    Fields.InValid_issubjecttocreditorsclaim((SALT38.StrType)le.issubjecttocreditorsclaim),
    Fields.InValid_publicationstartdate((SALT38.StrType)le.publicationstartdate),
    Fields.InValid_isestateopen((SALT38.StrType)le.isestateopen),
    Fields.InValid_executorfirstname((SALT38.StrType)le.executorfirstname),
    Fields.InValid_executorlastname((SALT38.StrType)le.executorlastname),
    Fields.InValid_executoraddress1((SALT38.StrType)le.executoraddress1),
    Fields.InValid_executoraddress2((SALT38.StrType)le.executoraddress2),
    Fields.InValid_executoraddresscity((SALT38.StrType)le.executoraddresscity),
    Fields.InValid_executoraddressstate((SALT38.StrType)le.executoraddressstate),
    Fields.InValid_executoraddresszipcode((SALT38.StrType)le.executoraddresszipcode),
    Fields.InValid_executorphone((SALT38.StrType)le.executorphone),
    Fields.InValid_attorneyfirstname((SALT38.StrType)le.attorneyfirstname),
    Fields.InValid_attorneylastname((SALT38.StrType)le.attorneylastname),
    Fields.InValid_firm((SALT38.StrType)le.firm),
    Fields.InValid_attorneyaddress1((SALT38.StrType)le.attorneyaddress1),
    Fields.InValid_attorneyaddress2((SALT38.StrType)le.attorneyaddress2),
    Fields.InValid_attorneyaddresscity((SALT38.StrType)le.attorneyaddresscity),
    Fields.InValid_attorneyaddressstate((SALT38.StrType)le.attorneyaddressstate),
    Fields.InValid_attorneyaddresszipcode((SALT38.StrType)le.attorneyaddresszipcode),
    Fields.InValid_attorneyphone((SALT38.StrType)le.attorneyphone),
    Fields.InValid_attorneyemail((SALT38.StrType)le.attorneyemail),
    Fields.InValid_documenttypes((SALT38.StrType)le.documenttypes),
    Fields.InValid_corr_dateofdeath((SALT38.StrType)le.corr_dateofdeath),
    Fields.InValid_pdid((SALT38.StrType)le.pdid),
    Fields.InValid_pfrd_address_ind((SALT38.StrType)le.pfrd_address_ind),
    Fields.InValid_nid((SALT38.StrType)le.nid),
    Fields.InValid_cln_title((SALT38.StrType)le.cln_title),
    Fields.InValid_cln_fname((SALT38.StrType)le.cln_fname),
    Fields.InValid_cln_mname((SALT38.StrType)le.cln_mname),
    Fields.InValid_cln_lname((SALT38.StrType)le.cln_lname),
    Fields.InValid_cln_suffix((SALT38.StrType)le.cln_suffix),
    Fields.InValid_cln_title2((SALT38.StrType)le.cln_title2),
    Fields.InValid_cln_fname2((SALT38.StrType)le.cln_fname2),
    Fields.InValid_cln_mname2((SALT38.StrType)le.cln_mname2),
    Fields.InValid_cln_lname2((SALT38.StrType)le.cln_lname2),
    Fields.InValid_cln_suffix2((SALT38.StrType)le.cln_suffix2),
    Fields.InValid_persistent_record_id((SALT38.StrType)le.persistent_record_id),
    Fields.InValid_cname((SALT38.StrType)le.cname),
    Fields.InValid_cleanaid((SALT38.StrType)le.cleanaid),
    Fields.InValid_addresstype((SALT38.StrType)le.addresstype),
    Fields.InValid_prim_range((SALT38.StrType)le.prim_range),
    Fields.InValid_predir((SALT38.StrType)le.predir),
    Fields.InValid_prim_name((SALT38.StrType)le.prim_name),
    Fields.InValid_addr_suffix((SALT38.StrType)le.addr_suffix),
    Fields.InValid_postdir((SALT38.StrType)le.postdir),
    Fields.InValid_unit_desig((SALT38.StrType)le.unit_desig),
    Fields.InValid_sec_range((SALT38.StrType)le.sec_range),
    Fields.InValid_p_city_name((SALT38.StrType)le.p_city_name),
    Fields.InValid_v_city_name((SALT38.StrType)le.v_city_name),
    Fields.InValid_st((SALT38.StrType)le.st),
    Fields.InValid_zip((SALT38.StrType)le.zip),
    Fields.InValid_zip4((SALT38.StrType)le.zip4),
    Fields.InValid_cart((SALT38.StrType)le.cart),
    Fields.InValid_cr_sort_sz((SALT38.StrType)le.cr_sort_sz),
    Fields.InValid_lot((SALT38.StrType)le.lot),
    Fields.InValid_lot_order((SALT38.StrType)le.lot_order),
    Fields.InValid_dbpc((SALT38.StrType)le.dbpc),
    Fields.InValid_chk_digit((SALT38.StrType)le.chk_digit),
    Fields.InValid_rec_type((SALT38.StrType)le.rec_type),
    Fields.InValid_fips_county((SALT38.StrType)le.fips_county),
    Fields.InValid_geo_lat((SALT38.StrType)le.geo_lat),
    Fields.InValid_geo_long((SALT38.StrType)le.geo_long),
    Fields.InValid_msa((SALT38.StrType)le.msa),
    Fields.InValid_geo_blk((SALT38.StrType)le.geo_blk),
    Fields.InValid_geo_match((SALT38.StrType)le.geo_match),
    Fields.InValid_err_stat((SALT38.StrType)le.err_stat),
    Fields.InValid_rawaid((SALT38.StrType)le.rawaid),
    0);
  SELF.FieldNum := IF(SELF.ErrorNum=0,SKIP,c); // Bail early to avoid creating record
END;
Errors := NORMALIZE(h,85,NoteErrors(LEFT,COUNTER));
ErrorRecordsTotals := RECORD
  Errors.FieldNum;
  Errors.ErrorNum;
  UNSIGNED Cnt := COUNT(GROUP);
END;
TotalErrors := TABLE(Errors,ErrorRecordsTotals,FieldNum,ErrorNum,FEW);
PrettyErrorTotals := RECORD
  FieldNme := Fields.FieldName(TotalErrors.FieldNum);
  FieldType := CHOOSE(TotalErrors.FieldNum,'invalid_Num','invalid_date','invalid_date','invalid_date','alphasandnums','invalid_name','invalid_name','invalid_address','invalid_address','invalid_city','invalid_state','invalid_zip','invalid_date','invalid_date','Unknown','invalid_casenumber','invalid_date','invalid_date','Unknown','invalid_date','Unknown','invalid_name','invalid_name','invalid_address','invalid_address','invalid_city','invalid_state','invalid_zip','invalid_phone','invalid_name','invalid_name','Unknown','invalid_address','invalid_address','invalid_city','invalid_state','invalid_zip','invalid_phone','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','invalid_name','invalid_name','invalid_name','invalid_name','Unknown','invalid_name','invalid_name','invalid_name','invalid_name','Unknown','invalid_company','Unknown','Unknown','Unknown','predir','prim_name','addr_suffix','postdir','unit_desig','sec_range','p_city_name','v_city_name','st','zip','zip4','cart','cr_sort_sz','lot','lot_order','dbpc','chk_digit','rec_type','fips_county','geo_lat','geo_long','msa','geo_blk','geo_match','err_stat','rawaid');
  ErrorMessage := CHOOSE(TotalErrors.FieldNum,Fields.InValidMessage_name_score(TotalErrors.ErrorNum),Fields.InValidMessage_filedate(TotalErrors.ErrorNum),Fields.InValidMessage_dod(TotalErrors.ErrorNum),Fields.InValidMessage_dob(TotalErrors.ErrorNum),Fields.InValidMessage_masterid(TotalErrors.ErrorNum),Fields.InValidMessage_debtorfirstname(TotalErrors.ErrorNum),Fields.InValidMessage_debtorlastname(TotalErrors.ErrorNum),Fields.InValidMessage_debtoraddress1(TotalErrors.ErrorNum),Fields.InValidMessage_debtoraddress2(TotalErrors.ErrorNum),Fields.InValidMessage_debtoraddresscity(TotalErrors.ErrorNum),Fields.InValidMessage_debtoraddressstate(TotalErrors.ErrorNum),Fields.InValidMessage_debtoraddresszipcode(TotalErrors.ErrorNum),Fields.InValidMessage_dateofdeath(TotalErrors.ErrorNum),Fields.InValidMessage_dateofbirth(TotalErrors.ErrorNum),Fields.InValidMessage_isprobatelocated(TotalErrors.ErrorNum),Fields.InValidMessage_casenumber(TotalErrors.ErrorNum),Fields.InValidMessage_filingdate(TotalErrors.ErrorNum),Fields.InValidMessage_lastdatetofileclaim(TotalErrors.ErrorNum),Fields.InValidMessage_issubjecttocreditorsclaim(TotalErrors.ErrorNum),Fields.InValidMessage_publicationstartdate(TotalErrors.ErrorNum),Fields.InValidMessage_isestateopen(TotalErrors.ErrorNum),Fields.InValidMessage_executorfirstname(TotalErrors.ErrorNum),Fields.InValidMessage_executorlastname(TotalErrors.ErrorNum),Fields.InValidMessage_executoraddress1(TotalErrors.ErrorNum),Fields.InValidMessage_executoraddress2(TotalErrors.ErrorNum),Fields.InValidMessage_executoraddresscity(TotalErrors.ErrorNum),Fields.InValidMessage_executoraddressstate(TotalErrors.ErrorNum),Fields.InValidMessage_executoraddresszipcode(TotalErrors.ErrorNum),Fields.InValidMessage_executorphone(TotalErrors.ErrorNum),Fields.InValidMessage_attorneyfirstname(TotalErrors.ErrorNum),Fields.InValidMessage_attorneylastname(TotalErrors.ErrorNum),Fields.InValidMessage_firm(TotalErrors.ErrorNum),Fields.InValidMessage_attorneyaddress1(TotalErrors.ErrorNum),Fields.InValidMessage_attorneyaddress2(TotalErrors.ErrorNum),Fields.InValidMessage_attorneyaddresscity(TotalErrors.ErrorNum),Fields.InValidMessage_attorneyaddressstate(TotalErrors.ErrorNum),Fields.InValidMessage_attorneyaddresszipcode(TotalErrors.ErrorNum),Fields.InValidMessage_attorneyphone(TotalErrors.ErrorNum),Fields.InValidMessage_attorneyemail(TotalErrors.ErrorNum),Fields.InValidMessage_documenttypes(TotalErrors.ErrorNum),Fields.InValidMessage_corr_dateofdeath(TotalErrors.ErrorNum),Fields.InValidMessage_pdid(TotalErrors.ErrorNum),Fields.InValidMessage_pfrd_address_ind(TotalErrors.ErrorNum),Fields.InValidMessage_nid(TotalErrors.ErrorNum),Fields.InValidMessage_cln_title(TotalErrors.ErrorNum),Fields.InValidMessage_cln_fname(TotalErrors.ErrorNum),Fields.InValidMessage_cln_mname(TotalErrors.ErrorNum),Fields.InValidMessage_cln_lname(TotalErrors.ErrorNum),Fields.InValidMessage_cln_suffix(TotalErrors.ErrorNum),Fields.InValidMessage_cln_title2(TotalErrors.ErrorNum),Fields.InValidMessage_cln_fname2(TotalErrors.ErrorNum),Fields.InValidMessage_cln_mname2(TotalErrors.ErrorNum),Fields.InValidMessage_cln_lname2(TotalErrors.ErrorNum),Fields.InValidMessage_cln_suffix2(TotalErrors.ErrorNum),Fields.InValidMessage_persistent_record_id(TotalErrors.ErrorNum),Fields.InValidMessage_cname(TotalErrors.ErrorNum),Fields.InValidMessage_cleanaid(TotalErrors.ErrorNum),Fields.InValidMessage_addresstype(TotalErrors.ErrorNum),Fields.InValidMessage_prim_range(TotalErrors.ErrorNum),Fields.InValidMessage_predir(TotalErrors.ErrorNum),Fields.InValidMessage_prim_name(TotalErrors.ErrorNum),Fields.InValidMessage_addr_suffix(TotalErrors.ErrorNum),Fields.InValidMessage_postdir(TotalErrors.ErrorNum),Fields.InValidMessage_unit_desig(TotalErrors.ErrorNum),Fields.InValidMessage_sec_range(TotalErrors.ErrorNum),Fields.InValidMessage_p_city_name(TotalErrors.ErrorNum),Fields.InValidMessage_v_city_name(TotalErrors.ErrorNum),Fields.InValidMessage_st(TotalErrors.ErrorNum),Fields.InValidMessage_zip(TotalErrors.ErrorNum),Fields.InValidMessage_zip4(TotalErrors.ErrorNum),Fields.InValidMessage_cart(TotalErrors.ErrorNum),Fields.InValidMessage_cr_sort_sz(TotalErrors.ErrorNum),Fields.InValidMessage_lot(TotalErrors.ErrorNum),Fields.InValidMessage_lot_order(TotalErrors.ErrorNum),Fields.InValidMessage_dbpc(TotalErrors.ErrorNum),Fields.InValidMessage_chk_digit(TotalErrors.ErrorNum),Fields.InValidMessage_rec_type(TotalErrors.ErrorNum),Fields.InValidMessage_fips_county(TotalErrors.ErrorNum),Fields.InValidMessage_geo_lat(TotalErrors.ErrorNum),Fields.InValidMessage_geo_long(TotalErrors.ErrorNum),Fields.InValidMessage_msa(TotalErrors.ErrorNum),Fields.InValidMessage_geo_blk(TotalErrors.ErrorNum),Fields.InValidMessage_geo_match(TotalErrors.ErrorNum),Fields.InValidMessage_err_stat(TotalErrors.ErrorNum),Fields.InValidMessage_rawaid(TotalErrors.ErrorNum));
  TotalErrors.Cnt;
END;
ValErr := TABLE(TotalErrors,PrettyErrorTotals);
EXPORT ValidityErrors := ValErr;
EXPORT StandardStats(BOOLEAN doSummaryGlobal = TRUE, BOOLEAN doAllProfiles = TRUE) := FUNCTION
  myTimeStamp := (UNSIGNED6)SALT38.Fn_Now('YYYYMMDDHHMMSS') : INDEPENDENT;
  fieldPopulationOverall := Summary('');

  SALT38.mod_StandardStatsTransforms.mac_hygieneSummaryTransform(Scrubs_OKC_Probate, Fields, 'RECORDOF(fieldPopulationOverall)', FALSE);

  fieldPopulationOverall_Standard := IF(doSummaryGlobal, NORMALIZE(fieldPopulationOverall, COUNT(FldIds) * 6, xSummary(LEFT, COUNTER, myTimeStamp, 'all', 'all')));
  fieldPopulationOverall_TotalRecs_Standard := IF(doSummaryGlobal, SALT38.mod_StandardStatsTransforms.mac_hygieneTotalRecs(fieldPopulationOverall, myTimeStamp, 'all', FALSE, 'all'));
  allProfiles_Standard := IF(doAllProfiles, SALT38.mod_StandardStatsTransforms.hygieneAllProfiles(AllProfiles, myTimeStamp, 10, 'all'));

  RETURN fieldPopulationOverall_Standard & fieldPopulationOverall_TotalRecs_Standard & allProfiles_Standard;
END;
END;
