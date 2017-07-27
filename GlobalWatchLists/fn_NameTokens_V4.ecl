import ut;

export fn_NameTokens_V4(DATASET(GlobalWatchLists.Layout_GlobalWatchLists_V4.LayoutNameTokenPrep) inData, 
															 boolean isSearchData = false) := function

rPrepTokens := record GlobalWatchLists.Layout_GlobalWatchLists_V4.LayoutNameTokenPrep; dataset(TextSearchDataRecord) tokens; end;
rPrepTokens getWordTokens(inData l) := transform
	self.tokens := EntityScoreLib.TextSearchData(trim(l.FullName), 3);
	self := l;
end;  
word_tokens := project(inData, getWordTokens(left));

LayoutTokenQuality := record	unicode tkn; unsigned1 tknQuality; end;
LayoutNormTokens := record unsigned6 key; string1 entitytype; dataset(LayoutTokenQuality) tokens; end;
LayoutNormTokens norm_tokens(word_tokens l, INTEGER c) :=
TRANSFORM
	tkn := l.tokens[c].indexword;
	len := length(tkn);
	isCommon := map(len = 1 => false, 
									l.EntityType = GlobalWatchLists.constants.EntityTypeIndividual => EntityScoreLib.IsIndividualCommonWord(tkn),
								  l.EntityType = GlobalWatchLists.constants.EntityTypeBusiness => EntityScoreLib.IsOrganizationCommonWord(tkn),	
								  EntityScoreLib.IsIndividualCommonWord(tkn) or EntityScoreLib.IsOrganizationCommonWord(tkn));
	tknQuality := map(len>=3 and ~isCommon => 1,
									 len=2 and ~isCommon => 2,
									 len=1 => 3, 
									 4); // common word
	
	self.key := l.Key;
	self.entitytype := l.entitytype;
	self.tokens := dataset([{tkn, tknQuality}], LayoutTokenQuality);
END;
normed_tokens := NORMALIZE(word_tokens, left.tokens, norm_tokens(LEFT, COUNTER));

LayoutNormTokens roll_tokens(normed_tokens l, normed_tokens r) := transform
	self.tokens := l.tokens + r.tokens;
	self := l;
end;
rolled_tokens := rollup(normed_tokens, left.key=right.key, roll_tokens(left,right));

LayoutToken := record	unicode24 tkn; end;
LayoutTokens := record unsigned6 key; dataset(LayoutToken) tokens; end;
LayoutTokens getTokens(rolled_tokens l) := transform
	// add a run together initials token (for things like I.B.M. add IBM)
	InitialCount := if(l.EntityType = GlobalWatchLists.constants.EntityTypeBusiness, count(l.tokens(length(tkn)=1)), 0);
	Initials3 := if(InitialCount >= 3 and length(l.tokens[1].tkn) = 1 and length(l.tokens[2].tkn) = 1 and length(l.tokens[3].tkn) = 1,
									l.tokens[1].tkn + l.tokens[2].tkn + l.tokens[3].tkn, '');
	Initials4 := if(InitialCount >= 4 and length(Initials3) = 3 and length(l.tokens[4].tkn) = 1, Initials3 + l.tokens[4].tkn, Initials3);													
	Initials5 := if(InitialCount >= 5 and length(Initials4) = 4 and length(l.tokens[5].tkn) = 1, Initials4 + l.tokens[5].tkn, Initials4);
	Initials6 := if(InitialCount >= 6 and length(Initials5) = 5 and length(l.tokens[6].tkn) = 1, Initials5 + l.tokens[6].tkn, Initials5);
	Initials7 := if(InitialCount >= 7 and length(Initials6) = 6 and length(l.tokens[7].tkn) = 1, Initials6 + l.tokens[7].tkn, Initials6);
	Initials8 := if(InitialCount >= 8 and length(Initials7) = 7 and length(l.tokens[8].tkn) = 1, Initials7 + l.tokens[8].tkn, Initials7);
	RunTogetherInitials := if(length(Initials8) >= 3, dataset([{Initials8, 1}], LayoutTokenQuality));

	tokens := l.tokens + RunTogetherInitials;
	//SortedTokens := dedup(sort(tokens, tkn), tkn); // cannot DEDUP or SORT or it will not run on THOR
	NumTokensToKeep := (integer)(count(tokens)/2) + 1;
	MinTokens := if(count(tokens) <= 3, 1, 2);
	Keepers := map(count(tokens(tknQuality<=1)) >= NumTokensToKeep => tokens(tknQuality<=1),
								 count(tokens(tknQuality<=2)) >= NumTokensToKeep => tokens(tknQuality<=2),
								 count(tokens(tknQuality<=3)) >= MinTokens => tokens(tknQuality<=3),
								 l.tokens);
	
	self.key := l.key;
	self.tokens := project(Keepers, transform(LayoutToken, self := left));
end;
dsTokens := project(rolled_tokens, getTokens(left));	

LayoutTokens_V4 := GlobalWatchLists.Layout_GlobalWatchLists_V4.LayoutTokens;
LayoutTokens_V4 norm(dsTokens L, integer C) := transform
	self.tkn := l.tokens[C].tkn;
	self.keys := project(L, transform({unsigned6 key}, self := left));
end;
normedTokens := sort(normalize(dsTokens, left.tokens, norm(left, counter)),tkn);

LayoutTokens_V4 roller(LayoutTokens_V4 L, LayoutTokens_V4 R) := transform
	self.keys := L.keys+R.keys;
	self := L;
end;
rolledTokens := rollup(normedTokens, left.tkn=right.tkn, roller(left,right));

return if(isSearchData, normedTokens, rolledTokens);
end;
