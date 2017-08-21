
import ut;

export File_MBSApp_base(string version = ut.GetDate) := module

export file := dataset('~thor100_21::out::inquiry_tracking::weekly_historical', Inquiry_AccLogs.Layout.Common_ThorAdditions, thor);

export Append(outfile, in_pversion = '') := macro

#uniquename(fnCleanUp)
#uniquename(instring)


#uniquename(prev_version)
#uniquename(logicalfilename)
%logicalfilename% := fileservices.superfilecontents('~thor100_21::out::inquiry_tracking::weekly_historical')[1].name;
%prev_version% := (unsigned)%logicalfilename%[stringlib.stringfind(%logicalfilename%, '::', 3) + 2 .. stringlib.stringfind(%logicalfilename%, '::', 4) -1];

#uniquename(jnInFile1)
#uniquename(jnInFile2)
#uniquename(jnInFile3)
#uniquename(jnInFileNCO)
#uniquename(jnInFile)
#uniquename(inFilePre1)
#uniquename(pinFilePre2)
#uniquename(inFilePre2)
#uniquename(pinfilepre3)
#uniquename(infilepre3)
#uniquename(inFilePre)
#uniquename(inFile)
#uniquename(RefUnused)
#UNIQUENAME(strMin2)										

// transaction_id, transaction_type, sequence_number, function_description, datetime, login_history_id, product_code, fname, lname

	%infilepre1% := 	dedup(sort(distribute(
											inquiry_acclogs.File_Accurint_Logs_Common +
											inquiry_acclogs.File_Custom_Logs_Common +
											inquiry_acclogs.File_Banko_Logs_Common + 
											inquiry_acclogs.File_IDM_Logs_Common +
											inquiry_acclogs.File_Riskwise_Logs_Common,															
										hash(person_q.fname, person_q.lname, search_info.transaction_id, search_info.transaction_type, search_info.sequence_number, search_info.function_description, search_info.datetime, search_info.login_history_id, search_info.product_code)), 
										search_info.transaction_id, local), 
										search_info.transaction_id, local) +

										dedup(sort(distribute(
											Inquiry_AccLogs.File_Batch_Logs_Common,
										hash(person_q.fname, person_q.lname, search_info.transaction_id, search_info.transaction_type, search_info.sequence_number, search_info.function_description, search_info.datetime, search_info.login_history_id, search_info.product_code)), 
										search_info.transaction_id, search_info.sequence_number, search_info.function_description, local), 
										search_info.transaction_id, search_info.sequence_number, search_info.function_description, local) +

										dedup(sort(distribute(
											Inquiry_AccLogs.File_BatchR3_Logs_Common(search_info.function_description not in ['BANKRUPTCY MONITORING']),
										hash(person_q.fname, person_q.lname, search_info.transaction_id, search_info.transaction_type, search_info.sequence_number, search_info.function_description, search_info.datetime, search_info.login_history_id, search_info.product_code)),
										search_info.transaction_id, search_info.transaction_type, search_info.sequence_number, search_info.function_description, search_info.datetime, local), 
										search_info.transaction_id, search_info.transaction_type, search_info.sequence_number, search_info.function_description, search_info.datetime, local) +

										distribute(
											Inquiry_AccLogs.File_Inquiry_MBS(source <> 'BRIDGER'),
										hash(person_q.fname, person_q.lname, search_info.transaction_id, search_info.transaction_type, search_info.sequence_number, search_info.function_description, search_info.datetime, search_info.login_history_id, search_info.product_code));
										
	%pinfilepre2% :=	dedup(sort(distribute(
											// inquiry_acclogs.fnAddSource(inquiry_acclogs.File_BankoBatch_Logs_Common, 'BANKO_BATCH') +
											Inquiry_AccLogs.File_BatchR3_Logs_Common(search_info.function_description in ['BANKRUPTCY MONITORING']),
										hash(search_info.sequence_number)), 
										search_info.sequence_number, person_q.fname, person_q.lname, bus_q.cname, search_info.datetime, local), 
										search_info.sequence_number, person_q.fname, person_q.lname, bus_q.cname, search_info.datetime, local)
										; 

	%infilepre2% :=	 rollup(%pinfilepre2%, transform(recordof(%pinfilepre2%),
	
	%strMin2%(string L, string R) :=  if ( l='' or l>r and r<>'', r, l );
	
														self.search_info.datetime 			:= %strMin2%(left.search_info.datetime, right.search_info.datetime);
														self.search_info.start_monitor 	:= (string)ut.min2((unsigned)left.search_info.datetime[..8], (unsigned)right.search_info.datetime[..8]);
														self.search_info.stop_monitor 	:= map(left.search_info.datetime[..8] = right.search_info.datetime[..8] => '',
																																	(string)max((unsigned)left.search_info.datetime[..8], (unsigned)right.search_info.datetime[..8]));
														self := right), search_info.sequence_number, person_q.fname, person_q.lname, bus_q.cname, local);
										
	%pinfilepre3% :=	Inquiry_AccLogs.File_Bridger_Logs_Common + Inquiry_AccLogs.File_Inquiry_MBS(source = 'BRIDGER');
	
	%infilepre3% :=	
												inquiry_acclogs.fnCleanFunctions.rll2months(%pinfilepre3%); 

	%infile% :=  %infilepre1% + %infilepre2% + %infilepre3%;
	
