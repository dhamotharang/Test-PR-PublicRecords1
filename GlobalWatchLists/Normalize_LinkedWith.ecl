dComments	:=	globalwatchlists.Normalize_Comments(StringLib.StringFind(GlobalWatchLists.Functions.strClean2Upper(comments),'LINKED WITH:',1)	<>	0);

rLinkedWith_Layout	:=
record
	string20	recordid;
	string60	watchlistname;
	string		linkedWith;
end;

rLinkedWith_Layout tLinkedWith(dComments	pInput)	:=
transform
	self.linkedWith	:=	GlobalWatchLists.Functions.strClean(regexreplace('LINKED WITH:',GlobalWatchLists.Functions.strClean(pInput.comments),'',nocase));
	self						:=	pInput;
end;

dLinkedWith	:=	project(dComments,tLinkedWith(left));

pattern	SinglelinkedWith	:=	pattern('[^,]+');

rLinkedWithParsed_Layout	:=
record 
	dLinkedWith;
	string	CompletelinkedWith	:=	GlobalWatchLists.Functions.strClean(matchtext(SinglelinkedWith));
end;

dLinkedWithParsed	:=	parse(dLinkedWith,linkedWith,SinglelinkedWith,rLinkedWithParsed_Layout,scan,first);

rLinkedWith_Layout	tLinkedWithReformat(dLinkedWithParsed	pInput)	:=
transform
	self.linkedWith	:=	if(	GlobalWatchLists.Functions.strClean2Upper(pInput.CompletelinkedWith)	in	GlobalWatchLists.constants.InvalidVals,
													SKIP,
													GlobalWatchLists.Functions.strClean(pInput.CompletelinkedWith)
												);
	self						:=	pInput;
end;

dLinkedWithReformat	:=	project(dLinkedWithParsed,tLinkedWithReformat(left));

dLinkedWithSort	:=	sort(dLinkedWithReformat,recordid,watchlistname)	:	persist('~thor_200::persist::globalwatchlists::linkedWith');

export	Normalize_LinkedWith	:=	dLinkedWithSort;