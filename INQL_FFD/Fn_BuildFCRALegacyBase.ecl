IMPORT INQL_FFD, Inquiry_acclogs, STD, Data_services, ut;

// Extracts data from Legacy Inquiry Tracking FCRA Base
EXPORT Fn_BuildFCRALegacyBase(string pVersion)  := function

fVersion   	:= pVersion+'w';

legacy_Riskwise    := Inquiry_acclogs.fnAddSource(
							dataset(Data_services.foreign_fcra_logs + 'fcra_logs_thor::out::inquiry::'+fVersion+'::riskwise', inquiry_acclogs.Layout.common, thor),'RISKWISE');
legacy_Accurint    := Inquiry_acclogs.fnAddSource(
							dataset(Data_services.foreign_fcra_logs + 'fcra_logs_thor::out::inquiry::'+fVersion+'::accurint', inquiry_acclogs.Layout.common, thor),'COLLECTION');
legacy_Batch       := Inquiry_acclogs.fnAddSource(
							dataset(Data_services.foreign_fcra_logs + 'fcra_logs_thor::out::inquiry::'+fVersion+'::batch', inquiry_acclogs.Layout.common, thor),'BATCH');
legacy_Prodr3      := Inquiry_acclogs.fnAddSource(
							dataset(Data_services.foreign_fcra_logs + 'fcra_logs_thor::out::inquiry::'+fVersion+'::prodr3', inquiry_acclogs.Layout.common, thor),'PROD R3');
legacy_BankoBatch  := Inquiry_acclogs.fnAddSource(
							dataset(Data_services.foreign_fcra_logs + 'fcra_logs_thor::out::inquiry::'+fVersion+'::banko_batch', inquiry_acclogs.Layout.common, thor), 'BANKO_BATCH');
legacy_Banko       := Inquiry_acclogs.fnAddSource(
							dataset(Data_services.foreign_fcra_logs + 'fcra_logs_thor::out::inquiry::'+fVersion+'::banko', inquiry_acclogs.Layout.common, thor),'BANKO');

legacy_weekly := legacy_Riskwise + legacy_Accurint + legacy_Batch + legacy_Prodr3 + legacy_BankoBatch + legacy_Banko;

legacyBase     	:= legacy_weekly
                 	(
									    ((permissions.fcra_purpose in _Constants.FCRA_PPC) and search_info.datetime[1..8] between _Flags(pVersion).dt2yearsago and pVersion) 
							     or ((permissions.fcra_purpose not in _Constants.FCRA_PPC) and search_info.datetime[1..8] between _Flags(pVersion).dt1yearago and pVersion)
									 )
									 :persist('~persist::inquiryhistory::legacy_base');

legacy_weekly_dupes_removed := sort(distribute(dedup(LegacyBase,all),
                 hash(person_q.appended_adl, search_info.transaction_id,search_info.sequence_number,search_info.datetime,search_info.function_description)), 
								 person_q.appended_adl, search_info.transaction_id, search_info.sequence_number, search_info.datetime, search_info.function_description, record, local);

legacy_DID_Key := inquiry_acclogs.Key_FCRA_DID;

legacy_key_dupes_removed := sort(distribute(dedup(legacy_DID_Key,all),
                 hash(person_q.appended_adl, search_info.transaction_id,search_info.sequence_number,search_info.datetime,search_info.function_description)), 
								 person_q.appended_adl, search_info.transaction_id, search_info.sequence_number, search_info.datetime, search_info.function_description, record, local);

legacy_weekly_base    :=join(legacy_weekly_dupes_removed,legacy_key_dupes_removed, 
																left.search_info.transaction_id = right.search_info.transaction_id and
																left.search_info.sequence_number = right.search_info.sequence_number and 
																left.search_info.datetime = right.search_info.datetime 
															,transform(recordof(legacy_weekly_dupes_removed),
																				self.person_q.appended_adl      := right.person_q.appended_adl;
																				self.search_info.function_description := right.search_info.function_description;
																				self:=left)
															,local);
		

