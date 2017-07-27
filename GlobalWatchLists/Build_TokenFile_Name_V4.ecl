import	ut;

export	Build_TokenFile_Name_V4(string	pFileDate)	:=
function

	dNames := GlobalWatchLists.Normalize_AKAList;

	LayoutPrep_V4	:=	GlobalWatchLists.Layout_GlobalWatchLists_V4.LayoutNameTokenPrep;
	
	LayoutPrep_V4	tPrepTokens(dNames	l)	:=
	transform
		self.FullName		:=	l.FullName;
		self.EntityType	:=	l.EntityType;
		self.Key				:=	l.Key;
	end;
	
	dPrep	:=	project(dNames,tPrepTokens(left));
	
	dNameTokens	:=	globalwatchlists.fn_NameTokens_V4(dPrep);
	
	ut.MAC_SF_BuildProcess(dNameTokens,'~thor_200::base::globalwatchlistsV2::name_tokens',bldNameTokens,,,true,pFileDate);
	
	return	bldNameTokens;
end;
