
export File_MBSApp(pInfile, source = '', isfcra = '', outfile) := macro

#uniquename(infile)
											
%infile% := distribute(pInfile, random());

#uniquename(fnCleanUp)
#uniquename(instring)

#uniquename(mbs_outfile)
#uniquename(mbs_outfile_dedup_gcid)
#uniquename(mbs_outfile_dedup_cid)

%mbs_outfile% := Inquiry_AccLogs.File_MBS.FILE;
%mbs_outfile_dedup_gcid% := dedup(sort(distribute(%mbs_outfile%(gc_id <> ''), hash(gc_id)),gc_id, -priority_flag, allowflags,local),gc_id, local);
%mbs_outfile_dedup_cid% := dedup(sort(distribute(%mbs_outfile%(company_id <> '' and product_id <> '0'), hash(company_id)),
company_id, product_id, -priority_flag, allowflags, local),company_id, product_id, local);


#uniquename(prod_id)
		%prod_id% := map(stringlib.stringtouppercase(source) = 'BATCH' => '',
										 stringlib.stringtouppercase(source) = 'BATCHR3' =>  '', 
										 stringlib.stringtouppercase(source) = 'BATCH R3' =>  '', 
										 stringlib.stringtouppercase(source) = 'IDM' =>  '7', 
										 stringlib.stringtouppercase(source) = 'BLS' =>  '7', 
										 stringlib.stringtouppercase(source) = 'IDM_BLS' =>  '7', 
										 stringlib.stringtouppercase(source) = 'IDM/BLS' =>  '7', 
										 stringlib.stringtouppercase(source) = 'PRODR3' =>  '', 
										 stringlib.stringtouppercase(source) = 'PROD R3' =>  '', 
										 stringlib.stringtouppercase(source) = 'RISKWISE' => '2', 
										 stringlib.stringtouppercase(source) = 'BANKO' =>  '5', 
										 stringlib.stringtouppercase(source) = 'BATCHBANKO' =>  '5', 
										 stringlib.stringtouppercase(source) = 'BATCH BANKO' =>  '5', 
										 stringlib.stringtouppercase(source) = 'BANKOBATCH' =>  '5', 
										 stringlib.stringtouppercase(source) = 'BANKO BATCH' =>  '5',
										 '1' /* ACCURINT CUSTOM NCO DAYTON BRIDGER*/);


#uniquename(jnInFile)
#uniquename(jnInFile1)
#uniquename(jnInFile2)

#IF(source not in ['BATCH','BATCHR3','BATCH R3','PROD R3','PRODR3'])
	%jnInFile1% := join(%infile%, 
									    %mbs_outfile_dedup_cid%(product_id = %prod_id%), 
									   trim(left.orig_company_id,all) = trim(right.company_id,all),
										 left outer, lookup);					
	%jnInFile2% := join(project(%jnInFile1%(sub_acct_id = ''), recordof(%infile%)),
									   %mbs_outfile_dedup_gcid%,  
									   trim(left.orig_global_company_id,all) = trim(right.gc_id,all),
											left outer, lookup);								
	
	%jnInFile% := %jnInFile1%(sub_acct_id <> '') + %jnInFile2%;
	

#ELSE													
	%jnInFile% := join(%infile%, 
									   %mbs_outfile_dedup_gcid%, 
									   trim(left.orig_global_company_id,all) = trim(right.gc_id,all),
										 left outer, lookup);
#END
																				
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
																							
%AllTransactions%		:= dedup(%rlTransactions% + %forAccurint% + %forAccurint1%, record, all) : independent;

%jnFunctionNames% := join(%jnInFile%, %AllTransactions%, 
														left.product_id = right.product_id and
														map(left.product_id = '1' => left.orig_transaction_type, '') = map(left.product_id = '1' => right.transaction_type, '') and
														stringlib.stringtouppercase(left.orig_function_name) = stringlib.stringtouppercase(right.function_name),
														transform({recordof(%jnInFile%), string Description, inquiry_acclogs.File_UniqueID.unique_id_code},
																self.orig_company_id := trim(map(left.company_id <> '' => left.company_id, 
																																// left.company_id_finance <> '' => left.company_id_finance,
																																 //left.billing_id <> '' => left.billing_id,
																															//	 left.banko_mn <> '' and left.idflag = 'MNID' => left.id,
																																 left.orig_company_id <> '' => left.orig_company_id, ''), left, right);
																self.orig_global_company_id	:= trim(map(left.gc_id <> '' => left.gc_id, 
																														left.orig_global_company_id <> '' => left.orig_global_company_id, ''), left, right);
																/*
																self.Primary_Market_Code 		:= map(left.primary_market_code <> '' => left.primary_market_code, left.primary_market_code);
																self.Secondary_Market_Code 	:= map(left.Secondary_Market_Code <> '' => left.Secondary_Market_Code, left.Secondary_Market_Code);
																self.Industry_Code_1 				:= map(left.Industry_Code_1 <> '' => left.Industry_Code_1, left.Industry_Code_1);
																self.Industry_Code_2 				:= map(left.Industry_Code_2 <> '' => left.Industry_Code_2, left.Industry_Code_2);
																*/
																self.description 					:= Inquiry_AccLogs.fncleanfunctions.fnCleanUp(right.description);
																self.orig_function_name 	:= Inquiry_AccLogs.fncleanfunctions.fnCleanUp(left.orig_function_name);
																self.unique_id_code := right.unique_id_code;
																self.allowflags := map(left.allowflags > 0 => left.allowflags, ut.bit_set(0,1) | ut.bit_set(0,13));
																self := left), 
														left outer, lookup);
#uniquename(keeplist)
%keeplist% := 'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789';														
outfile := join(	%jnFunctionNames%,dedup(inquiry_acclogs.File_Function_Description_Rollups,rollup_string,all),
									right.rollup_string = stringlib.stringfilter(left.Orig_function_name, %keeplist%),
									transform({recordof(%jnFunctionNames%)},
										self.description := if(right.rollup_string <> '', right.selected_version, left.description);
										self := left), lookup, left outer);
									

 
endmacro;