#uniquename(mbs_outfile)
#uniquename(mbs_outfile_dedup_gcid)
#uniquename(mbs_outfile_dedup_cid)

%mbs_outfile% := Inquiry_AccLogs.File_MBS.FILE;
%mbs_outfile_dedup_gcid% := dedup(sort(distribute(%mbs_outfile%(gc_id <> ''), hash(gc_id)),gc_id, -priority_flag, allowflags,local),gc_id, local);
%mbs_outfile_dedup_cid% := dedup(sort(distribute(%mbs_outfile%(company_id <> '' and product_id <> '0'), hash(company_id)),company_id, product_id,-priority_flag, allowflags, local),company_id, product_id, local);

	%jnInFile1% := join(%infile%(mbs.company_id <> ''), %mbs_outfile_dedup_cid%,
	                   left.mbs.company_id = right.company_id and 
										 left.search_info.product_code = trim(right.product_id,all), 
											left outer, lookup);
														
	%jnInFile2% := project(%jnInFile1%(sub_acct_id = ''), recordof(%infile%));	
	
	%jnInFile3% := join(%jnInFile2% + %infile%(mbs.company_id = ''), %mbs_outfile_dedup_gcid%, 
											left.mbs.global_company_id = right.gc_id, 
											left outer, lookup);

	%jnInFile% := %jnInFile1%(sub_acct_id <> '') + %jnInFile3%;
	
#uniquename(jnFunctionNames)
#uniquename(transaction_desc1)
#uniquename(transaction_desc2)
#uniquename(transactions)
#uniquename(UFunction_name)
#uniquename(UTransaction_Type)
#uniquename(nrmUniqueID)
#uniquename(jnTransactions)
#uniquename(prTransactions)
#uniquename(rlTransactions)
#uniquename(forAccurint)
#uniquename(forAccurint1)
#uniquename(AllTransactions)

%transaction_desc1%	:= project(inquiry_acclogs.file_lookups.transaction_desc(function_name <> ''),
																		transform(recordof(inquiry_acclogs.file_lookups.transaction_desc),
																							self.function_name := stringlib.stringtouppercase(stringlib.stringfindreplace(left.function_name, '_','')), self := left));

%transaction_desc2%	:= project(inquiry_acclogs.file_lookups.transaction_desc(function_name <> ''),
																		transform(recordof(inquiry_acclogs.file_lookups.transaction_desc),
																							self.function_name := stringlib.stringtouppercase(stringlib.stringfindreplace(left.function_name, '_',' ')), self := left));

%transactions%			:= dedup(%transaction_desc2% + %transaction_desc1% + inquiry_acclogs.file_lookups.transaction_desc, record, all);

%nrmUniqueID%				:= dedup(normalize(inquiry_acclogs.File_UniqueID(valuecnt = 1), 2, 
															transform({string %UFunction_name%, string %UTransaction_Type%, recordof(inquiry_acclogs.File_UniqueID) - function_name},
																					self.%UFunction_name% := left.function_name;
																					self.%UTransaction_Type% := left.Transaction_Type;
																					self.long_name := stringlib.stringtouppercase(choose(counter, left.long_name, left.function_name));
																					self := left)), record, all);


