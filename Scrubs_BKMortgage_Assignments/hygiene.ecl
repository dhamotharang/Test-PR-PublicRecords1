IMPORT SALT311,STD;
EXPORT hygiene(dataset(layout_BKMortgage_Assignments) h) := MODULE
 
//A simple summary record
EXPORT Summary(SALT311.Str30Type  txt) := FUNCTION
  SummaryLayout := RECORD
    txt;
    NumberOfRecords := COUNT(GROUP);
    populated_ln_filedate_cnt := COUNT(GROUP,h.ln_filedate <> (TYPEOF(h.ln_filedate))'');
    populated_ln_filedate_pcnt := AVE(GROUP,IF(h.ln_filedate = (TYPEOF(h.ln_filedate))'',0,100));
    maxlength_ln_filedate := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.ln_filedate)));
    avelength_ln_filedate := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.ln_filedate)),h.ln_filedate<>(typeof(h.ln_filedate))'');
    populated_bk_infile_type_cnt := COUNT(GROUP,h.bk_infile_type <> (TYPEOF(h.bk_infile_type))'');
    populated_bk_infile_type_pcnt := AVE(GROUP,IF(h.bk_infile_type = (TYPEOF(h.bk_infile_type))'',0,100));
    maxlength_bk_infile_type := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.bk_infile_type)));
    avelength_bk_infile_type := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.bk_infile_type)),h.bk_infile_type<>(typeof(h.bk_infile_type))'');
    populated_rectype_cnt := COUNT(GROUP,h.rectype <> (TYPEOF(h.rectype))'');
    populated_rectype_pcnt := AVE(GROUP,IF(h.rectype = (TYPEOF(h.rectype))'',0,100));
    maxlength_rectype := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.rectype)));
    avelength_rectype := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.rectype)),h.rectype<>(typeof(h.rectype))'');
    populated_documenttype_cnt := COUNT(GROUP,h.documenttype <> (TYPEOF(h.documenttype))'');
    populated_documenttype_pcnt := AVE(GROUP,IF(h.documenttype = (TYPEOF(h.documenttype))'',0,100));
    maxlength_documenttype := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.documenttype)));
    avelength_documenttype := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.documenttype)),h.documenttype<>(typeof(h.documenttype))'');
    populated_fipscode_cnt := COUNT(GROUP,h.fipscode <> (TYPEOF(h.fipscode))'');
    populated_fipscode_pcnt := AVE(GROUP,IF(h.fipscode = (TYPEOF(h.fipscode))'',0,100));
    maxlength_fipscode := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.fipscode)));
    avelength_fipscode := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.fipscode)),h.fipscode<>(typeof(h.fipscode))'');
    populated_mersindicator_cnt := COUNT(GROUP,h.mersindicator <> (TYPEOF(h.mersindicator))'');
    populated_mersindicator_pcnt := AVE(GROUP,IF(h.mersindicator = (TYPEOF(h.mersindicator))'',0,100));
    maxlength_mersindicator := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.mersindicator)));
    avelength_mersindicator := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.mersindicator)),h.mersindicator<>(typeof(h.mersindicator))'');
    populated_mainaddendum_cnt := COUNT(GROUP,h.mainaddendum <> (TYPEOF(h.mainaddendum))'');
    populated_mainaddendum_pcnt := AVE(GROUP,IF(h.mainaddendum = (TYPEOF(h.mainaddendum))'',0,100));
    maxlength_mainaddendum := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.mainaddendum)));
    avelength_mainaddendum := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.mainaddendum)),h.mainaddendum<>(typeof(h.mainaddendum))'');
    populated_assigrecdate_cnt := COUNT(GROUP,h.assigrecdate <> (TYPEOF(h.assigrecdate))'');
    populated_assigrecdate_pcnt := AVE(GROUP,IF(h.assigrecdate = (TYPEOF(h.assigrecdate))'',0,100));
    maxlength_assigrecdate := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.assigrecdate)));
    avelength_assigrecdate := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.assigrecdate)),h.assigrecdate<>(typeof(h.assigrecdate))'');
    populated_assigeffecdate_cnt := COUNT(GROUP,h.assigeffecdate <> (TYPEOF(h.assigeffecdate))'');
    populated_assigeffecdate_pcnt := AVE(GROUP,IF(h.assigeffecdate = (TYPEOF(h.assigeffecdate))'',0,100));
    maxlength_assigeffecdate := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.assigeffecdate)));
    avelength_assigeffecdate := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.assigeffecdate)),h.assigeffecdate<>(typeof(h.assigeffecdate))'');
    populated_assigdoc_cnt := COUNT(GROUP,h.assigdoc <> (TYPEOF(h.assigdoc))'');
    populated_assigdoc_pcnt := AVE(GROUP,IF(h.assigdoc = (TYPEOF(h.assigdoc))'',0,100));
    maxlength_assigdoc := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.assigdoc)));
    avelength_assigdoc := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.assigdoc)),h.assigdoc<>(typeof(h.assigdoc))'');
    populated_assigbk_cnt := COUNT(GROUP,h.assigbk <> (TYPEOF(h.assigbk))'');
    populated_assigbk_pcnt := AVE(GROUP,IF(h.assigbk = (TYPEOF(h.assigbk))'',0,100));
    maxlength_assigbk := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.assigbk)));
    avelength_assigbk := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.assigbk)),h.assigbk<>(typeof(h.assigbk))'');
    populated_assigpg_cnt := COUNT(GROUP,h.assigpg <> (TYPEOF(h.assigpg))'');
    populated_assigpg_pcnt := AVE(GROUP,IF(h.assigpg = (TYPEOF(h.assigpg))'',0,100));
    maxlength_assigpg := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.assigpg)));
    avelength_assigpg := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.assigpg)),h.assigpg<>(typeof(h.assigpg))'');
    populated_multiplepageimage_cnt := COUNT(GROUP,h.multiplepageimage <> (TYPEOF(h.multiplepageimage))'');
    populated_multiplepageimage_pcnt := AVE(GROUP,IF(h.multiplepageimage = (TYPEOF(h.multiplepageimage))'',0,100));
    maxlength_multiplepageimage := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.multiplepageimage)));
    avelength_multiplepageimage := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.multiplepageimage)),h.multiplepageimage<>(typeof(h.multiplepageimage))'');
    populated_bkfsimageid_cnt := COUNT(GROUP,h.bkfsimageid <> (TYPEOF(h.bkfsimageid))'');
    populated_bkfsimageid_pcnt := AVE(GROUP,IF(h.bkfsimageid = (TYPEOF(h.bkfsimageid))'',0,100));
    maxlength_bkfsimageid := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.bkfsimageid)));
    avelength_bkfsimageid := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.bkfsimageid)),h.bkfsimageid<>(typeof(h.bkfsimageid))'');
    populated_origdotrecdate_cnt := COUNT(GROUP,h.origdotrecdate <> (TYPEOF(h.origdotrecdate))'');
    populated_origdotrecdate_pcnt := AVE(GROUP,IF(h.origdotrecdate = (TYPEOF(h.origdotrecdate))'',0,100));
    maxlength_origdotrecdate := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.origdotrecdate)));
    avelength_origdotrecdate := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.origdotrecdate)),h.origdotrecdate<>(typeof(h.origdotrecdate))'');
    populated_origdotcontractdate_cnt := COUNT(GROUP,h.origdotcontractdate <> (TYPEOF(h.origdotcontractdate))'');
    populated_origdotcontractdate_pcnt := AVE(GROUP,IF(h.origdotcontractdate = (TYPEOF(h.origdotcontractdate))'',0,100));
    maxlength_origdotcontractdate := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.origdotcontractdate)));
    avelength_origdotcontractdate := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.origdotcontractdate)),h.origdotcontractdate<>(typeof(h.origdotcontractdate))'');
    populated_origdotdoc_cnt := COUNT(GROUP,h.origdotdoc <> (TYPEOF(h.origdotdoc))'');
    populated_origdotdoc_pcnt := AVE(GROUP,IF(h.origdotdoc = (TYPEOF(h.origdotdoc))'',0,100));
    maxlength_origdotdoc := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.origdotdoc)));
    avelength_origdotdoc := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.origdotdoc)),h.origdotdoc<>(typeof(h.origdotdoc))'');
    populated_origdotbk_cnt := COUNT(GROUP,h.origdotbk <> (TYPEOF(h.origdotbk))'');
    populated_origdotbk_pcnt := AVE(GROUP,IF(h.origdotbk = (TYPEOF(h.origdotbk))'',0,100));
    maxlength_origdotbk := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.origdotbk)));
    avelength_origdotbk := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.origdotbk)),h.origdotbk<>(typeof(h.origdotbk))'');
    populated_origdotpg_cnt := COUNT(GROUP,h.origdotpg <> (TYPEOF(h.origdotpg))'');
    populated_origdotpg_pcnt := AVE(GROUP,IF(h.origdotpg = (TYPEOF(h.origdotpg))'',0,100));
    maxlength_origdotpg := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.origdotpg)));
    avelength_origdotpg := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.origdotpg)),h.origdotpg<>(typeof(h.origdotpg))'');
    populated_origlenderben_cnt := COUNT(GROUP,h.origlenderben <> (TYPEOF(h.origlenderben))'');
    populated_origlenderben_pcnt := AVE(GROUP,IF(h.origlenderben = (TYPEOF(h.origlenderben))'',0,100));
    maxlength_origlenderben := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.origlenderben)));
    avelength_origlenderben := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.origlenderben)),h.origlenderben<>(typeof(h.origlenderben))'');
    populated_origloanamnt_cnt := COUNT(GROUP,h.origloanamnt <> (TYPEOF(h.origloanamnt))'');
    populated_origloanamnt_pcnt := AVE(GROUP,IF(h.origloanamnt = (TYPEOF(h.origloanamnt))'',0,100));
    maxlength_origloanamnt := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.origloanamnt)));
    avelength_origloanamnt := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.origloanamnt)),h.origloanamnt<>(typeof(h.origloanamnt))'');
    populated_assignorname_cnt := COUNT(GROUP,h.assignorname <> (TYPEOF(h.assignorname))'');
    populated_assignorname_pcnt := AVE(GROUP,IF(h.assignorname = (TYPEOF(h.assignorname))'',0,100));
    maxlength_assignorname := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.assignorname)));
    avelength_assignorname := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.assignorname)),h.assignorname<>(typeof(h.assignorname))'');
    populated_loannumber_cnt := COUNT(GROUP,h.loannumber <> (TYPEOF(h.loannumber))'');
    populated_loannumber_pcnt := AVE(GROUP,IF(h.loannumber = (TYPEOF(h.loannumber))'',0,100));
    maxlength_loannumber := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.loannumber)));
    avelength_loannumber := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.loannumber)),h.loannumber<>(typeof(h.loannumber))'');
    populated_assignee_cnt := COUNT(GROUP,h.assignee <> (TYPEOF(h.assignee))'');
    populated_assignee_pcnt := AVE(GROUP,IF(h.assignee = (TYPEOF(h.assignee))'',0,100));
    maxlength_assignee := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.assignee)));
    avelength_assignee := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.assignee)),h.assignee<>(typeof(h.assignee))'');
    populated_mers_cnt := COUNT(GROUP,h.mers <> (TYPEOF(h.mers))'');
    populated_mers_pcnt := AVE(GROUP,IF(h.mers = (TYPEOF(h.mers))'',0,100));
    maxlength_mers := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.mers)));
    avelength_mers := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.mers)),h.mers<>(typeof(h.mers))'');
    populated_mersvalidation_cnt := COUNT(GROUP,h.mersvalidation <> (TYPEOF(h.mersvalidation))'');
    populated_mersvalidation_pcnt := AVE(GROUP,IF(h.mersvalidation = (TYPEOF(h.mersvalidation))'',0,100));
    maxlength_mersvalidation := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.mersvalidation)));
    avelength_mersvalidation := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.mersvalidation)),h.mersvalidation<>(typeof(h.mersvalidation))'');
    populated_assigneepool_cnt := COUNT(GROUP,h.assigneepool <> (TYPEOF(h.assigneepool))'');
    populated_assigneepool_pcnt := AVE(GROUP,IF(h.assigneepool = (TYPEOF(h.assigneepool))'',0,100));
    maxlength_assigneepool := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.assigneepool)));
    avelength_assigneepool := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.assigneepool)),h.assigneepool<>(typeof(h.assigneepool))'');
    populated_mspsvcrloan_cnt := COUNT(GROUP,h.mspsvcrloan <> (TYPEOF(h.mspsvcrloan))'');
    populated_mspsvcrloan_pcnt := AVE(GROUP,IF(h.mspsvcrloan = (TYPEOF(h.mspsvcrloan))'',0,100));
    maxlength_mspsvcrloan := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.mspsvcrloan)));
    avelength_mspsvcrloan := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.mspsvcrloan)),h.mspsvcrloan<>(typeof(h.mspsvcrloan))'');
    populated_borrowername_cnt := COUNT(GROUP,h.borrowername <> (TYPEOF(h.borrowername))'');
    populated_borrowername_pcnt := AVE(GROUP,IF(h.borrowername = (TYPEOF(h.borrowername))'',0,100));
    maxlength_borrowername := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.borrowername)));
    avelength_borrowername := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.borrowername)),h.borrowername<>(typeof(h.borrowername))'');
    populated_apn_cnt := COUNT(GROUP,h.apn <> (TYPEOF(h.apn))'');
    populated_apn_pcnt := AVE(GROUP,IF(h.apn = (TYPEOF(h.apn))'',0,100));
    maxlength_apn := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.apn)));
    avelength_apn := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.apn)),h.apn<>(typeof(h.apn))'');
    populated_multiapncode_cnt := COUNT(GROUP,h.multiapncode <> (TYPEOF(h.multiapncode))'');
    populated_multiapncode_pcnt := AVE(GROUP,IF(h.multiapncode = (TYPEOF(h.multiapncode))'',0,100));
    maxlength_multiapncode := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.multiapncode)));
    avelength_multiapncode := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.multiapncode)),h.multiapncode<>(typeof(h.multiapncode))'');
    populated_taxacctid_cnt := COUNT(GROUP,h.taxacctid <> (TYPEOF(h.taxacctid))'');
    populated_taxacctid_pcnt := AVE(GROUP,IF(h.taxacctid = (TYPEOF(h.taxacctid))'',0,100));
    maxlength_taxacctid := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.taxacctid)));
    avelength_taxacctid := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.taxacctid)),h.taxacctid<>(typeof(h.taxacctid))'');
    populated_propertyfulladd_cnt := COUNT(GROUP,h.propertyfulladd <> (TYPEOF(h.propertyfulladd))'');
    populated_propertyfulladd_pcnt := AVE(GROUP,IF(h.propertyfulladd = (TYPEOF(h.propertyfulladd))'',0,100));
    maxlength_propertyfulladd := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.propertyfulladd)));
    avelength_propertyfulladd := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.propertyfulladd)),h.propertyfulladd<>(typeof(h.propertyfulladd))'');
    populated_propertyunit_cnt := COUNT(GROUP,h.propertyunit <> (TYPEOF(h.propertyunit))'');
    populated_propertyunit_pcnt := AVE(GROUP,IF(h.propertyunit = (TYPEOF(h.propertyunit))'',0,100));
    maxlength_propertyunit := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.propertyunit)));
    avelength_propertyunit := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.propertyunit)),h.propertyunit<>(typeof(h.propertyunit))'');
    populated_propertycity_cnt := COUNT(GROUP,h.propertycity <> (TYPEOF(h.propertycity))'');
    populated_propertycity_pcnt := AVE(GROUP,IF(h.propertycity = (TYPEOF(h.propertycity))'',0,100));
    maxlength_propertycity := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.propertycity)));
    avelength_propertycity := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.propertycity)),h.propertycity<>(typeof(h.propertycity))'');
    populated_propertystate_cnt := COUNT(GROUP,h.propertystate <> (TYPEOF(h.propertystate))'');
    populated_propertystate_pcnt := AVE(GROUP,IF(h.propertystate = (TYPEOF(h.propertystate))'',0,100));
    maxlength_propertystate := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.propertystate)));
    avelength_propertystate := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.propertystate)),h.propertystate<>(typeof(h.propertystate))'');
    populated_propertyzip_cnt := COUNT(GROUP,h.propertyzip <> (TYPEOF(h.propertyzip))'');
    populated_propertyzip_pcnt := AVE(GROUP,IF(h.propertyzip = (TYPEOF(h.propertyzip))'',0,100));
    maxlength_propertyzip := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.propertyzip)));
    avelength_propertyzip := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.propertyzip)),h.propertyzip<>(typeof(h.propertyzip))'');
    populated_propertyzip4_cnt := COUNT(GROUP,h.propertyzip4 <> (TYPEOF(h.propertyzip4))'');
    populated_propertyzip4_pcnt := AVE(GROUP,IF(h.propertyzip4 = (TYPEOF(h.propertyzip4))'',0,100));
    maxlength_propertyzip4 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.propertyzip4)));
    avelength_propertyzip4 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.propertyzip4)),h.propertyzip4<>(typeof(h.propertyzip4))'');
    populated_dataentrydate_cnt := COUNT(GROUP,h.dataentrydate <> (TYPEOF(h.dataentrydate))'');
    populated_dataentrydate_pcnt := AVE(GROUP,IF(h.dataentrydate = (TYPEOF(h.dataentrydate))'',0,100));
    maxlength_dataentrydate := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.dataentrydate)));
    avelength_dataentrydate := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.dataentrydate)),h.dataentrydate<>(typeof(h.dataentrydate))'');
    populated_dataentryopercode_cnt := COUNT(GROUP,h.dataentryopercode <> (TYPEOF(h.dataentryopercode))'');
    populated_dataentryopercode_pcnt := AVE(GROUP,IF(h.dataentryopercode = (TYPEOF(h.dataentryopercode))'',0,100));
    maxlength_dataentryopercode := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.dataentryopercode)));
    avelength_dataentryopercode := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.dataentryopercode)),h.dataentryopercode<>(typeof(h.dataentryopercode))'');
    populated_vendorsourcecode_cnt := COUNT(GROUP,h.vendorsourcecode <> (TYPEOF(h.vendorsourcecode))'');
    populated_vendorsourcecode_pcnt := AVE(GROUP,IF(h.vendorsourcecode = (TYPEOF(h.vendorsourcecode))'',0,100));
    maxlength_vendorsourcecode := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.vendorsourcecode)));
    avelength_vendorsourcecode := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.vendorsourcecode)),h.vendorsourcecode<>(typeof(h.vendorsourcecode))'');
    populated_hids_recordingflag_cnt := COUNT(GROUP,h.hids_recordingflag <> (TYPEOF(h.hids_recordingflag))'');
    populated_hids_recordingflag_pcnt := AVE(GROUP,IF(h.hids_recordingflag = (TYPEOF(h.hids_recordingflag))'',0,100));
    maxlength_hids_recordingflag := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.hids_recordingflag)));
    avelength_hids_recordingflag := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.hids_recordingflag)),h.hids_recordingflag<>(typeof(h.hids_recordingflag))'');
    populated_hids_docnumber_cnt := COUNT(GROUP,h.hids_docnumber <> (TYPEOF(h.hids_docnumber))'');
    populated_hids_docnumber_pcnt := AVE(GROUP,IF(h.hids_docnumber = (TYPEOF(h.hids_docnumber))'',0,100));
    maxlength_hids_docnumber := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.hids_docnumber)));
    avelength_hids_docnumber := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.hids_docnumber)),h.hids_docnumber<>(typeof(h.hids_docnumber))'');
    populated_transfercertificateoftitle_cnt := COUNT(GROUP,h.transfercertificateoftitle <> (TYPEOF(h.transfercertificateoftitle))'');
    populated_transfercertificateoftitle_pcnt := AVE(GROUP,IF(h.transfercertificateoftitle = (TYPEOF(h.transfercertificateoftitle))'',0,100));
    maxlength_transfercertificateoftitle := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.transfercertificateoftitle)));
    avelength_transfercertificateoftitle := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.transfercertificateoftitle)),h.transfercertificateoftitle<>(typeof(h.transfercertificateoftitle))'');
    populated_hi_condo_cpr_hpr_cnt := COUNT(GROUP,h.hi_condo_cpr_hpr <> (TYPEOF(h.hi_condo_cpr_hpr))'');
    populated_hi_condo_cpr_hpr_pcnt := AVE(GROUP,IF(h.hi_condo_cpr_hpr = (TYPEOF(h.hi_condo_cpr_hpr))'',0,100));
    maxlength_hi_condo_cpr_hpr := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.hi_condo_cpr_hpr)));
    avelength_hi_condo_cpr_hpr := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.hi_condo_cpr_hpr)),h.hi_condo_cpr_hpr<>(typeof(h.hi_condo_cpr_hpr))'');
    populated_hi_situs_unit_number_cnt := COUNT(GROUP,h.hi_situs_unit_number <> (TYPEOF(h.hi_situs_unit_number))'');
    populated_hi_situs_unit_number_pcnt := AVE(GROUP,IF(h.hi_situs_unit_number = (TYPEOF(h.hi_situs_unit_number))'',0,100));
    maxlength_hi_situs_unit_number := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.hi_situs_unit_number)));
    avelength_hi_situs_unit_number := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.hi_situs_unit_number)),h.hi_situs_unit_number<>(typeof(h.hi_situs_unit_number))'');
    populated_hids_previous_docnumber_cnt := COUNT(GROUP,h.hids_previous_docnumber <> (TYPEOF(h.hids_previous_docnumber))'');
    populated_hids_previous_docnumber_pcnt := AVE(GROUP,IF(h.hids_previous_docnumber = (TYPEOF(h.hids_previous_docnumber))'',0,100));
    maxlength_hids_previous_docnumber := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.hids_previous_docnumber)));
    avelength_hids_previous_docnumber := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.hids_previous_docnumber)),h.hids_previous_docnumber<>(typeof(h.hids_previous_docnumber))'');
    populated_prevtransfercertificateoftitle_cnt := COUNT(GROUP,h.prevtransfercertificateoftitle <> (TYPEOF(h.prevtransfercertificateoftitle))'');
    populated_prevtransfercertificateoftitle_pcnt := AVE(GROUP,IF(h.prevtransfercertificateoftitle = (TYPEOF(h.prevtransfercertificateoftitle))'',0,100));
    maxlength_prevtransfercertificateoftitle := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.prevtransfercertificateoftitle)));
    avelength_prevtransfercertificateoftitle := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.prevtransfercertificateoftitle)),h.prevtransfercertificateoftitle<>(typeof(h.prevtransfercertificateoftitle))'');
    populated_pid_cnt := COUNT(GROUP,h.pid <> (TYPEOF(h.pid))'');
    populated_pid_pcnt := AVE(GROUP,IF(h.pid = (TYPEOF(h.pid))'',0,100));
    maxlength_pid := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.pid)));
    avelength_pid := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.pid)),h.pid<>(typeof(h.pid))'');
    populated_matchedororphan_cnt := COUNT(GROUP,h.matchedororphan <> (TYPEOF(h.matchedororphan))'');
    populated_matchedororphan_pcnt := AVE(GROUP,IF(h.matchedororphan = (TYPEOF(h.matchedororphan))'',0,100));
    maxlength_matchedororphan := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.matchedororphan)));
    avelength_matchedororphan := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.matchedororphan)),h.matchedororphan<>(typeof(h.matchedororphan))'');
    populated_deed_pid_cnt := COUNT(GROUP,h.deed_pid <> (TYPEOF(h.deed_pid))'');
    populated_deed_pid_pcnt := AVE(GROUP,IF(h.deed_pid = (TYPEOF(h.deed_pid))'',0,100));
    maxlength_deed_pid := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.deed_pid)));
    avelength_deed_pid := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.deed_pid)),h.deed_pid<>(typeof(h.deed_pid))'');
    populated_sam_pid_cnt := COUNT(GROUP,h.sam_pid <> (TYPEOF(h.sam_pid))'');
    populated_sam_pid_pcnt := AVE(GROUP,IF(h.sam_pid = (TYPEOF(h.sam_pid))'',0,100));
    maxlength_sam_pid := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.sam_pid)));
    avelength_sam_pid := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.sam_pid)),h.sam_pid<>(typeof(h.sam_pid))'');
    populated_assessorparcelnumber_matched_cnt := COUNT(GROUP,h.assessorparcelnumber_matched <> (TYPEOF(h.assessorparcelnumber_matched))'');
    populated_assessorparcelnumber_matched_pcnt := AVE(GROUP,IF(h.assessorparcelnumber_matched = (TYPEOF(h.assessorparcelnumber_matched))'',0,100));
    maxlength_assessorparcelnumber_matched := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.assessorparcelnumber_matched)));
    avelength_assessorparcelnumber_matched := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.assessorparcelnumber_matched)),h.assessorparcelnumber_matched<>(typeof(h.assessorparcelnumber_matched))'');
    populated_assessorpropertyfulladd_cnt := COUNT(GROUP,h.assessorpropertyfulladd <> (TYPEOF(h.assessorpropertyfulladd))'');
    populated_assessorpropertyfulladd_pcnt := AVE(GROUP,IF(h.assessorpropertyfulladd = (TYPEOF(h.assessorpropertyfulladd))'',0,100));
    maxlength_assessorpropertyfulladd := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.assessorpropertyfulladd)));
    avelength_assessorpropertyfulladd := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.assessorpropertyfulladd)),h.assessorpropertyfulladd<>(typeof(h.assessorpropertyfulladd))'');
    populated_assessorpropertyunittype_cnt := COUNT(GROUP,h.assessorpropertyunittype <> (TYPEOF(h.assessorpropertyunittype))'');
    populated_assessorpropertyunittype_pcnt := AVE(GROUP,IF(h.assessorpropertyunittype = (TYPEOF(h.assessorpropertyunittype))'',0,100));
    maxlength_assessorpropertyunittype := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.assessorpropertyunittype)));
    avelength_assessorpropertyunittype := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.assessorpropertyunittype)),h.assessorpropertyunittype<>(typeof(h.assessorpropertyunittype))'');
    populated_assessorpropertyunit_cnt := COUNT(GROUP,h.assessorpropertyunit <> (TYPEOF(h.assessorpropertyunit))'');
    populated_assessorpropertyunit_pcnt := AVE(GROUP,IF(h.assessorpropertyunit = (TYPEOF(h.assessorpropertyunit))'',0,100));
    maxlength_assessorpropertyunit := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.assessorpropertyunit)));
    avelength_assessorpropertyunit := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.assessorpropertyunit)),h.assessorpropertyunit<>(typeof(h.assessorpropertyunit))'');
    populated_assessorpropertycity_cnt := COUNT(GROUP,h.assessorpropertycity <> (TYPEOF(h.assessorpropertycity))'');
    populated_assessorpropertycity_pcnt := AVE(GROUP,IF(h.assessorpropertycity = (TYPEOF(h.assessorpropertycity))'',0,100));
    maxlength_assessorpropertycity := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.assessorpropertycity)));
    avelength_assessorpropertycity := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.assessorpropertycity)),h.assessorpropertycity<>(typeof(h.assessorpropertycity))'');
    populated_assessorpropertystate_cnt := COUNT(GROUP,h.assessorpropertystate <> (TYPEOF(h.assessorpropertystate))'');
    populated_assessorpropertystate_pcnt := AVE(GROUP,IF(h.assessorpropertystate = (TYPEOF(h.assessorpropertystate))'',0,100));
    maxlength_assessorpropertystate := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.assessorpropertystate)));
    avelength_assessorpropertystate := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.assessorpropertystate)),h.assessorpropertystate<>(typeof(h.assessorpropertystate))'');
    populated_assessorpropertyzip_cnt := COUNT(GROUP,h.assessorpropertyzip <> (TYPEOF(h.assessorpropertyzip))'');
    populated_assessorpropertyzip_pcnt := AVE(GROUP,IF(h.assessorpropertyzip = (TYPEOF(h.assessorpropertyzip))'',0,100));
    maxlength_assessorpropertyzip := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.assessorpropertyzip)));
    avelength_assessorpropertyzip := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.assessorpropertyzip)),h.assessorpropertyzip<>(typeof(h.assessorpropertyzip))'');
    populated_assessorpropertyzip4_cnt := COUNT(GROUP,h.assessorpropertyzip4 <> (TYPEOF(h.assessorpropertyzip4))'');
    populated_assessorpropertyzip4_pcnt := AVE(GROUP,IF(h.assessorpropertyzip4 = (TYPEOF(h.assessorpropertyzip4))'',0,100));
    maxlength_assessorpropertyzip4 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.assessorpropertyzip4)));
    avelength_assessorpropertyzip4 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.assessorpropertyzip4)),h.assessorpropertyzip4<>(typeof(h.assessorpropertyzip4))'');
    populated_assessorpropertyaddrsource_cnt := COUNT(GROUP,h.assessorpropertyaddrsource <> (TYPEOF(h.assessorpropertyaddrsource))'');
    populated_assessorpropertyaddrsource_pcnt := AVE(GROUP,IF(h.assessorpropertyaddrsource = (TYPEOF(h.assessorpropertyaddrsource))'',0,100));
    maxlength_assessorpropertyaddrsource := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.assessorpropertyaddrsource)));
    avelength_assessorpropertyaddrsource := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.assessorpropertyaddrsource)),h.assessorpropertyaddrsource<>(typeof(h.assessorpropertyaddrsource))'');
    populated_raw_file_name_cnt := COUNT(GROUP,h.raw_file_name <> (TYPEOF(h.raw_file_name))'');
    populated_raw_file_name_pcnt := AVE(GROUP,IF(h.raw_file_name = (TYPEOF(h.raw_file_name))'',0,100));
    maxlength_raw_file_name := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.raw_file_name)));
    avelength_raw_file_name := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.raw_file_name)),h.raw_file_name<>(typeof(h.raw_file_name))'');
  END;
    T := TABLE(h,SummaryLayout);
  R1 := RECORD
    UNSIGNED LinkingPotential :=  + T.Populated_ln_filedate_pcnt *   0.00 / 100 + T.Populated_bk_infile_type_pcnt *   0.00 / 100 + T.Populated_rectype_pcnt *   0.00 / 100 + T.Populated_documenttype_pcnt *   0.00 / 100 + T.Populated_fipscode_pcnt *   0.00 / 100 + T.Populated_mersindicator_pcnt *   0.00 / 100 + T.Populated_mainaddendum_pcnt *   0.00 / 100 + T.Populated_assigrecdate_pcnt *   0.00 / 100 + T.Populated_assigeffecdate_pcnt *   0.00 / 100 + T.Populated_assigdoc_pcnt *   0.00 / 100 + T.Populated_assigbk_pcnt *   0.00 / 100 + T.Populated_assigpg_pcnt *   0.00 / 100 + T.Populated_multiplepageimage_pcnt *   0.00 / 100 + T.Populated_bkfsimageid_pcnt *   0.00 / 100 + T.Populated_origdotrecdate_pcnt *   0.00 / 100 + T.Populated_origdotcontractdate_pcnt *   0.00 / 100 + T.Populated_origdotdoc_pcnt *   0.00 / 100 + T.Populated_origdotbk_pcnt *   0.00 / 100 + T.Populated_origdotpg_pcnt *   0.00 / 100 + T.Populated_origlenderben_pcnt *   0.00 / 100 + T.Populated_origloanamnt_pcnt *   0.00 / 100 + T.Populated_assignorname_pcnt *   0.00 / 100 + T.Populated_loannumber_pcnt *   0.00 / 100 + T.Populated_assignee_pcnt *   0.00 / 100 + T.Populated_mers_pcnt *   0.00 / 100 + T.Populated_mersvalidation_pcnt *   0.00 / 100 + T.Populated_assigneepool_pcnt *   0.00 / 100 + T.Populated_mspsvcrloan_pcnt *   0.00 / 100 + T.Populated_borrowername_pcnt *   0.00 / 100 + T.Populated_apn_pcnt *   0.00 / 100 + T.Populated_multiapncode_pcnt *   0.00 / 100 + T.Populated_taxacctid_pcnt *   0.00 / 100 + T.Populated_propertyfulladd_pcnt *   0.00 / 100 + T.Populated_propertyunit_pcnt *   0.00 / 100 + T.Populated_propertycity_pcnt *   0.00 / 100 + T.Populated_propertystate_pcnt *   0.00 / 100 + T.Populated_propertyzip_pcnt *   0.00 / 100 + T.Populated_propertyzip4_pcnt *   0.00 / 100 + T.Populated_dataentrydate_pcnt *   0.00 / 100 + T.Populated_dataentryopercode_pcnt *   0.00 / 100 + T.Populated_vendorsourcecode_pcnt *   0.00 / 100 + T.Populated_hids_recordingflag_pcnt *   0.00 / 100 + T.Populated_hids_docnumber_pcnt *   0.00 / 100 + T.Populated_transfercertificateoftitle_pcnt *   0.00 / 100 + T.Populated_hi_condo_cpr_hpr_pcnt *   0.00 / 100 + T.Populated_hi_situs_unit_number_pcnt *   0.00 / 100 + T.Populated_hids_previous_docnumber_pcnt *   0.00 / 100 + T.Populated_prevtransfercertificateoftitle_pcnt *   0.00 / 100 + T.Populated_pid_pcnt *   0.00 / 100 + T.Populated_matchedororphan_pcnt *   0.00 / 100 + T.Populated_deed_pid_pcnt *   0.00 / 100 + T.Populated_sam_pid_pcnt *   0.00 / 100 + T.Populated_assessorparcelnumber_matched_pcnt *   0.00 / 100 + T.Populated_assessorpropertyfulladd_pcnt *   0.00 / 100 + T.Populated_assessorpropertyunittype_pcnt *   0.00 / 100 + T.Populated_assessorpropertyunit_pcnt *   0.00 / 100 + T.Populated_assessorpropertycity_pcnt *   0.00 / 100 + T.Populated_assessorpropertystate_pcnt *   0.00 / 100 + T.Populated_assessorpropertyzip_pcnt *   0.00 / 100 + T.Populated_assessorpropertyzip4_pcnt *   0.00 / 100 + T.Populated_assessorpropertyaddrsource_pcnt *   0.00 / 100 + T.Populated_raw_file_name_pcnt *   0.00 / 100;
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
  SELF.FieldName := CHOOSE(C,'ln_filedate','bk_infile_type','rectype','documenttype','fipscode','mersindicator','mainaddendum','assigrecdate','assigeffecdate','assigdoc','assigbk','assigpg','multiplepageimage','bkfsimageid','origdotrecdate','origdotcontractdate','origdotdoc','origdotbk','origdotpg','origlenderben','origloanamnt','assignorname','loannumber','assignee','mers','mersvalidation','assigneepool','mspsvcrloan','borrowername','apn','multiapncode','taxacctid','propertyfulladd','propertyunit','propertycity','propertystate','propertyzip','propertyzip4','dataentrydate','dataentryopercode','vendorsourcecode','hids_recordingflag','hids_docnumber','transfercertificateoftitle','hi_condo_cpr_hpr','hi_situs_unit_number','hids_previous_docnumber','prevtransfercertificateoftitle','pid','matchedororphan','deed_pid','sam_pid','assessorparcelnumber_matched','assessorpropertyfulladd','assessorpropertyunittype','assessorpropertyunit','assessorpropertycity','assessorpropertystate','assessorpropertyzip','assessorpropertyzip4','assessorpropertyaddrsource','raw_file_name');
  SELF.populated_pcnt := CHOOSE(C,le.populated_ln_filedate_pcnt,le.populated_bk_infile_type_pcnt,le.populated_rectype_pcnt,le.populated_documenttype_pcnt,le.populated_fipscode_pcnt,le.populated_mersindicator_pcnt,le.populated_mainaddendum_pcnt,le.populated_assigrecdate_pcnt,le.populated_assigeffecdate_pcnt,le.populated_assigdoc_pcnt,le.populated_assigbk_pcnt,le.populated_assigpg_pcnt,le.populated_multiplepageimage_pcnt,le.populated_bkfsimageid_pcnt,le.populated_origdotrecdate_pcnt,le.populated_origdotcontractdate_pcnt,le.populated_origdotdoc_pcnt,le.populated_origdotbk_pcnt,le.populated_origdotpg_pcnt,le.populated_origlenderben_pcnt,le.populated_origloanamnt_pcnt,le.populated_assignorname_pcnt,le.populated_loannumber_pcnt,le.populated_assignee_pcnt,le.populated_mers_pcnt,le.populated_mersvalidation_pcnt,le.populated_assigneepool_pcnt,le.populated_mspsvcrloan_pcnt,le.populated_borrowername_pcnt,le.populated_apn_pcnt,le.populated_multiapncode_pcnt,le.populated_taxacctid_pcnt,le.populated_propertyfulladd_pcnt,le.populated_propertyunit_pcnt,le.populated_propertycity_pcnt,le.populated_propertystate_pcnt,le.populated_propertyzip_pcnt,le.populated_propertyzip4_pcnt,le.populated_dataentrydate_pcnt,le.populated_dataentryopercode_pcnt,le.populated_vendorsourcecode_pcnt,le.populated_hids_recordingflag_pcnt,le.populated_hids_docnumber_pcnt,le.populated_transfercertificateoftitle_pcnt,le.populated_hi_condo_cpr_hpr_pcnt,le.populated_hi_situs_unit_number_pcnt,le.populated_hids_previous_docnumber_pcnt,le.populated_prevtransfercertificateoftitle_pcnt,le.populated_pid_pcnt,le.populated_matchedororphan_pcnt,le.populated_deed_pid_pcnt,le.populated_sam_pid_pcnt,le.populated_assessorparcelnumber_matched_pcnt,le.populated_assessorpropertyfulladd_pcnt,le.populated_assessorpropertyunittype_pcnt,le.populated_assessorpropertyunit_pcnt,le.populated_assessorpropertycity_pcnt,le.populated_assessorpropertystate_pcnt,le.populated_assessorpropertyzip_pcnt,le.populated_assessorpropertyzip4_pcnt,le.populated_assessorpropertyaddrsource_pcnt,le.populated_raw_file_name_pcnt);
  SELF.maxlength := CHOOSE(C,le.maxlength_ln_filedate,le.maxlength_bk_infile_type,le.maxlength_rectype,le.maxlength_documenttype,le.maxlength_fipscode,le.maxlength_mersindicator,le.maxlength_mainaddendum,le.maxlength_assigrecdate,le.maxlength_assigeffecdate,le.maxlength_assigdoc,le.maxlength_assigbk,le.maxlength_assigpg,le.maxlength_multiplepageimage,le.maxlength_bkfsimageid,le.maxlength_origdotrecdate,le.maxlength_origdotcontractdate,le.maxlength_origdotdoc,le.maxlength_origdotbk,le.maxlength_origdotpg,le.maxlength_origlenderben,le.maxlength_origloanamnt,le.maxlength_assignorname,le.maxlength_loannumber,le.maxlength_assignee,le.maxlength_mers,le.maxlength_mersvalidation,le.maxlength_assigneepool,le.maxlength_mspsvcrloan,le.maxlength_borrowername,le.maxlength_apn,le.maxlength_multiapncode,le.maxlength_taxacctid,le.maxlength_propertyfulladd,le.maxlength_propertyunit,le.maxlength_propertycity,le.maxlength_propertystate,le.maxlength_propertyzip,le.maxlength_propertyzip4,le.maxlength_dataentrydate,le.maxlength_dataentryopercode,le.maxlength_vendorsourcecode,le.maxlength_hids_recordingflag,le.maxlength_hids_docnumber,le.maxlength_transfercertificateoftitle,le.maxlength_hi_condo_cpr_hpr,le.maxlength_hi_situs_unit_number,le.maxlength_hids_previous_docnumber,le.maxlength_prevtransfercertificateoftitle,le.maxlength_pid,le.maxlength_matchedororphan,le.maxlength_deed_pid,le.maxlength_sam_pid,le.maxlength_assessorparcelnumber_matched,le.maxlength_assessorpropertyfulladd,le.maxlength_assessorpropertyunittype,le.maxlength_assessorpropertyunit,le.maxlength_assessorpropertycity,le.maxlength_assessorpropertystate,le.maxlength_assessorpropertyzip,le.maxlength_assessorpropertyzip4,le.maxlength_assessorpropertyaddrsource,le.maxlength_raw_file_name);
  SELF.avelength := CHOOSE(C,le.avelength_ln_filedate,le.avelength_bk_infile_type,le.avelength_rectype,le.avelength_documenttype,le.avelength_fipscode,le.avelength_mersindicator,le.avelength_mainaddendum,le.avelength_assigrecdate,le.avelength_assigeffecdate,le.avelength_assigdoc,le.avelength_assigbk,le.avelength_assigpg,le.avelength_multiplepageimage,le.avelength_bkfsimageid,le.avelength_origdotrecdate,le.avelength_origdotcontractdate,le.avelength_origdotdoc,le.avelength_origdotbk,le.avelength_origdotpg,le.avelength_origlenderben,le.avelength_origloanamnt,le.avelength_assignorname,le.avelength_loannumber,le.avelength_assignee,le.avelength_mers,le.avelength_mersvalidation,le.avelength_assigneepool,le.avelength_mspsvcrloan,le.avelength_borrowername,le.avelength_apn,le.avelength_multiapncode,le.avelength_taxacctid,le.avelength_propertyfulladd,le.avelength_propertyunit,le.avelength_propertycity,le.avelength_propertystate,le.avelength_propertyzip,le.avelength_propertyzip4,le.avelength_dataentrydate,le.avelength_dataentryopercode,le.avelength_vendorsourcecode,le.avelength_hids_recordingflag,le.avelength_hids_docnumber,le.avelength_transfercertificateoftitle,le.avelength_hi_condo_cpr_hpr,le.avelength_hi_situs_unit_number,le.avelength_hids_previous_docnumber,le.avelength_prevtransfercertificateoftitle,le.avelength_pid,le.avelength_matchedororphan,le.avelength_deed_pid,le.avelength_sam_pid,le.avelength_assessorparcelnumber_matched,le.avelength_assessorpropertyfulladd,le.avelength_assessorpropertyunittype,le.avelength_assessorpropertyunit,le.avelength_assessorpropertycity,le.avelength_assessorpropertystate,le.avelength_assessorpropertyzip,le.avelength_assessorpropertyzip4,le.avelength_assessorpropertyaddrsource,le.avelength_raw_file_name);
