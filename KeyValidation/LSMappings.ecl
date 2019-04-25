//************************************************************************************************************************************//
//Mapping information - LiensV2 Keys to Parent
//************************************************************************************************************************************//
EXPORT LSMappings := MODULE

	//BDID Key
	export BDIDKeyName := 'bdid';
	export BDIDKeyType := 'Search Key';
	export BDIDKeySet :=  ['p_bdid', 'tmsid', 'rmsid'];
	export BDIDParentSet := [ '(integer)left.bdid', 'left.tmsid', 'left.rmsid'];
	export BDIDIgnoredFields := ['__internal_fpos__', 'qa_defined_empty'];
	export BDIDUniqueField := ['p_bdid'];
	export BDIDParentName := 'bdid';

	//CaseNumber Key
	export CNKeyName := 'case number';
	export CNKeyType := 'Search Key';
	export CNKeySet :=  ['case_number', 'filing_state', 'tmsid', 'rmsid' ];
	export CNParentSet := [ 'left.case_number', 'left.filing_state', 'left.tmsid', 'left.rmsid'];
	export CNIgnoredFields := ['__internal_fpos__', 'qa_defined_empty'];
	export CNUniqueField := ['tmsid'];
	export CNParentName := 'case_number';
	
	//did Key
	export didKeyName := 'did';
	export didKeyType := 'Search Key';
	export didKeySet :=  ['did', 'tmsid', 'rmsid'];
	export didParentSet := [ '(integer)left.did','left.tmsid', 'left.rmsid'];
	export didIgnoredFields := ['__internal_fpos__', 'qa_defined_empty'];
	export didUniqueField := ['did'];
	export didParentName := 'did';

	//Filing Number Key
	export FNKeyName := 'Filing Number';
	export FNKeyType := 'Search Key';
	export FNKeySet :=  ['filing_number', 'filing_state','tmsid', 'rmsid'];
	export FNParentSet := [ 'left.filing_number','left.filing_state','left.tmsid', 'left.rmsid'];
	export FNIgnoredFields := ['__internal_fpos__', 'qa_defined_empty'];
	export FNUniqueField := ['tmsid'];
	export FNParentName := 'filing_number';	

	// Certificate Number Key
	export CTNKeyName := 'Certificate Number';
	export CTNKeyType := 'Search Key';
	export CTNKeySet :=  ['certificate_number','tmsid', 'rmsid'];
	export CTNParentSet := [ 'left.certificate_number','left.tmsid', 'left.rmsid'];
	export CTNIgnoredFields := ['__internal_fpos__', 'qa_defined_empty'];
	export CTNUniqueField := ['tmsid'];
	export CTNParentName := 'certificate_number';	
	
	// Serial Number Key
	export SNKeyName := 'Serial Number';
	export SNKeyType := 'Search Key';
	export SNKeySet :=  ['irs_serial_number','agency_state','tmsid', 'rmsid'];
	export SNParentSet := [ 'left.irs_serial_number','left.agency_state','left.tmsid', 'left.rmsid'];
	export SNIgnoredFields := ['__internal_fpos__', 'qa_defined_empty'];
	export SNUniqueField := ['tmsid'];
	export SNParentName := 'serial_number';	
	
	// rmsid Key
	export rmsidKeyName := 'rmsid';
	export rmsidKeyType := 'Search Key';
	export rmsidKeySet :=  ['tmsid', 'rmsid'];
	export rmsidParentSet := ['left.tmsid', 'left.rmsid'];
	export rmsidIgnoredFields := ['__internal_fpos__', 'qa_defined_empty'];
	export rmsidUniqueField := ['rmsid'];
	export rmsidParentName := 'rmsid';	

	// tmsid.rmsid Key
	export TRKeyName := 'TMSID.RMSID';
	export TRKeyType := 'Payload Key';
	export TRKeySet :=  [ 'tmsid', 'rmsid', 'process_date', 'record_code', 'date_vendor_removed', 'filing_jurisdiction', 'filing_state', 'orig_filing_number', 'orig_filing_type', 
	                      'orig_filing_date', 'orig_filing_time', 'case_number', 'filing_number', 'filing_type_desc', 'filing_date', 'filing_time', 'vendor_entry_date', 'judge', 
												'case_title', 'filing_book', 'filing_page', 'release_date', 'amount', 'eviction', 'satisifaction_type', 'judg_satisfied_date', 'judg_vacated_date', 
												'tax_code', 'irs_serial_number', 'effective_date', 'lapse_date', 'accident_date', 'sherrif_indc', 'expiration_date', 'agency', 'agency_city', 
												'agency_state', 'agency_county', 'legal_lot', 'legal_block', 'legal_borough', 'certificate_number', 'persistent_record_id', 
												'filing_status__filing_status', 'filing_status__filing_status_desc' ];
	export TRParentSet := [ 'left.tmsid', 'left.rmsid', 'left.process_date', 'left.record_code', 'left.date_vendor_removed', 'left.filing_jurisdiction', 'left.filing_state', 
	                        'left.orig_filing_number', 'left.orig_filing_type', 'left.orig_filing_date', 'left.orig_filing_time', 'left.case_number', 'left.filing_number', 
													'left.filing_type_desc', 'left.filing_date', 'left.filing_time', 'left.vendor_entry_date', 'left.judge', 'left.case_title', 'left.filing_book', 
													'left.filing_page', 'left.release_date', 'left.amount', 'left.eviction', 'left.satisifaction_type', 'left.judg_satisfied_date', 
													'left.judg_vacated_date', 'left.tax_code', 'left.irs_serial_number', 'left.effective_date', 'left.lapse_date', 'left.accident_date', 
													'left.sherrif_indc', 'left.expiration_date', 'left.agency', 'left.agency_city', 'left.agency_state', 'left.agency_county', 
	                        'left.legal_lot', 'left.legal_block', 'left.legal_borough', 'left.certificate_number', 'left.persistent_record_id', 
													'left.filing_status__filing_status', 'left.filing_status__filing_status_desc' ];
	export TRIgnoredFields := ['__internal_fpos__', 'qa_defined_empty'];
	export TRUniqueField := ['rmsid'];
	export TRParentName := 'tmsid_rmsid_Main';	
  
	// Linksid Key
	export linksidKeyName := 'linksid';
	export linksidKeyType := 'Search Key';
	export linksidKeySet :=  [ 'ultid', 'orgid', 'seleid', 'proxid', 'powid', 'empid', 'dotid', 'ultscore', 'orgscore', 'selescore', 'proxscore', 'powscore', 'empscore',
														 'dotscore', 'ultweight', 'orgweight', 'seleweight', 'proxweight', 'powweight', 'empweight', 'dotweight', 'tmsid', 'rmsid', 'orig_full_debtorname', 
														 'orig_name', 'orig_lname', 'orig_fname', 'orig_mname', 'orig_suffix', 'tax_id', 'ssn', 'title', 'fname', 'mname', 'lname', 'name_suffix', 
														 'name_score', 'cname', 'orig_address1', 'orig_address2', 'orig_city', 'orig_state', 'orig_zip5', 'orig_zip4', 'orig_county', 'orig_country', 
														 'prim_range', 'predir', 'prim_name', 'addr_suffix', 'postdir', 'unit_desig', 'sec_range', 'p_city_name', 'v_city_name', 'st', 'zip', 'zip4', 
														 'cart', 'cr_sort_sz', 'lot', 'lot_order', 'dbpc', 'chk_digit', 'rec_type', 'county', 'geo_lat', 'geo_long', 'msa', 'geo_blk', 'geo_match', 
														 'err_stat', 'phone', 'name_type', 'did', 'bdid', 'date_first_seen', 'date_last_seen', 'date_vendor_first_reported', 'date_vendor_last_reported', 
														 'persistent_record_id', 'app_ssn', 'app_tax_id' ];
	export linksidParentSet := [ 'left.ultid', 'left.orgid', 'left.seleid', 'left.proxid', 'left.powid', 'left.empid', 'left.dotid', 'left.ultscore', 'left.orgscore', 
	                             'left.selescore', 'left.proxscore', 'left.powscore', 'left.empscore', 'left.dotscore', 'left.ultweight', 'left.orgweight', 'left.seleweight', 
															 'left.proxweight', 'left.powweight', 'left.empweight', 'left.dotweight', 'left.tmsid', 'left.rmsid', 'left.orig_full_debtorname', 
															 'left.orig_name', 'left.orig_lname', 'left.orig_fname', 'left.orig_mname', 'left.orig_suffix', 'left.tax_id', 'left.ssn', 'left.title', 
															 'left.fname', 'left.mname', 'left.lname', 'left.name_suffix', 'left.name_score', 'left.cname', 'left.orig_address1', 'left.orig_address2', 
															 'left.orig_city', 'left.orig_state', 'left.orig_zip5', 'left.orig_zip4', 'left.orig_county', 'left.orig_country', 'left.prim_range', 
															 'left.predir', 'left.prim_name', 'left.addr_suffix', 'left.postdir', 'left.unit_desig', 'left.sec_range', 'left.p_city_name', 'left.v_city_name', 
															 'left.st', 'left.zip', 'left.zip4', 'left.cart', 'left.cr_sort_sz', 'left.lot', 'left.lot_order', 'left.dbpc', 'left.chk_digit', 'left.rec_type', 
															 'left.county', 'left.geo_lat', 'left.geo_long', 'left.msa', 'left.geo_blk', 'left.geo_match', 'left.err_stat', 'left.phone', 'left.name_type', 
															 'left.did', 'left.bdid', 'left.date_first_seen', 'left.date_last_seen', 'left.date_vendor_first_reported', 'left.date_vendor_last_reported', 
															 'left.persistent_record_id', 'left.app_ssn', 'left.app_tax_id'];
	export linksidIgnoredFields := ['fp','qa_defined_empty'];
	export linksidUniqueField := ['rmsid'];
	export linksidParentName := 'linksid';	

	// sourcerecid Key
	export sridKeyName := 'sourcerecid';
	export sridKeyType := 'Search Key';
	export sridKeySet :=  ['persistent_record_id','tmsid', 'rmsid'];
	export sridParentSet := ['left.persistent_record_id','left.tmsid', 'left.rmsid'];
	export sridIgnoredFields := ['__internal_fpos__','qa_defined_empty'];
	export sridUniqueField := ['tmsid'];
	export sridParentName := 'sourcerecid';	

	// tmsid.rmsid.linksid Key
	export trlKeyName := 'tmsid_rmsid_linksid';
	export trlKeyType := 'Search Key';
	export trlKeySet :=  [ 'tmsid', 'rmsid', 'orig_full_debtorname', 'orig_name', 'orig_lname', 'orig_fname', 'orig_mname', 'orig_suffix', 'tax_id', 'ssn', 'title', 'fname', 
	                       'mname', 'lname', 'name_suffix', 'name_score', 'cname', 'orig_address1', 'orig_address2', 'orig_city', 'orig_state', 'orig_zip5', 'orig_zip4', 
												 'orig_county', 'orig_country','prim_range', 'predir', 'prim_name', 'addr_suffix', 'postdir', 'unit_desig', 'sec_range', 'p_city_name', 'v_city_name', 
												 'st', 'zip', 'zip4', 'cart', 'cr_sort_sz', 'lot', 'lot_order', 'dbpc', 'chk_digit', 'rec_type', 'county', 'geo_lat', 'geo_long', 'msa', 'geo_blk', 
												 'geo_match', 'err_stat', 'phone', 'name_type', 'did', 'bdid', 'date_first_seen', 'date_last_seen', 'date_vendor_first_reported', 
												 'date_vendor_last_reported', 'persistent_record_id', 'dotid', 'dotscore', 'dotweight', 'empid', 'empscore', 'empweight', 'powid', 'powscore', 
												 'powweight', 'proxid', 'proxscore', 'proxweight', 'seleid', 'selescore', 'seleweight', 'orgid', 'orgscore', 'orgweight', 'ultid', 'ultscore', 
												 'ultweight' ];
	export trlParentSet := [ 'left.tmsid', 'left.rmsid', 'left.orig_full_debtorname', 'left.orig_name', 'left.orig_lname', 'left.orig_fname', 'left.orig_mname', 
	                         'left.orig_suffix', 'left.tax_id', 'left.ssn', 'left.title', 'left.fname', 'left.mname', 'left.lname', 'left.name_suffix', 'left.name_score', 
													 'left.cname', 'left.orig_address1', 'left.orig_address2', 'left.orig_city', 'left.orig_state', 'left.orig_zip5', 'left.orig_zip4', 'left.orig_county', 
													 'left.orig_country', 'left.prim_range', 'left.predir', 'left.prim_name', 'left.addr_suffix', 'left.postdir', 'left.unit_desig', 'left.sec_range', 
													 'left.p_city_name', 'left.v_city_name', 'left.st', 'left.zip', 'left.zip4', 'left.cart', 'left.cr_sort_sz', 'left.lot', 'left.lot_order', 'left.dbpc', 
													 'left.chk_digit', 'left.rec_type', 'left.county', 'left.geo_lat', 'left.geo_long', 'left.msa', 'left.geo_blk', 'left.geo_match', 'left.err_stat', 
													 'left.phone', 'left.name_type', 'left.did', 'left.bdid', 'left.date_first_seen', 'left.date_last_seen', 'left.date_vendor_first_reported', 
													 'left.date_vendor_last_reported', 'left.persistent_record_id', 'left.dotid', 'left.dotscore', 'left.dotweight', 'left.empid', 'left.empscore', 
													 'left.empweight', 'left.powid', 'left.powscore', 'left.powweight', 'left.proxid', 'left.proxscore', 'left.proxweight', 'left.seleid', 
													 'left.selescore', 'left.seleweight', 'left.orgid', 'left.orgscore', 'left.orgweight', 'left.ultid', 'left.ultscore', 'left.ultweight' ];
	export trlIgnoredFields := ['qa_defined_empty'];
	export trlUniqueField := ['tmsid'];
	export trlParentName := 'tmsid_rmsid_linksid';	
	
	// tmsid.rmsid.party Key
	export trpKeyName := 'linksid';
	export trpKeyType := 'Search Key';
	export trpKeySet :=  [ 'tmsid', 'rmsid', 'orig_full_debtorname', 'orig_name', 'orig_lname', 'orig_fname', 'orig_mname', 'orig_suffix', 'tax_id', 'ssn', 'title', 'fname', 
	                       'mname', 'lname', 'name_suffix', 'name_score', 'cname', 'orig_address1', 'orig_address2', 'orig_city', 'orig_state', 'orig_zip5', 'orig_zip4', 
												 'orig_county', 'orig_country', 'prim_range', 'predir', 'prim_name', 'addr_suffix', 'postdir', 'unit_desig', 'sec_range', 'p_city_name', 'v_city_name', 
												 'st', 'zip', 'zip4', 'cart', 'cr_sort_sz', 'lot', 'lot_order', 'dbpc', 'chk_digit', 'rec_type', 'county', 'geo_lat', 'geo_long', 'msa', 'geo_blk', 
												 'geo_match', 'err_stat', 'phone', 'name_type', 'did', 'bdid', 'date_first_seen', 'date_last_seen', 'date_vendor_first_reported', 
												 'date_vendor_last_reported', 'persistent_record_id', 'dotid', 'dotscore', 'dotweight', 'empid', 'empscore', 'empweight', 'powid', 'powscore', 
												 'powweight', 'proxid', 'proxscore', 'proxweight', 'seleid', 'selescore', 'seleweight', 'orgid', 'orgscore', 'orgweight', 'ultid', 'ultscore', 
												 'ultweight' ];
	export trpParentSet := [ 'left.tmsid', 'left.rmsid', 'left.orig_full_debtorname', 'left.orig_name', 'left.orig_lname', 'left.orig_fname', 'left.orig_mname', 
	                         'left.orig_suffix', 'left.tax_id', 'left.ssn', 'left.title', 'left.fname', 'left.mname', 'left.lname', 'left.name_suffix', 'left.name_score', 
													 'left.cname', 'left.orig_address1', 'left.orig_address2', 'left.orig_city', 'left.orig_state', 'left.orig_zip5', 'left.orig_zip4', 'left.orig_county',
													 'left.orig_country', 'left.prim_range', 'left.predir', 'left.prim_name', 'left.addr_suffix', 'left.postdir', 'left.unit_desig', 'left.sec_range', 
													 'left.p_city_name', 'left.v_city_name', 'left.st', 'left.zip', 'left.zip4', 'left.cart', 'left.cr_sort_sz', 'left.lot', 'left.lot_order', 'left.dbpc', 
													 'left.chk_digit', 'left.rec_type', 'left.county', 'left.geo_lat', 'left.geo_long', 'left.msa', 'left.geo_blk', 'left.geo_match', 'left.err_stat', 
													 'left.phone', 'left.name_type', 'left.did', 'left.bdid', 'left.date_first_seen', 'left.date_last_seen', 'left.date_vendor_first_reported', 
													 'left.date_vendor_last_reported', 'left.persistent_record_id', 'left.dotid', 'left.dotscore', 'left.dotweight', 'left.empid', 'left.empscore', 
													 'left.empweight', 'left.powid', 'left.powscore', 'left.powweight', 'left.proxid', 'left.proxscore', 'left.proxweight', 'left.seleid', 
													 'left.selescore', 'left.seleweight', 'left.orgid', 'left.orgscore', 'left.orgweight', 'left.ultid', 'left.ultscore', 'left.ultweight' ];
	export trpIgnoredFields := ['qa_defined_empty'];
	export trpUniqueField := ['tmsid'];
	export trpParentName := 'linksid';	
		
	//AutokeyZip Key
  export ZipAKKeyName := 'AutokeyZip';
	export ZipAKKeyType := 'Search Key';
	export ZipAKKeySet :=  ['lname', 'fname','s4', 'zip',  'did'];
	export ZipAKParentSet :=  ['left.person_name__lname', 'left.person_name__fname', '((integer4)left.ssn[6..9])','((integer4)left.person_addr__zip5)', 'left.fakeid'];
	export ZipAKIgnoredFields :=[ 'yob','dob','minit','dph_lname', 'pfname', 'states', 'lname1','lname2','lname3','city1','city2','city3','rel_fname1','rel_fname2','rel_fname3', 'lookups',
	                             'qa_defined_empty'];
	export ZipAKUniqueField :=['did'];
	export ZipAKParentName := 'AutokeyZip';	
	
	//Zipb2AK Key
	export Zipb2AKKeyName := 'AutokeyZipB2';
	export Zipb2AKKeyType := 'Search Key';
	export Zipb2AKKeySet := ['zip', 'bdid'];
	export Zipb2AKParentSet := [ '(integer4)left.person_addr__zip5', 'left.fakeid'];
	export Zipb2AKIgnoredFields := ['cname_indic', ' cname_sec', ' lookups', ' qa_defined_empty' ];
	export Zipb2AKUniqueField := ['bdid'];
	export Zipb2AKParentName := 'AutokeyZipB2';	
	
	//StNameAK Key
	export StNameAKKeyName := 'AutoKeyStName';
	export StNameAKKeyType := 'Search Key';
	export StNameAKKeySet := ['st', 'fname','minit', 's4', 'zip', 'dob',  'did'];
	export StNameAKParentSet := [ 'left.person_addr__st', 'left.person_name__fname', 
																					 'left.person_name__mname[1]', '(unsigned)(((string)left.ssn)[6..9])', 
																					 '(integer4)left.person_addr__zip5',  '0', 'left.fakeid'];
	export StNameAKIgnoredFields := ['dph_lname', ' lname', ' pfname', ' yob', ' states', ' lname1', ' lname2', 
																					 ' lname3', ' city1', ' city2', ' city3', ' rel_fname1', ' rel_fname2', 
																					 ' rel_fname3', ' lookups', ' qa_defined_empty' ];
	export StNameAKUniqueField := ['did'];
	export StNameAKParentName := 'AutoKeyStName';
	
  //StNameb2AK Key
  export StNameb2AKKeyName := 'AutoKeyStNameb2';
	export StNameb2AKKeyType := 'Search Key';
	export StNameb2AKKeySet := ['st', 'bdid'];
	export StNameb2AKParentSet := ['left.person_addr__st', 'left.fakeid'];
	export StNameb2AKIgnoredFields := ['cname_indic', ' cname_sec', ' lookups', ' qa_defined_empty'];
	export StNameb2AKUniqueField := ['bdid'];
	export StNameb2AKParentName := 'AutoKeyStNameb2';	

	//SSN2AK Key
  export SSN2AKKeyName := 'AutoKeySSN2';
	export SSN2AKKeyType := 'Search Key';	
	export SSN2AKKeySet := ['s1','s2','s3','s4','s5','s6','s7','s8','s9', 'did'];
	export SSN2AKParentSet := [ 'left.ssn[1]', 'left.ssn[2]', 'left.ssn[3]', 'left.ssn[4]', 
																					 'left.ssn[5]', 'left.ssn[6]', 'left.ssn[7]', 'left.ssn[8]', 
																					 'left.ssn[9]', 'left.fakeid'];
	export SSN2AKIgnoredFields := ['dph_lname', ' pfname', 'lookups', ' qa_defined_empty'];
	export SSN2AKUniqueField := ['did'];
	export SSN2AKParentName := 'AutoKeySSN2';

	//AddressAK Key
	export AddressAKKeyName := 'AutoKeyaddress';
	export AddressAKKeyType := 'Search Key';	
	export AddressAKKeySet := ['prim_name', 'prim_range', 'st', 'zip', 'sec_range', 'did'];
	export AddressAKParentSet := ['ut.stripOrdinal(left.person_addr__prim_name)', 
																					 'TRIM(ut.CleanPrimRange(left.person_addr__prim_range),left)', 
																					 'left.person_addr__st',  'left.person_addr__zip5', 
																					 'left.person_addr__sec_range', 'left.fakeid'];
	export AddressAKIgnoredFields := ['city_code', 'dph_lname', 'lname', 'pfname', 'fname', 
																					 'states', 'lname1', 'lname2', 'lname3', 'lookups', 'qa_defined_empty'];
	export AddressAKUniqueField := ['did'];
	export AddressAKParentName := 'AutoKeyaddress';
	
	//Addressb2AK Key
	export Addressb2AKKeyName := 'AutoKeyAddressb2';
	export Addressb2AKKeyType := 'Search Key';	
	export Addressb2AKKeySet := ['prim_name', 'prim_range',  'st', 'zip', 'sec_range', 'bdid'];
	export Addressb2AKParentSet := ['ut.stripOrdinal(left.person_addr__prim_name)', 
																					 'TRIM(ut.CleanPrimRange(left.person_addr__prim_range),left)',  
																					 'left.person_addr__st',  'left.person_addr__zip5', 
																					 'left.person_addr__sec_range', 'left.fakeid'];
	export Addressb2AKIgnoredFields := ['city_code', 'cname_indic', 'cname_sec', 'lookups', 'qa_defined_empty' ];
	export Addressb2AKUniqueField := ['bdid'];
	export Addressb2AKParentName := 'AutoKeyAddressb2';
	
	//FEIN2AK Key
	export Fein2AKKeyName := 'AutoKeyFein2';
	export Fein2AKKeyType := 'Search Key';	
	export FEIN2AKKeySet := ['f1','f2','f3','f4','f5','f6','f7','f8','f9', 'bdid'];
	export FEIN2AKParentSet := [ 'left.tax_id[1]', 'left.tax_id[2]', 'left.tax_id[3]', 'left.tax_id[4]', 
																					 'left.tax_id[5]', 'left.tax_id[6]', 'left.tax_id[7]', 'left.tax_id[8]', 'left.tax_id[9]', 'left.fakeid'];
	export FEIN2AKIgnoredFields := ['cname_indic', ' cname_sec', ' lookups', ' qa_defined_empty'];
	export FEIN2AKUniqueField := ['bdid'];
	export FEIN2AKParentName := 'AutoKeyFein2';
	
	//NameAK Key
	export NameAKKeyName := 'AutoKeyname';
	export NameAKKeyType := 'Search Key';	
	export NameAKKeySet := ['fname', 'minit', 's4',  'dob',  'did'];
	export NameAKParentSet := [ 'left.person_name__fname', 'left.person_name__mname[1]', 
																					 '(unsigned)(((string)left.ssn)[6..9])', '0', 'left.fakeid'];
	export NameAKIgnoredFields := ['dph_lname', ' lname', ' pfname', ' yob', ' states', ' lname1', ' lname2', 
																					 ' lname3', ' city1', ' city2', ' city3', ' rel_fname1', ' rel_fname2', 
																					 ' rel_fname3', ' lookups', ' qa_defined_empty' ];
	export NameAKUniqueField := ['did'];
	export NameAKParentName := 'AutoKeyname';

	//Nameb2AK Key
	// export Nameb2AKKeyName := 'AutoKeynameb2';
	// export Nameb2AKKeyType := 'Search Key';	
	// export Nameb2AKKeySet := ['bdid'];
	// export Nameb2AKParentSet := ['left.fakeid'];
	// export Nameb2AKIgnoredFields := ['cname_indic', ' cname_sec', ' lookups', ' qa_defined_empty' ];
	// export Nameb2AKUniqueField := ['bdid'];
	// export Nameb2AKParentName := 'LSPayloadAutoKey';
	
	//NameWords2AK Key
	export Namewords2AKKeyName := 'AutoKeynamewords2';
	export Namewords2AKKeyType := 'Search Key';	
	export NameWords2AKKeySet := ['state', 'bdid'];
	export NameWords2AKParentSet := [ 'left.person_addr__st', 'left.fakeid'];
	export NameWords2AKIgnoredFields := ['word', 'seq', 'lookups', ' qa_defined_empty' ];
	export NameWords2AKUniqueField := ['bdid'];
	export NameWords2AKParentName := 'AutoKeynamewords2';


	//CityStNameAK Key
	export CityStNameAKKeyName := 'AutoKeyCityStName';
	export CityStnameAKKeyType := 'Search Key';	
	export CityStNameAKKeySet := ['st', 'fname', 'dob', 'did'];
	export CityStNameAKParentSet := [ 'left.person_addr__st', 'left.person_name__fname', '0', 'left.fakeid'];
	export CityStNameAKIgnoredFields := ['city_code', 'lname', 'dph_lname', 'pfname', 'states', 'lname1', 
																					 'lname2', 'lname3', 'city1', 'city2', 'city3', 'rel_fname1', 'rel_fname2', 
																					 'rel_fname3', 'lookups', 'qa_defined_empty'];
	export CityStNameAKUniqueField := ['did'];
	export CityStNameAKParentName := 'AutoKeyCityStName';
	
	//CityStNameb2AK Key
  export CityStName2AKKeyName := 'AutoKeyCityStName2';
	export CityStname2AKKeyType := 'Search Key';	
	export CityStNameb2AKKeySet := ['st', 'bdid'];
	export CityStNameb2AKParentSet := ['left.person_addr__st', 'left.fakeid'];
	export CityStNameb2AKIgnoredFields := ['city_code', ' cname_indic', ' cname_sec', ' lookups', ' qa_defined_empty'];
	export CityStNameb2AKUniqueField := ['bdid'];
	export CityStNameb2AKParentName := 'AutoKeyCityStName2';
	
END;