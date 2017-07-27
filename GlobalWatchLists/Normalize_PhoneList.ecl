dGWLEntityV2	:=	GlobalWatchLists.File_GlobalWatchLists_V4.Base.Entity;

Layout_Phone	:=	GlobalWatchLists.Layout_GlobalWatchLists_V4.LayoutPhoneIndex	or	GlobalWatchLists.Layout_GlobalWatchLists_V4.LayoutPhone;

Layout_Phone	tNormPhone(dGWLEntityV2	pInput,integer	cnt)	:=
transform
	self	:=	pInput.Phones[cnt];
	self	:=	pInput;
end;

dPhoneNorm	:=	normalize(	dGWLEntityV2,
														left.PhoneCount,
														tNormPhone(left,counter)
													);

dPhoneNormSort	:=	sort(dPhoneNorm,EntityID,RecordID)	:	persist('~thor_200::persist::globalwatchlists::norm_phonelist');					

export	Normalize_PhoneList	:=	dPhoneNormSort;