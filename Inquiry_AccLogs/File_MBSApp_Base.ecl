import ut;

export File_MBSApp_base(string version = ut.GetDate) := module

export file := dataset('~thor10_11::out::inquiry_tracking::weekly_historical', recordof(inquiry_acclogs.File_Inquiry_BaseSourced.Full), thor);

export Append(outfile, in_pversion = '') := macro

#uniquename(fnCleanUp)
#uniquename(instring)
%fnCleanUp%(string %instring%) := stringlib.stringtouppercase(stringlib.stringfilterout(
																		regexreplace('^COLLECTION$',
																			trim(stringlib.stringcleanspaces(stringlib.stringtouppercase(%instring%)), left, right), 
																				'COLLECTIONS'),
																					'?'));


#uniquename(prev_version)
#uniquename(logicalfilename)
%logicalfilename% := fileservices.superfilecontents('~thor10_11::out::inquiry_tracking::weekly_historical')[1].name;
%prev_version% := (unsigned)%logicalfilename%[stringlib.stringfind(%logicalfilename%, '::', 3) + 2 .. stringlib.stringfind(%logicalfilename%, '::', 4) -1];

#uniquename(mbs_outfile)
%mbs_outfile% := Inquiry_AccLogs.File_MBS.File(current); // for full file refresh, use all mbs records

#uniquename(jnInFile1)
#uniquename(jnInFile2)
#uniquename(jnInFileNCO)
#uniquename(jnInFile)
#uniquename(inFilePre1)
#uniquename(inFilePre2)
#uniquename(pinFilePre2)
#uniquename(inFilePre)
#uniquename(inFile)
#uniquename(RefUnused)


	%infilepre1% := 	dedup(sort(distribute(
											inquiry_acclogs.fnAddSource(inquiry_acclogs.File_Accurint_Logs_Common, 'ACCURINT') +
											inquiry_acclogs.fnAddSource(inquiry_acclogs.File_Custom_Logs_Common, 'CUSTOM') +
											inquiry_acclogs.fnAddSource(inquiry_acclogs.File_Banko_Logs_Common, 'BANKO') + 
											inquiry_acclogs.fnAddSource(inquiry_acclogs.File_Riskwise_Logs_Common, 'RISKWISE'),															
										hash(search_info.transaction_id)), search_info.transaction_id, local), search_info.transaction_id, local) +

										dedup(sort(distribute(
											inquiry_acclogs.fnAddSource(Inquiry_AccLogs.File_Batch_Logs_Common, 'BATCH'),
										hash(search_info.transaction_id, search_info.sequence_number, search_info.function_description)), search_info.transaction_id, search_info.sequence_number, search_info.function_description, local), search_info.transaction_id, search_info.sequence_number, search_info.function_description, local) +

										dedup(sort(distribute(
											inquiry_acclogs.fnAddSource(Inquiry_AccLogs.File_BatchR3_Logs_Common(search_info.function_description not in ['BANKRUPTCY MONITORING']), 'BATCHR3'),
										hash(search_info.datetime, search_info.sequence_number)), search_info.datetime, search_info.sequence_number, local), search_info.datetime, search_info.sequence_number, local) +
										
										distribute(
											project(Inquiry_AccLogs.File_Inquiry_MBS, {inquiry_acclogs.Layout.common, string source}),
										random())
										;
										
	%pinfilepre2% :=	dedup(sort(distribute(
											inquiry_acclogs.fnAddSource(inquiry_acclogs.File_BankoBatch_Logs_Common, 'BANKO_BATCH') +
											inquiry_acclogs.fnAddSource(Inquiry_AccLogs.File_BatchR3_Logs_Common(search_info.function_description in ['BANKRUPTCY MONITORING']), 'BATCHR3'),
										hash(search_info.sequence_number)), 
										search_info.sequence_number, person_q.fname, person_q.lname, bus_q.cname, search_info.datetime, local), 
										search_info.sequence_number, person_q.fname, person_q.lname, bus_q.cname, search_info.datetime, local)
										; 

#UNIQUENAME(strMin2)										
	%infilepre2% :=	 rollup(%pinfilepre2%, transform(recordof(%pinfilepre2%),
	
	%strMin2%(string L, string R) :=  if ( l='' or l>r and r<>'', r, l );
	
														self.search_info.datetime 			:= %strMin2%(left.search_info.datetime, right.search_info.datetime);
														self.search_info.start_monitor 	:= (string)ut.min2((unsigned)left.search_info.datetime[..8], (unsigned)right.search_info.datetime[..8]);
														self.search_info.stop_monitor 	:= map(left.search_info.datetime[..8] = right.search_info.datetime[..8] => '',
																																	(string)max((unsigned)left.search_info.datetime[..8], (unsigned)right.search_info.datetime[..8]));
														self := right), search_info.sequence_number, person_q.fname, person_q.lname, bus_q.cname, local);
								
	%infile% :=  %infilepre1% + %infilepre2%;
	