%jnTransactions%		:= join(%transactions%, %nrmUniqueID%, 
												left.function_name = right.long_name and left.transaction_type = right.%utransaction_type%,
												full outer);
												
%prTransactions%		:= project(%jnTransactions%, transform({recordof(%jnTransactions%)},
																							self.function_name := stringlib.stringtouppercase(if(left.function_name = '' and left.%ufunction_name% <> '', left.%ufunction_name%,  left.function_name));
																							self.description := stringlib.stringtouppercase(map(left.function_name = '' and left.description = '' => left.long_name, 
																																				left.function_name <> '' and left.description = '' => left.function_name,
																																				left.description));
																							self.transaction_type :=stringlib.stringtouppercase( map(left.transaction_type = '' and left.%UTransaction_Type% <> '' => left.%UTransaction_Type%, 
																																				left.transaction_type));
																							self.long_name := stringlib.stringtouppercase(map(left.long_name = '' and left.function_name <> ''=> left.function_name, 
																																				left.long_name = '' and left.%ufunction_name% <> ''=> left.%ufunction_name%,
																																				// left.long_name = '' and left.description <> '' and left.%ufunction_name% = '' => left.description,
																																				left.long_name));
																							self := left));

%rlTransactions%		:= iterate(group(sort(%prTransactions%(%ufunction_name% <> ''), %ufunction_name%, -product_id), %ufunction_name%), transform({recordof(%prTransactions%)},
																							self.product_id := max(left.product_id, right.product_id);
																							self := right));
																							
%forAccurint1%				:= project(%prTransactions%(%ufunction_name% = '') + %rlTransactions%, transform({recordof(%rlTransactions%)}, 
																							self.long_name := trim(left.long_name, all);
																							self := left));
																							
%forAccurint%				:= project(%forAccurint1%, transform({recordof(%rlTransactions%)}, 
																							self.function_name := stringlib.stringtouppercase(map(left.function_name = '' and left.description = '' and left.long_name <>  ''=> left.long_name, 
																																				left.function_name = '' and left.description = '' and left.%ufunction_name% <> '' => left.%ufunction_name%,
																																				left.function_name));
																							self := left));
																							
%AllTransactions%		:= dedup(%rlTransactions% + %forAccurint% + %forAccurint1%, record, all);

#UNIQUENAME(outAppended)
#UNIQUENAME(fixDate)
#UNIQUENAME(fixTime)

%outAppended% :=	project(%jnInFile%,transform(recordof(%infile%),
															
															  self.mbs.company_id 			:= map(left.sub_acct_id = '' => left.mbs.company_id,
																													 left.internal_flag in ['Y','y'] and left.gc_id <> inquiry_acclogs.accounts_exclude.gc_id_not_internal => '', 
																													 left.company_id <> '' => left.company_id,
																												//	 left.company_id_finance <> '' => left.company_id_finance,
																												//	 left.billing_id <> '' => left.billing_id,
																												//	 left.banko_mn <> '' and left.sub_acct_idflag = 'MNID' => left.sub_acct_id,
																													 trim(left.mbs.company_id, left, right));
																self.mbs.global_company_id 	:= map(left.sub_acct_id = '' => left.mbs.global_company_id,
																													 left.gc_id <> '' => left.gc_id,
																													 trim(left.mbs.global_company_id, left, right));
																self.allow_flags.allowflags	:= map(left.sub_acct_id = '' => left.allow_flags.allowflags,
																													 left.allowflags > 0 => left.allowflags, 
																													 ut.bit_set(0,1) | ut.bit_set(0,13));
																		
																		%fixTime% := Inquiry_AccLogs.fncleanfunctions.tTimeAdded(left.search_info.datetime);
																self.search_info.datetime			 				:= %fixTime%;
																self.search_info.product_code			 		:= map(left.sub_acct_id = '' => left.search_info.product_code,
																													 left.product_id <> '' => left.product_id, 
																													 left.search_info.product_code);
																self.search_info.function_description	:= map(left.source = 'BATCHR3' and left.search_info.product_code = '1' => 'ACCURINT MONITORING',
																																						 left.source = 'BATCHR3' and left.search_info.product_code = '2' => 'RISKWISE MONITORING',
																																						 left.source = 'BATCHR3' and left.search_info.product_code = '5' => 'BANKRUPTCY MONITORING',
																																						 Inquiry_AccLogs.fnCleanFunctions.fnCleanUp(left.search_info.function_description));
																self.bus_intel.Primary_Market_Code 		:= map(left.sub_acct_id = '' => left.bus_intel.primary_market_code,
																																							left.primary_market_code);
																self.bus_intel.Secondary_Market_Code 	:= map(left.sub_acct_id = '' => left.bus_intel.secondary_market_code,
																																							left.Secondary_Market_Code);
																self.bus_intel.Industry_1_Code 				:= map(left.sub_acct_id = '' => left.bus_intel.industry_1_code,
																																							left.Industry_Code_1);
																self.bus_intel.Industry_2_Code 				:= map(left.sub_acct_id = '' => left.bus_intel.industry_2_code,
																																							left.Industry_Code_2);
																self.bus_intel.Sub_market							:= map(left.sub_acct_id = '' => left.bus_intel.sub_market,
																																							left.sub_market <> '' => left.sub_market, 
																																							'');
																self.bus_intel.Vertical 							:= map(left.sub_acct_id = '' => left.bus_intel.vertical,
																																							left.vertical <> '' => left.vertical, 
																																							'');
																self.bus_intel.Use 										:= map(left.sub_acct_id = '' => left.bus_intel.use, 
																																							left.use <> '' => left.use, 
																																							''); 
																self.bus_intel.Industry 							:= map(left.sub_acct_id = '' => left.bus_intel.industry,
																																							left.industry <> '' => left.industry, 
																																							'');																
																self := left)) 
																;				
																
