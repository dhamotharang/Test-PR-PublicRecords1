import LN_PropertyV2,codes;
EXPORT fMissingCodesDeeds (dataset(recordof(ln_propertyV2.layouts.layout_deed_mortgage_common_model_base_scrubs )) DeedsLatestRaw) := function

export prep  := record

			ln_propertyV2.layouts.layout_deed_mortgage_common_model_base_scrubs;
			string200 field_name; 
			string source_code;
			string raw_code; 
end; 

prep tNormalizeCodes(DeedsLatestRaw	l,integer	cnt)	:=
	transform
	
	  // Buyer/Borrower -----------------------------------
		bb := l.buyer_or_borrower_ind;
		
		buyer1_id										:= if(bb='O', L.name1_id_code,				'');
		buyer2_id										:= if(bb='O', L.name2_id_code,				'');
		buyer_vesting								:= if(bb='O', L.vesting_code,					'');
		buyer_addendum							:= if(bb='O', L.addendum_flag,				'');
		borrower1_id								:= if(bb='B', L.name1_id_code,				'');
		borrower2_id								:= if(bb='B', L.name2_id_code,				'');
		borrower_vesting						:= if(bb='B', L.vesting_code,					'');
		
	
		self.field_name		:=	choose(	cnt,
		                              'DOCUMENT_TYPE',
																	'LEGAL_LOT_CODE',
																	'SALE_CODE',
																	'PROPERTY_INDICATOR_CODE',
																	'CONDO_CODE',
																	'MORTGAGE_LOAN_TYPE_CODE',
																	'FIRST_TD_LENDER_TYPE_CODE',
																	'FIRST_TD_LENDER_TYPE_CODE',
																	'BUYER1_ID_CODE',
																	'BUYER2_ID_CODE',
																	'BUYER_VESTING_CODE',
																  'BORROWER1_ID_CODE',
																  'BORROWER2_ID_CODE',
																  'BORROWER_VESTING_CODE',
																  'SELLER1_ID_CODE',
																  'SELLER2_ID_CODE',
																  'RECORD_TYPE',
																  'TYPE_FINANCING',
																  'RATE_CHANGE_FREQUENCY',
																  'ADJUSTABLE_RATE_INDEX',
																  'FIXED_STEP_RATE_RIDER'																												

																	);
		tvendor_source	:=	if(l.vendor_source_flag	in	['F','S'],'FARES','OKCTY');
		self.source_code	:=	if(tvendor_source	=	'FARES','FAR_F',tvendor_source);
		self.raw_code			:=	choose(	cnt,
		                              l.document_type_code,
																	l.legal_lot_code,
																	l.sales_price_code,
																	l.property_use_code,
																	l.condo_code,
																	l.first_td_loan_type_code,
																	l.first_td_lender_type_code,
																	l.second_td_lender_type_code,
																	buyer1_id,
																	buyer2_id,
																	buyer_vesting,
																	borrower1_id,
																	borrower2_id,
																	borrower_vesting,
																	l.seller1_id_code,
																	l.seller2_id_code,
																	l.record_type,
																	l.type_financing,
																	l.rate_change_frequency,
																	l.adjustable_rate_index,
																	l.fixed_step_rate_rider		
																							
																);
		self							:=	[];
	end;

	dPropertyRawCodes	:=	normalize(	DeedsLatestRaw,
																		21,
																		tNormalizeCodes(left,counter)
																	);

	prep	tGetCommonCode(dPropertyRawCodes	le,codes.File_Codes_V3_In	ri)	:=
	transform
		self	:=	le;
	end;

	// Do a left only join to get the list of codes which don't have a common code
	dPropNoCommonCode	:=	join(	dPropertyRawCodes(raw_code<>''),
															Codes.File_Codes_V3_In(file_name	in	[/*'FARES_2580',*/'FARES_1080']),
															stringlib.stringcleanspaces(left.field_name)	=	stringlib.stringcleanspaces(right.field_name)		and
															stringlib.stringcleanspaces(left.source_code)	=	stringlib.stringcleanspaces(right.field_name2)	and
															stringlib.stringcleanspaces(left.raw_code)		=	stringlib.stringcleanspaces(right.code),
															tGetCommonCode(left,right),
															left only,
															lookup
														);

  rMissingCodesCounts := record
   dPropNoCommonCode.field_name;
	 dPropNoCommonCode.source_code;
	 dPropNoCommonCode.raw_code;
	 count_ := count(group);
	end;
	
	tMissingCodes := sort(table(dPropNoCommonCode,rMissingCodesCounts,field_name,source_code,raw_code,few),field_name,-count_) ;//:persist('tax_missing_codes');

Return 	tMissingCodes;
 
end ; 
