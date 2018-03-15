import ut, watchdog, did_add, header, did_add, address, lib_fileservices, lib_stringlib, ut, header_slimsort, didville, watchdog, idl_header;;

/****** SAMPLE CODE *********************************************************************************************/
/*
inquiry_acclogs._InquiryRecordTesting.WatchDog_PersonData(, //vertical
																													['COLLECTIONS'], //industry
																													, //product-function_description
																													3025, //output record count
																													'20110408', //start date for search
																													, //end date for search
																													true, //opt-ins only
																													''); //wu for previous work
*/
/****** END SAMPLE CODE *****************************************************************************************/

export _InquiryRecordTesting := module

export Randomize := record
	unsigned8 random_number;
 end;

export Output_Internal := record
	STRING5  title; 
	STRING20 fname;
	STRING20 mname;
	STRING20 lname;
	STRING5  name_suffix;	
	string10 prim_range ;
	string2  predir ;
	string28 prim_name ;
	string4  addr_suffix ;
	string2  postdir ;
	string10 unit_desig ;
	string8  sec_range ;
	string25 v_city_name ;
	string2  st ;
	string5  zip5 ;
	string4  zip4 ;
	string LinkID;
	string ssn;
	string	Primary_Market_Code;
	string	Secondary_Market_Code;
	string	Industry_1_Code;
	string	Industry_2_Code;
	string	Sub_market;
	string	Vertical;
	string	Use; 
	string	Industry; 
	string	Function_Description;
	unsigned6 Appended_ADL;
	string Appended_SSN;
	string hashid;
	unsigned count_records := 0;
	string8 date_f;
	unsigned date_bucket;
 end;
 
export Output_Customer := RECORD
  unsigned acct_no;
  string watchdog_fname := '';
  string watchdog_mname := '';
  string watchdog_lname := '';
  string watchdog_sname := '';
  string watchdog_address_line1 := '';
  string watchdog_address_line_2 := '';
  string watchdog_address_last_line := '';
  string watchdog_ssn := '';
	string watchdog_hashID := '';
END;

export WatchDog_PersonData(set of string pVertical = [''], set of string pIndustry = [''], set of string pFunction = [''], unsigned number_out = 1000000, string start_date, string end_date = ut.getdate, boolean opt_in_only = false, string paramwu_, boolean fast_match = false) := function

// #WORKUNIT('name','Inquiry Tracking Testing Extract')
// #OPTION('allowedClusters', 'thor400_84,thor400_92')// comment out if not on prod thor or cluster names change

wu_ := if(paramwu_ <> '', paramwu_, workunit);

// added inquiry_acclogs.Key_Inquiry_DID_Update to the input 
filtDates := (PULL(inquiry_acclogs.Key_Inquiry_DID) + pull(inquiry_acclogs.Key_Inquiry_DID_Update)) (search_info.datetime[1..8] between start_date and end_date);

filtADL := filtdates(person_q.appended_adl > 0);

// map(left.opt_out = '1' => ut.bit_set(0,13), ut.bit_set(0,0))) //opt out of raw data reporting
filtOpts := if(opt_in_only, filtADL(ut.bit_set(0,13) <> Allow_Flags.allowflags & ut.bit_set(0,13)), filtADL);


//filter by vertical, industry, and/or function-product
filtParameters := filtOpts(if('' not in pvertical, stringlib.stringtouppercase(bus_intel.vertical) in pVertical, person_q.appended_adl > 0) and
													 if('' not in pIndustry, stringlib.stringtouppercase(bus_intel.industry) in pIndustry, person_q.appended_adl > 0) and
													 if('' not in pFunction, stringlib.stringtouppercase(search_info.function_description) in pFunction, person_q.appended_adl > 0)
													);

//filter out records with no name or address
filtNameAddrPopulation := filtParameters(person_q.fname <> '' and 
																				 person_q.lname <> '' and 
																				 person_q.prim_range + person_q.prim_name <> '' and 
																				 person_q.zip5 <> '' and 
																				 person_q.ssn <> '');


