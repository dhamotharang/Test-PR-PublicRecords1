import Address,Autokey_batch,AutokeyB2_batch,doxie,LN_PropertyV2,ut,Suppress;

/*
	****************************************************************************
	General description: The batch solution for Capital Gains Tax is intended to 
  help locate individuals who did not file capital gains based on home sales 
  that had come from either a purchased property where the revenue gain was of 
  a substantial amount.
	****************************************************************************
*/

layout_in 	:= CapitalGains_BatchService_Layouts.batch_in;
layout_out 	:= CapitalGains_BatchService_Layouts.batch_out;
layout_flat	:= CapitalGains_BatchService_Layouts.batch_flat_tmp;
layout_prop_wide := BatchServices.Layouts.LN_Property.rec_widest_plus_acctnos;

EXPORT CapitalGains_BatchService_Records(dataset(layout_in) ds_batch_in) := 
FUNCTION
	
	doxie.MAC_Header_Field_Declare();	
	boolean AppendBest 								:= false : STORED('AppendBest');
	boolean AppendPhone 							:= false : STORED('AppendPhone');
	boolean AppendDeceased 						:= false : STORED('AppendDeceased');
	boolean ReturnUnformattedValues	 	:= false : STORED('Return_Unformatted_Values');
	boolean SkipDedup									:= false : STORED('Skip_Dedup'); // for testing purposes only.
	boolean IncludeMinors             := false : STORED('IncludeMinors');
	boolean GetSSNBest                := true  : STORED('GetSSNBest');
	
	// We will clean and normalize the input file to split subject 1 and subject 2 information (so we can run them as 2 independent searches). 
	ds_batch_in_clean	:= BatchServices.CapitalGains_BatchService_Functions.cleanInputAddresses(ds_batch_in);	
	ds_recs0 := BatchServices.CapitalGains_BatchService_Functions.normalizeInputFile(ds_batch_in_clean(error_code=0));		
	ds_recs1 := BatchServices.CapitalGains_BatchService_Functions.appendDids(ds_recs0);
	ds_recs2 := if(AppendBest, BatchServices.CapitalGains_BatchService_Functions.appendBest(ds_recs1,GLB_Purpose,DPPA_Purpose,IncludeMinors,GetSSNBest), ds_recs1);
	ds_recs3 := if(AppendPhone, BatchServices.CapitalGains_BatchService_Functions.appendPhones(ds_recs2), ds_recs2);
	ds_recs4 := if(AppendDeceased, BatchServices.CapitalGains_BatchService_Functions.appendDeceased(ds_recs3), ds_recs3);	

	// Suppress by did and ssn here, before pulling property records. Suppression for properties is done by underlying code.
	Suppress.MAC_Suppress(ds_recs4, ds_recs5, application_type_value,Suppress.Constants.LinkTypes.DID,subject_did);
	Suppress.MAC_Suppress(ds_recs5, ds_recs6, application_type_value,Suppress.Constants.LinkTypes.SSN,subject_ssn);
	
	ds_recs7 := BatchServices.CapitalGains_BatchService_Functions.appendProperties(ds_recs6);

	///////////////////////////////////////////////////////	
	
	// Since we normalized the original input, we may have pulled the same fares_id for both subject 1 and 2. 
	// Need to dedup those and restore original acctno. 
	ds_recs_props := dedup(sort(project(ds_recs7, 
																			transform(layout_flat, 
																								self.acctno := left.orig_acctno, self := left)), 
															acctno, ln_fares_id), acctno, ln_fares_id); 
												 
	// -----------------------------------------------------------------------
	// The logic below will try to assign ids for property records based on address and/or apns.	
	// -----------------------------------------------------------------------
	layout_flat assignPropertyId(layout_flat l, layout_flat r, integer id_seed, boolean hasNoSecRange) := transform
		sameAcctno	 := l.acctno = r.acctno;
		sameProperty := (l.property_address2<>'' and l.property_address2=r.property_address2) or l.last4apn=r.last4apn;
		self.property_id := map(~sameAcctno => id_seed,
														 sameProperty or hasNoSecRange => l.property_id,
														 l.property_id+1),
		self := r
	end;		
	
	// 1.First we assign ids based on records with secondary ranges.
	ds_recs_addr2 	 := sort(ds_recs_props(property_address2<>''), acctno, property_address2, ln_fares_id); 	
	ds_recs_it1			 := iterate(ds_recs_addr2, assignPropertyId(left, right, 1, false));
	// 2.Then we propagate those ids back to records with no secondary range by matching their apns.
	ds_recs_it2      := join(ds_recs_props, ds_recs_it1,
											 left.acctno = right.acctno and left.last4apn = right.last4apn,	
											 transform(layout_flat, self.property_id := right.property_id, self := left),
											 keep(1), left outer);
  // 3.Repeat the same process for all records that have no ids assigned at this point.											 
	ds_recs_apn			 := sort(ds_recs_it2(property_id=0),	acctno, last4apn, ln_fares_id);
	// 3.1. Passing max id for each acctno as the seed for the next iteration. 
	ds_recs_it3			 := iterate(ds_recs_apn, 
														  assignPropertyId(left, right, 
																							 max(ds_recs_it2(acctno=right.acctno), property_id)+1, // seed for next iteration.
																						   max(ds_recs_props(acctno=right.acctno), property_address2)='') // to indicate whether we have sec range addressess for this acctno.
																							 );		
	// 4.Now pull all records back together and sort.
	ds_recs_sorted	 := sort(ds_recs_it2(property_id<>0)+ds_recs_it3, acctno, property_id, sortby_date, sale_date, ln_fares_id); 
	// -----------------------------------------------------------------------
	
	layout_flat calculateGains(layout_flat l, layout_flat r) := transform
		_sameproperty							:= l.acctno = r.acctno and l.property_id=r.property_id;		
		_prior_sale_date					:= map(r.fid_type='A'=>r.prior_sale_date, _sameproperty and l.isSeller => l.prior_sale_date, _sameproperty and r.isSeller => l.sale_date, '');
		_prior_sale_amnt					:= map(r.fid_type='A'=>r.prior_sale_amnt, _sameproperty and l.isSeller => l.prior_sale_amnt, _sameproperty and r.isSeller => l.sale_amnt, '');
		_sale_date								:= r.sale_date;
		_sale_amnt								:= r.sale_amnt;
		_sale_days_diff 					:= ut.DaysApart(_sale_date, _prior_sale_date);
		_sale_amnt_diff 					:= (integer) _sale_amnt - (integer) _prior_sale_amnt;		
		_sale_amnt_diff_pct 			:= (decimal10_2) if((integer)_prior_sale_amnt<>0, ((integer)_sale_amnt_diff/(integer) _prior_sale_amnt)*100, 0);
		self.sale_date 						:= _sale_date,
		self.sale_amnt 						:= _sale_amnt,
		self.prior_sale_date		 	:= _prior_sale_date,
		self.prior_sale_amnt 		 	:= _prior_sale_amnt,
		self.sale_amnt_diff	 			:= if(_prior_sale_amnt<>'', (string11) _sale_amnt_diff, ''),
		self.sale_amnt_diff_pct 	:= if(_prior_sale_amnt<>'', (string8) _sale_amnt_diff_pct, '');
		self.sale_days_diff 			:= if(_prior_sale_date<>'', _sale_days_diff, 0),	
		self											:= r
	end;
	// For assessment records, calculate gains based on sale and prior sale information available in the record.
	// For deeds, also use sale information from previous record. 	
	ds_recs_with_gains := iterate(ds_recs_sorted(fid_type='D' or (fid_type='A' and isSeller)), calculateGains(left, right));	

	layout_out_tmp := record
		layout_out;
		BatchServices.layout_Property_Batch_out.sortby_date;
		boolean isSeller;
		string45  apn; 
		unsigned1 property_id;
		unsigned1 subject_id;
	end;		

	layout_out_tmp toFlatCommon(layout_flat l) := transform
		self.subject1_deceased_indicator 	:= if(l.subject_id=1, l.subject_deceased_indicator, ''),
		self.subject1_deceased_first 			:= if(l.subject_id=1, l.subject_deceased_first, ''),
		self.subject1_deceased_last 			:= if(l.subject_id=1, l.subject_deceased_last, ''),
		self.subject1_deceased_ssn 				:= if(l.subject_id=1, l.subject_deceased_ssn, ''),
		self.subject1_deceased_dob 				:= if(l.subject_id=1, l.subject_deceased_dob, ''),
		self.subject1_dod 								:= if(l.subject_id=1, l.subject_dod, ''),
		self.subject2_deceased_indicator 	:= if(l.subject_id=2, l.subject_deceased_indicator, ''),
		self.subject2_deceased_first 			:= if(l.subject_id=2, l.subject_deceased_first, ''),
		self.subject2_deceased_last 			:= if(l.subject_id=2, l.subject_deceased_last, ''),
		self.subject2_deceased_ssn 				:= if(l.subject_id=2, l.subject_deceased_ssn, ''),
		self.subject2_deceased_dob 				:= if(l.subject_id=2, l.subject_deceased_dob, ''),
		self.subject2_dod 								:= if(l.subject_id=2, l.subject_dod, ''),
		self.subject1_did 								:= if(l.subject_id=1, l.subject_did, 0),
		self.subject1_best_name 					:= if(l.subject_id=1, l.subject_best_name , ''),
		self.subject1_dob 								:= if(l.subject_id=1, l.subject_dob, ''),
		self.subject1_ssn 								:= if(l.subject_id=1, l.subject_ssn, ''),
		self.subject1_current_addr 				:= if(l.subject_id=1, l.subject_current_addr, ''),
		self.subject1_current_city 				:= if(l.subject_id=1, l.subject_current_city, ''),
		self.subject1_current_state 			:= if(l.subject_id=1, l.subject_current_state, ''),
		self.subject1_current_zip  				:= if(l.subject_id=1, l.subject_current_zip, ''),
		self.subject1_current_phone 			:= if(l.subject_id=1, l.subject_current_phone , ''),
		self.subject2_did 								:= if(l.subject_id=2, l.subject_did, 0),
		self.subject2_best_name 					:= if(l.subject_id=2, l.subject_best_name, ''),
		self.subject2_dob 								:= if(l.subject_id=2, l.subject_dob, ''),
		self.subject2_ssn 								:= if(l.subject_id=2, l.subject_ssn, ''),		
		self.subject2_current_addr	 			:= if(l.subject_id=2, l.subject_current_addr, ''),
		self.subject2_current_city 				:= if(l.subject_id=2, l.subject_current_city, ''),
		self.subject2_current_state 			:= if(l.subject_id=2, l.subject_current_state, ''),
		self.subject2_current_zip  				:= if(l.subject_id=2, l.subject_current_zip, ''),
		self.subject2_current_phone 			:= if(l.subject_id=2, l.subject_current_phone, ''),		
		self.acctno												:= l.orig_acctno, // restoring original acctno
		self.property_owner1_name 				:= '',
		self.property_owner2_name 				:= '',
		self.property_seller1_name 				:= '',
		self.property_seller2_name 				:= '',
		self := l
	end;

	// Common fields from best, deceased and phones should always be returned, even if no property is found.
	// Need to roll up those fields to a flat layout first and restore original acctno.	
	ds_recs_common_flat		:= project(ds_recs6, toFlatCommon(left));
	ds_recs_common_sorted := sort(ds_recs_common_flat, acctno, subject_id);
	
	layout_out_tmp toFlatOut(layout_out_tmp l, layout_out_tmp r) := transform
		self.subject2_deceased_indicator 	:= r.subject2_deceased_indicator,
		self.subject2_deceased_first 			:= r.subject2_deceased_first,
		self.subject2_deceased_last 			:= r.subject2_deceased_last,
		self.subject2_deceased_ssn 				:= r.subject2_deceased_ssn,
		self.subject2_deceased_dob 				:= r.subject2_deceased_dob,
		self.subject2_dod 								:= r.subject2_dod,
		self.subject2_did 								:= r.subject2_did,
		self.subject2_best_name 					:= r.subject2_best_name,
		self.subject2_dob 								:= r.subject2_dob,
		self.subject2_ssn 								:= r.subject2_ssn,
		self.subject2_current_addr	 			:= r.subject2_current_addr,
		self.subject2_current_city 				:= r.subject2_current_city,
		self.subject2_current_state 			:= r.subject2_current_state,
		self.subject2_current_zip  				:= r.subject2_current_zip,
		self.subject2_current_phone 			:= r.subject2_current_phone,
		self := l
	end;			
	ds_recs_common 				:= rollup(ds_recs_common_sorted, left.acctno=right.acctno, toFlatOut(left, right));
	
	layout_out_tmp appendPropertyToFlatOut(layout_out_tmp l, layout_flat r) := transform
		
		_sale_amnt_diff_pct	:= (decimal10_2) r.sale_amnt_diff_pct;
		_sale_amnt_diff_pct_frmt := if(_sale_amnt_diff_pct<0, '-', '')+(string)abs(_sale_amnt_diff_pct)+'%';
		_sale_amnt_diff := (decimal12_2) r.sale_amnt_diff;		
		_sale_amnt_diff_frmt := if(_sale_amnt_diff<0, '-', '')+BatchServices.Functions.convert_to_currency((string)abs(_sale_amnt_diff));
		
		// grab all property fields from right.
		self.property_owner1_name 	:= Address.NameFromComponents(r.owner_1_first_name, r.owner_1_middle_name, r.owner_1_last_name, r.owner_1_name_suffix),
		self.property_owner2_name 	:= Address.NameFromComponents(r.owner_2_first_name, r.owner_2_middle_name, r.owner_2_last_name, r.owner_2_name_suffix),
		self.property_seller1_name 	:= Address.NameFromComponents(r.seller_1_first_name, r.seller_1_middle_name, r.seller_1_last_name, r.seller_1_name_suffix),
		self.property_seller2_name 	:= Address.NameFromComponents(r.seller_2_first_name, r.seller_2_middle_name, r.seller_2_last_name, r.seller_2_name_suffix),
		self.property_address1    	:= r.property_address1,
		self.property_address2    	:= r.property_address2,
		self.property_city_name 		:= r.property_city_name, 
		self.property_st          	:= r.property_st,
		self.property_zip         	:= r.property_zip,
		self.property_zip4        	:= r.property_zip4,
		self.assessment_value 			:= if(ReturnUnformattedValues, r.assessment_value, BatchServices.Functions.convert_to_currency(r.assessment_value)),
		self.sale_date 							:= r.sale_date,
		self.sale_amnt 							:= if(ReturnUnformattedValues, r.sale_amnt, BatchServices.Functions.convert_to_currency(r.sale_amnt)),
		self.prior_sale_date 				:= r.prior_sale_date,
		self.sale_days_diff 				:= r.sale_days_diff,
		self.prior_sale_amnt 				:= if(ReturnUnformattedValues, r.prior_sale_amnt, BatchServices.Functions.convert_to_currency(r.prior_sale_amnt)),
		self.sale_amnt_diff_pct 		:= if(ReturnUnformattedValues, r.sale_amnt_diff_pct, _sale_amnt_diff_pct_frmt),
		self.sale_amnt_diff 				:= if(ReturnUnformattedValues, r.sale_amnt_diff, _sale_amnt_diff_frmt),
		self.last4APN 							:= r.last4APN,
		self.tax_year								:= r.tax_year,
		self.sortby_date						:= r.sortby_date,
		self.ln_fares_id 						:= r.ln_fares_id,
		self.property_id						:= r.property_id,
		
		// grab all common fields from left.
		self												:= l
		
	end;

	// appending property information to best, phones, deceased.
	ds_final_flat_out := 
		join(ds_recs_common, ds_recs_with_gains(isSeller), // ultimately, we're only interested in property records where subject is a seller.
				 left.acctno = right.orig_acctno,
				 appendPropertyToFlatOut(left, right),
				 left outer, limit(Constants.CapitalGains.JOIN_LIMIT));

	// also including acctno with insufficient input back in the response.
	ds_final_flat_missing := 
		join(ds_batch_in_clean(error_code<>0), ds_final_flat_out,
				 left.acctno = right.acctno,
				 transform(layout_out_tmp, self := left, self := []),
				 left only);

	ds_final_out_pre := sort(ds_final_flat_out+ds_final_flat_missing, acctno, property_id, -sortby_date, last4apn, -sale_date, ln_fares_id);	
	ds_final_out_pre_deduped := dedup(ds_final_out_pre, acctno, property_id);
	ds_final_out_unmasked := if(SkipDedup, ds_final_out_pre, ds_final_out_pre_deduped);
	
	Suppress.MAC_Mask(ds_final_out_unmasked, ds_final_pre_1, subject1_ssn, '', true, false,,,,ssn_mask_value);	
	Suppress.MAC_Mask(ds_final_pre_1, ds_final_pre_2, subject2_ssn, '', true, false,,,,ssn_mask_value);	  
	
	ds_final_out := project(ds_final_pre_2, layout_out);
	
	return ds_final_out;

END;