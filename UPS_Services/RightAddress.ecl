IMPORT iesp, AutoStandardI, CAN_PH, Address, ut, Fedex_Services, doxie;

// This module provides the main logic for executing UPS "RightAddress" 
// searches.
export RightAddress(DATASET(iesp.rightaddress.t_RightAddressSearchRequest) inReq = DATASET([], iesp.rightaddress.t_RightAddressSearchRequest)) := MODULE
	ds_in := DATASET([], iesp.rightaddress.t_RightAddressSearchRequest) : STORED ('RightAddressSearchRequest', FEW);
	shared first_row := if (EXISTS(inReq), inReq[1], ds_in[1]) : independent;

  //set options (translate from the pre-determined xml style into the stored/soap style that roxie is expecting
	shared search_options := global(first_row.options);
	shared boolean isCanada :=  search_options.isCanada; 
	shared search_by := global (first_row.SearchBy);
	shared powersearch := global(search_by.PowerSearch);
	shared boolean isZipSearch := search_options.ZipPostalSearch; 

	addr_origin_country := IF(isCanada, Address.Components.Country.CA, address.Components.Country.US); 
	#STORED ('AddressOrigin', addr_origin_country);

	shared search_by_name := mod_Names(search_by).bestParser() : independent;
	shared ps := mod_PowerSearch(powersearch,isCanada);
	shared ps_name := ps.getName() : independent;
	shared ps_phone := ps.getPhone() : independent;

	shared addr_in	:= if(powersearch='', search_by.Address, ps.paddr);
	shared addr_out	:= mod_Address(addr_in,isCanada).bestParser() : independent;
	
	shared zip_only_response := addr_out ; 	
	//set main search criteria:
	iesp.ECL2ESP.SetInputBaseRequest(first_row);
	iesp.ECL2ESP.Marshall.Mac_Set(search_options);

	// the UPS service has allowed Options/MaxResults to be set to 0.  When
	// MaxResults is 0, though, we miss some records in the individual header
	// lookup (gong?).  Due to a WSDL/ESDL bug (Options/MaxResults isn't 
	// currently visible to the middleware) we can't directly set it in the 
	// request.  This creates a bit of a problem, so if maxresults=0 we'll set
	// a reasonable default value here.
	maxResults := if(search_options.maxresults = 0, iesp.Constants.RA.MAX_RESPONSE_RECORDS, search_options.maxresults);
	#stored('MaxResults', maxResults);

	// set the query inputs (from XML) so they can be picked up by GlobalModule.
	NameToUse := if(powersearch <> '', ps_name, search_by_name);
	iesp.ECL2ESP.SetInputName (NameToUse);
	
	#stored('CompanyName', if(powersearch <> '', ps_name.CompanyName, search_by_name.CompanyName));
	aout :=  project(addr_out,transform(iesp.share.t_Address,SELF := LEFT));
	iesp.ECL2ESP.SetInputAddress(aout);
  iesp.ECL2ESP.SetInputSearchOptions (first_row.options);
			
	// filter out invalid phone inputs, such as "000-0000" or "(561) 000-0000"
	// (per Bugzilla 38423)
	shared validPhone := MAP(powersearch <> ''=> ps_phone,
													 LENGTH(search_by.Phone10) =  7 AND (INTEGER) search_by.Phone10 <> 0 => search_by.Phone10,
													 LENGTH(search_by.Phone10) = 10 AND (INTEGER)(search_by.Phone10[4..10]) <> 0 => search_by.Phone10,
													 '');

	#stored ('phone', validPhone);
	
	fname_was_input := trim(search_by.name.first) <> '';
	lname_doesnt_look_like_a_biz := ut.Word(search_by.lastnameorcompany,2,' ') = '';//only has 1 word

	shared EntityType := 
	map(
		fname_was_input 
		AND lname_doesnt_look_like_a_biz //if it looks like a person
		AND search_by.EntityType <> Constants.TAG_ENTITY_BIZ //then we can assume they are looking for a person and not a business (unless specified otherwise)
			=> Constants.TAG_ENTITY_IND,
		search_by.EntityType = Constants.TAG_ENTITY_IND 
		OR search_by.EntityType = Constants.TAG_ENTITY_BIZ 
		OR search_by.EntityType = Constants.TAG_ENTITY_UNK 								
			=> search_by.EntityType, 
		Constants.TAG_ENTITY_UNK
	);		
  // pack input parameters into a module
	shared inputmod := AutoStandardI.GlobalModule();

	shared search_inputs := MODULE(SearchParams)
		export nameQueryInputs := if (powersearch <> '', ps_name, search_by_name);
		export addrQueryInputs := addr_out;
		export phoneQueryInput := validPhone;
	END;
	
	// *** Do a person search 
	export PersonSearch := MODULE
	
		PSearchMod := module( project( inputmod, mod_Params.PersonSearch, opt)) 
		end;

		header_res := mod_Searches.personSearch.records(PSearchMod);

		// *** Penalize person search results
		header_res_pen := mod_Score(search_inputs).score(header_res);

		// do not do a person search if we're searching businesses
		export records := if (EntityType = Constants.TAG_ENTITY_BIZ,
															DATASET( [], RECORDOF(header_res_pen)),
															header_res_pen);
	END;
	
	export BusinessSearch := MODULE

		// Do a business search
		BSearchMod := module (project (inputmod, mod_Params.BusinessSearch, opt))
		end;
										 
		biz_res := ups_services.mod_Searches.businessSearch.records(search_inputs,BSearchMod);	

		// Penalize business search results
		biz_res_pen := mod_Score(search_inputs).score(biz_res);

		// don't do a business search if we're searching individuals
		export records := if (EntityType = Constants.TAG_ENTITY_IND, 
															DATASET( [], RECORDOF(biz_res_pen)),
															biz_res_pen);
	END;
	
  export FedExSearch := MODULE
		
		fedex_raw := Fedex_Services.mod_Searches.FedexNoHit; 
		fedex_sort := sort(fedex_raw, company_name, lname, fname, mname, prim_range, prim_name, zip5, -dt_last_seen);				
		fedex_dedup := dedup(fedex_sort, company_name, lname, fname, mname, prim_range, prim_name, zip5);
			
   	 
   	fedex_filtered := map (EntityType = Constants.TAG_ENTITY_IND  => fedex_dedup(trim(business_indicator) <> 'Y'),
   														EntityType = Constants.TAG_ENTITY_BIZ  => fedex_dedup(trim(business_indicator) = 'Y'),
   														fedex_dedup ) ;
   	fedex_format := project(fedex_filtered,transform(UPS_Services.layout_Common, 
													SELF.rollup_key := left.fakeid;
													SELF.rollup_key_type := Constants.TAG_ROLLUP_KEY_FAKEID, 
													self.phone := left.phone,
													self.fname := left.fname,
													self.mname := left.mname,
													self.lname := left.lname,
													self.company_name := left.company_name,
													self.prim_range := left.prim_range,
													self.predir 		:= left.predir ,
													self.prim_name 	:= left.prim_name,
													self.suffix 		:= left.addr_suffix,
													self.sec_range 	:= left.sec_range ,
													self.city_name 	:= left.p_city_name,
													self.state 			:= left.state,
													self.zip 						:= left.zip5,
													self.dt_first_seen 	:=  0,
													self.dt_last_seen  	:=  (unsigned4) left.dt_last_seen,
													self.listing_type   := if(trim(left.business_indicator) = 'Y','B','R');
													self.Current := 'Y'; // assumption , need to check if they have any non current records here. 
													//self.history_flag;
													self 	:= left, 
													self := [])); 
   																					
   	 fedex_pen := mod_Score(search_inputs).score(fedex_format);
		 
   	 export records := fedex_pen;

  END;
	
	
	export CanadaSearch := MODULE

	 // Do a Canada Address search
	 
	 // Gets raw records (canadianphones_V2) without penalty calculated.
	 can_res := Can_PH.GetRawRecords(true);	
	 can_res_sort := sort(can_res, phonenumber, lastname, firstname, middlename, housenumber, streetname, postalcode, -date_last_reported);				
	 can_res_dedup := dedup(can_res_sort, phonenumber, lastname, firstname, middlename, housenumber, streetname, postalcode);
		
	 
	 can_res_filtered := map (EntityType = Constants.TAG_ENTITY_IND  => can_res(trim(Listing_Type) = 'R'),
														EntityType = Constants.TAG_ENTITY_BIZ  => can_res(trim(Listing_Type) = 'B'),
														can_res_sort ) ;
	 
	 can_res_format := project(can_res_filtered,transform(UPS_Services.layout_Common, 
																							SELF.rollup_key := left.fdid;
																							SELF.rollup_key_type := Constants.TAG_ROLLUP_KEY_FDID,		
																							self.phone := left.phonenumber,
																							self.fname := left.firstname,
																							self.mname := left.middlename,
																							self.lname := left.lastname,
																							self.company_name := left.company_name,
																							self.prim_range := left.housenumber,
																							self.predir 		:= left.directional ,
																							self.prim_name 	:= left.streetname,
																							self.suffix 		:= left.streetsuffix,
																							self.sec_range 	:= left.suitenumber ,
																							self.city_name 	:= left.city,
																							self.state 			:= left.province,
																							self.zip 						:= left.postalcode,
																							self.dt_first_seen 	:=  (unsigned4) left.date_first_reported,
																							self.dt_last_seen  	:=  (unsigned4) left.date_last_reported,
																							self 	:= left, 
																							self := [])); 
																					
	 can_res_pen := mod_Score(search_inputs).score(can_res_format);
	 
	 export records := can_res_pen;
	END;
	

	// note that number of records returned here are limited in mod_Searches to
	// iesp.Constants.MAX_SEARCH_RESULTS for each individuals and businesses.

	permissions := AutoStandardI.DataPermissionI.val(project(inputmod, AutoStandardI.DataPermissionI.params));
	us_person_business_fedex_records := if(permissions.use_FedExData,FedExSearch.records);
	us_person_records_pre := PersonSearch.records + us_person_business_fedex_records(company_name = '');
	us_person_records := UPS_Services.fn_CurrentPersonAddressLookup(us_person_records_pre);
	us_business_records  := BusinessSearch.records + us_person_business_fedex_records(company_name <> '');
	us_records_pre := us_person_records + us_business_records;
	us_records := UPS_Services.fn_AdvoLookup(us_records_pre);
	can_records := CanadaSearch.records;
	
	#if(Debug.debug_flag)
			output(search_by_name, NAMED('SearchByName'));
			output(validPhone, NAMED('SearchByPhone'));
			output(ps_name, NAMED('psName'));
			output(ps_phone, NAMED('psPhone'));
			output(FedExSearch.records, NAMED('FedExSearch'));
			output(permissions.use_FedExData, NAMED('use_FedExData'));
	#end

	
	
	export records := if(isCanada,can_records,us_records);
	 	
	export rolled_records := mod_Rollup(search_inputs).roll(records, inputmod.MaxResults);
	
	BOOLEAN doHighlight := search_options.highlight;
	export highlighted_records := IF(doHighlight, mod_Highlight(search_inputs).doBest(rolled_records), rolled_records);
	
	MaxNumPhoneSubjectPre := (integer)search_options.MaxNumPhoneSubject;
	TrueMaxNumPhoneSubject := map(  MaxNumPhoneSubjectPre > 3 => 3, // max is 3 
	                                MaxNumPhoneSubjectPre = 0 => 3, // default is 3 
	                                MaxNumPhoneSubjectPre < 0 => 0, // internal testing to turn off WFP
																     MaxNumPhoneSubjectPre);
	
	PSearchMod := module( project( inputmod, mod_Params.PersonSearch, opt)) 
			export string20  PhoneScoreModel := if(trim(search_options.PhoneScoreModel)='','PHONESCORE_V2' ,search_options.PhoneScoreModel );
			export integer MaxNumPhoneSubject := TrueMaxNumPhoneSubject ;
		end;
	
	// Choose top 1 DID 	
	 topDid := project(choosen(highlighted_records(score > UPS_Services.Constants.SCORE_THRESHOLD_WATERFALL_PHONES and 
	                            EntityType = UPS_Services.Constants.TAG_ENTITY_IND),1),
									transform(doxie.layout_references_hh,
							         self.DID := (unsigned) left.UniqueID ));
											 
	boolean doWaterfallPhones := exists(topDid) and ~isCanada and TrueMaxNumPhoneSubject > 0; 
	
  wfpRecords := if( doWaterfallPhones, UPS_Services.fn_WaterfallPhonesLookup(topDid,PSearchMod));
	
	highlighted_records_with_phones := if( doWaterfallPhones, 
				join(highlighted_records,wfpRecords,
					~isCanada and left.EntityType = UPS_Services.Constants.TAG_ENTITY_IND and 
					left.score  >  UPS_Services.Constants.SCORE_THRESHOLD_WATERFALL_PHONES and 
					left.UniqueID = (string)right.DID,
					transform(recordof(highlighted_records),
					firstAddress := left.Addresses[1];
					phones := project(right.phones,transform(iesp.rightaddress.t_HighlightedPhoneInfo, 
														self.phone10 := left.phone10, self := [])) + 
									firstAddress.phones;
					firstAddressWithPhones := project(firstAddress,transform(iesp.rightaddress.t_RAAddressWithPhones, 
																				self.phones := phones, self := left ));
					self.addresses := firstAddressWithPhones + choosen(Left.Addresses,all,2),
					self := left), left outer),
					highlighted_records);

	//**** START TEMP DEMO CODE FOR CUSTOMER REVIEW 
	//**** This is temp because, if they want this behavior, we need to do the filtering much earlier.
	#stored('DemoMode',search_options.DemoMode);
	#stored('DemoModeEditDistance',search_options.DemoModeEditDistance);
	inDemoMode := false : stored('DemoMode');
	inEditDistanceAllowed := 1 : stored('DemoModeEditDistance');
		
	iesp.share.t_Address MA() := transform
		self.StreetName := UPS_Services.mod_Address(search_by.address,isCanada).bestparser().StreetName;
		self.StreetNumber:= UPS_Services.mod_Address(search_by.address,isCanada).bestparser().StreetNumber;
		self := search_by.address
	end;
		
	Addr := DATASET([MA()])[1];				
		
	filtered_records_pre :=
	if(
		inDemoMode,
		UPS_Services.mod_Filter(
			recs := highlighted_records_with_phones,
			inName := UPS_Services.mod_Names(search_by).bestparser(),
			inAddr := Addr,
			inPhone := validPhone,
			powersearch := powersearch,
			EditDistanceAllowed0 := inEditDistanceAllowed
		).results,
		highlighted_records_with_phones
	);
	
 	filtered_records := if(isZipSearch,dataset([],iesp.rightaddress.t_RightAddressSearchRecord),filtered_records_pre);
	
	
	
	iesp.ECL2ESP.Marshall.MAC_Marshall_Results(filtered_records , response, iesp.rightaddress.t_RightAddressSearchResponse,
	                                            ,,,ZipPostalLookup,zip_only_response);
																						 

																						 
	
	//***** END TEMP DEMO CODE

	// build a soap response and returns a single result row.
	// iesp.ECL2ESP.Marshall.MAC_Marshall_Results(highlighted_records, response, iesp.rightaddress.t_RightAddressSearchResponse); //UNCOMMENT THIS WHEN TEMP DEMO CODE IS GONE

   
	// export soap_response := project(response,
	                                // transform(iesp.rightaddress.t_RightAddressSearchResponse), 
																	            // self := left, 
																							// self.ZipPostalLookup := zip_only_response );																						
		export soap_response := response;																				
	
END;