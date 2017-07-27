import ut, address, aid, lib_stringlib, address, did_add, Business_Header_SS;

export MapAccLogs_Combine := module

// shared test_set := ['8741248383139371391','863337017702536222','6982485239743102520']; // testing only - each contain 70k+ child records

dummyids := ['1385345',
				'1005199',// Accurint Admin
				'1006061',
				'1448650',
				'1488800',
				'1028725',
				'1104341',
				'1357055'];

shared CleanInFile := Accurint_Acclogs.MapAccLogs_Clean
										/* THIS WAS BEING USED for testing b/c there can be hundreds of records with no query information for 1 user */
										// ( // must have at least one of the following and not dummy
							// /*name populated*/ 	(fname + lname + mname + cname + orig_business_name + orig_full_name <> '' or
							// /*personal info */	ssn + phone + dob <> '' or
							// /*address info  */	orig_address + orig_city + orig_state + orig_zip + orig_zip4 <> '' or
							// /*unique data   */	orig_unique_id <> '' or did + bdid > 0) and
							// /*remove dummies*/	orig_company_id not in dummyids)
							;

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
dstrcomb := distribute(trimCleanIn/* + hash_base_main */, hash(hash_key)); //distribute here

combinedFilesMain := project(dedup(sort(dstrcomb, hash_key, dt_vendor_first_reported, hash_key, dt_vendor_first_reported, dt_vendor_last_reported, local), hash_key, dt_vendor_first_reported, dt_vendor_last_reported, local), 
							transform(accurint_acclogs.Layout_AccLogs_Base.full_layout,
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
shared srtTransFile := dedup(sort(distribute(hash_new_trans /*+ hash_base_trans*/, hash(hash_key)), record, local), record, local);

////// FULL Transactional Dataset condensed for Child Dataset in Base

timetrim(string dttm) := if(stringlib.stringfind(dttm, ':', 2) > 10, dttm[1..stringlib.stringfind(dttm, ':', 2)-1], dttm);
pre_combinedFilesTrans := table(srtTransFile, {string hash_key := trim(hash_key, all), transaction_id_count := count(group), string orig_dateadded := timetrim(orig_dateadded)}, 
										hash_key, timetrim(orig_dateadded), local);
combinedFilesTrans := project(pre_combinedFilesTrans, accurint_acclogs.Layout_AccLogs_Base.transaction);

////// Denormalize Main and Transational for Full Layout
accurint_acclogs.Layout_AccLogs_Base.full_layout denormfiles(accurint_acclogs.Layout_AccLogs_Base.full_layout l, dataset(accurint_acclogs.Layout_AccLogs_Base.transaction) r) := transform
					self.transactions := r;
					self.transaction_count := count(self.transactions);
					self := l;
end;

DeNormedRecs := DENORMALIZE(distribute(rllupMain, hash(hash_key)), combinedFilesTrans,
								trim(LEFT.hash_key, all) = trim(RIGHT.hash_key, all), GROUP,
									DeNormFiles(LEFT,ROWS(RIGHT)), local); /////
									
AssignFLDates := project(DeNormedRecs, transform(accurint_acclogs.Layout_AccLogs_Base.full_layout,
														self.dt_first_seen := left.dt_vendor_first_reported;
														self.dt_last_seen := left.dt_vendor_last_reported;
														self := left));

////// Output Base File
export Base := AssignFLDates;

////// Output Transactional File
export Transactions := srtTransFile;

end;