#UNIQUENAME(ddpAppended)
#UNIQUENAME(Mnth6Rec)
#UNIQUENAME(indt)
#UNIQUENAME(crrdate)

%Mnth6Rec%(string %indt%, string %crrdate% = ut.GetDate) := 
		ut.DaysSince1900(%indt%[..4],%indt%[5..6],%indt%[7..8]) > (ut.DaysSince1900(%crrdate%[..4],%crrdate%[5..6],%crrdate%[7..8]) - 180) AND
		%crrdate% >= %indt%[..8];

%ddpAppended% := dedup(sort(%outAppended%(%Mnth6Rec%(search_info.datetime[..8])),
										person_q.fname, person_q.lname, search_info.transaction_id, search_info.transaction_type, search_info.sequence_number, search_info.function_description, search_info.datetime, search_info.login_history_id, search_info.product_code, local),
										person_q.fname, person_q.lname, search_info.transaction_id, search_info.transaction_type, search_info.sequence_number, search_info.function_description, search_info.datetime, search_info.login_history_id, search_info.product_code, local);

outfile := %ddpAppended% + dedup(%outAppended%(~%Mnth6Rec%(search_info.datetime[..8])),record,local);/*
											(
											 ~(mbs.company_id = '1446154' and search_info.product_code = '1' and search_info.function_description = 'RISKINDICATORS.FLEXIDBATCHSERVICE' and search_info.datetime[..6] between '201303' and '201304') and //TEMPORARY
											 ~(mbs.company_id = '1590195' and search_info.product_code = '1' and search_info.function_description = 'RISKINDICATORS.FLEXIDBATCHSERVICE' and search_info.datetime[..6] between '201304' and '201304') and //TEMPORARY
											 ~((mbs.company_id = '1534586' or mbs.global_company_id = '16952912') and search_info.function_description = 'FRAUDPOINT' and search_info.datetime[..6] between '201301' and '201302') and //TEMPORARY
												~inquiry_acclogs.fnTranslations.is_SubMarketFilter(allow_flags.allowflags) and
												~inquiry_acclogs.fnTranslations.is_IndustryFilter(allow_flags.allowflags) and
												~inquiry_acclogs.fnTranslations.is_VerticalFilter(allow_flags.allowflags) and
												~inquiry_acclogs.fnTranslations.is_Disable_Observation(allow_flags.allowflags) and
												~inquiry_acclogs.fnTranslations.is_Internal(allow_flags.allowflags) and
												~inquiry_acclogs.fnTranslations.is_AdditionalHealthcare(allow_flags.allowflags) and
											 mbs.company_id + mbs.global_company_id <> '');*/


endmacro;

export FCRA_Append(infile, outfile) := macro