END;
EXPORT invSummary := NORMALIZE(summary0, 62, invert(LEFT,COUNTER));
// The character counts
// Move everything into 'inverted list' form so processing can be done 'in library'
SALT311.MAC_Character_Counts.X_Data_Layout Into(h le,unsigned C) := TRANSFORM
  SELF.Fld := TRIM(CHOOSE(C,TRIM((SALT311.StrType)le.ln_filedate),TRIM((SALT311.StrType)le.bk_infile_type),TRIM((SALT311.StrType)le.rectype),TRIM((SALT311.StrType)le.documenttype),TRIM((SALT311.StrType)le.fipscode),TRIM((SALT311.StrType)le.mersindicator),TRIM((SALT311.StrType)le.mainaddendum),TRIM((SALT311.StrType)le.assigrecdate),TRIM((SALT311.StrType)le.assigeffecdate),TRIM((SALT311.StrType)le.assigdoc),TRIM((SALT311.StrType)le.assigbk),TRIM((SALT311.StrType)le.assigpg),TRIM((SALT311.StrType)le.multiplepageimage),TRIM((SALT311.StrType)le.bkfsimageid),TRIM((SALT311.StrType)le.origdotrecdate),TRIM((SALT311.StrType)le.origdotcontractdate),TRIM((SALT311.StrType)le.origdotdoc),TRIM((SALT311.StrType)le.origdotbk),TRIM((SALT311.StrType)le.origdotpg),TRIM((SALT311.StrType)le.origlenderben),TRIM((SALT311.StrType)le.origloanamnt),TRIM((SALT311.StrType)le.assignorname),TRIM((SALT311.StrType)le.loannumber),TRIM((SALT311.StrType)le.assignee),TRIM((SALT311.StrType)le.mers),TRIM((SALT311.StrType)le.mersvalidation),TRIM((SALT311.StrType)le.assigneepool),TRIM((SALT311.StrType)le.mspsvcrloan),TRIM((SALT311.StrType)le.borrowername),TRIM((SALT311.StrType)le.apn),TRIM((SALT311.StrType)le.multiapncode),TRIM((SALT311.StrType)le.taxacctid),TRIM((SALT311.StrType)le.propertyfulladd),TRIM((SALT311.StrType)le.propertyunit),TRIM((SALT311.StrType)le.propertycity),TRIM((SALT311.StrType)le.propertystate),TRIM((SALT311.StrType)le.propertyzip),TRIM((SALT311.StrType)le.propertyzip4),TRIM((SALT311.StrType)le.dataentrydate),TRIM((SALT311.StrType)le.dataentryopercode),TRIM((SALT311.StrType)le.vendorsourcecode),TRIM((SALT311.StrType)le.hids_recordingflag),TRIM((SALT311.StrType)le.hids_docnumber),TRIM((SALT311.StrType)le.transfercertificateoftitle),TRIM((SALT311.StrType)le.hi_condo_cpr_hpr),TRIM((SALT311.StrType)le.hi_situs_unit_number),TRIM((SALT311.StrType)le.hids_previous_docnumber),TRIM((SALT311.StrType)le.prevtransfercertificateoftitle),TRIM((SALT311.StrType)le.pid),TRIM((SALT311.StrType)le.matchedororphan),TRIM((SALT311.StrType)le.deed_pid),TRIM((SALT311.StrType)le.sam_pid),TRIM((SALT311.StrType)le.assessorparcelnumber_matched),TRIM((SALT311.StrType)le.assessorpropertyfulladd),TRIM((SALT311.StrType)le.assessorpropertyunittype),TRIM((SALT311.StrType)le.assessorpropertyunit),TRIM((SALT311.StrType)le.assessorpropertycity),TRIM((SALT311.StrType)le.assessorpropertystate),TRIM((SALT311.StrType)le.assessorpropertyzip),TRIM((SALT311.StrType)le.assessorpropertyzip4),TRIM((SALT311.StrType)le.assessorpropertyaddrsource),TRIM((SALT311.StrType)le.raw_file_name)));
  SELF.FldNo := C;
