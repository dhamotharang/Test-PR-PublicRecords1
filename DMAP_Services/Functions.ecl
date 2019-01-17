IMPORT $, VerificationOfOccupancy, iesp, Doxie, Address, ut, STD, LN_PropertyV2_Services, progressive_phone, Codes, LN_PropertyV2;

EXPORT Functions:= MODULE

	//	Function to compare the 2 addresses.
	EXPORT fn_addr_compare($.Layouts.addr_layout addr_1, $.Layouts.addr_layout addr_2):= FUNCTION
		
		BOOLEAN is_same_addr:= 	addr_1.PrimRange	= addr_2.PrimRange AND
														addr_1.PreDir 		= addr_2.PreDir AND
														addr_1.PrimName		= addr_2.PrimName AND
														addr_1.AddrSuffix = addr_2.AddrSuffix AND
														addr_1.PostDir		= addr_2.PostDir AND
														addr_1.SecRange		= addr_2.SecRange AND
														((addr_1.CityName	= addr_2.CityName AND
															addr_1.St		= addr_2.St) OR
															addr_1.Zip		= addr_2.Zip);
		
	RETURN is_same_addr;
	END;
	
	//	Function to clean the input property address
	EXPORT fn_clean_addr(iesp.Share.t_Address addr_in):= FUNCTION
	
		addr:= DATASET([$.Transforms.xform_inputAddr(addr_in)]);
		L:= Address.fn_AddressCleanBatch(addr);
		
		cleaned_addr:= PROJECT(L, $.Transforms.xform_cleanAddr(LEFT));
	RETURN cleaned_addr[1];
	END;
	
	//	Function to get best record for the did 	
	EXPORT fn_best_records(DATASET(Doxie.layout_references) dids_in,
												 $.IParams.ReportParams input_params):= FUNCTION
	
		Doxie.mac_best_records(dids_in, did, bestout, input_params.dppa_ok, input_params.glb_ok, , input_params.drm);
		recs:= PROJECT(bestout, $.Transforms.xform_bestDmap(LEFT));
	RETURN recs;
	END;
	
	//	Function to get all addresses for the did	
	EXPORT fn_comp_addr(DATASET(Doxie.layout_references) dids_in,
											$.IParams.ReportParams input_params):= FUNCTION

    mod_access := MODULE (doxie.compliance.GetGlobalDataAccessModuleTranslated (AutoStandardI.GlobalModule()))
      EXPORT unsigned1 glb := input_params.GLBA;
      EXPORT unsigned1 dppa := input_params.DPPA;
      EXPORT string DataPermissionMask := input_params.dpm;
      EXPORT string DataRestrictionMask := input_params.drm;
      EXPORT boolean ln_branded := FALSE;
      EXPORT boolean probation_override := input_params.Probation_Override_Value;
      EXPORT string5 industry_class := input_params.Industry_Class;
      EXPORT string ssn_mask := input_params.ssn_mask_val;
      EXPORT unsigned1 dob_mask := input_params.dob_mask_val;
    END;
		addr:= Doxie.Comp_Subject_Addresses(dids_in, , , , mod_access).Addresses;

		address_recs:= PROJECT(addr, $.Transforms.xform_compAddr(LEFT));
	RETURN address_recs;
	END;
	
	fn_AsOfDate(UNSIGNED4 dateFirstSeen, UNSIGNED4 dateLastSeen):= FUNCTION
		No_of_days:=STD.Date.DaysBetween(dateFirstSeen, dateLastSeen);
		STRING8 asOfDate:= (STRING8)ut.date_math((STRING)dateFirstSeen,(No_of_days DIV 2));
		RETURN asOfDate;
	END;	
	
	// Function to calculate Verification Of Occupancy score for the subject and all the addresses. 
 	EXPORT fn_VOOScore(DATASET($.Layouts.borrower_layout) Input,
										$.IParams.ReportParams input_params):= FUNCTION
			
		VerificationOfOccupancy.Layouts.Layout_VOOIn xform_vooIn($.Layouts.borrower_layout L) := TRANSFORM
			SELF.LexID 								:= L.did;	
			SELF.Seq									:= L.Address.AddrSeq;
			
			asOfDate:= fn_AsOfDate(L.dateFirstSeen, L.dateLastSeen);	
			SELF.AsOf 								:= IF(std.Date.IsValidDate((INTEGER)asOfDate), asOfDate, $.Constants.DEFAULT_ASOFDATE);
			SELF.ssn 									:= L.ssn;
			SELF.dob 									:= L.dob;
			SELF.Name_Full 						:= L.Name.full;
			SELF.Name_First  					:= L.Name.First;
			SELF.Name_Middle 					:= L.Name.middle;
			SELF.Name_Last  					:= L.Name.last;
			SELF.Name_Suffix 					:= L.Name.suffix;
			SELF.street_addr					:= Address.Addr1FromComponents(L.Address.PrimRange, L.Address.Predir, L.Address.PrimName, L.Address.AddrSuffix, L.Address.Postdir, L.Address.UnitDesig, L.Address.SecRange);								
			SELF.streetnumber					:= L.Address.PrimRange;
			SELF.streetpredirection		:= L.Address.Predir;
			SELF.streetname						:= L.Address.PrimName;
			SELF.streetsuffix					:= L.Address.AddrSuffix;
			SELF.streetpostdirection	:= L.Address.Postdir;
			SELF.unitdesignation			:= L.Address.UnitDesig;
			SELF.unitnumber						:= L.Address.SecRange;
			SELF.City_name         		:= L.Address.CityName;
			SELF.st        						:= L.Address.St;
			SELF.z5      							:= L.Address.Zip;
			SELF											:= [];
		END;
		voo_in := PROJECT(Input, xform_vooIn(LEFT));		
		voo_out:= VerificationOfOccupancy.Search_Function(voo_in, input_params.drm, input_params.glba, input_params.dppa, input_params.isUtility, $.Constants.ATTRIBUTES_VERSION, input_params.IncludeModel, input_params.dpm).VOOReport;
		
		$.Layouts.dmap_Layout xform_vooOut(VerificationOfOccupancy.Layouts.Layout_VOOBatchOutReport L, $.Layouts.borrower_layout R) := TRANSFORM
			InferredOwnershipTypeIndex								:= (INTEGER)L.attributes.version1.InferredOwnershipTypeIndex;
			VerificationOfOccupancyScore							:= (INTEGER)L.attributes.version1.VerificationOfOccupancyScore;
			SELF.Address															:= R.Address;
			SELF.InferredOwnershipTypeIndex	 					:= InferredOwnershipTypeIndex;
			SELF.VerificationOfOccupancyScore 				:= VerificationOfOccupancyScore;
			SELF.OwnOrRent														:= MAP(VerificationOfOccupancyScore>50 AND InferredOwnershipTypeIndex=0=> $.Constants.RENT,
																											 VerificationOfOccupancyScore>=0 AND InferredOwnershipTypeIndex>=1=> $.Constants.OWN,	
																											 $.Constants.INSUFFICIENT_EVIDENCE); // Insufficient evidence
																											 
			asOfDate:= fn_AsOfDate(R.dateFirstSeen, R.dateLastSeen);							
			SELF.AsOfDate															:= IF(std.Date.IsValidDate((INTEGER)asOfDate), asOfDate, $.Constants.DEFAULT_ASOFDATE);
			SELF.DOB 																	:= R.dob;
			SELF																			:= R;
			SELF:=[];
		END;
		IndIndex := JOIN(voo_out, Input, LEFT.LexID= RIGHT.did AND LEFT.Seq= RIGHT.Address.AddrSeq, xform_vooOut(LEFT, RIGHT));
	RETURN IndIndex;
	END;

	// Function to get phones from the best record for the did.
	EXPORT fn_get_phones($.Layouts.borrower_layout input):= FUNCTION
		
		phones_input:= DATASET([$.Transforms.xform_phoneIn(input)]);
		phones:= PROJECT(progressive_phone.functions.getPhonesV3(phones_input, , , , , , , , , , , $.Constants.MAX_NUM_PHONES), progressive_phone.layout_progressive_online_out);	// /* Return MaxNumSubject = 2 */		
		phone_recs:= PROJECT(phones, $.Transforms.xform_phoneOut(LEFT));		
		deduped_phones:= DEDUP(SORT(phone_recs, Phone), Phone);
		
	RETURN deduped_phones;
	END;
	
	// Function to mask DOB and SSN info as per input options	
	EXPORT fn_data_masking($.Layouts.dmap_Layout subject_current_info, $.IParams.ReportParams input_params):= FUNCTION
	
		subject_with_maskedInfo:= ROW($.Transforms.xform_dataMask(subject_current_info, input_params));
	
	RETURN subject_with_maskedInfo;
	END;
	
	EXPORT fn_getOwnedProp(DATASET($.Layouts.borrower_layout) subject_info):= FUNCTION

    voo_shell_in := PROJECT(subject_info, $.Transforms.xform_vooShellIn(LEFT));
    deduped_voo_shell_in:= DEDUP(SORT(voo_shell_in, z5, prim_name, prim_range, sec_range), z5, prim_name, prim_range, sec_range);
    prop_ownership:= VerificationOfOccupancy.getPropOwnership(deduped_voo_shell_in);
    owned_properties:= prop_ownership(property_owned='1' AND property_sold<>'1');
    Owned_Addr := PROJECT(owned_properties, $.Transforms.xform_vooOwnedAddr(LEFT, COUNTER));
    deduped_owned_addr:= DEDUP(SORT(Owned_Addr, Zip, PrimName, PrimRange, SecRange), Zip, PrimName, PrimRange, SecRange);
		
	RETURN deduped_owned_addr;
	END;
	
	// Function to get fids for the Input Property Address & Owned Property Address
 	EXPORT fn_get_fids(DATASET($.Layouts.addr_layout) addr_in):= FUNCTION

		k_addr(BOOLEAN isFCRA= FALSE):= LN_PropertyV2_Services.keys.search_addr(isFCRA);
		lookupValOK(STRING fid)			 := LN_PropertyV2_Services.input.lookupVal IN ['',LN_PropertyV2.fn_fid_type(fid)];	
		
		by_addr := JOIN(addr_in, k_addr(FALSE),
										KEYED(LEFT.PrimName=RIGHT.prim_name) AND
										KEYED(LEFT.PrimRange=RIGHT.prim_range) AND
										KEYED(LEFT.Zip=RIGHT.zip) AND
										KEYED(LEFT.PreDir=RIGHT.predir) AND
										KEYED(LEFT.PostDir=RIGHT.postdir) AND
										KEYED(LEFT.AddrSuffix=RIGHT.suffix) AND
										KEYED(LEFT.SecRange=RIGHT.sec_range) AND
										RIGHT.source_code_2='P' AND
										lookupValOK(RIGHT.ln_fares_id),
										$.Transforms.xform_fidsOut(LEFT, RIGHT),
										LIMIT(LN_PropertyV2_Services.consts.max_raw,SKIP)
									);
		fids_out	:= DEDUP(SORT(by_addr, AddrSeq, ln_fares_id), AddrSeq, ln_fares_id);

		RETURN fids_out;
	END;
   	
 	EXPORT GetCode(STRING Code_file,
								 STRING field_name_value,
								 STRING field_name2_value = '',
								 STRING code_value) 					:= FUNCTION
		RETURN Codes.KeyCodes(Code_file, field_name_value, field_name2_value, code_value, TRUE);
	END;	
	
	// Function to get deeds info for the input property.
	EXPORT fn_get_deeds(DATASET($.Layouts.fids_layout) fids):= FUNCTION
	
		k_deed(BOOLEAN isFCRA= FALSE):= LN_PropertyV2_Services.keys.deed(isFCRA);
		code_file_deeds		:= LN_PropertyV2_Services.consts.deeds_codefile;
		max_deeds		:= LN_PropertyV2_Services.consts.max_deeds;		
		vsource(STRING source_flag= ''):= LN_PropertyV2_Services.fn_vendor_source(source_flag);
	
		$.Layouts.Deed_layout	x_deed($.Layouts.fids_layout L, RECORDOF(LN_PropertyV2_Services.keys.deed) R):= TRANSFORM
			buyer_vesting:= IF(R.buyer_or_borrower_ind= 'O', R.vesting_code, '');
			borrower_vesting:= IF(R.buyer_or_borrower_ind= 'B', R.vesting_code, '');
			
			SELF.PropertyType := GetCode(code_file_deeds, 'PROPERTY_INDICATOR_CODE', vsource(R.vendor_source_flag), R.property_use_code);
			SELF.BorrowerVestingDesc := GetCode(code_file_deeds, 'BORROWER_VESTING_CODE', vsource(R.vendor_source_flag), borrower_vesting);
			SELF.BuyerVestingDesc := GetCode(code_file_deeds, 'BUYER_VESTING_CODE',  vsource(R.vendor_source_flag), buyer_vesting);
			SELF.YearLotAcquired:= R.contract_date;
			SELF.OriginalCost:= R.sales_price;
			SELF.AddrSeq:= L.AddrSeq;
			SELF.is_input_property:= L.is_input_property;
			SELF:= R;
			SELF:= [];
		END; 
	
		deed_Raw:= JOIN(fids, k_deed(FALSE),
										KEYED(LEFT.ln_fares_id = RIGHT.ln_fares_id),
										x_deed(LEFT, RIGHT), LIMIT(max_deeds));
		
		sorted_deeds_raw:= SORT(deed_Raw, AddrSeq, -RecordingDate, -YearLotAcquired);
		rolled_deeds:= ROLLUP(sorted_deeds_raw, 
													LEFT.AddrSeq = RIGHT.AddrSeq ,
													$.Transforms.xform_deedRollUp(LEFT, RIGHT));
		RETURN rolled_deeds;
	END;	
	
	// Function to get assessments info for the input property.
	EXPORT fn_get_assessments (DATASET($.Layouts.fids_layout) fids):= FUNCTION
	
		k_assessor(BOOLEAN isFCRA=FALSE):= LN_PropertyV2_Services.keys.assessor(isFCRA);
		code_file_assessments		:= LN_PropertyV2_Services.consts.assess_codefile;
		max_assess	:= LN_PropertyV2_Services.consts.max_assess;
		vsource(STRING source_flag= ''):= LN_PropertyV2_Services.fn_vendor_source(source_flag);
		
		$.Layouts.Assessment_layout	x_assess($.Layouts.fids_layout L, RECORDOF(LN_PropertyV2.key_assessor_fid()) R):= TRANSFORM
			SELF.NoOfUnits:= R.no_of_units;
			SELF.SubjectPropertyType:= GetCode(code_file_assessments, 'LAND_USE', vsource(R.vendor_source_flag), R.standardized_land_use_code);
			SELF.LegalDescription:= R.legal_brief_description;
			SELF.YearBuilt:= R.year_built;
			SELF.RealEstateTaxesCurrentProperty:= R.tax_amount;
			SELF:= R;
			SELF:= [];
		END; 
	
		assess_Raw:= JOIN(fids, k_assessor(FALSE),
											KEYED(LEFT.ln_fares_id = RIGHT.ln_fares_id),
											x_assess(LEFT, RIGHT),  LIMIT(max_assess));
	
		sorted_assess_raw:=	SORT(assess_Raw, -TaxYear, -AssessedValueYear);	
		rolled_assessments:= ROLLUP(sorted_assess_raw, TRUE, $.Transforms.xform_assessmentsRollUp(LEFT, RIGHT));
		RETURN rolled_assessments[1];
	END;	
 
 END;