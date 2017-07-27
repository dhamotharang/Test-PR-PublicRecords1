
IMPORT Gateway;

EXPORT RoyaltyNetAcuity := MODULE;

	EXPORT IPData := RECORD
		STRING30	AcctNo := '';			// only needed for batch queries.
		STRING45 	IPAddr := '';		
		STRING10 	IPType := '';		
		UNSIGNED2 Royalty_NAG := 0; // may also be used instead	of ipaddr/iptype.
	END;

	EXPORT GetOnlineRoyalties(dGateway, 								// Used to check if netacuity gateway is configured.
														dInf, 										// Used to check if we have an incoming ip address.
														dRecsOut, 								// Used to calculate royalties, based on either (ipaddr+iptype) or (royalty_nag) fields.
														checkCounterOnly = FALSE, // Will tell the macro to look at either (ipaddr+iptype) or (royalty_nag) when counting royalties.
														fIPAddr='IPAddr', 				// The default ipaddr field.
														fIPType='IPType',					// The default iptype field.
														fCounter='Royalty_NAG'		// The default royalty_nag field.
	) := FUNCTIONMACRO	

		import Gateway;

		// Only track it if we were supposed to hit the gateway, i.e. we have 
		// a valid gateway config and a valid ip addr.
		trackIt := dGateway(Gateway.Configuration.IsNetAcuity(servicename))[1].url<>'' and 
			exists(dInf(Royalty.RoyaltyNetAcuity.CheckIPAddr(fIPAddr)));

		dRoyalOut := 
			dataset([{
								Royalty.Constants.RoyaltyCode.NETACUITY,
								Royalty.Constants.RoyaltyType.NETACUITY,
								#IF(checkCounterOnly)
								SUM(dRecsOut, fCounter),
								#ELSE
								SUM(dRecsOut,Royalty.RoyaltyNetAcuity.GetCount(fIPAddr,fIPType)),
								#END
								0
							}],Royalty.Layouts.Royalty);			

		return if(trackIt, dRoyalOut);

	ENDMACRO;			
	
	EXPORT GetBatchRoyaltiesByAcctno(dGateway, 								// Used to check if netacuity gateway is configured.
																	 dInf, 										// Used to check if we have an incoming ip address.
																	 dRecsOut, 								// Used to calculate royalties, based on either (ipaddr+iptype) or (royalty_nag) fields.
																	 checkCounterOnly = FALSE,// Will tell the macro to look at either (ipaddr+iptype) or (royalty_nag) when counting royalties.
																	 fIPAddr='IPAddr', 				// The default ipaddr field.
																	 fIPType='IPType',				// The default iptype field.
																	 fCounter='Royalty_NAG'		// The default royalty_nag field.
	) := FUNCTIONMACRO																		

		import Gateway;

		// Only track it if we were supposed to hit the gateway, i.e. we have 
		// a valid gateway config and a valid ip addr.
		trackIt := dGateway(Gateway.Configuration.IsNetAcuity(servicename))[1].url<>'' and 
			exists(dInf(Royalty.RoyaltyNetAcuity.CheckIPAddr(fIPAddr)));

		Royalty.Layouts.RoyaltyForBatch tPrepForRoyalty(RECORDOF(dRecsOut) L) :=
		TRANSFORM
			SELF.acctno							:= l.acctno;
			SELF.royalty_type_code	:= Royalty.Constants.RoyaltyCode.NETACUITY;
			SELF.royalty_type 			:= Royalty.Constants.RoyaltyType.NETACUITY;
			#IF(checkCounterOnly)
			SELF.royalty_count 			:= L.fCounter;
			#ELSE
			SELF.royalty_count 			:= Royalty.RoyaltyNetAcuity.GetCount(L.fIPAddr, L.fIPType);
			#END
			SELF.non_royalty_count 	:= 0;
		END;

		dRoyaltiesByAcctno := PROJECT(dRecsOut, tPrepForRoyalty(LEFT));
		
		RETURN IF(trackIt, dRoyaltiesByAcctno);
		
	ENDMACRO;

	// Returns true if IPAddr appears to be valid.
	EXPORT BOOLEAN 	CheckIPAddr(string IPAddr) := TRIM(IPAddr)<>'' and stringlib.stringfilterout(TRIM(IPAddr[1]),'0123456789')='';
	// Returns 1 if IPAddr appears to be valid and iptype is not 'RESERVED'.
	EXPORT UNSIGNED GetCount(string IPAddr, string IPType) := IF(IPAddr<>'' and stringlib.stringToUpperCase(IPType)<>'RESERVED', 1, 0);	

END;	