Mac_Efficient_Table := project(filtNameAddrPopulation, 
															 transform({Output_Customer, Output_Internal, Randomize},
																					self.watchdog_hashID := (string)hash(left.person_q.appended_adl);
																					self.hashID := self.watchdog_hashID;
																				  self.acct_no := 0;
																					self.Primary_Market_Code := left.bus_intel.Primary_Market_Code;
																					self.Secondary_Market_Code := left.bus_intel.Secondary_Market_Code;
																					self.Industry_1_Code := left.bus_intel.Industry_1_Code;
																					self.Industry_2_Code := left.bus_intel.Industry_2_Code;
																					self.Sub_market := left.bus_intel.Sub_market;
																					self.Vertical := left.bus_intel.Vertical;
																					self.Use := left.bus_intel.Use; 
																					self.Industry := left.bus_intel.Industry; 
																					self.Function_Description := left.search_info.Function_Description;
																					self.Appended_ADL := left.person_q.appended_adl;
																					self.Appended_SSN := left.person_q.appended_ssn;
																					self.LinkID := left.person_q.linkid;
																					self.SSN := left.person_q.ssn;
																					self.count_records := 0;
																					
																					self.title := left.person_q.title;
																					self.fname := left.person_q.fname;
																					self.mname := left.person_q.mname;
																					self.lname := left.person_q.lname;
																					self.name_suffix := left.person_q.name_suffix;	
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
																					self.random_number := random();
																					self.date_f := left.search_info.datetime[1..8];
																					self.date_bucket := if(left.search_info.datetime[1..6] between '201110' and '201201', 1 ,2);
																					self := left));

fastMatchFilter := choosen(Mac_Efficient_Table, if(fast_Match, 14000000, choosen:all));

matchset := ['A','Q','Z'];

did_add.MAC_Match_Flex(fastMatchFilter
						,matchset					
						,ssn
						,''
						,fname
						,mname
						,lname
						,name_suffix
						,prim_range
						,prim_name
						,sec_range
						,zip5
						,st
						,''
						,appended_adl
						,recordof(Mac_Efficient_Table)
						,false
						,''
						,75
						,reDIDfile
						)

dstReDIDFile := distribute(reDIDFile, hash(appended_adl));

trimDIDFile := table(dstReDIDFile, {appended_adl}, appended_adl, local);

WatchDogRecords := choosen(distribute(join(watchdog.File_Best_nonglb(fname <> '' and lname <> '' and prim_range + prim_name <> '' and zip <> '' and ssn <> ''), 
															  trimDIDFile, 
															  right.appended_adl = left.did, keep(1), local), hash(random())), number_out);

JnWDtoIQTrack_ := join(distribute(dstReDIDFile, hash(appended_adl)), distribute(WatchDogRecords, hash(did)),
											right.did = left.appended_adl,
											transform(recordof(dstReDIDFile),
													 self.watchdog_fname := right.fname,
													 self.watchdog_mname := right.mname,
													 self.watchdog_lname := right.lname,
													 self.watchdog_sname := right.name_suffix,
													 self.watchdog_address_line1 := stringlib.stringcleanspaces(right.prim_range + ' ' + right.predir + ' ' + right.prim_name + ' ' + right.suffix + ' ' + right.postdir),
													 self.watchdog_address_line_2 := stringlib.stringcleanspaces(right.unit_desig + ' ' + right.sec_range),
													 self.watchdog_address_last_line := stringlib.stringcleanspaces(right.city_name + ' ' + right.st + ' ' + right.zip + ' ' + right.zip4),
													 self.watchdog_ssn := right.ssn;
													 self := left), local);

JnWDtoIQTrack__ := dedup(sort(distribute(JnWDtoIQTrack_, hash(watchdog_fname, watchdog_mname, watchdog_lname, watchdog_sname,watchdog_address_line1, watchdog_address_line_2, watchdog_address_last_line,watchdog_ssn)), watchdog_fname, watchdog_mname, watchdog_lname, watchdog_sname,watchdog_address_line1, watchdog_address_line_2, watchdog_address_last_line,-watchdog_ssn, local), watchdog_fname, watchdog_mname, watchdog_lname, watchdog_sname,watchdog_address_line1, watchdog_address_line_2, watchdog_address_last_line,watchdog_ssn, local);  
 
