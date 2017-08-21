import	ut;

dOrigFile	:=	globalwatchlists.OrigFile;

rCommentsSlim_Layout	:=
record,maxlength(40960)
	string20	recordid;
	string60	watchlistname;
	string		comments;
end;

rCommentsSlim_Layout	tReplaceLineFeeds(dOrigFile	pInput)	:=
transform
	self.comments	:=	regexreplace('\\n|\\r\\n',pInput.comments,'|',nocase);
	self					:=	pInput;
end;

dComments	:=	project(dOrigFile,tReplaceLineFeeds(left));

pattern	SingleComment	:=	pattern('[^|]+');

rParseComments_Layout	:=
record,maxlength(40960)
	dComments;
	string	CompleteComment	:=	GlobalWatchLists.Functions.strClean(matchtext(SingleComment));
end;

dCommentsParsed	:=	parse(dComments,comments,SingleComment,rParseComments_Layout,scan,first);

rCommentsSlim_Layout	tComments(dCommentsParsed	pInput)	:=
transform
	self.comments	:=	if(	GlobalWatchLists.Functions.strClean2Upper(pInput.CompleteComment)	in	GlobalWatchLists.constants.InvalidVals,
												SKIP,
												GlobalWatchLists.Functions.strClean(pInput.CompleteComment)
											);
	self					:=	pInput;
end;

dCommentsReformat	:=	project(dCommentsParsed,tComments(left));

export	Normalize_Comments	:=	sort(dCommentsReformat,recordid,watchlistname): persist('~thor_200::persist::globalwatchlists::comments');