#UNIQUENAME(mbs_with_nco)
	%mbs_with_nco% := dedup(%mbs_outfile%(idflag <> 'GCID'), id, product_id, all) + dedup(%mbs_outfile%(idflag = 'GCID'), id, all);

	%jnInFile1% := join(%infile%(mbs.global_company_id <> ''), %mbs_with_nco%(idflag = 'GCID'),
											left.mbs.global_company_id = right.id, 
												left outer, lookup);	
														
	%jnInFile2% := join(%infile%(mbs.global_company_id = ''), %mbs_with_nco%(idflag <> 'GCID'), 
									   left.mbs.company_id = right.id and 
										 left.search_info.product_code = trim(right.product_id,all), 
											left outer, lookup);

	%jnInFile% := %jnInFile1% + %jnInFile2%;

#UNIQUENAME(outAppended)
#UNIQUENAME(fixDate)
#UNIQUENAME(fixTime)

%outAppended% :=	project(%jnInFile%(id <> ''),transform(recordof(%infile%),
															
															  self.mbs.company_id := map(left.internal_flag in ['Y','y'] and left.source <> 'NCO' => '', 
																													 left.company_id <> '' => left.company_id,
																													 left.company_id_finance <> '' => left.company_id_finance,
																													 left.billing_id <> '' => left.billing_id,
																													 left.banko_mn <> '' and left.idflag = 'MNID' => left.id,
																													 trim(left.mbs.company_id, left, right));
																self.mbs.global_company_id := map(left.gc_id <> '' => left.gc_id,
																													 trim(left.mbs.global_company_id, left, right));
																self.allow_flags.allowflags 					:= map(left.allowflags > 0 => left.allowflags, ut.bit_set(0,1) | ut.bit_set(0,13));
																		
																		%fixTime% := Inquiry_AccLogs.fncleanfunctions.tTimeAdded(left.search_info.datetime);
																self.search_info.datetime			 				:= %fixTime%;
																self.search_info.product_code			 		:= map(left.product_id <> '' => left.product_id, left.search_info.product_code);
																self.search_info.function_description	:= map(left.source = 'BATCHR3' and left.search_info.product_code = '1' => 'ACCURINT MONITORING',
																																						 left.source = 'BATCHR3' and left.search_info.product_code = '2' => 'RISKWISE MONITORING',
																																						 left.source = 'BATCHR3' and left.search_info.product_code = '5' => 'BANKRUPTCY MONITORING',
																																						 Inquiry_AccLogs.fnCleanFunctions.fnCleanUp(left.search_info.function_description));
																self.bus_intel.Primary_Market_Code 		:= map(left.mbs_primary_market_code <> '' => left.mbs_primary_market_code, left.primary_market_code);
																self.bus_intel.Secondary_Market_Code 	:= map(left.mbs_Secondary_Market_Code <> '' => left.mbs_Secondary_Market_Code, left.Secondary_Market_Code);
																self.bus_intel.Industry_1_Code 				:= map(left.mbs_Industry_Code_1 <> '' => left.mbs_Industry_Code_1, left.Industry_Code_1);
																self.bus_intel.Industry_2_Code 				:= map(left.mbs_Industry_Code_2 <> '' => left.mbs_Industry_Code_2, left.Industry_Code_2);
																self.bus_intel.Sub_market							:= if(left.sub_market <> '', left.sub_market, '');
																self.bus_intel.Vertical 							:= if(left.vertical <> '', left.vertical, '');
																self.bus_intel.Use 										:= if(left.use <> '', left.use, ''); 
																self.bus_intel.Industry 							:= if(left.industry <> '', left.industry, '');																
																self := left)) 
									+ 
									project(%jnInFile%(id = ''),transform(recordof(%infile%),
																
																		%fixTime% := Inquiry_AccLogs.fncleanfunctions.tTimeAdded(left.search_info.datetime);
																self.search_info.datetime			 				:= %fixTime%;
																self.search_info.function_description	:= map(left.source = 'BATCHR3' and left.search_info.product_code = '1' => 'ACCURINT MONITORING',
																																						 left.source = 'BATCHR3' and left.search_info.product_code = '2' => 'RISKWISE MONITORING',
																																						 left.source = 'BATCHR3' and left.search_info.product_code = '5' => 'BANKRUPTCY MONITORING',
																																						 Inquiry_AccLogs.fnCleanFunctions.fnCleanUp(left.search_info.function_description));
																self := left))
																;									