END;
SHARED FldInv0 := NORMALIZE(h,62,Into(LEFT,COUNTER));
// Move everything into 'pairs' form so processing can be done 'in library'
SALT311.MAC_Correlate.Data_Layout IntoP(h le,UNSIGNED C) := TRANSFORM
  SELF.FldNo1 := 1 + (C / 62);
  SELF.FldNo2 := 1 + (C % 62);
  SELF.Fld1 := TRIM(CHOOSE(SELF.FldNo1,TRIM((SALT311.StrType)le.ln_filedate),TRIM((SALT311.StrType)le.bk_infile_type),TRIM((SALT311.StrType)le.rectype),TRIM((SALT311.StrType)le.documenttype),TRIM((SALT311.StrType)le.fipscode),TRIM((SALT311.StrType)le.mersindicator),TRIM((SALT311.StrType)le.mainaddendum),TRIM((SALT311.StrType)le.assigrecdate),TRIM((SALT311.StrType)le.assigeffecdate),TRIM((SALT311.StrType)le.assigdoc),TRIM((SALT311.StrType)le.assigbk),TRIM((SALT311.StrType)le.assigpg),TRIM((SALT311.StrType)le.multiplepageimage),TRIM((SALT311.StrType)le.bkfsimageid),TRIM((SALT311.StrType)le.origdotrecdate),TRIM((SALT311.StrType)le.origdotcontractdate),TRIM((SALT311.StrType)le.origdotdoc),TRIM((SALT311.StrType)le.origdotbk),TRIM((SALT311.StrType)le.origdotpg),TRIM((SALT311.StrType)le.origlenderben),TRIM((SALT311.StrType)le.origloanamnt),TRIM((SALT311.StrType)le.assignorname),TRIM((SALT311.StrType)le.loannumber),TRIM((SALT311.StrType)le.assignee),TRIM((SALT311.StrType)le.mers),TRIM((SALT311.StrType)le.mersvalidation),TRIM((SALT311.StrType)le.assigneepool),TRIM((SALT311.StrType)le.mspsvcrloan),TRIM((SALT311.StrType)le.borrowername),TRIM((SALT311.StrType)le.apn),TRIM((SALT311.StrType)le.multiapncode),TRIM((SALT311.StrType)le.taxacctid),TRIM((SALT311.StrType)le.propertyfulladd),TRIM((SALT311.StrType)le.propertyunit),TRIM((SALT311.StrType)le.propertycity),TRIM((SALT311.StrType)le.propertystate),TRIM((SALT311.StrType)le.propertyzip),TRIM((SALT311.StrType)le.propertyzip4),TRIM((SALT311.StrType)le.dataentrydate),TRIM((SALT311.StrType)le.dataentryopercode),TRIM((SALT311.StrType)le.vendorsourcecode),TRIM((SALT311.StrType)le.hids_recordingflag),TRIM((SALT311.StrType)le.hids_docnumber),TRIM((SALT311.StrType)le.transfercertificateoftitle),TRIM((SALT311.StrType)le.hi_condo_cpr_hpr),TRIM((SALT311.StrType)le.hi_situs_unit_number),TRIM((SALT311.StrType)le.hids_previous_docnumber),TRIM((SALT311.StrType)le.prevtransfercertificateoftitle),TRIM((SALT311.StrType)le.pid),TRIM((SALT311.StrType)le.matchedororphan),TRIM((SALT311.StrType)le.deed_pid),TRIM((SALT311.StrType)le.sam_pid),TRIM((SALT311.StrType)le.assessorparcelnumber_matched),TRIM((SALT311.StrType)le.assessorpropertyfulladd),TRIM((SALT311.StrType)le.assessorpropertyunittype),TRIM((SALT311.StrType)le.assessorpropertyunit),TRIM((SALT311.StrType)le.assessorpropertycity),TRIM((SALT311.StrType)le.assessorpropertystate),TRIM((SALT311.StrType)le.assessorpropertyzip),TRIM((SALT311.StrType)le.assessorpropertyzip4),TRIM((SALT311.StrType)le.assessorpropertyaddrsource),TRIM((SALT311.StrType)le.raw_file_name)));
  SELF.Fld2 := TRIM(CHOOSE(SELF.FldNo2,TRIM((SALT311.StrType)le.ln_filedate),TRIM((SALT311.StrType)le.bk_infile_type),TRIM((SALT311.StrType)le.rectype),TRIM((SALT311.StrType)le.documenttype),TRIM((SALT311.StrType)le.fipscode),TRIM((SALT311.StrType)le.mersindicator),TRIM((SALT311.StrType)le.mainaddendum),TRIM((SALT311.StrType)le.assigrecdate),TRIM((SALT311.StrType)le.assigeffecdate),TRIM((SALT311.StrType)le.assigdoc),TRIM((SALT311.StrType)le.assigbk),TRIM((SALT311.StrType)le.assigpg),TRIM((SALT311.StrType)le.multiplepageimage),TRIM((SALT311.StrType)le.bkfsimageid),TRIM((SALT311.StrType)le.origdotrecdate),TRIM((SALT311.StrType)le.origdotcontractdate),TRIM((SALT311.StrType)le.origdotdoc),TRIM((SALT311.StrType)le.origdotbk),TRIM((SALT311.StrType)le.origdotpg),TRIM((SALT311.StrType)le.origlenderben),TRIM((SALT311.StrType)le.origloanamnt),TRIM((SALT311.StrType)le.assignorname),TRIM((SALT311.StrType)le.loannumber),TRIM((SALT311.StrType)le.assignee),TRIM((SALT311.StrType)le.mers),TRIM((SALT311.StrType)le.mersvalidation),TRIM((SALT311.StrType)le.assigneepool),TRIM((SALT311.StrType)le.mspsvcrloan),TRIM((SALT311.StrType)le.borrowername),TRIM((SALT311.StrType)le.apn),TRIM((SALT311.StrType)le.multiapncode),TRIM((SALT311.StrType)le.taxacctid),TRIM((SALT311.StrType)le.propertyfulladd),TRIM((SALT311.StrType)le.propertyunit),TRIM((SALT311.StrType)le.propertycity),TRIM((SALT311.StrType)le.propertystate),TRIM((SALT311.StrType)le.propertyzip),TRIM((SALT311.StrType)le.propertyzip4),TRIM((SALT311.StrType)le.dataentrydate),TRIM((SALT311.StrType)le.dataentryopercode),TRIM((SALT311.StrType)le.vendorsourcecode),TRIM((SALT311.StrType)le.hids_recordingflag),TRIM((SALT311.StrType)le.hids_docnumber),TRIM((SALT311.StrType)le.transfercertificateoftitle),TRIM((SALT311.StrType)le.hi_condo_cpr_hpr),TRIM((SALT311.StrType)le.hi_situs_unit_number),TRIM((SALT311.StrType)le.hids_previous_docnumber),TRIM((SALT311.StrType)le.prevtransfercertificateoftitle),TRIM((SALT311.StrType)le.pid),TRIM((SALT311.StrType)le.matchedororphan),TRIM((SALT311.StrType)le.deed_pid),TRIM((SALT311.StrType)le.sam_pid),TRIM((SALT311.StrType)le.assessorparcelnumber_matched),TRIM((SALT311.StrType)le.assessorpropertyfulladd),TRIM((SALT311.StrType)le.assessorpropertyunittype),TRIM((SALT311.StrType)le.assessorpropertyunit),TRIM((SALT311.StrType)le.assessorpropertycity),TRIM((SALT311.StrType)le.assessorpropertystate),TRIM((SALT311.StrType)le.assessorpropertyzip),TRIM((SALT311.StrType)le.assessorpropertyzip4),TRIM((SALT311.StrType)le.assessorpropertyaddrsource),TRIM((SALT311.StrType)le.raw_file_name)));
  END;
