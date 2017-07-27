import	doxie;

dPhonesNorm	:=	GlobalWatchLists.Normalize_PhoneList;

export	key_GlobalWatchLists_PhoneNumbers_V4	:=	INDEX(	dPhonesNorm,
																													{EntityID},
																													{dPhonesNorm},
																													GlobalWatchLists.constants.Cluster	+	'key::globalwatchlists::'	+	doxie.Version_SuperKey	+	'::phonenumbers'
																												);