FFD_base := project(legacy_weekly_base,
				transform(INQL_FFD.Layouts.Base,
					self.lex_id := (STRING)left.person_q.appended_adl;
					self.product_id := '';
					self.inquiry_date := left.search_info.datetime;
					self.transaction_id := left.search_info.transaction_id;
					self.date_added := left.search_info.datetime;
					self.customer_number := '';
					self.customer_account := '';
					self.ssn := left.person_q.ssn;
					self.drivers_license_number := left.person_q.dl;
					self.drivers_license_state := left.person_q.dl_st;
					self.name_first := left.person_q.first_name;
					self.name_last := left.person_q.last_name;
					self.name_middle := left.person_q.middle_name;
					self.name_suffix := left.person_q.name_suffix;
					self.addr_street := left.person_q.address;
					self.addr_city := left.person_q.city;
					self.addr_state := left.person_q.state;
					self.addr_zip5 :=  left.person_q.zip5;
					self.addr_zip4 :=  left.person_q.zip4;
					self.dob := left.person_q.dob;
					self.transaction_location := '';
					self.ppc := INQL_FFD._Functions.Convert_PPC(left.Permissions.fcra_purpose);

					self.internal_identifier := '';
					self.eu1_customer_number := '';
					self.eu1_customer_account := '';
					self.eu2_customer_number := '';
					self.eu2_customer_account := '';
					self.state_id_number := '';
					self.state_id_state := '';
					self.phone_nbr := left.person_q.personal_phone;
					self.email_addr := left.person_q.email_address;
					self.ip_address := left.person_q.ipaddr;
					self.perm_purp_inq_type := '';
					self.eu_company_name := '';
					self.eu_addr_street := '';
					self.eu_addr_city := '';
					self.eu_addr_state := '';
					self.eu_addr_zip5 := '';
					self.eu_phone_nbr := '';
					self.product_code := left.search_info.product_code;
					self.transaction_type := left.search_info.transaction_type;
					self.function_name := left.search_info.function_description;
					self.customer_id := '';

					self.company_id := left.mbs.company_id;
					self.global_company_id := left.mbs.global_company_id;

					self.title := left.person_q.title;
					self.fname := left.person_q.fname;
					self.mname := left.person_q.mname;
					self.lname := left.person_q.lname;
					self.name_score := '';
					
					self.prim_range := left.person_q.prim_range;
					self.predir := left.person_q.predir;
					self.prim_name := left.person_q.prim_name;
					self.addr_suffix := left.person_q.addr_suffix;
					self.postdir := left.person_q.postdir;
					self.unit_desig := left.person_q.unit_desig;
					self.sec_range := left.person_q.sec_range;
					self.v_city_name := left.person_q.v_city_name;
					self.st := left.person_q.st;
					self.zip5 := left.person_q.zip5;
					self.zip4 := left.person_q.zip4;
					self.addr_rec_type := left.person_q.addr_rec_type;
					self.fips_state := left.person_q.fips_state;
					self.fips_county := left.person_q.fips_county;
					self.geo_lat := left.person_q.geo_lat;
					self.geo_long := left.person_q.geo_long;
					self.cbsa := left.person_q.cbsa;
					self.geo_blk := left.person_q.geo_blk;
					self.geo_match := left.person_q.geo_match;
					self.err_stat := left.person_q.err_stat;
					self.datetime := left.search_info.datetime;
					self.appended_did := left.person_q.appended_adl;
					self.appended_ssn := left.person_q.appended_ssn;
					self.filedate 						:= (UNSIGNED)pVersion,
          self.version              := fVersion,
	        self := left));

new_FFD_base := dedup(sort(distribute(FFD_base, 
									hash(appended_did,product_id,transaction_id,datetime )), record, local), record, local);
									
return new_FFD_base;

end;