SHARED Pairs0 := NORMALIZE(ENTH(h,Config.CorrelateSampleSize),62*62,IntoP(LEFT,COUNTER))(FldNo1<FldNo2);
SHARED FldIds := DATASET([{1,'ln_filedate'}
      ,{2,'bk_infile_type'}
      ,{3,'rectype'}
      ,{4,'documenttype'}
      ,{5,'fipscode'}
      ,{6,'mersindicator'}
      ,{7,'mainaddendum'}
      ,{8,'assigrecdate'}
      ,{9,'assigeffecdate'}
      ,{10,'assigdoc'}
      ,{11,'assigbk'}
      ,{12,'assigpg'}
      ,{13,'multiplepageimage'}
      ,{14,'bkfsimageid'}
      ,{15,'origdotrecdate'}
      ,{16,'origdotcontractdate'}
      ,{17,'origdotdoc'}
      ,{18,'origdotbk'}
      ,{19,'origdotpg'}
      ,{20,'origlenderben'}
      ,{21,'origloanamnt'}
      ,{22,'assignorname'}
      ,{23,'loannumber'}
      ,{24,'assignee'}
      ,{25,'mers'}
      ,{26,'mersvalidation'}
      ,{27,'assigneepool'}
      ,{28,'mspsvcrloan'}
      ,{29,'borrowername'}
      ,{30,'apn'}
      ,{31,'multiapncode'}
      ,{32,'taxacctid'}
      ,{33,'propertyfulladd'}
      ,{34,'propertyunit'}
      ,{35,'propertycity'}
      ,{36,'propertystate'}
      ,{37,'propertyzip'}
      ,{38,'propertyzip4'}
      ,{39,'dataentrydate'}
      ,{40,'dataentryopercode'}
      ,{41,'vendorsourcecode'}
      ,{42,'hids_recordingflag'}
      ,{43,'hids_docnumber'}
      ,{44,'transfercertificateoftitle'}
      ,{45,'hi_condo_cpr_hpr'}
      ,{46,'hi_situs_unit_number'}
      ,{47,'hids_previous_docnumber'}
      ,{48,'prevtransfercertificateoftitle'}
      ,{49,'pid'}
      ,{50,'matchedororphan'}
      ,{51,'deed_pid'}
      ,{52,'sam_pid'}
      ,{53,'assessorparcelnumber_matched'}
      ,{54,'assessorpropertyfulladd'}
      ,{55,'assessorpropertyunittype'}
      ,{56,'assessorpropertyunit'}
      ,{57,'assessorpropertycity'}
      ,{58,'assessorpropertystate'}
      ,{59,'assessorpropertyzip'}
      ,{60,'assessorpropertyzip4'}
      ,{61,'assessorpropertyaddrsource'}
      ,{62,'raw_file_name'}],SALT311.MAC_Character_Counts.Field_Identification);
