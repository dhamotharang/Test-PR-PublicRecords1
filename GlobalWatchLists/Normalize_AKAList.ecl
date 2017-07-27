dGWLEntityV2	:=	GlobalWatchLists.File_GlobalWatchLists_V4.Base.Entity;

// add primary name to aka/name list
GlobalWatchLists.Layouts.Base.rEntity_Layout	tAddPrimaryName(dGWLEntityV2	pInput)	:=
transform
	self.AkaNames	:=	dataset(	[{1,u'PRIMARY',u'',u'',pInput.FirstName,pInput.MiddleName,pInput.LastName,pInput.Generation,pInput.FullName,u''}],
															GlobalWatchLists.Layouts.Base.rAkaName_Layout
														)
										+	project(pInput.AkaNames,transform(GlobalWatchLists.Layouts.Base.rAkaName_layout,self.RecordID	:=	left.RecordID+1;self	:=	left));
	self					:=	pInput;
end;

dGWLAddPrimaryName	:=	project(dGWLEntityV2,tAddPrimaryName(left));

// Normalize AKAs
Layout_Name	:=	GlobalWatchLists.Layout_GlobalWatchLists_V4.LayoutNameIndex	or	GlobalWatchLists.Layout_GlobalWatchLists_V4.LayoutName;

Layout_Name	tNormAkas(dGWLAddPrimaryName	pInput,integer	cnt)	:=
transform
	self.Key				:=	0;
	self						:=	pInput.AkaNames[cnt];
	self						:=	pInput;
end;

dAkaNorm	:=	normalize(	dGWLAddPrimaryName,
													left.NameCount	+	1,
													tNormAkas(left,counter)
												);

dAkaNormSort	:=	sort(dAkaNorm,EntityID,RecordID);

Layout_Name	tAddKey(dAkaNorm	pInput,integer	cnt)	:=
transform
	self.key	:=	cnt;
	self			:=	pInput;
end;

dAkaNormKey	:=	project(dAkaNormSort,tAddKey(left,counter))	:	persist('~thor_200::persist::globalwatchlists::norm_akaList');

export	Normalize_AKAList	:=	dAkaNormKey;