import	doxie;

dNormAddress	:=	Globalwatchlists.Normalize_AddressList;

dAddress	:=	project(dNormAddress,GlobalWatchLists.Layout_GlobalWatchLists_V4.LayoutAddress);

export	key_GlobalWatchLists_Addresses_V4	:=	INDEX(	dAddress,
																											{EntityID,RecordID},
																											{dAddress},
																											GlobalWatchLists.constants.Cluster	+	'key::globalwatchlists::'	+	doxie.Version_SuperKey	+	'::address'
																										);
