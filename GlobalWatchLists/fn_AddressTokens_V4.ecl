import ut; 

export fn_AddressTokens_V4(DATASET(GlobalWatchLists.Layout_GlobalWatchLists_V4.LayoutAddressTokenPrep) inData, 
															 boolean isSearchData = false) := function
															 
rPrepTokens := record GlobalWatchLists.Layout_GlobalWatchLists_V4.LayoutAddressTokenPrep; dataset(TextSearchDataRecord) tokens; end;
rPrepTokens getWordTokens(inData l) := transform
	self.tokens := EntityScoreLib.TextSearchData(trim(l.FullAddress), 3);
	self := l;
end;  
word_tokens := project(inData, getWordTokens(left));

LayoutTokenQuality := record	unicode tkn; unsigned1 tknQuality; end;
LayoutNormTokens := record unsigned6 key; dataset(LayoutTokenQuality) tokens; end;
LayoutNormTokens norm_tokens(word_tokens l, INTEGER c) :=
TRANSFORM
	tkn := l.tokens[c].indexword;
	len := length(tkn);
	isCommon := EntityScoreLib.IsAddressCommonWord(tkn) or EntityScoreLib.IsDirectionCommonWord(tkn);
	tknQuality := map(len>=3 and ~isCommon => 1,
									 len=2 and ~isCommon => 2,
									 len=1 => 3, 
									 4); // common word
	
	self.key := l.Key;
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
	NumTokensToKeep := (integer)(count(l.tokens)/2) + 1;
	MinTokens := if(count(l.tokens) <= 3, 1, 2);
	Keepers := map(count(l.tokens(tknQuality<=1)) >= NumTokensToKeep => l.tokens(tknQuality<=1),
								 count(l.tokens(tknQuality<=2)) >= NumTokensToKeep => l.tokens(tknQuality<=2),
								 count(l.tokens(tknQuality<=3)) >= MinTokens => l.tokens(tknQuality<=3),
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