#uniquename(jnInFile1)
#uniquename(jnInFile2)
#uniquename(jnInFileNCO)
#uniquename(jnInFile3)
#uniquename(jnInFile)
#uniquename(RefUnused)
#uniquename(InFile2)

#uniquename(mbs_outfile)
#uniquename(mbs_outfile_dedup_gcid)
#uniquename(mbs_outfile_dedup_cid)

%mbs_outfile% := Inquiry_AccLogs.File_MBS.FILE;
%mbs_outfile_dedup_gcid% := dedup(sort(distribute(%mbs_outfile%(gc_id <> ''), hash(gc_id)),gc_id, -priority_flag, allowflags,local),gc_id, local);
%mbs_outfile_dedup_cid% := dedup(sort(distribute(%mbs_outfile%(company_id <> '' and product_id <> '0'), hash(company_id)),company_id, product_id,-priority_flag, allowflags, local),company_id, product_id, local);

	%jnInFile1% := join(infile(mbs.company_id <> ''), %mbs_outfile_dedup_cid%,
	                   left.mbs.company_id = right.company_id and 
										 left.search_info.product_code = trim(right.product_id,all), 
											left outer, lookup);
														
	%jnInFile2% := project(%jnInFile1%(sub_acct_id = ''), recordof(infile));	
	
	%jnInFile3% := join(%jnInFile2% + infile(mbs.company_id = ''), %mbs_outfile_dedup_gcid%, 
											left.mbs.global_company_id = right.gc_id, 
											left outer, lookup);

	%jnInFile% := %jnInFile1%(sub_acct_id <> '') + %jnInFile3%;
	
#uniquename(jnFunctionNames)
#uniquename(transaction_desc1)
#uniquename(transaction_desc2)
#uniquename(transactions)
#uniquename(UFunction_name)
#uniquename(UTransaction_Type)
#uniquename(nrmUniqueID)
#uniquename(jnTransactions)
#uniquename(prTransactions)
#uniquename(rlTransactions)
#uniquename(forAccurint)
#uniquename(forAccurint1)
#uniquename(AllTransactions)

%transaction_desc1%	:= project(inquiry_acclogs.file_lookups.transaction_desc(function_name <> ''),
																		transform(recordof(inquiry_acclogs.file_lookups.transaction_desc),
																							self.function_name := stringlib.stringtouppercase(stringlib.stringfindreplace(left.function_name, '_','')), self := left));

%transaction_desc2%	:= project(inquiry_acclogs.file_lookups.transaction_desc(function_name <> ''),
																		transform(recordof(inquiry_acclogs.file_lookups.transaction_desc),
																							self.function_name := stringlib.stringtouppercase(stringlib.stringfindreplace(left.function_name, '_',' ')), self := left));

%transactions%			:= dedup(%transaction_desc2% + %transaction_desc1% + inquiry_acclogs.file_lookups.transaction_desc, record, all);

%nrmUniqueID%				:= dedup(normalize(inquiry_acclogs.File_UniqueID(valuecnt = 1), 2, 
															transform({string %UFunction_name%, string %UTransaction_Type%, recordof(inquiry_acclogs.File_UniqueID) - function_name},
																					self.%UFunction_name% := left.function_name;
																					self.%UTransaction_Type% := left.Transaction_Type;
																					self.long_name := stringlib.stringtouppercase(choose(counter, left.long_name, left.function_name));
																					self := left)), record, all);


%jnTransactions%		:= join(%transactions%, %nrmUniqueID%, 
												left.function_name = right.long_name and left.transaction_type = right.%utransaction_type%,
												full outer);
												
%prTransactions%		:= project(%jnTransactions%, transform({recordof(%jnTransactions%)},
																							self.function_name := stringlib.stringtouppercase(if(left.function_name = '' and left.%ufunction_name% <> '', left.%ufunction_name%,  left.function_name));
																							self.description := stringlib.stringtouppercase(map(left.function_name = '' and left.description = '' => left.long_name, 
																																				left.function_name <> '' and left.description = '' => left.function_name,
																																				left.description));
																							self.transaction_type :=stringlib.stringtouppercase( map(left.transaction_type = '' and left.%UTransaction_Type% <> '' => left.%UTransaction_Type%, 
																																				left.transaction_type));
																							self.long_name := stringlib.stringtouppercase(map(left.long_name = '' and left.function_name <> ''=> left.function_name, 
																																				left.long_name = '' and left.%ufunction_name% <> ''=> left.%ufunction_name%,
																																				// left.long_name = '' and left.description <> '' and left.%ufunction_name% = '' => left.description,
																																				left.long_name));
																							self := left));

