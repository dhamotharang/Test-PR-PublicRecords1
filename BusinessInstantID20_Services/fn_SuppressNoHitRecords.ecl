IMPORT BusinessInstantID20_Services;

EXPORT fn_SuppressNoHitRecords( DATASET(BusinessInstantID20_Services.layouts.OutputLayout_intermediate) ds_BIID_results ) := 
	FUNCTION	
		ds_Hits := ds_BIID_results(VerificationSummaries.bvi NOT IN BusinessInstantID20_Services.Constants.BVI_NOHIT_VALUES AND 
				VerificationSummaries.bvi_desc_key NOT IN BusinessInstantID20_Services.Constants.BVI_DESC_KEY_NOHIT_VALUES);

		ds_NoHits := ds_BIID_results(VerificationSummaries.bvi IN BusinessInstantID20_Services.Constants.BVI_NOHIT_VALUES OR 
				VerificationSummaries.bvi_desc_key IN BusinessInstantID20_Services.Constants.BVI_DESC_KEY_NOHIT_VALUES);
		
		VerificationLayout_temp := { BusinessInstantID20_Services.layouts.VerificationLayout AND NOT [Seq] };
		
		VerificationLayout_temp xfm_DisplayNonVerification( VerificationLayout_temp le ) :=
			TRANSFORM
				SELF.ver_name_indicator       := '0';
				SELF.ver_altname_indicator    := '0';
				SELF.ver_streetaddr_indicator := '0';
				SELF.ver_city_indicator       := '0';
				SELF.ver_state_indicator      := '0';
				SELF.ver_zip_indicator        := '0';
				SELF.ver_phone_indicator      := '0';
				SELF.ver_tin_indicator        := '0';			
			END;
			
		BusinessInstantID20_Services.layouts.OutputLayout_intermediate xfm_SuppressNoHits( BusinessInstantID20_Services.layouts.OutputLayout_intermediate le ) := 
			TRANSFORM
				SELF.VerifiedEcho     := [];
				SELF.Verification     := PROJECT( le.Verification, xfm_DisplayNonVerification(LEFT) );
				SELF.BestEcho         := [];
				SELF.InputEcho.ultid  := 0;
				SELF.InputEcho.orgid  := 0;
				SELF.InputEcho.seleid := 0;
				SELF.InputEcho.proxid := 0;
				SELF.InputEcho.powid  := 0;				
				SELF.Bus2Exec         := [];
				SELF.ResidentialBus   := [];
				SELF.BusinessByPhone  := [];
				SELF.PhonesByAddress  := [];
				SELF.BusinessByFEIN   := [];
				SELF.OFAC             := [];
				SELF.Watchlists       := [];
				SELF.Firmographic     := [];
				SELF.PersonRole       := [];
				SELF.Parent           := [];
				SELF.SBFEVerification := [];
				SELF := le; // Keep everything else.
				SELF := [];
			END;
		
		ds_NoHitsSuppressed := PROJECT( ds_NoHits, xfm_SuppressNoHits(LEFT) );
		
		ds_All := ds_Hits + ds_NoHitsSuppressed;
		
		RETURN ds_All;

	END;