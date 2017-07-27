import	doxie;

dNormAddress	:=	Globalwatchlists.Normalize_AddressList;

dAddressIndex	:=	project(dNormAddress,GlobalWatchLists.Layout_GlobalWatchLists_V4.LayoutAddressIndex);

export	key_GlobalWatchLists_AddressIndex_V4	:=	INDEX(	dAddressIndex,
																													{Key,ListID},
																													{dAddressIndex},
																													GlobalWatchLists.constants.Cluster	+	'key::globalwatchlists::'	+	doxie.Version_SuperKey	+	'::address_index'
																												);