%rlTransactions%		:= iterate(group(sort(%prTransactions%(%ufunction_name% <> ''), %ufunction_name%, -product_id), %ufunction_name%), transform({recordof(%prTransactions%)},
																							self.product_id := max(left.product_id, right.product_id);
																							self := right));
																							
%forAccurint1%				:= project(%prTransactions%(%ufunction_name% = '') + %rlTransactions%, transform({recordof(%rlTransactions%)}, 
																							self.long_name := trim(left.long_name, all);
																							self := left));
																							
%forAccurint%				:= project(%forAccurint1%, transform({recordof(%rlTransactions%)}, 
																							self.function_name := stringlib.stringtouppercase(map(left.function_name = '' and left.description = '' and left.long_name <>  ''=> left.long_name, 
																																				left.function_name = '' and left.description = '' and left.%ufunction_name% <> '' => left.%ufunction_name%,
																																				left.function_name));
																							self := left));
																							
%AllTransactions%		:= dedup(%rlTransactions% + %forAccurint% + %forAccurint1%, record, all);

	// %jnFunctionNames% := join(%jnInFile%(search_info.function_description = '' and search_info.transaction_type <> ''), 
														// distribute(dedup(%transaction_desc1% + %transaction_desc2% + inquiry_acclogs.file_lookups.transaction_desc, record, all)(function_name = ''), random()), 
														// left.search_info.product_code = right.product_id and
														// left.search_info.transaction_type = right.transaction_type,
															// transform(recordof(%jnInFile%),
																				// self.search_info.function_description := right.description;
																				// self := left), left outer, lookup)
														// + %jnInFile%(search_info.function_description <> '' or search_info.transaction_type = '');

#UNIQUENAME(outAppended)
#UNIQUENAME(fixDate)
#UNIQUENAME(fixTime)


