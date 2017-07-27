import	ut;

export	Build_TokenFile_Address_V4(string	pFileDate)	:=
function
	dAddresses	:=	GlobalWatchLists.Normalize_AddressList;

	LayoutPrep_V4	:=	GlobalWatchLists.Layout_GlobalWatchLists_V4.LayoutAddressTokenPrep;
	
	LayoutPrep_V4	tPrepTokens(dAddresses	l)	:=
	transform
		self.FullAddress	:=	l.StreetAddress1	+	' '	+	l.StreetAddress2	+	' '	+	l.City	+	' '	+	l.Zip;
		self.Key					:=	l.Key;
	end;
	
	dPrep := project(dAddresses,tPrepTokens(left));
	
	dAddressTokens	:=	Globalwatchlists.fn_AddressTokens_V4(dPrep);
	
	ut.MAC_SF_BuildProcess(dAddressTokens,'~thor_200::base::globalwatchlistsV2::address_tokens',bldAddressTokens,,,true,pFileDate);
	
	return	bldAddressTokens;
end;
