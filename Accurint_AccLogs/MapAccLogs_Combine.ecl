import ut, address, aid, lib_stringlib, address, did_add, Business_Header_SS, inquiry_acclogs;

export MapAccLogs_Combine := module

// dummyids := ['1385345',
				// '1005199',// Accurint Admin
				// '1006061',
				// '1448650',
				// '1488800',
				// '1028725',
				// '1104341',
				// '1357055'];

shared CleanInFile := Accurint_Acclogs.MapAccLogs_Clean;

////// Place file in main layout + child dataset fields. Create hash key. INPUT only.
shared trimCleanIn := project(cleaninfile, transform({accurint_acclogs.Layout_AccLogs_Base.Main, string orig_transaction_id, string orig_dateadded},
												self.hash_key := (string)hash64(
																	LEFT.orig_loginid + LEFT.orig_billing_code + LEFT.orig_transaction_type + LEFT.orig_company_id + 
																	LEFT.orig_transaction_code + LEFT.orig_unique_id + LEFT.orig_function_name + 
																	LEFT.fname + LEFT.mname + LEFT.lname + LEFT.name_suffix + LEFT.cname + 
																	LEFT.prim_range + LEFT.predir + LEFT.prim_name + LEFT.addr_suffix + LEFT.postdir + LEFT.unit_desig + LEFT.sec_range + LEFT.p_city_name + 
																	LEFT.phone + LEFT.ssn + LEFT.dob);
												self := left)) : persist('~accurint_acclogs::base');

////// Place BASE file in main layout
base := accurint_acclogs.File_AccLogs_Base;

pre_hash_base_main := project(base, transform({accurint_acclogs.Layout_AccLogs_Base.Main, string orig_transaction_id := '', string orig_dateadded := ''},
						self := left;
						self := []));
						
////// RE-DID and RE-BDID Base file on Weekend ONLY
hash_base_main := accurint_acclogs.MapAccLogs_ReAppendIDs(pre_hash_base_main);

////// Combine Sort and Dedup Base Files
dstrcomb := distribute(trimCleanIn + hash_base_main, hash(hash_key)); //distribute here

combinedFilesMain := project(dedup(sort(dstrcomb, hash_key, dt_vendor_first_reported, hash_key, dt_vendor_first_reported, dt_vendor_last_reported, local), hash_key, dt_vendor_first_reported, dt_vendor_last_reported, local), 
							transform(accurint_acclogs.Layout_AccLogs_Base.main,
										self := left;
										self := []));

////// Rollup New Base
shared rllupMain := rollup(combinedFilesMain, transform(recordof(combinedFilesMain),
												self.dt_vendor_first_reported :=
														if(left.dt_vendor_first_reported < right.dt_vendor_first_reported,
																left.dt_vendor_first_reported, right.dt_vendor_first_reported);
												self.dt_vendor_last_reported :=
														if(left.dt_vendor_last_reported > right.dt_vendor_last_reported,
																left.dt_vendor_last_reported, right.dt_vendor_last_reported);
												self.dt_first_seen := self.dt_vendor_first_reported;
												self.dt_last_seen := self.dt_vendor_last_reported;
												self := right, self := []), hash_key, local); /////

////// Create Transactional Child Records and Dataset //////
hash_base_trans := accurint_acclogs.File_AccLogs_Transactions;
hash_new_trans := project(trimCleanIn, 
							transform(accurint_acclogs.Layout_AccLogs_Base.transaction_list_layout,
								tDateAdded(string indate) := function //dates like Dec  1 2009 5:35:32:011AM
										upcaseit 	:= trim(stringlib.stringtouppercase(indate), left, right);
										needsTrans := ~regexfind('[B-LN-OQ-Z]', upcaseit);
										month 	:= map(upcaseit[1..3] = 'JAN' => '01',
														upcaseit[1..3] = 'FEB' => '02',
														upcaseit[1..3] = 'MAR' => '03',
														upcaseit[1..3] = 'APR' => '04',
														upcaseit[1..3] = 'MAY' => '05',
														upcaseit[1..3] = 'JUN' => '06',
														upcaseit[1..3] = 'JUL' => '07',
														upcaseit[1..3] = 'AUG' => '08',
														upcaseit[1..3] = 'SEP' => '09',
														upcaseit[1..3] = 'OCT' => '10',
														upcaseit[1..3] = 'NOV' => '11',
														upcaseit[1..3] = 'DEC' => '12', '');
										DyYr 	:= (string)intformat((integer6)stringlib.stringfilter(upcaseit[4..11], '0123456789'), 6, 1);
										Dy		:= DyYr[1..2];
										Yr		:= DyYr[3..6];
								return stringlib.stringcleanspaces(if(needsTrans, stringlib.stringfilterout(upcaseit, '-'), yr+month+dy+' '+upcaseit[12..]));
								end;	
							
							self.orig_dateadded := tDateAdded(left.orig_dateadded),
							self := left));

