
IMPORT BatchDatasets, Risk_Indicators, Riskwise;

EXPORT fn_getIIDRecs(DATASET(Layouts.batch_in) ds_batch_in, IParams.BatchParams in_mod) :=
	FUNCTION
	
	// projecting to batchdatasets intermeadiate layout to add addr_status(error_code)
	
    ds_batch_in_with_addrStatus := project(ds_batch_in,BatchDatasets.Layouts.layout_batch_in_waddr_status);
	
		
		// Get InstantID records.
		Risk_Indicators.Layout_Output
				ds_iid_raw := BatchDatasets.fetch_InstantID_recs(ds_batch_in_with_addrStatus, in_mod);

		// Set parameter values for calling risk_indicators.reasonCodes( ) --see below.
		unsigned1 NumReturnCodes := risk_indicators.iid_constants.DefaultNumCodes;
		boolean IsInstantID := true;
		unsigned1 IIDVersion := 0;	// version 0 will not get the new reason codes in v1
		reasoncode_settings := dataset([{IsInstantID, IIDVersion}],riskwise.layouts.reasoncode_settings);

		SET OF STRING2 ACCEPTABLE_HRI_CODES := 
				['06','25','26','29','37','38','39','48','50','51','52','66','71','72','76','79','85','89','CL','IS','IT','MI','MS','PA','PO','RS'];
		
		fn_display_hri_code(string4 hri) :=	
				if( hri IN ACCEPTABLE_HRI_CODES, hri, '' );

		fn_display_hri_desc(string4 hri, string100 desc) :=
				if( hri IN ACCEPTABLE_HRI_CODES, desc, '' );
			
		Layouts.rec_instantid into_final(BatchDatasets.Layouts.batch_in le, Risk_Indicators.Layout_Output ri) := 
			transform
					reasonCodes := risk_indicators.reasonCodes(ri, NumReturnCodes, reasoncode_settings);
				self.acctno            := le.acctno;
				self.identity_verification_nas := (string)ri.socsverlevel;
				self.hri_1_indicator   := fn_display_hri_code(reasonCodes[1].hri);
				self.hri_1_description := fn_display_hri_desc(reasonCodes[1].hri,reasonCodes[1].desc);
				self.hri_2_indicator   := fn_display_hri_code(reasonCodes[2].hri);
				self.hri_2_description := fn_display_hri_desc(reasonCodes[2].hri,reasonCodes[2].desc);
				self.hri_3_indicator   := fn_display_hri_code(reasonCodes[3].hri);
				self.hri_3_description := fn_display_hri_desc(reasonCodes[3].hri,reasonCodes[3].desc);
				self.hri_4_indicator   := fn_display_hri_code(reasonCodes[4].hri);
				self.hri_4_description := fn_display_hri_desc(reasonCodes[4].hri,reasonCodes[4].desc);
				self.hri_5_indicator   := fn_display_hri_code(reasonCodes[5].hri);
				self.hri_5_description := fn_display_hri_desc(reasonCodes[5].hri,reasonCodes[5].desc);
				self.hri_6_indicator   := fn_display_hri_code(reasonCodes[6].hri);
				self.hri_6_description := fn_display_hri_desc(reasonCodes[6].hri,reasonCodes[6].desc);
				self.verified_dob      := ri.verdob;
			end;

		ds_iid_recs := 
			join(
				ds_batch_in, ds_iid_raw, 
				(unsigned4)left.acctno = right.seq, 
				into_final(left,right), 
				left outer, limit(0), keep(1)
			);
			
		IF( in_mod.ViewDebugs, 
				OUTPUT( ds_iid_raw, NAMED('InstantID_results') ) );

		return ds_iid_recs;			
	END;