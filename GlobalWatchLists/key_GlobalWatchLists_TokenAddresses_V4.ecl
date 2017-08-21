import doxie, ut, globalwatchlists;

tokens := GlobalWatchLists.Build_TokenFile_Address_V4;

LayoutTokenKey_flat := record
	unicode24 tkn;
	unsigned6 key;
end;

LayoutTokenKey := GlobalWatchLists.Layout_GlobalWatchLists_V4.LayoutTokenKey;
LayoutTokens := GlobalWatchLists.Layout_GlobalWatchLists_V4.LayoutTokens;
LayoutAddress	:=	GlobalWatchLists.Layout_GlobalWatchLists_V4.LayoutAddressIndex	or	GlobalWatchLists.Layout_GlobalWatchLists_V4.LayoutAddress;

LayoutTokenKey_flat flatten(LayoutTokens le, LayoutTokenKey ri) := TRANSFORM
	self.tkn := le.tkn;
	self.key := ri.key;
END;
recs_n := NORMALIZE(tokens, left.keys, flatten(left, right));

dNamesNorm	:=	globalwatchlists.Normalize_AddressList;

dNames	:=	project(dNamesNorm,LayoutAddress);

layout_index := RECORD
	unicode24 tkn;
	LayoutAddress - key;
END;

layout_index getRecs(recs_n l, dNames r) := TRANSFORM
	self.tkn := l.tkn;
	self := r;
END;

tokensWithNames := join(recs_n, dNames, left.key = right.key,
												getRecs(LEFT, RIGHT));
												
export	key_GlobalWatchLists_TokenAddresses_V4	:=	INDEX(tokensWithNames,
																									{tkn, ListID},
																									{tokensWithNames},
																								 GlobalWatchLists.constants.Cluster	+	'key::globalwatchlists::'	+	doxie.Version_SuperKey	+	'::token_addresses'); 
