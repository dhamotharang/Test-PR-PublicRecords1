IMPORT $, iesp, Doxie, AutostandardI, STD, ut, LN_PropertyV2_Services;

EXPORT Records($.Layouts.Input_Layout input, $.IParams.ReportParams input_params):= FUNCTION
	
	//	Create a dataset of dids to get Best and All addresses from header records
	ds_dids:= DATASET([input.did], doxie.layout_references);
	
	//	Get best record using did (current address)
	best_recs:= $.Functions.fn_best_records(ds_dids, input_params);
	
	//	Get all addresses associated with did from Header Records (for prior addresses)
	addr_recs:= $.Functions.fn_comp_addr(ds_dids, input_params);
	
	//	Join Best address and All addresses from Header to get DateFirstSeen for best address.
	$.Layouts.borrower_layout xform_addr($.Layouts.borrower_layout L, $.Layouts.borrower_layout R, INTEGER C):= TRANSFORM
		SELF.Address.AddrSeq:= C;
		SELF.did:= L.did;
		BOOLEAN is_same_addr:= $.Functions.fn_addr_compare(L.Address, R.Address);
		SELF.Address:= IF(is_same_addr, L.Address, R.Address);
		SELF.DateLastSeen:= IF(is_same_addr, L.DateLastSeen, R.DateLastSeen);
		SELF.DateFirstSeen:= R.DateFirstSeen; 							// Since Doxie.Mac_Best_Records doesn't have the datefirstseen using the datefirstseen from Doxie.Comp_Subject_Addresses
		SELF.is_best_address:= IF(is_same_addr, L.is_best_address, R.is_best_address);
		SELF:= L;
		SELF:= [];	
	END;

	addr_with_dates:= JOIN(best_recs, addr_recs,  
											 LEFT.did= RIGHT.did,
											 xform_addr(LEFT, RIGHT, COUNTER), LEFT OUTER);

	//	Get Verification of Occupancy Score for all the records
	voo_recs:= $.Functions.fn_VOOScore(addr_with_dates, input_params);
		
	// Separating the best records and sorting them on descending DateLastSeen.
	sorted_best_recs:= SORT(voo_recs(is_best_address), -DateLastSeen);
	
	bestlastseen := sorted_best_recs[1].DateLastSeen;
	
	// Separating the non-best records and filtering out the addresses reported after best address last seen
	filtered_prior_recs:= voo_recs(~is_best_address AND DateLastSeen<= bestlastseen);
	
	//	Sort the prior records on descending datelastseen
	sorted_prior_recs:= SORT(filtered_prior_recs, -DateLastSeen);
		
	//	Subject info with current Address
	subject_with_currentAddr:= sorted_best_recs[1];
	
	// Subject data masking
	subject_data_masked:= $.Functions.fn_data_masking(subject_with_currentAddr, input_params);
		
	//	Subject info with previous Address
	subject_with_priorAddr:= sorted_prior_recs[1];
			
	//	Get phones for the borrower
	phones:= $.Functions.fn_get_phones(best_recs[1]);
	
	// Joining the subject_owned_address and Input_Address to get fids.
	subject_owned_addr:= PROJECT(voo_recs(OwnOrRent= $.Constants.OWN), $.Transforms.xform_subjectToaddrLayout(LEFT));
			
	input_prop_addr:= DATASET([$.Transforms.xform_inputToaddrLayout(input)]);

	all_addr_recs:=	subject_owned_addr + input_prop_addr;
		
	//	Get fids for the input property address & Subject Owned addresses.
	fids:= $.Functions.fn_get_fids(all_addr_recs);
	
	//	Get deedinfo for the input property address & Subject Owned addresses using fids
	deed_info:= $.Functions.fn_get_deeds(fids);
	
	//	Real Estate Owned Properties 
	// Join subject owned addresses with deed info to get the propertyType																
	owned_prop_addr:=	JOIN(all_addr_recs(~is_input_property), deed_info(~is_input_property),
													LEFT.AddrSeq = RIGHT.AddrSeq,
													$.Transforms.xform_ownedPropAddr(LEFT, RIGHT), LEFT OUTER);
												
	input_prop_fids:= fids(is_input_property);											
	
	//	Assessment info for the input property address using fids
	input_prop_assess_info:= $.Functions.fn_get_assessments(input_prop_fids);
	
	//	Deedinfo for the input property address
	input_prop_deed_info:= deed_info(is_input_property)[1];
			
	final_recs:= ROW($.Transforms.xform_finalLayout(subject_data_masked,
																									subject_with_priorAddr,
																									phones[1].phone,
																									phones[2].phone,
																									input_prop_addr,
																									input_prop_deed_info,
																									input_prop_assess_info,
																									owned_prop_addr));
	
	// OUTPUT(in, NAMED('in'));
	// OUTPUT(best_recs, NAMED('best_recs'));
	// OUTPUT(addr_recs, NAMED('addr_recs'));
	// OUTPUT(addr_with_dates, NAMED('addr_with_dates'));
	// OUTPUT(voo_recs, NAMED('voo_recs'));
	// OUTPUT(sorted_best_recs, NAMED('sorted_best_recs'));
	// OUTPUT(sorted_prior_recs, NAMED('sorted_prior_recs'));
	// OUTPUT(filtered_prior_recs, NAMED('filtered_prior_recs'));
	// OUTPUT(subject_with_currentAddr, NAMED('subject_with_currentAddr'));
	// OUTPUT(subject_with_priorAddr, NAMED('subject_with_priorAddr'));
	// OUTPUT(subject_owned_addr, NAMED('subject_owned_addr'));
	// OUTPUT(input_prop_addr, NAMED('input_prop_addr'));
	// OUTPUT(all_addr_recs, NAMED('all_addr_recs'));
	// OUTPUT(phones, NAMED('phones'));		
	// OUTPUT(fids, NAMED('fids'));		
	// OUTPUT(deed_info, NAMED('deed_info'));
	// OUTPUT(owned_prop_addr, NAMED('owned_prop_addr'));
	// OUTPUT(input_prop_assess_info, NAMED('input_prop_assess_info'));
	// OUTPUT(input_prop_deed_info, NAMED('input_prop_deed_info'));
	// OUTPUT(final_recs, NAMED('final_recs'));
	
RETURN final_recs;
END; 