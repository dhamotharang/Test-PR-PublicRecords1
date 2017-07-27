export File_MBSApp(pInfile, source = '', isfcra = '', outfile) := macro

#uniquename(infile)
%infile% := distribute(pInfile, random());

#uniquename(fnCleanUp)
#uniquename(instring)
%fnCleanUp%(string %instring%) := stringlib.stringtouppercase(stringlib.stringfilterout(
																		regexreplace('^COLLECTION$',
																			trim(stringlib.stringcleanspaces(stringlib.stringtouppercase(%instring%)), left, right), 
																				'COLLECTIONS'),
																					'?'));

#uniquename(mbs_outfile)
%mbs_outfile% := distribute(Inquiry_AccLogs.File_MBS.File(current), random());


#uniquename(prod_id)
		%prod_id% := map(stringlib.stringtouppercase(source) = 'BATCH' => '',
										 stringlib.stringtouppercase(source) = 'BATCHR3' =>  '', 
										 stringlib.stringtouppercase(source) = 'BATCH R3' =>  '', 
										 stringlib.stringtouppercase(source) = 'PRODR3' =>  '', 
										 stringlib.stringtouppercase(source) = 'PROD R3' =>  '', 
										 stringlib.stringtouppercase(source) = 'RISKWISE' => '2', 
										 stringlib.stringtouppercase(source) = 'BANKO' =>  '5', 
										 stringlib.stringtouppercase(source) = 'BATCHBANKO' =>  '5', 
										 stringlib.stringtouppercase(source) = 'BATCH BANKO' =>  '5', 
										 stringlib.stringtouppercase(source) = 'BANKOBATCH' =>  '5', 
										 stringlib.stringtouppercase(source) = 'BANKO BATCH' =>  '5',
										 '1' /* ACCURINT CUSTOM NCO DAYTON */);


#uniquename(jnInFile)
#uniquename(jnInFile1)
#uniquename(jnInFile2)
#uniquename(jnInFile3)

#IF(source in ['ACCURINT','CUSTOM','RISKWISE', 'BANKO'])
	%jnInFile1% := join(%infile%, 
									    %mbs_outfile%(product_id <> ''), 
									   trim(left.orig_company_id,all) = trim(right.id,all) and 
										 %prod_id% = trim(right.product_id,all), 
														left outer, lookup);	
														
	%jnInFile2% := join(%jnInFile1%(id = ''), 
									   %mbs_outfile%(idflag = 'GCID'), 
									   trim(left.orig_global_company_id,all) = trim(right.id,all),
												transform(recordof(%jnInFile1%), self := right, self := left),
														left outer, lookup);

	%jnInFile% := %jnInFile1%(id <> '') + %jnInFile2%;
	

#ELSE													
	%jnInFile% := join(%infile%, 
									   %mbs_outfile%(idflag = 'GCID'), 
									   trim(left.orig_global_company_id,all) = trim(right.id,all),
														left outer, lookup);
#END
														
#uniquename(jnFunctionNames)
#uniquename(transaction_desc1)
#uniquename(transaction_desc2)

	%transaction_desc1% := project(inquiry_acclogs.file_lookups.transaction_desc(function_name <> ''),
																		transform(recordof(inquiry_acclogs.file_lookups.transaction_desc),
																							self.function_name := stringlib.stringfindreplace(left.function_name, '_',''), self := left));

	%transaction_desc2% := project(inquiry_acclogs.file_lookups.transaction_desc(function_name <> ''),
																		transform(recordof(inquiry_acclogs.file_lookups.transaction_desc),
																							self.function_name := stringlib.stringfindreplace(left.function_name, '_',' '), self := left));

	%jnFunctionNames% := join(%jnInFile%, (%transaction_desc1% + %transaction_desc2% + inquiry_acclogs.file_lookups.transaction_desc)(function_name <> ''), 
														left.product_id = right.product_id and
														map(left.product_id = '1' => left.orig_transaction_type, '') = map(left.product_id = '1' => right.transaction_type, '') and
														stringlib.stringtouppercase(left.orig_function_name) = stringlib.stringtouppercase(right.function_name),
														transform({recordof(%jnInFile%), string Description, inquiry_acclogs.File_UniqueID.unique_id_code},
																self.orig_company_id := trim(map(left.company_id <> '' => left.company_id, 
																																 left.company_id_finance <> '' => left.company_id_finance,
																																 left.billing_id <> '' => left.billing_id,
																																 left.banko_mn <> '' and left.idflag = 'MNID' => left.id,
																																 left.orig_company_id <> '' => left.orig_company_id, ''), left, right);
																self.orig_global_company_id	:= trim(map(left.gc_id <> '' => left.gc_id, 
																														left.orig_global_company_id <> '' => left.orig_global_company_id, ''), left, right);
																
																self.Primary_Market_Code 		:= map(left.mbs_primary_market_code <> '' => left.mbs_primary_market_code, left.primary_market_code);
																self.Secondary_Market_Code 	:= map(left.mbs_Secondary_Market_Code <> '' => left.mbs_Secondary_Market_Code, left.Secondary_Market_Code);
																self.Industry_Code_1 				:= map(left.mbs_Industry_Code_1 <> '' => left.mbs_Industry_Code_1, left.Industry_Code_1);
																self.Industry_Code_2 				:= map(left.mbs_Industry_Code_2 <> '' => left.mbs_Industry_Code_2, left.Industry_Code_2);
																
																self.description 					:= %fnCleanUp%(right.description),
																self.orig_function_name 	:= %fnCleanUp%(left.orig_function_name);
																self.unique_id_code := '';
																self.allowflags := map(left.allowflags > 0 => left.allowflags, ut.bit_set(0,1) | ut.bit_set(0,13));
																self := left), 
														left outer, lookup);


#uniquename(jUniqueID)
#uniquename(jUniqueID1)

	%juniqueid1% := join(%jnFunctionNames%, inquiry_acclogs.File_UniqueID(valuecnt = 1), 
											trim(stringlib.stringtouppercase(left.orig_function_name)) = trim(stringlib.stringtouppercase(right.long_name)),
										TRANSFORM({recordof(%jnFunctionNames%)},
											self.unique_id_code := right.unique_id_code,
											self := LEFT), left outer, lookup);

#if(%prod_id% = '1' and source not in ['NCO','BATCHR3','BATCH R3','PRODR3','PROD R3'])

	%juniqueid% := join(%juniqueid1%, inquiry_acclogs.File_UniqueID(valuecnt = 1), 
											stringlib.stringtouppercase(trim(left.description, all)) = stringlib.stringtouppercase(trim(right.long_name, all)),
										TRANSFORM(recordof(%juniqueid1%),
											self.unique_id_code := if(left.unique_id_code = '', right.unique_id_code, left.unique_id_code);
											self := LEFT), left outer, lookup);

#else
	%juniqueid% := %jnFunctionNames%;

#end

outfile := 	%jUniqueID%
											(Vertical not in inquiry_acclogs.FnCleanFunctions.FilterCds and	//remove records with certain verticals
											 allowflags & ut.bit_set(0,12) <> ut.bit_set(0,12) and
											 (orig_company_id <> '' or orig_global_company_id <> '') and
											 (source = 'NCO' or internal_flag not in ['Y','y']))											//remove records with disable set to true
;									

endmacro;

