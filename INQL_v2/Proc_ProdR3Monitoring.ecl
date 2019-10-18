EXPORT Proc_Prod_R3Monitoring := 'todo';

import ut, Data_Services, _control;

export proc_ProdR3Monitoring := module

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

export File_NCO := dataset(Data_Services.foreign_prod + 'batchr3::base::account_monitoring::prod::inquirytracking', inql_v2.Layouts.Common, thor, opt);

export File_Monitoring := dataset(Data_Services.foreign_prod + 'batchr3::base::account_monitoring::prod::inquirytracking', inql_v2.Layouts.Common, thor, opt);

export File_PIDs := dataset(Data_Services.foreign_prod + 'batchr3::base::account_monitoring::prod::inquirytracking::pidmapping', 
			// {string pid, string gcid, boolean isFcra}, csv(separator('|')));
			{string pid, string product_id, string company_id, string gcid, boolean isFcra}, csv(separator('|'))); // new layout, waiting on file
			
export Despray(string logicalname, string flag) := nothor(fileservices.Despray('~'+logicalName, 
																			 _control.IPAddress.bctlpedata10, 
																			 '/data/inquiry_data_01/spray_ready/prodr3_'+flag+'_'+ut.GetDate+'.cat', 
																			 , 
																			 , 
																			 , 
																			 true)); 


//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

ProcessedDS := dataset(Data_Services.foreign_logs + 'thor100_21::in::BatchR3_acclogs_contents',{string name}, thor, opt) + 
							 dataset(Data_Services.foreign_fcra_logs + 'thor10_231::in::BatchR3_acclogs_contents',{string name}, thor, opt);
							 
regexName := 'batchr3::base::account_monitoring::prod::([a-zA-Z]+)::inquirytracking::([0-9]+)';							 
ProcessedDsSet := set(ProcessedDS, regexfind(regexName,name,0));

logs_R3fcra := nothor(fileservices.superfilecontents(Data_Services.foreign_prod + 'batchr3::base::account_monitoring::prod::fcra::inquirytracking')(regexfind(regexName,name,0) in ProcessedDsSet));
logs_R3nonfcra := nothor(fileservices.superfilecontents(Data_Services.foreign_prod + 'batchr3::base::account_monitoring::prod::nonfcra::inquirytracking')(regexfind(regexName,name,0) in ProcessedDsSet));
logs_inNCO  := nothor(fileservices.superfilecontents('~thor_data400::base::monitoring_customer_base_delta')(Data_Services.foreign_prod+'::'+name in ProcessedDsSet));

fnRemoveFromSupers(string lname, string ftype) := function
	superswap1 := nothor(fileservices.removesuperfile('~batchr3::base::account_monitoring::'+ftype+'::inquirytracking', lname, true));
return parallel(superswap1);
end;

fnRemoveFromSupersNCO(string lname) := function
	superswap1 := nothor(fileservices.removesuperfile('~thor_data400::base::monitoring_customer_base_delta', lname, true));
return parallel(superswap1);
end;


export SuperMove := parallel(
												if(count(logs_R3fcra) > 0, 
												sequential(
													output(logs_R3fcra, named('R3_FCRA_Files_For_Super_Removal'));
													nothor(fileservices.startsuperfiletransaction());	
													nothor(apply(logs_R3fcra,  fnRemoveFromSupers('~'+name, 'prod::fcra')));
													nothor(fileservices.finishsuperfiletransaction())));
													if(count(logs_R3nonfcra) > 0, 
												sequential(
													output(logs_R3nonfcra, named('R3_NonFCRA_Files_For_Super_Removal'));
													nothor(fileservices.startsuperfiletransaction());
														nothor(apply(logs_R3nonfcra,  fnRemoveFromSupers('~'+name, 'prod::nonfcra')));
													nothor(fileservices.finishsuperfiletransaction())
												))
                        ); 
												
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