////// FULL Transactional Dataset with Transaction IDs
shared srtTransFile := dedup(sort(distribute(hash_new_trans + hash_base_trans , hash(hash_key)), record, local), record, local);

////// FULL Transactional Dataset condensed for Child Dataset in Base

timetrim(string dttm) := if(stringlib.stringfind(dttm, ':', 2) > 10, dttm[1..stringlib.stringfind(dttm, ':', 2)-1], dttm);
pre_combinedFilesTrans := table(srtTransFile, {string hash_key := trim(hash_key, all), transaction_id_count := count(group), string orig_dateadded := timetrim(orig_dateadded)}, 
										hash_key, timetrim(orig_dateadded), local);
combinedFilesTrans := project(pre_combinedFilesTrans, accurint_acclogs.Layout_AccLogs_Base.transaction);

////// Denormalize Main and Transational for Full Layout
accurint_acclogs.Layout_AccLogs_Base.main denormfiles(accurint_acclogs.Layout_AccLogs_Base.main l, dataset(accurint_acclogs.Layout_AccLogs_Base.transaction) r) := transform
					self.transaction_count := 0;
					self := l;
end;

DeNormedRecs := DENORMALIZE(distribute(rllupMain, hash(hash_key)), combinedFilesTrans,
								trim(LEFT.hash_key, all) = trim(RIGHT.hash_key, all), GROUP,
									DeNormFiles(LEFT,ROWS(RIGHT)), local); /////
									
AssignFLDates := project(DeNormedRecs, transform(accurint_acclogs.Layout_AccLogs_Base.main,
														self.dt_first_seen := left.dt_vendor_first_reported;
														self.dt_last_seen  := left.dt_vendor_last_reported;
														self.st 					 := if(left.st = '', stringlib.stringtouppercase(left.orig_state), left.st);
														self.p_city_name 	 := if(left.p_city_name = '', stringlib.stringtouppercase(left.orig_city), left.p_city_name);
														self.v_city_name 	 := if(left.v_city_name = '', stringlib.stringtouppercase(left.orig_city), left.v_city_name);
														self.zip 					 := if(left.zip = '', stringlib.stringtouppercase(left.orig_zip), left.zip);
														self.orig_dl			 := if(stringlib.stringtouppercase(left.orig_function_name) in ['ACCIDENTSEARCH','MVSEARCH','MVSEARCH2'] or
																										 stringlib.stringtouppercase(left.orig_searchdescription) in ['ACCIDENTSEARCH','MVSEARCH','MVSEARCH2'] or
																										 stringlib.stringtouppercase(left.search_description ) in ['ACCIDENTSEARCH','MVSEARCH','MVSEARCH2'],
																										 '', left.orig_dl);
														self.orig_charter_nbr	:= if(stringlib.stringtouppercase(left.orig_function_name) = 'CORPREPORTV2' or
																												stringlib.stringtouppercase(left.orig_searchdescription) = 'CORPREPORTV2' or
																												stringlib.stringtouppercase(left.search_description) = 'CORPREPORTV2', 
																													regexreplace('^[A-Za-z0-9][A-Za-z0-9]-', trim(left.orig_unique_id, all), ''), left.orig_charter_nbr);
														self := left));

////// UPDATE user status for previous base file records
			prep_user0 := AssignFLDates(orig_login_history_id = '0');
			jUser0 := join(prep_user0, Inquiry_AccLogs.File_Lookups.user_info, 
											stringlib.stringtouppercase(left.orig_loginid) = stringlib.stringtouppercase(right.login_id) and
											left.orig_company_id = right.company_id,
										transform({recordof(AssignFLDates)},
											self.orig_user_status := right.status;
											self := left), lookup, left outer);
											
			prep_user1 := AssignFLDates(orig_login_history_id > '0');
			jUser1 := join(prep_user1, Inquiry_AccLogs.File_Lookups.user_info, 
											stringlib.stringtouppercase(left.orig_billing_code) = stringlib.stringtouppercase(right.login_id) and
											left.orig_company_id = right.company_id,
										transform({recordof(AssignFLDates)},
											self.orig_user_status := right.status;
											self := left), lookup, left outer);

updated_user := jUser0+jUser1;

////// Output Base File
export Base := updated_user;

////// Output Transactional File

rmDupLegacy := dedup(sort(srtTransFile, hash_key, orig_transaction_id, -length(orig_dateadded)), hash_key, orig_transaction_id);

export Transactions := rmDupLegacy;

end;