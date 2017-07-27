import doxie;
EXPORT RoyaltyVehicles := module

	export RTV_RoyaltyType 		:= if(doxie.DataPermission.use_Polk, Royalty.Constants.RoyaltyType.POLK, Royalty.Constants.RoyaltyType.EXPERIAN);
	export RTV_RoyaltyCode 		:= if(doxie.DataPermission.use_Polk, Royalty.Constants.RoyaltyCode.POLK, Royalty.Constants.RoyaltyCode.EXPERIAN);
	export RTV_RoyaltySrc 		:= if(doxie.DataPermission.use_Polk, Royalty.Constants.RoyaltySrc.POLK, Royalty.Constants.RoyaltySrc.EXPERIAN);
	
	export MAC_ReportSet(recs, royal_out, srcf, vinf) := macro
		royal_out := dataset([{
									Royalty.RoyaltyVehicles.RTV_RoyaltyCode, 
									Royalty.RoyaltyVehicles.RTV_RoyaltyType, 
									count(recs(srcf='RealTime', vinf<>'', vinf<>'RESTRICTED')), 
									0}], Royalty.Layouts.Royalty);	
	endmacro;

	export MAC_GetRoyalties (recs) := functionmacro
		return dataset([{Royalty.RoyaltyVehicles.RTV_RoyaltyCode, Royalty.RoyaltyVehicles.RTV_RoyaltyType, count(recs), 0}], Royalty.Layouts.Royalty);	
	endmacro;

	export MAC_SearchSet(recs, royal_out, srcf) := macro
		royal_out := dataset([{Royalty.RoyaltyVehicles.RTV_RoyaltyCode, Royalty.RoyaltyVehicles.RTV_RoyaltyType, count(recs(srcf='RealTime')), 0}], Royalty.Layouts.Royalty);	
	endmacro;
	
	//////////////// FOR BATCH ////////////////////////

	export MAC_BatchSet(recs, royal_out, royalty_src='royalty_src', pReturnDetails = 'false') := macro

		dRoyaltiesByAcctno := 
			project(recs, 
							transform(Royalty.Layouts.RoyaltyForBatch,
								self.acctno 						:= left.acctno;										
								self.royalty_type_code	:= Royalty.RoyaltyVehicles.RTV_RoyaltyCode;
								self.royalty_type 			:= Royalty.RoyaltyVehicles.RTV_RoyaltyType;
								self.royalty_count 			:= if(left.royalty_src<>'', 1, 0); 
								self.non_royalty_count 	:= 0;
							));		 
		
		royal_out := Royalty.GetBatchRoyalties(dRoyaltiesByAcctno, pReturnDetails);						
				
	endmacro;

	export MAC_Append(recs, recs_with_royalties, srcf1, srcf2='acctno', check_srcf2='false') := macro
		
		#uniquename(rec_with_royal_layout)
		%rec_with_royal_layout% := record(recordof (recs))
			Royalty.Layouts.RoyaltySrc.royalty_src;
		end;
		
		recs_with_royalties := project(recs, 
									transform(%rec_with_royal_layout%,										
										self.royalty_src := if(left.srcf1<>'' and left.srcf1<>'RESTRICTED' and (~check_srcf2 or left.srcf2='RT'), 
																					 Royalty.RoyaltyVehicles.RTV_RoyaltySrc, 
																					 ''),
										self := left));
	endmacro;
	
end;