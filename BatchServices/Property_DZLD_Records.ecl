import LN_PropertyV2, LN_PropertyV2_Services;

export Property_DZLD_Records(
	 dataset(BatchServices.Layouts_Property_DZLD.Batch_In) in_data) := function

	// Must be exact on zip and loan amount (and loan date, if entered).  Provides flexibility for cases where loan date is not an exact match. 
	// The first two keyed items must match.
	records_from_key_DZLD := join(in_data,LN_PropertyV2.key_deed_zip_loanamt,
																keyed(Functions.fn_no_punct(left.zip) = right.zip) and 
																keyed(Functions.fn_strip_loan_amt(left.loan_amount) = right.loan_amount) and
																keyed(left.loan_date = '' OR (Functions.fn_no_punct(left.loan_date) = right.loan_date)),
																transform(BatchServices.Layouts_Property_DZLD.Batch_Pre_Out,
																					self.ln_fares_id := right.ln_fares_id,
																					self.acctno := left.acctno),
																keep(Constants.PROPERTY_SERVICE_JOIN_LIMIT));
	
	ds_fids		:= project(records_from_key_DZLD,transform(LN_PropertyV2_Services.layouts.fid, self.ln_fares_id := left.ln_fares_id));
	
	//Get property record by fid
	ds_property_recs := LN_PropertyV2_Services.resultFmt.widest_view.get_by_fid(ds_fids);
		
	BatchServices.Layouts.LN_Property.rec_widest_plus_acctnos_plus_matchcodes xform(recordof(records_from_key_DZLD) L, recordof(ds_property_recs) R) :=
		TRANSFORM	
			self.acctno := L.acctno;
			SELF := R;
			SELF := [];
		END;

	// Project into layout acceptable for calling transform to return flat results.
	// Also, attach the acctno from input.
	ds_records := join(records_from_key_DZLD, ds_property_recs,
											left.ln_fares_id = right.ln_fares_id,
											xform(left,right));	
	
	// Get the Property record and return flat results
	ds_results := PROJECT(ds_records, BatchServices.xfm_Property_make_flat(LEFT,true));

	return project(ds_results,BatchServices.layout_Property_Batch_out);

end;