shared Appendable_Layout := record
				string orig_pid,
				string orig_company_id,
				string orig_product_id,
				string orig_global_company_id,
				string orig_full_name,
				string orig_personal_phone,
				string orig_work_phone,
				string orig_dob,
				string orig_dl,
				string orig_dl_state,
				string orig_email,
				string orig_ssn,
				string orig_linkid,
				string orig_ipaddr,										
				string orig_addr1_1,
				string orig_addr2_1,
				string orig_city_1,
				string orig_st_1,
				string orig_zip_1,
				string orig_cname,
				string orig_company_phone,
				string orig_ein,
				string orig_charter_number,
				string orig_ucc_number,
				string orig_domain_name,
				string orig_addr1_2,
				string orig_addr2_2,
				string orig_city_2,
				string orig_st_2,
				string orig_zip_2,
				string orig_datetime,
				string orig_start_monitor,
				string orig_stop_monitor,
				string orig_login_history_id,
				string orig_transaction_id,
				string orig_sequence_number,
				string orig_job_id := '';
				string orig_method,
				string orig_transaction_type := '',
				string orig_function_name := '',
				string orig_fcra_purpose;
				string orig_glb_purpose;
				string orig_dppa_purpose;
				boolean isFCRA;
				string null := '',
end;

AppendableFile := join(File_Monitoring, File_PIDs, left.mbs.company_id = right.pid, 
																	transform(Appendable_Layout,
																				self.orig_pid := left.mbs.company_id;
																				self.orig_company_id := right.company_id;
																				self.orig_product_id := right.product_id;
																				self.orig_global_company_id := right.gcid;
																				self.orig_full_name := stringlib.stringcleanspaces(left.person_q.fname + ' ' + left.person_q.mname + ' ' + left.person_q.lname + ' ' + left.person_q.name_suffix);
																				self.orig_personal_phone := left.person_q.personal_phone;
																				self.orig_work_phone := left.person_q.work_phone;
																				self.orig_dob := left.person_q.dob;
																				self.orig_dl := left.person_q.dl;
																				self.orig_dl_state := left.person_q.dl_st;
																				self.orig_email := left.person_q.email_address;
																				self.orig_ssn := left.person_q.ssn;
																				self.orig_linkid := (string)left.person_q.appended_adl;
																				self.orig_ipaddr := left.person_q.ipaddr;
																				self.orig_addr1_1 := stringlib.stringcleanspaces(left.person_q.prim_range + ' ' + left.person_q.predir + ' ' + left.person_q.prim_name + ' ' + left.person_q.addr_suffix + ' ' + left.person_q.postdir + ' ' + left.person_q.unit_desig + ' ' + left.person_q.sec_range);
																				self.orig_addr2_1 := stringlib.stringcleanspaces(left.person_q.city + ' ' + left.person_q.st + ' ' + left.person_q.zip + ' ' + left.person_q.zip4);
																				self.orig_city_1 := left.person_q.city;
																				self.orig_st_1 := left.person_q.st;
																				self.orig_zip_1 := left.person_q.zip;
																				self.orig_cname := left.bus_q.cname;
																				self.orig_company_phone := left.bus_q.company_phone;
																				self.orig_ein := left.bus_q.ein;
																				self.orig_charter_number := left.bus_q.charter_number;
																				self.orig_ucc_number := left.bus_q.ucc_number;
																				self.orig_domain_name := left.bus_q.domain_name;
																				self.orig_addr1_2 := stringlib.stringcleanspaces(left.bus_q.prim_range + ' ' + left.bus_q.predir + ' ' + left.bus_q.prim_name + ' ' + left.bus_q.addr_suffix + ' ' + left.bus_q.postdir + ' ' + left.bus_q.unit_desig + ' ' + left.bus_q.sec_range);
																				self.orig_addr2_2 := stringlib.stringcleanspaces(left.bus_q.city + ' ' + left.bus_q.st + ' ' + left.bus_q.zip + ' ' + left.bus_q.zip4);
																				self.orig_city_2 := left.bus_q.city;
																				self.orig_st_2 := left.bus_q.st;
																				self.orig_zip_2 := left.bus_q.zip;
																				self.orig_datetime := left.search_info.datetime;
																				self.orig_start_monitor := left.search_info.start_monitor[1..8];
																				self.orig_stop_monitor := left.search_info.stop_monitor[1..8];
																				self.orig_login_history_id := left.search_info.login_history_id;
																				self.orig_transaction_id := left.search_info.transaction_id;
																				self.orig_sequence_number := left.search_info.sequence_number;
																				self.orig_function_name := left.search_info.Function_Description;
																				// self.orig_job_id := left.search_info.job_id;

																				self.orig_method := left.search_info.method;
																				self.orig_fcra_purpose := left.Permissions.FCRA_purpose;
																				self.orig_glb_purpose := left.Permissions.GLB_purpose;
																				self.orig_dppa_purpose := left.Permissions.DPPA_purpose;
																				self.isFCRA := right.isFCRA;
																				self := left), left outer, lookup);

