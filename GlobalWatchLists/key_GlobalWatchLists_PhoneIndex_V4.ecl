import	doxie;

dPhonesNorm	:=	GlobalWatchLists.Normalize_PhoneList;

GlobalWatchLists.Layout_GlobalWatchLists_V4.LayoutPhoneIndex	tCleanPhoneNumber(dPhonesNorm	pInput) :=
transform
	self.PhoneNumber	:=	regexreplace(u'[^[:alnum:]]',pInput.PhoneNumber ,u''); // for unicode put u before both quotes
	self							:=	pInput;
end;

dCleanPhoneNumber	:=	project(dPhonesNorm,tCleanPhoneNumber(left));

export	key_GlobalWatchLists_PhoneIndex_V4	:=	INDEX(	dCleanPhoneNumber,
																												{PhoneNumber,ListID},
																												{dCleanPhoneNumber},
																												GlobalWatchLists.constants.Cluster	+	'key::globalwatchlists::'	+	doxie.Version_SuperKey	+	'::phone_index'
																											);
