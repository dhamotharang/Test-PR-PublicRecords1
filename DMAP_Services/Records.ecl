IMPORT $, iesp, Doxie, AutostandardI, STD, ut, LN_PropertyV2_Services;

EXPORT Records($.Layouts.Input_Layout input):= FUNCTION
	
	gm:= AutostandardI.GlobalModule();
	INTEGER GLBA:= AutoStandardI.InterfaceTranslator.GLB_Purpose.val(PROJECT(gm,AutoStandardI.InterfaceTranslator.GLB_Purpose.params));	
	INTEGER DPPA:= AutoStandardI.InterfaceTranslator.DPPA_Purpose.val(PROJECT(gm,AutoStandardI.InterfaceTranslator.DPPA_Purpose.params));
	BOOLEAN probation_override_value:= AutoStandardI.InterfaceTranslator.probation_override_value.val(PROJECT(gm,AutoStandardI.InterfaceTranslator.probation_override_value.params));
	BOOLEAN IncludeModel:= TRUE; 	// Defaulted to TRUE to get Verification of Occupancy Score
	BOOLEAN IncludeReport:= TRUE;	// Defaulted to TRUE to get Verification of Occupancy Score
	drm:= gm.DataRestrictionMask;
	dpm:= gm.DataPermissionMask;
	STRING5 industryclass:= AutoStandardI.InterfaceTranslator.industry_class_val.val(PROJECT(gm,AutoStandardI.InterfaceTranslator.industry_class_val.params));
	BOOLEAN isUtility:=  ut.IndustryClass.Is_Utility;	
	BOOLEAN glb_ok:= ut.glb_ok(GLBA);
	BOOLEAN dppa_ok:= ut.dppa_ok(DPPA);
	
	//	Create a dataset of dids to get Best and All addresses from header records
	ds_dids:= DATASET([input.did], doxie.layout_references);
	
	//	Get best record using did (current address)
	best_recs:= $.Functions.fn_best_records(ds_dids, GLBA, DPPA, dppa_ok, glb_ok, drm);
	
	//	Get all addresses associated with did from Header Records (for prior addresses)
	addr_recs:= $.Functions.fn_comp_addr(ds_dids, GLBA, DPPA, probation_override_value, industryclass);
	
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
	voo_recs:= $.Functions.fn_VOOScore(addr_with_dates, drm, GLBA, DPPA, isUtility, IncludeModel, dpm,IncludeReport);
	
	// Separating the best records and sorting them on descending DateLastSeen.
	sorted_best_recs:= SORT(voo_recs(is_best_address), -DateLastSeen);
	
	bestlastseen := sorted_best_recs[1].DateLastSeen;
	
	// Separating the non-best records and filtering out the addresses reported after best address last seen
	filtered_prior_recs:= voo_recs(~is_best_address AND DateLastSeen<= bestlastseen);
	
	//	Sort the prior records on descending datelastseen
	sorted_prior_recs:= SORT(filtered_prior_recs, -DateLastSeen);
		
	//	Subject info with current Address
	subject_with_currentAddr:= sorted_best_recs[1];
	
	//	Subject info with previous Address
	subject_with_priorAddr:= sorted_prior_recs[1];
	
	//Subject previous address
	prior_address:= PROJECT(subject_with_priorAddr.Address, $.Transforms.xform_t_address(LEFT));
		
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
	
	//	Get assessinfo for the input property address using fids
	input_prop_assess_info:= $.Functions.fn_get_assessments(input_prop_fids);
	
	//	Get deedinfo for the input property address
	input_prop_deed_info:= deed_info(is_input_property)[1];
			
	iesp.dmap.t_DMAPReportResult info():= TRANSFORM
		SELF.Borrower.UniqueId:=(STRING)subject_with_currentAddr.did,
		SELF.Borrower.Name:= subject_with_currentAddr.Name;
		SELF.Borrower.DOB:= iesp.ECL2ESP.toDatestring8((STRING8)subject_with_currentAddr.DOB);
		SELF.Borrower.SSN:= subject_with_currentAddr.SSN;
		SELF.Borrower.Phone1:= phones[1].phone;
		SELF.Borrower.Phone2:= phones[2].phone;
		SELF.Borrower.CurrentAddress:= PROJECT(subject_with_currentAddr.Address, $.Transforms.xform_t_address(LEFT));
		Years_at_Address_current:= STD.Date.YearsBetween(subject_with_currentAddr.datefirstseen, subject_with_currentAddr.datelastseen);
		SELF.Borrower.CurrentAddress.YearsAtAddress:= (STRING)Years_at_Address_current;
		SELF.Borrower.CurrentAddress.VerificationOfOccupancyScore:= (STRING)subject_with_currentAddr.VerificationOfOccupancyScore;
		SELF.Borrower.CurrentAddress.InferredOwnershipTypeIndex:= (STRING)subject_with_currentAddr.InferredOwnershipTypeIndex;
		SELF.Borrower.CurrentAddress.OwnOrRent:= subject_with_currentAddr.OwnOrRent;
		SELF.Borrower.CurrentAddress.VerificationOfOccupancyAsOfDate:= iesp.ECL2ESP.toDatestring8(subject_with_currentAddr.AsOfDate);
		SELF.Borrower.PriorAddress:= If(Years_at_Address_current< $.Constants.YEARS_AT_CURRENT_ADDRESS_THRESHOLD, prior_address, ROW([],iesp.share.t_Address));
		SELF.Borrower.PriorAddress.VerificationOfOccupancyScore:= If(Years_at_Address_current< $.Constants.YEARS_AT_CURRENT_ADDRESS_THRESHOLD, (STRING)subject_with_priorAddr.VerificationOfOccupancyScore, '');
		SELF.Borrower.PriorAddress.InferredOwnershipTypeIndex:= If(Years_at_Address_current< $.Constants.YEARS_AT_CURRENT_ADDRESS_THRESHOLD, (STRING)subject_with_priorAddr.InferredOwnershipTypeIndex, '');
		SELF.Borrower.PriorAddress.OwnOrRent:= If(Years_at_Address_current< $.Constants.YEARS_AT_CURRENT_ADDRESS_THRESHOLD, subject_with_priorAddr.OwnOrRent, '');	
		Years_at_Address_prior:= STD.Date.YearsBetween(subject_with_priorAddr.datefirstseen, subject_with_priorAddr.datelastseen);
		SELF.Borrower.PriorAddress.VerificationOfOccupancyAsOfDate:= If(Years_at_Address_current< $.Constants.YEARS_AT_CURRENT_ADDRESS_THRESHOLD, iesp.ECL2ESP.toDatestring8(subject_with_priorAddr.AsOfDate), ROW([], iesp.share.t_Date));
		SELF.Borrower.PriorAddress.YearsAtAddress:= If(Years_at_Address_current< $.Constants.YEARS_AT_CURRENT_ADDRESS_THRESHOLD, (STRING)Years_at_Address_prior, '');
		SELF.OwnedProperties:= owned_prop_addr;
		SELF.SubjectProperty.Address:= ROW($.Transforms.xform_t_address(input_prop_addr[1]));
		SELF.SubjectProperty.NoOfUnits:= input_prop_assess_info.NoOfUnits;
		SELF.SubjectProperty.PropertyType:= input_prop_assess_info.SubjectPropertyType;
		SELF.SubjectProperty.LegalDescription:= input_prop_assess_info.LegalDescription;
		SELF.SubjectProperty.YearBuilt:= input_prop_assess_info.YearBuilt;
		SELF.SubjectProperty.RealEstateTaxesCurrentProperty:= input_prop_assess_info.RealEstateTaxesCurrentProperty;		
		SELF.SubjectProperty.BorrowerVestingDescription:= input_prop_deed_info.BorrowerVestingDesc;
		SELF.SubjectProperty.BuyerVestingDescription:= input_prop_deed_info.BuyerVestingDesc;
		SELF.SubjectProperty.YearLotAcquired:= input_prop_deed_info.YearLotAcquired;
		SELF.SubjectProperty.OriginalCost:= input_prop_deed_info.OriginalCost;		
		SELF:= [];
	END;
	
	final_recs:= ROW(info());
	
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