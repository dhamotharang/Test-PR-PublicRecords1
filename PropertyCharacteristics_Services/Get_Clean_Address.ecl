import	Address,iesp;

export Get_Clean_Address(iesp.property_info.t_PropertyInformationRequest.ReportBy.AddressInfo pAddr)	:= function
	// Clean address as we need to pass it to the gateway
		string	vStreetAddress			:=	Address.Addr1FromComponents(	pAddr.StreetNumber,
																																	pAddr.StreetPreDirection,
																																	pAddr.StreetName,
																																	pAddr.StreetSuffix,
																																	pAddr.StreetPostDirection,
																																	pAddr.UnitDesignation,
																																	pAddr.UnitNumber
																																);
		string	vStreetAddressl			:=	if(pAddr.StreetAddress1	=	'',vStreetAddress,pAddr.StreetAddress1);
    string	vStreetAddressFull	:=	stringlib.stringcleanspaces(vStreetAddressl)	+	' '	+	stringlib.stringcleanspaces(pAddr.StreetAddress2);
    string	vCityStateZip				:=	if(	pAddr.StatecityZip	!=	'',
																				pAddr.StateCityZip,
																				Address.Addr2FromComponents(pAddr.city,pAddr.state,pAddr.zip5)
																			);
		
		return	Address.GetCleanAddress(	vStreetAddressFull,
																			vCityStateZip,
																			address.Components.Country.US
																		).results;
end;