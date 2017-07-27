EXPORT RoyaltyInview := module

	EXPORT GetOnlineRoyalties(/*dataset(iesp.gateway_inviewreport.t_InviewReportResponse))*/dRecsOut, Include_BCRC, Include_BFRL, Include_BCIR ) := 
	FUNCTIONMACRO
			
		royaltyCode	:= Royalty.Functions.GetInviewRoyaltyCode(Include_BCRC, Include_BFRL, Include_BCIR);
		royaltyType := Royalty.Functions.GetInviewRoyaltyType(Include_BCRC, Include_BFRL, Include_BCIR);
		// <ProductCode name="COMM" code="0001">Commercial - Hit</ProductCode>
		hits := normalize(dRecsOut, left.ProductCodes, transform(right))(stringlib.stringtouppercase(name)='COMM', (integer)code=1);
		
		dRoyalOut := DATASET([{
											royaltyCode,
											royaltyType, 
											count(hits),
											0
										}], Royalty.Layouts.Royalty);
									
		
		return dRoyalOut;
												
	ENDMACRO;
	
end;