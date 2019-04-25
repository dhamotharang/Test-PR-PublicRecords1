#workunit('name', 'FDN_data_collection');
IMPORT RiskWise, iesp, ut, FraudDefenseNetwork, zz_koubsky;

//********* SOAP settings **********
unsigned8 no_of_records 			:= 500;
integer eyeball 							:= 50;
integer set_retry 						:= 3;
integer set_timeout 					:= 120;
integer set_threads 					:= 1;
String roxieIP 								:= riskwise.shortcuts.Dev192; 
// String roxieIP 								:= riskwise.shortcuts.Dev194; 
// Infile_name 										:= ;
String outfile_name 					:=  '~nkoubsky::temp::FDN_service_temp' + thorlib.wuid();

//********* Query settings **********
string DataRestrictionMask		:= '';
string DataPermissionMask			:= '';
integer GlobalCompanyId 			:= 0;
integer IndustryType 					:= 0;
integer ProductCode 					:= 1;
string GLBPurpose 						:= '4';
string DLPurpose 							:= '0';
integer MaxResults						:= 50;

//********* Sample settings **********

//==================  Generate a sample randomly from all sources using payload  ========================
ds_payload := distribute(FraudDefenseNetwork.Key_Autokey_Payload, random());
unsigned rand_sample_size := no_of_records / 6;

felony_sample 				:= enth(ds_payload(source='DDFELONY'), rand_sample_size);
// afi_sample 						:= enth(ds_payload(source='AFI'), rand_sample_size); //ADI no longer in file
incarceration_sample 	:= enth(ds_payload(source='DDINCARCERATED'), rand_sample_size);
ainspection_sample 		:= enth(ds_payload(source='ADDRESSINSPECTION'), rand_sample_size);
tigr_sample 					:= enth(ds_payload(source='TIGER'), rand_sample_size + 1);
cfna_sample 					:= enth(ds_payload(source='CFNA'), rand_sample_size + 1);
glb5_sample 					:= enth(ds_payload(source='GLB5'), rand_sample_size + 1);

// ==== Use this for random sample of payload key ========================================================
// raw_input := choosen(felony_sample + incarceration_sample + ainspection_sample + tigr_sample + cfna_sample + glb5_sample, no_of_records);
// ==== Use this instead for the test data created by QA =================================================
raw_input := ds_payload(source='LN TEST 01' or source='LN TEST 02');
// =======================================================================================================
output(count(ds_payload), named('basefile_record_count'));
// output(table(ds_payload, {ds_payload.source; _count := count(group)}, source), named('basefile_sources'));
output(rand_sample_size, named('sample_size_each_source'));
output(felony_sample, named('felony_sample'));
output(incarceration_sample, named('incarceration_sample'));
output(ainspection_sample, named('ainspection_sample'));
output(tigr_sample, named('tigr_sample'));
output(cfna_sample, named('cfna_sample'));
output(glb5_sample, named('glb5_sample'));
output(raw_input, named('raw_input'));

// add account number to file
// ds_input_temp := project(raw_input, transform({integer2 acct_num; recordof(raw_input)}, self.acct_num := counter; self := left));

// ds_input := distribute(ds_input_temp, random());
ds_input := distribute(raw_input, random());
output(ds_input, named('ds_input'));

//==================  input layout  ========================
soap_in_lay := record
		iesp.frauddefensenetwork.t_FDNSearchRequest;
		// temp_lay SearchBy;
end;

top_soapin_lay := record
	// dataset (soap_in_lay) FraudDefenseNetworkSearchRequest;
	dataset (soap_in_lay) fdnsearchrequest;
end;

