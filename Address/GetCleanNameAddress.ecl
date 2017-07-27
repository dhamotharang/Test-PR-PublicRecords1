import	iesp;

export	GetCleanNameAddress	:=
module
	// Clean name
	export	CleanPersonName(string	pName,boolean	pIsParsed)	:=
	function
		vCleanName	:=	if(	pIsParsed,
												Address.CleanPersonFML73(pName),
												Address.CleanPerson73(pName)
											);
		
		return	Address.CleanNameFields(vCleanName).CleanNameRecord;
	end;
	
	// Function to clean name
	export	fnCleanName(iesp.share.t_Name	pName)	:=
	function
		boolean	vIsNameParsed	:=	pName.Full	=	'';
		string	vName					:=	Address.NameFromComponents(	pName.First,
																													pName.Middle,
																													pName.Last,
																													pName.Suffix
																												);
		string	vFullName			:=	if(vIsNameParsed,vName,pName.Full);
		
		return	CleanPersonName(vFullName,vIsNameParsed);
	end;
	
	// Function to clean address
	export	fnCleanAddress(iesp.share.t_Address	pAddr)	:=
	function
		string	vStreetAddress			:=	Address.Addr1FromComponents(	pAddr.StreetNumber,
																																	pAddr.StreetPreDirection,
																																	pAddr.StreetName,
																																	pAddr.StreetSuffix,
																																	pAddr.StreetPostDirection,
																																	pAddr.UnitDesignation,
																																	pAddr.UnitNumber
																																);
		string	vStreetAddressl			:=	if(pAddr.StreetAddress1	=	'',vStreetAddress,pAddr.StreetAddress1);
		string	vStreetAddressFull	:=	stringlib.stringcleanspaces(vStreetAddressl	+	' '	+	pAddr.StreetAddress2);
		string	vCityStateZip				:=	if(	pAddr.StatecityZip	!=	'',
																				pAddr.StateCityZip,
																				Address.Addr2FromComponents(pAddr.city,pAddr.state,pAddr.zip5)
																			);
		
		return	Address.CleanAddressParsed(	vStreetAddressFull,
																				vCityStateZip
																			).addressrecord;
	end;
	
end;