dtTime := regexreplace('[^0-9]',ut.GetTimeDate(),'') : independent;

AvailFiles := nothor(fileservices.superfilecontents(Data_Services.foreign_prod + 'batchr3::base::account_monitoring::prod::inquirytracking'));
AvailRecs := count(nothor(fileservices.superfilecontents(Data_Services.foreign_prod + 'batchr3::base::account_monitoring::prod::inquirytracking'))) > 0;
output(AvailFiles, named('Available_Files'));

GCIDs_Valid := count(AppendableFile(orig_global_company_id = '')) = 0;

GCIDs_inValid_List := sort(table(AppendableFile(orig_global_company_id = ''), {orig_pid, ct := count(group)}, orig_pid, few), -ct);

fcra_output_move := sequential(
													output(AppendableFile(isFCRA),,'~batchr3::base::account_monitoring::prod::fcra::inquirytracking::'+dtTime,__compressed__,overwrite);
													nothor(fileservices.addsuperfile('~batchr3::base::account_monitoring::prod::fcra::inquirytracking','~batchr3::base::account_monitoring::prod::fcra::inquirytracking::'+dtTime));
													despray('~batchr3::base::account_monitoring::prod::fcra::inquirytracking::'+dtTime,'fcra')
													);

nonfcra_output_move := sequential(
													output(AppendableFile(~isFCRA),,'~batchr3::base::account_monitoring::prod::nonfcra::inquirytracking::'+dtTime,__compressed__,overwrite);
													nothor(fileservices.addsuperfile('~batchr3::base::account_monitoring::prod::nonfcra::inquirytracking','~batchr3::base::account_monitoring::prod::nonfcra::inquirytracking::'+dtTime));
													despray(Data_Services.foreign_prod + 'batchr3::base::account_monitoring::prod::nonfcra::inquirytracking::'+dtTime,'nonfcra')
													);
													
clear_input := nothor(fileservices.clearsuperfile('~batchr3::base::account_monitoring::prod::inquirytracking'));

emailDR := nothor(fileservices.sendemail('charles.pettola@lexisnexisrisk.com, Cecelie.Reid@lexisnexisrisk.com, Fernando.Incarnacao@lexisnexisrisk.com, Sudhir.Kasavajjala@lexisnexisrisk.com, Darren.Knowles@lexisnexisrisk.com, Franz.Nisswandt@lexisnexisrisk.com',
																	'Inquiry Tracking Incoming Prod R3 Files',
																	'File names on Prod R3 http:// ' +_Control.IPAddress.prod_watch_dev + ':8010/\n\n'  +
																	Data_Services.foreign_prod + 'batchr3::base::account_monitoring::prod::fcra::inquirytracking::'+dtTime + '\n' +
																	Data_Services.foreign_prod + 'batchr3::base::account_monitoring::prod::nonfcra::inquirytracking::'+dtTime));

export Separate_R3_Records := if(AvailRecs and GCIDs_Valid, 
																	sequential(parallel(fcra_output_move, nonfcra_output_move),clear_input, emailDR), 
																	if(~GCIDs_Valid, sequential(output(choosen(GCIDs_inValid_List, 100), named('Unmatched_PIds')),  
																						 nothor(FileServices.SendEmail('charles.pettola@lexisnexisrisk.com, Cecelie.Reid@lexisnexisrisk.com, Fernando.Incarnacao@lexisnexisrisk.com, Sudhir.Kasavajjala@lexisnexisrisk.com, Darren.Knowles@lexisnexisrisk.com, Franz.Nisswandt@lexisnexisrisk.com', 'ProdR3 PID Failure', thorlib.wuid() + '\n' + 'Please view WU to see empty missing PID assignment')))));

export File_Monitoring_FCRA := dataset(Data_Services.foreign_prod + 'batchr3::base::account_monitoring::prod::fcra::inquirytracking', Appendable_Layout, thor, opt);
export File_Monitoring_NONFCRA := dataset(Data_Services.foreign_prod + 'batchr3::base::account_monitoring::prod::nonfcra::inquirytracking', Appendable_Layout, thor, opt);

end;