//==================  create input file  ========================
top_soapin_lay make_soap_in(ds_input le) := TRANSFORM

		self.fdnsearchrequest := project(le, 
				transform(soap_in_lay, 
								// self.User.ReferenceCode := (string)le.;
								// self.User.BillingCode := le. ;
								// self.User.QueryId := le. ;
								// self.User.CompanyId := le. ;
						self.User.GLBPurpose := GLBPurpose;
						self.User.DLPurpose := DLPurpose;
								// self.User.LoginHistoryId := le. ;
								// self.User.DebitUnits := le. ;
								// self.User.IP := le. ;
								// self.User.IndustryClass := le. ;
								// self.User.ResultFormat := le. ;
								// self.User.LogAsFunction := le. ;
								// self.User.SSNMask := le. ;
								// self.User.DOBMask := le. ;
								// self.User.ExcludeDMVPII := le. ;
								// self.User.DLMask := le. ;
						self.User.DataRestrictionMask := DataRestrictionMask;
						self.User.DataPermissionMask := DataPermissionMask;
								// self.User.SourceCode := le. ;
								// self.User.ApplicationType := le. ;
								// self.User.SSNMaskingOn := false;
								// self.User.DLMaskingOn := false;
								// self.User.LnBranded := le. ;

								// self.RemoteLocations := ;
								// self.ServiceLocations := ;

						self.FDNUser.GlobalCompanyId := GlobalCompanyId;
						self.FDNUser.IndustryType := IndustryType;
						self.FDNUser.ProductCode := ProductCode;

								// self.options.MakeVendorGatewayCall := 0;
								// self.options.StrictMatch := le. ;
						self.options.MaxResults := MaxResults;
								/*
								self.options.ExcludedIndTypes := 	project(ut.ds_oneRecord,
																													transform(iesp.frauddefensenetwork.t_FDNIndType,
																															// self.IndType := le.;
																															self := [];
																													));
								self.options.FileTypes := 	project(ut.ds_oneRecord,
																										transform(iesp.frauddefensenetwork.t_FDNFileType,
																												// self.FileType := le.;
																												self := [];
																										));
								*/
								/*
						self.SearchBy.Address.StreetNumber := le.clean_address.prim_range;
						self.SearchBy.Address.StreetPreDirection := le.clean_address.predir;
						self.SearchBy.Address.StreetName := le.clean_address.prim_name;
						self.SearchBy.Address.StreetSuffix := le.clean_address.addr_suffix;
						self.SearchBy.Address.StreetPostDirection := le.clean_address.postdir;
						self.SearchBy.Address.UnitDesignation := le.clean_address.unit_desig;
								// self.SearchBy.Address.UnitNumber := le.clean_address. ;
								// self.SearchBy.Address.StreetAddress1 := le.clean_address. ;
								// self.SearchBy.Address.StreetAddress2 := le.clean_address. ;
						self.SearchBy.Address.City := le.clean_address.p_city_name;
						self.SearchBy.Address.State := le.clean_address.st;
						self.SearchBy.Address.Zip5 := le.clean_address.zip;
						self.SearchBy.Address.Zip4 := le.clean_address.zip4;
								// self.SearchBy.Address.County := le.clean_address. ;
								// self.SearchBy.Address.PostalCode := le.clean_address. ;
								// self.SearchBy.Address.StateCityZip := le.clean_address. ;
								
						self.SearchBy.UniqueId := if(le.did = 0, '', trim((string)le.did, all));
						self.SearchBy.Phone10 := (string)le.phone_number ;
						self.SearchBy.SSN := (string)le.SSN;
						*/
						
						self.SearchBy.Phone10 := (string)le.phone_number ;

						self := [];
				));
END;

soap_in := DISTRIBUTE(PROJECT(ds_input, make_soap_in(LEFT)), RANDOM());
OUTPUT(CHOOSEN(soap_in, eyeball), NAMED('soap_in'));

roxie_out_lay := RECORD
	// iesp.frauddefensenetwork.t_FDNSearchResponseEx;
	iesp.frauddefensenetwork.t_FDNSearchResponse;
	string200 errorcode;
END;
       
roxie_out_lay myfail(soap_in L) := transform
	SELF.errorcode := FAILCODE + ' ' + FAILMESSAGE;
	self := [];
end;

soap_results := soapcall(		soap_in,
														roxieIP,
														'fdn_services.searchservice', 
														{soap_in},
														dataset(roxie_out_lay),
														RETRY(set_retry), TIMEOUT(set_timeout),
														parallel(set_threads) ,
														onfail(myfail(LEFT))
													);

output(choosen(soap_results, eyeball), named('soap_results'));
	errors := soap_results(errorcode <> '');
output(choosen(errors, eyeball), named('errors'));
/*
// *******Join input info to file ************************************
// Can't join input to file since there is not a unique account number
final_lay := record
		iesp.share.t_Address Address {xpath('Address')};
		string12 UniqueId {xpath('UniqueId')};
		string15 Phone10 {xpath('Phone10')};
		string11 SSN {xpath('SSN')};	
end;

le.acct_num

*/
output(count(errors), named('FDN_error_count'));

// output(choosen(soap_results(records.match_counts.total_hits <> ''), eyeball), named('phone_hits'));
// output(choosen(soap_results(records[1].MatchCounts.TotalHits >= 1), eyeball), named('phone_hits'));

output(soap_results, , '~nkoubsky::temp::FDN_service_temp', thor, overwrite);
// output(soap_results, outfile_name, thor, overwrite);
// */