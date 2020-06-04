IMPORT Inql_FFD, Doxie, ut, dx_InquiryHistory, std, data_services, MDR, _control;

EXPORT Data_Keys (boolean pDaily = true, boolean pFCRA = true, string pVersion = '') := Module

shared fn_hash(pDs):=functionmacro

	return hash64(hashmd5(trim(pDS.lex_id) + ','
											+ trim(pDS.product_id) + ','
											+ trim(pDS.inquiry_date) + ','
											+ trim(pDS.transaction_id) + ','
											+ trim(pDS.date_added) + ','
											+ trim(pDS.customer_number) + ','
											+ trim(pDS.customer_account) + ','
											+ trim(pDS.ssn) + ','
											+ trim(pDS.drivers_license_number) + ','
											+ trim(pDS.drivers_license_state) + ','
											+ trim(pDS.name_first) + ','
											+ trim(pDS.name_last) + ','
											+ trim(pDS.name_middle) + ','
											+ trim(pDS.name_suffix) + ','
											+ trim(pDS.addr_street) + ','
											+ trim(pDS.addr_city) + ','
											+ trim(pDS.addr_state) + ','
											+ trim(pDS.addr_zip5) + ','
											+ trim(pDS.addr_zip4) + ','
											+ trim(pDS.dob) + ','
											+ trim(pDS.transaction_location) + ','
											+ trim(pDS.ppc) + ','
											+ trim(pDS.internal_identifier) + ','
											+ trim(pDS.eu1_customer_number) + ','
											+ trim(pDS.eu1_customer_account) + ','
											+ trim(pDS.eu2_customer_number) + ','
											+ trim(pDS.eu2_customer_account) + ','
											+ trim(pDS.state_id_number) + ','
											+ trim(pDS.state_id_state) + ','
											+ trim(pDS.phone_nbr) + ','
											+ trim(pDS.email_addr) + ','
											+ trim(pDS.ip_address) + ','
											+ trim(pDS.perm_purp_inq_type) + ','
											+ trim(pDS.eu_company_name) + ','
											+ trim(pDS.eu_addr_street) + ','
											+ trim(pDS.eu_addr_city) + ','
											+ trim(pDS.eu_addr_state) + ','
											+ trim(pDS.eu_addr_zip5) + ','
											+ trim(pDS.eu_phone_nbr) + ','
											+ trim(pDS.product_code) + ','
											+ trim(pDS.transaction_type) + ','
											+ trim(pDS.function_name) + ','
											+ trim(pDS.customer_id) + ','
											+ trim(pDS.company_id) + ','
											+ trim(pDS.global_company_id) + ','
											+ trim(pDS.title) + ','
											+ trim(pDS.fname) + ','
											+ trim(pDS.mname) + ','
											+ trim(pDS.lname) + ','
											+ trim(pDS.name_score) + ','
											+ trim(pDS.prim_range) + ','
											+ trim(pDS.predir) + ','
											+ trim(pDS.prim_name) + ','
											+ trim(pDS.addr_suffix) + ','
											+ trim(pDS.postdir) + ','
											+ trim(pDS.unit_desig) + ','
											+ trim(pDS.sec_range) + ','
											+ trim(pDS.v_city_name) + ','
											+ trim(pDS.st) + ','
											+ trim(pDS.zip5) + ','
											+ trim(pDS.zip4) + ','
											+ trim(pDS.addr_rec_type) + ','
											+ trim(pDS.fips_state) + ','
											+ trim(pDS.fips_county) + ','
											+ trim(pDS.geo_lat) + ','
											+ trim(pDS.geo_long) + ','
											+ trim(pDS.cbsa) + ','
											+ trim(pDS.geo_blk) + ','
											+ trim(pDS.geo_match) + ','
											+ trim(pDS.err_stat) + ','
											+ trim(pDS.datetime) + ','
											+ trim((STRING)pDS.appended_did) + ','
											+ trim(pDS.appended_ssn) 
											));	

endMacro;

shared get_recs_pre_remediaton := INQL_FFD.Files(pDaily, pFCRA, pVersion).Base.Built(Appended_DID != 0);

shared get_recs                := INQL_FFD.FN_Apply_FCRA_SAFECO_Remediation(get_recs_pre_remediaton);

shared appd_group_rid := project(get_recs,  
															Transform({recordof(get_recs),unsigned group_rid},
																					self.group_rid := fn_hash(left)
																			  , self.inquiry_date  :=  Std.Date.ConvertDateFormat(left.inquiry_date,'%Y-%m-%d','%Y%m%d');	
																				 ,self := left
																				 ,self := []
																			));

shared dd_appd_group_rid := dedup(sort(appd_group_rid,transaction_id,filedate,local),record,local, except filedate, version);

shared group_rid_ 	:= project(dd_appd_group_rid,
                                Transform(dx_InquiryHistory.Layouts.i_grouprid
																				 ,self := left
																				 ,self := []
																			));
																			
EXPORT group_rid 		:= MDR.macGetGlobalSid(group_rid_,'InquiryTracking_Virtual','', 'global_sid');


EXPORT lexid 				:= project(dd_appd_group_rid,
                                Transform(dx_InquiryHistory.Layouts.i_lexid
																				 ,self := left
																				 ,self := []
																			));

end;