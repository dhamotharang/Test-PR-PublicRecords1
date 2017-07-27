dGWLEntityV2	:=	GlobalWatchLists.File_GlobalWatchLists_V4.Base.Entity;

Layout_ID	:=	GlobalWatchLists.Layout_GlobalWatchLists_V4.LayoutIDIndex	or	GlobalWatchLists.Layout_GlobalWatchLists_V4.LayoutID;

Layout_ID	tNormID(dGWLEntityV2	pInput,integer	cnt)	:=
transform
	self	:=	pInput.Ids[cnt];
	self	:=	pInput;
end;

dIDNorm	:=	normalize(	dGWLEntityV2,
												left.IDCount,
												tNormID(left,counter)
											);

dIDNormSort	:=	sort(dIDNorm,EntityID,RecordID)	:	persist('~thor_200::persist::globalwatchlists::norm_idlist');					
	
export	Normalize_IdentificationList	:=	dIDNormSort;