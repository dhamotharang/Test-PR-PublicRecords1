import ut;
export fn_process_multitokens(dataset(layout_classify_token) tokens) := FUNCTION
  SingleTokens := tokens(ut.NoWords(TokenValue) <= 1); // < allows nulls through - which is useless but technically correct
	MultiTokens := tokens(ut.NoWords(TokenValue)>1);
	Layout_Classify_Token MakeST(Tokens le,UNSIGNED This,UNSIGNED Tot) := TRANSFORM
	  SELF.Pos := This;
		SELF.TokenCount := Tot;
		SELF.TokenValue := ut.Word(le.TokenValue,This);
	  SELF := le;
	END;
	AsSingles := NORMALIZE(MultiTokens,ut.NoWords(LEFT.TokenValue),MakeST(LEFT,COUNTER,ut.NoWords(LEFT.TokenValue)));
	Layout_Classify_Token Combine(AsSingles le,AsSingles ri) := TRANSFORM
	  SELF.Spc := MAP( le.Spc = ri.Spc AND le.Spc>1 => le.Spc-1, le.Spc < ri.Spc => le.Spc, ri.spc ); // More - does not handle LOTS of similar spc values (well)
	  SELF := le;
	END;
	CombinedSingles := ROLLUP( SORT( AsSingles, TokenValue, TokenType, Pos, TokenCount ), LEFT.TokenValue = RIGHT.TokenValue and LEFT.TokenType = RIGHT.TokenType AND LEFT.Pos = RIGHT.Pos and LEFT.TokenCount = RIGHT.TokenCount,Combine(LEFT,RIGHT));
  RETURN SingleTokens + CombinedSingles;	
  END;
