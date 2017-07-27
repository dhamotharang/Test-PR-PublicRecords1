
// replacement for doxie_ln.royalties.

EXPORT RoyaltyFares := module

	export MAC_SetA(prop_recs, foreclosure_recs, royal_out, fares_id='ln_fares_id') := macro

		royal_out0 :=
			dataset([{
								Royalty.Constants.RoyaltyCode.FARES,
								Royalty.Constants.RoyaltyType.FARES,
								count(prop_recs(fares_id[1]='R'))+count(foreclosure_recs),
								count(prop_recs(fares_id[1]<>'R'))
							}],Royalty.Layouts.Royalty);	

		royal_out := royal_out0(royalty_count>0 or non_royalty_count>0);

	endmacro;

	export MAC_SetB(prop_recs, royal_out, fares_id='ln_fares_id') := macro

		royal_out0 :=
			dataset([{
								Royalty.Constants.RoyaltyCode.FARES,
								Royalty.Constants.RoyaltyType.FARES,
								count(prop_recs(fares_id[1]='R')),
								count(prop_recs(fares_id[1]<>'R'))
							}],Royalty.Layouts.Royalty);	

		royal_out := royal_out0(royalty_count>0 or non_royalty_count>0);		
		
	endmacro;
	
	export MAC_SetC(royal_recs, non_royal_recs, royal_out) := macro

			royal_out0 :=
			dataset([{
								Royalty.Constants.RoyaltyCode.FARES,
								Royalty.Constants.RoyaltyType.FARES,
								count(royal_recs),
								count(non_royal_recs)
							}],Royalty.Layouts.Royalty);	
							
			royal_out := royal_out0(royalty_count>0 or non_royalty_count>0);				

	endmacro;

	export MAC_SetD(royal_recs, royal_out) := macro

			royal_out0 :=
			dataset([{
								Royalty.Constants.RoyaltyCode.FARES,
								Royalty.Constants.RoyaltyType.FARES,
								count(royal_recs),
								0
							}],Royalty.Layouts.Royalty);	

			royal_out := royal_out0(royalty_count>0 or non_royalty_count>0);				

	endmacro;

	export GetBatchRoyaltySet(dRecsOut, pSrcField='vendor_source_flag', pReturnDetails = 'false') := functionmacro
		
		dRoyaltiesByAcctno := 
			project(dRecsOut, 
							transform(Royalty.Layouts.RoyaltyForBatch,
								self.acctno 						:= left.acctno;										
								self.royalty_type_code	:= Royalty.Constants.RoyaltyCode.FARES;
								self.royalty_type 			:= Royalty.Constants.RoyaltyType.FARES;
								self.royalty_count 			:= if(left.pSrcField='A', 1, skip);
								self.non_royalty_count 	:= 0;
							));		 
		
		dRoyalties := Royalty.GetBatchRoyalties(dRoyaltiesByAcctno, pReturnDetails);	
		return dRoyalties;
		
	endmacro;
	
		
end;
