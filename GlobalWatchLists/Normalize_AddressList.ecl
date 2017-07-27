dGWLEntityV2	:=	GlobalWatchLists.File_GlobalWatchLists_V4.Base.Entity;

Layout_NormAddress	:=	GlobalWatchLists.Layout_GlobalWatchLists_V4.LayoutAddressIndex	or	GlobalWatchLists.Layout_GlobalWatchLists_V4.LayoutAddress;

Layout_NormAddress	tNormAddress(dGWLEntityV2	pInput,integer	cnt)	:=
transform
	self.Key	:=	0;
	self			:=	pInput.Addresses[cnt];
	self			:=	pInput;
end;

dNormAddress	:=	normalize(	dGWLEntityV2,
															left.AddressCount,
															tNormAddress(left,counter)
														);

dNormAddressSort	:=	sort(dNormAddress,EntityID,RecordID);

Layout_NormAddress	tAddKey(dNormAddressSort	pInput,integer	cnt)	:=
transform
	self.key	:=	cnt;
	self			:=	pInput;
end;

dNormAddrKey	:=	project(dNormAddressSort,tAddKey(left,counter)) : persist('~thor_200::persist::globalwatchlists::norm_addrList');					

export Normalize_AddressList	:=	dNormAddrKey;