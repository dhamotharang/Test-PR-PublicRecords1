Import Royalty, Risk_Indicators;

EXPORT RoyaltyFDNDLDATA := MODULE

	EXPORT GetBatchRoyaltiesByAcctno(dInF, unique_field = 'acctno', royalty_type_field='insurance_dl_used',
																	 royalty_type_value = true, fOrigAcctno='acctno') := FUNCTIONMACRO
		Royalty.Layouts.RoyaltyForBatch tPrepForRoyalty(RECORDOF(dInF) l) := TRANSFORM
			SELF.acctno							:= l.fOrigAcctno;
			SELF.royalty_type_code	:= Royalty.Constants.RoyaltyCode.FDN_DL_DATA;
			SELF.royalty_type 			:= Royalty.Constants.RoyaltyType.FDN_DL_DATA;
			SELF.royalty_count 			:= 1;
			SELF.non_royalty_count 	:= 0;
		END;
		
		deduped_in := dedup(sort(dInF, unique_field, -royalty_type_field), unique_field);
		
		royalties_to_count := deduped_in(royalty_type_field=royalty_type_value);
		dRoyaltiesByAcctno := project(royalties_to_count, tPrepForRoyalty(LEFT));
		RETURN dRoyaltiesByAcctno;
	ENDMACRO;

	EXPORT GetWebRoyalties(recs, unique_field = 'did', royalty_type_field = 'insurance_dl_used', royalty_type_value = true) := functionMacro
		
		deduped_recs := dedup(sort(recs, unique_field, -royalty_type_field), unique_field);
		
		Royalties := project( Risk_Indicators.iid_constants.ds_Record,
													transform(Royalty.Layouts.Royalty,
																		Self.royalty_type_code := Royalty.Constants.RoyaltyCode.FDN_DL_DATA,
																		Self.royalty_type := Royalty.Constants.RoyaltyType.FDN_DL_DATA,
																		Self.royalty_count := count(deduped_recs(royalty_type_field = royalty_type_value)),
																		Self.non_royalty_count := 0));
		Return Royalties;
	EndMacro;
		
END;