
EXPORT  fn_GetBusinessRecordVerification( BusinessInstantID20_Services.layouts.OutputLayout_intermediate le ) := 
	FUNCTION
	
		nothingVerified := [ 0, 0, 0, 0 ];

		_bvi          := le.VerificationSummaries.bvi;
		_bvi_desc_key := le.VerificationSummaries.bvi_desc_key;
		
		verificationBasedOnBVIDescKey :=
			CASE( (INTEGER)_bvi_desc_key,
				0   => nothingVerified,
				101 => nothingVerified,
				102 => nothingVerified,
				121 => [ 0, 0, 1, 0 ],
				122 => [ 0, 1, 0, 0 ],
				123 => [ 1, 0, 0, 0 ],
				124 => [ 0, 0, 0, 1 ],
				201 => [ 0, 0, 1, 0 ],
				202 => [ 0, 1, 0, 0 ],
				203 => [ 1, 0, 0, 0 ],
				204 => [ 0, 0, 0, 1 ],
				221 => [ 1, 0, 0, 0 ],
				222 => [ 0, 1, 1, 0 ],
				223 => [ 0, 0, 1, 1 ],
				311 => nothingVerified,
				312 => [ 0, 1, 1, 0 ],
				313 => [ 0, 0, 1, 1 ],
				321 => [ 1, 0, 1, 0 ],
				322 => [ 0, 1, 0, 1 ],
				323 => [ 0, 1, 1, 1 ],
				324 => [ 1, 0, 0, 1 ],
				325 => [ 1, 0, 1, 1 ],
				401 => [ 1, 0, 1, 0 ],
				402 => [ 0, 1, 0, 1 ],
				403 => [ 0, 1, 1, 1 ],
				404 => [ 1, 0, 0, 1 ],
				405 => [ 1, 0, 1, 1 ],
				411 => nothingVerified,
				412 => nothingVerified,
				413 => [ 0, 1, 1, 0 ],
				414 => [ 0, 0, 1, 1 ],
				415 => [ 1, 0, 1, 0 ],
				416 => [ 0, 1, 0, 1 ],
				417 => [ 0, 1, 1, 1 ],
				418 => [ 1, 0, 0, 1 ],
				419 => [ 1, 0, 1, 1 ],
				421 => [ 1, 1, 0, 0 ],
				521 => [ 1, 1, 0, 0 ],
				522 => [ 1, 1, 1, 0 ],
				523 => [ 1, 1, 0, 1 ],
				524 => [ 1, 1, 1, 1 ],
				nothingVerified
			);

		BusinessRecordVerification := IF( _bvi = '0', nothingVerified, verificationBasedOnBVIDescKey );
		
		RETURN BusinessRecordVerification;
	END;