%outAppended% :=	project(%jnInFile%,transform(recordof(infile),
															  bad_function_names := ['((H(Y','(H(Y','(HY','(HYH','(IUH(IUY',',(H,Y','<(H<Y','<H<Y','HY','L(HLY','LHLY','|(H|Y','|H|Y'];
																function_description := Inquiry_AccLogs.fnCleanFunctions.fnCleanUp(left.search_info.function_description);
															  self.mbs.company_id 			:= map(left.sub_acct_id = '' => left.mbs.company_id,
																													 left.internal_flag in ['Y','y'] and left.gc_id <> inquiry_acclogs.accounts_exclude.gc_id_not_internal => '', 
																													 left.company_id <> '' => left.company_id,
																													 //left.company_id_finance <> '' => left.company_id_finance,
																													 //left.billing_id <> '' => left.billing_id,
																													 //left.banko_mn <> '' and left.sub_acct_idflag = 'MNID' => left.sub_acct_id,
																													 trim(left.mbs.company_id, left, right));
																self.mbs.global_company_id 	:= map(left.sub_acct_id = '' => left.mbs.global_company_id,
																													 left.gc_id <> '' => left.gc_id,
																													 trim(left.mbs.global_company_id, left, right));
																self.allow_flags.allowflags	:= map(left.sub_acct_id = '' => left.allow_flags.allowflags,
																													 left.allowflags > 0 => left.allowflags, 
																													 ut.bit_set(0,1) | ut.bit_set(0,13));
																		
																		%fixTime% := Inquiry_AccLogs.fncleanfunctions.tTimeAdded(left.search_info.datetime);
																self.search_info.datetime			 				:= %fixTime%;
																self.search_info.product_code			 		:= map(left.sub_acct_id = '' => left.search_info.product_code,
																													 left.product_id <> '' => left.product_id, 
																													 left.search_info.product_code);
																self.search_info.function_description	:= map(left.source = 'BATCHR3' and left.search_info.product_code = '1' => 'ACCURINT MONITORING',
																																						 left.source = 'BATCHR3' and left.search_info.product_code = '2' => 'RISKWISE MONITORING',
																																						 left.source = 'BATCHR3' and left.search_info.product_code = '5' => 'BANKRUPTCY MONITORING',
																																						 function_description in bad_function_names and left.search_info.product_code = '2' => 'RISKVIEW APPLICATION',
																																						 left.mbs.company_id in ['101611','101761','102501','103661','103201'] and left.search_info.product_code = '2' and function_description = 'RISKVIEW PRE-SCREENING' => 'RISKVIEW APPLICATION',
																																						 function_description);
																self.bus_intel.Primary_Market_Code 		:= map(left.sub_acct_id = '' => left.bus_intel.primary_market_code,
																																							left.primary_market_code);
																self.bus_intel.Secondary_Market_Code 	:= map(left.sub_acct_id = '' => left.bus_intel.secondary_market_code,
																																							left.Secondary_Market_Code);
																self.bus_intel.Industry_1_Code 				:= map(left.sub_acct_id = '' => left.bus_intel.industry_1_code,
																																							left.Industry_Code_1);
																self.bus_intel.Industry_2_Code 				:= map(left.sub_acct_id = '' => left.bus_intel.industry_2_code,
																																							left.Industry_Code_2);
																self.bus_intel.Sub_market							:= map(left.sub_acct_id = '' => left.bus_intel.sub_market,
																																							left.sub_market <> '' => left.sub_market, 
																																							'');
																self.bus_intel.Vertical 							:= map(left.sub_acct_id = '' => left.bus_intel.vertical,
																																							left.vertical <> '' => left.vertical, 
																																							'');
																self.bus_intel.Use 										:= map(left.sub_acct_id = '' => left.bus_intel.use, 
																																							left.use <> '' => left.use, 
																																							''); 
																self.bus_intel.Industry 							:= map(left.sub_acct_id = '' => left.bus_intel.industry,
																																							left.industry <> '' => left.industry, 
																																							'');		
																self.permissions.fcra_purpose					:= map(left.mbs.company_id in ['101611','101761','102501'] and left.search_info.product_code = '2' and left.permissions.fcra_purpose in ['150','156'] => '100',
																																						 left.mbs.company_id in ['108516'] and left.search_info.product_code = '2' and left.permissions.fcra_purpose in ['100'] and left.search_info.datetime[..8] between '20120807' and '20121109' => '164',
																																						 left.mbs.company_id in ['108526'] and left.search_info.product_code = '2' and left.permissions.fcra_purpose in ['100'] and left.search_info.datetime[..8] between '20120622' and '20120810' => '164',
																																						 left.mbs.company_id in ['108246'] and left.search_info.product_code = '2' and left.permissions.fcra_purpose in ['100'] and left.search_info.datetime[..8] between '20120524' and '20121231' => '164',
																																						 left.permissions.fcra_purpose);

																self := left)) ;							

outfile := %outAppended%;/*(
											 ~(mbs.company_id = '103201' and search_info.product_code = '2' and search_info.function_description = 'RWBATCH' and search_info.datetime[..8] between '20120223' and '20120225') and //TEMPORARY
											 ~(mbs.company_id = '103201' and search_info.product_code = '2' and search_info.function_description = 'RWBATCH' and search_info.datetime[..8] between '20120514' and '20130515') and //TEMPORARY
											 ~(mbs.company_id = '108006' and search_info.product_code = '2' and search_info.function_description = 'MODELS.RISKVIEWBATCHSERVICE' and search_info.datetime[..8] between '20130901' and '20131031') and
											 ~(mbs.company_id = '112755' and search_info.product_code = '2' and search_info.function_description = 'MODELS.RISKVIEWBATCHSERVICE' and search_info.datetime[..8] between '20130901' and '20130930') and
												~inquiry_acclogs.fnTranslations.is_SubMarketFilter(allow_flags.allowflags) and
												~inquiry_acclogs.fnTranslations.is_IndustryFilter(allow_flags.allowflags) and
												~inquiry_acclogs.fnTranslations.is_VerticalFilter(allow_flags.allowflags) and
												~inquiry_acclogs.fnTranslations.is_Disable_Observation(allow_flags.allowflags) and
												~inquiry_acclogs.fnTranslations.is_Internal(allow_flags.allowflags) and 
											  ~inquiry_acclogs.fnTranslations.is_AdditionalHealthcare(allow_flags.allowflags) and
											 mbs.company_id + mbs.global_company_id <> '' 
											); //temporary*/

endmacro;


end;