jnWDtoIQTrack := project(JnWDtoIQTrack__, transform(recordof(JnWDtoIQTrack__), self.acct_no := counter, self := left));
 
ForCustomer := sort(dedup(project(JnWDtoIQTrack, Output_Customer), record, all), watchdog_hashID);
Customer := dataset('~thor_200::out::inquiry_acclogs::inquiry_test::collections::customer_'+wu_,recordof(forcustomer), csv(separator('\t')));

ForCustomerWithoutSSN := sort(dedup(project(JnWDtoIQTrack, Output_Customer - watchdog_ssn), record, all), watchdog_hashID);
CustomerWithoutSSN := dataset('~thor_200::out::inquiry_acclogs::inquiry_test::collections::customernossn_'+wu_,recordof(ForCustomerWithoutSSN), csv(separator('\t')));

ForInternal := sort(dedup(project(JnWDtoIQTrack, {Output_Customer, Output_Internal}), record, all), hashid);
Internal := dataset('~thor_200::out::inquiry_acclogs::inquiry_test::collections::internal_'+wu_, recordof(forinternal), csv(separator('\t')));

tb := record
	integer8 ct_all := count(group);
  decimal10_2 watchdog_fname := (count(group,customer.watchdog_fname<>'' )/count(group))*100;
  decimal10_2 watchdog_mname := (count(group,customer.watchdog_mname <>'' )/count(group))*100;
  decimal10_2 watchdog_lname := (count(group,customer.watchdog_lname <>'' )/count(group))*100;
  decimal10_2 watchdog_sname := (count(group,customer.watchdog_sname <>'' )/count(group))*100;
  decimal10_2 watchdog_address_line1 := (count(group,customer.watchdog_address_line1 <>'' )/count(group))*100;
  decimal10_2 watchdog_address_line_2 := (count(group,customer.watchdog_address_line_2 <>'' )/count(group))*100;
  decimal10_2 watchdog_address_last_line := (count(group,customer.watchdog_address_last_line <>'' )/count(group))*100;
  decimal10_2 watchdog_ssn := (count(group,customer.watchdog_ssn <>'' )/count(group))*100;
	decimal10_2 watchdog_hashID := (count(group,customer.watchdog_hashID <>'' )/count(group))*100;
end;

tb_out := table(customer, tb, 'all', few);

/* Header Rows */

headerCustomer := dataset([{'acct_no', 'fname','mname','lname','sname','address_line1','address_line_2','address_last_line','ssn','hashID'}], Output_Customer);
headerCustomerNoSSN := dataset([{'acct_no', 'fname','mname','lname','sname','address_line1','address_line_2','address_last_line','hashID'}], Output_Customer-watchdog_ssn);

/* ----------- */

 
return parallel(output(choosen(WatchDogRecords,100));
				output(choosen(sort(JnWDtoIQTrack, Appended_ADL), 100), named('test'));
				
				output(ForCustomer, named('Customer_Sample'));
				output(headerCustomer & ForCustomer,,'~thor_200::out::inquiry_acclogs::inquiry_test::collections::customer_'+wu_, overwrite, csv(separator('\t')));

				output(ForCustomerWithoutSSN, named('Customer_SamplenoSSN'));
				output(headerCustomerNoSSN & ForCustomerWithoutSSN,,'~thor_200::out::inquiry_acclogs::inquiry_test::collections::customernossn_'+wu_, overwrite, csv(separator('\t')));

				output(ForInternal, named('Internal_Sample'));
				output(ForInternal,,'~thor_200::out::inquiry_acclogs::inquiry_test::collections::internal_'+wu_, overwrite, csv(separator('\t')));

				output(tb_out, named('Customer_Sample_Populations'));
				output(table(ForInternal, {industry, count(group)}, industry, few), named('Industry_Counts'));
				output(table(ForInternal, {vertical, count(group)}, vertical, few), named('Vertical_Counts'));
				output(table(ForInternal, {function_description, count(group)}, function_description, few), named('FunctionDescription_Counts'));
				output(table(ForInternal, {sub_market, count(group)}, sub_market, few), named('SubMarket_Counts'))
				);


end;

end;