import	doxie;

dIDNorm	:=	GlobalWatchLists.Normalize_IdentificationList;

GlobalWatchLists.Layout_GlobalWatchLists_V4.LayoutIDIndex	tCleanIDNumber(dIDNorm	pInput)	:=
transform
	self.IDNumber	:=	regexreplace(u'[^[:alnum:]]',pInput.IDNumber,u''); // for unicode put u before both quotes
	self					:=	pInput;
end;

dCleanID	:=	project(dIDNorm,tCleanIDNumber(left));

export	key_GlobalWatchLists_IDIndex_V4	:=	INDEX(	dCleanID,
																										{IDNumber,IDType,ListID},
																										{dCleanID},
																										GlobalWatchLists.constants.Cluster	+	'key::globalwatchlists::'	+	doxie.Version_SuperKey	+	'::id_index'
																									);