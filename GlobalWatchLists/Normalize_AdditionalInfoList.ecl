dGWLEntityV2	:=	GlobalWatchLists.File_GlobalWatchLists_V4.Base.Entity;

GlobalWatchLists.Layout_GlobalWatchLists_V4.LayoutAdditionalInfo	tNormalizeAddlInfo(dGWLEntityV2	pInput,integer	cnt)	:=
transform
	self.EntityID	:=	pInput.EntityID;
	self					:=	pInput.AddlInfo[cnt];
end;

dAddlInfoNormalize	:=	normalize(	dGWLEntityV2,
																		left.InfoCount,
																		tNormalizeAddlInfo(left,counter)
																	);

dAddlInfoNormalizeSort	:=	sort(dAddlInfoNormalize,EntityID,RecordID)	:	persist('~thor_200::persist::globalwatchlists::norm_addlinfolist');					
	
export	Normalize_AdditionalInfoList	:=	dAddlInfoNormalizeSort;