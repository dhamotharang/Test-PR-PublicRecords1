EXPORT fn_split_parsed(DATASET(layout_parse_raw) p) := MODULE
	R := RECORD
	  p; // Raw parse record
		StrType tstring; // This string
		UNSIGNED4 cpos; // Position with parse type
		UNSIGNED4 max_cpos; // Total words in base
	END;
	R Split(P le,UNSIGNED4 C) := TRANSFORM
    SELF.tstring := GetNthWord(le.txt,C);
    SELF.cpos := C;
    SELF.max_cpos := WordCount(le.txt);
    SELF := le;
	END;
	SHARED AllW := NORMALIZE(p,WordCount(LEFT.txt),Split(LEFT,COUNTER));
	EXPORT Words := DEDUP(TABLE( Allw, { tstring } ), WHOLE RECORD, ALL );
	EXPORT R := RECORD
	  UNSIGNED8 __ParseNo;
		UNSIGNED4 Cpos;
		Layout_Classify_Token;
	END;
	EXPORT Combine(DATASET(layout_classify_token) ct) := FUNCTION
	// This both 'bulks up' the classify records (one for each place the token was found in the input stream
	// but also 'slims down' the stream (only finds those that 'fit' the spot
		J0 := JOIN(AllW,Ct,LEFT.tstring=RIGHT.TokenValue 
														AND LEFT.Cpos >= RIGHT.Pos // There must be enough tokens to the left
														AND LEFT.max_cpos-LEFT.cpos>=RIGHT.TokenCount-RIGHT.pos // and enough tokens to the right
														AND RIGHT.TokenType IN LEFT.PossF // and this is one of the fields we are expecting
														,TRANSFORM(R,SELF.__ParseNo:=LEFT.__ParseNo,SELF.Cpos := LEFT.Cpos, SELF := RIGHT));
	// Now we need to find those multi-token patterns that match (and filter out those that do not)
		J0_Pass := PROJECT(J0(TokenCount = 1),TRANSFORM(R,SELF.Verified := TRUE, SELF := LEFT));
		J0_Process := GROUP(J0(TokenCount>1),__ParseNo,TokenType,TokenCount,ALL);
		// The Cpos-Pos gives a 'proposed starting position'
		S1 := SORT(J0_Process,Cpos-Pos,Pos);
		R1 := ROLLUP(S1,LEFT.Cpos+WordCount(LEFT.TokenValue)=RIGHT.Cpos AND LEFT.pos+WordCount(LEFT.TokenValue)=RIGHT.pos,TRANSFORM(R,SELF.TokenValue := LEFT.TokenValue+' '+RIGHT.TokenValue,SELF.Spc:=MAX(LEFT.Spc,RIGHT.SPC),SELF := LEFT));
		R2 := GROUP(R1);
		RETURN J0_Pass + R2(WordCount(TokenValue)=TokenCount);
	END;
	EXPORT JoinBack(DATASET(R) J) := FUNCTION
	  Layout_Parse_Working note(AllW le,DATASET(R) ri) := TRANSFORM
		  SELF.Hyps := DATASET([{le.Cpos,PROJECT(ri,TRANSFORM(Layout_Classify_Token,SELF.FullMatch := le.txt=LEFT.tokenvalue,SELF := LEFT))}],layout_classify_working_hypothesis);
		  SELF := le;
		END;
		JR := DENORMALIZE(AllW,J,LEFT.__ParseNo=RIGHT.__ParseNo 
														AND LEFT.Cpos = RIGHT.CPos
														,GROUP,note(LEFT,ROWS(RIGHT)));
		S := SORT( JR, __ParseNo );
		RETURN ROLLUP(S,LEFT.__ParseNo=RIGHT.__ParseNo,TRANSFORM(Layout_Parse_Working,SELF.Hyps := LEFT.Hyps+RIGHT.Hyps,SELF := LEFT));
	END;
 END;
