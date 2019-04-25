//************************************************************************************************************************************//
//Mapping information - BK Keys to Parent
//Author: Vikram Pareddy
//************************************************************************************************************************************//
EXPORT BKMappings := module
	//BDID Key
	export BDIDKeyName := 'bdid';
	export BDIDKeyType := 'Search Key';
	export BDIDKeySet :=  [ 'tmsid', 'court_code', 'case_number'];
	export BDIDParentSet := [ 'left.tmsid', 'left.court_code', 'left.case_number'];
	export BDIDIgnoredFields := ['p_bdid', '__internal_fpos__', 'qa_defined_empty'];
	export BDIDUniqueField := ['tmsid'];
	export BDIDParentName := 'BKSearch';
	
	//CaseNumber Key
	export CaseNumberKey := ['case_number', 'filing_state', 'tmsid'];
	export CaseNumberParent := ['left.case_number', 'left.filing_jurisdiction', 'left.tmsid'];
	export CaseNumberIgnoredFields := ['__internal_fpos__', 'qa_defined_empty'];
	export CaseNumberUniqueField := ['tmsid'];
	export CaseNumberParentName := 'BKMain';
	
	//DID Key
	export DIDKey := [ 'tmsid', 'court_code', 'case_number'];
	export DIDParent := [ 'left.tmsid', 'left.court_code', 'left.case_number'];
	export DIDIgnoredFields := ['did', '__internal_fpos__', 'qa_defined_empty'];
	export DIDUniqueField := ['tmsid'];
	export DIDParentName := 'BKSearch+BKMain';
	
	//Supp Key
	export SuppKey := [  'tmsid', 'method_dismiss', 'case_status'];
	export SuppParent := [ 'left.tmsid', 'left.method_dismiss', 'left.case_status'];
	export SuppIgnoredFields := ['__internal_fpos__', 'qa_defined_empty'];
	export SuppUniqueField := ['tmsid'];
	export SuppParentName := 'BKMainSupp';
	
	//SSN Key
	export SSNKey := [  'tmsid', 'ssn'];
	export SSNParent1 := [ 'left.tmsid', 'if((unsigned6)left.ssn <> 0,left.ssn, left.app_ssn)'];
	export SSNParent2 := [ 'left.tmsid', 'left.app_ssn'];
	export SSNIgnoredFields := ['__internal_fpos__', 'qa_defined_empty'];
	export SSNUniqueField := ['tmsid'];
	export SSNParentName := 'BKSearch+BKMain';
	
	//SSN4St Key
	export SSN4StKey := [  'ssnlast4', 'state', 'lname', 'fname', 'tmsid'];
	export SSN4StParent := [ 'left.ssnlast4', 'left.state', 'left.lname', 'left.fname', 'left.tmsid'];
	export SSN4StIgnoredFields := ['__internal_fpos__', 'qa_defined_empty'];
	export SSN4StUniqueField := ['tmsid'];
	export SSN4StParentName := 'BKSearch';
	
	//SSNMatch Key
	export SSNMatchKey := [  'tmsid', 'ssnmatch'];
	export SSNMatchParent := [ 'left.tmsid', 'left.ssnmatch'];
	export SSNMatchIgnoredFields := ['__internal_fpos__', 'qa_defined_empty'];
	export SSNMatchUniqueField := ['tmsid'];
	export SSNMatchParentName := 'BKSearch';
	
	//TrusteeIDName Key
	export TrusteeIDNameKeySet := [  'tmsid', 'trusteeid'];
	export TrusteeIDNameParentSet := [ 'left.tmsid', 'left.trusteeid'];
	export TrusteeIDNameIgnoredFields := ['__internal_fpos__', 'qa_defined_empty'];
	export TrusteeIDNameUniqueField := ['tmsid'];
	export TrusteeIDNameParentName := 'BKMain';
	
	//TMSIDBKSearch Key
	 export TMSIDBKSearchKey := [ 'tmsid', 'process_date', 'caseid', 'defendantid', 'recid', 'seq_number', 'court_code', 'case_number', 'orig_case_number', 'chapter', 
	 'filing_type', 'business_flag', 'corp_flag', 'discharged', 'disposition', 'pro_se_ind', 'converted_date', 'orig_county', 'debtor_type', 
	 'debtor_seq', 'ssn', 'ssnsrc', 'ssnmatch', 'ssnmsrc', 'screen', 'dcode', 'disptype', 'dispreason', 'statusdate', 'holdcase', 'datevacated', 
	 'datetransferred', 'activityreceipt', 'tax_id', 'name_type', 'orig_name', 'orig_fname', 'orig_mname', 'orig_lname', 'orig_name_suffix', 
	 'title', 'fname', 'mname', 'lname', 'name_suffix', 'name_score', 'cname', 'orig_company', 'orig_addr1', 'orig_addr2', 'orig_city', 'orig_st', 
	 'orig_zip5', 'orig_zip4', 'orig_email', 'orig_fax', 'prim_range', 'predir', 'prim_name', 'addr_suffix', 'postdir', 'unit_desig', 'sec_range', 
	 'p_city_name', 'v_city_name', 'st', 'zip', 'zip4', 'cart', 'cr_sort_sz', 'lot', 'lot_order', 'dbpc', 'chk_digit', 'rec_type', 'county', 'geo_lat', 
	 'geo_long', 'msa', 'geo_blk', 'geo_match', 'err_stat', 'phone', 'did', 'bdid', 'app_ssn', 'app_tax_id', 'date_first_seen', 'date_last_seen', 
	 'date_vendor_first_reported', 'date_vendor_last_reported', 'disptypedesc', 'srcdesc', 'srcmtchdesc', 'screendesc', 'dcodedesc', 
	 'date_filed', 'record_type', 'delete_flag', 'dotid', 'dotscore', 'dotweight', 'empid', 'empscore', 'empweight', 'powid', 'powscore', 
	 'powweight', 'proxid', 'proxscore', 'proxweight', 'seleid', 'selescore', 'seleweight', 'orgid', 'orgscore', 'orgweight', 'ultid', 'ultscore', 
	 'ultweight', 'source_rec_id' ];
	 export TMSIDBKSearchParent := [ 'left.tmsid', 'left.process_date', 'left.caseid', 'left.defendantid', 'left.recid', 'left.seq_number', 'left.court_code', 
	 'left.case_number', 'left.orig_case_number', 'left.chapter', 'left.filing_type', 'left.business_flag', 'left.corp_flag', 'left.discharged', 'left.disposition', 
	 'left.pro_se_ind', 'left.converted_date', 'left.orig_county', 'left.debtor_type', 'left.debtor_seq', 'left.ssn', 'left.ssnsrc', 'left.ssnmatch', 'left.ssnmsrc', 
	 'left.screen', 'left.dcode', 'left.disptype', 'left.dispreason', 'left.statusdate', 'left.holdcase', 'left.datevacated', 'left.datetransferred', 'left.activityreceipt', 
	 'left.tax_id', 'left.name_type', 'left.orig_name', 'left.orig_fname', 'left.orig_mname', 'left.orig_lname', 'left.orig_name_suffix', 'left.title', 'left.fname', 
	 'left.mname', 'left.lname', 'left.name_suffix', 'left.name_score', 'left.cname', 'left.orig_company', 'left.orig_addr1', 'left.orig_addr2', 'left.orig_city', 
	 'left.orig_st', 'left.orig_zip5', 'left.orig_zip4', 'left.orig_email', 'left.orig_fax', 'left.prim_range', 'left.predir', 'left.prim_name', 'left.addr_suffix', 
	 'left.postdir', 'left.unit_desig', 'left.sec_range', 'left.p_city_name', 'left.v_city_name', 'left.st', 'left.zip', 'left.zip4', 'left.cart', 'left.cr_sort_sz', 'left.lot', 
	 'left.lot_order', 'left.dbpc', 'left.chk_digit', 'left.rec_type', 'left.county', 'left.geo_lat', 'left.geo_long', 'left.msa', 'left.geo_blk', 'left.geo_match', 
	 'left.err_stat', 'left.phone', 'left.did', 'left.bdid', 'left.app_ssn', 'left.app_tax_id', 'left.date_first_seen', 'left.date_last_seen', 
	 'left.date_vendor_first_reported',  'left.date_vendor_last_reported', 'left.disptypedesc', 'left.srcdesc', 'left.srcmtchdesc', 'left.screendesc', 
	 'left.dcodedesc', 'left.date_filed', 'left.record_type', 'left.delete_flag', 'left.dotid', 'left.dotscore', 'left.dotweight', 'left.empid', 'left.empscore', 
	 'left.empweight', 'left.powid', 'left.powscore', 'left.powweight', 'left.proxid', 'left.proxscore', 'left.proxweight', 'left.seleid', 'left.selescore', 
	 'left.seleweight', 'left.orgid', 'left.orgscore', 'left.orgweight', 'left.ultid', 'left.ultscore', 'left.ultweight', 'left.source_rec_id' ];
	 export TMSIDBKSearchIgnoredFields := ['qa_defined_empty'];
	 export TMSIDBKSearchUniqueField := ['tmsid'];
	 export TMSIDBKSearchParentName := 'BKSearch';
	 
	 //TMSIDBKMain Key
	 export TMSIDBKMainKeySet := [ 'process_date', 'tmsid', 'source', 'id', 'seq_number', 'date_created', 'date_modified', 'method_dismiss', 
	 'case_status', 'court_code', 'court_name', 'court_location', 'case_number', 'orig_case_number', 'date_filed', 'filing_status', 'orig_chapter', 
	 'orig_filing_date', 'assets_no_asset_indicator', 'filer_type', 'meeting_date', 'meeting_time', 'address_341', 'claims_deadline', 'complaint_deadline',
	 'judge_name', 'judges_identification', 'filing_jurisdiction', 'assets', 'liabilities', 'casetype', 'assoccode', 'splitcase', 'filedinerror', 'date_last_seen',
	 'date_first_seen', 'date_vendor_first_reported', 'date_vendor_last_reported', 'reopen_date', 'case_closing_date', 'datereclosed', 'trusteename',
	 'trusteeaddress', 'trusteecity', 'trusteestate', 'trusteezip', 'trusteezip4', 'trusteephone', 'trusteeid', 'caseid', 'bardate', 'transferin', 'trusteeemail',
	 'planconfdate', 'confheardate', 'title', 'fname', 'mname', 'lname', 'name_suffix', 'name_score', 'prim_range', 'predir', 'prim_name', 'addr_suffix', 
	 'postdir', 'unit_desig', 'sec_range', 'p_city_name', 'v_city_name', 'st', 'zip', 'zip4', 'cart', 'cr_sort_sz', 'lot', 'lot_order', 'dbpc', 'chk_digit', 'rec_type',
	 'county', 'geo_lat', 'geo_long', 'msa', 'geo_blk', 'geo_match', 'err_stat', 'did', 'app_ssn', 'delete_flag', 'status__status_date', 
	 'status__status_type', 'comments__filing_date', 'comments__description'  ];
	 export TMSIDBKMainParentSet := [ 'left.process_date', 'left.tmsid', 'left.source', 'left.id', 'left.seq_number', 'left.date_created', 'left.date_modified', 
	 'left.method_dismiss', 'left.case_status', 'left.court_code', 'left.court_name', 'left.court_location', 'left.case_number', 'left.orig_case_number',
	 'left.date_filed', 'left.filing_status', 'left.orig_chapter', 'left.orig_filing_date', 'left.assets_no_asset_indicator', 'left.filer_type', 'left.meeting_date', 
	 'left.meeting_time', 'left.address_341', 'left.claims_deadline', 'left.complaint_deadline', 'left.judge_name', 'left.judges_identification',
	 'left.filing_jurisdiction', 'left.assets', 'left.liabilities', 'left.casetype', 'left.assoccode', 'left.splitcase', 'left.filedinerror', 'left.date_last_seen', 
	 'left.date_first_seen', 'left.date_vendor_first_reported', 'left.date_vendor_last_reported', 'left.reopen_date', 'left.case_closing_date', 
	 'left.datereclosed', 'left.trusteename', 'left.trusteeaddress', 'left.trusteecity', 'left.trusteestate', 'left.trusteezip', 'left.trusteezip4', 'left.trusteephone', 
	 'left.trusteeid', 'left.caseid', 'left.bardate', 'left.transferin', 'left.trusteeemail', 'left.planconfdate', 'left.confheardate', 'left.title', 'left.fname',
	 'left.mname', 'left.lname', 'left.name_suffix', 'left.name_score', 'left.prim_range', 'left.predir', 'left.prim_name', 'left.addr_suffix', 'left.postdir', 
	 'left.unit_desig', 'left.sec_range', 'left.p_city_name', 'left.v_city_name', 'left.st', 'left.zip', 'left.zip4', 'left.cart', 'left.cr_sort_sz', 'left.lot', 'left.lot_order',
	 'left.dbpc', 'left.chk_digit', 'left.rec_type', 'left.county', 'left.geo_lat', 'left.geo_long', 'left.msa', 'left.geo_blk', 'left.geo_match', 'left.err_stat', 'left.did',
	 'left.app_ssn', 'left.delete_flag', 'left.status__status_date', 'left.status__status_type', 'left.comments__filing_date', 'left.comments__description' ];
	 export TMSIDBKMainIgnoredFields := ['__internal_fpos__', 'qa_defined_empty'];
	 export TMSIDBKMainUniqueField := ['tmsid'];
	 export TMSIDBKMainParentName := 'BKMain';
	 
	 //LinkIDSBKSearch Key
	 export LinkIDSBKSearchKeySet := [ 'ultid', 'orgid', 'seleid', 'proxid', 'powid', 'empid', 'dotid', 'ultscore', 'orgscore', 'selescore', 'proxscore', 'powscore', 
	 'empscore', 'dotscore', 'ultweight', 'orgweight', 'seleweight', 'proxweight', 'powweight', 'empweight', 'dotweight', 'process_date', 'caseid', 'defendantid',
	 'recid', 'tmsid', 'seq_number', 'court_code', 'case_number', 'orig_case_number', 'chapter', 'filing_type', 'business_flag', 'corp_flag', 'discharged',
	 'disposition', 'pro_se_ind', 'converted_date', 'orig_county', 'debtor_type', 'debtor_seq', 'ssn', 'ssnsrc', 'ssnmatch', 'ssnmsrc', 'screen', 'dcode', 'disptype',
	 'dispreason', 'statusdate', 'holdcase', 'datevacated', 'datetransferred', 'activityreceipt', 'tax_id', 'name_type', 'orig_name', 'orig_fname', 'orig_mname',
	 'orig_lname', 'orig_name_suffix', 'title', 'fname', 'mname', 'lname', 'name_suffix', 'name_score', 'cname', 'orig_company', 'orig_addr1', 'orig_addr2', 
	 'orig_city', 'orig_st', 'orig_zip5', 'orig_zip4', 'orig_email', 'orig_fax', 'prim_range', 'predir', 'prim_name', 'addr_suffix', 'postdir', 'unit_desig', 'sec_range', 
	 'p_city_name', 'v_city_name', 'st', 'zip', 'zip4', 'cart', 'cr_sort_sz', 'lot', 'lot_order', 'dbpc', 'chk_digit', 'rec_type', 'county', 'geo_lat', 'geo_long', 'msa', 
	 'geo_blk', 'geo_match', 'err_stat', 'phone', 'did', 'bdid', 'app_ssn', 'app_tax_id', 'date_first_seen', 'date_last_seen', 'date_vendor_first_reported', 
	 'date_vendor_last_reported', 'disptypedesc', 'srcdesc', 'srcmtchdesc', 'screendesc', 'dcodedesc', 'date_filed', 'record_type', 'delete_flag', 'source_rec_id' ];
	 export LinkIDSBKSearchParentSet := [ 'left.ultid', 'left.orgid', 'left.seleid', 'left.proxid', 'left.powid', 'left.empid', 'left.dotid', 'left.ultscore', 'left.orgscore', 
	 'left.selescore', 'left.proxscore', 'left.powscore', 'left.empscore', 'left.dotscore', 'left.ultweight', 'left.orgweight', 'left.seleweight', 'left.proxweight', 
	 'left.powweight', 'left.empweight', 'left.dotweight', 'left.process_date', 'left.caseid', 'left.defendantid', 'left.recid', 'left.tmsid', 'left.seq_number', 
	 'left.court_code', 'left.case_number', 'left.orig_case_number', 'left.chapter', 'left.filing_type', 'left.business_flag', 'left.corp_flag', 'left.discharged', 
	 'left.disposition', 'left.pro_se_ind', 'left.converted_date', 'left.orig_county', 'left.debtor_type', 'left.debtor_seq', 'left.ssn', 'left.ssnsrc', 'left.ssnmatch', 
	 'left.ssnmsrc', 'left.screen', 'left.dcode', 'left.disptype', 'left.dispreason', 'left.statusdate', 'left.holdcase', 'left.datevacated', 'left.datetransferred', 
	 'left.activityreceipt', 'left.tax_id', 'left.name_type', 'left.orig_name', 'left.orig_fname', 'left.orig_mname', 'left.orig_lname', 'left.orig_name_suffix', 
	 'left.title', 'left.fname', 'left.mname', 'left.lname', 'left.name_suffix', 'left.name_score', 'left.cname', 'left.orig_company', 'left.orig_addr1', 'left.orig_addr2', 
	 'left.orig_city', 'left.orig_st', 'left.orig_zip5', 'left.orig_zip4', 'left.orig_email', 'left.orig_fax', 'left.prim_range', 'left.predir', 'left.prim_name', 'left.addr_suffix',
	 'left.postdir', 'left.unit_desig', 'left.sec_range', 'left.p_city_name', 'left.v_city_name', 'left.st', 'left.zip', 'left.zip4', 'left.cart', 'left.cr_sort_sz', 'left.lot', 
	 'left.lot_order', 'left.dbpc', 'left.chk_digit', 'left.rec_type', 'left.county', 'left.geo_lat', 'left.geo_long', 'left.msa', 'left.geo_blk', 'left.geo_match', 'left.err_stat', 
	 'left.phone', 'left.did', 'left.bdid', 'left.app_ssn', 'left.app_tax_id', 'left.date_first_seen', 'left.date_last_seen', 'left.date_vendor_first_reported',
	 'left.date_vendor_last_reported', 'left.disptypedesc', 'left.srcdesc', 'left.srcmtchdesc', 'left.screendesc', 'left.dcodedesc', 'left.date_filed', 'left.record_type', 
	 'left.delete_flag', 'left.source_rec_id' ];
	 export LinkIDSBKSearchIgnoredFields := ['fp', 'qa_defined_empty'];
	 export LinkIDSBKSearchUniqueField := ['tmsid'];
	 export LinkIDSBKSearchParentName := 'BKSearch';
	 
	 
	//**********************************************************************************************************************************//
	//***********************************************AUTO KEYS***********************************************************************//
	
	//PayloadAK Key
	export PayloadAKKeySet :=[ 'name_type', 'party_bits', 'zero', 'tmsid', 'intdid', 'intbdid', 'cname', 'ssn', 'tax_id',
	'company_addr__prim_range', 'company_addr__predir', 'company_addr__prim_name', 'company_addr__addr_suffix', 
	'company_addr__postdir', 'company_addr__unit_desig', 'company_addr__sec_range', 'company_addr__v_city_name', 
	'company_addr__st', 'company_addr__zip5', 'company_addr__zip4', 'company_addr__addr_rec_type', 'company_addr__fips_state', 
	'company_addr__fips_county', 'company_addr__geo_lat', 'company_addr__geo_long', 'company_addr__cbsa', 
	'company_addr__geo_blk', 'company_addr__geo_match', 'company_addr__err_stat', 'person_addr__prim_range', 'person_addr__predir', 
	'person_addr__prim_name', 'person_addr__addr_suffix', 'person_addr__postdir', 'person_addr__unit_desig', 'person_addr__sec_range', 
	'person_addr__v_city_name', 'person_addr__st', 'person_addr__zip5', 'person_addr__zip4', 'person_addr__addr_rec_type', 
	'person_addr__fips_state', 'person_addr__fips_county', 'person_addr__geo_lat', 'person_addr__geo_long', 'person_addr__cbsa', 
	'person_addr__geo_blk', 'person_addr__geo_match', 'person_addr__err_stat', 'person_name__title', 'person_name__fname', 'person_name__mname', 
	'person_name__lname', 'person_name__name_suffix', 'person_name__name_score']; 
	export PayloadAKParentSet := [  'left.name_type', 'left.party_bits', 'left.zero', 'left.tmsid', 'left.intdid', 'left.intbdid', 'left.cname', 'left.ssn', 'left.tax_id', 
	'left.company_addr__prim_range', 'left.company_addr__predir', 'left.company_addr__prim_name', 'left.company_addr__addr_suffix', 
	'left.company_addr__postdir', 'left.company_addr__unit_desig', 'left.company_addr__sec_range', 'left.company_addr__v_city_name', 
	'left.company_addr__st', 'left.company_addr__zip5', 'left.company_addr__zip4', 'left.company_addr__addr_rec_type', 'left.company_addr__fips_state', 
	'left.company_addr__fips_county', 'left.company_addr__geo_lat', 'left.company_addr__geo_long', 'left.company_addr__cbsa', 
	'left.company_addr__geo_blk', 'left.company_addr__geo_match', 'left.company_addr__err_stat', 'left.person_addr__prim_range', 
	'left.person_addr__predir', 'left.person_addr__prim_name', 'left.person_addr__addr_suffix', 'left.person_addr__postdir', 
	'left.person_addr__unit_desig', 'left.person_addr__sec_range', 'left.person_addr__v_city_name', 'left.person_addr__st', 'left.person_addr__zip5', 
	'left.person_addr__zip4', 'left.person_addr__addr_rec_type', 'left.person_addr__fips_state', 'left.person_addr__fips_county', 
	'left.person_addr__geo_lat', 'left.person_addr__geo_long', 'left.person_addr__cbsa', 'left.person_addr__geo_blk', 'left.person_addr__geo_match', 
	'left.person_addr__err_stat', 'left.person_name__title', 'left.person_name__fname', 'left.person_name__mname', 'left.person_name__lname', 
	'left.person_name__name_suffix', 'left.person_name__name_score' ];
	export PayloadAKignoredFields := ['fakeid', '__internal_fpos__', 'qa_defined_empty'];
	export PayloadAKUniqueField := ['tmsid'];
	export PayloadAKParentName := 'BKSearch';
	
	//AddressAK Key
	export AddressAKKey := ['prim_name', 'prim_range', 'st', 'zip', 'sec_range', 'did'];
	export AddressAKParent := ['ut.stripOrdinal(left.person_addr.prim_name)', 
																					 'TRIM(ut.CleanPrimRange(left.person_addr.prim_range),left)', 
																					 'left.person_addr.st',  'left.person_addr.zip5', 
																					 'left.person_addr.sec_range', 'left.fakeid'];
	export AddressAKIgnoredFields := ['city_code', 'dph_lname', 'lname', 'pfname', 'fname', 
																					 'states', 'lname1', 'lname2', 'lname3', 'lookups', 'qa_defined_empty'];
	export AddressAKUniqueField := ['did'];
	export AddressAKParentName := 'BKPayloadAutoKey';
	
	//Addressb2AK Key
	export Addressb2AKKey := ['prim_name', 'prim_range',  'st', 'zip', 'sec_range', 'bdid'];
	export Addressb2AKParent := ['ut.stripOrdinal(left.person_addr.prim_name)', 
																					 'TRIM(ut.CleanPrimRange(left.person_addr.prim_range),left)',  
																					 'left.person_addr.st',  'left.person_addr.zip5', 
																					 'left.person_addr.sec_range', 'left.fakeid'];
	export Addressb2AKIgnoredFields := ['city_code', 'cname_indic', 'cname_sec', 'lookups', 'qa_defined_empty' ];
	export Addressb2AKUniqueField := ['bdid'];
	export Addressb2AKParentName := 'BKPayloadAutoKey';
	
	//CityStNameAK Key
	export CityStNameAKKey := ['st', 'fname', 'dob', 'did'];
	export CityStNameAKParent := [ 'left.person_addr.st', 'left.person_name.fname', '0', 'left.fakeid'];
	export CityStNameAKIgnoredFields := ['city_code', 'lname', 'dph_lname', 'pfname', 'states', 'lname1', 
																					 'lname2', 'lname3', 'city1', 'city2', 'city3', 'rel_fname1', 'rel_fname2', 
																					 'rel_fname3', 'lookups', 'qa_defined_empty'];
	export CityStNameAKUniqueField := ['did'];
	export CityStNameAKParentName := 'BKPayloadAutoKey';
	
	//CityStNameb2AK Key
	export CityStNameb2AKKey := ['st', 'bdid'];
	export CityStNameb2AKParent := ['left.person_addr.st', 'left.fakeid'];
	export CityStNameb2AKIgnoredFields := ['city_code', ' cname_indic', ' cname_sec', ' lookups', ' qa_defined_empty'];
	export CityStNameb2AKUniqueField := ['bdid'];
	export CityStNameb2AKParentName := 'BKPayloadAutoKey';

	//FEIN2AK Key
	export FEIN2AKKey := ['f1','f2','f3','f4','f5','f6','f7','f8','f9', 'bdid'];
	export FEIN2AKParent := [ 'left.tax_id[1]', 'left.tax_id[2]', 'left.tax_id[3]', 'left.tax_id[4]', 
																					 'left.tax_id[5]', 'left.tax_id[6]', 'left.tax_id[7]', 'left.tax_id[8]', 'left.tax_id[9]', 'left.fakeid'];
	export FEIN2AKIgnoredFields := ['cname_indic', ' cname_sec', ' lookups', ' qa_defined_empty'];
	export FEIN2AKUniqueField := ['bdid'];
	export FEIN2AKParentName := 'BKPayloadAutoKey';
	
	//NameAK Key
	export NameAKKey := ['fname', 'minit', 's4',  'dob',  'did'];
	export NameAKParent := [ 'left.person_name.fname', 'left.person_name.mname[1]', 
																					 '(unsigned)(((string)left.ssn)[6..9])', '0', 'left.fakeid'];
	export NameAKIgnoredFields := ['dph_lname', ' lname', ' pfname', ' yob', ' states', ' lname1', ' lname2', 
																					 ' lname3', ' city1', ' city2', ' city3', ' rel_fname1', ' rel_fname2', 
																					 ' rel_fname3', ' lookups', ' qa_defined_empty' ];
	export NameAKUniqueField := ['did'];
	export NameAKParentName := 'BKPayloadAutoKey';
	
	//NameWords2AK Key
	export NameWords2AKKey := ['state', 'bdid'];
	export NameWords2AKParent := [ 'left.person_addr.st', 'left.fakeid'];
	export NameWords2AKIgnoredFields := ['word', 'seq', 'lookups', ' qa_defined_empty' ];
	export NameWords2AKUniqueField := ['bdid'];
	export NameWords2AKParentName := 'BKPayloadAutoKey';
	
	//SSN4NameAK Key
	export SSN4NameAKKey := ['s6','s7','s8','s9', 'fname', 'minit', 'did'];
	export SSN4NameAKParent := [ 'if(length(trim(left.ssn, left, right))=4,left.ssn[1], left.ssn[6])', 
																					 'if(length(trim(left.ssn, left, right))=4,left.ssn[2], left.ssn[7])', 
																					 'if(length(trim(left.ssn, left, right))=4,left.ssn[3], left.ssn[8])', 
																					 'if(length(trim(left.ssn, left, right))=4,left.ssn[4], left.ssn[9])',  
																					 'left.person_name.fname', 'left.person_name.mname[1]', 'left.fakeid'];
	export SSN4NameAKIgnoredFields := ['dph_lname', ' lname', ' pfname', ' qa_defined_empty'];
	export SSN4NameAKUniqueField := ['did'];
	export SSN4NameAKParentName := 'BKPayloadAutoKey';
	
	//SSN2AK Key
	export SSN2AKKey := ['s1','s2','s3','s4','s5','s6','s7','s8','s9', 'did'];
	export SSN2AKParent := [ 'left.ssn[1]', 'left.ssn[2]', 'left.ssn[3]', 'left.ssn[4]', 
																					 'left.ssn[5]', 'left.ssn[6]', 'left.ssn[7]', 'left.ssn[8]', 
																					 'left.ssn[9]', 'left.fakeid'];
	export SSN2AKIgnoredFields := ['dph_lname', ' pfname', 'lookups', ' qa_defined_empty'];
	export SSN2AKUniqueField := ['did'];
	export SSN2AKParentName := 'BKPayloadAutoKey';
	
	//StNameAK Key
	export StNameAKKey := ['st', 'fname','minit', 's4', 'zip', 'dob',  'did'];
	export StNameAKParent := [ 'left.person_addr.st', 'left.person_name.fname', 
																					 'left.person_name.mname[1]', '(unsigned)(((string)left.ssn)[6..9])', 
																					 '(integer4)left.person_addr.zip5',  '0', 'left.fakeid'];
	export StNameAKIgnoredFields := ['dph_lname', ' lname', ' pfname', ' yob', ' states', ' lname1', ' lname2', 
																					 ' lname3', ' city1', ' city2', ' city3', ' rel_fname1', ' rel_fname2', 
																					 ' rel_fname3', ' lookups', ' qa_defined_empty' ];
	export StNameAKUniqueField := ['did'];
	export StNameAKParentName := 'BKPayloadAutoKey';
	
  //StNameb2AK Key
	export StNameb2AKKey := ['st', 'bdid'];
	export StNameb2AKParent := ['left.person_addr.st', 'left.fakeid'];
	export StNameb2AKIgnoredFields := ['cname_indic', ' cname_sec', ' lookups', ' qa_defined_empty'];
	export StNameb2AKUniqueField := ['bdid'];
	export StNameb2AKParentName := 'BKPayloadAutoKey';
	
	//ZipAK Key
	export ZipAKKey := [ 'fname','minit', 's4', 'dob', 'zip', 'did'];
	export ZipAKParent := [ 'left.person_name.fname', 'left.person_name.mname[1]', 
																					 '(unsigned)(((string)left.ssn)[6..9])', '0', 
																					 '(integer4)left.person_addr.zip5', 'left.fakeid'];
	export ZipAKIgnoredFields := ['dph_lname', ' lname', ' pfname', ' yob', ' states', ' lname1', 
																					 ' lname2', ' lname3', ' city1', ' city2', ' city3', ' rel_fname1', 
																					 ' rel_fname2', ' rel_fname3', ' lookups', ' qa_defined_empty'];
	export ZipAKUniqueField := ['did'];
	export ZipAKParentName := 'BKPayloadAutoKey';
	
	//Zipb2AK Key
	export Zipb2AKKey := ['zip', 'bdid'];
	export Zipb2AKParent := [ '(integer4)left.person_addr.zip5', 'left.fakeid'];
	export Zipb2AKIgnoredFields := ['cname_indic', ' cname_sec', ' lookups', ' qa_defined_empty' ];
	export Zipb2AKUniqueField := ['bdid'];
	export Zipb2AKParentName := 'BKPayloadAutoKey';
	
	
end;