EXPORT AllProfiles := SALT311.MAC_Character_Counts.FN_Profile(FldInv0,FldIds);
 
EXPORT SrcProfiles := SALT311.MAC_Character_Counts.Src_Profile(FldInv0,FldIds);
 
EXPORT Correlations := SALT311.MAC_Correlate.Fn_Profile(Pairs0,FldIds);
 
ErrorRecord := RECORD
  UNSIGNED1 FieldNum;
  UNSIGNED1 ErrorNum;
END;
ErrorRecord NoteErrors(h le,UNSIGNED1 c) := TRANSFORM
  SELF.ErrorNum := CHOOSE(c,
    Fields.InValid_ln_filedate((SALT311.StrType)le.ln_filedate),
    Fields.InValid_bk_infile_type((SALT311.StrType)le.bk_infile_type),
    Fields.InValid_rectype((SALT311.StrType)le.rectype),
    Fields.InValid_documenttype((SALT311.StrType)le.documenttype),
    Fields.InValid_fipscode((SALT311.StrType)le.fipscode),
    Fields.InValid_mersindicator((SALT311.StrType)le.mersindicator),
    Fields.InValid_mainaddendum((SALT311.StrType)le.mainaddendum),
    Fields.InValid_assigrecdate((SALT311.StrType)le.assigrecdate),
    Fields.InValid_assigeffecdate((SALT311.StrType)le.assigeffecdate),
    Fields.InValid_assigdoc((SALT311.StrType)le.assigdoc),
    Fields.InValid_assigbk((SALT311.StrType)le.assigbk),
    Fields.InValid_assigpg((SALT311.StrType)le.assigpg),
    Fields.InValid_multiplepageimage((SALT311.StrType)le.multiplepageimage),
    Fields.InValid_bkfsimageid((SALT311.StrType)le.bkfsimageid),
    Fields.InValid_origdotrecdate((SALT311.StrType)le.origdotrecdate),
    Fields.InValid_origdotcontractdate((SALT311.StrType)le.origdotcontractdate),
    Fields.InValid_origdotdoc((SALT311.StrType)le.origdotdoc),
    Fields.InValid_origdotbk((SALT311.StrType)le.origdotbk),
    Fields.InValid_origdotpg((SALT311.StrType)le.origdotpg),
    Fields.InValid_origlenderben((SALT311.StrType)le.origlenderben),
    Fields.InValid_origloanamnt((SALT311.StrType)le.origloanamnt),
    Fields.InValid_assignorname((SALT311.StrType)le.assignorname),
    Fields.InValid_loannumber((SALT311.StrType)le.loannumber),
    Fields.InValid_assignee((SALT311.StrType)le.assignee),
    Fields.InValid_mers((SALT311.StrType)le.mers),
    Fields.InValid_mersvalidation((SALT311.StrType)le.mersvalidation),
    Fields.InValid_assigneepool((SALT311.StrType)le.assigneepool),
    Fields.InValid_mspsvcrloan((SALT311.StrType)le.mspsvcrloan),
    Fields.InValid_borrowername((SALT311.StrType)le.borrowername),
    Fields.InValid_apn((SALT311.StrType)le.apn),
    Fields.InValid_multiapncode((SALT311.StrType)le.multiapncode),
    Fields.InValid_taxacctid((SALT311.StrType)le.taxacctid),
    Fields.InValid_propertyfulladd((SALT311.StrType)le.propertyfulladd),
    Fields.InValid_propertyunit((SALT311.StrType)le.propertyunit),
    Fields.InValid_propertycity((SALT311.StrType)le.propertycity),
    Fields.InValid_propertystate((SALT311.StrType)le.propertystate),
    Fields.InValid_propertyzip((SALT311.StrType)le.propertyzip),
    Fields.InValid_propertyzip4((SALT311.StrType)le.propertyzip4),
    Fields.InValid_dataentrydate((SALT311.StrType)le.dataentrydate),
    Fields.InValid_dataentryopercode((SALT311.StrType)le.dataentryopercode),
    Fields.InValid_vendorsourcecode((SALT311.StrType)le.vendorsourcecode),
    Fields.InValid_hids_recordingflag((SALT311.StrType)le.hids_recordingflag),
    Fields.InValid_hids_docnumber((SALT311.StrType)le.hids_docnumber),
    Fields.InValid_transfercertificateoftitle((SALT311.StrType)le.transfercertificateoftitle),
    Fields.InValid_hi_condo_cpr_hpr((SALT311.StrType)le.hi_condo_cpr_hpr),
    Fields.InValid_hi_situs_unit_number((SALT311.StrType)le.hi_situs_unit_number),
    Fields.InValid_hids_previous_docnumber((SALT311.StrType)le.hids_previous_docnumber),
    Fields.InValid_prevtransfercertificateoftitle((SALT311.StrType)le.prevtransfercertificateoftitle),
    Fields.InValid_pid((SALT311.StrType)le.pid),
    Fields.InValid_matchedororphan((SALT311.StrType)le.matchedororphan),
    Fields.InValid_deed_pid((SALT311.StrType)le.deed_pid),
    Fields.InValid_sam_pid((SALT311.StrType)le.sam_pid),
    Fields.InValid_assessorparcelnumber_matched((SALT311.StrType)le.assessorparcelnumber_matched),
    Fields.InValid_assessorpropertyfulladd((SALT311.StrType)le.assessorpropertyfulladd),
    Fields.InValid_assessorpropertyunittype((SALT311.StrType)le.assessorpropertyunittype),
    Fields.InValid_assessorpropertyunit((SALT311.StrType)le.assessorpropertyunit),
    Fields.InValid_assessorpropertycity((SALT311.StrType)le.assessorpropertycity),
    Fields.InValid_assessorpropertystate((SALT311.StrType)le.assessorpropertystate),
    Fields.InValid_assessorpropertyzip((SALT311.StrType)le.assessorpropertyzip),
    Fields.InValid_assessorpropertyzip4((SALT311.StrType)le.assessorpropertyzip4),
    Fields.InValid_assessorpropertyaddrsource((SALT311.StrType)le.assessorpropertyaddrsource),
    Fields.InValid_raw_file_name((SALT311.StrType)le.raw_file_name),
    0);
  SELF.FieldNum := IF(SELF.ErrorNum=0,SKIP,c); // Bail early to avoid creating record
