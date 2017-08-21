EXPORT ProcessInnovativeSystems := FUNCTION

	InnovativeSystems := ProcessInnovativeSystemsPEP + ProcessInnovativeSystemsOSC + ProcessInnovativeSystemsOCC
										 + ProcessInnovativeSystemsCFT + ProcessInnovativeSystemsFBI + ProcessInnovativeSystemsUNS;
	
	rOutLayout RemoveCleanedAddressesWithBadErrorCodes(rOutLayout L) := TRANSFORM
		self.addr_clean := if(L.addr_clean[179..180] <> 'E5'
													and L.addr_clean[179..182] <> 'E213'
													and L.addr_clean[179..182] <> 'E101'
												,L.addr_clean
												,'');
		self := L;
	END;
	
	return PROJECT(InnovativeSystems, RemoveCleanedAddressesWithBadErrorCodes(LEFT));

END;