outfile := %outAppended%
											(bus_intel.Vertical not in inquiry_acclogs.FnCleanFunctions.FilterCds and	//remove records with certain verticals
											 allow_flags.allowflags & ut.bit_set(0,12) <> ut.bit_set(0,12) and
											 mbs.company_id + mbs.global_company_id <> '');


endmacro;

export FCRA_Append(infile, outfile) := macro

#uniquename(jnInFile1)
#uniquename(jnInFile2)
#uniquename(jnInFileNCO)
#uniquename(jnInFile)
#uniquename(RefUnused)

#UNIQUENAME(mbs_with_nco)

	%mbs_with_nco% := dedup(Inquiry_AccLogs.File_MBS.File(idflag <> 'GCID' and current), id, product_id, all) + dedup(Inquiry_AccLogs.File_MBS.File(idflag = 'GCID' and current), id, all);

	%jnInFile1% := join(infile(mbs.global_company_id <> ''), %mbs_with_nco%(idflag = 'GCID'),
											left.mbs.global_company_id = right.id, 
												left outer, lookup);	
														
	%jnInFile2% := join(infile(mbs.global_company_id = ''), %mbs_with_nco%(idflag <> 'GCID'), 
									   left.mbs.company_id = right.id and 
										 left.search_info.product_code = trim(right.product_id,all), 
											left outer, lookup);

	%jnInFile% := %jnInFile1% + %jnInFile2%;

#UNIQUENAME(outAppended)

%outAppended% := project(%jnInFile%(id <> '' and (source = 'NCO' or internal_flag not in ['Y','y'])),transform(recordof(infile),
															
															  self.mbs.company_id := map(left.internal_flag in ['Y','y'] and left.source <> 'NCO' => '', 
																													 left.company_id <> '' => left.company_id,
																													 left.company_id_finance <> '' => left.company_id_finance,
																													 left.billing_id <> '' => left.billing_id,
																													 left.banko_mn <> '' and left.idflag = 'MNID' => left.id,
																													 trim(left.mbs.company_id, left, right));
																self.mbs.global_company_id := map(left.gc_id <> '' => left.gc_id,
																													 trim(left.mbs.global_company_id, left, right));
																self.allow_flags.allowflags 					:= map(left.allowflags > 0 => left.allowflags, ut.bit_set(0,1) | ut.bit_set(0,13));
																self.search_info.product_code			 		:= map(left.product_id <> '' => left.product_id, left.search_info.product_code);
																self.bus_intel.Primary_Market_Code 		:= map(left.mbs_primary_market_code <> '' => left.mbs_primary_market_code, left.primary_market_code);
																self.bus_intel.Secondary_Market_Code 	:= map(left.mbs_Secondary_Market_Code <> '' => left.mbs_Secondary_Market_Code, left.Secondary_Market_Code);
																self.bus_intel.Industry_1_Code 				:= map(left.mbs_Industry_Code_1 <> '' => left.mbs_Industry_Code_1, left.Industry_Code_1);
																self.bus_intel.Industry_2_Code 				:= map(left.mbs_Industry_Code_2 <> '' => left.mbs_Industry_Code_2, left.Industry_Code_2);
																self.bus_intel.Sub_market							:= if(left.sub_market <> '', left.sub_market, '');
																self.bus_intel.Vertical 							:= if(left.vertical <> '', left.vertical, '');
																self.bus_intel.Use 										:= if(left.use <> '', left.use, ''); 
																self.bus_intel.Industry 							:= if(left.industry <> '', left.industry, '');
																self.search_info.function_description	:= map(left.source = 'BATCHR3' and left.search_info.product_code = '1' => 'ACCURINT MONITORING',
																																						 left.source = 'BATCHR3' and left.search_info.product_code = '2' => 'RISKWISE MONITORING',
																																						 left.source = 'BATCHR3' and left.search_info.product_code = '5' => 'BANKRUPTCY MONITORING',
																																						 Inquiry_AccLogs.fnCleanFunctions.fnCleanUp(left.search_info.function_description));
																self := left)) + project(%jnInFile%(id = ''), recordof(infile));									

outfile := %outAppended%
											(bus_intel.Vertical not in inquiry_acclogs.FnCleanFunctions.FilterCds and	//remove records with certain verticals
											 allow_flags.allowflags & ut.bit_set(0,12) <> ut.bit_set(0,12) and
											 mbs.company_id + mbs.global_company_id <> '');

endmacro;


end;