END;
Errors := NORMALIZE(h,62,NoteErrors(LEFT,COUNTER));
ErrorRecordsTotals := RECORD
  Errors.FieldNum;
  Errors.ErrorNum;
  UNSIGNED Cnt := COUNT(GROUP);
END;
TotalErrors := TABLE(Errors,ErrorRecordsTotals,FieldNum,ErrorNum,FEW);
PrettyErrorTotals := RECORD
  FieldNme := Fields.FieldName(TotalErrors.FieldNum);
  FieldType := CHOOSE(TotalErrors.FieldNum,'invalid_date','Unknown','Invalid_RecType','Invalid_DocType','invalid_number','Unknown','Unknown','invalid_date','invalid_date','Unknown','Unknown','Unknown','Unknown','Unknown','invalid_date','invalid_date','Unknown','Unknown','Unknown','invalid_name','Unknown','invalid_name','Unknown','invalid_name','invalid_mers','Unknown','Unknown','Unknown','invalid_name','invalid_apn','Unknown','Unknown','invalid_AlphaNum','Unknown','invalid_AlphaNum','invalid_state','invalid_zip','invalid_zip','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','invalid_number','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown');
  ErrorMessage := CHOOSE(TotalErrors.FieldNum,Fields.InValidMessage_ln_filedate(TotalErrors.ErrorNum),Fields.InValidMessage_bk_infile_type(TotalErrors.ErrorNum),Fields.InValidMessage_rectype(TotalErrors.ErrorNum),Fields.InValidMessage_documenttype(TotalErrors.ErrorNum),Fields.InValidMessage_fipscode(TotalErrors.ErrorNum),Fields.InValidMessage_mersindicator(TotalErrors.ErrorNum),Fields.InValidMessage_mainaddendum(TotalErrors.ErrorNum),Fields.InValidMessage_assigrecdate(TotalErrors.ErrorNum),Fields.InValidMessage_assigeffecdate(TotalErrors.ErrorNum),Fields.InValidMessage_assigdoc(TotalErrors.ErrorNum),Fields.InValidMessage_assigbk(TotalErrors.ErrorNum),Fields.InValidMessage_assigpg(TotalErrors.ErrorNum),Fields.InValidMessage_multiplepageimage(TotalErrors.ErrorNum),Fields.InValidMessage_bkfsimageid(TotalErrors.ErrorNum),Fields.InValidMessage_origdotrecdate(TotalErrors.ErrorNum),Fields.InValidMessage_origdotcontractdate(TotalErrors.ErrorNum),Fields.InValidMessage_origdotdoc(TotalErrors.ErrorNum),Fields.InValidMessage_origdotbk(TotalErrors.ErrorNum),Fields.InValidMessage_origdotpg(TotalErrors.ErrorNum),Fields.InValidMessage_origlenderben(TotalErrors.ErrorNum),Fields.InValidMessage_origloanamnt(TotalErrors.ErrorNum),Fields.InValidMessage_assignorname(TotalErrors.ErrorNum),Fields.InValidMessage_loannumber(TotalErrors.ErrorNum),Fields.InValidMessage_assignee(TotalErrors.ErrorNum),Fields.InValidMessage_mers(TotalErrors.ErrorNum),Fields.InValidMessage_mersvalidation(TotalErrors.ErrorNum),Fields.InValidMessage_assigneepool(TotalErrors.ErrorNum),Fields.InValidMessage_mspsvcrloan(TotalErrors.ErrorNum),Fields.InValidMessage_borrowername(TotalErrors.ErrorNum),Fields.InValidMessage_apn(TotalErrors.ErrorNum),Fields.InValidMessage_multiapncode(TotalErrors.ErrorNum),Fields.InValidMessage_taxacctid(TotalErrors.ErrorNum),Fields.InValidMessage_propertyfulladd(TotalErrors.ErrorNum),Fields.InValidMessage_propertyunit(TotalErrors.ErrorNum),Fields.InValidMessage_propertycity(TotalErrors.ErrorNum),Fields.InValidMessage_propertystate(TotalErrors.ErrorNum),Fields.InValidMessage_propertyzip(TotalErrors.ErrorNum),Fields.InValidMessage_propertyzip4(TotalErrors.ErrorNum),Fields.InValidMessage_dataentrydate(TotalErrors.ErrorNum),Fields.InValidMessage_dataentryopercode(TotalErrors.ErrorNum),Fields.InValidMessage_vendorsourcecode(TotalErrors.ErrorNum),Fields.InValidMessage_hids_recordingflag(TotalErrors.ErrorNum),Fields.InValidMessage_hids_docnumber(TotalErrors.ErrorNum),Fields.InValidMessage_transfercertificateoftitle(TotalErrors.ErrorNum),Fields.InValidMessage_hi_condo_cpr_hpr(TotalErrors.ErrorNum),Fields.InValidMessage_hi_situs_unit_number(TotalErrors.ErrorNum),Fields.InValidMessage_hids_previous_docnumber(TotalErrors.ErrorNum),Fields.InValidMessage_prevtransfercertificateoftitle(TotalErrors.ErrorNum),Fields.InValidMessage_pid(TotalErrors.ErrorNum),Fields.InValidMessage_matchedororphan(TotalErrors.ErrorNum),Fields.InValidMessage_deed_pid(TotalErrors.ErrorNum),Fields.InValidMessage_sam_pid(TotalErrors.ErrorNum),Fields.InValidMessage_assessorparcelnumber_matched(TotalErrors.ErrorNum),Fields.InValidMessage_assessorpropertyfulladd(TotalErrors.ErrorNum),Fields.InValidMessage_assessorpropertyunittype(TotalErrors.ErrorNum),Fields.InValidMessage_assessorpropertyunit(TotalErrors.ErrorNum),Fields.InValidMessage_assessorpropertycity(TotalErrors.ErrorNum),Fields.InValidMessage_assessorpropertystate(TotalErrors.ErrorNum),Fields.InValidMessage_assessorpropertyzip(TotalErrors.ErrorNum),Fields.InValidMessage_assessorpropertyzip4(TotalErrors.ErrorNum),Fields.InValidMessage_assessorpropertyaddrsource(TotalErrors.ErrorNum),Fields.InValidMessage_raw_file_name(TotalErrors.ErrorNum));
  TotalErrors.Cnt;
END;
ValErr := TABLE(TotalErrors,PrettyErrorTotals);
EXPORT ValidityErrors := ValErr;
EXPORT StandardStats(BOOLEAN doSummaryGlobal = TRUE, BOOLEAN doAllProfiles = TRUE) := FUNCTION
  myTimeStamp := (UNSIGNED6)SALT311.Fn_Now('YYYYMMDDHHMMSS') : INDEPENDENT;
  fieldPopulationOverall := Summary('');
 
  SALT311.mod_StandardStatsTransforms.mac_hygieneSummaryTransform(Scrubs_BKMortgage_Assignments, Fields, 'RECORDOF(fieldPopulationOverall)', FALSE);
 
  fieldPopulationOverall_Standard := IF(doSummaryGlobal, NORMALIZE(fieldPopulationOverall, COUNT(FldIds) * 6, xSummary(LEFT, COUNTER, myTimeStamp, 'all', 'all')));
  fieldPopulationOverall_TotalRecs_Standard := IF(doSummaryGlobal, SALT311.mod_StandardStatsTransforms.mac_hygieneTotalRecs(fieldPopulationOverall, myTimeStamp, 'all', FALSE, 'all'));
  allProfiles_Standard := IF(doAllProfiles, SALT311.mod_StandardStatsTransforms.hygieneAllProfiles(AllProfiles, myTimeStamp, 10, 'all'));
 
  RETURN fieldPopulationOverall_Standard & fieldPopulationOverall_TotalRecs_Standard & allProfiles_Standard;
END;
END;
